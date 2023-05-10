Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E06F16FE304
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 19:06:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236520AbjEJRGk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 13:06:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230016AbjEJRGY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 13:06:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D27DE2110;
        Wed, 10 May 2023 10:06:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 43FD063F47;
        Wed, 10 May 2023 17:06:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 982EEC4339E;
        Wed, 10 May 2023 17:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683738370;
        bh=U+Q4wxr8ZsSuY8eMqt0mzW+sVG9CBmqF3HyB4hgOzwQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ml32gSFwseQxjkto07DNvhQVAkMiMJt2v6tyTcFUNSliaFMkfCAVHt96WWYubRqDR
         q0bOqW9QejsnUciAh3uaqNh6qdB18VNsMgaF8WRAA4OuOzi+xvoER4GLnPSUbg0MAY
         SLxoV+rbKrPEC4LNORrv/kefb1L6ERl+aKJhUQdyCBM6q0gRXZ4w6WXaesSbfTV2cu
         bMusu1up87tm9m9pF+3+uaT1jBo1Wyf1Bgl7EMvRI8K+Tw1aFE5qT8qe6UO0tnNiuU
         gF4+gZeFzh39/GAER8lxRAd3FcG0C9XcwPDebFhURaBHrzEKAOBYJUwapSNzDIYw+T
         owjVLe4pVvE5g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 346DDCE1348; Wed, 10 May 2023 10:06:10 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, Frederic Weisbecker <frederic@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 4/4] rcu/nocb: Make shrinker to iterate only NOCB CPUs
Date:   Wed, 10 May 2023 10:06:07 -0700
Message-Id: <20230510170607.2187978-4-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <9c5fae22-e25e-4548-b6e9-117495b29e62@paulmck-laptop>
References: <9c5fae22-e25e-4548-b6e9-117495b29e62@paulmck-laptop>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frederic Weisbecker <frederic@kernel.org>

Callbacks can only be queued as lazy on NOCB CPUs, therefore iterating
over the NOCB mask is enough for both counting and scanning. Just lock
the mostly uncontended barrier mutex on counting as well in order to
keep rcu_nocb_mask stable.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_nocb.h | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index dfa9c10d6727..43229d2b0c44 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -1319,13 +1319,22 @@ lazy_rcu_shrink_count(struct shrinker *shrink, struct shrink_control *sc)
 	int cpu;
 	unsigned long count = 0;
 
+	if (WARN_ON_ONCE(!cpumask_available(rcu_nocb_mask)))
+		return 0;
+
+	/*  Protect rcu_nocb_mask against concurrent (de-)offloading. */
+	if (!mutex_trylock(&rcu_state.barrier_mutex))
+		return 0;
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
 
@@ -1336,6 +1345,8 @@ lazy_rcu_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
 	unsigned long flags;
 	unsigned long count = 0;
 
+	if (WARN_ON_ONCE(!cpumask_available(rcu_nocb_mask)))
+		return 0;
 	/*
 	 * Protect against concurrent (de-)offloading. Otherwise nocb locking
 	 * may be ignored or imbalanced.
@@ -1351,11 +1362,11 @@ lazy_rcu_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
 	}
 
 	/* Snapshot count of all CPUs */
-	for_each_possible_cpu(cpu) {
+	for_each_cpu(cpu, rcu_nocb_mask) {
 		struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
 		int _count;
 
-		if (!rcu_rdp_is_offloaded(rdp))
+		if (WARN_ON_ONCE(!rcu_rdp_is_offloaded(rdp)))
 			continue;
 
 		if (!READ_ONCE(rdp->lazy_len))
-- 
2.40.1

