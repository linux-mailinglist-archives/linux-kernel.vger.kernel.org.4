Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E004A659C89
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 22:45:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231381AbiL3Vpo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 16:45:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiL3Vpk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 16:45:40 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E4A91B1D4
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 13:45:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3EC2AB81C25
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 21:45:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A096AC433EF;
        Fri, 30 Dec 2022 21:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1672436736;
        bh=cVumx4Nm/N9nn3OVGA7It+mlETPOyLHvs1Havnr2L+A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QZEU0Xf08tqRC03cMUp8ZVX2PqiCbdTTp/+3KWjVK6nFZli66GShQzIkgdGTev7A1
         97qHlLG6zRpYCC30idfLCXk3IWs+OGJwp+KQxv1Frl7MFtMpI65euANI7IqJx4ev2m
         mI9fkU9sqboXIdOLqXkFAhCPyrE6v4yfTjbVKXRs=
Date:   Fri, 30 Dec 2022 13:45:35 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <willy@infradead.org>
Subject: Re: [PATCH v2] mm: huge_memory: convert split_huge_pages_all() to
 use a folio
Message-Id: <20221230134535.240f49e0ad8bf6d82f8cc393@linux-foundation.org>
In-Reply-To: <20221230093020.9664-1-wangkefeng.wang@huawei.com>
References: <20221230093020.9664-1-wangkefeng.wang@huawei.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Dec 2022 17:30:20 +0800 Kefeng Wang <wangkefeng.wang@huawei.com> wrote:

> Straightforwardly convert split_huge_pages_all() to use a folio.
> 
> ...
>
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -2932,6 +2932,7 @@ static void split_huge_pages_all(void)
>  {
>  	struct zone *zone;
>  	struct page *page;
> +	struct folio *folio;
>  	unsigned long pfn, max_zone_pfn;
>  	unsigned long total = 0, split = 0;
>  
> @@ -2944,24 +2945,32 @@ static void split_huge_pages_all(void)
>  			int nr_pages;
>  
>  			page = pfn_to_online_page(pfn);
> -			if (!page || !get_page_unless_zero(page))
> +			if (!page || PageTail(page))
> +				continue;
> +			folio = page_folio(page);
> +			if (!folio_try_get(folio))
>  				continue;
>  
> -			if (zone != page_zone(page))
> +			if (unlikely(page_folio(page) != folio))
> +				goto next;
> +
> +			if (zone != folio_zone(folio))
>  				goto next;

I'm still not understanding the above hunk.  Why is the
"page_folio(page) != folio" check added?  Should it be commented?


> -			if (!PageHead(page) || PageHuge(page) || !PageLRU(page))
> +			if (!folio_test_large(folio) ||
> +			    folio_test_hugetlb(folio) ||
> +			    !folio_test_lru(folio))
>  				goto next;
>  
>  			total++;
> -			lock_page(page);
> -			nr_pages = thp_nr_pages(page);
> -			if (!split_huge_page(page))
> +			folio_lock(folio);
> +			nr_pages = folio_nr_pages(folio);
> +			if (!split_folio(folio))
>  				split++;
>  			pfn += nr_pages - 1;
> -			unlock_page(page);
> +			folio_unlock(folio);
>  next:
> -			put_page(page);
> +			folio_put(folio);
>  			cond_resched();
>  		}
>  	}
> -- 
> 2.35.3
