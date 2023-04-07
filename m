Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 705D76DB266
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 20:04:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231499AbjDGSEK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 14:04:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231293AbjDGSEI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 14:04:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D159EC140
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 11:03:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 276C660DCE
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 18:03:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A212BC433EF;
        Fri,  7 Apr 2023 18:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680890616;
        bh=zeLvM+wG9Reg7GPWHX1rrEptBgIOs976gIhZ41Bbdos=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bOGgaZo+OHVpjw84ut+dKEBX8kFMCYoAYvoqWCKJ+4sKeUDzoTpJFXWmNWDitx7Fz
         az/TmAIhaqK17Oq6C8Bg/3lHyHo9y8gco3TEVPnUjZH1tyucUpvdp2ILqKtfPrIwxm
         QnRv47iEtUSkXPWdL/GAlDpOPu07hs6MQcowF7tYX2ohpph3bbxrVIqbnr3Hsy56NO
         uK1YxKGwuZY6n36JWZOQquc5nKAJwrYfX5mtk7QXlms/euEEbz+c1a8MFZFQgJ6dZo
         dVf764QB+0TmW9RpbsMPNaA7inIOik2tT7UU3PO4JQmlKMm+rBHt8NxlmNQhWIY9L/
         aI7IapTui+ybg==
Date:   Fri, 7 Apr 2023 21:03:24 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm-treewide-redefine-max_order-sanely-fix.txt
Message-ID: <ZDBa7HWZK69dKKzH@kernel.org>
References: <9460377a-38aa-4f39-ad57-fb73725f92db@roeck-us.net>
 <20230406072529.vupqyrzqnhyozeyh@box.shutemov.name>
 <83e6bc46-dfc0-0e95-e69c-5b996af1e50b@roeck-us.net>
 <20230406151015.yndcm24fyxitvqyc@box.shutemov.name>
 <ZC82N4sP5xE63kl4@kernel.org>
 <20230406154423.20a991bbdd47630fc38d94e8@linux-foundation.org>
 <20230407124054.27iiers6o36pdfei@box.shutemov.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230407124054.27iiers6o36pdfei@box.shutemov.name>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 07, 2023 at 03:40:54PM +0300, Kirill A. Shutemov wrote:
> On Thu, Apr 06, 2023 at 03:44:23PM -0700, Andrew Morton wrote:
> > On Fri, 7 Apr 2023 00:14:31 +0300 Mike Rapoport <rppt@kernel.org> wrote:
> > 
> > > > > Shouldn't that be
> > > > > 		else
> > > > > 			order = 0;
> > > > > ?
> > > > 
> > > > +Mike.
> > > > 
> > > > No. start == 0 is MAX_ORDER-aligned. We want to free the pages in the
> > > > largest chunks alignment allows.
> > > 
> > > Right. Before the changes to MAX_ORDER it was
> > > 
> > > 		order = min(MAX_ORDER - 1UL, __ffs(start));
> > > 
> > > which would evaluate to 10.
> > > 
> > > I'd just prefer the comment to include the explanation about why we choose
> > > MAX_ORDER for start == 0. Say
> > > 
> > > 	/*
> > > 	 * __ffs() behaviour is undefined for 0 and we want to free the
> > > 	 * pages in the largest chunks alignment allows, so set order to
> > > 	 * MAX_ORDER when start == 0
> > > 	 */
> > 
> > Meanwhile I'd like to fix "various boot failures (hang) on arm targets"
> > in -next, so I queued up Kirill's informal fix for now.
> 
> Here's my variant of the fix up with more vervose comments.
> 
> diff --git a/mm/memblock.c b/mm/memblock.c
> index 7911224b1ed3..381e36ac9e4d 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -2043,7 +2043,16 @@ static void __init __free_pages_memory(unsigned long start, unsigned long end)
>  	int order;
>  
>  	while (start < end) {
> -		order = min_t(int, MAX_ORDER, __ffs(start));
> +		/*
> +		 * Free the pages in the largest chunks alignment allows.
> +		 *
> +		 * __ffs() behaviour is undefined for 0. start == 0 is
> +		 * MAX_ORDER-aligned, Set order to MAX_ORDER for the case.

                                      ^ small s
otherwise feel free to add

Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>

> +		 */
> +		if (start)
> +			order = min_t(int, MAX_ORDER, __ffs(start));
> +		else
> +			order = MAX_ORDER;
>  
>  		while (start + (1UL << order) > end)
>  			order--;
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index c8f0a8c2d049..8e0fa209d533 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -605,7 +605,18 @@ static void online_pages_range(unsigned long start_pfn, unsigned long nr_pages)
>  	 * this and the first chunk to online will be pageblock_nr_pages.
>  	 */
>  	for (pfn = start_pfn; pfn < end_pfn;) {
> -		int order = min_t(int, MAX_ORDER, __ffs(pfn));
> +		int order;
> +
> +		/*
> +		 * Free to online pages in the largest chunks alignment allows.
> +		 *
> +		 * __ffs() behaviour is undefined for 0. start == 0 is
> +		 * MAX_ORDER-aligned, Set order to MAX_ORDER for the case.
> +		 */
> +		if (pfn)
> +			order = min_t(int, MAX_ORDER, __ffs(pfn));
> +		else
> +			order = MAX_ORDER;
>  
>  		(*online_page_callback)(pfn_to_page(pfn), order);
>  		pfn += (1UL << order);
> -- 
>   Kiryl Shutsemau / Kirill A. Shutemov

-- 
Sincerely yours,
Mike.
