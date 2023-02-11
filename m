Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E16A693052
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 12:29:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbjBKL3g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 06:29:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjBKL3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 06:29:33 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06E6640CC
        for <linux-kernel@vger.kernel.org>; Sat, 11 Feb 2023 03:29:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 97BD460BFB
        for <linux-kernel@vger.kernel.org>; Sat, 11 Feb 2023 11:29:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2827C4339E
        for <linux-kernel@vger.kernel.org>; Sat, 11 Feb 2023 11:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676114972;
        bh=C3bjROftDAPM+bZdQkNNgbRlbm6TOtzl9Ub93ftiVEo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=LwMv/50uD4n72UOgutSUODC3C2KbqcgXa/4JPQi6yFjIPD+hFvA/c/iY+hBfU2M2w
         4UCxgjW71QCIMUJLIIIyPAMGY2yXS8R0seUgpeeiC/z6ZVZxxKLYLhFcBXsBscdDtV
         rkwa3um1nrH8kfRZw0a9lhBBZ3auZAWOyAqPEwFbmO1ZIy3U8o9JPp+Ci6XwNcABIJ
         ikPHNQhPxQeRRI/AmmPMhUfza2saZOZ/dpe2be+SSw7O3LA8lrkS/+dinpa3c7TuiU
         MVi/RPcK7opUrX/A/yFyqLKIdQ2Q66jhKbJqjAW6o39LdkM7gZp4JP/4AH1t2ybZ2c
         lgZ7DGFfaCG1g==
Received: by mail-ed1-f43.google.com with SMTP id d40so6028717eda.8
        for <linux-kernel@vger.kernel.org>; Sat, 11 Feb 2023 03:29:31 -0800 (PST)
X-Gm-Message-State: AO0yUKV2P9QikAY+h19Z5nM7OmpPju8HQpRRXNQn34GmsetaT14xc6Za
        9owJkuaWfz+w9OLzsW7M10OYw+VzOiRTkI47fZE=
X-Google-Smtp-Source: AK7set+mmZzUyxF0iFAFzDbCYZQofszUN0H6Ke2DyAdDADTjdww9OENwHEgM992BZmbHnkRY8IK7Zr2NepClMRtDeik=
X-Received: by 2002:a50:cd8e:0:b0:49d:ec5e:1e9a with SMTP id
 p14-20020a50cd8e000000b0049dec5e1e9amr4443908edi.7.1676114970137; Sat, 11 Feb
 2023 03:29:30 -0800 (PST)
MIME-Version: 1.0
References: <1676114191-13386-1-git-send-email-yangtiezhu@loongson.cn>
In-Reply-To: <1676114191-13386-1-git-send-email-yangtiezhu@loongson.cn>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Sat, 11 Feb 2023 19:29:17 +0800
X-Gmail-Original-Message-ID: <CAAhV-H76gvrBFoFcFyqfr1rBew_cLmXEEh+4qWt+A-h_adAjBw@mail.gmail.com>
Message-ID: <CAAhV-H76gvrBFoFcFyqfr1rBew_cLmXEEh+4qWt+A-h_adAjBw@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: Only call get_timer_irq() once in constant_clockevent_init()
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org, loongson-kernel@lists.loongnix.cn
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Tiezhu,

On Sat, Feb 11, 2023 at 7:16 PM Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
>
> Under CONFIG_DEBUG_ATOMIC_SLEEP=y and CONFIG_DEBUG_PREEMPT=y, we can see
> the following messages on LoongArch, this is because using might_sleep()
> in preemption disable context.
>
> [    0.001127] smp: Bringing up secondary CPUs ...
> [    0.001222] Booting CPU#1...
> [    0.001244] 64-bit Loongson Processor probed (LA464 Core)
> [    0.001247] CPU1 revision is: 0014c012 (Loongson-64bit)
> [    0.001250] FPU1 revision is: 00000000
> [    0.001252] BUG: sleeping function called from invalid context at kernel/locking/mutex.c:283
> [    0.001255] in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 0, name: swapper/1
> [    0.001257] preempt_count: 1, expected: 0
> [    0.001258] RCU nest depth: 0, expected: 0
> [    0.001259] Preemption disabled at:
> [    0.001261] [<9000000000223800>] arch_dup_task_struct+0x20/0x110
> [    0.001272] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 6.2.0-rc7+ #43
> [    0.001275] Hardware name: Loongson Loongson-3A5000-7A1000-1w-A2101/Loongson-LS3A5000-7A1000-1w-A2101, BIOS vUDK2018-LoongArch-V4.0.05132-beta10 12/13/202
> [    0.001277] Stack : 0072617764726148 0000000000000000 9000000000222f1c 90000001001e0000
> [    0.001286]         90000001001e3be0 90000001001e3be8 0000000000000000 0000000000000000
> [    0.001292]         90000001001e3be8 0000000000000040 90000001001e3cb8 90000001001e3a50
> [    0.001297]         9000000001642000 90000001001e3be8 be694d10ce4139dd 9000000100174500
> [    0.001303]         0000000000000001 0000000000000001 00000000ffffe0a2 0000000000000020
> [    0.001309]         000000000000002f 9000000001354116 00000000056b0000 ffffffffffffffff
> [    0.001314]         0000000000000000 0000000000000000 90000000014f6e90 9000000001642000
> [    0.001320]         900000000022b69c 0000000000000001 0000000000000000 9000000001736a90
> [    0.001325]         9000000100038000 0000000000000000 9000000000222f34 0000000000000000
> [    0.001331]         00000000000000b0 0000000000000004 0000000000000000 0000000000070000
> [    0.001337]         ...
> [    0.001339] Call Trace:
> [    0.001342] [<9000000000222f34>] show_stack+0x5c/0x180
> [    0.001346] [<90000000010bdd80>] dump_stack_lvl+0x60/0x88
> [    0.001352] [<9000000000266418>] __might_resched+0x180/0x1cc
> [    0.001356] [<90000000010c742c>] mutex_lock+0x20/0x64
> [    0.001359] [<90000000002a8ccc>] irq_find_matching_fwspec+0x48/0x124
> [    0.001364] [<90000000002259c4>] constant_clockevent_init+0x68/0x204
> [    0.001368] [<900000000022acf4>] start_secondary+0x40/0xa8
> [    0.001371] [<90000000010c0124>] smpboot_entry+0x60/0x64
>
> Here are the complete call chains:
>
> smpboot_entry()
>   start_secondary()
>     constant_clockevent_init()
>       get_timer_irq()
>         irq_find_matching_fwnode()
>           irq_find_matching_fwspec()
>             mutex_lock()
>               might_sleep()
>                 __might_sleep()
>                   __might_resched()
>
> In order to avoid the above issue, we should break the call chains,
> using timer_irq_installed variable as check condition to only call
> get_timer_irq() once in constant_clockevent_init() is a simple and
> proper way.
>
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>  arch/loongarch/kernel/time.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/arch/loongarch/kernel/time.c b/arch/loongarch/kernel/time.c
> index a6576de..6263b5a 100644
> --- a/arch/loongarch/kernel/time.c
> +++ b/arch/loongarch/kernel/time.c
> @@ -140,14 +140,15 @@ static int get_timer_irq(void)
>
>  int constant_clockevent_init(void)
>  {
> -       int irq;
> +       static int irq;
>         unsigned int cpu = smp_processor_id();
>         unsigned long min_delta = 0x600;
>         unsigned long max_delta = (1UL << 48) - 1;
>         struct clock_event_device *cd;
>         static int timer_irq_installed = 0;
>
> -       irq = get_timer_irq();
> +       if (timer_irq_installed == 0)
> +               irq = get_timer_irq();
>         if (irq < 0)
>                 pr_err("Failed to map irq %d (timer)\n", irq);
This should also be in the if condition, but you don't need to send a
new version. :)

Huacai
>
> --
> 2.1.0
>
