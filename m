Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 435E467992A
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 14:22:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234102AbjAXNWY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 08:22:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234056AbjAXNWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 08:22:21 -0500
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C58CA2710
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 05:22:17 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.229])
        by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4P1S9H2CBYz9v7HZ
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 21:14:11 +0800 (CST)
Received: from [10.48.129.122] (unknown [10.48.129.122])
        by APP2 (Coremail) with SMTP id GxC2BwAX511m289jmubAAA--.13674S2;
        Tue, 24 Jan 2023 14:21:53 +0100 (CET)
Message-ID: <dd15019c-f66f-44ff-59cd-f937c1b9e0f6@huaweicloud.com>
Date:   Tue, 24 Jan 2023 14:21:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: Internal vs. external barriers (was: Re: Interesting LKMM litmus
 test)
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Jonas Oberhauser <jonas.oberhauser@huawei.com>,
        "paulmck@kernel.org" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "parri.andrea" <parri.andrea@gmail.com>, will <will@kernel.org>,
        "boqun.feng" <boqun.feng@gmail.com>, npiggin <npiggin@gmail.com>,
        dhowells <dhowells@redhat.com>,
        "j.alglave" <j.alglave@ucl.ac.uk>,
        "luc.maranget" <luc.maranget@inria.fr>, akiyks <akiyks@gmail.com>,
        dlustig <dlustig@nvidia.com>, joel <joel@joelfernandes.org>,
        urezki <urezki@gmail.com>,
        quic_neeraju <quic_neeraju@quicinc.com>,
        frederic <frederic@kernel.org>,
        Kernel development list <linux-kernel@vger.kernel.org>
References: <20220921173109.GA1214281@paulmck-ThinkPad-P17-Gen-1>
 <YytfFiMT2Xsdwowf@rowland.harvard.edu>
 <YywXuzZ/922LHfjI@hirez.programming.kicks-ass.net>
 <114ECED5-FED1-4361-94F7-8D9BC02449B7> <Y87w5KHZ2UP2aLLG@rowland.harvard.edu>
From:   Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
In-Reply-To: <Y87w5KHZ2UP2aLLG@rowland.harvard.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GxC2BwAX511m289jmubAAA--.13674S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Ww43ZFWfCw18AryxGrW8Crg_yoW8tw4kpF
        yUKa98KFykAr109ws2yrW0qFnFvrZ3tryrXr4vkryfCwn0qrn3XF43trW5ur98Xr4fAw4j
        vr4YqasrX3WDZaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS
        07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
        02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_
        WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
        CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE
        14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf
        9x07UdxhLUUUUU=
X-CM-SenderInfo: 5mrqt2oorev25kdx2v3u6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/23/2023 9:41 PM, Alan Stern wrote:
> On Mon, Jan 23, 2023 at 09:06:54PM +0100, Jonas Oberhauser wrote:
>>
>> On 1/23/2023 8:58 PM, Alan Stern wrote:
>>> On Mon, Jan 23, 2023 at 05:16:27PM +0100, Jonas Oberhauser wrote:
>>>> On 1/19/2023 5:41 PM, Alan Stern wrote:
>>>>
>>>>> But when you're comparing grace periods or critical sections to each other,
>>>>> things get a little ambiguous.  Should G1 be considered to come before
>>>>> G2 when t1(G1) < t1(G2), when t2(G1) < t2(G2), or when t2(G1) < t1(G2)?
>>>>> Springing for (po ; rcu-order ; po?) amounts to choosing the second
>>>>> alternative.
>>>> Aha, I see! Powerful notation indeed.
>>>> Keeping that in mind, wouldn't it make sense for pb also be changed to
>>>> `...;po?` ?
>>> You mean changing the definition of pb to either:
>>>
>>> 	prop ; strong-fence ; hb* ; po? ; [Marked]
>>>
>>> or
>>>
>>> 	prop ; strong-fence ; hb* ; [Marked] ; po? ; [Marked]
>> Oh no, not at all!
>>
>> I mean that
>>      pb = prop ; po ; {strong ordering-operation} ; po ; hb* ; [Marked]
>> could instead be
>>      pb = prop ; po ; {strong ordering-operation} ; po? ; hb* ; [Marked]
>>
>> (note that the po ; ... ; po part is actually folded inside the actual
>> definition of strong fence).
> This goes back to the original herd models, before the LKMM came about:
> The fencerel() macro uses po on both sides.  I believe the motivating
> idea back then was that ordering should apply only to memory accesses
> (which can in practice be observed), not to other types of events such
> as memory barriers.
I see. I believe this argument no longer strictly holds, now that rcu-gp 
needs to be ordered in some cases.

>>> rcu-fence is different because rcu-order has to begin and end with
>>> either a grace period or a critical section, and both of these restrict
>>> the execution order of surrounding events:
>>>
>>> 	If X is a synchronize_rcu() or rcu_read_unlock() then events
>>> 	po-before X must execute before X;
>>>
>>> 	If X is a synchronize_rcu() or rcu_read_lock() then events
>>> 	po-after X must execute after X.
>>>
>> I believe so do the strong ordering-operations in pb.
> But the beginning and end of a pb link (for example, overwrite and hb)
> don't need to be strong-ordering operations.
Of course, but I'm not suggesting to put a po? at those locations.

have fun, jonas

