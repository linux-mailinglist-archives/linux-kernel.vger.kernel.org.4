Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A82D0732994
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 10:12:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244838AbjFPIML (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 04:12:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234405AbjFPIMI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 04:12:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCC152117
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 01:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686903076;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RnRIpHUiQnx1uu1gHAafQJv/IJPeE0K8K8Nwv8UCEzs=;
        b=K9wp1vjKCfuir516VHny5R/njrlyB0rpkR4vfYeKY0ToMHhglBNH9jMd4//AxAwrPrV83g
        mH8k+4akRT1QdfZZJ2kFW1XXZLUJYRsqWXz5zU/HIXdu21snXaNiUGRJ0486hhigcYr14S
        kMUXHxPzldyFUIlpNqutqxka+QOq1Ic=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-264-H_JXpUF4P9SPiEq6jybwaw-1; Fri, 16 Jun 2023 04:11:15 -0400
X-MC-Unique: H_JXpUF4P9SPiEq6jybwaw-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2b1d8fa43eeso3150181fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 01:11:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686903074; x=1689495074;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RnRIpHUiQnx1uu1gHAafQJv/IJPeE0K8K8Nwv8UCEzs=;
        b=CR8PoV6U+eL9gU0O6v4WgJyMQHNTIXprx5eCTYwG3By68OpxCLdXP/VvPFmffYHvfe
         bEDNHk8Yl3ZeiaL/Tf0fred/UP9YUPN38Dvpqx8RYUOSUBJsefcD9nTQUtQWhcPPLII/
         8bAhHvuu1E1sX3tqQjEmi5v3U1omjpwJ8YzIM27kjFHIr1MUmOfAgyZH3TolNdKA08xd
         uPlnizNUtkbsvGK86QVro/ujvfGE6ZkSmgFT7vFRqldDuO2ayaThzbuFpM8YRtG0dhkj
         61UkuFgxbX4AQ8XX2Bz1cjF+S+xrHkwOAeJUJCLb3c5aU2mhdy9Oe5TQ5xZ9Z4traice
         Vq7Q==
X-Gm-Message-State: AC+VfDyDRkI0u9GoGvOXShum8ZnUtRelNtAbyrsU2WErxHLk2ADtddIH
        Vh2+UNZ2sxFq0ROJPnK1DI00rOAe81PVyxXGQM2d4j2/vy0wtTgk0DCf0jcamPGLUXqh4EBT/x4
        qpHSeBS/Q25yoHcQJwAEeIiM1
X-Received: by 2002:a2e:a40d:0:b0:2b4:4307:48 with SMTP id p13-20020a2ea40d000000b002b443070048mr1155651ljn.38.1686903073919;
        Fri, 16 Jun 2023 01:11:13 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5FR8sSbqpeYzFBBHzIzpMvulL3PDwTlEmsGsghMkPnCnLywc6RZqX9/TuByGPFXysX2g37LA==
X-Received: by 2002:a2e:a40d:0:b0:2b4:4307:48 with SMTP id p13-20020a2ea40d000000b002b443070048mr1155631ljn.38.1686903073555;
        Fri, 16 Jun 2023 01:11:13 -0700 (PDT)
Received: from ?IPV6:2003:cb:c707:9800:59ba:1006:9052:fb40? (p200300cbc707980059ba10069052fb40.dip0.t-ipconnect.de. [2003:cb:c707:9800:59ba:1006:9052:fb40])
        by smtp.gmail.com with ESMTPSA id i10-20020a05600c354a00b003f4283f5c1bsm15463194wmq.2.2023.06.16.01.11.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jun 2023 01:11:12 -0700 (PDT)
Message-ID: <561f3796-e308-82c2-ae1f-f7ef94fe0691@redhat.com>
Date:   Fri, 16 Jun 2023 10:11:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 3/7] mm/hugetlb: Add page_mask for
 hugetlb_follow_page_mask()
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
 <20230613215346.1022773-4-peterx@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230613215346.1022773-4-peterx@redhat.com>
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

On 13.06.23 23:53, Peter Xu wrote:
> follow_page() doesn't need it, but we'll start to need it when unifying gup
> for hugetlb.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   include/linux/hugetlb.h | 8 +++++---
>   mm/gup.c                | 3 ++-
>   mm/hugetlb.c            | 4 +++-
>   3 files changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index 21f942025fec..0d6f389d98de 100644
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
> index aa0668505d61..8d59ae4554e7 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -794,7 +794,8 @@ static struct page *follow_page_mask(struct vm_area_struct *vma,
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
> index 9c261921b2cf..f037eaf9d819 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -6457,7 +6457,8 @@ static inline bool __follow_hugetlb_must_fault(struct vm_area_struct *vma,
>   }
>   
>   struct page *hugetlb_follow_page_mask(struct vm_area_struct *vma,
> -				unsigned long address, unsigned int flags)
> +				      unsigned long address, unsigned int flags,
> +				      unsigned int *page_mask)
>   {
>   	struct hstate *h = hstate_vma(vma);
>   	struct mm_struct *mm = vma->vm_mm;
> @@ -6506,6 +6507,7 @@ struct page *hugetlb_follow_page_mask(struct vm_area_struct *vma,
>   		 * because we hold the ptl lock and have verified pte_present().
>   		 */
>   		WARN_ON_ONCE(try_grab_page(page, flags));
> +		*page_mask = huge_page_mask(h);
>   	}
>   out:
>   	spin_unlock(ptl);

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb

