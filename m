Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09A28729D7C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 16:56:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231880AbjFIO4X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 10:56:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240841AbjFIO4O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 10:56:14 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE44B3C0D
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 07:55:46 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686322537;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=z1hdB/vFVE45XIPK9ERIBNmxTcvOEAi7QtCWRI08vE4=;
        b=41PCry0bCNNKUu7xqplNbVFZ0NN5EWsw8XlDuKMb/YQ0VhDq0buMxxXe1scrxCHwcd9aHY
        +ETo8/Xk9uQ0fHFCbIhyGjgMW2yq3bTSkwUpUN9YvYA/iJZTTYXJ87cRmbMugsPkbcgiy2
        GioDwKICEa8KaXuXBp1Cw7GknMhIkF9+oa7iC0wGJMBbOqhCxHKNeBoZ0d3Qh/lerKhWVE
        pH8cZuxFX+ESUBb26KJyi7UDlr0J8dyLgORLsqu2zADDzihEUKn//+HEYqClxIphcMENJP
        VuVZyuLKRjgKyD9w7LXggsdODJMFptPj8W/+iK4Vla+45mY/oKfbG5ticFd9Dw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686322537;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=z1hdB/vFVE45XIPK9ERIBNmxTcvOEAi7QtCWRI08vE4=;
        b=6OJmqEfIKbIqa5MWE1h9iPhGCslT8k5paJIZtLJqhyBxJIAMrhY8npPbHEmcNK6wlKvJKr
        j2HjwhL0yDbjnuAg==
To:     Xiongfeng Wang <wangxiongfeng2@huawei.com>, vschneid@redhat.com,
        Phil Auld <pauld@redhat.com>, vdonnefort@google.com
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        wangxiongfeng2@huawei.com, Wei Li <liwei391@huawei.com>,
        "liaoyu (E)" <liaoyu15@huawei.com>, zhangqiao22@huawei.com,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [Question] report a race condition between CPU hotplug state
 machine and hrtimer 'sched_cfs_period_timer' for cfs bandwidth throttling
In-Reply-To: <8e785777-03aa-99e1-d20e-e956f5685be6@huawei.com>
References: <8e785777-03aa-99e1-d20e-e956f5685be6@huawei.com>
Date:   Fri, 09 Jun 2023 16:55:37 +0200
Message-ID: <87mt18it1y.ffs@tglx>
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

On Fri, Jun 09 2023 at 19:24, Xiongfeng Wang wrote:

Cc+ scheduler people, leave context intact

> Hello,
>  When I do some low power tests, the following hung task is printed.
>
>   Call trace:
>    __switch_to+0xd4/0x160
>    __schedule+0x38c/0x8c4
>    __cond_resched+0x24/0x50
>    unmap_kernel_range_noflush+0x210/0x240
>    kretprobe_trampoline+0x0/0xc8
>    __vunmap+0x70/0x31c
>    __vfree+0x34/0x8c
>    vfree+0x40/0x58
>    free_vm_stack_cache+0x44/0x74
>    cpuhp_invoke_callback+0xc4/0x71c
>    _cpu_down+0x108/0x284
>    kretprobe_trampoline+0x0/0xc8
>    suspend_enter+0xd8/0x8ec
>    suspend_devices_and_enter+0x1f0/0x360
>    pm_suspend.part.1+0x428/0x53c
>    pm_suspend+0x3c/0xa0
>    devdrv_suspend_proc+0x148/0x248 [drv_devmng]
>    devdrv_manager_set_power_state+0x140/0x680 [drv_devmng]
>    devdrv_manager_ioctl+0xcc/0x210 [drv_devmng]
>    drv_ascend_intf_ioctl+0x84/0x248 [drv_davinci_intf]
>    __arm64_sys_ioctl+0xb4/0xf0
>    el0_svc_common.constprop.0+0x140/0x374
>    do_el0_svc+0x80/0xa0
>    el0_svc+0x1c/0x28
>    el0_sync_handler+0x90/0xf0
>    el0_sync+0x168/0x180
>
> After some analysis, I found it is caused by the following race condition.
>
> 1. A task running on CPU1 is throttled for cfs bandwidth. CPU1 starts the
> hrtimer cfs_bandwidth 'period_timer' and enqueue the hrtimer on CPU1's rbtree.
> 2. Then the task is migrated to CPU2 and starts to offline CPU1. CPU1 starts
> CPUHP AP steps, and then the hrtimer 'period_timer' expires and re-enqueued on CPU1.
> 3. CPU1 runs to take_cpu_down() and disable irq. After CPU1 finished CPUHP AP
> steps, CPU2 starts the rest CPUHP step.
> 4. When CPU2 runs to free_vm_stack_cache(), it is sched out in __vunmap()
> because it run out of CPU quota. start_cfs_bandwidth() does not restart the
> hrtimer because 'cfs_b->period_active' is set.
> 5. The task waits the hrtimer 'period_timer' to expire to wake itself up, but
> CPU1 has disabled irq and the hrtimer won't expire until it is migrated to CPU2
> in hrtimers_dead_cpu(). But the task is blocked and cannot proceed to
> hrtimers_dead_cpu() step. So the task hungs.
>
>     CPU1      			                 	 CPU2
> Task set cfs_quota
> start hrtimer cfs_bandwidth 'period_timer'
> 						start to offline CPU1
> CPU1 start CPUHP AP step
> ...
> 'period_timer' expired and re-enqueued on CPU1
> ...
> disable irq in take_cpu_down()
> ...
> 						CPU2 start the rest CPUHP steps
> 						...
> 					      sched out in free_vm_stack_cache()
> 						wait for 'period_timer' expires
>
>
> Appreciate it a lot if anyone can give some suggestion on how fix this problem !
>
> Thanks,
> Xiongfeng
