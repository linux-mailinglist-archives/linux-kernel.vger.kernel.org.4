Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 505186E1F6C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 11:38:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbjDNJic (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 05:38:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjDNJib (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 05:38:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25C4455B4
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 02:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681465066;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=y7jfa/TTSXXNR+HI17/4WsjHOhACytVYBySIdLruFJk=;
        b=ZYfalgO06aNXC4RxxcE8NT3ok1VlOPJZ1IwMGD4qQzkvhrPA8g1aQKJzGvjFY6CpFt7sAD
        OWvWJt0HthgG7+WQj8GYMut40r594EauB/AgiDfJgzbUUpvxRefqDtI9ZE+mxGZ7IGWYTo
        /8F+eyuiiY7PHoMfrec412uewtpY1NM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-61-bFsmUDkjOgGQIB_w00p1QQ-1; Fri, 14 Apr 2023 05:37:43 -0400
X-MC-Unique: bFsmUDkjOgGQIB_w00p1QQ-1
Received: by mail-wr1-f72.google.com with SMTP id u21-20020adfa195000000b002f6b0ce6655so614416wru.9
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 02:37:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681465063; x=1684057063;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y7jfa/TTSXXNR+HI17/4WsjHOhACytVYBySIdLruFJk=;
        b=Utslum9yWjOzzvpvxjB2LOMCuK7FqJfCZfnu7q150dJL1NuYJvgLOcsQuqQ/ZnqBqL
         i2F9SAzf7zVhit0gZ+MkQu1HZzmM7FEaGPWS6iwQw4Rh/R8g9E8rdrtTitGvbK++cTDU
         iDFpweke6JSeaGKua2OQ8Wfs1gyZz/1Xg9LdAW/1LnAC6/prlZ+vD0SRMlXldNGrVHPU
         ZAGFXYDpLouBqjYIzddTHkx4FLTnhbaIpkL0iFLENGew6L8dSpjPcnV8x0xgEE/AZAd2
         eKlpLuS3iMFd70Ukw8c84v9Vjhn52yQB4zPD3unn+e3xj4iknJtcow+YAB7bJGrjTIgI
         LM8g==
X-Gm-Message-State: AAQBX9cs1nUI8hPjVqCo+83FbAK9WgW3z6ua/NREPVQYd8kmPiK7Q/e5
        9KTG8dNZnJVcZyt2NaTxNDiIq/NIwm2IXT7zRHUCEBBTv3oNnWPeKfxJncdpqvDBsL3Kmh8FWpy
        U1567g9R8pV+MfpEznHvdKbb6
X-Received: by 2002:a5d:5350:0:b0:2e4:abb1:3e8b with SMTP id t16-20020a5d5350000000b002e4abb13e8bmr3748502wrv.25.1681465062787;
        Fri, 14 Apr 2023 02:37:42 -0700 (PDT)
X-Google-Smtp-Source: AKy350Z1swKpxAiu43bOkrN04CBR2jPIDXEy0bemkCbdTlJVl7ANlzOYK7CrGeUhL+007cOsBJ0tSg==
X-Received: by 2002:a5d:5350:0:b0:2e4:abb1:3e8b with SMTP id t16-20020a5d5350000000b002e4abb13e8bmr3748486wrv.25.1681465062444;
        Fri, 14 Apr 2023 02:37:42 -0700 (PDT)
Received: from ?IPV6:2003:cb:c702:5700:cb5b:f73a:c650:1d9? (p200300cbc7025700cb5bf73ac65001d9.dip0.t-ipconnect.de. [2003:cb:c702:5700:cb5b:f73a:c650:1d9])
        by smtp.gmail.com with ESMTPSA id v10-20020a05600c470a00b003ef36ef3833sm7684982wmo.8.2023.04.14.02.37.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Apr 2023 02:37:42 -0700 (PDT)
Message-ID: <17c46475-5889-1f60-39be-6208d70c90a0@redhat.com>
Date:   Fri, 14 Apr 2023 11:37:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Cc:     Axel Rasmussen <axelrasmussen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        linux-stable <stable@vger.kernel.org>
References: <20230413231120.544685-1-peterx@redhat.com>
 <20230413231120.544685-2-peterx@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH 1/6] mm/hugetlb: Fix uffd-wp during fork()
In-Reply-To: <20230413231120.544685-2-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.04.23 01:11, Peter Xu wrote:
> There're a bunch of things that were wrong:
> 
>    - Reading uffd-wp bit from a swap entry should use pte_swp_uffd_wp()
>      rather than huge_pte_uffd_wp().
> 
>    - When copying over a pte, we should drop uffd-wp bit when
>      !EVENT_FORK (aka, when !userfaultfd_wp(dst_vma)).
> 
>    - When doing early CoW for private hugetlb (e.g. when the parent page was
>      pinned), uffd-wp bit should be properly carried over if necessary.
> 
> No bug reported probably because most people do not even care about these
> corner cases, but they are still bugs and can be exposed by the recent unit
> tests introduced, so fix all of them in one shot.
> 
> Cc: linux-stable <stable@vger.kernel.org>
> Fixes: bc70fbf269fd ("mm/hugetlb: handle uffd-wp during fork()")
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   mm/hugetlb.c | 26 ++++++++++++++++----------
>   1 file changed, 16 insertions(+), 10 deletions(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index f16b25b1a6b9..7320e64aacc6 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -4953,11 +4953,15 @@ static bool is_hugetlb_entry_hwpoisoned(pte_t pte)
>   
>   static void
>   hugetlb_install_folio(struct vm_area_struct *vma, pte_t *ptep, unsigned long addr,
> -		     struct folio *new_folio)
> +		      struct folio *new_folio, pte_t old)
>   {

Nit: The function now expects old to be !swap_pte. Which works perfectly 
fine with existing code -- the function name is a bit generic and 
misleading, unfortunately. IMHO, instead of factoring that functionality 
out to desperately try keeping copy_hugetlb_page_range() somewhat 
readable, we should just have factored out the complete copy+replace 
into a copy_hugetlb_page() function -- similar to the ordinary page 
handling -- which would have made copy_hugetlb_page_range() more 
readable eventually.

Anyhow, unrelated.

> +	pte_t newpte = make_huge_pte(vma, &new_folio->page, 1);
> +
>   	__folio_mark_uptodate(new_folio);
>   	hugepage_add_new_anon_rmap(new_folio, vma, addr);
> -	set_huge_pte_at(vma->vm_mm, addr, ptep, make_huge_pte(vma, &new_folio->page, 1));
> +	if (userfaultfd_wp(vma) && huge_pte_uffd_wp(old))
> +		newpte = huge_pte_mkuffd_wp(newpte);
> +	set_huge_pte_at(vma->vm_mm, addr, ptep, newpte);
>   	hugetlb_count_add(pages_per_huge_page(hstate_vma(vma)), vma->vm_mm);
>   	folio_set_hugetlb_migratable(new_folio);
>   }
> @@ -5032,14 +5036,11 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
>   			 */
>   			;
>   		} else if (unlikely(is_hugetlb_entry_hwpoisoned(entry))) {
> -			bool uffd_wp = huge_pte_uffd_wp(entry);
> -
> -			if (!userfaultfd_wp(dst_vma) && uffd_wp)
> +			if (!userfaultfd_wp(dst_vma))
>   				entry = huge_pte_clear_uffd_wp(entry);
>   			set_huge_pte_at(dst, addr, dst_pte, entry);
>   		} else if (unlikely(is_hugetlb_entry_migration(entry))) {
>   			swp_entry_t swp_entry = pte_to_swp_entry(entry);
> -			bool uffd_wp = huge_pte_uffd_wp(entry);
>   
>   			if (!is_readable_migration_entry(swp_entry) && cow) {
>   				/*
> @@ -5049,11 +5050,12 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
>   				swp_entry = make_readable_migration_entry(
>   							swp_offset(swp_entry));
>   				entry = swp_entry_to_pte(swp_entry);
> -				if (userfaultfd_wp(src_vma) && uffd_wp)
> -					entry = huge_pte_mkuffd_wp(entry);
> +				if (userfaultfd_wp(src_vma) &&
> +				    pte_swp_uffd_wp(entry))
> +					entry = pte_swp_mkuffd_wp(entry);
>   				set_huge_pte_at(src, addr, src_pte, entry);
>   			}
> -			if (!userfaultfd_wp(dst_vma) && uffd_wp)
> +			if (!userfaultfd_wp(dst_vma))
>   				entry = huge_pte_clear_uffd_wp(entry);
>   			set_huge_pte_at(dst, addr, dst_pte, entry);
>   		} else if (unlikely(is_pte_marker(entry))) {
> @@ -5114,7 +5116,8 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
>   					/* huge_ptep of dst_pte won't change as in child */
>   					goto again;
>   				}
> -				hugetlb_install_folio(dst_vma, dst_pte, addr, new_folio);
> +				hugetlb_install_folio(dst_vma, dst_pte, addr,
> +						      new_folio, src_pte_old);
>   				spin_unlock(src_ptl);
>   				spin_unlock(dst_ptl);
>   				continue;
> @@ -5132,6 +5135,9 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
>   				entry = huge_pte_wrprotect(entry);
>   			}
>   
> +			if (!userfaultfd_wp(dst_vma))
> +				entry = huge_pte_clear_uffd_wp(entry);
> +
>   			set_huge_pte_at(dst, addr, dst_pte, entry);
>   			hugetlb_count_add(npages, dst);
>   		}

LGTM

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

