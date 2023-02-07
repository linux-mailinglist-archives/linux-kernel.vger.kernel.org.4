Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F422868CDAD
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 04:53:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbjBGDxh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 22:53:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbjBGDxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 22:53:32 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D77834328
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 19:53:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=JTbMeYDi+XVQmcHxlT3b2sWWNwIqG7r4VwhSYckXE2s=; b=SVNRIRHm8vrdmYkP5pWJaDrdt4
        ziWomcp6rJ9GJZDTZ8jdRXqESDS9LUk2ySjg35crvaBp6CcXMu26aBGcqTZWc98StujFMBGclxi/D
        clxVwUByNKzRbfq214Ss9RaKG4mOcjkQdx8C6gxm+6aM+iW1cvOxbqErE0F4u1To0Z6XkhCJ/zhH0
        wDc4jap09Q3ogTFNs6qMHX3W9yKAzCjLeCwCP+8W5SDv8JfV/3/eX5NRGPvCdryNgp1DWzJpCY82e
        0dGgoI4XJ9/zNYnurNt/vMRahFo8NSJibKwQ3s62oX+p8nFM2ieXFvAUWpr1IV4KC6BTko/YhO+x4
        l7FkPa5w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pPF2L-00HQc1-GG; Tue, 07 Feb 2023 03:52:53 +0000
Date:   Tue, 7 Feb 2023 03:52:53 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     hughd@google.com, akpm@linux-foundation.org, linux-mm@kvack.org,
        p.raghav@samsung.com, dave@stgolabs.net, a.manzanares@samsung.com,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC 1/2] shmem: set shmem_writepage() variables early
Message-ID: <Y+HLFWaHq11MQ91U@casper.infradead.org>
References: <20230207025259.2522793-1-mcgrof@kernel.org>
 <20230207025259.2522793-2-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230207025259.2522793-2-mcgrof@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 06, 2023 at 06:52:58PM -0800, Luis Chamberlain wrote:
> shmem_writepage() sets up variables typically used *after* a possible
> huge page split. However even if that does happen the address space
> mapping should not change. So it should be safe to set that from
> the beginning.

Yes, we can get mapping from the folio early.  It doesn't change
on split.

> The folio should always be locked from the start as well. It however
> was not clear if the folio address can / should change, as well as
> the first inode.
> 
> This commit makes no functional changes other a double check on the
> folio locking which might be superflous. This change should help make
> the subsequent patch easier to review.

You don't need to check that the folio's locked, and you don't
need to reassign inode after the split.

> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
>  mm/shmem.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 28f3c699c8ce..a2c6aa11aab8 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -1332,11 +1332,13 @@ static int shmem_writepage(struct page *page, struct writeback_control *wbc)
>  {
>  	struct folio *folio = page_folio(page);
>  	struct shmem_inode_info *info;
> -	struct address_space *mapping;
> -	struct inode *inode;
> +	struct address_space *mapping = folio->mapping;
> +	struct inode *inode = mapping->host;
>  	swp_entry_t swap;
>  	pgoff_t index;
>  
> +	BUG_ON(!folio_test_locked(folio));
> +
>  	/*
>  	 * If /sys/kernel/mm/transparent_hugepage/shmem_enabled is "always" or
>  	 * "force", drivers/gpu/drm/i915/gem/i915_gem_shmem.c gets huge pages,
> @@ -1351,8 +1353,8 @@ static int shmem_writepage(struct page *page, struct writeback_control *wbc)
>  		folio_clear_dirty(folio);
>  	}
>  
> +	/* Can the folio or first inode change on after a split? */
>  	BUG_ON(!folio_test_locked(folio));
> -	mapping = folio->mapping;
>  	index = folio->index;
>  	inode = mapping->host;
>  	info = SHMEM_I(inode);
> -- 
> 2.39.0
> 
