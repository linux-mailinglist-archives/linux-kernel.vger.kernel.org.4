Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 823B4661731
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 18:08:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233127AbjAHRIc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 12:08:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233071AbjAHRI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 12:08:27 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 267D29FEB
        for <linux-kernel@vger.kernel.org>; Sun,  8 Jan 2023 09:08:27 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 88CE868D06; Sun,  8 Jan 2023 18:08:24 +0100 (CET)
Date:   Sun, 8 Jan 2023 18:08:24 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Keith Busch <kbusch@meta.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@lst.de>,
        Tony Battersby <tonyb@cybernetics.com>,
        Kernel Team <kernel-team@meta.com>,
        Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv3 09/12] dmapool: simplify freeing
Message-ID: <20230108170824.GD19739@lst.de>
References: <20230103191551.3254778-1-kbusch@meta.com> <20230103191551.3254778-10-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230103191551.3254778-10-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> - * DMA Pool allocator
> +* DMA Pool allocator

This got corrupted somehow.

> +		if (!is_page_busy(page))
> +			dma_free_coherent(pool->dev, pool->allocation,
> +					  page->vaddr, page->dma);
> +		else
>  			dev_err(pool->dev, "%s %s, %p busy\n", __func__,
>  				pool->name, page->vaddr);
> +		list_del(&page->page_list);
> +		kfree(page);

I'm still not sure what the point of leaking the page in case it is
busy vs letting KASAN and friends actually catch it, but the pure
rearrangement is an improvement over the previous state, so:

Reviewed-by: Christoph Hellwig <hch@lst.de>
