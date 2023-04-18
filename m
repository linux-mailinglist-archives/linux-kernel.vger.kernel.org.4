Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48E646E5660
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 03:24:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbjDRBYo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 21:24:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjDRBYl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 21:24:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AA583AA2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 18:24:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BCB7862475
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 01:24:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36CD4C433EF;
        Tue, 18 Apr 2023 01:24:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681781078;
        bh=d+/9i/HvCTmAMbkHekQJJNIqcHMIhmJGbnzr3J0xxYM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GX2/tRr4FcY3iFHoqKN3F1JDBkSkHUTYbZd6gdqDV3knWKXP493lq4sU0feqQ/1KW
         9+YQ9DnshVn7lV655mTiJSkFMolOxqf4jlM0DDhf3XHtk0xNF+r+k67jHfJy4lItoW
         TjG0sZu9wmoYlRKnBHPrqSMyf8w23DCd3Hqnx3v7r4AyDJt7+uOQrv5M0iac4y9TaP
         ZwE3+Xb3kKfn/5pOhlR9I0q7g8kUhnJMtSWLk3OTR42iK6mMuaU/z7I9z1N5tDJmG8
         A6mZxVV/3gbTGVbKaRAdlSebz2m9YKXTyCYnUp4C5jekZ2gzDyH4DqZRmJFVpN6nln
         eFegaHwdS07yQ==
Date:   Mon, 17 Apr 2023 18:24:35 -0700
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>, x86-ml <x86@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] x86/urgent for v6.3-rc7
Message-ID: <20230418012435.fhjxd6moaz6tmnep@treble>
References: <20230416122913.GCZDvqGVe9TPa5LPRm@fat_crate.local>
 <CAHk-=wjOZgMu2VYBHMt-yFvurAqWsxLG8wh59km=B245CXRKxA@mail.gmail.com>
 <20230417090412.GAZD0LjH5ZIaGUdoHH@fat_crate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230417090412.GAZD0LjH5ZIaGUdoHH@fat_crate.local>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 17, 2023 at 11:04:12AM +0200, Borislav Petkov wrote:
> On Sun, Apr 16, 2023 at 10:33:19AM -0700, Linus Torvalds wrote:
> > On Sun, Apr 16, 2023 at 5:29 AM Borislav Petkov <bp@alien8.de> wrote:
> > >
> > > - Drop __init annotation from two rtc functions which get called after
> > >   boot is done, in order to prevent a crash
> > 
> > .. ahh, and our automation to catch these things didn't find it,
> > because they are only accessed from x86_wallclock_init(), which is
> > also __init.
> > 
> > So it all looked superficially good, except for the "oh, we saved them
> > into a data structure that _isn't_ init".
> > 
> > It would require automation much smarter than the one we have to catch
> > that kind of thing.
> 
> Looking at
> 
> objdump -D arch/x86/kernel/x86_init.o
> 
> output, all the info is there in order to check whether a function ptr from
> a .init section gets assigned to .data section structure.
> 
> Question is whether this is worth to put into objtool. From all the
> objtool code I've seen flying by in recent years, we should pretty much
> have everything needed so it should relatively easy to do.
> 
> But lemme add Josh and Peter...

I implemented it in the patch below.  It was pretty straightforward
since this case always(?) involves two relocations within a single
instruction, like:

 3d9:	48 c7 05 00 00 00 00 00 00 00 00 	movq   $0x0,0x0(%rip)        # 3e4 <x86_wallclock_init+0xa4>	3dc: R_X86_64_PC32	x86_platform+0x8
	3e0: R_X86_64_32S	.init.text+0x280

So objtool warns if the instruction's first relocation is non-init and
the second one is init.

Out of curiosity, I also added a few more init-related checks, as I'm
not sure what modpost's "section mismatch" does.  Specifically I added
the following three warnings:

  - "disallowed store of init symbol %s to non-init symbol %s"
  - "disallowed reference to init symbol %s in non-init code"
  - "disallowed reference to init symbol %s in non-init data %s at %s+0x%lx"

It spits out a lot of warnings on allyesconfig, though it's quite
possible many/most of them should be whitelisted as I haven't yet looked
at what modpost skips.

There are 9 "disallowed store" warnings.  There would have been more,
but I added per-symbol rate-limiting to keep the total number of
warnings down.  For example, instead of the x86_wallclock_init() issue
discovered above, it shows a similar warning from elsewhere:

  vmlinux.o: warning: objtool: xen_init_apic+0xab: disallowed store of init symbol xen_apic_check to non-init data x86_platform

Anyway, this is kind of experimental.  If any of these warnings don't
turn out to be useful I could drop some or all them.

vmlinux.o: warning: objtool: early_setup_idt+0x9: disallowed reference to init symbol vc_boot_ghcb in non-init code
vmlinux.o: warning: objtool: skip_addr+0x3f: disallowed reference to init symbol start_cpu0 in non-init code
vmlinux.o: warning: objtool: event_trigger_unlock_commit.constprop.0+0x20: disallowed reference to init symbol event_trace_file in non-init code
vmlinux.o: warning: objtool: bitmap_copy.constprop.0+0x13: disallowed reference to init symbol cp.25 in non-init code
vmlinux.o: warning: objtool: intel_pmu_init+0x896: disallowed store of init symbol __quirk.126 to non-init data x86_pmu
vmlinux.o: warning: objtool: xen_init_apic+0xab: disallowed store of init symbol xen_apic_check to non-init data x86_platform
vmlinux.o: warning: objtool: xen_start_kernel+0x2cc: disallowed store of init symbol xen_write_gdt_entry_boot to non-init data pv_ops
vmlinux.o: warning: objtool: xen_smp_init+0xc3: disallowed store of init symbol xen_smp_cpus_done to non-init data smp_ops
vmlinux.o: warning: objtool: set_cmdline_ftrace+0x99: disallowed store of init symbol bootup_tracer_buf to non-init data .bss
vmlinux.o: warning: objtool: kmem_cache_init+0x51: disallowed store of init symbol boot_kmem_cache_node.12 to non-init data __key.7
vmlinux.o: warning: objtool: debug_objects_selftest+0xdd: disallowed store of init symbol descr_type_test to non-init data obj_cache
vmlinux.o: warning: objtool: matroxfb_init_params+0x183: disallowed store of init symbol vesamap to non-init data __key.34
vmlinux.o: warning: objtool: early_console_setup+0xca: disallowed store of init symbol port_cfg to non-init data sci_ports
vmlinux.o: warning: objtool: disallowed reference to init symbol .head.text in non-init data .note.Xen at .note.Xen+0x10
vmlinux.o: warning: objtool: disallowed reference to init symbol btrfs_props_init in non-init data mod_init_seq at .rodata+0x701e80
vmlinux.o: warning: objtool: disallowed reference to init symbol imx_mu_imx7ulp_of_init in non-init data imx_mu_msi_irqchip_match_table at .rodata+0x7e3240
vmlinux.o: warning: objtool: disallowed reference to init symbol exynos3250_of_data in non-init data samsung_pinctrl_dt_match at .rodata+0x9f8600
vmlinux.o: warning: objtool: disallowed reference to init symbol s5pv210_wkup_irq_chip in non-init data exynos_wkup_irq_ids at .rodata+0x9f98a0
vmlinux.o: warning: objtool: disallowed reference to init symbol ids in non-init data __param_string_ids at .rodata+0xab5648
vmlinux.o: warning: objtool: disallowed reference to init symbol ks_pcie_host_init in non-init data ks_pcie_am654_host_ops at .rodata+0xad1800
vmlinux.o: warning: objtool: disallowed reference to init symbol num_slave_addrs in non-init data __param_arr_slave_addrs at .rodata+0xb42668
vmlinux.o: warning: objtool: disallowed reference to init symbol num_regshifts in non-init data __param_arr_regshifts at .rodata+0xb426a8
vmlinux.o: warning: objtool: disallowed reference to init symbol num_regsizes in non-init data __param_arr_regsizes at .rodata+0xb426e8
vmlinux.o: warning: objtool: disallowed reference to init symbol num_regspacings in non-init data __param_arr_regspacings at .rodata+0xb42728
vmlinux.o: warning: objtool: disallowed reference to init symbol num_irqs in non-init data __param_arr_irqs at .rodata+0xb42768
vmlinux.o: warning: objtool: disallowed reference to init symbol si_type_str in non-init data __param_string_type at .rodata+0xb42818
vmlinux.o: warning: objtool: disallowed reference to init symbol t2080_init_periph in non-init data chipinfo at .rodata+0xb86a28
vmlinux.o: warning: objtool: disallowed reference to init symbol nfi1x_parents in non-init data top_muxes at .rodata+0xbd9f90
vmlinux.o: warning: objtool: disallowed reference to init symbol infra_uart_parent in non-init data infra_muxes at .rodata+0xbdc0d0
vmlinux.o: warning: objtool: disallowed reference to init symbol sgmii1_clks in non-init data sgmii1_desc at .rodata+0xbdc6e0
vmlinux.o: warning: objtool: disallowed reference to init symbol sgmii0_clks in non-init data sgmii0_desc at .rodata+0xbdc760
vmlinux.o: warning: objtool: disallowed reference to init symbol eth_clks in non-init data eth_desc at .rodata+0xbdc7e0
vmlinux.o: warning: objtool: disallowed reference to init symbol nfi1x_parents in non-init data top_muxes at .rodata+0xbdd110
vmlinux.o: warning: objtool: disallowed reference to init symbol infra_uart_parent in non-init data infra_muxes at .rodata+0xbdeb10
vmlinux.o: warning: objtool: disallowed reference to init symbol ca53_parents in non-init data cpu_muxes at .rodata+0xbe16d0
vmlinux.o: warning: objtool: disallowed reference to init symbol r9a07g043_core_clks in non-init data r9a07g043_cpg_info at .rodata+0xc81020
vmlinux.o: warning: objtool: disallowed reference to init symbol core_clks in non-init data r9a07g054_cpg_info at .rodata+0xc81140
vmlinux.o: warning: objtool: disallowed reference to init symbol r9a07g044_crit_mod_clks in non-init data r9a07g044_cpg_info at .rodata+0xc811e8
vmlinux.o: warning: objtool: disallowed reference to init symbol r9a09g011_core_clks in non-init data r9a09g011_cpg_info at .rodata+0xc81aa0
vmlinux.o: warning: objtool: disallowed reference to init symbol r7s9210_cpg_mssr_info in non-init data cpg_mssr_match at .rodata+0xc83fe0
vmlinux.o: warning: objtool: disallowed reference to init symbol exynos5250_disp_gate_clks in non-init data exynos5250_disp_subcmu at .rodata+0xc88090
vmlinux.o: warning: objtool: disallowed reference to init symbol exynos5800_mau_gate_clks in non-init data exynos5800_mau_subcmu at .rodata+0xc88950
vmlinux.o: warning: objtool: disallowed reference to init symbol exynos5x_mscl_div_clks in non-init data exynos5x_mscl_subcmu at .rodata+0xc88980
vmlinux.o: warning: objtool: disallowed reference to init symbol exynos5x_mfc_div_clks in non-init data exynos5x_mfc_subcmu at .rodata+0xc889c0
vmlinux.o: warning: objtool: disallowed reference to init symbol exynos5x_g3d_gate_clks in non-init data exynos5x_g3d_subcmu at .rodata+0xc88a10
vmlinux.o: warning: objtool: disallowed reference to init symbol exynos5x_gsc_div_clks in non-init data exynos5x_gsc_subcmu at .rodata+0xc88a40
vmlinux.o: warning: objtool: disallowed reference to init symbol exynos5x_disp_div_clks in non-init data exynos5x_disp_subcmu at .rodata+0xc88a80
vmlinux.o: warning: objtool: disallowed reference to init symbol aud_cmu_info in non-init data exynos5433_cmu_of_match at .rodata+0xc88cc0
vmlinux.o: warning: objtool: disallowed reference to init symbol core_cmu_info in non-init data exynos7885_cmu_of_match at .rodata+0xc8a760
vmlinux.o: warning: objtool: disallowed reference to init symbol apm_cmu_info in non-init data exynos850_cmu_of_match at .rodata+0xc8a9c0
vmlinux.o: warning: objtool: disallowed reference to init symbol busmc_cmu_info in non-init data exynosautov9_cmu_of_match at .rodata+0xc8b0e0
vmlinux.o: warning: objtool: disallowed reference to init symbol peric_cmu_info in non-init data fsd_cmu_of_match at .rodata+0xc8bc00
vmlinux.o: warning: objtool: disallowed reference to init symbol imx8mm_soc_revision in non-init data imx8mp_soc_data at .rodata+0xcfce38
vmlinux.o: warning: objtool: disallowed reference to init symbol imx8mq_soc_revision in non-init data imx8mq_soc_data at .rodata+0xcfce68
vmlinux.o: warning: objtool: disallowed reference to init symbol i915_active_module_init in non-init data init_funcs at .rodata+0x108b4f8
vmlinux.o: warning: objtool: disallowed reference to init symbol ata_force_param_buf in non-init data __param_string_force at .rodata+0x1514a48
vmlinux.o: warning: objtool: disallowed reference to init symbol ubiblock_set_param in non-init data ubiblock_param_ops at .rodata+0x159da88
vmlinux.o: warning: objtool: disallowed reference to init symbol hisi_sfc_v3xx_dmi_quirk in non-init data hisi_sfc_v3xx_dmi_quirk_table at .rodata+0x15ad780
vmlinux.o: warning: objtool: disallowed reference to init symbol mtk_init in non-init data mtk_netdev_ops at .rodata+0x17dd548
vmlinux.o: warning: objtool: disallowed reference to init symbol netdev_init in non-init data netdev_ops at .rodata+0x1834128
vmlinux.o: warning: objtool: disallowed reference to init symbol fore200e_pca_prom_read in non-init data fore200e_pci_ops at .rodata+0x1d70cc8
vmlinux.o: warning: objtool: disallowed reference to init symbol ids in non-init data __param_string_ids at .rodata+0x1d8e218
vmlinux.o: warning: objtool: disallowed reference to init symbol init_common in non-init data ops_generic_v2 at .rodata+0x236cb30
vmlinux.o: warning: objtool: disallowed reference to init symbol init_8956 in non-init data ops_8956 at .rodata+0x236e4b0
vmlinux.o: warning: objtool: disallowed reference to init symbol init_8939 in non-init data ops_8939 at .rodata+0x236fed0
vmlinux.o: warning: objtool: disallowed reference to init symbol virtio_scmi_init in non-init data scmi_virtio_desc at .rodata+0x24e11a0
vmlinux.o: warning: objtool: disallowed reference to init symbol dmi_matched in non-init data huawei_quirks at .rodata+0x26655a0
vmlinux.o: warning: objtool: disallowed reference to init symbol set_ibm_param in non-init data __param_ops_fan at .rodata+0x26853e8
vmlinux.o: warning: objtool: disallowed reference to init symbol asus_t100_matched in non-init data inv_mpu_dev_list at .rodata+0x2801060
vmlinux.o: warning: objtool: disallowed reference to init symbol ima_appraise_cmdline_default in non-init data __param_ima_appraise at __param+0x4d28
vmlinux.o: warning: objtool: disallowed reference to init symbol rmem_cma_setup in non-init data __of_table_cma at __reservedmem_of_table+0xc0
vmlinux.o: warning: objtool: disallowed reference to init symbol al_fic_init_dt in non-init data __of_table_al_fic at __irqchip_of_table+0xc0
vmlinux.o: warning: objtool: disallowed reference to init symbol __fixed_factor_clk_of_clk_init_declare in non-init data __of_table_fixed_factor_clk at __clk_of_table+0xc0
vmlinux.o: warning: objtool: disallowed reference to init symbol xenboot_earlycon_setup in non-init data __UNIQUE_ID___earlycon_xenboot1165 at __earlycon_table+0x90
vmlinux.o: warning: objtool: disallowed reference to init symbol at91sam926x_pit_dt_init in non-init data __of_table_at91sam926x_pit at __timer_of_table+0xc0
vmlinux.o: warning: objtool: disallowed reference to init symbol need_page_owner in non-init data page_owner_ops at .data+0x8377d0
vmlinux.o: warning: objtool: disallowed reference to init symbol need_page_table_check in non-init data page_table_check_ops at .data+0x839bf0
vmlinux.o: warning: objtool: disallowed reference to init symbol trusted_tpm_init in non-init data trusted_key_tpm_ops at .data+0xa16b48
vmlinux.o: warning: objtool: disallowed reference to init symbol xenboot_console_setup in non-init data xenboot_console at .data+0xfb8650
vmlinux.o: warning: objtool: disallowed reference to init symbol lpc32xx_hsuart_console_setup in non-init data lpc32xx_hsuart_console at .data+0xfc1130
vmlinux.o: warning: objtool: disallowed reference to init symbol atmel_console_setup in non-init data atmel_console at .data+0xfc4e50
vmlinux.o: warning: objtool: disallowed reference to init symbol serial_omap_console_setup in non-init data serial_omap_console at .data+0xfc73f0
vmlinux.o: warning: objtool: disallowed reference to init symbol altera_uart_console_setup in non-init data altera_uart_console at .data+0xfc7790
vmlinux.o: warning: objtool: disallowed reference to init symbol altera_jtaguart_console_setup in non-init data altera_jtaguart_console at .data+0xfc81d0
vmlinux.o: warning: objtool: disallowed reference to init symbol vt8500_console_setup in non-init data vt8500_console at .data+0xfc8490
vmlinux.o: warning: objtool: disallowed reference to init symbol pch_console_setup in non-init data pch_console at .data+0xfc89b0
vmlinux.o: warning: objtool: disallowed reference to init symbol auart_console_setup in non-init data auart_console at .data+0xfc8e30
vmlinux.o: warning: objtool: disallowed reference to init symbol lqasc_console_setup in non-init data lqasc_console at .data+0xfc9150
vmlinux.o: warning: objtool: disallowed reference to init symbol lpuart_console_setup in non-init data lpuart32_console at .data+0xfca9d0
vmlinux.o: warning: objtool: disallowed reference to init symbol linflex_console_setup in non-init data linflex_console at .data+0xfcaeb0
vmlinux.o: warning: objtool: disallowed reference to init symbol mlb_usio_console_setup in non-init data mlb_usio_console at .data+0xfcd630
vmlinux.o: warning: objtool: disallowed reference to init symbol sifive_serial_console_setup in non-init data sifive_serial_console at .data+0xfcd950
vmlinux.o: warning: objtool: disallowed reference to init symbol sunplus_console_setup in non-init data sunplus_uart_console at .data+0xfcdf30
vmlinux.o: warning: objtool: disallowed reference to init symbol amd_iommu_prepare in non-init data amd_iommu_irq_ops at .data+0xfe2ba8
vmlinux.o: warning: objtool: disallowed reference to init symbol intel_prepare_irq_remapping in non-init data intel_irq_remap_ops at .data+0xfe6e08
vmlinux.o: warning: objtool: disallowed reference to init symbol hyperv_prepare_irq_remapping in non-init data hyperv_irq_remap_ops at .data+0xfedee8
vmlinux.o: warning: objtool: disallowed reference to init symbol __dtbo_overlay_base_begin in non-init data overlays at .data+0x1c6db60
vmlinux.o: warning: objtool: disallowed reference to init symbol uv_acpi_madt_oem_check in non-init data apic_x2apic_uv_x at .data..ro_after_init+0x18e30
vmlinux.o: warning: objtool: disallowed reference to init symbol qed_mfw_legacy_1g in non-init data qed_mfw_legacy_maps at .data..ro_after_init+0x1e998
vmlinux.o: warning: objtool: disallowed reference to init symbol qed_mfw_ext_1g in non-init data qed_mfw_ext_maps at .data..ro_after_init+0x1eab8
vmlinux.o: warning: objtool: disallowed reference to init symbol qede_forced_speed_1000 in non-init data qede_forced_speed_maps at .data..ro_after_init+0x1ebf8
vmlinux.o: warning: objtool: disallowed reference to init symbol __TRACE_SYSTEM_RET_PF_SPURIOUS in non-init data TRACE_SYSTEM_RET_PF_SPURIOUS at _ftrace_eval_map+0x0


diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index f937be1afe65..e60879dcf72d 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -405,6 +405,20 @@ static int decode_instructions(struct objtool_file *file)
 		u8 prev_len = 0;
 		u8 idx = 0;
 
+		/*
+		 * .init.text code is ran before userspace and thus doesn't
+		 * strictly need retpolines, except for modules which are
+		 * loaded late, they very much do need retpoline in their
+		 * .init.text
+		 */
+		if (!opts.module &&
+		    (strstr(sec->name, ".init") || !strcmp(sec->name, ".head.text")))
+			sec->init = true;
+
+		if (strstr(sec->name, ".ref"))
+			sec->ref = true;
+
+
 		if (!(sec->sh.sh_flags & SHF_EXECINSTR))
 			continue;
 
@@ -419,15 +433,6 @@ static int decode_instructions(struct objtool_file *file)
 		    !strncmp(sec->name, ".text.__x86.", 12))
 			sec->noinstr = true;
 
-		/*
-		 * .init.text code is ran before userspace and thus doesn't
-		 * strictly need retpolines, except for modules which are
-		 * loaded late, they very much do need retpoline in their
-		 * .init.text
-		 */
-		if (!strcmp(sec->name, ".init.text") && !opts.module)
-			sec->init = true;
-
 		for (offset = 0; offset < sec->sh.sh_size; offset += insn->len) {
 			if (!insns || idx == INSN_CHUNK_MAX) {
 				insns = calloc(sizeof(*insn), INSN_CHUNK_SIZE);
@@ -4317,12 +4322,38 @@ static bool noendbr_range(struct objtool_file *file, struct instruction *insn)
 	return insn->offset == sym->offset + sym->len;
 }
 
+static struct symbol *reloc_sym(struct reloc *reloc)
+{
+	struct symbol *sym = reloc->sym;
+	bool is_text = (sym->sec->sh.sh_flags & SHF_EXECINSTR);
+	unsigned long off;
+
+	if (sym->type != STT_SECTION)
+		return sym;
+
+	off = reloc->sym->offset;
+	if (reloc->type == R_X86_64_PC32 || reloc->type == R_X86_64_PLT32)
+		off += arch_dest_reloc_offset(reloc->addend);
+	else
+		off += reloc->addend;
+
+	if (is_text)
+		sym = find_func_containing(sym->sec, off);
+	else
+		sym = find_symbol_containing(sym->sec, off);
+
+	if (sym)
+		return sym;
+
+	return reloc->sym;
+}
+
 static int validate_ibt_insn(struct objtool_file *file, struct instruction *insn)
 {
 	struct instruction *dest;
-	struct reloc *reloc;
+	struct reloc *reloc, *first_reloc;
 	unsigned long off;
-	int warnings = 0;
+	int warnings = 0, i;
 
 	/*
 	 * Looking for function pointer load relocations.  Ignore
@@ -4342,11 +4373,38 @@ static int validate_ibt_insn(struct objtool_file *file, struct instruction *insn
 		break;
 	}
 
-	for (reloc = insn_reloc(file, insn);
+	for (reloc = insn_reloc(file, insn), i = 0;
 	     reloc;
 	     reloc = find_reloc_by_dest_range(file->elf, insn->sec,
 					      reloc->offset + 1,
-					      (insn->offset + insn->len) - (reloc->offset + 1))) {
+					      (insn->offset + insn->len) - (reloc->offset + 1)), i++) {
+
+		if (!insn->sec->ref) {
+			if (i == 0)
+				first_reloc = reloc;
+
+			if (!insn->sec->init) {
+				if (reloc->sym->sec->init) {
+					struct symbol *rsym = reloc_sym(reloc);
+					if (!insn->sym->warned && !rsym->warned) {
+						WARN_FUNC("disallowed reference to init symbol %s in non-init code",
+							  insn->sec, insn->offset, rsym->name);
+						insn->sym->warned = 1;
+						rsym->warned = 1;
+					}
+				}
+			} else if (i > 0) {
+				if (!first_reloc->sym->sec->init && reloc->sym->sec->init) {
+					struct symbol *first_rsym = reloc_sym(first_reloc);
+					if (!insn->sym->warned && !first_rsym->warned) {
+						WARN_FUNC("disallowed store of init symbol %s to non-init data %s",
+							  insn->sec, insn->offset, reloc_sym(reloc)->name, first_rsym->name);
+						insn->sym->warned = 1;
+						first_rsym->warned = 1;
+					}
+				}
+			}
+		}
 
 		/*
 		 * static_call_update() references the trampoline, which
@@ -4437,6 +4495,55 @@ static int validate_ibt_data_reloc(struct objtool_file *file,
 	return 1;
 }
 
+static char *sym_name(struct section *sec, unsigned long offset)
+{
+	bool is_text = (sec->sh.sh_flags & SHF_EXECINSTR);
+	struct symbol *sym;
+
+	if (is_text)
+		sym = find_func_containing(sec, offset);
+	else
+		sym = find_symbol_containing(sec, offset);
+
+	if (sym)
+		return sym->name;
+
+	return sec->name;
+}
+
+static int validate_init_data_reloc(struct objtool_file *file, struct section *sec, struct reloc *reloc)
+{
+	struct symbol *sym, *rsym;
+
+	if (!sec->init && !sec->ref && reloc->sym->sec->init) {
+		if (sec->warned &&
+		    strcmp(sec->name, ".data") &&
+		    strcmp(sec->name, ".rodata") &&
+		    strcmp(sec->name, ".data..ro_after_init"))
+			return 0;
+		sec->warned = 1;
+
+		sym = find_symbol_containing(sec, reloc->offset);
+		if (sym && sym->warned)
+			return 0;
+
+		rsym = reloc_sym(reloc);
+		if (rsym->warned)
+			return 0;
+
+		sec->warned = 1;
+		if (sym)
+			sym->warned = 1;
+		rsym->warned = 1;
+
+		WARN("disallowed reference to init symbol %s in non-init data %s at %s+0x%lx",
+		     rsym->name, sym_name(sec, reloc->offset), sec->name, reloc->offset);
+		return 1;
+	}
+
+	return 0;
+}
+
 /*
  * Validate IBT rules and remove used ENDBR instructions from the seal list.
  * Unused ENDBR instructions will be annotated for sealing (i.e., replaced with
@@ -4485,8 +4592,10 @@ static int validate_ibt(struct objtool_file *file)
 		    strstr(sec->name, "__patchable_function_entries"))
 			continue;
 
-		list_for_each_entry(reloc, &sec->reloc->reloc_list, list)
+		list_for_each_entry(reloc, &sec->reloc->reloc_list, list) {
 			warnings += validate_ibt_data_reloc(file, reloc);
+			warnings += validate_init_data_reloc(file, sec, reloc);
+		}
 	}
 
 	return warnings;
diff --git a/tools/objtool/include/objtool/elf.h b/tools/objtool/include/objtool/elf.h
index ad0024da262b..44daec92caa6 100644
--- a/tools/objtool/include/objtool/elf.h
+++ b/tools/objtool/include/objtool/elf.h
@@ -38,7 +38,7 @@ struct section {
 	Elf_Data *data;
 	char *name;
 	int idx;
-	bool changed, text, rodata, noinstr, init, truncate;
+	bool changed, text, rodata, noinstr, init, ref, truncate, warned;
 	struct reloc *reloc_data;
 };
 
@@ -61,6 +61,7 @@ struct symbol {
 	u8 return_thunk      : 1;
 	u8 fentry            : 1;
 	u8 profiling_func    : 1;
+	u8 warned            : 1;
 	struct list_head pv_target;
 	struct list_head reloc_list;
 };
