Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC2ED656E99
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 21:21:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231382AbiL0UVk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 15:21:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbiL0UVi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 15:21:38 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B9BDC7F
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 12:21:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D0DC9B8109A
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 20:21:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AC0CC433D2;
        Tue, 27 Dec 2022 20:21:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672172495;
        bh=+6SHzFYpleoqvJNUY3JPRsP/mA1tz9L+T/ymsSLaI2o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bPZ6lNF8ptkFi2U99dBpZSEU7g4kFpmvGsmLyQjob5pGFhV4HWsnFWRzb9f57SP3Q
         EbcyPhR2M0B+ot83g3NsUJ/SdicbClIVr5jF4+wS2Cjq2cUwSCk7MjYavFguN3avMX
         Rx0/irB+tis7chl140KdkWANCB4hPcyXz+oOmA2ZZP5IWetY45a46ufosYlRBb9Bap
         B1ZnxJDy9lHfTMbT88gJbHANzz3ovqKSeBbbrt2Tp9F+2s4UP/VkJgODJDhKg5vmk4
         WuMSDmmICljb32mvizzZcyLHfb2IpABfVK+y9REFN+m5d7iDxrEXaH8/9SubdO5kQj
         8cBmLDeU2SEFw==
Date:   Tue, 27 Dec 2022 13:21:32 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Keith Busch <kbusch@meta.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        Tony Battersby <tonyb@cybernetics.com>,
        Kernel Team <kernel-team@meta.com>
Subject: Re: [PATCHv2 09/11] dmapool: simplify freeing
Message-ID: <Y6tTzGs3lFWlMcPt@kbusch-mbp>
References: <20221216201625.2362737-1-kbusch@meta.com>
 <20221216201625.2362737-10-kbusch@meta.com>
 <Y6XZnz0EDXYlfqhX@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y6XZnz0EDXYlfqhX@infradead.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 23, 2022 at 08:38:55AM -0800, Christoph Hellwig wrote:
> > @@ -280,14 +268,14 @@ void dma_pool_destroy(struct dma_pool *pool)
> >  	mutex_unlock(&pools_reg_lock);
> >  
> >  	list_for_each_entry_safe(page, tmp, &pool->page_list, page_list) {
> > +		if (!is_page_busy(page))
> > +			dma_free_coherent(pool->dev, pool->allocation,
> > +					  page->vaddr, page->dma);
> > +		else
> >  			dev_err(pool->dev, "%s %s, %p busy\n", __func__,
> >  				pool->name, page->vaddr);
> > +		list_del(&page->page_list);
> > +		kfree(page);
> 
> Hmm.  The is_page_busy case is really a should not happen case.
> What is the benefit of skipping the dma_free_coherent and leaking
> memory here, vs letting KASAN and friends see the free and possibly
> help with debugging?  In other words, why is this not:
> 
> 		WARN_ON_ONCE(is_page_busy(page));
> 		dma_free_coherent(pool->dev, pool->allocation, page->vaddr,
> 				  page->dma);
> 		...

The memory is presumed to still be owned by the device in this case, so
the kernel shouldn't free it. I don't think KASAN will be very helpful
if the device corrupts memory.
 
> >  	page->in_use--;
> >  	*(int *)vaddr = page->offset;
> >  	page->offset = offset;
> > -	/*
> > -	 * Resist a temptation to do
> > -	 *    if (!is_page_busy(page)) pool_free_page(pool, page);
> > -	 * Better have a few empty pages hang around.
> > -	 */
> 
> This doesn't look related to the rest, or am I missing something?

Oops, this was supposed to go with a later patch in this series that
removed "is_page_busy()".
