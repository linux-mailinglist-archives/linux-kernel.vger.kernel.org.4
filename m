Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD8A772CC18
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 19:10:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236341AbjFLRKk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 13:10:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236176AbjFLRK1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 13:10:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA55EE6
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 10:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686589781;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=o3x5Jqp9svWUEJlBaR37fMtGHfPwZ3q/oDq0tcjZVns=;
        b=Ff6XRQPtNLIe9uY8jC/Efl7WUBtGKq/dLeK6ZdCEdbjbmQmGo/cTSsvidjR4x0z7MEg2Oq
        KiuG07PiOtf4r34s14f1N1ib9iEPcEAM8Y5khxJIiLPeCMM94iPjf5sycDRP5xkkGg2Kx8
        uk3E9GsgM+I4zDMzsFYoMLT1Qvhn+0k=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-552-kNJSJI6zMPCl7QK55fItfg-1; Mon, 12 Jun 2023 13:09:39 -0400
X-MC-Unique: kNJSJI6zMPCl7QK55fItfg-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-3f5fa06debcso30499635e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 10:09:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686589778; x=1689181778;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o3x5Jqp9svWUEJlBaR37fMtGHfPwZ3q/oDq0tcjZVns=;
        b=Hs8rRQ2ZBKzqI34DEZJfTI8+ZXOcYXOdKCPVYZWOT2Clh9+6icmW08Apdhh/C/KnYX
         VON+2vfrMIkgeO85BMF6ys0aXP0icPKKdTJaoA3x/QCblykLCRyAZmZRJipeA/g/xFXK
         e1h2PWNneArULIVsko5PeSvZ0WIxdH9pO5IX3XE7bo6EfJeG+OoqE8yKY8/LHJfKlkMf
         ewGW14M8hSHDDxqLJgfYyIdLyrx2gKxLmwYGPQCPXUCFeVXiFSsC1aG7OTJAToVADmoU
         Qkke50XwjRL4L2lBB92n5jDmzMtyTVlyFtyXIOtguM9GodBJs5Iaq7cnDynz06xZRdxR
         f1ug==
X-Gm-Message-State: AC+VfDzcnfIAdRF5C/XIXYz+GBVqvfqR6xQKJXElI9cnxnXM9bhdAWFL
        JBSrLpyIMfkZFyudT7shz6UxgqQpqsra7P9cHiMk/I7oMPeEG/ahs7t6f4UaUY5eTw26rvnitaT
        LzaDdDYT4C4k5D0nY0hGzTUWFMCHBZKAy
X-Received: by 2002:a05:600c:cb:b0:3f7:6bd9:2819 with SMTP id u11-20020a05600c00cb00b003f76bd92819mr7388868wmm.29.1686589778157;
        Mon, 12 Jun 2023 10:09:38 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7nWjp7iROukoRx3QdDb1Ucz3BrypuugeOU3OCYTyx8Zc1xEtRgGB+SAOqjI1Yo/YCWeALfKw==
X-Received: by 2002:a05:600c:cb:b0:3f7:6bd9:2819 with SMTP id u11-20020a05600c00cb00b003f76bd92819mr7388858wmm.29.1686589777876;
        Mon, 12 Jun 2023 10:09:37 -0700 (PDT)
Received: from vschneid.remote.csb ([154.57.232.159])
        by smtp.gmail.com with ESMTPSA id l17-20020a1ced11000000b003f810be0231sm8205622wmh.32.2023.06.12.10.09.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 10:09:37 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Wang You <wangyoua@uniontech.com>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com
Cc:     linux-kernel@vger.kernel.org, Wang You <wangyoua@uniontech.com>
Subject: Re: [RFC PATCH] sched/wait: Determine whether the wait queue is
 empty before waking up
In-Reply-To: <20230609053812.10230-1-wangyoua@uniontech.com>
References: <20230609053812.10230-1-wangyoua@uniontech.com>
Date:   Mon, 12 Jun 2023 18:09:36 +0100
Message-ID: <xhsmhfs6wy5db.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/06/23 13:38, Wang You wrote:
> When we did some benchmark tests (such as pipe tests), we found
> that the wake behavior was still triggered when the wait queue
> was empty, even though it would exit later.
>
> This processing consumes some unnecessary resources. Can we
> determine at the beginning of the wake up whether there are
> elements in the queue that need to be awakened? I think this
> judgment is probably good for performance and should be safe.
>
> Looking forward to your reply, thank you.
>
> Signed-off-by: Wang You <wangyoua@uniontech.com>
> ---
>  kernel/sched/wait.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/kernel/sched/wait.c b/kernel/sched/wait.c
> index 133b74730738..17011780aa21 100644
> --- a/kernel/sched/wait.c
> +++ b/kernel/sched/wait.c
> @@ -205,6 +205,9 @@ void __wake_up_sync_key(struct wait_queue_head *wq_head, unsigned int mode,
>       if (unlikely(!wq_head))
>               return;
>
> +	if (unlikely(!wq_has_sleeper(wq_head)))
> +		return;
> +


Hm so I suppose that if we end up in wake_up*() then the update of the wait
condition has been done (so this shouldn't lead to missed wakeups), but
that still means an extra smp_mb() before grabbing the wq_head->lock.

I'd suggest benchmarking the change, this is going to cause unwanted
overhead when dealing with busy queues, and I'm not sure it's saving much
vs grabbing wq_head->lock before noticing the list is empty.


>       __wake_up_common_lock(wq_head, mode, 1, WF_SYNC, key);
>  }
>  EXPORT_SYMBOL_GPL(__wake_up_sync_key);
> --
> 2.20.1

