Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 934D5671B7D
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 13:08:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbjARMI1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 07:08:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjARMHe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 07:07:34 -0500
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E72742BEF4
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 03:25:43 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.227])
        by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4Nxjsl19jfz9xFQv
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 19:17:47 +0800 (CST)
Received: from [10.48.132.179] (unknown [10.48.132.179])
        by APP1 (Coremail) with SMTP id LxC2BwAnrgkU18dj11eoAA--.1512S2;
        Wed, 18 Jan 2023 12:25:19 +0100 (CET)
Message-ID: <839e1765-7d47-73df-02f0-8122306b5fb3@huaweicloud.com>
Date:   Wed, 18 Jan 2023 12:25:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: Internal vs. external barriers (was: Re: Interesting LKMM litmus
 test)
To:     Alan Stern <stern@rowland.harvard.edu>
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
 <114ECED5-FED1-4361-94F7-8D9BC02449B7> <Y8cQ/94h7048nvQ6@rowland.harvard.edu>
From:   Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
In-Reply-To: <Y8cQ/94h7048nvQ6@rowland.harvard.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LxC2BwAnrgkU18dj11eoAA--.1512S2
X-Coremail-Antispam: 1UD129KBjvAXoW3CFW7ur15tryUWw1rtw4xJFb_yoW8Aw45Xo
        WfWw1S9w43Kr18GFWqy3WDJry5Aw1DGrn5Xw1UW343GF1qqryUCa48A3y8Xay3Xr40kF4U
        Ja48JryayF90qF93n29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
        AaLaJ3UjIYCTnIWjp_UUUYx7kC6x804xWl14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK
        8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4
        AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF
        7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I
        0E14v26r4j6r4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
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
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/17/2023 10:19 PM, Alan Stern wrote:
> On Tue, Jan 17, 2023 at 06:48:12PM +0100, Jonas Oberhauser wrote:
>> On 1/14/2023 5:42 PM, Alan Stern wrote:
>>>
>>> There is more to it than that, as I mentioned earlier. A complete
>>> description can be found the explanation.txt document; it says: For any
>>> critical section C and any grace period G, at least one of the following
>>> statements must hold: (1) C ends before G does, and in addition, every
>>> store that propagates to C's CPU before the end of C must propagate to
>>> every CPU before G ends. (2) G starts before C does, and in addition,
>>> every store that propagates to G's CPU before the start of G must
>>> propagate to every CPU before C starts.
>>>
>>> On Fri, Jan 13, 2023 at 02:55:34PM +0000, Jonas Oberhauser wrote:
>>>>> IMO it's generally better to think of grace periods as not being
>>>>> instantaneous but as occurring over a prolonged period of time.
>>>>> Thus we should say: If a grace period ends before an unlock
>>>>> occurs, it must start before the corresponding lock. And
>>>>> contrapositively, if a lock occurs before a grace period starts,
>>>>> the corresponding unlock must occur before the grace period
>>>>> ends.
>>>> I started thinking about it like this and comparing start/end times.
>>>> That made it more complicated, but the math came out the same in the
>>>> end. I could imagine that there are some scenarios where the
>>>> intuition of collapsing the grace period to a single event could
>>>> cause problems, but I haven't seen any.
>>>
>>>
>>> IIRC (and it has been a long time), this may be vaguely connected with
>>> the reason why the definitions of gp, rcu-link, and rcu-fence have po
>>> one side but po? on the other.  But I can't remember the details.
>>
>>
>> There's at least some connection. And I think from an operational model
>> perspective, the distinction has some effect.
>>
>> That's because part (1) of the rule you quoted forces propagation before G
> I prefer to say "requires" rather than "forces".  "Forces" sounds more
> like you're talking about a hardware mechanism that prevents something
> bad from happening, like the way the cache coherency rules are enforced.
>
>> ends, which allows propagation to G's CPU after the start or before the end.
> After the start or before the end of what?  G?

Sorry, I meant after the start *and* before the end of G.

>> Stores propagated in that time period are not forced to propagate by part
>> (2).
>>
>> If the two events in the operational model were merged, then all stores that
>> need to propagate to G's CPU through rule (1) would also need to propagate
>> to other CPU's through part (2).
> Again, I don't know why you say this.  In fact, all stores that need to
> propagate to G's CPU through rule (1) are also required by to propagate
> to other CPU's through rule (1) -- not rule (2).  And this has nothing
> to do with whether the end of G occurs at the same time as the start or
> some time afterward.
Yes, but the time periods are different. Rule (1) only requires 
propagation to all CPUs by the time G ends, rule (2) requires 
propagation to all CPUs by the time the second critical section starts, 
which may be much earlier.

>
>> In particular, if we had an execution with 3 CPUs like below (time from top
>> to bottom, also attached as a text file in case my e-mail client messes up
>> the formatting)
>>
>> CPU1             | CPU2           | CPU3
>> start CS;        |                |
>> read stage==0    |                |
>>                   | stage = 1;     |
>>                   |                |
>>                   | GP {           |
>> x = 1;           |                |
>>                   |                | start CS;
>>                   |                | read x == 0;
>> end CS;          |                |
>>                   | }              |
>>                   | stage = 2;     |
>>                   |                | read stage == 2;
>>                   |                | read x == 1;
>>                   |                | end CS;
>>
>> then we allow x=1 not to propagate to the third CPU before it reads x.
> I still can't understand what you're saying.  Since CPU3 reads x==1, of
> course we require x=1 to propagate to CPU3 before it reads x.

Note that it reads x twice, and the first time it reads 0.
I should have written "before it reads x for the first time" (= after 
the second read side critical section starts, but before G ends). The 
second read is after G ends, at which point by guarantee (1) the store 
has propagated to CPU3.



>
>> But
>> if there was only a single grace period step, which would not overlap with
>> either CS, then this outcome would be forbidden.
>> Because stage=1 didn't propagate to CPU1, the grace period would need to be
>> after CPU1's critical section.
>> Because stage=2 did propagate to CPU3, the grace period would need to be
>> before CPU3's critical section.
>> But then x=1 would need to propagate to CPU3 before the grace period, and
>> thus before its CS starts.
>>
>> I think it's because things can't happen "at the same time" in the
>> operational model.
> That's simply not true.  As an example, writes propagate to their own
> CPU at the same time as they execute.

I consider executing a store and it propagating to its own CPU as a 
single thing happening.
That's because it is considered so in the operational model.
However, a store propagating to a CPU and that CPU executing a grace 
period are likely two independent steps.
(You could formalize it differently, but it is highly non-standard).
It's imho more reasonable to split the grace period into start and end 
step, and then use the Grace Period Guarantee as written.

>>   Otherwise, x=1 could propagate "at the same time" as it
>> executes the grace period, and then wouldn't be affected by rule (2)
>> anymore.
>>
>> But in the axiomatic model, we can use the po; ... to state that things must
>> happen "strictly before" the start of G (instead of "kinda at the same
>> time"). If there is a po-earlier event that observes the propagation, then
>> the propagation happened before the start of G. If there is no po-earlier
>> event that observes the propagation, then the store may as well have
>> propagated at the same time as G (or "between the start and end"). So having
>> the distinction of start and end of grace periods becomes at least less
>> important.
>>
>> I still haven't wrapped my head fully around why the other side has to be
>> po?.
>>
>> I asked Hernan to run all the old litmus tests with rcu-fence = po ;
>> rcu-order ; po and he reported no difference in those tests either.
>>
>> Now I'm thinking if it can be proven that some of them aren't necessary, or
>> could be simplified.
> Maybe.  But why go to the trouble?

Because if one could simplify things, the model becomes more 
uniform/cohesive, easier to understand, and easier to reason about. (we 
can have a seperate discussion about whether the result is simpler :D).

>> Pretending for simplicity that rscs and grace periods aren't reads&writes
> They aren't.  You don't have to pretend.

rscs are reads& writes in herd. That's how the data dependency works in 
your patch, right?
I consider that a hack though and don't like it.

>> (and that prop must always start with overwrite&ext, but this can be done
>> wlog if we define the rcu relations with prop? instead of prop).
>>
>> I'm first looking at the rcu-link relation.
>> Any use of rcu-link in rcu-order is preceded by an rscs or gp. Considering
>> the cases where po? is not taken, the first edge of hb*;pb*;prop? can't be
>> any of prop, rfe, or prop&int because the rcu-order never ends in
>> write/reads. This leaves only ppo (or nothing), and we can use ppo <= po
>> (with the patch that's currently lying on my hard disk :D) to get that he
>> complete edge a subset of
>>
>> (po ; hb*;pb*;prop? | id);po
>>
>> Therefore I think we have rcu-link = (po ; hb*;pb*;prop? ; po) | po
> This does not seem like a simplification to me.

It's simpler to reason about because the number of combinations is 
roughly half (instead of multiplying each of hb*, pb*, prop? with the 
possibility of not having a po, it just adds one possibility to (po ; 
... ;po)). (I was also imprecise, it's not that `rcu-link = (po ; 
hb*;pb*;prop? ; po) | po`, but rather that it could be changed to that 
definition without changing the model).

>
>> Next, I look at rcu-fence in rb = prop? ; rcu-fence ; hb* ; pb*.
>> An rcu-fence ; hb* ; pb* which doesn't have the po at the end of rcu-fence
>> can not have prop, rfe, or prop&int after the rcu-fence either. This leaves
>> two cases, either the rb comes from prop? ; po ; rcu-order or from prop? ;
>> po ; rcu-order ; ppo ; hb* ; pb*.
>>
>> In the latter case we can use ppo <= po and get back  prop? ; po ; rcu-order
>> ; po ; hb* ; pb, so considering po? here is not necessary.
>>
>> In the former case, we can ask instead if po ; rcu-order ; prop? is
>> irreflexive, and since prop can't follow on rcu-order, this is the same as
>> po ; rcu-order.
>>
>> This can only have an identity edge if at least some of the rcu-links in
>> rcu-order are not just po. So let's look at the last such edge, when
>> abbreviating RCU cs and grace periods as R we get
>>
>>    po; (R ; rcu-link)* ; R ; po ; hb*;pb*;prop? ; (po ; R)+
>>
>> where overall the number of gps >= number of rscs, and this can be rewritten
>> as
>>
>>    prop? ; (po ; R)+; po; (rcu-order ; rcu-link)? ; R ; po ; hb*;pb*
>>
>> and I believe (po ; R)+; po; (R ; rcu-link)* ; R ; po  <= po ; rcu-order ;
>> po (using the fact that overall the number of gps is still >= the number of
>> rscs)
>>
>> so then it simplifies again to
>>
>>    prop? ; po ; rcu-order ; po ; hb*;pb*
>>
>> and po? is again not necessary.
>>
>> I'm again ignoring srcu here. I don't know if we can still shuffle the
>> gp/rscs around like above when the locations have to match.
> Indeed, before support for SRCU was added to the memory model, it did
> put the po and po? terms in other places.  I was forced to move them in
> order to add the tests for matching locations.
>
>> Either way if you can confirm my suspicion that the po? in rcu-fence could
>> be replaced by po, and that the po? in rcu-link could be replaced by (po ;
>> ... ; po) | po, or have a counter example and some additional explanation
>> for why the po? makes sense, I'd be thankful.
>>
>>
>>> There was also something about what should happen when you have two
>>> grace periods in a row.
>> Note that two grace periods in a row are a subset of po;rcu-gp;po and thus
>> gp, and so there's nothing to be done.
> That is not stated carefully, but it probably is wrong.  Consider this:
>
> 	P0                 P1                P2
> 	---------------    --------------    -----------------
> 	rcu_read_lock     Wy=1               rcu_read_lock
> 	Wx=1              synchronize_rcu    Wz=1
> 	Ry=0              synchronize_rcu    Rx=0
> 	rcu_read_unlock   Rz=0               rcu_read_unlock
>
> (W stands for Write and R for Read.)  This execution is forbidden by the
> counting rule: Its cycle has two grace periods and two critical
> sections.  But if we changed the definition of gp to be
>
> 	let gp = po ; [Sync-rcu | Sync-srcu] ; po
>
> then the memory model would allow the execution.  So having the po? at
> the end of gp is vital.

I hadn't thought yet about the effect of modifying the definition of gp, 
but I don't think this example relies on gp at all.
The model would forbid this even if rcu-fence and gp were both changed 
from po? to po.
 From Rz=0 we know
     second sync() ->rcu-gp;po Rz ->prop Wz ->po P2 unlock() ->rcu-rscsi 
P2 lock()
 From Ry=0 we know
   P1 unlock() ->rcu-rsci P1 lock() ->po Ry ->prop Wy ->po;rcu-gp first 
sync()

which are both rcu-order.
Then from Rx=0 we have
   Rx ->prop Wx ->po P1 unlock() ->rcu-order  first sync() ->po second 
sync() ->rcu-order P2 lock() ->po Rx
of course since po is one case of rcu-link, we get
   Rx ->prop Wx ->po P1 unlock() ->rcu-order P2 lock() ->po Rx
and hence
   Rx ->prop Wx ->rcu-fence Rx
which is supposed to be irreflexive (even with rcu-fence=po;rcu-order;po).

Note that if your ordering relies on actually using gp twice in a row, 
then these must come from strong-fence, but you should be able to just 
take the shortcut by merging them into a single gp.
   po;rcu-gp;po;rcu-gp;po <= gp <= strong-fence <= hb & strong-order


>
>> Something more interesting happens with critical sections, where currently
>> po ; rcu-rcsci ; po ; rcu-rcsci ; po should be a subset of po ; rcu-rcsci ;
>> po  because of the forbidden partial overlap. But I currently don't think
>> it's necessary to consider such cases.
>>
>> The other thing that causes complications is when all the pb*,hb*,and prop
>> links in rcu-link are just id, and then rcu-link becomes po?;po = po.
>> Currently I don't understand why such pure po links should be necessary at
>> all, since they should just merge with the neighboring rcu-gps into a gp
>> edge.
>>
>>>> The only way I'd count rcu-link' as adding a case is if you say that
>>>> the (...)* has two cases :D (or infinitely many :D) I don't count
>>>> the existence of the definition because you could always inline it
>>>> (but lose a lot of clarity imho).
>>>
>>>
>>> If you did inline it, you'd probably find that the end result was
>>> exactly what is currently in the LKMM.
>> Not quite. There are two differences. The first is that the
>> rcu-order;rcu-link;rcu-order case disappears.
>>
>> The second is that the ...;rcu-link;... and
>> ...;rcu-link;rcu-order;rcu-link;... subcases get merged, and not to
>> ...;rcu-link;(rcu-order;rcu-link)?;... but to
>> ...;rcu-link;(rcu-order;rcu-link)*;...
> Okay.
>
>> Indeed the definitions of rcu-extend and rcu-order can't become exactly the
>> same because they are different relations, e.g., rcu-order can begin and end
>> with a grace period but rcu-extend can't.
>>
>> That's why an additional non-recursive layer of
>>
>>     rcu-order = rcu-extend ; (rcu-link; rcu-extend)*
>>
>> is necessary to define rcu-order in terms of rcu-extend. But as I mentioned
>> I don't think rcu-order is necessary at all to define LKMM, and one can
>> probably just use rcu-extend instead of rcu-order (and in fact even a
>> version of rcu-extend without any lone rcu-gps).
> Sure, you could do that, but it wouldn't make sense.  Why would anyone
> want to define an RCU ordering relation that includes
>
> 	gp ... rscs ... gp ... rscs
>
> but not
>
> 	gp ... rscs ... rscs ... gp
>
> ?

Because the the RCU Grace Period Guarantee doesn't say "if a gp happens 
before a gp, with some rscs in between, ...".
So I think even the picture is not the best picture to draw for RCU 
ordering. I think the right picture to draw for RCU ordering is 
something like this:
     case (1): C ends before G does:

	rcsc ... ... ... ... ... gp

   case (2): G ends before C does:

	gp ... ... ... ... ... rscs

where the dots are some relation that means "happens before".


and then the natural formalization of the propagation requirement

	every store that propagates to (the CPU executing whatever of G resp. C happens first) before (G resp. C happens) propagates to every CPU before any instruction po-after (C resp. G, i.e., the other one) executes

is something like

	prop ; po ; (case (1) or case (2)) ; po  creates a kind of happens-before (rb)

which is absolutely the same as the formalization of the pb propagation requirement

	every store that propagates to a CPU beginning a strong ordering operation before that CPU begins the strong ordering operation propagates to every CPU before any instruction po-after the strong ordering operation executes

which is
	prop ; po ; (thing providing ordering); po  creates a kind of happens-before (pb)

I think this makes a lot more sense than to say "here's the grace period guarantee that talks about ordering gp with rscs, and here's the formalization that says the count of gp is >= than the number of rscs in some technical counting relation, but the relation between the two is too complicated to explain here".

The one remaining snag I currently see is that the current formalization of pb and rb doesn't allow using these ordering guarantees multiple times. I would prefer something like
	pb = prop ; strong-order
	acyclic (pb | hb) as propagation
	rb = prop ; new-rcu-order
	acyclic (rb | pb | hb) as rcu

And then if you do have a case like
	... gp ... rscs ... rscs ... gp ...

you would essentially get two rb edges.




>
>>>> the law is, well, um, "primarily empirical in nature"
>>>
>>>
>>> Actually it isn't, not any more. That quote was written before we
>>> formalized RCU in the LKMM.
>> I meant that the original formulation was empirical; of course you have
>> formalized it, but how do you know that the formalization is valid?
> We proved it in the ASPLOS paper.  That is, we proved that a particular
> implementation faithfully obeys the restrictions of the formalization.
>
>> I think
>> the correspondence with "what's intended" is always an empirical thing, even
>> if you formally prove the correctness of the imlementation against the
>> specification you might have missed some parts or added some parts that are
>> actually just implementation details.
> While I agree that it is difficult to be sure that an informal
> specification agrees with a formal model, I wouldn't describe attempts
> to ensure this as "empirical".

I think there's two parts, the formal proofs you do that are of course 
not empirical, and then the question if the theorem you have proven is 
the one you should be proving. And that's something that will become 
more or less clear as 1) you try to use the theorem you have proven to 
prove other theorems, and 2) as you change the implementation details 
and see whether the specification is stable under those changes or not. 
I consider that empirical since it's based on experience that comes 
after the fact, not something you can usually prove in advance.


Have fun,
jonas

