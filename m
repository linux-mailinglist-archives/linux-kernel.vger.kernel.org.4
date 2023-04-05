Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAE0F6D815D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 17:15:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238844AbjDEPPw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 11:15:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237845AbjDEPPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 11:15:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26DDB93CD
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 08:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680707569;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NbqrRYoH4MhiCPZmKOq0P0xBbJ8jHZBz12BO3KGobG4=;
        b=aQIBesq4tEa8otdLYqRu8oC8ZMD7YoJ9/6O1nADLbNGqVf92nLfglC3BeERk0x3s20LbRA
        3qLTxJ/gxGNp+IEK9BNTsXxUW2h2CBrC3q+Kcx/jcS2Ltahjlf49ZBpFXlTMxiFuDPEKJm
        gvz97ng6P5pg9WV4eKBoLa00wpNzs8A=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-640-g8Rdz92qPWeuluO2iF0CPg-1; Wed, 05 Apr 2023 11:12:48 -0400
X-MC-Unique: g8Rdz92qPWeuluO2iF0CPg-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7436374aadaso15677585a.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Apr 2023 08:12:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680707568; x=1683299568;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NbqrRYoH4MhiCPZmKOq0P0xBbJ8jHZBz12BO3KGobG4=;
        b=yPw5IcOI6SLwWVdnGaGnWSPVR4CYLrnhzUV+f53673ZDAkMB3dFCdK08AsyyioB+HG
         Ze8gXDPXxlRE6urEJOdHFSKL4JuDALqN51cJXGO9gnd+IWr0ahl0VD8Q6Ik8IVWoH2hy
         ItxzWvOkDN1TAFpqzkU9SGHWiw/HYUz8SQs5u3WNExpbHDo2+XDEk4FivtnZyOzmTPFI
         fgYDYJtC+frfC3UK+7Z250XYW2V3Q0jtP+glykGulY0/ON/DwFV0ZjHQRorzPI1OZw8c
         leA3Szp/qv4ocvZPExiUgKK0y3ZteICYfsJvhINF3V6M7bmPyfYcQuHHPh1e6QEDZ8An
         EzPA==
X-Gm-Message-State: AAQBX9eqt1GYPuohze83kK75zWQweyU/41rltEU4QbhYA14F0aW3tr7s
        Oy2935MusZxDVKLTaY7+3qKryz24nM4YLTMZZ8jPmAC4cZ27ndrLwNMgvx2IQkcNS8GJUQJ/6yA
        mUM+ml8HuQ9nCIqmu3GPKE1Kq
X-Received: by 2002:a05:6214:301b:b0:56e:f7dd:47ad with SMTP id ke27-20020a056214301b00b0056ef7dd47admr3957924qvb.5.1680707567607;
        Wed, 05 Apr 2023 08:12:47 -0700 (PDT)
X-Google-Smtp-Source: AKy350by4BvvddzPNID9g4CfXiEnFFWgAOu98t+35+GTR4I/ubHIFckRRQCBVh0oqa/OjDU9n4zG4Q==
X-Received: by 2002:a05:6214:301b:b0:56e:f7dd:47ad with SMTP id ke27-20020a056214301b00b0056ef7dd47admr3957888qvb.5.1680707567230;
        Wed, 05 Apr 2023 08:12:47 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-40-70-52-229-124.dsl.bell.ca. [70.52.229.124])
        by smtp.gmail.com with ESMTPSA id d4-20020a0cf6c4000000b005dd8b9345d5sm4200768qvo.109.2023.04.05.08.12.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 08:12:46 -0700 (PDT)
Date:   Wed, 5 Apr 2023 11:12:45 -0400
From:   Peter Xu <peterx@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>,
        stable@vger.kernel.org
Subject: Re: [PATCH v1 1/2] mm/userfaultfd: fix uffd-wp handling for THP
 migration entries
Message-ID: <ZC2P7Z7S87myvSst@x1n>
References: <20230405142535.493854-1-david@redhat.com>
 <20230405142535.493854-2-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230405142535.493854-2-david@redhat.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 05, 2023 at 04:25:34PM +0200, David Hildenbrand wrote:
> Looks like what we fixed for hugetlb in commit 44f86392bdd1 ("mm/hugetlb:
> fix uffd-wp handling for migration entries in hugetlb_change_protection()")
> similarly applies to THP.
> 
> Setting/clearing uffd-wp on THP migration entries is not implemented
> properly. Further, while removing migration PMDs considers the uffd-wp
> bit, inserting migration PMDs does not consider the uffd-wp bit.
> 
> We have to set/clear independently of the migration entry type in
> change_huge_pmd() and properly copy the uffd-wp bit in
> set_pmd_migration_entry().
> 
> Verified using a simple reproducer that triggers migration of a THP, that
> the set_pmd_migration_entry() no longer loses the uffd-wp bit.
> 
> Fixes: f45ec5ff16a7 ("userfaultfd: wp: support swap and page migration")
> Cc: stable@vger.kernel.org
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

Thanks, one trivial nitpick:

> ---
>  mm/huge_memory.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 032fb0ef9cd1..bdda4f426d58 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -1838,10 +1838,10 @@ int change_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
>  	if (is_swap_pmd(*pmd)) {
>  		swp_entry_t entry = pmd_to_swp_entry(*pmd);
>  		struct page *page = pfn_swap_entry_to_page(entry);
> +		pmd_t newpmd;
>  
>  		VM_BUG_ON(!is_pmd_migration_entry(*pmd));
>  		if (is_writable_migration_entry(entry)) {
> -			pmd_t newpmd;
>  			/*
>  			 * A protection check is difficult so
>  			 * just be safe and disable write
> @@ -1855,8 +1855,16 @@ int change_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
>  				newpmd = pmd_swp_mksoft_dirty(newpmd);
>  			if (pmd_swp_uffd_wp(*pmd))
>  				newpmd = pmd_swp_mkuffd_wp(newpmd);
> -			set_pmd_at(mm, addr, pmd, newpmd);
> +		} else {
> +			newpmd = *pmd;
>  		}
> +
> +		if (uffd_wp)
> +			newpmd = pmd_swp_mkuffd_wp(newpmd);
> +		else if (uffd_wp_resolve)
> +			newpmd = pmd_swp_clear_uffd_wp(newpmd);
> +		if (!pmd_same(*pmd, newpmd))
> +			set_pmd_at(mm, addr, pmd, newpmd);
>  		goto unlock;
>  	}
>  #endif
> @@ -3251,6 +3259,8 @@ int set_pmd_migration_entry(struct page_vma_mapped_walk *pvmw,
>  	pmdswp = swp_entry_to_pmd(entry);
>  	if (pmd_soft_dirty(pmdval))
>  		pmdswp = pmd_swp_mksoft_dirty(pmdswp);
> +	if (pmd_swp_uffd_wp(*pvmw->pmd))
> +		pmdswp = pmd_swp_mkuffd_wp(pmdswp);

I think it's fine to use *pmd, but maybe still better to use pmdval?  I
worry pmdp_invalidate()) can be something else in the future that may
affect the bit.

>  	set_pmd_at(mm, address, pvmw->pmd, pmdswp);
>  	page_remove_rmap(page, vma, true);
>  	put_page(page);
> -- 
> 2.39.2
> 

-- 
Peter Xu

