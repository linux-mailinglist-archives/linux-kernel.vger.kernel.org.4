Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6F30679E0B
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 16:55:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234070AbjAXPzb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 10:55:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233993AbjAXPz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 10:55:26 -0500
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D70664A1D9
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 07:55:21 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.228])
        by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4P1WYz1bqJz9xqnb
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 23:47:19 +0800 (CST)
Received: from [10.48.129.122] (unknown [10.48.129.122])
        by APP1 (Coremail) with SMTP id LxC2BwD3ewdF_89jGUbDAA--.14197S2;
        Tue, 24 Jan 2023 16:54:57 +0100 (CET)
Message-ID: <280fb8f6-f1fd-76ce-7851-cf720820c44e@huaweicloud.com>
Date:   Tue, 24 Jan 2023 16:54:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: Internal vs. external barriers (was: Re: Interesting LKMM litmus
 test)
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     "paulmck@kernel.org" <paulmck@kernel.org>,
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
 <114ECED5-FED1-4361-94F7-8D9BC02449B7> <Y8lynRI35cFeuqb5@rowland.harvard.edu>
From:   Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
In-Reply-To: <Y8lynRI35cFeuqb5@rowland.harvard.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LxC2BwD3ewdF_89jGUbDAA--.14197S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Aw18uF48WryrCry5WF17KFg_yoW8uw17pF
        WkKayktF4xKw1v9rn7Aw4I9w4xAa1xZ3W3Jrn5Gw4xX3s8JF9ayw4xKFWYvFykWryIyw4j
        vr1qg34DXas8AaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvSb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
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
        67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43
        ZEXa7IU13rcDUUUUU==
X-CM-SenderInfo: 5mrqt2oorev25kdx2v3u6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/19/2023 5:41 PM, Alan Stern wrote:
> On Thu, Jan 19, 2023 at 12:22:50PM +0100, Jonas Oberhauser wrote:
>>
>> On 1/19/2023 3:28 AM, Alan Stern wrote:
>>>> This is a permanent error; I've given up. Sorry it didn't
>>> work out.
>> [It seems the e-mail still reached me through the mailing list]
> [For everyone else, Jonas is referring to the fact that the last two
> emails I sent to his huaweicloud.com address could not be delivered, so
> I copied them off-list to his huawei.com address.]
>
>>>> I consider that a hack though and don't like it.
>>> It _is_ a bit of a hack, but not a huge one.  srcu_read_lock() really
>>> is a lot like a load, in that it returns a value obtained by reading
>>> something from memory (along with some other operations, though, so it
>>> isn't a simple straightforward read -- perhaps more like an
>>> atomic_inc_return_relaxed).
>> The issue I have with this is that it might create accidental ordering. How
>> does it behave when you throw fences in the mix?
> I think this isn't going to be a problem.  Certainly any real
> implementation of scru_read_lock() is going to involve some actual load
> operations, so any unintentional ordering caused by fences will also
> apply to real executions.  Likewise for srcu_read_unlock and store
> operations.

Note that there may indeed be reads in the implementation, but most 
likely not from the srcu_read_unlock()s of other threads. Most probably 
from the synchronize_srcu() calls. So the rfe edges being added are 
probably not corresponding to any rfe edges in the implementation.

That said, I believe there may indeed not be any restrictions in 
behavior caused by this, because any code that relies on the order being 
a certain thing would need to use some other ordering mechanism, and 
that would probably restrict the behavior anyways.

It does have the negative side-effect of creating an explosion of 
permutations though, by ordering all unlocks() in a total way and also 
sometimes allowing multiple options for each lock() (e.g., 
lock();unlock() || lock();unlock()  has 4 executions instead of 1).

Anyways, not much to be done about it right now.

best wishes, jonas

