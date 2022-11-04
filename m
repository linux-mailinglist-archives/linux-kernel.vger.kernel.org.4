Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABC3461959C
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 12:47:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231735AbiKDLrq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 07:47:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231302AbiKDLrm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 07:47:42 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A9822CDEE
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 04:47:40 -0700 (PDT)
Date:   Fri, 4 Nov 2022 12:47:36 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1667562458;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=5JrDz3eN2pjlVUD1YA6h5fow/0dXYTvzFFMFbutk5Hg=;
        b=uLpJHlZFiydBXxNZyTMRZ0cG1vOo3yzQf/tLOSaH+/FRSckCw4kro/UD8pEAUNYhycdo/T
        glf9LSasZELnSmjB0ES8aphpKLwCS5rEi1gm1nYFz605WtScgVQfMsQk69eTs5ut/D2S5f
        rW+XWWDSWCkr+J7NTf1o+ZozvFkwc0IJNmLxksILDikEgKhwGGGImytMyb2eA+Vbnhiw7a
        Q7i4CSnavasY/cy/TgdIkKwblpNhSPU0jmzVDvfZhIMFNdtnBK+6q2hbmtZOE9P6mwfE/M
        89MMmO3ufmqAdX2DtWeXhD00idwYT4HanLa7IPCOxTIA5P31fwvVR3Azsp2hJg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1667562458;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=5JrDz3eN2pjlVUD1YA6h5fow/0dXYTvzFFMFbutk5Hg=;
        b=iZiy8V/1ClgODRO229wPmTReIPvsNM8QZifO/FqnNYk4ufPLgqkCIXDzHOXeWELT6qgpSG
        GyEqfHYDz9d4p6CQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     Ben Segall <bsegall@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: Latency spikes from within the scheduler.
Message-ID: <Y2T72N6nE6UHDPx3@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've been playing with v6.1-rc3-rt2 on a 256 CPU machine. Some of my
findings:
- it can take some time to grab the RQ lock. That is to got on the CPU
  _or_ to leave the CPU. For instance an 1ms example:
|       cyclictest-4619    [011] d...2..  1128.288674: idle_cpu <-find_busi=
est_group
|       cyclictest-4619    [011] d...2..  1128.288674: idle_cpu <-find_busi=
est_group
|       cyclictest-4619    [011] d...2..  1128.288675: raw_spin_rq_lock_nes=
ted <-load_balance
|       cyclictest-4619    [011] d...3..  1128.288675: _raw_spin_lock <-raw=
_spin_rq_lock_nested
|       cyclictest-4619    [011] d...4..  1128.288676: queued_spin_lock_slo=
wpath <-raw_spin_rq_lock_nested
|       cyclictest-4619    [011] d...3..  1128.289688: update_rq_clock <-lo=
ad_balance
|       cyclictest-4619    [011] d...3..  1128.289688: can_migrate_task <-l=
oad_balance
|       cyclictest-4619    [011] d...3..  1128.289688: kthread_is_per_cpu <=
-can_migrate_task

   https://breakpoint.cc/traces-zen3/trace-load_balance_rq_lock-11.txt.zst =
[77KiB]
   https://breakpoint.cc/traces-zen3/trace-load_balance_rq_lock.txt.zst [34=
MiB]

- A CPU can be attacked by rto_push_irq_work_func(). A few instances are
  probably okay but doing it 86 times can sum up to ~400us if called from
  flush_smp_call_function_queue() (after waiting for the RQ lock):
|            <idle>-0       [032] d...2..  4069.605763: irq_enter_rcu <-sys=
vec_apic_timer_interrupt
|            <idle>-0       [032] dn.h6..  4069.605929: queued_spin_lock_sl=
owpath <-enqueue_task_rt
=E2=80=A6
|            <idle>-0       [032] d..h6..  4069.605766: queued_spin_lock_sl=
owpath <-try_to_wake_up
|            <idle>-0       [032] dn.h5..  4069.605923: update_rq_clock <-t=
ry_to_wake_up
=E2=80=A6
|            <idle>-0       [032] dn.h6..  4069.605929: queued_spin_lock_sl=
owpath <-enqueue_task_rt
|            <idle>-0       [032] dn.h5..  4069.606167: enqueue_top_rt_rq <=
-enqueue_task_rt
|            <idle>-0       [032] dn.h4..  4069.606169: sched_wakeup: comm=
=3Dcyclictest pid=3D8045 prio=3D9 target_cpu=3D032
=E2=80=A6
|            <idle>-0       [032] dn.h2..  4069.606171: irq_exit_rcu <-sysv=
ec_apic_timer_interrupt
|            <idle>-0       [032] .n..2..  4069.606171: arch_cpu_idle_exit =
<-do_idle
|            <idle>-0       [032] .n..2..  4069.606171: flush_smp_call_func=
tion_queue <-do_idle
|            <idle>-0       [032] dn..2..  4069.606172: __flush_smp_call_fu=
nction_queue <-flush_smp_call_function_queue
|            <idle>-0       [032] dn..2..  4069.606173: rto_push_irq_work_f=
unc <-irq_work_single
=E2=80=A6
|            <idle>-0       [032] dn.h2..  4069.606578: irq_exit_rcu <-sysv=
ec_irq_work
|            <idle>-0       [032] .n..2..  4069.606578: schedule_idle <-do_=
idle
|            <idle>-0       [032] dn..2..  4069.606579: rcu_note_context_sw=
itch <-__schedule

   https://breakpoint.cc/traces-zen3/trace-rto_push_irq_work_func-32.txt.zs=
t [102KiB]
   https://breakpoint.cc/traces-zen3/trace-rto_push_irq_work_func.txt.zst [=
49MiB]

- I also managed to run into sched_rt_period_timer():
|            <idle>-0       [027] dn.h1..   630.600139: hrtimer_expire_entr=
y: hrtimer=3D00000000602b5d49 function=3Dsched_rt_period_timer now=3D630600=
137263
|            <idle>-0       [027] dn.h2..   630.600139: sched_rt_period_tim=
er <-__hrtimer_run_queues
|            <idle>-0       [027] dn.h2..   630.600139: _raw_spin_lock <-sc=
hed_rt_period_timer
|            <idle>-0       [027] dn.h3..   630.600140: queued_spin_lock_sl=
owpath <-sched_rt_period_timer
|            <idle>-0       [027] dn.h3..   630.600326: ktime_get <-sched_r=
t_period_timer
=E2=80=A6
|            <idle>-0       [027] dn.h3..   630.606825: hrtimer_forward <-s=
ched_rt_period_timer
|            <idle>-0       [027] dn.h2..   630.606826: _raw_spin_lock_irq =
<-__hrtimer_run_queues
|            <idle>-0       [027] dn.h3..   630.606826: enqueue_hrtimer <-_=
_hrtimer_run_queues
|            <idle>-0       [027] dn.h2..   630.606826: hrtimer_start: hrti=
mer=3D00000000602b5d49 function=3Dsched_rt_period_timer expires=3D631600000=
000 softexpires=3D631600000000 mode=3DABS

   That is almost 7ms of runtime just for that one hrtimer ensuring that
   an RT task is not running longer than needing.

   https://breakpoint.cc/traces-zen3/trace-sched_rt_period_timer-27.txt.zst=
 [101K]
   https://breakpoint.cc/traces-zen3/trace-sched_rt_period_timer.txt.zst [4=
8MiB]

The -XX trace is just from that one CPU, the other the complete one. I
also have them as an all-in-one archive:
   https://breakpoint.cc/traces-zen3/trace-all-in-one.tar.zst

And the dot-config:
   https://breakpoint.cc/traces-zen3/dot-config.tar.zst

The first two were run with CONFIG-PERIODIC, the last one with CONFIG-NO_HZ.

Sebastian
