Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8AC55F07F6
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 11:48:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbiI3Jss (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 05:48:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231207AbiI3Jsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 05:48:42 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0DEE29F182;
        Fri, 30 Sep 2022 02:48:41 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 802C915BF;
        Fri, 30 Sep 2022 02:48:47 -0700 (PDT)
Received: from e123648.arm.com (unknown [10.57.0.185])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9705F3F73B;
        Fri, 30 Sep 2022 02:48:39 -0700 (PDT)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org, rafael@kernel.org
Cc:     linux-pm@vger.kernel.org, lukasz.luba@arm.com,
        viresh.kumar@linaro.org, Dietmar.Eggemann@arm.com
Subject: [PATCH 2/2] cpufreq: Update CPU capacity reduction in store_scaling_max_freq()
Date:   Fri, 30 Sep 2022 10:48:21 +0100
Message-Id: <20220930094821.31665-2-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220930094821.31665-1-lukasz.luba@arm.com>
References: <20220930094821.31665-1-lukasz.luba@arm.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the new max frequency value is stored, the task scheduler must
know about it. The scheduler uses the CPUs capacity information in the
task placement. Use the existing mechanism which provides information
about reduced CPU capacity to the scheduler due to thermal capping.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 drivers/cpufreq/cpufreq.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 1f8b93f42c76..205d9ea9c023 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -27,6 +27,7 @@
 #include <linux/slab.h>
 #include <linux/suspend.h>
 #include <linux/syscore_ops.h>
+#include <linux/thermal.h>
 #include <linux/tick.h>
 #include <linux/units.h>
 #include <trace/events/power.h>
@@ -718,6 +719,8 @@ static ssize_t show_scaling_cur_freq(struct cpufreq_policy *policy, char *buf)
 static ssize_t store_scaling_max_freq
 (struct cpufreq_policy *policy, const char *buf, size_t count)
 {
+	unsigned int frequency;
+	struct cpumask *cpus;
 	unsigned long val;
 	int ret;
 
@@ -726,7 +729,20 @@ static ssize_t store_scaling_max_freq
 		return -EINVAL;
 
 	ret = freq_qos_update_request(policy->max_freq_req, val);
-	return ret >= 0 ? count : ret;
+	if (ret >= 0) {
+		/*
+		 * Make sure that the task scheduler sees these CPUs
+		 * capacity reduction. Use the thermal pressure mechanism
+		 * to propagate this information to the scheduler.
+		 */
+		cpus = policy->related_cpus;
+		frequency = __resolve_freq(policy, val, CPUFREQ_RELATION_HE);
+		arch_update_thermal_pressure(cpus, frequency);
+
+		ret = count;
+	}
+
+	return ret;
 }
 
 static ssize_t store_scaling_min_freq
-- 
2.17.1

