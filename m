Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D2C27303ED
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 17:33:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244485AbjFNPcu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 11:32:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244612AbjFNPci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 11:32:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BB37C7
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 08:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686756712;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bSMzRpyJ0wNBvXjZw/K2wShxm75deoTyZl3ld1N6BhM=;
        b=FAZCtGkY2lQFKx2eryfqG2vASHMlyZKyn7k2/+smn09y4MbqfUM5JUHBxBRQsB0ipJk2aq
        noD83kIRFsQ0liyQL+LPnG+Rkblneswa43K5TEvp5XpJdh3Aw3SHZd8/3XDA3a5p3vUjQX
        Kx5DikYkUeHJgzaXZNQnLayq3KBx9rk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-333-sMW7LMK-Ny6F0Z_lkQ4c4A-1; Wed, 14 Jun 2023 11:31:43 -0400
X-MC-Unique: sMW7LMK-Ny6F0Z_lkQ4c4A-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-3f5df65fa35so4266615e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 08:31:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686756698; x=1689348698;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bSMzRpyJ0wNBvXjZw/K2wShxm75deoTyZl3ld1N6BhM=;
        b=jxG3gyimfjkZAWxPAGzOE+NJEcuYLsn5srPA9ToAsI/VbZ3s/nXZ9NLs3XyiIKH2QA
         Emi7z/oq1UgHckTNX2Kq8QgqPK5txqSGv1xq+xzq8m/voRBSYTsX/gvkyXKVPv84+DRh
         AvvwtJzTV8qG3v1CDPy4aVU3fFGOvKd7Xmfi7w7fBlGJ29Z62D6Y2E5oHcuWuFAEqOtY
         9TAKZh7rmH0eMgzaMkEOmF2XVxIZfOOVHMTBMnxSz7lMaST81yeUXud1Vh9P2zSEWDnR
         o69uneh0vXDcYt4kY/LlIJ2L5EWMdoYZJdgICmAJIxuzbTVFoA0I9E0E3LMpN35liTuV
         I/Xw==
X-Gm-Message-State: AC+VfDyDZL7OOQ6yrRGYUuSDq4VtDBj6JhHqMJU9XKXXAU76OncJeS93
        F/aS3FflOfoqs9+E9wryml2/J0sXVHJV3k2oJ8hGllv+yZSJPbmwEmdAtndrU+KI6PZQYT4mjRE
        tZgjbVJKOKLWsCWKgDJopm4OxGZMVyQcw
X-Received: by 2002:a05:600c:2189:b0:3f7:81e9:2f02 with SMTP id e9-20020a05600c218900b003f781e92f02mr10963543wme.4.1686756698675;
        Wed, 14 Jun 2023 08:31:38 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7eW5JkQaMGAkyIQMGW91FvjJ4JWtbJjZ6Dd1Jk4/sDZqCHtz4Qz1KQqmZPpTYxFUoTDrQuiQ==
X-Received: by 2002:a05:600c:2189:b0:3f7:81e9:2f02 with SMTP id e9-20020a05600c218900b003f781e92f02mr10963516wme.4.1686756698329;
        Wed, 14 Jun 2023 08:31:38 -0700 (PDT)
Received: from ?IPV6:2003:cb:c704:b200:7d03:23db:ad5:2d21? (p200300cbc704b2007d0323db0ad52d21.dip0.t-ipconnect.de. [2003:cb:c704:b200:7d03:23db:ad5:2d21])
        by smtp.gmail.com with ESMTPSA id a11-20020a05600c224b00b003f8126bcf34sm13411844wmm.48.2023.06.14.08.31.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Jun 2023 08:31:37 -0700 (PDT)
Message-ID: <24bc512a-b5c2-b7ea-fa83-5752cec7455b@redhat.com>
Date:   Wed, 14 Jun 2023 17:31:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Cc:     Matthew Wilcox <willy@infradead.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Mike Rapoport <rppt@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        James Houghton <jthoughton@google.com>,
        Hugh Dickins <hughd@google.com>
References: <20230613215346.1022773-1-peterx@redhat.com>
 <20230613215346.1022773-3-peterx@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH 2/7] mm/hugetlb: Fix hugetlb_follow_page_mask() on
 permission checks
In-Reply-To: <20230613215346.1022773-3-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.06.23 23:53, Peter Xu wrote:
> It seems hugetlb_follow_page_mask() was missing permission checks.  For
> example, one follow_page() can get the hugetlb page with FOLL_WRITE even if
> the page is read-only.

I'm curious if there even is a follow_page() user that operates on 
hugetlb ...

s390x secure storage does not apply to hugetlb IIRC.

ksm.c? no.

huge_memory.c ? no

So what remains is most probably mm/migrate.c, which never sets FOLL_WRITE.


Or am I missing something a user?

>  > And it wasn't there even in the old follow_page_mask(), where we can
> reference from before commit 57a196a58421 ("hugetlb: simplify hugetlb
> handling in follow_page_mask").
> 
> Let's add them, namely, either the need to CoW due to missing write bit, or
> proper CoR on !AnonExclusive pages over R/O pins to reject the follow page.
> That brings this function closer to follow_hugetlb_page().
> 
> I just doubt how many of us care for that, for FOLL_PIN follow_page doesn't
> really happen at all.  But we'll care, and care more if we switch over
> slow-gup to use hugetlb_follow_page_mask().  We'll also care when to return
> -EMLINK then, as that's the gup internal api to mean "we should do CoR".
> 
> When at it, switching the try_grab_page() to use WARN_ON_ONCE(), to be
> clear that it just should never fail.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   mm/hugetlb.c | 22 ++++++++++++++++------
>   1 file changed, 16 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 82dfdd96db4c..9c261921b2cf 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -6481,8 +6481,21 @@ struct page *hugetlb_follow_page_mask(struct vm_area_struct *vma,
>   	ptl = huge_pte_lock(h, mm, pte);
>   	entry = huge_ptep_get(pte);
>   	if (pte_present(entry)) {
> -		page = pte_page(entry) +
> -				((address & ~huge_page_mask(h)) >> PAGE_SHIFT);
> +		page = pte_page(entry);
> +
> +		if (gup_must_unshare(vma, flags, page)) {
> +			/* Tell the caller to do Copy-On-Read */
> +			page = ERR_PTR(-EMLINK);
> +			goto out;
> +		}
> +
> +		if ((flags & FOLL_WRITE) && !pte_write(entry)) {
> +			page = NULL;
> +			goto out;
> +		}
> +
> +		page += ((address & ~huge_page_mask(h)) >> PAGE_SHIFT);
> +
>   		/*
>   		 * Note that page may be a sub-page, and with vmemmap
>   		 * optimizations the page struct may be read only.
> @@ -6492,10 +6505,7 @@ struct page *hugetlb_follow_page_mask(struct vm_area_struct *vma,
>   		 * try_grab_page() should always be able to get the page here,
>   		 * because we hold the ptl lock and have verified pte_present().
>   		 */
> -		if (try_grab_page(page, flags)) {
> -			page = NULL;
> -			goto out;
> -		}
> +		WARN_ON_ONCE(try_grab_page(page, flags));
>   	}
>   out:
>   	spin_unlock(ptl);

-- 
Cheers,

David / dhildenb

