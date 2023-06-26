Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47CC173D91E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 10:07:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbjFZIHX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 04:07:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjFZIHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 04:07:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB12C83
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 01:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687766791;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bdy6ilB9MCEHjnSXB3UxFLYarjo26SKIUeQi/Jp98Ng=;
        b=fseRFZ2Y1C86eQ4Ycewy0oPh723ulsVvm8pgKTZWC5KH08TabAuhac1yZJB/BUeBuVJZZE
        S4PHbwBXCD1PiR2pbGOYvngX9sJxsEK76m3A18b3SoHZWITy6poSkI+frJpx0KKPv7cIjA
        K0591gMt08R7+Uh7r/dGVMCV2FX8VuQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-672-DwZpn1tsOHC4lmOapfi0fQ-1; Mon, 26 Jun 2023 04:06:27 -0400
X-MC-Unique: DwZpn1tsOHC4lmOapfi0fQ-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-313f3c115eeso192691f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 01:06:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687766786; x=1690358786;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bdy6ilB9MCEHjnSXB3UxFLYarjo26SKIUeQi/Jp98Ng=;
        b=P57eFJ32SXLmDHsQG6QImxE0FMdgFMDHT8uiMooTG+QzDvvXjnBcse5kjU3cYAF9/X
         eBbbPlv281D/vC5DdRQD1IX5KSpBqFbL+ubQGa1JG8ii1ic93jI2ET9C0R8e5/e85MYa
         efLnix21ta/Cg2Fh3I7NYYtxQnOlP+mdt1tb4C6WihY1Dm81Jfa6Qscc2nY1b25RaOaJ
         61depiJUebRu80wDFfzu9Z/njSxJtisxX7UXCg/3P+1aBteHePVwF2zaWEq0cttUUwY1
         PueLjHYEPWScR7QGcuyw5EM17SjuCv5c0hRLl7gA+oREsPhnVlxxS6dRJB7/KsGokQUQ
         bkQw==
X-Gm-Message-State: AC+VfDw+u/1UeAegsIWjeqvA/rU5g+9VB9bJPprZL/L+080Rj2j3NYMq
        AFceT7YbHbx3cukMoVTyUSQpd/l7vZLVcczgHMq7kISeuXGTyQ02ui9QwcuUCv034OojjrxZMf0
        iPQF2IM5e7SnX0RpYqHhwaTWz
X-Received: by 2002:a5d:5507:0:b0:313:e5ca:7517 with SMTP id b7-20020a5d5507000000b00313e5ca7517mr4774726wrv.9.1687766786181;
        Mon, 26 Jun 2023 01:06:26 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ76umJhgn/Hm6w0c6df0Vzwzqxxov5wQMyiuFZk9tAwcFYpmaRyYFJYCRhnVdFCT+eZjeiL5Q==
X-Received: by 2002:a5d:5507:0:b0:313:e5ca:7517 with SMTP id b7-20020a5d5507000000b00313e5ca7517mr4774703wrv.9.1687766785754;
        Mon, 26 Jun 2023 01:06:25 -0700 (PDT)
Received: from ?IPV6:2003:cb:c74b:7300:2ef6:6cd6:703c:e498? (p200300cbc74b73002ef66cd6703ce498.dip0.t-ipconnect.de. [2003:cb:c74b:7300:2ef6:6cd6:703c:e498])
        by smtp.gmail.com with ESMTPSA id l6-20020a5d4106000000b0030c2e3c7fb3sm6559048wrp.101.2023.06.26.01.06.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jun 2023 01:06:25 -0700 (PDT)
Message-ID: <89fee4bf-29a1-db19-e0ae-dd827d277504@redhat.com>
Date:   Mon, 26 Jun 2023 10:06:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Lorenzo Stoakes <lstoakes@gmail.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Yang Shi <shy828301@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        James Houghton <jthoughton@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Hugh Dickins <hughd@google.com>,
        Jason Gunthorpe <jgg@nvidia.com>
References: <20230623142936.268456-1-peterx@redhat.com>
 <20230623142936.268456-3-peterx@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v3 2/8] mm/hugetlb: Prepare hugetlb_follow_page_mask() for
 FOLL_PIN
In-Reply-To: <20230623142936.268456-3-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23.06.23 16:29, Peter Xu wrote:
> follow_page() doesn't use FOLL_PIN, meanwhile hugetlb seems to not be the
> target of FOLL_WRITE either.  However add the checks.
> 
> Namely, either the need to CoW due to missing write bit, or proper
> unsharing on !AnonExclusive pages over R/O pins to reject the follow page.
> That brings this function closer to follow_hugetlb_page().
> 
> So we don't care before, and also for now.  But we'll care if we switch
> over slow-gup to use hugetlb_follow_page_mask().  We'll also care when to
> return -EMLINK properly, as that's the gup internal api to mean "we should
> unshare".  Not really needed for follow page path, though.
> 
> When at it, switching the try_grab_page() to use WARN_ON_ONCE(), to be
> clear that it just should never fail.  When error happens, instead of
> setting page==NULL, capture the errno instead.
> 
> Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   mm/hugetlb.c | 31 ++++++++++++++++++++-----------
>   1 file changed, 20 insertions(+), 11 deletions(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index f75f5e78ff0b..27367edf5c72 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -6462,13 +6462,7 @@ struct page *hugetlb_follow_page_mask(struct vm_area_struct *vma,
>   	struct page *page = NULL;
>   	spinlock_t *ptl;
>   	pte_t *pte, entry;
> -
> -	/*
> -	 * FOLL_PIN is not supported for follow_page(). Ordinary GUP goes via
> -	 * follow_hugetlb_page().
> -	 */
> -	if (WARN_ON_ONCE(flags & FOLL_PIN))
> -		return NULL;
> +	int ret;
>   
>   	hugetlb_vma_lock_read(vma);
>   	pte = hugetlb_walk(vma, haddr, huge_page_size(h));
> @@ -6478,8 +6472,21 @@ struct page *hugetlb_follow_page_mask(struct vm_area_struct *vma,
>   	ptl = huge_pte_lock(h, mm, pte);
>   	entry = huge_ptep_get(pte);
>   	if (pte_present(entry)) {
> -		page = pte_page(entry) +
> -				((address & ~huge_page_mask(h)) >> PAGE_SHIFT);
> +		page = pte_page(entry);
> +
> +		if ((flags & FOLL_WRITE) && !huge_pte_write(entry)) {
> +			page = NULL;
> +			goto out;
> +		}
> +
> +		if (gup_must_unshare(vma, flags, page)) {
> +			/* Tell the caller to do unsharing */
> +			page = ERR_PTR(-EMLINK);
> +			goto out;
> +		}


No need to check if the page is writable (like all other callers and as 
gup_must_unshare() documents -- "for which pages that are 
write-protected in the page table")

if (!huge_pte_write(entry) && gup_must_unshare(vma, flags, page)) {


With that

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb

