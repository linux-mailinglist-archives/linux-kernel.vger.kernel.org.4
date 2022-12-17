Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDE9764F6CE
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Dec 2022 02:49:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbiLQBtP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 20:49:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiLQBtN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 20:49:13 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 13B231DA4B
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 17:49:11 -0800 (PST)
Received: from loongson.cn (unknown [111.9.175.10])
        by gateway (Coremail) with SMTP id _____8DxOekWIJ1jyUgGAA--.11081S3;
        Sat, 17 Dec 2022 09:49:10 +0800 (CST)
Received: from [10.136.12.26] (unknown [111.9.175.10])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Bxb+QVIJ1jUhECAA--.9141S3;
        Sat, 17 Dec 2022 09:49:10 +0800 (CST)
Subject: Re: [PATCH] LoongArch: Correct the definition of is_branch_ins()
To:     Tiezhu Yang <yangtiezhu@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>
Cc:     loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
References: <1671006659-23859-1-git-send-email-yangtiezhu@loongson.cn>
 <e89c80c7-53e5-5fec-d66b-4b375aa85d10@loongson.cn>
 <e65ce2d5-a154-6912-ab01-b0dc158acaaa@loongson.cn>
From:   Jinyang He <hejinyang@loongson.cn>
Message-ID: <5e051682-c4fa-64d7-8567-149b5bd7d403@loongson.cn>
Date:   Sat, 17 Dec 2022 09:49:09 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <e65ce2d5-a154-6912-ab01-b0dc158acaaa@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf8Bxb+QVIJ1jUhECAA--.9141S3
X-CM-SenderInfo: pkhmx0p1dqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBjvJXoW7Cr1kJFWDXr4rXr47Ww4fAFb_yoW8WrW7pF
        95AFykGrykWrn5CF17tw48Wryftrs7Gwn2gF1UKa45Ar42qr1qqF1rXw1q9F1DXw40gF1F
        qFWaqw15uF4UAwUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bI8YFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwA2z4
        x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1l
        e2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4xG64xvF2
        IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v26r1j6r4U
        McvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67vIY487Mx
        AIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_
        Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwI
        xGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8
        JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcV
        C2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUwMKuUUUUU
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2022-12-16 14:11, Tiezhu Yang wrote:
>
>
> On 12/16/2022 11:18 AM, Jinyang He wrote:
>> Hi, Tiezhu,
>>
>>
>> On 2022-12-14 16:30, Tiezhu Yang wrote:
>>> The current definition of is_branch_ins() is not correct,
>>
>> But the branch instruction opcode only use the high 6 bits,
>
> Yes, I noticed that, the logic result of current code is right,
> but it seems a little strange (only consider reg1i21_format)
> at the first glance, the initial aim of this patch is to make
> it theoretically correct, maybe it is not the best change.
>
> I think we can neglect the instruction formats and check the
> high 6 bits instead, what do you think of the following change?

We defined many instruction format because of variable-width opcode 
field and parameter field. IMHO if there is no way to solve that problem 
really, keeping original codes is better. That depends on the 
maintainers, of course.


Thanks,

Jinyang


>
> diff --git a/arch/loongarch/include/asm/inst.h 
> b/arch/loongarch/include/asm/inst.h
> index c00e151..fd31752 100644
> --- a/arch/loongarch/include/asm/inst.h
> +++ b/arch/loongarch/include/asm/inst.h
> @@ -329,8 +329,8 @@ static inline bool is_pc_ins(union 
> loongarch_instruction *ip)
>
>  static inline bool is_branch_ins(union loongarch_instruction *ip)
>  {
> -       return ip->reg1i21_format.opcode >= beqz_op &&
> -               ip->reg1i21_format.opcode <= bgeu_op;
> +       return ((ip->word >> 26) & 0x3f) >= beqz_op &&
> +               ((ip->word >> 26) & 0x3f) <= bgeu_op;
>  }
>
> Thanks,
> Tiezhu
>
>
>

