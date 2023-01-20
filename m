Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B44B1675F16
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 21:47:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbjATUri (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 15:47:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjATUrg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 15:47:36 -0500
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8FCAAA5EA
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 12:47:34 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.229])
        by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4NzBF15ftlz9v7K5
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jan 2023 04:39:33 +0800 (CST)
Received: from [10.81.223.78] (unknown [10.81.223.78])
        by APP2 (Coremail) with SMTP id GxC2BwD3yF_C_cpjoe2wAA--.5389S2;
        Fri, 20 Jan 2023 21:47:09 +0100 (CET)
Message-ID: <cc3686b3-b234-b0ee-4d2d-15f54da4331b@huaweicloud.com>
Date:   Fri, 20 Jan 2023 21:46:55 +0100
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
References: <20230118201918.GI2948950@paulmck-ThinkPad-P17-Gen-1>
 <a5637181-1675-7973-489c-e5d24cbd25c2@huaweicloud.com>
 <20230118211201.GL2948950@paulmck-ThinkPad-P17-Gen-1>
 <09f084d2-6128-7f83-b2a5-cbe236b1678d@huaweicloud.com>
 <20230119001147.GN2948950@paulmck-ThinkPad-P17-Gen-1>
 <0fae983b-2a7c-d44e-8881-53d5cc053f09@huaweicloud.com>
 <20230119184107.GT2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8mfWTX7V69pAwo8@rowland.harvard.edu>
 <20230119215304.GA2948950@paulmck-ThinkPad-P17-Gen-1>
 <c5902c18-e0cc-125e-c2f5-7971f0a7ce07@huaweicloud.com>
 <20230120153909.GF2948950@paulmck-ThinkPad-P17-Gen-1>
From:   Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
In-Reply-To: <20230120153909.GF2948950@paulmck-ThinkPad-P17-Gen-1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GxC2BwD3yF_C_cpjoe2wAA--.5389S2
X-Coremail-Antispam: 1UD129KBjvJXoW7CFy5Cryktr4ftr4DZw4rGrg_yoW8KrWDp3
        s0gFn8GF4kAr1fX3ZrXr4xXr1Yvw45KFWDArn8tF47Cw15ur12gF4fKw15AF4furs3Aayv
        qw429Fn8Z34qvaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/20/2023 4:39 PM, Paul E. McKenney wrote:
> On Fri, Jan 20, 2023 at 10:43:10AM +0100, Jonas Oberhauser wrote:
>
>> I don't think Boqun's patch is hard to repair.
>> Besides the issue you mention, I think it's also missing Sync-srcu, which
>> seems to be linked by loc based on its first argument.
>>
>> How about something like this?
>>
>> let ALL-LOCKS = LKR | LKW | UL | LF | RU | Srcu-lock | Srcu-unlock |
>> Sync-srcu   flag ~empty ~[ALL_LOCKS | IW] ; loc ; [ALL-LOCKS] as
>> mixed-lock-accesses
>>
>> If you're using something that isn't a lock or intial write on the same location as a lock, you get the flag.
> Wouldn't that unconditionally complain about the first srcu_read_lock()
> in a given process?  Or am I misreading those statements?
> 							

I unfolded the definition step by step and it seems I was careless when 
distributing the ~ over the [] operator.
I should have written:

flag ~empty [~(ALL_LOCKS | IW)] ; loc ; [ALL-LOCKS] as mixed-lock-accesses

but somehow I thought I can save the parentheses by putting the ~ on the 
outside.
Now on the off-chance that this is kind of how you already read the 
relation, let me unfold it step-by-step.

Let's assume that the sequence s of operations on this location is
   s = initial write , (perhaps some gps) , first read lock , read 
lock&unlock&gp ...
then the flag would appear if the specified relation isn't empty. That 
would be the case if there are a and b that are linked by

   a ->[~(ALL_LOCKS | IW)] ; loc ; [ALL-LOCKS] b

This means a is neither in ALL_LOCKS nor in IW, while b is ALL-LOCKS; and furthermore, they are equal to a' and b' resp. that are related by loc, i.e., appear in this sequence s. Thus both a and b are actually appearing both in the sequence s.
However, every event in the sequence s is either in ALL_LOCKS or in IW, which contradicts the assumption that a is in the sequence and in neither of the sets. Because of this contradiction, the flag doesn't appear if the sequence looks like this.

More generally, if every event in the sequence is either the initial write or one of (srcu-) lock,unlock,up,down,sync, there won't be a flag.

In contrast, if the sequence has the form
  s' = initial write, (normal srcu events), some other acces x, (normal srcu events)
and y is one of the srcu events in this sequence, then
  x ->[~(ALL_LOCKS | IW)] ; loc ; [ALL_LOCKS] y
and you get a flag.

Best wishes,
jonas

