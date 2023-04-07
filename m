Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 870DA6DAC78
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 14:02:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240535AbjDGMCh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 08:02:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbjDGMCf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 08:02:35 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BC0C283F0
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 05:02:32 -0700 (PDT)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8BxMMxXBjBk894XAA--.37073S3;
        Fri, 07 Apr 2023 20:02:31 +0800 (CST)
Received: from [10.130.0.149] (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8DxC75WBjBk_18YAA--.24086S3;
        Fri, 07 Apr 2023 20:02:31 +0800 (CST)
Subject: Re: [RFC PATCH 2/3] LoongArch: Add larch_insn_gen_break() to generate
 break insn
To:     WANG Xuerui <kernel@xen0n.name>,
        Youling Tang <tangyouling@loongson.cn>
References: <1680833701-1727-1-git-send-email-yangtiezhu@loongson.cn>
 <1680833701-1727-3-git-send-email-yangtiezhu@loongson.cn>
 <0d309725-3b91-6902-de67-08bda48ccf57@loongson.cn>
 <ab4f20ff-6aeb-f343-c4dc-24c46919176c@xen0n.name>
Cc:     Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org, loongson-kernel@lists.loongnix.cn
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <9433a12a-b24b-4438-fdc8-0213522c71ba@loongson.cn>
Date:   Fri, 7 Apr 2023 20:02:30 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <ab4f20ff-6aeb-f343-c4dc-24c46919176c@xen0n.name>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8DxC75WBjBk_18YAA--.24086S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvJXoW7KF4kWF47WryruFWkuFyUZFb_yoW8Kryfpr
        1DAF15Zrs8W3yrG34vqw15ZF4Sqw4kWr4qqF4DJ3y3GrW7Xrn8tFn2gryakFyYvw4jgay0
        q3ZFgFWIva4jyaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bI8YFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_JrI_Jryl8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwA2z4
        x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr1j6rxdM2AI
        xVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I8CrVACY4xI64
        kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWxJVW8Jr1l
        Ox8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42
        xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWU
        GwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI4
        8JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4U
        MIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I
        8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUFwZ2UUUUU
X-Spam-Status: No, score=-2.0 required=5.0 tests=NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/07/2023 05:51 PM, WANG Xuerui wrote:
> On 2023/4/7 10:30, Youling Tang wrote:
>> /* snip */
>>
>>> diff --git a/arch/loongarch/kernel/kprobes.c
>>> b/arch/loongarch/kernel/kprobes.c
>>> index 08c78d2..a5c3712 100644
>>> --- a/arch/loongarch/kernel/kprobes.c
>>> +++ b/arch/loongarch/kernel/kprobes.c
>>> @@ -4,19 +4,8 @@
>>>  #include <linux/preempt.h>
>>>  #include <asm/break.h>
>>>
>>> -static const union loongarch_instruction breakpoint_insn = {
>>> -    .reg0i15_format = {
>>> -        .opcode = break_op,
>>> -        .immediate = BRK_KPROBE_BP,
>>> -    }
>>> -};
>>> -
>>> -static const union loongarch_instruction singlestep_insn = {
>>> -    .reg0i15_format = {
>>> -        .opcode = break_op,
>>> -        .immediate = BRK_KPROBE_SSTEPBP,
>>> -    }
>>> -};
>>> +#define breakpoint_insn larch_insn_gen_break(BRK_KPROBE_BP)
>>> +#define singlestep_insn larch_insn_gen_break(BRK_KPROBE_SSTEPBP)
>>
>> IMO, Defined as KPROBE_BP_INSN, KPROBE_SSTEPBP_INSN may be better.
>
> Are you suggesting to hardcode the instruction words for those two BREAK
> flavors?

I think what Youling said is:

#define KPROBE_BP_INSN         larch_insn_gen_break(BRK_KPROBE_BP)
#define KPROBE_SSTEPBP_INSN    larch_insn_gen_break(BRK_KPROBE_SSTEPBP)

> I don't think it's better because even more structured info is
> lost, and the compiler would generate the same code (if not, it's the
> compiler that's to be fixed).
>
> Actually, I don't know why this commit was necessary in the first place.
> For the very least, it consisted of two logical changes (pass around
> instruction words instead of unions; and change the BREAK insns to make
> them words) that should get split;

Yes, thanks for your suggestion, I will split it into two patches
in the next version.

> but again, the generated code should
> be identical anyway, so it seems a lot of churn for no benefit and
> reduced readability.
>

Define and use larch_insn_gen_break() is to avoid hardcoding the
uprobe break instruction in patch #3.

We do not like the following definitions:

#define UPROBE_SWBP_INSN	0x002a000c
#define UPROBE_XOLBP_INSN	0x002a000d

Using larch_insn_gen_break() seems better:

#define UPROBE_SWBP_INSN	larch_insn_gen_break(BRK_UPROBE_BP)
#define UPROBE_XOLBP_INSN	larch_insn_gen_break(BRK_UPROBE_XOLBP)

Thanks,
Tiezhu

