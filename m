Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 437CB698F07
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 09:51:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbjBPIvw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 03:51:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjBPIvu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 03:51:50 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3A1503A09D
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 00:51:49 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9EE901042;
        Thu, 16 Feb 2023 00:52:31 -0800 (PST)
Received: from [10.34.100.128] (pierre123.nice.arm.com [10.34.100.128])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 08A143F703;
        Thu, 16 Feb 2023 00:51:46 -0800 (PST)
Message-ID: <6c0fd4d4-9424-172f-e17e-66c0267abd92@arm.com>
Date:   Thu, 16 Feb 2023 09:51:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v3] firmware: arm_sdei: Fix sleep from invalid context BUG
To:     James Morse <james.morse@arm.com>, Will Deacon <will@kernel.org>
Cc:     Huacai Chen <chenhuacai@kernel.org>,
        Atish Patra <atishp@atishpatra.org>,
        Shaokun Zhang <zhangshaokun@hisilicon.com>,
        WANG Xuerui <git@xen0n.name>,
        Guangbin Huang <huangguangbin2@huawei.com>,
        Bharat Bhushan <bbhushan2@marvell.com>,
        Bibo Mao <maobibo@loongson.cn>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Juergen Gross <jgross@suse.com>,
        Nick Child <nnac123@linux.ibm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230215160949.94602-1-pierre.gondois@arm.com>
 <2b06fd6c-83d5-3dbe-0227-02091f5d3dac@arm.com>
Content-Language: en-US
From:   Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <2b06fd6c-83d5-3dbe-0227-02091f5d3dac@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/15/23 19:13, James Morse wrote:
> Hi Pierre, Will,
> 
> On 15/02/2023 16:09, Pierre Gondois wrote:
>> Running a preemp_rt kernel based on vv6.2-rc3-rt1 based kernel on an
>> Ampere Altra triggers:
>>    BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:46
>>    in_atomic(): 0, irqs_disabled(): 128, non_block: 0, pid: 24, name: cpuhp/0
>>    preempt_count: 0, expected: 0
>>    RCU nest depth: 0, expected: 0
>>    3 locks held by cpuhp/0/24:
>>     #0: ffffda30217c70d0 (cpu_hotplug_lock){++++}-{0:0}, at: cpuhp_thread_fun+0x5c/0x248
>>     #1: ffffda30217c7120 (cpuhp_state-up){+.+.}-{0:0}, at: cpuhp_thread_fun+0x5c/0x248
>>     #2: ffffda3021c711f0 (sdei_list_lock){....}-{3:3}, at: sdei_cpuhp_up+0x3c/0x130
>>    irq event stamp: 36
>>    hardirqs last  enabled at (35): [<ffffda301e85b7bc>] finish_task_switch+0xb4/0x2b0
>>    hardirqs last disabled at (36): [<ffffda301e812fec>] cpuhp_thread_fun+0x21c/0x248
>>    softirqs last  enabled at (0): [<ffffda301e80b184>] copy_process+0x63c/0x1ac0
>>    softirqs last disabled at (0): [<0000000000000000>] 0x0
>>    CPU: 0 PID: 24 Comm: cpuhp/0 Not tainted 5.19.0-rc3-rt5-[...]
>>    Hardware name: WIWYNN Mt.Jade Server [...]
>>    Call trace:
>>     dump_backtrace+0x114/0x120
>>     show_stack+0x20/0x70
>>     dump_stack_lvl+0x9c/0xd8
>>     dump_stack+0x18/0x34
>>     __might_resched+0x188/0x228
>>     rt_spin_lock+0x70/0x120
>>     sdei_cpuhp_up+0x3c/0x130
>>     cpuhp_invoke_callback+0x250/0xf08
>>     cpuhp_thread_fun+0x120/0x248
>>     smpboot_thread_fn+0x280/0x320
>>     kthread+0x130/0x140
>>     ret_from_fork+0x10/0x20
>>
>> sdei_cpuhp_up() is called in the STARTING hotplug section,
>> which runs whith interrupts disabled. Use a CPUHP_AP_ONLINE_DYN entry
> 
> Typo: with
> 
>> instead to execute the cpuhp cb later, with preemption enabled.
>>
>> SDEI originaly got its own cpuhp slot because to allow interracting
> 
> Typo: originally
> Typo: interacting
> 
>> with perf. It got superseded by pNMI and this early slot is not
>> relevant anymore. [1]
> 
> (Please add a spell checker to your workflow. 'codespell' knows which bits of
>   a diff it should check)
> 
> "because to allow interacting" isn't easy to parse, "to allow an interaction with"?
> 
> 
>> Some SDEI calls (e.g. SDEI_1_0_FN_SDEI_PE_MASK) take actions on the
>> calling CPU. It is checked that preemption is disabled for them.
>> _ONLINE cpuhp cb are executed in the 'per CPU hotplug thread'.
>> Preemption is enabled in those threads, but their cpumask is limited
>> to 1 CPU.
>> Move 'WARN_ON_ONCE(preemptible())' statements so that SDEI cpuhp cb
>> don't trigger them.
>>
>> Also add a check for the SDEI_1_0_FN_SDEI_PRIVATE_RESET SDEI call
>> which acts on the calling CPU.
> 
> Thanks for sticking with this,
> 
> Reviewed-by: James Morse <james.morse@arm.com>
> 
> 
> Will, are you happy to pick this up and fix the typos, or would you prefer a clean version
> to be posted?

I re-posted the patch with the typos corrected at:
https://lore.kernel.org/all/20230216084920.144064-1-pierre.gondois@arm.com/

sorry for those,
Regards,
Pierre

> 
> 
> Thanks,
> 
> James
