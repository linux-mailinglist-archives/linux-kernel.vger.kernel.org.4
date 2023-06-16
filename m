Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9F6A732985
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 10:10:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243314AbjFPIJW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 04:09:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241031AbjFPIJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 04:09:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70A012117
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 01:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686902910;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Gr7a6v7Egyynk2whMDZ85Y4nh+6uiz4a8aewos3ecfU=;
        b=dpyOtMEP/bqqeT4CMErhAS0owpqA1KGBEt7/kxhpg5otmrg7utDlmFVzjFTcrpTvsaAfuf
        MtiAblYEu4HzQKgiYUAmhcP7l5KKkIbfFMv370nxlytnvKw9xnkKmoC3cH8XhIzEbAixdq
        Nli3BCawVT7+4Yb1Hx2gnM3SJdj6bx8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-177-X2LBpSXpNCa6seMZp0P03Q-1; Fri, 16 Jun 2023 04:08:29 -0400
X-MC-Unique: X2LBpSXpNCa6seMZp0P03Q-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-30e4d85e1ffso538113f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 01:08:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686902908; x=1689494908;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gr7a6v7Egyynk2whMDZ85Y4nh+6uiz4a8aewos3ecfU=;
        b=D8taFehTgHhb1pvulInUGidaR3rUw+5QucXBn3RbkkZrCXO/qEZeyWVpdBSs163ROm
         cVPjHaPRyRSYImx54OJmaTZ/U2l22ZxBxpmclyIs03uRXAruI5mf1pKvrEu35mxpDMZV
         NxhNhMh5PXGN1t1LLACAGIgP1fCNR+oJI8IUmKHIrqyKL6cW2ufcq0HzAkfLYN6PcpX5
         lRWitqIAKHuqeqmrmhoYAD4wyWV7V4NmryPBN1rQX3Pzc5nyV2iTw7UCqz0HfhxPwC78
         Eg11h+p8bP2nNkmjStWGy8cRf+LA7lXByGzq6nMbDYpZ6MV6xPKjFfoRfFEwwXUEC/dz
         SU9Q==
X-Gm-Message-State: AC+VfDyoswrppxNJ8XGhUyBAgqFZPV4UjbdQOWxYNDGevppDzyFwn2NE
        anKB/U92Z3p5B+5eWnfpAvppEuJxHq0yIFqR0ET7030TarMUph+PeLkeBpTD3NOjWvGmlQzOwV5
        6mjX/nz1J4lUtOuRlGekT4Fru
X-Received: by 2002:adf:fe48:0:b0:311:1b34:a7c9 with SMTP id m8-20020adffe48000000b003111b34a7c9mr782832wrs.12.1686902908107;
        Fri, 16 Jun 2023 01:08:28 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7poTm3R+mJyphj8XV8uoLBMWM2wgwZ2t8vqhpRIMaOFweUpkhxLxpRt8sELV1wUja3WEGZ+Q==
X-Received: by 2002:adf:fe48:0:b0:311:1b34:a7c9 with SMTP id m8-20020adffe48000000b003111b34a7c9mr782815wrs.12.1686902907698;
        Fri, 16 Jun 2023 01:08:27 -0700 (PDT)
Received: from ?IPV6:2003:cb:c707:9800:59ba:1006:9052:fb40? (p200300cbc707980059ba10069052fb40.dip0.t-ipconnect.de. [2003:cb:c707:9800:59ba:1006:9052:fb40])
        by smtp.gmail.com with ESMTPSA id a8-20020a5d5088000000b0030f9c3219aasm20732258wrt.47.2023.06.16.01.08.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jun 2023 01:08:27 -0700 (PDT)
Message-ID: <9a4b168b-fb27-b4e4-94e9-5a2c1390aa2a@redhat.com>
Date:   Fri, 16 Jun 2023 10:08:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 1/7] mm/hugetlb: Handle FOLL_DUMP well in
 follow_page_mask()
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
 <20230613215346.1022773-2-peterx@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230613215346.1022773-2-peterx@redhat.com>
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
> Firstly, the no_page_table() is meaningless for hugetlb which is a no-op
> there, because a hugetlb page always satisfies:
> 
>    - vma_is_anonymous() == false
>    - vma->vm_ops->fault != NULL
> 
> So we can already safely remove it in hugetlb_follow_page_mask(), alongside
> with the page* variable.
> 
> Meanwhile, what we do in follow_hugetlb_page() actually makes sense for a
> dump: we try to fault in the page only if the page cache is already
> allocated.  Let's do the same here for follow_page_mask() on hugetlb.
> 
> It should so far has zero effect on real dumps, because that still goes
> into follow_hugetlb_page().  But this may start to influence a bit on
> follow_page() users who mimics a "dump page" scenario, but hopefully in a
> good way.  This also paves way for unifying the hugetlb gup-slow.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   mm/gup.c     | 9 ++-------
>   mm/hugetlb.c | 9 +++++++++
>   2 files changed, 11 insertions(+), 7 deletions(-)
> 
> diff --git a/mm/gup.c b/mm/gup.c
> index dbe96d266670..aa0668505d61 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -781,7 +781,6 @@ static struct page *follow_page_mask(struct vm_area_struct *vma,
>   			      struct follow_page_context *ctx)
>   {
>   	pgd_t *pgd;
> -	struct page *page;
>   	struct mm_struct *mm = vma->vm_mm;
>   
>   	ctx->page_mask = 0;
> @@ -794,12 +793,8 @@ static struct page *follow_page_mask(struct vm_area_struct *vma,
>   	 * hugetlb_follow_page_mask is only for follow_page() handling here.
>   	 * Ordinary GUP uses follow_hugetlb_page for hugetlb processing.
>   	 */
> -	if (is_vm_hugetlb_page(vma)) {
> -		page = hugetlb_follow_page_mask(vma, address, flags);
> -		if (!page)
> -			page = no_page_table(vma, flags);
> -		return page;
> -	}
> +	if (is_vm_hugetlb_page(vma))
> +		return hugetlb_follow_page_mask(vma, address, flags);
>   
>   	pgd = pgd_offset(mm, address);
>   
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 270ec0ecd5a1..82dfdd96db4c 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -6501,6 +6501,15 @@ struct page *hugetlb_follow_page_mask(struct vm_area_struct *vma,
>   	spin_unlock(ptl);
>   out_unlock:
>   	hugetlb_vma_unlock_read(vma);
> +
> +	/*
> +	 * Fixup retval for dump requests: if pagecache doesn't exist,
> +	 * don't try to allocate a new page but just skip it.
> +	 */
> +	if (!page && (flags & FOLL_DUMP) &&
> +	    !hugetlbfs_pagecache_present(h, vma, address))
> +		page = ERR_PTR(-EFAULT);
> +
>   	return page;
>   }
>   

Makes sense to me:

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb

