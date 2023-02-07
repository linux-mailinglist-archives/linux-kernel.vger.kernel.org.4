Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D9AB68DDBE
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 17:17:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232493AbjBGQRQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 11:17:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232008AbjBGQRN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 11:17:13 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CC2961B5
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 08:17:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=D/595zd2bwLI9Ts3OQDjIrZJ9SVnpkY9w35ikK9E30g=; b=ljOSH63kWzbB/osxS2fz4+b73F
        Ay4Mp7L9gWdQ4SK7ep3+LQPb0h4uRg027gS8245X2wQbs5N0W4kNETyGZSWpp8mmoXEak3jxKqCxB
        bur5w4yL6p2Aq0Cj2rOdNYI4P9T2tZLPW0i+0OOmA8KcKy1pR1Ew4/kSqaNIv5RxF2VYRyK2dGC2w
        TNp3zWcgbsNr5//tM2q3hDdHb8xyf9nmKOwEuWa8DGVyf9RbOpn0YfENQ7tu5vD3RqLPbD/ss9Hv/
        sGsl59eXv9ZK6zwcIFfL5BCkCrVvrpeHMvRFULuN4ei4ypJw1Kg65rWCLL7l3FlUpIwh1tUUVsg8b
        0gm/B3Fw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pPQeS-000N8Y-R1; Tue, 07 Feb 2023 16:17:01 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 41B5930013F;
        Tue,  7 Feb 2023 17:16:59 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 073C620AF917C; Tue,  7 Feb 2023 17:16:59 +0100 (CET)
Date:   Tue, 7 Feb 2023 17:16:58 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: current objtool warnings from randconfig builds
Message-ID: <Y+J5ev/R/Sz6nwBF@hirez.programming.kicks-ass.net>
References: <9698eff1-9680-4f0a-94de-590eaa923e94@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9698eff1-9680-4f0a-94de-590eaa923e94@app.fastmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 07, 2023 at 11:25:27AM +0100, Arnd Bergmann wrote:
> Hi Josh and Peter,
> 
> I've updated my randconfig test setup to use gcc-13 and clang-16, and
> have sent fixes for all normal WERROR=y build warnings, but there are a
> lot of objtool warnings that remain. I've reported some of them in
> the past, some others are new. It would be nice to at least reduce
> the number of warnings either through code changes or workarounds
> in objtool for any false positives.
> 
> Out of 1500 builds, about a third had any warnings, this is the full
> list sorted by frequency. Let me know if there are any that you haven't
> seen before, I can provide the corresponding object and config files
> for reproducing.
> 
>     Arnd
> 
> 8<---
> 205 mm/kasan/shadow.o: warning: objtool: __asan_memset+0x2e: call to __memset() with UACCESS enabled
> 205 mm/kasan/shadow.o: warning: objtool: __asan_memmove+0x48: call to __memmove() with UACCESS enabled
> 205 mm/kasan/shadow.o: warning: objtool: __asan_memcpy+0x48: call to __memcpy() with UACCESS enabled

Patch pending here:

  https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit/?h=sched/core-robot&id=79cdfdacd5b8d1ac77e24ccbc178bba0294d0d78
￼

> 80 vmlinux.o: warning: objtool: ibt_selftest+0x11: sibling call from callable instruction with modified stack frame

Can you provide details on how to reproduce this?

> 49 vmlinux.o: warning: objtool: lkdtm_UNSET_SMEP+0x100: relocation to !ENDBR: native_write_cr4+0x4

That one was on purpose I think.

> 29 mm/kasan/generic.o: warning: objtool: kasan_check_range+0x1e: call to addr_has_metadata() with UACCESS enabled
> 29 mm/kasan/generic.o: warning: objtool: __asan_load2+0x11: call to addr_has_metadata() with UACCESS enabled

I'm thinking addr_has_metadata() needs the __always_inline treatment, it
seems to be present a lot.

> 28 mm/kasan/generic.o: warning: objtool: __asan_store16+0x11: call to addr_has_metadata() with UACCESS enabled
> 28 mm/kasan/generic.o: warning: objtool: __asan_load16+0x11: call to addr_has_metadata() with UACCESS enabled
> 22 mm/kasan/generic.o: warning: objtool: __asan_load4+0x11: call to addr_has_metadata() with UACCESS enabled
> 21 mm/kasan/generic.o: warning: objtool: __asan_store4+0x11: call to addr_has_metadata() with UACCESS enabled
> 21 mm/kasan/generic.o: warning: objtool: __asan_store1+0x11: call to addr_has_metadata() with UACCESS enabled
> 21 mm/kasan/generic.o: warning: objtool: __asan_load8+0x11: call to addr_has_metadata() with UACCESS enabled
> 21 mm/kasan/generic.o: warning: objtool: __asan_load1+0x11: call to addr_has_metadata() with UACCESS enabled

> 29 drivers/gpu/drm/vmwgfx/vmwgfx_msg.o: warning: objtool: vmw_port_hb_out+0x15e: return with modified stack frame
> 29 drivers/gpu/drm/vmwgfx/vmwgfx_msg.o: warning: objtool: vmw_port_hb_out+0x11d: stack state mismatch: cfa1=5+16 cfa2=4+8
> 29 drivers/gpu/drm/vmwgfx/vmwgfx_msg.o: warning: objtool: vmw_port_hb_in+0x150: return with modified stack frame
> 29 drivers/gpu/drm/vmwgfx/vmwgfx_msg.o: warning: objtool: vmw_port_hb_in+0x13d: stack state mismatch: cfa1=5+16 cfa2=4+8
> 29 drivers/gpu/drm/vmwgfx/vmwgfx.o: warning: objtool: vmw_port_hb_out+0xe2: return with modified stack frame
> 29 drivers/gpu/drm/vmwgfx/vmwgfx.o: warning: objtool: vmw_port_hb_out+0xd1: stack state mismatch: cfa1=5+16 cfa2=4+8
> 29 drivers/gpu/drm/vmwgfx/vmwgfx.o: warning: objtool: vmw_port_hb_in+0xea: return with modified stack frame
> 29 drivers/gpu/drm/vmwgfx/vmwgfx.o: warning: objtool: vmw_port_hb_in+0xcc: stack state mismatch: cfa1=5+16 cfa2=4+8

Repro details?

> 18 fs/reiserfs/reiserfs.o: warning: objtool: balance_internal+0x1238: stack state mismatch: cfa1=4+248 cfa2=4+256
> 18 fs/reiserfs/ibalance.o: warning: objtool: balance_internal+0x10a2: stack state mismatch: cfa1=4+232 cfa2=4+256
> 17 arch/x86/coco/tdx/tdcall.o: warning: objtool: __tdx_hypercall+0xb0: return with modified stack frame

Fix on list somewhere..

> 15 vmlinux.o: warning: objtool: ftrace_likely_update+0xd2: call to __stack_chk_fail() with UACCESS enabled
> 15 kernel/trace/trace_branch.o: warning: objtool: ftrace_likely_update+0x201: call to __stack_chk_fail() with UACCESS enabled

-EWONTFIX, TRACE_BRANCH_PROFILING is fundamentally incompatible with
lots of things.

> 14 mm/kasan/generic.o: warning: objtool: __asan_store2+0x11: call to addr_has_metadata() with UACCESS enabled
> 13 mm/kasan/generic.o: warning: objtool: __asan_store8+0x11: call to addr_has_metadata() with UACCESS enabled

> 14 arch/x86/kvm/kvm.o: warning: objtool: .text+0x0: unreachable instruction

details?

> 11 vmlinux.o: warning: objtool: replace_key+0x1b2: stack state mismatch: cfa1=4+72 cfa2=4+88
> 8 vmlinux.o: warning: objtool: set_ftrace_ops_ro+0x49: relocation to !ENDBR: kgdb_ll_trap+0x6a
> 8 vmlinux.o: warning: objtool: set_ftrace_ops_ro+0x28: relocation to !ENDBR: kgdb_arch_late+0x193
> 8 vmlinux.o: warning: objtool: set_ftrace_ops_ro+0x23: relocation to !ENDBR: kexec_mark_range+0x13
> 8 vmlinux.o: warning: objtool: set_ftrace_ops_ro+0x23: relocation to !ENDBR: kexec_mark_crashkres+0x53
> 8 vmlinux.o: warning: objtool: set_ftrace_ops_ro+0x23: relocation to !ENDBR: .text+0x4b314
> 8 drivers/media/platform/qcom/camss/qcom-camss.o: warning: objtool: csiphy_lanes_enable() falls through to next function __cfi_csiphy_hw_version_read()
> 8 drivers/media/platform/qcom/camss/camss-csiphy-3ph-1-0.o: warning: objtool: csiphy_lanes_enable() falls through to next function __cfi_csiphy_get_lane_mask()
> 7 vmlinux.o: warning: objtool: internal_move_pointers_items+0x3fa: stack state mismatch: cfa1=4+144 cfa2=4+136
> 7 fs/jffs2/jffs2.o: warning: objtool: jffs2_erase_pending_blocks() falls through to next function jffs2_free_jeb_node_refs()
> 7 fs/jffs2/erase.o: warning: objtool: jffs2_erase_pending_blocks() falls through to next function __cfi_jffs2_free_jeb_node_refs()
> 7 drivers/hwmon/pmbus/adm1275.o: warning: objtool: adm1275_probe+0x574: unreachable instruction
> 5 vmlinux.o: warning: objtool: exynos3250_cmu_isp_probe+0x17: unreachable instruction
> 5 arch/x86/mm/fault.o: warning: objtool: do_user_addr_fault+0x2c0: unreachable instruction
> 5 arch/x86/kvm/kvm-amd.o: warning: objtool: __svm_vcpu_run+0x141: BP used as a scratch register
> 5 arch/x86/kvm/kvm-amd.o: warning: objtool: __svm_sev_es_vcpu_run+0x36: BP used as a scratch register
> 4 vmlinux.o: warning: objtool: resume_play_dead+0xe: unreachable instruction
> 4 vmlinux.o: warning: objtool: hyperv_init+0x55c: unreachable instruction
> 4 vmlinux.o: warning: objtool: do_idle+0x15e: unreachable instruction
> 4 drivers/media/i2c/m5mols/m5mols_core.o: warning: objtool: m5mols_set_fmt() falls through to next function __cfi_m5mols_get_frame_desc()
> 3 vmlinux.o: warning: objtool: nmi_panic+0x2d: unreachable instruction
> 3 vmlinux.o: warning: objtool: mptscsih_abort+0x319: unreachable instruction
> 3 vmlinux.o: warning: objtool: internal_delete_pointers_items+0x392: stack state mismatch: cfa1=4+136 cfa2=4+144
> 3 vmlinux.o: warning: objtool: emulate_vsyscall+0x1ff: unreachable instruction
> 3 vmlinux.o: warning: objtool: do_arch_prctl_64+0x1ac: unreachable instruction
> 3 fs/xfs/libxfs/xfs_da_btree.o: warning: objtool: xfs_da_grow_inode_int+0x397: stack state mismatch: reg1[12]=-2-48 reg2[12]=-1+0
> 3 drivers/spi/spi-amd.o: warning: objtool: amd_spi_master_transfer() falls through to next function __cfi_amd_spi_max_transfer_size()
> 3 drivers/pwm/pwm-mediatek.o: warning: objtool: .text: unexpected end of section
> 3 drivers/gpu/drm/i915/gt/intel_timeline.o: warning: objtool: live_hwsp_read+0x318: stack state mismatch: cfa1=4+240 cfa2=5+48
> 3 arch/x86/entry/entry_64.o: warning: objtool: .entry.text+0xba7: unreachable instruction
> 2 vmlinux.o: warning: objtool: xenpv_exc_double_fault+0x9: unreachable instruction
> 2 vmlinux.o: warning: objtool: pwm_mediatek_apply() falls through to next function mtk_disp_pwm_probe()
> 2 vmlinux.o: warning: objtool: force_ibs_eilvt_setup+0xad: unreachable instruction
> 2 vmlinux.o: warning: objtool: exynos7885_cmu_probe+0x1b: unreachable instruction
> 2 vmlinux.o: warning: objtool: do_one_initcall+0x1f6: unreachable instruction

> 2 mm/kmsan/report.o: warning: objtool: kmsan_report+0x0: call to __fentry__() with UACCESS enabled

mm/kasan/Makefil:CFLAGS_REMOVE_report.o = $(CC_FLAGS_FTRACE)

How?!?!
￼

> 2 mm/kmsan/instrumentation.o: warning: objtool: __msan_warning+0x0: call to __fentry__() with UACCESS enabled
> 2 mm/kmsan/instrumentation.o: warning: objtool: __msan_poison_alloca+0x0: call to __fentry__() with UACCESS enabled
> 2 mm/kmsan/instrumentation.o: warning: objtool: __msan_metadata_ptr_for_store_n+0x0: call to __fentry__() with UACCESS enabled
> 2 mm/kmsan/instrumentation.o: warning: objtool: __msan_metadata_ptr_for_store_8+0x0: call to __fentry__() with UACCESS enabled
> 2 mm/kmsan/instrumentation.o: warning: objtool: __msan_metadata_ptr_for_store_4+0x0: call to __fentry__() with UACCESS enabled
> 2 mm/kmsan/instrumentation.o: warning: objtool: __msan_metadata_ptr_for_store_2+0x0: call to __fentry__() with UACCESS enabled
> 2 mm/kmsan/instrumentation.o: warning: objtool: __msan_metadata_ptr_for_store_1+0x0: call to __fentry__() with UACCESS enabled
> 2 mm/kmsan/instrumentation.o: warning: objtool: __msan_metadata_ptr_for_load_n+0x0: call to __fentry__() with UACCESS enabled
> 2 mm/kmsan/instrumentation.o: warning: objtool: __msan_metadata_ptr_for_load_8+0x0: call to __fentry__() with UACCESS enabled
> 2 mm/kmsan/instrumentation.o: warning: objtool: __msan_metadata_ptr_for_load_4+0x0: call to __fentry__() with UACCESS enabled
> 2 mm/kmsan/instrumentation.o: warning: objtool: __msan_metadata_ptr_for_load_2+0x0: call to __fentry__() with UACCESS enabled
> 2 mm/kmsan/instrumentation.o: warning: objtool: __msan_metadata_ptr_for_load_1+0x0: call to __fentry__() with UACCESS enabled
> 2 mm/kmsan/instrumentation.o: warning: objtool: __msan_instrument_asm_store+0x0: call to __fentry__() with UACCESS enabled
> 2 mm/kmsan/instrumentation.o: warning: objtool: __msan_get_context_state+0x0: call to __fentry__() with UACCESS enabled
> 2 mm/kmsan/instrumentation.o: warning: objtool: __msan_chain_origin+0x0: call to __fentry__() with UACCESS enabled
> 2 mm/kmsan/hooks.o: warning: objtool: kmsan_unpoison_memory+0x0: call to __fentry__() with UACCESS enabled
> 2 mm/kmsan/hooks.o: warning: objtool: kmsan_unpoison_entry_regs+0x0: call to __fentry__() with UACCESS enabled
> 2 mm/kmsan/hooks.o: warning: objtool: kmsan_copy_to_user+0x0: call to __fentry__() with UACCESS enabled

Something seems to be going badly wrong there... notrace is being lost.


