Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38E0F650B3D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 13:13:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231795AbiLSMNm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 07:13:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231728AbiLSMNH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 07:13:07 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1855FD2A
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 04:09:45 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id a19so8912567ljk.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 04:09:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cFpsTThPmorTzxNRzB4rfnvG2I3ODpNOkx2axpQ+YZM=;
        b=e2KfN0rxqpiI7hyUA6YPq+O+AZf2L2DGqPAuoga+hbJGFNHHBxNslh+gg/8nV0V07T
         FFkkVQG/FZrtELqoj6hIicjz3From4MRb9kHqv+sFV6AkOwNEdD32IwBOdhDCdC71QWc
         f8T9o3Wwj5ZP4zjUQGAe4RiJ8KUBJR7k4Hl6cZP1E7gDwiZ/hVbsZnNwh95sB9oLcM2c
         //gw8oY1UbvOZyFv3PHDUSWeNN9qV5DS6rULdgK3j1NIDdKCPdZEbiR3Vl/zm+5ByIkF
         2WXAFgNgJ7w1k6kGGFJVc2xvHfauR7AKzt3LgDf/z+WFWPtq2eN8D5wuEG+X2kHYcA3o
         Wk+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cFpsTThPmorTzxNRzB4rfnvG2I3ODpNOkx2axpQ+YZM=;
        b=ZsK/mYE8vfRH5PeC6bUxaKwiAO+WrDBZnzEhST7buqdmjPG9JF5rwHrXUaxClGX9VS
         yu//Wc6muw9NGpXnnN7BZvz8rG/xKql5IKCsNSkZwMTKXKm4cqW+x99P3YAWts+ZIapB
         hxiLGuPKM+BKR9QWw9Z8qMZ+7ndcis87rzXFrhiDgwYUKqLIU//a+XeU8t0FZMVFhbDn
         1VESM2pLt4rAyHe9QBhExsU2ulqNYj+X9mQxdCbXJwKudSzeSDhpYCDGT4qxtrIPtU6p
         R5L/eRGvbGChn3fEDyjQBrH1ew7tqcugcfzFK3pIBAK/SyGJrX95NNlzREAbcoAmD0x1
         jNuw==
X-Gm-Message-State: ANoB5pkH6t584/kUbhVkTgsGefbHM6F8FpnMqAb/6iOkYXSEYs8XESg3
        POz0WY8sIkhtWZH0O68fGTo=
X-Google-Smtp-Source: AA0mqf5TpqUc9wLalJvJYIOBc8Z2O6Cujk7fCi/aquD/84yzL6J77NMJKsfpL5OWuhTUVtCXwTsZLQ==
X-Received: by 2002:a05:651c:1591:b0:277:413:7da3 with SMTP id h17-20020a05651c159100b0027704137da3mr16498313ljq.49.1671451784246;
        Mon, 19 Dec 2022 04:09:44 -0800 (PST)
Received: from pc636 (host-90-233-218-120.mobileonline.telia.com. [90.233.218.120])
        by smtp.gmail.com with ESMTPSA id z3-20020a056512370300b004949f7cbb6esm1080718lfr.79.2022.12.19.04.09.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 04:09:43 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Mon, 19 Dec 2022 13:09:41 +0100
To:     Lorenzo Stoakes <lstoakes@gmail.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH] mm: vmalloc: correct use of __GFP_NOWARN mask in
 __vmalloc_area_node()
Message-ID: <Y6BUhXwswQTsfp0E@pc636>
References: <20221216234659.493794-1-lstoakes@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221216234659.493794-1-lstoakes@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 16, 2022 at 11:46:59PM +0000, Lorenzo Stoakes wrote:
> This function invokes warn_alloc() with __GFP_NOWARN set which is a
> no-op. Set this flag _after_ this call so it is actually invoked, and
> additionally remove a duplicate application of __GFP_NOWARN afterwards.
> 
> Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
> ---
>  mm/vmalloc.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index ca71de7c9d77..9e30f0b39203 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -3031,7 +3031,7 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
>  	int ret;
> 
>  	array_size = (unsigned long)nr_small_pages * sizeof(struct page *);
> -	gfp_mask |= __GFP_NOWARN;
> +
>  	if (!(gfp_mask & (GFP_DMA | GFP_DMA32)))
>  		gfp_mask |= __GFP_HIGHMEM;
> 
> @@ -3051,10 +3051,12 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
>  		return NULL;
>  	}
> 
> +	gfp_mask |= __GFP_NOWARN;
> +
>
There are three more warn_alloc()s below. Those are explicitly disabled.
Could you please rework the patch and make it working also?

--
Uladzislau Rezki
