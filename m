Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FA8D72627E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 16:14:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241050AbjFGOOD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 10:14:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239782AbjFGOOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 10:14:01 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0EA2137
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 07:13:59 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id 6a1803df08f44-62614a2ce61so63110686d6.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 07:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20221208.gappssmtp.com; s=20221208; t=1686147239; x=1688739239;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hujtERsbr1y1Z0h2D+lsDsJnysg0r755K8W7fL2vlzU=;
        b=Df5rDCZQESwjHEO+Uah+2lAx+ncZ/pSMBGHAB7jgWart+hv1h4s0QUfngJdWJ+Pn8K
         iILaIApA9zVcMWGF6JyrvlNQ2I9xG3l2PiM6HyOJoKNv9E+6ijAoUbwiyfgwwmrAEzfc
         ANxbLVbqEt97/N2QcUR7PC0XAVrCJATVwLyKSxRPZ9FFoLuWZ4kt26v2LV2e/RGCTiIs
         /+JWuknkCiKVvH6V3uog4o1Sb50eQuAzt1cz/t18eIiHEIpOtHZjTpmi6RED+BESRA6V
         EHkgOlfMdNL5qGfTD3YqzlMAPO9wvvotwaygK4DX8R2sJXVVuc/WZv4yi+Cr7DeIAshX
         lNsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686147239; x=1688739239;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hujtERsbr1y1Z0h2D+lsDsJnysg0r755K8W7fL2vlzU=;
        b=GFsnB85IXIrjz18uY4f8lXeD6fBcXis2XW6zXPjgS0vdUb+8ymfCACOgw6luAFrA1S
         HnDp7Gq3FgOScgqEdy1vFF4aRVRIZY0P+vysaMsIG+FF14+rSOsqQcx/XxlQkczBxrZ7
         P/RS4OJPU9EkCZbDmLFBIxaZsYM50HzTIGZpFfe8+5WU3JZfFqbtPSttcNYvaoBBIo9k
         +6bnYqv5nhRnItLEySwNjgj7jLPFCX9hG2KoFi7cD3BrqaVWq2E16eWwnxRkWNDhb5Zf
         Ho6qwQlvLsazT+Llvq+Ueu8P1iOhlpRSn/zRH9baKEjkLHrb6YztczOFJVjKdPa++0dY
         oAUg==
X-Gm-Message-State: AC+VfDzWk6rHsGOai6BaYTKcf8/9hJg7UQoCIJgM1u0vrIZjQGTzKhE7
        5LJKWbH+T15fJTNRe966ayrneA==
X-Google-Smtp-Source: ACHHUZ6C1PlaUoolC9qAy7RRteJreDjDP+HPCNptvM/K49WfcQemsYFute8jzy0/tbDwXcxDqT4IQA==
X-Received: by 2002:a05:6214:ac9:b0:622:7b7f:ed46 with SMTP id g9-20020a0562140ac900b006227b7fed46mr3261958qvi.7.1686147238725;
        Wed, 07 Jun 2023 07:13:58 -0700 (PDT)
Received: from localhost (2603-7000-0c01-2716-8f57-5681-ccd3-4a2e.res6.spectrum.com. [2603:7000:c01:2716:8f57:5681:ccd3:4a2e])
        by smtp.gmail.com with ESMTPSA id p8-20020a0cfd88000000b00623927281c2sm6077696qvr.40.2023.06.07.07.13.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 07:13:58 -0700 (PDT)
Date:   Wed, 7 Jun 2023 10:13:57 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        Nhat Pham <nphamcs@gmail.com>,
        Domenico Cerasuolo <cerasuolodomenico@gmail.com>,
        Yu Zhao <yuzhao@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: zswap: support exclusive loads
Message-ID: <20230607141357.GA338934@cmpxchg.org>
References: <20230530210251.493194-1-yosryahmed@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230530210251.493194-1-yosryahmed@google.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 30, 2023 at 09:02:51PM +0000, Yosry Ahmed wrote:
> @@ -46,6 +46,19 @@ config ZSWAP_DEFAULT_ON
>  	  The selection made here can be overridden by using the kernel
>  	  command line 'zswap.enabled=' option.
>  
> +config ZSWAP_EXCLUSIVE_LOADS
> +	bool "Invalidate zswap entries when pages are loaded"
> +	depends on ZSWAP
> +	help
> +	  If selected, when a page is loaded from zswap, the zswap entry is
> +	  invalidated at once, as opposed to leaving it in zswap until the
> +	  swap entry is freed.
> +
> +	  This avoids having two copies of the same page in memory
> +	  (compressed and uncompressed) after faulting in a page from zswap.
> +	  The cost is that if the page was never dirtied and needs to be
> +	  swapped out again, it will be re-compressed.
> +
>  choice
>  	prompt "Default compressor"
>  	depends on ZSWAP
> diff --git a/mm/frontswap.c b/mm/frontswap.c
> index 279e55b4ed87..e5d6825110f4 100644
> --- a/mm/frontswap.c
> +++ b/mm/frontswap.c
> @@ -216,8 +216,13 @@ int __frontswap_load(struct page *page)
>  
>  	/* Try loading from each implementation, until one succeeds. */
>  	ret = frontswap_ops->load(type, offset, page);
> -	if (ret == 0)
> +	if (ret == 0) {
>  		inc_frontswap_loads();
> +		if (frontswap_ops->exclusive_loads) {
> +			SetPageDirty(page);
> +			__frontswap_clear(sis, offset);
> +		}
> +	}
>  	return ret;

This would be a much more accessible feature (distro kernels,
experimenting, adapting to different workloads) if it were runtime
switchable.

That should be possible, right? As long as frontswap and zswap are
coordinated, this can be done on a per-entry basis:

	exclusive = READ_ONCE(frontswap_ops->exclusive_loads);
	ret = frontswap_ops->load(type, offset, page, exclusive);
	if (ret == 0) {
		if (exclusive) {
			SetPageDirty(page);
			__frontswap_clear(sis, offset);
		}
	}
