Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE1666953DC
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 23:28:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbjBMW2t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 17:28:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbjBMW2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 17:28:47 -0500
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABA441CF62
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 14:28:45 -0800 (PST)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-5258f66721bso183525627b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 14:28:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=77aHWmqeltWzPkpHcVxRXfxRpIBnLXEzOMQwSrNfg4g=;
        b=QSIyG63fzLxzXhd1RUQhyraNJdbNzM7PIzYSpLTSac2B/cnCRKRmTSF8DRH+0FNs5u
         oTIgUnc8+kAbX4pqUahnKO5dbJvV60DL8B2OiQ6UpdAfvTTEnUjR974HHKaIFcTZTDV7
         aovhZUAyDM8/rFJkDEuHr9oUmQM9h1nwl8RvuNT9nEXILVhjbUl5qpl7LN52e7nJ8dKj
         5ZiX/Z1XyYkicsuBMgdLVPsY5CWfALd3IQ2RdZoWWSDYfcjQO0NQw/AKK24tC5RmjgS2
         WYgIpxtuX3oD3tiDMIABjNOiKWkBbG0a7+1crJxEWUwiW8BjU7Uz3yeNVKEtCspve9b0
         umPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=77aHWmqeltWzPkpHcVxRXfxRpIBnLXEzOMQwSrNfg4g=;
        b=N48BDFgy2BFW+77bg1++SgSefEqWCgo8cK10dkllaU+vXgKadOAflWqV55OeCdB3+h
         wDZ/vUg6ZYru193KWR/vQD5UUqVpSZV0Zv4CondkLVytIcehphjyhUhLtsfvltoZRv4k
         f5x/bWH88Tb4BUiXmap849Uu9C75dwmmi1NjOnAAaR73Du8ZXyHC0kz9kcqc083jSla6
         kU7vuASF9KLQwkA51hgbXlDsH86nbnLeqKplJTcHWvfgoVQoHDPi6UkZTq4PCuPbibbr
         wM9KbAuB8Rstk+oNYHRYsVZftvbpBn45BWnAZ2WZLri1J5A1eRNx8TK8ZMyZXWOnrTt5
         tKPw==
X-Gm-Message-State: AO0yUKXoObEUHXYzYPh0Pj0EB9xLbTAtt2laZ2aeY4HSAMScS0EYMOCi
        Nqe0ku8gHMj9b/XGfdut1W8a8R88zHzg75HOxM7/rRbzUu00lzw=
X-Google-Smtp-Source: AK7set857KfR9TxPOSYFd4ghqgd5yB5TOLqxHI5nmQuarx5nHE9aHjCOAM0c++qL7EaXYapLYqzLxII/t7fuGqd9XMQ=
X-Received: by 2002:a0d:eb01:0:b0:52e:ea72:1a48 with SMTP id
 u1-20020a0deb01000000b0052eea721a48mr1276947ywe.368.1676327324797; Mon, 13
 Feb 2023 14:28:44 -0800 (PST)
MIME-Version: 1.0
References: <0000000000006ac93505f42dda96@google.com> <87k00q1no2.ffs@tglx>
In-Reply-To: <87k00q1no2.ffs@tglx>
From:   John Stultz <jstultz@google.com>
Date:   Mon, 13 Feb 2023 14:28:33 -0800
Message-ID: <CANDhNCpua2g-jFRn-qK_yxck+_6m3Le1Dywh6A5zNj1qRhMeUw@mail.gmail.com>
Subject: Re: [syzbot] INFO: rcu detected stall in ext4_file_write_iter (6)
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     syzbot <syzbot+b9564ba6e8e00694511b@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, sboyd@kernel.org,
        syzkaller-bugs@googlegroups.com,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Oleg Nesterov <oleg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 9, 2023 at 2:25 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Wed, Feb 08 2023 at 02:37, syzbot wrote:
> > syzbot found the following issue on:
> >
> > HEAD commit:    4fafd96910ad Add linux-next specific files for 20230203
> > git tree:       linux-next
> > console+strace: https://syzkaller.appspot.com/x/log.txt?x=17005023480000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=1d2fba7d42502ca4
> > dashboard link: https://syzkaller.appspot.com/bug?extid=b9564ba6e8e00694511b
> > compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=110c6175480000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15ef5ad9480000
> >
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/348cc2da441a/disk-4fafd969.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/e2dedc500f12/vmlinux-4fafd969.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/fae710d9ebd8/bzImage-4fafd969.xz
>
> <SNIP>
>
> > NMI backtrace for cpu 0
> > Call Trace:
> >  <IRQ>
> >  trace_alarmtimer_fired include/trace/events/alarmtimer.h:73 [inline]
> >  alarmtimer_fired+0x327/0x670 kernel/time/alarmtimer.c:220
> >  __run_hrtimer kernel/time/hrtimer.c:1685 [inline]
> >  __hrtimer_run_queues+0x600/0xcf0 kernel/time/hrtimer.c:1749
> >  hrtimer_interrupt+0x320/0x7b0 kernel/time/hrtimer.c:1811
> >  local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1096 [inline]
> >  __sysvec_apic_timer_interrupt+0x180/0x660 arch/x86/kernel/apic/apic.c:1113
> >  sysvec_apic_timer_interrupt+0x92/0xc0 arch/x86/kernel/apic/apic.c:1107
> >  </IRQ>
> >  <TASK>
> >  asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:645
>
> Looking at the reproducer:
>
>   *(uint64_t*)0x2006b000 = 0;
>   *(uint64_t*)0x2006b008 = 8;
>   *(uint64_t*)0x2006b010 = 0;
>   *(uint64_t*)0x2006b018 = 9;
>   syscall(__NR_timer_settime, 0, 0ul, 0x2006b000ul, 0ul);
>
> This arms the alarm timer with a relative expiry of 8ns and an interval
> of 9ns. Not a problem per se, but that's an issue when the signal is
> ignored because then the timer is immediately rearmed because there is
> no way to delay that rearming to the signal delivery path.
> See posix_timer_fn() and commit 58229a189942 ("posix-timers: Prevent
> softirq starvation by small intervals and SIG_IGN") for details.
>
> The reproducer does not set SIG_IGN explicitely, but it does something
> nasty which has the same effect:
>
>   *(uint64_t*)0x20000000 = 0;
>   *(uint32_t*)0x20000008 = 0x12;
>   *(uint32_t*)0x2000000c = 0;
>   *(uint32_t*)0x20000010 = 0;
>   syscall(__NR_timer_create, 9ul, 0x20000000ul, 0x20000180ul);
>
> 0x20000008 is the signal number, which decodes to SIGCONT. SIGCONT is
> ignored if there is no handler set and the task is not ptraced.
>
> The log clearly shows that:
>
>    [pid  5102] --- SIGCONT {si_signo=SIGCONT, si_code=SI_TIMER, si_timerid=0, si_overrun=316014, si_int=0, si_ptr=NULL} ---
>
> It works because the tasks are traced and therefore the signal is queued
> so the tracer can see it, which delays the restart of the timer
> and the restart of the timer is delayed.
>
>    [pid  5087] kill(-5102, SIGKILL <unfinished ...>
>
> Here the tracer is killed
>
>    [pid  5107] --- SIGCONT {si_signo=SIGCONT, si_code=SI_TIMER, si_timerid=0, si_overrun=167448, si_int=0, si_ptr=NULL} ---
>    [pid  5104] --- SIGCONT {si_signo=SIGCONT, si_code=SI_TIMER, si_timerid=0, si_overrun=157138, si_int=0, si_ptr=NULL} ---
>    [pid  5103] --- SIGCONT {si_signo=SIGCONT, si_code=SI_TIMER, si_timerid=0, si_overrun=187150, si_int=0, si_ptr=NULL} ---
>    [pid  5106] --- SIGCONT {si_signo=SIGCONT, si_code=SI_TIMER, si_timerid=0, si_overrun=190249, si_int=0, si_ptr=NULL} ---
>    [pid  5102] --- stopped by SIGCONT ---
>    ./strace-static-x86_64: ptrace(PTRACE_LISTEN,pid:5102,sig:0): Input/output error
>    ./strace-static-x86_64: Process 5083 detached
>    ./strace-static-x86_64: Process 5084 detached
>    ./strace-static-x86_64: Process 5086 detached
>    ./strace-static-x86_64: Process 5085 detached
>    ./strace-static-x86_64: Process 5088 detached
>    ./strace-static-x86_64: Process 5089 detached
>    ./strace-static-x86_64: Process 5087 detached
>    ./strace-static-x86_64: Process 5102 detached
>    ./strace-static-x86_64: Process 5103 detached
>    ./strace-static-x86_64: Process 5104 detached
>    ./strace-static-x86_64: Process 5105 detached
>    ./strace-static-x86_64: Process 5106 detached
>    ./strace-static-x86_64: Process 5107 detached
>
> and after it's gone the drama starts:
>
>    syzkaller login: [   79.439102][    C0] hrtimer: interrupt took 68471 ns
>    [  184.460538][    C1] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
>    ...
>    [  184.658237][    C1] rcu: Stack dump where RCU GP kthread last ran:
>    [  184.664574][    C1] Sending NMI from CPU 1 to CPUs 0:
>    [  184.669821][    C0] NMI backtrace for cpu 0
>    [  184.669831][    C0] CPU: 0 PID: 5108 Comm: syz-executor192 Not tainted 6.2.0-rc6-next-20230203-syzkaller #0
>    ...
>    [  184.670036][    C0] Call Trace:
>    [  184.670041][    C0]  <IRQ>
>    [  184.670045][    C0]  alarmtimer_fired+0x327/0x670
>
> posix_timer_fn() prevents that by checking whether the interval for
> timers which have the signal ignored is smaller than a jiffie and
> artifically delay it by shifting the next expiry out by a jiffie. That's
> accurate vs. the overrun accounting, but slightly inaccurate
> vs. timer_gettimer().
>
> The comment in that function says what needs to be done and there was a
> fix available for the regular userspace induced SIG_IGN mechanism, but
> that did not work due to the implicit ignore for SIGCONT. I gave up at
> that point and put it onto the ever growing todo list...
>
> So the only available workaround right now is to do exactly what
> posix_timer_fn() does.
>
> Untested patch below.

I ran your test for a bit with the reproducer and didn't see any
issues. Also ran it through the kselftests/timers
run_destructive_tests and didn't see any issues.

So I think this is ok. Haven't really dug through all the implications
for adding an extra jiffy to the expiration there, but it sounds
reasonable to me.

Acked-by: John Stultz <jstultz@google.com>

thanks
-john
