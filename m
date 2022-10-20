Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 265CB605A5F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 10:59:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbiJTI7X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 04:59:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230173AbiJTI7N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 04:59:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33B82194221
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 01:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666256351;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VDOSs9w5teSY0v64EoGV9ODDZzj4sY8LViTNwvI0Fl4=;
        b=NW22ExdoqqmA3lvQwVbRAiLSE9ZGxawDDcZS+EaYOc8y2dgKg5Vw44pX2/6MAdscXTloxB
        1CgzY9i5nlEtcLHEU8fzDAMBSbabv0ww9Oi19ogD88DALXZzTdott3fcreRYI25u1B6Ui5
        En+UAiPuMV41c+AEguwTFJqTxCbkHYk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-16-4dM0fvDgNfy12MuX8Z6TKA-1; Thu, 20 Oct 2022 04:59:09 -0400
X-MC-Unique: 4dM0fvDgNfy12MuX8Z6TKA-1
Received: by mail-wm1-f70.google.com with SMTP id t20-20020a7bc3d4000000b003c6bfea856aso770212wmj.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 01:59:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VDOSs9w5teSY0v64EoGV9ODDZzj4sY8LViTNwvI0Fl4=;
        b=4o/VNMLn3ckmLazzwtOT6BoHuj2898kIauakkvrf1HQ4qpSI2xqk1NOmYhPJVKXg9m
         B7KNJ2Iy4RxRfqT8GWm8NPziIvf2bH4XbWU2YYdd7/D9FRAI/EAJGBH208xnUs8Rusdv
         WxOzW2U9MyDVkZugxaz3sNOHt8Tpp30A8G4n378x1BrldKc2d1KYxBRY782OPb0Lxeru
         Dq7ct+dRi5pAZv4jydRYcX4xfmLTa5/2TYt7iVDPXpfpHEV8EUDztCUfvXrKVvm/un0p
         qWyMwqGU3MdJPTif1GAhF0mVxwQwXt2PhyikmXGHXJydFPwU28DVT/IBPX9wYZvfwuDz
         NHQA==
X-Gm-Message-State: ACrzQf1iVBv/qfCLOnUsDLnwKLEYYQQm+u1a7Ci4L6UuHDUiYnwaj8JS
        wrkcsfzIR8U3BFhtTNU5ZyYYT7Clgp6tlpDf5AwQq9kb3c5oeRlyc5/UTGn5PPIKJsuKvLZXtcf
        NVpJo9ULrzU9U25Kq+Xjj8XYVIYK0NixwTWLuKGBNAOYvV6QCIAfNHsO1BD/XKvPWwMA8t8sv
X-Received: by 2002:adf:e109:0:b0:225:4ca5:80d5 with SMTP id t9-20020adfe109000000b002254ca580d5mr7689865wrz.465.1666256348046;
        Thu, 20 Oct 2022 01:59:08 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM63uXuoBvlTjpQoi4bGhWEu0SeX2qIwjG13vznZ+D0K6xJzclcC/En1SF+lZRoN0ncGrVs7zA==
X-Received: by 2002:adf:e109:0:b0:225:4ca5:80d5 with SMTP id t9-20020adfe109000000b002254ca580d5mr7689829wrz.465.1666256347642;
        Thu, 20 Oct 2022 01:59:07 -0700 (PDT)
Received: from ?IPV6:2003:cb:c708:b100:1443:78d5:341f:c97a? (p200300cbc708b100144378d5341fc97a.dip0.t-ipconnect.de. [2003:cb:c708:b100:1443:78d5:341f:c97a])
        by smtp.gmail.com with ESMTPSA id b21-20020a05600c4e1500b003b476cabf1csm1411944wmq.26.2022.10.20.01.59.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Oct 2022 01:59:07 -0700 (PDT)
Message-ID: <8c86678a-3bfb-3854-b1a9-ae5969e730b8@redhat.com>
Date:   Thu, 20 Oct 2022 10:59:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH v1 6/7] mm/ksm: convert break_ksm() to use
 walk_page_range_vma()
Content-Language: en-US
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, Hugh Dickins <hughd@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, Peter Xu <peterx@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Janosch Frank <frankja@linux.ibm.com>
References: <20220930141931.174362-1-david@redhat.com>
 <20220930141931.174362-7-david@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220930141931.174362-7-david@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30.09.22 16:19, David Hildenbrand wrote:
> FOLL_MIGRATION exists only for the purpose of break_ksm(), and
> actually, there is not even the need to wait for the migration to
> finish, we only want to know if we're dealing with a KSM page.
> 
> Using follow_page() just to identify a KSM page overcomplicates GUP
> code. Let's use walk_page_range_vma() instead, because we don't actually
> care about the page itself, we only need to know a single property --
> no need to even grab a reference on the page.
> 
> In my setup (AMD Ryzen 9 3900X), running the KSM selftest to test unmerge
> performance on 2 GiB (taskset 0x8 ./ksm_tests -D -s 2048), this results in
> a performance degradation of ~4% (old: ~5010 MiB/s, new: ~4800 MiB/s).
> I don't think we particularly care for now.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>   mm/ksm.c | 70 +++++++++++++++++++++++++++++++++++++++++++++++++-------
>   1 file changed, 62 insertions(+), 8 deletions(-)
> 
> diff --git a/mm/ksm.c b/mm/ksm.c
> index 4d7bcf7da7c3..814c1a37c323 100644
> --- a/mm/ksm.c
> +++ b/mm/ksm.c
> @@ -39,6 +39,7 @@
>   #include <linux/freezer.h>
>   #include <linux/oom.h>
>   #include <linux/numa.h>
> +#include <linux/pagewalk.h>
>   
>   #include <asm/tlbflush.h>
>   #include "internal.h"
> @@ -452,6 +453,60 @@ static inline bool ksm_test_exit(struct mm_struct *mm)
>   	return atomic_read(&mm->mm_users) == 0;
>   }
>   
> +int break_ksm_pud_entry(pud_t *pud, unsigned long addr, unsigned long next,
> +			struct mm_walk *walk)
> +{
> +	/* We only care about page tables to walk to a single base page. */
> +	if (pud_leaf(*pud) || !pud_present(*pud))
> +		return 1;
> +	return 0;
> +}
> +
> +int break_ksm_pmd_entry(pmd_t *pmd, unsigned long addr, unsigned long next,
> +			struct mm_walk *walk)
> +{
> +	bool *ksm_page = walk->private;
> +	struct page *page = NULL;
> +	pte_t *pte, ptent;
> +	spinlock_t *ptl;
> +
> +	/* We only care about page tables to walk to a single base page. */
> +	if (pmd_leaf(*pmd) || !pmd_present(*pmd))
> +		return 1;
> +
> +	/*
> +	 * We only lookup a single page (a) no need to iterate; and (b)
> +	 * always return 1 to exit immediately and not iterate in the caller.
> +	 */
> +	pte = pte_offset_map_lock(walk->mm, pmd, addr, &ptl);
> +	ptent = *pte;
> +
> +	if (pte_none(ptent))
> +		return 1;

As reported by Janosch, we fail to drop the lock here.


t480s: ~/git/linux ksm_unshare $ git diff
diff --git a/mm/ksm.c b/mm/ksm.c
index 26aec41b127c..94f8e114c89f 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -435,7 +435,7 @@ int break_ksm_pmd_entry(pmd_t *pmd, unsigned long addr, unsigned long next,
         pte = pte_offset_map_lock(walk->mm, pmd, addr, &ptl);
  
         if (pte_none(*pte))
-               return 1;
+               goto out_unlock;
         if (!pte_present(*pte)) {
                 swp_entry_t entry = pte_to_swp_entry(*pte);
  
@@ -451,6 +451,7 @@ int break_ksm_pmd_entry(pmd_t *pmd, unsigned long addr, unsigned long next,
         }
         if (page && PageKsm(page))
                 *ksm_page = true;
+out_unlock:
         pte_unmap_unlock(pte, ptl);
         return 1;
  }



-- 
Thanks,

David / dhildenb

