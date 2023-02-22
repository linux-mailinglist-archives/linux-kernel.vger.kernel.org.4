Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B173769F28C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 11:12:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231497AbjBVKMb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 05:12:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230480AbjBVKM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 05:12:29 -0500
Received: from mailbox.box.xen0n.name (mail.xen0n.name [115.28.160.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2C3733471
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 02:12:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xen0n.name; s=mail;
        t=1677060744; bh=gl77/uhMzHl5LvD1iZLRjwPZnpIAtfB1KdFD5EeZD+o=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=R8q6PWnHYZANesuZGjB66GOFwf22Eu0TR+AKKAhQRykItUX7s3HqnOyjGx28Kkl78
         mzoutsRPlyM+DgHSKJIdVfzTVaWuKpyUY8W+FbsA6mQllFAC8rgtEKqooI5P1ujqUl
         68nPJt8bgKe7RhUl27CDRZoiqJSGvn21tUvyFvuc=
Received: from [100.100.57.122] (unknown [58.34.185.106])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mailbox.box.xen0n.name (Postfix) with ESMTPSA id 01E53600DA;
        Wed, 22 Feb 2023 18:12:23 +0800 (CST)
Message-ID: <aa7032be-be91-4377-a09a-1bb3f382cab2@xen0n.name>
Date:   Wed, 22 Feb 2023 18:12:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [PATCH 1/2] LoongArch: kdump: Add the same binary implementation
Content-Language: en-US
To:     Youling Tang <tangyouling@loongson.cn>
Cc:     Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <1677048791-26951-1-git-send-email-tangyouling@loongson.cn>
 <1677048791-26951-2-git-send-email-tangyouling@loongson.cn>
 <6d71e063-8e18-dd08-ac40-36b41ccfcfdb@xen0n.name>
 <3ec77f64-55b2-5549-52f8-b875392d992e@loongson.cn>
From:   WANG Xuerui <kernel@xen0n.name>
In-Reply-To: <3ec77f64-55b2-5549-52f8-b875392d992e@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/2/22 17:54, Youling Tang wrote:
> Hi, Xuerui
> 
> On 02/22/2023 05:05 PM, WANG Xuerui wrote:
>> On 2023/2/22 14:53, Youling Tang wrote:
>>> This feature depends on the relocation function, so the relocation
>>> configuration
>>> CONFIG_RELOCATABLE will be enabled.
>>
>> In general try to describe things briefly: "This depends on the kernel
>> being relocatable" would be enough in this case.
> OK.
> 
>>
>>>
>>> Add the same set of binary implementations for kdump, and then no
>>> longer need to
>>> compile two kernels (the production kernel and the capture kernel
>>> share the same
>>> binary).
>>
>> Sorry but what do you mean by "same set of binary implementation",
>> where's the "first set of binary implementation"?
> 
> kdump requires two kernels, the production kernel and the capture
> kernel, which made the final link address different through different
> configuration options in the previous implementation. Now it is
> possible to share a kernel, and after entering the capture kernel, it
> can be corrected by relocation.
> 
>>
>> Judging from the patch content, I guess it's kinda wrong translation,
>> and what you actually mean is something like "enable using the same
>> image for crashkernel"?
> 
> Or "LoongArch: kdump: Add support for using a single image" ?
> 

Whatever you prefer, literally anything else would be better than the 
original. I don't have strong opinion over this.

>>
>>>
>>> CONFIG_CRASH_DUMP is enabled by default (CONFIG_RELOCATABLE is also
>>> enabled).
>>
>> No it's not: you didn't add "default y" anywhere. What you actually did
>> is to enable it *in the defconfig*. And the latter part about
>> CONFIG_RELOCATABLE shouldn't be necessary, it's implementation detail
>> after all, and the users likely don't have to be aware of it.
>>
>> Better reword a little bit, like "Also enable CONFIG_CRASH_DUMP in
>> loongson3_defconfig".
> 
> Thanks, I'll rewrite the commit message.
> 
>>
>>>
>>> Signed-off-by: Youling Tang <tangyouling@loongson.cn>
>>> ---
>>>   arch/loongarch/Kconfig                     | 12 +-----------
>>>   arch/loongarch/Makefile                    |  4 ----
>>>   arch/loongarch/configs/loongson3_defconfig |  1 +
>>>   arch/loongarch/include/asm/addrspace.h     |  2 ++
>>>   arch/loongarch/kernel/head.S               |  2 +-
>>>   5 files changed, 5 insertions(+), 16 deletions(-)
>>>
>>> diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
>>> index ab4c2ab146ab..84f220273296 100644
>>> --- a/arch/loongarch/Kconfig
>>> +++ b/arch/loongarch/Kconfig
>>> @@ -502,6 +502,7 @@ config KEXEC
>>>     config CRASH_DUMP
>>>       bool "Build kdump crash kernel"
>>> +    select RELOCATABLE
>>>       help
>>>         Generate crash dump after being started by kexec. This should
>>>         be normally only set in special crash dump kernels which are
>>> @@ -511,17 +512,6 @@ config CRASH_DUMP
>>>           For more details see Documentation/admin-guide/kdump/kdump.rst
>>>   -config PHYSICAL_START
>>> -    hex "Physical address where the kernel is loaded"
>>> -    default "0x90000000a0000000"
>>> -    depends on CRASH_DUMP
>>> -    help
>>> -      This gives the XKPRANGE address where the kernel is loaded.
>>> -      If you plan to use kernel for capturing the crash dump change
>>> -      this value to start of the reserved region (the "X" value as
>>> -      specified in the "crashkernel=YM@XM" command line boot parameter
>>> -      passed to the panic-ed kernel).
>>> -
>>>   config RELOCATABLE
>>>       bool "Relocatable kernel"
>>>       help
>>> diff --git a/arch/loongarch/Makefile b/arch/loongarch/Makefile
>>> index 2aba6ff30436..8304fed7aa42 100644
>>> --- a/arch/loongarch/Makefile
>>> +++ b/arch/loongarch/Makefile
>>> @@ -79,11 +79,7 @@ endif
>>>   cflags-y += -ffreestanding
>>>   cflags-y += $(call cc-option, -mno-check-zero-division)
>>>   -ifndef CONFIG_PHYSICAL_START
>>>   load-y        = 0x9000000000200000
>>> -else
>>> -load-y        = $(CONFIG_PHYSICAL_START)
>>> -endif
>>>   bootvars-y    = VMLINUX_LOAD_ADDRESS=$(load-y)
>>
>> Both load-y and VMLINUX_LOAD_ADDRESS are kinda LoongArch-ism (stemming
>> from similar usage in arch/mips apparently), so why not just drop load-y
>> and fold the constant into the bootvars-y definition? So we have one
>> piece of "special" definition instead of two.
> 
> This series of patches will not modify it, perhaps it can be submitted
> and discussed separately later.

I mean since you're already touching this part, you might be better off 
just simplify along the way because it's used by nowhere else. But 
splitting commits would be indeed cleaner and of course you can add such 
a followup commit in the next revision.

-- 
WANG "xen0n" Xuerui

Linux/LoongArch mailing list: https://lore.kernel.org/loongarch/

