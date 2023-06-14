Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6344A72F3C4
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 06:50:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242640AbjFNEu3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 00:50:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242671AbjFNEuT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 00:50:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A2EBE61
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 21:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686718170;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qHRc1Mkyk+K0FJWIMqVw/kpFNdAJq+RCcKh1xxVrXLw=;
        b=Rcpi/lCBZg06UHbvygYlyW6Gn6VM0rw6QsqHY+iguzCaA2nZ2GPqr/fdApAdlAsDFHrxc1
        vb05V9HfQcoKhvAlK948+yMtCjv756gmj9EtxKB9fm18Y8dv7YvQEn4RUEFKRuCX4xjtPh
        8U6lNXs/nJXXyWX4qUfJRXMvYeHy7xM=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-377-2w9Z1wwIMlS6pv9Tu_APvA-1; Wed, 14 Jun 2023 00:49:27 -0400
X-MC-Unique: 2w9Z1wwIMlS6pv9Tu_APvA-1
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1b3cab3a48dso25018155ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 21:49:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686718166; x=1689310166;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qHRc1Mkyk+K0FJWIMqVw/kpFNdAJq+RCcKh1xxVrXLw=;
        b=fGlJjdHXVp1ZdSQNC//aAw88aZsNEnMNvDOwXaTbygS5jkB27z+ZgXvnZqmALcEt0E
         agx8Lp6FCDFKVb+Ju/7IO04tmtKbqF8U6IGCrokcyF9eFRUQTBHxsggG1YWWpxZK0wXi
         3YKwxUJQW+x6XKz3Apbp8KfZuk+UMfyv41XyXPgbMrZpQhT749phOphDFxs6xb3iI9/j
         ABHwjqwIMg8eO5GQuCQk5XuuK6qRo12p8JEt+A6R01YJCEG4Wo/riKHoRruXSKURbkID
         nMvq6Z8A/HEB4sKf4E4cDJPIT/C0TP4zMugCcCGlYc8gnHMCTIvbKKpwK9+wipK1En9P
         bpoA==
X-Gm-Message-State: AC+VfDyisS7tL7fuV9uGqVw1Z/eRBcrELJA6X0COOYhmZm1DPeHJAlPS
        Z2iyYvd9ZBWIEja/HAIbIVixi5oeXdPRE6kkaMcGD87AMSxatQhCt/Uzlwv4KSrCN/C5pwarpBP
        dnim/jCSRkyDq0PzFHS9D6zFv
X-Received: by 2002:a17:902:8205:b0:1b2:194b:9ce9 with SMTP id x5-20020a170902820500b001b2194b9ce9mr9570236pln.44.1686718166632;
        Tue, 13 Jun 2023 21:49:26 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7PpwOeO+Y52uGvEtrLcanj4UUyIOdRBtIgT2zh8VeLdrt+HFEs+yelLdJ8VFB3cWecP7/8Kw==
X-Received: by 2002:a17:902:8205:b0:1b2:194b:9ce9 with SMTP id x5-20020a170902820500b001b2194b9ce9mr9570219pln.44.1686718166272;
        Tue, 13 Jun 2023 21:49:26 -0700 (PDT)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id r21-20020a170902ea5500b001b19d14a3d5sm11107447plg.68.2023.06.13.21.49.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 21:49:25 -0700 (PDT)
Date:   Wed, 14 Jun 2023 12:49:21 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     io-uring <io-uring@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH] io_uring/io-wq: don't clear PF_IO_WORKER on exit
Message-ID: <20230614044921.7wxs7w3uncjns33i@zlang-mailbox>
References: <2392dcb4-71f4-1109-614b-4e2083c0941e@kernel.dk>
 <20230614005449.awc2ncxl5lb2eg6m@zlang-mailbox>
 <5d5ccbb1-784c-52b3-3748-2cf7b5cf01ef@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d5ccbb1-784c-52b3-3748-2cf7b5cf01ef@kernel.dk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 13, 2023 at 07:14:25PM -0600, Jens Axboe wrote:
> On 6/13/23 6:54?PM, Zorro Lang wrote:
> > On Mon, Jun 12, 2023 at 12:11:57PM -0600, Jens Axboe wrote:
> >> A recent commit gated the core dumping task exit logic on current->flags
> >> remaining consistent in terms of PF_{IO,USER}_WORKER at task exit time.
> >> This exposed a problem with the io-wq handling of that, which explicitly
> >> clears PF_IO_WORKER before calling do_exit().
> >>
> >> The reasons for this manual clear of PF_IO_WORKER is historical, where
> >> io-wq used to potentially trigger a sleep on exit. As the io-wq thread
> >> is exiting, it should not participate any further accounting. But these
> >> days we don't need to rely on current->flags anymore, so we can safely
> >> remove the PF_IO_WORKER clearing.
> >>
> >> Reported-by: Zorro Lang <zlang@redhat.com>
> >> Reported-by: Dave Chinner <david@fromorbit.com>
> >> Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
> >> Link: https://lore.kernel.org/all/ZIZSPyzReZkGBEFy@dread.disaster.area/
> >> Fixes: f9010dbdce91 ("fork, vhost: Use CLONE_THREAD to fix freezer/ps regression")
> >> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> >>
> >> ---
> > 
> > Hi,
> > 
> > This patch fix the issue I reported. The bug can be reproduced on v6.4-rc6,
> > then test passed on v6.4-rc6 with this patch.
> > 
> > But I found another KASAN bug [1] on aarch64 machine, by running generic/388.
> > I hit that 3 times. And hit a panic [2] (once after that kasan bug) on a x86_64
> > with pmem device (mount with dax=never), by running geneirc/388 too.
> 
> Can you try with this? I suspect the preempt dance isn't really
> necessary, but I can't quite convince myself that it isn't. In any case,
> I think this should fix it and this was exactly what I was worried about
> but apparently not able to easily trigger or prove...

Hi Jens,

Sure, I'm going to submit several new testing jobs to test this patch. BTW,
besides the kasan warning, I'm sure that mount with "dax=never" can crash the
kernel as [2], I just reproduced that. So it's worse than a kasan bug output.

Thanks,
Zorro

> 
> 
> diff --git a/io_uring/io-wq.c b/io_uring/io-wq.c
> index fe38eb0cbc82..878ec3feeba9 100644
> --- a/io_uring/io-wq.c
> +++ b/io_uring/io-wq.c
> @@ -220,7 +220,9 @@ static void io_worker_exit(struct io_worker *worker)
>  	list_del_rcu(&worker->all_list);
>  	raw_spin_unlock(&wq->lock);
>  	io_wq_dec_running(worker);
> -	worker->flags = 0;
> +	preempt_disable();
> +	current->worker_private = NULL;
> +	preempt_enable();
>  
>  	kfree_rcu(worker, rcu);
>  	io_worker_ref_put(wq);
> 
> -- 
> Jens Axboe
> 

