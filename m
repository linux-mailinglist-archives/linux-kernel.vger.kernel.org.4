Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B08365CA4F
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 00:30:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234237AbjACX34 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 18:29:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjACX3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 18:29:53 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AE3D2601
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 15:29:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=gJPqyGklqTbYMdKnqat7Qbv+pMXyAuOwKbuCLL2MIGw=; b=kgw2QhRfZdK8b99xYswM0FAnRa
        dSWhynhEso+r248R4juIWtqk7DJjJUjp0jhL12KxbqdpiSIrFQ8YSV3VoZFFQ3yO99t2DD70ULyf1
        wM3nop/kBaR8yEWyrpbQai8qbp4lcfvIeHsju2Sky76nk/2u4JpuaBwBTW6f5ZmoIh9ACBywZefUB
        tBytsJdtHZYYlXWf+BK5TNHejVhq9PzgzAkt5OuDjbnMzapHMYdNAqnLoqHqPY0Qps6mu7wHxXe44
        fUPitTOeDXgQy1Yk4pts9rgn8+abS24OGJzxGdjmvEzuziye1YpH3/+B++sf8+kPT2PuSlaL5E+EU
        uSpJ2wlw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pCqiy-00EUm4-5a; Tue, 03 Jan 2023 23:29:40 +0000
Date:   Tue, 3 Jan 2023 23:29:40 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     David Rientjes <rientjes@google.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        kernel test robot <oliver.sang@intel.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>, oe-lkp@lists.linux.dev,
        lkp@intel.com, Mike Rapoport <rppt@linux.ibm.com>,
        Christoph Lameter <cl@linux.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: A better dump_page()
Message-ID: <Y7S6ZPUKi07h5uZO@casper.infradead.org>
References: <202212312021.bc1efe86-oliver.sang@intel.com>
 <41276905-b8a5-76ae-8a17-a8ec6558e988@suse.cz>
 <Y7RKX45mvwkbiMbo@casper.infradead.org>
 <c022ddc3-1cbd-8291-68a3-f90ffb93af84@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c022ddc3-1cbd-8291-68a3-f90ffb93af84@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 03, 2023 at 03:07:12PM -0800, David Rientjes wrote:
> On Tue, 3 Jan 2023, Matthew Wilcox wrote:
> 
> > On Tue, Jan 03, 2023 at 11:42:11AM +0100, Vlastimil Babka wrote:
> > > Separately we should also make the __dump_page() more resilient.
> > 
> > Right.  It's not ideal when one of our best debugging tools obfuscates
> > the problem we're trying to debug.  I've seen probems like this before,
> > and the problem is that somebody calls dump_page() on a page that they
> > don't own a refcount on.  That lets the page mutate under us in some
> > fairly awkward ways (as you've seen here, it seems to be part of several
> > different compound allocations at various points during the dump
> > process).
> > 
> > One possibility I thought about was taking our own refcount on the
> > page at the start of dump_page().  That would kill off the possibility
> > of ever passing in a const struct page, and it would confuse people.
> > Also, what if somebody passes in a pointer to something that's not a
> > struct page?  Then we've (tried to) modify memory that's not a refcount.
> > 
> > I think the best we can do is to snapshot the struct page and the folio
> > it appears to belong to at the start of dump_page().  It'll take a
> > little care (for example, folio_pfn() must be passed the original
> > folio, and not the snapshot), but I think it's doable.
> > 
> 
> By snapshot do you mean memcpy() of the metadata to the stack?  I assume 
> this still leaves the opportunity for the underlying mutation of the page 
> but makes the window more narrow.

Right.  We'd need to memcpy() both the page and the folio, so around 192
bytes.  It doesn't make it consistent since it could be mutated during
the memcpy(), but it will be consistent throughout the execution of the
function, so we won't get calls like folio_entire_mapcount() aborting
due to the folio having become a tail page halfway through.
