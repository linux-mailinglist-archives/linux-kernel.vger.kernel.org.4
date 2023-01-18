Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 603FA6729F0
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 22:06:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230305AbjARVGd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 16:06:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbjARVGa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 16:06:30 -0500
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 742F9552B7
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 13:06:29 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.227])
        by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4Nxylr43Wkz9v7Gd
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 04:58:32 +0800 (CST)
Received: from [10.48.135.81] (unknown [10.48.135.81])
        by APP1 (Coremail) with SMTP id LxC2BwB3+wYxX8hjEyaqAA--.1556S2;
        Wed, 18 Jan 2023 22:06:05 +0100 (CET)
Message-ID: <3fcb533b-de5a-6583-3b41-61f2c7c91dbf@huaweicloud.com>
Date:   Wed, 18 Jan 2023 22:05:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: Internal vs. external barriers (was: Re: Interesting LKMM litmus
 test)
To:     Alan Stern <stern@rowland.harvard.edu>,
        "Paul E. McKenney" <paulmck@kernel.org>
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
References: <Y8WjmTFnqbAnS1Pz@rowland.harvard.edu>
 <20230116221357.GA2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8aKlNY4Z0z2Yqs0@andrea>
 <20230117151416.GI2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8bFMgDSUZymXUsS@rowland.harvard.edu>
 <20230117174308.GK2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8cBypKx4gM3wBJa@rowland.harvard.edu>
 <20230118035041.GQ2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8gjUKoHxqR9+7Hx@rowland.harvard.edu>
 <20230118200601.GH2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8hclxuhpGm+krkz@rowland.harvard.edu>
From:   Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
In-Reply-To: <Y8hclxuhpGm+krkz@rowland.harvard.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LxC2BwB3+wYxX8hjEyaqAA--.1556S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXF1rtry3JFy8JrW5Zw1rCrg_yoWrXw4Dpr
        WFqF90k3s7Xw1Sqrn2k3y7Xry8Aw1rJay5Jr4DG3yxA3s5X3s2gryIq3W2gFnxuwsaqry2
        qF40qwn8C3y5ZaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS
        07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
        02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_
        WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
        CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE
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



On 1/18/2023 9:54 PM, Alan Stern wrote:
> On Wed, Jan 18, 2023 at 12:06:01PM -0800, Paul E. McKenney wrote:
>> On Wed, Jan 18, 2023 at 11:50:24AM -0500, Alan Stern wrote:
>> Boqun mentioned off-list this morning that this is still the case,
>> and that each execution of srcu_read_lock() will return a unique value.
>> Assuming that I understood him correctly, anyway.
> That will no longer be true with the patch I posted yesterday.  Every
> execution of srcu_read_lock() will return 0 (or whatever the initial
> value of the lock variable is).
>
> But with a small change to the .def file, each execution of
> srcu_read_unlock() can be made to increment the lock's value, and then
> the next srcu_read_lock() would naturally return the new value.

That's one of the reasons I'd prefer to see some way to define arbitrary 
events and constrain their values axiomatically in cat/bell, rather than 
having to rely on loads and stores.

>
>>>> given that I have no idea how one would go about modeling down_read()
>>>> and up_read() in LKMM.
>>> It might make sense to work on that first, before trying to do
>>> srcu_down_read() and srcu_up_read().
>> The thing is that it is easy to associate an srcu_down_read() with the
>> corresponding srcu_up_read().  With down() and up(), although in the
>> Linux kernel this might be represented by a data structure tracking
>> (say) an I/O request, LKMM is going to be hard pressed to figure that out.
> It would help (or at least, it would help _me_) if you gave a short
> explanation of how srcu_down_read() and srcu_up_read() are meant to
> work.  With regular r/w semaphores, the initial lock value is 0, each
> down() operation decrements the value, each up() operation increments
> the value -- or vice versa if you don't like negative values -- and a
> write_lock() will wait until the value is >= 0.  In that setting, it
> makes sense to say that a down() which changes the value from n to n-1
> matches the next up() which changes the value from n-1 to n.
>
> I presume that srcu semaphores do not work this way.  Particularly since
> the down() operation returns a value which must be passed to the
> corresponding up() operation.  So how _do_ they work?

Coming from the lense of how it probably works (that you get an index 
computed from the number of completed rcu_sync(), and down() on a 
semaphore in an array indexed by that index, where any concurrent 
rcu_sync waits until the semaphore is 0 again), I suspect that each 
value defines its own semaphore.
That's why I proposed

let balanced-srcu-updown = let rec
         unmatched-locks = Srcu-down \ domain(matched)
     and unmatched-unlocks = Srcu-up \ range(matched)
     and unmatched = unmatched-locks | unmatched-unlocks
     and unmatched-co = [unmatched] ; co & same-value ; [unmatched]
     and unmatched-locks-to-unlocks =
         [unmatched-locks] ;  co & same-value ; [unmatched-unlocks]
     and matched = matched | (unmatched-locks-to-unlocks \
         (unmatched-co ; unmatched-co))
     in matched
let match-down-up = (co & same-value)^-1?; balanced-srcu-updown ; (co &
same-value)^-1?

Which would match every down on the same value with every up that 
happens between two times that the value of the semaphore is 0, without 
having to keep track of the actual value of the semaphore.

Since the semaphore starts from zero, it's really just a matter of 
having balanced down() and up(), and if you are enclosed between 
balanced down() and up(), you are in a critical section.

Then any GP that ends after any down() must also end after all "later" 
up() on the same semaphore (same srcu_struct, same idx) until the value 
reaches zero again. (Here "later" is encoded through co. Might be you 
want fr instead.)
And any GP that starts before any up() must also start before all 
"earlier" down() on the same semaphore.

This is the sense of matching I'm trying to encode above.
Let me know if my understanding of down() and up() is wrong.

have fun, jonas


