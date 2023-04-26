Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0179E6EEC54
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 04:23:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238824AbjDZCXf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 22:23:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237911AbjDZCXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 22:23:33 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7D19C192
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 19:23:31 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.170])
        by gateway (Coremail) with SMTP id _____8Cx9egii0hkxtMAAA--.1423S3;
        Wed, 26 Apr 2023 10:23:30 +0800 (CST)
Received: from [10.20.42.170] (unknown [10.20.42.170])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8DxurIgi0hk4u07AA--.16026S3;
        Wed, 26 Apr 2023 10:23:28 +0800 (CST)
Message-ID: <a1815428-36bb-780f-313f-c4dcb22887f3@loongson.cn>
Date:   Wed, 26 Apr 2023 10:23:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: Loongson (and other $ARCHs?) idle VS timer enqueue
Content-Language: en-US
To:     WANG Xuerui <kernel@xen0n.name>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Huacai Chen <chenhuacai@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
References: <ZEKDZEQmKExv0O7Q@lothringen> <87leil2r7v.ffs@tglx>
 <20230422081700.GB1214746@hirez.programming.kicks-ass.net>
 <ZEPteS82TbIhMQxe@lothringen>
 <20230422150409.GL1214746@hirez.programming.kicks-ass.net>
 <7d91fa2a-57c5-6c78-8e2d-7fbdd6a11cba@loongson.cn>
 <20230425114937.GC1335080@hirez.programming.kicks-ass.net>
 <5ba79220-683f-a78a-8c3b-bc0b118226f8@loongson.cn>
 <d9c9b2cb-dd5e-03dd-9a7e-27938af96aaf@xen0n.name>
 <f0f029c5-b095-d713-114f-dc7d5c092d8a@loongson.cn>
 <b882eb61-d783-985e-7687-386f9e03235d@xen0n.name>
From:   maobibo <maobibo@loongson.cn>
In-Reply-To: <b882eb61-d783-985e-7687-386f9e03235d@xen0n.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DxurIgi0hk4u07AA--.16026S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjvJXoW7KF4kury5Xw1fJryktr1rCrg_yoW8Ar1xpa
        4kZF4DArW5Ww1kG348tw15urZ0yrykKw45W3W8JFy5Gr4qgryq9F1xXr4qgFyrt393Gr10
        qr1UXasF9Fy7J3JanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bqkYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
        x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1l
        n4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6x
        ACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E
        87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0V
        AS07AlzVAYIcxG8wCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCF
        s4IE7xkEbVWUJVW8JwCFI7km07C267AKxVWUXVWUAwC20s026c02F40E14v26r1j6r18MI
        8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41l
        IxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIx
        AIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2
        jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07j7189UUUUU=
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/4/26 10:10, WANG Xuerui 写道:
> On 2023/4/26 08:46, maobibo wrote:
>>
>>
>> 在 2023/4/25 21:28, WANG Xuerui 写道:
>>> On 2023/4/25 21:25, maobibo wrote:
>>>>
>>>>
>>>> 在 2023/4/25 19:49, Peter Zijlstra 写道:
>>>
>>> <snip>
>>>
>>>>>
>>>>> diff --git a/arch/loongarch/kernel/genex.S b/arch/loongarch/kernel/genex.S
>>>>> index 44ff1ff64260..3c8a6bab98fe 100644
>>>>> --- a/arch/loongarch/kernel/genex.S
>>>>> +++ b/arch/loongarch/kernel/genex.S
>>>>> @@ -18,27 +18,31 @@
>>>>>          .align    5
>>>>>    SYM_FUNC_START(__arch_cpu_idle)
>>>>> -    /* start of rollback region */
>>>>> -    LONG_L    t0, tp, TI_FLAGS
>>>>> -    nop
>>>>> -    andi    t0, t0, _TIF_NEED_RESCHED
>>>>> -    bnez    t0, 1f
>>>>> -    nop
>>>>> -    nop
>>>>> -    nop
>>>>> +    /* start of idle interrupt region */
>>>>> +    move    t0, CSR_CRMD_IE
>>>> addi.d  t0, zero, CSR_CRMD_IE can be used here, move is used for reg to reg
>>>
>>> Or better: li.d t0, CSR_CRMD_IE (prefer pseudo-instruction over concrete ones whenever it helps readability). We don't need to support ancient in-house toolchains without support for even li. ;-)
>>    I am not familiar with compiler:(, how many actual instructions does
>> pseudo-instr li.d takes? It will be ok if it uses only one intr, else
>> there will be problem.
> 
> It's just `ori $t0, $zero, 4` no matter which of li.w or li.d is used. It only matters when the immediate to load is bigger. Given CSR_CRMD_IE is just 4 (1<<2) you can definitely say `li.w` if you want to be extra cautious and it won't hurt. ;-)

That is good to me, you are compiler expert:)

> 

