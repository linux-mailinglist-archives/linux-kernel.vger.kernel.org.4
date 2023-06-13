Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA23872EA00
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 19:37:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229445AbjFMRgu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 13:36:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbjFMRgk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 13:36:40 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 59E63198D
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 10:36:34 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F046F1FB;
        Tue, 13 Jun 2023 10:37:18 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3BE9F3F663;
        Tue, 13 Jun 2023 10:36:31 -0700 (PDT)
Message-ID: <cbcbe3e3-e657-25f2-199d-ce78711545bd@arm.com>
Date:   Tue, 13 Jun 2023 19:36:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v4 00/13] Generalized Priority Inheritance via Proxy
 Execution v3
Content-Language: en-US
To:     John Stultz <jstultz@google.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Joel Fernandes <joelaf@google.com>,
        Qais Yousef <qyousef@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <vschneid@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Zimuzo Ezeozue <zezeozue@google.com>,
        Youssef Esmat <youssefesmat@google.com>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>, kernel-team@android.com
References: <20230601055846.2349566-1-jstultz@google.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <20230601055846.2349566-1-jstultz@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/06/2023 07:58, John Stultz wrote:
> After having to catch up on other work after OSPM[1], I've finally
> gotten back to focusing on Proxy Execution and wanted to send out this
> next iteration of the patch series for review, testing, and feedback.
> (Many thanks to folks who provided feedback on the last revision!)
> 
> As mentioned previously, this Proxy Execution series has a long history:
> First described in a paper[2] by Watkins, Straub, Niehaus, then from
> patches from Peter Zijlstra, extended with lots of work by Juri Lelli,
> Valentin Schneider, and Connor O'Brien. (and thank you to Steven Rostedt
> for providing additional details here!)
> 
> So again, many thanks to those above, as all the credit for this series
> really is due to them - while the mistakes are likely mine.
> 
> Overview:
> —----------
> Proxy Execution is a generalized form of priority inheritance. Classic
> priority inheritance works well for real-time tasks where there is a
> straight forward priority order to how things are run. But it breaks
> down when used between CFS or DEADLINE tasks, as there are lots
> of parameters involved outside of just the task’s nice value when
> selecting the next task to run (via pick_next_task()).  So ideally we
> want to imbue the mutex holder with all the scheduler attributes of 
> the blocked waiting task.
> 
> Proxy Execution does this via a few changes:
> * Keeping tasks that are blocked on a mutex *on* the runqueue
> * Keeping additional tracking of which mutex a task is blocked on, and
>   which task holds a specific mutex.
> * Special handling for when we select a blocked task to run, so that we
>   instead run the mutex holder. 
> 
> The first of these is the most difficult to grasp (I do get the mental
> friction here: blocked tasks on the *run*queue sounds like nonsense!
> Personally I like to think of the runqueue in this model more like a
> “task-selection queue”).
> 
> By leaving blocked tasks on the runqueue, we allow pick_next_task() to
> choose the task that should run next (even if it’s blocked waiting on a
> mutex). If we do select a blocked task, we look at the task’s blocked_on
> mutex and from there look at the mutex’s owner task. And in the simple
> case, the task which owns the mutex is what we then choose to run,
> allowing it to release the mutex.
> 
> This means that instead of just tracking “curr”, the scheduler needs to
> track both the scheduler context (what was picked and all the state used
> for scheduling decisions), and the execution context (what we’re
> running)
> 
> In this way, the mutex owner is run “on behalf” of the blocked task
> that was picked to run, essentially inheriting the scheduler context of
> the blocked task.
> 
> As Connor outlined in a previous submission of this patch series,  this
> raises a number of complicated situations:  The mutex owner might itself
> be blocked on another mutex, or it could be sleeping, running on a
> different CPU, in the process of migrating between CPUs, etc.
> 
> But the functionality provided by Proxy Execution is useful, as in
> Android we have a number of cases where we are seeing priority inversion
> (not unbounded, but longer than we’d like) between “foreground” and
> “background” SCHED_NORMAL applications, so having a generalized solution
> would be very useful.
> 
> New in v4:
> —------
> * Fixed deadlock that was caused by wait/wound mutexes having circular
>   blocked_on references by clearing the blocked_on pointer on the task
>   we are waking to wound/die.

I always get this when running `insmod ./test-ww_mutex.ko` with default
SCHED_FEAT(TTWU_QUEUE, true) with this fix. Don't understand the issue
fully yet:

qemu-system-x86_64 ... -smp cores=64 -enable-kvm ...

[   21.109134] Beginning ww mutex selftests
[   26.397545] ------------[ cut here ]------------
[   26.397951] WARNING: CPU: 41 PID: 0 at kernel/sched/core.c:4126 sched_ttwu_pending+0xc5/0x120
[   26.398590] Modules linked in: test_ww_mutex(+)
[   26.398916] CPU: 41 PID: 0 Comm: swapper/41 Not tainted 6.4.0-rc1-00054-gb4baf2e792df-dirty #9
[   26.399506] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubuntu1.1 04/01/2014
[   26.400193] RIP: 0010:sched_ttwu_pending+0xc5/0x120
[   26.400515] Code: c8 75 ba 41 c7 46 48 00 00 00 00 4c 89 f7 e8 32 b5 d4 00 41 f7 c4 00 02 00 00 74 01
                     fb 5b 5d 41 5c 41 5d 41 5e c3 cc cc cc cc <0f> 0b 44 8b 45 14 8b 8d 20 05 00 00 48
                     8d 95 18 07 00 00 48 c7 c6
[   26.401840] RSP: 0018:ffffa31940990fc0 EFLAGS: 00010006
[   26.402178] RAX: 0000000000000012 RBX: ffffffffffffffc8 RCX: 00000006256a6d58
[   26.402631] RDX: 000000000001c9f4 RSI: ffff9dc5012fe180 RDI: ffffffff97320a40
[   26.403096] RBP: ffff9dc50552d140 R08: 00000006256a6d58 R09: 0000000000000029
[   26.403607] R10: 0000000000000000 R11: ffffa31940990ff8 R12: 0000000000000086
[   26.404117] R13: ffffffffffffffc8 R14: ffff9dc57d86b3c0 R15: 0000000000000000
[   26.404691] FS:  0000000000000000(0000) GS:ffff9dc57d840000(0000) knlGS:0000000000000000
[   26.405236] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   26.405663] CR2: 00007ffeda3d7b00 CR3: 0000000013e2e003 CR4: 0000000000370ee0
[   26.406236] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   26.406715] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   26.407219] Call Trace:
[   26.407390]  <IRQ>
[   26.407571]  __sysvec_call_function_single+0x28/0xc0
[   26.407988]  sysvec_call_function_single+0x69/0x90
[   26.408312]  </IRQ>
[   26.408467]  <TASK>
[   26.408612]  asm_sysvec_call_function_single+0x1a/0x20
[   26.408992] RIP: 0010:default_idle+0xf/0x20
[   26.409267] Code: 4c 01 c7 4c 29 c2 e9 72 ff ff ff 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90
                     f3 0f 1e fa 66 90 0f 00 2d d3 00 40 00 fb f4 <fa> c3 cc cc cc cc 66 66 2e 0f 1f
                     84 00 00 00 00 00 90 90 90 90 90
[   26.410629] RSP: 0018:ffffa319401cbed8 EFLAGS: 00000252
[   26.411073] RAX: ffff9dc57d867f80 RBX: ffff9dc5012fe180 RCX: 4000000000000000
[   26.411625] RDX: 0000000000000001 RSI: 0000000000000087 RDI: 00000000000ed25c
[   26.411788] ------------[ cut here ]------------

extra debug:

sched_ttwu_pending [kworker/u128:87 738] task_cpu(p)=29 cpu_of(rq)=41

[...]
