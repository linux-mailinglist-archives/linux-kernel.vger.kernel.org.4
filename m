Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65088675167
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 10:43:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbjATJnx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 04:43:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbjATJnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 04:43:51 -0500
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 626327698
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 01:43:49 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.229])
        by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4NyvWD6KJjz9y5YQ
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 17:35:52 +0800 (CST)
Received: from [10.48.133.21] (unknown [10.48.133.21])
        by APP1 (Coremail) with SMTP id LxC2BwD3fAgxYspjOrqwAA--.5131S2;
        Fri, 20 Jan 2023 10:43:24 +0100 (CET)
Message-ID: <c5902c18-e0cc-125e-c2f5-7971f0a7ce07@huaweicloud.com>
Date:   Fri, 20 Jan 2023 10:43:10 +0100
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
 <20230119215304.GA2948950@paulmck-ThinkPad-P17-Gen-1>
From:   Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
In-Reply-To: <20230119215304.GA2948950@paulmck-ThinkPad-P17-Gen-1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: LxC2BwD3fAgxYspjOrqwAA--.5131S2
X-Coremail-Antispam: 1UD129KBjvJXoWxZFy7KFyfGw47ZF18uF1DAwb_yoW5Xw4UpF
        W3Kay7Wr4DJrnagrnFgw1UuryFga1rWr1DZrn8XFWrArnIvw1rJFy7Kr1Fkry3ZrW7Cw42
        qF42vFZ3Ja4UZwUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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



On 1/19/2023 10:53 PM, Paul E. McKenney wrote:
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

This sounds like good style.
I suppose this is already flagged as mismatched srcu_unlock(), in case 
you accidentally read from the initial write?

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
> Agreed.  I for one would definitely have something to say about an
> SRCU-usage patch that directly manipulated a srcu_struct structure!  ;-)

Wouldn't the point of having it being flagged be that herd (or similar 
tools) would be having something to say long before it has to reach your 
pair of eyes?
I don't think Boqun's patch is hard to repair.
Besides the issue you mention, I think it's also missing Sync-srcu, 
which seems to be linked by loc based on its first argument.

How about something like this?

let ALL-LOCKS = LKR | LKW | UL | LF | RU | Srcu-lock | Srcu-unlock | 
Sync-srcu   flag ~empty ~[ALL_LOCKS | IW] ; loc ; [ALL-LOCKS] as mixed-lock-accesses

If you're using something that isn't a lock or intial write on the same location as a lock, you get the flag.

Best wishes,
   jonas

