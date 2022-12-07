Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA2136464CD
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 00:10:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbiLGXKE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 18:10:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbiLGXKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 18:10:03 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36EA77F882
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 15:10:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=xqHiRihBJ8iX0F/IkBiJScs1HhKDLwhRskwhnIf3MT8=; b=Z2+ynanTTY8D9mWJ9eqW9lYfd5
        Xwe0VmlCYl+gVh/rHRHIuDPnWB2VRRrvl9FJ05OxNsb2YI1exSW+EYKuNiji4yv1pr7+xiJeQ/XzK
        N79p6UQhttIVKpVjUJjuC2HCHkFpcwHzx7ky9ym0f8+cONc512UwqHcHtMkuFzgMJpfpoaW4lqYwF
        +6wr3GhOMPcFQRg4QMhzpXbWCiAj/LmzOC/Gh2l3i9eTVHDF2OLB8UbHvY7BuBVYDgUEMIJiCAXnr
        OzS4OTYhnzcVKOBDp/YE0jTGezZFOZ8GWUcdwvY9ovgQob+KHkwDkqpsUiXApDOPq4WEBQShgAwle
        1Aa32cVQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p33Y7-006IRG-Nb; Wed, 07 Dec 2022 23:09:59 +0000
Date:   Wed, 7 Dec 2022 23:09:59 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Cc:     linux-mm@kvack.org, damon@lists.linux.dev,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        sj@kernel.org
Subject: Re: [PATCH v2 1/3] madvise: Convert
 madvise_cold_or_pageout_pte_range() to use folios
Message-ID: <Y5EdR1l1Ho3FyrY3@casper.infradead.org>
References: <20221207230152.22938-1-vishal.moola@gmail.com>
 <20221207230152.22938-2-vishal.moola@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221207230152.22938-2-vishal.moola@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 07, 2022 at 03:01:50PM -0800, Vishal Moola (Oracle) wrote:
> @@ -424,28 +425,29 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
>  		page = vm_normal_page(vma, addr, ptent);
>  		if (!page || is_zone_device_page(page))
>  			continue;
> +		folio = page_folio(page);

Maybe we should add a vm_normal_folio() first?  That way we could get
rid of the 'struct page' in this function entirely.

> @@ -453,13 +455,13 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
>  		}
>  
>  		/*
> -		 * Do not interfere with other mappings of this page and
> -		 * non-LRU page.
> +		 * Do not interfere with other mappings of this folio and
> +		 * non-LRU folio.
>  		 */
> -		if (!PageLRU(page) || page_mapcount(page) != 1)
> +		if (!folio_test_lru(folio))

Why has the test for folio_mapcount() disappeared?

