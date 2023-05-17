Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A06AD70677A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 14:03:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231295AbjEQMDq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 08:03:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231534AbjEQMBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 08:01:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 490A259C9;
        Wed, 17 May 2023 05:01:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F09716461D;
        Wed, 17 May 2023 12:01:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28A43C433EF;
        Wed, 17 May 2023 12:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684324871;
        bh=4R49IulfEw4RFfEvz9Suh81SSZUeQh8N0aUmiFj1LAA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nCjbNpBknjdL9ZU5HP0hiGYwnCm2WmY/88isfyQppwp1B2L0HgapqZxf8wfRXT86J
         hV1yYoTIM2gGfG8oSrqLAa9dzAmxWi/0rLT9bJd4xApMiRHjexSWEOOE6zmIEA/paY
         up77FC0JogmBb6z/EyapYizYd4bU2Mnv2O35znlk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 6.1.29
Date:   Wed, 17 May 2023 14:00:59 +0200
Message-Id: <2023051758-motivate-baking-d867@gregkh>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <2023051758-automaker-childhood-e428@gregkh>
References: <2023051758-automaker-childhood-e428@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

diff --git a/Makefile b/Makefile
index 2d221b879c48..f02f6e1ac574 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 1
-SUBLEVEL = 28
+SUBLEVEL = 29
 EXTRAVERSION =
 NAME = Curry Ramen
 
diff --git a/arch/arm/boot/dts/aspeed-bmc-asrock-e3c246d4i.dts b/arch/arm/boot/dts/aspeed-bmc-asrock-e3c246d4i.dts
index 9b4cf5ebe6d5..c62aff908ab4 100644
--- a/arch/arm/boot/dts/aspeed-bmc-asrock-e3c246d4i.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-asrock-e3c246d4i.dts
@@ -63,7 +63,7 @@ flash@0 {
 		status = "okay";
 		m25p,fast-read;
 		label = "bmc";
-		spi-max-frequency = <100000000>; /* 100 MHz */
+		spi-max-frequency = <50000000>; /* 50 MHz */
 #include "openbmc-flash-layout.dtsi"
 	};
 };
diff --git a/arch/arm/boot/dts/aspeed-bmc-asrock-romed8hm3.dts b/arch/arm/boot/dts/aspeed-bmc-asrock-romed8hm3.dts
index ff4c07c69af1..4554abf0c7cd 100644
--- a/arch/arm/boot/dts/aspeed-bmc-asrock-romed8hm3.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-asrock-romed8hm3.dts
@@ -31,7 +31,7 @@ heartbeat {
 		};
 
 		system-fault {
-			gpios = <&gpio ASPEED_GPIO(Z, 2) GPIO_ACTIVE_LOW>;
+			gpios = <&gpio ASPEED_GPIO(Z, 2) GPIO_ACTIVE_HIGH>;
 			panic-indicator;
 		};
 	};
@@ -51,7 +51,7 @@ flash@0 {
 		status = "okay";
 		m25p,fast-read;
 		label = "bmc";
-		spi-max-frequency = <100000000>; /* 100 MHz */
+		spi-max-frequency = <50000000>; /* 50 MHz */
 #include "openbmc-flash-layout-64.dtsi"
 	};
 };
diff --git a/arch/arm/boot/dts/exynos4412-itop-elite.dts b/arch/arm/boot/dts/exynos4412-itop-elite.dts
index 202ab0fee3b7..bfc79490e2e2 100644
--- a/arch/arm/boot/dts/exynos4412-itop-elite.dts
+++ b/arch/arm/boot/dts/exynos4412-itop-elite.dts
@@ -182,7 +182,7 @@ codec: audio-codec@1a {
 		compatible = "wlf,wm8960";
 		reg = <0x1a>;
 		clocks = <&pmu_system_controller 0>;
-		clock-names = "MCLK1";
+		clock-names = "mclk";
 		wlf,shared-lrclk;
 		#sound-dai-cells = <0>;
 	};
diff --git a/arch/arm/boot/dts/s5pv210.dtsi b/arch/arm/boot/dts/s5pv210.dtsi
index 12e90a1cc6a1..1a9e4a96b2ff 100644
--- a/arch/arm/boot/dts/s5pv210.dtsi
+++ b/arch/arm/boot/dts/s5pv210.dtsi
@@ -566,7 +566,7 @@ csis0: csis@fa600000 {
 				interrupts = <29>;
 				clocks = <&clocks CLK_CSIS>,
 						<&clocks SCLK_CSIS>;
-				clock-names = "clk_csis",
+				clock-names = "csis",
 						"sclk_csis";
 				bus-width = <4>;
 				status = "disabled";
diff --git a/arch/riscv/errata/sifive/errata.c b/arch/riscv/errata/sifive/errata.c
index 1031038423e7..c24a349dd026 100644
--- a/arch/riscv/errata/sifive/errata.c
+++ b/arch/riscv/errata/sifive/errata.c
@@ -4,6 +4,7 @@
  */
 
 #include <linux/kernel.h>
+#include <linux/memory.h>
 #include <linux/module.h>
 #include <linux/string.h>
 #include <linux/bug.h>
@@ -107,7 +108,9 @@ void __init_or_module sifive_errata_patch_func(struct alt_entry *begin,
 
 		tmp = (1U << alt->errata_id);
 		if (cpu_req_errata & tmp) {
+			mutex_lock(&text_mutex);
 			patch_text_nosync(alt->old_ptr, alt->alt_ptr, alt->alt_len);
+			mutex_unlock(&text_mutex);
 			cpu_apply_errata |= tmp;
 		}
 	}
diff --git a/arch/riscv/errata/thead/errata.c b/arch/riscv/errata/thead/errata.c
index 21546937db39..32a34ed73509 100644
--- a/arch/riscv/errata/thead/errata.c
+++ b/arch/riscv/errata/thead/errata.c
@@ -5,6 +5,7 @@
 
 #include <linux/bug.h>
 #include <linux/kernel.h>
+#include <linux/memory.h>
 #include <linux/module.h>
 #include <linux/string.h>
 #include <linux/uaccess.h>
@@ -78,11 +79,14 @@ void __init_or_module thead_errata_patch_func(struct alt_entry *begin, struct al
 		tmp = (1U << alt->errata_id);
 		if (cpu_req_errata & tmp) {
 			/* On vm-alternatives, the mmu isn't running yet */
-			if (stage == RISCV_ALTERNATIVES_EARLY_BOOT)
+			if (stage == RISCV_ALTERNATIVES_EARLY_BOOT) {
 				memcpy((void *)__pa_symbol(alt->old_ptr),
 				       (void *)__pa_symbol(alt->alt_ptr), alt->alt_len);
-			else
+			} else {
+				mutex_lock(&text_mutex);
 				patch_text_nosync(alt->old_ptr, alt->alt_ptr, alt->alt_len);
+				mutex_unlock(&text_mutex);
+			}
 		}
 	}
 
diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
index db6e4b1294ba..ab333cb792fd 100644
--- a/arch/riscv/kernel/Makefile
+++ b/arch/riscv/kernel/Makefile
@@ -9,6 +9,7 @@ CFLAGS_REMOVE_patch.o	= $(CC_FLAGS_FTRACE)
 CFLAGS_REMOVE_sbi.o	= $(CC_FLAGS_FTRACE)
 endif
 CFLAGS_syscall_table.o	+= $(call cc-option,-Wno-override-init,)
+CFLAGS_compat_syscall_table.o += $(call cc-option,-Wno-override-init,)
 
 ifdef CONFIG_KEXEC
 AFLAGS_kexec_relocate.o := -mcmodel=medany $(call cc-option,-mno-relax)
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index 694267d1fe81..fd1238df6149 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -9,6 +9,7 @@
 #include <linux/bitmap.h>
 #include <linux/ctype.h>
 #include <linux/libfdt.h>
+#include <linux/memory.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <asm/alternative.h>
@@ -316,8 +317,11 @@ void __init_or_module riscv_cpufeature_patch_func(struct alt_entry *begin,
 		}
 
 		tmp = (1U << alt->errata_id);
-		if (cpu_req_feature & tmp)
+		if (cpu_req_feature & tmp) {
+			mutex_lock(&text_mutex);
 			patch_text_nosync(alt->old_ptr, alt->alt_ptr, alt->alt_len);
+			mutex_unlock(&text_mutex);
+		}
 	}
 }
 #endif
diff --git a/arch/riscv/mm/pageattr.c b/arch/riscv/mm/pageattr.c
index 86c56616e5de..ea3d61de065b 100644
--- a/arch/riscv/mm/pageattr.c
+++ b/arch/riscv/mm/pageattr.c
@@ -217,18 +217,26 @@ bool kernel_page_present(struct page *page)
 	pgd = pgd_offset_k(addr);
 	if (!pgd_present(*pgd))
 		return false;
+	if (pgd_leaf(*pgd))
+		return true;
 
 	p4d = p4d_offset(pgd, addr);
 	if (!p4d_present(*p4d))
 		return false;
+	if (p4d_leaf(*p4d))
+		return true;
 
 	pud = pud_offset(p4d, addr);
 	if (!pud_present(*pud))
 		return false;
+	if (pud_leaf(*pud))
+		return true;
 
 	pmd = pmd_offset(pud, addr);
 	if (!pmd_present(*pmd))
 		return false;
+	if (pmd_leaf(*pmd))
+		return true;
 
 	pte = pte_offset_kernel(pmd, addr);
 	return pte_present(*pte);
diff --git a/arch/s390/kernel/uv.c b/arch/s390/kernel/uv.c
index f9810d2a267c..5caa0ed2b594 100644
--- a/arch/s390/kernel/uv.c
+++ b/arch/s390/kernel/uv.c
@@ -192,21 +192,10 @@ static int expected_page_refs(struct page *page)
 	return res;
 }
 
-static int make_secure_pte(pte_t *ptep, unsigned long addr,
-			   struct page *exp_page, struct uv_cb_header *uvcb)
+static int make_page_secure(struct page *page, struct uv_cb_header *uvcb)
 {
-	pte_t entry = READ_ONCE(*ptep);
-	struct page *page;
 	int expected, cc = 0;
 
-	if (!pte_present(entry))
-		return -ENXIO;
-	if (pte_val(entry) & _PAGE_INVALID)
-		return -ENXIO;
-
-	page = pte_page(entry);
-	if (page != exp_page)
-		return -ENXIO;
 	if (PageWriteback(page))
 		return -EAGAIN;
 	expected = expected_page_refs(page);
@@ -297,17 +286,18 @@ int gmap_make_secure(struct gmap *gmap, unsigned long gaddr, void *uvcb)
 		goto out;
 
 	rc = -ENXIO;
-	page = follow_page(vma, uaddr, FOLL_WRITE);
-	if (IS_ERR_OR_NULL(page))
-		goto out;
-
-	lock_page(page);
 	ptep = get_locked_pte(gmap->mm, uaddr, &ptelock);
-	if (should_export_before_import(uvcb, gmap->mm))
-		uv_convert_from_secure(page_to_phys(page));
-	rc = make_secure_pte(ptep, uaddr, page, uvcb);
+	if (pte_present(*ptep) && !(pte_val(*ptep) & _PAGE_INVALID) && pte_write(*ptep)) {
+		page = pte_page(*ptep);
+		rc = -EAGAIN;
+		if (trylock_page(page)) {
+			if (should_export_before_import(uvcb, gmap->mm))
+				uv_convert_from_secure(page_to_phys(page));
+			rc = make_page_secure(page, uvcb);
+			unlock_page(page);
+		}
+	}
 	pte_unmap_unlock(ptep, ptelock);
-	unlock_page(page);
 out:
 	mmap_read_unlock(gmap->mm);
 
diff --git a/arch/sh/Kconfig.debug b/arch/sh/Kconfig.debug
index 10290e5c1f43..c449e7c1b20f 100644
--- a/arch/sh/Kconfig.debug
+++ b/arch/sh/Kconfig.debug
@@ -15,7 +15,7 @@ config SH_STANDARD_BIOS
 
 config STACK_DEBUG
 	bool "Check for stack overflows"
-	depends on DEBUG_KERNEL
+	depends on DEBUG_KERNEL && PRINTK
 	help
 	  This option will cause messages to be printed if free stack space
 	  drops below a certain limit. Saying Y here will add overhead to
diff --git a/arch/sh/kernel/head_32.S b/arch/sh/kernel/head_32.S
index 4adbd4ade319..b603b7968b38 100644
--- a/arch/sh/kernel/head_32.S
+++ b/arch/sh/kernel/head_32.S
@@ -64,7 +64,7 @@ ENTRY(_stext)
 	ldc	r0, r6_bank
 #endif
 
-#ifdef CONFIG_OF_FLATTREE
+#ifdef CONFIG_OF_EARLY_FLATTREE
 	mov	r4, r12		! Store device tree blob pointer in r12
 #endif
 	
@@ -315,7 +315,7 @@ ENTRY(_stext)
 10:		
 #endif
 
-#ifdef CONFIG_OF_FLATTREE
+#ifdef CONFIG_OF_EARLY_FLATTREE
 	mov.l	8f, r0		! Make flat device tree available early.
 	jsr	@r0
 	 mov	r12, r4
@@ -346,7 +346,7 @@ ENTRY(stack_start)
 5:	.long	start_kernel
 6:	.long	cpu_init
 7:	.long	init_thread_union
-#if defined(CONFIG_OF_FLATTREE)
+#if defined(CONFIG_OF_EARLY_FLATTREE)
 8:	.long	sh_fdt_init
 #endif
 
diff --git a/arch/sh/kernel/nmi_debug.c b/arch/sh/kernel/nmi_debug.c
index 11777867c6f5..a212b645b4cf 100644
--- a/arch/sh/kernel/nmi_debug.c
+++ b/arch/sh/kernel/nmi_debug.c
@@ -49,7 +49,7 @@ static int __init nmi_debug_setup(char *str)
 	register_die_notifier(&nmi_debug_nb);
 
 	if (*str != '=')
-		return 0;
+		return 1;
 
 	for (p = str + 1; *p; p = sep + 1) {
 		sep = strchr(p, ',');
@@ -70,6 +70,6 @@ static int __init nmi_debug_setup(char *str)
 			break;
 	}
 
-	return 0;
+	return 1;
 }
 __setup("nmi_debug", nmi_debug_setup);
diff --git a/arch/sh/kernel/setup.c b/arch/sh/kernel/setup.c
index 1fcb6659822a..af977ec4ca5e 100644
--- a/arch/sh/kernel/setup.c
+++ b/arch/sh/kernel/setup.c
@@ -244,7 +244,7 @@ void __init __weak plat_early_device_setup(void)
 {
 }
 
-#ifdef CONFIG_OF_FLATTREE
+#ifdef CONFIG_OF_EARLY_FLATTREE
 void __ref sh_fdt_init(phys_addr_t dt_phys)
 {
 	static int done = 0;
@@ -326,7 +326,7 @@ void __init setup_arch(char **cmdline_p)
 	/* Let earlyprintk output early console messages */
 	sh_early_platform_driver_probe("earlyprintk", 1, 1);
 
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
diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index 8259d725054d..4dbde69c423b 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -1603,10 +1603,8 @@ void __init intel_pmu_arch_lbr_init(void)
  * x86_perf_get_lbr - get the LBR records information
  *
  * @lbr: the caller's memory to store the LBR records information
- *
- * Returns: 0 indicates the LBR info has been successfully obtained
  */
-int x86_perf_get_lbr(struct x86_pmu_lbr *lbr)
+void x86_perf_get_lbr(struct x86_pmu_lbr *lbr)
 {
 	int lbr_fmt = x86_pmu.intel_cap.lbr_format;
 
@@ -1614,8 +1612,6 @@ int x86_perf_get_lbr(struct x86_pmu_lbr *lbr)
 	lbr->from = x86_pmu.lbr_from;
 	lbr->to = x86_pmu.lbr_to;
 	lbr->info = (lbr_fmt == LBR_FORMAT_INFO) ? x86_pmu.lbr_info : 0;
-
-	return 0;
 }
 EXPORT_SYMBOL_GPL(x86_perf_get_lbr);
 
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index 9ac46dbe57d4..5d0f6891ae61 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -543,12 +543,12 @@ static inline void perf_check_microcode(void) { }
 
 #if defined(CONFIG_PERF_EVENTS) && defined(CONFIG_CPU_SUP_INTEL)
 extern struct perf_guest_switch_msr *perf_guest_get_msrs(int *nr, void *data);
-extern int x86_perf_get_lbr(struct x86_pmu_lbr *lbr);
+extern void x86_perf_get_lbr(struct x86_pmu_lbr *lbr);
 #else
 struct perf_guest_switch_msr *perf_guest_get_msrs(int *nr, void *data);
-static inline int x86_perf_get_lbr(struct x86_pmu_lbr *lbr)
+static inline void x86_perf_get_lbr(struct x86_pmu_lbr *lbr)
 {
-	return -1;
+	memset(lbr, 0, sizeof(*lbr));
 }
 #endif
 
diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
index 4266b64631a4..7e331e8f3692 100644
--- a/arch/x86/kernel/amd_nb.c
+++ b/arch/x86/kernel/amd_nb.c
@@ -36,6 +36,7 @@
 #define PCI_DEVICE_ID_AMD_19H_M50H_DF_F4 0x166e
 #define PCI_DEVICE_ID_AMD_19H_M60H_DF_F4 0x14e4
 #define PCI_DEVICE_ID_AMD_19H_M70H_DF_F4 0x14f4
+#define PCI_DEVICE_ID_AMD_19H_M78H_DF_F4 0x12fc
 
 /* Protect the PCI config register pairs used for SMN. */
 static DEFINE_MUTEX(smn_mutex);
@@ -79,6 +80,7 @@ static const struct pci_device_id amd_nb_misc_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M50H_DF_F3) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M60H_DF_F3) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M70H_DF_F3) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M78H_DF_F3) },
 	{}
 };
 
diff --git a/arch/x86/kvm/kvm_cache_regs.h b/arch/x86/kvm/kvm_cache_regs.h
index 3febc342360c..896cc7394944 100644
--- a/arch/x86/kvm/kvm_cache_regs.h
+++ b/arch/x86/kvm/kvm_cache_regs.h
@@ -4,7 +4,7 @@
 
 #include <linux/kvm_host.h>
 
-#define KVM_POSSIBLE_CR0_GUEST_BITS X86_CR0_TS
+#define KVM_POSSIBLE_CR0_GUEST_BITS	(X86_CR0_TS | X86_CR0_WP)
 #define KVM_POSSIBLE_CR4_GUEST_BITS				  \
 	(X86_CR4_PVI | X86_CR4_DE | X86_CR4_PCE | X86_CR4_OSFXSR  \
 	 | X86_CR4_OSXMMEXCPT | X86_CR4_PGE | X86_CR4_TSD | X86_CR4_FSGSBASE)
diff --git a/arch/x86/kvm/mmu.h b/arch/x86/kvm/mmu.h
index 6bdaacb6faa0..59804be91b5b 100644
--- a/arch/x86/kvm/mmu.h
+++ b/arch/x86/kvm/mmu.h
@@ -113,6 +113,8 @@ void kvm_init_shadow_ept_mmu(struct kvm_vcpu *vcpu, bool execonly,
 bool kvm_can_do_async_pf(struct kvm_vcpu *vcpu);
 int kvm_handle_page_fault(struct kvm_vcpu *vcpu, u64 error_code,
 				u64 fault_address, char *insn, int insn_len);
+void __kvm_mmu_refresh_passthrough_bits(struct kvm_vcpu *vcpu,
+					struct kvm_mmu *mmu);
 
 int kvm_mmu_load(struct kvm_vcpu *vcpu);
 void kvm_mmu_unload(struct kvm_vcpu *vcpu);
@@ -153,6 +155,24 @@ static inline void kvm_mmu_load_pgd(struct kvm_vcpu *vcpu)
 					  vcpu->arch.mmu->root_role.level);
 }
 
+static inline void kvm_mmu_refresh_passthrough_bits(struct kvm_vcpu *vcpu,
+						    struct kvm_mmu *mmu)
+{
+	/*
+	 * When EPT is enabled, KVM may passthrough CR0.WP to the guest, i.e.
+	 * @mmu's snapshot of CR0.WP and thus all related paging metadata may
+	 * be stale.  Refresh CR0.WP and the metadata on-demand when checking
+	 * for permission faults.  Exempt nested MMUs, i.e. MMUs for shadowing
+	 * nEPT and nNPT, as CR0.WP is ignored in both cases.  Note, KVM does
+	 * need to refresh nested_mmu, a.k.a. the walker used to translate L2
+	 * GVAs to GPAs, as that "MMU" needs to honor L2's CR0.WP.
+	 */
+	if (!tdp_enabled || mmu == &vcpu->arch.guest_mmu)
+		return;
+
+	__kvm_mmu_refresh_passthrough_bits(vcpu, mmu);
+}
+
 /*
  * Check if a given access (described through the I/D, W/R and U/S bits of a
  * page fault error code pfec) causes a permission fault with the given PTE
@@ -184,8 +204,12 @@ static inline u8 permission_fault(struct kvm_vcpu *vcpu, struct kvm_mmu *mmu,
 	u64 implicit_access = access & PFERR_IMPLICIT_ACCESS;
 	bool not_smap = ((rflags & X86_EFLAGS_AC) | implicit_access) == X86_EFLAGS_AC;
 	int index = (pfec + (not_smap << PFERR_RSVD_BIT)) >> 1;
-	bool fault = (mmu->permissions[index] >> pte_access) & 1;
 	u32 errcode = PFERR_PRESENT_MASK;
+	bool fault;
+
+	kvm_mmu_refresh_passthrough_bits(vcpu, mmu);
+
+	fault = (mmu->permissions[index] >> pte_access) & 1;
 
 	WARN_ON(pfec & (PFERR_PK_MASK | PFERR_RSVD_MASK));
 	if (unlikely(mmu->pkru_mask)) {
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index b6f96d47e596..230108a90cf3 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -232,6 +232,20 @@ static struct kvm_mmu_role_regs vcpu_to_role_regs(struct kvm_vcpu *vcpu)
 	return regs;
 }
 
+static unsigned long get_guest_cr3(struct kvm_vcpu *vcpu)
+{
+	return kvm_read_cr3(vcpu);
+}
+
+static inline unsigned long kvm_mmu_get_guest_pgd(struct kvm_vcpu *vcpu,
+						  struct kvm_mmu *mmu)
+{
+	if (IS_ENABLED(CONFIG_RETPOLINE) && mmu->get_guest_pgd == get_guest_cr3)
+		return kvm_read_cr3(vcpu);
+
+	return mmu->get_guest_pgd(vcpu);
+}
+
 static inline bool kvm_available_flush_tlb_with_range(void)
 {
 	return kvm_x86_ops.tlb_remote_flush_with_range;
@@ -3661,7 +3675,7 @@ static int mmu_alloc_shadow_roots(struct kvm_vcpu *vcpu)
 	int quadrant, i, r;
 	hpa_t root;
 
-	root_pgd = mmu->get_guest_pgd(vcpu);
+	root_pgd = kvm_mmu_get_guest_pgd(vcpu, mmu);
 	root_gfn = root_pgd >> PAGE_SHIFT;
 
 	if (mmu_check_root(vcpu, root_gfn))
@@ -4112,7 +4126,7 @@ static bool kvm_arch_setup_async_pf(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
 	arch.token = alloc_apf_token(vcpu);
 	arch.gfn = gfn;
 	arch.direct_map = vcpu->arch.mmu->root_role.direct;
-	arch.cr3 = vcpu->arch.mmu->get_guest_pgd(vcpu);
+	arch.cr3 = kvm_mmu_get_guest_pgd(vcpu, vcpu->arch.mmu);
 
 	return kvm_setup_async_pf(vcpu, cr2_or_gpa,
 				  kvm_vcpu_gfn_to_hva(vcpu, gfn), &arch);
@@ -4131,7 +4145,7 @@ void kvm_arch_async_page_ready(struct kvm_vcpu *vcpu, struct kvm_async_pf *work)
 		return;
 
 	if (!vcpu->arch.mmu->root_role.direct &&
-	      work->arch.cr3 != vcpu->arch.mmu->get_guest_pgd(vcpu))
+	      work->arch.cr3 != kvm_mmu_get_guest_pgd(vcpu, vcpu->arch.mmu))
 		return;
 
 	kvm_mmu_do_page_fault(vcpu, work->cr2_or_gpa, 0, true);
@@ -4488,11 +4502,6 @@ void kvm_mmu_new_pgd(struct kvm_vcpu *vcpu, gpa_t new_pgd)
 }
 EXPORT_SYMBOL_GPL(kvm_mmu_new_pgd);
 
-static unsigned long get_cr3(struct kvm_vcpu *vcpu)
-{
-	return kvm_read_cr3(vcpu);
-}
-
 static bool sync_mmio_spte(struct kvm_vcpu *vcpu, u64 *sptep, gfn_t gfn,
 			   unsigned int access)
 {
@@ -4996,6 +5005,21 @@ kvm_calc_cpu_role(struct kvm_vcpu *vcpu, const struct kvm_mmu_role_regs *regs)
 	return role;
 }
 
+void __kvm_mmu_refresh_passthrough_bits(struct kvm_vcpu *vcpu,
+					struct kvm_mmu *mmu)
+{
+	const bool cr0_wp = !!kvm_read_cr0_bits(vcpu, X86_CR0_WP);
+
+	BUILD_BUG_ON((KVM_MMU_CR0_ROLE_BITS & KVM_POSSIBLE_CR0_GUEST_BITS) != X86_CR0_WP);
+	BUILD_BUG_ON((KVM_MMU_CR4_ROLE_BITS & KVM_POSSIBLE_CR4_GUEST_BITS));
+
+	if (is_cr0_wp(mmu) == cr0_wp)
+		return;
+
+	mmu->cpu_role.base.cr0_wp = cr0_wp;
+	reset_guest_paging_metadata(vcpu, mmu);
+}
+
 static inline int kvm_mmu_get_tdp_level(struct kvm_vcpu *vcpu)
 {
 	/* tdp_root_level is architecture forced level, use it if nonzero */
@@ -5043,7 +5067,7 @@ static void init_kvm_tdp_mmu(struct kvm_vcpu *vcpu,
 	context->page_fault = kvm_tdp_page_fault;
 	context->sync_page = nonpaging_sync_page;
 	context->invlpg = NULL;
-	context->get_guest_pgd = get_cr3;
+	context->get_guest_pgd = get_guest_cr3;
 	context->get_pdptr = kvm_pdptr_read;
 	context->inject_page_fault = kvm_inject_page_fault;
 
@@ -5193,7 +5217,7 @@ static void init_kvm_softmmu(struct kvm_vcpu *vcpu,
 
 	kvm_init_shadow_mmu(vcpu, cpu_role);
 
-	context->get_guest_pgd     = get_cr3;
+	context->get_guest_pgd     = get_guest_cr3;
 	context->get_pdptr         = kvm_pdptr_read;
 	context->inject_page_fault = kvm_inject_page_fault;
 }
@@ -5207,7 +5231,7 @@ static void init_kvm_nested_mmu(struct kvm_vcpu *vcpu,
 		return;
 
 	g_context->cpu_role.as_u64   = new_mode.as_u64;
-	g_context->get_guest_pgd     = get_cr3;
+	g_context->get_guest_pgd     = get_guest_cr3;
 	g_context->get_pdptr         = kvm_pdptr_read;
 	g_context->inject_page_fault = kvm_inject_page_fault;
 
diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_tmpl.h
index 5ab5f94dcb6f..1f4f5e703f13 100644
--- a/arch/x86/kvm/mmu/paging_tmpl.h
+++ b/arch/x86/kvm/mmu/paging_tmpl.h
@@ -324,7 +324,7 @@ static int FNAME(walk_addr_generic)(struct guest_walker *walker,
 	trace_kvm_mmu_pagetable_walk(addr, access);
 retry_walk:
 	walker->level = mmu->cpu_role.base.level;
-	pte           = mmu->get_guest_pgd(vcpu);
+	pte           = kvm_mmu_get_guest_pgd(vcpu, mmu);
 	have_ad       = PT_HAVE_ACCESSED_DIRTY(mmu);
 
 #if PTTYPE == 64
diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index de1fd7369736..20cd746cf467 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -418,9 +418,9 @@ int kvm_pmu_rdpmc(struct kvm_vcpu *vcpu, unsigned idx, u64 *data)
 	if (!pmc)
 		return 1;
 
-	if (!(kvm_read_cr4(vcpu) & X86_CR4_PCE) &&
+	if (!(kvm_read_cr4_bits(vcpu, X86_CR4_PCE)) &&
 	    (static_call(kvm_x86_get_cpl)(vcpu) != 0) &&
-	    (kvm_read_cr0(vcpu) & X86_CR0_PE))
+	    (kvm_read_cr0_bits(vcpu, X86_CR0_PE)))
 		return 1;
 
 	*data = pmc_read_counter(pmc) & mask;
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 9599931c7d57..fc1649b5931a 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -2709,6 +2709,7 @@ static int svm_get_msr_feature(struct kvm_msr_entry *msr)
 			msr->data |= MSR_AMD64_DE_CFG_LFENCE_SERIALIZE;
 		break;
 	case MSR_IA32_PERF_CAPABILITIES:
+		msr->data = kvm_caps.supported_perf_cap;
 		return 0;
 	default:
 		return KVM_MSR_RET_INVALID;
@@ -4888,6 +4889,7 @@ static __init void svm_set_cpu_caps(void)
 {
 	kvm_set_cpu_caps();
 
+	kvm_caps.supported_perf_cap = 0;
 	kvm_caps.supported_xss = 0;
 
 	/* CPUID 0x80000001 and 0x8000000A (SVM features) */
diff --git a/arch/x86/kvm/vmx/capabilities.h b/arch/x86/kvm/vmx/capabilities.h
index 07254314f3dd..cd2ac9536c99 100644
--- a/arch/x86/kvm/vmx/capabilities.h
+++ b/arch/x86/kvm/vmx/capabilities.h
@@ -395,30 +395,6 @@ static inline bool vmx_pebs_supported(void)
 	return boot_cpu_has(X86_FEATURE_PEBS) && kvm_pmu_cap.pebs_ept;
 }
 
-static inline u64 vmx_get_perf_capabilities(void)
-{
-	u64 perf_cap = PMU_CAP_FW_WRITES;
-	struct x86_pmu_lbr lbr;
-	u64 host_perf_cap = 0;
-
-	if (!enable_pmu)
-		return 0;
-
-	if (boot_cpu_has(X86_FEATURE_PDCM))
-		rdmsrl(MSR_IA32_PERF_CAPABILITIES, host_perf_cap);
-
-	if (x86_perf_get_lbr(&lbr) >= 0 && lbr.nr)
-		perf_cap |= host_perf_cap & PMU_CAP_LBR_FMT;
-
-	if (vmx_pebs_supported()) {
-		perf_cap |= host_perf_cap & PERF_CAP_PEBS_MASK;
-		if ((perf_cap & PERF_CAP_PEBS_FORMAT) < 4)
-			perf_cap &= ~PERF_CAP_PEBS_BASELINE;
-	}
-
-	return perf_cap;
-}
-
 static inline bool cpu_has_notify_vmexit(void)
 {
 	return vmcs_config.cpu_based_2nd_exec_ctrl &
diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 8e56ec6e72e9..9d683b6067c7 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -4460,7 +4460,7 @@ static void load_vmcs12_host_state(struct kvm_vcpu *vcpu,
 	 * CR0_GUEST_HOST_MASK is already set in the original vmcs01
 	 * (KVM doesn't change it);
 	 */
-	vcpu->arch.cr0_guest_owned_bits = KVM_POSSIBLE_CR0_GUEST_BITS;
+	vcpu->arch.cr0_guest_owned_bits = vmx_l1_guest_owned_cr0_bits();
 	vmx_set_cr0(vcpu, vmcs12->host_cr0);
 
 	/* Same as above - no reason to call set_cr4_guest_host_mask().  */
@@ -4611,7 +4611,7 @@ static void nested_vmx_restore_host_state(struct kvm_vcpu *vcpu)
 	 */
 	vmx_set_efer(vcpu, nested_vmx_get_vmcs01_guest_efer(vmx));
 
-	vcpu->arch.cr0_guest_owned_bits = KVM_POSSIBLE_CR0_GUEST_BITS;
+	vcpu->arch.cr0_guest_owned_bits = vmx_l1_guest_owned_cr0_bits();
 	vmx_set_cr0(vcpu, vmcs_readl(CR0_READ_SHADOW));
 
 	vcpu->arch.cr4_guest_owned_bits = ~vmcs_readl(CR4_GUEST_HOST_MASK);
diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
index 10b33da9bd05..9fabfe71fd87 100644
--- a/arch/x86/kvm/vmx/pmu_intel.c
+++ b/arch/x86/kvm/vmx/pmu_intel.c
@@ -631,7 +631,7 @@ static void intel_pmu_init(struct kvm_vcpu *vcpu)
 		pmu->fixed_counters[i].current_config = 0;
 	}
 
-	vcpu->arch.perf_capabilities = vmx_get_perf_capabilities();
+	vcpu->arch.perf_capabilities = kvm_caps.supported_perf_cap;
 	lbr_desc->records.nr = 0;
 	lbr_desc->event = NULL;
 	lbr_desc->msr_passthrough = false;
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 4c9116d223df..07aab8592244 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -1879,7 +1879,7 @@ static int vmx_get_msr_feature(struct kvm_msr_entry *msr)
 			return 1;
 		return vmx_get_vmx_msr(&vmcs_config.nested, msr->index, &msr->data);
 	case MSR_IA32_PERF_CAPABILITIES:
-		msr->data = vmx_get_perf_capabilities();
+		msr->data = kvm_caps.supported_perf_cap;
 		return 0;
 	default:
 		return KVM_MSR_RET_INVALID;
@@ -2058,7 +2058,7 @@ static u64 vmx_get_supported_debugctl(struct kvm_vcpu *vcpu, bool host_initiated
 	    (host_initiated || guest_cpuid_has(vcpu, X86_FEATURE_BUS_LOCK_DETECT)))
 		debugctl |= DEBUGCTLMSR_BUS_LOCK_DETECT;
 
-	if ((vmx_get_perf_capabilities() & PMU_CAP_LBR_FMT) &&
+	if ((kvm_caps.supported_perf_cap & PMU_CAP_LBR_FMT) &&
 	    (host_initiated || intel_pmu_lbr_is_enabled(vcpu)))
 		debugctl |= DEBUGCTLMSR_LBR | DEBUGCTLMSR_FREEZE_LBRS_ON_PMI;
 
@@ -2371,14 +2371,14 @@ static int vmx_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 			return 1;
 		if (data & PMU_CAP_LBR_FMT) {
 			if ((data & PMU_CAP_LBR_FMT) !=
-			    (vmx_get_perf_capabilities() & PMU_CAP_LBR_FMT))
+			    (kvm_caps.supported_perf_cap & PMU_CAP_LBR_FMT))
 				return 1;
 			if (!cpuid_model_is_consistent(vcpu))
 				return 1;
 		}
 		if (data & PERF_CAP_PEBS_FORMAT) {
 			if ((data & PERF_CAP_PEBS_MASK) !=
-			    (vmx_get_perf_capabilities() & PERF_CAP_PEBS_MASK))
+			    (kvm_caps.supported_perf_cap & PERF_CAP_PEBS_MASK))
 				return 1;
 			if (!guest_cpuid_has(vcpu, X86_FEATURE_DS))
 				return 1;
@@ -4695,7 +4695,7 @@ static void init_vmcs(struct vcpu_vmx *vmx)
 	/* 22.2.1, 20.8.1 */
 	vm_entry_controls_set(vmx, vmx_vmentry_ctrl());
 
-	vmx->vcpu.arch.cr0_guest_owned_bits = KVM_POSSIBLE_CR0_GUEST_BITS;
+	vmx->vcpu.arch.cr0_guest_owned_bits = vmx_l1_guest_owned_cr0_bits();
 	vmcs_writel(CR0_GUEST_HOST_MASK, ~vmx->vcpu.arch.cr0_guest_owned_bits);
 
 	set_cr4_guest_host_mask(vmx);
@@ -5417,7 +5417,7 @@ static int handle_cr(struct kvm_vcpu *vcpu)
 		break;
 	case 3: /* lmsw */
 		val = (exit_qualification >> LMSW_SOURCE_DATA_SHIFT) & 0x0f;
-		trace_kvm_cr_write(0, (kvm_read_cr0(vcpu) & ~0xful) | val);
+		trace_kvm_cr_write(0, (kvm_read_cr0_bits(vcpu, ~0xful) | val));
 		kvm_lmsw(vcpu, val);
 
 		return kvm_skip_emulated_instruction(vcpu);
@@ -7496,7 +7496,7 @@ static u8 vmx_get_mt_mask(struct kvm_vcpu *vcpu, gfn_t gfn, bool is_mmio)
 	if (!kvm_arch_has_noncoherent_dma(vcpu->kvm))
 		return (MTRR_TYPE_WRBACK << VMX_EPT_MT_EPTE_SHIFT) | VMX_EPT_IPAT_BIT;
 
-	if (kvm_read_cr0(vcpu) & X86_CR0_CD) {
+	if (kvm_read_cr0_bits(vcpu, X86_CR0_CD)) {
 		if (kvm_check_has_quirk(vcpu->kvm, KVM_X86_QUIRK_CD_NW_CLEARED))
 			cache = MTRR_TYPE_WRBACK;
 		else
@@ -7702,6 +7702,33 @@ static void vmx_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
 	vmx_update_exception_bitmap(vcpu);
 }
 
+static u64 vmx_get_perf_capabilities(void)
+{
+	u64 perf_cap = PMU_CAP_FW_WRITES;
+	struct x86_pmu_lbr lbr;
+	u64 host_perf_cap = 0;
+
+	if (!enable_pmu)
+		return 0;
+
+	if (boot_cpu_has(X86_FEATURE_PDCM))
+		rdmsrl(MSR_IA32_PERF_CAPABILITIES, host_perf_cap);
+
+	if (!cpu_feature_enabled(X86_FEATURE_ARCH_LBR)) {
+		x86_perf_get_lbr(&lbr);
+		if (lbr.nr)
+			perf_cap |= host_perf_cap & PMU_CAP_LBR_FMT;
+	}
+
+	if (vmx_pebs_supported()) {
+		perf_cap |= host_perf_cap & PERF_CAP_PEBS_MASK;
+		if ((perf_cap & PERF_CAP_PEBS_FORMAT) < 4)
+			perf_cap &= ~PERF_CAP_PEBS_BASELINE;
+	}
+
+	return perf_cap;
+}
+
 static __init void vmx_set_cpu_caps(void)
 {
 	kvm_set_cpu_caps();
@@ -7724,6 +7751,7 @@ static __init void vmx_set_cpu_caps(void)
 
 	if (!enable_pmu)
 		kvm_cpu_cap_clear(X86_FEATURE_PDCM);
+	kvm_caps.supported_perf_cap = vmx_get_perf_capabilities();
 
 	if (!enable_sgx) {
 		kvm_cpu_cap_clear(X86_FEATURE_SGX);
diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
index a3da84f4ea45..e2b04f4c0fef 100644
--- a/arch/x86/kvm/vmx/vmx.h
+++ b/arch/x86/kvm/vmx/vmx.h
@@ -640,6 +640,24 @@ BUILD_CONTROLS_SHADOW(tertiary_exec, TERTIARY_VM_EXEC_CONTROL, 64)
 				(1 << VCPU_EXREG_EXIT_INFO_1) | \
 				(1 << VCPU_EXREG_EXIT_INFO_2))
 
+static inline unsigned long vmx_l1_guest_owned_cr0_bits(void)
+{
+	unsigned long bits = KVM_POSSIBLE_CR0_GUEST_BITS;
+
+	/*
+	 * CR0.WP needs to be intercepted when KVM is shadowing legacy paging
+	 * in order to construct shadow PTEs with the correct protections.
+	 * Note!  CR0.WP technically can be passed through to the guest if
+	 * paging is disabled, but checking CR0.PG would generate a cyclical
+	 * dependency of sorts due to forcing the caller to ensure CR0 holds
+	 * the correct value prior to determining which CR0 bits can be owned
+	 * by L1.  Keep it simple and limit the optimization to EPT.
+	 */
+	if (!enable_ept)
+		bits &= ~X86_CR0_WP;
+	return bits;
+}
+
 static inline struct kvm_vmx *to_kvm_vmx(struct kvm *kvm)
 {
 	return container_of(kvm, struct kvm_vmx, kvm);
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 3463ef7f3019..d7af225b63d8 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -910,6 +910,18 @@ EXPORT_SYMBOL_GPL(load_pdptrs);
 
 void kvm_post_set_cr0(struct kvm_vcpu *vcpu, unsigned long old_cr0, unsigned long cr0)
 {
+	/*
+	 * CR0.WP is incorporated into the MMU role, but only for non-nested,
+	 * indirect shadow MMUs.  If TDP is enabled, the MMU's metadata needs
+	 * to be updated, e.g. so that emulating guest translations does the
+	 * right thing, but there's no need to unload the root as CR0.WP
+	 * doesn't affect SPTEs.
+	 */
+	if (tdp_enabled && (cr0 ^ old_cr0) == X86_CR0_WP) {
+		kvm_init_mmu(vcpu);
+		return;
+	}
+
 	if ((cr0 ^ old_cr0) & X86_CR0_PG) {
 		kvm_clear_async_pf_completion_queue(vcpu);
 		kvm_async_pf_hash_reset(vcpu);
diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
index 829d3134c1eb..9de72586f406 100644
--- a/arch/x86/kvm/x86.h
+++ b/arch/x86/kvm/x86.h
@@ -27,6 +27,7 @@ struct kvm_caps {
 	u64 supported_mce_cap;
 	u64 supported_xcr0;
 	u64 supported_xss;
+	u64 supported_perf_cap;
 };
 
 void kvm_spurious_fault(void);
diff --git a/arch/x86/lib/clear_page_64.S b/arch/x86/lib/clear_page_64.S
index ecbfb4dd3b01..faa4cdc747a3 100644
--- a/arch/x86/lib/clear_page_64.S
+++ b/arch/x86/lib/clear_page_64.S
@@ -142,8 +142,8 @@ SYM_FUNC_START(clear_user_rep_good)
 	and $7, %edx
 	jz .Lrep_good_exit
 
-.Lrep_good_bytes:
 	mov %edx, %ecx
+.Lrep_good_bytes:
 	rep stosb
 
 .Lrep_good_exit:
diff --git a/arch/x86/lib/retpoline.S b/arch/x86/lib/retpoline.S
index 073289a55f84..841955dc2573 100644
--- a/arch/x86/lib/retpoline.S
+++ b/arch/x86/lib/retpoline.S
@@ -87,8 +87,8 @@ SYM_CODE_END(__x86_indirect_thunk_array)
  */
 	.align 64
 	.skip 63, 0xcc
-SYM_FUNC_START_NOALIGN(zen_untrain_ret);
-
+SYM_START(zen_untrain_ret, SYM_L_GLOBAL, SYM_A_NONE)
+	ANNOTATE_NOENDBR
 	/*
 	 * As executed from zen_untrain_ret, this is:
 	 *
diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 7c91d9195da8..60f366f98fa2 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -468,6 +468,9 @@ static void blkg_destroy_all(struct gendisk *disk)
 	list_for_each_entry_safe(blkg, n, &q->blkg_list, q_node) {
 		struct blkcg *blkcg = blkg->blkcg;
 
+		if (hlist_unhashed(&blkg->blkcg_node))
+			continue;
+
 		spin_lock(&blkcg->lock);
 		blkg_destroy(blkg);
 		spin_unlock(&blkcg->lock);
diff --git a/crypto/algapi.c b/crypto/algapi.c
index c72622f20f52..8c3a869cc43a 100644
--- a/crypto/algapi.c
+++ b/crypto/algapi.c
@@ -944,6 +944,9 @@ EXPORT_SYMBOL_GPL(crypto_enqueue_request);
 void crypto_enqueue_request_head(struct crypto_queue *queue,
 				 struct crypto_async_request *request)
 {
+	if (unlikely(queue->qlen >= queue->max_qlen))
+		queue->backlog = queue->backlog->prev;
+
 	queue->qlen++;
 	list_add(&request->list, &queue->list);
 }
diff --git a/crypto/crypto_engine.c b/crypto/crypto_engine.c
index bb8e77077f02..50bac2ab55f1 100644
--- a/crypto/crypto_engine.c
+++ b/crypto/crypto_engine.c
@@ -54,7 +54,7 @@ static void crypto_finalize_request(struct crypto_engine *engine,
 		}
 	}
 	lockdep_assert_in_softirq();
-	req->complete(req, err);
+	crypto_request_complete(req, err);
 
 	kthread_queue_work(engine->kworker, &engine->pump_requests);
 }
@@ -129,9 +129,6 @@ static void crypto_pump_requests(struct crypto_engine *engine,
 	if (!engine->retry_support)
 		engine->cur_req = async_req;
 
-	if (backlog)
-		backlog->complete(backlog, -EINPROGRESS);
-
 	if (engine->busy)
 		was_busy = true;
 	else
@@ -214,9 +211,12 @@ static void crypto_pump_requests(struct crypto_engine *engine,
 	}
 
 req_err_2:
-	async_req->complete(async_req, ret);
+	crypto_request_complete(async_req, ret);
 
 retry:
+	if (backlog)
+		crypto_request_complete(backlog, -EINPROGRESS);
+
 	/* If retry mechanism is supported, send new requests to engine */
 	if (engine->retry_support) {
 		spin_lock_irqsave(&engine->queue_lock, flags);
diff --git a/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-cipher.c b/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-cipher.c
index 902f6be057ec..e97fb203690a 100644
--- a/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-cipher.c
+++ b/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-cipher.c
@@ -151,7 +151,7 @@ static int sun8i_ss_setup_ivs(struct skcipher_request *areq)
 		}
 		rctx->p_iv[i] = a;
 		/* we need to setup all others IVs only in the decrypt way */
-		if (rctx->op_dir & SS_ENCRYPTION)
+		if (rctx->op_dir == SS_ENCRYPTION)
 			return 0;
 		todo = min(len, sg_dma_len(sg));
 		len -= todo;
diff --git a/drivers/crypto/ccp/psp-dev.c b/drivers/crypto/ccp/psp-dev.c
index c9c741ac8442..949a3fa0b94a 100644
--- a/drivers/crypto/ccp/psp-dev.c
+++ b/drivers/crypto/ccp/psp-dev.c
@@ -42,6 +42,9 @@ static irqreturn_t psp_irq_handler(int irq, void *data)
 	/* Read the interrupt status: */
 	status = ioread32(psp->io_regs + psp->vdata->intsts_reg);
 
+	/* Clear the interrupt status by writing the same value we read. */
+	iowrite32(status, psp->io_regs + psp->vdata->intsts_reg);
+
 	/* invoke subdevice interrupt handlers */
 	if (status) {
 		if (psp->sev_irq_handler)
@@ -51,9 +54,6 @@ static irqreturn_t psp_irq_handler(int irq, void *data)
 			psp->tee_irq_handler(irq, psp->tee_irq_data, status);
 	}
 
-	/* Clear the interrupt status by writing the same value we read. */
-	iowrite32(status, psp->io_regs + psp->vdata->intsts_reg);
-
 	return IRQ_HANDLED;
 }
 
diff --git a/drivers/edac/qcom_edac.c b/drivers/edac/qcom_edac.c
index c45519f59dc1..2c91ceff8a9c 100644
--- a/drivers/edac/qcom_edac.c
+++ b/drivers/edac/qcom_edac.c
@@ -76,6 +76,8 @@
 #define DRP0_INTERRUPT_ENABLE           BIT(6)
 #define SB_DB_DRP_INTERRUPT_ENABLE      0x3
 
+#define ECC_POLL_MSEC			5000
+
 enum {
 	LLCC_DRAM_CE = 0,
 	LLCC_DRAM_UE,
@@ -285,8 +287,7 @@ dump_syn_reg(struct edac_device_ctl_info *edev_ctl, int err_type, u32 bank)
 	return ret;
 }
 
-static irqreturn_t
-llcc_ecc_irq_handler(int irq, void *edev_ctl)
+static irqreturn_t llcc_ecc_irq_handler(int irq, void *edev_ctl)
 {
 	struct edac_device_ctl_info *edac_dev_ctl = edev_ctl;
 	struct llcc_drv_data *drv = edac_dev_ctl->dev->platform_data;
@@ -332,6 +333,11 @@ llcc_ecc_irq_handler(int irq, void *edev_ctl)
 	return irq_rc;
 }
 
+static void llcc_ecc_check(struct edac_device_ctl_info *edev_ctl)
+{
+	llcc_ecc_irq_handler(0, edev_ctl);
+}
+
 static int qcom_llcc_edac_probe(struct platform_device *pdev)
 {
 	struct llcc_drv_data *llcc_driv_data = pdev->dev.platform_data;
@@ -359,29 +365,31 @@ static int qcom_llcc_edac_probe(struct platform_device *pdev)
 	edev_ctl->ctl_name = "llcc";
 	edev_ctl->panic_on_ue = LLCC_ERP_PANIC_ON_UE;
 
-	rc = edac_device_add_device(edev_ctl);
-	if (rc)
-		goto out_mem;
-
-	platform_set_drvdata(pdev, edev_ctl);
-
-	/* Request for ecc irq */
+	/* Check if LLCC driver has passed ECC IRQ */
 	ecc_irq = llcc_driv_data->ecc_irq;
-	if (ecc_irq < 0) {
-		rc = -ENODEV;
-		goto out_dev;
-	}
-	rc = devm_request_irq(dev, ecc_irq, llcc_ecc_irq_handler,
+	if (ecc_irq > 0) {
+		/* Use interrupt mode if IRQ is available */
+		rc = devm_request_irq(dev, ecc_irq, llcc_ecc_irq_handler,
 			      IRQF_TRIGGER_HIGH, "llcc_ecc", edev_ctl);
-	if (rc)
-		goto out_dev;
+		if (!rc) {
+			edac_op_state = EDAC_OPSTATE_INT;
+			goto irq_done;
+		}
+	}
 
-	return rc;
+	/* Fall back to polling mode otherwise */
+	edev_ctl->poll_msec = ECC_POLL_MSEC;
+	edev_ctl->edac_check = llcc_ecc_check;
+	edac_op_state = EDAC_OPSTATE_POLL;
 
-out_dev:
-	edac_device_del_device(edev_ctl->dev);
-out_mem:
-	edac_device_free_ctl_info(edev_ctl);
+irq_done:
+	rc = edac_device_add_device(edev_ctl);
+	if (rc) {
+		edac_device_free_ctl_info(edev_ctl);
+		return rc;
+	}
+
+	platform_set_drvdata(pdev, edev_ctl);
 
 	return rc;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 9776e0b488cf..011e4fbe27f1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4483,7 +4483,11 @@ static int amdgpu_device_recover_vram(struct amdgpu_device *adev)
 	dev_info(adev->dev, "recover vram bo from shadow start\n");
 	mutex_lock(&adev->shadow_list_lock);
 	list_for_each_entry(vmbo, &adev->shadow_list, shadow_list) {
-		shadow = &vmbo->bo;
+		/* If vm is compute context or adev is APU, shadow will be NULL */
+		if (!vmbo->shadow)
+			continue;
+		shadow = vmbo->shadow;
+
 		/* No need to recover an evicted BO */
 		if (shadow->tbo.resource->mem_type != TTM_PL_TT ||
 		    shadow->tbo.resource->start == AMDGPU_BO_INVALID_OFFSET ||
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index 0c546245793b..82e27bd4f038 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -21,6 +21,8 @@
  *
  */
 
+#include <linux/firmware.h>
+
 #include "amdgpu_mes.h"
 #include "amdgpu.h"
 #include "soc15_common.h"
@@ -1423,3 +1425,60 @@ int amdgpu_mes_self_test(struct amdgpu_device *adev)
 	kfree(vm);
 	return 0;
 }
+
+int amdgpu_mes_init_microcode(struct amdgpu_device *adev, int pipe)
+{
+	const struct mes_firmware_header_v1_0 *mes_hdr;
+	struct amdgpu_firmware_info *info;
+	char ucode_prefix[30];
+	char fw_name[40];
+	int r;
+
+	amdgpu_ucode_ip_version_decode(adev, GC_HWIP, ucode_prefix, sizeof(ucode_prefix));
+	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mes%s.bin",
+		ucode_prefix,
+		pipe == AMDGPU_MES_SCHED_PIPE ? "" : "1");
+	r = amdgpu_ucode_request(adev, &adev->mes.fw[pipe], fw_name);
+	if (r)
+		goto out;
+
+	mes_hdr = (const struct mes_firmware_header_v1_0 *)
+		adev->mes.fw[pipe]->data;
+	adev->mes.uc_start_addr[pipe] =
+		le32_to_cpu(mes_hdr->mes_uc_start_addr_lo) |
+		((uint64_t)(le32_to_cpu(mes_hdr->mes_uc_start_addr_hi)) << 32);
+	adev->mes.data_start_addr[pipe] =
+		le32_to_cpu(mes_hdr->mes_data_start_addr_lo) |
+		((uint64_t)(le32_to_cpu(mes_hdr->mes_data_start_addr_hi)) << 32);
+
+	if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
+		int ucode, ucode_data;
+
+		if (pipe == AMDGPU_MES_SCHED_PIPE) {
+			ucode = AMDGPU_UCODE_ID_CP_MES;
+			ucode_data = AMDGPU_UCODE_ID_CP_MES_DATA;
+		} else {
+			ucode = AMDGPU_UCODE_ID_CP_MES1;
+			ucode_data = AMDGPU_UCODE_ID_CP_MES1_DATA;
+		}
+
+		info = &adev->firmware.ucode[ucode];
+		info->ucode_id = ucode;
+		info->fw = adev->mes.fw[pipe];
+		adev->firmware.fw_size +=
+			ALIGN(le32_to_cpu(mes_hdr->mes_ucode_size_bytes),
+			      PAGE_SIZE);
+
+		info = &adev->firmware.ucode[ucode_data];
+		info->ucode_id = ucode_data;
+		info->fw = adev->mes.fw[pipe];
+		adev->firmware.fw_size +=
+			ALIGN(le32_to_cpu(mes_hdr->mes_ucode_data_size_bytes),
+			      PAGE_SIZE);
+	}
+
+	return 0;
+out:
+	amdgpu_ucode_release(&adev->mes.fw[pipe]);
+	return r;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
index ad980f4b66e1..547ec35691fa 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -91,14 +91,12 @@ struct amdgpu_mes {
 	struct amdgpu_bo		*ucode_fw_obj[AMDGPU_MAX_MES_PIPES];
 	uint64_t			ucode_fw_gpu_addr[AMDGPU_MAX_MES_PIPES];
 	uint32_t			*ucode_fw_ptr[AMDGPU_MAX_MES_PIPES];
-	uint32_t                        ucode_fw_version[AMDGPU_MAX_MES_PIPES];
 	uint64_t                        uc_start_addr[AMDGPU_MAX_MES_PIPES];
 
 	/* mes ucode data */
 	struct amdgpu_bo		*data_fw_obj[AMDGPU_MAX_MES_PIPES];
 	uint64_t			data_fw_gpu_addr[AMDGPU_MAX_MES_PIPES];
 	uint32_t			*data_fw_ptr[AMDGPU_MAX_MES_PIPES];
-	uint32_t                        data_fw_version[AMDGPU_MAX_MES_PIPES];
 	uint64_t                        data_start_addr[AMDGPU_MAX_MES_PIPES];
 
 	/* eop gpu obj */
@@ -308,6 +306,7 @@ struct amdgpu_mes_funcs {
 
 int amdgpu_mes_ctx_get_offs(struct amdgpu_ring *ring, unsigned int id_offs);
 
+int amdgpu_mes_init_microcode(struct amdgpu_device *adev, int pipe);
 int amdgpu_mes_init(struct amdgpu_device *adev);
 void amdgpu_mes_fini(struct amdgpu_device *adev);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c
index e9b45089a28a..863b2a34b2d6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c
@@ -38,6 +38,7 @@ static int amdgpu_sched_process_priority_override(struct amdgpu_device *adev,
 {
 	struct fd f = fdget(fd);
 	struct amdgpu_fpriv *fpriv;
+	struct amdgpu_ctx_mgr *mgr;
 	struct amdgpu_ctx *ctx;
 	uint32_t id;
 	int r;
@@ -51,8 +52,11 @@ static int amdgpu_sched_process_priority_override(struct amdgpu_device *adev,
 		return r;
 	}
 
-	idr_for_each_entry(&fpriv->ctx_mgr.ctx_handles, ctx, id)
+	mgr = &fpriv->ctx_mgr;
+	mutex_lock(&mgr->lock);
+	idr_for_each_entry(&mgr->ctx_handles, ctx, id)
 		amdgpu_ctx_priority_override(ctx, priority);
+	mutex_unlock(&mgr->lock);
 
 	fdput(f);
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
index 5cb62e6249c2..6e7058a2d1c8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
@@ -1091,3 +1091,39 @@ void amdgpu_ucode_ip_version_decode(struct amdgpu_device *adev, int block_type,
 
 	snprintf(ucode_prefix, len, "%s_%d_%d_%d", ip_name, maj, min, rev);
 }
+
+/*
+ * amdgpu_ucode_request - Fetch and validate amdgpu microcode
+ *
+ * @adev: amdgpu device
+ * @fw: pointer to load firmware to
+ * @fw_name: firmware to load
+ *
+ * This is a helper that will use request_firmware and amdgpu_ucode_validate
+ * to load and run basic validation on firmware. If the load fails, remap
+ * the error code to -ENODEV, so that early_init functions will fail to load.
+ */
+int amdgpu_ucode_request(struct amdgpu_device *adev, const struct firmware **fw,
+			 const char *fw_name)
+{
+	int err = request_firmware(fw, fw_name, adev->dev);
+
+	if (err)
+		return -ENODEV;
+	err = amdgpu_ucode_validate(*fw);
+	if (err)
+		dev_dbg(adev->dev, "\"%s\" failed to validate\n", fw_name);
+
+	return err;
+}
+
+/*
+ * amdgpu_ucode_release - Release firmware microcode
+ *
+ * @fw: pointer to firmware to release
+ */
+void amdgpu_ucode_release(const struct firmware **fw)
+{
+	release_firmware(*fw);
+	*fw = NULL;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
index 1c36235b4539..4c20eb410960 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
@@ -543,6 +543,9 @@ void amdgpu_ucode_print_sdma_hdr(const struct common_firmware_header *hdr);
 void amdgpu_ucode_print_psp_hdr(const struct common_firmware_header *hdr);
 void amdgpu_ucode_print_gpu_info_hdr(const struct common_firmware_header *hdr);
 int amdgpu_ucode_validate(const struct firmware *fw);
+int amdgpu_ucode_request(struct amdgpu_device *adev, const struct firmware **fw,
+			 const char *fw_name);
+void amdgpu_ucode_release(const struct firmware **fw);
 bool amdgpu_ucode_hdr_version(union amdgpu_firmware_header *hdr,
 				uint16_t hdr_major, uint16_t hdr_minor);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 0320be4a5fc6..1f3fdf6cb903 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -3797,7 +3797,8 @@ static int gfx_v9_0_hw_fini(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
-	amdgpu_irq_put(adev, &adev->gfx.cp_ecc_error_irq, 0);
+	if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__GFX))
+		amdgpu_irq_put(adev, &adev->gfx.cp_ecc_error_irq, 0);
 	amdgpu_irq_put(adev, &adev->gfx.priv_reg_irq, 0);
 	amdgpu_irq_put(adev, &adev->gfx.priv_inst_irq, 0);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index f513e2c2e964..d96ee48e1706 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -1142,7 +1142,6 @@ static int gmc_v10_0_hw_fini(void *handle)
 		return 0;
 	}
 
-	amdgpu_irq_put(adev, &adev->gmc.ecc_irq, 0);
 	amdgpu_irq_put(adev, &adev->gmc.vm_fault, 0);
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index 96e0bb5bee78..2d11e8e7e123 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -931,7 +931,6 @@ static int gmc_v11_0_hw_fini(void *handle)
 		return 0;
 	}
 
-	amdgpu_irq_put(adev, &adev->gmc.ecc_irq, 0);
 	amdgpu_irq_put(adev, &adev->gmc.vm_fault, 0);
 	gmc_v11_0_gart_disable(adev);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 67ca16a8027c..0d9e9d9dd4a1 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1898,7 +1898,6 @@ static int gmc_v9_0_hw_fini(void *handle)
 	if (adev->mmhub.funcs->update_power_gating)
 		adev->mmhub.funcs->update_power_gating(adev, false);
 
-	amdgpu_irq_put(adev, &adev->gmc.ecc_irq, 0);
 	amdgpu_irq_put(adev, &adev->gmc.vm_fault, 0);
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
index a1b751d9ac06..323d68b2124f 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
@@ -54,6 +54,7 @@ static int jpeg_v3_0_early_init(void *handle)
 
 	switch (adev->ip_versions[UVD_HWIP][0]) {
 	case IP_VERSION(3, 1, 1):
+	case IP_VERSION(3, 1, 2):
 		break;
 	default:
 		harvest = RREG32_SOC15(JPEG, 0, mmCC_UVD_HARVESTING);
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c b/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
index 067d10073a56..09105029445a 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
@@ -375,93 +375,6 @@ static const struct amdgpu_mes_funcs mes_v10_1_funcs = {
 	.resume_gang = mes_v10_1_resume_gang,
 };
 
-static int mes_v10_1_init_microcode(struct amdgpu_device *adev,
-				    enum admgpu_mes_pipe pipe)
-{
-	const char *chip_name;
-	char fw_name[30];
-	int err;
-	const struct mes_firmware_header_v1_0 *mes_hdr;
-	struct amdgpu_firmware_info *info;
-
-	switch (adev->ip_versions[GC_HWIP][0]) {
-	case IP_VERSION(10, 1, 10):
-		chip_name = "navi10";
-		break;
-	case IP_VERSION(10, 3, 0):
-		chip_name = "sienna_cichlid";
-		break;
-	default:
-		BUG();
-	}
-
-	if (pipe == AMDGPU_MES_SCHED_PIPE)
-		snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mes.bin",
-			 chip_name);
-	else
-		snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mes1.bin",
-			 chip_name);
-
-	err = request_firmware(&adev->mes.fw[pipe], fw_name, adev->dev);
-	if (err)
-		return err;
-
-	err = amdgpu_ucode_validate(adev->mes.fw[pipe]);
-	if (err) {
-		release_firmware(adev->mes.fw[pipe]);
-		adev->mes.fw[pipe] = NULL;
-		return err;
-	}
-
-	mes_hdr = (const struct mes_firmware_header_v1_0 *)
-		adev->mes.fw[pipe]->data;
-	adev->mes.ucode_fw_version[pipe] =
-		le32_to_cpu(mes_hdr->mes_ucode_version);
-	adev->mes.ucode_fw_version[pipe] =
-		le32_to_cpu(mes_hdr->mes_ucode_data_version);
-	adev->mes.uc_start_addr[pipe] =
-		le32_to_cpu(mes_hdr->mes_uc_start_addr_lo) |
-		((uint64_t)(le32_to_cpu(mes_hdr->mes_uc_start_addr_hi)) << 32);
-	adev->mes.data_start_addr[pipe] =
-		le32_to_cpu(mes_hdr->mes_data_start_addr_lo) |
-		((uint64_t)(le32_to_cpu(mes_hdr->mes_data_start_addr_hi)) << 32);
-
-	if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
-		int ucode, ucode_data;
-
-		if (pipe == AMDGPU_MES_SCHED_PIPE) {
-			ucode = AMDGPU_UCODE_ID_CP_MES;
-			ucode_data = AMDGPU_UCODE_ID_CP_MES_DATA;
-		} else {
-			ucode = AMDGPU_UCODE_ID_CP_MES1;
-			ucode_data = AMDGPU_UCODE_ID_CP_MES1_DATA;
-		}
-
-		info = &adev->firmware.ucode[ucode];
-		info->ucode_id = ucode;
-		info->fw = adev->mes.fw[pipe];
-		adev->firmware.fw_size +=
-			ALIGN(le32_to_cpu(mes_hdr->mes_ucode_size_bytes),
-			      PAGE_SIZE);
-
-		info = &adev->firmware.ucode[ucode_data];
-		info->ucode_id = ucode_data;
-		info->fw = adev->mes.fw[pipe];
-		adev->firmware.fw_size +=
-			ALIGN(le32_to_cpu(mes_hdr->mes_ucode_data_size_bytes),
-			      PAGE_SIZE);
-	}
-
-	return 0;
-}
-
-static void mes_v10_1_free_microcode(struct amdgpu_device *adev,
-				     enum admgpu_mes_pipe pipe)
-{
-	release_firmware(adev->mes.fw[pipe]);
-	adev->mes.fw[pipe] = NULL;
-}
-
 static int mes_v10_1_allocate_ucode_buffer(struct amdgpu_device *adev,
 					   enum admgpu_mes_pipe pipe)
 {
@@ -1019,10 +932,6 @@ static int mes_v10_1_sw_init(void *handle)
 		if (!adev->enable_mes_kiq && pipe == AMDGPU_MES_KIQ_PIPE)
 			continue;
 
-		r = mes_v10_1_init_microcode(adev, pipe);
-		if (r)
-			return r;
-
 		r = mes_v10_1_allocate_eop_buf(adev, pipe);
 		if (r)
 			return r;
@@ -1059,8 +968,7 @@ static int mes_v10_1_sw_fini(void *handle)
 		amdgpu_bo_free_kernel(&adev->mes.eop_gpu_obj[pipe],
 				      &adev->mes.eop_gpu_addr[pipe],
 				      NULL);
-
-		mes_v10_1_free_microcode(adev, pipe);
+		amdgpu_ucode_release(&adev->mes.fw[pipe]);
 	}
 
 	amdgpu_bo_free_kernel(&adev->gfx.kiq.ring.mqd_obj,
@@ -1229,6 +1137,22 @@ static int mes_v10_1_resume(void *handle)
 	return amdgpu_mes_resume(adev);
 }
 
+static int mes_v10_0_early_init(void *handle)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	int pipe, r;
+
+	for (pipe = 0; pipe < AMDGPU_MAX_MES_PIPES; pipe++) {
+		if (!adev->enable_mes_kiq && pipe == AMDGPU_MES_KIQ_PIPE)
+			continue;
+		r = amdgpu_mes_init_microcode(adev, pipe);
+		if (r)
+			return r;
+	}
+
+	return 0;
+}
+
 static int mes_v10_0_late_init(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
@@ -1241,6 +1165,7 @@ static int mes_v10_0_late_init(void *handle)
 
 static const struct amd_ip_funcs mes_v10_1_ip_funcs = {
 	.name = "mes_v10_1",
+	.early_init = mes_v10_0_early_init,
 	.late_init = mes_v10_0_late_init,
 	.sw_init = mes_v10_1_sw_init,
 	.sw_fini = mes_v10_1_sw_fini,
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index 6f0e389be5f6..e3168149ca8f 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -453,84 +453,6 @@ static const struct amdgpu_mes_funcs mes_v11_0_funcs = {
 	.misc_op = mes_v11_0_misc_op,
 };
 
-static int mes_v11_0_init_microcode(struct amdgpu_device *adev,
-				    enum admgpu_mes_pipe pipe)
-{
-	char fw_name[30];
-	char ucode_prefix[30];
-	int err;
-	const struct mes_firmware_header_v1_0 *mes_hdr;
-	struct amdgpu_firmware_info *info;
-
-	amdgpu_ucode_ip_version_decode(adev, GC_HWIP, ucode_prefix, sizeof(ucode_prefix));
-
-	if (pipe == AMDGPU_MES_SCHED_PIPE)
-		snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mes.bin",
-			 ucode_prefix);
-	else
-		snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mes1.bin",
-			 ucode_prefix);
-
-	err = request_firmware(&adev->mes.fw[pipe], fw_name, adev->dev);
-	if (err)
-		return err;
-
-	err = amdgpu_ucode_validate(adev->mes.fw[pipe]);
-	if (err) {
-		release_firmware(adev->mes.fw[pipe]);
-		adev->mes.fw[pipe] = NULL;
-		return err;
-	}
-
-	mes_hdr = (const struct mes_firmware_header_v1_0 *)
-		adev->mes.fw[pipe]->data;
-	adev->mes.ucode_fw_version[pipe] =
-		le32_to_cpu(mes_hdr->mes_ucode_version);
-	adev->mes.ucode_fw_version[pipe] =
-		le32_to_cpu(mes_hdr->mes_ucode_data_version);
-	adev->mes.uc_start_addr[pipe] =
-		le32_to_cpu(mes_hdr->mes_uc_start_addr_lo) |
-		((uint64_t)(le32_to_cpu(mes_hdr->mes_uc_start_addr_hi)) << 32);
-	adev->mes.data_start_addr[pipe] =
-		le32_to_cpu(mes_hdr->mes_data_start_addr_lo) |
-		((uint64_t)(le32_to_cpu(mes_hdr->mes_data_start_addr_hi)) << 32);
-
-	if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
-		int ucode, ucode_data;
-
-		if (pipe == AMDGPU_MES_SCHED_PIPE) {
-			ucode = AMDGPU_UCODE_ID_CP_MES;
-			ucode_data = AMDGPU_UCODE_ID_CP_MES_DATA;
-		} else {
-			ucode = AMDGPU_UCODE_ID_CP_MES1;
-			ucode_data = AMDGPU_UCODE_ID_CP_MES1_DATA;
-		}
-
-		info = &adev->firmware.ucode[ucode];
-		info->ucode_id = ucode;
-		info->fw = adev->mes.fw[pipe];
-		adev->firmware.fw_size +=
-			ALIGN(le32_to_cpu(mes_hdr->mes_ucode_size_bytes),
-			      PAGE_SIZE);
-
-		info = &adev->firmware.ucode[ucode_data];
-		info->ucode_id = ucode_data;
-		info->fw = adev->mes.fw[pipe];
-		adev->firmware.fw_size +=
-			ALIGN(le32_to_cpu(mes_hdr->mes_ucode_data_size_bytes),
-			      PAGE_SIZE);
-	}
-
-	return 0;
-}
-
-static void mes_v11_0_free_microcode(struct amdgpu_device *adev,
-				     enum admgpu_mes_pipe pipe)
-{
-	release_firmware(adev->mes.fw[pipe]);
-	adev->mes.fw[pipe] = NULL;
-}
-
 static int mes_v11_0_allocate_ucode_buffer(struct amdgpu_device *adev,
 					   enum admgpu_mes_pipe pipe)
 {
@@ -1098,10 +1020,6 @@ static int mes_v11_0_sw_init(void *handle)
 		if (!adev->enable_mes_kiq && pipe == AMDGPU_MES_KIQ_PIPE)
 			continue;
 
-		r = mes_v11_0_init_microcode(adev, pipe);
-		if (r)
-			return r;
-
 		r = mes_v11_0_allocate_eop_buf(adev, pipe);
 		if (r)
 			return r;
@@ -1138,8 +1056,7 @@ static int mes_v11_0_sw_fini(void *handle)
 		amdgpu_bo_free_kernel(&adev->mes.eop_gpu_obj[pipe],
 				      &adev->mes.eop_gpu_addr[pipe],
 				      NULL);
-
-		mes_v11_0_free_microcode(adev, pipe);
+		amdgpu_ucode_release(&adev->mes.fw[pipe]);
 	}
 
 	amdgpu_bo_free_kernel(&adev->gfx.kiq.ring.mqd_obj,
@@ -1334,6 +1251,22 @@ static int mes_v11_0_resume(void *handle)
 	return amdgpu_mes_resume(adev);
 }
 
+static int mes_v11_0_early_init(void *handle)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	int pipe, r;
+
+	for (pipe = 0; pipe < AMDGPU_MAX_MES_PIPES; pipe++) {
+		if (!adev->enable_mes_kiq && pipe == AMDGPU_MES_KIQ_PIPE)
+			continue;
+		r = amdgpu_mes_init_microcode(adev, pipe);
+		if (r)
+			return r;
+	}
+
+	return 0;
+}
+
 static int mes_v11_0_late_init(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
@@ -1348,6 +1281,7 @@ static int mes_v11_0_late_init(void *handle)
 
 static const struct amd_ip_funcs mes_v11_0_ip_funcs = {
 	.name = "mes_v11_0",
+	.early_init = mes_v11_0_early_init,
 	.late_init = mes_v11_0_late_init,
 	.sw_init = mes_v11_0_sw_init,
 	.sw_fini = mes_v11_0_sw_fini,
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
index 4d780e4430e7..77d5a6f30409 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -1941,9 +1941,11 @@ static int sdma_v4_0_hw_fini(void *handle)
 		return 0;
 	}
 
-	for (i = 0; i < adev->sdma.num_instances; i++) {
-		amdgpu_irq_put(adev, &adev->sdma.ecc_irq,
-			       AMDGPU_SDMA_IRQ_INSTANCE0 + i);
+	if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__SDMA)) {
+		for (i = 0; i < adev->sdma.num_instances; i++) {
+			amdgpu_irq_put(adev, &adev->sdma.ecc_irq,
+				       AMDGPU_SDMA_IRQ_INSTANCE0 + i);
+		}
 	}
 
 	sdma_v4_0_ctx_switch_enable(adev, false);
diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
index 9c52af500525..d150a90daa40 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -715,7 +715,7 @@ static int soc21_common_early_init(void *handle)
 			AMD_PG_SUPPORT_VCN_DPG |
 			AMD_PG_SUPPORT_GFX_PG |
 			AMD_PG_SUPPORT_JPEG;
-		adev->external_rev_id = adev->rev_id + 0x1;
+		adev->external_rev_id = adev->rev_id + 0x80;
 		break;
 
 	default:
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 99b99f0b42c0..b46732cefe37 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -39,6 +39,7 @@
 #include "dc/dc_edid_parser.h"
 #include "dc/dc_stat.h"
 #include "amdgpu_dm_trace.h"
+#include "dc/inc/dc_link_ddc.h"
 
 #include "vid.h"
 #include "amdgpu.h"
@@ -2254,6 +2255,14 @@ static void s3_handle_mst(struct drm_device *dev, bool suspend)
 		if (suspend) {
 			drm_dp_mst_topology_mgr_suspend(mgr);
 		} else {
+			/* if extended timeout is supported in hardware,
+			 * default to LTTPR timeout (3.2ms) first as a W/A for DP link layer
+			 * CTS 4.2.1.1 regression introduced by CTS specs requirement update.
+			 */
+			dc_link_aux_try_to_configure_timeout(aconnector->dc_link->ddc, LINK_AUX_DEFAULT_LTTPR_TIMEOUT_PERIOD);
+			if (!dp_is_lttpr_present(aconnector->dc_link))
+				dc_link_aux_try_to_configure_timeout(aconnector->dc_link->ddc, LINK_AUX_DEFAULT_TIMEOUT_PERIOD);
+
 			ret = drm_dp_mst_topology_mgr_resume(mgr, true);
 			if (ret < 0) {
 				dm_helpers_dp_mst_stop_top_mgr(aconnector->dc_link->ctx,
@@ -7584,6 +7593,13 @@ static void amdgpu_dm_commit_cursors(struct drm_atomic_state *state)
 			handle_cursor_update(plane, old_plane_state);
 }
 
+static inline uint32_t get_mem_type(struct drm_framebuffer *fb)
+{
+	struct amdgpu_bo *abo = gem_to_amdgpu_bo(fb->obj[0]);
+
+	return abo->tbo.resource ? abo->tbo.resource->mem_type : 0;
+}
+
 static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
 				    struct dc_state *dc_state,
 				    struct drm_device *dev,
@@ -7657,6 +7673,8 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
 			continue;
 
 		dc_plane = dm_new_plane_state->dc_state;
+		if (!dc_plane)
+			continue;
 
 		bundle->surface_updates[planes_count].surface = dc_plane;
 		if (new_pcrtc_state->color_mgmt_changed) {
@@ -7701,11 +7719,13 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
 
 		/*
 		 * Only allow immediate flips for fast updates that don't
-		 * change FB pitch, DCC state, rotation or mirroing.
+		 * change memory domain, FB pitch, DCC state, rotation or
+		 * mirroring.
 		 */
 		bundle->flip_addrs[planes_count].flip_immediate =
 			crtc->state->async_flip &&
-			acrtc_state->update_type == UPDATE_TYPE_FAST;
+			acrtc_state->update_type == UPDATE_TYPE_FAST &&
+			get_mem_type(old_plane_state->fb) == get_mem_type(fb);
 
 		timestamp_ns = ktime_get_ns();
 		bundle->flip_addrs[planes_count].flip_timestamp_in_us = div_u64(timestamp_ns, 1000);
@@ -9199,8 +9219,9 @@ static int dm_update_plane_state(struct dc *dc,
 			return -EINVAL;
 		}
 
+		if (dm_old_plane_state->dc_state)
+			dc_plane_state_release(dm_old_plane_state->dc_state);
 
-		dc_plane_state_release(dm_old_plane_state->dc_state);
 		dm_new_plane_state->dc_state = NULL;
 
 		*lock_and_validation_needed = true;
@@ -9737,6 +9758,7 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
 		ret = compute_mst_dsc_configs_for_state(state, dm_state->context, vars);
 		if (ret) {
 			DRM_DEBUG_DRIVER("compute_mst_dsc_configs_for_state() failed\n");
+			ret = -EINVAL;
 			goto fail;
 		}
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index df74bc88e460..e2f9141d6d93 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -1368,6 +1368,7 @@ int pre_validate_dsc(struct drm_atomic_state *state,
 	ret = pre_compute_mst_dsc_configs_for_state(state, local_dc_state, vars);
 	if (ret != 0) {
 		DRM_INFO_ONCE("pre_compute_mst_dsc_configs_for_state() failed\n");
+		ret = -EINVAL;
 		goto clean_exit;
 	}
 
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_smu.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_smu.c
index 090b2c02aee1..0827c7df2855 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_smu.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_smu.c
@@ -333,8 +333,8 @@ void dcn31_smu_set_zstate_support(struct clk_mgr_internal *clk_mgr, enum dcn_zst
 			(support == DCN_ZSTATE_SUPPORT_ALLOW_Z10_ONLY))
 		support = DCN_ZSTATE_SUPPORT_DISALLOW;
 
-
-	if (support == DCN_ZSTATE_SUPPORT_ALLOW_Z10_ONLY)
+	if (support == DCN_ZSTATE_SUPPORT_ALLOW_Z10_ONLY ||
+	    support == DCN_ZSTATE_SUPPORT_ALLOW_Z8_Z10_ONLY)
 		param = 1;
 	else
 		param = 0;
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_smu.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_smu.c
index aa264c600408..0765334f0825 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_smu.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_smu.c
@@ -349,8 +349,6 @@ void dcn314_smu_set_zstate_support(struct clk_mgr_internal *clk_mgr, enum dcn_zs
 	if (!clk_mgr->smu_present)
 		return;
 
-	// Arg[15:0] = 8/9/0 for Z8/Z9/disallow -> existing bits
-	// Arg[16] = Disallow Z9 -> new bit
 	switch (support) {
 
 	case DCN_ZSTATE_SUPPORT_ALLOW:
@@ -369,6 +367,16 @@ void dcn314_smu_set_zstate_support(struct clk_mgr_internal *clk_mgr, enum dcn_zs
 		param = (1 << 10);
 		break;
 
+	case DCN_ZSTATE_SUPPORT_ALLOW_Z8_Z10_ONLY:
+		msg_id = VBIOSSMC_MSG_AllowZstatesEntry;
+		param = (1 << 10) | (1 << 8);
+		break;
+
+	case DCN_ZSTATE_SUPPORT_ALLOW_Z8_ONLY:
+		msg_id = VBIOSSMC_MSG_AllowZstatesEntry;
+		param = (1 << 8);
+		break;
+
 	default: //DCN_ZSTATE_SUPPORT_UNKNOWN
 		msg_id = VBIOSSMC_MSG_AllowZstatesEntry;
 		param = 0;
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
index 9eb9fe5b8d2c..1d84a04acb3f 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
@@ -756,6 +756,8 @@ void dcn32_clk_mgr_construct(
 		struct pp_smu_funcs *pp_smu,
 		struct dccg *dccg)
 {
+	struct clk_log_info log_info = {0};
+
 	clk_mgr->base.ctx = ctx;
 	clk_mgr->base.funcs = &dcn32_funcs;
 	if (ASICREV_IS_GC_11_0_2(clk_mgr->base.ctx->asic_id.hw_internal_rev)) {
@@ -789,6 +791,7 @@ void dcn32_clk_mgr_construct(
 			clk_mgr->base.clks.ref_dtbclk_khz = 268750;
 	}
 
+
 	/* integer part is now VCO frequency in kHz */
 	clk_mgr->base.dentist_vco_freq_khz = dcn32_get_vco_frequency_from_reg(clk_mgr);
 
@@ -796,6 +799,8 @@ void dcn32_clk_mgr_construct(
 	if (clk_mgr->base.dentist_vco_freq_khz == 0)
 		clk_mgr->base.dentist_vco_freq_khz = 4300000; /* Updated as per HW docs */
 
+	dcn32_dump_clk_registers(&clk_mgr->base.boot_snapshot, &clk_mgr->base, &log_info);
+
 	if (ctx->dc->debug.disable_dtb_ref_clk_switch &&
 			clk_mgr->base.clks.ref_dtbclk_khz != clk_mgr->base.boot_snapshot.dtbclk) {
 		clk_mgr->base.clks.ref_dtbclk_khz = clk_mgr->base.boot_snapshot.dtbclk;
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index bf7fcd268cb4..6299130663a3 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -3381,7 +3381,7 @@ bool dc_link_setup_psr(struct dc_link *link,
 		case FAMILY_YELLOW_CARP:
 		case AMDGPU_FAMILY_GC_10_3_6:
 		case AMDGPU_FAMILY_GC_11_0_1:
-			if (dc->debug.disable_z10)
+			if (dc->debug.disable_z10 || dc->debug.psr_skip_crtc_disable)
 				psr_context->psr_level.bits.SKIP_CRTC_DISABLE = true;
 			break;
 		default:
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index fd8db482e56f..f0d05829288b 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -1707,6 +1707,9 @@ bool dc_remove_plane_from_context(
 	struct dc_stream_status *stream_status = NULL;
 	struct resource_pool *pool = dc->res_pool;
 
+	if (!plane_state)
+		return true;
+
 	for (i = 0; i < context->stream_count; i++)
 		if (context->streams[i] == stream) {
 			stream_status = &context->stream_status[i];
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 0598465fd1a1..3f277009075f 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -491,6 +491,8 @@ enum dcn_pwr_state {
 enum dcn_zstate_support_state {
 	DCN_ZSTATE_SUPPORT_UNKNOWN,
 	DCN_ZSTATE_SUPPORT_ALLOW,
+	DCN_ZSTATE_SUPPORT_ALLOW_Z8_ONLY,
+	DCN_ZSTATE_SUPPORT_ALLOW_Z8_Z10_ONLY,
 	DCN_ZSTATE_SUPPORT_ALLOW_Z10_ONLY,
 	DCN_ZSTATE_SUPPORT_DISALLOW,
 };
@@ -764,7 +766,6 @@ struct dc_debug_options {
 	bool disable_mem_low_power;
 	bool pstate_enabled;
 	bool disable_dmcu;
-	bool disable_psr;
 	bool force_abm_enable;
 	bool disable_stereo_support;
 	bool vsr_support;
@@ -780,6 +781,7 @@ struct dc_debug_options {
 	unsigned int force_odm_combine; //bit vector based on otg inst
 	unsigned int seamless_boot_odm_combine;
 	unsigned int force_odm_combine_4to1; //bit vector based on otg inst
+	int minimum_z8_residency_time;
 	bool disable_z9_mpc;
 	unsigned int force_fclk_khz;
 	bool enable_tri_buf;
@@ -828,6 +830,7 @@ struct dc_debug_options {
 	int crb_alloc_policy_min_disp_count;
 	bool disable_z10;
 	bool enable_z9_disable_interface;
+	bool psr_skip_crtc_disable;
 	union dpia_debug_options dpia_debug;
 	bool disable_fixed_vs_aux_timeout_wa;
 	bool force_disable_subvp;
diff --git a/drivers/gpu/drm/amd/display/dc/dc_link.h b/drivers/gpu/drm/amd/display/dc/dc_link.h
index caf0c7af2d0b..17f080f8af6c 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_link.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_link.h
@@ -117,7 +117,7 @@ struct psr_settings {
  * Add a struct dc_panel_config under dc_link
  */
 struct dc_panel_config {
-	// extra panel power sequence parameters
+	/* extra panel power sequence parameters */
 	struct pps {
 		unsigned int extra_t3_ms;
 		unsigned int extra_t7_ms;
@@ -127,13 +127,21 @@ struct dc_panel_config {
 		unsigned int extra_t12_ms;
 		unsigned int extra_post_OUI_ms;
 	} pps;
-	// ABM
+	/* PSR */
+	struct psr {
+		bool disable_psr;
+		bool disallow_psrsu;
+		bool rc_disable;
+		bool rc_allow_static_screen;
+		bool rc_allow_fullscreen_VPB;
+	} psr;
+	/* ABM */
 	struct varib {
 		unsigned int varibright_feature_enable;
 		unsigned int def_varibright_level;
 		unsigned int abm_config_setting;
 	} varib;
-	// edp DSC
+	/* edp DSC */
 	struct dsc {
 		bool disable_dsc_edp;
 		unsigned int force_dsc_edp_policy;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index 55d63d860ef1..0dcd9fea122d 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -726,11 +726,15 @@ void dcn10_hubp_pg_control(
 	}
 }
 
-static void power_on_plane(
+static void power_on_plane_resources(
 	struct dce_hwseq *hws,
 	int plane_id)
 {
 	DC_LOGGER_INIT(hws->ctx->logger);
+
+	if (hws->funcs.dpp_root_clock_control)
+		hws->funcs.dpp_root_clock_control(hws, plane_id, true);
+
 	if (REG(DC_IP_REQUEST_CNTL)) {
 		REG_SET(DC_IP_REQUEST_CNTL, 0,
 				IP_REQUEST_EN, 1);
@@ -1237,11 +1241,15 @@ void dcn10_plane_atomic_power_down(struct dc *dc,
 			hws->funcs.hubp_pg_control(hws, hubp->inst, false);
 
 		dpp->funcs->dpp_reset(dpp);
+
 		REG_SET(DC_IP_REQUEST_CNTL, 0,
 				IP_REQUEST_EN, 0);
 		DC_LOG_DEBUG(
 				"Power gated front end %d\n", hubp->inst);
 	}
+
+	if (hws->funcs.dpp_root_clock_control)
+		hws->funcs.dpp_root_clock_control(hws, dpp->inst, false);
 }
 
 /* disable HW used by plane.
@@ -2450,7 +2458,7 @@ static void dcn10_enable_plane(
 
 	undo_DEGVIDCN10_253_wa(dc);
 
-	power_on_plane(dc->hwseq,
+	power_on_plane_resources(dc->hwseq,
 		pipe_ctx->plane_res.hubp->inst);
 
 	/* enable DCFCLK current DCHUB */
@@ -3369,7 +3377,9 @@ static bool dcn10_can_pipe_disable_cursor(struct pipe_ctx *pipe_ctx)
 	for (test_pipe = pipe_ctx->top_pipe; test_pipe;
 	     test_pipe = test_pipe->top_pipe) {
 		// Skip invisible layer and pipe-split plane on same layer
-		if (!test_pipe->plane_state->visible || test_pipe->plane_state->layer_index == cur_layer)
+		if (!test_pipe->plane_state ||
+		    !test_pipe->plane_state->visible ||
+		    test_pipe->plane_state->layer_index == cur_layer)
 			continue;
 
 		r2 = test_pipe->plane_res.scl_data.recout;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
index f348bc15a925..2d49e99a152c 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
@@ -1087,11 +1087,15 @@ void dcn20_blank_pixel_data(
 }
 
 
-static void dcn20_power_on_plane(
+static void dcn20_power_on_plane_resources(
 	struct dce_hwseq *hws,
 	struct pipe_ctx *pipe_ctx)
 {
 	DC_LOGGER_INIT(hws->ctx->logger);
+
+	if (hws->funcs.dpp_root_clock_control)
+		hws->funcs.dpp_root_clock_control(hws, pipe_ctx->plane_res.dpp->inst, true);
+
 	if (REG(DC_IP_REQUEST_CNTL)) {
 		REG_SET(DC_IP_REQUEST_CNTL, 0,
 				IP_REQUEST_EN, 1);
@@ -1115,7 +1119,7 @@ static void dcn20_enable_plane(struct dc *dc, struct pipe_ctx *pipe_ctx,
 	//if (dc->debug.sanity_checks) {
 	//	dcn10_verify_allow_pstate_change_high(dc);
 	//}
-	dcn20_power_on_plane(dc->hwseq, pipe_ctx);
+	dcn20_power_on_plane_resources(dc->hwseq, pipe_ctx);
 
 	/* enable DCFCLK current DCHUB */
 	pipe_ctx->plane_res.hubp->funcs->hubp_clk_cntl(pipe_ctx->plane_res.hubp, true);
diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
index 887081472c0d..ce6c70e25703 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
@@ -671,12 +671,15 @@ static const struct dc_debug_options debug_defaults_diags = {
 		.disable_pplib_wm_range = true,
 		.disable_stutter = true,
 		.disable_48mhz_pwrdwn = true,
-		.disable_psr = true,
 		.enable_tri_buf = true,
 		.use_max_lb = true
 };
 
 static const struct dc_panel_config panel_config_defaults = {
+		.psr = {
+			.disable_psr = false,
+			.disallow_psrsu = false,
+		},
 		.ilr = {
 			.optimize_edp_link_rate = true,
 		},
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
index e958f838c804..5a8d1a051314 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
@@ -723,7 +723,6 @@ static const struct dc_debug_options debug_defaults_drv = {
 	.underflow_assert_delay_us = 0xFFFFFFFF,
 	.dwb_fi_phase = -1, // -1 = disable,
 	.dmub_command_table = true,
-	.disable_psr = false,
 	.use_max_lb = true,
 	.exit_idle_opt_for_cursor_updates = true
 };
@@ -742,11 +741,17 @@ static const struct dc_debug_options debug_defaults_diags = {
 	.scl_reset_length10 = true,
 	.dwb_fi_phase = -1, // -1 = disable
 	.dmub_command_table = true,
-	.disable_psr = true,
 	.enable_tri_buf = true,
 	.use_max_lb = true
 };
 
+static const struct dc_panel_config panel_config_defaults = {
+	.psr = {
+		.disable_psr = false,
+		.disallow_psrsu = false,
+	},
+};
+
 static void dcn30_dpp_destroy(struct dpp **dpp)
 {
 	kfree(TO_DCN20_DPP(*dpp));
@@ -2214,6 +2219,11 @@ void dcn30_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_params
 	}
 }
 
+static void dcn30_get_panel_config_defaults(struct dc_panel_config *panel_config)
+{
+	*panel_config = panel_config_defaults;
+}
+
 static const struct resource_funcs dcn30_res_pool_funcs = {
 	.destroy = dcn30_destroy_resource_pool,
 	.link_enc_create = dcn30_link_encoder_create,
@@ -2233,6 +2243,7 @@ static const struct resource_funcs dcn30_res_pool_funcs = {
 	.release_post_bldn_3dlut = dcn30_release_post_bldn_3dlut,
 	.update_bw_bounding_box = dcn30_update_bw_bounding_box,
 	.patch_unknown_plane_state = dcn20_patch_unknown_plane_state,
+	.get_panel_config_defaults = dcn30_get_panel_config_defaults,
 };
 
 #define CTX ctx
diff --git a/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c b/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
index b925b6ddde5a..d3945876aced 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
@@ -112,10 +112,16 @@ static const struct dc_debug_options debug_defaults_diags = {
 		.dwb_fi_phase = -1, // -1 = disable
 		.dmub_command_table = true,
 		.enable_tri_buf = true,
-		.disable_psr = true,
 		.use_max_lb = true
 };
 
+static const struct dc_panel_config panel_config_defaults = {
+		.psr = {
+			.disable_psr = false,
+			.disallow_psrsu = false,
+		},
+};
+
 enum dcn302_clk_src_array_id {
 	DCN302_CLK_SRC_PLL0,
 	DCN302_CLK_SRC_PLL1,
@@ -1132,6 +1138,11 @@ void dcn302_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_param
 	DC_FP_END();
 }
 
+static void dcn302_get_panel_config_defaults(struct dc_panel_config *panel_config)
+{
+	*panel_config = panel_config_defaults;
+}
+
 static struct resource_funcs dcn302_res_pool_funcs = {
 		.destroy = dcn302_destroy_resource_pool,
 		.link_enc_create = dcn302_link_encoder_create,
@@ -1151,6 +1162,7 @@ static struct resource_funcs dcn302_res_pool_funcs = {
 		.release_post_bldn_3dlut = dcn30_release_post_bldn_3dlut,
 		.update_bw_bounding_box = dcn302_update_bw_bounding_box,
 		.patch_unknown_plane_state = dcn20_patch_unknown_plane_state,
+		.get_panel_config_defaults = dcn302_get_panel_config_defaults,
 };
 
 static struct dc_cap_funcs cap_funcs = {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c b/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c
index 527d5c902878..7e7f18bef098 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c
@@ -96,7 +96,13 @@ static const struct dc_debug_options debug_defaults_diags = {
 		.dwb_fi_phase = -1, // -1 = disable
 		.dmub_command_table = true,
 		.enable_tri_buf = true,
-		.disable_psr = true,
+};
+
+static const struct dc_panel_config panel_config_defaults = {
+		.psr = {
+			.disable_psr = false,
+			.disallow_psrsu = false,
+		},
 };
 
 enum dcn303_clk_src_array_id {
@@ -1055,6 +1061,10 @@ static void dcn303_destroy_resource_pool(struct resource_pool **pool)
 	*pool = NULL;
 }
 
+static void dcn303_get_panel_config_defaults(struct dc_panel_config *panel_config)
+{
+	*panel_config = panel_config_defaults;
+}
 
 void dcn303_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_params)
 {
@@ -1082,6 +1092,7 @@ static struct resource_funcs dcn303_res_pool_funcs = {
 		.release_post_bldn_3dlut = dcn30_release_post_bldn_3dlut,
 		.update_bw_bounding_box = dcn303_update_bw_bounding_box,
 		.patch_unknown_plane_state = dcn20_patch_unknown_plane_state,
+		.get_panel_config_defaults = dcn303_get_panel_config_defaults,
 };
 
 static struct dc_cap_funcs cap_funcs = {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dccg.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dccg.c
index 7f34418e6308..7d2b982506fd 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dccg.c
@@ -66,17 +66,8 @@ void dccg31_update_dpp_dto(struct dccg *dccg, int dpp_inst, int req_dppclk)
 		REG_UPDATE(DPPCLK_DTO_CTRL,
 				DPPCLK_DTO_ENABLE[dpp_inst], 1);
 	} else {
-		//DTO must be enabled to generate a 0Hz clock output
-		if (dccg->ctx->dc->debug.root_clock_optimization.bits.dpp) {
-			REG_UPDATE(DPPCLK_DTO_CTRL,
-					DPPCLK_DTO_ENABLE[dpp_inst], 1);
-			REG_SET_2(DPPCLK_DTO_PARAM[dpp_inst], 0,
-					DPPCLK0_DTO_PHASE, 0,
-					DPPCLK0_DTO_MODULO, 1);
-		} else {
-			REG_UPDATE(DPPCLK_DTO_CTRL,
-					DPPCLK_DTO_ENABLE[dpp_inst], 0);
-		}
+		REG_UPDATE(DPPCLK_DTO_CTRL,
+				DPPCLK_DTO_ENABLE[dpp_inst], 0);
 	}
 	dccg->pipe_dppclk_khz[dpp_inst] = req_dppclk;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
index d825f11b4fea..d3f76512841b 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
@@ -911,6 +911,10 @@ static const struct dc_debug_options debug_defaults_diags = {
 };
 
 static const struct dc_panel_config panel_config_defaults = {
+	.psr = {
+		.disable_psr = false,
+		.disallow_psrsu = false,
+	},
 	.ilr = {
 		.optimize_edp_link_rate = true,
 	},
diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dccg.c b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dccg.c
index 389a8938ee45..85ea3334355c 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dccg.c
@@ -289,8 +289,31 @@ static void dccg314_set_valid_pixel_rate(
 	dccg314_set_dtbclk_dto(dccg, &dto_params);
 }
 
+static void dccg314_dpp_root_clock_control(
+		struct dccg *dccg,
+		unsigned int dpp_inst,
+		bool clock_on)
+{
+	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
+
+	if (clock_on) {
+		/* turn off the DTO and leave phase/modulo at max */
+		REG_UPDATE(DPPCLK_DTO_CTRL, DPPCLK_DTO_ENABLE[dpp_inst], 0);
+		REG_SET_2(DPPCLK_DTO_PARAM[dpp_inst], 0,
+			  DPPCLK0_DTO_PHASE, 0xFF,
+			  DPPCLK0_DTO_MODULO, 0xFF);
+	} else {
+		/* turn on the DTO to generate a 0hz clock */
+		REG_UPDATE(DPPCLK_DTO_CTRL, DPPCLK_DTO_ENABLE[dpp_inst], 1);
+		REG_SET_2(DPPCLK_DTO_PARAM[dpp_inst], 0,
+			  DPPCLK0_DTO_PHASE, 0,
+			  DPPCLK0_DTO_MODULO, 1);
+	}
+}
+
 static const struct dccg_funcs dccg314_funcs = {
 	.update_dpp_dto = dccg31_update_dpp_dto,
+	.dpp_root_clock_control = dccg314_dpp_root_clock_control,
 	.get_dccg_ref_freq = dccg31_get_dccg_ref_freq,
 	.dccg_init = dccg31_init,
 	.set_dpstreamclk = dccg314_set_dpstreamclk,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_hwseq.c
index 8e824dc81ded..414d7358a075 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_hwseq.c
@@ -392,6 +392,16 @@ void dcn314_set_pixels_per_cycle(struct pipe_ctx *pipe_ctx)
 				pix_per_cycle);
 }
 
+void dcn314_dpp_root_clock_control(struct dce_hwseq *hws, unsigned int dpp_inst, bool clock_on)
+{
+	if (!hws->ctx->dc->debug.root_clock_optimization.bits.dpp)
+		return;
+
+	if (hws->ctx->dc->res_pool->dccg->funcs->dpp_root_clock_control)
+		hws->ctx->dc->res_pool->dccg->funcs->dpp_root_clock_control(
+			hws->ctx->dc->res_pool->dccg, dpp_inst, clock_on);
+}
+
 void dcn314_hubp_pg_control(struct dce_hwseq *hws, unsigned int hubp_inst, bool power_on)
 {
 	struct dc_context *ctx = hws->ctx;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_hwseq.h b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_hwseq.h
index c419d3dbdfee..c786d5e6a428 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_hwseq.h
@@ -43,4 +43,6 @@ void dcn314_set_pixels_per_cycle(struct pipe_ctx *pipe_ctx);
 
 void dcn314_hubp_pg_control(struct dce_hwseq *hws, unsigned int hubp_inst, bool power_on);
 
+void dcn314_dpp_root_clock_control(struct dce_hwseq *hws, unsigned int dpp_inst, bool clock_on);
+
 #endif /* __DC_HWSS_DCN314_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_init.c b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_init.c
index 343f4d9dd5e3..5267e901a35c 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_init.c
@@ -137,6 +137,7 @@ static const struct hwseq_private_funcs dcn314_private_funcs = {
 	.plane_atomic_disable = dcn20_plane_atomic_disable,
 	.plane_atomic_power_down = dcn10_plane_atomic_power_down,
 	.enable_power_gating_plane = dcn314_enable_power_gating_plane,
+	.dpp_root_clock_control = dcn314_dpp_root_clock_control,
 	.hubp_pg_control = dcn314_hubp_pg_control,
 	.program_all_writeback_pipes_in_tree = dcn30_program_all_writeback_pipes_in_tree,
 	.update_odm = dcn314_update_odm,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
index ffaa4e5b3fca..b7782433ce6b 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
@@ -884,6 +884,8 @@ static const struct dc_plane_cap plane_cap = {
 static const struct dc_debug_options debug_defaults_drv = {
 	.disable_z10 = false,
 	.enable_z9_disable_interface = true,
+	.minimum_z8_residency_time = 2000,
+	.psr_skip_crtc_disable = true,
 	.disable_dmcu = true,
 	.force_abm_enable = false,
 	.timing_trace = false,
@@ -940,6 +942,10 @@ static const struct dc_debug_options debug_defaults_diags = {
 };
 
 static const struct dc_panel_config panel_config_defaults = {
+	.psr = {
+		.disable_psr = false,
+		.disallow_psrsu = false,
+	},
 	.ilr = {
 		.optimize_edp_link_rate = true,
 	},
diff --git a/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c b/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c
index 58746c437554..31cbc5762eab 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c
@@ -907,6 +907,10 @@ static const struct dc_debug_options debug_defaults_diags = {
 };
 
 static const struct dc_panel_config panel_config_defaults = {
+	.psr = {
+		.disable_psr = false,
+		.disallow_psrsu = false,
+	},
 	.ilr = {
 		.optimize_edp_link_rate = true,
 	},
diff --git a/drivers/gpu/drm/amd/display/dc/dcn316/dcn316_resource.c b/drivers/gpu/drm/amd/display/dc/dcn316/dcn316_resource.c
index 6b40a11ac83a..af3eddc0cf32 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn316/dcn316_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn316/dcn316_resource.c
@@ -906,6 +906,10 @@ static const struct dc_debug_options debug_defaults_diags = {
 };
 
 static const struct dc_panel_config panel_config_defaults = {
+	.psr = {
+		.disable_psr = false,
+		.disallow_psrsu = false,
+	},
 	.ilr = {
 		.optimize_edp_link_rate = true,
 	},
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
index 1a85509c12f2..e9188bce62e0 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
@@ -984,6 +984,7 @@ void dcn32_init_hw(struct dc *dc)
 	if (dc->ctx->dmub_srv) {
 		dc_dmub_srv_query_caps_cmd(dc->ctx->dmub_srv->dmub);
 		dc->caps.dmub_caps.psr = dc->ctx->dmub_srv->dmub->feature_caps.psr;
+		dc->caps.dmub_caps.mclk_sw = dc->ctx->dmub_srv->dmub->feature_caps.fw_assisted_mclk_switch;
 	}
 
 	/* Enable support for ODM and windowed MPO if policy flag is set */
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
index a942e2812183..814620e6638f 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
@@ -1984,7 +1984,7 @@ int dcn32_populate_dml_pipes_from_context(
 	// In general cases we want to keep the dram clock change requirement
 	// (prefer configs that support MCLK switch). Only override to false
 	// for SubVP
-	if (subvp_in_use)
+	if (context->bw_ctx.bw.dcn.clk.fw_based_mclk_switching || subvp_in_use)
 		context->bw_ctx.dml.soc.dram_clock_change_requirement_final = false;
 	else
 		context->bw_ctx.dml.soc.dram_clock_change_requirement_final = true;
@@ -2037,6 +2037,14 @@ static struct resource_funcs dcn32_res_pool_funcs = {
 	.remove_phantom_pipes = dcn32_remove_phantom_pipes,
 };
 
+static uint32_t read_pipe_fuses(struct dc_context *ctx)
+{
+	uint32_t value = REG_READ(CC_DC_PIPE_DIS);
+	/* DCN32 support max 4 pipes */
+	value = value & 0xf;
+	return value;
+}
+
 
 static bool dcn32_resource_construct(
 	uint8_t num_virtual_links,
@@ -2079,7 +2087,7 @@ static bool dcn32_resource_construct(
 	pool->base.res_cap = &res_cap_dcn32;
 	/* max number of pipes for ASIC before checking for pipe fuses */
 	num_pipes  = pool->base.res_cap->num_timing_generator;
-	pipe_fuses = REG_READ(CC_DC_PIPE_DIS);
+	pipe_fuses = read_pipe_fuses(ctx);
 
 	for (i = 0; i < pool->base.res_cap->num_timing_generator; i++)
 		if (pipe_fuses & 1 << i)
diff --git a/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c b/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
index d320e21680da..213ff3672bd5 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
@@ -1621,6 +1621,14 @@ static struct resource_funcs dcn321_res_pool_funcs = {
 	.remove_phantom_pipes = dcn32_remove_phantom_pipes,
 };
 
+static uint32_t read_pipe_fuses(struct dc_context *ctx)
+{
+	uint32_t value = REG_READ(CC_DC_PIPE_DIS);
+	/* DCN321 support max 4 pipes */
+	value = value & 0xf;
+	return value;
+}
+
 
 static bool dcn321_resource_construct(
 	uint8_t num_virtual_links,
@@ -1663,7 +1671,7 @@ static bool dcn321_resource_construct(
 	pool->base.res_cap = &res_cap_dcn321;
 	/* max number of pipes for ASIC before checking for pipe fuses */
 	num_pipes  = pool->base.res_cap->num_timing_generator;
-	pipe_fuses = REG_READ(CC_DC_PIPE_DIS);
+	pipe_fuses = read_pipe_fuses(ctx);
 
 	for (i = 0; i < pool->base.res_cap->num_timing_generator; i++)
 		if (pipe_fuses & 1 << i)
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
index 45db40c41882..186538e3e3c0 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
@@ -963,6 +963,8 @@ static enum dcn_zstate_support_state  decide_zstate_support(struct dc *dc, struc
 	 * 	2. single eDP, on link 0, 1 plane and stutter period > 5ms
 	 * Z10 only cases:
 	 * 	1. single eDP, on link 0, 1 plane and stutter period >= 5ms
+	 * Z8 cases:
+	 * 	1. stutter period sufficient
 	 * Zstate not allowed cases:
 	 * 	1. Everything else
 	 */
@@ -971,6 +973,9 @@ static enum dcn_zstate_support_state  decide_zstate_support(struct dc *dc, struc
 	else if (context->stream_count == 1 &&  context->streams[0]->signal == SIGNAL_TYPE_EDP) {
 		struct dc_link *link = context->streams[0]->sink->link;
 		struct dc_stream_status *stream_status = &context->stream_status[0];
+		int minmum_z8_residency = dc->debug.minimum_z8_residency_time > 0 ? dc->debug.minimum_z8_residency_time : 1000;
+		bool allow_z8 = context->bw_ctx.dml.vba.StutterPeriod > (double)minmum_z8_residency;
+		bool is_pwrseq0 = link->link_index == 0;
 
 		if (dc_extended_blank_supported(dc)) {
 			for (i = 0; i < dc->res_pool->pipe_count; i++) {
@@ -983,18 +988,20 @@ static enum dcn_zstate_support_state  decide_zstate_support(struct dc *dc, struc
 				}
 			}
 		}
-		/* zstate only supported on PWRSEQ0  and when there's <2 planes*/
-		if (link->link_index != 0 || stream_status->plane_count > 1)
+
+		/* Don't support multi-plane configurations */
+		if (stream_status->plane_count > 1)
 			return DCN_ZSTATE_SUPPORT_DISALLOW;
 
-		if (context->bw_ctx.dml.vba.StutterPeriod > 5000.0 || optimized_min_dst_y_next_start_us > 5000)
+		if (is_pwrseq0 && (context->bw_ctx.dml.vba.StutterPeriod > 5000.0 || optimized_min_dst_y_next_start_us > 5000))
 			return DCN_ZSTATE_SUPPORT_ALLOW;
-		else if (link->psr_settings.psr_version == DC_PSR_VERSION_1 && !dc->debug.disable_psr)
-			return DCN_ZSTATE_SUPPORT_ALLOW_Z10_ONLY;
+		else if (is_pwrseq0 && link->psr_settings.psr_version == DC_PSR_VERSION_1 && !link->panel_config.psr.disable_psr)
+			return allow_z8 ? DCN_ZSTATE_SUPPORT_ALLOW_Z8_Z10_ONLY : DCN_ZSTATE_SUPPORT_ALLOW_Z10_ONLY;
 		else
-			return DCN_ZSTATE_SUPPORT_DISALLOW;
-	} else
+			return allow_z8 ? DCN_ZSTATE_SUPPORT_ALLOW_Z8_ONLY : DCN_ZSTATE_SUPPORT_DISALLOW;
+	} else {
 		return DCN_ZSTATE_SUPPORT_DISALLOW;
+	}
 }
 
 void dcn20_calculate_dlg_params(
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.c
index 990dbd736e2c..fdfb19337ea6 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.c
@@ -368,7 +368,9 @@ void dcn30_fpu_update_soc_for_wm_a(struct dc *dc, struct dc_state *context)
 	dc_assert_fp_enabled();
 
 	if (dc->clk_mgr->bw_params->wm_table.nv_entries[WM_A].valid) {
-		context->bw_ctx.dml.soc.dram_clock_change_latency_us = dc->clk_mgr->bw_params->wm_table.nv_entries[WM_A].dml_input.pstate_latency_us;
+		if (!context->bw_ctx.bw.dcn.clk.fw_based_mclk_switching ||
+				context->bw_ctx.dml.soc.dram_clock_change_latency_us == 0)
+			context->bw_ctx.dml.soc.dram_clock_change_latency_us = dc->clk_mgr->bw_params->wm_table.nv_entries[WM_A].dml_input.pstate_latency_us;
 		context->bw_ctx.dml.soc.sr_enter_plus_exit_time_us = dc->clk_mgr->bw_params->wm_table.nv_entries[WM_A].dml_input.sr_enter_plus_exit_time_us;
 		context->bw_ctx.dml.soc.sr_exit_time_us = dc->clk_mgr->bw_params->wm_table.nv_entries[WM_A].dml_input.sr_exit_time_us;
 	}
@@ -520,9 +522,21 @@ void dcn30_fpu_calculate_wm_and_dlg(
 		pipe_idx++;
 	}
 
-	DC_FP_START();
+	// WA: restrict FPO to use first non-strobe mode (NV24 BW issue)
+	if (context->bw_ctx.bw.dcn.clk.fw_based_mclk_switching &&
+			dc->dml.soc.num_chans <= 4 &&
+			context->bw_ctx.dml.vba.DRAMSpeed <= 1700 &&
+			context->bw_ctx.dml.vba.DRAMSpeed >= 1500) {
+
+		for (i = 0; i < dc->dml.soc.num_states; i++) {
+			if (dc->dml.soc.clock_limits[i].dram_speed_mts > 1700) {
+				context->bw_ctx.dml.vba.DRAMSpeed = dc->dml.soc.clock_limits[i].dram_speed_mts;
+				break;
+			}
+		}
+	}
+
 	dcn20_calculate_dlg_params(dc, context, pipes, pipe_cnt, vlevel);
-	DC_FP_END();
 
 	if (!pstate_en)
 		/* Restore full p-state latency */
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c
index 34b6c763a455..4f91e6475423 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c
@@ -148,8 +148,8 @@ struct _vcs_dpi_soc_bounding_box_st dcn3_14_soc = {
 	.num_states = 5,
 	.sr_exit_time_us = 16.5,
 	.sr_enter_plus_exit_time_us = 18.5,
-	.sr_exit_z8_time_us = 442.0,
-	.sr_enter_plus_exit_z8_time_us = 560.0,
+	.sr_exit_z8_time_us = 268.0,
+	.sr_enter_plus_exit_z8_time_us = 393.0,
 	.writeback_latency_us = 12.0,
 	.dram_channel_width_bytes = 4,
 	.round_trip_ping_latency_dcfclk_cycles = 106,
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
index e22b4b3880af..d2b184fdd7e0 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
@@ -1200,9 +1200,7 @@ static void dcn32_full_validate_bw_helper(struct dc *dc,
 			}
 		} else {
 			// Most populate phantom DLG params before programming hardware / timing for phantom pipe
-			DC_FP_START();
 			dcn32_helper_populate_phantom_dlg_params(dc, context, pipes, *pipe_cnt);
-			DC_FP_END();
 
 			/* Call validate_apply_pipe_split flags after calling DML getters for
 			 * phantom dlg params, or some of the VBA params indicating pipe split
@@ -1503,11 +1501,8 @@ bool dcn32_internal_validate_bw(struct dc *dc,
 
 	dml_log_pipe_params(&context->bw_ctx.dml, pipes, pipe_cnt);
 
-	if (!fast_validate) {
-		DC_FP_START();
+	if (!fast_validate)
 		dcn32_full_validate_bw_helper(dc, context, pipes, &vlevel, split, merge, &pipe_cnt);
-		DC_FP_END();
-	}
 
 	if (fast_validate ||
 			(dc->debug.dml_disallow_alternate_prefetch_modes &&
@@ -2172,9 +2167,7 @@ static int build_synthetic_soc_states(struct clk_bw_params *bw_params,
 		entry.fabricclk_mhz = 0;
 		entry.dram_speed_mts = 0;
 
-		DC_FP_START();
 		insert_entry_into_table_sorted(table, num_entries, &entry);
-		DC_FP_END();
 	}
 
 	// Insert the max DCFCLK
@@ -2182,9 +2175,7 @@ static int build_synthetic_soc_states(struct clk_bw_params *bw_params,
 	entry.fabricclk_mhz = 0;
 	entry.dram_speed_mts = 0;
 
-	DC_FP_START();
 	insert_entry_into_table_sorted(table, num_entries, &entry);
-	DC_FP_END();
 
 	// Insert the UCLK DPMS
 	for (i = 0; i < num_uclk_dpms; i++) {
@@ -2192,9 +2183,7 @@ static int build_synthetic_soc_states(struct clk_bw_params *bw_params,
 		entry.fabricclk_mhz = 0;
 		entry.dram_speed_mts = bw_params->clk_table.entries[i].memclk_mhz * 16;
 
-		DC_FP_START();
 		insert_entry_into_table_sorted(table, num_entries, &entry);
-		DC_FP_END();
 	}
 
 	// If FCLK is coarse grained, insert individual DPMs.
@@ -2204,9 +2193,7 @@ static int build_synthetic_soc_states(struct clk_bw_params *bw_params,
 			entry.fabricclk_mhz = bw_params->clk_table.entries[i].fclk_mhz;
 			entry.dram_speed_mts = 0;
 
-			DC_FP_START();
 			insert_entry_into_table_sorted(table, num_entries, &entry);
-			DC_FP_END();
 		}
 	}
 	// If FCLK fine grained, only insert max
@@ -2215,9 +2202,7 @@ static int build_synthetic_soc_states(struct clk_bw_params *bw_params,
 		entry.fabricclk_mhz = max_fclk_mhz;
 		entry.dram_speed_mts = 0;
 
-		DC_FP_START();
 		insert_entry_into_table_sorted(table, num_entries, &entry);
-		DC_FP_END();
 	}
 
 	// At this point, the table contains all "points of interest" based on
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
index 820042f6aaca..e02e9d4b04a9 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
@@ -807,7 +807,8 @@ static void DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerforman
 					v->SwathHeightY[k],
 					v->SwathHeightC[k],
 					TWait,
-					v->DRAMSpeedPerState[mode_lib->vba.VoltageLevel] <= MEM_STROBE_FREQ_MHZ ?
+					(v->DRAMSpeedPerState[mode_lib->vba.VoltageLevel] <= MEM_STROBE_FREQ_MHZ ||
+						v->DCFCLKPerState[mode_lib->vba.VoltageLevel] <= MIN_DCFCLK_FREQ_MHZ) ?
 							mode_lib->vba.ip.min_prefetch_in_strobe_us : 0,
 					/* Output */
 					&v->DSTXAfterScaler[k],
@@ -3288,7 +3289,7 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 							v->swath_width_chroma_ub_this_state[k],
 							v->SwathHeightYThisState[k],
 							v->SwathHeightCThisState[k], v->TWait,
-							v->DRAMSpeedPerState[i] <= MEM_STROBE_FREQ_MHZ ?
+							(v->DRAMSpeedPerState[i] <= MEM_STROBE_FREQ_MHZ || v->DCFCLKState[i][j] <= MIN_DCFCLK_FREQ_MHZ) ?
 									mode_lib->vba.ip.min_prefetch_in_strobe_us : 0,
 
 							/* Output */
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.h b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.h
index c8b28c83ddf4..e92eee2c664d 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.h
@@ -52,6 +52,7 @@
 #define BPP_BLENDED_PIPE 0xffffffff
 
 #define MEM_STROBE_FREQ_MHZ 1600
+#define MIN_DCFCLK_FREQ_MHZ 200
 #define MEM_STROBE_MAX_DELIVERY_TIME_US 60.0
 
 struct display_mode_lib;
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn321/dcn321_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn321/dcn321_fpu.c
index b80cef70fa60..383a409a3f54 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn321/dcn321_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn321/dcn321_fpu.c
@@ -106,16 +106,16 @@ struct _vcs_dpi_soc_bounding_box_st dcn3_21_soc = {
 	.clock_limits = {
 		{
 			.state = 0,
-			.dcfclk_mhz = 1564.0,
-			.fabricclk_mhz = 400.0,
-			.dispclk_mhz = 2150.0,
-			.dppclk_mhz = 2150.0,
+			.dcfclk_mhz = 1434.0,
+			.fabricclk_mhz = 2250.0,
+			.dispclk_mhz = 1720.0,
+			.dppclk_mhz = 1720.0,
 			.phyclk_mhz = 810.0,
 			.phyclk_d18_mhz = 667.0,
-			.phyclk_d32_mhz = 625.0,
+			.phyclk_d32_mhz = 313.0,
 			.socclk_mhz = 1200.0,
-			.dscclk_mhz = 716.667,
-			.dram_speed_mts = 1600.0,
+			.dscclk_mhz = 573.333,
+			.dram_speed_mts = 16000.0,
 			.dtbclk_mhz = 1564.0,
 		},
 	},
@@ -125,14 +125,14 @@ struct _vcs_dpi_soc_bounding_box_st dcn3_21_soc = {
 	.sr_exit_z8_time_us = 285.0,
 	.sr_enter_plus_exit_z8_time_us = 320,
 	.writeback_latency_us = 12.0,
-	.round_trip_ping_latency_dcfclk_cycles = 263,
+	.round_trip_ping_latency_dcfclk_cycles = 207,
 	.urgent_latency_pixel_data_only_us = 4,
 	.urgent_latency_pixel_mixed_with_vm_data_us = 4,
 	.urgent_latency_vm_data_only_us = 4,
-	.fclk_change_latency_us = 20,
-	.usr_retraining_latency_us = 2,
-	.smn_latency_us = 2,
-	.mall_allocated_for_dcn_mbytes = 64,
+	.fclk_change_latency_us = 7,
+	.usr_retraining_latency_us = 0,
+	.smn_latency_us = 0,
+	.mall_allocated_for_dcn_mbytes = 32,
 	.urgent_out_of_order_return_per_channel_pixel_only_bytes = 4096,
 	.urgent_out_of_order_return_per_channel_pixel_and_vm_bytes = 4096,
 	.urgent_out_of_order_return_per_channel_vm_only_bytes = 4096,
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h b/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h
index ce006762f257..ad6acd1b34e1 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h
@@ -148,18 +148,21 @@ struct dccg_funcs {
 		struct dccg *dccg,
 		int inst);
 
-void (*set_pixel_rate_div)(
-        struct dccg *dccg,
-        uint32_t otg_inst,
-        enum pixel_rate_div k1,
-        enum pixel_rate_div k2);
-
-void (*set_valid_pixel_rate)(
-        struct dccg *dccg,
-	int ref_dtbclk_khz,
-        int otg_inst,
-        int pixclk_khz);
+	void (*set_pixel_rate_div)(struct dccg *dccg,
+			uint32_t otg_inst,
+			enum pixel_rate_div k1,
+			enum pixel_rate_div k2);
 
+	void (*set_valid_pixel_rate)(
+			struct dccg *dccg,
+			int ref_dtbclk_khz,
+			int otg_inst,
+			int pixclk_khz);
+
+	void (*dpp_root_clock_control)(
+			struct dccg *dccg,
+			unsigned int dpp_inst,
+			bool clock_on);
 };
 
 #endif //__DAL_DCCG_H__
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer_private.h b/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer_private.h
index a4d61bb724b6..39bd53b79020 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer_private.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer_private.h
@@ -115,6 +115,10 @@ struct hwseq_private_funcs {
 	void (*plane_atomic_disable)(struct dc *dc, struct pipe_ctx *pipe_ctx);
 	void (*enable_power_gating_plane)(struct dce_hwseq *hws,
 		bool enable);
+	void (*dpp_root_clock_control)(
+			struct dce_hwseq *hws,
+			unsigned int dpp_inst,
+			bool clock_on);
 	void (*dpp_pg_control)(struct dce_hwseq *hws,
 			unsigned int dpp_inst,
 			bool power_on);
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn32.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn32.c
index a76da0131add..9c20516be066 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn32.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn32.c
@@ -130,12 +130,13 @@ void dmub_dcn32_reset(struct dmub_srv *dmub)
 	REG_WRITE(DMCUB_INBOX1_WPTR, 0);
 	REG_WRITE(DMCUB_OUTBOX1_RPTR, 0);
 	REG_WRITE(DMCUB_OUTBOX1_WPTR, 0);
+	REG_WRITE(DMCUB_OUTBOX0_RPTR, 0);
+	REG_WRITE(DMCUB_OUTBOX0_WPTR, 0);
 	REG_WRITE(DMCUB_SCRATCH0, 0);
 }
 
 void dmub_dcn32_reset_release(struct dmub_srv *dmub)
 {
-	REG_WRITE(DMCUB_GPINT_DATAIN1, 0);
 	REG_UPDATE(MMHUBBUB_SOFT_RESET, DMUIF_SOFT_RESET, 0);
 	REG_WRITE(DMCUB_SCRATCH15, dmub->psp_version & 0x001100FF);
 	REG_UPDATE_2(DMCUB_CNTL, DMCUB_ENABLE, 1, DMCUB_TRACEPORT_EN, 1);
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
index 1b300c569faf..69b51612c39a 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -36,6 +36,8 @@
 #define amdgpu_dpm_enable_bapm(adev, e) \
 		((adev)->powerplay.pp_funcs->enable_bapm((adev)->powerplay.pp_handle, (e)))
 
+#define amdgpu_dpm_is_legacy_dpm(adev) ((adev)->powerplay.pp_handle == (adev))
+
 int amdgpu_dpm_get_sclk(struct amdgpu_device *adev, bool low)
 {
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
@@ -1414,15 +1416,24 @@ int amdgpu_dpm_get_smu_prv_buf_details(struct amdgpu_device *adev,
 
 int amdgpu_dpm_is_overdrive_supported(struct amdgpu_device *adev)
 {
-	struct pp_hwmgr *hwmgr = adev->powerplay.pp_handle;
-	struct smu_context *smu = adev->powerplay.pp_handle;
+	if (is_support_sw_smu(adev)) {
+		struct smu_context *smu = adev->powerplay.pp_handle;
 
-	if ((is_support_sw_smu(adev) && smu->od_enabled) ||
-	    (is_support_sw_smu(adev) && smu->is_apu) ||
-		(!is_support_sw_smu(adev) && hwmgr->od_enabled))
-		return true;
+		return (smu->od_enabled || smu->is_apu);
+	} else {
+		struct pp_hwmgr *hwmgr;
 
-	return false;
+		/*
+		 * dpm on some legacy asics don't carry od_enabled member
+		 * as its pp_handle is casted directly from adev.
+		 */
+		if (amdgpu_dpm_is_legacy_dpm(adev))
+			return false;
+
+		hwmgr = (struct pp_hwmgr *)adev->powerplay.pp_handle;
+
+		return hwmgr->od_enabled;
+	}
 }
 
 int amdgpu_dpm_set_pp_table(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/bridge/lontium-lt8912b.c b/drivers/gpu/drm/bridge/lontium-lt8912b.c
index 1b74a913f1b8..5e419934d2a3 100644
--- a/drivers/gpu/drm/bridge/lontium-lt8912b.c
+++ b/drivers/gpu/drm/bridge/lontium-lt8912b.c
@@ -504,7 +504,6 @@ static int lt8912_attach_dsi(struct lt8912 *lt)
 	dsi->format = MIPI_DSI_FMT_RGB888;
 
 	dsi->mode_flags = MIPI_DSI_MODE_VIDEO |
-			  MIPI_DSI_MODE_VIDEO_BURST |
 			  MIPI_DSI_MODE_LPM |
 			  MIPI_DSI_MODE_NO_EOT_PACKET;
 
diff --git a/drivers/gpu/drm/i915/display/icl_dsi.c b/drivers/gpu/drm/i915/display/icl_dsi.c
index dd64b93c78e5..8219310025de 100644
--- a/drivers/gpu/drm/i915/display/icl_dsi.c
+++ b/drivers/gpu/drm/i915/display/icl_dsi.c
@@ -1210,7 +1210,7 @@ static void gen11_dsi_powerup_panel(struct intel_encoder *encoder)
 
 	/* panel power on related mipi dsi vbt sequences */
 	intel_dsi_vbt_exec_sequence(intel_dsi, MIPI_SEQ_POWER_ON);
-	intel_dsi_msleep(intel_dsi, intel_dsi->panel_on_delay);
+	msleep(intel_dsi->panel_on_delay);
 	intel_dsi_vbt_exec_sequence(intel_dsi, MIPI_SEQ_DEASSERT_RESET);
 	intel_dsi_vbt_exec_sequence(intel_dsi, MIPI_SEQ_INIT_OTP);
 	intel_dsi_vbt_exec_sequence(intel_dsi, MIPI_SEQ_DISPLAY_ON);
diff --git a/drivers/gpu/drm/i915/display/intel_dsi_vbt.c b/drivers/gpu/drm/i915/display/intel_dsi_vbt.c
index 2cbc1292ab38..f102c13cb959 100644
--- a/drivers/gpu/drm/i915/display/intel_dsi_vbt.c
+++ b/drivers/gpu/drm/i915/display/intel_dsi_vbt.c
@@ -762,17 +762,6 @@ void intel_dsi_vbt_exec_sequence(struct intel_dsi *intel_dsi,
 		gpiod_set_value_cansleep(intel_dsi->gpio_backlight, 0);
 }
 
-void intel_dsi_msleep(struct intel_dsi *intel_dsi, int msec)
-{
-	struct intel_connector *connector = intel_dsi->attached_connector;
-
-	/* For v3 VBTs in vid-mode the delays are part of the VBT sequences */
-	if (is_vid_mode(intel_dsi) && connector->panel.vbt.dsi.seq_version >= 3)
-		return;
-
-	msleep(msec);
-}
-
 void intel_dsi_log_params(struct intel_dsi *intel_dsi)
 {
 	struct drm_i915_private *i915 = to_i915(intel_dsi->base.base.dev);
diff --git a/drivers/gpu/drm/i915/display/intel_dsi_vbt.h b/drivers/gpu/drm/i915/display/intel_dsi_vbt.h
index dc642c1fe7ef..468d873fab1a 100644
--- a/drivers/gpu/drm/i915/display/intel_dsi_vbt.h
+++ b/drivers/gpu/drm/i915/display/intel_dsi_vbt.h
@@ -16,7 +16,6 @@ void intel_dsi_vbt_gpio_init(struct intel_dsi *intel_dsi, bool panel_is_on);
 void intel_dsi_vbt_gpio_cleanup(struct intel_dsi *intel_dsi);
 void intel_dsi_vbt_exec_sequence(struct intel_dsi *intel_dsi,
 				 enum mipi_seq seq_id);
-void intel_dsi_msleep(struct intel_dsi *intel_dsi, int msec);
 void intel_dsi_log_params(struct intel_dsi *intel_dsi);
 
 #endif /* __INTEL_DSI_VBT_H__ */
diff --git a/drivers/gpu/drm/i915/display/skl_scaler.c b/drivers/gpu/drm/i915/display/skl_scaler.c
index 4092679be21e..90f42f63128e 100644
--- a/drivers/gpu/drm/i915/display/skl_scaler.c
+++ b/drivers/gpu/drm/i915/display/skl_scaler.c
@@ -85,6 +85,10 @@ static u16 skl_scaler_calc_phase(int sub, int scale, bool chroma_cosited)
 #define ICL_MAX_SRC_H 4096
 #define ICL_MAX_DST_W 5120
 #define ICL_MAX_DST_H 4096
+#define MTL_MAX_SRC_W 4096
+#define MTL_MAX_SRC_H 8192
+#define MTL_MAX_DST_W 8192
+#define MTL_MAX_DST_H 8192
 #define SKL_MIN_YUV_420_SRC_W 16
 #define SKL_MIN_YUV_420_SRC_H 16
 
@@ -101,6 +105,10 @@ skl_update_scaler(struct intel_crtc_state *crtc_state, bool force_detach,
 	struct drm_i915_private *dev_priv = to_i915(crtc->base.dev);
 	const struct drm_display_mode *adjusted_mode =
 		&crtc_state->hw.adjusted_mode;
+	int pipe_src_w = drm_rect_width(&crtc_state->pipe_src);
+	int pipe_src_h = drm_rect_height(&crtc_state->pipe_src);
+	int min_src_w, min_src_h, min_dst_w, min_dst_h;
+	int max_src_w, max_src_h, max_dst_w, max_dst_h;
 
 	/*
 	 * Src coordinates are already rotated by 270 degrees for
@@ -155,15 +163,33 @@ skl_update_scaler(struct intel_crtc_state *crtc_state, bool force_detach,
 		return -EINVAL;
 	}
 
+	min_src_w = SKL_MIN_SRC_W;
+	min_src_h = SKL_MIN_SRC_H;
+	min_dst_w = SKL_MIN_DST_W;
+	min_dst_h = SKL_MIN_DST_H;
+
+	if (DISPLAY_VER(dev_priv) < 11) {
+		max_src_w = SKL_MAX_SRC_W;
+		max_src_h = SKL_MAX_SRC_H;
+		max_dst_w = SKL_MAX_DST_W;
+		max_dst_h = SKL_MAX_DST_H;
+	} else if (DISPLAY_VER(dev_priv) < 14) {
+		max_src_w = ICL_MAX_SRC_W;
+		max_src_h = ICL_MAX_SRC_H;
+		max_dst_w = ICL_MAX_DST_W;
+		max_dst_h = ICL_MAX_DST_H;
+	} else {
+		max_src_w = MTL_MAX_SRC_W;
+		max_src_h = MTL_MAX_SRC_H;
+		max_dst_w = MTL_MAX_DST_W;
+		max_dst_h = MTL_MAX_DST_H;
+	}
+
 	/* range checks */
-	if (src_w < SKL_MIN_SRC_W || src_h < SKL_MIN_SRC_H ||
-	    dst_w < SKL_MIN_DST_W || dst_h < SKL_MIN_DST_H ||
-	    (DISPLAY_VER(dev_priv) >= 11 &&
-	     (src_w > ICL_MAX_SRC_W || src_h > ICL_MAX_SRC_H ||
-	      dst_w > ICL_MAX_DST_W || dst_h > ICL_MAX_DST_H)) ||
-	    (DISPLAY_VER(dev_priv) < 11 &&
-	     (src_w > SKL_MAX_SRC_W || src_h > SKL_MAX_SRC_H ||
-	      dst_w > SKL_MAX_DST_W || dst_h > SKL_MAX_DST_H)))	{
+	if (src_w < min_src_w || src_h < min_src_h ||
+	    dst_w < min_dst_w || dst_h < min_dst_h ||
+	    src_w > max_src_w || src_h > max_src_h ||
+	    dst_w > max_dst_w || dst_h > max_dst_h) {
 		drm_dbg_kms(&dev_priv->drm,
 			    "scaler_user index %u.%u: src %ux%u dst %ux%u "
 			    "size is out of scaler range\n",
@@ -172,6 +198,21 @@ skl_update_scaler(struct intel_crtc_state *crtc_state, bool force_detach,
 		return -EINVAL;
 	}
 
+	/*
+	 * The pipe scaler does not use all the bits of PIPESRC, at least
+	 * on the earlier platforms. So even when we're scaling a plane
+	 * the *pipe* source size must not be too large. For simplicity
+	 * we assume the limits match the scaler source size limits. Might
+	 * not be 100% accurate on all platforms, but good enough for now.
+	 */
+	if (pipe_src_w > max_src_w || pipe_src_h > max_src_h) {
+		drm_dbg_kms(&dev_priv->drm,
+			    "scaler_user index %u.%u: pipe src size %ux%u "
+			    "is out of scaler range\n",
+			    crtc->pipe, scaler_user, pipe_src_w, pipe_src_h);
+		return -EINVAL;
+	}
+
 	/* mark this plane as a scaler user in crtc_state */
 	scaler_state->scaler_users |= (1 << scaler_user);
 	drm_dbg_kms(&dev_priv->drm, "scaler_user index %u.%u: "
diff --git a/drivers/gpu/drm/i915/display/vlv_dsi.c b/drivers/gpu/drm/i915/display/vlv_dsi.c
index 90e3e41095b3..00c80f29ad99 100644
--- a/drivers/gpu/drm/i915/display/vlv_dsi.c
+++ b/drivers/gpu/drm/i915/display/vlv_dsi.c
@@ -782,7 +782,6 @@ static void intel_dsi_pre_enable(struct intel_atomic_state *state,
 {
 	struct intel_dsi *intel_dsi = enc_to_intel_dsi(encoder);
 	struct intel_crtc *crtc = to_intel_crtc(pipe_config->uapi.crtc);
-	struct intel_connector *connector = to_intel_connector(conn_state->connector);
 	struct drm_i915_private *dev_priv = to_i915(crtc->base.dev);
 	enum pipe pipe = crtc->pipe;
 	enum port port;
@@ -830,21 +829,10 @@ static void intel_dsi_pre_enable(struct intel_atomic_state *state,
 	if (!IS_GEMINILAKE(dev_priv))
 		intel_dsi_prepare(encoder, pipe_config);
 
+	/* Give the panel time to power-on and then deassert its reset */
 	intel_dsi_vbt_exec_sequence(intel_dsi, MIPI_SEQ_POWER_ON);
-
-	/*
-	 * Give the panel time to power-on and then deassert its reset.
-	 * Depending on the VBT MIPI sequences version the deassert-seq
-	 * may contain the necessary delay, intel_dsi_msleep() will skip
-	 * the delay in that case. If there is no deassert-seq, then an
-	 * unconditional msleep is used to give the panel time to power-on.
-	 */
-	if (connector->panel.vbt.dsi.sequence[MIPI_SEQ_DEASSERT_RESET]) {
-		intel_dsi_msleep(intel_dsi, intel_dsi->panel_on_delay);
-		intel_dsi_vbt_exec_sequence(intel_dsi, MIPI_SEQ_DEASSERT_RESET);
-	} else {
-		msleep(intel_dsi->panel_on_delay);
-	}
+	msleep(intel_dsi->panel_on_delay);
+	intel_dsi_vbt_exec_sequence(intel_dsi, MIPI_SEQ_DEASSERT_RESET);
 
 	if (IS_GEMINILAKE(dev_priv)) {
 		glk_cold_boot = glk_dsi_enable_io(encoder);
@@ -878,7 +866,7 @@ static void intel_dsi_pre_enable(struct intel_atomic_state *state,
 		msleep(20); /* XXX */
 		for_each_dsi_port(port, intel_dsi->ports)
 			dpi_send_cmd(intel_dsi, TURN_ON, false, port);
-		intel_dsi_msleep(intel_dsi, 100);
+		msleep(100);
 
 		intel_dsi_vbt_exec_sequence(intel_dsi, MIPI_SEQ_DISPLAY_ON);
 
@@ -1006,7 +994,7 @@ static void intel_dsi_post_disable(struct intel_atomic_state *state,
 	/* Assert reset */
 	intel_dsi_vbt_exec_sequence(intel_dsi, MIPI_SEQ_ASSERT_RESET);
 
-	intel_dsi_msleep(intel_dsi, intel_dsi->panel_off_delay);
+	msleep(intel_dsi->panel_off_delay);
 	intel_dsi_vbt_exec_sequence(intel_dsi, MIPI_SEQ_POWER_OFF);
 
 	intel_dsi->panel_power_off_time = ktime_get_boottime();
diff --git a/drivers/gpu/drm/i915/i915_pci.c b/drivers/gpu/drm/i915/i915_pci.c
index fe4f279aaeb3..a2efc0b9d50c 100644
--- a/drivers/gpu/drm/i915/i915_pci.c
+++ b/drivers/gpu/drm/i915/i915_pci.c
@@ -1133,6 +1133,8 @@ static const struct intel_gt_definition xelpmp_extra_gt[] = {
 static const struct intel_device_info mtl_info = {
 	XE_HP_FEATURES,
 	XE_LPDP_FEATURES,
+	.__runtime.cpu_transcoder_mask = BIT(TRANSCODER_A) | BIT(TRANSCODER_B) |
+			       BIT(TRANSCODER_C) | BIT(TRANSCODER_D),
 	/*
 	 * Real graphics IP version will be obtained from hardware GMD_ID
 	 * register.  Value provided here is just for sanity checking.
diff --git a/drivers/gpu/drm/i915/i915_reg.h b/drivers/gpu/drm/i915/i915_reg.h
index 2372bfa04aa8..25015996f627 100644
--- a/drivers/gpu/drm/i915/i915_reg.h
+++ b/drivers/gpu/drm/i915/i915_reg.h
@@ -7840,8 +7840,8 @@ enum skl_power_gate {
 
 #define _PLANE_CSC_RY_GY_1(pipe)	_PIPE(pipe, _PLANE_CSC_RY_GY_1_A, \
 					      _PLANE_CSC_RY_GY_1_B)
-#define _PLANE_CSC_RY_GY_2(pipe)	_PIPE(pipe, _PLANE_INPUT_CSC_RY_GY_2_A, \
-					      _PLANE_INPUT_CSC_RY_GY_2_B)
+#define _PLANE_CSC_RY_GY_2(pipe)	_PIPE(pipe, _PLANE_CSC_RY_GY_2_A, \
+					      _PLANE_CSC_RY_GY_2_B)
 #define PLANE_CSC_COEFF(pipe, plane, index)	_MMIO_PLANE(plane, \
 							    _PLANE_CSC_RY_GY_1(pipe) +  (index) * 4, \
 							    _PLANE_CSC_RY_GY_2(pipe) + (index) * 4)
diff --git a/drivers/gpu/drm/msm/adreno/a4xx_gpu.c b/drivers/gpu/drm/msm/adreno/a4xx_gpu.c
index 7cb8d9849c07..a10feb8a4194 100644
--- a/drivers/gpu/drm/msm/adreno/a4xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a4xx_gpu.c
@@ -606,8 +606,7 @@ static int a4xx_pm_suspend(struct msm_gpu *gpu) {
 
 static int a4xx_get_timestamp(struct msm_gpu *gpu, uint64_t *value)
 {
-	*value = gpu_read64(gpu, REG_A4XX_RBBM_PERFCTR_CP_0_LO,
-		REG_A4XX_RBBM_PERFCTR_CP_0_HI);
+	*value = gpu_read64(gpu, REG_A4XX_RBBM_PERFCTR_CP_0_LO);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c b/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
index 02ff306f96f4..24feae285ccd 100644
--- a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
@@ -605,11 +605,9 @@ static int a5xx_ucode_init(struct msm_gpu *gpu)
 		a5xx_ucode_check_version(a5xx_gpu, a5xx_gpu->pfp_bo);
 	}
 
-	gpu_write64(gpu, REG_A5XX_CP_ME_INSTR_BASE_LO,
-		REG_A5XX_CP_ME_INSTR_BASE_HI, a5xx_gpu->pm4_iova);
+	gpu_write64(gpu, REG_A5XX_CP_ME_INSTR_BASE_LO, a5xx_gpu->pm4_iova);
 
-	gpu_write64(gpu, REG_A5XX_CP_PFP_INSTR_BASE_LO,
-		REG_A5XX_CP_PFP_INSTR_BASE_HI, a5xx_gpu->pfp_iova);
+	gpu_write64(gpu, REG_A5XX_CP_PFP_INSTR_BASE_LO, a5xx_gpu->pfp_iova);
 
 	return 0;
 }
@@ -868,8 +866,7 @@ static int a5xx_hw_init(struct msm_gpu *gpu)
 	 * memory rendering at this point in time and we don't want to block off
 	 * part of the virtual memory space.
 	 */
-	gpu_write64(gpu, REG_A5XX_RBBM_SECVID_TSB_TRUSTED_BASE_LO,
-		REG_A5XX_RBBM_SECVID_TSB_TRUSTED_BASE_HI, 0x00000000);
+	gpu_write64(gpu, REG_A5XX_RBBM_SECVID_TSB_TRUSTED_BASE_LO, 0x00000000);
 	gpu_write(gpu, REG_A5XX_RBBM_SECVID_TSB_TRUSTED_SIZE, 0x00000000);
 
 	/* Put the GPU into 64 bit by default */
@@ -908,8 +905,7 @@ static int a5xx_hw_init(struct msm_gpu *gpu)
 		return ret;
 
 	/* Set the ringbuffer address */
-	gpu_write64(gpu, REG_A5XX_CP_RB_BASE, REG_A5XX_CP_RB_BASE_HI,
-		gpu->rb[0]->iova);
+	gpu_write64(gpu, REG_A5XX_CP_RB_BASE, gpu->rb[0]->iova);
 
 	/*
 	 * If the microcode supports the WHERE_AM_I opcode then we can use that
@@ -936,7 +932,7 @@ static int a5xx_hw_init(struct msm_gpu *gpu)
 		}
 
 		gpu_write64(gpu, REG_A5XX_CP_RB_RPTR_ADDR,
-			REG_A5XX_CP_RB_RPTR_ADDR_HI, shadowptr(a5xx_gpu, gpu->rb[0]));
+			    shadowptr(a5xx_gpu, gpu->rb[0]));
 	} else if (gpu->nr_rings > 1) {
 		/* Disable preemption if WHERE_AM_I isn't available */
 		a5xx_preempt_fini(gpu);
@@ -1239,9 +1235,9 @@ static void a5xx_fault_detect_irq(struct msm_gpu *gpu)
 		gpu_read(gpu, REG_A5XX_RBBM_STATUS),
 		gpu_read(gpu, REG_A5XX_CP_RB_RPTR),
 		gpu_read(gpu, REG_A5XX_CP_RB_WPTR),
-		gpu_read64(gpu, REG_A5XX_CP_IB1_BASE, REG_A5XX_CP_IB1_BASE_HI),
+		gpu_read64(gpu, REG_A5XX_CP_IB1_BASE),
 		gpu_read(gpu, REG_A5XX_CP_IB1_BUFSZ),
-		gpu_read64(gpu, REG_A5XX_CP_IB2_BASE, REG_A5XX_CP_IB2_BASE_HI),
+		gpu_read64(gpu, REG_A5XX_CP_IB2_BASE),
 		gpu_read(gpu, REG_A5XX_CP_IB2_BUFSZ));
 
 	/* Turn off the hangcheck timer to keep it from bothering us */
@@ -1427,8 +1423,7 @@ static int a5xx_pm_suspend(struct msm_gpu *gpu)
 
 static int a5xx_get_timestamp(struct msm_gpu *gpu, uint64_t *value)
 {
-	*value = gpu_read64(gpu, REG_A5XX_RBBM_ALWAYSON_COUNTER_LO,
-		REG_A5XX_RBBM_ALWAYSON_COUNTER_HI);
+	*value = gpu_read64(gpu, REG_A5XX_RBBM_ALWAYSON_COUNTER_LO);
 
 	return 0;
 }
@@ -1465,8 +1460,7 @@ static int a5xx_crashdumper_run(struct msm_gpu *gpu,
 	if (IS_ERR_OR_NULL(dumper->ptr))
 		return -EINVAL;
 
-	gpu_write64(gpu, REG_A5XX_CP_CRASH_SCRIPT_BASE_LO,
-		REG_A5XX_CP_CRASH_SCRIPT_BASE_HI, dumper->iova);
+	gpu_write64(gpu, REG_A5XX_CP_CRASH_SCRIPT_BASE_LO, dumper->iova);
 
 	gpu_write(gpu, REG_A5XX_CP_CRASH_DUMP_CNTL, 1);
 
@@ -1666,8 +1660,7 @@ static u64 a5xx_gpu_busy(struct msm_gpu *gpu, unsigned long *out_sample_rate)
 {
 	u64 busy_cycles;
 
-	busy_cycles = gpu_read64(gpu, REG_A5XX_RBBM_PERFCTR_RBBM_0_LO,
-			REG_A5XX_RBBM_PERFCTR_RBBM_0_HI);
+	busy_cycles = gpu_read64(gpu, REG_A5XX_RBBM_PERFCTR_RBBM_0_LO);
 	*out_sample_rate = clk_get_rate(gpu->core_clk);
 
 	return busy_cycles;
diff --git a/drivers/gpu/drm/msm/adreno/a5xx_preempt.c b/drivers/gpu/drm/msm/adreno/a5xx_preempt.c
index e0eef47dae63..f58dd564d122 100644
--- a/drivers/gpu/drm/msm/adreno/a5xx_preempt.c
+++ b/drivers/gpu/drm/msm/adreno/a5xx_preempt.c
@@ -137,7 +137,6 @@ void a5xx_preempt_trigger(struct msm_gpu *gpu)
 
 	/* Set the address of the incoming preemption record */
 	gpu_write64(gpu, REG_A5XX_CP_CONTEXT_SWITCH_RESTORE_ADDR_LO,
-		REG_A5XX_CP_CONTEXT_SWITCH_RESTORE_ADDR_HI,
 		a5xx_gpu->preempt_iova[ring->id]);
 
 	a5xx_gpu->next_ring = ring;
@@ -212,8 +211,7 @@ void a5xx_preempt_hw_init(struct msm_gpu *gpu)
 	}
 
 	/* Write a 0 to signal that we aren't switching pagetables */
-	gpu_write64(gpu, REG_A5XX_CP_CONTEXT_SWITCH_SMMU_INFO_LO,
-		REG_A5XX_CP_CONTEXT_SWITCH_SMMU_INFO_HI, 0);
+	gpu_write64(gpu, REG_A5XX_CP_CONTEXT_SWITCH_SMMU_INFO_LO, 0);
 
 	/* Reset the preemption state */
 	set_preempt_state(a5xx_gpu, PREEMPT_NONE);
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index 9d7fc44c1e2a..95e73eddc5e9 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -247,8 +247,7 @@ static void a6xx_submit(struct msm_gpu *gpu, struct msm_gem_submit *submit)
 	OUT_RING(ring, submit->seqno);
 
 	trace_msm_gpu_submit_flush(submit,
-		gpu_read64(gpu, REG_A6XX_CP_ALWAYS_ON_COUNTER_LO,
-			REG_A6XX_CP_ALWAYS_ON_COUNTER_HI));
+		gpu_read64(gpu, REG_A6XX_CP_ALWAYS_ON_COUNTER_LO));
 
 	a6xx_flush(gpu, ring);
 }
@@ -947,8 +946,7 @@ static int a6xx_ucode_init(struct msm_gpu *gpu)
 		}
 	}
 
-	gpu_write64(gpu, REG_A6XX_CP_SQE_INSTR_BASE,
-		REG_A6XX_CP_SQE_INSTR_BASE+1, a6xx_gpu->sqe_iova);
+	gpu_write64(gpu, REG_A6XX_CP_SQE_INSTR_BASE, a6xx_gpu->sqe_iova);
 
 	return 0;
 }
@@ -999,8 +997,7 @@ static int hw_init(struct msm_gpu *gpu)
 	 * memory rendering at this point in time and we don't want to block off
 	 * part of the virtual memory space.
 	 */
-	gpu_write64(gpu, REG_A6XX_RBBM_SECVID_TSB_TRUSTED_BASE_LO,
-		REG_A6XX_RBBM_SECVID_TSB_TRUSTED_BASE_HI, 0x00000000);
+	gpu_write64(gpu, REG_A6XX_RBBM_SECVID_TSB_TRUSTED_BASE_LO, 0x00000000);
 	gpu_write(gpu, REG_A6XX_RBBM_SECVID_TSB_TRUSTED_SIZE, 0x00000000);
 
 	/* Turn on 64 bit addressing for all blocks */
@@ -1049,11 +1046,9 @@ static int hw_init(struct msm_gpu *gpu)
 
 	if (!adreno_is_a650_family(adreno_gpu)) {
 		/* Set the GMEM VA range [0x100000:0x100000 + gpu->gmem - 1] */
-		gpu_write64(gpu, REG_A6XX_UCHE_GMEM_RANGE_MIN_LO,
-			REG_A6XX_UCHE_GMEM_RANGE_MIN_HI, 0x00100000);
+		gpu_write64(gpu, REG_A6XX_UCHE_GMEM_RANGE_MIN_LO, 0x00100000);
 
 		gpu_write64(gpu, REG_A6XX_UCHE_GMEM_RANGE_MAX_LO,
-			REG_A6XX_UCHE_GMEM_RANGE_MAX_HI,
 			0x00100000 + adreno_gpu->gmem - 1);
 	}
 
@@ -1145,8 +1140,7 @@ static int hw_init(struct msm_gpu *gpu)
 		goto out;
 
 	/* Set the ringbuffer address */
-	gpu_write64(gpu, REG_A6XX_CP_RB_BASE, REG_A6XX_CP_RB_BASE_HI,
-		gpu->rb[0]->iova);
+	gpu_write64(gpu, REG_A6XX_CP_RB_BASE, gpu->rb[0]->iova);
 
 	/* Targets that support extended APRIV can use the RPTR shadow from
 	 * hardware but all the other ones need to disable the feature. Targets
@@ -1178,7 +1172,6 @@ static int hw_init(struct msm_gpu *gpu)
 		}
 
 		gpu_write64(gpu, REG_A6XX_CP_RB_RPTR_ADDR_LO,
-			REG_A6XX_CP_RB_RPTR_ADDR_HI,
 			shadowptr(a6xx_gpu, gpu->rb[0]));
 	}
 
@@ -1506,9 +1499,9 @@ static void a6xx_fault_detect_irq(struct msm_gpu *gpu)
 		gpu_read(gpu, REG_A6XX_RBBM_STATUS),
 		gpu_read(gpu, REG_A6XX_CP_RB_RPTR),
 		gpu_read(gpu, REG_A6XX_CP_RB_WPTR),
-		gpu_read64(gpu, REG_A6XX_CP_IB1_BASE, REG_A6XX_CP_IB1_BASE_HI),
+		gpu_read64(gpu, REG_A6XX_CP_IB1_BASE),
 		gpu_read(gpu, REG_A6XX_CP_IB1_REM_SIZE),
-		gpu_read64(gpu, REG_A6XX_CP_IB2_BASE, REG_A6XX_CP_IB2_BASE_HI),
+		gpu_read64(gpu, REG_A6XX_CP_IB2_BASE),
 		gpu_read(gpu, REG_A6XX_CP_IB2_REM_SIZE));
 
 	/* Turn off the hangcheck timer to keep it from bothering us */
@@ -1719,8 +1712,7 @@ static int a6xx_get_timestamp(struct msm_gpu *gpu, uint64_t *value)
 	/* Force the GPU power on so we can read this register */
 	a6xx_gmu_set_oob(&a6xx_gpu->gmu, GMU_OOB_PERFCOUNTER_SET);
 
-	*value = gpu_read64(gpu, REG_A6XX_CP_ALWAYS_ON_COUNTER_LO,
-			    REG_A6XX_CP_ALWAYS_ON_COUNTER_HI);
+	*value = gpu_read64(gpu, REG_A6XX_CP_ALWAYS_ON_COUNTER_LO);
 
 	a6xx_gmu_clear_oob(&a6xx_gpu->gmu, GMU_OOB_PERFCOUNTER_SET);
 
@@ -1858,6 +1850,39 @@ static uint32_t a6xx_get_rptr(struct msm_gpu *gpu, struct msm_ringbuffer *ring)
 	return ring->memptrs->rptr = gpu_read(gpu, REG_A6XX_CP_RB_RPTR);
 }
 
+static bool a6xx_progress(struct msm_gpu *gpu, struct msm_ringbuffer *ring)
+{
+	struct msm_cp_state cp_state = {
+		.ib1_base = gpu_read64(gpu, REG_A6XX_CP_IB1_BASE),
+		.ib2_base = gpu_read64(gpu, REG_A6XX_CP_IB2_BASE),
+		.ib1_rem  = gpu_read(gpu, REG_A6XX_CP_IB1_REM_SIZE),
+		.ib2_rem  = gpu_read(gpu, REG_A6XX_CP_IB2_REM_SIZE),
+	};
+	bool progress;
+
+	/*
+	 * Adjust the remaining data to account for what has already been
+	 * fetched from memory, but not yet consumed by the SQE.
+	 *
+	 * This is not *technically* correct, the amount buffered could
+	 * exceed the IB size due to hw prefetching ahead, but:
+	 *
+	 * (1) We aren't trying to find the exact position, just whether
+	 *     progress has been made
+	 * (2) The CP_REG_TO_MEM at the end of a submit should be enough
+	 *     to prevent prefetching into an unrelated submit.  (And
+	 *     either way, at some point the ROQ will be full.)
+	 */
+	cp_state.ib1_rem += gpu_read(gpu, REG_A6XX_CP_CSQ_IB1_STAT) >> 16;
+	cp_state.ib2_rem += gpu_read(gpu, REG_A6XX_CP_CSQ_IB2_STAT) >> 16;
+
+	progress = !!memcmp(&cp_state, &ring->last_cp_state, sizeof(cp_state));
+
+	ring->last_cp_state = cp_state;
+
+	return progress;
+}
+
 static u32 a618_get_speed_bin(u32 fuse)
 {
 	if (fuse == 0)
@@ -1974,6 +1999,7 @@ static const struct adreno_gpu_funcs funcs = {
 		.create_address_space = a6xx_create_address_space,
 		.create_private_address_space = a6xx_create_private_address_space,
 		.get_rptr = a6xx_get_rptr,
+		.progress = a6xx_progress,
 	},
 	.get_timestamp = a6xx_get_timestamp,
 };
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c
index a5c3d1ed255a..a023d5f962dc 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c
@@ -147,8 +147,7 @@ static int a6xx_crashdumper_run(struct msm_gpu *gpu,
 	/* Make sure all pending memory writes are posted */
 	wmb();
 
-	gpu_write64(gpu, REG_A6XX_CP_CRASH_SCRIPT_BASE_LO,
-		REG_A6XX_CP_CRASH_SCRIPT_BASE_HI, dumper->iova);
+	gpu_write64(gpu, REG_A6XX_CP_CRASH_SCRIPT_BASE_LO, dumper->iova);
 
 	gpu_write(gpu, REG_A6XX_CP_CRASH_DUMP_CNTL, 1);
 
diff --git a/drivers/gpu/drm/msm/adreno/adreno_device.c b/drivers/gpu/drm/msm/adreno/adreno_device.c
index cd009d56d35d..ed1e0c650bb1 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_device.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_device.c
@@ -440,20 +440,21 @@ struct msm_gpu *adreno_load_gpu(struct drm_device *dev)
 
 	ret = pm_runtime_get_sync(&pdev->dev);
 	if (ret < 0) {
-		pm_runtime_put_sync(&pdev->dev);
+		pm_runtime_put_noidle(&pdev->dev);
 		DRM_DEV_ERROR(dev->dev, "Couldn't power up the GPU: %d\n", ret);
-		return NULL;
+		goto err_disable_rpm;
 	}
 
 	mutex_lock(&gpu->lock);
 	ret = msm_gpu_hw_init(gpu);
 	mutex_unlock(&gpu->lock);
-	pm_runtime_put_autosuspend(&pdev->dev);
 	if (ret) {
 		DRM_DEV_ERROR(dev->dev, "gpu hw init failed: %d\n", ret);
-		return NULL;
+		goto err_put_rpm;
 	}
 
+	pm_runtime_put_autosuspend(&pdev->dev);
+
 #ifdef CONFIG_DEBUG_FS
 	if (gpu->funcs->debugfs_init) {
 		gpu->funcs->debugfs_init(gpu, dev->primary);
@@ -462,6 +463,13 @@ struct msm_gpu *adreno_load_gpu(struct drm_device *dev)
 #endif
 
 	return gpu;
+
+err_put_rpm:
+	pm_runtime_put_sync_suspend(&pdev->dev);
+err_disable_rpm:
+	pm_runtime_disable(&pdev->dev);
+
+	return NULL;
 }
 
 static int find_chipid(struct device *dev, struct adreno_rev *rev)
diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
index 5a0ff112634b..ac3d1d492a48 100644
--- a/drivers/gpu/drm/msm/msm_drv.c
+++ b/drivers/gpu/drm/msm/msm_drv.c
@@ -50,6 +50,8 @@
 #define MSM_VERSION_MINOR	9
 #define MSM_VERSION_PATCHLEVEL	0
 
+static void msm_deinit_vram(struct drm_device *ddev);
+
 static const struct drm_mode_config_funcs mode_config_funcs = {
 	.fb_create = msm_framebuffer_create,
 	.output_poll_changed = drm_fb_helper_output_poll_changed,
@@ -241,7 +243,8 @@ static int msm_drm_uninit(struct device *dev)
 		msm_fbdev_free(ddev);
 #endif
 
-	msm_disp_snapshot_destroy(ddev);
+	if (kms)
+		msm_disp_snapshot_destroy(ddev);
 
 	drm_mode_config_cleanup(ddev);
 
@@ -249,19 +252,16 @@ static int msm_drm_uninit(struct device *dev)
 		drm_bridge_remove(priv->bridges[i]);
 	priv->num_bridges = 0;
 
-	pm_runtime_get_sync(dev);
-	msm_irq_uninstall(ddev);
-	pm_runtime_put_sync(dev);
+	if (kms) {
+		pm_runtime_get_sync(dev);
+		msm_irq_uninstall(ddev);
+		pm_runtime_put_sync(dev);
+	}
 
 	if (kms && kms->funcs)
 		kms->funcs->destroy(kms);
 
-	if (priv->vram.paddr) {
-		unsigned long attrs = DMA_ATTR_NO_KERNEL_MAPPING;
-		drm_mm_takedown(&priv->vram.mm);
-		dma_free_attrs(dev, priv->vram.size, NULL,
-			       priv->vram.paddr, attrs);
-	}
+	msm_deinit_vram(ddev);
 
 	component_unbind_all(dev, ddev);
 
@@ -401,6 +401,19 @@ static int msm_init_vram(struct drm_device *dev)
 	return ret;
 }
 
+static void msm_deinit_vram(struct drm_device *ddev)
+{
+	struct msm_drm_private *priv = ddev->dev_private;
+	unsigned long attrs = DMA_ATTR_NO_KERNEL_MAPPING;
+
+	if (!priv->vram.paddr)
+		return;
+
+	drm_mm_takedown(&priv->vram.mm);
+	dma_free_attrs(ddev->dev, priv->vram.size, NULL, priv->vram.paddr,
+			attrs);
+}
+
 static int msm_drm_init(struct device *dev, const struct drm_driver *drv)
 {
 	struct msm_drm_private *priv = dev_get_drvdata(dev);
@@ -420,7 +433,10 @@ static int msm_drm_init(struct device *dev, const struct drm_driver *drv)
 	priv->dev = ddev;
 
 	priv->wq = alloc_ordered_workqueue("msm", 0);
-	priv->hangcheck_period = DRM_MSM_HANGCHECK_DEFAULT_PERIOD;
+	if (!priv->wq) {
+		ret = -ENOMEM;
+		goto err_put_dev;
+	}
 
 	INIT_LIST_HEAD(&priv->objects);
 	mutex_init(&priv->obj_lock);
@@ -443,12 +459,12 @@ static int msm_drm_init(struct device *dev, const struct drm_driver *drv)
 
 	ret = msm_init_vram(ddev);
 	if (ret)
-		return ret;
+		goto err_cleanup_mode_config;
 
 	/* Bind all our sub-components: */
 	ret = component_bind_all(dev, ddev);
 	if (ret)
-		return ret;
+		goto err_deinit_vram;
 
 	dma_set_max_seg_size(dev, UINT_MAX);
 
@@ -543,6 +559,17 @@ static int msm_drm_init(struct device *dev, const struct drm_driver *drv)
 
 err_msm_uninit:
 	msm_drm_uninit(dev);
+
+	return ret;
+
+err_deinit_vram:
+	msm_deinit_vram(ddev);
+err_cleanup_mode_config:
+	drm_mode_config_cleanup(ddev);
+	destroy_workqueue(priv->wq);
+err_put_dev:
+	drm_dev_put(ddev);
+
 	return ret;
 }
 
diff --git a/drivers/gpu/drm/msm/msm_drv.h b/drivers/gpu/drm/msm/msm_drv.h
index b2ea262296a4..d4e0ef608950 100644
--- a/drivers/gpu/drm/msm/msm_drv.h
+++ b/drivers/gpu/drm/msm/msm_drv.h
@@ -224,7 +224,13 @@ struct msm_drm_private {
 
 	struct drm_atomic_state *pm_state;
 
-	/* For hang detection, in ms */
+	/**
+	 * hangcheck_period: For hang detection, in ms
+	 *
+	 * Note that in practice, a submit/job will get at least two hangcheck
+	 * periods, due to checking for progress being implemented as simply
+	 * "have the CP position registers changed since last time?"
+	 */
 	unsigned int hangcheck_period;
 
 	/**
diff --git a/drivers/gpu/drm/msm/msm_gpu.c b/drivers/gpu/drm/msm/msm_gpu.c
index 4f495eecc34b..380249500325 100644
--- a/drivers/gpu/drm/msm/msm_gpu.c
+++ b/drivers/gpu/drm/msm/msm_gpu.c
@@ -494,6 +494,21 @@ static void hangcheck_timer_reset(struct msm_gpu *gpu)
 			round_jiffies_up(jiffies + msecs_to_jiffies(priv->hangcheck_period)));
 }
 
+static bool made_progress(struct msm_gpu *gpu, struct msm_ringbuffer *ring)
+{
+	if (ring->hangcheck_progress_retries >= DRM_MSM_HANGCHECK_PROGRESS_RETRIES)
+		return false;
+
+	if (!gpu->funcs->progress)
+		return false;
+
+	if (!gpu->funcs->progress(gpu, ring))
+		return false;
+
+	ring->hangcheck_progress_retries++;
+	return true;
+}
+
 static void hangcheck_handler(struct timer_list *t)
 {
 	struct msm_gpu *gpu = from_timer(gpu, t, hangcheck_timer);
@@ -504,9 +519,12 @@ static void hangcheck_handler(struct timer_list *t)
 	if (fence != ring->hangcheck_fence) {
 		/* some progress has been made.. ya! */
 		ring->hangcheck_fence = fence;
-	} else if (fence_before(fence, ring->fctx->last_fence)) {
+		ring->hangcheck_progress_retries = 0;
+	} else if (fence_before(fence, ring->fctx->last_fence) &&
+			!made_progress(gpu, ring)) {
 		/* no progress and not done.. hung! */
 		ring->hangcheck_fence = fence;
+		ring->hangcheck_progress_retries = 0;
 		DRM_DEV_ERROR(dev->dev, "%s: hangcheck detected gpu lockup rb %d!\n",
 				gpu->name, ring->id);
 		DRM_DEV_ERROR(dev->dev, "%s:     completed fence: %u\n",
@@ -832,6 +850,7 @@ int msm_gpu_init(struct drm_device *drm, struct platform_device *pdev,
 		struct msm_gpu *gpu, const struct msm_gpu_funcs *funcs,
 		const char *name, struct msm_gpu_config *config)
 {
+	struct msm_drm_private *priv = drm->dev_private;
 	int i, ret, nr_rings = config->nr_rings;
 	void *memptrs;
 	uint64_t memptrs_iova;
@@ -859,6 +878,16 @@ int msm_gpu_init(struct drm_device *drm, struct platform_device *pdev,
 	kthread_init_work(&gpu->recover_work, recover_worker);
 	kthread_init_work(&gpu->fault_work, fault_worker);
 
+	priv->hangcheck_period = DRM_MSM_HANGCHECK_DEFAULT_PERIOD;
+
+	/*
+	 * If progress detection is supported, halve the hangcheck timer
+	 * duration, as it takes two iterations of the hangcheck handler
+	 * to detect a hang.
+	 */
+	if (funcs->progress)
+		priv->hangcheck_period /= 2;
+
 	timer_setup(&gpu->hangcheck_timer, hangcheck_handler, 0);
 
 	spin_lock_init(&gpu->perf_lock);
diff --git a/drivers/gpu/drm/msm/msm_gpu.h b/drivers/gpu/drm/msm/msm_gpu.h
index a89bfdc3d7f9..732295e25683 100644
--- a/drivers/gpu/drm/msm/msm_gpu.h
+++ b/drivers/gpu/drm/msm/msm_gpu.h
@@ -78,6 +78,15 @@ struct msm_gpu_funcs {
 	struct msm_gem_address_space *(*create_private_address_space)
 		(struct msm_gpu *gpu);
 	uint32_t (*get_rptr)(struct msm_gpu *gpu, struct msm_ringbuffer *ring);
+
+	/**
+	 * progress: Has the GPU made progress?
+	 *
+	 * Return true if GPU position in cmdstream has advanced (or changed)
+	 * since the last call.  To avoid false negatives, this should account
+	 * for cmdstream that is buffered in this FIFO upstream of the CP fw.
+	 */
+	bool (*progress)(struct msm_gpu *gpu, struct msm_ringbuffer *ring);
 };
 
 /* Additional state for iommu faults: */
@@ -237,6 +246,7 @@ struct msm_gpu {
 #define DRM_MSM_INACTIVE_PERIOD   66 /* in ms (roughly four frames) */
 
 #define DRM_MSM_HANGCHECK_DEFAULT_PERIOD 500 /* in ms */
+#define DRM_MSM_HANGCHECK_PROGRESS_RETRIES 3
 	struct timer_list hangcheck_timer;
 
 	/* Fault info for most recent iova fault: */
@@ -548,7 +558,7 @@ static inline void gpu_rmw(struct msm_gpu *gpu, u32 reg, u32 mask, u32 or)
 	msm_rmw(gpu->mmio + (reg << 2), mask, or);
 }
 
-static inline u64 gpu_read64(struct msm_gpu *gpu, u32 lo, u32 hi)
+static inline u64 gpu_read64(struct msm_gpu *gpu, u32 reg)
 {
 	u64 val;
 
@@ -566,17 +576,17 @@ static inline u64 gpu_read64(struct msm_gpu *gpu, u32 lo, u32 hi)
 	 * when the lo is read, so make sure to read the lo first to trigger
 	 * that
 	 */
-	val = (u64) msm_readl(gpu->mmio + (lo << 2));
-	val |= ((u64) msm_readl(gpu->mmio + (hi << 2)) << 32);
+	val = (u64) msm_readl(gpu->mmio + (reg << 2));
+	val |= ((u64) msm_readl(gpu->mmio + ((reg + 1) << 2)) << 32);
 
 	return val;
 }
 
-static inline void gpu_write64(struct msm_gpu *gpu, u32 lo, u32 hi, u64 val)
+static inline void gpu_write64(struct msm_gpu *gpu, u32 reg, u64 val)
 {
 	/* Why not a writeq here? Read the screed above */
-	msm_writel(lower_32_bits(val), gpu->mmio + (lo << 2));
-	msm_writel(upper_32_bits(val), gpu->mmio + (hi << 2));
+	msm_writel(lower_32_bits(val), gpu->mmio + (reg << 2));
+	msm_writel(upper_32_bits(val), gpu->mmio + ((reg + 1) << 2));
 }
 
 int msm_gpu_pm_suspend(struct msm_gpu *gpu);
diff --git a/drivers/gpu/drm/msm/msm_ringbuffer.h b/drivers/gpu/drm/msm/msm_ringbuffer.h
index 2a5045abe46e..698b333abccd 100644
--- a/drivers/gpu/drm/msm/msm_ringbuffer.h
+++ b/drivers/gpu/drm/msm/msm_ringbuffer.h
@@ -35,6 +35,11 @@ struct msm_rbmemptrs {
 	volatile u64 ttbr0;
 };
 
+struct msm_cp_state {
+	uint64_t ib1_base, ib2_base;
+	uint32_t ib1_rem, ib2_rem;
+};
+
 struct msm_ringbuffer {
 	struct msm_gpu *gpu;
 	int id;
@@ -64,6 +69,29 @@ struct msm_ringbuffer {
 	uint64_t memptrs_iova;
 	struct msm_fence_context *fctx;
 
+	/**
+	 * hangcheck_progress_retries:
+	 *
+	 * The number of extra hangcheck duration cycles that we have given
+	 * due to it appearing that the GPU is making forward progress.
+	 *
+	 * For GPU generations which support progress detection (see.
+	 * msm_gpu_funcs::progress()), if the GPU appears to be making progress
+	 * (ie. the CP has advanced in the command stream, we'll allow up to
+	 * DRM_MSM_HANGCHECK_PROGRESS_RETRIES expirations of the hangcheck timer
+	 * before killing the job.  But to detect progress we need two sample
+	 * points, so the duration of the hangcheck timer is halved.  In other
+	 * words we'll let the submit run for up to:
+	 *
+	 * (DRM_MSM_HANGCHECK_DEFAULT_PERIOD / 2) * (DRM_MSM_HANGCHECK_PROGRESS_RETRIES + 1)
+	 */
+	int hangcheck_progress_retries;
+
+	/**
+	 * last_cp_state: The state of the CP at the last call to gpu->progress()
+	 */
+	struct msm_cp_state last_cp_state;
+
 	/*
 	 * preempt_lock protects preemption and serializes wptr updates against
 	 * preemption.  Can be aquired from irq context.
diff --git a/drivers/gpu/drm/panel/panel-orisetech-otm8009a.c b/drivers/gpu/drm/panel/panel-orisetech-otm8009a.c
index b4729a94c34a..898b892f1143 100644
--- a/drivers/gpu/drm/panel/panel-orisetech-otm8009a.c
+++ b/drivers/gpu/drm/panel/panel-orisetech-otm8009a.c
@@ -471,7 +471,7 @@ static int otm8009a_probe(struct mipi_dsi_device *dsi)
 		       DRM_MODE_CONNECTOR_DSI);
 
 	ctx->bl_dev = devm_backlight_device_register(dev, dev_name(dev),
-						     dsi->host->dev, ctx,
+						     dev, ctx,
 						     &otm8009a_backlight_ops,
 						     NULL);
 	if (IS_ERR(ctx->bl_dev)) {
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h
index 0bc1ebc43002..1ec9c53a7bf4 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h
@@ -1221,9 +1221,6 @@ int vmw_kms_write_svga(struct vmw_private *vmw_priv,
 bool vmw_kms_validate_mode_vram(struct vmw_private *dev_priv,
 				uint32_t pitch,
 				uint32_t height);
-u32 vmw_get_vblank_counter(struct drm_crtc *crtc);
-int vmw_enable_vblank(struct drm_crtc *crtc);
-void vmw_disable_vblank(struct drm_crtc *crtc);
 int vmw_kms_present(struct vmw_private *dev_priv,
 		    struct drm_file *file_priv,
 		    struct vmw_framebuffer *vfb,
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
index 13721bcf047c..aab6389cb4aa 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
@@ -31,7 +31,6 @@
 #include <drm/drm_fourcc.h>
 #include <drm/drm_rect.h>
 #include <drm/drm_sysfs.h>
-#include <drm/drm_vblank.h>
 
 #include "vmwgfx_kms.h"
 
@@ -832,15 +831,6 @@ void vmw_du_crtc_atomic_begin(struct drm_crtc *crtc,
 void vmw_du_crtc_atomic_flush(struct drm_crtc *crtc,
 			      struct drm_atomic_state *state)
 {
-	struct drm_pending_vblank_event *event = crtc->state->event;
-
-	if (event) {
-		crtc->state->event = NULL;
-
-		spin_lock_irq(&crtc->dev->event_lock);
-		drm_crtc_send_vblank_event(crtc, event);
-		spin_unlock_irq(&crtc->dev->event_lock);
-	}
 }
 
 
@@ -1274,70 +1264,10 @@ static void vmw_framebuffer_bo_destroy(struct drm_framebuffer *framebuffer)
 	kfree(vfbd);
 }
 
-static int vmw_framebuffer_bo_dirty(struct drm_framebuffer *framebuffer,
-				    struct drm_file *file_priv,
-				    unsigned int flags, unsigned int color,
-				    struct drm_clip_rect *clips,
-				    unsigned int num_clips)
-{
-	struct vmw_private *dev_priv = vmw_priv(framebuffer->dev);
-	struct vmw_framebuffer_bo *vfbd =
-		vmw_framebuffer_to_vfbd(framebuffer);
-	struct drm_clip_rect norect;
-	int ret, increment = 1;
-
-	drm_modeset_lock_all(&dev_priv->drm);
-
-	if (!num_clips) {
-		num_clips = 1;
-		clips = &norect;
-		norect.x1 = norect.y1 = 0;
-		norect.x2 = framebuffer->width;
-		norect.y2 = framebuffer->height;
-	} else if (flags & DRM_MODE_FB_DIRTY_ANNOTATE_COPY) {
-		num_clips /= 2;
-		increment = 2;
-	}
-
-	switch (dev_priv->active_display_unit) {
-	case vmw_du_legacy:
-		ret = vmw_kms_ldu_do_bo_dirty(dev_priv, &vfbd->base, 0, 0,
-					      clips, num_clips, increment);
-		break;
-	default:
-		ret = -EINVAL;
-		WARN_ONCE(true, "Dirty called with invalid display system.\n");
-		break;
-	}
-
-	vmw_cmd_flush(dev_priv, false);
-
-	drm_modeset_unlock_all(&dev_priv->drm);
-
-	return ret;
-}
-
-static int vmw_framebuffer_bo_dirty_ext(struct drm_framebuffer *framebuffer,
-					struct drm_file *file_priv,
-					unsigned int flags, unsigned int color,
-					struct drm_clip_rect *clips,
-					unsigned int num_clips)
-{
-	struct vmw_private *dev_priv = vmw_priv(framebuffer->dev);
-
-	if (dev_priv->active_display_unit == vmw_du_legacy &&
-	    vmw_cmd_supported(dev_priv))
-		return vmw_framebuffer_bo_dirty(framebuffer, file_priv, flags,
-						color, clips, num_clips);
-
-	return drm_atomic_helper_dirtyfb(framebuffer, file_priv, flags, color,
-					 clips, num_clips);
-}
-
 static const struct drm_framebuffer_funcs vmw_framebuffer_bo_funcs = {
 	.create_handle = vmw_framebuffer_bo_create_handle,
 	.destroy = vmw_framebuffer_bo_destroy,
-	.dirty = vmw_framebuffer_bo_dirty_ext,
+	.dirty = drm_atomic_helper_dirtyfb,
 };
 
 /*
@@ -2158,30 +2088,6 @@ bool vmw_kms_validate_mode_vram(struct vmw_private *dev_priv,
 		 dev_priv->max_primary_mem : dev_priv->vram_size);
 }
 
-
-/*
- * Function called by DRM code called with vbl_lock held.
- */
-u32 vmw_get_vblank_counter(struct drm_crtc *crtc)
-{
-	return 0;
-}
-
-/*
- * Function called by DRM code called with vbl_lock held.
- */
-int vmw_enable_vblank(struct drm_crtc *crtc)
-{
-	return -EINVAL;
-}
-
-/*
- * Function called by DRM code called with vbl_lock held.
- */
-void vmw_disable_vblank(struct drm_crtc *crtc)
-{
-}
-
 /**
  * vmw_du_update_layout - Update the display unit with topology from resolution
  * plugin and generate DRM uevent
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.h b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.h
index 85f86faa3243..b02d2793659f 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.h
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.h
@@ -517,11 +517,6 @@ void vmw_du_connector_destroy_state(struct drm_connector *connector,
  */
 int vmw_kms_ldu_init_display(struct vmw_private *dev_priv);
 int vmw_kms_ldu_close_display(struct vmw_private *dev_priv);
-int vmw_kms_ldu_do_bo_dirty(struct vmw_private *dev_priv,
-			    struct vmw_framebuffer *framebuffer,
-			    unsigned int flags, unsigned int color,
-			    struct drm_clip_rect *clips,
-			    unsigned int num_clips, int increment);
 int vmw_kms_update_proxy(struct vmw_resource *res,
 			 const struct drm_clip_rect *clips,
 			 unsigned num_clips,
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_ldu.c b/drivers/gpu/drm/vmwgfx/vmwgfx_ldu.c
index b8761f16dd78..ac72c20715f3 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_ldu.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_ldu.c
@@ -28,7 +28,6 @@
 #include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_fourcc.h>
-#include <drm/drm_vblank.h>
 
 #include "vmwgfx_kms.h"
 
@@ -235,9 +234,7 @@ static const struct drm_crtc_funcs vmw_legacy_crtc_funcs = {
 	.atomic_duplicate_state = vmw_du_crtc_duplicate_state,
 	.atomic_destroy_state = vmw_du_crtc_destroy_state,
 	.set_config = drm_atomic_helper_set_config,
-	.get_vblank_counter = vmw_get_vblank_counter,
-	.enable_vblank = vmw_enable_vblank,
-	.disable_vblank = vmw_disable_vblank,
+	.page_flip = drm_atomic_helper_page_flip,
 };
 
 
@@ -277,6 +274,12 @@ static const struct
 drm_connector_helper_funcs vmw_ldu_connector_helper_funcs = {
 };
 
+static int vmw_kms_ldu_do_bo_dirty(struct vmw_private *dev_priv,
+				   struct vmw_framebuffer *framebuffer,
+				   unsigned int flags, unsigned int color,
+				   struct drm_mode_rect *clips,
+				   unsigned int num_clips);
+
 /*
  * Legacy Display Plane Functions
  */
@@ -295,7 +298,6 @@ vmw_ldu_primary_plane_atomic_update(struct drm_plane *plane,
 	struct drm_framebuffer *fb;
 	struct drm_crtc *crtc = new_state->crtc ?: old_state->crtc;
 
-
 	ldu = vmw_crtc_to_ldu(crtc);
 	dev_priv = vmw_priv(plane->dev);
 	fb       = new_state->fb;
@@ -308,8 +310,31 @@ vmw_ldu_primary_plane_atomic_update(struct drm_plane *plane,
 		vmw_ldu_del_active(dev_priv, ldu);
 
 	vmw_ldu_commit_list(dev_priv);
-}
 
+	if (vfb && vmw_cmd_supported(dev_priv)) {
+		struct drm_mode_rect fb_rect = {
+			.x1 = 0,
+			.y1 = 0,
+			.x2 = vfb->base.width,
+			.y2 = vfb->base.height
+		};
+		struct drm_mode_rect *damage_rects = drm_plane_get_damage_clips(new_state);
+		u32 rect_count = drm_plane_get_damage_clips_count(new_state);
+		int ret;
+
+		if (!damage_rects) {
+			damage_rects = &fb_rect;
+			rect_count = 1;
+		}
+
+		ret = vmw_kms_ldu_do_bo_dirty(dev_priv, vfb, 0, 0, damage_rects, rect_count);
+
+		drm_WARN_ONCE(plane->dev, ret,
+			"vmw_kms_ldu_do_bo_dirty failed with: ret=%d\n", ret);
+
+		vmw_cmd_flush(dev_priv, false);
+	}
+}
 
 static const struct drm_plane_funcs vmw_ldu_plane_funcs = {
 	.update_plane = drm_atomic_helper_update_plane,
@@ -507,10 +532,6 @@ int vmw_kms_ldu_init_display(struct vmw_private *dev_priv)
 	dev_priv->ldu_priv->last_num_active = 0;
 	dev_priv->ldu_priv->fb = NULL;
 
-	ret = drm_vblank_init(dev, num_display_units);
-	if (ret != 0)
-		goto err_free;
-
 	vmw_kms_create_implicit_placement_property(dev_priv);
 
 	for (i = 0; i < num_display_units; ++i) {
@@ -544,11 +565,11 @@ int vmw_kms_ldu_close_display(struct vmw_private *dev_priv)
 }
 
 
-int vmw_kms_ldu_do_bo_dirty(struct vmw_private *dev_priv,
-			    struct vmw_framebuffer *framebuffer,
-			    unsigned int flags, unsigned int color,
-			    struct drm_clip_rect *clips,
-			    unsigned int num_clips, int increment)
+static int vmw_kms_ldu_do_bo_dirty(struct vmw_private *dev_priv,
+				   struct vmw_framebuffer *framebuffer,
+				   unsigned int flags, unsigned int color,
+				   struct drm_mode_rect *clips,
+				   unsigned int num_clips)
 {
 	size_t fifo_size;
 	int i;
@@ -564,7 +585,7 @@ int vmw_kms_ldu_do_bo_dirty(struct vmw_private *dev_priv,
 		return -ENOMEM;
 
 	memset(cmd, 0, fifo_size);
-	for (i = 0; i < num_clips; i++, clips += increment) {
+	for (i = 0; i < num_clips; i++, clips++) {
 		cmd[i].header = SVGA_CMD_UPDATE;
 		cmd[i].body.x = clips->x1;
 		cmd[i].body.y = clips->y1;
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c b/drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c
index 9c79873f62f0..e1f36a09c59c 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c
@@ -29,7 +29,6 @@
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_damage_helper.h>
 #include <drm/drm_fourcc.h>
-#include <drm/drm_vblank.h>
 
 #include "vmwgfx_kms.h"
 
@@ -320,9 +319,6 @@ static const struct drm_crtc_funcs vmw_screen_object_crtc_funcs = {
 	.atomic_destroy_state = vmw_du_crtc_destroy_state,
 	.set_config = drm_atomic_helper_set_config,
 	.page_flip = drm_atomic_helper_page_flip,
-	.get_vblank_counter = vmw_get_vblank_counter,
-	.enable_vblank = vmw_enable_vblank,
-	.disable_vblank = vmw_disable_vblank,
 };
 
 /*
@@ -730,7 +726,6 @@ vmw_sou_primary_plane_atomic_update(struct drm_plane *plane,
 	struct drm_plane_state *old_state = drm_atomic_get_old_plane_state(state, plane);
 	struct drm_plane_state *new_state = drm_atomic_get_new_plane_state(state, plane);
 	struct drm_crtc *crtc = new_state->crtc;
-	struct drm_pending_vblank_event *event = NULL;
 	struct vmw_fence_obj *fence = NULL;
 	int ret;
 
@@ -754,24 +749,6 @@ vmw_sou_primary_plane_atomic_update(struct drm_plane *plane,
 		return;
 	}
 
-	/* For error case vblank event is send from vmw_du_crtc_atomic_flush */
-	event = crtc->state->event;
-	if (event && fence) {
-		struct drm_file *file_priv = event->base.file_priv;
-
-		ret = vmw_event_fence_action_queue(file_priv,
-						   fence,
-						   &event->base,
-						   &event->event.vbl.tv_sec,
-						   &event->event.vbl.tv_usec,
-						   true);
-
-		if (unlikely(ret != 0))
-			DRM_ERROR("Failed to queue event on fence.\n");
-		else
-			crtc->state->event = NULL;
-	}
-
 	if (fence)
 		vmw_fence_obj_unreference(&fence);
 }
@@ -947,7 +924,7 @@ static int vmw_sou_init(struct vmw_private *dev_priv, unsigned unit)
 int vmw_kms_sou_init_display(struct vmw_private *dev_priv)
 {
 	struct drm_device *dev = &dev_priv->drm;
-	int i, ret;
+	int i;
 
 	/* Screen objects won't work if GMR's aren't available */
 	if (!dev_priv->has_gmr)
@@ -957,12 +934,6 @@ int vmw_kms_sou_init_display(struct vmw_private *dev_priv)
 		return -ENOSYS;
 	}
 
-	ret = -ENOMEM;
-
-	ret = drm_vblank_init(dev, VMWGFX_NUM_DISPLAY_UNITS);
-	if (unlikely(ret != 0))
-		return ret;
-
 	for (i = 0; i < VMWGFX_NUM_DISPLAY_UNITS; ++i)
 		vmw_sou_init(dev_priv, i);
 
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c b/drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c
index 8650c3aea8f0..0090abe89254 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c
@@ -29,7 +29,6 @@
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_damage_helper.h>
 #include <drm/drm_fourcc.h>
-#include <drm/drm_vblank.h>
 
 #include "vmwgfx_kms.h"
 #include "vmw_surface_cache.h"
@@ -925,9 +924,6 @@ static const struct drm_crtc_funcs vmw_stdu_crtc_funcs = {
 	.atomic_destroy_state = vmw_du_crtc_destroy_state,
 	.set_config = drm_atomic_helper_set_config,
 	.page_flip = drm_atomic_helper_page_flip,
-	.get_vblank_counter = vmw_get_vblank_counter,
-	.enable_vblank = vmw_enable_vblank,
-	.disable_vblank = vmw_disable_vblank,
 };
 
 
@@ -1591,7 +1587,6 @@ vmw_stdu_primary_plane_atomic_update(struct drm_plane *plane,
 	struct vmw_plane_state *vps = vmw_plane_state_to_vps(new_state);
 	struct drm_crtc *crtc = new_state->crtc;
 	struct vmw_screen_target_display_unit *stdu;
-	struct drm_pending_vblank_event *event;
 	struct vmw_fence_obj *fence = NULL;
 	struct vmw_private *dev_priv;
 	int ret;
@@ -1640,23 +1635,6 @@ vmw_stdu_primary_plane_atomic_update(struct drm_plane *plane,
 		return;
 	}
 
-	/* In case of error, vblank event is send in vmw_du_crtc_atomic_flush */
-	event = crtc->state->event;
-	if (event && fence) {
-		struct drm_file *file_priv = event->base.file_priv;
-
-		ret = vmw_event_fence_action_queue(file_priv,
-						   fence,
-						   &event->base,
-						   &event->event.vbl.tv_sec,
-						   &event->event.vbl.tv_usec,
-						   true);
-		if (ret)
-			DRM_ERROR("Failed to queue event on fence.\n");
-		else
-			crtc->state->event = NULL;
-	}
-
 	if (fence)
 		vmw_fence_obj_unreference(&fence);
 }
@@ -1883,10 +1861,6 @@ int vmw_kms_stdu_init_display(struct vmw_private *dev_priv)
 	if (!(dev_priv->capabilities & SVGA_CAP_GBOBJECTS))
 		return -ENOSYS;
 
-	ret = drm_vblank_init(dev, VMWGFX_NUM_DISPLAY_UNITS);
-	if (unlikely(ret != 0))
-		return ret;
-
 	dev_priv->active_display_unit = vmw_du_screen_target;
 
 	for (i = 0; i < VMWGFX_NUM_DISPLAY_UNITS; ++i) {
diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index 9312d611db8e..0c6a82c665c1 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -1308,6 +1308,9 @@ static void wacom_intuos_pro2_bt_pen(struct wacom_wac *wacom)
 
 	struct input_dev *pen_input = wacom->pen_input;
 	unsigned char *data = wacom->data;
+	int number_of_valid_frames = 0;
+	int time_interval = 15000000;
+	ktime_t time_packet_received = ktime_get();
 	int i;
 
 	if (wacom->features.type == INTUOSP2_BT ||
@@ -1328,12 +1331,30 @@ static void wacom_intuos_pro2_bt_pen(struct wacom_wac *wacom)
 		wacom->id[0] |= (wacom->serial[0] >> 32) & 0xFFFFF;
 	}
 
+	/* number of valid frames */
 	for (i = 0; i < pen_frames; i++) {
 		unsigned char *frame = &data[i*pen_frame_len + 1];
 		bool valid = frame[0] & 0x80;
+
+		if (valid)
+			number_of_valid_frames++;
+	}
+
+	if (number_of_valid_frames) {
+		if (wacom->hid_data.time_delayed)
+			time_interval = ktime_get() - wacom->hid_data.time_delayed;
+		time_interval /= number_of_valid_frames;
+		wacom->hid_data.time_delayed = time_packet_received;
+	}
+
+	for (i = 0; i < number_of_valid_frames; i++) {
+		unsigned char *frame = &data[i*pen_frame_len + 1];
+		bool valid = frame[0] & 0x80;
 		bool prox = frame[0] & 0x40;
 		bool range = frame[0] & 0x20;
 		bool invert = frame[0] & 0x10;
+		int frames_number_reversed = number_of_valid_frames - i - 1;
+		int event_timestamp = time_packet_received - frames_number_reversed * time_interval;
 
 		if (!valid)
 			continue;
@@ -1346,6 +1367,7 @@ static void wacom_intuos_pro2_bt_pen(struct wacom_wac *wacom)
 			wacom->tool[0] = 0;
 			wacom->id[0] = 0;
 			wacom->serial[0] = 0;
+			wacom->hid_data.time_delayed = 0;
 			return;
 		}
 
@@ -1382,6 +1404,7 @@ static void wacom_intuos_pro2_bt_pen(struct wacom_wac *wacom)
 						 get_unaligned_le16(&frame[11]));
 			}
 		}
+
 		if (wacom->tool[0]) {
 			input_report_abs(pen_input, ABS_PRESSURE, get_unaligned_le16(&frame[5]));
 			if (wacom->features.type == INTUOSP2_BT ||
@@ -1405,6 +1428,9 @@ static void wacom_intuos_pro2_bt_pen(struct wacom_wac *wacom)
 
 		wacom->shared->stylus_in_proximity = prox;
 
+		/* add timestamp to unpack the frames */
+		input_set_timestamp(pen_input, event_timestamp);
+
 		input_sync(pen_input);
 	}
 }
@@ -1895,6 +1921,7 @@ static void wacom_map_usage(struct input_dev *input, struct hid_usage *usage,
 	int fmax = field->logical_maximum;
 	unsigned int equivalent_usage = wacom_equivalent_usage(usage->hid);
 	int resolution_code = code;
+	int resolution = hidinput_calc_abs_res(field, resolution_code);
 
 	if (equivalent_usage == HID_DG_TWIST) {
 		resolution_code = ABS_RZ;
@@ -1915,8 +1942,15 @@ static void wacom_map_usage(struct input_dev *input, struct hid_usage *usage,
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
 	case EV_MSC:
diff --git a/drivers/hid/wacom_wac.h b/drivers/hid/wacom_wac.h
index 16f221388563..1a40bb8c5810 100644
--- a/drivers/hid/wacom_wac.h
+++ b/drivers/hid/wacom_wac.h
@@ -324,6 +324,7 @@ struct hid_data {
 	int ps_connected;
 	bool pad_input_event_flag;
 	unsigned short sequence_number;
+	int time_delayed;
 };
 
 struct wacom_remote_data {
diff --git a/drivers/i2c/busses/i2c-tegra.c b/drivers/i2c/busses/i2c-tegra.c
index 3869c258a529..2bc40f957e50 100644
--- a/drivers/i2c/busses/i2c-tegra.c
+++ b/drivers/i2c/busses/i2c-tegra.c
@@ -242,9 +242,10 @@ struct tegra_i2c_hw_feature {
  * @is_dvc: identifies the DVC I2C controller, has a different register layout
  * @is_vi: identifies the VI I2C controller, has a different register layout
  * @msg_complete: transfer completion notifier
+ * @msg_buf_remaining: size of unsent data in the message buffer
+ * @msg_len: length of message in current transfer
  * @msg_err: error code for completed message
  * @msg_buf: pointer to current message data
- * @msg_buf_remaining: size of unsent data in the message buffer
  * @msg_read: indicates that the transfer is a read access
  * @timings: i2c timings information like bus frequency
  * @multimaster_mode: indicates that I2C controller is in multi-master mode
@@ -277,6 +278,7 @@ struct tegra_i2c_dev {
 
 	struct completion msg_complete;
 	size_t msg_buf_remaining;
+	unsigned int msg_len;
 	int msg_err;
 	u8 *msg_buf;
 
@@ -1169,7 +1171,7 @@ static void tegra_i2c_push_packet_header(struct tegra_i2c_dev *i2c_dev,
 	else
 		i2c_writel(i2c_dev, packet_header, I2C_TX_FIFO);
 
-	packet_header = msg->len - 1;
+	packet_header = i2c_dev->msg_len - 1;
 
 	if (i2c_dev->dma_mode && !i2c_dev->msg_read)
 		*dma_buf++ = packet_header;
@@ -1242,20 +1244,32 @@ static int tegra_i2c_xfer_msg(struct tegra_i2c_dev *i2c_dev,
 		return err;
 
 	i2c_dev->msg_buf = msg->buf;
+	i2c_dev->msg_len = msg->len;
 
-	/* The condition true implies smbus block read and len is already read */
-	if (msg->flags & I2C_M_RECV_LEN && end_state != MSG_END_CONTINUE)
-		i2c_dev->msg_buf = msg->buf + 1;
-
-	i2c_dev->msg_buf_remaining = msg->len;
 	i2c_dev->msg_err = I2C_ERR_NONE;
 	i2c_dev->msg_read = !!(msg->flags & I2C_M_RD);
 	reinit_completion(&i2c_dev->msg_complete);
 
+	/*
+	 * For SMBUS block read command, read only 1 byte in the first transfer.
+	 * Adjust that 1 byte for the next transfer in the msg buffer and msg
+	 * length.
+	 */
+	if (msg->flags & I2C_M_RECV_LEN) {
+		if (end_state == MSG_END_CONTINUE) {
+			i2c_dev->msg_len = 1;
+		} else {
+			i2c_dev->msg_buf += 1;
+			i2c_dev->msg_len -= 1;
+		}
+	}
+
+	i2c_dev->msg_buf_remaining = i2c_dev->msg_len;
+
 	if (i2c_dev->msg_read)
-		xfer_size = msg->len;
+		xfer_size = i2c_dev->msg_len;
 	else
-		xfer_size = msg->len + I2C_PACKET_HEADER_SIZE;
+		xfer_size = i2c_dev->msg_len + I2C_PACKET_HEADER_SIZE;
 
 	xfer_size = ALIGN(xfer_size, BYTES_PER_FIFO_WORD);
 
@@ -1295,7 +1309,7 @@ static int tegra_i2c_xfer_msg(struct tegra_i2c_dev *i2c_dev,
 	if (!i2c_dev->msg_read) {
 		if (i2c_dev->dma_mode) {
 			memcpy(i2c_dev->dma_buf + I2C_PACKET_HEADER_SIZE,
-			       msg->buf, msg->len);
+			       msg->buf, i2c_dev->msg_len);
 
 			dma_sync_single_for_device(i2c_dev->dma_dev,
 						   i2c_dev->dma_phys,
@@ -1352,7 +1366,7 @@ static int tegra_i2c_xfer_msg(struct tegra_i2c_dev *i2c_dev,
 						i2c_dev->dma_phys,
 						xfer_size, DMA_FROM_DEVICE);
 
-			memcpy(i2c_dev->msg_buf, i2c_dev->dma_buf, msg->len);
+			memcpy(i2c_dev->msg_buf, i2c_dev->dma_buf, i2c_dev->msg_len);
 		}
 	}
 
@@ -1408,8 +1422,8 @@ static int tegra_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[],
 			ret = tegra_i2c_xfer_msg(i2c_dev, &msgs[i], MSG_END_CONTINUE);
 			if (ret)
 				break;
-			/* Set the read byte as msg len */
-			msgs[i].len = msgs[i].buf[0];
+			/* Set the msg length from first byte */
+			msgs[i].len += msgs[i].buf[0];
 			dev_dbg(i2c_dev->dev, "reading %d bytes\n", msgs[i].len);
 		}
 		ret = tegra_i2c_xfer_msg(i2c_dev, &msgs[i], end_type);
diff --git a/drivers/irqchip/irq-loongarch-cpu.c b/drivers/irqchip/irq-loongarch-cpu.c
index 741612ba6a52..fdec3e9cfacf 100644
--- a/drivers/irqchip/irq-loongarch-cpu.c
+++ b/drivers/irqchip/irq-loongarch-cpu.c
@@ -92,18 +92,16 @@ static const struct irq_domain_ops loongarch_cpu_intc_irq_domain_ops = {
 	.xlate = irq_domain_xlate_onecell,
 };
 
-static int __init
-liointc_parse_madt(union acpi_subtable_headers *header,
-		       const unsigned long end)
+static int __init liointc_parse_madt(union acpi_subtable_headers *header,
+					const unsigned long end)
 {
 	struct acpi_madt_lio_pic *liointc_entry = (struct acpi_madt_lio_pic *)header;
 
 	return liointc_acpi_init(irq_domain, liointc_entry);
 }
 
-static int __init
-eiointc_parse_madt(union acpi_subtable_headers *header,
-		       const unsigned long end)
+static int __init eiointc_parse_madt(union acpi_subtable_headers *header,
+					const unsigned long end)
 {
 	struct acpi_madt_eio_pic *eiointc_entry = (struct acpi_madt_eio_pic *)header;
 
@@ -112,16 +110,24 @@ eiointc_parse_madt(union acpi_subtable_headers *header,
 
 static int __init acpi_cascade_irqdomain_init(void)
 {
-	acpi_table_parse_madt(ACPI_MADT_TYPE_LIO_PIC,
-			      liointc_parse_madt, 0);
-	acpi_table_parse_madt(ACPI_MADT_TYPE_EIO_PIC,
-			      eiointc_parse_madt, 0);
+	int r;
+
+	r = acpi_table_parse_madt(ACPI_MADT_TYPE_LIO_PIC, liointc_parse_madt, 0);
+	if (r < 0)
+		return r;
+
+	r = acpi_table_parse_madt(ACPI_MADT_TYPE_EIO_PIC, eiointc_parse_madt, 0);
+	if (r < 0)
+		return r;
+
 	return 0;
 }
 
 static int __init cpuintc_acpi_init(union acpi_subtable_headers *header,
 				   const unsigned long end)
 {
+	int ret;
+
 	if (irq_domain)
 		return 0;
 
@@ -139,9 +145,9 @@ static int __init cpuintc_acpi_init(union acpi_subtable_headers *header,
 	set_handle_irq(&handle_cpu_irq);
 	acpi_set_irq_model(ACPI_IRQ_MODEL_LPIC, lpic_get_gsi_domain_id);
 	acpi_set_gsi_to_irq_fallback(lpic_gsi_to_irq);
-	acpi_cascade_irqdomain_init();
+	ret = acpi_cascade_irqdomain_init();
 
-	return 0;
+	return ret;
 }
 
 IRQCHIP_ACPI_DECLARE(cpuintc_v1, ACPI_MADT_TYPE_CORE_PIC,
diff --git a/drivers/irqchip/irq-loongson-eiointc.c b/drivers/irqchip/irq-loongson-eiointc.c
index 16e9af8d8b1e..ac04aeaa2d30 100644
--- a/drivers/irqchip/irq-loongson-eiointc.c
+++ b/drivers/irqchip/irq-loongson-eiointc.c
@@ -279,9 +279,6 @@ static void acpi_set_vec_parent(int node, struct irq_domain *parent, struct acpi
 {
 	int i;
 
-	if (cpu_has_flatmode)
-		node = cpu_to_node(node * CORES_PER_EIO_NODE);
-
 	for (i = 0; i < MAX_IO_PICS; i++) {
 		if (node == vec_group[i].node) {
 			vec_group[i].parent = parent;
@@ -301,9 +298,8 @@ static struct irq_domain *acpi_get_vec_parent(int node, struct acpi_vector_group
 	return NULL;
 }
 
-static int __init
-pch_pic_parse_madt(union acpi_subtable_headers *header,
-		       const unsigned long end)
+static int __init pch_pic_parse_madt(union acpi_subtable_headers *header,
+					const unsigned long end)
 {
 	struct acpi_madt_bio_pic *pchpic_entry = (struct acpi_madt_bio_pic *)header;
 	unsigned int node = (pchpic_entry->address >> 44) & 0xf;
@@ -312,37 +308,51 @@ pch_pic_parse_madt(union acpi_subtable_headers *header,
 	if (parent)
 		return pch_pic_acpi_init(parent, pchpic_entry);
 
-	return -EINVAL;
+	return 0;
 }
 
-static int __init
-pch_msi_parse_madt(union acpi_subtable_headers *header,
-		       const unsigned long end)
+static int __init pch_msi_parse_madt(union acpi_subtable_headers *header,
+					const unsigned long end)
 {
+	struct irq_domain *parent;
 	struct acpi_madt_msi_pic *pchmsi_entry = (struct acpi_madt_msi_pic *)header;
-	struct irq_domain *parent = acpi_get_vec_parent(eiointc_priv[nr_pics - 1]->node, msi_group);
+	int node;
+
+	if (cpu_has_flatmode)
+		node = cpu_to_node(eiointc_priv[nr_pics - 1]->node * CORES_PER_EIO_NODE);
+	else
+		node = eiointc_priv[nr_pics - 1]->node;
+
+	parent = acpi_get_vec_parent(node, msi_group);
 
 	if (parent)
 		return pch_msi_acpi_init(parent, pchmsi_entry);
 
-	return -EINVAL;
+	return 0;
 }
 
 static int __init acpi_cascade_irqdomain_init(void)
 {
-	acpi_table_parse_madt(ACPI_MADT_TYPE_BIO_PIC,
-			      pch_pic_parse_madt, 0);
-	acpi_table_parse_madt(ACPI_MADT_TYPE_MSI_PIC,
-			      pch_msi_parse_madt, 1);
+	int r;
+
+	r = acpi_table_parse_madt(ACPI_MADT_TYPE_BIO_PIC, pch_pic_parse_madt, 0);
+	if (r < 0)
+		return r;
+
+	r = acpi_table_parse_madt(ACPI_MADT_TYPE_MSI_PIC, pch_msi_parse_madt, 1);
+	if (r < 0)
+		return r;
+
 	return 0;
 }
 
 int __init eiointc_acpi_init(struct irq_domain *parent,
 				     struct acpi_madt_eio_pic *acpi_eiointc)
 {
-	int i, parent_irq;
+	int i, ret, parent_irq;
 	unsigned long node_map;
 	struct eiointc_priv *priv;
+	int node;
 
 	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
 	if (!priv)
@@ -380,15 +390,21 @@ int __init eiointc_acpi_init(struct irq_domain *parent,
 	parent_irq = irq_create_mapping(parent, acpi_eiointc->cascade);
 	irq_set_chained_handler_and_data(parent_irq, eiointc_irq_dispatch, priv);
 
-	cpuhp_setup_state_nocalls(CPUHP_AP_IRQ_LOONGARCH_STARTING,
+	if (nr_pics == 1) {
+		cpuhp_setup_state_nocalls(CPUHP_AP_IRQ_LOONGARCH_STARTING,
 				  "irqchip/loongarch/intc:starting",
 				  eiointc_router_init, NULL);
+	}
 
-	acpi_set_vec_parent(acpi_eiointc->node, priv->eiointc_domain, pch_group);
-	acpi_set_vec_parent(acpi_eiointc->node, priv->eiointc_domain, msi_group);
-	acpi_cascade_irqdomain_init();
-
-	return 0;
+	if (cpu_has_flatmode)
+		node = cpu_to_node(acpi_eiointc->node * CORES_PER_EIO_NODE);
+	else
+		node = acpi_eiointc->node;
+	acpi_set_vec_parent(node, priv->eiointc_domain, pch_group);
+	acpi_set_vec_parent(node, priv->eiointc_domain, msi_group);
+	ret = acpi_cascade_irqdomain_init();
+
+	return ret;
 
 out_free_handle:
 	irq_domain_free_fwnode(priv->domain_handle);
diff --git a/drivers/irqchip/irq-loongson-pch-pic.c b/drivers/irqchip/irq-loongson-pch-pic.c
index 03493cda65a3..679e2b68e6e9 100644
--- a/drivers/irqchip/irq-loongson-pch-pic.c
+++ b/drivers/irqchip/irq-loongson-pch-pic.c
@@ -328,9 +328,8 @@ int find_pch_pic(u32 gsi)
 	return -1;
 }
 
-static int __init
-pch_lpc_parse_madt(union acpi_subtable_headers *header,
-		       const unsigned long end)
+static int __init pch_lpc_parse_madt(union acpi_subtable_headers *header,
+					const unsigned long end)
 {
 	struct acpi_madt_lpc_pic *pchlpc_entry = (struct acpi_madt_lpc_pic *)header;
 
@@ -339,8 +338,12 @@ pch_lpc_parse_madt(union acpi_subtable_headers *header,
 
 static int __init acpi_cascade_irqdomain_init(void)
 {
-	acpi_table_parse_madt(ACPI_MADT_TYPE_LPC_PIC,
-			      pch_lpc_parse_madt, 0);
+	int r;
+
+	r = acpi_table_parse_madt(ACPI_MADT_TYPE_LPC_PIC, pch_lpc_parse_madt, 0);
+	if (r < 0)
+		return r;
+
 	return 0;
 }
 
@@ -350,6 +353,9 @@ int __init pch_pic_acpi_init(struct irq_domain *parent,
 	int ret, vec_base;
 	struct fwnode_handle *domain_handle;
 
+	if (find_pch_pic(acpi_pchpic->gsi_base) >= 0)
+		return 0;
+
 	vec_base = acpi_pchpic->gsi_base - GSI_MIN_PCH_IRQ;
 
 	domain_handle = irq_domain_alloc_fwnode(&acpi_pchpic->address);
@@ -367,7 +373,7 @@ int __init pch_pic_acpi_init(struct irq_domain *parent,
 	}
 
 	if (acpi_pchpic->id == 0)
-		acpi_cascade_irqdomain_init();
+		ret = acpi_cascade_irqdomain_init();
 
 	return ret;
 }
diff --git a/drivers/mailbox/zynqmp-ipi-mailbox.c b/drivers/mailbox/zynqmp-ipi-mailbox.c
index e02a4a18e8c2..d097f45b0e5f 100644
--- a/drivers/mailbox/zynqmp-ipi-mailbox.c
+++ b/drivers/mailbox/zynqmp-ipi-mailbox.c
@@ -110,7 +110,7 @@ struct zynqmp_ipi_pdata {
 	unsigned int method;
 	u32 local_id;
 	int num_mboxes;
-	struct zynqmp_ipi_mbox *ipi_mboxes;
+	struct zynqmp_ipi_mbox ipi_mboxes[];
 };
 
 static struct device_driver zynqmp_ipi_mbox_driver = {
@@ -634,8 +634,13 @@ static int zynqmp_ipi_probe(struct platform_device *pdev)
 	struct zynqmp_ipi_mbox *mbox;
 	int num_mboxes, ret = -EINVAL;
 
-	num_mboxes = of_get_child_count(np);
-	pdata = devm_kzalloc(dev, sizeof(*pdata) + (num_mboxes * sizeof(*mbox)),
+	num_mboxes = of_get_available_child_count(np);
+	if (num_mboxes == 0) {
+		dev_err(dev, "mailbox nodes not available\n");
+		return -EINVAL;
+	}
+
+	pdata = devm_kzalloc(dev, struct_size(pdata, ipi_mboxes, num_mboxes),
 			     GFP_KERNEL);
 	if (!pdata)
 		return -ENOMEM;
@@ -649,8 +654,6 @@ static int zynqmp_ipi_probe(struct platform_device *pdev)
 	}
 
 	pdata->num_mboxes = num_mboxes;
-	pdata->ipi_mboxes = (struct zynqmp_ipi_mbox *)
-			    ((char *)pdata + sizeof(*pdata));
 
 	mbox = pdata->ipi_mboxes;
 	for_each_available_child_of_node(np, nc) {
diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index 9a7bea365acb..dc4d86ceee44 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -2440,6 +2440,9 @@ static void spi_nor_init_flags(struct spi_nor *nor)
 
 	if (flags & NO_CHIP_ERASE)
 		nor->flags |= SNOR_F_NO_OP_CHIP_ERASE;
+
+	if (flags & SPI_NOR_RWW)
+		nor->flags |= SNOR_F_RWW;
 }
 
 /**
@@ -2578,6 +2581,12 @@ static void spi_nor_init_default_params(struct spi_nor *nor)
 	params->hwcaps.mask |= SNOR_HWCAPS_PP;
 	spi_nor_set_pp_settings(&params->page_programs[SNOR_CMD_PP],
 				SPINOR_OP_PP, SNOR_PROTO_1_1_1);
+
+	if (info->flags & SPI_NOR_QUAD_PP) {
+		params->hwcaps.mask |= SNOR_HWCAPS_PP_1_1_4;
+		spi_nor_set_pp_settings(&params->page_programs[SNOR_CMD_PP_1_1_4],
+					SPINOR_OP_PP_1_1_4, SNOR_PROTO_1_1_4);
+	}
 }
 
 /**
@@ -2933,6 +2942,9 @@ static void spi_nor_set_mtd_info(struct spi_nor *nor)
 		mtd->name = dev_name(dev);
 	mtd->type = MTD_NORFLASH;
 	mtd->flags = MTD_CAP_NORFLASH;
+	/* Unset BIT_WRITEABLE to enable JFFS2 write buffer for ECC'd NOR */
+	if (nor->flags & SNOR_F_ECC)
+		mtd->flags &= ~MTD_BIT_WRITEABLE;
 	if (nor->info->flags & SPI_NOR_NO_ERASE)
 		mtd->flags |= MTD_NO_ERASE;
 	else
diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
index 00bf0d0e955a..290613fd63ae 100644
--- a/drivers/mtd/spi-nor/core.h
+++ b/drivers/mtd/spi-nor/core.h
@@ -130,6 +130,8 @@ enum spi_nor_option_flags {
 	SNOR_F_IO_MODE_EN_VOLATILE = BIT(11),
 	SNOR_F_SOFT_RESET	= BIT(12),
 	SNOR_F_SWP_IS_VOLATILE	= BIT(13),
+	SNOR_F_RWW		= BIT(14),
+	SNOR_F_ECC		= BIT(15),
 };
 
 struct spi_nor_read_command {
@@ -458,6 +460,8 @@ struct spi_nor_fixups {
  *   SPI_NOR_NO_ERASE:        no erase command needed.
  *   NO_CHIP_ERASE:           chip does not support chip erase.
  *   SPI_NOR_NO_FR:           can't do fastread.
+ *   SPI_NOR_QUAD_PP:         flash supports Quad Input Page Program.
+ *   SPI_NOR_RWW:             flash supports reads while write.
  *
  * @no_sfdp_flags:  flags that indicate support that can be discovered via SFDP.
  *                  Used when SFDP tables are not defined in the flash. These
@@ -507,6 +511,8 @@ struct flash_info {
 #define SPI_NOR_NO_ERASE		BIT(6)
 #define NO_CHIP_ERASE			BIT(7)
 #define SPI_NOR_NO_FR			BIT(8)
+#define SPI_NOR_QUAD_PP			BIT(9)
+#define SPI_NOR_RWW			BIT(10)
 
 	u8 no_sfdp_flags;
 #define SPI_NOR_SKIP_SFDP		BIT(0)
diff --git a/drivers/mtd/spi-nor/debugfs.c b/drivers/mtd/spi-nor/debugfs.c
index 5f56b23205d8..6d6bd559db8f 100644
--- a/drivers/mtd/spi-nor/debugfs.c
+++ b/drivers/mtd/spi-nor/debugfs.c
@@ -25,6 +25,8 @@ static const char *const snor_f_names[] = {
 	SNOR_F_NAME(IO_MODE_EN_VOLATILE),
 	SNOR_F_NAME(SOFT_RESET),
 	SNOR_F_NAME(SWP_IS_VOLATILE),
+	SNOR_F_NAME(RWW),
+	SNOR_F_NAME(ECC),
 };
 #undef SNOR_F_NAME
 
diff --git a/drivers/mtd/spi-nor/issi.c b/drivers/mtd/spi-nor/issi.c
index 89a66a19d754..7c8eee808dda 100644
--- a/drivers/mtd/spi-nor/issi.c
+++ b/drivers/mtd/spi-nor/issi.c
@@ -73,6 +73,7 @@ static const struct flash_info issi_nor_parts[] = {
 	{ "is25wp256", INFO(0x9d7019, 0, 64 * 1024, 512)
 		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ)
 		FIXUP_FLAGS(SPI_NOR_4B_OPCODES)
+		FLAGS(SPI_NOR_QUAD_PP)
 		.fixups = &is25lp256_fixups },
 
 	/* PMC */
diff --git a/drivers/mtd/spi-nor/spansion.c b/drivers/mtd/spi-nor/spansion.c
index 7ac2ad1a8d57..7e7c68fc7776 100644
--- a/drivers/mtd/spi-nor/spansion.c
+++ b/drivers/mtd/spi-nor/spansion.c
@@ -212,6 +212,17 @@ static int cypress_nor_set_page_size(struct spi_nor *nor)
 	return 0;
 }
 
+static void cypress_nor_ecc_init(struct spi_nor *nor)
+{
+	/*
+	 * Programming is supported only in 16-byte ECC data unit granularity.
+	 * Byte-programming, bit-walking, or multiple program operations to the
+	 * same ECC data unit without an erase are not allowed.
+	 */
+	nor->params->writesize = 16;
+	nor->flags |= SNOR_F_ECC;
+}
+
 static int
 s25hx_t_post_bfpt_fixup(struct spi_nor *nor,
 			const struct sfdp_parameter_header *bfpt_header,
@@ -249,13 +260,10 @@ static void s25hx_t_post_sfdp_fixup(struct spi_nor *nor)
 
 static void s25hx_t_late_init(struct spi_nor *nor)
 {
-	struct spi_nor_flash_parameter *params = nor->params;
-
 	/* Fast Read 4B requires mode cycles */
-	params->reads[SNOR_CMD_READ_FAST].num_mode_clocks = 8;
+	nor->params->reads[SNOR_CMD_READ_FAST].num_mode_clocks = 8;
 
-	/* The writesize should be ECC data unit size */
-	params->writesize = 16;
+	cypress_nor_ecc_init(nor);
 }
 
 static struct spi_nor_fixups s25hx_t_fixups = {
@@ -280,12 +288,6 @@ static int cypress_nor_octal_dtr_enable(struct spi_nor *nor, bool enable)
 			cypress_nor_octal_dtr_dis(nor);
 }
 
-static void s28hs512t_default_init(struct spi_nor *nor)
-{
-	nor->params->octal_dtr_enable = cypress_nor_octal_dtr_enable;
-	nor->params->writesize = 16;
-}
-
 static void s28hs512t_post_sfdp_fixup(struct spi_nor *nor)
 {
 	/*
@@ -321,10 +323,16 @@ static int s28hs512t_post_bfpt_fixup(struct spi_nor *nor,
 	return cypress_nor_set_page_size(nor);
 }
 
+static void s28hs512t_late_init(struct spi_nor *nor)
+{
+	nor->params->octal_dtr_enable = cypress_nor_octal_dtr_enable;
+	cypress_nor_ecc_init(nor);
+}
+
 static const struct spi_nor_fixups s28hs512t_fixups = {
-	.default_init = s28hs512t_default_init,
 	.post_sfdp = s28hs512t_post_sfdp_fixup,
 	.post_bfpt = s28hs512t_post_bfpt_fixup,
+	.late_init = s28hs512t_late_init,
 };
 
 static int
@@ -459,8 +467,7 @@ static const struct flash_info spansion_nor_parts[] = {
 	{ "cy15x104q",  INFO6(0x042cc2, 0x7f7f7f, 512 * 1024, 1)
 		FLAGS(SPI_NOR_NO_ERASE) },
 	{ "s28hs512t",   INFO(0x345b1a,      0, 256 * 1024, 256)
-		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_OCTAL_DTR_READ |
-			      SPI_NOR_OCTAL_DTR_PP)
+		PARSE_SFDP
 		.fixups = &s28hs512t_fixups,
 	},
 };
diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index 38bf760b5b5e..855220c5ce33 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -446,9 +446,9 @@ mt7530_pad_clk_setup(struct dsa_switch *ds, phy_interface_t interface)
 		else
 			ssc_delta = 0x87;
 		if (priv->id == ID_MT7621) {
-			/* PLL frequency: 150MHz: 1.2GBit */
+			/* PLL frequency: 125MHz: 1.0GBit */
 			if (xtal == HWTRAP_XTAL_40MHZ)
-				ncpo1 = 0x0780;
+				ncpo1 = 0x0640;
 			if (xtal == HWTRAP_XTAL_25MHZ)
 				ncpo1 = 0x0a00;
 		} else { /* PLL frequency: 250MHz: 2.0Gbit */
@@ -1015,9 +1015,9 @@ mt753x_cpu_port_enable(struct dsa_switch *ds, int port)
 	mt7530_write(priv, MT7530_PVC_P(port),
 		     PORT_SPEC_TAG);
 
-	/* Disable flooding by default */
-	mt7530_rmw(priv, MT7530_MFC, BC_FFP_MASK | UNM_FFP_MASK | UNU_FFP_MASK,
-		   BC_FFP(BIT(port)) | UNM_FFP(BIT(port)) | UNU_FFP(BIT(port)));
+	/* Enable flooding on the CPU port */
+	mt7530_set(priv, MT7530_MFC, BC_FFP(BIT(port)) | UNM_FFP(BIT(port)) |
+		   UNU_FFP(BIT(port)));
 
 	/* Set CPU port number */
 	if (priv->id == ID_MT7621)
@@ -2312,12 +2312,69 @@ mt7530_setup(struct dsa_switch *ds)
 	return 0;
 }
 
+static int
+mt7531_setup_common(struct dsa_switch *ds)
+{
+	struct mt7530_priv *priv = ds->priv;
+	struct dsa_port *cpu_dp;
+	int ret, i;
+
+	/* BPDU to CPU port */
+	dsa_switch_for_each_cpu_port(cpu_dp, ds) {
+		mt7530_rmw(priv, MT7531_CFC, MT7531_CPU_PMAP_MASK,
+			   BIT(cpu_dp->index));
+		break;
+	}
+	mt7530_rmw(priv, MT753X_BPC, MT753X_BPDU_PORT_FW_MASK,
+		   MT753X_BPDU_CPU_ONLY);
+
+	/* Enable and reset MIB counters */
+	mt7530_mib_reset(ds);
+
+	/* Disable flooding on all ports */
+	mt7530_clear(priv, MT7530_MFC, BC_FFP_MASK | UNM_FFP_MASK |
+		     UNU_FFP_MASK);
+
+	for (i = 0; i < MT7530_NUM_PORTS; i++) {
+		/* Disable forwarding by default on all ports */
+		mt7530_rmw(priv, MT7530_PCR_P(i), PCR_MATRIX_MASK,
+			   PCR_MATRIX_CLR);
+
+		/* Disable learning by default on all ports */
+		mt7530_set(priv, MT7530_PSC_P(i), SA_DIS);
+
+		mt7530_set(priv, MT7531_DBG_CNT(i), MT7531_DIS_CLR);
+
+		if (dsa_is_cpu_port(ds, i)) {
+			ret = mt753x_cpu_port_enable(ds, i);
+			if (ret)
+				return ret;
+		} else {
+			mt7530_port_disable(ds, i);
+
+			/* Set default PVID to 0 on all user ports */
+			mt7530_rmw(priv, MT7530_PPBV1_P(i), G0_PORT_VID_MASK,
+				   G0_PORT_VID_DEF);
+		}
+
+		/* Enable consistent egress tag */
+		mt7530_rmw(priv, MT7530_PVC_P(i), PVC_EG_TAG_MASK,
+			   PVC_EG_TAG(MT7530_VLAN_EG_CONSISTENT));
+	}
+
+	/* Flush the FDB table */
+	ret = mt7530_fdb_cmd(priv, MT7530_FDB_FLUSH, NULL);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
 static int
 mt7531_setup(struct dsa_switch *ds)
 {
 	struct mt7530_priv *priv = ds->priv;
 	struct mt7530_dummy_poll p;
-	struct dsa_port *cpu_dp;
 	u32 val, id;
 	int ret, i;
 
@@ -2395,44 +2452,7 @@ mt7531_setup(struct dsa_switch *ds)
 	mt7531_ind_c45_phy_write(priv, MT753X_CTRL_PHY_ADDR, MDIO_MMD_VEND2,
 				 CORE_PLL_GROUP4, val);
 
-	/* BPDU to CPU port */
-	dsa_switch_for_each_cpu_port(cpu_dp, ds) {
-		mt7530_rmw(priv, MT7531_CFC, MT7531_CPU_PMAP_MASK,
-			   BIT(cpu_dp->index));
-		break;
-	}
-	mt7530_rmw(priv, MT753X_BPC, MT753X_BPDU_PORT_FW_MASK,
-		   MT753X_BPDU_CPU_ONLY);
-
-	/* Enable and reset MIB counters */
-	mt7530_mib_reset(ds);
-
-	for (i = 0; i < MT7530_NUM_PORTS; i++) {
-		/* Disable forwarding by default on all ports */
-		mt7530_rmw(priv, MT7530_PCR_P(i), PCR_MATRIX_MASK,
-			   PCR_MATRIX_CLR);
-
-		/* Disable learning by default on all ports */
-		mt7530_set(priv, MT7530_PSC_P(i), SA_DIS);
-
-		mt7530_set(priv, MT7531_DBG_CNT(i), MT7531_DIS_CLR);
-
-		if (dsa_is_cpu_port(ds, i)) {
-			ret = mt753x_cpu_port_enable(ds, i);
-			if (ret)
-				return ret;
-		} else {
-			mt7530_port_disable(ds, i);
-
-			/* Set default PVID to 0 on all user ports */
-			mt7530_rmw(priv, MT7530_PPBV1_P(i), G0_PORT_VID_MASK,
-				   G0_PORT_VID_DEF);
-		}
-
-		/* Enable consistent egress tag */
-		mt7530_rmw(priv, MT7530_PVC_P(i), PVC_EG_TAG_MASK,
-			   PVC_EG_TAG(MT7530_VLAN_EG_CONSISTENT));
-	}
+	mt7531_setup_common(ds);
 
 	/* Setup VLAN ID 0 for VLAN-unaware bridges */
 	ret = mt7530_setup_vlan0(priv);
@@ -2442,11 +2462,6 @@ mt7531_setup(struct dsa_switch *ds)
 	ds->assisted_learning_on_cpu_port = true;
 	ds->mtu_enforcement_ingress = true;
 
-	/* Flush the FDB table */
-	ret = mt7530_fdb_cmd(priv, MT7530_FDB_FLUSH, NULL);
-	if (ret < 0)
-		return ret;
-
 	return 0;
 }
 
diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index f1d9ee2a78b0..12175195d396 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -5109,6 +5109,7 @@ static const struct mv88e6xxx_ops mv88e6321_ops = {
 	.set_cpu_port = mv88e6095_g1_set_cpu_port,
 	.set_egress_port = mv88e6095_g1_set_egress_port,
 	.watchdog_ops = &mv88e6390_watchdog_ops,
+	.mgmt_rsvd2cpu = mv88e6352_g2_mgmt_rsvd2cpu,
 	.reset = mv88e6352_g1_reset,
 	.vtu_getnext = mv88e6185_g1_vtu_getnext,
 	.vtu_loadpurge = mv88e6185_g1_vtu_loadpurge,
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_qos.c b/drivers/net/ethernet/freescale/enetc/enetc_qos.c
index fcebb54224c0..a8539a8554a1 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_qos.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_qos.c
@@ -1255,7 +1255,7 @@ static int enetc_psfp_parse_clsflower(struct enetc_ndev_priv *priv,
 		int index;
 
 		index = enetc_get_free_index(priv);
-		if (sfi->handle < 0) {
+		if (index < 0) {
 			NL_SET_ERR_MSG_MOD(extack, "No Stream Filter resource!");
 			err = -ENOSPC;
 			goto free_fmi;
diff --git a/drivers/net/ethernet/intel/ice/ice_tc_lib.c b/drivers/net/ethernet/intel/ice/ice_tc_lib.c
index 71cb15fcf63b..652ef09eeb30 100644
--- a/drivers/net/ethernet/intel/ice/ice_tc_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_tc_lib.c
@@ -693,17 +693,18 @@ ice_eswitch_add_tc_fltr(struct ice_vsi *vsi, struct ice_tc_flower_fltr *fltr)
 	 * results into order of switch rule evaluation.
 	 */
 	rule_info.priority = 7;
+	rule_info.flags_info.act_valid = true;
 
 	if (fltr->direction == ICE_ESWITCH_FLTR_INGRESS) {
 		rule_info.sw_act.flag |= ICE_FLTR_RX;
 		rule_info.sw_act.src = hw->pf_id;
 		rule_info.rx = true;
+		rule_info.flags_info.act = ICE_SINGLE_ACT_LB_ENABLE;
 	} else {
 		rule_info.sw_act.flag |= ICE_FLTR_TX;
 		rule_info.sw_act.src = vsi->idx;
 		rule_info.rx = false;
 		rule_info.flags_info.act = ICE_SINGLE_ACT_LAN_ENABLE;
-		rule_info.flags_info.act_valid = true;
 	}
 
 	/* specify the cookie as filter_rule_id */
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c
index f8156fe4b1dc..0ee943db3dc9 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c
@@ -1035,9 +1035,6 @@ static void ixgbe_free_q_vector(struct ixgbe_adapter *adapter, int v_idx)
 	adapter->q_vector[v_idx] = NULL;
 	__netif_napi_del(&q_vector->napi);
 
-	if (static_key_enabled(&ixgbe_xdp_locking_key))
-		static_branch_dec(&ixgbe_xdp_locking_key);
-
 	/*
 	 * after a call to __netif_napi_del() napi may still be used and
 	 * ixgbe_get_stats64() might access the rings on this vector,
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index faf3a094ac54..9b8848daeb43 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -6495,6 +6495,10 @@ static int ixgbe_sw_init(struct ixgbe_adapter *adapter,
 	set_bit(0, adapter->fwd_bitmask);
 	set_bit(__IXGBE_DOWN, &adapter->state);
 
+	/* enable locking for XDP_TX if we have more CPUs than queues */
+	if (nr_cpu_ids > IXGBE_MAX_XDP_QS)
+		static_branch_enable(&ixgbe_xdp_locking_key);
+
 	return 0;
 }
 
@@ -10288,8 +10292,6 @@ static int ixgbe_xdp_setup(struct net_device *dev, struct bpf_prog *prog)
 	 */
 	if (nr_cpu_ids > IXGBE_MAX_XDP_QS * 2)
 		return -ENOMEM;
-	else if (nr_cpu_ids > IXGBE_MAX_XDP_QS)
-		static_branch_inc(&ixgbe_xdp_locking_key);
 
 	old_prog = xchg(&adapter->xdp_prog, prog);
 	need_reset = (!!prog != !!old_prog);
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mbox.c b/drivers/net/ethernet/marvell/octeontx2/af/mbox.c
index 2898931d5260..9690ac01f02c 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/mbox.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/mbox.c
@@ -157,7 +157,7 @@ EXPORT_SYMBOL(otx2_mbox_init);
  */
 int otx2_mbox_regions_init(struct otx2_mbox *mbox, void **hwbase,
 			   struct pci_dev *pdev, void *reg_base,
-			   int direction, int ndevs)
+			   int direction, int ndevs, unsigned long *pf_bmap)
 {
 	struct otx2_mbox_dev *mdev;
 	int devid, err;
@@ -169,6 +169,9 @@ int otx2_mbox_regions_init(struct otx2_mbox *mbox, void **hwbase,
 	mbox->hwbase = hwbase[0];
 
 	for (devid = 0; devid < ndevs; devid++) {
+		if (!test_bit(devid, pf_bmap))
+			continue;
+
 		mdev = &mbox->dev[devid];
 		mdev->mbase = hwbase[devid];
 		mdev->hwbase = hwbase[devid];
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
index 8d5d5a0f68c4..11eeb36cf9a5 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
@@ -96,9 +96,10 @@ void otx2_mbox_destroy(struct otx2_mbox *mbox);
 int otx2_mbox_init(struct otx2_mbox *mbox, void __force *hwbase,
 		   struct pci_dev *pdev, void __force *reg_base,
 		   int direction, int ndevs);
+
 int otx2_mbox_regions_init(struct otx2_mbox *mbox, void __force **hwbase,
 			   struct pci_dev *pdev, void __force *reg_base,
-			   int direction, int ndevs);
+			   int direction, int ndevs, unsigned long *bmap);
 void otx2_mbox_msg_send(struct otx2_mbox *mbox, int devid);
 int otx2_mbox_wait_for_rsp(struct otx2_mbox *mbox, int devid);
 int otx2_mbox_busy_poll_for_rsp(struct otx2_mbox *mbox, int devid);
@@ -242,9 +243,12 @@ M(NPC_MCAM_READ_BASE_RULE, 0x6011, npc_read_base_steer_rule,            \
 M(NPC_MCAM_GET_STATS, 0x6012, npc_mcam_entry_stats,                     \
 				   npc_mcam_get_stats_req,              \
 				   npc_mcam_get_stats_rsp)              \
-M(NPC_GET_SECRET_KEY, 0x6013, npc_get_secret_key,                     \
-				   npc_get_secret_key_req,              \
-				   npc_get_secret_key_rsp)              \
+M(NPC_GET_FIELD_HASH_INFO, 0x6013, npc_get_field_hash_info,                     \
+				   npc_get_field_hash_info_req,              \
+				   npc_get_field_hash_info_rsp)              \
+M(NPC_GET_FIELD_STATUS, 0x6014, npc_get_field_status,                     \
+				   npc_get_field_status_req,              \
+				   npc_get_field_status_rsp)              \
 /* NIX mbox IDs (range 0x8000 - 0xFFFF) */				\
 M(NIX_LF_ALLOC,		0x8000, nix_lf_alloc,				\
 				 nix_lf_alloc_req, nix_lf_alloc_rsp)	\
@@ -1510,14 +1514,20 @@ struct npc_mcam_get_stats_rsp {
 	u8 stat_ena; /* enabled */
 };
 
-struct npc_get_secret_key_req {
+struct npc_get_field_hash_info_req {
 	struct mbox_msghdr hdr;
 	u8 intf;
 };
 
-struct npc_get_secret_key_rsp {
+struct npc_get_field_hash_info_rsp {
 	struct mbox_msghdr hdr;
 	u64 secret_key[3];
+#define NPC_MAX_HASH 2
+#define NPC_MAX_HASH_MASK 2
+	/* NPC_AF_INTF(0..1)_HASH(0..1)_MASK(0..1) */
+	u64 hash_mask[NPC_MAX_INTF][NPC_MAX_HASH][NPC_MAX_HASH_MASK];
+	/* NPC_AF_INTF(0..1)_HASH(0..1)_RESULT_CTRL */
+	u64 hash_ctrl[NPC_MAX_INTF][NPC_MAX_HASH];
 };
 
 enum ptp_op {
@@ -1541,6 +1551,17 @@ struct ptp_rsp {
 	u64 clk;
 };
 
+struct npc_get_field_status_req {
+	struct mbox_msghdr hdr;
+	u8 intf;
+	u8 field;
+};
+
+struct npc_get_field_status_rsp {
+	struct mbox_msghdr hdr;
+	u8 enable;
+};
+
 struct set_vf_perm  {
 	struct  mbox_msghdr hdr;
 	u16	vf;
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mcs.c b/drivers/net/ethernet/marvell/octeontx2/af/mcs.c
index f68a6a0e3aa4..c43f19dfbd74 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/mcs.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/mcs.c
@@ -473,6 +473,8 @@ void mcs_flowid_entry_write(struct mcs *mcs, u64 *data, u64 *mask, int flow_id,
 		for (reg_id = 0; reg_id < 4; reg_id++) {
 			reg = MCSX_CPM_RX_SLAVE_FLOWID_TCAM_DATAX(reg_id, flow_id);
 			mcs_reg_write(mcs, reg, data[reg_id]);
+		}
+		for (reg_id = 0; reg_id < 4; reg_id++) {
 			reg = MCSX_CPM_RX_SLAVE_FLOWID_TCAM_MASKX(reg_id, flow_id);
 			mcs_reg_write(mcs, reg, mask[reg_id]);
 		}
@@ -480,6 +482,8 @@ void mcs_flowid_entry_write(struct mcs *mcs, u64 *data, u64 *mask, int flow_id,
 		for (reg_id = 0; reg_id < 4; reg_id++) {
 			reg = MCSX_CPM_TX_SLAVE_FLOWID_TCAM_DATAX(reg_id, flow_id);
 			mcs_reg_write(mcs, reg, data[reg_id]);
+		}
+		for (reg_id = 0; reg_id < 4; reg_id++) {
 			reg = MCSX_CPM_TX_SLAVE_FLOWID_TCAM_MASKX(reg_id, flow_id);
 			mcs_reg_write(mcs, reg, mask[reg_id]);
 		}
@@ -494,6 +498,9 @@ int mcs_install_flowid_bypass_entry(struct mcs *mcs)
 
 	/* Flow entry */
 	flow_id = mcs->hw->tcam_entries - MCS_RSRC_RSVD_CNT;
+	__set_bit(flow_id, mcs->rx.flow_ids.bmap);
+	__set_bit(flow_id, mcs->tx.flow_ids.bmap);
+
 	for (reg_id = 0; reg_id < 4; reg_id++) {
 		reg = MCSX_CPM_RX_SLAVE_FLOWID_TCAM_MASKX(reg_id, flow_id);
 		mcs_reg_write(mcs, reg, GENMASK_ULL(63, 0));
@@ -504,6 +511,8 @@ int mcs_install_flowid_bypass_entry(struct mcs *mcs)
 	}
 	/* secy */
 	secy_id = mcs->hw->secy_entries - MCS_RSRC_RSVD_CNT;
+	__set_bit(secy_id, mcs->rx.secy.bmap);
+	__set_bit(secy_id, mcs->tx.secy.bmap);
 
 	/* Set validate frames to NULL and enable control port */
 	plcy = 0x7ull;
@@ -528,6 +537,7 @@ int mcs_install_flowid_bypass_entry(struct mcs *mcs)
 	/* Enable Flowid entry */
 	mcs_ena_dis_flowid_entry(mcs, flow_id, MCS_RX, true);
 	mcs_ena_dis_flowid_entry(mcs, flow_id, MCS_TX, true);
+
 	return 0;
 }
 
@@ -926,60 +936,42 @@ static void mcs_tx_misc_intr_handler(struct mcs *mcs, u64 intr)
 	mcs_add_intr_wq_entry(mcs, &event);
 }
 
-static void mcs_bbe_intr_handler(struct mcs *mcs, u64 intr, enum mcs_direction dir)
+void cn10kb_mcs_bbe_intr_handler(struct mcs *mcs, u64 intr,
+				 enum mcs_direction dir)
 {
-	struct mcs_intr_event event = { 0 };
-	int i;
+	u64 val, reg;
+	int lmac;
 
-	if (!(intr & MCS_BBE_INT_MASK))
+	if (!(intr & 0x6ULL))
 		return;
 
-	event.mcs_id = mcs->mcs_id;
-	event.pcifunc = mcs->pf_map[0];
+	if (intr & BIT_ULL(1))
+		reg = (dir == MCS_RX) ? MCSX_BBE_RX_SLAVE_DFIFO_OVERFLOW_0 :
+					MCSX_BBE_TX_SLAVE_DFIFO_OVERFLOW_0;
+	else
+		reg = (dir == MCS_RX) ? MCSX_BBE_RX_SLAVE_PLFIFO_OVERFLOW_0 :
+					MCSX_BBE_TX_SLAVE_PLFIFO_OVERFLOW_0;
+	val = mcs_reg_read(mcs, reg);
 
-	for (i = 0; i < MCS_MAX_BBE_INT; i++) {
-		if (!(intr & BIT_ULL(i)))
+	/* policy/data over flow occurred */
+	for (lmac = 0; lmac < mcs->hw->lmac_cnt; lmac++) {
+		if (!(val & BIT_ULL(lmac)))
 			continue;
-
-		/* Lower nibble denotes data fifo overflow interrupts and
-		 * upper nibble indicates policy fifo overflow interrupts.
-		 */
-		if (intr & 0xFULL)
-			event.intr_mask = (dir == MCS_RX) ?
-					  MCS_BBE_RX_DFIFO_OVERFLOW_INT :
-					  MCS_BBE_TX_DFIFO_OVERFLOW_INT;
-		else
-			event.intr_mask = (dir == MCS_RX) ?
-					  MCS_BBE_RX_PLFIFO_OVERFLOW_INT :
-					  MCS_BBE_TX_PLFIFO_OVERFLOW_INT;
-
-		/* Notify the lmac_id info which ran into BBE fatal error */
-		event.lmac_id = i & 0x3ULL;
-		mcs_add_intr_wq_entry(mcs, &event);
+		dev_warn(mcs->dev, "BEE:Policy or data overflow occurred on lmac:%d\n", lmac);
 	}
 }
 
-static void mcs_pab_intr_handler(struct mcs *mcs, u64 intr, enum mcs_direction dir)
+void cn10kb_mcs_pab_intr_handler(struct mcs *mcs, u64 intr,
+				 enum mcs_direction dir)
 {
-	struct mcs_intr_event event = { 0 };
-	int i;
+	int lmac;
 
-	if (!(intr & MCS_PAB_INT_MASK))
+	if (!(intr & 0xFFFFFULL))
 		return;
 
-	event.mcs_id = mcs->mcs_id;
-	event.pcifunc = mcs->pf_map[0];
-
-	for (i = 0; i < MCS_MAX_PAB_INT; i++) {
-		if (!(intr & BIT_ULL(i)))
-			continue;
-
-		event.intr_mask = (dir == MCS_RX) ? MCS_PAB_RX_CHAN_OVERFLOW_INT :
-				  MCS_PAB_TX_CHAN_OVERFLOW_INT;
-
-		/* Notify the lmac_id info which ran into PAB fatal error */
-		event.lmac_id = i;
-		mcs_add_intr_wq_entry(mcs, &event);
+	for (lmac = 0; lmac < mcs->hw->lmac_cnt; lmac++) {
+		if (intr & BIT_ULL(lmac))
+			dev_warn(mcs->dev, "PAB: overflow occurred on lmac:%d\n", lmac);
 	}
 }
 
@@ -988,9 +980,8 @@ static irqreturn_t mcs_ip_intr_handler(int irq, void *mcs_irq)
 	struct mcs *mcs = (struct mcs *)mcs_irq;
 	u64 intr, cpm_intr, bbe_intr, pab_intr;
 
-	/* Disable and clear the interrupt */
+	/* Disable  the interrupt */
 	mcs_reg_write(mcs, MCSX_IP_INT_ENA_W1C, BIT_ULL(0));
-	mcs_reg_write(mcs, MCSX_IP_INT, BIT_ULL(0));
 
 	/* Check which block has interrupt*/
 	intr = mcs_reg_read(mcs, MCSX_TOP_SLAVE_INT_SUM);
@@ -1037,7 +1028,7 @@ static irqreturn_t mcs_ip_intr_handler(int irq, void *mcs_irq)
 	/* BBE RX */
 	if (intr & MCS_BBE_RX_INT_ENA) {
 		bbe_intr = mcs_reg_read(mcs, MCSX_BBE_RX_SLAVE_BBE_INT);
-		mcs_bbe_intr_handler(mcs, bbe_intr, MCS_RX);
+		mcs->mcs_ops->mcs_bbe_intr_handler(mcs, bbe_intr, MCS_RX);
 
 		/* Clear the interrupt */
 		mcs_reg_write(mcs, MCSX_BBE_RX_SLAVE_BBE_INT_INTR_RW, 0);
@@ -1047,7 +1038,7 @@ static irqreturn_t mcs_ip_intr_handler(int irq, void *mcs_irq)
 	/* BBE TX */
 	if (intr & MCS_BBE_TX_INT_ENA) {
 		bbe_intr = mcs_reg_read(mcs, MCSX_BBE_TX_SLAVE_BBE_INT);
-		mcs_bbe_intr_handler(mcs, bbe_intr, MCS_TX);
+		mcs->mcs_ops->mcs_bbe_intr_handler(mcs, bbe_intr, MCS_TX);
 
 		/* Clear the interrupt */
 		mcs_reg_write(mcs, MCSX_BBE_TX_SLAVE_BBE_INT_INTR_RW, 0);
@@ -1057,7 +1048,7 @@ static irqreturn_t mcs_ip_intr_handler(int irq, void *mcs_irq)
 	/* PAB RX */
 	if (intr & MCS_PAB_RX_INT_ENA) {
 		pab_intr = mcs_reg_read(mcs, MCSX_PAB_RX_SLAVE_PAB_INT);
-		mcs_pab_intr_handler(mcs, pab_intr, MCS_RX);
+		mcs->mcs_ops->mcs_pab_intr_handler(mcs, pab_intr, MCS_RX);
 
 		/* Clear the interrupt */
 		mcs_reg_write(mcs, MCSX_PAB_RX_SLAVE_PAB_INT_INTR_RW, 0);
@@ -1067,14 +1058,15 @@ static irqreturn_t mcs_ip_intr_handler(int irq, void *mcs_irq)
 	/* PAB TX */
 	if (intr & MCS_PAB_TX_INT_ENA) {
 		pab_intr = mcs_reg_read(mcs, MCSX_PAB_TX_SLAVE_PAB_INT);
-		mcs_pab_intr_handler(mcs, pab_intr, MCS_TX);
+		mcs->mcs_ops->mcs_pab_intr_handler(mcs, pab_intr, MCS_TX);
 
 		/* Clear the interrupt */
 		mcs_reg_write(mcs, MCSX_PAB_TX_SLAVE_PAB_INT_INTR_RW, 0);
 		mcs_reg_write(mcs, MCSX_PAB_TX_SLAVE_PAB_INT, pab_intr);
 	}
 
-	/* Enable the interrupt */
+	/* Clear and enable the interrupt */
+	mcs_reg_write(mcs, MCSX_IP_INT, BIT_ULL(0));
 	mcs_reg_write(mcs, MCSX_IP_INT_ENA_W1S, BIT_ULL(0));
 
 	return IRQ_HANDLED;
@@ -1156,7 +1148,7 @@ static int mcs_register_interrupts(struct mcs *mcs)
 		return ret;
 	}
 
-	ret = request_irq(pci_irq_vector(mcs->pdev, MCS_INT_VEC_IP),
+	ret = request_irq(pci_irq_vector(mcs->pdev, mcs->hw->ip_vec),
 			  mcs_ip_intr_handler, 0, "MCS_IP", mcs);
 	if (ret) {
 		dev_err(mcs->dev, "MCS IP irq registration failed\n");
@@ -1175,11 +1167,11 @@ static int mcs_register_interrupts(struct mcs *mcs)
 	mcs_reg_write(mcs, MCSX_CPM_TX_SLAVE_TX_INT_ENB, 0x7ULL);
 	mcs_reg_write(mcs, MCSX_CPM_RX_SLAVE_RX_INT_ENB, 0x7FULL);
 
-	mcs_reg_write(mcs, MCSX_BBE_RX_SLAVE_BBE_INT_ENB, 0xff);
-	mcs_reg_write(mcs, MCSX_BBE_TX_SLAVE_BBE_INT_ENB, 0xff);
+	mcs_reg_write(mcs, MCSX_BBE_RX_SLAVE_BBE_INT_ENB, 0xFFULL);
+	mcs_reg_write(mcs, MCSX_BBE_TX_SLAVE_BBE_INT_ENB, 0xFFULL);
 
-	mcs_reg_write(mcs, MCSX_PAB_RX_SLAVE_PAB_INT_ENB, 0xff);
-	mcs_reg_write(mcs, MCSX_PAB_TX_SLAVE_PAB_INT_ENB, 0xff);
+	mcs_reg_write(mcs, MCSX_PAB_RX_SLAVE_PAB_INT_ENB, 0xFFFFFULL);
+	mcs_reg_write(mcs, MCSX_PAB_TX_SLAVE_PAB_INT_ENB, 0xFFFFFULL);
 
 	mcs->tx_sa_active = alloc_mem(mcs, mcs->hw->sc_entries);
 	if (!mcs->tx_sa_active) {
@@ -1190,7 +1182,7 @@ static int mcs_register_interrupts(struct mcs *mcs)
 	return ret;
 
 free_irq:
-	free_irq(pci_irq_vector(mcs->pdev, MCS_INT_VEC_IP), mcs);
+	free_irq(pci_irq_vector(mcs->pdev, mcs->hw->ip_vec), mcs);
 exit:
 	pci_free_irq_vectors(mcs->pdev);
 	mcs->num_vec = 0;
@@ -1325,8 +1317,11 @@ void mcs_reset_port(struct mcs *mcs, u8 port_id, u8 reset)
 void mcs_set_lmac_mode(struct mcs *mcs, int lmac_id, u8 mode)
 {
 	u64 reg;
+	int id = lmac_id * 2;
 
-	reg = MCSX_MCS_TOP_SLAVE_CHANNEL_CFG(lmac_id * 2);
+	reg = MCSX_MCS_TOP_SLAVE_CHANNEL_CFG(id);
+	mcs_reg_write(mcs, reg, (u64)mode);
+	reg = MCSX_MCS_TOP_SLAVE_CHANNEL_CFG((id + 1));
 	mcs_reg_write(mcs, reg, (u64)mode);
 }
 
@@ -1484,6 +1479,7 @@ void cn10kb_mcs_set_hw_capabilities(struct mcs *mcs)
 	hw->lmac_cnt = 20;		/* lmacs/ports per mcs block */
 	hw->mcs_x2p_intf = 5;		/* x2p clabration intf */
 	hw->mcs_blks = 1;		/* MCS blocks */
+	hw->ip_vec = MCS_CN10KB_INT_VEC_IP; /* IP vector */
 }
 
 static struct mcs_ops cn10kb_mcs_ops = {
@@ -1492,6 +1488,8 @@ static struct mcs_ops cn10kb_mcs_ops = {
 	.mcs_tx_sa_mem_map_write	= cn10kb_mcs_tx_sa_mem_map_write,
 	.mcs_rx_sa_mem_map_write	= cn10kb_mcs_rx_sa_mem_map_write,
 	.mcs_flowid_secy_map		= cn10kb_mcs_flowid_secy_map,
+	.mcs_bbe_intr_handler		= cn10kb_mcs_bbe_intr_handler,
+	.mcs_pab_intr_handler		= cn10kb_mcs_pab_intr_handler,
 };
 
 static int mcs_probe(struct pci_dev *pdev, const struct pci_device_id *id)
@@ -1592,7 +1590,7 @@ static void mcs_remove(struct pci_dev *pdev)
 
 	/* Set MCS to external bypass */
 	mcs_set_external_bypass(mcs, true);
-	free_irq(pci_irq_vector(pdev, MCS_INT_VEC_IP), mcs);
+	free_irq(pci_irq_vector(pdev, mcs->hw->ip_vec), mcs);
 	pci_free_irq_vectors(pdev);
 	pci_release_regions(pdev);
 	pci_disable_device(pdev);
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mcs.h b/drivers/net/ethernet/marvell/octeontx2/af/mcs.h
index 64dc2b80e15d..0f89dcb76465 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/mcs.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/mcs.h
@@ -43,24 +43,15 @@
 /* Reserved resources for default bypass entry */
 #define MCS_RSRC_RSVD_CNT		1
 
-/* MCS Interrupt Vector Enumeration */
-enum mcs_int_vec_e {
-	MCS_INT_VEC_MIL_RX_GBL		= 0x0,
-	MCS_INT_VEC_MIL_RX_LMACX	= 0x1,
-	MCS_INT_VEC_MIL_TX_LMACX	= 0x5,
-	MCS_INT_VEC_HIL_RX_GBL		= 0x9,
-	MCS_INT_VEC_HIL_RX_LMACX	= 0xa,
-	MCS_INT_VEC_HIL_TX_GBL		= 0xe,
-	MCS_INT_VEC_HIL_TX_LMACX	= 0xf,
-	MCS_INT_VEC_IP			= 0x13,
-	MCS_INT_VEC_CNT			= 0x14,
-};
+/* MCS Interrupt Vector */
+#define MCS_CNF10KB_INT_VEC_IP	0x13
+#define MCS_CN10KB_INT_VEC_IP	0x53
 
 #define MCS_MAX_BBE_INT			8ULL
 #define MCS_BBE_INT_MASK		0xFFULL
 
-#define MCS_MAX_PAB_INT			4ULL
-#define MCS_PAB_INT_MASK		0xFULL
+#define MCS_MAX_PAB_INT		8ULL
+#define MCS_PAB_INT_MASK	0xFULL
 
 #define MCS_BBE_RX_INT_ENA		BIT_ULL(0)
 #define MCS_BBE_TX_INT_ENA		BIT_ULL(1)
@@ -137,6 +128,7 @@ struct hwinfo {
 	u8 lmac_cnt;
 	u8 mcs_blks;
 	unsigned long	lmac_bmap; /* bitmap of enabled mcs lmac */
+	u16 ip_vec;
 };
 
 struct mcs {
@@ -165,6 +157,8 @@ struct mcs_ops {
 	void	(*mcs_tx_sa_mem_map_write)(struct mcs *mcs, struct mcs_tx_sc_sa_map *map);
 	void	(*mcs_rx_sa_mem_map_write)(struct mcs *mcs, struct mcs_rx_sc_sa_map *map);
 	void	(*mcs_flowid_secy_map)(struct mcs *mcs, struct secy_mem_map *map, int dir);
+	void	(*mcs_bbe_intr_handler)(struct mcs *mcs, u64 intr, enum mcs_direction dir);
+	void	(*mcs_pab_intr_handler)(struct mcs *mcs, u64 intr, enum mcs_direction dir);
 };
 
 extern struct pci_driver mcs_driver;
@@ -219,6 +213,8 @@ void cn10kb_mcs_tx_sa_mem_map_write(struct mcs *mcs, struct mcs_tx_sc_sa_map *ma
 void cn10kb_mcs_flowid_secy_map(struct mcs *mcs, struct secy_mem_map *map, int dir);
 void cn10kb_mcs_rx_sa_mem_map_write(struct mcs *mcs, struct mcs_rx_sc_sa_map *map);
 void cn10kb_mcs_parser_cfg(struct mcs *mcs);
+void cn10kb_mcs_pab_intr_handler(struct mcs *mcs, u64 intr, enum mcs_direction dir);
+void cn10kb_mcs_bbe_intr_handler(struct mcs *mcs, u64 intr, enum mcs_direction dir);
 
 /* CNF10K-B APIs */
 struct mcs_ops *cnf10kb_get_mac_ops(void);
@@ -229,6 +225,8 @@ void cnf10kb_mcs_rx_sa_mem_map_write(struct mcs *mcs, struct mcs_rx_sc_sa_map *m
 void cnf10kb_mcs_parser_cfg(struct mcs *mcs);
 void cnf10kb_mcs_tx_pn_thresh_reached_handler(struct mcs *mcs);
 void cnf10kb_mcs_tx_pn_wrapped_handler(struct mcs *mcs);
+void cnf10kb_mcs_bbe_intr_handler(struct mcs *mcs, u64 intr, enum mcs_direction dir);
+void cnf10kb_mcs_pab_intr_handler(struct mcs *mcs, u64 intr, enum mcs_direction dir);
 
 /* Stats APIs */
 void mcs_get_sc_stats(struct mcs *mcs, struct mcs_sc_stats *stats, int id, int dir);
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mcs_cnf10kb.c b/drivers/net/ethernet/marvell/octeontx2/af/mcs_cnf10kb.c
index 7b6205414428..9f9b904ab2cd 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/mcs_cnf10kb.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/mcs_cnf10kb.c
@@ -13,6 +13,8 @@ static struct mcs_ops cnf10kb_mcs_ops   = {
 	.mcs_tx_sa_mem_map_write	= cnf10kb_mcs_tx_sa_mem_map_write,
 	.mcs_rx_sa_mem_map_write	= cnf10kb_mcs_rx_sa_mem_map_write,
 	.mcs_flowid_secy_map		= cnf10kb_mcs_flowid_secy_map,
+	.mcs_bbe_intr_handler		= cnf10kb_mcs_bbe_intr_handler,
+	.mcs_pab_intr_handler		= cnf10kb_mcs_pab_intr_handler,
 };
 
 struct mcs_ops *cnf10kb_get_mac_ops(void)
@@ -31,6 +33,7 @@ void cnf10kb_mcs_set_hw_capabilities(struct mcs *mcs)
 	hw->lmac_cnt = 4;		/* lmacs/ports per mcs block */
 	hw->mcs_x2p_intf = 1;		/* x2p clabration intf */
 	hw->mcs_blks = 7;		/* MCS blocks */
+	hw->ip_vec = MCS_CNF10KB_INT_VEC_IP; /* IP vector */
 }
 
 void cnf10kb_mcs_parser_cfg(struct mcs *mcs)
@@ -212,3 +215,63 @@ void cnf10kb_mcs_tx_pn_wrapped_handler(struct mcs *mcs)
 		mcs_add_intr_wq_entry(mcs, &event);
 	}
 }
+
+void cnf10kb_mcs_bbe_intr_handler(struct mcs *mcs, u64 intr,
+				  enum mcs_direction dir)
+{
+	struct mcs_intr_event event = { 0 };
+	int i;
+
+	if (!(intr & MCS_BBE_INT_MASK))
+		return;
+
+	event.mcs_id = mcs->mcs_id;
+	event.pcifunc = mcs->pf_map[0];
+
+	for (i = 0; i < MCS_MAX_BBE_INT; i++) {
+		if (!(intr & BIT_ULL(i)))
+			continue;
+
+		/* Lower nibble denotes data fifo overflow interrupts and
+		 * upper nibble indicates policy fifo overflow interrupts.
+		 */
+		if (intr & 0xFULL)
+			event.intr_mask = (dir == MCS_RX) ?
+					  MCS_BBE_RX_DFIFO_OVERFLOW_INT :
+					  MCS_BBE_TX_DFIFO_OVERFLOW_INT;
+		else
+			event.intr_mask = (dir == MCS_RX) ?
+					  MCS_BBE_RX_PLFIFO_OVERFLOW_INT :
+					  MCS_BBE_TX_PLFIFO_OVERFLOW_INT;
+
+		/* Notify the lmac_id info which ran into BBE fatal error */
+		event.lmac_id = i & 0x3ULL;
+		mcs_add_intr_wq_entry(mcs, &event);
+	}
+}
+
+void cnf10kb_mcs_pab_intr_handler(struct mcs *mcs, u64 intr,
+				  enum mcs_direction dir)
+{
+	struct mcs_intr_event event = { 0 };
+	int i;
+
+	if (!(intr & MCS_PAB_INT_MASK))
+		return;
+
+	event.mcs_id = mcs->mcs_id;
+	event.pcifunc = mcs->pf_map[0];
+
+	for (i = 0; i < MCS_MAX_PAB_INT; i++) {
+		if (!(intr & BIT_ULL(i)))
+			continue;
+
+		event.intr_mask = (dir == MCS_RX) ?
+				  MCS_PAB_RX_CHAN_OVERFLOW_INT :
+				  MCS_PAB_TX_CHAN_OVERFLOW_INT;
+
+		/* Notify the lmac_id info which ran into PAB fatal error */
+		event.lmac_id = i;
+		mcs_add_intr_wq_entry(mcs, &event);
+	}
+}
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mcs_reg.h b/drivers/net/ethernet/marvell/octeontx2/af/mcs_reg.h
index c95a8b8f5eaf..f3ab01fc363c 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/mcs_reg.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/mcs_reg.h
@@ -97,6 +97,7 @@
 #define MCSX_PEX_TX_SLAVE_VLAN_CFGX(a)          (0x46f8ull + (a) * 0x8ull)
 #define MCSX_PEX_TX_SLAVE_CUSTOM_TAG_REL_MODE_SEL(a)	(0x788ull + (a) * 0x8ull)
 #define MCSX_PEX_TX_SLAVE_PORT_CONFIG(a)		(0x4738ull + (a) * 0x8ull)
+#define MCSX_PEX_RX_SLAVE_PORT_CFGX(a)		(0x3b98ull + (a) * 0x8ull)
 #define MCSX_PEX_RX_SLAVE_RULE_ETYPE_CFGX(a) ({	\
 	u64 offset;					\
 							\
@@ -275,7 +276,10 @@
 #define MCSX_BBE_RX_SLAVE_CAL_ENTRY			0x180ull
 #define MCSX_BBE_RX_SLAVE_CAL_LEN			0x188ull
 #define MCSX_PAB_RX_SLAVE_FIFO_SKID_CFGX(a)		(0x290ull + (a) * 0x40ull)
-
+#define MCSX_BBE_RX_SLAVE_DFIFO_OVERFLOW_0		0xe20
+#define MCSX_BBE_TX_SLAVE_DFIFO_OVERFLOW_0		0x1298
+#define MCSX_BBE_RX_SLAVE_PLFIFO_OVERFLOW_0		0xe40
+#define MCSX_BBE_TX_SLAVE_PLFIFO_OVERFLOW_0		0x12b8
 #define MCSX_BBE_RX_SLAVE_BBE_INT ({	\
 	u64 offset;			\
 					\
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mcs_rvu_if.c b/drivers/net/ethernet/marvell/octeontx2/af/mcs_rvu_if.c
index eb25e458266c..dfd23580e3b8 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/mcs_rvu_if.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/mcs_rvu_if.c
@@ -11,6 +11,7 @@
 
 #include "mcs.h"
 #include "rvu.h"
+#include "mcs_reg.h"
 #include "lmac_common.h"
 
 #define M(_name, _id, _fn_name, _req_type, _rsp_type)			\
@@ -32,6 +33,42 @@ static struct _req_type __maybe_unused					\
 MBOX_UP_MCS_MESSAGES
 #undef M
 
+void rvu_mcs_ptp_cfg(struct rvu *rvu, u8 rpm_id, u8 lmac_id, bool ena)
+{
+	struct mcs *mcs;
+	u64 cfg;
+	u8 port;
+
+	if (!rvu->mcs_blk_cnt)
+		return;
+
+	/* When ptp is enabled, RPM appends 8B header for all
+	 * RX packets. MCS PEX need to configure to skip 8B
+	 * during packet parsing.
+	 */
+
+	/* CNF10K-B */
+	if (rvu->mcs_blk_cnt > 1) {
+		mcs = mcs_get_pdata(rpm_id);
+		cfg = mcs_reg_read(mcs, MCSX_PEX_RX_SLAVE_PEX_CONFIGURATION);
+		if (ena)
+			cfg |= BIT_ULL(lmac_id);
+		else
+			cfg &= ~BIT_ULL(lmac_id);
+		mcs_reg_write(mcs, MCSX_PEX_RX_SLAVE_PEX_CONFIGURATION, cfg);
+		return;
+	}
+	/* CN10KB */
+	mcs = mcs_get_pdata(0);
+	port = (rpm_id * rvu->hw->lmac_per_cgx) + lmac_id;
+	cfg = mcs_reg_read(mcs, MCSX_PEX_RX_SLAVE_PORT_CFGX(port));
+	if (ena)
+		cfg |= BIT_ULL(0);
+	else
+		cfg &= ~BIT_ULL(0);
+	mcs_reg_write(mcs, MCSX_PEX_RX_SLAVE_PORT_CFGX(port), cfg);
+}
+
 int rvu_mbox_handler_mcs_set_lmac_mode(struct rvu *rvu,
 				       struct mcs_set_lmac_mode *req,
 				       struct msg_rsp *rsp)
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/npc.h b/drivers/net/ethernet/marvell/octeontx2/af/npc.h
index f187293e3e08..d027c23b8ef8 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/npc.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/npc.h
@@ -620,6 +620,7 @@ struct rvu_npc_mcam_rule {
 	bool vfvlan_cfg;
 	u16 chan;
 	u16 chan_mask;
+	u8 lxmb;
 };
 
 #endif /* NPC_H */
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
index 3f5e09b77d4b..873f081c030d 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
@@ -2274,7 +2274,7 @@ static inline void rvu_afvf_mbox_up_handler(struct work_struct *work)
 }
 
 static int rvu_get_mbox_regions(struct rvu *rvu, void **mbox_addr,
-				int num, int type)
+				int num, int type, unsigned long *pf_bmap)
 {
 	struct rvu_hwinfo *hw = rvu->hw;
 	int region;
@@ -2286,6 +2286,9 @@ static int rvu_get_mbox_regions(struct rvu *rvu, void **mbox_addr,
 	 */
 	if (type == TYPE_AFVF) {
 		for (region = 0; region < num; region++) {
+			if (!test_bit(region, pf_bmap))
+				continue;
+
 			if (hw->cap.per_pf_mbox_regs) {
 				bar4 = rvu_read64(rvu, BLKADDR_RVUM,
 						  RVU_AF_PFX_BAR4_ADDR(0)) +
@@ -2307,6 +2310,9 @@ static int rvu_get_mbox_regions(struct rvu *rvu, void **mbox_addr,
 	 * RVU_AF_PF_BAR4_ADDR register.
 	 */
 	for (region = 0; region < num; region++) {
+		if (!test_bit(region, pf_bmap))
+			continue;
+
 		if (hw->cap.per_pf_mbox_regs) {
 			bar4 = rvu_read64(rvu, BLKADDR_RVUM,
 					  RVU_AF_PFX_BAR4_ADDR(region));
@@ -2335,20 +2341,41 @@ static int rvu_mbox_init(struct rvu *rvu, struct mbox_wq_info *mw,
 	int err = -EINVAL, i, dir, dir_up;
 	void __iomem *reg_base;
 	struct rvu_work *mwork;
+	unsigned long *pf_bmap;
 	void **mbox_regions;
 	const char *name;
+	u64 cfg;
 
-	mbox_regions = kcalloc(num, sizeof(void *), GFP_KERNEL);
-	if (!mbox_regions)
+	pf_bmap = bitmap_zalloc(num, GFP_KERNEL);
+	if (!pf_bmap)
 		return -ENOMEM;
 
+	/* RVU VFs */
+	if (type == TYPE_AFVF)
+		bitmap_set(pf_bmap, 0, num);
+
+	if (type == TYPE_AFPF) {
+		/* Mark enabled PFs in bitmap */
+		for (i = 0; i < num; i++) {
+			cfg = rvu_read64(rvu, BLKADDR_RVUM, RVU_PRIV_PFX_CFG(i));
+			if (cfg & BIT_ULL(20))
+				set_bit(i, pf_bmap);
+		}
+	}
+
+	mbox_regions = kcalloc(num, sizeof(void *), GFP_KERNEL);
+	if (!mbox_regions) {
+		err = -ENOMEM;
+		goto free_bitmap;
+	}
+
 	switch (type) {
 	case TYPE_AFPF:
 		name = "rvu_afpf_mailbox";
 		dir = MBOX_DIR_AFPF;
 		dir_up = MBOX_DIR_AFPF_UP;
 		reg_base = rvu->afreg_base;
-		err = rvu_get_mbox_regions(rvu, mbox_regions, num, TYPE_AFPF);
+		err = rvu_get_mbox_regions(rvu, mbox_regions, num, TYPE_AFPF, pf_bmap);
 		if (err)
 			goto free_regions;
 		break;
@@ -2357,7 +2384,7 @@ static int rvu_mbox_init(struct rvu *rvu, struct mbox_wq_info *mw,
 		dir = MBOX_DIR_PFVF;
 		dir_up = MBOX_DIR_PFVF_UP;
 		reg_base = rvu->pfreg_base;
-		err = rvu_get_mbox_regions(rvu, mbox_regions, num, TYPE_AFVF);
+		err = rvu_get_mbox_regions(rvu, mbox_regions, num, TYPE_AFVF, pf_bmap);
 		if (err)
 			goto free_regions;
 		break;
@@ -2388,16 +2415,19 @@ static int rvu_mbox_init(struct rvu *rvu, struct mbox_wq_info *mw,
 	}
 
 	err = otx2_mbox_regions_init(&mw->mbox, mbox_regions, rvu->pdev,
-				     reg_base, dir, num);
+				     reg_base, dir, num, pf_bmap);
 	if (err)
 		goto exit;
 
 	err = otx2_mbox_regions_init(&mw->mbox_up, mbox_regions, rvu->pdev,
-				     reg_base, dir_up, num);
+				     reg_base, dir_up, num, pf_bmap);
 	if (err)
 		goto exit;
 
 	for (i = 0; i < num; i++) {
+		if (!test_bit(i, pf_bmap))
+			continue;
+
 		mwork = &mw->mbox_wrk[i];
 		mwork->rvu = rvu;
 		INIT_WORK(&mwork->work, mbox_handler);
@@ -2406,8 +2436,7 @@ static int rvu_mbox_init(struct rvu *rvu, struct mbox_wq_info *mw,
 		mwork->rvu = rvu;
 		INIT_WORK(&mwork->work, mbox_up_handler);
 	}
-	kfree(mbox_regions);
-	return 0;
+	goto free_regions;
 
 exit:
 	destroy_workqueue(mw->mbox_wq);
@@ -2416,6 +2445,8 @@ static int rvu_mbox_init(struct rvu *rvu, struct mbox_wq_info *mw,
 		iounmap((void __iomem *)mbox_regions[num]);
 free_regions:
 	kfree(mbox_regions);
+free_bitmap:
+	bitmap_free(pf_bmap);
 	return err;
 }
 
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
index b07c6f51b461..d493b533cf76 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
@@ -851,6 +851,7 @@ int npc_install_mcam_drop_rule(struct rvu *rvu, int mcam_idx, u16 *counter_idx,
 			       u64 chan_val, u64 chan_mask, u64 exact_val, u64 exact_mask,
 			       u64 bcast_mcast_val, u64 bcast_mcast_mask);
 void npc_mcam_rsrcs_reserve(struct rvu *rvu, int blkaddr, int entry_idx);
+bool npc_is_feature_supported(struct rvu *rvu, u64 features, u8 intf);
 
 /* CPT APIs */
 int rvu_cpt_register_interrupts(struct rvu *rvu);
@@ -892,6 +893,7 @@ int rvu_get_hwvf(struct rvu *rvu, int pcifunc);
 /* CN10K MCS */
 int rvu_mcs_init(struct rvu *rvu);
 int rvu_mcs_flr_handler(struct rvu *rvu, u16 pcifunc);
+void rvu_mcs_ptp_cfg(struct rvu *rvu, u8 rpm_id, u8 lmac_id, bool ena);
 void rvu_mcs_exit(struct rvu *rvu);
 
 #endif /* RVU_H */
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
index addc69f4b65c..9eca38547b78 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
@@ -761,6 +761,8 @@ static int rvu_cgx_ptp_rx_cfg(struct rvu *rvu, u16 pcifunc, bool enable)
 	/* This flag is required to clean up CGX conf if app gets killed */
 	pfvf->hw_rx_tstamp_en = enable;
 
+	/* Inform MCS about 8B RX header */
+	rvu_mcs_ptp_cfg(rvu, cgx_id, lmac_id, enable);
 	return 0;
 }
 
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cn10k.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cn10k.c
index 7dbbc115cde4..f9faa5b23bb9 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cn10k.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cn10k.c
@@ -60,13 +60,14 @@ static int rvu_get_lmtaddr(struct rvu *rvu, u16 pcifunc,
 			   u64 iova, u64 *lmt_addr)
 {
 	u64 pa, val, pf;
-	int err;
+	int err = 0;
 
 	if (!iova) {
 		dev_err(rvu->dev, "%s Requested Null address for transulation\n", __func__);
 		return -EINVAL;
 	}
 
+	mutex_lock(&rvu->rsrc_lock);
 	rvu_write64(rvu, BLKADDR_RVUM, RVU_AF_SMMU_ADDR_REQ, iova);
 	pf = rvu_get_pf(pcifunc) & 0x1F;
 	val = BIT_ULL(63) | BIT_ULL(14) | BIT_ULL(13) | pf << 8 |
@@ -76,12 +77,13 @@ static int rvu_get_lmtaddr(struct rvu *rvu, u16 pcifunc,
 	err = rvu_poll_reg(rvu, BLKADDR_RVUM, RVU_AF_SMMU_ADDR_RSP_STS, BIT_ULL(0), false);
 	if (err) {
 		dev_err(rvu->dev, "%s LMTLINE iova transulation failed\n", __func__);
-		return err;
+		goto exit;
 	}
 	val = rvu_read64(rvu, BLKADDR_RVUM, RVU_AF_SMMU_ADDR_RSP_STS);
 	if (val & ~0x1ULL) {
 		dev_err(rvu->dev, "%s LMTLINE iova transulation failed err:%llx\n", __func__, val);
-		return -EIO;
+		err = -EIO;
+		goto exit;
 	}
 	/* PA[51:12] = RVU_AF_SMMU_TLN_FLIT0[57:18]
 	 * PA[11:0] = IOVA[11:0]
@@ -89,8 +91,9 @@ static int rvu_get_lmtaddr(struct rvu *rvu, u16 pcifunc,
 	pa = rvu_read64(rvu, BLKADDR_RVUM, RVU_AF_SMMU_TLN_FLIT0) >> 18;
 	pa &= GENMASK_ULL(39, 0);
 	*lmt_addr = (pa << 12) | (iova  & 0xFFF);
-
-	return 0;
+exit:
+	mutex_unlock(&rvu->rsrc_lock);
+	return err;
 }
 
 static int rvu_update_lmtaddr(struct rvu *rvu, u16 pcifunc, u64 lmt_addr)
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
index abef0fd4259a..aadc352c2ffb 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
@@ -497,8 +497,9 @@ static int rvu_dbg_mcs_rx_secy_stats_display(struct seq_file *filp, void *unused
 			   stats.octet_validated_cnt);
 		seq_printf(filp, "secy%d: Pkts on disable port: %lld\n", secy_id,
 			   stats.pkt_port_disabled_cnt);
-		seq_printf(filp, "secy%d: Octets validated: %lld\n", secy_id, stats.pkt_badtag_cnt);
-		seq_printf(filp, "secy%d: Octets validated: %lld\n", secy_id, stats.pkt_nosa_cnt);
+		seq_printf(filp, "secy%d: Pkts with badtag: %lld\n", secy_id, stats.pkt_badtag_cnt);
+		seq_printf(filp, "secy%d: Pkts with no SA(sectag.tci.c=0): %lld\n", secy_id,
+			   stats.pkt_nosa_cnt);
 		seq_printf(filp, "secy%d: Pkts with nosaerror: %lld\n", secy_id,
 			   stats.pkt_nosaerror_cnt);
 		seq_printf(filp, "secy%d: Tagged ctrl pkts: %lld\n", secy_id,
@@ -2758,6 +2759,12 @@ static void rvu_dbg_npc_mcam_show_flows(struct seq_file *s,
 	for_each_set_bit(bit, (unsigned long *)&rule->features, 64) {
 		seq_printf(s, "\t%s  ", npc_get_field_name(bit));
 		switch (bit) {
+		case NPC_LXMB:
+			if (rule->lxmb == 1)
+				seq_puts(s, "\tL2M nibble is set\n");
+			else
+				seq_puts(s, "\tL2B nibble is set\n");
+			break;
 		case NPC_DMAC:
 			seq_printf(s, "%pM ", rule->packet.dmac);
 			seq_printf(s, "mask %pM\n", rule->mask.dmac);
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
index 1e348fd0d930..16cfc802e348 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
@@ -617,6 +617,12 @@ void rvu_npc_install_ucast_entry(struct rvu *rvu, u16 pcifunc,
 	if (blkaddr < 0)
 		return;
 
+	/* Ucast rule should not be installed if DMAC
+	 * extraction is not supported by the profile.
+	 */
+	if (!npc_is_feature_supported(rvu, BIT_ULL(NPC_DMAC), pfvf->nix_rx_intf))
+		return;
+
 	index = npc_get_nixlf_mcam_index(mcam, pcifunc,
 					 nixlf, NIXLF_UCAST_ENTRY);
 
@@ -778,6 +784,14 @@ void rvu_npc_install_bcast_match_entry(struct rvu *rvu, u16 pcifunc,
 	/* Get 'pcifunc' of PF device */
 	pcifunc = pcifunc & ~RVU_PFVF_FUNC_MASK;
 	pfvf = rvu_get_pfvf(rvu, pcifunc);
+
+	/* Bcast rule should not be installed if both DMAC
+	 * and LXMB extraction is not supported by the profile.
+	 */
+	if (!npc_is_feature_supported(rvu, BIT_ULL(NPC_DMAC), pfvf->nix_rx_intf) &&
+	    !npc_is_feature_supported(rvu, BIT_ULL(NPC_LXMB), pfvf->nix_rx_intf))
+		return;
+
 	index = npc_get_nixlf_mcam_index(mcam, pcifunc,
 					 nixlf, NIXLF_BCAST_ENTRY);
 
@@ -848,6 +862,14 @@ void rvu_npc_install_allmulti_entry(struct rvu *rvu, u16 pcifunc, int nixlf,
 	vf_func = pcifunc & RVU_PFVF_FUNC_MASK;
 	pcifunc = pcifunc & ~RVU_PFVF_FUNC_MASK;
 	pfvf = rvu_get_pfvf(rvu, pcifunc);
+
+	/* Mcast rule should not be installed if both DMAC
+	 * and LXMB extraction is not supported by the profile.
+	 */
+	if (!npc_is_feature_supported(rvu, BIT_ULL(NPC_DMAC), pfvf->nix_rx_intf) &&
+	    !npc_is_feature_supported(rvu, BIT_ULL(NPC_LXMB), pfvf->nix_rx_intf))
+		return;
+
 	index = npc_get_nixlf_mcam_index(mcam, pcifunc,
 					 nixlf, NIXLF_ALLMULTI_ENTRY);
 
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
index 7c4e1acd0f77..1eb5eb29a2ba 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
@@ -13,11 +13,6 @@
 #include "rvu_npc_fs.h"
 #include "rvu_npc_hash.h"
 
-#define NPC_BYTESM		GENMASK_ULL(19, 16)
-#define NPC_HDR_OFFSET		GENMASK_ULL(15, 8)
-#define NPC_KEY_OFFSET		GENMASK_ULL(5, 0)
-#define NPC_LDATA_EN		BIT_ULL(7)
-
 static const char * const npc_flow_names[] = {
 	[NPC_DMAC]	= "dmac",
 	[NPC_SMAC]	= "smac",
@@ -43,9 +38,23 @@ static const char * const npc_flow_names[] = {
 	[NPC_DPORT_UDP]	= "udp destination port",
 	[NPC_SPORT_SCTP] = "sctp source port",
 	[NPC_DPORT_SCTP] = "sctp destination port",
+	[NPC_LXMB]	= "Mcast/Bcast header ",
 	[NPC_UNKNOWN]	= "unknown",
 };
 
+bool npc_is_feature_supported(struct rvu *rvu, u64 features, u8 intf)
+{
+	struct npc_mcam *mcam = &rvu->hw->mcam;
+	u64 mcam_features;
+	u64 unsupported;
+
+	mcam_features = is_npc_intf_tx(intf) ? mcam->tx_features : mcam->rx_features;
+	unsupported = (mcam_features ^ features) & ~mcam_features;
+
+	/* Return false if at least one of the input flows is not extracted */
+	return !unsupported;
+}
+
 const char *npc_get_field_name(u8 hdr)
 {
 	if (hdr >= ARRAY_SIZE(npc_flow_names))
@@ -340,8 +349,10 @@ static void npc_handle_multi_layer_fields(struct rvu *rvu, int blkaddr, u8 intf)
 	vlan_tag2 = &key_fields[NPC_VLAN_TAG2];
 
 	/* if key profile programmed does not extract Ethertype at all */
-	if (!etype_ether->nr_kws && !etype_tag1->nr_kws && !etype_tag2->nr_kws)
+	if (!etype_ether->nr_kws && !etype_tag1->nr_kws && !etype_tag2->nr_kws) {
+		dev_err(rvu->dev, "mkex: Ethertype is not extracted.\n");
 		goto vlan_tci;
+	}
 
 	/* if key profile programmed extracts Ethertype from one layer */
 	if (etype_ether->nr_kws && !etype_tag1->nr_kws && !etype_tag2->nr_kws)
@@ -354,35 +365,45 @@ static void npc_handle_multi_layer_fields(struct rvu *rvu, int blkaddr, u8 intf)
 	/* if key profile programmed extracts Ethertype from multiple layers */
 	if (etype_ether->nr_kws && etype_tag1->nr_kws) {
 		for (i = 0; i < NPC_MAX_KWS_IN_KEY; i++) {
-			if (etype_ether->kw_mask[i] != etype_tag1->kw_mask[i])
+			if (etype_ether->kw_mask[i] != etype_tag1->kw_mask[i]) {
+				dev_err(rvu->dev, "mkex: Etype pos is different for untagged and tagged pkts.\n");
 				goto vlan_tci;
+			}
 		}
 		key_fields[NPC_ETYPE] = *etype_tag1;
 	}
 	if (etype_ether->nr_kws && etype_tag2->nr_kws) {
 		for (i = 0; i < NPC_MAX_KWS_IN_KEY; i++) {
-			if (etype_ether->kw_mask[i] != etype_tag2->kw_mask[i])
+			if (etype_ether->kw_mask[i] != etype_tag2->kw_mask[i]) {
+				dev_err(rvu->dev, "mkex: Etype pos is different for untagged and double tagged pkts.\n");
 				goto vlan_tci;
+			}
 		}
 		key_fields[NPC_ETYPE] = *etype_tag2;
 	}
 	if (etype_tag1->nr_kws && etype_tag2->nr_kws) {
 		for (i = 0; i < NPC_MAX_KWS_IN_KEY; i++) {
-			if (etype_tag1->kw_mask[i] != etype_tag2->kw_mask[i])
+			if (etype_tag1->kw_mask[i] != etype_tag2->kw_mask[i]) {
+				dev_err(rvu->dev, "mkex: Etype pos is different for tagged and double tagged pkts.\n");
 				goto vlan_tci;
+			}
 		}
 		key_fields[NPC_ETYPE] = *etype_tag2;
 	}
 
 	/* check none of higher layers overwrite Ethertype */
 	start_lid = key_fields[NPC_ETYPE].layer_mdata.lid + 1;
-	if (npc_check_overlap(rvu, blkaddr, NPC_ETYPE, start_lid, intf))
+	if (npc_check_overlap(rvu, blkaddr, NPC_ETYPE, start_lid, intf)) {
+		dev_err(rvu->dev, "mkex: Ethertype is overwritten by higher layers.\n");
 		goto vlan_tci;
+	}
 	*features |= BIT_ULL(NPC_ETYPE);
 vlan_tci:
 	/* if key profile does not extract outer vlan tci at all */
-	if (!vlan_tag1->nr_kws && !vlan_tag2->nr_kws)
+	if (!vlan_tag1->nr_kws && !vlan_tag2->nr_kws) {
+		dev_err(rvu->dev, "mkex: Outer vlan tci is not extracted.\n");
 		goto done;
+	}
 
 	/* if key profile extracts outer vlan tci from one layer */
 	if (vlan_tag1->nr_kws && !vlan_tag2->nr_kws)
@@ -393,15 +414,19 @@ static void npc_handle_multi_layer_fields(struct rvu *rvu, int blkaddr, u8 intf)
 	/* if key profile extracts outer vlan tci from multiple layers */
 	if (vlan_tag1->nr_kws && vlan_tag2->nr_kws) {
 		for (i = 0; i < NPC_MAX_KWS_IN_KEY; i++) {
-			if (vlan_tag1->kw_mask[i] != vlan_tag2->kw_mask[i])
+			if (vlan_tag1->kw_mask[i] != vlan_tag2->kw_mask[i]) {
+				dev_err(rvu->dev, "mkex: Out vlan tci pos is different for tagged and double tagged pkts.\n");
 				goto done;
+			}
 		}
 		key_fields[NPC_OUTER_VID] = *vlan_tag2;
 	}
 	/* check none of higher layers overwrite outer vlan tci */
 	start_lid = key_fields[NPC_OUTER_VID].layer_mdata.lid + 1;
-	if (npc_check_overlap(rvu, blkaddr, NPC_OUTER_VID, start_lid, intf))
+	if (npc_check_overlap(rvu, blkaddr, NPC_OUTER_VID, start_lid, intf)) {
+		dev_err(rvu->dev, "mkex: Outer vlan tci is overwritten by higher layers.\n");
 		goto done;
+	}
 	*features |= BIT_ULL(NPC_OUTER_VID);
 done:
 	return;
@@ -410,6 +435,7 @@ static void npc_handle_multi_layer_fields(struct rvu *rvu, int blkaddr, u8 intf)
 static void npc_scan_ldata(struct rvu *rvu, int blkaddr, u8 lid,
 			   u8 lt, u64 cfg, u8 intf)
 {
+	struct npc_mcam_kex_hash *mkex_hash = rvu->kpu.mkex_hash;
 	struct npc_mcam *mcam = &rvu->hw->mcam;
 	u8 hdr, key, nr_bytes, bit_offset;
 	u8 la_ltype, la_start;
@@ -419,8 +445,6 @@ static void npc_scan_ldata(struct rvu *rvu, int blkaddr, u8 lid,
 	nr_bytes = FIELD_GET(NPC_BYTESM, cfg) + 1;
 	hdr = FIELD_GET(NPC_HDR_OFFSET, cfg);
 	key = FIELD_GET(NPC_KEY_OFFSET, cfg);
-	start_kwi = key / 8;
-	offset = (key * 8) % 64;
 
 	/* For Tx, Layer A has NIX_INST_HDR_S(64 bytes) preceding
 	 * ethernet header.
@@ -435,13 +459,18 @@ static void npc_scan_ldata(struct rvu *rvu, int blkaddr, u8 lid,
 
 #define NPC_SCAN_HDR(name, hlid, hlt, hstart, hlen)			       \
 do {									       \
+	start_kwi = key / 8;						       \
+	offset = (key * 8) % 64;					       \
 	if (lid == (hlid) && lt == (hlt)) {				       \
 		if ((hstart) >= hdr &&					       \
 		    ((hstart) + (hlen)) <= (hdr + nr_bytes)) {	               \
 			bit_offset = (hdr + nr_bytes - (hstart) - (hlen)) * 8; \
 			npc_set_layer_mdata(mcam, (name), cfg, lid, lt, intf); \
+			offset += bit_offset;				       \
+			start_kwi += offset / 64;			       \
+			offset %= 64;					       \
 			npc_set_kw_masks(mcam, (name), (hlen) * 8,	       \
-					 start_kwi, offset + bit_offset, intf);\
+					 start_kwi, offset, intf);	       \
 		}							       \
 	}								       \
 } while (0)
@@ -453,8 +482,21 @@ do {									       \
 	NPC_SCAN_HDR(NPC_TOS, NPC_LID_LC, NPC_LT_LC_IP, 1, 1);
 	NPC_SCAN_HDR(NPC_SIP_IPV4, NPC_LID_LC, NPC_LT_LC_IP, 12, 4);
 	NPC_SCAN_HDR(NPC_DIP_IPV4, NPC_LID_LC, NPC_LT_LC_IP, 16, 4);
-	NPC_SCAN_HDR(NPC_SIP_IPV6, NPC_LID_LC, NPC_LT_LC_IP6, 8, 16);
-	NPC_SCAN_HDR(NPC_DIP_IPV6, NPC_LID_LC, NPC_LT_LC_IP6, 24, 16);
+	if (rvu->hw->cap.npc_hash_extract) {
+		if (mkex_hash->lid_lt_ld_hash_en[intf][lid][lt][0])
+			NPC_SCAN_HDR(NPC_SIP_IPV6, NPC_LID_LC, NPC_LT_LC_IP6, 8, 4);
+		else
+			NPC_SCAN_HDR(NPC_SIP_IPV6, NPC_LID_LC, NPC_LT_LC_IP6, 8, 16);
+
+		if (mkex_hash->lid_lt_ld_hash_en[intf][lid][lt][1])
+			NPC_SCAN_HDR(NPC_DIP_IPV6, NPC_LID_LC, NPC_LT_LC_IP6, 24, 4);
+		else
+			NPC_SCAN_HDR(NPC_DIP_IPV6, NPC_LID_LC, NPC_LT_LC_IP6, 24, 16);
+	} else {
+		NPC_SCAN_HDR(NPC_SIP_IPV6, NPC_LID_LC, NPC_LT_LC_IP6, 8, 16);
+		NPC_SCAN_HDR(NPC_DIP_IPV6, NPC_LID_LC, NPC_LT_LC_IP6, 24, 16);
+	}
+
 	NPC_SCAN_HDR(NPC_SPORT_UDP, NPC_LID_LD, NPC_LT_LD_UDP, 0, 2);
 	NPC_SCAN_HDR(NPC_DPORT_UDP, NPC_LID_LD, NPC_LT_LD_UDP, 2, 2);
 	NPC_SCAN_HDR(NPC_SPORT_TCP, NPC_LID_LD, NPC_LT_LD_TCP, 0, 2);
@@ -522,6 +564,10 @@ static void npc_set_features(struct rvu *rvu, int blkaddr, u8 intf)
 	if (npc_check_field(rvu, blkaddr, NPC_LB, intf))
 		*features |= BIT_ULL(NPC_VLAN_ETYPE_CTAG) |
 			     BIT_ULL(NPC_VLAN_ETYPE_STAG);
+
+	/* for L2M/L2B/L3M/L3B, check if the type is present in the key */
+	if (npc_check_field(rvu, blkaddr, NPC_LXMB, intf))
+		*features |= BIT_ULL(NPC_LXMB);
 }
 
 /* Scan key extraction profile and record how fields of our interest
@@ -553,8 +599,7 @@ static int npc_scan_kex(struct rvu *rvu, int blkaddr, u8 intf)
 	 */
 	masked_cfg = cfg & NPC_EXACT_NIBBLE;
 	bitnr = NPC_EXACT_NIBBLE_START;
-	for_each_set_bit_from(bitnr, (unsigned long *)&masked_cfg,
-			      NPC_EXACT_NIBBLE_START) {
+	for_each_set_bit_from(bitnr, (unsigned long *)&masked_cfg, NPC_EXACT_NIBBLE_END + 1) {
 		npc_scan_exact_result(mcam, bitnr, key_nibble, intf);
 		key_nibble++;
 	}
@@ -599,16 +644,6 @@ static int npc_scan_verify_kex(struct rvu *rvu, int blkaddr)
 		dev_err(rvu->dev, "Channel cannot be overwritten\n");
 		return -EINVAL;
 	}
-	/* DMAC should be present in key for unicast filter to work */
-	if (!npc_is_field_present(rvu, NPC_DMAC, NIX_INTF_RX)) {
-		dev_err(rvu->dev, "DMAC not present in Key\n");
-		return -EINVAL;
-	}
-	/* check that none of the fields overwrite DMAC */
-	if (npc_check_overlap(rvu, blkaddr, NPC_DMAC, 0, NIX_INTF_RX)) {
-		dev_err(rvu->dev, "DMAC cannot be overwritten\n");
-		return -EINVAL;
-	}
 
 	npc_set_features(rvu, blkaddr, NIX_INTF_TX);
 	npc_set_features(rvu, blkaddr, NIX_INTF_RX);
@@ -639,9 +674,9 @@ static int npc_check_unsupported_flows(struct rvu *rvu, u64 features, u8 intf)
 
 	unsupported = (*mcam_features ^ features) & ~(*mcam_features);
 	if (unsupported) {
-		dev_info(rvu->dev, "Unsupported flow(s):\n");
+		dev_warn(rvu->dev, "Unsupported flow(s):\n");
 		for_each_set_bit(bit, (unsigned long *)&unsupported, 64)
-			dev_info(rvu->dev, "%s ", npc_get_field_name(bit));
+			dev_warn(rvu->dev, "%s ", npc_get_field_name(bit));
 		return -EOPNOTSUPP;
 	}
 
@@ -851,6 +886,11 @@ static void npc_update_flow(struct rvu *rvu, struct mcam_entry *entry,
 		npc_update_entry(rvu, NPC_LE, entry, NPC_LT_LE_ESP,
 				 0, ~0ULL, 0, intf);
 
+	if (features & BIT_ULL(NPC_LXMB)) {
+		output->lxmb = is_broadcast_ether_addr(pkt->dmac) ? 2 : 1;
+		npc_update_entry(rvu, NPC_LXMB, entry, output->lxmb, 0,
+				 output->lxmb, 0, intf);
+	}
 #define NPC_WRITE_FLOW(field, member, val_lo, val_hi, mask_lo, mask_hi)	      \
 do {									      \
 	if (features & BIT_ULL((field))) {				      \
@@ -991,8 +1031,20 @@ static void npc_update_rx_entry(struct rvu *rvu, struct rvu_pfvf *pfvf,
 	action.match_id = req->match_id;
 	action.flow_key_alg = req->flow_key_alg;
 
-	if (req->op == NIX_RX_ACTION_DEFAULT && pfvf->def_ucast_rule)
-		action = pfvf->def_ucast_rule->rx_action;
+	if (req->op == NIX_RX_ACTION_DEFAULT) {
+		if (pfvf->def_ucast_rule) {
+			action = pfvf->def_ucast_rule->rx_action;
+		} else {
+			/* For profiles which do not extract DMAC, the default
+			 * unicast entry is unused. Hence modify action for the
+			 * requests which use same action as default unicast
+			 * entry
+			 */
+			*(u64 *)&action = 0;
+			action.pf_func = target;
+			action.op = NIX_RX_ACTIONOP_UCAST;
+		}
+	}
 
 	entry->action = *(u64 *)&action;
 
@@ -1153,6 +1205,7 @@ static int npc_install_flow(struct rvu *rvu, int blkaddr, u16 target,
 	rule->chan_mask = write_req.entry_data.kw_mask[0] & NPC_KEX_CHAN_MASK;
 	rule->chan = write_req.entry_data.kw[0] & NPC_KEX_CHAN_MASK;
 	rule->chan &= rule->chan_mask;
+	rule->lxmb = dummy.lxmb;
 	if (is_npc_intf_tx(req->intf))
 		rule->intf = pfvf->nix_tx_intf;
 	else
@@ -1215,6 +1268,35 @@ int rvu_mbox_handler_npc_install_flow(struct rvu *rvu,
 	if (!is_npc_interface_valid(rvu, req->intf))
 		return NPC_FLOW_INTF_INVALID;
 
+	/* If DMAC is not extracted in MKEX, rules installed by AF
+	 * can rely on L2MB bit set by hardware protocol checker for
+	 * broadcast and multicast addresses.
+	 */
+	if (npc_check_field(rvu, blkaddr, NPC_DMAC, req->intf))
+		goto process_flow;
+
+	if (is_pffunc_af(req->hdr.pcifunc) &&
+	    req->features & BIT_ULL(NPC_DMAC)) {
+		if (is_unicast_ether_addr(req->packet.dmac)) {
+			dev_warn(rvu->dev,
+				 "%s: mkex profile does not support ucast flow\n",
+				 __func__);
+			return NPC_FLOW_NOT_SUPPORTED;
+		}
+
+		if (!npc_is_field_present(rvu, NPC_LXMB, req->intf)) {
+			dev_warn(rvu->dev,
+				 "%s: mkex profile does not support bcast/mcast flow",
+				 __func__);
+			return NPC_FLOW_NOT_SUPPORTED;
+		}
+
+		/* Modify feature to use LXMB instead of DMAC */
+		req->features &= ~BIT_ULL(NPC_DMAC);
+		req->features |= BIT_ULL(NPC_LXMB);
+	}
+
+process_flow:
 	if (from_vf && req->default_rule)
 		return NPC_FLOW_VF_PERM_DENIED;
 
@@ -1558,3 +1640,22 @@ int npc_install_mcam_drop_rule(struct rvu *rvu, int mcam_idx, u16 *counter_idx,
 
 	return 0;
 }
+
+int rvu_mbox_handler_npc_get_field_status(struct rvu *rvu,
+					  struct npc_get_field_status_req *req,
+					  struct npc_get_field_status_rsp *rsp)
+{
+	int blkaddr;
+
+	blkaddr = rvu_get_blkaddr(rvu, BLKTYPE_NPC, 0);
+	if (blkaddr < 0)
+		return NPC_MCAM_INVALID_REQ;
+
+	if (!is_npc_interface_valid(rvu, req->intf))
+		return NPC_FLOW_INTF_INVALID;
+
+	if (npc_check_field(rvu, blkaddr, req->field, req->intf))
+		rsp->enable = 1;
+
+	return 0;
+}
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.h b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.h
index bdd65ce56a32..3f5c9042d10e 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.h
@@ -9,6 +9,10 @@
 #define __RVU_NPC_FS_H
 
 #define IPV6_WORDS	4
+#define NPC_BYTESM	GENMASK_ULL(19, 16)
+#define NPC_HDR_OFFSET	GENMASK_ULL(15, 8)
+#define NPC_KEY_OFFSET	GENMASK_ULL(5, 0)
+#define NPC_LDATA_EN	BIT_ULL(7)
 
 void npc_update_entry(struct rvu *rvu, enum key_fields type,
 		      struct mcam_entry *entry, u64 val_lo,
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_hash.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_hash.c
index 594029007f85..3182adb7b9a8 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_hash.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_hash.c
@@ -78,42 +78,43 @@ static u32 rvu_npc_toeplitz_hash(const u64 *data, u64 *key, size_t data_bit_len,
 	return hash_out;
 }
 
-u32 npc_field_hash_calc(u64 *ldata, struct npc_mcam_kex_hash *mkex_hash,
-			u64 *secret_key, u8 intf, u8 hash_idx)
+u32 npc_field_hash_calc(u64 *ldata, struct npc_get_field_hash_info_rsp rsp,
+			u8 intf, u8 hash_idx)
 {
 	u64 hash_key[3];
 	u64 data_padded[2];
 	u32 field_hash;
 
-	hash_key[0] = secret_key[1] << 31;
-	hash_key[0] |= secret_key[2];
-	hash_key[1] = secret_key[1] >> 33;
-	hash_key[1] |= secret_key[0] << 31;
-	hash_key[2] = secret_key[0] >> 33;
+	hash_key[0] = rsp.secret_key[1] << 31;
+	hash_key[0] |= rsp.secret_key[2];
+	hash_key[1] = rsp.secret_key[1] >> 33;
+	hash_key[1] |= rsp.secret_key[0] << 31;
+	hash_key[2] = rsp.secret_key[0] >> 33;
 
-	data_padded[0] = mkex_hash->hash_mask[intf][hash_idx][0] & ldata[0];
-	data_padded[1] = mkex_hash->hash_mask[intf][hash_idx][1] & ldata[1];
+	data_padded[0] = rsp.hash_mask[intf][hash_idx][0] & ldata[0];
+	data_padded[1] = rsp.hash_mask[intf][hash_idx][1] & ldata[1];
 	field_hash = rvu_npc_toeplitz_hash(data_padded, hash_key, 128, 159);
 
-	field_hash &= mkex_hash->hash_ctrl[intf][hash_idx] >> 32;
-	field_hash |= mkex_hash->hash_ctrl[intf][hash_idx];
+	field_hash &= FIELD_GET(GENMASK(63, 32), rsp.hash_ctrl[intf][hash_idx]);
+	field_hash += FIELD_GET(GENMASK(31, 0), rsp.hash_ctrl[intf][hash_idx]);
 	return field_hash;
 }
 
-static u64 npc_update_use_hash(int lt, int ld)
+static u64 npc_update_use_hash(struct rvu *rvu, int blkaddr,
+			       u8 intf, int lid, int lt, int ld)
 {
-	u64 cfg = 0;
-
-	switch (lt) {
-	case NPC_LT_LC_IP6:
-		/* Update use_hash(bit-20) and bytesm1 (bit-16:19)
-		 * in KEX_LD_CFG
-		 */
-		cfg = KEX_LD_CFG_USE_HASH(0x1, 0x03,
-					  ld ? 0x8 : 0x18,
-					  0x1, 0x0, 0x10);
-		break;
-	}
+	u8 hdr, key;
+	u64 cfg;
+
+	cfg = rvu_read64(rvu, blkaddr, NPC_AF_INTFX_LIDX_LTX_LDX_CFG(intf, lid, lt, ld));
+	hdr = FIELD_GET(NPC_HDR_OFFSET, cfg);
+	key = FIELD_GET(NPC_KEY_OFFSET, cfg);
+
+	/* Update use_hash(bit-20) to 'true' and
+	 * bytesm1(bit-16:19) to '0x3' in KEX_LD_CFG
+	 */
+	cfg = KEX_LD_CFG_USE_HASH(0x1, 0x03,
+				  hdr, 0x1, 0x0, key);
 
 	return cfg;
 }
@@ -132,12 +133,13 @@ static void npc_program_mkex_hash_rx(struct rvu *rvu, int blkaddr,
 		for (lt = 0; lt < NPC_MAX_LT; lt++) {
 			for (ld = 0; ld < NPC_MAX_LD; ld++) {
 				if (mkex_hash->lid_lt_ld_hash_en[intf][lid][lt][ld]) {
-					u64 cfg = npc_update_use_hash(lt, ld);
+					u64 cfg;
 
-					hash_cnt++;
 					if (hash_cnt == NPC_MAX_HASH)
 						return;
 
+					cfg = npc_update_use_hash(rvu, blkaddr,
+								  intf, lid, lt, ld);
 					/* Set updated KEX configuration */
 					SET_KEX_LD(intf, lid, lt, ld, cfg);
 					/* Set HASH configuration */
@@ -149,6 +151,8 @@ static void npc_program_mkex_hash_rx(struct rvu *rvu, int blkaddr,
 							     mkex_hash->hash_mask[intf][ld][1]);
 					SET_KEX_LD_HASH_CTRL(intf, ld,
 							     mkex_hash->hash_ctrl[intf][ld]);
+
+					hash_cnt++;
 				}
 			}
 		}
@@ -169,12 +173,13 @@ static void npc_program_mkex_hash_tx(struct rvu *rvu, int blkaddr,
 		for (lt = 0; lt < NPC_MAX_LT; lt++) {
 			for (ld = 0; ld < NPC_MAX_LD; ld++)
 				if (mkex_hash->lid_lt_ld_hash_en[intf][lid][lt][ld]) {
-					u64 cfg = npc_update_use_hash(lt, ld);
+					u64 cfg;
 
-					hash_cnt++;
 					if (hash_cnt == NPC_MAX_HASH)
 						return;
 
+					cfg = npc_update_use_hash(rvu, blkaddr,
+								  intf, lid, lt, ld);
 					/* Set updated KEX configuration */
 					SET_KEX_LD(intf, lid, lt, ld, cfg);
 					/* Set HASH configuration */
@@ -187,8 +192,6 @@ static void npc_program_mkex_hash_tx(struct rvu *rvu, int blkaddr,
 					SET_KEX_LD_HASH_CTRL(intf, ld,
 							     mkex_hash->hash_ctrl[intf][ld]);
 					hash_cnt++;
-					if (hash_cnt == NPC_MAX_HASH)
-						return;
 				}
 		}
 	}
@@ -242,8 +245,8 @@ void npc_update_field_hash(struct rvu *rvu, u8 intf,
 			   struct flow_msg *omask)
 {
 	struct npc_mcam_kex_hash *mkex_hash = rvu->kpu.mkex_hash;
-	struct npc_get_secret_key_req req;
-	struct npc_get_secret_key_rsp rsp;
+	struct npc_get_field_hash_info_req req;
+	struct npc_get_field_hash_info_rsp rsp;
 	u64 ldata[2], cfg;
 	u32 field_hash;
 	u8 hash_idx;
@@ -254,7 +257,7 @@ void npc_update_field_hash(struct rvu *rvu, u8 intf,
 	}
 
 	req.intf = intf;
-	rvu_mbox_handler_npc_get_secret_key(rvu, &req, &rsp);
+	rvu_mbox_handler_npc_get_field_hash_info(rvu, &req, &rsp);
 
 	for (hash_idx = 0; hash_idx < NPC_MAX_HASH; hash_idx++) {
 		cfg = rvu_read64(rvu, blkaddr, NPC_AF_INTFX_HASHX_CFG(intf, hash_idx));
@@ -270,44 +273,45 @@ void npc_update_field_hash(struct rvu *rvu, u8 intf,
 				 * is hashed to 32 bit value.
 				 */
 				case NPC_LT_LC_IP6:
-					if (features & BIT_ULL(NPC_SIP_IPV6)) {
+					/* ld[0] == hash_idx[0] == Source IPv6
+					 * ld[1] == hash_idx[1] == Destination IPv6
+					 */
+					if ((features & BIT_ULL(NPC_SIP_IPV6)) && !hash_idx) {
 						u32 src_ip[IPV6_WORDS];
 
 						be32_to_cpu_array(src_ip, pkt->ip6src, IPV6_WORDS);
-						ldata[0] = (u64)src_ip[0] << 32 | src_ip[1];
-						ldata[1] = (u64)src_ip[2] << 32 | src_ip[3];
+						ldata[1] = (u64)src_ip[0] << 32 | src_ip[1];
+						ldata[0] = (u64)src_ip[2] << 32 | src_ip[3];
 						field_hash = npc_field_hash_calc(ldata,
-										 mkex_hash,
-										 rsp.secret_key,
+										 rsp,
 										 intf,
 										 hash_idx);
 						npc_update_entry(rvu, NPC_SIP_IPV6, entry,
-								 field_hash, 0, 32, 0, intf);
+								 field_hash, 0,
+								 GENMASK(31, 0), 0, intf);
 						memcpy(&opkt->ip6src, &pkt->ip6src,
 						       sizeof(pkt->ip6src));
 						memcpy(&omask->ip6src, &mask->ip6src,
 						       sizeof(mask->ip6src));
-						break;
-					}
-
-					if (features & BIT_ULL(NPC_DIP_IPV6)) {
+					} else if ((features & BIT_ULL(NPC_DIP_IPV6)) && hash_idx) {
 						u32 dst_ip[IPV6_WORDS];
 
 						be32_to_cpu_array(dst_ip, pkt->ip6dst, IPV6_WORDS);
-						ldata[0] = (u64)dst_ip[0] << 32 | dst_ip[1];
-						ldata[1] = (u64)dst_ip[2] << 32 | dst_ip[3];
+						ldata[1] = (u64)dst_ip[0] << 32 | dst_ip[1];
+						ldata[0] = (u64)dst_ip[2] << 32 | dst_ip[3];
 						field_hash = npc_field_hash_calc(ldata,
-										 mkex_hash,
-										 rsp.secret_key,
+										 rsp,
 										 intf,
 										 hash_idx);
 						npc_update_entry(rvu, NPC_DIP_IPV6, entry,
-								 field_hash, 0, 32, 0, intf);
+								 field_hash, 0,
+								 GENMASK(31, 0), 0, intf);
 						memcpy(&opkt->ip6dst, &pkt->ip6dst,
 						       sizeof(pkt->ip6dst));
 						memcpy(&omask->ip6dst, &mask->ip6dst,
 						       sizeof(mask->ip6dst));
 					}
+
 					break;
 				}
 			}
@@ -315,13 +319,13 @@ void npc_update_field_hash(struct rvu *rvu, u8 intf,
 	}
 }
 
-int rvu_mbox_handler_npc_get_secret_key(struct rvu *rvu,
-					struct npc_get_secret_key_req *req,
-					struct npc_get_secret_key_rsp *rsp)
+int rvu_mbox_handler_npc_get_field_hash_info(struct rvu *rvu,
+					     struct npc_get_field_hash_info_req *req,
+					     struct npc_get_field_hash_info_rsp *rsp)
 {
 	u64 *secret_key = rsp->secret_key;
 	u8 intf = req->intf;
-	int blkaddr;
+	int i, j, blkaddr;
 
 	blkaddr = rvu_get_blkaddr(rvu, BLKTYPE_NPC, 0);
 	if (blkaddr < 0) {
@@ -333,6 +337,19 @@ int rvu_mbox_handler_npc_get_secret_key(struct rvu *rvu,
 	secret_key[1] = rvu_read64(rvu, blkaddr, NPC_AF_INTFX_SECRET_KEY1(intf));
 	secret_key[2] = rvu_read64(rvu, blkaddr, NPC_AF_INTFX_SECRET_KEY2(intf));
 
+	for (i = 0; i < NPC_MAX_HASH; i++) {
+		for (j = 0; j < NPC_MAX_HASH_MASK; j++) {
+			rsp->hash_mask[NIX_INTF_RX][i][j] =
+				GET_KEX_LD_HASH_MASK(NIX_INTF_RX, i, j);
+			rsp->hash_mask[NIX_INTF_TX][i][j] =
+				GET_KEX_LD_HASH_MASK(NIX_INTF_TX, i, j);
+		}
+	}
+
+	for (i = 0; i < NPC_MAX_INTF; i++)
+		for (j = 0; j < NPC_MAX_HASH; j++)
+			rsp->hash_ctrl[i][j] = GET_KEX_LD_HASH_CTRL(i, j);
+
 	return 0;
 }
 
@@ -1879,9 +1896,9 @@ int rvu_npc_exact_init(struct rvu *rvu)
 	rvu->hw->table = table;
 
 	/* Read table size, ways and depth */
-	table->mem_table.depth = FIELD_GET(GENMASK_ULL(31, 24), npc_const3);
 	table->mem_table.ways = FIELD_GET(GENMASK_ULL(19, 16), npc_const3);
-	table->cam_table.depth = FIELD_GET(GENMASK_ULL(15, 0), npc_const3);
+	table->mem_table.depth = FIELD_GET(GENMASK_ULL(15, 0), npc_const3);
+	table->cam_table.depth = FIELD_GET(GENMASK_ULL(31, 24), npc_const3);
 
 	dev_dbg(rvu->dev, "%s: NPC exact match 4way_2k table(ways=%d, depth=%d)\n",
 		__func__,  table->mem_table.ways, table->cam_table.depth);
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_hash.h b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_hash.h
index 3efeb09c58de..a1c3d987b804 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_hash.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_hash.h
@@ -31,6 +31,12 @@
 	rvu_write64(rvu, blkaddr,	\
 		    NPC_AF_INTFX_HASHX_MASKX(intf, ld, mask_idx), cfg)
 
+#define GET_KEX_LD_HASH_CTRL(intf, ld)	\
+	rvu_read64(rvu, blkaddr, NPC_AF_INTFX_HASHX_RESULT_CTRL(intf, ld))
+
+#define GET_KEX_LD_HASH_MASK(intf, ld, mask_idx)	\
+	rvu_read64(rvu, blkaddr, NPC_AF_INTFX_HASHX_MASKX(intf, ld, mask_idx))
+
 #define SET_KEX_LD_HASH_CTRL(intf, ld, cfg) \
 	rvu_write64(rvu, blkaddr,	\
 		    NPC_AF_INTFX_HASHX_RESULT_CTRL(intf, ld), cfg)
@@ -56,8 +62,8 @@ void npc_update_field_hash(struct rvu *rvu, u8 intf,
 			   struct flow_msg *omask);
 void npc_config_secret_key(struct rvu *rvu, int blkaddr);
 void npc_program_mkex_hash(struct rvu *rvu, int blkaddr);
-u32 npc_field_hash_calc(u64 *ldata, struct npc_mcam_kex_hash *mkex_hash,
-			u64 *secret_key, u8 intf, u8 hash_idx);
+u32 npc_field_hash_calc(u64 *ldata, struct npc_get_field_hash_info_rsp rsp,
+			u8 intf, u8 hash_idx);
 
 static struct npc_mcam_kex_hash npc_mkex_hash_default __maybe_unused = {
 	.lid_lt_ld_hash_en = {
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_macsec.c b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_macsec.c
index 9ec5f38d38a8..a487a98eac88 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_macsec.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_macsec.c
@@ -9,6 +9,7 @@
 #include <net/macsec.h>
 #include "otx2_common.h"
 
+#define MCS_TCAM0_MAC_DA_MASK		GENMASK_ULL(47, 0)
 #define MCS_TCAM0_MAC_SA_MASK		GENMASK_ULL(63, 48)
 #define MCS_TCAM1_MAC_SA_MASK		GENMASK_ULL(31, 0)
 #define MCS_TCAM1_ETYPE_MASK		GENMASK_ULL(47, 32)
@@ -149,11 +150,20 @@ static void cn10k_mcs_free_rsrc(struct otx2_nic *pfvf, enum mcs_direction dir,
 				enum mcs_rsrc_type type, u16 hw_rsrc_id,
 				bool all)
 {
+	struct mcs_clear_stats *clear_req;
 	struct mbox *mbox = &pfvf->mbox;
 	struct mcs_free_rsrc_req *req;
 
 	mutex_lock(&mbox->lock);
 
+	clear_req = otx2_mbox_alloc_msg_mcs_clear_stats(mbox);
+	if (!clear_req)
+		goto fail;
+
+	clear_req->id = hw_rsrc_id;
+	clear_req->type = type;
+	clear_req->dir = dir;
+
 	req = otx2_mbox_alloc_msg_mcs_free_resources(mbox);
 	if (!req)
 		goto fail;
@@ -237,8 +247,10 @@ static int cn10k_mcs_write_rx_flowid(struct otx2_nic *pfvf,
 				     struct cn10k_mcs_rxsc *rxsc, u8 hw_secy_id)
 {
 	struct macsec_rx_sc *sw_rx_sc = rxsc->sw_rxsc;
+	struct macsec_secy *secy = rxsc->sw_secy;
 	struct mcs_flowid_entry_write_req *req;
 	struct mbox *mbox = &pfvf->mbox;
+	u64 mac_da;
 	int ret;
 
 	mutex_lock(&mbox->lock);
@@ -249,11 +261,16 @@ static int cn10k_mcs_write_rx_flowid(struct otx2_nic *pfvf,
 		goto fail;
 	}
 
+	mac_da = ether_addr_to_u64(secy->netdev->dev_addr);
+
+	req->data[0] = FIELD_PREP(MCS_TCAM0_MAC_DA_MASK, mac_da);
+	req->mask[0] = ~0ULL;
+	req->mask[0] = ~MCS_TCAM0_MAC_DA_MASK;
+
 	req->data[1] = FIELD_PREP(MCS_TCAM1_ETYPE_MASK, ETH_P_MACSEC);
 	req->mask[1] = ~0ULL;
 	req->mask[1] &= ~MCS_TCAM1_ETYPE_MASK;
 
-	req->mask[0] = ~0ULL;
 	req->mask[2] = ~0ULL;
 	req->mask[3] = ~0ULL;
 
@@ -997,7 +1014,7 @@ static void cn10k_mcs_sync_stats(struct otx2_nic *pfvf, struct macsec_secy *secy
 
 	/* Check if sync is really needed */
 	if (secy->validate_frames == txsc->last_validate_frames &&
-	    secy->protect_frames == txsc->last_protect_frames)
+	    secy->replay_protect == txsc->last_replay_protect)
 		return;
 
 	cn10k_mcs_secy_stats(pfvf, txsc->hw_secy_id_rx, &rx_rsp, MCS_RX, true);
@@ -1019,19 +1036,19 @@ static void cn10k_mcs_sync_stats(struct otx2_nic *pfvf, struct macsec_secy *secy
 		rxsc->stats.InPktsInvalid += sc_rsp.pkt_invalid_cnt;
 		rxsc->stats.InPktsNotValid += sc_rsp.pkt_notvalid_cnt;
 
-		if (txsc->last_protect_frames)
+		if (txsc->last_replay_protect)
 			rxsc->stats.InPktsLate += sc_rsp.pkt_late_cnt;
 		else
 			rxsc->stats.InPktsDelayed += sc_rsp.pkt_late_cnt;
 
-		if (txsc->last_validate_frames == MACSEC_VALIDATE_CHECK)
+		if (txsc->last_validate_frames == MACSEC_VALIDATE_DISABLED)
 			rxsc->stats.InPktsUnchecked += sc_rsp.pkt_unchecked_cnt;
 		else
 			rxsc->stats.InPktsOK += sc_rsp.pkt_unchecked_cnt;
 	}
 
 	txsc->last_validate_frames = secy->validate_frames;
-	txsc->last_protect_frames = secy->protect_frames;
+	txsc->last_replay_protect = secy->replay_protect;
 }
 
 static int cn10k_mdo_open(struct macsec_context *ctx)
@@ -1100,7 +1117,7 @@ static int cn10k_mdo_add_secy(struct macsec_context *ctx)
 	txsc->sw_secy = secy;
 	txsc->encoding_sa = secy->tx_sc.encoding_sa;
 	txsc->last_validate_frames = secy->validate_frames;
-	txsc->last_protect_frames = secy->protect_frames;
+	txsc->last_replay_protect = secy->replay_protect;
 
 	list_add(&txsc->entry, &cfg->txsc_list);
 
@@ -1117,6 +1134,7 @@ static int cn10k_mdo_upd_secy(struct macsec_context *ctx)
 	struct macsec_secy *secy = ctx->secy;
 	struct macsec_tx_sa *sw_tx_sa;
 	struct cn10k_mcs_txsc *txsc;
+	bool active;
 	u8 sa_num;
 	int err;
 
@@ -1124,15 +1142,19 @@ static int cn10k_mdo_upd_secy(struct macsec_context *ctx)
 	if (!txsc)
 		return -ENOENT;
 
-	txsc->encoding_sa = secy->tx_sc.encoding_sa;
-
-	sa_num = txsc->encoding_sa;
-	sw_tx_sa = rcu_dereference_bh(secy->tx_sc.sa[sa_num]);
+	/* Encoding SA got changed */
+	if (txsc->encoding_sa != secy->tx_sc.encoding_sa) {
+		txsc->encoding_sa = secy->tx_sc.encoding_sa;
+		sa_num = txsc->encoding_sa;
+		sw_tx_sa = rcu_dereference_bh(secy->tx_sc.sa[sa_num]);
+		active = sw_tx_sa ? sw_tx_sa->active : false;
+		cn10k_mcs_link_tx_sa2sc(pfvf, secy, txsc, sa_num, active);
+	}
 
 	if (netif_running(secy->netdev)) {
 		cn10k_mcs_sync_stats(pfvf, secy, txsc);
 
-		err = cn10k_mcs_secy_tx_cfg(pfvf, secy, txsc, sw_tx_sa, sa_num);
+		err = cn10k_mcs_secy_tx_cfg(pfvf, secy, txsc, NULL, 0);
 		if (err)
 			return err;
 	}
@@ -1521,12 +1543,12 @@ static int cn10k_mdo_get_rx_sc_stats(struct macsec_context *ctx)
 	rxsc->stats.InPktsInvalid += rsp.pkt_invalid_cnt;
 	rxsc->stats.InPktsNotValid += rsp.pkt_notvalid_cnt;
 
-	if (secy->protect_frames)
+	if (secy->replay_protect)
 		rxsc->stats.InPktsLate += rsp.pkt_late_cnt;
 	else
 		rxsc->stats.InPktsDelayed += rsp.pkt_late_cnt;
 
-	if (secy->validate_frames == MACSEC_VALIDATE_CHECK)
+	if (secy->validate_frames == MACSEC_VALIDATE_DISABLED)
 		rxsc->stats.InPktsUnchecked += rsp.pkt_unchecked_cnt;
 	else
 		rxsc->stats.InPktsOK += rsp.pkt_unchecked_cnt;
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
index 712715a49d20..241016ca64d0 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
@@ -332,11 +332,11 @@ struct otx2_flow_config {
 #define OTX2_PER_VF_VLAN_FLOWS	2 /* Rx + Tx per VF */
 #define OTX2_VF_VLAN_RX_INDEX	0
 #define OTX2_VF_VLAN_TX_INDEX	1
-	u16			max_flows;
-	u8			dmacflt_max_flows;
 	u32			*bmap_to_dmacindex;
 	unsigned long		*dmacflt_bmap;
 	struct list_head	flow_list;
+	u32			dmacflt_max_flows;
+	u16                     max_flows;
 };
 
 struct otx2_tc_info {
@@ -386,7 +386,7 @@ struct cn10k_mcs_txsc {
 	struct cn10k_txsc_stats stats;
 	struct list_head entry;
 	enum macsec_validation_type last_validate_frames;
-	bool last_protect_frames;
+	bool last_replay_protect;
 	u16 hw_secy_id_tx;
 	u16 hw_secy_id_rx;
 	u16 hw_flow_id;
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c
index 0f7345a96965..d0554f6d2673 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c
@@ -164,6 +164,8 @@ EXPORT_SYMBOL(otx2_alloc_mcam_entries);
 static int otx2_mcam_entry_init(struct otx2_nic *pfvf)
 {
 	struct otx2_flow_config *flow_cfg = pfvf->flow_cfg;
+	struct npc_get_field_status_req *freq;
+	struct npc_get_field_status_rsp *frsp;
 	struct npc_mcam_alloc_entry_req *req;
 	struct npc_mcam_alloc_entry_rsp *rsp;
 	int vf_vlan_max_flows;
@@ -214,8 +216,29 @@ static int otx2_mcam_entry_init(struct otx2_nic *pfvf)
 	flow_cfg->rx_vlan_offset = flow_cfg->unicast_offset +
 					OTX2_MAX_UNICAST_FLOWS;
 	pfvf->flags |= OTX2_FLAG_UCAST_FLTR_SUPPORT;
-	pfvf->flags |= OTX2_FLAG_RX_VLAN_SUPPORT;
-	pfvf->flags |= OTX2_FLAG_VF_VLAN_SUPPORT;
+
+	/* Check if NPC_DMAC field is supported
+	 * by the mkex profile before setting VLAN support flag.
+	 */
+	freq = otx2_mbox_alloc_msg_npc_get_field_status(&pfvf->mbox);
+	if (!freq) {
+		mutex_unlock(&pfvf->mbox.lock);
+		return -ENOMEM;
+	}
+
+	freq->field = NPC_DMAC;
+	if (otx2_sync_mbox_msg(&pfvf->mbox)) {
+		mutex_unlock(&pfvf->mbox.lock);
+		return -EINVAL;
+	}
+
+	frsp = (struct npc_get_field_status_rsp *)otx2_mbox_get_rsp
+	       (&pfvf->mbox.mbox, 0, &freq->hdr);
+
+	if (frsp->enable) {
+		pfvf->flags |= OTX2_FLAG_RX_VLAN_SUPPORT;
+		pfvf->flags |= OTX2_FLAG_VF_VLAN_SUPPORT;
+	}
 
 	pfvf->flags |= OTX2_FLAG_MCAM_ENTRIES_ALLOC;
 	mutex_unlock(&pfvf->mbox.lock);
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
index 303930499a4c..ed911d994627 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
@@ -1835,13 +1835,22 @@ int otx2_open(struct net_device *netdev)
 		otx2_dmacflt_reinstall_flows(pf);
 
 	err = otx2_rxtx_enable(pf, true);
-	if (err)
+	/* If a mbox communication error happens at this point then interface
+	 * will end up in a state such that it is in down state but hardware
+	 * mcam entries are enabled to receive the packets. Hence disable the
+	 * packet I/O.
+	 */
+	if (err == EIO)
+		goto err_disable_rxtx;
+	else if (err)
 		goto err_tx_stop_queues;
 
 	otx2_do_set_rx_mode(pf);
 
 	return 0;
 
+err_disable_rxtx:
+	otx2_rxtx_enable(pf, false);
 err_tx_stop_queues:
 	netif_tx_stop_all_queues(netdev);
 	netif_carrier_off(netdev);
@@ -3069,8 +3078,6 @@ static void otx2_remove(struct pci_dev *pdev)
 		otx2_config_pause_frm(pf);
 	}
 
-	cn10k_mcs_free(pf);
-
 #ifdef CONFIG_DCB
 	/* Disable PFC config */
 	if (pf->pfc_en) {
@@ -3084,6 +3091,7 @@ static void otx2_remove(struct pci_dev *pdev)
 
 	otx2_unregister_dl(pf);
 	unregister_netdev(netdev);
+	cn10k_mcs_free(pf);
 	otx2_sriov_disable(pf->pdev);
 	otx2_sriov_vfcfg_cleanup(pf);
 	if (pf->otx2_wq)
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
index ab126f8706c7..53366dbfbf27 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
@@ -621,7 +621,7 @@ static int otx2vf_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	err = otx2vf_realloc_msix_vectors(vf);
 	if (err)
-		goto err_mbox_destroy;
+		goto err_detach_rsrc;
 
 	err = otx2_set_real_num_queues(netdev, qcount, qcount);
 	if (err)
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_devlink.c b/drivers/net/ethernet/pensando/ionic/ionic_devlink.c
index 4297ed9024c0..2696dac21b09 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_devlink.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_devlink.c
@@ -65,6 +65,8 @@ struct ionic *ionic_devlink_alloc(struct device *dev)
 	struct devlink *dl;
 
 	dl = devlink_alloc(&ionic_dl_ops, sizeof(struct ionic), dev);
+	if (!dl)
+		return NULL;
 
 	return devlink_priv(dl);
 }
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c b/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
index 01c22701482d..d7370fb60a16 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
@@ -691,7 +691,7 @@ static int ionic_get_rxnfc(struct net_device *netdev,
 		info->data = lif->nxqs;
 		break;
 	default:
-		netdev_err(netdev, "Command parameter %d is not supported\n",
+		netdev_dbg(netdev, "Command parameter %d is not supported\n",
 			   info->cmd);
 		err = -EOPNOTSUPP;
 	}
diff --git a/drivers/net/ethernet/sfc/mcdi_port_common.c b/drivers/net/ethernet/sfc/mcdi_port_common.c
index 899cc1671004..0ab14f3d01d4 100644
--- a/drivers/net/ethernet/sfc/mcdi_port_common.c
+++ b/drivers/net/ethernet/sfc/mcdi_port_common.c
@@ -972,12 +972,15 @@ static u32 efx_mcdi_phy_module_type(struct efx_nic *efx)
 
 	/* A QSFP+ NIC may actually have an SFP+ module attached.
 	 * The ID is page 0, byte 0.
+	 * QSFP28 is of type SFF_8636, however, this is treated
+	 * the same by ethtool, so we can also treat them the same.
 	 */
 	switch (efx_mcdi_phy_get_module_eeprom_byte(efx, 0, 0)) {
-	case 0x3:
+	case 0x3: /* SFP */
 		return MC_CMD_MEDIA_SFP_PLUS;
-	case 0xc:
-	case 0xd:
+	case 0xc: /* QSFP */
+	case 0xd: /* QSFP+ */
+	case 0x11: /* QSFP28 */
 		return MC_CMD_MEDIA_QSFP_PLUS;
 	default:
 		return 0;
@@ -1075,7 +1078,7 @@ int efx_mcdi_phy_get_module_info(struct efx_nic *efx, struct ethtool_modinfo *mo
 
 	case MC_CMD_MEDIA_QSFP_PLUS:
 		modinfo->type = ETH_MODULE_SFF_8436;
-		modinfo->eeprom_len = ETH_MODULE_SFF_8436_LEN;
+		modinfo->eeprom_len = ETH_MODULE_SFF_8436_MAX_LEN;
 		break;
 
 	default:
diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index 23da1d9dafd1..059d610901d8 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -199,6 +199,7 @@
 #define OCP_EEE_AR		0xa41a
 #define OCP_EEE_DATA		0xa41c
 #define OCP_PHY_STATUS		0xa420
+#define OCP_INTR_EN		0xa424
 #define OCP_NCTL_CFG		0xa42c
 #define OCP_POWER_CFG		0xa430
 #define OCP_EEE_CFG		0xa432
@@ -620,6 +621,9 @@ enum spd_duplex {
 #define PHY_STAT_LAN_ON		3
 #define PHY_STAT_PWRDN		5
 
+/* OCP_INTR_EN */
+#define INTR_SPEED_FORCE	BIT(3)
+
 /* OCP_NCTL_CFG */
 #define PGA_RETURN_EN		BIT(1)
 
@@ -3023,12 +3027,16 @@ static int rtl_enable(struct r8152 *tp)
 	ocp_write_byte(tp, MCU_TYPE_PLA, PLA_CR, ocp_data);
 
 	switch (tp->version) {
-	case RTL_VER_08:
-	case RTL_VER_09:
-	case RTL_VER_14:
-		r8153b_rx_agg_chg_indicate(tp);
+	case RTL_VER_01:
+	case RTL_VER_02:
+	case RTL_VER_03:
+	case RTL_VER_04:
+	case RTL_VER_05:
+	case RTL_VER_06:
+	case RTL_VER_07:
 		break;
 	default:
+		r8153b_rx_agg_chg_indicate(tp);
 		break;
 	}
 
@@ -3082,7 +3090,6 @@ static void r8153_set_rx_early_timeout(struct r8152 *tp)
 			       640 / 8);
 		ocp_write_word(tp, MCU_TYPE_USB, USB_RX_EXTRA_AGGR_TMR,
 			       ocp_data);
-		r8153b_rx_agg_chg_indicate(tp);
 		break;
 
 	default:
@@ -3116,7 +3123,6 @@ static void r8153_set_rx_early_size(struct r8152 *tp)
 	case RTL_VER_15:
 		ocp_write_word(tp, MCU_TYPE_USB, USB_RX_EARLY_SIZE,
 			       ocp_data / 8);
-		r8153b_rx_agg_chg_indicate(tp);
 		break;
 	default:
 		WARN_ON_ONCE(1);
@@ -5986,6 +5992,25 @@ static void rtl8153_disable(struct r8152 *tp)
 	r8153_aldps_en(tp, true);
 }
 
+static u32 fc_pause_on_auto(struct r8152 *tp)
+{
+	return (ALIGN(mtu_to_size(tp->netdev->mtu), 1024) + 6 * 1024);
+}
+
+static u32 fc_pause_off_auto(struct r8152 *tp)
+{
+	return (ALIGN(mtu_to_size(tp->netdev->mtu), 1024) + 14 * 1024);
+}
+
+static void r8156_fc_parameter(struct r8152 *tp)
+{
+	u32 pause_on = tp->fc_pause_on ? tp->fc_pause_on : fc_pause_on_auto(tp);
+	u32 pause_off = tp->fc_pause_off ? tp->fc_pause_off : fc_pause_off_auto(tp);
+
+	ocp_write_word(tp, MCU_TYPE_PLA, PLA_RX_FIFO_FULL, pause_on / 16);
+	ocp_write_word(tp, MCU_TYPE_PLA, PLA_RX_FIFO_EMPTY, pause_off / 16);
+}
+
 static int rtl8156_enable(struct r8152 *tp)
 {
 	u32 ocp_data;
@@ -5994,6 +6019,7 @@ static int rtl8156_enable(struct r8152 *tp)
 	if (test_bit(RTL8152_UNPLUG, &tp->flags))
 		return -ENODEV;
 
+	r8156_fc_parameter(tp);
 	set_tx_qlen(tp);
 	rtl_set_eee_plus(tp);
 	r8153_set_rx_early_timeout(tp);
@@ -6025,9 +6051,24 @@ static int rtl8156_enable(struct r8152 *tp)
 		ocp_write_word(tp, MCU_TYPE_USB, USB_L1_CTRL, ocp_data);
 	}
 
+	ocp_data = ocp_read_word(tp, MCU_TYPE_USB, USB_FW_TASK);
+	ocp_data &= ~FC_PATCH_TASK;
+	ocp_write_word(tp, MCU_TYPE_USB, USB_FW_TASK, ocp_data);
+	usleep_range(1000, 2000);
+	ocp_data |= FC_PATCH_TASK;
+	ocp_write_word(tp, MCU_TYPE_USB, USB_FW_TASK, ocp_data);
+
 	return rtl_enable(tp);
 }
 
+static void rtl8156_disable(struct r8152 *tp)
+{
+	ocp_write_word(tp, MCU_TYPE_PLA, PLA_RX_FIFO_FULL, 0);
+	ocp_write_word(tp, MCU_TYPE_PLA, PLA_RX_FIFO_EMPTY, 0);
+
+	rtl8153_disable(tp);
+}
+
 static int rtl8156b_enable(struct r8152 *tp)
 {
 	u32 ocp_data;
@@ -6429,25 +6470,6 @@ static void rtl8153c_up(struct r8152 *tp)
 	r8153b_u1u2en(tp, true);
 }
 
-static inline u32 fc_pause_on_auto(struct r8152 *tp)
-{
-	return (ALIGN(mtu_to_size(tp->netdev->mtu), 1024) + 6 * 1024);
-}
-
-static inline u32 fc_pause_off_auto(struct r8152 *tp)
-{
-	return (ALIGN(mtu_to_size(tp->netdev->mtu), 1024) + 14 * 1024);
-}
-
-static void r8156_fc_parameter(struct r8152 *tp)
-{
-	u32 pause_on = tp->fc_pause_on ? tp->fc_pause_on : fc_pause_on_auto(tp);
-	u32 pause_off = tp->fc_pause_off ? tp->fc_pause_off : fc_pause_off_auto(tp);
-
-	ocp_write_word(tp, MCU_TYPE_PLA, PLA_RX_FIFO_FULL, pause_on / 16);
-	ocp_write_word(tp, MCU_TYPE_PLA, PLA_RX_FIFO_EMPTY, pause_off / 16);
-}
-
 static void rtl8156_change_mtu(struct r8152 *tp)
 {
 	u32 rx_max_size = mtu_to_size(tp->netdev->mtu);
@@ -7538,6 +7560,11 @@ static void r8156_hw_phy_cfg(struct r8152 *tp)
 				      ((swap_a & 0x1f) << 8) |
 				      ((swap_a >> 8) & 0x1f));
 		}
+
+		/* Notify the MAC when the speed is changed to force mode. */
+		data = ocp_reg_read(tp, OCP_INTR_EN);
+		data |= INTR_SPEED_FORCE;
+		ocp_reg_write(tp, OCP_INTR_EN, data);
 		break;
 	default:
 		break;
@@ -7933,6 +7960,11 @@ static void r8156b_hw_phy_cfg(struct r8152 *tp)
 		break;
 	}
 
+	/* Notify the MAC when the speed is changed to force mode. */
+	data = ocp_reg_read(tp, OCP_INTR_EN);
+	data |= INTR_SPEED_FORCE;
+	ocp_reg_write(tp, OCP_INTR_EN, data);
+
 	if (rtl_phy_patch_request(tp, true, true))
 		return;
 
@@ -9377,7 +9409,7 @@ static int rtl_ops_init(struct r8152 *tp)
 	case RTL_VER_10:
 		ops->init		= r8156_init;
 		ops->enable		= rtl8156_enable;
-		ops->disable		= rtl8153_disable;
+		ops->disable		= rtl8156_disable;
 		ops->up			= rtl8156_up;
 		ops->down		= rtl8156_down;
 		ops->unload		= rtl8153_unload;
diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 3f1883814ce2..9a612b13b4e4 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -3405,12 +3405,14 @@ static void free_unused_bufs(struct virtnet_info *vi)
 		struct virtqueue *vq = vi->sq[i].vq;
 		while ((buf = virtqueue_detach_unused_buf(vq)) != NULL)
 			virtnet_sq_free_unused_buf(vq, buf);
+		cond_resched();
 	}
 
 	for (i = 0; i < vi->max_queue_pairs; i++) {
 		struct virtqueue *vq = vi->rq[i].vq;
 		while ((buf = virtqueue_detach_unused_buf(vq)) != NULL)
 			virtnet_rq_free_unused_buf(vq, buf);
+		cond_resched();
 	}
 }
 
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8821c.c b/drivers/net/wireless/realtek/rtw88/rtw8821c.c
index 9afdc5ce86b4..609a2b86330d 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8821c.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8821c.c
@@ -41,7 +41,7 @@ static int rtw8821c_read_efuse(struct rtw_dev *rtwdev, u8 *log_map)
 
 	map = (struct rtw8821c_efuse *)log_map;
 
-	efuse->rfe_option = map->rfe_option;
+	efuse->rfe_option = map->rfe_option & 0x1f;
 	efuse->rf_board_option = map->rf_board_option;
 	efuse->crystal_cap = map->xtal_k;
 	efuse->pa_type_2g = map->pa_type;
diff --git a/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-common.c b/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-common.c
index cb24de9e97dc..fa8f14c925ec 100644
--- a/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-common.c
+++ b/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-common.c
@@ -44,14 +44,18 @@ static ssize_t store_min_max_freq_khz(struct uncore_data *data,
 				      int min_max)
 {
 	unsigned int input;
+	int ret;
 
 	if (kstrtouint(buf, 10, &input))
 		return -EINVAL;
 
 	mutex_lock(&uncore_lock);
-	uncore_write(data, input, min_max);
+	ret = uncore_write(data, input, min_max);
 	mutex_unlock(&uncore_lock);
 
+	if (ret)
+		return ret;
+
 	return count;
 }
 
diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index d1ec31086e9b..5b2c8dd2861b 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -10322,6 +10322,7 @@ static atomic_t dytc_ignore_event = ATOMIC_INIT(0);
 static DEFINE_MUTEX(dytc_mutex);
 static int dytc_capabilities;
 static bool dytc_mmc_get_available;
+static int profile_force;
 
 static int convert_dytc_to_profile(int funcmode, int dytcmode,
 		enum platform_profile_option *profile)
@@ -10584,6 +10585,21 @@ static int tpacpi_dytc_profile_init(struct ibm_init_struct *iibm)
 	if (err)
 		return err;
 
+	/* Check if user wants to override the profile selection */
+	if (profile_force) {
+		switch (profile_force) {
+		case -1:
+			dytc_capabilities = 0;
+			break;
+		case 1:
+			dytc_capabilities = BIT(DYTC_FC_MMC);
+			break;
+		case 2:
+			dytc_capabilities = BIT(DYTC_FC_PSC);
+			break;
+		}
+		pr_debug("Profile selection forced: 0x%x\n", dytc_capabilities);
+	}
 	if (dytc_capabilities & BIT(DYTC_FC_MMC)) { /* MMC MODE */
 		pr_debug("MMC is supported\n");
 		/*
@@ -10597,11 +10613,6 @@ static int tpacpi_dytc_profile_init(struct ibm_init_struct *iibm)
 				dytc_mmc_get_available = true;
 		}
 	} else if (dytc_capabilities & BIT(DYTC_FC_PSC)) { /* PSC MODE */
-		/* Support for this only works on AMD platforms */
-		if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD) {
-			dbg_printk(TPACPI_DBG_INIT, "PSC not support on Intel platforms\n");
-			return -ENODEV;
-		}
 		pr_debug("PSC is supported\n");
 	} else {
 		dbg_printk(TPACPI_DBG_INIT, "No DYTC support available\n");
@@ -11650,6 +11661,9 @@ MODULE_PARM_DESC(uwb_state,
 		 "Initial state of the emulated UWB switch");
 #endif
 
+module_param(profile_force, int, 0444);
+MODULE_PARM_DESC(profile_force, "Force profile mode. -1=off, 1=MMC, 2=PSC");
+
 static void thinkpad_acpi_module_exit(void)
 {
 	struct ibm_struct *ibm, *itmp;
diff --git a/drivers/platform/x86/touchscreen_dmi.c b/drivers/platform/x86/touchscreen_dmi.c
index 13802a3c3591..68e66b60445c 100644
--- a/drivers/platform/x86/touchscreen_dmi.c
+++ b/drivers/platform/x86/touchscreen_dmi.c
@@ -336,6 +336,22 @@ static const struct ts_dmi_data dexp_ursus_7w_data = {
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
@@ -378,6 +394,11 @@ static const struct ts_dmi_data gdix1001_01_upside_down_data = {
 	.properties	= gdix1001_upside_down_props,
 };
 
+static const struct ts_dmi_data gdix1002_00_upside_down_data = {
+	.acpi_name	= "GDIX1002:00",
+	.properties	= gdix1001_upside_down_props,
+};
+
 static const struct property_entry gp_electronic_t701_props[] = {
 	PROPERTY_ENTRY_U32("touchscreen-size-x", 960),
 	PROPERTY_ENTRY_U32("touchscreen-size-y", 640),
@@ -1185,6 +1206,14 @@ const struct dmi_system_id touchscreen_dmi_table[] = {
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
@@ -1295,6 +1324,18 @@ const struct dmi_system_id touchscreen_dmi_table[] = {
 			DMI_MATCH(DMI_BIOS_VERSION, "jumperx.T87.KFBNEEA"),
 		},
 	},
+	{
+		/* Juno Tablet */
+		.driver_data = (void *)&gdix1002_00_upside_down_data,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Default string"),
+			/* Both product- and board-name being "Default string" is somewhat rare */
+			DMI_MATCH(DMI_PRODUCT_NAME, "Default string"),
+			DMI_MATCH(DMI_BOARD_NAME, "Default string"),
+			/* Above matches are too generic, add partial bios-version match */
+			DMI_MATCH(DMI_BIOS_VERSION, "JP2V1."),
+		},
+	},
 	{
 		/* Mediacom WinPad 7.0 W700 (same hw as Wintron surftab 7") */
 		.driver_data = (void *)&trekstor_surftab_wintron70_data,
diff --git a/drivers/remoteproc/imx_dsp_rproc.c b/drivers/remoteproc/imx_dsp_rproc.c
index 95da1cbefacf..506ec9565716 100644
--- a/drivers/remoteproc/imx_dsp_rproc.c
+++ b/drivers/remoteproc/imx_dsp_rproc.c
@@ -627,15 +627,19 @@ static int imx_dsp_rproc_add_carveout(struct imx_dsp_rproc *priv)
 
 		rmem = of_reserved_mem_lookup(it.node);
 		if (!rmem) {
+			of_node_put(it.node);
 			dev_err(dev, "unable to acquire memory-region\n");
 			return -EINVAL;
 		}
 
-		if (imx_dsp_rproc_sys_to_da(priv, rmem->base, rmem->size, &da))
+		if (imx_dsp_rproc_sys_to_da(priv, rmem->base, rmem->size, &da)) {
+			of_node_put(it.node);
 			return -EINVAL;
+		}
 
 		cpu_addr = devm_ioremap_wc(dev, rmem->base, rmem->size);
 		if (!cpu_addr) {
+			of_node_put(it.node);
 			dev_err(dev, "failed to map memory %p\n", &rmem->base);
 			return -ENOMEM;
 		}
@@ -644,10 +648,12 @@ static int imx_dsp_rproc_add_carveout(struct imx_dsp_rproc *priv)
 		mem = rproc_mem_entry_init(dev, (void __force *)cpu_addr, (dma_addr_t)rmem->base,
 					   rmem->size, da, NULL, NULL, it.node->name);
 
-		if (mem)
+		if (mem) {
 			rproc_coredump_add_segment(rproc, da, rmem->size);
-		else
+		} else {
+			of_node_put(it.node);
 			return -ENOMEM;
+		}
 
 		rproc_add_carveout(rproc, mem);
 	}
diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
index 596e1440cca5..8a2a7112678c 100644
--- a/drivers/remoteproc/imx_rproc.c
+++ b/drivers/remoteproc/imx_rproc.c
@@ -460,6 +460,7 @@ static int imx_rproc_prepare(struct rproc *rproc)
 
 		rmem = of_reserved_mem_lookup(it.node);
 		if (!rmem) {
+			of_node_put(it.node);
 			dev_err(priv->dev, "unable to acquire memory-region\n");
 			return -EINVAL;
 		}
@@ -472,10 +473,12 @@ static int imx_rproc_prepare(struct rproc *rproc)
 					   imx_rproc_mem_alloc, imx_rproc_mem_release,
 					   it.node->name);
 
-		if (mem)
+		if (mem) {
 			rproc_coredump_add_segment(rproc, da, rmem->size);
-		else
+		} else {
+			of_node_put(it.node);
 			return -ENOMEM;
+		}
 
 		rproc_add_carveout(rproc, mem);
 	}
diff --git a/drivers/remoteproc/rcar_rproc.c b/drivers/remoteproc/rcar_rproc.c
index aa86154109c7..1ff2a73ade90 100644
--- a/drivers/remoteproc/rcar_rproc.c
+++ b/drivers/remoteproc/rcar_rproc.c
@@ -62,13 +62,16 @@ static int rcar_rproc_prepare(struct rproc *rproc)
 
 		rmem = of_reserved_mem_lookup(it.node);
 		if (!rmem) {
+			of_node_put(it.node);
 			dev_err(&rproc->dev,
 				"unable to acquire memory-region\n");
 			return -EINVAL;
 		}
 
-		if (rmem->base > U32_MAX)
+		if (rmem->base > U32_MAX) {
+			of_node_put(it.node);
 			return -EINVAL;
+		}
 
 		/* No need to translate pa to da, R-Car use same map */
 		da = rmem->base;
@@ -79,8 +82,10 @@ static int rcar_rproc_prepare(struct rproc *rproc)
 					   rcar_rproc_mem_release,
 					   it.node->name);
 
-		if (!mem)
+		if (!mem) {
+			of_node_put(it.node);
 			return -ENOMEM;
+		}
 
 		rproc_add_carveout(rproc, mem);
 	}
diff --git a/drivers/remoteproc/st_remoteproc.c b/drivers/remoteproc/st_remoteproc.c
index a3268d95a50e..e6bd3c7a950a 100644
--- a/drivers/remoteproc/st_remoteproc.c
+++ b/drivers/remoteproc/st_remoteproc.c
@@ -129,6 +129,7 @@ static int st_rproc_parse_fw(struct rproc *rproc, const struct firmware *fw)
 	while (of_phandle_iterator_next(&it) == 0) {
 		rmem = of_reserved_mem_lookup(it.node);
 		if (!rmem) {
+			of_node_put(it.node);
 			dev_err(dev, "unable to acquire memory-region\n");
 			return -EINVAL;
 		}
@@ -150,8 +151,10 @@ static int st_rproc_parse_fw(struct rproc *rproc, const struct firmware *fw)
 							   it.node->name);
 		}
 
-		if (!mem)
+		if (!mem) {
+			of_node_put(it.node);
 			return -ENOMEM;
+		}
 
 		rproc_add_carveout(rproc, mem);
 		index++;
diff --git a/drivers/remoteproc/stm32_rproc.c b/drivers/remoteproc/stm32_rproc.c
index 7d782ed9e589..23c1690b8d73 100644
--- a/drivers/remoteproc/stm32_rproc.c
+++ b/drivers/remoteproc/stm32_rproc.c
@@ -223,11 +223,13 @@ static int stm32_rproc_prepare(struct rproc *rproc)
 	while (of_phandle_iterator_next(&it) == 0) {
 		rmem = of_reserved_mem_lookup(it.node);
 		if (!rmem) {
+			of_node_put(it.node);
 			dev_err(dev, "unable to acquire memory-region\n");
 			return -EINVAL;
 		}
 
 		if (stm32_rproc_pa_to_da(rproc, rmem->base, &da) < 0) {
+			of_node_put(it.node);
 			dev_err(dev, "memory region not valid %pa\n",
 				&rmem->base);
 			return -EINVAL;
@@ -254,8 +256,10 @@ static int stm32_rproc_prepare(struct rproc *rproc)
 							   it.node->name);
 		}
 
-		if (!mem)
+		if (!mem) {
+			of_node_put(it.node);
 			return -ENOMEM;
+		}
 
 		rproc_add_carveout(rproc, mem);
 		index++;
diff --git a/drivers/scsi/qedi/qedi_main.c b/drivers/scsi/qedi/qedi_main.c
index df2fe7bd26d1..f530bb036493 100644
--- a/drivers/scsi/qedi/qedi_main.c
+++ b/drivers/scsi/qedi/qedi_main.c
@@ -2450,6 +2450,9 @@ static void __qedi_remove(struct pci_dev *pdev, int mode)
 		qedi_ops->ll2->stop(qedi->cdev);
 	}
 
+	cancel_delayed_work_sync(&qedi->recovery_work);
+	cancel_delayed_work_sync(&qedi->board_disable_work);
+
 	qedi_free_iscsi_pf_param(qedi);
 
 	rval = qedi_ops->common->update_drv_state(qedi->cdev, false);
diff --git a/drivers/soc/qcom/llcc-qcom.c b/drivers/soc/qcom/llcc-qcom.c
index 9c6cf2f5d77c..d4cba3b3c56c 100644
--- a/drivers/soc/qcom/llcc-qcom.c
+++ b/drivers/soc/qcom/llcc-qcom.c
@@ -101,10 +101,11 @@ struct llcc_slice_config {
 
 struct qcom_llcc_config {
 	const struct llcc_slice_config *sct_data;
-	int size;
-	bool need_llcc_cfg;
 	const u32 *reg_offset;
 	const struct llcc_edac_reg_offset *edac_reg_offset;
+	int size;
+	bool need_llcc_cfg;
+	bool no_edac;
 };
 
 enum llcc_reg_offset {
@@ -401,6 +402,7 @@ static const struct qcom_llcc_config sdm845_cfg = {
 	.need_llcc_cfg	= false,
 	.reg_offset	= llcc_v1_reg_offset,
 	.edac_reg_offset = &llcc_v1_edac_reg_offset,
+	.no_edac	= true,
 };
 
 static const struct qcom_llcc_config sm6350_cfg = {
@@ -850,7 +852,14 @@ static int qcom_llcc_probe(struct platform_device *pdev)
 		goto err;
 
 	drv_data->ecc_irq = platform_get_irq_optional(pdev, 0);
-	if (drv_data->ecc_irq >= 0) {
+
+	/*
+	 * On some platforms, the access to EDAC registers will be locked by
+	 * the bootloader. So probing the EDAC driver will result in a crash.
+	 * Hence, disable the creation of EDAC platform device for the
+	 * problematic platforms.
+	 */
+	if (!cfg->no_edac) {
 		llcc_edac = platform_device_register_data(&pdev->dev,
 						"qcom_llcc_edac", -1, drv_data,
 						sizeof(*drv_data));
diff --git a/drivers/spi/spi-fsl-cpm.c b/drivers/spi/spi-fsl-cpm.c
index ee905880769e..7832ce330b29 100644
--- a/drivers/spi/spi-fsl-cpm.c
+++ b/drivers/spi/spi-fsl-cpm.c
@@ -21,6 +21,7 @@
 #include <linux/spi/spi.h>
 #include <linux/types.h>
 #include <linux/platform_device.h>
+#include <linux/byteorder/generic.h>
 
 #include "spi-fsl-cpm.h"
 #include "spi-fsl-lib.h"
@@ -120,6 +121,21 @@ int fsl_spi_cpm_bufs(struct mpc8xxx_spi *mspi,
 		mspi->rx_dma = mspi->dma_dummy_rx;
 		mspi->map_rx_dma = 0;
 	}
+	if (t->bits_per_word == 16 && t->tx_buf) {
+		const u16 *src = t->tx_buf;
+		u16 *dst;
+		int i;
+
+		dst = kmalloc(t->len, GFP_KERNEL);
+		if (!dst)
+			return -ENOMEM;
+
+		for (i = 0; i < t->len >> 1; i++)
+			dst[i] = cpu_to_le16p(src + i);
+
+		mspi->tx = dst;
+		mspi->map_tx_dma = 1;
+	}
 
 	if (mspi->map_tx_dma) {
 		void *nonconst_tx = (void *)mspi->tx; /* shut up gcc */
@@ -173,6 +189,13 @@ void fsl_spi_cpm_bufs_complete(struct mpc8xxx_spi *mspi)
 	if (mspi->map_rx_dma)
 		dma_unmap_single(dev, mspi->rx_dma, t->len, DMA_FROM_DEVICE);
 	mspi->xfer_in_progress = NULL;
+
+	if (t->bits_per_word == 16 && t->rx_buf) {
+		int i;
+
+		for (i = 0; i < t->len; i += 2)
+			le16_to_cpus(t->rx_buf + i);
+	}
 }
 EXPORT_SYMBOL_GPL(fsl_spi_cpm_bufs_complete);
 
diff --git a/drivers/spi/spi-fsl-spi.c b/drivers/spi/spi-fsl-spi.c
index 5602f052b2b5..b14f430a699d 100644
--- a/drivers/spi/spi-fsl-spi.c
+++ b/drivers/spi/spi-fsl-spi.c
@@ -177,26 +177,6 @@ static int mspi_apply_cpu_mode_quirks(struct spi_mpc8xxx_cs *cs,
 	return bits_per_word;
 }
 
-static int mspi_apply_qe_mode_quirks(struct spi_mpc8xxx_cs *cs,
-				struct spi_device *spi,
-				int bits_per_word)
-{
-	/* CPM/QE uses Little Endian for words > 8
-	 * so transform 16 and 32 bits words into 8 bits
-	 * Unfortnatly that doesn't work for LSB so
-	 * reject these for now */
-	/* Note: 32 bits word, LSB works iff
-	 * tfcr/rfcr is set to CPMFCR_GBL */
-	if (spi->mode & SPI_LSB_FIRST &&
-	    bits_per_word > 8)
-		return -EINVAL;
-	if (bits_per_word <= 8)
-		return bits_per_word;
-	if (bits_per_word == 16 || bits_per_word == 32)
-		return 8; /* pretend its 8 bits */
-	return -EINVAL;
-}
-
 static int fsl_spi_setup_transfer(struct spi_device *spi,
 					struct spi_transfer *t)
 {
@@ -224,9 +204,6 @@ static int fsl_spi_setup_transfer(struct spi_device *spi,
 		bits_per_word = mspi_apply_cpu_mode_quirks(cs, spi,
 							   mpc8xxx_spi,
 							   bits_per_word);
-	else
-		bits_per_word = mspi_apply_qe_mode_quirks(cs, spi,
-							  bits_per_word);
 
 	if (bits_per_word < 0)
 		return bits_per_word;
@@ -361,6 +338,22 @@ static int fsl_spi_prepare_message(struct spi_controller *ctlr,
 				t->bits_per_word = 32;
 			else if ((t->len & 1) == 0)
 				t->bits_per_word = 16;
+		} else {
+			/*
+			 * CPM/QE uses Little Endian for words > 8
+			 * so transform 16 and 32 bits words into 8 bits
+			 * Unfortnatly that doesn't work for LSB so
+			 * reject these for now
+			 * Note: 32 bits word, LSB works iff
+			 * tfcr/rfcr is set to CPMFCR_GBL
+			 */
+			if (m->spi->mode & SPI_LSB_FIRST && t->bits_per_word > 8)
+				return -EINVAL;
+			if (t->bits_per_word == 16 || t->bits_per_word == 32)
+				t->bits_per_word = 8; /* pretend its 8 bits */
+			if (t->bits_per_word == 8 && t->len >= 256 &&
+			    (mpc8xxx_spi->flags & SPI_CPM1))
+				t->bits_per_word = 16;
 		}
 	}
 	return fsl_spi_setup_transfer(m->spi, first);
@@ -594,8 +587,14 @@ static struct spi_master *fsl_spi_probe(struct device *dev,
 	if (mpc8xxx_spi->type == TYPE_GRLIB)
 		fsl_spi_grlib_probe(dev);
 
-	master->bits_per_word_mask =
-		(SPI_BPW_RANGE_MASK(4, 16) | SPI_BPW_MASK(32)) &
+	if (mpc8xxx_spi->flags & SPI_CPM_MODE)
+		master->bits_per_word_mask =
+			(SPI_BPW_RANGE_MASK(4, 8) | SPI_BPW_MASK(16) | SPI_BPW_MASK(32));
+	else
+		master->bits_per_word_mask =
+			(SPI_BPW_RANGE_MASK(4, 16) | SPI_BPW_MASK(32));
+
+	master->bits_per_word_mask &=
 		SPI_BPW_RANGE_MASK(1, mpc8xxx_spi->max_bits_per_word);
 
 	if (mpc8xxx_spi->flags & SPI_QE_CPU_MODE)
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index d2622378ce04..daa767383355 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -2468,7 +2468,7 @@ static void __dwc3_gadget_set_speed(struct dwc3 *dwc)
 	dwc3_writel(dwc->regs, DWC3_DCFG, reg);
 }
 
-static int dwc3_gadget_run_stop(struct dwc3 *dwc, int is_on, int suspend)
+static int dwc3_gadget_run_stop(struct dwc3 *dwc, int is_on)
 {
 	u32			reg;
 	u32			timeout = 2000;
@@ -2487,17 +2487,11 @@ static int dwc3_gadget_run_stop(struct dwc3 *dwc, int is_on, int suspend)
 			reg &= ~DWC3_DCTL_KEEP_CONNECT;
 		reg |= DWC3_DCTL_RUN_STOP;
 
-		if (dwc->has_hibernation)
-			reg |= DWC3_DCTL_KEEP_CONNECT;
-
 		__dwc3_gadget_set_speed(dwc);
 		dwc->pullups_connected = true;
 	} else {
 		reg &= ~DWC3_DCTL_RUN_STOP;
 
-		if (dwc->has_hibernation && !suspend)
-			reg &= ~DWC3_DCTL_KEEP_CONNECT;
-
 		dwc->pullups_connected = false;
 	}
 
@@ -2542,7 +2536,6 @@ static int dwc3_gadget_soft_disconnect(struct dwc3 *dwc)
 	 * bit.
 	 */
 	dwc3_stop_active_transfers(dwc);
-	__dwc3_gadget_stop(dwc);
 	spin_unlock_irqrestore(&dwc->lock, flags);
 
 	/*
@@ -2579,7 +2572,19 @@ static int dwc3_gadget_soft_disconnect(struct dwc3 *dwc)
 	 * remaining event generated by the controller while polling for
 	 * DSTS.DEVCTLHLT.
 	 */
-	return dwc3_gadget_run_stop(dwc, false, false);
+	ret = dwc3_gadget_run_stop(dwc, false);
+
+	/*
+	 * Stop the gadget after controller is halted, so that if needed, the
+	 * events to update EP0 state can still occur while the run/stop
+	 * routine polls for the halted state.  DEVTEN is cleared as part of
+	 * gadget stop.
+	 */
+	spin_lock_irqsave(&dwc->lock, flags);
+	__dwc3_gadget_stop(dwc);
+	spin_unlock_irqrestore(&dwc->lock, flags);
+
+	return ret;
 }
 
 static int dwc3_gadget_pullup(struct usb_gadget *g, int is_on)
@@ -2633,7 +2638,7 @@ static int dwc3_gadget_pullup(struct usb_gadget *g, int is_on)
 
 		dwc3_event_buffers_setup(dwc);
 		__dwc3_gadget_start(dwc);
-		ret = dwc3_gadget_run_stop(dwc, true, false);
+		ret = dwc3_gadget_run_stop(dwc, true);
 	}
 
 	pm_runtime_put(dwc->dev);
@@ -4200,30 +4205,6 @@ static void dwc3_gadget_suspend_interrupt(struct dwc3 *dwc,
 	dwc->link_state = next;
 }
 
-static void dwc3_gadget_hibernation_interrupt(struct dwc3 *dwc,
-		unsigned int evtinfo)
-{
-	unsigned int is_ss = evtinfo & BIT(4);
-
-	/*
-	 * WORKAROUND: DWC3 revision 2.20a with hibernation support
-	 * have a known issue which can cause USB CV TD.9.23 to fail
-	 * randomly.
-	 *
-	 * Because of this issue, core could generate bogus hibernation
-	 * events which SW needs to ignore.
-	 *
-	 * Refers to:
-	 *
-	 * STAR#9000546576: Device Mode Hibernation: Issue in USB 2.0
-	 * Device Fallback from SuperSpeed
-	 */
-	if (is_ss ^ (dwc->speed == USB_SPEED_SUPER))
-		return;
-
-	/* enter hibernation here */
-}
-
 static void dwc3_gadget_interrupt(struct dwc3 *dwc,
 		const struct dwc3_event_devt *event)
 {
@@ -4241,11 +4222,7 @@ static void dwc3_gadget_interrupt(struct dwc3 *dwc,
 		dwc3_gadget_wakeup_interrupt(dwc);
 		break;
 	case DWC3_DEVICE_EVENT_HIBER_REQ:
-		if (dev_WARN_ONCE(dwc->dev, !dwc->has_hibernation,
-					"unexpected hibernation event\n"))
-			break;
-
-		dwc3_gadget_hibernation_interrupt(dwc, event->event_info);
+		dev_WARN_ONCE(dwc->dev, true, "unexpected hibernation event\n");
 		break;
 	case DWC3_DEVICE_EVENT_LINK_STATUS_CHANGE:
 		dwc3_gadget_linksts_change_interrupt(dwc, event->event_info);
@@ -4582,7 +4559,7 @@ int dwc3_gadget_suspend(struct dwc3 *dwc)
 	if (!dwc->gadget_driver)
 		return 0;
 
-	dwc3_gadget_run_stop(dwc, false, false);
+	dwc3_gadget_run_stop(dwc, false);
 
 	spin_lock_irqsave(&dwc->lock, flags);
 	dwc3_disconnect_gadget(dwc);
@@ -4603,7 +4580,7 @@ int dwc3_gadget_resume(struct dwc3 *dwc)
 	if (ret < 0)
 		goto err0;
 
-	ret = dwc3_gadget_run_stop(dwc, true, false);
+	ret = dwc3_gadget_run_stop(dwc, true);
 	if (ret < 0)
 		goto err1;
 
diff --git a/drivers/watchdog/dw_wdt.c b/drivers/watchdog/dw_wdt.c
index 52962e8d11a6..61af5d1332ac 100644
--- a/drivers/watchdog/dw_wdt.c
+++ b/drivers/watchdog/dw_wdt.c
@@ -635,7 +635,7 @@ static int dw_wdt_drv_probe(struct platform_device *pdev)
 
 	ret = dw_wdt_init_timeouts(dw_wdt, dev);
 	if (ret)
-		goto out_disable_clk;
+		goto out_assert_rst;
 
 	wdd = &dw_wdt->wdd;
 	wdd->ops = &dw_wdt_ops;
@@ -666,12 +666,15 @@ static int dw_wdt_drv_probe(struct platform_device *pdev)
 
 	ret = watchdog_register_device(wdd);
 	if (ret)
-		goto out_disable_pclk;
+		goto out_assert_rst;
 
 	dw_wdt_dbgfs_init(dw_wdt);
 
 	return 0;
 
+out_assert_rst:
+	reset_control_assert(dw_wdt->rst);
+
 out_disable_pclk:
 	clk_disable_unprepare(dw_wdt->pclk);
 
diff --git a/fs/btrfs/block-rsv.c b/fs/btrfs/block-rsv.c
index ec96285357e0..2044f1e18629 100644
--- a/fs/btrfs/block-rsv.c
+++ b/fs/btrfs/block-rsv.c
@@ -122,7 +122,8 @@ static u64 block_rsv_release_bytes(struct btrfs_fs_info *fs_info,
 	} else {
 		num_bytes = 0;
 	}
-	if (block_rsv->qgroup_rsv_reserved >= block_rsv->qgroup_rsv_size) {
+	if (qgroup_to_release_ret &&
+	    block_rsv->qgroup_rsv_reserved >= block_rsv->qgroup_rsv_size) {
 		qgroup_to_release = block_rsv->qgroup_rsv_reserved -
 				    block_rsv->qgroup_rsv_size;
 		block_rsv->qgroup_rsv_reserved = block_rsv->qgroup_rsv_size;
diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index dcb510f38dda..dbbae92ac23d 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -4411,10 +4411,12 @@ int btrfs_del_items(struct btrfs_trans_handle *trans, struct btrfs_root *root,
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
@@ -4431,8 +4433,36 @@ int btrfs_prev_leaf(struct btrfs_root *root, struct btrfs_path *path)
 
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
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 5b1b5e1a63c8..acae82a5f8ee 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3215,23 +3215,34 @@ int btrfs_start_pre_rw_mount(struct btrfs_fs_info *fs_info)
 {
 	int ret;
 	const bool cache_opt = btrfs_test_opt(fs_info, SPACE_CACHE);
-	bool clear_free_space_tree = false;
+	bool rebuild_free_space_tree = false;
 
 	if (btrfs_test_opt(fs_info, CLEAR_CACHE) &&
 	    btrfs_fs_compat_ro(fs_info, FREE_SPACE_TREE)) {
-		clear_free_space_tree = true;
+		rebuild_free_space_tree = true;
 	} else if (btrfs_fs_compat_ro(fs_info, FREE_SPACE_TREE) &&
 		   !btrfs_fs_compat_ro(fs_info, FREE_SPACE_TREE_VALID)) {
 		btrfs_warn(fs_info, "free space tree is invalid");
-		clear_free_space_tree = true;
+		rebuild_free_space_tree = true;
 	}
 
-	if (clear_free_space_tree) {
-		btrfs_info(fs_info, "clearing free space tree");
-		ret = btrfs_clear_free_space_tree(fs_info);
+	if (rebuild_free_space_tree) {
+		btrfs_info(fs_info, "rebuilding free space tree");
+		ret = btrfs_rebuild_free_space_tree(fs_info);
 		if (ret) {
 			btrfs_warn(fs_info,
-				   "failed to clear free space tree: %d", ret);
+				   "failed to rebuild free space tree: %d", ret);
+			goto out;
+		}
+	}
+
+	if (btrfs_fs_compat_ro(fs_info, FREE_SPACE_TREE) &&
+	    !btrfs_test_opt(fs_info, FREE_SPACE_TREE)) {
+		btrfs_info(fs_info, "disabling free space tree");
+		ret = btrfs_delete_free_space_tree(fs_info);
+		if (ret) {
+			btrfs_warn(fs_info,
+				   "failed to disable free space tree: %d", ret);
 			goto out;
 		}
 	}
diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index 6bb9fa961a6a..4fab7da63259 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -47,13 +47,13 @@ void btrfs_inode_safe_disk_i_size_write(struct btrfs_inode *inode, u64 new_i_siz
 	u64 start, end, i_size;
 	int ret;
 
+	spin_lock(&inode->lock);
 	i_size = new_i_size ?: i_size_read(&inode->vfs_inode);
 	if (btrfs_fs_incompat(fs_info, NO_HOLES)) {
 		inode->disk_i_size = i_size;
-		return;
+		goto out_unlock;
 	}
 
-	spin_lock(&inode->lock);
 	ret = find_contiguous_extent_bit(&inode->file_extent_tree, 0, &start,
 					 &end, EXTENT_DIRTY);
 	if (!ret && start == 0)
@@ -61,6 +61,7 @@ void btrfs_inode_safe_disk_i_size_write(struct btrfs_inode *inode, u64 new_i_siz
 	else
 		i_size = 0;
 	inode->disk_i_size = i_size;
+out_unlock:
 	spin_unlock(&inode->lock);
 }
 
diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index 6a8f2bd350f4..4cd8e44cba4c 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -861,15 +861,16 @@ static int __load_free_space_cache(struct btrfs_root *root, struct inode *inode,
 			}
 			spin_lock(&ctl->tree_lock);
 			ret = link_free_space(ctl, e);
-			ctl->total_bitmaps++;
-			recalculate_thresholds(ctl);
-			spin_unlock(&ctl->tree_lock);
 			if (ret) {
+				spin_unlock(&ctl->tree_lock);
 				btrfs_err(fs_info,
 					"Duplicate entries in free space cache, dumping");
 				kmem_cache_free(btrfs_free_space_cachep, e);
 				goto free_cache;
 			}
+			ctl->total_bitmaps++;
+			recalculate_thresholds(ctl);
+			spin_unlock(&ctl->tree_lock);
 			list_add_tail(&e->list, &bitmaps);
 		}
 
diff --git a/fs/btrfs/free-space-tree.c b/fs/btrfs/free-space-tree.c
index 367bcfcf68f5..e040eea3937d 100644
--- a/fs/btrfs/free-space-tree.c
+++ b/fs/btrfs/free-space-tree.c
@@ -1247,7 +1247,7 @@ static int clear_free_space_tree(struct btrfs_trans_handle *trans,
 	return ret;
 }
 
-int btrfs_clear_free_space_tree(struct btrfs_fs_info *fs_info)
+int btrfs_delete_free_space_tree(struct btrfs_fs_info *fs_info)
 {
 	struct btrfs_trans_handle *trans;
 	struct btrfs_root *tree_root = fs_info->tree_root;
@@ -1293,6 +1293,54 @@ int btrfs_clear_free_space_tree(struct btrfs_fs_info *fs_info)
 	return ret;
 }
 
+int btrfs_rebuild_free_space_tree(struct btrfs_fs_info *fs_info)
+{
+	struct btrfs_trans_handle *trans;
+	struct btrfs_key key = {
+		.objectid = BTRFS_FREE_SPACE_TREE_OBJECTID,
+		.type = BTRFS_ROOT_ITEM_KEY,
+		.offset = 0,
+	};
+	struct btrfs_root *free_space_root = btrfs_global_root(fs_info, &key);
+	struct rb_node *node;
+	int ret;
+
+	trans = btrfs_start_transaction(free_space_root, 1);
+	if (IS_ERR(trans))
+		return PTR_ERR(trans);
+
+	set_bit(BTRFS_FS_CREATING_FREE_SPACE_TREE, &fs_info->flags);
+	set_bit(BTRFS_FS_FREE_SPACE_TREE_UNTRUSTED, &fs_info->flags);
+
+	ret = clear_free_space_tree(trans, free_space_root);
+	if (ret)
+		goto abort;
+
+	node = rb_first_cached(&fs_info->block_group_cache_tree);
+	while (node) {
+		struct btrfs_block_group *block_group;
+
+		block_group = rb_entry(node, struct btrfs_block_group,
+				       cache_node);
+		ret = populate_free_space_tree(trans, block_group);
+		if (ret)
+			goto abort;
+		node = rb_next(node);
+	}
+
+	btrfs_set_fs_compat_ro(fs_info, FREE_SPACE_TREE);
+	btrfs_set_fs_compat_ro(fs_info, FREE_SPACE_TREE_VALID);
+	clear_bit(BTRFS_FS_CREATING_FREE_SPACE_TREE, &fs_info->flags);
+
+	ret = btrfs_commit_transaction(trans);
+	clear_bit(BTRFS_FS_FREE_SPACE_TREE_UNTRUSTED, &fs_info->flags);
+	return ret;
+abort:
+	btrfs_abort_transaction(trans, ret);
+	btrfs_end_transaction(trans);
+	return ret;
+}
+
 static int __add_block_group_free_space(struct btrfs_trans_handle *trans,
 					struct btrfs_block_group *block_group,
 					struct btrfs_path *path)
diff --git a/fs/btrfs/free-space-tree.h b/fs/btrfs/free-space-tree.h
index dc2463e4cfe3..6d5551d0ced8 100644
--- a/fs/btrfs/free-space-tree.h
+++ b/fs/btrfs/free-space-tree.h
@@ -18,7 +18,8 @@ struct btrfs_caching_control;
 
 void set_free_space_tree_thresholds(struct btrfs_block_group *block_group);
 int btrfs_create_free_space_tree(struct btrfs_fs_info *fs_info);
-int btrfs_clear_free_space_tree(struct btrfs_fs_info *fs_info);
+int btrfs_delete_free_space_tree(struct btrfs_fs_info *fs_info);
+int btrfs_rebuild_free_space_tree(struct btrfs_fs_info *fs_info);
 int load_free_space_tree(struct btrfs_caching_control *caching_ctl);
 int add_block_group_free_space(struct btrfs_trans_handle *trans,
 			       struct btrfs_block_group *block_group);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 0e516aefbf51..56e9efbffd58 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3237,6 +3237,9 @@ int btrfs_finish_ordered_io(struct btrfs_ordered_extent *ordered_extent)
 		btrfs_rewrite_logical_zoned(ordered_extent);
 		btrfs_zone_finish_endio(fs_info, ordered_extent->disk_bytenr,
 					ordered_extent->disk_num_bytes);
+	} else if (btrfs_is_data_reloc_root(inode->root)) {
+		btrfs_zone_finish_endio(fs_info, ordered_extent->disk_bytenr,
+					ordered_extent->disk_num_bytes);
 	}
 
 	btrfs_free_io_failure_record(inode, start, end);
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 0cebc203c4cc..9de647e48e7e 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -443,7 +443,9 @@ void btrfs_exclop_balance(struct btrfs_fs_info *fs_info,
 	case BTRFS_EXCLOP_BALANCE_PAUSED:
 		spin_lock(&fs_info->super_lock);
 		ASSERT(fs_info->exclusive_operation == BTRFS_EXCLOP_BALANCE ||
-		       fs_info->exclusive_operation == BTRFS_EXCLOP_DEV_ADD);
+		       fs_info->exclusive_operation == BTRFS_EXCLOP_DEV_ADD ||
+		       fs_info->exclusive_operation == BTRFS_EXCLOP_NONE ||
+		       fs_info->exclusive_operation == BTRFS_EXCLOP_BALANCE_PAUSED);
 		fs_info->exclusive_operation = BTRFS_EXCLOP_BALANCE_PAUSED;
 		spin_unlock(&fs_info->super_lock);
 		break;
diff --git a/fs/btrfs/print-tree.c b/fs/btrfs/print-tree.c
index dd8777872143..228eeb04d03d 100644
--- a/fs/btrfs/print-tree.c
+++ b/fs/btrfs/print-tree.c
@@ -148,10 +148,10 @@ static void print_extent_item(struct extent_buffer *eb, int slot, int type)
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
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index e43b16199e22..6438300fa246 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -1136,7 +1136,11 @@ int btrfs_parse_options(struct btrfs_fs_info *info, char *options,
 	    !btrfs_test_opt(info, CLEAR_CACHE)) {
 		btrfs_err(info, "cannot disable free space tree");
 		ret = -EINVAL;
-
+	}
+	if (btrfs_fs_compat_ro(info, BLOCK_GROUP_TREE) &&
+	     !btrfs_test_opt(info, FREE_SPACE_TREE)) {
+		btrfs_err(info, "cannot disable free space tree with block-group-tree feature");
+		ret = -EINVAL;
 	}
 	if (!ret)
 		ret = btrfs_check_mountopts_zoned(info);
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index e97c5a1ac95d..836babd23db5 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -119,10 +119,9 @@ static int sb_write_pointer(struct block_device *bdev, struct blk_zone *zones,
 		int i;
 
 		for (i = 0; i < BTRFS_NR_SB_LOG_ZONES; i++) {
-			u64 bytenr;
-
-			bytenr = ((zones[i].start + zones[i].len)
-				   << SECTOR_SHIFT) - BTRFS_SUPER_INFO_SIZE;
+			u64 zone_end = (zones[i].start + zones[i].capacity) << SECTOR_SHIFT;
+			u64 bytenr = ALIGN_DOWN(zone_end, BTRFS_SUPER_INFO_SIZE) -
+						BTRFS_SUPER_INFO_SIZE;
 
 			page[i] = read_cache_page_gfp(mapping,
 					bytenr >> PAGE_SHIFT, GFP_NOFS);
@@ -1163,12 +1162,12 @@ int btrfs_ensure_empty_zones(struct btrfs_device *device, u64 start, u64 size)
 		return -ERANGE;
 
 	/* All the zones are conventional */
-	if (find_next_bit(zinfo->seq_zones, begin, end) == end)
+	if (find_next_bit(zinfo->seq_zones, end, begin) == end)
 		return 0;
 
 	/* All the zones are sequential and empty */
-	if (find_next_zero_bit(zinfo->seq_zones, begin, end) == end &&
-	    find_next_zero_bit(zinfo->empty_zones, begin, end) == end)
+	if (find_next_zero_bit(zinfo->seq_zones, end, begin) == end &&
+	    find_next_zero_bit(zinfo->empty_zones, end, begin) == end)
 		return 0;
 
 	for (pos = start; pos < start + size; pos += zinfo->zone_size) {
@@ -1605,11 +1604,11 @@ void btrfs_redirty_list_add(struct btrfs_transaction *trans,
 	    !list_empty(&eb->release_list))
 		return;
 
+	memzero_extent_buffer(eb, 0, eb->len);
+	set_bit(EXTENT_BUFFER_NO_CHECK, &eb->bflags);
 	set_extent_buffer_dirty(eb);
 	set_extent_bits_nowait(&trans->dirty_pages, eb->start,
 			       eb->start + eb->len - 1, EXTENT_DIRTY);
-	memzero_extent_buffer(eb, 0, eb->len);
-	set_bit(EXTENT_BUFFER_NO_CHECK, &eb->bflags);
 
 	spin_lock(&trans->releasing_ebs_lock);
 	list_add_tail(&eb->release_list, &trans->releasing_ebs);
diff --git a/fs/cifs/cifsfs.c b/fs/cifs/cifsfs.c
index 03e3e95cf25b..078df1e2dd18 100644
--- a/fs/cifs/cifsfs.c
+++ b/fs/cifs/cifsfs.c
@@ -743,6 +743,7 @@ static void cifs_umount_begin(struct super_block *sb)
 	spin_unlock(&tcon->tc_lock);
 	spin_unlock(&cifs_tcp_ses_lock);
 
+	cifs_close_all_deferred_files(tcon);
 	/* cancel_brl_requests(tcon); */ /* BB mark all brl mids as exiting */
 	/* cancel_notify_requests(tcon); */
 	if (tcon->ses && tcon->ses->server) {
@@ -758,6 +759,20 @@ static void cifs_umount_begin(struct super_block *sb)
 	return;
 }
 
+static int cifs_freeze(struct super_block *sb)
+{
+	struct cifs_sb_info *cifs_sb = CIFS_SB(sb);
+	struct cifs_tcon *tcon;
+
+	if (cifs_sb == NULL)
+		return 0;
+
+	tcon = cifs_sb_master_tcon(cifs_sb);
+
+	cifs_close_all_deferred_files(tcon);
+	return 0;
+}
+
 #ifdef CONFIG_CIFS_STATS2
 static int cifs_show_stats(struct seq_file *s, struct dentry *root)
 {
@@ -796,6 +811,7 @@ static const struct super_operations cifs_super_ops = {
 	as opens */
 	.show_options = cifs_show_options,
 	.umount_begin   = cifs_umount_begin,
+	.freeze_fs      = cifs_freeze,
 #ifdef CONFIG_CIFS_STATS2
 	.show_stats = cifs_show_stats,
 #endif
diff --git a/fs/cifs/connect.c b/fs/cifs/connect.c
index 21b31d1640e5..935fe198a4ba 100644
--- a/fs/cifs/connect.c
+++ b/fs/cifs/connect.c
@@ -2742,6 +2742,13 @@ cifs_match_super(struct super_block *sb, void *data)
 
 	spin_lock(&cifs_tcp_ses_lock);
 	cifs_sb = CIFS_SB(sb);
+
+	/* We do not want to use a superblock that has been shutdown */
+	if (CIFS_MOUNT_SHUTDOWN & cifs_sb->mnt_cifs_flags) {
+		spin_unlock(&cifs_tcp_ses_lock);
+		return 0;
+	}
+
 	tlink = cifs_get_tlink(cifs_sb_master_tlink(cifs_sb));
 	if (tlink == NULL) {
 		/* can not match superblock if tlink were ever null */
diff --git a/fs/cifs/smb2ops.c b/fs/cifs/smb2ops.c
index ccf311750927..7468f8baf499 100644
--- a/fs/cifs/smb2ops.c
+++ b/fs/cifs/smb2ops.c
@@ -1682,7 +1682,7 @@ smb2_copychunk_range(const unsigned int xid,
 		pcchunk->SourceOffset = cpu_to_le64(src_off);
 		pcchunk->TargetOffset = cpu_to_le64(dest_off);
 		pcchunk->Length =
-			cpu_to_le32(min_t(u32, len, tcon->max_bytes_chunk));
+			cpu_to_le32(min_t(u64, len, tcon->max_bytes_chunk));
 
 		/* Request server copy to target from src identified by key */
 		kfree(retbuf);
diff --git a/fs/ext4/balloc.c b/fs/ext4/balloc.c
index 8ff4b9192a9f..f2c415f31b75 100644
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
@@ -401,6 +417,15 @@ static int ext4_validate_block_bitmap(struct super_block *sb,
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
diff --git a/fs/ext4/extents_status.c b/fs/ext4/extents_status.c
index 7ada374ff27d..44e83521bfde 100644
--- a/fs/ext4/extents_status.c
+++ b/fs/ext4/extents_status.c
@@ -269,14 +269,12 @@ static void __es_find_extent_range(struct inode *inode,
 
 	/* see if the extent has been cached */
 	es->es_lblk = es->es_len = es->es_pblk = 0;
-	if (tree->cache_es) {
-		es1 = tree->cache_es;
-		if (in_range(lblk, es1->es_lblk, es1->es_len)) {
-			es_debug("%u cached by [%u/%u) %llu %x\n",
-				 lblk, es1->es_lblk, es1->es_len,
-				 ext4_es_pblock(es1), ext4_es_status(es1));
-			goto out;
-		}
+	es1 = READ_ONCE(tree->cache_es);
+	if (es1 && in_range(lblk, es1->es_lblk, es1->es_len)) {
+		es_debug("%u cached by [%u/%u) %llu %x\n",
+			 lblk, es1->es_lblk, es1->es_len,
+			 ext4_es_pblock(es1), ext4_es_status(es1));
+		goto out;
 	}
 
 	es1 = __es_tree_search(&tree->root, lblk);
@@ -295,7 +293,7 @@ static void __es_find_extent_range(struct inode *inode,
 	}
 
 	if (es1 && matching_fn(es1)) {
-		tree->cache_es = es1;
+		WRITE_ONCE(tree->cache_es, es1);
 		es->es_lblk = es1->es_lblk;
 		es->es_len = es1->es_len;
 		es->es_pblk = es1->es_pblk;
@@ -933,14 +931,12 @@ int ext4_es_lookup_extent(struct inode *inode, ext4_lblk_t lblk,
 
 	/* find extent in cache firstly */
 	es->es_lblk = es->es_len = es->es_pblk = 0;
-	if (tree->cache_es) {
-		es1 = tree->cache_es;
-		if (in_range(lblk, es1->es_lblk, es1->es_len)) {
-			es_debug("%u cached by [%u/%u)\n",
-				 lblk, es1->es_lblk, es1->es_len);
-			found = 1;
-			goto out;
-		}
+	es1 = READ_ONCE(tree->cache_es);
+	if (es1 && in_range(lblk, es1->es_lblk, es1->es_len)) {
+		es_debug("%u cached by [%u/%u)\n",
+			 lblk, es1->es_lblk, es1->es_len);
+		found = 1;
+		goto out;
 	}
 
 	node = tree->root.rb_node;
diff --git a/fs/ext4/hash.c b/fs/ext4/hash.c
index 147b5241dd94..46c3423ddfa1 100644
--- a/fs/ext4/hash.c
+++ b/fs/ext4/hash.c
@@ -277,7 +277,11 @@ static int __ext4fs_dirhash(const struct inode *dir, const char *name, int len,
 	}
 	default:
 		hinfo->hash = 0;
-		return -1;
+		hinfo->minor_hash = 0;
+		ext4_warning(dir->i_sb,
+			     "invalid/unsupported hash tree version %u",
+			     hinfo->hash_version);
+		return -EINVAL;
 	}
 	hash = hash & ~1;
 	if (hash == (EXT4_HTREE_EOF_32BIT << 1))
diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
index c4475a74c762..3a91be1d9bbe 100644
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -34,6 +34,7 @@ static int get_max_inline_xattr_value_size(struct inode *inode,
 	struct ext4_xattr_ibody_header *header;
 	struct ext4_xattr_entry *entry;
 	struct ext4_inode *raw_inode;
+	void *end;
 	int free, min_offs;
 
 	if (!EXT4_INODE_HAS_XATTR_SPACE(inode))
@@ -57,14 +58,23 @@ static int get_max_inline_xattr_value_size(struct inode *inode,
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
@@ -351,7 +361,7 @@ static int ext4_update_inline_data(handle_t *handle, struct inode *inode,
 
 	error = ext4_xattr_ibody_get(inode, i.name_index, i.name,
 				     value, len);
-	if (error == -ENODATA)
+	if (error < 0)
 		goto out;
 
 	BUFFER_TRACE(is.iloc.bh, "get_write_access");
@@ -1178,6 +1188,7 @@ static int ext4_finish_convert_inline_dir(handle_t *handle,
 		ext4_initialize_dirent_tail(dir_block,
 					    inode->i_sb->s_blocksize);
 	set_buffer_uptodate(dir_block);
+	unlock_buffer(dir_block);
 	err = ext4_handle_dirty_dirblock(handle, inode, dir_block);
 	if (err)
 		return err;
@@ -1252,6 +1263,7 @@ static int ext4_convert_inline_data_nolock(handle_t *handle,
 	if (!S_ISDIR(inode->i_mode)) {
 		memcpy(data_bh->b_data, buf, inline_size);
 		set_buffer_uptodate(data_bh);
+		unlock_buffer(data_bh);
 		error = ext4_handle_dirty_metadata(handle,
 						   inode, data_bh);
 	} else {
@@ -1259,7 +1271,6 @@ static int ext4_convert_inline_data_nolock(handle_t *handle,
 						       buf, inline_size);
 	}
 
-	unlock_buffer(data_bh);
 out_restore:
 	if (error)
 		ext4_restore_inline_data(handle, inode, iloc, buf, inline_size);
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 42003b5c4cad..ffc810436ef2 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3503,7 +3503,7 @@ static int ext4_iomap_overwrite_begin(struct inode *inode, loff_t offset,
 	 */
 	flags &= ~IOMAP_WRITE;
 	ret = ext4_iomap_begin(inode, offset, length, flags, iomap, srcmap);
-	WARN_ON_ONCE(iomap->type != IOMAP_MAPPED);
+	WARN_ON_ONCE(!ret && iomap->type != IOMAP_MAPPED);
 	return ret;
 }
 
diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 9dad93059945..912c4a1093fe 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -4820,7 +4820,11 @@ ext4_mb_release_group_pa(struct ext4_buddy *e4b,
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
diff --git a/fs/ext4/mmp.c b/fs/ext4/mmp.c
index 588cb09c5291..23930ed3cbda 100644
--- a/fs/ext4/mmp.c
+++ b/fs/ext4/mmp.c
@@ -39,28 +39,36 @@ static void ext4_mmp_csum_set(struct super_block *sb, struct mmp_struct *mmp)
  * Write the MMP block using REQ_SYNC to try to get the block on-disk
  * faster.
  */
-static int write_mmp_block(struct super_block *sb, struct buffer_head *bh)
+static int write_mmp_block_thawed(struct super_block *sb,
+				  struct buffer_head *bh)
 {
 	struct mmp_struct *mmp = (struct mmp_struct *)(bh->b_data);
 
-	/*
-	 * We protect against freezing so that we don't create dirty buffers
-	 * on frozen filesystem.
-	 */
-	sb_start_write(sb);
 	ext4_mmp_csum_set(sb, mmp);
 	lock_buffer(bh);
 	bh->b_end_io = end_buffer_write_sync;
 	get_bh(bh);
 	submit_bh(REQ_OP_WRITE | REQ_SYNC | REQ_META | REQ_PRIO, bh);
 	wait_on_buffer(bh);
-	sb_end_write(sb);
 	if (unlikely(!buffer_uptodate(bh)))
 		return -EIO;
-
 	return 0;
 }
 
+static int write_mmp_block(struct super_block *sb, struct buffer_head *bh)
+{
+	int err;
+
+	/*
+	 * We protect against freezing so that we don't create dirty buffers
+	 * on frozen filesystem.
+	 */
+	sb_start_write(sb);
+	err = write_mmp_block_thawed(sb, bh);
+	sb_end_write(sb);
+	return err;
+}
+
 /*
  * Read the MMP block. It _must_ be read from disk and hence we clear the
  * uptodate flag on the buffer.
@@ -346,7 +354,11 @@ int ext4_multi_mount_protect(struct super_block *sb,
 	seq = mmp_new_seq();
 	mmp->mmp_seq = cpu_to_le32(seq);
 
-	retval = write_mmp_block(sb, bh);
+	/*
+	 * On mount / remount we are protected against fs freezing (by s_umount
+	 * semaphore) and grabbing freeze protection upsets lockdep
+	 */
+	retval = write_mmp_block_thawed(sb, bh);
 	if (retval)
 		goto failed;
 
diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index 56f09598448b..5a3dbbabe23a 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -674,7 +674,7 @@ static struct stats dx_show_leaf(struct inode *dir,
 				len = de->name_len;
 				if (!IS_ENCRYPTED(dir)) {
 					/* Directory is not encrypted */
-					ext4fs_dirhash(dir, de->name,
+					(void) ext4fs_dirhash(dir, de->name,
 						de->name_len, &h);
 					printk("%*.s:(U)%x.%u ", len,
 					       name, h.hash,
@@ -709,8 +709,9 @@ static struct stats dx_show_leaf(struct inode *dir,
 					if (IS_CASEFOLDED(dir))
 						h.hash = EXT4_DIRENT_HASH(de);
 					else
-						ext4fs_dirhash(dir, de->name,
-						       de->name_len, &h);
+						(void) ext4fs_dirhash(dir,
+							de->name,
+							de->name_len, &h);
 					printk("%*.s:(E)%x.%u ", len, name,
 					       h.hash, (unsigned) ((char *) de
 								   - base));
@@ -720,7 +721,8 @@ static struct stats dx_show_leaf(struct inode *dir,
 #else
 				int len = de->name_len;
 				char *name = de->name;
-				ext4fs_dirhash(dir, de->name, de->name_len, &h);
+				(void) ext4fs_dirhash(dir, de->name,
+						      de->name_len, &h);
 				printk("%*.s:%x.%u ", len, name, h.hash,
 				       (unsigned) ((char *) de - base));
 #endif
@@ -849,8 +851,14 @@ dx_probe(struct ext4_filename *fname, struct inode *dir,
 	hinfo->seed = EXT4_SB(dir->i_sb)->s_hash_seed;
 	/* hash is already computed for encrypted casefolded directory */
 	if (fname && fname_name(fname) &&
-				!(IS_ENCRYPTED(dir) && IS_CASEFOLDED(dir)))
-		ext4fs_dirhash(dir, fname_name(fname), fname_len(fname), hinfo);
+	    !(IS_ENCRYPTED(dir) && IS_CASEFOLDED(dir))) {
+		int ret = ext4fs_dirhash(dir, fname_name(fname),
+					 fname_len(fname), hinfo);
+		if (ret < 0) {
+			ret_err = ERR_PTR(ret);
+			goto fail;
+		}
+	}
 	hash = hinfo->hash;
 
 	if (root->info.unused_flags & 1) {
@@ -1111,7 +1119,12 @@ static int htree_dirblock_to_tree(struct file *dir_file,
 				hinfo->minor_hash = 0;
 			}
 		} else {
-			ext4fs_dirhash(dir, de->name, de->name_len, hinfo);
+			err = ext4fs_dirhash(dir, de->name,
+					     de->name_len, hinfo);
+			if (err < 0) {
+				count = err;
+				goto errout;
+			}
 		}
 		if ((hinfo->hash < start_hash) ||
 		    ((hinfo->hash == start_hash) &&
@@ -1313,8 +1326,12 @@ static int dx_make_map(struct inode *dir, struct buffer_head *bh,
 		if (de->name_len && de->inode) {
 			if (ext4_hash_in_dirent(dir))
 				h.hash = EXT4_DIRENT_HASH(de);
-			else
-				ext4fs_dirhash(dir, de->name, de->name_len, &h);
+			else {
+				int err = ext4fs_dirhash(dir, de->name,
+						     de->name_len, &h);
+				if (err < 0)
+					return err;
+			}
 			map_tail--;
 			map_tail->hash = h.hash;
 			map_tail->offs = ((char *) de - base)>>2;
@@ -1452,10 +1469,9 @@ int ext4_fname_setup_ci_filename(struct inode *dir, const struct qstr *iname,
 	hinfo->hash_version = DX_HASH_SIPHASH;
 	hinfo->seed = NULL;
 	if (cf_name->name)
-		ext4fs_dirhash(dir, cf_name->name, cf_name->len, hinfo);
+		return ext4fs_dirhash(dir, cf_name->name, cf_name->len, hinfo);
 	else
-		ext4fs_dirhash(dir, iname->name, iname->len, hinfo);
-	return 0;
+		return ext4fs_dirhash(dir, iname->name, iname->len, hinfo);
 }
 #endif
 
@@ -2298,10 +2314,15 @@ static int make_indexed_dir(handle_t *handle, struct ext4_filename *fname,
 	fname->hinfo.seed = EXT4_SB(dir->i_sb)->s_hash_seed;
 
 	/* casefolded encrypted hashes are computed on fname setup */
-	if (!ext4_hash_in_dirent(dir))
-		ext4fs_dirhash(dir, fname_name(fname),
-				fname_len(fname), &fname->hinfo);
-
+	if (!ext4_hash_in_dirent(dir)) {
+		int err = ext4fs_dirhash(dir, fname_name(fname),
+					 fname_len(fname), &fname->hinfo);
+		if (err < 0) {
+			brelse(bh2);
+			brelse(bh);
+			return err;
+		}
+	}
 	memset(frames, 0, sizeof(frames));
 	frame = frames;
 	frame->entries = entries;
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 2528e8216c33..d542f068ca99 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -3195,11 +3195,9 @@ static __le16 ext4_group_desc_csum(struct super_block *sb, __u32 block_group,
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
@@ -6568,9 +6566,6 @@ static int __ext4_remount(struct fs_context *fc, struct super_block *sb)
 	}
 
 #ifdef CONFIG_QUOTA
-	/* Release old quota file names */
-	for (i = 0; i < EXT4_MAXQUOTAS; i++)
-		kfree(old_opts.s_qf_names[i]);
 	if (enable_quota) {
 		if (sb_any_quota_suspended(sb))
 			dquot_resume(sb, -1);
@@ -6580,6 +6575,9 @@ static int __ext4_remount(struct fs_context *fc, struct super_block *sb)
 				goto restore_opts;
 		}
 	}
+	/* Release old quota file names */
+	for (i = 0; i < EXT4_MAXQUOTAS; i++)
+		kfree(old_opts.s_qf_names[i]);
 #endif
 	if (!test_opt(sb, BLOCK_VALIDITY) && sbi->s_system_blks)
 		ext4_release_system_zone(sb);
@@ -6590,6 +6588,13 @@ static int __ext4_remount(struct fs_context *fc, struct super_block *sb)
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
index b17c1b90e122..b1b8fe86ccdb 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -2564,6 +2564,7 @@ static int ext4_xattr_move_to_block(handle_t *handle, struct inode *inode,
 		.in_inode = !!entry->e_value_inum,
 	};
 	struct ext4_xattr_ibody_header *header = IHDR(inode, raw_inode);
+	int needs_kvfree = 0;
 	int error;
 
 	is = kzalloc(sizeof(struct ext4_xattr_ibody_find), GFP_NOFS);
@@ -2586,7 +2587,7 @@ static int ext4_xattr_move_to_block(handle_t *handle, struct inode *inode,
 			error = -ENOMEM;
 			goto out;
 		}
-
+		needs_kvfree = 1;
 		error = ext4_xattr_inode_get(inode, entry, buffer, value_size);
 		if (error)
 			goto out;
@@ -2625,7 +2626,7 @@ static int ext4_xattr_move_to_block(handle_t *handle, struct inode *inode,
 
 out:
 	kfree(b_entry_name);
-	if (entry->e_value_inum && buffer)
+	if (needs_kvfree && buffer)
 		kvfree(buffer);
 	if (is)
 		brelse(is->iloc.bh);
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 770a606eb3f6..de6b056f090b 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1134,7 +1134,7 @@ void f2fs_update_data_blkaddr(struct dnode_of_data *dn, block_t blkaddr)
 {
 	dn->data_blkaddr = blkaddr;
 	f2fs_set_data_blkaddr(dn);
-	f2fs_update_extent_cache(dn);
+	f2fs_update_read_extent_cache(dn);
 }
 
 /* dn->ofs_in_node will be returned with up-to-date last block pointer */
@@ -1203,7 +1203,7 @@ int f2fs_get_block(struct dnode_of_data *dn, pgoff_t index)
 	struct extent_info ei = {0, };
 	struct inode *inode = dn->inode;
 
-	if (f2fs_lookup_extent_cache(inode, index, &ei)) {
+	if (f2fs_lookup_read_extent_cache(inode, index, &ei)) {
 		dn->data_blkaddr = ei.blk + index - ei.fofs;
 		return 0;
 	}
@@ -1224,7 +1224,7 @@ struct page *f2fs_get_read_data_page(struct inode *inode, pgoff_t index,
 	if (!page)
 		return ERR_PTR(-ENOMEM);
 
-	if (f2fs_lookup_extent_cache(inode, index, &ei)) {
+	if (f2fs_lookup_read_extent_cache(inode, index, &ei)) {
 		dn.data_blkaddr = ei.blk + index - ei.fofs;
 		if (!f2fs_is_valid_blkaddr(F2FS_I_SB(inode), dn.data_blkaddr,
 						DATA_GENERIC_ENHANCE_READ)) {
@@ -1486,7 +1486,7 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map,
 	pgofs =	(pgoff_t)map->m_lblk;
 	end = pgofs + maxblocks;
 
-	if (!create && f2fs_lookup_extent_cache(inode, pgofs, &ei)) {
+	if (!create && f2fs_lookup_read_extent_cache(inode, pgofs, &ei)) {
 		if (f2fs_lfs_mode(sbi) && flag == F2FS_GET_BLOCK_DIO &&
 							map->m_may_create)
 			goto next_dnode;
@@ -1696,7 +1696,7 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map,
 		if (map->m_flags & F2FS_MAP_MAPPED) {
 			unsigned int ofs = start_pgofs - map->m_lblk;
 
-			f2fs_update_extent_cache_range(&dn,
+			f2fs_update_read_extent_cache_range(&dn,
 				start_pgofs, map->m_pblk + ofs,
 				map->m_len - ofs);
 		}
@@ -1741,7 +1741,7 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map,
 		if (map->m_flags & F2FS_MAP_MAPPED) {
 			unsigned int ofs = start_pgofs - map->m_lblk;
 
-			f2fs_update_extent_cache_range(&dn,
+			f2fs_update_read_extent_cache_range(&dn,
 				start_pgofs, map->m_pblk + ofs,
 				map->m_len - ofs);
 		}
@@ -2202,7 +2202,7 @@ int f2fs_read_multi_pages(struct compress_ctx *cc, struct bio **bio_ret,
 	if (f2fs_cluster_is_empty(cc))
 		goto out;
 
-	if (f2fs_lookup_extent_cache(inode, start_idx, &ei))
+	if (f2fs_lookup_read_extent_cache(inode, start_idx, &ei))
 		from_dnode = false;
 
 	if (!from_dnode)
@@ -2636,7 +2636,7 @@ int f2fs_do_write_data_page(struct f2fs_io_info *fio)
 		set_new_dnode(&dn, inode, NULL, NULL, 0);
 
 	if (need_inplace_update(fio) &&
-			f2fs_lookup_extent_cache(inode, page->index, &ei)) {
+	    f2fs_lookup_read_extent_cache(inode, page->index, &ei)) {
 		fio->old_blkaddr = ei.blk + page->index - ei.fofs;
 
 		if (!f2fs_is_valid_blkaddr(fio->sbi, fio->old_blkaddr,
@@ -3361,7 +3361,7 @@ static int prepare_write_begin(struct f2fs_sb_info *sbi,
 	} else if (locked) {
 		err = f2fs_get_block(&dn, index);
 	} else {
-		if (f2fs_lookup_extent_cache(inode, index, &ei)) {
+		if (f2fs_lookup_read_extent_cache(inode, index, &ei)) {
 			dn.data_blkaddr = ei.blk + index - ei.fofs;
 		} else {
 			/* hole case */
@@ -3402,7 +3402,7 @@ static int __find_data_block(struct inode *inode, pgoff_t index,
 
 	set_new_dnode(&dn, inode, ipage, ipage, 0);
 
-	if (f2fs_lookup_extent_cache(inode, index, &ei)) {
+	if (f2fs_lookup_read_extent_cache(inode, index, &ei)) {
 		dn.data_blkaddr = ei.blk + index - ei.fofs;
 	} else {
 		/* hole case */
diff --git a/fs/f2fs/debug.c b/fs/f2fs/debug.c
index a216dcdf6941..a9baa121d829 100644
--- a/fs/f2fs/debug.c
+++ b/fs/f2fs/debug.c
@@ -72,15 +72,23 @@ static void update_general_status(struct f2fs_sb_info *sbi)
 	si->main_area_zones = si->main_area_sections /
 				le32_to_cpu(raw_super->secs_per_zone);
 
-	/* validation check of the segment numbers */
+	/* general extent cache stats */
+	for (i = 0; i < NR_EXTENT_CACHES; i++) {
+		struct extent_tree_info *eti = &sbi->extent_tree[i];
+
+		si->hit_cached[i] = atomic64_read(&sbi->read_hit_cached[i]);
+		si->hit_rbtree[i] = atomic64_read(&sbi->read_hit_rbtree[i]);
+		si->total_ext[i] = atomic64_read(&sbi->total_hit_ext[i]);
+		si->hit_total[i] = si->hit_cached[i] + si->hit_rbtree[i];
+		si->ext_tree[i] = atomic_read(&eti->total_ext_tree);
+		si->zombie_tree[i] = atomic_read(&eti->total_zombie_tree);
+		si->ext_node[i] = atomic_read(&eti->total_ext_node);
+	}
+	/* read extent_cache only */
 	si->hit_largest = atomic64_read(&sbi->read_hit_largest);
-	si->hit_cached = atomic64_read(&sbi->read_hit_cached);
-	si->hit_rbtree = atomic64_read(&sbi->read_hit_rbtree);
-	si->hit_total = si->hit_largest + si->hit_cached + si->hit_rbtree;
-	si->total_ext = atomic64_read(&sbi->total_hit_ext);
-	si->ext_tree = atomic_read(&sbi->total_ext_tree);
-	si->zombie_tree = atomic_read(&sbi->total_zombie_tree);
-	si->ext_node = atomic_read(&sbi->total_ext_node);
+	si->hit_total[EX_READ] += si->hit_largest;
+
+	/* validation check of the segment numbers */
 	si->ndirty_node = get_pages(sbi, F2FS_DIRTY_NODES);
 	si->ndirty_dent = get_pages(sbi, F2FS_DIRTY_DENTS);
 	si->ndirty_meta = get_pages(sbi, F2FS_DIRTY_META);
@@ -294,10 +302,16 @@ static void update_mem_info(struct f2fs_sb_info *sbi)
 				sizeof(struct nat_entry_set);
 	for (i = 0; i < MAX_INO_ENTRY; i++)
 		si->cache_mem += sbi->im[i].ino_num * sizeof(struct ino_entry);
-	si->cache_mem += atomic_read(&sbi->total_ext_tree) *
+
+	for (i = 0; i < NR_EXTENT_CACHES; i++) {
+		struct extent_tree_info *eti = &sbi->extent_tree[i];
+
+		si->ext_mem[i] = atomic_read(&eti->total_ext_tree) *
 						sizeof(struct extent_tree);
-	si->cache_mem += atomic_read(&sbi->total_ext_node) *
+		si->ext_mem[i] += atomic_read(&eti->total_ext_node) *
 						sizeof(struct extent_node);
+		si->cache_mem += si->ext_mem[i];
+	}
 
 	si->page_mem = 0;
 	if (sbi->node_inode) {
@@ -490,16 +504,18 @@ static int stat_show(struct seq_file *s, void *v)
 				si->bg_node_blks);
 		seq_printf(s, "BG skip : IO: %u, Other: %u\n",
 				si->io_skip_bggc, si->other_skip_bggc);
-		seq_puts(s, "\nExtent Cache:\n");
+		seq_puts(s, "\nExtent Cache (Read):\n");
 		seq_printf(s, "  - Hit Count: L1-1:%llu L1-2:%llu L2:%llu\n",
-				si->hit_largest, si->hit_cached,
-				si->hit_rbtree);
+				si->hit_largest, si->hit_cached[EX_READ],
+				si->hit_rbtree[EX_READ]);
 		seq_printf(s, "  - Hit Ratio: %llu%% (%llu / %llu)\n",
-				!si->total_ext ? 0 :
-				div64_u64(si->hit_total * 100, si->total_ext),
-				si->hit_total, si->total_ext);
+				!si->total_ext[EX_READ] ? 0 :
+				div64_u64(si->hit_total[EX_READ] * 100,
+				si->total_ext[EX_READ]),
+				si->hit_total[EX_READ], si->total_ext[EX_READ]);
 		seq_printf(s, "  - Inner Struct Count: tree: %d(%d), node: %d\n",
-				si->ext_tree, si->zombie_tree, si->ext_node);
+				si->ext_tree[EX_READ], si->zombie_tree[EX_READ],
+				si->ext_node[EX_READ]);
 		seq_puts(s, "\nBalancing F2FS Async:\n");
 		seq_printf(s, "  - DIO (R: %4d, W: %4d)\n",
 			   si->nr_dio_read, si->nr_dio_write);
@@ -566,8 +582,10 @@ static int stat_show(struct seq_file *s, void *v)
 			(si->base_mem + si->cache_mem + si->page_mem) >> 10);
 		seq_printf(s, "  - static: %llu KB\n",
 				si->base_mem >> 10);
-		seq_printf(s, "  - cached: %llu KB\n",
+		seq_printf(s, "  - cached all: %llu KB\n",
 				si->cache_mem >> 10);
+		seq_printf(s, "  - read extent cache: %llu KB\n",
+				si->ext_mem[EX_READ] >> 10);
 		seq_printf(s, "  - paged : %llu KB\n",
 				si->page_mem >> 10);
 	}
@@ -600,10 +618,15 @@ int f2fs_build_stats(struct f2fs_sb_info *sbi)
 	si->sbi = sbi;
 	sbi->stat_info = si;
 
-	atomic64_set(&sbi->total_hit_ext, 0);
-	atomic64_set(&sbi->read_hit_rbtree, 0);
+	/* general extent cache stats */
+	for (i = 0; i < NR_EXTENT_CACHES; i++) {
+		atomic64_set(&sbi->total_hit_ext[i], 0);
+		atomic64_set(&sbi->read_hit_rbtree[i], 0);
+		atomic64_set(&sbi->read_hit_cached[i], 0);
+	}
+
+	/* read extent_cache only */
 	atomic64_set(&sbi->read_hit_largest, 0);
-	atomic64_set(&sbi->read_hit_cached, 0);
 
 	atomic_set(&sbi->inline_xattr, 0);
 	atomic_set(&sbi->inline_inode, 0);
diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
index 6c9e6f78a3e3..16692c96e765 100644
--- a/fs/f2fs/extent_cache.c
+++ b/fs/f2fs/extent_cache.c
@@ -15,6 +15,122 @@
 #include "node.h"
 #include <trace/events/f2fs.h>
 
+bool sanity_check_extent_cache(struct inode *inode)
+{
+	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
+	struct f2fs_inode_info *fi = F2FS_I(inode);
+	struct extent_info *ei;
+
+	if (!fi->extent_tree[EX_READ])
+		return true;
+
+	ei = &fi->extent_tree[EX_READ]->largest;
+
+	if (ei->len &&
+		(!f2fs_is_valid_blkaddr(sbi, ei->blk,
+					DATA_GENERIC_ENHANCE) ||
+		!f2fs_is_valid_blkaddr(sbi, ei->blk + ei->len - 1,
+					DATA_GENERIC_ENHANCE))) {
+		set_sbi_flag(sbi, SBI_NEED_FSCK);
+		f2fs_warn(sbi, "%s: inode (ino=%lx) extent info [%u, %u, %u] is incorrect, run fsck to fix",
+			  __func__, inode->i_ino,
+			  ei->blk, ei->fofs, ei->len);
+		return false;
+	}
+	return true;
+}
+
+static void __set_extent_info(struct extent_info *ei,
+				unsigned int fofs, unsigned int len,
+				block_t blk, bool keep_clen,
+				enum extent_type type)
+{
+	ei->fofs = fofs;
+	ei->len = len;
+
+	if (type == EX_READ) {
+		ei->blk = blk;
+		if (keep_clen)
+			return;
+#ifdef CONFIG_F2FS_FS_COMPRESSION
+		ei->c_len = 0;
+#endif
+	}
+}
+
+static bool __may_read_extent_tree(struct inode *inode)
+{
+	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
+
+	if (!test_opt(sbi, READ_EXTENT_CACHE))
+		return false;
+	if (is_inode_flag_set(inode, FI_NO_EXTENT))
+		return false;
+	if (is_inode_flag_set(inode, FI_COMPRESSED_FILE) &&
+			 !f2fs_sb_has_readonly(sbi))
+		return false;
+	return S_ISREG(inode->i_mode);
+}
+
+static bool __init_may_extent_tree(struct inode *inode, enum extent_type type)
+{
+	if (type == EX_READ)
+		return __may_read_extent_tree(inode);
+	return false;
+}
+
+static bool __may_extent_tree(struct inode *inode, enum extent_type type)
+{
+	/*
+	 * for recovered files during mount do not create extents
+	 * if shrinker is not registered.
+	 */
+	if (list_empty(&F2FS_I_SB(inode)->s_list))
+		return false;
+
+	return __init_may_extent_tree(inode, type);
+}
+
+static void __try_update_largest_extent(struct extent_tree *et,
+						struct extent_node *en)
+{
+	if (et->type != EX_READ)
+		return;
+	if (en->ei.len <= et->largest.len)
+		return;
+
+	et->largest = en->ei;
+	et->largest_updated = true;
+}
+
+static bool __is_extent_mergeable(struct extent_info *back,
+		struct extent_info *front, enum extent_type type)
+{
+	if (type == EX_READ) {
+#ifdef CONFIG_F2FS_FS_COMPRESSION
+		if (back->c_len && back->len != back->c_len)
+			return false;
+		if (front->c_len && front->len != front->c_len)
+			return false;
+#endif
+		return (back->fofs + back->len == front->fofs &&
+				back->blk + back->len == front->blk);
+	}
+	return false;
+}
+
+static bool __is_back_mergeable(struct extent_info *cur,
+		struct extent_info *back, enum extent_type type)
+{
+	return __is_extent_mergeable(back, cur, type);
+}
+
+static bool __is_front_mergeable(struct extent_info *cur,
+		struct extent_info *front, enum extent_type type)
+{
+	return __is_extent_mergeable(cur, front, type);
+}
+
 static struct rb_entry *__lookup_rb_tree_fast(struct rb_entry *cached_re,
 							unsigned int ofs)
 {
@@ -58,29 +174,6 @@ struct rb_entry *f2fs_lookup_rb_tree(struct rb_root_cached *root,
 	return re;
 }
 
-struct rb_node **f2fs_lookup_rb_tree_ext(struct f2fs_sb_info *sbi,
-					struct rb_root_cached *root,
-					struct rb_node **parent,
-					unsigned long long key, bool *leftmost)
-{
-	struct rb_node **p = &root->rb_root.rb_node;
-	struct rb_entry *re;
-
-	while (*p) {
-		*parent = *p;
-		re = rb_entry(*parent, struct rb_entry, rb_node);
-
-		if (key < re->key) {
-			p = &(*p)->rb_left;
-		} else {
-			p = &(*p)->rb_right;
-			*leftmost = false;
-		}
-	}
-
-	return p;
-}
-
 struct rb_node **f2fs_lookup_rb_tree_for_insert(struct f2fs_sb_info *sbi,
 				struct rb_root_cached *root,
 				struct rb_node **parent,
@@ -189,7 +282,7 @@ struct rb_entry *f2fs_lookup_rb_tree_ret(struct rb_root_cached *root,
 }
 
 bool f2fs_check_rb_tree_consistence(struct f2fs_sb_info *sbi,
-				struct rb_root_cached *root, bool check_key)
+				struct rb_root_cached *root)
 {
 #ifdef CONFIG_F2FS_CHECK_FS
 	struct rb_node *cur = rb_first_cached(root), *next;
@@ -206,23 +299,12 @@ bool f2fs_check_rb_tree_consistence(struct f2fs_sb_info *sbi,
 		cur_re = rb_entry(cur, struct rb_entry, rb_node);
 		next_re = rb_entry(next, struct rb_entry, rb_node);
 
-		if (check_key) {
-			if (cur_re->key > next_re->key) {
-				f2fs_info(sbi, "inconsistent rbtree, "
-					"cur(%llu) next(%llu)",
-					cur_re->key, next_re->key);
-				return false;
-			}
-			goto next;
-		}
-
 		if (cur_re->ofs + cur_re->len > next_re->ofs) {
 			f2fs_info(sbi, "inconsistent rbtree, cur(%u, %u) next(%u, %u)",
 				  cur_re->ofs, cur_re->len,
 				  next_re->ofs, next_re->len);
 			return false;
 		}
-next:
 		cur = next;
 	}
 #endif
@@ -237,6 +319,7 @@ static struct extent_node *__attach_extent_node(struct f2fs_sb_info *sbi,
 				struct rb_node *parent, struct rb_node **p,
 				bool leftmost)
 {
+	struct extent_tree_info *eti = &sbi->extent_tree[et->type];
 	struct extent_node *en;
 
 	en = f2fs_kmem_cache_alloc(extent_node_slab, GFP_ATOMIC, false, sbi);
@@ -250,16 +333,18 @@ static struct extent_node *__attach_extent_node(struct f2fs_sb_info *sbi,
 	rb_link_node(&en->rb_node, parent, p);
 	rb_insert_color_cached(&en->rb_node, &et->root, leftmost);
 	atomic_inc(&et->node_cnt);
-	atomic_inc(&sbi->total_ext_node);
+	atomic_inc(&eti->total_ext_node);
 	return en;
 }
 
 static void __detach_extent_node(struct f2fs_sb_info *sbi,
 				struct extent_tree *et, struct extent_node *en)
 {
+	struct extent_tree_info *eti = &sbi->extent_tree[et->type];
+
 	rb_erase_cached(&en->rb_node, &et->root);
 	atomic_dec(&et->node_cnt);
-	atomic_dec(&sbi->total_ext_node);
+	atomic_dec(&eti->total_ext_node);
 
 	if (et->cached_en == en)
 		et->cached_en = NULL;
@@ -275,61 +360,51 @@ static void __detach_extent_node(struct f2fs_sb_info *sbi,
 static void __release_extent_node(struct f2fs_sb_info *sbi,
 			struct extent_tree *et, struct extent_node *en)
 {
-	spin_lock(&sbi->extent_lock);
+	struct extent_tree_info *eti = &sbi->extent_tree[et->type];
+
+	spin_lock(&eti->extent_lock);
 	f2fs_bug_on(sbi, list_empty(&en->list));
 	list_del_init(&en->list);
-	spin_unlock(&sbi->extent_lock);
+	spin_unlock(&eti->extent_lock);
 
 	__detach_extent_node(sbi, et, en);
 }
 
-static struct extent_tree *__grab_extent_tree(struct inode *inode)
+static struct extent_tree *__grab_extent_tree(struct inode *inode,
+						enum extent_type type)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
+	struct extent_tree_info *eti = &sbi->extent_tree[type];
 	struct extent_tree *et;
 	nid_t ino = inode->i_ino;
 
-	mutex_lock(&sbi->extent_tree_lock);
-	et = radix_tree_lookup(&sbi->extent_tree_root, ino);
+	mutex_lock(&eti->extent_tree_lock);
+	et = radix_tree_lookup(&eti->extent_tree_root, ino);
 	if (!et) {
 		et = f2fs_kmem_cache_alloc(extent_tree_slab,
 					GFP_NOFS, true, NULL);
-		f2fs_radix_tree_insert(&sbi->extent_tree_root, ino, et);
+		f2fs_radix_tree_insert(&eti->extent_tree_root, ino, et);
 		memset(et, 0, sizeof(struct extent_tree));
 		et->ino = ino;
+		et->type = type;
 		et->root = RB_ROOT_CACHED;
 		et->cached_en = NULL;
 		rwlock_init(&et->lock);
 		INIT_LIST_HEAD(&et->list);
 		atomic_set(&et->node_cnt, 0);
-		atomic_inc(&sbi->total_ext_tree);
+		atomic_inc(&eti->total_ext_tree);
 	} else {
-		atomic_dec(&sbi->total_zombie_tree);
+		atomic_dec(&eti->total_zombie_tree);
 		list_del_init(&et->list);
 	}
-	mutex_unlock(&sbi->extent_tree_lock);
+	mutex_unlock(&eti->extent_tree_lock);
 
 	/* never died until evict_inode */
-	F2FS_I(inode)->extent_tree = et;
+	F2FS_I(inode)->extent_tree[type] = et;
 
 	return et;
 }
 
-static struct extent_node *__init_extent_tree(struct f2fs_sb_info *sbi,
-				struct extent_tree *et, struct extent_info *ei)
-{
-	struct rb_node **p = &et->root.rb_root.rb_node;
-	struct extent_node *en;
-
-	en = __attach_extent_node(sbi, et, ei, NULL, p, true);
-	if (!en)
-		return NULL;
-
-	et->largest = en->ei;
-	et->cached_en = en;
-	return en;
-}
-
 static unsigned int __free_extent_tree(struct f2fs_sb_info *sbi,
 					struct extent_tree *et)
 {
@@ -358,71 +433,78 @@ static void __drop_largest_extent(struct extent_tree *et,
 	}
 }
 
-/* return true, if inode page is changed */
-static void __f2fs_init_extent_tree(struct inode *inode, struct page *ipage)
+void f2fs_init_read_extent_tree(struct inode *inode, struct page *ipage)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
-	struct f2fs_extent *i_ext = ipage ? &F2FS_INODE(ipage)->i_ext : NULL;
+	struct extent_tree_info *eti = &sbi->extent_tree[EX_READ];
+	struct f2fs_extent *i_ext = &F2FS_INODE(ipage)->i_ext;
 	struct extent_tree *et;
 	struct extent_node *en;
 	struct extent_info ei;
 
-	if (!f2fs_may_extent_tree(inode)) {
-		/* drop largest extent */
+	if (!__may_extent_tree(inode, EX_READ)) {
+		/* drop largest read extent */
 		if (i_ext && i_ext->len) {
 			f2fs_wait_on_page_writeback(ipage, NODE, true, true);
 			i_ext->len = 0;
 			set_page_dirty(ipage);
-			return;
 		}
-		return;
+		goto out;
 	}
 
-	et = __grab_extent_tree(inode);
+	et = __grab_extent_tree(inode, EX_READ);
 
 	if (!i_ext || !i_ext->len)
-		return;
+		goto out;
 
-	get_extent_info(&ei, i_ext);
+	get_read_extent_info(&ei, i_ext);
 
 	write_lock(&et->lock);
 	if (atomic_read(&et->node_cnt))
-		goto out;
+		goto unlock_out;
 
-	en = __init_extent_tree(sbi, et, &ei);
+	en = __attach_extent_node(sbi, et, &ei, NULL,
+				&et->root.rb_root.rb_node, true);
 	if (en) {
-		spin_lock(&sbi->extent_lock);
-		list_add_tail(&en->list, &sbi->extent_list);
-		spin_unlock(&sbi->extent_lock);
+		et->largest = en->ei;
+		et->cached_en = en;
+
+		spin_lock(&eti->extent_lock);
+		list_add_tail(&en->list, &eti->extent_list);
+		spin_unlock(&eti->extent_lock);
 	}
-out:
+unlock_out:
 	write_unlock(&et->lock);
+out:
+	if (!F2FS_I(inode)->extent_tree[EX_READ])
+		set_inode_flag(inode, FI_NO_EXTENT);
 }
 
-void f2fs_init_extent_tree(struct inode *inode, struct page *ipage)
+void f2fs_init_extent_tree(struct inode *inode)
 {
-	__f2fs_init_extent_tree(inode, ipage);
-
-	if (!F2FS_I(inode)->extent_tree)
-		set_inode_flag(inode, FI_NO_EXTENT);
+	/* initialize read cache */
+	if (__init_may_extent_tree(inode, EX_READ))
+		__grab_extent_tree(inode, EX_READ);
 }
 
-static bool f2fs_lookup_extent_tree(struct inode *inode, pgoff_t pgofs,
-							struct extent_info *ei)
+static bool __lookup_extent_tree(struct inode *inode, pgoff_t pgofs,
+			struct extent_info *ei, enum extent_type type)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
-	struct extent_tree *et = F2FS_I(inode)->extent_tree;
+	struct extent_tree_info *eti = &sbi->extent_tree[type];
+	struct extent_tree *et = F2FS_I(inode)->extent_tree[type];
 	struct extent_node *en;
 	bool ret = false;
 
 	if (!et)
 		return false;
 
-	trace_f2fs_lookup_extent_tree_start(inode, pgofs);
+	trace_f2fs_lookup_extent_tree_start(inode, pgofs, type);
 
 	read_lock(&et->lock);
 
-	if (et->largest.fofs <= pgofs &&
+	if (type == EX_READ &&
+			et->largest.fofs <= pgofs &&
 			et->largest.fofs + et->largest.len > pgofs) {
 		*ei = et->largest;
 		ret = true;
@@ -436,23 +518,24 @@ static bool f2fs_lookup_extent_tree(struct inode *inode, pgoff_t pgofs,
 		goto out;
 
 	if (en == et->cached_en)
-		stat_inc_cached_node_hit(sbi);
+		stat_inc_cached_node_hit(sbi, type);
 	else
-		stat_inc_rbtree_node_hit(sbi);
+		stat_inc_rbtree_node_hit(sbi, type);
 
 	*ei = en->ei;
-	spin_lock(&sbi->extent_lock);
+	spin_lock(&eti->extent_lock);
 	if (!list_empty(&en->list)) {
-		list_move_tail(&en->list, &sbi->extent_list);
+		list_move_tail(&en->list, &eti->extent_list);
 		et->cached_en = en;
 	}
-	spin_unlock(&sbi->extent_lock);
+	spin_unlock(&eti->extent_lock);
 	ret = true;
 out:
-	stat_inc_total_hit(sbi);
+	stat_inc_total_hit(sbi, type);
 	read_unlock(&et->lock);
 
-	trace_f2fs_lookup_extent_tree_end(inode, pgofs, ei);
+	if (type == EX_READ)
+		trace_f2fs_lookup_read_extent_tree_end(inode, pgofs, ei);
 	return ret;
 }
 
@@ -461,18 +544,20 @@ static struct extent_node *__try_merge_extent_node(struct f2fs_sb_info *sbi,
 				struct extent_node *prev_ex,
 				struct extent_node *next_ex)
 {
+	struct extent_tree_info *eti = &sbi->extent_tree[et->type];
 	struct extent_node *en = NULL;
 
-	if (prev_ex && __is_back_mergeable(ei, &prev_ex->ei)) {
+	if (prev_ex && __is_back_mergeable(ei, &prev_ex->ei, et->type)) {
 		prev_ex->ei.len += ei->len;
 		ei = &prev_ex->ei;
 		en = prev_ex;
 	}
 
-	if (next_ex && __is_front_mergeable(ei, &next_ex->ei)) {
+	if (next_ex && __is_front_mergeable(ei, &next_ex->ei, et->type)) {
 		next_ex->ei.fofs = ei->fofs;
-		next_ex->ei.blk = ei->blk;
 		next_ex->ei.len += ei->len;
+		if (et->type == EX_READ)
+			next_ex->ei.blk = ei->blk;
 		if (en)
 			__release_extent_node(sbi, et, prev_ex);
 
@@ -484,12 +569,12 @@ static struct extent_node *__try_merge_extent_node(struct f2fs_sb_info *sbi,
 
 	__try_update_largest_extent(et, en);
 
-	spin_lock(&sbi->extent_lock);
+	spin_lock(&eti->extent_lock);
 	if (!list_empty(&en->list)) {
-		list_move_tail(&en->list, &sbi->extent_list);
+		list_move_tail(&en->list, &eti->extent_list);
 		et->cached_en = en;
 	}
-	spin_unlock(&sbi->extent_lock);
+	spin_unlock(&eti->extent_lock);
 	return en;
 }
 
@@ -499,6 +584,7 @@ static struct extent_node *__insert_extent_tree(struct f2fs_sb_info *sbi,
 				struct rb_node *insert_parent,
 				bool leftmost)
 {
+	struct extent_tree_info *eti = &sbi->extent_tree[et->type];
 	struct rb_node **p;
 	struct rb_node *parent = NULL;
 	struct extent_node *en = NULL;
@@ -521,47 +607,50 @@ static struct extent_node *__insert_extent_tree(struct f2fs_sb_info *sbi,
 	__try_update_largest_extent(et, en);
 
 	/* update in global extent list */
-	spin_lock(&sbi->extent_lock);
-	list_add_tail(&en->list, &sbi->extent_list);
+	spin_lock(&eti->extent_lock);
+	list_add_tail(&en->list, &eti->extent_list);
 	et->cached_en = en;
-	spin_unlock(&sbi->extent_lock);
+	spin_unlock(&eti->extent_lock);
 	return en;
 }
 
-static void f2fs_update_extent_tree_range(struct inode *inode,
-				pgoff_t fofs, block_t blkaddr, unsigned int len)
+static void __update_extent_tree_range(struct inode *inode,
+			struct extent_info *tei, enum extent_type type)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
-	struct extent_tree *et = F2FS_I(inode)->extent_tree;
+	struct extent_tree *et = F2FS_I(inode)->extent_tree[type];
 	struct extent_node *en = NULL, *en1 = NULL;
 	struct extent_node *prev_en = NULL, *next_en = NULL;
 	struct extent_info ei, dei, prev;
 	struct rb_node **insert_p = NULL, *insert_parent = NULL;
+	unsigned int fofs = tei->fofs, len = tei->len;
 	unsigned int end = fofs + len;
-	unsigned int pos = (unsigned int)fofs;
 	bool updated = false;
 	bool leftmost = false;
 
 	if (!et)
 		return;
 
-	trace_f2fs_update_extent_tree_range(inode, fofs, blkaddr, len, 0);
-
+	if (type == EX_READ)
+		trace_f2fs_update_read_extent_tree_range(inode, fofs, len,
+						tei->blk, 0);
 	write_lock(&et->lock);
 
-	if (is_inode_flag_set(inode, FI_NO_EXTENT)) {
-		write_unlock(&et->lock);
-		return;
-	}
+	if (type == EX_READ) {
+		if (is_inode_flag_set(inode, FI_NO_EXTENT)) {
+			write_unlock(&et->lock);
+			return;
+		}
 
-	prev = et->largest;
-	dei.len = 0;
+		prev = et->largest;
+		dei.len = 0;
 
-	/*
-	 * drop largest extent before lookup, in case it's already
-	 * been shrunk from extent tree
-	 */
-	__drop_largest_extent(et, fofs, len);
+		/*
+		 * drop largest extent before lookup, in case it's already
+		 * been shrunk from extent tree
+		 */
+		__drop_largest_extent(et, fofs, len);
+	}
 
 	/* 1. lookup first extent node in range [fofs, fofs + len - 1] */
 	en = (struct extent_node *)f2fs_lookup_rb_tree_ret(&et->root,
@@ -582,26 +671,30 @@ static void f2fs_update_extent_tree_range(struct inode *inode,
 
 		dei = en->ei;
 		org_end = dei.fofs + dei.len;
-		f2fs_bug_on(sbi, pos >= org_end);
+		f2fs_bug_on(sbi, fofs >= org_end);
 
-		if (pos > dei.fofs && pos - dei.fofs >= F2FS_MIN_EXTENT_LEN) {
-			en->ei.len = pos - en->ei.fofs;
+		if (fofs > dei.fofs && (type != EX_READ ||
+				fofs - dei.fofs >= F2FS_MIN_EXTENT_LEN)) {
+			en->ei.len = fofs - en->ei.fofs;
 			prev_en = en;
 			parts = 1;
 		}
 
-		if (end < org_end && org_end - end >= F2FS_MIN_EXTENT_LEN) {
+		if (end < org_end && (type != EX_READ ||
+				org_end - end >= F2FS_MIN_EXTENT_LEN)) {
 			if (parts) {
-				set_extent_info(&ei, end,
-						end - dei.fofs + dei.blk,
-						org_end - end);
+				__set_extent_info(&ei,
+					end, org_end - end,
+					end - dei.fofs + dei.blk, false,
+					type);
 				en1 = __insert_extent_tree(sbi, et, &ei,
 							NULL, NULL, true);
 				next_en = en1;
 			} else {
-				en->ei.fofs = end;
-				en->ei.blk += end - dei.fofs;
-				en->ei.len -= end - dei.fofs;
+				__set_extent_info(&en->ei,
+					end, en->ei.len - (end - dei.fofs),
+					en->ei.blk + (end - dei.fofs), true,
+					type);
 				next_en = en;
 			}
 			parts++;
@@ -631,10 +724,11 @@ static void f2fs_update_extent_tree_range(struct inode *inode,
 		en = next_en;
 	}
 
-	/* 3. update extent in extent cache */
-	if (blkaddr) {
+	/* 3. update extent in read extent cache */
+	BUG_ON(type != EX_READ);
 
-		set_extent_info(&ei, fofs, blkaddr, len);
+	if (tei->blk) {
+		__set_extent_info(&ei, fofs, len, tei->blk, false, EX_READ);
 		if (!__try_merge_extent_node(sbi, et, &ei, prev_en, next_en))
 			__insert_extent_tree(sbi, et, &ei,
 					insert_p, insert_parent, leftmost);
@@ -664,19 +758,20 @@ static void f2fs_update_extent_tree_range(struct inode *inode,
 }
 
 #ifdef CONFIG_F2FS_FS_COMPRESSION
-void f2fs_update_extent_tree_range_compressed(struct inode *inode,
+void f2fs_update_read_extent_tree_range_compressed(struct inode *inode,
 				pgoff_t fofs, block_t blkaddr, unsigned int llen,
 				unsigned int c_len)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
-	struct extent_tree *et = F2FS_I(inode)->extent_tree;
+	struct extent_tree *et = F2FS_I(inode)->extent_tree[EX_READ];
 	struct extent_node *en = NULL;
 	struct extent_node *prev_en = NULL, *next_en = NULL;
 	struct extent_info ei;
 	struct rb_node **insert_p = NULL, *insert_parent = NULL;
 	bool leftmost = false;
 
-	trace_f2fs_update_extent_tree_range(inode, fofs, blkaddr, llen, c_len);
+	trace_f2fs_update_read_extent_tree_range(inode, fofs, llen,
+						blkaddr, c_len);
 
 	/* it is safe here to check FI_NO_EXTENT w/o et->lock in ro image */
 	if (is_inode_flag_set(inode, FI_NO_EXTENT))
@@ -693,7 +788,7 @@ void f2fs_update_extent_tree_range_compressed(struct inode *inode,
 	if (en)
 		goto unlock_out;
 
-	set_extent_info(&ei, fofs, blkaddr, llen);
+	__set_extent_info(&ei, fofs, llen, blkaddr, true, EX_READ);
 	ei.c_len = c_len;
 
 	if (!__try_merge_extent_node(sbi, et, &ei, prev_en, next_en))
@@ -704,24 +799,43 @@ void f2fs_update_extent_tree_range_compressed(struct inode *inode,
 }
 #endif
 
-unsigned int f2fs_shrink_extent_tree(struct f2fs_sb_info *sbi, int nr_shrink)
+static void __update_extent_cache(struct dnode_of_data *dn, enum extent_type type)
 {
+	struct extent_info ei;
+
+	if (!__may_extent_tree(dn->inode, type))
+		return;
+
+	ei.fofs = f2fs_start_bidx_of_node(ofs_of_node(dn->node_page), dn->inode) +
+								dn->ofs_in_node;
+	ei.len = 1;
+
+	if (type == EX_READ) {
+		if (dn->data_blkaddr == NEW_ADDR)
+			ei.blk = NULL_ADDR;
+		else
+			ei.blk = dn->data_blkaddr;
+	}
+	__update_extent_tree_range(dn->inode, &ei, type);
+}
+
+static unsigned int __shrink_extent_tree(struct f2fs_sb_info *sbi, int nr_shrink,
+					enum extent_type type)
+{
+	struct extent_tree_info *eti = &sbi->extent_tree[type];
 	struct extent_tree *et, *next;
 	struct extent_node *en;
 	unsigned int node_cnt = 0, tree_cnt = 0;
 	int remained;
 
-	if (!test_opt(sbi, EXTENT_CACHE))
-		return 0;
-
-	if (!atomic_read(&sbi->total_zombie_tree))
+	if (!atomic_read(&eti->total_zombie_tree))
 		goto free_node;
 
-	if (!mutex_trylock(&sbi->extent_tree_lock))
+	if (!mutex_trylock(&eti->extent_tree_lock))
 		goto out;
 
 	/* 1. remove unreferenced extent tree */
-	list_for_each_entry_safe(et, next, &sbi->zombie_list, list) {
+	list_for_each_entry_safe(et, next, &eti->zombie_list, list) {
 		if (atomic_read(&et->node_cnt)) {
 			write_lock(&et->lock);
 			node_cnt += __free_extent_tree(sbi, et);
@@ -729,61 +843,100 @@ unsigned int f2fs_shrink_extent_tree(struct f2fs_sb_info *sbi, int nr_shrink)
 		}
 		f2fs_bug_on(sbi, atomic_read(&et->node_cnt));
 		list_del_init(&et->list);
-		radix_tree_delete(&sbi->extent_tree_root, et->ino);
+		radix_tree_delete(&eti->extent_tree_root, et->ino);
 		kmem_cache_free(extent_tree_slab, et);
-		atomic_dec(&sbi->total_ext_tree);
-		atomic_dec(&sbi->total_zombie_tree);
+		atomic_dec(&eti->total_ext_tree);
+		atomic_dec(&eti->total_zombie_tree);
 		tree_cnt++;
 
 		if (node_cnt + tree_cnt >= nr_shrink)
 			goto unlock_out;
 		cond_resched();
 	}
-	mutex_unlock(&sbi->extent_tree_lock);
+	mutex_unlock(&eti->extent_tree_lock);
 
 free_node:
 	/* 2. remove LRU extent entries */
-	if (!mutex_trylock(&sbi->extent_tree_lock))
+	if (!mutex_trylock(&eti->extent_tree_lock))
 		goto out;
 
 	remained = nr_shrink - (node_cnt + tree_cnt);
 
-	spin_lock(&sbi->extent_lock);
+	spin_lock(&eti->extent_lock);
 	for (; remained > 0; remained--) {
-		if (list_empty(&sbi->extent_list))
+		if (list_empty(&eti->extent_list))
 			break;
-		en = list_first_entry(&sbi->extent_list,
+		en = list_first_entry(&eti->extent_list,
 					struct extent_node, list);
 		et = en->et;
 		if (!write_trylock(&et->lock)) {
 			/* refresh this extent node's position in extent list */
-			list_move_tail(&en->list, &sbi->extent_list);
+			list_move_tail(&en->list, &eti->extent_list);
 			continue;
 		}
 
 		list_del_init(&en->list);
-		spin_unlock(&sbi->extent_lock);
+		spin_unlock(&eti->extent_lock);
 
 		__detach_extent_node(sbi, et, en);
 
 		write_unlock(&et->lock);
 		node_cnt++;
-		spin_lock(&sbi->extent_lock);
+		spin_lock(&eti->extent_lock);
 	}
-	spin_unlock(&sbi->extent_lock);
+	spin_unlock(&eti->extent_lock);
 
 unlock_out:
-	mutex_unlock(&sbi->extent_tree_lock);
+	mutex_unlock(&eti->extent_tree_lock);
 out:
-	trace_f2fs_shrink_extent_tree(sbi, node_cnt, tree_cnt);
+	trace_f2fs_shrink_extent_tree(sbi, node_cnt, tree_cnt, type);
 
 	return node_cnt + tree_cnt;
 }
 
-unsigned int f2fs_destroy_extent_node(struct inode *inode)
+/* read extent cache operations */
+bool f2fs_lookup_read_extent_cache(struct inode *inode, pgoff_t pgofs,
+				struct extent_info *ei)
+{
+	if (!__may_extent_tree(inode, EX_READ))
+		return false;
+
+	return __lookup_extent_tree(inode, pgofs, ei, EX_READ);
+}
+
+void f2fs_update_read_extent_cache(struct dnode_of_data *dn)
+{
+	return __update_extent_cache(dn, EX_READ);
+}
+
+void f2fs_update_read_extent_cache_range(struct dnode_of_data *dn,
+				pgoff_t fofs, block_t blkaddr, unsigned int len)
+{
+	struct extent_info ei = {
+		.fofs = fofs,
+		.len = len,
+		.blk = blkaddr,
+	};
+
+	if (!__may_extent_tree(dn->inode, EX_READ))
+		return;
+
+	__update_extent_tree_range(dn->inode, &ei, EX_READ);
+}
+
+unsigned int f2fs_shrink_read_extent_tree(struct f2fs_sb_info *sbi, int nr_shrink)
+{
+	if (!test_opt(sbi, READ_EXTENT_CACHE))
+		return 0;
+
+	return __shrink_extent_tree(sbi, nr_shrink, EX_READ);
+}
+
+static unsigned int __destroy_extent_node(struct inode *inode,
+					enum extent_type type)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
-	struct extent_tree *et = F2FS_I(inode)->extent_tree;
+	struct extent_tree *et = F2FS_I(inode)->extent_tree[type];
 	unsigned int node_cnt = 0;
 
 	if (!et || !atomic_read(&et->node_cnt))
@@ -796,31 +949,44 @@ unsigned int f2fs_destroy_extent_node(struct inode *inode)
 	return node_cnt;
 }
 
-void f2fs_drop_extent_tree(struct inode *inode)
+void f2fs_destroy_extent_node(struct inode *inode)
+{
+	__destroy_extent_node(inode, EX_READ);
+}
+
+static void __drop_extent_tree(struct inode *inode, enum extent_type type)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
-	struct extent_tree *et = F2FS_I(inode)->extent_tree;
+	struct extent_tree *et = F2FS_I(inode)->extent_tree[type];
 	bool updated = false;
 
-	if (!f2fs_may_extent_tree(inode))
+	if (!__may_extent_tree(inode, type))
 		return;
 
 	write_lock(&et->lock);
-	set_inode_flag(inode, FI_NO_EXTENT);
 	__free_extent_tree(sbi, et);
-	if (et->largest.len) {
-		et->largest.len = 0;
-		updated = true;
+	if (type == EX_READ) {
+		set_inode_flag(inode, FI_NO_EXTENT);
+		if (et->largest.len) {
+			et->largest.len = 0;
+			updated = true;
+		}
 	}
 	write_unlock(&et->lock);
 	if (updated)
 		f2fs_mark_inode_dirty_sync(inode, true);
 }
 
-void f2fs_destroy_extent_tree(struct inode *inode)
+void f2fs_drop_extent_tree(struct inode *inode)
+{
+	__drop_extent_tree(inode, EX_READ);
+}
+
+static void __destroy_extent_tree(struct inode *inode, enum extent_type type)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
-	struct extent_tree *et = F2FS_I(inode)->extent_tree;
+	struct extent_tree_info *eti = &sbi->extent_tree[type];
+	struct extent_tree *et = F2FS_I(inode)->extent_tree[type];
 	unsigned int node_cnt = 0;
 
 	if (!et)
@@ -828,76 +994,49 @@ void f2fs_destroy_extent_tree(struct inode *inode)
 
 	if (inode->i_nlink && !is_bad_inode(inode) &&
 					atomic_read(&et->node_cnt)) {
-		mutex_lock(&sbi->extent_tree_lock);
-		list_add_tail(&et->list, &sbi->zombie_list);
-		atomic_inc(&sbi->total_zombie_tree);
-		mutex_unlock(&sbi->extent_tree_lock);
+		mutex_lock(&eti->extent_tree_lock);
+		list_add_tail(&et->list, &eti->zombie_list);
+		atomic_inc(&eti->total_zombie_tree);
+		mutex_unlock(&eti->extent_tree_lock);
 		return;
 	}
 
 	/* free all extent info belong to this extent tree */
-	node_cnt = f2fs_destroy_extent_node(inode);
+	node_cnt = __destroy_extent_node(inode, type);
 
 	/* delete extent tree entry in radix tree */
-	mutex_lock(&sbi->extent_tree_lock);
+	mutex_lock(&eti->extent_tree_lock);
 	f2fs_bug_on(sbi, atomic_read(&et->node_cnt));
-	radix_tree_delete(&sbi->extent_tree_root, inode->i_ino);
+	radix_tree_delete(&eti->extent_tree_root, inode->i_ino);
 	kmem_cache_free(extent_tree_slab, et);
-	atomic_dec(&sbi->total_ext_tree);
-	mutex_unlock(&sbi->extent_tree_lock);
+	atomic_dec(&eti->total_ext_tree);
+	mutex_unlock(&eti->extent_tree_lock);
 
-	F2FS_I(inode)->extent_tree = NULL;
-
-	trace_f2fs_destroy_extent_tree(inode, node_cnt);
-}
-
-bool f2fs_lookup_extent_cache(struct inode *inode, pgoff_t pgofs,
-					struct extent_info *ei)
-{
-	if (!f2fs_may_extent_tree(inode))
-		return false;
+	F2FS_I(inode)->extent_tree[type] = NULL;
 
-	return f2fs_lookup_extent_tree(inode, pgofs, ei);
+	trace_f2fs_destroy_extent_tree(inode, node_cnt, type);
 }
 
-void f2fs_update_extent_cache(struct dnode_of_data *dn)
+void f2fs_destroy_extent_tree(struct inode *inode)
 {
-	pgoff_t fofs;
-	block_t blkaddr;
-
-	if (!f2fs_may_extent_tree(dn->inode))
-		return;
-
-	if (dn->data_blkaddr == NEW_ADDR)
-		blkaddr = NULL_ADDR;
-	else
-		blkaddr = dn->data_blkaddr;
-
-	fofs = f2fs_start_bidx_of_node(ofs_of_node(dn->node_page), dn->inode) +
-								dn->ofs_in_node;
-	f2fs_update_extent_tree_range(dn->inode, fofs, blkaddr, 1);
+	__destroy_extent_tree(inode, EX_READ);
 }
 
-void f2fs_update_extent_cache_range(struct dnode_of_data *dn,
-				pgoff_t fofs, block_t blkaddr, unsigned int len)
-
+static void __init_extent_tree_info(struct extent_tree_info *eti)
 {
-	if (!f2fs_may_extent_tree(dn->inode))
-		return;
-
-	f2fs_update_extent_tree_range(dn->inode, fofs, blkaddr, len);
+	INIT_RADIX_TREE(&eti->extent_tree_root, GFP_NOIO);
+	mutex_init(&eti->extent_tree_lock);
+	INIT_LIST_HEAD(&eti->extent_list);
+	spin_lock_init(&eti->extent_lock);
+	atomic_set(&eti->total_ext_tree, 0);
+	INIT_LIST_HEAD(&eti->zombie_list);
+	atomic_set(&eti->total_zombie_tree, 0);
+	atomic_set(&eti->total_ext_node, 0);
 }
 
 void f2fs_init_extent_cache_info(struct f2fs_sb_info *sbi)
 {
-	INIT_RADIX_TREE(&sbi->extent_tree_root, GFP_NOIO);
-	mutex_init(&sbi->extent_tree_lock);
-	INIT_LIST_HEAD(&sbi->extent_list);
-	spin_lock_init(&sbi->extent_lock);
-	atomic_set(&sbi->total_ext_tree, 0);
-	INIT_LIST_HEAD(&sbi->zombie_list);
-	atomic_set(&sbi->total_zombie_tree, 0);
-	atomic_set(&sbi->total_ext_node, 0);
+	__init_extent_tree_info(&sbi->extent_tree[EX_READ]);
 }
 
 int __init f2fs_create_extent_cache(void)
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 4b44ca1decdd..a0a232551da9 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -91,7 +91,7 @@ extern const char *f2fs_fault_name[FAULT_MAX];
 #define F2FS_MOUNT_FLUSH_MERGE		0x00000400
 #define F2FS_MOUNT_NOBARRIER		0x00000800
 #define F2FS_MOUNT_FASTBOOT		0x00001000
-#define F2FS_MOUNT_EXTENT_CACHE		0x00002000
+#define F2FS_MOUNT_READ_EXTENT_CACHE	0x00002000
 #define F2FS_MOUNT_DATA_FLUSH		0x00008000
 #define F2FS_MOUNT_FAULT_INJECTION	0x00010000
 #define F2FS_MOUNT_USRQUOTA		0x00080000
@@ -593,35 +593,43 @@ enum {
 /* dirty segments threshold for triggering CP */
 #define DEFAULT_DIRTY_THRESHOLD		4
 
+#define RECOVERY_MAX_RA_BLOCKS		BIO_MAX_VECS
+#define RECOVERY_MIN_RA_BLOCKS		1
+
+#define F2FS_ONSTACK_PAGES	16	/* nr of onstack pages */
+
 /* for in-memory extent cache entry */
 #define F2FS_MIN_EXTENT_LEN	64	/* minimum extent length */
 
 /* number of extent info in extent cache we try to shrink */
-#define EXTENT_CACHE_SHRINK_NUMBER	128
+#define READ_EXTENT_CACHE_SHRINK_NUMBER	128
 
-#define RECOVERY_MAX_RA_BLOCKS		BIO_MAX_VECS
-#define RECOVERY_MIN_RA_BLOCKS		1
-
-#define F2FS_ONSTACK_PAGES	16	/* nr of onstack pages */
+/* extent cache type */
+enum extent_type {
+	EX_READ,
+	NR_EXTENT_CACHES,
+};
 
 struct rb_entry {
 	struct rb_node rb_node;		/* rb node located in rb-tree */
-	union {
-		struct {
-			unsigned int ofs;	/* start offset of the entry */
-			unsigned int len;	/* length of the entry */
-		};
-		unsigned long long key;		/* 64-bits key */
-	} __packed;
+	unsigned int ofs;		/* start offset of the entry */
+	unsigned int len;		/* length of the entry */
 };
 
 struct extent_info {
 	unsigned int fofs;		/* start offset in a file */
 	unsigned int len;		/* length of the extent */
-	u32 blk;			/* start block address of the extent */
+	union {
+		/* read extent_cache */
+		struct {
+			/* start block address of the extent */
+			block_t blk;
 #ifdef CONFIG_F2FS_FS_COMPRESSION
-	unsigned int c_len;		/* physical extent length of compressed blocks */
+			/* physical extent length of compressed blocks */
+			unsigned int c_len;
 #endif
+		};
+	};
 };
 
 struct extent_node {
@@ -633,13 +641,25 @@ struct extent_node {
 
 struct extent_tree {
 	nid_t ino;			/* inode number */
+	enum extent_type type;		/* keep the extent tree type */
 	struct rb_root_cached root;	/* root of extent info rb-tree */
 	struct extent_node *cached_en;	/* recently accessed extent node */
-	struct extent_info largest;	/* largested extent info */
 	struct list_head list;		/* to be used by sbi->zombie_list */
 	rwlock_t lock;			/* protect extent info rb-tree */
 	atomic_t node_cnt;		/* # of extent node in rb-tree*/
 	bool largest_updated;		/* largest extent updated */
+	struct extent_info largest;	/* largest cached extent for EX_READ */
+};
+
+struct extent_tree_info {
+	struct radix_tree_root extent_tree_root;/* cache extent cache entries */
+	struct mutex extent_tree_lock;	/* locking extent radix tree */
+	struct list_head extent_list;		/* lru list for shrinker */
+	spinlock_t extent_lock;			/* locking extent lru list */
+	atomic_t total_ext_tree;		/* extent tree count */
+	struct list_head zombie_list;		/* extent zombie tree list */
+	atomic_t total_zombie_tree;		/* extent zombie tree count */
+	atomic_t total_ext_node;		/* extent info count */
 };
 
 /*
@@ -801,7 +821,8 @@ struct f2fs_inode_info {
 	struct list_head dirty_list;	/* dirty list for dirs and files */
 	struct list_head gdirty_list;	/* linked in global dirty list */
 	struct task_struct *atomic_write_task;	/* store atomic write task */
-	struct extent_tree *extent_tree;	/* cached extent_tree entry */
+	struct extent_tree *extent_tree[NR_EXTENT_CACHES];
+					/* cached extent_tree entry */
 	struct inode *cow_inode;	/* copy-on-write inode for atomic write */
 
 	/* avoid racing between foreground op and gc */
@@ -826,7 +847,7 @@ struct f2fs_inode_info {
 	loff_t original_i_size;		/* original i_size before atomic write */
 };
 
-static inline void get_extent_info(struct extent_info *ext,
+static inline void get_read_extent_info(struct extent_info *ext,
 					struct f2fs_extent *i_ext)
 {
 	ext->fofs = le32_to_cpu(i_ext->fofs);
@@ -834,7 +855,7 @@ static inline void get_extent_info(struct extent_info *ext,
 	ext->len = le32_to_cpu(i_ext->len);
 }
 
-static inline void set_raw_extent(struct extent_info *ext,
+static inline void set_raw_read_extent(struct extent_info *ext,
 					struct f2fs_extent *i_ext)
 {
 	i_ext->fofs = cpu_to_le32(ext->fofs);
@@ -842,17 +863,6 @@ static inline void set_raw_extent(struct extent_info *ext,
 	i_ext->len = cpu_to_le32(ext->len);
 }
 
-static inline void set_extent_info(struct extent_info *ei, unsigned int fofs,
-						u32 blk, unsigned int len)
-{
-	ei->fofs = fofs;
-	ei->blk = blk;
-	ei->len = len;
-#ifdef CONFIG_F2FS_FS_COMPRESSION
-	ei->c_len = 0;
-#endif
-}
-
 static inline bool __is_discard_mergeable(struct discard_info *back,
 			struct discard_info *front, unsigned int max_len)
 {
@@ -872,41 +882,6 @@ static inline bool __is_discard_front_mergeable(struct discard_info *cur,
 	return __is_discard_mergeable(cur, front, max_len);
 }
 
-static inline bool __is_extent_mergeable(struct extent_info *back,
-						struct extent_info *front)
-{
-#ifdef CONFIG_F2FS_FS_COMPRESSION
-	if (back->c_len && back->len != back->c_len)
-		return false;
-	if (front->c_len && front->len != front->c_len)
-		return false;
-#endif
-	return (back->fofs + back->len == front->fofs &&
-			back->blk + back->len == front->blk);
-}
-
-static inline bool __is_back_mergeable(struct extent_info *cur,
-						struct extent_info *back)
-{
-	return __is_extent_mergeable(back, cur);
-}
-
-static inline bool __is_front_mergeable(struct extent_info *cur,
-						struct extent_info *front)
-{
-	return __is_extent_mergeable(cur, front);
-}
-
-extern void f2fs_mark_inode_dirty_sync(struct inode *inode, bool sync);
-static inline void __try_update_largest_extent(struct extent_tree *et,
-						struct extent_node *en)
-{
-	if (en->ei.len > et->largest.len) {
-		et->largest = en->ei;
-		et->largest_updated = true;
-	}
-}
-
 /*
  * For free nid management
  */
@@ -1670,14 +1645,7 @@ struct f2fs_sb_info {
 	struct mutex flush_lock;		/* for flush exclusion */
 
 	/* for extent tree cache */
-	struct radix_tree_root extent_tree_root;/* cache extent cache entries */
-	struct mutex extent_tree_lock;	/* locking extent radix tree */
-	struct list_head extent_list;		/* lru list for shrinker */
-	spinlock_t extent_lock;			/* locking extent lru list */
-	atomic_t total_ext_tree;		/* extent tree count */
-	struct list_head zombie_list;		/* extent zombie tree list */
-	atomic_t total_zombie_tree;		/* extent zombie tree count */
-	atomic_t total_ext_node;		/* extent info count */
+	struct extent_tree_info extent_tree[NR_EXTENT_CACHES];
 
 	/* basic filesystem units */
 	unsigned int log_sectors_per_block;	/* log2 sectors per block */
@@ -1761,10 +1729,14 @@ struct f2fs_sb_info {
 	unsigned int segment_count[2];		/* # of allocated segments */
 	unsigned int block_count[2];		/* # of allocated blocks */
 	atomic_t inplace_count;		/* # of inplace update */
-	atomic64_t total_hit_ext;		/* # of lookup extent cache */
-	atomic64_t read_hit_rbtree;		/* # of hit rbtree extent node */
-	atomic64_t read_hit_largest;		/* # of hit largest extent node */
-	atomic64_t read_hit_cached;		/* # of hit cached extent node */
+	/* # of lookup extent cache */
+	atomic64_t total_hit_ext[NR_EXTENT_CACHES];
+	/* # of hit rbtree extent node */
+	atomic64_t read_hit_rbtree[NR_EXTENT_CACHES];
+	/* # of hit cached extent node */
+	atomic64_t read_hit_cached[NR_EXTENT_CACHES];
+	/* # of hit largest extent node in read extent cache */
+	atomic64_t read_hit_largest;
 	atomic_t inline_xattr;			/* # of inline_xattr inodes */
 	atomic_t inline_inode;			/* # of inline_data inodes */
 	atomic_t inline_dir;			/* # of inline_dentry inodes */
@@ -2578,6 +2550,7 @@ static inline block_t __start_sum_addr(struct f2fs_sb_info *sbi)
 	return le32_to_cpu(F2FS_CKPT(sbi)->cp_pack_start_sum);
 }
 
+extern void f2fs_mark_inode_dirty_sync(struct inode *inode, bool sync);
 static inline int inc_valid_node_count(struct f2fs_sb_info *sbi,
 					struct inode *inode, bool is_inode)
 {
@@ -3865,9 +3838,17 @@ struct f2fs_stat_info {
 	struct f2fs_sb_info *sbi;
 	int all_area_segs, sit_area_segs, nat_area_segs, ssa_area_segs;
 	int main_area_segs, main_area_sections, main_area_zones;
-	unsigned long long hit_largest, hit_cached, hit_rbtree;
-	unsigned long long hit_total, total_ext;
-	int ext_tree, zombie_tree, ext_node;
+	unsigned long long hit_cached[NR_EXTENT_CACHES];
+	unsigned long long hit_rbtree[NR_EXTENT_CACHES];
+	unsigned long long total_ext[NR_EXTENT_CACHES];
+	unsigned long long hit_total[NR_EXTENT_CACHES];
+	int ext_tree[NR_EXTENT_CACHES];
+	int zombie_tree[NR_EXTENT_CACHES];
+	int ext_node[NR_EXTENT_CACHES];
+	/* to count memory footprint */
+	unsigned long long ext_mem[NR_EXTENT_CACHES];
+	/* for read extent cache */
+	unsigned long long hit_largest;
 	int ndirty_node, ndirty_dent, ndirty_meta, ndirty_imeta;
 	int ndirty_data, ndirty_qdata;
 	unsigned int ndirty_dirs, ndirty_files, nquota_files, ndirty_all;
@@ -3926,10 +3907,10 @@ static inline struct f2fs_stat_info *F2FS_STAT(struct f2fs_sb_info *sbi)
 #define stat_other_skip_bggc_count(sbi)	((sbi)->other_skip_bggc++)
 #define stat_inc_dirty_inode(sbi, type)	((sbi)->ndirty_inode[type]++)
 #define stat_dec_dirty_inode(sbi, type)	((sbi)->ndirty_inode[type]--)
-#define stat_inc_total_hit(sbi)		(atomic64_inc(&(sbi)->total_hit_ext))
-#define stat_inc_rbtree_node_hit(sbi)	(atomic64_inc(&(sbi)->read_hit_rbtree))
+#define stat_inc_total_hit(sbi, type)		(atomic64_inc(&(sbi)->total_hit_ext[type]))
+#define stat_inc_rbtree_node_hit(sbi, type)	(atomic64_inc(&(sbi)->read_hit_rbtree[type]))
 #define stat_inc_largest_node_hit(sbi)	(atomic64_inc(&(sbi)->read_hit_largest))
-#define stat_inc_cached_node_hit(sbi)	(atomic64_inc(&(sbi)->read_hit_cached))
+#define stat_inc_cached_node_hit(sbi, type)	(atomic64_inc(&(sbi)->read_hit_cached[type]))
 #define stat_inc_inline_xattr(inode)					\
 	do {								\
 		if (f2fs_has_inline_xattr(inode))			\
@@ -4052,10 +4033,10 @@ void f2fs_update_sit_info(struct f2fs_sb_info *sbi);
 #define stat_other_skip_bggc_count(sbi)			do { } while (0)
 #define stat_inc_dirty_inode(sbi, type)			do { } while (0)
 #define stat_dec_dirty_inode(sbi, type)			do { } while (0)
-#define stat_inc_total_hit(sbi)				do { } while (0)
-#define stat_inc_rbtree_node_hit(sbi)			do { } while (0)
+#define stat_inc_total_hit(sbi, type)			do { } while (0)
+#define stat_inc_rbtree_node_hit(sbi, type)		do { } while (0)
 #define stat_inc_largest_node_hit(sbi)			do { } while (0)
-#define stat_inc_cached_node_hit(sbi)			do { } while (0)
+#define stat_inc_cached_node_hit(sbi, type)		do { } while (0)
 #define stat_inc_inline_xattr(inode)			do { } while (0)
 #define stat_dec_inline_xattr(inode)			do { } while (0)
 #define stat_inc_inline_inode(inode)			do { } while (0)
@@ -4144,12 +4125,9 @@ void f2fs_leave_shrinker(struct f2fs_sb_info *sbi);
 /*
  * extent_cache.c
  */
+bool sanity_check_extent_cache(struct inode *inode);
 struct rb_entry *f2fs_lookup_rb_tree(struct rb_root_cached *root,
 				struct rb_entry *cached_re, unsigned int ofs);
-struct rb_node **f2fs_lookup_rb_tree_ext(struct f2fs_sb_info *sbi,
-				struct rb_root_cached *root,
-				struct rb_node **parent,
-				unsigned long long key, bool *left_most);
 struct rb_node **f2fs_lookup_rb_tree_for_insert(struct f2fs_sb_info *sbi,
 				struct rb_root_cached *root,
 				struct rb_node **parent,
@@ -4160,21 +4138,25 @@ struct rb_entry *f2fs_lookup_rb_tree_ret(struct rb_root_cached *root,
 		struct rb_node ***insert_p, struct rb_node **insert_parent,
 		bool force, bool *leftmost);
 bool f2fs_check_rb_tree_consistence(struct f2fs_sb_info *sbi,
-				struct rb_root_cached *root, bool check_key);
-unsigned int f2fs_shrink_extent_tree(struct f2fs_sb_info *sbi, int nr_shrink);
-void f2fs_init_extent_tree(struct inode *inode, struct page *ipage);
+				struct rb_root_cached *root);
+void f2fs_init_extent_tree(struct inode *inode);
 void f2fs_drop_extent_tree(struct inode *inode);
-unsigned int f2fs_destroy_extent_node(struct inode *inode);
+void f2fs_destroy_extent_node(struct inode *inode);
 void f2fs_destroy_extent_tree(struct inode *inode);
-bool f2fs_lookup_extent_cache(struct inode *inode, pgoff_t pgofs,
-			struct extent_info *ei);
-void f2fs_update_extent_cache(struct dnode_of_data *dn);
-void f2fs_update_extent_cache_range(struct dnode_of_data *dn,
-			pgoff_t fofs, block_t blkaddr, unsigned int len);
 void f2fs_init_extent_cache_info(struct f2fs_sb_info *sbi);
 int __init f2fs_create_extent_cache(void);
 void f2fs_destroy_extent_cache(void);
 
+/* read extent cache ops */
+void f2fs_init_read_extent_tree(struct inode *inode, struct page *ipage);
+bool f2fs_lookup_read_extent_cache(struct inode *inode, pgoff_t pgofs,
+			struct extent_info *ei);
+void f2fs_update_read_extent_cache(struct dnode_of_data *dn);
+void f2fs_update_read_extent_cache_range(struct dnode_of_data *dn,
+			pgoff_t fofs, block_t blkaddr, unsigned int len);
+unsigned int f2fs_shrink_read_extent_tree(struct f2fs_sb_info *sbi,
+			int nr_shrink);
+
 /*
  * sysfs.c
  */
@@ -4244,9 +4226,9 @@ int f2fs_write_multi_pages(struct compress_ctx *cc,
 						struct writeback_control *wbc,
 						enum iostat_type io_type);
 int f2fs_is_compressed_cluster(struct inode *inode, pgoff_t index);
-void f2fs_update_extent_tree_range_compressed(struct inode *inode,
-				pgoff_t fofs, block_t blkaddr, unsigned int llen,
-				unsigned int c_len);
+void f2fs_update_read_extent_tree_range_compressed(struct inode *inode,
+				pgoff_t fofs, block_t blkaddr,
+				unsigned int llen, unsigned int c_len);
 int f2fs_read_multi_pages(struct compress_ctx *cc, struct bio **bio_ret,
 				unsigned nr_pages, sector_t *last_block_in_bio,
 				bool is_readahead, bool for_write);
@@ -4327,9 +4309,10 @@ static inline bool f2fs_load_compressed_page(struct f2fs_sb_info *sbi,
 static inline void f2fs_invalidate_compress_pages(struct f2fs_sb_info *sbi,
 							nid_t ino) { }
 #define inc_compr_inode_stat(inode)		do { } while (0)
-static inline void f2fs_update_extent_tree_range_compressed(struct inode *inode,
-				pgoff_t fofs, block_t blkaddr, unsigned int llen,
-				unsigned int c_len) { }
+static inline void f2fs_update_read_extent_tree_range_compressed(
+				struct inode *inode,
+				pgoff_t fofs, block_t blkaddr,
+				unsigned int llen, unsigned int c_len) { }
 #endif
 
 static inline int set_compress_context(struct inode *inode)
@@ -4400,26 +4383,6 @@ F2FS_FEATURE_FUNCS(casefold, CASEFOLD);
 F2FS_FEATURE_FUNCS(compression, COMPRESSION);
 F2FS_FEATURE_FUNCS(readonly, RO);
 
-static inline bool f2fs_may_extent_tree(struct inode *inode)
-{
-	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
-
-	if (!test_opt(sbi, EXTENT_CACHE) ||
-			is_inode_flag_set(inode, FI_NO_EXTENT) ||
-			(is_inode_flag_set(inode, FI_COMPRESSED_FILE) &&
-			 !f2fs_sb_has_readonly(sbi)))
-		return false;
-
-	/*
-	 * for recovered files during mount do not create extents
-	 * if shrinker is not registered.
-	 */
-	if (list_empty(&sbi->s_list))
-		return false;
-
-	return S_ISREG(inode->i_mode);
-}
-
 #ifdef CONFIG_BLK_DEV_ZONED
 static inline bool f2fs_blkz_is_seq(struct f2fs_sb_info *sbi, int devi,
 				    block_t blkaddr)
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index bf37983304a3..dbad2db68f1b 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -618,7 +618,7 @@ void f2fs_truncate_data_blocks_range(struct dnode_of_data *dn, int count)
 		 */
 		fofs = f2fs_start_bidx_of_node(ofs_of_node(dn->node_page),
 							dn->inode) + ofs;
-		f2fs_update_extent_cache_range(dn, fofs, 0, len);
+		f2fs_update_read_extent_cache_range(dn, fofs, 0, len);
 		dec_valid_block_count(sbi, dn->inode, nr_free);
 	}
 	dn->ofs_in_node = ofs;
@@ -1496,7 +1496,7 @@ static int f2fs_do_zero_range(struct dnode_of_data *dn, pgoff_t start,
 		f2fs_set_data_blkaddr(dn);
 	}
 
-	f2fs_update_extent_cache_range(dn, start, 0, index - start);
+	f2fs_update_read_extent_cache_range(dn, start, 0, index - start);
 
 	return ret;
 }
@@ -2573,7 +2573,7 @@ static int f2fs_defragment_range(struct f2fs_sb_info *sbi,
 	struct f2fs_map_blocks map = { .m_next_extent = NULL,
 					.m_seg_type = NO_CHECK_TYPE,
 					.m_may_create = false };
-	struct extent_info ei = {0, 0, 0};
+	struct extent_info ei = {0, };
 	pgoff_t pg_start, pg_end, next_pgofs;
 	unsigned int blk_per_seg = sbi->blocks_per_seg;
 	unsigned int total = 0, sec_num;
@@ -2605,7 +2605,7 @@ static int f2fs_defragment_range(struct f2fs_sb_info *sbi,
 	 * lookup mapping info in extent cache, skip defragmenting if physical
 	 * block addresses are continuous.
 	 */
-	if (f2fs_lookup_extent_cache(inode, pg_start, &ei)) {
+	if (f2fs_lookup_read_extent_cache(inode, pg_start, &ei)) {
 		if (ei.fofs + ei.len >= pg_end)
 			goto out;
 	}
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index aa928d1c8159..5cd19fdc1059 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -389,40 +389,95 @@ static unsigned int count_bits(const unsigned long *addr,
 	return sum;
 }
 
-static struct victim_entry *attach_victim_entry(struct f2fs_sb_info *sbi,
-				unsigned long long mtime, unsigned int segno,
-				struct rb_node *parent, struct rb_node **p,
-				bool left_most)
+static bool f2fs_check_victim_tree(struct f2fs_sb_info *sbi,
+				struct rb_root_cached *root)
+{
+#ifdef CONFIG_F2FS_CHECK_FS
+	struct rb_node *cur = rb_first_cached(root), *next;
+	struct victim_entry *cur_ve, *next_ve;
+
+	while (cur) {
+		next = rb_next(cur);
+		if (!next)
+			return true;
+
+		cur_ve = rb_entry(cur, struct victim_entry, rb_node);
+		next_ve = rb_entry(next, struct victim_entry, rb_node);
+
+		if (cur_ve->mtime > next_ve->mtime) {
+			f2fs_info(sbi, "broken victim_rbtree, "
+				"cur_mtime(%llu) next_mtime(%llu)",
+				cur_ve->mtime, next_ve->mtime);
+			return false;
+		}
+		cur = next;
+	}
+#endif
+	return true;
+}
+
+static struct victim_entry *__lookup_victim_entry(struct f2fs_sb_info *sbi,
+					unsigned long long mtime)
+{
+	struct atgc_management *am = &sbi->am;
+	struct rb_node *node = am->root.rb_root.rb_node;
+	struct victim_entry *ve = NULL;
+
+	while (node) {
+		ve = rb_entry(node, struct victim_entry, rb_node);
+
+		if (mtime < ve->mtime)
+			node = node->rb_left;
+		else
+			node = node->rb_right;
+	}
+	return ve;
+}
+
+static struct victim_entry *__create_victim_entry(struct f2fs_sb_info *sbi,
+		unsigned long long mtime, unsigned int segno)
 {
 	struct atgc_management *am = &sbi->am;
 	struct victim_entry *ve;
 
-	ve =  f2fs_kmem_cache_alloc(victim_entry_slab,
-				GFP_NOFS, true, NULL);
+	ve =  f2fs_kmem_cache_alloc(victim_entry_slab, GFP_NOFS, true, NULL);
 
 	ve->mtime = mtime;
 	ve->segno = segno;
 
-	rb_link_node(&ve->rb_node, parent, p);
-	rb_insert_color_cached(&ve->rb_node, &am->root, left_most);
-
 	list_add_tail(&ve->list, &am->victim_list);
-
 	am->victim_count++;
 
 	return ve;
 }
 
-static void insert_victim_entry(struct f2fs_sb_info *sbi,
+static void __insert_victim_entry(struct f2fs_sb_info *sbi,
 				unsigned long long mtime, unsigned int segno)
 {
 	struct atgc_management *am = &sbi->am;
-	struct rb_node **p;
+	struct rb_root_cached *root = &am->root;
+	struct rb_node **p = &root->rb_root.rb_node;
 	struct rb_node *parent = NULL;
+	struct victim_entry *ve;
 	bool left_most = true;
 
-	p = f2fs_lookup_rb_tree_ext(sbi, &am->root, &parent, mtime, &left_most);
-	attach_victim_entry(sbi, mtime, segno, parent, p, left_most);
+	/* look up rb tree to find parent node */
+	while (*p) {
+		parent = *p;
+		ve = rb_entry(parent, struct victim_entry, rb_node);
+
+		if (mtime < ve->mtime) {
+			p = &(*p)->rb_left;
+		} else {
+			p = &(*p)->rb_right;
+			left_most = false;
+		}
+	}
+
+	ve = __create_victim_entry(sbi, mtime, segno);
+
+	rb_link_node(&ve->rb_node, parent, p);
+	rb_insert_color_cached(&ve->rb_node, root, left_most);
 }
 
 static void add_victim_entry(struct f2fs_sb_info *sbi,
@@ -458,19 +513,7 @@ static void add_victim_entry(struct f2fs_sb_info *sbi,
 	if (sit_i->dirty_max_mtime - mtime < p->age_threshold)
 		return;
 
-	insert_victim_entry(sbi, mtime, segno);
-}
-
-static struct rb_node *lookup_central_victim(struct f2fs_sb_info *sbi,
-						struct victim_sel_policy *p)
-{
-	struct atgc_management *am = &sbi->am;
-	struct rb_node *parent = NULL;
-	bool left_most;
-
-	f2fs_lookup_rb_tree_ext(sbi, &am->root, &parent, p->age, &left_most);
-
-	return parent;
+	__insert_victim_entry(sbi, mtime, segno);
 }
 
 static void atgc_lookup_victim(struct f2fs_sb_info *sbi,
@@ -480,7 +523,6 @@ static void atgc_lookup_victim(struct f2fs_sb_info *sbi,
 	struct atgc_management *am = &sbi->am;
 	struct rb_root_cached *root = &am->root;
 	struct rb_node *node;
-	struct rb_entry *re;
 	struct victim_entry *ve;
 	unsigned long long total_time;
 	unsigned long long age, u, accu;
@@ -507,12 +549,10 @@ static void atgc_lookup_victim(struct f2fs_sb_info *sbi,
 
 	node = rb_first_cached(root);
 next:
-	re = rb_entry_safe(node, struct rb_entry, rb_node);
-	if (!re)
+	ve = rb_entry_safe(node, struct victim_entry, rb_node);
+	if (!ve)
 		return;
 
-	ve = (struct victim_entry *)re;
-
 	if (ve->mtime >= max_mtime || ve->mtime < min_mtime)
 		goto skip;
 
@@ -554,8 +594,6 @@ static void atssr_lookup_victim(struct f2fs_sb_info *sbi,
 {
 	struct sit_info *sit_i = SIT_I(sbi);
 	struct atgc_management *am = &sbi->am;
-	struct rb_node *node;
-	struct rb_entry *re;
 	struct victim_entry *ve;
 	unsigned long long age;
 	unsigned long long max_mtime = sit_i->dirty_max_mtime;
@@ -565,25 +603,22 @@ static void atssr_lookup_victim(struct f2fs_sb_info *sbi,
 	unsigned int dirty_threshold = max(am->max_candidate_count,
 					am->candidate_ratio *
 					am->victim_count / 100);
-	unsigned int cost;
-	unsigned int iter = 0;
+	unsigned int cost, iter;
 	int stage = 0;
 
 	if (max_mtime < min_mtime)
 		return;
 	max_mtime += 1;
 next_stage:
-	node = lookup_central_victim(sbi, p);
+	iter = 0;
+	ve = __lookup_victim_entry(sbi, p->age);
 next_node:
-	re = rb_entry_safe(node, struct rb_entry, rb_node);
-	if (!re) {
-		if (stage == 0)
-			goto skip_stage;
+	if (!ve) {
+		if (stage++ == 0)
+			goto next_stage;
 		return;
 	}
 
-	ve = (struct victim_entry *)re;
-
 	if (ve->mtime >= max_mtime || ve->mtime < min_mtime)
 		goto skip_node;
 
@@ -609,24 +644,20 @@ static void atssr_lookup_victim(struct f2fs_sb_info *sbi,
 	}
 skip_node:
 	if (iter < dirty_threshold) {
-		if (stage == 0)
-			node = rb_prev(node);
-		else if (stage == 1)
-			node = rb_next(node);
+		ve = rb_entry(stage == 0 ? rb_prev(&ve->rb_node) :
+					rb_next(&ve->rb_node),
+					struct victim_entry, rb_node);
 		goto next_node;
 	}
-skip_stage:
-	if (stage < 1) {
-		stage++;
-		iter = 0;
+
+	if (stage++ == 0)
 		goto next_stage;
-	}
 }
+
 static void lookup_victim_by_age(struct f2fs_sb_info *sbi,
 						struct victim_sel_policy *p)
 {
-	f2fs_bug_on(sbi, !f2fs_check_rb_tree_consistence(sbi,
-						&sbi->am.root, true));
+	f2fs_bug_on(sbi, !f2fs_check_victim_tree(sbi, &sbi->am.root));
 
 	if (p->gc_mode == GC_AT)
 		atgc_lookup_victim(sbi, p);
@@ -1147,7 +1178,7 @@ static int ra_data_block(struct inode *inode, pgoff_t index)
 	struct address_space *mapping = inode->i_mapping;
 	struct dnode_of_data dn;
 	struct page *page;
-	struct extent_info ei = {0, 0, 0};
+	struct extent_info ei = {0, };
 	struct f2fs_io_info fio = {
 		.sbi = sbi,
 		.ino = inode->i_ino,
@@ -1165,7 +1196,7 @@ static int ra_data_block(struct inode *inode, pgoff_t index)
 	if (!page)
 		return -ENOMEM;
 
-	if (f2fs_lookup_extent_cache(inode, index, &ei)) {
+	if (f2fs_lookup_read_extent_cache(inode, index, &ei)) {
 		dn.data_blkaddr = ei.blk + index - ei.fofs;
 		if (unlikely(!f2fs_is_valid_blkaddr(sbi, dn.data_blkaddr,
 						DATA_GENERIC_ENHANCE_READ))) {
diff --git a/fs/f2fs/gc.h b/fs/f2fs/gc.h
index 19b956c2d697..ca84024b9c9e 100644
--- a/fs/f2fs/gc.h
+++ b/fs/f2fs/gc.h
@@ -55,20 +55,10 @@ struct gc_inode_list {
 	struct radix_tree_root iroot;
 };
 
-struct victim_info {
-	unsigned long long mtime;	/* mtime of section */
-	unsigned int segno;		/* section No. */
-};
-
 struct victim_entry {
 	struct rb_node rb_node;		/* rb node located in rb-tree */
-	union {
-		struct {
-			unsigned long long mtime;	/* mtime of section */
-			unsigned int segno;		/* segment No. */
-		};
-		struct victim_info vi;	/* victim info */
-	};
+	unsigned long long mtime;	/* mtime of section */
+	unsigned int segno;		/* segment No. */
 	struct list_head list;
 };
 
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index 229ddc2f7b07..aab3b8b3ab0a 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -262,22 +262,6 @@ static bool sanity_check_inode(struct inode *inode, struct page *node_page)
 		return false;
 	}
 
-	if (fi->extent_tree) {
-		struct extent_info *ei = &fi->extent_tree->largest;
-
-		if (ei->len &&
-			(!f2fs_is_valid_blkaddr(sbi, ei->blk,
-						DATA_GENERIC_ENHANCE) ||
-			!f2fs_is_valid_blkaddr(sbi, ei->blk + ei->len - 1,
-						DATA_GENERIC_ENHANCE))) {
-			set_sbi_flag(sbi, SBI_NEED_FSCK);
-			f2fs_warn(sbi, "%s: inode (ino=%lx) extent info [%u, %u, %u] is incorrect, run fsck to fix",
-				  __func__, inode->i_ino,
-				  ei->blk, ei->fofs, ei->len);
-			return false;
-		}
-	}
-
 	if (f2fs_sanity_check_inline_data(inode)) {
 		set_sbi_flag(sbi, SBI_NEED_FSCK);
 		f2fs_warn(sbi, "%s: inode (ino=%lx, mode=%u) should not have inline_data, run fsck to fix",
@@ -392,8 +376,6 @@ static int do_read_inode(struct inode *inode)
 	fi->i_pino = le32_to_cpu(ri->i_pino);
 	fi->i_dir_level = ri->i_dir_level;
 
-	f2fs_init_extent_tree(inode, node_page);
-
 	get_inline_info(inode, ri);
 
 	fi->i_extra_isize = f2fs_has_extra_attr(inode) ?
@@ -415,12 +397,6 @@ static int do_read_inode(struct inode *inode)
 		fi->i_inline_xattr_size = 0;
 	}
 
-	if (!sanity_check_inode(inode, node_page)) {
-		f2fs_put_page(node_page, 1);
-		f2fs_handle_error(sbi, ERROR_CORRUPTED_INODE);
-		return -EFSCORRUPTED;
-	}
-
 	/* check data exist */
 	if (f2fs_has_inline_data(inode) && !f2fs_exist_data(inode))
 		__recover_inline_status(inode, node_page);
@@ -479,6 +455,22 @@ static int do_read_inode(struct inode *inode)
 	}
 
 	init_idisk_time(inode);
+
+	/* Need all the flag bits */
+	f2fs_init_read_extent_tree(inode, node_page);
+
+	if (!sanity_check_inode(inode, node_page)) {
+		f2fs_put_page(node_page, 1);
+		f2fs_handle_error(sbi, ERROR_CORRUPTED_INODE);
+		return -EFSCORRUPTED;
+	}
+
+	if (!sanity_check_extent_cache(inode)) {
+		f2fs_put_page(node_page, 1);
+		f2fs_handle_error(sbi, ERROR_CORRUPTED_INODE);
+		return -EFSCORRUPTED;
+	}
+
 	f2fs_put_page(node_page, 1);
 
 	stat_inc_inline_xattr(inode);
@@ -607,7 +599,7 @@ struct inode *f2fs_iget_retry(struct super_block *sb, unsigned long ino)
 void f2fs_update_inode(struct inode *inode, struct page *node_page)
 {
 	struct f2fs_inode *ri;
-	struct extent_tree *et = F2FS_I(inode)->extent_tree;
+	struct extent_tree *et = F2FS_I(inode)->extent_tree[EX_READ];
 
 	f2fs_wait_on_page_writeback(node_page, NODE, true, true);
 	set_page_dirty(node_page);
@@ -629,7 +621,7 @@ void f2fs_update_inode(struct inode *inode, struct page *node_page)
 
 	if (et) {
 		read_lock(&et->lock);
-		set_raw_extent(&et->largest, &ri->i_ext);
+		set_raw_read_extent(&et->largest, &ri->i_ext);
 		read_unlock(&et->lock);
 	} else {
 		memset(&ri->i_ext, 0, sizeof(ri->i_ext));
diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index b6c14c9c33a0..d879a295b688 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -258,8 +258,6 @@ static struct inode *f2fs_new_inode(struct user_namespace *mnt_userns,
 	}
 	F2FS_I(inode)->i_inline_xattr_size = xattr_size;
 
-	f2fs_init_extent_tree(inode, NULL);
-
 	F2FS_I(inode)->i_flags =
 		f2fs_mask_flags(mode, F2FS_I(dir)->i_flags & F2FS_FL_INHERITED);
 
@@ -282,6 +280,8 @@ static struct inode *f2fs_new_inode(struct user_namespace *mnt_userns,
 
 	f2fs_set_inode_flags(inode);
 
+	f2fs_init_extent_tree(inode);
+
 	trace_f2fs_new_inode(inode, 0);
 	return inode;
 
@@ -1002,12 +1002,20 @@ static int f2fs_rename(struct user_namespace *mnt_userns, struct inode *old_dir,
 			goto out;
 	}
 
+	/*
+	 * Copied from ext4_rename: we need to protect against old.inode
+	 * directory getting converted from inline directory format into
+	 * a normal one.
+	 */
+	if (S_ISDIR(old_inode->i_mode))
+		inode_lock_nested(old_inode, I_MUTEX_NONDIR2);
+
 	err = -ENOENT;
 	old_entry = f2fs_find_entry(old_dir, &old_dentry->d_name, &old_page);
 	if (!old_entry) {
 		if (IS_ERR(old_page))
 			err = PTR_ERR(old_page);
-		goto out;
+		goto out_unlock_old;
 	}
 
 	if (S_ISDIR(old_inode->i_mode)) {
@@ -1115,6 +1123,9 @@ static int f2fs_rename(struct user_namespace *mnt_userns, struct inode *old_dir,
 
 	f2fs_unlock_op(sbi);
 
+	if (S_ISDIR(old_inode->i_mode))
+		inode_unlock(old_inode);
+
 	if (IS_DIRSYNC(old_dir) || IS_DIRSYNC(new_dir))
 		f2fs_sync_fs(sbi->sb, 1);
 
@@ -1129,6 +1140,9 @@ static int f2fs_rename(struct user_namespace *mnt_userns, struct inode *old_dir,
 		f2fs_put_page(old_dir_page, 0);
 out_old:
 	f2fs_put_page(old_page, 0);
+out_unlock_old:
+	if (S_ISDIR(old_inode->i_mode))
+		inode_unlock(old_inode);
 out:
 	iput(whiteout);
 	return err;
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index b9ee5a1176a0..07419c3e42a5 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -85,10 +85,12 @@ bool f2fs_available_free_memory(struct f2fs_sb_info *sbi, int type)
 						sizeof(struct ino_entry);
 		mem_size >>= PAGE_SHIFT;
 		res = mem_size < ((avail_ram * nm_i->ram_thresh / 100) >> 1);
-	} else if (type == EXTENT_CACHE) {
-		mem_size = (atomic_read(&sbi->total_ext_tree) *
+	} else if (type == READ_EXTENT_CACHE) {
+		struct extent_tree_info *eti = &sbi->extent_tree[EX_READ];
+
+		mem_size = (atomic_read(&eti->total_ext_tree) *
 				sizeof(struct extent_tree) +
-				atomic_read(&sbi->total_ext_node) *
+				atomic_read(&eti->total_ext_node) *
 				sizeof(struct extent_node)) >> PAGE_SHIFT;
 		res = mem_size < ((avail_ram * nm_i->ram_thresh / 100) >> 1);
 	} else if (type == DISCARD_CACHE) {
@@ -859,7 +861,7 @@ int f2fs_get_dnode_of_data(struct dnode_of_data *dn, pgoff_t index, int mode)
 			blkaddr = data_blkaddr(dn->inode, dn->node_page,
 						dn->ofs_in_node + 1);
 
-		f2fs_update_extent_tree_range_compressed(dn->inode,
+		f2fs_update_read_extent_tree_range_compressed(dn->inode,
 					index, blkaddr,
 					F2FS_I(dn->inode)->i_cluster_size,
 					c_len);
diff --git a/fs/f2fs/node.h b/fs/f2fs/node.h
index 3c09cae058b0..0aa48704c77a 100644
--- a/fs/f2fs/node.h
+++ b/fs/f2fs/node.h
@@ -146,7 +146,7 @@ enum mem_type {
 	NAT_ENTRIES,	/* indicates the cached nat entry */
 	DIRTY_DENTS,	/* indicates dirty dentry pages */
 	INO_ENTRIES,	/* indicates inode entries */
-	EXTENT_CACHE,	/* indicates extent cache */
+	READ_EXTENT_CACHE,	/* indicates read extent cache */
 	DISCARD_CACHE,	/* indicates memory of cached discard cmds */
 	COMPRESS_PAGE,	/* indicates memory of cached compressed pages */
 	BASE_CHECK,	/* check kernel status */
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index b0fbdee16a96..cbbf95b99541 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -262,7 +262,7 @@ static int __replace_atomic_write_block(struct inode *inode, pgoff_t index,
 	f2fs_put_dnode(&dn);
 
 	trace_f2fs_replace_atomic_write_block(inode, F2FS_I(inode)->cow_inode,
-					index, *old_addr, new_addr, recover);
+			index, old_addr ? *old_addr : 0, new_addr, recover);
 	return 0;
 }
 
@@ -452,8 +452,9 @@ void f2fs_balance_fs_bg(struct f2fs_sb_info *sbi, bool from_bg)
 		return;
 
 	/* try to shrink extent cache when there is no enough memory */
-	if (!f2fs_available_free_memory(sbi, EXTENT_CACHE))
-		f2fs_shrink_extent_tree(sbi, EXTENT_CACHE_SHRINK_NUMBER);
+	if (!f2fs_available_free_memory(sbi, READ_EXTENT_CACHE))
+		f2fs_shrink_read_extent_tree(sbi,
+				READ_EXTENT_CACHE_SHRINK_NUMBER);
 
 	/* check the # of cached NAT entries */
 	if (!f2fs_available_free_memory(sbi, NAT_ENTRIES))
@@ -1473,7 +1474,7 @@ static int __issue_discard_cmd(struct f2fs_sb_info *sbi,
 			goto next;
 		if (unlikely(dcc->rbtree_check))
 			f2fs_bug_on(sbi, !f2fs_check_rb_tree_consistence(sbi,
-							&dcc->root, false));
+							&dcc->root));
 		blk_start_plug(&plug);
 		list_for_each_entry_safe(dc, tmp, pend_list, list) {
 			f2fs_bug_on(sbi, dc->state != D_PREP);
@@ -3001,7 +3002,7 @@ static unsigned int __issue_discard_cmd_range(struct f2fs_sb_info *sbi,
 	mutex_lock(&dcc->cmd_lock);
 	if (unlikely(dcc->rbtree_check))
 		f2fs_bug_on(sbi, !f2fs_check_rb_tree_consistence(sbi,
-							&dcc->root, false));
+							&dcc->root));
 
 	dc = (struct discard_cmd *)f2fs_lookup_rb_tree_ret(&dcc->root,
 					NULL, start,
diff --git a/fs/f2fs/shrinker.c b/fs/f2fs/shrinker.c
index dd3c3c7a90ec..33c490e69ae3 100644
--- a/fs/f2fs/shrinker.c
+++ b/fs/f2fs/shrinker.c
@@ -28,10 +28,13 @@ static unsigned long __count_free_nids(struct f2fs_sb_info *sbi)
 	return count > 0 ? count : 0;
 }
 
-static unsigned long __count_extent_cache(struct f2fs_sb_info *sbi)
+static unsigned long __count_extent_cache(struct f2fs_sb_info *sbi,
+					enum extent_type type)
 {
-	return atomic_read(&sbi->total_zombie_tree) +
-				atomic_read(&sbi->total_ext_node);
+	struct extent_tree_info *eti = &sbi->extent_tree[type];
+
+	return atomic_read(&eti->total_zombie_tree) +
+				atomic_read(&eti->total_ext_node);
 }
 
 unsigned long f2fs_shrink_count(struct shrinker *shrink,
@@ -53,8 +56,8 @@ unsigned long f2fs_shrink_count(struct shrinker *shrink,
 		}
 		spin_unlock(&f2fs_list_lock);
 
-		/* count extent cache entries */
-		count += __count_extent_cache(sbi);
+		/* count read extent cache entries */
+		count += __count_extent_cache(sbi, EX_READ);
 
 		/* count clean nat cache entries */
 		count += __count_nat_entries(sbi);
@@ -99,8 +102,8 @@ unsigned long f2fs_shrink_scan(struct shrinker *shrink,
 
 		sbi->shrinker_run_no = run_no;
 
-		/* shrink extent cache entries */
-		freed += f2fs_shrink_extent_tree(sbi, nr >> 1);
+		/* shrink read extent cache entries */
+		freed += f2fs_shrink_read_extent_tree(sbi, nr >> 1);
 
 		/* shrink clean nat cache entries */
 		if (freed < nr)
@@ -130,7 +133,7 @@ void f2fs_join_shrinker(struct f2fs_sb_info *sbi)
 
 void f2fs_leave_shrinker(struct f2fs_sb_info *sbi)
 {
-	f2fs_shrink_extent_tree(sbi, __count_extent_cache(sbi));
+	f2fs_shrink_read_extent_tree(sbi, __count_extent_cache(sbi, EX_READ));
 
 	spin_lock(&f2fs_list_lock);
 	list_del_init(&sbi->s_list);
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 5af05411818a..c46533d65372 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -810,10 +810,10 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
 			set_opt(sbi, FASTBOOT);
 			break;
 		case Opt_extent_cache:
-			set_opt(sbi, EXTENT_CACHE);
+			set_opt(sbi, READ_EXTENT_CACHE);
 			break;
 		case Opt_noextent_cache:
-			clear_opt(sbi, EXTENT_CACHE);
+			clear_opt(sbi, READ_EXTENT_CACHE);
 			break;
 		case Opt_noinline_data:
 			clear_opt(sbi, INLINE_DATA);
@@ -1939,7 +1939,7 @@ static int f2fs_show_options(struct seq_file *seq, struct dentry *root)
 		seq_puts(seq, ",nobarrier");
 	if (test_opt(sbi, FASTBOOT))
 		seq_puts(seq, ",fastboot");
-	if (test_opt(sbi, EXTENT_CACHE))
+	if (test_opt(sbi, READ_EXTENT_CACHE))
 		seq_puts(seq, ",extent_cache");
 	else
 		seq_puts(seq, ",noextent_cache");
@@ -2057,7 +2057,7 @@ static void default_options(struct f2fs_sb_info *sbi)
 	set_opt(sbi, INLINE_XATTR);
 	set_opt(sbi, INLINE_DATA);
 	set_opt(sbi, INLINE_DENTRY);
-	set_opt(sbi, EXTENT_CACHE);
+	set_opt(sbi, READ_EXTENT_CACHE);
 	set_opt(sbi, NOHEAP);
 	clear_opt(sbi, DISABLE_CHECKPOINT);
 	set_opt(sbi, MERGE_CHECKPOINT);
@@ -2198,7 +2198,7 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
 	bool need_restart_ckpt = false, need_stop_ckpt = false;
 	bool need_restart_flush = false, need_stop_flush = false;
 	bool need_restart_discard = false, need_stop_discard = false;
-	bool no_extent_cache = !test_opt(sbi, EXTENT_CACHE);
+	bool no_read_extent_cache = !test_opt(sbi, READ_EXTENT_CACHE);
 	bool enable_checkpoint = !test_opt(sbi, DISABLE_CHECKPOINT);
 	bool no_io_align = !F2FS_IO_ALIGNED(sbi);
 	bool no_atgc = !test_opt(sbi, ATGC);
@@ -2288,7 +2288,7 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
 	}
 
 	/* disallow enable/disable extent_cache dynamically */
-	if (no_extent_cache == !!test_opt(sbi, EXTENT_CACHE)) {
+	if (no_read_extent_cache == !!test_opt(sbi, READ_EXTENT_CACHE)) {
 		err = -EINVAL;
 		f2fs_warn(sbi, "switch extent_cache option is not allowed");
 		goto restore_opts;
diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index aa33c39be182..d387708977a5 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -827,7 +827,7 @@ void wbc_detach_inode(struct writeback_control *wbc)
 		 * is okay.  The main goal is avoiding keeping an inode on
 		 * the wrong wb for an extended period of time.
 		 */
-		if (hweight32(history) > WB_FRN_HIST_THR_SLOTS)
+		if (hweight16(history) > WB_FRN_HIST_THR_SLOTS)
 			inode_switch_wbs(inode, max_id);
 	}
 
diff --git a/fs/ksmbd/connection.c b/fs/ksmbd/connection.c
index b8f9d627f241..e3312fbf4c09 100644
--- a/fs/ksmbd/connection.c
+++ b/fs/ksmbd/connection.c
@@ -20,7 +20,7 @@ static DEFINE_MUTEX(init_lock);
 static struct ksmbd_conn_ops default_conn_ops;
 
 LIST_HEAD(conn_list);
-DEFINE_RWLOCK(conn_list_lock);
+DECLARE_RWSEM(conn_list_lock);
 
 /**
  * ksmbd_conn_free() - free resources of the connection instance
@@ -32,9 +32,9 @@ DEFINE_RWLOCK(conn_list_lock);
  */
 void ksmbd_conn_free(struct ksmbd_conn *conn)
 {
-	write_lock(&conn_list_lock);
+	down_write(&conn_list_lock);
 	list_del(&conn->conns_list);
-	write_unlock(&conn_list_lock);
+	up_write(&conn_list_lock);
 
 	xa_destroy(&conn->sessions);
 	kvfree(conn->request_buf);
@@ -56,7 +56,7 @@ struct ksmbd_conn *ksmbd_conn_alloc(void)
 		return NULL;
 
 	conn->need_neg = true;
-	conn->status = KSMBD_SESS_NEW;
+	ksmbd_conn_set_new(conn);
 	conn->local_nls = load_nls("utf8");
 	if (!conn->local_nls)
 		conn->local_nls = load_nls_default();
@@ -84,9 +84,9 @@ struct ksmbd_conn *ksmbd_conn_alloc(void)
 	spin_lock_init(&conn->llist_lock);
 	INIT_LIST_HEAD(&conn->lock_list);
 
-	write_lock(&conn_list_lock);
+	down_write(&conn_list_lock);
 	list_add(&conn->conns_list, &conn_list);
-	write_unlock(&conn_list_lock);
+	up_write(&conn_list_lock);
 	return conn;
 }
 
@@ -95,7 +95,7 @@ bool ksmbd_conn_lookup_dialect(struct ksmbd_conn *c)
 	struct ksmbd_conn *t;
 	bool ret = false;
 
-	read_lock(&conn_list_lock);
+	down_read(&conn_list_lock);
 	list_for_each_entry(t, &conn_list, conns_list) {
 		if (memcmp(t->ClientGUID, c->ClientGUID, SMB2_CLIENT_GUID_SIZE))
 			continue;
@@ -103,7 +103,7 @@ bool ksmbd_conn_lookup_dialect(struct ksmbd_conn *c)
 		ret = true;
 		break;
 	}
-	read_unlock(&conn_list_lock);
+	up_read(&conn_list_lock);
 	return ret;
 }
 
@@ -149,19 +149,47 @@ int ksmbd_conn_try_dequeue_request(struct ksmbd_work *work)
 	return ret;
 }
 
-static void ksmbd_conn_lock(struct ksmbd_conn *conn)
+void ksmbd_conn_lock(struct ksmbd_conn *conn)
 {
 	mutex_lock(&conn->srv_mutex);
 }
 
-static void ksmbd_conn_unlock(struct ksmbd_conn *conn)
+void ksmbd_conn_unlock(struct ksmbd_conn *conn)
 {
 	mutex_unlock(&conn->srv_mutex);
 }
 
-void ksmbd_conn_wait_idle(struct ksmbd_conn *conn)
+void ksmbd_all_conn_set_status(u64 sess_id, u32 status)
 {
+	struct ksmbd_conn *conn;
+
+	down_read(&conn_list_lock);
+	list_for_each_entry(conn, &conn_list, conns_list) {
+		if (conn->binding || xa_load(&conn->sessions, sess_id))
+			WRITE_ONCE(conn->status, status);
+	}
+	up_read(&conn_list_lock);
+}
+
+void ksmbd_conn_wait_idle(struct ksmbd_conn *conn, u64 sess_id)
+{
+	struct ksmbd_conn *bind_conn;
+
 	wait_event(conn->req_running_q, atomic_read(&conn->req_running) < 2);
+
+	down_read(&conn_list_lock);
+	list_for_each_entry(bind_conn, &conn_list, conns_list) {
+		if (bind_conn == conn)
+			continue;
+
+		if ((bind_conn->binding || xa_load(&bind_conn->sessions, sess_id)) &&
+		    !ksmbd_conn_releasing(bind_conn) &&
+		    atomic_read(&bind_conn->req_running)) {
+			wait_event(bind_conn->req_running_q,
+				atomic_read(&bind_conn->req_running) == 0);
+		}
+	}
+	up_read(&conn_list_lock);
 }
 
 int ksmbd_conn_write(struct ksmbd_work *work)
@@ -245,7 +273,7 @@ bool ksmbd_conn_alive(struct ksmbd_conn *conn)
 	if (!ksmbd_server_running())
 		return false;
 
-	if (conn->status == KSMBD_SESS_EXITING)
+	if (ksmbd_conn_exiting(conn))
 		return false;
 
 	if (kthread_should_stop())
@@ -305,7 +333,7 @@ int ksmbd_conn_handler_loop(void *p)
 		pdu_size = get_rfc1002_len(hdr_buf);
 		ksmbd_debug(CONN, "RFC1002 header %u bytes\n", pdu_size);
 
-		if (conn->status == KSMBD_SESS_GOOD)
+		if (ksmbd_conn_good(conn))
 			max_allowed_pdu_size =
 				SMB3_MAX_MSGSIZE + conn->vals->max_write_size;
 		else
@@ -314,7 +342,7 @@ int ksmbd_conn_handler_loop(void *p)
 		if (pdu_size > max_allowed_pdu_size) {
 			pr_err_ratelimited("PDU length(%u) excceed maximum allowed pdu size(%u) on connection(%d)\n",
 					pdu_size, max_allowed_pdu_size,
-					conn->status);
+					READ_ONCE(conn->status));
 			break;
 		}
 
@@ -362,10 +390,10 @@ int ksmbd_conn_handler_loop(void *p)
 	}
 
 out:
+	ksmbd_conn_set_releasing(conn);
 	/* Wait till all reference dropped to the Server object*/
 	wait_event(conn->r_count_q, atomic_read(&conn->r_count) == 0);
 
-
 	if (IS_ENABLED(CONFIG_UNICODE))
 		utf8_unload(conn->um);
 	unload_nls(conn->local_nls);
@@ -409,7 +437,7 @@ static void stop_sessions(void)
 	struct ksmbd_transport *t;
 
 again:
-	read_lock(&conn_list_lock);
+	down_read(&conn_list_lock);
 	list_for_each_entry(conn, &conn_list, conns_list) {
 		struct task_struct *task;
 
@@ -418,14 +446,14 @@ static void stop_sessions(void)
 		if (task)
 			ksmbd_debug(CONN, "Stop session handler %s/%d\n",
 				    task->comm, task_pid_nr(task));
-		conn->status = KSMBD_SESS_EXITING;
+		ksmbd_conn_set_exiting(conn);
 		if (t->ops->shutdown) {
-			read_unlock(&conn_list_lock);
+			up_read(&conn_list_lock);
 			t->ops->shutdown(t);
-			read_lock(&conn_list_lock);
+			down_read(&conn_list_lock);
 		}
 	}
-	read_unlock(&conn_list_lock);
+	up_read(&conn_list_lock);
 
 	if (!list_empty(&conn_list)) {
 		schedule_timeout_interruptible(HZ / 10); /* 100ms */
diff --git a/fs/ksmbd/connection.h b/fs/ksmbd/connection.h
index 0e3a848defaf..ad8dfaa48ffb 100644
--- a/fs/ksmbd/connection.h
+++ b/fs/ksmbd/connection.h
@@ -26,7 +26,8 @@ enum {
 	KSMBD_SESS_GOOD,
 	KSMBD_SESS_EXITING,
 	KSMBD_SESS_NEED_RECONNECT,
-	KSMBD_SESS_NEED_NEGOTIATE
+	KSMBD_SESS_NEED_NEGOTIATE,
+	KSMBD_SESS_RELEASING
 };
 
 struct ksmbd_stats {
@@ -140,10 +141,10 @@ struct ksmbd_transport {
 #define KSMBD_TCP_PEER_SOCKADDR(c)	((struct sockaddr *)&((c)->peer_addr))
 
 extern struct list_head conn_list;
-extern rwlock_t conn_list_lock;
+extern struct rw_semaphore conn_list_lock;
 
 bool ksmbd_conn_alive(struct ksmbd_conn *conn);
-void ksmbd_conn_wait_idle(struct ksmbd_conn *conn);
+void ksmbd_conn_wait_idle(struct ksmbd_conn *conn, u64 sess_id);
 struct ksmbd_conn *ksmbd_conn_alloc(void);
 void ksmbd_conn_free(struct ksmbd_conn *conn);
 bool ksmbd_conn_lookup_dialect(struct ksmbd_conn *c);
@@ -162,6 +163,8 @@ void ksmbd_conn_init_server_callbacks(struct ksmbd_conn_ops *ops);
 int ksmbd_conn_handler_loop(void *p);
 int ksmbd_conn_transport_init(void);
 void ksmbd_conn_transport_destroy(void);
+void ksmbd_conn_lock(struct ksmbd_conn *conn);
+void ksmbd_conn_unlock(struct ksmbd_conn *conn);
 
 /*
  * WARNING
@@ -169,43 +172,60 @@ void ksmbd_conn_transport_destroy(void);
  * This is a hack. We will move status to a proper place once we land
  * a multi-sessions support.
  */
-static inline bool ksmbd_conn_good(struct ksmbd_work *work)
+static inline bool ksmbd_conn_good(struct ksmbd_conn *conn)
 {
-	return work->conn->status == KSMBD_SESS_GOOD;
+	return READ_ONCE(conn->status) == KSMBD_SESS_GOOD;
 }
 
-static inline bool ksmbd_conn_need_negotiate(struct ksmbd_work *work)
+static inline bool ksmbd_conn_need_negotiate(struct ksmbd_conn *conn)
 {
-	return work->conn->status == KSMBD_SESS_NEED_NEGOTIATE;
+	return READ_ONCE(conn->status) == KSMBD_SESS_NEED_NEGOTIATE;
 }
 
-static inline bool ksmbd_conn_need_reconnect(struct ksmbd_work *work)
+static inline bool ksmbd_conn_need_reconnect(struct ksmbd_conn *conn)
 {
-	return work->conn->status == KSMBD_SESS_NEED_RECONNECT;
+	return READ_ONCE(conn->status) == KSMBD_SESS_NEED_RECONNECT;
 }
 
-static inline bool ksmbd_conn_exiting(struct ksmbd_work *work)
+static inline bool ksmbd_conn_exiting(struct ksmbd_conn *conn)
 {
-	return work->conn->status == KSMBD_SESS_EXITING;
+	return READ_ONCE(conn->status) == KSMBD_SESS_EXITING;
 }
 
-static inline void ksmbd_conn_set_good(struct ksmbd_work *work)
+static inline bool ksmbd_conn_releasing(struct ksmbd_conn *conn)
 {
-	work->conn->status = KSMBD_SESS_GOOD;
+	return READ_ONCE(conn->status) == KSMBD_SESS_RELEASING;
 }
 
-static inline void ksmbd_conn_set_need_negotiate(struct ksmbd_work *work)
+static inline void ksmbd_conn_set_new(struct ksmbd_conn *conn)
 {
-	work->conn->status = KSMBD_SESS_NEED_NEGOTIATE;
+	WRITE_ONCE(conn->status, KSMBD_SESS_NEW);
 }
 
-static inline void ksmbd_conn_set_need_reconnect(struct ksmbd_work *work)
+static inline void ksmbd_conn_set_good(struct ksmbd_conn *conn)
 {
-	work->conn->status = KSMBD_SESS_NEED_RECONNECT;
+	WRITE_ONCE(conn->status, KSMBD_SESS_GOOD);
 }
 
-static inline void ksmbd_conn_set_exiting(struct ksmbd_work *work)
+static inline void ksmbd_conn_set_need_negotiate(struct ksmbd_conn *conn)
 {
-	work->conn->status = KSMBD_SESS_EXITING;
+	WRITE_ONCE(conn->status, KSMBD_SESS_NEED_NEGOTIATE);
 }
+
+static inline void ksmbd_conn_set_need_reconnect(struct ksmbd_conn *conn)
+{
+	WRITE_ONCE(conn->status, KSMBD_SESS_NEED_RECONNECT);
+}
+
+static inline void ksmbd_conn_set_exiting(struct ksmbd_conn *conn)
+{
+	WRITE_ONCE(conn->status, KSMBD_SESS_EXITING);
+}
+
+static inline void ksmbd_conn_set_releasing(struct ksmbd_conn *conn)
+{
+	WRITE_ONCE(conn->status, KSMBD_SESS_RELEASING);
+}
+
+void ksmbd_all_conn_set_status(u64 sess_id, u32 status);
 #endif /* __CONNECTION_H__ */
diff --git a/fs/ksmbd/mgmt/tree_connect.c b/fs/ksmbd/mgmt/tree_connect.c
index f19de20c2960..f07a05f37651 100644
--- a/fs/ksmbd/mgmt/tree_connect.c
+++ b/fs/ksmbd/mgmt/tree_connect.c
@@ -137,6 +137,9 @@ int ksmbd_tree_conn_session_logoff(struct ksmbd_session *sess)
 	struct ksmbd_tree_connect *tc;
 	unsigned long id;
 
+	if (!sess)
+		return -EINVAL;
+
 	xa_for_each(&sess->tree_conns, id, tc)
 		ret |= ksmbd_tree_conn_disconnect(sess, tc);
 	xa_destroy(&sess->tree_conns);
diff --git a/fs/ksmbd/mgmt/user_session.c b/fs/ksmbd/mgmt/user_session.c
index 92b1603b5abe..ea4b56d570fb 100644
--- a/fs/ksmbd/mgmt/user_session.c
+++ b/fs/ksmbd/mgmt/user_session.c
@@ -30,15 +30,15 @@ struct ksmbd_session_rpc {
 
 static void free_channel_list(struct ksmbd_session *sess)
 {
-	struct channel *chann, *tmp;
+	struct channel *chann;
+	unsigned long index;
 
-	write_lock(&sess->chann_lock);
-	list_for_each_entry_safe(chann, tmp, &sess->ksmbd_chann_list,
-				 chann_list) {
-		list_del(&chann->chann_list);
+	xa_for_each(&sess->ksmbd_chann_list, index, chann) {
+		xa_erase(&sess->ksmbd_chann_list, index);
 		kfree(chann);
 	}
-	write_unlock(&sess->chann_lock);
+
+	xa_destroy(&sess->ksmbd_chann_list);
 }
 
 static void __session_rpc_close(struct ksmbd_session *sess,
@@ -153,10 +153,6 @@ void ksmbd_session_destroy(struct ksmbd_session *sess)
 	if (!sess)
 		return;
 
-	down_write(&sessions_table_lock);
-	hash_del(&sess->hlist);
-	up_write(&sessions_table_lock);
-
 	if (sess->user)
 		ksmbd_free_user(sess->user);
 
@@ -174,76 +170,101 @@ static struct ksmbd_session *__session_lookup(unsigned long long id)
 	struct ksmbd_session *sess;
 
 	hash_for_each_possible(sessions_table, sess, hlist, id) {
-		if (id == sess->id)
+		if (id == sess->id) {
+			sess->last_active = jiffies;
 			return sess;
+		}
 	}
 	return NULL;
 }
 
+static void ksmbd_expire_session(struct ksmbd_conn *conn)
+{
+	unsigned long id;
+	struct ksmbd_session *sess;
+
+	down_write(&sessions_table_lock);
+	xa_for_each(&conn->sessions, id, sess) {
+		if (sess->state != SMB2_SESSION_VALID ||
+		    time_after(jiffies,
+			       sess->last_active + SMB2_SESSION_TIMEOUT)) {
+			xa_erase(&conn->sessions, sess->id);
+			hash_del(&sess->hlist);
+			ksmbd_session_destroy(sess);
+			continue;
+		}
+	}
+	up_write(&sessions_table_lock);
+}
+
 int ksmbd_session_register(struct ksmbd_conn *conn,
 			   struct ksmbd_session *sess)
 {
 	sess->dialect = conn->dialect;
 	memcpy(sess->ClientGUID, conn->ClientGUID, SMB2_CLIENT_GUID_SIZE);
+	ksmbd_expire_session(conn);
 	return xa_err(xa_store(&conn->sessions, sess->id, sess, GFP_KERNEL));
 }
 
 static int ksmbd_chann_del(struct ksmbd_conn *conn, struct ksmbd_session *sess)
 {
-	struct channel *chann, *tmp;
-
-	write_lock(&sess->chann_lock);
-	list_for_each_entry_safe(chann, tmp, &sess->ksmbd_chann_list,
-				 chann_list) {
-		if (chann->conn == conn) {
-			list_del(&chann->chann_list);
-			kfree(chann);
-			write_unlock(&sess->chann_lock);
-			return 0;
-		}
-	}
-	write_unlock(&sess->chann_lock);
+	struct channel *chann;
 
-	return -ENOENT;
+	chann = xa_erase(&sess->ksmbd_chann_list, (long)conn);
+	if (!chann)
+		return -ENOENT;
+
+	kfree(chann);
+	return 0;
 }
 
 void ksmbd_sessions_deregister(struct ksmbd_conn *conn)
 {
 	struct ksmbd_session *sess;
+	unsigned long id;
 
+	down_write(&sessions_table_lock);
 	if (conn->binding) {
 		int bkt;
+		struct hlist_node *tmp;
 
-		down_write(&sessions_table_lock);
-		hash_for_each(sessions_table, bkt, sess, hlist) {
-			if (!ksmbd_chann_del(conn, sess)) {
-				up_write(&sessions_table_lock);
-				goto sess_destroy;
+		hash_for_each_safe(sessions_table, bkt, tmp, sess, hlist) {
+			if (!ksmbd_chann_del(conn, sess) &&
+			    xa_empty(&sess->ksmbd_chann_list)) {
+				hash_del(&sess->hlist);
+				ksmbd_session_destroy(sess);
 			}
 		}
-		up_write(&sessions_table_lock);
-	} else {
-		unsigned long id;
-
-		xa_for_each(&conn->sessions, id, sess) {
-			if (!ksmbd_chann_del(conn, sess))
-				goto sess_destroy;
-		}
 	}
 
-	return;
+	xa_for_each(&conn->sessions, id, sess) {
+		unsigned long chann_id;
+		struct channel *chann;
+
+		xa_for_each(&sess->ksmbd_chann_list, chann_id, chann) {
+			if (chann->conn != conn)
+				ksmbd_conn_set_exiting(chann->conn);
+		}
 
-sess_destroy:
-	if (list_empty(&sess->ksmbd_chann_list)) {
-		xa_erase(&conn->sessions, sess->id);
-		ksmbd_session_destroy(sess);
+		ksmbd_chann_del(conn, sess);
+		if (xa_empty(&sess->ksmbd_chann_list)) {
+			xa_erase(&conn->sessions, sess->id);
+			hash_del(&sess->hlist);
+			ksmbd_session_destroy(sess);
+		}
 	}
+	up_write(&sessions_table_lock);
 }
 
 struct ksmbd_session *ksmbd_session_lookup(struct ksmbd_conn *conn,
 					   unsigned long long id)
 {
-	return xa_load(&conn->sessions, id);
+	struct ksmbd_session *sess;
+
+	sess = xa_load(&conn->sessions, id);
+	if (sess)
+		sess->last_active = jiffies;
+	return sess;
 }
 
 struct ksmbd_session *ksmbd_session_lookup_slowpath(unsigned long long id)
@@ -252,6 +273,8 @@ struct ksmbd_session *ksmbd_session_lookup_slowpath(unsigned long long id)
 
 	down_read(&sessions_table_lock);
 	sess = __session_lookup(id);
+	if (sess)
+		sess->last_active = jiffies;
 	up_read(&sessions_table_lock);
 
 	return sess;
@@ -320,6 +343,9 @@ static struct ksmbd_session *__session_create(int protocol)
 	struct ksmbd_session *sess;
 	int ret;
 
+	if (protocol != CIFDS_SESSION_FLAG_SMB2)
+		return NULL;
+
 	sess = kzalloc(sizeof(struct ksmbd_session), GFP_KERNEL);
 	if (!sess)
 		return NULL;
@@ -327,32 +353,24 @@ static struct ksmbd_session *__session_create(int protocol)
 	if (ksmbd_init_file_table(&sess->file_table))
 		goto error;
 
+	sess->last_active = jiffies;
+	sess->state = SMB2_SESSION_IN_PROGRESS;
 	set_session_flag(sess, protocol);
 	xa_init(&sess->tree_conns);
-	INIT_LIST_HEAD(&sess->ksmbd_chann_list);
+	xa_init(&sess->ksmbd_chann_list);
 	INIT_LIST_HEAD(&sess->rpc_handle_list);
 	sess->sequence_number = 1;
-	rwlock_init(&sess->chann_lock);
-
-	switch (protocol) {
-	case CIFDS_SESSION_FLAG_SMB2:
-		ret = __init_smb2_session(sess);
-		break;
-	default:
-		ret = -EINVAL;
-		break;
-	}
 
+	ret = __init_smb2_session(sess);
 	if (ret)
 		goto error;
 
 	ida_init(&sess->tree_conn_ida);
 
-	if (protocol == CIFDS_SESSION_FLAG_SMB2) {
-		down_write(&sessions_table_lock);
-		hash_add(sessions_table, &sess->hlist, sess->id);
-		up_write(&sessions_table_lock);
-	}
+	down_write(&sessions_table_lock);
+	hash_add(sessions_table, &sess->hlist, sess->id);
+	up_write(&sessions_table_lock);
+
 	return sess;
 
 error:
diff --git a/fs/ksmbd/mgmt/user_session.h b/fs/ksmbd/mgmt/user_session.h
index 8934b8ee275b..51f38e5b61ab 100644
--- a/fs/ksmbd/mgmt/user_session.h
+++ b/fs/ksmbd/mgmt/user_session.h
@@ -21,7 +21,6 @@ struct ksmbd_file_table;
 struct channel {
 	__u8			smb3signingkey[SMB3_SIGN_KEY_SIZE];
 	struct ksmbd_conn	*conn;
-	struct list_head	chann_list;
 };
 
 struct preauth_session {
@@ -50,8 +49,7 @@ struct ksmbd_session {
 	char				sess_key[CIFS_KEY_SIZE];
 
 	struct hlist_node		hlist;
-	rwlock_t			chann_lock;
-	struct list_head		ksmbd_chann_list;
+	struct xarray			ksmbd_chann_list;
 	struct xarray			tree_conns;
 	struct ida			tree_conn_ida;
 	struct list_head		rpc_handle_list;
@@ -61,6 +59,7 @@ struct ksmbd_session {
 	__u8				smb3signingkey[SMB3_SIGN_KEY_SIZE];
 
 	struct ksmbd_file_table		file_table;
+	unsigned long			last_active;
 };
 
 static inline int test_session_flag(struct ksmbd_session *sess, int bit)
diff --git a/fs/ksmbd/server.c b/fs/ksmbd/server.c
index 8c2bc513445c..8a0ad399f245 100644
--- a/fs/ksmbd/server.c
+++ b/fs/ksmbd/server.c
@@ -93,7 +93,8 @@ static inline int check_conn_state(struct ksmbd_work *work)
 {
 	struct smb_hdr *rsp_hdr;
 
-	if (ksmbd_conn_exiting(work) || ksmbd_conn_need_reconnect(work)) {
+	if (ksmbd_conn_exiting(work->conn) ||
+	    ksmbd_conn_need_reconnect(work->conn)) {
 		rsp_hdr = work->response_buf;
 		rsp_hdr->Status.CifsError = STATUS_CONNECTION_DISCONNECTED;
 		return 1;
diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index acd66fb40c5f..8f96b96dbac1 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -74,14 +74,7 @@ static inline bool check_session_id(struct ksmbd_conn *conn, u64 id)
 
 struct channel *lookup_chann_list(struct ksmbd_session *sess, struct ksmbd_conn *conn)
 {
-	struct channel *chann;
-
-	list_for_each_entry(chann, &sess->ksmbd_chann_list, chann_list) {
-		if (chann->conn == conn)
-			return chann;
-	}
-
-	return NULL;
+	return xa_load(&sess->ksmbd_chann_list, (long)conn);
 }
 
 /**
@@ -254,7 +247,7 @@ int init_smb2_neg_rsp(struct ksmbd_work *work)
 
 	rsp = smb2_get_msg(work->response_buf);
 
-	WARN_ON(ksmbd_conn_good(work));
+	WARN_ON(ksmbd_conn_good(conn));
 
 	rsp->StructureSize = cpu_to_le16(65);
 	ksmbd_debug(SMB, "conn->dialect 0x%x\n", conn->dialect);
@@ -284,7 +277,7 @@ int init_smb2_neg_rsp(struct ksmbd_work *work)
 		rsp->SecurityMode |= SMB2_NEGOTIATE_SIGNING_REQUIRED_LE;
 	conn->use_spnego = true;
 
-	ksmbd_conn_set_need_negotiate(work);
+	ksmbd_conn_set_need_negotiate(conn);
 	return 0;
 }
 
@@ -574,7 +567,7 @@ int smb2_check_user_session(struct ksmbd_work *work)
 	    cmd == SMB2_SESSION_SETUP_HE)
 		return 0;
 
-	if (!ksmbd_conn_good(work))
+	if (!ksmbd_conn_good(conn))
 		return -EINVAL;
 
 	sess_id = le64_to_cpu(req_hdr->SessionId);
@@ -592,6 +585,7 @@ static void destroy_previous_session(struct ksmbd_conn *conn,
 	struct ksmbd_session *prev_sess = ksmbd_session_lookup_slowpath(id);
 	struct ksmbd_user *prev_user;
 	struct channel *chann;
+	long index;
 
 	if (!prev_sess)
 		return;
@@ -605,10 +599,8 @@ static void destroy_previous_session(struct ksmbd_conn *conn,
 		return;
 
 	prev_sess->state = SMB2_SESSION_EXPIRED;
-	write_lock(&prev_sess->chann_lock);
-	list_for_each_entry(chann, &prev_sess->ksmbd_chann_list, chann_list)
-		chann->conn->status = KSMBD_SESS_EXITING;
-	write_unlock(&prev_sess->chann_lock);
+	xa_for_each(&prev_sess->ksmbd_chann_list, index, chann)
+		ksmbd_conn_set_exiting(chann->conn);
 }
 
 /**
@@ -1075,7 +1067,7 @@ int smb2_handle_negotiate(struct ksmbd_work *work)
 
 	ksmbd_debug(SMB, "Received negotiate request\n");
 	conn->need_neg = false;
-	if (ksmbd_conn_good(work)) {
+	if (ksmbd_conn_good(conn)) {
 		pr_err("conn->tcp_status is already in CifsGood State\n");
 		work->send_no_response = 1;
 		return rc;
@@ -1230,7 +1222,7 @@ int smb2_handle_negotiate(struct ksmbd_work *work)
 	}
 
 	conn->srv_sec_mode = le16_to_cpu(rsp->SecurityMode);
-	ksmbd_conn_set_need_negotiate(work);
+	ksmbd_conn_set_need_negotiate(conn);
 
 err_out:
 	if (rc < 0)
@@ -1520,19 +1512,14 @@ static int ntlm_authenticate(struct ksmbd_work *work)
 
 binding_session:
 	if (conn->dialect >= SMB30_PROT_ID) {
-		read_lock(&sess->chann_lock);
 		chann = lookup_chann_list(sess, conn);
-		read_unlock(&sess->chann_lock);
 		if (!chann) {
 			chann = kmalloc(sizeof(struct channel), GFP_KERNEL);
 			if (!chann)
 				return -ENOMEM;
 
 			chann->conn = conn;
-			INIT_LIST_HEAD(&chann->chann_list);
-			write_lock(&sess->chann_lock);
-			list_add(&chann->chann_list, &sess->ksmbd_chann_list);
-			write_unlock(&sess->chann_lock);
+			xa_store(&sess->ksmbd_chann_list, (long)conn, chann, GFP_KERNEL);
 		}
 	}
 
@@ -1606,19 +1593,14 @@ static int krb5_authenticate(struct ksmbd_work *work)
 	}
 
 	if (conn->dialect >= SMB30_PROT_ID) {
-		read_lock(&sess->chann_lock);
 		chann = lookup_chann_list(sess, conn);
-		read_unlock(&sess->chann_lock);
 		if (!chann) {
 			chann = kmalloc(sizeof(struct channel), GFP_KERNEL);
 			if (!chann)
 				return -ENOMEM;
 
 			chann->conn = conn;
-			INIT_LIST_HEAD(&chann->chann_list);
-			write_lock(&sess->chann_lock);
-			list_add(&chann->chann_list, &sess->ksmbd_chann_list);
-			write_unlock(&sess->chann_lock);
+			xa_store(&sess->ksmbd_chann_list, (long)conn, chann, GFP_KERNEL);
 		}
 	}
 
@@ -1661,6 +1643,7 @@ int smb2_sess_setup(struct ksmbd_work *work)
 	rsp->SecurityBufferLength = 0;
 	inc_rfc1001_len(work->response_buf, 9);
 
+	ksmbd_conn_lock(conn);
 	if (!req->hdr.SessionId) {
 		sess = ksmbd_smb2_session_create();
 		if (!sess) {
@@ -1708,6 +1691,12 @@ int smb2_sess_setup(struct ksmbd_work *work)
 			goto out_err;
 		}
 
+		if (ksmbd_conn_need_reconnect(conn)) {
+			rc = -EFAULT;
+			sess = NULL;
+			goto out_err;
+		}
+
 		if (ksmbd_session_lookup(conn, sess_id)) {
 			rc = -EACCES;
 			goto out_err;
@@ -1732,12 +1721,20 @@ int smb2_sess_setup(struct ksmbd_work *work)
 			rc = -ENOENT;
 			goto out_err;
 		}
+
+		if (sess->state == SMB2_SESSION_EXPIRED) {
+			rc = -EFAULT;
+			goto out_err;
+		}
+
+		if (ksmbd_conn_need_reconnect(conn)) {
+			rc = -EFAULT;
+			sess = NULL;
+			goto out_err;
+		}
 	}
 	work->sess = sess;
 
-	if (sess->state == SMB2_SESSION_EXPIRED)
-		sess->state = SMB2_SESSION_IN_PROGRESS;
-
 	negblob_off = le16_to_cpu(req->SecurityBufferOffset);
 	negblob_len = le16_to_cpu(req->SecurityBufferLength);
 	if (negblob_off < offsetof(struct smb2_sess_setup_req, Buffer) ||
@@ -1767,8 +1764,10 @@ int smb2_sess_setup(struct ksmbd_work *work)
 				goto out_err;
 			}
 
-			ksmbd_conn_set_good(work);
-			sess->state = SMB2_SESSION_VALID;
+			if (!ksmbd_conn_need_reconnect(conn)) {
+				ksmbd_conn_set_good(conn);
+				sess->state = SMB2_SESSION_VALID;
+			}
 			kfree(sess->Preauth_HashValue);
 			sess->Preauth_HashValue = NULL;
 		} else if (conn->preferred_auth_mech == KSMBD_AUTH_NTLMSSP) {
@@ -1790,8 +1789,10 @@ int smb2_sess_setup(struct ksmbd_work *work)
 				if (rc)
 					goto out_err;
 
-				ksmbd_conn_set_good(work);
-				sess->state = SMB2_SESSION_VALID;
+				if (!ksmbd_conn_need_reconnect(conn)) {
+					ksmbd_conn_set_good(conn);
+					sess->state = SMB2_SESSION_VALID;
+				}
 				if (conn->binding) {
 					struct preauth_session *preauth_sess;
 
@@ -1859,14 +1860,17 @@ int smb2_sess_setup(struct ksmbd_work *work)
 			if (sess->user && sess->user->flags & KSMBD_USER_FLAG_DELAY_SESSION)
 				try_delay = true;
 
-			xa_erase(&conn->sessions, sess->id);
-			ksmbd_session_destroy(sess);
-			work->sess = NULL;
-			if (try_delay)
+			sess->last_active = jiffies;
+			sess->state = SMB2_SESSION_EXPIRED;
+			if (try_delay) {
+				ksmbd_conn_set_need_reconnect(conn);
 				ssleep(5);
+				ksmbd_conn_set_need_negotiate(conn);
+			}
 		}
 	}
 
+	ksmbd_conn_unlock(conn);
 	return rc;
 }
 
@@ -2091,21 +2095,25 @@ int smb2_session_logoff(struct ksmbd_work *work)
 {
 	struct ksmbd_conn *conn = work->conn;
 	struct smb2_logoff_rsp *rsp = smb2_get_msg(work->response_buf);
-	struct ksmbd_session *sess = work->sess;
+	struct ksmbd_session *sess;
+	struct smb2_logoff_req *req = smb2_get_msg(work->request_buf);
+	u64 sess_id = le64_to_cpu(req->hdr.SessionId);
 
 	rsp->StructureSize = cpu_to_le16(4);
 	inc_rfc1001_len(work->response_buf, 4);
 
 	ksmbd_debug(SMB, "request\n");
 
-	/* setting CifsExiting here may race with start_tcp_sess */
-	ksmbd_conn_set_need_reconnect(work);
+	ksmbd_all_conn_set_status(sess_id, KSMBD_SESS_NEED_RECONNECT);
 	ksmbd_close_session_fds(work);
-	ksmbd_conn_wait_idle(conn);
+	ksmbd_conn_wait_idle(conn, sess_id);
 
+	/*
+	 * Re-lookup session to validate if session is deleted
+	 * while waiting request complete
+	 */
+	sess = ksmbd_session_lookup_all(conn, sess_id);
 	if (ksmbd_tree_conn_session_logoff(sess)) {
-		struct smb2_logoff_req *req = smb2_get_msg(work->request_buf);
-
 		ksmbd_debug(SMB, "Invalid tid %d\n", req->hdr.Id.SyncId.TreeId);
 		rsp->hdr.Status = STATUS_NETWORK_NAME_DELETED;
 		smb2_set_err_rsp(work);
@@ -2117,9 +2125,7 @@ int smb2_session_logoff(struct ksmbd_work *work)
 
 	ksmbd_free_user(sess->user);
 	sess->user = NULL;
-
-	/* let start_tcp_sess free connection info now */
-	ksmbd_conn_set_need_negotiate(work);
+	ksmbd_all_conn_set_status(sess_id, KSMBD_SESS_NEED_NEGOTIATE);
 	return 0;
 }
 
@@ -6947,7 +6953,7 @@ int smb2_lock(struct ksmbd_work *work)
 
 		nolock = 1;
 		/* check locks in connection list */
-		read_lock(&conn_list_lock);
+		down_read(&conn_list_lock);
 		list_for_each_entry(conn, &conn_list, conns_list) {
 			spin_lock(&conn->llist_lock);
 			list_for_each_entry_safe(cmp_lock, tmp2, &conn->lock_list, clist) {
@@ -6964,7 +6970,7 @@ int smb2_lock(struct ksmbd_work *work)
 						list_del(&cmp_lock->flist);
 						list_del(&cmp_lock->clist);
 						spin_unlock(&conn->llist_lock);
-						read_unlock(&conn_list_lock);
+						up_read(&conn_list_lock);
 
 						locks_free_lock(cmp_lock->fl);
 						kfree(cmp_lock);
@@ -6986,7 +6992,7 @@ int smb2_lock(struct ksmbd_work *work)
 				    cmp_lock->start > smb_lock->start &&
 				    cmp_lock->start < smb_lock->end) {
 					spin_unlock(&conn->llist_lock);
-					read_unlock(&conn_list_lock);
+					up_read(&conn_list_lock);
 					pr_err("previous lock conflict with zero byte lock range\n");
 					goto out;
 				}
@@ -6995,7 +7001,7 @@ int smb2_lock(struct ksmbd_work *work)
 				    smb_lock->start > cmp_lock->start &&
 				    smb_lock->start < cmp_lock->end) {
 					spin_unlock(&conn->llist_lock);
-					read_unlock(&conn_list_lock);
+					up_read(&conn_list_lock);
 					pr_err("current lock conflict with zero byte lock range\n");
 					goto out;
 				}
@@ -7006,14 +7012,14 @@ int smb2_lock(struct ksmbd_work *work)
 				      cmp_lock->end >= smb_lock->end)) &&
 				    !cmp_lock->zero_len && !smb_lock->zero_len) {
 					spin_unlock(&conn->llist_lock);
-					read_unlock(&conn_list_lock);
+					up_read(&conn_list_lock);
 					pr_err("Not allow lock operation on exclusive lock range\n");
 					goto out;
 				}
 			}
 			spin_unlock(&conn->llist_lock);
 		}
-		read_unlock(&conn_list_lock);
+		up_read(&conn_list_lock);
 out_check_cl:
 		if (smb_lock->fl->fl_type == F_UNLCK && nolock) {
 			pr_err("Try to unlock nolocked range\n");
@@ -8428,14 +8434,11 @@ int smb3_check_sign_req(struct ksmbd_work *work)
 	if (le16_to_cpu(hdr->Command) == SMB2_SESSION_SETUP_HE) {
 		signing_key = work->sess->smb3signingkey;
 	} else {
-		read_lock(&work->sess->chann_lock);
 		chann = lookup_chann_list(work->sess, conn);
 		if (!chann) {
-			read_unlock(&work->sess->chann_lock);
 			return 0;
 		}
 		signing_key = chann->smb3signingkey;
-		read_unlock(&work->sess->chann_lock);
 	}
 
 	if (!signing_key) {
@@ -8495,14 +8498,11 @@ void smb3_set_sign_rsp(struct ksmbd_work *work)
 	    le16_to_cpu(hdr->Command) == SMB2_SESSION_SETUP_HE) {
 		signing_key = work->sess->smb3signingkey;
 	} else {
-		read_lock(&work->sess->chann_lock);
 		chann = lookup_chann_list(work->sess, work->conn);
 		if (!chann) {
-			read_unlock(&work->sess->chann_lock);
 			return;
 		}
 		signing_key = chann->smb3signingkey;
-		read_unlock(&work->sess->chann_lock);
 	}
 
 	if (!signing_key)
diff --git a/fs/ksmbd/smb2pdu.h b/fs/ksmbd/smb2pdu.h
index f4baa9800f6e..dd10f8031606 100644
--- a/fs/ksmbd/smb2pdu.h
+++ b/fs/ksmbd/smb2pdu.h
@@ -61,6 +61,8 @@ struct preauth_integrity_info {
 #define SMB2_SESSION_IN_PROGRESS	BIT(0)
 #define SMB2_SESSION_VALID		BIT(1)
 
+#define SMB2_SESSION_TIMEOUT		(10 * HZ)
+
 struct create_durable_req_v2 {
 	struct create_context ccontext;
 	__u8   Name[8];
diff --git a/fs/ksmbd/transport_tcp.c b/fs/ksmbd/transport_tcp.c
index 20e85e2701f2..eff7a1d793f0 100644
--- a/fs/ksmbd/transport_tcp.c
+++ b/fs/ksmbd/transport_tcp.c
@@ -333,7 +333,7 @@ static int ksmbd_tcp_readv(struct tcp_transport *t, struct kvec *iov_orig,
 		if (length == -EINTR) {
 			total_read = -ESHUTDOWN;
 			break;
-		} else if (conn->status == KSMBD_SESS_NEED_RECONNECT) {
+		} else if (ksmbd_conn_need_reconnect(conn)) {
 			total_read = -EAGAIN;
 			break;
 		} else if (length == -ERESTARTSYS || length == -EAGAIN) {
diff --git a/fs/notify/inotify/inotify_fsnotify.c b/fs/notify/inotify/inotify_fsnotify.c
index 49cfe2ae6d23..993375f0db67 100644
--- a/fs/notify/inotify/inotify_fsnotify.c
+++ b/fs/notify/inotify/inotify_fsnotify.c
@@ -65,7 +65,7 @@ int inotify_handle_inode_event(struct fsnotify_mark *inode_mark, u32 mask,
 	struct fsnotify_event *fsn_event;
 	struct fsnotify_group *group = inode_mark->group;
 	int ret;
-	int len = 0;
+	int len = 0, wd;
 	int alloc_len = sizeof(struct inotify_event_info);
 	struct mem_cgroup *old_memcg;
 
@@ -80,6 +80,13 @@ int inotify_handle_inode_event(struct fsnotify_mark *inode_mark, u32 mask,
 	i_mark = container_of(inode_mark, struct inotify_inode_mark,
 			      fsn_mark);
 
+	/*
+	 * We can be racing with mark being detached. Don't report event with
+	 * invalid wd.
+	 */
+	wd = READ_ONCE(i_mark->wd);
+	if (wd == -1)
+		return 0;
 	/*
 	 * Whoever is interested in the event, pays for the allocation. Do not
 	 * trigger OOM killer in the target monitoring memcg as it may have
@@ -110,7 +117,7 @@ int inotify_handle_inode_event(struct fsnotify_mark *inode_mark, u32 mask,
 	fsn_event = &event->fse;
 	fsnotify_init_event(fsn_event);
 	event->mask = mask;
-	event->wd = i_mark->wd;
+	event->wd = wd;
 	event->sync_cookie = cookie;
 	event->name_len = len;
 	if (len)
diff --git a/fs/ntfs3/bitmap.c b/fs/ntfs3/bitmap.c
index 45f95c1cb258..e0cdc91d88a8 100644
--- a/fs/ntfs3/bitmap.c
+++ b/fs/ntfs3/bitmap.c
@@ -661,7 +661,8 @@ int wnd_init(struct wnd_bitmap *wnd, struct super_block *sb, size_t nbits)
 	if (!wnd->bits_last)
 		wnd->bits_last = wbits;
 
-	wnd->free_bits = kcalloc(wnd->nwnd, sizeof(u16), GFP_NOFS | __GFP_NOWARN);
+	wnd->free_bits =
+		kcalloc(wnd->nwnd, sizeof(u16), GFP_NOFS | __GFP_NOWARN);
 	if (!wnd->free_bits)
 		return -ENOMEM;
 
diff --git a/fs/ntfs3/namei.c b/fs/ntfs3/namei.c
index bc22cc321a74..a9549e73081f 100644
--- a/fs/ntfs3/namei.c
+++ b/fs/ntfs3/namei.c
@@ -86,6 +86,16 @@ static struct dentry *ntfs_lookup(struct inode *dir, struct dentry *dentry,
 		__putname(uni);
 	}
 
+	/*
+	 * Check for a null pointer
+	 * If the MFT record of ntfs inode is not a base record, inode->i_op can be NULL.
+	 * This causes null pointer dereference in d_splice_alias().
+	 */
+	if (!IS_ERR_OR_NULL(inode) && !inode->i_op) {
+		iput(inode);
+		inode = ERR_PTR(-EINVAL);
+	}
+
 	return d_splice_alias(inode, dentry);
 }
 
diff --git a/fs/ntfs3/ntfs.h b/fs/ntfs3/ntfs.h
index 9cc396b117bf..0f38d558169a 100644
--- a/fs/ntfs3/ntfs.h
+++ b/fs/ntfs3/ntfs.h
@@ -436,9 +436,6 @@ static inline u64 attr_svcn(const struct ATTRIB *attr)
 	return attr->non_res ? le64_to_cpu(attr->nres.svcn) : 0;
 }
 
-/* The size of resident attribute by its resident size. */
-#define BYTES_PER_RESIDENT(b) (0x18 + (b))
-
 static_assert(sizeof(struct ATTRIB) == 0x48);
 static_assert(sizeof(((struct ATTRIB *)NULL)->res) == 0x08);
 static_assert(sizeof(((struct ATTRIB *)NULL)->nres) == 0x38);
diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index 48f2d60bd78a..72f2b373221e 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -1281,7 +1281,10 @@ static int insert_links(struct ctl_table_header *head)
  * __register_sysctl_table - register a leaf sysctl table
  * @set: Sysctl tree to register on
  * @path: The path to the directory the sysctl table is in.
- * @table: the top-level table structure
+ * @table: the top-level table structure without any child. This table
+ * 	 should not be free'd after registration. So it should not be
+ * 	 used on stack. It can either be a global or dynamically allocated
+ * 	 by the caller and free'd later after sysctl unregistration.
  *
  * Register a sysctl table hierarchy. @table should be a filled in ctl_table
  * array. A completely 0 filled entry terminates the table.
@@ -1302,9 +1305,12 @@ static int insert_links(struct ctl_table_header *head)
  * proc_handler - the text handler routine (described below)
  *
  * extra1, extra2 - extra pointers usable by the proc handler routines
+ * XXX: we should eventually modify these to use long min / max [0]
+ * [0] https://lkml.kernel.org/87zgpte9o4.fsf@email.froward.int.ebiederm.org
  *
  * Leaf nodes in the sysctl tree will be represented by a single file
- * under /proc; non-leaf nodes will be represented by directories.
+ * under /proc; non-leaf nodes (where child is not NULL) are not allowed,
+ * sysctl_check_table() verifies this.
  *
  * There must be a proc_handler routine for any terminal nodes.
  * Several default handlers are available to cover common cases -
@@ -1346,7 +1352,7 @@ struct ctl_table_header *__register_sysctl_table(
 
 	spin_lock(&sysctl_lock);
 	dir = &set->dir;
-	/* Reference moved down the diretory tree get_subdir */
+	/* Reference moved down the directory tree get_subdir */
 	dir->header.nreg++;
 	spin_unlock(&sysctl_lock);
 
@@ -1363,6 +1369,11 @@ struct ctl_table_header *__register_sysctl_table(
 		if (namelen == 0)
 			continue;
 
+		/*
+		 * namelen ensures if name is "foo/bar/yay" only foo is
+		 * registered first. We traverse as if using mkdir -p and
+		 * return a ctl_dir for the last directory entry.
+		 */
 		dir = get_subdir(dir, name, namelen);
 		if (IS_ERR(dir))
 			goto fail;
@@ -1388,8 +1399,15 @@ struct ctl_table_header *__register_sysctl_table(
 
 /**
  * register_sysctl - register a sysctl table
- * @path: The path to the directory the sysctl table is in.
- * @table: the table structure
+ * @path: The path to the directory the sysctl table is in. If the path
+ * 	doesn't exist we will create it for you.
+ * @table: the table structure. The calller must ensure the life of the @table
+ * 	will be kept during the lifetime use of the syctl. It must not be freed
+ * 	until unregister_sysctl_table() is called with the given returned table
+ * 	with this registration. If your code is non modular then you don't need
+ * 	to call unregister_sysctl_table() and can instead use something like
+ * 	register_sysctl_init() which does not care for the result of the syctl
+ * 	registration.
  *
  * Register a sysctl table. @table should be a filled in ctl_table
  * array. A completely 0 filled entry terminates the table.
@@ -1405,8 +1423,11 @@ EXPORT_SYMBOL(register_sysctl);
 
 /**
  * __register_sysctl_init() - register sysctl table to path
- * @path: path name for sysctl base
- * @table: This is the sysctl table that needs to be registered to the path
+ * @path: path name for sysctl base. If that path doesn't exist we will create
+ * 	it for you.
+ * @table: This is the sysctl table that needs to be registered to the path.
+ * 	The caller must ensure the life of the @table will be kept during the
+ * 	lifetime use of the sysctl.
  * @table_name: The name of sysctl table, only used for log printing when
  *              registration fails
  *
@@ -1418,10 +1439,7 @@ EXPORT_SYMBOL(register_sysctl);
  * register_sysctl() failing on init are extremely low, and so for both reasons
  * this function does not return any error as it is used by initialization code.
  *
- * Context: Can only be called after your respective sysctl base path has been
- * registered. So for instance, most base directories are registered early on
- * init before init levels are processed through proc_sys_init() and
- * sysctl_init_bases().
+ * Context: if your base directory does not exist it will be created for you.
  */
 void __init __register_sysctl_init(const char *path, struct ctl_table *table,
 				 const char *table_name)
@@ -1551,6 +1569,7 @@ static int register_leaf_sysctl_tables(const char *path, char *pos,
  *
  * Register a sysctl table hierarchy. @table should be a filled in ctl_table
  * array. A completely 0 filled entry terminates the table.
+ * We are slowly deprecating this call so avoid its use.
  *
  * See __register_sysctl_table for more details.
  */
@@ -1622,6 +1641,7 @@ struct ctl_table_header *__register_sysctl_paths(
  *
  * Register a sysctl table hierarchy. @table should be a filled in ctl_table
  * array. A completely 0 filled entry terminates the table.
+ * We are slowly deprecating this caller so avoid future uses of it.
  *
  * See __register_sysctl_paths for more details.
  */
diff --git a/include/crypto/algapi.h b/include/crypto/algapi.h
index f50c5d1725da..224b86064708 100644
--- a/include/crypto/algapi.h
+++ b/include/crypto/algapi.h
@@ -265,4 +265,11 @@ enum {
 	CRYPTO_MSG_ALG_LOADED,
 };
 
+static inline void crypto_request_complete(struct crypto_async_request *req,
+					   int err)
+{
+	crypto_completion_t complete = req->complete;
+	complete(req, err);
+}
+
 #endif	/* _CRYPTO_ALGAPI_H */
diff --git a/include/drm/display/drm_dp.h b/include/drm/display/drm_dp.h
index e934aab357be..05f2cc03d03d 100644
--- a/include/drm/display/drm_dp.h
+++ b/include/drm/display/drm_dp.h
@@ -240,6 +240,8 @@
 #define DP_DSC_SUPPORT                      0x060   /* DP 1.4 */
 # define DP_DSC_DECOMPRESSION_IS_SUPPORTED  (1 << 0)
 # define DP_DSC_PASSTHROUGH_IS_SUPPORTED    (1 << 1)
+# define DP_DSC_DYNAMIC_PPS_UPDATE_SUPPORT_COMP_TO_COMP    (1 << 2)
+# define DP_DSC_DYNAMIC_PPS_UPDATE_SUPPORT_UNCOMP_TO_COMP  (1 << 3)
 
 #define DP_DSC_REV                          0x061
 # define DP_DSC_MAJOR_MASK                  (0xf << 0)
@@ -278,12 +280,14 @@
 
 #define DP_DSC_BLK_PREDICTION_SUPPORT       0x066
 # define DP_DSC_BLK_PREDICTION_IS_SUPPORTED (1 << 0)
+# define DP_DSC_RGB_COLOR_CONV_BYPASS_SUPPORT (1 << 1)
 
 #define DP_DSC_MAX_BITS_PER_PIXEL_LOW       0x067   /* eDP 1.4 */
 
 #define DP_DSC_MAX_BITS_PER_PIXEL_HI        0x068   /* eDP 1.4 */
 # define DP_DSC_MAX_BITS_PER_PIXEL_HI_MASK  (0x3 << 0)
-# define DP_DSC_MAX_BITS_PER_PIXEL_HI_SHIFT 8
+# define DP_DSC_MAX_BPP_DELTA_VERSION_MASK  (0x3 << 5)	/* eDP 1.5 & DP 2.0 */
+# define DP_DSC_MAX_BPP_DELTA_AVAILABILITY  (1 << 7)	/* eDP 1.5 & DP 2.0 */
 
 #define DP_DSC_DEC_COLOR_FORMAT_CAP         0x069
 # define DP_DSC_RGB                         (1 << 0)
@@ -345,11 +349,13 @@
 # define DP_DSC_24_PER_DP_DSC_SINK          (1 << 2)
 
 #define DP_DSC_BITS_PER_PIXEL_INC           0x06F
+# define DP_DSC_RGB_YCbCr444_MAX_BPP_DELTA_MASK 0x1f
+# define DP_DSC_RGB_YCbCr420_MAX_BPP_DELTA_MASK 0xe0
 # define DP_DSC_BITS_PER_PIXEL_1_16         0x0
 # define DP_DSC_BITS_PER_PIXEL_1_8          0x1
 # define DP_DSC_BITS_PER_PIXEL_1_4          0x2
 # define DP_DSC_BITS_PER_PIXEL_1_2          0x3
-# define DP_DSC_BITS_PER_PIXEL_1            0x4
+# define DP_DSC_BITS_PER_PIXEL_1_1          0x4
 
 #define DP_PSR_SUPPORT                      0x070   /* XXX 1.2? */
 # define DP_PSR_IS_SUPPORTED                1
diff --git a/include/drm/display/drm_dp_helper.h b/include/drm/display/drm_dp_helper.h
index ab55453f2d2c..ade9df59e156 100644
--- a/include/drm/display/drm_dp_helper.h
+++ b/include/drm/display/drm_dp_helper.h
@@ -181,9 +181,8 @@ static inline u16
 drm_edp_dsc_sink_output_bpp(const u8 dsc_dpcd[DP_DSC_RECEIVER_CAP_SIZE])
 {
 	return dsc_dpcd[DP_DSC_MAX_BITS_PER_PIXEL_LOW - DP_DSC_SUPPORT] |
-		(dsc_dpcd[DP_DSC_MAX_BITS_PER_PIXEL_HI - DP_DSC_SUPPORT] &
-		 DP_DSC_MAX_BITS_PER_PIXEL_HI_MASK <<
-		 DP_DSC_MAX_BITS_PER_PIXEL_HI_SHIFT);
+		((dsc_dpcd[DP_DSC_MAX_BITS_PER_PIXEL_HI - DP_DSC_SUPPORT] &
+		  DP_DSC_MAX_BITS_PER_PIXEL_HI_MASK) << 8);
 }
 
 static inline u32
diff --git a/include/linux/crypto.h b/include/linux/crypto.h
index 2324ab6f1846..e3c4be29aacc 100644
--- a/include/linux/crypto.h
+++ b/include/linux/crypto.h
@@ -176,6 +176,7 @@ struct crypto_async_request;
 struct crypto_tfm;
 struct crypto_type;
 
+typedef struct crypto_async_request crypto_completion_data_t;
 typedef void (*crypto_completion_t)(struct crypto_async_request *req, int err);
 
 /**
@@ -595,6 +596,11 @@ struct crypto_wait {
 /*
  * Async ops completion helper functioons
  */
+static inline void *crypto_get_completion_data(crypto_completion_data_t *req)
+{
+	return req->data;
+}
+
 void crypto_req_done(struct crypto_async_request *req, int err);
 
 static inline int crypto_wait_req(int err, struct crypto_wait *wait)
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 45c3d62e616d..95f33dadb2be 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -567,6 +567,7 @@
 #define PCI_DEVICE_ID_AMD_19H_M50H_DF_F3 0x166d
 #define PCI_DEVICE_ID_AMD_19H_M60H_DF_F3 0x14e3
 #define PCI_DEVICE_ID_AMD_19H_M70H_DF_F3 0x14f3
+#define PCI_DEVICE_ID_AMD_19H_M78H_DF_F3 0x12fb
 #define PCI_DEVICE_ID_AMD_CNB17H_F3	0x1703
 #define PCI_DEVICE_ID_AMD_LANCE		0x2000
 #define PCI_DEVICE_ID_AMD_LANCE_HOME	0x2001
diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
index eb53e96b7a29..5f58684f6107 100644
--- a/include/trace/events/f2fs.h
+++ b/include/trace/events/f2fs.h
@@ -48,6 +48,7 @@ TRACE_DEFINE_ENUM(CP_DISCARD);
 TRACE_DEFINE_ENUM(CP_TRIMMED);
 TRACE_DEFINE_ENUM(CP_PAUSE);
 TRACE_DEFINE_ENUM(CP_RESIZE);
+TRACE_DEFINE_ENUM(EX_READ);
 
 #define show_block_type(type)						\
 	__print_symbolic(type,						\
@@ -1559,28 +1560,31 @@ TRACE_EVENT(f2fs_issue_flush,
 
 TRACE_EVENT(f2fs_lookup_extent_tree_start,
 
-	TP_PROTO(struct inode *inode, unsigned int pgofs),
+	TP_PROTO(struct inode *inode, unsigned int pgofs, enum extent_type type),
 
-	TP_ARGS(inode, pgofs),
+	TP_ARGS(inode, pgofs, type),
 
 	TP_STRUCT__entry(
 		__field(dev_t,	dev)
 		__field(ino_t,	ino)
 		__field(unsigned int, pgofs)
+		__field(enum extent_type, type)
 	),
 
 	TP_fast_assign(
 		__entry->dev = inode->i_sb->s_dev;
 		__entry->ino = inode->i_ino;
 		__entry->pgofs = pgofs;
+		__entry->type = type;
 	),
 
-	TP_printk("dev = (%d,%d), ino = %lu, pgofs = %u",
+	TP_printk("dev = (%d,%d), ino = %lu, pgofs = %u, type = %s",
 		show_dev_ino(__entry),
-		__entry->pgofs)
+		__entry->pgofs,
+		__entry->type == EX_READ ? "Read" : "N/A")
 );
 
-TRACE_EVENT_CONDITION(f2fs_lookup_extent_tree_end,
+TRACE_EVENT_CONDITION(f2fs_lookup_read_extent_tree_end,
 
 	TP_PROTO(struct inode *inode, unsigned int pgofs,
 						struct extent_info *ei),
@@ -1594,8 +1598,8 @@ TRACE_EVENT_CONDITION(f2fs_lookup_extent_tree_end,
 		__field(ino_t,	ino)
 		__field(unsigned int, pgofs)
 		__field(unsigned int, fofs)
-		__field(u32, blk)
 		__field(unsigned int, len)
+		__field(u32, blk)
 	),
 
 	TP_fast_assign(
@@ -1603,26 +1607,26 @@ TRACE_EVENT_CONDITION(f2fs_lookup_extent_tree_end,
 		__entry->ino = inode->i_ino;
 		__entry->pgofs = pgofs;
 		__entry->fofs = ei->fofs;
-		__entry->blk = ei->blk;
 		__entry->len = ei->len;
+		__entry->blk = ei->blk;
 	),
 
 	TP_printk("dev = (%d,%d), ino = %lu, pgofs = %u, "
-		"ext_info(fofs: %u, blk: %u, len: %u)",
+		"read_ext_info(fofs: %u, len: %u, blk: %u)",
 		show_dev_ino(__entry),
 		__entry->pgofs,
 		__entry->fofs,
-		__entry->blk,
-		__entry->len)
+		__entry->len,
+		__entry->blk)
 );
 
-TRACE_EVENT(f2fs_update_extent_tree_range,
+TRACE_EVENT(f2fs_update_read_extent_tree_range,
 
-	TP_PROTO(struct inode *inode, unsigned int pgofs, block_t blkaddr,
-						unsigned int len,
+	TP_PROTO(struct inode *inode, unsigned int pgofs, unsigned int len,
+						block_t blkaddr,
 						unsigned int c_len),
 
-	TP_ARGS(inode, pgofs, blkaddr, len, c_len),
+	TP_ARGS(inode, pgofs, len, blkaddr, c_len),
 
 	TP_STRUCT__entry(
 		__field(dev_t,	dev)
@@ -1637,67 +1641,73 @@ TRACE_EVENT(f2fs_update_extent_tree_range,
 		__entry->dev = inode->i_sb->s_dev;
 		__entry->ino = inode->i_ino;
 		__entry->pgofs = pgofs;
-		__entry->blk = blkaddr;
 		__entry->len = len;
+		__entry->blk = blkaddr;
 		__entry->c_len = c_len;
 	),
 
 	TP_printk("dev = (%d,%d), ino = %lu, pgofs = %u, "
-					"blkaddr = %u, len = %u, "
-					"c_len = %u",
+				"len = %u, blkaddr = %u, c_len = %u",
 		show_dev_ino(__entry),
 		__entry->pgofs,
-		__entry->blk,
 		__entry->len,
+		__entry->blk,
 		__entry->c_len)
 );
 
 TRACE_EVENT(f2fs_shrink_extent_tree,
 
 	TP_PROTO(struct f2fs_sb_info *sbi, unsigned int node_cnt,
-						unsigned int tree_cnt),
+			unsigned int tree_cnt, enum extent_type type),
 
-	TP_ARGS(sbi, node_cnt, tree_cnt),
+	TP_ARGS(sbi, node_cnt, tree_cnt, type),
 
 	TP_STRUCT__entry(
 		__field(dev_t,	dev)
 		__field(unsigned int, node_cnt)
 		__field(unsigned int, tree_cnt)
+		__field(enum extent_type, type)
 	),
 
 	TP_fast_assign(
 		__entry->dev = sbi->sb->s_dev;
 		__entry->node_cnt = node_cnt;
 		__entry->tree_cnt = tree_cnt;
+		__entry->type = type;
 	),
 
-	TP_printk("dev = (%d,%d), shrunk: node_cnt = %u, tree_cnt = %u",
+	TP_printk("dev = (%d,%d), shrunk: node_cnt = %u, tree_cnt = %u, type = %s",
 		show_dev(__entry->dev),
 		__entry->node_cnt,
-		__entry->tree_cnt)
+		__entry->tree_cnt,
+		__entry->type == EX_READ ? "Read" : "N/A")
 );
 
 TRACE_EVENT(f2fs_destroy_extent_tree,
 
-	TP_PROTO(struct inode *inode, unsigned int node_cnt),
+	TP_PROTO(struct inode *inode, unsigned int node_cnt,
+				enum extent_type type),
 
-	TP_ARGS(inode, node_cnt),
+	TP_ARGS(inode, node_cnt, type),
 
 	TP_STRUCT__entry(
 		__field(dev_t,	dev)
 		__field(ino_t,	ino)
 		__field(unsigned int, node_cnt)
+		__field(enum extent_type, type)
 	),
 
 	TP_fast_assign(
 		__entry->dev = inode->i_sb->s_dev;
 		__entry->ino = inode->i_ino;
 		__entry->node_cnt = node_cnt;
+		__entry->type = type;
 	),
 
-	TP_printk("dev = (%d,%d), ino = %lu, destroyed: node_cnt = %u",
+	TP_printk("dev = (%d,%d), ino = %lu, destroyed: node_cnt = %u, type = %s",
 		show_dev_ino(__entry),
-		__entry->node_cnt)
+		__entry->node_cnt,
+		__entry->type == EX_READ ? "Read" : "N/A")
 );
 
 DECLARE_EVENT_CLASS(f2fs_sync_dirty_inodes,
diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index 84d5b649b95f..92d8e2c4edda 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -1251,7 +1251,7 @@ static struct rw_semaphore *rwsem_downgrade_wake(struct rw_semaphore *sem)
 /*
  * lock for reading
  */
-static inline int __down_read_common(struct rw_semaphore *sem, int state)
+static __always_inline int __down_read_common(struct rw_semaphore *sem, int state)
 {
 	int ret = 0;
 	long count;
@@ -1269,17 +1269,17 @@ static inline int __down_read_common(struct rw_semaphore *sem, int state)
 	return ret;
 }
 
-static inline void __down_read(struct rw_semaphore *sem)
+static __always_inline void __down_read(struct rw_semaphore *sem)
 {
 	__down_read_common(sem, TASK_UNINTERRUPTIBLE);
 }
 
-static inline int __down_read_interruptible(struct rw_semaphore *sem)
+static __always_inline int __down_read_interruptible(struct rw_semaphore *sem)
 {
 	return __down_read_common(sem, TASK_INTERRUPTIBLE);
 }
 
-static inline int __down_read_killable(struct rw_semaphore *sem)
+static __always_inline int __down_read_killable(struct rw_semaphore *sem)
 {
 	return __down_read_common(sem, TASK_KILLABLE);
 }
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 597c1f17d388..ccfd9053754a 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -1544,7 +1544,7 @@ int skb_copy_ubufs(struct sk_buff *skb, gfp_t gfp_mask)
 {
 	int num_frags = skb_shinfo(skb)->nr_frags;
 	struct page *page, *head = NULL;
-	int i, new_frags;
+	int i, order, psize, new_frags;
 	u32 d_off;
 
 	if (skb_shared(skb) || skb_unclone(skb, gfp_mask))
@@ -1553,9 +1553,17 @@ int skb_copy_ubufs(struct sk_buff *skb, gfp_t gfp_mask)
 	if (!num_frags)
 		goto release;
 
-	new_frags = (__skb_pagelen(skb) + PAGE_SIZE - 1) >> PAGE_SHIFT;
+	/* We might have to allocate high order pages, so compute what minimum
+	 * page order is needed.
+	 */
+	order = 0;
+	while ((PAGE_SIZE << order) * MAX_SKB_FRAGS < __skb_pagelen(skb))
+		order++;
+	psize = (PAGE_SIZE << order);
+
+	new_frags = (__skb_pagelen(skb) + psize - 1) >> (PAGE_SHIFT + order);
 	for (i = 0; i < new_frags; i++) {
-		page = alloc_page(gfp_mask);
+		page = alloc_pages(gfp_mask | __GFP_COMP, order);
 		if (!page) {
 			while (head) {
 				struct page *next = (struct page *)page_private(head);
@@ -1582,11 +1590,11 @@ int skb_copy_ubufs(struct sk_buff *skb, gfp_t gfp_mask)
 			vaddr = kmap_atomic(p);
 
 			while (done < p_len) {
-				if (d_off == PAGE_SIZE) {
+				if (d_off == psize) {
 					d_off = 0;
 					page = (struct page *)page_private(page);
 				}
-				copy = min_t(u32, PAGE_SIZE - d_off, p_len - done);
+				copy = min_t(u32, psize - d_off, p_len - done);
 				memcpy(page_address(page) + d_off,
 				       vaddr + p_off + done, copy);
 				done += copy;
@@ -1602,7 +1610,7 @@ int skb_copy_ubufs(struct sk_buff *skb, gfp_t gfp_mask)
 
 	/* skb frags point to kernel buffers */
 	for (i = 0; i < new_frags - 1; i++) {
-		__skb_fill_page_desc(skb, i, head, 0, PAGE_SIZE);
+		__skb_fill_page_desc(skb, i, head, 0, psize);
 		head = (struct page *)page_private(head);
 	}
 	__skb_fill_page_desc(skb, new_frags - 1, head, 0, d_off);
diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index 038398d41a93..940c0e27be73 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -580,8 +580,8 @@ static int ethtool_get_link_ksettings(struct net_device *dev,
 static int ethtool_set_link_ksettings(struct net_device *dev,
 				      void __user *useraddr)
 {
+	struct ethtool_link_ksettings link_ksettings = {};
 	int err;
-	struct ethtool_link_ksettings link_ksettings;
 
 	ASSERT_RTNL();
 
diff --git a/net/ipv6/sit.c b/net/ipv6/sit.c
index 70d81bba5093..3ffb6a5b1f82 100644
--- a/net/ipv6/sit.c
+++ b/net/ipv6/sit.c
@@ -1095,12 +1095,13 @@ static netdev_tx_t sit_tunnel_xmit(struct sk_buff *skb,
 
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
@@ -1123,14 +1124,15 @@ static void ipip6_tunnel_bind_dev(struct net_device *dev)
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
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index c563a84d67b4..8d61efeab9c9 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -1065,7 +1065,7 @@ static void tcp_v6_send_reset(const struct sock *sk, struct sk_buff *skb)
 			if (np->repflow)
 				label = ip6_flowlabel(ipv6h);
 			priority = sk->sk_priority;
-			txhash = sk->sk_hash;
+			txhash = sk->sk_txhash;
 		}
 		if (sk->sk_state == TCP_TIME_WAIT) {
 			label = cpu_to_be32(inet_twsk(sk)->tw_flowlabel);
diff --git a/net/ncsi/ncsi-aen.c b/net/ncsi/ncsi-aen.c
index b635c194f0a8..62fb1031763d 100644
--- a/net/ncsi/ncsi-aen.c
+++ b/net/ncsi/ncsi-aen.c
@@ -165,6 +165,7 @@ static int ncsi_aen_handler_cr(struct ncsi_dev_priv *ndp,
 	nc->state = NCSI_CHANNEL_INACTIVE;
 	list_add_tail_rcu(&nc->link, &ndp->channel_queue);
 	spin_unlock_irqrestore(&ndp->lock, flags);
+	nc->modes[NCSI_MODE_TX_ENABLE].enable = 0;
 
 	return ncsi_process_next_channel(ndp);
 }
diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index ac9335d76fb7..2af2ab924d64 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -2035,7 +2035,7 @@ static int packet_sendmsg_spkt(struct socket *sock, struct msghdr *msg,
 		goto retry;
 	}
 
-	if (!dev_validate_header(dev, skb->data, len)) {
+	if (!dev_validate_header(dev, skb->data, len) || !skb->len) {
 		err = -EINVAL;
 		goto out_unlock;
 	}
diff --git a/net/rxrpc/sendmsg.c b/net/rxrpc/sendmsg.c
index d4e4e94f4f98..71e40f91dd39 100644
--- a/net/rxrpc/sendmsg.c
+++ b/net/rxrpc/sendmsg.c
@@ -736,7 +736,7 @@ int rxrpc_do_sendmsg(struct rxrpc_sock *rx, struct msghdr *msg, size_t len)
 		fallthrough;
 	case 1:
 		if (p.call.timeouts.hard > 0) {
-			j = msecs_to_jiffies(p.call.timeouts.hard);
+			j = p.call.timeouts.hard * HZ;
 			now = jiffies;
 			j += now;
 			WRITE_ONCE(call->expect_term_by, j);
diff --git a/net/sched/act_mirred.c b/net/sched/act_mirred.c
index baeae5e5c8f0..36395e5db3b4 100644
--- a/net/sched/act_mirred.c
+++ b/net/sched/act_mirred.c
@@ -262,7 +262,7 @@ static int tcf_mirred_act(struct sk_buff *skb, const struct tc_action *a,
 		goto out;
 	}
 
-	if (unlikely(!(dev->flags & IFF_UP))) {
+	if (unlikely(!(dev->flags & IFF_UP)) || !netif_carrier_ok(dev)) {
 		net_notice_ratelimited("tc mirred to Houston: device %s is down\n",
 				       dev->name);
 		goto out;
diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
index 50566db45949..7b2aa04a7cdf 100644
--- a/net/sched/cls_api.c
+++ b/net/sched/cls_api.c
@@ -1483,6 +1483,7 @@ static int tcf_block_bind(struct tcf_block *block,
 
 err_unroll:
 	list_for_each_entry_safe(block_cb, next, &bo->cb_list, list) {
+		list_del(&block_cb->driver_list);
 		if (i-- > 0) {
 			list_del(&block_cb->list);
 			tcf_block_playback_offloads(block, block_cb->cb,
diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 3f16ad1c3758..965ae55fa160 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -199,6 +199,7 @@ config SND_SOC_ALL_CODECS
 	imply SND_SOC_RT715_SDCA_SDW
 	imply SND_SOC_RT1308_SDW
 	imply SND_SOC_RT1316_SDW
+	imply SND_SOC_RT1318_SDW
 	imply SND_SOC_RT9120
 	imply SND_SOC_SDW_MOCKUP
 	imply SND_SOC_SGTL5000
@@ -1311,6 +1312,11 @@ config SND_SOC_RT1316_SDW
 	depends on SOUNDWIRE
 	select REGMAP_SOUNDWIRE
 
+config SND_SOC_RT1318_SDW
+	tristate "Realtek RT1318 Codec - SDW"
+	depends on SOUNDWIRE
+	select REGMAP_SOUNDWIRE
+
 config SND_SOC_RT5514
 	tristate
 	depends on I2C
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index 9170ee1447dd..71d3ce5867e4 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -196,6 +196,7 @@ snd-soc-rt1305-objs := rt1305.o
 snd-soc-rt1308-objs := rt1308.o
 snd-soc-rt1308-sdw-objs := rt1308-sdw.o
 snd-soc-rt1316-sdw-objs := rt1316-sdw.o
+snd-soc-rt1318-sdw-objs := rt1318-sdw.o
 snd-soc-rt274-objs := rt274.o
 snd-soc-rt286-objs := rt286.o
 snd-soc-rt298-objs := rt298.o
@@ -551,6 +552,7 @@ obj-$(CONFIG_SND_SOC_RT1305)	+= snd-soc-rt1305.o
 obj-$(CONFIG_SND_SOC_RT1308)	+= snd-soc-rt1308.o
 obj-$(CONFIG_SND_SOC_RT1308_SDW)	+= snd-soc-rt1308-sdw.o
 obj-$(CONFIG_SND_SOC_RT1316_SDW)	+= snd-soc-rt1316-sdw.o
+obj-$(CONFIG_SND_SOC_RT1318_SDW)	+= snd-soc-rt1318-sdw.o
 obj-$(CONFIG_SND_SOC_RT274)	+= snd-soc-rt274.o
 obj-$(CONFIG_SND_SOC_RT286)	+= snd-soc-rt286.o
 obj-$(CONFIG_SND_SOC_RT298)	+= snd-soc-rt298.o
diff --git a/sound/soc/codecs/rt1316-sdw.c b/sound/soc/codecs/rt1316-sdw.c
index ed0a11436362..154b6179b6dc 100644
--- a/sound/soc/codecs/rt1316-sdw.c
+++ b/sound/soc/codecs/rt1316-sdw.c
@@ -585,7 +585,7 @@ static int rt1316_sdw_pcm_hw_free(struct snd_pcm_substream *substream,
  * slave_ops: callbacks for get_clock_stop_mode, clock_stop and
  * port_prep are not defined for now
  */
-static struct sdw_slave_ops rt1316_slave_ops = {
+static const struct sdw_slave_ops rt1316_slave_ops = {
 	.read_prop = rt1316_read_prop,
 	.update_status = rt1316_update_status,
 };
diff --git a/sound/soc/codecs/rt1318-sdw.c b/sound/soc/codecs/rt1318-sdw.c
new file mode 100644
index 000000000000..c6ec86e97a6e
--- /dev/null
+++ b/sound/soc/codecs/rt1318-sdw.c
@@ -0,0 +1,884 @@
+// SPDX-License-Identifier: GPL-2.0-only
+//
+// rt1318-sdw.c -- rt1318 SDCA ALSA SoC amplifier audio driver
+//
+// Copyright(c) 2022 Realtek Semiconductor Corp.
+//
+//
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/pm_runtime.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+#include <linux/dmi.h>
+#include <linux/firmware.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/soc-dapm.h>
+#include <sound/initval.h>
+#include "rt1318-sdw.h"
+
+static const struct reg_sequence rt1318_blind_write[] = {
+	{ 0xc001, 0x43 },
+	{ 0xc003, 0xa2 },
+	{ 0xc004, 0x44 },
+	{ 0xc005, 0x44 },
+	{ 0xc006, 0x33 },
+	{ 0xc007, 0x64 },
+	{ 0xc320, 0x20 },
+	{ 0xf203, 0x18 },
+	{ 0xf211, 0x00 },
+	{ 0xf212, 0x26 },
+	{ 0xf20d, 0x17 },
+	{ 0xf214, 0x06 },
+	{ 0xf20e, 0x00 },
+	{ 0xf223, 0x7f },
+	{ 0xf224, 0xdb },
+	{ 0xf225, 0xee },
+	{ 0xf226, 0x3f },
+	{ 0xf227, 0x0f },
+	{ 0xf21a, 0x78 },
+	{ 0xf242, 0x3c },
+	{ 0xc321, 0x0b },
+	{ 0xc200, 0xd8 },
+	{ 0xc201, 0x27 },
+	{ 0xc202, 0x0f },
+	{ 0xf800, 0x20 },
+	{ 0xdf00, 0x10 },
+	{ 0xdf5f, 0x01 },
+	{ 0xdf60, 0xa7 },
+	{ 0xc400, 0x0e },
+	{ 0xc401, 0x43 },
+	{ 0xc402, 0xe0 },
+	{ 0xc403, 0x00 },
+	{ 0xc404, 0x4c },
+	{ 0xc407, 0x02 },
+	{ 0xc408, 0x3f },
+	{ 0xc300, 0x01 },
+	{ 0xc206, 0x78 },
+	{ 0xc203, 0x84 },
+	{ 0xc120, 0xc0 },
+	{ 0xc121, 0x03 },
+	{ 0xe000, 0x88 },
+	{ 0xc321, 0x09 },
+	{ 0xc322, 0x01 },
+	{ 0xe706, 0x0f },
+	{ 0xe707, 0x30 },
+	{ 0xe806, 0x0f },
+	{ 0xe807, 0x30 },
+	{ 0xed00, 0xb0 },
+	{ 0xce04, 0x02 },
+	{ 0xce05, 0x63 },
+	{ 0xce06, 0x68 },
+	{ 0xce07, 0x07 },
+	{ 0xcf04, 0x02 },
+	{ 0xcf05, 0x63 },
+	{ 0xcf06, 0x68 },
+	{ 0xcf07, 0x07 },
+	{ 0xce60, 0xe3 },
+	{ 0xc130, 0x51 },
+	{ 0xf102, 0x00 },
+	{ 0xf103, 0x00 },
+	{ 0xf104, 0xf5 },
+	{ 0xf105, 0x06 },
+	{ 0xf109, 0x9b },
+	{ 0xf10a, 0x0b },
+	{ 0xf10b, 0x4c },
+	{ 0xf10b, 0x5c },
+	{ 0xf102, 0x00 },
+	{ 0xf103, 0x00 },
+	{ 0xf104, 0xf5 },
+	{ 0xf105, 0x0b },
+	{ 0xf109, 0x03 },
+	{ 0xf10a, 0x0b },
+	{ 0xf10b, 0x4c },
+	{ 0xf10b, 0x5c },
+	{ 0xf102, 0x00 },
+	{ 0xf103, 0x00 },
+	{ 0xf104, 0xf5 },
+	{ 0xf105, 0x0c },
+	{ 0xf109, 0x7f },
+	{ 0xf10a, 0x0b },
+	{ 0xf10b, 0x4c },
+	{ 0xf10b, 0x5c },
+
+	{ 0xe604, 0x00 },
+	{ 0xdb00, 0x0c },
+	{ 0xdd00, 0x0c },
+	{ 0xdc19, 0x00 },
+	{ 0xdc1a, 0xff },
+	{ 0xdc1b, 0xff },
+	{ 0xdc1c, 0xff },
+	{ 0xdc1d, 0x00 },
+	{ 0xdc1e, 0x00 },
+	{ 0xdc1f, 0x00 },
+	{ 0xdc20, 0xff },
+	{ 0xde19, 0x00 },
+	{ 0xde1a, 0xff },
+	{ 0xde1b, 0xff },
+	{ 0xde1c, 0xff },
+	{ 0xde1d, 0x00 },
+	{ 0xde1e, 0x00 },
+	{ 0xde1f, 0x00 },
+	{ 0xde20, 0xff },
+	{ 0xdb32, 0x00 },
+	{ 0xdd32, 0x00 },
+	{ 0xdb33, 0x0a },
+	{ 0xdd33, 0x0a },
+	{ 0xdb34, 0x1a },
+	{ 0xdd34, 0x1a },
+	{ 0xdb17, 0xef },
+	{ 0xdd17, 0xef },
+	{ 0xdba7, 0x00 },
+	{ 0xdba8, 0x64 },
+	{ 0xdda7, 0x00 },
+	{ 0xdda8, 0x64 },
+	{ 0xdb19, 0x40 },
+	{ 0xdd19, 0x40 },
+	{ 0xdb00, 0x4c },
+	{ 0xdb01, 0x79 },
+	{ 0xdd01, 0x79 },
+	{ 0xdb04, 0x05 },
+	{ 0xdb05, 0x03 },
+	{ 0xdd04, 0x05 },
+	{ 0xdd05, 0x03 },
+	{ 0xdbbb, 0x09 },
+	{ 0xdbbc, 0x30 },
+	{ 0xdbbd, 0xf0 },
+	{ 0xdbbe, 0xf1 },
+	{ 0xddbb, 0x09 },
+	{ 0xddbc, 0x30 },
+	{ 0xddbd, 0xf0 },
+	{ 0xddbe, 0xf1 },
+	{ 0xdb01, 0x79 },
+	{ 0xdd01, 0x79 },
+	{ 0xdc52, 0xef },
+	{ 0xde52, 0xef },
+	{ 0x2f55, 0x22 },
+};
+
+static const struct reg_default rt1318_reg_defaults[] = {
+	{ 0x3000, 0x00 },
+	{ 0x3004, 0x01 },
+	{ 0x3005, 0x23 },
+	{ 0x3202, 0x00 },
+	{ 0x3203, 0x01 },
+	{ 0x3206, 0x00 },
+	{ 0xc000, 0x00 },
+	{ 0xc001, 0x43 },
+	{ 0xc003, 0x22 },
+	{ 0xc004, 0x44 },
+	{ 0xc005, 0x44 },
+	{ 0xc006, 0x33 },
+	{ 0xc007, 0x64 },
+	{ 0xc008, 0x05 },
+	{ 0xc00a, 0xfc },
+	{ 0xc00b, 0x0f },
+	{ 0xc00c, 0x0e },
+	{ 0xc00d, 0xef },
+	{ 0xc00e, 0xe5 },
+	{ 0xc00f, 0xff },
+	{ 0xc120, 0xc0 },
+	{ 0xc121, 0x00 },
+	{ 0xc122, 0x00 },
+	{ 0xc123, 0x14 },
+	{ 0xc125, 0x00 },
+	{ 0xc200, 0x00 },
+	{ 0xc201, 0x00 },
+	{ 0xc202, 0x00 },
+	{ 0xc203, 0x04 },
+	{ 0xc204, 0x00 },
+	{ 0xc205, 0x00 },
+	{ 0xc206, 0x68 },
+	{ 0xc207, 0x70 },
+	{ 0xc208, 0x00 },
+	{ 0xc20a, 0x00 },
+	{ 0xc20b, 0x01 },
+	{ 0xc20c, 0x7f },
+	{ 0xc20d, 0x01 },
+	{ 0xc20e, 0x7f },
+	{ 0xc300, 0x00 },
+	{ 0xc301, 0x00 },
+	{ 0xc303, 0x80 },
+	{ 0xc320, 0x00 },
+	{ 0xc321, 0x09 },
+	{ 0xc322, 0x02 },
+	{ 0xc410, 0x04 },
+	{ 0xc430, 0x00 },
+	{ 0xc431, 0x00 },
+	{ 0xca00, 0x10 },
+	{ 0xca01, 0x00 },
+	{ 0xca02, 0x0b },
+	{ 0xca10, 0x10 },
+	{ 0xca11, 0x00 },
+	{ 0xca12, 0x0b },
+	{ 0xdd93, 0x00 },
+	{ 0xdd94, 0x64 },
+	{ 0xe300, 0xa0 },
+	{ 0xed00, 0x80 },
+	{ 0xed01, 0x0f },
+	{ 0xed02, 0xff },
+	{ 0xed03, 0x00 },
+	{ 0xed04, 0x00 },
+	{ 0xed05, 0x0f },
+	{ 0xed06, 0xff },
+	{ 0xf010, 0x10 },
+	{ 0xf011, 0xec },
+	{ 0xf012, 0x68 },
+	{ 0xf013, 0x21 },
+	{ 0xf800, 0x00 },
+	{ 0xf801, 0x12 },
+	{ 0xf802, 0xe0 },
+	{ 0xf803, 0x2f },
+	{ 0xf804, 0x00 },
+	{ 0xf805, 0x00 },
+	{ 0xf806, 0x07 },
+	{ 0xf807, 0xff },
+	{ SDW_SDCA_CTL(FUNC_NUM_SMART_AMP, RT1318_SDCA_ENT_UDMPU21, RT1318_SDCA_CTL_UDMPU_CLUSTER, 0), 0x00 },
+	{ SDW_SDCA_CTL(FUNC_NUM_SMART_AMP, RT1318_SDCA_ENT_FU21, RT1318_SDCA_CTL_FU_MUTE, CH_L), 0x01 },
+	{ SDW_SDCA_CTL(FUNC_NUM_SMART_AMP, RT1318_SDCA_ENT_FU21, RT1318_SDCA_CTL_FU_MUTE, CH_R), 0x01 },
+	{ SDW_SDCA_CTL(FUNC_NUM_SMART_AMP, RT1318_SDCA_ENT_PDE23, RT1318_SDCA_CTL_REQ_POWER_STATE, 0), 0x03 },
+	{ SDW_SDCA_CTL(FUNC_NUM_SMART_AMP, RT1318_SDCA_ENT_CS21, RT1318_SDCA_CTL_SAMPLE_FREQ_INDEX, 0), 0x09 },
+};
+
+static bool rt1318_readable_register(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case 0x2f55:
+	case 0x3000:
+	case 0x3004 ... 0x3005:
+	case 0x3202 ... 0x3203:
+	case 0x3206:
+	case 0xc000 ... 0xc00f:
+	case 0xc120 ... 0xc125:
+	case 0xc200 ... 0xc20e:
+	case 0xc300 ... 0xc303:
+	case 0xc320 ... 0xc322:
+	case 0xc410:
+	case 0xc430 ... 0xc431:
+	case 0xca00 ... 0xca02:
+	case 0xca10 ... 0xca12:
+	case 0xcb00 ... 0xcb0b:
+	case 0xcc00 ... 0xcce5:
+	case 0xcd00 ... 0xcde5:
+	case 0xce00 ... 0xce6a:
+	case 0xcf00 ... 0xcf53:
+	case 0xd000 ... 0xd0cc:
+	case 0xd100 ... 0xd1b9:
+	case 0xdb00 ... 0xdc53:
+	case 0xdd00 ... 0xde53:
+	case 0xdf00 ... 0xdf6b:
+	case 0xe300:
+	case 0xeb00 ... 0xebcc:
+	case 0xec00 ... 0xecb9:
+	case 0xed00 ... 0xed06:
+	case 0xf010 ... 0xf014:
+	case 0xf800 ... 0xf807:
+	case SDW_SDCA_CTL(FUNC_NUM_SMART_AMP, RT1318_SDCA_ENT_UDMPU21, RT1318_SDCA_CTL_UDMPU_CLUSTER, 0):
+	case SDW_SDCA_CTL(FUNC_NUM_SMART_AMP, RT1318_SDCA_ENT_FU21, RT1318_SDCA_CTL_FU_MUTE, CH_L):
+	case SDW_SDCA_CTL(FUNC_NUM_SMART_AMP, RT1318_SDCA_ENT_FU21, RT1318_SDCA_CTL_FU_MUTE, CH_R):
+	case SDW_SDCA_CTL(FUNC_NUM_SMART_AMP, RT1318_SDCA_ENT_PDE23, RT1318_SDCA_CTL_REQ_POWER_STATE, 0):
+	case SDW_SDCA_CTL(FUNC_NUM_SMART_AMP, RT1318_SDCA_ENT_CS21, RT1318_SDCA_CTL_SAMPLE_FREQ_INDEX, 0):
+	case SDW_SDCA_CTL(FUNC_NUM_SMART_AMP, RT1318_SDCA_ENT_SAPU, RT1318_SDCA_CTL_SAPU_PROTECTION_MODE, 0):
+	case SDW_SDCA_CTL(FUNC_NUM_SMART_AMP, RT1318_SDCA_ENT_SAPU, RT1318_SDCA_CTL_SAPU_PROTECTION_STATUS, 0):
+		return true;
+	default:
+		return false;
+	}
+}
+
+static bool rt1318_volatile_register(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case 0x2f55:
+	case 0x3000 ... 0x3001:
+	case 0xc000:
+	case 0xc301:
+	case 0xc410:
+	case 0xc430 ... 0xc431:
+	case 0xdb06:
+	case 0xdb12:
+	case 0xdb1d ... 0xdb1f:
+	case 0xdb35:
+	case 0xdb37:
+	case 0xdb8a ... 0xdb92:
+	case 0xdbc5 ... 0xdbc8:
+	case 0xdc2b ... 0xdc49:
+	case 0xdd0b:
+	case 0xdd12:
+	case 0xdd1d ... 0xdd1f:
+	case 0xdd35:
+	case 0xdd8a ... 0xdd92:
+	case 0xddc5 ... 0xddc8:
+	case 0xde2b ... 0xde44:
+	case 0xdf4a ... 0xdf55:
+	case 0xe224 ... 0xe23b:
+	case 0xea01:
+	case 0xebc5:
+	case 0xebc8:
+	case 0xebcb ... 0xebcc:
+	case 0xed03 ... 0xed06:
+	case 0xf010 ... 0xf014:
+	case SDW_SDCA_CTL(FUNC_NUM_SMART_AMP, RT1318_SDCA_ENT_SAPU, RT1318_SDCA_CTL_SAPU_PROTECTION_MODE, 0):
+	case SDW_SDCA_CTL(FUNC_NUM_SMART_AMP, RT1318_SDCA_ENT_SAPU, RT1318_SDCA_CTL_SAPU_PROTECTION_STATUS, 0):
+		return true;
+	default:
+		return false;
+	}
+}
+
+static const struct regmap_config rt1318_sdw_regmap = {
+	.reg_bits = 32,
+	.val_bits = 8,
+	.readable_reg = rt1318_readable_register,
+	.volatile_reg = rt1318_volatile_register,
+	.max_register = 0x41081488,
+	.reg_defaults = rt1318_reg_defaults,
+	.num_reg_defaults = ARRAY_SIZE(rt1318_reg_defaults),
+	.cache_type = REGCACHE_RBTREE,
+	.use_single_read = true,
+	.use_single_write = true,
+};
+
+static int rt1318_read_prop(struct sdw_slave *slave)
+{
+	struct sdw_slave_prop *prop = &slave->prop;
+	int nval;
+	int i, j;
+	u32 bit;
+	unsigned long addr;
+	struct sdw_dpn_prop *dpn;
+
+	prop->scp_int1_mask = SDW_SCP_INT1_BUS_CLASH | SDW_SCP_INT1_PARITY;
+	prop->quirks = SDW_SLAVE_QUIRKS_INVALID_INITIAL_PARITY;
+	prop->is_sdca = true;
+
+	prop->paging_support = true;
+
+	/* first we need to allocate memory for set bits in port lists */
+	prop->source_ports = BIT(2);
+	prop->sink_ports = BIT(1);
+
+	nval = hweight32(prop->source_ports);
+	prop->src_dpn_prop = devm_kcalloc(&slave->dev, nval,
+		sizeof(*prop->src_dpn_prop), GFP_KERNEL);
+	if (!prop->src_dpn_prop)
+		return -ENOMEM;
+
+	i = 0;
+	dpn = prop->src_dpn_prop;
+	addr = prop->source_ports;
+	for_each_set_bit(bit, &addr, 32) {
+		dpn[i].num = bit;
+		dpn[i].type = SDW_DPN_FULL;
+		dpn[i].simple_ch_prep_sm = true;
+		dpn[i].ch_prep_timeout = 10;
+		i++;
+	}
+
+	/* do this again for sink now */
+	nval = hweight32(prop->sink_ports);
+	prop->sink_dpn_prop = devm_kcalloc(&slave->dev, nval,
+		sizeof(*prop->sink_dpn_prop), GFP_KERNEL);
+	if (!prop->sink_dpn_prop)
+		return -ENOMEM;
+
+	j = 0;
+	dpn = prop->sink_dpn_prop;
+	addr = prop->sink_ports;
+	for_each_set_bit(bit, &addr, 32) {
+		dpn[j].num = bit;
+		dpn[j].type = SDW_DPN_FULL;
+		dpn[j].simple_ch_prep_sm = true;
+		dpn[j].ch_prep_timeout = 10;
+		j++;
+	}
+
+	/* set the timeout values */
+	prop->clk_stop_timeout = 20;
+
+	return 0;
+}
+
+static int rt1318_io_init(struct device *dev, struct sdw_slave *slave)
+{
+	struct rt1318_sdw_priv *rt1318 = dev_get_drvdata(dev);
+
+	if (rt1318->hw_init)
+		return 0;
+
+	if (rt1318->first_hw_init) {
+		regcache_cache_only(rt1318->regmap, false);
+		regcache_cache_bypass(rt1318->regmap, true);
+	} else {
+		/*
+		 * PM runtime is only enabled when a Slave reports as Attached
+		 */
+
+		/* set autosuspend parameters */
+		pm_runtime_set_autosuspend_delay(&slave->dev, 3000);
+		pm_runtime_use_autosuspend(&slave->dev);
+
+		/* update count of parent 'active' children */
+		pm_runtime_set_active(&slave->dev);
+
+		/* make sure the device does not suspend immediately */
+		pm_runtime_mark_last_busy(&slave->dev);
+
+		pm_runtime_enable(&slave->dev);
+	}
+
+	pm_runtime_get_noresume(&slave->dev);
+
+	/* blind write */
+	regmap_multi_reg_write(rt1318->regmap, rt1318_blind_write,
+		ARRAY_SIZE(rt1318_blind_write));
+
+	if (rt1318->first_hw_init) {
+		regcache_cache_bypass(rt1318->regmap, false);
+		regcache_mark_dirty(rt1318->regmap);
+	}
+
+	/* Mark Slave initialization complete */
+	rt1318->first_hw_init = true;
+	rt1318->hw_init = true;
+
+	pm_runtime_mark_last_busy(&slave->dev);
+	pm_runtime_put_autosuspend(&slave->dev);
+
+	dev_dbg(&slave->dev, "%s hw_init complete\n", __func__);
+	return 0;
+}
+
+static int rt1318_update_status(struct sdw_slave *slave,
+					enum sdw_slave_status status)
+{
+	struct  rt1318_sdw_priv *rt1318 = dev_get_drvdata(&slave->dev);
+
+	/* Update the status */
+	rt1318->status = status;
+
+	if (status == SDW_SLAVE_UNATTACHED)
+		rt1318->hw_init = false;
+
+	/*
+	 * Perform initialization only if slave status is present and
+	 * hw_init flag is false
+	 */
+	if (rt1318->hw_init || rt1318->status != SDW_SLAVE_ATTACHED)
+		return 0;
+
+	/* perform I/O transfers required for Slave initialization */
+	return rt1318_io_init(&slave->dev, slave);
+}
+
+static int rt1318_classd_event(struct snd_soc_dapm_widget *w,
+	struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_component *component =
+		snd_soc_dapm_to_component(w->dapm);
+	struct rt1318_sdw_priv *rt1318 = snd_soc_component_get_drvdata(component);
+	unsigned char ps0 = 0x0, ps3 = 0x3;
+
+	switch (event) {
+	case SND_SOC_DAPM_POST_PMU:
+		regmap_write(rt1318->regmap,
+			SDW_SDCA_CTL(FUNC_NUM_SMART_AMP, RT1318_SDCA_ENT_PDE23,
+				RT1318_SDCA_CTL_REQ_POWER_STATE, 0),
+				ps0);
+		break;
+	case SND_SOC_DAPM_PRE_PMD:
+		regmap_write(rt1318->regmap,
+			SDW_SDCA_CTL(FUNC_NUM_SMART_AMP, RT1318_SDCA_ENT_PDE23,
+				RT1318_SDCA_CTL_REQ_POWER_STATE, 0),
+				ps3);
+		break;
+
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+static const char * const rt1318_rx_data_ch_select[] = {
+	"L,R",
+	"L,L",
+	"L,R",
+	"L,L+R",
+	"R,L",
+	"R,R",
+	"R,L+R",
+	"L+R,L",
+	"L+R,R",
+	"L+R,L+R",
+};
+
+static SOC_ENUM_SINGLE_DECL(rt1318_rx_data_ch_enum,
+	SDW_SDCA_CTL(FUNC_NUM_SMART_AMP, RT1318_SDCA_ENT_UDMPU21, RT1318_SDCA_CTL_UDMPU_CLUSTER, 0), 0,
+	rt1318_rx_data_ch_select);
+
+static const struct snd_kcontrol_new rt1318_snd_controls[] = {
+
+	/* UDMPU Cluster Selection */
+	SOC_ENUM("RX Channel Select", rt1318_rx_data_ch_enum),
+};
+
+static const struct snd_kcontrol_new rt1318_sto_dac =
+	SOC_DAPM_DOUBLE_R("Switch",
+		SDW_SDCA_CTL(FUNC_NUM_SMART_AMP, RT1318_SDCA_ENT_FU21, RT1318_SDCA_CTL_FU_MUTE, CH_L),
+		SDW_SDCA_CTL(FUNC_NUM_SMART_AMP, RT1318_SDCA_ENT_FU21, RT1318_SDCA_CTL_FU_MUTE, CH_R),
+		0, 1, 1);
+
+static const struct snd_soc_dapm_widget rt1318_dapm_widgets[] = {
+	/* Audio Interface */
+	SND_SOC_DAPM_AIF_IN("DP1RX", "DP1 Playback", 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_OUT("DP2TX", "DP2 Capture", 0, SND_SOC_NOPM, 0, 0),
+
+	/* Digital Interface */
+	SND_SOC_DAPM_SWITCH("DAC", SND_SOC_NOPM, 0, 0, &rt1318_sto_dac),
+
+	/* Output */
+	SND_SOC_DAPM_PGA_E("CLASS D", SND_SOC_NOPM, 0, 0, NULL, 0,
+		rt1318_classd_event, SND_SOC_DAPM_PRE_PMD | SND_SOC_DAPM_POST_PMU),
+	SND_SOC_DAPM_OUTPUT("SPOL"),
+	SND_SOC_DAPM_OUTPUT("SPOR"),
+	/* Input */
+	SND_SOC_DAPM_PGA("FB Data", SND_SOC_NOPM, 0, 0, NULL, 0),
+	SND_SOC_DAPM_SIGGEN("FB Gen"),
+};
+
+static const struct snd_soc_dapm_route rt1318_dapm_routes[] = {
+	{ "DAC", "Switch", "DP1RX" },
+	{ "CLASS D", NULL, "DAC" },
+	{ "SPOL", NULL, "CLASS D" },
+	{ "SPOR", NULL, "CLASS D" },
+
+	{ "FB Data", NULL, "FB Gen" },
+	{ "DP2TX", NULL, "FB Data" },
+};
+
+static int rt1318_set_sdw_stream(struct snd_soc_dai *dai, void *sdw_stream,
+				int direction)
+{
+	struct sdw_stream_data *stream;
+
+	if (!sdw_stream)
+		return 0;
+
+	stream = kzalloc(sizeof(*stream), GFP_KERNEL);
+	if (!stream)
+		return -ENOMEM;
+
+	stream->sdw_stream = sdw_stream;
+
+	/* Use tx_mask or rx_mask to configure stream tag and set dma_data */
+	if (direction == SNDRV_PCM_STREAM_PLAYBACK)
+		dai->playback_dma_data = stream;
+	else
+		dai->capture_dma_data = stream;
+
+	return 0;
+}
+
+static void rt1318_sdw_shutdown(struct snd_pcm_substream *substream,
+				struct snd_soc_dai *dai)
+{
+	struct sdw_stream_data *stream;
+
+	stream = snd_soc_dai_get_dma_data(dai, substream);
+	snd_soc_dai_set_dma_data(dai, substream, NULL);
+	kfree(stream);
+}
+
+static int rt1318_sdw_hw_params(struct snd_pcm_substream *substream,
+	struct snd_pcm_hw_params *params, struct snd_soc_dai *dai)
+{
+	struct snd_soc_component *component = dai->component;
+	struct rt1318_sdw_priv *rt1318 =
+		snd_soc_component_get_drvdata(component);
+	struct sdw_stream_config stream_config;
+	struct sdw_port_config port_config;
+	enum sdw_data_direction direction;
+	struct sdw_stream_data *stream;
+	int retval, port, num_channels, ch_mask;
+	unsigned int sampling_rate;
+
+	dev_dbg(dai->dev, "%s %s", __func__, dai->name);
+	stream = snd_soc_dai_get_dma_data(dai, substream);
+
+	if (!stream)
+		return -EINVAL;
+
+	if (!rt1318->sdw_slave)
+		return -EINVAL;
+
+	/* SoundWire specific configuration */
+	/* port 1 for playback */
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		direction = SDW_DATA_DIR_RX;
+		port = 1;
+	} else {
+		direction = SDW_DATA_DIR_TX;
+		port = 2;
+	}
+
+	num_channels = params_channels(params);
+	ch_mask = (1 << num_channels) - 1;
+
+	stream_config.frame_rate = params_rate(params);
+	stream_config.ch_count = num_channels;
+	stream_config.bps = snd_pcm_format_width(params_format(params));
+	stream_config.direction = direction;
+
+	port_config.ch_mask = ch_mask;
+	port_config.num = port;
+
+	retval = sdw_stream_add_slave(rt1318->sdw_slave, &stream_config,
+				&port_config, 1, stream->sdw_stream);
+	if (retval) {
+		dev_err(dai->dev, "Unable to configure port\n");
+		return retval;
+	}
+
+	/* sampling rate configuration */
+	switch (params_rate(params)) {
+	case 16000:
+		sampling_rate = RT1318_SDCA_RATE_16000HZ;
+		break;
+	case 32000:
+		sampling_rate = RT1318_SDCA_RATE_32000HZ;
+		break;
+	case 44100:
+		sampling_rate = RT1318_SDCA_RATE_44100HZ;
+		break;
+	case 48000:
+		sampling_rate = RT1318_SDCA_RATE_48000HZ;
+		break;
+	case 96000:
+		sampling_rate = RT1318_SDCA_RATE_96000HZ;
+		break;
+	case 192000:
+		sampling_rate = RT1318_SDCA_RATE_192000HZ;
+		break;
+	default:
+		dev_err(component->dev, "Rate %d is not supported\n",
+			params_rate(params));
+		return -EINVAL;
+	}
+
+	/* set sampling frequency */
+	regmap_write(rt1318->regmap,
+		SDW_SDCA_CTL(FUNC_NUM_SMART_AMP, RT1318_SDCA_ENT_CS21, RT1318_SDCA_CTL_SAMPLE_FREQ_INDEX, 0),
+		sampling_rate);
+
+	return 0;
+}
+
+static int rt1318_sdw_pcm_hw_free(struct snd_pcm_substream *substream,
+				struct snd_soc_dai *dai)
+{
+	struct snd_soc_component *component = dai->component;
+	struct rt1318_sdw_priv *rt1318 =
+		snd_soc_component_get_drvdata(component);
+	struct sdw_stream_data *stream =
+		snd_soc_dai_get_dma_data(dai, substream);
+
+	if (!rt1318->sdw_slave)
+		return -EINVAL;
+
+	sdw_stream_remove_slave(rt1318->sdw_slave, stream->sdw_stream);
+	return 0;
+}
+
+/*
+ * slave_ops: callbacks for get_clock_stop_mode, clock_stop and
+ * port_prep are not defined for now
+ */
+static const struct sdw_slave_ops rt1318_slave_ops = {
+	.read_prop = rt1318_read_prop,
+	.update_status = rt1318_update_status,
+};
+
+static int rt1318_sdw_component_probe(struct snd_soc_component *component)
+{
+	int ret;
+	struct rt1318_sdw_priv *rt1318 = snd_soc_component_get_drvdata(component);
+
+	rt1318->component = component;
+
+	ret = pm_runtime_resume(component->dev);
+	dev_dbg(&rt1318->sdw_slave->dev, "%s pm_runtime_resume, ret=%d", __func__, ret);
+	if (ret < 0 && ret != -EACCES)
+		return ret;
+
+	return 0;
+}
+
+static const struct snd_soc_component_driver soc_component_sdw_rt1318 = {
+	.probe = rt1318_sdw_component_probe,
+	.controls = rt1318_snd_controls,
+	.num_controls = ARRAY_SIZE(rt1318_snd_controls),
+	.dapm_widgets = rt1318_dapm_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(rt1318_dapm_widgets),
+	.dapm_routes = rt1318_dapm_routes,
+	.num_dapm_routes = ARRAY_SIZE(rt1318_dapm_routes),
+	.endianness = 1,
+};
+
+static const struct snd_soc_dai_ops rt1318_aif_dai_ops = {
+	.hw_params = rt1318_sdw_hw_params,
+	.hw_free	= rt1318_sdw_pcm_hw_free,
+	.set_stream	= rt1318_set_sdw_stream,
+	.shutdown	= rt1318_sdw_shutdown,
+};
+
+#define RT1318_STEREO_RATES (SNDRV_PCM_RATE_16000 | SNDRV_PCM_RATE_32000 | SNDRV_PCM_RATE_44100 | \
+	SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_96000 | SNDRV_PCM_RATE_192000)
+#define RT1318_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S24_LE | \
+	SNDRV_PCM_FMTBIT_S32_LE)
+
+static struct snd_soc_dai_driver rt1318_sdw_dai[] = {
+	{
+		.name = "rt1318-aif",
+		.playback = {
+			.stream_name = "DP1 Playback",
+			.channels_min = 1,
+			.channels_max = 2,
+			.rates = RT1318_STEREO_RATES,
+			.formats = RT1318_FORMATS,
+		},
+		.capture = {
+			.stream_name = "DP2 Capture",
+			.channels_min = 1,
+			.channels_max = 2,
+			.rates = RT1318_STEREO_RATES,
+			.formats = RT1318_FORMATS,
+		},
+		.ops = &rt1318_aif_dai_ops,
+	},
+};
+
+static int rt1318_sdw_init(struct device *dev, struct regmap *regmap,
+				struct sdw_slave *slave)
+{
+	struct rt1318_sdw_priv *rt1318;
+	int ret;
+
+	rt1318 = devm_kzalloc(dev, sizeof(*rt1318), GFP_KERNEL);
+	if (!rt1318)
+		return -ENOMEM;
+
+	dev_set_drvdata(dev, rt1318);
+	rt1318->sdw_slave = slave;
+	rt1318->regmap = regmap;
+
+	/*
+	 * Mark hw_init to false
+	 * HW init will be performed when device reports present
+	 */
+	rt1318->hw_init = false;
+	rt1318->first_hw_init = false;
+
+	ret =  devm_snd_soc_register_component(dev,
+				&soc_component_sdw_rt1318,
+				rt1318_sdw_dai,
+				ARRAY_SIZE(rt1318_sdw_dai));
+
+	dev_dbg(&slave->dev, "%s\n", __func__);
+
+	return ret;
+}
+
+static int rt1318_sdw_probe(struct sdw_slave *slave,
+				const struct sdw_device_id *id)
+{
+	struct regmap *regmap;
+
+	/* Regmap Initialization */
+	regmap = devm_regmap_init_sdw(slave, &rt1318_sdw_regmap);
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
+
+	return rt1318_sdw_init(&slave->dev, regmap, slave);
+}
+
+static int rt1318_sdw_remove(struct sdw_slave *slave)
+{
+	struct rt1318_sdw_priv *rt1318 = dev_get_drvdata(&slave->dev);
+
+	if (rt1318->first_hw_init)
+		pm_runtime_disable(&slave->dev);
+
+	return 0;
+}
+
+static const struct sdw_device_id rt1318_id[] = {
+	SDW_SLAVE_ENTRY_EXT(0x025d, 0x1318, 0x3, 0x1, 0),
+	{},
+};
+MODULE_DEVICE_TABLE(sdw, rt1318_id);
+
+static int __maybe_unused rt1318_dev_suspend(struct device *dev)
+{
+	struct rt1318_sdw_priv *rt1318 = dev_get_drvdata(dev);
+
+	if (!rt1318->hw_init)
+		return 0;
+
+	regcache_cache_only(rt1318->regmap, true);
+	return 0;
+}
+
+#define RT1318_PROBE_TIMEOUT 5000
+
+static int __maybe_unused rt1318_dev_resume(struct device *dev)
+{
+	struct sdw_slave *slave = dev_to_sdw_dev(dev);
+	struct rt1318_sdw_priv *rt1318 = dev_get_drvdata(dev);
+	unsigned long time;
+
+	if (!rt1318->first_hw_init)
+		return 0;
+
+	if (!slave->unattach_request)
+		goto regmap_sync;
+
+	time = wait_for_completion_timeout(&slave->initialization_complete,
+				msecs_to_jiffies(RT1318_PROBE_TIMEOUT));
+	if (!time) {
+		dev_err(&slave->dev, "Initialization not complete, timed out\n");
+		return -ETIMEDOUT;
+	}
+
+regmap_sync:
+	slave->unattach_request = 0;
+	regcache_cache_only(rt1318->regmap, false);
+	regcache_sync(rt1318->regmap);
+
+	return 0;
+}
+
+static const struct dev_pm_ops rt1318_pm = {
+	SET_SYSTEM_SLEEP_PM_OPS(rt1318_dev_suspend, rt1318_dev_resume)
+	SET_RUNTIME_PM_OPS(rt1318_dev_suspend, rt1318_dev_resume, NULL)
+};
+
+static struct sdw_driver rt1318_sdw_driver = {
+	.driver = {
+		.name = "rt1318-sdca",
+		.owner = THIS_MODULE,
+		.pm = &rt1318_pm,
+	},
+	.probe = rt1318_sdw_probe,
+	.remove = rt1318_sdw_remove,
+	.ops = &rt1318_slave_ops,
+	.id_table = rt1318_id,
+};
+module_sdw_driver(rt1318_sdw_driver);
+
+MODULE_DESCRIPTION("ASoC RT1318 driver SDCA SDW");
+MODULE_AUTHOR("Shuming Fan <shumingf@realtek.com>");
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/codecs/rt1318-sdw.h b/sound/soc/codecs/rt1318-sdw.h
new file mode 100644
index 000000000000..4d7ac9c4bd8d
--- /dev/null
+++ b/sound/soc/codecs/rt1318-sdw.h
@@ -0,0 +1,101 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * rt1318-sdw.h -- RT1318 SDCA ALSA SoC audio driver header
+ *
+ * Copyright(c) 2022 Realtek Semiconductor Corp.
+ */
+
+#ifndef __RT1318_SDW_H__
+#define __RT1318_SDW_H__
+
+#include <linux/regmap.h>
+#include <linux/soundwire/sdw.h>
+#include <linux/soundwire/sdw_type.h>
+#include <linux/soundwire/sdw_registers.h>
+#include <sound/soc.h>
+
+/* imp-defined registers */
+#define RT1318_SAPU_SM 0x3203
+
+#define R1318_TCON	0xc203
+#define R1318_TCON_RELATED_1	0xc206
+
+#define R1318_SPK_TEMPERATRUE_PROTECTION_0	0xdb00
+#define R1318_SPK_TEMPERATRUE_PROTECTION_L_4	0xdb08
+#define R1318_SPK_TEMPERATRUE_PROTECTION_R_4	0xdd08
+
+#define R1318_SPK_TEMPERATRUE_PROTECTION_L_6	0xdb12
+#define R1318_SPK_TEMPERATRUE_PROTECTION_R_6	0xdd12
+
+#define RT1318_INIT_RECIPROCAL_REG_L_24		0xdbb5
+#define RT1318_INIT_RECIPROCAL_REG_L_23_16	0xdbb6
+#define RT1318_INIT_RECIPROCAL_REG_L_15_8	0xdbb7
+#define RT1318_INIT_RECIPROCAL_REG_L_7_0	0xdbb8
+#define RT1318_INIT_RECIPROCAL_REG_R_24		0xddb5
+#define RT1318_INIT_RECIPROCAL_REG_R_23_16	0xddb6
+#define RT1318_INIT_RECIPROCAL_REG_R_15_8	0xddb7
+#define RT1318_INIT_RECIPROCAL_REG_R_7_0	0xddb8
+
+#define RT1318_INIT_R0_RECIPROCAL_SYN_L_24 0xdbc5
+#define RT1318_INIT_R0_RECIPROCAL_SYN_L_23_16 0xdbc6
+#define RT1318_INIT_R0_RECIPROCAL_SYN_L_15_8 0xdbc7
+#define RT1318_INIT_R0_RECIPROCAL_SYN_L_7_0 0xdbc8
+#define RT1318_INIT_R0_RECIPROCAL_SYN_R_24 0xddc5
+#define RT1318_INIT_R0_RECIPROCAL_SYN_R_23_16 0xddc6
+#define RT1318_INIT_R0_RECIPROCAL_SYN_R_15_8 0xddc7
+#define RT1318_INIT_R0_RECIPROCAL_SYN_R_7_0 0xddc8
+
+#define RT1318_R0_COMPARE_FLAG_L	0xdb35
+#define RT1318_R0_COMPARE_FLAG_R	0xdd35
+
+#define RT1318_STP_INITIAL_RS_TEMP_H 0xdd93
+#define RT1318_STP_INITIAL_RS_TEMP_L 0xdd94
+
+/* RT1318 SDCA Control - function number */
+#define FUNC_NUM_SMART_AMP 0x04
+
+/* RT1318 SDCA entity */
+#define RT1318_SDCA_ENT_PDE23 0x31
+#define RT1318_SDCA_ENT_XU24 0x24
+#define RT1318_SDCA_ENT_FU21 0x03
+#define RT1318_SDCA_ENT_UDMPU21 0x02
+#define RT1318_SDCA_ENT_CS21 0x21
+#define RT1318_SDCA_ENT_SAPU 0x29
+
+/* RT1318 SDCA control */
+#define RT1318_SDCA_CTL_SAMPLE_FREQ_INDEX 0x10
+#define RT1318_SDCA_CTL_REQ_POWER_STATE 0x01
+#define RT1318_SDCA_CTL_FU_MUTE 0x01
+#define RT1318_SDCA_CTL_FU_VOLUME 0x02
+#define RT1318_SDCA_CTL_UDMPU_CLUSTER 0x10
+#define RT1318_SDCA_CTL_SAPU_PROTECTION_MODE 0x10
+#define RT1318_SDCA_CTL_SAPU_PROTECTION_STATUS 0x11
+
+/* RT1318 SDCA channel */
+#define CH_L 0x01
+#define CH_R 0x02
+
+/* sample frequency index */
+#define RT1318_SDCA_RATE_16000HZ		0x04
+#define RT1318_SDCA_RATE_32000HZ		0x07
+#define RT1318_SDCA_RATE_44100HZ		0x08
+#define RT1318_SDCA_RATE_48000HZ		0x09
+#define RT1318_SDCA_RATE_96000HZ		0x0b
+#define RT1318_SDCA_RATE_192000HZ		0x0d
+
+
+struct rt1318_sdw_priv {
+	struct snd_soc_component *component;
+	struct regmap *regmap;
+	struct sdw_slave *sdw_slave;
+	enum sdw_slave_status status;
+	struct sdw_bus_params params;
+	bool hw_init;
+	bool first_hw_init;
+};
+
+struct sdw_stream_data {
+	struct sdw_stream_runtime *sdw_stream;
+};
+
+#endif /* __RT1318_SDW_H__ */
diff --git a/sound/soc/codecs/rt711-sdca-sdw.c b/sound/soc/codecs/rt711-sdca-sdw.c
index 88a8392a58ed..e23cec4c457d 100644
--- a/sound/soc/codecs/rt711-sdca-sdw.c
+++ b/sound/soc/codecs/rt711-sdca-sdw.c
@@ -338,7 +338,7 @@ static int rt711_sdca_interrupt_callback(struct sdw_slave *slave,
 	return ret;
 }
 
-static struct sdw_slave_ops rt711_sdca_slave_ops = {
+static const struct sdw_slave_ops rt711_sdca_slave_ops = {
 	.read_prop = rt711_sdca_read_prop,
 	.interrupt_callback = rt711_sdca_interrupt_callback,
 	.update_status = rt711_sdca_update_status,
diff --git a/sound/soc/codecs/rt715-sdca-sdw.c b/sound/soc/codecs/rt715-sdca-sdw.c
index c54ecf3e6987..38a82e4e2f95 100644
--- a/sound/soc/codecs/rt715-sdca-sdw.c
+++ b/sound/soc/codecs/rt715-sdca-sdw.c
@@ -172,7 +172,7 @@ static int rt715_sdca_read_prop(struct sdw_slave *slave)
 	return 0;
 }
 
-static struct sdw_slave_ops rt715_sdca_slave_ops = {
+static const struct sdw_slave_ops rt715_sdca_slave_ops = {
 	.read_prop = rt715_sdca_read_prop,
 	.update_status = rt715_sdca_update_status,
 };
diff --git a/sound/soc/codecs/wcd938x-sdw.c b/sound/soc/codecs/wcd938x-sdw.c
index 1bf3c06a2b62..402286dfaea4 100644
--- a/sound/soc/codecs/wcd938x-sdw.c
+++ b/sound/soc/codecs/wcd938x-sdw.c
@@ -161,6 +161,14 @@ EXPORT_SYMBOL_GPL(wcd938x_sdw_set_sdw_stream);
 static int wcd9380_update_status(struct sdw_slave *slave,
 				 enum sdw_slave_status status)
 {
+	struct wcd938x_sdw_priv *wcd = dev_get_drvdata(&slave->dev);
+
+	if (wcd->regmap && (status == SDW_SLAVE_ATTACHED)) {
+		/* Write out any cached changes that happened between probe and attach */
+		regcache_cache_only(wcd->regmap, false);
+		return regcache_sync(wcd->regmap);
+	}
+
 	return 0;
 }
 
@@ -177,21 +185,1015 @@ static int wcd9380_interrupt_callback(struct sdw_slave *slave,
 {
 	struct wcd938x_sdw_priv *wcd = dev_get_drvdata(&slave->dev);
 	struct irq_domain *slave_irq = wcd->slave_irq;
-	struct regmap *regmap = dev_get_regmap(&slave->dev, NULL);
 	u32 sts1, sts2, sts3;
 
 	do {
 		handle_nested_irq(irq_find_mapping(slave_irq, 0));
-		regmap_read(regmap, WCD938X_DIGITAL_INTR_STATUS_0, &sts1);
-		regmap_read(regmap, WCD938X_DIGITAL_INTR_STATUS_1, &sts2);
-		regmap_read(regmap, WCD938X_DIGITAL_INTR_STATUS_2, &sts3);
+		regmap_read(wcd->regmap, WCD938X_DIGITAL_INTR_STATUS_0, &sts1);
+		regmap_read(wcd->regmap, WCD938X_DIGITAL_INTR_STATUS_1, &sts2);
+		regmap_read(wcd->regmap, WCD938X_DIGITAL_INTR_STATUS_2, &sts3);
 
 	} while (sts1 || sts2 || sts3);
 
 	return IRQ_HANDLED;
 }
 
-static struct sdw_slave_ops wcd9380_slave_ops = {
+static const struct reg_default wcd938x_defaults[] = {
+	{WCD938X_ANA_PAGE_REGISTER,                            0x00},
+	{WCD938X_ANA_BIAS,                                     0x00},
+	{WCD938X_ANA_RX_SUPPLIES,                              0x00},
+	{WCD938X_ANA_HPH,                                      0x0C},
+	{WCD938X_ANA_EAR,                                      0x00},
+	{WCD938X_ANA_EAR_COMPANDER_CTL,                        0x02},
+	{WCD938X_ANA_TX_CH1,                                   0x20},
+	{WCD938X_ANA_TX_CH2,                                   0x00},
+	{WCD938X_ANA_TX_CH3,                                   0x20},
+	{WCD938X_ANA_TX_CH4,                                   0x00},
+	{WCD938X_ANA_MICB1_MICB2_DSP_EN_LOGIC,                 0x00},
+	{WCD938X_ANA_MICB3_DSP_EN_LOGIC,                       0x00},
+	{WCD938X_ANA_MBHC_MECH,                                0x39},
+	{WCD938X_ANA_MBHC_ELECT,                               0x08},
+	{WCD938X_ANA_MBHC_ZDET,                                0x00},
+	{WCD938X_ANA_MBHC_RESULT_1,                            0x00},
+	{WCD938X_ANA_MBHC_RESULT_2,                            0x00},
+	{WCD938X_ANA_MBHC_RESULT_3,                            0x00},
+	{WCD938X_ANA_MBHC_BTN0,                                0x00},
+	{WCD938X_ANA_MBHC_BTN1,                                0x10},
+	{WCD938X_ANA_MBHC_BTN2,                                0x20},
+	{WCD938X_ANA_MBHC_BTN3,                                0x30},
+	{WCD938X_ANA_MBHC_BTN4,                                0x40},
+	{WCD938X_ANA_MBHC_BTN5,                                0x50},
+	{WCD938X_ANA_MBHC_BTN6,                                0x60},
+	{WCD938X_ANA_MBHC_BTN7,                                0x70},
+	{WCD938X_ANA_MICB1,                                    0x10},
+	{WCD938X_ANA_MICB2,                                    0x10},
+	{WCD938X_ANA_MICB2_RAMP,                               0x00},
+	{WCD938X_ANA_MICB3,                                    0x10},
+	{WCD938X_ANA_MICB4,                                    0x10},
+	{WCD938X_BIAS_CTL,                                     0x2A},
+	{WCD938X_BIAS_VBG_FINE_ADJ,                            0x55},
+	{WCD938X_LDOL_VDDCX_ADJUST,                            0x01},
+	{WCD938X_LDOL_DISABLE_LDOL,                            0x00},
+	{WCD938X_MBHC_CTL_CLK,                                 0x00},
+	{WCD938X_MBHC_CTL_ANA,                                 0x00},
+	{WCD938X_MBHC_CTL_SPARE_1,                             0x00},
+	{WCD938X_MBHC_CTL_SPARE_2,                             0x00},
+	{WCD938X_MBHC_CTL_BCS,                                 0x00},
+	{WCD938X_MBHC_MOISTURE_DET_FSM_STATUS,                 0x00},
+	{WCD938X_MBHC_TEST_CTL,                                0x00},
+	{WCD938X_LDOH_MODE,                                    0x2B},
+	{WCD938X_LDOH_BIAS,                                    0x68},
+	{WCD938X_LDOH_STB_LOADS,                               0x00},
+	{WCD938X_LDOH_SLOWRAMP,                                0x50},
+	{WCD938X_MICB1_TEST_CTL_1,                             0x1A},
+	{WCD938X_MICB1_TEST_CTL_2,                             0x00},
+	{WCD938X_MICB1_TEST_CTL_3,                             0xA4},
+	{WCD938X_MICB2_TEST_CTL_1,                             0x1A},
+	{WCD938X_MICB2_TEST_CTL_2,                             0x00},
+	{WCD938X_MICB2_TEST_CTL_3,                             0x24},
+	{WCD938X_MICB3_TEST_CTL_1,                             0x1A},
+	{WCD938X_MICB3_TEST_CTL_2,                             0x00},
+	{WCD938X_MICB3_TEST_CTL_3,                             0xA4},
+	{WCD938X_MICB4_TEST_CTL_1,                             0x1A},
+	{WCD938X_MICB4_TEST_CTL_2,                             0x00},
+	{WCD938X_MICB4_TEST_CTL_3,                             0xA4},
+	{WCD938X_TX_COM_ADC_VCM,                               0x39},
+	{WCD938X_TX_COM_BIAS_ATEST,                            0xE0},
+	{WCD938X_TX_COM_SPARE1,                                0x00},
+	{WCD938X_TX_COM_SPARE2,                                0x00},
+	{WCD938X_TX_COM_TXFE_DIV_CTL,                          0x22},
+	{WCD938X_TX_COM_TXFE_DIV_START,                        0x00},
+	{WCD938X_TX_COM_SPARE3,                                0x00},
+	{WCD938X_TX_COM_SPARE4,                                0x00},
+	{WCD938X_TX_1_2_TEST_EN,                               0xCC},
+	{WCD938X_TX_1_2_ADC_IB,                                0xE9},
+	{WCD938X_TX_1_2_ATEST_REFCTL,                          0x0A},
+	{WCD938X_TX_1_2_TEST_CTL,                              0x38},
+	{WCD938X_TX_1_2_TEST_BLK_EN1,                          0xFF},
+	{WCD938X_TX_1_2_TXFE1_CLKDIV,                          0x00},
+	{WCD938X_TX_1_2_SAR2_ERR,                              0x00},
+	{WCD938X_TX_1_2_SAR1_ERR,                              0x00},
+	{WCD938X_TX_3_4_TEST_EN,                               0xCC},
+	{WCD938X_TX_3_4_ADC_IB,                                0xE9},
+	{WCD938X_TX_3_4_ATEST_REFCTL,                          0x0A},
+	{WCD938X_TX_3_4_TEST_CTL,                              0x38},
+	{WCD938X_TX_3_4_TEST_BLK_EN3,                          0xFF},
+	{WCD938X_TX_3_4_TXFE3_CLKDIV,                          0x00},
+	{WCD938X_TX_3_4_SAR4_ERR,                              0x00},
+	{WCD938X_TX_3_4_SAR3_ERR,                              0x00},
+	{WCD938X_TX_3_4_TEST_BLK_EN2,                          0xFB},
+	{WCD938X_TX_3_4_TXFE2_CLKDIV,                          0x00},
+	{WCD938X_TX_3_4_SPARE1,                                0x00},
+	{WCD938X_TX_3_4_TEST_BLK_EN4,                          0xFB},
+	{WCD938X_TX_3_4_TXFE4_CLKDIV,                          0x00},
+	{WCD938X_TX_3_4_SPARE2,                                0x00},
+	{WCD938X_CLASSH_MODE_1,                                0x40},
+	{WCD938X_CLASSH_MODE_2,                                0x3A},
+	{WCD938X_CLASSH_MODE_3,                                0x00},
+	{WCD938X_CLASSH_CTRL_VCL_1,                            0x70},
+	{WCD938X_CLASSH_CTRL_VCL_2,                            0x82},
+	{WCD938X_CLASSH_CTRL_CCL_1,                            0x31},
+	{WCD938X_CLASSH_CTRL_CCL_2,                            0x80},
+	{WCD938X_CLASSH_CTRL_CCL_3,                            0x80},
+	{WCD938X_CLASSH_CTRL_CCL_4,                            0x51},
+	{WCD938X_CLASSH_CTRL_CCL_5,                            0x00},
+	{WCD938X_CLASSH_BUCK_TMUX_A_D,                         0x00},
+	{WCD938X_CLASSH_BUCK_SW_DRV_CNTL,                      0x77},
+	{WCD938X_CLASSH_SPARE,                                 0x00},
+	{WCD938X_FLYBACK_EN,                                   0x4E},
+	{WCD938X_FLYBACK_VNEG_CTRL_1,                          0x0B},
+	{WCD938X_FLYBACK_VNEG_CTRL_2,                          0x45},
+	{WCD938X_FLYBACK_VNEG_CTRL_3,                          0x74},
+	{WCD938X_FLYBACK_VNEG_CTRL_4,                          0x7F},
+	{WCD938X_FLYBACK_VNEG_CTRL_5,                          0x83},
+	{WCD938X_FLYBACK_VNEG_CTRL_6,                          0x98},
+	{WCD938X_FLYBACK_VNEG_CTRL_7,                          0xA9},
+	{WCD938X_FLYBACK_VNEG_CTRL_8,                          0x68},
+	{WCD938X_FLYBACK_VNEG_CTRL_9,                          0x64},
+	{WCD938X_FLYBACK_VNEGDAC_CTRL_1,                       0xED},
+	{WCD938X_FLYBACK_VNEGDAC_CTRL_2,                       0xF0},
+	{WCD938X_FLYBACK_VNEGDAC_CTRL_3,                       0xA6},
+	{WCD938X_FLYBACK_CTRL_1,                               0x65},
+	{WCD938X_FLYBACK_TEST_CTL,                             0x00},
+	{WCD938X_RX_AUX_SW_CTL,                                0x00},
+	{WCD938X_RX_PA_AUX_IN_CONN,                            0x01},
+	{WCD938X_RX_TIMER_DIV,                                 0x32},
+	{WCD938X_RX_OCP_CTL,                                   0x1F},
+	{WCD938X_RX_OCP_COUNT,                                 0x77},
+	{WCD938X_RX_BIAS_EAR_DAC,                              0xA0},
+	{WCD938X_RX_BIAS_EAR_AMP,                              0xAA},
+	{WCD938X_RX_BIAS_HPH_LDO,                              0xA9},
+	{WCD938X_RX_BIAS_HPH_PA,                               0xAA},
+	{WCD938X_RX_BIAS_HPH_RDACBUFF_CNP2,                    0x8A},
+	{WCD938X_RX_BIAS_HPH_RDAC_LDO,                         0x88},
+	{WCD938X_RX_BIAS_HPH_CNP1,                             0x82},
+	{WCD938X_RX_BIAS_HPH_LOWPOWER,                         0x82},
+	{WCD938X_RX_BIAS_AUX_DAC,                              0xA0},
+	{WCD938X_RX_BIAS_AUX_AMP,                              0xAA},
+	{WCD938X_RX_BIAS_VNEGDAC_BLEEDER,                      0x50},
+	{WCD938X_RX_BIAS_MISC,                                 0x00},
+	{WCD938X_RX_BIAS_BUCK_RST,                             0x08},
+	{WCD938X_RX_BIAS_BUCK_VREF_ERRAMP,                     0x44},
+	{WCD938X_RX_BIAS_FLYB_ERRAMP,                          0x40},
+	{WCD938X_RX_BIAS_FLYB_BUFF,                            0xAA},
+	{WCD938X_RX_BIAS_FLYB_MID_RST,                         0x14},
+	{WCD938X_HPH_L_STATUS,                                 0x04},
+	{WCD938X_HPH_R_STATUS,                                 0x04},
+	{WCD938X_HPH_CNP_EN,                                   0x80},
+	{WCD938X_HPH_CNP_WG_CTL,                               0x9A},
+	{WCD938X_HPH_CNP_WG_TIME,                              0x14},
+	{WCD938X_HPH_OCP_CTL,                                  0x28},
+	{WCD938X_HPH_AUTO_CHOP,                                0x16},
+	{WCD938X_HPH_CHOP_CTL,                                 0x83},
+	{WCD938X_HPH_PA_CTL1,                                  0x46},
+	{WCD938X_HPH_PA_CTL2,                                  0x50},
+	{WCD938X_HPH_L_EN,                                     0x80},
+	{WCD938X_HPH_L_TEST,                                   0xE0},
+	{WCD938X_HPH_L_ATEST,                                  0x50},
+	{WCD938X_HPH_R_EN,                                     0x80},
+	{WCD938X_HPH_R_TEST,                                   0xE0},
+	{WCD938X_HPH_R_ATEST,                                  0x54},
+	{WCD938X_HPH_RDAC_CLK_CTL1,                            0x99},
+	{WCD938X_HPH_RDAC_CLK_CTL2,                            0x9B},
+	{WCD938X_HPH_RDAC_LDO_CTL,                             0x33},
+	{WCD938X_HPH_RDAC_CHOP_CLK_LP_CTL,                     0x00},
+	{WCD938X_HPH_REFBUFF_UHQA_CTL,                         0x68},
+	{WCD938X_HPH_REFBUFF_LP_CTL,                           0x0E},
+	{WCD938X_HPH_L_DAC_CTL,                                0x20},
+	{WCD938X_HPH_R_DAC_CTL,                                0x20},
+	{WCD938X_HPH_SURGE_HPHLR_SURGE_COMP_SEL,               0x55},
+	{WCD938X_HPH_SURGE_HPHLR_SURGE_EN,                     0x19},
+	{WCD938X_HPH_SURGE_HPHLR_SURGE_MISC1,                  0xA0},
+	{WCD938X_HPH_SURGE_HPHLR_SURGE_STATUS,                 0x00},
+	{WCD938X_EAR_EAR_EN_REG,                               0x22},
+	{WCD938X_EAR_EAR_PA_CON,                               0x44},
+	{WCD938X_EAR_EAR_SP_CON,                               0xDB},
+	{WCD938X_EAR_EAR_DAC_CON,                              0x80},
+	{WCD938X_EAR_EAR_CNP_FSM_CON,                          0xB2},
+	{WCD938X_EAR_TEST_CTL,                                 0x00},
+	{WCD938X_EAR_STATUS_REG_1,                             0x00},
+	{WCD938X_EAR_STATUS_REG_2,                             0x08},
+	{WCD938X_ANA_NEW_PAGE_REGISTER,                        0x00},
+	{WCD938X_HPH_NEW_ANA_HPH2,                             0x00},
+	{WCD938X_HPH_NEW_ANA_HPH3,                             0x00},
+	{WCD938X_SLEEP_CTL,                                    0x16},
+	{WCD938X_SLEEP_WATCHDOG_CTL,                           0x00},
+	{WCD938X_MBHC_NEW_ELECT_REM_CLAMP_CTL,                 0x00},
+	{WCD938X_MBHC_NEW_CTL_1,                               0x02},
+	{WCD938X_MBHC_NEW_CTL_2,                               0x05},
+	{WCD938X_MBHC_NEW_PLUG_DETECT_CTL,                     0xE9},
+	{WCD938X_MBHC_NEW_ZDET_ANA_CTL,                        0x0F},
+	{WCD938X_MBHC_NEW_ZDET_RAMP_CTL,                       0x00},
+	{WCD938X_MBHC_NEW_FSM_STATUS,                          0x00},
+	{WCD938X_MBHC_NEW_ADC_RESULT,                          0x00},
+	{WCD938X_TX_NEW_AMIC_MUX_CFG,                          0x00},
+	{WCD938X_AUX_AUXPA,                                    0x00},
+	{WCD938X_LDORXTX_MODE,                                 0x0C},
+	{WCD938X_LDORXTX_CONFIG,                               0x10},
+	{WCD938X_DIE_CRACK_DIE_CRK_DET_EN,                     0x00},
+	{WCD938X_DIE_CRACK_DIE_CRK_DET_OUT,                    0x00},
+	{WCD938X_HPH_NEW_INT_RDAC_GAIN_CTL,                    0x40},
+	{WCD938X_HPH_NEW_INT_RDAC_HD2_CTL_L,                   0x81},
+	{WCD938X_HPH_NEW_INT_RDAC_VREF_CTL,                    0x10},
+	{WCD938X_HPH_NEW_INT_RDAC_OVERRIDE_CTL,                0x00},
+	{WCD938X_HPH_NEW_INT_RDAC_HD2_CTL_R,                   0x81},
+	{WCD938X_HPH_NEW_INT_PA_MISC1,                         0x22},
+	{WCD938X_HPH_NEW_INT_PA_MISC2,                         0x00},
+	{WCD938X_HPH_NEW_INT_PA_RDAC_MISC,                     0x00},
+	{WCD938X_HPH_NEW_INT_HPH_TIMER1,                       0xFE},
+	{WCD938X_HPH_NEW_INT_HPH_TIMER2,                       0x02},
+	{WCD938X_HPH_NEW_INT_HPH_TIMER3,                       0x4E},
+	{WCD938X_HPH_NEW_INT_HPH_TIMER4,                       0x54},
+	{WCD938X_HPH_NEW_INT_PA_RDAC_MISC2,                    0x00},
+	{WCD938X_HPH_NEW_INT_PA_RDAC_MISC3,                    0x00},
+	{WCD938X_HPH_NEW_INT_RDAC_HD2_CTL_L_NEW,               0x90},
+	{WCD938X_HPH_NEW_INT_RDAC_HD2_CTL_R_NEW,               0x90},
+	{WCD938X_RX_NEW_INT_HPH_RDAC_BIAS_LOHIFI,              0x62},
+	{WCD938X_RX_NEW_INT_HPH_RDAC_BIAS_ULP,                 0x01},
+	{WCD938X_RX_NEW_INT_HPH_RDAC_LDO_LP,                   0x11},
+	{WCD938X_MBHC_NEW_INT_MOISTURE_DET_DC_CTRL,            0x57},
+	{WCD938X_MBHC_NEW_INT_MOISTURE_DET_POLLING_CTRL,       0x01},
+	{WCD938X_MBHC_NEW_INT_MECH_DET_CURRENT,                0x00},
+	{WCD938X_MBHC_NEW_INT_SPARE_2,                         0x00},
+	{WCD938X_EAR_INT_NEW_EAR_CHOPPER_CON,                  0xA8},
+	{WCD938X_EAR_INT_NEW_CNP_VCM_CON1,                     0x42},
+	{WCD938X_EAR_INT_NEW_CNP_VCM_CON2,                     0x22},
+	{WCD938X_EAR_INT_NEW_EAR_DYNAMIC_BIAS,                 0x00},
+	{WCD938X_AUX_INT_EN_REG,                               0x00},
+	{WCD938X_AUX_INT_PA_CTRL,                              0x06},
+	{WCD938X_AUX_INT_SP_CTRL,                              0xD2},
+	{WCD938X_AUX_INT_DAC_CTRL,                             0x80},
+	{WCD938X_AUX_INT_CLK_CTRL,                             0x50},
+	{WCD938X_AUX_INT_TEST_CTRL,                            0x00},
+	{WCD938X_AUX_INT_STATUS_REG,                           0x00},
+	{WCD938X_AUX_INT_MISC,                                 0x00},
+	{WCD938X_LDORXTX_INT_BIAS,                             0x6E},
+	{WCD938X_LDORXTX_INT_STB_LOADS_DTEST,                  0x50},
+	{WCD938X_LDORXTX_INT_TEST0,                            0x1C},
+	{WCD938X_LDORXTX_INT_STARTUP_TIMER,                    0xFF},
+	{WCD938X_LDORXTX_INT_TEST1,                            0x1F},
+	{WCD938X_LDORXTX_INT_STATUS,                           0x00},
+	{WCD938X_SLEEP_INT_WATCHDOG_CTL_1,                     0x0A},
+	{WCD938X_SLEEP_INT_WATCHDOG_CTL_2,                     0x0A},
+	{WCD938X_DIE_CRACK_INT_DIE_CRK_DET_INT1,               0x02},
+	{WCD938X_DIE_CRACK_INT_DIE_CRK_DET_INT2,               0x60},
+	{WCD938X_TX_COM_NEW_INT_TXFE_DIVSTOP_L2,               0xFF},
+	{WCD938X_TX_COM_NEW_INT_TXFE_DIVSTOP_L1,               0x7F},
+	{WCD938X_TX_COM_NEW_INT_TXFE_DIVSTOP_L0,               0x3F},
+	{WCD938X_TX_COM_NEW_INT_TXFE_DIVSTOP_ULP1P2M,          0x1F},
+	{WCD938X_TX_COM_NEW_INT_TXFE_DIVSTOP_ULP0P6M,          0x0F},
+	{WCD938X_TX_COM_NEW_INT_TXFE_ICTRL_STG1_L2L1,          0xD7},
+	{WCD938X_TX_COM_NEW_INT_TXFE_ICTRL_STG1_L0,            0xC8},
+	{WCD938X_TX_COM_NEW_INT_TXFE_ICTRL_STG1_ULP,           0xC6},
+	{WCD938X_TX_COM_NEW_INT_TXFE_ICTRL_STG2MAIN_L2L1,      0xD5},
+	{WCD938X_TX_COM_NEW_INT_TXFE_ICTRL_STG2MAIN_L0,        0xCA},
+	{WCD938X_TX_COM_NEW_INT_TXFE_ICTRL_STG2MAIN_ULP,       0x05},
+	{WCD938X_TX_COM_NEW_INT_TXFE_ICTRL_STG2CASC_L2L1L0,    0xA5},
+	{WCD938X_TX_COM_NEW_INT_TXFE_ICTRL_STG2CASC_ULP,       0x13},
+	{WCD938X_TX_COM_NEW_INT_TXADC_SCBIAS_L2L1,             0x88},
+	{WCD938X_TX_COM_NEW_INT_TXADC_SCBIAS_L0ULP,            0x42},
+	{WCD938X_TX_COM_NEW_INT_TXADC_INT_L2,                  0xFF},
+	{WCD938X_TX_COM_NEW_INT_TXADC_INT_L1,                  0x64},
+	{WCD938X_TX_COM_NEW_INT_TXADC_INT_L0,                  0x64},
+	{WCD938X_TX_COM_NEW_INT_TXADC_INT_ULP,                 0x77},
+	{WCD938X_DIGITAL_PAGE_REGISTER,                        0x00},
+	{WCD938X_DIGITAL_CHIP_ID0,                             0x00},
+	{WCD938X_DIGITAL_CHIP_ID1,                             0x00},
+	{WCD938X_DIGITAL_CHIP_ID2,                             0x0D},
+	{WCD938X_DIGITAL_CHIP_ID3,                             0x01},
+	{WCD938X_DIGITAL_SWR_TX_CLK_RATE,                      0x00},
+	{WCD938X_DIGITAL_CDC_RST_CTL,                          0x03},
+	{WCD938X_DIGITAL_TOP_CLK_CFG,                          0x00},
+	{WCD938X_DIGITAL_CDC_ANA_CLK_CTL,                      0x00},
+	{WCD938X_DIGITAL_CDC_DIG_CLK_CTL,                      0xF0},
+	{WCD938X_DIGITAL_SWR_RST_EN,                           0x00},
+	{WCD938X_DIGITAL_CDC_PATH_MODE,                        0x55},
+	{WCD938X_DIGITAL_CDC_RX_RST,                           0x00},
+	{WCD938X_DIGITAL_CDC_RX0_CTL,                          0xFC},
+	{WCD938X_DIGITAL_CDC_RX1_CTL,                          0xFC},
+	{WCD938X_DIGITAL_CDC_RX2_CTL,                          0xFC},
+	{WCD938X_DIGITAL_CDC_TX_ANA_MODE_0_1,                  0x00},
+	{WCD938X_DIGITAL_CDC_TX_ANA_MODE_2_3,                  0x00},
+	{WCD938X_DIGITAL_CDC_COMP_CTL_0,                       0x00},
+	{WCD938X_DIGITAL_CDC_ANA_TX_CLK_CTL,                   0x1E},
+	{WCD938X_DIGITAL_CDC_HPH_DSM_A1_0,                     0x00},
+	{WCD938X_DIGITAL_CDC_HPH_DSM_A1_1,                     0x01},
+	{WCD938X_DIGITAL_CDC_HPH_DSM_A2_0,                     0x63},
+	{WCD938X_DIGITAL_CDC_HPH_DSM_A2_1,                     0x04},
+	{WCD938X_DIGITAL_CDC_HPH_DSM_A3_0,                     0xAC},
+	{WCD938X_DIGITAL_CDC_HPH_DSM_A3_1,                     0x04},
+	{WCD938X_DIGITAL_CDC_HPH_DSM_A4_0,                     0x1A},
+	{WCD938X_DIGITAL_CDC_HPH_DSM_A4_1,                     0x03},
+	{WCD938X_DIGITAL_CDC_HPH_DSM_A5_0,                     0xBC},
+	{WCD938X_DIGITAL_CDC_HPH_DSM_A5_1,                     0x02},
+	{WCD938X_DIGITAL_CDC_HPH_DSM_A6_0,                     0xC7},
+	{WCD938X_DIGITAL_CDC_HPH_DSM_A7_0,                     0xF8},
+	{WCD938X_DIGITAL_CDC_HPH_DSM_C_0,                      0x47},
+	{WCD938X_DIGITAL_CDC_HPH_DSM_C_1,                      0x43},
+	{WCD938X_DIGITAL_CDC_HPH_DSM_C_2,                      0xB1},
+	{WCD938X_DIGITAL_CDC_HPH_DSM_C_3,                      0x17},
+	{WCD938X_DIGITAL_CDC_HPH_DSM_R1,                       0x4D},
+	{WCD938X_DIGITAL_CDC_HPH_DSM_R2,                       0x29},
+	{WCD938X_DIGITAL_CDC_HPH_DSM_R3,                       0x34},
+	{WCD938X_DIGITAL_CDC_HPH_DSM_R4,                       0x59},
+	{WCD938X_DIGITAL_CDC_HPH_DSM_R5,                       0x66},
+	{WCD938X_DIGITAL_CDC_HPH_DSM_R6,                       0x87},
+	{WCD938X_DIGITAL_CDC_HPH_DSM_R7,                       0x64},
+	{WCD938X_DIGITAL_CDC_AUX_DSM_A1_0,                     0x00},
+	{WCD938X_DIGITAL_CDC_AUX_DSM_A1_1,                     0x01},
+	{WCD938X_DIGITAL_CDC_AUX_DSM_A2_0,                     0x96},
+	{WCD938X_DIGITAL_CDC_AUX_DSM_A2_1,                     0x09},
+	{WCD938X_DIGITAL_CDC_AUX_DSM_A3_0,                     0xAB},
+	{WCD938X_DIGITAL_CDC_AUX_DSM_A3_1,                     0x05},
+	{WCD938X_DIGITAL_CDC_AUX_DSM_A4_0,                     0x1C},
+	{WCD938X_DIGITAL_CDC_AUX_DSM_A4_1,                     0x02},
+	{WCD938X_DIGITAL_CDC_AUX_DSM_A5_0,                     0x17},
+	{WCD938X_DIGITAL_CDC_AUX_DSM_A5_1,                     0x02},
+	{WCD938X_DIGITAL_CDC_AUX_DSM_A6_0,                     0xAA},
+	{WCD938X_DIGITAL_CDC_AUX_DSM_A7_0,                     0xE3},
+	{WCD938X_DIGITAL_CDC_AUX_DSM_C_0,                      0x69},
+	{WCD938X_DIGITAL_CDC_AUX_DSM_C_1,                      0x54},
+	{WCD938X_DIGITAL_CDC_AUX_DSM_C_2,                      0x02},
+	{WCD938X_DIGITAL_CDC_AUX_DSM_C_3,                      0x15},
+	{WCD938X_DIGITAL_CDC_AUX_DSM_R1,                       0xA4},
+	{WCD938X_DIGITAL_CDC_AUX_DSM_R2,                       0xB5},
+	{WCD938X_DIGITAL_CDC_AUX_DSM_R3,                       0x86},
+	{WCD938X_DIGITAL_CDC_AUX_DSM_R4,                       0x85},
+	{WCD938X_DIGITAL_CDC_AUX_DSM_R5,                       0xAA},
+	{WCD938X_DIGITAL_CDC_AUX_DSM_R6,                       0xE2},
+	{WCD938X_DIGITAL_CDC_AUX_DSM_R7,                       0x62},
+	{WCD938X_DIGITAL_CDC_HPH_GAIN_RX_0,                    0x55},
+	{WCD938X_DIGITAL_CDC_HPH_GAIN_RX_1,                    0xA9},
+	{WCD938X_DIGITAL_CDC_HPH_GAIN_DSD_0,                   0x3D},
+	{WCD938X_DIGITAL_CDC_HPH_GAIN_DSD_1,                   0x2E},
+	{WCD938X_DIGITAL_CDC_HPH_GAIN_DSD_2,                   0x01},
+	{WCD938X_DIGITAL_CDC_AUX_GAIN_DSD_0,                   0x00},
+	{WCD938X_DIGITAL_CDC_AUX_GAIN_DSD_1,                   0xFC},
+	{WCD938X_DIGITAL_CDC_AUX_GAIN_DSD_2,                   0x01},
+	{WCD938X_DIGITAL_CDC_HPH_GAIN_CTL,                     0x00},
+	{WCD938X_DIGITAL_CDC_AUX_GAIN_CTL,                     0x00},
+	{WCD938X_DIGITAL_CDC_EAR_PATH_CTL,                     0x00},
+	{WCD938X_DIGITAL_CDC_SWR_CLH,                          0x00},
+	{WCD938X_DIGITAL_SWR_CLH_BYP,                          0x00},
+	{WCD938X_DIGITAL_CDC_TX0_CTL,                          0x68},
+	{WCD938X_DIGITAL_CDC_TX1_CTL,                          0x68},
+	{WCD938X_DIGITAL_CDC_TX2_CTL,                          0x68},
+	{WCD938X_DIGITAL_CDC_TX_RST,                           0x00},
+	{WCD938X_DIGITAL_CDC_REQ_CTL,                          0x01},
+	{WCD938X_DIGITAL_CDC_RST,                              0x00},
+	{WCD938X_DIGITAL_CDC_AMIC_CTL,                         0x0F},
+	{WCD938X_DIGITAL_CDC_DMIC_CTL,                         0x04},
+	{WCD938X_DIGITAL_CDC_DMIC1_CTL,                        0x01},
+	{WCD938X_DIGITAL_CDC_DMIC2_CTL,                        0x01},
+	{WCD938X_DIGITAL_CDC_DMIC3_CTL,                        0x01},
+	{WCD938X_DIGITAL_CDC_DMIC4_CTL,                        0x01},
+	{WCD938X_DIGITAL_EFUSE_PRG_CTL,                        0x00},
+	{WCD938X_DIGITAL_EFUSE_CTL,                            0x2B},
+	{WCD938X_DIGITAL_CDC_DMIC_RATE_1_2,                    0x11},
+	{WCD938X_DIGITAL_CDC_DMIC_RATE_3_4,                    0x11},
+	{WCD938X_DIGITAL_PDM_WD_CTL0,                          0x00},
+	{WCD938X_DIGITAL_PDM_WD_CTL1,                          0x00},
+	{WCD938X_DIGITAL_PDM_WD_CTL2,                          0x00},
+	{WCD938X_DIGITAL_INTR_MODE,                            0x00},
+	{WCD938X_DIGITAL_INTR_MASK_0,                          0xFF},
+	{WCD938X_DIGITAL_INTR_MASK_1,                          0xFF},
+	{WCD938X_DIGITAL_INTR_MASK_2,                          0x3F},
+	{WCD938X_DIGITAL_INTR_STATUS_0,                        0x00},
+	{WCD938X_DIGITAL_INTR_STATUS_1,                        0x00},
+	{WCD938X_DIGITAL_INTR_STATUS_2,                        0x00},
+	{WCD938X_DIGITAL_INTR_CLEAR_0,                         0x00},
+	{WCD938X_DIGITAL_INTR_CLEAR_1,                         0x00},
+	{WCD938X_DIGITAL_INTR_CLEAR_2,                         0x00},
+	{WCD938X_DIGITAL_INTR_LEVEL_0,                         0x00},
+	{WCD938X_DIGITAL_INTR_LEVEL_1,                         0x00},
+	{WCD938X_DIGITAL_INTR_LEVEL_2,                         0x00},
+	{WCD938X_DIGITAL_INTR_SET_0,                           0x00},
+	{WCD938X_DIGITAL_INTR_SET_1,                           0x00},
+	{WCD938X_DIGITAL_INTR_SET_2,                           0x00},
+	{WCD938X_DIGITAL_INTR_TEST_0,                          0x00},
+	{WCD938X_DIGITAL_INTR_TEST_1,                          0x00},
+	{WCD938X_DIGITAL_INTR_TEST_2,                          0x00},
+	{WCD938X_DIGITAL_TX_MODE_DBG_EN,                       0x00},
+	{WCD938X_DIGITAL_TX_MODE_DBG_0_1,                      0x00},
+	{WCD938X_DIGITAL_TX_MODE_DBG_2_3,                      0x00},
+	{WCD938X_DIGITAL_LB_IN_SEL_CTL,                        0x00},
+	{WCD938X_DIGITAL_LOOP_BACK_MODE,                       0x00},
+	{WCD938X_DIGITAL_SWR_DAC_TEST,                         0x00},
+	{WCD938X_DIGITAL_SWR_HM_TEST_RX_0,                     0x40},
+	{WCD938X_DIGITAL_SWR_HM_TEST_TX_0,                     0x40},
+	{WCD938X_DIGITAL_SWR_HM_TEST_RX_1,                     0x00},
+	{WCD938X_DIGITAL_SWR_HM_TEST_TX_1,                     0x00},
+	{WCD938X_DIGITAL_SWR_HM_TEST_TX_2,                     0x00},
+	{WCD938X_DIGITAL_SWR_HM_TEST_0,                        0x00},
+	{WCD938X_DIGITAL_SWR_HM_TEST_1,                        0x00},
+	{WCD938X_DIGITAL_PAD_CTL_SWR_0,                        0x8F},
+	{WCD938X_DIGITAL_PAD_CTL_SWR_1,                        0x06},
+	{WCD938X_DIGITAL_I2C_CTL,                              0x00},
+	{WCD938X_DIGITAL_CDC_TX_TANGGU_SW_MODE,                0x00},
+	{WCD938X_DIGITAL_EFUSE_TEST_CTL_0,                     0x00},
+	{WCD938X_DIGITAL_EFUSE_TEST_CTL_1,                     0x00},
+	{WCD938X_DIGITAL_EFUSE_T_DATA_0,                       0x00},
+	{WCD938X_DIGITAL_EFUSE_T_DATA_1,                       0x00},
+	{WCD938X_DIGITAL_PAD_CTL_PDM_RX0,                      0xF1},
+	{WCD938X_DIGITAL_PAD_CTL_PDM_RX1,                      0xF1},
+	{WCD938X_DIGITAL_PAD_CTL_PDM_TX0,                      0xF1},
+	{WCD938X_DIGITAL_PAD_CTL_PDM_TX1,                      0xF1},
+	{WCD938X_DIGITAL_PAD_CTL_PDM_TX2,                      0xF1},
+	{WCD938X_DIGITAL_PAD_INP_DIS_0,                        0x00},
+	{WCD938X_DIGITAL_PAD_INP_DIS_1,                        0x00},
+	{WCD938X_DIGITAL_DRIVE_STRENGTH_0,                     0x00},
+	{WCD938X_DIGITAL_DRIVE_STRENGTH_1,                     0x00},
+	{WCD938X_DIGITAL_DRIVE_STRENGTH_2,                     0x00},
+	{WCD938X_DIGITAL_RX_DATA_EDGE_CTL,                     0x1F},
+	{WCD938X_DIGITAL_TX_DATA_EDGE_CTL,                     0x80},
+	{WCD938X_DIGITAL_GPIO_MODE,                            0x00},
+	{WCD938X_DIGITAL_PIN_CTL_OE,                           0x00},
+	{WCD938X_DIGITAL_PIN_CTL_DATA_0,                       0x00},
+	{WCD938X_DIGITAL_PIN_CTL_DATA_1,                       0x00},
+	{WCD938X_DIGITAL_PIN_STATUS_0,                         0x00},
+	{WCD938X_DIGITAL_PIN_STATUS_1,                         0x00},
+	{WCD938X_DIGITAL_DIG_DEBUG_CTL,                        0x00},
+	{WCD938X_DIGITAL_DIG_DEBUG_EN,                         0x00},
+	{WCD938X_DIGITAL_ANA_CSR_DBG_ADD,                      0x00},
+	{WCD938X_DIGITAL_ANA_CSR_DBG_CTL,                      0x48},
+	{WCD938X_DIGITAL_SSP_DBG,                              0x00},
+	{WCD938X_DIGITAL_MODE_STATUS_0,                        0x00},
+	{WCD938X_DIGITAL_MODE_STATUS_1,                        0x00},
+	{WCD938X_DIGITAL_SPARE_0,                              0x00},
+	{WCD938X_DIGITAL_SPARE_1,                              0x00},
+	{WCD938X_DIGITAL_SPARE_2,                              0x00},
+	{WCD938X_DIGITAL_EFUSE_REG_0,                          0x00},
+	{WCD938X_DIGITAL_EFUSE_REG_1,                          0xFF},
+	{WCD938X_DIGITAL_EFUSE_REG_2,                          0xFF},
+	{WCD938X_DIGITAL_EFUSE_REG_3,                          0xFF},
+	{WCD938X_DIGITAL_EFUSE_REG_4,                          0xFF},
+	{WCD938X_DIGITAL_EFUSE_REG_5,                          0xFF},
+	{WCD938X_DIGITAL_EFUSE_REG_6,                          0xFF},
+	{WCD938X_DIGITAL_EFUSE_REG_7,                          0xFF},
+	{WCD938X_DIGITAL_EFUSE_REG_8,                          0xFF},
+	{WCD938X_DIGITAL_EFUSE_REG_9,                          0xFF},
+	{WCD938X_DIGITAL_EFUSE_REG_10,                         0xFF},
+	{WCD938X_DIGITAL_EFUSE_REG_11,                         0xFF},
+	{WCD938X_DIGITAL_EFUSE_REG_12,                         0xFF},
+	{WCD938X_DIGITAL_EFUSE_REG_13,                         0xFF},
+	{WCD938X_DIGITAL_EFUSE_REG_14,                         0xFF},
+	{WCD938X_DIGITAL_EFUSE_REG_15,                         0xFF},
+	{WCD938X_DIGITAL_EFUSE_REG_16,                         0xFF},
+	{WCD938X_DIGITAL_EFUSE_REG_17,                         0xFF},
+	{WCD938X_DIGITAL_EFUSE_REG_18,                         0xFF},
+	{WCD938X_DIGITAL_EFUSE_REG_19,                         0xFF},
+	{WCD938X_DIGITAL_EFUSE_REG_20,                         0x0E},
+	{WCD938X_DIGITAL_EFUSE_REG_21,                         0x00},
+	{WCD938X_DIGITAL_EFUSE_REG_22,                         0x00},
+	{WCD938X_DIGITAL_EFUSE_REG_23,                         0xF8},
+	{WCD938X_DIGITAL_EFUSE_REG_24,                         0x16},
+	{WCD938X_DIGITAL_EFUSE_REG_25,                         0x00},
+	{WCD938X_DIGITAL_EFUSE_REG_26,                         0x00},
+	{WCD938X_DIGITAL_EFUSE_REG_27,                         0x00},
+	{WCD938X_DIGITAL_EFUSE_REG_28,                         0x00},
+	{WCD938X_DIGITAL_EFUSE_REG_29,                         0x00},
+	{WCD938X_DIGITAL_EFUSE_REG_30,                         0x00},
+	{WCD938X_DIGITAL_EFUSE_REG_31,                         0x00},
+	{WCD938X_DIGITAL_TX_REQ_FB_CTL_0,                      0x88},
+	{WCD938X_DIGITAL_TX_REQ_FB_CTL_1,                      0x88},
+	{WCD938X_DIGITAL_TX_REQ_FB_CTL_2,                      0x88},
+	{WCD938X_DIGITAL_TX_REQ_FB_CTL_3,                      0x88},
+	{WCD938X_DIGITAL_TX_REQ_FB_CTL_4,                      0x88},
+	{WCD938X_DIGITAL_DEM_BYPASS_DATA0,                     0x55},
+	{WCD938X_DIGITAL_DEM_BYPASS_DATA1,                     0x55},
+	{WCD938X_DIGITAL_DEM_BYPASS_DATA2,                     0x55},
+	{WCD938X_DIGITAL_DEM_BYPASS_DATA3,                     0x01},
+};
+
+static bool wcd938x_rdwr_register(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case WCD938X_ANA_PAGE_REGISTER:
+	case WCD938X_ANA_BIAS:
+	case WCD938X_ANA_RX_SUPPLIES:
+	case WCD938X_ANA_HPH:
+	case WCD938X_ANA_EAR:
+	case WCD938X_ANA_EAR_COMPANDER_CTL:
+	case WCD938X_ANA_TX_CH1:
+	case WCD938X_ANA_TX_CH2:
+	case WCD938X_ANA_TX_CH3:
+	case WCD938X_ANA_TX_CH4:
+	case WCD938X_ANA_MICB1_MICB2_DSP_EN_LOGIC:
+	case WCD938X_ANA_MICB3_DSP_EN_LOGIC:
+	case WCD938X_ANA_MBHC_MECH:
+	case WCD938X_ANA_MBHC_ELECT:
+	case WCD938X_ANA_MBHC_ZDET:
+	case WCD938X_ANA_MBHC_BTN0:
+	case WCD938X_ANA_MBHC_BTN1:
+	case WCD938X_ANA_MBHC_BTN2:
+	case WCD938X_ANA_MBHC_BTN3:
+	case WCD938X_ANA_MBHC_BTN4:
+	case WCD938X_ANA_MBHC_BTN5:
+	case WCD938X_ANA_MBHC_BTN6:
+	case WCD938X_ANA_MBHC_BTN7:
+	case WCD938X_ANA_MICB1:
+	case WCD938X_ANA_MICB2:
+	case WCD938X_ANA_MICB2_RAMP:
+	case WCD938X_ANA_MICB3:
+	case WCD938X_ANA_MICB4:
+	case WCD938X_BIAS_CTL:
+	case WCD938X_BIAS_VBG_FINE_ADJ:
+	case WCD938X_LDOL_VDDCX_ADJUST:
+	case WCD938X_LDOL_DISABLE_LDOL:
+	case WCD938X_MBHC_CTL_CLK:
+	case WCD938X_MBHC_CTL_ANA:
+	case WCD938X_MBHC_CTL_SPARE_1:
+	case WCD938X_MBHC_CTL_SPARE_2:
+	case WCD938X_MBHC_CTL_BCS:
+	case WCD938X_MBHC_TEST_CTL:
+	case WCD938X_LDOH_MODE:
+	case WCD938X_LDOH_BIAS:
+	case WCD938X_LDOH_STB_LOADS:
+	case WCD938X_LDOH_SLOWRAMP:
+	case WCD938X_MICB1_TEST_CTL_1:
+	case WCD938X_MICB1_TEST_CTL_2:
+	case WCD938X_MICB1_TEST_CTL_3:
+	case WCD938X_MICB2_TEST_CTL_1:
+	case WCD938X_MICB2_TEST_CTL_2:
+	case WCD938X_MICB2_TEST_CTL_3:
+	case WCD938X_MICB3_TEST_CTL_1:
+	case WCD938X_MICB3_TEST_CTL_2:
+	case WCD938X_MICB3_TEST_CTL_3:
+	case WCD938X_MICB4_TEST_CTL_1:
+	case WCD938X_MICB4_TEST_CTL_2:
+	case WCD938X_MICB4_TEST_CTL_3:
+	case WCD938X_TX_COM_ADC_VCM:
+	case WCD938X_TX_COM_BIAS_ATEST:
+	case WCD938X_TX_COM_SPARE1:
+	case WCD938X_TX_COM_SPARE2:
+	case WCD938X_TX_COM_TXFE_DIV_CTL:
+	case WCD938X_TX_COM_TXFE_DIV_START:
+	case WCD938X_TX_COM_SPARE3:
+	case WCD938X_TX_COM_SPARE4:
+	case WCD938X_TX_1_2_TEST_EN:
+	case WCD938X_TX_1_2_ADC_IB:
+	case WCD938X_TX_1_2_ATEST_REFCTL:
+	case WCD938X_TX_1_2_TEST_CTL:
+	case WCD938X_TX_1_2_TEST_BLK_EN1:
+	case WCD938X_TX_1_2_TXFE1_CLKDIV:
+	case WCD938X_TX_3_4_TEST_EN:
+	case WCD938X_TX_3_4_ADC_IB:
+	case WCD938X_TX_3_4_ATEST_REFCTL:
+	case WCD938X_TX_3_4_TEST_CTL:
+	case WCD938X_TX_3_4_TEST_BLK_EN3:
+	case WCD938X_TX_3_4_TXFE3_CLKDIV:
+	case WCD938X_TX_3_4_TEST_BLK_EN2:
+	case WCD938X_TX_3_4_TXFE2_CLKDIV:
+	case WCD938X_TX_3_4_SPARE1:
+	case WCD938X_TX_3_4_TEST_BLK_EN4:
+	case WCD938X_TX_3_4_TXFE4_CLKDIV:
+	case WCD938X_TX_3_4_SPARE2:
+	case WCD938X_CLASSH_MODE_1:
+	case WCD938X_CLASSH_MODE_2:
+	case WCD938X_CLASSH_MODE_3:
+	case WCD938X_CLASSH_CTRL_VCL_1:
+	case WCD938X_CLASSH_CTRL_VCL_2:
+	case WCD938X_CLASSH_CTRL_CCL_1:
+	case WCD938X_CLASSH_CTRL_CCL_2:
+	case WCD938X_CLASSH_CTRL_CCL_3:
+	case WCD938X_CLASSH_CTRL_CCL_4:
+	case WCD938X_CLASSH_CTRL_CCL_5:
+	case WCD938X_CLASSH_BUCK_TMUX_A_D:
+	case WCD938X_CLASSH_BUCK_SW_DRV_CNTL:
+	case WCD938X_CLASSH_SPARE:
+	case WCD938X_FLYBACK_EN:
+	case WCD938X_FLYBACK_VNEG_CTRL_1:
+	case WCD938X_FLYBACK_VNEG_CTRL_2:
+	case WCD938X_FLYBACK_VNEG_CTRL_3:
+	case WCD938X_FLYBACK_VNEG_CTRL_4:
+	case WCD938X_FLYBACK_VNEG_CTRL_5:
+	case WCD938X_FLYBACK_VNEG_CTRL_6:
+	case WCD938X_FLYBACK_VNEG_CTRL_7:
+	case WCD938X_FLYBACK_VNEG_CTRL_8:
+	case WCD938X_FLYBACK_VNEG_CTRL_9:
+	case WCD938X_FLYBACK_VNEGDAC_CTRL_1:
+	case WCD938X_FLYBACK_VNEGDAC_CTRL_2:
+	case WCD938X_FLYBACK_VNEGDAC_CTRL_3:
+	case WCD938X_FLYBACK_CTRL_1:
+	case WCD938X_FLYBACK_TEST_CTL:
+	case WCD938X_RX_AUX_SW_CTL:
+	case WCD938X_RX_PA_AUX_IN_CONN:
+	case WCD938X_RX_TIMER_DIV:
+	case WCD938X_RX_OCP_CTL:
+	case WCD938X_RX_OCP_COUNT:
+	case WCD938X_RX_BIAS_EAR_DAC:
+	case WCD938X_RX_BIAS_EAR_AMP:
+	case WCD938X_RX_BIAS_HPH_LDO:
+	case WCD938X_RX_BIAS_HPH_PA:
+	case WCD938X_RX_BIAS_HPH_RDACBUFF_CNP2:
+	case WCD938X_RX_BIAS_HPH_RDAC_LDO:
+	case WCD938X_RX_BIAS_HPH_CNP1:
+	case WCD938X_RX_BIAS_HPH_LOWPOWER:
+	case WCD938X_RX_BIAS_AUX_DAC:
+	case WCD938X_RX_BIAS_AUX_AMP:
+	case WCD938X_RX_BIAS_VNEGDAC_BLEEDER:
+	case WCD938X_RX_BIAS_MISC:
+	case WCD938X_RX_BIAS_BUCK_RST:
+	case WCD938X_RX_BIAS_BUCK_VREF_ERRAMP:
+	case WCD938X_RX_BIAS_FLYB_ERRAMP:
+	case WCD938X_RX_BIAS_FLYB_BUFF:
+	case WCD938X_RX_BIAS_FLYB_MID_RST:
+	case WCD938X_HPH_CNP_EN:
+	case WCD938X_HPH_CNP_WG_CTL:
+	case WCD938X_HPH_CNP_WG_TIME:
+	case WCD938X_HPH_OCP_CTL:
+	case WCD938X_HPH_AUTO_CHOP:
+	case WCD938X_HPH_CHOP_CTL:
+	case WCD938X_HPH_PA_CTL1:
+	case WCD938X_HPH_PA_CTL2:
+	case WCD938X_HPH_L_EN:
+	case WCD938X_HPH_L_TEST:
+	case WCD938X_HPH_L_ATEST:
+	case WCD938X_HPH_R_EN:
+	case WCD938X_HPH_R_TEST:
+	case WCD938X_HPH_R_ATEST:
+	case WCD938X_HPH_RDAC_CLK_CTL1:
+	case WCD938X_HPH_RDAC_CLK_CTL2:
+	case WCD938X_HPH_RDAC_LDO_CTL:
+	case WCD938X_HPH_RDAC_CHOP_CLK_LP_CTL:
+	case WCD938X_HPH_REFBUFF_UHQA_CTL:
+	case WCD938X_HPH_REFBUFF_LP_CTL:
+	case WCD938X_HPH_L_DAC_CTL:
+	case WCD938X_HPH_R_DAC_CTL:
+	case WCD938X_HPH_SURGE_HPHLR_SURGE_COMP_SEL:
+	case WCD938X_HPH_SURGE_HPHLR_SURGE_EN:
+	case WCD938X_HPH_SURGE_HPHLR_SURGE_MISC1:
+	case WCD938X_EAR_EAR_EN_REG:
+	case WCD938X_EAR_EAR_PA_CON:
+	case WCD938X_EAR_EAR_SP_CON:
+	case WCD938X_EAR_EAR_DAC_CON:
+	case WCD938X_EAR_EAR_CNP_FSM_CON:
+	case WCD938X_EAR_TEST_CTL:
+	case WCD938X_ANA_NEW_PAGE_REGISTER:
+	case WCD938X_HPH_NEW_ANA_HPH2:
+	case WCD938X_HPH_NEW_ANA_HPH3:
+	case WCD938X_SLEEP_CTL:
+	case WCD938X_SLEEP_WATCHDOG_CTL:
+	case WCD938X_MBHC_NEW_ELECT_REM_CLAMP_CTL:
+	case WCD938X_MBHC_NEW_CTL_1:
+	case WCD938X_MBHC_NEW_CTL_2:
+	case WCD938X_MBHC_NEW_PLUG_DETECT_CTL:
+	case WCD938X_MBHC_NEW_ZDET_ANA_CTL:
+	case WCD938X_MBHC_NEW_ZDET_RAMP_CTL:
+	case WCD938X_TX_NEW_AMIC_MUX_CFG:
+	case WCD938X_AUX_AUXPA:
+	case WCD938X_LDORXTX_MODE:
+	case WCD938X_LDORXTX_CONFIG:
+	case WCD938X_DIE_CRACK_DIE_CRK_DET_EN:
+	case WCD938X_HPH_NEW_INT_RDAC_GAIN_CTL:
+	case WCD938X_HPH_NEW_INT_RDAC_HD2_CTL_L:
+	case WCD938X_HPH_NEW_INT_RDAC_VREF_CTL:
+	case WCD938X_HPH_NEW_INT_RDAC_OVERRIDE_CTL:
+	case WCD938X_HPH_NEW_INT_RDAC_HD2_CTL_R:
+	case WCD938X_HPH_NEW_INT_PA_MISC1:
+	case WCD938X_HPH_NEW_INT_PA_MISC2:
+	case WCD938X_HPH_NEW_INT_PA_RDAC_MISC:
+	case WCD938X_HPH_NEW_INT_HPH_TIMER1:
+	case WCD938X_HPH_NEW_INT_HPH_TIMER2:
+	case WCD938X_HPH_NEW_INT_HPH_TIMER3:
+	case WCD938X_HPH_NEW_INT_HPH_TIMER4:
+	case WCD938X_HPH_NEW_INT_PA_RDAC_MISC2:
+	case WCD938X_HPH_NEW_INT_PA_RDAC_MISC3:
+	case WCD938X_HPH_NEW_INT_RDAC_HD2_CTL_L_NEW:
+	case WCD938X_HPH_NEW_INT_RDAC_HD2_CTL_R_NEW:
+	case WCD938X_RX_NEW_INT_HPH_RDAC_BIAS_LOHIFI:
+	case WCD938X_RX_NEW_INT_HPH_RDAC_BIAS_ULP:
+	case WCD938X_RX_NEW_INT_HPH_RDAC_LDO_LP:
+	case WCD938X_MBHC_NEW_INT_MOISTURE_DET_DC_CTRL:
+	case WCD938X_MBHC_NEW_INT_MOISTURE_DET_POLLING_CTRL:
+	case WCD938X_MBHC_NEW_INT_MECH_DET_CURRENT:
+	case WCD938X_MBHC_NEW_INT_SPARE_2:
+	case WCD938X_EAR_INT_NEW_EAR_CHOPPER_CON:
+	case WCD938X_EAR_INT_NEW_CNP_VCM_CON1:
+	case WCD938X_EAR_INT_NEW_CNP_VCM_CON2:
+	case WCD938X_EAR_INT_NEW_EAR_DYNAMIC_BIAS:
+	case WCD938X_AUX_INT_EN_REG:
+	case WCD938X_AUX_INT_PA_CTRL:
+	case WCD938X_AUX_INT_SP_CTRL:
+	case WCD938X_AUX_INT_DAC_CTRL:
+	case WCD938X_AUX_INT_CLK_CTRL:
+	case WCD938X_AUX_INT_TEST_CTRL:
+	case WCD938X_AUX_INT_MISC:
+	case WCD938X_LDORXTX_INT_BIAS:
+	case WCD938X_LDORXTX_INT_STB_LOADS_DTEST:
+	case WCD938X_LDORXTX_INT_TEST0:
+	case WCD938X_LDORXTX_INT_STARTUP_TIMER:
+	case WCD938X_LDORXTX_INT_TEST1:
+	case WCD938X_SLEEP_INT_WATCHDOG_CTL_1:
+	case WCD938X_SLEEP_INT_WATCHDOG_CTL_2:
+	case WCD938X_DIE_CRACK_INT_DIE_CRK_DET_INT1:
+	case WCD938X_DIE_CRACK_INT_DIE_CRK_DET_INT2:
+	case WCD938X_TX_COM_NEW_INT_TXFE_DIVSTOP_L2:
+	case WCD938X_TX_COM_NEW_INT_TXFE_DIVSTOP_L1:
+	case WCD938X_TX_COM_NEW_INT_TXFE_DIVSTOP_L0:
+	case WCD938X_TX_COM_NEW_INT_TXFE_DIVSTOP_ULP1P2M:
+	case WCD938X_TX_COM_NEW_INT_TXFE_DIVSTOP_ULP0P6M:
+	case WCD938X_TX_COM_NEW_INT_TXFE_ICTRL_STG1_L2L1:
+	case WCD938X_TX_COM_NEW_INT_TXFE_ICTRL_STG1_L0:
+	case WCD938X_TX_COM_NEW_INT_TXFE_ICTRL_STG1_ULP:
+	case WCD938X_TX_COM_NEW_INT_TXFE_ICTRL_STG2MAIN_L2L1:
+	case WCD938X_TX_COM_NEW_INT_TXFE_ICTRL_STG2MAIN_L0:
+	case WCD938X_TX_COM_NEW_INT_TXFE_ICTRL_STG2MAIN_ULP:
+	case WCD938X_TX_COM_NEW_INT_TXFE_ICTRL_STG2CASC_L2L1L0:
+	case WCD938X_TX_COM_NEW_INT_TXFE_ICTRL_STG2CASC_ULP:
+	case WCD938X_TX_COM_NEW_INT_TXADC_SCBIAS_L2L1:
+	case WCD938X_TX_COM_NEW_INT_TXADC_SCBIAS_L0ULP:
+	case WCD938X_TX_COM_NEW_INT_TXADC_INT_L2:
+	case WCD938X_TX_COM_NEW_INT_TXADC_INT_L1:
+	case WCD938X_TX_COM_NEW_INT_TXADC_INT_L0:
+	case WCD938X_TX_COM_NEW_INT_TXADC_INT_ULP:
+	case WCD938X_DIGITAL_PAGE_REGISTER:
+	case WCD938X_DIGITAL_SWR_TX_CLK_RATE:
+	case WCD938X_DIGITAL_CDC_RST_CTL:
+	case WCD938X_DIGITAL_TOP_CLK_CFG:
+	case WCD938X_DIGITAL_CDC_ANA_CLK_CTL:
+	case WCD938X_DIGITAL_CDC_DIG_CLK_CTL:
+	case WCD938X_DIGITAL_SWR_RST_EN:
+	case WCD938X_DIGITAL_CDC_PATH_MODE:
+	case WCD938X_DIGITAL_CDC_RX_RST:
+	case WCD938X_DIGITAL_CDC_RX0_CTL:
+	case WCD938X_DIGITAL_CDC_RX1_CTL:
+	case WCD938X_DIGITAL_CDC_RX2_CTL:
+	case WCD938X_DIGITAL_CDC_TX_ANA_MODE_0_1:
+	case WCD938X_DIGITAL_CDC_TX_ANA_MODE_2_3:
+	case WCD938X_DIGITAL_CDC_COMP_CTL_0:
+	case WCD938X_DIGITAL_CDC_ANA_TX_CLK_CTL:
+	case WCD938X_DIGITAL_CDC_HPH_DSM_A1_0:
+	case WCD938X_DIGITAL_CDC_HPH_DSM_A1_1:
+	case WCD938X_DIGITAL_CDC_HPH_DSM_A2_0:
+	case WCD938X_DIGITAL_CDC_HPH_DSM_A2_1:
+	case WCD938X_DIGITAL_CDC_HPH_DSM_A3_0:
+	case WCD938X_DIGITAL_CDC_HPH_DSM_A3_1:
+	case WCD938X_DIGITAL_CDC_HPH_DSM_A4_0:
+	case WCD938X_DIGITAL_CDC_HPH_DSM_A4_1:
+	case WCD938X_DIGITAL_CDC_HPH_DSM_A5_0:
+	case WCD938X_DIGITAL_CDC_HPH_DSM_A5_1:
+	case WCD938X_DIGITAL_CDC_HPH_DSM_A6_0:
+	case WCD938X_DIGITAL_CDC_HPH_DSM_A7_0:
+	case WCD938X_DIGITAL_CDC_HPH_DSM_C_0:
+	case WCD938X_DIGITAL_CDC_HPH_DSM_C_1:
+	case WCD938X_DIGITAL_CDC_HPH_DSM_C_2:
+	case WCD938X_DIGITAL_CDC_HPH_DSM_C_3:
+	case WCD938X_DIGITAL_CDC_HPH_DSM_R1:
+	case WCD938X_DIGITAL_CDC_HPH_DSM_R2:
+	case WCD938X_DIGITAL_CDC_HPH_DSM_R3:
+	case WCD938X_DIGITAL_CDC_HPH_DSM_R4:
+	case WCD938X_DIGITAL_CDC_HPH_DSM_R5:
+	case WCD938X_DIGITAL_CDC_HPH_DSM_R6:
+	case WCD938X_DIGITAL_CDC_HPH_DSM_R7:
+	case WCD938X_DIGITAL_CDC_AUX_DSM_A1_0:
+	case WCD938X_DIGITAL_CDC_AUX_DSM_A1_1:
+	case WCD938X_DIGITAL_CDC_AUX_DSM_A2_0:
+	case WCD938X_DIGITAL_CDC_AUX_DSM_A2_1:
+	case WCD938X_DIGITAL_CDC_AUX_DSM_A3_0:
+	case WCD938X_DIGITAL_CDC_AUX_DSM_A3_1:
+	case WCD938X_DIGITAL_CDC_AUX_DSM_A4_0:
+	case WCD938X_DIGITAL_CDC_AUX_DSM_A4_1:
+	case WCD938X_DIGITAL_CDC_AUX_DSM_A5_0:
+	case WCD938X_DIGITAL_CDC_AUX_DSM_A5_1:
+	case WCD938X_DIGITAL_CDC_AUX_DSM_A6_0:
+	case WCD938X_DIGITAL_CDC_AUX_DSM_A7_0:
+	case WCD938X_DIGITAL_CDC_AUX_DSM_C_0:
+	case WCD938X_DIGITAL_CDC_AUX_DSM_C_1:
+	case WCD938X_DIGITAL_CDC_AUX_DSM_C_2:
+	case WCD938X_DIGITAL_CDC_AUX_DSM_C_3:
+	case WCD938X_DIGITAL_CDC_AUX_DSM_R1:
+	case WCD938X_DIGITAL_CDC_AUX_DSM_R2:
+	case WCD938X_DIGITAL_CDC_AUX_DSM_R3:
+	case WCD938X_DIGITAL_CDC_AUX_DSM_R4:
+	case WCD938X_DIGITAL_CDC_AUX_DSM_R5:
+	case WCD938X_DIGITAL_CDC_AUX_DSM_R6:
+	case WCD938X_DIGITAL_CDC_AUX_DSM_R7:
+	case WCD938X_DIGITAL_CDC_HPH_GAIN_RX_0:
+	case WCD938X_DIGITAL_CDC_HPH_GAIN_RX_1:
+	case WCD938X_DIGITAL_CDC_HPH_GAIN_DSD_0:
+	case WCD938X_DIGITAL_CDC_HPH_GAIN_DSD_1:
+	case WCD938X_DIGITAL_CDC_HPH_GAIN_DSD_2:
+	case WCD938X_DIGITAL_CDC_AUX_GAIN_DSD_0:
+	case WCD938X_DIGITAL_CDC_AUX_GAIN_DSD_1:
+	case WCD938X_DIGITAL_CDC_AUX_GAIN_DSD_2:
+	case WCD938X_DIGITAL_CDC_HPH_GAIN_CTL:
+	case WCD938X_DIGITAL_CDC_AUX_GAIN_CTL:
+	case WCD938X_DIGITAL_CDC_EAR_PATH_CTL:
+	case WCD938X_DIGITAL_CDC_SWR_CLH:
+	case WCD938X_DIGITAL_SWR_CLH_BYP:
+	case WCD938X_DIGITAL_CDC_TX0_CTL:
+	case WCD938X_DIGITAL_CDC_TX1_CTL:
+	case WCD938X_DIGITAL_CDC_TX2_CTL:
+	case WCD938X_DIGITAL_CDC_TX_RST:
+	case WCD938X_DIGITAL_CDC_REQ_CTL:
+	case WCD938X_DIGITAL_CDC_RST:
+	case WCD938X_DIGITAL_CDC_AMIC_CTL:
+	case WCD938X_DIGITAL_CDC_DMIC_CTL:
+	case WCD938X_DIGITAL_CDC_DMIC1_CTL:
+	case WCD938X_DIGITAL_CDC_DMIC2_CTL:
+	case WCD938X_DIGITAL_CDC_DMIC3_CTL:
+	case WCD938X_DIGITAL_CDC_DMIC4_CTL:
+	case WCD938X_DIGITAL_EFUSE_PRG_CTL:
+	case WCD938X_DIGITAL_EFUSE_CTL:
+	case WCD938X_DIGITAL_CDC_DMIC_RATE_1_2:
+	case WCD938X_DIGITAL_CDC_DMIC_RATE_3_4:
+	case WCD938X_DIGITAL_PDM_WD_CTL0:
+	case WCD938X_DIGITAL_PDM_WD_CTL1:
+	case WCD938X_DIGITAL_PDM_WD_CTL2:
+	case WCD938X_DIGITAL_INTR_MODE:
+	case WCD938X_DIGITAL_INTR_MASK_0:
+	case WCD938X_DIGITAL_INTR_MASK_1:
+	case WCD938X_DIGITAL_INTR_MASK_2:
+	case WCD938X_DIGITAL_INTR_CLEAR_0:
+	case WCD938X_DIGITAL_INTR_CLEAR_1:
+	case WCD938X_DIGITAL_INTR_CLEAR_2:
+	case WCD938X_DIGITAL_INTR_LEVEL_0:
+	case WCD938X_DIGITAL_INTR_LEVEL_1:
+	case WCD938X_DIGITAL_INTR_LEVEL_2:
+	case WCD938X_DIGITAL_INTR_SET_0:
+	case WCD938X_DIGITAL_INTR_SET_1:
+	case WCD938X_DIGITAL_INTR_SET_2:
+	case WCD938X_DIGITAL_INTR_TEST_0:
+	case WCD938X_DIGITAL_INTR_TEST_1:
+	case WCD938X_DIGITAL_INTR_TEST_2:
+	case WCD938X_DIGITAL_TX_MODE_DBG_EN:
+	case WCD938X_DIGITAL_TX_MODE_DBG_0_1:
+	case WCD938X_DIGITAL_TX_MODE_DBG_2_3:
+	case WCD938X_DIGITAL_LB_IN_SEL_CTL:
+	case WCD938X_DIGITAL_LOOP_BACK_MODE:
+	case WCD938X_DIGITAL_SWR_DAC_TEST:
+	case WCD938X_DIGITAL_SWR_HM_TEST_RX_0:
+	case WCD938X_DIGITAL_SWR_HM_TEST_TX_0:
+	case WCD938X_DIGITAL_SWR_HM_TEST_RX_1:
+	case WCD938X_DIGITAL_SWR_HM_TEST_TX_1:
+	case WCD938X_DIGITAL_SWR_HM_TEST_TX_2:
+	case WCD938X_DIGITAL_PAD_CTL_SWR_0:
+	case WCD938X_DIGITAL_PAD_CTL_SWR_1:
+	case WCD938X_DIGITAL_I2C_CTL:
+	case WCD938X_DIGITAL_CDC_TX_TANGGU_SW_MODE:
+	case WCD938X_DIGITAL_EFUSE_TEST_CTL_0:
+	case WCD938X_DIGITAL_EFUSE_TEST_CTL_1:
+	case WCD938X_DIGITAL_PAD_CTL_PDM_RX0:
+	case WCD938X_DIGITAL_PAD_CTL_PDM_RX1:
+	case WCD938X_DIGITAL_PAD_CTL_PDM_TX0:
+	case WCD938X_DIGITAL_PAD_CTL_PDM_TX1:
+	case WCD938X_DIGITAL_PAD_CTL_PDM_TX2:
+	case WCD938X_DIGITAL_PAD_INP_DIS_0:
+	case WCD938X_DIGITAL_PAD_INP_DIS_1:
+	case WCD938X_DIGITAL_DRIVE_STRENGTH_0:
+	case WCD938X_DIGITAL_DRIVE_STRENGTH_1:
+	case WCD938X_DIGITAL_DRIVE_STRENGTH_2:
+	case WCD938X_DIGITAL_RX_DATA_EDGE_CTL:
+	case WCD938X_DIGITAL_TX_DATA_EDGE_CTL:
+	case WCD938X_DIGITAL_GPIO_MODE:
+	case WCD938X_DIGITAL_PIN_CTL_OE:
+	case WCD938X_DIGITAL_PIN_CTL_DATA_0:
+	case WCD938X_DIGITAL_PIN_CTL_DATA_1:
+	case WCD938X_DIGITAL_DIG_DEBUG_CTL:
+	case WCD938X_DIGITAL_DIG_DEBUG_EN:
+	case WCD938X_DIGITAL_ANA_CSR_DBG_ADD:
+	case WCD938X_DIGITAL_ANA_CSR_DBG_CTL:
+	case WCD938X_DIGITAL_SSP_DBG:
+	case WCD938X_DIGITAL_SPARE_0:
+	case WCD938X_DIGITAL_SPARE_1:
+	case WCD938X_DIGITAL_SPARE_2:
+	case WCD938X_DIGITAL_TX_REQ_FB_CTL_0:
+	case WCD938X_DIGITAL_TX_REQ_FB_CTL_1:
+	case WCD938X_DIGITAL_TX_REQ_FB_CTL_2:
+	case WCD938X_DIGITAL_TX_REQ_FB_CTL_3:
+	case WCD938X_DIGITAL_TX_REQ_FB_CTL_4:
+	case WCD938X_DIGITAL_DEM_BYPASS_DATA0:
+	case WCD938X_DIGITAL_DEM_BYPASS_DATA1:
+	case WCD938X_DIGITAL_DEM_BYPASS_DATA2:
+	case WCD938X_DIGITAL_DEM_BYPASS_DATA3:
+		return true;
+	}
+
+	return false;
+}
+
+static bool wcd938x_readonly_register(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case WCD938X_ANA_MBHC_RESULT_1:
+	case WCD938X_ANA_MBHC_RESULT_2:
+	case WCD938X_ANA_MBHC_RESULT_3:
+	case WCD938X_MBHC_MOISTURE_DET_FSM_STATUS:
+	case WCD938X_TX_1_2_SAR2_ERR:
+	case WCD938X_TX_1_2_SAR1_ERR:
+	case WCD938X_TX_3_4_SAR4_ERR:
+	case WCD938X_TX_3_4_SAR3_ERR:
+	case WCD938X_HPH_L_STATUS:
+	case WCD938X_HPH_R_STATUS:
+	case WCD938X_HPH_SURGE_HPHLR_SURGE_STATUS:
+	case WCD938X_EAR_STATUS_REG_1:
+	case WCD938X_EAR_STATUS_REG_2:
+	case WCD938X_MBHC_NEW_FSM_STATUS:
+	case WCD938X_MBHC_NEW_ADC_RESULT:
+	case WCD938X_DIE_CRACK_DIE_CRK_DET_OUT:
+	case WCD938X_AUX_INT_STATUS_REG:
+	case WCD938X_LDORXTX_INT_STATUS:
+	case WCD938X_DIGITAL_CHIP_ID0:
+	case WCD938X_DIGITAL_CHIP_ID1:
+	case WCD938X_DIGITAL_CHIP_ID2:
+	case WCD938X_DIGITAL_CHIP_ID3:
+	case WCD938X_DIGITAL_INTR_STATUS_0:
+	case WCD938X_DIGITAL_INTR_STATUS_1:
+	case WCD938X_DIGITAL_INTR_STATUS_2:
+	case WCD938X_DIGITAL_INTR_CLEAR_0:
+	case WCD938X_DIGITAL_INTR_CLEAR_1:
+	case WCD938X_DIGITAL_INTR_CLEAR_2:
+	case WCD938X_DIGITAL_SWR_HM_TEST_0:
+	case WCD938X_DIGITAL_SWR_HM_TEST_1:
+	case WCD938X_DIGITAL_EFUSE_T_DATA_0:
+	case WCD938X_DIGITAL_EFUSE_T_DATA_1:
+	case WCD938X_DIGITAL_PIN_STATUS_0:
+	case WCD938X_DIGITAL_PIN_STATUS_1:
+	case WCD938X_DIGITAL_MODE_STATUS_0:
+	case WCD938X_DIGITAL_MODE_STATUS_1:
+	case WCD938X_DIGITAL_EFUSE_REG_0:
+	case WCD938X_DIGITAL_EFUSE_REG_1:
+	case WCD938X_DIGITAL_EFUSE_REG_2:
+	case WCD938X_DIGITAL_EFUSE_REG_3:
+	case WCD938X_DIGITAL_EFUSE_REG_4:
+	case WCD938X_DIGITAL_EFUSE_REG_5:
+	case WCD938X_DIGITAL_EFUSE_REG_6:
+	case WCD938X_DIGITAL_EFUSE_REG_7:
+	case WCD938X_DIGITAL_EFUSE_REG_8:
+	case WCD938X_DIGITAL_EFUSE_REG_9:
+	case WCD938X_DIGITAL_EFUSE_REG_10:
+	case WCD938X_DIGITAL_EFUSE_REG_11:
+	case WCD938X_DIGITAL_EFUSE_REG_12:
+	case WCD938X_DIGITAL_EFUSE_REG_13:
+	case WCD938X_DIGITAL_EFUSE_REG_14:
+	case WCD938X_DIGITAL_EFUSE_REG_15:
+	case WCD938X_DIGITAL_EFUSE_REG_16:
+	case WCD938X_DIGITAL_EFUSE_REG_17:
+	case WCD938X_DIGITAL_EFUSE_REG_18:
+	case WCD938X_DIGITAL_EFUSE_REG_19:
+	case WCD938X_DIGITAL_EFUSE_REG_20:
+	case WCD938X_DIGITAL_EFUSE_REG_21:
+	case WCD938X_DIGITAL_EFUSE_REG_22:
+	case WCD938X_DIGITAL_EFUSE_REG_23:
+	case WCD938X_DIGITAL_EFUSE_REG_24:
+	case WCD938X_DIGITAL_EFUSE_REG_25:
+	case WCD938X_DIGITAL_EFUSE_REG_26:
+	case WCD938X_DIGITAL_EFUSE_REG_27:
+	case WCD938X_DIGITAL_EFUSE_REG_28:
+	case WCD938X_DIGITAL_EFUSE_REG_29:
+	case WCD938X_DIGITAL_EFUSE_REG_30:
+	case WCD938X_DIGITAL_EFUSE_REG_31:
+		return true;
+	}
+	return false;
+}
+
+static bool wcd938x_readable_register(struct device *dev, unsigned int reg)
+{
+	bool ret;
+
+	ret = wcd938x_readonly_register(dev, reg);
+	if (!ret)
+		return wcd938x_rdwr_register(dev, reg);
+
+	return ret;
+}
+
+static bool wcd938x_writeable_register(struct device *dev, unsigned int reg)
+{
+	return wcd938x_rdwr_register(dev, reg);
+}
+
+static bool wcd938x_volatile_register(struct device *dev, unsigned int reg)
+{
+	if (reg <= WCD938X_BASE_ADDRESS)
+		return false;
+
+	if (reg == WCD938X_DIGITAL_SWR_TX_CLK_RATE)
+		return true;
+
+	if (wcd938x_readonly_register(dev, reg))
+		return true;
+
+	return false;
+}
+
+static const struct regmap_config wcd938x_regmap_config = {
+	.name = "wcd938x_csr",
+	.reg_bits = 32,
+	.val_bits = 8,
+	.cache_type = REGCACHE_RBTREE,
+	.reg_defaults = wcd938x_defaults,
+	.num_reg_defaults = ARRAY_SIZE(wcd938x_defaults),
+	.max_register = WCD938X_MAX_REGISTER,
+	.readable_reg = wcd938x_readable_register,
+	.writeable_reg = wcd938x_writeable_register,
+	.volatile_reg = wcd938x_volatile_register,
+	.can_multi_write = true,
+};
+
+static const struct sdw_slave_ops wcd9380_slave_ops = {
 	.update_status = wcd9380_update_status,
 	.interrupt_callback = wcd9380_interrupt_callback,
 	.bus_config = wcd9380_bus_config,
@@ -261,6 +1263,16 @@ static int wcd9380_probe(struct sdw_slave *pdev,
 		wcd->ch_info = &wcd938x_sdw_rx_ch_info[0];
 	}
 
+	if (wcd->is_tx) {
+		wcd->regmap = devm_regmap_init_sdw(pdev, &wcd938x_regmap_config);
+		if (IS_ERR(wcd->regmap))
+			return dev_err_probe(dev, PTR_ERR(wcd->regmap),
+					     "Regmap init failed\n");
+
+		/* Start in cache-only until device is enumerated */
+		regcache_cache_only(wcd->regmap, true);
+	};
+
 	pm_runtime_set_autosuspend_delay(dev, 3000);
 	pm_runtime_use_autosuspend(dev);
 	pm_runtime_mark_last_busy(dev);
@@ -278,22 +1290,23 @@ MODULE_DEVICE_TABLE(sdw, wcd9380_slave_id);
 
 static int __maybe_unused wcd938x_sdw_runtime_suspend(struct device *dev)
 {
-	struct regmap *regmap = dev_get_regmap(dev, NULL);
+	struct wcd938x_sdw_priv *wcd = dev_get_drvdata(dev);
 
-	if (regmap) {
-		regcache_cache_only(regmap, true);
-		regcache_mark_dirty(regmap);
+	if (wcd->regmap) {
+		regcache_cache_only(wcd->regmap, true);
+		regcache_mark_dirty(wcd->regmap);
 	}
+
 	return 0;
 }
 
 static int __maybe_unused wcd938x_sdw_runtime_resume(struct device *dev)
 {
-	struct regmap *regmap = dev_get_regmap(dev, NULL);
+	struct wcd938x_sdw_priv *wcd = dev_get_drvdata(dev);
 
-	if (regmap) {
-		regcache_cache_only(regmap, false);
-		regcache_sync(regmap);
+	if (wcd->regmap) {
+		regcache_cache_only(wcd->regmap, false);
+		regcache_sync(wcd->regmap);
 	}
 
 	pm_runtime_mark_last_busy(dev);
diff --git a/sound/soc/codecs/wcd938x.c b/sound/soc/codecs/wcd938x.c
index aca06a4026f3..1d801a7b1469 100644
--- a/sound/soc/codecs/wcd938x.c
+++ b/sound/soc/codecs/wcd938x.c
@@ -273,1001 +273,6 @@ static struct wcd_mbhc_field wcd_mbhc_fields[WCD_MBHC_REG_FUNC_MAX] = {
 	WCD_MBHC_FIELD(WCD_MBHC_ELECT_ISRC_EN, WCD938X_ANA_MBHC_ZDET, 0x02),
 };
 
-static const struct reg_default wcd938x_defaults[] = {
-	{WCD938X_ANA_PAGE_REGISTER,                            0x00},
-	{WCD938X_ANA_BIAS,                                     0x00},
-	{WCD938X_ANA_RX_SUPPLIES,                              0x00},
-	{WCD938X_ANA_HPH,                                      0x0C},
-	{WCD938X_ANA_EAR,                                      0x00},
-	{WCD938X_ANA_EAR_COMPANDER_CTL,                        0x02},
-	{WCD938X_ANA_TX_CH1,                                   0x20},
-	{WCD938X_ANA_TX_CH2,                                   0x00},
-	{WCD938X_ANA_TX_CH3,                                   0x20},
-	{WCD938X_ANA_TX_CH4,                                   0x00},
-	{WCD938X_ANA_MICB1_MICB2_DSP_EN_LOGIC,                 0x00},
-	{WCD938X_ANA_MICB3_DSP_EN_LOGIC,                       0x00},
-	{WCD938X_ANA_MBHC_MECH,                                0x39},
-	{WCD938X_ANA_MBHC_ELECT,                               0x08},
-	{WCD938X_ANA_MBHC_ZDET,                                0x00},
-	{WCD938X_ANA_MBHC_RESULT_1,                            0x00},
-	{WCD938X_ANA_MBHC_RESULT_2,                            0x00},
-	{WCD938X_ANA_MBHC_RESULT_3,                            0x00},
-	{WCD938X_ANA_MBHC_BTN0,                                0x00},
-	{WCD938X_ANA_MBHC_BTN1,                                0x10},
-	{WCD938X_ANA_MBHC_BTN2,                                0x20},
-	{WCD938X_ANA_MBHC_BTN3,                                0x30},
-	{WCD938X_ANA_MBHC_BTN4,                                0x40},
-	{WCD938X_ANA_MBHC_BTN5,                                0x50},
-	{WCD938X_ANA_MBHC_BTN6,                                0x60},
-	{WCD938X_ANA_MBHC_BTN7,                                0x70},
-	{WCD938X_ANA_MICB1,                                    0x10},
-	{WCD938X_ANA_MICB2,                                    0x10},
-	{WCD938X_ANA_MICB2_RAMP,                               0x00},
-	{WCD938X_ANA_MICB3,                                    0x10},
-	{WCD938X_ANA_MICB4,                                    0x10},
-	{WCD938X_BIAS_CTL,                                     0x2A},
-	{WCD938X_BIAS_VBG_FINE_ADJ,                            0x55},
-	{WCD938X_LDOL_VDDCX_ADJUST,                            0x01},
-	{WCD938X_LDOL_DISABLE_LDOL,                            0x00},
-	{WCD938X_MBHC_CTL_CLK,                                 0x00},
-	{WCD938X_MBHC_CTL_ANA,                                 0x00},
-	{WCD938X_MBHC_CTL_SPARE_1,                             0x00},
-	{WCD938X_MBHC_CTL_SPARE_2,                             0x00},
-	{WCD938X_MBHC_CTL_BCS,                                 0x00},
-	{WCD938X_MBHC_MOISTURE_DET_FSM_STATUS,                 0x00},
-	{WCD938X_MBHC_TEST_CTL,                                0x00},
-	{WCD938X_LDOH_MODE,                                    0x2B},
-	{WCD938X_LDOH_BIAS,                                    0x68},
-	{WCD938X_LDOH_STB_LOADS,                               0x00},
-	{WCD938X_LDOH_SLOWRAMP,                                0x50},
-	{WCD938X_MICB1_TEST_CTL_1,                             0x1A},
-	{WCD938X_MICB1_TEST_CTL_2,                             0x00},
-	{WCD938X_MICB1_TEST_CTL_3,                             0xA4},
-	{WCD938X_MICB2_TEST_CTL_1,                             0x1A},
-	{WCD938X_MICB2_TEST_CTL_2,                             0x00},
-	{WCD938X_MICB2_TEST_CTL_3,                             0x24},
-	{WCD938X_MICB3_TEST_CTL_1,                             0x1A},
-	{WCD938X_MICB3_TEST_CTL_2,                             0x00},
-	{WCD938X_MICB3_TEST_CTL_3,                             0xA4},
-	{WCD938X_MICB4_TEST_CTL_1,                             0x1A},
-	{WCD938X_MICB4_TEST_CTL_2,                             0x00},
-	{WCD938X_MICB4_TEST_CTL_3,                             0xA4},
-	{WCD938X_TX_COM_ADC_VCM,                               0x39},
-	{WCD938X_TX_COM_BIAS_ATEST,                            0xE0},
-	{WCD938X_TX_COM_SPARE1,                                0x00},
-	{WCD938X_TX_COM_SPARE2,                                0x00},
-	{WCD938X_TX_COM_TXFE_DIV_CTL,                          0x22},
-	{WCD938X_TX_COM_TXFE_DIV_START,                        0x00},
-	{WCD938X_TX_COM_SPARE3,                                0x00},
-	{WCD938X_TX_COM_SPARE4,                                0x00},
-	{WCD938X_TX_1_2_TEST_EN,                               0xCC},
-	{WCD938X_TX_1_2_ADC_IB,                                0xE9},
-	{WCD938X_TX_1_2_ATEST_REFCTL,                          0x0A},
-	{WCD938X_TX_1_2_TEST_CTL,                              0x38},
-	{WCD938X_TX_1_2_TEST_BLK_EN1,                          0xFF},
-	{WCD938X_TX_1_2_TXFE1_CLKDIV,                          0x00},
-	{WCD938X_TX_1_2_SAR2_ERR,                              0x00},
-	{WCD938X_TX_1_2_SAR1_ERR,                              0x00},
-	{WCD938X_TX_3_4_TEST_EN,                               0xCC},
-	{WCD938X_TX_3_4_ADC_IB,                                0xE9},
-	{WCD938X_TX_3_4_ATEST_REFCTL,                          0x0A},
-	{WCD938X_TX_3_4_TEST_CTL,                              0x38},
-	{WCD938X_TX_3_4_TEST_BLK_EN3,                          0xFF},
-	{WCD938X_TX_3_4_TXFE3_CLKDIV,                          0x00},
-	{WCD938X_TX_3_4_SAR4_ERR,                              0x00},
-	{WCD938X_TX_3_4_SAR3_ERR,                              0x00},
-	{WCD938X_TX_3_4_TEST_BLK_EN2,                          0xFB},
-	{WCD938X_TX_3_4_TXFE2_CLKDIV,                          0x00},
-	{WCD938X_TX_3_4_SPARE1,                                0x00},
-	{WCD938X_TX_3_4_TEST_BLK_EN4,                          0xFB},
-	{WCD938X_TX_3_4_TXFE4_CLKDIV,                          0x00},
-	{WCD938X_TX_3_4_SPARE2,                                0x00},
-	{WCD938X_CLASSH_MODE_1,                                0x40},
-	{WCD938X_CLASSH_MODE_2,                                0x3A},
-	{WCD938X_CLASSH_MODE_3,                                0x00},
-	{WCD938X_CLASSH_CTRL_VCL_1,                            0x70},
-	{WCD938X_CLASSH_CTRL_VCL_2,                            0x82},
-	{WCD938X_CLASSH_CTRL_CCL_1,                            0x31},
-	{WCD938X_CLASSH_CTRL_CCL_2,                            0x80},
-	{WCD938X_CLASSH_CTRL_CCL_3,                            0x80},
-	{WCD938X_CLASSH_CTRL_CCL_4,                            0x51},
-	{WCD938X_CLASSH_CTRL_CCL_5,                            0x00},
-	{WCD938X_CLASSH_BUCK_TMUX_A_D,                         0x00},
-	{WCD938X_CLASSH_BUCK_SW_DRV_CNTL,                      0x77},
-	{WCD938X_CLASSH_SPARE,                                 0x00},
-	{WCD938X_FLYBACK_EN,                                   0x4E},
-	{WCD938X_FLYBACK_VNEG_CTRL_1,                          0x0B},
-	{WCD938X_FLYBACK_VNEG_CTRL_2,                          0x45},
-	{WCD938X_FLYBACK_VNEG_CTRL_3,                          0x74},
-	{WCD938X_FLYBACK_VNEG_CTRL_4,                          0x7F},
-	{WCD938X_FLYBACK_VNEG_CTRL_5,                          0x83},
-	{WCD938X_FLYBACK_VNEG_CTRL_6,                          0x98},
-	{WCD938X_FLYBACK_VNEG_CTRL_7,                          0xA9},
-	{WCD938X_FLYBACK_VNEG_CTRL_8,                          0x68},
-	{WCD938X_FLYBACK_VNEG_CTRL_9,                          0x64},
-	{WCD938X_FLYBACK_VNEGDAC_CTRL_1,                       0xED},
-	{WCD938X_FLYBACK_VNEGDAC_CTRL_2,                       0xF0},
-	{WCD938X_FLYBACK_VNEGDAC_CTRL_3,                       0xA6},
-	{WCD938X_FLYBACK_CTRL_1,                               0x65},
-	{WCD938X_FLYBACK_TEST_CTL,                             0x00},
-	{WCD938X_RX_AUX_SW_CTL,                                0x00},
-	{WCD938X_RX_PA_AUX_IN_CONN,                            0x01},
-	{WCD938X_RX_TIMER_DIV,                                 0x32},
-	{WCD938X_RX_OCP_CTL,                                   0x1F},
-	{WCD938X_RX_OCP_COUNT,                                 0x77},
-	{WCD938X_RX_BIAS_EAR_DAC,                              0xA0},
-	{WCD938X_RX_BIAS_EAR_AMP,                              0xAA},
-	{WCD938X_RX_BIAS_HPH_LDO,                              0xA9},
-	{WCD938X_RX_BIAS_HPH_PA,                               0xAA},
-	{WCD938X_RX_BIAS_HPH_RDACBUFF_CNP2,                    0x8A},
-	{WCD938X_RX_BIAS_HPH_RDAC_LDO,                         0x88},
-	{WCD938X_RX_BIAS_HPH_CNP1,                             0x82},
-	{WCD938X_RX_BIAS_HPH_LOWPOWER,                         0x82},
-	{WCD938X_RX_BIAS_AUX_DAC,                              0xA0},
-	{WCD938X_RX_BIAS_AUX_AMP,                              0xAA},
-	{WCD938X_RX_BIAS_VNEGDAC_BLEEDER,                      0x50},
-	{WCD938X_RX_BIAS_MISC,                                 0x00},
-	{WCD938X_RX_BIAS_BUCK_RST,                             0x08},
-	{WCD938X_RX_BIAS_BUCK_VREF_ERRAMP,                     0x44},
-	{WCD938X_RX_BIAS_FLYB_ERRAMP,                          0x40},
-	{WCD938X_RX_BIAS_FLYB_BUFF,                            0xAA},
-	{WCD938X_RX_BIAS_FLYB_MID_RST,                         0x14},
-	{WCD938X_HPH_L_STATUS,                                 0x04},
-	{WCD938X_HPH_R_STATUS,                                 0x04},
-	{WCD938X_HPH_CNP_EN,                                   0x80},
-	{WCD938X_HPH_CNP_WG_CTL,                               0x9A},
-	{WCD938X_HPH_CNP_WG_TIME,                              0x14},
-	{WCD938X_HPH_OCP_CTL,                                  0x28},
-	{WCD938X_HPH_AUTO_CHOP,                                0x16},
-	{WCD938X_HPH_CHOP_CTL,                                 0x83},
-	{WCD938X_HPH_PA_CTL1,                                  0x46},
-	{WCD938X_HPH_PA_CTL2,                                  0x50},
-	{WCD938X_HPH_L_EN,                                     0x80},
-	{WCD938X_HPH_L_TEST,                                   0xE0},
-	{WCD938X_HPH_L_ATEST,                                  0x50},
-	{WCD938X_HPH_R_EN,                                     0x80},
-	{WCD938X_HPH_R_TEST,                                   0xE0},
-	{WCD938X_HPH_R_ATEST,                                  0x54},
-	{WCD938X_HPH_RDAC_CLK_CTL1,                            0x99},
-	{WCD938X_HPH_RDAC_CLK_CTL2,                            0x9B},
-	{WCD938X_HPH_RDAC_LDO_CTL,                             0x33},
-	{WCD938X_HPH_RDAC_CHOP_CLK_LP_CTL,                     0x00},
-	{WCD938X_HPH_REFBUFF_UHQA_CTL,                         0x68},
-	{WCD938X_HPH_REFBUFF_LP_CTL,                           0x0E},
-	{WCD938X_HPH_L_DAC_CTL,                                0x20},
-	{WCD938X_HPH_R_DAC_CTL,                                0x20},
-	{WCD938X_HPH_SURGE_HPHLR_SURGE_COMP_SEL,               0x55},
-	{WCD938X_HPH_SURGE_HPHLR_SURGE_EN,                     0x19},
-	{WCD938X_HPH_SURGE_HPHLR_SURGE_MISC1,                  0xA0},
-	{WCD938X_HPH_SURGE_HPHLR_SURGE_STATUS,                 0x00},
-	{WCD938X_EAR_EAR_EN_REG,                               0x22},
-	{WCD938X_EAR_EAR_PA_CON,                               0x44},
-	{WCD938X_EAR_EAR_SP_CON,                               0xDB},
-	{WCD938X_EAR_EAR_DAC_CON,                              0x80},
-	{WCD938X_EAR_EAR_CNP_FSM_CON,                          0xB2},
-	{WCD938X_EAR_TEST_CTL,                                 0x00},
-	{WCD938X_EAR_STATUS_REG_1,                             0x00},
-	{WCD938X_EAR_STATUS_REG_2,                             0x08},
-	{WCD938X_ANA_NEW_PAGE_REGISTER,                        0x00},
-	{WCD938X_HPH_NEW_ANA_HPH2,                             0x00},
-	{WCD938X_HPH_NEW_ANA_HPH3,                             0x00},
-	{WCD938X_SLEEP_CTL,                                    0x16},
-	{WCD938X_SLEEP_WATCHDOG_CTL,                           0x00},
-	{WCD938X_MBHC_NEW_ELECT_REM_CLAMP_CTL,                 0x00},
-	{WCD938X_MBHC_NEW_CTL_1,                               0x02},
-	{WCD938X_MBHC_NEW_CTL_2,                               0x05},
-	{WCD938X_MBHC_NEW_PLUG_DETECT_CTL,                     0xE9},
-	{WCD938X_MBHC_NEW_ZDET_ANA_CTL,                        0x0F},
-	{WCD938X_MBHC_NEW_ZDET_RAMP_CTL,                       0x00},
-	{WCD938X_MBHC_NEW_FSM_STATUS,                          0x00},
-	{WCD938X_MBHC_NEW_ADC_RESULT,                          0x00},
-	{WCD938X_TX_NEW_AMIC_MUX_CFG,                          0x00},
-	{WCD938X_AUX_AUXPA,                                    0x00},
-	{WCD938X_LDORXTX_MODE,                                 0x0C},
-	{WCD938X_LDORXTX_CONFIG,                               0x10},
-	{WCD938X_DIE_CRACK_DIE_CRK_DET_EN,                     0x00},
-	{WCD938X_DIE_CRACK_DIE_CRK_DET_OUT,                    0x00},
-	{WCD938X_HPH_NEW_INT_RDAC_GAIN_CTL,                    0x40},
-	{WCD938X_HPH_NEW_INT_RDAC_HD2_CTL_L,                   0x81},
-	{WCD938X_HPH_NEW_INT_RDAC_VREF_CTL,                    0x10},
-	{WCD938X_HPH_NEW_INT_RDAC_OVERRIDE_CTL,                0x00},
-	{WCD938X_HPH_NEW_INT_RDAC_HD2_CTL_R,                   0x81},
-	{WCD938X_HPH_NEW_INT_PA_MISC1,                         0x22},
-	{WCD938X_HPH_NEW_INT_PA_MISC2,                         0x00},
-	{WCD938X_HPH_NEW_INT_PA_RDAC_MISC,                     0x00},
-	{WCD938X_HPH_NEW_INT_HPH_TIMER1,                       0xFE},
-	{WCD938X_HPH_NEW_INT_HPH_TIMER2,                       0x02},
-	{WCD938X_HPH_NEW_INT_HPH_TIMER3,                       0x4E},
-	{WCD938X_HPH_NEW_INT_HPH_TIMER4,                       0x54},
-	{WCD938X_HPH_NEW_INT_PA_RDAC_MISC2,                    0x00},
-	{WCD938X_HPH_NEW_INT_PA_RDAC_MISC3,                    0x00},
-	{WCD938X_HPH_NEW_INT_RDAC_HD2_CTL_L_NEW,               0x90},
-	{WCD938X_HPH_NEW_INT_RDAC_HD2_CTL_R_NEW,               0x90},
-	{WCD938X_RX_NEW_INT_HPH_RDAC_BIAS_LOHIFI,              0x62},
-	{WCD938X_RX_NEW_INT_HPH_RDAC_BIAS_ULP,                 0x01},
-	{WCD938X_RX_NEW_INT_HPH_RDAC_LDO_LP,                   0x11},
-	{WCD938X_MBHC_NEW_INT_MOISTURE_DET_DC_CTRL,            0x57},
-	{WCD938X_MBHC_NEW_INT_MOISTURE_DET_POLLING_CTRL,       0x01},
-	{WCD938X_MBHC_NEW_INT_MECH_DET_CURRENT,                0x00},
-	{WCD938X_MBHC_NEW_INT_SPARE_2,                         0x00},
-	{WCD938X_EAR_INT_NEW_EAR_CHOPPER_CON,                  0xA8},
-	{WCD938X_EAR_INT_NEW_CNP_VCM_CON1,                     0x42},
-	{WCD938X_EAR_INT_NEW_CNP_VCM_CON2,                     0x22},
-	{WCD938X_EAR_INT_NEW_EAR_DYNAMIC_BIAS,                 0x00},
-	{WCD938X_AUX_INT_EN_REG,                               0x00},
-	{WCD938X_AUX_INT_PA_CTRL,                              0x06},
-	{WCD938X_AUX_INT_SP_CTRL,                              0xD2},
-	{WCD938X_AUX_INT_DAC_CTRL,                             0x80},
-	{WCD938X_AUX_INT_CLK_CTRL,                             0x50},
-	{WCD938X_AUX_INT_TEST_CTRL,                            0x00},
-	{WCD938X_AUX_INT_STATUS_REG,                           0x00},
-	{WCD938X_AUX_INT_MISC,                                 0x00},
-	{WCD938X_LDORXTX_INT_BIAS,                             0x6E},
-	{WCD938X_LDORXTX_INT_STB_LOADS_DTEST,                  0x50},
-	{WCD938X_LDORXTX_INT_TEST0,                            0x1C},
-	{WCD938X_LDORXTX_INT_STARTUP_TIMER,                    0xFF},
-	{WCD938X_LDORXTX_INT_TEST1,                            0x1F},
-	{WCD938X_LDORXTX_INT_STATUS,                           0x00},
-	{WCD938X_SLEEP_INT_WATCHDOG_CTL_1,                     0x0A},
-	{WCD938X_SLEEP_INT_WATCHDOG_CTL_2,                     0x0A},
-	{WCD938X_DIE_CRACK_INT_DIE_CRK_DET_INT1,               0x02},
-	{WCD938X_DIE_CRACK_INT_DIE_CRK_DET_INT2,               0x60},
-	{WCD938X_TX_COM_NEW_INT_TXFE_DIVSTOP_L2,               0xFF},
-	{WCD938X_TX_COM_NEW_INT_TXFE_DIVSTOP_L1,               0x7F},
-	{WCD938X_TX_COM_NEW_INT_TXFE_DIVSTOP_L0,               0x3F},
-	{WCD938X_TX_COM_NEW_INT_TXFE_DIVSTOP_ULP1P2M,          0x1F},
-	{WCD938X_TX_COM_NEW_INT_TXFE_DIVSTOP_ULP0P6M,          0x0F},
-	{WCD938X_TX_COM_NEW_INT_TXFE_ICTRL_STG1_L2L1,          0xD7},
-	{WCD938X_TX_COM_NEW_INT_TXFE_ICTRL_STG1_L0,            0xC8},
-	{WCD938X_TX_COM_NEW_INT_TXFE_ICTRL_STG1_ULP,           0xC6},
-	{WCD938X_TX_COM_NEW_INT_TXFE_ICTRL_STG2MAIN_L2L1,      0xD5},
-	{WCD938X_TX_COM_NEW_INT_TXFE_ICTRL_STG2MAIN_L0,        0xCA},
-	{WCD938X_TX_COM_NEW_INT_TXFE_ICTRL_STG2MAIN_ULP,       0x05},
-	{WCD938X_TX_COM_NEW_INT_TXFE_ICTRL_STG2CASC_L2L1L0,    0xA5},
-	{WCD938X_TX_COM_NEW_INT_TXFE_ICTRL_STG2CASC_ULP,       0x13},
-	{WCD938X_TX_COM_NEW_INT_TXADC_SCBIAS_L2L1,             0x88},
-	{WCD938X_TX_COM_NEW_INT_TXADC_SCBIAS_L0ULP,            0x42},
-	{WCD938X_TX_COM_NEW_INT_TXADC_INT_L2,                  0xFF},
-	{WCD938X_TX_COM_NEW_INT_TXADC_INT_L1,                  0x64},
-	{WCD938X_TX_COM_NEW_INT_TXADC_INT_L0,                  0x64},
-	{WCD938X_TX_COM_NEW_INT_TXADC_INT_ULP,                 0x77},
-	{WCD938X_DIGITAL_PAGE_REGISTER,                        0x00},
-	{WCD938X_DIGITAL_CHIP_ID0,                             0x00},
-	{WCD938X_DIGITAL_CHIP_ID1,                             0x00},
-	{WCD938X_DIGITAL_CHIP_ID2,                             0x0D},
-	{WCD938X_DIGITAL_CHIP_ID3,                             0x01},
-	{WCD938X_DIGITAL_SWR_TX_CLK_RATE,                      0x00},
-	{WCD938X_DIGITAL_CDC_RST_CTL,                          0x03},
-	{WCD938X_DIGITAL_TOP_CLK_CFG,                          0x00},
-	{WCD938X_DIGITAL_CDC_ANA_CLK_CTL,                      0x00},
-	{WCD938X_DIGITAL_CDC_DIG_CLK_CTL,                      0xF0},
-	{WCD938X_DIGITAL_SWR_RST_EN,                           0x00},
-	{WCD938X_DIGITAL_CDC_PATH_MODE,                        0x55},
-	{WCD938X_DIGITAL_CDC_RX_RST,                           0x00},
-	{WCD938X_DIGITAL_CDC_RX0_CTL,                          0xFC},
-	{WCD938X_DIGITAL_CDC_RX1_CTL,                          0xFC},
-	{WCD938X_DIGITAL_CDC_RX2_CTL,                          0xFC},
-	{WCD938X_DIGITAL_CDC_TX_ANA_MODE_0_1,                  0x00},
-	{WCD938X_DIGITAL_CDC_TX_ANA_MODE_2_3,                  0x00},
-	{WCD938X_DIGITAL_CDC_COMP_CTL_0,                       0x00},
-	{WCD938X_DIGITAL_CDC_ANA_TX_CLK_CTL,                   0x1E},
-	{WCD938X_DIGITAL_CDC_HPH_DSM_A1_0,                     0x00},
-	{WCD938X_DIGITAL_CDC_HPH_DSM_A1_1,                     0x01},
-	{WCD938X_DIGITAL_CDC_HPH_DSM_A2_0,                     0x63},
-	{WCD938X_DIGITAL_CDC_HPH_DSM_A2_1,                     0x04},
-	{WCD938X_DIGITAL_CDC_HPH_DSM_A3_0,                     0xAC},
-	{WCD938X_DIGITAL_CDC_HPH_DSM_A3_1,                     0x04},
-	{WCD938X_DIGITAL_CDC_HPH_DSM_A4_0,                     0x1A},
-	{WCD938X_DIGITAL_CDC_HPH_DSM_A4_1,                     0x03},
-	{WCD938X_DIGITAL_CDC_HPH_DSM_A5_0,                     0xBC},
-	{WCD938X_DIGITAL_CDC_HPH_DSM_A5_1,                     0x02},
-	{WCD938X_DIGITAL_CDC_HPH_DSM_A6_0,                     0xC7},
-	{WCD938X_DIGITAL_CDC_HPH_DSM_A7_0,                     0xF8},
-	{WCD938X_DIGITAL_CDC_HPH_DSM_C_0,                      0x47},
-	{WCD938X_DIGITAL_CDC_HPH_DSM_C_1,                      0x43},
-	{WCD938X_DIGITAL_CDC_HPH_DSM_C_2,                      0xB1},
-	{WCD938X_DIGITAL_CDC_HPH_DSM_C_3,                      0x17},
-	{WCD938X_DIGITAL_CDC_HPH_DSM_R1,                       0x4D},
-	{WCD938X_DIGITAL_CDC_HPH_DSM_R2,                       0x29},
-	{WCD938X_DIGITAL_CDC_HPH_DSM_R3,                       0x34},
-	{WCD938X_DIGITAL_CDC_HPH_DSM_R4,                       0x59},
-	{WCD938X_DIGITAL_CDC_HPH_DSM_R5,                       0x66},
-	{WCD938X_DIGITAL_CDC_HPH_DSM_R6,                       0x87},
-	{WCD938X_DIGITAL_CDC_HPH_DSM_R7,                       0x64},
-	{WCD938X_DIGITAL_CDC_AUX_DSM_A1_0,                     0x00},
-	{WCD938X_DIGITAL_CDC_AUX_DSM_A1_1,                     0x01},
-	{WCD938X_DIGITAL_CDC_AUX_DSM_A2_0,                     0x96},
-	{WCD938X_DIGITAL_CDC_AUX_DSM_A2_1,                     0x09},
-	{WCD938X_DIGITAL_CDC_AUX_DSM_A3_0,                     0xAB},
-	{WCD938X_DIGITAL_CDC_AUX_DSM_A3_1,                     0x05},
-	{WCD938X_DIGITAL_CDC_AUX_DSM_A4_0,                     0x1C},
-	{WCD938X_DIGITAL_CDC_AUX_DSM_A4_1,                     0x02},
-	{WCD938X_DIGITAL_CDC_AUX_DSM_A5_0,                     0x17},
-	{WCD938X_DIGITAL_CDC_AUX_DSM_A5_1,                     0x02},
-	{WCD938X_DIGITAL_CDC_AUX_DSM_A6_0,                     0xAA},
-	{WCD938X_DIGITAL_CDC_AUX_DSM_A7_0,                     0xE3},
-	{WCD938X_DIGITAL_CDC_AUX_DSM_C_0,                      0x69},
-	{WCD938X_DIGITAL_CDC_AUX_DSM_C_1,                      0x54},
-	{WCD938X_DIGITAL_CDC_AUX_DSM_C_2,                      0x02},
-	{WCD938X_DIGITAL_CDC_AUX_DSM_C_3,                      0x15},
-	{WCD938X_DIGITAL_CDC_AUX_DSM_R1,                       0xA4},
-	{WCD938X_DIGITAL_CDC_AUX_DSM_R2,                       0xB5},
-	{WCD938X_DIGITAL_CDC_AUX_DSM_R3,                       0x86},
-	{WCD938X_DIGITAL_CDC_AUX_DSM_R4,                       0x85},
-	{WCD938X_DIGITAL_CDC_AUX_DSM_R5,                       0xAA},
-	{WCD938X_DIGITAL_CDC_AUX_DSM_R6,                       0xE2},
-	{WCD938X_DIGITAL_CDC_AUX_DSM_R7,                       0x62},
-	{WCD938X_DIGITAL_CDC_HPH_GAIN_RX_0,                    0x55},
-	{WCD938X_DIGITAL_CDC_HPH_GAIN_RX_1,                    0xA9},
-	{WCD938X_DIGITAL_CDC_HPH_GAIN_DSD_0,                   0x3D},
-	{WCD938X_DIGITAL_CDC_HPH_GAIN_DSD_1,                   0x2E},
-	{WCD938X_DIGITAL_CDC_HPH_GAIN_DSD_2,                   0x01},
-	{WCD938X_DIGITAL_CDC_AUX_GAIN_DSD_0,                   0x00},
-	{WCD938X_DIGITAL_CDC_AUX_GAIN_DSD_1,                   0xFC},
-	{WCD938X_DIGITAL_CDC_AUX_GAIN_DSD_2,                   0x01},
-	{WCD938X_DIGITAL_CDC_HPH_GAIN_CTL,                     0x00},
-	{WCD938X_DIGITAL_CDC_AUX_GAIN_CTL,                     0x00},
-	{WCD938X_DIGITAL_CDC_EAR_PATH_CTL,                     0x00},
-	{WCD938X_DIGITAL_CDC_SWR_CLH,                          0x00},
-	{WCD938X_DIGITAL_SWR_CLH_BYP,                          0x00},
-	{WCD938X_DIGITAL_CDC_TX0_CTL,                          0x68},
-	{WCD938X_DIGITAL_CDC_TX1_CTL,                          0x68},
-	{WCD938X_DIGITAL_CDC_TX2_CTL,                          0x68},
-	{WCD938X_DIGITAL_CDC_TX_RST,                           0x00},
-	{WCD938X_DIGITAL_CDC_REQ_CTL,                          0x01},
-	{WCD938X_DIGITAL_CDC_RST,                              0x00},
-	{WCD938X_DIGITAL_CDC_AMIC_CTL,                         0x0F},
-	{WCD938X_DIGITAL_CDC_DMIC_CTL,                         0x04},
-	{WCD938X_DIGITAL_CDC_DMIC1_CTL,                        0x01},
-	{WCD938X_DIGITAL_CDC_DMIC2_CTL,                        0x01},
-	{WCD938X_DIGITAL_CDC_DMIC3_CTL,                        0x01},
-	{WCD938X_DIGITAL_CDC_DMIC4_CTL,                        0x01},
-	{WCD938X_DIGITAL_EFUSE_PRG_CTL,                        0x00},
-	{WCD938X_DIGITAL_EFUSE_CTL,                            0x2B},
-	{WCD938X_DIGITAL_CDC_DMIC_RATE_1_2,                    0x11},
-	{WCD938X_DIGITAL_CDC_DMIC_RATE_3_4,                    0x11},
-	{WCD938X_DIGITAL_PDM_WD_CTL0,                          0x00},
-	{WCD938X_DIGITAL_PDM_WD_CTL1,                          0x00},
-	{WCD938X_DIGITAL_PDM_WD_CTL2,                          0x00},
-	{WCD938X_DIGITAL_INTR_MODE,                            0x00},
-	{WCD938X_DIGITAL_INTR_MASK_0,                          0xFF},
-	{WCD938X_DIGITAL_INTR_MASK_1,                          0xFF},
-	{WCD938X_DIGITAL_INTR_MASK_2,                          0x3F},
-	{WCD938X_DIGITAL_INTR_STATUS_0,                        0x00},
-	{WCD938X_DIGITAL_INTR_STATUS_1,                        0x00},
-	{WCD938X_DIGITAL_INTR_STATUS_2,                        0x00},
-	{WCD938X_DIGITAL_INTR_CLEAR_0,                         0x00},
-	{WCD938X_DIGITAL_INTR_CLEAR_1,                         0x00},
-	{WCD938X_DIGITAL_INTR_CLEAR_2,                         0x00},
-	{WCD938X_DIGITAL_INTR_LEVEL_0,                         0x00},
-	{WCD938X_DIGITAL_INTR_LEVEL_1,                         0x00},
-	{WCD938X_DIGITAL_INTR_LEVEL_2,                         0x00},
-	{WCD938X_DIGITAL_INTR_SET_0,                           0x00},
-	{WCD938X_DIGITAL_INTR_SET_1,                           0x00},
-	{WCD938X_DIGITAL_INTR_SET_2,                           0x00},
-	{WCD938X_DIGITAL_INTR_TEST_0,                          0x00},
-	{WCD938X_DIGITAL_INTR_TEST_1,                          0x00},
-	{WCD938X_DIGITAL_INTR_TEST_2,                          0x00},
-	{WCD938X_DIGITAL_TX_MODE_DBG_EN,                       0x00},
-	{WCD938X_DIGITAL_TX_MODE_DBG_0_1,                      0x00},
-	{WCD938X_DIGITAL_TX_MODE_DBG_2_3,                      0x00},
-	{WCD938X_DIGITAL_LB_IN_SEL_CTL,                        0x00},
-	{WCD938X_DIGITAL_LOOP_BACK_MODE,                       0x00},
-	{WCD938X_DIGITAL_SWR_DAC_TEST,                         0x00},
-	{WCD938X_DIGITAL_SWR_HM_TEST_RX_0,                     0x40},
-	{WCD938X_DIGITAL_SWR_HM_TEST_TX_0,                     0x40},
-	{WCD938X_DIGITAL_SWR_HM_TEST_RX_1,                     0x00},
-	{WCD938X_DIGITAL_SWR_HM_TEST_TX_1,                     0x00},
-	{WCD938X_DIGITAL_SWR_HM_TEST_TX_2,                     0x00},
-	{WCD938X_DIGITAL_SWR_HM_TEST_0,                        0x00},
-	{WCD938X_DIGITAL_SWR_HM_TEST_1,                        0x00},
-	{WCD938X_DIGITAL_PAD_CTL_SWR_0,                        0x8F},
-	{WCD938X_DIGITAL_PAD_CTL_SWR_1,                        0x06},
-	{WCD938X_DIGITAL_I2C_CTL,                              0x00},
-	{WCD938X_DIGITAL_CDC_TX_TANGGU_SW_MODE,                0x00},
-	{WCD938X_DIGITAL_EFUSE_TEST_CTL_0,                     0x00},
-	{WCD938X_DIGITAL_EFUSE_TEST_CTL_1,                     0x00},
-	{WCD938X_DIGITAL_EFUSE_T_DATA_0,                       0x00},
-	{WCD938X_DIGITAL_EFUSE_T_DATA_1,                       0x00},
-	{WCD938X_DIGITAL_PAD_CTL_PDM_RX0,                      0xF1},
-	{WCD938X_DIGITAL_PAD_CTL_PDM_RX1,                      0xF1},
-	{WCD938X_DIGITAL_PAD_CTL_PDM_TX0,                      0xF1},
-	{WCD938X_DIGITAL_PAD_CTL_PDM_TX1,                      0xF1},
-	{WCD938X_DIGITAL_PAD_CTL_PDM_TX2,                      0xF1},
-	{WCD938X_DIGITAL_PAD_INP_DIS_0,                        0x00},
-	{WCD938X_DIGITAL_PAD_INP_DIS_1,                        0x00},
-	{WCD938X_DIGITAL_DRIVE_STRENGTH_0,                     0x00},
-	{WCD938X_DIGITAL_DRIVE_STRENGTH_1,                     0x00},
-	{WCD938X_DIGITAL_DRIVE_STRENGTH_2,                     0x00},
-	{WCD938X_DIGITAL_RX_DATA_EDGE_CTL,                     0x1F},
-	{WCD938X_DIGITAL_TX_DATA_EDGE_CTL,                     0x80},
-	{WCD938X_DIGITAL_GPIO_MODE,                            0x00},
-	{WCD938X_DIGITAL_PIN_CTL_OE,                           0x00},
-	{WCD938X_DIGITAL_PIN_CTL_DATA_0,                       0x00},
-	{WCD938X_DIGITAL_PIN_CTL_DATA_1,                       0x00},
-	{WCD938X_DIGITAL_PIN_STATUS_0,                         0x00},
-	{WCD938X_DIGITAL_PIN_STATUS_1,                         0x00},
-	{WCD938X_DIGITAL_DIG_DEBUG_CTL,                        0x00},
-	{WCD938X_DIGITAL_DIG_DEBUG_EN,                         0x00},
-	{WCD938X_DIGITAL_ANA_CSR_DBG_ADD,                      0x00},
-	{WCD938X_DIGITAL_ANA_CSR_DBG_CTL,                      0x48},
-	{WCD938X_DIGITAL_SSP_DBG,                              0x00},
-	{WCD938X_DIGITAL_MODE_STATUS_0,                        0x00},
-	{WCD938X_DIGITAL_MODE_STATUS_1,                        0x00},
-	{WCD938X_DIGITAL_SPARE_0,                              0x00},
-	{WCD938X_DIGITAL_SPARE_1,                              0x00},
-	{WCD938X_DIGITAL_SPARE_2,                              0x00},
-	{WCD938X_DIGITAL_EFUSE_REG_0,                          0x00},
-	{WCD938X_DIGITAL_EFUSE_REG_1,                          0xFF},
-	{WCD938X_DIGITAL_EFUSE_REG_2,                          0xFF},
-	{WCD938X_DIGITAL_EFUSE_REG_3,                          0xFF},
-	{WCD938X_DIGITAL_EFUSE_REG_4,                          0xFF},
-	{WCD938X_DIGITAL_EFUSE_REG_5,                          0xFF},
-	{WCD938X_DIGITAL_EFUSE_REG_6,                          0xFF},
-	{WCD938X_DIGITAL_EFUSE_REG_7,                          0xFF},
-	{WCD938X_DIGITAL_EFUSE_REG_8,                          0xFF},
-	{WCD938X_DIGITAL_EFUSE_REG_9,                          0xFF},
-	{WCD938X_DIGITAL_EFUSE_REG_10,                         0xFF},
-	{WCD938X_DIGITAL_EFUSE_REG_11,                         0xFF},
-	{WCD938X_DIGITAL_EFUSE_REG_12,                         0xFF},
-	{WCD938X_DIGITAL_EFUSE_REG_13,                         0xFF},
-	{WCD938X_DIGITAL_EFUSE_REG_14,                         0xFF},
-	{WCD938X_DIGITAL_EFUSE_REG_15,                         0xFF},
-	{WCD938X_DIGITAL_EFUSE_REG_16,                         0xFF},
-	{WCD938X_DIGITAL_EFUSE_REG_17,                         0xFF},
-	{WCD938X_DIGITAL_EFUSE_REG_18,                         0xFF},
-	{WCD938X_DIGITAL_EFUSE_REG_19,                         0xFF},
-	{WCD938X_DIGITAL_EFUSE_REG_20,                         0x0E},
-	{WCD938X_DIGITAL_EFUSE_REG_21,                         0x00},
-	{WCD938X_DIGITAL_EFUSE_REG_22,                         0x00},
-	{WCD938X_DIGITAL_EFUSE_REG_23,                         0xF8},
-	{WCD938X_DIGITAL_EFUSE_REG_24,                         0x16},
-	{WCD938X_DIGITAL_EFUSE_REG_25,                         0x00},
-	{WCD938X_DIGITAL_EFUSE_REG_26,                         0x00},
-	{WCD938X_DIGITAL_EFUSE_REG_27,                         0x00},
-	{WCD938X_DIGITAL_EFUSE_REG_28,                         0x00},
-	{WCD938X_DIGITAL_EFUSE_REG_29,                         0x00},
-	{WCD938X_DIGITAL_EFUSE_REG_30,                         0x00},
-	{WCD938X_DIGITAL_EFUSE_REG_31,                         0x00},
-	{WCD938X_DIGITAL_TX_REQ_FB_CTL_0,                      0x88},
-	{WCD938X_DIGITAL_TX_REQ_FB_CTL_1,                      0x88},
-	{WCD938X_DIGITAL_TX_REQ_FB_CTL_2,                      0x88},
-	{WCD938X_DIGITAL_TX_REQ_FB_CTL_3,                      0x88},
-	{WCD938X_DIGITAL_TX_REQ_FB_CTL_4,                      0x88},
-	{WCD938X_DIGITAL_DEM_BYPASS_DATA0,                     0x55},
-	{WCD938X_DIGITAL_DEM_BYPASS_DATA1,                     0x55},
-	{WCD938X_DIGITAL_DEM_BYPASS_DATA2,                     0x55},
-	{WCD938X_DIGITAL_DEM_BYPASS_DATA3,                     0x01},
-};
-
-static bool wcd938x_rdwr_register(struct device *dev, unsigned int reg)
-{
-	switch (reg) {
-	case WCD938X_ANA_PAGE_REGISTER:
-	case WCD938X_ANA_BIAS:
-	case WCD938X_ANA_RX_SUPPLIES:
-	case WCD938X_ANA_HPH:
-	case WCD938X_ANA_EAR:
-	case WCD938X_ANA_EAR_COMPANDER_CTL:
-	case WCD938X_ANA_TX_CH1:
-	case WCD938X_ANA_TX_CH2:
-	case WCD938X_ANA_TX_CH3:
-	case WCD938X_ANA_TX_CH4:
-	case WCD938X_ANA_MICB1_MICB2_DSP_EN_LOGIC:
-	case WCD938X_ANA_MICB3_DSP_EN_LOGIC:
-	case WCD938X_ANA_MBHC_MECH:
-	case WCD938X_ANA_MBHC_ELECT:
-	case WCD938X_ANA_MBHC_ZDET:
-	case WCD938X_ANA_MBHC_BTN0:
-	case WCD938X_ANA_MBHC_BTN1:
-	case WCD938X_ANA_MBHC_BTN2:
-	case WCD938X_ANA_MBHC_BTN3:
-	case WCD938X_ANA_MBHC_BTN4:
-	case WCD938X_ANA_MBHC_BTN5:
-	case WCD938X_ANA_MBHC_BTN6:
-	case WCD938X_ANA_MBHC_BTN7:
-	case WCD938X_ANA_MICB1:
-	case WCD938X_ANA_MICB2:
-	case WCD938X_ANA_MICB2_RAMP:
-	case WCD938X_ANA_MICB3:
-	case WCD938X_ANA_MICB4:
-	case WCD938X_BIAS_CTL:
-	case WCD938X_BIAS_VBG_FINE_ADJ:
-	case WCD938X_LDOL_VDDCX_ADJUST:
-	case WCD938X_LDOL_DISABLE_LDOL:
-	case WCD938X_MBHC_CTL_CLK:
-	case WCD938X_MBHC_CTL_ANA:
-	case WCD938X_MBHC_CTL_SPARE_1:
-	case WCD938X_MBHC_CTL_SPARE_2:
-	case WCD938X_MBHC_CTL_BCS:
-	case WCD938X_MBHC_TEST_CTL:
-	case WCD938X_LDOH_MODE:
-	case WCD938X_LDOH_BIAS:
-	case WCD938X_LDOH_STB_LOADS:
-	case WCD938X_LDOH_SLOWRAMP:
-	case WCD938X_MICB1_TEST_CTL_1:
-	case WCD938X_MICB1_TEST_CTL_2:
-	case WCD938X_MICB1_TEST_CTL_3:
-	case WCD938X_MICB2_TEST_CTL_1:
-	case WCD938X_MICB2_TEST_CTL_2:
-	case WCD938X_MICB2_TEST_CTL_3:
-	case WCD938X_MICB3_TEST_CTL_1:
-	case WCD938X_MICB3_TEST_CTL_2:
-	case WCD938X_MICB3_TEST_CTL_3:
-	case WCD938X_MICB4_TEST_CTL_1:
-	case WCD938X_MICB4_TEST_CTL_2:
-	case WCD938X_MICB4_TEST_CTL_3:
-	case WCD938X_TX_COM_ADC_VCM:
-	case WCD938X_TX_COM_BIAS_ATEST:
-	case WCD938X_TX_COM_SPARE1:
-	case WCD938X_TX_COM_SPARE2:
-	case WCD938X_TX_COM_TXFE_DIV_CTL:
-	case WCD938X_TX_COM_TXFE_DIV_START:
-	case WCD938X_TX_COM_SPARE3:
-	case WCD938X_TX_COM_SPARE4:
-	case WCD938X_TX_1_2_TEST_EN:
-	case WCD938X_TX_1_2_ADC_IB:
-	case WCD938X_TX_1_2_ATEST_REFCTL:
-	case WCD938X_TX_1_2_TEST_CTL:
-	case WCD938X_TX_1_2_TEST_BLK_EN1:
-	case WCD938X_TX_1_2_TXFE1_CLKDIV:
-	case WCD938X_TX_3_4_TEST_EN:
-	case WCD938X_TX_3_4_ADC_IB:
-	case WCD938X_TX_3_4_ATEST_REFCTL:
-	case WCD938X_TX_3_4_TEST_CTL:
-	case WCD938X_TX_3_4_TEST_BLK_EN3:
-	case WCD938X_TX_3_4_TXFE3_CLKDIV:
-	case WCD938X_TX_3_4_TEST_BLK_EN2:
-	case WCD938X_TX_3_4_TXFE2_CLKDIV:
-	case WCD938X_TX_3_4_SPARE1:
-	case WCD938X_TX_3_4_TEST_BLK_EN4:
-	case WCD938X_TX_3_4_TXFE4_CLKDIV:
-	case WCD938X_TX_3_4_SPARE2:
-	case WCD938X_CLASSH_MODE_1:
-	case WCD938X_CLASSH_MODE_2:
-	case WCD938X_CLASSH_MODE_3:
-	case WCD938X_CLASSH_CTRL_VCL_1:
-	case WCD938X_CLASSH_CTRL_VCL_2:
-	case WCD938X_CLASSH_CTRL_CCL_1:
-	case WCD938X_CLASSH_CTRL_CCL_2:
-	case WCD938X_CLASSH_CTRL_CCL_3:
-	case WCD938X_CLASSH_CTRL_CCL_4:
-	case WCD938X_CLASSH_CTRL_CCL_5:
-	case WCD938X_CLASSH_BUCK_TMUX_A_D:
-	case WCD938X_CLASSH_BUCK_SW_DRV_CNTL:
-	case WCD938X_CLASSH_SPARE:
-	case WCD938X_FLYBACK_EN:
-	case WCD938X_FLYBACK_VNEG_CTRL_1:
-	case WCD938X_FLYBACK_VNEG_CTRL_2:
-	case WCD938X_FLYBACK_VNEG_CTRL_3:
-	case WCD938X_FLYBACK_VNEG_CTRL_4:
-	case WCD938X_FLYBACK_VNEG_CTRL_5:
-	case WCD938X_FLYBACK_VNEG_CTRL_6:
-	case WCD938X_FLYBACK_VNEG_CTRL_7:
-	case WCD938X_FLYBACK_VNEG_CTRL_8:
-	case WCD938X_FLYBACK_VNEG_CTRL_9:
-	case WCD938X_FLYBACK_VNEGDAC_CTRL_1:
-	case WCD938X_FLYBACK_VNEGDAC_CTRL_2:
-	case WCD938X_FLYBACK_VNEGDAC_CTRL_3:
-	case WCD938X_FLYBACK_CTRL_1:
-	case WCD938X_FLYBACK_TEST_CTL:
-	case WCD938X_RX_AUX_SW_CTL:
-	case WCD938X_RX_PA_AUX_IN_CONN:
-	case WCD938X_RX_TIMER_DIV:
-	case WCD938X_RX_OCP_CTL:
-	case WCD938X_RX_OCP_COUNT:
-	case WCD938X_RX_BIAS_EAR_DAC:
-	case WCD938X_RX_BIAS_EAR_AMP:
-	case WCD938X_RX_BIAS_HPH_LDO:
-	case WCD938X_RX_BIAS_HPH_PA:
-	case WCD938X_RX_BIAS_HPH_RDACBUFF_CNP2:
-	case WCD938X_RX_BIAS_HPH_RDAC_LDO:
-	case WCD938X_RX_BIAS_HPH_CNP1:
-	case WCD938X_RX_BIAS_HPH_LOWPOWER:
-	case WCD938X_RX_BIAS_AUX_DAC:
-	case WCD938X_RX_BIAS_AUX_AMP:
-	case WCD938X_RX_BIAS_VNEGDAC_BLEEDER:
-	case WCD938X_RX_BIAS_MISC:
-	case WCD938X_RX_BIAS_BUCK_RST:
-	case WCD938X_RX_BIAS_BUCK_VREF_ERRAMP:
-	case WCD938X_RX_BIAS_FLYB_ERRAMP:
-	case WCD938X_RX_BIAS_FLYB_BUFF:
-	case WCD938X_RX_BIAS_FLYB_MID_RST:
-	case WCD938X_HPH_CNP_EN:
-	case WCD938X_HPH_CNP_WG_CTL:
-	case WCD938X_HPH_CNP_WG_TIME:
-	case WCD938X_HPH_OCP_CTL:
-	case WCD938X_HPH_AUTO_CHOP:
-	case WCD938X_HPH_CHOP_CTL:
-	case WCD938X_HPH_PA_CTL1:
-	case WCD938X_HPH_PA_CTL2:
-	case WCD938X_HPH_L_EN:
-	case WCD938X_HPH_L_TEST:
-	case WCD938X_HPH_L_ATEST:
-	case WCD938X_HPH_R_EN:
-	case WCD938X_HPH_R_TEST:
-	case WCD938X_HPH_R_ATEST:
-	case WCD938X_HPH_RDAC_CLK_CTL1:
-	case WCD938X_HPH_RDAC_CLK_CTL2:
-	case WCD938X_HPH_RDAC_LDO_CTL:
-	case WCD938X_HPH_RDAC_CHOP_CLK_LP_CTL:
-	case WCD938X_HPH_REFBUFF_UHQA_CTL:
-	case WCD938X_HPH_REFBUFF_LP_CTL:
-	case WCD938X_HPH_L_DAC_CTL:
-	case WCD938X_HPH_R_DAC_CTL:
-	case WCD938X_HPH_SURGE_HPHLR_SURGE_COMP_SEL:
-	case WCD938X_HPH_SURGE_HPHLR_SURGE_EN:
-	case WCD938X_HPH_SURGE_HPHLR_SURGE_MISC1:
-	case WCD938X_EAR_EAR_EN_REG:
-	case WCD938X_EAR_EAR_PA_CON:
-	case WCD938X_EAR_EAR_SP_CON:
-	case WCD938X_EAR_EAR_DAC_CON:
-	case WCD938X_EAR_EAR_CNP_FSM_CON:
-	case WCD938X_EAR_TEST_CTL:
-	case WCD938X_ANA_NEW_PAGE_REGISTER:
-	case WCD938X_HPH_NEW_ANA_HPH2:
-	case WCD938X_HPH_NEW_ANA_HPH3:
-	case WCD938X_SLEEP_CTL:
-	case WCD938X_SLEEP_WATCHDOG_CTL:
-	case WCD938X_MBHC_NEW_ELECT_REM_CLAMP_CTL:
-	case WCD938X_MBHC_NEW_CTL_1:
-	case WCD938X_MBHC_NEW_CTL_2:
-	case WCD938X_MBHC_NEW_PLUG_DETECT_CTL:
-	case WCD938X_MBHC_NEW_ZDET_ANA_CTL:
-	case WCD938X_MBHC_NEW_ZDET_RAMP_CTL:
-	case WCD938X_TX_NEW_AMIC_MUX_CFG:
-	case WCD938X_AUX_AUXPA:
-	case WCD938X_LDORXTX_MODE:
-	case WCD938X_LDORXTX_CONFIG:
-	case WCD938X_DIE_CRACK_DIE_CRK_DET_EN:
-	case WCD938X_HPH_NEW_INT_RDAC_GAIN_CTL:
-	case WCD938X_HPH_NEW_INT_RDAC_HD2_CTL_L:
-	case WCD938X_HPH_NEW_INT_RDAC_VREF_CTL:
-	case WCD938X_HPH_NEW_INT_RDAC_OVERRIDE_CTL:
-	case WCD938X_HPH_NEW_INT_RDAC_HD2_CTL_R:
-	case WCD938X_HPH_NEW_INT_PA_MISC1:
-	case WCD938X_HPH_NEW_INT_PA_MISC2:
-	case WCD938X_HPH_NEW_INT_PA_RDAC_MISC:
-	case WCD938X_HPH_NEW_INT_HPH_TIMER1:
-	case WCD938X_HPH_NEW_INT_HPH_TIMER2:
-	case WCD938X_HPH_NEW_INT_HPH_TIMER3:
-	case WCD938X_HPH_NEW_INT_HPH_TIMER4:
-	case WCD938X_HPH_NEW_INT_PA_RDAC_MISC2:
-	case WCD938X_HPH_NEW_INT_PA_RDAC_MISC3:
-	case WCD938X_HPH_NEW_INT_RDAC_HD2_CTL_L_NEW:
-	case WCD938X_HPH_NEW_INT_RDAC_HD2_CTL_R_NEW:
-	case WCD938X_RX_NEW_INT_HPH_RDAC_BIAS_LOHIFI:
-	case WCD938X_RX_NEW_INT_HPH_RDAC_BIAS_ULP:
-	case WCD938X_RX_NEW_INT_HPH_RDAC_LDO_LP:
-	case WCD938X_MBHC_NEW_INT_MOISTURE_DET_DC_CTRL:
-	case WCD938X_MBHC_NEW_INT_MOISTURE_DET_POLLING_CTRL:
-	case WCD938X_MBHC_NEW_INT_MECH_DET_CURRENT:
-	case WCD938X_MBHC_NEW_INT_SPARE_2:
-	case WCD938X_EAR_INT_NEW_EAR_CHOPPER_CON:
-	case WCD938X_EAR_INT_NEW_CNP_VCM_CON1:
-	case WCD938X_EAR_INT_NEW_CNP_VCM_CON2:
-	case WCD938X_EAR_INT_NEW_EAR_DYNAMIC_BIAS:
-	case WCD938X_AUX_INT_EN_REG:
-	case WCD938X_AUX_INT_PA_CTRL:
-	case WCD938X_AUX_INT_SP_CTRL:
-	case WCD938X_AUX_INT_DAC_CTRL:
-	case WCD938X_AUX_INT_CLK_CTRL:
-	case WCD938X_AUX_INT_TEST_CTRL:
-	case WCD938X_AUX_INT_MISC:
-	case WCD938X_LDORXTX_INT_BIAS:
-	case WCD938X_LDORXTX_INT_STB_LOADS_DTEST:
-	case WCD938X_LDORXTX_INT_TEST0:
-	case WCD938X_LDORXTX_INT_STARTUP_TIMER:
-	case WCD938X_LDORXTX_INT_TEST1:
-	case WCD938X_SLEEP_INT_WATCHDOG_CTL_1:
-	case WCD938X_SLEEP_INT_WATCHDOG_CTL_2:
-	case WCD938X_DIE_CRACK_INT_DIE_CRK_DET_INT1:
-	case WCD938X_DIE_CRACK_INT_DIE_CRK_DET_INT2:
-	case WCD938X_TX_COM_NEW_INT_TXFE_DIVSTOP_L2:
-	case WCD938X_TX_COM_NEW_INT_TXFE_DIVSTOP_L1:
-	case WCD938X_TX_COM_NEW_INT_TXFE_DIVSTOP_L0:
-	case WCD938X_TX_COM_NEW_INT_TXFE_DIVSTOP_ULP1P2M:
-	case WCD938X_TX_COM_NEW_INT_TXFE_DIVSTOP_ULP0P6M:
-	case WCD938X_TX_COM_NEW_INT_TXFE_ICTRL_STG1_L2L1:
-	case WCD938X_TX_COM_NEW_INT_TXFE_ICTRL_STG1_L0:
-	case WCD938X_TX_COM_NEW_INT_TXFE_ICTRL_STG1_ULP:
-	case WCD938X_TX_COM_NEW_INT_TXFE_ICTRL_STG2MAIN_L2L1:
-	case WCD938X_TX_COM_NEW_INT_TXFE_ICTRL_STG2MAIN_L0:
-	case WCD938X_TX_COM_NEW_INT_TXFE_ICTRL_STG2MAIN_ULP:
-	case WCD938X_TX_COM_NEW_INT_TXFE_ICTRL_STG2CASC_L2L1L0:
-	case WCD938X_TX_COM_NEW_INT_TXFE_ICTRL_STG2CASC_ULP:
-	case WCD938X_TX_COM_NEW_INT_TXADC_SCBIAS_L2L1:
-	case WCD938X_TX_COM_NEW_INT_TXADC_SCBIAS_L0ULP:
-	case WCD938X_TX_COM_NEW_INT_TXADC_INT_L2:
-	case WCD938X_TX_COM_NEW_INT_TXADC_INT_L1:
-	case WCD938X_TX_COM_NEW_INT_TXADC_INT_L0:
-	case WCD938X_TX_COM_NEW_INT_TXADC_INT_ULP:
-	case WCD938X_DIGITAL_PAGE_REGISTER:
-	case WCD938X_DIGITAL_SWR_TX_CLK_RATE:
-	case WCD938X_DIGITAL_CDC_RST_CTL:
-	case WCD938X_DIGITAL_TOP_CLK_CFG:
-	case WCD938X_DIGITAL_CDC_ANA_CLK_CTL:
-	case WCD938X_DIGITAL_CDC_DIG_CLK_CTL:
-	case WCD938X_DIGITAL_SWR_RST_EN:
-	case WCD938X_DIGITAL_CDC_PATH_MODE:
-	case WCD938X_DIGITAL_CDC_RX_RST:
-	case WCD938X_DIGITAL_CDC_RX0_CTL:
-	case WCD938X_DIGITAL_CDC_RX1_CTL:
-	case WCD938X_DIGITAL_CDC_RX2_CTL:
-	case WCD938X_DIGITAL_CDC_TX_ANA_MODE_0_1:
-	case WCD938X_DIGITAL_CDC_TX_ANA_MODE_2_3:
-	case WCD938X_DIGITAL_CDC_COMP_CTL_0:
-	case WCD938X_DIGITAL_CDC_ANA_TX_CLK_CTL:
-	case WCD938X_DIGITAL_CDC_HPH_DSM_A1_0:
-	case WCD938X_DIGITAL_CDC_HPH_DSM_A1_1:
-	case WCD938X_DIGITAL_CDC_HPH_DSM_A2_0:
-	case WCD938X_DIGITAL_CDC_HPH_DSM_A2_1:
-	case WCD938X_DIGITAL_CDC_HPH_DSM_A3_0:
-	case WCD938X_DIGITAL_CDC_HPH_DSM_A3_1:
-	case WCD938X_DIGITAL_CDC_HPH_DSM_A4_0:
-	case WCD938X_DIGITAL_CDC_HPH_DSM_A4_1:
-	case WCD938X_DIGITAL_CDC_HPH_DSM_A5_0:
-	case WCD938X_DIGITAL_CDC_HPH_DSM_A5_1:
-	case WCD938X_DIGITAL_CDC_HPH_DSM_A6_0:
-	case WCD938X_DIGITAL_CDC_HPH_DSM_A7_0:
-	case WCD938X_DIGITAL_CDC_HPH_DSM_C_0:
-	case WCD938X_DIGITAL_CDC_HPH_DSM_C_1:
-	case WCD938X_DIGITAL_CDC_HPH_DSM_C_2:
-	case WCD938X_DIGITAL_CDC_HPH_DSM_C_3:
-	case WCD938X_DIGITAL_CDC_HPH_DSM_R1:
-	case WCD938X_DIGITAL_CDC_HPH_DSM_R2:
-	case WCD938X_DIGITAL_CDC_HPH_DSM_R3:
-	case WCD938X_DIGITAL_CDC_HPH_DSM_R4:
-	case WCD938X_DIGITAL_CDC_HPH_DSM_R5:
-	case WCD938X_DIGITAL_CDC_HPH_DSM_R6:
-	case WCD938X_DIGITAL_CDC_HPH_DSM_R7:
-	case WCD938X_DIGITAL_CDC_AUX_DSM_A1_0:
-	case WCD938X_DIGITAL_CDC_AUX_DSM_A1_1:
-	case WCD938X_DIGITAL_CDC_AUX_DSM_A2_0:
-	case WCD938X_DIGITAL_CDC_AUX_DSM_A2_1:
-	case WCD938X_DIGITAL_CDC_AUX_DSM_A3_0:
-	case WCD938X_DIGITAL_CDC_AUX_DSM_A3_1:
-	case WCD938X_DIGITAL_CDC_AUX_DSM_A4_0:
-	case WCD938X_DIGITAL_CDC_AUX_DSM_A4_1:
-	case WCD938X_DIGITAL_CDC_AUX_DSM_A5_0:
-	case WCD938X_DIGITAL_CDC_AUX_DSM_A5_1:
-	case WCD938X_DIGITAL_CDC_AUX_DSM_A6_0:
-	case WCD938X_DIGITAL_CDC_AUX_DSM_A7_0:
-	case WCD938X_DIGITAL_CDC_AUX_DSM_C_0:
-	case WCD938X_DIGITAL_CDC_AUX_DSM_C_1:
-	case WCD938X_DIGITAL_CDC_AUX_DSM_C_2:
-	case WCD938X_DIGITAL_CDC_AUX_DSM_C_3:
-	case WCD938X_DIGITAL_CDC_AUX_DSM_R1:
-	case WCD938X_DIGITAL_CDC_AUX_DSM_R2:
-	case WCD938X_DIGITAL_CDC_AUX_DSM_R3:
-	case WCD938X_DIGITAL_CDC_AUX_DSM_R4:
-	case WCD938X_DIGITAL_CDC_AUX_DSM_R5:
-	case WCD938X_DIGITAL_CDC_AUX_DSM_R6:
-	case WCD938X_DIGITAL_CDC_AUX_DSM_R7:
-	case WCD938X_DIGITAL_CDC_HPH_GAIN_RX_0:
-	case WCD938X_DIGITAL_CDC_HPH_GAIN_RX_1:
-	case WCD938X_DIGITAL_CDC_HPH_GAIN_DSD_0:
-	case WCD938X_DIGITAL_CDC_HPH_GAIN_DSD_1:
-	case WCD938X_DIGITAL_CDC_HPH_GAIN_DSD_2:
-	case WCD938X_DIGITAL_CDC_AUX_GAIN_DSD_0:
-	case WCD938X_DIGITAL_CDC_AUX_GAIN_DSD_1:
-	case WCD938X_DIGITAL_CDC_AUX_GAIN_DSD_2:
-	case WCD938X_DIGITAL_CDC_HPH_GAIN_CTL:
-	case WCD938X_DIGITAL_CDC_AUX_GAIN_CTL:
-	case WCD938X_DIGITAL_CDC_EAR_PATH_CTL:
-	case WCD938X_DIGITAL_CDC_SWR_CLH:
-	case WCD938X_DIGITAL_SWR_CLH_BYP:
-	case WCD938X_DIGITAL_CDC_TX0_CTL:
-	case WCD938X_DIGITAL_CDC_TX1_CTL:
-	case WCD938X_DIGITAL_CDC_TX2_CTL:
-	case WCD938X_DIGITAL_CDC_TX_RST:
-	case WCD938X_DIGITAL_CDC_REQ_CTL:
-	case WCD938X_DIGITAL_CDC_RST:
-	case WCD938X_DIGITAL_CDC_AMIC_CTL:
-	case WCD938X_DIGITAL_CDC_DMIC_CTL:
-	case WCD938X_DIGITAL_CDC_DMIC1_CTL:
-	case WCD938X_DIGITAL_CDC_DMIC2_CTL:
-	case WCD938X_DIGITAL_CDC_DMIC3_CTL:
-	case WCD938X_DIGITAL_CDC_DMIC4_CTL:
-	case WCD938X_DIGITAL_EFUSE_PRG_CTL:
-	case WCD938X_DIGITAL_EFUSE_CTL:
-	case WCD938X_DIGITAL_CDC_DMIC_RATE_1_2:
-	case WCD938X_DIGITAL_CDC_DMIC_RATE_3_4:
-	case WCD938X_DIGITAL_PDM_WD_CTL0:
-	case WCD938X_DIGITAL_PDM_WD_CTL1:
-	case WCD938X_DIGITAL_PDM_WD_CTL2:
-	case WCD938X_DIGITAL_INTR_MODE:
-	case WCD938X_DIGITAL_INTR_MASK_0:
-	case WCD938X_DIGITAL_INTR_MASK_1:
-	case WCD938X_DIGITAL_INTR_MASK_2:
-	case WCD938X_DIGITAL_INTR_CLEAR_0:
-	case WCD938X_DIGITAL_INTR_CLEAR_1:
-	case WCD938X_DIGITAL_INTR_CLEAR_2:
-	case WCD938X_DIGITAL_INTR_LEVEL_0:
-	case WCD938X_DIGITAL_INTR_LEVEL_1:
-	case WCD938X_DIGITAL_INTR_LEVEL_2:
-	case WCD938X_DIGITAL_INTR_SET_0:
-	case WCD938X_DIGITAL_INTR_SET_1:
-	case WCD938X_DIGITAL_INTR_SET_2:
-	case WCD938X_DIGITAL_INTR_TEST_0:
-	case WCD938X_DIGITAL_INTR_TEST_1:
-	case WCD938X_DIGITAL_INTR_TEST_2:
-	case WCD938X_DIGITAL_TX_MODE_DBG_EN:
-	case WCD938X_DIGITAL_TX_MODE_DBG_0_1:
-	case WCD938X_DIGITAL_TX_MODE_DBG_2_3:
-	case WCD938X_DIGITAL_LB_IN_SEL_CTL:
-	case WCD938X_DIGITAL_LOOP_BACK_MODE:
-	case WCD938X_DIGITAL_SWR_DAC_TEST:
-	case WCD938X_DIGITAL_SWR_HM_TEST_RX_0:
-	case WCD938X_DIGITAL_SWR_HM_TEST_TX_0:
-	case WCD938X_DIGITAL_SWR_HM_TEST_RX_1:
-	case WCD938X_DIGITAL_SWR_HM_TEST_TX_1:
-	case WCD938X_DIGITAL_SWR_HM_TEST_TX_2:
-	case WCD938X_DIGITAL_PAD_CTL_SWR_0:
-	case WCD938X_DIGITAL_PAD_CTL_SWR_1:
-	case WCD938X_DIGITAL_I2C_CTL:
-	case WCD938X_DIGITAL_CDC_TX_TANGGU_SW_MODE:
-	case WCD938X_DIGITAL_EFUSE_TEST_CTL_0:
-	case WCD938X_DIGITAL_EFUSE_TEST_CTL_1:
-	case WCD938X_DIGITAL_PAD_CTL_PDM_RX0:
-	case WCD938X_DIGITAL_PAD_CTL_PDM_RX1:
-	case WCD938X_DIGITAL_PAD_CTL_PDM_TX0:
-	case WCD938X_DIGITAL_PAD_CTL_PDM_TX1:
-	case WCD938X_DIGITAL_PAD_CTL_PDM_TX2:
-	case WCD938X_DIGITAL_PAD_INP_DIS_0:
-	case WCD938X_DIGITAL_PAD_INP_DIS_1:
-	case WCD938X_DIGITAL_DRIVE_STRENGTH_0:
-	case WCD938X_DIGITAL_DRIVE_STRENGTH_1:
-	case WCD938X_DIGITAL_DRIVE_STRENGTH_2:
-	case WCD938X_DIGITAL_RX_DATA_EDGE_CTL:
-	case WCD938X_DIGITAL_TX_DATA_EDGE_CTL:
-	case WCD938X_DIGITAL_GPIO_MODE:
-	case WCD938X_DIGITAL_PIN_CTL_OE:
-	case WCD938X_DIGITAL_PIN_CTL_DATA_0:
-	case WCD938X_DIGITAL_PIN_CTL_DATA_1:
-	case WCD938X_DIGITAL_DIG_DEBUG_CTL:
-	case WCD938X_DIGITAL_DIG_DEBUG_EN:
-	case WCD938X_DIGITAL_ANA_CSR_DBG_ADD:
-	case WCD938X_DIGITAL_ANA_CSR_DBG_CTL:
-	case WCD938X_DIGITAL_SSP_DBG:
-	case WCD938X_DIGITAL_SPARE_0:
-	case WCD938X_DIGITAL_SPARE_1:
-	case WCD938X_DIGITAL_SPARE_2:
-	case WCD938X_DIGITAL_TX_REQ_FB_CTL_0:
-	case WCD938X_DIGITAL_TX_REQ_FB_CTL_1:
-	case WCD938X_DIGITAL_TX_REQ_FB_CTL_2:
-	case WCD938X_DIGITAL_TX_REQ_FB_CTL_3:
-	case WCD938X_DIGITAL_TX_REQ_FB_CTL_4:
-	case WCD938X_DIGITAL_DEM_BYPASS_DATA0:
-	case WCD938X_DIGITAL_DEM_BYPASS_DATA1:
-	case WCD938X_DIGITAL_DEM_BYPASS_DATA2:
-	case WCD938X_DIGITAL_DEM_BYPASS_DATA3:
-		return true;
-	}
-
-	return false;
-}
-
-static bool wcd938x_readonly_register(struct device *dev, unsigned int reg)
-{
-	switch (reg) {
-	case WCD938X_ANA_MBHC_RESULT_1:
-	case WCD938X_ANA_MBHC_RESULT_2:
-	case WCD938X_ANA_MBHC_RESULT_3:
-	case WCD938X_MBHC_MOISTURE_DET_FSM_STATUS:
-	case WCD938X_TX_1_2_SAR2_ERR:
-	case WCD938X_TX_1_2_SAR1_ERR:
-	case WCD938X_TX_3_4_SAR4_ERR:
-	case WCD938X_TX_3_4_SAR3_ERR:
-	case WCD938X_HPH_L_STATUS:
-	case WCD938X_HPH_R_STATUS:
-	case WCD938X_HPH_SURGE_HPHLR_SURGE_STATUS:
-	case WCD938X_EAR_STATUS_REG_1:
-	case WCD938X_EAR_STATUS_REG_2:
-	case WCD938X_MBHC_NEW_FSM_STATUS:
-	case WCD938X_MBHC_NEW_ADC_RESULT:
-	case WCD938X_DIE_CRACK_DIE_CRK_DET_OUT:
-	case WCD938X_AUX_INT_STATUS_REG:
-	case WCD938X_LDORXTX_INT_STATUS:
-	case WCD938X_DIGITAL_CHIP_ID0:
-	case WCD938X_DIGITAL_CHIP_ID1:
-	case WCD938X_DIGITAL_CHIP_ID2:
-	case WCD938X_DIGITAL_CHIP_ID3:
-	case WCD938X_DIGITAL_INTR_STATUS_0:
-	case WCD938X_DIGITAL_INTR_STATUS_1:
-	case WCD938X_DIGITAL_INTR_STATUS_2:
-	case WCD938X_DIGITAL_INTR_CLEAR_0:
-	case WCD938X_DIGITAL_INTR_CLEAR_1:
-	case WCD938X_DIGITAL_INTR_CLEAR_2:
-	case WCD938X_DIGITAL_SWR_HM_TEST_0:
-	case WCD938X_DIGITAL_SWR_HM_TEST_1:
-	case WCD938X_DIGITAL_EFUSE_T_DATA_0:
-	case WCD938X_DIGITAL_EFUSE_T_DATA_1:
-	case WCD938X_DIGITAL_PIN_STATUS_0:
-	case WCD938X_DIGITAL_PIN_STATUS_1:
-	case WCD938X_DIGITAL_MODE_STATUS_0:
-	case WCD938X_DIGITAL_MODE_STATUS_1:
-	case WCD938X_DIGITAL_EFUSE_REG_0:
-	case WCD938X_DIGITAL_EFUSE_REG_1:
-	case WCD938X_DIGITAL_EFUSE_REG_2:
-	case WCD938X_DIGITAL_EFUSE_REG_3:
-	case WCD938X_DIGITAL_EFUSE_REG_4:
-	case WCD938X_DIGITAL_EFUSE_REG_5:
-	case WCD938X_DIGITAL_EFUSE_REG_6:
-	case WCD938X_DIGITAL_EFUSE_REG_7:
-	case WCD938X_DIGITAL_EFUSE_REG_8:
-	case WCD938X_DIGITAL_EFUSE_REG_9:
-	case WCD938X_DIGITAL_EFUSE_REG_10:
-	case WCD938X_DIGITAL_EFUSE_REG_11:
-	case WCD938X_DIGITAL_EFUSE_REG_12:
-	case WCD938X_DIGITAL_EFUSE_REG_13:
-	case WCD938X_DIGITAL_EFUSE_REG_14:
-	case WCD938X_DIGITAL_EFUSE_REG_15:
-	case WCD938X_DIGITAL_EFUSE_REG_16:
-	case WCD938X_DIGITAL_EFUSE_REG_17:
-	case WCD938X_DIGITAL_EFUSE_REG_18:
-	case WCD938X_DIGITAL_EFUSE_REG_19:
-	case WCD938X_DIGITAL_EFUSE_REG_20:
-	case WCD938X_DIGITAL_EFUSE_REG_21:
-	case WCD938X_DIGITAL_EFUSE_REG_22:
-	case WCD938X_DIGITAL_EFUSE_REG_23:
-	case WCD938X_DIGITAL_EFUSE_REG_24:
-	case WCD938X_DIGITAL_EFUSE_REG_25:
-	case WCD938X_DIGITAL_EFUSE_REG_26:
-	case WCD938X_DIGITAL_EFUSE_REG_27:
-	case WCD938X_DIGITAL_EFUSE_REG_28:
-	case WCD938X_DIGITAL_EFUSE_REG_29:
-	case WCD938X_DIGITAL_EFUSE_REG_30:
-	case WCD938X_DIGITAL_EFUSE_REG_31:
-		return true;
-	}
-	return false;
-}
-
-static bool wcd938x_readable_register(struct device *dev, unsigned int reg)
-{
-	bool ret;
-
-	ret = wcd938x_readonly_register(dev, reg);
-	if (!ret)
-		return wcd938x_rdwr_register(dev, reg);
-
-	return ret;
-}
-
-static bool wcd938x_writeable_register(struct device *dev, unsigned int reg)
-{
-	return wcd938x_rdwr_register(dev, reg);
-}
-
-static bool wcd938x_volatile_register(struct device *dev, unsigned int reg)
-{
-	if (reg <= WCD938X_BASE_ADDRESS)
-		return false;
-
-	if (reg == WCD938X_DIGITAL_SWR_TX_CLK_RATE)
-		return true;
-
-	if (wcd938x_readonly_register(dev, reg))
-		return true;
-
-	return false;
-}
-
-static struct regmap_config wcd938x_regmap_config = {
-	.name = "wcd938x_csr",
-	.reg_bits = 32,
-	.val_bits = 8,
-	.cache_type = REGCACHE_RBTREE,
-	.reg_defaults = wcd938x_defaults,
-	.num_reg_defaults = ARRAY_SIZE(wcd938x_defaults),
-	.max_register = WCD938X_MAX_REGISTER,
-	.readable_reg = wcd938x_readable_register,
-	.writeable_reg = wcd938x_writeable_register,
-	.volatile_reg = wcd938x_volatile_register,
-	.can_multi_write = true,
-};
-
 static const struct regmap_irq wcd938x_irqs[WCD938X_NUM_IRQS] = {
 	REGMAP_IRQ_REG(WCD938X_IRQ_MBHC_BUTTON_PRESS_DET, 0, 0x01),
 	REGMAP_IRQ_REG(WCD938X_IRQ_MBHC_BUTTON_RELEASE_DET, 0, 0x02),
@@ -4412,10 +3417,10 @@ static int wcd938x_bind(struct device *dev)
 		return -EINVAL;
 	}
 
-	wcd938x->regmap = devm_regmap_init_sdw(wcd938x->tx_sdw_dev, &wcd938x_regmap_config);
-	if (IS_ERR(wcd938x->regmap)) {
-		dev_err(dev, "%s: tx csr regmap not found\n", __func__);
-		return PTR_ERR(wcd938x->regmap);
+	wcd938x->regmap = dev_get_regmap(&wcd938x->tx_sdw_dev->dev, NULL);
+	if (!wcd938x->regmap) {
+		dev_err(dev, "could not get TX device regmap\n");
+		return -EINVAL;
 	}
 
 	ret = wcd938x_irq_init(wcd938x, dev);
diff --git a/sound/soc/codecs/wcd938x.h b/sound/soc/codecs/wcd938x.h
index ea82039e7843..74b1498fec38 100644
--- a/sound/soc/codecs/wcd938x.h
+++ b/sound/soc/codecs/wcd938x.h
@@ -663,6 +663,7 @@ struct wcd938x_sdw_priv {
 	bool is_tx;
 	struct wcd938x_priv *wcd938x;
 	struct irq_domain *slave_irq;
+	struct regmap *regmap;
 };
 
 #if IS_ENABLED(CONFIG_SND_SOC_WCD938X_SDW)
diff --git a/sound/soc/codecs/wsa881x.c b/sound/soc/codecs/wsa881x.c
index 6c8b1db649b8..046843b57b03 100644
--- a/sound/soc/codecs/wsa881x.c
+++ b/sound/soc/codecs/wsa881x.c
@@ -1101,7 +1101,7 @@ static int wsa881x_bus_config(struct sdw_slave *slave,
 	return 0;
 }
 
-static struct sdw_slave_ops wsa881x_slave_ops = {
+static const struct sdw_slave_ops wsa881x_slave_ops = {
 	.update_status = wsa881x_update_status,
 	.bus_config = wsa881x_bus_config,
 	.port_prep = wsa881x_port_prep,
diff --git a/sound/soc/codecs/wsa883x.c b/sound/soc/codecs/wsa883x.c
index 2533d0973529..6e9a64c5948e 100644
--- a/sound/soc/codecs/wsa883x.c
+++ b/sound/soc/codecs/wsa883x.c
@@ -1073,7 +1073,7 @@ static int wsa883x_port_prep(struct sdw_slave *slave,
 	return 0;
 }
 
-static struct sdw_slave_ops wsa883x_slave_ops = {
+static const struct sdw_slave_ops wsa883x_slave_ops = {
 	.update_status = wsa883x_update_status,
 	.port_prep = wsa883x_port_prep,
 };
diff --git a/sound/soc/intel/common/soc-acpi-intel-byt-match.c b/sound/soc/intel/common/soc-acpi-intel-byt-match.c
index db5a92b9875a..87c44f284971 100644
--- a/sound/soc/intel/common/soc-acpi-intel-byt-match.c
+++ b/sound/soc/intel/common/soc-acpi-intel-byt-match.c
@@ -124,7 +124,7 @@ static const struct snd_soc_acpi_codecs rt5640_comp_ids = {
 };
 
 static const struct snd_soc_acpi_codecs wm5102_comp_ids = {
-	.num_codecs = 2,
+	.num_codecs = 3,
 	.codecs = { "10WM5102", "WM510204", "WM510205"},
 };
 
diff --git a/sound/usb/caiaq/input.c b/sound/usb/caiaq/input.c
index 1e2cf2f08eec..84f26dce7f5d 100644
--- a/sound/usb/caiaq/input.c
+++ b/sound/usb/caiaq/input.c
@@ -804,6 +804,7 @@ int snd_usb_caiaq_input_init(struct snd_usb_caiaqdev *cdev)
 
 	default:
 		/* no input methods supported on this device */
+		ret = -EINVAL;
 		goto exit_free_idev;
 	}
 
diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
index 7de07bb16d23..4bc5b7cf3e04 100644
--- a/tools/perf/builtin-ftrace.c
+++ b/tools/perf/builtin-ftrace.c
@@ -1228,10 +1228,12 @@ int cmd_ftrace(int argc, const char **argv)
 		goto out_delete_filters;
 	}
 
+	/* Make system wide (-a) the default target. */
+	if (!argc && target__none(&ftrace.target))
+		ftrace.target.system_wide = true;
+
 	switch (subcmd) {
 	case PERF_FTRACE_TRACE:
-		if (!argc && target__none(&ftrace.target))
-			ftrace.target.system_wide = true;
 		cmd_func = __cmd_ftrace;
 		break;
 	case PERF_FTRACE_LATENCY:
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 48c3461b496c..7314183cdcb6 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1864,7 +1864,7 @@ static void __record__read_lost_samples(struct record *rec, struct evsel *evsel,
 	int id_hdr_size;
 
 	if (perf_evsel__read(&evsel->core, cpu_idx, thread_idx, &count) < 0) {
-		pr_err("read LOST count failed\n");
+		pr_debug("read LOST count failed\n");
 		return;
 	}
 
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index f6427e3a4742..a2c74a34e4a4 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -765,7 +765,7 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 		counter->reset_group = false;
 		if (bpf_counter__load(counter, &target))
 			return -1;
-		if (!evsel__is_bpf(counter))
+		if (!(evsel__is_bperf(counter)))
 			all_counters_use_bpf = false;
 	}
 
@@ -781,7 +781,7 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 
 		if (counter->reset_group || counter->errored)
 			continue;
-		if (evsel__is_bpf(counter))
+		if (evsel__is_bperf(counter))
 			continue;
 try_again:
 		if (create_perf_stat_counter(counter, &stat_config, &target,
diff --git a/tools/perf/pmu-events/arch/powerpc/power9/other.json b/tools/perf/pmu-events/arch/powerpc/power9/other.json
index 3f69422c21f9..f10bd554521a 100644
--- a/tools/perf/pmu-events/arch/powerpc/power9/other.json
+++ b/tools/perf/pmu-events/arch/powerpc/power9/other.json
@@ -1417,7 +1417,7 @@
   {
     "EventCode": "0x45054",
     "EventName": "PM_FMA_CMPL",
-    "BriefDescription": "two flops operation completed (fmadd, fnmadd, fmsub, fnmsub) Scalar instructions only. "
+    "BriefDescription": "two flops operation completed (fmadd, fnmadd, fmsub, fnmsub) Scalar instructions only."
   },
   {
     "EventCode": "0x201E8",
@@ -2017,7 +2017,7 @@
   {
     "EventCode": "0xC0BC",
     "EventName": "PM_LSU_FLUSH_OTHER",
-    "BriefDescription": "Other LSU flushes including: Sync (sync ack from L2 caused search of LRQ for oldest snooped load, This will either signal a Precise Flush of the oldest snooped loa or a Flush Next PPC); Data Valid Flush Next (several cases of this, one example is store and reload are lined up such that a store-hit-reload scenario exists and the CDF has already launched and has gotten bad/stale data); Bad Data Valid Flush Next (might be a few cases of this, one example is a larxa (D$ hit) return data and dval but can't allocate to LMQ (LMQ full or other reason). Already gave dval but can't watch it for snoop_hit_larx. Need to take the “bad dval” back and flush all younger ops)"
+    "BriefDescription": "Other LSU flushes including: Sync (sync ack from L2 caused search of LRQ for oldest snooped load, This will either signal a Precise Flush of the oldest snooped loa or a Flush Next PPC); Data Valid Flush Next (several cases of this, one example is store and reload are lined up such that a store-hit-reload scenario exists and the CDF has already launched and has gotten bad/stale data); Bad Data Valid Flush Next (might be a few cases of this, one example is a larxa (D$ hit) return data and dval but can't allocate to LMQ (LMQ full or other reason). Already gave dval but can't watch it for snoop_hit_larx. Need to take the 'bad dval' back and flush all younger ops)"
   },
   {
     "EventCode": "0x5094",
diff --git a/tools/perf/pmu-events/arch/powerpc/power9/pipeline.json b/tools/perf/pmu-events/arch/powerpc/power9/pipeline.json
index d0265f255de2..723bffa41c44 100644
--- a/tools/perf/pmu-events/arch/powerpc/power9/pipeline.json
+++ b/tools/perf/pmu-events/arch/powerpc/power9/pipeline.json
@@ -442,7 +442,7 @@
   {
     "EventCode": "0x4D052",
     "EventName": "PM_2FLOP_CMPL",
-    "BriefDescription": "DP vector version of fmul, fsub, fcmp, fsel, fabs, fnabs, fres ,fsqrte, fneg "
+    "BriefDescription": "DP vector version of fmul, fsub, fcmp, fsel, fabs, fnabs, fres ,fsqrte, fneg"
   },
   {
     "EventCode": "0x1F142",
diff --git a/tools/perf/pmu-events/arch/s390/cf_z16/extended.json b/tools/perf/pmu-events/arch/s390/cf_z16/extended.json
index c306190fc06f..c2b10ec1c6e0 100644
--- a/tools/perf/pmu-events/arch/s390/cf_z16/extended.json
+++ b/tools/perf/pmu-events/arch/s390/cf_z16/extended.json
@@ -95,28 +95,28 @@
 		"EventCode": "145",
 		"EventName": "DCW_REQ",
 		"BriefDescription": "Directory Write Level 1 Data Cache from Cache",
-		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from the requestor’s Level-2 cache."
+		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from the requestors Level-2 cache."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "146",
 		"EventName": "DCW_REQ_IV",
 		"BriefDescription": "Directory Write Level 1 Data Cache from Cache with Intervention",
-		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from the requestor’s Level-2 cache with intervention."
+		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from the requestors Level-2 cache with intervention."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "147",
 		"EventName": "DCW_REQ_CHIP_HIT",
 		"BriefDescription": "Directory Write Level 1 Data Cache from Cache with Chip HP Hit",
-		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from the requestor’s Level-2 cache after using chip level horizontal persistence, Chip-HP hit."
+		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from the requestors Level-2 cache after using chip level horizontal persistence, Chip-HP hit."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "148",
 		"EventName": "DCW_REQ_DRAWER_HIT",
 		"BriefDescription": "Directory Write Level 1 Data Cache from Cache with Drawer HP Hit",
-		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from the requestor’s Level-2 cache after using drawer level horizontal persistence, Drawer-HP hit."
+		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from the requestors Level-2 cache after using drawer level horizontal persistence, Drawer-HP hit."
 	},
 	{
 		"Unit": "CPU-M-CF",
@@ -284,7 +284,7 @@
 		"EventCode": "172",
 		"EventName": "ICW_REQ_DRAWER_HIT",
 		"BriefDescription": "Directory Write Level 1 Instruction Cache from Cache with Drawer HP Hit",
-		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from the requestor’s Level-2 cache using drawer level horizontal persistence, Drawer-HP hit."
+		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from the requestors Level-2 cache using drawer level horizontal persistence, Drawer-HP hit."
 	},
 	{
 		"Unit": "CPU-M-CF",
diff --git a/tools/perf/scripts/python/intel-pt-events.py b/tools/perf/scripts/python/intel-pt-events.py
index 6be7fd8fd615..8058b2fc2b68 100644
--- a/tools/perf/scripts/python/intel-pt-events.py
+++ b/tools/perf/scripts/python/intel-pt-events.py
@@ -11,7 +11,7 @@
 # FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
 # more details.
 
-from __future__ import print_function
+from __future__ import division, print_function
 
 import os
 import sys
diff --git a/tools/perf/tests/shell/record_offcpu.sh b/tools/perf/tests/shell/record_offcpu.sh
index d2eba583a2ac..054272750aa9 100755
--- a/tools/perf/tests/shell/record_offcpu.sh
+++ b/tools/perf/tests/shell/record_offcpu.sh
@@ -65,7 +65,7 @@ test_offcpu_child() {
 
   # perf bench sched messaging creates 400 processes
   if ! perf record --off-cpu -e dummy -o ${perfdata} -- \
-    perf bench sched messaging -g 10 > /dev/null 2&>1
+    perf bench sched messaging -g 10 > /dev/null 2>&1
   then
     echo "Child task off-cpu test [Failed record]"
     err=1
diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 16db965ac995..09e240e4477d 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -2488,26 +2488,29 @@ static int cs_etm__process_auxtrace_event(struct perf_session *session,
 	return 0;
 }
 
-static bool cs_etm__is_timeless_decoding(struct cs_etm_auxtrace *etm)
+static int cs_etm__setup_timeless_decoding(struct cs_etm_auxtrace *etm)
 {
 	struct evsel *evsel;
 	struct evlist *evlist = etm->session->evlist;
-	bool timeless_decoding = true;
 
 	/* Override timeless mode with user input from --itrace=Z */
-	if (etm->synth_opts.timeless_decoding)
-		return true;
+	if (etm->synth_opts.timeless_decoding) {
+		etm->timeless_decoding = true;
+		return 0;
+	}
 
 	/*
-	 * Circle through the list of event and complain if we find one
-	 * with the time bit set.
+	 * Find the cs_etm evsel and look at what its timestamp setting was
 	 */
-	evlist__for_each_entry(evlist, evsel) {
-		if ((evsel->core.attr.sample_type & PERF_SAMPLE_TIME))
-			timeless_decoding = false;
-	}
+	evlist__for_each_entry(evlist, evsel)
+		if (cs_etm__evsel_is_auxtrace(etm->session, evsel)) {
+			etm->timeless_decoding =
+				!(evsel->core.attr.config & BIT(ETM_OPT_TS));
+			return 0;
+		}
 
-	return timeless_decoding;
+	pr_err("CS ETM: Couldn't find ETM evsel\n");
+	return -EINVAL;
 }
 
 static const char * const cs_etm_global_header_fmts[] = {
@@ -3051,7 +3054,6 @@ int cs_etm__process_auxtrace_info(union perf_event *event,
 	etm->snapshot_mode = (hdr[CS_ETM_SNAPSHOT] != 0);
 	etm->metadata = metadata;
 	etm->auxtrace_type = auxtrace_info->type;
-	etm->timeless_decoding = cs_etm__is_timeless_decoding(etm);
 
 	etm->auxtrace.process_event = cs_etm__process_event;
 	etm->auxtrace.process_auxtrace_event = cs_etm__process_auxtrace_event;
@@ -3061,6 +3063,10 @@ int cs_etm__process_auxtrace_info(union perf_event *event,
 	etm->auxtrace.evsel_is_auxtrace = cs_etm__evsel_is_auxtrace;
 	session->auxtrace = &etm->auxtrace;
 
+	err = cs_etm__setup_timeless_decoding(etm);
+	if (err)
+		return err;
+
 	etm->unknown_thread = thread__new(999999999, 999999999);
 	if (!etm->unknown_thread) {
 		err = -ENOMEM;
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 989865e16aad..8ce30329a077 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -263,6 +263,11 @@ static inline bool evsel__is_bpf(struct evsel *evsel)
 	return evsel->bpf_counter_ops != NULL;
 }
 
+static inline bool evsel__is_bperf(struct evsel *evsel)
+{
+	return evsel->bpf_counter_ops != NULL && list_empty(&evsel->bpf_counter_list);
+}
+
 #define EVSEL__MAX_ALIASES 8
 
 extern const char *const evsel__hw_cache[PERF_COUNT_HW_CACHE_MAX][EVSEL__MAX_ALIASES];
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 03284059175f..9a762c0cc53c 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -1845,7 +1845,7 @@ static int perf_pmu__new_caps(struct list_head *list, char *name, char *value)
 	return 0;
 
 free_name:
-	zfree(caps->name);
+	zfree(&caps->name);
 free_caps:
 	free(caps);
 
diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index 2e7330867e2e..6882b1714499 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -876,8 +876,7 @@ static int hist_entry__dso_to_filter(struct hist_entry *he, int type,
 static int64_t
 sort__sym_from_cmp(struct hist_entry *left, struct hist_entry *right)
 {
-	struct addr_map_symbol *from_l = &left->branch_info->from;
-	struct addr_map_symbol *from_r = &right->branch_info->from;
+	struct addr_map_symbol *from_l, *from_r;
 
 	if (!left->branch_info || !right->branch_info)
 		return cmp_null(left->branch_info, right->branch_info);
diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index 80345695b136..29c9348c30f0 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -553,7 +553,7 @@ static int elf_read_build_id(Elf *elf, void *bf, size_t size)
 				size_t sz = min(size, descsz);
 				memcpy(bf, ptr, sz);
 				memset(bf + sz, 0, size - sz);
-				err = descsz;
+				err = sz;
 				break;
 			}
 		}
diff --git a/tools/perf/util/tracepoint.c b/tools/perf/util/tracepoint.c
index 89ef56c43311..92dd8b455b90 100644
--- a/tools/perf/util/tracepoint.c
+++ b/tools/perf/util/tracepoint.c
@@ -50,6 +50,7 @@ int is_valid_tracepoint(const char *event_string)
 				 sys_dirent->d_name, evt_dirent->d_name);
 			if (!strcmp(evt_path, event_string)) {
 				closedir(evt_dir);
+				put_events_file(dir_path);
 				closedir(sys_dir);
 				return 1;
 			}
diff --git a/tools/testing/selftests/net/srv6_end_dt46_l3vpn_test.sh b/tools/testing/selftests/net/srv6_end_dt46_l3vpn_test.sh
index aebaab8ce44c..441eededa031 100755
--- a/tools/testing/selftests/net/srv6_end_dt46_l3vpn_test.sh
+++ b/tools/testing/selftests/net/srv6_end_dt46_l3vpn_test.sh
@@ -292,6 +292,11 @@ setup_hs()
 	ip netns exec ${hsname} sysctl -wq net.ipv6.conf.all.accept_dad=0
 	ip netns exec ${hsname} sysctl -wq net.ipv6.conf.default.accept_dad=0
 
+	# disable the rp_filter otherwise the kernel gets confused about how
+	# to route decap ipv4 packets.
+	ip netns exec ${rtname} sysctl -wq net.ipv4.conf.all.rp_filter=0
+	ip netns exec ${rtname} sysctl -wq net.ipv4.conf.default.rp_filter=0
+
 	ip -netns ${hsname} link add veth0 type veth peer name ${rtveth}
 	ip -netns ${hsname} link set ${rtveth} netns ${rtname}
 	ip -netns ${hsname} addr add ${IPv6_HS_NETWORK}::${hs}/64 dev veth0 nodad
@@ -316,11 +321,6 @@ setup_hs()
 	ip netns exec ${rtname} sysctl -wq net.ipv6.conf.${rtveth}.proxy_ndp=1
 	ip netns exec ${rtname} sysctl -wq net.ipv4.conf.${rtveth}.proxy_arp=1
 
-	# disable the rp_filter otherwise the kernel gets confused about how
-	# to route decap ipv4 packets.
-	ip netns exec ${rtname} sysctl -wq net.ipv4.conf.all.rp_filter=0
-	ip netns exec ${rtname} sysctl -wq net.ipv4.conf.${rtveth}.rp_filter=0
-
 	ip netns exec ${rtname} sh -c "echo 1 > /proc/sys/net/vrf/strict_mode"
 }
 
diff --git a/tools/testing/selftests/netfilter/Makefile b/tools/testing/selftests/netfilter/Makefile
index 4504ee07be08..3686bfa6c58d 100644
--- a/tools/testing/selftests/netfilter/Makefile
+++ b/tools/testing/selftests/netfilter/Makefile
@@ -8,8 +8,11 @@ TEST_PROGS := nft_trans_stress.sh nft_fib.sh nft_nat.sh bridge_brouter.sh \
 	ipip-conntrack-mtu.sh conntrack_tcp_unreplied.sh \
 	conntrack_vrf.sh nft_synproxy.sh rpath.sh
 
-CFLAGS += $(shell pkg-config --cflags libmnl 2>/dev/null || echo "-I/usr/include/libmnl")
-LDLIBS = -lmnl
+HOSTPKG_CONFIG := pkg-config
+
+CFLAGS += $(shell $(HOSTPKG_CONFIG) --cflags libmnl 2>/dev/null)
+LDLIBS += $(shell $(HOSTPKG_CONFIG) --libs libmnl 2>/dev/null || echo -lmnl)
+
 TEST_GEN_FILES =  nf-queue connect_close
 
 include ../lib.mk
