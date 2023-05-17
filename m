Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35E6A7060DE
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 09:11:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbjEQHLM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 03:11:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjEQHLL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 03:11:11 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C82B97
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 00:11:09 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 2514068C4E; Wed, 17 May 2023 09:11:06 +0200 (CEST)
Date:   Wed, 17 May 2023 09:11:05 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     Phillip Lougher <phillip@squashfs.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>, hch@lst.de,
        linux-kernel@vger.kernel.org, squashfs-devel@lists.sourceforge.net,
        kernel@axis.com
Subject: Re: [PATCH v3] squashfs: cache partial compressed blocks
Message-ID: <20230517071105.GA26233@lst.de>
References: <20230510-squashfs-cache-v3-1-9f56ffd43f03@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230510-squashfs-cache-v3-1-9f56ffd43f03@axis.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This looks generally good, but I have two more nitpicks (sorry for
beeing annoying):

> +	struct inode *cache_inode = msblk->cache_inode;
> +	struct address_space *cache_mapping = cache_inode ? cache_inode->i_mapping : NULL;
>
> +		struct page *page = NULL;
> +
> +		if (cache_mapping)
> +			page = find_get_page(cache_mapping,
> +					     read_start + i * PAGE_SIZE);

Given we only ever use the cache inode mapping, I'd suggest to store
that in the super_block and the just use mapping->host for the iput
on unmount.

> +		if (cache_mapping) {
> +			/*
> +			 * Use the __ version to avoid merging since we need
> +			 * each page to be separate when we check for and avoid
> +			 * cached pages.
> +			 */
> +			__bio_add_page(bio, page, len, offset);
> +		} else if (!bio_add_page(bio, page, len, offset)) {
>  			error = -EIO;
>  			goto out_free_bio;

And given that random alloc_page pages are basically never mergable
we should be able to just use __bio_add_page here unconditionally.
