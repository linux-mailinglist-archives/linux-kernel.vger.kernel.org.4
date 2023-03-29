Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F6376CEE9A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 18:05:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230382AbjC2QE7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 12:04:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231585AbjC2QEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 12:04:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B56C3619E;
        Wed, 29 Mar 2023 09:03:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7054461DA6;
        Wed, 29 Mar 2023 16:02:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2042CC433A8;
        Wed, 29 Mar 2023 16:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680105737;
        bh=0K4ESNHhsDtk/yTZYL0aDVGEKmylHOGHPXnx46UNdgA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T9MnKLbPrzarjfBI9Dw3rgLPHWQ8R6SP/XmHP0pf5K+NS6LV+GbdRHtt44caB17Aa
         Fovrx/MzSWysqABNpo4PTUYL30Yd0e/T14VLVTAG7i5Tij52icZET8bAihMSn2uncp
         9dMU1P+Y0blFA4Z74TJYw8hmeSgYk6IBYNX6ovEdXytKo3dlUkiI98znrYWcl9kRBo
         1slX4ifmJD5DWD+8I3Rbvnud97Fu8BfkTVZ+xehDhzeywWmnKwPeXuJ2bUC1uZ1sx1
         rHHr6nT9u3Mw3v5d+dOFQGgwI7yM4iXHP8aK6LM2EiEjamYCebP3ZCgp8OBmd3WvAN
         ctWQZThLtRm/g==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        rcu <rcu@vger.kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH 4/4] rcu/nocb: Make shrinker to iterate only NOCB CPUs
Date:   Wed, 29 Mar 2023 18:02:03 +0200
Message-Id: <20230329160203.191380-5-frederic@kernel.org>
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

Callbacks can only be queued as lazy on NOCB CPUs, therefore iterating
over the NOCB mask is enough for both counting and scanning. Just lock
the mostly uncontended barrier mutex on counting as well in order to
keep rcu_nocb_mask stable.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
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
2.34.1

