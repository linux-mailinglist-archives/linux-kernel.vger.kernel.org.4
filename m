Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3DC374EAEF
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 11:42:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbjGKJmA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 05:42:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjGKJl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 05:41:58 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8EEAA91
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 02:41:57 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7941F2B;
        Tue, 11 Jul 2023 02:42:39 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 083593F67D;
        Tue, 11 Jul 2023 02:41:55 -0700 (PDT)
Date:   Tue, 11 Jul 2023 10:41:53 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>
Subject: Re: [PATCH] KVM: arm64: Handle kvm_arm_init failure correctly in
 finalize_pkvm
Message-ID: <20230711094153.36b746snfds3cbr7@bogus>
References: <20230704193243.3300506-1-sudeep.holla@arm.com>
 <86fs5ux2sh.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86fs5ux2sh.wl-maz@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 11, 2023 at 09:36:46AM +0100, Marc Zyngier wrote:
> On Tue, 04 Jul 2023 20:32:43 +0100,
> Sudeep Holla <sudeep.holla@arm.com> wrote:
> > 
> > Currently there is no synchronisation between finalize_pkvm() and
> > kvm_arm_init() initcalls. The finalize_pkvm() proceeds happily even if
> > kvm_arm_init() fails resulting in the following warning on all the CPUs
> > and eventually a HYP panic:
> > 
> >   | kvm [1]: IPA Size Limit: 48 bits
> >   | kvm [1]: Failed to init hyp memory protection
> >   | kvm [1]: error initializing Hyp mode: -22
> >   |
> >   | <snip>
> >   |
> >   | WARNING: CPU: 0 PID: 0 at arch/arm64/kvm/pkvm.c:226 _kvm_host_prot_finalize+0x30/0x50
> >   | Modules linked in:
> >   | CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.4.0 #237
> >   | Hardware name: FVP Base RevC (DT)
> >   | pstate: 634020c5 (nZCv daIF +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
> >   | pc : _kvm_host_prot_finalize+0x30/0x50
> >   | lr : __flush_smp_call_function_queue+0xd8/0x230
> >   |
> >   | Call trace:
> >   |  _kvm_host_prot_finalize+0x3c/0x50
> >   |  on_each_cpu_cond_mask+0x3c/0x6c
> >   |  pkvm_drop_host_privileges+0x4c/0x78
> >   |  finalize_pkvm+0x3c/0x5c
> >   |  do_one_initcall+0xcc/0x240
> >   |  do_initcall_level+0x8c/0xac
> >   |  do_initcalls+0x54/0x94
> >   |  do_basic_setup+0x1c/0x28
> >   |  kernel_init_freeable+0x100/0x16c
> >   |  kernel_init+0x20/0x1a0
> >   |  ret_from_fork+0x10/0x20
> >   | Failed to finalize Hyp protection: -22
> >   |     dtb=fvp-base-revc.dtb
> >   | kvm [95]: nVHE hyp BUG at: arch/arm64/kvm/hyp/nvhe/mem_protect.c:540!
> >   | kvm [95]: nVHE call trace:
> >   | kvm [95]:  [<ffff800081052984>] __kvm_nvhe_hyp_panic+0xac/0xf8
> >   | kvm [95]:  [<ffff800081059644>] __kvm_nvhe_handle_host_mem_abort+0x1a0/0x2ac
> >   | kvm [95]:  [<ffff80008105511c>] __kvm_nvhe_handle_trap+0x4c/0x160
> >   | kvm [95]:  [<ffff8000810540fc>] __kvm_nvhe___skip_pauth_save+0x4/0x4
> >   | kvm [95]: ---[ end nVHE call trace ]---
> >   | kvm [95]: Hyp Offset: 0xfffe8db00ffa0000
> >   | Kernel panic - not syncing: HYP panic:
> >   | PS:a34023c9 PC:0000f250710b973c ESR:00000000f2000800
> >   | FAR:ffff000800cb00d0 HPFAR:000000000880cb00 PAR:0000000000000000
> >   | VCPU:0000000000000000
> >   | CPU: 3 PID: 95 Comm: kworker/u16:2 Tainted: G        W          6.4.0 #237
> >   | Hardware name: FVP Base RevC (DT)
> >   | Workqueue: rpciod rpc_async_schedule
> >   | Call trace:
> >   |  dump_backtrace+0xec/0x108
> >   |  show_stack+0x18/0x2c
> >   |  dump_stack_lvl+0x50/0x68
> >   |  dump_stack+0x18/0x24
> >   |  panic+0x138/0x33c
> >   |  nvhe_hyp_panic_handler+0x100/0x184
> >   |  new_slab+0x23c/0x54c
> >   |  ___slab_alloc+0x3e4/0x770
> >   |  kmem_cache_alloc_node+0x1f0/0x278
> >   |  __alloc_skb+0xdc/0x294
> >   |  tcp_stream_alloc_skb+0x2c/0xf0
> >   |  tcp_sendmsg_locked+0x3d0/0xda4
> >   |  tcp_sendmsg+0x38/0x5c
> >   |  inet_sendmsg+0x44/0x60
> >   |  sock_sendmsg+0x1c/0x34
> >   |  xprt_sock_sendmsg+0xdc/0x274
> >   |  xs_tcp_send_request+0x1ac/0x28c
> >   |  xprt_transmit+0xcc/0x300
> >   |  call_transmit+0x78/0x90
> >   |  __rpc_execute+0x114/0x3d8
> >   |  rpc_async_schedule+0x28/0x48
> >   |  process_one_work+0x1d8/0x314
> >   |  worker_thread+0x248/0x474
> >   |  kthread+0xfc/0x184
> >   |  ret_from_fork+0x10/0x20
> >   | SMP: stopping secondary CPUs
> >   | Kernel Offset: 0x57c5cb460000 from 0xffff800080000000
> >   | PHYS_OFFSET: 0x80000000
> >   | CPU features: 0x00000000,1035b7a3,ccfe773f
> >   | Memory Limit: none
> >   | ---[ end Kernel panic - not syncing: HYP panic:
> >   | PS:a34023c9 PC:0000f250710b973c ESR:00000000f2000800
> >   | FAR:ffff000800cb00d0 HPFAR:000000000880cb00 PAR:0000000000000000
> >   | VCPU:0000000000000000 ]---
> > 
> > Fix it by checking for the successfull initialisation of kvm_arm_init()
> > in finalize_pkvm() before proceeding any futher.
> > 
> > Fixes: 87727ba2bb05 ("KVM: arm64: Ensure CPU PMU probes before pKVM host de-privilege")
> > Cc: Will Deacon <will@kernel.org>
> > Cc: Marc Zyngier <maz@kernel.org>
> > Cc: Oliver Upton <oliver.upton@linux.dev>
> > Cc: James Morse <james.morse@arm.com>
> > Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> > Cc: Zenghui Yu <yuzenghui@huawei.com>
> > Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> 
> I really dislike the additional helper, but now that the capabilities
> are patched, I can't see another way to achieve this so:
>

Yes, I too don't like it and was almost tempted to post it as RFC, but then
I didn't want it to get ignored ;) as it a bug I hit on my setup with
mismatched FF-A version.

> Acked-by: Marc Zyngier <maz@kernel.org>
>

Thanks!

-- 
Regards,
Sudeep
