Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3BFB746B03
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 09:47:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231639AbjGDHrd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 03:47:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231359AbjGDHrM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 03:47:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75752170A
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 00:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688456787;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FQ2r6QjsjK05cM18O2vwPvtoR0JkrbCVAkonYT36Uko=;
        b=Avbyaqp9lq3r45m8mmiDR5w7OmkNwEJKrw/LYPqtYQ8e+8s9RR/GJObXYfqM93CnibWh0J
        eaep6z0Uq4HR7nCC3qBO/DT+Ebrp33UtY6EunmKlviUGNxwhUQidzf343fobhHKJFHiydF
        /vdEfki9xAeeQ22yF3TyFG5oLeKriJo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-637-a-0n31C2N3u1cdnZZi9Jsg-1; Tue, 04 Jul 2023 03:46:22 -0400
X-MC-Unique: a-0n31C2N3u1cdnZZi9Jsg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7162A186E127;
        Tue,  4 Jul 2023 07:46:21 +0000 (UTC)
Received: from localhost (unknown [10.42.28.237])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1BA0CC00049;
        Tue,  4 Jul 2023 07:46:21 +0000 (UTC)
Date:   Tue, 4 Jul 2023 08:46:20 +0100
From:   "Richard W.M. Jones" <rjones@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Daniel =?iso-8859-1?Q?D=EDaz?= <daniel.diaz@linaro.org>,
        Benjamin Copeland <ben.copeland@linaro.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Richard Henderson <richard.henderson@linaro.org>
Subject: Re: qemu-x86_64 booting with 8.0.0 stil see int3: when running LTP
 tracing testing.
Message-ID: <20230704074620.GA17440@redhat.com>
References: <CA+G9fYsETJQm0Ue7hGsb+nbsiMikwycOV3V0DPr6WC2r61KRBQ@mail.gmail.com>
 <2d7595b1-b655-4425-85d3-423801bce644@app.fastmail.com>
 <20230621160655.GL2053369@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230621160655.GL2053369@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2023 at 06:06:55PM +0200, Peter Zijlstra wrote:
> On Wed, Jun 21, 2023 at 05:31:15PM +0200, Arnd Bergmann wrote:
> 
> > I don't know much about x86 exception handling, but my guess is
> > that this is where the stack overflows, so this backtrace
> > is not all that useful. Looking at the full log from your link,
> > I see that recursion through asm_exc_int3:
> > 
> > <4>[   49.886694]  ? exc_int3+0x62/0x80
> > <4>[   49.886714]  ? asm_exc_int3+0x3e/0x50
> > <4>[   49.886759]  ? preempt_count_sub+0x5/0x80
> > <4>[   49.886783]  ? preempt_count_sub+0x5/0x80
> > <4>[   49.886805]  ? irq_work_queue+0x40/0x80
> > <4>[   49.886826]  ? defer_console_output+0x49/0x80
> > <4>[   49.886840]  ? vprintk+0x42/0x60
> > <4>[   49.886857]  ? _printk+0x5d/0x80
> > <4>[   49.886891]  ? die+0x9c/0xe0
> > <4>[   49.886922]  ? exc_int3+0x62/0x80
> > <4>[   49.886942]  ? asm_exc_int3+0x3e/0x50
> 
> So this is exc_int3(), but it is past poke_int3_handler() which is the
> counter-part of text_poke_bp_batch() -- die() seems to suggest we're
> even past do_int3().
> 
> The fact that it continued past poke_int3_handler() suggests that it is
> a 'stray' int3, not covered by an active text modification site.
> 
> > <4>[   49.886966]  ? __pfx_tick_sched_timer+0x10/0x10
> > <4>[   49.886980]  ? __pfx_read_tsc+0x10/0x10
> > <4>[   49.887010]  ? preempt_count_sub+0x5/0x80
> > <4>[   49.887035]  ? preempt_count_sub+0x5/0x80
> > <4>[   49.887057]  ? __hrtimer_run_queues+0xee/0x330
> > <4>[   49.887070]  ? _raw_spin_unlock_irqrestore+0x28/0x50
> > <4>[   49.887085]  ? __hrtimer_run_queues+0xee/0x330
> > <4>[   49.887136]  ? hrtimer_interrupt+0xf6/0x390
> > <4>[   49.887167]  ? __sysvec_apic_timer_interrupt+0x64/0x1a0
> > <4>[   49.887189]  ? sysvec_apic_timer_interrupt+0x7a/0x90
> > <4>[   49.887206]  </IRQ>
> > <4>[   49.887219]  <TASK>
> > <4>[   49.887231]  ? asm_sysvec_apic_timer_interrupt+0x1f/0x30
> > <4>[   49.887252]  ? sched_rt_period_timer+0x4/0x390
> > <4>[   49.887272]  ? __pfx_do_sync_core+0x10/0x10
> > <4>[   49.887305]  ? insn_get_displacement+0x9/0x160
> > <4>[   49.887329]  ? insn_get_displacement+0x9/0x160
> > <4>[   49.887344]  ? insn_get_immediate+0xd2/0x270
> > <4>[   49.887365]  ? insn_decode+0x113/0x150
> > <4>[   49.887384]  ? text_poke_loc_init+0xea/0x220
> > <4>[   49.887429]  ? sched_rt_period_timer+0x4/0x390
> > <4>[   49.887451]  ? text_poke_queue+0x89/0xa0
> 
> This is the text_poke_queue() stage, it is still collecting sites to
> poke but hasn't actually started yet. The actual poking happens in
> text_poke_bp_batch(), which isn't in the call-chain afaict.
> 
> > <4>[   49.887477]  ? ftrace_replace_code+0x149/0x1f0
> > <4>[   49.887508]  ? ftrace_modify_all_code+0x71/0x140
> > <4>[   49.887533]  ? arch_ftrace_update_code+0xd/0x20
> > <4>[   49.887550]  ? ftrace_shutdown+0xf5/0x220
> > <4>[   49.887577]  ? unregister_ftrace_function+0x2e/0x150
> > <4>[   49.887608]  ? stack_trace_sysctl+0x82/0xb0
> > <4>[   49.887636]  ? proc_sys_call_handler+0x18b/0x280
> > <4>[   49.887675]  ? proc_sys_write+0x17/0x20
> > <4>[   49.887692]  ? vfs_write+0x324/0x3f0
> > <4>[   49.887742]  ? ksys_write+0x75/0xe0
> > <4>[   49.887771]  ? __x64_sys_write+0x1f/0x30
> > <4>[   49.887787]  ? do_syscall_64+0x48/0xa0
> > <4>[   49.887802]  ? sysvec_apic_timer_interrupt+0x4d/0x90
> > <4>[   49.887822]  ? entry_SYSCALL_64_after_hwframe+0x6e/0xd8
> > <4>[   49.887878]  </TASK>

Did anything happen with this bug later?  I see nothing on any public
list, nor any public bug tracker.

We have been having the same sort of problem
(https://bugzilla.redhat.com/show_bug.cgi?id=2216496).  It's another
of those bugs that requires hundreds or thousands of boot iterations
before you can see it.  There is a test in comment 27 but it requires
guestfish and some hacking to work.  I'll try to come up with a
cleaner test later.

We see stack traces like:

[    3.081939] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    3.082266] clocksource: Switched to clocksource acpi_pm
[    3.090201] NET: Registered PF_INET protocol family
[    3.093098] int3: 0000 [#1] PREEMPT SMP NOPTI
[    3.093098] CPU: 3 PID: 1 Comm: swapper/0 Not tainted 6.4.0-10173-ga901a3568fd2 #8
[    3.093098] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.2-0-gea1b7a073390-prebuilt.qemu.org 04/01/2014
[    3.093098] RIP: 0010:__mod_timer+0x1c3/0x370
[    3.093098] Code: 00 00 41 bd ff ff ff ff 31 d2 4c 89 f6 4c 89 ff e8 f2 ef ff ff 41 89 c4 85 c0 75 09 83 e3 01 0f 85 54 ff ff ff 41 8b 4f 20 66 <90> f7 c1 00 00 10 00 0f 84 23 01 00 00 48 c7 c3 40 cc 01 00 65 48
[    3.093098] RSP: 0018:ffffaf1600013e00 EFLAGS: 00000046
[    3.093098] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000280003
[    3.093098] RDX: 0000000000000000 RSI: ffff9aa90fd9dec0 RDI: ffffffff8441e4b8
[    3.093098] RBP: 00000000fffc200d R08: ffffffff8441e4a0 R09: ffffffff8441e4b8
[    3.093098] R10: 0000000000000001 R11: 000000000002e990 R12: 0000000000000000
[    3.093098] R13: 00000000ffffffff R14: ffff9aa90fd9dec0 R15: ffffffff8441e4b8
[    3.093098] FS:  0000000000000000(0000) GS:ffff9aa90fd80000(0000) knlGS:0000000000000000
[    3.093098] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    3.093098] CR2: 0000000000000000 CR3: 000000004e02e000 CR4: 0000000000750ee0
[    3.093098] PKRU: 55555554
[    3.093098] Call Trace:
[    3.093098]  <TASK>
[    3.093098]  ? die+0x31/0x80
[    3.093098]  ? exc_int3+0x10e/0x120
[    3.093098]  ? asm_exc_int3+0x39/0x40
[    3.093098]  ? __mod_timer+0x1c3/0x370
[    3.093098]  ? __mod_timer+0x1c3/0x370
[    3.093098]  queue_delayed_work_on+0x23/0x30
[    3.093098]  neigh_table_init+0x1bb/0x2e0
[    3.093098]  arp_init+0x12/0x50
[    3.093098]  inet_init+0x15b/0x2f0
[    3.093098]  ? __pfx_inet_init+0x10/0x10
[    3.093098]  do_one_initcall+0x58/0x230
[    3.093098]  kernel_init_freeable+0x199/0x2d0
[    3.093098]  ? __pfx_kernel_init+0x10/0x10
[    3.093098]  kernel_init+0x15/0x1b0
[    3.093098]  ret_from_fork+0x2c/0x50
[    3.093098]  </TASK>
[    3.093098] Modules linked in:
[    3.093098] ---[ end trace 0000000000000000 ]---
[    3.093098] RIP: 0010:__mod_timer+0x1c3/0x370
[    3.093098] Code: 00 00 41 bd ff ff ff ff 31 d2 4c 89 f6 4c 89 ff e8 f2 ef ff ff 41 89 c4 85 c0 75 09 83 e3 01 0f 85 54 ff ff ff 41 8b 4f 20 66 <90> f7 c1 00 00 10 00 0f 84 23 01 00 00 48 c7 c3 40 cc 01 00 65 48
[    3.093098] RSP: 0018:ffffaf1600013e00 EFLAGS: 00000046
[    3.093098] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000280003
[    3.093098] RDX: 0000000000000000 RSI: ffff9aa90fd9dec0 RDI: ffffffff8441e4b8
[    3.093098] RBP: 00000000fffc200d R08: ffffffff8441e4a0 R09: ffffffff8441e4b8
[    3.093098] R10: 0000000000000001 R11: 000000000002e990 R12: 0000000000000000
[    3.093098] R13: 00000000ffffffff R14: ffff9aa90fd9dec0 R15: ffffffff8441e4b8
[    3.093098] FS:  0000000000000000(0000) GS:ffff9aa90fd80000(0000) knlGS:0000000000000000
[    3.093098] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    3.093098] CR2: 0000000000000000 CR3: 000000004e02e000 CR4: 0000000000750ee0
[    3.093098] PKRU: 55555554
[    3.093098] Kernel panic - not syncing: Fatal exception in interrupt

There are many variations, but the common pattern seems to be
<something in the clock or timer code> -> int3 exception

It only happens under qemu TCG (software emulation).

It goes away if we recompile qemu without MTTCG support.

It only happens with -smp enabled, we are using qemu -smp 4

We are using qemu-system-x86_64 full system emulation on x86_64 host
(ie. forcing KVM off).

It happens with the latest upstream kernel and qemu, compiled from
source.

I'd love to have a better way to debug this or collect more
diagnostics if you have any suggestions.

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
virt-builder quickly builds VMs from scratch
http://libguestfs.org/virt-builder.1.html

