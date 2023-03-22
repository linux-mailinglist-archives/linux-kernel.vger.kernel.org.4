Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FAFC6C5526
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 20:45:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbjCVTpb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 15:45:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbjCVTpT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 15:45:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C81F11EFE2;
        Wed, 22 Mar 2023 12:45:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 78F8CB81DEA;
        Wed, 22 Mar 2023 19:45:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A46EC433AA;
        Wed, 22 Mar 2023 19:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679514313;
        bh=o/d+MExJk6dT2Q3smaaeBjF9BtLmW7hBw77NXSOsuZA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sMzpGXOBEC1RG/wSZamyrsu+iU5m/0UxfjbhgycVXYNRHFbH1PZzU36l2ZJ4mSV0j
         LkxFT6qscyXdSGYE7CmKa1TSgHrv8ZKVgvw5F65b2ML4Bc3nLmvr37dSZcgONG+5pJ
         mdw05b0W+QtvQbJBzNWZzZiXPt0XXlvpK3HV5gZA+FxyPMGB7CvKDCBH8iioZ4teNE
         d3i8DgCAfvDwfQLZEvkwaEIUyJ5yDb+kP0dxZBPQzjEi/l9KdYglF8ryipqJ9Imq7y
         zm+q6aVtWhZGneLo//5aGNwdBjFj+fGPKk8BA3LqKTtQbIbBhhQyejpRxL+Q7gZWZr
         Y82MOffgaHTBQ==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        rcu <rcu@vger.kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH 4/4] rcu/nocb: Make shrinker to iterate only NOCB CPUs
Date:   Wed, 22 Mar 2023 20:44:56 +0100
Message-Id: <20230322194456.2331527-5-frederic@kernel.org>
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

Callbacks can only be queued as lazy on NOCB CPUs, therefore iterating
over the NOCB mask is enough for both counting and scanning. Just lock
the mostly uncontended barrier mutex on counting as well in order to
keep rcu_nocb_mask stable.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/rcu/tree_nocb.h | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index a3dc7465b0b2..185c0c9a60d4 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -1319,13 +1319,21 @@ lazy_rcu_shrink_count(struct shrinker *shrink, struct shrink_control *sc)
 	int cpu;
 	unsigned long count = 0;
 
+	if (WARN_ON_ONCE(!cpumask_available(rcu_nocb_mask)))
+		return 0;
+
+	/*  Protect rcu_nocb_mask against concurrent (de-)offloading. */
+	mutex_lock(&rcu_state.barrier_mutex);
+
 	/* Snapshot count of all CPUs */
-	for_each_possible_cpu(cpu) {
+	for_each_cpu(cpu, rcu_nocb_mask) {
 		struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
 
 		count +=  READ_ONCE(rdp->lazy_len);
 	}
 
+	mutex_unlock(&rcu_state.barrier_mutex);
+
 	return count ? count : SHRINK_EMPTY;
 }
 
@@ -1336,6 +1344,8 @@ lazy_rcu_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
 	unsigned long flags;
 	unsigned long count = 0;
 
+	if (WARN_ON_ONCE(!cpumask_available(rcu_nocb_mask)))
+		return 0;
 	/*
 	 * Protect against concurrent (de-)offloading. Otherwise nocb locking
 	 * may be ignored or imbalanced.
@@ -1343,7 +1353,7 @@ lazy_rcu_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
 	mutex_lock(&rcu_state.barrier_mutex);
 
 	/* Snapshot count of all CPUs */
-	for_each_possible_cpu(cpu) {
+	for_each_cpu(cpu, rcu_nocb_mask) {
 		struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
 		int _count;
 
-- 
2.34.1

