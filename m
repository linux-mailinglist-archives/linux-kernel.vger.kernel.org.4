Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B08C367D1A8
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 17:32:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbjAZQcH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 11:32:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjAZQcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 11:32:05 -0500
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A6C0210A
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 08:32:00 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.227])
        by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4P2mHJ46hQz9xFHQ
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 00:23:56 +0800 (CST)
Received: from [10.48.129.37] (unknown [10.48.129.37])
        by APP1 (Coremail) with SMTP id LxC2BwD3eATbqtJjJCbMAA--.816S2;
        Thu, 26 Jan 2023 17:31:35 +0100 (CET)
Message-ID: <10cfb309-4a12-2b57-e367-b5224a442685@huaweicloud.com>
Date:   Thu, 26 Jan 2023 17:31:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [Patch 2/2] tools/memory-model: Provide exact SRCU semantics
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
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
References: <Y9GO3xEYkIQq/qSl@rowland.harvard.edu>
 <Y9GPI/g23YWx+0Ce@rowland.harvard.edu> <Y9GPVnK6lQbY6vCK@rowland.harvard.edu>
 <c44183e7-44ae-4be3-bb47-517067a112b5@huaweicloud.com>
 <Y9Gyuj+2UFefUdJS@rowland.harvard.edu>
 <edadb690-e791-0e9c-e641-ea8876abe96e@huaweicloud.com>
 <Y9KkLHWzuIQ8sDwq@rowland.harvard.edu>
From:   Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
In-Reply-To: <Y9KkLHWzuIQ8sDwq@rowland.harvard.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LxC2BwD3eATbqtJjJCbMAA--.816S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAryrGry3trWUGr4rJry8AFb_yoW5Xw15pF
        W8tFWfAan8tr1S9r1I934rGry8t3yFqa9Fqrs8GF97J3s8Xr9xGr1xKw45uFy3Gw1fGFWa
        q3yrtF9xJ3s0yaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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



On 1/26/2023 5:02 PM, Alan Stern wrote:
> On Thu, Jan 26, 2023 at 12:30:14PM +0100, Jonas Oberhauser wrote:
>>
>> On 1/25/2023 11:52 PM, Alan Stern wrote:
>>> On Wed, Jan 25, 2023 at 10:04:29PM +0100, Jonas Oberhauser wrote:
>>>> On 1/25/2023 9:21 PM, Alan Stern wrote:
>>>>>     (* Validate nesting *)
>>>>>     flag ~empty Srcu-lock \ domain(srcu-rscs) as unmatched-srcu-lock
>>>>>     flag ~empty Srcu-unlock \ range(srcu-rscs) as unmatched-srcu-unlock
>>>>> +flag ~empty (srcu-rscs^-1 ; srcu-rscs) \ id as multiple-srcu-matches
>>>> [...]
>>>>>     // SRCU
>>>>> -srcu_read_lock(X)  __srcu{srcu-lock}(X)
>>>>> -srcu_read_unlock(X,Y) { __srcu{srcu-unlock}(X,Y); }
>>>>> +srcu_read_lock(X) __load{srcu-lock}(*X)
>>>>> +srcu_read_unlock(X,Y) { __store{srcu-unlock}(*X,Y); }
>>>>> +srcu_down_read(X) __load{srcu-lock}(*X)
>>>>> +srcu_up_read(X,Y) { __store{srcu-unlock}(*X,Y); }
>>>> How do you feel about introducing Srcu-up and Srcu-down with this patch?
>>> Why invent new classes for them?  They are literally the same operation
>>> as Srcu-lock and Srcu-unlock; the only difference is how the kernel's
>>> lockdep checker treats them.
>> I don't think they're necessarily implemented in a compatible way, so
>>
>> r = srcu_lock(s);
>> srcu_up(s,r);
>>
>> might not actually work, but would currently be ok'ed by LKMM.
> I'll let Paul answer this.
>
>>   With
>> different classes you could state
>>    flag ~empty [Srcu-lock];srcu-rscs;[Srcu-up] as srcu-mismatch-lock-to-up
>>    flag ~empty [Srcu-down];srcu-rscs;[Srcu-unlock] as
>> srcu-mismatch-down-to-unlock
>>
>> I think with the current implementation this code might work, but I don't
>> feel like this is inherently true.
>>
>> You could then also go ahead and define the "same CPU" requirement as a flag
>> for lock and unlock specifically, like
>>    flag ~empty [Srcu-lock];srcu-rscs & ext as srcu-lock-unlock-mismatch-CPU
>> or so.
> Bear in mind that the herd7 model is not obliged to find and warn about
> all possible bugs in a litmus test.  Especially if the same code would
> generate a warning or error when run in the kernel.

I  agree, and indeed it may not even possible to do so (even under a 
hypothetical formal proof that the list of bugs is complete, some might 
not be formalizable in a satisfactory way in herd).
Mostly I'm just trying to see if you have considered the possibilities 
and decided against them intentionally, or if you just hadn't considered 
it. I don't have a strong opinion either way and would be ok with the 
patch as written.

That said, I do like to think of the model as a kind of compact formal 
specification/documentation, including the assumptions the kernel makes 
about how these APIs are to be used.

Best wishes, jonas

