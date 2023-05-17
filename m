Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E17B706757
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 14:00:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbjEQMAL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 08:00:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231444AbjEQL77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 07:59:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73EAB194;
        Wed, 17 May 2023 04:59:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8CF0261309;
        Wed, 17 May 2023 11:59:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B090C4339C;
        Wed, 17 May 2023 11:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684324792;
        bh=/Fo7GyFTMUUCvY8qMwDo+O8rsq0nLbdwkg1mbi6fj0A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zuLlqWP01P8y5jlc6+eRyK1flDkgWYAcDVgNvorWAMdf+h+u842MSGmiios/PebqU
         XLeTm+Xwzbnu0n93iZEIOlK4Qb/KqMB5D41Vp1wLeSq9BgZ3qm91xF1uW66XQMOtm7
         F4wcfQ/wVRceQo6Wcz7BYNvpX4ps0a0gRaq65lQw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 4.14.315
Date:   Wed, 17 May 2023 13:59:40 +0200
Message-Id: <2023051739-thespian-collision-f2d3@gregkh>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <2023051739-machinist-secluding-0747@gregkh>
References: <2023051739-machinist-secluding-0747@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

diff --git a/Makefile b/Makefile
index ad598ce28494..78a88e76c253 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 4
 PATCHLEVEL = 14
-SUBLEVEL = 314
+SUBLEVEL = 315
 EXTRAVERSION =
 NAME = Petit Gorille
 
diff --git a/arch/arm/boot/dts/exynos4412-itop-elite.dts b/arch/arm/boot/dts/exynos4412-itop-elite.dts
index d66093084dbb..bd263a496a27 100644
--- a/arch/arm/boot/dts/exynos4412-itop-elite.dts
+++ b/arch/arm/boot/dts/exynos4412-itop-elite.dts
@@ -187,7 +187,7 @@
 		compatible = "wlf,wm8960";
 		reg = <0x1a>;
 		clocks = <&pmu_system_controller 0>;
-		clock-names = "MCLK1";
+		clock-names = "mclk";
 		wlf,shared-lrclk;
 		#sound-dai-cells = <0>;
 	};
diff --git a/arch/arm/boot/dts/s5pv210.dtsi b/arch/arm/boot/dts/s5pv210.dtsi
index a215218237a6..f9930f509a92 100644
--- a/arch/arm/boot/dts/s5pv210.dtsi
+++ b/arch/arm/boot/dts/s5pv210.dtsi
@@ -563,7 +563,7 @@
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
index 2ccd0a99d8b3..970ce0907887 100644
--- a/arch/arm64/kernel/debug-monitors.c
+++ b/arch/arm64/kernel/debug-monitors.c
@@ -434,6 +434,11 @@ int kernel_active_single_step(void)
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
index 7fd7a9cd8616..05790fce1a85 100644
--- a/arch/arm64/kernel/kgdb.c
+++ b/arch/arm64/kernel/kgdb.c
@@ -223,6 +223,8 @@ int kgdb_arch_handle_exception(int exception_vector, int signo,
 		 */
 		if (!kernel_active_single_step())
 			kernel_enable_single_step(linux_regs);
+		else
+			kernel_rewind_single_step(linux_regs);
 		err = 0;
 		break;
 	default:
diff --git a/arch/ia64/mm/contig.c b/arch/ia64/mm/contig.c
index 52715a71aede..179d354e0232 100644
--- a/arch/ia64/mm/contig.c
+++ b/arch/ia64/mm/contig.c
@@ -129,7 +129,7 @@ void *per_cpu_init(void)
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
diff --git a/arch/parisc/kernel/real2.S b/arch/parisc/kernel/real2.S
index cc9963421a19..ef22978978d4 100644
--- a/arch/parisc/kernel/real2.S
+++ b/arch/parisc/kernel/real2.S
@@ -254,9 +254,6 @@ ENTRY_CFI(real64_call_asm)
 	/* save fn */
 	copy	%arg2, %r31
 
-	/* set up the new ap */
-	ldo	64(%arg1), %r29
-
 	/* load up the arg registers from the saved arg area */
 	/* 32-bit calling convention passes first 4 args in registers */
 	ldd	0*REG_SZ(%arg1), %arg0		/* note overwriting arg0 */
@@ -268,7 +265,9 @@ ENTRY_CFI(real64_call_asm)
 	ldd	7*REG_SZ(%arg1), %r19
 	ldd	1*REG_SZ(%arg1), %arg1		/* do this one last! */
 
+	/* set up real-mode stack and real-mode ap */
 	tophys_r1 %sp
+	ldo	-16(%sp), %r29			/* Reference param save area */
 
 	b,l	rfi_virt2real,%r2
 	nop
diff --git a/arch/powerpc/kernel/rtas.c b/arch/powerpc/kernel/rtas.c
index 5d84b412b2fd..35f1f8b2f625 100644
--- a/arch/powerpc/kernel/rtas.c
+++ b/arch/powerpc/kernel/rtas.c
@@ -400,7 +400,7 @@ static char *__fetch_rtas_last_error(char *altbuf)
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
index ade83829d5e8..416375b346ba 100644
--- a/arch/powerpc/platforms/embedded6xx/flipper-pic.c
+++ b/arch/powerpc/platforms/embedded6xx/flipper-pic.c
@@ -157,7 +157,7 @@ struct irq_domain * __init flipper_pic_init(struct device_node *np)
 	}
 	io_base = ioremap(res.start, resource_size(&res));
 
-	pr_info("controller at 0x%08x mapped to 0x%p\n", res.start, io_base);
+	pr_info("controller at 0x%pa mapped to 0x%p\n", &res.start, io_base);
 
 	__flipper_quiesce(io_base);
 
diff --git a/arch/powerpc/platforms/embedded6xx/hlwd-pic.c b/arch/powerpc/platforms/embedded6xx/hlwd-pic.c
index db2ea6b6889d..7b7d659fd156 100644
--- a/arch/powerpc/platforms/embedded6xx/hlwd-pic.c
+++ b/arch/powerpc/platforms/embedded6xx/hlwd-pic.c
@@ -178,7 +178,7 @@ struct irq_domain *hlwd_pic_init(struct device_node *np)
 		return NULL;
 	}
 
-	pr_info("controller at 0x%08x mapped to 0x%p\n", res.start, io_base);
+	pr_info("controller at 0x%pa mapped to 0x%p\n", &res.start, io_base);
 
 	__hlwd_quiesce(io_base);
 
diff --git a/arch/powerpc/platforms/embedded6xx/wii.c b/arch/powerpc/platforms/embedded6xx/wii.c
index 2914529c0695..eabbced08d5f 100644
--- a/arch/powerpc/platforms/embedded6xx/wii.c
+++ b/arch/powerpc/platforms/embedded6xx/wii.c
@@ -143,8 +143,8 @@ static void __iomem *wii_ioremap_hw_regs(char *name, char *compatible)
 
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
index 488e0853a44d..c3a4eeabe753 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -411,10 +411,9 @@ static unsigned int reserve_eilvt_offset(int offset, unsigned int new)
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
index de74bca6a8ff..1cceb30357aa 100644
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -2357,17 +2357,21 @@ static int io_apic_get_redir_entries(int ioapic)
 
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
diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index a7c180426c60..5a63010f2af3 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -1309,7 +1309,7 @@ static void submit_one_flush(struct drbd_device *device, struct issue_flush_cont
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
index 3acf5f041e3c..857d5008239f 100644
--- a/drivers/clk/rockchip/clk-rk3399.c
+++ b/drivers/clk/rockchip/clk-rk3399.c
@@ -1266,7 +1266,7 @@ static struct rockchip_clk_branch rk3399_clk_branches[] __initdata = {
 			RK3399_CLKSEL_CON(56), 6, 2, MFLAGS,
 			RK3399_CLKGATE_CON(10), 7, GFLAGS),
 
-	COMPOSITE_NOGATE(SCLK_CIF_OUT, "clk_cifout", mux_clk_cif_p, 0,
+	COMPOSITE_NOGATE(SCLK_CIF_OUT, "clk_cifout", mux_clk_cif_p, CLK_SET_RATE_PARENT,
 			 RK3399_CLKSEL_CON(56), 5, 1, MFLAGS, 0, 5, DFLAGS),
 
 	/* gic */
diff --git a/drivers/dma/at_xdmac.c b/drivers/dma/at_xdmac.c
index c8dd0eef0b67..3f9f1d6e3b50 100644
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
@@ -1880,6 +1881,7 @@ static int atmel_xdmac_suspend(struct device *dev)
 		}
 	}
 	atxdmac->save_gim = at_xdmac_read(atxdmac, AT_XDMAC_GIM);
+	atxdmac->save_gs = at_xdmac_read(atxdmac, AT_XDMAC_GS);
 
 	at_xdmac_off(atxdmac);
 	clk_disable_unprepare(atxdmac->clk);
@@ -1917,7 +1919,8 @@ static int atmel_xdmac_resume(struct device *dev)
 			at_xdmac_chan_write(atchan, AT_XDMAC_CNDC, atchan->save_cndc);
 			at_xdmac_chan_write(atchan, AT_XDMAC_CIE, atchan->save_cim);
 			wmb();
-			at_xdmac_write(atxdmac, AT_XDMAC_GE, atchan->mask);
+			if (atxdmac->save_gs & atchan->mask)
+				at_xdmac_write(atxdmac, AT_XDMAC_GE, atchan->mask);
 		}
 	}
 	return 0;
diff --git a/drivers/gpu/drm/drm_probe_helper.c b/drivers/gpu/drm/drm_probe_helper.c
index adbabf16c07b..f76eced3ff94 100644
--- a/drivers/gpu/drm/drm_probe_helper.c
+++ b/drivers/gpu/drm/drm_probe_helper.c
@@ -465,8 +465,9 @@ int drm_helper_probe_single_connector_modes(struct drm_connector *connector,
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
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_gem.c b/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
index bde65186a3c3..8ba3a682dd9a 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
@@ -268,9 +268,6 @@ static int rockchip_drm_gem_object_mmap(struct drm_gem_object *obj,
 	else
 		ret = rockchip_drm_gem_object_mmap_dma(obj, vma);
 
-	if (ret)
-		drm_gem_vm_close(vma);
-
 	return ret;
 }
 
diff --git a/drivers/gpu/drm/vgem/vgem_fence.c b/drivers/gpu/drm/vgem/vgem_fence.c
index 8fd52f211e9d..673db9bf3c5d 100644
--- a/drivers/gpu/drm/vgem/vgem_fence.c
+++ b/drivers/gpu/drm/vgem/vgem_fence.c
@@ -280,4 +280,5 @@ void vgem_fence_close(struct vgem_file *vfile)
 {
 	idr_for_each(&vfile->fence_idr, __vgem_fence_idr_fini, vfile);
 	idr_destroy(&vfile->fence_idr);
+	mutex_destroy(&vfile->fence_mutex);
 }
diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index 417e1083556b..921d5184196d 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -1734,6 +1734,7 @@ static void wacom_map_usage(struct input_dev *input, struct hid_usage *usage,
 	int fmax = field->logical_maximum;
 	unsigned int equivalent_usage = wacom_equivalent_usage(usage->hid);
 	int resolution_code = code;
+	int resolution = hidinput_calc_abs_res(field, resolution_code);
 
 	if (equivalent_usage == HID_DG_TWIST) {
 		resolution_code = ABS_RZ;
@@ -1756,8 +1757,15 @@ static void wacom_map_usage(struct input_dev *input, struct hid_usage *usage,
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
index a03564f41ad0..68b35220d262 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -1030,7 +1030,7 @@ omap_i2c_isr(int irq, void *dev_id)
 	u16 stat;
 
 	stat = omap_i2c_read_reg(omap, OMAP_I2C_STAT_REG);
-	mask = omap_i2c_read_reg(omap, OMAP_I2C_IE_REG);
+	mask = omap_i2c_read_reg(omap, OMAP_I2C_IE_REG) & ~OMAP_I2C_STAT_NACK;
 
 	if (stat & mask)
 		ret = IRQ_WAKE_THREAD;
diff --git a/drivers/iio/adc/palmas_gpadc.c b/drivers/iio/adc/palmas_gpadc.c
index f5218461ae25..f422df4daadc 100644
--- a/drivers/iio/adc/palmas_gpadc.c
+++ b/drivers/iio/adc/palmas_gpadc.c
@@ -634,7 +634,7 @@ static int palmas_gpadc_probe(struct platform_device *pdev)
 
 static int palmas_gpadc_remove(struct platform_device *pdev)
 {
-	struct iio_dev *indio_dev = dev_to_iio_dev(&pdev->dev);
+	struct iio_dev *indio_dev = dev_get_drvdata(&pdev->dev);
 	struct palmas_gpadc *adc = iio_priv(indio_dev);
 
 	if (adc->wakeup1_enable || adc->wakeup2_enable)
diff --git a/drivers/infiniband/hw/hfi1/mmu_rb.c b/drivers/infiniband/hw/hfi1/mmu_rb.c
index 175002c046ed..42eddaf3a994 100644
--- a/drivers/infiniband/hw/hfi1/mmu_rb.c
+++ b/drivers/infiniband/hw/hfi1/mmu_rb.c
@@ -177,7 +177,7 @@ int hfi1_mmu_rb_insert(struct mmu_rb_handler *handler,
 		goto unlock;
 	}
 	__mmu_int_rb_insert(mnode, &handler->root);
-	list_add(&mnode->list, &handler->lru_list);
+	list_add_tail(&mnode->list, &handler->lru_list);
 
 	ret = handler->ops->insert(handler->ops_arg, mnode);
 	if (ret) {
@@ -224,8 +224,10 @@ bool hfi1_mmu_rb_remove_unless_exact(struct mmu_rb_handler *handler,
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
@@ -246,8 +248,7 @@ void hfi1_mmu_rb_evict(struct mmu_rb_handler *handler, void *evict_arg)
 	INIT_LIST_HEAD(&del_list);
 
 	spin_lock_irqsave(&handler->lock, flags);
-	list_for_each_entry_safe_reverse(rbnode, ptr, &handler->lru_list,
-					 list) {
+	list_for_each_entry_safe(rbnode, ptr, &handler->lru_list, list) {
 		if (handler->ops->evict(handler->ops_arg, rbnode, evict_arg,
 					&stop)) {
 			__mmu_int_rb_remove(rbnode, &handler->root);
@@ -259,9 +260,7 @@ void hfi1_mmu_rb_evict(struct mmu_rb_handler *handler, void *evict_arg)
 	}
 	spin_unlock_irqrestore(&handler->lock, flags);
 
-	while (!list_empty(&del_list)) {
-		rbnode = list_first_entry(&del_list, struct mmu_rb_node, list);
-		list_del(&rbnode->list);
+	list_for_each_entry_safe(rbnode, ptr, &del_list, list) {
 		handler->ops->remove(handler->ops_arg, rbnode);
 	}
 }
diff --git a/drivers/infiniband/sw/rdmavt/qp.c b/drivers/infiniband/sw/rdmavt/qp.c
index b0309876f4bb..2bfcd47b58ba 100644
--- a/drivers/infiniband/sw/rdmavt/qp.c
+++ b/drivers/infiniband/sw/rdmavt/qp.c
@@ -318,8 +318,6 @@ void rvt_qp_exit(struct rvt_dev_info *rdi)
 	if (qps_inuse)
 		rvt_pr_err(rdi, "QP memory leak! %u still in use\n",
 			   qps_inuse);
-	if (!rdi->qp_dev)
-		return;
 
 	kfree(rdi->qp_dev->qp_table);
 	free_qpn_table(&rdi->qp_dev->qpn_table);
diff --git a/drivers/macintosh/Kconfig b/drivers/macintosh/Kconfig
index 5e47d91da519..aa42a41ba438 100644
--- a/drivers/macintosh/Kconfig
+++ b/drivers/macintosh/Kconfig
@@ -94,6 +94,7 @@ config ADB_PMU_LED
 
 config ADB_PMU_LED_DISK
 	bool "Use front LED as DISK LED by default"
+	depends on ATA
 	depends on ADB_PMU_LED
 	depends on LEDS_CLASS
 	select LEDS_TRIGGERS
diff --git a/drivers/macintosh/windfarm_smu_sat.c b/drivers/macintosh/windfarm_smu_sat.c
index a0f61eb853c5..644e123510c5 100644
--- a/drivers/macintosh/windfarm_smu_sat.c
+++ b/drivers/macintosh/windfarm_smu_sat.c
@@ -172,6 +172,7 @@ static void wf_sat_release(struct kref *ref)
 
 	if (sat->nr >= 0)
 		sats[sat->nr] = NULL;
+	of_node_put(sat->node);
 	kfree(sat);
 }
 
diff --git a/drivers/md/dm-flakey.c b/drivers/md/dm-flakey.c
index 9bbadceaed91..f714a4a94ddc 100644
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
index 6579aa46f544..94ab60397c95 100644
--- a/drivers/md/dm-integrity.c
+++ b/drivers/md/dm-integrity.c
@@ -3274,11 +3274,13 @@ int __init dm_integrity_init(void)
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
index fbce9fc8bda0..d49a0857cbb8 100644
--- a/drivers/md/dm-ioctl.c
+++ b/drivers/md/dm-ioctl.c
@@ -1409,11 +1409,12 @@ static int table_clear(struct file *filp, struct dm_ioctl *param, size_t param_s
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
diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index 3ad0a1460eb7..95c3a21cd733 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -2234,11 +2234,22 @@ static void recovery_request_write(struct mddev *mddev, struct r10bio *r10_bio)
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
 
@@ -2247,14 +2258,6 @@ static void recovery_request_write(struct mddev *mddev, struct r10bio *r10_bio)
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
diff --git a/drivers/media/pci/dm1105/dm1105.c b/drivers/media/pci/dm1105/dm1105.c
index 7c3900dec368..df0829791154 100644
--- a/drivers/media/pci/dm1105/dm1105.c
+++ b/drivers/media/pci/dm1105/dm1105.c
@@ -1185,6 +1185,7 @@ static void dm1105_remove(struct pci_dev *pdev)
 	struct dvb_demux *dvbdemux = &dev->demux;
 	struct dmx_demux *dmx = &dvbdemux->dmx;
 
+	cancel_work_sync(&dev->ir.work);
 	dm1105_ir_exit(dev);
 	dmx->close(dmx);
 	dvb_net_release(&dev->dvbnet);
diff --git a/drivers/media/pci/ttpci/av7110_av.c b/drivers/media/pci/ttpci/av7110_av.c
index 2aa4ba675194..43b780aadf5f 100644
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
diff --git a/drivers/media/platform/sti/bdisp/bdisp-v4l2.c b/drivers/media/platform/sti/bdisp/bdisp-v4l2.c
index 79de7d413cf5..d7432e0e3e6e 100644
--- a/drivers/media/platform/sti/bdisp/bdisp-v4l2.c
+++ b/drivers/media/platform/sti/bdisp/bdisp-v4l2.c
@@ -1308,6 +1308,8 @@ static int bdisp_probe(struct platform_device *pdev)
 	init_waitqueue_head(&bdisp->irq_queue);
 	INIT_DELAYED_WORK(&bdisp->timeout_work, bdisp_irq_timeout);
 	bdisp->work_queue = create_workqueue(BDISP_NAME);
+	if (!bdisp->work_queue)
+		return -ENOMEM;
 
 	spin_lock_init(&bdisp->slock);
 	mutex_init(&bdisp->lock);
diff --git a/drivers/mtd/ubi/eba.c b/drivers/mtd/ubi/eba.c
index c4d4b8f07630..f452c510fa32 100644
--- a/drivers/mtd/ubi/eba.c
+++ b/drivers/mtd/ubi/eba.c
@@ -943,7 +943,7 @@ static int try_write_vid_and_data(struct ubi_volume *vol, int lnum,
 				  int offset, int len)
 {
 	struct ubi_device *ubi = vol->ubi;
-	int pnum, opnum, err, vol_id = vol->vol_id;
+	int pnum, opnum, err, err2, vol_id = vol->vol_id;
 
 	pnum = ubi_wl_get_peb(ubi);
 	if (pnum < 0) {
@@ -978,10 +978,19 @@ static int try_write_vid_and_data(struct ubi_volume *vol, int lnum,
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
index f7e68083200c..55b2b6eaae2b 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
@@ -2554,6 +2554,14 @@ static int ixgbe_get_rss_hash_opts(struct ixgbe_adapter *adapter,
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
@@ -2562,7 +2570,8 @@ static int ixgbe_get_rxnfc(struct net_device *dev, struct ethtool_rxnfc *cmd,
 
 	switch (cmd->cmd) {
 	case ETHTOOL_GRXRINGS:
-		cmd->data = adapter->num_rx_queues;
+		cmd->data = min_t(int, adapter->num_rx_queues,
+				  ixgbe_rss_indir_tbl_max(adapter));
 		ret = 0;
 		break;
 	case ETHTOOL_GRXCLSRLCNT:
@@ -2964,14 +2973,6 @@ static int ixgbe_set_rxnfc(struct net_device *dev, struct ethtool_rxnfc *cmd)
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
@@ -3020,8 +3021,8 @@ static int ixgbe_set_rxfh(struct net_device *netdev, const u32 *indir,
 	int i;
 	u32 reta_entries = ixgbe_rss_indir_tbl_entries(adapter);
 
-	if (hfunc)
-		return -EINVAL;
+	if (hfunc != ETH_RSS_HASH_NO_CHANGE && hfunc != ETH_RSS_HASH_TOP)
+		return -EOPNOTSUPP;
 
 	/* Fill out the redirection table */
 	if (indir) {
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
index 334dbd834b3a..8380ee76bdde 100644
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
index 546243e11737..634cde696272 100644
--- a/drivers/net/wireless/ath/ath6kl/htc_pipe.c
+++ b/drivers/net/wireless/ath/ath6kl/htc_pipe.c
@@ -969,8 +969,8 @@ static int ath6kl_htc_pipe_rx_complete(struct ath6kl *ar, struct sk_buff *skb,
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
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
index b5fceba10806..df0e48e4cf5b 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -5458,6 +5458,11 @@ static s32 brcmf_get_assoc_ies(struct brcmf_cfg80211_info *cfg,
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
index 714996187236..7a830a9f702f 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
@@ -1721,6 +1721,11 @@ static ssize_t iwl_dbgfs_mem_read(struct file *file, char __user *user_buf,
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
@@ -1798,6 +1803,11 @@ static ssize_t iwl_dbgfs_mem_write(struct file *file,
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
index 4d3cbe554f5b..647ca6479a1e 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -562,7 +562,6 @@ static int iwl_pcie_set_hw_ready(struct iwl_trans *trans)
 int iwl_pcie_prepare_card_hw(struct iwl_trans *trans)
 {
 	int ret;
-	int t = 0;
 	int iter;
 
 	IWL_DEBUG_INFO(trans, "iwl_trans_prepare_card_hw enter\n");
@@ -577,6 +576,8 @@ int iwl_pcie_prepare_card_hw(struct iwl_trans *trans)
 	usleep_range(1000, 2000);
 
 	for (iter = 0; iter < 10; iter++) {
+		int t = 0;
+
 		/* If HW is not ready, prepare the conditions to check again */
 		iwl_set_bit(trans, CSR_HW_IF_CONFIG_REG,
 			    CSR_HW_IF_CONFIG_REG_PREPARE);
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192e.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192e.c
index e202b67832e9..413f0ced960a 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192e.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192e.c
@@ -1660,6 +1660,7 @@ struct rtl8xxxu_fileops rtl8192eu_fops = {
 	.rx_desc_size = sizeof(struct rtl8xxxu_rxdesc24),
 	.has_s0s1 = 0,
 	.gen2_thermal_meter = 1,
+	.needs_full_init = 1,
 	.adda_1t_init = 0x0fc01616,
 	.adda_1t_path_on = 0x0fc01616,
 	.adda_2t_path_on_a = 0x0fc01616,
diff --git a/drivers/of/device.c b/drivers/of/device.c
index 64b710265d39..3255c97b14f6 100644
--- a/drivers/of/device.c
+++ b/drivers/of/device.c
@@ -257,12 +257,15 @@ int of_device_request_module(struct device *dev)
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
 
diff --git a/drivers/phy/tegra/xusb.c b/drivers/phy/tegra/xusb.c
index 9c55e0f45ea8..d0483712637b 100644
--- a/drivers/phy/tegra/xusb.c
+++ b/drivers/phy/tegra/xusb.c
@@ -596,6 +596,7 @@ static int tegra_xusb_add_usb2_port(struct tegra_xusb_padctl *padctl,
 	usb2->base.lane = usb2->base.ops->map(&usb2->base);
 	if (IS_ERR(usb2->base.lane)) {
 		err = PTR_ERR(usb2->base.lane);
+		tegra_xusb_port_unregister(&usb2->base);
 		goto out;
 	}
 
@@ -648,6 +649,7 @@ static int tegra_xusb_add_ulpi_port(struct tegra_xusb_padctl *padctl,
 	ulpi->base.lane = ulpi->base.ops->map(&ulpi->base);
 	if (IS_ERR(ulpi->base.lane)) {
 		err = PTR_ERR(ulpi->base.lane);
+		tegra_xusb_port_unregister(&ulpi->base);
 		goto out;
 	}
 
diff --git a/drivers/power/supply/generic-adc-battery.c b/drivers/power/supply/generic-adc-battery.c
index c5bde3c24c31..42a9e03744c7 100644
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
 
diff --git a/drivers/s390/block/dasd.c b/drivers/s390/block/dasd.c
index 2dbe9c25ba74..d3a11a168616 100644
--- a/drivers/s390/block/dasd.c
+++ b/drivers/s390/block/dasd.c
@@ -2899,7 +2899,7 @@ static int _dasd_requeue_request(struct dasd_ccw_req *cqr)
 		return 0;
 	spin_lock_irq(&cqr->dq->lock);
 	req = (struct request *) cqr->callback_data;
-	blk_mq_requeue_request(req, false);
+	blk_mq_requeue_request(req, true);
 	spin_unlock_irq(&cqr->dq->lock);
 
 	return 0;
diff --git a/drivers/scsi/megaraid.c b/drivers/scsi/megaraid.c
index eed6d45b8025..b6a62c8c2671 100644
--- a/drivers/scsi/megaraid.c
+++ b/drivers/scsi/megaraid.c
@@ -1443,6 +1443,7 @@ mega_cmd_done(adapter_t *adapter, u8 completed[], int nstatus, int status)
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
index 989d5eca8861..f3d52e94cf89 100644
--- a/drivers/staging/iio/resolver/ad2s1210.c
+++ b/drivers/staging/iio/resolver/ad2s1210.c
@@ -96,7 +96,7 @@ struct ad2s1210_state {
 static const int ad2s1210_mode_vals[4][2] = {
 	[MOD_POS] = { 0, 0 },
 	[MOD_VEL] = { 0, 1 },
-	[MOD_CONFIG] = { 1, 0 },
+	[MOD_CONFIG] = { 1, 1 },
 };
 
 static inline void ad2s1210_set_mode(enum ad2s1210_mode mode,
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index e1ede9fd4920..8420bdae1a5c 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -778,6 +778,7 @@ static int _rtl92e_sta_up(struct net_device *dev, bool is_silent_reset)
 	else
 		netif_wake_queue(dev);
 
+	priv->bfirst_after_down = false;
 	return 0;
 }
 
diff --git a/drivers/target/iscsi/iscsi_target.c b/drivers/target/iscsi/iscsi_target.c
index d9fcef82ddf5..d801f5b388b8 100644
--- a/drivers/target/iscsi/iscsi_target.c
+++ b/drivers/target/iscsi/iscsi_target.c
@@ -4088,9 +4088,12 @@ static void iscsit_release_commands_from_conn(struct iscsi_conn *conn)
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
@@ -4098,11 +4101,10 @@ static void iscsit_release_commands_from_conn(struct iscsi_conn *conn)
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
index b2bdc35f7495..6e8a54eb9842 100644
--- a/drivers/tty/serial/8250/8250.h
+++ b/drivers/tty/serial/8250/8250.h
@@ -221,6 +221,13 @@ extern int serial8250_rx_dma(struct uart_8250_port *);
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
@@ -236,6 +243,11 @@ static inline int serial8250_request_dma(struct uart_8250_port *p)
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
index fe1de63269d1..78af258111e5 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -23,6 +23,7 @@
 #include <linux/moduleparam.h>
 #include <linux/ioport.h>
 #include <linux/init.h>
+#include <linux/irq.h>
 #include <linux/console.h>
 #include <linux/sysrq.h>
 #include <linux/delay.h>
@@ -1886,6 +1887,7 @@ int serial8250_handle_irq(struct uart_port *port, unsigned int iir)
 	unsigned char status;
 	unsigned long flags;
 	struct uart_8250_port *up = up_to_u8250p(port);
+	struct tty_port *tport = &port->state->port;
 	bool skip_rx = false;
 
 	if (iir & UART_IIR_NO_INT)
@@ -1909,6 +1911,8 @@ int serial8250_handle_irq(struct uart_port *port, unsigned int iir)
 		skip_rx = true;
 
 	if (status & (UART_LSR_DR | UART_LSR_BI) && !skip_rx) {
+		if (irqd_is_wakeup_set(irq_get_irq_data(port->irq)))
+			pm_wakeup_event(tport->tty->dev, 0);
 		if (!up->dma || handle_rx_dma(up, iir))
 			status = serial8250_rx_chars(up, status);
 	}
@@ -1964,19 +1968,25 @@ static int serial8250_tx_threshold_handle_irq(struct uart_port *port)
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
index 20dd476e4d1a..e7ab8ec032cf 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -998,7 +998,7 @@ static inline int lpuart_start_rx_dma(struct lpuart_port *sport)
 	 * 10ms at any baud rate.
 	 */
 	sport->rx_dma_rng_buf_len = (DMA_RX_TIMEOUT * baud /  bits / 1000) * 2;
-	sport->rx_dma_rng_buf_len = (1 << (fls(sport->rx_dma_rng_buf_len) - 1));
+	sport->rx_dma_rng_buf_len = (1 << fls(sport->rx_dma_rng_buf_len));
 	if (sport->rx_dma_rng_buf_len < 16)
 		sport->rx_dma_rng_buf_len = 16;
 
diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 8cbd6fa6351f..bf834387fb0d 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -874,13 +874,13 @@ static ssize_t tty_read(struct file *file, char __user *buf, size_t count,
 	return i;
 }
 
-static void tty_write_unlock(struct tty_struct *tty)
+void tty_write_unlock(struct tty_struct *tty)
 {
 	mutex_unlock(&tty->atomic_write_lock);
 	wake_up_interruptible_poll(&tty->write_wait, POLLOUT);
 }
 
-static int tty_write_lock(struct tty_struct *tty, int ndelay)
+int tty_write_lock(struct tty_struct *tty, int ndelay)
 {
 	if (!mutex_trylock(&tty->atomic_write_lock)) {
 		if (ndelay)
diff --git a/drivers/tty/tty_ioctl.c b/drivers/tty/tty_ioctl.c
index efa96e6c4c1b..0339a3856c13 100644
--- a/drivers/tty/tty_ioctl.c
+++ b/drivers/tty/tty_ioctl.c
@@ -396,21 +396,42 @@ static int set_termios(struct tty_struct *tty, void __user *arg, int opt)
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
index 48fbb6302e60..4cacb91c4729 100644
--- a/drivers/usb/chipidea/core.c
+++ b/drivers/usb/chipidea/core.c
@@ -987,7 +987,7 @@ static int ci_hdrc_probe(struct platform_device *pdev)
 	ret = ci_usb_phy_init(ci);
 	if (ret) {
 		dev_err(dev, "unable to init phy: %d\n", ret);
-		return ret;
+		goto ulpi_exit;
 	}
 
 	ci->hw_bank.phys = res->start;
diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 5a4bd093c311..558e730d25f0 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -1348,6 +1348,7 @@ static int dwc3_remove(struct platform_device *pdev)
 	dwc3_core_exit(dwc);
 	dwc3_ulpi_exit(dwc);
 
+	pm_runtime_allow(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 	pm_runtime_put_noidle(&pdev->dev);
 	pm_runtime_set_suspended(&pdev->dev);
diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
index 4068462e0d3f..a0edba3729f6 100644
--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -598,6 +598,11 @@ static void option_instat_callback(struct urb *urb);
 #define SIERRA_VENDOR_ID			0x1199
 #define SIERRA_PRODUCT_EM9191			0x90d3
 
+/* UNISOC (Spreadtrum) products */
+#define UNISOC_VENDOR_ID			0x1782
+/* TOZED LT70-C based on UNISOC SL8563 uses UNISOC's vendor ID */
+#define TOZED_PRODUCT_LT70C			0x4055
+
 /* Device flags */
 
 /* Highest interface number which can be used with NCTRL() and RSVD() */
@@ -2227,6 +2232,7 @@ static const struct usb_device_id option_ids[] = {
 	{ USB_DEVICE_AND_INTERFACE_INFO(OPPO_VENDOR_ID, OPPO_PRODUCT_R11, 0xff, 0xff, 0x30) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(SIERRA_VENDOR_ID, SIERRA_PRODUCT_EM9191, 0xff, 0xff, 0x30) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(SIERRA_VENDOR_ID, SIERRA_PRODUCT_EM9191, 0xff, 0, 0) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(UNISOC_VENDOR_ID, TOZED_PRODUCT_LT70C, 0xff, 0, 0) },
 	{ } /* Terminating entry */
 };
 MODULE_DEVICE_TABLE(usb, option_ids);
diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 5f7eea3fa1c6..156716f9e3e2 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -5106,10 +5106,12 @@ int btrfs_del_items(struct btrfs_trans_handle *trans, struct btrfs_root *root,
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
@@ -5126,8 +5128,36 @@ int btrfs_prev_leaf(struct btrfs_root *root, struct btrfs_path *path)
 
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
index fa64a1127c97..d8255bd33d50 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -4442,6 +4442,11 @@ static long btrfs_ioctl_scrub(struct file *file, void __user *arg)
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
index f96eb176166d..e80ae2690123 100644
--- a/fs/btrfs/print-tree.c
+++ b/fs/btrfs/print-tree.c
@@ -130,10 +130,10 @@ static void print_extent_item(struct extent_buffer *eb, int slot, int type)
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
index 069eb2533e7f..dec306a3b0f4 100644
--- a/fs/cifs/smb2ops.c
+++ b/fs/cifs/smb2ops.c
@@ -891,7 +891,7 @@ smb2_copychunk_range(const unsigned int xid,
 		pcchunk->SourceOffset = cpu_to_le64(src_off);
 		pcchunk->TargetOffset = cpu_to_le64(dest_off);
 		pcchunk->Length =
-			cpu_to_le32(min_t(u32, len, tcon->max_bytes_chunk));
+			cpu_to_le32(min_t(u64, len, tcon->max_bytes_chunk));
 
 		/* Request server copy to target from src identified by key */
 		kfree(retbuf);
diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
index c8e8f37eb122..92d7778cd6c4 100644
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -38,6 +38,7 @@ static int get_max_inline_xattr_value_size(struct inode *inode,
 	struct ext4_xattr_ibody_header *header;
 	struct ext4_xattr_entry *entry;
 	struct ext4_inode *raw_inode;
+	void *end;
 	int free, min_offs;
 
 	if (!EXT4_INODE_HAS_XATTR_SPACE(inode))
@@ -61,14 +62,23 @@ static int get_max_inline_xattr_value_size(struct inode *inode,
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
@@ -354,7 +364,7 @@ static int ext4_update_inline_data(handle_t *handle, struct inode *inode,
 
 	error = ext4_xattr_ibody_get(inode, i.name_index, i.name,
 				     value, len);
-	if (error == -ENODATA)
+	if (error < 0)
 		goto out;
 
 	BUFFER_TRACE(is.iloc.bh, "get_write_access");
diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index a93bd342e0ae..d9f2fde2e3e9 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -3921,7 +3921,11 @@ ext4_mb_release_group_pa(struct ext4_buddy *e4b,
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
index aab39d10b29c..45f366408a1f 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -2343,11 +2343,9 @@ static __le16 ext4_group_desc_csum(struct super_block *sb, __u32 block_group,
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
@@ -5392,9 +5390,6 @@ static int ext4_remount(struct super_block *sb, int *flags, char *data)
 		ext4_commit_super(sb, 1);
 
 #ifdef CONFIG_QUOTA
-	/* Release old quota file names */
-	for (i = 0; i < EXT4_MAXQUOTAS; i++)
-		kfree(old_opts.s_qf_names[i]);
 	if (enable_quota) {
 		if (sb_any_quota_suspended(sb))
 			dquot_resume(sb, -1);
@@ -5404,6 +5399,9 @@ static int ext4_remount(struct super_block *sb, int *flags, char *data)
 				goto restore_opts;
 		}
 	}
+	/* Release old quota file names */
+	for (i = 0; i < EXT4_MAXQUOTAS; i++)
+		kfree(old_opts.s_qf_names[i]);
 #endif
 
 	*flags = (*flags & ~MS_LAZYTIME) | (sb->s_flags & MS_LAZYTIME);
@@ -5412,6 +5410,13 @@ static int ext4_remount(struct super_block *sb, int *flags, char *data)
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
index 4f39932ef3c8..4d55cb2cb7bd 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -2559,6 +2559,7 @@ static int ext4_xattr_move_to_block(handle_t *handle, struct inode *inode,
 		.in_inode = !!entry->e_value_inum,
 	};
 	struct ext4_xattr_ibody_header *header = IHDR(inode, raw_inode);
+	int needs_kvfree = 0;
 	int error;
 
 	is = kzalloc(sizeof(struct ext4_xattr_ibody_find), GFP_NOFS);
@@ -2581,7 +2582,7 @@ static int ext4_xattr_move_to_block(handle_t *handle, struct inode *inode,
 			error = -ENOMEM;
 			goto out;
 		}
-
+		needs_kvfree = 1;
 		error = ext4_xattr_inode_get(inode, entry, buffer, value_size);
 		if (error)
 			goto out;
@@ -2620,7 +2621,7 @@ static int ext4_xattr_move_to_block(handle_t *handle, struct inode *inode,
 
 out:
 	kfree(b_entry_name);
-	if (entry->e_value_inum && buffer)
+	if (needs_kvfree && buffer)
 		kvfree(buffer);
 	if (is)
 		brelse(is->iloc.bh);
diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index be6096f195c5..05e2fbe89219 100644
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
index 9616f7eacd4c..85e005efc977 100644
--- a/fs/nfs/nfs4state.c
+++ b/fs/nfs/nfs4state.c
@@ -65,6 +65,8 @@
 
 #define OPENOWNER_POOL_SIZE	8
 
+static void nfs4_state_start_reclaim_reboot(struct nfs_client *clp);
+
 const nfs4_stateid zero_stateid = {
 	{ .data = { 0 } },
 	.type = NFS4_SPECIAL_STATEID_TYPE,
@@ -321,6 +323,8 @@ int nfs41_init_clientid(struct nfs_client *clp, struct rpc_cred *cred)
 	status = nfs4_proc_create_session(clp, cred);
 	if (status != 0)
 		goto out;
+	if (!(clp->cl_exchange_flags & EXCHGID4_FLAG_CONFIRMED_R))
+		nfs4_state_start_reclaim_reboot(clp);
 	nfs41_finish_session_reset(clp);
 	nfs_mark_client_ready(clp, NFS_CS_READY);
 out:
diff --git a/fs/nilfs2/bmap.c b/fs/nilfs2/bmap.c
index 01fb1831ca25..147971ce4e3e 100644
--- a/fs/nilfs2/bmap.c
+++ b/fs/nilfs2/bmap.c
@@ -76,20 +76,28 @@ int nilfs_bmap_lookup_at_level(struct nilfs_bmap *bmap, __u64 key, int level,
 
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
index 368b8ee5a316..bc0f8f837c37 100644
--- a/fs/nilfs2/segment.c
+++ b/fs/nilfs2/segment.c
@@ -2052,6 +2052,9 @@ static int nilfs_segctor_do_construct(struct nilfs_sc_info *sci, int mode)
 	struct the_nilfs *nilfs = sci->sc_super->s_fs_info;
 	int err;
 
+	if (sb_rdonly(sci->sc_super))
+		return -EROFS;
+
 	nilfs_sc_cstage_set(sci, NILFS_ST_INIT);
 	sci->sc_cno = nilfs->ns_cno;
 
@@ -2738,7 +2741,7 @@ static void nilfs_segctor_write_out(struct nilfs_sc_info *sci)
 
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
index 99e3692264ae..83822f281cdf 100644
--- a/fs/ubifs/dir.c
+++ b/fs/ubifs/dir.c
@@ -462,6 +462,7 @@ static int do_tmpfile(struct inode *dir, struct dentry *dentry,
 	mutex_unlock(&dir_ui->ui_mutex);
 
 	ubifs_release_budget(c, &req);
+	fscrypt_free_filename(&nm);
 
 	return 0;
 
diff --git a/fs/ubifs/tnc.c b/fs/ubifs/tnc.c
index 6c4af1cfce34..20b70e178c4f 100644
--- a/fs/ubifs/tnc.c
+++ b/fs/ubifs/tnc.c
@@ -279,18 +279,11 @@ static struct ubifs_znode *dirty_cow_znode(struct ubifs_info *c,
 	if (zbr->len) {
 		err = insert_old_idx(c, zbr->lnum, zbr->offs);
 		if (unlikely(err))
-			/*
-			 * Obsolete znodes will be freed by tnc_destroy_cnext()
-			 * or free_obsolete_znodes(), copied up znodes should
-			 * be added back to tnc and freed by
-			 * ubifs_destroy_tnc_subtree().
-			 */
-			goto out;
+			return ERR_PTR(err);
 		err = add_idx_dirt(c, zbr->lnum, zbr->len);
 	} else
 		err = 0;
 
-out:
 	zbr->znode = zn;
 	zbr->lnum = 0;
 	zbr->offs = 0;
diff --git a/include/linux/printk.h b/include/linux/printk.h
index 6106befed756..77429d3eb0de 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -528,4 +528,23 @@ static inline void print_hex_dump_debug(const char *prefix_str, int prefix_type,
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
index c9548a63d09b..0f7c8f820aa3 100644
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
diff --git a/include/linux/tty.h b/include/linux/tty.h
index 641c93acc557..33a9dbe74a06 100644
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -479,6 +479,8 @@ extern void __stop_tty(struct tty_struct *tty);
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
index 3107895115c2..2db486e9724c 100644
--- a/include/net/netfilter/nf_tables.h
+++ b/include/net/netfilter/nf_tables.h
@@ -383,6 +383,7 @@ void nft_unregister_set(struct nft_set_type *type);
  * 	@dtype: data type (verdict or numeric type defined by userspace)
  * 	@objtype: object type (see NFT_OBJECT_* definitions)
  * 	@size: maximum set size
+ *	@use: number of rules references to this set
  * 	@nelems: number of elements
  * 	@ndeact: number of deactivated elements queued for removal
  *	@timeout: default timeout value in jiffies
@@ -405,6 +406,7 @@ struct nft_set {
 	u32				dtype;
 	u32				objtype;
 	u32				size;
+	u32				use;
 	atomic_t			nelems;
 	u32				ndeact;
 	u64				timeout;
@@ -459,10 +461,16 @@ struct nft_set_binding {
 	u32				flags;
 };
 
+enum nft_trans_phase;
+void nf_tables_activate_set(const struct nft_ctx *ctx, struct nft_set *set);
+void nf_tables_deactivate_set(const struct nft_ctx *ctx, struct nft_set *set,
+			      struct nft_set_binding *binding,
+			      enum nft_trans_phase phase);
 int nf_tables_bind_set(const struct nft_ctx *ctx, struct nft_set *set,
 		       struct nft_set_binding *binding);
 void nf_tables_unbind_set(const struct nft_ctx *ctx, struct nft_set *set,
-			  struct nft_set_binding *binding);
+			  struct nft_set_binding *binding, bool commit);
+void nf_tables_destroy_set(const struct nft_ctx *ctx, struct nft_set *set);
 
 /**
  *	enum nft_set_extensions - set extension type IDs
@@ -710,13 +718,22 @@ struct nft_expr_type {
 
 #define NFT_EXPR_STATEFUL		0x1
 
+enum nft_trans_phase {
+	NFT_TRANS_PREPARE,
+	NFT_TRANS_ABORT,
+	NFT_TRANS_COMMIT,
+	NFT_TRANS_RELEASE
+};
+
 /**
  *	struct nft_expr_ops - nf_tables expression operations
  *
  *	@eval: Expression evaluation function
  *	@size: full expression size, including private data size
  *	@init: initialization function
- *	@destroy: destruction function
+ *	@activate: activate expression in the next generation
+ *	@deactivate: deactivate expression in next generation
+ *	@destroy: destruction function, called after synchronize_rcu
  *	@dump: function to dump parameters
  *	@type: expression type
  *	@validate: validate expression, called during loop detection
@@ -737,7 +754,8 @@ struct nft_expr_ops {
 	void				(*activate)(const struct nft_ctx *ctx,
 						    const struct nft_expr *expr);
 	void				(*deactivate)(const struct nft_ctx *ctx,
-						      const struct nft_expr *expr);
+						      const struct nft_expr *expr,
+						      enum nft_trans_phase phase);
 	void				(*destroy)(const struct nft_ctx *ctx,
 						   const struct nft_expr *expr);
 	int				(*dump)(struct sk_buff *skb,
@@ -1285,12 +1303,15 @@ struct nft_trans_rule {
 struct nft_trans_set {
 	struct nft_set			*set;
 	u32				set_id;
+	bool				bound;
 };
 
 #define nft_trans_set(trans)	\
 	(((struct nft_trans_set *)trans->data)->set)
 #define nft_trans_set_id(trans)	\
 	(((struct nft_trans_set *)trans->data)->set_id)
+#define nft_trans_set_bound(trans)	\
+	(((struct nft_trans_set *)trans->data)->bound)
 
 struct nft_trans_chain {
 	bool				update;
@@ -1321,12 +1342,15 @@ struct nft_trans_table {
 struct nft_trans_elem {
 	struct nft_set			*set;
 	struct nft_set_elem		elem;
+	bool				bound;
 };
 
 #define nft_trans_elem_set(trans)	\
 	(((struct nft_trans_elem *)trans->data)->set)
 #define nft_trans_elem(trans)	\
 	(((struct nft_trans_elem *)trans->data)->elem)
+#define nft_trans_elem_set_bound(trans)	\
+	(((struct nft_trans_elem *)trans->data)->bound)
 
 struct nft_trans_obj {
 	struct nft_object		*obj;
diff --git a/include/net/scm.h b/include/net/scm.h
index 903771c8d4e3..1268a051f1aa 100644
--- a/include/net/scm.h
+++ b/include/net/scm.h
@@ -104,16 +104,27 @@ static inline void scm_passec(struct socket *sock, struct msghdr *msg, struct sc
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
diff --git a/include/uapi/linux/btrfs.h b/include/uapi/linux/btrfs.h
index 6cdfd12cd14c..86d2a52b4665 100644
--- a/include/uapi/linux/btrfs.h
+++ b/include/uapi/linux/btrfs.h
@@ -161,6 +161,7 @@ struct btrfs_scrub_progress {
 };
 
 #define BTRFS_SCRUB_READONLY	1
+#define BTRFS_SCRUB_SUPPORTED_FLAGS	(BTRFS_SCRUB_READONLY)
 struct btrfs_ioctl_scrub_args {
 	__u64 devid;				/* in */
 	__u64 start;				/* in */
diff --git a/include/uapi/linux/const.h b/include/uapi/linux/const.h
index 0bd39530b2e3..4ef7c87d1249 100644
--- a/include/uapi/linux/const.h
+++ b/include/uapi/linux/const.h
@@ -28,7 +28,7 @@
 #define _BITUL(x)	(_AC(1,UL) << (x))
 #define _BITULL(x)	(_AC(1,ULL) << (x))
 
-#define __ALIGN_KERNEL(x, a)		__ALIGN_KERNEL_MASK(x, (typeof(x))(a) - 1)
+#define __ALIGN_KERNEL(x, a)		__ALIGN_KERNEL_MASK(x, (__typeof__(x))(a) - 1)
 #define __ALIGN_KERNEL_MASK(x, mask)	(((x) + (mask)) & ~(mask))
 
 #define __KERNEL_DIV_ROUND_UP(n, d) (((n) + (d) - 1) / (d))
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 392e48bbba44..20ba0d90e8ae 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7490,8 +7490,8 @@ __perf_event_account_interrupt(struct perf_event *event, int throttle)
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
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 567e96492ed9..f234c63b59fc 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -1269,6 +1269,8 @@ static void rb_free_cpu_buffer(struct ring_buffer_per_cpu *cpu_buffer)
 	struct list_head *head = cpu_buffer->pages;
 	struct buffer_page *bpage, *tmp;
 
+	irq_work_sync(&cpu_buffer->irq_work.work);
+
 	free_buffer_page(cpu_buffer->reader_page);
 
 	if (head) {
@@ -1374,6 +1376,8 @@ ring_buffer_free(struct ring_buffer *buffer)
 
 	cpuhp_state_remove_instance(CPUHP_TRACE_RB_PREPARE, &buffer->node);
 
+	irq_work_sync(&buffer->irq_work.work);
+
 	for_each_buffer_cpu(buffer, cpu)
 		rb_free_cpu_buffer(buffer->buffers[cpu]);
 
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index f88307fee38d..7163cf682582 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5213,7 +5213,21 @@ static void __build_all_zonelists(void *data)
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
@@ -5248,6 +5262,8 @@ static void __build_all_zonelists(void *data)
 	}
 
 	write_sequnlock(&zonelist_update_seq);
+	printk_deferred_exit();
+	local_irq_restore(flags);
 }
 
 static noinline void __init
diff --git a/net/8021q/vlan_dev.c b/net/8021q/vlan_dev.c
index ed3717dc2d20..e871d3b27c47 100644
--- a/net/8021q/vlan_dev.c
+++ b/net/8021q/vlan_dev.c
@@ -367,7 +367,7 @@ static int vlan_dev_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
 
 	switch (cmd) {
 	case SIOCSHWTSTAMP:
-		if (!net_eq(dev_net(dev), &init_net))
+		if (!net_eq(dev_net(dev), dev_net(real_dev)))
 			break;
 	case SIOCGMIIPHY:
 	case SIOCGMIIREG:
diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index ed6fcfe62f7c..837b0767892e 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -984,7 +984,14 @@ static int hci_sock_ioctl(struct socket *sock, unsigned int cmd,
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
index 9dae8009b407..71827da47274 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -4420,6 +4420,9 @@ void __skb_tstamp_tx(struct sk_buff *orig_skb,
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
index aab18ab49e3b..c5c9dc0f41cb 100644
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -1415,9 +1415,19 @@ struct sk_buff *__ip_make_skb(struct sock *sk,
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
index e5baf5e4782b..f24a6cd0d15a 100644
--- a/net/ipv6/sit.c
+++ b/net/ipv6/sit.c
@@ -1039,12 +1039,13 @@ static netdev_tx_t sit_tunnel_xmit(struct sk_buff *skb,
 
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
@@ -1067,14 +1068,15 @@ static void ipip6_tunnel_bind_dev(struct net_device *dev)
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
index b24c83cf64b9..c683a45b8ae5 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -140,6 +140,28 @@ static void nft_trans_destroy(struct nft_trans *trans)
 	kfree(trans);
 }
 
+static void nft_set_trans_bind(const struct nft_ctx *ctx, struct nft_set *set)
+{
+	struct net *net = ctx->net;
+	struct nft_trans *trans;
+
+	if (!(set->flags & NFT_SET_ANONYMOUS))
+		return;
+
+	list_for_each_entry_reverse(trans, &net->nft.commit_list, list) {
+		switch (trans->msg_type) {
+		case NFT_MSG_NEWSET:
+			if (nft_trans_set(trans) == set)
+				nft_trans_set_bound(trans) = true;
+			break;
+		case NFT_MSG_NEWSETELEM:
+			if (nft_trans_elem_set(trans) == set)
+				nft_trans_elem_set_bound(trans) = true;
+			break;
+		}
+	}
+}
+
 static int nf_tables_register_hooks(struct net *net,
 				    const struct nft_table *table,
 				    struct nft_chain *chain,
@@ -221,18 +243,6 @@ static int nft_delchain(struct nft_ctx *ctx)
 	return err;
 }
 
-/* either expr ops provide both activate/deactivate, or neither */
-static bool nft_expr_check_ops(const struct nft_expr_ops *ops)
-{
-	if (!ops)
-		return true;
-
-	if (WARN_ON_ONCE((!ops->activate ^ !ops->deactivate)))
-		return false;
-
-	return true;
-}
-
 static void nft_rule_expr_activate(const struct nft_ctx *ctx,
 				   struct nft_rule *rule)
 {
@@ -248,14 +258,15 @@ static void nft_rule_expr_activate(const struct nft_ctx *ctx,
 }
 
 static void nft_rule_expr_deactivate(const struct nft_ctx *ctx,
-				     struct nft_rule *rule)
+				     struct nft_rule *rule,
+				     enum nft_trans_phase phase)
 {
 	struct nft_expr *expr;
 
 	expr = nft_expr_first(rule);
 	while (expr != nft_expr_last(rule) && expr->ops) {
 		if (expr->ops->deactivate)
-			expr->ops->deactivate(ctx, expr);
+			expr->ops->deactivate(ctx, expr, phase);
 
 		expr = nft_expr_next(expr);
 	}
@@ -306,7 +317,7 @@ static int nft_delrule(struct nft_ctx *ctx, struct nft_rule *rule)
 		nft_trans_destroy(trans);
 		return err;
 	}
-	nft_rule_expr_deactivate(ctx, rule);
+	nft_rule_expr_deactivate(ctx, rule, NFT_TRANS_PREPARE);
 
 	return 0;
 }
@@ -327,7 +338,7 @@ static int nft_delrule_by_chain(struct nft_ctx *ctx)
 	return 0;
 }
 
-static int nft_trans_set_add(struct nft_ctx *ctx, int msg_type,
+static int nft_trans_set_add(const struct nft_ctx *ctx, int msg_type,
 			     struct nft_set *set)
 {
 	struct nft_trans *trans;
@@ -347,7 +358,7 @@ static int nft_trans_set_add(struct nft_ctx *ctx, int msg_type,
 	return 0;
 }
 
-static int nft_delset(struct nft_ctx *ctx, struct nft_set *set)
+static int nft_delset(const struct nft_ctx *ctx, struct nft_set *set)
 {
 	int err;
 
@@ -1737,9 +1748,6 @@ static int nf_tables_delchain(struct net *net, struct sock *nlsk,
  */
 int nft_register_expr(struct nft_expr_type *type)
 {
-	if (!nft_expr_check_ops(type->ops))
-		return -EINVAL;
-
 	nfnl_lock(NFNL_SUBSYS_NFTABLES);
 	if (type->family == NFPROTO_UNSPEC)
 		list_add_tail_rcu(&type->list, &nf_tables_expressions);
@@ -1889,10 +1897,6 @@ static int nf_tables_expr_parse(const struct nft_ctx *ctx,
 			err = PTR_ERR(ops);
 			goto err1;
 		}
-		if (!nft_expr_check_ops(ops)) {
-			err = -EINVAL;
-			goto err1;
-		}
 	} else
 		ops = type->ops;
 
@@ -2297,7 +2301,7 @@ static void nf_tables_rule_destroy(const struct nft_ctx *ctx,
 static void nf_tables_rule_release(const struct nft_ctx *ctx,
 				   struct nft_rule *rule)
 {
-	nft_rule_expr_deactivate(ctx, rule);
+	nft_rule_expr_deactivate(ctx, rule, NFT_TRANS_RELEASE);
 	nf_tables_rule_destroy(ctx, rule);
 }
 
@@ -3305,19 +3309,15 @@ static int nf_tables_newset(struct net *net, struct sock *nlsk,
 
 static void nft_set_destroy(struct nft_set *set)
 {
+	if (WARN_ON(set->use > 0))
+		return;
+
 	set->ops->destroy(set);
 	module_put(set->ops->type->owner);
 	kfree(set->name);
 	kvfree(set);
 }
 
-static void nf_tables_set_destroy(const struct nft_ctx *ctx, struct nft_set *set)
-{
-	list_del_rcu(&set->list);
-	nf_tables_set_notify(ctx, set, NFT_MSG_DELSET, GFP_ATOMIC);
-	nft_set_destroy(set);
-}
-
 static int nf_tables_delset(struct net *net, struct sock *nlsk,
 			    struct sk_buff *skb, const struct nlmsghdr *nlh,
 			    const struct nlattr * const nla[],
@@ -3342,7 +3342,7 @@ static int nf_tables_delset(struct net *net, struct sock *nlsk,
 	if (IS_ERR(set))
 		return PTR_ERR(set);
 
-	if (!list_empty(&set->bindings) ||
+	if (set->use ||
 	    (nlh->nlmsg_flags & NLM_F_NONREC && atomic_read(&set->nelems) > 0))
 		return -EBUSY;
 
@@ -3370,6 +3370,9 @@ int nf_tables_bind_set(const struct nft_ctx *ctx, struct nft_set *set,
 	struct nft_set_binding *i;
 	struct nft_set_iter iter;
 
+	if (set->use == UINT_MAX)
+		return -EOVERFLOW;
+
 	if (!list_empty(&set->bindings) && set->flags & NFT_SET_ANONYMOUS)
 		return -EBUSY;
 
@@ -3396,21 +3399,65 @@ int nf_tables_bind_set(const struct nft_ctx *ctx, struct nft_set *set,
 bind:
 	binding->chain = ctx->chain;
 	list_add_tail_rcu(&binding->list, &set->bindings);
+	nft_set_trans_bind(ctx, set);
+	set->use++;
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(nf_tables_bind_set);
 
 void nf_tables_unbind_set(const struct nft_ctx *ctx, struct nft_set *set,
-			  struct nft_set_binding *binding)
+			  struct nft_set_binding *binding, bool event)
 {
 	list_del_rcu(&binding->list);
 
-	if (list_empty(&set->bindings) && set->flags & NFT_SET_ANONYMOUS &&
-	    nft_is_active(ctx->net, set))
-		nf_tables_set_destroy(ctx, set);
+	if (list_empty(&set->bindings) && set->flags & NFT_SET_ANONYMOUS) {
+		list_del_rcu(&set->list);
+		if (event)
+			nf_tables_set_notify(ctx, set, NFT_MSG_DELSET,
+					     GFP_KERNEL);
+	}
 }
 EXPORT_SYMBOL_GPL(nf_tables_unbind_set);
 
+void nf_tables_activate_set(const struct nft_ctx *ctx, struct nft_set *set)
+{
+	if (set->flags & NFT_SET_ANONYMOUS)
+		nft_clear(ctx->net, set);
+
+	set->use++;
+}
+EXPORT_SYMBOL_GPL(nf_tables_activate_set);
+
+void nf_tables_deactivate_set(const struct nft_ctx *ctx, struct nft_set *set,
+			      struct nft_set_binding *binding,
+			      enum nft_trans_phase phase)
+{
+	switch (phase) {
+	case NFT_TRANS_PREPARE:
+		if (set->flags & NFT_SET_ANONYMOUS)
+			nft_deactivate_next(ctx->net, set);
+
+		set->use--;
+		return;
+	case NFT_TRANS_ABORT:
+	case NFT_TRANS_RELEASE:
+		set->use--;
+		/* fall through */
+	default:
+		nf_tables_unbind_set(ctx, set, binding,
+				     phase == NFT_TRANS_COMMIT);
+	}
+}
+EXPORT_SYMBOL_GPL(nf_tables_deactivate_set);
+
+void nf_tables_destroy_set(const struct nft_ctx *ctx, struct nft_set *set)
+{
+	if (list_empty(&set->bindings) && set->flags & NFT_SET_ANONYMOUS)
+		nft_set_destroy(set);
+}
+EXPORT_SYMBOL_GPL(nf_tables_destroy_set);
+
 const struct nft_set_ext_type nft_set_ext_types[] = {
 	[NFT_SET_EXT_KEY]		= {
 		.align	= __alignof__(u32),
@@ -5183,6 +5230,9 @@ static int nf_tables_commit(struct net *net, struct sk_buff *skb)
 			nf_tables_rule_notify(&trans->ctx,
 					      nft_trans_rule(trans),
 					      NFT_MSG_DELRULE);
+			nft_rule_expr_deactivate(&trans->ctx,
+						 nft_trans_rule(trans),
+						 NFT_TRANS_COMMIT);
 			break;
 		case NFT_MSG_NEWSET:
 			nft_clear(net, nft_trans_set(trans));
@@ -5260,7 +5310,8 @@ static void nf_tables_abort_release(struct nft_trans *trans)
 		nf_tables_rule_destroy(&trans->ctx, nft_trans_rule(trans));
 		break;
 	case NFT_MSG_NEWSET:
-		nft_set_destroy(nft_trans_set(trans));
+		if (!nft_trans_set_bound(trans))
+			nft_set_destroy(nft_trans_set(trans));
 		break;
 	case NFT_MSG_NEWSETELEM:
 		nft_set_elem_destroy(nft_trans_elem_set(trans),
@@ -5320,7 +5371,9 @@ static int nf_tables_abort(struct net *net, struct sk_buff *skb)
 		case NFT_MSG_NEWRULE:
 			trans->ctx.chain->use--;
 			list_del_rcu(&nft_trans_rule(trans)->list);
-			nft_rule_expr_deactivate(&trans->ctx, nft_trans_rule(trans));
+			nft_rule_expr_deactivate(&trans->ctx,
+						 nft_trans_rule(trans),
+						 NFT_TRANS_ABORT);
 			break;
 		case NFT_MSG_DELRULE:
 			trans->ctx.chain->use++;
@@ -5330,6 +5383,10 @@ static int nf_tables_abort(struct net *net, struct sk_buff *skb)
 			break;
 		case NFT_MSG_NEWSET:
 			trans->ctx.table->use--;
+			if (nft_trans_set_bound(trans)) {
+				nft_trans_destroy(trans);
+				break;
+			}
 			list_del_rcu(&nft_trans_set(trans)->list);
 			break;
 		case NFT_MSG_DELSET:
@@ -5338,6 +5395,10 @@ static int nf_tables_abort(struct net *net, struct sk_buff *skb)
 			nft_trans_destroy(trans);
 			break;
 		case NFT_MSG_NEWSETELEM:
+			if (nft_trans_elem_set_bound(trans)) {
+				nft_trans_destroy(trans);
+				break;
+			}
 			te = (struct nft_trans_elem *)trans->data;
 
 			te->set->ops->remove(net, te->set, &te->elem);
diff --git a/net/netfilter/nft_dynset.c b/net/netfilter/nft_dynset.c
index f8688f9bf46c..74e8fdaa3432 100644
--- a/net/netfilter/nft_dynset.c
+++ b/net/netfilter/nft_dynset.c
@@ -223,14 +223,32 @@ static int nft_dynset_init(const struct nft_ctx *ctx,
 	return err;
 }
 
+static void nft_dynset_deactivate(const struct nft_ctx *ctx,
+				  const struct nft_expr *expr,
+				  enum nft_trans_phase phase)
+{
+	struct nft_dynset *priv = nft_expr_priv(expr);
+
+	nf_tables_deactivate_set(ctx, priv->set, &priv->binding, phase);
+}
+
+static void nft_dynset_activate(const struct nft_ctx *ctx,
+				const struct nft_expr *expr)
+{
+	struct nft_dynset *priv = nft_expr_priv(expr);
+
+	nf_tables_activate_set(ctx, priv->set);
+}
+
 static void nft_dynset_destroy(const struct nft_ctx *ctx,
 			       const struct nft_expr *expr)
 {
 	struct nft_dynset *priv = nft_expr_priv(expr);
 
-	nf_tables_unbind_set(ctx, priv->set, &priv->binding);
 	if (priv->expr != NULL)
 		nft_expr_destroy(ctx, priv->expr);
+
+	nf_tables_destroy_set(ctx, priv->set);
 }
 
 static int nft_dynset_dump(struct sk_buff *skb, const struct nft_expr *expr)
@@ -267,6 +285,8 @@ static const struct nft_expr_ops nft_dynset_ops = {
 	.eval		= nft_dynset_eval,
 	.init		= nft_dynset_init,
 	.destroy	= nft_dynset_destroy,
+	.activate	= nft_dynset_activate,
+	.deactivate	= nft_dynset_deactivate,
 	.dump		= nft_dynset_dump,
 };
 
diff --git a/net/netfilter/nft_immediate.c b/net/netfilter/nft_immediate.c
index aa87ff8beae8..86fd35018b4a 100644
--- a/net/netfilter/nft_immediate.c
+++ b/net/netfilter/nft_immediate.c
@@ -78,10 +78,14 @@ static void nft_immediate_activate(const struct nft_ctx *ctx,
 }
 
 static void nft_immediate_deactivate(const struct nft_ctx *ctx,
-				     const struct nft_expr *expr)
+				     const struct nft_expr *expr,
+				     enum nft_trans_phase phase)
 {
 	const struct nft_immediate_expr *priv = nft_expr_priv(expr);
 
+	if (phase == NFT_TRANS_COMMIT)
+		return;
+
 	return nft_data_release(&priv->data, nft_dreg_to_type(priv->dreg));
 }
 
diff --git a/net/netfilter/nft_lookup.c b/net/netfilter/nft_lookup.c
index 44015a151ad6..4fcbe51e88c7 100644
--- a/net/netfilter/nft_lookup.c
+++ b/net/netfilter/nft_lookup.c
@@ -118,12 +118,29 @@ static int nft_lookup_init(const struct nft_ctx *ctx,
 	return 0;
 }
 
+static void nft_lookup_deactivate(const struct nft_ctx *ctx,
+				  const struct nft_expr *expr,
+				  enum nft_trans_phase phase)
+{
+	struct nft_lookup *priv = nft_expr_priv(expr);
+
+	nf_tables_deactivate_set(ctx, priv->set, &priv->binding, phase);
+}
+
+static void nft_lookup_activate(const struct nft_ctx *ctx,
+				const struct nft_expr *expr)
+{
+	struct nft_lookup *priv = nft_expr_priv(expr);
+
+	nf_tables_activate_set(ctx, priv->set);
+}
+
 static void nft_lookup_destroy(const struct nft_ctx *ctx,
 			       const struct nft_expr *expr)
 {
 	struct nft_lookup *priv = nft_expr_priv(expr);
 
-	nf_tables_unbind_set(ctx, priv->set, &priv->binding);
+	nf_tables_destroy_set(ctx, priv->set);
 }
 
 static int nft_lookup_dump(struct sk_buff *skb, const struct nft_expr *expr)
@@ -151,6 +168,8 @@ static const struct nft_expr_ops nft_lookup_ops = {
 	.size		= NFT_EXPR_SIZE(sizeof(struct nft_lookup)),
 	.eval		= nft_lookup_eval,
 	.init		= nft_lookup_init,
+	.activate	= nft_lookup_activate,
+	.deactivate	= nft_lookup_deactivate,
 	.destroy	= nft_lookup_destroy,
 	.dump		= nft_lookup_dump,
 };
diff --git a/net/netfilter/nft_objref.c b/net/netfilter/nft_objref.c
index 7bcdc48f3d73..49a067a67e72 100644
--- a/net/netfilter/nft_objref.c
+++ b/net/netfilter/nft_objref.c
@@ -154,12 +154,29 @@ static int nft_objref_map_dump(struct sk_buff *skb, const struct nft_expr *expr)
 	return -1;
 }
 
+static void nft_objref_map_deactivate(const struct nft_ctx *ctx,
+				      const struct nft_expr *expr,
+				      enum nft_trans_phase phase)
+{
+	struct nft_objref_map *priv = nft_expr_priv(expr);
+
+	nf_tables_deactivate_set(ctx, priv->set, &priv->binding, phase);
+}
+
+static void nft_objref_map_activate(const struct nft_ctx *ctx,
+				    const struct nft_expr *expr)
+{
+	struct nft_objref_map *priv = nft_expr_priv(expr);
+
+	nf_tables_activate_set(ctx, priv->set);
+}
+
 static void nft_objref_map_destroy(const struct nft_ctx *ctx,
 				   const struct nft_expr *expr)
 {
 	struct nft_objref_map *priv = nft_expr_priv(expr);
 
-	nf_tables_unbind_set(ctx, priv->set, &priv->binding);
+	nf_tables_destroy_set(ctx, priv->set);
 }
 
 static struct nft_expr_type nft_objref_type;
@@ -168,6 +185,8 @@ static const struct nft_expr_ops nft_objref_map_ops = {
 	.size		= NFT_EXPR_SIZE(sizeof(struct nft_objref_map)),
 	.eval		= nft_objref_map_eval,
 	.init		= nft_objref_map_init,
+	.activate	= nft_objref_map_activate,
+	.deactivate	= nft_objref_map_deactivate,
 	.destroy	= nft_objref_map_destroy,
 	.dump		= nft_objref_map_dump,
 };
diff --git a/net/netfilter/nft_set_hash.c b/net/netfilter/nft_set_hash.c
index a684234bd229..eb7db31dd173 100644
--- a/net/netfilter/nft_set_hash.c
+++ b/net/netfilter/nft_set_hash.c
@@ -520,7 +520,7 @@ static void *nft_hash_deactivate(const struct net *net,
 	hash = nft_jhash(set, priv, &this->ext);
 	hlist_for_each_entry(he, &priv->table[hash], node) {
 		if (!memcmp(nft_set_ext_key(&this->ext), &elem->key.val,
-			    set->klen) ||
+			    set->klen) &&
 		    nft_set_elem_active(&he->ext, genmask)) {
 			nft_set_elem_change_active(net, set, &he->ext);
 			return he;
diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index 1be5fb6af017..2089da69da10 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -1995,7 +1995,7 @@ static int packet_sendmsg_spkt(struct socket *sock, struct msghdr *msg,
 		goto retry;
 	}
 
-	if (!dev_validate_header(dev, skb->data, len)) {
+	if (!dev_validate_header(dev, skb->data, len) || !skb->len) {
 		err = -EINVAL;
 		goto out_unlock;
 	}
@@ -2144,7 +2144,7 @@ static int packet_rcv(struct sk_buff *skb, struct net_device *dev,
 	sll = &PACKET_SKB_CB(skb)->sa.ll;
 	sll->sll_hatype = dev->type;
 	sll->sll_pkttype = skb->pkt_type;
-	if (unlikely(po->origdev))
+	if (unlikely(packet_sock_flag(po, PACKET_SOCK_ORIGDEV)))
 		sll->sll_ifindex = orig_dev->ifindex;
 	else
 		sll->sll_ifindex = dev->ifindex;
@@ -2410,7 +2410,7 @@ static int tpacket_rcv(struct sk_buff *skb, struct net_device *dev,
 	sll->sll_hatype = dev->type;
 	sll->sll_protocol = skb->protocol;
 	sll->sll_pkttype = skb->pkt_type;
-	if (unlikely(po->origdev))
+	if (unlikely(packet_sock_flag(po, PACKET_SOCK_ORIGDEV)))
 		sll->sll_ifindex = orig_dev->ifindex;
 	else
 		sll->sll_ifindex = dev->ifindex;
@@ -3480,7 +3480,7 @@ static int packet_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
 		memcpy(msg->msg_name, &PACKET_SKB_CB(skb)->sa, copy_len);
 	}
 
-	if (pkt_sk(sk)->auxdata) {
+	if (packet_sock_flag(pkt_sk(sk), PACKET_SOCK_AUXDATA)) {
 		struct tpacket_auxdata aux;
 
 		aux.tp_status = TP_STATUS_USER;
@@ -3865,9 +3865,7 @@ packet_setsockopt(struct socket *sock, int level, int optname, char __user *optv
 		if (copy_from_user(&val, optval, sizeof(val)))
 			return -EFAULT;
 
-		lock_sock(sk);
-		po->auxdata = !!val;
-		release_sock(sk);
+		packet_sock_flag_set(po, PACKET_SOCK_AUXDATA, val);
 		return 0;
 	}
 	case PACKET_ORIGDEV:
@@ -3879,9 +3877,7 @@ packet_setsockopt(struct socket *sock, int level, int optname, char __user *optv
 		if (copy_from_user(&val, optval, sizeof(val)))
 			return -EFAULT;
 
-		lock_sock(sk);
-		po->origdev = !!val;
-		release_sock(sk);
+		packet_sock_flag_set(po, PACKET_SOCK_ORIGDEV, val);
 		return 0;
 	}
 	case PACKET_VNET_HDR:
@@ -4011,10 +4007,10 @@ static int packet_getsockopt(struct socket *sock, int level, int optname,
 
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
diff --git a/net/sched/act_mirred.c b/net/sched/act_mirred.c
index dcfaa4f9c7c5..0a032c4d26b8 100644
--- a/net/sched/act_mirred.c
+++ b/net/sched/act_mirred.c
@@ -181,7 +181,7 @@ static int tcf_mirred(struct sk_buff *skb, const struct tc_action *a,
 		goto out;
 	}
 
-	if (unlikely(!(dev->flags & IFF_UP))) {
+	if (unlikely(!(dev->flags & IFF_UP)) || !netif_carrier_ok(dev)) {
 		net_notice_ratelimited("tc mirred to Houston: device %s is down\n",
 				       dev->name);
 		goto out;
diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index 411925b043cc..de917d45e512 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -1827,9 +1827,6 @@ call_bind_status(struct rpc_task *task)
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
index 4e0ebb4780df..b368f5aabe29 100644
--- a/net/sunrpc/sched.c
+++ b/net/sunrpc/sched.c
@@ -697,7 +697,6 @@ rpc_init_task_statistics(struct rpc_task *task)
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
diff --git a/sound/usb/caiaq/input.c b/sound/usb/caiaq/input.c
index 4b3fb91deecd..0898d2dd14e4 100644
--- a/sound/usb/caiaq/input.c
+++ b/sound/usb/caiaq/input.c
@@ -808,6 +808,7 @@ int snd_usb_caiaq_input_init(struct snd_usb_caiaqdev *cdev)
 
 	default:
 		/* no input methods supported on this device */
+		ret = -EINVAL;
 		goto exit_free_idev;
 	}
 
diff --git a/tools/perf/bench/bench.h b/tools/perf/bench/bench.h
index 80208ac07771..71010922cd4d 100644
--- a/tools/perf/bench/bench.h
+++ b/tools/perf/bench/bench.h
@@ -2,6 +2,10 @@
 #ifndef BENCH_H
 #define BENCH_H
 
+#include <sys/time.h>
+
+extern struct timeval bench__start, bench__end, bench__runtime;
+
 /*
  * The madvise transparent hugepage constants were added in glibc
  * 2.13. For compatibility with older versions of glibc, define these
diff --git a/tools/perf/bench/futex-hash.c b/tools/perf/bench/futex-hash.c
index 58ae6ed8f38b..0f683fed4cdd 100644
--- a/tools/perf/bench/futex-hash.c
+++ b/tools/perf/bench/futex-hash.c
@@ -35,7 +35,7 @@ static unsigned int nfutexes = 1024;
 static bool fshared = false, done = false, silent = false;
 static int futex_flag = 0;
 
-struct timeval start, end, runtime;
+struct timeval bench__start, bench__end, bench__runtime;
 static pthread_mutex_t thread_lock;
 static unsigned int threads_starting;
 static struct stats throughput_stats;
@@ -101,8 +101,8 @@ static void toggle_done(int sig __maybe_unused,
 {
 	/* inform all threads that we're done for the day */
 	done = true;
-	gettimeofday(&end, NULL);
-	timersub(&end, &start, &runtime);
+	gettimeofday(&bench__end, NULL);
+	timersub(&bench__end, &bench__start, &bench__runtime);
 }
 
 static void print_summary(void)
@@ -112,7 +112,7 @@ static void print_summary(void)
 
 	printf("%sAveraged %ld operations/sec (+- %.2f%%), total secs = %d\n",
 	       !silent ? "\n" : "", avg, rel_stddev_stats(stddev, avg),
-	       (int) runtime.tv_sec);
+	       (int)bench__runtime.tv_sec);
 }
 
 int bench_futex_hash(int argc, const char **argv)
@@ -156,7 +156,7 @@ int bench_futex_hash(int argc, const char **argv)
 
 	threads_starting = nthreads;
 	pthread_attr_init(&thread_attr);
-	gettimeofday(&start, NULL);
+	gettimeofday(&bench__start, NULL);
 	for (i = 0; i < nthreads; i++) {
 		worker[i].tid = i;
 		worker[i].futex = calloc(nfutexes, sizeof(*worker[i].futex));
@@ -199,7 +199,7 @@ int bench_futex_hash(int argc, const char **argv)
 	pthread_mutex_destroy(&thread_lock);
 
 	for (i = 0; i < nthreads; i++) {
-		unsigned long t = worker[i].ops/runtime.tv_sec;
+		unsigned long t = worker[i].ops / bench__runtime.tv_sec;
 		update_stats(&throughput_stats, t);
 		if (!silent) {
 			if (nfutexes == 1)
diff --git a/tools/perf/bench/futex-lock-pi.c b/tools/perf/bench/futex-lock-pi.c
index 08653ae8a8c4..58711b7831e0 100644
--- a/tools/perf/bench/futex-lock-pi.c
+++ b/tools/perf/bench/futex-lock-pi.c
@@ -34,7 +34,6 @@ static bool silent = false, multi = false;
 static bool done = false, fshared = false;
 static unsigned int ncpus, nthreads = 0;
 static int futex_flag = 0;
-struct timeval start, end, runtime;
 static pthread_mutex_t thread_lock;
 static unsigned int threads_starting;
 static struct stats throughput_stats;
@@ -61,7 +60,7 @@ static void print_summary(void)
 
 	printf("%sAveraged %ld operations/sec (+- %.2f%%), total secs = %d\n",
 	       !silent ? "\n" : "", avg, rel_stddev_stats(stddev, avg),
-	       (int) runtime.tv_sec);
+	       (int)bench__runtime.tv_sec);
 }
 
 static void toggle_done(int sig __maybe_unused,
@@ -70,8 +69,8 @@ static void toggle_done(int sig __maybe_unused,
 {
 	/* inform all threads that we're done for the day */
 	done = true;
-	gettimeofday(&end, NULL);
-	timersub(&end, &start, &runtime);
+	gettimeofday(&bench__end, NULL);
+	timersub(&bench__end, &bench__start, &bench__runtime);
 }
 
 static void *workerfn(void *arg)
@@ -178,7 +177,7 @@ int bench_futex_lock_pi(int argc, const char **argv)
 
 	threads_starting = nthreads;
 	pthread_attr_init(&thread_attr);
-	gettimeofday(&start, NULL);
+	gettimeofday(&bench__start, NULL);
 
 	create_threads(worker, thread_attr);
 	pthread_attr_destroy(&thread_attr);
@@ -204,7 +203,7 @@ int bench_futex_lock_pi(int argc, const char **argv)
 	pthread_mutex_destroy(&thread_lock);
 
 	for (i = 0; i < nthreads; i++) {
-		unsigned long t = worker[i].ops/runtime.tv_sec;
+		unsigned long t = worker[i].ops / bench__runtime.tv_sec;
 
 		update_stats(&throughput_stats, t);
 		if (!silent)
diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index f380d91ee609..9c2ad6063b10 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -655,7 +655,7 @@ static void create_tasks(struct perf_sched *sched)
 	err = pthread_attr_init(&attr);
 	BUG_ON(err);
 	err = pthread_attr_setstacksize(&attr,
-			(size_t) max(16 * 1024, PTHREAD_STACK_MIN));
+			(size_t) max(16 * 1024, (int)PTHREAD_STACK_MIN));
 	BUG_ON(err);
 	err = pthread_mutex_lock(&sched->start_work_mutex);
 	BUG_ON(err);
diff --git a/tools/perf/pmu-events/arch/powerpc/power9/other.json b/tools/perf/pmu-events/arch/powerpc/power9/other.json
index 54cc3be00fc2..0048c27d75f3 100644
--- a/tools/perf/pmu-events/arch/powerpc/power9/other.json
+++ b/tools/perf/pmu-events/arch/powerpc/power9/other.json
@@ -1452,7 +1452,7 @@
   {,
     "EventCode": "0x45054",
     "EventName": "PM_FMA_CMPL",
-    "BriefDescription": "two flops operation completed (fmadd, fnmadd, fmsub, fnmsub) Scalar instructions only. "
+    "BriefDescription": "two flops operation completed (fmadd, fnmadd, fmsub, fnmsub) Scalar instructions only."
   },
   {,
     "EventCode": "0x5090",
@@ -2067,7 +2067,7 @@
   {,
     "EventCode": "0xC0BC",
     "EventName": "PM_LSU_FLUSH_OTHER",
-    "BriefDescription": "Other LSU flushes including: Sync (sync ack from L2 caused search of LRQ for oldest snooped load, This will either signal a Precise Flush of the oldest snooped loa or a Flush Next PPC); Data Valid Flush Next (several cases of this, one example is store and reload are lined up such that a store-hit-reload scenario exists and the CDF has already launched and has gotten bad/stale data); Bad Data Valid Flush Next (might be a few cases of this, one example is a larxa (D$ hit) return data and dval but can't allocate to LMQ (LMQ full or other reason). Already gave dval but can't watch it for snoop_hit_larx. Need to take the “bad dval” back and flush all younger ops)"
+    "BriefDescription": "Other LSU flushes including: Sync (sync ack from L2 caused search of LRQ for oldest snooped load, This will either signal a Precise Flush of the oldest snooped loa or a Flush Next PPC); Data Valid Flush Next (several cases of this, one example is store and reload are lined up such that a store-hit-reload scenario exists and the CDF has already launched and has gotten bad/stale data); Bad Data Valid Flush Next (might be a few cases of this, one example is a larxa (D$ hit) return data and dval but can't allocate to LMQ (LMQ full or other reason). Already gave dval but can't watch it for snoop_hit_larx. Need to take the 'bad dval' back and flush all younger ops)"
   },
   {,
     "EventCode": "0x5094",
diff --git a/tools/perf/pmu-events/arch/powerpc/power9/pipeline.json b/tools/perf/pmu-events/arch/powerpc/power9/pipeline.json
index bc2db636dabf..876292f69e1f 100644
--- a/tools/perf/pmu-events/arch/powerpc/power9/pipeline.json
+++ b/tools/perf/pmu-events/arch/powerpc/power9/pipeline.json
@@ -462,7 +462,7 @@
   {,
     "EventCode": "0x4D052",
     "EventName": "PM_2FLOP_CMPL",
-    "BriefDescription": "DP vector version of fmul, fsub, fcmp, fsel, fabs, fnabs, fres ,fsqrte, fneg "
+    "BriefDescription": "DP vector version of fmul, fsub, fcmp, fsel, fabs, fnabs, fres ,fsqrte, fneg"
   },
   {,
     "EventCode": "0x1F142",
diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index e2cc45e5e4a1..295b0ff415d3 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -1776,6 +1776,7 @@ static int find_entire_kern_cb(void *arg, const char *name __maybe_unused,
 			       char type, u64 start)
 {
 	struct sym_args *args = arg;
+	u64 size;
 
 	if (!symbol_type__is_a(type, MAP__FUNCTION))
 		return 0;
@@ -1785,7 +1786,9 @@ static int find_entire_kern_cb(void *arg, const char *name __maybe_unused,
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
index cd870129131e..4fe2f3f92ab1 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -753,8 +753,7 @@ static int hist_entry__dso_to_filter(struct hist_entry *he, int type,
 static int64_t
 sort__sym_from_cmp(struct hist_entry *left, struct hist_entry *right)
 {
-	struct addr_map_symbol *from_l = &left->branch_info->from;
-	struct addr_map_symbol *from_r = &right->branch_info->from;
+	struct addr_map_symbol *from_l, *from_r;
 
 	if (!left->branch_info || !right->branch_info)
 		return cmp_null(left->branch_info, right->branch_info);
diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index 866a61d66251..1071a276f4fd 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -504,7 +504,7 @@ static int elf_read_build_id(Elf *elf, void *bf, size_t size)
 				size_t sz = min(size, descsz);
 				memcpy(bf, ptr, sz);
 				memset(bf + sz, 0, size - sz);
-				err = descsz;
+				err = sz;
 				break;
 			}
 		}
