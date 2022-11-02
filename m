Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD789616403
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 14:46:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230380AbiKBNqf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 09:46:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230280AbiKBNqa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 09:46:30 -0400
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56BC32AC7C;
        Wed,  2 Nov 2022 06:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1667396785;
        bh=XYmFvXQ4GOXPUVmiEl6Ck9BNbLvwbpXoiDFUhcSXDR8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=mDsqjwsCguRcOe5Lmuj7UX8v4HO7pExu2d7XqR0jkyS2mKljUgfovldWUycD+git8
         7zaNRdcDWQnqjiuRfMwnRdFQxA1x0gaUNb7gEKaT+YD+lWXs0gMpJKrk4DBFPj2khj
         aG6OJ2ijIgZ/iKKonCGNIldnXtg/uq5msWO3NGZoPabhRNPne7Id/nWAF/3PgGnwDC
         Xqqldiit6MbRzShPI1bdFKm8CP+rQKT92ZYlQ2k5ZERKhahwQXAlPaek2D/zTBrYUJ
         pogmBwErol/CzH9BvPoaCisZTRt/Sg3UbC4liMZJJt8cUMNmyg7c9WIxWtgiSNRVGS
         ftMTwN/AASvOw==
Received: from [172.16.0.153] (192-222-180-24.qc.cable.ebox.net [192.222.180.24])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4N2Spn3K1jzfnH;
        Wed,  2 Nov 2022 09:46:25 -0400 (EDT)
Message-ID: <3ff4d759-307e-31a2-4124-98de9e423d7e@efficios.com>
Date:   Wed, 2 Nov 2022 09:46:31 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [RFC PATCH 0/2] tracing/user_events: Remote write ABI
To:     Beau Belgrave <beaub@linux.microsoft.com>
Cc:     rostedt@goodmis.org, mhiramat@kernel.org,
        dcook@linux.microsoft.com, alanau@linux.microsoft.com,
        linux-trace-devel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221027224011.2075-1-beaub@linux.microsoft.com>
 <96d9f066-2f39-78e6-9be7-f9c69235615e@efficios.com>
 <20221028221728.GA162@W11-BEAU-MD.localdomain>
 <01d10e59-0ea6-e60f-8561-84aa5dee40d3@efficios.com>
 <20221031165314.GA129@W11-BEAU-MD.localdomain>
Content-Language: en-US
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <20221031165314.GA129@W11-BEAU-MD.localdomain>
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

On 2022-10-31 12:53, Beau Belgrave wrote:
> On Sat, Oct 29, 2022 at 09:58:26AM -0400, Mathieu Desnoyers wrote:
>> On 2022-10-28 18:17, Beau Belgrave wrote:
>>> On Fri, Oct 28, 2022 at 05:50:04PM -0400, Mathieu Desnoyers wrote:
>>>> On 2022-10-27 18:40, Beau Belgrave wrote:
>>
>> [...]
>>>
>>>>>
>>>>> NOTE:
>>>>> User programs that wish to have the enable bit shared across forks
>>>>> either need to use a MAP_SHARED allocated address or register a new
>>>>> address and file descriptor. If MAP_SHARED cannot be used or new
>>>>> registrations cannot be done, then it's allowable to use MAP_PRIVATE
>>>>> as long as the forked children never update the page themselves. Once
>>>>> the page has been updated, the page from the parent will be copied over
>>>>> to the child. This new copy-on-write page will not receive updates from
>>>>> the kernel until another registration has been performed with this new
>>>>> address.
>>>>
>>>> This seems rather odd. I would expect that if a parent process registers
>>>> some instrumentation using private mappings for enabled state through the
>>>> user events ioctl, and then forks, the child process would seamlessly be
>>>> traced by the user events ABI while being able to also change the enabled
>>>> state from the userspace tracer libraries (which would trigger COW).
>>>> Requiring the child to re-register to user events is rather odd.
>>>>
>>>
>>> It's the COW that is the problem, see below.
>>>
>>>> What is preventing us from tracing the child without re-registration in this
>>>> scenario ?
>>>>
>>>
>>> Largely knowing when the COW occurs on a specific page. We don't make
>>> the mappings, so I'm unsure if we can ask to be notified easily during
>>> these times or not. If we could, that would solve this. I'm glad you are
>>> thinking about this. The note here was exactly to trigger this
>>> discussion :)
>>>
>>> I believe this is the same as a Futex, I'll take another look at that
>>> code to see if they've come up with anything regarding this.
>>>
>>> Any ideas?
>>
>> Based on your description of the symptoms, AFAIU, upon registration of a
>> given user event associated with a mm_struct, the user events ioctl appears
>> to translates the virtual address into a page pointer immediately, and keeps
>> track of that page afterwards. This means it loses track of the page when
>> COW occurs.
>>
> 
> No, we keep the memory descriptor and virtual address so we can properly
> resolve to page per-process.
> 
>> Why not keep track of the registered virtual address and struct_mm
>> associated with the event rather than the page ? Whenever a state change is
>> needed, the virtual-address-to-page translation will be performed again. If
>> it follows a COW, it will get the new copied page. If it happens that no COW
>> was done, it should map to the original page. If the mapping is shared, the
>> kernel would update that shared page. If the mapping is private, then the
>> kernel would COW the page before updating it.
>>
>> Thoughts ?
>>
> 
> I think you are forgetting about page table entries. My understanding is
> the process will have the VMAs copied on fork, but the page table
> entries will be marked read-only. Then when the write access occurs, the
> COW is created (since the PTE says readonly, but the VMA says writable).
> However, that COW page is now only mapped within that forked process
> page table.
> 
> This requires tracking the child memory descriptors in addition to the
> parent. The most straightforward way I see this happening is requiring
> user side to mmap the user_event_data fd that is used for write. This
> way when fork occurs in dup_mm() / dup_mmap() that mmap'd
> user_event_data will get open() / close() called per-fork. I could then
> copy the enablers from the parent but with the child's memory descriptor
> to allow proper lookup.
> 
> This is like fork before COW, it's a bummer I cannot see a way to do
> this per-page. Doing the above would work, but it requires copying all
> the enablers, not just the one that changed after the fork.

This brings an overall design concern I have with user-events: AFAIU, 
the lifetime of the user event registration appears to be linked to the 
lifetime of a file descriptor.

What happens when that file descriptor is duplicated and send over to 
another process through unix sockets credentials ? Does it mean that the 
kernel have a handle on the wrong process to update the "enabled" state?

Also, what happens on execve system call if the file descriptor 
representing the user event is not marked as close-on-exec ? Does it 
mean the kernel can corrupt user-space memory of the after-exec loaded 
binary when it attempts to update the "enabled" state ?

If I get this right, I suspect we might want to move the lifetime of the 
user event registration to the memory space (mm_struct).

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

