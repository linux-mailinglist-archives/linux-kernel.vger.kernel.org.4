Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53DE967B303
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 14:11:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235539AbjAYNK6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 08:10:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235511AbjAYNK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 08:10:56 -0500
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1466F49011
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 05:10:43 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.229])
        by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4P23sb6DFNz9xrpW
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 21:02:43 +0800 (CST)
Received: from [10.48.135.9] (unknown [10.48.135.9])
        by APP1 (Coremail) with SMTP id LxC2BwAXnQgyKtFjLS_HAA--.15611S2;
        Wed, 25 Jan 2023 14:10:21 +0100 (CET)
Message-ID: <cedf3a39-12cd-1cb1-ad5a-7c10768cee40@huaweicloud.com>
Date:   Wed, 25 Jan 2023 14:10:08 +0100
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
References: <20230124145423.GI2948950@paulmck-ThinkPad-P17-Gen-1>
 <8cc799ab-ffa1-47f7-6e1d-97488a210f14@huaweicloud.com>
 <20230124162253.GL2948950@paulmck-ThinkPad-P17-Gen-1>
 <3e5020c2-0dd3-68a6-9b98-5a7f57ed7733@huaweicloud.com>
 <20230124172647.GN2948950@paulmck-ThinkPad-P17-Gen-1>
 <2788294a-972e-acbc-84ce-25d2bb4d26d6@huaweicloud.com>
 <20230124221524.GV2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y9BdNVk2LQiUYABS@rowland.harvard.edu>
 <20230124225449.GY2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y9CL8LBz+/mbbD00@rowland.harvard.edu>
 <20230125022019.GB2948950@paulmck-ThinkPad-P17-Gen-1>
From:   Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
In-Reply-To: <20230125022019.GB2948950@paulmck-ThinkPad-P17-Gen-1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: LxC2BwAXnQgyKtFjLS_HAA--.15611S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ZryfWF1fZF1UZw13WFykXwb_yoW8ZF15pF
        W8KFsFka1Dtr40grnxZr1xWFy5ta95XFs8KrnYgwnxAwn0gF9rKw4fGw43CFyFqrZay3Wj
        va1Yqa4Duas8ZFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
        e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
        Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a
        6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
        kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVW3JVWrJr1lIxAIcVC2z280aVAF
        wI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa
        7IUbG2NtUUUUU==
X-CM-SenderInfo: 5mrqt2oorev25kdx2v3u6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/25/2023 3:20 AM, Paul E. McKenney wrote:
> On Tue, Jan 24, 2023 at 08:54:56PM -0500, Alan Stern wrote:
>> On Tue, Jan 24, 2023 at 02:54:49PM -0800, Paul E. McKenney wrote:
>>> On Tue, Jan 24, 2023 at 05:35:33PM -0500, Alan Stern wrote:
>>>> Can you be more explicit?  Exactly what guarantees does the kernel
>>>> implementation make that can't be expressed in LKMM?
>>> I doubt that I will be able to articulate it very well, but here goes.
>>>
>>> Within the Linux kernel, the rule for a given RCU "domain" is that if
>>> an event follows a grace period in pretty much any sense of the word,
>>> then that event sees the effects of all events in all read-side critical
>>> sections that began prior to the start of that grace period.
>>>
>>> Here the senses of the word "follow" include combinations of rf, fr,
>>> and co, combined with the various acyclic and irreflexive relations
>>> defined in LKMM.
>> The LKMM says pretty much the same thing.  In fact, it says the event
>> sees the effects of all events po-before the unlock of (not just inside)
>> any read-side critical section that began prior to the start of the
>> grace period.
>>
>>>> And are these anything the memory model needs to worry about?
>>> Given that several people, yourself included, are starting to use LKMM
>>> to analyze the Linux-kernel RCU implementations, maybe it does.
>>>
>>> Me, I am happy either way.
>> Judging from your description, I don't think we have anything to worry
>> about.
> Sounds good, and let's proceed on that assumption then.  We can always
> revisit later if need be.
>
> 							Thanx, Paul

FWIW, I currently don't see a need for either RCU nor "base" LKMM to 
have this kind of guarantee.
But I'm curious for why it doesn't exist in LKMM -- is it because of 
Alpha or some other issues that make it hard to guarantee (like a 
compiler merging two threads and optimizing or something?), or is it 
simply that it seemed like a complicated guarantee with no discernible 
upside, or something else?

Best wishes, jonas

