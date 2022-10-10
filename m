Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3B9B5FA246
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 18:57:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbiJJQ5r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 12:57:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiJJQ5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 12:57:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC4154661C
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 09:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665421063;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5S+BNyIeJIXqDBwU61BSD8ffgXS2PZduRFuxFNybg6Q=;
        b=K87v/b9Tb3Fw8nYNAnVBY2BF2MVvASpCUm8N0oH8v0AXWmgxCH68LFi5iqcGr865GYaUUD
        id3+M5p1t0b8DOYMCFG3LvN0xLg/iyh6PYwXiY4HsIGS3RnroD8EPJlHV7LpO4EJRocRZw
        qYbbyjsiIPWUA7Uso2FCVKhuGUf0XGE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-481-pq7lrMkpOVyOwIR4Qn4_QA-1; Mon, 10 Oct 2022 12:57:37 -0400
X-MC-Unique: pq7lrMkpOVyOwIR4Qn4_QA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1CC57101A528;
        Mon, 10 Oct 2022 16:57:37 +0000 (UTC)
Received: from [10.22.33.72] (unknown [10.22.33.72])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 71CDF40252A9;
        Mon, 10 Oct 2022 16:57:36 +0000 (UTC)
Message-ID: <4c4e5208-ddf5-6191-64b0-54ae0bed1af6@redhat.com>
Date:   Mon, 10 Oct 2022 12:57:36 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] locking/rwsem: Prevent non-first waiter from spinning in
 down_write() slowpath
Content-Language: en-US
To:     Mukesh Ojha <quic_mojha@quicinc.com>
Cc:     linux-kernel@vger.kernel.org, john.p.donnelly@oracle.com,
        Hillf Danton <hdanton@sina.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Ingo Molnar <mingo@redhat.com>
References: <20220929180413.107374-1-longman@redhat.com>
 <6530f135-e8ac-bb6c-4715-1ea8f76cf4c4@redhat.com>
 <7cbf49c9-d122-30e6-68b3-c61eca63e5dc@quicinc.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <7cbf49c9-d122-30e6-68b3-c61eca63e5dc@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/10/22 06:24, Mukesh Ojha wrote:
> Hi Waiman,
>
>
> On 9/29/2022 11:36 PM, Waiman Long wrote:
>> On 9/29/22 14:04, Waiman Long wrote:
>>> A non-first waiter can potentially spin in the for loop of
>>> rwsem_down_write_slowpath() without sleeping but fail to acquire the
>>> lock even if the rwsem is free if the following sequence happens:
>>>
>>>    Non-first waiter       First waiter      Lock holder
>>>    ----------------       ------------      -----------
>>>    Acquire wait_lock
>>>    rwsem_try_write_lock():
>>>      Set handoff bit if RT or
>>>        wait too long
>>>      Set waiter->handoff_set
>>>    Release wait_lock
>>>                           Acquire wait_lock
>>>                           Inherit waiter->handoff_set
>>>                           Release wait_lock
>>>                        Clear owner
>>>                                             Release lock
>>>    if (waiter.handoff_set) {
>>>      rwsem_spin_on_owner(();
>>>      if (OWNER_NULL)
>>>        goto trylock_again;
>>>    }
>>>    trylock_again:
>>>    Acquire wait_lock
>>>    rwsem_try_write_lock():
>>>       if (first->handoff_set && (waiter != first))
>>>           return false;
>>>    Release wait_lock
>>>
>>> It is especially problematic if the non-first waiter is an RT task and
>>> it is running on the same CPU as the first waiter as this can lead to
>>> live lock.
>>>
>>> Fixes: d257cc8cb8d5 ("locking/rwsem: Make handoff bit handling more 
>>> consistent")
>>> Signed-off-by: Waiman Long <longman@redhat.com>
>>> ---
>>>   kernel/locking/rwsem.c | 13 ++++++++++---
>>>   1 file changed, 10 insertions(+), 3 deletions(-)
>>
>> Mukesh, can you test if this patch can fix the RT task lockup problem?
>>
>
> Looks like, There is still a window for a race.
>
> There is a chance when a reader who came first added it's BIAS and 
> goes to slowpath and before it gets added to wait list it got 
> preempted by RT task which  goes to slowpath as well and being the 
> first waiter gets its hand-off bit set and not able to get the lock 
> due to following condition in rwsem_try_write_lock()
>
>  630                 if (count & RWSEM_LOCK_MASK) {  ==> reader has 
> sets its bias
> ..
> ...
>
>  634
>  635                         new |= RWSEM_FLAG_HANDOFF;
>  636                 } else {
>  637                         new |= RWSEM_WRITER_LOCKED;
>
>
> ---------------------->----------------------->-------------------------
>
> First reader (1)          writer(2) RT task             Lock holder(3)
>
> It sets
> RWSEM_READER_BIAS.
> while it is going to
> slowpath(as the lock
> was held by (3)) and
> before it got added
> to the waiters list
> it got preempted
> by (2).
>                         RT task also takes
>                         the slowpath and add              release the
>                         itself into waiting list          rwsem lock
>             and since it is the first         clear the
>                         it is the next one to get         owner.
>                         the lock but it can not
>                         get the lock as (count &
>                         RWSEM_LOCK_MASK) is set
>                         as (1) has added it but
>                         not able to remove its
>             adjustment.
>
Good catch!

It is indeed a possible livelock scenario. Will update the patch to 
address that.

Thanks,
Longman

