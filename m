Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88CC46E68BE
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 17:57:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232455AbjDRP5C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 11:57:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232408AbjDRP5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 11:57:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBF7013864
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 08:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681833371;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OtKlP8rnOl2lq9t5ADiW6fLtYHBS76FbLQQee5fUbUg=;
        b=V1L10Kka4ItvVRo2sUCO++uKi3PWPmaT0iR7J+T/r1vYFoTkz5y4Y+WjwcG1R+xJSn6lwZ
        TsAlwmzQ+W7gef5dl8pgyHQQ4qt+MV1n6prsdm1P23MZJnAPGX5AuJb4IdzYPIxYi460cl
        9AMhXZwq6y2cHOByzgvGc/CVVS25dss=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-Pc2S9nQAOduJs38RvaXk-A-1; Tue, 18 Apr 2023 11:56:09 -0400
X-MC-Unique: Pc2S9nQAOduJs38RvaXk-A-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-3ef2cb3bfbfso6710721cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 08:56:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681833369; x=1684425369;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OtKlP8rnOl2lq9t5ADiW6fLtYHBS76FbLQQee5fUbUg=;
        b=dXafBBoizvFLTwACsG+tV1jAmjoiSCsmuaYVkVrn12VzJliqCx+V3RBSwKhMTXODyF
         Fr8KA/vh/wUWVn+WK9l6gteXbrXNsuxIgqn+6VjfO8AvUhqxmUXiL6HKOX7DZQr2m0rC
         5a8Hq/VyCw3e826lpz0+XgvA8xDEv2jHXSutccIbFojJZjJivvBpDD3EeL/wdXOGjP9C
         YuOOQOVHvcAAV01oARCxzUy+Gx3ZczSoLJGMvlqdItpBBWCAA2M3n8GBVgShu0bC/wfb
         eIP+dsYT9JRg1X1pGPn4jRupCj8tjHb2rpChiatCX60LxWTb1npfGJrBI+x49BZ6vIGv
         bqiQ==
X-Gm-Message-State: AAQBX9eNkuTgyfZdOJPwZfQdALKx9mwTlXI2XvXHI42f6ZPO9b9PfVPo
        t7Eu4tnC3kAbGTx5kebI+8Lco3peMUNmAZycgxHWMrLEr4Mc4Wh1S1leT3iCIigiii4VvYP9+L3
        djVqehqJ+OdZr31xFXT6H7QBJ
X-Received: by 2002:a05:622a:1981:b0:3e3:c889:ecf9 with SMTP id u1-20020a05622a198100b003e3c889ecf9mr22684367qtc.1.1681833369356;
        Tue, 18 Apr 2023 08:56:09 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZKZaVQG2Bgur25IfGn8Qc7YxIayAHbRDmpRwtEfLZCJaaykJcrlO20sXyLSzrcYlq+SqRSvQ==
X-Received: by 2002:a05:622a:1981:b0:3e3:c889:ecf9 with SMTP id u1-20020a05622a198100b003e3c889ecf9mr22684330qtc.1.1681833368995;
        Tue, 18 Apr 2023 08:56:08 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-40-70-52-229-124.dsl.bell.ca. [70.52.229.124])
        by smtp.gmail.com with ESMTPSA id a76-20020ae9e84f000000b0074df74a9f9fsm1310576qkg.39.2023.04.18.08.56.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 08:56:08 -0700 (PDT)
Date:   Tue, 18 Apr 2023 11:56:07 -0400
From:   Peter Xu <peterx@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        "Kirill A. Shutemov" <kirill@shutemov.name>
Subject: Re: [PATCH mm-unstable v1] mm: don't check VMA write permissions if
 the PTE/PMD indicates write permissions
Message-ID: <ZD69l0zD3UL9HD8g@x1n>
References: <20230418142113.439494-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230418142113.439494-1-david@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 18, 2023 at 04:21:13PM +0200, David Hildenbrand wrote:
> Staring at the comment "Recheck VMA as permissions can change since
> migration started" in remove_migration_pte() can result in confusion,
> because if the source PTE/PMD indicates write permissions, then there
> should be no need to check VMA write permissions when restoring migration
> entries or PTE-mapping a PMD.
> 
> Commit d3cb8bf6081b ("mm: migrate: Close race between migration completion
> and mprotect") introduced the maybe_mkwrite() handling in
> remove_migration_pte() in 2014, stating that a race between mprotect() and
> migration finishing would be possible, and that we could end up with
> a writable PTE that should be readable.
> 
> However, mprotect() code first updates vma->vm_flags / vma->vm_page_prot
> and then walks the page tables to (a) set all present writable PTEs to
> read-only and (b) convert all writable migration entries to readable
> migration entries. While walking the page tables and modifying the
> entries, migration code has to grab the PT locks to synchronize against
> concurrent page table modifications.

Makes sense to me.

> 
> Assuming migration would find a writable migration entry (while holding
> the PT lock) and replace it with a writable present PTE, surely mprotect()
> code didn't stumble over the writable migration entry yet (converting it
> into a readable migration entry) and would instead wait for the PT lock to
> convert the now present writable PTE into a read-only PTE. As mprotect()
> didn't finish yet, the behavior is just like migration didn't happen: a
> writable PTE will be converted to a read-only PTE.
> 
> So it's fine to rely on the writability information in the source
> PTE/PMD and not recheck against the VMA as long as we're holding the PT
> lock to synchronize with anyone who concurrently wants to downgrade write
> permissions (like mprotect()) by first adjusting vma->vm_flags /
> vma->vm_page_prot to then walk over the page tables to adjust the page
> table entries.
> 
> Running test cases that should reveal such races -- mprotect(PROT_READ)
> racing with page migration or THP splitting -- for multiple hours did
> not reveal an issue with this cleanup.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Mel Gorman <mgorman@techsingularity.net>
> Cc: Peter Xu <peterx@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
> 
> This is a follow-up cleanup to [1]:
> 	[PATCH v1 RESEND 0/6] mm: (pte|pmd)_mkdirty() should not
> 	unconditionally allow for write access
> 
> I wanted to be a bit careful and write some test cases to convince myself
> that I am not missing something important. Of course, there is still the
> possibility that my test cases are buggy ;)
> 
> Test cases I'm running:
> 	https://gitlab.com/davidhildenbrand/scratchspace/-/raw/main/test_mprotect_migration.c
> 	https://gitlab.com/davidhildenbrand/scratchspace/-/raw/main/test_mprotect_thp_split.c
> 
> 
> [1] https://lkml.kernel.org/r/20230411142512.438404-1-david@redhat.com
> 
> ---
>  mm/huge_memory.c | 4 ++--
>  mm/migrate.c     | 5 +----
>  2 files changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index c23fa39dec92..624671aaa60d 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -2234,7 +2234,7 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
>  		} else {
>  			entry = mk_pte(page + i, READ_ONCE(vma->vm_page_prot));
>  			if (write)
> -				entry = maybe_mkwrite(entry, vma);
> +				entry = pte_mkwrite(entry);

This is another change besides page migration.  I also don't know why it's
needed, but it's there since day 1 of thp split in eef1b3ba053, so maybe
worthwhile to copy Kirill too (which I did).

>  			if (anon_exclusive)
>  				SetPageAnonExclusive(page + i);
>  			if (!young)
> @@ -3271,7 +3271,7 @@ void remove_migration_pmd(struct page_vma_mapped_walk *pvmw, struct page *new)
>  	if (pmd_swp_soft_dirty(*pvmw->pmd))
>  		pmde = pmd_mksoft_dirty(pmde);
>  	if (is_writable_migration_entry(entry))
> -		pmde = maybe_pmd_mkwrite(pmde, vma);
> +		pmde = pmd_mkwrite(pmde);
>  	if (pmd_swp_uffd_wp(*pvmw->pmd))
>  		pmde = pmd_mkuffd_wp(pmde);
>  	if (!is_migration_entry_young(entry))
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 5d95e09b1618..02cace7955d4 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -213,16 +213,13 @@ static bool remove_migration_pte(struct folio *folio,
>  		if (pte_swp_soft_dirty(*pvmw.pte))
>  			pte = pte_mksoft_dirty(pte);
>  
> -		/*
> -		 * Recheck VMA as permissions can change since migration started
> -		 */
>  		entry = pte_to_swp_entry(*pvmw.pte);
>  		if (!is_migration_entry_young(entry))
>  			pte = pte_mkold(pte);
>  		if (folio_test_dirty(folio) && is_migration_entry_dirty(entry))
>  			pte = pte_mkdirty(pte);
>  		if (is_writable_migration_entry(entry))
> -			pte = maybe_mkwrite(pte, vma);
> +			pte = pte_mkwrite(pte);
>  		else if (pte_swp_uffd_wp(*pvmw.pte))
>  			pte = pte_mkuffd_wp(pte);
>  
> -- 
> 2.39.2
> 

-- 
Peter Xu

