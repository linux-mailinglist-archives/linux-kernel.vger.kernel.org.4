Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60D81709944
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 16:15:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231978AbjESOP2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 10:15:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231653AbjESOPV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 10:15:21 -0400
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AEF21A5;
        Fri, 19 May 2023 07:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1684505706;
        bh=hrLDk4Ku/N+Gf0DGHxR5oOwcJE4ZzrE2JYuRc9BDUc8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=LU9/QsjsSej9UKNksRhmw8R7x+3+sG/kDctrb20XugRuqs4Yp1tAnZUJr8XBZe01J
         9iOrpxuZxLSE2nERz3Zf4UfjMSo1NOOPWzOpZ3eBhzWX+sPkvaa62fRsu+zjf16Smu
         rcl7010x+KL0IdFivUfiLbTA0HNQvVieMRQwkZvTlXJadxkHZkPr+uYmeSqomaQVnI
         DHzJooY08xYC9Av03nPl8IR6geSxNobN0v4fAHrWhR4BbcbWhh9Zszim/DbZE5TPik
         Oss5BmD17Y3Y7RvquNS5MJtTNBQGHndpQT6ph+GGTGPxvwI/GyqaDMpCHSi8fW/xAe
         Cv/O9GxYUkVOw==
Received: from [192.168.18.200] (unknown [198.16.236.227])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4QN84V0J5Tz13HD;
        Fri, 19 May 2023 10:15:06 -0400 (EDT)
Message-ID: <06ee47e0-99e0-4b6a-ab67-239fccf2777d@efficios.com>
Date:   Fri, 19 May 2023 10:15:11 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [RFC PATCH 1/4] rseq: Add sched_state field to struct rseq
Content-Language: en-US
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
        Florian Weimer <fw@deneb.enyo.de>, David.Laight@aculab.com,
        carlos@redhat.com, Peter Oskolkov <posk@posk.io>,
        Alexander Mikhalitsyn <alexander@mihalicyn.com>,
        Chris Kennelly <ckennelly@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@igalia.com>,
        libc-alpha@sourceware.org, Steven Rostedt <rostedt@goodmis.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Florian Weimer <fweimer@redhat.com>
References: <20230517152654.7193-1-mathieu.desnoyers@efficios.com>
 <20230517152654.7193-2-mathieu.desnoyers@efficios.com>
 <ZGaddGcHw7nJE+Gh@boqun-archlinux>
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <ZGaddGcHw7nJE+Gh@boqun-archlinux>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-05-18 17:49, Boqun Feng wrote:
> On Wed, May 17, 2023 at 11:26:51AM -0400, Mathieu Desnoyers wrote:
[...]
>> diff --git a/include/uapi/linux/rseq.h b/include/uapi/linux/rseq.h
>> index c233aae5eac9..c6d8537e23ca 100644
>> --- a/include/uapi/linux/rseq.h
>> +++ b/include/uapi/linux/rseq.h
>> @@ -37,6 +37,13 @@ enum rseq_cs_flags {
>>   		(1U << RSEQ_CS_FLAG_NO_RESTART_ON_MIGRATE_BIT),
>>   };
>>   
>> +enum rseq_sched_state {
>> +	/*
>> +	 * Task is currently running on a CPU if bit is set.
>> +	 */
>> +	RSEQ_SCHED_STATE_ON_CPU		= (1U << 0),
>> +};
[...]
>>   
>> +	/*
>> +	 * Restartable sequences sched_state field. Updated by the kernel. Read
>> +	 * by user-space with single-copy atomicity semantics. This fields can
>> +	 * be read by any userspace thread. Aligned on 32-bit. Contains a
> 
> Maybe this is a premature optimization, but since most of the time the
> bit would be read by another thread, does it make sense putting the
> "sched_state" into a different cache line to avoid false sharing?

I'm puzzled by your optimization proposal, so I'll say it outright: I'm 
probably missing something.

I agree that false-sharing would be an issue if various threads would 
contend for updating any field within this cache line.

But the only thread responsible for updating this cache line's fields is 
the current thread, either from userspace (stores to rseq_abi->rseq_cs) 
or from the kernel (usually on return to userspace, except for this new 
ON_CPU bit clear on context switch).

The other threads busy-waiting on the content of this sched_state field 
will only load from it, never store. And they will only busy-wait on it 
as long as the current task runs. When that task gets preempted, other 
threads will notice the flag change and use sys_futex instead.

So the very worse I can think of in terms of pattern causing cache 
coherency traffic due to false-sharing is if the lock owner happens to 
have lots of rseq critical sections as well, causing it to repeatedly 
store to the rseq_abi->rseq_cs field, which is in the same cache line.

But even then I'm wondering if this really matters, because each of 
those stores to rseq_cs would only slow down loads from other threads 
which will need to retry busy-wait anyway if the on-cpu flag is still set.

So, what am I missing ? Is this heavy use of rseq critical sections 
while the lock is held the scenario you are concerned about ?

Note that the heavy cache-line bouncing in my test-case happens on the 
lock structure (cmpxchg expecting NULL, setting the current thread 
rseq_get_abi() pointer on success). There are probably better ways to 
implement that part, it is currently just a simple prototype showcasing 
the approach.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

