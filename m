Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CC2771640D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 16:27:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231222AbjE3O1T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 10:27:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232807AbjE3O0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 10:26:45 -0400
Received: from smtpout.efficios.com (unknown [IPv6:2607:5300:203:b2ee::31e5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11E69185;
        Tue, 30 May 2023 07:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1685456753;
        bh=zQFMqgeJEIzUkXswfFG74lqXIFcfTl769xcbWLTmtPQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=TkJpvX5hE+zqJJKFYfzGTlSePN6C+Ib06dBr+3x8biQBUmMUfZwfOExsv4ygsJ6qk
         umaIb6YpfLLcECDC4OzVF6FZ182LtmWh/9QSzw5Nps+pqFItnxYJAwtRYLR0JY4K4c
         F2qfD8xA5gafM1kgXCBFIkl+SmtUd41bUZv9OGMU7ASZofLs5yeZP+O8H8tfy6Xt32
         0xToXURYv4gPWY2uVnXX7dCtsSQFCq0msr2CiqnkU8xe5AlI33t4f9Tg+ZA079RfT4
         qET8AVlCG4YaNJL4T32n36HmP7LkRraQ16SXuDPQBicLaNif7q+heuR2pvYHX1cNYb
         usJhKxzbSYeXA==
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4QVvns2fv1z16Kd;
        Tue, 30 May 2023 10:25:53 -0400 (EDT)
Message-ID: <b0416e8c-9b8f-9b25-dd0c-3b7882e5746f@efficios.com>
Date:   Tue, 30 May 2023 10:25:57 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [RFC PATCH v2 1/4] rseq: Add sched_state field to struct rseq
Content-Language: en-US
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
        Noah Goldstein <goldstein.w.n@gmail.com>, longman@redhat.com
References: <20230529191416.53955-1-mathieu.desnoyers@efficios.com>
 <20230529191416.53955-2-mathieu.desnoyers@efficios.com>
 <87wn0r6id9.fsf@oldenburg.str.redhat.com>
 <2c421e36-a749-7dc3-3562-7a8cf256df3c@efficios.com>
 <87sfbew7ra.fsf@oldenburg.str.redhat.com>
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <87sfbew7ra.fsf@oldenburg.str.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/30/23 04:20, Florian Weimer wrote:
> * Mathieu Desnoyers:
> 
>>> I don't see why we can't stick this directly into struct rseq because
>>> it's all public anyway.
>>
>> The motivation for moving this to a different cache line is to handle
>> the prior comment from Boqun, who is concerned that busy-waiting
>> repeatedly loading a field from struct rseq will cause false-sharing
>> and make other stores to that cache line slower, especially stores to
>> rseq_cs to begin rseq critical sections, thus slightly increasing the
>> overhead of rseq critical sections taken while mutexes are held.
> 
> Hmm.  For context, in glibc, we have to place struct rseq on a fixed
> offset from the start of a page (or even some larger alignment) for all
> threads.  In the future (once we move the thread control block off the
> top of the userspace stack, where it resides since the LinuxThreads
> days), it is likely that the pointer difference between different
> threads will also be a multiple of a fairly large power of two
> (something like 2**20 might be common).  Maybe this will make caching
> even more difficult?
> 
>> If we want to embed this field into struct rseq with its own cache
>> line, then we need to add a lot of padding, which is inconvenient.
>>
>> That being said, perhaps this is premature optimization, what do you
>> think ?
> 
> Maybe?  I don't know how the access patterns will look like.  But I
> suspect that once we hit this case, performance will not be great
> anyway, so the optimization is perhaps unnecessary?

What I dislike though is that contention for any lock which busy-waits 
on the rseq sched_state would slow down all rseq critical sections of 
that thread, which is a side-effect we want to avoid.

I've done some more additional benchmarks on my 8-core AMD laptop, and I 
notice that things get especially bad whenever the store to 
rseq_abi->rseq_cs is surrounded by other instructions that need to be 
ordered with that store, e.g. a for loop doing 10 stores to a local 
variables. If it's surrounded by instructions that don't need to be 
ordered wrt that store (e.g. a for loop of 10 iterations issuing 
barrier() "memory" asm clobbers), then the overhead cannot be noticed 
anymore.

> 
> The challenge is that once we put stuff at fixed offsets, we can't
> transparently fix it later.  It would need more auxv entries with
> further offsets, or accessing this data through some indirection,
> perhaps via vDSO helpers.

Perhaps this is more flexibility/complexity than we really need. One 
possible approach would be to split struct rseq into sub-structures, e.g.:

rseq_len = overall size of all sub-structures.
auxv AT_RSEQ_ALIGN = 256

auxv AT_RSEQ_FEATURE_SIZE = size of first portion of struct rseq,
                             at most 256 bytes, meant to contain fields
                             stored/loaded from the thread doing the
                             registration.
auxv AT_RSEQ_SHARED_FEATURE_SIZE =
                             size of 2nd portion of struct rseq,
                             starts at offset 256, at most 256 bytes,
                             meant to contain fields stored/loaded by
                             any thread.

Then we have this layout:

struct rseq {
   struct rseq_local {
     /* Fields accessed from local thread. */

   } __attribute__((aligned((256));
   struct rseq_shared {
     /* Shared fields. */

   } __attribute__((aligned(256));
} __attribute__((aligned(256));

And if someday AT_RSEQ_FEATURE_SIZE needs to grow over 256 bytes
(32 * u64), we can still extend with a new auxv entry after the "shared"
features.


> 
>>> The TID field would be useful in its own right.
>>
>> Indeed, good point.
>>
>> While we are there, I wonder if we should use the thread_pointer() as
>> lock identifier, or if the address of struct rseq is fine ?
> 
> Hard to tell until we'll see what the futex integration looks like, I
> think.

Good point. I can choose one way or another for the prototype, and then 
we'll see how things go with futex integration.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

