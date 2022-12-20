Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13DC9652612
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 19:13:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233716AbiLTSNk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 13:13:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231638AbiLTSNi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 13:13:38 -0500
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCD52FD5;
        Tue, 20 Dec 2022 10:13:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1671560015;
        bh=PeVvyGS6MVyRwG704+tnWCDsPqrngVfhXtM8AuLKXms=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ee9nivXnI0kdtqFaTVTCwD1LfrS/vLM6j46f3NKrmEpEaj+nHtPJlgoqq88uhRm+D
         Cr4n/fTt9bt796Gkv9c/UQR1YiI1hoMPwxfqJPwJ8FsjSk9SpDe3c95qAXkN4z3VC1
         eZW0e8YNU6vB64shL827BGX/qEqMCHmT12kFtD36qAgrxR70jw96X/O/HXkUoX+OIV
         WqPUUyFKHHLxHHSsRgO0RaCQO7ZLlMAJg5w28qlCmFkMcFai5+dpwycPxLlpLLNqp6
         oxCg9XfZZ0Wplb8JrZf5BOKTMWQ+mKagGv+gxLodyGjuvQDUgEL6ZM4IvAjvAcUVpN
         r6po7iibbiSQw==
Received: from [10.1.0.205] (192-222-188-97.qc.cable.ebox.net [192.222.188.97])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4Nc4Sv3vfvzbcW;
        Tue, 20 Dec 2022 13:13:35 -0500 (EST)
Message-ID: <6438d903-ab97-48c7-c338-9f0bc2686f94@efficios.com>
Date:   Tue, 20 Dec 2022 13:14:00 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [RFC 0/2] srcu: Remove pre-flip memory barrier
Content-Language: en-US
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
References: <20221218191310.130904-1-joel@joelfernandes.org>
 <589da7c9-5fb7-5f6f-db88-ca464987997e@efficios.com>
 <CAEXW_YQHpz3dNqW1ocqjr-e9qn09Rkg4kQ19byZORGbO18Xckg@mail.gmail.com>
 <2da94283-4fce-9aff-ac5d-ba181fa0f008@efficios.com>
 <CAEXW_YQBmwynuBOWbV6_L2itRr_i3BZUxQ91PDC2We2vXhpztQ@mail.gmail.com>
 <CAEXW_YTyZaE4ULvm-HygFN2BGm-jayHTbpnYbrJFoo_GOsYKQg@mail.gmail.com>
 <659763b0-eee4-10dd-5f4a-37241173809c@efficios.com>
 <CAEXW_YQ+NTaM43Va5FG8kYSxr2gsbjar4_f3xnpSAHzgUVZ-+g@mail.gmail.com>
 <CAEXW_YRqscm++0TP9bEnM0PQNLMe4cXFWAdRvHh2M5chERm+UA@mail.gmail.com>
 <35293ec4-40a1-cf6b-3bdd-0e3e30819c06@efficios.com>
 <CAEXW_YR194jzDQM7YZr0H8pDjhxUdymFbaheOGsMXq8judgGEQ@mail.gmail.com>
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <CAEXW_YR194jzDQM7YZr0H8pDjhxUdymFbaheOGsMXq8judgGEQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-12-20 13:05, Joel Fernandes wrote:
> Hi Mathieu,
> 
> On Tue, Dec 20, 2022 at 5:00 PM Mathieu Desnoyers
> <mathieu.desnoyers@efficios.com> wrote:
>>
>> On 2022-12-19 20:04, Joel Fernandes wrote:
>>> On Mon, Dec 19, 2022 at 7:55 PM Joel Fernandes <joel@joelfernandes.org> wrote:
> [...]
>>>>> On a 64-bit system, where 64-bit counters are used, AFAIU this need to
>>>>> be exactly 2^64 read-side critical sections.
>>>>
>>>> Yes, but what about 32-bit systems?
>>
>> The overflow indeed happens after 2^32 increments, just like seqlock.
>> The question we need to ask is therefore: if 2^32 is good enough for
>> seqlock, why isn't it good enough for SRCU ?
> 
> I think Paul said wrap around does happen with SRCU on 32-bit but I'll
> let him talk more about it. If 32-bit is good enough, let us also drop
> the size of the counters for 64-bit then?
> 
>>>>> There are other synchronization algorithms such as seqlocks which are
>>>>> quite happy with much less protection against overflow (using a 32-bit
>>>>> counter even on 64-bit architectures).
>>>>
>>>> The seqlock is an interesting point.
>>>>
>>>>> For practical purposes, I suspect this issue is really just theoretical.
>>>>
>>>> I have to ask, what is the benefit of avoiding a flip and scanning
>>>> active readers? Is the issue about grace period delay or performance?
>>>> If so, it might be worth prototyping that approach and measuring using
>>>> rcutorture/rcuscale. If there is significant benefit to current
>>>> approach, then IMO it is worth exploring.
>>
>> The main benefit I expect is improved performance of the grace period
>> implementation in common cases where there are few or no readers
>> present, especially on machines with many cpus.
>>
>> It allows scanning both periods (0/1) for each cpu within the same pass,
>> therefore loading both period's unlock counters sitting in the same
>> cache line at once (improved locality), and then loading both period's
>> lock counters, also sitting in the same cache line.
>>
>> It also allows skipping the period flip entirely if there are no readers
>> present, which is an -arguably- tiny performance improvement as well.
> 
> The issue of counter wrap aside, what if a new reader always shows up
> in the active index being scanned, then can you not delay the GP
> indefinitely? It seems like writer-starvation is possible then (sure
> it is possible also with preemption after reader-index-sampling, but
> scanning active index deliberately will make that worse). Seqlock does
> not have such writer starvation just because the writer does not care
> about what the readers are doing.

No, it's not possible for "current index" readers to starve the g.p. 
with the side-rcu scheme, because the initial pass (sampling both 
periods) only opportunistically skips flipping the period if there 
happens to be no readers in both periods.

If there are readers in the "non-current" period, the grace period waits 
for them.

If there are readers in the "current" period, it flips the period and 
then waits for them.

> 
> That said, the approach of scanning both counters does seem attractive
> for when there are no readers, for the reasons you mentioned. Maybe a
> heuristic to count the number of readers might help? If we are not
> reader-heavy, then scan both. Otherwise, just scan the inactive ones,
> and also couple that heuristic with the number of CPUs. I am
> interested in working on such a design with you! Let us do it and
> prototype/measure. ;-)

Considering that it would add extra complexity, I'm unsure what that 
extra heuristic would improve over just scanning both periods in the 
first pass.

I'll be happy to work with you on such a design :) I think we can borrow 
quite a few concepts from side-rcu for this. Please be aware that my 
time is limited though, as I'm currently supposed to be on vacation. :)

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

