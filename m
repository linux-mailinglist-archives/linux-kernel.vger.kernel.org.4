Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A99066139FF
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 16:27:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231609AbiJaP1r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 11:27:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230394AbiJaP1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 11:27:44 -0400
Received: from smtpout.efficios.com (smtpout.efficios.com [IPv6:2607:5300:203:5aae::31e5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2751D1183E;
        Mon, 31 Oct 2022 08:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1667230061;
        bh=XQF0uYZeFpRGxhzIxZGFTrUIoIKqhTBlJXlq0c+4Msw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=snV9JjA6JkELDZZqSCfTmGDyl5d7DjN0REsSuQGgbekuXqi4NWonFkUlvf/zCzHD8
         uk2GI6yslbAxmYLkIF5hQCAceabvqCv9uWe6PLbibP6HSfTvGHX7BInL3H24FIQUiz
         8HUW4/qJ9qBovHkEgbQFCZGTUfqWFDAZmtwLxtABJgX71bUAmzed6sRgdG6G4OlDQA
         iHaj5Ajvr++qUgGMZ4XplhycMfaD/eEfenpZbSSiijViSHItqApqJSnpjSCpi/G+Bv
         hUaiuRvd6sJRQ3wMTKPn7wOYwbeCxX/2bwb70XN4V4wxdHWoW/MmNPRpsn7tBtNHTg
         D2Q2SQwdrhcVA==
Received: from [172.16.0.153] (192-222-180-24.qc.cable.ebox.net [192.222.180.24])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4N1H8Y2mB2z11ZY;
        Mon, 31 Oct 2022 11:27:41 -0400 (EDT)
Message-ID: <bdb09819-6aaf-c879-56fc-3d795d94dde7@efficios.com>
Date:   Mon, 31 Oct 2022 11:27:46 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [RFC PATCH 0/2] tracing/user_events: Remote write ABI
Content-Language: en-US
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        Beau Belgrave <beaub@linux.microsoft.com>
Cc:     rostedt@goodmis.org, dcook@linux.microsoft.com,
        alanau@linux.microsoft.com, linux-trace-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221027224011.2075-1-beaub@linux.microsoft.com>
 <20221031231556.a15846fd3513641d48820d5b@kernel.org>
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <20221031231556.a15846fd3513641d48820d5b@kernel.org>
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

On 2022-10-31 10:15, Masami Hiramatsu (Google) wrote:
> Hi Beau,
> 
> On Thu, 27 Oct 2022 15:40:09 -0700
> Beau Belgrave <beaub@linux.microsoft.com> wrote:
> 
>> As part of the discussions for user_events aligned with user space
>> tracers, it was determined that user programs should register a 32-bit
>> value to set or clear a bit when an event becomes enabled. Currently a
>> shared page is being used that requires mmap().
>>
>> In this new model during the event registration from user programs 2 new
>> values are specified. The first is the address to update when the event
>> is either enabled or disabled. The second is the bit to set/clear to
>> reflect the event being enabled. This allows for a local 32-bit value in
>> user programs to support both kernel and user tracers. As an example,
>> setting bit 31 for kernel tracers when the event becomes enabled allows
>> for user tracers to use the other bits for ref counts or other flags.
>> The kernel side updates the bit atomically, user programs need to also
>> update these values atomically.
> 
> I think you means the kernel tracer (ftrace/perf) and user tracers (e.g.
> LTTng) use the same 32bit data so that traced user-application only checks
> that data for checking an event is enabled, right?
> 
> If so, who the user tracer threads updates the data bit? Is that thread
> safe to update both kernel tracer and user tracers at the same time?

Yes, my plan is to have userspace tracer agent threads use atomic 
increments/decrements to update the "enabled" state, and the kernel use 
atomic bit set/clear to update the top bit. This should allow the state 
to be updated concurrently without issues.

> 
> And what is the actual advantage of this change? Are there any issue
> to use mmaped page? I would like to know more background of this
> change.

With this change we can allow a user-space process to manage userspace 
tracing on its own, without any kernel support. Registering to user 
events becomes entirely optional. So if a kernel does not provide user 
events (either an old kernel or a kernel with CONFIG_USER_EVENTS=n), 
userspace tracing still works.

This also allows user-space tracers to co-exist with the user events ABI.

> 
> Could you also provide any sample program which I can play it? :)

I've been working on a user-space static instrumentation library in the 
recent weeks. I've left "TODO" items for integration with user events 
ioctl/writev in the userspace code. See

https://github.com/compudj/side

There is now a build dependency on librseq to provide fast RCU read-side 
to iterate on the array of userspace tracer callbacks:

https://github.com/compudj/librseq

(this dependency could be made optional in the future)

I know Doug is working on his own private repository for userspace 
instrumentation, and we share a lot of common goals.

Thanks,

Mathieu

> 
>> User provided addresses must be aligned on a 32-bit boundary, this
>> allows for single page checking and prevents odd behaviors such as a
>> 32-bit value straddling 2 pages instead of a single page.
>>
>> When page faults are encountered they are done asyncly via a workqueue.
>> If the page faults back in, the write update is attempted again. If the
>> page cannot fault-in, then we log and wait until the next time the event
>> is enabled/disabled. This is to prevent possible infinite loops resulting
>> from bad user processes unmapping or changing protection values after
>> registering the address.
>>
>> NOTE:
>> User programs that wish to have the enable bit shared across forks
>> either need to use a MAP_SHARED allocated address or register a new
>> address and file descriptor. If MAP_SHARED cannot be used or new
>> registrations cannot be done, then it's allowable to use MAP_PRIVATE
>> as long as the forked children never update the page themselves. Once
>> the page has been updated, the page from the parent will be copied over
>> to the child. This new copy-on-write page will not receive updates from
>> the kernel until another registration has been performed with this new
>> address.
>>
>> Beau Belgrave (2):
>>    tracing/user_events: Use remote writes for event enablement
>>    tracing/user_events: Fixup enable faults asyncly
>>
>>   include/linux/user_events.h      |  10 +-
>>   kernel/trace/trace_events_user.c | 396 ++++++++++++++++++++-----------
>>   2 files changed, 270 insertions(+), 136 deletions(-)
>>
>>
>> base-commit: 23758867219c8d84c8363316e6dd2f9fd7ae3049
>> -- 
>> 2.25.1
>>
> 
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

