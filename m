Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6945C6EEBA7
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 02:47:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237880AbjDZArB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 20:47:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236800AbjDZAq7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 20:46:59 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EC939C149
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 17:46:56 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.170])
        by gateway (Coremail) with SMTP id _____8DxZPB_dEhkd8cAAA--.1398S3;
        Wed, 26 Apr 2023 08:46:55 +0800 (CST)
Received: from [10.20.42.170] (unknown [10.20.42.170])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8DxsrR+dEhkF8o7AA--.15386S3;
        Wed, 26 Apr 2023 08:46:55 +0800 (CST)
Message-ID: <f0f029c5-b095-d713-114f-dc7d5c092d8a@loongson.cn>
Date:   Wed, 26 Apr 2023 08:46:54 +0800
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
From:   maobibo <maobibo@loongson.cn>
In-Reply-To: <d9c9b2cb-dd5e-03dd-9a7e-27938af96aaf@xen0n.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DxsrR+dEhkF8o7AA--.15386S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjvJXoW7XFWrArW8Kw1fCw47Cw4xtFb_yoW8JF18pa
        48ZFs8JrW5Ww1kG34UJ3WDWr90yrZrGa15W3W0va43KrZrXFyq9r18XrWqgF15t393WF10
        qr1rXF9F9F9rJ3JanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bf8YFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
        x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267AKxVW8JVW8Jr1ln4kS
        14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
        1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv
        67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
        AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C2
        67AKxVWUXVWUAwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI
        8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWU
        CwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r
        1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsG
        vfC2KfnxnUUI43ZEXa7IU8hiSPUUUUU==
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/4/25 21:28, WANG Xuerui 写道:
> On 2023/4/25 21:25, maobibo wrote:
>>
>>
>> 在 2023/4/25 19:49, Peter Zijlstra 写道:
> 
> <snip>
> 
>>>
>>> diff --git a/arch/loongarch/kernel/genex.S b/arch/loongarch/kernel/genex.S
>>> index 44ff1ff64260..3c8a6bab98fe 100644
>>> --- a/arch/loongarch/kernel/genex.S
>>> +++ b/arch/loongarch/kernel/genex.S
>>> @@ -18,27 +18,31 @@
>>>         .align    5
>>>   SYM_FUNC_START(__arch_cpu_idle)
>>> -    /* start of rollback region */
>>> -    LONG_L    t0, tp, TI_FLAGS
>>> -    nop
>>> -    andi    t0, t0, _TIF_NEED_RESCHED
>>> -    bnez    t0, 1f
>>> -    nop
>>> -    nop
>>> -    nop
>>> +    /* start of idle interrupt region */
>>> +    move    t0, CSR_CRMD_IE
>> addi.d  t0, zero, CSR_CRMD_IE can be used here, move is used for reg to reg
> 
> Or better: li.d t0, CSR_CRMD_IE (prefer pseudo-instruction over concrete ones whenever it helps readability). We don't need to support ancient in-house toolchains without support for even li. ;-)
  
I am not familiar with compiler:(, how many actual instructions does
pseudo-instr li.d takes? It will be ok if it uses only one intr, else
there will be problem.

Regards
Bibo, Mao

> 

