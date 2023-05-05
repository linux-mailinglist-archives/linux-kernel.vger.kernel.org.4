Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DE166F7E3E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 09:57:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231146AbjEEH5Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 03:57:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjEEH5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 03:57:22 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB15D11558
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 00:57:20 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1683273438;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G6AyWahm1HMAkSRkiuL2sJYh+KFshgAetNxm+GiO8M0=;
        b=RjxdEe0A2iLzDM1DICLNWMgAEHIbRmcHsTwIwsEDXiKnkztqRXCgI/ebBeViVRntswmI4+
        8jC2lHrcd0ppN1i3F0Rs30ifwgNN9lBKvQvK8BZ8R4ok5UJRZgPY7sBfCm2iv+orN2tSnB
        Cg8DuTyqu6RUwrZgD96Smcegryq4/QEFisDCQEyHuUZEBG8XkZR9fDoEiRNhIf0jOCSEDm
        Fr9WlFlcMNi2JfzyMBRGPL/DOKECJI94vXuqhJE6l3z4i8YNhSEApTfyjbAFhYpRG0Z/EI
        xYF1/zYi1JHJzFITCegkuIrbaagGdfw4r4jFNKSza6oAS/kXAUx5WOcQLQU+UA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1683273438;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G6AyWahm1HMAkSRkiuL2sJYh+KFshgAetNxm+GiO8M0=;
        b=TOUocu/3tDBI6MDqtvZOwZwebCit/cJgAoewju3vix5lPvu3R6DOka3lVrSXN50ZUwODO1
        Lh9bAaZ3nq3LjeCw==
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        syzbot+5c54bd3eb218bb595aa9@syzkaller.appspotmail.com,
        Dmitry Vyukov <dvyukov@google.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>
Subject: Re: [patch 01/20] posix-timers: Prevent RT livelock in itimer_delete()
In-Reply-To: <87bkj03qmq.ffs@tglx>
References: <20230425181827.219128101@linutronix.de>
 <20230425183312.862346341@linutronix.de>
 <ZFPmKtFGPUQkeDEd@localhost.localdomain> <87bkj03qmq.ffs@tglx>
Date:   Fri, 05 May 2023 09:57:18 +0200
Message-ID: <875y9743dt.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 04 2023 at 20:20, Thomas Gleixner wrote:
> On Thu, May 04 2023 at 19:06, Frederic Weisbecker wrote:
>> Le Tue, Apr 25, 2023 at 08:48:56PM +0200, Thomas Gleixner a =C3=A9crit :
>>> itimer_delete() has a retry loop when the timer is concurrently expired=
. On
>>> non-RT kernels this just spin-waits until the timer callback has
>>> completed. On RT kernels this is a potential livelock when the exiting =
task
>>> preempted the hrtimer soft interrupt.
>>>=20
>>> This only affects hrtimer based timers as Posix CPU timers cannot be
>>> concurrently expired. For CONFIG_POSIX_CPU_TIMERS_TASK_WORK=3Dy this is
>>> obviously impossible as the task cannot run task work and exit at the s=
ame
>>> time. The CONFIG_POSIX_CPU_TIMERS_TASK_WORK=3Dn (only non-RT) is preven=
ted
>>> because interrupts are disabled.
>>
>> But the owner of the timer is not the same as the target of the timer, r=
ight?
>>
>> Though I seem to remember that we forbid setting a timer to a target out=
side
>> the current process, in which case the owner and the target are the same=
 at
>> this exit stage. But I can't remember what enforces that permission in
>> pid_for_clock()..
>
> The owner of the timer is always the one which needs to find the entity
> to synchronize on, whether that's the right hrtimer base or the task
> which runs the expiry code.
>
> wait_for_running_timer() is taking that into account:
>
>   - The hrtimer timer based posix timers lock the hrtimer base expiry
>     lock on the base to which the timer is currently associated
>
>   - Posix CPU timers can be armed on a differnet process (only per
>     thread timers are restricted to currents threadgroup) but the
>     wait_for_running() callback "knows" how to find that process:
>
>     When the timer is moved to the expiry list it gets:
>
>          cputimer->firing =3D 1;
>          rcu_assign_pointer(ctmr->handling, current);
>
>    and the wait for running side does:
>
>        rcu_read_lock()
>        tsk =3D rcu_dereference(timr->it.cpu.handling);
>        ....
>        mutex_lock(&tsk->posix_cputimers_work.mutex);
>
>    See collect_timerqueue(), handle_posix_cpu_timers() and
>    posix_cpu_timer_wait_running() for details.
>
>    commit f7abf14f0001 ("posix-cpu-timers: Implement the missing
>    timer_wait_running callback") has quite some prose in the changelog.

But you have a point. The comment I added in itimer_delete() vs. CPU
timers is wrong for timers which are armed on a different process.
Needs to be removed.

Thanks,

        tglx
