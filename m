Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9830E69F931
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 17:41:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232518AbjBVQlV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 11:41:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232459AbjBVQlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 11:41:18 -0500
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8201F3CE0C
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 08:41:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1677084074;
        bh=fJmYDM90gZcR6wZ+gyoUWm1EtEJHno/IUjDohD2h0Aw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=fpLjjCHIlVtfQLKaj10Ruu9w8oxvdwiTnjImZTc+gFgnoOgckIEc2JSaHS8RzMUwA
         9PpSXGL6AZrYC5dVYjbOlSlooeb9LXLhJSi15OVYKrgvurT/zEbQCBqRO5aDRgRAHm
         5Zuo8vwKrSk9rNaIiSWNYyhJyd/weQXEK/29yDtM7pinKDovH9PXfwQ6kwfLFspruG
         VyYyjtowJqiD5rbfzkLFtYrAfkXzndujR4Yi7ZlCtzVGmVY/Zzv/y+4jL1grF1cs6h
         Pryk314bYOnnLcxDW3GGaX6Z4nA+sANWeTZYxxPnn5AfhIuOUbh26XcISjOySxDDDs
         hRJmmqISdkTkw==
Received: from [172.16.0.188] (192-222-180-24.qc.cable.ebox.net [192.222.180.24])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4PMMNn6X2gzmSt;
        Wed, 22 Feb 2023 11:41:13 -0500 (EST)
Message-ID: <d593fccb-aace-6611-c9c6-46049e2de817@efficios.com>
Date:   Wed, 22 Feb 2023 11:41:10 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: Official documentation from Intel stating that poking INT3
 (single-byte) concurrently is OK ?
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Olivier Dion <odion@efficios.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jiri Kosina <jkosina@suse.cz>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>
References: <786f4aed-2c30-806b-409b-23a60b3d7571@efficios.com>
 <20230221125032.0b02d309@gandalf.local.home>
 <5774aace-23f3-c53d-8e65-b90b588dbbe3@efficios.com>
 <Y/XecPdgpG0Cx+gX@hirez.programming.kicks-ass.net>
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <Y/XecPdgpG0Cx+gX@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,URI_DOTEDU autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-02-22 04:20, Peter Zijlstra wrote:
> On Tue, Feb 21, 2023 at 01:42:58PM -0500, Mathieu Desnoyers wrote:
>> On 2023-02-21 12:50, Steven Rostedt wrote:
>>> On Tue, 21 Feb 2023 11:44:42 -0500
>>> Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
>>>
>>>> Hi Peter,
>>>>
>>>> I have emails from you dating from a few years back unofficially stating
>>>> that it's OK to update the first byte of an instruction with a single-byte
>>>> int3 concurrently:
>>>>
>>>> https://lkml.indiana.edu/hypermail/linux/kernel/1001.1/01530.html
>>>>
>>>> It is referred in the original implementation of text_poke_bp():
>>>> commit fd4363fff3d9 ("x86: Introduce int3 (breakpoint)-based instruction patching")
>>>>
>>>> Olivier Dion is working on the libpatch [1,2] project aiming to use this
>>>> property for low-latency/low-overhead live code patching in user-space as
>>>> well, but we cannot find an official statement from Intel that guarantees
>>>> this breakpoint-bypass technique is indeed OK without stopping the world
>>>> while patching.
>>>>
>>>> Do you know where I could find an official statement of this guarantee ?
>>>>
>>>
>>> The fact that we have been using it for over 10 years without issue should
>>> be a good guarantee ;-)
>>>
>>> I know you probably prefer an official statement, and I thought they
>>> actually gave one, but can't seem to find it.
>>
>> I recall an in-person discussion with Peter Anvin shortly after he got the
>> official confirmation, but I cannot find any public trace of it. I suspect
>> Intel may have documented this internally only.
> 
> My 2ct, ISTR this also having been vetted by AMD, perhaps they did
> manage to write it down somewhere.

Good point! I did not find a statement specifically about the breakpoint 
bypass, but by piecing up together the explanations from their manual, I 
think we can conclude that it is safe:

Based on AMD64 Architecture Programmer’s Manual Volume 2
7.6.1 Cache Organization and Operation
Cross-Modifying Code

The subsection "Asynchronous modification" describes in detail what 
happens if we concurrently update an instruction that is concurrently 
executed. The good news is that there is no mention of an evil Boeman 
triggering any kind of general protection fault when updating 
instructions concurrently with their execution. So inserting a 
single-byte breakpoint as first byte of an instruction is just the 
simplest scenario covered by that section:

"Such modifications must be done via a single store to the target 
thread's instruction stream that is contained entirely within a 
naturally-aligned quadword, and is subject to the constraints given 
here. A key aspect is that, although the store is performed atomically, 
the affected quadword may be read more than once in the process of 
extracting instruction bytes from it. This can result in the following 
scenarios resulting from a single store:

[...]

2. A modification to one instruction A that changes it to two 
instructions A'-B will only result in execution of A'-B.

[...]"

Then there is the "Synchronous modification" section which basically 
describes how serializing instructions can be issued before proceeding 
to execute the modified instructions.

So AFAIU the XMC breakpoint insertion without stopping the world is 
covered by AMD's "Asynchronous modification" section, and the rest of 
the breakpoint-bypass technique using serializing instructions relying 
on IPIs in the kernel, and on membarrier sync-core in userspace, is 
guaranteed by the "Synchronous modification" section.

Unfortunately I cannot find anything with respect to asynchronous 
cross-modification of code stated as clearly in Intel's documentation.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

