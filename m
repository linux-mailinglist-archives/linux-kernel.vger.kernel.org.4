Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2F73675224
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 11:13:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbjATKNl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 05:13:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbjATKNj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 05:13:39 -0500
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 334A2891E7
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 02:13:38 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.228])
        by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4Nyw9b4Bw3z9y0kg
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 18:05:39 +0800 (CST)
Received: from [10.48.133.21] (unknown [10.48.133.21])
        by APP2 (Coremail) with SMTP id GxC2BwDXXWQvacpjZRCvAA--.43987S2;
        Fri, 20 Jan 2023 11:13:14 +0100 (CET)
Message-ID: <64b48a7b-624c-26bd-be9b-0522fc490b28@huaweicloud.com>
Date:   Fri, 20 Jan 2023 11:13:00 +0100
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
References: <Y8cBypKx4gM3wBJa@rowland.harvard.edu>
 <20230118035041.GQ2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8gjUKoHxqR9+7Hx@rowland.harvard.edu>
 <3dabbcfb-858c-6aa0-6824-05b8cc8e9cdb@gmail.com>
 <20230118201918.GI2948950@paulmck-ThinkPad-P17-Gen-1>
 <a5637181-1675-7973-489c-e5d24cbd25c2@huaweicloud.com>
 <20230118211201.GL2948950@paulmck-ThinkPad-P17-Gen-1>
 <09f084d2-6128-7f83-b2a5-cbe236b1678d@huaweicloud.com>
 <20230119001147.GN2948950@paulmck-ThinkPad-P17-Gen-1>
 <0fae983b-2a7c-d44e-8881-53d5cc053f09@huaweicloud.com>
 <20230119184107.GT2948950@paulmck-ThinkPad-P17-Gen-1>
From:   Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
In-Reply-To: <20230119184107.GT2948950@paulmck-ThinkPad-P17-Gen-1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GxC2BwDXXWQvacpjZRCvAA--.43987S2
X-Coremail-Antispam: 1UD129KBjvJXoWxZFyxCr4xXw4rJw43XryxXwb_yoW5GrykpF
        Z5tFZaywnrArn7uw1Iv3Wjqry0v34UJay5Xws5JrW8Aa98WFnIgr1Ig3WYgrZxur4xAr4j
        qrWYqasrZa1xJaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/19/2023 7:41 PM, Paul E. McKenney wrote:
> On Thu, Jan 19, 2023 at 02:39:01PM +0100, Jonas Oberhauser wrote:
>>
>> On 1/19/2023 1:11 AM, Paul E. McKenney wrote:
>>> On Wed, Jan 18, 2023 at 10:24:50PM +0100, Jonas Oberhauser wrote:
>>>> What I was thinking of is more something like this:
>>>>
>>>> P0{
>>>>      idx1 = srcu_down(&ss);
>>>>      srcu_up(&ss,idx1);
>>>> }
>>>>
>>>> P1{
>>>>       idx2 = srcu_down(&ss);
>>>>       srcu_up(&ss,idx2)
>>>> }
>>> And srcu_read_lock() and srcu_read_unlock() already do this.
>> I think I left out too much from my example.
>> And filling in the details led me down a bit of a rabbit hole of confusion
>> for a while.
>> But here's what I ended up with:
>>
>>
>> P0{
>>      idx1 = srcu_down(&ss);
>>      store_rel(p1, true);
>>
>>
>>      shared cs
>>
>>      R x == ?
>>
>>      while (! load_acq(p2));
>>      R idx2 == idx1 // for some reason, we got lucky!
>>      srcu_up(&ss,idx1);
> Although the current Linux-kernel implementation happens to be fine with
> this sort of abuse, I am quite happy to tell people "Don't do that!"
> And you can do this with srcu_read_lock() and srcu_read_unlock().
> In contrast, this actually needs srcu_down_read() and srcu_up_read():

My point/clarification request wasn't about whether you could write that 
code with read_lock() and read_unlock(), but what it would/should mean 
for the operational and axiomatic models.
As I wrote later in the mail, for the operational model it is quite 
clear that x==1 should be allowed for lock() and unlock(), but would 
probably be forbidden for down() and up().
My clarification request is whether that difference in the probable 
operational model should be reflected in the axiomatic model (as I first 
suspected based on the word "semaphore" being dropped a lot), or whether 
it's just due to abuse (i.e., yes the axiomatic model and operational 
model might be different here, but you're not allowed to look).
Which brings us to the next point:

> Could you please review the remainder to see what remains given the
> usage restrictions that I called out above?

Perhaps we could say that reading an index without using it later is 
forbidden?

flag ~empty [Srcu-lock];data;rf;[~ domain(data;[Srcu-unlock])] as 
thrown-srcu-cookie-on-floor

So if there is an srcu_down() that produces a cookie that is read by 
some read R, and R doesn't then pass that value into an srcu_up(), the 
srcu-warranty is voided.

Perhaps it would also be good to add special tags for Srcu-down and 
Srcu-up to avoid collisions.

always have fun, jonas

