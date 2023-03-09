Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38E9B6B265A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 15:10:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230365AbjCIOKn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 09:10:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231747AbjCIOJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 09:09:55 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 301EFDC3AE
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 06:08:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678370901; x=1709906901;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=PrifQL44FT7SXrZbAn22u99G0EoaQheyU5tOZ3HrePc=;
  b=FWItae1Xs0mbBSSrXfLI9XhitOElDXPq4+KcJmUiBbA0VEEvbEeOszzh
   /3qQUyeNYt2IaHOLODY4JWHwa6CCKVN+USbxqpqbxhLT1/1Hu1qXiZLHN
   HPY5khYL2ui1DY/UOR3TQkcP1MsRHYqgdYdA+KgOHikcYPIq0vbax29vS
   A60pjdV1/tGZnpuQ7iIen9DqoUmDn57YQgin2rGQ53L/0HuO68wDEF2Xl
   OxOowbd0wLD+7xre0qSSYLF37faUa+LzqmmEgAZlDgd5Uf/DbxuLYZ/sH
   cn9OeqUmi3iUte9oHaG2LQwjU41+AjW8Fcxpp7IUhZDDa9wWwYv9q1/sk
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="324771915"
X-IronPort-AV: E=Sophos;i="5.98,246,1673942400"; 
   d="scan'208";a="324771915"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2023 06:04:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="766435834"
X-IronPort-AV: E=Sophos;i="5.98,246,1673942400"; 
   d="scan'208";a="766435834"
Received: from rajatkha-mobl.gar.corp.intel.com (HELO [10.213.100.94]) ([10.213.100.94])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2023 06:04:20 -0800
Message-ID: <975cc790-7dd9-4902-45c1-c69b4be9ba3a@linux.intel.com>
Date:   Thu, 9 Mar 2023 19:34:18 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [BUG] nvme-pci: NVMe probe fails with ENODEV
Content-Language: en-US
From:   Rajat Khandelwal <rajat.khandelwal@linux.intel.com>
To:     kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me
Cc:     linux-nvme@lists.infradead.org,
        "Khandelwal, Rajat" <rajat.khandelwal@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <f1ad4c1a-2871-57be-48cb-2b0e5cec1bfa@linux.intel.com>
In-Reply-To: <f1ad4c1a-2871-57be-48cb-2b0e5cec1bfa@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Apologies for the reply (I was not on plain format).
Sending again (as a reply).

Thanks
Rajat

On 3/9/2023 7:31 PM, Rajat Khandelwal wrote:
> Hi,
> I am seeking some help regarding an issue I encounter sporadically
> with Samsung Portable TBT SSD X5.
>
> Right from the thunderbolt discovery to the PCIe enumeration, everything
> is fine, until 'NVME_REG_CSTS' is tried to be read in 'nvme_reset_work'.
> Precisely, 'readl(dev->bar + NVME_REG_CSTS)' fails.
>
> I handle type-C, thunderbolt and USB4 on Chrome platforms, and currently
> we are working on Intel Raptorlake systems.
> This issue has been witnessed from ADL time-frame and now is seen
> on RPL as well. I would really like to get to the bottom of the problem
> and close the issue.
>
> I have tried 5.10 and 6.1.15 kernels.
>
> During the issue:
> Contents of BAR-0: <garbage> 00000004 (dumped using setpci)
> Contents of kernel PCI resource-0: 0x83000000 (matches with the mem allocation)
> Issue: nvme nvme1: Removing after probe failure status: -19
>
> During a working case:
> Contents of BAR-0: 83000004 (dumped using setpci)
>
> Seems like, the kernel PCIe resource contents don't change (which results in a
> successful ioremap), but somehow the BAR-0 dumps garbage.
>
> The logs for the scenario: (apologies if this is not the way to attach a log in
> the mailing list as I have never done that :)).
>
> [    0.000000] Linux version 6.1.15-01642-g2f18a077d91a (rajath@rajath-NUC10i7FNH) (Chromium OS 16.0_pre475826_p20230103-r1 clang version 16.0.0 (/var/tmp/portage/sys-devel/llvm-16.0_pre475826_p20230103-r1/work/llvm-16.0_pre475826_p20230103/clang 11897708c0229c92802e747564e7c34b722f045f), LLD 16.0.0) #1 SMP PREEMPT_DYNAMIC Thu Mar  9 18:05:29 IST 2023
> [    0.000000] Command line: cros_secure console= loglevel=7 init=/sbin/init cros_secure drm.trace=0x106 root=PARTUUID=73e0a8ba-3018-3845-bb56-4f84cfa7fafd/PARTNROFF=1 rootwait rw dm_verity.error_behavior=3 dm_verity.max_bios=-1 dm_verity.dev_wait=0 dm="1 vroot none ro 1,0 6348800 verity payload=ROOT_DEV hashtree=HASH_DEV hashstart=6348800 alg=sha256 root_hexdigest=0366e3e4513a397e0c251ddd703a03cbd06f8de6ed9f2a1f7ad6617f30a44817 salt=cf6734dadd53d9e3adcabf0ee4138b94df54df8d8095f1a8fec6f49fb90b63e8" noinitrd cros_debug vt.global_cursor_default=0 kern_guid=73e0a8ba-3018-3845-bb56-4f84cfa7fafd add_efi_memmap boot=local noresume noswap i915.modeset=1 ramoops.ecc=1 tpm_tis.force=0 intel_pmc_core.warn_on_s0ix_failures=1 i915.enable_guc=3 i915.enable_dc=4 xdomain=0 swiotlb=65536 intel_iommu=on i915.enable_psr=1 usb-storage.quirks=13fe:6500:u
> [    0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
> [    0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
> [    0.000000] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
> [    0.000000] x86/fpu: Supporting XSAVE feature 0x200: 'Protection Keys User registers'
> [    0.000000] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
> [    0.000000] x86/fpu: xstate_offset[9]:  832, xstate_sizes[9]:    8
> [    0.000000] x86/fpu: Enabled xstate features 0x207, context size is 840 bytes, using 'compacted' format.
> [    0.000000] signal: max sigframe size: 3632
> [    0.000000] BIOS-provided physical RAM map:
> [    0.000000] BIOS-e820: [mem 0x0000000000000000-0x0000000000000fff] reserved
> [    0.000000] BIOS-e820: [mem 0x0000000000001000-0x000000000009ffff] usable
> [    0.000000] BIOS-e820: [mem 0x00000000000a0000-0x00000000000fffff] reserved
> [    0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000007685afff] usable
> [    0.000000] BIOS-e820: [mem 0x000000007685b000-0x00000000803fffff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000c0000000-0x00000000cfffffff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000f8000000-0x00000000f9ffffff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000fb000000-0x00000000fb000fff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000fc800000-0x00000000fe7fffff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000feb00000-0x00000000feb7ffff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000fec00000-0x00000000fecfffff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000fed40000-0x00000000fed6ffff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000fed80000-0x00000000fed87fff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000fed90000-0x00000000fed92fff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000feda0000-0x00000000feda1fff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000fedc0000-0x00000000feddffff] reserved
> [    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000087fbfffff] usable
> [    0.000000] NX (Execute Disable) protection: active
> [    0.000000] SMBIOS 3.0 present.
> [    0.000000] DMI: Google Brya/Brya, BIOS Google_Brya.14505.395.14827 02/20/2023
> [    0.000000] tsc: Detected 2700.000 MHz processor
> [    0.000000] tsc: Detected 2688.000 MHz TSC
> [    0.000002] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
> [    0.000004] e820: remove [mem 0x000a0000-0x000fffff] usable
> [    0.000007] last_pfn = 0x87fc00 max_arch_pfn = 0x400000000
> [    0.000099] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT
> [    0.000554] last_pfn = 0x7685b max_arch_pfn = 0x400000000
> [    0.003716] Using GB pages for direct mapping
> [    0.003786] ACPI: Early table checksum verification disabled
> [    0.003787] ACPI: RSDP 0x00000000000F0000 000024 (v02 COREv4)
> [    0.003789] ACPI: XSDT 0x00000000768710E0 00006C (v01 COREv4 COREBOOT 00000000 CORE 20210331)
> [    0.003792] ACPI: FACP 0x00000000768762C0 000114 (v06 COREv4 COREBOOT 00000000 CORE 20210331)
> [    0.003795] ACPI: DSDT 0x0000000076871280 00503F (v02 COREv4 COREBOOT 20110725 INTL 20210331)
> [    0.003796] ACPI: FACS 0x0000000076871240 000040
> [    0.003796] ACPI: FACS 0x0000000076871240 000040
> [    0.003797] ACPI: SSDT 0x00000000768763E0 007A13 (v02 COREv4 COREBOOT 0000002A CORE 20210331)
> [    0.003798] ACPI: MCFG 0x000000007687DE00 00003C (v01 COREv4 COREBOOT 00000000 CORE 20210331)
> [    0.003799] ACPI: TPM2 0x000000007687DE40 00004C (v04 COREv4 COREBOOT 00000000 CORE 20210331)
> [    0.003800] ACPI: LPIT 0x000000007687DE90 000094 (v00 COREv4 COREBOOT 0000002A CORE 20210331)
> [    0.003801] ACPI: APIC 0x000000007687DF30 0000B2 (v03 COREv4 COREBOOT 00000000 CORE 20210331)
> [    0.003803] ACPI: DMAR 0x000000007687DFF0 0000A0 (v01 COREv4 COREBOOT 00000000 CORE 20210331)
> [    0.003804] ACPI: DBG2 0x000000007687E090 000054 (v00 COREv4 COREBOOT 00000000 CORE 20210331)
> [    0.003805] ACPI: HPET 0x000000007687E0F0 000038 (v01 COREv4 COREBOOT 00000000 CORE 20210331)
> [    0.003805] ACPI: Reserving FACP table memory at [mem 0x768762c0-0x768763d3]
> [    0.003806] ACPI: Reserving DSDT table memory at [mem 0x76871280-0x768762be]
> [    0.003806] ACPI: Reserving FACS table memory at [mem 0x76871240-0x7687127f]
> [    0.003807] ACPI: Reserving FACS table memory at [mem 0x76871240-0x7687127f]
> [    0.003807] ACPI: Reserving SSDT table memory at [mem 0x768763e0-0x7687ddf2]
> [    0.003807] ACPI: Reserving MCFG table memory at [mem 0x7687de00-0x7687de3b]
> [    0.003808] ACPI: Reserving TPM2 table memory at [mem 0x7687de40-0x7687de8b]
> [    0.003808] ACPI: Reserving LPIT table memory at [mem 0x7687de90-0x7687df23]
> [    0.003808] ACPI: Reserving APIC table memory at [mem 0x7687df30-0x7687dfe1]
> [    0.003809] ACPI: Reserving DMAR table memory at [mem 0x7687dff0-0x7687e08f]
> [    0.003809] ACPI: Reserving DBG2 table memory at [mem 0x7687e090-0x7687e0e3]
> [    0.003809] ACPI: Reserving HPET table memory at [mem 0x7687e0f0-0x7687e127]
> [    0.003832] Zone ranges:
> [    0.003833]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
> [    0.003833]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
> [    0.003834]   Normal   [mem 0x0000000100000000-0x000000087fbfffff]
> [    0.003835] Movable zone start for each node
> [    0.003835] Early memory node ranges
> [    0.003835]   node   0: [mem 0x0000000000001000-0x000000000009ffff]
> [    0.003836]   node   0: [mem 0x0000000000100000-0x000000007685afff]
> [    0.003836]   node   0: [mem 0x0000000100000000-0x000000087fbfffff]
> [    0.003837] Initmem setup node 0 [mem 0x0000000000001000-0x000000087fbfffff]
> [    0.003840] On node 0, zone DMA: 1 pages in unavailable ranges
> [    0.003857] On node 0, zone DMA: 96 pages in unavailable ranges
> [    0.049224] On node 0, zone Normal: 6053 pages in unavailable ranges
> [    0.049233] On node 0, zone Normal: 1024 pages in unavailable ranges
> [    0.049254] Reserving Intel graphics memory at [mem 0x7c800000-0x803fffff]
> [    0.053110] ACPI: PM-Timer IO Port: 0x1808
> [    0.053116] ACPI: LAPIC_NMI (acpi_id[0xff] high edge lint[0x1])
> [    0.053155] IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-119
> [    0.053156] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
> [    0.053158] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
> [    0.053160] ACPI: Using ACPI (MADT) for SMP configuration information
> [    0.053160] ACPI: HPET id: 0x8086a701 base: 0xfed00000
> [    0.053164] TSC deadline timer available
> [    0.053165] smpboot: Allowing 12 CPUs, 0 hotplug CPUs
> [    0.053172] [mem 0x80400000-0xbfffffff] available for PCI devices
> [    0.053174] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1910969940391419 ns
> [    0.055965] setup_percpu: NR_CPUS:24 nr_cpumask_bits:12 nr_cpu_ids:12 nr_node_ids:1
> [    0.056338] percpu: Embedded 54 pages/cpu s181864 r8192 d31128 u262144
> [    0.056341] pcpu-alloc: s181864 r8192 d31128 u262144 alloc=1*2097152
> [    0.056343] pcpu-alloc: [0] 00 01 02 03 04 05 06 07 [0] 08 09 10 11 -- -- -- --
> [    0.056354] Built 1 zonelists, mobility grouping on.  Total pages: 8218057
> [    0.056356] Kernel command line: cros_secure console= loglevel=7 init=/sbin/init cros_secure drm.trace=0x106 root=PARTUUID=73e0a8ba-3018-3845-bb56-4f84cfa7fafd/PARTNROFF=1 rootwait rw dm_verity.error_behavior=3 dm_verity.max_bios=-1 dm_verity.dev_wait=0 dm="1 vroot none ro 1,0 6348800 verity payload=ROOT_DEV hashtree=HASH_DEV hashstart=6348800 alg=sha256 root_hexdigest=0366e3e4513a397e0c251ddd703a03cbd06f8de6ed9f2a1f7ad6617f30a44817 salt=cf6734dadd53d9e3adcabf0ee4138b94df54df8d8095f1a8fec6f49fb90b63e8" noinitrd cros_debug vt.global_cursor_default=0 kern_guid=73e0a8ba-3018-3845-bb56-4f84cfa7fafd add_efi_memmap boot=local noresume noswap i915.modeset=1 ramoops.ecc=1 tpm_tis.force=0 intel_pmc_core.warn_on_s0ix_failures=1 i915.enable_guc=3 i915.enable_dc=4 xdomain=0 swiotlb=65536 intel_iommu=on i915.enable_psr=1 usb-storage.quirks=13fe:6500:u
> [    0.056452] Setting dangerous option i915.enable_guc - tainting kernel
> [    0.056454] Setting dangerous option i915.enable_dc - tainting kernel
> [    0.056467] DMAR: IOMMU enabled
> [    0.056469] Setting dangerous option i915.enable_psr - tainting kernel
> [    0.056473] Unknown kernel command line parameters "cros_secure cros_debug noresume noswap dm=1 vroot none ro 1,0 6348800 verity payload=ROOT_DEV hashtree=HASH_DEV hashstart=6348800 alg=sha256 root_hexdigest=0366e3e4513a397e0c251ddd703a03cbd06f8de6ed9f2a1f7ad6617f30a44817 salt=cf6734dadd53d9e3adcabf0ee4138b94df54df8d8095f1a8fec6f49fb90b63e8 boot=local xdomain=0", will be passed to user space.
> [    0.056484] random: crng init done
> [    0.058995] Dentry cache hash table entries: 4194304 (order: 13, 33554432 bytes, linear)
> [    0.060257] Inode-cache hash table entries: 2097152 (order: 12, 16777216 bytes, linear)
> [    0.060463] mem auto-init: stack:all(zero), heap alloc:off, heap free:off
> [    0.060470] software IO TLB: area num 16.
> [    0.120798] Memory: 32648148K/33394664K available (16394K kernel code, 2450K rwdata, 6896K rodata, 1940K init, 2856K bss, 746256K reserved, 0K cma-reserved)
> [    0.120844] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=12, Nodes=1
> [    0.120849] ftrace: allocating 54963 entries in 215 pages
> [    0.120974] ftrace: allocated 215 pages with 6 groups
> [    0.121007] Dynamic Preempt: full
> [    0.121028] rcu: Preemptible hierarchical RCU implementation.
> [    0.121028] rcu: 	RCU restricting CPUs from NR_CPUS=24 to nr_cpu_ids=12.
> [    0.121029] 	Trampoline variant of Tasks RCU enabled.
> [    0.121029] 	Rude variant of Tasks RCU enabled.
> [    0.121029] 	Tracing variant of Tasks RCU enabled.
> [    0.121030] rcu: RCU calculated value of scheduler-enlistment delay is 100 jiffies.
> [    0.121030] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=12
> [    0.122263] NR_IRQS: 4352, nr_irqs: 2152, preallocated irqs: 16
> [    0.122530] rcu: 	Offload RCU callbacks from CPUs: 0-11.
> [    0.122532] rcu: srcu_init: Setting srcu_struct sizes based on contention.
> [    0.122763] kfence: initialized - using 2097152 bytes for 255 objects at 0x(____ptrval____)-0x(____ptrval____)
> [    0.122805] spurious 8259A interrupt: IRQ7.
> [    0.122831] ACPI: Core revision 20220331
> [    0.122862] hpet: HPET dysfunctional in PC10. Force disabled.
> [    0.122863] APIC: Switch to symmetric I/O mode setup
> [    0.122864] DMAR: Host address width 46
> [    0.122864] DMAR: DRHD base: 0x000000fed90000 flags: 0x0
> [    0.122869] DMAR: dmar0: reg_base_addr fed90000 ver 4:0 cap 1c0000c40660462 ecap 29a00f0505e
> [    0.122870] DMAR: DRHD base: 0x000000fed92000 flags: 0x0
> [    0.122872] DMAR: dmar1: reg_base_addr fed92000 ver 1:0 cap d2008c40660462 ecap f050da
> [    0.122873] DMAR: DRHD base: 0x000000fed91000 flags: 0x1
> [    0.122875] DMAR: dmar2: reg_base_addr fed91000 ver 5:0 cap d2008c40660462 ecap f050da
> [    0.122876] DMAR: RMRR base: 0x0000007c000000 end: 0x000000803fffff
> [    0.122878] DMAR-IR: IOAPIC id 2 under DRHD base  0xfed91000 IOMMU 2
> [    0.122879] DMAR-IR: HPET id 0 under DRHD base 0xfed91000
> [    0.122879] DMAR-IR: Queued invalidation will be enabled to support x2apic and Intr-remapping.
> [    0.124576] DMAR-IR: Enabled IRQ remapping in x2apic mode
> [    0.124577] x2apic enabled
> [    0.124596] Switched APIC routing to cluster x2apic.
> [    0.129094] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x26bef67878b, max_idle_ns: 440795293631 ns
> [    0.129098] Calibrating delay loop (skipped), value calculated using timer frequency.. 5376.00 BogoMIPS (lpj=2688000)
> [    0.129099] pid_max: default: 32768 minimum: 301
> [    0.129113] LSM: Security Framework initializing
> [    0.129117] landlock: Up and running.
> [    0.129118] Yama: becoming mindful.
> [    0.129120] LoadPin: ready to pin (currently enforcing)
> [    0.129122] Chromium OS LSM: enabled
> [    0.129122] SELinux:  Initializing.
> [    0.129173] Mount-cache hash table entries: 65536 (order: 7, 524288 bytes, linear)
> [    0.129203] Mountpoint-cache hash table entries: 65536 (order: 7, 524288 bytes, linear)
> [    0.129328] x86/tme: enabled by BIOS
> [    0.129329] x86/tme: Unknown policy is active: 0x2
> [    0.129329] x86/mktme: No known encryption algorithm is supported: 0x4
> [    0.129329] x86/mktme: enabled by BIOS
> [    0.129330] x86/mktme: 15 KeyIDs available
> [    0.129335] CPU0: Thermal monitoring enabled (TM1)
> [    0.129336] x86/cpu: User Mode Instruction Prevention (UMIP) activated
> [    0.129435] process: using mwait in idle threads
> [    0.129436] Last level iTLB entries: 4KB 0, 2MB 0, 4MB 0
> [    0.129437] Last level dTLB entries: 4KB 0, 2MB 0, 4MB 0, 1GB 0
> [    0.129438] Spectre V1 : Mitigation: usercopy/swapgs barriers and __user pointer sanitization
> [    0.129441] Spectre V2 : Mitigation: Enhanced IBRS
> [    0.129441] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB on context switch
> [    0.129441] Spectre V2 : Spectre v2 / PBRSB-eIBRS: Retire a single CALL on VMEXIT
> [    0.129443] Spectre V2 : mitigation: Enabling conditional Indirect Branch Prediction Barrier
> [    0.129445] Speculative Store Bypass: Mitigation: Speculative Store Bypass disabled via prctl
> [    0.130097] Freeing SMP alternatives memory: 40K
> [    0.130097] smpboot: CPU0: 13th Gen Intel(R) Core(TM) i7-1365U (family: 0x6, model: 0xba, stepping: 0x3)
> [    0.130097] cblist_init_generic: Setting adjustable number of callback queues.
> [    0.130097] cblist_init_generic: Setting shift to 4 and lim to 1.
> [    0.130097] cblist_init_generic: Setting shift to 4 and lim to 1.
> [    0.130097] cblist_init_generic: Setting shift to 4 and lim to 1.
> [    0.130097] Performance Events: XSAVE Architectural LBR, PEBS fmt4+-baseline,  AnyThread deprecated, Alderlake Hybrid events, 32-deep LBR, full-width counters, Intel PMU driver.
> [    0.130097] core: cpu_core PMU driver:
> [    0.130097] ... version:                5
> [    0.130097] ... bit width:              48
> [    0.130097] ... generic registers:      8
> [    0.130097] ... value mask:             0000ffffffffffff
> [    0.130097] ... max period:             00007fffffffffff
> [    0.130097] ... fixed-purpose events:   4
> [    0.130097] ... event mask:             0001000f000000ff
> [    0.130097] Estimated ratio of average max frequency by base frequency (times 1024): 1858
> [    0.130097] rcu: Hierarchical SRCU implementation.
> [    0.130097] rcu: 	Max phase no-delay instances is 400.
> [    0.130097] NMI watchdog: Enabled. Permanently consumes one hw-PMU counter.
> [    0.130097] smp: Bringing up secondary CPUs ...
> [    0.130097] x86: Booting SMP configuration:
> [    0.130097] .... node  #0, CPUs:        #1  #2  #3  #4
> [    0.007387] core: cpu_atom PMU driver: PEBS-via-PT
> [    0.007387] ... version:                5
> [    0.007387] ... bit width:              48
> [    0.007387] ... generic registers:      6
> [    0.007387] ... value mask:             0000ffffffffffff
> [    0.007387] ... max period:             00007fffffffffff
> [    0.007387] ... fixed-purpose events:   3
> [    0.007387] ... event mask:             000000070000003f
> [    0.133397]   #5  #6  #7  #8  #9 #10 #11
> [    0.142232] smp: Brought up 1 node, 12 CPUs
> [    0.142232] smpboot: Max logical packages: 1
> [    0.142232] smpboot: Total of 12 processors activated (64512.00 BogoMIPS)
> [    0.143521] devtmpfs: initialized
> [    0.143521] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275000 ns
> [    0.143521] futex hash table entries: 4096 (order: 6, 262144 bytes, linear)
> [    0.143521] pinctrl core: initialized pinctrl subsystem
> [    0.144098] PM: RTC time: 12:54:59, date: 2023-03-09
> [    0.144361] NET: Registered PF_NETLINK/PF_ROUTE protocol family
> [    0.144457] audit: initializing netlink subsys (disabled)
> [    0.144460] audit: type=2000 audit(1678366499.015:1): state=initialized audit_enabled=0 res=1
> [    0.144460] thermal_sys: Registered thermal governor 'step_wise'
> [    0.144460] thermal_sys: Registered thermal governor 'user_space'
> [    0.144460] cpuidle: using governor ladder
> [    0.144460] cpuidle: using governor menu
> [    0.144460] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
> [    0.144460] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0xc0000000-0xcfffffff] (base 0xc0000000)
> [    0.144460] PCI: MMCONFIG at [mem 0xc0000000-0xcfffffff] reserved in E820
> [    0.144460] PCI: Using configuration type 1 for base access
> [    0.145959] kprobes: kprobe jump-optimization is enabled. All kprobes are optimized if possible.
> [    0.147120] cryptd: max_cpu_qlen set to 1000
> [    0.147132] ACPI: Added _OSI(Module Device)
> [    0.147132] ACPI: Added _OSI(Processor Device)
> [    0.147133] ACPI: Added _OSI(3.0 _SCP Extensions)
> [    0.147134] ACPI: Added _OSI(Processor Aggregator Device)
> [    0.149332] ACPI: 2 ACPI AML tables successfully acquired and loaded
> [    0.154204] ACPI: USB4 _OSC: OS supports USB3+ DisplayPort+ PCIe+ XDomain+
> [    0.154205] ACPI: USB4 _OSC: OS controls USB3+ DisplayPort+ PCIe+ XDomain+
> [    0.154315] ACPI: EC: EC started
> [    0.154315] ACPI: EC: interrupt blocked
> [    0.154372] ACPI: EC: EC_CMD/EC_SC=0x66, EC_DATA=0x62
> [    0.154373] ACPI: \_SB_.PCI0.LPCB.EC0_: Boot DSDT EC used to handle transactions
> [    0.154374] ACPI: Interpreter enabled
> [    0.154380] ACPI: PM: (supports S0 S3 S5)
> [    0.154380] ACPI: Using IOAPIC for interrupt routing
> [    0.154387] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
> [    0.154388] PCI: Ignoring E820 reservations for host bridge windows
> [    0.154478] ACPI: Enabled 2 GPEs in block 00 to 7F
> [    0.155013] ACPI: PM: Power Resource [RTD3]
> [    0.155192] ACPI: PM: Power Resource [PRIC]
> [    0.155334] ACPI: PM: Power Resource [PRIC]
> [    0.155391] ACPI: PM: Power Resource [PR00]
> [    0.465285] ACPI: PM: Power Resource [PR01]
> [    0.609221] ACPI: PM: Power Resource [PR02]
> [    0.729264] ACPI: PM: Power Resource [PR03]
> [    0.735424] ACPI: PM: Power Resource [TBT0]
> [    0.735433] ACPI: PM: Power Resource [TBT1]
> [    0.735441] ACPI: PM: Power Resource [D3C]
> [    0.763119] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
> [    0.763125] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX-Type3]
> [    0.763134] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug PME AER PCIeCapability LTR]
> [    0.763596] PCI host bridge to bus 0000:00
> [    0.763597] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
> [    0.763598] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
> [    0.763598] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000fffff window]
> [    0.763599] pci_bus 0000:00: root bus resource [mem 0x80400000-0xdfffffff window]
> [    0.763599] pci_bus 0000:00: root bus resource [mem 0x87fc00000-0x3fffffffffff window]
> [    0.763600] pci_bus 0000:00: root bus resource [mem 0xfc800000-0xfe7fffff window]
> [    0.763600] pci_bus 0000:00: root bus resource [mem 0xfed40000-0xfed47fff window]
> [    0.763601] pci_bus 0000:00: root bus resource [bus 00-ff]
> [    0.763627] pci 0000:00:00.0: [8086:a708] type 00 class 0x060000
> [    0.763742] pci 0000:00:02.0: [8086:a7a1] type 00 class 0x030000
> [    0.763748] pci 0000:00:02.0: reg 0x10: [mem 0x81000000-0x81ffffff 64bit]
> [    0.763753] pci 0000:00:02.0: reg 0x18: [mem 0x90000000-0x9fffffff 64bit pref]
> [    0.763756] pci 0000:00:02.0: reg 0x20: [io  0x1000-0x103f]
> [    0.763766] pci 0000:00:02.0: DMAR: Skip IOMMU disabling for graphics
> [    0.763768] pci 0000:00:02.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
> [    0.763790] pci 0000:00:02.0: reg 0x344: [mem 0x00000000-0x00ffffff 64bit]
> [    0.763790] pci 0000:00:02.0: VF(n) BAR0 space: [mem 0x00000000-0x06ffffff 64bit] (contains BAR0 for 7 VFs)
> [    0.763793] pci 0000:00:02.0: reg 0x34c: [mem 0x00000000-0x1fffffff 64bit pref]
> [    0.763794] pci 0000:00:02.0: VF(n) BAR2 space: [mem 0x00000000-0xdfffffff 64bit pref] (contains BAR2 for 7 VFs)
> [    0.763841] pci 0000:00:04.0: [8086:a71d] type 00 class 0x118000
> [    0.763854] pci 0000:00:04.0: reg 0x10: [mem 0x80780000-0x8079ffff 64bit]
> [    0.763929] pci 0000:00:05.0: [8086:a75d] type 00 class 0x048000
> [    0.763935] pci 0000:00:05.0: reg 0x10: [mem 0x82000000-0x82ffffff 64bit]
> [    0.763950] pci 0000:00:05.0: enabling Extended Tags
> [    0.763954] pci 0000:00:05.0: DMAR: Passthrough IOMMU for integrated Intel IPU
> [    0.764008] pci 0000:00:07.0: [8086:a76e] type 01 class 0x060400
> [    0.764076] pci 0000:00:07.0: PME# supported from D0 D3hot D3cold
> [    0.764166] pci 0000:00:07.1: [8086:a73f] type 01 class 0x060400
> [    0.764237] pci 0000:00:07.1: PME# supported from D0 D3hot D3cold
> [    0.764321] pci 0000:00:07.2: [8086:a72f] type 01 class 0x060400
> [    0.764390] pci 0000:00:07.2: PME# supported from D0 D3hot D3cold
> [    0.764488] pci 0000:00:08.0: [8086:a74f] type 00 class 0x088000
> [    0.764495] pci 0000:00:08.0: reg 0x10: [mem 0x00000000-0x00000fff 64bit]
> [    0.764556] pci 0000:00:0a.0: [8086:a77d] type 00 class 0x118000
> [    0.764561] pci 0000:00:0a.0: reg 0x10: [mem 0x807c0000-0x807c7fff 64bit]
> [    0.764576] pci 0000:00:0a.0: enabling Extended Tags
> [    0.764637] pci 0000:00:0d.0: [8086:a71e] type 00 class 0x0c0330
> [    0.764645] pci 0000:00:0d.0: reg 0x10: [mem 0x807a0000-0x807affff 64bit]
> [    0.764681] pci 0000:00:0d.0: PME# supported from D3hot D3cold
> [    0.764733] pci 0000:00:0d.2: [8086:a73e] type 00 class 0x0c0340
> [    0.764741] pci 0000:00:0d.2: reg 0x10: [mem 0x80700000-0x8073ffff 64bit]
> [    0.764747] pci 0000:00:0d.2: reg 0x18: [mem 0x807d4000-0x807d4fff 64bit]
> [    0.764774] pci 0000:00:0d.2: supports D1 D2
> [    0.764774] pci 0000:00:0d.2: PME# supported from D0 D1 D2 D3hot D3cold
> [    0.764806] pci 0000:00:0d.3: [8086:a76d] type 00 class 0x0c0340
> [    0.764815] pci 0000:00:0d.3: reg 0x10: [mem 0x80740000-0x8077ffff 64bit]
> [    0.764820] pci 0000:00:0d.3: reg 0x18: [mem 0x807d5000-0x807d5fff 64bit]
> [    0.764847] pci 0000:00:0d.3: supports D1 D2
> [    0.764847] pci 0000:00:0d.3: PME# supported from D0 D1 D2 D3hot D3cold
> [    0.764923] pci 0000:00:14.0: [8086:51ed] type 00 class 0x0c0330
> [    0.764942] pci 0000:00:14.0: reg 0x10: [mem 0x807b0000-0x807bffff 64bit]
> [    0.765025] pci 0000:00:14.0: PME# supported from D3hot D3cold
> [    0.765087] pci 0000:00:14.2: [8086:51ef] type 00 class 0x050000
> [    0.765108] pci 0000:00:14.2: reg 0x10: [mem 0xfe010000-0xfe013fff 64bit]
> [    0.765123] pci 0000:00:14.2: reg 0x18: [mem 0x807d6000-0x807d6fff 64bit]
> [    0.765326] pci 0000:00:14.3: [8086:51f1] type 00 class 0x028000
> [    0.765349] pci 0000:00:14.3: reg 0x10: [mem 0x807cc000-0x807cffff 64bit]
> [    0.765503] pci 0000:00:14.3: PME# supported from D0 D3hot D3cold
> [    0.765679] pci 0000:00:15.0: [8086:51e8] type 00 class 0x0c8000
> [    0.765704] pci 0000:00:15.0: reg 0x10: [mem 0x807d7000-0x807d7fff 64bit]
> [    0.765841] pci 0000:00:15.1: [8086:51e9] type 00 class 0x0c8000
> [    0.765865] pci 0000:00:15.1: reg 0x10: [mem 0x807d8000-0x807d8fff 64bit]
> [    0.766001] pci 0000:00:15.2: [8086:51ea] type 00 class 0x0c8000
> [    0.766023] pci 0000:00:15.2: reg 0x10: [mem 0x807d9000-0x807d9fff 64bit]
> [    0.766160] pci 0000:00:15.3: [8086:51eb] type 00 class 0x0c8000
> [    0.766184] pci 0000:00:15.3: reg 0x10: [mem 0x807da000-0x807dafff 64bit]
> [    0.766339] pci 0000:00:16.0: [8086:51e0] type 00 class 0x078000
> [    0.766364] pci 0000:00:16.0: reg 0x10: [mem 0x807db000-0x807dbfff 64bit]
> [    0.766465] pci 0000:00:16.0: PME# supported from D3hot
> [    0.766547] pci 0000:00:19.0: [8086:51c5] type 00 class 0x0c8000
> [    0.766567] pci 0000:00:19.0: reg 0x10: [mem 0x00000000-0x00000fff 64bit]
> [    0.766690] pci 0000:00:19.1: [8086:51c6] type 00 class 0x0c8000
> [    0.766717] pci 0000:00:19.1: reg 0x10: [mem 0x807dc000-0x807dcfff 64bit]
> [    0.766886] pci 0000:00:1c.0: [8086:51bf] type 01 class 0x060400
> [    0.766991] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
> [    0.767125] pci 0000:00:1d.0: [8086:51b0] type 01 class 0x060400
> [    0.767221] pci 0000:00:1d.0: PME# supported from D0 D3hot D3cold
> [    0.767344] pci 0000:00:1e.0: [8086:51a8] type 00 class 0x078000
> [    0.767367] pci 0000:00:1e.0: reg 0x10: [mem 0xfe03e000-0xfe03efff 64bit]
> [    0.767514] pci 0000:00:1e.3: [8086:51ab] type 00 class 0x0c8000
> [    0.767542] pci 0000:00:1e.3: reg 0x10: [mem 0x807dd000-0x807ddfff 64bit]
> [    0.767682] pci 0000:00:1f.0: [8086:519d] type 00 class 0x060100
> [    0.767842] pci 0000:00:1f.3: [8086:51ca] type 00 class 0x040100
> [    0.767890] pci 0000:00:1f.3: reg 0x10: [mem 0x807d0000-0x807d3fff 64bit]
> [    0.767960] pci 0000:00:1f.3: reg 0x20: [mem 0x80600000-0x806fffff 64bit]
> [    0.768070] pci 0000:00:1f.3: PME# supported from D3hot D3cold
> [    0.768153] pci 0000:00:1f.5: [8086:51a4] type 00 class 0x0c8000
> [    0.768171] pci 0000:00:1f.5: reg 0x10: [mem 0xfe010000-0xfe010fff]
> [    0.768291] pci 0000:00:07.0: PCI bridge to [bus 01-2b]
> [    0.768293] pci 0000:00:07.0:   bridge window [io  0x2000-0x3fff]
> [    0.768295] pci 0000:00:07.0:   bridge window [mem 0x83000000-0x8f1fffff]
> [    0.768298] pci 0000:00:07.0:   bridge window [mem 0x87fc00000-0x89bbfffff 64bit pref]
> [    0.768322] pci 0000:00:07.1: PCI bridge to [bus 2c-56]
> [    0.768324] pci 0000:00:07.1:   bridge window [io  0x4000-0x5fff]
> [    0.768326] pci 0000:00:07.1:   bridge window [mem 0xa0000000-0xac1fffff]
> [    0.768329] pci 0000:00:07.1:   bridge window [mem 0x89bc00000-0x8b7bfffff 64bit pref]
> [    0.768352] pci 0000:00:07.2: PCI bridge to [bus 57-81]
> [    0.768354] pci 0000:00:07.2:   bridge window [io  0x6000-0x7fff]
> [    0.768356] pci 0000:00:07.2:   bridge window [mem 0xac200000-0xb83fffff]
> [    0.768359] pci 0000:00:07.2:   bridge window [mem 0x8b7c00000-0x8d3bfffff 64bit pref]
> [    0.772121] pci 0000:82:00.0: [17a0:9755] type 00 class 0x080501
> [    0.772152] pci 0000:82:00.0: reg 0x10: [mem 0x80400000-0x80400fff]
> [    0.772374] pci 0000:82:00.0: supports D1 D2
> [    0.772374] pci 0000:82:00.0: PME# supported from D1 D2 D3hot D3cold
> [    0.772890] pci 0000:00:1c.0: PCI bridge to [bus 82]
> [    0.772894] pci 0000:00:1c.0:   bridge window [mem 0x80400000-0x804fffff]
> [    0.772945] pci 0000:83:00.0: [1c5c:174a] type 00 class 0x010802
> [    0.772967] pci 0000:83:00.0: reg 0x10: [mem 0x80500000-0x80503fff 64bit]
> [    0.772977] pci 0000:83:00.0: reg 0x18: [mem 0x80504000-0x80504fff]
> [    0.772987] pci 0000:83:00.0: reg 0x1c: [mem 0x80505000-0x80505fff]
> [    0.773279] pci 0000:00:1d.0: PCI bridge to [bus 83]
> [    0.773283] pci 0000:00:1d.0:   bridge window [mem 0x80500000-0x805fffff]
> [    0.773314] pci_bus 0000:00: on NUMA node 0
> [    0.773788] Low-power S0 idle used by default for system suspend
> [    0.775149] ACPI: EC: interrupt unblocked
> [    0.775149] ACPI: EC: event unblocked
> [    0.775161] ACPI: EC: EC_CMD/EC_SC=0x66, EC_DATA=0x62
> [    0.775162] ACPI: EC: GPE=0x6e
> [    0.775162] ACPI: \_SB_.PCI0.LPCB.EC0_: Boot DSDT EC initialization complete
> [    0.775163] ACPI: \_SB_.PCI0.LPCB.EC0_: EC: Used to handle transactions and events
> [    0.775226] iommu: Default domain type: Translated
> [    0.775226] iommu: DMA domain TLB invalidation policy: lazy mode
> [    0.775226] SCSI subsystem initialized
> [    0.775226] libata version 3.00 loaded.
> [    0.775226] ACPI: bus type USB registered
> [    0.775226] usbcore: registered new interface driver usbfs
> [    0.775226] usbcore: registered new interface driver hub
> [    0.775226] usbcore: registered new device driver usb
> [    0.775226] mc: Linux media interface: v0.10
> [    0.775226] videodev: Linux video capture interface: v2.00
> [    0.775226] chromeos_acpi: registering CHSW 0
> [    0.775228] chromeos_acpi: registering VBNV 0
> [    0.775228] chromeos_acpi: registering VBNV 1
> [    0.775274] chromeos_acpi: truncating buffer from 3072 to 1336
> [    0.776119] chromeos_acpi: installed
> [    0.776128] Advanced Linux Sound Architecture Driver Initialized.
> [    0.776192] PCI: Using ACPI for IRQ routing
> [    0.790596] PCI: pci_cache_line_size set to 64 bytes
> [    0.790726] pci 0000:00:1f.5: can't claim BAR 0 [mem 0xfe010000-0xfe010fff]: address conflict with 0000:00:14.2 [mem 0xfe010000-0xfe013fff 64bit]
> [    0.790817] e820: reserve RAM buffer [mem 0x7685b000-0x77ffffff]
> [    0.790818] e820: reserve RAM buffer [mem 0x87fc00000-0x87fffffff]
> [    0.790820] clocksource: Switched to clocksource tsc-early
> [    0.790820] VFS: Disk quotas dquot_6.6.0
> [    0.790820] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
> [    0.790820] pnp: PnP ACPI init
> [    0.790820] pnp 00:00: disabling [mem 0xc0000000-0xcfffffff] because it overlaps 0000:00:02.0 BAR 9 [mem 0x00000000-0xdfffffff 64bit pref]
> [    0.790820] system 00:00: [mem 0xfedc0000-0xfeddffff] has been reserved
> [    0.790820] system 00:00: [mem 0xfeda0000-0xfeda0fff] has been reserved
> [    0.790820] system 00:00: [mem 0xfeda1000-0xfeda1fff] has been reserved
> [    0.790820] system 00:00: [mem 0xfed90000-0xfed93fff] could not be reserved
> [    0.790820] system 00:00: [mem 0xfe000000-0xffffffff] could not be reserved
> [    0.790820] system 00:00: [mem 0xf8000000-0xf9ffffff] has been reserved
> [    0.790820] system 00:00: [mem 0xfee00000-0xfeefffff] has been reserved
> [    0.790820] system 00:00: [mem 0xfed00000-0xfed003ff] has been reserved
> [    0.790820] system 00:01: [mem 0xfed00000-0xfed003ff] has been reserved
> [    0.790820] system 00:02: [io  0x1800-0x18fe] has been reserved
> [    0.790820] system 00:04: [io  0x0900-0x09fe] has been reserved
> [    0.790820] system 00:05: [io  0x0200] has been reserved
> [    0.790820] system 00:05: [io  0x0204] has been reserved
> [    0.790820] system 00:05: [io  0x0800-0x087f] has been reserved
> [    0.790820] system 00:05: [io  0x0880-0x08ff] has been reserved
> [    0.791055] pnp: PnP ACPI: found 7 devices
> [    0.795701] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
> [    0.795740] NET: Registered PF_INET protocol family
> [    0.795954] IP idents hash table entries: 262144 (order: 9, 2097152 bytes, linear)
> [    0.797282] tcp_listen_portaddr_hash hash table entries: 16384 (order: 6, 262144 bytes, linear)
> [    0.797307] Table-perturb hash table entries: 65536 (order: 6, 262144 bytes, linear)
> [    0.797329] TCP established hash table entries: 262144 (order: 9, 2097152 bytes, linear)
> [    0.797491] TCP bind hash table entries: 65536 (order: 9, 2097152 bytes, linear)
> [    0.797636] TCP: Hash tables configured (established 262144 bind 65536)
> [    0.797660] UDP hash table entries: 16384 (order: 7, 524288 bytes, linear)
> [    0.797702] UDP-Lite hash table entries: 16384 (order: 7, 524288 bytes, linear)
> [    0.797762] NET: Registered PF_UNIX/PF_LOCAL protocol family
> [    0.797769] pci 0000:00:1c.0: bridge window [io  0x1000-0x0fff] to [bus 82] add_size 1000
> [    0.797771] pci 0000:00:1c.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 82] add_size 200000 add_align 100000
> [    0.797776] pci 0000:00:02.0: BAR 9: assigned [mem 0x8e0000000-0x9bfffffff 64bit pref]
> [    0.797778] pci 0000:00:02.0: BAR 7: assigned [mem 0x8d4000000-0x8daffffff 64bit]
> [    0.797780] pci 0000:00:1c.0: BAR 15: assigned [mem 0x8d3c00000-0x8d3dfffff 64bit pref]
> [    0.797781] pci 0000:00:08.0: BAR 0: assigned [mem 0x8d3e00000-0x8d3e00fff 64bit]
> [    0.797784] pci 0000:00:19.0: BAR 0: assigned [mem 0x8d3e01000-0x8d3e01fff 64bit]
> [    0.797797] pci 0000:00:1c.0: BAR 13: assigned [io  0x8000-0x8fff]
> [    0.797798] pci 0000:00:1f.5: BAR 0: assigned [mem 0x807c8000-0x807c8fff]
> [    0.797809] pci 0000:00:07.0: PCI bridge to [bus 01-2b]
> [    0.797810] pci 0000:00:07.0:   bridge window [io  0x2000-0x3fff]
> [    0.797813] pci 0000:00:07.0:   bridge window [mem 0x83000000-0x8f1fffff]
> [    0.797814] pci 0000:00:07.0:   bridge window [mem 0x87fc00000-0x89bbfffff 64bit pref]
> [    0.797818] pci 0000:00:07.1: PCI bridge to [bus 2c-56]
> [    0.797819] pci 0000:00:07.1:   bridge window [io  0x4000-0x5fff]
> [    0.797821] pci 0000:00:07.1:   bridge window [mem 0xa0000000-0xac1fffff]
> [    0.797823] pci 0000:00:07.1:   bridge window [mem 0x89bc00000-0x8b7bfffff 64bit pref]
> [    0.797826] pci 0000:00:07.2: PCI bridge to [bus 57-81]
> [    0.797827] pci 0000:00:07.2:   bridge window [io  0x6000-0x7fff]
> [    0.797829] pci 0000:00:07.2:   bridge window [mem 0xac200000-0xb83fffff]
> [    0.797831] pci 0000:00:07.2:   bridge window [mem 0x8b7c00000-0x8d3bfffff 64bit pref]
> [    0.797835] pci 0000:00:1c.0: PCI bridge to [bus 82]
> [    0.797842] pci 0000:00:1c.0:   bridge window [io  0x8000-0x8fff]
> [    0.797846] pci 0000:00:1c.0:   bridge window [mem 0x80400000-0x804fffff]
> [    0.797848] pci 0000:00:1c.0:   bridge window [mem 0x8d3c00000-0x8d3dfffff 64bit pref]
> [    0.797853] pci 0000:00:1d.0: PCI bridge to [bus 83]
> [    0.797856] pci 0000:00:1d.0:   bridge window [mem 0x80500000-0x805fffff]
> [    0.797862] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
> [    0.797863] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
> [    0.797864] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000fffff window]
> [    0.797864] pci_bus 0000:00: resource 7 [mem 0x80400000-0xdfffffff window]
> [    0.797865] pci_bus 0000:00: resource 8 [mem 0x87fc00000-0x3fffffffffff window]
> [    0.797865] pci_bus 0000:00: resource 9 [mem 0xfc800000-0xfe7fffff window]
> [    0.797866] pci_bus 0000:00: resource 10 [mem 0xfed40000-0xfed47fff window]
> [    0.797866] pci_bus 0000:01: resource 0 [io  0x2000-0x3fff]
> [    0.797867] pci_bus 0000:01: resource 1 [mem 0x83000000-0x8f1fffff]
> [    0.797867] pci_bus 0000:01: resource 2 [mem 0x87fc00000-0x89bbfffff 64bit pref]
> [    0.797868] pci_bus 0000:2c: resource 0 [io  0x4000-0x5fff]
> [    0.797868] pci_bus 0000:2c: resource 1 [mem 0xa0000000-0xac1fffff]
> [    0.797868] pci_bus 0000:2c: resource 2 [mem 0x89bc00000-0x8b7bfffff 64bit pref]
> [    0.797869] pci_bus 0000:57: resource 0 [io  0x6000-0x7fff]
> [    0.797869] pci_bus 0000:57: resource 1 [mem 0xac200000-0xb83fffff]
> [    0.797870] pci_bus 0000:57: resource 2 [mem 0x8b7c00000-0x8d3bfffff 64bit pref]
> [    0.797870] pci_bus 0000:82: resource 0 [io  0x8000-0x8fff]
> [    0.797870] pci_bus 0000:82: resource 1 [mem 0x80400000-0x804fffff]
> [    0.797871] pci_bus 0000:82: resource 2 [mem 0x8d3c00000-0x8d3dfffff 64bit pref]
> [    0.797871] pci_bus 0000:83: resource 1 [mem 0x80500000-0x805fffff]
> [    0.798227] PCI: CLS 64 bytes, default 64
> [    0.798237] DMAR: No ATSR found
> [    0.798237] DMAR: No SATC found
> [    0.798238] DMAR: IOMMU feature fl1gp_support inconsistent
> [    0.798239] DMAR: IOMMU feature pgsel_inv inconsistent
> [    0.798239] DMAR: IOMMU feature nwfs inconsistent
> [    0.798240] DMAR: IOMMU feature dit inconsistent
> [    0.798240] DMAR: IOMMU feature sc_support inconsistent
> [    0.798240] DMAR: IOMMU feature dev_iotlb_support inconsistent
> [    0.798241] DMAR: dmar1: Using Queued invalidation
> [    0.798243] DMAR: dmar0: Using Queued invalidation
> [    0.798244] DMAR: dmar2: Using Queued invalidation
> [    0.798374] pci 0000:00:05.0: Adding to iommu group 0
> [    0.798389] pci 0000:00:02.0: Adding to iommu group 1
> [    0.798615] pci 0000:00:00.0: Adding to iommu group 2
> [    0.798619] pci 0000:00:04.0: Adding to iommu group 3
> [    0.798625] pci 0000:00:07.0: Adding to iommu group 4
> [    0.798630] pci 0000:00:07.1: Adding to iommu group 5
> [    0.798635] pci 0000:00:07.2: Adding to iommu group 6
> [    0.798639] pci 0000:00:08.0: Adding to iommu group 7
> [    0.798642] pci 0000:00:0a.0: Adding to iommu group 8
> [    0.798651] pci 0000:00:0d.0: Adding to iommu group 9
> [    0.798655] pci 0000:00:0d.2: Adding to iommu group 9
> [    0.798660] pci 0000:00:0d.3: Adding to iommu group 9
> [    0.798667] pci 0000:00:14.0: Adding to iommu group 10
> [    0.798671] pci 0000:00:14.2: Adding to iommu group 10
> [    0.798675] pci 0000:00:14.3: Adding to iommu group 11
> [    0.798686] pci 0000:00:15.0: Adding to iommu group 12
> [    0.798690] pci 0000:00:15.1: Adding to iommu group 12
> [    0.798695] pci 0000:00:15.2: Adding to iommu group 12
> [    0.798699] pci 0000:00:15.3: Adding to iommu group 12
> [    0.798705] pci 0000:00:16.0: Adding to iommu group 13
> [    0.798712] pci 0000:00:19.0: Adding to iommu group 14
> [    0.798716] pci 0000:00:19.1: Adding to iommu group 14
> [    0.798727] pci 0000:00:1c.0: Adding to iommu group 15
> [    0.798734] pci 0000:00:1d.0: Adding to iommu group 16
> [    0.798741] pci 0000:00:1e.0: Adding to iommu group 17
> [    0.798746] pci 0000:00:1e.3: Adding to iommu group 17
> [    0.798755] pci 0000:00:1f.0: Adding to iommu group 18
> [    0.798760] pci 0000:00:1f.3: Adding to iommu group 18
> [    0.798764] pci 0000:00:1f.5: Adding to iommu group 18
> [    0.798776] pci 0000:82:00.0: Adding to iommu group 19
> [    0.798781] pci 0000:83:00.0: Adding to iommu group 20
> [    0.799714] DMAR: Intel(R) Virtualization Technology for Directed I/O
> [    0.799714] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
> [    0.799715] software IO TLB: mapped [mem 0x000000006e85b000-0x000000007685b000] (128MB)
> [    0.799718] ACPI: bus type thunderbolt registered
> [    0.799726] pci 0000:00:0d.2: attach allowed to drvr thunderbolt [internal device]
> [    0.852477] pci 0000:00:0d.3: attach allowed to drvr thunderbolt [internal device]
> [    0.909476] RAPL PMU: API unit is 2^-32 Joules, 3 fixed counters, 655360 ms ovfl timer
> [    0.909477] RAPL PMU: hw unit of domain pp0-core 2^-14 Joules
> [    0.909478] RAPL PMU: hw unit of domain package 2^-14 Joules
> [    0.909478] RAPL PMU: hw unit of domain psys 2^-14 Joules
> [    0.912263] kvm: already loaded vendor module 'kvm_intel'
> [    0.912265] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x26bef67878b, max_idle_ns: 440795293631 ns
> [    0.912279] clocksource: Switched to clocksource tsc
> [    0.912961] Initialise system trusted keyrings
> [    0.912993] workingset: timestamp_bits=62 max_order=23 bucket_order=0
> [    0.913493] squashfs: version 4.0 (2009/01/31) Phillip Lougher
> [    0.913517] Registering esdfs 0.2
> [    0.913537] alt_syscall: table 'read_write_test' available.
> [    0.913542] alt_syscall: table 'android' available.
> [    0.913547] alt_syscall: table 'android_permissive' available.
> [    0.913551] alt_syscall: table 'third_party' available.
> [    0.913554] alt_syscall: table 'third_party_permissive' available.
> [    0.913558] alt_syscall: table 'complete' available.
> [    0.913561] alt_syscall: table 'complete_permissive' available.
> [    0.915253] Key type asymmetric registered
> [    0.915254] Asymmetric key parser 'x509' registered
> [    0.915259] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 247)
> [    0.915261] io scheduler mq-deadline registered
> [    0.915261] io scheduler kyber registered
> [    0.915273] io scheduler bfq registered
> [    0.915754] gpiochip_find_base: found new base at 664
> [    0.917106] gpio gpiochip0: (INTC1055:00): created GPIO range 0->25 ==> INTC1055:00 PIN 0->25
> [    0.917108] gpio gpiochip0: (INTC1055:00): created GPIO range 32->47 ==> INTC1055:00 PIN 26->41
> [    0.917109] gpio gpiochip0: (INTC1055:00): created GPIO range 64->88 ==> INTC1055:00 PIN 42->66
> [    0.917110] gpio gpiochip0: (INTC1055:00): created GPIO range 96->103 ==> INTC1055:00 PIN 67->74
> [    0.917111] gpio gpiochip0: (INTC1055:00): created GPIO range 128->151 ==> INTC1055:00 PIN 75->98
> [    0.917112] gpio gpiochip0: (INTC1055:00): created GPIO range 160->180 ==> INTC1055:00 PIN 99->119
> [    0.917113] gpio gpiochip0: (INTC1055:00): created GPIO range 192->215 ==> INTC1055:00 PIN 120->143
> [    0.917114] gpio gpiochip0: (INTC1055:00): created GPIO range 224->250 ==> INTC1055:00 PIN 144->170
> [    0.917115] gpio gpiochip0: (INTC1055:00): created GPIO range 256->279 ==> INTC1055:00 PIN 171->194
> [    0.917116] gpio gpiochip0: (INTC1055:00): created GPIO range 288->312 ==> INTC1055:00 PIN 195->219
> [    0.917117] gpio gpiochip0: (INTC1055:00): created GPIO range 320->344 ==> INTC1055:00 PIN 226->250
> [    0.917117] gpio gpiochip0: (INTC1055:00): created GPIO range 352->359 ==> INTC1055:00 PIN 260->267
> [    0.917166] gpio gpiochip0: (INTC1055:00): added GPIO chardev (254:0)
> [    0.917177] gpio gpiochip0: registered GPIOs 664 to 1023 on INTC1055:00
> [    0.917198] pci 0000:00:07.0: attach allowed to drvr pcieport [internal device]
> [    0.917395] pcieport 0000:00:07.0: PME: Signaling with IRQ 155
> [    0.917429] pcieport 0000:00:07.0: AER: enabled with IRQ 155
> [    0.917446] pcieport 0000:00:07.0: pciehp: Slot #3 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+
> [    0.917521] pci 0000:00:07.1: attach allowed to drvr pcieport [internal device]
> [    0.917679] pcieport 0000:00:07.1: PME: Signaling with IRQ 156
> [    0.917710] pcieport 0000:00:07.1: AER: enabled with IRQ 156
> [    0.917723] pcieport 0000:00:07.1: pciehp: Slot #4 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+
> [    0.917787] pci 0000:00:07.2: attach allowed to drvr pcieport [internal device]
> [    0.917945] pcieport 0000:00:07.2: PME: Signaling with IRQ 157
> [    0.917994] pcieport 0000:00:07.2: AER: enabled with IRQ 157
> [    0.918006] pcieport 0000:00:07.2: pciehp: Slot #5 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+
> [    0.918074] pci 0000:00:1c.0: attach allowed to drvr pcieport [internal device]
> [    0.918088] pcieport 0000:00:1c.0: enabling device (0106 -> 0107)
> [    0.918272] pcieport 0000:00:1c.0: PME: Signaling with IRQ 158
> [    0.918325] pcieport 0000:00:1c.0: AER: enabled with IRQ 158
> [    0.918346] pcieport 0000:00:1c.0: pciehp: Slot #7 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+
> [    0.918476] pci 0000:00:1d.0: attach allowed to drvr pcieport [internal device]
> [    0.918650] pcieport 0000:00:1d.0: PME: Signaling with IRQ 159
> [    0.918698] pcieport 0000:00:1d.0: AER: enabled with IRQ 159
> [    0.918781] Monitor-Mwait will be used to enter C-1 state
> [    0.918785] Monitor-Mwait will be used to enter C-2 state
> [    0.918789] Monitor-Mwait will be used to enter C-3 state
> [    0.918791] ACPI: \_SB_.CP00: Found 3 idle states
> [    0.919108] ACPI: AC: AC Adapter [AC] (on-line)
> [    0.919158] input: Lid Switch as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/device:02/PNP0C09:00/PNP0C0D:00/input/input0
> [    0.919247] ACPI: button: Lid Switch [LID0]
> [    0.919274] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input1
> [    0.919333] ACPI: button: Power Button [PWRF]
> [    0.920123] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
> [    0.920499] hpet_acpi_add: no address or irqs in _CRS
> [    0.920519] ACPI: battery: Slot [BAT0] (battery present)
> [    0.920524] Non-volatile memory driver v1.3
> [    0.928419] ACPI: bus type drm_connector registered
> [    0.928514] pci 0000:00:02.0: attach allowed to drvr i915 [internal device]
> [    0.929094] i915 0000:00:02.0: [drm] VT-d active for gfx access
> [    0.929143] i915 0000:00:02.0: [drm] Using Transparent Hugepages
> [    0.980578] i915 0000:00:02.0: Direct firmware load for i915/adlp_dmc.bin failed with error -2
> [    0.980587] i915 0000:00:02.0: Direct firmware load for i915/adlp_dmc_ver2_16.bin failed with error -2
> [    0.980588] i915 0000:00:02.0: [drm] Failed to load DMC firmware i915/adlp_dmc.bin. Disabling runtime power management.
> [    0.980589] i915 0000:00:02.0: [drm] DMC firmware homepage:https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/tree/i915
> [    0.991524] i915 0000:00:02.0: [drm] GuC firmware i915/adlp_guc_70.bin (70.5) is recommended, but only i915/adlp_guc_69.0.3.bin (69.0) was found
> [    0.991528] i915 0000:00:02.0: [drm] Consider updating your linux-firmware pkg or downloading fromhttps://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/tree/i915
> [    0.991634] i915 0000:00:02.0: [drm] HuC firmware i915/tgl_huc.bin (0.0) is recommended, but only i915/tgl_huc_7.9.3.bin (7.9) was found
> [    0.991635] i915 0000:00:02.0: [drm] Consider updating your linux-firmware pkg or downloading fromhttps://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/tree/i915
> [    0.996114] i915 0000:00:02.0: [drm] GuC firmware i915/adlp_guc_69.0.3.bin version 69.0.3
> [    0.996118] i915 0000:00:02.0: [drm] HuC firmware i915/tgl_huc_7.9.3.bin version 7.9.3
> [    1.013102] i915 0000:00:02.0: [drm] HuC authenticated
> [    1.013675] i915 0000:00:02.0: [drm] GuC submission enabled
> [    1.013676] i915 0000:00:02.0: [drm] GuC SLPC enabled
> [    1.014174] i915 0000:00:02.0: [drm] GuC RC: enabled
> [    1.014874] i915 0000:00:02.0: [drm] Protected Xe Path (PXP) protected content support initialized
> [    2.137297] [drm] Initialized i915 1.6.0 20201103 for 0000:00:02.0 on minor 0
> [    2.137528] usbcore: registered new interface driver udl
> [    2.139589] loop: module loaded
> [    2.139628] lkdtm: No crash points registered, enable through debugfs
> [    2.139647] pci 0000:00:16.0: attach allowed to drvr mei_me [internal device]
> [    2.139713] pci 0000:00:15.0: attach allowed to drvr intel-lpss [internal device]
> [    2.140055] idma64 idma64.0: Found Intel integrated DMA 64-bit
> [    2.141566] i2c_designware i2c_designware.0: GPIO lookup for consumer scl
> [    2.141568] i2c_designware i2c_designware.0: using ACPI for GPIO lookup
> [    2.141570] acpi device:17: GPIO: looking up scl-gpios
> [    2.141571] acpi device:17: GPIO: looking up scl-gpio
> [    2.141572] i2c_designware i2c_designware.0: using lookup tables for GPIO lookup
> [    2.141573] i2c_designware i2c_designware.0: No GPIO consumer scl found
> [    2.141903] pci 0000:00:15.1: attach allowed to drvr intel-lpss [internal device]
> [    2.142108] idma64 idma64.1: Found Intel integrated DMA 64-bit
> [    2.143623] i2c_designware i2c_designware.1: GPIO lookup for consumer scl
> [    2.143626] i2c_designware i2c_designware.1: using ACPI for GPIO lookup
> [    2.143627] acpi device:18: GPIO: looking up scl-gpios
> [    2.143629] acpi device:18: GPIO: looking up scl-gpio
> [    2.143630] i2c_designware i2c_designware.1: using lookup tables for GPIO lookup
> [    2.143631] i2c_designware i2c_designware.1: No GPIO consumer scl found
> [    2.145538] cr50_i2c i2c-GOOG0005:00: cr50 TPM 2.0 (i2c 0x50 irq 77 id 0x28)
> [    2.145809] mei_pxp 0000:00:16.0-fbf6fcf1-96cf-4e2e-a6a6-1bab8cbe36b1: bound 0000:00:02.0 (ops 0xffffffff86305760)
> [    2.239753] pci 0000:00:15.2: attach allowed to drvr intel-lpss [internal device]
> [    2.240078] idma64 idma64.2: Found Intel integrated DMA 64-bit
> [    2.241878] i2c_designware i2c_designware.2: GPIO lookup for consumer scl
> [    2.241879] i2c_designware i2c_designware.2: using ACPI for GPIO lookup
> [    2.241881] acpi device:19: GPIO: looking up scl-gpios
> [    2.241882] acpi device:19: GPIO: looking up scl-gpio
> [    2.241883] i2c_designware i2c_designware.2: using lookup tables for GPIO lookup
> [    2.241884] i2c_designware i2c_designware.2: No GPIO consumer scl found
> [    2.242146] pci 0000:00:15.3: attach allowed to drvr intel-lpss [internal device]
> [    2.242344] idma64 idma64.3: Found Intel integrated DMA 64-bit
> [    2.243801] i2c_designware i2c_designware.3: GPIO lookup for consumer scl
> [    2.243803] i2c_designware i2c_designware.3: using ACPI for GPIO lookup
> [    2.243804] acpi device:1a: GPIO: looking up scl-gpios
> [    2.243804] acpi device:1a: GPIO: looking up scl-gpio
> [    2.243805] i2c_designware i2c_designware.3: using lookup tables for GPIO lookup
> [    2.243806] i2c_designware i2c_designware.3: No GPIO consumer scl found
> [    2.244349] pci 0000:00:19.0: attach allowed to drvr intel-lpss [internal device]
> [    2.256143] intel-lpss 0000:00:19.0: enabling device (0000 -> 0002)
> [    2.256348] idma64 idma64.4: Found Intel integrated DMA 64-bit
> [    2.257736] i2c_designware i2c_designware.4: GPIO lookup for consumer scl
> [    2.257737] i2c_designware i2c_designware.4: using ACPI for GPIO lookup
> [    2.257738] acpi device:1b: GPIO: looking up scl-gpios
> [    2.257739] acpi device:1b: GPIO: looking up scl-gpio
> [    2.257740] i2c_designware i2c_designware.4: using lookup tables for GPIO lookup
> [    2.257740] i2c_designware i2c_designware.4: No GPIO consumer scl found
> [    2.257934] pci 0000:00:19.1: attach allowed to drvr intel-lpss [internal device]
> [    2.258139] idma64 idma64.5: Found Intel integrated DMA 64-bit
> [    2.259541] i2c_designware i2c_designware.5: GPIO lookup for consumer scl
> [    2.259542] i2c_designware i2c_designware.5: using ACPI for GPIO lookup
> [    2.259544] acpi device:1c: GPIO: looking up scl-gpios
> [    2.259544] acpi device:1c: GPIO: looking up scl-gpio
> [    2.259545] i2c_designware i2c_designware.5: using lookup tables for GPIO lookup
> [    2.259546] i2c_designware i2c_designware.5: No GPIO consumer scl found
> [    2.259756] pci 0000:00:1e.0: attach allowed to drvr intel-lpss [internal device]
> [    2.259972] idma64 idma64.6: Found Intel integrated DMA 64-bit
> [    2.260248] dw-apb-uart dw-apb-uart.6: GPIO lookup for consumer rs485-term
> [    2.260250] dw-apb-uart dw-apb-uart.6: using ACPI for GPIO lookup
> [    2.260252] acpi device:23: GPIO: looking up rs485-term-gpios
> [    2.260252] acpi device:23: GPIO: looking up rs485-term-gpio
> [    2.260253] dw-apb-uart dw-apb-uart.6: using lookup tables for GPIO lookup
> [    2.260254] dw-apb-uart dw-apb-uart.6: No GPIO consumer rs485-term found
> [    2.260258] dw-apb-uart.6: ttyS0 at MMIO 0xfe03e000 (irq = 23, base_baud = 114825) is a 16550A
> [    2.260453] pci 0000:00:1e.3: attach allowed to drvr intel-lpss [internal device]
> [    2.272499] idma64 idma64.7: Found Intel integrated DMA 64-bit
> [    2.274962] pci 0000:83:00.0: attach allowed to drvr nvme [internal device]
> [    2.275085] nvme nvme0: pci function 0000:83:00.0
> [    2.275209] mdio_bus fixed-0: GPIO lookup for consumer reset
> [    2.275210] mdio_bus fixed-0: using lookup tables for GPIO lookup
> [    2.275211] mdio_bus fixed-0: No GPIO consumer reset found
> [    2.275212] PPP generic driver version 2.4.2
> [    2.275427] PPP MPPE Compression module registered
> [    2.275470] pci 0000:00:0d.0: attach allowed to drvr xhci_hcd [internal device]
> [    2.275496] xhci_hcd 0000:00:0d.0: xHCI Host Controller
> [    2.275512] xhci_hcd 0000:00:0d.0: new USB bus registered, assigned bus number 1
> [    2.276610] xhci_hcd 0000:00:0d.0: hcc params 0x20007fc1 hci version 0x120 quirks 0x0000000200009810
> [    2.276731] xhci_hcd 0000:00:0d.0: xHCI Host Controller
> [    2.276845] xhci_hcd 0000:00:0d.0: new USB bus registered, assigned bus number 2
> [    2.276846] xhci_hcd 0000:00:0d.0: Host supports USB 3.2 Enhanced SuperSpeed
> [    2.276869] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 6.01
> [    2.276870] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [    2.276871] usb usb1: Product: xHCI Host Controller
> [    2.276872] usb usb1: Manufacturer: Linux 6.1.15-01642-g2f18a077d91a xhci-hcd
> [    2.276873] usb usb1: SerialNumber: 0000:00:0d.0
> [    2.276930] hub 1-0:1.0: USB hub found
> [    2.276936] hub 1-0:1.0: 1 port detected
> [    2.276993] usb usb2: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 6.01
> [    2.276995] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [    2.276995] usb usb2: Product: xHCI Host Controller
> [    2.276996] usb usb2: Manufacturer: Linux 6.1.15-01642-g2f18a077d91a xhci-hcd
> [    2.276996] usb usb2: SerialNumber: 0000:00:0d.0
> [    2.277035] hub 2-0:1.0: USB hub found
> [    2.277042] hub 2-0:1.0: 3 ports detected
> [    2.277142] pci 0000:00:14.0: attach allowed to drvr xhci_hcd [internal device]
> [    2.277274] xhci_hcd 0000:00:14.0: xHCI Host Controller
> [    2.277331] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 3
> [    2.278475] xhci_hcd 0000:00:14.0: hcc params 0x20007fc1 hci version 0x120 quirks 0x0000100200009810
> [    2.278668] xhci_hcd 0000:00:14.0: xHCI Host Controller
> [    2.278776] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 4
> [    2.278778] xhci_hcd 0000:00:14.0: Host supports USB 3.1 Enhanced SuperSpeed
> [    2.278800] usb usb3: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 6.01
> [    2.278802] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [    2.278802] usb usb3: Product: xHCI Host Controller
> [    2.278803] usb usb3: Manufacturer: Linux 6.1.15-01642-g2f18a077d91a xhci-hcd
> [    2.278803] usb usb3: SerialNumber: 0000:00:14.0
> [    2.278853] hub 3-0:1.0: USB hub found
> [    2.278871] hub 3-0:1.0: 12 ports detected
> [    2.279113] usb usb4: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 6.01
> [    2.279114] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [    2.279115] usb usb4: Product: xHCI Host Controller
> [    2.279115] usb usb4: Manufacturer: Linux 6.1.15-01642-g2f18a077d91a xhci-hcd
> [    2.279116] usb usb4: SerialNumber: 0000:00:14.0
> [    2.279239] hub 4-0:1.0: USB hub found
> [    2.279251] hub 4-0:1.0: 4 ports detected
> [    2.279355] usbcore: registered new interface driver cdc_acm
> [    2.279356] cdc_acm: USB Abstract Control Model driver for USB modems and ISDN adapters
> [    2.279499] usbcore: registered new interface driver uas
> [    2.279512] usbcore: registered new interface driver usb-storage
> [    2.279529] usbcore: registered new interface driver ums-realtek
> [    2.279550] i8042: PNP: PS/2 Controller [PNP0303:PS2K] at 0x60,0x64 irq 1
> [    2.279551] i8042: PNP: PS/2 appears to have AUX port disabled, if this is incorrect please boot with i8042.nopnp
> [    2.280691] i8042: Warning: Keylock active
> [    2.280880] serio: i8042 KBD port at 0x60,0x64 irq 1
> [    2.282282] rtc_cmos 00:03: RTC can wake from S4
> [    2.283140] rtc_cmos 00:03: registered as rtc0
> [    2.283141] rtc_cmos 00:03: GPIO lookup for consumer wp
> [    2.283142] rtc_cmos 00:03: using ACPI for GPIO lookup
> [    2.283143] acpi PNP0B00:00: GPIO: looking up wp-gpios
> [    2.283147] acpi PNP0B00:00: GPIO: looking up wp-gpio
> [    2.283148] rtc_cmos 00:03: using lookup tables for GPIO lookup
> [    2.283148] rtc_cmos 00:03: No GPIO consumer wp found
> [    2.283168] rtc_cmos 00:03: alarms up to one month, y3k, 242 bytes nvram
> [    2.283177] i2c_dev: i2c /dev entries driver
> [    2.284619] Consider using thermal netlink events interface
> [    2.285306] pci 0000:00:04.0: attach allowed to drvr proc_thermal_pci [internal device]
> [    2.285662] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input2
> [    2.285979] intel_rapl_common: Found RAPL domain package
> [    2.287073] iTCO_vendor_support: vendor-support=0
> [    2.287218] device-mapper: ioctl: 4.47.0-ioctl (2022-07-28) initialised:dm-devel@redhat.com
> [    2.287302] device-mapper: verity-chromeos: dm-verity-chromeos registered
> [    2.287304] intel_pstate: Intel P-state driver initializing
> [    2.288211] intel_pstate: HWP enabled
> [    2.288219] sdhci: Secure Digital Host Controller Interface driver
> [    2.288219] sdhci: Copyright(c) Pierre Ossman
> [    2.288229] pci 0000:82:00.0: attach allowed to drvr sdhci-pci [internal device]
> [    2.288256] sdhci-pci 0000:82:00.0: SDHCI controller found [17a0:9755] (rev 0)
> [    2.288494] Registered efivars operations
> [    2.288496] gsmi version 1.0 loaded
> [    2.288548] pcieport 0000:00:1c.0: AER: Corrected error received: 0000:82:00.0
> [    2.288792] hid: raw HID events driver (C) Jiri Kosina
> [    2.288828] sdhci-pci 0000:82:00.0: PCIe Bus Error: severity=Corrected, type=Data Link Layer, (Transmitter ID)
> [    2.288831] sdhci-pci 0000:82:00.0:   device [17a0:9755] error status/mask=00001000/00002000
> [    2.288834] sdhci-pci 0000:82:00.0:    [12] Timeout
> [    2.288950] usbcore: registered new interface driver usbhid
> [    2.288951] usbhid: USB HID core driver
> [    2.292344] intel_pmc_core INT33A1:00:  initialized
> [    2.292357] pcieport 0000:00:1c.0: AER: Corrected error received: 0000:82:00.0
> [    2.292377] intel_telemetry_core Init
> [    2.292383] pci 0000:00:0a.0: attach allowed to drvr intel_vsec [internal device]
> [    2.292734] acpi INTC1026:00: GPIO: looking up 0 in _CRS
> [    2.292775] chromeos ramoops using acpi device.
> [    2.293356] printk: console [ramoops-1] enabled
> [    2.293417] pstore: Registered ramoops as persistent store backend
> [    2.293419] ramoops: using 0x100000@0x7689d000, ecc: 0
> [    2.294548] spi_master spi0: will run message pump with realtime priority
> [    2.294551] pcieport 0000:00:1c.0: AER: Corrected error received: 0000:82:00.0
> [    2.294618] elan_i2c i2c-ELAN0000:00: supply vcc not found, using dummy regulator
> [    2.298446] pcieport 0000:00:1c.0: AER: Corrected error received: 0000:00:1c.0
> [    2.298462] pcieport 0000:00:1c.0: PCIe Bus Error: severity=Corrected, type=Data Link Layer, (Transmitter ID)
> [    2.298465] pcieport 0000:00:1c.0:   device [8086:51bf] error status/mask=00001000/00002000
> [    2.298469] pcieport 0000:00:1c.0:    [12] Timeout
> [    2.298491] mmc0: SDHCI controller on PCI [0000:82:00.0] using ADMA 64-bit
> [    2.299425] cros-ec-dev cros-ec-dev.5.auto: CrOS Fingerprint MCU detected
> [    2.301162] cros_ec_lpcs GOOG0004:00: Chrome EC device registered
> [    2.302576] pcieport 0000:00:1c.0: AER: Corrected error received: 0000:82:00.0
> [    2.303690] intel_rapl_msr: PL4 support detected.
> [    2.303703] intel_rapl_common: Found RAPL domain package
> [    2.303706] intel_rapl_common: Found RAPL domain core
> [    2.303707] intel_rapl_common: Found RAPL domain uncore
> [    2.303709] intel_rapl_common: Found RAPL domain psys
> [    2.303720] cros-ec-spi spi-PRP0001:02: Chrome EC device registered
> [    2.304388] nvme nvme0: 12/0/0 default/read/poll queues
> [    2.306040] sdhci-pci 0000:82:00.0: PCIe Bus Error: severity=Corrected, type=Data Link Layer, (Transmitter ID)
> [    2.306043] sdhci-pci 0000:82:00.0:   device [17a0:9755] error status/mask=00001000/00002000
> [    2.306045] sdhci-pci 0000:82:00.0:    [12] Timeout
> [    2.309533] pcieport 0000:00:1c.0: AER: Corrected error received: 0000:00:1c.0
> [    2.309539] pcieport 0000:00:1c.0: PCIe Bus Error: severity=Corrected, type=Data Link Layer, (Transmitter ID)
> [    2.309541] pcieport 0000:00:1c.0:   device [8086:51bf] error status/mask=00001000/00002000
> [    2.309544] pcieport 0000:00:1c.0:    [12] Timeout
> [    2.309570] nvme nvme0: Ignoring bogus Namespace Identifiers
> [    2.310047] GACT probability NOT on
> [    2.310780] xt_time: kernel timezone is -0000
> [    2.310819] Initializing XFRM netlink socket
> [    2.310866] NET: Registered PF_INET6 protocol family
> [    2.310995] Segment Routing with IPv6
> [    2.311007] In-situ OAM (IOAM) with IPv6
> [    2.311026] NET: Registered PF_PACKET protocol family
> [    2.311029] NET: Registered PF_KEY protocol family
> [    2.311409]  nvme0n1: p1 p2 p3 p4 p5 p6 p7 p8 p9 p10 p11 p12
> [    2.311957] microcode: sig=0xb06a3, pf=0x80, revision=0x4111
> [    2.312226] microcode: Microcode Update Driver: v2.2.
> [    2.312229] IPI shorthand broadcast: enabled
> [    2.312234] AVX2 version of gcm_enc/dec engaged.
> [    2.312709] AES CTR mode by8 optimization enabled
> [    2.312865] sched_clock: Marking stable (2306466206, 6387792)->(2328460951, -15606953)
> [    2.313045] registered taskstats version 1
> [    2.313050] Loading compiled-in X.509 certificates
> [    2.313067] Key type .fscrypt registered
> [    2.313068] Key type fscrypt-provisioning registered
> [    2.313146] pstore: Using crash dump compression: deflate
> [    2.313284] Key type encrypted registered
> [    2.340172] input: cros_ec_buttons as /devices/pci0000:00/0000:00:1f.0/PNP0C09:00/GOOG0004:00/GOOG0007:00/input/input3
> [    2.340647] PM:   Magic number: 15:818:935
> [    2.340812] i2c i2c-PRP0001:01: hash matches
> [    2.340824] dma dma0chan0: hash matches
> [    2.341195] device-mapper: init: waiting for all devices to be available before creating mapped devices
> [    2.396228] input: ELAN9050:00 04F3:2DFD as /devices/pci0000:00/0000:00:15.3/i2c_designware.3/i2c-17/i2c-ELAN9050:00/0018:04F3:2DFD.0001/input/input4
> [    2.396332] input: ELAN9050:00 04F3:2DFD UNKNOWN as /devices/pci0000:00/0000:00:15.3/i2c_designware.3/i2c-17/i2c-ELAN9050:00/0018:04F3:2DFD.0001/input/input5
> [    2.396436] input: ELAN9050:00 04F3:2DFD UNKNOWN as /devices/pci0000:00/0000:00:15.3/i2c_designware.3/i2c-17/i2c-ELAN9050:00/0018:04F3:2DFD.0001/input/input6
> [    2.396542] input: ELAN9050:00 04F3:2DFD Stylus as /devices/pci0000:00/0000:00:15.3/i2c_designware.3/i2c-17/i2c-ELAN9050:00/0018:04F3:2DFD.0001/input/input7
> [    2.396648] input: ELAN9050:00 04F3:2DFD UNKNOWN as /devices/pci0000:00/0000:00:15.3/i2c_designware.3/i2c-17/i2c-ELAN9050:00/0018:04F3:2DFD.0001/input/input8
> [    2.396797] hid-multitouch 0018:04F3:2DFD.0001: input,hidraw0: I2C HID v1.00 Device [ELAN9050:00 04F3:2DFD] on i2c-ELAN9050:00
> [    2.411625] elan_i2c i2c-ELAN0000:00: Elan Touchpad: Module ID: 0x0113, Firmware: 0x00a0, Sample: 0x0006, IAP: 0x0002
> [    2.411921] input: Elan Touchpad as /devices/pci0000:00/0000:00:19.1/i2c_designware.5/i2c-19/i2c-ELAN0000:00/input/input11
> [    2.412368] device-mapper: table: 254:0: verity: Data device lookup failed (-EPERM)
> [    2.412372] device-mapper: ioctl: error adding target to table
> [    2.412623] ALSA device list:
> [    2.412626]   No soundcards found.
> [    2.412636] Warning: unable to open an initial console.
> [    2.414192] EXT4-fs (nvme0n1p3): mounting ext2 file system using the ext4 subsystem
> [    2.414689] EXT4-fs (nvme0n1p3): warning: mounting unchecked fs, running e2fsck is recommended
> [    2.417019] EXT4-fs (nvme0n1p3): mounted filesystem without journal. Quota mode: none.
> [    2.417030] VFS: Mounted root (ext2 filesystem) on device 259:3.
> [    2.417484] devtmpfs: mounted
> [    2.421386] Freeing unused kernel image (initmem) memory: 1940K
> [    2.428472] Write protecting the kernel read-only data: 26624k
> [    2.429634] Freeing unused kernel image (text/rodata gap) memory: 2036K
> [    2.430233] Freeing unused kernel image (rodata/data gap) memory: 1296K
> [    2.430252] Run /sbin/init as init process
> [    2.430256]   with arguments:
> [    2.430257]     /sbin/init
> [    2.430259]     cros_secure
> [    2.430260]     cros_debug
> [    2.430261]     noresume
> [    2.430262]     noswap
> [    2.430263]   with environment:
> [    2.430264]     HOME=/
> [    2.430265]     TERM=linux
> [    2.430267]     dm=1 vroot none ro 1,0 6348800 verity payload=ROOT_DEV hashtree=HASH_DEV hashstart=6348800 alg=sha256 root_hexdigest=0366e3e4513a397e0c251ddd703a03cbd06f8de6ed9f2a1f7ad6617f30a44817 salt=cf6734dadd53d9e3adcabf0ee4138b94df54df8d8095f1a8fec6f49fb90b63e8
> [    2.430269]     boot=local
> [    2.430270]     xdomain=0
> [    2.447725] audit: type=1404 audit(1678366501.317:2): enforcing=1 old_enforcing=0 auid=4294967295 ses=4294967295 enabled=1 old-enabled=1 lsm=selinux res=1
> [    2.471121] SELinux:  Permission nlmsg_getneigh in class netlink_route_socket not defined in policy.
> [    2.471145] SELinux:  Permission bpf in class capability2 not defined in policy.
> [    2.471148] SELinux:  Permission checkpoint_restore in class capability2 not defined in policy.
> [    2.471159] SELinux:  Permission bpf in class cap2_userns not defined in policy.
> [    2.471162] SELinux:  Permission checkpoint_restore in class cap2_userns not defined in policy.
> [    2.471186] SELinux:  Class mctp_socket not defined in policy.
> [    2.471190] SELinux:  Class anon_inode not defined in policy.
> [    2.471192] SELinux:  Class io_uring not defined in policy.
> [    2.471194] SELinux:  Class user_namespace not defined in policy.
> [    2.471196] SELinux: the above unknown classes and permissions will be denied
> [    2.472561] SELinux:  policy capability network_peer_controls=1
> [    2.472564] SELinux:  policy capability open_perms=1
> [    2.472567] SELinux:  policy capability extended_socket_class=1
> [    2.472569] SELinux:  policy capability always_check_network=0
> [    2.472571] SELinux:  policy capability cgroup_seclabel=0
> [    2.472572] SELinux:  policy capability nnp_nosuid_transition=1
> [    2.472574] SELinux:  policy capability genfs_seclabel_symlinks=0
> [    2.472576] SELinux:  policy capability ioctl_skip_cloexec=0
> [    2.506505] audit: type=1403 audit(1678366501.376:3): auid=4294967295 ses=4294967295 lsm=selinux res=1
> [    2.514225] usb 3-1: new low-speed USB device number 2 using xhci_hcd
> [    2.566847] SELinux:  Context u:object_r:cros_run_pvm_opt:s0 is not valid (left unmapped).
> [    2.566927] SELinux:  Context u:object_r:cros_run_pvm_opt_pita:s0 is not valid (left unmapped).
> [    2.568210] audit: type=1400 audit(1678366501.438:4): avc:  granted  { execute } for  pid=243 comm="sh" name="crash_reporter" dev="nvme0n1p3" ino=41890 scontext=u:r:cros_init_scripts:s0 tcontext=u:object_r:cros_crash_reporter_exec:s0 tclass=file
> [    2.633476] init: early-failure main process (244) terminated with status 124
> [    2.642389] loop0: detected capacity change from 0 to 920
> [    2.644625] usb 3-1: No LPM exit latency info found, disabling LPM.
> [    2.651136] usb 3-1: New USB device found, idVendor=04e8, idProduct=4000, bcdDevice= 4.45
> [    2.651145] usb 3-1: New USB device strings: Mfr=2, Product=3, SerialNumber=1
> [    2.651149] usb 3-1: Product: Portable SSD X5
> [    2.651153] usb 3-1: Manufacturer: SAMSUNG ELECTRONICS CO., LTD
> [    2.651156] usb 3-1: SerialNumber: 950740060FDD0F962F43B8088B49A646
> [    2.654950] udevd[261]: starting version 225
> [    2.657348] NMI watchdog: Enabled. Permanently consumes one hw-PMU counter.
> [    2.672379] udevd[262]: invalid key/value pair in file /lib/udev/rules.d/99-mei_driver_files.rules on line 1, starting at character 1 ('/')
> [    2.672385] udevd[262]: invalid key/value pair in file /lib/udev/rules.d/99-mei_driver_files.rules on line 2, starting at character 1 ('/')
> [    2.672388] udevd[262]: invalid key/value pair in file /lib/udev/rules.d/99-mei_driver_files.rules on line 3, starting at character 1 ('/')
> [    2.690195] LoadPin: nvme0n1p3 (259:3): writable
> [    2.690210] LoadPin: enforcement can be disabled.
> [    2.690217] LoadPin: kernel-module pinned obj="/lib/modules/6.1.15-01642-g2f18a077d91a/kernel/drivers/input/joydev.ko.gz" pid=273 cmdline="udevd --daemon"
> [    2.760021] usb 4-1: new SuperSpeed USB device number 2 using xhci_hcd
> [    2.787818] usb 4-1: New USB device found, idVendor=0bda, idProduct=0411, bcdDevice= 1.33
> [    2.787825] usb 4-1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
> [    2.787827] usb 4-1: Product: 4-Port USB 3.0 Hub
> [    2.787829] usb 4-1: Manufacturer: Generic
> [    2.795930] hub 4-1:1.0: USB hub found
> [    2.797256] hub 4-1:1.0: 4 ports detected
> [    2.802029] frecon[527]: Frecon using drm driver i915, version 1.6, date(20201103), desc(Intel Graphics) using atomic
> [    2.838338] frecon[527]: Frecon using drm driver i915, version 1.6, date(20201103), desc(Intel Graphics) using atomic
> [    2.892238] usb 3-9: new high-speed USB device number 3 using xhci_hcd
> [    2.945347] udevd[545]: Process '/usr/bin/dbus-send --system --dest=org.chromium.ResourceManager   /org/chromium/ResourceManager org.chromium.ResourceManager.PowerSupplyChange' failed with exit code 1.
> [    3.041397] usb 3-9: New USB device found, idVendor=0bda, idProduct=5411, bcdDevice= 1.33
> [    3.041423] usb 3-9: New USB device strings: Mfr=1, Product=2, SerialNumber=0
> [    3.041433] usb 3-9: Product: 4-Port USB 2.0 Hub
> [    3.041441] usb 3-9: Manufacturer: Generic
> [    3.044579] hub 3-9:1.0: USB hub found
> [    3.045834] hub 3-9:1.0: 4 ports detected
> [    3.104679] usb 4-1.4: new SuperSpeed USB device number 3 using xhci_hcd
> [    3.109281] EXT4-fs (dm-3): recovery complete
> [    3.111331] EXT4-fs (dm-3): mounted filesystem with ordered data mode. Quota mode: journalled.
> [    3.112105] EXT4-fs (nvme0n1p8): mounted filesystem without journal. Quota mode: none.
> [    3.117071] usb 4-1.4: New USB device found, idVendor=0bda, idProduct=8153, bcdDevice=30.00
> [    3.117081] usb 4-1.4: New USB device strings: Mfr=1, Product=2, SerialNumber=6
> [    3.117085] usb 4-1.4: Product: USB 10/100/1000 LAN
> [    3.117089] usb 4-1.4: Manufacturer: Realtek
> [    3.117092] usb 4-1.4: SerialNumber: 000001000000
> [    3.127564] EXT4-fs (dm-3): re-mounted. Quota mode: journalled.
> [    3.138928] usbcore: registered new interface driver r8152
> [    3.141948] usbcore: registered new interface driver cdc_ether
> [    3.142538] usbcore: registered new interface driver r8153_ecm
> [    3.230124] usb 3-10: new full-speed USB device number 4 using xhci_hcd
> [    3.358508] usb 3-10: New USB device found, idVendor=8087, idProduct=0033, bcdDevice= 0.00
> [    3.358526] usb 3-10: New USB device strings: Mfr=0, Product=0, SerialNumber=0
> [    3.408566] Bluetooth: bt_init() Core ver 2.22
> [    3.408589] NET: Registered PF_BLUETOOTH protocol family
> [    3.408590] Bluetooth: bt_init() HCI device and connection manager initialized
> [    3.408593] Bluetooth: hci_sock_init() HCI socket layer initialized
> [    3.408594] Bluetooth: l2cap_init_sockets() L2CAP socket layer initialized
> [    3.408598] Bluetooth: sco_init() SCO socket layer initialized
> [    3.413846] usb 3-10: GPIO lookup for consumer reset
> [    3.413849] usb 3-10: using ACPI for GPIO lookup
> [    3.413851] acpi device:34: GPIO: looking up reset-gpios
> [    3.413853] acpi device:34: GPIO: looking up reset-gpio
> [    3.413855] acpi device:34: GPIO: _DSD returned device:34 0 0 1
> [    3.413942] gpio gpiochip0: Persistence not supported for GPIO 164
> [    3.414048] usbcore: registered new interface driver btusb
> [    3.416546] Bluetooth: btintel_version_info_tlv() hci0: Device revision is 0
> [    3.416549] Bluetooth: btintel_version_info_tlv() hci0: Secure boot is enabled
> [    3.416551] Bluetooth: btintel_version_info_tlv() hci0: OTP lock is enabled
> [    3.416551] Bluetooth: btintel_version_info_tlv() hci0: API lock is enabled
> [    3.416557] Bluetooth: btintel_version_info_tlv() hci0: Debug lock is disabled
> [    3.416557] Bluetooth: btintel_version_info_tlv() hci0: Minimum firmware build 1 week 10 2014
> [    3.416559] Bluetooth: btintel_version_info_tlv() hci0: Bootloader timestamp 2019.40 buildtype 1 build 38
> [    3.417487] Bluetooth: btintel_prepare_fw_download_tlv() hci0: Found device firmware: intel/ibt-0040-0041.sfi
> [    3.417506] Bluetooth: btintel_firmware_version() hci0: Boot Address: 0x100800
> [    3.417508] Bluetooth: btintel_firmware_version() hci0: Firmware Version: 35-4.23
> [    3.426457] usb 4-1.4: reset SuperSpeed USB device number 3 using xhci_hcd
> [    3.468949] r8152 4-1.4:1.0: load rtl8153a-3 v2 02/07/20 successfully
> [    3.493914] r8152 4-1.4:1.0 eth0: v1.12.13
> [    3.574557] udevd[648]: conflicting device node '/dev/mapper/encstateful' found, link to '/dev/dm-5' will not be created
> [    3.614980] EXT4-fs (dm-5): 2 orphan inodes deleted
> [    3.614992] EXT4-fs (dm-5): recovery complete
> [    3.625997] EXT4-fs (dm-5): mounted filesystem with ordered data mode. Quota mode: none.
> [    3.696707] encrypted-reboo (pid 662) is setting deprecated v1 encryption policy; recommend upgrading to v2.
> [    3.697699] audit: type=1400 audit(1678366502.567:5): avc:  granted  { execute } for  pid=663 comm="chromeos_startu" name="crash_reporter" dev="nvme0n1p3" ino=41890 scontext=u:r:chromeos_startup:s0 tcontext=u:object_r:cros_crash_reporter_exec:s0 tclass=file
> [    3.758205] SELinux:  Context u:object_r:cros_modemfwd_file:s0  is not valid (left unmapped).
> [    3.931585] /dev/A5GEVOXPBBG11XSG/dev-image: Can't open blockdev
> [    3.933149] EXT4-fs (dm-3): re-mounted. Quota mode: journalled.
> [    3.947387] udevd[796]: Process '/usr/bin/dbus-send --system --dest=org.chromium.ResourceManager   /org/chromium/ResourceManager org.chromium.ResourceManager.PowerSupplyChange' failed with exit code 1.
> [    3.955114] low_mem: threshold[0] 1658 MB
> [    3.955118] low_mem: threshold[1] 12755 MB
> [    3.960324] zram: Added device: zram0
> [    4.046109] zram0: detected capacity change from 0 to 127553600
> [    4.058706] Adding 63776796k swap on /dev/zram0.  Priority:-2 extents:1 across:63776796k SS
> [    4.113308] cros-ec-light-prox: probe of cros-ec-light.17.auto failed with error -22
> [    4.116467] udevd[1089]: Process '/sbin/restorecon /dev/iio:device1' failed with exit code 255.
> [    4.173993] gpio gpiochip0: Persistence not supported for GPIO 335
> [    4.206042] Intel(R) Wireless WiFi driver for Linux
> [    4.206119] pci 0000:00:14.3: attach allowed to drvr iwlwifi [internal device]
> [    4.210359] iwlwifi 0000:00:14.3: Detected crf-id 0x400410, cnv-id 0x80400 wfpm id 0x80000020
> [    4.210402] iwlwifi 0000:00:14.3: PCI dev 51f1/0090, rev=0x370, rfid=0x2010d000
> [    4.214007] iwlwifi 0000:00:14.3: api flags index 2 larger than supported by driver
> [    4.214032] iwlwifi 0000:00:14.3: WRT: Invalid time point 28 for host command TLV
> [    4.214035] iwlwifi 0000:00:14.3: WRT: Failed to allocate TLV 0x1000007, ret -22, (ext=0)
> [    4.214039] iwlwifi 0000:00:14.3: TLV_FW_FSEQ_VERSION: FSEQ Version: 0.0.2.41
> [    4.214488] iwlwifi 0000:00:14.3: loaded firmware version 79.27f1c37b.0 so-a0-gf-a0-79.ucode op_mode iwlmvm
> [    4.304370] iwlwifi 0000:00:14.3: Detected Intel(R) Wi-Fi 6E AX211 160MHz, REV=0x370
> [    4.304410] thermal thermal_zone8: failed to read out thermal zone (-61)
> [    4.377172] loop1: detected capacity change from 0 to 192920
> [    4.474424] iwlwifi 0000:00:14.3: WFPM_UMAC_PD_NOTIFICATION: 0x20
> [    4.474439] iwlwifi 0000:00:14.3: WFPM_LMAC2_PD_NOTIFICATION: 0x1f
> [    4.474449] iwlwifi 0000:00:14.3: WFPM_AUTH_KEY_0: 0x90
> [    4.474457] iwlwifi 0000:00:14.3: CNVI_SCU_SEQ_DATA_DW9: 0x0
> [    4.474798] iwlwifi 0000:00:14.3: loaded PNVM version 64acdc51
> [    4.490406] iwlwifi 0000:00:14.3: RFIm is deactivated, reason = 4
> [    4.490479] iwlwifi 0000:00:14.3: Detected RF GF, rfid=0x2010d000
> [    4.560397] iwlwifi 0000:00:14.3: base HW address: 54:6c:eb:32:43:b2
> [    4.926551] init: failsafe-delay main process (1003) killed by TERM signal
> [    4.927087] init: featured main process (2371) terminated with status 69
> [    4.927097] init: featured main process ended, respawning
> [    4.942172] init: featured main process (2443) terminated with status 69
> [    4.942184] init: featured main process ended, respawning
> [    4.950178] fuse: init (API version 7.37)
> [    4.959193] init: featured main process (2489) terminated with status 69
> [    4.959206] init: featured main process ended, respawning
> [    4.964069] init: modemfwd main process (2400) terminated with status 69
> [    4.972551] init: featured main process (2544) terminated with status 69
> [    4.972562] init: featured main process ended, respawning
> [    4.983804] init: featured main process (2570) terminated with status 69
> [    4.983814] init: featured main process ended, respawning
> [    4.994621] init: featured main process (2578) terminated with status 69
> [    4.994636] init: featured main process ended, respawning
> [    5.008063] init: featured main process (2600) terminated with status 69
> [    5.008076] init: featured main process ended, respawning
> [    5.022059] init: featured main process (2629) terminated with status 69
> [    5.022076] init: featured main process ended, respawning
> [    5.034497] init: featured main process (2652) terminated with status 69
> [    5.034512] init: featured main process ended, respawning
> [    5.042544] init: featured main process (2675) terminated with status 69
> [    5.042558] init: featured main process ended, respawning
> [    5.051403] init: featured main process (2703) terminated with status 69
> [    5.051415] init: featured main process ended, respawning
> [    5.058895] init: featured main process (2724) terminated with status 69
> [    5.058909] init: featured main process ended, respawning
> [    5.064833] fscrypt: AES-256-CTS-CBC using implementation "cts-cbc-aes-aesni"
> [    5.069244] init: featured main process (2738) terminated with status 69
> [    5.069255] init: featured main process ended, respawning
> [    5.076612] init: featured main process (2759) terminated with status 69
> [    5.076625] init: featured main process ended, respawning
> [    5.085714] init: featured main process (2769) terminated with status 69
> [    5.085726] init: featured main process ended, respawning
> [    5.095399] init: featured main process (2778) terminated with status 69
> [    5.095412] init: featured main process ended, respawning
> [    5.104354] init: featured main process (2789) terminated with status 69
> [    5.104365] init: featured respawning too fast, stopped
> [    5.107870] Bluetooth: btintel_download_wait() hci0: Waiting for firmware download to complete
> [    5.108459] Bluetooth: btintel_download_wait() hci0: Firmware loaded in 1651337 usecs
> [    5.108753] Bluetooth: btintel_boot_wait() hci0: Waiting for device to boot
> [    5.124471] Bluetooth: btintel_boot_wait() hci0: Device booted in 15506 usecs
> [    5.124506] Bluetooth: msft_skb_pull() hci0: Malformed MSFT vendor event: 0x02
> [    5.124924] Bluetooth: btintel_load_ddc_config() hci0: Found Intel DDC parameters: intel/ibt-0040-0041.ddc
> [    5.127569] Bluetooth: btintel_load_ddc_config() hci0: Applying Intel DDC parameters completed
> [    5.130620] Bluetooth: btintel_version_info_tlv() hci0: Firmware timestamp 2023.4 buildtype 1 build 58403
> [    5.130823] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
> [    5.132052] r8152 4-1.4:1.0 eth0: carrier on
> [    5.201969] Bluetooth: mgmt_init_hdev() MGMT ver 1.22
> [    5.328877] 8021q: 802.1Q VLAN Support v1.8
> [    5.364638] NET: Registered PF_ALG protocol family
> [    5.498693] pci 0000:00:05.0: attach allowed to drvr intel-ipu6 [internal device]
> [    5.506000] intel-ipu6 intel-ipu: Device 0xa75d (rev: 0x1)
> [    5.506209] intel-ipu6 intel-ipu: physical base address 0x82000000
> [    5.506229] intel-ipu6 intel-ipu: mapped as: 0x00000000057757e2
> [    5.509912] intel-ipu6 intel-ipu: IPU in secure mode
> [    5.509949] intel-ipu6 intel-ipu: IPU secure touch = 0x0
> [    5.509964] intel-ipu6 intel-ipu: IPU camera mask = 0xff
> [    5.524724] intel-ipu6 intel-ipu: IPC reset done
> [    5.524791] intel-ipu6 intel-ipu: cpd file name: intel/ipu6ep_fw.bin
> [    5.533502] intel-ipu6 intel-ipu: FW version: 20220510
> [    5.569324] intel-ipu6 intel-ipu: Sending BOOT_LOAD to CSE
> [    5.579638] intel-ipu6 intel-ipu: Sending AUTHENTICATE_RUN to CSE
> [    5.598044] acpi 10EC5682:00: GPIO: looking up 0 in _CRS
> [    5.598881] acpi PRP0001:00: GPIO: looking up 0 in _CRS
> [    5.601579] gpio gpiochip0: Persistence not supported for GPIO 87
> [    5.626794] rt5682 i2c-10EC5682:00: Using default DAI clk names: rt5682-dai-wclk, rt5682-dai-bclk
> [    5.628378] acpi PRP0001:01: GPIO: looking up 0 in _CRS
> [    5.628427] rt5682 i2c-10EC5682:00: supply AVDD not found, using dummy regulator
> [    5.630330] dw9714 i2c-PRP0001:00: supply vcc not found, using dummy regulator
> [    5.630383] at24 i2c-PRP0001:01: supply vcc not found, using dummy regulator
> [    5.639255] rt5682 i2c-10EC5682:00: supply MICVDD not found, using dummy regulator
> [    5.652413] intel-ipu6 intel-ipu: CSE authenticate_run done
> [    5.653284] intel-ipu6 intel-ipu: IPU6-v3 driver version 1.0
> [    5.677987] rt5682 i2c-10EC5682:00: supply VBAT not found, using dummy regulator
> [    5.678541] at24 i2c-PRP0001:01: GPIO lookup for consumer wp
> [    5.678571] at24 i2c-PRP0001:01: using ACPI for GPIO lookup
> [    5.678586] acpi PRP0001:01: GPIO: looking up wp-gpios
> [    5.678597] acpi PRP0001:01: GPIO: looking up wp-gpio
> [    5.678607] at24 i2c-PRP0001:01: using lookup tables for GPIO lookup
> [    5.678619] at24 i2c-PRP0001:01: No GPIO consumer wp found
> [    5.678778] max98357a MX98360A:00: GPIO lookup for consumer sdmode
> [    5.678787] max98357a MX98360A:00: using ACPI for GPIO lookup
> [    5.678793] acpi MX98360A:00: GPIO: looking up sdmode-gpios
> [    5.678802] acpi MX98360A:00: GPIO: looking up sdmode-gpio
> [    5.678811] acpi MX98360A:00: GPIO: _DSD returned MX98360A:00 0 0 0
> [    5.679070] gpio gpiochip0: Persistence not supported for GPIO 75
> [    5.679834] rt5682 i2c-10EC5682:00: supply DBVDD not found, using dummy regulator
> [    5.681314] rt5682 i2c-10EC5682:00: supply LDO1-IN not found, using dummy regulator
> [    5.712993] at24 i2c-PRP0001:01: 8192 byte 24c08 EEPROM, read-only
> [    5.715445] acpi INT3478:00: GPIO: looking up 0 in _CRS
> [    6.007663] acpi OVTI8856:00: GPIO: looking up 0 in _CRS
> [    6.010737] mei_hdcp 0000:00:16.0-b638ab7e-94e2-4ea2-a552-d1c54b627f04: bound 0000:00:02.0 (ops 0xffffffff862f8f70)
> [    6.021154] udevd[2824]: Process '/bin/chgrp arc-camera /sys//devices/pci0000:00/0000:00:15.0/i2c_designware.0/i2c-14/i2c-PRP0001:00/eeprom' failed with exit code 1.
> [    6.036452] udevd[2824]: Process '/bin/chmod 440 /sys//devices/pci0000:00/0000:00:15.0/i2c_designware.0/i2c-14/i2c-PRP0001:00/eeprom' failed with exit code 1.
> [    6.043045] ov8856 i2c-OVTI8856:00: OV8856 revision 1 (2A) at address 0x36
> [    6.054010] sx9324 i2c-STH9324:00: supply vdd not found, using dummy regulator
> [    6.061095] sx9324 i2c-STH9324:01: supply vdd not found, using dummy regulator
> [    6.063796] sx9324 i2c-STH9324:00: supply svdd not found, using dummy regulator
> [    6.069732] sx9324 i2c-STH9324:01: supply svdd not found, using dummy regulator
> [    6.523475] typec port0: bound usb3-port1 (ops 0xffffffff865825d8)
> [    6.526927] typec port0: bound usb2-port1 (ops 0xffffffff865825d8)
> [    6.529843] typec port0: bound usb4_port1 (ops 0xffffffff865b6870)
> [    6.542035] Bluetooth: rfcomm_init_sockets() RFCOMM socket layer initialized
> [    6.542251] Bluetooth: rfcomm_init() RFCOMM ver 1.11
> [    6.545031] Bluetooth: set_offload_codec_func() hci0: offload codecs enable 1 changed 1
> [    6.545916] typec port1: bound usb3-port2 (ops 0xffffffff865825d8)
> [    6.548921] typec port1: bound usb2-port2 (ops 0xffffffff865825d8)
> [    6.585787] typec port2: bound usb3-port3 (ops 0xffffffff865825d8)
> [    6.585872] typec port2: bound usb2-port3 (ops 0xffffffff865825d8)
> [    6.585911] typec port2: bound usb4_port1 (ops 0xffffffff865b6870)
> [    6.743454] intel-ipu6-isys intel-ipu6-isys0: bind ov8856 14-0036 nlanes is 4 port is 2
> [    7.018295] pci 0000:00:1f.3: attach allowed to drvr sof-audio-pci-intel-tgl [internal device]
> [    7.020021] sof-audio-pci-intel-tgl 0000:00:1f.3: DSP detected with PCI class/subclass/prog-if 0x040100
> [    7.023368] sof-audio-pci-intel-tgl 0000:00:1f.3: bound 0000:00:02.0 (ops 0xffffffff862f2260)
> [    7.039994] sof-audio-pci-intel-tgl 0000:00:1f.3: use msi interrupt mode
> [    7.097247] intel-ipu6-isys intel-ipu6-isys0: bind imx208 16-0010 nlanes is 2 port is 1
> [    7.110440] intel-ipu6-isys intel-ipu6-isys0: All sensor registration completed.
> [    7.169643] intel-ipu6-psys intel-ipu6-psys0: pkg_dir entry count:8
> [    7.173383] intel-ipu6-psys intel-ipu6-psys0: psys probe minor: 0
> [    7.184395] sof-audio-pci-intel-tgl 0000:00:1f.3: NHLT table not found
> [    7.184441] sof-audio-pci-intel-tgl 0000:00:1f.3: hda codecs found, mask 4
> [    7.184458] sof-audio-pci-intel-tgl 0000:00:1f.3: using HDA machine driver skl_hda_dsp_generic now
> [    7.184485] sof-audio-pci-intel-tgl 0000:00:1f.3: DMICs detected in NHLT tables: 0
> [    7.187742] sof-audio-pci-intel-tgl 0000:00:1f.3: Firmware info: version 2:2:0-a337f
> [    7.187778] sof-audio-pci-intel-tgl 0000:00:1f.3: Firmware: ABI 3:23:0 Kernel ABI 3:23:0
> [    7.187895] sof-audio-pci-intel-tgl 0000:00:1f.3: unknown sof_ext_man header type 3 size 0x30
> [    7.327787] sof-audio-pci-intel-tgl 0000:00:1f.3: Firmware info: version 2:2:0-a337f
> [    7.327833] sof-audio-pci-intel-tgl 0000:00:1f.3: Firmware: ABI 3:23:0 Kernel ABI 3:23:0
> [    8.205334] udevd[2845]: Process '/usr/sbin/mems_setup --device_id=1' failed with exit code 1.
> [    8.213133] udevd[2804]: Process '/usr/sbin/mems_setup --device_id=5' failed with exit code 1.
> [    8.529020] init: cdm-oemcrypto main process ended, respawning
> [    8.671554] IPv6: ADDRCONF(NETDEV_CHANGE): arc_ns0: link becomes ready
> [    8.671882] IPv6: ADDRCONF(NETDEV_CHANGE): veth0: link becomes ready
> [    9.341796] IPv6: ADDRCONF(NETDEV_CHANGE): veth1: link becomes ready
> [   10.365707] loop2: detected capacity change from 0 to 18888
> [   10.405042] loop3: detected capacity change from 0 to 39688
> [   11.037489] input: cros_fp_input as /devices/virtual/input/input12
> [   11.206703] usb 3-1: USB disconnect, device number 2
> [   11.373628] init: cdm-oemcrypto main process ended, respawning
> [   13.717775] thunderbolt 0-0:1.1: GPIO lookup for consumer wp
> [   13.717803] thunderbolt 0-0:1.1: using lookup tables for GPIO lookup
> [   13.717816] thunderbolt 0-0:1.1: No GPIO consumer wp found
> [   13.718003] thunderbolt 0-0:1.1: GPIO lookup for consumer wp
> [   13.718013] thunderbolt 0-0:1.1: using lookup tables for GPIO lookup
> [   13.718022] thunderbolt 0-0:1.1: No GPIO consumer wp found
> [   13.718156] thunderbolt 0-0:1.1: new retimer found, vendor=0x8087 device=0x15ee
> [   13.719595] udevd[5008]: Process '/bin/chown -R fwupd:fwupd /sys//devices/pci0000:00/0000:00:0d.2/domain0/0-0/usb4_port1/0-0:1.1' failed with exit code 1.
> [   13.727382] udevd[5008]: Process '/bin/chown power:power "/sys//devices/pci0000:00/0000:00:0d.2/domain0/0-0/usb4_port1/0-0:1.1/power/control"' failed with exit code 1.
> [   14.066734] init: cdm-oemcrypto main process ended, respawning
> [   14.797125] thunderbolt 0-1: new device found, vendor=0x175 device=0x4000
> [   14.797165] thunderbolt 0-1: SAMSUNG ELECTRONICS CO., LTD Portable SSD X5
> [   14.801243] thunderbolt 0-1: GPIO lookup for consumer wp
> [   14.801272] thunderbolt 0-1: using lookup tables for GPIO lookup
> [   14.801282] thunderbolt 0-1: No GPIO consumer wp found
> [   14.801478] thunderbolt 0-1: GPIO lookup for consumer wp
> [   14.801489] thunderbolt 0-1: using lookup tables for GPIO lookup
> [   14.801495] thunderbolt 0-1: No GPIO consumer wp found
> [   16.677992] init: cdm-oemcrypto main process ended, respawning
> [   19.236934] init: cdm-oemcrypto main process ended, respawning
> [   21.832583] init: cdm-oemcrypto respawning too fast, stopped
> [   41.837528] init: vm_cicerone state changed from spawning to spawned
> [   41.838023] init: vm_cicerone main process (7063) executable changed
> [   41.840760] init: vm_cicerone main process (7063) became new process (7064)
> [   41.840771] init: vm_cicerone state changed from spawned to post-starting
> [   41.840806] init: vm_cicerone state changed from post-starting to post-start
> [   41.840824] init: vm_cicerone state changed from post-start to running
> [   41.840928] init: Handling started event
> [   41.849751] init: Handling load-shill-profile event
> [   41.849848] init: shill-start-user-session goal changed from stop to start
> [   41.849863] init: shill-start-user-session state changed from waiting to starting
> [   41.849944] init: Handling starting event
> [   41.850016] init: shill-start-user-session state changed from starting to security-spawning
> [   41.850027] init: shill-start-user-session state changed from security-spawning to security
> [   41.850035] init: shill-start-user-session state changed from security to tmpfiles-spawning
> [   41.850043] init: shill-start-user-session state changed from tmpfiles-spawning to tmpfiles
> [   41.850051] init: shill-start-user-session state changed from tmpfiles to pre-starting
> [   41.850058] init: shill-start-user-session state changed from pre-starting to pre-start
> [   41.850066] init: shill-start-user-session state changed from pre-start to spawning
> [   41.850197] init: shill-start-user-session main process (7083)
> [   41.850220] init: shill-start-user-session state changed from spawning to spawned
> [   41.850454] init: shill-start-user-session state changed from spawned to post-starting
> [   41.850474] init: shill-start-user-session state changed from post-starting to post-start
> [   41.850486] init: shill-start-user-session state changed from post-start to running
> [   41.850509] init: Handling started event
> [   41.862793] init: shill-start-user-session main process (7083) exited normally
> [   41.862818] init: shill-start-user-session goal changed from start to stop
> [   41.862859] init: shill-start-user-session state changed from running to stopping
> [   41.862888] init: Handling stopping event
> [   41.863075] init: shill-start-user-session state changed from stopping to killed
> [   41.863096] init: shill-start-user-session state changed from killed to post-stopping
> [   41.863113] init: shill-start-user-session state changed from post-stopping to post-stop
> [   41.863131] init: shill-start-user-session state changed from post-stop to waiting
> [   41.863245] init: Handling stopped event
> [   41.885182] init: smbproviderd post-start process (7021) exited normally
> [   41.885215] init: smbproviderd state changed from post-start to running
> [   41.885277] init: Handling started event
> [   41.998200] init: Connection from private client
> [   41.999678] init: usb_bouncer pre-start process (6947) exited normally
> [   41.999704] init: usb_bouncer state changed from pre-start to spawning
> [   41.999855] init: usb_bouncer main process (7213)
> [   41.999897] init: usb_bouncer state changed from spawning to spawned
> [   42.000890] init: usb_bouncer state changed from spawned to post-starting
> [   42.000925] init: usb_bouncer state changed from post-starting to post-start
> [   42.001011] init: usb_bouncer state changed from post-start to running
> [   42.001048] init: Handling started event
> [   42.020401] init: usb_bouncer main process (7213) exited normally
> [   42.020422] init: usb_bouncer goal changed from start to stop
> [   42.020445] init: usb_bouncer state changed from running to stopping
> [   42.020473] init: Handling stopping event
> [   42.020651] init: usb_bouncer state changed from stopping to killed
> [   42.020669] init: usb_bouncer state changed from killed to post-stopping
> [   42.020679] init: usb_bouncer state changed from post-stopping to post-stop
> [   42.020689] init: usb_bouncer state changed from post-stop to waiting
> [   42.020753] init: Handling stopped event
> [   42.037620] init: lacros-unmounter goal changed from stop to start
> [   42.037659] init: lacros-unmounter state changed from waiting to starting
> [   42.037697] init: Handling starting event
> [   42.037993] init: lacros-unmounter state changed from starting to security-spawning
> [   42.038019] init: lacros-unmounter state changed from security-spawning to security
> [   42.038039] init: lacros-unmounter state changed from security to tmpfiles-spawning
> [   42.038064] init: lacros-unmounter state changed from tmpfiles-spawning to tmpfiles
> [   42.038089] init: lacros-unmounter state changed from tmpfiles to pre-starting
> [   42.038109] init: lacros-unmounter state changed from pre-starting to pre-start
> [   42.038128] init: lacros-unmounter state changed from pre-start to spawning
> [   42.038398] init: lacros-unmounter main process (7235)
> [   42.038490] init: lacros-unmounter state changed from spawning to spawned
> [   42.038989] init: lacros-unmounter state changed from spawned to post-starting
> [   42.039021] init: lacros-unmounter state changed from post-starting to post-start
> [   42.039039] init: lacros-unmounter state changed from post-start to running
> [   42.039079] init: Handling started event
> [   42.039695] init: lacros-unmounter main process (7235) exited normally
> [   42.039711] init: lacros-unmounter goal changed from start to stop
> [   42.039728] init: lacros-unmounter state changed from running to stopping
> [   42.039743] init: Handling stopping event
> [   42.039842] init: lacros-unmounter state changed from stopping to killed
> [   42.039852] init: lacros-unmounter state changed from killed to post-stopping
> [   42.039859] init: lacros-unmounter state changed from post-stopping to post-stop
> [   42.039865] init: lacros-unmounter state changed from post-stop to waiting
> [   42.039922] init: Handling stopped event
> [   42.522253] pcieport 0000:00:07.0: pciehp: Slot(3): Card present
> [   42.635697] init: Connection from private client
> [   42.646941] pci 0000:01:00.0: [8086:15da] type 01 class 0x060400
> [   42.647006] pci 0000:01:00.0: enabling Extended Tags
> [   42.647145] pci 0000:01:00.0: supports D1 D2
> [   42.647147] pci 0000:01:00.0: PME# supported from D0 D1 D2 D3hot D3cold
> [   42.647250] pci 0000:01:00.0: 8.000 Gb/s available PCIe bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:07.0 (capable of 31.504 Gb/s with 8.0 GT/s PCIe x4 link)
> [   42.647551] pci 0000:01:00.0: Adding to iommu group 21
> [   42.649913] pci 0000:01:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
> [   42.650029] pci 0000:02:01.0: [8086:15da] type 01 class 0x060400
> [   42.650101] pci 0000:02:01.0: enabling Extended Tags
> [   42.650233] pci 0000:02:01.0: supports D1 D2
> [   42.650235] pci 0000:02:01.0: PME# supported from D0 D1 D2 D3hot D3cold
> [   42.650403] pci 0000:02:01.0: Adding to iommu group 22
> [   42.650512] pci 0000:01:00.0: PCI bridge to [bus 02-2b]
> [   42.650521] pci 0000:01:00.0:   bridge window [io  0x0000-0x0fff]
> [   42.650526] pci 0000:01:00.0:   bridge window [mem 0x00000000-0x000fffff]
> [   42.650534] pci 0000:01:00.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]
> [   42.650538] pci 0000:02:01.0: bridge configuration invalid ([bus 00-00]), reconfiguring
> [   42.650636] pci 0000:03:00.0: [144d:a808] type 00 class 0x010802
> [   42.650671] pci 0000:03:00.0: reg 0x10: [mem 0x00000000-0x00003fff 64bit]
> [   42.651002] pci 0000:03:00.0: 8.000 Gb/s available PCIe bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:07.0 (capable of 31.504 Gb/s with 8.0 GT/s PCIe x4 link)
> [   42.651119] pci 0000:03:00.0: Adding to iommu group 22
> [   42.653906] pci 0000:02:01.0: PCI bridge to [bus 03-2b]
> [   42.653925] pci 0000:02:01.0:   bridge window [io  0x0000-0x0fff]
> [   42.653934] pci 0000:02:01.0:   bridge window [mem 0x00000000-0x000fffff]
> [   42.653945] pci 0000:02:01.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]
> [   42.653950] pci_bus 0000:03: busn_res: [bus 03-2b] end is updated to 2b
> [   42.653959] pci_bus 0000:02: busn_res: [bus 02-2b] end is updated to 2b
> [   42.653969] pci 0000:02:01.0: bridge window [mem 0x00100000-0x001fffff 64bit pref] to [bus 03-2b] add_size 100000 add_align 100000
> [   42.653975] pci 0000:02:01.0: bridge window [mem 0x00100000-0x001fffff] to [bus 03-2b] add_size 100000 add_align 100000
> [   42.653981] pci 0000:01:00.0: bridge window [mem 0x00100000-0x001fffff 64bit pref] to [bus 02-2b] add_size 100000 add_align 100000
> [   42.653985] pci 0000:01:00.0: bridge window [mem 0x00100000-0x001fffff] to [bus 02-2b] add_size 100000 add_align 100000
> [   42.653995] pci 0000:01:00.0: BAR 14: assigned [mem 0x83000000-0x8f1fffff]
> [   42.653999] pci 0000:01:00.0: BAR 15: assigned [mem 0x87fc00000-0x89bbfffff 64bit pref]
> [   42.654003] pci 0000:01:00.0: BAR 13: assigned [io  0x2000-0x3fff]
> [   42.654008] pci 0000:02:01.0: BAR 14: assigned [mem 0x83000000-0x8f1fffff]
> [   42.654012] pci 0000:02:01.0: BAR 15: assigned [mem 0x87fc00000-0x89bbfffff 64bit pref]
> [   42.654016] pci 0000:02:01.0: BAR 13: assigned [io  0x2000-0x3fff]
> [   42.654021] pci 0000:03:00.0: BAR 0: assigned [mem 0x83000000-0x83003fff 64bit]
> [   42.654042] pci 0000:02:01.0: PCI bridge to [bus 03-2b]
> [   42.654047] pci 0000:02:01.0:   bridge window [io  0x2000-0x3fff]
> [   42.654055] pci 0000:02:01.0:   bridge window [mem 0x83000000-0x8f1fffff]
> [   42.654062] pci 0000:02:01.0:   bridge window [mem 0x87fc00000-0x89bbfffff 64bit pref]
> [   42.654073] pci 0000:01:00.0: PCI bridge to [bus 02-2b]
> [   42.654077] pci 0000:01:00.0:   bridge window [io  0x2000-0x3fff]
> [   42.654086] pci 0000:01:00.0:   bridge window [mem 0x83000000-0x8f1fffff]
> [   42.654092] pci 0000:01:00.0:   bridge window [mem 0x87fc00000-0x89bbfffff 64bit pref]
> [   42.654103] pcieport 0000:00:07.0: PCI bridge to [bus 01-2b]
> [   42.654107] pcieport 0000:00:07.0:   bridge window [io  0x2000-0x3fff]
> [   42.654112] pcieport 0000:00:07.0:   bridge window [mem 0x83000000-0x8f1fffff]
> [   42.654116] pcieport 0000:00:07.0:   bridge window [mem 0x87fc00000-0x89bbfffff 64bit pref]
> [   42.654139] pci 0000:01:00.0: attach allowed to drvr pcieport [drvr in allowlist]
> [   42.654186] pcieport 0000:01:00.0: enabling device (0000 -> 0003)
> [   42.654757] pci 0000:02:01.0: attach allowed to drvr pcieport [drvr in allowlist]
> [   42.654785] pcieport 0000:02:01.0: enabling device (0000 -> 0003)
> [   42.655201] pcieport 0000:02:01.0: pciehp: Slot #1 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+
> [   42.655514] pci 0000:03:00.0: attach allowed to drvr nvme [drvr in allowlist]
> [   42.655871] nvme nvme1: pci function 0000:03:00.0
> [   42.655894] nvme 0000:03:00.0: enabling device (0000 -> 0002)
> *[ 42.656498] nvme nvme1: Removing after probe failure status: -19*
> [   42.682099] pcieport 0000:00:1c.0: AER: Multiple Corrected error received: 0000:82:00.0
> [   42.685595] sdhci-pci 0000:82:00.0: PCIe Bus Error: severity=Corrected, type=Data Link Layer, (Transmitter ID)
> [   42.685599] sdhci-pci 0000:82:00.0:   device [17a0:9755] error status/mask=00001000/00002000
> [   42.685602] sdhci-pci 0000:82:00.0:    [12] Timeout
> [   42.689393] pcieport 0000:00:1c.0: AER: Corrected error received: 0000:00:1c.0
> [   42.689402] pcieport 0000:00:1c.0: PCIe Bus Error: severity=Corrected, type=Data Link Layer, (Transmitter ID)
> [   42.689405] pcieport 0000:00:1c.0:   device [8086:51bf] error status/mask=00001000/00002000
> [   42.689408] pcieport 0000:00:1c.0:    [12] Timeout
> [   42.689430] pcieport 0000:00:1c.0: AER: Corrected error received: 0000:82:00.0
> [   42.692891] sdhci-pci 0000:82:00.0: PCIe Bus Error: severity=Corrected, type=Data Link Layer, (Transmitter ID)
> [   42.692893] sdhci-pci 0000:82:00.0:   device [17a0:9755] error status/mask=00001000/00002000
> [   42.692896] sdhci-pci 0000:82:00.0:    [12] Timeout
> [   43.200070] init: cdm-oemcrypto main process (6928) exited normally
> [   43.200091] init: cdm-oemcrypto main process ended, respawning
> [   43.200166] init: cdm-oemcrypto state changed from running to stopping
>
> The issue is specific to this particular device.
>
> Please let me know if you require more information (more logs enabled, etc.).
>
> Thanks
> Rajat
