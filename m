Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FB626EC362
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 03:20:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbjDXBTL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Apr 2023 21:19:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjDXBTJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Apr 2023 21:19:09 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E7E3710DF
        for <linux-kernel@vger.kernel.org>; Sun, 23 Apr 2023 18:19:07 -0700 (PDT)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8CxztoK2UVkHGMhAA--.40538S3;
        Mon, 24 Apr 2023 09:19:06 +0800 (CST)
Received: from [10.130.0.149] (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8BxoOQJ2UVkbeg3AA--.10000S3;
        Mon, 24 Apr 2023 09:19:06 +0800 (CST)
Subject: Re: [PATCH v3 4/6] LoongArch: Add uprobes support
To:     Huacai Chen <chenhuacai@kernel.org>
References: <1681898221-27828-1-git-send-email-yangtiezhu@loongson.cn>
 <1681898221-27828-5-git-send-email-yangtiezhu@loongson.cn>
 <CAAhV-H7Z_Y+XC-yMGRA1zq9FBU-tAVK+8+Jd4t5x4L4DFXAPJA@mail.gmail.com>
Cc:     WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org, loongson-kernel@lists.loongnix.cn
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <993a2d7e-d7a2-3017-5a81-517ef6f85049@loongson.cn>
Date:   Mon, 24 Apr 2023 09:19:05 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <CAAhV-H7Z_Y+XC-yMGRA1zq9FBU-tAVK+8+Jd4t5x4L4DFXAPJA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxoOQJ2UVkbeg3AA--.10000S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvJXoW7ZF4rJFykAr1kWw4UZrW5KFg_yoW8Jw13pa
        15Aay2qrsxJ3y8Cr18X390vryaq3yktr4DWr4DXrWrG3y7Xwn8GF92gryayFyjvrnYgay0
        93Wj9FZ3ZFZxAFDanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bfxYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
        x0Y4vEx4A2jsIE14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UM2kK
        e7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI
        0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUAVWUtwAv7VC2z280
        aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2
        xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xF
        xVAFwI0_Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWw
        C2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_
        JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJV
        WUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBI
        daVFxhVjvjDU0xZFpf9x07j5xhLUUUUU=
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/23/2023 09:12 PM, Huacai Chen wrote:
> Hi, Tiezhu,
>
> On Wed, Apr 19, 2023 at 5:57 PM Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
>>
>> Uprobes is the user-space counterpart to kprobes, this commit
>> adds uprobes support for LoongArch.

...

>> +#define MAX_UINSN_BYTES                8
>> +#define UPROBE_XOL_SLOT_BYTES  MAX_UINSN_BYTES
> In old versions we define UPROBE_XOL_SLOT_BYTES to 128, why we use 8 now?

I assume "the old version" maybe comes from mips, I am not quite sure 
the backgrounds. For LoongArch, there are 2 xol slots to save 2 
instructions, each of them is 32 bit, 2*32bit=8bytes, so 
UPROBE_XOL_SLOT_BYTES can be 8.

>> +
>> +#define UPROBE_XOLBP_INSN      larch_insn_gen_break(BRK_UPROBE_XOLBP)
>> +#define UPROBE_SWBP_INSN       larch_insn_gen_break(BRK_UPROBE_BP)
>> +#define UPROBE_SWBP_INSN_SIZE  LOONGARCH_INSN_SIZE

...

>>         case BRK_UPROBE_XOLBP:
>> -               if (notify_die(DIE_UPROBE_XOL, "Uprobe_XOL", regs, bcode,
>> -                              current->thread.trap_nr, SIGTRAP) == NOTIFY_STOP)
>> +               if (uprobe_singlestep_handler(regs))
> As I know, XOL means "execute out of line", is it an alias of "single step"?

I think so, the instruction filled in xol slots is to single step, 
arm64, riscv, csky also uses "single step" for the related code, 
powerpc, s390 uses "DIE_SSTEP".

Thanks,
Tiezhu

