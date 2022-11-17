Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA6FD62E55F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 20:42:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240285AbiKQTmv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 14:42:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233225AbiKQTmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 14:42:49 -0500
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01A6187571;
        Thu, 17 Nov 2022 11:42:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1668714165;
        bh=E+4NnFSUMwiz6OC8we0hbhRXfPNER6d4goz0qBG9fHs=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Q4lqPaUuDMK3GVVcUG7P6ybJ5uUt4vrXt2XIRycWpoLEHTVF4iUS2OIihjdFhQccB
         f8/5+zns2B5uyc6T7b8C+JAr8dHrKvA3Lpfe8HsxidGybH2bMEUwRtw1zBNqFjl6k4
         wi+S7bFzNMClqyV230hvNy0UKM5KAgbSm+FGitYc50tAPQizzRhi3QxGQ1MhrGTiSe
         vzE9Vmtn67goDKVAR9pUxHneSTprrHbGLsyZrTpDzp/Kp62vfPHK2nXCa7WXAjJKcH
         2LT0EFLxS9n7vgN6KINa1efmGnsr/cB0UOzHObKh20EcHTmccgbkUs76OcKkTdNSxt
         VOs5n5jTiK/Aw==
Received: from [172.16.0.153] (192-222-180-24.qc.cable.ebox.net [192.222.180.24])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4NCr111cQDzX7j;
        Thu, 17 Nov 2022 14:42:45 -0500 (EST)
Message-ID: <a1b401e7-cbfa-0add-17fe-ebb2ae54850c@efficios.com>
Date:   Thu, 17 Nov 2022 14:42:56 -0500
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
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <Y3aHMTNv0yiyHCun@google.com>
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

On 2022-11-17 14:10, Sean Christopherson wrote:
> On Thu, Nov 17, 2022, Mathieu Desnoyers wrote:
>> On 2022-11-14 15:49, Sean Christopherson wrote:
>>> On Fri, Nov 11, 2022, Mathieu Desnoyers wrote:
>>>> On 2022-11-10 23:41, Andy Lutomirski wrote:
>>>>> On Thu, Nov 3, 2022 at 1:05 PM Mathieu Desnoyers
>>>>> <mathieu.desnoyers@efficios.com> wrote:
>>>>> Also, in my mind "virtual cpu" is vCPU, which this isn't.  Maybe
>>>>> "compacted cpu" or something?  It's a strange sort of concept.
>>>>
>>>> I've kept the same wording that has been introduced in 2011 by Paul Turner
>>>> and used internally at Google since then, although it may be confusing if
>>>> people expect kvm-vCPU and rseq-vcpu to mean the same thing. Both really end
>>>> up providing the semantic of a virtually assigned cpu id (in opposition to
>>>> the logical cpu id on the system), but this is much more involved in the
>>>> case of KVM.
>>>
>>> I had the same reaction as Andy.  The rseq concepts don't worry me so much as the
>>> existence of "vcpu" in mm_struct/task_struct, e.g. switch_mm_vcpu() when switching
>>> between KVM vCPU tasks is going to be super confusing.  Ditto for mm_vcpu_get()
>>> and mm_vcpu_put() in the few cases where KVM currently does mmget()/mmput().
>>
>> I'm fine with changing the wording if it helps make things less confusing.
>>
>> Should we go for "compact-cpu-id" ? "packed-cpu-id" ? Other ideas ?
> 
> What about something like "process-local-cpu-id" to capture that the ID has meaning
> only within the associated address space / process?

Considering that the shorthand for "memory space" is "VM" in e.g. 
"CLONE_VM" clone(2) flags, perhaps "vm-cpu-id", "vm-local-cpu-id" or 
"per-vm-cpu-id" ?

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

