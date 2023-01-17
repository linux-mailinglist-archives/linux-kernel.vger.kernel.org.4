Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E5AE66D4F9
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 04:29:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235412AbjAQD25 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 22:28:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235235AbjAQD2z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 22:28:55 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0837B227AF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 19:28:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673926086;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jsYjZCJ7jK48jJe07Q5I3hC4QGLC4+eAqFug+u5ymd4=;
        b=ZxBTQ8gtY4zvsB4bEbsTVgpAS9ZY9vu43TLjs+G/YROYo/tCDp4/D1pXzUxfAh/9KEchgw
        hBgDkuGsV2WqDG+g+JxAtm56mf4xtXjxYS1GHFODsCdoNgDzPVV+FQLVnt37pTE9HF00ED
        HBK91aMNC4rstHIOrItmj0o3gFz7Hc4=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-29-tbQTbLKrMCa1tuFpC-5bOA-1; Mon, 16 Jan 2023 22:28:02 -0500
X-MC-Unique: tbQTbLKrMCa1tuFpC-5bOA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 59E4C29AA2D6;
        Tue, 17 Jan 2023 03:28:02 +0000 (UTC)
Received: from [10.22.18.0] (unknown [10.22.18.0])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 001E0C15BA0;
        Tue, 17 Jan 2023 03:28:01 +0000 (UTC)
Message-ID: <8cfce359-2b55-5158-3a7f-d83a7be212f4@redhat.com>
Date:   Mon, 16 Jan 2023 22:28:01 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v2 (repost)] locking/lockdep: add
 debug_show_all_lock_holders()
Content-Language: en-US
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Ingo Molnar <mingo@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <41f43b27-d910-78e0-c0b3-f2885fe1cd22@I-love.SAKURA.ne.jp>
 <Y8J3gAXLf4yc0FcL@gmail.com>
 <e68b4c88-a278-90d0-0ce0-9d4e161366cc@I-love.SAKURA.ne.jp>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <e68b4c88-a278-90d0-0ce0-9d4e161366cc@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/14/23 04:53, Tetsuo Handa wrote:
> On 2023/01/14 18:36, Ingo Molnar wrote:
>> Yeah, so note how you introduce a function with a parameter:
>>
>> 	void __debug_show_all_locks(bool show_stack)
>>
>> ... only to then *hide* the new parameter via helper functions:
>>
>> 	static inline void debug_show_all_locks(void)
>> 	{
>> 		__debug_show_all_locks(false);
>> 	}
>>
>> 	static inline void debug_show_all_lock_holders(void)
>> 	{
>> 		__debug_show_all_locks(true);
>> 	}
>>
>> ... which is a *strong* hint by our universe that the new parameter was
>> probably a bad idea to begin with.
>>
>> Given how small debug_show_all_locks() is to begin with, I'd suggest simply
>> duplicating the loop into debug_show_all_lock_holders() or so.
> Initial version at https://lkml.kernel.org/r/82af40cc-bf85-2b53-b8f9-dfc12e66a781@I-love.SAKURA.ne.jp
> was duplicating the loop.
>
> Waiman Long suggested me not to duplicate the loop at
> https://lkml.kernel.org/r/3e027453-fda4-3891-3ec3-5623f1525e56@redhat.com .
>
> Please talk with Waiman. I'm fine with either approach.

My original concern was that two functions are very similar with some 
minor difference. My suggestion was to use a common helper to reduce the 
code redundancy and future maintenance.

I do have some nits about the patch. The show_stack parameter isn't 
informative. Maybe you can use show_tasks as the parameter name since 
the major difference is the calling of sched_show_task().

Define a new helper like debug_show_all_locks_tasks(bool show_tasks), 
use it directly in check_hung_uninterruptible_tasks() and make 
debug_show_all_lock() call debug_show_all_locks_tasks().

Ingo, will that OK with you?

Cheers,
Longman

