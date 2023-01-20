Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C79E56754AB
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 13:36:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbjATMgT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 07:36:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230287AbjATMgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 07:36:11 -0500
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95353BC89B
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 04:35:42 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.227])
        by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4NyzKT1dHXz9v7Zb
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 20:27:41 +0800 (CST)
Received: from [10.48.133.21] (unknown [10.48.133.21])
        by APP1 (Coremail) with SMTP id LxC2BwBHzwp0ispjOkGxAA--.5406S2;
        Fri, 20 Jan 2023 13:35:12 +0100 (CET)
Message-ID: <126e32b7-caa7-0a1e-4589-885aef7c5a39@huaweicloud.com>
Date:   Fri, 20 Jan 2023 13:34:57 +0100
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
References: <Y8gjUKoHxqR9+7Hx@rowland.harvard.edu>
 <3dabbcfb-858c-6aa0-6824-05b8cc8e9cdb@gmail.com>
 <20230118201918.GI2948950@paulmck-ThinkPad-P17-Gen-1>
 <a5637181-1675-7973-489c-e5d24cbd25c2@huaweicloud.com>
 <20230118211201.GL2948950@paulmck-ThinkPad-P17-Gen-1>
 <09f084d2-6128-7f83-b2a5-cbe236b1678d@huaweicloud.com>
 <20230119001147.GN2948950@paulmck-ThinkPad-P17-Gen-1>
 <0fae983b-2a7c-d44e-8881-53d5cc053f09@huaweicloud.com>
 <20230119184107.GT2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8mfWTX7V69pAwo8@rowland.harvard.edu>
 <20230120035521.GA319650@paulmck-ThinkPad-P17-Gen-1>
From:   Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
In-Reply-To: <20230120035521.GA319650@paulmck-ThinkPad-P17-Gen-1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: LxC2BwBHzwp0ispjOkGxAA--.5406S2
X-Coremail-Antispam: 1UD129KBjvJXoW3JFW3uw4ftFy8AF1kAr4xZwb_yoW3Gr1kpr
        ZrtFWft3yDtryIv3429r1UCFy8ta4rXFyUArn5JF1fZas2vrn8Kr13tr1FgFy5ur1akrs8
        XF1YqrZ7Gw1kJaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I just realized I made a mistake in my earlier response to this message; 
you still need the rf for passing the cookie across threads.
Perhaps it's better to just also exclude srcu_unlock type events 
explicitly here.

+let srcu-rscs = ([Srcu-lock] ; (data ; [~ Srcu-unlock] ; rf) + ; 
[Srcu-unlock]) & loc


best wishes,
jonas

On 1/20/2023 4:55 AM, Paul E. McKenney wrote:
> On Thu, Jan 19, 2023 at 02:51:53PM -0500, Alan Stern wrote:
>> On Thu, Jan 19, 2023 at 10:41:07AM -0800, Paul E. McKenney wrote:
>>> In contrast, this actually needs srcu_down_read() and srcu_up_read():
>>>
>>> ------------------------------------------------------------------------
>>>
>>> C C-srcu-nest-6
>>>
>>> (*
>>>   * Result: Never
>>>   *
>>>   * Flag unbalanced-srcu-locking
>>>   * This would be valid for srcu_down_read() and srcu_up_read().
>>>   *)
>>>
>>> {}
>>>
>>> P0(int *x, int *y, struct srcu_struct *s1, int *idx)
>>> {
>>> 	int r2;
>>> 	int r3;
>>>
>>> 	r3 = srcu_down_read(s1);
>>> 	WRITE_ONCE(*idx, r3);
>>> 	r2 = READ_ONCE(*y);
>>> }
>>>
>>> P1(int *x, int *y, struct srcu_struct *s1, int *idx)
>>> {
>>> 	int r1;
>>> 	int r3;
>>>
>>> 	r1 = READ_ONCE(*x);
>>> 	r3 = READ_ONCE(*idx);
>>> 	srcu_up_read(s1, r3);
>>> }
>>>
>>> P2(int *x, int *y, struct srcu_struct *s1)
>>> {
>>> 	WRITE_ONCE(*y, 1);
>>> 	synchronize_srcu(s1);
>>> 	WRITE_ONCE(*x, 1);
>>> }
>>>
>>> locations [0:r1]
>>> exists (1:r1=1 /\ 0:r2=0)
>> I modified this litmus test by adding a flag variable with an
>> smp_store_release in P0, an smp_load_acquire in P1, and a filter clause
>> to ensure that P1 reads the flag and idx from P1.
>>
>> With the patch below, the results were as expected:
>>
>> Test C-srcu-nest-6 Allowed
>> States 3
>> 0:r1=0; 0:r2=0; 1:r1=0;
>> 0:r1=0; 0:r2=1; 1:r1=0;
>> 0:r1=0; 0:r2=1; 1:r1=1;
>> No
>> Witnesses
>> Positive: 0 Negative: 3
>> Condition exists (1:r1=1 /\ 0:r2=0)
>> Observation C-srcu-nest-6 Never 0 3
>> Time C-srcu-nest-6 0.04
>> Hash=2b010cf3446879fb84752a6016ff88c5
>>
>> It turns out that the idea of removing rf edges from Srcu-unlock events
>> doesn't work well.  The missing edges mess up herd's calculation of the
>> fr relation and the coherence axiom.  So I've gone back to filtering
>> those edges out of carry-dep.
>>
>> Also, Boqun's suggestion for flagging ordinary accesses to SRCU
>> structures no longer works, because the lock and unlock operations now
>> _are_ normal accesses.  I removed that check too, but it shouldn't hurt
>> much because I don't expect to encounter litmus tests that try to read
>> or write srcu_structs directly.
>>
>> Alan
>>
>>
>>
>> Index: usb-devel/tools/memory-model/linux-kernel.bell
>> ===================================================================
>> --- usb-devel.orig/tools/memory-model/linux-kernel.bell
>> +++ usb-devel/tools/memory-model/linux-kernel.bell
>> @@ -53,38 +53,30 @@ let rcu-rscs = let rec
>>   	in matched
>>   
>>   (* Validate nesting *)
>> -flag ~empty Rcu-lock \ domain(rcu-rscs) as unbalanced-rcu-locking
>> -flag ~empty Rcu-unlock \ range(rcu-rscs) as unbalanced-rcu-locking
>> +flag ~empty Rcu-lock \ domain(rcu-rscs) as unbalanced-rcu-lock
>> +flag ~empty Rcu-unlock \ range(rcu-rscs) as unbalanced-rcu-unlock
>>   
>>   (* Compute matching pairs of nested Srcu-lock and Srcu-unlock *)
>> -let srcu-rscs = let rec
>> -	    unmatched-locks = Srcu-lock \ domain(matched)
>> -	and unmatched-unlocks = Srcu-unlock \ range(matched)
>> -	and unmatched = unmatched-locks | unmatched-unlocks
>> -	and unmatched-po = ([unmatched] ; po ; [unmatched]) & loc
>> -	and unmatched-locks-to-unlocks =
>> -		([unmatched-locks] ; po ; [unmatched-unlocks]) & loc
>> -	and matched = matched | (unmatched-locks-to-unlocks \
>> -		(unmatched-po ; unmatched-po))
>> -	in matched
>> +let srcu-rscs = ([Srcu-lock] ; (data | rf)+ ; [Srcu-unlock]) & loc
>>   
>>   (* Validate nesting *)
>> -flag ~empty Srcu-lock \ domain(srcu-rscs) as unbalanced-srcu-locking
>> -flag ~empty Srcu-unlock \ range(srcu-rscs) as unbalanced-srcu-locking
>> +flag ~empty Srcu-lock \ domain(srcu-rscs) as unbalanced-srcu-lock
>> +flag ~empty Srcu-unlock \ range(srcu-rscs) as unbalanced-srcu-unlock
>> +flag ~empty (srcu-rscs^-1 ; srcu-rscs) \ id as multiple-srcu-matches
>>   
>>   (* Check for use of synchronize_srcu() inside an RCU critical section *)
>>   flag ~empty rcu-rscs & (po ; [Sync-srcu] ; po) as invalid-sleep
>>   
>>   (* Validate SRCU dynamic match *)
>> -flag ~empty different-values(srcu-rscs) as srcu-bad-nesting
>> +flag ~empty different-values(srcu-rscs) as bad-srcu-value-match
>>   
>>   (* Compute marked and plain memory accesses *)
>>   let Marked = (~M) | IW | Once | Release | Acquire | domain(rmw) | range(rmw) |
>> -		LKR | LKW | UL | LF | RL | RU
>> + 		LKR | LKW | UL | LF | RL | RU | Srcu-lock | Srcu-unlock
>>   let Plain = M \ Marked
>>   
>>   (* Redefine dependencies to include those carried through plain accesses *)
>> -let carry-dep = (data ; rfi)*
>> +let carry-dep = (data ; [~ Srcu-unlock] ; rfi)*
>>   let addr = carry-dep ; addr
>>   let ctrl = carry-dep ; ctrl
>>   let data = carry-dep ; data
>> Index: usb-devel/tools/memory-model/linux-kernel.def
>> ===================================================================
>> --- usb-devel.orig/tools/memory-model/linux-kernel.def
>> +++ usb-devel/tools/memory-model/linux-kernel.def
>> @@ -49,8 +49,10 @@ synchronize_rcu() { __fence{sync-rcu}; }
>>   synchronize_rcu_expedited() { __fence{sync-rcu}; }
>>   
>>   // SRCU
>> -srcu_read_lock(X)  __srcu{srcu-lock}(X)
>> -srcu_read_unlock(X,Y) { __srcu{srcu-unlock}(X,Y); }
>> +srcu_read_lock(X) __load{srcu-lock}(*X)
>> +srcu_read_unlock(X,Y) { __store{srcu-unlock}(*X,Y); }
>> +srcu_down_read(X) __load{srcu-lock}(*X)
>> +srcu_up_read(X,Y) { __store{srcu-unlock}(*X,Y); }
>>   synchronize_srcu(X)  { __srcu{sync-srcu}(X); }
>>   synchronize_srcu_expedited(X)  { __srcu{sync-srcu}(X); }
> And for some initial tests:
>
> https://github.com/paulmckrcu/litmus/blob/master/manual/kernel/C-srcu-nest-1.litmus
>
> 	"Flag multiple-srcu-matches" but otherwise OK.
> 	As a "hail Mary" exercise, I used r4 for the second SRCU
> 	read-side critical section, but this had no effect.
> 	(This flag is expected and seen for #4 below.)
>
> https://github.com/paulmckrcu/litmus/blob/master/manual/kernel/C-srcu-nest-2.litmus
> https://github.com/paulmckrcu/litmus/blob/master/manual/kernel/C-srcu-nest-3.litmus
> https://github.com/paulmckrcu/litmus/blob/master/manual/kernel/C-srcu-nest-4.litmus
> https://github.com/paulmckrcu/litmus/blob/master/manual/kernel/C-srcu-nest-5.litmus
>
> 	All as expected.
>
> https://github.com/paulmckrcu/litmus/blob/master/manual/kernel/C-srcu-nest-6.litmus
>
> 	Get "Flag unbalanced-srcu-lock" and "Flag unbalanced-srcu-unlock",
> 	but this is srcu_down_read() and srcu_up_read(), where this should
> 	be OK.	Ah, but I need to do the release/acquire/filter trick.  Once
> 	I did that, it works as expected.
>
> https://github.com/paulmckrcu/litmus/blob/master/manual/kernel/C-srcu-nest-7.litmus
> https://github.com/paulmckrcu/litmus/blob/master/manual/kernel/C-srcu-nest-8.litmus
>
> 	Both as expected.
>
> Getting there!!!
>
> I also started a regression test, hopefully without pilot error.  :-/
>
> 							Thanx, Paul

