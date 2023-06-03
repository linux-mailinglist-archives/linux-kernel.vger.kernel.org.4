Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ADE47211BD
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jun 2023 21:15:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbjFCTO7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Jun 2023 15:14:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjFCTO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Jun 2023 15:14:57 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCF13180
        for <linux-kernel@vger.kernel.org>; Sat,  3 Jun 2023 12:14:56 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1685819693;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yJMZKGTX9Ox7TGvWExs002/sxlviB01HfhsSiQL0VZg=;
        b=pHKr1KMYSJkkISbq/whEkO+jWxr/jltkgDGqf6lpIiXda4UuC96PZhUmzlG2HQLHtTCtVw
        ySGUt4wueQPmCEL/bL6r9ga6qNushIdofo1TqTD5SJfRGI2mkKvUNGaOsPMxjTcY/OG/tR
        g3Xqvo5D0sQYBPs6GwtRXaQsWjep9DmLF2t8oImrHmqFuV9pqzTeAaleFzZFBfjKVgcjAH
        C8DLcY7PbcW4CWA+X8l2x1ccY2nr0WecE9Pr2F7X9YZs+W6vENh1mZTskYrnVA0HPQWhyx
        j77FewLTrwWpDKL6XHroxwTa1KlPh61pOv3FSpeeizAW/lZMZ6souRq3GK1+4A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1685819693;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yJMZKGTX9Ox7TGvWExs002/sxlviB01HfhsSiQL0VZg=;
        b=/UboU3b0zfKRNC0CyFQgFn3GYx4D880x8dCIhCAy4GmvhcDZmoMixvQJoIb4S2pJr0udLV
        9YX6hlVHX2XNXEBA==
To:     Palash Oswal <oswalpalash@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Subject: Re: KASAN: stack-out-of-bounds Read in __remove_hrtimer
In-Reply-To: <CAGyP=7dN6DYyCQJHyJ_74eakHAJDT3Xk77nZ5r8+qUPLENeo2A@mail.gmail.com>
References: <CAGyP=7dN6DYyCQJHyJ_74eakHAJDT3Xk77nZ5r8+qUPLENeo2A@mail.gmail.com>
Date:   Sat, 03 Jun 2023 21:14:53 +0200
Message-ID: <87r0qs8ij6.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 03 2023 at 02:42, Palash Oswal wrote:
> Hello,
> I found the following issue using syzkaller with enriched corpus[1] on:
> HEAD commit : 0bcc4025550403ae28d2984bddacafbca0a2f112
> git tree: linux
> C Reproducer : I do not have a C reproducer yet. I will update this
> thread when I get one.
> Kernel .config :
> https://gist.github.com/oswalpalash/d9580b0bfce202b37445fa5fd426e41f

That's not really helpful without knowing which compiler version.

> ==================================================================
> BUG: KASAN: stack-out-of-bounds in __remove_hrtimer+0x250/0x2a0

Can you please enable full decoding so it looks like this:

BUG: KASAN: stack-out-of-bounds in i801_isr_byte_done drivers/i2c/busses/i2c-i801.c:546 [inline]
BUG: KASAN: stack-out-of-bounds in i801_isr drivers/i2c/busses/i2c-i801.c:613 [inline]

and the stack trace has the proper line number decoding too.

> Read of size 1 at addr ffffc9000358fdd0 by task swapper/0/0
>
> CPU: 0 PID: 0 Comm: swapper/0 Not tainted
> 6.3.0-rc6-pasta-00035-g0bcc40255504 #1
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
> 1.13.0-1ubuntu1.1 04/01/2014
> Call Trace:
>  <IRQ>
>  dump_stack_lvl+0xd9/0x150
>  print_address_description.constprop.0+0x2c/0x3c0
>  kasan_report+0x11c/0x130
>  __remove_hrtimer+0x250/0x2a0
>  __hrtimer_run_queues+0x4e0/0xbe0
>  hrtimer_interrupt+0x320/0x7b0
>  __sysvec_apic_timer_interrupt+0x14a/0x430
>  sysvec_apic_timer_interrupt+0x92/0xc0
>  </IRQ>
>  <TASK>
>  asm_sysvec_apic_timer_interrupt+0x1a/0x20
> RIP: 0010:default_idle+0xf/0x20
> Code: 89 07 49 c7 c0 08 00 00 00 4d 29 c8 4c 01 c7 4c 29 c2 e9 76 ff
> ff ff cc cc cc cc f3 0f 1e fa eb 07 0f 00 2d 13 38 49 00 fb f4 <fa> c3
> 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 f3 0f 1e fa 65

Please don't wrap the output.

Also where is the RIP/Code/Register dump for the faulting context?

This one is the interrupted task context which is completely uninteresting.

> RSP: 0018:ffffffff8c407e30 EFLAGS: 00000202
> RAX: 000000000033b773 RBX: 0000000000000000 RCX: ffffffff89fd3ef5
> RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
> RBP: ffffffff8c495800 R08: 0000000000000001 R09: ffff888063a36cab
> R10: ffffed100c746d95 R11: 0000000000000000 R12: fffffbfff1892b00
> R13: 0000000000000000 R14: ffffffff8e769510 R15: 0000000000000000
>  default_idle_call+0x67/0xa0
>
> do_idle+0x31e/0x3e0
>
>                                                              [31/73]

Interesting output. Can you please reconrd the full console output and
provide a link to it so that we can look at the complete info and not at
something which was trimmed by some tool?
> ----------------
> Code disassembly (best guess):
>    0:   89 07                   mov    %eax,(%rdi)
>    2:   49 c7 c0 08 00 00 00    mov    $0x8,%r8
>    9:   4d 29 c8                sub    %r9,%r8
>    c:   4c 01 c7                add    %r8,%rdi
>    f:   4c 29 c2                sub    %r8,%rdx
>   12:   e9 76 ff ff ff          jmpq   0xffffff8d
>   17:   cc                      int3
>   18:   cc                      int3
>   19:   cc                      int3
>   1a:   cc                      int3
>   1b:   f3 0f 1e fa             endbr64
>   1f:   eb 07                   jmp    0x28
>   21:   0f 00 2d 13 38 49 00    verw   0x493813(%rip)        # 0x49383b
>   28:   fb                      sti
>   29:   f4                      hlt
> * 2a:   fa                      cli <-- trapping instruction

That's useless because thats the disassembly of idle() which got
interrupted.

Thanks,

        tglx
