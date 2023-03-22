Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7571C6C5529
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 20:45:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbjCVTpX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 15:45:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbjCVTpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 15:45:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6135E3E0BD;
        Wed, 22 Mar 2023 12:45:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EF741622B2;
        Wed, 22 Mar 2023 19:45:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E6C7C4339E;
        Wed, 22 Mar 2023 19:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679514306;
        bh=a59gUDfTCHexacSrsbU3Hhq+A3tfJIUWFd5dyE5PoH0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KsIagmLyRTqKsfR7uIUg9MjUB6redqBnrKvV76N6o1Vx+jY7uIq9Y/alf5qVC/2ey
         ohoXznoXXIOPSCCOrKmSUnBTPG7XgSSOYnAU0cwsvTb1jWWtbM7mUf8bn8zfxUqq7d
         sUKfStasnjoGheU7ibY1W95SuRdThbFK9Ec/iAOHru2Z9iREVbwiQjm2+mgwBrHgpT
         Rv8lUWHtGFZv1KFuOaULMtS5KzIMTqZzlDzOsR6T4Fl82KuJ/xakJuFUd6056Ubqmc
         H7gSghF0E0NFS/fX2z1J5oKfP42YjQUcRkcAmriowRcVz/Mqs+RrElKEEgy3Ag1wLo
         1ff65pFu9K4+A==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        rcu <rcu@vger.kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH 1/4] rcu/nocb: Protect lazy shrinker against concurrent (de-)offloading
Date:   Wed, 22 Mar 2023 20:44:53 +0100
Message-Id: <20230322194456.2331527-2-frederic@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230322194456.2331527-1-frederic@kernel.org>
References: <20230322194456.2331527-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The shrinker may run concurrently with callbacks (de-)offloading. As
such, calling rcu_nocb_lock() is very dangerous because it does a
conditional locking. The worst outcome is that rcu_nocb_lock() doesn't
lock but rcu_nocb_unlock() eventually unlocks, or the reverse, creating
an imbalance.

Fix this with protecting against (de-)offloading using the barrier mutex.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/rcu/tree_nocb.h | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index f2280616f9d5..dd9b655ae533 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -1336,13 +1336,25 @@ lazy_rcu_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
 	unsigned long flags;
 	unsigned long count = 0;
 
+	/*
+	 * Protect against concurrent (de-)offloading. Otherwise nocb locking
+	 * may be ignored or imbalanced.
+	 */
+	mutex_lock(&rcu_state.barrier_mutex);
+
 	/* Snapshot count of all CPUs */
 	for_each_possible_cpu(cpu) {
 		struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
-		int _count = READ_ONCE(rdp->lazy_len);
+		int _count;
+
+		if (!rcu_rdp_is_offloaded(rdp))
+			continue;
+
+		_count = READ_ONCE(rdp->lazy_len);
 
 		if (_count == 0)
 			continue;
+
 		rcu_nocb_lock_irqsave(rdp, flags);
 		WRITE_ONCE(rdp->lazy_len, 0);
 		rcu_nocb_unlock_irqrestore(rdp, flags);
@@ -1352,6 +1364,9 @@ lazy_rcu_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
 		if (sc->nr_to_scan <= 0)
 			break;
 	}
+
+	mutex_unlock(&rcu_state.barrier_mutex);
+
 	return count ? count : SHRINK_STOP;
 }
 
-- 
2.34.1

