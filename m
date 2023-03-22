Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A8516C5528
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 20:45:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbjCVTp3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 15:45:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbjCVTpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 15:45:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEC273BC54;
        Wed, 22 Mar 2023 12:45:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 39A03622B3;
        Wed, 22 Mar 2023 19:45:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF921C4339C;
        Wed, 22 Mar 2023 19:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679514308;
        bh=0Nr44nYCi7dzslDo1zOnGsqBigDrConQ2cePzusvGBA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q4ElfwI+077Zl/ofdd0x4Ay6VqneIR52LHDh8XjmdxboYiaUFydahOC+vJdDP3gVM
         qKcsiuWKsMku4MXcouUMFY1ScE5FU63BdMz/qvvDXmr/AZV7oPpzqxEvDSG7ZWC5VG
         V8oTfqnZjRS0wCjLYzNexf3mUk13See+COaCA70KUfzrfUHDjbZB0nODKhY9g9GEf8
         VlO40NfZqTBD6abnXkfgTUW2DfAPV2va79D0yiYOm/MWe4O3X9NKiweMNPuOVmIVlW
         w9kbIexABoAg5VoldEaKqo16pOjfJbMT35K/KjLJDwpMnw+JO9srJ+pZ11tOc5oRAy
         k2dQYxj84yMGg==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        rcu <rcu@vger.kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH 2/4] rcu/nocb: Fix shrinker race against callback enqueuer
Date:   Wed, 22 Mar 2023 20:44:54 +0100
Message-Id: <20230322194456.2331527-3-frederic@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230322194456.2331527-1-frederic@kernel.org>
References: <20230322194456.2331527-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The shrinker resets the lazy callbacks counter in order to trigger the
pending lazy queue flush though the rcuog kthread. The counter reset is
protected by the ->nocb_lock against concurrent accesses...except
for one of them. Here is a list of existing synchronized readers/writer:

1) The first lazy enqueuer (incrementing ->lazy_len to 1) does so under
   ->nocb_lock and ->nocb_bypass_lock.

2) The further lazy enqueuers (incrementing ->lazy_len above 1) do so
   under ->nocb_bypass_lock _only_.

3) The lazy flush checks and resets to 0 under ->nocb_lock and
	->nocb_bypass_lock.

The shrinker protects its ->lazy_len reset against cases 1) and 3) but
not against 2). As such, setting ->lazy_len to 0 under the ->nocb_lock
may be cancelled right away by an overwrite from an enqueuer, leading
rcuog to ignore the flush.

To avoid that, use the proper bypass flush API which takes care of all
those details.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/rcu/tree_nocb.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index dd9b655ae533..cb57e8312231 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -1356,7 +1356,7 @@ lazy_rcu_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
 			continue;
 
 		rcu_nocb_lock_irqsave(rdp, flags);
-		WRITE_ONCE(rdp->lazy_len, 0);
+		WARN_ON_ONCE(!rcu_nocb_flush_bypass(rdp, NULL, jiffies, false));
 		rcu_nocb_unlock_irqrestore(rdp, flags);
 		wake_nocb_gp(rdp, false);
 		sc->nr_to_scan -= _count;
-- 
2.34.1

