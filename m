Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9139867601B
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 23:22:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbjATWWN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 17:22:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjATWWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 17:22:11 -0500
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A22E7762DE
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 14:22:08 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.229])
        by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4NzDL86PR3z9v7Jk
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jan 2023 06:14:08 +0800 (CST)
Received: from [10.81.218.54] (unknown [10.81.218.54])
        by APP2 (Coremail) with SMTP id GxC2BwDnuWDtE8tjkDexAA--.5719S2;
        Fri, 20 Jan 2023 23:21:44 +0100 (CET)
Message-ID: <a4cf8b8e-2527-545a-7175-a2ca4d7028c4@huaweicloud.com>
Date:   Fri, 20 Jan 2023 23:21:30 +0100
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
References: <Y8gjUKoHxqR9+7Hx@rowland.harvard.edu>
 <3dabbcfb-858c-6aa0-6824-05b8cc8e9cdb@gmail.com>
 <20230118201918.GI2948950@paulmck-ThinkPad-P17-Gen-1>
 <a5637181-1675-7973-489c-e5d24cbd25c2@huaweicloud.com>
 <20230118211201.GL2948950@paulmck-ThinkPad-P17-Gen-1>
 <09f084d2-6128-7f83-b2a5-cbe236b1678d@huaweicloud.com>
 <20230119001147.GN2948950@paulmck-ThinkPad-P17-Gen-1>
 <0fae983b-2a7c-d44e-8881-53d5cc053f09@huaweicloud.com>
 <20230119184107.GT2948950@paulmck-ThinkPad-P17-Gen-1>
 <64b48a7b-624c-26bd-be9b-0522fc490b28@huaweicloud.com>
 <20230120154709.GG2948950@paulmck-ThinkPad-P17-Gen-1>
From:   Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
In-Reply-To: <20230120154709.GG2948950@paulmck-ThinkPad-P17-Gen-1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GxC2BwDnuWDtE8tjkDexAA--.5719S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Gw13JF4kXw13XrWfXw1rtFb_yoWxGFyrpF
        Z5tFyFywnrAr17uFn2v3W7try0yry8Ka15Xrn5Xry8Zws0gFn3urySgw1a9F43Cr1fJr4q
        vr4YqasxZa4DAaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9vb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
        e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2
        xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWU
        WwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr
        0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWr
        Jr0_WFyUJwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4UJV
        WxJrUvcSsGvfC2KfnxnUUI43ZEXa7IU13rcDUUUUU==
X-CM-SenderInfo: 5mrqt2oorev25kdx2v3u6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/20/2023 4:47 PM, Paul E. McKenney wrote:
> On Fri, Jan 20, 2023 at 11:13:00AM +0100, Jonas Oberhauser wrote:
>>
>> On 1/19/2023 7:41 PM, Paul E. McKenney wrote:
>>> On Thu, Jan 19, 2023 at 02:39:01PM +0100, Jonas Oberhauser wrote:
>>>> On 1/19/2023 1:11 AM, Paul E. McKenney wrote:
>>>>> On Wed, Jan 18, 2023 at 10:24:50PM +0100, Jonas Oberhauser wrote:
>>>>>> What I was thinking of is more something like this:
>>>>>>
>>>>>> P0{
>>>>>>       idx1 = srcu_down(&ss);
>>>>>>       srcu_up(&ss,idx1);
>>>>>> }
>>>>>>
>>>>>> P1{
>>>>>>        idx2 = srcu_down(&ss);
>>>>>>        srcu_up(&ss,idx2)
>>>>>> }
>>>>> And srcu_read_lock() and srcu_read_unlock() already do this.
>>>> I think I left out too much from my example.
>>>> And filling in the details led me down a bit of a rabbit hole of confusion
>>>> for a while.
>>>> But here's what I ended up with:
>>>>
>>>>
>>>> P0{
>>>>       idx1 = srcu_down(&ss);
>>>>       store_rel(p1, true);
>>>>
>>>>
>>>>       shared cs
>>>>
>>>>       R x == ?
>>>>
>>>>       while (! load_acq(p2));
>>>>       R idx2 == idx1 // for some reason, we got lucky!
>>>>       srcu_up(&ss,idx1);
>>> Although the current Linux-kernel implementation happens to be fine with
>>> this sort of abuse, I am quite happy to tell people "Don't do that!"
>>> And you can do this with srcu_read_lock() and srcu_read_unlock().
>>> In contrast, this actually needs srcu_down_read() and srcu_up_read():
>> My point/clarification request wasn't about whether you could write that
>> code with read_lock() and read_unlock(), but what it would/should mean for
>> the operational and axiomatic models.
>> As I wrote later in the mail, for the operational model it is quite clear
>> that x==1 should be allowed for lock() and unlock(), but would probably be
>> forbidden for down() and up().
> Agreed, the math might say something or another about doing something
> with the srcu_read_lock() or srcu_down_read() return values (other than
> passing them to srcu_read_unlock() or srcu_up_read(), respectively),
> but such somethings are excluded by convention.
>
> So it would be nice for LKMM to complain about such abuse, but not
> at all mandatory.

I think at the very least it would be nice if the convention was written 
down somewhere.

>> My clarification request is whether that difference in the probable
>> operational model should be reflected in the axiomatic model (as I first
>> suspected based on the word "semaphore" being dropped a lot), or whether
>> it's just due to abuse (i.e., yes the axiomatic model and operational model
>> might be different here, but you're not allowed to look).
> For the moment, I am taking the door labeled "abuse".
>
> Maybe someday someone will come up with a valid use case, but they have
> to prove it first.  ;-)

Luckily, I currently don't have a stake in this :D
I currently don't think it's necessary to take a peek at cookies before 
deciding whether it should be used or not, since the decision can't 
depend on the value of the cookie anyways.

>
>> Which brings us to the next point:
>>
>>> Could you please review the remainder to see what remains given the
>>> usage restrictions that I called out above?
>> Perhaps we could say that reading an index without using it later is
>> forbidden?
>>
>> flag ~empty [Srcu-lock];data;rf;[~ domain(data;[Srcu-unlock])] as
>> thrown-srcu-cookie-on-floor
>>
>> So if there is an srcu_down() that produces a cookie that is read by some
>> read R, and R doesn't then pass that value into an srcu_up(), the
>> srcu-warranty is voided.
> I like the general idea, but I am dazed and confused by this "flag"
> statement.

Too bad, I was aiming for dazed and amazed. Ah well, I'll take what I 
can get.

> Ah, separate down/up tags could make this "flag" statement at least
> somewhat less dazing and confusing.

Let me use up/down names and also fix the statement a little bit in 
analogy to the other issue we had with the rf from the other subthread.

let  use-cookie = (data|[~(Srcu-up|Srcu-unlock)] ; rfe)* ; data

flag ~empty [Srcu-down] ; use-cookie; [~Srcu-up] ; rf ; [~ domain(use-cookie;[Srcu-up])] as thrown-srcu-cookie-on-floor

Here use-cookie is essentially just a name for the relation we used 
before to see where the cookie is being used in the end when defining 
how to match srcu events: it links (among other things) an srcu-down to 
every store that stores the cookie produced by that srcu-down,
and every read that reads such a cookie to the srcu_up() that uses the 
cookie returned by that read. (Because of how srcu's up() and down() are 
currently formalized, those two happen to be the same thing, but maybe 
it helps thinking of them as seperate for now).

Then the relation

[Srcu-down] ; use-cookie ; [~Srcu-up] ; rf ; [~ domain(use-cookie;[Srcu-up])]

links an event X to an event R exactly in the following case:

  X ->use-cookie W ->rf R
  and X \in Srcu-down, W \not\in Srcu-up, and R \not\in domain(use-cookie;[Srcu-up])

meaning X is an srcu_down(), and its cookie is stored by the write W, 
and R is a read that looks at the cookie (it reads from W), but(!) the 
cookie read by R is never used by any srcu_up().

More precisely, imagine that in contrast to what I just claimed, the 
cookie read by R would actually be used in some srcu_up() event U.
Then R would be linked by use-cookie to U; we would have
   R ->use-cookie U
   and U \in Srcu-up
which we could rewrite as
   R ->use-cookie;[Srcu-up] U

Now because R appears on the left-hand-side of the relation with some 
event (here U), R is in the domain(*) of this relation :
   R \in domain(use-cookie;[Srcu-up])
which is a contradiction.

In other words, the relation would be non-empty (= the flag is raised) 
exactly when there is a read R that reads a cookie produced by some 
srcu_down() event X, but the return value of that read is never used as 
input to srcu_up().
This seems to be exactly the "drop on the floor" metaphor you mentioned 
(and from my own experience I know it's bad to drop cookies on the floor).

does that make it more clear why it might be a reasonable formalization 
of that principle?
jonas

(*anyways I hope so, I always mix up domain and range, but I think 
domain is the left side and range the right side. I can also barely keep 
apart reft and light though, so...)


