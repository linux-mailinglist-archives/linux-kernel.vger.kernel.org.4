Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3B766B9021
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 11:35:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbjCNKfe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 06:35:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231395AbjCNKfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 06:35:10 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 11D0E95BE0;
        Tue, 14 Mar 2023 03:34:37 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 872F81063;
        Tue, 14 Mar 2023 03:35:03 -0700 (PDT)
Received: from e123648.arm.com (unknown [10.57.19.101])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 05FC23F71A;
        Tue, 14 Mar 2023 03:34:16 -0700 (PDT)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        rafael@kernel.org
Cc:     lukasz.luba@arm.com, dietmar.eggemann@arm.com, rui.zhang@intel.com,
        amit.kucheria@verdurent.com, amit.kachhap@gmail.com,
        daniel.lezcano@linaro.org, viresh.kumar@linaro.org,
        len.brown@intel.com, pavel@ucw.cz, Pierre.Gondois@arm.com,
        ionela.voinescu@arm.com, rostedt@goodmis.org, mhiramat@kernel.org
Subject: [PATCH 02/17] PM: EM: Find first CPU online while updating OPP efficiency
Date:   Tue, 14 Mar 2023 10:33:42 +0000
Message-Id: <20230314103357.26010-3-lukasz.luba@arm.com>
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

The Energy Model might be updated at runtime and the energy efficiency
for each OPP may change. Thus, there is a need to update also the
cpufreq framework and make it aligned to the new values. In order to
do that, use a first online CPU from the Performance Domain.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 kernel/power/energy_model.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
index 265d51a948d4..3d8d1fad00ac 100644
--- a/kernel/power/energy_model.c
+++ b/kernel/power/energy_model.c
@@ -246,12 +246,19 @@ em_cpufreq_update_efficiencies(struct device *dev, struct em_perf_state *table)
 	struct em_perf_domain *pd = dev->em_pd;
 	struct cpufreq_policy *policy;
 	int found = 0;
-	int i;
+	int i, cpu;
 
 	if (!_is_cpu_device(dev) || !pd)
 		return;
 
-	policy = cpufreq_cpu_get(cpumask_first(em_span_cpus(pd)));
+	/* Try to get a CPU which is online and in this PD */
+	cpu = cpumask_first_and(em_span_cpus(pd), cpu_active_mask);
+	if (cpu >= nr_cpu_ids) {
+		dev_warn(dev, "EM: No online CPU for CPUFreq policy\n");
+		return;
+	}
+
+	policy = cpufreq_cpu_get(cpu);
 	if (!policy) {
 		dev_warn(dev, "EM: Access to CPUFreq policy failed");
 		return;
-- 
2.17.1

