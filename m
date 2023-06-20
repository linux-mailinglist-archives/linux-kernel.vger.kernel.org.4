Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F38B27370C9
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 17:44:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231703AbjFTPoo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 11:44:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231721AbjFTPol (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 11:44:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F43810F4
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 08:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687275828;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7/6q4gTkvc30OYeDjeAdNcm26xZpxhhkMzm5gksN37U=;
        b=fdolq3JH6m9iqYRrZUYzbsa5gzrQfHIeLmal/zM5tzhsWgULo3tuPu2QvBVPlgnrj9sYJd
        /OBoYak0D2E1imgzCzMnJP/eQl1t024Se2etJ2Xkk6PPWXvhBTXCtDQhJ9EiA/sIb2kbBP
        K448WO7VnrWGIIhzOYcoM6gRtowZQcI=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-670-Oie26bwxNLyw4oa9yr-MeQ-1; Tue, 20 Jun 2023 11:43:42 -0400
X-MC-Unique: Oie26bwxNLyw4oa9yr-MeQ-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2b45e6e1c44so33683791fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 08:43:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687275817; x=1689867817;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7/6q4gTkvc30OYeDjeAdNcm26xZpxhhkMzm5gksN37U=;
        b=Ys5dPu2kMIt8vKoPy+bkKhR6ZzgMgaf7pKOQCac9vcN93jNt4Cql0PZy1bI0ekNCYq
         OrMYL9AS1ASdaTk6B5M/G0AuVDn6yjIfBXHciQ+BTllMleqdvLUCydDOYezW+qGByf0H
         OMGvR7K9PUUNvwU2OU8wTO+bXu+uQXAhj1yBTdzmwh3LCClk/5LXnmrzQYp06aKUl3Bp
         RUB8vrlQBcQVRilmEerNaqsTdPxxckzQsrXS5NQIcxaMyImgM0Upy0yIsKmxcD7DiJ6z
         qGy0iBIOFcvHLIbyWbq3MHGQE8ZYmJDCrDoWEYxYX7vZORm9mAjOHzQWyPn7DClB3EUw
         gL4g==
X-Gm-Message-State: AC+VfDwgD2Xxo1jT7xljzvacXKn99YWAA0OyDcq8BjEikzXK61fOaCaF
        FAcrwdaD6RtAB34w8hgnppHUrfUAdLMhnG3hsuFGSczQBFJ7s/qyHv5mo7eQ6/pQ4u9ZhvS7Fs4
        KSgKx518Ja2vX9g6A3blklHCA
X-Received: by 2002:a19:ca01:0:b0:4f8:56cd:da8c with SMTP id a1-20020a19ca01000000b004f856cdda8cmr6673073lfg.34.1687275817177;
        Tue, 20 Jun 2023 08:43:37 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6w7hOiteiIn8xI/CmrWnZtgYHpyBwP1uBoTYnp+qxJ1Ld6Y72h5hSEc+v2kSqdr2tsSNZZ8w==
X-Received: by 2002:a19:ca01:0:b0:4f8:56cd:da8c with SMTP id a1-20020a19ca01000000b004f856cdda8cmr6673052lfg.34.1687275816805;
        Tue, 20 Jun 2023 08:43:36 -0700 (PDT)
Received: from [192.168.3.108] (p4ff23bc9.dip0.t-ipconnect.de. [79.242.59.201])
        by smtp.gmail.com with ESMTPSA id m7-20020a7bca47000000b003f90b9b2c31sm7728390wml.28.2023.06.20.08.43.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jun 2023 08:43:36 -0700 (PDT)
Message-ID: <02a057a3-3d9e-4013-8762-25ceb1beec86@redhat.com>
Date:   Tue, 20 Jun 2023 17:43:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Mike Rapoport <rppt@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        John Hubbard <jhubbard@nvidia.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        James Houghton <jthoughton@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Hugh Dickins <hughd@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Jason Gunthorpe <jgg@nvidia.com>
References: <20230619231044.112894-1-peterx@redhat.com>
 <20230619231044.112894-6-peterx@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v2 5/8] mm/gup: Accelerate thp gup even for "pages !=
 NULL"
In-Reply-To: <20230619231044.112894-6-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.06.23 01:10, Peter Xu wrote:
> The acceleration of THP was done with ctx.page_mask, however it'll be
> ignored if **pages is non-NULL.
> 
> The old optimization was introduced in 2013 in 240aadeedc4a ("mm:
> accelerate mm_populate() treatment of THP pages").  It didn't explain why
> we can't optimize the **pages non-NULL case.  It's possible that at that
> time the major goal was for mm_populate() which should be enough back then.

In the past we had these sub-page refcounts for THP. My best guess (and 
I didn't check if that was still the case in 2013) would be that it was 
simpler regarding refcount handling to to do it one-subpage at a time.

But I might be just wrong.

> 
> Optimize thp for all cases, by properly looping over each subpage, doing
> cache flushes, and boost refcounts / pincounts where needed in one go.
> 
> This can be verified using gup_test below:
> 
>    # chrt -f 1 ./gup_test -m 512 -t -L -n 1024 -r 10
> 
> Before:    13992.50 ( +-8.75%)
> After:       378.50 (+-69.62%)
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   mm/gup.c | 51 ++++++++++++++++++++++++++++++++++++++++++++-------
>   1 file changed, 44 insertions(+), 7 deletions(-)
> 
> diff --git a/mm/gup.c b/mm/gup.c
> index 4a00d609033e..b50272012e49 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -1199,16 +1199,53 @@ static long __get_user_pages(struct mm_struct *mm,
>   			goto out;
>   		}
>   next_page:
> -		if (pages) {
> -			pages[i] = page;
> -			flush_anon_page(vma, page, start);
> -			flush_dcache_page(page);
> -			ctx.page_mask = 0;
> -		}
> -
>   		page_increm = 1 + (~(start >> PAGE_SHIFT) & ctx.page_mask);
>   		if (page_increm > nr_pages)
>   			page_increm = nr_pages;
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
> +			}
> +
> +			for (j = 0; j < page_increm; j++) {
> +				subpage = nth_page(page, j);
> +				pages[i+j] = subpage;

Doe checkpatch like pages[i+j]? I'd have used spaces around the +.

> +				flush_anon_page(vma, subpage, start + j * PAGE_SIZE);
> +				flush_dcache_page(subpage);
> +			}
> +		}
> +
>   		i += page_increm;
>   		start += page_increm * PAGE_SIZE;
>   		nr_pages -= page_increm;


So, we did the first try_grab_folio() while our page was PMD-mapped 
udner the PT lock and we had sufficient permissions (e.g., mapped 
writable, no unsharing required). With FOLL_PIN, we incremented the 
pincount.


I was wondering if something could have happened ever since we unlocked 
the PT table lock and possibly PTE-mapped the THP. ... but as it's 
already pinned, it cannot get shared during fork() [will stay exclusive].

So we can just take additional pins on that folio.


LGTM, although I do like the GUP-fast way of recording+ref'ing it at a 
central place (see gup_huge_pmd() with record_subpages() and friends), 
not after the effects.

-- 
Cheers,

David / dhildenb

