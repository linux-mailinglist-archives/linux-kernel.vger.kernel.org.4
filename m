Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 506A96450B2
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 02:05:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbiLGBFW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 20:05:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbiLGBFU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 20:05:20 -0500
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B6009581
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 17:05:20 -0800 (PST)
Received: by mail-pj1-f46.google.com with SMTP id t17so16108904pjo.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Dec 2022 17:05:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kDHXNdP6MSMMsA/w0febLQLYepjyZbaxc8wqoj5tAiM=;
        b=FaaSr4FFITQCO/fd0LD4/QYYm1r31G3D5IXq8AsZeNk6f6KCFR+RwFYE80adr2fxvN
         TsP3VQkIa9LpmldzIFV9NEUPrtOQzS92LIJRPCnZkUlUtHkzY3zovILG/T975S4nJsE5
         eXYUaPEiewNMCjnEkhGwMSuQXLMzKbAhLN7r9jZxEckuVpwvzOyeCJtaQwVeNAAm8tsV
         Lq5xicOIvoRSOIzQp7G4TpzNbbrwX/0BjMBJttNBLXW61BQV74A3JQ7MyD5TYeCbqo9z
         rwU/OJajT8+9Y1lbbHL5d8MMf7XJz7+5d3guTer/yIwOArG5ND/pb40LdombNd7cbYoz
         /osw==
X-Gm-Message-State: ANoB5pmkR7wSCCNDjtzd4XGB8I7PSiB7yABtKtbx3Um+YqXhX8yXQIu8
        iiR+1oHv0dunOgD95WJ0SqE=
X-Google-Smtp-Source: AA0mqf5yQUGmm/AHSLd619YeNEcEdOyfosSo9fU5Ru7AmzyQYKBEqV96pi5U077piuNPUeIQDNWIrA==
X-Received: by 2002:a17:90b:3c4e:b0:219:e628:acf0 with SMTP id pm14-20020a17090b3c4e00b00219e628acf0mr9508654pjb.149.1670375119479;
        Tue, 06 Dec 2022 17:05:19 -0800 (PST)
Received: from fedora (148-64-108-50.PUBLIC.monkeybrains.net. [148.64.108.50])
        by smtp.gmail.com with ESMTPSA id j10-20020a170902c3ca00b001869f2120absm13197201plj.294.2022.12.06.17.05.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 17:05:19 -0800 (PST)
Date:   Tue, 6 Dec 2022 17:05:16 -0800
From:   Dennis Zhou <dennis@kernel.org>
To:     Zhong Jinghua <zhongjinghua@huawei.com>
Cc:     tj@kernel.org, cl@linux.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yukuai3@huawei.com
Subject: Re: [PATCH-next] block: fix null-deref in percpu_ref_put
Message-ID: <Y4/mzMd4evRg9yDi@fedora>
References: <20221206090939.871239-1-zhongjinghua@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221206090939.871239-1-zhongjinghua@huawei.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tue, Dec 06, 2022 at 05:09:39PM +0800, Zhong Jinghua wrote:
> A problem was find in stable 5.10 and the root cause of it like below.
> 
> In the use of q_usage_counter of request_queue, blk_cleanup_queue using
> "wait_event(q->mq_freeze_wq, percpu_ref_is_zero(&q->q_usage_counter))"
> to wait q_usage_counter becoming zero. however, if the q_usage_counter
> becoming zero quickly, and percpu_ref_exit will execute and ref->data
> will be freed, maybe another process will cause a null-defef problem
> like below:
> 
> 	CPU0                             CPU1
> blk_mq_destroy_queue
>  blk_freeze_queue
>   blk_mq_freeze_queue_wait
> 				scsi_end_request
> 				 percpu_ref_get
> 				 ...
> 				 percpu_ref_put
> 				  atomic_long_sub_and_test
>  blk_put_queue
>   kobject_put
>    kref_put
>     blk_release_queue
>      percpu_ref_exit
>       ref->data -> NULL
>    				   ref->data->release(ref) -> null-deref
> 

I remember thinking about this a while ago. I don't think this fix works
as nicely as it may seem. Please correct me if I'm wrong.

q->q_usage_counter has the oddity that the lifetime of the percpu_ref
object isn't managed by the release function. The freeing is handled by
a separate path where it depends on the percpu_ref hitting 0. So here we
have 2 concurrent paths racing to run with 1 destroying the object. We
probably need blk_release_queue() to wait on percpu_ref's release
finishing, not starting.

I think the above works in this specific case because there is a
call_rcu() in blk_release_queue(). If there wasn't a call_rcu(),
then by the same logic we could delay ref->data->release(ref) further
and that could potentially lead to a use after free.

Ideally, I think fixing the race in q->q_usage_counter's pattern is
better than masking it here as I think we're being saved by the
call_rcu() call further down the object release path.

Thanks,
Dennis

> As suggested by Ming Lei, fix it by getting the release method before
> the referebce count is minus 0.
> 
> Suggested-by: Ming Lei <ming.lei@redhat.com>
> Signed-off-by: Zhong Jinghua <zhongjinghua@huawei.com>
> ---
>  include/linux/percpu-refcount.h | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/percpu-refcount.h b/include/linux/percpu-refcount.h
> index d73a1c08c3e3..11e717c95acb 100644
> --- a/include/linux/percpu-refcount.h
> +++ b/include/linux/percpu-refcount.h
> @@ -331,8 +331,11 @@ static inline void percpu_ref_put_many(struct percpu_ref *ref, unsigned long nr)
>  
>  	if (__ref_is_percpu(ref, &percpu_count))
>  		this_cpu_sub(*percpu_count, nr);
> -	else if (unlikely(atomic_long_sub_and_test(nr, &ref->data->count)))
> -		ref->data->release(ref);
> +	else {
> +		percpu_ref_func_t *release = ref->data->release;
> +		if (unlikely(atomic_long_sub_and_test(nr, &ref->data->count)))
> +			release(ref);
> +	}
>  
>  	rcu_read_unlock();
>  }
> -- 
> 2.31.1
> 
