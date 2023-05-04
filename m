Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA66F6F71DA
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 20:20:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbjEDSUf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 14:20:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjEDSUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 14:20:34 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D8EE1700
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 11:20:32 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1683224430;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K2sV3TpxlJp2nAhrUEtF4mS7eyHqxKADq22CtPKIy3s=;
        b=cjo5c1Q/6QZbrmPnheRS80QfWW0aa+YyI+dyBcwL9onJ9m+10Vvs8ouFRCoa9XHlw7nYi0
        y2JS92wEzQi3HzhQwTcD3ruGQUBRWrSiZFsq7EpxA55Br4qbkHl0Qni89olpcPyBiTRXJy
        KImLcSGcppcDT0Y1SPh3Vm0JnFvC2C3dQHKzKklyWlPsP0RX90hoXOhPskYUWSuEUgGpi9
        hW1YLpQuH6xj8oZdTGmfbQsHgZoFRzxYTeAUnT7sl649cl+X9bj0N7rrbiylTuGrVC4+fV
        aCB/A+2fCbU14gpAZWaoE2BVUrjUPoH/Zl0YSKpZQK7LLmmMaeioSa+GVFmr/w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1683224430;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K2sV3TpxlJp2nAhrUEtF4mS7eyHqxKADq22CtPKIy3s=;
        b=Yb/U81e/I6w6F2cFrJmy3ua33hQ6/gOrnJbZANO+0uxoNoFSJ94NwqPYkvabWOzg+PngLc
        HF1AnKIkc/AyQaCA==
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        syzbot+5c54bd3eb218bb595aa9@syzkaller.appspotmail.com,
        Dmitry Vyukov <dvyukov@google.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>
Subject: Re: [patch 01/20] posix-timers: Prevent RT livelock in itimer_delete()
In-Reply-To: <ZFPmKtFGPUQkeDEd@localhost.localdomain>
References: <20230425181827.219128101@linutronix.de>
 <20230425183312.862346341@linutronix.de>
 <ZFPmKtFGPUQkeDEd@localhost.localdomain>
Date:   Thu, 04 May 2023 20:20:29 +0200
Message-ID: <87bkj03qmq.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 04 2023 at 19:06, Frederic Weisbecker wrote:
> Le Tue, Apr 25, 2023 at 08:48:56PM +0200, Thomas Gleixner a =C3=A9crit :
>> itimer_delete() has a retry loop when the timer is concurrently expired.=
 On
>> non-RT kernels this just spin-waits until the timer callback has
>> completed. On RT kernels this is a potential livelock when the exiting t=
ask
>> preempted the hrtimer soft interrupt.
>>=20
>> This only affects hrtimer based timers as Posix CPU timers cannot be
>> concurrently expired. For CONFIG_POSIX_CPU_TIMERS_TASK_WORK=3Dy this is
>> obviously impossible as the task cannot run task work and exit at the sa=
me
>> time. The CONFIG_POSIX_CPU_TIMERS_TASK_WORK=3Dn (only non-RT) is prevent=
ed
>> because interrupts are disabled.
>
> But the owner of the timer is not the same as the target of the timer, ri=
ght?
>
> Though I seem to remember that we forbid setting a timer to a target outs=
ide
> the current process, in which case the owner and the target are the same =
at
> this exit stage. But I can't remember what enforces that permission in
> pid_for_clock()..

The owner of the timer is always the one which needs to find the entity
to synchronize on, whether that's the right hrtimer base or the task
which runs the expiry code.

wait_for_running_timer() is taking that into account:

  - The hrtimer timer based posix timers lock the hrtimer base expiry
    lock on the base to which the timer is currently associated

  - Posix CPU timers can be armed on a differnet process (only per
    thread timers are restricted to currents threadgroup) but the
    wait_for_running() callback "knows" how to find that process:

    When the timer is moved to the expiry list it gets:

         cputimer->firing =3D 1;
         rcu_assign_pointer(ctmr->handling, current);

   and the wait for running side does:

       rcu_read_lock()
       tsk =3D rcu_dereference(timr->it.cpu.handling);
       ....
       mutex_lock(&tsk->posix_cputimers_work.mutex);

   See collect_timerqueue(), handle_posix_cpu_timers() and
   posix_cpu_timer_wait_running() for details.

   commit f7abf14f0001 ("posix-cpu-timers: Implement the missing
   timer_wait_running callback") has quite some prose in the changelog.

Thanks,

        tglx

