Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07D125B87FE
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 14:17:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbiINMR1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 08:17:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbiINMRZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 08:17:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93A178002C;
        Wed, 14 Sep 2022 05:17:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DEB24B81A85;
        Wed, 14 Sep 2022 12:17:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F12EC433D6;
        Wed, 14 Sep 2022 12:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663157840;
        bh=LjtHbeZOr/9JZEa7I1H/izsxurCxnOeMIcYC+J1+aGs=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=sEyT2ykKw5xH/pP9Hx+oU+bejvLCDQg48R4lelTpHYlzyftUN27nlFuqvDcUwa0KI
         aPMup65AArkc45lCd7J7Qx+slsiBOM13gdPp57B/VrfDTG3mQZ7AMl4QS2eZzD9Xmt
         uGBKWBSdqRV0GkDewrCXAytx+XjmWqp35X80nT01IJGoo+tssWRXmdBfGi9PiB1WE8
         21R9oX+uNT/IPejMwuB8CNMJEVnhduE/p4ec0sI0i7BRqG77xExsQJqjU/YnZbpWxu
         9SZqfRbIH2X4vAgd3yAJ5+VfNLcbchn34+eg9Forg1Fv4UMkuPqHN+7ZQbbpfOS3JV
         pYv2ID47Y0YVw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id C15255C06AB; Wed, 14 Sep 2022 05:17:17 -0700 (PDT)
Date:   Wed, 14 Sep 2022 05:17:17 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Zhouyi Zhou <zhouzhouyi@gmail.com>
Cc:     mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        atrajeev@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, lance@osuosl.org, rcu@vger.kernel.org
Subject: Re: [PATCH linux-next][RFC] powerpc: protect cpu offlining by RCU
 offline lock
Message-ID: <20220914121717.GY246308@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220914021528.15946-1-zhouzhouyi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220914021528.15946-1-zhouzhouyi@gmail.com>
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 14, 2022 at 10:15:28AM +0800, Zhouyi Zhou wrote:
> During the cpu offlining, the sub functions of xive_teardown_cpu will
> call __lock_acquire when CONFIG_LOCKDEP=y. The latter function will
> travel RCU protected list, so "WARNING: suspicious RCU usage" will be
> triggered.
> 
> Try to protect cpu offlining by RCU offline lock.

Rather than acquiring the RCU lock, why not change the functions called
by xive_teardown_cpu() to avoid calling __lock_acquire()?  For example,
a call to spin_lock() could be changed to arch_spin_lock().

							Thanx, Paul

> Tested on PPC VM of Open Source Lab of Oregon State University.
> (Each round of tests takes about 19 hours to finish)
> Test results show that although "WARNING: suspicious RCU usage" has gone,
> but there are more "BUG: soft lockup" reports than the original kernel
> (10 vs 6), so I add a [RFC] to my subject line.
> 
> Signed-off-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
> ---
> [it seems that there are some delivery problem in my previous email,
>  so I send again via gmail, sorry for the trouble]
>  
> Dear PPC and RCU developers
> 
> I found this bug when trying to do rcutorture tests in ppc VM of
> Open Source Lab of Oregon State University.
> 
> console.log report following bug:
> [   37.635545][    T0] WARNING: suspicious RCU usage^M
> [   37.636409][    T0] 6.0.0-rc4-next-20220907-dirty #8 Not tainted^M
> [   37.637575][    T0] -----------------------------^M
> [   37.638306][    T0] kernel/locking/lockdep.c:3723 RCU-list traversed in non-reader section!!^M
> [   37.639651][    T0] ^M
> [   37.639651][    T0] other info that might help us debug this:^M
> [   37.639651][    T0] ^M
> [   37.641381][    T0] ^M
> [   37.641381][    T0] RCU used illegally from offline CPU!^M
> [   37.641381][    T0] rcu_scheduler_active = 2, debug_locks = 1^M
> [   37.667170][    T0] no locks held by swapper/6/0.^M
> [   37.668328][    T0] ^M
> [   37.668328][    T0] stack backtrace:^M
> [   37.669995][    T0] CPU: 6 PID: 0 Comm: swapper/6 Not tainted 6.0.0-rc4-next-20220907-dirty #8^M
> [   37.672777][    T0] Call Trace:^M
> [   37.673729][    T0] [c000000004653920] [c00000000097f9b4] dump_stack_lvl+0x98/0xe0 (unreliable)^M
> [   37.678579][    T0] [c000000004653960] [c0000000001f2eb8] lockdep_rcu_suspicious+0x148/0x16c^M
> [   37.680425][    T0] [c0000000046539f0] [c0000000001ed9b4] __lock_acquire+0x10f4/0x26e0^M
> [   37.682450][    T0] [c000000004653b30] [c0000000001efc2c] lock_acquire+0x12c/0x420^M
> [   37.684113][    T0] [c000000004653c20] [c0000000010d704c] _raw_spin_lock_irqsave+0x6c/0xc0^M
> [   37.686154][    T0] [c000000004653c60] [c0000000000c7b4c] xive_spapr_put_ipi+0xcc/0x150^M
> [   37.687879][    T0] [c000000004653ca0] [c0000000010c72a8] xive_cleanup_cpu_ipi+0xc8/0xf0^M
> [   37.689856][    T0] [c000000004653cf0] [c0000000010c7370] xive_teardown_cpu+0xa0/0xf0^M
> [   37.691877][    T0] [c000000004653d30] [c0000000000fba5c] pseries_cpu_offline_self+0x5c/0x100^M
> [   37.693882][    T0] [c000000004653da0] [c00000000005d2c4] arch_cpu_idle_dead+0x44/0x60^M
> [   37.695739][    T0] [c000000004653dc0] [c0000000001c740c] do_idle+0x16c/0x3d0^M
> [   37.697536][    T0] [c000000004653e70] [c0000000001c7a1c] cpu_startup_entry+0x3c/0x40^M
> [   37.699694][    T0] [c000000004653ea0] [c00000000005ca20] start_secondary+0x6c0/0xb50^M
> [   37.701742][    T0] [c000000004653f90] [c00000000000d054] start_secondary_prolog+0x10/0x14^M
> 
> 
> I am a beginner, hope I can be of some beneficial to the community ;-)
> 
> Thanks
> Zhouyi
> --
>  arch/powerpc/platforms/pseries/hotplug-cpu.c |  5 ++++-
>  include/linux/rcupdate.h                     |  3 ++-
>  kernel/rcu/tree.c                            | 10 ++++++++++
>  3 files changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/pseries/hotplug-cpu.c b/arch/powerpc/platforms/pseries/hotplug-cpu.c
> index 0f8cd8b06432..ddf66a253c70 100644
> --- a/arch/powerpc/platforms/pseries/hotplug-cpu.c
> +++ b/arch/powerpc/platforms/pseries/hotplug-cpu.c
> @@ -64,11 +64,14 @@ static void pseries_cpu_offline_self(void)
>  
>  	local_irq_disable();
>  	idle_task_exit();
> +
> +	/* Because the cpu is now offline, let rcu know that */
> +	rcu_state_ofl_lock();
>  	if (xive_enabled())
>  		xive_teardown_cpu();
>  	else
>  		xics_teardown_cpu();
> -
> +	rcu_state_ofl_unlock();
>  	unregister_slb_shadow(hwcpu);
>  	rtas_stop_self();
>  
> diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
> index 63d2e6a60ad7..d857955a02ba 100644
> --- a/include/linux/rcupdate.h
> +++ b/include/linux/rcupdate.h
> @@ -1034,5 +1034,6 @@ rcu_head_after_call_rcu(struct rcu_head *rhp, rcu_callback_t f)
>  /* kernel/ksysfs.c definitions */
>  extern int rcu_expedited;
>  extern int rcu_normal;
> -
> +void rcu_state_ofl_lock(void);
> +void rcu_state_ofl_unlock(void);
>  #endif /* __LINUX_RCUPDATE_H */
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 6bb8e72bc815..3282725f1054 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -4796,6 +4796,16 @@ void __init rcu_init(void)
>  		(void)start_poll_synchronize_rcu_expedited();
>  }
>  
> +void rcu_state_ofl_lock(void)
> +{
> +	arch_spin_lock(&rcu_state.ofl_lock);
> +}
> +
> +void rcu_state_ofl_unlock(void)
> +{
> +	arch_spin_unlock(&rcu_state.ofl_lock);
> +}
> +
>  #include "tree_stall.h"
>  #include "tree_exp.h"
>  #include "tree_nocb.h"
> -- 
> 2.34.1
> 
