Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45B3F670B7F
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 23:14:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbjAQWO3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 17:14:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbjAQWNr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 17:13:47 -0500
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFFB437B55
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 12:21:35 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.227])
        by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4NxKpW2t2fz9v7Yx
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 04:13:39 +0800 (CST)
Received: from [10.81.216.132] (unknown [10.81.216.132])
        by APP2 (Coremail) with SMTP id GxC2BwCnLWQoA8djNiekAA--.31938S2;
        Tue, 17 Jan 2023 21:21:09 +0100 (CET)
Message-ID: <8385813c-f649-946a-a0ba-54475824f37d@huaweicloud.com>
Date:   Tue, 17 Jan 2023 21:20:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: Internal vs. external barriers (was: Re: Interesting LKMM litmus
 test)
To:     paulmck@kernel.org
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
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
References: <20230116042329.GN2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8WTXS73qTBpUzcI@rowland.harvard.edu>
 <20230116190652.GZ2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8WjmTFnqbAnS1Pz@rowland.harvard.edu>
 <20230116221357.GA2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8aKlNY4Z0z2Yqs0@andrea>
 <20230117151416.GI2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8bFMgDSUZymXUsS@rowland.harvard.edu>
 <20230117174308.GK2948950@paulmck-ThinkPad-P17-Gen-1>
 <306bf79f-51db-473f-636c-e1d7d1dc685e@huaweicloud.com>
 <20230117185521.GN2948950@paulmck-ThinkPad-P17-Gen-1>
From:   Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
In-Reply-To: <20230117185521.GN2948950@paulmck-ThinkPad-P17-Gen-1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GxC2BwCnLWQoA8djNiekAA--.31938S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAFWkurW7CFWUtrW8CF13twb_yoWrXF1UpF
        W5KFZ3ta1DWFs29rn2kw17XFySyaySqa9xArn8JF18Zay5Xr1SgF4ftr4FvrsxArWxJrn0
        va1Yv345A3yDA3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvab4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
        e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
        Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a
        6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
        kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv
        67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyT
        uYvjxUFDGOUUUUU
X-CM-SenderInfo: 5mrqt2oorev25kdx2v3u6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/17/2023 7:55 PM, Paul E. McKenney wrote:

> On Tue, Jan 17, 2023 at 07:27:29PM +0100, Jonas Oberhauser wrote:
>> On 1/17/2023 6:43 PM, Paul E. McKenney wrote:
>>> Just to see if I understand, different-values yields true if the set
>>> contains multiple elements with the same value mapping to different
>>> values.  Or, to put it another way, if the relation does not correspond
>>> to a function.
>> based on https://lkml.org/lkml/2019/1/10/155:
> Ah, thank you for the pointer!

What troubles me is that this is the only reference I could find as to 
what the meaning of different-values is. Herd7 is a great tool for 
specifying memory models, but the documentation could be heavily improved.

>> I think different-values(r) is the same as r \ same-values, where
>> same-values links all reads and writes that have the same value (e.g.,
>> "write 5 to x" and "read 5 from y").
>>
>> With this in mind, I think the idea is to 1) forbid partial overlap, and
>> using the different-values to 2) force them to provide the appropriate
>> value.
>> This works because apparently srcu-lock is a read and srcu-unlock is a
>> write, so in case of
>> int r1 = srcu-lock(&ss);   ==>  Read(&ss, x), r1 := x
>> ...
>> srcu-unlock(&ss, r1);  ==> Write(&ss, r1), which is Write(&ss, x)
>>
>> This guarantees that the read and write have the same value, hence
>> different-values(...) will be the empty relation, and so no flag.
> Might it instead match the entire event?

Which event?

Btw, if you want to state that a relation is functional (e.g., that 
srcu-rscs only matches each lock event to at most one unlock event), one 
way to do so is to state

flag ~empty ((srcu-rscs ; srcu-rscs^-1) \ id) as srcu-use-multiple-lock

I visualize this as two different locks pointing via srcu-rscs to the 
same unlock.
Analogously,

flag ~empty ((srcu-rscs^-1 ; srcu-rscs) \ id) as srcu-reuse-lock-idx

should flag if a single lock points to two different unlocks (note: in a 
single execution! this does not flag `int idx = srcu_lock(&ss); if { 
...; srcu_unlock(&ss,idx); } else { ... ; srcu_unlock(&ss,idx) ;... } `).

[snipping in here a part written by Alan:]

> I think what you want would be:
>
> let srcu-rscs = ([Srcu-lock] ; data ; [Srcu-unlock]) & loc
>

I think it makes more sense to define
     let srcu-rscs = ([Srcu-lock] ; (whatever relation says "I'm using 
the return value as the second input") ; [Srcu-unlock])
and then to do
     flag ~empty srcu-rscs\loc as srcu-passing-idx-to-wrong-unlock
to flag cases where you try to pass an index from one srcu_struct to 
another.

>>> Agreed, changes must wait for SRCU support in herd7.
>>>
>> I would like instead to be able to give names to the arguments of events
>> that become dependency relations, like
>>     event srcu_unlock(struct srcu_struct *srcu_addr, struct srcu_token
>> *srcu_data)
>> and then
>>      let srcu-rscs = [Srcu-lock] ; srcu_data ; (data; rfi)*
>>
>> Personally I would also like to not have Linux-specific primitives in
>> herd7/cat, that means that to understand LKMM you also need to understand
>> the herd7 tool, and sounds quite brittle.
>>
>> I would prefer if herd7 had some means to define custom events/instructions
>> and uninterpreted relations between them, like
>>
>> relation rf : [write] x [read]
>> [read] <= range(rf)
>> empty rf ;rf^-1 \ id
>>
>> and some way to say
>> [read] ; .return <= rf^-1 ; .data
>> (where .return is a functional relation relating every event to the value it
>> returns, and .xyz is the functional relation relating every event to the
>> value of its argument xyz).
> I am glad that I asked rather than kneejerk filing a bug report.  ;-)

Please send me a link if you open a thread, then I'll voice my wishes as well.
Maybe Luc is in a wish-fulfilling mood?

best wishes,
jonas

PS:

> Other thoughts?

Other than that I added too many [] in my example? :) :( :) I meant

relation rf : write x read
read <= range(rf)
empty rf ;rf^-1 \ id

