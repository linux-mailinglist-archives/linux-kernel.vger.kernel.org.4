Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 425AA717617
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 07:23:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233608AbjEaFWz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 01:22:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbjEaFWw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 01:22:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55F5C107
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 22:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685510537;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hyyMYTFvM0Mbkvw27bbtYVzj+3x2ZRPx23KOzo9PcFU=;
        b=SoggA5xsx90IxacQGVY8qnZpFgJ2Gp0LGgzLBR8JeXq4cNDOov8Ml3qGEEW4WsYAMnemDX
        V9LdmRdg9gM8D5TfndlP8AuRY0C4KylEwhApk1K9ZHDldkZ3d0mOpfE/SpiBxLoE17NSh8
        tMVGvlsQLbOLqb1oBPzR6LNuKVlrSug=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-177-QfLekO_4OCe4CvFBcbOklQ-1; Wed, 31 May 2023 01:22:15 -0400
X-MC-Unique: QfLekO_4OCe4CvFBcbOklQ-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2563afb0150so4822077a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 22:22:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685510534; x=1688102534;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hyyMYTFvM0Mbkvw27bbtYVzj+3x2ZRPx23KOzo9PcFU=;
        b=DG6hKqaWXZZyEwKnUxyNaMaztEAv3PRgRRljkvJsM0Zettcjy9zZU7gU6y117V9lv2
         Cm8vXvwi/+VxYRnwxenRj5rz7vHDfSRZmlxv12m+b/onVz9T8JxvzgduXqmLO1h1Y4GK
         jGIjX7EnM8GT3Zl9Rj2aovuqiq4vZX2Lw4rMRRsVwpUZONAgM9kr+nQ7J3luzZcbO1ZC
         h6rjxbo9bPYrH3+lq7/5M9FkY73yWkkCf8lNDAKmnmCJmc9HgrTZi+DCO16Xqw0DsEp6
         /0ycbaR75uBkJui5tYbmIWBrm0qGtPWFgY06h2dNZxALkBKMPkfmnqnQYrbjtvOrHml1
         zR3w==
X-Gm-Message-State: AC+VfDzchMFx/V7SVoaDcLd88ac06Vzd2Y8sU51vjB7zvGBygxgFesMQ
        G8TSOqhsI9O0Ecr4qPEzTEmfJhn60cxIS5Fxd+LZbbJsOAY6YWRj+aTeJvpzVpGi+A4CuHTzAzl
        THFDQW39+Le4X/L5kzdQI55B/
X-Received: by 2002:a17:903:32c5:b0:1a2:6257:36b9 with SMTP id i5-20020a17090332c500b001a2625736b9mr5737391plr.31.1685510534160;
        Tue, 30 May 2023 22:22:14 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5NKnnkrfvWoHVrOcZULHtbOJ9PTxVtzJ5WaIVNPRr3IRbwtd4MYYnRfhK2JfjixmtArqhmkA==
X-Received: by 2002:a17:903:32c5:b0:1a2:6257:36b9 with SMTP id i5-20020a17090332c500b001a2625736b9mr5737373plr.31.1685510533888;
        Tue, 30 May 2023 22:22:13 -0700 (PDT)
Received: from [10.72.13.48] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id e13-20020a170902d38d00b001b033873744sm253550pld.249.2023.05.30.22.22.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 May 2023 22:22:13 -0700 (PDT)
Message-ID: <e8c702f3-e364-c624-1ff5-1f3da624d538@redhat.com>
Date:   Wed, 31 May 2023 13:22:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH 3/3] fork, vhost: Use CLONE_THREAD to fix freezer/ps
 regression
Content-Language: en-US
To:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>
Cc:     Mike Christie <michael.christie@oracle.com>, linux@leemhuis.info,
        nicolas.dichtel@6wind.com, axboe@kernel.dk,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, mst@redhat.com,
        sgarzare@redhat.com, stefanha@redhat.com, brauner@kernel.org
References: <20230522025124.5863-1-michael.christie@oracle.com>
 <20230522025124.5863-4-michael.christie@oracle.com>
 <20230522123029.GA22159@redhat.com>
 <cfca7764-d210-6df9-e182-2c093101c6cf@oracle.com>
 <20230522174757.GC22159@redhat.com> <20230523121506.GA6562@redhat.com>
 <87bkib6nxr.fsf@email.froward.int.ebiederm.org>
From:   Jason Wang <jasowang@redhat.com>
In-Reply-To: <87bkib6nxr.fsf@email.froward.int.ebiederm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2023/5/23 23:57, Eric W. Biederman 写道:
> Oleg Nesterov <oleg@redhat.com> writes:
>
>> On 05/22, Oleg Nesterov wrote:
>>> Right now I think that "int dead" should die,
>> No, probably we shouldn't call get_signal() if we have already
>> dequeued SIGKILL.
> Very much agreed.  It is one thing to add a patch to move do_exit
> out of get_signal.  It is another to keep calling get_signal after
> that.  Nothing tests that case, and so we get some weird behaviors.
>
>
>>> but let me think tomorrow.
>> May be something like this... I don't like it but I can't suggest anything better
>> right now.
>>
>> 	bool killed = false;
>>
>> 	for (;;) {
>> 		...
>> 	
>> 		node = llist_del_all(&worker->work_list);
>> 		if (!node) {
>> 			schedule();
>> 			/*
>> 			 * When we get a SIGKILL our release function will
>> 			 * be called. That will stop new IOs from being queued
>> 			 * and check for outstanding cmd responses. It will then
>> 			 * call vhost_task_stop to tell us to return and exit.
>> 			 */
>> 			if (signal_pending(current)) {
>> 				struct ksignal ksig;
>>
>> 				if (!killed)
>> 					killed = get_signal(&ksig);
>>
>> 				clear_thread_flag(TIF_SIGPENDING);
>> 			}
>>
>> 			continue;
>> 		}
> I want to point out that we need to consider not just SIGKILL, but
> SIGABRT that causes a coredump, as well as the process peforming
> an ordinary exit(2).  All of which will cause get_signal to return
> SIGKILL in this context.
>
>> -------------------------------------------------------------------------------
>> But let me ask a couple of questions.
> I share most of these questions.
>
>> Let's forget this patch, let's look at the
>> current code:
>>
>> 		node = llist_del_all(&worker->work_list);
>> 		if (!node)
>> 			schedule();
>>
>> 		node = llist_reverse_order(node);
>> 		... process works ...
>>
>> To me this looks a bit confusing. Shouldn't we do
>>
>> 		if (!node) {
>> 			schedule();
>> 			continue;
>> 		}
>>
>> just to make the code a bit more clear? If node == NULL then
>> llist_reverse_order() and llist_for_each_entry_safe() will do nothing.
>> But this is minor.
>>
>>
>>
>> 		/* make sure flag is seen after deletion */
>> 		smp_wmb();
>> 		llist_for_each_entry_safe(work, work_next, node, node) {
>> 			clear_bit(VHOST_WORK_QUEUED, &work->flags);
>>
>> I am not sure about smp_wmb + clear_bit. Once we clear VHOST_WORK_QUEUED,
>> vhost_work_queue() can add this work again and change work->node->next.
>>
>> That is why we use _safe, but we need to ensure that llist_for_each_safe()
>> completes LOAD(work->node->next) before VHOST_WORK_QUEUED is cleared.
>>
>> So it seems that smp_wmb() can't help and should be removed, instead we need
>>
>> 		llist_for_each_entry_safe(...) {
>> 			smp_mb__before_atomic();
>> 			clear_bit(VHOST_WORK_QUEUED, &work->flags);
>>
>> Also, if the work->fn pointer is not stable, we should read it before
>> smp_mb__before_atomic() as well.
>>
>> No?
>>
>>
>> 			__set_current_state(TASK_RUNNING);
>>
>> Why do we set TASK_RUNNING inside the loop? Does this mean that work->fn()
>> can return with current->state != RUNNING ?
>>
>>
>> 			work->fn(work);
>>
>> Now the main question. Whatever we do, SIGKILL/SIGSTOP/etc can come right
>> before we call work->fn(). Is it "safe" to run this callback with
>> signal_pending() or fatal_signal_pending() ?
>>
>>
>> Finally. I never looked into drivers/vhost/ before so I don't understand
>> this code at all, but let me ask anyway... Can we change vhost_dev_flush()
>> to run the pending callbacks rather than wait for vhost_worker() ?
>> I guess we can't, ->mm won't be correct, but can you confirm?
> In a conversation long ago I remember hearing that vhost does not
> support file descriptor passing.  Which means all of the file
> descriptors should be in the same process.


It's not. Actually passing vhost fd is pretty common since Qemu is 
usually running without privilege. So it's the charge of the management 
layer to open vhost fd and pass it to Qemu.


>
> Looking at the vhost code what I am seeing happening is that the
> vhost_worker persists until vhost_dev_cleanup is called from
> one of the vhost_???_release() functions.  The release functions
> are only called after the last flush function completes.  See __fput
> if you want to trace the details.
>
>
> On one hand this all seems reasonable.  On the other hand I am not
> seeing the code that prevents file descriptor passing.


Yes.


>
>
> It is probably not the worst thing in the world, but what this means
> is now if you pass a copy of the vhost file descriptor to another
> process the vhost_worker will persist, and thus the process will persist
> until that copy of the file descriptor is closed.


Right.

Thanks


>
> Eric
>

