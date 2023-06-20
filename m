Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20344737060
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 17:23:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233169AbjFTPXQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 11:23:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232859AbjFTPXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 11:23:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71DB0DD
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 08:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687274549;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vUHsmWFXJbqKAxJCOSo9wPf2HsRiiOjgMGetTznsPf8=;
        b=i+MZ6/oXWSrV73uxDMKuueUN8rmMH58W1xzuMUrkG19rVdiJbWFeaV+j4oTlWNWzEYArAC
        8y6cxS1MBi4g9vJbUgKR9ZkbcCNplq/pJXOcpcHs7khH2vFfNGDSDmI3DDcELLGIKJ6jo3
        11zwJnaWtSoM6pGMbRHroH2VkizS9ZE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-pTMdgRuWNlaKU4rmOmXx0g-1; Tue, 20 Jun 2023 11:22:23 -0400
X-MC-Unique: pTMdgRuWNlaKU4rmOmXx0g-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-30e4943ca7fso1812617f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 08:22:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687274524; x=1689866524;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vUHsmWFXJbqKAxJCOSo9wPf2HsRiiOjgMGetTznsPf8=;
        b=f5JvUMrlR+EyfSx0ywe7i0ghn8UEJloMiCChD5/D4O819bmGTxYj9zGKbD37qyeBQC
         8fYyuoxlktMXRai94a1rg5O+nejNwVH39mn8OvaDlEmbHkJkYVIqnIRVUxz7Evo46Am7
         I3YQD+zTyMU7/Vnb/vHWCYMjdl11O0pLkjf6Bc8/EzKGxJrt6/yBMDRJn7HzSja1V1gy
         HEBqskIVAdznKj/shfvdmj3e9quIcIaLV6qFmwYaRYMS4X90+yQP7jsYA/PGCJsV6jkY
         p7U2tafL8ldLjIErqT355HaQZm2hgiI3PGJ5CdX6Chz99vDOFrCNjEjNu5PUHemWgHZQ
         Q2cg==
X-Gm-Message-State: AC+VfDzT4TyI6W8PnoP6SJk7KqWAnODZMw1Zi0NmWEhjI/CmI+vKizAw
        JHlt0Hg56ID3uQLMKXqDqUx8oPIHFIwmJzamPGBBhEY2If1Viev/9pXcXgvyA6SggSBJ4D1tcuZ
        JKcVsqvj6rSTf0LKzBNBMEm7i
X-Received: by 2002:a5d:6a91:0:b0:2fe:e137:dbad with SMTP id s17-20020a5d6a91000000b002fee137dbadmr8376991wru.51.1687274524630;
        Tue, 20 Jun 2023 08:22:04 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5Gn4OPb3ze0G2DgnO1dg9J7p3I2mezr5RXhvZxL6SVcrkjCJEZW18z1MqUMg/O9j9exoZ+WQ==
X-Received: by 2002:a5d:6a91:0:b0:2fe:e137:dbad with SMTP id s17-20020a5d6a91000000b002fee137dbadmr8376969wru.51.1687274524265;
        Tue, 20 Jun 2023 08:22:04 -0700 (PDT)
Received: from ?IPV6:2003:cb:c739:d200:8745:c520:8bf6:b587? (p200300cbc739d2008745c5208bf6b587.dip0.t-ipconnect.de. [2003:cb:c739:d200:8745:c520:8bf6:b587])
        by smtp.gmail.com with ESMTPSA id h5-20020adff4c5000000b00304adbeeabbsm2211610wrp.99.2023.06.20.08.22.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jun 2023 08:22:03 -0700 (PDT)
Message-ID: <c77f6aeb-ddfc-3b46-55f4-aff7cf40e6b9@redhat.com>
Date:   Tue, 20 Jun 2023 17:22:02 +0200
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
 <20230619231044.112894-3-peterx@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v2 2/8] mm/hugetlb: Prepare hugetlb_follow_page_mask() for
 FOLL_PIN
In-Reply-To: <20230619231044.112894-3-peterx@redhat.com>
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

On 20.06.23 01:10, Peter Xu wrote:
> follow_page() doesn't use FOLL_PIN, meanwhile hugetlb seems to not be the
> target of FOLL_WRITE either.  However add the checks.
> 
> Namely, either the need to CoW due to missing write bit, or proper CoR on

s/CoR/unsharing/

> !AnonExclusive pages over R/O pins to reject the follow page.  That brings
> this function closer to follow_hugetlb_page().
> 
> So we don't care before, and also for now.  But we'll care if we switch
> over slow-gup to use hugetlb_follow_page_mask().  We'll also care when to
> return -EMLINK properly, as that's the gup internal api to mean "we should
> do CoR".  Not really needed for follow page path, though.

"we should unshare".

> 
> When at it, switching the try_grab_page() to use WARN_ON_ONCE(), to be
> clear that it just should never fail.
> 
> Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   mm/hugetlb.c | 24 +++++++++++++++---------
>   1 file changed, 15 insertions(+), 9 deletions(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index f75f5e78ff0b..9a6918c4250a 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -6463,13 +6463,6 @@ struct page *hugetlb_follow_page_mask(struct vm_area_struct *vma,
>   	spinlock_t *ptl;
>   	pte_t *pte, entry;
>   
> -	/*
> -	 * FOLL_PIN is not supported for follow_page(). Ordinary GUP goes via
> -	 * follow_hugetlb_page().
> -	 */
> -	if (WARN_ON_ONCE(flags & FOLL_PIN))
> -		return NULL;
> -
>   	hugetlb_vma_lock_read(vma);
>   	pte = hugetlb_walk(vma, haddr, huge_page_size(h));
>   	if (!pte)
> @@ -6478,8 +6471,21 @@ struct page *hugetlb_follow_page_mask(struct vm_area_struct *vma,
>   	ptl = huge_pte_lock(h, mm, pte);
>   	entry = huge_ptep_get(pte);
>   	if (pte_present(entry)) {
> -		page = pte_page(entry) +
> -				((address & ~huge_page_mask(h)) >> PAGE_SHIFT);
> +		page = pte_page(entry);
> +
> +		if (gup_must_unshare(vma, flags, page)) {

All other callers (like follow_page_pte(), including 
__follow_hugetlb_must_fault())

(a) check for write permissions first.

(b) check for gup_must_unshare() only if !pte_write(entry)

I'd vote to keep these checks as similar as possible to the other GUP code.

> +			/* Tell the caller to do Copy-On-Read */

"Tell the caller to unshare".

> +			page = ERR_PTR(-EMLINK);
> +			goto out;
> +		}
> +
> +		if ((flags & FOLL_WRITE) && !pte_write(entry)) {
> +			page = NULL;
> +			goto out;
> +		}


I'm confused about pte_write() vs. huge_pte_write(), and I don't know 
what's right or wrong here.

-- 
Cheers,

David / dhildenb

