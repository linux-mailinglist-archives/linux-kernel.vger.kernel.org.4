Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEF0D6F6FF0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 18:30:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbjEDQaI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 12:30:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbjEDQaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 12:30:06 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 361A919A7
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 09:30:04 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-6436e075166so598642b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 May 2023 09:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683217803; x=1685809803;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4oWF7MLF4+8vGd2/R4GxfBjS1i4cdYcBLULRSIqenjc=;
        b=R8AeTZsNf/ltnePPcGCgT6p1s0AacnGl8TmKQhWG5myvuCSb5lwTsljrITKi5yN6E6
         I7vB9d6G5w7S5rYteVEvkeU6MnkFAW94cQ2owUkoUY9dS00woJAzMfisIZiW17uBalrF
         6qhmwGcW/VUdHPVae5824FQZpUlR2KDxYJ9FTlWl/P9y7WkpVR5QKOrNR4DgdL9Cxah3
         UsMwXxFbbzSmk2fxQwhYWrXsJXi6HDvupIa3/9No5ClwSwK6ryTK9ZWIuGBrMZXTvz+A
         Ih9ex8mKEVhT7dlCxXK3KRLaZOoBk6w4x8m6y++/qvqYGqsd+TEL4V7LoX9Tkr/k190b
         TQHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683217803; x=1685809803;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4oWF7MLF4+8vGd2/R4GxfBjS1i4cdYcBLULRSIqenjc=;
        b=ONX8Yj6V1kzVxO/gWOvjZdzYgbO3xaQgOxpYzPHsw90pUqDFpJ+V0IxvgrkH0d2Lzo
         vcC2e7gzgfYslc0kTwJJdlYOaOczaU/BxwcgywYCzCYecx/26SnQ8OdXrHmQvPL8cpt6
         oG+H6jv37L7dup4xwzR0hgpjJW1UevNxFDOWY47ImizvSA8WSRj36PA6IGIzdwCo5sZh
         2m2V/CSnwIbsfPo4fM9fm8jPpRwTlwrNta1NLBZ365xjtyqk8TFIstMefOo2zMy+XdgQ
         9mZD2CDyFyRKnnQ3mxxqehn9T1144k6JZqWrVIdaJwz3nfFKL/iXB5fHzEuJAeeUw9Xw
         ncCw==
X-Gm-Message-State: AC+VfDwgvh7EE7zRsUMmFSRFwy1QQqwsWLtxdIjGsvX/aEWGC3ZMo9ev
        k0MBGrwx+Z9EVLNkgpGiHg0=
X-Google-Smtp-Source: ACHHUZ6K2eiHAxeMXa1bp0Vm4Vsv1XIe64urtOnQe1sXjDVA65uBFKQQXqNN0ei4jV5GoYoFHxXozg==
X-Received: by 2002:a05:6a21:9217:b0:d5:f7f5:85e4 with SMTP id tl23-20020a056a21921700b000d5f7f585e4mr2927692pzb.22.1683217803412;
        Thu, 04 May 2023 09:30:03 -0700 (PDT)
Received: from google.com ([2620:15c:211:201:f807:c8e7:2886:90f5])
        by smtp.gmail.com with ESMTPSA id z20-20020a63e554000000b00502fd70b0bdsm21969537pgj.52.2023.05.04.09.30.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 May 2023 09:30:02 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Thu, 4 May 2023 09:30:00 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Sergii Piatakov <sergii.piatakov@globallogic.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Steffen Zachaeus <steffen.zachaeus@joynext.com>,
        Gotthard Voellmeke <gotthard.voellmeke@renesas.com>,
        Yaroslav Parkhomenko <yaroslav.parkhomenko@globallogic.com>
Subject: Re: [PATCH mm/cma] mm/cma: retry allocation of dedicated area on
 EBUSY
Message-ID: <ZFPdiItgLb5dqoic@google.com>
References: <20230419083851.2555096-1-sergii.piatakov@globallogic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230419083851.2555096-1-sergii.piatakov@globallogic.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 19, 2023 at 11:38:51AM +0300, Sergii Piatakov wrote:
> Sometimes continuous page range can't be successfully allocated, because
> some pages in the range may not pass the isolation test. In this case,
> the CMA allocator gets an EBUSY error and retries allocation again (in
> the slightly shifted range). During this procedure, a user may see
> messages like:
>     alloc_contig_range: [70000, 80000) PFNs busy
> But in most cases, everything will be OK, because isolation test failure
> is a recoverable issue and the CMA allocator takes care of it (retrying
> allocation again and again).
> 
> This approach works well while a small piece of memory is allocated from
> a big CMA region. But there are cases when the caller needs to allocate
> the entire CMA region at once.

I agree that's valid use case.

> 
> For example, when a module requires a lot of CMA memory and a region
> with the requested size is binded to the module in the DTS file. When
> the module tries to allocate the entire its own region at once and the
> isolation test fails, the situation will be different than usual due to
> the following:
>  - it is not possible to allocate pages in another range from the CMA
>    region (because the module requires the whole range from the
>    beginning to the end);
>  - the module (from the client's point of view) doesn't expect its
>    request will be rejected (because it has its own dedicated CMA region
>    declared in the DTS).

That's out of expectation. Every CMA client should expect that CMA
allocation can be failed since there are a lot of reasons CMA can fail.

> 
> This issue should be handled on the CMA allocator layer as this is the
> lowest layer when the reason for failure can be distinguished. Because
> the allocator doesn't return an error code, but instead it just returns
> a pointer (to a page structure). And when the caller gets a NULL it
> can't realize what kind of problem happens inside (EBUSY, ENOMEM, or
> something else).
> 
> To avoid cases when CMA region has enough room to allocate the requested
> pages, but returns NULL due to failed isolation test it is proposed:
>  - add a separate branch to handle cases when the entire region is
>    requested;

Can't we also consider the request size is greater than half the size of
CMA as well if we want to go this approach?

Furthermore, what happens if the CMA is shared with others and remains
free memory up to only the requested size? In the case, it also returns
without further retrial(I am thinking how we can generalize if we want
to add retrial option to increase success ratio not only entire range
request but also other cases).

>  - as an initial solution, retry allocation several times (in the setup
>    where the issue was observed this solution helps).

At a quick look, I think the CMA client need to handle the failure.
If they request entire range, they should try harder(e.g., multiple attempts)
(Just FYI, folks had tried such a retry option multiple times even though
it was not entire range request since CMA allocation is fragile)

> 
> Signed-off-by: Sergii Piatakov <sergii.piatakov@globallogic.com>
> ---
>  mm/cma.c | 23 +++++++++++++++++++++--
>  1 file changed, 21 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/cma.c b/mm/cma.c
> index a7263aa02c92..37e2bc34391b 100644
> --- a/mm/cma.c
> +++ b/mm/cma.c
> @@ -431,6 +431,7 @@ struct page *cma_alloc(struct cma *cma, unsigned long count,
>  	unsigned long i;
>  	struct page *page = NULL;
>  	int ret = -ENOMEM;
> +	int retry = 0;
>  
>  	if (!cma || !cma->count || !cma->bitmap)
>  		goto out;
> @@ -487,8 +488,26 @@ struct page *cma_alloc(struct cma *cma, unsigned long count,
>  
>  		trace_cma_alloc_busy_retry(cma->name, pfn, pfn_to_page(pfn),
>  					   count, align);
> -		/* try again with a bit different memory target */
> -		start = bitmap_no + mask + 1;
> +
> +		/*
> +		 * The region has enough free space, but it can't be provided right now
> +		 * because the underlying layer is busy and can't perform allocation.
> +		 * Here we have different options depending on each particular case.
> +		 */
> +
> +		if (!start && !offset && bitmap_maxno == bitmap_count) {
> +			/*
> +			 * If the whole region is requested it means that:
> +			 *  - there is no room to retry the allocation in another range;
> +			 *  - most likely somebody tries to allocate a dedicated CMA region.
> +			 * So in this case we can just retry allocation several times with the
> +			 * same parameters.
> +			 */
> +			if (retry++ >= 5/*maxretry*/)
> +				break;
> +		} else
> +			/* In other cases try again with a bit different memory target */
> +			start = bitmap_no + mask + 1;
>  	}
>  
>  	trace_cma_alloc_finish(cma->name, pfn, page, count, align, ret);
> -- 
> 2.25.1
> 
> 
