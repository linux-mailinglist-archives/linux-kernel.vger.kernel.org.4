Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 605D567B8C7
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 18:43:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235473AbjAYRnq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 12:43:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234924AbjAYRno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 12:43:44 -0500
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2E23B77C
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 09:43:41 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.228])
        by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4P29wN72V9z9v7c4
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 01:35:32 +0800 (CST)
Received: from [10.48.135.9] (unknown [10.48.135.9])
        by APP2 (Coremail) with SMTP id GxC2BwAX7GIjatFjBe3FAA--.34617S2;
        Wed, 25 Jan 2023 18:43:17 +0100 (CET)
Message-ID: <404dd9fd-f735-e844-e439-ea8594f98388@huaweicloud.com>
Date:   Wed, 25 Jan 2023 18:42:52 +0100
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
References: <20230124172647.GN2948950@paulmck-ThinkPad-P17-Gen-1>
 <2788294a-972e-acbc-84ce-25d2bb4d26d6@huaweicloud.com>
 <20230124221524.GV2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y9BdNVk2LQiUYABS@rowland.harvard.edu>
 <20230124225449.GY2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y9CL8LBz+/mbbD00@rowland.harvard.edu>
 <20230125022019.GB2948950@paulmck-ThinkPad-P17-Gen-1>
 <cedf3a39-12cd-1cb1-ad5a-7c10768cee40@huaweicloud.com>
 <20230125150520.GG2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y9FMEATzv3gcTUe2@rowland.harvard.edu>
 <20230125171832.GH2948950@paulmck-ThinkPad-P17-Gen-1>
From:   Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
In-Reply-To: <20230125171832.GH2948950@paulmck-ThinkPad-P17-Gen-1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: GxC2BwAX7GIjatFjBe3FAA--.34617S2
X-Coremail-Antispam: 1UD129KBjvJXoW3WF13Xw4fAFyUXry7WrWxWFg_yoW7uw4fpF
        W3tF47Kr1DJr10kr12yw17XF1rt34rJr45Wr1qqry8Arn0vF1xJr13Gr4ruFy5XrWxZr1j
        vr1UtasrJ34DAaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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



On 1/25/2023 6:18 PM, Paul E. McKenney wrote:
> On Wed, Jan 25, 2023 at 10:34:40AM -0500, Alan Stern wrote:
>> On Wed, Jan 25, 2023 at 07:05:20AM -0800, Paul E. McKenney wrote:
>>> On Wed, Jan 25, 2023 at 02:10:08PM +0100, Jonas Oberhauser wrote:
>>>>
>>>> On 1/25/2023 3:20 AM, Paul E. McKenney wrote:
>>>>> On Tue, Jan 24, 2023 at 08:54:56PM -0500, Alan Stern wrote:
>>>>>> On Tue, Jan 24, 2023 at 02:54:49PM -0800, Paul E. McKenney wrote:
>>>>>>> Within the Linux kernel, the rule for a given RCU "domain" is that if
>>>>>>> an event follows a grace period in pretty much any sense of the word,
>>>>>>> then that event sees the effects of all events in all read-side critical
>>>>>>> sections that began prior to the start of that grace period.
>>>>>>>
>>>>>>> Here the senses of the word "follow" include combinations of rf, fr,
>>>>>>> and co, combined with the various acyclic and irreflexive relations
>>>>>>> defined in LKMM.
>>>>>> The LKMM says pretty much the same thing.  In fact, it says the event
>>>>>> sees the effects of all events po-before the unlock of (not just inside)
>>>>>> any read-side critical section that began prior to the start of the
>>>>>> grace period.
>>>>>>
>>>>>>>> And are these anything the memory model needs to worry about?
>>>>>>> Given that several people, yourself included, are starting to use LKMM
>>>>>>> to analyze the Linux-kernel RCU implementations, maybe it does.
>>>>>>>
>>>>>>> Me, I am happy either way.
>>>>>> Judging from your description, I don't think we have anything to worry
>>>>>> about.
>>>>> Sounds good, and let's proceed on that assumption then.  We can always
>>>>> revisit later if need be.
>>>>>
>>>>> 							Thanx, Paul
>>>> FWIW, I currently don't see a need for either RCU nor "base" LKMM to have
>>>> this kind of guarantee.
>>> In the RCU case, it is because it is far easier to provide this guarantee,
>>> even though it is based on hardware and compilers rather than LKMM,
>>> than it would be to explain to some random person why the access that
>>> is intuitively clearly after the grace period can somehow come before it.
>>>
>>>> But I'm curious for why it doesn't exist in LKMM -- is it because of Alpha
>>>> or some other issues that make it hard to guarantee (like a compiler merging
>>>> two threads and optimizing or something?), or is it simply that it seemed
>>>> like a complicated guarantee with no discernible upside, or something else?
>>> Because to the best of my knowledge, no one has ever come up with a
>>> use for 2+2W and friends that isn't better handled by some much more
>>> straightforward pattern of accesses.  So we did not guarantee it in LKMM.
>>>
>>> Yes, you could argue that my "ease of explanation" paragraph above is
>>> a valid use case, but I am not sure that this is all that compelling of
>>> an argument.  ;-)
>> Are we all talking about the same thing?  There were two different
>> guarantees mentioned above:
>>
>> 	The RCU guarantee about writes in a read-side critical section
>> 	becoming visible to all CPUs before a later grace period ends;
>>
>> 	The guarantee about the 2+2W pattern and friends being
>> 	forbidden.
>>
>> The LKMM includes the first of these but not the second (for the reason
>> Paul stated).
> I am not sure whether or not we are talking about the same thing,
> but given this litmus test:
>
> ------------------------------------------------------------------------
>
> C C-srcu-observed-4
>
> (*
>   * Result: Sometimes
>   *
>   * The Linux-kernel implementation is suspected to forbid this.
>   *)
>
> {}
>
> P0(int *x, int *y, int *z, struct srcu_struct *s)
> {
> 	int r1;
>
> 	r1 = srcu_read_lock(s);
> 	WRITE_ONCE(*y, 2);
> 	WRITE_ONCE(*x, 1);
> 	srcu_read_unlock(s, r1);
> }
>
> P1(int *x, int *y, int *z, struct srcu_struct *s)
> {
> 	int r1;
>
> 	WRITE_ONCE(*y, 1);
> 	synchronize_srcu(s);
> 	WRITE_ONCE(*z, 2);
> }
>
> P2(int *x, int *y, int *z, struct srcu_struct *s)
> {
> 	WRITE_ONCE(*z, 1);
> 	smp_store_release(x, 2);
> }
>
> exists (x=1 /\ y=1 /\ z=1)
>
> ------------------------------------------------------------------------
>
> We get the following from herd7:
>
> ------------------------------------------------------------------------
>
> $ herd7 -conf linux-kernel.cfg C-srcu-observed-4.litmus
> Test C-srcu-observed-4 Allowed
> States 8
> x=1; y=1; z=1;
> x=1; y=1; z=2;
> x=1; y=2; z=1;
> x=1; y=2; z=2;
> x=2; y=1; z=1;
> x=2; y=1; z=2;
> x=2; y=2; z=1;
> x=2; y=2; z=2;
> Ok
> Witnesses
> Positive: 1 Negative: 7
> Condition exists (x=1 /\ y=1 /\ z=1)
> Observation C-srcu-observed-4 Sometimes 1 7
> Time C-srcu-observed-4 0.02
> Hash=8b6020369b73ac19070864a9db00bbf8
>
> ------------------------------------------------------------------------
>
> This does not seem to me to be consistent with your "The RCU guarantee
> about writes in a read-side critical section becoming visible to all
> CPUs before a later grace period ends".

I believe the issue is a different one, it's about the prop;prop at the 
end, not related to the grace period guarantee. The stores in the CS 
become visible, but the store release never propagates anywhere, since 
the co-later store from the CS already propagated everywhere.
I believe this is because A ->prop B ->prop C only says that there are 
writes WB and WC such that WB propagates to B's CPU before B executes, 
WC is co-after B, and WC propagates to C's CPU before C executes. (I 
think B is the release store here).

But it does not say anything about the propagation/execution order of B 
and WC, and I believe WC can propagate to every CPU (other than B's) 
before B, and B never propagates anywhere.

> Again, I am OK with LKMM allowing C-srcu-observed-4.litmus, as long as
> the actual Linux-kernel implementation forbids it.

Is it really that important that the implementation forbids it? Do you 
have a use case?

Best wishes, jonas

