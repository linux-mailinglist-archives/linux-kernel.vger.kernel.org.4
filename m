Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49D2F67E677
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 14:20:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234800AbjA0NUb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 08:20:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234786AbjA0NUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 08:20:16 -0500
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F34A484197
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 05:19:31 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.228])
        by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4P3HyV2H1vz9v7H9
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 21:11:14 +0800 (CST)
Received: from [10.81.218.251] (unknown [10.81.218.251])
        by APP2 (Coremail) with SMTP id GxC2BwAX510zz9NjSPnNAA--.19909S2;
        Fri, 27 Jan 2023 14:18:54 +0100 (CET)
Message-ID: <c9c511d1-318b-8551-e5d7-be9fa5e09008@huaweicloud.com>
Date:   Fri, 27 Jan 2023 14:18:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 1/2] tools/memory-model: Unify UNLOCK+LOCK pairings to
 po-unlock-lock-po
To:     paulmck@kernel.org, Alan Stern <stern@rowland.harvard.edu>
Cc:     parri.andrea@gmail.com, will@kernel.org, peterz@infradead.org,
        boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com,
        j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com,
        dlustig@nvidia.com, joel@joelfernandes.org, urezki@gmail.com,
        quic_neeraju@quicinc.com, frederic@kernel.org,
        linux-kernel@vger.kernel.org
References: <20230126134604.2160-1-jonas.oberhauser@huaweicloud.com>
 <20230126134604.2160-2-jonas.oberhauser@huaweicloud.com>
 <Y9KsI/PsW4DK083z@rowland.harvard.edu>
 <20230126200828.GK2948950@paulmck-ThinkPad-P17-Gen-1>
 <20230126232148.GA855268@paulmck-ThinkPad-P17-Gen-1>
From:   Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
In-Reply-To: <20230126232148.GA855268@paulmck-ThinkPad-P17-Gen-1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: GxC2BwAX510zz9NjSPnNAA--.19909S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWw17Zw43CrWrtFykZry7Wrg_yoWrZw43pr
        WDKa1UKw4DJrykWw1qgwn0qrWIyw43Gr15Xr1DX3Z5Cas0q3WfCF1UtrWj9FykWrn3WFWD
        tFyjvasxur15AaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS
        07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
        02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_
        WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
        CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAF
        wI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa
        7IU13rcDUUUUU==
X-CM-SenderInfo: 5mrqt2oorev25kdx2v3u6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/27/2023 12:21 AM, Paul E. McKenney wrote:
> On Thu, Jan 26, 2023 at 12:08:28PM -0800, Paul E. McKenney wrote:
>> On Thu, Jan 26, 2023 at 11:36:51AM -0500, Alan Stern wrote:
>>> On Thu, Jan 26, 2023 at 02:46:03PM +0100, Jonas Oberhauser wrote:
>>>> LKMM uses two relations for talking about UNLOCK+LOCK pairings:
>>>>
>>>> 	1) po-unlock-lock-po, which handles UNLOCK+LOCK pairings
>>>> 	   on the same CPU or immediate lock handovers on the same
>>>> 	   lock variable
>>>>
>>>> 	2) po;[UL];(co|po);[LKW];po, which handles UNLOCK+LOCK pairs
>>>> 	   literally as described in rcupdate.h#L1002, i.e., even
>>>> 	   after a sequence of handovers on the same lock variable.
>>>>
>>>> The latter relation is used only once, to provide the guarantee
>>>> defined in rcupdate.h#L1002 by smp_mb__after_unlock_lock(), which
>>>> makes any UNLOCK+LOCK pair followed by the fence behave like a full
>>>> barrier.
>>>>
>>>> This patch drops this use in favor of using po-unlock-lock-po
>>>> everywhere, which unifies the way the model talks about UNLOCK+LOCK
>>>> pairings.  At first glance this seems to weaken the guarantee given
>>>> by LKMM: When considering a long sequence of lock handovers
>>>> such as below, where P0 hands the lock to P1, which hands it to P2,
>>>> which finally executes such an after_unlock_lock fence, the mb
>>>> relation currently links any stores in the critical section of P0
>>>> to instructions P2 executes after its fence, but not so after the
>>>> patch.
>>>>
>>>> P0(int *x, int *y, spinlock_t *mylock)
>>>> {
>>>>          spin_lock(mylock);
>>>>          WRITE_ONCE(*x, 2);
>>>>          spin_unlock(mylock);
>>>>          WRITE_ONCE(*y, 1);
>>>> }
>>>>
>>>> P1(int *y, int *z, spinlock_t *mylock)
>>>> {
>>>>          int r0 = READ_ONCE(*y); // reads 1
>>>>          spin_lock(mylock);
>>>>          spin_unlock(mylock);
>>>>          WRITE_ONCE(*z,1);
>>>> }
>>>>
>>>> P2(int *z, int *d, spinlock_t *mylock)
>>>> {
>>>>          int r1 = READ_ONCE(*z); // reads 1
>>>>          spin_lock(mylock);
>>>>          spin_unlock(mylock);
>>>>          smp_mb__after_unlock_lock();
>>>>          WRITE_ONCE(*d,1);
>>>> }
>>>>
>>>> P3(int *x, int *d)
>>>> {
>>>>          WRITE_ONCE(*d,2);
>>>>          smp_mb();
>>>>          WRITE_ONCE(*x,1);
>>>> }
>>>>
>>>> exists (1:r0=1 /\ 2:r1=1 /\ x=2 /\ d=2)
>>>>
>>>> Nevertheless, the ordering guarantee given in rcupdate.h is actually
>>>> not weakened.  This is because the unlock operations along the
>>>> sequence of handovers are A-cumulative fences.  They ensure that any
>>>> stores that propagate to the CPU performing the first unlock
>>>> operation in the sequence must also propagate to every CPU that
>>>> performs a subsequent lock operation in the sequence.  Therefore any
>>>> such stores will also be ordered correctly by the fence even if only
>>>> the final handover is considered a full barrier.
>>>>
>>>> Indeed this patch does not affect the behaviors allowed by LKMM at
>>>> all.  The mb relation is used to define ordering through:
>>>> 1) mb/.../ppo/hb, where the ordering is subsumed by hb+ where the
>>>>     lock-release, rfe, and unlock-acquire orderings each provide hb
>>>> 2) mb/strong-fence/cumul-fence/prop, where the rfe and A-cumulative
>>>>     lock-release orderings simply add more fine-grained cumul-fence
>>>>     edges to substitute a single strong-fence edge provided by a long
>>>>     lock handover sequence
>>>> 3) mb/strong-fence/pb and various similar uses in the definition of
>>>>     data races, where as discussed above any long handover sequence
>>>>     can be turned into a sequence of cumul-fence edges that provide
>>>>     the same ordering.
>>>>
>>>> Signed-off-by: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
>>>> ---
>>> Reviewed-by: Alan Stern <stern@rowland.harvard.edu>
>> A quick spot check showed no change in performance, so thank you both!
>>
>> Queued for review and further testing.
> And testing on https://github.com/paulmckrcu/litmus for litmus tests up
> to ten processes and allowing 10 minutes per litmus test got this:
>
> Exact output matches: 5208
> !!! Timed out: 38
> !!! Unknown primitive: 7
>
> This test compared output with and without your patch.
>
> For the tests with a Results clause, these failed:

Gave me a heart attack there for a second!

> Also, I am going to be pushing the scripts I use to mainline.  They might
> not be perfect, but they will be quite useful for this sort of change
> to the memory model.

I could also provide Coq proofs, although those are ignoring the 
srcu/data race parts at the moment.

Have fun, jonas

