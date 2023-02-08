Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67BE868F600
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 18:47:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232004AbjBHRrM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 12:47:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230185AbjBHRqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 12:46:55 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C3825356C
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 09:45:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=jtZ9usIqG10mDaEiQbcVXECDWkMgFMufDpS54uMpync=; b=ogX0Ke7Lx2PsPOC0o8QOf7t6j1
        u6S+DZmGyBpy+o2bYp1R2GA0dLpUU/+FJQUBk7Q5eMxyrOdn8D6Eh9edkiQ7d0sQuTyA5Ks4NyIDx
        bnFNHfIQT09ig+fEaUyFJfrOaRn468ebvpyl5KLXwMm72CsNV/vSvIohWaJtpoI0ggmnvSL/Ez5N+
        wz9dxcfv1I7/r3rVXIy3cWtBa6Q1JDSR+TKQ6tWWlNlGt0VYZw6ymZEdgNo4E1nfFv+c2Z9a3iUp7
        e1nl/3dhnS4SX2N2Z9hi7cH7DoiCCf2yrJmp01wpOZ8Lkr2o/u7WP6Y9BFbrK4Os7jLSeyFqLD3aM
        GBWQgxqg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pPoVP-001QMo-0x; Wed, 08 Feb 2023 17:45:15 +0000
Date:   Wed, 8 Feb 2023 17:45:14 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     hughd@google.com, akpm@linux-foundation.org, linux-mm@kvack.org,
        p.raghav@samsung.com, dave@stgolabs.net, a.manzanares@samsung.com,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC 2/2] shmem: add support to ignore swap
Message-ID: <Y+PfqulG2wt0Y+Vr@casper.infradead.org>
References: <20230207025259.2522793-1-mcgrof@kernel.org>
 <20230207025259.2522793-3-mcgrof@kernel.org>
 <Y+HNL9RoP48tquGd@casper.infradead.org>
 <Y+PHPfiVS6EiTVl1@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+PHPfiVS6EiTVl1@bombadil.infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 08, 2023 at 08:01:01AM -0800, Luis Chamberlain wrote:
> On Tue, Feb 07, 2023 at 04:01:51AM +0000, Matthew Wilcox wrote:
> > On Mon, Feb 06, 2023 at 06:52:59PM -0800, Luis Chamberlain wrote:
> > > @@ -1334,11 +1336,15 @@ static int shmem_writepage(struct page *page, struct writeback_control *wbc)
> > >  	struct shmem_inode_info *info;
> > >  	struct address_space *mapping = folio->mapping;
> > >  	struct inode *inode = mapping->host;
> > > +	struct shmem_sb_info *sbinfo = SHMEM_SB(inode->i_sb);
> > >  	swp_entry_t swap;
> > >  	pgoff_t index;
> > >  
> > >  	BUG_ON(!folio_test_locked(folio));
> > >  
> > > +	if (wbc->for_reclaim && unlikely(sbinfo->noswap))
> > > +		return AOP_WRITEPAGE_ACTIVATE;
> > 
> > Not sure this is the best way to handle this.  We'll still incur the
> > oevrhead of tracking shmem pages on the LRU, only to fail to write them
> > out when the VM thinks we should get rid of them.  We'd be better off
> > not putting them on the LRU in the first place.
> 
> Ah, makes sense, so in effect then if we do that then on reclaim
> we should be able to even WARN_ON(sbinfo->noswap) assuming we did
> everthing right.
> 
> Hrm, we have invalidate_mapping_pages(mapping, 0, -1) but that seems a bit
> too late how about d_mark_dontcache() on shmem_get_inode() instead?

I was thinking that the two calls to folio_add_lru() in mm/shmem.c
should be conditional on sbinfo->noswap.
