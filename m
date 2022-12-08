Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3104D647750
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 21:30:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbiLHUaH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 15:30:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbiLHUaE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 15:30:04 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3F6385676
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 12:29:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670531341;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ii0FuSoZ7SGQWloslzn471nE8nER1iLtDMQwcznCIMw=;
        b=Utj4AvEuyDsUl8Ikw7VPFEh732GAT5la7Bym6kc4GPTKEqBGK++AqcD5kzrRj3h04VW+us
        g9JUKj0cuwP8YxcXsl8FPBwpYPgW2Lsg6Hmmq1pL3zgFTJOTDyzVTyNJdcf9NtLk+9D15m
        DW28T+44VXAhL1CiWWy02NNgOrvXBtU=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-79-dn7K86qRMyGm4u1ZEI0f9g-1; Thu, 08 Dec 2022 15:28:59 -0500
X-MC-Unique: dn7K86qRMyGm4u1ZEI0f9g-1
Received: by mail-qk1-f197.google.com with SMTP id bi42-20020a05620a31aa00b006faaa1664b9so2694552qkb.8
        for <linux-kernel@vger.kernel.org>; Thu, 08 Dec 2022 12:28:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ii0FuSoZ7SGQWloslzn471nE8nER1iLtDMQwcznCIMw=;
        b=w5cIXAbGDvE45c/VhHt5bJdpDK0fY2VMYcVe34iy366uaqk1ZSsHTaGzBM4I1LUsjB
         1CidDt8BcUbMh2FHTR65dUTeIwR8CSrCvnDTeSbPVf/7xiOnnfimsoU62MWuFoaE+eCo
         khQr3/A0lD3x4789nuYOQjou0p5tYXiPX/5M7Dm0xMX3NqFCBVuQs+SCbLpdbvuvaFTq
         AKgozhx1uRJR6ymlQTbt0+OpeSa79gRSdzze3OJXETarisVuqzftC0+E+k8OZPDTeSla
         ptfUyVqdpHsYbY2HEioa3wo5/JcB1t+LRP+I2wenUIWeku3zQYso6zyF+psXGtsJGcse
         u2Mg==
X-Gm-Message-State: ANoB5pnui08ndrHKD5A9pOutfgyWCa/SSvx2zn5eYAZRjxzS6NEa51jJ
        lC23Em/XSk4g8KFZLrOu2lK2us3mpmHCvMKsOaeCChcYFIEt/5tFu6BWaxie7eXxgWotSl/Xxs2
        6TKwKSDgRC/qEJe0iChXmbUSc
X-Received: by 2002:a05:622a:1002:b0:3a5:4e34:fafe with SMTP id d2-20020a05622a100200b003a54e34fafemr5952476qte.68.1670531339326;
        Thu, 08 Dec 2022 12:28:59 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6izTd8dvbGPkRyTdbCT91s9peP5zAGoaeKQ8hNdzhpRPFtyvhn6SWCASnYc4491qtuUqwlig==
X-Received: by 2002:a05:622a:1002:b0:3a5:4e34:fafe with SMTP id d2-20020a05622a100200b003a54e34fafemr5952455qte.68.1670531339036;
        Thu, 08 Dec 2022 12:28:59 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id k26-20020ac8475a000000b0039cb59f00fcsm10904928qtp.30.2022.12.08.12.28.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 12:28:58 -0800 (PST)
Date:   Thu, 8 Dec 2022 15:28:57 -0500
From:   Peter Xu <peterx@redhat.com>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        James Houghton <jthoughton@google.com>,
        Jann Horn <jannh@google.com>, Rik van Riel <riel@surriel.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        David Hildenbrand <david@redhat.com>,
        Nadav Amit <nadav.amit@gmail.com>
Subject: Re: [PATCH v2 04/10] mm/hugetlb: Move swap entry handling into vma
 lock when faulted
Message-ID: <Y5JJCZkUPyZdYjyn@x1n>
References: <20221207203034.650899-1-peterx@redhat.com>
 <20221207203034.650899-5-peterx@redhat.com>
 <326789a5-85ba-f13c-389e-fd21d673e3ae@nvidia.com>
 <Y5EW+RTuGuGhfdNk@x1n>
 <86bff55b-d048-1500-cddc-2d53702d7a3b@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <86bff55b-d048-1500-cddc-2d53702d7a3b@nvidia.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 07, 2022 at 03:05:42PM -0800, John Hubbard wrote:
> On 12/7/22 14:43, Peter Xu wrote:
> > Note that here migration_entry_wait_huge() will release it.
> > 
> > Sorry it's definitely not as straightforward, but this is also something I
> > didn't come up with a better solution, because we need the vma lock to
> > protect the spinlock, which is used in deep code path of the migration
> > code.
> > 
> > That's also why I added a rich comment above, and there's "The vma lock
> > will be released there" which is just for that.
> > 
> 
> Yes, OK,
> 
> Reviewed-by: John Hubbard <jhubbard@nvidia.com>
> 
> ...and here is some fancy documentation polishing (incremental on top of this
> specific patch) if you would like to fold it in, optional but it makes me
> happier:
> 
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 49f73677a418..e3bbd4869f68 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -5809,6 +5809,10 @@ u32 hugetlb_fault_mutex_hash(struct address_space *mapping, pgoff_t idx)
>  }
>  #endif
> +/*
> + * There are a few special cases in which this function returns while still
> + * holding locks. Those are noted inline.
> + */

This is not true, I think?  It always releases all the locks.

>  vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
>  			unsigned long address, unsigned int flags)
>  {
> @@ -5851,8 +5855,8 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
>  	/* PTE markers should be handled the same way as none pte */
>  	if (huge_pte_none_mostly(entry))
>  		/*
> -		 * hugetlb_no_page will drop vma lock and hugetlb fault
> -		 * mutex internally, which make us return immediately.
> +		 * hugetlb_no_page() will release both the vma lock and the
> +		 * hugetlb fault mutex, so just return directly from that:

I'm probably not gonna touch this part because it's not part of the patch..
For the rest, I can do.

I'll also apply the comment changes elsewhere if I don't speak up - in most
cases they all look good to me.

Thanks,

>  		 */
>  		return hugetlb_no_page(mm, vma, mapping, idx, address, ptep,
>  				      entry, flags);
> @@ -5869,10 +5873,11 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
>  	if (!pte_present(entry)) {
>  		if (unlikely(is_hugetlb_entry_migration(entry))) {
>  			/*
> -			 * Release fault lock first because the vma lock is
> -			 * needed to guard the huge_pte_lockptr() later in
> -			 * migration_entry_wait_huge().  The vma lock will
> -			 * be released there.
> +			 * Release the hugetlb fault lock now, but retain the
> +			 * vma lock, because it is needed to guard the
> +			 * huge_pte_lockptr() later in
> +			 * migration_entry_wait_huge(). The vma lock will be
> +			 * released there.
>  			 */
>  			mutex_unlock(&hugetlb_fault_mutex_table[hash]);
>  			migration_entry_wait_huge(vma, ptep);
> diff --git a/mm/migrate.c b/mm/migrate.c
> index d14f1f3ab073..a31df628b938 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -333,16 +333,18 @@ void migration_entry_wait(struct mm_struct *mm, pmd_t *pmd,
>  }
>  #ifdef CONFIG_HUGETLB_PAGE
> +
> +/*
> + * The vma read lock must be held upon entry. Holding that lock prevents either
> + * the pte or the ptl from being freed.
> + *
> + * This function will release the vma lock before returning.
> + */
>  void __migration_entry_wait_huge(struct vm_area_struct *vma,
>  				 pte_t *ptep, spinlock_t *ptl)
>  {
>  	pte_t pte;
> -	/*
> -	 * The vma read lock must be taken, which will be released before
> -	 * the function returns.  It makes sure the pgtable page (along
> -	 * with its spin lock) not be freed in parallel.
> -	 */
>  	hugetlb_vma_assert_locked(vma);
>  	spin_lock(ptl);
> 
> 
> thanks,
> -- 
> John Hubbard
> NVIDIA
> 

-- 
Peter Xu

