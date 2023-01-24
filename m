Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A203F679EF9
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 17:41:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234168AbjAXQlA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 11:41:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234113AbjAXQk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 11:40:58 -0500
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67DC848639
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 08:40:32 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.229])
        by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4P1XZ16X1dz9v7cG
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 00:32:25 +0800 (CST)
Received: from [10.48.129.122] (unknown [10.48.129.122])
        by APP1 (Coremail) with SMTP id LxC2BwD3fwvcCdBj5mnDAA--.31461S2;
        Tue, 24 Jan 2023 17:40:08 +0100 (CET)
Message-ID: <3e5020c2-0dd3-68a6-9b98-5a7f57ed7733@huaweicloud.com>
Date:   Tue, 24 Jan 2023 17:39:53 +0100
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
References: <20230120192032.GR2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8r7SBdfuZX/y1cd@rowland.harvard.edu>
 <20230120212037.GW2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y82dWEW4RwclDTGM@rowland.harvard.edu>
 <20230123201659.GA3754540@paulmck-ThinkPad-P17-Gen-1>
 <Y88/5ib7zYl67mcE@rowland.harvard.edu>
 <20230124040611.GD2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8+8fH52iqQABYs2@andrea>
 <20230124145423.GI2948950@paulmck-ThinkPad-P17-Gen-1>
 <8cc799ab-ffa1-47f7-6e1d-97488a210f14@huaweicloud.com>
 <20230124162253.GL2948950@paulmck-ThinkPad-P17-Gen-1>
From:   Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
In-Reply-To: <20230124162253.GL2948950@paulmck-ThinkPad-P17-Gen-1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: LxC2BwD3fwvcCdBj5mnDAA--.31461S2
X-Coremail-Antispam: 1UD129KBjvJXoW7WrW3KrWfZr1kGw1DZryxKrg_yoW8XFy7pF
        Z3tFsrCrn5XryvgrnrZwnFgFn2ya45XFW5J3Z8X3s2yFnFkryrJFy5Kry0vry5XrWxGw42
        qr4UtF4DAr1UCrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvvb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x
        0267AKxVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02
        F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4I
        kC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY
        0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s
        026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_
        GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20x
        vEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2
        jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73Uj
        IFyTuYvjxUFDGOUUUUU
X-CM-SenderInfo: 5mrqt2oorev25kdx2v3u6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/24/2023 5:22 PM, Paul E. McKenney wrote:
> I clearly recall some
> store-based lack of ordering after a grace period from some years back,
> and am thus far failing to reproduce it.
>
> And here is another attempt that herd7 actually does allow.
>
> So what did I mess up this time?  ;-)
>
> 							Thanx, Paul
>
> ------------------------------------------------------------------------
>
> C C-srcu-observed-4
>
> (*
>   * Result: Sometimes
>   *
>   * The Linux-kernel implementation is suspected to forbid this.
>   *)
>
> {}
>
> P0(int *x, int *y, int *z, struct srcu_struct *s)
> {
> 	int r1;
>
> 	r1 = srcu_read_lock(s);
> 	WRITE_ONCE(*y, 2);
> 	WRITE_ONCE(*x, 1);
> 	srcu_read_unlock(s, r1);
> }
>
> P1(int *x, int *y, int *z, struct srcu_struct *s)
> {
> 	int r1;
>
> 	WRITE_ONCE(*y, 1);
> 	synchronize_srcu(s);
> 	WRITE_ONCE(*z, 2);
> }
>
> P2(int *x, int *y, int *z, struct srcu_struct *s)
> {
> 	WRITE_ONCE(*z, 1);
> 	smp_store_release(x, 2);
> }
>
> exists (x=1 /\ y=1 /\ z=1)

I think even if you implement the unlock as mb() followed by some store 
that is read by the gp between mb()s, this would still be allowed.

I have already forgotten the specifics, but I think the power model 
allows certain stores never propagating somewhere?
If z=2,z=1,x=2 never propagate to P0, you might start by executing P0, 
then P1, and then P2 at which point the memory system decides that x=1 
overwrites x=2, and the latter simply doesn't propagate anywhere.

(I'll let anyone who has the model at hand correct me on this, because I 
have to take a walk now).

Have fun, jonas

