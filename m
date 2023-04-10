Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 903F26DC7BF
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 16:16:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbjDJOQj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 10:16:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjDJOQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 10:16:38 -0400
Received: from mailbox.box.xen0n.name (mail.xen0n.name [115.28.160.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 883A8199E
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 07:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xen0n.name; s=mail;
        t=1681136192; bh=JFxIGato1Hvx8g9xV9cO3IPTvj8x3ok57KNjAO1cBMU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=flfjmvOgDlm6XfvrXM/Rc73uluo1Ja5YN2jPl5HPGCSA7LhEe832Hz/sa+6H0+dA/
         wy/FyYdvpMcMK9gct0oClYwhbqiX8HY7qFhXPtfjvRpoPkhhxZVZ7GItMX3k3/pBf6
         sXaI8KuNqyxRZpehkw9iGpsMjZp4V+uTgm6q6tNU=
Received: from [100.100.33.167] (unknown [220.248.53.61])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mailbox.box.xen0n.name (Postfix) with ESMTPSA id 0BD26600AE;
        Mon, 10 Apr 2023 22:16:32 +0800 (CST)
Message-ID: <01dcb3b6-efdb-af17-93a5-f6288b3f816d@xen0n.name>
Date:   Mon, 10 Apr 2023 22:16:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.1
Subject: Re: [RFC PATCH 2/3] LoongArch: Add larch_insn_gen_break() to generate
 break insn
Content-Language: en-US
To:     Tiezhu Yang <yangtiezhu@loongson.cn>,
        Youling Tang <tangyouling@loongson.cn>
Cc:     Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org, loongson-kernel@lists.loongnix.cn
References: <1680833701-1727-1-git-send-email-yangtiezhu@loongson.cn>
 <1680833701-1727-3-git-send-email-yangtiezhu@loongson.cn>
 <0d309725-3b91-6902-de67-08bda48ccf57@loongson.cn>
 <ab4f20ff-6aeb-f343-c4dc-24c46919176c@xen0n.name>
 <9433a12a-b24b-4438-fdc8-0213522c71ba@loongson.cn>
From:   WANG Xuerui <kernel@xen0n.name>
In-Reply-To: <9433a12a-b24b-4438-fdc8-0213522c71ba@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/4/7 20:02, Tiezhu Yang wrote:
> 
> 
> On 04/07/2023 05:51 PM, WANG Xuerui wrote:
>> On 2023/4/7 10:30, Youling Tang wrote:
>>> /* snip */
>>>
>>>> diff --git a/arch/loongarch/kernel/kprobes.c
>>>> b/arch/loongarch/kernel/kprobes.c
>>>> index 08c78d2..a5c3712 100644
>>>> --- a/arch/loongarch/kernel/kprobes.c
>>>> +++ b/arch/loongarch/kernel/kprobes.c
>>>> @@ -4,19 +4,8 @@
>>>>  #include <linux/preempt.h>
>>>>  #include <asm/break.h>
>>>>
>>>> -static const union loongarch_instruction breakpoint_insn = {
>>>> -    .reg0i15_format = {
>>>> -        .opcode = break_op,
>>>> -        .immediate = BRK_KPROBE_BP,
>>>> -    }
>>>> -};
>>>> -
>>>> -static const union loongarch_instruction singlestep_insn = {
>>>> -    .reg0i15_format = {
>>>> -        .opcode = break_op,
>>>> -        .immediate = BRK_KPROBE_SSTEPBP,
>>>> -    }
>>>> -};
>>>> +#define breakpoint_insn larch_insn_gen_break(BRK_KPROBE_BP)
>>>> +#define singlestep_insn larch_insn_gen_break(BRK_KPROBE_SSTEPBP)
>>>
>>> IMO, Defined as KPROBE_BP_INSN, KPROBE_SSTEPBP_INSN may be better.
>>
>> Are you suggesting to hardcode the instruction words for those two BREAK
>> flavors?
> 
> I think what Youling said is:
> 
> #define KPROBE_BP_INSN         larch_insn_gen_break(BRK_KPROBE_BP)
> #define KPROBE_SSTEPBP_INSN    larch_insn_gen_break(BRK_KPROBE_SSTEPBP)
> 
>> I don't think it's better because even more structured info is
>> lost, and the compiler would generate the same code (if not, it's the
>> compiler that's to be fixed).
>>
>> Actually, I don't know why this commit was necessary in the first place.
>> For the very least, it consisted of two logical changes (pass around
>> instruction words instead of unions; and change the BREAK insns to make
>> them words) that should get split;
> 
> Yes, thanks for your suggestion, I will split it into two patches
> in the next version.
> 
>> but again, the generated code should
>> be identical anyway, so it seems a lot of churn for no benefit and
>> reduced readability.
>>
> 
> Define and use larch_insn_gen_break() is to avoid hardcoding the
> uprobe break instruction in patch #3.
> 
> We do not like the following definitions:
> 
> #define UPROBE_SWBP_INSN    0x002a000c
> #define UPROBE_XOLBP_INSN    0x002a000d
> 
> Using larch_insn_gen_break() seems better:
> 
> #define UPROBE_SWBP_INSN    larch_insn_gen_break(BRK_UPROBE_BP)
> #define UPROBE_XOLBP_INSN    larch_insn_gen_break(BRK_UPROBE_XOLBP)

Sorry, I meant *not* ditching the union-typed parameters. IMO they 
should behave the same codegen-wise (i.e. unchanged performance), and 
have the benefit of being clearly typed unlike plain u32's.

-- 
WANG "xen0n" Xuerui

Linux/LoongArch mailing list: https://lore.kernel.org/loongarch/

