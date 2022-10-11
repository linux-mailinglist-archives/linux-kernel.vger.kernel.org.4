Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75EB65FB19E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 13:37:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbiJKLh5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 07:37:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbiJKLhx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 07:37:53 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1AC97B78E
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 04:37:51 -0700 (PDT)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MmtvJ1b4bzlVtp;
        Tue, 11 Oct 2022 19:33:16 +0800 (CST)
Received: from dggpemm500002.china.huawei.com (7.185.36.229) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 11 Oct 2022 19:37:49 +0800
Received: from [10.174.179.5] (10.174.179.5) by dggpemm500002.china.huawei.com
 (7.185.36.229) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 11 Oct
 2022 19:37:48 +0800
Subject: Re: [PATCH 00/20] rcu/context-tracking: Merge RCU eqs-dynticks
 counter to context tracking v5
To:     Frederic Weisbecker <frederic@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Phil Auld <pauld@redhat.com>,
        Alex Belits <abelits@marvell.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        "Marco Elver" <elver@google.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Yu Liao <liaoyu15@huawei.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        "kernel test robot" <lkp@intel.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Uladzislau Rezki <uladzislau.rezki@sony.com>,
        Joel Fernandes <joel@joelfernandes.org>
References: <20220628131619.2109651-1-frederic@kernel.org>
From:   Xiongfeng Wang <wangxiongfeng2@huawei.com>
Message-ID: <43a38198-d80f-2135-646c-db7e7990a401@huawei.com>
Date:   Tue, 11 Oct 2022 19:37:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20220628131619.2109651-1-frederic@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.5]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500002.china.huawei.com (7.185.36.229)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Frederic

Thanks for push RCU dynticks counters to upstream. It is very useful. After it
is done, do we have plan to revive the sys-idle feature and use it to shutdown
the tick on the last housekeeping when the whole system is idle. I'm very glad
to help test it if you have some demo patches on your personal repo.

Thanks,
Xiongfeng

On 2022/6/28 21:15, Frederic Weisbecker wrote:
> This is the same as rcu:ctxt.2022.06.21a (no rebase) with minimal changes
> on the following patches:
> 
> * [06/20] fix missing function renames on xtensa (thanks Max Filippov, SOB added)
> * [09/20] fix missing Kconfig renames on xtensa (thanks Max Filippov, SOB added)
>           and also on loongarch.
> * [18/20] remove unecessary and buggy notrace from rcu_preempt_deferred_qs(). It's called
>           after intrumentation_begin() in EQS functions.
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git
> 	rcu/ctxt.2022.06.27
> 
> HEAD: cb0045adde39bba5ffc620a184b1685a869569d8
> 
> Thanks,
> 	Frederic
> ---
> 
> Frederic Weisbecker (19):
>       context_tracking: Remove unused context_tracking_in_user()
>       context_tracking: Add a note about noinstr VS unsafe context tracking functions
>       context_tracking: Rename __context_tracking_enter/exit() to __ct_user_enter/exit()
>       context_tracking: Rename context_tracking_user_enter/exit() to user_enter/exit_callable()
>       context_tracking: Rename context_tracking_enter/exit() to ct_user_enter/exit()
>       context_tracking: Rename context_tracking_cpu_set() to ct_cpu_track_user()
>       context_tracking: Split user tracking Kconfig
>       context_tracking: Take idle eqs entrypoints over RCU
>       context_tracking: Take IRQ eqs entrypoints over RCU
>       context_tracking: Take NMI eqs entrypoints over RCU
>       rcu/context-tracking: Remove rcu_irq_enter/exit()
>       rcu/context_tracking: Move dynticks counter to context tracking
>       rcu/context_tracking: Move dynticks_nesting to context tracking
>       rcu/context_tracking: Move dynticks_nmi_nesting to context tracking
>       rcu/context-tracking: Move deferred nocb resched to context tracking
>       rcu/context-tracking: Move RCU-dynticks internal functions to context_tracking
>       rcu/context-tracking: Remove unused and/or unecessary middle functions
>       context_tracking: Convert state to atomic_t
>       MAINTAINERS: Add Paul as context tracking maintainer
> 
> Paul E. McKenney (1):
>       context_tracking: Use arch_atomic_read() in __ct_state for KASAN
> 
> 
>  .../RCU/Design/Requirements/Requirements.rst       |  10 +-
>  Documentation/RCU/stallwarn.rst                    |   6 +-
>  .../time/context-tracking/arch-support.txt         |   6 +-
>  MAINTAINERS                                        |   1 +
>  arch/Kconfig                                       |   8 +-
>  arch/arm/Kconfig                                   |   2 +-
>  arch/arm/kernel/entry-common.S                     |   4 +-
>  arch/arm/kernel/entry-header.S                     |  12 +-
>  arch/arm/mach-imx/cpuidle-imx6q.c                  |   5 +-
>  arch/arm64/Kconfig                                 |   2 +-
>  arch/arm64/kernel/entry-common.c                   |  14 +-
>  arch/csky/Kconfig                                  |   2 +-
>  arch/csky/kernel/entry.S                           |   8 +-
>  arch/loongarch/Kconfig                             |   2 +-
>  arch/mips/Kconfig                                  |   2 +-
>  arch/powerpc/Kconfig                               |   2 +-
>  arch/powerpc/include/asm/context_tracking.h        |   2 +-
>  arch/riscv/Kconfig                                 |   2 +-
>  arch/riscv/kernel/entry.S                          |  12 +-
>  arch/sparc/Kconfig                                 |   2 +-
>  arch/sparc/kernel/rtrap_64.S                       |   2 +-
>  arch/x86/Kconfig                                   |   4 +-
>  arch/x86/mm/fault.c                                |   2 +-
>  arch/xtensa/Kconfig                                |   2 +-
>  arch/xtensa/kernel/entry.S                         |   8 +-
>  drivers/acpi/processor_idle.c                      |   5 +-
>  drivers/cpuidle/cpuidle-psci.c                     |   8 +-
>  drivers/cpuidle/cpuidle-riscv-sbi.c                |   8 +-
>  drivers/cpuidle/cpuidle.c                          |   9 +-
>  include/linux/context_tracking.h                   |  95 ++--
>  include/linux/context_tracking_irq.h               |  21 +
>  include/linux/context_tracking_state.h             | 113 +++-
>  include/linux/entry-common.h                       |  10 +-
>  include/linux/hardirq.h                            |  12 +-
>  include/linux/rcupdate.h                           |  17 +-
>  include/linux/rcutiny.h                            |   6 -
>  include/linux/rcutree.h                            |   9 +-
>  include/linux/tracepoint.h                         |   4 +-
>  init/Kconfig                                       |   4 +-
>  kernel/cfi.c                                       |   4 +-
>  kernel/context_tracking.c                          | 617 +++++++++++++++++++--
>  kernel/cpu_pm.c                                    |   8 +-
>  kernel/entry/common.c                              |  16 +-
>  kernel/extable.c                                   |   4 +-
>  kernel/locking/lockdep.c                           |   2 +-
>  kernel/rcu/Kconfig                                 |   2 +
>  kernel/rcu/rcu.h                                   |   4 -
>  kernel/rcu/tree.c                                  | 476 +---------------
>  kernel/rcu/tree.h                                  |   8 -
>  kernel/rcu/tree_exp.h                              |   2 +-
>  kernel/rcu/tree_plugin.h                           |  38 +-
>  kernel/rcu/tree_stall.h                            |   8 +-
>  kernel/rcu/update.c                                |   2 +-
>  kernel/sched/core.c                                |   2 +-
>  kernel/sched/idle.c                                |  10 +-
>  kernel/sched/sched.h                               |   1 +
>  kernel/softirq.c                                   |   4 +-
>  kernel/time/Kconfig                                |  37 +-
>  kernel/time/tick-sched.c                           |   2 +-
>  kernel/trace/trace.c                               |   8 +-
>  60 files changed, 934 insertions(+), 764 deletions(-)
> .
> 
