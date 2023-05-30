Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F03C87166BF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 17:13:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231978AbjE3PNl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 11:13:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230404AbjE3PNj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 11:13:39 -0400
Received: from smtpout.efficios.com (unknown [IPv6:2607:5300:203:b2ee::31e5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9EF9C5;
        Tue, 30 May 2023 08:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1685459617;
        bh=hsFGav/0/u3lTU7+URVYstvkYkxZoD/CB/dNCylhnns=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=jm09fyBFvoCjveRnyfPnPAfPVbw6ZrQ0spA2iCWttSjGgkA8lPneETJ5r3u7synjR
         Wbp4x4LeMkk/+5wReXgE694Car5yilZcGdEBBf6q06jZo1AUorAuwJMo31VL84YqhE
         KfNOhfN9c2mTC6gSPLFw8/CwAObJDGnK4keYjV7B+vsGnMuKp3Xoy79HRCfzzjGK0p
         tme9osxoaoXXL9As8oCVQlj2ZmUqbvvB186PAzKo40AsYXtI4d+wtQXltFNwHEOx/h
         RZO6+UgR0WMZ4L35RSdeCmd/wDeL2CkJW9RkJQ3Cp6IAOcPdwYvCwk9Q4er/30sdD7
         5NFk936bpdwsQ==
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4QVwrw4h3pz16Q3;
        Tue, 30 May 2023 11:13:36 -0400 (EDT)
Message-ID: <c1064e76-70f8-4a5f-2624-95a1e2dc9d64@efficios.com>
Date:   Tue, 30 May 2023 11:13:41 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [RFC PATCH v2 1/4] rseq: Add sched_state field to struct rseq
Content-Language: en-US
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
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
        Noah Goldstein <goldstein.w.n@gmail.com>, longman@redhat.com,
        Olivier Dion <odion@efficios.com>
References: <20230529191416.53955-1-mathieu.desnoyers@efficios.com>
 <20230529191416.53955-2-mathieu.desnoyers@efficios.com>
 <87wn0r6id9.fsf@oldenburg.str.redhat.com>
 <2c421e36-a749-7dc3-3562-7a8cf256df3c@efficios.com>
 <87sfbew7ra.fsf@oldenburg.str.redhat.com>
 <b0416e8c-9b8f-9b25-dd0c-3b7882e5746f@efficios.com>
In-Reply-To: <b0416e8c-9b8f-9b25-dd0c-3b7882e5746f@efficios.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/30/23 10:25, Mathieu Desnoyers wrote:
> On 5/30/23 04:20, Florian Weimer wrote:
[...]
>>
>> The challenge is that once we put stuff at fixed offsets, we can't
>> transparently fix it later.  It would need more auxv entries with
>> further offsets, or accessing this data through some indirection,
>> perhaps via vDSO helpers.
> 
> Perhaps this is more flexibility/complexity than we really need. One 
> possible approach would be to split struct rseq into sub-structures, e.g.:
> 
> rseq_len = overall size of all sub-structures.
> auxv AT_RSEQ_ALIGN = 256
> 
> auxv AT_RSEQ_FEATURE_SIZE = size of first portion of struct rseq,
>                              at most 256 bytes, meant to contain fields
>                              stored/loaded from the thread doing the
>                              registration.
> auxv AT_RSEQ_SHARED_FEATURE_SIZE =
>                              size of 2nd portion of struct rseq,
>                              starts at offset 256, at most 256 bytes,
>                              meant to contain fields stored/loaded by
>                              any thread.
> 
> Then we have this layout:
> 
> struct rseq {
>    struct rseq_local {
>      /* Fields accessed from local thread. */
> 
>    } __attribute__((aligned((256));
>    struct rseq_shared {
>      /* Shared fields. */
> 
>    } __attribute__((aligned(256));
> } __attribute__((aligned(256));
> 
> And if someday AT_RSEQ_FEATURE_SIZE needs to grow over 256 bytes
> (32 * u64), we can still extend with a new auxv entry after the "shared"
> features.

Actually, after giving it some more thoughts, I think we can do better:

- Add a sys_rseq() rseq_flag RSEQ_FLAG_SHARED, which changes the 
behavior of sys_rseq() to expect an additional "struct rseq_shared *" 
argument.

- Introduce auxv AT_RSEQ_SHARED_FEATURE_SIZE.

This way, it's up to the libc to decide how to allocate its private vs 
shared rseq structures.

The auxv "AT_RSEQ_ALIGN" would dictate the minimal alignment required 
for both private and shared rseq structures.

I don't think we need to express the size of the rseq_shared memory area 
allocated by libc because we know that it needs to be large enough to 
handle the shared feature size.

Thoughts ?

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

