Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC8617164A6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 16:45:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230430AbjE3OpW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 10:45:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230402AbjE3OpU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 10:45:20 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C048C9D
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 07:45:18 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-2564dc37c3eso1998632a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 07:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685457918; x=1688049918;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yV6a04b62bfNJUZXNfKu/8vbCtHkV+mBE6B8etB9GBo=;
        b=TarhzH5yM/fV63eG1rr53xcznQcz/s2cMDRMTPgezUdtY9j3c3OhxFB9JPRUMpDMjK
         V1D2s+uzrQzEtZ2YNVo5rIIaOl6U+jv4nq0Q0k4mokXFbJCByQ1Y503wu1Q8CvAHcG7n
         G5BpesNCyDk8UcztX7Ta4uMOISSt7sJ5felh/JAMysgls+ObX27UqvEEdG2k4BFHMC+R
         8EmUAY9XPx4pX1tP08axAbopIdVWrppmOOH+HyHSdbKZS6qm9nDMk3BT8s3paemyj+sS
         yeEHxV/bl07QnYJNw/erMzO/hbKdlI4g+o+wa+gPRfRuLxWa5rViUucoSIiCqP2f8QU8
         8JHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685457918; x=1688049918;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yV6a04b62bfNJUZXNfKu/8vbCtHkV+mBE6B8etB9GBo=;
        b=M6SHyX0QY3Zh1NdT4n6nvog/Zjg5phzSm0DDzSC/xFogBxZhV8Ub8KGZF0BypfZMQx
         KL6AMJAvWkbGqHF83FzyCK5S66pLdJIzVNmEGcaqrS1S/HPbhj2IvTcXpmd6gOQCCoUY
         Bid44sPmgecff1qwZtm/Xvi6MV4PR1KMp8Z7oKypjOvvx1gdxWUxu6mSsJ93FAtZpFo5
         68OELuavLlkVF+3laeQBn3o5CpymZ8mmwtvLks5lEJ/PzfE0qjv48FEi2YYj5c9FUP2s
         wm0h5qrNvCXBp8XINWRsivk4ptPMdYOTw8x8tm1xOAQEYrW47QhVGAmpjk/HmjEsCHbH
         OvUw==
X-Gm-Message-State: AC+VfDwRFZ7XsoS2bfDMhNvNjSHyMD0Xuxwh4dMs08KtxLzwvzmay8b4
        P1e7F0g1RPC2VbVBfcDG9nVwzj5JCb8NLhrYxRU2vgVzzUgmBC8/
X-Google-Smtp-Source: ACHHUZ7Uzlo5lKpxdfl8tc1/NXzcFk63jxiXikfiUNWgin8rc5qdEt0tDPXBxbEr3NZIJZGpEY2rQaVwxvWvMphz5NA=
X-Received: by 2002:a17:90b:2348:b0:24e:14a4:9b92 with SMTP id
 ms8-20020a17090b234800b0024e14a49b92mr2820133pjb.5.1685457918198; Tue, 30 May
 2023 07:45:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230530082507.10444-1-yangyicong@huawei.com>
In-Reply-To: <20230530082507.10444-1-yangyicong@huawei.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 30 May 2023 16:45:07 +0200
Message-ID: <CAKfTPtCujzU0musRE=FxvgR4rky76XnqaF=ak6U5YwgWnZu9KQ@mail.gmail.com>
Subject: Re: [PATCH v2] sched/fair: Don't balance task to its current running CPU
To:     Yicong Yang <yangyicong@huawei.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        yu.c.chen@intel.com, linuxarm@huawei.com, prime.zeng@huawei.com,
        wangjie125@huawei.com, yangyicong@hisilicon.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 May 2023 at 10:26, Yicong Yang <yangyicong@huawei.com> wrote:
>
> From: Yicong Yang <yangyicong@hisilicon.com>
>
> We've run into the case that the balancer tries to balance a migration
> disabled task and trigger the warning in set_task_cpu() like below:
>
>  ------------[ cut here ]------------
>  WARNING: CPU: 7 PID: 0 at kernel/sched/core.c:3115 set_task_cpu+0x188/0x240
>  Modules linked in: hclgevf xt_CHECKSUM ipt_REJECT nf_reject_ipv4 <...snip>
>  CPU: 7 PID: 0 Comm: swapper/7 Kdump: loaded Tainted: G           O       6.1.0-rc4+ #1
>  Hardware name: Huawei TaiShan 2280 V2/BC82AMDC, BIOS 2280-V2 CS V5.B221.01 12/09/2021
>  pstate: 604000c9 (nZCv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>  pc : set_task_cpu+0x188/0x240
>  lr : load_balance+0x5d0/0xc60
>  sp : ffff80000803bc70
>  x29: ffff80000803bc70 x28: ffff004089e190e8 x27: ffff004089e19040
>  x26: ffff007effcabc38 x25: 0000000000000000 x24: 0000000000000001
>  x23: ffff80000803be84 x22: 000000000000000c x21: ffffb093e79e2a78
>  x20: 000000000000000c x19: ffff004089e19040 x18: 0000000000000000
>  x17: 0000000000001fad x16: 0000000000000030 x15: 0000000000000000
>  x14: 0000000000000003 x13: 0000000000000000 x12: 0000000000000000
>  x11: 0000000000000001 x10: 0000000000000400 x9 : ffffb093e4cee530
>  x8 : 00000000fffffffe x7 : 0000000000ce168a x6 : 000000000000013e
>  x5 : 00000000ffffffe1 x4 : 0000000000000001 x3 : 0000000000000b2a
>  x2 : 0000000000000b2a x1 : ffffb093e6d6c510 x0 : 0000000000000001
>  Call trace:
>   set_task_cpu+0x188/0x240
>   load_balance+0x5d0/0xc60
>   rebalance_domains+0x26c/0x380
>   _nohz_idle_balance.isra.0+0x1e0/0x370
>   run_rebalance_domains+0x6c/0x80
>   __do_softirq+0x128/0x3d8
>   ____do_softirq+0x18/0x24
>   call_on_irq_stack+0x2c/0x38
>   do_softirq_own_stack+0x24/0x3c
>   __irq_exit_rcu+0xcc/0xf4
>   irq_exit_rcu+0x18/0x24
>   el1_interrupt+0x4c/0xe4
>   el1h_64_irq_handler+0x18/0x2c
>   el1h_64_irq+0x74/0x78
>   arch_cpu_idle+0x18/0x4c
>   default_idle_call+0x58/0x194
>   do_idle+0x244/0x2b0
>   cpu_startup_entry+0x30/0x3c
>   secondary_start_kernel+0x14c/0x190
>   __secondary_switched+0xb0/0xb4
>  ---[ end trace 0000000000000000 ]---
>
> Further investigation shows that the warning is superfluous, the migration
> disabled task is just going to be migrated to its current running CPU.
> This is because that on load balance if the dst_cpu is not allowed by the
> task, we'll re-select a new_dst_cpu as a candidate. If no task can be
> balanced to dst_cpu we'll try to balance the task to the new_dst_cpu
> instead. In this case when the migration disabled task is not on CPU it
> only allows to run on its current CPU, load balance will select its
> current CPU as new_dst_cpu and later triggers the warning above.
>
> The new_dst_cpu is chosen from the env->dst_grpmask. Currently it
> contains CPUs in sched_group_span() and if we have overlapped groups it's
> possible to run into this case. This patch makes env->dst_grpmask of
> group_balance_mask() which exclude any CPUs from the busiest group and
> solve the issue. For balancing in a domain with no overlapped groups
> the behaviour keeps same as before.
>
> Suggested-by: Vincent Guittot <vincent.guittot@linaro.org>
> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>

Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>

> ---
> Change since v1:
> - Solve the issue by making env->dst_cpumask of group_balance_mask(), per Vincent
> Link: https://lore.kernel.org/all/20230524072018.62204-1-yangyicong@huawei.com/
>
> - Thanks Valentin for the knowledge of migration disable. Previous discussion can
> be found at
> https://lore.kernel.org/all/20230313065759.39698-1-yangyicong@huawei.com/
>
>  kernel/sched/fair.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 373ff5f55884..0128dc9344cc 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -10744,7 +10744,7 @@ static int load_balance(int this_cpu, struct rq *this_rq,
>                 .sd             = sd,
>                 .dst_cpu        = this_cpu,
>                 .dst_rq         = this_rq,
> -               .dst_grpmask    = sched_group_span(sd->groups),
> +               .dst_grpmask    = group_balance_mask(sd->groups),
>                 .idle           = idle,
>                 .loop_break     = SCHED_NR_MIGRATE_BREAK,
>                 .cpus           = cpus,
> --
> 2.24.0
>
