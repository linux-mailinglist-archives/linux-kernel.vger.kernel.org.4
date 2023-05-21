Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3285770AC94
	for <lists+linux-kernel@lfdr.de>; Sun, 21 May 2023 08:04:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbjEUGD7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 May 2023 02:03:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjEUGD5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 May 2023 02:03:57 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C983109
        for <linux-kernel@vger.kernel.org>; Sat, 20 May 2023 23:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1684649022; i=efault@gmx.de;
        bh=fsFUpKc3fr3FD3xkFHiNMMst91WvFGFpM9KObmcuqp4=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date;
        b=NWtnvyJdPaOiG/B1jY2RI9k/fn+clxu2QaToriVEvFhuQUNSBcVcZb+4crXqftgjR
         16jxoZRPqXk9PT4QnLoAhkJh3LjOnC0La1ZkCssTPSC2x+nyzmFNDxjuYsvGDlVvJK
         KGP32rwCDbgM12LoZrTHcYQGotpgxonHWNbVxU7uj6Tj7ghWvE13DTO16ipiF6uilZ
         M67vuZUmG5aG7zgDhFp/gdhI70/8rRI3Yotca/MtwYMKgOoJ4gnnBHLV6M/EmA1a5+
         UChIRVl4V6vhMFJwAzR+k11EJRXKKibmSHiv5zkG0hQm4XgIIqTe+NuqG7uBo9pKwq
         gYCyieny92LYg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from homer.fritz.box ([185.191.219.131]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MK3Rm-1piXc80RG2-00LWyS; Sun, 21
 May 2023 08:03:42 +0200
Message-ID: <e55be0ae115ad6494ebb48fecd03e5c2fe528230.camel@gmx.de>
Subject: r8169: disable ASPM during NAPI poll locking changes --> BUG:
 Invalid wait context --> PREEMPT_RT pain
From:   Mike Galbraith <efault@gmx.de>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Date:   Sun, 21 May 2023 08:03:41 +0200
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:L3nhEhzAoGoNo4t2Qqd8OrNApNAWF7F4ZPaPqsvgEov0zvpcmXF
 m1aQSbd2xaxsMscXcwp1Bn4IZE0up/QO0lal6hw1QrJiZpN+pJDczOqu6nxoYwMqMWoqQvl
 Is0Mz4ufNDDWEkMh9EofbyMlflnHyFNbRoNMxfmPj03UTx5He+7aYoLdoOjL/FOxxEBKU7L
 tSaEx3JceNlkdLRqNibdQ==
UI-OutboundReport: notjunk:1;M01:P0:HarVUZ4vEyE=;XFA46BS5KFdHnoYtyhPCvdihd23
 OxctUawvS+3ZkpBAl7t2ejrSH1l6aiISWyV03N3J6IHM2/nDxEplV3SQlsz5UJSIgXS9WK2Hn
 ePYrg9vZ9OQ5ynRahT78NPuvzhZ0ynfxHP9aeCvFG+5aWgM3Bgr5X4XG1+jY3+BUYyK4vDH3c
 hu0YkMNpp58xwTq1OC4+63dBQje43WVO/lJlFcrmoIw3lrkdEgNaNdh2HtVEpg2yOK2wpicQC
 41r/M78mTz/yEPqYiKkG/drNpYZKNdqxKRTpchCl7C6bKfwQx2tfx6hRSQZM3aN6Jf6aqE1jY
 E97mfaCSf+xl3HQt6+LmRYfUNoaLFhDICIFP1N9YxXqZQnpUvltiSjL5bnONeF25TJJO4jZNa
 3xuP9Rc9f9BefApxInF7fSWvO8VPe1tIX/gFzB7oqzZvwwheLoc/qgDBz17C9lQ+pvaBGK2WY
 lCVnWd6bnSoD0vKwuye6xswo61BjviNKNevUU+Avb6hI5t9PJ56/687U3iPbHmduo2Vfrh3bt
 sSjstbAB/cvT7TVDhRV+Kr293PtMafLDC0pMc0stHxzsPgOzxsMU0bZoYtxtiordh2PaYPmuW
 aPw38XQFw0su7bDd3peHd7EY8Lx0a1wRqxNdFN5+2RHrlrCQWWYLK9Oy2uoAfeS/XccG96We4
 IrgPyBZ3Y5BwMjcBAxdKjKUAD0bFoQy6201ev5qTBEkID9Nqmh2iwIbfU5b1xdMWLM6xgznje
 68FmNli6wo1M1VuTGEB294ua44ff6xfbmne9JGsuStI8sw1BBRPoeBh1Ryi4Ro8HYG38hc7Dy
 n81e4m/DXbLQkSy8WMarEhMUj2wgM9h288bd4a8ZkJBWElT8740lMGfBxUROckFv4Lgg/6Scv
 5hgtHA3GapbuiZO+c2hGrYwwmtAPnaxzBK0rxjTZ3wuQMNQBJCrxyk0+F5pAlwwv9YntAGCNG
 XBg+t0QnWA31FUvftPf9wK5gJaM=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

The locks added to prep for $subject induce invalid context moaning due
to not being raw locks, but if I do that, the hold time does very bad
things to RT.  Nouveau apparently didn't appreciate ftrace recording
the 160us latency hit all that much either, because my GUI ceased
responding, and I had to ssh in to find out what happened.

[  783.226457] nouveau 0000:01:00.0: ce2: LAUNCHERR 0000000a [UNUSED_FIELD=
]
[  787.530456] nouveau 0000:01:00.0: fifo: SCHED_ERROR 0a [CTXSW_TIMEOUT]
[  787.530501] nouveau 0000:01:00.0: fifo:000000:0002:[X[2677]] rc schedul=
ed
[  787.530504] nouveau 0000:01:00.0: fifo:000000: rc scheduled
[  787.530516] nouveau 0000:01:00.0: fifo:000000:0002:0002:[X[2677]] error=
ed - disabling channel
[  787.530522] nouveau 0000:01:00.0: X[2677]: channel 2 killed!

# tracer: wakeup_RT
#
# wakeup_RT latency trace v1.1.5 on 6.4.0.gd635f6c-master-eevdf-rt
# --------------------------------------------------------------------
# latency: 160 us, #116/116, CPU#0 | (M:preempt_rt VP:0, KP:0, SP:0 HP:0 #=
P:8)
#    -----------------
#    | task: cyclictest-29050 (uid:0 nice:0 policy:1 rt_prio:99)
#    -----------------
#
#                    _--------=3D> CPU#
#                   / _-------=3D> irqs-off/BH-disabled
#                  | / _------=3D> need-resched
#                  || / _-----=3D> need-resched-lazy
#                  ||| / _----=3D> hardirq/softirq
#                  |||| / _---=3D> preempt-depth
#                  ||||| / _--=3D> preempt-lazy-depth
#                  |||||| / _-=3D> migrate-disable
#                  ||||||| /     delay
#  cmd     pid     |||||||| time  |   caller
#     \   /        ||||||||  \    |    /
  <idle>-0         0dn.h5..    0us :        0:120:R   + [000]   29050:  0:=
R cyclictest
  <idle>-0         0dn.h5..    1us : 0
  <idle>-0         0dn.h4..    1us : task_woken_rt <-ttwu_do_activate
  <idle>-0         0dn.h4..    1us : preempt_count_sub <-__raw_spin_unlock
  <idle>-0         0dn.h3..    1us : _raw_spin_unlock_irqrestore <-try_to_=
wake_up
  <idle>-0         0dn.h3..    1us : preempt_count_sub <-_raw_spin_unlock_=
irqrestore
  <idle>-0         0dn.h2..    2us : preempt_count_sub <-try_to_wake_up
  <idle>-0         0dn.h1..    2us : _raw_spin_lock_irq <-__hrtimer_run_qu=
eues
  <idle>-0         0dn.h1..    2us : preempt_count_add <-_raw_spin_lock_ir=
q
  <idle>-0         0dn.h2..    2us : hrtimer_update_next_event <-hrtimer_i=
nterrupt
  <idle>-0         0dn.h2..    2us : __hrtimer_get_next_event <-hrtimer_up=
date_next_event
  <idle>-0         0dn.h2..    2us : __hrtimer_next_event_base <-__hrtimer=
_get_next_event
  <idle>-0         0dn.h2..    3us : __hrtimer_get_next_event <-hrtimer_up=
date_next_event
  <idle>-0         0dn.h2..    3us : __hrtimer_next_event_base <-hrtimer_u=
pdate_next_event
  <idle>-0         0dn.h2..    3us : _raw_spin_unlock_irqrestore <-hrtimer=
_interrupt
  <idle>-0         0dn.h2..    3us : preempt_count_sub <-_raw_spin_unlock_=
irqrestore
  <idle>-0         0dn.h1..    3us : tick_program_event <-hrtimer_interrup=
t
  <idle>-0         0dn.h1..    3us : clockevents_program_event <-hrtimer_i=
nterrupt
  <idle>-0         0dn.h1..    3us : ktime_get <-clockevents_program_event
  <idle>-0         0dn.h1..    3us : lapic_next_deadline <-clockevents_pro=
gram_event
  <idle>-0         0dn.h1..    4us : irq_exit_rcu <-sysvec_apic_timer_inte=
rrupt
  <idle>-0         0dn..1..    4us : idle_cpu <-irq_exit_rcu
  <idle>-0         0dn..1..    4us : irq_enter_rcu <-common_interrupt
  <idle>-0         0dn.h1..    4us : tick_irq_enter <-irq_enter_rcu
  <idle>-0         0dn.h1..    4us : tick_check_oneshot_broadcast_this_cpu=
 <-tick_irq_enter
  <idle>-0         0dn.h1..    5us : __common_interrupt <-common_interrupt
  <idle>-0         0dn.h1..    5us : handle_edge_irq <-__common_interrupt
  <idle>-0         0dn.h1..    5us : _raw_spin_lock <-handle_edge_irq
  <idle>-0         0dn.h1..    5us : preempt_count_add <-_raw_spin_lock
  <idle>-0         0dn.h2..    5us : irq_may_run <-handle_edge_irq
  <idle>-0         0dn.h2..    5us : irq_chip_ack_parent <-handle_edge_irq
  <idle>-0         0dn.h2..    5us : apic_ack_irq <-handle_edge_irq
  <idle>-0         0dn.h2..    6us : handle_irq_event <-handle_edge_irq
  <idle>-0         0dn.h2..    6us : preempt_count_sub <-handle_irq_event
  <idle>-0         0dn.h1..    6us : handle_irq_event_percpu <-handle_irq_=
event
  <idle>-0         0dn.h1..    6us : __handle_irq_event_percpu <-handle_ir=
q_event_percpu
  <idle>-0         0dn.h1..    6us+: rtl8169_interrupt <-__handle_irq_even=
t_percpu
  <idle>-0         0dn.h1..   81us : napi_schedule_prep <-rtl8169_interrup=
t
  <idle>-0         0dn.h1..   81us : rtl_unlock_config_regs <-rtl8169_inte=
rrupt
  <idle>-0         0dn.h1..   81us : _raw_spin_lock_irqsave <-rtl_unlock_c=
onfig_regs
  <idle>-0         0dn.h1..   81us : preempt_count_add <-_raw_spin_lock_ir=
qsave
  <idle>-0         0dn.h2..   82us : _raw_spin_unlock_irqrestore <-rtl8169=
_interrupt
  <idle>-0         0dn.h2..   82us : preempt_count_sub <-_raw_spin_unlock_=
irqrestore
  <idle>-0         0dn.h1..   82us : rtl_hw_aspm_clkreq_enable <-rtl8169_i=
nterrupt
  <idle>-0         0dn.h1..   82us : rtl_mod_config2 <-rtl_hw_aspm_clkreq_=
enable
  <idle>-0         0dn.h1..   82us : _raw_spin_lock_irqsave <-rtl_mod_conf=
ig2
  <idle>-0         0dn.h1..   82us+: preempt_count_add <-_raw_spin_lock_ir=
qsave
  <idle>-0         0dn.h2..  110us : _raw_spin_unlock_irqrestore <-rtl_hw_=
aspm_clkreq_enable
  <idle>-0         0dn.h2..  110us : preempt_count_sub <-_raw_spin_unlock_=
irqrestore
  <idle>-0         0dn.h1..  110us : rtl_mod_config5 <-rtl8169_interrupt
  <idle>-0         0dn.h1..  110us : _raw_spin_lock_irqsave <-rtl_mod_conf=
ig5
  <idle>-0         0dn.h1..  110us+: preempt_count_add <-_raw_spin_lock_ir=
qsave
  <idle>-0         0dn.h2..  149us : _raw_spin_unlock_irqrestore <-rtl8169=
_interrupt
  <idle>-0         0dn.h2..  150us : preempt_count_sub <-_raw_spin_unlock_=
irqrestore
  <idle>-0         0dn.h1..  150us : rtl_lock_config_regs <-rtl8169_interr=
upt
  <idle>-0         0dn.h1..  150us : _raw_spin_lock_irqsave <-rtl_lock_con=
fig_regs
  <idle>-0         0dn.h1..  150us : preempt_count_add <-_raw_spin_lock_ir=
qsave
  <idle>-0         0dn.h2..  150us : _raw_spin_unlock_irqrestore <-rtl8169=
_interrupt
  <idle>-0         0dn.h2..  150us : preempt_count_sub <-_raw_spin_unlock_=
irqrestore
  <idle>-0         0dn.h1..  151us : __napi_schedule <-rtl8169_interrupt
  <idle>-0         0dn.h1..  151us : __raise_softirq_irqoff <-__napi_sched=
ule
  <idle>-0         0dn.h1..  151us : add_interrupt_randomness <-handle_irq=
_event_percpu
  <idle>-0         0dn.h1..  151us : fast_mix <-add_interrupt_randomness
  <idle>-0         0dn.h1..  151us : note_interrupt <-handle_irq_event_per=
cpu
  <idle>-0         0dn.h1..  151us : _raw_spin_lock <-handle_irq_event
  <idle>-0         0dn.h1..  152us : preempt_count_add <-_raw_spin_lock
  <idle>-0         0dn.h2..  152us : preempt_count_sub <-handle_edge_irq
  <idle>-0         0dn.h1..  152us : irq_exit_rcu <-common_interrupt
  <idle>-0         0dn..1..  152us : wakeup_softirqd <-irq_exit_rcu
  <idle>-0         0dn..1..  152us : wake_up_process <-irq_exit_rcu
  <idle>-0         0dn..1..  152us : try_to_wake_up <-irq_exit_rcu
  <idle>-0         0dn..1..  153us : preempt_count_add <-try_to_wake_up
  <idle>-0         0dn..2..  153us : _raw_spin_lock_irqsave <-try_to_wake_=
up
  <idle>-0         0dn..2..  153us : preempt_count_add <-_raw_spin_lock_ir=
qsave
  <idle>-0         0dn..3..  153us : kthread_is_per_cpu <-is_cpu_allowed
  <idle>-0         0dn..3..  153us : ttwu_queue_wakelist <-try_to_wake_up
  <idle>-0         0dn..3..  153us : preempt_count_add <-try_to_wake_up
  <idle>-0         0dn..4..  154us : _raw_spin_lock <-try_to_wake_up
  <idle>-0         0dn..4..  154us : preempt_count_add <-_raw_spin_lock
  <idle>-0         0dn..5..  154us : preempt_count_sub <-try_to_wake_up
  <idle>-0         0dn..4..  154us : update_rq_clock <-try_to_wake_up
  <idle>-0         0dn..4..  155us : update_rq_clock.part.110 <-try_to_wak=
e_up
  <idle>-0         0dn..4..  155us : ttwu_do_activate <-try_to_wake_up
  <idle>-0         0dn..4..  155us : activate_task <-ttwu_do_activate
  <idle>-0         0dn..4..  155us : enqueue_task_fair <-activate_task
  <idle>-0         0dn..4..  155us : update_curr <-enqueue_task_fair
  <idle>-0         0dn..4..  155us : __update_load_avg_se <-enqueue_task_f=
air
  <idle>-0         0dn..4..  156us : __update_load_avg_cfs_rq <-enqueue_ta=
sk_fair
  <idle>-0         0dn..4..  156us : place_entity <-enqueue_task_fair
  <idle>-0         0dn..4..  156us : avg_vruntime <-place_entity
  <idle>-0         0dn..4..  156us : __enqueue_entity <-enqueue_task_fair
  <idle>-0         0dn..4..  156us : hrtick_update <-activate_task
  <idle>-0         0dn..4..  156us : check_preempt_curr <-ttwu_do_activate
  <idle>-0         0dn..4..  157us : resched_curr <-check_preempt_curr
  <idle>-0         0dn..5..  157us : __traceiter_sched_wakeup <-ttwu_do_ac=
tivate
  <idle>-0         0dn..4..  157us : preempt_count_sub <-__raw_spin_unlock
  <idle>-0         0dn..3..  157us : _raw_spin_unlock_irqrestore <-try_to_=
wake_up
  <idle>-0         0dn..3..  157us : preempt_count_sub <-_raw_spin_unlock_=
irqrestore
  <idle>-0         0dn..2..  157us : preempt_count_sub <-try_to_wake_up
  <idle>-0         0dn..1..  158us : idle_cpu <-irq_exit_rcu
  <idle>-0         0dn..1..  158us : rcu_note_context_switch <-__schedule
  <idle>-0         0dn..1..  158us : rcu_qs <-rcu_note_context_switch
  <idle>-0         0dn..1..  158us : preempt_count_add <-__schedule
  <idle>-0         0dn..2..  158us : _raw_spin_lock <-__schedule
  <idle>-0         0dn..2..  159us : preempt_count_add <-_raw_spin_lock
  <idle>-0         0dn..3..  159us : preempt_count_sub <-__schedule
  <idle>-0         0dn..2..  159us : update_rq_clock <-__schedule
  <idle>-0         0dn..2..  159us : put_prev_task_idle <-__schedule
  <idle>-0         0dn..2..  159us : pick_next_task_stop <-__schedule
  <idle>-0         0dn..2..  159us : pick_next_task_dl <-__schedule
  <idle>-0         0dn..2..  159us : pick_next_task_rt <-__schedule
  <idle>-0         0dn..2..  160us : pick_next_rt_entity <-pick_next_task_=
rt
  <idle>-0         0dn..2..  160us : update_rt_rq_load_avg <-pick_next_tas=
k_rt
  <idle>-0         0d...3..  160us : __traceiter_sched_switch <-__schedule
  <idle>-0         0d...3..  160us : __traceiter_sched_switch
  <idle>-0         0d...3..  160us :        0:120:R =3D=3D> [000]   29050:=
  0:R cyclictest

