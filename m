Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F41FD67E8E1
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 16:03:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234105AbjA0PD6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 10:03:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbjA0PD4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 10:03:56 -0500
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D6947BE69
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 07:03:55 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.229])
        by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4P3LHD0ggKz9v7Qq
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 22:55:52 +0800 (CST)
Received: from [10.81.218.251] (unknown [10.81.218.251])
        by APP1 (Coremail) with SMTP id LxC2BwBn6QS459NjJkPQAA--.2692S2;
        Fri, 27 Jan 2023 16:03:31 +0100 (CET)
Message-ID: <c94ad1d4-c7ac-4570-6f33-85656b041090@huaweicloud.com>
Date:   Fri, 27 Jan 2023 16:03:16 +0100
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
References: <Y9FMEATzv3gcTUe2@rowland.harvard.edu>
 <20230125171832.GH2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y9F+SyLpxHwdK0rE@rowland.harvard.edu>
 <20230125194651.GN2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y9GVFkVRRRs5/rBd@rowland.harvard.edu>
 <20230125213832.GQ2948950@paulmck-ThinkPad-P17-Gen-1>
 <20230125233308.GA1552266@paulmck-ThinkPad-P17-Gen-1>
 <Y9HbSBLrNJ9O2ad6@rowland.harvard.edu>
 <20230126015330.GX2948950@paulmck-ThinkPad-P17-Gen-1>
 <0ef2e974-5c3a-6195-62d5-a4c436bd7d82@huaweicloud.com>
 <20230126184802.GF2948950@paulmck-ThinkPad-P17-Gen-1>
From:   Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
In-Reply-To: <20230126184802.GF2948950@paulmck-ThinkPad-P17-Gen-1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: LxC2BwBn6QS459NjJkPQAA--.2692S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWF1kXw1fCFW8JF4DWr47XFb_yoW5AF1rpF
        WSgrsrGrn8Jrs7uw17Aw4UCr9Yy3yrGFy5CF93Wr1vya43Zr13JF40gry8uryDWFZrur4U
        tw4UK3Z5AFy5u3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/26/2023 7:48 PM, Paul E. McKenney wrote:
> On Thu, Jan 26, 2023 at 01:17:49PM +0100, Jonas Oberhauser wrote:
>> [...]
>> Note that this interpretation is analogous to the promise of smp_mb__after_unlock_lock(), which says that an
>> UNLOCK+LOCK pair act as a full fence: here the read-side unlock+gp act as a
>> full memory barrier.
> Good point that the existing smp_mb__after_unlock_lock() can be used for
> any use cases relying on the more literal interpretation of this promise.
> We already have the work-around!  ;-)

Can it? I meant that the less-literal form is similar to the one given 
by smp_mb__after_unlock_lock().

>> [...] I suppose you might be able to write
>> some absurd client that inspects every store of the reader thread and sees
>> that there is no line in the reader side code that acts like a full fence.
>> But it would take a lot of effort to discern this.
> The usual litmus test is shown at the end of this email [...]
>> [...] I hope few people would have this unhealthy idea. But you
>> never know.
> Given that the more literal interpretation is not unreasonable, we should
> assume that someone somewhere might have interpreted it that way.
>
> But I agree that the odds of someone actually relying on this are low,
> and any such use case can be fixed with smp_mb__before_srcu_read_unlock(),
> similar to smp_mb__after_srcu_read_unlock() that you note is already in use.
>
> It would still be good to scan SRCU use for this sort of pattern, maybe
> manually, maybe via something like coccinelle.  Alternatively, I could
> post on my blog (with right of first refusal to LWN and you guys as
> co-authors) telling the community of our intent to change this and see
> what people say.  Probably both rather than either/or.
>
> Thoughts?

My first thought is "there is a 'usual' litmus test for this?" :D
But yes, the test you have given has at least the same structure as what 
I would expect.

Communicating this with the community sounds very reasonable.

For some automated combing, I'm really not sure what pattern to look for.
I'm afraid someone with a lot of time might have to look (semi-)manually.

Best wishes, jonas


>
> 							Thanx, Paul
>
> ------------------------------------------------------------------------
>
> C C-srcu-observed-6
>
> (*
>   * Result: Sometimes
>   *
>   * The result is Never if any of the smp_mb() calls is uncommented.
>   *)
>
> {}
>
> P0(int *a, int *b, int *c, int *d, struct srcu_struct *s)
> {
> 	int r1;
> 	int r2;
> 	int r3;
> 	int r4;
>
> 	r1 = srcu_read_lock(s);
> 	WRITE_ONCE(*b, 2);
> 	r2 = READ_ONCE(*a);
> 	// smp_mb();
> 	srcu_read_unlock(s, r1);
> 	// smp_mb();
> 	r3 = READ_ONCE(*c);
> 	// smp_mb();
> 	r4 = READ_ONCE(*d);
> }
>
> P1(int *a, int *b, int *c, int *d, struct srcu_struct *s)
> {
> 	WRITE_ONCE(*b, 1);
> 	synchronize_srcu(s);
> 	WRITE_ONCE(*c, 1);
> }
>
> P2(int *a, int *b, int *c, int *d, struct srcu_struct *s)
> {
> 	WRITE_ONCE(*d, 1);
> 	smp_mb();
> 	WRITE_ONCE(*a, 1);
> }
>
> exists (0:r2=1 /\ 0:r3=1 /\ 0:r4=0 /\ b=1)

