Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD2AF6A0BB8
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 15:18:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234797AbjBWOR5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 09:17:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234840AbjBWORi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 09:17:38 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 695D458B40
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 06:16:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677161797;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LJq+4ZZHQ5oU0fdQmOoDs9PKH8Rtjmtd4igcShVpL4g=;
        b=EFjToiEFfas83XFQ0Z7chRvVNlMH1IDFGHy+DxGmP4ckeN+/cvdL14biEmb1eWVznIrWC1
        Bjj9Nsww0aBxo9GN8XJST0XS9wQ6Knis26ekSHdv2uwBgYAx3+WOdIM23AsdIYtfIQGxWB
        w+vJopJQkW9bfGoh942zzNwr/qM1160=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-604-OMY2YsLKOGmy1vAgb6r9eA-1; Thu, 23 Feb 2023 09:16:35 -0500
X-MC-Unique: OMY2YsLKOGmy1vAgb6r9eA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 725F2884348;
        Thu, 23 Feb 2023 14:16:34 +0000 (UTC)
Received: from [10.22.16.134] (unknown [10.22.16.134])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CD6B61121314;
        Thu, 23 Feb 2023 14:16:33 +0000 (UTC)
Message-ID: <0e036ff5-c0f1-96a7-cb07-222c7552201f@redhat.com>
Date:   Thu, 23 Feb 2023 09:16:33 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2 2/3] locking/rwsem: Enable early rwsem writer lock
 handoff
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        linux-kernel@vger.kernel.org, Hillf Danton <hdanton@sina.com>
References: <20230216210933.1169097-1-longman@redhat.com>
 <20230216210933.1169097-3-longman@redhat.com>
 <Y/dc01A9+k6KuHTc@hirez.programming.kicks-ass.net>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <Y/dc01A9+k6KuHTc@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2/23/23 07:32, Peter Zijlstra wrote:
> On Thu, Feb 16, 2023 at 04:09:32PM -0500, Waiman Long wrote:
>> @@ -432,19 +433,39 @@ static void rwsem_mark_wake(struct rw_semaphore *sem,
>>   		 * Mark writer at the front of the queue for wakeup.
>>   		 * Until the task is actually later awoken later by
>>   		 * the caller, other writers are able to steal it.
>> +		 *
>> +		 * *Unless* HANDOFF is set, in which case only the
>> +		 * first waiter is allowed to take it.
>> +		 *
>>   		 * Readers, on the other hand, will block as they
>>   		 * will notice the queued writer.
>>   		 */
>>   		wake_q_add(wake_q, waiter->task);
>>   		lockevent_inc(rwsem_wake_writer);
>> +
>> +		if ((count & RWSEM_LOCK_MASK) || !(count & RWSEM_FLAG_HANDOFF))
>> +			return;
>> +
>> +		/*
>> +		 * If the rwsem is free and handoff flag is set with wait_lock
>> +		 * held, no other CPUs can take an active lock. We can do an
>> +		 * early handoff.
>> +		 */
>> +		adjustment = RWSEM_WRITER_LOCKED - RWSEM_FLAG_HANDOFF;
>> +		atomic_long_set(&sem->owner, (long)waiter->task);
>> +		waiter->task = NULL;
>> +		atomic_long_add(adjustment, &sem->count);
>> +		rwsem_del_waiter(sem, waiter);
>> +		lockevent_inc(rwsem_wlock_ehandoff);
>>   	}
> *sigh*... you can't even properly copy/paste from the reader side :/
> This is broken, the moment you do waiter->task = NULL, waiter can
> dissapear from under you and that rwsem_del_waiter() is a UaF.
>
> Nor did you unify the reader and writer side and still have a giant
> trainwreck on your hands..
>
> Surely all that isn't too hard... let me post it.
>
Right, I should keep the clearing after deleting the waiter. Thanks for 
spotting that. I will review your patches soon.

Cheers,
Longman

