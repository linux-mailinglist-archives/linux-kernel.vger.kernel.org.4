Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 320AC625CE1
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 15:23:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234600AbiKKOXD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 09:23:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234416AbiKKOWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 09:22:40 -0500
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B88029D;
        Fri, 11 Nov 2022 06:18:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1668176297;
        bh=vJIYuMn+At2sL0l/lBZTfA5ZWUGfFE17xuwr2QDcG8w=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=fLB9josUWfndff3iej/h9RRsXmh9fwG3e/NhOJtNb0E6DyAfkIi9cCq+yVXawJPhP
         WAr4a+L1AlAcdPhj7HPwC7OvhylrMvkwcJNVVulfeRHGUq3mEfdVGzPGXPBHHLd3cr
         z4x+1ybG5AXou05qfR3lie7F2spU0G0TNrlQh99n+YB/2Ev1kfODxYnpaNlW05UpjF
         fdNEx2uD9RMnWgNtd+c6WdwG+/50KVIWOWUpV+mxWFkYjDqOmlV1wI6GvdBF0qzlM2
         uYhPtxHyFu7N3RtuJ5MJ76CiH2nS9bdDa4Xt7GIbpYLWQOzoWNQCk5NoCTbEkPImzC
         yped6MSXsuIyw==
Received: from [172.16.0.153] (192-222-180-24.qc.cable.ebox.net [192.222.180.24])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4N815P43qGzgpd;
        Fri, 11 Nov 2022 09:18:17 -0500 (EST)
Message-ID: <2f191ddb-de89-52c0-e7da-26ac0239b8fe@efficios.com>
Date:   Fri, 11 Nov 2022 09:18:26 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v5 08/24] sched: Introduce per memory space current
 virtual cpu id
Content-Language: en-US
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Peter Zijlstra <peterz@infradead.org>,
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
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <CALCETrW1doHX3=za+KDuB=4y+wHsnaZpVkDP3OhZXGrQU2iffw@mail.gmail.com>
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

On 2022-11-10 23:41, Andy Lutomirski wrote:
> On Thu, Nov 3, 2022 at 1:05 PM Mathieu Desnoyers
> <mathieu.desnoyers@efficios.com> wrote:
>>
>> This feature allows the scheduler to expose a current virtual cpu id
>> to user-space. This virtual cpu id is within the possible cpus range,
>> and is temporarily (and uniquely) assigned while threads are actively
>> running within a memory space. If a memory space has fewer threads than
>> cores, or is limited to run on few cores concurrently through sched
>> affinity or cgroup cpusets, the virtual cpu ids will be values close
>> to 0, thus allowing efficient use of user-space memory for per-cpu
>> data structures.
>>
> 
> Just to check, is a "memory space" an mm?  I've heard these called
> "mms" or sometimes (mostly accurately) "processes" but never memory
> spaces.  Although I guess the clone(2) manpage says "memory space".

Yes, exactly.

I've had a hard time finding the right word there to describe the 
concept of a struct mm from a user-space point of view, and ended up 
finding that the clone(2) man page expresses the result of a clone 
system call with CLONE_VM set as sharing a "memory space", aka a mm_struct.

 From an internal kernel implementation perspective it is usually 
referred to as a "mm", but it's not a notion that appears to be exposed 
to user-space.

And unfortunately "process" can mean so many things other than a struct 
mm: is it a thread group ? Or just a group of processes sharing a file 
descriptor table ? Or sharing signal handlers ? How would you call a 
thread group (clone with CLONE_THREAD) that does not have CLONE_VM set ?

> 
> Also, in my mind "virtual cpu" is vCPU, which this isn't.  Maybe
> "compacted cpu" or something?  It's a strange sort of concept.

I've kept the same wording that has been introduced in 2011 by Paul 
Turner and used internally at Google since then, although it may be 
confusing if people expect kvm-vCPU and rseq-vcpu to mean the same 
thing. Both really end up providing the semantic of a virtually assigned 
cpu id (in opposition to the logical cpu id on the system), but this is 
much more involved in the case of KVM.

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

