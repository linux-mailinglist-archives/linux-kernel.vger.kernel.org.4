Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1022E69006A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 07:35:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbjBIGfA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 01:35:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjBIGe6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 01:34:58 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 40CD42ED7C
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 22:34:56 -0800 (PST)
Received: from loongson.cn (unknown [192.168.200.1])
        by gateway (Coremail) with SMTP id _____8DxSuoPlORjKVEQAA--.32262S3;
        Thu, 09 Feb 2023 14:34:55 +0800 (CST)
Received: from [0.0.0.0] (unknown [192.168.200.1])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8BxtOUNlORjhygvAA--.55653S3;
        Thu, 09 Feb 2023 14:34:53 +0800 (CST)
Subject: Re: [PATCH v2 0/5] LoongArch: Add kernel relocation and KASLR support
To:     Xi Ruoyao <xry111@xry111.site>
References: <20230207142822.52172-1-xry111@xry111.site>
 <70278d23-aa0e-19d9-796f-78c0fd06fee0@loongson.cn>
 <87b9f23ba8b123a765c4139c2112aa365546c1e5.camel@xry111.site>
Cc:     Jinyang He <hejinyang@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>,
        Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org
From:   Youling Tang <tangyouling@loongson.cn>
Message-ID: <c11aae17-838f-3741-0c13-1c830ac30a56@loongson.cn>
Date:   Thu, 9 Feb 2023 14:34:53 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <87b9f23ba8b123a765c4139c2112aa365546c1e5.camel@xry111.site>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8BxtOUNlORjhygvAA--.55653S3
X-CM-SenderInfo: 5wdqw5prxox03j6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBjvJXoWxJry5JF1xJF4fKr43ZFW5Jrb_yoW8XFy3pF
        yfGr4DKF4DXF1I9F429a45XryIyr4xK3yrCFsYk348Z390gF13KFyrKws2krZ7Ar12gF4I
        9rWSyFyxCF45AFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bOxFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4
        AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF
        7I0E14v26r1j6r4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7
        CjxVAFwI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2
        zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VCjz48v1sIEY20_WwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0E
        wIxGrwCF04k20xvE74AGY7Cv6cx26rWl4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
        xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1D
        MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
        0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
        JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x0zRVWl
        kUUUUU=
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/08/2023 04:27 PM, Xi Ruoyao wrote:
> On Wed, 2023-02-08 at 12:37 +0800, Youling Tang wrote:
>> In the case of "[Patch v2 2/5] LoongArch: use la.pcrel instenad of
>> la.abs for exception handlerS", the above failure will occur.
>>
>> Patch2 may have certain problems when using the old toolchains.
>>
>> Youling.
>
> Thanks for the test...
>
> The problem is: old toolchain uses pcaddu12i/ori/lu32i.d/lu52i.d/add.d
> for a 3-operand la.pcrel, while the new toolchain uses
> pcalau12i/addi.d/lu32i/lu52i/add.d.  (I've somehow forgotten all the
> difference!)
>
> We can fix it with something like...
>
>> +void reloc_handler(unsigned long handler, struct handler_reloc *rel)
>> +{
>> +	if (!rel)
>> +		return;
>> +
>> +	for (unsigned long i = 0; i < rel->cnt; i++) {
>> +		unsigned long pc = handler + rel->entries[i].offset;
>> +		unsigned long v = rel->entries[i].sym;
>
>                 /* anchor etc. moved into do_reloc_pcalau12i */
>
>> +		union loongarch_instruction *insn =
>> +			(union loongarch_instruction *)pc;
>
>                 switch insn[0]->reg1i20_format->reg1i20_format {
>                 case pcaddu12i_op:
>                         do_reloc_pcaddu12i(insn, pc, v);
>                         break;
>                 case pcalau12i_op: /* TODO: add it for asm/inst.h */
>                         do_reloc_pcalau12i(insn, pc, v);
>                         break;
>                 default:
>                         panic("what the f**k");
>                 }
>
> Alternatively, we can also emit the pcalau12i/addi.d/lu32i/lu52i
> sequence and overwrite the pcaddu12i/ori sequence generated by the old
> toolchain.
>
> Which way do you like?

v3 tested successfully in both new and old toolchains.

Youling.
>

