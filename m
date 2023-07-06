Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A2FC7495DB
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 08:44:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbjGFGoh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 02:44:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbjGFGof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 02:44:35 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A26B119B
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 23:44:33 -0700 (PDT)
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4QxRnB2d43zTm85;
        Thu,  6 Jul 2023 14:43:26 +0800 (CST)
Received: from [10.174.177.174] (10.174.177.174) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 6 Jul 2023 14:44:29 +0800
Message-ID: <d7f266fd-e34d-e26e-e371-ee6ff13b6696@huawei.com>
Date:   Thu, 6 Jul 2023 14:44:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [BUG REPORT] Triggering a panic in an x86 virtual machine does
 not wait
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     <arjan@linux.intel.com>, <ashok.raj@intel.com>,
        <ashok.raj@linux.intel.com>, <ebiederm@xmission.com>,
        <linux-kernel@vger.kernel.org>, <mario.limonciello@amd.com>,
        <thomas.lendacky@amd.com>, <tony.luck@intel.com>,
        <tonyb@cybernetics.com>, <x86@kernel.org>,
        yangerkun <yangerkun@huawei.com>, Baoquan He <bhe@redhat.com>,
        <kexec@lists.infradead.org>, Baokun Li <libaokun1@huawei.com>
References: <20230615193330.608657211@linutronix.de>
 <71578392-63ed-02a9-24da-2adf8cce38c7@huawei.com> <87ttui91jo.ffs@tglx>
From:   Baokun Li <libaokun1@huawei.com>
In-Reply-To: <87ttui91jo.ffs@tglx>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.174]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500021.china.huawei.com (7.185.36.21)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/7/5 16:59, Thomas Gleixner wrote:
> On Mon, Jul 03 2023 at 11:44, Baokun Li wrote:
>
>> When I manually trigger panic in a qume x86 VM with
>>
>>          `echo c > /proc/sysrq-trigger`,
>>
>>    I find that the VM will probably reboot directly, but the
>> PANIC_TIMEOUT is 0.
>> This prevents us from exporting the vmcore via panic, and even if we succeed
>> in panic exporting the vmcore, the processes in the vmcore are mostly
>> stop_this_cpu(). By dichotomizing we found the patch that introduced the
>> behavior change
>>
>>      45e34c8af58f ("x86/smp: Put CPUs into INIT on shutdown if possible"),
> Bah, I missed that this is used by crash too. So if this happens to be
> invoked on an AP, i.e. not on CPU 0, then the INIT will reset the
> machine. Fix below.
>
> Thanks,
>
>          tglx
> ---
> diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
> index ed2d51960a7d..e1aa2cd7734b 100644
> --- a/arch/x86/kernel/smpboot.c
> +++ b/arch/x86/kernel/smpboot.c
> @@ -1348,6 +1348,14 @@ bool smp_park_other_cpus_in_init(void)
>   	if (apic->wakeup_secondary_cpu_64 || apic->wakeup_secondary_cpu)
>   		return false;
>   
> +	/*
> +	 * If this is a crash stop which does not execute on the boot CPU,
> +	 * then this cannot use the INIT mechanism because INIT to the boot
> +	 * CPU will reset the machine.
> +	 */
> +	if (this_cpu)
> +		return false;
> +
>   	for_each_present_cpu(cpu) {
>   		if (cpu == this_cpu)
>   			continue;
This patch does fix the problem of rebooting at panic, but the exported 
stack
stays at stop_this_cpu() like below, instead of showing what the 
corresponding
process is doing as before.

PID: 681      TASK: ffff9ac2429d3080  CPU: 2    COMMAND: "fsstress"
  #0 [ffffb00200184fd0] stop_this_cpu at ffffffff89a4ffd8
  #1 [ffffb00200184fe8] __sysvec_reboot at ffffffff89a94213
  #2 [ffffb00200184ff0] sysvec_reboot at ffffffff8aee7491
--- <IRQ stack> ---
     RIP: 0000000000000010  RSP: 0000000000000018  RFLAGS: ffffb00200f8bd08
     RAX: ffff9ac256fda9d8  RBX: 0000000009973a85  RCX: ffff9ac256fda078
     RDX: ffff9ac24416e300  RSI: ffff9ac256fda9e0  RDI: ffffffffffffffff
     RBP: ffff9ac2443a5f88   R8: 0000000000000000   R9: ffff9ac2422eeea0
     R10: ffff9ac256fda9d8  R11: 0000000000549921  R12: ffff9ac2422eeea0
     R13: ffff9ac251cd23c8  R14: ffff9ac24269a800  R15: ffff9ac251cd2150
     ORIG_RAX: ffffffff8a1719e4  CS: 0206  SS: ffffffff8a1719c8
bt: WARNING: possibly bogus exception frame

Do you know how this happened? I would be grateful if you could fix it.

Thanks!
-- 
With Best Regards,
Baokun Li
.
