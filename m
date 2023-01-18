Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C363672A66
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 22:25:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231174AbjARVZy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 16:25:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231162AbjARVZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 16:25:47 -0500
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4802264D9D
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 13:25:29 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.229])
        by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4Nxz9n1rdvz9v7P2
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 05:17:33 +0800 (CST)
Received: from [10.48.135.81] (unknown [10.48.135.81])
        by APP1 (Coremail) with SMTP id LxC2BwAXnQimY8hjUTSqAA--.1731S2;
        Wed, 18 Jan 2023 22:25:05 +0100 (CET)
Message-ID: <09f084d2-6128-7f83-b2a5-cbe236b1678d@huaweicloud.com>
Date:   Wed, 18 Jan 2023 22:24:50 +0100
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
References: <Y8aKlNY4Z0z2Yqs0@andrea>
 <20230117151416.GI2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8bFMgDSUZymXUsS@rowland.harvard.edu>
 <20230117174308.GK2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8cBypKx4gM3wBJa@rowland.harvard.edu>
 <20230118035041.GQ2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8gjUKoHxqR9+7Hx@rowland.harvard.edu>
 <3dabbcfb-858c-6aa0-6824-05b8cc8e9cdb@gmail.com>
 <20230118201918.GI2948950@paulmck-ThinkPad-P17-Gen-1>
 <a5637181-1675-7973-489c-e5d24cbd25c2@huaweicloud.com>
 <20230118211201.GL2948950@paulmck-ThinkPad-P17-Gen-1>
From:   Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
In-Reply-To: <20230118211201.GL2948950@paulmck-ThinkPad-P17-Gen-1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LxC2BwAXnQimY8hjUTSqAA--.1731S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ZF4kGF1DKrWfKF1kAw13Jwb_yoW8ZF4xpr
        WUKryIkr1DJr1Ik342v3Wjqry8uwn5WFW3JrWkJrZ5Z3s8XFnF9FySgF1Y9F9xWw4xZrWj
        qF4Sqw1kAa48XaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
        67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyT
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



On 1/18/2023 10:12 PM, Paul E. McKenney wrote:

> The only difference between srcu_read_lock() and srcu_read_unlock()
> on the one hand and srcu_down_read() and srcu_up_read() on the other
> is that a matching pair of srcu_read_lock() and srcu_read_unlock()
> must be running on the same task.  In contrast, srcu_down_read() and
> srcu_up_read() are not subject to this constraint.
>
>> What I was suggesting below is how to redefine "match" between read_down and
>> read_up that work more like a cross-thread semaphore.
> Understood, but what I don't understand is why not simply this:
>
> let srcu-rscs-down = ([Srcu-down] ; (data | rf)* ; [Srcu-up]) & loc

Oh, I had thought that it should be more like a semaphore rather than 
just a cross-cpu mutex.

Here's an example of how what you are describing would be used:

P0{
    idx = srcu_down(&ss);
    store_release(done,1);
}

P1{
     while (! load_acquire(done));
     srcu_up(&ss,idx)
}

What I was thinking of is more something like this:

P0{
    idx1 = srcu_down(&ss);
    srcu_up(&ss,idx1);
}

P1{
     idx2 = srcu_down(&ss);
     srcu_up(&ss,idx2)
}

where the big difference to srcu_lock/unlock would be that if P0 and P1 
happened to get the same index -- which you could very well check or 
synchronize on -- that you would be guaranteed that the grace period 
only ends once *all* threads that are using this index have called up. 
(note that I believe that your implementation has this property, and 
some users may come to rely on it if they find out!)

If you want this latter kind of guarantee, then you need to do so 
something along the lines of what Alan or I wrote.

If all you need is the ability to use the first scenario, without any 
guarantee that if the index happened to be the same (or providing an API 
where you can do the down with a fixed index provided by P0) the grace 
period will extend, then what you propose should be right.

But from Alan's comments I had misunderstood that that wouldn't be the case.

Best wishes,
jonas

