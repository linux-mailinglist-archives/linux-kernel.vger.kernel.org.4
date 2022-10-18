Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CFE1602653
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 10:01:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230375AbiJRIBw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 04:01:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230218AbiJRIBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 04:01:50 -0400
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE37F7CAA2;
        Tue, 18 Oct 2022 01:01:48 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=xianting.tian@linux.alibaba.com;NM=1;PH=DS;RN=24;SR=0;TI=SMTPD_---0VSTkHr-_1666080101;
Received: from 30.221.96.155(mailfrom:xianting.tian@linux.alibaba.com fp:SMTPD_---0VSTkHr-_1666080101)
          by smtp.aliyun-inc.com;
          Tue, 18 Oct 2022 16:01:43 +0800
Message-ID: <c60b60c0-59ac-6544-186d-9ac79b742734@linux.alibaba.com>
Date:   Tue, 18 Oct 2022 16:01:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.12.0
Subject: Re: [PATCH V2 1/2] RISC-V: Add arch_crash_save_vmcoreinfo support
To:     Conor.Dooley@microchip.com, conor@kernel.org
Cc:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, anup@brainfault.org, heiko@sntech.de,
        guoren@kernel.org, mick@ics.forth.gr,
        alexandre.ghiti@canonical.com, bhe@redhat.com, vgoyal@redhat.com,
        dyoung@redhat.com, corbet@lwn.net, bagasdotme@gmail.com,
        kexec@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        crash-utility@redhat.com, heinrich.schuchardt@canonical.com,
        k-hagio-ab@nec.com, hschauhan@nulltrace.org, yixun.lan@gmail.com
References: <20221014134139.5151-1-xianting.tian@linux.alibaba.com>
 <20221014134139.5151-2-xianting.tian@linux.alibaba.com>
 <Y02y9eN1TNJteTw6@spud>
 <78420277-215f-55d0-67b8-fbf9208b3d22@linux.alibaba.com>
 <642e0529-1df1-86e9-f7de-a6252ba9fd12@microchip.com>
From:   Xianting Tian <xianting.tian@linux.alibaba.com>
In-Reply-To: <642e0529-1df1-86e9-f7de-a6252ba9fd12@microchip.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2022/10/18 下午3:19, Conor.Dooley@microchip.com 写道:
> On 18/10/2022 03:28, Xianting Tian wrote:
>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>>
>> 在 2022/10/18 上午3:54, Conor Dooley 写道:
>>
>>> On Fri, Oct 14, 2022 at 09:41:38PM +0800, Xianting Tian wrote:
>>>>    * Linux Kernel 5.18 ~
>>>>    *      PGTABLE_LEVELS = 5
>>>>    *      PAGE_OFFSET = 0xff60000000000000
>>>>    * Linux Kernel 5.17 ~
>>>>    *      PGTABLE_LEVELS = 4
>>>>    *      PAGE_OFFSET = 0xffffaf8000000000
>>>>    * Linux Kernel 4.19 ~
>>>>    *      PGTABLE_LEVELS = 3
>>>>    *      PAGE_OFFSET = 0xffffffe000000000
>>>>
>>>> Since these configurations change from time to time and version to version,
>>>> it is preferable to export them via vmcoreinfo than to change the crash's
>>>> code frequently, it can simplify the development of crash tool.
>>>>
>>>> Signed-off-by: Xianting Tian<xianting.tian@linux.alibaba.com>
>>>> ---
>>>>    arch/riscv/kernel/Makefile     |  1 +
>>>>    arch/riscv/kernel/crash_core.c | 29 +++++++++++++++++++++++++++++
>>>>    2 files changed, 30 insertions(+)
>>>>    create mode 100644 arch/riscv/kernel/crash_core.c
>>>>
>>>> diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
>>>> index db6e4b1294ba..4cf303a779ab 100644
>>>> --- a/arch/riscv/kernel/Makefile
>>>> +++ b/arch/riscv/kernel/Makefile
>>>> @@ -81,6 +81,7 @@ obj-$(CONFIG_KGDB)		+= kgdb.o
>>>>    obj-$(CONFIG_KEXEC_CORE)	+= kexec_relocate.o crash_save_regs.o machine_kexec.o
>>>>    obj-$(CONFIG_KEXEC_FILE)	+= elf_kexec.o machine_kexec_file.o
>>>>    obj-$(CONFIG_CRASH_DUMP)	+= crash_dump.o
>>>> +obj-$(CONFIG_CRASH_CORE)	+= crash_core.o
>>>>    
>>>>    obj-$(CONFIG_JUMP_LABEL)	+= jump_label.o
>>>>    
>>>> diff --git a/arch/riscv/kernel/crash_core.c b/arch/riscv/kernel/crash_core.c
>>>> new file mode 100644
>>>> index 000000000000..8d7f5ff108da
>>>> --- /dev/null
>>>> +++ b/arch/riscv/kernel/crash_core.c
>>>> @@ -0,0 +1,29 @@
>>>> +// SPDX-License-Identifier: GPL-2.0-only
>>>> +
>>>> +#include <linux/crash_core.h>
>>>> +#include <linux/pagemap.h>
>>>> +
>>>> +void arch_crash_save_vmcoreinfo(void)
>>>> +{
>>>> +	VMCOREINFO_NUMBER(VA_BITS);
>>>> +	VMCOREINFO_NUMBER(phys_ram_base);
>>>> +
>>>> +	vmcoreinfo_append_str("NUMBER(PAGE_OFFSET)=0x%lx\n", PAGE_OFFSET);
>>>> +	vmcoreinfo_append_str("NUMBER(VMALLOC_START)=0x%lx\n", VMALLOC_START);
>>>> +	vmcoreinfo_append_str("NUMBER(VMALLOC_END)=0x%lx\n", VMALLOC_END);
>>>> +	vmcoreinfo_append_str("NUMBER(VMEMMAP_START)=0x%lx\n", VMEMMAP_START);
>>>> +	vmcoreinfo_append_str("NUMBER(VMEMMAP_END)=0x%lx\n", VMEMMAP_END);
>>>> +#ifdef CONFIG_64BIT
>>>> +	vmcoreinfo_append_str("NUMBER(MODULES_VADDR)=0x%lx\n", MODULES_VADDR);
>>>> +	vmcoreinfo_append_str("NUMBER(MODULES_END)=0x%lx\n", MODULES_END);
>>>> +#endif
>>>> +
>>>> +	if (IS_ENABLED(CONFIG_64BIT)) {
>>> You've already got a #ifdef CONFIG_64BIT above, is there a reason why
>>> you'd use the IS_ENABLED here rather than merge this with the above
>>> section? I'm a big fan of IS_ENABLED but I'm not sure what it adds here,
>>> maybe you can show me the light :)
>> The IS_ENABLED() check prevents the line from getting executed, but
>> unlike an #ifdef it relies on it to be parsable.
> Hey Xianting,
> Firstly, neither this nor the other version of this message made it to
> the mailing list - and since I usually use lei to get my mails that is
> a bit of a problem :(

Sorry, I don't know why,  I just reply via Thunderbird.

But git send-mail is right, I will send V3 soon.

>
> Yeah, I know that that is what IS_ENABLED() does, it's just in this
> situation it does not look very intentional & more like disjoint bits
> of copy-paste. It's fine though, leave it as it is.
OK, thanks
>
> Thanks,
> Conor.
>
>> I wrote this arch_crash_save_vmcoreinfo() func with reference to this: static void __init print_vm_layout(void) // arch/riscv/mm/init.c
>> {
>>           pr_notice("Virtual kernel memory layout:\n");
>>           print_ml("fixmap", (unsigned long)FIXADDR_START,
>>                   (unsigned long)FIXADDR_TOP);
>>           print_ml("pci io", (unsigned long)PCI_IO_START,
>>                   (unsigned long)PCI_IO_END);
>>           print_ml("vmemmap", (unsigned long)VMEMMAP_START,
>>                   (unsigned long)VMEMMAP_END);
>>           print_ml("vmalloc", (unsigned long)VMALLOC_START,
>>                   (unsigned long)VMALLOC_END);
>> #ifdef CONFIG_64BIT
>>           print_ml("modules", (unsigned long)MODULES_VADDR,
>>                   (unsigned long)MODULES_END);
>> #endif
>>           print_ml("lowmem", (unsigned long)PAGE_OFFSET,
>>                   (unsigned long)high_memory);
>>           if (IS_ENABLED(CONFIG_64BIT)) {
>> #ifdef CONFIG_KASAN
>>                   print_ml("kasan", KASAN_SHADOW_START, KASAN_SHADOW_END);
>> #endif
>>
>>                   print_ml("kernel", (unsigned long)KERNEL_LINK_ADDR,
>>                            (unsigned long)ADDRESS_SPACE_END);
>>           }
>> }
>>
>>> Thanks,
>>> Conor.
>>>
>>>
>>>> +#ifdef CONFIG_KASAN
>>>> +		vmcoreinfo_append_str("NUMBER(KASAN_SHADOW_START)=0x%lx\n", KASAN_SHADOW_START);
>>>> +		vmcoreinfo_append_str("NUMBER(KASAN_SHADOW_END)=0x%lx\n", KASAN_SHADOW_END);
>>>> +#endif
>>>> +		vmcoreinfo_append_str("NUMBER(KERNEL_LINK_ADDR)=0x%lx\n", KERNEL_LINK_ADDR);
>>>> +		vmcoreinfo_append_str("NUMBER(ADDRESS_SPACE_END)=0x%lx\n", ADDRESS_SPACE_END);
>>>> +	}
>>>> +}
>>>> -- 
>>>> 2.17.1
>>>>
>>>>
