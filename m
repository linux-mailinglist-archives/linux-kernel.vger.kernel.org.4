Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59ED97376CB
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 23:43:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbjFTVnp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 17:43:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbjFTVno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 17:43:44 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB3B7172C
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 14:43:42 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-30fbf253dc7so4139301f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 14:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687297421; x=1689889421;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OFOIV5n7LYzSxODkxerJSJAEZ596/FRwMkn7FgiJCPM=;
        b=OW3C6O+zZOenJS3jTySNr7Xrwf1eS4GHjg0AiTKXTVvRFNnvkZupDNuh8ErLLKUKX+
         NdxOc25lYONtyKd40AZGJBWVqC4313oQ10voKXdNV/lkJJmit2E+7RKf5ZlZ8+4ydL3E
         69WSh5Y83A+OhCkl2Q6CIRwBLOjzob8TdlEzK2XwyX03H5fAjNHnC0WpWBe0+uBLCTjH
         XyfqIFG6X7uLBHyA/+v8ZjFFqi6cH8rIdZqB9qUJW7OlrBiTdVEBjIqX5fT/ggfY+8Bn
         QAaMBF3acmbInhir+dzE/DQAaHKKmR73+E0Zl/e09CCidEa+gQN0xva+mlHSOMDpH+DB
         Izmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687297421; x=1689889421;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OFOIV5n7LYzSxODkxerJSJAEZ596/FRwMkn7FgiJCPM=;
        b=je8Nwh0GsuJSV48z1gifJuJGUry1/Qzl1iJHbVd6eJ3Q+6+aPX2UWAevEpwNfPNynh
         pflK3uNyziKMkNu2H7h/efRheugi3Igd6SK5tTg1WpGAowsA/csxkwlEbGMbCQxCmXcx
         psL9pU7NB7d12Hpn44eJtC6FCfwoxkZo7WojT2TNHEtyGtTRoKHqjySpfcYimf+Io2Si
         aT7uSqzlhI26GX/42e1jaEs8ioPeEnrhmzKnIMDk8MGZ31fa78VT7t4fDhOp0WvipfGT
         HIkXSdZWI1nNs6bn6S50nNLqLs9q2nUKXyafUP45cO8yuocs9ZDzQ0ZfNUfCJJF2YVPT
         VKlA==
X-Gm-Message-State: AC+VfDw2j5sBx/AtBhXCZhQiobDvYB+jpioiSZJe0yRZCu4PvnJZ75Kg
        XCYI/cObyoRAJ0UuzuXsIX4=
X-Google-Smtp-Source: ACHHUZ45fYpIIZajjBz0hE2VIpo921OqmDAvp90wUO1IreQfyV3apYvKNRUnEVb4DlVT1q98uSd7lw==
X-Received: by 2002:a5d:45c3:0:b0:311:1944:ad33 with SMTP id b3-20020a5d45c3000000b003111944ad33mr10814813wrs.12.1687297421070;
        Tue, 20 Jun 2023 14:43:41 -0700 (PDT)
Received: from localhost ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.gmail.com with ESMTPSA id t16-20020a5d49d0000000b0030aed4223e0sm2784675wrs.105.2023.06.20.14.43.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 14:43:40 -0700 (PDT)
Date:   Tue, 20 Jun 2023 22:43:39 +0100
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        John Hubbard <jhubbard@nvidia.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        James Houghton <jthoughton@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v2 5/8] mm/gup: Accelerate thp gup even for "pages !=
 NULL"
Message-ID: <956f7c72-4c7d-43a5-8786-5fdaa9010f7b@lucifer.local>
References: <20230619231044.112894-1-peterx@redhat.com>
 <20230619231044.112894-6-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230619231044.112894-6-peterx@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 19, 2023 at 07:10:41PM -0400, Peter Xu wrote:
> The acceleration of THP was done with ctx.page_mask, however it'll be
> ignored if **pages is non-NULL.
>
> The old optimization was introduced in 2013 in 240aadeedc4a ("mm:
> accelerate mm_populate() treatment of THP pages").  It didn't explain why
> we can't optimize the **pages non-NULL case.  It's possible that at that
> time the major goal was for mm_populate() which should be enough back then.
>
> Optimize thp for all cases, by properly looping over each subpage, doing
> cache flushes, and boost refcounts / pincounts where needed in one go.
>
> This can be verified using gup_test below:
>
>   # chrt -f 1 ./gup_test -m 512 -t -L -n 1024 -r 10
>
> Before:    13992.50 ( +-8.75%)
> After:       378.50 (+-69.62%)
>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  mm/gup.c | 51 ++++++++++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 44 insertions(+), 7 deletions(-)
>
> diff --git a/mm/gup.c b/mm/gup.c
> index 4a00d609033e..b50272012e49 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -1199,16 +1199,53 @@ static long __get_user_pages(struct mm_struct *mm,
>  			goto out;
>  		}
>  next_page:
> -		if (pages) {
> -			pages[i] = page;
> -			flush_anon_page(vma, page, start);
> -			flush_dcache_page(page);
> -			ctx.page_mask = 0;
> -		}
> -
>  		page_increm = 1 + (~(start >> PAGE_SHIFT) & ctx.page_mask);
>  		if (page_increm > nr_pages)
>  			page_increm = nr_pages;
> +
> +		if (pages) {
> +			struct page *subpage;
> +			unsigned int j;
> +
> +			/*
> +			 * This must be a large folio (and doesn't need to
> +			 * be the whole folio; it can be part of it), do
> +			 * the refcount work for all the subpages too.
> +			 *
> +			 * NOTE: here the page may not be the head page
> +			 * e.g. when start addr is not thp-size aligned.
> +			 * try_grab_folio() should have taken care of tail
> +			 * pages.
> +			 */
> +			if (page_increm > 1) {
> +				struct folio *folio;
> +
> +				/*
> +				 * Since we already hold refcount on the
> +				 * large folio, this should never fail.
> +				 */
> +				folio = try_grab_folio(page, page_increm - 1,
> +						       foll_flags);
> +				if (WARN_ON_ONCE(!folio)) {
> +					/*
> +					 * Release the 1st page ref if the
> +					 * folio is problematic, fail hard.
> +					 */
> +					gup_put_folio(page_folio(page), 1,
> +						      foll_flags);
> +					ret = -EFAULT;
> +					goto out;
> +				}

Thanks this looks good to me, I agree it'd be quite surprising for us not
to retrieve folio here and probably something has gone wrong if so, so not
actually too unreasonable to warn, as long as we error out.

> +			}
> +
> +			for (j = 0; j < page_increm; j++) {
> +				subpage = nth_page(page, j);
> +				pages[i+j] = subpage;
> +				flush_anon_page(vma, subpage, start + j * PAGE_SIZE);
> +				flush_dcache_page(subpage);
> +			}
> +		}
> +
>  		i += page_increm;
>  		start += page_increm * PAGE_SIZE;
>  		nr_pages -= page_increm;
> --
> 2.40.1
>

Looks good to me overall,

Reviewed-by: Lorenzo Stoakes <lstoakes@gmail.com>
