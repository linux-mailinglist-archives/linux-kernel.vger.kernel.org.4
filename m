Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDCAC68F2A5
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 17:01:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbjBHQBV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 11:01:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjBHQBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 11:01:18 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C21A6A58
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 08:01:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1DaopZDdlwao209mQiW1EFcILq+SNU2i7Dq7AU/IXvY=; b=ABZad9E2tqcSahpgS49GerIChy
        TjdG6srT8y6qMko0eIT6HOKkSbHg7y/Hp3zKJukjgwfft387vsFtUmmOVrPcYuQZicTzOvgtxI177
        Sop4U663UuT+HF0PnkUOP+hTmBOqkwy0EfnDkPGZZTW7UkVf7LKssjqgf6Mb6UFZRaTzqnnBlFTBp
        To2hDXS6o4cbMjmnYMGC/6goKqTSxiWya6ak+TltW+c94IszKu5Pl89jlVM4FUpT9zs5EGtUp1GGQ
        gVaLKdpV8R57Sm9MrTvxoEXNHdaumZUP09fSyefshk+IRBkHbcErRISnzb61wS0MlndIq9Su/XTLr
        y1CNSgJw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pPmsX-00GB4B-MP; Wed, 08 Feb 2023 16:01:06 +0000
Date:   Wed, 8 Feb 2023 08:01:01 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     hughd@google.com, akpm@linux-foundation.org, linux-mm@kvack.org,
        p.raghav@samsung.com, dave@stgolabs.net, a.manzanares@samsung.com,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC 2/2] shmem: add support to ignore swap
Message-ID: <Y+PHPfiVS6EiTVl1@bombadil.infradead.org>
References: <20230207025259.2522793-1-mcgrof@kernel.org>
 <20230207025259.2522793-3-mcgrof@kernel.org>
 <Y+HNL9RoP48tquGd@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+HNL9RoP48tquGd@casper.infradead.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 07, 2023 at 04:01:51AM +0000, Matthew Wilcox wrote:
> On Mon, Feb 06, 2023 at 06:52:59PM -0800, Luis Chamberlain wrote:
> > @@ -1334,11 +1336,15 @@ static int shmem_writepage(struct page *page, struct writeback_control *wbc)
> >  	struct shmem_inode_info *info;
> >  	struct address_space *mapping = folio->mapping;
> >  	struct inode *inode = mapping->host;
> > +	struct shmem_sb_info *sbinfo = SHMEM_SB(inode->i_sb);
> >  	swp_entry_t swap;
> >  	pgoff_t index;
> >  
> >  	BUG_ON(!folio_test_locked(folio));
> >  
> > +	if (wbc->for_reclaim && unlikely(sbinfo->noswap))
> > +		return AOP_WRITEPAGE_ACTIVATE;
> 
> Not sure this is the best way to handle this.  We'll still incur the
> oevrhead of tracking shmem pages on the LRU, only to fail to write them
> out when the VM thinks we should get rid of them.  We'd be better off
> not putting them on the LRU in the first place.

Ah, makes sense, so in effect then if we do that then on reclaim
we should be able to even WARN_ON(sbinfo->noswap) assuming we did
everthing right.

Hrm, we have invalidate_mapping_pages(mapping, 0, -1) but that seems a bit
too late how about d_mark_dontcache() on shmem_get_inode() instead?

  Luis
