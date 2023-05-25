Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A89A710F3F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 17:13:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241672AbjEYPNV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 11:13:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234629AbjEYPNT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 11:13:19 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17FCCA3
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 08:13:18 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-64d30ab1f89so1731490b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 08:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685027597; x=1687619597;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tVf6vsZ9xC7Q48P/tDe58bfiO8+LPbu6X2NueCsAf00=;
        b=LOISVb4HzMiyG/wDmZF3TrAFqmAlzPzQ08FYvnVC7l3UVRRJGDDUR7J7edq024tj/1
         sJKMh4VrQVtDOMf0BWMlwsfbdbD5MaBjc2qevF/5qLLQry8ksYCGSOAf550Hy8Rsa+tZ
         eF0Hkbou87+9qqOHbXDUBayku7AtfQhPqEk5AGUlxJYaoGL8Jr4CzbKJ8gsVa8L2kbnJ
         K6CCUbmg71+kjt2yzaLx/MUIPvnLrPYlkqnZTTZiWYU+AO5HUAqGg5tdFChrf781FZEB
         4D3RCxFEZH2CCKGN/CdMfDJwc2mhdE6HGwCvq1bHvKrr+ZyZwh/zgE1noN5+VZ6GZOLx
         aPrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685027597; x=1687619597;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tVf6vsZ9xC7Q48P/tDe58bfiO8+LPbu6X2NueCsAf00=;
        b=P4PNg8rmFR8iDFFQlap0cFX8XG6PjaSwyfinbC/jEuFpOGkLeLLJ7GAfw2TASwL7S8
         6lr9YrvdEFm7MK5wQePn/va12mU0cmnrMED1kBwa96A7ntKMZxj8enHvrJJXAIOlDeac
         v9YN2ayrPeaU5Jp7NFbrhN2Rk7V271RbiRMQJrAqtIqtTDjNACieYt7WQkJYiPVip7L7
         IUWBgusSIA13PRmyTN3ZFaWczD7FvsEplu/NTXMXjlGuOja5oXDqOE3IPADK97KvsAVO
         5Wl3q00ALCCssHYZFdUgChKXxW/ZdO4scpJ1qiUV+RvSwABAQBm3OwluvkKLovvDgS6L
         NXLw==
X-Gm-Message-State: AC+VfDxodTaeUgQsIWt7HSI0ahzz+ISvfiyBkLVvZkj7rf04Lu+cWFPr
        qENfn4q/2Gk8kJwwp1pacUNLV5CRnytarBZgZ6do1g==
X-Google-Smtp-Source: ACHHUZ4RZErmRPrCzog/cNmfwrg7E1TkslF8/bSttnz5gTIS45+1wzq1B3IbEy64dDzEXhiSZREkPH0JnrhckEQTU74=
X-Received: by 2002:a05:6a21:3395:b0:10c:663c:31c3 with SMTP id
 yy21-20020a056a21339500b0010c663c31c3mr11613886pzb.29.1685027597353; Thu, 25
 May 2023 08:13:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230524072018.62204-1-yangyicong@huawei.com>
In-Reply-To: <20230524072018.62204-1-yangyicong@huawei.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 25 May 2023 17:13:06 +0200
Message-ID: <CAKfTPtDOvMqHW7sgw1Ht7pV27W-Up61uO+AfSNkGpoMuOF_gXQ@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: Don't balance task to its current running CPU
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

On Wed, 24 May 2023 at 09:21, Yicong Yang <yangyicong@huawei.com> wrote:
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
> current CPU as new_dst_cpu and later triggers the the warning above.
>
> This patch tries to solve this by not select the task's current running
> CPU as new_dst_cpu in the load balance.
>
> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> ---
> Thanks Valentin for the knowledge of migration disable. Previous discussion can
> be found at
> https://lore.kernel.org/all/20230313065759.39698-1-yangyicong@huawei.com/
>
>  kernel/sched/fair.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 7a1b1f855b96..3c4f3a244c1d 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -8456,7 +8456,8 @@ int can_migrate_task(struct task_struct *p, struct lb_env *env)
>
>                 /* Prevent to re-select dst_cpu via env's CPUs: */
>                 for_each_cpu_and(cpu, env->dst_grpmask, env->cpus) {
> -                       if (cpumask_test_cpu(cpu, p->cpus_ptr)) {
> +                       if (cpumask_test_cpu(cpu, p->cpus_ptr) &&
> +                           cpu != env->src_cpu) {

So I'm a bit surprised that src_cpu can be part of the dst_grpmask and
selected as new_dst_cpu. The only reason would be some numa
overlapping domains. Is it the case for you ?

>                                 env->flags |= LBF_DST_PINNED;
>                                 env->new_dst_cpu = cpu;
>                                 break;
> --
> 2.24.0
>
