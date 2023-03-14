Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 184616B9022
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 11:35:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbjCNKfa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 06:35:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231421AbjCNKfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 06:35:13 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 729AD10430;
        Tue, 14 Mar 2023 03:34:43 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AA2D21474;
        Tue, 14 Mar 2023 03:35:06 -0700 (PDT)
Received: from e123648.arm.com (unknown [10.57.19.101])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3333A3F71A;
        Tue, 14 Mar 2023 03:34:20 -0700 (PDT)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        rafael@kernel.org
Cc:     lukasz.luba@arm.com, dietmar.eggemann@arm.com, rui.zhang@intel.com,
        amit.kucheria@verdurent.com, amit.kachhap@gmail.com,
        daniel.lezcano@linaro.org, viresh.kumar@linaro.org,
        len.brown@intel.com, pavel@ucw.cz, Pierre.Gondois@arm.com,
        ionela.voinescu@arm.com, rostedt@goodmis.org, mhiramat@kernel.org
Subject: [PATCH 03/17] PM: EM: Refactor em_pd_get_efficient_state() to be more flexible
Date:   Tue, 14 Mar 2023 10:33:43 +0000
Message-Id: <20230314103357.26010-4-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230314103357.26010-1-lukasz.luba@arm.com>
References: <20230314103357.26010-1-lukasz.luba@arm.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prepare em_pd_get_efficient_state() for the upcoming changes and
make it possible to re-use. Return an index for the best performance
state. The function arguments that are introduced should allow to
work on different performance state arrays. The caller of
em_pd_get_efficient_state() should be able to use the index either
on the default or the modifiable EM table.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 include/linux/energy_model.h | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
index b9caa01dfac4..8069f526c9d8 100644
--- a/include/linux/energy_model.h
+++ b/include/linux/energy_model.h
@@ -175,33 +175,35 @@ void em_dev_unregister_perf_domain(struct device *dev);
 
 /**
  * em_pd_get_efficient_state() - Get an efficient performance state from the EM
- * @pd   : Performance domain for which we want an efficient frequency
- * @freq : Frequency to map with the EM
+ * @state:		List of performance states, in ascending order
+ * @nr_perf_states:	Number of performance states
+ * @freq:		Frequency to map with the EM
+ * @pd_flags:		Performance Domain flags
  *
  * It is called from the scheduler code quite frequently and as a consequence
  * doesn't implement any check.
  *
- * Return: An efficient performance state, high enough to meet @freq
+ * Return: An efficient performance state id, high enough to meet @freq
  * requirement.
  */
-static inline
-struct em_perf_state *em_pd_get_efficient_state(struct em_perf_domain *pd,
-						unsigned long freq)
+static inline int
+em_pd_get_efficient_state(struct em_perf_state *table, int nr_perf_states,
+			  unsigned long freq, unsigned long pd_flags)
 {
 	struct em_perf_state *ps;
 	int i;
 
-	for (i = 0; i < pd->nr_perf_states; i++) {
-		ps = &pd->table[i];
+	for (i = 0; i < nr_perf_states; i++) {
+		ps = &table[i];
 		if (ps->frequency >= freq) {
-			if (pd->flags & EM_PERF_DOMAIN_SKIP_INEFFICIENCIES &&
+			if (pd_flags & EM_PERF_DOMAIN_SKIP_INEFFICIENCIES &&
 			    ps->flags & EM_PERF_STATE_INEFFICIENT)
 				continue;
-			break;
+			return i;
 		}
 	}
 
-	return ps;
+	return nr_perf_states - 1;
 }
 
 /**
@@ -226,7 +228,7 @@ static inline unsigned long em_cpu_energy(struct em_perf_domain *pd,
 {
 	unsigned long freq, scale_cpu;
 	struct em_perf_state *ps;
-	int cpu;
+	int cpu, i;
 
 	if (!sum_util)
 		return 0;
@@ -251,7 +253,9 @@ static inline unsigned long em_cpu_energy(struct em_perf_domain *pd,
 	 * Find the lowest performance state of the Energy Model above the
 	 * requested frequency.
 	 */
-	ps = em_pd_get_efficient_state(pd, freq);
+	i = em_pd_get_efficient_state(pd->table, pd->nr_perf_states, freq,
+				      pd->flags);
+	ps = &pd->table[i];
 
 	/*
 	 * The capacity of a CPU in the domain at the performance state (ps)
-- 
2.17.1

