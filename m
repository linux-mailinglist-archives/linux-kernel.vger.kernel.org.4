Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F4089723B4A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 10:22:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236255AbjFFIWA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 04:22:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236058AbjFFIV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 04:21:57 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3309FE52
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 01:21:52 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-514ab6cb529so14181645a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 01:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686039710; x=1688631710;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AHKF7/YQ89A+3he/E/d8YEFI+Q74KxWrX8Gv/PaLeCY=;
        b=a3ctcpwgB80yYJp74jGa1SOABGyaDeT9JSwT21OIw2Ug6oRbD+m28srMvkkO7EroMK
         IBD9XwcQG6md7xiGhjomhbHMx2EjszalLTlLYy6bRuk31WXE9DR+PxQsXCq8uy+nth9G
         d2vgLP2y5Jnma04+WkV32K/hyH2CTWID3LeSNyK6SpXElY745dqQM61cukqso7WumDr+
         gu5suHUFh6BjXrdtAy1ZgVrpeB+8YNNdK+3NfTCpsnYZNKPJY9pT3H7K9TEhApp5kLY3
         BeS8iCCYgQZNeOQmk+nH6TigMC42D5MjAnX5xm3eUulk89TNf59FBEKm2esXA04Xk0d/
         qkWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686039710; x=1688631710;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AHKF7/YQ89A+3he/E/d8YEFI+Q74KxWrX8Gv/PaLeCY=;
        b=D8bmJicQVYvAz3ZOhp3lCk56ST6aiPX60c1UwN4N64bsAxw45Ygx11ztex2YETixnq
         P52Jz8B//WFRe1LyRv9xLMisMvvXqWDi/sCrRZKUKBciDjB1oA0B9ElQxuApqYWYA8vC
         N19V2KIa4cnWovJeD9B65hr95f7GVrJHUW1F6r9v/o8wb33vlonbkMX+ZyTNubp3n3sM
         0NWbkDmOMyEtL1AUXLyd0OaFUTC3onTYrudRNM0i7n9dJ6piSm6t+f+8zIdcFoPM2ZIE
         2CrPHJM/kx3+Izu2UOh4D8isybHoV0zPrhP+ly/WdY3a3GnDGy5ltm5BoNdXimQdD3qQ
         TTiw==
X-Gm-Message-State: AC+VfDxtp9/Br0NIciEkJlpg5P7t42eWPfnj1Y56nZ2wt6YUmu4NRrH+
        WH82C2aftMDMrMeq+FGtsGdXAjVPlQM=
X-Google-Smtp-Source: ACHHUZ6jyn6UnQPXWnMZS9VOV6EQ+45JZDc6mv5fP3VKnxOHD7aRDdgKyjRnFFNvj1WD3ys6p1NSgQ==
X-Received: by 2002:a05:6402:b35:b0:513:fa61:397a with SMTP id bo21-20020a0564020b3500b00513fa61397amr1590139edb.12.1686039710550;
        Tue, 06 Jun 2023 01:21:50 -0700 (PDT)
Received: from pc638.lan ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id d13-20020a05640208cd00b0051643d71ce9sm4255777edz.26.2023.06.06.01.21.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 01:21:50 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date:   Tue, 6 Jun 2023 10:21:48 +0200
To:     Lorenzo Stoakes <lstoakes@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Baoquan He <bhe@redhat.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH] mm/vmalloc: do not output a spurious warning when huge
 vmalloc() fails
Message-ID: <ZH7snMZtdmpNi3sw@pc638.lan>
References: <20230605201107.83298-1-lstoakes@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230605201107.83298-1-lstoakes@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 05, 2023 at 09:11:07PM +0100, Lorenzo Stoakes wrote:
> In __vmalloc_area_node() we always warn_alloc() when an allocation
> performed by vm_area_alloc_pages() fails unless it was due to a pending
> fatal signal.
> 
> However, huge page allocations instigated either by vmalloc_huge() or
> __vmalloc_node_range() (or a caller that invokes this like kvmalloc() or
> kvmalloc_node()) always falls back to order-0 allocations if the huge page
> allocation fails.
> 
> This renders the warning useless and noisy, especially as all callers
> appear to be aware that this may fallback. This has already resulted in at
> least one bug report from a user who was confused by this (see link).
> 
> Therefore, simply update the code to only output this warning for order-0
> pages when no fatal signal is pending.
> 
> Link: https://bugzilla.suse.com/show_bug.cgi?id=1211410
> Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
> ---
>  mm/vmalloc.c | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index ab606a80f475..e563f40ad379 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -3149,11 +3149,20 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
>  	 * allocation request, free them via vfree() if any.
>  	 */
>  	if (area->nr_pages != nr_small_pages) {
> -		/* vm_area_alloc_pages() can also fail due to a fatal signal */
> -		if (!fatal_signal_pending(current))
> +		/*
> +		 * vm_area_alloc_pages() can fail due to insufficient memory but
> +		 * also:-
> +		 *
> +		 * - a pending fatal signal
> +		 * - insufficient huge page-order pages
> +		 *
> +		 * Since we always retry allocations at order-0 in the huge page
> +		 * case a warning for either is spurious.
> +		 */
> +		if (!fatal_signal_pending(current) && page_order == 0)
>  			warn_alloc(gfp_mask, NULL,
> -				"vmalloc error: size %lu, page order %u, failed to allocate pages",
> -				area->nr_pages * PAGE_SIZE, page_order);
> +				"vmalloc error: size %lu, failed to allocate pages",
> +				area->nr_pages * PAGE_SIZE);
>  		goto fail;
>  	}
>  
> -- 
> 2.40.1
> 
Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
