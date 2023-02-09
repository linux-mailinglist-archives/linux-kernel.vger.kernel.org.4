Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B06C1691342
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 23:26:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230262AbjBIWZ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 17:25:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjBIWZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 17:25:56 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 344F868AC9
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 14:25:52 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1675981550;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=o/6iCEFEAADmyV/MYI8pahg41cD9x6uNs4Tdd4Dwim0=;
        b=uyjbI2clfI85oKH7A8xmbIENJwtQyrkbKZ9ZULN5pUmF1+ugYmtE6EJ5G0bs+/SM4bJRJd
        uRjjcV6eQI6Y0s27uhsMHc4o0VAjYCJedFpNJ+tAwOVVKwLzHl6NNvBpud4FRFLWVxeYbO
        o1g170rJZeWu+PQQB4Ky/n+TjeQq3tKSFd4qr/g4Xy4BD0IxH42WLAIp5As2Xg06x5nNnH
        PFmaI9umTnkPEn6nl7jcDMbomyfelE56O9BQ+Tw1GSBZYpRBkt/f/6kY+X1K4IEYl691Du
        FFGZ7MRv3Tltr9vBS5CIdO1EqtxU1Qpb5xV8RewR0vO14axKcZieF9DX/T8SkA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1675981550;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=o/6iCEFEAADmyV/MYI8pahg41cD9x6uNs4Tdd4Dwim0=;
        b=G+01ru+mVYW8RS+CxQOOfQw+6DnhDr2zCNLsjixiIvEZzWYn1WirOArFpnPhjAYLKWLYPb
        VzV9hEWgLYSLv3CA==
To:     syzbot <syzbot+b9564ba6e8e00694511b@syzkaller.appspotmail.com>,
        jstultz@google.com, linux-kernel@vger.kernel.org, sboyd@kernel.org,
        syzkaller-bugs@googlegroups.com,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Oleg Nesterov <oleg@redhat.com>
Subject: Re: [syzbot] INFO: rcu detected stall in ext4_file_write_iter (6)
In-Reply-To: <0000000000006ac93505f42dda96@google.com>
References: <0000000000006ac93505f42dda96@google.com>
Date:   Thu, 09 Feb 2023 23:25:49 +0100
Message-ID: <87k00q1no2.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 08 2023 at 02:37, syzbot wrote:
> syzbot found the following issue on:
>
> HEAD commit:    4fafd96910ad Add linux-next specific files for 20230203
> git tree:       linux-next
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=17005023480000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=1d2fba7d42502ca4
> dashboard link: https://syzkaller.appspot.com/bug?extid=b9564ba6e8e00694511b
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=110c6175480000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15ef5ad9480000
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/348cc2da441a/disk-4fafd969.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/e2dedc500f12/vmlinux-4fafd969.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/fae710d9ebd8/bzImage-4fafd969.xz

<SNIP>

> NMI backtrace for cpu 0
> Call Trace:
>  <IRQ>
>  trace_alarmtimer_fired include/trace/events/alarmtimer.h:73 [inline]
>  alarmtimer_fired+0x327/0x670 kernel/time/alarmtimer.c:220
>  __run_hrtimer kernel/time/hrtimer.c:1685 [inline]
>  __hrtimer_run_queues+0x600/0xcf0 kernel/time/hrtimer.c:1749
>  hrtimer_interrupt+0x320/0x7b0 kernel/time/hrtimer.c:1811
>  local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1096 [inline]
>  __sysvec_apic_timer_interrupt+0x180/0x660 arch/x86/kernel/apic/apic.c:1113
>  sysvec_apic_timer_interrupt+0x92/0xc0 arch/x86/kernel/apic/apic.c:1107
>  </IRQ>
>  <TASK>
>  asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:645

Looking at the reproducer:

  *(uint64_t*)0x2006b000 = 0;
  *(uint64_t*)0x2006b008 = 8;
  *(uint64_t*)0x2006b010 = 0;
  *(uint64_t*)0x2006b018 = 9;
  syscall(__NR_timer_settime, 0, 0ul, 0x2006b000ul, 0ul);

This arms the alarm timer with a relative expiry of 8ns and an interval
of 9ns. Not a problem per se, but that's an issue when the signal is
ignored because then the timer is immediately rearmed because there is
no way to delay that rearming to the signal delivery path.
See posix_timer_fn() and commit 58229a189942 ("posix-timers: Prevent
softirq starvation by small intervals and SIG_IGN") for details.

The reproducer does not set SIG_IGN explicitely, but it does something
nasty which has the same effect:

  *(uint64_t*)0x20000000 = 0;
  *(uint32_t*)0x20000008 = 0x12;
  *(uint32_t*)0x2000000c = 0;
  *(uint32_t*)0x20000010 = 0;
  syscall(__NR_timer_create, 9ul, 0x20000000ul, 0x20000180ul);

0x20000008 is the signal number, which decodes to SIGCONT. SIGCONT is
ignored if there is no handler set and the task is not ptraced.

The log clearly shows that:

   [pid  5102] --- SIGCONT {si_signo=SIGCONT, si_code=SI_TIMER, si_timerid=0, si_overrun=316014, si_int=0, si_ptr=NULL} ---

It works because the tasks are traced and therefore the signal is queued
so the tracer can see it, which delays the restart of the timer
and the restart of the timer is delayed.

   [pid  5087] kill(-5102, SIGKILL <unfinished ...>

Here the tracer is killed

   [pid  5107] --- SIGCONT {si_signo=SIGCONT, si_code=SI_TIMER, si_timerid=0, si_overrun=167448, si_int=0, si_ptr=NULL} ---
   [pid  5104] --- SIGCONT {si_signo=SIGCONT, si_code=SI_TIMER, si_timerid=0, si_overrun=157138, si_int=0, si_ptr=NULL} ---
   [pid  5103] --- SIGCONT {si_signo=SIGCONT, si_code=SI_TIMER, si_timerid=0, si_overrun=187150, si_int=0, si_ptr=NULL} ---
   [pid  5106] --- SIGCONT {si_signo=SIGCONT, si_code=SI_TIMER, si_timerid=0, si_overrun=190249, si_int=0, si_ptr=NULL} ---
   [pid  5102] --- stopped by SIGCONT ---
   ./strace-static-x86_64: ptrace(PTRACE_LISTEN,pid:5102,sig:0): Input/output error
   ./strace-static-x86_64: Process 5083 detached
   ./strace-static-x86_64: Process 5084 detached
   ./strace-static-x86_64: Process 5086 detached
   ./strace-static-x86_64: Process 5085 detached
   ./strace-static-x86_64: Process 5088 detached
   ./strace-static-x86_64: Process 5089 detached
   ./strace-static-x86_64: Process 5087 detached
   ./strace-static-x86_64: Process 5102 detached
   ./strace-static-x86_64: Process 5103 detached
   ./strace-static-x86_64: Process 5104 detached
   ./strace-static-x86_64: Process 5105 detached
   ./strace-static-x86_64: Process 5106 detached
   ./strace-static-x86_64: Process 5107 detached
   
and after it's gone the drama starts:
   
   syzkaller login: [   79.439102][    C0] hrtimer: interrupt took 68471 ns
   [  184.460538][    C1] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
   ...
   [  184.658237][    C1] rcu: Stack dump where RCU GP kthread last ran:
   [  184.664574][    C1] Sending NMI from CPU 1 to CPUs 0:
   [  184.669821][    C0] NMI backtrace for cpu 0
   [  184.669831][    C0] CPU: 0 PID: 5108 Comm: syz-executor192 Not tainted 6.2.0-rc6-next-20230203-syzkaller #0
   ...
   [  184.670036][    C0] Call Trace:
   [  184.670041][    C0]  <IRQ>
   [  184.670045][    C0]  alarmtimer_fired+0x327/0x670

posix_timer_fn() prevents that by checking whether the interval for
timers which have the signal ignored is smaller than a jiffie and
artifically delay it by shifting the next expiry out by a jiffie. That's
accurate vs. the overrun accounting, but slightly inaccurate
vs. timer_gettimer().

The comment in that function says what needs to be done and there was a
fix available for the regular userspace induced SIG_IGN mechanism, but
that did not work due to the implicit ignore for SIGCONT. I gave up at
that point and put it onto the ever growing todo list...

So the only available workaround right now is to do exactly what
posix_timer_fn() does.

Untested patch below.

Thanks,

        tglx
---
diff --git a/kernel/time/alarmtimer.c b/kernel/time/alarmtimer.c
index 5897828b9d7e..ff4ff2cab0c0 100644
--- a/kernel/time/alarmtimer.c
+++ b/kernel/time/alarmtimer.c
@@ -470,11 +470,35 @@ u64 alarm_forward(struct alarm *alarm, ktime_t now, ktime_t interval)
 }
 EXPORT_SYMBOL_GPL(alarm_forward);
 
-u64 alarm_forward_now(struct alarm *alarm, ktime_t interval)
+static u64 __alarm_forward_now(struct alarm *alarm, ktime_t interval, bool throttle)
 {
 	struct alarm_base *base = &alarm_bases[alarm->type];
+	ktime_t now = base->get_ktime();
+
+	if (IS_ENABLED(CONFIG_HIGH_RES_TIMERS) && throttle) {
+		/*
+		 * Same issue as with posix_timer_fn(). Timers which are
+		 * periodic but the signal is ignored can starve the system
+		 * with a very small interval. The real fix which was
+		 * promised in the context of posix_timer_fn() never
+		 * materialized, but someone should really work on it.
+		 *
+		 * To prevent DOS fake @now to be 1 jiffie out which keeps
+		 * the overrun accounting correct but creates an
+		 * inconsistency vs. timer_gettime(2).
+		 */
+		ktime_t kj = NSEC_PER_SEC / HZ;
+
+		if (interval < kj)
+			now = ktime_add(now, kj);
+	}
+
+	return alarm_forward(alarm, now, interval);
+}
 
-	return alarm_forward(alarm, base->get_ktime(), interval);
+u64 alarm_forward_now(struct alarm *alarm, ktime_t interval)
+{
+	return __alarm_forward_now(alarm, interval, false);
 }
 EXPORT_SYMBOL_GPL(alarm_forward_now);
 
@@ -551,9 +575,10 @@ static enum alarmtimer_restart alarm_handle_timer(struct alarm *alarm,
 	if (posix_timer_event(ptr, si_private) && ptr->it_interval) {
 		/*
 		 * Handle ignored signals and rearm the timer. This will go
-		 * away once we handle ignored signals proper.
+		 * away once we handle ignored signals proper. Ensure that
+		 * small intervals cannot starve the system.
 		 */
-		ptr->it_overrun += alarm_forward_now(alarm, ptr->it_interval);
+		ptr->it_overrun += __alarm_forward_now(alarm, ptr->it_interval, true);
 		++ptr->it_requeue_pending;
 		ptr->it_active = 1;
 		result = ALARMTIMER_RESTART;
