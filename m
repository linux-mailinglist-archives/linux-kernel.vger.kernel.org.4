Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4396E616E28
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 21:01:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbiKBUBQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 16:01:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230374AbiKBUBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 16:01:11 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB296E53;
        Wed,  2 Nov 2022 13:01:08 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id n83so20312191oif.11;
        Wed, 02 Nov 2022 13:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NdYxLy6u/2PaTIupg+k2bBdapnT54tEDA9Zj5rVwx9I=;
        b=bAVCp0ivJaQO14A0QNklaSQIqSD0fnB3qCvfGZk24diiJXROl20vlLybQHTqWsCAmd
         G/OXrtfBqqVagHhnVljb3P4K1POpC+oMSjohUKIAU26KLaKRJc4r1uPq6NiktKorDDIa
         czZhkVpV7cjbJw10jQ6cLNEiH4zM80BpD4X2GUYYKDEKQZlQfVZlX8/S2HUzIS5GT1Mx
         UYarHeMq11u0lkibbOD8CWVpdyogUHObFPoBf83nIh6+PJWshohpERwc34q55ZiK2mYu
         lL2/t29Z1BzWqlfoblPJuC6Gua9PE/lVxDcwcijz3jyG78oDxRo+KiwAPxxl0R9Id/M3
         E2jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NdYxLy6u/2PaTIupg+k2bBdapnT54tEDA9Zj5rVwx9I=;
        b=RLU6ucL1+CyQqg6Q/Nh3kB/YugtA0rmHQ8/syAyzteqOs6gmY4BidQMETJcdlRL0YD
         SrCPi0L2HbLb+1SgS1rsBEq6Uu7cqq2YkwsWvY0wNiQZwpB98SPrjkl/XvHOAIDmgGmX
         OZFfP0nCvIIYIf2/CMqRQ35k8OxoCl2qv1tbTV3IJAMuEeYOyTZVgdaAoTZlrNv22tAZ
         xAsqEtU+hGQJdVfzuzBogxl7+vNnyHJgJ662L88F167DyBOkVQbZpES5oB5Lo7La8aMw
         ma+qRHcetydQrjcXEfDHgHCdRzlAH2WtKnrBBZCVxVJWC0u3VcEE1iTg+NvdhsoVO9LL
         N66Q==
X-Gm-Message-State: ACrzQf09e9aS/wASMcF2S/2r3rsKSVdAl9dnUfzI1Nn/JFBSe0swD0ot
        hnVCmnHSMqxmWDyJvrGioIs=
X-Google-Smtp-Source: AMsMyM7NdmpoQP25PH2Uc/dA20RwnF8f9qcE3BAQDocFFzqpofVxY8PDrwxFWjupI0R/+C+yTZmhlg==
X-Received: by 2002:a05:6808:1442:b0:35a:1542:a1a6 with SMTP id x2-20020a056808144200b0035a1542a1a6mr8584650oiv.243.1667419267979;
        Wed, 02 Nov 2022 13:01:07 -0700 (PDT)
Received: from auvcetillem1m1.corp.emc.net ([143.166.81.254])
        by smtp.gmail.com with ESMTPSA id n29-20020a0568080a1d00b003549397fde4sm4873182oij.54.2022.11.02.13.01.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 13:01:07 -0700 (PDT)
From:   Stuart Hayes <stuart.w.hayes@gmail.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Stuart Hayes <stuart.w.hayes@gmail.com>,
        Kyle Meyer <kyle.meyer@hpe.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] cpufreq: acpi: Defer setting boost MSRs
Date:   Wed,  2 Nov 2022 14:59:57 -0500
Message-Id: <20221102195957.82871-1-stuart.w.hayes@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When acpi-cpufreq is loaded, boost is enabled on every CPU (by setting an
MSR) before the driver is registered with cpufreq.  This can be very time
consuming, because it is done with a CPU hotplug startup callback, and
cpuhp_setup_state() schedules the callback (cpufreq_boost_online()) to run
on each CPU one at a time, waiting for each to run before calling the next.

If cpufreq_register_driver() fails--if, for example, there are no ACPI
P-states present--this is wasted time.

Since cpufreq already sets up a CPU hotplug startup callback if and when
acpi-cpufreq is registered, set the boost MSRs in acpi_cpufreq_cpu_init(),
which is called by the cpufreq cpuhp callback.  This allows acpi-cpufreq to
exit quickly if it is loaded but not needed.

On one system with 192 CPUs, this patch speeds up boot by about 30 seconds.

Signed-off-by: Stuart Hayes <stuart.w.hayes@gmail.com>
---
 drivers/cpufreq/acpi-cpufreq.c | 31 +++----------------------------
 1 file changed, 3 insertions(+), 28 deletions(-)

diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
index 1bb2b90ebb21..cb167263de72 100644
--- a/drivers/cpufreq/acpi-cpufreq.c
+++ b/drivers/cpufreq/acpi-cpufreq.c
@@ -535,15 +535,6 @@ static void free_acpi_perf_data(void)
 	free_percpu(acpi_perf_data);
 }
 
-static int cpufreq_boost_online(unsigned int cpu)
-{
-	/*
-	 * On the CPU_UP path we simply keep the boost-disable flag
-	 * in sync with the current global state.
-	 */
-	return boost_set_msr(acpi_cpufreq_driver.boost_enabled);
-}
-
 static int cpufreq_boost_down_prep(unsigned int cpu)
 {
 	/*
@@ -897,6 +888,8 @@ static int acpi_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	if (perf->states[0].core_frequency * 1000 != freq_table[0].frequency)
 		pr_warn(FW_WARN "P-state 0 is not max freq\n");
 
+	set_boost(policy, acpi_cpufreq_driver.boost_enabled);
+
 	return result;
 
 err_unreg:
@@ -916,6 +909,7 @@ static int acpi_cpufreq_cpu_exit(struct cpufreq_policy *policy)
 
 	pr_debug("%s\n", __func__);
 
+	cpufreq_boost_down_prep(policy->cpu);
 	policy->fast_switch_possible = false;
 	policy->driver_data = NULL;
 	acpi_processor_unregister_performance(data->acpi_perf_cpu);
@@ -972,25 +966,9 @@ static void __init acpi_cpufreq_boost_init(void)
 	acpi_cpufreq_driver.set_boost = set_boost;
 	acpi_cpufreq_driver.boost_enabled = boost_state(0);
 
-	/*
-	 * This calls the online callback on all online cpu and forces all
-	 * MSRs to the same value.
-	 */
-	ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "cpufreq/acpi:online",
-				cpufreq_boost_online, cpufreq_boost_down_prep);
-	if (ret < 0) {
-		pr_err("acpi_cpufreq: failed to register hotplug callbacks\n");
-		return;
-	}
 	acpi_cpufreq_online = ret;
 }
 
-static void acpi_cpufreq_boost_exit(void)
-{
-	if (acpi_cpufreq_online > 0)
-		cpuhp_remove_state_nocalls(acpi_cpufreq_online);
-}
-
 static int __init acpi_cpufreq_init(void)
 {
 	int ret;
@@ -1032,7 +1010,6 @@ static int __init acpi_cpufreq_init(void)
 	ret = cpufreq_register_driver(&acpi_cpufreq_driver);
 	if (ret) {
 		free_acpi_perf_data();
-		acpi_cpufreq_boost_exit();
 	}
 	return ret;
 }
@@ -1041,8 +1018,6 @@ static void __exit acpi_cpufreq_exit(void)
 {
 	pr_debug("%s\n", __func__);
 
-	acpi_cpufreq_boost_exit();
-
 	cpufreq_unregister_driver(&acpi_cpufreq_driver);
 
 	free_acpi_perf_data();
-- 
2.31.1

