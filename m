Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4897961F8AC
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 17:14:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232744AbiKGQO0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 11:14:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232511AbiKGQOW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 11:14:22 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C187D6B
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 08:14:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 43781B81151
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 16:14:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 597BEC433C1;
        Mon,  7 Nov 2022 16:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667837658;
        bh=8drlGFPWT+4zRBSJGyTdu5Q3x+jj0nADH5k69cVKWOs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BA1A5ifIWCD5A52rdUTVJbghYPT4GLWS3cEeOuePzU+zC8zHluxCV1Bfvlkpm8viH
         3sZsz07PQISTVga3BHnvC4fRJVKnlRhIvZvQuSuBY8r8bYQdiWZSV2hZ4zrJxZvyoG
         8DQQ0jpscMw3e5R+k6zAvLJu9VA9oSVlKsCGecvZ8qT3KeYA2Od57twEPQ3o4NtnqS
         9Udy3W4CQkdGgSnr93fyiZnEufgIWwmvRKyqeYTzLsZs/NmmNad0rHhxHdcCbzJfVN
         /lsjf4suUXEtvrRoHk0zo5tMx8cQdURfJsNvJA5pYb9RVsmIvkp/8p9Xdeda19jbgc
         ZeSwMmMh4m1Ww==
Date:   Mon, 7 Nov 2022 16:14:12 +0000
From:   Will Deacon <will@kernel.org>
To:     Pierre Gondois <pierre.gondois@arm.com>
Cc:     linux-kernel@vger.kernel.org, James Morse <james.morse@arm.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Shaokun Zhang <zhangshaokun@hisilicon.com>,
        WANG Xuerui <git@xen0n.name>, Qi Liu <liuqi115@huawei.com>,
        Bharat Bhushan <bbhushan2@marvell.com>,
        Huang Ying <ying.huang@intel.com>,
        Bibo Mao <maobibo@loongson.cn>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] firmware: arm_sdei: Fix sleep from invalid context BUG
Message-ID: <20221107161411.GF21157@willie-the-truck>
References: <20221018130456.1356081-1-pierre.gondois@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221018130456.1356081-1-pierre.gondois@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 18, 2022 at 03:04:53PM +0200, Pierre Gondois wrote:
> On an Ampere Altra,
> Running a preemp_rt kernel based on v5.19-rc3-rt5 on an
> Ampere Altra triggers:
> [   15.683141] BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:46
> [   15.683154] in_atomic(): 0, irqs_disabled(): 128, non_block: 0, pid: 24, name: cpuhp/0
> [   15.683157] preempt_count: 0, expected: 0
> [   15.683159] RCU nest depth: 0, expected: 0
> [   15.683163] 3 locks held by cpuhp/0/24:
> [   15.683167]  #0: ffffda30217c70d0 (cpu_hotplug_lock){++++}-{0:0}, at: cpuhp_thread_fun+0x5c/0x248
> [   15.683201]  #1: ffffda30217c7120 (cpuhp_state-up){+.+.}-{0:0}, at: cpuhp_thread_fun+0x5c/0x248
> [   15.683205]  #2: ffffda3021c711f0 (sdei_list_lock){....}-{3:3}, at: sdei_cpuhp_up+0x3c/0x130
> [   15.683224] irq event stamp: 36
> [   15.683226] hardirqs last  enabled at (35): [<ffffda301e85b7bc>] finish_task_switch+0xb4/0x2b0
> [   15.683236] hardirqs last disabled at (36): [<ffffda301e812fec>] cpuhp_thread_fun+0x21c/0x248
> [   15.683238] softirqs last  enabled at (0): [<ffffda301e80b184>] copy_process+0x63c/0x1ac0
> [   15.683245] softirqs last disabled at (0): [<0000000000000000>] 0x0
> [   15.683258] CPU: 0 PID: 24 Comm: cpuhp/0 Not tainted 5.19.0-rc3-rt5-[...]
> [   15.683265] Hardware name: WIWYNN Mt.Jade Server System B81.03001.0005/Mt.Jade Motherboard, BIOS 1.08.20220218 (SCP: 1.08.20220218) 2022/02/18
> [   15.683268] Call trace:
> [   15.683271]  dump_backtrace+0x114/0x120
> [   15.683277]  show_stack+0x20/0x70
> [   15.683279]  dump_stack_lvl+0x9c/0xd8
> [   15.683288]  dump_stack+0x18/0x34
> [   15.683289]  __might_resched+0x188/0x228
> [   15.683292]  rt_spin_lock+0x70/0x120
> [   15.683301]  sdei_cpuhp_up+0x3c/0x130
> [   15.683303]  cpuhp_invoke_callback+0x250/0xf08
> [   15.683305]  cpuhp_thread_fun+0x120/0x248
> [   15.683308]  smpboot_thread_fn+0x280/0x320
> [   15.683315]  kthread+0x130/0x140
> [   15.683321]  ret_from_fork+0x10/0x20
> 
> sdei_cpuhp_up() is called in the STARTING hotplug section,
> which runs whith interrupts disabled. Move CPUHP_AP_ARM_SDEI_
> state to the _ONLINE section to execute the cpuhp cb with
> preemption enabled.
> 
> Some SDEI calls (e.g. SDEI_1_0_FN_SDEI_PE_MASK) take actions on the
> calling CPU. It is checked that preemption is disabled for them.
> _ONLINE cpuhp cb are executed in the 'per CPU hotplug thread'.
> Preemption is enabled in those threads, but their cpumask is limited
> to 1 CPU.
> Move 'WARN_ON_ONCE(preemptible())' statements so that SDEI cpuhp cb
> don't trigger them. This means that no check will be done for some
> cases, e.g. sdei_mask_local_cpu() invocations.
> 
> Also add a check for the SDEI_1_0_FN_SDEI_PRIVATE_RESET SDEI call
> which acts on the calling CPU.
> 
> Suggested-by: James Morse <james.morse@arm.com>
> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
> ---
>  drivers/firmware/arm_sdei.c | 28 ++++++++++++++--------------
>  include/linux/cpuhotplug.h  |  2 +-
>  2 files changed, 15 insertions(+), 15 deletions(-)

James -- are you taking care of this one, or should I queue it via arm64?

Will
