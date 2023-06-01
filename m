Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E5E371A1F9
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 17:09:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235018AbjFAPGd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 11:06:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234956AbjFAPEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 11:04:54 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABA06E7F
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 08:03:39 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id 5614622812f47-39a523e8209so577316b6e.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 08:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20221208.gappssmtp.com; s=20221208; t=1685631818; x=1688223818;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eNsTwu+7vxM1RFU/Tn3oHzsU6bxLHTIeMbI3R+ogjXA=;
        b=LeTKb0EILlqE1OXr+Mlwp65bVj3bWGlDOkp3U/oOIOaKnlmPetNZ2uFhIwBkEztbz9
         X8Eq3mRBsLJmCE4K4DTCqCpcp1srAigSRD88Ihel3lvVHD2J4OD9kcyYjZO1jiwg2So7
         DG5P8XTk4CeOP3AiOoZ7+6tR+N+NbwtxNOy7zQqsKOZYHjQdUptGXEG76aV2A3jLOSCx
         9c27yUVnoHI7KwHBX2bWsoPLbJO7uH1yRhe0JrjnfzmWkHSjaKyAd4fIrAI0W0ZXQ8bv
         LvY+nHDQzNQEvIdQX5hpTyVd9eYHrfBC63ZARTw2+Bs/cmJYluDGAEM0ASqc1iQrWgN9
         IasA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685631818; x=1688223818;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eNsTwu+7vxM1RFU/Tn3oHzsU6bxLHTIeMbI3R+ogjXA=;
        b=FF9UwDV5Oyf1+X/lqL+1TL+FkxEJYN0zmfXimS0hvKQhPiVPJDfDXzYyPnDXjKwN2L
         sez0IxNBmjKp4jgVoqyY28gv8RctpvOblMpRxeZuGTVz1yJ4s+smAD7Nel+BatOZnuO1
         tvb/QvAjh2GFBYSbAiEzYcHzVk+BOTxLKXihLd4Zjk+V7WX2d1T/Y2NVPJ30CP1gYJLo
         7BdN0XF4e9DgjwhbYoGcufAuYkuPaQxtjuMzB08QVAsTPN+fPzu588UF0vYhgV/hUPXu
         1XLJMDQpuAufl2P27z145En16SoiztKL1Wp32oEKlIfu22JSac8SOnX5/Cx9MxHfqIfl
         bHJA==
X-Gm-Message-State: AC+VfDxQ+xue9uUJw6QXJwhLIQ5nxxnS6GKxRY1p+zIBZ1bn9ibUqlkQ
        b4IpypjN5Ywdk5hNfp+57UZ2KA==
X-Google-Smtp-Source: ACHHUZ5PJp/Xx8aqEvA22Sw24+fxrSppG/Z2XySDE6JBF3CFlK8LUtkzy2a6JJBy1oUh1SohxS4i1w==
X-Received: by 2002:a54:4e01:0:b0:398:2b60:dbf7 with SMTP id a1-20020a544e01000000b003982b60dbf7mr5988323oiy.17.1685631817976;
        Thu, 01 Jun 2023 08:03:37 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:ec58])
        by smtp.gmail.com with ESMTPSA id o9-20020a056214108900b005fdbcab3065sm2951524qvr.72.2023.06.01.08.03.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 08:03:37 -0700 (PDT)
Date:   Thu, 1 Jun 2023 11:03:36 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Domenico Cerasuolo <cerasuolodomenico@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        sjenning@redhat.com, ddstreet@ieee.org, vitaly.wool@konsulko.com,
        yosryahmed@google.com, kernel-team@fb.com,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v3] mm: zswap: shrink until can accept
Message-ID: <20230601150336.GE102494@cmpxchg.org>
References: <20230526183227.793977-1-cerasuolodomenico@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230526183227.793977-1-cerasuolodomenico@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks like Andrew wasn't CC'd on this one.

Andrew, would you mind picking this up? Thanks!

On Fri, May 26, 2023 at 08:32:27PM +0200, Domenico Cerasuolo wrote:
> This update addresses an issue with the zswap reclaim mechanism, which
> hinders the efficient offloading of cold pages to disk, thereby
> compromising the preservation of the LRU order and consequently
> diminishing, if not inverting, its performance benefits.
> 
> The functioning of the zswap shrink worker was found to be inadequate,
> as shown by basic benchmark test. For the test, a kernel build was
> utilized as a reference, with its memory confined to 1G via a cgroup and
> a 5G swap file provided. The results are presented below, these are
> averages of three runs without the use of zswap:
> 
> real 46m26s
> user 35m4s
> sys 7m37s
> 
> With zswap (zbud) enabled and max_pool_percent set to 1 (in a 32G
> system), the results changed to:
> 
> real 56m4s
> user 35m13s
> sys 8m43s
> 
> written_back_pages: 18
> reject_reclaim_fail: 0
> pool_limit_hit:1478
> 
> Besides the evident regression, one thing to notice from this data is
> the extremely low number of written_back_pages and pool_limit_hit.
> 
> The pool_limit_hit counter, which is increased in zswap_frontswap_store
> when zswap is completely full, doesn't account for a particular
> scenario: once zswap hits his limit, zswap_pool_reached_full is set to
> true; with this flag on, zswap_frontswap_store rejects pages if zswap is
> still above the acceptance threshold. Once we include the rejections due
> to zswap_pool_reached_full && !zswap_can_accept(), the number goes from
> 1478 to a significant 21578266.
> 
> Zswap is stuck in an undesirable state where it rejects pages because
> it's above the acceptance threshold, yet fails to attempt memory
> reclaimation. This happens because the shrink work is only queued when
> zswap_frontswap_store detects that it's full and the work itself only
> reclaims one page per run.
> 
> This state results in hot pages getting written directly to disk,
> while cold ones remain memory, waiting only to be invalidated. The LRU
> order is completely broken and zswap ends up being just an overhead
> without providing any benefits.
> 
> This commit applies 2 changes: a) the shrink worker is set to reclaim
> pages until the acceptance threshold is met and b) the task is also
> enqueued when zswap is not full but still above the threshold.
> 
> Testing this suggested update showed much better numbers:
> 
> real 36m37s
> user 35m8s
> sys 9m32s
> 
> written_back_pages: 10459423
> reject_reclaim_fail: 12896
> pool_limit_hit: 75653
> 
> V2:
> - loop against == -EAGAIN rather than != -EINVAL and also break the loop
> on MAX_RECLAIM_RETRIES (thanks Yosry)
> - cond_resched() to ensure that the loop doesn't burn the cpu (thanks
> Vitaly)
> 
> V3:
> - fix wrong loop break, should continue on !ret (thanks Johannes)
> 
> Fixes: 45190f01dd40 ("mm/zswap.c: add allocation hysteresis if pool limit is hit")
> Signed-off-by: Domenico Cerasuolo <cerasuolodomenico@gmail.com>
> ---
>  mm/zswap.c | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 59da2a415fbb..bcb82e09eb64 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -37,6 +37,7 @@
>  #include <linux/workqueue.h>
>  
>  #include "swap.h"
> +#include "internal.h"
>  
>  /*********************************
>  * statistics
> @@ -587,9 +588,19 @@ static void shrink_worker(struct work_struct *w)
>  {
>  	struct zswap_pool *pool = container_of(w, typeof(*pool),
>  						shrink_work);
> +	int ret, failures = 0;
>  
> -	if (zpool_shrink(pool->zpool, 1, NULL))
> -		zswap_reject_reclaim_fail++;
> +	do {
> +		ret = zpool_shrink(pool->zpool, 1, NULL);
> +		if (ret) {
> +			zswap_reject_reclaim_fail++;
> +			if (ret != -EAGAIN)
> +				break;
> +			if (++failures == MAX_RECLAIM_RETRIES)
> +				break;
> +		}
> +		cond_resched();
> +	} while (!zswap_can_accept());
>  	zswap_pool_put(pool);
>  }
>  
> @@ -1188,7 +1199,7 @@ static int zswap_frontswap_store(unsigned type, pgoff_t offset,
>  	if (zswap_pool_reached_full) {
>  	       if (!zswap_can_accept()) {
>  			ret = -ENOMEM;
> -			goto reject;
> +			goto shrink;
>  		} else
>  			zswap_pool_reached_full = false;
>  	}
> -- 
> 2.34.1
> 
