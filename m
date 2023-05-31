Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94FF8717D0D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 12:18:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235878AbjEaKSO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 06:18:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235869AbjEaKSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 06:18:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D2A7189;
        Wed, 31 May 2023 03:17:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 01B8862F14;
        Wed, 31 May 2023 10:17:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5814DC433D2;
        Wed, 31 May 2023 10:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685528278;
        bh=vs1shr8Oz5T6vzLyfco2GglAWiji2BVDH39dzR8TnMU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i0C481BdTj94a+sJDkbJnVZXFJpcRPBz4x11sA9d0i3dm5oa6FyjBGPgjE4bePMDP
         U181pKEUpURPiFzXSFroP2wF3u8a4L/qt3481sWrb42NxDK1KH3B7SmQfZ/VbkZ6Bv
         UFGoHOnO67lbjAoTmyy2otF6qeMvoZp4D0JDJquNvZiviXt/EnCVccn5c42TPZSyod
         AAhtydlMiCQEGRhlKBdb4OuUFaUZOJyXLPk79uGq+W+vT0X6yN+1Zm+Dy0yq5qHp1k
         IW5J7fAsVWeQt+id9NicMd86nBIuQ4hjARMj67WHqPmdK0+vA7oDhPfGTJLO7m5qTh
         QGKYTBrSItg2A==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        rcu <rcu@vger.kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Giovanni Gherdovich <ggherdovich@suse.cz>
Subject: [PATCH 4/9] rcu: Introduce lazy queue's own qhimark
Date:   Wed, 31 May 2023 12:17:31 +0200
Message-Id: <20230531101736.12981-5-frederic@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230531101736.12981-1-frederic@kernel.org>
References: <20230531101736.12981-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The lazy and the regular bypass queues share the same thresholds in
terms of number of callbacks after which a flush to the main list is
performed: 10 000 callbacks.

However lazy and regular bypass don't have the same purposes and neither
should their respective thresholds:

* The bypass queue stands for relieving the main queue in case of a
  callback storm. It makes sense to allow a high number of callbacks to
  pile up before flushing to the main queue, especially as the life
  cycle for this queue is very short (1 jiffy).

* The lazy queue aims to spare wake ups and reduce the number of grace
  periods. There it doesn't make sense to allow a huge number of
  callbacks before flushing so as not to introduce memory pressure,
  especially as the life cycle for this queue is very long (10
  seconds)

For those reasons, set the default threshold for the lazy queue to
100.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/rcu/tree.c      | 2 ++
 kernel/rcu/tree_nocb.h | 9 ++++-----
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index bc4e7c9b51cb..9b98d87fa22e 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -379,6 +379,8 @@ static int rcu_is_cpu_rrupt_from_idle(void)
 static long blimit = DEFAULT_RCU_BLIMIT;
 #define DEFAULT_RCU_QHIMARK 10000 // If this many pending, ignore blimit.
 static long qhimark = DEFAULT_RCU_QHIMARK;
+#define DEFAULT_RCU_QHIMARK_LAZY 100 // If this many pending, flush.
+static long qhimark_lazy = DEFAULT_RCU_QHIMARK_LAZY;
 #define DEFAULT_RCU_QLOMARK 100   // Once only this many pending, use blimit.
 static long qlowmark = DEFAULT_RCU_QLOMARK;
 #define DEFAULT_RCU_QOVLD_MULT 2
diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index 8320eb77b58b..c08447db5a2e 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -480,10 +480,9 @@ static bool rcu_nocb_try_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
 
 	// If ->nocb_bypass has been used too long or is too full,
 	// flush ->nocb_bypass to ->cblist.
-	if ((ncbs && !bypass_is_lazy && j != READ_ONCE(rdp->nocb_bypass_first)) ||
-	    (ncbs &&  bypass_is_lazy &&
-	     (time_after(j, READ_ONCE(rdp->nocb_bypass_first) + jiffies_lazy_flush))) ||
-	    ncbs >= qhimark) {
+	if (ncbs &&
+	    ((!bypass_is_lazy && ((j != READ_ONCE(rdp->nocb_bypass_first)) || ncbs >= qhimark)) ||
+	     (bypass_is_lazy && (time_after(j, READ_ONCE(rdp->nocb_bypass_first) + jiffies_lazy_flush) || ncbs >= qhimark_lazy)))) {
 		rcu_nocb_lock(rdp);
 		*was_alldone = !rcu_segcblist_pend_cbs(&rdp->cblist);
 
@@ -724,7 +723,7 @@ static void nocb_gp_wait(struct rcu_data *my_rdp)
 
 		if (bypass_ncbs && (lazy_ncbs == bypass_ncbs) &&
 		    (time_after(j, READ_ONCE(rdp->nocb_bypass_first) + jiffies_lazy_flush) ||
-		     bypass_ncbs > 2 * qhimark)) {
+		     bypass_ncbs > 2 * qhimark_lazy)) {
 			flush_bypass = true;
 		} else if (bypass_ncbs && (lazy_ncbs != bypass_ncbs) &&
 		    (time_after(j, READ_ONCE(rdp->nocb_bypass_first) + 1) ||
-- 
2.40.1

