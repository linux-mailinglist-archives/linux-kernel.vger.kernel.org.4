Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1004073CC81
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 21:03:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231651AbjFXTDs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jun 2023 15:03:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbjFXTDq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jun 2023 15:03:46 -0400
Received: from mailbox.box.xen0n.name (mail.xen0n.name [115.28.160.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 089EB170B;
        Sat, 24 Jun 2023 12:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xen0n.name; s=mail;
        t=1687633423; bh=BoL00BrSJXKAeyJySKFaqRI5u0YaOvBodIbSgtkFE7g=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=EbUwmrV2b51MN4jn+TSgyS0u3hAMaNdDkttJa0AQHw4owhlHXWGRniXKmj+TffMG1
         l06W3sWY5gjPo9HpalvJhOqXpPGJ+iG25KpU5bciCN9ElqGKRT3vwBbRVxc5a36H3D
         AgpqYwPmBEIOiJf5cwKNGWJHaaCzUG16BrxzpCs4=
Received: from [192.168.9.172] (unknown [101.88.25.181])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mailbox.box.xen0n.name (Postfix) with ESMTPSA id 6C584600B5;
        Sun, 25 Jun 2023 03:03:43 +0800 (CST)
Message-ID: <c71f13ed-8e07-632b-55a6-d686e0d0f977@xen0n.name>
Date:   Sun, 25 Jun 2023 03:03:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 5/9] LoongArch: Simplify the invtlb wrappers
Content-Language: en-US
To:     Xi Ruoyao <xry111@xry111.site>, Huacai Chen <chenhuacai@kernel.org>
Cc:     WANG Rui <wangrui@loongson.cn>, loongarch@lists.linux.dev,
        linux-kbuild@vger.kernel.org, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org, WANG Xuerui <git@xen0n.name>
References: <20230624184055.3000636-1-kernel@xen0n.name>
 <20230624184055.3000636-6-kernel@xen0n.name>
 <bb4c5746bba9c96f083cbff0ced4185f88bef33a.camel@xry111.site>
From:   WANG Xuerui <kernel@xen0n.name>
In-Reply-To: <bb4c5746bba9c96f083cbff0ced4185f88bef33a.camel@xry111.site>
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

Good evening! (I really have to get some sleep real soon.)

On 6/25/23 02:55, Xi Ruoyao wrote:
> On Sun, 2023-06-25 at 02:40 +0800, WANG Xuerui wrote:
>> From: WANG Xuerui <git@xen0n.name>
>>
>> The invtlb instruction has been supported by upstream LoongArch
>> toolchains from day one, so ditch the raw opcode trickery and just use
>> plain inline asm for it.
>>
>> While at it, also make the invtlb asm statements barriers, for proper
>> modeling of the side effects.
>>
>> The signature of the other more specific invtlb wrappers contain unused
>> arguments right now, but these are not removed right away in order for
>> the patch to be focused. In the meantime, assertions are added to ensure
>> no accidental misuse happens before the refactor. (The more specific
>> wrappers cannot re-use the generic invtlb wrapper, because the ISA
>> manual says $zero shall be used in case a particular op does not take
>> the respective argument: re-using the generic wrapper would mean losing
>> control over the register usage.)
>>
>> Signed-off-by: WANG Xuerui <git@xen0n.name>
>> ---
>>   arch/loongarch/include/asm/tlb.h | 39 ++++++++++++++++----------------
>>   1 file changed, 19 insertions(+), 20 deletions(-)
>>
>> diff --git a/arch/loongarch/include/asm/tlb.h b/arch/loongarch/include/asm/tlb.h
>> index 0dc9ee2b05d2..15750900540c 100644
>> --- a/arch/loongarch/include/asm/tlb.h
>> +++ b/arch/loongarch/include/asm/tlb.h
>> @@ -88,52 +88,51 @@ enum invtlb_ops {
>>          INVTLB_GID_ADDR = 0x16,
>>   };
>>   
>> -/*
>> - * invtlb op info addr
>> - * (0x1 << 26) | (0x24 << 20) | (0x13 << 15) |
>> - * (addr << 10) | (info << 5) | op
>> - */
>>   static inline void invtlb(u32 op, u32 info, u64 addr)
> Oh, technically these wrappers should be __always_inline, not only
> inline because they don't work at all if not inlined.  Should we change
> them to __always_inline in this patch by the way?
Makes sense... let me send a quick v3 tomorrow (and maybe after Huacai 
has taken a look).
>
>>   {
>> +       BUILD_BUG_ON(!__builtin_constant_p(op));
> Hmm, I guess it's redundant.  If op is not a compile-time constant, it
> won't satisfy the "i" constraint then the compiler will complain anyway.
You're right (in v1 this wasn't done, yet it compiled just fine with GCC 
and Clang). I'll remove the op assertions in v3. Thanks for the reviews.
>
>>          __asm__ __volatile__(
>> -               "parse_r addr,%0\n\t"
>> -               "parse_r info,%1\n\t"
>> -               ".word ((0x6498000) | (addr << 10) | (info << 5) | %2)\n\t"
>> -               :
>> -               : "r"(addr), "r"(info), "i"(op)
>> +               "invtlb %0, %1, %2\n\t"
>>                  :
>> +               : "i"(op), "r"(info), "r"(addr)
>> +               : "memory"
>>                  );
>>   }
> Likewise for other wrappers.
>
> /* snip */
>
-- 
WANG "xen0n" Xuerui

Linux/LoongArch mailing list: https://lore.kernel.org/loongarch/

