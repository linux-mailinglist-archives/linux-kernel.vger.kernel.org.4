Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9D2167CAC3
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 13:19:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237053AbjAZMTD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 07:19:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237191AbjAZMSj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 07:18:39 -0500
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 517256C126
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 04:18:26 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.228])
        by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4P2ffk3yznz9v7W0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 20:10:22 +0800 (CST)
Received: from [10.48.129.37] (unknown [10.48.129.37])
        by APP2 (Coremail) with SMTP id GxC2BwDXo1pwb9JjCG3JAA--.427S2;
        Thu, 26 Jan 2023 13:18:03 +0100 (CET)
Message-ID: <0ef2e974-5c3a-6195-62d5-a4c436bd7d82@huaweicloud.com>
Date:   Thu, 26 Jan 2023 13:17:49 +0100
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
References: <cedf3a39-12cd-1cb1-ad5a-7c10768cee40@huaweicloud.com>
 <20230125150520.GG2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y9FMEATzv3gcTUe2@rowland.harvard.edu>
 <20230125171832.GH2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y9F+SyLpxHwdK0rE@rowland.harvard.edu>
 <20230125194651.GN2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y9GVFkVRRRs5/rBd@rowland.harvard.edu>
 <20230125213832.GQ2948950@paulmck-ThinkPad-P17-Gen-1>
 <20230125233308.GA1552266@paulmck-ThinkPad-P17-Gen-1>
 <Y9HbSBLrNJ9O2ad6@rowland.harvard.edu>
 <20230126015330.GX2948950@paulmck-ThinkPad-P17-Gen-1>
From:   Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
In-Reply-To: <20230126015330.GX2948950@paulmck-ThinkPad-P17-Gen-1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GxC2BwDXo1pwb9JjCG3JAA--.427S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXr4fAw17Wr4kCFy7XFWUJwb_yoW5Ww43pF
        W8KF47KF4kJ397Zw4xCF4xCrWFyrWrXa45Jr9ayr18A343Gr4S9rW3KFyYgFy5Wrs3u3W0
        vF4j93s8ua4UAaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/26/2023 2:53 AM, Paul E. McKenney wrote:
> On Wed, Jan 25, 2023 at 08:45:44PM -0500, Alan Stern wrote:
>> On Wed, Jan 25, 2023 at 03:33:08PM -0800, Paul E. McKenney wrote:
>>> Ah, and returning to the earlier question as to whether srcu_read_unlock()
>>> can use release semantics instead of smp_mb(), at the very least, this
>>> portion of the synchronize_srcu() function's header comment must change:
>>>
>>> 	On systems with more than one CPU, when synchronize_srcu()
>>> 	returns, each CPU is guaranteed to have executed a full
>>> 	memory barrier since the end of its last corresponding SRCU
>>> 	read-side critical section whose beginning preceded the call
>>> 	to synchronize_srcu().
>>
>> Of course, there might be code relying on a guarantee that
>> srcu_read_unlock() executes a full memory barrier.  This guarantee would
>> certainly no longer hold.  But as I understand it, this guarantee was
>> never promised by the SRCU subsystem.
> That indented sentence was copied from the synchronize_srcu() function's
> header comment, which might be interpreted by some as a promise by the
> SRCU subsystem.

I think we understand that it is a promise of the SRCU subsystem, the 
question is just what the promise is.
As Alan said, if the promise is interpreted as something like

"every store that propagated to the read side critical section must have 
propagated to all CPUs before the  synchronize_srcu() ends" (where the 
RSCS and synchronize_srcu() calls are those from the promise)

then that guarantee holds even if you only use a release fence to 
communicate the end of the RSCS to the GP. Note that this interpretation 
is analogous to the promise of smp_mb__after_unlock_lock(), which says 
that an UNLOCK+LOCK pair act as a full fence: here the read-side 
unlock+gp act as a full memory barrier.

On the other hand, if the promise is more literally interpreted as

"there is a (possibly virtual) instruction in the reader-side execution 
stream that acts as a full memory barrier, and that instruction is 
executed before the  synchronize_srcu() ends"

then that guarantee is violated, and I suppose you might be able to 
write some absurd client that inspects every store of the reader thread 
and sees that there is no line in the reader side code that acts like a 
full fence. But it would take a lot of effort to discern this.

Perhaps someone interpreting the promise like this might however come to 
the conclusion that because the only part of the code that is actually 
under control of srcu, and hence the only code where that full barrier 
could be hidden, would be inside the srcu_unlock(), they might expect to 
always find this full barrier there and treat srcu_unlock() in general 
as a full barrier. Considering that the wording explicitly isn't "an 
srcu_unlock() is a full barrier", I hope few people would have this 
unhealthy idea. But you never know.

Best wishes,
jonas

