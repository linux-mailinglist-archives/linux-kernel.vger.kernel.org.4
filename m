Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5AB2677A58
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 12:49:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231578AbjAWLt3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 06:49:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231478AbjAWLt1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 06:49:27 -0500
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A3AA15C84
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 03:49:24 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.227])
        by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4P0p8h62xjz9v7Yt
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 19:41:24 +0800 (CST)
Received: from [10.81.216.232] (unknown [10.81.216.232])
        by APP1 (Coremail) with SMTP id LxC2BwBX3gkfdM5jWRq+AA--.10786S2;
        Mon, 23 Jan 2023 12:48:59 +0100 (CET)
Message-ID: <1e77c538-d04b-62b7-a859-1589bab0ddef@huaweicloud.com>
Date:   Mon, 23 Jan 2023 12:48:42 +0100
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
References: <20230118201918.GI2948950@paulmck-ThinkPad-P17-Gen-1>
 <a5637181-1675-7973-489c-e5d24cbd25c2@huaweicloud.com>
 <20230118211201.GL2948950@paulmck-ThinkPad-P17-Gen-1>
 <09f084d2-6128-7f83-b2a5-cbe236b1678d@huaweicloud.com>
 <20230119001147.GN2948950@paulmck-ThinkPad-P17-Gen-1>
 <0fae983b-2a7c-d44e-8881-53d5cc053f09@huaweicloud.com>
 <20230119184107.GT2948950@paulmck-ThinkPad-P17-Gen-1>
 <64b48a7b-624c-26bd-be9b-0522fc490b28@huaweicloud.com>
 <Y8q+u09ynxnvjVi5@rowland.harvard.edu>
 <ea37d3d9-4ed3-872a-aed9-f34c4553f6f1@huaweicloud.com>
 <Y8wimpMpajLudrYb@rowland.harvard.edu>
From:   Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
In-Reply-To: <Y8wimpMpajLudrYb@rowland.harvard.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: LxC2BwBX3gkfdM5jWRq+AA--.10786S2
X-Coremail-Antispam: 1UD129KBjvJXoWxCFWUWrW5CF1kXry3ury3Arb_yoW5Zr1DpF
        Wfta4Skr4DXFWIvwnF9w42vF18J3y8XFW3Xr95Jws7A398XFn3Ar1fKa1Yka43Zr4ftanF
        vrWjqr9rAa4DJaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS
        07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
        02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_
        WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
        CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAF
        wI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa
        7IU13rcDUUUUU==
X-CM-SenderInfo: 5mrqt2oorev25kdx2v3u6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/21/2023 6:36 PM, Alan Stern wrote:
> On Fri, Jan 20, 2023 at 10:41:14PM +0100, Jonas Oberhauser wrote:
>>
>> On 1/20/2023 5:18 PM, Alan Stern wrote:
>>> On Fri, Jan 20, 2023 at 11:13:00AM +0100, Jonas Oberhauser wrote:
>>>> Perhaps we could say that reading an index without using it later is
>>>> forbidden?
>>>>
>>>> flag ~empty [Srcu-lock];data;rf;[~ domain(data;[Srcu-unlock])] as
>>>> thrown-srcu-cookie-on-floor
>>> We already flag locks that don't have a matching unlock.
>> Of course, but as you know this is completely orthogonal.
> Yeah, okay.  It doesn't hurt to add this check, but the check isn't
> complete.  For example, it won't catch the invalid usage here:
>
> P0(srcu_struct *ss)
> {
> 	int r1, r2;
>
> 	r1 = srcu_read_lock(ss);
> 	srcu_read_unlock(&ss, r1);
> 	r2 = srcu_read_lock(ss);
> 	srcu_read_unlock(&ss, r2);
> }
>
> exists (~0:r1=0:r2)
>
> On the other hand, how often will people make this sort of mistake in
> their litmus tests?  My guess is not very.
I currently don't care too much about the incorrect usage of herd (by 
inspecting some final state incorrectly), only incorrect usage in the code.

>
>> I can imagine models that allow this but they aren't pretty. Maybe you have
>> a better operational model?
> The operational model is not very detailed as far as SRCU is concerned.
> It merely says that synchronize_srcu() executing on CPU C waits until:
>
> 	[...]
>
> 	For every srcu_down_read() that executed prior to t1, the
> 	matching srcu_up_read() [...].
> [...]
>
> Does this answer your question satisfactorily?

The reason I originally didn't consider this type of model (which 
requires defining 'matching') pretty is that the most natural way to 
define matching is probably using the whole dependency stuff at the 
operational level. This isn't necessary for rcu or srcu lock/unlock, so 
I thought this will add a new amount of tediousness to the model.
But I now realized that mechanisms for tracking dependencies are pretty 
much already there (to define when stores can be executed), so I'm not 
that unhappy about it anymore.


>>>> So if there is an srcu_down() that produces a cookie that is read by some
>>>> read R, and R doesn't then pass that value into an srcu_up(), the
>>>> srcu-warranty is voided.
>>> No, it isn't.
>> I quote Paul:
>> "If you do anything else at all with it, anything at all, you just voided
>> your SRCU warranty. For that matter, if you just throw that value on the
>> floor and don't pass it to an srcu_up_read() execution, you also just voided
>> your SRCU warranty."
> I suspect Paul did not express himself very precisely, and what he
> really meant was more like this:
>
> 	If you don't pass the value to exactly one srcu_up_read() call,
> 	you void the SRCU warranty.  In addition, if you do anything
> 	else with the value that might affect the outcome of the litmus
> 	test, you incur the risk that herd7 might compute an incorrect
> 	result [as in the litmus test I gave near the start of this
> 	email].
>
> Merely storing the value in a shared variable which then doesn't get
> used or is used only for something inconsequential would not cause any
> problems.
>
> Alan
Ah, I understand now.
Thanks, jonas

