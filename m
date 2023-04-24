Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0052A6D864B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 20:52:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234316AbjDESwP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 14:52:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjDESwN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 14:52:13 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3CBA5589;
        Wed,  5 Apr 2023 11:52:10 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 684DE1FE4B;
        Wed,  5 Apr 2023 18:52:09 +0000 (UTC)
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id C171F2C141;
        Wed,  5 Apr 2023 18:52:08 +0000 (UTC)
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     John Crispin <john@phrozen.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH] MIPS: Remove deprecated CONFIG_MIPS_CMP
Date:   Wed,  5 Apr 2023 20:51:27 +0200
Message-Id: <20230405185128.15237-1-tsbogend@alpha.franken.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=RCVD_IN_DNSWL_MED,SPF_FAIL,
        SPF_HELO_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 5cac93b35c14 ("MIPS: Deprecate CONFIG_MIPS_CMP") deprecated
CONFIG_MIPS_CMP and after 9 years it's time to remove it.

Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
---
Marc, if you prefer an extra patch for the irqchip change, I'll
split this. Otherwise I would take it through the MIPS tree.

 arch/mips/Kconfig                    |  34 +----
 arch/mips/include/asm/rtlx.h         |   1 -
 arch/mips/include/asm/smp-ops.h      |  16 ---
 arch/mips/include/asm/vpe.h          |   4 -
 arch/mips/kernel/Makefile            |   3 -
 arch/mips/kernel/rtlx-cmp.c          | 122 ------------------
 arch/mips/kernel/smp-cmp.c           | 148 ----------------------
 arch/mips/kernel/vpe-cmp.c           | 180 ---------------------------
 arch/mips/kernel/vpe.c               |   2 +-
 arch/mips/mti-malta/Makefile         |   2 -
 arch/mips/mti-malta/malta-amon.c     |  88 -------------
 arch/mips/mti-malta/malta-init.c     |   2 -
 arch/mips/mti-malta/malta-platform.c |   2 -
 arch/mips/ralink/mt7621.c            |   2 -
 drivers/irqchip/irq-mips-gic.c       |  26 ----
 15 files changed, 3 insertions(+), 629 deletions(-)
 delete mode 100644 arch/mips/kernel/rtlx-cmp.c
 delete mode 100644 arch/mips/kernel/smp-cmp.c
 delete mode 100644 arch/mips/kernel/vpe-cmp.c
 delete mode 100644 arch/mips/mti-malta/malta-amon.c

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index a975f140ae82..61fca312a2c5 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -568,7 +568,6 @@ config MIPS_MALTA
 	select SYS_SUPPORTS_LITTLE_ENDIAN
 	select SYS_SUPPORTS_MICROMIPS
 	select SYS_SUPPORTS_MIPS16
-	select SYS_SUPPORTS_MIPS_CMP
 	select SYS_SUPPORTS_MIPS_CPS
 	select SYS_SUPPORTS_MULTITHREADING
 	select SYS_SUPPORTS_RELOCATABLE
@@ -2270,15 +2269,10 @@ config MIPS_VPE_LOADER
 	  Includes a loader for loading an elf relocatable object
 	  onto another VPE and running it.
 
-config MIPS_VPE_LOADER_CMP
-	bool
-	default "y"
-	depends on MIPS_VPE_LOADER && MIPS_CMP
-
 config MIPS_VPE_LOADER_MT
 	bool
 	default "y"
-	depends on MIPS_VPE_LOADER && !MIPS_CMP
+	depends on MIPS_VPE_LOADER
 
 config MIPS_VPE_LOADER_TOM
 	bool "Load VPE program into memory hidden from linux"
@@ -2294,31 +2288,10 @@ config MIPS_VPE_APSP_API
 	bool "Enable support for AP/SP API (RTLX)"
 	depends on MIPS_VPE_LOADER
 
-config MIPS_VPE_APSP_API_CMP
-	bool
-	default "y"
-	depends on MIPS_VPE_APSP_API && MIPS_CMP
-
 config MIPS_VPE_APSP_API_MT
 	bool
 	default "y"
-	depends on MIPS_VPE_APSP_API && !MIPS_CMP
-
-config MIPS_CMP
-	bool "MIPS CMP framework support (DEPRECATED)"
-	depends on SYS_SUPPORTS_MIPS_CMP && !CPU_MIPSR6
-	select SMP
-	select SYNC_R4K
-	select SYS_SUPPORTS_SMP
-	select WEAK_ORDERING
-	default n
-	help
-	  Select this if you are using a bootloader which implements the "CMP
-	  framework" protocol (ie. YAMON) and want your kernel to make use of
-	  its ability to start secondary CPUs.
-
-	  Unless you have a specific need, you should use CONFIG_MIPS_CPS
-	  instead of this.
+	depends on MIPS_VPE_APSP_API
 
 config MIPS_CPS
 	bool "MIPS Coherent Processing System support"
@@ -2774,9 +2747,6 @@ config HOTPLUG_CPU
 config SMP_UP
 	bool
 
-config SYS_SUPPORTS_MIPS_CMP
-	bool
-
 config SYS_SUPPORTS_MIPS_CPS
 	bool
 
diff --git a/arch/mips/include/asm/rtlx.h b/arch/mips/include/asm/rtlx.h
index c1020654876e..a72785b4bbf4 100644
--- a/arch/mips/include/asm/rtlx.h
+++ b/arch/mips/include/asm/rtlx.h
@@ -81,7 +81,6 @@ struct rtlx_channel {
 extern struct rtlx_info {
 	unsigned long id;
 	enum rtlx_state state;
-	int ap_int_pending;	/* Status of 0 or 1 for CONFIG_MIPS_CMP only */
 
 	struct rtlx_channel channel[RTLX_CHANNELS];
 } *rtlx;
diff --git a/arch/mips/include/asm/smp-ops.h b/arch/mips/include/asm/smp-ops.h
index 864aea803984..0145bbfb5efb 100644
--- a/arch/mips/include/asm/smp-ops.h
+++ b/arch/mips/include/asm/smp-ops.h
@@ -80,22 +80,6 @@ static inline int register_up_smp_ops(void)
 #endif
 }
 
-static inline int register_cmp_smp_ops(void)
-{
-#ifdef CONFIG_MIPS_CMP
-	extern const struct plat_smp_ops cmp_smp_ops;
-
-	if (!mips_cm_present())
-		return -ENODEV;
-
-	register_smp_ops(&cmp_smp_ops);
-
-	return 0;
-#else
-	return -ENODEV;
-#endif
-}
-
 static inline int register_vsmp_smp_ops(void)
 {
 #ifdef CONFIG_MIPS_MT_SMP
diff --git a/arch/mips/include/asm/vpe.h b/arch/mips/include/asm/vpe.h
index ef7e07829607..61fd4d0aeda4 100644
--- a/arch/mips/include/asm/vpe.h
+++ b/arch/mips/include/asm/vpe.h
@@ -29,12 +29,8 @@
 
 static inline int aprp_cpu_index(void)
 {
-#ifdef CONFIG_MIPS_CMP
-	return setup_max_cpus;
-#else
 	extern int tclimit;
 	return tclimit;
-#endif
 }
 
 enum vpe_state {
diff --git a/arch/mips/kernel/Makefile b/arch/mips/kernel/Makefile
index 5d1addac5e28..853a43ee4b44 100644
--- a/arch/mips/kernel/Makefile
+++ b/arch/mips/kernel/Makefile
@@ -58,16 +58,13 @@ obj-$(CONFIG_CPU_BMIPS)		+= smp-bmips.o bmips_vec.o bmips_5xxx_init.o
 obj-$(CONFIG_MIPS_MT)		+= mips-mt.o
 obj-$(CONFIG_MIPS_MT_FPAFF)	+= mips-mt-fpaff.o
 obj-$(CONFIG_MIPS_MT_SMP)	+= smp-mt.o
-obj-$(CONFIG_MIPS_CMP)		+= smp-cmp.o
 obj-$(CONFIG_MIPS_CPS)		+= smp-cps.o cps-vec.o
 obj-$(CONFIG_MIPS_CPS_NS16550)	+= cps-vec-ns16550.o
 obj-$(CONFIG_MIPS_SPRAM)	+= spram.o
 
 obj-$(CONFIG_MIPS_VPE_LOADER)	+= vpe.o
-obj-$(CONFIG_MIPS_VPE_LOADER_CMP) += vpe-cmp.o
 obj-$(CONFIG_MIPS_VPE_LOADER_MT) += vpe-mt.o
 obj-$(CONFIG_MIPS_VPE_APSP_API) += rtlx.o
-obj-$(CONFIG_MIPS_VPE_APSP_API_CMP) += rtlx-cmp.o
 obj-$(CONFIG_MIPS_VPE_APSP_API_MT) += rtlx-mt.o
 
 obj-$(CONFIG_MIPS_MSC)		+= irq-msc01.o
diff --git a/arch/mips/kernel/rtlx-cmp.c b/arch/mips/kernel/rtlx-cmp.c
deleted file mode 100644
index d26dcc4b46e7..000000000000
--- a/arch/mips/kernel/rtlx-cmp.c
+++ /dev/null
@@ -1,122 +0,0 @@
-/*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * Copyright (C) 2005 MIPS Technologies, Inc.  All rights reserved.
- * Copyright (C) 2013 Imagination Technologies Ltd.
- */
-#include <linux/device.h>
-#include <linux/fs.h>
-#include <linux/err.h>
-#include <linux/wait.h>
-#include <linux/sched.h>
-#include <linux/smp.h>
-
-#include <asm/mips_mt.h>
-#include <asm/vpe.h>
-#include <asm/rtlx.h>
-
-static int major;
-
-static void rtlx_interrupt(void)
-{
-	int i;
-	struct rtlx_info *info;
-	struct rtlx_info **p = vpe_get_shared(aprp_cpu_index());
-
-	if (p == NULL || *p == NULL)
-		return;
-
-	info = *p;
-
-	if (info->ap_int_pending == 1 && smp_processor_id() == 0) {
-		for (i = 0; i < RTLX_CHANNELS; i++) {
-			wake_up(&channel_wqs[i].lx_queue);
-			wake_up(&channel_wqs[i].rt_queue);
-		}
-		info->ap_int_pending = 0;
-	}
-}
-
-void _interrupt_sp(void)
-{
-	smp_send_reschedule(aprp_cpu_index());
-}
-
-int __init rtlx_module_init(void)
-{
-	struct device *dev;
-	int i, err;
-
-	if (!cpu_has_mipsmt) {
-		pr_warn("VPE loader: not a MIPS MT capable processor\n");
-		return -ENODEV;
-	}
-
-	if (num_possible_cpus() - aprp_cpu_index() < 1) {
-		pr_warn("No TCs reserved for AP/SP, not initializing RTLX.\n"
-			"Pass maxcpus=<n> argument as kernel argument\n");
-
-		return -ENODEV;
-	}
-
-	major = register_chrdev(0, RTLX_MODULE_NAME, &rtlx_fops);
-	if (major < 0) {
-		pr_err("rtlx_module_init: unable to register device\n");
-		return major;
-	}
-
-	/* initialise the wait queues */
-	for (i = 0; i < RTLX_CHANNELS; i++) {
-		init_waitqueue_head(&channel_wqs[i].rt_queue);
-		init_waitqueue_head(&channel_wqs[i].lx_queue);
-		atomic_set(&channel_wqs[i].in_open, 0);
-		mutex_init(&channel_wqs[i].mutex);
-
-		dev = device_create(mt_class, NULL, MKDEV(major, i), NULL,
-				    "%s%d", RTLX_MODULE_NAME, i);
-		if (IS_ERR(dev)) {
-			while (i--)
-				device_destroy(mt_class, MKDEV(major, i));
-
-			err = PTR_ERR(dev);
-			goto out_chrdev;
-		}
-	}
-
-	/* set up notifiers */
-	rtlx_notify.start = rtlx_starting;
-	rtlx_notify.stop = rtlx_stopping;
-	vpe_notify(aprp_cpu_index(), &rtlx_notify);
-
-	if (cpu_has_vint) {
-		aprp_hook = rtlx_interrupt;
-	} else {
-		pr_err("APRP RTLX init on non-vectored-interrupt processor\n");
-		err = -ENODEV;
-		goto out_class;
-	}
-
-	return 0;
-
-out_class:
-	for (i = 0; i < RTLX_CHANNELS; i++)
-		device_destroy(mt_class, MKDEV(major, i));
-out_chrdev:
-	unregister_chrdev(major, RTLX_MODULE_NAME);
-
-	return err;
-}
-
-void __exit rtlx_module_exit(void)
-{
-	int i;
-
-	for (i = 0; i < RTLX_CHANNELS; i++)
-		device_destroy(mt_class, MKDEV(major, i));
-
-	unregister_chrdev(major, RTLX_MODULE_NAME);
-
-	aprp_hook = NULL;
-}
diff --git a/arch/mips/kernel/smp-cmp.c b/arch/mips/kernel/smp-cmp.c
deleted file mode 100644
index 76f5824cdb00..000000000000
--- a/arch/mips/kernel/smp-cmp.c
+++ /dev/null
@@ -1,148 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- *
- * Copyright (C) 2007 MIPS Technologies, Inc.
- *    Chris Dearman (chris@mips.com)
- */
-
-#undef DEBUG
-
-#include <linux/kernel.h>
-#include <linux/sched/task_stack.h>
-#include <linux/smp.h>
-#include <linux/cpumask.h>
-#include <linux/interrupt.h>
-#include <linux/compiler.h>
-
-#include <linux/atomic.h>
-#include <asm/cacheflush.h>
-#include <asm/cpu.h>
-#include <asm/processor.h>
-#include <asm/hardirq.h>
-#include <asm/mmu_context.h>
-#include <asm/smp.h>
-#include <asm/time.h>
-#include <asm/mipsregs.h>
-#include <asm/mipsmtregs.h>
-#include <asm/mips_mt.h>
-#include <asm/amon.h>
-
-static void cmp_init_secondary(void)
-{
-	struct cpuinfo_mips *c __maybe_unused = &current_cpu_data;
-
-	/* Assume GIC is present */
-	change_c0_status(ST0_IM, STATUSF_IP2 | STATUSF_IP3 | STATUSF_IP4 |
-				 STATUSF_IP5 | STATUSF_IP6 | STATUSF_IP7);
-
-	/* Enable per-cpu interrupts: platform specific */
-
-#ifdef CONFIG_MIPS_MT_SMP
-	if (cpu_has_mipsmt)
-		cpu_set_vpe_id(c, (read_c0_tcbind() >> TCBIND_CURVPE_SHIFT) &
-				  TCBIND_CURVPE);
-#endif
-}
-
-static void cmp_smp_finish(void)
-{
-	pr_debug("SMPCMP: CPU%d: %s\n", smp_processor_id(), __func__);
-
-	/* CDFIXME: remove this? */
-	write_c0_compare(read_c0_count() + (8 * mips_hpt_frequency / HZ));
-
-#ifdef CONFIG_MIPS_MT_FPAFF
-	/* If we have an FPU, enroll ourselves in the FPU-full mask */
-	if (cpu_has_fpu)
-		cpumask_set_cpu(smp_processor_id(), &mt_fpu_cpumask);
-#endif /* CONFIG_MIPS_MT_FPAFF */
-
-	local_irq_enable();
-}
-
-/*
- * Setup the PC, SP, and GP of a secondary processor and start it running
- * smp_bootstrap is the place to resume from
- * __KSTK_TOS(idle) is apparently the stack pointer
- * (unsigned long)idle->thread_info the gp
- */
-static int cmp_boot_secondary(int cpu, struct task_struct *idle)
-{
-	struct thread_info *gp = task_thread_info(idle);
-	unsigned long sp = __KSTK_TOS(idle);
-	unsigned long pc = (unsigned long)&smp_bootstrap;
-	unsigned long a0 = 0;
-
-	pr_debug("SMPCMP: CPU%d: %s cpu %d\n", smp_processor_id(),
-		__func__, cpu);
-
-#if 0
-	/* Needed? */
-	flush_icache_range((unsigned long)gp,
-			   (unsigned long)(gp + sizeof(struct thread_info)));
-#endif
-
-	amon_cpu_start(cpu, pc, sp, (unsigned long)gp, a0);
-	return 0;
-}
-
-/*
- * Common setup before any secondaries are started
- */
-void __init cmp_smp_setup(void)
-{
-	int i;
-	int ncpu = 0;
-
-	pr_debug("SMPCMP: CPU%d: %s\n", smp_processor_id(), __func__);
-
-#ifdef CONFIG_MIPS_MT_FPAFF
-	/* If we have an FPU, enroll ourselves in the FPU-full mask */
-	if (cpu_has_fpu)
-		cpumask_set_cpu(0, &mt_fpu_cpumask);
-#endif /* CONFIG_MIPS_MT_FPAFF */
-
-	for (i = 1; i < NR_CPUS; i++) {
-		if (amon_cpu_avail(i)) {
-			set_cpu_possible(i, true);
-			__cpu_number_map[i]	= ++ncpu;
-			__cpu_logical_map[ncpu] = i;
-		}
-	}
-
-	if (cpu_has_mipsmt) {
-		unsigned int nvpe = 1;
-#ifdef CONFIG_MIPS_MT_SMP
-		unsigned int mvpconf0 = read_c0_mvpconf0();
-
-		nvpe = ((mvpconf0 & MVPCONF0_PVPE) >> MVPCONF0_PVPE_SHIFT) + 1;
-#endif
-		smp_num_siblings = nvpe;
-	}
-	pr_info("Detected %i available secondary CPU(s)\n", ncpu);
-}
-
-void __init cmp_prepare_cpus(unsigned int max_cpus)
-{
-	pr_debug("SMPCMP: CPU%d: %s max_cpus=%d\n",
-		 smp_processor_id(), __func__, max_cpus);
-
-#ifdef CONFIG_MIPS_MT
-	/*
-	 * FIXME: some of these options are per-system, some per-core and
-	 * some per-cpu
-	 */
-	mips_mt_set_cpuoptions();
-#endif
-
-}
-
-const struct plat_smp_ops cmp_smp_ops = {
-	.send_ipi_single	= mips_smp_send_ipi_single,
-	.send_ipi_mask		= mips_smp_send_ipi_mask,
-	.init_secondary		= cmp_init_secondary,
-	.smp_finish		= cmp_smp_finish,
-	.boot_secondary		= cmp_boot_secondary,
-	.smp_setup		= cmp_smp_setup,
-	.prepare_cpus		= cmp_prepare_cpus,
-};
diff --git a/arch/mips/kernel/vpe-cmp.c b/arch/mips/kernel/vpe-cmp.c
deleted file mode 100644
index 92140edb3ce3..000000000000
--- a/arch/mips/kernel/vpe-cmp.c
+++ /dev/null
@@ -1,180 +0,0 @@
-/*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * Copyright (C) 2004, 2005 MIPS Technologies, Inc.  All rights reserved.
- * Copyright (C) 2013 Imagination Technologies Ltd.
- */
-#include <linux/kernel.h>
-#include <linux/device.h>
-#include <linux/fs.h>
-#include <linux/slab.h>
-#include <linux/export.h>
-
-#include <asm/vpe.h>
-
-static int major;
-
-void cleanup_tc(struct tc *tc)
-{
-
-}
-
-static ssize_t store_kill(struct device *dev, struct device_attribute *attr,
-			  const char *buf, size_t len)
-{
-	struct vpe *vpe = get_vpe(aprp_cpu_index());
-	struct vpe_notifications *notifier;
-
-	list_for_each_entry(notifier, &vpe->notify, list)
-		notifier->stop(aprp_cpu_index());
-
-	release_progmem(vpe->load_addr);
-	vpe->state = VPE_STATE_UNUSED;
-
-	return len;
-}
-static DEVICE_ATTR(kill, S_IWUSR, NULL, store_kill);
-
-static ssize_t ntcs_show(struct device *cd, struct device_attribute *attr,
-			 char *buf)
-{
-	struct vpe *vpe = get_vpe(aprp_cpu_index());
-
-	return sprintf(buf, "%d\n", vpe->ntcs);
-}
-
-static ssize_t ntcs_store(struct device *dev, struct device_attribute *attr,
-			  const char *buf, size_t len)
-{
-	struct vpe *vpe = get_vpe(aprp_cpu_index());
-	unsigned long new;
-	int ret;
-
-	ret = kstrtoul(buf, 0, &new);
-	if (ret < 0)
-		return ret;
-
-	/* APRP can only reserve one TC in a VPE and no more. */
-	if (new != 1)
-		return -EINVAL;
-
-	vpe->ntcs = new;
-
-	return len;
-}
-static DEVICE_ATTR_RW(ntcs);
-
-static struct attribute *vpe_attrs[] = {
-	&dev_attr_kill.attr,
-	&dev_attr_ntcs.attr,
-	NULL,
-};
-ATTRIBUTE_GROUPS(vpe);
-
-static void vpe_device_release(struct device *cd)
-{
-}
-
-static struct class vpe_class = {
-	.name = "vpe",
-	.owner = THIS_MODULE,
-	.dev_release = vpe_device_release,
-	.dev_groups = vpe_groups,
-};
-
-static struct device vpe_device;
-
-int __init vpe_module_init(void)
-{
-	struct vpe *v = NULL;
-	struct tc *t;
-	int err;
-
-	if (!cpu_has_mipsmt) {
-		pr_warn("VPE loader: not a MIPS MT capable processor\n");
-		return -ENODEV;
-	}
-
-	if (num_possible_cpus() - aprp_cpu_index() < 1) {
-		pr_warn("No VPEs reserved for AP/SP, not initialize VPE loader\n"
-			"Pass maxcpus=<n> argument as kernel argument\n");
-		return -ENODEV;
-	}
-
-	major = register_chrdev(0, VPE_MODULE_NAME, &vpe_fops);
-	if (major < 0) {
-		pr_warn("VPE loader: unable to register character device\n");
-		return major;
-	}
-
-	err = class_register(&vpe_class);
-	if (err) {
-		pr_err("vpe_class registration failed\n");
-		goto out_chrdev;
-	}
-
-	device_initialize(&vpe_device);
-	vpe_device.class	= &vpe_class;
-	vpe_device.parent	= NULL;
-	dev_set_name(&vpe_device, "vpe_sp");
-	vpe_device.devt = MKDEV(major, VPE_MODULE_MINOR);
-	err = device_add(&vpe_device);
-	if (err) {
-		pr_err("Adding vpe_device failed\n");
-		goto out_class;
-	}
-
-	t = alloc_tc(aprp_cpu_index());
-	if (!t) {
-		pr_warn("VPE: unable to allocate TC\n");
-		err = -ENOMEM;
-		goto out_dev;
-	}
-
-	/* VPE */
-	v = alloc_vpe(aprp_cpu_index());
-	if (v == NULL) {
-		pr_warn("VPE: unable to allocate VPE\n");
-		kfree(t);
-		err = -ENOMEM;
-		goto out_dev;
-	}
-
-	v->ntcs = 1;
-
-	/* add the tc to the list of this vpe's tc's. */
-	list_add(&t->tc, &v->tc);
-
-	/* TC */
-	t->pvpe = v;	/* set the parent vpe */
-
-	return 0;
-
-out_dev:
-	device_del(&vpe_device);
-
-out_class:
-	put_device(&vpe_device);
-	class_unregister(&vpe_class);
-
-out_chrdev:
-	unregister_chrdev(major, VPE_MODULE_NAME);
-
-	return err;
-}
-
-void __exit vpe_module_exit(void)
-{
-	struct vpe *v, *n;
-
-	device_unregister(&vpe_device);
-	class_unregister(&vpe_class);
-	unregister_chrdev(major, VPE_MODULE_NAME);
-
-	/* No locking needed here */
-	list_for_each_entry_safe(v, n, &vpecontrol.vpe_list, list)
-		if (v->state != VPE_STATE_UNUSED)
-			release_vpe(v);
-}
diff --git a/arch/mips/kernel/vpe.c b/arch/mips/kernel/vpe.c
index 13294972707b..343d2597ed76 100644
--- a/arch/mips/kernel/vpe.c
+++ b/arch/mips/kernel/vpe.c
@@ -795,7 +795,7 @@ static int vpe_open(struct inode *inode, struct file *filp)
 
 static int vpe_release(struct inode *inode, struct file *filp)
 {
-#if defined(CONFIG_MIPS_VPE_LOADER_MT) || defined(CONFIG_MIPS_VPE_LOADER_CMP)
+#ifdef CONFIG_MIPS_VPE_LOADER_MT
 	struct vpe *v;
 	Elf_Ehdr *hdr;
 	int ret = 0;
diff --git a/arch/mips/mti-malta/Makefile b/arch/mips/mti-malta/Makefile
index 13bbd12bfa65..bb2c706e11b0 100644
--- a/arch/mips/mti-malta/Makefile
+++ b/arch/mips/mti-malta/Makefile
@@ -14,6 +14,4 @@ obj-y				+= malta-platform.o
 obj-y				+= malta-setup.o
 obj-y				+= malta-time.o
 
-obj-$(CONFIG_MIPS_CMP)		+= malta-amon.o
-
 CFLAGS_malta-dtshim.o = -I$(src)/../../../scripts/dtc/libfdt
diff --git a/arch/mips/mti-malta/malta-amon.c b/arch/mips/mti-malta/malta-amon.c
deleted file mode 100644
index 84ac523b0ce0..000000000000
--- a/arch/mips/mti-malta/malta-amon.c
+++ /dev/null
@@ -1,88 +0,0 @@
-/*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * Copyright (C) 2007 MIPS Technologies, Inc.  All rights reserved.
- * Copyright (C) 2013 Imagination Technologies Ltd.
- *
- * Arbitrary Monitor Interface
- */
-#include <linux/kernel.h>
-#include <linux/smp.h>
-
-#include <asm/addrspace.h>
-#include <asm/mipsmtregs.h>
-#include <asm/mips-boards/launch.h>
-#include <asm/vpe.h>
-
-int amon_cpu_avail(int cpu)
-{
-	struct cpulaunch *launch = (struct cpulaunch *)CKSEG0ADDR(CPULAUNCH);
-
-	if (cpu < 0 || cpu >= NCPULAUNCH) {
-		pr_debug("avail: cpu%d is out of range\n", cpu);
-		return 0;
-	}
-
-	launch += cpu;
-	if (!(launch->flags & LAUNCH_FREADY)) {
-		pr_debug("avail: cpu%d is not ready\n", cpu);
-		return 0;
-	}
-	if (launch->flags & (LAUNCH_FGO|LAUNCH_FGONE)) {
-		pr_debug("avail: too late.. cpu%d is already gone\n", cpu);
-		return 0;
-	}
-
-	return 1;
-}
-
-int amon_cpu_start(int cpu,
-		    unsigned long pc, unsigned long sp,
-		    unsigned long gp, unsigned long a0)
-{
-	volatile struct cpulaunch *launch =
-		(struct cpulaunch  *)CKSEG0ADDR(CPULAUNCH);
-
-	if (!amon_cpu_avail(cpu))
-		return -1;
-	if (cpu == smp_processor_id()) {
-		pr_debug("launch: I am cpu%d!\n", cpu);
-		return -1;
-	}
-	launch += cpu;
-
-	pr_debug("launch: starting cpu%d\n", cpu);
-
-	launch->pc = pc;
-	launch->gp = gp;
-	launch->sp = sp;
-	launch->a0 = a0;
-
-	smp_wmb();		/* Target must see parameters before go */
-	launch->flags |= LAUNCH_FGO;
-	smp_wmb();		/* Target must see go before we poll  */
-
-	while ((launch->flags & LAUNCH_FGONE) == 0)
-		;
-	smp_rmb();	/* Target will be updating flags soon */
-	pr_debug("launch: cpu%d gone!\n", cpu);
-
-	return 0;
-}
-
-#ifdef CONFIG_MIPS_VPE_LOADER_CMP
-int vpe_run(struct vpe *v)
-{
-	struct vpe_notifications *n;
-
-	if (amon_cpu_start(aprp_cpu_index(), v->__start, 0, 0, 0) < 0)
-		return -1;
-
-	list_for_each_entry(n, &v->notify, list)
-		n->start(VPE_MODULE_MINOR);
-
-	return 0;
-}
-#endif
diff --git a/arch/mips/mti-malta/malta-init.c b/arch/mips/mti-malta/malta-init.c
index b03cac5fdc02..000d6d50520a 100644
--- a/arch/mips/mti-malta/malta-init.c
+++ b/arch/mips/mti-malta/malta-init.c
@@ -289,8 +289,6 @@ void __init prom_init(void)
 
 	if (!register_cps_smp_ops())
 		return;
-	if (!register_cmp_smp_ops())
-		return;
 	if (!register_vsmp_smp_ops())
 		return;
 	register_up_smp_ops();
diff --git a/arch/mips/mti-malta/malta-platform.c b/arch/mips/mti-malta/malta-platform.c
index 4ffbcc58c6f6..6961a23aefe9 100644
--- a/arch/mips/mti-malta/malta-platform.c
+++ b/arch/mips/mti-malta/malta-platform.c
@@ -43,7 +43,6 @@
 static struct plat_serial8250_port uart8250_data[] = {
 	SMC_PORT(0x3F8, 4),
 	SMC_PORT(0x2F8, 3),
-#ifndef CONFIG_MIPS_CMP
 	{
 		.mapbase	= 0x1f000900,	/* The CBUS UART */
 		.irq		= MIPS_CPU_IRQ_BASE + MIPSCPU_INT_MB2,
@@ -53,7 +52,6 @@ static struct plat_serial8250_port uart8250_data[] = {
 		.flags		= CBUS_UART_FLAGS,
 		.regshift	= 3,
 	},
-#endif
 	{ },
 };
 
diff --git a/arch/mips/ralink/mt7621.c b/arch/mips/ralink/mt7621.c
index bbf5811afbf2..c3fbab50b95c 100644
--- a/arch/mips/ralink/mt7621.c
+++ b/arch/mips/ralink/mt7621.c
@@ -217,8 +217,6 @@ void __init prom_soc_init(struct ralink_soc_info *soc_info)
 
 	if (!register_cps_smp_ops())
 		return;
-	if (!register_cmp_smp_ops())
-		return;
 	if (!register_vsmp_smp_ops())
 		return;
 }
diff --git a/drivers/irqchip/irq-mips-gic.c b/drivers/irqchip/irq-mips-gic.c
index 1a6a7a672ad7..046c355e120b 100644
--- a/drivers/irqchip/irq-mips-gic.c
+++ b/drivers/irqchip/irq-mips-gic.c
@@ -54,7 +54,6 @@ static DEFINE_SPINLOCK(gic_lock);
 static struct irq_domain *gic_irq_domain;
 static int gic_shared_intrs;
 static unsigned int gic_cpu_pin;
-static unsigned int timer_cpu_pin;
 static struct irq_chip gic_level_irq_controller, gic_edge_irq_controller;
 
 #ifdef CONFIG_GENERIC_IRQ_IPI
@@ -499,9 +498,6 @@ static int gic_irq_domain_map(struct irq_domain *d, unsigned int virq,
 	 */
 	switch (intr) {
 	case GIC_LOCAL_INT_TIMER:
-		/* CONFIG_MIPS_CMP workaround (see __gic_init) */
-		map = GIC_MAP_PIN_MAP_TO_PIN | timer_cpu_pin;
-		fallthrough;
 	case GIC_LOCAL_INT_PERFCTR:
 	case GIC_LOCAL_INT_FDC:
 		/*
@@ -795,34 +791,12 @@ static int __init gic_of_init(struct device_node *node,
 	if (cpu_has_veic) {
 		/* Always use vector 1 in EIC mode */
 		gic_cpu_pin = 0;
-		timer_cpu_pin = gic_cpu_pin;
 		set_vi_handler(gic_cpu_pin + GIC_PIN_TO_VEC_OFFSET,
 			       __gic_irq_dispatch);
 	} else {
 		gic_cpu_pin = cpu_vec - GIC_CPU_PIN_OFFSET;
 		irq_set_chained_handler(MIPS_CPU_IRQ_BASE + cpu_vec,
 					gic_irq_dispatch);
-		/*
-		 * With the CMP implementation of SMP (deprecated), other CPUs
-		 * are started by the bootloader and put into a timer based
-		 * waiting poll loop. We must not re-route those CPU's local
-		 * timer interrupts as the wait instruction will never finish,
-		 * so just handle whatever CPU interrupt it is routed to by
-		 * default.
-		 *
-		 * This workaround should be removed when CMP support is
-		 * dropped.
-		 */
-		if (IS_ENABLED(CONFIG_MIPS_CMP) &&
-		    gic_local_irq_is_routable(GIC_LOCAL_INT_TIMER)) {
-			timer_cpu_pin = read_gic_vl_timer_map() & GIC_MAP_PIN_MAP;
-			irq_set_chained_handler(MIPS_CPU_IRQ_BASE +
-						GIC_CPU_PIN_OFFSET +
-						timer_cpu_pin,
-						gic_irq_dispatch);
-		} else {
-			timer_cpu_pin = gic_cpu_pin;
-		}
 	}
 
 	gic_irq_domain = irq_domain_add_simple(node, GIC_NUM_LOCAL_INTRS +
-- 
2.35.3

