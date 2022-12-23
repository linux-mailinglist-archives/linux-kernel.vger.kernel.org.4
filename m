Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6282F6552FB
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 17:59:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232142AbiLWQ6V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 11:58:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230453AbiLWQ6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 11:58:19 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 024491D3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 08:58:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=n3ckuVjd+kf/Enh4S8aX3LjBb7aTur9Q4f8tyMM3MaY=; b=eTVnoJr3m7/74zcHBx2nqnM6pR
        vRuXjuU7ECwpnGlWDEcqYQC3lRL7UgO2IuQGPHRODtOXwEkCLQU6Dd7xDImeUksWAW1vHTZFC1CHH
        YPAcmcMhSHjY5MIWES2IgM1rL1G3JJqwrSDD0qvvfmzI/otKMqTykzeGwtyeCNy/YBPMUGUNmbT1m
        PdGgR1/o3hlmjre8IJpSphepYlcWcz3/A0XalD7vSdYYRrptThG9OUA90iitf5ymps2GQF2Ko5L7o
        6HXKo8y2H7NXnpO4AMZAgB336Mu1wTj6i4942GjTSMr5wMtdm6HxnGZT6SzHeVDveftOxtUCZBncE
        b2Hi/Fag==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p8lN9-00AAbn-KE; Fri, 23 Dec 2022 16:58:15 +0000
Date:   Fri, 23 Dec 2022 08:58:15 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Keith Busch <kbusch@meta.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        Tony Battersby <tonyb@cybernetics.com>,
        Kernel Team <kernel-team@meta.com>,
        Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv2 11/11] dmapool: link blocks across pages
Message-ID: <Y6XeJ2mzd8p73J93@infradead.org>
References: <20221216201625.2362737-1-kbusch@meta.com>
 <20221216201625.2362737-12-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221216201625.2362737-12-kbusch@meta.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 16, 2022 at 12:16:25PM -0800, Keith Busch wrote:
>  	unsigned int size;
>  	unsigned int allocation;
>  	unsigned int boundary;
> +	size_t nr_blocks;
> +	size_t nr_active;
> +	size_t nr_pages;

Should these be unsigned int like the counters above?

> +static inline struct dma_block *pool_block_pop(struct dma_pool *pool)
> +{
> +	struct dma_block *block = pool->next_block;
> +
> +	if (block) {
> +		pool->next_block = block->next_block;
> +		pool->nr_active++;
> +	}
> +	return block;
> +}
> +
> +static inline void pool_block_push(struct dma_pool *pool, struct dma_block *block,
> +				 dma_addr_t dma)
> +{
> +	block->dma = dma;
> +	block->next_block = pool->next_block;
> +	pool->next_block = block;
> +}

Any point in marking these inline vs just letting the ocmpile do
it's job?

> @@ -162,6 +176,10 @@ struct dma_pool *dma_pool_create(const char *name, struct device *dev,
>  	retval->size = size;
>  	retval->boundary = boundary;
>  	retval->allocation = allocation;
> +	retval->nr_blocks = 0;
> +	retval->nr_active = 0;
> +	retval->nr_pages = 0;
> +	retval->next_block = NULL;

Maybe just switch to kzmalloc so that you don't have to bother
initializing invdividual fields.  It's not like dma_pool_create is
called from anything near a fast path.

>  static void pool_initialise_page(struct dma_pool *pool, struct dma_page *page)
>  {
> +	unsigned int next_boundary = pool->boundary, offset = 0;
> +	struct dma_block *block;
> +
> +	while (offset + pool->size <= pool->allocation) {
> +		if (offset + pool->size > next_boundary) {
> +			offset = next_boundary;
>  			next_boundary += pool->boundary;
> +			continue;
>  		}
> +
> +		block = page->vaddr + offset;
> +		pool_block_push(pool, block, page->dma + offset);

So I guess with this pool_initialise_page needs to be called under
the lock anyway, but just doing it silently in the previous patch
seems a bit odd.

> +static inline void pool_check_block(struct dma_pool *pool, struct dma_block *block,
> +				    gfp_t mem_flags)

I didn't spot this earlier, but inline on a relatively expensive debug
helper is a bit silly.

Otherwise this looks like a nice improvement by using a better and
simpler data structure.
