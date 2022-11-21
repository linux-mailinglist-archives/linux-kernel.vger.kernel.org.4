Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B6A3632C81
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 20:00:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbiKUTAg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 14:00:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiKUTAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 14:00:33 -0500
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 851B45CD22;
        Mon, 21 Nov 2022 11:00:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1669057228;
        bh=qlTxwjLzUArVDUmHDy2x0ijrzdWCb9u7jU8Bh5JN34M=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=aU2IGGqiMjiw5HkbrEoWGbobflqlBctidMr14SJF0ERgnI3Y9jPTUC9VxbUrgO1ZV
         /AZ0d9M3mGuxp6Ou1wU+t0rlIXz2kTMqeEMKcAoTGMNuN/d1+YLKpXKEAEogoZeLD7
         NKfIhjVL1F4Syz0x1nw5Cjor5+Stx/NagdeBZsr0emXUCg9+xT1PyjiuELz1lfySEz
         Go9ANfb/3MKq1Zv8hHKKrCA4boLlE5OzlVrWMAk39BOOi8AdI8Vj2n07jFLmwGne81
         Nl8kBcb3BbjcUlq1ffgdXTYDrTq2y4RQGXJCRTXu0FQytYGIWDt3o9opefzXg+dV4N
         oOh3CEwqq+m1g==
Received: from [172.16.0.156] (192-222-180-24.qc.cable.ebox.net [192.222.180.24])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4NGGtN3mfZzXR4;
        Mon, 21 Nov 2022 14:00:28 -0500 (EST)
Message-ID: <468f2595-e9e4-a195-05eb-bae7f42db4b3@efficios.com>
Date:   Mon, 21 Nov 2022 14:00:42 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v5 08/24] sched: Introduce per memory space current
 virtual cpu id
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
        Florian Weimer <fw@deneb.enyo.de>, David.Laight@aculab.com,
        carlos@redhat.com, Peter Oskolkov <posk@posk.io>,
        Alexander Mikhalitsyn <alexander@mihalicyn.com>,
        Chris Kennelly <ckennelly@google.com>
References: <20221103200359.328736-1-mathieu.desnoyers@efficios.com>
 <20221103200359.328736-9-mathieu.desnoyers@efficios.com>
 <CALCETrW1doHX3=za+KDuB=4y+wHsnaZpVkDP3OhZXGrQU2iffw@mail.gmail.com>
 <2f191ddb-de89-52c0-e7da-26ac0239b8fe@efficios.com>
 <Y3KpxR4ABRxvD+kj@google.com>
 <273f4883-25bc-44ad-9c35-3950ca8a3fcf@efficios.com>
 <Y3aHMTNv0yiyHCun@google.com>
 <a1b401e7-cbfa-0add-17fe-ebb2ae54850c@efficios.com>
 <Y3akhjmJEcD0nDK/@google.com>
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <Y3akhjmJEcD0nDK/@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-11-17 16:15, Sean Christopherson wrote:
> On Thu, Nov 17, 2022, Mathieu Desnoyers wrote:
>> On 2022-11-17 14:10, Sean Christopherson wrote:
>>> On Thu, Nov 17, 2022, Mathieu Desnoyers wrote:
>>>> On 2022-11-14 15:49, Sean Christopherson wrote:
>>>>> On Fri, Nov 11, 2022, Mathieu Desnoyers wrote:
>>>>>> On 2022-11-10 23:41, Andy Lutomirski wrote:
>>>>>>> On Thu, Nov 3, 2022 at 1:05 PM Mathieu Desnoyers
>>>>>>> <mathieu.desnoyers@efficios.com> wrote:
>>>>>>> Also, in my mind "virtual cpu" is vCPU, which this isn't.  Maybe
>>>>>>> "compacted cpu" or something?  It's a strange sort of concept.
>>>>>>
>>>>>> I've kept the same wording that has been introduced in 2011 by Paul Turner
>>>>>> and used internally at Google since then, although it may be confusing if
>>>>>> people expect kvm-vCPU and rseq-vcpu to mean the same thing. Both really end
>>>>>> up providing the semantic of a virtually assigned cpu id (in opposition to
>>>>>> the logical cpu id on the system), but this is much more involved in the
>>>>>> case of KVM.
>>>>>
>>>>> I had the same reaction as Andy.  The rseq concepts don't worry me so much as the
>>>>> existence of "vcpu" in mm_struct/task_struct, e.g. switch_mm_vcpu() when switching
>>>>> between KVM vCPU tasks is going to be super confusing.  Ditto for mm_vcpu_get()
>>>>> and mm_vcpu_put() in the few cases where KVM currently does mmget()/mmput().
>>>>
>>>> I'm fine with changing the wording if it helps make things less confusing.
>>>>
>>>> Should we go for "compact-cpu-id" ? "packed-cpu-id" ? Other ideas ?
>>>
>>> What about something like "process-local-cpu-id" to capture that the ID has meaning
>>> only within the associated address space / process?
>>
>> Considering that the shorthand for "memory space" is "VM" in e.g. "CLONE_VM"
> 
> No objection from me for "vm", I've already had to untrain myself and remember
> that "vm" doesn't always mean "virtual machine" :-)
> 
>> clone(2) flags, perhaps "vm-cpu-id", "vm-local-cpu-id" or "per-vm-cpu-id" ?
> 
> I have a slight preference for vm-local-cpu-id, but any of 'em work for me.

Taking a step back wrt naming (because if I do a name change across the 
series, I want it to be the last time I do it):

- VM (kvm) vs vm_ (rseq) is confusing.
- vCPU (kvm) vs vcpu (rseq) is confusing.

I propose "Address Space Concurrency ID". This indicates that those IDs 
are really just tags assigned uniquely within an address space for each 
thread running concurrently (and only while they are running).

Then the question that arises is whether the abbreviation presented to 
user-space should be "mm_cid" (as would be expected from an internal 
implementation perspective) or "as_cid" (which would match the name 
exposed to user-space) ?

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

