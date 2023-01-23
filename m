Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75F22678693
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 20:41:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232648AbjAWTlF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 14:41:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232582AbjAWTlD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 14:41:03 -0500
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8716D977A
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 11:41:01 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.228])
        by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4P10cr4Pq5z9xGYB
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 03:33:00 +0800 (CST)
Received: from [10.81.216.232] (unknown [10.81.216.232])
        by APP2 (Coremail) with SMTP id GxC2BwBn7mSq4s5j8bG9AA--.51816S2;
        Mon, 23 Jan 2023 20:40:38 +0100 (CET)
Message-ID: <dc535472-eb7f-9b73-bd9b-3ec282e90478@huaweicloud.com>
Date:   Mon, 23 Jan 2023 20:40:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: Internal vs. external barriers (was: Re: Interesting LKMM litmus
 test)
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     paulmck@kernel.org, Andrea Parri <parri.andrea@gmail.com>,
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
References: <20230118211201.GL2948950@paulmck-ThinkPad-P17-Gen-1>
 <09f084d2-6128-7f83-b2a5-cbe236b1678d@huaweicloud.com>
 <20230119001147.GN2948950@paulmck-ThinkPad-P17-Gen-1>
 <0fae983b-2a7c-d44e-8881-53d5cc053f09@huaweicloud.com>
 <20230119184107.GT2948950@paulmck-ThinkPad-P17-Gen-1>
 <64b48a7b-624c-26bd-be9b-0522fc490b28@huaweicloud.com>
 <Y8q+u09ynxnvjVi5@rowland.harvard.edu>
 <ea37d3d9-4ed3-872a-aed9-f34c4553f6f1@huaweicloud.com>
 <Y8wimpMpajLudrYb@rowland.harvard.edu>
 <1e77c538-d04b-62b7-a859-1589bab0ddef@huaweicloud.com>
 <Y86t5ST3TcUl/rQd@rowland.harvard.edu>
From:   Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
In-Reply-To: <Y86t5ST3TcUl/rQd@rowland.harvard.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: GxC2BwBn7mSq4s5j8bG9AA--.51816S2
X-Coremail-Antispam: 1UD129KBjvJXoW7urW8tw1UWw1xJF4fCw45Wrg_yoW8CF17pF
        yftay0kr4DJr4a9rnFvr10gryxt3yrXFy5Wwn8Jw1xXF90qF98Gw4Skrs8C3sxXr13Ja1j
        vrWjqay3Ja4UJaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvSb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
        e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
        Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a
        6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
        kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv
        67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43
        ZEXa7IU1rMa5UUUUU==
X-CM-SenderInfo: 5mrqt2oorev25kdx2v3u6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/23/2023 4:55 PM, Alan Stern wrote:
> On Mon, Jan 23, 2023 at 12:48:42PM +0100, Jonas Oberhauser wrote:
>>
>> On 1/21/2023 6:36 PM, Alan Stern wrote:
>>> On Fri, Jan 20, 2023 at 10:41:14PM +0100, Jonas Oberhauser wrote:
>>>> On 1/20/2023 5:18 PM, Alan Stern wrote:
>>>>> On Fri, Jan 20, 2023 at 11:13:00AM +0100, Jonas Oberhauser wrote:
>>>>>> Perhaps we could say that reading an index without using it later is
>>>>>> forbidden?
>>>>>>
>>>>>> flag ~empty [Srcu-lock];data;rf;[~ domain(data;[Srcu-unlock])] as
>>>>>> thrown-srcu-cookie-on-floor
>>>>> We already flag locks that don't have a matching unlock.
>>>> Of course, but as you know this is completely orthogonal.
>>> Yeah, okay.  It doesn't hurt to add this check, but the check isn't
>>> complete.  For example, it won't catch the invalid usage here:
>>>
>>> P0(srcu_struct *ss)
>>> {
>>> 	int r1, r2;
>>>
>>> 	r1 = srcu_read_lock(ss);
>>> 	srcu_read_unlock(&ss, r1);
>>> 	r2 = srcu_read_lock(ss);
>>> 	srcu_read_unlock(&ss, r2);
>>> }
>>>
>>> exists (~0:r1=0:r2)
>>>
>>> On the other hand, how often will people make this sort of mistake in
>>> their litmus tests?  My guess is not very.
>> I currently don't care too much about the incorrect usage of herd (by
>> inspecting some final state incorrectly), only incorrect usage in the code.
> I'm inclined to add this check to the memory model.  Would you prefer to
> submit it yourself as a separate patch?  Or are you happy to have it
> merged with my patch, and if so, do you have a final, preferred form for
> the check?

After clearing my confusion, I'm no longer sure if it should be added. 
If you're still inclined to have it, I would prefer to submit the patch, 
but I'd like to define the use-cookie relation (= 
(data|[~Srcu-unlock];rfe)+) and use it also to clarify the srcu match 
definition (I almost would like to do that anyways :D).
Is that ok?

jonas

