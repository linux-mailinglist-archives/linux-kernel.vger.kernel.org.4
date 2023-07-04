Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 197C1746B0D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 09:49:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231308AbjGDHtP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 03:49:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231577AbjGDHss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 03:48:48 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 81531E52;
        Tue,  4 Jul 2023 00:48:46 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 79C4E2F4;
        Tue,  4 Jul 2023 00:49:28 -0700 (PDT)
Received: from [10.57.28.39] (unknown [10.57.28.39])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 46F833F73F;
        Tue,  4 Jul 2023 00:48:43 -0700 (PDT)
Message-ID: <c4bcff44-c306-73f5-7864-ef9551d5f5bf@arm.com>
Date:   Tue, 4 Jul 2023 08:49:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [RESEND][PATCH v2 1/3] sched/tp: Add new tracepoint to track
 uclamp set from user-space
Content-Language: en-US
To:     Qais Yousef <qyousef@layalina.io>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        rafael@kernel.org, linux-pm@vger.kernel.org, rostedt@goodmis.org,
        mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        vschneid@redhat.com, delyank@fb.com, qyousef@google.com
References: <20230522145702.2419654-1-lukasz.luba@arm.com>
 <20230522145702.2419654-2-lukasz.luba@arm.com>
 <20230531182629.nztie5rwhjl53v3d@airbuntu>
 <20230621122513.2aa3bc0d29321197e3d38441@kernel.org>
 <20230630114950.zoocytnpvdrxgnss@airbuntu>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20230630114950.zoocytnpvdrxgnss@airbuntu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masami, Qais,

On 6/30/23 12:49, Qais Yousef wrote:
> On 06/21/23 12:25, Masami Hiramatsu wrote:
>> On Wed, 31 May 2023 19:26:29 +0100
>> Qais Yousef <qyousef@layalina.io> wrote:
>>
>>> On 05/22/23 15:57, Lukasz Luba wrote:
>>>> The user-space can set uclamp value for a given task. It impacts task
>>>> placement decisions made by the scheduler. This is very useful information
>>>> and helps to understand the system behavior or track improvements in
>>>> middleware and applications which start using uclamp mechanisms and report
>>>> better performance in tests.
>>>
>>> Do you mind adding a generic one instead please? And explain why we can't just
>>> attach to the syscall via kprobes? I think you want to bypass the permission
>>> checks, so maybe a generic tracepoint after that might be justifiable?
>>
>> Could you tell me more about this point? I would like to know what kind of
>> permission checks can be bypassed with tracepoints.
> 
> Sorry bad usage of English from my end.
> 
> The syscall can fail if the caller doesn't have permission to change the
> attribute (some of them are protected with CAP_NICE) or if the boundary check
> fails. The desire here is to emit a tracepoint() when the user successfully
> changes an attribute of a task.
> 
> Lukasz would like to have this tracepoint to help debug and analyse workloads.
> We are not really bypassing anything. So to rephrase, emit the tracepointn if
> the syscall is successfully changing an attribute.

Sorry, but no. As I said, I don't want to add more dependencies in our
tooling and kernel configuration.

> 
>>
>>> Then anyone can use it to track how userspace has changed any attributes for
>>> a task, not just uclamp.

Is this a real-life use case?
Is there a user-space SW that changes dynamically those attributes in a
way which affects task scheduler decisions that we have hard time to
understand it?

This syscall is quite old and I haven't heard that there is a need to
know what and how often it changes for apps.

On the other hand (the real life).
We started facing issues since some smart middle-ware very often
(a few hundred times in a few minutes) changes the uclamp for apps.
That daemon works autonomously and tries to figure out best values,
To understand those decisions we need some tricky offline processing
from trace. Since the uclamp affects a lot of mechanisms, we need to
know exactly the time and value when it is set.

If you don't point me to the SW which changes the other attributes
that often that you need to record them and post process, then
I would keep the current approach.


>>
>> I guess Uclamp is not controlled by syscall but from kernel internal
>> sched_setattr/setscheduler() too. Anyway I agree that it can be more generic
>> tracepoint, something like trace_sched_set_scheduer(task, attr).
> 
> Yes. Which is something worries me and I had a series in the past to hide it.
> The uclamp range is abstracted and has no meaning in general and should be set
> specifically to each system. e.g: 512 means half the system performance level,
> but if the system is over powered this could be too fast, and if it's
> underpowered it could be too slow. It must be set by userspace; though not sure
> if kernel threads need to manage their performance level how this can be
> achieved.

In mainline kernel I don't see any place where uclamp is set for kernel
threads. It's not use the use case and I hope it won't be anytime soon.

Regards,
Lukasz
