Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44A036DA487
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 23:14:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239506AbjDFVOr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 17:14:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbjDFVOp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 17:14:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E849D59D3
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 14:14:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 830FF60FB4
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 21:14:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C448C433EF;
        Thu,  6 Apr 2023 21:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680815683;
        bh=MIZftBGiJqlzHjA5Wfhi/OoQu1CpPVe/qKv92HcO38A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BZVs0J84dWOYp9AmkZySPpRpECfmhqVYLW3dNTClilflAUwxPMPoAX4HQGEbfHaVV
         SD7NZszCXY9k0UypwGRAcpkzVMd+VBKKQ1o7bmyuns65JfrDe4eaxD/A7CqtSgGJHF
         KJXuu17qvlLpKPGGQ94cILkxHbUpTuGa1JeXPRAEKNjIIEL3fGhmpGa1cuVlNuT65X
         +vfpenWSctWuM9deyYvSAUufC3pxiOBZ/cM11ZazQ+9NYRSYVjAc6BzMTECOC+uQtG
         EUO8WVcn0uIz5CVcMcxPE89Oa46BxRQecyu5YuAcrs1/bBpDzQpTl+nfwG6hx2j2ip
         BhWKjUIT9GWFQ==
Date:   Fri, 7 Apr 2023 00:14:31 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm-treewide-redefine-max_order-sanely-fix.txt
Message-ID: <ZC82N4sP5xE63kl4@kernel.org>
References: <9460377a-38aa-4f39-ad57-fb73725f92db@roeck-us.net>
 <20230406072529.vupqyrzqnhyozeyh@box.shutemov.name>
 <83e6bc46-dfc0-0e95-e69c-5b996af1e50b@roeck-us.net>
 <20230406151015.yndcm24fyxitvqyc@box.shutemov.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230406151015.yndcm24fyxitvqyc@box.shutemov.name>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 06, 2023 at 06:10:15PM +0300, Kirill A. Shutemov wrote:
> On Thu, Apr 06, 2023 at 06:57:41AM -0700, Guenter Roeck wrote:
> > On 4/6/23 00:25, Kirill A. Shutemov wrote:
> > > On Wed, Apr 05, 2023 at 10:20:26PM -0700, Guenter Roeck wrote:
> > > > Hi,
> > > > 
> > > > On Wed, Mar 15, 2023 at 06:38:00PM +0300, Kirill A. Shutemov wrote:
> > > > > fix min() warning
> > > > > 
> > > > > Link: https://lkml.kernel.org/r/20230315153800.32wib3n5rickolvh@box
> > > > > Reported-by: kernel test robot <lkp@intel.com>
> > > > >    Link: https://lore.kernel.org/oe-kbuild-all/202303152343.D93IbJmn-lkp@intel.com/
> > > > > Signed-off-by: "Kirill A. Shutemov" <kirill@shutemov.name>
> > > > > Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> > > > > Cc: Zi Yan <ziy@nvidia.com>
> > > > > Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> > > > 
> > > > This patch results in various boot failures (hang) on arm targets
> > > > in linux-next. Debug messages reveal the reason.
> > > > 
> > > > ########### MAX_ORDER=10 start=0 __ffs(start)=-1 min()=10 min_t=-1
> > > >                           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > > > 
> > > > If start==0, __ffs(start) returns 0xfffffff or (as int) -1, which min_t()
> > > > interprets as such, while min() apparently uses the returned unsigned long
> > > > value. Obviously a negative order isn't received well by the rest of the
> > > > code.
> > > 
> > > Actually, __ffs() is not defined for 0.
> > > 
> > > Maybe something like this?
> > > 
> > > diff --git a/mm/memblock.c b/mm/memblock.c
> > > index 7911224b1ed3..63603b943bd0 100644
> > > --- a/mm/memblock.c
> > > +++ b/mm/memblock.c
> > > @@ -2043,7 +2043,11 @@ static void __init __free_pages_memory(unsigned long start, unsigned long end)
> > >   	int order;
> > >   	while (start < end) {
> > > -		order = min_t(int, MAX_ORDER, __ffs(start));
> > > +		/* __ffs() behaviour is undefined for 0 */
> > > +		if (start)
> > > +			order = min_t(int, MAX_ORDER, __ffs(start));
> > > +		else
> > > +			order = MAX_ORDER;
> > 
> > Shouldn't that be
> > 		else
> > 			order = 0;
> > ?
> 
> +Mike.
> 
> No. start == 0 is MAX_ORDER-aligned. We want to free the pages in the
> largest chunks alignment allows.

Right. Before the changes to MAX_ORDER it was

		order = min(MAX_ORDER - 1UL, __ffs(start));

which would evaluate to 10.

I'd just prefer the comment to include the explanation about why we choose
MAX_ORDER for start == 0. Say

	/*
	 * __ffs() behaviour is undefined for 0 and we want to free the
	 * pages in the largest chunks alignment allows, so set order to
	 * MAX_ORDER when start == 0
	 */

> -- 
>   Kiryl Shutsemau / Kirill A. Shutemov

-- 
Sincerely yours,
Mike.
