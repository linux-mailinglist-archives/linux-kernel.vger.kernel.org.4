Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A65E573BD56
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 19:05:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231267AbjFWRFc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 13:05:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbjFWRFa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 13:05:30 -0400
Received: from mailbox.box.xen0n.name (mail.xen0n.name [115.28.160.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9421526AF;
        Fri, 23 Jun 2023 10:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xen0n.name; s=mail;
        t=1687539924; bh=CwaupLNxCaQfdyqirb5X7+xJvkBuOUpQ0ThhbWfP/hk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ukUcNbU2eLFRCrRZNr7wSbGcmF3VKpW5hY2lA7txYZxFGvuN9BJe4lCuFDKFLtlUB
         vEIv7jrSQE2aARCFPjHXT4iuMkOJWOF3OUJLYuWKey33ub2gKTlbSNXS1Xwb9QMToc
         Ee0as+6Bm1F+uhQdtwslcWQsN7Dd5V5zbFK9I9hc=
Received: from [192.168.9.172] (unknown [101.88.25.181])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mailbox.box.xen0n.name (Postfix) with ESMTPSA id 74662600A9;
        Sat, 24 Jun 2023 01:05:24 +0800 (CST)
Message-ID: <267d223d-5215-f53d-ffb8-c74a209326e4@xen0n.name>
Date:   Sat, 24 Jun 2023 01:05:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 7/9] LoongArch: Tweak CFLAGS for Clang compatibility
Content-Language: en-US
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Huacai Chen <chenhuacai@kernel.org>,
        WANG Rui <wangrui@loongson.cn>, Xi Ruoyao <xry111@xry111.site>,
        loongarch@lists.linux.dev, linux-kbuild@vger.kernel.org,
        llvm@lists.linux.dev, linux-kernel@vger.kernel.org,
        WANG Xuerui <git@xen0n.name>
References: <20230623134351.1898379-1-kernel@xen0n.name>
 <20230623134351.1898379-8-kernel@xen0n.name>
 <CAKwvOdn5e+BzhGzDPnZYEjCuanABJmu5ZZo5x2uwHj4L44m5nA@mail.gmail.com>
From:   WANG Xuerui <kernel@xen0n.name>
In-Reply-To: <CAKwvOdn5e+BzhGzDPnZYEjCuanABJmu5ZZo5x2uwHj4L44m5nA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/24/23 00:39, Nick Desaulniers wrote:
> On Fri, Jun 23, 2023 at 6:44 AM WANG Xuerui <kernel@xen0n.name> wrote:
>> From: WANG Xuerui <git@xen0n.name>
>>
>> Now the arch code is mostly ready for LLVM/Clang consumption, it is time
>> to re-organize the CFLAGS a little to actually enable the LLVM build.
>>
>> A build with !RELOCATABLE && !MODULE is confirmed working within a QEMU
>> environment; support for the two features are currently blocked by
>> LLVM/Clang, and will come later.
>>
>> Signed-off-by: WANG Xuerui <git@xen0n.name>
>> ---
>>   arch/loongarch/Makefile      | 14 +++++++++++---
>>   arch/loongarch/vdso/Makefile |  6 +++++-
>>   2 files changed, 16 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/loongarch/Makefile b/arch/loongarch/Makefile
>> index a27e264bdaa5..efe9b50bd829 100644
>> --- a/arch/loongarch/Makefile
>> +++ b/arch/loongarch/Makefile
>> @@ -46,12 +46,18 @@ ld-emul                     = $(64bit-emul)
>>   cflags-y               += -mabi=lp64s
>>   endif
>>
>> -cflags-y                       += -G0 -pipe -msoft-float
> This seems to drop -msoft-float for GCC. Intentional?

Kind-of; according to the LoongArch Toolchain Conventions [1], 
-msoft-float basically selects the soft-float ABI, but *also prevents 
use of any FP instructions*. This is where things get hairy, because it 
means e.g. any translation unit can't manipulate the FP context at all 
without special-casing its CFLAGS to have the -msoft-float flag removed. 
I've tried and stopped when I noticed >3 files needed such treatment 
even in arch/loongarch/kernel alone; -mabi=lp64s is always present right 
now and that's enough.

[1]: 
https://loongson.github.io/LoongArch-Documentation/LoongArch-toolchain-conventions-EN.html#_compiler_options

>
>> -LDFLAGS_vmlinux                        += -G0 -static -n -nostdlib
>> +ifndef CONFIG_CC_IS_CLANG
>> +cflags-y                       += -G0
>> +LDFLAGS_vmlinux                        += -G0
> Thanks for the patch!
>
> I can understand not passing -G0 to clang if clang doesn't understand
> it, but should you be using CONFIG_LD_IS_LLD for LDFLAGS?
>
> What does -G0 do?
Just as Ruoyao explained earlier, it's the "small data threshold". It's 
not implemented on LoongArch yet, and we don't have ABI provisions for 
that either, so IMO it's even okay to just drop it unconditionally. (I 
haven't double-checked the GCC behavior though.)
>
> Is there a plan to support it in clang and lld?
>
> If so, please file a bug in LLVM's issue tracker
> https://github.com/llvm/llvm-project/issues
> then link to it in a comment in this Makefile above the relevant condition.
As explained above, proper support for "small data optimization" 
probably means some cooperation from ABI side (e.g. reserving a GP 
register for being able to reference +/-4KiB from it with a single 
insn), so I don't expect this to happen anytime soon.
>
>> +endif
>> +cflags-y                       += -pipe
>> +LDFLAGS_vmlinux                        += -static -n -nostdlib
>>
>>   # When the assembler supports explicit relocation hint, we must use it.
>>   # GCC may have -mexplicit-relocs off by default if it was built with an old
>> -# assembler, so we force it via an option.
>> +# assembler, so we force it via an option. For LLVM/Clang the desired behavior
>> +# is the default, and the flag is not supported, so don't pass it if Clang is
>> +# being used.
>>   #
>>   # When the assembler does not supports explicit relocation hint, we can't use
>>   # it.  Disable it if the compiler supports it.
>> @@ -61,8 +67,10 @@ LDFLAGS_vmlinux                      += -G0 -static -n -nostdlib
>>   # combination of a "new" assembler and "old" compiler is not supported.  Either
>>   # upgrade the compiler or downgrade the assembler.
>>   ifdef CONFIG_AS_HAS_EXPLICIT_RELOCS
>> +ifndef CONFIG_CC_IS_CLANG
>>   cflags-y                       += -mexplicit-relocs
>>   KBUILD_CFLAGS_KERNEL           += -mdirect-extern-access
>> +endif
> Why would AS_HAS_EXPLICIT_RELOCS be set if -mexplicit-relocs isn't
> supported? Is the kconfig for that broken?
>
> Does AS_HAS_EXPLICIT_RELOCS also need to test for the support for
> -mdirect-extern-access or should there be a new config for that?
> CC_SUPPORTS_DIRECT_EXTERN_ACCESS
>
>>   else
>>   cflags-y                       += $(call cc-option,-mno-explicit-relocs)
>>   KBUILD_AFLAGS_KERNEL           += -Wa,-mla-global-with-pcrel
>> diff --git a/arch/loongarch/vdso/Makefile b/arch/loongarch/vdso/Makefile
>> index 4c859a0e4754..19f6c75a1106 100644
>> --- a/arch/loongarch/vdso/Makefile
>> +++ b/arch/loongarch/vdso/Makefile
>> @@ -25,13 +25,17 @@ endif
>>   cflags-vdso := $(ccflags-vdso) \
>>          -isystem $(shell $(CC) -print-file-name=include) \
>>          $(filter -W%,$(filter-out -Wa$(comma)%,$(KBUILD_CFLAGS))) \
>> -       -O2 -g -fno-strict-aliasing -fno-common -fno-builtin -G0 \
>> +       -O2 -g -fno-strict-aliasing -fno-common -fno-builtin \
>>          -fno-stack-protector -fno-jump-tables -DDISABLE_BRANCH_PROFILING \
>>          $(call cc-option, -fno-asynchronous-unwind-tables) \
>>          $(call cc-option, -fno-stack-protector)
>>   aflags-vdso := $(ccflags-vdso) \
>>          -D__ASSEMBLY__ -Wa,-gdwarf-2
>>
>> +ifndef CONFIG_CC_IS_CLANG
>> +cflags-vdso += -G0
>> +endif
>> +
>>   ifneq ($(c-gettimeofday-y),)
>>     CFLAGS_vgettimeofday.o += -include $(c-gettimeofday-y)
>>   endif
>> --
>> 2.40.0
>>
>>
>
-- 
WANG "xen0n" Xuerui

Linux/LoongArch mailing list: https://lore.kernel.org/loongarch/

