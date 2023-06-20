Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 418BD737064
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 17:24:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233234AbjFTPYS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 11:24:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232292AbjFTPYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 11:24:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EB3D18C
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 08:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687274608;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8L1z0Wqyx26HGhyycMO2j7Hbz2K4sdr/Xuz4e1iXzyM=;
        b=VXK0GU1EBZffMJhzgIFl3Iz/kof8UDsrSKwblCkhKYrF3LDxIWYjI9bdwfNCQG5PW1a2bO
        uHq+1IvrU3Kcfd/Ku/yXMTvN2VeNTcm16GfWv0q+3/mz9oc8c9/4rI5nNbvObxve8hofZn
        DAGAjRbEzLKGfuJtL9JkqKE7vzHrLh8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-211-a6pp7NxeNzK2rSjwuPncHg-1; Tue, 20 Jun 2023 11:23:20 -0400
X-MC-Unique: a6pp7NxeNzK2rSjwuPncHg-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3127d83b31cso410879f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 08:23:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687274591; x=1689866591;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8L1z0Wqyx26HGhyycMO2j7Hbz2K4sdr/Xuz4e1iXzyM=;
        b=ePeuO+twU+UXCqLsqbd3TbHGlm48iy9pUIdMex5NmZRYPk5vUOZNMZcsmwFHXpXQfY
         Si3sP3dCXfoNzUa8kYsIra4Q8pwNLUwEMXpL7VOa09ep7xsxnu25cQLws6duvVV/OLyn
         h72y9dDdm/1gP6ZVzA1msUsy5/us+cawDEC8YXfngTOBG7ATqksghSpxVqB2FTfWm51v
         uB5NHuIja115WZuzFRqzJqicc4vNh8T9yeFB1VG0n/M1ajee6iSgZuya7mHEMgfUCc+J
         seHhHZSvlNAy2fWKJjDZRA2YdykgpkedaP8n5oTzBeFJgwiX/W0kmIwuo6XXKMYCbM8e
         xAWA==
X-Gm-Message-State: AC+VfDxe0AP3XOheV9w/MTSbUpFC9fZrDTLta2CkWcKYBaaf94R71Szg
        mhWTW09kvHGjVFFU/13NLFA9VL0MBFLTe3pvoHkTMlFb+48Yh08wV9c9FKUFiuaYWGSpDbUPgiD
        +O3fwo6Pf6zWGdts5mkKaZr6j
X-Received: by 2002:a5d:43c2:0:b0:311:1cd8:b97a with SMTP id v2-20020a5d43c2000000b003111cd8b97amr8317353wrr.47.1687274591220;
        Tue, 20 Jun 2023 08:23:11 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4Ehs5Fiel37p+ImJ7RiGKTf2LxRLyh21P1eDQ/5tasNmWuOmkixCQq8AEkISpidQTelMdy5w==
X-Received: by 2002:a5d:43c2:0:b0:311:1cd8:b97a with SMTP id v2-20020a5d43c2000000b003111cd8b97amr8317335wrr.47.1687274590816;
        Tue, 20 Jun 2023 08:23:10 -0700 (PDT)
Received: from [192.168.3.108] (p4ff23bc9.dip0.t-ipconnect.de. [79.242.59.201])
        by smtp.gmail.com with ESMTPSA id o19-20020a05600c511300b003f8fe1933e4sm15580121wms.3.2023.06.20.08.23.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jun 2023 08:23:10 -0700 (PDT)
Message-ID: <d1f6c2c5-07d0-d430-49b3-68e9f5978534@redhat.com>
Date:   Tue, 20 Jun 2023 17:23:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 3/8] mm/hugetlb: Add page_mask for
 hugetlb_follow_page_mask()
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
 <20230619231044.112894-4-peterx@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230619231044.112894-4-peterx@redhat.com>
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
> follow_page() doesn't need it, but we'll start to need it when unifying gup
> for hugetlb.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   include/linux/hugetlb.h | 8 +++++---
>   mm/gup.c                | 3 ++-
>   mm/hugetlb.c            | 5 ++++-
>   3 files changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index beb7c63d2871..2e2d89e79d6c 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -131,7 +131,8 @@ int move_hugetlb_page_tables(struct vm_area_struct *vma,
>   int copy_hugetlb_page_range(struct mm_struct *, struct mm_struct *,
>   			    struct vm_area_struct *, struct vm_area_struct *);
>   struct page *hugetlb_follow_page_mask(struct vm_area_struct *vma,
> -				unsigned long address, unsigned int flags);
> +				      unsigned long address, unsigned int flags,
> +				      unsigned int *page_mask);
>   long follow_hugetlb_page(struct mm_struct *, struct vm_area_struct *,
>   			 struct page **, unsigned long *, unsigned long *,
>   			 long, unsigned int, int *);
> @@ -297,8 +298,9 @@ static inline void adjust_range_if_pmd_sharing_possible(
>   {
>   }
>   
> -static inline struct page *hugetlb_follow_page_mask(struct vm_area_struct *vma,
> -				unsigned long address, unsigned int flags)
> +static inline struct page *hugetlb_follow_page_mask(
> +    struct vm_area_struct *vma, unsigned long address, unsigned int flags,
> +    unsigned int *page_mask)
>   {
>   	BUILD_BUG(); /* should never be compiled in if !CONFIG_HUGETLB_PAGE*/
>   }
> diff --git a/mm/gup.c b/mm/gup.c
> index abcd841d94b7..9fc9271cba8d 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -780,7 +780,8 @@ static struct page *follow_page_mask(struct vm_area_struct *vma,
>   	 * Ordinary GUP uses follow_hugetlb_page for hugetlb processing.
>   	 */
>   	if (is_vm_hugetlb_page(vma))
> -		return hugetlb_follow_page_mask(vma, address, flags);
> +		return hugetlb_follow_page_mask(vma, address, flags,
> +						&ctx->page_mask);
>   
>   	pgd = pgd_offset(mm, address);
>   
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 9a6918c4250a..fbf6a09c0ec4 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -6454,7 +6454,8 @@ static inline bool __follow_hugetlb_must_fault(struct vm_area_struct *vma,
>   }
>   
>   struct page *hugetlb_follow_page_mask(struct vm_area_struct *vma,
> -				unsigned long address, unsigned int flags)
> +				      unsigned long address, unsigned int flags,
> +				      unsigned int *page_mask)
>   {
>   	struct hstate *h = hstate_vma(vma);
>   	struct mm_struct *mm = vma->vm_mm;
> @@ -6499,6 +6500,8 @@ struct page *hugetlb_follow_page_mask(struct vm_area_struct *vma,
>   			page = NULL;
>   			goto out;
>   		}
> +
> +		*page_mask = ~huge_page_mask(h) >> PAGE_SHIFT;

As discussed, can be simplified. But can be done on top (or not at all, 
but it is confusing code).

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb

