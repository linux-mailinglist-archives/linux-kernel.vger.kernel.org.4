Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70AEB700492
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 12:00:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240558AbjELKAM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 06:00:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240654AbjELJ7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 05:59:30 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 47F5811DB4;
        Fri, 12 May 2023 02:59:03 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2E08D1684;
        Fri, 12 May 2023 02:59:30 -0700 (PDT)
Received: from e123648.arm.com (unknown [10.57.22.28])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E19C93F5A1;
        Fri, 12 May 2023 02:58:42 -0700 (PDT)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        rafael@kernel.org
Cc:     lukasz.luba@arm.com, dietmar.eggemann@arm.com, rui.zhang@intel.com,
        amit.kucheria@verdurent.com, amit.kachhap@gmail.com,
        daniel.lezcano@linaro.org, viresh.kumar@linaro.org,
        len.brown@intel.com, pavel@ucw.cz, Pierre.Gondois@arm.com,
        ionela.voinescu@arm.com, rostedt@goodmis.org, mhiramat@kernel.org
Subject: [PATCH v2 16/17] Documentation: EM: Add example with driver modifying the EM
Date:   Fri, 12 May 2023 10:57:42 +0100
Message-Id: <20230512095743.3393563-17-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230512095743.3393563-1-lukasz.luba@arm.com>
References: <20230512095743.3393563-1-lukasz.luba@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Energy Model (EM) support runtime modifications. Add description
with example driver code which updates EM.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 Documentation/power/energy-model.rst | 53 ++++++++++++++++++++++++++--
 1 file changed, 51 insertions(+), 2 deletions(-)

diff --git a/Documentation/power/energy-model.rst b/Documentation/power/energy-model.rst
index 64c2462dc9a6..a6ceeeb72868 100644
--- a/Documentation/power/energy-model.rst
+++ b/Documentation/power/energy-model.rst
@@ -225,8 +225,11 @@ or in Section 3.4
    :export:
 
 
-4. Example driver
------------------
+4. Examples
+-----------
+
+4.1 Example driver with EM registration
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 
 The CPUFreq framework supports dedicated callback for registering
 the EM for a given CPU(s) 'policy' object: cpufreq_driver::register_em().
@@ -280,3 +283,49 @@ EM framework::
   39	static struct cpufreq_driver foo_cpufreq_driver = {
   40		.register_em = foo_cpufreq_register_em,
   41	};
+
+
+4.2 Example driver with EM modification
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+This section provides a simple example of a thermal driver modifying the EM.
+The driver implements a foo_mod_power() function to be provided to the
+EM framework. The driver is woken up periodically to check the temperature
+and modify the EM data if needed::
+
+  -> drivers/thermal/foo_thermal.c
+
+  01	static int foo_mod_power(struct device *dev, unsigned long freq,
+  02			unsigned long *power, void *priv)
+  03	{
+  04		struct foo_context *ctx = priv;
+  05
+  06		/* Estimate power for the given frequency and temperature */
+  07		*power = foo_estimate_power(dev, freq, ctx->temperature);
+  08		if (*power >= EM_MAX_POWER);
+  09			return -EINVAL;
+  10
+  11		return 0;
+  12	}
+  13
+  14	/*
+  15	 * Function called periodically to check the temperature and
+  16	 * update the EM if needed
+  17	 */
+  18	static void foo_thermal_em_update(struct foo_context *ctx)
+  19	{
+  20		struct em_data_callback em_cb = EM_UPDATE_CB(mod_power);
+  21		struct cpufreq_policy *policy = ctx->policy;
+  22		struct device *cpu_dev;
+  23
+  24		cpu_dev = get_cpu_device(cpumask_first(policy->cpus));
+  25
+  26		ctx->temperature = foo_get_temp(cpu_dev, ctx);
+  27		if (ctx->temperature < FOO_EM_UPDATE_TEMP_THRESHOLD)
+  28			return;
+  29
+  30		/* Update EM for the CPUs' performance domain */
+  31		ret = em_dev_update_perf_domain(cpu_dev, &em_cb, ctx);
+  32		if (ret)
+  33			pr_warn("foo_thermal: EM update failed\n");
+  34	}
-- 
2.25.1

