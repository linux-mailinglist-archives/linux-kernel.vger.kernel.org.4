Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9597873090F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 22:17:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236633AbjFNURl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 16:17:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234755AbjFNURk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 16:17:40 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C3541BCE
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 13:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=bHxFZhGcHSdLpHTIxszs9CxuBIsMRRxsbZMR2wHn8Tc=; b=LFdFZsfrd0y1NAeGvqWlUvYTJ7
        2H2n6r/w+mPa8rLoeP06+zkqtqKzYcl0QKIezAvkFiU8bDe+EYRt7ZYEYH5xoz321r8Lh3QXolqRN
        b+IqR3JsCwWmU4huN8phDrN62zQWBaGwbK9E7gJadhlLJ/62no4fvoRzT91/n++WH0rTGyaaS+5hA
        /kHnhEcvYC08g8oDNxa4fKUuDfqgM1XOk4Ohn8swIz2X/dQ+2FlUMm5okIbdHUA1JfDC8kSHa6Dip
        3Ya3Rg4PNTm7/nNfuZrDvbXRaymlDvLxoDPkMmbQllAs2tqymDTItxxdvMiHMrCYjAVhPAqwcijzL
        5Ilia9bQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q9Wvu-006kPi-9B; Wed, 14 Jun 2023 20:17:34 +0000
Date:   Wed, 14 Jun 2023 21:17:34 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/5] mmzone: Introduce folio_migratetype()
Message-ID: <ZIogXmFNr3MnBtjX@casper.infradead.org>
References: <20230614021312.34085-1-vishal.moola@gmail.com>
 <20230614021312.34085-3-vishal.moola@gmail.com>
 <20230614131305.2939f29e4372c94a8c6a56a8@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230614131305.2939f29e4372c94a8c6a56a8@linux-foundation.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 14, 2023 at 01:13:05PM -0700, Andrew Morton wrote:
> On Tue, 13 Jun 2023 19:13:09 -0700 "Vishal Moola (Oracle)" <vishal.moola@gmail.com> wrote:
> 
> > Introduce folio_migratetype() as a folio equivalent for
> > get_pageblock_migratetype(). This function intends to return the
> > migratetype the folio is located in, hence the name choice.
> > 
> > ...
> >
> > --- a/include/linux/mmzone.h
> > +++ b/include/linux/mmzone.h
> > @@ -105,6 +105,9 @@ extern int page_group_by_mobility_disabled;
> >  #define get_pageblock_migratetype(page)					\
> >  	get_pfnblock_flags_mask(page, page_to_pfn(page), MIGRATETYPE_MASK)
> >  
> > +#define folio_migratetype(folio)				\
> > +	get_pfnblock_flags_mask(&folio->page, folio_pfn(folio),		\
> > +			MIGRATETYPE_MASK)
> 
> Theoretically this is risky because it evaluates its argument more than
> once.  Although folio_migratetype(folio++) seems an unlikely thing to do.

folio++ is always an unsafe thing to do.  folios are not consecutive
in memory (unless we know they're order-0).

> An inlined C function is always preferable.  My quick attempt at that
> reveals that the header files are All Messed Up As Usual.

The page-equivalent of this also evaluates its arguments more than once,
so it doesn't see too risky for now?
