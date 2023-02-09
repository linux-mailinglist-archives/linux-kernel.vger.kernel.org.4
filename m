Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CE97691025
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 19:14:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbjBISO2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 13:14:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbjBISOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 13:14:23 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB24413D4B
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 10:14:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 792E761B7C
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 18:14:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8825C433D2;
        Thu,  9 Feb 2023 18:14:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675966460;
        bh=wqc+8W13ru5JQp5gJc955Xs1dujcKpGHdtGBfyzBcRQ=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=BU+dftiJ33c82zBy98VEYDS8WZvWhtjwtZDx44CWiBjSCIHrJFvoFR5jfb93WnYWK
         z4SB7t6N8IR8KAoIO/D/kSVdcNL9OGhFlv1POD90Qu2quP6tiKP4JhzB+VD4xkpS9g
         NC9+EdIwSHjTa0Tlqao3jCmSd+0EKZnvRoGgWOMSzN4Y+I4YAwIX6Hy8K1m1Onjrx6
         i7JjI9Vpk0NlOnp4l/yqnIKTTjTdqgKHa6oai3bDet/u8UqSyiNcY0+2Az8QXyYWDN
         D/UQViLevfNxhL6ziy1ko3KIzwsbClwHrnRfTHCHPrmV+1SB8BpD5B3/Y1AZ9jxSan
         jQmNA1/ZSCKIQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 2A3855C099C; Thu,  9 Feb 2023 10:14:20 -0800 (PST)
Date:   Thu, 9 Feb 2023 10:14:20 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Zqiang <qiang1.zhang@intel.com>
Cc:     mingo@redhat.com, peterz@infradead.org, frederic@kernel.org,
        joel@joelfernandes.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/isolation: Fix illegal CPU value by
 housekeeping_any_cpu() return
Message-ID: <20230209181420.GM2948950@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20230209144911.987938-1-qiang1.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230209144911.987938-1-qiang1.zhang@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 09, 2023 at 10:49:11PM +0800, Zqiang wrote:
> For kernels built with CONFIG_NO_HZ_FULL=y, running the following tests:
> 
> runqemu kvm slirp nographic qemuparams="-m 1024 -smp 4" bootparams=
> "console=ttyS0 nohz_full=0,1 rcu_nocbs=0,1 sched_verbose" -d
> 
> root@qemux86-64:~# echo 0 > /sys/devices/system/cpu/cpu2/online
> root@qemux86-64:~# echo 0 > /sys/devices/system/cpu/cpu3/online
> 
> [   22.838290] BUG: unable to handle page fault for address: ffffffff84cd48c0
> [   22.839409] #PF: supervisor read access in kernel mode
> [   22.840215] #PF: error_code(0x0000) - not-present page
> [   22.841028] PGD 3e19067 P4D 3e19067 PUD 3e1a063 PMD 800ffffffb3ff062
> [   22.841889] Oops: 0000 [#1] PREEMPT SMP DEBUG_PAGEALLOC KASAN PTI
> [   22.842175] CPU: 0 PID: 16 Comm: rcu_preempt Not tainted 6.2.0-rc1-yocto-standard+ #658
> [   22.842534] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009),
>                BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.o4
> [   22.843036] RIP: 0010:do_raw_spin_trylock+0x70/0x120
> [   22.843267] Code: 81 c7 00 f1 f1 f1 f1 c7 40 04 04 f3 f3 f3 65
>                48 8b 04 25 28 00 00 00 48 89 45 e0 31 c0 e8 b8 0
> [   22.844187] RSP: 0018:ffff8880072b7b30 EFLAGS: 00010046
> [   22.844429] RAX: 0000000000000000 RBX: ffffffff84cd48c0 RCX: dffffc0000000000
> [   22.844751] RDX: 0000000000000003 RSI: 0000000000000004 RDI: ffffffff84cd48c0
> [   22.845074] RBP: ffff8880072b7ba8 R08: ffffffff811daa20 R09: fffffbfff099a919
> [   22.845400] R10: ffffffff84cd48c3 R11: fffffbfff099a918 R12: 1ffff11000e56f66
> [   22.845719] R13: ffffffff84cd48d8 R14: ffffffff84cd48c0 R15: ffff8880072b7cd8
> [   22.846040] FS:  0000000000000000(0000) GS:ffff888035200000(0000) knlGS:0000000000000000
> [   22.846403] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   22.846667] CR2: ffffffff84cd48c0 CR3: 000000001036c000 CR4: 00000000001506f0
> [   22.846988] Call Trace:
> [   22.847105]  <TASK>
> [   22.847208]  ? __pfx_do_raw_spin_trylock+0x10/0x10
> [   22.847430]  ? rcu_read_unlock+0x26/0x80
> [   22.847612]  ? trace_preempt_off+0x2a/0x130
> [   22.847812]  _raw_spin_lock+0x41/0x80
> [   22.847984]  ? schedule_timeout+0x242/0x580
> [   22.848178]  schedule_timeout+0x242/0x580
> [   22.848366]  ? __pfx_schedule_timeout+0x10/0x10
> [   22.848575]  ? __pfx_do_raw_spin_trylock+0x10/0x10
> [   22.848796]  ? __pfx_process_timeout+0x10/0x10
> [   22.849005]  ? _raw_spin_unlock_irqrestore+0x46/0x80
> [   22.849232]  ? prepare_to_swait_event+0xb8/0x210
> [   22.849450]  rcu_gp_fqs_loop+0x66e/0xe70
> [   22.849633]  ? rcu_gp_init+0x87c/0x1130
> [   22.849813]  ? __pfx_rcu_gp_fqs_loop+0x10/0x10
> [   22.850022]  ? _raw_spin_unlock_irqrestore+0x46/0x80
> [   22.850251]  ? finish_swait+0xce/0x100
> [   22.850429]  rcu_gp_kthread+0x2ea/0x6b0
> [   22.850608]  ? __pfx_do_raw_spin_trylock+0x10/0x10
> [   22.850829]  ? __pfx_rcu_gp_kthread+0x10/0x10
> [   22.851039]  ? __kasan_check_read+0x11/0x20
> [   22.851233]  ? __kthread_parkme+0xe8/0x110
> [   22.851424]  ? __pfx_rcu_gp_kthread+0x10/0x10
> [   22.851627]  kthread+0x172/0x1a0
> [   22.851781]  ? __pfx_kthread+0x10/0x10
> [   22.851956]  ret_from_fork+0x2c/0x50
> [   22.852129]  </TASK>
> 
> schedule_timeout()
> ->__mod_timer()
>  ->get_target_base(base, timer->flags)
>    ->get_timer_cpu_base(tflags, get_nohz_timer_target());
>      ->cpu = get_nohz_timer_target()
>              ->housekeeping_any_cpu(HK_TYPE_TIMER)
>                      /*housekeeping.cpumasks[type] is 2-3*/
> 		     /*cpu_online_mask is 0-1*/
>                ->cpu = cpumask_any_and(housekeeping.cpumasks[type],
> 			cpu_online_mask);
>              /*cpu value is 4*/
>      ->new_base = per_cpu_ptr(&timer_bases[BASE_DEF], cpu);
>    /*new_base is illegal address*/
>  ->if (base != new_base)
>    ->raw_spin_lock(&new_base->lock); ==> trigger Oops
> 
> This commit therefore add checks for cpumask_any_and() return values
> in housekeeping_any_cpu(), if cpumask_any_and() returns an illegal CPU
> value, the housekeeping_any_cpu() will return current CPU number.
> 
> Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> ---
>  kernel/sched/isolation.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
> index 373d42c707bc..e255eb83f14f 100644
> --- a/kernel/sched/isolation.c
> +++ b/kernel/sched/isolation.c
> @@ -46,7 +46,9 @@ int housekeeping_any_cpu(enum hk_type type)
>  			if (cpu < nr_cpu_ids)
>  				return cpu;
>  
> -			return cpumask_any_and(housekeeping.cpumasks[type], cpu_online_mask);
> +			cpu = cpumask_any_and(housekeeping.cpumasks[type], cpu_online_mask);
> +			if (cpu >= nr_cpu_ids)
> +				return smp_processor_id();

Don't we need a "return cpu" here?  Or am I missing something subtle?

							Thanx, Paul

>  		}
>  	}
>  	return smp_processor_id();
> -- 
> 2.25.1
> 
