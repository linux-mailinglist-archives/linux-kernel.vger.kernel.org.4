Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 920496CEE9D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 18:05:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230507AbjC2QFI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 12:05:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231178AbjC2QEf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 12:04:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 157F47DBA;
        Wed, 29 Mar 2023 09:03:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CA5CA61DA0;
        Wed, 29 Mar 2023 16:02:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76468C433EF;
        Wed, 29 Mar 2023 16:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680105731;
        bh=Fp/ndTMmWDQvJYRUYSiB/n1pWGiQmprjbLIvXN1t7Yo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GXJMVZfZjTUnt6ouzt7l7m2vLdEpVbUYF3zXJObcVdJJ25rx/QAGDa+UpVUX5FE0p
         yr9Nrt6tM4pt81wfx84r5lPmsnUfyLbv3QrLoXbP+LziiVJ06zK3GQsjq+RFuVFwiq
         v/5qNkDMeWEGa054oW0J6Lk4jzXytIB0ApwtctH1DbKmdcqmNH0qiX5j553slYPOp5
         aaTi7iyeF5s8UlNX+OkcbFgJMznNcCAKMSsCCYFsqremZD8TJRiiv6HxfgLeXT3yDy
         7Z//tvu6PB1lD4HVnV8kem77vQWp8PlIRW8pyBKiBT1n6SzZs5RnfTlJ2C+xWJMZaU
         7Qo2OdpvBGN6g==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        rcu <rcu@vger.kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH 1/4] rcu/nocb: Protect lazy shrinker against concurrent (de-)offloading
Date:   Wed, 29 Mar 2023 18:02:00 +0200
Message-Id: <20230329160203.191380-2-frederic@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230329160203.191380-1-frederic@kernel.org>
References: <20230329160203.191380-1-frederic@kernel.org>
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

The shrinker may run concurrently with callbacks (de-)offloading. As
such, calling rcu_nocb_lock() is very dangerous because it does a
conditional locking. The worst outcome is that rcu_nocb_lock() doesn't
lock but rcu_nocb_unlock() eventually unlocks, or the reverse, creating
an imbalance.

Fix this with protecting against (de-)offloading using the barrier mutex.
Although if the barrier mutex is contended, which should be rare, then
step aside so as not to trigger a mutex VS allocation
dependency chain.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/rcu/tree_nocb.h | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index f2280616f9d5..1a86883902ce 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -1336,13 +1336,33 @@ lazy_rcu_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
 	unsigned long flags;
 	unsigned long count = 0;
 
+	/*
+	 * Protect against concurrent (de-)offloading. Otherwise nocb locking
+	 * may be ignored or imbalanced.
+	 */
+	if (!mutex_trylock(&rcu_state.barrier_mutex)) {
+		/*
+		 * But really don't insist if barrier_mutex is contended since we
+		 * can't guarantee that it will never engage in a dependency
+		 * chain involving memory allocation. The lock is seldom contended
+		 * anyway.
+		 */
+		return 0;
+	}
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
@@ -1352,6 +1372,9 @@ lazy_rcu_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
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

