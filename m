Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4C7F6BE468
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 09:55:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230423AbjCQIzY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 04:55:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231246AbjCQIyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 04:54:44 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36C1B5F53D
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 01:54:30 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id cn6so4425688pjb.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 01:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679043270;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vWZWdC10+j0w099PHVi30w/+gmrDL8QwmxhzaXCQoR0=;
        b=G0eSCKG6h4Ta0yWiVyQxGKd4gahKP9atCBvxdpnTFEa6q7gHHYehISu+4FXrip7HXp
         TxcUYafO7oCk+WpjFS0cqRF/onquX1GPA+/9iccEiyu4cqrxoYqSByyU6+sUbo28GR/x
         nL/M/T7t/qtADwdZgxDU5/0ExpYa3a/UCO6tcEmSzq6hq0u9Vp9ow4PIMkfBCrUz5sxq
         CE6l6TgqNY/iRklHD/7x/oIl0JnhRzv8Xmh10c5PiRnRypBJkrI25CSKR3U82ja2/lkP
         v0LzU6jlUTCYjv5rlG7jpm4AO5m/ufGNWUR0U5K+GNGkmCzzWaUwEUcw7N1i1Xte0w+3
         Ta0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679043270;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vWZWdC10+j0w099PHVi30w/+gmrDL8QwmxhzaXCQoR0=;
        b=iYXBpG4SyfEPukf01h5fT2mKFVuvtYtCXnxqRGoPI/etenJLzQXLbs8qvz7BCRQhvQ
         RAFdNfNpvYwgFU5LvkNSu1DlpMgO+xsaytVhGXEnFcNByGJF2VMgrdGDEVVIdSAEQO4e
         TelWlEzGEX9mOCQcXNaR3mC+QW9Cg+YMtSPqlo1MUNqqBAxU1z4FdfnODk6Qt9SzYUL0
         fGKZas4P8LfLTOAddsYNRW0UTDdGvObhxdzyc43YXLHNR67251BRLXHl3o2K1cJ/aFpg
         hYX0Bhigf021yGiWYX6J0DE0U5Pw+Dv/8pJeH/vJgY8OPAO/2fYPQ2AubV34l5816eix
         4rZA==
X-Gm-Message-State: AO0yUKX0qOUwfrnJFmK80PK8U72TnIvcg92s7jgBvqI3G0oCWVVRA1Q1
        gEmVwRnrPPJZkfotgFwmY1M=
X-Google-Smtp-Source: AK7set/j5yldPNFCUzqcrOnlaHuuGsNgEn9kpyXtss8fB5ek9hQR2x95/1/uGTFj1t/F1DL3f5KMeA==
X-Received: by 2002:a17:903:18d:b0:19e:7f6f:8c32 with SMTP id z13-20020a170903018d00b0019e7f6f8c32mr8132652plg.48.1679043269923;
        Fri, 17 Mar 2023 01:54:29 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([104.28.245.204])
        by smtp.gmail.com with ESMTPSA id jh17-20020a170903329100b0019a96a6543esm1030775plb.184.2023.03.17.01.54.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 01:54:29 -0700 (PDT)
From:   David Yang <mmyangfl@gmail.com>
Cc:     David Yang <mmyangfl@gmail.com>, Wei Xu <xuwei5@hisilicon.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/4] ARM: hisi: Support Hi3798 SoC
Date:   Fri, 17 Mar 2023 16:53:46 +0800
Message-Id: <20230317085347.10147-4-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230317085347.10147-1-mmyangfl@gmail.com>
References: <20230317085347.10147-1-mmyangfl@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi3798 are SoC series for IPTV STB, with Cortex A9 or A7 cores.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 arch/arm/mach-hisi/Makefile  |   2 +-
 arch/arm/mach-hisi/core.h    |   7 ++
 arch/arm/mach-hisi/headsmp.S |  36 ++++++++++
 arch/arm/mach-hisi/hotplug.c | 128 +++++++++++++++++++++++++++++++++--
 arch/arm/mach-hisi/platsmp.c | 122 +++++++++++++++++++++++++++++++++
 5 files changed, 289 insertions(+), 6 deletions(-)
 create mode 100644 arch/arm/mach-hisi/headsmp.S

diff --git a/arch/arm/mach-hisi/Makefile b/arch/arm/mach-hisi/Makefile
index 39476355e..71e2f67cd 100644
--- a/arch/arm/mach-hisi/Makefile
+++ b/arch/arm/mach-hisi/Makefile
@@ -7,4 +7,4 @@ CFLAGS_platmcpm.o	:= -march=armv7-a
 
 obj-y	+= hisilicon.o
 obj-$(CONFIG_MCPM)		+= platmcpm.o
-obj-$(CONFIG_SMP)		+= platsmp.o hotplug.o
+obj-$(CONFIG_SMP)		+= headsmp.o platsmp.o hotplug.o
diff --git a/arch/arm/mach-hisi/core.h b/arch/arm/mach-hisi/core.h
index 61245274f..ebfc472e4 100644
--- a/arch/arm/mach-hisi/core.h
+++ b/arch/arm/mach-hisi/core.h
@@ -4,6 +4,9 @@
 
 #include <linux/reboot.h>
 
+extern volatile int hisi_pen_release;
+extern void hisi_secondary_startup(void);
+
 extern void hi3xxx_set_cpu_jump(int cpu, void *jump_addr);
 extern int hi3xxx_get_cpu_jump(int cpu);
 extern void secondary_startup(void);
@@ -16,4 +19,8 @@ extern void hix5hd2_set_cpu(int cpu, bool enable);
 extern void hix5hd2_cpu_die(unsigned int cpu);
 
 extern void hip01_set_cpu(int cpu, bool enable);
+
+extern void hi3798_set_cpu(int cpu, bool enable);
+extern void hi3798_cpu_die(unsigned int cpu);
+extern int hi3798_cpu_kill(unsigned int cpu);
 #endif
diff --git a/arch/arm/mach-hisi/headsmp.S b/arch/arm/mach-hisi/headsmp.S
new file mode 100644
index 000000000..67cfb584a
--- /dev/null
+++ b/arch/arm/mach-hisi/headsmp.S
@@ -0,0 +1,36 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ *  Copyright (c) 2003 ARM Limited
+ *  All Rights Reserved
+ */
+#include <linux/linkage.h>
+#include <linux/init.h>
+#include <asm/assembler.h>
+
+/*
+ * Hisilicon specific entry point for secondary CPUs. This provides
+ * a "holding pen" into which all secondary cores are held until we're
+ * ready for them to initialise.
+ */
+ENTRY(hisi_secondary_startup)
+ ARM_BE8(setend	be)
+	mrc	p15, 0, r0, c0, c0, 5
+	and	r0, r0, #15
+	adr	r4, 1f
+	ldmia	r4, {r5, r6}
+	sub	r4, r4, r5
+	add	r6, r6, r4
+pen:	ldr	r7, [r6]
+	cmp	r7, r0
+	bne	pen
+
+	/*
+	 * we've been released from the holding pen: secondary_stack
+	 * should now contain the SVC stack for this core
+	 */
+	b	secondary_startup
+
+	.align
+1:	.long	.
+	.long	hisi_pen_release
+ENDPROC(hisi_secondary_startup)
diff --git a/arch/arm/mach-hisi/hotplug.c b/arch/arm/mach-hisi/hotplug.c
index c51794141..da87ed5d2 100644
--- a/arch/arm/mach-hisi/hotplug.c
+++ b/arch/arm/mach-hisi/hotplug.c
@@ -55,7 +55,7 @@
 #define CPU0_SRST_REQ_EN		(1 << 0)
 
 #define HIX5HD2_PERI_CRG20		0x50
-#define CRG20_CPU1_RESET		(1 << 17)
+#define CRG20_ARM_SRST(i)		(1 << ((i) + 16))
 
 #define HIX5HD2_PERI_PMC0		0x1000
 #define PMC0_CPU1_WAIT_MTCOMS_ACK	(1 << 8)
@@ -65,6 +65,12 @@
 #define HIP01_PERI9                    0x50
 #define PERI9_CPU1_RESET               (1 << 1)
 
+#define HI3798_PERI_CRG18		0x48
+#define CRG18_CPU_SW_BEGIN		(1 << 10)
+#define HI3798_PERI_CRG20		0x50
+#define CRG20_ARM_POR_SRST(i)		(1 << ((i) + 12))
+#define CRG20_CLUSTER_DBG_SRST(i)	(1 << ((i) + 20))
+
 enum {
 	HI3620_CTRL,
 	ERROR_CTRL,
@@ -204,7 +210,7 @@ void hix5hd2_set_cpu(int cpu, bool enable)
 		writel_relaxed(val, ctrl_base + HIX5HD2_PERI_PMC0);
 		/* unreset */
 		val = readl_relaxed(ctrl_base + HIX5HD2_PERI_CRG20);
-		val &= ~CRG20_CPU1_RESET;
+		val &= ~CRG20_ARM_SRST(cpu);
 		writel_relaxed(val, ctrl_base + HIX5HD2_PERI_CRG20);
 	} else {
 		/* power down cpu1 */
@@ -212,10 +218,9 @@ void hix5hd2_set_cpu(int cpu, bool enable)
 		val |= PMC0_CPU1_PMC_ENABLE | PMC0_CPU1_POWERDOWN;
 		val &= ~PMC0_CPU1_WAIT_MTCOMS_ACK;
 		writel_relaxed(val, ctrl_base + HIX5HD2_PERI_PMC0);
-
 		/* reset */
 		val = readl_relaxed(ctrl_base + HIX5HD2_PERI_CRG20);
-		val |= CRG20_CPU1_RESET;
+		val |= CRG20_ARM_SRST(cpu);
 		writel_relaxed(val, ctrl_base + HIX5HD2_PERI_CRG20);
 	}
 }
@@ -248,6 +253,55 @@ void hip01_set_cpu(int cpu, bool enable)
 	}
 }
 
+void hi3798_set_cpu(int cpu, bool enable)
+{
+	u32 val;
+	u32 val_crg18;
+
+	if (!ctrl_base)
+		if (!hix5hd2_hotplug_init())
+			BUG();
+
+	if (enable) {
+		val_crg18 = readl_relaxed(ctrl_base + HI3798_PERI_CRG18);
+		/* select 400MHz */
+		val = 0x306;
+		writel_relaxed(val, ctrl_base + HI3798_PERI_CRG18);
+		val |= CRG18_CPU_SW_BEGIN;
+		writel_relaxed(val, ctrl_base + HI3798_PERI_CRG18);
+		/* unreset arm_por_srst_req */
+		val = readl_relaxed(ctrl_base + HI3798_PERI_CRG20);
+		val &= ~CRG20_ARM_POR_SRST(cpu);
+		writel_relaxed(val, ctrl_base + HI3798_PERI_CRG20);
+		/* unreset cluster_dbg_srst_req */
+		val = readl_relaxed(ctrl_base + HI3798_PERI_CRG20);
+		val &= ~CRG20_CLUSTER_DBG_SRST(cpu);
+		writel_relaxed(val, ctrl_base + HI3798_PERI_CRG20);
+		/* unreset */
+		val = readl_relaxed(ctrl_base + HI3798_PERI_CRG20);
+		val &= ~CRG20_ARM_SRST(cpu);
+		writel_relaxed(val, ctrl_base + HI3798_PERI_CRG20);
+		/* restore freq */
+		val = val_crg18 & ~CRG18_CPU_SW_BEGIN;
+		writel_relaxed(val, ctrl_base + HI3798_PERI_CRG18);
+		writel_relaxed(val_crg18, ctrl_base + HI3798_PERI_CRG18);
+	} else {
+		/* reset */
+		val = readl_relaxed(ctrl_base + HI3798_PERI_CRG20);
+		val |= CRG20_ARM_SRST(cpu);
+		writel_relaxed(val, ctrl_base + HI3798_PERI_CRG20);
+		/* reset cluster_dbg_srst_req */
+		val = readl_relaxed(ctrl_base + HI3798_PERI_CRG20);
+		val |= CRG20_CLUSTER_DBG_SRST(cpu);
+		writel_relaxed(val, ctrl_base + HI3798_PERI_CRG20);
+		/* reset arm_por_srst_req */
+		val = readl_relaxed(ctrl_base + HI3798_PERI_CRG20);
+		val |= CRG20_ARM_POR_SRST(cpu);
+		writel_relaxed(val, ctrl_base + HI3798_PERI_CRG20);
+	}
+}
+
+#ifdef CONFIG_HOTPLUG_CPU
 static inline void cpu_enter_lowpower(void)
 {
 	unsigned int v;
@@ -269,7 +323,45 @@ static inline void cpu_enter_lowpower(void)
 	  : "cc");
 }
 
-#ifdef CONFIG_HOTPLUG_CPU
+static inline void cpu_leave_lowpower(void)
+{
+	unsigned int v;
+
+	asm volatile(
+	"	mrc	p15, 0, %0, c1, c0, 0\n"
+	"	orr	%0, %0, #0x04\n"
+	"	mcr	p15, 0, %0, c1, c0, 0\n"
+	"	mrc	p15, 0, %0, c1, c0, 1\n"
+	"	orr	%0, %0, #0x20\n"
+	"	mcr	p15, 0, %0, c1, c0, 1\n"
+	  : "=&r" (v)
+	  :
+	  : "cc");
+}
+
+static inline void hisi_do_lowpower(unsigned int cpu, int *spurious)
+{
+	for (;;) {
+		wfi();
+
+		if (hisi_pen_release == cpu) {
+			/*
+			 * OK, proper wakeup, we're done
+			 */
+			break;
+		}
+
+		/*
+		 * Getting here, means that we have come out of WFI without
+		 * having been woken up - this shouldn't happen
+		 *
+		 * Just note it happening - when we're woken, we can report
+		 * its occurrence.
+		 */
+		(*spurious)++;
+	}
+}
+
 void hi3xxx_cpu_die(unsigned int cpu)
 {
 	cpu_enter_lowpower();
@@ -296,4 +388,30 @@ void hix5hd2_cpu_die(unsigned int cpu)
 	flush_cache_all();
 	hix5hd2_set_cpu(cpu, false);
 }
+
+void hi3798_cpu_die(unsigned int cpu)
+{
+	int spurious = 0;
+
+	/*
+	 * we're ready for shutdown now, so do it
+	 */
+	cpu_enter_lowpower();
+	hisi_do_lowpower(cpu, &spurious);
+
+	/*
+	 * bring this CPU back into the world of cache
+	 * coherency, and then restore interrupts
+	 */
+	cpu_leave_lowpower();
+
+	if (spurious)
+		pr_warn("CPU%u: %u spurious wakeup calls\n", cpu, spurious);
+}
+
+int hi3798_cpu_kill(unsigned int cpu)
+{
+	hi3798_set_cpu(cpu, false);
+	return 1;
+}
 #endif
diff --git a/arch/arm/mach-hisi/platsmp.c b/arch/arm/mach-hisi/platsmp.c
index 9ce93e0b6..512fb8dc1 100644
--- a/arch/arm/mach-hisi/platsmp.c
+++ b/arch/arm/mach-hisi/platsmp.c
@@ -20,6 +20,48 @@
 
 static void __iomem *ctrl_base;
 
+/*
+ * hisi_pen_release controls the release of CPUs from the holding
+ * pen in headsmp.S, which exists because we are not always able to
+ * control the release of individual CPUs from the board firmware.
+ */
+volatile int hisi_pen_release = -1;
+
+/*
+ * Write hisi_write_pen_release in a way that is guaranteed to be visible to
+ * all observers, irrespective of whether they're taking part in coherency
+ * or not.  This is necessary for the hotplug code to work reliably.
+ */
+static void hisi_write_pen_release(int val)
+{
+	hisi_pen_release = val;
+	smp_wmb();
+	sync_cache_w(&hisi_pen_release);
+}
+
+/*
+ * hisi_lock exists to avoid running the loops_per_jiffy delay loop
+ * calibrations on the secondary CPU while the requesting CPU is using
+ * the limited-bandwidth bus - which affects the calibration value.
+ */
+static DEFINE_RAW_SPINLOCK(hisi_lock);
+
+static void hisi_pen_secondary_init(unsigned int cpu)
+{
+	/*
+	 * let the primary processor know we're out of the
+	 * pen, then head off into the C entry point
+	 */
+	hisi_write_pen_release(-1);
+
+	/*
+	 * Synchronise with the boot thread.
+	 */
+	raw_spin_lock(&hisi_lock);
+	raw_spin_unlock(&hisi_lock);
+}
+
+
 void hi3xxx_set_cpu_jump(int cpu, void *jump_addr)
 {
 	cpu = cpu_logical_map(cpu);
@@ -182,6 +224,86 @@ static const struct smp_operations hip01_smp_ops __initconst = {
 	.smp_boot_secondary     = hip01_boot_secondary,
 };
 
+
+static void hi3798_smp_prepare_cpus(unsigned int max_cpus)
+{
+	unsigned int i;
+	unsigned int l2ctlr;
+	unsigned int ncores;
+
+	asm ("mrc p15, 1, %0, c9, c0, 2\n" : "=r" (l2ctlr));
+	ncores = ((l2ctlr >> 24) & 0x3) + 1;
+
+	pr_info("SMP: %u cores detected\n", ncores);
+	if (ncores > max_cpus) {
+		pr_warn("SMP: %u cores greater than maximum (%u), clipping\n",
+			ncores, max_cpus);
+		ncores = max_cpus;
+	}
+	for (i = 0; i < ncores; i++)
+		set_cpu_possible(i, true);
+
+	/* Put the boot address in this magic register */
+	hix5hd2_set_scu_boot_addr(HIX5HD2_BOOT_ADDRESS,
+				  __pa_symbol(hisi_secondary_startup));
+}
+
+static int hi3798_boot_secondary(unsigned int cpu, struct task_struct *idle)
+{
+	unsigned long timeout;
+
+	/*
+	 * Set synchronisation state between this boot processor
+	 * and the secondary one
+	 */
+	raw_spin_lock(&hisi_lock);
+
+	hi3798_set_cpu(cpu, true);
+
+	/*
+	 * This is really belt and braces; we hold unintended secondary
+	 * CPUs in the holding pen until we're ready for them.  However,
+	 * since we haven't sent them a soft interrupt, they shouldn't
+	 * be there.
+	 */
+	hisi_write_pen_release(cpu);
+
+	/*
+	 * Send the secondary CPU a soft interrupt, thereby causing
+	 * the boot monitor to read the system wide flags register,
+	 * and branch to the address found there.
+	 */
+	arch_send_wakeup_ipi_mask(cpumask_of(cpu));
+
+	timeout = jiffies + (1 * HZ);
+	while (time_before(jiffies, timeout)) {
+		smp_rmb();
+		if (hisi_pen_release == -1)
+			break;
+
+		udelay(10);
+	}
+
+	/*
+	 * now the secondary core is starting up let it run its
+	 * calibrations, then wait for it to finish
+	 */
+	raw_spin_unlock(&hisi_lock);
+
+	return hisi_pen_release != -1 ? -ENOSYS : 0;
+}
+
+static const struct smp_operations hi3798_smp_ops __initconst = {
+	.smp_prepare_cpus	= hi3798_smp_prepare_cpus,
+	.smp_secondary_init	= hisi_pen_secondary_init,
+	.smp_boot_secondary	= hi3798_boot_secondary,
+#ifdef CONFIG_HOTPLUG_CPU
+	.cpu_die		= hi3798_cpu_die,
+	.cpu_kill		= hi3798_cpu_kill,
+#endif
+};
+
 CPU_METHOD_OF_DECLARE(hi3xxx_smp, "hisilicon,hi3620-smp", &hi3xxx_smp_ops);
 CPU_METHOD_OF_DECLARE(hix5hd2_smp, "hisilicon,hix5hd2-smp", &hix5hd2_smp_ops);
 CPU_METHOD_OF_DECLARE(hip01_smp, "hisilicon,hip01-smp", &hip01_smp_ops);
+CPU_METHOD_OF_DECLARE(hi3798_smp, "hisilicon,hi3798-smp", &hi3798_smp_ops);
-- 
2.39.2

