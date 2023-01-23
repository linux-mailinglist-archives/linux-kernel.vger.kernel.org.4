Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8C0B67873C
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 21:07:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232686AbjAWUHg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 15:07:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232824AbjAWUHe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 15:07:34 -0500
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E1767281
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 12:07:31 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.228])
        by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4P11CS2Bvfz9v7ZH
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 03:59:32 +0800 (CST)
Received: from [10.81.216.232] (unknown [10.81.216.232])
        by APP2 (Coremail) with SMTP id GxC2BwBHG2Lg6M5j5sa9AA--.11637S2;
        Mon, 23 Jan 2023 21:07:07 +0100 (CET)
Message-ID: <d1a576ee-4af4-6053-8ae2-dc04fdd1b73b@huaweicloud.com>
Date:   Mon, 23 Jan 2023 21:06:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: Internal vs. external barriers (was: Re: Interesting LKMM litmus
 test)
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Jonas Oberhauser <jonas.oberhauser@huawei.com>,
        "paulmck@kernel.org" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "parri.andrea" <parri.andrea@gmail.com>, will <will@kernel.org>,
        "boqun.feng" <boqun.feng@gmail.com>, npiggin <npiggin@gmail.com>,
        dhowells <dhowells@redhat.com>,
        "j.alglave" <j.alglave@ucl.ac.uk>,
        "luc.maranget" <luc.maranget@inria.fr>, akiyks <akiyks@gmail.com>,
        dlustig <dlustig@nvidia.com>, joel <joel@joelfernandes.org>,
        urezki <urezki@gmail.com>,
        quic_neeraju <quic_neeraju@quicinc.com>,
        frederic <frederic@kernel.org>,
        Kernel development list <linux-kernel@vger.kernel.org>
References: <20220921173109.GA1214281@paulmck-ThinkPad-P17-Gen-1>
 <YytfFiMT2Xsdwowf@rowland.harvard.edu>
 <YywXuzZ/922LHfjI@hirez.programming.kicks-ass.net>
 <114ECED5-FED1-4361-94F7-8D9BC02449B7> <Y87m5KcSaieYZyeM@rowland.harvard.edu>
From:   Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
In-Reply-To: <Y87m5KcSaieYZyeM@rowland.harvard.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GxC2BwBHG2Lg6M5j5sa9AA--.11637S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Ww43ZFWrAFy7tr1xWrW5Awb_yoW8XrWkpF
        yvkay3tF97Aryq9a1kCrWIq3ZrZ393tryktF48C3yfG3sYqrna9F4ftrWrua43Jr4fuw1j
        vw4Yq3WkXF1UuFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
        e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
        Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a
        6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
        kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVW3JVWrJr1lIxAIcVC2z280aVAF
        wI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf
        9x07UuBT5UUUUU=
X-CM-SenderInfo: 5mrqt2oorev25kdx2v3u6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/23/2023 8:58 PM, Alan Stern wrote:
> On Mon, Jan 23, 2023 at 05:16:27PM +0100, Jonas Oberhauser wrote:
>> On 1/19/2023 5:41 PM, Alan Stern wrote:
>>
>>> But when you're comparing grace periods or critical sections to each other,
>>> things get a little ambiguous.  Should G1 be considered to come before
>>> G2 when t1(G1) < t1(G2), when t2(G1) < t2(G2), or when t2(G1) < t1(G2)?
>>> Springing for (po ; rcu-order ; po?) amounts to choosing the second
>>> alternative.
>> Aha, I see! Powerful notation indeed.
>> Keeping that in mind, wouldn't it make sense for pb also be changed to
>> `...;po?` ?
> You mean changing the definition of pb to either:
>
> 	prop ; strong-fence ; hb* ; po? ; [Marked]
>
> or
>
> 	prop ; strong-fence ; hb* ; [Marked] ; po? ; [Marked]

Oh no, not at all!

I mean that
     pb = prop ; po ; {strong ordering-operation} ; po ; hb* ; [Marked]
could instead be
     pb = prop ; po ; {strong ordering-operation} ; po? ; hb* ; [Marked]

(note that the po ; ... ; po part is actually folded inside the actual 
definition of strong fence).

> rcu-fence is different because rcu-order has to begin and end with
> either a grace period or a critical section, and both of these restrict
> the execution order of surrounding events:
>
> 	If X is a synchronize_rcu() or rcu_read_unlock() then events
> 	po-before X must execute before X;
>
> 	If X is a synchronize_rcu() or rcu_read_lock() then events
> 	po-after X must execute after X.
>
I believe so do the strong ordering-operations in pb.
best wishes, jonas

