Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2621972B738
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 07:16:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234026AbjFLFQn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 01:16:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232246AbjFLFQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 01:16:40 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77CEA107
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jun 2023 22:16:39 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-65311774e52so2963380b3a.3
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jun 2023 22:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20221208.gappssmtp.com; s=20221208; t=1686546999; x=1689138999;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4+PE8Ae399X3HYXbtTvK/AUs8qH8Yfu5G/e5XpXLgGk=;
        b=GBHx3EF9UEksNtV/kFP/1k9oy+sTjGtgHcNUkGpAHHFVPpBP5CIlhx5Vc07QKt8u0C
         ztzvimJ4ucVBLDdl/1AcgLi5i7u68mlS7m/pU1G//CIGRxe3ODQ6mNNEO3ZUCxbadet4
         0MPIx18WrqB89UBV8iDddBnK7/LB5Uy0rzXZ+ObKWPijuPASS+7+/MdlFjDLDXYX9mGw
         PDuxUv850r7c5PCf8b82ClM9HKKKIG20jfI5W6CfZNcRo+yWuDjeLvAPk3JQF6fKXYKB
         ao6GxUa8xYymk0oO0H2M6htQKw2e+Q+VynEb9ik5Bu6V9f76raRsTU7g5nTYWKCsieRi
         yMjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686546999; x=1689138999;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4+PE8Ae399X3HYXbtTvK/AUs8qH8Yfu5G/e5XpXLgGk=;
        b=j+7tk0Z8XzPRcCPkzTyAFEYLyKX9Y46m0JzCFvHY0xj0viM1Br9wiCzmaaog4ZzuCE
         VW14gnpLiL5MoDHBfWLYWPI9dKo+dysAfpn3a/Y8hmyxJuEOuELD2hToKuX6fiCWIYor
         jsaLWAuld/M69eXGTLmveEl4dONrI4xUsvJFG8Su+b/JZV6PP9/OENz7pi8pNKtGE9y8
         p2XmuUY/AB+DOrSw8yZBd8G0DRyXbbwUOqL4ifMN+gGO1tIn+UWDIS/PqrOciT0HyNHy
         L135e+o/7VMTjgVQqAYlYb1UwknJbbwTweOu3AEkcJLoXdiRxwjBsXX5XulPjytLDvqo
         BORg==
X-Gm-Message-State: AC+VfDzWQ12UIbbix2dfZehJUavrezatZBzisHzVWp1WttseXrRJXGi3
        zojMUAc5swngNVdUnms7PuudTg==
X-Google-Smtp-Source: ACHHUZ63PvqLQJcBz2BrqB4Epylw6lIn2gm/lww8XNZKWdne28k4pzK5cKdUAezhWHDuMs3zqni6Sg==
X-Received: by 2002:a05:6a21:3414:b0:10b:97c8:2e15 with SMTP id yn20-20020a056a21341400b0010b97c82e15mr7816191pzb.45.1686546998871;
        Sun, 11 Jun 2023 22:16:38 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-79-151.pa.nsw.optusnet.com.au. [49.179.79.151])
        by smtp.gmail.com with ESMTPSA id jo5-20020a170903054500b001addf547a6esm7203419plb.17.2023.06.11.22.16.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jun 2023 22:16:38 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1q8Zus-00AkpZ-1v;
        Mon, 12 Jun 2023 15:16:34 +1000
Date:   Mon, 12 Jun 2023 15:16:34 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        Zorro Lang <zlang@redhat.com>, linux-xfs@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Mike Christie <michael.christie@oracle.com>,
        "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [6.5-rc5 regression] core dump hangs (was Re: [Bug report]
 fstests generic/051 (on xfs) hang on latest linux v6.5-rc5+)
Message-ID: <ZIaqMpGISWKgHLK6@dread.disaster.area>
References: <20230611124836.whfktwaumnefm5z5@zlang-mailbox>
 <ZIZSPyzReZkGBEFy@dread.disaster.area>
 <20230612015145.GA11441@frogsfrogsfrogs>
 <ZIaBQnCKJ6NsqGhd@dread.disaster.area>
 <CAHk-=whJqZLKPR-cpX-V4wJTXVX-_tG5Vjuj2q9knvKGCPdfkg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=whJqZLKPR-cpX-V4wJTXVX-_tG5Vjuj2q9knvKGCPdfkg@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 11, 2023 at 08:14:25PM -0700, Linus Torvalds wrote:
> On Sun, Jun 11, 2023 at 7:22 PM Dave Chinner <david@fromorbit.com> wrote:
> >
> > I guess the regression fix needs a regression fix....
> 
> Yup.
> 
> From the description of the problem, it sounds like this happens on
> real hardware, no vhost anywhere?
>
> Or maybe Darrick (who doesn't see the issue) is running on raw
> hardware, and you and Zorro are running in a virtual environment?

I'm testing inside VMs and seeing it, I can't speak for anyone else.

....

> So *maybe* this attached patch might fix it? I haven't thought very
> deeply about this, but vhost workers most definitely shouldn't call
> do_coredump(), since they are then not counted.
> 
> (And again, I think we should just check that PF_IO_WORKER bit, not
> use this more complex test, but that's a separate and bigger change).
> 
>               Linus

>  kernel/signal.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/kernel/signal.c b/kernel/signal.c
> index 2547fa73bde5..a1e11ee8537c 100644
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -2847,6 +2847,10 @@ bool get_signal(struct ksignal *ksig)
>  		 */
>  		current->flags |= PF_SIGNALED;
>  
> +		/* vhost workers don't participate in core dups */
> +		if ((current->flags & (PF_IO_WORKER | PF_USER_WORKER)) != PF_USER_WORKER)
> +			goto out;
> +
>  		if (sig_kernel_coredump(signr)) {
>  			if (print_fatal_signals)
>  				print_fatal_signal(ksig->info.si_signo);


That would appear to make things worse. mkfs.xfs hung in Z state on
exit and never returned to the shell. Also, multiple processes are
livelocked like this:

 Sending NMI from CPU 0 to CPUs 1-3:
 NMI backtrace for cpu 2
 CPU: 2 PID: 3409 Comm: pmlogger_farm Not tainted 6.4.0-rc5-dgc+ #1822
 Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
 RIP: 0010:uprobe_deny_signal+0x5/0x90
 Code: 48 c7 c1 c4 64 62 82 48 c7 c7 d1 64 62 82 e8 b2 39 ec ff e9 70 ff ff ff 66 66 2e 0f 1f 84 00 00 00 00 00 66 90 0f 1f 44 00 00 <55> 31 4
 RSP: 0018:ffffc900023abdf0 EFLAGS: 00000202
 RAX: 0000000000000004 RBX: ffff888103b127c0 RCX: 0000000000000000
 RDX: 0000000000000000 RSI: 0000000000000296 RDI: ffffc900023abe70
 RBP: ffffc900023abe60 R08: 0000000000000001 R09: 0000000000000001
 R10: 0000000000000000 R11: ffff88813bd2ccf0 R12: ffff888103b127c0
 R13: ffffc900023abe70 R14: ffff888110413700 R15: ffff888103d26e80
 FS:  00007f35497a4740(0000) GS:ffff88813bd00000(0000) knlGS:0000000000000000
 CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
 CR2: 00007ffd4ca0ce80 CR3: 000000010f7d1000 CR4: 00000000000006e0
 Call Trace:
  <NMI>
  ? show_regs+0x61/0x70
  ? nmi_cpu_backtrace+0x88/0xf0
  ? nmi_cpu_backtrace_handler+0x11/0x20
  ? nmi_handle+0x57/0x150
  ? default_do_nmi+0x49/0x240
  ? exc_nmi+0xf4/0x110
  ? end_repeat_nmi+0x16/0x31
  ? uprobe_deny_signal+0x5/0x90
  ? uprobe_deny_signal+0x5/0x90
  ? uprobe_deny_signal+0x5/0x90
  </NMI>
  <TASK>
  ? get_signal+0x94/0x9b0
  ? signal_setup_done+0x66/0x190
  arch_do_signal_or_restart+0x2f/0x260
  exit_to_user_mode_prepare+0x181/0x1c0
  syscall_exit_to_user_mode+0x16/0x40
  do_syscall_64+0x40/0x80
  entry_SYSCALL_64_after_hwframe+0x63/0xcd
 RIP: 0023:0xffff888103b127c0
 Code: Unable to access opcode bytes at 0xffff888103b12796.
 RSP: 002b:00007ffd4ca0d0ac EFLAGS: 00000202 ORIG_RAX: 000000000000003d
 RAX: 0000000000000009 RBX: 0000000000000000 RCX: 0000000000000000
 RDX: 0000000000000000 RSI: 00007ffd4d20bb9c RDI: 00000000ffffffff
 RBP: 00007ffd4d20bb9c R08: 0000000000000002 R09: 0000000000000000
 R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000000
 R13: 00007ffd4d20bba0 R14: 00005604571fc380 R15: 0000000000000001
  </TASK>
 NMI backtrace for cpu 3
 CPU: 3 PID: 3526 Comm: pmlogger_check Not tainted 6.4.0-rc5-dgc+ #1822
 Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
 RIP: 0010:fixup_exception+0x72/0x260
 Code: 14 0f 87 03 02 00 00 ff 24 d5 98 67 22 82 31 c0 5b 41 5c 41 5d 41 5e 41 5f 5d c3 41 81 cd 00 00 00 40 4d 63 ed 4d 89 6c 24 50 <31> c0 9
 RSP: 0018:ffffc9000275bb58 EFLAGS: 00000083
 RAX: 000000000000000f RBX: ffffffff827d0a4c RCX: ffffffff810c5f95
 RDX: 000000000000000f RSI: ffffffff827d0a4c RDI: ffffc9000275bb28
 RBP: ffffc9000275bb80 R08: 0000000000000000 R09: 0000000000000000
 R10: 0000000000000000 R11: 0000000000000000 R12: ffffc9000275bc78
 R13: 000000000000000e R14: 000000008f5ded3f R15: 0000000000000000
 FS:  00007f56a36de740(0000) GS:ffff88813bd80000(0000) knlGS:0000000000000000
 CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
 CR2: 000000008f5ded3f CR3: 000000010dcde000 CR4: 00000000000006e0
 Call Trace:
  <NMI>
  ? show_regs+0x61/0x70
  ? nmi_cpu_backtrace+0x88/0xf0
  ? nmi_cpu_backtrace_handler+0x11/0x20
  ? nmi_handle+0x57/0x150
  ? default_do_nmi+0x49/0x240
  ? exc_nmi+0xf4/0x110
  ? end_repeat_nmi+0x16/0x31
  ? copy_fpstate_to_sigframe+0x1c5/0x3a0
  ? fixup_exception+0x72/0x260
  ? fixup_exception+0x72/0x260
  ? fixup_exception+0x72/0x260
  </NMI>
  <TASK>
  kernelmode_fixup_or_oops+0x49/0x120
  __bad_area_nosemaphore+0x15a/0x230
  ? __bad_area+0x57/0x80
  bad_area_nosemaphore+0x16/0x20
  exc_page_fault+0x323/0x880
  asm_exc_page_fault+0x27/0x30
 RIP: 0010:copy_fpstate_to_sigframe+0x1c5/0x3a0
 Code: 45 89 bc 24 40 25 00 00 f0 41 80 64 24 01 bf e9 f5 fe ff ff be 3c 00 00 00 48 c7 c7 77 9c 5f 82 e8 00 2a 23 00 31 c0 0f 1f 00 <49> 0f 1
 RSP: 0018:ffffc9000275bd28 EFLAGS: 00010246
 RAX: 000000000000000e RBX: 000000008f5de7ec RCX: ffffc9000275bda8
 RDX: 000000008f5ded40 RSI: 000000000000003c RDI: ffffffff825f9c77
 RBP: ffffc9000275bd98 R08: ffffc9000275be30 R09: 0000000000000001
 R10: 0000000000000000 R11: ffffc90000138ff8 R12: ffff8881106527c0
 R13: 000000008f5deb40 R14: ffff888110654d40 R15: ffff88810a653f40
  ? copy_fpstate_to_sigframe+0x1c0/0x3a0
  ? __might_sleep+0x42/0x70
  get_sigframe+0xcd/0x2b0
  ia32_setup_frame+0x61/0x230
  arch_do_signal_or_restart+0x1d1/0x260
  exit_to_user_mode_prepare+0x181/0x1c0
  irqentry_exit_to_user_mode+0x9/0x30
  irqentry_exit+0x33/0x40
  exc_page_fault+0x1b6/0x880
  asm_exc_page_fault+0x27/0x30
 RIP: 0023:0x106527c0
 Code: Unable to access opcode bytes at 0x10652796.
 RSP: 002b:000000008f5ded6c EFLAGS: 00010202
 RAX: 000000000000000b RBX: 0000000000000000 RCX: 0000000000000000
 RDX: 0000000000000000 RSI: 00007ffd8f5df2ec RDI: 00000000ffffffff
 RBP: 00007ffd8f5df2ec R08: 0000000000000000 R09: 00005558962eb526
 R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000000
 R13: 00007ffd8f5df2f0 R14: 00005558962b5e60 R15: 0000000000000001
  </TASK>


Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
