Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EB1466845D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 21:53:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240223AbjALUxK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 15:53:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237286AbjALUwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 15:52:35 -0500
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9405D63D25
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 12:25:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1673555108;
        bh=ABVJWX1YFWwFvWg/I5xwpsfT16mnlQwmI7g0C+2Jyn4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ojAdu+SEv3o0qPtQaYvRGeG2uLn5uKtQiXcB6KTM8h+Up41sF+U9Zx30cyDFDM+qL
         LDG5NyFvVCO4jjBEcBz22rctcdkokAyB1pMBrnCeEaVsx9WVh/f9jKOVA7wnL4DDOl
         tcMN2GybZ2mLvJMu93TI5WMZFsmdQl0uhCSsXeYeHWy2GoSJsJHJsdCD7ffRR1zN3B
         +ZpGR0poS6xwbmBnFXvwDKewIemlOq2Wa4FRlG5sZ37wDWHO2RZSIrm7Zbl2Fhc6fD
         0nalsyGAGfmnQQ11U+kVZnmR+W6biaK4SK0UfiywloZmvBMynVfAafhQPTJZi+ezcE
         gySTVsWSA0Kuw==
Received: from [172.16.0.101] (192-222-180-24.qc.cable.ebox.net [192.222.180.24])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4NtGJ42rQ1zg6p;
        Thu, 12 Jan 2023 15:25:08 -0500 (EST)
Message-ID: <5c64b742-c41a-8c59-c0c8-8b4cdedaaba5@efficios.com>
Date:   Thu, 12 Jan 2023 15:25:42 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: rseq CPU ID not correct on 6.0 kernels for pinned threads
Content-Language: en-US
To:     Florian Weimer <fweimer@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        libc-alpha@sourceware.org
References: <87lem9cnxr.fsf@oldenburg.str.redhat.com>
 <8b52b0d6-c973-f959-b44a-1b54fb808a04@efficios.com>
 <871qnzpv9l.fsf@oldenburg.str.redhat.com>
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <871qnzpv9l.fsf@oldenburg.str.redhat.com>
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

On 2023-01-12 11:33, Florian Weimer wrote:
> * Mathieu Desnoyers:
> 
>> As you also point out, it can also be caused by some other task
>> modifying the affinity of your task concurrently. You could print
>> the result of sched_getaffinity on error to get a better idea of
>> the expected vs actual mask.
>>
>> Lastly, it could be caused by CPU hotplug which would set all bits
>> in the affinity mask as a fallback. As you mention it should not be
>> the cause there.
>>
>> Can you share your kernel configuration ?
> 
> Attached.
> 
> cpupower frequency-info says:
> 
> analyzing CPU 0:
>    driver: intel_cpufreq
>    CPUs which run at the same hardware frequency: 0
>    CPUs which need to have their frequency coordinated by software: 0
>    maximum transition latency: 20.0 us
>    hardware limits: 800 MHz - 4.60 GHz
>    available cpufreq governors: conservative ondemand userspace powersave performance schedutil
>    current policy: frequency should be within 800 MHz and 4.60 GHz.
>                    The governor "schedutil" may decide which speed to use
>                    within this range.
>    current CPU frequency: Unable to call hardware
>    current CPU frequency: 3.20 GHz (asserted by call to kernel)
>    boost state support:
>      Supported: yes
>      Active: yes
> 
> And I have: kernel.sched_energy_aware = 1
> 
>> Is this on a physical machine or in a virtual machine ?
> 
> I think it happened on both.
> 
> I added additional error reporting to the test (running on kernel
> 6.0.18-300.fc37.x86_64), and it seems that there is something that is
> mucking with affinity masks:
> 
> info: Detected CPU set size (in bits): 64
> info: Maximum test CPU: 19
> error: Pinned thread 17 ran on impossible cpu 7
> info: getcpu reported CPU 7, node 0
> info: CPU affinity mask: 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19
> error: Pinned thread 3 ran on impossible cpu 13
> info: getcpu reported CPU 13, node 0
> info: CPU affinity mask: 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19
> info: Main thread ran on 2 CPU(s) of 20 available CPU(s)
> info: Other threads ran on 20 CPU(s)
> 
> For each of these threads, the affinity mask should be a singleton set.
> Now I need to find out if there is a process that changes affinity
> settings.

If it's not cpu hotunplug, then perhaps something like systemd modifies 
the AllowedCPUs of your cpuset concurrently ?

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

