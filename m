Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACE6B6642C2
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 15:07:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232548AbjAJOHR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 09:07:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232395AbjAJOHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 09:07:04 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9FBA3FCB5
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 06:07:02 -0800 (PST)
Received: from kwepemi500024.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Nrsv95HH1zqV6c;
        Tue, 10 Jan 2023 22:02:13 +0800 (CST)
Received: from [10.174.179.163] (10.174.179.163) by
 kwepemi500024.china.huawei.com (7.221.188.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Tue, 10 Jan 2023 22:06:58 +0800
Message-ID: <ab20014e-ed45-0bdc-8ed3-2598244c6614@huawei.com>
Date:   Tue, 10 Jan 2023 22:06:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH -v2] x86/boot/compressed: Register dummy NMI handler in
 EFI boot loader, to avoid kdump crashes
Content-Language: en-US
To:     Ingo Molnar <mingo@kernel.org>
CC:     <michael.roth@amd.com>, <bp@alien8.de>, <hpa@zytor.com>,
        <tglx@linutronix.de>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
        <kirill.shutemov@linux.intel.com>, <jroedel@suse.de>,
        <keescook@chromium.org>, <mingo@redhat.com>,
        <dave.hansen@linux.intel.com>, <brijesh.singh@amd.com>,
        <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        <liwei391@huawei.com>
References: <20230110102745.2514694-1-zengheng4@huawei.com>
 <Y71FJ+G0NGQe3Ppq@gmail.com> <Y71TglxSLJKO17SY@gmail.com>
From:   Zeng Heng <zengheng4@huawei.com>
In-Reply-To: <Y71TglxSLJKO17SY@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.163]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemi500024.china.huawei.com (7.221.188.100)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023/1/10 20:01, Ingo Molnar wrote:
> * Ingo Molnar <mingo@kernel.org> wrote:
>
>> * Zeng Heng <zengheng4@huawei.com> wrote:
>>
>>> +void do_boot_nmi_fault(struct pt_regs *regs, unsigned long error_code)
>>> +{
>>> +	/* ignore */
>>> +}
>>> diff --git a/arch/x86/boot/compressed/idt_64.c b/arch/x86/boot/compressed/idt_64.c
>>> index 6debb816e83d..b169c9728d52 100644
>>> --- a/arch/x86/boot/compressed/idt_64.c
>>> +++ b/arch/x86/boot/compressed/idt_64.c
>>> @@ -60,6 +60,7 @@ void load_stage2_idt(void)
>>>   {
>>>   	boot_idt_desc.address = (unsigned long)boot_idt;
>>>   
>>> +	set_idt_entry(X86_TRAP_NMI, boot_nmi_fault);
>>>   	set_idt_entry(X86_TRAP_PF, boot_page_fault);
>> So it's a bit sad to install a dummy handler that does nothing, while
>> something clearly sent an NMI and expects an intelligent reaction - OTOH
>> the unexpected NMIs from from watchdog during a kdump clearly make things
>> worse by crashing the bootup.
>>
>> Anyway, I cannot think of a better response here that the boot loading code
>> could do either, so I've applied your fix to tip:x86/boot.
> BTW., the changelog had very poor quality, and the patch added no comments
> to explain the presence of the dummy NMI.
>
> The -v2 version below should address most of those problems.
>
> Thanks,
>
> 	Ingo

Thanks for your work.

B.R.,

Zeng Heng

> =============>
> From: Zeng Heng <zengheng4@huawei.com>
> Date: Tue, 10 Jan 2023 18:27:45 +0800
> Subject: [PATCH] x86/boot/compressed: Register dummy NMI handler in EFI boot loader, to avoid kdump crashes
>
> If kdump is enabled, when using mce_inject to inject errors, EFI
> boot loader would decompress & load second kernel for saving the
> vmcore file.
>
> For normal errors that is fine. However, in the MCE case, the panic
> CPU that firstly enters into mce_panic() is running within NMI
> interrupt context, and the processor blocks delivery of subsequent
> NMIs until the next execution of the IRET instruction.
>
> When the panic CPU takes long time in the panic processing route,
> and causes the watchdog timeout, at this moment, the processor
> already receives NMI interrupt in the background.
>
> In the reproducer sequence below, panic CPU would run into EFI loader
> and raise page fault exception (like visiting `vidmem` variable
> when attempting to call debug_putstr()), the CPU would execute IRET
> instruction when it exits from the page fault handler.
>
> But the loader never registers handler for NMI vector in IDT,
> lack of vector handler would cause reboot, which interrupts
> kdump procedure and fails to save the vmcore file.
>
> Here is steps to reproduce the above issue (it's sporadic):
>
> 	1. # cat uncorrected
> 	CPU 1 BANK 4
> 	STATUS uncorrected 0xc0
> 	MCGSTATUS  EIPV MCIP
> 	ADDR 0x1234
> 	RIP 0xdeadbabe
> 	RAISINGCPU 0
> 	MCGCAP SER CMCI TES 0x6
> 	2. # modprobe mce_inject
> 	3. # mce-inject uncorrected
>
> For increasing the probability of reproduction of this issue, there are
> two ways to increase the probability of the bug:
>
>    1. modify the threshold value of watchdog (increase NMI frequency);
>    2. and/or add delays before panic() in mce_panic() and modify PANIC_TIMEOUT macro;
>
> Fixes: ca0e22d4f011 ("x86/boot/compressed/64: Always switch to own page table")
> Signed-off-by: Zeng Heng <zengheng4@huawei.com>
> [ Tidy up changelog, add comments. ]
> Signed-off-by: Ingo Molnar <mingo@kernel.org>
> Link: https://lore.kernel.org/r/20230110102745.2514694-1-zengheng4@huawei.com
> ---
>   arch/x86/boot/compressed/ident_map_64.c    | 12 ++++++++++++
>   arch/x86/boot/compressed/idt_64.c          |  1 +
>   arch/x86/boot/compressed/idt_handlers_64.S |  1 +
>   arch/x86/boot/compressed/misc.h            |  1 +
>   4 files changed, 15 insertions(+)
>
> diff --git a/arch/x86/boot/compressed/ident_map_64.c b/arch/x86/boot/compressed/ident_map_64.c
> index d4a314cc50d6..cbfdefcf9657 100644
> --- a/arch/x86/boot/compressed/ident_map_64.c
> +++ b/arch/x86/boot/compressed/ident_map_64.c
> @@ -379,3 +379,15 @@ void do_boot_page_fault(struct pt_regs *regs, unsigned long error_code)
>   	 */
>   	kernel_add_identity_map(address, end);
>   }
> +
> +void do_boot_nmi_fault(struct pt_regs *regs, unsigned long error_code)
> +{
> +	/*
> +	 * Default boot loader placeholder fault handler - there's no real
> +	 * kernel running yet, so there's not much we can do - but NMIs
> +	 * can arrive in a kdump scenario, for example by the NMI watchdog.
> +	 *
> +	 * Not having any handler would cause the CPU to silently reboot,
> +	 * so we do the second-worst thing here and ignore the NMI.
> +	 */
> +}
> diff --git a/arch/x86/boot/compressed/idt_64.c b/arch/x86/boot/compressed/idt_64.c
> index 6debb816e83d..b169c9728d52 100644
> --- a/arch/x86/boot/compressed/idt_64.c
> +++ b/arch/x86/boot/compressed/idt_64.c
> @@ -60,6 +60,7 @@ void load_stage2_idt(void)
>   {
>   	boot_idt_desc.address = (unsigned long)boot_idt;
>   
> +	set_idt_entry(X86_TRAP_NMI, boot_nmi_fault);
>   	set_idt_entry(X86_TRAP_PF, boot_page_fault);
>   
>   #ifdef CONFIG_AMD_MEM_ENCRYPT
> diff --git a/arch/x86/boot/compressed/idt_handlers_64.S b/arch/x86/boot/compressed/idt_handlers_64.S
> index 22890e199f5b..2aef8e1b515b 100644
> --- a/arch/x86/boot/compressed/idt_handlers_64.S
> +++ b/arch/x86/boot/compressed/idt_handlers_64.S
> @@ -69,6 +69,7 @@ SYM_FUNC_END(\name)
>   	.text
>   	.code64
>   
> +EXCEPTION_HANDLER	boot_nmi_fault do_boot_nmi_fault error_code=0
>   EXCEPTION_HANDLER	boot_page_fault do_boot_page_fault error_code=1
>   
>   #ifdef CONFIG_AMD_MEM_ENCRYPT
> diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
> index 62208ec04ca4..d89d3f8417f6 100644
> --- a/arch/x86/boot/compressed/misc.h
> +++ b/arch/x86/boot/compressed/misc.h
> @@ -187,6 +187,7 @@ static inline void cleanup_exception_handling(void) { }
>   #endif
>   
>   /* IDT Entry Points */
> +void boot_nmi_fault(void);
>   void boot_page_fault(void);
>   void boot_stage1_vc(void);
>   void boot_stage2_vc(void);
