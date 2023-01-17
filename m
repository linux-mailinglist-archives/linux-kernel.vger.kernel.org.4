Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64FC566E6EE
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 20:26:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230053AbjAQT0F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 14:26:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232310AbjAQTOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 14:14:03 -0500
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A1D6442E6
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 10:28:15 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.229])
        by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4NxHHn07ZKz9v7Nc
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 02:20:21 +0800 (CST)
Received: from [10.81.216.132] (unknown [10.81.216.132])
        by APP1 (Coremail) with SMTP id LxC2BwBHzAeU6MZjolKlAA--.65136S2;
        Tue, 17 Jan 2023 19:27:47 +0100 (CET)
Message-ID: <306bf79f-51db-473f-636c-e1d7d1dc685e@huaweicloud.com>
Date:   Tue, 17 Jan 2023 19:27:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: Internal vs. external barriers (was: Re: Interesting LKMM litmus
 test)
To:     paulmck@kernel.org, Alan Stern <stern@rowland.harvard.edu>
Cc:     Andrea Parri <parri.andrea@gmail.com>,
        Jonas Oberhauser <jonas.oberhauser@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>, will <will@kernel.org>,
        "boqun.feng" <boqun.feng@gmail.com>, npiggin <npiggin@gmail.com>,
        dhowells <dhowells@redhat.com>,
        "j.alglave" <j.alglave@ucl.ac.uk>,
        "luc.maranget" <luc.maranget@inria.fr>, akiyks <akiyks@gmail.com>,
        dlustig <dlustig@nvidia.com>, joel <joel@joelfernandes.org>,
        urezki <urezki@gmail.com>,
        quic_neeraju <quic_neeraju@quicinc.com>,
        frederic <frederic@kernel.org>,
        Kernel development list <linux-kernel@vger.kernel.org>
References: <20230115181052.GJ2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8RmEtBnwqOzNhsK@rowland.harvard.edu>
 <20230116042329.GN2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8WTXS73qTBpUzcI@rowland.harvard.edu>
 <20230116190652.GZ2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8WjmTFnqbAnS1Pz@rowland.harvard.edu>
 <20230116221357.GA2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8aKlNY4Z0z2Yqs0@andrea>
 <20230117151416.GI2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8bFMgDSUZymXUsS@rowland.harvard.edu>
 <20230117174308.GK2948950@paulmck-ThinkPad-P17-Gen-1>
From:   Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
In-Reply-To: <20230117174308.GK2948950@paulmck-ThinkPad-P17-Gen-1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LxC2BwBHzAeU6MZjolKlAA--.65136S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAry5uF17Cr4kAry8Zw1rXrb_yoWrZw1DpF
        W5KF9xtFs8Jr4xZrn2kw18WrySvry8ta15Jrn8tw1kZrn8Wrn8KrW7Kr1YvF9xCr4IkF4Y
        vF4j939rZ3yqvaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9Sb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS
        07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07
        C267AKxVWUXVWUAwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1r
        MI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJV
        WUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rWU
        JVWrZr1UMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr
        1UYxBIdaVFxhVjvjDU0xZFpf9x07UZ18PUUUUU=
X-CM-SenderInfo: 5mrqt2oorev25kdx2v3u6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org




On 1/17/2023 6:43 PM, Paul E. McKenney wrote:
> On Tue, Jan 17, 2023 at 10:56:34AM -0500, Alan Stern wrote:
>> On Tue, Jan 17, 2023 at 07:14:16AM -0800, Paul E. McKenney wrote:
>>> On Tue, Jan 17, 2023 at 12:46:28PM +0100, Andrea Parri wrote:
>>>> This was reminiscent of old discussions, in fact, we do have:
>>>>
>>>> [tools/memory-model/Documentation/litmus-tests.txt]
>>>>
>>>> e.	Although sleepable RCU (SRCU) is now modeled, there
>>>> 	are some subtle differences between its semantics and
>>>> 	those in the Linux kernel.  For example, the kernel
>>>> 	might interpret the following sequence as two partially
>>>> 	overlapping SRCU read-side critical sections:
>>>>
>>>> 		 1  r1 = srcu_read_lock(&my_srcu);
>>>> 		 2  do_something_1();
>>>> 		 3  r2 = srcu_read_lock(&my_srcu);
>>>> 		 4  do_something_2();
>>>> 		 5  srcu_read_unlock(&my_srcu, r1);
>>>> 		 6  do_something_3();
>>>> 		 7  srcu_read_unlock(&my_srcu, r2);
>>>>
>>>> 	In contrast, LKMM will interpret this as a nested pair of
>>>> 	SRCU read-side critical sections, with the outer critical
>>>> 	section spanning lines 1-7 and the inner critical section
>>>> 	spanning lines 3-5.
>>>>
>>>> 	This difference would be more of a concern had anyone
>>>> 	identified a reasonable use case for partially overlapping
>>>> 	SRCU read-side critical sections.  For more information
>>>> 	on the trickiness of such overlapping, please see:
>>>> 	https://paulmck.livejournal.com/40593.html
>>> Good point, if we do change the definition, we also need to update
>>> this documentation.
>>>
>>>> More recently/related,
>>>>
>>>>    https://lore.kernel.org/lkml/20220421230848.GA194034@paulmck-ThinkPad-P17-Gen-1/T/#m2a8701c7c377ccb27190a6679e58b0929b0b0ad9
>>> It would not be a bad thing for LKMM to be able to show people the
>>> error of their ways when they try non-nested partially overlapping SRCU
>>> read-side critical sections.  Or, should they find some valid use case,
>>> to help them prove their point.  ;-)
>> Isn't it true that the current code will flag srcu-bad-nesting if a
>> litmus test has non-nested overlapping SRCU read-side critical sections?
> Now that you mention it, it does indeed, flagging srcu-bad-nesting.
>
> Just to see if I understand, different-values yields true if the set
> contains multiple elements with the same value mapping to different
> values.  Or, to put it another way, if the relation does not correspond
> to a function.
>
> Or am I still missing something?

based on https://lkml.org/lkml/2019/1/10/155:
I think different-values(r) is the same as r \ same-values, where 
same-values links all reads and writes that have the same value (e.g., 
"write 5 to x" and "read 5 from y").

With this in mind, I think the idea is to 1) forbid partial overlap, and 
using the different-values to 2) force them to provide the appropriate 
value.
This works because apparently srcu-lock is a read and srcu-unlock is a 
write, so in case of
int r1 = srcu-lock(&ss);   ==>  Read(&ss, x), r1 := x
...
srcu-unlock(&ss, r1);  ==> Write(&ss, r1), which is Write(&ss, x)

This guarantees that the read and write have the same value, hence 
different-values(...) will be the empty relation, and so no flag.

>
>> And if it is true, is there any need to change the memory model at this
>> point?
>>
>> (And if it's not true, that's most likely due to a bug in herd7.)
> Agreed, changes must wait for SRCU support in herd7.
>
> At which point something roughly similar to this might work?
>
> let srcu-rscs = return_value(Srcu-lock) ; (dep | rfi)* ;
> 		parameter(Srcu-unlock, 2)

I would like instead to be able to give names to the arguments of events 
that become dependency relations, like
    event srcu_unlock(struct srcu_struct *srcu_addr, struct srcu_token 
*srcu_data)
and then
     let srcu-rscs = [Srcu-lock] ; srcu_data ; (data; rfi)*

Personally I would also like to not have Linux-specific primitives in 
herd7/cat, that means that to understand LKMM you also need to 
understand the herd7 tool, and sounds quite brittle.

I would prefer if herd7 had some means to define custom 
events/instructions and uninterpreted relations between them, like

relation rf : [write] x [read]
[read] <= range(rf)
empty rf ;rf^-1 \ id

and some way to say
[read] ; .return <= rf^-1 ; .data
(where .return is a functional relation relating every event to the 
value it returns, and .xyz is the functional relation relating every 
event to the value of its argument xyz).



