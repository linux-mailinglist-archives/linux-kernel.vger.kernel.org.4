Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66A446FE97C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 03:32:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236284AbjEKBcq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 21:32:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjEKBcp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 21:32:45 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B4BCD3A96;
        Wed, 10 May 2023 18:32:42 -0700 (PDT)
Received: from loongson.cn (unknown [192.168.100.1])
        by gateway (Coremail) with SMTP id _____8BxZ+m5RVxkK5gHAA--.12680S3;
        Thu, 11 May 2023 09:32:41 +0800 (CST)
Received: from [0.0.0.0] (unknown [192.168.100.1])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8DxD7+2RVxkuQxVAA--.20458S3;
        Thu, 11 May 2023 09:32:38 +0800 (CST)
Subject: Re: [PATCH v2] LoongArch: Add jump-label implementation
To:     Peter Zijlstra <peterz@infradead.org>
References: <1683710206-23905-1-git-send-email-tangyouling@loongson.cn>
 <20230510092723.GK4253@hirez.programming.kicks-ass.net>
Cc:     Huacai Chen <chenhuacai@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Jason Baron <jbaron@akamai.com>,
        WANG Xuerui <kernel@xen0n.name>,
        Zhangjin Wu <falcon@tinylab.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, loongarch@lists.linux.dev
From:   Youling Tang <tangyouling@loongson.cn>
Message-ID: <de498202-846d-2997-6226-94d302d846b2@loongson.cn>
Date:   Thu, 11 May 2023 09:32:38 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <20230510092723.GK4253@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8DxD7+2RVxkuQxVAA--.20458S3
X-CM-SenderInfo: 5wdqw5prxox03j6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBjvJXoWxCw4DtF4UJF1ruF43ur1xXwb_yoW5KF1xpF
        yUCa9YkF4kt3WfJr98XrnxZF1Yvws5KF9FqFZ0g34xAFnFv340kF1IkrZ09as2yaykGr42
        v3WYvFZIv3W5taDanT9S1TB71UUUUjDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bDAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
        x0Y4vEx4A2jsIE14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UM2kK
        e7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI
        0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUtVWrXwAv7VC2z280
        aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2
        xFo4CEbIxvr21lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC
        6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s
        026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF
        0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0x
        vE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv
        6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07jz5lbUUUUU=
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Peter

On 05/10/2023 05:27 PM, Peter Zijlstra wrote:
> On Wed, May 10, 2023 at 05:16:46PM +0800, Youling Tang wrote:
>> Add jump-label implementation based on the ARM64 version.
>>
>> Signed-off-by: Youling Tang <tangyouling@loongson.cn>
>
>> diff --git a/arch/loongarch/include/asm/jump_label.h b/arch/loongarch/include/asm/jump_label.h
>> new file mode 100644
>> index 000000000000..2f9fdec256c5
>> --- /dev/null
>> +++ b/arch/loongarch/include/asm/jump_label.h
>> @@ -0,0 +1,51 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> +/*
>> + * Copyright (C) 2023 Loongson Technology Corporation Limited
>> + *
>> + * Based on arch/arm64/include/asm/jump_label.h
>> + */
>> +#ifndef __ASM_JUMP_LABEL_H
>> +#define __ASM_JUMP_LABEL_H
>> +
>> +#ifndef __ASSEMBLY__
>> +
>> +#include <linux/types.h>
>> +
>> +#define JUMP_LABEL_NOP_SIZE	4
>> +
>> +static __always_inline bool arch_static_branch(struct static_key * const key,
>> +					       const bool branch)
>> +{
>> +	asm_volatile_goto(
>> +		"1:	nop					\n\t"
>> +		 "	.pushsection	__jump_table, \"aw\"	\n\t"
>> +		 "	.align		3			\n\t"
>> +		 "	.long		1b - ., %l[l_yes] - .	\n\t"
>> +		 "	.quad		%0 - .			\n\t"
>> +		 "	.popsection				\n\t"
>> +		 :  :  "i"(&((char *)key)[branch]) :  : l_yes);
>> +
>> +	return false;
>> +l_yes:
>> +	return true;
>> +}
>> +
>> +static __always_inline bool arch_static_branch_jump(struct static_key * const key,
>> +						    const bool branch)
>> +{
>> +	asm_volatile_goto(
>> +		"1:	b		%l[l_yes]		\n\t"
>> +		 "	.pushsection	__jump_table, \"aw\"	\n\t"
>> +		 "	.align		3			\n\t"
>> +		 "	.long		1b - ., %l[l_yes] - .	\n\t"
>> +		 "	.quad		%0 - .			\n\t"
>> +		 "	.popsection				\n\t"
>> +		 :  :  "i"(&((char *)key)[branch]) :  : l_yes);
>> +
>> +	return false;
>> +l_yes:
>> +	return true;
>> +}
>
> Seems simple enough; one change I did a while ago for the x86 version is
> to put the __jump_table entry generation in a macro so it could be
> shared between the (3 for x86) variants.

Looks better, I will define JUMP_TABLE_ENTRY macro so that
arch_static_branch and arch_static_branch_jump can share.

Thanks,
Youling.

>
> Not saying you have to do that, just saying it's an option.
>
>> +#endif  /* __ASSEMBLY__ */
>> +#endif	/* __ASM_JUMP_LABEL_H */
>
>> diff --git a/arch/loongarch/kernel/jump_label.c b/arch/loongarch/kernel/jump_label.c
>> new file mode 100644
>> index 000000000000..b06245955f7a
>> --- /dev/null
>> +++ b/arch/loongarch/kernel/jump_label.c
>> @@ -0,0 +1,23 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Copyright (C) 2023 Loongson Technology Corporation Limited
>> + *
>> + * Based on arch/arm64/kernel/jump_label.c
>> + */
>> +#include <linux/jump_label.h>
>> +#include <linux/kernel.h>
>> +#include <asm/inst.h>
>> +
>> +void arch_jump_label_transform(struct jump_entry *entry,
>> +			       enum jump_label_type type)
>> +{
>> +	void *addr = (void *)jump_entry_code(entry);
>> +	u32 insn;
>> +
>> +	if (type == JUMP_LABEL_JMP)
>> +		insn = larch_insn_gen_b(jump_entry_code(entry), jump_entry_target(entry));
>> +	else
>> +		insn = larch_insn_gen_nop();
>> +
>> +	larch_insn_patch_text(addr, insn);
>> +}
>
> This all implies Loongarch is fine with the nop<->b transition (much
> like arm64 is), but I found no actual mention of what transitions are
> valid for the architecture in your inst.c file -- perhaps you could put
> a small comment there to elucidate the occasional reader that doesn't
> have your arch manual memorized?
>
>
> Anyway, as with most RISC implementations it's short and sweet.
>
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>

