Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 654F874F89D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 22:01:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231454AbjGKUB3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 16:01:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231395AbjGKUB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 16:01:27 -0400
Received: from out-62.mta1.migadu.com (out-62.mta1.migadu.com [IPv6:2001:41d0:203:375::3e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB3AA10D2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 13:01:26 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1689105685;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HDm8x68ARVpO0YxOTdTpajZpNzbe/t0JXfpMESSJgsY=;
        b=qJOhbqMBrfn77QHzNqQzHCNpwGtXzLSaOL94loSqfIFoeGFrdMmTCrsIFaiaSDPtw5oMQ/
        3uK+Qdih8lOU2vsCO/mxAG84iOwGkGIdlK7NLW3FKycMYoBfIR2Q8gRllgWVw9S1omi2aY
        dWQuoGH16ooT/RCqNkFrrTyxvSgsgxs=
From:   Oliver Upton <oliver.upton@linux.dev>
To:     Sudeep Holla <sudeep.holla@arm.com>, linux-kernel@vger.kernel.org,
        kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Cc:     Oliver Upton <oliver.upton@linux.dev>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH] KVM: arm64: Handle kvm_arm_init failure correctly in finalize_pkvm
Date:   Tue, 11 Jul 2023 20:00:48 +0000
Message-ID: <168910562678.2605377.2888121955545772800.b4-ty@linux.dev>
In-Reply-To: <20230704193243.3300506-1-sudeep.holla@arm.com>
References: <20230704193243.3300506-1-sudeep.holla@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Jul 2023 20:32:43 +0100, Sudeep Holla wrote:
> Currently there is no synchronisation between finalize_pkvm() and
> kvm_arm_init() initcalls. The finalize_pkvm() proceeds happily even if
> kvm_arm_init() fails resulting in the following warning on all the CPUs
> and eventually a HYP panic:
> 
>   | kvm [1]: IPA Size Limit: 48 bits
>   | kvm [1]: Failed to init hyp memory protection
>   | kvm [1]: error initializing Hyp mode: -22
>   |
>   | <snip>
>   |
>   | WARNING: CPU: 0 PID: 0 at arch/arm64/kvm/pkvm.c:226 _kvm_host_prot_finalize+0x30/0x50
>   | Modules linked in:
>   | CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.4.0 #237
>   | Hardware name: FVP Base RevC (DT)
>   | pstate: 634020c5 (nZCv daIF +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
>   | pc : _kvm_host_prot_finalize+0x30/0x50
>   | lr : __flush_smp_call_function_queue+0xd8/0x230
>   |
>   | Call trace:
>   |  _kvm_host_prot_finalize+0x3c/0x50
>   |  on_each_cpu_cond_mask+0x3c/0x6c
>   |  pkvm_drop_host_privileges+0x4c/0x78
>   |  finalize_pkvm+0x3c/0x5c
>   |  do_one_initcall+0xcc/0x240
>   |  do_initcall_level+0x8c/0xac
>   |  do_initcalls+0x54/0x94
>   |  do_basic_setup+0x1c/0x28
>   |  kernel_init_freeable+0x100/0x16c
>   |  kernel_init+0x20/0x1a0
>   |  ret_from_fork+0x10/0x20
>   | Failed to finalize Hyp protection: -22
>   |     dtb=fvp-base-revc.dtb
>   | kvm [95]: nVHE hyp BUG at: arch/arm64/kvm/hyp/nvhe/mem_protect.c:540!
>   | kvm [95]: nVHE call trace:
>   | kvm [95]:  [<ffff800081052984>] __kvm_nvhe_hyp_panic+0xac/0xf8
>   | kvm [95]:  [<ffff800081059644>] __kvm_nvhe_handle_host_mem_abort+0x1a0/0x2ac
>   | kvm [95]:  [<ffff80008105511c>] __kvm_nvhe_handle_trap+0x4c/0x160
>   | kvm [95]:  [<ffff8000810540fc>] __kvm_nvhe___skip_pauth_save+0x4/0x4
>   | kvm [95]: ---[ end nVHE call trace ]---
>   | kvm [95]: Hyp Offset: 0xfffe8db00ffa0000
>   | Kernel panic - not syncing: HYP panic:
>   | PS:a34023c9 PC:0000f250710b973c ESR:00000000f2000800
>   | FAR:ffff000800cb00d0 HPFAR:000000000880cb00 PAR:0000000000000000
>   | VCPU:0000000000000000
>   | CPU: 3 PID: 95 Comm: kworker/u16:2 Tainted: G        W          6.4.0 #237
>   | Hardware name: FVP Base RevC (DT)
>   | Workqueue: rpciod rpc_async_schedule
>   | Call trace:
>   |  dump_backtrace+0xec/0x108
>   |  show_stack+0x18/0x2c
>   |  dump_stack_lvl+0x50/0x68
>   |  dump_stack+0x18/0x24
>   |  panic+0x138/0x33c
>   |  nvhe_hyp_panic_handler+0x100/0x184
>   |  new_slab+0x23c/0x54c
>   |  ___slab_alloc+0x3e4/0x770
>   |  kmem_cache_alloc_node+0x1f0/0x278
>   |  __alloc_skb+0xdc/0x294
>   |  tcp_stream_alloc_skb+0x2c/0xf0
>   |  tcp_sendmsg_locked+0x3d0/0xda4
>   |  tcp_sendmsg+0x38/0x5c
>   |  inet_sendmsg+0x44/0x60
>   |  sock_sendmsg+0x1c/0x34
>   |  xprt_sock_sendmsg+0xdc/0x274
>   |  xs_tcp_send_request+0x1ac/0x28c
>   |  xprt_transmit+0xcc/0x300
>   |  call_transmit+0x78/0x90
>   |  __rpc_execute+0x114/0x3d8
>   |  rpc_async_schedule+0x28/0x48
>   |  process_one_work+0x1d8/0x314
>   |  worker_thread+0x248/0x474
>   |  kthread+0xfc/0x184
>   |  ret_from_fork+0x10/0x20
>   | SMP: stopping secondary CPUs
>   | Kernel Offset: 0x57c5cb460000 from 0xffff800080000000
>   | PHYS_OFFSET: 0x80000000
>   | CPU features: 0x00000000,1035b7a3,ccfe773f
>   | Memory Limit: none
>   | ---[ end Kernel panic - not syncing: HYP panic:
>   | PS:a34023c9 PC:0000f250710b973c ESR:00000000f2000800
>   | FAR:ffff000800cb00d0 HPFAR:000000000880cb00 PAR:0000000000000000
>   | VCPU:0000000000000000 ]---
> 
> [...]

Applied to kvmarm/fixes, thanks!

[1/1] KVM: arm64: Handle kvm_arm_init failure correctly in finalize_pkvm
      https://git.kernel.org/kvmarm/kvmarm/c/fa729bc7c9c8

--
Best,
Oliver
