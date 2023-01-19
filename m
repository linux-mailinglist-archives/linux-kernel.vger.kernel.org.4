Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE71A673A89
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 14:40:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230342AbjASNkO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 08:40:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231287AbjASNj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 08:39:59 -0500
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FAA77ED46
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 05:39:40 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.228])
        by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4NyNnp0RFrz9v7cC
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 21:31:42 +0800 (CST)
Received: from [10.81.219.171] (unknown [10.81.219.171])
        by APP1 (Coremail) with SMTP id LxC2BwDnbAj4R8ljBB2tAA--.3383S2;
        Thu, 19 Jan 2023 14:39:15 +0100 (CET)
Message-ID: <0fae983b-2a7c-d44e-8881-53d5cc053f09@huaweicloud.com>
Date:   Thu, 19 Jan 2023 14:39:01 +0100
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
References: <Y8bFMgDSUZymXUsS@rowland.harvard.edu>
 <20230117174308.GK2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8cBypKx4gM3wBJa@rowland.harvard.edu>
 <20230118035041.GQ2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8gjUKoHxqR9+7Hx@rowland.harvard.edu>
 <3dabbcfb-858c-6aa0-6824-05b8cc8e9cdb@gmail.com>
 <20230118201918.GI2948950@paulmck-ThinkPad-P17-Gen-1>
 <a5637181-1675-7973-489c-e5d24cbd25c2@huaweicloud.com>
 <20230118211201.GL2948950@paulmck-ThinkPad-P17-Gen-1>
 <09f084d2-6128-7f83-b2a5-cbe236b1678d@huaweicloud.com>
 <20230119001147.GN2948950@paulmck-ThinkPad-P17-Gen-1>
From:   Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
In-Reply-To: <20230119001147.GN2948950@paulmck-ThinkPad-P17-Gen-1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LxC2BwDnbAj4R8ljBB2tAA--.3383S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWrWkGFWDCr1kGFW3uFy5twb_yoWruFWrpr
        W8tr95tr97Ar4fuw13Zw1jqryrJw4fG3W3Jr95taykA398JrnaqryIqr4Y9as8Cw4fXr40
        vFZ8t3srua1jvF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/19/2023 1:11 AM, Paul E. McKenney wrote:
> On Wed, Jan 18, 2023 at 10:24:50PM +0100, Jonas Oberhauser wrote:
>> What I was thinking of is more something like this:
>>
>> P0{
>>     idx1 = srcu_down(&ss);
>>     srcu_up(&ss,idx1);
>> }
>>
>> P1{
>>      idx2 = srcu_down(&ss);
>>      srcu_up(&ss,idx2)
>> }
> And srcu_read_lock() and srcu_read_unlock() already do this.

I think I left out too much from my example.
And filling in the details led me down a bit of a rabbit hole of 
confusion for a while.
But here's what I ended up with:


P0{
     idx1 = srcu_down(&ss);
     store_rel(p1, true);


     shared cs

     R x == ?

     while (! load_acq(p2));
     R idx2 == idx1 // for some reason, we got lucky!
     srcu_up(&ss,idx1);
}

P1{
     idx2 = srcu_down(&ss);
     store_rel(p2, true);

     shared cs

     R y == 0

     while (! load_acq(p1));
     srcu_up(&ss,idx2);
}

P2 {
     W y = 1
     srcu_sync(&ss);
     W x = 1
}




Assuming that like indicated above both threads happen to read the same 
index, are you guaranteed that the shared cs lasts until both P0 and P1 
have performed their final up?
Is it allowed for P0 to read x==1?

If you define matching up&down as you do through the data link, then we 
get something like

P1's down ->po;prop;po  grace period
thus
P1's up  ->rcu-order  grace period
P0's down ->po;hb;po  P1's up ->rcu-order grace period
P0's up ->srcu-rscsi;rcu-link;rcu-order  grace-period
Unfortunately, this is not enough to rcu-order  P0's up with the grace 
period -- you'd need a second rcu-gp for that!

Looking at it from the other side, because x reads x=1, we have
grace period ->po;rfe;po P0's up
and thus
grace period ->rcu-order P0's down ->po;hb;po P1's up
but again this would order the grace period with P1's up because you'd 
need a second grace period.

When sketching it out on paper, I couldn't find any forbidden cycles, 
and so x==1 would be allowed. (But as I side, I managed to confuse 
myself a few times with this, so if you find a forbidden cycle let me know).

But note that the synchronization in there and the fact that both have 
the same index ensures that the two grace periods overlap, in a 
hypothetical order it would be
   down() -> down() -> up() -> up()
(with any premutation of P0 and P1 over these events so that they each 
get 1 up() and 1 down()) and thus the grace period must actually end 
after both, or start before both.

With the definition I offered, you would get
P0's up() ->srcu-rscsi  P1's down()
and
P1's up() ->srcu-rscsi P0's down()
and in particular

Rx1 ->po P0's up() ->srcu-rscsi  P1's down() ->po Ry0 ->prop Wy1 ->po 
srcu-gp on the same loc ->po Wx1 ->rfe Rx1
which can be collapsed to
Rx1 ->po;rcu-order;po;hb Rx1 which isn't irreflexive

Thus x==1 would be forbidden.

This is more semaphore-like, where the same cookie shared between 
threads implies that it's the same semaphore, and the overlapping 
guarantee (through synchronizing on p1,p2 in the beginning) means that 
the critical sections overlap.

In contrast, I wouldn't suggest the same for srcu_lock and srcu_unlock, 
where even though you may get the same cookie by accident, those might 
still be two completely independent critical sections.
For example, you could imagine a single percpu counter _cnt (per index 
of course) that is incremented and decremented for lock() and unlock(), 
and the condition to pass an srcu_sync() of a given index is that the 
cpu[...]._cnt[idx] are all individually 0 and the sum of all ups[idx] is 
equal to the sum of all downs[idx].

If you create an operational model of up() and down() in terms of such a 
per-index semaphore, I think the x==1 case would similarly need to be 
forbidden. Since the grace period must end after P1's grace period, and 
P0's and P1's grace period overlap and use the same semaphore, the count 
is never 0 at any point in time either P0 or P1 are in the grace period, 
and so the grace period must also end after P0's grace period. But then 
x=1 can't yet have propagated to P0 when it reads x inside its grace period.

In contrast, if the operational model of lock() and unlock() is a 
per-index and per-cpu count, then the x==1 case would be allowed, e.g., 
as follows (time from left to right, all processes happen in parallel):
P0:                      < Rx1         >
P1: <    Ry0               >
P2:           y=1  < P0!     P1! > x=1

here < and > mark the start and end of cs and gp, and Pn! is the time 
the gp realizes that Pn was not in a cs.

Best wishes,

jonas

