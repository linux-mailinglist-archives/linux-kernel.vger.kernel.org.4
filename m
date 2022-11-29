Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E844063C4A8
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 17:06:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235705AbiK2QGp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 11:06:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235850AbiK2QGH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 11:06:07 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25A1266C99
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 08:03:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669737823;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0Gt3AIWb2ri6G3KKDanOT6IHhzcEIhTnTK93LHPt92E=;
        b=ajHvdcUcrhZ1ONMyVeO/iKIk3Lu2A/AYfjsISLLqGz5WPWgPTjHFzXQUbOeHsrmrrVczvy
        dhWBmMby5zqDCBHvOEjJODME9dVfoLZCEfBODLZnfga83AIemM/Vi92CIpzGD3T7uDZ5A/
        PxLoQGaq/mxLBt4NtbWLLHvwYFVVIsM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-212-ryLL5bSvPnmYfwHwl01TRA-1; Tue, 29 Nov 2022 11:03:39 -0500
X-MC-Unique: ryLL5bSvPnmYfwHwl01TRA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9E14A811E87;
        Tue, 29 Nov 2022 16:03:38 +0000 (UTC)
Received: from [10.22.17.30] (unknown [10.22.17.30])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CC51C492B07;
        Tue, 29 Nov 2022 16:03:37 +0000 (UTC)
Message-ID: <4e93019d-4b19-14f9-14d7-da43456d3546@redhat.com>
Date:   Tue, 29 Nov 2022 11:03:35 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH-tip v4] sched: Fix NULL user_cpus_ptr check in
 dup_user_cpus_ptr()
Content-Language: en-US
To:     Will Deacon <will@kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Phil Auld <pauld@redhat.com>,
        Wenjie Li <wenjieli@qti.qualcomm.com>,
        =?UTF-8?B?RGF2aWQgV2FuZyDnjovmoIc=?= <wangbiao3@xiaomi.com>,
        linux-kernel@vger.kernel.org
References: <20221125023943.1118603-1-longman@redhat.com>
 <92b99a5e-1588-4e08-a652-72e9c51421cf@redhat.com>
 <20221128120008.GA25090@willie-the-truck>
 <d49a78bb-dce1-92b1-0f67-d71259609263@redhat.com>
 <20221129140759.GA26437@willie-the-truck>
 <f669ce38-1e23-04b4-fe6f-591579e817de@redhat.com>
 <20221129155757.GC26561@willie-the-truck>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20221129155757.GC26561@willie-the-truck>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/29/22 10:57, Will Deacon wrote:
> On Tue, Nov 29, 2022 at 10:32:49AM -0500, Waiman Long wrote:
>> On 11/29/22 09:07, Will Deacon wrote:
>>> On Mon, Nov 28, 2022 at 10:11:52AM -0500, Waiman Long wrote:
>>>> On 11/28/22 07:00, Will Deacon wrote:
>>>>> On Sun, Nov 27, 2022 at 08:43:27PM -0500, Waiman Long wrote:
>>>>>> On 11/24/22 21:39, Waiman Long wrote:
>>>>>>> In general, a non-null user_cpus_ptr will remain set until the task dies.
>>>>>>> A possible exception to this is the fact that do_set_cpus_allowed()
>>>>>>> will clear a non-null user_cpus_ptr. To allow this possible racing
>>>>>>> condition, we need to check for NULL user_cpus_ptr under the pi_lock
>>>>>>> before duping the user mask.
>>>>>>>
>>>>>>> Fixes: 851a723e45d1 ("sched: Always clear user_cpus_ptr in do_set_cpus_allowed()")
>>>>>>> Signed-off-by: Waiman Long <longman@redhat.com>
>>>>>> This is actually a pre-existing use-after-free bug since commit 07ec77a1d4e8
>>>>>> ("sched: Allow task CPU affinity to be restricted on asymmetric systems").
>>>>>> So it needs to be fixed in the stable release as well. Will resend the patch
>>>>>> with an additional fixes tag and updated commit log.
>>>>> Please can you elaborate on the use-after-free here? Looking at
>>>>> 07ec77a1d4e8, the mask is only freed in free_task() when the usage refcount
>>>>> has dropped to zero and I can't see how that can race with fork().
>>>>>
>>>>> What am I missing?
>>>> I missed that at first. The current task cloning process copies the content
>>>> of the task structure over to the newly cloned/forked task. IOW, if
>>>> user_cpus_ptr had been set up previously, it will be copied over to the
>>>> cloned task. Now if user_cpus_ptr of the source task is cleared right after
>>>> that and before dup_user_cpus_ptr() is called. The obsolete user_cpus_ptr
>>>> value in the cloned task will remain and get used even if it has been freed.
>>>> That is what I call as use-after-free and double-free.
>>> If the parent task can be modified concurrently with dup_task_struct() then
>>> surely we'd have bigger issues because that's not going to be atomic? At the
>>> very least we'd have a data race, but it also feels like we could end up
>>> with inconsistent task state in the child. In fact, couldn't the normal
>>> 'cpus_mask' be corrupted by a concurrent set_cpus_allowed_common()?
>>>
>>> Or am I still failing to understand the race?
>>>
>> A major difference between cpus_mask and user_cpus_ptr is that for
>> cpus_mask, the bitmap is embedded into task_struct whereas user_cpus_ptr is
>> a pointer to an external bitmap. So there is no issue of use-after-free wrt
>> cpus_mask. That is not the case where the memory of the user_cpus_ptr of the
>> parent task is freed, but then a reference to that memory is still available
>> in the child's task struct and may be used.
> Sure, I'm not saying there's a UAF on cpus_mask, but I'm concerned that we
> could corrupt the data and end up with an affinity mask that doesn't correspond
> to anything meaningful. Do you agree that's possible?
That is certainly possible. So we have to be careful about it.
>
>> Note that the problematic concurrence is not between the copying of task
>> struct and changing of the task struct. It is what will happen after the
>> task struct copying has already been done with an extra reference present in
>> the child's task struct.
> Well, sort of, but the child only has the extra reference _because_ the parent
> pointer was concurrently cleared to NULL, otherwise dup_user_cpus_ptr() would
> have allocated a new copy and we'd be ok, no?
Yes, that is exactly where the problem is and this is what my patch is 
trying to fix.
>
> Overall, I'm just very wary that we seem to be saying that copy_process()
> can run concurrently with changes to the parent. Maybe it's all been written
> with that in mindi (including all the arch callbacks), but I'd be astonished
> if this is the only problem in there.

It seems like that, at least in some cases, the clearing of a task's 
user_cpus_ptr can be done by another task. So the parent may be unaware 
of it and so is not its fault.

Cheers,
Longman

