Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACF2D5F42D8
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 14:19:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbiJDMTr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 08:19:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbiJDMTn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 08:19:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC76D6144
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 05:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664885981;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CGLX/ljMcH9ugjySzTmYidS+NlMSbNJzq8WccMn70Z8=;
        b=RH8cDeIEseZIVeY8gDPQL/hq2wn62y64aQ5sTQoIqQ/vi0ZNeMuejauRmfWS3ga+YzPt34
        c4BQHvo6k5dmE8FOMQELwPPF4UAh+FLxaeAkxOETCuzN6qq6g655b4Wl5OGTuWbHu33AcJ
        cfJha3Q3R51UmoVzFSbOr4NcKImEW5o=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-451-5AGE9YPeP8-PEZipJU5oDA-1; Tue, 04 Oct 2022 08:19:39 -0400
X-MC-Unique: 5AGE9YPeP8-PEZipJU5oDA-1
Received: by mail-wr1-f72.google.com with SMTP id n8-20020adf8b08000000b0022e4d3dc8d2so661757wra.7
        for <linux-kernel@vger.kernel.org>; Tue, 04 Oct 2022 05:19:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=CGLX/ljMcH9ugjySzTmYidS+NlMSbNJzq8WccMn70Z8=;
        b=kdrurMgloE/LGr7Be572Qo5l5bJTkGNMm5zcB2RwA7M0XjSVK1ap5SZNsvRTnDbZPY
         3k4CNcvG5gMkqeSHh8I0oBkBrUMdBbdO45hidpO2550/N4KrNeEV7EB46YJQn5/WJYN9
         4y99ai2dTFehrKtOMdz4UXDKBLBJO0QaHH1lKXrrEvDNK7Le9oSpYD8CqsU7BH//IuA8
         hXEvp9cQVMbn5eAgnuO1I7TNT86Xd0BodFbkGn2haUePHs5r5PN28Fu/Az17EQEhw6uy
         c2cjBdrpvatxALmDfnZX9BODs917pJf5U8oJRLHJeQwoLgl4qMomilKtJfRhzcbb2gww
         letQ==
X-Gm-Message-State: ACrzQf0JyC3R1Y1tEbzyrvFay/66WPux48yoaQZ2lc3lILzvTJ8a0vmf
        EsxDcfi+3Bg8eQ8doASkTWMzQEquMhLMfwOR7jRrCxCDfPRdClJyM97zj4XGH+8/dxCmeJJIV45
        tW1qIH7pZ3bzY+oEe+1pdNewe
X-Received: by 2002:adf:db0d:0:b0:22a:eeed:5145 with SMTP id s13-20020adfdb0d000000b0022aeeed5145mr16093043wri.590.1664885978629;
        Tue, 04 Oct 2022 05:19:38 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM50kctHe5RVsmDHaLGVaOyZ1F/I7XlFLf51A/N/qAKqGSHorWVQRXtqrUqNcrh7JdYaYygADA==
X-Received: by 2002:adf:db0d:0:b0:22a:eeed:5145 with SMTP id s13-20020adfdb0d000000b0022aeeed5145mr16093017wri.590.1664885978307;
        Tue, 04 Oct 2022 05:19:38 -0700 (PDT)
Received: from ?IPV6:2003:cb:c706:5000:4fff:1dd6:7868:a36? (p200300cbc70650004fff1dd678680a36.dip0.t-ipconnect.de. [2003:cb:c706:5000:4fff:1dd6:7868:a36])
        by smtp.gmail.com with ESMTPSA id bv14-20020a0560001f0e00b0022ae8b862a7sm12583632wrb.35.2022.10.04.05.19.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Oct 2022 05:19:37 -0700 (PDT)
Message-ID: <41fb1d6c-0d36-e88c-39fe-ea1e9d80a1fc@redhat.com>
Date:   Tue, 4 Oct 2022 14:19:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v2 1/3] mm/hugetlb: Fix race condition of uffd
 missing/minor handling
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Nadav Amit <nadav.amit@gmail.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
References: <20221004003705.497782-1-peterx@redhat.com>
 <20221004003705.497782-2-peterx@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20221004003705.497782-2-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04.10.22 02:37, Peter Xu wrote:
> After the recent rework patchset of hugetlb locking on pmd sharing,
> kselftest for userfaultfd sometimes fails on hugetlb private tests with
> unexpected write fault checks.
> 
> It turns out there's nothing wrong within the locking series regarding this
> matter, but it could have changed the timing of threads so it can trigger
> an old bug.
> 
> The real bug is when we call hugetlb_no_page() we're not with the pgtable
> lock.  It means we're reading the pte values lockless.  It's perfectly fine
> in most cases because before we do normal page allocations we'll take the
> lock and check pte_same() again.  However before that, there are actually
> two paths on userfaultfd missing/minor handling that may directly move on
> with the fault process without checking the pte values.
> 
> It means for these two paths we may be generating an uffd message based on
> an unstable pte, while an unstable pte can legally be anything as long as
> the modifier holds the pgtable lock.
> 
> One example, which is also what happened in the failing kselftest and
> caused the test failure, is that for private mappings wr-protection changes
> can happen on one page.  While hugetlb_change_protection() generally
> requires pte being cleared before being changed, then there can be a race
> condition like:
> 
>          thread 1                              thread 2
>          --------                              --------
> 
>        UFFDIO_WRITEPROTECT                     hugetlb_fault
>          hugetlb_change_protection
>            pgtable_lock()
>            huge_ptep_modify_prot_start
>                                                pte==NULL
>                                                hugetlb_no_page
>                                                  generate uffd missing event
>                                                  even if page existed!!
>            huge_ptep_modify_prot_commit
>            pgtable_unlock()
> 
> Fix this by recheck the pte after pgtable lock for both userfaultfd missing
> & minor fault paths.
> 
> This bug should have been around starting from uffd hugetlb introduced, so
> attaching a Fixes to the commit.  Also attach another Fixes to the minor
> support commit for easier tracking.
> 
> Note that userfaultfd is actually fine with false positives (e.g. caused by
> pte changed), but not wrong logical events (e.g. caused by reading a pte
> during changing).  The latter can confuse the userspace, so the strictness
> is very much preferred.  E.g., MISSING event should never happen on the
> page after UFFDIO_COPY has correctly installed the page and returned.
> 
> Cc: Andrea Arcangeli <aarcange@redhat.com>
> Cc: Mike Kravetz <mike.kravetz@oracle.com>
> Cc: Axel Rasmussen <axelrasmussen@google.com>
> Cc: Nadav Amit <nadav.amit@gmail.com>
> Fixes: 1a1aad8a9b7b ("userfaultfd: hugetlbfs: add userfaultfd hugetlb hook")
> Fixes: 7677f7fd8be7 ("userfaultfd: add minor fault registration mode")
> Co-developed-by: Mike Kravetz <mike.kravetz@oracle.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   mm/hugetlb.c | 55 ++++++++++++++++++++++++++++++++++++++++++++++------
>   1 file changed, 49 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 9679fe519b90..fa3fcdb0c4b8 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -5521,6 +5521,23 @@ static inline vm_fault_t hugetlb_handle_userfault(struct vm_area_struct *vma,
>   	return ret;
>   }
>   
> +/*
> + * Recheck pte with pgtable lock.  Returns true if pte didn't change, or
> + * false if pte changed or is changing.
> + */
> +static bool hugetlb_pte_stable(struct hstate *h, struct mm_struct *mm,
> +			       pte_t *ptep, pte_t old_pte)
> +{
> +	spinlock_t *ptl;
> +	bool same;
> +
> +	ptl = huge_pte_lock(h, mm, ptep);
> +	same = pte_same(huge_ptep_get(ptep), old_pte);
> +	spin_unlock(ptl);
> +
> +	return same;
> +}
> +
>   static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
>   			struct vm_area_struct *vma,
>   			struct address_space *mapping, pgoff_t idx,
> @@ -5562,9 +5579,30 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
>   			goto out;
>   		/* Check for page in userfault range */
>   		if (userfaultfd_missing(vma)) {
> -			ret = hugetlb_handle_userfault(vma, mapping, idx,
> -						       flags, haddr, address,
> -						       VM_UFFD_MISSING);
> +			/*
> +			 * Since hugetlb_no_page() was examining pte
> +			 * without pgtable lock, we need to re-test under
> +			 * lock because the pte may not be stable and could
> +			 * have changed from under us.  Try to detect
> +			 * either changed or during-changing ptes and retry
> +			 * properly when needed.
> +			 *
> +			 * Note that userfaultfd is actually fine with
> +			 * false positives (e.g. caused by pte changed),
> +			 * but not wrong logical events (e.g. caused by
> +			 * reading a pte during changing).  The latter can
> +			 * confuse the userspace, so the strictness is very
> +			 * much preferred.  E.g., MISSING event should
> +			 * never happen on the page after UFFDIO_COPY has
> +			 * correctly installed the page and returned.
> +			 */
> +			if (hugetlb_pte_stable(h, mm, ptep, old_pte))
> +				ret = hugetlb_handle_userfault(
> +				    vma, mapping, idx, flags, haddr,
> +				    address, VM_UFFD_MISSING);

That looks kind-of ugly now. I wonder if it would be worth factoring 
that handling out into a separate function and reusing it at two places. 
Would get rid of one level of code indent at least.

Apart from that, LGTM. Although the lockless reading of the PTE screams 
for more trouble in the future :)

-- 
Thanks,

David / dhildenb

