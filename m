Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28DA16552D8
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 17:31:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235594AbiLWQbg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 11:31:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231238AbiLWQbK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 11:31:10 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D639615A
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 08:31:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Otc9hVPnb4uEiMojoyOvNAsTxJu3nDfQNUlQmeQ8aE0=; b=L4E35C1bu1mLdsdwy2A24aW9i0
        BlSAurOdUGmUVBZRuV5dLvXjsXHDhmw1dZhnP+Ux+dGYfGTUAdeshJ6BfmsbcJLh+YAq6rro4MOGt
        bN4ocBY1x3Ebl/ByzMhXiUwXjbQhTa9ghEEi7oPe5zrewdlqbVwQZLLvKt8mDCq7My+FLW886Kxoo
        XSagG2jM3FJFxlZ7XeaVmTHtj3m1LtWUpq1L6cJAElnMl5XRCYPuQp/g9foPFdlMi4lR6H6dSqDY3
        6vVDJB+1tUM7sUvaDs9nLcboX1NnKEqRskCuOxMSRK6nso0WbYY7g0mPGYD3f908lBaOe7oRG6tGv
        LvYJpN0w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p8kwt-009ztr-B2; Fri, 23 Dec 2022 16:31:07 +0000
Date:   Fri, 23 Dec 2022 08:31:07 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Keith Busch <kbusch@meta.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        Tony Battersby <tonyb@cybernetics.com>,
        Kernel Team <kernel-team@meta.com>,
        Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv2 06/11] dmapool: move debug code to own functions
Message-ID: <Y6XXy0h+bazIKwjC@infradead.org>
References: <20221216201625.2362737-1-kbusch@meta.com>
 <20221216201625.2362737-7-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221216201625.2362737-7-kbusch@meta.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +static inline void pool_check_block(struct dma_pool *pool, void *retval,
> +				    unsigned int offset, gfp_t mem_flags)
> +{
> +#ifdef	DMAPOOL_DEBUG

We normally keep the ifdef outside the function and provide stubs.
Extra points for keeping all the debug helpers in a single ifdef
block.
