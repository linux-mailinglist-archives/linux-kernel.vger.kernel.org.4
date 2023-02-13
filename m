Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69D48694BA1
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 16:50:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbjBMPuO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 10:50:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjBMPuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 10:50:13 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BABB1A48B
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 07:50:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=Kte+m+lKTTqG6oB4BYfQ5mT5ptHhOKa/aRTefrLttjg=; b=TF0M23iV/VnK1s3qQ7lbJNu1yT
        EeFjl90WPGS+pTyXDXykXkXQ/CpZQRwodVCXMYEYr6l//iRUFQT6v43Wf3VifyvbmJBdwLqR9uhS/
        U5H9FJxE/AoN/Z6N+xySm7wDeVsUukwgak5xXYPSjQUpzIz1VLVC1SoYN8LJRKFyL4U8EKcKbN3xo
        kWyKRgoXntLfPygw3wA4DOvkCjlx/4ytjXeY3/8Tdlvx3LSWFgBbh002CVTChiISZhd9lDH9YnDPP
        GnCKP58TUvHa8dGKjAlvrE8WXcVmm8RUPBYYMocpqMCZ8Jd/nnRhJyNaQYRWKqIehTsT3AKnpOU4B
        HpU2kJYA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pRb5f-005tiD-V5; Mon, 13 Feb 2023 15:50:04 +0000
Date:   Mon, 13 Feb 2023 15:50:03 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Alexandre Ghiti <alex@ghiti.fr>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: Re: [PATCH 2/2] mm/khugepaged: Convert release_pte_pages() to use
 folios
Message-ID: <Y+pcK41bagzzhgj+@casper.infradead.org>
References: <20230114001556.43795-1-vishal.moola@gmail.com>
 <20230114001556.43795-2-vishal.moola@gmail.com>
 <CGME20230213085312eucas1p2252fe07e3eadea5e2a80dfdd3aa96507@eucas1p2.samsung.com>
 <ff300770-afe9-908d-23ed-d23e0796e899@samsung.com>
 <3a3457b1-60bc-a97b-0042-432790d3bbbe@ghiti.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3a3457b1-60bc-a97b-0042-432790d3bbbe@ghiti.fr>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 13, 2023 at 04:28:05PM +0100, Alexandre Ghiti wrote:
> The issue lies here: before using pteval in pfn_folio(), we should test it.
> The following patch fixes the issue for me:

Thanks for debugging it.  I'd rather see this written as ...

		pte_t pteval = *_pte;
+		unsigned long pfn;

+		if (pte_none(pteval))
+			continue;
+		pfn = pte_pfn(pteval);
+		if (is_zero_pfn(pfn))
+			continue;
+		folio = pfn_folio(pfn);
+		if (folio_test_large(folio))
+			continue;
		release_pte_folio(folio);

makes sense?

> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index eb38bd1b1b2f..fef3414b481b 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -514,10 +514,12 @@ static void release_pte_pages(pte_t *pte, pte_t *_pte,
>         while (--_pte >= pte) {
>                 pte_t pteval = *_pte;
> 
> -               folio = pfn_folio(pte_pfn(pteval));
> -               if (!pte_none(pteval) && !is_zero_pfn(pte_pfn(pteval)) &&
> -                               !folio_test_large(folio))
> -                       release_pte_folio(folio);
> +               if (!pte_none(pteval) && !is_zero_pfn(pte_pfn(pteval))) {
> +                       folio = pfn_folio(pte_pfn(pteval));
> +
> +                       if (!folio_test_large(folio))
> +                               release_pte_folio(folio);
> +               }
>         }
> 
>         list_for_each_entry_safe(folio, tmp, compound_pagelist, lru) {
> 
> 
> @Marek: could you give it a try?
> 
> I can send a separate patch if needed, let me know.
> 
> Thanks,
> 
> Alex
> 
> 
> > >    		if (!pte_none(pteval) && !is_zero_pfn(pte_pfn(pteval)) &&
> > > -				!PageCompound(page))
> > > -			release_pte_page(page);
> > > +				!folio_test_large(folio))
> > > +			release_pte_folio(folio);
> > >    	}
> > > -	list_for_each_entry_safe(page, tmp, compound_pagelist, lru) {
> > > -		list_del(&page->lru);
> > > -		release_pte_page(page);
> > > +	list_for_each_entry_safe(folio, tmp, compound_pagelist, lru) {
> > > +		list_del(&folio->lru);
> > > +		release_pte_folio(folio);
> > >    	}
> > >    }
> > Best regards
> 
