Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18BC3645E8E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 17:18:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbiLGQSh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 11:18:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbiLGQSg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 11:18:36 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D91BE9587
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 08:18:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=CTE6dIt+WJ+vgyPZslBvBPKrvguQdijjejJhRQWzhfU=; b=EUFd0ueIKCe4OzBKsVkD5N/fXz
        zwYytj69x7Hr59S7QSGQsQSA+T1HqUFvBOKCsad7up1f0y/tAYobcGbBquBO//IxTqDd8/83rbM5f
        oMJQil/xQa+zCfr+zoJGoo+TEtmcN0JfTEyDDo7ioFjPFKU6jvOQNHZcLzimZSyxjNGNHpvOrpmcB
        DS1gDSXEQdPNoyynfUmEsD9UJJQWkBkGEqJMa5EUwvkqr8sY12DkAtcVBU3Gsn8x3dvkpG00kSqYX
        euP/95Xn8boTEWKaeoJpazyT3dSNNcrqPwl195NolKfPR9FFTu8yoFzcGEwMvq8vq9cbrmaps1VBy
        0j8HXGYA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p2x7v-005z8C-WC; Wed, 07 Dec 2022 16:18:32 +0000
Date:   Wed, 7 Dec 2022 16:18:31 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Cc:     linux-mm@kvack.org, damon@lists.linux.dev,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        sj@kernel.org
Subject: Re: [PATCH 3/3] swap: Convert deactivate_page() to deactivate_folio()
Message-ID: <Y5C814+q1QAtKvRW@casper.infradead.org>
References: <20221207002158.418789-1-vishal.moola@gmail.com>
 <20221207002158.418789-4-vishal.moola@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221207002158.418789-4-vishal.moola@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 06, 2022 at 04:21:58PM -0800, Vishal Moola (Oracle) wrote:
>  /*
> - * deactivate_page - deactivate a page
> - * @page: page to deactivate
> + * deactivate_folio - deactivate a folio
> + * @folio: folio to deactivate
>   *
> - * deactivate_page() moves @page to the inactive list if @page was on the active
> - * list and was not an unevictable page.  This is done to accelerate the reclaim
> - * of @page.
> + * deactivate_folio() moves @folio to the inactive list if @folio was on the
> + * active list and was not an unevictable page. This is done to accelerate

... and was not unevictable.  This ...

> + * the reclaim of @folio.
>   */
> -void deactivate_page(struct page *page)
> +void deactivate_folio(struct folio *folio)
>  {
> -	struct folio *folio = page_folio(page);
> -
>  	if (folio_test_lru(folio) && !folio_test_unevictable(folio) &&
>  	    (folio_test_active(folio) || lru_gen_enabled())) {
>  		struct folio_batch *fbatch;
> -- 
> 2.38.1
> 
> 
