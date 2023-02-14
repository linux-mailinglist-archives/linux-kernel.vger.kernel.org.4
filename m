Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3622B695653
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 03:04:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231169AbjBNCE1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 21:04:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjBNCEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 21:04:25 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCFADCA2B
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 18:03:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676340217;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q4RizyYoN+f/EYFmsiRQx5HFIuLBlDb//9AAYQs+Ppc=;
        b=XrXtf6tKQQUjjHSWOK09qWuflRwzKRELAUUf6Xaa+YqE6Gy2icZR7H+Kaiv68MdB51VZ6b
        JZ+3ikE/4qQ0C7aetnXEUdAo+sN4A+5ue1RNkIxDU/rUVt1n0o5M9r9IC7x8WoogSgFa4J
        pozWD5N3l3o16w/ARpohP7+E1RDPorU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-347-GWX8WUe5PZKFoenARfK0DA-1; Mon, 13 Feb 2023 21:03:32 -0500
X-MC-Unique: GWX8WUe5PZKFoenARfK0DA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 52CA680006E;
        Tue, 14 Feb 2023 02:03:31 +0000 (UTC)
Received: from [10.22.8.167] (unknown [10.22.8.167])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A98352026D4B;
        Tue, 14 Feb 2023 02:03:30 +0000 (UTC)
Message-ID: <fc6bb7b9-a229-4afd-d7c6-a302460fde81@redhat.com>
Date:   Mon, 13 Feb 2023 21:03:30 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v7 4/4] locking/rwsem: Enable direct rwsem lock handoff
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        linux-kernel@vger.kernel.org, john.p.donnelly@oracle.com,
        Hillf Danton <hdanton@sina.com>,
        Mukesh Ojha <quic_mojha@quicinc.com>,
        =?UTF-8?B?VGluZzExIFdhbmcg546L5am3?= <wangting11@xiaomi.com>
References: <20230126003628.365092-1-longman@redhat.com>
 <20230126003628.365092-5-longman@redhat.com>
 <Y+otv+QGyMpHAFO1@hirez.programming.kicks-ass.net>
 <19c54f55-3b27-6777-e42c-8d7b25b6f2b5@redhat.com>
 <Y+qxHXwXSsIZnVtH@hirez.programming.kicks-ass.net>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <Y+qxHXwXSsIZnVtH@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2/13/23 16:52, Peter Zijlstra wrote:
> On Mon, Feb 13, 2023 at 12:14:59PM -0500, Waiman Long wrote:
>
>>> I am once again confused...
>>>
>>> *WHY* are you changing the writer wake-up path? The comments added here
>>> don't clarify anything.
>>>
>>> If we set handoff, we terminate/disallow the spinning/stealing. The
>>> direct consequence is that the slowpath/wait-list becomes the only way
>>> forward.
>> Yes, that is true.
>>> Since we don't take wait_lock on up, we fundamentally have a race
>>> condition. But *WHY* do you insist on handling that in rwsem_wake()?
>>> Delaying all that until rwsem_try_write_lock()? Doing so would render
>>> pretty much all of the above pointless, no?
>> There is an advantage in doing the handover earlier, if possible. A reader
>> that comes in between can spoils the takeover of the rwsem in
> How ?!? since all the stealing and spinning is out, the wait-list reigns
> supreme. A new reader will queue.
>
> Are you worried about the spurious elevation of ->count due to that
> uncondition increment on down_read() ? This is always going to be the
> case.

Yes, that is what I am talking about.


>
>> rwsem_try_write_lock() and cause it to sleep again. Since we will have to
>> take the wait lock anyway in rwsem_wake(), there isn't much additional cost
>> to do some additional check.
> There is a complexity cost -- and so far I've not seen a single line of
> justification for the added complexity.
>
>> Note that the kernel test robot had detected a 19.3% improvement of
>> will-it-scale.per_thread_ops [1] due to this commit. That indicates this
>> commit is good to have. I am planning to update the commit log to include
>> that information as well as additional reasoning as discussed here.
> Seen that; but who's saying a simpler implementation will not also have
> those gains. And if not, then we have a clear separation into
> functionality and optimization and justifications for it.
>
> But now, we have neither. I'm not saying the patch is wrong -- I'm
> saying it is needlessly complicated without justification.
>
> All this stuff is hard enough -- we should really try to keep is as
> simple as possible, having two distinct ways to wake up a writer is not
> 'as simple as possible'.

OK, a simpler implementation will be to also check for handoff readiness 
in rwsem_wake() and set a flag in waiter structure. When the writer 
wakes up and calls  rwsem_try_write_lock(), it can ignore any spurious 
READER_BIAS and take over the lock directly if the flag is set. Will you 
be OK with that?

I believe the one of the reasons for the performance improvement 
reported by the test robot is that the check for handoff readiness in 
both rwsem_wake() and rwsem_try_write_lock() will increase the chance 
that a handoff will be successful in the first attempt. Another possible 
reason is that writer may not need to take the wait_lock anymore if all 
the handoff work is done by the unlocker at rwsem_wake(). That will be 
lost if we do a simpler solution as outlined above.

>
>>> After all, rwsem_mark_wake() already wakes the writer if it is first,
>>> no? Why invent yet another special way to wake up the writer.
>> As I said before, waking up the writer does not mean it can always get the
>> rwsem on the first rwsem_try_write_lock(). Doing early handoff in
>> rwsem_wake() can remove that ambiguity.
> But what if it is rwsem_down_read_slowpath() that drops ->count to 0 and
> does rwsem_mark_wake() and misses your fancy new path?

As said above, the current patch allows handoff to be done at both 
rwsem_wake() and rwsem_try_write_lock(). I haven't removed the code to 
do handoff in rwsem_try_write_lock().


>
> That is, I'm thinking there's an argument to be had that rwsem_wake() is
> fundamentally the wrong place to do anything.
>
> OTOH, you are right in that rwsem_mark_wake() is in a special position;
> it *KNOWS* the reader count has hit 0 and can ignore future spurious
> increments because by knowing it was 0 it knows they *WILL* fail and
> queue (provided WAITERS||HANDOFF) -- but I've not seen you
> articulate this point.
My bad, I sometimes miss stating assumptions and rationale that can 
properly justify the patch. I usually need more back and fro like what 
we are doing now to fully write out all the missing pieces. So I really 
appreciate your time in reviewing the patch and your critiques :-)
>
> (note how rwsem_cond_wake_waiter() relies on exactly this to select
> WAKE_ANY)
>
> You are also right in that having these different means of waking
> readers and writers is 'confusing'.
>
> But you failed to take things to their natural conclusion -- change the
> way we do writer wakeups, all writer wakeups.
>
> So change rwsem_mark_wake()'s writer wakeup and
> rwsem_down_write_slowpath() to always so that waiter->task thing that
> the readers already do.
>
> It means putting all the logic for waking writers into
> rwsem_mark_wake(), but then we can make full use of this 'we hit zero
> future readers are temporary noise'. Althought I suspect you might need
> to pass count into it, so we can observe the flags at the time 0 was
> observed.
>
> Is all that making sense? -- it has been a long day :-)

I guess it is possible to do that, but it may reduce the performance 
improvement due to optimistic spinning and it will become more like the 
old way of strictly following the wait queue order in granting lock. I 
need to run some tests to verify the performance impact.


>
>>> Also; and I asked this last time around; why do we care about the
>>> handoff to writer *at*all* ? It is the readers that set HANDOFF.
>> HANDOFF can happen for both readers and writers. Handoff to writer is
>> actually more important than to readers.
> Hmm, clearly I missed something. This is rwsem_try_write_lock() setting
> it, right?

Yes, handoff can be set and granted in rwsem_try_write_lock().

Cheers,
Longman

