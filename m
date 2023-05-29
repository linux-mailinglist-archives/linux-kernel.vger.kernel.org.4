Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DADA1714FF1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 21:48:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbjE2Ts4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 15:48:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjE2Tsx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 15:48:53 -0400
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB2B7E3;
        Mon, 29 May 2023 12:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1685389720;
        bh=5Mv2iDY3/+/X26c7+oJN7S46E47FDbIxA4JnvM9t6LA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=qKqixCkAmWIZJ9ueg9iXOFyyyfKXkToaxYQMR+WimJXBFlbMcwJuEg+tmoKI945V/
         mhJsQKx2+spbbY875mXg3wdgD8FXxk1bu6lUNEB+e3J9yvuolZLaiNwBNmdf3RBkeJ
         BzD9jSp3prSUR0xoR30cSVbOwVKr73F9l7+ElQcx+rtwbHfPZCul1aFmnZf3FSH8FE
         6U2UsMFuDNKS56jUbBmF4RAQ20wsqomYBc+HXP4pYFmDhY2fNs2zAVYZzA6obWsff5
         NG8fCnmKYzx9K+yyIl/U+E373NqF63Z5zoiUl1SLV6xLIwjgvr88WG21kDJOpsqxEk
         e8txGroYFlKyQ==
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4QVR0m1cVFz15tr;
        Mon, 29 May 2023 15:48:40 -0400 (EDT)
Message-ID: <2c421e36-a749-7dc3-3562-7a8cf256df3c@efficios.com>
Date:   Mon, 29 May 2023 15:48:44 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [RFC PATCH v2 1/4] rseq: Add sched_state field to struct rseq
To:     Florian Weimer <fweimer@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
        David.Laight@ACULAB.COM, carlos@redhat.com,
        Peter Oskolkov <posk@posk.io>,
        Alexander Mikhalitsyn <alexander@mihalicyn.com>,
        Chris Kennelly <ckennelly@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@igalia.com>,
        libc-alpha@sourceware.org, Steven Rostedt <rostedt@goodmis.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Noah Goldstein <goldstein.w.n@gmail.com>,
        Daniel Colascione <dancol@google.com>, longman@redhat.com
References: <20230529191416.53955-1-mathieu.desnoyers@efficios.com>
 <20230529191416.53955-2-mathieu.desnoyers@efficios.com>
 <87wn0r6id9.fsf@oldenburg.str.redhat.com>
Content-Language: en-US
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <87wn0r6id9.fsf@oldenburg.str.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/29/23 15:35, Florian Weimer wrote:
> * Mathieu Desnoyers:
> 
>> +/*
>> + * rseq_sched_state should be aligned on the cache line size.
>> + */
>> +struct rseq_sched_state {
>> +	/*
>> +	 * Version of this structure. Populated by the kernel, read by
>> +	 * user-space.
>> +	 */
>> +	__u32 version;
>> +	/*
>> +	 * The state is updated by the kernel. Read by user-space with
>> +	 * single-copy atomicity semantics. This field can be read by any
>> +	 * userspace thread. Aligned on 32-bit. Contains a bitmask of enum
>> +	 * rseq_sched_state_flags. This field is provided as a hint by the
>> +	 * scheduler, and requires that the page holding this state is
>> +	 * faulted-in for the state update to be performed by the scheduler.
>> +	 */
>> +	__u32 state;
>> +	/*
>> +	 * Thread ID associated with the thread registering this structure.
>> +	 * Initialized by user-space before registration.
>> +	 */
>> +	__u32 tid;
>> +};
> 
> How does the version handshake protocol in practice?  Given that this
> user-allocated?

Good point, I must admit that I have not thought this specific version 
protocol through. :) As you say, userspace is responsible for 
allocation, and the kernel is responsible for implementing features.

Let's first see if we can get away with embedding these fields in struct 
rseq.

> 
> I don't see why we can't stick this directly into struct rseq because
> it's all public anyway.

The motivation for moving this to a different cache line is to handle 
the prior comment from Boqun, who is concerned that busy-waiting 
repeatedly loading a field from struct rseq will cause false-sharing and 
make other stores to that cache line slower, especially stores to 
rseq_cs to begin rseq critical sections, thus slightly increasing the 
overhead of rseq critical sections taken while mutexes are held.

If we want to embed this field into struct rseq with its own cache line, 
then we need to add a lot of padding, which is inconvenient.

That being said, perhaps this is premature optimization, what do you think ?

> 
> The TID field would be useful in its own right.

Indeed, good point.

While we are there, I wonder if we should use the thread_pointer() as 
lock identifier, or if the address of struct rseq is fine ?

Thanks,

Mathieu

> 
> Thanks,
> Florian
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

