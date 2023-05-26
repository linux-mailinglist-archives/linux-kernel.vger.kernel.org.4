Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BCD0712C37
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 20:10:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbjEZSKa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 14:10:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjEZSK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 14:10:29 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EA67D3
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 11:10:26 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-3f7f864525fso10458251cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 11:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20221208.gappssmtp.com; s=20221208; t=1685124625; x=1687716625;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=37tg7T594fYkzDsLRmJ/Q/EtJuUqNxmb+GPO0Hq9YXs=;
        b=reDng+rZ41X+8kbVvk70QgEyAxMMtYhYluWthz2mr1dSMs9TYcu11xcUgRJVfXN/Sm
         jY2o62DOBoN88bBnQIE9rS9eSnRe5uBwY5reg87S0Fw8eF935S0hxcsnfE71Y2SfhuNE
         ouBIF281iuZI8dNIwTaZSuS2dCjDNsrCnQXulfe+I2wwCM3cjnnHIW9jI3oyIfOx4J31
         VNv5J4sXrExqpCPJEcJ60teSfibqRBVG8GM65lDtPTMncU5dCKEKP6G6Tl20n4mLq/5a
         gs835RbxW30qIs5A+9Qo5H8xsTkWrDMfI6hhLylFh4Vq0DMeXLRGsBWsMlx56KTFAbRT
         BkLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685124625; x=1687716625;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=37tg7T594fYkzDsLRmJ/Q/EtJuUqNxmb+GPO0Hq9YXs=;
        b=T/45p4I9q6u/GeW5qXWjEs9QWkkYOShwyD0OLYp3GTz8J1gdfarIlZA0VyiypVEqYh
         P62Vm6kXxsiAzXri/xR1z7+oMOngx/sWo9jzZVJeiyvhZm61arFT3q+7fJMuwHpQx4Ks
         PDM+gfi/1cr4N1PVmjoVTubPhttw5Xvz6sUAkh05fmYNMGQyuvtR6ssMHiuhwxQK4J4D
         9Ov2cDNtMZ8qccK6PC7/WBW4Ost2kJaHX0aGQZDtHeMEgv5+65TAT+NAZu/pZH1iq9VG
         KWohTXqVqDrQSEFi2jta6JjacuUlCtAZAKSp1IH6I3wsnh2vyZerqA6xQBvDxXU514M1
         Ep2Q==
X-Gm-Message-State: AC+VfDx7YSMMBoeDDqZdMggRQGAv+KGo9mSU4U1xM2OEmJ0bscrcO+XC
        gahzqWg0EFfD5815GQ5uB/z/KA==
X-Google-Smtp-Source: ACHHUZ6oawaOs+6t1Ee0cteRC9QmCsKo/5UJS1rWK9TQ6iGOtaGL//yRiVETzvyhQ+kUGwyk5HaOjQ==
X-Received: by 2002:a05:6214:29ec:b0:625:8b9a:b426 with SMTP id jv12-20020a05621429ec00b006258b9ab426mr2902811qvb.46.1685124625036;
        Fri, 26 May 2023 11:10:25 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:8bb6])
        by smtp.gmail.com with ESMTPSA id g14-20020ae9e10e000000b0075cb3e8ad1fsm764918qkm.83.2023.05.26.11.10.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 May 2023 11:10:24 -0700 (PDT)
Date:   Fri, 26 May 2023 14:10:23 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Domenico Cerasuolo <cerasuolodomenico@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        sjenning@redhat.com, ddstreet@ieee.org, vitaly.wool@konsulko.com,
        yosryahmed@google.com, kernel-team@fb.com
Subject: Re: [PATCH v2] mm: zswap: shrink until can accept
Message-ID: <20230526181023.GA49039@cmpxchg.org>
References: <20230526173955.781115-1-cerasuolodomenico@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230526173955.781115-1-cerasuolodomenico@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 26, 2023 at 07:39:55PM +0200, Domenico Cerasuolo wrote:
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
> Fixes: 45190f01dd40 ("mm/zswap.c: add allocation hysteresis if pool limit is hit")
> Signed-off-by: Domenico Cerasuolo <cerasuolodomenico@gmail.com>
> ---
>  mm/zswap.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 59da2a415fbb..f953dceaab34 100644
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
> @@ -587,9 +588,17 @@ static void shrink_worker(struct work_struct *w)
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
> +			failures++;
> +		}
> +		cond_resched();
> +	} while (!zswap_can_accept() && ret == -EAGAIN &&
> +		 failures < MAX_RECLAIM_RETRIES);

It should also loop on !ret, right?

AFAIU Yosry's suggestion was that instead of breaking only on -EINVAL,
it should break on all failures but -EAGAIN. But it should still keep
going if the shrink was successful and the pool cannot accept yet.

Basically, something like this?

	do {
		ret = zpool_shrink(pool->zpool, 1, NULL);
		if (ret) {
			zswap_reject_reclaim_fail++;
			if (ret != -EAGAIN)
				break;
			if (++failures == MAX_RECLAIM_RETRIES)
				break;
		}
		cond_resched();
	} while (!zswap_can_accept());
