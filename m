Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 181326187C5
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 19:40:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231144AbiKCSkF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 14:40:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231169AbiKCSkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 14:40:02 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A6BB15A0D;
        Thu,  3 Nov 2022 11:39:59 -0700 (PDT)
Date:   Thu, 03 Nov 2022 18:39:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1667500797;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=xENVDoPXxUqY8rf5BH/AhX7AJMk3dm0UMy+Fi6xNzJw=;
        b=FMU6XkoLNq36jrlL+JnSKfF5HydpY5pGkwd1zHifIRKA3a9sxapGi9XLA/AUqEvU2W3B4y
        zzKf7hZZt+jvUufyVFUwawPenAr6aQLM2fTFh9xMQ2qq+tGad5XjRwmT+Ewftj/vI2ssWi
        CitH/WMtk6knJSm+ZOP4eU5KfjPVPKuD9MLYPPtz11Vo223LWzRepnpkx85MvGWl7rFHRd
        X/8NN/PYAMEUwNTvLPdb45EFb1jWZSACMqZN5UzmUtCjfmyv2tyKsmjh/q0ccRIbUT+VPh
        /gWy+ud4c4cv874EeZYiMNq0N7WU0iGsn8sg6GB0qsEEyb3AR+Au7LYTaM0rGA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1667500797;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=xENVDoPXxUqY8rf5BH/AhX7AJMk3dm0UMy+Fi6xNzJw=;
        b=2/HKk9xTh3gSXwEzG/ZcI5NzRsYznG0lj6x2Gp2dERJecnfNiDCbxpclvyNcr5wMme1zc0
        q2ReUF4a8M442TCQ==
From:   "tip-bot2 for Srinivas Pandruvada" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/intel_epb: Set Alder Lake N and Raptor Lake P normal EPB
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <166750079535.6127.17977189495133076329.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     7420ae3bb977b46eab082f4964641f3ddc98ebaf
Gitweb:        https://git.kernel.org/tip/7420ae3bb977b46eab082f4964641f3ddc98ebaf
Author:        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
AuthorDate:    Thu, 27 Oct 2022 15:00:56 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Thu, 03 Nov 2022 11:31:01 -07:00

x86/intel_epb: Set Alder Lake N and Raptor Lake P normal EPB

Intel processors support additional software hint called EPB ("Energy
Performance Bias") to guide the hardware heuristic of power management
features to favor increasing dynamic performance or conserve energy
consumption.

Since this EPB hint is processor specific, the same value of hint can
result in different behavior across generations of processors.

commit 4ecc933b7d1f ("x86: intel_epb: Allow model specific normal EPB
value")' introduced capability to update the default power up EPB
based on the CPU model and updated the default EPB to 7 for Alder Lake
mobile CPUs.

The same change is required for other Alder Lake-N and Raptor Lake-P
mobile CPUs as the current default of 6 results in higher uncore power
consumption. This increase in power is related to memory clock
frequency setting based on the EPB value.

Depending on the EPB the minimum memory frequency is set by the
firmware. At EPB = 7, the minimum memory frequency is 1/4th compared to
EPB = 6. This results in significant power saving for idle and
semi-idle workload on a Chrome platform.

For example Change in power and performance from EPB change from 6 to 7
on Alder Lake-N:

Workload    Performance diff (%)    power diff
----------------------------------------------------
VP9 FHD30	0 (FPS)		-218 mw
Google meet	0 (FPS)		-385 mw

This 200+ mw power saving is very significant for mobile platform for
battery life and thermal reasons.

But as the workload demands more memory bandwidth, the memory frequency
will be increased very fast. There is no power savings for such busy
workloads.

For example:

Workload		Performance diff (%) from EPB 6 to 7
-------------------------------------------------------
Speedometer 2.0		-0.8
WebGL Aquarium 10K
Fish    		-0.5
Unity 3D 2018		0.2
WebXPRT3		-0.5

There are run to run variations for performance scores for
such busy workloads. So the difference is not significant.

Add a new define ENERGY_PERF_BIAS_NORMAL_POWERSAVE for EPB 7
and use it for Alder Lake-N and Raptor Lake-P mobile CPUs.

This modification is done originally by
Jeremy Compostella <jeremy.compostella@intel.com>.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Link: https://lore.kernel.org/all/20221027220056.1534264-1-srinivas.pandruvada%40linux.intel.com
---
 arch/x86/include/asm/msr-index.h | 1 +
 arch/x86/kernel/cpu/intel_epb.c  | 7 ++++++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 10ac527..a3eb4d3 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -796,6 +796,7 @@
 #define ENERGY_PERF_BIAS_PERFORMANCE		0
 #define ENERGY_PERF_BIAS_BALANCE_PERFORMANCE	4
 #define ENERGY_PERF_BIAS_NORMAL			6
+#define ENERGY_PERF_BIAS_NORMAL_POWERSAVE	7
 #define ENERGY_PERF_BIAS_BALANCE_POWERSAVE	8
 #define ENERGY_PERF_BIAS_POWERSAVE		15
 
diff --git a/arch/x86/kernel/cpu/intel_epb.c b/arch/x86/kernel/cpu/intel_epb.c
index fbaf12e..3b84761 100644
--- a/arch/x86/kernel/cpu/intel_epb.c
+++ b/arch/x86/kernel/cpu/intel_epb.c
@@ -204,7 +204,12 @@ static int intel_epb_offline(unsigned int cpu)
 }
 
 static const struct x86_cpu_id intel_epb_normal[] = {
-	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_L, 7),
+	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_L,
+				   ENERGY_PERF_BIAS_NORMAL_POWERSAVE),
+	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_N,
+				   ENERGY_PERF_BIAS_NORMAL_POWERSAVE),
+	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_P,
+				   ENERGY_PERF_BIAS_NORMAL_POWERSAVE),
 	{}
 };
 
