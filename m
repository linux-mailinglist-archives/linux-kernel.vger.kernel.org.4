Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3299770675F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 14:00:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231341AbjEQMAa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 08:00:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230188AbjEQMA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 08:00:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16FCF527D;
        Wed, 17 May 2023 05:00:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BCB73638AE;
        Wed, 17 May 2023 12:00:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20B9AC433D2;
        Wed, 17 May 2023 11:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684324801;
        bh=1dfCPAIR57vkTBiJ2tbGMgsIfCm/ySBnKPaxwyFsyQM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d5rK0rO2Dhm9A/KIDGT3yc+4CJq+GzpCoUB0wiU8fa9b1uxV0YUubmBFKvoRHrV0u
         AF1G5VcQITrnfCTC5xMEjPnRocIQCIOX7aJszPBWZ4fbbikXPvlNBGDErdy5btiZNe
         XfElz6xMJqXS1xnlqSY5Dxwh2F9mdeohyGHEEgUE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 4.19.283
Date:   Wed, 17 May 2023 13:59:50 +0200
Message-Id: <2023051748-spyglass-estranged-d8dd@gregkh>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <2023051748-bridged-shortcut-c52b@gregkh>
References: <2023051748-bridged-shortcut-c52b@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

diff --git a/Documentation/media/uapi/v4l/subdev-formats.rst b/Documentation/media/uapi/v4l/subdev-formats.rst
index 8e73fcfc6900..cc2ad8af51ea 100644
--- a/Documentation/media/uapi/v4l/subdev-formats.rst
+++ b/Documentation/media/uapi/v4l/subdev-formats.rst
@@ -7565,3 +7565,30 @@ formats.
       - 0x5001
       - Interleaved raw UYVY and JPEG image format with embedded meta-data
 	used by Samsung S3C73MX camera sensors.
+
+.. _v4l2-mbus-metadata-fmts:
+
+Metadata Formats
+^^^^^^^^^^^^^^^^
+
+This section lists all metadata formats.
+
+The following table lists the existing metadata formats.
+
+.. tabularcolumns:: |p{8.0cm}|p{1.4cm}|p{7.7cm}|
+
+.. flat-table:: Metadata formats
+    :header-rows:  1
+    :stub-columns: 0
+
+    * - Identifier
+      - Code
+      - Comments
+    * .. _MEDIA-BUS-FMT-METADATA-FIXED:
+
+      - MEDIA_BUS_FMT_METADATA_FIXED
+      - 0x7001
+      - This format should be used when the same driver handles
+	both sides of the link and the bus format is a fixed
+	metadata format that is not configurable from userspace.
+	Width and height will be set to 0 for this format.
diff --git a/Makefile b/Makefile
index 6ed7f3fe3a4e..71416fde7348 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 4
 PATCHLEVEL = 19
-SUBLEVEL = 282
+SUBLEVEL = 283
 EXTRAVERSION =
 NAME = "People's Front"
 
diff --git a/arch/arm/boot/dts/exynos4412-itop-elite.dts b/arch/arm/boot/dts/exynos4412-itop-elite.dts
index 0dedeba89b5f..d2350561b051 100644
--- a/arch/arm/boot/dts/exynos4412-itop-elite.dts
+++ b/arch/arm/boot/dts/exynos4412-itop-elite.dts
@@ -184,7 +184,7 @@
 		compatible = "wlf,wm8960";
 		reg = <0x1a>;
 		clocks = <&pmu_system_controller 0>;
-		clock-names = "MCLK1";
+		clock-names = "mclk";
 		wlf,shared-lrclk;
 		#sound-dai-cells = <0>;
 	};
diff --git a/arch/arm/boot/dts/qcom-ipq4019.dtsi b/arch/arm/boot/dts/qcom-ipq4019.dtsi
index 59527bb1225a..cb90e7645d08 100644
--- a/arch/arm/boot/dts/qcom-ipq4019.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq4019.dtsi
@@ -387,8 +387,8 @@
 			#address-cells = <3>;
 			#size-cells = <2>;
 
-			ranges = <0x81000000 0 0x40200000 0x40200000 0 0x00100000>,
-				 <0x82000000 0 0x40300000 0x40300000 0 0x00d00000>;
+			ranges = <0x81000000 0x0 0x00000000 0x40200000 0x0 0x00100000>,
+				 <0x82000000 0x0 0x40300000 0x40300000 0x0 0x00d00000>;
 
 			interrupts = <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "msi";
diff --git a/arch/arm/boot/dts/s5pv210.dtsi b/arch/arm/boot/dts/s5pv210.dtsi
index 020a864623ff..781ddfdc5f87 100644
--- a/arch/arm/boot/dts/s5pv210.dtsi
+++ b/arch/arm/boot/dts/s5pv210.dtsi
@@ -560,7 +560,7 @@
 				interrupts = <29>;
 				clocks = <&clocks CLK_CSIS>,
 						<&clocks SCLK_CSIS>;
-				clock-names = "clk_csis",
+				clock-names = "csis",
 						"sclk_csis";
 				bus-width = <4>;
 				status = "disabled";
diff --git a/arch/arm64/include/asm/debug-monitors.h b/arch/arm64/include/asm/debug-monitors.h
index 41b065f1be88..13630e8078ff 100644
--- a/arch/arm64/include/asm/debug-monitors.h
+++ b/arch/arm64/include/asm/debug-monitors.h
@@ -125,6 +125,7 @@ void user_regs_reset_single_step(struct user_pt_regs *regs,
 void kernel_enable_single_step(struct pt_regs *regs);
 void kernel_disable_single_step(void);
 int kernel_active_single_step(void);
+void kernel_rewind_single_step(struct pt_regs *regs);
 
 #ifdef CONFIG_HAVE_HW_BREAKPOINT
 int reinstall_suspended_bps(struct pt_regs *regs);
diff --git a/arch/arm64/kernel/debug-monitors.c b/arch/arm64/kernel/debug-monitors.c
index 501e835c6500..f5837937cd93 100644
--- a/arch/arm64/kernel/debug-monitors.c
+++ b/arch/arm64/kernel/debug-monitors.c
@@ -437,6 +437,11 @@ int kernel_active_single_step(void)
 }
 NOKPROBE_SYMBOL(kernel_active_single_step);
 
+void kernel_rewind_single_step(struct pt_regs *regs)
+{
+	set_regs_spsr_ss(regs);
+}
+
 /* ptrace API */
 void user_enable_single_step(struct task_struct *task)
 {
diff --git a/arch/arm64/kernel/kgdb.c b/arch/arm64/kernel/kgdb.c
index 8815b5457dd0..d7847ef10e9d 100644
--- a/arch/arm64/kernel/kgdb.c
+++ b/arch/arm64/kernel/kgdb.c
@@ -234,6 +234,8 @@ int kgdb_arch_handle_exception(int exception_vector, int signo,
 		 */
 		if (!kernel_active_single_step())
 			kernel_enable_single_step(linux_regs);
+		else
+			kernel_rewind_single_step(linux_regs);
 		err = 0;
 		break;
 	default:
diff --git a/arch/ia64/kernel/salinfo.c b/arch/ia64/kernel/salinfo.c
index aba1f463a8dd..b889db4492c8 100644
--- a/arch/ia64/kernel/salinfo.c
+++ b/arch/ia64/kernel/salinfo.c
@@ -580,7 +580,7 @@ static int salinfo_cpu_pre_down(unsigned int cpu)
  * 'data' contains an integer that corresponds to the feature we're
  * testing
  */
-static int proc_salinfo_show(struct seq_file *m, void *v)
+static int __maybe_unused proc_salinfo_show(struct seq_file *m, void *v)
 {
 	unsigned long data = (unsigned long)v;
 	seq_puts(m, (sal_platform_features & data) ? "1\n" : "0\n");
diff --git a/arch/ia64/mm/contig.c b/arch/ia64/mm/contig.c
index e2e40bbd391c..18a2b105f7f3 100644
--- a/arch/ia64/mm/contig.c
+++ b/arch/ia64/mm/contig.c
@@ -82,7 +82,7 @@ void *per_cpu_init(void)
 	return __per_cpu_start + __per_cpu_offset[smp_processor_id()];
 }
 
-static inline void
+static inline __init void
 alloc_per_cpu_data(void)
 {
 	cpu_data = __alloc_bootmem(PERCPU_PAGE_SIZE * num_possible_cpus(),
diff --git a/arch/mips/fw/lib/cmdline.c b/arch/mips/fw/lib/cmdline.c
index 6ecda64ad184..ed88abc40513 100644
--- a/arch/mips/fw/lib/cmdline.c
+++ b/arch/mips/fw/lib/cmdline.c
@@ -51,7 +51,7 @@ char *fw_getenv(char *envname)
 {
 	char *result = NULL;
 
-	if (_fw_envp != NULL) {
+	if (_fw_envp != NULL && fw_envp(0) != NULL) {
 		/*
 		 * Return a pointer to the given environment variable.
 		 * YAMON uses "name", "value" pairs, while U-Boot uses
diff --git a/arch/openrisc/kernel/entry.S b/arch/openrisc/kernel/entry.S
index c2c3ce8a0f84..7b408d67f11e 100644
--- a/arch/openrisc/kernel/entry.S
+++ b/arch/openrisc/kernel/entry.S
@@ -177,7 +177,6 @@ handler:							;\
 	l.sw    PT_GPR28(r1),r28					;\
 	l.sw    PT_GPR29(r1),r29					;\
 	/* r30 already save */					;\
-/*        l.sw    PT_GPR30(r1),r30*/					;\
 	l.sw    PT_GPR31(r1),r31					;\
 	TRACE_IRQS_OFF_ENTRY						;\
 	/* Store -1 in orig_gpr11 for non-syscall exceptions */	;\
@@ -215,9 +214,8 @@ handler:							;\
 	l.sw    PT_GPR27(r1),r27					;\
 	l.sw    PT_GPR28(r1),r28					;\
 	l.sw    PT_GPR29(r1),r29					;\
-	/* r31 already saved */					;\
-	l.sw    PT_GPR30(r1),r30					;\
-/*        l.sw    PT_GPR31(r1),r31	*/				;\
+	/* r30 already saved */						;\
+	l.sw    PT_GPR31(r1),r31					;\
 	/* Store -1 in orig_gpr11 for non-syscall exceptions */	;\
 	l.addi	r30,r0,-1					;\
 	l.sw	PT_ORIG_GPR11(r1),r30				;\
diff --git a/arch/parisc/kernel/real2.S b/arch/parisc/kernel/real2.S
index 2b16d8d6598f..c37010a13586 100644
--- a/arch/parisc/kernel/real2.S
+++ b/arch/parisc/kernel/real2.S
@@ -248,9 +248,6 @@ ENTRY_CFI(real64_call_asm)
 	/* save fn */
 	copy	%arg2, %r31
 
-	/* set up the new ap */
-	ldo	64(%arg1), %r29
-
 	/* load up the arg registers from the saved arg area */
 	/* 32-bit calling convention passes first 4 args in registers */
 	ldd	0*REG_SZ(%arg1), %arg0		/* note overwriting arg0 */
@@ -262,7 +259,9 @@ ENTRY_CFI(real64_call_asm)
 	ldd	7*REG_SZ(%arg1), %r19
 	ldd	1*REG_SZ(%arg1), %arg1		/* do this one last! */
 
+	/* set up real-mode stack and real-mode ap */
 	tophys_r1 %sp
+	ldo	-16(%sp), %r29			/* Reference param save area */
 
 	b,l	rfi_virt2real,%r2
 	nop
diff --git a/arch/powerpc/kernel/rtas.c b/arch/powerpc/kernel/rtas.c
index 7c7648e6f1c2..2646dd54eb0b 100644
--- a/arch/powerpc/kernel/rtas.c
+++ b/arch/powerpc/kernel/rtas.c
@@ -401,7 +401,7 @@ static char *__fetch_rtas_last_error(char *altbuf)
 				buf = kmalloc(RTAS_ERROR_LOG_MAX, GFP_ATOMIC);
 		}
 		if (buf)
-			memcpy(buf, rtas_err_buf, RTAS_ERROR_LOG_MAX);
+			memmove(buf, rtas_err_buf, RTAS_ERROR_LOG_MAX);
 	}
 
 	return buf;
diff --git a/arch/powerpc/platforms/512x/clock-commonclk.c b/arch/powerpc/platforms/512x/clock-commonclk.c
index b3097fe6441b..1019d78e44bb 100644
--- a/arch/powerpc/platforms/512x/clock-commonclk.c
+++ b/arch/powerpc/platforms/512x/clock-commonclk.c
@@ -985,7 +985,7 @@ static void mpc5121_clk_provide_migration_support(void)
 
 #define NODE_PREP do { \
 	of_address_to_resource(np, 0, &res); \
-	snprintf(devname, sizeof(devname), "%08x.%s", res.start, np->name); \
+	snprintf(devname, sizeof(devname), "%pa.%s", &res.start, np->name); \
 } while (0)
 
 #define NODE_CHK(clkname, clkitem, regnode, regflag) do { \
diff --git a/arch/powerpc/platforms/embedded6xx/flipper-pic.c b/arch/powerpc/platforms/embedded6xx/flipper-pic.c
index db0be007fd06..bfca4d42b00d 100644
--- a/arch/powerpc/platforms/embedded6xx/flipper-pic.c
+++ b/arch/powerpc/platforms/embedded6xx/flipper-pic.c
@@ -149,7 +149,7 @@ static struct irq_domain * __init flipper_pic_init(struct device_node *np)
 	}
 	io_base = ioremap(res.start, resource_size(&res));
 
-	pr_info("controller at 0x%08x mapped to 0x%p\n", res.start, io_base);
+	pr_info("controller at 0x%pa mapped to 0x%p\n", &res.start, io_base);
 
 	__flipper_quiesce(io_base);
 
diff --git a/arch/powerpc/platforms/embedded6xx/hlwd-pic.c b/arch/powerpc/platforms/embedded6xx/hlwd-pic.c
index 7b4edf1cb2c8..bdc7e1a80366 100644
--- a/arch/powerpc/platforms/embedded6xx/hlwd-pic.c
+++ b/arch/powerpc/platforms/embedded6xx/hlwd-pic.c
@@ -178,7 +178,7 @@ static struct irq_domain *hlwd_pic_init(struct device_node *np)
 		return NULL;
 	}
 
-	pr_info("controller at 0x%08x mapped to 0x%p\n", res.start, io_base);
+	pr_info("controller at 0x%pa mapped to 0x%p\n", &res.start, io_base);
 
 	__hlwd_quiesce(io_base);
 
diff --git a/arch/powerpc/platforms/embedded6xx/wii.c b/arch/powerpc/platforms/embedded6xx/wii.c
index 343bffd20fca..768231005fb5 100644
--- a/arch/powerpc/platforms/embedded6xx/wii.c
+++ b/arch/powerpc/platforms/embedded6xx/wii.c
@@ -122,8 +122,8 @@ static void __iomem *wii_ioremap_hw_regs(char *name, char *compatible)
 
 	hw_regs = ioremap(res.start, resource_size(&res));
 	if (hw_regs) {
-		pr_info("%s at 0x%08x mapped to 0x%p\n", name,
-			res.start, hw_regs);
+		pr_info("%s at 0x%pa mapped to 0x%p\n", name,
+			&res.start, hw_regs);
 	}
 
 out_put:
diff --git a/arch/powerpc/sysdev/tsi108_pci.c b/arch/powerpc/sysdev/tsi108_pci.c
index 28ff1f53cefc..6bd50c690006 100644
--- a/arch/powerpc/sysdev/tsi108_pci.c
+++ b/arch/powerpc/sysdev/tsi108_pci.c
@@ -229,9 +229,8 @@ int __init tsi108_setup_pci(struct device_node *dev, u32 cfg_phys, int primary)
 
 	(hose)->ops = &tsi108_direct_pci_ops;
 
-	printk(KERN_INFO "Found tsi108 PCI host bridge at 0x%08x. "
-	       "Firmware bus number: %d->%d\n",
-	       rsrc.start, hose->first_busno, hose->last_busno);
+	pr_info("Found tsi108 PCI host bridge at 0x%pa. Firmware bus number: %d->%d\n",
+		&rsrc.start, hose->first_busno, hose->last_busno);
 
 	/* Interpret the "ranges" property */
 	/* This also maps the I/O region and sets isa_io/mem_base */
diff --git a/arch/sh/kernel/cpu/sh4/sq.c b/arch/sh/kernel/cpu/sh4/sq.c
index 4ca78ed71ad2..c218bae8fe20 100644
--- a/arch/sh/kernel/cpu/sh4/sq.c
+++ b/arch/sh/kernel/cpu/sh4/sq.c
@@ -383,7 +383,7 @@ static int __init sq_api_init(void)
 	if (unlikely(!sq_cache))
 		return ret;
 
-	sq_bitmap = kzalloc(size, GFP_KERNEL);
+	sq_bitmap = kcalloc(size, sizeof(long), GFP_KERNEL);
 	if (unlikely(!sq_bitmap))
 		goto out;
 
diff --git a/arch/sh/kernel/head_32.S b/arch/sh/kernel/head_32.S
index 4e352c3f79e6..fb505cda25fc 100644
--- a/arch/sh/kernel/head_32.S
+++ b/arch/sh/kernel/head_32.S
@@ -67,7 +67,7 @@ ENTRY(_stext)
 	ldc	r0, r6_bank
 #endif
 
-#ifdef CONFIG_OF_FLATTREE
+#ifdef CONFIG_OF_EARLY_FLATTREE
 	mov	r4, r12		! Store device tree blob pointer in r12
 #endif
 	
@@ -318,7 +318,7 @@ ENTRY(_stext)
 10:		
 #endif
 
-#ifdef CONFIG_OF_FLATTREE
+#ifdef CONFIG_OF_EARLY_FLATTREE
 	mov.l	8f, r0		! Make flat device tree available early.
 	jsr	@r0
 	 mov	r12, r4
@@ -349,7 +349,7 @@ ENTRY(stack_start)
 5:	.long	start_kernel
 6:	.long	cpu_init
 7:	.long	init_thread_union
-#if defined(CONFIG_OF_FLATTREE)
+#if defined(CONFIG_OF_EARLY_FLATTREE)
 8:	.long	sh_fdt_init
 #endif
 
diff --git a/arch/sh/kernel/nmi_debug.c b/arch/sh/kernel/nmi_debug.c
index 730d928f0d12..d37b54f9cec6 100644
--- a/arch/sh/kernel/nmi_debug.c
+++ b/arch/sh/kernel/nmi_debug.c
@@ -52,7 +52,7 @@ static int __init nmi_debug_setup(char *str)
 	register_die_notifier(&nmi_debug_nb);
 
 	if (*str != '=')
-		return 0;
+		return 1;
 
 	for (p = str + 1; *p; p = sep + 1) {
 		sep = strchr(p, ',');
@@ -73,6 +73,6 @@ static int __init nmi_debug_setup(char *str)
 			break;
 	}
 
-	return 0;
+	return 1;
 }
 __setup("nmi_debug", nmi_debug_setup);
diff --git a/arch/sh/kernel/setup.c b/arch/sh/kernel/setup.c
index c286cf5da6e7..b2f44eb7ce19 100644
--- a/arch/sh/kernel/setup.c
+++ b/arch/sh/kernel/setup.c
@@ -242,7 +242,7 @@ void __init __weak plat_early_device_setup(void)
 {
 }
 
-#ifdef CONFIG_OF_FLATTREE
+#ifdef CONFIG_OF_EARLY_FLATTREE
 void __ref sh_fdt_init(phys_addr_t dt_phys)
 {
 	static int done = 0;
@@ -329,7 +329,7 @@ void __init setup_arch(char **cmdline_p)
 	/* Let earlyprintk output early console messages */
 	early_platform_driver_probe("earlyprintk", 1, 1);
 
-#ifdef CONFIG_OF_FLATTREE
+#ifdef CONFIG_OF_EARLY_FLATTREE
 #ifdef CONFIG_USE_BUILTIN_DTB
 	unflatten_and_copy_device_tree();
 #else
diff --git a/arch/sh/math-emu/sfp-util.h b/arch/sh/math-emu/sfp-util.h
index 784f541344f3..bda50762b3d3 100644
--- a/arch/sh/math-emu/sfp-util.h
+++ b/arch/sh/math-emu/sfp-util.h
@@ -67,7 +67,3 @@
   } while (0)
 
 #define abort()	return 0
-
-#define __BYTE_ORDER __LITTLE_ENDIAN
-
-
diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index 926939978c1c..9318fe7d850e 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -403,10 +403,9 @@ static unsigned int reserve_eilvt_offset(int offset, unsigned int new)
 		if (vector && !eilvt_entry_is_changeable(vector, new))
 			/* may not change if vectors are different */
 			return rsvd;
-		rsvd = atomic_cmpxchg(&eilvt_offsets[offset], rsvd, new);
-	} while (rsvd != new);
+	} while (!atomic_try_cmpxchg(&eilvt_offsets[offset], &rsvd, new));
 
-	rsvd &= ~APIC_EILVT_MASKED;
+	rsvd = new & ~APIC_EILVT_MASKED;
 	if (rsvd && rsvd != vector)
 		pr_info("LVT offset %d assigned for vector 0x%02x\n",
 			offset, rsvd);
diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
index 677508baf95a..af59aa9c5523 100644
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -2449,17 +2449,21 @@ static int io_apic_get_redir_entries(int ioapic)
 
 unsigned int arch_dynirq_lower_bound(unsigned int from)
 {
+	unsigned int ret;
+
 	/*
 	 * dmar_alloc_hwirq() may be called before setup_IO_APIC(), so use
 	 * gsi_top if ioapic_dynirq_base hasn't been initialized yet.
 	 */
-	if (!ioapic_initialized)
-		return gsi_top;
+	ret = ioapic_dynirq_base ? : gsi_top;
+
 	/*
-	 * For DT enabled machines ioapic_dynirq_base is irrelevant and not
-	 * updated. So simply return @from if ioapic_dynirq_base == 0.
+	 * For DT enabled machines ioapic_dynirq_base is irrelevant and
+	 * always 0. gsi_top can be 0 if there is no IO/APIC registered.
+	 * 0 is an invalid interrupt number for dynamic allocations. Return
+	 * @from instead.
 	 */
-	return ioapic_dynirq_base ? : from;
+	return ret ? : from;
 }
 
 #ifdef CONFIG_X86_32
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 265e70b0eb79..55e52064c4ec 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -13878,6 +13878,21 @@ static int vmx_check_intercept(struct kvm_vcpu *vcpu,
 		/* FIXME: produce nested vmexit and return X86EMUL_INTERCEPTED.  */
 		break;
 
+	case x86_intercept_pause:
+		/*
+		 * PAUSE is a single-byte NOP with a REPE prefix, i.e. collides
+		 * with vanilla NOPs in the emulator.  Apply the interception
+		 * check only to actual PAUSE instructions.  Don't check
+		 * PAUSE-loop-exiting, software can't expect a given PAUSE to
+		 * exit, i.e. KVM is within its rights to allow L2 to execute
+		 * the PAUSE.
+		 */
+		if ((info->rep_prefix != REPE_PREFIX) ||
+		    !nested_cpu_has2(vmcs12, CPU_BASED_PAUSE_EXITING))
+			return X86EMUL_CONTINUE;
+
+		break;
+
 	/* TODO: check more intercepts... */
 	default:
 		break;
diff --git a/crypto/drbg.c b/crypto/drbg.c
index c8c56763dfde..0df8cc9bb563 100644
--- a/crypto/drbg.c
+++ b/crypto/drbg.c
@@ -1512,6 +1512,14 @@ static int drbg_prepare_hrng(struct drbg_state *drbg)
 		return 0;
 
 	drbg->jent = crypto_alloc_rng("jitterentropy_rng", 0, 0);
+	if (IS_ERR(drbg->jent)) {
+		const int err = PTR_ERR(drbg->jent);
+
+		drbg->jent = NULL;
+		if (fips_enabled)
+			return err;
+		pr_info("DRBG: Continuing without Jitter RNG\n");
+	}
 
 	return 0;
 }
@@ -1567,14 +1575,6 @@ static int drbg_instantiate(struct drbg_state *drbg, struct drbg_string *pers,
 		if (ret)
 			goto free_everything;
 
-		if (IS_ERR(drbg->jent)) {
-			ret = PTR_ERR(drbg->jent);
-			drbg->jent = NULL;
-			if (fips_enabled || ret != -ENOENT)
-				goto free_everything;
-			pr_info("DRBG: Continuing without Jitter RNG\n");
-		}
-
 		reseed = false;
 	}
 
diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
index ce5b3ffbd6ee..878ed43d8753 100644
--- a/drivers/base/cpu.c
+++ b/drivers/base/cpu.c
@@ -494,7 +494,8 @@ static const struct attribute_group *cpu_root_attr_groups[] = {
 bool cpu_is_hotpluggable(unsigned cpu)
 {
 	struct device *dev = get_cpu_device(cpu);
-	return dev && container_of(dev, struct cpu, dev)->hotpluggable;
+	return dev && container_of(dev, struct cpu, dev)->hotpluggable
+		&& tick_nohz_cpu_hotpluggable(cpu);
 }
 EXPORT_SYMBOL_GPL(cpu_is_hotpluggable);
 
diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index cbb6ef719978..d1d6a7af7e78 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -1310,7 +1310,7 @@ static void submit_one_flush(struct drbd_device *device, struct issue_flush_cont
 	bio_set_dev(bio, device->ldev->backing_bdev);
 	bio->bi_private = octx;
 	bio->bi_end_io = one_flush_endio;
-	bio->bi_opf = REQ_OP_FLUSH | REQ_PREFLUSH;
+	bio->bi_opf = REQ_OP_WRITE | REQ_PREFLUSH;
 
 	device->flush_jif = jiffies;
 	set_bit(FLUSH_PENDING, &device->flags);
diff --git a/drivers/bluetooth/btsdio.c b/drivers/bluetooth/btsdio.c
index bd55bf7a9914..20142bc77554 100644
--- a/drivers/bluetooth/btsdio.c
+++ b/drivers/bluetooth/btsdio.c
@@ -353,7 +353,6 @@ static void btsdio_remove(struct sdio_func *func)
 
 	BT_DBG("func %p", func);
 
-	cancel_work_sync(&data->work);
 	if (!data)
 		return;
 
diff --git a/drivers/char/ipmi/ipmi_msghandler.c b/drivers/char/ipmi/ipmi_msghandler.c
index 4265e8d3e71c..31cfa47d2498 100644
--- a/drivers/char/ipmi/ipmi_msghandler.c
+++ b/drivers/char/ipmi/ipmi_msghandler.c
@@ -536,9 +536,22 @@ struct ipmi_smi {
 	unsigned int     waiting_events_count; /* How many events in queue? */
 	char             delivering_events;
 	char             event_msg_printed;
+
+	/* How many users are waiting for events? */
 	atomic_t         event_waiters;
 	unsigned int     ticks_to_req_ev;
-	int              last_needs_timer;
+
+	/* How many users are waiting for commands? */
+	atomic_t         command_waiters;
+
+	/* How many users are waiting for watchdogs? */
+	atomic_t         watchdog_waiters;
+
+	/*
+	 * Tells what the lower layer has last been asked to watch for,
+	 * messages and/or watchdogs.  Protected by xmit_msgs_lock.
+	 */
+	unsigned int     last_watch_mask;
 
 	/*
 	 * The event receiver for my BMC, only really used at panic
@@ -1085,6 +1098,29 @@ static int intf_err_seq(struct ipmi_smi *intf,
 	return rv;
 }
 
+/* Must be called with xmit_msgs_lock held. */
+static void smi_tell_to_watch(struct ipmi_smi *intf,
+			      unsigned int flags,
+			      struct ipmi_smi_msg *smi_msg)
+{
+	if (flags & IPMI_WATCH_MASK_CHECK_MESSAGES) {
+		if (!smi_msg)
+			return;
+
+		if (!smi_msg->needs_response)
+			return;
+	}
+
+	if (!intf->handlers->set_need_watch)
+		return;
+
+	if ((intf->last_watch_mask & flags) == flags)
+		return;
+
+	intf->last_watch_mask |= flags;
+	intf->handlers->set_need_watch(intf->send_info,
+				       intf->last_watch_mask);
+}
 
 static void free_user_work(struct work_struct *work)
 {
@@ -1164,8 +1200,9 @@ int ipmi_create_user(unsigned int          if_num,
 	spin_unlock_irqrestore(&intf->seq_lock, flags);
 	if (handler->ipmi_watchdog_pretimeout) {
 		/* User wants pretimeouts, so make sure to watch for them. */
-		if (atomic_inc_return(&intf->event_waiters) == 1)
-			need_waiter(intf);
+		if (atomic_inc_return(&intf->watchdog_waiters) == 1)
+			smi_tell_to_watch(intf, IPMI_WATCH_MASK_CHECK_WATCHDOG,
+					  NULL);
 	}
 	srcu_read_unlock(&ipmi_interfaces_srcu, index);
 	*user = new_user;
@@ -1239,7 +1276,7 @@ static void _ipmi_destroy_user(struct ipmi_user *user)
 		user->handler->shutdown(user->handler_data);
 
 	if (user->handler->ipmi_watchdog_pretimeout)
-		atomic_dec(&intf->event_waiters);
+		atomic_dec(&intf->watchdog_waiters);
 
 	if (user->gets_events)
 		atomic_dec(&intf->event_waiters);
@@ -1597,8 +1634,8 @@ int ipmi_register_for_cmd(struct ipmi_user *user,
 		goto out_unlock;
 	}
 
-	if (atomic_inc_return(&intf->event_waiters) == 1)
-		need_waiter(intf);
+	if (atomic_inc_return(&intf->command_waiters) == 1)
+		smi_tell_to_watch(intf, IPMI_WATCH_MASK_CHECK_COMMANDS, NULL);
 
 	list_add_rcu(&rcvr->link, &intf->cmd_rcvrs);
 
@@ -1648,7 +1685,7 @@ int ipmi_unregister_for_cmd(struct ipmi_user *user,
 	synchronize_rcu();
 	release_ipmi_user(user, index);
 	while (rcvrs) {
-		atomic_dec(&intf->event_waiters);
+		atomic_dec(&intf->command_waiters);
 		rcvr = rcvrs;
 		rcvrs = rcvr->next;
 		kfree(rcvr);
@@ -1765,22 +1802,21 @@ static struct ipmi_smi_msg *smi_add_send_msg(struct ipmi_smi *intf,
 	return smi_msg;
 }
 
-
 static void smi_send(struct ipmi_smi *intf,
 		     const struct ipmi_smi_handlers *handlers,
 		     struct ipmi_smi_msg *smi_msg, int priority)
 {
 	int run_to_completion = intf->run_to_completion;
+	unsigned long flags = 0;
 
-	if (run_to_completion) {
-		smi_msg = smi_add_send_msg(intf, smi_msg, priority);
-	} else {
-		unsigned long flags;
-
+	if (!run_to_completion)
 		spin_lock_irqsave(&intf->xmit_msgs_lock, flags);
-		smi_msg = smi_add_send_msg(intf, smi_msg, priority);
+	smi_msg = smi_add_send_msg(intf, smi_msg, priority);
+
+	smi_tell_to_watch(intf, IPMI_WATCH_MASK_CHECK_MESSAGES, smi_msg);
+
+	if (!run_to_completion)
 		spin_unlock_irqrestore(&intf->xmit_msgs_lock, flags);
-	}
 
 	if (smi_msg)
 		handlers->sender(intf->send_info, smi_msg);
@@ -1978,6 +2014,9 @@ static int i_ipmi_req_ipmb(struct ipmi_smi        *intf,
 				ipmb_seq, broadcast,
 				source_address, source_lun);
 
+		/* We will be getting a response in the BMC message queue. */
+		smi_msg->needs_response = true;
+
 		/*
 		 * Copy the message into the recv message data, so we
 		 * can retransmit it later if necessary.
@@ -2165,6 +2204,7 @@ static int i_ipmi_request(struct ipmi_user     *user,
 			goto out;
 		}
 	}
+	smi_msg->needs_response = false;
 
 	rcu_read_lock();
 	if (intf->in_shutdown) {
@@ -3386,6 +3426,8 @@ int ipmi_add_smi(struct module         *owner,
 	INIT_LIST_HEAD(&intf->hp_xmit_msgs);
 	spin_lock_init(&intf->events_lock);
 	atomic_set(&intf->event_waiters, 0);
+	atomic_set(&intf->watchdog_waiters, 0);
+	atomic_set(&intf->command_waiters, 0);
 	intf->ticks_to_req_ev = IPMI_REQUEST_EV_TIME;
 	INIT_LIST_HEAD(&intf->waiting_events);
 	intf->waiting_events_count = 0;
@@ -4404,6 +4446,9 @@ static void smi_recv_tasklet(unsigned long val)
 			intf->curr_msg = newmsg;
 		}
 	}
+
+	smi_tell_to_watch(intf, IPMI_WATCH_MASK_CHECK_MESSAGES, newmsg);
+
 	if (!run_to_completion)
 		spin_unlock_irqrestore(&intf->xmit_msgs_lock, flags);
 	if (newmsg)
@@ -4531,7 +4576,7 @@ static void check_msg_timeout(struct ipmi_smi *intf, struct seq_table *ent,
 			      struct list_head *timeouts,
 			      unsigned long timeout_period,
 			      int slot, unsigned long *flags,
-			      unsigned int *waiting_msgs)
+			      unsigned int *watch_mask)
 {
 	struct ipmi_recv_msg *msg;
 
@@ -4543,7 +4588,7 @@ static void check_msg_timeout(struct ipmi_smi *intf, struct seq_table *ent,
 
 	if (timeout_period < ent->timeout) {
 		ent->timeout -= timeout_period;
-		(*waiting_msgs)++;
+		*watch_mask |= IPMI_WATCH_MASK_CHECK_MESSAGES;
 		return;
 	}
 
@@ -4562,7 +4607,7 @@ static void check_msg_timeout(struct ipmi_smi *intf, struct seq_table *ent,
 		struct ipmi_smi_msg *smi_msg;
 		/* More retries, send again. */
 
-		(*waiting_msgs)++;
+		*watch_mask |= IPMI_WATCH_MASK_CHECK_MESSAGES;
 
 		/*
 		 * Start with the max timer, set to normal timer after
@@ -4614,13 +4659,13 @@ static unsigned int ipmi_timeout_handler(struct ipmi_smi *intf,
 	struct ipmi_recv_msg *msg, *msg2;
 	unsigned long        flags;
 	int                  i;
-	unsigned int         waiting_msgs = 0;
+	unsigned int         watch_mask = 0;
 
 	if (!intf->bmc_registered) {
 		kref_get(&intf->refcount);
 		if (!schedule_work(&intf->bmc_reg_work)) {
 			kref_put(&intf->refcount, intf_free);
-			waiting_msgs++;
+			watch_mask |= IPMI_WATCH_MASK_INTERNAL;
 		}
 	}
 
@@ -4640,7 +4685,7 @@ static unsigned int ipmi_timeout_handler(struct ipmi_smi *intf,
 	for (i = 0; i < IPMI_IPMB_NUM_SEQ; i++)
 		check_msg_timeout(intf, &intf->seq_table[i],
 				  &timeouts, timeout_period, i,
-				  &flags, &waiting_msgs);
+				  &flags, &watch_mask);
 	spin_unlock_irqrestore(&intf->seq_lock, flags);
 
 	list_for_each_entry_safe(msg, msg2, &timeouts, link)
@@ -4671,7 +4716,7 @@ static unsigned int ipmi_timeout_handler(struct ipmi_smi *intf,
 
 	tasklet_schedule(&intf->recv_tasklet);
 
-	return waiting_msgs;
+	return watch_mask;
 }
 
 static void ipmi_request_event(struct ipmi_smi *intf)
@@ -4691,37 +4736,43 @@ static atomic_t stop_operation;
 static void ipmi_timeout(struct timer_list *unused)
 {
 	struct ipmi_smi *intf;
-	int nt = 0, index;
+	unsigned int watch_mask = 0;
+	int index;
+	unsigned long flags;
 
 	if (atomic_read(&stop_operation))
 		return;
 
 	index = srcu_read_lock(&ipmi_interfaces_srcu);
 	list_for_each_entry_rcu(intf, &ipmi_interfaces, link) {
-		int lnt = 0;
-
 		if (atomic_read(&intf->event_waiters)) {
 			intf->ticks_to_req_ev--;
 			if (intf->ticks_to_req_ev == 0) {
 				ipmi_request_event(intf);
 				intf->ticks_to_req_ev = IPMI_REQUEST_EV_TIME;
 			}
-			lnt++;
+			watch_mask |= IPMI_WATCH_MASK_INTERNAL;
 		}
 
-		lnt += ipmi_timeout_handler(intf, IPMI_TIMEOUT_TIME);
+		if (atomic_read(&intf->watchdog_waiters))
+			watch_mask |= IPMI_WATCH_MASK_CHECK_WATCHDOG;
 
-		lnt = !!lnt;
-		if (lnt != intf->last_needs_timer &&
-					intf->handlers->set_need_watch)
-			intf->handlers->set_need_watch(intf->send_info, lnt);
-		intf->last_needs_timer = lnt;
+		if (atomic_read(&intf->command_waiters))
+			watch_mask |= IPMI_WATCH_MASK_CHECK_COMMANDS;
+
+		watch_mask |= ipmi_timeout_handler(intf, IPMI_TIMEOUT_TIME);
 
-		nt += lnt;
+		spin_lock_irqsave(&intf->xmit_msgs_lock, flags);
+		if (watch_mask != intf->last_watch_mask &&
+					intf->handlers->set_need_watch)
+			intf->handlers->set_need_watch(intf->send_info,
+						       watch_mask);
+		intf->last_watch_mask = watch_mask;
+		spin_unlock_irqrestore(&intf->xmit_msgs_lock, flags);
 	}
 	srcu_read_unlock(&ipmi_interfaces_srcu, index);
 
-	if (nt)
+	if (watch_mask)
 		mod_timer(&ipmi_timer, jiffies + IPMI_TIMEOUT_JIFFIES);
 }
 
diff --git a/drivers/char/ipmi/ipmi_si_intf.c b/drivers/char/ipmi/ipmi_si_intf.c
index a5e1dce042e8..429fe063e33f 100644
--- a/drivers/char/ipmi/ipmi_si_intf.c
+++ b/drivers/char/ipmi/ipmi_si_intf.c
@@ -1073,10 +1073,13 @@ static void request_events(void *send_info)
 	atomic_set(&smi_info->req_events, 1);
 }
 
-static void set_need_watch(void *send_info, bool enable)
+static void set_need_watch(void *send_info, unsigned int watch_mask)
 {
 	struct smi_info *smi_info = send_info;
 	unsigned long flags;
+	int enable;
+
+	enable = !!(watch_mask & ~IPMI_WATCH_MASK_INTERNAL);
 
 	atomic_set(&smi_info->need_watch, enable);
 	spin_lock_irqsave(&smi_info->si_lock, flags);
diff --git a/drivers/char/ipmi/ipmi_ssif.c b/drivers/char/ipmi/ipmi_ssif.c
index fd1a487443f0..34c5b287c412 100644
--- a/drivers/char/ipmi/ipmi_ssif.c
+++ b/drivers/char/ipmi/ipmi_ssif.c
@@ -88,8 +88,14 @@
 #define SSIF_MSG_JIFFIES	((SSIF_MSG_USEC * 1000) / TICK_NSEC)
 #define SSIF_MSG_PART_JIFFIES	((SSIF_MSG_PART_USEC * 1000) / TICK_NSEC)
 
+/*
+ * Timeout for the watch, only used for get flag timer.
+ */
+#define SSIF_WATCH_MSG_TIMEOUT		msecs_to_jiffies(10)
+#define SSIF_WATCH_WATCHDOG_TIMEOUT	msecs_to_jiffies(250)
+
 enum ssif_intf_state {
-	SSIF_NORMAL,
+	SSIF_IDLE,
 	SSIF_GETTING_FLAGS,
 	SSIF_GETTING_EVENTS,
 	SSIF_CLEARING_FLAGS,
@@ -97,8 +103,8 @@ enum ssif_intf_state {
 	/* FIXME - add watchdog stuff. */
 };
 
-#define SSIF_IDLE(ssif)	 ((ssif)->ssif_state == SSIF_NORMAL \
-			  && (ssif)->curr_msg == NULL)
+#define IS_SSIF_IDLE(ssif) ((ssif)->ssif_state == SSIF_IDLE \
+			    && (ssif)->curr_msg == NULL)
 
 /*
  * Indexes into stats[] in ssif_info below.
@@ -268,6 +274,9 @@ struct ssif_info {
 	struct timer_list retry_timer;
 	int retries_left;
 
+	long watch_timeout;		/* Timeout for flags check, 0 if off. */
+	struct timer_list watch_timer;	/* Flag fetch timer. */
+
 	/* Info from SSIF cmd */
 	unsigned char max_xmit_msg_size;
 	unsigned char max_recv_msg_size;
@@ -340,9 +349,9 @@ static void return_hosed_msg(struct ssif_info *ssif_info,
 
 /*
  * Must be called with the message lock held.  This will release the
- * message lock.  Note that the caller will check SSIF_IDLE and start a
- * new operation, so there is no need to check for new messages to
- * start in here.
+ * message lock.  Note that the caller will check IS_SSIF_IDLE and
+ * start a new operation, so there is no need to check for new
+ * messages to start in here.
  */
 static void start_clear_flags(struct ssif_info *ssif_info, unsigned long *flags)
 {
@@ -359,7 +368,7 @@ static void start_clear_flags(struct ssif_info *ssif_info, unsigned long *flags)
 
 	if (start_send(ssif_info, msg, 3) != 0) {
 		/* Error, just go to normal state. */
-		ssif_info->ssif_state = SSIF_NORMAL;
+		ssif_info->ssif_state = SSIF_IDLE;
 	}
 }
 
@@ -374,7 +383,7 @@ static void start_flag_fetch(struct ssif_info *ssif_info, unsigned long *flags)
 	mb[0] = (IPMI_NETFN_APP_REQUEST << 2);
 	mb[1] = IPMI_GET_MSG_FLAGS_CMD;
 	if (start_send(ssif_info, mb, 2) != 0)
-		ssif_info->ssif_state = SSIF_NORMAL;
+		ssif_info->ssif_state = SSIF_IDLE;
 }
 
 static void check_start_send(struct ssif_info *ssif_info, unsigned long *flags,
@@ -385,7 +394,7 @@ static void check_start_send(struct ssif_info *ssif_info, unsigned long *flags,
 
 		flags = ipmi_ssif_lock_cond(ssif_info, &oflags);
 		ssif_info->curr_msg = NULL;
-		ssif_info->ssif_state = SSIF_NORMAL;
+		ssif_info->ssif_state = SSIF_IDLE;
 		ipmi_ssif_unlock_cond(ssif_info, flags);
 		ipmi_free_smi_msg(msg);
 	}
@@ -399,7 +408,7 @@ static void start_event_fetch(struct ssif_info *ssif_info, unsigned long *flags)
 
 	msg = ipmi_alloc_smi_msg();
 	if (!msg) {
-		ssif_info->ssif_state = SSIF_NORMAL;
+		ssif_info->ssif_state = SSIF_IDLE;
 		ipmi_ssif_unlock_cond(ssif_info, flags);
 		return;
 	}
@@ -422,7 +431,7 @@ static void start_recv_msg_fetch(struct ssif_info *ssif_info,
 
 	msg = ipmi_alloc_smi_msg();
 	if (!msg) {
-		ssif_info->ssif_state = SSIF_NORMAL;
+		ssif_info->ssif_state = SSIF_IDLE;
 		ipmi_ssif_unlock_cond(ssif_info, flags);
 		return;
 	}
@@ -440,9 +449,9 @@ static void start_recv_msg_fetch(struct ssif_info *ssif_info,
 
 /*
  * Must be called with the message lock held.  This will release the
- * message lock.  Note that the caller will check SSIF_IDLE and start a
- * new operation, so there is no need to check for new messages to
- * start in here.
+ * message lock.  Note that the caller will check IS_SSIF_IDLE and
+ * start a new operation, so there is no need to check for new
+ * messages to start in here.
  */
 static void handle_flags(struct ssif_info *ssif_info, unsigned long *flags)
 {
@@ -458,7 +467,7 @@ static void handle_flags(struct ssif_info *ssif_info, unsigned long *flags)
 		/* Events available. */
 		start_event_fetch(ssif_info, flags);
 	else {
-		ssif_info->ssif_state = SSIF_NORMAL;
+		ssif_info->ssif_state = SSIF_IDLE;
 		ipmi_ssif_unlock_cond(ssif_info, flags);
 	}
 }
@@ -558,6 +567,26 @@ static void retry_timeout(struct timer_list *t)
 		start_get(ssif_info);
 }
 
+static void watch_timeout(struct timer_list *t)
+{
+	struct ssif_info *ssif_info = from_timer(ssif_info, t, watch_timer);
+	unsigned long oflags, *flags;
+
+	if (ssif_info->stopping)
+		return;
+
+	flags = ipmi_ssif_lock_cond(ssif_info, &oflags);
+	if (ssif_info->watch_timeout) {
+		mod_timer(&ssif_info->watch_timer,
+			  jiffies + ssif_info->watch_timeout);
+		if (IS_SSIF_IDLE(ssif_info)) {
+			start_flag_fetch(ssif_info, flags); /* Releases lock */
+			return;
+		}
+		ssif_info->req_flags = true;
+	}
+	ipmi_ssif_unlock_cond(ssif_info, flags);
+}
 
 static void ssif_alert(struct i2c_client *client, enum i2c_alert_protocol type,
 		       unsigned int data)
@@ -747,7 +776,7 @@ static void msg_done_handler(struct ssif_info *ssif_info, int result,
 	}
 
 	switch (ssif_info->ssif_state) {
-	case SSIF_NORMAL:
+	case SSIF_IDLE:
 		ipmi_ssif_unlock_cond(ssif_info, flags);
 		if (!msg)
 			break;
@@ -765,16 +794,16 @@ static void msg_done_handler(struct ssif_info *ssif_info, int result,
 			 * Error fetching flags, or invalid length,
 			 * just give up for now.
 			 */
-			ssif_info->ssif_state = SSIF_NORMAL;
+			ssif_info->ssif_state = SSIF_IDLE;
 			ipmi_ssif_unlock_cond(ssif_info, flags);
 			pr_warn(PFX "Error getting flags: %d %d, %x\n",
 			       result, len, (len >= 3) ? data[2] : 0);
 		} else if (data[0] != (IPMI_NETFN_APP_REQUEST | 1) << 2
 			   || data[1] != IPMI_GET_MSG_FLAGS_CMD) {
 			/*
-			 * Don't abort here, maybe it was a queued
-			 * response to a previous command.
+			 * Recv error response, give up.
 			 */
+			ssif_info->ssif_state = SSIF_IDLE;
 			ipmi_ssif_unlock_cond(ssif_info, flags);
 			pr_warn(PFX "Invalid response getting flags: %x %x\n",
 				data[0], data[1]);
@@ -796,7 +825,7 @@ static void msg_done_handler(struct ssif_info *ssif_info, int result,
 			pr_warn(PFX "Invalid response clearing flags: %x %x\n",
 				data[0], data[1]);
 		}
-		ssif_info->ssif_state = SSIF_NORMAL;
+		ssif_info->ssif_state = SSIF_IDLE;
 		ipmi_ssif_unlock_cond(ssif_info, flags);
 		break;
 
@@ -872,7 +901,7 @@ static void msg_done_handler(struct ssif_info *ssif_info, int result,
 	}
 
 	flags = ipmi_ssif_lock_cond(ssif_info, &oflags);
-	if (SSIF_IDLE(ssif_info) && !ssif_info->stopping) {
+	if (IS_SSIF_IDLE(ssif_info) && !ssif_info->stopping) {
 		if (ssif_info->req_events)
 			start_event_fetch(ssif_info, flags);
 		else if (ssif_info->req_flags)
@@ -1041,7 +1070,7 @@ static void start_next_msg(struct ssif_info *ssif_info, unsigned long *flags)
 	unsigned long oflags;
 
  restart:
-	if (!SSIF_IDLE(ssif_info)) {
+	if (!IS_SSIF_IDLE(ssif_info)) {
 		ipmi_ssif_unlock_cond(ssif_info, flags);
 		return;
 	}
@@ -1103,8 +1132,7 @@ static int get_smi_info(void *send_info, struct ipmi_smi_info *data)
 }
 
 /*
- * Instead of having our own timer to periodically check the message
- * flags, we let the message handler drive us.
+ * Upper layer wants us to request events.
  */
 static void request_events(void *send_info)
 {
@@ -1115,18 +1143,33 @@ static void request_events(void *send_info)
 		return;
 
 	flags = ipmi_ssif_lock_cond(ssif_info, &oflags);
-	/*
-	 * Request flags first, not events, because the lower layer
-	 * doesn't have a way to send an attention.  But make sure
-	 * event checking still happens.
-	 */
 	ssif_info->req_events = true;
-	if (SSIF_IDLE(ssif_info))
-		start_flag_fetch(ssif_info, flags);
-	else {
-		ssif_info->req_flags = true;
-		ipmi_ssif_unlock_cond(ssif_info, flags);
+	ipmi_ssif_unlock_cond(ssif_info, flags);
+}
+
+/*
+ * Upper layer is changing the flag saying whether we need to request
+ * flags periodically or not.
+ */
+static void ssif_set_need_watch(void *send_info, unsigned int watch_mask)
+{
+	struct ssif_info *ssif_info = (struct ssif_info *) send_info;
+	unsigned long oflags, *flags;
+	long timeout = 0;
+
+	if (watch_mask & IPMI_WATCH_MASK_CHECK_MESSAGES)
+		timeout = SSIF_WATCH_MSG_TIMEOUT;
+	else if (watch_mask & ~IPMI_WATCH_MASK_INTERNAL)
+		timeout = SSIF_WATCH_WATCHDOG_TIMEOUT;
+
+	flags = ipmi_ssif_lock_cond(ssif_info, &oflags);
+	if (timeout != ssif_info->watch_timeout) {
+		ssif_info->watch_timeout = timeout;
+		if (ssif_info->watch_timeout)
+			mod_timer(&ssif_info->watch_timer,
+				  jiffies + ssif_info->watch_timeout);
 	}
+	ipmi_ssif_unlock_cond(ssif_info, flags);
 }
 
 static int ssif_start_processing(void            *send_info,
@@ -1249,10 +1292,11 @@ static void shutdown_ssif(void *send_info)
 	dev_set_drvdata(&ssif_info->client->dev, NULL);
 
 	/* make sure the driver is not looking for flags any more. */
-	while (ssif_info->ssif_state != SSIF_NORMAL)
+	while (ssif_info->ssif_state != SSIF_IDLE)
 		schedule_timeout(1);
 
 	ssif_info->stopping = true;
+	del_timer_sync(&ssif_info->watch_timer);
 	del_timer_sync(&ssif_info->retry_timer);
 	if (ssif_info->thread) {
 		complete(&ssif_info->wake_thread);
@@ -1630,8 +1674,9 @@ static int ssif_probe(struct i2c_client *client, const struct i2c_device_id *id)
 	}
 
 	spin_lock_init(&ssif_info->lock);
-	ssif_info->ssif_state = SSIF_NORMAL;
+	ssif_info->ssif_state = SSIF_IDLE;
 	timer_setup(&ssif_info->retry_timer, retry_timeout, 0);
+	timer_setup(&ssif_info->watch_timer, watch_timeout, 0);
 
 	for (i = 0; i < SSIF_NUM_STATS; i++)
 		atomic_set(&ssif_info->stats[i], 0);
@@ -1645,6 +1690,7 @@ static int ssif_probe(struct i2c_client *client, const struct i2c_device_id *id)
 	ssif_info->handlers.get_smi_info = get_smi_info;
 	ssif_info->handlers.sender = sender;
 	ssif_info->handlers.request_events = request_events;
+	ssif_info->handlers.set_need_watch = ssif_set_need_watch;
 
 	{
 		unsigned int thread_num;
diff --git a/drivers/clk/clk-conf.c b/drivers/clk/clk-conf.c
index 49819b546134..5c6760e45a16 100644
--- a/drivers/clk/clk-conf.c
+++ b/drivers/clk/clk-conf.c
@@ -36,9 +36,12 @@ static int __set_clk_parents(struct device_node *node, bool clk_supplier)
 			else
 				return rc;
 		}
-		if (clkspec.np == node && !clk_supplier)
+		if (clkspec.np == node && !clk_supplier) {
+			of_node_put(clkspec.np);
 			return 0;
+		}
 		pclk = of_clk_get_from_provider(&clkspec);
+		of_node_put(clkspec.np);
 		if (IS_ERR(pclk)) {
 			if (PTR_ERR(pclk) != -EPROBE_DEFER)
 				pr_warn("clk: couldn't get parent clock %d for %pOF\n",
@@ -51,10 +54,12 @@ static int __set_clk_parents(struct device_node *node, bool clk_supplier)
 		if (rc < 0)
 			goto err;
 		if (clkspec.np == node && !clk_supplier) {
+			of_node_put(clkspec.np);
 			rc = 0;
 			goto err;
 		}
 		clk = of_clk_get_from_provider(&clkspec);
+		of_node_put(clkspec.np);
 		if (IS_ERR(clk)) {
 			if (PTR_ERR(clk) != -EPROBE_DEFER)
 				pr_warn("clk: couldn't get assigned clock %d for %pOF\n",
@@ -96,10 +101,13 @@ static int __set_clk_rates(struct device_node *node, bool clk_supplier)
 				else
 					return rc;
 			}
-			if (clkspec.np == node && !clk_supplier)
+			if (clkspec.np == node && !clk_supplier) {
+				of_node_put(clkspec.np);
 				return 0;
+			}
 
 			clk = of_clk_get_from_provider(&clkspec);
+			of_node_put(clkspec.np);
 			if (IS_ERR(clk)) {
 				if (PTR_ERR(clk) != -EPROBE_DEFER)
 					pr_warn("clk: couldn't get clock %d for %pOF\n",
diff --git a/drivers/clk/rockchip/clk-rk3399.c b/drivers/clk/rockchip/clk-rk3399.c
index 5a628148f3f0..ec9850db5bf9 100644
--- a/drivers/clk/rockchip/clk-rk3399.c
+++ b/drivers/clk/rockchip/clk-rk3399.c
@@ -1267,7 +1267,7 @@ static struct rockchip_clk_branch rk3399_clk_branches[] __initdata = {
 			RK3399_CLKSEL_CON(56), 6, 2, MFLAGS,
 			RK3399_CLKGATE_CON(10), 7, GFLAGS),
 
-	COMPOSITE_NOGATE(SCLK_CIF_OUT, "clk_cifout", mux_clk_cif_p, 0,
+	COMPOSITE_NOGATE(SCLK_CIF_OUT, "clk_cifout", mux_clk_cif_p, CLK_SET_RATE_PARENT,
 			 RK3399_CLKSEL_CON(56), 5, 1, MFLAGS, 0, 5, DFLAGS),
 
 	/* gic */
diff --git a/drivers/dma/at_xdmac.c b/drivers/dma/at_xdmac.c
index a451ecae1669..33ea7abd8cc9 100644
--- a/drivers/dma/at_xdmac.c
+++ b/drivers/dma/at_xdmac.c
@@ -223,6 +223,7 @@ struct at_xdmac {
 	int			irq;
 	struct clk		*clk;
 	u32			save_gim;
+	u32			save_gs;
 	struct dma_pool		*at_xdmac_desc_pool;
 	struct at_xdmac_chan	chan[0];
 };
@@ -1878,6 +1879,7 @@ static int atmel_xdmac_suspend(struct device *dev)
 		}
 	}
 	atxdmac->save_gim = at_xdmac_read(atxdmac, AT_XDMAC_GIM);
+	atxdmac->save_gs = at_xdmac_read(atxdmac, AT_XDMAC_GS);
 
 	at_xdmac_off(atxdmac);
 	clk_disable_unprepare(atxdmac->clk);
@@ -1914,7 +1916,8 @@ static int atmel_xdmac_resume(struct device *dev)
 			at_xdmac_chan_write(atchan, AT_XDMAC_CNDC, atchan->save_cndc);
 			at_xdmac_chan_write(atchan, AT_XDMAC_CIE, atchan->save_cim);
 			wmb();
-			at_xdmac_write(atxdmac, AT_XDMAC_GE, atchan->mask);
+			if (atxdmac->save_gs & atchan->mask)
+				at_xdmac_write(atxdmac, AT_XDMAC_GE, atchan->mask);
 		}
 	}
 	return 0;
diff --git a/drivers/edac/skx_edac.c b/drivers/edac/skx_edac.c
index dd209e0dd9ab..38a82a3f4516 100644
--- a/drivers/edac/skx_edac.c
+++ b/drivers/edac/skx_edac.c
@@ -825,13 +825,13 @@ static bool skx_rir_decode(struct decoded_addr *res)
 }
 
 static u8 skx_close_row[] = {
-	15, 16, 17, 18, 20, 21, 22, 28, 10, 11, 12, 13, 29, 30, 31, 32, 33
+	15, 16, 17, 18, 20, 21, 22, 28, 10, 11, 12, 13, 29, 30, 31, 32, 33, 34
 };
 static u8 skx_close_column[] = {
 	3, 4, 5, 14, 19, 23, 24, 25, 26, 27
 };
 static u8 skx_open_row[] = {
-	14, 15, 16, 20, 28, 21, 22, 23, 24, 25, 26, 27, 29, 30, 31, 32, 33
+	14, 15, 16, 20, 28, 21, 22, 23, 24, 25, 26, 27, 29, 30, 31, 32, 33, 34
 };
 static u8 skx_open_column[] = {
 	3, 4, 5, 6, 7, 8, 9, 10, 11, 12
@@ -896,12 +896,11 @@ static bool skx_decode(struct decoded_addr *res)
 
 #ifdef CONFIG_EDAC_DEBUG
 /*
- * Debug feature. Make /sys/kernel/debug/skx_edac_test/addr.
- * Write an address to this file to exercise the address decode
- * logic in this driver.
+ * Debug feature.
+ * Exercise the address decode logic by writing an address to
+ * /sys/kernel/debug/edac/skx_test/addr.
  */
 static struct dentry *skx_test;
-static u64 skx_fake_addr;
 
 static int debugfs_u64_set(void *data, u64 val)
 {
@@ -912,19 +911,19 @@ static int debugfs_u64_set(void *data, u64 val)
 
 	return 0;
 }
-
 DEFINE_SIMPLE_ATTRIBUTE(fops_u64_wo, NULL, debugfs_u64_set, "%llu\n");
 
-static struct dentry *mydebugfs_create(const char *name, umode_t mode,
-				       struct dentry *parent, u64 *value)
-{
-	return debugfs_create_file(name, mode, parent, value, &fops_u64_wo);
-}
-
 static void setup_skx_debug(void)
 {
-	skx_test = debugfs_create_dir("skx_edac_test", NULL);
-	mydebugfs_create("addr", S_IWUSR, skx_test, &skx_fake_addr);
+	skx_test = edac_debugfs_create_dir("skx_test");
+	if (!skx_test)
+		return;
+
+	if (!edac_debugfs_create_file("addr", 0200, skx_test,
+				      NULL, &fops_u64_wo)) {
+		debugfs_remove(skx_test);
+		skx_test = NULL;
+	}
 }
 
 static void teardown_skx_debug(void)
diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
index 513908a0c262..e795bd9c8038 100644
--- a/drivers/firmware/qcom_scm.c
+++ b/drivers/firmware/qcom_scm.c
@@ -586,8 +586,7 @@ static int qcom_scm_probe(struct platform_device *pdev)
 static void qcom_scm_shutdown(struct platform_device *pdev)
 {
 	/* Clean shutdown, disable download mode to allow normal restart */
-	if (download_mode)
-		qcom_scm_set_download_mode(false);
+	qcom_scm_set_download_mode(false);
 }
 
 static const struct of_device_id qcom_scm_dt_match[] = {
diff --git a/drivers/fpga/fpga-bridge.c b/drivers/fpga/fpga-bridge.c
index c983dac97501..c7db12192fac 100644
--- a/drivers/fpga/fpga-bridge.c
+++ b/drivers/fpga/fpga-bridge.c
@@ -121,7 +121,7 @@ static int fpga_bridge_dev_match(struct device *dev, const void *data)
 /**
  * fpga_bridge_get - get an exclusive reference to a fpga bridge
  * @dev:	parent device that fpga bridge was registered with
- * @info:	fpga manager info
+ * @info:	fpga image specific information
  *
  * Given a device, get an exclusive reference to a fpga bridge.
  *
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index acbd33fcb73d..45e6dfa330ad 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -950,6 +950,12 @@ struct amdgpu_gfx {
 	/* NGG */
 	struct amdgpu_ngg		ngg;
 
+	/* gfx off */
+	bool                            gfx_off_state; /* true: enabled, false: disabled */
+	struct mutex                    gfx_off_mutex;
+	uint32_t                        gfx_off_req_count; /* default 1, enable gfx off: dec 1, disable gfx off: add 1 */
+	struct delayed_work             gfx_off_delay_work;
+
 	/* pipe reservation */
 	struct mutex			pipe_reserve_mutex;
 	DECLARE_BITMAP			(pipe_reserve_bitmap, AMDGPU_MAX_COMPUTE_QUEUES);
@@ -1776,6 +1782,7 @@ void amdgpu_device_program_register_sequence(struct amdgpu_device *adev,
 					     const u32 array_size);
 
 bool amdgpu_device_is_px(struct drm_device *dev);
+void amdgpu_gfx_off_ctrl(struct amdgpu_device *adev, bool enable);
 /* atpx handler */
 #if defined(CONFIG_VGA_SWITCHEROO)
 void amdgpu_register_atpx_handler(void);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 102b05b8f0c2..787cbeea8dc5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1927,6 +1927,19 @@ static void amdgpu_device_ip_late_init_func_handler(struct work_struct *work)
 		DRM_ERROR("ib ring test failed (%d).\n", r);
 }
 
+static void amdgpu_device_delay_enable_gfx_off(struct work_struct *work)
+{
+	struct amdgpu_device *adev =
+		container_of(work, struct amdgpu_device, gfx.gfx_off_delay_work.work);
+
+	mutex_lock(&adev->gfx.gfx_off_mutex);
+	if (!adev->gfx.gfx_off_state && !adev->gfx.gfx_off_req_count) {
+		if (!amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_GFX, true))
+			adev->gfx.gfx_off_state = true;
+	}
+	mutex_unlock(&adev->gfx.gfx_off_mutex);
+}
+
 /**
  * amdgpu_device_ip_suspend_phase1 - run suspend for hardware IPs (phase 1)
  *
@@ -2369,6 +2382,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	mutex_init(&adev->gfx.gpu_clock_mutex);
 	mutex_init(&adev->srbm_mutex);
 	mutex_init(&adev->gfx.pipe_reserve_mutex);
+	mutex_init(&adev->gfx.gfx_off_mutex);
 	mutex_init(&adev->grbm_idx_mutex);
 	mutex_init(&adev->mn_lock);
 	mutex_init(&adev->virt.vf_errors.lock);
@@ -2395,7 +2409,10 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 
 	INIT_DELAYED_WORK(&adev->late_init_work,
 			  amdgpu_device_ip_late_init_func_handler);
+	INIT_DELAYED_WORK(&adev->gfx.gfx_off_delay_work,
+			  amdgpu_device_delay_enable_gfx_off);
 
+	adev->gfx.gfx_off_req_count = 1;
 	adev->pm.ac_power = power_supply_is_system_supplied() > 0 ? true : false;
 
 	/* Registers mapping */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index eeaa2e825858..af42c2464a59 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -26,6 +26,9 @@
 #include "amdgpu.h"
 #include "amdgpu_gfx.h"
 
+/* 0.5 second timeout */
+#define GFX_OFF_DELAY_ENABLE         msecs_to_jiffies(500)
+
 /*
  * GPU scratch registers helpers function.
  */
@@ -340,3 +343,40 @@ void amdgpu_gfx_compute_mqd_sw_fini(struct amdgpu_device *adev)
 			      &ring->mqd_gpu_addr,
 			      &ring->mqd_ptr);
 }
+
+/* amdgpu_gfx_off_ctrl - Handle gfx off feature enable/disable
+ *
+ * @adev: amdgpu_device pointer
+ * @bool enable true: enable gfx off feature, false: disable gfx off feature
+ *
+ * 1. gfx off feature will be enabled by gfx ip after gfx cg gp enabled.
+ * 2. other client can send request to disable gfx off feature, the request should be honored.
+ * 3. other client can cancel their request of disable gfx off feature
+ * 4. other client should not send request to enable gfx off feature before disable gfx off feature.
+ */
+
+void amdgpu_gfx_off_ctrl(struct amdgpu_device *adev, bool enable)
+{
+	if (!(adev->powerplay.pp_feature & PP_GFXOFF_MASK))
+		return;
+
+	if (!adev->powerplay.pp_funcs->set_powergating_by_smu)
+		return;
+
+
+	mutex_lock(&adev->gfx.gfx_off_mutex);
+
+	if (!enable)
+		adev->gfx.gfx_off_req_count++;
+	else if (adev->gfx.gfx_off_req_count > 0)
+		adev->gfx.gfx_off_req_count--;
+
+	if (enable && !adev->gfx.gfx_off_state && !adev->gfx.gfx_off_req_count) {
+		schedule_delayed_work(&adev->gfx.gfx_off_delay_work, GFX_OFF_DELAY_ENABLE);
+	} else if (!enable && adev->gfx.gfx_off_state) {
+		if (!amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_GFX, false))
+			adev->gfx.gfx_off_state = false;
+	}
+
+	mutex_unlock(&adev->gfx.gfx_off_mutex);
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c
index 0b70410488b6..018f06f154b8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c
@@ -55,6 +55,7 @@ static int amdgpu_sched_process_priority_override(struct amdgpu_device *adev,
 {
 	struct file *filp = fget(fd);
 	struct amdgpu_fpriv *fpriv;
+	struct amdgpu_ctx_mgr *mgr;
 	struct amdgpu_ctx *ctx;
 	uint32_t id;
 	int r;
@@ -68,14 +69,50 @@ static int amdgpu_sched_process_priority_override(struct amdgpu_device *adev,
 		return r;
 	}
 
-	idr_for_each_entry(&fpriv->ctx_mgr.ctx_handles, ctx, id)
+	mgr = &fpriv->ctx_mgr;
+	mutex_lock(&mgr->lock);
+	idr_for_each_entry(&mgr->ctx_handles, ctx, id)
 		amdgpu_ctx_priority_override(ctx, priority);
+	mutex_unlock(&mgr->lock);
 
 	fput(filp);
 
 	return 0;
 }
 
+static int amdgpu_sched_context_priority_override(struct amdgpu_device *adev,
+						  int fd,
+						  unsigned ctx_id,
+						  enum drm_sched_priority priority)
+{
+	struct file *filp = fget(fd);
+	struct amdgpu_fpriv *fpriv;
+	struct amdgpu_ctx *ctx;
+	int r;
+
+	if (!filp)
+		return -EINVAL;
+
+	r = amdgpu_file_to_fpriv(filp, &fpriv);
+	if (r) {
+		fput(filp);
+		return r;
+	}
+
+	ctx = amdgpu_ctx_get(fpriv, ctx_id);
+
+	if (!ctx) {
+		fput(filp);
+		return -EINVAL;
+	}
+
+	amdgpu_ctx_priority_override(ctx, priority);
+	amdgpu_ctx_put(ctx);
+	fput(filp);
+
+	return 0;
+}
+
 int amdgpu_sched_ioctl(struct drm_device *dev, void *data,
 		       struct drm_file *filp)
 {
@@ -85,7 +122,7 @@ int amdgpu_sched_ioctl(struct drm_device *dev, void *data,
 	int r;
 
 	priority = amdgpu_to_sched_priority(args->in.priority);
-	if (args->in.flags || priority == DRM_SCHED_PRIORITY_INVALID)
+	if (priority == DRM_SCHED_PRIORITY_INVALID)
 		return -EINVAL;
 
 	switch (args->in.op) {
@@ -94,6 +131,12 @@ int amdgpu_sched_ioctl(struct drm_device *dev, void *data,
 							   args->in.fd,
 							   priority);
 		break;
+	case AMDGPU_SCHED_OP_CONTEXT_PRIORITY_OVERRIDE:
+		r = amdgpu_sched_context_priority_override(adev,
+							   args->in.fd,
+							   args->in.ctx_id,
+							   priority);
+		break;
 	default:
 		DRM_ERROR("Invalid sched op specified: %d\n", args->in.op);
 		r = -EINVAL;
diff --git a/drivers/gpu/drm/drm_probe_helper.c b/drivers/gpu/drm/drm_probe_helper.c
index c0b26135dbd5..f9e0594ee702 100644
--- a/drivers/gpu/drm/drm_probe_helper.c
+++ b/drivers/gpu/drm/drm_probe_helper.c
@@ -459,8 +459,9 @@ int drm_helper_probe_single_connector_modes(struct drm_connector *connector,
 		 */
 		dev->mode_config.delayed_event = true;
 		if (dev->mode_config.poll_enabled)
-			schedule_delayed_work(&dev->mode_config.output_poll_work,
-					      0);
+			mod_delayed_work(system_wq,
+					 &dev->mode_config.output_poll_work,
+					 0);
 	}
 
 	/* Re-enable polling in case the global poll config changed. */
diff --git a/drivers/gpu/drm/msm/adreno/adreno_device.c b/drivers/gpu/drm/msm/adreno/adreno_device.c
index 7d3e9a129ac7..7acb53a907e5 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_device.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_device.c
@@ -190,8 +190,11 @@ struct msm_gpu *adreno_load_gpu(struct drm_device *dev)
 	if (ret)
 		return NULL;
 
-	/* Make sure pm runtime is active and reset any previous errors */
-	pm_runtime_set_active(&pdev->dev);
+	/*
+	 * Now that we have firmware loaded, and are ready to begin
+	 * booting the gpu, go ahead and enable runpm:
+	 */
+	pm_runtime_enable(&pdev->dev);
 
 	ret = pm_runtime_get_sync(&pdev->dev);
 	if (ret < 0) {
diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
index c9f831604558..6da144c39409 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
@@ -725,7 +725,6 @@ int adreno_gpu_init(struct drm_device *drm, struct platform_device *pdev,
 	pm_runtime_set_autosuspend_delay(&pdev->dev,
 		adreno_gpu->info->inactive_period);
 	pm_runtime_use_autosuspend(&pdev->dev);
-	pm_runtime_enable(&pdev->dev);
 
 	return msm_gpu_init(drm, pdev, &adreno_gpu->base, &funcs->base,
 			adreno_gpu->info->name, &adreno_gpu_config);
diff --git a/drivers/gpu/drm/panel/panel-orisetech-otm8009a.c b/drivers/gpu/drm/panel/panel-orisetech-otm8009a.c
index 58ccf648b70f..e88a7d95a00c 100644
--- a/drivers/gpu/drm/panel/panel-orisetech-otm8009a.c
+++ b/drivers/gpu/drm/panel/panel-orisetech-otm8009a.c
@@ -454,7 +454,7 @@ static int otm8009a_probe(struct mipi_dsi_device *dsi)
 	ctx->panel.funcs = &otm8009a_drm_funcs;
 
 	ctx->bl_dev = devm_backlight_device_register(dev, dev_name(dev),
-						     dsi->host->dev, ctx,
+						     dev, ctx,
 						     &otm8009a_backlight_ops,
 						     NULL);
 	if (IS_ERR(ctx->bl_dev)) {
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_gem.c b/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
index a8db758d523e..94242fa9e25d 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
@@ -270,9 +270,6 @@ static int rockchip_drm_gem_object_mmap(struct drm_gem_object *obj,
 	else
 		ret = rockchip_drm_gem_object_mmap_dma(obj, vma);
 
-	if (ret)
-		drm_gem_vm_close(vma);
-
 	return ret;
 }
 
diff --git a/drivers/gpu/drm/vgem/vgem_fence.c b/drivers/gpu/drm/vgem/vgem_fence.c
index b28876c222b4..04527d8f3623 100644
--- a/drivers/gpu/drm/vgem/vgem_fence.c
+++ b/drivers/gpu/drm/vgem/vgem_fence.c
@@ -280,4 +280,5 @@ void vgem_fence_close(struct vgem_file *vfile)
 {
 	idr_for_each(&vfile->fence_idr, __vgem_fence_idr_fini, vfile);
 	idr_destroy(&vfile->fence_idr);
+	mutex_destroy(&vfile->fence_mutex);
 }
diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index bc4d6474d8f5..da6053deb954 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -1791,6 +1791,7 @@ static void wacom_map_usage(struct input_dev *input, struct hid_usage *usage,
 	int fmax = field->logical_maximum;
 	unsigned int equivalent_usage = wacom_equivalent_usage(usage->hid);
 	int resolution_code = code;
+	int resolution = hidinput_calc_abs_res(field, resolution_code);
 
 	if (equivalent_usage == HID_DG_TWIST) {
 		resolution_code = ABS_RZ;
@@ -1813,8 +1814,15 @@ static void wacom_map_usage(struct input_dev *input, struct hid_usage *usage,
 	switch (type) {
 	case EV_ABS:
 		input_set_abs_params(input, code, fmin, fmax, fuzz, 0);
-		input_abs_set_res(input, code,
-				  hidinput_calc_abs_res(field, resolution_code));
+
+		/* older tablet may miss physical usage */
+		if ((code == ABS_X || code == ABS_Y) && !resolution) {
+			resolution = WACOM_INTUOS_RES;
+			hid_warn(input,
+				 "Wacom usage (%d) missing resolution \n",
+				 code);
+		}
+		input_abs_set_res(input, code, resolution);
 		break;
 	case EV_KEY:
 		input_set_capability(input, EV_KEY, code);
diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index cd9c65f3d404..11321ad482a3 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -1027,7 +1027,7 @@ omap_i2c_isr(int irq, void *dev_id)
 	u16 stat;
 
 	stat = omap_i2c_read_reg(omap, OMAP_I2C_STAT_REG);
-	mask = omap_i2c_read_reg(omap, OMAP_I2C_IE_REG);
+	mask = omap_i2c_read_reg(omap, OMAP_I2C_IE_REG) & ~OMAP_I2C_STAT_NACK;
 
 	if (stat & mask)
 		ret = IRQ_WAKE_THREAD;
diff --git a/drivers/iio/adc/palmas_gpadc.c b/drivers/iio/adc/palmas_gpadc.c
index 7dcd4213d38a..6b76622b4fbf 100644
--- a/drivers/iio/adc/palmas_gpadc.c
+++ b/drivers/iio/adc/palmas_gpadc.c
@@ -633,7 +633,7 @@ static int palmas_gpadc_probe(struct platform_device *pdev)
 
 static int palmas_gpadc_remove(struct platform_device *pdev)
 {
-	struct iio_dev *indio_dev = dev_to_iio_dev(&pdev->dev);
+	struct iio_dev *indio_dev = dev_get_drvdata(&pdev->dev);
 	struct palmas_gpadc *adc = iio_priv(indio_dev);
 
 	if (adc->wakeup1_enable || adc->wakeup2_enable)
diff --git a/drivers/infiniband/hw/hfi1/mmu_rb.c b/drivers/infiniband/hw/hfi1/mmu_rb.c
index e1c7996c018e..513a297b4ff0 100644
--- a/drivers/infiniband/hw/hfi1/mmu_rb.c
+++ b/drivers/infiniband/hw/hfi1/mmu_rb.c
@@ -175,7 +175,7 @@ int hfi1_mmu_rb_insert(struct mmu_rb_handler *handler,
 		goto unlock;
 	}
 	__mmu_int_rb_insert(mnode, &handler->root);
-	list_add(&mnode->list, &handler->lru_list);
+	list_add_tail(&mnode->list, &handler->lru_list);
 
 	ret = handler->ops->insert(handler->ops_arg, mnode);
 	if (ret) {
@@ -222,8 +222,10 @@ bool hfi1_mmu_rb_remove_unless_exact(struct mmu_rb_handler *handler,
 	spin_lock_irqsave(&handler->lock, flags);
 	node = __mmu_rb_search(handler, addr, len);
 	if (node) {
-		if (node->addr == addr && node->len == len)
+		if (node->addr == addr && node->len == len) {
+			list_move_tail(&node->list, &handler->lru_list);
 			goto unlock;
+		}
 		__mmu_int_rb_remove(node, &handler->root);
 		list_del(&node->list); /* remove from LRU list */
 		ret = true;
@@ -244,8 +246,7 @@ void hfi1_mmu_rb_evict(struct mmu_rb_handler *handler, void *evict_arg)
 	INIT_LIST_HEAD(&del_list);
 
 	spin_lock_irqsave(&handler->lock, flags);
-	list_for_each_entry_safe_reverse(rbnode, ptr, &handler->lru_list,
-					 list) {
+	list_for_each_entry_safe(rbnode, ptr, &handler->lru_list, list) {
 		if (handler->ops->evict(handler->ops_arg, rbnode, evict_arg,
 					&stop)) {
 			__mmu_int_rb_remove(rbnode, &handler->root);
@@ -257,9 +258,7 @@ void hfi1_mmu_rb_evict(struct mmu_rb_handler *handler, void *evict_arg)
 	}
 	spin_unlock_irqrestore(&handler->lock, flags);
 
-	while (!list_empty(&del_list)) {
-		rbnode = list_first_entry(&del_list, struct mmu_rb_node, list);
-		list_del(&rbnode->list);
+	list_for_each_entry_safe(rbnode, ptr, &del_list, list) {
 		handler->ops->remove(handler->ops_arg, rbnode);
 	}
 }
diff --git a/drivers/infiniband/hw/mlx4/qp.c b/drivers/infiniband/hw/mlx4/qp.c
index 7209b8a9b0dd..87358b8c4558 100644
--- a/drivers/infiniband/hw/mlx4/qp.c
+++ b/drivers/infiniband/hw/mlx4/qp.c
@@ -436,9 +436,13 @@ static int set_user_sq_size(struct mlx4_ib_dev *dev,
 			    struct mlx4_ib_qp *qp,
 			    struct mlx4_ib_create_qp *ucmd)
 {
+	u32 cnt;
+
 	/* Sanity check SQ size before proceeding */
-	if ((1 << ucmd->log_sq_bb_count) > dev->dev->caps.max_wqes	 ||
-	    ucmd->log_sq_stride >
+	if (check_shl_overflow(1, ucmd->log_sq_bb_count, &cnt) ||
+	    cnt > dev->dev->caps.max_wqes)
+		return -EINVAL;
+	if (ucmd->log_sq_stride >
 		ilog2(roundup_pow_of_two(dev->dev->caps.max_sq_desc_sz)) ||
 	    ucmd->log_sq_stride < MLX4_IB_MIN_SQ_STRIDE)
 		return -EINVAL;
diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index 1520a3098f7d..0455abfba41c 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -3350,7 +3350,7 @@ static int mlx5_ib_modify_dct(struct ib_qp *ibqp, struct ib_qp_attr *attr,
 			return -EINVAL;
 
 		if (attr->port_num == 0 ||
-		    attr->port_num > MLX5_CAP_GEN(dev->mdev, num_ports)) {
+		    attr->port_num > dev->num_ports) {
 			mlx5_ib_dbg(dev, "invalid port number %d. number of ports is %d\n",
 				    attr->port_num, dev->num_ports);
 			return -EINVAL;
diff --git a/drivers/infiniband/sw/rdmavt/qp.c b/drivers/infiniband/sw/rdmavt/qp.c
index fbc316775669..c12fc2eace16 100644
--- a/drivers/infiniband/sw/rdmavt/qp.c
+++ b/drivers/infiniband/sw/rdmavt/qp.c
@@ -321,8 +321,6 @@ void rvt_qp_exit(struct rvt_dev_info *rdi)
 	if (qps_inuse)
 		rvt_pr_err(rdi, "QP memory leak! %u still in use\n",
 			   qps_inuse);
-	if (!rdi->qp_dev)
-		return;
 
 	kfree(rdi->qp_dev->qp_table);
 	free_qpn_table(&rdi->qp_dev->qpn_table);
diff --git a/drivers/macintosh/Kconfig b/drivers/macintosh/Kconfig
index a316624742f6..c3d421c7b0cf 100644
--- a/drivers/macintosh/Kconfig
+++ b/drivers/macintosh/Kconfig
@@ -83,6 +83,7 @@ config ADB_PMU_LED
 
 config ADB_PMU_LED_DISK
 	bool "Use front LED as DISK LED by default"
+	depends on ATA
 	depends on ADB_PMU_LED
 	depends on LEDS_CLASS
 	select LEDS_TRIGGERS
diff --git a/drivers/macintosh/windfarm_smu_sat.c b/drivers/macintosh/windfarm_smu_sat.c
index 51ef77de4174..3d4b8c33640a 100644
--- a/drivers/macintosh/windfarm_smu_sat.c
+++ b/drivers/macintosh/windfarm_smu_sat.c
@@ -172,6 +172,7 @@ static void wf_sat_release(struct kref *ref)
 
 	if (sat->nr >= 0)
 		sats[sat->nr] = NULL;
+	of_node_put(sat->node);
 	kfree(sat);
 }
 
diff --git a/drivers/md/dm-flakey.c b/drivers/md/dm-flakey.c
index 1f1614af5e97..5116856ea81d 100644
--- a/drivers/md/dm-flakey.c
+++ b/drivers/md/dm-flakey.c
@@ -124,9 +124,9 @@ static int parse_features(struct dm_arg_set *as, struct flakey_c *fc,
 			 * Direction r or w?
 			 */
 			arg_name = dm_shift_arg(as);
-			if (!strcasecmp(arg_name, "w"))
+			if (arg_name && !strcasecmp(arg_name, "w"))
 				fc->corrupt_bio_rw = WRITE;
-			else if (!strcasecmp(arg_name, "r"))
+			else if (arg_name && !strcasecmp(arg_name, "r"))
 				fc->corrupt_bio_rw = READ;
 			else {
 				ti->error = "Invalid corrupt bio direction (r or w)";
diff --git a/drivers/md/dm-integrity.c b/drivers/md/dm-integrity.c
index b054271066ac..0a4e440948f0 100644
--- a/drivers/md/dm-integrity.c
+++ b/drivers/md/dm-integrity.c
@@ -3689,11 +3689,13 @@ int __init dm_integrity_init(void)
 	}
 
 	r = dm_register_target(&integrity_target);
-
-	if (r < 0)
+	if (r < 0) {
 		DMERR("register failed %d", r);
+		kmem_cache_destroy(journal_io_cache);
+		return r;
+	}
 
-	return r;
+	return 0;
 }
 
 void dm_integrity_exit(void)
diff --git a/drivers/md/dm-ioctl.c b/drivers/md/dm-ioctl.c
index 0c8ddf37ef39..e1603c17e346 100644
--- a/drivers/md/dm-ioctl.c
+++ b/drivers/md/dm-ioctl.c
@@ -1410,11 +1410,12 @@ static int table_clear(struct file *filp, struct dm_ioctl *param, size_t param_s
 		hc->new_map = NULL;
 	}
 
-	param->flags &= ~DM_INACTIVE_PRESENT_FLAG;
-
-	__dev_status(hc->md, param);
 	md = hc->md;
 	up_write(&_hash_lock);
+
+	param->flags &= ~DM_INACTIVE_PRESENT_FLAG;
+	__dev_status(md, param);
+
 	if (old_map) {
 		dm_sync_table(md);
 		dm_table_destroy(old_map);
diff --git a/drivers/md/dm-verity-target.c b/drivers/md/dm-verity-target.c
index 36945030520a..d116495a3445 100644
--- a/drivers/md/dm-verity-target.c
+++ b/drivers/md/dm-verity-target.c
@@ -471,13 +471,14 @@ static int verity_verify_io(struct dm_verity_io *io)
 	struct bvec_iter start;
 	unsigned b;
 	struct crypto_wait wait;
+	struct bio *bio = dm_bio_from_per_bio_data(io, v->ti->per_io_data_size);
 
 	for (b = 0; b < io->n_blocks; b++) {
 		int r;
 		sector_t cur_block = io->block + b;
 		struct ahash_request *req = verity_io_hash_req(v, io);
 
-		if (v->validated_blocks &&
+		if (v->validated_blocks && bio->bi_status == BLK_STS_OK &&
 		    likely(test_bit(cur_block, v->validated_blocks))) {
 			verity_bv_skip_block(v, io, &io->iter);
 			continue;
@@ -525,9 +526,17 @@ static int verity_verify_io(struct dm_verity_io *io)
 		else if (verity_fec_decode(v, io, DM_VERITY_BLOCK_TYPE_DATA,
 					   cur_block, NULL, &start) == 0)
 			continue;
-		else if (verity_handle_err(v, DM_VERITY_BLOCK_TYPE_DATA,
-					   cur_block))
-			return -EIO;
+		else {
+			if (bio->bi_status) {
+				/*
+				 * Error correction failed; Just return error
+				 */
+				return -EIO;
+			}
+			if (verity_handle_err(v, DM_VERITY_BLOCK_TYPE_DATA,
+					      cur_block))
+				return -EIO;
+		}
 	}
 
 	return 0;
diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index 9f9cd2fadc1e..f6d2be1d2386 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -2266,11 +2266,22 @@ static void recovery_request_write(struct mddev *mddev, struct r10bio *r10_bio)
 {
 	struct r10conf *conf = mddev->private;
 	int d;
-	struct bio *wbio, *wbio2;
+	struct bio *wbio = r10_bio->devs[1].bio;
+	struct bio *wbio2 = r10_bio->devs[1].repl_bio;
+
+	/* Need to test wbio2->bi_end_io before we call
+	 * generic_make_request as if the former is NULL,
+	 * the latter is free to free wbio2.
+	 */
+	if (wbio2 && !wbio2->bi_end_io)
+		wbio2 = NULL;
 
 	if (!test_bit(R10BIO_Uptodate, &r10_bio->state)) {
 		fix_recovery_read_error(r10_bio);
-		end_sync_request(r10_bio);
+		if (wbio->bi_end_io)
+			end_sync_request(r10_bio);
+		if (wbio2)
+			end_sync_request(r10_bio);
 		return;
 	}
 
@@ -2279,14 +2290,6 @@ static void recovery_request_write(struct mddev *mddev, struct r10bio *r10_bio)
 	 * and submit the write request
 	 */
 	d = r10_bio->devs[1].devnum;
-	wbio = r10_bio->devs[1].bio;
-	wbio2 = r10_bio->devs[1].repl_bio;
-	/* Need to test wbio2->bi_end_io before we call
-	 * generic_make_request as if the former is NULL,
-	 * the latter is free to free wbio2.
-	 */
-	if (wbio2 && !wbio2->bi_end_io)
-		wbio2 = NULL;
 	if (wbio->bi_end_io) {
 		atomic_inc(&conf->mirrors[d].rdev->nr_pending);
 		md_sync_acct(conf->mirrors[d].rdev->bdev, bio_sectors(wbio));
@@ -2954,10 +2957,6 @@ static sector_t raid10_sync_request(struct mddev *mddev, sector_t sector_nr,
 	sector_t chunk_mask = conf->geo.chunk_mask;
 	int page_idx = 0;
 
-	if (!mempool_initialized(&conf->r10buf_pool))
-		if (init_resync(conf))
-			return 0;
-
 	/*
 	 * Allow skipping a full rebuild for incremental assembly
 	 * of a clean array, like RAID1 does.
@@ -2973,6 +2972,10 @@ static sector_t raid10_sync_request(struct mddev *mddev, sector_t sector_nr,
 		return mddev->dev_sectors - sector_nr;
 	}
 
+	if (!mempool_initialized(&conf->r10buf_pool))
+		if (init_resync(conf))
+			return 0;
+
  skipped:
 	max_sector = mddev->dev_sectors;
 	if (test_bit(MD_RECOVERY_SYNC, &mddev->recovery) ||
@@ -3668,6 +3671,20 @@ static int setup_geo(struct geom *geo, struct mddev *mddev, enum geo_type new)
 	return nc*fc;
 }
 
+static void raid10_free_conf(struct r10conf *conf)
+{
+	if (!conf)
+		return;
+
+	mempool_exit(&conf->r10bio_pool);
+	kfree(conf->mirrors);
+	kfree(conf->mirrors_old);
+	kfree(conf->mirrors_new);
+	safe_put_page(conf->tmppage);
+	bioset_exit(&conf->bio_split);
+	kfree(conf);
+}
+
 static struct r10conf *setup_conf(struct mddev *mddev)
 {
 	struct r10conf *conf = NULL;
@@ -3750,20 +3767,24 @@ static struct r10conf *setup_conf(struct mddev *mddev)
 	return conf;
 
  out:
-	if (conf) {
-		mempool_exit(&conf->r10bio_pool);
-		kfree(conf->mirrors);
-		safe_put_page(conf->tmppage);
-		bioset_exit(&conf->bio_split);
-		kfree(conf);
-	}
+	raid10_free_conf(conf);
 	return ERR_PTR(err);
 }
 
+static void raid10_set_io_opt(struct r10conf *conf)
+{
+	int raid_disks = conf->geo.raid_disks;
+
+	if (!(conf->geo.raid_disks % conf->geo.near_copies))
+		raid_disks /= conf->geo.near_copies;
+	blk_queue_io_opt(conf->mddev->queue, (conf->mddev->chunk_sectors << 9) *
+			 raid_disks);
+}
+
 static int raid10_run(struct mddev *mddev)
 {
 	struct r10conf *conf;
-	int i, disk_idx, chunk_size;
+	int i, disk_idx;
 	struct raid10_info *disk;
 	struct md_rdev *rdev;
 	sector_t size;
@@ -3784,6 +3805,9 @@ static int raid10_run(struct mddev *mddev)
 	if (!conf)
 		goto out;
 
+	mddev->thread = conf->thread;
+	conf->thread = NULL;
+
 	if (mddev_is_clustered(conf->mddev)) {
 		int fc, fo;
 
@@ -3796,21 +3820,13 @@ static int raid10_run(struct mddev *mddev)
 		}
 	}
 
-	mddev->thread = conf->thread;
-	conf->thread = NULL;
-
-	chunk_size = mddev->chunk_sectors << 9;
 	if (mddev->queue) {
 		blk_queue_max_discard_sectors(mddev->queue,
 					      mddev->chunk_sectors);
 		blk_queue_max_write_same_sectors(mddev->queue, 0);
 		blk_queue_max_write_zeroes_sectors(mddev->queue, 0);
-		blk_queue_io_min(mddev->queue, chunk_size);
-		if (conf->geo.raid_disks % conf->geo.near_copies)
-			blk_queue_io_opt(mddev->queue, chunk_size * conf->geo.raid_disks);
-		else
-			blk_queue_io_opt(mddev->queue, chunk_size *
-					 (conf->geo.raid_disks / conf->geo.near_copies));
+		blk_queue_io_min(mddev->queue, mddev->chunk_sectors << 9);
+		raid10_set_io_opt(conf);
 	}
 
 	rdev_for_each(rdev, mddev) {
@@ -3970,10 +3986,7 @@ static int raid10_run(struct mddev *mddev)
 
 out_free_conf:
 	md_unregister_thread(&mddev->thread);
-	mempool_exit(&conf->r10bio_pool);
-	safe_put_page(conf->tmppage);
-	kfree(conf->mirrors);
-	kfree(conf);
+	raid10_free_conf(conf);
 	mddev->private = NULL;
 out:
 	return -EIO;
@@ -3981,15 +3994,7 @@ static int raid10_run(struct mddev *mddev)
 
 static void raid10_free(struct mddev *mddev, void *priv)
 {
-	struct r10conf *conf = priv;
-
-	mempool_exit(&conf->r10bio_pool);
-	safe_put_page(conf->tmppage);
-	kfree(conf->mirrors);
-	kfree(conf->mirrors_old);
-	kfree(conf->mirrors_new);
-	bioset_exit(&conf->bio_split);
-	kfree(conf);
+	raid10_free_conf(priv);
 }
 
 static void raid10_quiesce(struct mddev *mddev, int quiesce)
@@ -4724,6 +4729,7 @@ static void end_reshape(struct r10conf *conf)
 		stripe /= conf->geo.near_copies;
 		if (conf->mddev->queue->backing_dev_info->ra_pages < 2 * stripe)
 			conf->mddev->queue->backing_dev_info->ra_pages = 2 * stripe;
+		raid10_set_io_opt(conf);
 	}
 	conf->fullsync = 0;
 }
diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 7fe0619c487a..7eeae0301ccc 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -7153,6 +7153,12 @@ static int only_parity(int raid_disk, int algo, int raid_disks, int max_degraded
 	return 0;
 }
 
+static void raid5_set_io_opt(struct r5conf *conf)
+{
+	blk_queue_io_opt(conf->mddev->queue, (conf->chunk_sectors << 9) *
+			 (conf->raid_disks - conf->max_degraded));
+}
+
 static int raid5_run(struct mddev *mddev)
 {
 	struct r5conf *conf;
@@ -7442,8 +7448,7 @@ static int raid5_run(struct mddev *mddev)
 
 		chunk_size = mddev->chunk_sectors << 9;
 		blk_queue_io_min(mddev->queue, chunk_size);
-		blk_queue_io_opt(mddev->queue, chunk_size *
-				 (conf->raid_disks - conf->max_degraded));
+		raid5_set_io_opt(conf);
 		mddev->queue->limits.raid_partial_stripes_expensive = 1;
 		/*
 		 * We can only discard a whole stripe. It doesn't make sense to
@@ -8037,6 +8042,7 @@ static void end_reshape(struct r5conf *conf)
 						   / PAGE_SIZE);
 			if (conf->mddev->queue->backing_dev_info->ra_pages < 2 * stripe)
 				conf->mddev->queue->backing_dev_info->ra_pages = 2 * stripe;
+			raid5_set_io_opt(conf);
 		}
 	}
 }
diff --git a/drivers/media/pci/dm1105/dm1105.c b/drivers/media/pci/dm1105/dm1105.c
index 1ddb0576fb7b..dc3fc69e4480 100644
--- a/drivers/media/pci/dm1105/dm1105.c
+++ b/drivers/media/pci/dm1105/dm1105.c
@@ -1188,6 +1188,7 @@ static void dm1105_remove(struct pci_dev *pdev)
 	struct dvb_demux *dvbdemux = &dev->demux;
 	struct dmx_demux *dmx = &dvbdemux->dmx;
 
+	cancel_work_sync(&dev->ir.work);
 	dm1105_ir_exit(dev);
 	dmx->close(dmx);
 	dvb_net_release(&dev->dvbnet);
diff --git a/drivers/media/pci/saa7134/saa7134-ts.c b/drivers/media/pci/saa7134/saa7134-ts.c
index 2be703617e29..e7adcd4f9962 100644
--- a/drivers/media/pci/saa7134/saa7134-ts.c
+++ b/drivers/media/pci/saa7134/saa7134-ts.c
@@ -309,6 +309,7 @@ int saa7134_ts_start(struct saa7134_dev *dev)
 
 int saa7134_ts_fini(struct saa7134_dev *dev)
 {
+	del_timer_sync(&dev->ts_q.timeout);
 	saa7134_pgtable_free(dev->pci, &dev->ts_q.pt);
 	return 0;
 }
diff --git a/drivers/media/pci/saa7134/saa7134-vbi.c b/drivers/media/pci/saa7134/saa7134-vbi.c
index 57bea543c39b..559db500b19c 100644
--- a/drivers/media/pci/saa7134/saa7134-vbi.c
+++ b/drivers/media/pci/saa7134/saa7134-vbi.c
@@ -194,6 +194,7 @@ int saa7134_vbi_init1(struct saa7134_dev *dev)
 int saa7134_vbi_fini(struct saa7134_dev *dev)
 {
 	/* nothing */
+	del_timer_sync(&dev->vbi_q.timeout);
 	return 0;
 }
 
diff --git a/drivers/media/pci/saa7134/saa7134-video.c b/drivers/media/pci/saa7134/saa7134-video.c
index 079219288af7..90255ecb08ca 100644
--- a/drivers/media/pci/saa7134/saa7134-video.c
+++ b/drivers/media/pci/saa7134/saa7134-video.c
@@ -2213,6 +2213,7 @@ int saa7134_video_init1(struct saa7134_dev *dev)
 
 void saa7134_video_fini(struct saa7134_dev *dev)
 {
+	del_timer_sync(&dev->video_q.timeout);
 	/* free stuff */
 	vb2_queue_release(&dev->video_vbq);
 	saa7134_pgtable_free(dev->pci, &dev->video_q.pt);
diff --git a/drivers/media/pci/ttpci/av7110_av.c b/drivers/media/pci/ttpci/av7110_av.c
index ef1bc17cdc4d..03d1d1fba8bc 100644
--- a/drivers/media/pci/ttpci/av7110_av.c
+++ b/drivers/media/pci/ttpci/av7110_av.c
@@ -836,10 +836,10 @@ static int write_ts_to_decoder(struct av7110 *av7110, int type, const u8 *buf, s
 		av7110_ipack_flush(ipack);
 
 	if (buf[3] & ADAPT_FIELD) {
+		if (buf[4] > len - 1 - 4)
+			return 0;
 		len -= buf[4] + 1;
 		buf += buf[4] + 1;
-		if (!len)
-			return 0;
 	}
 
 	av7110_ipack_instant_repack(buf + 4, len - 4, ipack);
diff --git a/drivers/media/platform/rcar_fdp1.c b/drivers/media/platform/rcar_fdp1.c
index 2bd5898a6204..605d8188ac8c 100644
--- a/drivers/media/platform/rcar_fdp1.c
+++ b/drivers/media/platform/rcar_fdp1.c
@@ -2287,11 +2287,10 @@ static int fdp1_probe(struct platform_device *pdev)
 		return PTR_ERR(fdp1->regs);
 
 	/* Interrupt service routine registration */
-	fdp1->irq = ret = platform_get_irq(pdev, 0);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "cannot find IRQ\n");
+	ret = platform_get_irq(pdev, 0);
+	if (ret < 0)
 		return ret;
-	}
+	fdp1->irq = ret;
 
 	ret = devm_request_irq(&pdev->dev, fdp1->irq, fdp1_irq_handler, 0,
 			       dev_name(&pdev->dev), fdp1);
@@ -2314,8 +2313,10 @@ static int fdp1_probe(struct platform_device *pdev)
 
 	/* Determine our clock rate */
 	clk = clk_get(&pdev->dev, NULL);
-	if (IS_ERR(clk))
-		return PTR_ERR(clk);
+	if (IS_ERR(clk)) {
+		ret = PTR_ERR(clk);
+		goto put_dev;
+	}
 
 	fdp1->clk_rate = clk_get_rate(clk);
 	clk_put(clk);
@@ -2324,7 +2325,7 @@ static int fdp1_probe(struct platform_device *pdev)
 	ret = v4l2_device_register(&pdev->dev, &fdp1->v4l2_dev);
 	if (ret) {
 		v4l2_err(&fdp1->v4l2_dev, "Failed to register video device\n");
-		return ret;
+		goto put_dev;
 	}
 
 	/* M2M registration */
@@ -2389,6 +2390,8 @@ static int fdp1_probe(struct platform_device *pdev)
 unreg_dev:
 	v4l2_device_unregister(&fdp1->v4l2_dev);
 
+put_dev:
+	rcar_fcp_put(fdp1->fcp);
 	return ret;
 }
 
@@ -2400,6 +2403,7 @@ static int fdp1_remove(struct platform_device *pdev)
 	video_unregister_device(&fdp1->vfd);
 	v4l2_device_unregister(&fdp1->v4l2_dev);
 	pm_runtime_disable(&pdev->dev);
+	rcar_fcp_put(fdp1->fcp);
 
 	return 0;
 }
diff --git a/drivers/media/platform/sti/bdisp/bdisp-v4l2.c b/drivers/media/platform/sti/bdisp/bdisp-v4l2.c
index 00f6e3f06dac..7a7271f9d875 100644
--- a/drivers/media/platform/sti/bdisp/bdisp-v4l2.c
+++ b/drivers/media/platform/sti/bdisp/bdisp-v4l2.c
@@ -1312,6 +1312,8 @@ static int bdisp_probe(struct platform_device *pdev)
 	init_waitqueue_head(&bdisp->irq_queue);
 	INIT_DELAYED_WORK(&bdisp->timeout_work, bdisp_irq_timeout);
 	bdisp->work_queue = create_workqueue(BDISP_NAME);
+	if (!bdisp->work_queue)
+		return -ENOMEM;
 
 	spin_lock_init(&bdisp->slock);
 	mutex_init(&bdisp->lock);
diff --git a/drivers/media/rc/gpio-ir-recv.c b/drivers/media/rc/gpio-ir-recv.c
index 3d99b51384ac..ed5cfde4d9e7 100644
--- a/drivers/media/rc/gpio-ir-recv.c
+++ b/drivers/media/rc/gpio-ir-recv.c
@@ -91,6 +91,8 @@ static int gpio_ir_recv_probe(struct platform_device *pdev)
 		rcdev->map_name = RC_MAP_EMPTY;
 
 	gpio_dev->rcdev = rcdev;
+	if (of_property_read_bool(np, "wakeup-source"))
+		device_init_wakeup(dev, true);
 
 	rc = devm_rc_register_device(dev, rcdev);
 	if (rc < 0) {
diff --git a/drivers/misc/vmw_vmci/vmci_host.c b/drivers/misc/vmw_vmci/vmci_host.c
index 83e0c95d20a4..5acbf384ffa6 100644
--- a/drivers/misc/vmw_vmci/vmci_host.c
+++ b/drivers/misc/vmw_vmci/vmci_host.c
@@ -169,10 +169,16 @@ static int vmci_host_close(struct inode *inode, struct file *filp)
 static __poll_t vmci_host_poll(struct file *filp, poll_table *wait)
 {
 	struct vmci_host_dev *vmci_host_dev = filp->private_data;
-	struct vmci_ctx *context = vmci_host_dev->context;
+	struct vmci_ctx *context;
 	__poll_t mask = 0;
 
 	if (vmci_host_dev->ct_type == VMCIOBJ_CONTEXT) {
+		/*
+		 * Read context only if ct_type == VMCIOBJ_CONTEXT to make
+		 * sure that context is initialized
+		 */
+		context = vmci_host_dev->context;
+
 		/* Check for VMCI calls to this VM context. */
 		if (wait)
 			poll_wait(filp, &context->host_context.wait_queue,
diff --git a/drivers/mtd/spi-nor/cadence-quadspi.c b/drivers/mtd/spi-nor/cadence-quadspi.c
index a92f531ad23a..d5c6b91fd113 100644
--- a/drivers/mtd/spi-nor/cadence-quadspi.c
+++ b/drivers/mtd/spi-nor/cadence-quadspi.c
@@ -80,9 +80,6 @@ struct cqspi_st {
 	dma_addr_t		mmap_phys_base;
 
 	int			current_cs;
-	int			current_page_size;
-	int			current_erase_size;
-	int			current_addr_width;
 	unsigned long		master_ref_clk_hz;
 	bool			is_decoded_cs;
 	u32			fifo_depth;
@@ -734,32 +731,6 @@ static void cqspi_chipselect(struct spi_nor *nor)
 	writel(reg, reg_base + CQSPI_REG_CONFIG);
 }
 
-static void cqspi_configure_cs_and_sizes(struct spi_nor *nor)
-{
-	struct cqspi_flash_pdata *f_pdata = nor->priv;
-	struct cqspi_st *cqspi = f_pdata->cqspi;
-	void __iomem *iobase = cqspi->iobase;
-	unsigned int reg;
-
-	/* configure page size and block size. */
-	reg = readl(iobase + CQSPI_REG_SIZE);
-	reg &= ~(CQSPI_REG_SIZE_PAGE_MASK << CQSPI_REG_SIZE_PAGE_LSB);
-	reg &= ~(CQSPI_REG_SIZE_BLOCK_MASK << CQSPI_REG_SIZE_BLOCK_LSB);
-	reg &= ~CQSPI_REG_SIZE_ADDRESS_MASK;
-	reg |= (nor->page_size << CQSPI_REG_SIZE_PAGE_LSB);
-	reg |= (ilog2(nor->mtd.erasesize) << CQSPI_REG_SIZE_BLOCK_LSB);
-	reg |= (nor->addr_width - 1);
-	writel(reg, iobase + CQSPI_REG_SIZE);
-
-	/* configure the chip select */
-	cqspi_chipselect(nor);
-
-	/* Store the new configuration of the controller */
-	cqspi->current_page_size = nor->page_size;
-	cqspi->current_erase_size = nor->mtd.erasesize;
-	cqspi->current_addr_width = nor->addr_width;
-}
-
 static unsigned int calculate_ticks_for_ns(const unsigned int ref_clk_hz,
 					   const unsigned int ns_val)
 {
@@ -865,18 +836,13 @@ static void cqspi_configure(struct spi_nor *nor)
 	int switch_cs = (cqspi->current_cs != f_pdata->cs);
 	int switch_ck = (cqspi->sclk != sclk);
 
-	if ((cqspi->current_page_size != nor->page_size) ||
-	    (cqspi->current_erase_size != nor->mtd.erasesize) ||
-	    (cqspi->current_addr_width != nor->addr_width))
-		switch_cs = 1;
-
 	if (switch_cs || switch_ck)
 		cqspi_controller_enable(cqspi, 0);
 
 	/* Switch chip select. */
 	if (switch_cs) {
 		cqspi->current_cs = f_pdata->cs;
-		cqspi_configure_cs_and_sizes(nor);
+		cqspi_chipselect(nor);
 	}
 
 	/* Setup baudrate divisor and delays */
@@ -1196,7 +1162,7 @@ static void cqspi_controller_init(struct cqspi_st *cqspi)
 	cqspi_controller_enable(cqspi, 1);
 }
 
-static void cqspi_request_mmap_dma(struct cqspi_st *cqspi)
+static int cqspi_request_mmap_dma(struct cqspi_st *cqspi)
 {
 	dma_cap_mask_t mask;
 
@@ -1205,10 +1171,16 @@ static void cqspi_request_mmap_dma(struct cqspi_st *cqspi)
 
 	cqspi->rx_chan = dma_request_chan_by_mask(&mask);
 	if (IS_ERR(cqspi->rx_chan)) {
-		dev_err(&cqspi->pdev->dev, "No Rx DMA available\n");
+		int ret = PTR_ERR(cqspi->rx_chan);
+
+		if (ret != -EPROBE_DEFER)
+			dev_err(&cqspi->pdev->dev, "No Rx DMA available\n");
 		cqspi->rx_chan = NULL;
+		return ret;
 	}
 	init_completion(&cqspi->rx_dma_complete);
+
+	return 0;
 }
 
 static int cqspi_setup_flash(struct cqspi_st *cqspi, struct device_node *np)
@@ -1289,8 +1261,11 @@ static int cqspi_setup_flash(struct cqspi_st *cqspi, struct device_node *np)
 			dev_dbg(nor->dev, "using direct mode for %s\n",
 				mtd->name);
 
-			if (!cqspi->rx_chan)
-				cqspi_request_mmap_dma(cqspi);
+			if (!cqspi->rx_chan) {
+				ret = cqspi_request_mmap_dma(cqspi);
+				if (ret == -EPROBE_DEFER)
+					goto err;
+			}
 		}
 	}
 
@@ -1437,17 +1412,30 @@ static int cqspi_remove(struct platform_device *pdev)
 static int cqspi_suspend(struct device *dev)
 {
 	struct cqspi_st *cqspi = dev_get_drvdata(dev);
+	struct spi_master *master = dev_get_drvdata(dev);
+	int ret;
 
+	ret = spi_master_suspend(master);
 	cqspi_controller_enable(cqspi, 0);
-	return 0;
+
+	clk_disable_unprepare(cqspi->clk);
+
+	return ret;
 }
 
 static int cqspi_resume(struct device *dev)
 {
 	struct cqspi_st *cqspi = dev_get_drvdata(dev);
+	struct spi_master *master = dev_get_drvdata(dev);
 
-	cqspi_controller_enable(cqspi, 1);
-	return 0;
+	clk_prepare_enable(cqspi->clk);
+	cqspi_wait_idle(cqspi);
+	cqspi_controller_init(cqspi);
+
+	cqspi->current_cs = -1;
+	cqspi->sclk = 0;
+
+	return spi_master_resume(master);
 }
 
 static const struct dev_pm_ops cqspi__dev_pm_ops = {
diff --git a/drivers/mtd/ubi/eba.c b/drivers/mtd/ubi/eba.c
index b98481b69314..3e25421f22a2 100644
--- a/drivers/mtd/ubi/eba.c
+++ b/drivers/mtd/ubi/eba.c
@@ -960,7 +960,7 @@ static int try_write_vid_and_data(struct ubi_volume *vol, int lnum,
 				  int offset, int len)
 {
 	struct ubi_device *ubi = vol->ubi;
-	int pnum, opnum, err, vol_id = vol->vol_id;
+	int pnum, opnum, err, err2, vol_id = vol->vol_id;
 
 	pnum = ubi_wl_get_peb(ubi);
 	if (pnum < 0) {
@@ -995,10 +995,19 @@ static int try_write_vid_and_data(struct ubi_volume *vol, int lnum,
 out_put:
 	up_read(&ubi->fm_eba_sem);
 
-	if (err && pnum >= 0)
-		err = ubi_wl_put_peb(ubi, vol_id, lnum, pnum, 1);
-	else if (!err && opnum >= 0)
-		err = ubi_wl_put_peb(ubi, vol_id, lnum, opnum, 0);
+	if (err && pnum >= 0) {
+		err2 = ubi_wl_put_peb(ubi, vol_id, lnum, pnum, 1);
+		if (err2) {
+			ubi_warn(ubi, "failed to return physical eraseblock %d, error %d",
+				 pnum, err2);
+		}
+	} else if (!err && opnum >= 0) {
+		err2 = ubi_wl_put_peb(ubi, vol_id, lnum, opnum, 0);
+		if (err2) {
+			ubi_warn(ubi, "failed to return physical eraseblock %d, error %d",
+				 opnum, err2);
+		}
+	}
 
 	return err;
 }
diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index 6b310f723580..b593e4d85e9c 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -3601,6 +3601,7 @@ static const struct mv88e6xxx_ops mv88e6320_ops = {
 	.stats_get_stats = mv88e6320_stats_get_stats,
 	.set_cpu_port = mv88e6095_g1_set_cpu_port,
 	.set_egress_port = mv88e6095_g1_set_egress_port,
+	.watchdog_ops = &mv88e6390_watchdog_ops,
 	.mgmt_rsvd2cpu = mv88e6352_g2_mgmt_rsvd2cpu,
 	.pot_clear = mv88e6xxx_g2_pot_clear,
 	.reset = mv88e6352_g1_reset,
@@ -3643,6 +3644,8 @@ static const struct mv88e6xxx_ops mv88e6321_ops = {
 	.stats_get_stats = mv88e6320_stats_get_stats,
 	.set_cpu_port = mv88e6095_g1_set_cpu_port,
 	.set_egress_port = mv88e6095_g1_set_egress_port,
+	.watchdog_ops = &mv88e6390_watchdog_ops,
+	.mgmt_rsvd2cpu = mv88e6352_g2_mgmt_rsvd2cpu,
 	.reset = mv88e6352_g1_reset,
 	.vtu_getnext = mv88e6185_g1_vtu_getnext,
 	.vtu_loadpurge = mv88e6185_g1_vtu_loadpurge,
diff --git a/drivers/net/ethernet/amd/nmclan_cs.c b/drivers/net/ethernet/amd/nmclan_cs.c
index 9c152d85840d..c9d2a6f15062 100644
--- a/drivers/net/ethernet/amd/nmclan_cs.c
+++ b/drivers/net/ethernet/amd/nmclan_cs.c
@@ -652,7 +652,7 @@ static int nmclan_config(struct pcmcia_device *link)
     } else {
       pr_notice("mace id not found: %x %x should be 0x40 0x?9\n",
 		sig[0], sig[1]);
-      return -ENODEV;
+      goto failed;
     }
   }
 
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
index 8829bd95d0d3..3d361557a63a 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
@@ -2539,6 +2539,14 @@ static int ixgbe_get_rss_hash_opts(struct ixgbe_adapter *adapter,
 	return 0;
 }
 
+static int ixgbe_rss_indir_tbl_max(struct ixgbe_adapter *adapter)
+{
+	if (adapter->hw.mac.type < ixgbe_mac_X550)
+		return 16;
+	else
+		return 64;
+}
+
 static int ixgbe_get_rxnfc(struct net_device *dev, struct ethtool_rxnfc *cmd,
 			   u32 *rule_locs)
 {
@@ -2547,7 +2555,8 @@ static int ixgbe_get_rxnfc(struct net_device *dev, struct ethtool_rxnfc *cmd,
 
 	switch (cmd->cmd) {
 	case ETHTOOL_GRXRINGS:
-		cmd->data = adapter->num_rx_queues;
+		cmd->data = min_t(int, adapter->num_rx_queues,
+				  ixgbe_rss_indir_tbl_max(adapter));
 		ret = 0;
 		break;
 	case ETHTOOL_GRXCLSRLCNT:
@@ -2949,14 +2958,6 @@ static int ixgbe_set_rxnfc(struct net_device *dev, struct ethtool_rxnfc *cmd)
 	return ret;
 }
 
-static int ixgbe_rss_indir_tbl_max(struct ixgbe_adapter *adapter)
-{
-	if (adapter->hw.mac.type < ixgbe_mac_X550)
-		return 16;
-	else
-		return 64;
-}
-
 static u32 ixgbe_get_rxfh_key_size(struct net_device *netdev)
 {
 	return IXGBE_RSS_KEY_SIZE;
@@ -3005,8 +3006,8 @@ static int ixgbe_set_rxfh(struct net_device *netdev, const u32 *indir,
 	int i;
 	u32 reta_entries = ixgbe_rss_indir_tbl_entries(adapter);
 
-	if (hfunc)
-		return -EINVAL;
+	if (hfunc != ETH_RSS_HASH_NO_CHANGE && hfunc != ETH_RSS_HASH_TOP)
+		return -EOPNOTSUPP;
 
 	/* Fill out the redirection table */
 	if (indir) {
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 0a4d093adfc9..3e35cdf0d2b7 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -114,6 +114,7 @@ MODULE_PARM_DESC(chain_mode, "To use chain instead of ring mode");
 static irqreturn_t stmmac_interrupt(int irq, void *dev_id);
 
 #ifdef CONFIG_DEBUG_FS
+static const struct net_device_ops stmmac_netdev_ops;
 static int stmmac_init_fs(struct net_device *dev);
 static void stmmac_exit_fs(struct net_device *dev);
 #endif
@@ -4034,6 +4035,34 @@ static const struct file_operations stmmac_dma_cap_fops = {
 	.release = single_release,
 };
 
+/* Use network device events to rename debugfs file entries.
+ */
+static int stmmac_device_event(struct notifier_block *unused,
+			       unsigned long event, void *ptr)
+{
+	struct net_device *dev = netdev_notifier_info_to_dev(ptr);
+	struct stmmac_priv *priv = netdev_priv(dev);
+
+	if (dev->netdev_ops != &stmmac_netdev_ops)
+		goto done;
+
+	switch (event) {
+	case NETDEV_CHANGENAME:
+		if (priv->dbgfs_dir)
+			priv->dbgfs_dir = debugfs_rename(stmmac_fs_dir,
+							 priv->dbgfs_dir,
+							 stmmac_fs_dir,
+							 dev->name);
+		break;
+	}
+done:
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block stmmac_notifier = {
+	.notifier_call = stmmac_device_event,
+};
+
 static int stmmac_init_fs(struct net_device *dev)
 {
 	struct stmmac_priv *priv = netdev_priv(dev);
@@ -4072,6 +4101,8 @@ static int stmmac_init_fs(struct net_device *dev)
 		return -ENOMEM;
 	}
 
+	register_netdevice_notifier(&stmmac_notifier);
+
 	return 0;
 }
 
@@ -4079,6 +4110,7 @@ static void stmmac_exit_fs(struct net_device *dev)
 {
 	struct stmmac_priv *priv = netdev_priv(dev);
 
+	unregister_netdevice_notifier(&stmmac_notifier);
 	debugfs_remove_recursive(priv->dbgfs_dir);
 }
 #endif /* CONFIG_DEBUG_FS */
diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 0cd46735e395..d45e8de79f28 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -2655,6 +2655,27 @@ static void free_receive_page_frags(struct virtnet_info *vi)
 			put_page(vi->rq[i].alloc_frag.page);
 }
 
+static void virtnet_sq_free_unused_buf(struct virtqueue *vq, void *buf)
+{
+	if (!is_xdp_frame(buf))
+		dev_kfree_skb(buf);
+	else
+		xdp_return_frame(ptr_to_xdp(buf));
+}
+
+static void virtnet_rq_free_unused_buf(struct virtqueue *vq, void *buf)
+{
+	struct virtnet_info *vi = vq->vdev->priv;
+	int i = vq2rxq(vq);
+
+	if (vi->mergeable_rx_bufs)
+		put_page(virt_to_head_page(buf));
+	else if (vi->big_packets)
+		give_pages(&vi->rq[i], buf);
+	else
+		put_page(virt_to_head_page(buf));
+}
+
 static void free_unused_bufs(struct virtnet_info *vi)
 {
 	void *buf;
@@ -2662,26 +2683,16 @@ static void free_unused_bufs(struct virtnet_info *vi)
 
 	for (i = 0; i < vi->max_queue_pairs; i++) {
 		struct virtqueue *vq = vi->sq[i].vq;
-		while ((buf = virtqueue_detach_unused_buf(vq)) != NULL) {
-			if (!is_xdp_frame(buf))
-				dev_kfree_skb(buf);
-			else
-				xdp_return_frame(ptr_to_xdp(buf));
-		}
+		while ((buf = virtqueue_detach_unused_buf(vq)) != NULL)
+			virtnet_sq_free_unused_buf(vq, buf);
+		cond_resched();
 	}
 
 	for (i = 0; i < vi->max_queue_pairs; i++) {
 		struct virtqueue *vq = vi->rq[i].vq;
-
-		while ((buf = virtqueue_detach_unused_buf(vq)) != NULL) {
-			if (vi->mergeable_rx_bufs) {
-				put_page(virt_to_head_page(buf));
-			} else if (vi->big_packets) {
-				give_pages(&vi->rq[i], buf);
-			} else {
-				put_page(virt_to_head_page(buf));
-			}
-		}
+		while ((buf = virtqueue_detach_unused_buf(vq)) != NULL)
+			virtnet_rq_free_unused_buf(vq, buf);
+		cond_resched();
 	}
 }
 
diff --git a/drivers/net/wireless/ath/ath5k/eeprom.c b/drivers/net/wireless/ath/ath5k/eeprom.c
index 01163b333945..92f5c8e83090 100644
--- a/drivers/net/wireless/ath/ath5k/eeprom.c
+++ b/drivers/net/wireless/ath/ath5k/eeprom.c
@@ -529,7 +529,7 @@ ath5k_eeprom_read_freq_list(struct ath5k_hw *ah, int *offset, int max,
 		ee->ee_n_piers[mode]++;
 
 		freq2 = (val >> 8) & 0xff;
-		if (!freq2)
+		if (!freq2 || i >= max)
 			break;
 
 		pc[i++].freq = ath5k_eeprom_bin2freq(ee,
diff --git a/drivers/net/wireless/ath/ath6kl/bmi.c b/drivers/net/wireless/ath/ath6kl/bmi.c
index bde5a10d470c..af98e871199d 100644
--- a/drivers/net/wireless/ath/ath6kl/bmi.c
+++ b/drivers/net/wireless/ath/ath6kl/bmi.c
@@ -246,7 +246,7 @@ int ath6kl_bmi_execute(struct ath6kl *ar, u32 addr, u32 *param)
 		return -EACCES;
 	}
 
-	size = sizeof(cid) + sizeof(addr) + sizeof(param);
+	size = sizeof(cid) + sizeof(addr) + sizeof(*param);
 	if (size > ar->bmi.max_cmd_size) {
 		WARN_ON(1);
 		return -EINVAL;
diff --git a/drivers/net/wireless/ath/ath6kl/htc_pipe.c b/drivers/net/wireless/ath/ath6kl/htc_pipe.c
index 434b66829646..73bf4af1f3c7 100644
--- a/drivers/net/wireless/ath/ath6kl/htc_pipe.c
+++ b/drivers/net/wireless/ath/ath6kl/htc_pipe.c
@@ -963,8 +963,8 @@ static int ath6kl_htc_pipe_rx_complete(struct ath6kl *ar, struct sk_buff *skb,
 	 * Thus the possibility of ar->htc_target being NULL
 	 * via ath6kl_recv_complete -> ath6kl_usb_io_comp_work.
 	 */
-	if (WARN_ON_ONCE(!target)) {
-		ath6kl_err("Target not yet initialized\n");
+	if (!target) {
+		ath6kl_dbg(ATH6KL_DBG_HTC, "Target not yet initialized\n");
 		status = -EINVAL;
 		goto free_skb;
 	}
diff --git a/drivers/net/wireless/ath/ath9k/hif_usb.c b/drivers/net/wireless/ath/ath9k/hif_usb.c
index e23d58f83dd6..3aa915d21554 100644
--- a/drivers/net/wireless/ath/ath9k/hif_usb.c
+++ b/drivers/net/wireless/ath/ath9k/hif_usb.c
@@ -534,6 +534,24 @@ static struct ath9k_htc_hif hif_usb = {
 	.send = hif_usb_send,
 };
 
+/* Need to free remain_skb allocated in ath9k_hif_usb_rx_stream
+ * in case ath9k_hif_usb_rx_stream wasn't called next time to
+ * process the buffer and subsequently free it.
+ */
+static void ath9k_hif_usb_free_rx_remain_skb(struct hif_device_usb *hif_dev)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&hif_dev->rx_lock, flags);
+	if (hif_dev->remain_skb) {
+		dev_kfree_skb_any(hif_dev->remain_skb);
+		hif_dev->remain_skb = NULL;
+		hif_dev->rx_remain_len = 0;
+		RX_STAT_INC(hif_dev, skb_dropped);
+	}
+	spin_unlock_irqrestore(&hif_dev->rx_lock, flags);
+}
+
 static void ath9k_hif_usb_rx_stream(struct hif_device_usb *hif_dev,
 				    struct sk_buff *skb)
 {
@@ -868,6 +886,7 @@ static int ath9k_hif_usb_alloc_tx_urbs(struct hif_device_usb *hif_dev)
 static void ath9k_hif_usb_dealloc_rx_urbs(struct hif_device_usb *hif_dev)
 {
 	usb_kill_anchored_urbs(&hif_dev->rx_submitted);
+	ath9k_hif_usb_free_rx_remain_skb(hif_dev);
 }
 
 static int ath9k_hif_usb_alloc_rx_urbs(struct hif_device_usb *hif_dev)
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
index 75790b13c962..d77c1dbb5e19 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -5362,6 +5362,11 @@ static s32 brcmf_get_assoc_ies(struct brcmf_cfg80211_info *cfg,
 		(struct brcmf_cfg80211_assoc_ielen_le *)cfg->extra_buf;
 	req_len = le32_to_cpu(assoc_info->req_len);
 	resp_len = le32_to_cpu(assoc_info->resp_len);
+	if (req_len > WL_EXTRA_BUF_MAX || resp_len > WL_EXTRA_BUF_MAX) {
+		brcmf_err("invalid lengths in assoc info: req %u resp %u\n",
+			 req_len, resp_len);
+		return -EINVAL;
+	}
 	if (req_len) {
 		err = brcmf_fil_iovar_data_get(ifp, "assoc_req_ies",
 					       cfg->extra_buf,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
index 05b77419953c..9540c874fc38 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
@@ -1835,6 +1835,11 @@ static ssize_t iwl_dbgfs_mem_read(struct file *file, char __user *user_buf,
 	if (ret < 0)
 		return ret;
 
+	if (iwl_rx_packet_payload_len(hcmd.resp_pkt) < sizeof(*rsp)) {
+		ret = -EIO;
+		goto out;
+	}
+
 	rsp = (void *)hcmd.resp_pkt->data;
 	if (le32_to_cpu(rsp->status) != DEBUG_MEM_STATUS_SUCCESS) {
 		ret = -ENXIO;
@@ -1912,6 +1917,11 @@ static ssize_t iwl_dbgfs_mem_write(struct file *file,
 	if (ret < 0)
 		return ret;
 
+	if (iwl_rx_packet_payload_len(hcmd.resp_pkt) < sizeof(*rsp)) {
+		ret = -EIO;
+		goto out;
+	}
+
 	rsp = (void *)hcmd.resp_pkt->data;
 	if (rsp->status != DEBUG_MEM_STATUS_SUCCESS) {
 		ret = -ENXIO;
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
index 2d2afc175830..c69c13e762bb 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -666,7 +666,6 @@ static int iwl_pcie_set_hw_ready(struct iwl_trans *trans)
 int iwl_pcie_prepare_card_hw(struct iwl_trans *trans)
 {
 	int ret;
-	int t = 0;
 	int iter;
 
 	IWL_DEBUG_INFO(trans, "iwl_trans_prepare_card_hw enter\n");
@@ -681,6 +680,8 @@ int iwl_pcie_prepare_card_hw(struct iwl_trans *trans)
 	usleep_range(1000, 2000);
 
 	for (iter = 0; iter < 10; iter++) {
+		int t = 0;
+
 		/* If HW is not ready, prepare the conditions to check again */
 		iwl_set_bit(trans, CSR_HW_IF_CONFIG_REG,
 			    CSR_HW_IF_CONFIG_REG_PREPARE);
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192e.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192e.c
index eb8f046ae20d..f936ad6c5728 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192e.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192e.c
@@ -1710,6 +1710,7 @@ struct rtl8xxxu_fileops rtl8192eu_fops = {
 	.rx_desc_size = sizeof(struct rtl8xxxu_rxdesc24),
 	.has_s0s1 = 0,
 	.gen2_thermal_meter = 1,
+	.needs_full_init = 1,
 	.adda_1t_init = 0x0fc01616,
 	.adda_1t_path_on = 0x0fc01616,
 	.adda_2t_path_on_a = 0x0fc01616,
diff --git a/drivers/net/wireless/realtek/rtlwifi/base.c b/drivers/net/wireless/realtek/rtlwifi/base.c
index 6d1b6a4a8150..7644d7cbcb5a 100644
--- a/drivers/net/wireless/realtek/rtlwifi/base.c
+++ b/drivers/net/wireless/realtek/rtlwifi/base.c
@@ -217,8 +217,8 @@ static void _rtl_init_hw_ht_capab(struct ieee80211_hw *hw,
 	} else {
 		if (get_rf_type(rtlphy) == RF_1T2R ||
 		    get_rf_type(rtlphy) == RF_2T2R) {
-			RT_TRACE(rtlpriv, COMP_INIT, DBG_DMESG,
-				 "1T2R or 2T2R\n");
+			rtl_dbg(rtlpriv, COMP_INIT, DBG_DMESG,
+				"1T2R or 2T2R\n");
 			ht_cap->mcs.rx_mask[0] = 0xFF;
 			ht_cap->mcs.rx_mask[1] = 0xFF;
 			ht_cap->mcs.rx_mask[4] = 0x01;
@@ -226,7 +226,7 @@ static void _rtl_init_hw_ht_capab(struct ieee80211_hw *hw,
 			ht_cap->mcs.rx_highest =
 				 cpu_to_le16(MAX_BIT_RATE_40MHZ_MCS15);
 		} else if (get_rf_type(rtlphy) == RF_1T1R) {
-			RT_TRACE(rtlpriv, COMP_INIT, DBG_DMESG, "1T1R\n");
+			rtl_dbg(rtlpriv, COMP_INIT, DBG_DMESG, "1T1R\n");
 
 			ht_cap->mcs.rx_mask[0] = 0xFF;
 			ht_cap->mcs.rx_mask[1] = 0x00;
@@ -1344,7 +1344,7 @@ bool rtl_tx_mgmt_proc(struct ieee80211_hw *hw, struct sk_buff *skb)
 			rtlpriv->cfg->ops->chk_switch_dmdp(hw);
 	}
 	if (ieee80211_is_auth(fc)) {
-		RT_TRACE(rtlpriv, COMP_SEND, DBG_DMESG, "MAC80211_LINKING\n");
+		rtl_dbg(rtlpriv, COMP_SEND, DBG_DMESG, "MAC80211_LINKING\n");
 
 		mac->link_state = MAC80211_LINKING;
 		/* Dul mac */
@@ -1405,7 +1405,7 @@ bool rtl_action_proc(struct ieee80211_hw *hw, struct sk_buff *skb, u8 is_tx)
 			if (mac->act_scanning)
 				return false;
 
-			RT_TRACE(rtlpriv, (COMP_SEND | COMP_RECV), DBG_DMESG,
+			rtl_dbg(rtlpriv, (COMP_SEND | COMP_RECV), DBG_DMESG,
 				"%s ACT_ADDBAREQ From :%pM\n",
 				is_tx ? "Tx" : "Rx", hdr->addr2);
 			RT_PRINT_DATA(rtlpriv, COMP_INIT, DBG_DMESG, "req\n",
@@ -1420,8 +1420,8 @@ bool rtl_action_proc(struct ieee80211_hw *hw, struct sk_buff *skb, u8 is_tx)
 				rcu_read_lock();
 				sta = rtl_find_sta(hw, hdr->addr3);
 				if (sta == NULL) {
-					RT_TRACE(rtlpriv, COMP_SEND | COMP_RECV,
-						 DBG_DMESG, "sta is NULL\n");
+					rtl_dbg(rtlpriv, COMP_SEND | COMP_RECV,
+						DBG_DMESG, "sta is NULL\n");
 					rcu_read_unlock();
 					return true;
 				}
@@ -1448,13 +1448,13 @@ bool rtl_action_proc(struct ieee80211_hw *hw, struct sk_buff *skb, u8 is_tx)
 			}
 			break;
 		case ACT_ADDBARSP:
-			RT_TRACE(rtlpriv, (COMP_SEND | COMP_RECV), DBG_DMESG,
-				 "%s ACT_ADDBARSP From :%pM\n",
-				  is_tx ? "Tx" : "Rx", hdr->addr2);
+			rtl_dbg(rtlpriv, (COMP_SEND | COMP_RECV), DBG_DMESG,
+				"%s ACT_ADDBARSP From :%pM\n",
+				is_tx ? "Tx" : "Rx", hdr->addr2);
 			break;
 		case ACT_DELBA:
-			RT_TRACE(rtlpriv, (COMP_SEND | COMP_RECV), DBG_DMESG,
-				 "ACT_ADDBADEL From :%pM\n", hdr->addr2);
+			rtl_dbg(rtlpriv, (COMP_SEND | COMP_RECV), DBG_DMESG,
+				"ACT_ADDBADEL From :%pM\n", hdr->addr2);
 			break;
 		}
 		break;
@@ -1539,9 +1539,9 @@ u8 rtl_is_special_data(struct ieee80211_hw *hw, struct sk_buff *skb, u8 is_tx,
 				/* 68 : UDP BOOTP client
 				 * 67 : UDP BOOTP server
 				 */
-				RT_TRACE(rtlpriv, (COMP_SEND | COMP_RECV),
-					 DBG_DMESG, "dhcp %s !!\n",
-					 (is_tx) ? "Tx" : "Rx");
+				rtl_dbg(rtlpriv, (COMP_SEND | COMP_RECV),
+					DBG_DMESG, "dhcp %s !!\n",
+					(is_tx) ? "Tx" : "Rx");
 
 				if (is_tx)
 					setup_special_tx(rtlpriv, ppsc,
@@ -1560,8 +1560,8 @@ u8 rtl_is_special_data(struct ieee80211_hw *hw, struct sk_buff *skb, u8 is_tx,
 		rtlpriv->btcoexist.btc_info.in_4way = true;
 		rtlpriv->btcoexist.btc_info.in_4way_ts = jiffies;
 
-		RT_TRACE(rtlpriv, (COMP_SEND | COMP_RECV), DBG_DMESG,
-			 "802.1X %s EAPOL pkt!!\n", (is_tx) ? "Tx" : "Rx");
+		rtl_dbg(rtlpriv, (COMP_SEND | COMP_RECV), DBG_DMESG,
+			"802.1X %s EAPOL pkt!!\n", (is_tx) ? "Tx" : "Rx");
 
 		if (is_tx) {
 			rtlpriv->ra.is_special_data = true;
@@ -1603,12 +1603,12 @@ static void rtl_tx_status(struct ieee80211_hw *hw, struct sk_buff *skb,
 	info = IEEE80211_SKB_CB(skb);
 	ieee80211_tx_info_clear_status(info);
 	if (ack) {
-		RT_TRACE(rtlpriv, COMP_TX_REPORT, DBG_LOUD,
-			 "tx report: ack\n");
+		rtl_dbg(rtlpriv, COMP_TX_REPORT, DBG_LOUD,
+			"tx report: ack\n");
 		info->flags |= IEEE80211_TX_STAT_ACK;
 	} else {
-		RT_TRACE(rtlpriv, COMP_TX_REPORT, DBG_LOUD,
-			 "tx report: not ack\n");
+		rtl_dbg(rtlpriv, COMP_TX_REPORT, DBG_LOUD,
+			"tx report: not ack\n");
 		info->flags &= ~IEEE80211_TX_STAT_ACK;
 	}
 	ieee80211_tx_status_irqsafe(hw, skb);
@@ -1646,8 +1646,8 @@ static u16 rtl_get_tx_report_sn(struct ieee80211_hw *hw,
 	tx_report->last_sent_time = jiffies;
 	tx_info->sn = sn;
 	tx_info->send_time = tx_report->last_sent_time;
-	RT_TRACE(rtlpriv, COMP_TX_REPORT, DBG_DMESG,
-		 "Send TX-Report sn=0x%X\n", sn);
+	rtl_dbg(rtlpriv, COMP_TX_REPORT, DBG_DMESG,
+		"Send TX-Report sn=0x%X\n", sn);
 
 	return sn;
 }
@@ -1694,9 +1694,9 @@ void rtl_tx_report_handler(struct ieee80211_hw *hw, u8 *tmp_buf, u8 c2h_cmd_len)
 			break;
 		}
 	}
-	RT_TRACE(rtlpriv, COMP_TX_REPORT, DBG_DMESG,
-		 "Recv TX-Report st=0x%02X sn=0x%X retry=0x%X\n",
-		 st, sn, retry);
+	rtl_dbg(rtlpriv, COMP_TX_REPORT, DBG_DMESG,
+		"Recv TX-Report st=0x%02X sn=0x%X retry=0x%X\n",
+		st, sn, retry);
 }
 EXPORT_SYMBOL_GPL(rtl_tx_report_handler);
 
@@ -1709,9 +1709,9 @@ bool rtl_check_tx_report_acked(struct ieee80211_hw *hw)
 		return true;
 
 	if (time_before(tx_report->last_sent_time + 3 * HZ, jiffies)) {
-		RT_TRACE(rtlpriv, COMP_TX_REPORT, DBG_WARNING,
-			 "Check TX-Report timeout!! s_sn=0x%X r_sn=0x%X\n",
-			 tx_report->last_sent_sn, tx_report->last_recv_sn);
+		rtl_dbg(rtlpriv, COMP_TX_REPORT, DBG_WARNING,
+			"Check TX-Report timeout!! s_sn=0x%X r_sn=0x%X\n",
+			tx_report->last_sent_sn, tx_report->last_recv_sn);
 		return true;	/* 3 sec. (timeout) seen as acked */
 	}
 
@@ -1727,8 +1727,8 @@ void rtl_wait_tx_report_acked(struct ieee80211_hw *hw, u32 wait_ms)
 		if (rtl_check_tx_report_acked(hw))
 			break;
 		usleep_range(1000, 2000);
-		RT_TRACE(rtlpriv, COMP_SEC, DBG_DMESG,
-			 "Wait 1ms (%d/%d) to disable key.\n", i, wait_ms);
+		rtl_dbg(rtlpriv, COMP_SEC, DBG_DMESG,
+			"Wait 1ms (%d/%d) to disable key.\n", i, wait_ms);
 	}
 }
 
@@ -1790,9 +1790,9 @@ int rtl_tx_agg_start(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 		return -ENXIO;
 	tid_data = &sta_entry->tids[tid];
 
-	RT_TRACE(rtlpriv, COMP_SEND, DBG_DMESG,
-		 "on ra = %pM tid = %d seq:%d\n", sta->addr, tid,
-		 *ssn);
+	rtl_dbg(rtlpriv, COMP_SEND, DBG_DMESG,
+		"on ra = %pM tid = %d seq:%d\n", sta->addr, tid,
+		*ssn);
 
 	tid_data->agg.agg_state = RTL_AGG_START;
 
@@ -1809,8 +1809,8 @@ int rtl_tx_agg_stop(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	if (sta == NULL)
 		return -EINVAL;
 
-	RT_TRACE(rtlpriv, COMP_SEND, DBG_DMESG,
-		 "on ra = %pM tid = %d\n", sta->addr, tid);
+	rtl_dbg(rtlpriv, COMP_SEND, DBG_DMESG,
+		"on ra = %pM tid = %d\n", sta->addr, tid);
 
 	if (unlikely(tid >= MAX_TID_COUNT))
 		return -EINVAL;
@@ -1849,8 +1849,8 @@ int rtl_rx_agg_start(struct ieee80211_hw *hw,
 		return -ENXIO;
 	tid_data = &sta_entry->tids[tid];
 
-	RT_TRACE(rtlpriv, COMP_RECV, DBG_DMESG,
-		 "on ra = %pM tid = %d\n", sta->addr, tid);
+	rtl_dbg(rtlpriv, COMP_RECV, DBG_DMESG,
+		"on ra = %pM tid = %d\n", sta->addr, tid);
 
 	tid_data->agg.rx_agg_state = RTL_RX_AGG_START;
 	return 0;
@@ -1865,8 +1865,8 @@ int rtl_rx_agg_stop(struct ieee80211_hw *hw,
 	if (sta == NULL)
 		return -EINVAL;
 
-	RT_TRACE(rtlpriv, COMP_SEND, DBG_DMESG,
-		 "on ra = %pM tid = %d\n", sta->addr, tid);
+	rtl_dbg(rtlpriv, COMP_SEND, DBG_DMESG,
+		"on ra = %pM tid = %d\n", sta->addr, tid);
 
 	if (unlikely(tid >= MAX_TID_COUNT))
 		return -EINVAL;
@@ -1885,8 +1885,8 @@ int rtl_tx_agg_oper(struct ieee80211_hw *hw,
 	if (sta == NULL)
 		return -EINVAL;
 
-	RT_TRACE(rtlpriv, COMP_SEND, DBG_DMESG,
-		 "on ra = %pM tid = %d\n", sta->addr, tid);
+	rtl_dbg(rtlpriv, COMP_SEND, DBG_DMESG,
+		"on ra = %pM tid = %d\n", sta->addr, tid);
 
 	if (unlikely(tid >= MAX_TID_COUNT))
 		return -EINVAL;
@@ -1906,9 +1906,9 @@ void rtl_rx_ampdu_apply(struct rtl_priv *rtlpriv)
 		btc_ops->btc_get_ampdu_cfg(rtlpriv, &reject_agg,
 					   &ctrl_agg_size, &agg_size);
 
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
-		 "Set RX AMPDU: coex - reject=%d, ctrl_agg_size=%d, size=%d",
-		 reject_agg, ctrl_agg_size, agg_size);
+	rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
+		"Set RX AMPDU: coex - reject=%d, ctrl_agg_size=%d, size=%d",
+		reject_agg, ctrl_agg_size, agg_size);
 
 	rtlpriv->hw->max_rx_aggregation_subframes =
 		(ctrl_agg_size ? agg_size : IEEE80211_MAX_AMPDU_BUF_HT);
@@ -1996,9 +1996,9 @@ void rtl_scan_list_expire(struct ieee80211_hw *hw)
 		list_del(&entry->list);
 		rtlpriv->scan_list.num--;
 
-		RT_TRACE(rtlpriv, COMP_SCAN, DBG_LOUD,
-			 "BSSID=%pM is expire in scan list (total=%d)\n",
-			 entry->bssid, rtlpriv->scan_list.num);
+		rtl_dbg(rtlpriv, COMP_SCAN, DBG_LOUD,
+			"BSSID=%pM is expire in scan list (total=%d)\n",
+			entry->bssid, rtlpriv->scan_list.num);
 		kfree(entry);
 	}
 
@@ -2032,9 +2032,9 @@ void rtl_collect_scan_list(struct ieee80211_hw *hw, struct sk_buff *skb)
 		if (memcmp(entry->bssid, hdr->addr3, ETH_ALEN) == 0) {
 			list_del_init(&entry->list);
 			entry_found = true;
-			RT_TRACE(rtlpriv, COMP_SCAN, DBG_LOUD,
-				 "Update BSSID=%pM to scan list (total=%d)\n",
-				 hdr->addr3, rtlpriv->scan_list.num);
+			rtl_dbg(rtlpriv, COMP_SCAN, DBG_LOUD,
+				"Update BSSID=%pM to scan list (total=%d)\n",
+				hdr->addr3, rtlpriv->scan_list.num);
 			break;
 		}
 	}
@@ -2048,9 +2048,9 @@ void rtl_collect_scan_list(struct ieee80211_hw *hw, struct sk_buff *skb)
 		memcpy(entry->bssid, hdr->addr3, ETH_ALEN);
 		rtlpriv->scan_list.num++;
 
-		RT_TRACE(rtlpriv, COMP_SCAN, DBG_LOUD,
-			 "Add BSSID=%pM to scan list (total=%d)\n",
-			 hdr->addr3, rtlpriv->scan_list.num);
+		rtl_dbg(rtlpriv, COMP_SCAN, DBG_LOUD,
+			"Add BSSID=%pM to scan list (total=%d)\n",
+			hdr->addr3, rtlpriv->scan_list.num);
 	}
 
 	entry->age = jiffies;
@@ -2213,8 +2213,8 @@ void rtl_watchdog_wq_callback(void *data)
 		if ((rtlpriv->link_info.bcn_rx_inperiod +
 		    rtlpriv->link_info.num_rx_inperiod) == 0) {
 			rtlpriv->link_info.roam_times++;
-			RT_TRACE(rtlpriv, COMP_ERR, DBG_DMESG,
-				 "AP off for %d s\n",
+			rtl_dbg(rtlpriv, COMP_ERR, DBG_DMESG,
+				"AP off for %d s\n",
 				(rtlpriv->link_info.roam_times * 2));
 
 			/* if we can't recv beacon for 10s,
@@ -2325,11 +2325,11 @@ static void rtl_c2h_content_parsing(struct ieee80211_hw *hw,
 
 	switch (cmd_id) {
 	case C2H_DBG:
-		RT_TRACE(rtlpriv, COMP_FW, DBG_LOUD, "[C2H], C2H_DBG!!\n");
+		rtl_dbg(rtlpriv, COMP_FW, DBG_LOUD, "[C2H], C2H_DBG!!\n");
 		break;
 	case C2H_TXBF:
-		RT_TRACE(rtlpriv, COMP_FW, DBG_TRACE,
-			 "[C2H], C2H_TXBF!!\n");
+		rtl_dbg(rtlpriv, COMP_FW, DBG_TRACE,
+			"[C2H], C2H_TXBF!!\n");
 		break;
 	case C2H_TX_REPORT:
 		rtl_tx_report_handler(hw, cmd_buf, cmd_len);
@@ -2339,20 +2339,20 @@ static void rtl_c2h_content_parsing(struct ieee80211_hw *hw,
 			hal_ops->c2h_ra_report_handler(hw, cmd_buf, cmd_len);
 		break;
 	case C2H_BT_INFO:
-		RT_TRACE(rtlpriv, COMP_FW, DBG_TRACE,
-			 "[C2H], C2H_BT_INFO!!\n");
+		rtl_dbg(rtlpriv, COMP_FW, DBG_TRACE,
+			"[C2H], C2H_BT_INFO!!\n");
 		if (rtlpriv->cfg->ops->get_btc_status())
 			btc_ops->btc_btinfo_notify(rtlpriv, cmd_buf, cmd_len);
 		break;
 	case C2H_BT_MP:
-		RT_TRACE(rtlpriv, COMP_FW, DBG_TRACE,
-			 "[C2H], C2H_BT_MP!!\n");
+		rtl_dbg(rtlpriv, COMP_FW, DBG_TRACE,
+			"[C2H], C2H_BT_MP!!\n");
 		if (rtlpriv->cfg->ops->get_btc_status())
 			btc_ops->btc_btmpinfo_notify(rtlpriv, cmd_buf, cmd_len);
 		break;
 	default:
-		RT_TRACE(rtlpriv, COMP_FW, DBG_TRACE,
-			 "[C2H], Unknown packet!! cmd_id(%#X)!\n", cmd_id);
+		rtl_dbg(rtlpriv, COMP_FW, DBG_TRACE,
+			"[C2H], Unknown packet!! cmd_id(%#X)!\n", cmd_id);
 		break;
 	}
 }
@@ -2376,8 +2376,8 @@ void rtl_c2hcmd_launcher(struct ieee80211_hw *hw, int exec)
 		if (!skb)
 			break;
 
-		RT_TRACE(rtlpriv, COMP_FW, DBG_DMESG, "C2H rx_desc_shift=%d\n",
-			 *((u8 *)skb->cb));
+		rtl_dbg(rtlpriv, COMP_FW, DBG_DMESG, "C2H rx_desc_shift=%d\n",
+			*((u8 *)skb->cb));
 		RT_PRINT_DATA(rtlpriv, COMP_FW, DBG_DMESG,
 			      "C2H data: ", skb->data, skb->len);
 
@@ -2721,29 +2721,29 @@ void rtl_recognize_peer(struct ieee80211_hw *hw, u8 *data, unsigned int len)
 		(memcmp(mac->bssid, ap5_6, 3) == 0) ||
 		vendor == PEER_ATH) {
 		vendor = PEER_ATH;
-		RT_TRACE(rtlpriv, COMP_MAC80211, DBG_LOUD, "=>ath find\n");
+		rtl_dbg(rtlpriv, COMP_MAC80211, DBG_LOUD, "=>ath find\n");
 	} else if ((memcmp(mac->bssid, ap4_4, 3) == 0) ||
 		(memcmp(mac->bssid, ap4_5, 3) == 0) ||
 		(memcmp(mac->bssid, ap4_1, 3) == 0) ||
 		(memcmp(mac->bssid, ap4_2, 3) == 0) ||
 		(memcmp(mac->bssid, ap4_3, 3) == 0) ||
 		vendor == PEER_RAL) {
-		RT_TRACE(rtlpriv, COMP_MAC80211, DBG_LOUD, "=>ral find\n");
+		rtl_dbg(rtlpriv, COMP_MAC80211, DBG_LOUD, "=>ral find\n");
 		vendor = PEER_RAL;
 	} else if (memcmp(mac->bssid, ap6_1, 3) == 0 ||
 		vendor == PEER_CISCO) {
 		vendor = PEER_CISCO;
-		RT_TRACE(rtlpriv, COMP_MAC80211, DBG_LOUD, "=>cisco find\n");
+		rtl_dbg(rtlpriv, COMP_MAC80211, DBG_LOUD, "=>cisco find\n");
 	} else if ((memcmp(mac->bssid, ap3_1, 3) == 0) ||
 		(memcmp(mac->bssid, ap3_2, 3) == 0) ||
 		(memcmp(mac->bssid, ap3_3, 3) == 0) ||
 		vendor == PEER_BROAD) {
-		RT_TRACE(rtlpriv, COMP_MAC80211, DBG_LOUD, "=>broad find\n");
+		rtl_dbg(rtlpriv, COMP_MAC80211, DBG_LOUD, "=>broad find\n");
 		vendor = PEER_BROAD;
 	} else if (memcmp(mac->bssid, ap7_1, 3) == 0 ||
 		vendor == PEER_MARV) {
 		vendor = PEER_MARV;
-		RT_TRACE(rtlpriv, COMP_MAC80211, DBG_LOUD, "=>marv find\n");
+		rtl_dbg(rtlpriv, COMP_MAC80211, DBG_LOUD, "=>marv find\n");
 	}
 
 	mac->vendor = vendor;
diff --git a/drivers/net/wireless/realtek/rtlwifi/cam.c b/drivers/net/wireless/realtek/rtlwifi/cam.c
index f7a7dcbf945e..c63129525875 100644
--- a/drivers/net/wireless/realtek/rtlwifi/cam.c
+++ b/drivers/net/wireless/realtek/rtlwifi/cam.c
@@ -64,14 +64,14 @@ static void rtl_cam_program_entry(struct ieee80211_hw *hw, u32 entry_no,
 			rtl_write_dword(rtlpriv, rtlpriv->cfg->maps[RWCAM],
 					target_command);
 
-			RT_TRACE(rtlpriv, COMP_SEC, DBG_LOUD,
-				 "WRITE %x: %x\n",
-				 rtlpriv->cfg->maps[WCAMI], target_content);
-			RT_TRACE(rtlpriv, COMP_SEC, DBG_LOUD,
-				 "The Key ID is %d\n", entry_no);
-			RT_TRACE(rtlpriv, COMP_SEC, DBG_LOUD,
-				 "WRITE %x: %x\n",
-				 rtlpriv->cfg->maps[RWCAM], target_command);
+			rtl_dbg(rtlpriv, COMP_SEC, DBG_LOUD,
+				"WRITE %x: %x\n",
+				rtlpriv->cfg->maps[WCAMI], target_content);
+			rtl_dbg(rtlpriv, COMP_SEC, DBG_LOUD,
+				"The Key ID is %d\n", entry_no);
+			rtl_dbg(rtlpriv, COMP_SEC, DBG_LOUD,
+				"WRITE %x: %x\n",
+				rtlpriv->cfg->maps[RWCAM], target_command);
 
 		} else if (entry_i == 1) {
 
@@ -85,10 +85,10 @@ static void rtl_cam_program_entry(struct ieee80211_hw *hw, u32 entry_no,
 			rtl_write_dword(rtlpriv, rtlpriv->cfg->maps[RWCAM],
 					target_command);
 
-			RT_TRACE(rtlpriv, COMP_SEC, DBG_LOUD,
-				 "WRITE A4: %x\n", target_content);
-			RT_TRACE(rtlpriv, COMP_SEC, DBG_LOUD,
-				 "WRITE A0: %x\n", target_command);
+			rtl_dbg(rtlpriv, COMP_SEC, DBG_LOUD,
+				"WRITE A4: %x\n", target_content);
+			rtl_dbg(rtlpriv, COMP_SEC, DBG_LOUD,
+				"WRITE A0: %x\n", target_command);
 
 		} else {
 
@@ -104,15 +104,15 @@ static void rtl_cam_program_entry(struct ieee80211_hw *hw, u32 entry_no,
 			rtl_write_dword(rtlpriv, rtlpriv->cfg->maps[RWCAM],
 					target_command);
 
-			RT_TRACE(rtlpriv, COMP_SEC, DBG_LOUD,
-				 "WRITE A4: %x\n", target_content);
-			RT_TRACE(rtlpriv, COMP_SEC, DBG_LOUD,
-				 "WRITE A0: %x\n", target_command);
+			rtl_dbg(rtlpriv, COMP_SEC, DBG_LOUD,
+				"WRITE A4: %x\n", target_content);
+			rtl_dbg(rtlpriv, COMP_SEC, DBG_LOUD,
+				"WRITE A0: %x\n", target_command);
 		}
 	}
 
-	RT_TRACE(rtlpriv, COMP_SEC, DBG_LOUD,
-		 "after set key, usconfig:%x\n", us_config);
+	rtl_dbg(rtlpriv, COMP_SEC, DBG_LOUD,
+		"after set key, usconfig:%x\n", us_config);
 }
 
 u8 rtl_cam_add_one_entry(struct ieee80211_hw *hw, u8 *mac_addr,
@@ -122,14 +122,14 @@ u8 rtl_cam_add_one_entry(struct ieee80211_hw *hw, u8 *mac_addr,
 	u32 us_config;
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 
-	RT_TRACE(rtlpriv, COMP_SEC, DBG_DMESG,
-		 "EntryNo:%x, ulKeyId=%x, ulEncAlg=%x, ulUseDK=%x MacAddr %pM\n",
-		 ul_entry_idx, ul_key_id, ul_enc_alg,
-		 ul_default_key, mac_addr);
+	rtl_dbg(rtlpriv, COMP_SEC, DBG_DMESG,
+		"EntryNo:%x, ulKeyId=%x, ulEncAlg=%x, ulUseDK=%x MacAddr %pM\n",
+		ul_entry_idx, ul_key_id, ul_enc_alg,
+		ul_default_key, mac_addr);
 
 	if (ul_key_id == TOTAL_CAM_ENTRY) {
-		RT_TRACE(rtlpriv, COMP_ERR, DBG_WARNING,
-			 "ulKeyId exceed!\n");
+		rtl_dbg(rtlpriv, COMP_ERR, DBG_WARNING,
+			"ulKeyId exceed!\n");
 		return 0;
 	}
 
@@ -141,7 +141,7 @@ u8 rtl_cam_add_one_entry(struct ieee80211_hw *hw, u8 *mac_addr,
 	rtl_cam_program_entry(hw, ul_entry_idx, mac_addr,
 			      (u8 *)key_content, us_config);
 
-	RT_TRACE(rtlpriv, COMP_SEC, DBG_DMESG, "end\n");
+	rtl_dbg(rtlpriv, COMP_SEC, DBG_DMESG, "end\n");
 
 	return 1;
 
@@ -154,7 +154,7 @@ int rtl_cam_delete_one_entry(struct ieee80211_hw *hw,
 	u32 ul_command;
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 
-	RT_TRACE(rtlpriv, COMP_SEC, DBG_DMESG, "key_idx:%d\n", ul_key_id);
+	rtl_dbg(rtlpriv, COMP_SEC, DBG_DMESG, "key_idx:%d\n", ul_key_id);
 
 	ul_command = ul_key_id * CAM_CONTENT_COUNT;
 	ul_command = ul_command | BIT(31) | BIT(16);
@@ -162,10 +162,10 @@ int rtl_cam_delete_one_entry(struct ieee80211_hw *hw,
 	rtl_write_dword(rtlpriv, rtlpriv->cfg->maps[WCAMI], 0);
 	rtl_write_dword(rtlpriv, rtlpriv->cfg->maps[RWCAM], ul_command);
 
-	RT_TRACE(rtlpriv, COMP_SEC, DBG_DMESG,
-		 "rtl_cam_delete_one_entry(): WRITE A4: %x\n", 0);
-	RT_TRACE(rtlpriv, COMP_SEC, DBG_DMESG,
-		 "rtl_cam_delete_one_entry(): WRITE A0: %x\n", ul_command);
+	rtl_dbg(rtlpriv, COMP_SEC, DBG_DMESG,
+		"%s: WRITE A4: %x\n", __func__, 0);
+	rtl_dbg(rtlpriv, COMP_SEC, DBG_DMESG,
+		"%s: WRITE A0: %x\n", __func__, ul_command);
 
 	return 0;
 
@@ -216,10 +216,10 @@ void rtl_cam_mark_invalid(struct ieee80211_hw *hw, u8 uc_index)
 	rtl_write_dword(rtlpriv, rtlpriv->cfg->maps[WCAMI], ul_content);
 	rtl_write_dword(rtlpriv, rtlpriv->cfg->maps[RWCAM], ul_command);
 
-	RT_TRACE(rtlpriv, COMP_SEC, DBG_DMESG,
-		 "rtl_cam_mark_invalid(): WRITE A4: %x\n", ul_content);
-	RT_TRACE(rtlpriv, COMP_SEC, DBG_DMESG,
-		 "rtl_cam_mark_invalid(): WRITE A0: %x\n", ul_command);
+	rtl_dbg(rtlpriv, COMP_SEC, DBG_DMESG,
+		"%s: WRITE A4: %x\n", __func__, ul_content);
+	rtl_dbg(rtlpriv, COMP_SEC, DBG_DMESG,
+		"%s: WRITE A0: %x\n", __func__, ul_command);
 }
 EXPORT_SYMBOL(rtl_cam_mark_invalid);
 
@@ -266,12 +266,10 @@ void rtl_cam_empty_entry(struct ieee80211_hw *hw, u8 uc_index)
 		rtl_write_dword(rtlpriv, rtlpriv->cfg->maps[WCAMI], ul_content);
 		rtl_write_dword(rtlpriv, rtlpriv->cfg->maps[RWCAM], ul_command);
 
-		RT_TRACE(rtlpriv, COMP_SEC, DBG_LOUD,
-			 "rtl_cam_empty_entry(): WRITE A4: %x\n",
-			 ul_content);
-		RT_TRACE(rtlpriv, COMP_SEC, DBG_LOUD,
-			 "rtl_cam_empty_entry(): WRITE A0: %x\n",
-			 ul_command);
+		rtl_dbg(rtlpriv, COMP_SEC, DBG_LOUD,
+			"%s: WRITE A4: %x\n", __func__, ul_content);
+		rtl_dbg(rtlpriv, COMP_SEC, DBG_LOUD,
+			"%s: WRITE A0: %x\n", __func__, ul_command);
 	}
 
 }
@@ -334,8 +332,8 @@ void rtl_cam_del_entry(struct ieee80211_hw *hw, u8 *sta_addr)
 			/* Remove from HW Security CAM */
 			eth_zero_addr(rtlpriv->sec.hwsec_cam_sta_addr[i]);
 			rtlpriv->sec.hwsec_cam_bitmap &= ~(BIT(0) << i);
-			RT_TRACE(rtlpriv, COMP_SEC, DBG_DMESG,
-				 "&&&&&&&&&del entry %d\n", i);
+			rtl_dbg(rtlpriv, COMP_SEC, DBG_DMESG,
+				"&&&&&&&&&del entry %d\n", i);
 		}
 	}
 	return;
diff --git a/drivers/net/wireless/realtek/rtlwifi/core.c b/drivers/net/wireless/realtek/rtlwifi/core.c
index 4bf7967590ca..0ad4e0f099f9 100644
--- a/drivers/net/wireless/realtek/rtlwifi/core.c
+++ b/drivers/net/wireless/realtek/rtlwifi/core.c
@@ -98,8 +98,8 @@ static void rtl_fw_do_work(const struct firmware *firmware, void *context,
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	int err;
 
-	RT_TRACE(rtlpriv, COMP_ERR, DBG_LOUD,
-		 "Firmware callback routine entered!\n");
+	rtl_dbg(rtlpriv, COMP_ERR, DBG_LOUD,
+		"Firmware callback routine entered!\n");
 	complete(&rtlpriv->firmware_loading_complete);
 	if (!firmware) {
 		if (rtlpriv->cfg->alt_fw_name) {
@@ -235,8 +235,8 @@ static int rtl_op_add_interface(struct ieee80211_hw *hw,
 	u8 retry_limit = 0x30;
 
 	if (mac->vif) {
-		RT_TRACE(rtlpriv, COMP_ERR, DBG_WARNING,
-			 "vif has been set!! mac->vif = 0x%p\n", mac->vif);
+		rtl_dbg(rtlpriv, COMP_ERR, DBG_WARNING,
+			"vif has been set!! mac->vif = 0x%p\n", mac->vif);
 		return -EOPNOTSUPP;
 	}
 
@@ -251,16 +251,16 @@ static int rtl_op_add_interface(struct ieee80211_hw *hw,
 		/*fall through*/
 	case NL80211_IFTYPE_STATION:
 		if (mac->beacon_enabled == 1) {
-			RT_TRACE(rtlpriv, COMP_MAC80211, DBG_LOUD,
-				 "NL80211_IFTYPE_STATION\n");
+			rtl_dbg(rtlpriv, COMP_MAC80211, DBG_LOUD,
+				"NL80211_IFTYPE_STATION\n");
 			mac->beacon_enabled = 0;
 			rtlpriv->cfg->ops->update_interrupt_mask(hw, 0,
 					rtlpriv->cfg->maps[RTL_IBSS_INT_MASKS]);
 		}
 		break;
 	case NL80211_IFTYPE_ADHOC:
-		RT_TRACE(rtlpriv, COMP_MAC80211, DBG_LOUD,
-			 "NL80211_IFTYPE_ADHOC\n");
+		rtl_dbg(rtlpriv, COMP_MAC80211, DBG_LOUD,
+			"NL80211_IFTYPE_ADHOC\n");
 
 		mac->link_state = MAC80211_LINKED;
 		rtlpriv->cfg->ops->set_bcn_reg(hw);
@@ -277,8 +277,8 @@ static int rtl_op_add_interface(struct ieee80211_hw *hw,
 		mac->p2p = P2P_ROLE_GO;
 		/*fall through*/
 	case NL80211_IFTYPE_AP:
-		RT_TRACE(rtlpriv, COMP_MAC80211, DBG_LOUD,
-			 "NL80211_IFTYPE_AP\n");
+		rtl_dbg(rtlpriv, COMP_MAC80211, DBG_LOUD,
+			"NL80211_IFTYPE_AP\n");
 
 		mac->link_state = MAC80211_LINKED;
 		rtlpriv->cfg->ops->set_bcn_reg(hw);
@@ -292,8 +292,8 @@ static int rtl_op_add_interface(struct ieee80211_hw *hw,
 		retry_limit = 0x07;
 		break;
 	case NL80211_IFTYPE_MESH_POINT:
-		RT_TRACE(rtlpriv, COMP_MAC80211, DBG_LOUD,
-			 "NL80211_IFTYPE_MESH_POINT\n");
+		rtl_dbg(rtlpriv, COMP_MAC80211, DBG_LOUD,
+			"NL80211_IFTYPE_MESH_POINT\n");
 
 		mac->link_state = MAC80211_LINKED;
 		rtlpriv->cfg->ops->set_bcn_reg(hw);
@@ -314,8 +314,8 @@ static int rtl_op_add_interface(struct ieee80211_hw *hw,
 	}
 
 	if (mac->p2p) {
-		RT_TRACE(rtlpriv, COMP_MAC80211, DBG_LOUD,
-			 "p2p role %x\n", vif->type);
+		rtl_dbg(rtlpriv, COMP_MAC80211, DBG_LOUD,
+			"p2p role %x\n", vif->type);
 		mac->basic_rates = 0xff0;/*disable cck rate for p2p*/
 		rtlpriv->cfg->ops->set_hw_reg(hw, HW_VAR_BASIC_RATE,
 				(u8 *)(&mac->basic_rates));
@@ -379,8 +379,8 @@ static int rtl_op_change_interface(struct ieee80211_hw *hw,
 	vif->type = new_type;
 	vif->p2p = p2p;
 	ret = rtl_op_add_interface(hw, vif);
-	RT_TRACE(rtlpriv, COMP_MAC80211, DBG_LOUD,
-		 "p2p  %x\n", p2p);
+	rtl_dbg(rtlpriv, COMP_MAC80211, DBG_LOUD,
+		"p2p  %x\n", p2p);
 	return ret;
 }
 
@@ -454,8 +454,8 @@ static void _rtl_add_wowlan_patterns(struct ieee80211_hw *hw,
 		memset(mask, 0, MAX_WOL_BIT_MASK_SIZE);
 		if (patterns[i].pattern_len < 0 ||
 		    patterns[i].pattern_len > MAX_WOL_PATTERN_SIZE) {
-			RT_TRACE(rtlpriv, COMP_POWER, DBG_WARNING,
-				 "Pattern[%d] is too long\n", i);
+			rtl_dbg(rtlpriv, COMP_POWER, DBG_WARNING,
+				"Pattern[%d] is too long\n", i);
 			continue;
 		}
 		pattern_os = patterns[i].pattern;
@@ -534,8 +534,8 @@ static void _rtl_add_wowlan_patterns(struct ieee80211_hw *hw,
 			      "pattern to hw\n", content, len);
 		/* 3. calculate crc */
 		rtl_pattern.crc = _calculate_wol_pattern_crc(content, len);
-		RT_TRACE(rtlpriv, COMP_POWER, DBG_TRACE,
-			 "CRC_Remainder = 0x%x\n", rtl_pattern.crc);
+		rtl_dbg(rtlpriv, COMP_POWER, DBG_TRACE,
+			"CRC_Remainder = 0x%x\n", rtl_pattern.crc);
 
 		/* 4. write crc & mask_for_hw to hw */
 		rtlpriv->cfg->ops->add_wowlan_pattern(hw, &rtl_pattern, i);
@@ -550,7 +550,7 @@ static int rtl_op_suspend(struct ieee80211_hw *hw,
 	struct rtl_hal *rtlhal = rtl_hal(rtlpriv);
 	struct rtl_ps_ctl *ppsc = rtl_psc(rtl_priv(hw));
 
-	RT_TRACE(rtlpriv, COMP_POWER, DBG_DMESG, "\n");
+	rtl_dbg(rtlpriv, COMP_POWER, DBG_DMESG, "\n");
 	if (WARN_ON(!wow))
 		return -EINVAL;
 
@@ -576,7 +576,7 @@ static int rtl_op_resume(struct ieee80211_hw *hw)
 	struct rtl_mac *mac = rtl_mac(rtl_priv(hw));
 	time64_t now;
 
-	RT_TRACE(rtlpriv, COMP_POWER, DBG_DMESG, "\n");
+	rtl_dbg(rtlpriv, COMP_POWER, DBG_DMESG, "\n");
 	rtlhal->driver_is_goingto_unload = false;
 	rtlhal->enter_pnp_sleep = false;
 	rtlhal->wake_from_pnp_sleep = true;
@@ -607,8 +607,8 @@ static int rtl_op_config(struct ieee80211_hw *hw, u32 changed)
 
 	mutex_lock(&rtlpriv->locks.conf_mutex);
 	if (changed & IEEE80211_CONF_CHANGE_LISTEN_INTERVAL) {	/* BIT(2)*/
-		RT_TRACE(rtlpriv, COMP_MAC80211, DBG_LOUD,
-			 "IEEE80211_CONF_CHANGE_LISTEN_INTERVAL\n");
+		rtl_dbg(rtlpriv, COMP_MAC80211, DBG_LOUD,
+			"IEEE80211_CONF_CHANGE_LISTEN_INTERVAL\n");
 	}
 
 	/*For IPS */
@@ -651,9 +651,9 @@ static int rtl_op_config(struct ieee80211_hw *hw, u32 changed)
 	}
 
 	if (changed & IEEE80211_CONF_CHANGE_RETRY_LIMITS) {
-		RT_TRACE(rtlpriv, COMP_MAC80211, DBG_LOUD,
-			 "IEEE80211_CONF_CHANGE_RETRY_LIMITS %x\n",
-			 hw->conf.long_frame_max_tx_count);
+		rtl_dbg(rtlpriv, COMP_MAC80211, DBG_LOUD,
+			"IEEE80211_CONF_CHANGE_RETRY_LIMITS %x\n",
+			hw->conf.long_frame_max_tx_count);
 		/* brought up everything changes (changed == ~0) indicates first
 		 * open, so use our default value instead of that of wiphy.
 		 */
@@ -828,13 +828,13 @@ static void rtl_op_configure_filter(struct ieee80211_hw *hw,
 		if (*new_flags & FIF_ALLMULTI) {
 			mac->rx_conf |= rtlpriv->cfg->maps[MAC_RCR_AM] |
 			    rtlpriv->cfg->maps[MAC_RCR_AB];
-			RT_TRACE(rtlpriv, COMP_MAC80211, DBG_LOUD,
-				 "Enable receive multicast frame\n");
+			rtl_dbg(rtlpriv, COMP_MAC80211, DBG_LOUD,
+				"Enable receive multicast frame\n");
 		} else {
 			mac->rx_conf &= ~(rtlpriv->cfg->maps[MAC_RCR_AM] |
 					  rtlpriv->cfg->maps[MAC_RCR_AB]);
-			RT_TRACE(rtlpriv, COMP_MAC80211, DBG_LOUD,
-				 "Disable receive multicast frame\n");
+			rtl_dbg(rtlpriv, COMP_MAC80211, DBG_LOUD,
+				"Disable receive multicast frame\n");
 		}
 		update_rcr = true;
 	}
@@ -842,12 +842,12 @@ static void rtl_op_configure_filter(struct ieee80211_hw *hw,
 	if (changed_flags & FIF_FCSFAIL) {
 		if (*new_flags & FIF_FCSFAIL) {
 			mac->rx_conf |= rtlpriv->cfg->maps[MAC_RCR_ACRC32];
-			RT_TRACE(rtlpriv, COMP_MAC80211, DBG_LOUD,
-				 "Enable receive FCS error frame\n");
+			rtl_dbg(rtlpriv, COMP_MAC80211, DBG_LOUD,
+				"Enable receive FCS error frame\n");
 		} else {
 			mac->rx_conf &= ~rtlpriv->cfg->maps[MAC_RCR_ACRC32];
-			RT_TRACE(rtlpriv, COMP_MAC80211, DBG_LOUD,
-				 "Disable receive FCS error frame\n");
+			rtl_dbg(rtlpriv, COMP_MAC80211, DBG_LOUD,
+				"Disable receive FCS error frame\n");
 		}
 		if (!update_rcr)
 			update_rcr = true;
@@ -874,12 +874,12 @@ static void rtl_op_configure_filter(struct ieee80211_hw *hw,
 		if (*new_flags & FIF_CONTROL) {
 			mac->rx_conf |= rtlpriv->cfg->maps[MAC_RCR_ACF];
 
-			RT_TRACE(rtlpriv, COMP_MAC80211, DBG_LOUD,
-				 "Enable receive control frame.\n");
+			rtl_dbg(rtlpriv, COMP_MAC80211, DBG_LOUD,
+				"Enable receive control frame.\n");
 		} else {
 			mac->rx_conf &= ~rtlpriv->cfg->maps[MAC_RCR_ACF];
-			RT_TRACE(rtlpriv, COMP_MAC80211, DBG_LOUD,
-				 "Disable receive control frame.\n");
+			rtl_dbg(rtlpriv, COMP_MAC80211, DBG_LOUD,
+				"Disable receive control frame.\n");
 		}
 		if (!update_rcr)
 			update_rcr = true;
@@ -888,12 +888,12 @@ static void rtl_op_configure_filter(struct ieee80211_hw *hw,
 	if (changed_flags & FIF_OTHER_BSS) {
 		if (*new_flags & FIF_OTHER_BSS) {
 			mac->rx_conf |= rtlpriv->cfg->maps[MAC_RCR_AAP];
-			RT_TRACE(rtlpriv, COMP_MAC80211, DBG_LOUD,
-				 "Enable receive other BSS's frame.\n");
+			rtl_dbg(rtlpriv, COMP_MAC80211, DBG_LOUD,
+				"Enable receive other BSS's frame.\n");
 		} else {
 			mac->rx_conf &= ~rtlpriv->cfg->maps[MAC_RCR_AAP];
-			RT_TRACE(rtlpriv, COMP_MAC80211, DBG_LOUD,
-				 "Disable receive other BSS's frame.\n");
+			rtl_dbg(rtlpriv, COMP_MAC80211, DBG_LOUD,
+				"Disable receive other BSS's frame.\n");
 		}
 		if (!update_rcr)
 			update_rcr = true;
@@ -941,7 +941,7 @@ static int rtl_op_sta_add(struct ieee80211_hw *hw,
 			sta->supp_rates[0] &= 0xfffffff0;
 
 		memcpy(sta_entry->mac_addr, sta->addr, ETH_ALEN);
-		RT_TRACE(rtlpriv, COMP_MAC80211, DBG_DMESG,
+		rtl_dbg(rtlpriv, COMP_MAC80211, DBG_DMESG,
 			"Add sta addr is %pM\n", sta->addr);
 		rtlpriv->cfg->ops->update_rate_tbl(hw, sta, 0, true);
 	}
@@ -956,8 +956,8 @@ static int rtl_op_sta_remove(struct ieee80211_hw *hw,
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	struct rtl_sta_info *sta_entry;
 	if (sta) {
-		RT_TRACE(rtlpriv, COMP_MAC80211, DBG_DMESG,
-			 "Remove sta addr is %pM\n", sta->addr);
+		rtl_dbg(rtlpriv, COMP_MAC80211, DBG_DMESG,
+			"Remove sta addr is %pM\n", sta->addr);
 		sta_entry = (struct rtl_sta_info *)sta->drv_priv;
 		sta_entry->wireless_mode = 0;
 		sta_entry->ratr_index = 0;
@@ -1004,8 +1004,8 @@ static int rtl_op_conf_tx(struct ieee80211_hw *hw,
 	int aci;
 
 	if (queue >= AC_MAX) {
-		RT_TRACE(rtlpriv, COMP_ERR, DBG_WARNING,
-			 "queue number %d is incorrect!\n", queue);
+		rtl_dbg(rtlpriv, COMP_ERR, DBG_WARNING,
+			"queue number %d is incorrect!\n", queue);
 		return -EINVAL;
 	}
 
@@ -1050,8 +1050,8 @@ static void rtl_op_bss_info_changed(struct ieee80211_hw *hw,
 		    (changed & BSS_CHANGED_BEACON_ENABLED &&
 		     bss_conf->enable_beacon)) {
 			if (mac->beacon_enabled == 0) {
-				RT_TRACE(rtlpriv, COMP_MAC80211, DBG_DMESG,
-					 "BSS_CHANGED_BEACON_ENABLED\n");
+				rtl_dbg(rtlpriv, COMP_MAC80211, DBG_DMESG,
+					"BSS_CHANGED_BEACON_ENABLED\n");
 
 				/*start hw beacon interrupt. */
 				/*rtlpriv->cfg->ops->set_bcn_reg(hw); */
@@ -1068,8 +1068,8 @@ static void rtl_op_bss_info_changed(struct ieee80211_hw *hw,
 		if ((changed & BSS_CHANGED_BEACON_ENABLED &&
 		    !bss_conf->enable_beacon)) {
 			if (mac->beacon_enabled == 1) {
-				RT_TRACE(rtlpriv, COMP_MAC80211, DBG_DMESG,
-					 "ADHOC DISABLE BEACON\n");
+				rtl_dbg(rtlpriv, COMP_MAC80211, DBG_DMESG,
+					"ADHOC DISABLE BEACON\n");
 
 				mac->beacon_enabled = 0;
 				rtlpriv->cfg->ops->update_interrupt_mask(hw, 0,
@@ -1078,8 +1078,8 @@ static void rtl_op_bss_info_changed(struct ieee80211_hw *hw,
 			}
 		}
 		if (changed & BSS_CHANGED_BEACON_INT) {
-			RT_TRACE(rtlpriv, COMP_BEACON, DBG_TRACE,
-				 "BSS_CHANGED_BEACON_INT\n");
+			rtl_dbg(rtlpriv, COMP_BEACON, DBG_TRACE,
+				"BSS_CHANGED_BEACON_INT\n");
 			mac->beacon_interval = bss_conf->beacon_int;
 			rtlpriv->cfg->ops->set_bcn_intv(hw);
 		}
@@ -1117,8 +1117,8 @@ static void rtl_op_bss_info_changed(struct ieee80211_hw *hw,
 				rcu_read_unlock();
 				goto out;
 			}
-			RT_TRACE(rtlpriv, COMP_EASY_CONCURRENT, DBG_LOUD,
-				 "send PS STATIC frame\n");
+			rtl_dbg(rtlpriv, COMP_EASY_CONCURRENT, DBG_LOUD,
+				"send PS STATIC frame\n");
 			if (rtlpriv->dm.supp_phymode_switch) {
 				if (sta->ht_cap.ht_supported)
 					rtl_send_smps_action(hw, sta,
@@ -1158,8 +1158,8 @@ static void rtl_op_bss_info_changed(struct ieee80211_hw *hw,
 						      HW_VAR_KEEP_ALIVE,
 						      (u8 *)(&keep_alive));
 
-			RT_TRACE(rtlpriv, COMP_MAC80211, DBG_DMESG,
-				 "BSS_CHANGED_ASSOC\n");
+			rtl_dbg(rtlpriv, COMP_MAC80211, DBG_DMESG,
+				"BSS_CHANGED_ASSOC\n");
 		} else {
 			struct cfg80211_bss *bss = NULL;
 
@@ -1176,14 +1176,14 @@ static void rtl_op_bss_info_changed(struct ieee80211_hw *hw,
 					       IEEE80211_BSS_TYPE_ESS,
 					       IEEE80211_PRIVACY_OFF);
 
-			RT_TRACE(rtlpriv, COMP_MAC80211, DBG_DMESG,
-				 "bssid = %pMF\n", mac->bssid);
+			rtl_dbg(rtlpriv, COMP_MAC80211, DBG_DMESG,
+				"bssid = %pMF\n", mac->bssid);
 
 			if (bss) {
 				cfg80211_unlink_bss(hw->wiphy, bss);
 				cfg80211_put_bss(hw->wiphy, bss);
-				RT_TRACE(rtlpriv, COMP_MAC80211, DBG_DMESG,
-					 "cfg80211_unlink !!\n");
+				rtl_dbg(rtlpriv, COMP_MAC80211, DBG_DMESG,
+					"cfg80211_unlink !!\n");
 			}
 
 			eth_zero_addr(mac->bssid);
@@ -1194,8 +1194,8 @@ static void rtl_op_bss_info_changed(struct ieee80211_hw *hw,
 				if (rtlpriv->cfg->ops->chk_switch_dmdp)
 					rtlpriv->cfg->ops->chk_switch_dmdp(hw);
 			}
-			RT_TRACE(rtlpriv, COMP_MAC80211, DBG_DMESG,
-				 "BSS_CHANGED_UN_ASSOC\n");
+			rtl_dbg(rtlpriv, COMP_MAC80211, DBG_DMESG,
+				"BSS_CHANGED_UN_ASSOC\n");
 		}
 		rtlpriv->cfg->ops->set_network_type(hw, vif->type);
 		/* For FW LPS:
@@ -1213,14 +1213,14 @@ static void rtl_op_bss_info_changed(struct ieee80211_hw *hw,
 	}
 
 	if (changed & BSS_CHANGED_ERP_CTS_PROT) {
-		RT_TRACE(rtlpriv, COMP_MAC80211, DBG_TRACE,
-			 "BSS_CHANGED_ERP_CTS_PROT\n");
+		rtl_dbg(rtlpriv, COMP_MAC80211, DBG_TRACE,
+			"BSS_CHANGED_ERP_CTS_PROT\n");
 		mac->use_cts_protect = bss_conf->use_cts_prot;
 	}
 
 	if (changed & BSS_CHANGED_ERP_PREAMBLE) {
-		RT_TRACE(rtlpriv, COMP_MAC80211, DBG_LOUD,
-			 "BSS_CHANGED_ERP_PREAMBLE use short preamble:%x\n",
+		rtl_dbg(rtlpriv, COMP_MAC80211, DBG_LOUD,
+			"BSS_CHANGED_ERP_PREAMBLE use short preamble:%x\n",
 			  bss_conf->use_short_preamble);
 
 		mac->short_preamble = bss_conf->use_short_preamble;
@@ -1229,8 +1229,8 @@ static void rtl_op_bss_info_changed(struct ieee80211_hw *hw,
 	}
 
 	if (changed & BSS_CHANGED_ERP_SLOT) {
-		RT_TRACE(rtlpriv, COMP_MAC80211, DBG_TRACE,
-			 "BSS_CHANGED_ERP_SLOT\n");
+		rtl_dbg(rtlpriv, COMP_MAC80211, DBG_TRACE,
+			"BSS_CHANGED_ERP_SLOT\n");
 
 		if (bss_conf->use_short_slot)
 			mac->slot_time = RTL_SLOT_TIME_9;
@@ -1244,8 +1244,8 @@ static void rtl_op_bss_info_changed(struct ieee80211_hw *hw,
 	if (changed & BSS_CHANGED_HT) {
 		struct ieee80211_sta *sta = NULL;
 
-		RT_TRACE(rtlpriv, COMP_MAC80211, DBG_TRACE,
-			 "BSS_CHANGED_HT\n");
+		rtl_dbg(rtlpriv, COMP_MAC80211, DBG_TRACE,
+			"BSS_CHANGED_HT\n");
 
 		rcu_read_lock();
 		sta = ieee80211_find_sta(vif, (u8 *)bss_conf->bssid);
@@ -1276,8 +1276,8 @@ static void rtl_op_bss_info_changed(struct ieee80211_hw *hw,
 		rtlpriv->cfg->ops->set_hw_reg(hw, HW_VAR_BSSID,
 					      (u8 *)bss_conf->bssid);
 
-		RT_TRACE(rtlpriv, COMP_MAC80211, DBG_DMESG,
-			 "bssid: %pM\n", bss_conf->bssid);
+		rtl_dbg(rtlpriv, COMP_MAC80211, DBG_DMESG,
+			"bssid: %pM\n", bss_conf->bssid);
 
 		mac->vendor = PEER_UNKNOWN;
 		memcpy(mac->bssid, bss_conf->bssid, ETH_ALEN);
@@ -1407,27 +1407,27 @@ static int rtl_op_ampdu_action(struct ieee80211_hw *hw,
 
 	switch (action) {
 	case IEEE80211_AMPDU_TX_START:
-		RT_TRACE(rtlpriv, COMP_MAC80211, DBG_TRACE,
-			 "IEEE80211_AMPDU_TX_START: TID:%d\n", tid);
+		rtl_dbg(rtlpriv, COMP_MAC80211, DBG_TRACE,
+			"IEEE80211_AMPDU_TX_START: TID:%d\n", tid);
 		return rtl_tx_agg_start(hw, vif, sta, tid, ssn);
 	case IEEE80211_AMPDU_TX_STOP_CONT:
 	case IEEE80211_AMPDU_TX_STOP_FLUSH:
 	case IEEE80211_AMPDU_TX_STOP_FLUSH_CONT:
-		RT_TRACE(rtlpriv, COMP_MAC80211, DBG_TRACE,
-			 "IEEE80211_AMPDU_TX_STOP: TID:%d\n", tid);
+		rtl_dbg(rtlpriv, COMP_MAC80211, DBG_TRACE,
+			"IEEE80211_AMPDU_TX_STOP: TID:%d\n", tid);
 		return rtl_tx_agg_stop(hw, vif, sta, tid);
 	case IEEE80211_AMPDU_TX_OPERATIONAL:
-		RT_TRACE(rtlpriv, COMP_MAC80211, DBG_TRACE,
-			 "IEEE80211_AMPDU_TX_OPERATIONAL:TID:%d\n", tid);
+		rtl_dbg(rtlpriv, COMP_MAC80211, DBG_TRACE,
+			"IEEE80211_AMPDU_TX_OPERATIONAL:TID:%d\n", tid);
 		rtl_tx_agg_oper(hw, sta, tid);
 		break;
 	case IEEE80211_AMPDU_RX_START:
-		RT_TRACE(rtlpriv, COMP_MAC80211, DBG_TRACE,
-			 "IEEE80211_AMPDU_RX_START:TID:%d\n", tid);
+		rtl_dbg(rtlpriv, COMP_MAC80211, DBG_TRACE,
+			"IEEE80211_AMPDU_RX_START:TID:%d\n", tid);
 		return rtl_rx_agg_start(hw, sta, tid);
 	case IEEE80211_AMPDU_RX_STOP:
-		RT_TRACE(rtlpriv, COMP_MAC80211, DBG_TRACE,
-			 "IEEE80211_AMPDU_RX_STOP:TID:%d\n", tid);
+		rtl_dbg(rtlpriv, COMP_MAC80211, DBG_TRACE,
+			"IEEE80211_AMPDU_RX_STOP:TID:%d\n", tid);
 		return rtl_rx_agg_stop(hw, sta, tid);
 	default:
 		pr_err("IEEE80211_AMPDU_ERR!!!!:\n");
@@ -1443,7 +1443,7 @@ static void rtl_op_sw_scan_start(struct ieee80211_hw *hw,
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	struct rtl_mac *mac = rtl_mac(rtl_priv(hw));
 
-	RT_TRACE(rtlpriv, COMP_MAC80211, DBG_LOUD, "\n");
+	rtl_dbg(rtlpriv, COMP_MAC80211, DBG_LOUD, "\n");
 	mac->act_scanning = true;
 	if (rtlpriv->link_info.higher_busytraffic) {
 		mac->skip_scan = true;
@@ -1481,7 +1481,7 @@ static void rtl_op_sw_scan_complete(struct ieee80211_hw *hw,
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	struct rtl_mac *mac = rtl_mac(rtl_priv(hw));
 
-	RT_TRACE(rtlpriv, COMP_MAC80211, DBG_LOUD, "\n");
+	rtl_dbg(rtlpriv, COMP_MAC80211, DBG_LOUD, "\n");
 	mac->act_scanning = false;
 	mac->skip_scan = false;
 
@@ -1531,8 +1531,8 @@ static int rtl_op_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 	rtlpriv->btcoexist.btc_info.in_4way = false;
 
 	if (rtlpriv->cfg->mod_params->sw_crypto || rtlpriv->sec.use_sw_sec) {
-		RT_TRACE(rtlpriv, COMP_ERR, DBG_WARNING,
-			 "not open hw encryption\n");
+		rtl_dbg(rtlpriv, COMP_ERR, DBG_WARNING,
+			"not open hw encryption\n");
 		return -ENOSPC;	/*User disabled HW-crypto */
 	}
 	/* To support IBSS, use sw-crypto for GTK */
@@ -1540,10 +1540,10 @@ static int rtl_op_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 	     vif->type == NL80211_IFTYPE_MESH_POINT) &&
 	    !(key->flags & IEEE80211_KEY_FLAG_PAIRWISE))
 		return -ENOSPC;
-	RT_TRACE(rtlpriv, COMP_SEC, DBG_DMESG,
-		 "%s hardware based encryption for keyidx: %d, mac: %pM\n",
-		  cmd == SET_KEY ? "Using" : "Disabling", key->keyidx,
-		  sta ? sta->addr : bcast_addr);
+	rtl_dbg(rtlpriv, COMP_SEC, DBG_DMESG,
+		"%s hardware based encryption for keyidx: %d, mac: %pM\n",
+		cmd == SET_KEY ? "Using" : "Disabling", key->keyidx,
+		sta ? sta->addr : bcast_addr);
 	rtlpriv->sec.being_setkey = true;
 	rtl_ips_nic_on(hw);
 	mutex_lock(&rtlpriv->locks.conf_mutex);
@@ -1552,28 +1552,28 @@ static int rtl_op_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 	switch (key->cipher) {
 	case WLAN_CIPHER_SUITE_WEP40:
 		key_type = WEP40_ENCRYPTION;
-		RT_TRACE(rtlpriv, COMP_SEC, DBG_DMESG, "alg:WEP40\n");
+		rtl_dbg(rtlpriv, COMP_SEC, DBG_DMESG, "alg:WEP40\n");
 		break;
 	case WLAN_CIPHER_SUITE_WEP104:
-		RT_TRACE(rtlpriv, COMP_SEC, DBG_DMESG, "alg:WEP104\n");
+		rtl_dbg(rtlpriv, COMP_SEC, DBG_DMESG, "alg:WEP104\n");
 		key_type = WEP104_ENCRYPTION;
 		break;
 	case WLAN_CIPHER_SUITE_TKIP:
 		key_type = TKIP_ENCRYPTION;
-		RT_TRACE(rtlpriv, COMP_SEC, DBG_DMESG, "alg:TKIP\n");
+		rtl_dbg(rtlpriv, COMP_SEC, DBG_DMESG, "alg:TKIP\n");
 		break;
 	case WLAN_CIPHER_SUITE_CCMP:
 		key_type = AESCCMP_ENCRYPTION;
-		RT_TRACE(rtlpriv, COMP_SEC, DBG_DMESG, "alg:CCMP\n");
+		rtl_dbg(rtlpriv, COMP_SEC, DBG_DMESG, "alg:CCMP\n");
 		break;
 	case WLAN_CIPHER_SUITE_AES_CMAC:
 		/* HW don't support CMAC encryption,
 		 * use software CMAC encryption
 		 */
 		key_type = AESCMAC_ENCRYPTION;
-		RT_TRACE(rtlpriv, COMP_SEC, DBG_DMESG, "alg:CMAC\n");
-		RT_TRACE(rtlpriv, COMP_SEC, DBG_DMESG,
-			 "HW don't support CMAC encryption, use software CMAC encryption\n");
+		rtl_dbg(rtlpriv, COMP_SEC, DBG_DMESG, "alg:CMAC\n");
+		rtl_dbg(rtlpriv, COMP_SEC, DBG_DMESG,
+			"HW don't support CMAC encryption, use software CMAC encryption\n");
 		err = -EOPNOTSUPP;
 		goto out_unlock;
 	default:
@@ -1619,9 +1619,9 @@ static int rtl_op_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 			    key_type == WEP104_ENCRYPTION))
 				wep_only = true;
 			rtlpriv->sec.pairwise_enc_algorithm = key_type;
-			RT_TRACE(rtlpriv, COMP_SEC, DBG_DMESG,
-				 "set enable_hw_sec, key_type:%x(OPEN:0 WEP40:1 TKIP:2 AES:4 WEP104:5)\n",
-				 key_type);
+			rtl_dbg(rtlpriv, COMP_SEC, DBG_DMESG,
+				"set enable_hw_sec, key_type:%x(OPEN:0 WEP40:1 TKIP:2 AES:4 WEP104:5)\n",
+				key_type);
 			rtlpriv->cfg->ops->enable_hw_sec(hw);
 		}
 	}
@@ -1629,8 +1629,8 @@ static int rtl_op_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 	switch (cmd) {
 	case SET_KEY:
 		if (wep_only) {
-			RT_TRACE(rtlpriv, COMP_SEC, DBG_DMESG,
-				 "set WEP(group/pairwise) key\n");
+			rtl_dbg(rtlpriv, COMP_SEC, DBG_DMESG,
+				"set WEP(group/pairwise) key\n");
 			/* Pairwise key with an assigned MAC address. */
 			rtlpriv->sec.pairwise_enc_algorithm = key_type;
 			rtlpriv->sec.group_enc_algorithm = key_type;
@@ -1640,8 +1640,8 @@ static int rtl_op_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 			rtlpriv->sec.key_len[key_idx] = key->keylen;
 			eth_zero_addr(mac_addr);
 		} else if (group_key) {	/* group key */
-			RT_TRACE(rtlpriv, COMP_SEC, DBG_DMESG,
-				 "set group key\n");
+			rtl_dbg(rtlpriv, COMP_SEC, DBG_DMESG,
+				"set group key\n");
 			/* group key */
 			rtlpriv->sec.group_enc_algorithm = key_type;
 			/*set local buf about group key. */
@@ -1650,8 +1650,8 @@ static int rtl_op_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 			rtlpriv->sec.key_len[key_idx] = key->keylen;
 			memcpy(mac_addr, bcast_addr, ETH_ALEN);
 		} else {	/* pairwise key */
-			RT_TRACE(rtlpriv, COMP_SEC, DBG_DMESG,
-				 "set pairwise key\n");
+			rtl_dbg(rtlpriv, COMP_SEC, DBG_DMESG,
+				"set pairwise key\n");
 			if (!sta) {
 				WARN_ONCE(true,
 					  "rtlwifi: pairwise key without mac_addr\n");
@@ -1683,8 +1683,8 @@ static int rtl_op_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 			key->flags |= IEEE80211_KEY_FLAG_SW_MGMT_TX;
 		break;
 	case DISABLE_KEY:
-		RT_TRACE(rtlpriv, COMP_SEC, DBG_DMESG,
-			 "disable key delete one entry\n");
+		rtl_dbg(rtlpriv, COMP_SEC, DBG_DMESG,
+			"disable key delete one entry\n");
 		/*set local buf about wep key. */
 		if (vif->type == NL80211_IFTYPE_AP ||
 			vif->type == NL80211_IFTYPE_MESH_POINT) {
@@ -1732,9 +1732,9 @@ static void rtl_op_rfkill_poll(struct ieee80211_hw *hw)
 		if (unlikely(radio_state != rtlpriv->rfkill.rfkill_state)) {
 			rtlpriv->rfkill.rfkill_state = radio_state;
 
-			RT_TRACE(rtlpriv, COMP_RF, DBG_DMESG,
-				 "wireless radio switch turned %s\n",
-				  radio_state ? "on" : "off");
+			rtl_dbg(rtlpriv, COMP_RF, DBG_DMESG,
+				"wireless radio switch turned %s\n",
+				radio_state ? "on" : "off");
 
 			blocked = (rtlpriv->rfkill.rfkill_state == 1) ? 0 : 1;
 			wiphy_rfkill_set_hw_state(hw->wiphy, blocked);
@@ -1779,26 +1779,27 @@ bool rtl_hal_pwrseqcmdparsing(struct rtl_priv *rtlpriv, u8 cut_version,
 
 	do {
 		cfg_cmd = pwrcfgcmd[ary_idx];
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE,
-			 "rtl_hal_pwrseqcmdparsing(): offset(%#x),cut_msk(%#x), famsk(%#x), interface_msk(%#x), base(%#x), cmd(%#x), msk(%#x), value(%#x)\n",
-			 GET_PWR_CFG_OFFSET(cfg_cmd),
-					    GET_PWR_CFG_CUT_MASK(cfg_cmd),
-			 GET_PWR_CFG_FAB_MASK(cfg_cmd),
-					      GET_PWR_CFG_INTF_MASK(cfg_cmd),
-			 GET_PWR_CFG_BASE(cfg_cmd), GET_PWR_CFG_CMD(cfg_cmd),
-			 GET_PWR_CFG_MASK(cfg_cmd), GET_PWR_CFG_VALUE(cfg_cmd));
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_TRACE,
+			"%s: offset(%#x),cut_msk(%#x), famsk(%#x), interface_msk(%#x), base(%#x), cmd(%#x), msk(%#x), value(%#x)\n",
+			__func__,
+			GET_PWR_CFG_OFFSET(cfg_cmd),
+					   GET_PWR_CFG_CUT_MASK(cfg_cmd),
+			GET_PWR_CFG_FAB_MASK(cfg_cmd),
+					     GET_PWR_CFG_INTF_MASK(cfg_cmd),
+			GET_PWR_CFG_BASE(cfg_cmd), GET_PWR_CFG_CMD(cfg_cmd),
+			GET_PWR_CFG_MASK(cfg_cmd), GET_PWR_CFG_VALUE(cfg_cmd));
 
 		if ((GET_PWR_CFG_FAB_MASK(cfg_cmd)&faversion) &&
 		    (GET_PWR_CFG_CUT_MASK(cfg_cmd)&cut_version) &&
 		    (GET_PWR_CFG_INTF_MASK(cfg_cmd)&interface_type)) {
 			switch (GET_PWR_CFG_CMD(cfg_cmd)) {
 			case PWR_CMD_READ:
-				RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE,
+				rtl_dbg(rtlpriv, COMP_INIT, DBG_TRACE,
 					"rtl_hal_pwrseqcmdparsing(): PWR_CMD_READ\n");
 				break;
 			case PWR_CMD_WRITE:
-				RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE,
-					 "%s(): PWR_CMD_WRITE\n", __func__);
+				rtl_dbg(rtlpriv, COMP_INIT, DBG_TRACE,
+					"%s(): PWR_CMD_WRITE\n", __func__);
 				offset = GET_PWR_CFG_OFFSET(cfg_cmd);
 
 				/*Read the value from system register*/
@@ -1811,7 +1812,7 @@ bool rtl_hal_pwrseqcmdparsing(struct rtl_priv *rtlpriv, u8 cut_version,
 				rtl_write_byte(rtlpriv, offset, value);
 				break;
 			case PWR_CMD_POLLING:
-				RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE,
+				rtl_dbg(rtlpriv, COMP_INIT, DBG_TRACE,
 					"rtl_hal_pwrseqcmdparsing(): PWR_CMD_POLLING\n");
 				polling_bit = false;
 				offset = GET_PWR_CFG_OFFSET(cfg_cmd);
@@ -1832,8 +1833,8 @@ bool rtl_hal_pwrseqcmdparsing(struct rtl_priv *rtlpriv, u8 cut_version,
 				} while (!polling_bit);
 				break;
 			case PWR_CMD_DELAY:
-				RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE,
-					 "rtl_hal_pwrseqcmdparsing(): PWR_CMD_DELAY\n");
+				rtl_dbg(rtlpriv, COMP_INIT, DBG_TRACE,
+					"%s: PWR_CMD_DELAY\n", __func__);
 				if (GET_PWR_CFG_VALUE(cfg_cmd) ==
 				    PWRSEQ_DELAY_US)
 					udelay(GET_PWR_CFG_OFFSET(cfg_cmd));
@@ -1841,8 +1842,8 @@ bool rtl_hal_pwrseqcmdparsing(struct rtl_priv *rtlpriv, u8 cut_version,
 					mdelay(GET_PWR_CFG_OFFSET(cfg_cmd));
 				break;
 			case PWR_CMD_END:
-				RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE,
-					 "rtl_hal_pwrseqcmdparsing(): PWR_CMD_END\n");
+				rtl_dbg(rtlpriv, COMP_INIT, DBG_TRACE,
+					"%s: PWR_CMD_END\n", __func__);
 				return true;
 			default:
 				WARN_ONCE(true,
diff --git a/drivers/net/wireless/realtek/rtlwifi/debug.c b/drivers/net/wireless/realtek/rtlwifi/debug.c
index 474439fc2da1..6a0dfc6d4905 100644
--- a/drivers/net/wireless/realtek/rtlwifi/debug.c
+++ b/drivers/net/wireless/realtek/rtlwifi/debug.c
@@ -319,8 +319,8 @@ static ssize_t rtl_debugfs_set_write_reg(struct file *filp,
 
 	tmp_len = (count > sizeof(tmp) - 1 ? sizeof(tmp) - 1 : count);
 
-	if (!buffer || copy_from_user(tmp, buffer, tmp_len))
-		return count;
+	if (copy_from_user(tmp, buffer, tmp_len))
+		return -EFAULT;
 
 	tmp[tmp_len] = '\0';
 
@@ -328,7 +328,7 @@ static ssize_t rtl_debugfs_set_write_reg(struct file *filp,
 	num = sscanf(tmp, "%x %x %x", &addr, &val, &len);
 
 	if (num !=  3)
-		return count;
+		return -EINVAL;
 
 	switch (len) {
 	case 1:
@@ -416,8 +416,8 @@ static ssize_t rtl_debugfs_set_write_rfreg(struct file *filp,
 
 	tmp_len = (count > sizeof(tmp) - 1 ? sizeof(tmp) - 1 : count);
 
-	if (!buffer || copy_from_user(tmp, buffer, tmp_len))
-		return count;
+	if (copy_from_user(tmp, buffer, tmp_len))
+		return -EFAULT;
 
 	tmp[tmp_len] = '\0';
 
@@ -425,9 +425,9 @@ static ssize_t rtl_debugfs_set_write_rfreg(struct file *filp,
 		     &path, &addr, &bitmask, &data);
 
 	if (num != 4) {
-		RT_TRACE(rtlpriv, COMP_ERR, DBG_DMESG,
-			 "Format is <path> <addr> <mask> <data>\n");
-		return count;
+		rtl_dbg(rtlpriv, COMP_ERR, DBG_DMESG,
+			"Format is <path> <addr> <mask> <data>\n");
+		return -EINVAL;
 	}
 
 	rtl_set_rfreg(hw, path, addr, bitmask, data);
diff --git a/drivers/net/wireless/realtek/rtlwifi/debug.h b/drivers/net/wireless/realtek/rtlwifi/debug.h
index ad6834af618b..14f822afc89a 100644
--- a/drivers/net/wireless/realtek/rtlwifi/debug.h
+++ b/drivers/net/wireless/realtek/rtlwifi/debug.h
@@ -181,6 +181,10 @@ void _rtl_dbg_print_data(struct rtl_priv *rtlpriv, u64 comp, int level,
 			 const char *titlestring,
 			 const void *hexdata, int hexdatalen);
 
+#define rtl_dbg(rtlpriv, comp, level, fmt, ...)			\
+	_rtl_dbg_trace(rtlpriv, comp, level,				\
+		       fmt, ##__VA_ARGS__)
+
 #define RT_TRACE(rtlpriv, comp, level, fmt, ...)			\
 	_rtl_dbg_trace(rtlpriv, comp, level,				\
 		       fmt, ##__VA_ARGS__)
@@ -197,6 +201,13 @@ void _rtl_dbg_print_data(struct rtl_priv *rtlpriv, u64 comp, int level,
 
 struct rtl_priv;
 
+__printf(4, 5)
+static inline void rtl_dbg(struct rtl_priv *rtlpriv,
+			   u64 comp, int level,
+			   const char *fmt, ...)
+{
+}
+
 __printf(4, 5)
 static inline void RT_TRACE(struct rtl_priv *rtlpriv,
 			    u64 comp, int level,
diff --git a/drivers/net/wireless/realtek/rtlwifi/efuse.c b/drivers/net/wireless/realtek/rtlwifi/efuse.c
index 9729e51fce38..5d8995097ee7 100644
--- a/drivers/net/wireless/realtek/rtlwifi/efuse.c
+++ b/drivers/net/wireless/realtek/rtlwifi/efuse.c
@@ -160,8 +160,8 @@ void efuse_write_1byte(struct ieee80211_hw *hw, u16 address, u8 value)
 	const u32 efuse_len =
 		rtlpriv->cfg->maps[EFUSE_REAL_CONTENT_SIZE];
 
-	RT_TRACE(rtlpriv, COMP_EFUSE, DBG_LOUD, "Addr=%x Data =%x\n",
-		 address, value);
+	rtl_dbg(rtlpriv, COMP_EFUSE, DBG_LOUD, "Addr=%x Data =%x\n",
+		address, value);
 
 	if (address < efuse_len) {
 		rtl_write_byte(rtlpriv, rtlpriv->cfg->maps[EFUSE_CTRL], value);
@@ -251,9 +251,9 @@ void read_efuse(struct ieee80211_hw *hw, u16 _offset, u16 _size_byte, u8 *pbuf)
 	u8 efuse_usage;
 
 	if ((_offset + _size_byte) > rtlpriv->cfg->maps[EFUSE_HWSET_MAX_SIZE]) {
-		RT_TRACE(rtlpriv, COMP_EFUSE, DBG_LOUD,
-			 "read_efuse(): Invalid offset(%#x) with read bytes(%#x)!!\n",
-			 _offset, _size_byte);
+		rtl_dbg(rtlpriv, COMP_EFUSE, DBG_LOUD,
+			"%s: Invalid offset(%#x) with read bytes(%#x)!!\n",
+			__func__, _offset, _size_byte);
 		return;
 	}
 
@@ -416,9 +416,9 @@ bool efuse_shadow_update_chk(struct ieee80211_hw *hw)
 	    (EFUSE_MAX_SIZE - rtlpriv->cfg->maps[EFUSE_OOB_PROTECT_BYTES_LEN]))
 		result = false;
 
-	RT_TRACE(rtlpriv, COMP_EFUSE, DBG_LOUD,
-		 "efuse_shadow_update_chk(): totalbytes(%#x), hdr_num(%#x), words_need(%#x), efuse_used(%d)\n",
-		 totalbytes, hdr_num, words_need, efuse_used);
+	rtl_dbg(rtlpriv, COMP_EFUSE, DBG_LOUD,
+		"%s: totalbytes(%#x), hdr_num(%#x), words_need(%#x), efuse_used(%d)\n",
+		__func__, totalbytes, hdr_num, words_need, efuse_used);
 
 	return result;
 }
@@ -456,7 +456,7 @@ bool efuse_shadow_update(struct ieee80211_hw *hw)
 	u8 word_en = 0x0F;
 	u8 first_pg = false;
 
-	RT_TRACE(rtlpriv, COMP_EFUSE, DBG_LOUD, "\n");
+	rtl_dbg(rtlpriv, COMP_EFUSE, DBG_LOUD, "\n");
 
 	if (!efuse_shadow_update_chk(hw)) {
 		efuse_read_all_map(hw, &rtlefuse->efuse_map[EFUSE_INIT_MAP][0]);
@@ -464,8 +464,8 @@ bool efuse_shadow_update(struct ieee80211_hw *hw)
 		       &rtlefuse->efuse_map[EFUSE_INIT_MAP][0],
 		       rtlpriv->cfg->maps[EFUSE_HWSET_MAX_SIZE]);
 
-		RT_TRACE(rtlpriv, COMP_EFUSE, DBG_LOUD,
-			 "efuse out of capacity!!\n");
+		rtl_dbg(rtlpriv, COMP_EFUSE, DBG_LOUD,
+			"efuse out of capacity!!\n");
 		return false;
 	}
 	efuse_power_switch(hw, true, true);
@@ -503,8 +503,8 @@ bool efuse_shadow_update(struct ieee80211_hw *hw)
 
 			if (!efuse_pg_packet_write(hw, (u8) offset, word_en,
 						   tmpdata)) {
-				RT_TRACE(rtlpriv, COMP_ERR, DBG_WARNING,
-					 "PG section(%#x) fail!!\n", offset);
+				rtl_dbg(rtlpriv, COMP_ERR, DBG_WARNING,
+					"PG section(%#x) fail!!\n", offset);
 				break;
 			}
 		}
@@ -518,7 +518,7 @@ bool efuse_shadow_update(struct ieee80211_hw *hw)
 	       &rtlefuse->efuse_map[EFUSE_INIT_MAP][0],
 	       rtlpriv->cfg->maps[EFUSE_HWSET_MAX_SIZE]);
 
-	RT_TRACE(rtlpriv, COMP_EFUSE, DBG_LOUD, "\n");
+	rtl_dbg(rtlpriv, COMP_EFUSE, DBG_LOUD, "\n");
 	return true;
 }
 
@@ -656,8 +656,8 @@ static int efuse_one_byte_write(struct ieee80211_hw *hw, u16 addr, u8 data)
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	u8 tmpidx = 0;
 
-	RT_TRACE(rtlpriv, COMP_EFUSE, DBG_LOUD,
-		 "Addr = %x Data=%x\n", addr, data);
+	rtl_dbg(rtlpriv, COMP_EFUSE, DBG_LOUD,
+		"Addr = %x Data=%x\n", addr, data);
 
 	rtl_write_byte(rtlpriv,
 		       rtlpriv->cfg->maps[EFUSE_CTRL] + 1, (u8) (addr & 0xff));
@@ -1036,8 +1036,8 @@ static int efuse_pg_packet_write(struct ieee80211_hw *hw,
 
 	if (efuse_addr >= (EFUSE_MAX_SIZE -
 		rtlpriv->cfg->maps[EFUSE_OOB_PROTECT_BYTES_LEN])) {
-		RT_TRACE(rtlpriv, COMP_EFUSE, DBG_LOUD,
-			 "efuse_addr(%#x) Out of size!!\n", efuse_addr);
+		rtl_dbg(rtlpriv, COMP_EFUSE, DBG_LOUD,
+			"efuse_addr(%#x) Out of size!!\n", efuse_addr);
 	}
 
 	return true;
@@ -1077,8 +1077,8 @@ static u8 enable_efuse_data_write(struct ieee80211_hw *hw,
 	u8 tmpdata[8];
 
 	memset(tmpdata, 0xff, PGPKT_DATA_SIZE);
-	RT_TRACE(rtlpriv, COMP_EFUSE, DBG_LOUD,
-		 "word_en = %x efuse_addr=%x\n", word_en, efuse_addr);
+	rtl_dbg(rtlpriv, COMP_EFUSE, DBG_LOUD,
+		"word_en = %x efuse_addr=%x\n", word_en, efuse_addr);
 
 	if (!(word_en & BIT(0))) {
 		tmpaddr = start_addr;
@@ -1281,11 +1281,11 @@ int rtl_get_hwinfo(struct ieee80211_hw *hw, struct rtl_priv *rtlpriv,
 
 	eeprom_id = *((u16 *)&hwinfo[0]);
 	if (eeprom_id != params[0]) {
-		RT_TRACE(rtlpriv, COMP_ERR, DBG_WARNING,
-			 "EEPROM ID(%#x) is invalid!!\n", eeprom_id);
+		rtl_dbg(rtlpriv, COMP_ERR, DBG_WARNING,
+			"EEPROM ID(%#x) is invalid!!\n", eeprom_id);
 		rtlefuse->autoload_failflag = true;
 	} else {
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD, "Autoload OK\n");
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD, "Autoload OK\n");
 		rtlefuse->autoload_failflag = false;
 	}
 
@@ -1296,30 +1296,30 @@ int rtl_get_hwinfo(struct ieee80211_hw *hw, struct rtl_priv *rtlpriv,
 	rtlefuse->eeprom_did = *(u16 *)&hwinfo[params[2]];
 	rtlefuse->eeprom_svid = *(u16 *)&hwinfo[params[3]];
 	rtlefuse->eeprom_smid = *(u16 *)&hwinfo[params[4]];
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
-		 "EEPROMId = 0x%4x\n", eeprom_id);
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
-		 "EEPROM VID = 0x%4x\n", rtlefuse->eeprom_vid);
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
-		 "EEPROM DID = 0x%4x\n", rtlefuse->eeprom_did);
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
-		 "EEPROM SVID = 0x%4x\n", rtlefuse->eeprom_svid);
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
-		 "EEPROM SMID = 0x%4x\n", rtlefuse->eeprom_smid);
+	rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
+		"EEPROMId = 0x%4x\n", eeprom_id);
+	rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
+		"EEPROM VID = 0x%4x\n", rtlefuse->eeprom_vid);
+	rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
+		"EEPROM DID = 0x%4x\n", rtlefuse->eeprom_did);
+	rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
+		"EEPROM SVID = 0x%4x\n", rtlefuse->eeprom_svid);
+	rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
+		"EEPROM SMID = 0x%4x\n", rtlefuse->eeprom_smid);
 
 	for (i = 0; i < 6; i += 2) {
 		usvalue = *(u16 *)&hwinfo[params[5] + i];
 		*((u16 *)(&rtlefuse->dev_addr[i])) = usvalue;
 	}
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_DMESG, "%pM\n", rtlefuse->dev_addr);
+	rtl_dbg(rtlpriv, COMP_INIT, DBG_DMESG, "%pM\n", rtlefuse->dev_addr);
 
 	rtlefuse->eeprom_channelplan = *&hwinfo[params[6]];
 	rtlefuse->eeprom_version = *(u16 *)&hwinfo[params[7]];
 	rtlefuse->txpwr_fromeprom = true;
 	rtlefuse->eeprom_oemid = *&hwinfo[params[8]];
 
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
-		 "EEPROM Customer ID: 0x%2x\n", rtlefuse->eeprom_oemid);
+	rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
+		"EEPROM Customer ID: 0x%2x\n", rtlefuse->eeprom_oemid);
 
 	/* set channel plan to world wide 13 */
 	rtlefuse->channel_plan = params[9];
diff --git a/drivers/net/wireless/realtek/rtlwifi/pci.c b/drivers/net/wireless/realtek/rtlwifi/pci.c
index 83749578fa8b..0d22bd300f04 100644
--- a/drivers/net/wireless/realtek/rtlwifi/pci.c
+++ b/drivers/net/wireless/realtek/rtlwifi/pci.c
@@ -226,8 +226,8 @@ static void rtl_pci_disable_aspm(struct ieee80211_hw *hw)
 		return;
 
 	if (pcibridge_vendor == PCI_BRIDGE_VENDOR_UNKNOWN) {
-		RT_TRACE(rtlpriv, COMP_POWER, DBG_TRACE,
-			 "PCI(Bridge) UNKNOWN\n");
+		rtl_dbg(rtlpriv, COMP_POWER, DBG_TRACE,
+			"PCI(Bridge) UNKNOWN\n");
 
 		return;
 	}
@@ -276,8 +276,8 @@ static void rtl_pci_enable_aspm(struct ieee80211_hw *hw)
 		return;
 
 	if (pcibridge_vendor == PCI_BRIDGE_VENDOR_UNKNOWN) {
-		RT_TRACE(rtlpriv, COMP_POWER, DBG_TRACE,
-			 "PCI(Bridge) UNKNOWN\n");
+		rtl_dbg(rtlpriv, COMP_POWER, DBG_TRACE,
+			"PCI(Bridge) UNKNOWN\n");
 		return;
 	}
 
@@ -293,10 +293,10 @@ static void rtl_pci_enable_aspm(struct ieee80211_hw *hw)
 	pci_write_config_byte(rtlpci->pdev, (num4bytes << 2),
 			      u_pcibridge_aspmsetting);
 
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
-		 "PlatformEnableASPM(): Write reg[%x] = %x\n",
-		 (pcipriv->ndis_adapter.pcibridge_pciehdr_offset + 0x10),
-		 u_pcibridge_aspmsetting);
+	rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
+		"PlatformEnableASPM(): Write reg[%x] = %x\n",
+		(pcipriv->ndis_adapter.pcibridge_pciehdr_offset + 0x10),
+		u_pcibridge_aspmsetting);
 
 	udelay(50);
 
@@ -353,11 +353,11 @@ static bool rtl_pci_check_buddy_priv(struct ieee80211_hw *hw,
 		list_for_each_entry(tpriv, &rtlpriv->glb_var->glb_priv_list,
 				    list) {
 			tpcipriv = (struct rtl_pci_priv *)tpriv->priv;
-			RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
-				 "pcipriv->ndis_adapter.funcnumber %x\n",
+			rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
+				"pcipriv->ndis_adapter.funcnumber %x\n",
 				pcipriv->ndis_adapter.funcnumber);
-			RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
-				 "tpcipriv->ndis_adapter.funcnumber %x\n",
+			rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
+				"tpcipriv->ndis_adapter.funcnumber %x\n",
 				tpcipriv->ndis_adapter.funcnumber);
 
 			if (pcipriv->ndis_adapter.busnumber ==
@@ -372,8 +372,8 @@ static bool rtl_pci_check_buddy_priv(struct ieee80211_hw *hw,
 		}
 	}
 
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
-		 "find_buddy_priv %d\n", find_buddy_priv);
+	rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
+		"find_buddy_priv %d\n", find_buddy_priv);
 
 	if (find_buddy_priv)
 		*buddy_priv = tpriv;
@@ -410,8 +410,8 @@ static void rtl_pci_parse_configuration(struct pci_dev *pdev,
 	pcie_capability_read_word(pdev, PCI_EXP_LNKCTL, &linkctrl_reg);
 	pcipriv->ndis_adapter.linkctrl_reg = (u8)linkctrl_reg;
 
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE, "Link Control Register =%x\n",
-		 pcipriv->ndis_adapter.linkctrl_reg);
+	rtl_dbg(rtlpriv, COMP_INIT, DBG_TRACE, "Link Control Register =%x\n",
+		pcipriv->ndis_adapter.linkctrl_reg);
 
 	pci_read_config_byte(pdev, 0x98, &tmp);
 	tmp |= BIT(4);
@@ -579,11 +579,11 @@ static void _rtl_pci_tx_isr(struct ieee80211_hw *hw, int prio)
 		if (rtlpriv->rtlhal.earlymode_enable)
 			skb_pull(skb, EM_HDR_LEN);
 
-		RT_TRACE(rtlpriv, (COMP_INTR | COMP_SEND), DBG_TRACE,
-			 "new ring->idx:%d, free: skb_queue_len:%d, free: seq:%x\n",
-			 ring->idx,
-			 skb_queue_len(&ring->queue),
-			 *(u16 *)(skb->data + 22));
+		rtl_dbg(rtlpriv, (COMP_INTR | COMP_SEND), DBG_TRACE,
+			"new ring->idx:%d, free: skb_queue_len:%d, free: seq:%x\n",
+			ring->idx,
+			skb_queue_len(&ring->queue),
+			*(u16 *)(skb->data + 22));
 
 		if (prio == TXCMD_QUEUE) {
 			dev_kfree_skb(skb);
@@ -630,10 +630,10 @@ static void _rtl_pci_tx_isr(struct ieee80211_hw *hw, int prio)
 		}
 
 		if ((ring->entries - skb_queue_len(&ring->queue)) <= 4) {
-			RT_TRACE(rtlpriv, COMP_ERR, DBG_DMESG,
-				 "more desc left, wake skb_queue@%d, ring->idx = %d, skb_queue_len = 0x%x\n",
-				 prio, ring->idx,
-				 skb_queue_len(&ring->queue));
+			rtl_dbg(rtlpriv, COMP_ERR, DBG_DMESG,
+				"more desc left, wake skb_queue@%d, ring->idx = %d, skb_queue_len = 0x%x\n",
+				prio, ring->idx,
+				skb_queue_len(&ring->queue));
 
 			ieee80211_wake_queue(hw, skb_get_queue_mapping(skb));
 		}
@@ -823,9 +823,9 @@ static void _rtl_pci_rx_interrupt(struct ieee80211_hw *hw)
 				skb_reserve(skb, stats.rx_drvinfo_size +
 					    stats.rx_bufshift);
 		} else {
-			RT_TRACE(rtlpriv, COMP_ERR, DBG_WARNING,
-				 "skb->end - skb->tail = %d, len is %d\n",
-				 skb->end - skb->tail, len);
+			rtl_dbg(rtlpriv, COMP_ERR, DBG_WARNING,
+				"skb->end - skb->tail = %d, len is %d\n",
+				skb->end - skb->tail, len);
 			dev_kfree_skb_any(skb);
 			goto new_trx_end;
 		}
@@ -946,67 +946,67 @@ static irqreturn_t _rtl_pci_interrupt(int irq, void *dev_id)
 
 	/*<1> beacon related */
 	if (intvec.inta & rtlpriv->cfg->maps[RTL_IMR_TBDOK])
-		RT_TRACE(rtlpriv, COMP_INTR, DBG_TRACE,
-			 "beacon ok interrupt!\n");
+		rtl_dbg(rtlpriv, COMP_INTR, DBG_TRACE,
+			"beacon ok interrupt!\n");
 
 	if (unlikely(intvec.inta & rtlpriv->cfg->maps[RTL_IMR_TBDER]))
-		RT_TRACE(rtlpriv, COMP_INTR, DBG_TRACE,
-			 "beacon err interrupt!\n");
+		rtl_dbg(rtlpriv, COMP_INTR, DBG_TRACE,
+			"beacon err interrupt!\n");
 
 	if (intvec.inta & rtlpriv->cfg->maps[RTL_IMR_BDOK])
-		RT_TRACE(rtlpriv, COMP_INTR, DBG_TRACE, "beacon interrupt!\n");
+		rtl_dbg(rtlpriv, COMP_INTR, DBG_TRACE, "beacon interrupt!\n");
 
 	if (intvec.inta & rtlpriv->cfg->maps[RTL_IMR_BCNINT]) {
-		RT_TRACE(rtlpriv, COMP_INTR, DBG_TRACE,
-			 "prepare beacon for interrupt!\n");
+		rtl_dbg(rtlpriv, COMP_INTR, DBG_TRACE,
+			"prepare beacon for interrupt!\n");
 		tasklet_schedule(&rtlpriv->works.irq_prepare_bcn_tasklet);
 	}
 
 	/*<2> Tx related */
 	if (unlikely(intvec.intb & rtlpriv->cfg->maps[RTL_IMR_TXFOVW]))
-		RT_TRACE(rtlpriv, COMP_ERR, DBG_WARNING, "IMR_TXFOVW!\n");
+		rtl_dbg(rtlpriv, COMP_ERR, DBG_WARNING, "IMR_TXFOVW!\n");
 
 	if (intvec.inta & rtlpriv->cfg->maps[RTL_IMR_MGNTDOK]) {
-		RT_TRACE(rtlpriv, COMP_INTR, DBG_TRACE,
-			 "Manage ok interrupt!\n");
+		rtl_dbg(rtlpriv, COMP_INTR, DBG_TRACE,
+			"Manage ok interrupt!\n");
 		_rtl_pci_tx_isr(hw, MGNT_QUEUE);
 	}
 
 	if (intvec.inta & rtlpriv->cfg->maps[RTL_IMR_HIGHDOK]) {
-		RT_TRACE(rtlpriv, COMP_INTR, DBG_TRACE,
-			 "HIGH_QUEUE ok interrupt!\n");
+		rtl_dbg(rtlpriv, COMP_INTR, DBG_TRACE,
+			"HIGH_QUEUE ok interrupt!\n");
 		_rtl_pci_tx_isr(hw, HIGH_QUEUE);
 	}
 
 	if (intvec.inta & rtlpriv->cfg->maps[RTL_IMR_BKDOK]) {
 		rtlpriv->link_info.num_tx_inperiod++;
 
-		RT_TRACE(rtlpriv, COMP_INTR, DBG_TRACE,
-			 "BK Tx OK interrupt!\n");
+		rtl_dbg(rtlpriv, COMP_INTR, DBG_TRACE,
+			"BK Tx OK interrupt!\n");
 		_rtl_pci_tx_isr(hw, BK_QUEUE);
 	}
 
 	if (intvec.inta & rtlpriv->cfg->maps[RTL_IMR_BEDOK]) {
 		rtlpriv->link_info.num_tx_inperiod++;
 
-		RT_TRACE(rtlpriv, COMP_INTR, DBG_TRACE,
-			 "BE TX OK interrupt!\n");
+		rtl_dbg(rtlpriv, COMP_INTR, DBG_TRACE,
+			"BE TX OK interrupt!\n");
 		_rtl_pci_tx_isr(hw, BE_QUEUE);
 	}
 
 	if (intvec.inta & rtlpriv->cfg->maps[RTL_IMR_VIDOK]) {
 		rtlpriv->link_info.num_tx_inperiod++;
 
-		RT_TRACE(rtlpriv, COMP_INTR, DBG_TRACE,
-			 "VI TX OK interrupt!\n");
+		rtl_dbg(rtlpriv, COMP_INTR, DBG_TRACE,
+			"VI TX OK interrupt!\n");
 		_rtl_pci_tx_isr(hw, VI_QUEUE);
 	}
 
 	if (intvec.inta & rtlpriv->cfg->maps[RTL_IMR_VODOK]) {
 		rtlpriv->link_info.num_tx_inperiod++;
 
-		RT_TRACE(rtlpriv, COMP_INTR, DBG_TRACE,
-			 "Vo TX OK interrupt!\n");
+		rtl_dbg(rtlpriv, COMP_INTR, DBG_TRACE,
+			"Vo TX OK interrupt!\n");
 		_rtl_pci_tx_isr(hw, VO_QUEUE);
 	}
 
@@ -1014,8 +1014,8 @@ static irqreturn_t _rtl_pci_interrupt(int irq, void *dev_id)
 		if (intvec.intd & rtlpriv->cfg->maps[RTL_IMR_H2CDOK]) {
 			rtlpriv->link_info.num_tx_inperiod++;
 
-			RT_TRACE(rtlpriv, COMP_INTR, DBG_TRACE,
-				 "H2C TX OK interrupt!\n");
+			rtl_dbg(rtlpriv, COMP_INTR, DBG_TRACE,
+				"H2C TX OK interrupt!\n");
 			_rtl_pci_tx_isr(hw, H2C_QUEUE);
 		}
 	}
@@ -1024,34 +1024,34 @@ static irqreturn_t _rtl_pci_interrupt(int irq, void *dev_id)
 		if (intvec.inta & rtlpriv->cfg->maps[RTL_IMR_COMDOK]) {
 			rtlpriv->link_info.num_tx_inperiod++;
 
-			RT_TRACE(rtlpriv, COMP_INTR, DBG_TRACE,
-				 "CMD TX OK interrupt!\n");
+			rtl_dbg(rtlpriv, COMP_INTR, DBG_TRACE,
+				"CMD TX OK interrupt!\n");
 			_rtl_pci_tx_isr(hw, TXCMD_QUEUE);
 		}
 	}
 
 	/*<3> Rx related */
 	if (intvec.inta & rtlpriv->cfg->maps[RTL_IMR_ROK]) {
-		RT_TRACE(rtlpriv, COMP_INTR, DBG_TRACE, "Rx ok interrupt!\n");
+		rtl_dbg(rtlpriv, COMP_INTR, DBG_TRACE, "Rx ok interrupt!\n");
 		_rtl_pci_rx_interrupt(hw);
 	}
 
 	if (unlikely(intvec.inta & rtlpriv->cfg->maps[RTL_IMR_RDU])) {
-		RT_TRACE(rtlpriv, COMP_ERR, DBG_WARNING,
-			 "rx descriptor unavailable!\n");
+		rtl_dbg(rtlpriv, COMP_ERR, DBG_WARNING,
+			"rx descriptor unavailable!\n");
 		_rtl_pci_rx_interrupt(hw);
 	}
 
 	if (unlikely(intvec.intb & rtlpriv->cfg->maps[RTL_IMR_RXFOVW])) {
-		RT_TRACE(rtlpriv, COMP_ERR, DBG_WARNING, "rx overflow !\n");
+		rtl_dbg(rtlpriv, COMP_ERR, DBG_WARNING, "rx overflow !\n");
 		_rtl_pci_rx_interrupt(hw);
 	}
 
 	/*<4> fw related*/
 	if (rtlhal->hw_type == HARDWARE_TYPE_RTL8723AE) {
 		if (intvec.inta & rtlpriv->cfg->maps[RTL_IMR_C2HCMD]) {
-			RT_TRACE(rtlpriv, COMP_INTR, DBG_TRACE,
-				 "firmware interrupt!\n");
+			rtl_dbg(rtlpriv, COMP_INTR, DBG_TRACE,
+				"firmware interrupt!\n");
 			queue_delayed_work(rtlpriv->works.rtl_wq,
 					   &rtlpriv->works.fwevt_wq, 0);
 		}
@@ -1067,8 +1067,8 @@ static irqreturn_t _rtl_pci_interrupt(int irq, void *dev_id)
 	    rtlhal->hw_type == HARDWARE_TYPE_RTL8723BE) {
 		if (unlikely(intvec.inta &
 		    rtlpriv->cfg->maps[RTL_IMR_HSISR_IND])) {
-			RT_TRACE(rtlpriv, COMP_INTR, DBG_TRACE,
-				 "hsisr interrupt!\n");
+			rtl_dbg(rtlpriv, COMP_INTR, DBG_TRACE,
+				"hsisr interrupt!\n");
 			_rtl_pci_hs_interrupt(hw);
 		}
 	}
@@ -1272,8 +1272,8 @@ static int _rtl_pci_init_tx_ring(struct ieee80211_hw *hw,
 	rtlpci->tx_ring[prio].entries = entries;
 	skb_queue_head_init(&rtlpci->tx_ring[prio].queue);
 
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD, "queue:%d, ring_addr:%p\n",
-		 prio, desc);
+	rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD, "queue:%d, ring_addr:%p\n",
+		prio, desc);
 
 	/* init every desc in this ring */
 	if (!rtlpriv->use_new_trx_flow) {
@@ -1670,10 +1670,10 @@ static int rtl_pci_tx(struct ieee80211_hw *hw,
 				true, HW_DESC_OWN);
 
 		if (own == 1 && hw_queue != BEACON_QUEUE) {
-			RT_TRACE(rtlpriv, COMP_ERR, DBG_WARNING,
-				 "No more TX desc@%d, ring->idx = %d, idx = %d, skb_queue_len = 0x%x\n",
-				 hw_queue, ring->idx, idx,
-				 skb_queue_len(&ring->queue));
+			rtl_dbg(rtlpriv, COMP_ERR, DBG_WARNING,
+				"No more TX desc@%d, ring->idx = %d, idx = %d, skb_queue_len = 0x%x\n",
+				hw_queue, ring->idx, idx,
+				skb_queue_len(&ring->queue));
 
 			spin_unlock_irqrestore(&rtlpriv->locks.irq_th_lock,
 					       flags);
@@ -1683,8 +1683,8 @@ static int rtl_pci_tx(struct ieee80211_hw *hw,
 
 	if (rtlpriv->cfg->ops->get_available_desc &&
 	    rtlpriv->cfg->ops->get_available_desc(hw, hw_queue) == 0) {
-		RT_TRACE(rtlpriv, COMP_ERR, DBG_WARNING,
-			 "get_available_desc fail\n");
+		rtl_dbg(rtlpriv, COMP_ERR, DBG_WARNING,
+			"get_available_desc fail\n");
 		spin_unlock_irqrestore(&rtlpriv->locks.irq_th_lock, flags);
 		return skb->len;
 	}
@@ -1707,8 +1707,8 @@ static int rtl_pci_tx(struct ieee80211_hw *hw,
 
 	if ((ring->entries - skb_queue_len(&ring->queue)) < 2 &&
 	    hw_queue != BEACON_QUEUE) {
-		RT_TRACE(rtlpriv, COMP_ERR, DBG_LOUD,
-			 "less desc left, stop skb_queue@%d, ring->idx = %d, idx = %d, skb_queue_len = 0x%x\n",
+		rtl_dbg(rtlpriv, COMP_ERR, DBG_LOUD,
+			"less desc left, stop skb_queue@%d, ring->idx = %d, idx = %d, skb_queue_len = 0x%x\n",
 			 hw_queue, ring->idx, idx,
 			 skb_queue_len(&ring->queue));
 
@@ -1815,15 +1815,17 @@ static int rtl_pci_start(struct ieee80211_hw *hw)
 
 	err = rtlpriv->cfg->ops->hw_init(hw);
 	if (err) {
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_DMESG,
-			 "Failed to config hardware!\n");
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_DMESG,
+			"Failed to config hardware!\n");
+		kfree(rtlpriv->btcoexist.btc_context);
+		kfree(rtlpriv->btcoexist.wifi_only_context);
 		return err;
 	}
 	rtlpriv->cfg->ops->set_hw_reg(hw, HW_VAR_RETRY_LIMIT,
 			&rtlmac->retry_long);
 
 	rtlpriv->cfg->ops->enable_interrupt(hw);
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD, "enable_interrupt OK\n");
+	rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD, "enable_interrupt OK\n");
 
 	rtl_init_rx_config(hw);
 
@@ -1834,7 +1836,7 @@ static int rtl_pci_start(struct ieee80211_hw *hw)
 
 	rtlpci->up_first_time = false;
 
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_DMESG, "%s OK\n", __func__);
+	rtl_dbg(rtlpriv, COMP_INIT, DBG_DMESG, "%s OK\n", __func__);
 	return 0;
 }
 
@@ -1928,71 +1930,71 @@ static bool _rtl_pci_find_adapter(struct pci_dev *pdev,
 	    deviceid == RTL_PCI_8171_DID) {
 		switch (revisionid) {
 		case RTL_PCI_REVISION_ID_8192PCIE:
-			RT_TRACE(rtlpriv, COMP_INIT, DBG_DMESG,
-				 "8192 PCI-E is found - vid/did=%x/%x\n",
-				 venderid, deviceid);
+			rtl_dbg(rtlpriv, COMP_INIT, DBG_DMESG,
+				"8192 PCI-E is found - vid/did=%x/%x\n",
+				venderid, deviceid);
 			rtlhal->hw_type = HARDWARE_TYPE_RTL8192E;
 			return false;
 		case RTL_PCI_REVISION_ID_8192SE:
-			RT_TRACE(rtlpriv, COMP_INIT, DBG_DMESG,
-				 "8192SE is found - vid/did=%x/%x\n",
-				 venderid, deviceid);
+			rtl_dbg(rtlpriv, COMP_INIT, DBG_DMESG,
+				"8192SE is found - vid/did=%x/%x\n",
+				venderid, deviceid);
 			rtlhal->hw_type = HARDWARE_TYPE_RTL8192SE;
 			break;
 		default:
-			RT_TRACE(rtlpriv, COMP_ERR, DBG_WARNING,
-				 "Err: Unknown device - vid/did=%x/%x\n",
-				 venderid, deviceid);
+			rtl_dbg(rtlpriv, COMP_ERR, DBG_WARNING,
+				"Err: Unknown device - vid/did=%x/%x\n",
+				venderid, deviceid);
 			rtlhal->hw_type = HARDWARE_TYPE_RTL8192SE;
 			break;
 		}
 	} else if (deviceid == RTL_PCI_8723AE_DID) {
 		rtlhal->hw_type = HARDWARE_TYPE_RTL8723AE;
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_DMESG,
-			 "8723AE PCI-E is found - vid/did=%x/%x\n",
-			 venderid, deviceid);
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_DMESG,
+			"8723AE PCI-E is found - vid/did=%x/%x\n",
+			venderid, deviceid);
 	} else if (deviceid == RTL_PCI_8192CET_DID ||
 		   deviceid == RTL_PCI_8192CE_DID ||
 		   deviceid == RTL_PCI_8191CE_DID ||
 		   deviceid == RTL_PCI_8188CE_DID) {
 		rtlhal->hw_type = HARDWARE_TYPE_RTL8192CE;
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_DMESG,
-			 "8192C PCI-E is found - vid/did=%x/%x\n",
-			 venderid, deviceid);
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_DMESG,
+			"8192C PCI-E is found - vid/did=%x/%x\n",
+			venderid, deviceid);
 	} else if (deviceid == RTL_PCI_8192DE_DID ||
 		   deviceid == RTL_PCI_8192DE_DID2) {
 		rtlhal->hw_type = HARDWARE_TYPE_RTL8192DE;
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_DMESG,
-			 "8192D PCI-E is found - vid/did=%x/%x\n",
-			 venderid, deviceid);
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_DMESG,
+			"8192D PCI-E is found - vid/did=%x/%x\n",
+			venderid, deviceid);
 	} else if (deviceid == RTL_PCI_8188EE_DID) {
 		rtlhal->hw_type = HARDWARE_TYPE_RTL8188EE;
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
-			 "Find adapter, Hardware type is 8188EE\n");
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
+			"Find adapter, Hardware type is 8188EE\n");
 	} else if (deviceid == RTL_PCI_8723BE_DID) {
 		rtlhal->hw_type = HARDWARE_TYPE_RTL8723BE;
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
-			 "Find adapter, Hardware type is 8723BE\n");
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
+			"Find adapter, Hardware type is 8723BE\n");
 	} else if (deviceid == RTL_PCI_8192EE_DID) {
 		rtlhal->hw_type = HARDWARE_TYPE_RTL8192EE;
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
-			 "Find adapter, Hardware type is 8192EE\n");
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
+			"Find adapter, Hardware type is 8192EE\n");
 	} else if (deviceid == RTL_PCI_8821AE_DID) {
 		rtlhal->hw_type = HARDWARE_TYPE_RTL8821AE;
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
-			 "Find adapter, Hardware type is 8821AE\n");
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
+			"Find adapter, Hardware type is 8821AE\n");
 	} else if (deviceid == RTL_PCI_8812AE_DID) {
 		rtlhal->hw_type = HARDWARE_TYPE_RTL8812AE;
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
-			 "Find adapter, Hardware type is 8812AE\n");
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
+			"Find adapter, Hardware type is 8812AE\n");
 	} else if (deviceid == RTL_PCI_8822BE_DID) {
 		rtlhal->hw_type = HARDWARE_TYPE_RTL8822BE;
 		rtlhal->bandset = BAND_ON_BOTH;
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
-			 "Find adapter, Hardware type is 8822BE\n");
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
+			"Find adapter, Hardware type is 8822BE\n");
 	} else {
-		RT_TRACE(rtlpriv, COMP_ERR, DBG_WARNING,
-			 "Err: Unknown device - vid/did=%x/%x\n",
+		rtl_dbg(rtlpriv, COMP_ERR, DBG_WARNING,
+			"Err: Unknown device - vid/did=%x/%x\n",
 			 venderid, deviceid);
 
 		rtlhal->hw_type = RTL_DEFAULT_HARDWARE_TYPE;
@@ -2001,17 +2003,17 @@ static bool _rtl_pci_find_adapter(struct pci_dev *pdev,
 	if (rtlhal->hw_type == HARDWARE_TYPE_RTL8192DE) {
 		if (revisionid == 0 || revisionid == 1) {
 			if (revisionid == 0) {
-				RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
-					 "Find 92DE MAC0\n");
+				rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
+					"Find 92DE MAC0\n");
 				rtlhal->interfaceindex = 0;
 			} else if (revisionid == 1) {
-				RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
-					 "Find 92DE MAC1\n");
+				rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
+					"Find 92DE MAC1\n");
 				rtlhal->interfaceindex = 1;
 			}
 		} else {
-			RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
-				 "Unknown device - VendorID/DeviceID=%x/%x, Revision=%x\n",
+			rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
+				"Unknown device - VendorID/DeviceID=%x/%x, Revision=%x\n",
 				 venderid, deviceid, revisionid);
 			rtlhal->interfaceindex = 0;
 		}
@@ -2045,9 +2047,9 @@ static bool _rtl_pci_find_adapter(struct pci_dev *pdev,
 		for (tmp = 0; tmp < PCI_BRIDGE_VENDOR_MAX; tmp++) {
 			if (bridge_pdev->vendor == pcibridge_vendors[tmp]) {
 				pcipriv->ndis_adapter.pcibridge_vendor = tmp;
-				RT_TRACE(rtlpriv, COMP_INIT, DBG_DMESG,
-					 "Pci Bridge Vendor is found index: %d\n",
-					 tmp);
+				rtl_dbg(rtlpriv, COMP_INIT, DBG_DMESG,
+					"Pci Bridge Vendor is found index: %d\n",
+					tmp);
 				break;
 			}
 		}
@@ -2075,22 +2077,22 @@ static bool _rtl_pci_find_adapter(struct pci_dev *pdev,
 		}
 	}
 
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_DMESG,
-		 "pcidev busnumber:devnumber:funcnumber:vendor:link_ctl %d:%d:%d:%x:%x\n",
-		 pcipriv->ndis_adapter.busnumber,
-		 pcipriv->ndis_adapter.devnumber,
-		 pcipriv->ndis_adapter.funcnumber,
-		 pdev->vendor, pcipriv->ndis_adapter.linkctrl_reg);
+	rtl_dbg(rtlpriv, COMP_INIT, DBG_DMESG,
+		"pcidev busnumber:devnumber:funcnumber:vendor:link_ctl %d:%d:%d:%x:%x\n",
+		pcipriv->ndis_adapter.busnumber,
+		pcipriv->ndis_adapter.devnumber,
+		pcipriv->ndis_adapter.funcnumber,
+		pdev->vendor, pcipriv->ndis_adapter.linkctrl_reg);
 
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_DMESG,
-		 "pci_bridge busnumber:devnumber:funcnumber:vendor:pcie_cap:link_ctl_reg:amd %d:%d:%d:%x:%x:%x:%x\n",
-		 pcipriv->ndis_adapter.pcibridge_busnum,
-		 pcipriv->ndis_adapter.pcibridge_devnum,
-		 pcipriv->ndis_adapter.pcibridge_funcnum,
-		 pcibridge_vendors[pcipriv->ndis_adapter.pcibridge_vendor],
-		 pcipriv->ndis_adapter.pcibridge_pciehdr_offset,
-		 pcipriv->ndis_adapter.pcibridge_linkctrlreg,
-		 pcipriv->ndis_adapter.amd_l1_patch);
+	rtl_dbg(rtlpriv, COMP_INIT, DBG_DMESG,
+		"pci_bridge busnumber:devnumber:funcnumber:vendor:pcie_cap:link_ctl_reg:amd %d:%d:%d:%x:%x:%x:%x\n",
+		pcipriv->ndis_adapter.pcibridge_busnum,
+		pcipriv->ndis_adapter.pcibridge_devnum,
+		pcipriv->ndis_adapter.pcibridge_funcnum,
+		pcibridge_vendors[pcipriv->ndis_adapter.pcibridge_vendor],
+		pcipriv->ndis_adapter.pcibridge_pciehdr_offset,
+		pcipriv->ndis_adapter.pcibridge_linkctrlreg,
+		pcipriv->ndis_adapter.amd_l1_patch);
 
 	rtl_pci_parse_configuration(pdev, hw);
 	list_add_tail(&rtlpriv->list, &rtlpriv->glb_var->glb_priv_list);
@@ -2118,8 +2120,8 @@ static int rtl_pci_intr_mode_msi(struct ieee80211_hw *hw)
 
 	rtlpci->using_msi = true;
 
-	RT_TRACE(rtlpriv, COMP_INIT | COMP_INTR, DBG_DMESG,
-		 "MSI Interrupt Mode!\n");
+	rtl_dbg(rtlpriv, COMP_INIT | COMP_INTR, DBG_DMESG,
+		"MSI Interrupt Mode!\n");
 	return 0;
 }
 
@@ -2136,8 +2138,8 @@ static int rtl_pci_intr_mode_legacy(struct ieee80211_hw *hw)
 		return ret;
 
 	rtlpci->using_msi = false;
-	RT_TRACE(rtlpriv, COMP_INIT | COMP_INTR, DBG_DMESG,
-		 "Pin-based Interrupt Mode!\n");
+	rtl_dbg(rtlpriv, COMP_INIT | COMP_INTR, DBG_DMESG,
+		"Pin-based Interrupt Mode!\n");
 	return 0;
 }
 
@@ -2264,10 +2266,10 @@ int rtl_pci_probe(struct pci_dev *pdev,
 		goto fail2;
 	}
 
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_DMESG,
-		 "mem mapped space: start: 0x%08lx len:%08lx flags:%08lx, after map:0x%08lx\n",
-		 pmem_start, pmem_len, pmem_flags,
-		 rtlpriv->io.pci_mem_start);
+	rtl_dbg(rtlpriv, COMP_INIT, DBG_DMESG,
+		"mem mapped space: start: 0x%08lx len:%08lx flags:%08lx, after map:0x%08lx\n",
+		pmem_start, pmem_len, pmem_flags,
+		rtlpriv->io.pci_mem_start);
 
 	/* Disable Clk Request */
 	pci_write_config_byte(pdev, 0x81, 0);
@@ -2329,9 +2331,9 @@ int rtl_pci_probe(struct pci_dev *pdev,
 	rtlpci = rtl_pcidev(pcipriv);
 	err = rtl_pci_intr_mode_decide(hw);
 	if (err) {
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_DMESG,
-			 "%s: failed to register IRQ handler\n",
-			 wiphy_name(hw->wiphy));
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_DMESG,
+			"%s: failed to register IRQ handler\n",
+			wiphy_name(hw->wiphy));
 		goto fail3;
 	}
 	rtlpci->irq_alloc = 1;
diff --git a/drivers/net/wireless/realtek/rtlwifi/ps.c b/drivers/net/wireless/realtek/rtlwifi/ps.c
index 5f998ea2d5a6..102f0d0e1cd0 100644
--- a/drivers/net/wireless/realtek/rtlwifi/ps.c
+++ b/drivers/net/wireless/realtek/rtlwifi/ps.c
@@ -41,8 +41,8 @@ bool rtl_ps_enable_nic(struct ieee80211_hw *hw)
 		rtlpriv->intf_ops->reset_trx_ring(hw);
 
 	if (is_hal_stop(rtlhal))
-		RT_TRACE(rtlpriv, COMP_ERR, DBG_WARNING,
-			 "Driver is already down!\n");
+		rtl_dbg(rtlpriv, COMP_ERR, DBG_WARNING,
+			"Driver is already down!\n");
 
 	/*<2> Enable Adapter */
 	if (rtlpriv->cfg->ops->hw_init(hw))
@@ -103,9 +103,9 @@ static bool rtl_ps_set_rf_state(struct ieee80211_hw *hw,
 		if (ppsc->rfchange_inprogress) {
 			spin_unlock(&rtlpriv->locks.rf_ps_lock);
 
-			RT_TRACE(rtlpriv, COMP_ERR, DBG_WARNING,
-				 "RF Change in progress! Wait to set..state_toset(%d).\n",
-				  state_toset);
+			rtl_dbg(rtlpriv, COMP_ERR, DBG_WARNING,
+				"RF Change in progress! Wait to set..state_toset(%d).\n",
+				state_toset);
 
 			/* Set RF after the previous action is done.  */
 			while (ppsc->rfchange_inprogress) {
@@ -217,8 +217,8 @@ void rtl_ips_nic_off_wq_callback(void *data)
 	enum rf_pwrstate rtstate;
 
 	if (mac->opmode != NL80211_IFTYPE_STATION) {
-		RT_TRACE(rtlpriv, COMP_ERR, DBG_WARNING,
-			 "not station return\n");
+		rtl_dbg(rtlpriv, COMP_ERR, DBG_WARNING,
+			"not station return\n");
 		return;
 	}
 
@@ -254,8 +254,8 @@ void rtl_ips_nic_off_wq_callback(void *data)
 		    !ppsc->swrf_processing &&
 		    (mac->link_state == MAC80211_NOLINK) &&
 		    !mac->act_scanning) {
-			RT_TRACE(rtlpriv, COMP_RF, DBG_TRACE,
-				 "IPSEnter(): Turn off RF\n");
+			rtl_dbg(rtlpriv, COMP_RF, DBG_TRACE,
+				"IPSEnter(): Turn off RF\n");
 
 			ppsc->inactive_pwrstate = ERFOFF;
 			ppsc->in_powersavemode = true;
@@ -333,8 +333,8 @@ static bool rtl_get_fwlps_doze(struct ieee80211_hw *hw)
 				       ppsc->last_delaylps_stamp_jiffies);
 
 	if (ps_timediff < 2000) {
-		RT_TRACE(rtlpriv, COMP_POWER, DBG_LOUD,
-			 "Delay enter Fw LPS for DHCP, ARP, or EAPOL exchanging state\n");
+		rtl_dbg(rtlpriv, COMP_POWER, DBG_LOUD,
+			"Delay enter Fw LPS for DHCP, ARP, or EAPOL exchanging state\n");
 		return false;
 	}
 
@@ -379,9 +379,9 @@ void rtl_lps_set_psmode(struct ieee80211_hw *hw, u8 rt_psmode)
 
 	if ((ppsc->fwctrl_lps) && ppsc->report_linked) {
 		if (ppsc->dot11_psmode == EACTIVE) {
-			RT_TRACE(rtlpriv, COMP_RF, DBG_DMESG,
-				 "FW LPS leave ps_mode:%x\n",
-				  FW_PS_ACTIVE_MODE);
+			rtl_dbg(rtlpriv, COMP_RF, DBG_DMESG,
+				"FW LPS leave ps_mode:%x\n",
+				FW_PS_ACTIVE_MODE);
 			enter_fwlps = false;
 			ppsc->pwr_mode = FW_PS_ACTIVE_MODE;
 			ppsc->smart_ps = 0;
@@ -394,9 +394,9 @@ void rtl_lps_set_psmode(struct ieee80211_hw *hw, u8 rt_psmode)
 				rtlpriv->btcoexist.btc_ops->btc_lps_notify(rtlpriv, rt_psmode);
 		} else {
 			if (rtl_get_fwlps_doze(hw)) {
-				RT_TRACE(rtlpriv, COMP_RF, DBG_DMESG,
-					 "FW LPS enter ps_mode:%x\n",
-					 ppsc->fwctrl_psmode);
+				rtl_dbg(rtlpriv, COMP_RF, DBG_DMESG,
+					"FW LPS enter ps_mode:%x\n",
+					ppsc->fwctrl_psmode);
 				if (rtlpriv->cfg->ops->get_btc_status())
 					rtlpriv->btcoexist.btc_ops->btc_lps_notify(rtlpriv, rt_psmode);
 				enter_fwlps = true;
@@ -446,8 +446,8 @@ static void rtl_lps_enter_core(struct ieee80211_hw *hw)
 	 * bt_ccoexist may ask to enter lps.
 	 * In normal case, this constraint move to rtl_lps_set_psmode().
 	 */
-	RT_TRACE(rtlpriv, COMP_POWER, DBG_LOUD,
-		 "Enter 802.11 power save mode...\n");
+	rtl_dbg(rtlpriv, COMP_POWER, DBG_LOUD,
+		"Enter 802.11 power save mode...\n");
 	rtl_lps_set_psmode(hw, EAUTOPS);
 
 	mutex_unlock(&rtlpriv->locks.lps_mutex);
@@ -475,8 +475,8 @@ static void rtl_lps_leave_core(struct ieee80211_hw *hw)
 				RT_CLEAR_PS_LEVEL(ppsc, RT_PS_LEVEL_ASPM);
 			}
 
-			RT_TRACE(rtlpriv, COMP_POWER, DBG_LOUD,
-				 "Busy Traffic,Leave 802.11 power save..\n");
+			rtl_dbg(rtlpriv, COMP_POWER, DBG_LOUD,
+				"Busy Traffic,Leave 802.11 power save..\n");
 
 			rtl_lps_set_psmode(hw, EACTIVE);
 		}
@@ -560,8 +560,8 @@ void rtl_swlps_beacon(struct ieee80211_hw *hw, void *data, unsigned int len)
 		queue_delayed_work(rtlpriv->works.rtl_wq,
 				   &rtlpriv->works.ps_work, MSECS(5));
 	} else {
-		RT_TRACE(rtlpriv, COMP_POWER, DBG_DMESG,
-			 "u_bufferd: %x, m_buffered: %x\n", u_buffed, m_buffed);
+		rtl_dbg(rtlpriv, COMP_POWER, DBG_DMESG,
+			"u_bufferd: %x, m_buffered: %x\n", u_buffed, m_buffed);
 	}
 }
 EXPORT_SYMBOL_GPL(rtl_swlps_beacon);
@@ -656,9 +656,9 @@ void rtl_swlps_rf_sleep(struct ieee80211_hw *hw)
 	/* this print should always be dtim_conter = 0 &
 	 * sleep  = dtim_period, that meaons, we should
 	 * awake before every dtim */
-	RT_TRACE(rtlpriv, COMP_POWER, DBG_DMESG,
-		 "dtim_counter:%x will sleep :%d beacon_intv\n",
-		  rtlpriv->psc.dtim_counter, sleep_intv);
+	rtl_dbg(rtlpriv, COMP_POWER, DBG_DMESG,
+		"dtim_counter:%x will sleep :%d beacon_intv\n",
+		rtlpriv->psc.dtim_counter, sleep_intv);
 
 	/* we tested that 40ms is enough for sw & hw sw delay */
 	queue_delayed_work(rtlpriv->works.rtl_wq, &rtlpriv->works.ps_rfon_wq,
@@ -769,9 +769,9 @@ static void rtl_p2p_noa_ie(struct ieee80211_hw *hw, void *data,
 		if (ie[0] == 12) {
 			find_p2p_ps_ie = true;
 			if ((noa_len - 2) % 13 != 0) {
-				RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
-					 "P2P notice of absence: invalid length.%d\n",
-					 noa_len);
+				rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
+					"P2P notice of absence: invalid length.%d\n",
+					noa_len);
 				return;
 			} else {
 				noa_num = (noa_len - 2) / 13;
@@ -782,8 +782,8 @@ static void rtl_p2p_noa_ie(struct ieee80211_hw *hw, void *data,
 			noa_index = ie[3];
 			if (rtlpriv->psc.p2p_ps_info.p2p_ps_mode ==
 			    P2P_PS_NONE || noa_index != p2pinfo->noa_index) {
-				RT_TRACE(rtlpriv, COMP_FW, DBG_LOUD,
-					 "update NOA ie.\n");
+				rtl_dbg(rtlpriv, COMP_FW, DBG_LOUD,
+					"update NOA ie.\n");
 				p2pinfo->noa_index = noa_index;
 				p2pinfo->opp_ps = (ie[4] >> 7);
 				p2pinfo->ctwindow = ie[4] & 0x7F;
@@ -854,7 +854,7 @@ static void rtl_p2p_action_ie(struct ieee80211_hw *hw, void *data,
 	if (ie == NULL)
 		return;
 
-	RT_TRACE(rtlpriv, COMP_FW, DBG_LOUD, "action frame find P2P IE.\n");
+	rtl_dbg(rtlpriv, COMP_FW, DBG_LOUD, "action frame find P2P IE.\n");
 	/*to find noa ie*/
 	while (ie + 1 < end) {
 		noa_len = READEF2BYTE((__le16 *)&ie[1]);
@@ -862,13 +862,13 @@ static void rtl_p2p_action_ie(struct ieee80211_hw *hw, void *data,
 			return;
 
 		if (ie[0] == 12) {
-			RT_TRACE(rtlpriv, COMP_FW, DBG_LOUD, "find NOA IE.\n");
+			rtl_dbg(rtlpriv, COMP_FW, DBG_LOUD, "find NOA IE.\n");
 			RT_PRINT_DATA(rtlpriv, COMP_FW, DBG_LOUD, "noa ie ",
 				      ie, noa_len);
 			if ((noa_len - 2) % 13 != 0) {
-				RT_TRACE(rtlpriv, COMP_FW, DBG_LOUD,
-					 "P2P notice of absence: invalid length.%d\n",
-					 noa_len);
+				rtl_dbg(rtlpriv, COMP_FW, DBG_LOUD,
+					"P2P notice of absence: invalid length.%d\n",
+					noa_len);
 				return;
 			} else {
 				noa_num = (noa_len - 2) / 13;
@@ -926,7 +926,7 @@ void rtl_p2p_ps_cmd(struct ieee80211_hw *hw , u8 p2p_ps_state)
 	struct rtl_ps_ctl *rtlps = rtl_psc(rtl_priv(hw));
 	struct rtl_p2p_ps_info  *p2pinfo = &(rtlpriv->psc.p2p_ps_info);
 
-	RT_TRACE(rtlpriv, COMP_FW, DBG_LOUD, " p2p state %x\n" , p2p_ps_state);
+	rtl_dbg(rtlpriv, COMP_FW, DBG_LOUD, " p2p state %x\n", p2p_ps_state);
 	switch (p2p_ps_state) {
 	case P2P_PS_DISABLE:
 		p2pinfo->p2p_ps_state = p2p_ps_state;
@@ -978,18 +978,18 @@ void rtl_p2p_ps_cmd(struct ieee80211_hw *hw , u8 p2p_ps_state)
 	default:
 		break;
 	}
-	RT_TRACE(rtlpriv, COMP_FW, DBG_LOUD,
-		 "ctwindow %x oppps %x\n",
-		 p2pinfo->ctwindow , p2pinfo->opp_ps);
-	RT_TRACE(rtlpriv, COMP_FW, DBG_LOUD,
-		 "count %x duration %x index %x interval %x start time %x noa num %x\n",
-		 p2pinfo->noa_count_type[0],
-		 p2pinfo->noa_duration[0],
-		 p2pinfo->noa_index,
-		 p2pinfo->noa_interval[0],
-		 p2pinfo->noa_start_time[0],
-		 p2pinfo->noa_num);
-	RT_TRACE(rtlpriv, COMP_FW, DBG_LOUD, "end\n");
+	rtl_dbg(rtlpriv, COMP_FW, DBG_LOUD,
+		"ctwindow %x oppps %x\n",
+		p2pinfo->ctwindow, p2pinfo->opp_ps);
+	rtl_dbg(rtlpriv, COMP_FW, DBG_LOUD,
+		"count %x duration %x index %x interval %x start time %x noa num %x\n",
+		p2pinfo->noa_count_type[0],
+		p2pinfo->noa_duration[0],
+		p2pinfo->noa_index,
+		p2pinfo->noa_interval[0],
+		p2pinfo->noa_start_time[0],
+		p2pinfo->noa_num);
+	rtl_dbg(rtlpriv, COMP_FW, DBG_LOUD, "end\n");
 }
 
 void rtl_p2p_info(struct ieee80211_hw *hw, void *data, unsigned int len)
diff --git a/drivers/net/wireless/realtek/rtlwifi/regd.c b/drivers/net/wireless/realtek/rtlwifi/regd.c
index 72ca370331fb..f89f60ddfebe 100644
--- a/drivers/net/wireless/realtek/rtlwifi/regd.c
+++ b/drivers/net/wireless/realtek/rtlwifi/regd.c
@@ -434,13 +434,13 @@ int rtl_regd_init(struct ieee80211_hw *hw,
 	rtlpriv->regd.country_code =
 		channel_plan_to_country_code(rtlpriv->efuse.channel_plan);
 
-	RT_TRACE(rtlpriv, COMP_REGD, DBG_DMESG,
-		 "rtl: EEPROM regdomain: 0x%0x country code: %d\n",
-		 rtlpriv->efuse.channel_plan, rtlpriv->regd.country_code);
+	rtl_dbg(rtlpriv, COMP_REGD, DBG_DMESG,
+		"rtl: EEPROM regdomain: 0x%0x country code: %d\n",
+		rtlpriv->efuse.channel_plan, rtlpriv->regd.country_code);
 
 	if (rtlpriv->regd.country_code >= COUNTRY_CODE_MAX) {
-		RT_TRACE(rtlpriv, COMP_REGD, DBG_DMESG,
-			 "rtl: EEPROM indicates invalid country code, world wide 13 should be used\n");
+		rtl_dbg(rtlpriv, COMP_REGD, DBG_DMESG,
+			"rtl: EEPROM indicates invalid country code, world wide 13 should be used\n");
 
 		rtlpriv->regd.country_code = COUNTRY_CODE_WORLD_WIDE_13;
 	}
@@ -455,9 +455,9 @@ int rtl_regd_init(struct ieee80211_hw *hw,
 		rtlpriv->regd.alpha2[1] = '0';
 	}
 
-	RT_TRACE(rtlpriv, COMP_REGD, DBG_TRACE,
-		 "rtl: Country alpha2 being used: %c%c\n",
-		  rtlpriv->regd.alpha2[0], rtlpriv->regd.alpha2[1]);
+	rtl_dbg(rtlpriv, COMP_REGD, DBG_TRACE,
+		"rtl: Country alpha2 being used: %c%c\n",
+		rtlpriv->regd.alpha2[0], rtlpriv->regd.alpha2[1]);
 
 	_rtl_regd_init_wiphy(&rtlpriv->regd, wiphy, reg_notifier);
 
@@ -469,7 +469,7 @@ void rtl_reg_notifier(struct wiphy *wiphy, struct regulatory_request *request)
 	struct ieee80211_hw *hw = wiphy_to_ieee80211_hw(wiphy);
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 
-	RT_TRACE(rtlpriv, COMP_REGD, DBG_LOUD, "\n");
+	rtl_dbg(rtlpriv, COMP_REGD, DBG_LOUD, "\n");
 
 	_rtl_reg_notifier_apply(wiphy, request, &rtlpriv->regd);
 }
diff --git a/drivers/net/wireless/realtek/rtlwifi/usb.c b/drivers/net/wireless/realtek/rtlwifi/usb.c
index 395671383ca9..35ebbd8ca9ca 100644
--- a/drivers/net/wireless/realtek/rtlwifi/usb.c
+++ b/drivers/net/wireless/realtek/rtlwifi/usb.c
@@ -282,14 +282,14 @@ static int _rtl_usb_init_tx(struct ieee80211_hw *hw)
 						    ? USB_HIGH_SPEED_BULK_SIZE
 						    : USB_FULL_SPEED_BULK_SIZE;
 
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_DMESG, "USB Max Bulk-out Size=%d\n",
-		 rtlusb->max_bulk_out_size);
+	rtl_dbg(rtlpriv, COMP_INIT, DBG_DMESG, "USB Max Bulk-out Size=%d\n",
+		rtlusb->max_bulk_out_size);
 
 	for (i = 0; i < __RTL_TXQ_NUM; i++) {
 		u32 ep_num = rtlusb->ep_map.ep_mapping[i];
 		if (!ep_num) {
-			RT_TRACE(rtlpriv, COMP_INIT, DBG_DMESG,
-				 "Invalid endpoint map setting!\n");
+			rtl_dbg(rtlpriv, COMP_INIT, DBG_DMESG,
+				"Invalid endpoint map setting!\n");
 			return -EINVAL;
 		}
 	}
@@ -358,10 +358,10 @@ static int _rtl_usb_init(struct ieee80211_hw *hw)
 		else if (usb_endpoint_dir_out(pep_desc))
 			rtlusb->out_ep_nums++;
 
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_DMESG,
-			 "USB EP(0x%02x), MaxPacketSize=%d, Interval=%d\n",
-			 pep_desc->bEndpointAddress, pep_desc->wMaxPacketSize,
-			 pep_desc->bInterval);
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_DMESG,
+			"USB EP(0x%02x), MaxPacketSize=%d, Interval=%d\n",
+			pep_desc->bEndpointAddress, pep_desc->wMaxPacketSize,
+			pep_desc->bInterval);
 	}
 	if (rtlusb->in_ep_nums <  rtlpriv->cfg->usb_interface_cfg->in_ep_num) {
 		pr_err("Too few input end points found\n");
@@ -960,7 +960,7 @@ static void _rtl_usb_tx_preprocess(struct ieee80211_hw *hw,
 
 	memset(&tcb_desc, 0, sizeof(struct rtl_tcb_desc));
 	if (ieee80211_is_auth(fc)) {
-		RT_TRACE(rtlpriv, COMP_SEND, DBG_DMESG, "MAC80211_LINKING\n");
+		rtl_dbg(rtlpriv, COMP_SEND, DBG_DMESG, "MAC80211_LINKING\n");
 	}
 
 	if (rtlpriv->psc.sw_ps_enabled) {
diff --git a/drivers/of/device.c b/drivers/of/device.c
index 258742830e36..566d8af05157 100644
--- a/drivers/of/device.c
+++ b/drivers/of/device.c
@@ -258,12 +258,15 @@ int of_device_request_module(struct device *dev)
 	if (size < 0)
 		return size;
 
-	str = kmalloc(size + 1, GFP_KERNEL);
+	/* Reserve an additional byte for the trailing '\0' */
+	size++;
+
+	str = kmalloc(size, GFP_KERNEL);
 	if (!str)
 		return -ENOMEM;
 
 	of_device_get_modalias(dev, str, size);
-	str[size] = '\0';
+	str[size - 1] = '\0';
 	ret = request_module(str);
 	kfree(str);
 
diff --git a/drivers/pci/hotplug/pciehp.h b/drivers/pci/hotplug/pciehp.h
index ef6071807072..522719ca1c2b 100644
--- a/drivers/pci/hotplug/pciehp.h
+++ b/drivers/pci/hotplug/pciehp.h
@@ -84,6 +84,8 @@ struct slot {
  * @reset_lock: prevents access to the Data Link Layer Link Active bit in the
  *	Link Status register and to the Presence Detect State bit in the Slot
  *	Status register during a slot reset which may cause them to flap
+ * @depth: Number of additional hotplug ports in the path to the root bus,
+ *	used as lock subclass for @reset_lock
  * @slot: pointer to the controller's slot structure
  * @queue: wait queue to wake up on reception of a Command Completed event,
  *	used for synchronous writes to the Slot Control register
@@ -115,6 +117,7 @@ struct controller {
 	struct mutex ctrl_lock;
 	struct pcie_device *pcie;
 	struct rw_semaphore reset_lock;
+	unsigned int depth;
 	struct slot *slot;
 	wait_queue_head_t queue;
 	u32 slot_cap;
diff --git a/drivers/pci/hotplug/pciehp_core.c b/drivers/pci/hotplug/pciehp_core.c
index 518c46f8e63b..5ebfff9356c7 100644
--- a/drivers/pci/hotplug/pciehp_core.c
+++ b/drivers/pci/hotplug/pciehp_core.c
@@ -215,7 +215,7 @@ static void pciehp_check_presence(struct controller *ctrl)
 	struct slot *slot = ctrl->slot;
 	u8 occupied;
 
-	down_read(&ctrl->reset_lock);
+	down_read_nested(&ctrl->reset_lock, ctrl->depth);
 	mutex_lock(&slot->lock);
 
 	pciehp_get_adapter_status(slot, &occupied);
diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index 2795445233b3..7392b26e9f15 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -674,7 +674,7 @@ static irqreturn_t pciehp_ist(int irq, void *dev_id)
 	 * Disable requests have higher priority than Presence Detect Changed
 	 * or Data Link Layer State Changed events.
 	 */
-	down_read(&ctrl->reset_lock);
+	down_read_nested(&ctrl->reset_lock, ctrl->depth);
 	if (events & DISABLE_SLOT)
 		pciehp_handle_disable_request(slot);
 	else if (events & (PCI_EXP_SLTSTA_PDC | PCI_EXP_SLTSTA_DLLSC))
@@ -785,7 +785,7 @@ int pciehp_reset_slot(struct slot *slot, int probe)
 	if (probe)
 		return 0;
 
-	down_write(&ctrl->reset_lock);
+	down_write_nested(&ctrl->reset_lock, ctrl->depth);
 
 	if (!ATTN_BUTTN(ctrl)) {
 		ctrl_mask |= PCI_EXP_SLTCTL_PDCE;
@@ -872,6 +872,20 @@ static inline void dbg_ctrl(struct controller *ctrl)
 
 #define FLAG(x, y)	(((x) & (y)) ? '+' : '-')
 
+static inline int pcie_hotplug_depth(struct pci_dev *dev)
+{
+	struct pci_bus *bus = dev->bus;
+	int depth = 0;
+
+	while (bus->parent) {
+		bus = bus->parent;
+		if (bus->self && bus->self->is_hotplug_bridge)
+			depth++;
+	}
+
+	return depth;
+}
+
 struct controller *pcie_init(struct pcie_device *dev)
 {
 	struct controller *ctrl;
@@ -884,6 +898,7 @@ struct controller *pcie_init(struct pcie_device *dev)
 		goto abort;
 
 	ctrl->pcie = dev;
+	ctrl->depth = pcie_hotplug_depth(dev->port);
 	pcie_capability_read_dword(pdev, PCI_EXP_SLTCAP, &slot_cap);
 
 	if (pdev->hotplug_user_indicators)
diff --git a/drivers/pci/hotplug/pciehp_pci.c b/drivers/pci/hotplug/pciehp_pci.c
index 5c58c22e0c08..a32023afa25b 100644
--- a/drivers/pci/hotplug/pciehp_pci.c
+++ b/drivers/pci/hotplug/pciehp_pci.c
@@ -55,7 +55,14 @@ int pciehp_configure_device(struct slot *p_slot)
 
 	pci_assign_unassigned_bridge_resources(bridge);
 	pcie_bus_configure_settings(parent);
+
+	/*
+	 * Release reset_lock during driver binding
+	 * to avoid AB-BA deadlock with device_lock.
+	 */
+	up_read(&ctrl->reset_lock);
 	pci_bus_add_devices(parent);
+	down_read_nested(&ctrl->reset_lock, ctrl->depth);
 
  out:
 	pci_unlock_rescan_remove();
@@ -91,7 +98,15 @@ void pciehp_unconfigure_device(struct slot *p_slot)
 				pci_walk_bus(dev->subordinate,
 					     pci_dev_set_disconnected, NULL);
 		}
+
+		/*
+		 * Release reset_lock during driver unbinding
+		 * to avoid AB-BA deadlock with device_lock.
+		 */
+		up_read(&ctrl->reset_lock);
 		pci_stop_and_remove_bus_device(dev);
+		down_read_nested(&ctrl->reset_lock, ctrl->depth);
+
 		/*
 		 * Ensure that no new Requests will be generated from
 		 * the device.
diff --git a/drivers/phy/tegra/xusb.c b/drivers/phy/tegra/xusb.c
index 39c01ef57d83..17211b31e1ed 100644
--- a/drivers/phy/tegra/xusb.c
+++ b/drivers/phy/tegra/xusb.c
@@ -583,6 +583,7 @@ static int tegra_xusb_add_usb2_port(struct tegra_xusb_padctl *padctl,
 	usb2->base.lane = usb2->base.ops->map(&usb2->base);
 	if (IS_ERR(usb2->base.lane)) {
 		err = PTR_ERR(usb2->base.lane);
+		tegra_xusb_port_unregister(&usb2->base);
 		goto out;
 	}
 
@@ -635,6 +636,7 @@ static int tegra_xusb_add_ulpi_port(struct tegra_xusb_padctl *padctl,
 	ulpi->base.lane = ulpi->base.ops->map(&ulpi->base);
 	if (IS_ERR(ulpi->base.lane)) {
 		err = PTR_ERR(ulpi->base.lane);
+		tegra_xusb_port_unregister(&ulpi->base);
 		goto out;
 	}
 
diff --git a/drivers/platform/x86/touchscreen_dmi.c b/drivers/platform/x86/touchscreen_dmi.c
index f122a0263a1b..e26e2279ba6c 100644
--- a/drivers/platform/x86/touchscreen_dmi.c
+++ b/drivers/platform/x86/touchscreen_dmi.c
@@ -147,6 +147,22 @@ static const struct ts_dmi_data dexp_ursus_7w_data = {
 	.properties	= dexp_ursus_7w_props,
 };
 
+static const struct property_entry dexp_ursus_kx210i_props[] = {
+	PROPERTY_ENTRY_U32("touchscreen-min-x", 5),
+	PROPERTY_ENTRY_U32("touchscreen-min-y",  2),
+	PROPERTY_ENTRY_U32("touchscreen-size-x", 1720),
+	PROPERTY_ENTRY_U32("touchscreen-size-y", 1137),
+	PROPERTY_ENTRY_STRING("firmware-name", "gsl1680-dexp-ursus-kx210i.fw"),
+	PROPERTY_ENTRY_U32("silead,max-fingers", 10),
+	PROPERTY_ENTRY_BOOL("silead,home-button"),
+	{ }
+};
+
+static const struct ts_dmi_data dexp_ursus_kx210i_data = {
+	.acpi_name	= "MSSL1680:00",
+	.properties	= dexp_ursus_kx210i_props,
+};
+
 static const struct property_entry digma_citi_e200_props[] = {
 	PROPERTY_ENTRY_U32("touchscreen-size-x", 1980),
 	PROPERTY_ENTRY_U32("touchscreen-size-y", 1500),
@@ -502,6 +518,14 @@ static const struct dmi_system_id touchscreen_dmi_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "7W"),
 		},
 	},
+	{
+		/* DEXP Ursus KX210i */
+		.driver_data = (void *)&dexp_ursus_kx210i_data,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "INSYDE Corp."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "S107I"),
+		},
+	},
 	{
 		/* Digma Citi E200 */
 		.driver_data = (void *)&digma_citi_e200_data,
diff --git a/drivers/power/supply/generic-adc-battery.c b/drivers/power/supply/generic-adc-battery.c
index 97b0e873e87d..c2d6378bb897 100644
--- a/drivers/power/supply/generic-adc-battery.c
+++ b/drivers/power/supply/generic-adc-battery.c
@@ -138,6 +138,9 @@ static int read_channel(struct gab *adc_bat, enum power_supply_property psp,
 			result);
 	if (ret < 0)
 		pr_err("read channel error\n");
+	else
+		*result *= 1000;
+
 	return ret;
 }
 
diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
index e247ab632530..90aba3091b23 100644
--- a/drivers/pwm/pwm-meson.c
+++ b/drivers/pwm/pwm-meson.c
@@ -425,7 +425,7 @@ static const struct meson_pwm_data pwm_axg_ee_data = {
 };
 
 static const char * const pwm_axg_ao_parent_names[] = {
-	"aoclk81", "xtal", "fclk_div4", "fclk_div5"
+	"xtal", "axg_ao_clk81", "fclk_div4", "fclk_div5"
 };
 
 static const struct meson_pwm_data pwm_axg_ao_data = {
diff --git a/drivers/pwm/pwm-mtk-disp.c b/drivers/pwm/pwm-mtk-disp.c
index 893940d45f0d..c49b1e696b8c 100644
--- a/drivers/pwm/pwm-mtk-disp.c
+++ b/drivers/pwm/pwm-mtk-disp.c
@@ -82,6 +82,19 @@ static int mtk_disp_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	u64 div, rate;
 	int err;
 
+	err = clk_prepare_enable(mdp->clk_main);
+	if (err < 0) {
+		dev_err(chip->dev, "Can't enable mdp->clk_main: %pe\n", ERR_PTR(err));
+		return err;
+	}
+
+	err = clk_prepare_enable(mdp->clk_mm);
+	if (err < 0) {
+		dev_err(chip->dev, "Can't enable mdp->clk_mm: %pe\n", ERR_PTR(err));
+		clk_disable_unprepare(mdp->clk_main);
+		return err;
+	}
+
 	/*
 	 * Find period, high_width and clk_div to suit duty_ns and period_ns.
 	 * Calculate proper div value to keep period value in the bound.
@@ -95,8 +108,11 @@ static int mtk_disp_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	rate = clk_get_rate(mdp->clk_main);
 	clk_div = div_u64(rate * period_ns, NSEC_PER_SEC) >>
 			  PWM_PERIOD_BIT_WIDTH;
-	if (clk_div > PWM_CLKDIV_MAX)
+	if (clk_div > PWM_CLKDIV_MAX) {
+		clk_disable_unprepare(mdp->clk_mm);
+		clk_disable_unprepare(mdp->clk_main);
 		return -EINVAL;
+	}
 
 	div = NSEC_PER_SEC * (clk_div + 1);
 	period = div64_u64(rate * period_ns, div);
@@ -106,14 +122,17 @@ static int mtk_disp_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	high_width = div64_u64(rate * duty_ns, div);
 	value = period | (high_width << PWM_HIGH_WIDTH_SHIFT);
 
-	err = clk_enable(mdp->clk_main);
-	if (err < 0)
-		return err;
-
-	err = clk_enable(mdp->clk_mm);
-	if (err < 0) {
-		clk_disable(mdp->clk_main);
-		return err;
+	if (mdp->data->bls_debug && !mdp->data->has_commit) {
+		/*
+		 * For MT2701, disable double buffer before writing register
+		 * and select manual mode and use PWM_PERIOD/PWM_HIGH_WIDTH.
+		 */
+		mtk_disp_pwm_update_bits(mdp, mdp->data->bls_debug,
+					 mdp->data->bls_debug_mask,
+					 mdp->data->bls_debug_mask);
+		mtk_disp_pwm_update_bits(mdp, mdp->data->con0,
+					 mdp->data->con0_sel,
+					 mdp->data->con0_sel);
 	}
 
 	mtk_disp_pwm_update_bits(mdp, mdp->data->con0,
@@ -132,8 +151,8 @@ static int mtk_disp_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 					 0x0);
 	}
 
-	clk_disable(mdp->clk_mm);
-	clk_disable(mdp->clk_main);
+	clk_disable_unprepare(mdp->clk_mm);
+	clk_disable_unprepare(mdp->clk_main);
 
 	return 0;
 }
@@ -143,13 +162,16 @@ static int mtk_disp_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 	struct mtk_disp_pwm *mdp = to_mtk_disp_pwm(chip);
 	int err;
 
-	err = clk_enable(mdp->clk_main);
-	if (err < 0)
+	err = clk_prepare_enable(mdp->clk_main);
+	if (err < 0) {
+		dev_err(chip->dev, "Can't enable mdp->clk_main: %pe\n", ERR_PTR(err));
 		return err;
+	}
 
-	err = clk_enable(mdp->clk_mm);
+	err = clk_prepare_enable(mdp->clk_mm);
 	if (err < 0) {
-		clk_disable(mdp->clk_main);
+		dev_err(chip->dev, "Can't enable mdp->clk_mm: %pe\n", ERR_PTR(err));
+		clk_disable_unprepare(mdp->clk_main);
 		return err;
 	}
 
@@ -166,8 +188,8 @@ static void mtk_disp_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 	mtk_disp_pwm_update_bits(mdp, DISP_PWM_EN, mdp->data->enable_mask,
 				 0x0);
 
-	clk_disable(mdp->clk_mm);
-	clk_disable(mdp->clk_main);
+	clk_disable_unprepare(mdp->clk_mm);
+	clk_disable_unprepare(mdp->clk_main);
 }
 
 static const struct pwm_ops mtk_disp_pwm_ops = {
@@ -202,14 +224,6 @@ static int mtk_disp_pwm_probe(struct platform_device *pdev)
 	if (IS_ERR(mdp->clk_mm))
 		return PTR_ERR(mdp->clk_mm);
 
-	ret = clk_prepare(mdp->clk_main);
-	if (ret < 0)
-		return ret;
-
-	ret = clk_prepare(mdp->clk_mm);
-	if (ret < 0)
-		goto disable_clk_main;
-
 	mdp->chip.dev = &pdev->dev;
 	mdp->chip.ops = &mtk_disp_pwm_ops;
 	mdp->chip.base = -1;
@@ -217,44 +231,22 @@ static int mtk_disp_pwm_probe(struct platform_device *pdev)
 
 	ret = pwmchip_add(&mdp->chip);
 	if (ret < 0) {
-		dev_err(&pdev->dev, "pwmchip_add() failed: %d\n", ret);
-		goto disable_clk_mm;
+		dev_err(&pdev->dev, "pwmchip_add() failed: %pe\n", ERR_PTR(ret));
+		return ret;
 	}
 
 	platform_set_drvdata(pdev, mdp);
 
-	/*
-	 * For MT2701, disable double buffer before writing register
-	 * and select manual mode and use PWM_PERIOD/PWM_HIGH_WIDTH.
-	 */
-	if (!mdp->data->has_commit) {
-		mtk_disp_pwm_update_bits(mdp, mdp->data->bls_debug,
-					 mdp->data->bls_debug_mask,
-					 mdp->data->bls_debug_mask);
-		mtk_disp_pwm_update_bits(mdp, mdp->data->con0,
-					 mdp->data->con0_sel,
-					 mdp->data->con0_sel);
-	}
-
 	return 0;
-
-disable_clk_mm:
-	clk_unprepare(mdp->clk_mm);
-disable_clk_main:
-	clk_unprepare(mdp->clk_main);
-	return ret;
 }
 
 static int mtk_disp_pwm_remove(struct platform_device *pdev)
 {
 	struct mtk_disp_pwm *mdp = platform_get_drvdata(pdev);
-	int ret;
 
-	ret = pwmchip_remove(&mdp->chip);
-	clk_unprepare(mdp->clk_mm);
-	clk_unprepare(mdp->clk_main);
+	pwmchip_remove(&mdp->chip);
 
-	return ret;
+	return 0;
 }
 
 static const struct mtk_pwm_data mt2701_pwm_data = {
diff --git a/drivers/s390/block/dasd.c b/drivers/s390/block/dasd.c
index 7beda20cf122..c1cf277d0d89 100644
--- a/drivers/s390/block/dasd.c
+++ b/drivers/s390/block/dasd.c
@@ -2841,7 +2841,7 @@ static int _dasd_requeue_request(struct dasd_ccw_req *cqr)
 		return 0;
 	spin_lock_irq(&cqr->dq->lock);
 	req = (struct request *) cqr->callback_data;
-	blk_mq_requeue_request(req, false);
+	blk_mq_requeue_request(req, true);
 	spin_unlock_irq(&cqr->dq->lock);
 
 	return 0;
diff --git a/drivers/scsi/megaraid.c b/drivers/scsi/megaraid.c
index 7352d46ebb09..44d648baabd8 100644
--- a/drivers/scsi/megaraid.c
+++ b/drivers/scsi/megaraid.c
@@ -1444,6 +1444,7 @@ mega_cmd_done(adapter_t *adapter, u8 completed[], int nstatus, int status)
 		 */
 		if (cmdid == CMDID_INT_CMDS) {
 			scb = &adapter->int_scb;
+			cmd = scb->cmd;
 
 			list_del_init(&scb->list);
 			scb->state = SCB_FREE;
diff --git a/drivers/spi/spi-fsl-spi.c b/drivers/spi/spi-fsl-spi.c
index cd784552de7f..479d10dc6cb8 100644
--- a/drivers/spi/spi-fsl-spi.c
+++ b/drivers/spi/spi-fsl-spi.c
@@ -205,8 +205,8 @@ static int mspi_apply_qe_mode_quirks(struct spi_mpc8xxx_cs *cs,
 				struct spi_device *spi,
 				int bits_per_word)
 {
-	/* QE uses Little Endian for words > 8
-	 * so transform all words > 8 into 8 bits
+	/* CPM/QE uses Little Endian for words > 8
+	 * so transform 16 and 32 bits words into 8 bits
 	 * Unfortnatly that doesn't work for LSB so
 	 * reject these for now */
 	/* Note: 32 bits word, LSB works iff
@@ -214,9 +214,11 @@ static int mspi_apply_qe_mode_quirks(struct spi_mpc8xxx_cs *cs,
 	if (spi->mode & SPI_LSB_FIRST &&
 	    bits_per_word > 8)
 		return -EINVAL;
-	if (bits_per_word > 8)
+	if (bits_per_word <= 8)
+		return bits_per_word;
+	if (bits_per_word == 16 || bits_per_word == 32)
 		return 8; /* pretend its 8 bits */
-	return bits_per_word;
+	return -EINVAL;
 }
 
 static int fsl_spi_setup_transfer(struct spi_device *spi,
@@ -246,7 +248,7 @@ static int fsl_spi_setup_transfer(struct spi_device *spi,
 		bits_per_word = mspi_apply_cpu_mode_quirks(cs, spi,
 							   mpc8xxx_spi,
 							   bits_per_word);
-	else if (mpc8xxx_spi->flags & SPI_QE)
+	else
 		bits_per_word = mspi_apply_qe_mode_quirks(cs, spi,
 							  bits_per_word);
 
diff --git a/drivers/spi/spi-qup.c b/drivers/spi/spi-qup.c
index 1ca678bcb527..defe959884da 100644
--- a/drivers/spi/spi-qup.c
+++ b/drivers/spi/spi-qup.c
@@ -1250,17 +1250,21 @@ static int spi_qup_remove(struct platform_device *pdev)
 	int ret;
 
 	ret = pm_runtime_get_sync(&pdev->dev);
-	if (ret < 0)
-		return ret;
 
-	ret = spi_qup_set_state(controller, QUP_STATE_RESET);
-	if (ret)
-		return ret;
+	if (ret >= 0) {
+		ret = spi_qup_set_state(controller, QUP_STATE_RESET);
+		if (ret)
+			dev_warn(&pdev->dev, "failed to reset controller (%pe)\n",
+				 ERR_PTR(ret));
 
-	spi_qup_release_dma(master);
+		clk_disable_unprepare(controller->cclk);
+		clk_disable_unprepare(controller->iclk);
+	} else {
+		dev_warn(&pdev->dev, "failed to resume, skip hw disable (%pe)\n",
+			 ERR_PTR(ret));
+	}
 
-	clk_disable_unprepare(controller->cclk);
-	clk_disable_unprepare(controller->iclk);
+	spi_qup_release_dma(master);
 
 	pm_runtime_put_noidle(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
diff --git a/drivers/spmi/spmi.c b/drivers/spmi/spmi.c
index aa3edabc2b0f..55f1cad836ba 100644
--- a/drivers/spmi/spmi.c
+++ b/drivers/spmi/spmi.c
@@ -356,7 +356,8 @@ static int spmi_drv_remove(struct device *dev)
 	const struct spmi_driver *sdrv = to_spmi_driver(dev->driver);
 
 	pm_runtime_get_sync(dev);
-	sdrv->remove(to_spmi_device(dev));
+	if (sdrv->remove)
+		sdrv->remove(to_spmi_device(dev));
 	pm_runtime_put_noidle(dev);
 
 	pm_runtime_disable(dev);
diff --git a/drivers/staging/iio/resolver/ad2s1210.c b/drivers/staging/iio/resolver/ad2s1210.c
index aca983f34f5e..f41ee9243801 100644
--- a/drivers/staging/iio/resolver/ad2s1210.c
+++ b/drivers/staging/iio/resolver/ad2s1210.c
@@ -85,7 +85,7 @@ struct ad2s1210_state {
 static const int ad2s1210_mode_vals[4][2] = {
 	[MOD_POS] = { 0, 0 },
 	[MOD_VEL] = { 0, 1 },
-	[MOD_CONFIG] = { 1, 0 },
+	[MOD_CONFIG] = { 1, 1 },
 };
 
 static inline void ad2s1210_set_mode(enum ad2s1210_mode mode,
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index da73998bc5f7..d5ef1986bde4 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -778,6 +778,7 @@ static int _rtl92e_sta_up(struct net_device *dev, bool is_silent_reset)
 	else
 		netif_wake_queue(dev);
 
+	priv->bfirst_after_down = false;
 	return 0;
 }
 
diff --git a/drivers/target/iscsi/iscsi_target.c b/drivers/target/iscsi/iscsi_target.c
index 58ccded1be85..7738e249c4a2 100644
--- a/drivers/target/iscsi/iscsi_target.c
+++ b/drivers/target/iscsi/iscsi_target.c
@@ -4056,9 +4056,12 @@ static void iscsit_release_commands_from_conn(struct iscsi_conn *conn)
 	list_for_each_entry_safe(cmd, cmd_tmp, &tmp_list, i_conn_node) {
 		struct se_cmd *se_cmd = &cmd->se_cmd;
 
-		if (se_cmd->se_tfo != NULL) {
-			spin_lock_irq(&se_cmd->t_state_lock);
-			if (se_cmd->transport_state & CMD_T_ABORTED) {
+		if (!se_cmd->se_tfo)
+			continue;
+
+		spin_lock_irq(&se_cmd->t_state_lock);
+		if (se_cmd->transport_state & CMD_T_ABORTED) {
+			if (!(se_cmd->transport_state & CMD_T_TAS))
 				/*
 				 * LIO's abort path owns the cleanup for this,
 				 * so put it back on the list and let
@@ -4066,11 +4069,10 @@ static void iscsit_release_commands_from_conn(struct iscsi_conn *conn)
 				 */
 				list_move_tail(&cmd->i_conn_node,
 					       &conn->conn_cmd_list);
-			} else {
-				se_cmd->transport_state |= CMD_T_FABRIC_STOP;
-			}
-			spin_unlock_irq(&se_cmd->t_state_lock);
+		} else {
+			se_cmd->transport_state |= CMD_T_FABRIC_STOP;
 		}
+		spin_unlock_irq(&se_cmd->t_state_lock);
 	}
 	spin_unlock_bh(&conn->cmd_lock);
 
diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/8250.h
index ebfb0bd5bef5..8c8aa3b9c298 100644
--- a/drivers/tty/serial/8250/8250.h
+++ b/drivers/tty/serial/8250/8250.h
@@ -217,6 +217,13 @@ extern int serial8250_rx_dma(struct uart_8250_port *);
 extern void serial8250_rx_dma_flush(struct uart_8250_port *);
 extern int serial8250_request_dma(struct uart_8250_port *);
 extern void serial8250_release_dma(struct uart_8250_port *);
+
+static inline bool serial8250_tx_dma_running(struct uart_8250_port *p)
+{
+	struct uart_8250_dma *dma = p->dma;
+
+	return dma && dma->tx_running;
+}
 #else
 static inline int serial8250_tx_dma(struct uart_8250_port *p)
 {
@@ -232,6 +239,11 @@ static inline int serial8250_request_dma(struct uart_8250_port *p)
 	return -1;
 }
 static inline void serial8250_release_dma(struct uart_8250_port *p) { }
+
+static inline bool serial8250_tx_dma_running(struct uart_8250_port *p)
+{
+	return false;
+}
 #endif
 
 static inline int ns16550a_goto_highspeed(struct uart_8250_port *up)
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index ce266e10a21e..cba4888bc482 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -19,6 +19,7 @@
 #include <linux/moduleparam.h>
 #include <linux/ioport.h>
 #include <linux/init.h>
+#include <linux/irq.h>
 #include <linux/console.h>
 #include <linux/sysrq.h>
 #include <linux/delay.h>
@@ -1885,6 +1886,7 @@ int serial8250_handle_irq(struct uart_port *port, unsigned int iir)
 	unsigned char status;
 	unsigned long flags;
 	struct uart_8250_port *up = up_to_u8250p(port);
+	struct tty_port *tport = &port->state->port;
 	bool skip_rx = false;
 
 	if (iir & UART_IIR_NO_INT)
@@ -1908,6 +1910,8 @@ int serial8250_handle_irq(struct uart_port *port, unsigned int iir)
 		skip_rx = true;
 
 	if (status & (UART_LSR_DR | UART_LSR_BI) && !skip_rx) {
+		if (irqd_is_wakeup_set(irq_get_irq_data(port->irq)))
+			pm_wakeup_event(tport->tty->dev, 0);
 		if (!up->dma || handle_rx_dma(up, iir))
 			status = serial8250_rx_chars(up, status);
 	}
@@ -1963,19 +1967,25 @@ static int serial8250_tx_threshold_handle_irq(struct uart_port *port)
 static unsigned int serial8250_tx_empty(struct uart_port *port)
 {
 	struct uart_8250_port *up = up_to_u8250p(port);
+	unsigned int result = 0;
 	unsigned long flags;
 	unsigned int lsr;
 
 	serial8250_rpm_get(up);
 
 	spin_lock_irqsave(&port->lock, flags);
-	lsr = serial_port_in(port, UART_LSR);
-	up->lsr_saved_flags |= lsr & LSR_SAVE_FLAGS;
+	if (!serial8250_tx_dma_running(up)) {
+		lsr = serial_port_in(port, UART_LSR);
+		up->lsr_saved_flags |= lsr & LSR_SAVE_FLAGS;
+
+		if ((lsr & BOTH_EMPTY) == BOTH_EMPTY)
+			result = TIOCSER_TEMT;
+	}
 	spin_unlock_irqrestore(&port->lock, flags);
 
 	serial8250_rpm_put(up);
 
-	return (lsr & BOTH_EMPTY) == BOTH_EMPTY ? TIOCSER_TEMT : 0;
+	return result;
 }
 
 unsigned int serial8250_do_get_mctrl(struct uart_port *port)
diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 6ea1d23623e5..dbfec943071d 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -994,7 +994,7 @@ static inline int lpuart_start_rx_dma(struct lpuart_port *sport)
 	 * 10ms at any baud rate.
 	 */
 	sport->rx_dma_rng_buf_len = (DMA_RX_TIMEOUT * baud /  bits / 1000) * 2;
-	sport->rx_dma_rng_buf_len = (1 << (fls(sport->rx_dma_rng_buf_len) - 1));
+	sport->rx_dma_rng_buf_len = (1 << fls(sport->rx_dma_rng_buf_len));
 	if (sport->rx_dma_rng_buf_len < 16)
 		sport->rx_dma_rng_buf_len = 16;
 
diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index d3e6b6615553..72091b1f5626 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -875,13 +875,13 @@ static ssize_t tty_read(struct file *file, char __user *buf, size_t count,
 	return i;
 }
 
-static void tty_write_unlock(struct tty_struct *tty)
+void tty_write_unlock(struct tty_struct *tty)
 {
 	mutex_unlock(&tty->atomic_write_lock);
 	wake_up_interruptible_poll(&tty->write_wait, EPOLLOUT);
 }
 
-static int tty_write_lock(struct tty_struct *tty, int ndelay)
+int tty_write_lock(struct tty_struct *tty, int ndelay)
 {
 	if (!mutex_trylock(&tty->atomic_write_lock)) {
 		if (ndelay)
diff --git a/drivers/tty/tty_ioctl.c b/drivers/tty/tty_ioctl.c
index d99fec44036c..095c8780e210 100644
--- a/drivers/tty/tty_ioctl.c
+++ b/drivers/tty/tty_ioctl.c
@@ -397,21 +397,42 @@ static int set_termios(struct tty_struct *tty, void __user *arg, int opt)
 	tmp_termios.c_ispeed = tty_termios_input_baud_rate(&tmp_termios);
 	tmp_termios.c_ospeed = tty_termios_baud_rate(&tmp_termios);
 
-	ld = tty_ldisc_ref(tty);
+	if (opt & (TERMIOS_FLUSH|TERMIOS_WAIT)) {
+retry_write_wait:
+		retval = wait_event_interruptible(tty->write_wait, !tty_chars_in_buffer(tty));
+		if (retval < 0)
+			return retval;
 
-	if (ld != NULL) {
-		if ((opt & TERMIOS_FLUSH) && ld->ops->flush_buffer)
-			ld->ops->flush_buffer(tty);
-		tty_ldisc_deref(ld);
-	}
+		if (tty_write_lock(tty, 0) < 0)
+			goto retry_write_wait;
 
-	if (opt & TERMIOS_WAIT) {
-		tty_wait_until_sent(tty, 0);
-		if (signal_pending(current))
-			return -ERESTARTSYS;
-	}
+		/* Racing writer? */
+		if (tty_chars_in_buffer(tty)) {
+			tty_write_unlock(tty);
+			goto retry_write_wait;
+		}
+
+		ld = tty_ldisc_ref(tty);
+		if (ld != NULL) {
+			if ((opt & TERMIOS_FLUSH) && ld->ops->flush_buffer)
+				ld->ops->flush_buffer(tty);
+			tty_ldisc_deref(ld);
+		}
+
+		if ((opt & TERMIOS_WAIT) && tty->ops->wait_until_sent) {
+			tty->ops->wait_until_sent(tty, 0);
+			if (signal_pending(current)) {
+				tty_write_unlock(tty);
+				return -ERESTARTSYS;
+			}
+		}
+
+		tty_set_termios(tty, &tmp_termios);
 
-	tty_set_termios(tty, &tmp_termios);
+		tty_write_unlock(tty);
+	} else {
+		tty_set_termios(tty, &tmp_termios);
+	}
 
 	/* FIXME: Arguably if tmp_termios == tty->termios AND the
 	   actual requested termios was not tmp_termios then we may
diff --git a/drivers/usb/chipidea/core.c b/drivers/usb/chipidea/core.c
index 3fd1073a345d..9f6a52ed038e 100644
--- a/drivers/usb/chipidea/core.c
+++ b/drivers/usb/chipidea/core.c
@@ -984,7 +984,7 @@ static int ci_hdrc_probe(struct platform_device *pdev)
 	ret = ci_usb_phy_init(ci);
 	if (ret) {
 		dev_err(dev, "unable to init phy: %d\n", ret);
-		return ret;
+		goto ulpi_exit;
 	}
 
 	ci->hw_bank.phys = res->start;
diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 65caee589e67..81a5ca15b9c7 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -1563,6 +1563,7 @@ static int dwc3_remove(struct platform_device *pdev)
 	dwc3_core_exit(dwc);
 	dwc3_ulpi_exit(dwc);
 
+	pm_runtime_allow(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 	pm_runtime_put_noidle(&pdev->dev);
 	pm_runtime_set_suspended(&pdev->dev);
diff --git a/drivers/usb/gadget/udc/renesas_usb3.c b/drivers/usb/gadget/udc/renesas_usb3.c
index c17d7a71e29a..013db752d55d 100644
--- a/drivers/usb/gadget/udc/renesas_usb3.c
+++ b/drivers/usb/gadget/udc/renesas_usb3.c
@@ -2478,6 +2478,7 @@ static int renesas_usb3_remove(struct platform_device *pdev)
 	debugfs_remove_recursive(usb3->dentry);
 	device_remove_file(&pdev->dev, &dev_attr_role);
 
+	cancel_work_sync(&usb3->role_work);
 	usb_role_switch_unregister(usb3->role_sw);
 
 	usb_del_gadget_udc(&usb3->gadget);
diff --git a/drivers/usb/host/xhci-debugfs.c b/drivers/usb/host/xhci-debugfs.c
index 448d7b11dec4..608104cdcf33 100644
--- a/drivers/usb/host/xhci-debugfs.c
+++ b/drivers/usb/host/xhci-debugfs.c
@@ -132,6 +132,7 @@ static void xhci_debugfs_regset(struct xhci_hcd *xhci, u32 base,
 	regset->regs = regs;
 	regset->nregs = nregs;
 	regset->base = hcd->regs + base;
+	regset->dev = hcd->self.controller;
 
 	debugfs_create_regset32((const char *)rgs->name, 0444, parent, regset);
 }
diff --git a/drivers/usb/host/xhci-rcar.c b/drivers/usb/host/xhci-rcar.c
index 4ebbe2c23292..4353c1948e5c 100644
--- a/drivers/usb/host/xhci-rcar.c
+++ b/drivers/usb/host/xhci-rcar.c
@@ -74,7 +74,6 @@ MODULE_FIRMWARE(XHCI_RCAR_FIRMWARE_NAME_V3);
 
 /* For soc_device_attribute */
 #define RCAR_XHCI_FIRMWARE_V2   BIT(0) /* FIRMWARE V2 */
-#define RCAR_XHCI_FIRMWARE_V3   BIT(1) /* FIRMWARE V3 */
 
 static const struct soc_device_attribute rcar_quirks_match[]  = {
 	{
@@ -156,8 +155,6 @@ static int xhci_rcar_download_firmware(struct usb_hcd *hcd)
 
 	if (quirks & RCAR_XHCI_FIRMWARE_V2)
 		firmware_name = XHCI_RCAR_FIRMWARE_NAME_V2;
-	else if (quirks & RCAR_XHCI_FIRMWARE_V3)
-		firmware_name = XHCI_RCAR_FIRMWARE_NAME_V3;
 	else
 		firmware_name = priv->firmware_name;
 
diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
index 8dd94ce7245e..06c5f46ff0f9 100644
--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -595,6 +595,11 @@ static void option_instat_callback(struct urb *urb);
 #define SIERRA_VENDOR_ID			0x1199
 #define SIERRA_PRODUCT_EM9191			0x90d3
 
+/* UNISOC (Spreadtrum) products */
+#define UNISOC_VENDOR_ID			0x1782
+/* TOZED LT70-C based on UNISOC SL8563 uses UNISOC's vendor ID */
+#define TOZED_PRODUCT_LT70C			0x4055
+
 /* Device flags */
 
 /* Highest interface number which can be used with NCTRL() and RSVD() */
@@ -2225,6 +2230,7 @@ static const struct usb_device_id option_ids[] = {
 	{ USB_DEVICE_AND_INTERFACE_INFO(OPPO_VENDOR_ID, OPPO_PRODUCT_R11, 0xff, 0xff, 0x30) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(SIERRA_VENDOR_ID, SIERRA_PRODUCT_EM9191, 0xff, 0xff, 0x30) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(SIERRA_VENDOR_ID, SIERRA_PRODUCT_EM9191, 0xff, 0, 0) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(UNISOC_VENDOR_ID, TOZED_PRODUCT_LT70C, 0xff, 0, 0) },
 	{ } /* Terminating entry */
 };
 MODULE_DEVICE_TABLE(usb, option_ids);
diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 00dc1b5c8737..34d56f0fa750 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -5151,10 +5151,12 @@ int btrfs_del_items(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 int btrfs_prev_leaf(struct btrfs_root *root, struct btrfs_path *path)
 {
 	struct btrfs_key key;
+	struct btrfs_key orig_key;
 	struct btrfs_disk_key found_key;
 	int ret;
 
 	btrfs_item_key_to_cpu(path->nodes[0], &key, 0);
+	orig_key = key;
 
 	if (key.offset > 0) {
 		key.offset--;
@@ -5171,8 +5173,36 @@ int btrfs_prev_leaf(struct btrfs_root *root, struct btrfs_path *path)
 
 	btrfs_release_path(path);
 	ret = btrfs_search_slot(NULL, root, &key, path, 0, 0);
-	if (ret < 0)
+	if (ret <= 0)
 		return ret;
+
+	/*
+	 * Previous key not found. Even if we were at slot 0 of the leaf we had
+	 * before releasing the path and calling btrfs_search_slot(), we now may
+	 * be in a slot pointing to the same original key - this can happen if
+	 * after we released the path, one of more items were moved from a
+	 * sibling leaf into the front of the leaf we had due to an insertion
+	 * (see push_leaf_right()).
+	 * If we hit this case and our slot is > 0 and just decrement the slot
+	 * so that the caller does not process the same key again, which may or
+	 * may not break the caller, depending on its logic.
+	 */
+	if (path->slots[0] < btrfs_header_nritems(path->nodes[0])) {
+		btrfs_item_key(path->nodes[0], &found_key, path->slots[0]);
+		ret = comp_keys(&found_key, &orig_key);
+		if (ret == 0) {
+			if (path->slots[0] > 0) {
+				path->slots[0]--;
+				return 0;
+			}
+			/*
+			 * At slot 0, same key as before, it means orig_key is
+			 * the lowest, leftmost, key in the tree. We're done.
+			 */
+			return 1;
+		}
+	}
+
 	btrfs_item_key(path->nodes[0], &found_key, 0);
 	ret = comp_keys(&found_key, &key);
 	/*
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 4f2513388567..f009d585e72f 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -4722,6 +4722,11 @@ static long btrfs_ioctl_scrub(struct file *file, void __user *arg)
 	if (IS_ERR(sa))
 		return PTR_ERR(sa);
 
+	if (sa->flags & ~BTRFS_SCRUB_SUPPORTED_FLAGS) {
+		ret = -EOPNOTSUPP;
+		goto out;
+	}
+
 	if (!(sa->flags & BTRFS_SCRUB_READONLY)) {
 		ret = mnt_want_write_file(file);
 		if (ret)
diff --git a/fs/btrfs/print-tree.c b/fs/btrfs/print-tree.c
index 4b217e9a581c..e3de0c4ecbfc 100644
--- a/fs/btrfs/print-tree.c
+++ b/fs/btrfs/print-tree.c
@@ -109,10 +109,10 @@ static void print_extent_item(struct extent_buffer *eb, int slot, int type)
 			pr_cont("shared data backref parent %llu count %u\n",
 			       offset, btrfs_shared_data_ref_count(eb, sref));
 			/*
-			 * offset is supposed to be a tree block which
-			 * must be aligned to nodesize.
+			 * Offset is supposed to be a tree block which must be
+			 * aligned to sectorsize.
 			 */
-			if (!IS_ALIGNED(offset, eb->fs_info->nodesize))
+			if (!IS_ALIGNED(offset, eb->fs_info->sectorsize))
 				pr_info(
 			"\t\t\t(parent %llu not aligned to sectorsize %u)\n",
 				     offset, eb->fs_info->sectorsize);
diff --git a/fs/cifs/smb2ops.c b/fs/cifs/smb2ops.c
index 118bcb351af9..c07dcb2af2eb 100644
--- a/fs/cifs/smb2ops.c
+++ b/fs/cifs/smb2ops.c
@@ -1180,7 +1180,7 @@ smb2_copychunk_range(const unsigned int xid,
 		pcchunk->SourceOffset = cpu_to_le64(src_off);
 		pcchunk->TargetOffset = cpu_to_le64(dest_off);
 		pcchunk->Length =
-			cpu_to_le32(min_t(u32, len, tcon->max_bytes_chunk));
+			cpu_to_le32(min_t(u64, len, tcon->max_bytes_chunk));
 
 		/* Request server copy to target from src identified by key */
 		kfree(retbuf);
diff --git a/fs/debugfs/file.c b/fs/debugfs/file.c
index a57d080d2ba5..acdc802bfe9a 100644
--- a/fs/debugfs/file.c
+++ b/fs/debugfs/file.c
@@ -18,6 +18,7 @@
 #include <linux/slab.h>
 #include <linux/atomic.h>
 #include <linux/device.h>
+#include <linux/pm_runtime.h>
 #include <linux/poll.h>
 
 #include "internal.h"
@@ -1084,7 +1085,14 @@ static int debugfs_show_regset32(struct seq_file *s, void *data)
 {
 	struct debugfs_regset32 *regset = s->private;
 
+	if (regset->dev)
+		pm_runtime_get_sync(regset->dev);
+
 	debugfs_print_regs32(s, regset->regs, regset->nregs, regset->base, "");
+
+	if (regset->dev)
+		pm_runtime_put(regset->dev);
+
 	return 0;
 }
 
diff --git a/fs/ext4/balloc.c b/fs/ext4/balloc.c
index f9645de9d04c..9761aeb4b224 100644
--- a/fs/ext4/balloc.c
+++ b/fs/ext4/balloc.c
@@ -303,6 +303,22 @@ struct ext4_group_desc * ext4_get_group_desc(struct super_block *sb,
 	return desc;
 }
 
+static ext4_fsblk_t ext4_valid_block_bitmap_padding(struct super_block *sb,
+						    ext4_group_t block_group,
+						    struct buffer_head *bh)
+{
+	ext4_grpblk_t next_zero_bit;
+	unsigned long bitmap_size = sb->s_blocksize * 8;
+	unsigned int offset = num_clusters_in_group(sb, block_group);
+
+	if (bitmap_size <= offset)
+		return 0;
+
+	next_zero_bit = ext4_find_next_zero_bit(bh->b_data, bitmap_size, offset);
+
+	return (next_zero_bit < bitmap_size ? next_zero_bit : 0);
+}
+
 /*
  * Return the block number which was discovered to be invalid, or 0 if
  * the block bitmap is valid.
@@ -395,6 +411,15 @@ static int ext4_validate_block_bitmap(struct super_block *sb,
 					EXT4_GROUP_INFO_BBITMAP_CORRUPT);
 		return -EFSCORRUPTED;
 	}
+	blk = ext4_valid_block_bitmap_padding(sb, block_group, bh);
+	if (unlikely(blk != 0)) {
+		ext4_unlock_group(sb, block_group);
+		ext4_error(sb, "bg %u: block %llu: padding at end of block bitmap is not set",
+			   block_group, blk);
+		ext4_mark_group_bitmap_corrupted(sb, block_group,
+						 EXT4_GROUP_INFO_BBITMAP_CORRUPT);
+		return -EFSCORRUPTED;
+	}
 	set_buffer_verified(bh);
 verified:
 	ext4_unlock_group(sb, block_group);
diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
index 72387e142e28..71bb3cfc5933 100644
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -32,6 +32,7 @@ static int get_max_inline_xattr_value_size(struct inode *inode,
 	struct ext4_xattr_ibody_header *header;
 	struct ext4_xattr_entry *entry;
 	struct ext4_inode *raw_inode;
+	void *end;
 	int free, min_offs;
 
 	if (!EXT4_INODE_HAS_XATTR_SPACE(inode))
@@ -55,14 +56,23 @@ static int get_max_inline_xattr_value_size(struct inode *inode,
 	raw_inode = ext4_raw_inode(iloc);
 	header = IHDR(inode, raw_inode);
 	entry = IFIRST(header);
+	end = (void *)raw_inode + EXT4_SB(inode->i_sb)->s_inode_size;
 
 	/* Compute min_offs. */
-	for (; !IS_LAST_ENTRY(entry); entry = EXT4_XATTR_NEXT(entry)) {
+	while (!IS_LAST_ENTRY(entry)) {
+		void *next = EXT4_XATTR_NEXT(entry);
+
+		if (next >= end) {
+			EXT4_ERROR_INODE(inode,
+					 "corrupt xattr in inline inode");
+			return 0;
+		}
 		if (!entry->e_value_inum && entry->e_value_size) {
 			size_t offs = le16_to_cpu(entry->e_value_offs);
 			if (offs < min_offs)
 				min_offs = offs;
 		}
+		entry = next;
 	}
 	free = min_offs -
 		((void *)entry - (void *)IFIRST(header)) - sizeof(__u32);
@@ -348,7 +358,7 @@ static int ext4_update_inline_data(handle_t *handle, struct inode *inode,
 
 	error = ext4_xattr_ibody_get(inode, i.name_index, i.name,
 				     value, len);
-	if (error == -ENODATA)
+	if (error < 0)
 		goto out;
 
 	BUFFER_TRACE(is.iloc.bh, "get_write_access");
diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 4ea4fe92eb8c..70e1121d0a30 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -3893,7 +3893,11 @@ ext4_mb_release_group_pa(struct ext4_buddy *e4b,
 	trace_ext4_mb_release_group_pa(sb, pa);
 	BUG_ON(pa->pa_deleted == 0);
 	ext4_get_group_no_and_offset(sb, pa->pa_pstart, &group, &bit);
-	BUG_ON(group != e4b->bd_group && pa->pa_len != 0);
+	if (unlikely(group != e4b->bd_group && pa->pa_len != 0)) {
+		ext4_warning(sb, "bad group: expected %u, group %u, pa_start %llu",
+			     e4b->bd_group, group, pa->pa_pstart);
+		return 0;
+	}
 	mb_free_blocks(pa->pa_inode, e4b, bit, pa->pa_len);
 	atomic_add(pa->pa_len, &EXT4_SB(sb)->s_mb_discarded);
 	trace_ext4_mballoc_discard(sb, NULL, group, bit, pa->pa_len);
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index e54a5be15636..ce5abd25eb99 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -2423,11 +2423,9 @@ static __le16 ext4_group_desc_csum(struct super_block *sb, __u32 block_group,
 	crc = crc16(crc, (__u8 *)gdp, offset);
 	offset += sizeof(gdp->bg_checksum); /* skip checksum */
 	/* for checksum of struct ext4_group_desc do the rest...*/
-	if (ext4_has_feature_64bit(sb) &&
-	    offset < le16_to_cpu(sbi->s_es->s_desc_size))
+	if (ext4_has_feature_64bit(sb) && offset < sbi->s_desc_size)
 		crc = crc16(crc, (__u8 *)gdp + offset,
-			    le16_to_cpu(sbi->s_es->s_desc_size) -
-				offset);
+			    sbi->s_desc_size - offset);
 
 out:
 	return cpu_to_le16(crc);
@@ -5503,9 +5501,6 @@ static int ext4_remount(struct super_block *sb, int *flags, char *data)
 	}
 
 #ifdef CONFIG_QUOTA
-	/* Release old quota file names */
-	for (i = 0; i < EXT4_MAXQUOTAS; i++)
-		kfree(old_opts.s_qf_names[i]);
 	if (enable_quota) {
 		if (sb_any_quota_suspended(sb))
 			dquot_resume(sb, -1);
@@ -5515,6 +5510,9 @@ static int ext4_remount(struct super_block *sb, int *flags, char *data)
 				goto restore_opts;
 		}
 	}
+	/* Release old quota file names */
+	for (i = 0; i < EXT4_MAXQUOTAS; i++)
+		kfree(old_opts.s_qf_names[i]);
 #endif
 	if (!test_opt(sb, BLOCK_VALIDITY) && sbi->system_blks)
 		ext4_release_system_zone(sb);
@@ -5531,6 +5529,13 @@ static int ext4_remount(struct super_block *sb, int *flags, char *data)
 	return 0;
 
 restore_opts:
+	/*
+	 * If there was a failing r/w to ro transition, we may need to
+	 * re-enable quota
+	 */
+	if ((sb->s_flags & SB_RDONLY) && !(old_sb_flags & SB_RDONLY) &&
+	    sb_any_quota_suspended(sb))
+		dquot_resume(sb, -1);
 	sb->s_flags = old_sb_flags;
 	sbi->s_mount_opt = old_opts.s_mount_opt;
 	sbi->s_mount_opt2 = old_opts.s_mount_opt2;
diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index 1b73a7f8189d..700822c9851a 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -2573,6 +2573,7 @@ static int ext4_xattr_move_to_block(handle_t *handle, struct inode *inode,
 		.in_inode = !!entry->e_value_inum,
 	};
 	struct ext4_xattr_ibody_header *header = IHDR(inode, raw_inode);
+	int needs_kvfree = 0;
 	int error;
 
 	is = kzalloc(sizeof(struct ext4_xattr_ibody_find), GFP_NOFS);
@@ -2595,7 +2596,7 @@ static int ext4_xattr_move_to_block(handle_t *handle, struct inode *inode,
 			error = -ENOMEM;
 			goto out;
 		}
-
+		needs_kvfree = 1;
 		error = ext4_xattr_inode_get(inode, entry, buffer, value_size);
 		if (error)
 			goto out;
@@ -2634,7 +2635,7 @@ static int ext4_xattr_move_to_block(handle_t *handle, struct inode *inode,
 
 out:
 	kfree(b_entry_name);
-	if (entry->e_value_inum && buffer)
+	if (needs_kvfree && buffer)
 		kvfree(buffer);
 	if (is)
 		brelse(is->iloc.bh);
diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 4d687e2e2373..61dc0dc139f8 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -702,7 +702,7 @@ void wbc_detach_inode(struct writeback_control *wbc)
 		 * is okay.  The main goal is avoiding keeping an inode on
 		 * the wrong wb for an extended period of time.
 		 */
-		if (hweight32(history) > WB_FRN_HIST_THR_SLOTS)
+		if (hweight16(history) > WB_FRN_HIST_THR_SLOTS)
 			inode_switch_wbs(inode, max_id);
 	}
 
diff --git a/fs/nfs/nfs4state.c b/fs/nfs/nfs4state.c
index e5b4c6987c84..f0f0fb7499e3 100644
--- a/fs/nfs/nfs4state.c
+++ b/fs/nfs/nfs4state.c
@@ -66,6 +66,8 @@
 
 #define OPENOWNER_POOL_SIZE	8
 
+static void nfs4_state_start_reclaim_reboot(struct nfs_client *clp);
+
 const nfs4_stateid zero_stateid = {
 	{ .data = { 0 } },
 	.type = NFS4_SPECIAL_STATEID_TYPE,
@@ -338,6 +340,8 @@ int nfs41_init_clientid(struct nfs_client *clp, struct rpc_cred *cred)
 	status = nfs4_proc_create_session(clp, cred);
 	if (status != 0)
 		goto out;
+	if (!(clp->cl_exchange_flags & EXCHGID4_FLAG_CONFIRMED_R))
+		nfs4_state_start_reclaim_reboot(clp);
 	nfs41_finish_session_reset(clp);
 	nfs_mark_client_ready(clp, NFS_CS_READY);
 out:
diff --git a/fs/nilfs2/bmap.c b/fs/nilfs2/bmap.c
index fb5a9a8a13cf..2ba57e4b4f0a 100644
--- a/fs/nilfs2/bmap.c
+++ b/fs/nilfs2/bmap.c
@@ -67,20 +67,28 @@ int nilfs_bmap_lookup_at_level(struct nilfs_bmap *bmap, __u64 key, int level,
 
 	down_read(&bmap->b_sem);
 	ret = bmap->b_ops->bop_lookup(bmap, key, level, ptrp);
-	if (ret < 0) {
-		ret = nilfs_bmap_convert_error(bmap, __func__, ret);
+	if (ret < 0)
 		goto out;
-	}
+
 	if (NILFS_BMAP_USE_VBN(bmap)) {
 		ret = nilfs_dat_translate(nilfs_bmap_get_dat(bmap), *ptrp,
 					  &blocknr);
 		if (!ret)
 			*ptrp = blocknr;
+		else if (ret == -ENOENT) {
+			/*
+			 * If there was no valid entry in DAT for the block
+			 * address obtained by b_ops->bop_lookup, then pass
+			 * internal code -EINVAL to nilfs_bmap_convert_error
+			 * to treat it as metadata corruption.
+			 */
+			ret = -EINVAL;
+		}
 	}
 
  out:
 	up_read(&bmap->b_sem);
-	return ret;
+	return nilfs_bmap_convert_error(bmap, __func__, ret);
 }
 
 int nilfs_bmap_lookup_contig(struct nilfs_bmap *bmap, __u64 key, __u64 *ptrp,
diff --git a/fs/nilfs2/segment.c b/fs/nilfs2/segment.c
index b23ed9a35e5e..3091d1a3edde 100644
--- a/fs/nilfs2/segment.c
+++ b/fs/nilfs2/segment.c
@@ -2039,6 +2039,9 @@ static int nilfs_segctor_do_construct(struct nilfs_sc_info *sci, int mode)
 	struct the_nilfs *nilfs = sci->sc_super->s_fs_info;
 	int err;
 
+	if (sb_rdonly(sci->sc_super))
+		return -EROFS;
+
 	nilfs_sc_cstage_set(sci, NILFS_ST_INIT);
 	sci->sc_cno = nilfs->ns_cno;
 
@@ -2724,7 +2727,7 @@ static void nilfs_segctor_write_out(struct nilfs_sc_info *sci)
 
 		flush_work(&sci->sc_iput_work);
 
-	} while (ret && retrycount-- > 0);
+	} while (ret && ret != -EROFS && retrycount-- > 0);
 }
 
 /**
diff --git a/fs/pstore/pmsg.c b/fs/pstore/pmsg.c
index ffc13ea196d2..24db02de1787 100644
--- a/fs/pstore/pmsg.c
+++ b/fs/pstore/pmsg.c
@@ -15,10 +15,9 @@
 #include <linux/device.h>
 #include <linux/fs.h>
 #include <linux/uaccess.h>
-#include <linux/rtmutex.h>
 #include "internal.h"
 
-static DEFINE_RT_MUTEX(pmsg_lock);
+static DEFINE_MUTEX(pmsg_lock);
 
 static ssize_t write_pmsg(struct file *file, const char __user *buf,
 			  size_t count, loff_t *ppos)
@@ -37,9 +36,9 @@ static ssize_t write_pmsg(struct file *file, const char __user *buf,
 	if (!access_ok(VERIFY_READ, buf, count))
 		return -EFAULT;
 
-	rt_mutex_lock(&pmsg_lock);
+	mutex_lock(&pmsg_lock);
 	ret = psinfo->write_user(&record, buf);
-	rt_mutex_unlock(&pmsg_lock);
+	mutex_unlock(&pmsg_lock);
 	return ret ? ret : count;
 }
 
diff --git a/fs/reiserfs/xattr_security.c b/fs/reiserfs/xattr_security.c
index 59d87f9f72fb..159af6c26f4b 100644
--- a/fs/reiserfs/xattr_security.c
+++ b/fs/reiserfs/xattr_security.c
@@ -81,11 +81,15 @@ int reiserfs_security_write(struct reiserfs_transaction_handle *th,
 			    struct inode *inode,
 			    struct reiserfs_security_handle *sec)
 {
+	char xattr_name[XATTR_NAME_MAX + 1] = XATTR_SECURITY_PREFIX;
 	int error;
-	if (strlen(sec->name) < sizeof(XATTR_SECURITY_PREFIX))
+
+	if (XATTR_SECURITY_PREFIX_LEN + strlen(sec->name) > XATTR_NAME_MAX)
 		return -EINVAL;
 
-	error = reiserfs_xattr_set_handle(th, inode, sec->name, sec->value,
+	strlcat(xattr_name, sec->name, sizeof(xattr_name));
+
+	error = reiserfs_xattr_set_handle(th, inode, xattr_name, sec->value,
 					  sec->length, XATTR_CREATE);
 	if (error == -ENODATA || error == -EOPNOTSUPP)
 		error = 0;
diff --git a/fs/ubifs/dir.c b/fs/ubifs/dir.c
index 3b93b14e0041..cb52aa9ea276 100644
--- a/fs/ubifs/dir.c
+++ b/fs/ubifs/dir.c
@@ -445,6 +445,7 @@ static int do_tmpfile(struct inode *dir, struct dentry *dentry,
 	mutex_unlock(&dir_ui->ui_mutex);
 
 	ubifs_release_budget(c, &req);
+	fscrypt_free_filename(&nm);
 
 	return 0;
 
diff --git a/fs/ubifs/tnc.c b/fs/ubifs/tnc.c
index 4665c4d7d76a..08ed942b7627 100644
--- a/fs/ubifs/tnc.c
+++ b/fs/ubifs/tnc.c
@@ -56,6 +56,33 @@ enum {
 	NOT_ON_MEDIA = 3,
 };
 
+static void do_insert_old_idx(struct ubifs_info *c,
+			      struct ubifs_old_idx *old_idx)
+{
+	struct ubifs_old_idx *o;
+	struct rb_node **p, *parent = NULL;
+
+	p = &c->old_idx.rb_node;
+	while (*p) {
+		parent = *p;
+		o = rb_entry(parent, struct ubifs_old_idx, rb);
+		if (old_idx->lnum < o->lnum)
+			p = &(*p)->rb_left;
+		else if (old_idx->lnum > o->lnum)
+			p = &(*p)->rb_right;
+		else if (old_idx->offs < o->offs)
+			p = &(*p)->rb_left;
+		else if (old_idx->offs > o->offs)
+			p = &(*p)->rb_right;
+		else {
+			ubifs_err(c, "old idx added twice!");
+			kfree(old_idx);
+		}
+	}
+	rb_link_node(&old_idx->rb, parent, p);
+	rb_insert_color(&old_idx->rb, &c->old_idx);
+}
+
 /**
  * insert_old_idx - record an index node obsoleted since the last commit start.
  * @c: UBIFS file-system description object
@@ -81,35 +108,15 @@ enum {
  */
 static int insert_old_idx(struct ubifs_info *c, int lnum, int offs)
 {
-	struct ubifs_old_idx *old_idx, *o;
-	struct rb_node **p, *parent = NULL;
+	struct ubifs_old_idx *old_idx;
 
 	old_idx = kmalloc(sizeof(struct ubifs_old_idx), GFP_NOFS);
 	if (unlikely(!old_idx))
 		return -ENOMEM;
 	old_idx->lnum = lnum;
 	old_idx->offs = offs;
+	do_insert_old_idx(c, old_idx);
 
-	p = &c->old_idx.rb_node;
-	while (*p) {
-		parent = *p;
-		o = rb_entry(parent, struct ubifs_old_idx, rb);
-		if (lnum < o->lnum)
-			p = &(*p)->rb_left;
-		else if (lnum > o->lnum)
-			p = &(*p)->rb_right;
-		else if (offs < o->offs)
-			p = &(*p)->rb_left;
-		else if (offs > o->offs)
-			p = &(*p)->rb_right;
-		else {
-			ubifs_err(c, "old idx added twice!");
-			kfree(old_idx);
-			return 0;
-		}
-	}
-	rb_link_node(&old_idx->rb, parent, p);
-	rb_insert_color(&old_idx->rb, &c->old_idx);
 	return 0;
 }
 
@@ -211,23 +218,6 @@ static struct ubifs_znode *copy_znode(struct ubifs_info *c,
 	__set_bit(DIRTY_ZNODE, &zn->flags);
 	__clear_bit(COW_ZNODE, &zn->flags);
 
-	ubifs_assert(c, !ubifs_zn_obsolete(znode));
-	__set_bit(OBSOLETE_ZNODE, &znode->flags);
-
-	if (znode->level != 0) {
-		int i;
-		const int n = zn->child_cnt;
-
-		/* The children now have new parent */
-		for (i = 0; i < n; i++) {
-			struct ubifs_zbranch *zbr = &zn->zbranch[i];
-
-			if (zbr->znode)
-				zbr->znode->parent = zn;
-		}
-	}
-
-	atomic_long_inc(&c->dirty_zn_cnt);
 	return zn;
 }
 
@@ -245,6 +235,42 @@ static int add_idx_dirt(struct ubifs_info *c, int lnum, int dirt)
 	return ubifs_add_dirt(c, lnum, dirt);
 }
 
+/**
+ * replace_znode - replace old znode with new znode.
+ * @c: UBIFS file-system description object
+ * @new_zn: new znode
+ * @old_zn: old znode
+ * @zbr: the branch of parent znode
+ *
+ * Replace old znode with new znode in TNC.
+ */
+static void replace_znode(struct ubifs_info *c, struct ubifs_znode *new_zn,
+			  struct ubifs_znode *old_zn, struct ubifs_zbranch *zbr)
+{
+	ubifs_assert(c, !ubifs_zn_obsolete(old_zn));
+	__set_bit(OBSOLETE_ZNODE, &old_zn->flags);
+
+	if (old_zn->level != 0) {
+		int i;
+		const int n = new_zn->child_cnt;
+
+		/* The children now have new parent */
+		for (i = 0; i < n; i++) {
+			struct ubifs_zbranch *child = &new_zn->zbranch[i];
+
+			if (child->znode)
+				child->znode->parent = new_zn;
+		}
+	}
+
+	zbr->znode = new_zn;
+	zbr->lnum = 0;
+	zbr->offs = 0;
+	zbr->len = 0;
+
+	atomic_long_inc(&c->dirty_zn_cnt);
+}
+
 /**
  * dirty_cow_znode - ensure a znode is not being committed.
  * @c: UBIFS file-system description object
@@ -277,28 +303,32 @@ static struct ubifs_znode *dirty_cow_znode(struct ubifs_info *c,
 		return zn;
 
 	if (zbr->len) {
-		err = insert_old_idx(c, zbr->lnum, zbr->offs);
-		if (unlikely(err))
-			/*
-			 * Obsolete znodes will be freed by tnc_destroy_cnext()
-			 * or free_obsolete_znodes(), copied up znodes should
-			 * be added back to tnc and freed by
-			 * ubifs_destroy_tnc_subtree().
-			 */
+		struct ubifs_old_idx *old_idx;
+
+		old_idx = kmalloc(sizeof(struct ubifs_old_idx), GFP_NOFS);
+		if (unlikely(!old_idx)) {
+			err = -ENOMEM;
 			goto out;
+		}
+		old_idx->lnum = zbr->lnum;
+		old_idx->offs = zbr->offs;
+
 		err = add_idx_dirt(c, zbr->lnum, zbr->len);
-	} else
-		err = 0;
+		if (err) {
+			kfree(old_idx);
+			goto out;
+		}
 
-out:
-	zbr->znode = zn;
-	zbr->lnum = 0;
-	zbr->offs = 0;
-	zbr->len = 0;
+		do_insert_old_idx(c, old_idx);
+	}
+
+	replace_znode(c, zn, znode, zbr);
 
-	if (unlikely(err))
-		return ERR_PTR(err);
 	return zn;
+
+out:
+	kfree(zn);
+	return ERR_PTR(err);
 }
 
 /**
diff --git a/include/linux/debugfs.h b/include/linux/debugfs.h
index 6ebc269e48ac..0624c9a1f01e 100644
--- a/include/linux/debugfs.h
+++ b/include/linux/debugfs.h
@@ -35,6 +35,7 @@ struct debugfs_regset32 {
 	const struct debugfs_reg32 *regs;
 	int nregs;
 	void __iomem *base;
+	struct device *dev;	/* Optional device for Runtime PM */
 };
 
 extern struct dentry *arch_debugfs_dir;
diff --git a/include/linux/ipmi_smi.h b/include/linux/ipmi_smi.h
index 1995ce146789..86b119400f30 100644
--- a/include/linux/ipmi_smi.h
+++ b/include/linux/ipmi_smi.h
@@ -30,6 +30,17 @@ struct device;
 /* Structure for the low-level drivers. */
 typedef struct ipmi_smi *ipmi_smi_t;
 
+/*
+ * Flags for set_check_watch() below.  Tells if the SMI should be
+ * waiting for watchdog timeouts, commands and/or messages.  There is
+ * also an internal flag for the message handler, SMIs should ignore
+ * it.
+ */
+#define IPMI_WATCH_MASK_INTERNAL	(1 << 0)
+#define IPMI_WATCH_MASK_CHECK_MESSAGES	(1 << 1)
+#define IPMI_WATCH_MASK_CHECK_WATCHDOG	(1 << 2)
+#define IPMI_WATCH_MASK_CHECK_COMMANDS	(1 << 3)
+
 /*
  * Messages to/from the lower layer.  The smi interface will take one
  * of these to send. After the send has occurred and a response has
@@ -55,8 +66,16 @@ struct ipmi_smi_msg {
 	int           rsp_size;
 	unsigned char rsp[IPMI_MAX_MSG_LENGTH];
 
-	/* Will be called when the system is done with the message
-	   (presumably to free it). */
+	/*
+	 * There should be a response message coming back in the BMC
+	 * message queue.
+	 */
+	bool needs_response;
+
+	/*
+	 * Will be called when the system is done with the message
+	 * (presumably to free it).
+	 */
 	void (*done)(struct ipmi_smi_msg *msg);
 };
 
@@ -105,12 +124,15 @@ struct ipmi_smi_handlers {
 
 	/*
 	 * Called by the upper layer when some user requires that the
-	 * interface watch for events, received messages, watchdog
-	 * pretimeouts, or not.  Used by the SMI to know if it should
-	 * watch for these.  This may be NULL if the SMI does not
-	 * implement it.
+	 * interface watch for received messages and watchdog
+	 * pretimeouts (basically do a "Get Flags", or not.  Used by
+	 * the SMI to know if it should watch for these.  This may be
+	 * NULL if the SMI does not implement it.  watch_mask is from
+	 * IPMI_WATCH_MASK_xxx above.  The interface should run slower
+	 * timeouts for just watchdog checking or faster timeouts when
+	 * waiting for the message queue.
 	 */
-	void (*set_need_watch)(void *send_info, bool enable);
+	void (*set_need_watch)(void *send_info, unsigned int watch_mask);
 
 	/*
 	 * Called when flushing all pending messages.
diff --git a/include/linux/netfilter/nfnetlink.h b/include/linux/netfilter/nfnetlink.h
index e713476ff29d..a806803fbe37 100644
--- a/include/linux/netfilter/nfnetlink.h
+++ b/include/linux/netfilter/nfnetlink.h
@@ -32,7 +32,6 @@ struct nfnetlink_subsystem {
 	struct module *owner;
 	int (*commit)(struct net *net, struct sk_buff *skb);
 	int (*abort)(struct net *net, struct sk_buff *skb);
-	void (*cleanup)(struct net *net);
 	bool (*valid_genid)(struct net *net, u32 genid);
 };
 
diff --git a/include/linux/printk.h b/include/linux/printk.h
index 6dd867e39365..f4d7e643f010 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -525,4 +525,23 @@ static inline void print_hex_dump_debug(const char *prefix_str, int prefix_type,
 }
 #endif
 
+#ifdef CONFIG_PRINTK
+extern void __printk_safe_enter(void);
+extern void __printk_safe_exit(void);
+/*
+ * The printk_deferred_enter/exit macros are available only as a hack for
+ * some code paths that need to defer all printk console printing. Interrupts
+ * must be disabled for the deferred duration.
+ */
+#define printk_deferred_enter __printk_safe_enter
+#define printk_deferred_exit __printk_safe_exit
+#else
+static inline void printk_deferred_enter(void)
+{
+}
+static inline void printk_deferred_exit(void)
+{
+}
+#endif
+
 #endif
diff --git a/include/linux/sunrpc/sched.h b/include/linux/sunrpc/sched.h
index ad2e243f3f03..96837ae07822 100644
--- a/include/linux/sunrpc/sched.h
+++ b/include/linux/sunrpc/sched.h
@@ -88,8 +88,7 @@ struct rpc_task {
 #endif
 	unsigned char		tk_priority : 2,/* Task priority */
 				tk_garb_retry : 2,
-				tk_cred_retry : 2,
-				tk_rebind_retry : 2;
+				tk_cred_retry : 2;
 };
 
 typedef void			(*rpc_action)(struct rpc_task *);
diff --git a/include/linux/tick.h b/include/linux/tick.h
index 55388ab45fd4..443726085f6c 100644
--- a/include/linux/tick.h
+++ b/include/linux/tick.h
@@ -102,7 +102,8 @@ enum tick_dep_bits {
 	TICK_DEP_BIT_POSIX_TIMER	= 0,
 	TICK_DEP_BIT_PERF_EVENTS	= 1,
 	TICK_DEP_BIT_SCHED		= 2,
-	TICK_DEP_BIT_CLOCK_UNSTABLE	= 3
+	TICK_DEP_BIT_CLOCK_UNSTABLE	= 3,
+	TICK_DEP_BIT_RCU		= 4
 };
 
 #define TICK_DEP_MASK_NONE		0
@@ -110,6 +111,7 @@ enum tick_dep_bits {
 #define TICK_DEP_MASK_PERF_EVENTS	(1 << TICK_DEP_BIT_PERF_EVENTS)
 #define TICK_DEP_MASK_SCHED		(1 << TICK_DEP_BIT_SCHED)
 #define TICK_DEP_MASK_CLOCK_UNSTABLE	(1 << TICK_DEP_BIT_CLOCK_UNSTABLE)
+#define TICK_DEP_MASK_RCU		(1 << TICK_DEP_BIT_RCU)
 
 #ifdef CONFIG_NO_HZ_COMMON
 extern bool tick_nohz_enabled;
@@ -195,6 +197,7 @@ extern void tick_nohz_dep_set_signal(struct signal_struct *signal,
 				     enum tick_dep_bits bit);
 extern void tick_nohz_dep_clear_signal(struct signal_struct *signal,
 				       enum tick_dep_bits bit);
+extern bool tick_nohz_cpu_hotpluggable(unsigned int cpu);
 
 /*
  * The below are tick_nohz_[set,clear]_dep() wrappers that optimize off-cases
@@ -257,6 +260,10 @@ static inline bool tick_nohz_full_enabled(void) { return false; }
 static inline bool tick_nohz_full_cpu(int cpu) { return false; }
 static inline void tick_nohz_full_add_cpus_to(struct cpumask *mask) { }
 
+static inline void tick_nohz_dep_set_cpu(int cpu, enum tick_dep_bits bit) { }
+static inline void tick_nohz_dep_clear_cpu(int cpu, enum tick_dep_bits bit) { }
+static inline bool tick_nohz_cpu_hotpluggable(unsigned int cpu) { return true; }
+
 static inline void tick_dep_set(enum tick_dep_bits bit) { }
 static inline void tick_dep_clear(enum tick_dep_bits bit) { }
 static inline void tick_dep_set_cpu(int cpu, enum tick_dep_bits bit) { }
diff --git a/include/linux/tty.h b/include/linux/tty.h
index d808ab9c9aff..487ce56b88e8 100644
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -480,6 +480,8 @@ extern void __stop_tty(struct tty_struct *tty);
 extern void stop_tty(struct tty_struct *tty);
 extern void __start_tty(struct tty_struct *tty);
 extern void start_tty(struct tty_struct *tty);
+void tty_write_unlock(struct tty_struct *tty);
+int tty_write_lock(struct tty_struct *tty, int ndelay);
 extern int tty_register_driver(struct tty_driver *driver);
 extern int tty_unregister_driver(struct tty_driver *driver);
 extern struct device *tty_register_device(struct tty_driver *driver,
diff --git a/include/linux/vt_buffer.h b/include/linux/vt_buffer.h
index 848db1b1569f..919d999a8c1d 100644
--- a/include/linux/vt_buffer.h
+++ b/include/linux/vt_buffer.h
@@ -16,7 +16,7 @@
 
 #include <linux/string.h>
 
-#if defined(CONFIG_VGA_CONSOLE) || defined(CONFIG_MDA_CONSOLE)
+#if IS_ENABLED(CONFIG_VGA_CONSOLE) || IS_ENABLED(CONFIG_MDA_CONSOLE)
 #include <asm/vga.h>
 #endif
 
diff --git a/include/net/netfilter/nf_tables.h b/include/net/netfilter/nf_tables.h
index 93253ba1eeac..78f5f0426e6b 100644
--- a/include/net/netfilter/nf_tables.h
+++ b/include/net/netfilter/nf_tables.h
@@ -471,6 +471,7 @@ struct nft_set_binding {
 };
 
 enum nft_trans_phase;
+void nf_tables_activate_set(const struct nft_ctx *ctx, struct nft_set *set);
 void nf_tables_deactivate_set(const struct nft_ctx *ctx, struct nft_set *set,
 			      struct nft_set_binding *binding,
 			      enum nft_trans_phase phase);
diff --git a/include/net/scm.h b/include/net/scm.h
index 1ce365f4c256..585adc1346bd 100644
--- a/include/net/scm.h
+++ b/include/net/scm.h
@@ -105,16 +105,27 @@ static inline void scm_passec(struct socket *sock, struct msghdr *msg, struct sc
 		}
 	}
 }
+
+static inline bool scm_has_secdata(struct socket *sock)
+{
+	return test_bit(SOCK_PASSSEC, &sock->flags);
+}
 #else
 static inline void scm_passec(struct socket *sock, struct msghdr *msg, struct scm_cookie *scm)
 { }
+
+static inline bool scm_has_secdata(struct socket *sock)
+{
+	return false;
+}
 #endif /* CONFIG_SECURITY_NETWORK */
 
 static __inline__ void scm_recv(struct socket *sock, struct msghdr *msg,
 				struct scm_cookie *scm, int flags)
 {
 	if (!msg->msg_control) {
-		if (test_bit(SOCK_PASSCRED, &sock->flags) || scm->fp)
+		if (test_bit(SOCK_PASSCRED, &sock->flags) || scm->fp ||
+		    scm_has_secdata(sock))
 			msg->msg_flags |= MSG_CTRUNC;
 		scm_destroy(scm);
 		return;
diff --git a/include/trace/events/timer.h b/include/trace/events/timer.h
index a57e4ee989d6..350b046e7576 100644
--- a/include/trace/events/timer.h
+++ b/include/trace/events/timer.h
@@ -362,7 +362,8 @@ TRACE_EVENT(itimer_expire,
 		tick_dep_name(POSIX_TIMER)		\
 		tick_dep_name(PERF_EVENTS)		\
 		tick_dep_name(SCHED)			\
-		tick_dep_name_end(CLOCK_UNSTABLE)
+		tick_dep_name(CLOCK_UNSTABLE)		\
+		tick_dep_name_end(RCU)
 
 #undef tick_dep_name
 #undef tick_dep_mask_name
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 1ceec56de015..b72aeb766fc7 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -272,13 +272,14 @@ union drm_amdgpu_vm {
 
 /* sched ioctl */
 #define AMDGPU_SCHED_OP_PROCESS_PRIORITY_OVERRIDE	1
+#define AMDGPU_SCHED_OP_CONTEXT_PRIORITY_OVERRIDE	2
 
 struct drm_amdgpu_sched_in {
 	/* AMDGPU_SCHED_OP_* */
 	__u32	op;
 	__u32	fd;
 	__s32	priority;
-	__u32	flags;
+	__u32   ctx_id;
 };
 
 union drm_amdgpu_sched {
diff --git a/include/uapi/linux/btrfs.h b/include/uapi/linux/btrfs.h
index 5ca1d21fc4a7..dd7a7b3e53f4 100644
--- a/include/uapi/linux/btrfs.h
+++ b/include/uapi/linux/btrfs.h
@@ -162,6 +162,7 @@ struct btrfs_scrub_progress {
 };
 
 #define BTRFS_SCRUB_READONLY	1
+#define BTRFS_SCRUB_SUPPORTED_FLAGS	(BTRFS_SCRUB_READONLY)
 struct btrfs_ioctl_scrub_args {
 	__u64 devid;				/* in */
 	__u64 start;				/* in */
diff --git a/include/uapi/linux/const.h b/include/uapi/linux/const.h
index af2a44c08683..a429381e7ca5 100644
--- a/include/uapi/linux/const.h
+++ b/include/uapi/linux/const.h
@@ -28,7 +28,7 @@
 #define _BITUL(x)	(_UL(1) << (x))
 #define _BITULL(x)	(_ULL(1) << (x))
 
-#define __ALIGN_KERNEL(x, a)		__ALIGN_KERNEL_MASK(x, (typeof(x))(a) - 1)
+#define __ALIGN_KERNEL(x, a)		__ALIGN_KERNEL_MASK(x, (__typeof__(x))(a) - 1)
 #define __ALIGN_KERNEL_MASK(x, mask)	(((x) + (mask)) & ~(mask))
 
 #define __KERNEL_DIV_ROUND_UP(n, d) (((n) + (d) - 1) / (d))
diff --git a/include/uapi/linux/media-bus-format.h b/include/uapi/linux/media-bus-format.h
index d6a5a3bfe6c4..be53a8c1a2df 100644
--- a/include/uapi/linux/media-bus-format.h
+++ b/include/uapi/linux/media-bus-format.h
@@ -153,4 +153,12 @@
 /* HSV - next is	0x6002 */
 #define MEDIA_BUS_FMT_AHSV8888_1X32		0x6001
 
+/*
+ * This format should be used when the same driver handles
+ * both sides of the link and the bus format is a fixed
+ * metadata format that is not configurable from userspace.
+ * Width and height will be set to 0 for this format.
+ */
+#define MEDIA_BUS_FMT_METADATA_FIXED		0x7001
+
 #endif /* __LINUX_MEDIA_BUS_FORMAT_H */
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 72ed3f3d078f..2bf4b6b109bf 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7843,8 +7843,8 @@ __perf_event_account_interrupt(struct perf_event *event, int throttle)
 		hwc->interrupts = 1;
 	} else {
 		hwc->interrupts++;
-		if (unlikely(throttle
-			     && hwc->interrupts >= max_samples_per_tick)) {
+		if (unlikely(throttle &&
+			     hwc->interrupts > max_samples_per_tick)) {
 			__this_cpu_inc(perf_throttled_count);
 			tick_dep_set_cpu(smp_processor_id(), TICK_DEP_BIT_PERF_EVENTS);
 			hwc->interrupts = MAX_INTERRUPTS;
diff --git a/kernel/relay.c b/kernel/relay.c
index b7aa7df43955..e6f70f4c41a3 100644
--- a/kernel/relay.c
+++ b/kernel/relay.c
@@ -997,14 +997,14 @@ static void relay_file_read_consume(struct rchan_buf *buf,
 /*
  *	relay_file_read_avail - boolean, are there unconsumed bytes available?
  */
-static int relay_file_read_avail(struct rchan_buf *buf, size_t read_pos)
+static int relay_file_read_avail(struct rchan_buf *buf)
 {
 	size_t subbuf_size = buf->chan->subbuf_size;
 	size_t n_subbufs = buf->chan->n_subbufs;
 	size_t produced = buf->subbufs_produced;
 	size_t consumed = buf->subbufs_consumed;
 
-	relay_file_read_consume(buf, read_pos, 0);
+	relay_file_read_consume(buf, 0, 0);
 
 	consumed = buf->subbufs_consumed;
 
@@ -1065,23 +1065,21 @@ static size_t relay_file_read_subbuf_avail(size_t read_pos,
 
 /**
  *	relay_file_read_start_pos - find the first available byte to read
- *	@read_pos: file read position
  *	@buf: relay channel buffer
  *
- *	If the @read_pos is in the middle of padding, return the
+ *	If the read_pos is in the middle of padding, return the
  *	position of the first actually available byte, otherwise
  *	return the original value.
  */
-static size_t relay_file_read_start_pos(size_t read_pos,
-					struct rchan_buf *buf)
+static size_t relay_file_read_start_pos(struct rchan_buf *buf)
 {
 	size_t read_subbuf, padding, padding_start, padding_end;
 	size_t subbuf_size = buf->chan->subbuf_size;
 	size_t n_subbufs = buf->chan->n_subbufs;
 	size_t consumed = buf->subbufs_consumed % n_subbufs;
+	size_t read_pos = (consumed * subbuf_size + buf->bytes_consumed)
+			% (n_subbufs * subbuf_size);
 
-	if (!read_pos)
-		read_pos = consumed * subbuf_size + buf->bytes_consumed;
 	read_subbuf = read_pos / subbuf_size;
 	padding = buf->padding[read_subbuf];
 	padding_start = (read_subbuf + 1) * subbuf_size - padding;
@@ -1137,10 +1135,10 @@ static ssize_t relay_file_read(struct file *filp,
 	do {
 		void *from;
 
-		if (!relay_file_read_avail(buf, *ppos))
+		if (!relay_file_read_avail(buf))
 			break;
 
-		read_start = relay_file_read_start_pos(*ppos, buf);
+		read_start = relay_file_read_start_pos(buf);
 		avail = relay_file_read_subbuf_avail(read_start, buf);
 		if (!avail)
 			break;
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 48403fb653c2..25c6efa2c557 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -199,6 +199,11 @@ static bool check_tick_dependency(atomic_t *dep)
 		return true;
 	}
 
+	if (val & TICK_DEP_MASK_RCU) {
+		trace_tick_stop(0, TICK_DEP_MASK_RCU);
+		return true;
+	}
+
 	return false;
 }
 
@@ -325,6 +330,7 @@ void tick_nohz_dep_set_cpu(int cpu, enum tick_dep_bits bit)
 		preempt_enable();
 	}
 }
+EXPORT_SYMBOL_GPL(tick_nohz_dep_set_cpu);
 
 void tick_nohz_dep_clear_cpu(int cpu, enum tick_dep_bits bit)
 {
@@ -332,6 +338,7 @@ void tick_nohz_dep_clear_cpu(int cpu, enum tick_dep_bits bit)
 
 	atomic_andnot(BIT(bit), &ts->tick_dep_mask);
 }
+EXPORT_SYMBOL_GPL(tick_nohz_dep_clear_cpu);
 
 /*
  * Set a per-task tick dependency. Posix CPU timers need this in order to elapse
@@ -399,7 +406,7 @@ void __init tick_nohz_full_setup(cpumask_var_t cpumask)
 	tick_nohz_full_running = true;
 }
 
-static int tick_nohz_cpu_down(unsigned int cpu)
+bool tick_nohz_cpu_hotpluggable(unsigned int cpu)
 {
 	/*
 	 * The boot CPU handles housekeeping duty (unbound timers,
@@ -407,8 +414,13 @@ static int tick_nohz_cpu_down(unsigned int cpu)
 	 * CPUs. It must remain online when nohz full is enabled.
 	 */
 	if (tick_nohz_full_running && tick_do_timer_cpu == cpu)
-		return -EBUSY;
-	return 0;
+		return false;
+	return true;
+}
+
+static int tick_nohz_cpu_down(unsigned int cpu)
+{
+	return tick_nohz_cpu_hotpluggable(cpu) ? 0 : -EBUSY;
 }
 
 void __init tick_nohz_init(void)
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 37fade5101ee..ba8b72f9cdc0 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -1326,6 +1326,8 @@ static void rb_free_cpu_buffer(struct ring_buffer_per_cpu *cpu_buffer)
 	struct list_head *head = cpu_buffer->pages;
 	struct buffer_page *bpage, *tmp;
 
+	irq_work_sync(&cpu_buffer->irq_work.work);
+
 	free_buffer_page(cpu_buffer->reader_page);
 
 	if (head) {
@@ -1431,6 +1433,8 @@ ring_buffer_free(struct ring_buffer *buffer)
 
 	cpuhp_state_remove_instance(CPUHP_TRACE_RB_PREPARE, &buffer->node);
 
+	irq_work_sync(&buffer->irq_work.work);
+
 	for_each_buffer_cpu(buffer, cpu)
 		rb_free_cpu_buffer(buffer->buffers[cpu]);
 
diff --git a/lib/debugobjects.c b/lib/debugobjects.c
index 14afeeb7d6ef..5f23d896df55 100644
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -25,6 +25,7 @@
 
 #define ODEBUG_POOL_SIZE	1024
 #define ODEBUG_POOL_MIN_LEVEL	256
+#define ODEBUG_POOL_PERCPU_SIZE	64
 
 #define ODEBUG_CHUNK_SHIFT	PAGE_SHIFT
 #define ODEBUG_CHUNK_SIZE	(1 << ODEBUG_CHUNK_SHIFT)
@@ -35,6 +36,17 @@ struct debug_bucket {
 	raw_spinlock_t		lock;
 };
 
+/*
+ * Debug object percpu free list
+ * Access is protected by disabling irq
+ */
+struct debug_percpu_free {
+	struct hlist_head	free_objs;
+	int			obj_free;
+};
+
+static DEFINE_PER_CPU(struct debug_percpu_free, percpu_obj_pool);
+
 static struct debug_bucket	obj_hash[ODEBUG_HASH_SIZE];
 
 static struct debug_obj		obj_static_pool[ODEBUG_POOL_SIZE] __initdata;
@@ -44,13 +56,19 @@ static DEFINE_RAW_SPINLOCK(pool_lock);
 static HLIST_HEAD(obj_pool);
 static HLIST_HEAD(obj_to_free);
 
+/*
+ * Because of the presence of percpu free pools, obj_pool_free will
+ * under-count those in the percpu free pools. Similarly, obj_pool_used
+ * will over-count those in the percpu free pools. Adjustments will be
+ * made at debug_stats_show(). Both obj_pool_min_free and obj_pool_max_used
+ * can be off.
+ */
 static int			obj_pool_min_free = ODEBUG_POOL_SIZE;
 static int			obj_pool_free = ODEBUG_POOL_SIZE;
 static int			obj_pool_used;
 static int			obj_pool_max_used;
 /* The number of objs on the global free list */
 static int			obj_nr_tofree;
-static struct kmem_cache	*obj_cache;
 
 static int			debug_objects_maxchain __read_mostly;
 static int __maybe_unused	debug_objects_maxchecked __read_mostly;
@@ -63,6 +81,7 @@ static int			debug_objects_pool_size __read_mostly
 static int			debug_objects_pool_min_level __read_mostly
 				= ODEBUG_POOL_MIN_LEVEL;
 static struct debug_obj_descr	*descr_test  __read_mostly;
+static struct kmem_cache	*obj_cache __read_mostly;
 
 /*
  * Track numbers of kmem_cache_alloc()/free() calls done.
@@ -163,26 +182,38 @@ static struct debug_obj *lookup_object(void *addr, struct debug_bucket *b)
 }
 
 /*
- * Allocate a new object. If the pool is empty, switch off the debugger.
- * Must be called with interrupts disabled.
+ * Allocate a new object from the hlist
  */
-static struct debug_obj *
-alloc_object(void *addr, struct debug_bucket *b, struct debug_obj_descr *descr)
+static struct debug_obj *__alloc_object(struct hlist_head *list)
 {
 	struct debug_obj *obj = NULL;
 
-	raw_spin_lock(&pool_lock);
-	if (obj_pool.first) {
-		obj	    = hlist_entry(obj_pool.first, typeof(*obj), node);
-
-		obj->object = addr;
-		obj->descr  = descr;
-		obj->state  = ODEBUG_STATE_NONE;
-		obj->astate = 0;
+	if (list->first) {
+		obj = hlist_entry(list->first, typeof(*obj), node);
 		hlist_del(&obj->node);
+	}
 
-		hlist_add_head(&obj->node, &b->list);
+	return obj;
+}
+
+static struct debug_obj *
+alloc_object(void *addr, struct debug_bucket *b, struct debug_obj_descr *descr)
+{
+	struct debug_percpu_free *percpu_pool;
+	struct debug_obj *obj;
+
+	if (likely(obj_cache)) {
+		percpu_pool = this_cpu_ptr(&percpu_obj_pool);
+		obj = __alloc_object(&percpu_pool->free_objs);
+		if (obj) {
+			percpu_pool->obj_free--;
+			goto init_obj;
+		}
+	}
 
+	raw_spin_lock(&pool_lock);
+	obj = __alloc_object(&obj_pool);
+	if (obj) {
 		obj_pool_used++;
 		if (obj_pool_used > obj_pool_max_used)
 			obj_pool_max_used = obj_pool_used;
@@ -193,6 +224,14 @@ alloc_object(void *addr, struct debug_bucket *b, struct debug_obj_descr *descr)
 	}
 	raw_spin_unlock(&pool_lock);
 
+init_obj:
+	if (obj) {
+		obj->object = addr;
+		obj->descr  = descr;
+		obj->state  = ODEBUG_STATE_NONE;
+		obj->astate = 0;
+		hlist_add_head(&obj->node, &b->list);
+	}
 	return obj;
 }
 
@@ -247,8 +286,21 @@ static bool __free_object(struct debug_obj *obj)
 {
 	unsigned long flags;
 	bool work;
+	struct debug_percpu_free *percpu_pool;
 
-	raw_spin_lock_irqsave(&pool_lock, flags);
+	local_irq_save(flags);
+	/*
+	 * Try to free it into the percpu pool first.
+	 */
+	percpu_pool = this_cpu_ptr(&percpu_obj_pool);
+	if (obj_cache && percpu_pool->obj_free < ODEBUG_POOL_PERCPU_SIZE) {
+		hlist_add_head(&obj->node, &percpu_pool->free_objs);
+		percpu_pool->obj_free++;
+		local_irq_restore(flags);
+		return false;
+	}
+
+	raw_spin_lock(&pool_lock);
 	work = (obj_pool_free > debug_objects_pool_size) && obj_cache;
 	obj_pool_used--;
 
@@ -259,7 +311,8 @@ static bool __free_object(struct debug_obj *obj)
 		obj_pool_free++;
 		hlist_add_head(&obj->node, &obj_pool);
 	}
-	raw_spin_unlock_irqrestore(&pool_lock, flags);
+	raw_spin_unlock(&pool_lock);
+	local_irq_restore(flags);
 	return work;
 }
 
@@ -368,6 +421,55 @@ static void debug_object_is_on_stack(void *addr, int onstack)
 	WARN_ON(1);
 }
 
+static struct debug_obj *lookup_object_or_alloc(void *addr, struct debug_bucket *b,
+						struct debug_obj_descr *descr,
+						bool onstack, bool alloc_ifstatic)
+{
+	struct debug_obj *obj = lookup_object(addr, b);
+	enum debug_obj_state state = ODEBUG_STATE_NONE;
+
+	if (likely(obj))
+		return obj;
+
+	/*
+	 * debug_object_init() unconditionally allocates untracked
+	 * objects. It does not matter whether it is a static object or
+	 * not.
+	 *
+	 * debug_object_assert_init() and debug_object_activate() allow
+	 * allocation only if the descriptor callback confirms that the
+	 * object is static and considered initialized. For non-static
+	 * objects the allocation needs to be done from the fixup callback.
+	 */
+	if (unlikely(alloc_ifstatic)) {
+		if (!descr->is_static_object || !descr->is_static_object(addr))
+			return ERR_PTR(-ENOENT);
+		/* Statically allocated objects are considered initialized */
+		state = ODEBUG_STATE_INIT;
+	}
+
+	obj = alloc_object(addr, b, descr);
+	if (likely(obj)) {
+		obj->state = state;
+		debug_object_is_on_stack(addr, onstack);
+		return obj;
+	}
+
+	/* Out of memory. Do the cleanup outside of the locked region */
+	debug_objects_enabled = 0;
+	return NULL;
+}
+
+static void debug_objects_fill_pool(void)
+{
+	/*
+	 * On RT enabled kernels the pool refill must happen in preemptible
+	 * context:
+	 */
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT) || preemptible())
+		fill_pool();
+}
+
 static void
 __debug_object_init(void *addr, struct debug_obj_descr *descr, int onstack)
 {
@@ -376,22 +478,17 @@ __debug_object_init(void *addr, struct debug_obj_descr *descr, int onstack)
 	struct debug_obj *obj;
 	unsigned long flags;
 
-	fill_pool();
+	debug_objects_fill_pool();
 
 	db = get_bucket((unsigned long) addr);
 
 	raw_spin_lock_irqsave(&db->lock, flags);
 
-	obj = lookup_object(addr, db);
-	if (!obj) {
-		obj = alloc_object(addr, db, descr);
-		if (!obj) {
-			debug_objects_enabled = 0;
-			raw_spin_unlock_irqrestore(&db->lock, flags);
-			debug_objects_oom();
-			return;
-		}
-		debug_object_is_on_stack(addr, onstack);
+	obj = lookup_object_or_alloc(addr, db, descr, onstack, false);
+	if (unlikely(!obj)) {
+		raw_spin_unlock_irqrestore(&db->lock, flags);
+		debug_objects_oom();
+		return;
 	}
 
 	switch (obj->state) {
@@ -402,15 +499,16 @@ __debug_object_init(void *addr, struct debug_obj_descr *descr, int onstack)
 		break;
 
 	case ODEBUG_STATE_ACTIVE:
-		debug_print_object(obj, "init");
 		state = obj->state;
 		raw_spin_unlock_irqrestore(&db->lock, flags);
+		debug_print_object(obj, "init");
 		debug_object_fixup(descr->fixup_init, addr, state);
 		return;
 
 	case ODEBUG_STATE_DESTROYED:
+		raw_spin_unlock_irqrestore(&db->lock, flags);
 		debug_print_object(obj, "init");
-		break;
+		return;
 	default:
 		break;
 	}
@@ -455,24 +553,26 @@ EXPORT_SYMBOL_GPL(debug_object_init_on_stack);
  */
 int debug_object_activate(void *addr, struct debug_obj_descr *descr)
 {
+	struct debug_obj o = { .object = addr, .state = ODEBUG_STATE_NOTAVAILABLE, .descr = descr };
 	enum debug_obj_state state;
 	struct debug_bucket *db;
 	struct debug_obj *obj;
 	unsigned long flags;
 	int ret;
-	struct debug_obj o = { .object = addr,
-			       .state = ODEBUG_STATE_NOTAVAILABLE,
-			       .descr = descr };
 
 	if (!debug_objects_enabled)
 		return 0;
 
+	debug_objects_fill_pool();
+
 	db = get_bucket((unsigned long) addr);
 
 	raw_spin_lock_irqsave(&db->lock, flags);
 
-	obj = lookup_object(addr, db);
-	if (obj) {
+	obj = lookup_object_or_alloc(addr, db, descr, false, true);
+	if (likely(!IS_ERR_OR_NULL(obj))) {
+		bool print_object = false;
+
 		switch (obj->state) {
 		case ODEBUG_STATE_INIT:
 		case ODEBUG_STATE_INACTIVE:
@@ -481,14 +581,14 @@ int debug_object_activate(void *addr, struct debug_obj_descr *descr)
 			break;
 
 		case ODEBUG_STATE_ACTIVE:
-			debug_print_object(obj, "activate");
 			state = obj->state;
 			raw_spin_unlock_irqrestore(&db->lock, flags);
+			debug_print_object(obj, "activate");
 			ret = debug_object_fixup(descr->fixup_activate, addr, state);
 			return ret ? 0 : -EINVAL;
 
 		case ODEBUG_STATE_DESTROYED:
-			debug_print_object(obj, "activate");
+			print_object = true;
 			ret = -EINVAL;
 			break;
 		default:
@@ -496,28 +596,23 @@ int debug_object_activate(void *addr, struct debug_obj_descr *descr)
 			break;
 		}
 		raw_spin_unlock_irqrestore(&db->lock, flags);
+		if (print_object)
+			debug_print_object(obj, "activate");
 		return ret;
 	}
 
 	raw_spin_unlock_irqrestore(&db->lock, flags);
-	/*
-	 * We are here when a static object is activated. We
-	 * let the type specific code confirm whether this is
-	 * true or not. if true, we just make sure that the
-	 * static object is tracked in the object tracker. If
-	 * not, this must be a bug, so we try to fix it up.
-	 */
-	if (descr->is_static_object && descr->is_static_object(addr)) {
-		/* track this static object */
-		debug_object_init(addr, descr);
-		debug_object_activate(addr, descr);
-	} else {
-		debug_print_object(&o, "activate");
-		ret = debug_object_fixup(descr->fixup_activate, addr,
-					ODEBUG_STATE_NOTAVAILABLE);
-		return ret ? 0 : -EINVAL;
+
+	/* If NULL the allocation has hit OOM */
+	if (!obj) {
+		debug_objects_oom();
+		return 0;
 	}
-	return 0;
+
+	/* Object is neither static nor tracked. It's not initialized */
+	debug_print_object(&o, "activate");
+	ret = debug_object_fixup(descr->fixup_activate, addr, ODEBUG_STATE_NOTAVAILABLE);
+	return ret ? 0 : -EINVAL;
 }
 EXPORT_SYMBOL_GPL(debug_object_activate);
 
@@ -531,6 +626,7 @@ void debug_object_deactivate(void *addr, struct debug_obj_descr *descr)
 	struct debug_bucket *db;
 	struct debug_obj *obj;
 	unsigned long flags;
+	bool print_object = false;
 
 	if (!debug_objects_enabled)
 		return;
@@ -548,24 +644,27 @@ void debug_object_deactivate(void *addr, struct debug_obj_descr *descr)
 			if (!obj->astate)
 				obj->state = ODEBUG_STATE_INACTIVE;
 			else
-				debug_print_object(obj, "deactivate");
+				print_object = true;
 			break;
 
 		case ODEBUG_STATE_DESTROYED:
-			debug_print_object(obj, "deactivate");
+			print_object = true;
 			break;
 		default:
 			break;
 		}
-	} else {
+	}
+
+	raw_spin_unlock_irqrestore(&db->lock, flags);
+	if (!obj) {
 		struct debug_obj o = { .object = addr,
 				       .state = ODEBUG_STATE_NOTAVAILABLE,
 				       .descr = descr };
 
 		debug_print_object(&o, "deactivate");
+	} else if (print_object) {
+		debug_print_object(obj, "deactivate");
 	}
-
-	raw_spin_unlock_irqrestore(&db->lock, flags);
 }
 EXPORT_SYMBOL_GPL(debug_object_deactivate);
 
@@ -580,6 +679,7 @@ void debug_object_destroy(void *addr, struct debug_obj_descr *descr)
 	struct debug_bucket *db;
 	struct debug_obj *obj;
 	unsigned long flags;
+	bool print_object = false;
 
 	if (!debug_objects_enabled)
 		return;
@@ -599,20 +699,22 @@ void debug_object_destroy(void *addr, struct debug_obj_descr *descr)
 		obj->state = ODEBUG_STATE_DESTROYED;
 		break;
 	case ODEBUG_STATE_ACTIVE:
-		debug_print_object(obj, "destroy");
 		state = obj->state;
 		raw_spin_unlock_irqrestore(&db->lock, flags);
+		debug_print_object(obj, "destroy");
 		debug_object_fixup(descr->fixup_destroy, addr, state);
 		return;
 
 	case ODEBUG_STATE_DESTROYED:
-		debug_print_object(obj, "destroy");
+		print_object = true;
 		break;
 	default:
 		break;
 	}
 out_unlock:
 	raw_spin_unlock_irqrestore(&db->lock, flags);
+	if (print_object)
+		debug_print_object(obj, "destroy");
 }
 EXPORT_SYMBOL_GPL(debug_object_destroy);
 
@@ -641,9 +743,9 @@ void debug_object_free(void *addr, struct debug_obj_descr *descr)
 
 	switch (obj->state) {
 	case ODEBUG_STATE_ACTIVE:
-		debug_print_object(obj, "free");
 		state = obj->state;
 		raw_spin_unlock_irqrestore(&db->lock, flags);
+		debug_print_object(obj, "free");
 		debug_object_fixup(descr->fixup_free, addr, state);
 		return;
 	default:
@@ -664,6 +766,7 @@ EXPORT_SYMBOL_GPL(debug_object_free);
  */
 void debug_object_assert_init(void *addr, struct debug_obj_descr *descr)
 {
+	struct debug_obj o = { .object = addr, .state = ODEBUG_STATE_NOTAVAILABLE, .descr = descr };
 	struct debug_bucket *db;
 	struct debug_obj *obj;
 	unsigned long flags;
@@ -671,34 +774,25 @@ void debug_object_assert_init(void *addr, struct debug_obj_descr *descr)
 	if (!debug_objects_enabled)
 		return;
 
+	debug_objects_fill_pool();
+
 	db = get_bucket((unsigned long) addr);
 
 	raw_spin_lock_irqsave(&db->lock, flags);
+	obj = lookup_object_or_alloc(addr, db, descr, false, true);
+	raw_spin_unlock_irqrestore(&db->lock, flags);
+	if (likely(!IS_ERR_OR_NULL(obj)))
+		return;
 
-	obj = lookup_object(addr, db);
+	/* If NULL the allocation has hit OOM */
 	if (!obj) {
-		struct debug_obj o = { .object = addr,
-				       .state = ODEBUG_STATE_NOTAVAILABLE,
-				       .descr = descr };
-
-		raw_spin_unlock_irqrestore(&db->lock, flags);
-		/*
-		 * Maybe the object is static, and we let the type specific
-		 * code confirm. Track this static object if true, else invoke
-		 * fixup.
-		 */
-		if (descr->is_static_object && descr->is_static_object(addr)) {
-			/* Track this static object */
-			debug_object_init(addr, descr);
-		} else {
-			debug_print_object(&o, "assert_init");
-			debug_object_fixup(descr->fixup_assert_init, addr,
-					   ODEBUG_STATE_NOTAVAILABLE);
-		}
+		debug_objects_oom();
 		return;
 	}
 
-	raw_spin_unlock_irqrestore(&db->lock, flags);
+	/* Object is neither tracked nor static. It's not initialized. */
+	debug_print_object(&o, "assert_init");
+	debug_object_fixup(descr->fixup_assert_init, addr, ODEBUG_STATE_NOTAVAILABLE);
 }
 EXPORT_SYMBOL_GPL(debug_object_assert_init);
 
@@ -716,6 +810,7 @@ debug_object_active_state(void *addr, struct debug_obj_descr *descr,
 	struct debug_bucket *db;
 	struct debug_obj *obj;
 	unsigned long flags;
+	bool print_object = false;
 
 	if (!debug_objects_enabled)
 		return;
@@ -731,22 +826,25 @@ debug_object_active_state(void *addr, struct debug_obj_descr *descr,
 			if (obj->astate == expect)
 				obj->astate = next;
 			else
-				debug_print_object(obj, "active_state");
+				print_object = true;
 			break;
 
 		default:
-			debug_print_object(obj, "active_state");
+			print_object = true;
 			break;
 		}
-	} else {
+	}
+
+	raw_spin_unlock_irqrestore(&db->lock, flags);
+	if (!obj) {
 		struct debug_obj o = { .object = addr,
 				       .state = ODEBUG_STATE_NOTAVAILABLE,
 				       .descr = descr };
 
 		debug_print_object(&o, "active_state");
+	} else if (print_object) {
+		debug_print_object(obj, "active_state");
 	}
-
-	raw_spin_unlock_irqrestore(&db->lock, flags);
 }
 EXPORT_SYMBOL_GPL(debug_object_active_state);
 
@@ -782,10 +880,10 @@ static void __debug_check_no_obj_freed(const void *address, unsigned long size)
 
 			switch (obj->state) {
 			case ODEBUG_STATE_ACTIVE:
-				debug_print_object(obj, "free");
 				descr = obj->descr;
 				state = obj->state;
 				raw_spin_unlock_irqrestore(&db->lock, flags);
+				debug_print_object(obj, "free");
 				debug_object_fixup(descr->fixup_free,
 						   (void *) oaddr, state);
 				goto repeat;
@@ -822,13 +920,19 @@ void debug_check_no_obj_freed(const void *address, unsigned long size)
 
 static int debug_stats_show(struct seq_file *m, void *v)
 {
+	int cpu, obj_percpu_free = 0;
+
+	for_each_possible_cpu(cpu)
+		obj_percpu_free += per_cpu(percpu_obj_pool.obj_free, cpu);
+
 	seq_printf(m, "max_chain     :%d\n", debug_objects_maxchain);
 	seq_printf(m, "max_checked   :%d\n", debug_objects_maxchecked);
 	seq_printf(m, "warnings      :%d\n", debug_objects_warnings);
 	seq_printf(m, "fixups        :%d\n", debug_objects_fixups);
-	seq_printf(m, "pool_free     :%d\n", obj_pool_free);
+	seq_printf(m, "pool_free     :%d\n", obj_pool_free + obj_percpu_free);
+	seq_printf(m, "pool_pcp_free :%d\n", obj_percpu_free);
 	seq_printf(m, "pool_min_free :%d\n", obj_pool_min_free);
-	seq_printf(m, "pool_used     :%d\n", obj_pool_used);
+	seq_printf(m, "pool_used     :%d\n", obj_pool_used - obj_percpu_free);
 	seq_printf(m, "pool_max_used :%d\n", obj_pool_max_used);
 	seq_printf(m, "on_free_list  :%d\n", obj_nr_tofree);
 	seq_printf(m, "objs_allocated:%d\n", debug_objects_allocated);
@@ -1177,9 +1281,20 @@ static int __init debug_objects_replace_static_objects(void)
  */
 void __init debug_objects_mem_init(void)
 {
+	int cpu;
+
 	if (!debug_objects_enabled)
 		return;
 
+	/*
+	 * Initialize the percpu object pools
+	 *
+	 * Initialization is not strictly necessary, but was done for
+	 * completeness.
+	 */
+	for_each_possible_cpu(cpu)
+		INIT_HLIST_HEAD(&per_cpu(percpu_obj_pool.free_objs, cpu));
+
 	obj_cache = kmem_cache_create("debug_objects_cache",
 				      sizeof (struct debug_obj), 0,
 				      SLAB_DEBUG_OBJECTS | SLAB_NOLEAKTRACE,
@@ -1191,11 +1306,4 @@ void __init debug_objects_mem_init(void)
 		pr_warn("out of memory.\n");
 	} else
 		debug_objects_selftest();
-
-	/*
-	 * Increase the thresholds for allocating and freeing objects
-	 * according to the number of possible CPUs available in the system.
-	 */
-	debug_objects_pool_size += num_possible_cpus() * 32;
-	debug_objects_pool_min_level += num_possible_cpus() * 4;
 }
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 1cffd4e1fd8f..4553cc848abc 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5425,7 +5425,21 @@ static void __build_all_zonelists(void *data)
 	int nid;
 	int __maybe_unused cpu;
 	pg_data_t *self = data;
+	unsigned long flags;
 
+	/*
+	 * Explicitly disable this CPU's interrupts before taking seqlock
+	 * to prevent any IRQ handler from calling into the page allocator
+	 * (e.g. GFP_ATOMIC) that could hit zonelist_iter_begin and livelock.
+	 */
+	local_irq_save(flags);
+	/*
+	 * Explicitly disable this CPU's synchronous printk() before taking
+	 * seqlock to prevent any printk() from trying to hold port->lock, for
+	 * tty_insert_flip_string_and_push_buffer() on other CPU might be
+	 * calling kmalloc(GFP_ATOMIC | __GFP_NOWARN) with port->lock held.
+	 */
+	printk_deferred_enter();
 	write_seqlock(&zonelist_update_seq);
 
 #ifdef CONFIG_NUMA
@@ -5460,6 +5474,8 @@ static void __build_all_zonelists(void *data)
 	}
 
 	write_sequnlock(&zonelist_update_seq);
+	printk_deferred_exit();
+	local_irq_restore(flags);
 }
 
 static noinline void __init
diff --git a/net/8021q/vlan_dev.c b/net/8021q/vlan_dev.c
index 84ef83772114..c80add6edf59 100644
--- a/net/8021q/vlan_dev.c
+++ b/net/8021q/vlan_dev.c
@@ -369,7 +369,7 @@ static int vlan_dev_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
 
 	switch (cmd) {
 	case SIOCSHWTSTAMP:
-		if (!net_eq(dev_net(dev), &init_net))
+		if (!net_eq(dev_net(dev), dev_net(real_dev)))
 			break;
 	case SIOCGMIIPHY:
 	case SIOCGMIIREG:
diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index 6908817a5a70..908a57578794 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -989,7 +989,14 @@ static int hci_sock_ioctl(struct socket *sock, unsigned int cmd,
 	if (hci_sock_gen_cookie(sk)) {
 		struct sk_buff *skb;
 
-		if (capable(CAP_NET_ADMIN))
+		/* Perform careful checks before setting the HCI_SOCK_TRUSTED
+		 * flag. Make sure that not only the current task but also
+		 * the socket opener has the required capability, since
+		 * privileged programs can be tricked into making ioctl calls
+		 * on HCI sockets, and the socket should not be marked as
+		 * trusted simply because the ioctl caller is privileged.
+		 */
+		if (sk_capable(sk, CAP_NET_ADMIN))
 			hci_sock_set_flag(sk, HCI_SOCK_TRUSTED);
 
 		/* Send event to monitor */
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 7f501dff4501..5ae62d743357 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -4445,6 +4445,9 @@ void __skb_tstamp_tx(struct sk_buff *orig_skb,
 			skb = alloc_skb(0, GFP_ATOMIC);
 	} else {
 		skb = skb_clone(orig_skb, GFP_ATOMIC);
+
+		if (skb_orphan_frags_rx(skb, GFP_ATOMIC))
+			return;
 	}
 	if (!skb)
 		return;
diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
index 06a981676356..92fa11e75a4d 100644
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -1443,9 +1443,19 @@ struct sk_buff *__ip_make_skb(struct sock *sk,
 	cork->dst = NULL;
 	skb_dst_set(skb, &rt->dst);
 
-	if (iph->protocol == IPPROTO_ICMP)
-		icmp_out_count(net, ((struct icmphdr *)
-			skb_transport_header(skb))->type);
+	if (iph->protocol == IPPROTO_ICMP) {
+		u8 icmp_type;
+
+		/* For such sockets, transhdrlen is zero when do ip_append_data(),
+		 * so icmphdr does not in skb linear region and can not get icmp_type
+		 * by icmp_hdr(skb)->type.
+		 */
+		if (sk->sk_type == SOCK_RAW && !inet_sk(sk)->hdrincl)
+			icmp_type = fl4->fl4_icmp_type;
+		else
+			icmp_type = icmp_hdr(skb)->type;
+		icmp_out_count(net, icmp_type);
+	}
 
 	ip_cork_release(cork);
 out:
diff --git a/net/ipv6/sit.c b/net/ipv6/sit.c
index df734fe64d10..ec1de1e6b8e3 100644
--- a/net/ipv6/sit.c
+++ b/net/ipv6/sit.c
@@ -1053,12 +1053,13 @@ static netdev_tx_t sit_tunnel_xmit(struct sk_buff *skb,
 
 static void ipip6_tunnel_bind_dev(struct net_device *dev)
 {
+	struct ip_tunnel *tunnel = netdev_priv(dev);
+	int t_hlen = tunnel->hlen + sizeof(struct iphdr);
 	struct net_device *tdev = NULL;
-	struct ip_tunnel *tunnel;
+	int hlen = LL_MAX_HEADER;
 	const struct iphdr *iph;
 	struct flowi4 fl4;
 
-	tunnel = netdev_priv(dev);
 	iph = &tunnel->parms.iph;
 
 	if (iph->daddr) {
@@ -1081,14 +1082,15 @@ static void ipip6_tunnel_bind_dev(struct net_device *dev)
 		tdev = __dev_get_by_index(tunnel->net, tunnel->parms.link);
 
 	if (tdev && !netif_is_l3_master(tdev)) {
-		int t_hlen = tunnel->hlen + sizeof(struct iphdr);
 		int mtu;
 
 		mtu = tdev->mtu - t_hlen;
 		if (mtu < IPV6_MIN_MTU)
 			mtu = IPV6_MIN_MTU;
 		WRITE_ONCE(dev->mtu, mtu);
+		hlen = tdev->hard_header_len + tdev->needed_headroom;
 	}
+	dev->needed_headroom = t_hlen + hlen;
 }
 
 static void ipip6_tunnel_update(struct ip_tunnel *t, struct ip_tunnel_parm *p,
diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 079f76849693..e20bde9cc7b1 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -3758,12 +3758,24 @@ void nf_tables_unbind_set(const struct nft_ctx *ctx, struct nft_set *set,
 }
 EXPORT_SYMBOL_GPL(nf_tables_unbind_set);
 
+void nf_tables_activate_set(const struct nft_ctx *ctx, struct nft_set *set)
+{
+	if (nft_set_is_anonymous(set))
+		nft_clear(ctx->net, set);
+
+	set->use++;
+}
+EXPORT_SYMBOL_GPL(nf_tables_activate_set);
+
 void nf_tables_deactivate_set(const struct nft_ctx *ctx, struct nft_set *set,
 			      struct nft_set_binding *binding,
 			      enum nft_trans_phase phase)
 {
 	switch (phase) {
 	case NFT_TRANS_PREPARE:
+		if (nft_set_is_anonymous(set))
+			nft_deactivate_next(ctx->net, set);
+
 		set->use--;
 		return;
 	case NFT_TRANS_ABORT:
@@ -6241,6 +6253,8 @@ static int nf_tables_validate(struct net *net)
 			if (nft_table_validate(net, table) < 0)
 				return -EAGAIN;
 		}
+
+		nft_validate_state_update(net, NFT_VALIDATE_SKIP);
 		break;
 	}
 
@@ -6767,11 +6781,6 @@ static int __nf_tables_abort(struct net *net)
 	return 0;
 }
 
-static void nf_tables_cleanup(struct net *net)
-{
-	nft_validate_state_update(net, NFT_VALIDATE_SKIP);
-}
-
 static int nf_tables_abort(struct net *net, struct sk_buff *skb)
 {
 	int ret = __nf_tables_abort(net);
@@ -6802,7 +6811,6 @@ static const struct nfnetlink_subsystem nf_tables_subsys = {
 	.cb		= nf_tables_cb,
 	.commit		= nf_tables_commit,
 	.abort		= nf_tables_abort,
-	.cleanup	= nf_tables_cleanup,
 	.valid_genid	= nf_tables_valid_genid,
 	.owner		= THIS_MODULE,
 };
diff --git a/net/netfilter/nfnetlink.c b/net/netfilter/nfnetlink.c
index 9bacddc761ba..39e369e18cb8 100644
--- a/net/netfilter/nfnetlink.c
+++ b/net/netfilter/nfnetlink.c
@@ -495,8 +495,6 @@ static void nfnetlink_rcv_batch(struct sk_buff *skb, struct nlmsghdr *nlh,
 	} else {
 		ss->abort(net, oskb);
 	}
-	if (ss->cleanup)
-		ss->cleanup(net);
 
 	nfnl_err_deliver(&err_list, oskb);
 	kfree_skb(skb);
diff --git a/net/netfilter/nft_dynset.c b/net/netfilter/nft_dynset.c
index cc076d535e14..ea73130427eb 100644
--- a/net/netfilter/nft_dynset.c
+++ b/net/netfilter/nft_dynset.c
@@ -248,7 +248,7 @@ static void nft_dynset_activate(const struct nft_ctx *ctx,
 {
 	struct nft_dynset *priv = nft_expr_priv(expr);
 
-	priv->set->use++;
+	nf_tables_activate_set(ctx, priv->set);
 }
 
 static void nft_dynset_destroy(const struct nft_ctx *ctx,
diff --git a/net/netfilter/nft_lookup.c b/net/netfilter/nft_lookup.c
index 55754d9939b5..cb9e937a5ce0 100644
--- a/net/netfilter/nft_lookup.c
+++ b/net/netfilter/nft_lookup.c
@@ -132,7 +132,7 @@ static void nft_lookup_activate(const struct nft_ctx *ctx,
 {
 	struct nft_lookup *priv = nft_expr_priv(expr);
 
-	priv->set->use++;
+	nf_tables_activate_set(ctx, priv->set);
 }
 
 static void nft_lookup_destroy(const struct nft_ctx *ctx,
diff --git a/net/netfilter/nft_objref.c b/net/netfilter/nft_objref.c
index bf92a40dd1b2..eff2173db7e4 100644
--- a/net/netfilter/nft_objref.c
+++ b/net/netfilter/nft_objref.c
@@ -182,7 +182,7 @@ static void nft_objref_map_activate(const struct nft_ctx *ctx,
 {
 	struct nft_objref_map *priv = nft_expr_priv(expr);
 
-	priv->set->use++;
+	nf_tables_activate_set(ctx, priv->set);
 }
 
 static void nft_objref_map_destroy(const struct nft_ctx *ctx,
diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
index 6a49c0aa55bd..6867158656b8 100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -1738,7 +1738,8 @@ static int netlink_getsockopt(struct socket *sock, int level, int optname,
 {
 	struct sock *sk = sock->sk;
 	struct netlink_sock *nlk = nlk_sk(sk);
-	int len, val, err;
+	unsigned int flag;
+	int len, val;
 
 	if (level != SOL_NETLINK)
 		return -ENOPROTOOPT;
@@ -1750,39 +1751,17 @@ static int netlink_getsockopt(struct socket *sock, int level, int optname,
 
 	switch (optname) {
 	case NETLINK_PKTINFO:
-		if (len < sizeof(int))
-			return -EINVAL;
-		len = sizeof(int);
-		val = nlk->flags & NETLINK_F_RECV_PKTINFO ? 1 : 0;
-		if (put_user(len, optlen) ||
-		    put_user(val, optval))
-			return -EFAULT;
-		err = 0;
+		flag = NETLINK_F_RECV_PKTINFO;
 		break;
 	case NETLINK_BROADCAST_ERROR:
-		if (len < sizeof(int))
-			return -EINVAL;
-		len = sizeof(int);
-		val = nlk->flags & NETLINK_F_BROADCAST_SEND_ERROR ? 1 : 0;
-		if (put_user(len, optlen) ||
-		    put_user(val, optval))
-			return -EFAULT;
-		err = 0;
+		flag = NETLINK_F_BROADCAST_SEND_ERROR;
 		break;
 	case NETLINK_NO_ENOBUFS:
-		if (len < sizeof(int))
-			return -EINVAL;
-		len = sizeof(int);
-		val = nlk->flags & NETLINK_F_RECV_NO_ENOBUFS ? 1 : 0;
-		if (put_user(len, optlen) ||
-		    put_user(val, optval))
-			return -EFAULT;
-		err = 0;
+		flag = NETLINK_F_RECV_NO_ENOBUFS;
 		break;
 	case NETLINK_LIST_MEMBERSHIPS: {
-		int pos, idx, shift;
+		int pos, idx, shift, err = 0;
 
-		err = 0;
 		netlink_lock_table();
 		for (pos = 0; pos * 8 < nlk->ngroups; pos += sizeof(u32)) {
 			if (len - pos < sizeof(u32))
@@ -1799,31 +1778,29 @@ static int netlink_getsockopt(struct socket *sock, int level, int optname,
 		if (put_user(ALIGN(nlk->ngroups / 8, sizeof(u32)), optlen))
 			err = -EFAULT;
 		netlink_unlock_table();
-		break;
+		return err;
 	}
 	case NETLINK_CAP_ACK:
-		if (len < sizeof(int))
-			return -EINVAL;
-		len = sizeof(int);
-		val = nlk->flags & NETLINK_F_CAP_ACK ? 1 : 0;
-		if (put_user(len, optlen) ||
-		    put_user(val, optval))
-			return -EFAULT;
-		err = 0;
+		flag = NETLINK_F_CAP_ACK;
 		break;
 	case NETLINK_EXT_ACK:
-		if (len < sizeof(int))
-			return -EINVAL;
-		len = sizeof(int);
-		val = nlk->flags & NETLINK_F_EXT_ACK ? 1 : 0;
-		if (put_user(len, optlen) || put_user(val, optval))
-			return -EFAULT;
-		err = 0;
+		flag = NETLINK_F_EXT_ACK;
 		break;
 	default:
-		err = -ENOPROTOOPT;
+		return -ENOPROTOOPT;
 	}
-	return err;
+
+	if (len < sizeof(int))
+		return -EINVAL;
+
+	len = sizeof(int);
+	val = nlk->flags & flag ? 1 : 0;
+
+	if (put_user(len, optlen) ||
+	    copy_to_user(optval, &val, len))
+		return -EFAULT;
+
+	return 0;
 }
 
 static void netlink_cmsg_recv_pktinfo(struct msghdr *msg, struct sk_buff *skb)
diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index 6fa0a9a453a8..aa12bee4133a 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -1955,7 +1955,7 @@ static int packet_sendmsg_spkt(struct socket *sock, struct msghdr *msg,
 		goto retry;
 	}
 
-	if (!dev_validate_header(dev, skb->data, len)) {
+	if (!dev_validate_header(dev, skb->data, len) || !skb->len) {
 		err = -EINVAL;
 		goto out_unlock;
 	}
@@ -2105,7 +2105,7 @@ static int packet_rcv(struct sk_buff *skb, struct net_device *dev,
 	sll = &PACKET_SKB_CB(skb)->sa.ll;
 	sll->sll_hatype = dev->type;
 	sll->sll_pkttype = skb->pkt_type;
-	if (unlikely(po->origdev))
+	if (unlikely(packet_sock_flag(po, PACKET_SOCK_ORIGDEV)))
 		sll->sll_ifindex = orig_dev->ifindex;
 	else
 		sll->sll_ifindex = dev->ifindex;
@@ -2371,7 +2371,7 @@ static int tpacket_rcv(struct sk_buff *skb, struct net_device *dev,
 	sll->sll_hatype = dev->type;
 	sll->sll_protocol = skb->protocol;
 	sll->sll_pkttype = skb->pkt_type;
-	if (unlikely(po->origdev))
+	if (unlikely(packet_sock_flag(po, PACKET_SOCK_ORIGDEV)))
 		sll->sll_ifindex = orig_dev->ifindex;
 	else
 		sll->sll_ifindex = dev->ifindex;
@@ -3444,7 +3444,7 @@ static int packet_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
 		memcpy(msg->msg_name, &PACKET_SKB_CB(skb)->sa, copy_len);
 	}
 
-	if (pkt_sk(sk)->auxdata) {
+	if (packet_sock_flag(pkt_sk(sk), PACKET_SOCK_AUXDATA)) {
 		struct tpacket_auxdata aux;
 
 		aux.tp_status = TP_STATUS_USER;
@@ -3827,9 +3827,7 @@ packet_setsockopt(struct socket *sock, int level, int optname, char __user *optv
 		if (copy_from_user(&val, optval, sizeof(val)))
 			return -EFAULT;
 
-		lock_sock(sk);
-		po->auxdata = !!val;
-		release_sock(sk);
+		packet_sock_flag_set(po, PACKET_SOCK_AUXDATA, val);
 		return 0;
 	}
 	case PACKET_ORIGDEV:
@@ -3841,9 +3839,7 @@ packet_setsockopt(struct socket *sock, int level, int optname, char __user *optv
 		if (copy_from_user(&val, optval, sizeof(val)))
 			return -EFAULT;
 
-		lock_sock(sk);
-		po->origdev = !!val;
-		release_sock(sk);
+		packet_sock_flag_set(po, PACKET_SOCK_ORIGDEV, val);
 		return 0;
 	}
 	case PACKET_VNET_HDR:
@@ -3973,10 +3969,10 @@ static int packet_getsockopt(struct socket *sock, int level, int optname,
 
 		break;
 	case PACKET_AUXDATA:
-		val = po->auxdata;
+		val = packet_sock_flag(po, PACKET_SOCK_AUXDATA);
 		break;
 	case PACKET_ORIGDEV:
-		val = po->origdev;
+		val = packet_sock_flag(po, PACKET_SOCK_ORIGDEV);
 		break;
 	case PACKET_VNET_HDR:
 		val = po->has_vnet_hdr;
diff --git a/net/packet/diag.c b/net/packet/diag.c
index 7ef1c881ae74..d9f912ad23df 100644
--- a/net/packet/diag.c
+++ b/net/packet/diag.c
@@ -22,9 +22,9 @@ static int pdiag_put_info(const struct packet_sock *po, struct sk_buff *nlskb)
 	pinfo.pdi_flags = 0;
 	if (po->running)
 		pinfo.pdi_flags |= PDI_RUNNING;
-	if (po->auxdata)
+	if (packet_sock_flag(po, PACKET_SOCK_AUXDATA))
 		pinfo.pdi_flags |= PDI_AUXDATA;
-	if (po->origdev)
+	if (packet_sock_flag(po, PACKET_SOCK_ORIGDEV))
 		pinfo.pdi_flags |= PDI_ORIGDEV;
 	if (po->has_vnet_hdr)
 		pinfo.pdi_flags |= PDI_VNETHDR;
diff --git a/net/packet/internal.h b/net/packet/internal.h
index f10294800aaf..3d871cae85b8 100644
--- a/net/packet/internal.h
+++ b/net/packet/internal.h
@@ -115,10 +115,9 @@ struct packet_sock {
 	int			copy_thresh;
 	spinlock_t		bind_lock;
 	struct mutex		pg_vec_lock;
+	unsigned long		flags;
 	unsigned int		running;	/* bind_lock must be held */
-	unsigned int		auxdata:1,	/* writer must hold sock lock */
-				origdev:1,
-				has_vnet_hdr:1,
+	unsigned int		has_vnet_hdr:1, /* writer must hold sock lock */
 				tp_loss:1,
 				tp_tx_has_off:1;
 	int			pressure;
@@ -142,4 +141,25 @@ static struct packet_sock *pkt_sk(struct sock *sk)
 	return (struct packet_sock *)sk;
 }
 
+enum packet_sock_flags {
+	PACKET_SOCK_ORIGDEV,
+	PACKET_SOCK_AUXDATA,
+};
+
+static inline void packet_sock_flag_set(struct packet_sock *po,
+					enum packet_sock_flags flag,
+					bool val)
+{
+	if (val)
+		set_bit(flag, &po->flags);
+	else
+		clear_bit(flag, &po->flags);
+}
+
+static inline bool packet_sock_flag(const struct packet_sock *po,
+				    enum packet_sock_flags flag)
+{
+	return test_bit(flag, &po->flags);
+}
+
 #endif
diff --git a/net/rxrpc/sendmsg.c b/net/rxrpc/sendmsg.c
index a7a09eb04d93..eaa032c498c9 100644
--- a/net/rxrpc/sendmsg.c
+++ b/net/rxrpc/sendmsg.c
@@ -709,7 +709,7 @@ int rxrpc_do_sendmsg(struct rxrpc_sock *rx, struct msghdr *msg, size_t len)
 		/* Fall through */
 	case 1:
 		if (p.call.timeouts.hard > 0) {
-			j = msecs_to_jiffies(p.call.timeouts.hard);
+			j = p.call.timeouts.hard * HZ;
 			now = jiffies;
 			j += now;
 			WRITE_ONCE(call->expect_term_by, j);
diff --git a/net/sched/act_mirred.c b/net/sched/act_mirred.c
index a30c17a28281..9aad86e4a0fb 100644
--- a/net/sched/act_mirred.c
+++ b/net/sched/act_mirred.c
@@ -220,7 +220,7 @@ static int tcf_mirred_act(struct sk_buff *skb, const struct tc_action *a,
 		goto out;
 	}
 
-	if (unlikely(!(dev->flags & IFF_UP))) {
+	if (unlikely(!(dev->flags & IFF_UP)) || !netif_carrier_ok(dev)) {
 		net_notice_ratelimited("tc mirred to Houston: device %s is down\n",
 				       dev->name);
 		goto out;
diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index 1946bd13d5df..e5498253ad93 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -1814,9 +1814,6 @@ call_bind_status(struct rpc_task *task)
 			status = -EOPNOTSUPP;
 			break;
 		}
-		if (task->tk_rebind_retry == 0)
-			break;
-		task->tk_rebind_retry--;
 		rpc_delay(task, 3*HZ);
 		goto retry_timeout;
 	case -ETIMEDOUT:
diff --git a/net/sunrpc/sched.c b/net/sunrpc/sched.c
index e36ae4d4b540..9af919364a00 100644
--- a/net/sunrpc/sched.c
+++ b/net/sunrpc/sched.c
@@ -709,7 +709,6 @@ rpc_init_task_statistics(struct rpc_task *task)
 	/* Initialize retry counters */
 	task->tk_garb_retry = 2;
 	task->tk_cred_retry = 2;
-	task->tk_rebind_retry = 2;
 
 	/* starting timestamp */
 	task->tk_start = ktime_get();
diff --git a/security/selinux/Makefile b/security/selinux/Makefile
index c7161f8792b2..08ba8ca81d40 100644
--- a/security/selinux/Makefile
+++ b/security/selinux/Makefile
@@ -19,8 +19,8 @@ ccflags-y := -I$(srctree)/security/selinux -I$(srctree)/security/selinux/include
 $(addprefix $(obj)/,$(selinux-y)): $(obj)/flask.h
 
 quiet_cmd_flask = GEN     $(obj)/flask.h $(obj)/av_permissions.h
-      cmd_flask = scripts/selinux/genheaders/genheaders $(obj)/flask.h $(obj)/av_permissions.h
+      cmd_flask = $< $(obj)/flask.h $(obj)/av_permissions.h
 
 targets += flask.h av_permissions.h
-$(obj)/flask.h: $(src)/include/classmap.h FORCE
+$(obj)/flask.h $(obj)/av_permissions.h &: scripts/selinux/genheaders/genheaders FORCE
 	$(call if_changed,flask)
diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
index 2001bc774c64..d27dd170beda 100644
--- a/sound/soc/intel/boards/bytcr_rt5640.c
+++ b/sound/soc/intel/boards/bytcr_rt5640.c
@@ -400,6 +400,18 @@ static int byt_rt5640_aif1_hw_params(struct snd_pcm_substream *substream,
 
 /* Please keep this list alphabetically sorted */
 static const struct dmi_system_id byt_rt5640_quirk_table[] = {
+	{	/* Acer Iconia One 7 B1-750 */
+		.matches = {
+			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Insyde"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "VESPA2"),
+		},
+		.driver_data = (void *)(BYT_RT5640_DMIC1_MAP |
+					BYT_RT5640_JD_SRC_JD1_IN4P |
+					BYT_RT5640_OVCD_TH_1500UA |
+					BYT_RT5640_OVCD_SF_0P75 |
+					BYT_RT5640_SSP0_AIF1 |
+					BYT_RT5640_MCLK_EN),
+	},
 	{	/* Acer Iconia Tab 8 W1-810 */
 		.matches = {
 			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Acer"),
diff --git a/sound/usb/caiaq/input.c b/sound/usb/caiaq/input.c
index e883659ea6e7..19951e1dbbb0 100644
--- a/sound/usb/caiaq/input.c
+++ b/sound/usb/caiaq/input.c
@@ -817,6 +817,7 @@ int snd_usb_caiaq_input_init(struct snd_usb_caiaqdev *cdev)
 
 	default:
 		/* no input methods supported on this device */
+		ret = -EINVAL;
 		goto exit_free_idev;
 	}
 
diff --git a/tools/bpf/bpftool/json_writer.c b/tools/bpf/bpftool/json_writer.c
index c6eef76322ae..0c38c41269be 100644
--- a/tools/bpf/bpftool/json_writer.c
+++ b/tools/bpf/bpftool/json_writer.c
@@ -84,9 +84,6 @@ static void jsonw_puts(json_writer_t *self, const char *str)
 		case '"':
 			fputs("\\\"", self->out);
 			break;
-		case '\'':
-			fputs("\\\'", self->out);
-			break;
 		default:
 			putc(*str, self->out);
 		}
diff --git a/tools/bpf/bpftool/xlated_dumper.c b/tools/bpf/bpftool/xlated_dumper.c
index 3284759df98a..7f49347bf5aa 100644
--- a/tools/bpf/bpftool/xlated_dumper.c
+++ b/tools/bpf/bpftool/xlated_dumper.c
@@ -336,8 +336,15 @@ void dump_xlated_for_graph(struct dump_data *dd, void *buf_start, void *buf_end,
 	struct bpf_insn *insn_start = buf_start;
 	struct bpf_insn *insn_end = buf_end;
 	struct bpf_insn *cur = insn_start;
+	bool double_insn = false;
 
 	for (; cur <= insn_end; cur++) {
+		if (double_insn) {
+			double_insn = false;
+			continue;
+		}
+		double_insn = cur->code == (BPF_LD | BPF_IMM | BPF_DW);
+
 		printf("% 4d: ", (int)(cur - insn_start + start_idx));
 		print_bpf_insn(&cbs, cur, true);
 		if (cur != insn_end)
diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index cbf39dab19c1..4562e3b2f4d3 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -659,7 +659,7 @@ static void create_tasks(struct perf_sched *sched)
 	err = pthread_attr_init(&attr);
 	BUG_ON(err);
 	err = pthread_attr_setstacksize(&attr,
-			(size_t) max(16 * 1024, PTHREAD_STACK_MIN));
+			(size_t) max(16 * 1024, (int)PTHREAD_STACK_MIN));
 	BUG_ON(err);
 	err = pthread_mutex_lock(&sched->start_work_mutex);
 	BUG_ON(err);
diff --git a/tools/perf/pmu-events/arch/powerpc/power9/other.json b/tools/perf/pmu-events/arch/powerpc/power9/other.json
index 48cf4f920b3f..064341c0df57 100644
--- a/tools/perf/pmu-events/arch/powerpc/power9/other.json
+++ b/tools/perf/pmu-events/arch/powerpc/power9/other.json
@@ -1417,7 +1417,7 @@
   {,
     "EventCode": "0x45054",
     "EventName": "PM_FMA_CMPL",
-    "BriefDescription": "two flops operation completed (fmadd, fnmadd, fmsub, fnmsub) Scalar instructions only. "
+    "BriefDescription": "two flops operation completed (fmadd, fnmadd, fmsub, fnmsub) Scalar instructions only."
   },
   {,
     "EventCode": "0x201E8",
@@ -2017,7 +2017,7 @@
   {,
     "EventCode": "0xC0BC",
     "EventName": "PM_LSU_FLUSH_OTHER",
-    "BriefDescription": "Other LSU flushes including: Sync (sync ack from L2 caused search of LRQ for oldest snooped load, This will either signal a Precise Flush of the oldest snooped loa or a Flush Next PPC); Data Valid Flush Next (several cases of this, one example is store and reload are lined up such that a store-hit-reload scenario exists and the CDF has already launched and has gotten bad/stale data); Bad Data Valid Flush Next (might be a few cases of this, one example is a larxa (D$ hit) return data and dval but can't allocate to LMQ (LMQ full or other reason). Already gave dval but can't watch it for snoop_hit_larx. Need to take the “bad dval” back and flush all younger ops)"
+    "BriefDescription": "Other LSU flushes including: Sync (sync ack from L2 caused search of LRQ for oldest snooped load, This will either signal a Precise Flush of the oldest snooped loa or a Flush Next PPC); Data Valid Flush Next (several cases of this, one example is store and reload are lined up such that a store-hit-reload scenario exists and the CDF has already launched and has gotten bad/stale data); Bad Data Valid Flush Next (might be a few cases of this, one example is a larxa (D$ hit) return data and dval but can't allocate to LMQ (LMQ full or other reason). Already gave dval but can't watch it for snoop_hit_larx. Need to take the 'bad dval' back and flush all younger ops)"
   },
   {,
     "EventCode": "0x5094",
diff --git a/tools/perf/pmu-events/arch/powerpc/power9/pipeline.json b/tools/perf/pmu-events/arch/powerpc/power9/pipeline.json
index b4772f54a271..e2f2ed0a3549 100644
--- a/tools/perf/pmu-events/arch/powerpc/power9/pipeline.json
+++ b/tools/perf/pmu-events/arch/powerpc/power9/pipeline.json
@@ -442,7 +442,7 @@
   {,
     "EventCode": "0x4D052",
     "EventName": "PM_2FLOP_CMPL",
-    "BriefDescription": "DP vector version of fmul, fsub, fcmp, fsel, fabs, fnabs, fres ,fsqrte, fneg "
+    "BriefDescription": "DP vector version of fmul, fsub, fcmp, fsel, fabs, fnabs, fres ,fsqrte, fneg"
   },
   {,
     "EventCode": "0x1F142",
diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index 1e607403c94c..5ae37a83dca3 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -1793,6 +1793,7 @@ static int find_entire_kern_cb(void *arg, const char *name __maybe_unused,
 			       char type, u64 start)
 {
 	struct sym_args *args = arg;
+	u64 size;
 
 	if (!kallsyms__is_function(type))
 		return 0;
@@ -1802,7 +1803,9 @@ static int find_entire_kern_cb(void *arg, const char *name __maybe_unused,
 		args->start = start;
 	}
 	/* Don't know exactly where the kernel ends, so we add a page */
-	args->size = round_up(start, page_size) + page_size - args->start;
+	size = round_up(start, page_size) + page_size - args->start;
+	if (size > args->size)
+		args->size = size;
 
 	return 0;
 }
diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index 85ff4f68adc0..66e11e6bb719 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -735,8 +735,7 @@ static int hist_entry__dso_to_filter(struct hist_entry *he, int type,
 static int64_t
 sort__sym_from_cmp(struct hist_entry *left, struct hist_entry *right)
 {
-	struct addr_map_symbol *from_l = &left->branch_info->from;
-	struct addr_map_symbol *from_r = &right->branch_info->from;
+	struct addr_map_symbol *from_l, *from_r;
 
 	if (!left->branch_info || !right->branch_info)
 		return cmp_null(left->branch_info, right->branch_info);
diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index 8dde4369fbcd..227dfe33063c 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -517,7 +517,7 @@ static int elf_read_build_id(Elf *elf, void *bf, size_t size)
 				size_t sz = min(size, descsz);
 				memcpy(bf, ptr, sz);
 				memset(bf + sz, 0, size - sz);
-				err = descsz;
+				err = sz;
 				break;
 			}
 		}
