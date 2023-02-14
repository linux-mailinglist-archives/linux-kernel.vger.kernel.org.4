Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCA9D695F3D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 10:31:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232064AbjBNJba (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 04:31:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjBNJb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 04:31:27 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B48CA233C9
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 01:31:05 -0800 (PST)
Received: from kwepemi500024.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4PGG6P3k3wzJq5X;
        Tue, 14 Feb 2023 17:26:05 +0800 (CST)
Received: from [10.174.179.163] (10.174.179.163) by
 kwepemi500024.china.huawei.com (7.221.188.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Tue, 14 Feb 2023 17:30:47 +0800
Message-ID: <e57ba121-5bcc-e63b-691d-3e3d998e9e48@huawei.com>
Date:   Tue, 14 Feb 2023 17:30:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH v3] x86/kdump: Handle blocked NMIs interrupt to avoid
 kdump crashes
To:     Peter Zijlstra <peterz@infradead.org>
CC:     <mingo@redhat.com>, <bp@alien8.de>, <jroedel@suse.de>,
        <vbabka@suse.cz>, <hpa@zytor.com>, <tglx@linutronix.de>,
        <eric.devolder@oracle.com>, <bhe@redhat.com>, <tiwai@suse.de>,
        <keescook@chromium.org>, <dave.hansen@linux.intel.com>,
        <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        <liwei391@huawei.com>, <xiexiuqi@huawei.com>
References: <20230202014053.3604176-1-zengheng4@huawei.com>
 <Y9t9wvQ0HRwCs1Xh@hirez.programming.kicks-ass.net>
Content-Language: en-US
From:   Zeng Heng <zengheng4@huawei.com>
In-Reply-To: <Y9t9wvQ0HRwCs1Xh@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.163]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemi500024.china.huawei.com (7.221.188.100)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2023/2/2 17:09, Peter Zijlstra 写道:
> On Thu, Feb 02, 2023 at 09:40:53AM +0800, Zeng Heng wrote:
>> If the cpu panics within the NMI interrupt context,
>> there could be unhandled NMI interrupts in the
>> background which are blocked by processor until
>> next IRET instruction executes. Since that, it
>> prevents nested execution of the NMI handler.
>>
>> In case of IRET execution during kdump reboot and
>> no proper NMIs handler registered at that point
>> (such as during EFI loader), we need to handle these
>> blocked NMI interrupts in advance to avoid kdump
>> crashes.
>>
>> Because asm_exc_nmi() has the ability to handle
>> nested NMIs, here call iret_to_self() and execute
>> IRET instruction in order to trigger and handle the
>> possible blocked NMIs interrupts in advance before
>> the IDT set invalidate.
>>
>> Provide one of test case to reproduce the concerned
>> issue, and here is the steps:
>>    1. # cat uncorrected
>>       CPU 1 BANK 4
>>       STATUS uncorrected 0xc0
>>       MCGSTATUS  EIPV MCIP
>>       ADDR 0x1234
>>       RIP 0xdeadbabe
>>       RAISINGCPU 0
>>       MCGCAP SER CMCI TES 0x6
>>    2. # modprobe mce_inject
>>    3. # mce-inject uncorrected
>>
>> Mce-inject would trigger kernel panic under NMI
>> interrupt context. In addition, we need another NMI
>> interrupt raise (such as from watchdog) during panic
>> process. Set proper watchdog threshold value and/or
>> add an artificial delay to make sure watchdog interrupt
>> raise during the panic procedure and the involved
>> issue would occur.
>>
>> Fixes: ca0e22d4f011 ("x86/boot/compressed/64: Always switch to own page table")
>> Signed-off-by: Zeng Heng <zengheng4@huawei.com>
>> Suggested-by: Borislav Petkov <bp@alien8.de>
>> ---
>>    v1: add dummy NMI interrupt handler in EFI loader
>>    v2: tidy up changelog, add comments (by Ingo Molnar)
>>    v3: add iret_to_self() to deal with blocked NMIs in advance
>>
>>   arch/x86/kernel/crash.c | 14 ++++++++++++++
>>   1 file changed, 14 insertions(+)
>>
>> diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
>> index 305514431f26..3aaca680a639 100644
>> --- a/arch/x86/kernel/crash.c
>> +++ b/arch/x86/kernel/crash.c
>> @@ -41,6 +41,7 @@
>>   #include <asm/intel_pt.h>
>>   #include <asm/crash.h>
>>   #include <asm/cmdline.h>
>> +#include <asm/sync_core.h>
>>
>>   /* Used while preparing memory map entries for second kernel */
>>   struct crash_memmap_data {
>> @@ -143,6 +144,19 @@ void native_machine_crash_shutdown(struct pt_regs *regs)
>>
>>   	crash_smp_send_stop();
>>
>> +	/*
>> +	 * If the cpu panics within the NMI interrupt context,
>> +	 * there may be unhandled NMI interrupts which are
>> +	 * blocked by processor until next IRET instruction
>> +	 * executes.
>> +	 *
>> +	 * In case of IRET execution during kdump reboot and
>> +	 * no proper NMIs handler registered at that point,
>> +	 * we trigger and handle blocked NMIs in advance to
>> +	 * avoid kdump crashes.
>> +	 */
>> +	iret_to_self();
>> +
>>   	/*
>>   	 * VMCLEAR VMCSs loaded on this cpu if needed.
>>   	 */
> I never remember the shutdown paths -- do we force wipe the PMU
> registers somewhere before this?

I have checked the panic process, and there is no wipe operation for PMU 
registers,

which causes the watchdog bites.

Do you mean we should directly disable PMU registers instead of calling 
`iret_to_self` to

consume blocked NMI interrupts ?


Best regards,

zeng heng

