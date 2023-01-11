Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED6CC6663C6
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 20:31:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231712AbjAKTaz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 14:30:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbjAKTaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 14:30:52 -0500
Received: from smtpout.efficios.com (unknown [IPv6:2607:5300:203:b2ee::31e5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C7DFD13D
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 11:30:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1673465447;
        bh=P5o+X5w9OffEjvSaI+GOzWtEzWbMVtkRV9QeB10s/Uo=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=BYdzV5aGrS2mDWushzIiZHeGklmS+cyaMUOmgCWDDprghvolkS7hL3SxkQfQX0Hyj
         9AQh1Wja5Oez71znxfEf9bgyIcJWIteRHxBFPAJ7lBAqji9a8Yt2x6UzSMaVLTCZV3
         Y9rWPBK8qbWVQAfo3B3g2OjSGPRKLl1duFIfsFbRUJMgh7wlDtJXyVHPyTFi4FDUWW
         XxIA8aXRWf+eSeJJrsKCw4b2NL5jGDpwFVmSuUid7L4mJoXcAdJ/4gF1+2txXhZ8d/
         ACiXvcvbA1PVFeyOqffnZZMaRn8hpbGitZF+u+T6HGPuR4I9NEPyOmjHIdcHLPvlrA
         jYclhyVaj2BYA==
Received: from [172.16.0.101] (192-222-180-24.qc.cable.ebox.net [192.222.180.24])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4Nsd7q5WfrzgJM;
        Wed, 11 Jan 2023 14:30:47 -0500 (EST)
Message-ID: <ee304052-5731-4ae6-8f7b-69d0bd1e6c77@efficios.com>
Date:   Wed, 11 Jan 2023 14:31:21 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: rseq CPU ID not correct on 6.0 kernels for pinned threads
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Florian Weimer <fweimer@redhat.com>, linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        libc-alpha@sourceware.org
References: <87lem9cnxr.fsf@oldenburg.str.redhat.com>
 <8b52b0d6-c973-f959-b44a-1b54fb808a04@efficios.com>
Content-Language: en-US
In-Reply-To: <8b52b0d6-c973-f959-b44a-1b54fb808a04@efficios.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-01-11 09:52, Mathieu Desnoyers wrote:
> On 2023-01-11 06:26, Florian Weimer wrote:
>> The glibc test suite contains a test that verifies that sched_getcpu
>> returns the expected CPU number for a thread that is pinned (via
>> sched_setaffinity) to a specific CPU.  There are other threads running
>> which attempt to de-schedule the pinned thread from its CPU.  I believe
>> the test is correctly doing what it is expected to do; it is invalid
>> only if one believes that it is okay for the kernel to disregard the
>> affinity mask for scheduling decisions.
>>
>> These days, we use the cpu_id rseq field as the return value of
>> sched_getcpu if the kernel has rseq support (which it has in these
>> cases).
>>
>> This test has started failing sporadically for us, some time around
>> kernel 6.0.  I see failure occasionally on a Fedora builder, it runs:
>>
>> Linux buildvm-x86-26.iad2.fedoraproject.org 6.0.15-300.fc37.x86_64 #1 
>> SMP PREEMPT_DYNAMIC Wed Dec 21 18:33:23 UTC 2022 x86_64 x86_64 x86_64 
>> GNU/Linux
>>
>> I think I've seen it on the x86-64 builder only, but that might just be
>> an accident.
>>
>> The failing tests log this output:
>>
>> =====FAIL: nptl/tst-thread-affinity-pthread.out=====
>> info: Detected CPU set size (in bits): 64
>> info: Maximum test CPU: 5
>> error: Pinned thread 1 ran on impossible cpu 0
>> error: Pinned thread 0 ran on impossible cpu 0
>> info: Main thread ran on 4 CPU(s) of 6 available CPU(s)
>> info: Other threads ran on 6 CPU(s)
>> =====FAIL: nptl/tst-thread-affinity-pthread2.out=====
>> info: Detected CPU set size (in bits): 64
>> info: Maximum test CPU: 5
>> error: Pinned thread 1 ran on impossible cpu 1
>> error: Pinned thread 2 ran on impossible cpu 0
>> error: Pinned thread 3 ran on impossible cpu 3
>> info: Main thread ran on 5 CPU(s) of 6 available CPU(s)
>> info: Other threads ran on 6 CPU(s)
>>
>> But I also encountered one local failure, but it is rare.  Maybe it's
>> load-related.  There shouldn't be any CPU unplug or anything like that
>> involved here.
>>
>> I am not entirely sure if something is changing CPU affinities from
>> outside the process (which would be quite wrong, but not a kernel bug).
>> But in the past, our glibc test has detected real rseq cpu_id
>> brokenness, so I'm leaning towards that as the cause this time, too.
> 
> It can be caused by rseq failing to update the cpu number field on 
> return to userspace. Tthis could be validated by printing the regular 
> getcpu vdso value and/or the value returned by the getcpu system call 
> when the error is triggered, and see whether it matches the rseq cpu id 
> value.
> 
> It can also be caused by scheduler failure to take the affinity into
> account.
> 
> As you also point out, it can also be caused by some other task
> modifying the affinity of your task concurrently. You could print
> the result of sched_getaffinity on error to get a better idea of
> the expected vs actual mask.
> 
> Lastly, it could be caused by CPU hotplug which would set all bits
> in the affinity mask as a fallback. As you mention it should not be
> the cause there.
> 
> Can you share your kernel configuration ?

Also, can you provide more information about the cpufreq driver and 
governor used in your system ? e.g. output of

cpupower frequency-info

and also output of

sysctl kernel.sched_energy_aware

Is this on a physical machine or in a virtual machine ?

Thanks,

Mathieu

> 
> Thanks,
> 
> Mathieu
> 
>>
>> Thanks,
>> Florian
>>
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

