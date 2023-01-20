Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27E7C6750A5
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 10:20:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230147AbjATJUz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 04:20:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbjATJUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 04:20:51 -0500
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37D4E4218
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 01:20:49 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.228])
        by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4Nyv0f2rjMz9xqd2
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 17:12:50 +0800 (CST)
Received: from [10.48.133.21] (unknown [10.48.133.21])
        by APP1 (Coremail) with SMTP id LxC2BwB3_wrNXMpjAqewAA--.4975S2;
        Fri, 20 Jan 2023 10:20:24 +0100 (CET)
Message-ID: <acbbd099-07de-fba9-3d44-874bdfc47365@huaweicloud.com>
Date:   Fri, 20 Jan 2023 10:20:11 +0100
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
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LxC2BwB3_wrNXMpjAqewAA--.4975S2
X-Coremail-Antispam: 1UD129KBjvJXoW3JFW3uw4ftFy8AF1kAr4xZwb_yoWxCr1Dpr
        Z8tFWft3yDtr92qw129w1UAFy0qa4FqF1UJrn5JF1fZr9YvrnxKr13J3ZYgFy5Cr1akr4U
        Xr1Yqr97Gw1kJaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS
        07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
        02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_
        WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
        CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAF
        wI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa
        7IUbG2NtUUUUU==
X-CM-SenderInfo: 5mrqt2oorev25kdx2v3u6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



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

This is because srcu_lock/srcu_unlock are reads and writes, and so you 
get the accidental rf relation here I was talking about earlier.
In particular your first lock() is linked by  data ; rf ; data to the 
second unlock(), which therefore seems to have data coming in from two 
sources.

You would be better off moving the carry-dep/data definitions higher in 
the file,

-let carry-dep = (data ; rfi)*
+let carry-dep = (data ; [~ Srcu-unlock] ; rfi)*
  let addr = carry-dep ; addr
  let ctrl = carry-dep ; ctrl
  let data = carry-dep ; data

and then defining

+let srcu-rscs = ([Srcu-lock] ; data ; [Srcu-unlock]) & loc

Note here I'm just using the freshly redefined data, instead of the (data;rf)+


best wishes, jonas

