Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD44E5EB86F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 05:13:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231194AbiI0DN3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 23:13:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231197AbiI0DMe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 23:12:34 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B193610FE3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 20:10:39 -0700 (PDT)
Received: from [10.20.42.28] (unknown [10.20.42.28])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Cx72umaTJj5ZEiAA--.60554S3;
        Tue, 27 Sep 2022 11:10:31 +0800 (CST)
Message-ID: <5bf565a4-5bc4-42f8-59c0-8b908a9c2ab6@loongson.cn>
Date:   Tue, 27 Sep 2022 11:10:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3] LoongArch: Fixup do_ri csr_era
Content-Language: en-US
To:     Guo Ren <guoren@kernel.org>
Cc:     Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Qing Zhang <zhangqing@loongson.cn>,
        Mao Bibo <maobibo@loongson.cn>,
        Jianmin Lv <lvjianmin@loongson.cn>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20220926122727.2310118-1-yijun@loongson.cn>
 <CAJF2gTQR804AwU0up2-FyTciQZJY2M9xQ7JbiqjwMbkD=aLhCQ@mail.gmail.com>
From:   Jun Yi <yijun@loongson.cn>
In-Reply-To: <CAJF2gTQR804AwU0up2-FyTciQZJY2M9xQ7JbiqjwMbkD=aLhCQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8Cx72umaTJj5ZEiAA--.60554S3
X-Coremail-Antispam: 1UD129KBjvJXoWrtw18JrWkGFW7ur15CF4rZrb_yoW8Jr1rpF
        nrCa1DJF48XFnrCw1Dtr4jvry3tasxGr43uanrt34Sk3Wqqr9Yq3WvqF12vF1jv3y5Gr40
        qFyFy3sFga13Aa7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9G14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26r
        xl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
        6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr
        0_Gr1lF7xvr2IY64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxa
        n2IY04v7Mxk0xIA0c2IEe2xFo4CEbIxvr21lc2xSY4AK6svPMxAIw28IcxkI7VAKI48JMx
        C20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAF
        wI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20x
        vE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v2
        0xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxV
        W8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbXdbUUUUUU==
X-CM-SenderInfo: p1lm30o6or00hjvr0hdfq/1tbiAQACAWMxll4P4AABs2
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

do_ri is porting from mips, mipsr6 use do_ri to emulate some fp 
instructions, but Loongarch do not need to emulate these instructions.

And the regs->csr_era be always recovered to ths old_era = 
regs->csr_era, so the compute_return_era is useless.

On 9/27/22 07:41, Guo Ren wrote:
> On Mon, Sep 26, 2022 at 8:27 PM Jun Yi <yijun@loongson.cn> wrote:
>>
>> csr_era of pt_regs in do_ri should not add 4 to point to the
>> next instruction.
> The comment does not make sense. I think it wants to skip some
> instructions, but your patch broke that.
> 
>>
>> Signed-off-by: Jun Yi <yijun@loongson.cn>
>> ---
>>   arch/loongarch/kernel/traps.c | 2 --
>>   1 file changed, 2 deletions(-)
>>
>> diff --git a/arch/loongarch/kernel/traps.c b/arch/loongarch/kernel/traps.c
>> index aa1c95aaf595..ec888eda3d45 100644
>> --- a/arch/loongarch/kernel/traps.c
>> +++ b/arch/loongarch/kernel/traps.c
>> @@ -477,8 +477,6 @@ asmlinkage void noinstr do_ri(struct pt_regs *regs)
>>
>>          die_if_kernel("Reserved instruction in kernel code", regs);
>>
>> -       compute_return_era(regs);
>> -
>>          if (unlikely(get_user(opcode, era) < 0)) {
>>                  status = SIGSEGV;
>>                  current->thread.error_code = 1;
>> --
>> 2.31.1
>>
> 
> 

