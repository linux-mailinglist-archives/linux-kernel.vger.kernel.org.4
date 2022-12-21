Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10976653404
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 17:31:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234581AbiLUQak (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 11:30:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233016AbiLUQah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 11:30:37 -0500
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9978F23BC5;
        Wed, 21 Dec 2022 08:30:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1671640233;
        bh=r4HjUR3ibF30w+11NPYLmcKi3ymguCvxvHZK2X7qefU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=MQTkUCVgWOJnNSf3M5hdebbCIIClLz8Gr2MAyNwA8hx7evEAjBQs+SyGQQoJ8ScUo
         ld4WPu3VW524hgLapnAsCxQuSwRjjbl+3AYUwU4EUTptz7IiKMJ7fGIMPlmptwdemj
         DUdg4/d7WSl0mrRQ4+10BeJJo+kapeqs0bi/holP2/eyWNSylFfWkNT4GvIjhXomcF
         90KOASri+Zuw4ctcTTKBq3apsZIOP6seMx+ysAIBmviCxvLS36SubDSzMpYwYFQU7i
         xykwbTbHCttHA33mFpQDMBLPMyzEieWPiHaxM7DgFdq+li3HdQSYodGBM4pN1OzFqO
         WqDYKKojXFC/Q==
Received: from [10.1.0.30] (192-222-188-97.qc.cable.ebox.net [192.222.188.97])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4Ncf7Y2xpzzc12;
        Wed, 21 Dec 2022 11:30:33 -0500 (EST)
Message-ID: <9586cbdf-4525-412b-3a53-c0041d171149@efficios.com>
Date:   Wed, 21 Dec 2022 11:30:58 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [RFC 0/2] srcu: Remove pre-flip memory barrier
Content-Language: en-US
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
References: <f4199d1f-306c-681f-8bb9-26d66ecf5121@efficios.com>
 <6BD506EA-77D2-4AC9-87A5-C8781594CF0F@joelfernandes.org>
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <6BD506EA-77D2-4AC9-87A5-C8781594CF0F@joelfernandes.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-12-20 23:26, Joel Fernandes wrote:
> 
> 
>> On Dec 20, 2022, at 10:43 PM, Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
>>
>> ﻿On 2022-12-20 19:58, Frederic Weisbecker wrote:
>>>> On Wed, Dec 21, 2022 at 01:49:57AM +0100, Frederic Weisbecker wrote:
>>>> On Tue, Dec 20, 2022 at 07:15:00PM -0500, Joel Fernandes wrote:
>>>>> On Tue, Dec 20, 2022 at 5:45 PM Frederic Weisbecker <frederic@kernel.org> wrote:
>>>>> Agreed about (1).
>>>>>
>>>>>> _ In (2), E pairs with the address-dependency between idx and lock_count.
>>>>>
>>>>> But that is not the only reason. If that was the only reason for (2),
>>>>> then there is an smp_mb() just before the next-scan post-flip before
>>>>> the lock counts are read.
>>>>
>>>> The post-flip barrier makes sure the new idx is visible on the next READER's
>>>> turn, but it doesn't protect against the fact that "READ idx then WRITE lock[idx]"
>>>> may appear unordered from the update side POV if there is no barrier between the
>>>> scan and the flip.
>>>>
>>>> If you remove the smp_mb() from the litmus test I sent, things explode.
>>> Or rather, look at it the other way, if there is no barrier between the lock
>>> scan and the index flip (E), then the index flip can appear to be written before the
>>> lock is read. Which means you may start activating the index before you finish
>>> reading it (at least it appears that way from the readers pont of view).
>>
>> Considering that you can have pre-existing readers from arbitrary index appearing anywhere in the grace period (because a reader can fetch the
>> index and be preempted for an arbitrary amount of time before incrementing the lock count), the grace period algorithm needs to deal with the fact that a newcoming reader can appear in a given index either before or after the flip.
>>
>> I don't see how flipping the index before or after loading the unlock/lock values would break anything (except for unlikely counter overflow situations as previously discussed).
> 
> If you say unlikely, that means it can happen some times which is bad enough ;-). Maybe you mean impossible.

I mean that if we have a synchronize_srcu preemption long enough to get 
2^32 or 2^64 concurrent srcu read-side critical sections, I strongly 
suspect that RCU stall detection will yell loudly. And if it does not 
already, then we should make it so.

So I mean "impossible unless the system is already unusable", rather 
than just "unlikely".

Thanks,

Mathieu

> I would not settle for anything less than keeping the memory barrier around if it helps unlikely cases, but only D does help for the theoretical wrapping/overflow issue. E is broken and does not even help the theoretical issue IMO. And both D and E do not affect correctness IMO.
> 
> Anyway in all likelihood, I will be trying to remove E completely and clarify docs on D in the coming weeks. And also try to drop the size of the counters per our discussions
> 
> Thanks.
> 
> 
> 
>>
>> Thanks,
>>
>> Mathieu
>>
>> -- 
>> Mathieu Desnoyers
>> EfficiOS Inc.
>> https://www.efficios.com
>>

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

