Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09F5173CF09
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 09:48:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231429AbjFYHsd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 03:48:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230154AbjFYHsb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 03:48:31 -0400
Received: from mailbox.box.xen0n.name (mail.xen0n.name [115.28.160.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DAADE45;
        Sun, 25 Jun 2023 00:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xen0n.name; s=mail;
        t=1687679307; bh=/68NbnTcIZWpyWND2Cdx843Vk2DveQW8gFt7NZyrO34=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=o0KxdgRNG0cej/WO7lsfELLSK3Rxc26j7w6nHBLcQjPBdhpywqTs7/Wn1s9aYr5F+
         0vw5WFpS+6OEf+EHIEWkl2ua+9GixRn2OckwNfI/vuZDosScaLVRsVUvbeI7n5OjB2
         TKTOXhO7QEko1W3vN+CPXm1fG+4dR0ZTv3IYAvSw=
Received: from [100.100.34.13] (unknown [220.248.53.61])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by mailbox.box.xen0n.name (Postfix) with ESMTPSA id 2436B600B5;
        Sun, 25 Jun 2023 15:48:27 +0800 (CST)
Message-ID: <12e9a417-e655-b85b-1213-231fd68b0977@xen0n.name>
Date:   Sun, 25 Jun 2023 15:48:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v2 7/9] LoongArch: Tweak CFLAGS for Clang compatibility
Content-Language: en-US
To:     Xi Ruoyao <xry111@xry111.site>, Huacai Chen <chenhuacai@kernel.org>
Cc:     WANG Rui <wangrui@loongson.cn>, loongarch@lists.linux.dev,
        linux-kbuild@vger.kernel.org, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org, WANG Xuerui <git@xen0n.name>
References: <20230624184055.3000636-1-kernel@xen0n.name>
 <20230624184055.3000636-8-kernel@xen0n.name>
 <CAAhV-H54bZ5_OSXtcq3B3d4bZj4GBTOf7Z8aA6Jm7uGdKTj_ug@mail.gmail.com>
 <cc8c2f2d-b242-7488-3b5a-33828ee38b36@xen0n.name>
 <5154e8141e2b022b477f2d2658279e94f6b02149.camel@xry111.site>
From:   WANG Xuerui <kernel@xen0n.name>
In-Reply-To: <5154e8141e2b022b477f2d2658279e94f6b02149.camel@xry111.site>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/6/25 15:36, Xi Ruoyao wrote:
> On Sun, 2023-06-25 at 15:16 +0800, WANG Xuerui wrote:
>> On 2023/6/25 10:13, Huacai Chen wrote:
>>> Hi, Ruoyao,
>>>
>>> On Sun, Jun 25, 2023 at 2:42 AM WANG Xuerui <kernel@xen0n.name> wrote:
>>>>
>>>> From: WANG Xuerui <git@xen0n.name>
>>>>
>>>> Now the arch code is mostly ready for LLVM/Clang consumption, it is time
>>>> to re-organize the CFLAGS a little to actually enable the LLVM build.
>>>>
>>>> In particular, -mexplicit-relocs and -mdirect-extern-access are not
>>>> necessary nor supported on Clang; feature detection via cc-option would
>>>> not work, because that way the broken combo of "new GNU as + old GCC"
>>>> would seem to get "fixed", but actually produce broken kernels.
>>>> Explicitly depending on CONFIG_CC_IS_CLANG is thus necessary to not
>>>> regress UX for those building their own kernels.
>>>>
>>>> A build with !RELOCATABLE && !MODULE is confirmed working within a QEMU
>>>> environment; support for the two features are currently blocked on
>>>> LLVM/Clang, and will come later.
>>>>
>>>> Signed-off-by: WANG Xuerui <git@xen0n.name>
>>>> ---
>>>>    arch/loongarch/Makefile | 6 +++++-
>>>>    1 file changed, 5 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/arch/loongarch/Makefile b/arch/loongarch/Makefile
>>>> index 366771016b99..82c619791a63 100644
>>>> --- a/arch/loongarch/Makefile
>>>> +++ b/arch/loongarch/Makefile
>>>> @@ -51,7 +51,9 @@ LDFLAGS_vmlinux                       += -static -n -nostdlib
>>>>
>>>>    # When the assembler supports explicit relocation hint, we must use it.
>>>>    # GCC may have -mexplicit-relocs off by default if it was built with an old
>>>> -# assembler, so we force it via an option.
>>>> +# assembler, so we force it via an option. For LLVM/Clang the desired behavior
>>>> +# is the default, and the flag is not supported, so don't pass it if Clang is
>>>> +# being used.
>>>>    #
>>>>    # When the assembler does not supports explicit relocation hint, we can't use
>>>>    # it.  Disable it if the compiler supports it.
>>>> @@ -61,8 +63,10 @@ LDFLAGS_vmlinux                      += -static -n -nostdlib
>>>>    # combination of a "new" assembler and "old" compiler is not supported.  Either
>>>>    # upgrade the compiler or downgrade the assembler.
>>>>    ifdef CONFIG_AS_HAS_EXPLICIT_RELOCS
>>>> +ifndef CONFIG_CC_IS_CLANG
>>>>    cflags-y                       += -mexplicit-relocs
>>>>    KBUILD_CFLAGS_KERNEL           += -mdirect-extern-access
>>>> +endif
>>> I prefer to drop CONFIG_CC_IS_CLANG and use
>>> cflags-y                       += $(call cc-option,-mexplicit-relocs)
>>> KBUILD_CFLAGS_KERNEL           += $(call cc-option,-mdirect-extern-access)
>>>
>>> Then Patch-6 can be merged in this.
>>>
>>> What's your opinion?
>>
>> FYI: with this approach the build no longer instantly dies with binutils
>> 2.40 + gcc 12.3, but there are also tons of warnings that say the model
>> attribute is being ignored. I checked earlier discussions and this means
>> modules are silently broken at runtime, which is not particularly good UX.
> 
> We can add
> 
> #if defined(MODULE) && !__has_attribute(model)
> #  error some fancy error message
> #endif
> 
> into percpu.h to error out in this case.  It had been in my earlier
> drafts of explicit relocs patches, but we dropped it because there was
> no such configuration (unless a snapshot of development GCC is used, and
> using such a snapshot is never supported IIUC).

Ah I've seen that. So in this case we simply wrap -mexplicit-relocs with 
cc-option and error out in case of CONFIG_MODULE but no model attribute, 
which nicely prevents broken configurations (MODULE && ((old_gcc && 
new_binutils) || clang)) with feature detection alone.

This seems elegant and better to me; Huacai, WDYT?

-- 
WANG "xen0n" Xuerui

Linux/LoongArch mailing list: https://lore.kernel.org/loongarch/

