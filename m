Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEA64669D89
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 17:21:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbjAMQV2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 11:21:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbjAMQU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 11:20:57 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 159EF392FD
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 08:13:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673626413;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LXEPekITNxpuaI6z+nmO+Vw9fP4KuIfNcriWYNQQsP8=;
        b=fti4TIIEaYrDSGxCmT8sig5w2A89zlYbKNHboX1s9Vtl/3NRYx55wly0LIOg0lbFrwS4OM
        Q798r7wuIw0X2kMpUnApJIBRS7Xlab53hmfQ+PoIzkimlQdh8Xwx2B+OQx0TVVZcIHyk7W
        bQKxr2H2bCQ73Q6ccxrfS/JSlyMcBws=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-575-aPBiztmeMgmtCeIvtftMfQ-1; Fri, 13 Jan 2023 11:13:29 -0500
X-MC-Unique: aPBiztmeMgmtCeIvtftMfQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5CAE4801779;
        Fri, 13 Jan 2023 16:13:29 +0000 (UTC)
Received: from [10.22.8.221] (unknown [10.22.8.221])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 033D1492B06;
        Fri, 13 Jan 2023 16:13:28 +0000 (UTC)
Message-ID: <f832a6bc-d0f2-b659-37c9-2b64f1e73b0d@redhat.com>
Date:   Fri, 13 Jan 2023 11:13:28 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: rseq CPU ID not correct on 6.0 kernels for pinned threads
Content-Language: en-US
To:     Florian Weimer <fweimer@redhat.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        libc-alpha@sourceware.org
References: <87lem9cnxr.fsf@oldenburg.str.redhat.com>
 <8b52b0d6-c973-f959-b44a-1b54fb808a04@efficios.com>
 <871qnzpv9l.fsf@oldenburg.str.redhat.com>
 <5c64b742-c41a-8c59-c0c8-8b4cdedaaba5@efficios.com>
 <877cxq4dwn.fsf@oldenburg.str.redhat.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <877cxq4dwn.fsf@oldenburg.str.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/13/23 11:06, Florian Weimer wrote:
> * Mathieu Desnoyers:
>
>> On 2023-01-12 11:33, Florian Weimer wrote:
>>> * Mathieu Desnoyers:
>>>
>>>> As you also point out, it can also be caused by some other task
>>>> modifying the affinity of your task concurrently. You could print
>>>> the result of sched_getaffinity on error to get a better idea of
>>>> the expected vs actual mask.
>>>>
>>>> Lastly, it could be caused by CPU hotplug which would set all bits
>>>> in the affinity mask as a fallback. As you mention it should not be
>>>> the cause there.
>>>>
>>>> Can you share your kernel configuration ?
>>> Attached.
>>> cpupower frequency-info says:
>>> analyzing CPU 0:
>>>     driver: intel_cpufreq
>>>     CPUs which run at the same hardware frequency: 0
>>>     CPUs which need to have their frequency coordinated by software: 0
>>>     maximum transition latency: 20.0 us
>>>     hardware limits: 800 MHz - 4.60 GHz
>>>     available cpufreq governors: conservative ondemand userspace powersave performance schedutil
>>>     current policy: frequency should be within 800 MHz and 4.60 GHz.
>>>                     The governor "schedutil" may decide which speed to use
>>>                     within this range.
>>>     current CPU frequency: Unable to call hardware
>>>     current CPU frequency: 3.20 GHz (asserted by call to kernel)
>>>     boost state support:
>>>       Supported: yes
>>>       Active: yes
>>> And I have: kernel.sched_energy_aware = 1
>>>
>>>> Is this on a physical machine or in a virtual machine ?
>>> I think it happened on both.
>>> I added additional error reporting to the test (running on kernel
>>> 6.0.18-300.fc37.x86_64), and it seems that there is something that is
>>> mucking with affinity masks:
>>> info: Detected CPU set size (in bits): 64
>>> info: Maximum test CPU: 19
>>> error: Pinned thread 17 ran on impossible cpu 7
>>> info: getcpu reported CPU 7, node 0
>>> info: CPU affinity mask: 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19
>>> error: Pinned thread 3 ran on impossible cpu 13
>>> info: getcpu reported CPU 13, node 0
>>> info: CPU affinity mask: 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19
>>> info: Main thread ran on 2 CPU(s) of 20 available CPU(s)
>>> info: Other threads ran on 20 CPU(s)
>>> For each of these threads, the affinity mask should be a singleton
>>> set.
>>> Now I need to find out if there is a process that changes affinity
>>> settings.
>> If it's not cpu hotunplug, then perhaps something like systemd
>> modifies the AllowedCPUs of your cpuset concurrently ?
> It's probably just this kernel bug:
>
> commit da019032819a1f09943d3af676892ec8c627668e
> Author: Waiman Long <longman@redhat.com>
> Date:   Thu Sep 22 14:00:39 2022 -0400
>
>      sched: Enforce user requested affinity
>      
>      It was found that the user requested affinity via sched_setaffinity()
>      can be easily overwritten by other kernel subsystems without an easy way
>      to reset it back to what the user requested. For example, any change
>      to the current cpuset hierarchy may reset the cpumask of the tasks in
>      the affected cpusets to the default cpuset value even if those tasks
>      have pre-existing user requested affinity. That is especially easy to
>      trigger under a cgroup v2 environment where writing "+cpuset" to the
>      root cgroup's cgroup.subtree_control file will reset the cpus affinity
>      of all the processes in the system.
>      
>      That is problematic in a nohz_full environment where the tasks running
>      in the nohz_full CPUs usually have their cpus affinity explicitly set
>      and will behave incorrectly if cpus affinity changes.
>      
>      Fix this problem by looking at user_cpus_ptr in __set_cpus_allowed_ptr()
>      and use it to restrcit the given cpumask unless there is no overlap. In
>      that case, it will fallback to the given one. The SCA_USER flag is
>      reused to indicate intent to set user_cpus_ptr and so user_cpus_ptr
>      masking should be skipped. In addition, masking should also be skipped
>      if any of the SCA_MIGRATE_* flag is set.
>      
>      All callers of set_cpus_allowed_ptr() will be affected by this change.
>      A scratch cpumask is added to percpu runqueues structure for doing
>      additional masking when user_cpus_ptr is set.
>      
>      Signed-off-by: Waiman Long <longman@redhat.com>
>      Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>      Link: https://lkml.kernel.org/r/20220922180041.1768141-4-longman@redhat.com
>
> I don't think it's been merged into any stable kernels yet?

This patch will be in the v6.2 kernel. Since it is not marked as a fix, 
it won't go into a stable kernel by default.

Cheers,
Longman

