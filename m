Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 046566736AB
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 12:23:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbjASLXe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 06:23:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjASLXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 06:23:31 -0500
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E707E6DB33
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 03:23:28 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.229])
        by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4NyKmk3TWkz9v7H3
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 19:15:34 +0800 (CST)
Received: from [10.81.219.171] (unknown [10.81.219.171])
        by APP1 (Coremail) with SMTP id LxC2BwBHywYNKMljdbysAA--.3101S2;
        Thu, 19 Jan 2023 12:23:05 +0100 (CET)
Message-ID: <a2b89243-ddd7-c114-541f-0aff7806d217@huaweicloud.com>
Date:   Thu, 19 Jan 2023 12:22:50 +0100
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
 <114ECED5-FED1-4361-94F7-8D9BC02449B7> <Y8iqzJXVZX1lS7Kp@rowland.harvard.edu>
From:   Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
In-Reply-To: <Y8iqzJXVZX1lS7Kp@rowland.harvard.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LxC2BwBHywYNKMljdbysAA--.3101S2
X-Coremail-Antispam: 1UD129KBjvJXoWxKrWfXFyDZFWUCry5Wr43trb_yoWxZrWxpF
        W8Ka4qkFWkJrn29w1Iyw17XrWrZ34xGay7tFn5XF15Aw1Yqr9avr4Ygr4Y9asxurs3JrWj
        vw4Yq3sxZas8AaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/19/2023 3:28 AM, Alan Stern wrote:
> > This is a permanent error; I've given up. Sorry it didn't
> work out.

[It seems the e-mail still reached me through the mailing list]

> hopefully with just one main thought per email!  :-)

Honestly, I wish I could.  I'm already trying hard but sometimes things 
are interconnected, and my brain isn't good at withholding information 
-- including incorrect and incomprehensible information :D

>
> On Wed, Jan 18, 2023 at 12:25:05PM +0100, Jonas Oberhauser wrote:
>>
>> On 1/17/2023 10:19 PM, Alan Stern wrote:
>>> On Tue, Jan 17, 2023 at 06:48:12PM +0100, Jonas Oberhauser wrote:
>>>> Pretending for simplicity that rscs and grace periods aren't reads&writes
>>> They aren't.  You don't have to pretend.
>> rscs are reads& writes in herd. That's how the data dependency works in your
>> patch, right?
> No, you're mixing up RCU and SRCU.
Yes, I meant for the srcu : ) Any argument I'm trying to make just for 
rcu right now, will need to still work for srcu later.

>> I consider that a hack though and don't like it.
> It _is_ a bit of a hack, but not a huge one.  srcu_read_lock() really
> is a lot like a load, in that it returns a value obtained by reading
> something from memory (along with some other operations, though, so it
> isn't a simple straightforward read -- perhaps more like an
> atomic_inc_return_relaxed).
The issue I have with this is that it might create accidental ordering. 
How does it behave when you throw fences in the mix?
It really does not work like an increment at all, I think 
srcu_read_lock() only reads the currently active index, but the index is 
changed by srcu_sync. But even that is an implementation detail of 
sorts. I think the best way to think of it would be for srcu_read_lock 
to just return an arbitrary value.
The user can not rely on any kind of "accidental" rfe edges between 
these events for ordering.

Perhaps if you flag any use of these values in address or control 
dependencies, as well as any event which depends on more than one of 
these values, you could prove that it's impossible to contrain the 
behavior through these rfe(and/or co) edges because you can anyways 
never inspect the value returned by the operation (except to pass it 
into srcu_unlock).

Or you might be able to explicitly eliminate the events everywhere, just 
like you have done for carry-dep in your patch.

But it looks so brittle.



> srcu_read_unlock() is somewhat less like a store, but it does have one
> notable similarity: It takes an input value and therefore can be the
> target of a data dependency.  The biggest difference is that an
> srcu_read_unlock() can't really be read-from.  It would be nice if herd
> had an event type that behaved this way.
Or if you could declare your own : )
Obviously, you will have accidental rf edges going from 
srcu_read_unlock() to srcu_read_lock() if you model them this way.

> Also, herd doesn't have any way of saying that the value passed to a
> store is an unmodified copy of the value obtained by a load.  In our
> case that doesn't matter much -- nobody should be writing litmus tests
> in which the value returned by srcu_read_lock() is incremented and then
> decremented again before being passed to srcu_write_lock()!

It would be nice if herd allowed declaring structs that can be used for 
such purposes.
(anyways, I am not sure if Luc is still following everything in this 
deeply nested thread that started somewhere completely different. But 
maybe if Paul or you open a feature request, let me know so that I can 
give my 2ct)

> By golly, you're right!  I'm still thinking in terms of an older
> version of the memory model, which used gp in place of rcu-gp.

I'm glad I'm not the only person to mix these two up xP

>> Note that if your ordering relies on actually using gp twice in a row, then
>> these must come from strong-fence, but you should be able to just take the
>> shortcut by merging them into a single gp.
>>    po;rcu-gp;po;rcu-gp;po <= gp <= strong-fence <= hb & strong-order
> I don't know what you mean by this.  The example above does rely on
> having two synchronize_rcu() calls; with only one it would be allowed.

I mean that if you have a cycle that is formed by having two adjacent 
actual `gp` edges, like .... ; gp;gp ; ....  with gp= po ; rcu-gp ; po?,
(not like your example, where the cycle uses two *rcu*-gp but no gp 
edges) and assume we define gp' = po ; rcu-gp ; po and hb' and pb' to 
use gp' instead of gp,
then there are two cases for how that cycle came to be, either 1) as
  ... ; hb;hb ; ....
but then you can refactor as
  ... ; po;rcu-gp;po;rcu-gp;po ; ...
  ... ; po;rcu-gp;     po      ; ...
  ... ;         gp'            ; ...
  ... ;         hb'            ; ...
which again creates a cycle, or 2) as
   ... ; pb ; hb ; ...
coming from
   ... ; prop ; gp ; gp ; ....
which you can similarly refactor as
   ... ; prop ; po;rcu-gp;po ; ....
   ... ; prop ;      gp'     ; ....
and again get a cycle with
... ; pb' ; ....
Therefore, gp = po;rcu-gp;po should be equivalent.

>>>> I don't think rcu-order is necessary at all to define LKMM, and one can
>>>> probably just use rcu-extend instead of rcu-order (and in fact even a
>>>> version of rcu-extend without any lone rcu-gps).
>>> Sure, you could do that, but it wouldn't make sense.  Why would anyone
>>> want to define an RCU ordering relation that includes
>>>
>>> 	gp ... rscs ... gp ... rscs
>>>
>>> but not
>>>
>>> 	gp ... rscs ... rscs ... gp
>>>
>>> ?
>> Because the the RCU Grace Period Guarantee doesn't say "if a gp happens
>> before a gp, with some rscs in between, ...".
>> So I think even the picture is not the best picture to draw for RCU
>> ordering. I think the right picture to draw for RCU ordering is something
>> like this:
>>      case (1): C ends before G does:
>>
>> 	rcsc ... ... ... ... ... gp
>>
>>    case (2): G ends before C does:
>>
>> 	gp ... ... ... ... ... rscs
>>
>> where the dots are some relation that means "happens before".
> Okay.  So we could define rcu-order by:
>
> let rec rcu-order = (rcu-gp ; rcu-link ; (rcu-order ; rcu-link)* ; rcu-rscsi) |
> 	(rcu-rscsi ; rcu-link ; (rcu-order ; rcu-link)* ; rcu-gp)
>
> (ignoring the SRCU cases).  That is a little awkward; it might make
> sense to factor out (rcu-link ; (rcu-order ; rcu-link)*) as a separate
> relation and do a simultaneous recursion on both relations.

Exactly!

> But either way, rcu-fence would have to be defined as (po ; rcu-order+ ; po?),
> which looks a little odd.

Almost, (assuming the rb definition is changed to be like the pb one*) 
it would be

       rcu-fence = (po ; (rcu-order ; po)+).

Alernatively, I believe (but haven't fully confirmed) it would also work to define
       rcu-fence = po ; rcu-order ; po?


This is why I am wondering whether
	order = po ; {inducing operation} ; po?
is ok in general or not.


Have fun,
jonas

(*= otherwise you'd need to include the rcu-link in here as well)

