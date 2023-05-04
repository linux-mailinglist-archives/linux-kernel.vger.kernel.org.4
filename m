Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFC926F2B98
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 01:38:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231814AbjD3Xiz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Apr 2023 19:38:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230194AbjD3Xiw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Apr 2023 19:38:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D255310DE;
        Sun, 30 Apr 2023 16:38:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5175261519;
        Sun, 30 Apr 2023 23:38:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7693EC433D2;
        Sun, 30 Apr 2023 23:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1682897928;
        bh=5f+J+Df7EQQvcEKE/4vhY97kXkLYPTlxS7DhqfF0KMA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PARMJ4dwLwNqGins6UIsKWr12koogpg+6hZcAhRGnIrN71yyYtm/PYRW7lGXjp57D
         kFl0Solbty6GH4+EmQ19uhHCRyCCAibmvkIFNaHD7jhEhkgNEZfszmRL5iXDvtxatr
         Ijl0s1NP85F4KpLZSNgyZTNZx8Zh0QXmJbG3dFxU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 5.15.110
Date:   Mon,  1 May 2023 08:38:40 +0900
Message-Id: <2023050139-consent-bankable-bd8f@gregkh>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <2023050139-ashes-backstab-021f@gregkh>
References: <2023050139-ashes-backstab-021f@gregkh>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

diff --git a/Documentation/riscv/vm-layout.rst b/Documentation/riscv/vm-layout.rst
index b7f98930d38d..a2ec11da38b0 100644
--- a/Documentation/riscv/vm-layout.rst
+++ b/Documentation/riscv/vm-layout.rst
@@ -48,7 +48,7 @@ RISC-V Linux Kernel SV39
   ____________________________________________________________|___________________________________________________________
                     |            |                  |         |
    ffffffc000000000 | -256    GB | ffffffc7ffffffff |   32 GB | kasan
-   ffffffcefee00000 | -196    GB | ffffffcefeffffff |    2 MB | fixmap
+   ffffffcefea00000 | -196    GB | ffffffcefeffffff |    6 MB | fixmap
    ffffffceff000000 | -196    GB | ffffffceffffffff |   16 MB | PCI io
    ffffffcf00000000 | -196    GB | ffffffcfffffffff |    4 GB | vmemmap
    ffffffd000000000 | -192    GB | ffffffdfffffffff |   64 GB | vmalloc/ioremap space
diff --git a/Makefile b/Makefile
index 610991822c20..781af18b5984 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 5
 PATCHLEVEL = 15
-SUBLEVEL = 109
+SUBLEVEL = 110
 EXTRAVERSION =
 NAME = Trick or Treat
 
diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index 9b465cd55a8d..38a8095744a0 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -997,6 +997,20 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 		return -EFAULT;
 	}
 
+	/*
+	 * Permission faults just need to update the existing leaf entry,
+	 * and so normally don't require allocations from the memcache. The
+	 * only exception to this is when dirty logging is enabled at runtime
+	 * and a write fault needs to collapse a block entry into a table.
+	 */
+	if (fault_status != FSC_PERM ||
+	    (logging_active && write_fault)) {
+		ret = kvm_mmu_topup_memory_cache(memcache,
+						 kvm_mmu_cache_min_pages(kvm));
+		if (ret)
+			return ret;
+	}
+
 	/*
 	 * Let's check if we will get back a huge page backed by hugetlbfs, or
 	 * get block mapping for device MMIO region.
@@ -1051,36 +1065,17 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 		fault_ipa &= ~(vma_pagesize - 1);
 
 	gfn = fault_ipa >> PAGE_SHIFT;
-	mmap_read_unlock(current->mm);
-
-	/*
-	 * Permission faults just need to update the existing leaf entry,
-	 * and so normally don't require allocations from the memcache. The
-	 * only exception to this is when dirty logging is enabled at runtime
-	 * and a write fault needs to collapse a block entry into a table.
-	 */
-	if (fault_status != FSC_PERM || (logging_active && write_fault)) {
-		ret = kvm_mmu_topup_memory_cache(memcache,
-						 kvm_mmu_cache_min_pages(kvm));
-		if (ret)
-			return ret;
-	}
 
-	mmu_seq = vcpu->kvm->mmu_notifier_seq;
 	/*
-	 * Ensure the read of mmu_notifier_seq happens before we call
-	 * gfn_to_pfn_prot (which calls get_user_pages), so that we don't risk
-	 * the page we just got a reference to gets unmapped before we have a
-	 * chance to grab the mmu_lock, which ensure that if the page gets
-	 * unmapped afterwards, the call to kvm_unmap_gfn will take it away
-	 * from us again properly. This smp_rmb() interacts with the smp_wmb()
-	 * in kvm_mmu_notifier_invalidate_<page|range_end>.
+	 * Read mmu_notifier_seq so that KVM can detect if the results of
+	 * vma_lookup() or __gfn_to_pfn_memslot() become stale prior to
+	 * acquiring kvm->mmu_lock.
 	 *
-	 * Besides, __gfn_to_pfn_memslot() instead of gfn_to_pfn_prot() is
-	 * used to avoid unnecessary overhead introduced to locate the memory
-	 * slot because it's always fixed even @gfn is adjusted for huge pages.
+	 * Rely on mmap_read_unlock() for an implicit smp_rmb(), which pairs
+	 * with the smp_wmb() in kvm_dec_notifier_count().
 	 */
-	smp_rmb();
+	mmu_seq = vcpu->kvm->mmu_notifier_seq;
+	mmap_read_unlock(current->mm);
 
 	pfn = __gfn_to_pfn_memslot(memslot, gfn, false, NULL,
 				   write_fault, &writable, NULL);
diff --git a/arch/arm64/kvm/psci.c b/arch/arm64/kvm/psci.c
index 44efe12dfc06..be03ea3e775a 100644
--- a/arch/arm64/kvm/psci.c
+++ b/arch/arm64/kvm/psci.c
@@ -508,6 +508,8 @@ int kvm_arm_set_fw_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
 	u64 val;
 	int wa_level;
 
+	if (KVM_REG_SIZE(reg->id) != sizeof(val))
+		return -ENOENT;
 	if (copy_from_user(&val, uaddr, KVM_REG_SIZE(reg->id)))
 		return -EFAULT;
 
diff --git a/arch/riscv/include/asm/fixmap.h b/arch/riscv/include/asm/fixmap.h
index 54cbf07fb4e9..8839cd2b28d1 100644
--- a/arch/riscv/include/asm/fixmap.h
+++ b/arch/riscv/include/asm/fixmap.h
@@ -22,6 +22,14 @@
  */
 enum fixed_addresses {
 	FIX_HOLE,
+	/*
+	 * The fdt fixmap mapping must be PMD aligned and will be mapped
+	 * using PMD entries in fixmap_pmd in 64-bit and a PGD entry in 32-bit.
+	 */
+	FIX_FDT_END,
+	FIX_FDT = FIX_FDT_END + FIX_FDT_SIZE / PAGE_SIZE - 1,
+
+	/* Below fixmaps will be mapped using fixmap_pte */
 	FIX_PTE,
 	FIX_PMD,
 	FIX_TEXT_POKE1,
diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 39b550310ec6..397cb945b16e 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -66,9 +66,13 @@
 
 #define FIXADDR_TOP      PCI_IO_START
 #ifdef CONFIG_64BIT
-#define FIXADDR_SIZE     PMD_SIZE
+#define MAX_FDT_SIZE	 PMD_SIZE
+#define FIX_FDT_SIZE	 (MAX_FDT_SIZE + SZ_2M)
+#define FIXADDR_SIZE     (PMD_SIZE + FIX_FDT_SIZE)
 #else
-#define FIXADDR_SIZE     PGDIR_SIZE
+#define MAX_FDT_SIZE	 PGDIR_SIZE
+#define FIX_FDT_SIZE	 MAX_FDT_SIZE
+#define FIXADDR_SIZE     (PGDIR_SIZE + FIX_FDT_SIZE)
 #endif
 #define FIXADDR_START    (FIXADDR_TOP - FIXADDR_SIZE)
 
diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
index 14b84d09354a..8cc147491c67 100644
--- a/arch/riscv/kernel/setup.c
+++ b/arch/riscv/kernel/setup.c
@@ -286,12 +286,8 @@ void __init setup_arch(char **cmdline_p)
 #if IS_ENABLED(CONFIG_BUILTIN_DTB)
 	unflatten_and_copy_device_tree();
 #else
-	if (early_init_dt_verify(__va(XIP_FIXUP(dtb_early_pa))))
-		unflatten_device_tree();
-	else
-		pr_err("No DTB found in kernel mappings\n");
+	unflatten_device_tree();
 #endif
-	early_init_fdt_scan_reserved_mem();
 	misc_mem_init();
 
 	init_resources();
diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 830f53b141a0..e800d7981e99 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -49,7 +49,6 @@ unsigned long empty_zero_page[PAGE_SIZE / sizeof(unsigned long)]
 EXPORT_SYMBOL(empty_zero_page);
 
 extern char _start[];
-#define DTB_EARLY_BASE_VA      PGDIR_SIZE
 void *_dtb_early_va __initdata;
 uintptr_t _dtb_early_pa __initdata;
 
@@ -216,31 +215,22 @@ static void __init setup_bootmem(void)
 	set_max_mapnr(max_low_pfn - ARCH_PFN_OFFSET);
 
 	reserve_initrd_mem();
+
+	/*
+	 * No allocation should be done before reserving the memory as defined
+	 * in the device tree, otherwise the allocation could end up in a
+	 * reserved region.
+	 */
+	early_init_fdt_scan_reserved_mem();
+
 	/*
 	 * If DTB is built in, no need to reserve its memblock.
 	 * Otherwise, do reserve it but avoid using
 	 * early_init_fdt_reserve_self() since __pa() does
 	 * not work for DTB pointers that are fixmap addresses
 	 */
-	if (!IS_ENABLED(CONFIG_BUILTIN_DTB)) {
-		/*
-		 * In case the DTB is not located in a memory region we won't
-		 * be able to locate it later on via the linear mapping and
-		 * get a segfault when accessing it via __va(dtb_early_pa).
-		 * To avoid this situation copy DTB to a memory region.
-		 * Note that memblock_phys_alloc will also reserve DTB region.
-		 */
-		if (!memblock_is_memory(dtb_early_pa)) {
-			size_t fdt_size = fdt_totalsize(dtb_early_va);
-			phys_addr_t new_dtb_early_pa = memblock_phys_alloc(fdt_size, PAGE_SIZE);
-			void *new_dtb_early_va = early_memremap(new_dtb_early_pa, fdt_size);
-
-			memcpy(new_dtb_early_va, dtb_early_va, fdt_size);
-			early_memunmap(new_dtb_early_va, fdt_size);
-			_dtb_early_pa = new_dtb_early_pa;
-		} else
-			memblock_reserve(dtb_early_pa, fdt_totalsize(dtb_early_va));
-	}
+	if (!IS_ENABLED(CONFIG_BUILTIN_DTB))
+		memblock_reserve(dtb_early_pa, fdt_totalsize(dtb_early_va));
 
 	dma_contiguous_reserve(dma32_phys_limit);
 	if (IS_ENABLED(CONFIG_64BIT))
@@ -265,7 +255,6 @@ pgd_t trampoline_pg_dir[PTRS_PER_PGD] __page_aligned_bss;
 static pte_t fixmap_pte[PTRS_PER_PTE] __page_aligned_bss;
 
 pgd_t early_pg_dir[PTRS_PER_PGD] __initdata __aligned(PAGE_SIZE);
-static pmd_t __maybe_unused early_dtb_pmd[PTRS_PER_PMD] __initdata __aligned(PAGE_SIZE);
 
 #ifdef CONFIG_XIP_KERNEL
 #define riscv_pfn_base         (*(unsigned long  *)XIP_FIXUP(&riscv_pfn_base))
@@ -580,24 +569,28 @@ static void __init create_kernel_page_table(pgd_t *pgdir, bool early)
  * this means 2 PMD entries whereas for 32-bit kernel, this is only 1 PGDIR
  * entry.
  */
-static void __init create_fdt_early_page_table(pgd_t *pgdir, uintptr_t dtb_pa)
+static void __init create_fdt_early_page_table(pgd_t *pgdir,
+					       uintptr_t fix_fdt_va,
+					       uintptr_t dtb_pa)
 {
-#ifndef CONFIG_BUILTIN_DTB
 	uintptr_t pa = dtb_pa & ~(PMD_SIZE - 1);
 
-	create_pgd_mapping(early_pg_dir, DTB_EARLY_BASE_VA,
-			   IS_ENABLED(CONFIG_64BIT) ? (uintptr_t)early_dtb_pmd : pa,
-			   PGDIR_SIZE,
-			   IS_ENABLED(CONFIG_64BIT) ? PAGE_TABLE : PAGE_KERNEL);
+#ifndef CONFIG_BUILTIN_DTB
+	/* Make sure the fdt fixmap address is always aligned on PMD size */
+	BUILD_BUG_ON(FIX_FDT % (PMD_SIZE / PAGE_SIZE));
 
-	if (IS_ENABLED(CONFIG_64BIT)) {
-		create_pmd_mapping(early_dtb_pmd, DTB_EARLY_BASE_VA,
+	/* In 32-bit only, the fdt lies in its own PGD */
+	if (!IS_ENABLED(CONFIG_64BIT)) {
+		create_pgd_mapping(early_pg_dir, fix_fdt_va,
+				   pa, MAX_FDT_SIZE, PAGE_KERNEL);
+	} else {
+		create_pmd_mapping(fixmap_pmd, fix_fdt_va,
 				   pa, PMD_SIZE, PAGE_KERNEL);
-		create_pmd_mapping(early_dtb_pmd, DTB_EARLY_BASE_VA + PMD_SIZE,
+		create_pmd_mapping(fixmap_pmd, fix_fdt_va + PMD_SIZE,
 				   pa + PMD_SIZE, PMD_SIZE, PAGE_KERNEL);
 	}
 
-	dtb_early_va = (void *)DTB_EARLY_BASE_VA + (dtb_pa & (PMD_SIZE - 1));
+	dtb_early_va = (void *)fix_fdt_va + (dtb_pa & (PMD_SIZE - 1));
 #else
 	/*
 	 * For 64-bit kernel, __va can't be used since it would return a linear
@@ -685,7 +678,8 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
 	create_kernel_page_table(early_pg_dir, true);
 
 	/* Setup early mapping for FDT early scan */
-	create_fdt_early_page_table(early_pg_dir, dtb_pa);
+	create_fdt_early_page_table(early_pg_dir,
+				    __fix_to_virt(FIX_FDT), dtb_pa);
 
 	/*
 	 * Bootime fixmap only can handle PMD_SIZE mapping. Thus, boot-ioremap
@@ -735,6 +729,16 @@ static void __init setup_vm_final(void)
 	pt_ops.get_pmd_virt = get_pmd_virt_fixmap;
 #endif
 	/* Setup swapper PGD for fixmap */
+#if !defined(CONFIG_64BIT)
+	/*
+	 * In 32-bit, the device tree lies in a pgd entry, so it must be copied
+	 * directly in swapper_pg_dir in addition to the pgd entry that points
+	 * to fixmap_pte.
+	 */
+	unsigned long idx = pgd_index(__fix_to_virt(FIX_FDT));
+
+	set_pgd(&swapper_pg_dir[idx], early_pg_dir[idx]);
+#endif
 	create_pgd_mapping(swapper_pg_dir, FIXADDR_START,
 			   __pa_symbol(fixmap_pgd_next),
 			   PGDIR_SIZE, PAGE_TABLE);
diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 9cbf086fe552..ab0b2eb5fa07 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -690,7 +690,12 @@ static int really_probe_debug(struct device *dev, struct device_driver *drv)
 	calltime = ktime_get();
 	ret = really_probe(dev, drv);
 	rettime = ktime_get();
-	pr_debug("probe of %s returned %d after %lld usecs\n",
+	/*
+	 * Don't change this to pr_debug() because that requires
+	 * CONFIG_DYNAMIC_DEBUG and we want a simple 'initcall_debug' on the
+	 * kernel commandline to print this all the time at the debug level.
+	 */
+	printk(KERN_DEBUG "probe of %s returned %d after %lld usecs\n",
 		 dev_name(dev), ret, ktime_us_delta(rettime, calltime));
 	return ret;
 }
diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
index ed589e7182bb..3d9c0444df40 100644
--- a/drivers/gpu/drm/drm_fb_helper.c
+++ b/drivers/gpu/drm/drm_fb_helper.c
@@ -1327,6 +1327,9 @@ int drm_fb_helper_check_var(struct fb_var_screeninfo *var,
 		return -EINVAL;
 	}
 
+	var->xres_virtual = fb->width;
+	var->yres_virtual = fb->height;
+
 	/*
 	 * Workaround for SDL 1.2, which is known to be setting all pixel format
 	 * fields values to zero in some cases. We treat this situation as a
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
index fc622e6b329a..cba909c5bc6b 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -5890,6 +5890,11 @@ static s32 brcmf_get_assoc_ies(struct brcmf_cfg80211_info *cfg,
 		(struct brcmf_cfg80211_assoc_ielen_le *)cfg->extra_buf;
 	req_len = le32_to_cpu(assoc_info->req_len);
 	resp_len = le32_to_cpu(assoc_info->resp_len);
+	if (req_len > WL_EXTRA_BUF_MAX || resp_len > WL_EXTRA_BUF_MAX) {
+		bphy_err(drvr, "invalid lengths in assoc info: req %u resp %u\n",
+			 req_len, resp_len);
+		return -EINVAL;
+	}
 	if (req_len) {
 		err = brcmf_fil_iovar_data_get(ifp, "assoc_req_ies",
 					       cfg->extra_buf,
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 649df298869c..4aa2e655398c 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1140,9 +1140,6 @@ static int pci_raw_set_power_state(struct pci_dev *dev, pci_power_t state)
 	if (need_restore)
 		pci_restore_bars(dev);
 
-	if (dev->bus->self)
-		pcie_aspm_pm_state_change(dev->bus->self);
-
 	return 0;
 }
 
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 72280e9b23b2..e6ea6e950428 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -595,12 +595,10 @@ bool pcie_wait_for_link(struct pci_dev *pdev, bool active);
 #ifdef CONFIG_PCIEASPM
 void pcie_aspm_init_link_state(struct pci_dev *pdev);
 void pcie_aspm_exit_link_state(struct pci_dev *pdev);
-void pcie_aspm_pm_state_change(struct pci_dev *pdev);
 void pcie_aspm_powersave_config_link(struct pci_dev *pdev);
 #else
 static inline void pcie_aspm_init_link_state(struct pci_dev *pdev) { }
 static inline void pcie_aspm_exit_link_state(struct pci_dev *pdev) { }
-static inline void pcie_aspm_pm_state_change(struct pci_dev *pdev) { }
 static inline void pcie_aspm_powersave_config_link(struct pci_dev *pdev) { }
 #endif
 
diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 013a47f587ce..b3ad316418f1 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -1020,25 +1020,6 @@ void pcie_aspm_exit_link_state(struct pci_dev *pdev)
 	up_read(&pci_bus_sem);
 }
 
-/* @pdev: the root port or switch downstream port */
-void pcie_aspm_pm_state_change(struct pci_dev *pdev)
-{
-	struct pcie_link_state *link = pdev->link_state;
-
-	if (aspm_disabled || !link)
-		return;
-	/*
-	 * Devices changed PM state, we should recheck if latency
-	 * meets all functions' requirement
-	 */
-	down_read(&pci_bus_sem);
-	mutex_lock(&aspm_lock);
-	pcie_update_aspm_capable(link->root);
-	pcie_config_aspm_path(link);
-	mutex_unlock(&aspm_lock);
-	up_read(&pci_bus_sem);
-}
-
 void pcie_aspm_powersave_config_link(struct pci_dev *pdev)
 {
 	struct pcie_link_state *link = pdev->link_state;
diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
index fc12fee66141..f05aea57e2d8 100644
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
diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index 3f92a21cabe8..7905e005baa9 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -996,7 +996,14 @@ static int hci_sock_ioctl(struct socket *sock, unsigned int cmd,
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
diff --git a/tools/testing/selftests/kselftest/runner.sh b/tools/testing/selftests/kselftest/runner.sh
index cc9c846585f0..a9ba782d8ca0 100644
--- a/tools/testing/selftests/kselftest/runner.sh
+++ b/tools/testing/selftests/kselftest/runner.sh
@@ -33,9 +33,9 @@ tap_timeout()
 {
 	# Make sure tests will time out if utility is available.
 	if [ -x /usr/bin/timeout ] ; then
-		/usr/bin/timeout --foreground "$kselftest_timeout" "$1"
+		/usr/bin/timeout --foreground "$kselftest_timeout" $1
 	else
-		"$1"
+		$1
 	fi
 }
 
@@ -65,17 +65,25 @@ run_one()
 
 	TEST_HDR_MSG="selftests: $DIR: $BASENAME_TEST"
 	echo "# $TEST_HDR_MSG"
-	if [ ! -x "$TEST" ]; then
-		echo -n "# Warning: file $TEST is "
-		if [ ! -e "$TEST" ]; then
-			echo "missing!"
-		else
-			echo "not executable, correct this."
-		fi
+	if [ ! -e "$TEST" ]; then
+		echo "# Warning: file $TEST is missing!"
 		echo "not ok $test_num $TEST_HDR_MSG"
 	else
+		cmd="./$BASENAME_TEST"
+		if [ ! -x "$TEST" ]; then
+			echo "# Warning: file $TEST is not executable"
+
+			if [ $(head -n 1 "$TEST" | cut -c -2) = "#!" ]
+			then
+				interpreter=$(head -n 1 "$TEST" | cut -c 3-)
+				cmd="$interpreter ./$BASENAME_TEST"
+			else
+				echo "not ok $test_num $TEST_HDR_MSG"
+				return
+			fi
+		fi
 		cd `dirname $TEST` > /dev/null
-		((((( tap_timeout ./$BASENAME_TEST 2>&1; echo $? >&3) |
+		((((( tap_timeout "$cmd" 2>&1; echo $? >&3) |
 			tap_prefix >&4) 3>&1) |
 			(read xs; exit $xs)) 4>>"$logfile" &&
 		echo "ok $test_num $TEST_HDR_MSG") ||
diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 3be615ab1588..96a090e7f47e 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -732,7 +732,7 @@ chk_add_nr()
 	local dump_stats
 
 	printf "%-39s %s" " " "add"
-	count=`ip netns exec $ns2 nstat -as | grep MPTcpExtAddAddr | awk '{print $2}'`
+	count=`ip netns exec $ns2 nstat -as MPTcpExtAddAddr | grep MPTcpExtAddAddr | awk '{print $2}'`
 	[ -z "$count" ] && count=0
 	if [ "$count" != "$add_nr" ]; then
 		echo "[fail] got $count ADD_ADDR[s] expected $add_nr"
