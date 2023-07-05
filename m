Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03F6F74893F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 18:29:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232915AbjGEQ3X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 12:29:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231408AbjGEQ3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 12:29:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F39C810EA
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 09:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688574515;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=j6FM5HuBYumhlI3iVlRzFNWVY/RjkHo+Q4G46cjp5hs=;
        b=KCqmrU1+OPOQLYcmEscZWxH7FsQ2HHTZqors1W1Y4KPoOf6GqwXnlg+WFLTTDO3EtA5uSN
        yvi9IXosc1IxWDJdmo9BPmHCqsV+LNC8jrnmUp0sWmY+mKKjee8LhAiRaBwwuowmZmA2y8
        Vy9pruStOnFEXx3XdLl9YpVGnV99QZs=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-91-aEqzftOrMVmMdpCsvvCQBQ-1; Wed, 05 Jul 2023 12:28:32 -0400
X-MC-Unique: aEqzftOrMVmMdpCsvvCQBQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4DF8C38294A4;
        Wed,  5 Jul 2023 16:28:31 +0000 (UTC)
Received: from localhost (unknown [10.42.28.237])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 153961121314;
        Wed,  5 Jul 2023 16:28:30 +0000 (UTC)
Date:   Wed, 5 Jul 2023 17:28:30 +0100
From:   "Richard W.M. Jones" <rjones@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Richard Henderson <richard.henderson@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Daniel =?iso-8859-1?Q?D=EDaz?= <daniel.diaz@linaro.org>,
        Benjamin Copeland <ben.copeland@linaro.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: qemu-x86_64 booting with 8.0.0 stil see int3: when running LTP
 tracing testing.
Message-ID: <20230705162830.GC17440@redhat.com>
References: <CA+G9fYsETJQm0Ue7hGsb+nbsiMikwycOV3V0DPr6WC2r61KRBQ@mail.gmail.com>
 <2d7595b1-b655-4425-85d3-423801bce644@app.fastmail.com>
 <20230621160655.GL2053369@hirez.programming.kicks-ass.net>
 <20230704074620.GA17440@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230704074620.GA17440@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
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

On Tue, Jul 04, 2023 at 08:46:20AM +0100, Richard W.M. Jones wrote:
> We have been having the same sort of problem
> (https://bugzilla.redhat.com/show_bug.cgi?id=2216496).  It's another
> of those bugs that requires hundreds or thousands of boot iterations
> before you can see it.  There is a test in comment 27 but it requires
> guestfish and some hacking to work.  I'll try to come up with a
> cleaner test later.
> 
> We see stack traces like:
> 
> [    3.081939] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
> [    3.082266] clocksource: Switched to clocksource acpi_pm
> [    3.090201] NET: Registered PF_INET protocol family
> [    3.093098] int3: 0000 [#1] PREEMPT SMP NOPTI
> [    3.093098] CPU: 3 PID: 1 Comm: swapper/0 Not tainted 6.4.0-10173-ga901a3568fd2 #8
> [    3.093098] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.2-0-gea1b7a073390-prebuilt.qemu.org 04/01/2014
> [    3.093098] RIP: 0010:__mod_timer+0x1c3/0x370
> [    3.093098] Code: 00 00 41 bd ff ff ff ff 31 d2 4c 89 f6 4c 89 ff e8 f2 ef ff ff 41 89 c4 85 c0 75 09 83 e3 01 0f 85 54 ff ff ff 41 8b 4f 20 66 <90> f7 c1 00 00 10 00 0f 84 23 01 00 00 48 c7 c3 40 cc 01 00 65 48
> [    3.093098] RSP: 0018:ffffaf1600013e00 EFLAGS: 00000046
> [    3.093098] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000280003
> [    3.093098] RDX: 0000000000000000 RSI: ffff9aa90fd9dec0 RDI: ffffffff8441e4b8
> [    3.093098] RBP: 00000000fffc200d R08: ffffffff8441e4a0 R09: ffffffff8441e4b8
> [    3.093098] R10: 0000000000000001 R11: 000000000002e990 R12: 0000000000000000
> [    3.093098] R13: 00000000ffffffff R14: ffff9aa90fd9dec0 R15: ffffffff8441e4b8
> [    3.093098] FS:  0000000000000000(0000) GS:ffff9aa90fd80000(0000) knlGS:0000000000000000
> [    3.093098] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    3.093098] CR2: 0000000000000000 CR3: 000000004e02e000 CR4: 0000000000750ee0
> [    3.093098] PKRU: 55555554
> [    3.093098] Call Trace:
> [    3.093098]  <TASK>
> [    3.093098]  ? die+0x31/0x80
> [    3.093098]  ? exc_int3+0x10e/0x120
> [    3.093098]  ? asm_exc_int3+0x39/0x40
> [    3.093098]  ? __mod_timer+0x1c3/0x370
> [    3.093098]  ? __mod_timer+0x1c3/0x370
> [    3.093098]  queue_delayed_work_on+0x23/0x30
> [    3.093098]  neigh_table_init+0x1bb/0x2e0
> [    3.093098]  arp_init+0x12/0x50
> [    3.093098]  inet_init+0x15b/0x2f0
> [    3.093098]  ? __pfx_inet_init+0x10/0x10
> [    3.093098]  do_one_initcall+0x58/0x230
> [    3.093098]  kernel_init_freeable+0x199/0x2d0
> [    3.093098]  ? __pfx_kernel_init+0x10/0x10
> [    3.093098]  kernel_init+0x15/0x1b0
> [    3.093098]  ret_from_fork+0x2c/0x50
> [    3.093098]  </TASK>
> [    3.093098] Modules linked in:
> [    3.093098] ---[ end trace 0000000000000000 ]---
> [    3.093098] RIP: 0010:__mod_timer+0x1c3/0x370
> [    3.093098] Code: 00 00 41 bd ff ff ff ff 31 d2 4c 89 f6 4c 89 ff e8 f2 ef ff ff 41 89 c4 85 c0 75 09 83 e3 01 0f 85 54 ff ff ff 41 8b 4f 20 66 <90> f7 c1 00 00 10 00 0f 84 23 01 00 00 48 c7 c3 40 cc 01 00 65 48
> [    3.093098] RSP: 0018:ffffaf1600013e00 EFLAGS: 00000046
> [    3.093098] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000280003
> [    3.093098] RDX: 0000000000000000 RSI: ffff9aa90fd9dec0 RDI: ffffffff8441e4b8
> [    3.093098] RBP: 00000000fffc200d R08: ffffffff8441e4a0 R09: ffffffff8441e4b8
> [    3.093098] R10: 0000000000000001 R11: 000000000002e990 R12: 0000000000000000
> [    3.093098] R13: 00000000ffffffff R14: ffff9aa90fd9dec0 R15: ffffffff8441e4b8
> [    3.093098] FS:  0000000000000000(0000) GS:ffff9aa90fd80000(0000) knlGS:0000000000000000
> [    3.093098] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    3.093098] CR2: 0000000000000000 CR3: 000000004e02e000 CR4: 0000000000750ee0
> [    3.093098] PKRU: 55555554
> [    3.093098] Kernel panic - not syncing: Fatal exception in interrupt
> 
> There are many variations, but the common pattern seems to be
> <something in the clock or timer code> -> int3 exception
> 
> It only happens under qemu TCG (software emulation).
> 
> It goes away if we recompile qemu without MTTCG support.
> 
> It only happens with -smp enabled, we are using qemu -smp 4
> 
> We are using qemu-system-x86_64 full system emulation on x86_64 host
> (ie. forcing KVM off).
> 
> It happens with the latest upstream kernel and qemu, compiled from
> source.

I got a bit further on this one.

The bug happens in the code that updates the static branch used for at
least these two keys:

  static DEFINE_STATIC_KEY_FALSE(__sched_clock_stable);
  DEFINE_STATIC_KEY_FALSE(timers_migration_enabled);

There are probably others (it seems a generic problem with how static
branches are handled by TCG), but I only see the bug for those two.

When the static branch is updated we end up calling
arch/x86/kernel/alternative.c:text_poke_bp_batch().  It's best to read
the description of that function to see where int3 is used:

  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/x86/kernel/alternative.c#n2086

I modified the qemu TCG int3 helper so it dumps the code at %rip when
the interrupt fires, and I can actually see the changes in the above
function happen, first int3 being written, then the end of the nop,
then the int3 being overwritten with the first byte of the nop.

Unfortunately the int3 still fires after the code has been completely
rewritten to its final (ie nop) value.

This seems to indicate to me that neither the self-write to the kernel
text segment, nor sync_core (implemented by a "iret to self" trick)
invalidates the qemu TCG translation block containing the old int3
helper call.  Thus we (qemu) never "see" the new nop, we keep
emulating int3, and that causes the kernel to crash.

I added print statements inside tb_invalidate_phys_page() and this
function seems never to be called at all.  It's my understanding that
at least the kernel writing to its text segment ought to cause
tb_invalidate_phys_page() to be called, but I'm not super-familiar
with this qemu code.

Richard Henderson - do you have any suggestions?

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
libguestfs lets you edit virtual machines.  Supports shell scripting,
bindings from many languages.  http://libguestfs.org

