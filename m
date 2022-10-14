Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E4175FE6E0
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 04:18:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbiJNCSu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 22:18:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbiJNCSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 22:18:47 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 85131E8C44
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 19:18:45 -0700 (PDT)
Received: from [10.130.0.135] (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Cxqmr+xkhjKcgtAA--.28612S3;
        Fri, 14 Oct 2022 10:18:39 +0800 (CST)
Subject: Re: [PATCH] LoongArch: BPF: Avoid declare variables in switch-case
To:     Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>
References: <20221013154000.3462836-1-chenhuacai@loongson.cn>
 <8a8fa581-94a9-649d-8c01-f1afd4bc9514@xen0n.name>
 <CAAhV-H5U1c_wfWLuxMaHD6c9-k+g-iSqgtcJVwceoL13J7hEiA@mail.gmail.com>
Cc:     Huacai Chen <chenhuacai@loongson.cn>, loongarch@lists.linux.dev,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Guo Ren <guoren@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-kernel@vger.kernel.org
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <ae6260e5-0eb6-a615-7032-6481cd186f3f@loongson.cn>
Date:   Fri, 14 Oct 2022 10:18:38 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <CAAhV-H5U1c_wfWLuxMaHD6c9-k+g-iSqgtcJVwceoL13J7hEiA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8Cxqmr+xkhjKcgtAA--.28612S3
X-Coremail-Antispam: 1UD129KBjvJXoW7uw1UAry3Xw15WF1fuw18Grg_yoW8tr43pF
        95Wan8Ka1DJ3yY9FyqqrWkXa48tw4kJrn8KF1FqrZ2kFsF9r1fGr48KF4FkFZxGrn8ur4I
        va1qvayxuw15CrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvG14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxV
        WxJr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2Wl
        Yx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbV
        WUJVW8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7I2V7IY0VAS07Al
        zVAYIcxG8wCY02Avz4vE14v_Gr1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr
        0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY
        17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcV
        C0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY
        6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa
        73UjIFyTuYvjfU5CztUUUUU
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/14/2022 09:13 AM, Huacai Chen wrote:
> Hi, Xuerui,
>
> On Fri, Oct 14, 2022 at 12:43 AM WANG Xuerui <kernel@xen0n.name> wrote:
>>
>> On 10/13/22 23:40, Huacai Chen wrote:
>>> Not all compilers support declare variables in switch-case, so move
>>> declarations to the beginning of a function. Otherwise we may get such
>>> build errors:

...

>>>
>>>   static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool extra_pass)
>>>   {
>>> -     const bool is32 = BPF_CLASS(insn->code) == BPF_ALU ||
>>> -                       BPF_CLASS(insn->code) == BPF_JMP32;
>>> +     u8 t0 = -1;
>> Here "t0" seems to be a versatile temp value, while the "t1" below is
>> the actual GPR $t1. What about renaming "t0" to something like "tmp" to
>> reduce confusion? I believe due to things like "t0 = LOONGARCH_GPR_ZERO"
>> the "t0" is 100% not an actual mapping to $t0.
> I rename t7 to t0 because there is no t3-t6, t7 looks very strange.
> But from emit_cond_jmp() the 3rd and 4th parameters have no difference
> so I suppose t0 is just OK, then whether rename it to tmp depends on
> Tiezhu's opinion.
>

Use "tmp" seems better due to it is a temp value.

>>> +     u64 func_addr;
>>> +     bool func_addr_fixed;
>>> +     int i = insn - ctx->prog->insnsi;
>>> +     int ret, jmp_offset;
>>>       const u8 code = insn->code;
>>>       const u8 cond = BPF_OP(code);
>>>       const u8 t1 = LOONGARCH_GPR_T1;
>>> @@ -400,8 +402,8 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool ext
>>>       const u8 dst = regmap[insn->dst_reg];
>>>       const s16 off = insn->off;
>>>       const s32 imm = insn->imm;
>>> -     int jmp_offset;
>>> -     int i = insn - ctx->prog->insnsi;
>>> +     const u64 imm64 = (u64)(insn + 1)->imm << 32 | (u32)insn->imm;
>>> +     const bool is32 = BPF_CLASS(insn->code) == BPF_ALU || BPF_CLASS(insn->code) == BPF_JMP32;
>> Please consider reducing diff damage and not touching parts not directly
>> affected by this change. For example this "is32" declaration and
>> initialization was moved although not related to this change.

It looks reasonable, one change per patch is better.

> I think defining variables from simple to complex and grouping them
> can make life easier. :)
>

No strong opinion on this, I am OK either way.

Thanks,
Tiezhu

