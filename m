Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB85D6552E2
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 17:39:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231404AbiLWQjB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 11:39:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230155AbiLWQi7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 11:38:59 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F1B92DDA
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 08:38:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=EYSG91C6cZ+G8ROzIZso2hzCSRMc6hmS4xPa9jppU4k=; b=PXlBDbqcgNeVERJWHENKzVYTpT
        8wvXWzu+aOiB+QmLpVTPDevj/3xxqcqU8OD+1h2YcaKpN6QpPxJ0gxGH3n/YhBqNR4yMw4IzCdET5
        pM5NstCxnV53JAcm1JpTkJxBoxnMcjl0hT1RGCRX69JxCOb3oCizk6jEfZBn9ZQgIL9LabNbU66Dc
        U+3r/gnOwEdOEtgNllzz8yOkNzEGkwaRtr5/qTpT6TL88k/3py2pwf/6pv61rkHcnVZoPxN/iLQPW
        iPe2UA3nYv8ysDeznb2UCqmdf+AKQ+bw6fkfE2eeZBOdGnRR+WAdil2BI2jy1AsD+8zTAIcjhC0PZ
        o1mUMoMw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p8l4R-00A2qS-Ob; Fri, 23 Dec 2022 16:38:55 +0000
Date:   Fri, 23 Dec 2022 08:38:55 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Keith Busch <kbusch@meta.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        Tony Battersby <tonyb@cybernetics.com>,
        Kernel Team <kernel-team@meta.com>,
        Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv2 09/11] dmapool: simplify freeing
Message-ID: <Y6XZnz0EDXYlfqhX@infradead.org>
References: <20221216201625.2362737-1-kbusch@meta.com>
 <20221216201625.2362737-10-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221216201625.2362737-10-kbusch@meta.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> @@ -280,14 +268,14 @@ void dma_pool_destroy(struct dma_pool *pool)
>  	mutex_unlock(&pools_reg_lock);
>  
>  	list_for_each_entry_safe(page, tmp, &pool->page_list, page_list) {
> +		if (!is_page_busy(page))
> +			dma_free_coherent(pool->dev, pool->allocation,
> +					  page->vaddr, page->dma);
> +		else
>  			dev_err(pool->dev, "%s %s, %p busy\n", __func__,
>  				pool->name, page->vaddr);
> +		list_del(&page->page_list);
> +		kfree(page);

Hmm.  The is_page_busy case is really a should not happen case.
What is the benefit of skipping the dma_free_coherent and leaking
memory here, vs letting KASAN and friends see the free and possibly
help with debugging?  In other words, why is this not:

		WARN_ON_ONCE(is_page_busy(page));
		dma_free_coherent(pool->dev, pool->allocation, page->vaddr,
				  page->dma);
		...

>  	page->in_use--;
>  	*(int *)vaddr = page->offset;
>  	page->offset = offset;
> -	/*
> -	 * Resist a temptation to do
> -	 *    if (!is_page_busy(page)) pool_free_page(pool, page);
> -	 * Better have a few empty pages hang around.
> -	 */

This doesn't look related to the rest, or am I missing something?
