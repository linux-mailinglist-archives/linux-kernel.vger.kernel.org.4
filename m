Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE6CE67A2F7
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 20:31:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234510AbjAXTbz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 14:31:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230214AbjAXTbN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 14:31:13 -0500
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FE8A4FC24
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 11:30:47 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.229])
        by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4P1cLT0M5Gz9xFmQ
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 03:22:41 +0800 (CST)
Received: from [10.45.158.189] (unknown [10.45.158.189])
        by APP1 (Coremail) with SMTP id LxC2BwD3fQnDMdBjMunDAA--.14846S2;
        Tue, 24 Jan 2023 20:30:23 +0100 (CET)
Message-ID: <2788294a-972e-acbc-84ce-25d2bb4d26d6@huaweicloud.com>
Date:   Tue, 24 Jan 2023 20:30:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: Internal vs. external barriers (was: Re: Interesting LKMM litmus
 test)
To:     paulmck@kernel.org
Cc:     Andrea Parri <parri.andrea@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
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
References: <20230120212037.GW2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y82dWEW4RwclDTGM@rowland.harvard.edu>
 <20230123201659.GA3754540@paulmck-ThinkPad-P17-Gen-1>
 <Y88/5ib7zYl67mcE@rowland.harvard.edu>
 <20230124040611.GD2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8+8fH52iqQABYs2@andrea>
 <20230124145423.GI2948950@paulmck-ThinkPad-P17-Gen-1>
 <8cc799ab-ffa1-47f7-6e1d-97488a210f14@huaweicloud.com>
 <20230124162253.GL2948950@paulmck-ThinkPad-P17-Gen-1>
 <3e5020c2-0dd3-68a6-9b98-5a7f57ed7733@huaweicloud.com>
 <20230124172647.GN2948950@paulmck-ThinkPad-P17-Gen-1>
From:   Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
In-Reply-To: <20230124172647.GN2948950@paulmck-ThinkPad-P17-Gen-1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LxC2BwD3fQnDMdBjMunDAA--.14846S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJF45Ww4xGr4DKrWrXry7KFg_yoW5AF4rpF
        Z3tanrAFn5XrZ5CrnFvwsFgr9a93W8GF15Xws8Xw1IyFnIkFn3AF45tryF9FyUXr97Gw1j
        qrWUKay3Ar1DCw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
        kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE
        14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyT
        uYvjxUFDGOUUUUU
X-CM-SenderInfo: 5mrqt2oorev25kdx2v3u6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/24/2023 6:26 PM, Paul E. McKenney wrote:
> On Tue, Jan 24, 2023 at 05:39:53PM +0100, Jonas Oberhauser wrote:
>>
>> On 1/24/2023 5:22 PM, Paul E. McKenney wrote:
>>> I clearly recall some
>>> store-based lack of ordering after a grace period from some years back,
>>> and am thus far failing to reproduce it.
>>>
>>> And here is another attempt that herd7 actually does allow.
>>>
>>> So what did I mess up this time?  ;-)
>>>
>>> 							Thanx, Paul
>>>
>>> ------------------------------------------------------------------------
>>>
>>> C C-srcu-observed-4
>>>
>>> (*
>>>    * Result: Sometimes
>>>    *
>>>    * The Linux-kernel implementation is suspected to forbid this.
>>>    *)
>>>
>>> {}
>>>
>>> P0(int *x, int *y, int *z, struct srcu_struct *s)
>>> {
>>> 	int r1;
>>>
>>> 	r1 = srcu_read_lock(s);
>>> 	WRITE_ONCE(*y, 2);
>>> 	WRITE_ONCE(*x, 1);
>>> 	srcu_read_unlock(s, r1);
>>> }
>>>
>>> P1(int *x, int *y, int *z, struct srcu_struct *s)
>>> {
>>> 	int r1;
>>>
>>> 	WRITE_ONCE(*y, 1);
>>> 	synchronize_srcu(s);
>>> 	WRITE_ONCE(*z, 2);
>>> }
>>>
>>> P2(int *x, int *y, int *z, struct srcu_struct *s)
>>> {
>>> 	WRITE_ONCE(*z, 1);
>>> 	smp_store_release(x, 2);
>>> }
>>>
>>> exists (x=1 /\ y=1 /\ z=1)
>> I think even if you implement the unlock as mb() followed by some store that
>> is read by the gp between mb()s, this would still be allowed.
> The implementation of synchronize_srcu() has quite a few smp_mb()
> invocations.
>
> But exactly how are you modeling this?  As in what additional accesses
> and memory barriers are you placing in which locations?

Along these lines:

P0(int *x, int *y, int *z, int *magic_location)
{
	int r1;


	WRITE_ONCE(*y, 2);
	WRITE_ONCE(*x, 1);

         smp_mb();
	WRITE_ONCE(*magic_location, 1);

}

P1(int *x, int *y, int *z, int *magic_location)
{
	int r1;

	WRITE_ONCE(*y, 1);

         smp_mb();
         while (! READ_ONCE(*magic_location))
		;
	smp_mb();
	WRITE_ONCE(*z, 2);
}


P2(int *x, int *y, int *z, struct srcu_struct *s)
{
	WRITE_ONCE(*z, 1);
	smp_store_release(x, 2);
}



Note that you can add as many additional smp_mb() and other accesses as 
you want around the original srcu call sites. I don't see how they could 
influence the absence of a cycle.

(Also, to make it work with herd it seems you need to replace the loop 
with a single read and state in the exists clause that it happens to 
read a 1.)

>> I have already forgotten the specifics, but I think the power model allows
>> certain stores never propagating somewhere?
> PowerPC would forbid the 3.2W case, where each process used an
> smp_store_release() as its sole ordering (no smp_mb() calls at all).
>
> [...]
>
> This propagation is modulated by the memory barriers, though.

Ah, looking at the model now. Indeed it's forbidden, because in order to 
say that something is in co, there must not be a (resulting) cycle of co 
and barriers. But you'd get that here.  In the axiomatic model, this 
corresponds to saying Power's "prop | co" is acyclic. The same isn't 
true in LKMM. So that's probably why.

Have fun, jonas

