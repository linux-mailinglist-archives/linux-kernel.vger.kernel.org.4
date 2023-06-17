Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB57F73437E
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 22:30:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234162AbjFQU13 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 16:27:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229825AbjFQU11 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 16:27:27 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31F871724
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 13:27:26 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2b45c289615so22771661fa.1
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 13:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687033644; x=1689625644;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=w2+b/PqnIBpq5iGqs0C3avQyNHSwvxOWMP0M0/gZo/o=;
        b=cd5pfdX0Tdkl18J7xGnfDQ8gh6C0kXzoGdvIrCJWv5k4sa89dF/BdB88vAl1YSzPOf
         QIxQBrFoV4C2O6Iq+rO0bL5P65P43N2RO4fs/rqvATO6f1r3Y6fUdrW21OiGKl64woBy
         UyhRaMjjR3tWwoZOkRUkKR7ETrgQPLjQrX5FrX/tHPI1yoS5jr6dwP4Tmf2HV9ejm2yH
         jT1UWqQJ3guYZU5UmQz4e/x9tmWyi7Tq/wu94h5kY+MNfF3y/7HgNbsmvIN+HSGpFvZv
         U+Vl+JMJQktX7CBmGAScd6y8R01f5h7aqLYFCUdPsbkJfTYVsKb45ufZNUFPthVIbhpE
         CH3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687033644; x=1689625644;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w2+b/PqnIBpq5iGqs0C3avQyNHSwvxOWMP0M0/gZo/o=;
        b=gvBE0NpS74Q3BzheuUbLF/Q9m7mFSNRLVR025qGBcVThYHPwcm32zLxN7EqrUEtFM0
         y44QcCal0TktOvm8dpnGmrGqwI+GxNxQixFIBDHF7AxdCCpMZdDEHJxkly5gxHh8FeMH
         aF5PeNf/yAnpf8hP6V7DAAq/zQsNC/50k8pDHD0OoAXyRm5287L4kmlq7JJV6tsz6YBM
         OVyDhE1G0sbOECHqWpieBnmW3iyBZk3+o9uWaCx1xn6jtk0RXT+w9Rr377Y4hUyKe7Ts
         VX6Ah39Xc8fvxDww5ejS8RADQe+o5+6S79DodMtJl4eZemaJ3B+Vd2AdXv7vNuev2a0R
         xf0A==
X-Gm-Message-State: AC+VfDw+PLMMYblmcfidDhxXuH0a3Y+9YJP55kVEANkBcTYb7FL1R9hX
        67/Q9LlgLaOqyeYgK01daRg=
X-Google-Smtp-Source: ACHHUZ4+STj2mXzKow8pWVDwnNFt8S43KcRFDBpwzrza/TMG329dUbjtVA2nVQlw+ETp80YfpcBjoQ==
X-Received: by 2002:a2e:3610:0:b0:2b4:6c8e:4379 with SMTP id d16-20020a2e3610000000b002b46c8e4379mr827043lja.22.1687033644013;
        Sat, 17 Jun 2023 13:27:24 -0700 (PDT)
Received: from localhost ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.gmail.com with ESMTPSA id q9-20020a7bce89000000b003f7cb42fa20sm5792481wmj.42.2023.06.17.13.27.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jun 2023 13:27:23 -0700 (PDT)
Date:   Sat, 17 Jun 2023 21:27:22 +0100
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Matthew Wilcox <willy@infradead.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        James Houghton <jthoughton@google.com>,
        Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH 6/7] mm/gup: Accelerate thp gup even for "pages != NULL"
Message-ID: <d8c76484-1030-44a3-b148-7e69fa84243a@lucifer.local>
References: <20230613215346.1022773-1-peterx@redhat.com>
 <20230613215346.1022773-7-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230613215346.1022773-7-peterx@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 13, 2023 at 05:53:45PM -0400, Peter Xu wrote:
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
>  mm/gup.c | 36 +++++++++++++++++++++++++++++-------
>  1 file changed, 29 insertions(+), 7 deletions(-)
>
> diff --git a/mm/gup.c b/mm/gup.c
> index a2d1b3c4b104..cdabc8ea783b 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -1210,16 +1210,38 @@ static long __get_user_pages(struct mm_struct *mm,
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
> +			 * Since we already hold refcount on the head page,
> +			 * it should never fail.
> +			 *
> +			 * NOTE: here the page may not be the head page
> +			 * e.g. when start addr is not thp-size aligned.
> +			 */
> +			if (page_increm > 1)
> +				WARN_ON_ONCE(
> +				    try_grab_folio(compound_head(page),
> +						   page_increm - 1,
> +						   foll_flags) == NULL);

I'm not sure this should be warning but otherwise ignoring this returning
NULL?  This feels like a case that could come up in realtiy,
e.g. folio_ref_try_add_rcu() fails, or !folio_is_longterm_pinnable().

Side-note: I _hate_ the semantics of GUP such that try_grab_folio()
(invoked, other than for huge page cases, by the GUP-fast logic) will
explicitly fail if neither FOLL_GET or FOLL_PIN are specified,
differentiating it from try_grab_page() in this respect.

This is a side-note and not relevant here, as all callers to
__get_user_pages() either explicitly set FOLL_GET if not set by user (in
__get_user_pages_locked()) or don't set pages (e.g. in
faultin_vma_page_range())

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
