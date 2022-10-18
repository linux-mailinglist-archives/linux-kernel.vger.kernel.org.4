Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DE2660213A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 04:34:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbiJRCeB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 22:34:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbiJRCd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 22:33:58 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7712F7E839;
        Mon, 17 Oct 2022 19:33:56 -0700 (PDT)
Received: from dggpeml500025.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MryXh5l7fzJn6W;
        Tue, 18 Oct 2022 10:31:16 +0800 (CST)
Received: from dggpeml500003.china.huawei.com (7.185.36.200) by
 dggpeml500025.china.huawei.com (7.185.36.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 18 Oct 2022 10:33:54 +0800
Received: from [10.174.177.173] (10.174.177.173) by
 dggpeml500003.china.huawei.com (7.185.36.200) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 18 Oct 2022 10:33:53 +0800
Message-ID: <fcb5d4e2-2632-411e-239c-bcd6a5ebd085@huawei.com>
Date:   Tue, 18 Oct 2022 10:33:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [BUG] possible deadlock in __rcu_irq_enter_check_tick
Content-Language: en-US
To:     "Zhang, Qiang1" <qiang1.zhang@intel.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>
CC:     "liwei (GF)" <liwei391@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "paulmck@kernel.org" <paulmck@kernel.org>
References: <e015e32d-d068-2d17-1ca5-c584c30ffebb@huawei.com>
 <20221012064911.GN4221@paulmck-ThinkPad-P17-Gen-1>
 <PH0PR11MB5880A8E6EFE6D57EF44C4A9EDA299@PH0PR11MB5880.namprd11.prod.outlook.com>
From:   Yu Liao <liaoyu15@huawei.com>
In-Reply-To: <PH0PR11MB5880A8E6EFE6D57EF44C4A9EDA299@PH0PR11MB5880.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.173]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500003.china.huawei.com (7.185.36.200)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/10/17 17:32, Zhang, Qiang1 wrote:
> On Tue, Oct 11, 2022 at 09:18:11PM +0800, Yu Liao wrote:
>> Hello,
>>
>> When I run syzkaller, a deadlock problem occurs. The call stack is as follows:
>> [ 1088.244366][    C1] ======================================================
>> [ 1088.244838][    C1] WARNING: possible circular locking dependency detected
>> [ 1088.245313][    C1] 5.10.0-04424-ga472e3c833d3 #1 Not tainted
>> [ 1088.245745][    C1] ------------------------------------------------------
>>
>> It is quite possible that an unfortunate set of commits were backported
>> to v5.10.  Could you please bisect?
>>
> 
> Hi Yu liao
> 
> This looks like the result of the following commit:
> 
> commit 2a9b3e6ac69a8bf177d8496a11e749e2dc72fa22
> Author: Mark Rutland <mark.rutland@arm.com>
> Date:   Mon Nov 30 11:59:50 2020 +0000
> 
>     arm64: entry: fix EL1 debug transitions
> 
> 
> Is it possible to try the following modification?  maybe Mark have better solution.
> 
Thanks for the reply, this problem was reported by syzkaller, and I have not
been able to reproduce it yet. But this modification seems to work, when
called from arm64_enter_el1_dbg it prevents rcu_nmi_enter from calling
rcu_irq_enter_check_tick which may holds the rcu_node lock.

Thanks
Yu Liao
> --- a/arch/arm64/kernel/entry-common.c
> +++ b/arch/arm64/kernel/entry-common.c
> @@ -259,7 +259,7 @@ static void noinstr el1_inv(struct pt_regs *regs, unsigned long esr)
>  static void noinstr arm64_enter_el1_dbg(struct pt_regs *regs)
>  {
>         regs->lockdep_hardirqs = lockdep_hardirqs_enabled();
> -
> +       __nmi_enter();
>         lockdep_hardirqs_off(CALLER_ADDR0);
>         rcu_nmi_enter();
> 
> @@ -278,6 +278,7 @@ static void noinstr arm64_exit_el1_dbg(struct pt_regs *regs)
>         rcu_nmi_exit();
>         if (restore)
>                 lockdep_hardirqs_on(CALLER_ADDR0);
> +       __nmi_exit();
>  }
> 
> Thanks
> Zqiang
> 
> 
>> [ 1088.246214][    C1] syz-executor.2/932 is trying to acquire lock:
>> [ 1088.246628][    C1] ffffa0001440c418 (rcu_node_0){..-.}-{2:2}, at:
>> __rcu_irq_enter_check_tick+0x128/0x2f4
>> [ 1088.247330][    C1]
>> [ 1088.247330][    C1] but task is already holding lock:
>> [ 1088.247830][    C1] ffff000224d0c298 (&rq->lock){-.-.}-{2:2}, at:
>> try_to_wake_up+0x6e0/0xd40
>> [ 1088.248424][    C1]
>> [ 1088.248424][    C1] which lock already depends on the new lock.
>> [ 1088.248424][    C1]
>> [ 1088.249127][    C1]
>> [ 1088.249127][    C1] the existing dependency chain (in reverse order) is:
>> [ 1088.249726][    C1]
>> [ 1088.249726][    C1] -> #1 (&rq->lock){-.-.}-{2:2}:
>> [ 1088.250239][    C1]        validate_chain+0x6dc/0xb0c
>> [ 1088.250591][    C1]        __lock_acquire+0x498/0x940
>> [ 1088.250942][    C1]        lock_acquire+0x228/0x580
>> [ 1088.251346][    C1]        _raw_spin_lock_irqsave+0xc0/0x15c
>> [ 1088.251758][    C1]        resched_cpu+0x5c/0x110
>> [ 1088.252091][    C1]        rcu_implicit_dynticks_qs+0x2b0/0x5d0
>> [ 1088.252501][    C1]        force_qs_rnp+0x244/0x39c
>> [ 1088.252847][    C1]        rcu_gp_fqs_loop+0x2e4/0x440
>> [ 1088.253219][    C1]        rcu_gp_kthread+0x1a4/0x240
>> [ 1088.253597][    C1]        kthread+0x20c/0x260
>> [ 1088.253963][    C1]        ret_from_fork+0x10/0x18
>> [ 1088.254389][    C1]
>> [ 1088.254389][    C1] -> #0 (rcu_node_0){..-.}-{2:2}:
>> [ 1088.255296][    C1]        check_prev_add+0xe0/0x105c
>> [ 1088.256000][    C1]        check_prevs_add+0x1c8/0x3d4
>> [ 1088.256693][    C1]        validate_chain+0x6dc/0xb0c
>> [ 1088.257372][    C1]        __lock_acquire+0x498/0x940
>> [ 1088.257731][    C1]        lock_acquire+0x228/0x580
>> [ 1088.258079][    C1]        _raw_spin_lock+0xa0/0x120
>> [ 1088.258425][    C1]        __rcu_irq_enter_check_tick+0x128/0x2f4
>> [ 1088.258844][    C1]        rcu_nmi_enter+0xc4/0xd0
>>
>> This is looking like we took an interrupt while holding an rq lock.
>> Am I reading this correctly?  If so, that is bad in and of itself.
>>
>> 							Thanx, Paul
>>
>> [ 1088.259183][    C1]        arm64_enter_el1_dbg+0xb0/0x160
>> [ 1088.259623][    C1]        el1_dbg+0x28/0x50
>> [ 1088.260011][    C1]        el1_sync_handler+0xf4/0x150
>> [ 1088.260481][    C1]        el1_sync+0x74/0x100
>> [ 1088.260800][    C1]        update_irq_load_avg+0x5d8/0xaa0
>> [ 1088.261194][    C1]        update_rq_clock_task+0xb8/0x2d0
>> [ 1088.261595][    C1]        update_rq_clock+0x8c/0x120
>> [ 1088.261952][    C1]        try_to_wake_up+0x70c/0xd40
>> [ 1088.262305][    C1]        wake_up_process+0x1c/0x24
>> [ 1088.262652][    C1]        wakeup_softirqd+0x58/0x64
>> [ 1088.263000][    C1]        __do_softirq+0x6b8/0x95c
>> [ 1088.263345][    C1]        irq_exit+0x27c/0x2d0
>> [ 1088.263674][    C1]        __handle_domain_irq+0x100/0x184
>> [ 1088.264049][    C1]        gic_handle_irq+0xc0/0x760
>> [ 1088.264394][    C1]        el1_irq+0xb8/0x140
>> [ 1088.264709][    C1]        _raw_spin_unlock_irqrestore+0x7c/0x130
>> [ 1088.265134][    C1]        __aarch64_insn_write+0xc4/0x100
>> [ 1088.265516][    C1]        aarch64_insn_patch_text_nosync+0x40/0xa0
>> [ 1088.265942][    C1]        ftrace_make_nop+0x120/0x1a4
>> [ 1088.266300][    C1]        __ftrace_replace_code+0xdc/0x160
>> [ 1088.266684][    C1]        ftrace_replace_code+0x100/0x1a4
>> [ 1088.267063][    C1]        ftrace_modify_all_code+0x1a8/0x260
>> [ 1088.267456][    C1]        arch_ftrace_update_code+0x1c/0x2c
>> [ 1088.267847][    C1]        ftrace_run_update_code+0x38/0xa4
>> [ 1088.268259][    C1]        ftrace_shutdown.part.0+0x2dc/0x550
>> [ 1088.268682][    C1]        unregister_ftrace_function+0x74/0xc0
>> [ 1088.269117][    C1]        perf_ftrace_event_register+0x130/0x1a0
>> [ 1088.269559][    C1]        perf_trace_destroy+0x68/0x9c
>> [ 1088.269938][    C1]        tp_perf_event_destroy+0x1c/0x2c
>> [ 1088.270340][    C1]        _free_event+0x2f4/0x670
>> [ 1088.270696][    C1]        put_event+0x7c/0x90
>> [ 1088.271031][    C1]        perf_event_release_kernel+0x3c0/0x450
>> [ 1088.271467][    C1]        perf_release+0x24/0x34
>> [ 1088.271824][    C1]        __fput+0x1dc/0x500
>> [ 1088.272155][    C1]        ____fput+0x24/0x30
>> [ 1088.272471][    C1]        task_work_run+0xf4/0x1ec
>> [ 1088.272811][    C1]        do_notify_resume+0x378/0x410
>> [ 1088.273180][    C1]        work_pending+0xc/0x198
>> [ 1088.273504][    C1]
>> [ 1088.273504][    C1] other info that might help us debug this:
>> [ 1088.273504][    C1]
>> [ 1088.274168][    C1]  Possible unsafe locking scenario:
>> [ 1088.274168][    C1]
>> [ 1088.274658][    C1]        CPU0                    CPU1
>> [ 1088.275012][    C1]        ----                    ----
>> [ 1088.275367][    C1]   lock(&rq->lock);
>> [ 1088.275646][    C1]                                lock(rcu_node_0);
>> [ 1088.276082][    C1]                                lock(&rq->lock);
>> [ 1088.276517][    C1]   lock(rcu_node_0);
>> [ 1088.276797][    C1]
>> [ 1088.276797][    C1]  *** DEADLOCK ***
>> [ 1088.276797][    C1]
>> [ 1088.277339][    C1] 4 locks held by syz-executor.2/932:
>> [ 1088.277696][    C1]  #0: ffffa000145251e8 (event_mutex){+.+.}-{3:3}, at:
>> perf_trace_destroy+0x34/0x9c
>> [ 1088.278345][    C1]  #1: ffffa000144fb5a8 (ftrace_lock){+.+.}-{3:3}, at:
>> unregister_ftrace_function+0x2c/0xc0
>> [ 1088.279034][    C1]  #2: ffff0000c0e0c968 (&p->pi_lock){-.-.}-{2:2}, at:
>> try_to_wake_up+0xbc/0xd40
>> [ 1088.279672][    C1]  #3: ffff000224d0c298 (&rq->lock){-.-.}-{2:2}, at:
>> try_to_wake_up+0x6e0/0xd40
>> [ 1088.280300][    C1]
>> [ 1088.280300][    C1] stack backtrace:
>> [ 1088.280706][    C1] CPU: 1 PID: 932 Comm: syz-executor.2 Not tainted
>> 5.10.0-04424-ga472e3c833d3 #1
>> [ 1088.281315][    C1] Hardware name: linux,dummy-virt (DT)
>> [ 1088.281679][    C1] Call trace:
>> [ 1088.281910][    C1]  dump_backtrace+0x0/0x41c
>> [ 1088.282218][    C1]  show_stack+0x30/0x40
>> [ 1088.282505][    C1]  dump_stack+0x1fc/0x2c0
>> [ 1088.282807][    C1]  print_circular_bug+0x1ec/0x284
>> [ 1088.283149][    C1]  check_noncircular+0x1cc/0x1ec
>> [ 1088.283486][    C1]  check_prev_add+0xe0/0x105c
>> [ 1088.283804][    C1]  check_prevs_add+0x1c8/0x3d4
>> [ 1088.284126][    C1]  validate_chain+0x6dc/0xb0c
>> [ 1088.284442][    C1]  __lock_acquire+0x498/0x940
>> [ 1088.284764][    C1]  lock_acquire+0x228/0x580
>> [ 1088.285072][    C1]  _raw_spin_lock+0xa0/0x120
>> [ 1088.285392][    C1]  __rcu_irq_enter_check_tick+0x128/0x2f4
>> [ 1088.285779][    C1]  rcu_nmi_enter+0xc4/0xd0
>> [ 1088.286082][    C1]  arm64_enter_el1_dbg+0xb0/0x160
>> [ 1088.286420][    C1]  el1_dbg+0x28/0x50
>> [ 1088.286689][    C1]  el1_sync_handler+0xf4/0x150
>> [ 1088.287010][    C1]  el1_sync+0x74/0x100
>> [ 1088.287295][    C1]  update_irq_load_avg+0x5d8/0xaa0
>> [ 1088.287640][    C1]  update_rq_clock_task+0xb8/0x2d0
>> [ 1088.287988][    C1]  update_rq_clock+0x8c/0x120
>> [ 1088.288309][    C1]  try_to_wake_up+0x70c/0xd40
>> [ 1088.288629][    C1]  wake_up_process+0x1c/0x24
>> [ 1088.288945][    C1]  wakeup_softirqd+0x58/0x64
>> [ 1088.289271][    C1]  __do_softirq+0x6b8/0x95c
>> [ 1088.289580][    C1]  irq_exit+0x27c/0x2d0
>> [ 1088.289868][    C1]  __handle_domain_irq+0x100/0x184
>> [ 1088.290211][    C1]  gic_handle_irq+0xc0/0x760
>> [ 1088.290522][    C1]  el1_irq+0xb8/0x140
>> [ 1088.290801][    C1]  _raw_spin_unlock_irqrestore+0x7c/0x130
>> [ 1088.291188][    C1]  __aarch64_insn_write+0xc4/0x100
>> [ 1088.291533][    C1]  aarch64_insn_patch_text_nosync+0x40/0xa0
>> [ 1088.291928][    C1]  ftrace_make_nop+0x120/0x1a4
>> [ 1088.292256][    C1]  __ftrace_replace_code+0xdc/0x160
>> [ 1088.292613][    C1]  ftrace_replace_code+0x100/0x1a4
>> [ 1088.292963][    C1]  ftrace_modify_all_code+0x1a8/0x260
>> [ 1088.293335][    C1]  arch_ftrace_update_code+0x1c/0x2c
>> [ 1088.293694][    C1]  ftrace_run_update_code+0x38/0xa4
>> [ 1088.294048][    C1]  ftrace_shutdown.part.0+0x2dc/0x550
>> [ 1088.294415][    C1]  unregister_ftrace_function+0x74/0xc0
>> [ 1088.294787][    C1]  perf_ftrace_event_register+0x130/0x1a0
>> [ 1088.295172][    C1]  perf_trace_destroy+0x68/0x9c
>> [ 1088.295500][    C1]  tp_perf_event_destroy+0x1c/0x2c
>> [ 1088.295850][    C1]  _free_event+0x2f4/0x670
>> [ 1088.296154][    C1]  put_event+0x7c/0x90
>> [ 1088.296439][    C1]  perf_event_release_kernel+0x3c0/0x450
>> [ 1088.296820][    C1]  perf_release+0x24/0x34
>> [ 1088.297125][    C1]  __fput+0x1dc/0x500
>> [ 1088.297404][    C1]  ____fput+0x24/0x30
>> [ 1088.297682][    C1]  task_work_run+0xf4/0x1ec
>> [ 1088.297989][    C1]  do_notify_resume+0x378/0x410
>> [ 1088.298316][    C1]  work_pending+0xc/0x198
>>
