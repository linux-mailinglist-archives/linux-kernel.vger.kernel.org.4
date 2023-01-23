Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4BC0678128
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 17:17:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232970AbjAWQRO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 11:17:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231899AbjAWQRM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 11:17:12 -0500
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 781E12685C
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 08:17:08 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.229])
        by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4P0w5c61Ksz9xFg9
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 00:09:08 +0800 (CST)
Received: from [10.81.216.232] (unknown [10.81.216.232])
        by APP1 (Coremail) with SMTP id LxC2BwD3fAjfss5jpO6+AA--.11887S2;
        Mon, 23 Jan 2023 17:16:43 +0100 (CET)
Message-ID: <2cde689d-69b1-b719-1739-e1657d8de044@huaweicloud.com>
Date:   Mon, 23 Jan 2023 17:16:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: Internal vs. external barriers (was: Re: Interesting LKMM litmus
 test)
To:     Alan Stern <stern@rowland.harvard.edu>,
        Jonas Oberhauser <jonas.oberhauser@huawei.com>
Cc:     "paulmck@kernel.org" <paulmck@kernel.org>,
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
 <114ECED5-FED1-4361-94F7-8D9BC02449B7> <Y8lynRI35cFeuqb5@rowland.harvard.edu>
From:   Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
In-Reply-To: <Y8lynRI35cFeuqb5@rowland.harvard.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LxC2BwD3fAjfss5jpO6+AA--.11887S2
X-Coremail-Antispam: 1UD129KBjvJXoW3GFy7Cw1Duw1rWFWUurWkXrb_yoWxJFyxpF
        48KasIkFWkJFykuw1Fyw1xWa47Z348Jay8KF1rJFyUJa1Yqr1F9F4jgr1Y9as5Cr4fJr1j
        vr4kXr1ku3Z8ZFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
        e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
        Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a
        6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
        kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE
        14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf
        9x07UZ18PUUUUU=
X-CM-SenderInfo: 5mrqt2oorev25kdx2v3u6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/19/2023 5:41 PM, Alan Stern wrote:
> On Thu, Jan 19, 2023 at 12:22:50PM +0100, Jonas Oberhauser wrote:
>> I mean that if you have a cycle that is formed by having two adjacent actual
>> `gp` edges, like .... ; gp;gp ; ....  with gp= po ; rcu-gp ; po?,
>> (not like your example, where the cycle uses two *rcu*-gp but no gp edges)
> Don't forget that I had in mind a version of the model where rcu-gp did
> not exist.
>
>> and assume we define gp' = po ; rcu-gp ; po and hb' and pb' to use gp'
>> instead of gp,
>> then there are two cases for how that cycle came to be, either 1) as
>>   ... ; hb;hb ; ....
>> but then you can refactor as
>>   ... ; po;rcu-gp;po;rcu-gp;po ; ...
>>   ... ; po;rcu-gp;     po      ; ...
>>   ... ;         gp'            ; ...
>>   ... ;         hb'            ; ...
>> which again creates a cycle, or 2) as
>>    ... ; pb ; hb ; ...
>> coming from
>>    ... ; prop ; gp ; gp ; ....
>> which you can similarly refactor as
>>    ... ; prop ; po;rcu-gp;po ; ....
>>    ... ; prop ;      gp'     ; ....
>> and again get a cycle with
>> ... ; pb' ; ....
>> Therefore, gp = po;rcu-gp;po should be equivalent.
> The point is that in P1, we have Write ->(gp;gp) Read, but we do not
> have Write ->(gp';gp') Read.  Only Write ->gp' Read.  So if you're using
> gp' instead of gp, you'll analyze the litmus test as if it had only one
> grace period but two critical sections, getting a wrong answer.

Are you writing about the old model? Otherwise I don't see how this can 
give a wrong answer.
gp' isn't used to count the grace periods (anymore?). the po<=rcu-link 
allows using both grace periods to create rcu-order between the two read 
side critical sections.
For the old model I believe it.

>
>
> Here's a totally different way of thinking about these things, which may
> prove enlightening.  These thoughts originally occurred to me years ago,
> and I had forgotten about them until last night.
>
> If G is a grace period, let's write t1(G) for the time when G starts and
> t2(G) for the time when G ends.
>
> Likewise, if C is a read-side critical section, let's write t2(C) for
> the time when C starts (or the lock executes if you prefer) and t1(C)
> for the time when C ends (or the unlock executes).  This terminology
> reflects the "backward" role that critical sections play in the memory
> model.
>
> Now we can can characterize rcu-order and rcu-link in operational terms.
> Let A and B each be either a grace period or a read-side critical
> section.  Then:
>
> 	A ->rcu-order B  means  t1(A) < t2(B), and
>
> 	A ->rcu-link B   means  t2(A) <= t1(B).


That's a really elegant notation! I have thought about rcu-link and 
rcu-order as ordering ends or starts depending on which events are being 
ordered, but it quickly got out of hand because of all the different 
cases. With this notation it becomes quite trivial.


> (Of course, we always have t1(X) < t2(X) for any grace period or
> critical section X.)
>
> This explains quite a lot.  For example, we can justify including
>
> 	C ->rcu-link G
>
> into rcu-order as follows.  From C ->rcu-link G we get that t2(C) <=
> t1(G), in other words, C starts when or before G starts.  Then the
> Fundamental Law of RCU says that C must end before G ends, since
> otherwise C would span all of G.  Thus t1(C) < t2(G), which is C
> ->rcu-order G.
>
> The case of G ->rcu-link C is similar.
>
> This also explains why rcu-link can be extended by appending (rcu-order
> ; rcu-link)*.

Indeed, by similar (but more clumsy) reasoning I observed that rcu-order 
can be thought of as "extending" rcu-link.

>    From X ->rcu-order Y ->rcu-link Z we get that t1(X) <
> t2(Y) <= t1(Z) and thus t1(X) <= t1(Z).  So if
>
> 	A ->rcu-link B ->(rcu-order ; rcu-link)* C
>
> then t2(A) <= t1(B) <= t1(C), which justifies A ->rcu-link C.
>
> The same sort of argument shows that rcu-order should be extendable by
> appending (rcu-link ; rcu-order)* -- but not (rcu-order ; rcu-link)*.
>
> This also justifies why a lone gp belongs in rcu-order: G ->rcu-order G
> holds because t1(G) < t2(G).  But for critical sections we have t2(C) <
> t1(C) and so C ->rcu-order C does not hold.
I don't think that it justifies why it belongs there. It justifies that 
it could be included.
Neither rcu-order nor rcu-link exactly capture the temporal ordering, 
they just imply it.
For example, if you have L1 U1 and L2 U2 forming two read side critical 
sections C1 and C2, and
     U1 ->(hb|pb)+ L2
then I would say you would have
     t1(C1) < t2(C2)
but no rcu-order relation between any of the four events.

And for rcu-link this is even more obvious, because 
(rcu-order;rcu-link)* does not currently actually extend rcu-link (but 
it could based on the above reasoning).

In fact it seems we shouldn't even define a relation that is precisely 
ordering t1(A) < t2(B) because that should be a total order on all grace 
periods. As far as "observable" t1(A) < t2(B) is concerned, gp belongs 
in that definition but I think it already is there through hb and/or pb.

> Assuming ordinary memory accesses occur in a single instant, you see why
> it makes sense to consider (po ; rcu-order ; po) an ordering.

Do you mean "execute" in a single instant?

> But when you're comparing grace periods or critical sections to each other,
> things get a little ambiguous.  Should G1 be considered to come before
> G2 when t1(G1) < t1(G2), when t2(G1) < t2(G2), or when t2(G1) < t1(G2)?
> Springing for (po ; rcu-order ; po?) amounts to choosing the second
> alternative.

Aha, I see! Powerful notation indeed.
Keeping that in mind, wouldn't it make sense for pb also be changed to 
`...;po?` ?
Mathematically it ends up making no difference (so far), because any 
cycle of
   ... ;(pb';po?); (rb | (pb';po?) | hb);...
(where pb' is pb but where things have been redefined so that the final 
po is dropped)
can be trivially turned into a (pb | hb | rb) cycle except if it is
    ... ; pb' ; rcu-order ; po ; ...
But in this case we can use pb' <= prop ; po
    ... ; prop ; po ; rcu-order ; po ; ...
which is
    ... ; rb ; ...
and thus we get again a (pb | hb | rb) cycle.

But it would be more uniform and lets us define
   xyz-order = po ; ... ; po?
   pb = prop ; ...-order
   rb = prop ; ...-order

Thanks for the insights,
jonas

