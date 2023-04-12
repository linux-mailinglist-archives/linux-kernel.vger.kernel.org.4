Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 547386DF4C4
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 14:11:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbjDLMLt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 08:11:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjDLMLq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 08:11:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCA7EB3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 05:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681301463;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7LSuDPeEIJ3aNmuAEBuRgkzCKJ5eoNSlQ7XYoj+AElo=;
        b=Nc6XkWtxZywWLnhgpTuWRcrIv0o5ViUEMdFxH/VMCd/zapNwooUF4DW7N+9xEbqrEfisZv
        Q42LsxKEcbC10P1CnwfhWeOr56BiFEDUlraLqMt8x/aXwdyA1tMxZv6+zebWiIAcHjfPKZ
        tW0UXZFcv0Q4LY5zox0oiT93LGw1ahQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-401-R4f4V4tLMyiJOkqtc4FdMw-1; Wed, 12 Apr 2023 08:10:59 -0400
X-MC-Unique: R4f4V4tLMyiJOkqtc4FdMw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 257B48996E1;
        Wed, 12 Apr 2023 12:10:59 +0000 (UTC)
Received: from [10.22.32.168] (unknown [10.22.32.168])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AD7DC1121320;
        Wed, 12 Apr 2023 12:10:58 +0000 (UTC)
Message-ID: <84e5f6d5-3217-e1cf-6a3f-c337a6737e5d@redhat.com>
Date:   Wed, 12 Apr 2023 08:10:58 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2] locking/rwsem: Add __always_inline annotation to
 __down_read_common()
Content-Language: en-US
To:     John Stultz <jstultz@google.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Minchan Kim <minchan@kernel.org>,
        Tim Murray <timmurray@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>, kernel-team@android.com,
        stable@vger.kernel.org
References: <20230412023839.2869114-1-jstultz@google.com>
 <20230412035905.3184199-1-jstultz@google.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20230412035905.3184199-1-jstultz@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/11/23 23:59, John Stultz wrote:
> Apparently despite it being marked inline, the compiler
> may not inline __down_read_common() which makes it difficult
> to identify the cause of lock contention, as the blocked
> function will always be listed as __down_read_common().
>
> So this patch adds __always_inline annotation to the
> function to force it to be inlines so the calling function
> will be listed.
>
> Cc: Minchan Kim <minchan@kernel.org>
> Cc: Tim Murray <timmurray@google.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Waiman Long <longman@redhat.com>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: kernel-team@android.com
> Cc: stable@vger.kernel.org
> Fixes: c995e638ccbb ("locking/rwsem: Fold __down_{read,write}*()")
> Reported-by: Tim Murray <timmurray@google.com>
> Signed-off-by: John Stultz <jstultz@google.com>
> ---
> v2: Reworked to use __always_inline instead of __sched as
>      suggested by Waiman Long
> ---
>   kernel/locking/rwsem.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
> index acb5a50309a1..e99eef8ea552 100644
> --- a/kernel/locking/rwsem.c
> +++ b/kernel/locking/rwsem.c
> @@ -1240,7 +1240,7 @@ static struct rw_semaphore *rwsem_downgrade_wake(struct rw_semaphore *sem)
>   /*
>    * lock for reading
>    */
> -static inline int __down_read_common(struct rw_semaphore *sem, int state)
> +static __always_inline int __down_read_common(struct rw_semaphore *sem, int state)
>   {
>   	int ret = 0;
>   	long count;
Reviewed-by: Waiman Long <longman@redhat.com>

