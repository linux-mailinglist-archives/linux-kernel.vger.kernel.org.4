Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D0DF730935
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 22:34:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236918AbjFNUdy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 16:33:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236396AbjFNUdv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 16:33:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1386226BA
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 13:33:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8FA906184D
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 20:33:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C85DBC433C0;
        Wed, 14 Jun 2023 20:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1686774819;
        bh=Iu93SuweVrRX7FVAD9kDUf9pdECryvqWZ90NRtl/CPM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=pSwEuI0aIqzS/2+x/BhbgWOiPFgdB3tHAXo9/s4EEeQpUBC6DL34uboA1uV9fel//
         tmwtpHlh9olp17mtfnOvFdKh/SZJsYxpZEZJJ7bTf8mz1FSNkjAHrQm0Y16fIoU0dv
         KR9VvyNtVnVajWAOyJ6WJ+MtyO71bVnyYORfmY/U=
Date:   Wed, 14 Jun 2023 13:33:37 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/5] mmzone: Introduce folio_migratetype()
Message-Id: <20230614133337.f5eb6ef530d7d6cb1edbcf0d@linux-foundation.org>
In-Reply-To: <ZIogXmFNr3MnBtjX@casper.infradead.org>
References: <20230614021312.34085-1-vishal.moola@gmail.com>
        <20230614021312.34085-3-vishal.moola@gmail.com>
        <20230614131305.2939f29e4372c94a8c6a56a8@linux-foundation.org>
        <ZIogXmFNr3MnBtjX@casper.infradead.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Jun 2023 21:17:34 +0100 Matthew Wilcox <willy@infradead.org> wrote:

> On Wed, Jun 14, 2023 at 01:13:05PM -0700, Andrew Morton wrote:
> > On Tue, 13 Jun 2023 19:13:09 -0700 "Vishal Moola (Oracle)" <vishal.moola@gmail.com> wrote:
> > 
> > > Introduce folio_migratetype() as a folio equivalent for
> > > get_pageblock_migratetype(). This function intends to return the
> > > migratetype the folio is located in, hence the name choice.
> > > 
> > > ...
> > >
> > > --- a/include/linux/mmzone.h
> > > +++ b/include/linux/mmzone.h
> > > @@ -105,6 +105,9 @@ extern int page_group_by_mobility_disabled;
> > >  #define get_pageblock_migratetype(page)					\
> > >  	get_pfnblock_flags_mask(page, page_to_pfn(page), MIGRATETYPE_MASK)
> > >  
> > > +#define folio_migratetype(folio)				\
> > > +	get_pfnblock_flags_mask(&folio->page, folio_pfn(folio),		\
> > > +			MIGRATETYPE_MASK)
> > 
> > Theoretically this is risky because it evaluates its argument more than
> > once.  Although folio_migratetype(folio++) seems an unlikely thing to do.
> 
> folio++ is always an unsafe thing to do.  folios are not consecutive
> in memory (unless we know they're order-0).

OK, folio_migratetype(expensive_function_which_returns_a_folio()) or
folio_migratetype(function_with_side_effects_which_returns_a_folio()). 
There are many failure modes.

> > An inlined C function is always preferable.  My quick attempt at that
> > reveals that the header files are All Messed Up As Usual.
> 
> The page-equivalent of this also evaluates its arguments more than once,
> so it doesn't see too risky for now?

We got lucky.   It's just bad practice.
