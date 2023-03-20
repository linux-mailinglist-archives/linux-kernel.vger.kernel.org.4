Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FDDC6C0EA8
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 11:22:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbjCTKWf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 06:22:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230266AbjCTKWb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 06:22:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 529611E5E6
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 03:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679307678;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BgSWj3zSpvR+t6erekcaSg4yxSMvQy9o3Bkd3DNLF24=;
        b=XPdjKZ9lEZsgWYGc/KZ3YiqnsjzQhQIcLllEgACbdQT0m2PJmgL7I2iNqNOla1SeQIxDqH
        4KWN0Vnp23mai2+/KHj+PNP+KOj62wpZeiqnxsE5MwJ5Ud277o92DEuynYabIZY1kK1/IX
        ycSOHICiGYDy2hHgmMZ7+PLjSc6ML68=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-85qoikPQOQWE8uK9HyzwaA-1; Mon, 20 Mar 2023 06:21:16 -0400
X-MC-Unique: 85qoikPQOQWE8uK9HyzwaA-1
Received: by mail-wr1-f70.google.com with SMTP id g7-20020a5d6987000000b002cea7acd26fso1345446wru.5
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 03:21:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679307675;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BgSWj3zSpvR+t6erekcaSg4yxSMvQy9o3Bkd3DNLF24=;
        b=3EWSG25H80Vnc4ML9Dq/YofIJi7qACz4Mqy7b8kG9lgRkJJwoT66a6PaHyZzrxvrhT
         Y9bMIX3eNQXWYfDWNVmyozLns8IUthpx/SHgBP+9NlAk3BuBv/TTCPcLl0orM/jHT+T2
         eJwFswrwE9tfIECdGUSEEvHdMPdSdpsXruKDHAql7sdZSHK5rVIshhHXFlNguJ07a8e+
         NLiP9X1QvRhTykrIa+KrNjjVRgTojgNpYva8dQpLupmN0TftDiR6Jw6ye7ctAo6LJzqb
         vKdUpA3TL0n3ve3618SW0U0cTrrS/Cm60Zv4A91Ut/EHqFnqlVDX+KtUrvMtW4oCTGNu
         7i+w==
X-Gm-Message-State: AO0yUKXSAYb2UMHe6/Xg4QWQpk746lRd3NtcGEsbLmkpVUU6uugtZN6g
        8PgW03B8TDzI+QXeDmF2ZL9QyjIfX5ejNgg1ZOXKfgqgWyKov9fQce1My6Dg8pJNTx4VxzBYmHA
        eMCcTW+ealrmjuQrfYr3ystK5
X-Received: by 2002:a05:600c:4ecf:b0:3eb:29fe:70ec with SMTP id g15-20020a05600c4ecf00b003eb29fe70ecmr36012809wmq.27.1679307675668;
        Mon, 20 Mar 2023 03:21:15 -0700 (PDT)
X-Google-Smtp-Source: AK7set+vItu0U3zmhAl3fXtHhWhsS19G9xFs9rpMm3JTWvnO8fUtGK+E9HJKmLUIHcQQoJKjWjITsg==
X-Received: by 2002:a05:600c:4ecf:b0:3eb:29fe:70ec with SMTP id g15-20020a05600c4ecf00b003eb29fe70ecmr36012793wmq.27.1679307675309;
        Mon, 20 Mar 2023 03:21:15 -0700 (PDT)
Received: from ?IPV6:2003:cb:c702:4100:a064:1ded:25ec:cf2f? (p200300cbc7024100a0641ded25eccf2f.dip0.t-ipconnect.de. [2003:cb:c702:4100:a064:1ded:25ec:cf2f])
        by smtp.gmail.com with ESMTPSA id n15-20020a1c720f000000b003ee0fc6244asm861481wmc.32.2023.03.20.03.21.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Mar 2023 03:21:14 -0700 (PDT)
Message-ID: <cf338070-246e-25d3-e624-53f4beda8158@redhat.com>
Date:   Mon, 20 Mar 2023 11:21:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Nadav Amit <nadav.amit@gmail.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Paul Gofman <pgofman@codeweavers.com>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20230309223711.823547-1-peterx@redhat.com>
 <20230309223711.823547-2-peterx@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v4 1/2] mm/uffd: UFFD_FEATURE_WP_UNPOPULATED
In-Reply-To: <20230309223711.823547-2-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>    (1) With huge page disabled
>    echo madvise > /sys/kernel/mm/transparent_hugepage/enabled
>    ./uffd_wp_perf
>    Test DEFAULT: 4
>    Test PRE-READ: 1111453 (pre-fault 1101011)
>    Test MADVISE: 278276 (pre-fault 266378)

Thinking about it, I guess the biggest slowdown here is the "one fake 
pagefault at a time" handling.

>    Test WP-UNPOPULATE: 11712
> 
>    (2) With Huge page enabled
>    echo always > /sys/kernel/mm/transparent_hugepage/enabled
>    ./uffd_wp_perf
>    Test DEFAULT: 4
>    Test PRE-READ: 22521 (pre-fault 22348)
>    Test MADVISE: 4909 (pre-fault 4743)
>    Test WP-UNPOPULATE: 14448
> 
> There'll be a great perf boost for no-thp case, while for thp enabled with
> extreme case of all-thp-zero WP_UNPOPULATED can be slower than MADVISE, but
> that's low possibility in reality, also the overhead was not reduced but
> postponed until a follow up write on any huge zero thp, so potentially it
> is faster by making the follow up writes slower.
> 
> [1] https://lore.kernel.org/all/20210401092226.102804-4-andrey.gruzdev@virtuozzo.com/
> [2] https://lore.kernel.org/all/Y+v2HJ8+3i%2FKzDBu@x1n/
> [3] https://lore.kernel.org/all/d0eb0a13-16dc-1ac1-653a-78b7273781e3@collabora.com/
> [4] https://github.com/xzpeter/clibs/blob/master/uffd-test/uffd-wp-perf.c
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   Documentation/admin-guide/mm/userfaultfd.rst | 17 ++++++
>   fs/userfaultfd.c                             | 16 ++++++
>   include/linux/mm_inline.h                    |  6 +++
>   include/linux/userfaultfd_k.h                | 23 ++++++++
>   include/uapi/linux/userfaultfd.h             | 10 +++-
>   mm/memory.c                                  | 56 +++++++++++++++-----
>   mm/mprotect.c                                | 51 ++++++++++++++----
>   7 files changed, 154 insertions(+), 25 deletions(-)
> 
> diff --git a/Documentation/admin-guide/mm/userfaultfd.rst b/Documentation/admin-guide/mm/userfaultfd.rst
> index 7dc823b56ca4..c86b56c95ea6 100644
> --- a/Documentation/admin-guide/mm/userfaultfd.rst
> +++ b/Documentation/admin-guide/mm/userfaultfd.rst
> @@ -219,6 +219,23 @@ former will have ``UFFD_PAGEFAULT_FLAG_WP`` set, the latter
>   you still need to supply a page when ``UFFDIO_REGISTER_MODE_MISSING`` was
>   used.
>   
> +Userfaultfd write-protect mode currently behave differently on none ptes
> +(when e.g. page is missing) over different types of memories.
> +
> +For anonymous memory, ``ioctl(UFFDIO_WRITEPROTECT)`` will ignore none ptes
> +(e.g. when pages are missing and not populated).  For file-backed memories
> +like shmem and hugetlbfs, none ptes will be write protected just like a
> +present pte.  In other words, there will be a userfaultfd write fault
> +message generated when writting to a missing page on file typed memories,

s/writting/writing/

> +as long as the page range was write-protected before.  Such a message will
> +not be generated on anonymous memories by default.
> +
> +If the application wants to be able to write protect none ptes on anonymous
> +memory, one can pre-populate the memory with e.g. MADV_POPULATE_READ.  On
> +newer kernels, one can also detect the feature UFFD_FEATURE_WP_UNPOPULATED
> +and set the feature bit in advance to make sure none ptes will also be
> +write protected even upon anonymous memory.
> +

[...]

>   /*
>    * A number of key systems in x86 including ioremap() rely on the assumption
> @@ -1350,6 +1364,10 @@ zap_install_uffd_wp_if_needed(struct vm_area_struct *vma,
>   			      unsigned long addr, pte_t *pte,
>   			      struct zap_details *details, pte_t pteval)
>   {
> +	/* Zap on anonymous always means dropping everything */
> +	if (vma_is_anonymous(vma))
> +		return;
> +
>   	if (zap_drop_file_uffd_wp(details))
>   		return;
>   
> @@ -1456,8 +1474,12 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
>   				continue;
>   			rss[mm_counter(page)]--;
>   		} else if (pte_marker_entry_uffd_wp(entry)) {
> -			/* Only drop the uffd-wp marker if explicitly requested */
> -			if (!zap_drop_file_uffd_wp(details))
> +			/*
> +			 * For anon: always drop the marker; for file: only
> +			 * drop the marker if explicitly requested.
> +			 */

So MADV_DONTNEED a pte marker in an anonymous VMA will always remove 
that marker. Is that the same handling as for MADV_DONTNEED on shmem or 
on fallocate(PUNCHHOLE) on shmem?

> +			if (!vma_is_anonymous(vma) &&
> +			    !zap_drop_file_uffd_wp(details))
>   				continue;

Maybe it would be nicer to have a zap_drop_uffd_wp_marker(vma, details) 
and have the comment in there. Especially because of the other hunk above.

So zap_drop_file_uffd_wp(details) -> zap_drop_uffd_wp_marker(vma, 
details) and move the anon handling + comment in there.


>   		} else if (is_hwpoison_entry(entry) ||
>   			   is_swapin_error_entry(entry)) {
> @@ -3624,6 +3646,14 @@ static vm_fault_t pte_marker_clear(struct vm_fault *vmf)
>   	return 0;
>   }
>   
> +static vm_fault_t do_pte_missing(struct vm_fault *vmf)
> +{
> +	if (vma_is_anonymous(vmf->vma))
> +		return do_anonymous_page(vmf);
> +	else
> +		return do_fault(vmf);

No need for the "else" statement.

> +}
> +
>   /*
>    * This is actually a page-missing access, but with uffd-wp special pte
>    * installed.  It means this pte was wr-protected before being unmapped.
> @@ -3634,11 +3664,10 @@ static vm_fault_t pte_marker_handle_uffd_wp(struct vm_fault *vmf)
>   	 * Just in case there're leftover special ptes even after the region
>   	 * got unregistered - we can simply clear them.
>   	 */
> -	if (unlikely(!userfaultfd_wp(vmf->vma) || vma_is_anonymous(vmf->vma)))
> +	if (unlikely(!userfaultfd_wp(vmf->vma)))
>   		return pte_marker_clear(vmf);
>   
> -	/* do_fault() can handle pte markers too like none pte */
> -	return do_fault(vmf);
> +	return do_pte_missing(vmf);
>   }
>   

[...]

> diff --git a/mm/mprotect.c b/mm/mprotect.c
> index 231929f119d9..455f7051098f 100644
> --- a/mm/mprotect.c
> +++ b/mm/mprotect.c
> @@ -276,7 +276,15 @@ static long change_pte_range(struct mmu_gather *tlb,
>   		} else {
>   			/* It must be an none page, or what else?.. */
>   			WARN_ON_ONCE(!pte_none(oldpte));
> -			if (unlikely(uffd_wp && !vma_is_anonymous(vma))) {
> +
> +			/*
> +			 * Nobody plays with any none ptes besides
> +			 * userfaultfd when applying the protections.
> +			 */
> +			if (likely(!uffd_wp))
> +				continue;
> +
> +			if (userfaultfd_wp_use_markers(vma)) {
>   				/*
>   				 * For file-backed mem, we need to be able to
>   				 * wr-protect a none pte, because even if the
> @@ -320,23 +328,46 @@ static inline int pmd_none_or_clear_bad_unless_trans_huge(pmd_t *pmd)
>   	return 0;
>   }
>   
> -/* Return true if we're uffd wr-protecting file-backed memory, or false */
> +/*
> + * Return true if we want to split huge thps in change protection

"huge thps" sounds redundant. "if we want to PTE-map a huge PMD" ?

> + * procedure, false otherwise.


In general,

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

