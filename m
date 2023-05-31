Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 441D8717619
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 07:23:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234040AbjEaFXU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 01:23:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231314AbjEaFXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 01:23:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D94DA11B
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 22:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685510551;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WEQ7TS+vyvsvSkbc945GTeCJNzt8/T2iPFI6Ja2m7Tc=;
        b=B5qdfblkVVKKuA/r00eamUpEVrRISfsUxEhRpqkqeKdyC2ygEVvMNkQT7KaPeysnHw0SGX
        RNL1wG1KKnymrKvnOxZ2LaoVuIM5q5nCMwIABwuxnwBcm4m0fO+7uuRbFi3SMebqVIXAJj
        Wlyc5pkhT/Nv1YbyN1WZ0xJF4GG6Pb0=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-b6QmNHAJPGiU6rCIa8qxjw-1; Wed, 31 May 2023 01:22:29 -0400
X-MC-Unique: b6QmNHAJPGiU6rCIa8qxjw-1
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-53450fa3a18so4670462a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 22:22:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685510549; x=1688102549;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WEQ7TS+vyvsvSkbc945GTeCJNzt8/T2iPFI6Ja2m7Tc=;
        b=b12gs2+OdWMzlOufJ6M3F8StiGE9a+vqJy2mvjGz8fnDKZOwo9836VUYBDde8DQoLy
         PY0APVwcdNF8yl4eGXJwdndwsjmmA1tOj6F7ZQsGQhHBNJP8IPXRKZU5FK/JVuPfWO0t
         teLJAvpPehdR7RCEEVbfWlYol2jV2RYXsQxuq4wMWggPJo+E8RhM1KR+yK1qF0gZ2ZsV
         Lt8mM85XrIfsidEAr8fQ+RLu5bN+TpcOGYCxa75vM/bnt7u+6e/0OZNGz6NpeFdM4TLz
         RYbIP5IVnEMuLtCJwLtMJ63qYRUWP7M+H4dxiTDA5HZ2FK+RArdqAzy9JSYZ6rCInqYU
         NlkA==
X-Gm-Message-State: AC+VfDyyroQWyu8b4eOsNQ/5VMhRGFA4BbOos3H7K3tfGerzUKik7Fn6
        BICFsv7vIisflaqdESpKKdcDqkM0lqmZmMPZIIFh2BRyxsia4LWCNFB3v7eO09lLWd7ZC9dpuC3
        rJDskK28okpIPw2JIlAMfWyLL
X-Received: by 2002:a05:6a20:7fa7:b0:105:8173:93a0 with SMTP id d39-20020a056a207fa700b00105817393a0mr6006068pzj.5.1685510548712;
        Tue, 30 May 2023 22:22:28 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7u0/KbgtxubOa7ggKO6fzLX5KAxiKr4jwHXNkdUFKNRBJw5oMEaCK0s5MaabHczQzM6Lyt9Q==
X-Received: by 2002:a05:6a20:7fa7:b0:105:8173:93a0 with SMTP id d39-20020a056a207fa700b00105817393a0mr6006055pzj.5.1685510548453;
        Tue, 30 May 2023 22:22:28 -0700 (PDT)
Received: from [10.72.13.48] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id s11-20020aa7828b000000b0063d670ad850sm2582842pfm.92.2023.05.30.22.22.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 May 2023 22:22:28 -0700 (PDT)
Message-ID: <26c87be0-8e19-d677-a51b-e6821e6f7ae4@redhat.com>
Date:   Wed, 31 May 2023 13:22:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH 3/3] fork, vhost: Use CLONE_THREAD to fix freezer/ps
 regression
To:     Oleg Nesterov <oleg@redhat.com>,
        Mike Christie <michael.christie@oracle.com>
Cc:     linux@leemhuis.info, nicolas.dichtel@6wind.com, axboe@kernel.dk,
        ebiederm@xmission.com, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, mst@redhat.com,
        sgarzare@redhat.com, stefanha@redhat.com, brauner@kernel.org
References: <20230522025124.5863-1-michael.christie@oracle.com>
 <20230522025124.5863-4-michael.christie@oracle.com>
 <20230522123029.GA22159@redhat.com>
 <cfca7764-d210-6df9-e182-2c093101c6cf@oracle.com>
 <20230522174757.GC22159@redhat.com> <20230523121506.GA6562@redhat.com>
Content-Language: en-US
From:   Jason Wang <jasowang@redhat.com>
In-Reply-To: <20230523121506.GA6562@redhat.com>
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


在 2023/5/23 20:15, Oleg Nesterov 写道:
> On 05/22, Oleg Nesterov wrote:
>> Right now I think that "int dead" should die,
> No, probably we shouldn't call get_signal() if we have already dequeued SIGKILL.
>
>> but let me think tomorrow.
> May be something like this... I don't like it but I can't suggest anything better
> right now.
>
> 	bool killed = false;
>
> 	for (;;) {
> 		...
> 	
> 		node = llist_del_all(&worker->work_list);
> 		if (!node) {
> 			schedule();
> 			/*
> 			 * When we get a SIGKILL our release function will
> 			 * be called. That will stop new IOs from being queued
> 			 * and check for outstanding cmd responses. It will then
> 			 * call vhost_task_stop to tell us to return and exit.
> 			 */
> 			if (signal_pending(current)) {
> 				struct ksignal ksig;
>
> 				if (!killed)
> 					killed = get_signal(&ksig);
>
> 				clear_thread_flag(TIF_SIGPENDING);
> 			}
>
> 			continue;
> 		}
>
> -------------------------------------------------------------------------------
> But let me ask a couple of questions. Let's forget this patch, let's look at the
> current code:
>
> 		node = llist_del_all(&worker->work_list);
> 		if (!node)
> 			schedule();
>
> 		node = llist_reverse_order(node);
> 		... process works ...
>
> To me this looks a bit confusing. Shouldn't we do
>
> 		if (!node) {
> 			schedule();
> 			continue;
> 		}
>
> just to make the code a bit more clear? If node == NULL then
> llist_reverse_order() and llist_for_each_entry_safe() will do nothing.
> But this is minor.


Yes.


>
>
>
> 		/* make sure flag is seen after deletion */
> 		smp_wmb();
> 		llist_for_each_entry_safe(work, work_next, node, node) {
> 			clear_bit(VHOST_WORK_QUEUED, &work->flags);
>
> I am not sure about smp_wmb + clear_bit. Once we clear VHOST_WORK_QUEUED,
> vhost_work_queue() can add this work again and change work->node->next.
>
> That is why we use _safe, but we need to ensure that llist_for_each_safe()
> completes LOAD(work->node->next) before VHOST_WORK_QUEUED is cleared.


This should be fine since store is not speculated, so work->node->next 
needs to be loaded before VHOST_WORK_QUEUED is cleared to meet the loop 
condition.


> So it seems that smp_wmb() can't help and should be removed, instead we need
>
> 		llist_for_each_entry_safe(...) {
> 			smp_mb__before_atomic();
> 			clear_bit(VHOST_WORK_QUEUED, &work->flags);
>
> Also, if the work->fn pointer is not stable, we should read it before
> smp_mb__before_atomic() as well.


The fn won't be changed after it is initialized.


>
> No?
>
>
> 			__set_current_state(TASK_RUNNING);
>
> Why do we set TASK_RUNNING inside the loop? Does this mean that work->fn()
> can return with current->state != RUNNING ?


It is because the state were set to TASK_INTERRUPTIBLE in the beginning 
of the loop otherwise it might be side effect while executing work->fn().


>
>
> 			work->fn(work);
>
> Now the main question. Whatever we do, SIGKILL/SIGSTOP/etc can come right
> before we call work->fn(). Is it "safe" to run this callback with
> signal_pending() or fatal_signal_pending() ?


It looks safe since:

1) vhost hold refcnt of the mm
2) release will sync with the worker


>
>
> Finally. I never looked into drivers/vhost/ before so I don't understand
> this code at all, but let me ask anyway... Can we change vhost_dev_flush()
> to run the pending callbacks rather than wait for vhost_worker() ?
> I guess we can't, ->mm won't be correct, but can you confirm?


Yes.

Thanks


>
> Oleg.
>

