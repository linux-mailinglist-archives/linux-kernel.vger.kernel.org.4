Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C1336605C5
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 18:38:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235605AbjAFRik (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 12:38:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbjAFRiW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 12:38:22 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CA607D9DB
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 09:38:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D8AF661ED7
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 17:38:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96A55C433EF;
        Fri,  6 Jan 2023 17:38:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673026700;
        bh=mVSb5WJNxb9CkrZLtlHqaTe+bEMhYwT0ZS0NE5kngJo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oPb9v8shkRWv2aUHwslq3X46cvS6dY8A7pPkMe1YRMrZjY+zzg1ecLol0MIE9yNAf
         J3EHogP5Z1HsWN5sNhF4uy7H4vGSQgMVfs8OrFhpp8GbzxgAbmqSEZ8WxqPEY4jxIE
         wyL5CXat6/M1HL9GflD3J6JcyU98X1n4XgVxM58N67CEg2L8KoyQlLZCmolEZWgAYL
         3tFbUJ2eush/oWAfFtvDpb5Pho1roN5bhmFIeWxMMnSoVvL1V31ryaGWJZux6N//H1
         6tbSJzqaJzyNdVEvmA+cYBeaqJLZ/78wDWiTAioAjy2soPiaL4R7U9TpD0nhmaeTbj
         n7mLWABL6ft8g==
Date:   Fri, 6 Jan 2023 17:38:15 +0000
From:   Will Deacon <will@kernel.org>
To:     Anders Roxell <anders.roxell@linaro.org>
Cc:     catalin.marinas@arm.com, mark.rutland@arm.com, james.morse@arm.com,
        ebiederm@xmission.com, elver@google.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        arnd@arndb.de
Subject: Re: BUG: KCSAN: data-race in do_page_fault /
 spectre_v4_enable_task_mitigation
Message-ID: <20230106173814.GA5169@willie-the-truck>
References: <20221221145436.GF69385@mutt>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221221145436.GF69385@mutt>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 21, 2022 at 03:54:36PM +0100, Anders Roxell wrote:
> Hey,
> 
> I'm building an allmodconfig kernel on yesterdays linux-next (tag:
> next-20221220) and I see a
> "BUG: KCSAN: data-race in do_page_fault / spectre_v4_enable_task_mitigation"
> when I boot up in QEMU. I ran the output via
> scripts/decode_stacktrace.sh and this is what I see:
> 
> 
> [ 2105.261121][  T154] ==================================================================
> [ 2105.266067][  T154] BUG: KCSAN: data-race in do_page_fault / spectre_v4_enable_task_mitigation
> [ 2105.271577][  T154] 
> [ 2105.273121][  T154] write to 0xffff8000210b3fb8 of 8 bytes by task 136 on cpu 0:
> [ 2105.277743][ T154] spectre_v4_enable_task_mitigation (/home/anders/src/kernel/next/arch/arm64/kernel/proton-pack.c:651 /home/anders/src/kernel/next/arch/arm64/kernel/proton-pack.c:664) 
> [ 2105.281802][ T154] __switch_to (/home/anders/src/kernel/next/arch/arm64/kernel/process.c:459 /home/anders/src/kernel/next/arch/arm64/kernel/process.c:532) 
> [ 2105.284670][ T154] __schedule (/home/anders/src/kernel/next/kernel/sched/core.c:5247 /home/anders/src/kernel/next/kernel/sched/core.c:6555) 
> [ 2105.287555][ T154] preempt_schedule_irq (/home/anders/src/kernel/next/arch/arm64/include/asm/irqflags.h:70 /home/anders/src/kernel/next/arch/arm64/include/asm/irqflags.h:98 /home/anders/src/kernel/next/kernel/sched/core.c:6868) 
> [ 2105.290857][ T154] arm64_preempt_schedule_irq (/home/anders/src/kernel/next/arch/arm64/kernel/entry-common.c:237) 
> [ 2105.294433][ T154] el1_interrupt (/home/anders/src/kernel/next/arch/arm64/kernel/entry-common.c:476 /home/anders/src/kernel/next/arch/arm64/kernel/entry-common.c:486) 
> [ 2105.297433][ T154] el1h_64_irq_handler (/home/anders/src/kernel/next/arch/arm64/kernel/entry-common.c:492) 
> [ 2105.300718][ T154] el1h_64_irq (/home/anders/src/kernel/next/arch/arm64/kernel/entry.S:580) 
> [ 2105.303497][ T154] arch_local_irq_restore (/home/anders/src/kernel/next/arch/arm64/include/asm/jump_label.h:21 /home/anders/src/kernel/next/arch/arm64/include/asm/irqflags.h:130) 
> [ 2105.306750][ T154] fs_reclaim_acquire (/home/anders/src/kernel/next/mm/page_alloc.c:4691) 
> [ 2105.310118][ T154] slab_pre_alloc_hook.constprop.0 (/home/anders/src/kernel/next/include/linux/sched/mm.h:272 /home/anders/src/kernel/next/mm/slab.h:720) 
> [ 2105.313966][ T154] slab_alloc_node.isra.0 (/home/anders/src/kernel/next/mm/slub.c:3434) 
> [ 2105.317343][ T154] __kmem_cache_alloc_lru (/home/anders/src/kernel/next/mm/slub.c:3469) 
> [ 2105.320659][ T154] kmem_cache_alloc (/home/anders/src/kernel/next/mm/slub.c:3477) 
> [ 2105.323673][ T154] getname_flags (/home/anders/src/kernel/next/fs/namei.c:139) 
> [ 2105.326703][ T154] getname (/home/anders/src/kernel/next/fs/namei.c:218) 
> [ 2105.329377][ T154] do_sys_openat2 (/home/anders/src/kernel/next/fs/open.c:1304) 
> [ 2105.332352][ T154] __arm64_sys_openat (/home/anders/src/kernel/next/fs/open.c:1326) 
> [ 2105.335573][ T154] el0_svc_common.constprop.0 (/home/anders/src/kernel/next/arch/arm64/kernel/syscall.c:38 /home/anders/src/kernel/next/arch/arm64/kernel/syscall.c:52 /home/anders/src/kernel/next/arch/arm64/kernel/syscall.c:142) 
> [ 2105.339272][ T154] do_el0_svc (/home/anders/src/kernel/next/arch/arm64/kernel/syscall.c:197) 
> [ 2105.342025][ T154] el0_svc (/home/anders/src/kernel/next/arch/arm64/kernel/entry-common.c:133 /home/anders/src/kernel/next/arch/arm64/kernel/entry-common.c:142 /home/anders/src/kernel/next/arch/arm64/kernel/entry-common.c:638) 
> [ 2105.344687][ T154] el0t_64_sync_handler (/home/anders/src/kernel/next/arch/arm64/kernel/entry-common.c:656) 
> [ 2105.348089][ T154] el0t_64_sync (/home/anders/src/kernel/next/arch/arm64/kernel/entry.S:584) 
> [ 2105.350998][  T154] 
> [ 2105.352567][  T154] read to 0xffff8000210b3fb8 of 8 bytes by task 154 on cpu 0:
> [ 2105.357117][ T154] do_page_fault (/home/anders/src/kernel/next/arch/arm64/mm/fault.c:517 /home/anders/src/kernel/next/arch/arm64/mm/fault.c:558) 
> [ 2105.360110][ T154] do_translation_fault (/home/anders/src/kernel/next/arch/arm64/mm/fault.c:695) 
> [ 2105.363400][ T154] do_mem_abort (/home/anders/src/kernel/next/arch/arm64/mm/fault.c:831) 
> [ 2105.366400][ T154] el0_ia (/home/anders/src/kernel/next/arch/arm64/kernel/entry-common.c:133 /home/anders/src/kernel/next/arch/arm64/kernel/entry-common.c:142 /home/anders/src/kernel/next/arch/arm64/kernel/entry-common.c:534) 
> [ 2105.369059][ T154] el0t_64_sync_handler (/home/anders/src/kernel/next/arch/arm64/kernel/entry-common.c:662) 
> [ 2105.372445][ T154] el0t_64_sync (/home/anders/src/kernel/next/arch/arm64/kernel/entry.S:584) 
> [ 2105.375404][  T154] 
> [ 2105.376935][  T154] no locks held by systemd/154.
> [ 2105.379935][  T154] irq event stamp: 385
> [ 2105.382448][ T154] hardirqs last enabled at (385): local_daif_restore (/home/anders/src/kernel/next/arch/arm64/include/asm/daifflags.h:71 (discriminator 1)) 
> [ 2105.388413][ T154] hardirqs last disabled at (384): el0t_64_sync_handler (/home/anders/src/kernel/next/arch/arm64/kernel/entry-common.c:662) 
> [ 2105.394436][ T154] softirqs last enabled at (352): fpsimd_restore_current_state (/home/anders/src/kernel/next/arch/arm64/kernel/fpsimd.c:264 /home/anders/src/kernel/next/arch/arm64/kernel/fpsimd.c:1780) 
> [ 2105.400932][ T154] softirqs last disabled at (350): fpsimd_restore_current_state (/home/anders/src/kernel/next/include/linux/bottom_half.h:20 /home/anders/src/kernel/next/arch/arm64/kernel/fpsimd.c:242 /home/anders/src/kernel/next/arch/arm64/kernel/fpsimd.c:1773) 
> [ 2105.407394][  T154] 
> [ 2105.408909][  T154] value changed: 0x0000000060000000 -> 0x0000000060001000
> [ 2105.413225][  T154] 
> [ 2105.414746][  T154] Reported by Kernel Concurrency Sanitizer on:
> [ 2105.426169][  T154] Hardware name: linux,dummy-virt (DT)
> [ 2105.429528][  T154] ==================================================================
> 
> 
> The prctl case, which only gets called on 'current'. However, assuming
> the kernel could be preempted while accessing current->pt_regs->pstate,
> and then it races against the task switch.
> 
> Any idea what happens and how to fix it?

I can't quite decipher this against mainline, as the line numbers above in
do_page_fault() seem to correlate with reads of the esr, which is either
a register or a stack read. I also think everything in the stacktraces
is running in the context of 'current', so I can't see how we could really
race here.

:/

Will
