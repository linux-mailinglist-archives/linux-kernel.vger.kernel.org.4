Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2866669710
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 13:33:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241289AbjAMMcv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 07:32:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240979AbjAMMcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 07:32:07 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 144DE43D8E;
        Fri, 13 Jan 2023 04:31:07 -0800 (PST)
Date:   Fri, 13 Jan 2023 12:31:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1673613065;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YrVSD9mvSByVVVJgGZwGXLjs6fL/wAq3WD+FK1aXvxc=;
        b=m2mYYYxM06RIm00g1vKQ/BmmmWa7Qlmk4gqimC/tlLnsLZ1+lVxPlDSKbUhFftmMDYb8yL
        lzBfUNAtF73r1tpsI/PxnZX2ByqOB42EUstNtSPkWnVrYz4guu4c+nkjJEHov5cQw9zqIn
        OqYmkHkXeGoLBGW87GAcjJXDxGrqXH+w66tJtcINotCSvkA/Gj1Fx7U6bGUG51zCEVhHRU
        s/mzX6yBX/RA/hFFM0/SVUFWKc+EXNR9kJ9QRZfpieukqWGfJWgBvTHtD/tSU7ApZkTs4t
        839OIR7few+V9t2eH1KLtS9oOYdI/VfmnI5deZroQ3wRf/6ZUVtYzW+rjK24xg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1673613065;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YrVSD9mvSByVVVJgGZwGXLjs6fL/wAq3WD+FK1aXvxc=;
        b=q9RjxWBKb4LzTtOCy/6Xl1x0tAdzRuFjwdfrIe10rpJh1TUnubJetJcpSbL5LU6SxucDNc
        /XemTrooK90VtDDQ==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] cpuidle,arch: Mark all regular cpuidle_state::
 Enter methods __cpuidle
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230112195542.335211484@infradead.org>
References: <20230112195542.335211484@infradead.org>
MIME-Version: 1.0
Message-ID: <167361306530.4906.577388410385763862.tip-bot2@tip-bot2>
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

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     26388a7c353f7b1d3fd8a6df6452fa9773193155
Gitweb:        https://git.kernel.org/tip/26388a7c353f7b1d3fd8a6df6452fa9773193155
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 12 Jan 2023 20:44:03 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 13 Jan 2023 11:48:18 +01:00

cpuidle,arch: Mark all regular cpuidle_state:: Enter methods __cpuidle

For all cpuidle drivers that do not use CPUIDLE_FLAG_RCU_IDLE (iow,
the simple ones) make sure all the functions are marked __cpuidle.

( due to lack of noinstr validation on these platforms it is entirely
  possible this isn't complete )

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20230112195542.335211484@infradead.org
---
 arch/arm/kernel/cpuidle.c           | 4 ++--
 arch/arm/mach-davinci/cpuidle.c     | 4 ++--
 arch/arm/mach-imx/cpuidle-imx5.c    | 4 ++--
 arch/arm/mach-imx/cpuidle-imx6sl.c  | 4 ++--
 arch/arm/mach-imx/cpuidle-imx7ulp.c | 4 ++--
 arch/arm/mach-s3c/cpuidle-s3c64xx.c | 5 ++---
 arch/mips/kernel/idle.c             | 6 +++---
 7 files changed, 15 insertions(+), 16 deletions(-)

diff --git a/arch/arm/kernel/cpuidle.c b/arch/arm/kernel/cpuidle.c
index e168462..437ff39 100644
--- a/arch/arm/kernel/cpuidle.c
+++ b/arch/arm/kernel/cpuidle.c
@@ -26,8 +26,8 @@ static struct cpuidle_ops cpuidle_ops[NR_CPUS] __ro_after_init;
  *
  * Returns the index passed as parameter
  */
-int arm_cpuidle_simple_enter(struct cpuidle_device *dev,
-		struct cpuidle_driver *drv, int index)
+__cpuidle int arm_cpuidle_simple_enter(struct cpuidle_device *dev, struct
+				       cpuidle_driver *drv, int index)
 {
 	cpu_do_idle();
 
diff --git a/arch/arm/mach-davinci/cpuidle.c b/arch/arm/mach-davinci/cpuidle.c
index dd38785..78a1575 100644
--- a/arch/arm/mach-davinci/cpuidle.c
+++ b/arch/arm/mach-davinci/cpuidle.c
@@ -44,8 +44,8 @@ static void davinci_save_ddr_power(int enter, bool pdown)
 }
 
 /* Actual code that puts the SoC in different idle states */
-static int davinci_enter_idle(struct cpuidle_device *dev,
-			      struct cpuidle_driver *drv, int index)
+static __cpuidle int davinci_enter_idle(struct cpuidle_device *dev,
+					struct cpuidle_driver *drv, int index)
 {
 	davinci_save_ddr_power(1, ddr2_pdown);
 	cpu_do_idle();
diff --git a/arch/arm/mach-imx/cpuidle-imx5.c b/arch/arm/mach-imx/cpuidle-imx5.c
index a8457c4..5ad9f2f 100644
--- a/arch/arm/mach-imx/cpuidle-imx5.c
+++ b/arch/arm/mach-imx/cpuidle-imx5.c
@@ -8,8 +8,8 @@
 #include <asm/system_misc.h>
 #include "cpuidle.h"
 
-static int imx5_cpuidle_enter(struct cpuidle_device *dev,
-			      struct cpuidle_driver *drv, int index)
+static __cpuidle int imx5_cpuidle_enter(struct cpuidle_device *dev,
+					struct cpuidle_driver *drv, int index)
 {
 	arm_pm_idle();
 	return index;
diff --git a/arch/arm/mach-imx/cpuidle-imx6sl.c b/arch/arm/mach-imx/cpuidle-imx6sl.c
index b86ffbe..b49cd63 100644
--- a/arch/arm/mach-imx/cpuidle-imx6sl.c
+++ b/arch/arm/mach-imx/cpuidle-imx6sl.c
@@ -11,8 +11,8 @@
 #include "common.h"
 #include "cpuidle.h"
 
-static int imx6sl_enter_wait(struct cpuidle_device *dev,
-			    struct cpuidle_driver *drv, int index)
+static __cpuidle int imx6sl_enter_wait(struct cpuidle_device *dev,
+				       struct cpuidle_driver *drv, int index)
 {
 	imx6_set_lpm(WAIT_UNCLOCKED);
 	/*
diff --git a/arch/arm/mach-imx/cpuidle-imx7ulp.c b/arch/arm/mach-imx/cpuidle-imx7ulp.c
index ca86c96..f55ed74 100644
--- a/arch/arm/mach-imx/cpuidle-imx7ulp.c
+++ b/arch/arm/mach-imx/cpuidle-imx7ulp.c
@@ -12,8 +12,8 @@
 #include "common.h"
 #include "cpuidle.h"
 
-static int imx7ulp_enter_wait(struct cpuidle_device *dev,
-			    struct cpuidle_driver *drv, int index)
+static __cpuidle int imx7ulp_enter_wait(struct cpuidle_device *dev,
+					struct cpuidle_driver *drv, int index)
 {
 	if (index == 1)
 		imx7ulp_set_lpm(ULP_PM_WAIT);
diff --git a/arch/arm/mach-s3c/cpuidle-s3c64xx.c b/arch/arm/mach-s3c/cpuidle-s3c64xx.c
index b1c5f43..27a13cc 100644
--- a/arch/arm/mach-s3c/cpuidle-s3c64xx.c
+++ b/arch/arm/mach-s3c/cpuidle-s3c64xx.c
@@ -19,9 +19,8 @@
 #include "regs-sys-s3c64xx.h"
 #include "regs-syscon-power-s3c64xx.h"
 
-static int s3c64xx_enter_idle(struct cpuidle_device *dev,
-			      struct cpuidle_driver *drv,
-			      int index)
+static __cpuidle int s3c64xx_enter_idle(struct cpuidle_device *dev,
+					struct cpuidle_driver *drv, int index)
 {
 	unsigned long tmp;
 
diff --git a/arch/mips/kernel/idle.c b/arch/mips/kernel/idle.c
index 3e7ccdd..5abc8b7 100644
--- a/arch/mips/kernel/idle.c
+++ b/arch/mips/kernel/idle.c
@@ -241,7 +241,7 @@ void __init check_wait(void)
 	}
 }
 
-void arch_cpu_idle(void)
+__cpuidle void arch_cpu_idle(void)
 {
 	if (cpu_wait)
 		cpu_wait();
@@ -249,8 +249,8 @@ void arch_cpu_idle(void)
 
 #ifdef CONFIG_CPU_IDLE
 
-int mips_cpuidle_wait_enter(struct cpuidle_device *dev,
-			    struct cpuidle_driver *drv, int index)
+__cpuidle int mips_cpuidle_wait_enter(struct cpuidle_device *dev,
+				      struct cpuidle_driver *drv, int index)
 {
 	arch_cpu_idle();
 	return index;
