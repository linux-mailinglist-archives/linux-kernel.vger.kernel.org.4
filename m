Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E375612A6A
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 12:45:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbiJ3Lpk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 07:45:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiJ3Lpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 07:45:38 -0400
Received: from smtpout.efficios.com (smtpout.efficios.com [IPv6:2607:5300:203:5aae::31e5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87F12247;
        Sun, 30 Oct 2022 04:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1667130333;
        bh=FHitCiRYLg3puiEvplBQIr9bBOi1r3xMt4XKwVmIP8g=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=m05x1tg3pEuo/oPHR9i9LBvx/H9XPzFxZuoXHoykJODzLaTiN9jxTYa8gNr3y+IZx
         1o+FrV56VZC5w2/Kk3oeW4Ym/6efOWNl8k+TVisujboc3dl7/tBypOFQhAnpEmXbq7
         byU/30qF5O81i2DGSkOZzZxnRBEQ1ctUDUb/aIwkseZrHtCEZGeDaL0lC2UniEgGeD
         T2vMSdK1nIMmQRqmglhusvu0DSHAJeoR3jraeDZ+2QB7fQrAOgRDo5kpmiL5dwk/R0
         NaHJw73t05wOS+S0cFpoFh+CS3y3gdYJ04KcCMDEh8mGgF+rBFq1krW6PJKZxVjAoy
         QCfPIirceTzZA==
Received: from [10.1.0.216] (192-222-188-69.qc.cable.ebox.net [192.222.188.69])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4N0ZGj4MxQzZ6W;
        Sun, 30 Oct 2022 07:45:33 -0400 (EDT)
Message-ID: <d955ff39-8823-d80f-e60f-9aafecc5708c@efficios.com>
Date:   Sun, 30 Oct 2022 07:45:33 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [RFC PATCH 2/2] tracing/user_events: Fixup enable faults asyncly
Content-Language: en-US
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Beau Belgrave <beaub@linux.microsoft.com>
Cc:     rostedt@goodmis.org, mhiramat@kernel.org,
        dcook@linux.microsoft.com, alanau@linux.microsoft.com,
        linux-trace-devel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221027224011.2075-1-beaub@linux.microsoft.com>
 <20221027224011.2075-3-beaub@linux.microsoft.com>
 <a18e940d-8423-0294-23b4-f2702313f3eb@efficios.com>
 <20221028224256.GA202@W11-BEAU-MD.localdomain>
 <f66cdb16-8a3b-35c1-9c24-c32c5c7b19fb@efficios.com>
In-Reply-To: <f66cdb16-8a3b-35c1-9c24-c32c5c7b19fb@efficios.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-10-29 10:40, Mathieu Desnoyers wrote:
> On 2022-10-28 18:42, Beau Belgrave wrote:
>> On Fri, Oct 28, 2022 at 06:19:10PM -0400, Mathieu Desnoyers wrote:
>>> On 2022-10-27 18:40, Beau Belgrave wrote:
>>>> When events are enabled within the various tracing facilities, such as
>>>> ftrace/perf, the event_mutex is held. As events are enabled pages are
>>>> accessed. We do not want page faults to occur under this lock. Instead
>>>> queue the fault to a workqueue to be handled in a process context safe
>>>> way without the lock.
>>>>
>>>> The enable address is disabled while the async fault-in occurs. This
>>>> ensures that we don't attempt fault-in more than is necessary. Once the
>>>> page has been faulted in, the address write is attempted again. If the
>>>> page couldn't fault-in, then we wait until the next time the event is
>>>> enabled to prevent any potential infinite loops.
>>>
>>> I'm also unclear about how the system call initiating the enabled state
>>> change is delayed (or not) when a page fault is queued.
>>>
>>
>> It's not, if needed we could call schedule_delayed_work(). However, I
>> don't think we need it. When pin_user_pages_remote is invoked, it's with
>> FOLL_NOFAULT. This will tell us if we need to fault pages in, we then
>> call fixup_user_fault with unlocked value passed. This will cause the
>> fixup to retry and get the page in.
>>
>> It's called out in the comments for this exact purpose (lucked out
>> here):
>> mm/gup.c
>>   * This is meant to be called in the specific scenario where for 
>> locking reasons
>>   * we try to access user memory in atomic context (within a 
>> pagefault_disable()
>>   * section), this returns -EFAULT, and we want to resolve the user 
>> fault before
>>   * trying again.
>>
>> The fault in happens in a workqueue, this is the same way KVM does it's
>> async page fault logic, so it's not a new pattern. As soon as the
>> fault-in is done, we have a page we should be able to use, so we
>> re-attempt the write immediately. If the write fails, another queue
>> happens and we could loop, but not like the unmap() case I replied with
>> earlier.
>>
>>> I would expect that when a page fault is needed, after enqueuing work 
>>> to the
>>> worker thread, the system call initiating the state change would somehow
>>> wait for a completion (after releasing the user events mutex). That
>>> completion would be signaled by the worker thread either if the page 
>>> fault
>>> fails, or if the state change is done.
>>>
>>
>> I didn't see a generic fault-in + notify anywhere, do you know of one I
>> could use? Otherwise, it seems the pattern used is check fault, fault-in
>> via workqueue, re-attempt.
> 
> I don't think we're talking about the same thing. I'll try stating my 
> concern in a different way.
> 
> user_event_enabler_write() calls user_event_enabler_queue_fault() when 
> it cannot perform the enabled state update immediately (because a page 
> fault is needed).
> 
> But then AFAIU it returns immediately to the caller. The caller could 
> very well expect that the event has been enabled, as requested, 
> immediately when the enabler write returns. The fact that enabling the 
> event can be delayed for an arbitrary amount of time due to page faults 
> means that we have no hard guarantee that the event is enabled as 
> requested upon return to the caller.
> 
> I'd like to add a completion there, to be waited for after 
> user_event_enabler_queue_fault(), but before returning from 
> user_event_enabler_create(). Waiting for the completion should be done 
> without any mutexes held, so after releasing event_mutex.
> 
> The completion would be placed on the stack of 
> user_event_enabler_create(), and a reference to the completion would be 
> placed in the queued fault request. The completion notification would be 
> emitted by the worker thread either when enabling is done, or if a page 
> fault fails.
> 
> See include/linux/completion.h
> 
> Thoughts ?

Actually, after further thinking, I wonder if we need a worker thread at 
all to perform the page faults.

Could we simply handle the page faults from user_event_enabler_create() 
by releasing the mutex and re-trying ? From what contexts is 
user_event_enabler_create() called ? (any locks taken ? system call 
context ? irqs and preemption enabled or disabled ?)

Thanks,

Mathieu

> 
> Thanks,
> 
> Mathieu
> 
> 
>>
>>> Thoughts ?
>>>
>>> Thanks,
>>>
>>> Mathieu
>>>
>>
>> Thanks,
>> -Beau
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

