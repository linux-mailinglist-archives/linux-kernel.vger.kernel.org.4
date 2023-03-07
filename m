Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ADAD6AE60E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 17:13:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbjCGQNd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 11:13:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjCGQNc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 11:13:32 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5CF113D40
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 08:12:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678205555;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oo9Ql82WQk+WwZEhSCLKfZVtCnkfKktd5ammh9bPW10=;
        b=Ir4I4QI+OkdWk01fj0D7vyG1vy8qJraoGJ2zilUANt8bflcNfl88Bw+qi3P/XTm3lygWM7
        8OHi2TbaEgLwVqwWbG56GZ485FEY1h8HtZt7AcTOP2+AnWXV7aWvYnJvFL1Pp731lFoFzW
        ssnSkluHqK4XfEw80ntqs2Y2RVo1PVk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-16-BAgkaVz2PtCwNdEThR1DBA-1; Tue, 07 Mar 2023 11:11:20 -0500
X-MC-Unique: BAgkaVz2PtCwNdEThR1DBA-1
Received: by mail-wm1-f71.google.com with SMTP id r7-20020a05600c35c700b003eb3f2c4fb4so5145406wmq.6
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 08:11:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678205469;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oo9Ql82WQk+WwZEhSCLKfZVtCnkfKktd5ammh9bPW10=;
        b=JVs1LBIjMXuTypafUONSVbNrcej5AoQ/scoYm5tdpl8HGpCUKa0qRZjp72XC4jb82v
         dXha1+u3FpQ2cEwvlbj4wCQIpdtibZ+75Gs4Cz48I8uA1tihjKZW+7JR1RDS/J5g/nNI
         IwmEzzLwt8vIOrNEtH+C3oT/cchJrtR/3P0+Dcv3atBOB6z0TsndeUb+HQnFyFiAE91n
         1xDrYg6jo7400NRIv0Klo77cEEVmiNv+1X8hPUqWFtcnwvlBSzFUuu4JQTAYqAtJxc93
         F2HbgU3ADC3KXEpp8x1G0xS8dRpZEhDhRz1yBx6tjRTRHG2b/lN0ppynTHkdHrAkszCY
         BiRg==
X-Gm-Message-State: AO0yUKWKOaNTL1DpyqJJk2hlFYxPg5cK8nhhE17FZLGwqIkL9BZ4dMiA
        Eri4l1GlQP7GdjUN0bJL2kYuwViCS6rU2/Ghozr+CfHPURSB+/6W0e14MaUqvNxhNcYr85udGeI
        71tfFH8QjvZoP3YuyD06mSFGT
X-Received: by 2002:a5d:658b:0:b0:2c9:79f4:101f with SMTP id q11-20020a5d658b000000b002c979f4101fmr10742123wru.34.1678205468787;
        Tue, 07 Mar 2023 08:11:08 -0800 (PST)
X-Google-Smtp-Source: AK7set83og5nEYla97Fnw+XisXoZwVed2N+iJd6f789nKsBveRVprqXqIQ2BzzXK+rD9vLm4ROQKXw==
X-Received: by 2002:a5d:658b:0:b0:2c9:79f4:101f with SMTP id q11-20020a5d658b000000b002c979f4101fmr10742101wru.34.1678205468396;
        Tue, 07 Mar 2023 08:11:08 -0800 (PST)
Received: from ?IPV6:2003:cb:c707:a100:e20:41da:c49b:8974? (p200300cbc707a1000e2041dac49b8974.dip0.t-ipconnect.de. [2003:cb:c707:a100:e20:41da:c49b:8974])
        by smtp.gmail.com with ESMTPSA id d18-20020a5d6452000000b002c71dd1109fsm12715822wrw.47.2023.03.07.08.11.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Mar 2023 08:11:07 -0800 (PST)
Message-ID: <94be7b9f-c33e-c6dc-4132-6cb78f7c0624@redhat.com>
Date:   Tue, 7 Mar 2023 17:11:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Paul Gofman <pgofman@codeweavers.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20230306213925.617814-1-peterx@redhat.com>
 <20230306213925.617814-2-peterx@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v3 1/2] mm/uffd: UFFD_FEATURE_WP_UNPOPULATED
In-Reply-To: <20230306213925.617814-2-peterx@redhat.com>
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

On 06.03.23 22:39, Peter Xu wrote:

Note that I wodnered for a second if we'd call it 
"UFFD_FEATURE_WP_MISSING" instead (similar to the definition of MISSING 
uffd that triggers when we have nothing mapped).

Just a thought.

[...]

> With WP_UNPOPUATED, application like QEMU can avoid pre-read faults all the
> memory before wr-protect during taking a live snapshot.  Quotting from
> Muhammad's test result here [3] based on a simple program [4]:
> 
>    (1) With huge page disabled
>    echo madvise > /sys/kernel/mm/transparent_hugepage/enabled
>    ./uffd_wp_perf
>    Test DEFAULT: 4
>    Test PRE-READ: 1111453 (pre-fault 1101011)
>    Test MADVISE: 278276 (pre-fault 266378)
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
> postponed until a follow up write on any huge zero thp, so potentitially it

s/potentitially/potentially/

> is faster by making the follow up writes slower.

What I realized, interrestingly not only the writes, but also the reads. 
In case of background snapshots we'll be reading all VM memory I think 
... but we could optimize in QEMU by consulting the pagemap if there is 
anything mapped at all, and not read zeros in that case [an optimization 
brought up several times already].

I am not sure yet if we want to change the QEMU implementation. But 
anyhow, that's a different discussion.

> 
> [1] https://lore.kernel.org/all/20210401092226.102804-4-andrey.gruzdev@virtuozzo.com/
> [2] https://lore.kernel.org/all/Y+v2HJ8+3i%2FKzDBu@x1n/
> [3] https://lore.kernel.org/all/d0eb0a13-16dc-1ac1-653a-78b7273781e3@collabora.com/
> [4] https://github.com/xzpeter/clibs/blob/master/uffd-test/uffd-wp-perf.c
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   fs/userfaultfd.c                 | 14 ++++++++
>   include/linux/mm_inline.h        |  6 ++++
>   include/linux/userfaultfd_k.h    |  6 ++++
>   include/uapi/linux/userfaultfd.h | 10 +++++-
>   mm/memory.c                      | 56 ++++++++++++++++++++++--------
>   mm/mprotect.c                    | 59 ++++++++++++++++++++++++++------
>   6 files changed, 126 insertions(+), 25 deletions(-)

[...]

>   
> +static vm_fault_t handle_pte_missing(struct vm_fault *vmf)
> +{
> +	if (vma_is_anonymous(vmf->vma))
> +		return do_anonymous_page(vmf);
> +	else
> +		return do_fault(vmf);
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
> +	return handle_pte_missing(vmf);
>   }
>   
>   static vm_fault_t handle_pte_marker(struct vm_fault *vmf)
> @@ -4008,6 +4037,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>    */
>   static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
>   {
> +	bool uffd_wp = vmf_orig_pte_uffd_wp(vmf);
>   	struct vm_area_struct *vma = vmf->vma;
>   	struct folio *folio;
>   	vm_fault_t ret = 0;
> @@ -4041,7 +4071,7 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
>   						vma->vm_page_prot));
>   		vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd,
>   				vmf->address, &vmf->ptl);
> -		if (!pte_none(*vmf->pte)) {
> +		if (vmf_pte_changed(vmf)) {
>   			update_mmu_tlb(vma, vmf->address, vmf->pte);
>   			goto unlock;
>   		}
> @@ -4081,7 +4111,7 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
>   
>   	vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd, vmf->address,
>   			&vmf->ptl);
> -	if (!pte_none(*vmf->pte)) {
> +	if (vmf_pte_changed(vmf)) {
>   		update_mmu_tlb(vma, vmf->address, vmf->pte);
>   		goto release;
>   	}
> @@ -4101,6 +4131,8 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
>   	folio_add_new_anon_rmap(folio, vma, vmf->address);
>   	folio_add_lru_vma(folio, vma);
>   setpte:
> +	if (uffd_wp)
> +		entry = pte_mkuffd_wp(entry);
>   	set_pte_at(vma->vm_mm, vmf->address, vmf->pte, entry);
>   
>   	/* No need to invalidate - it was non-present before */
> @@ -4268,7 +4300,7 @@ vm_fault_t do_set_pmd(struct vm_fault *vmf, struct page *page)
>   void do_set_pte(struct vm_fault *vmf, struct page *page, unsigned long addr)
>   {
>   	struct vm_area_struct *vma = vmf->vma;
> -	bool uffd_wp = pte_marker_uffd_wp(vmf->orig_pte);
> +	bool uffd_wp = vmf_orig_pte_uffd_wp(vmf);
>   	bool write = vmf->flags & FAULT_FLAG_WRITE;
>   	bool prefault = vmf->address != addr;
>   	pte_t entry;
> @@ -4915,12 +4947,8 @@ static vm_fault_t handle_pte_fault(struct vm_fault *vmf)
>   		}
>   	}
>   
> -	if (!vmf->pte) {
> -		if (vma_is_anonymous(vmf->vma))
> -			return do_anonymous_page(vmf);
> -		else
> -			return do_fault(vmf);
> -	}
> +	if (!vmf->pte)
> +		return handle_pte_missing(vmf);

It would better blend in if it would be called "do_pte_missing()".

>   
>   	if (!pte_present(vmf->orig_pte))
>   		return do_swap_page(vmf);
> diff --git a/mm/mprotect.c b/mm/mprotect.c
> index 231929f119d9..6a2df93158ee 100644
> --- a/mm/mprotect.c
> +++ b/mm/mprotect.c
> @@ -276,7 +276,16 @@ static long change_pte_range(struct mmu_gather *tlb,
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
> +			if (!vma_is_anonymous(vma) ||
> +			    userfaultfd_wp_unpopulated(vma)) {

I think it would make sense to replace all 3 instances of this check by 
a new function (userfaultfd_wp_use_markers() ? ) and move some doc from 
pgtable_populate_needed() in there.

>   				/*
>   				 * For file-backed mem, we need to be able to
>   				 * wr-protect a none pte, because even if the
> @@ -320,23 +329,53 @@ static inline int pmd_none_or_clear_bad_unless_trans_huge(pmd_t *pmd)
>   	return 0;
>   }
>   
> -/* Return true if we're uffd wr-protecting file-backed memory, or false */
> +/*
> + * Return true if we want to split huge thps in change protection
> + * procedure, false otherwise.
> + */
>   static inline bool
> -uffd_wp_protect_file(struct vm_area_struct *vma, unsigned long cp_flags)
> +pgtable_split_needed(struct vm_area_struct *vma, unsigned long cp_flags)
>   {
> +	/*
> +	 * pte markers only resides in pte level, if we need pte markers,
> +	 * we need to split.  We cannot wr-protect shmem thp because file
> +	 * thp is handled differently when split by erasing the pmd so far.
> +	 */
>   	return (cp_flags & MM_CP_UFFD_WP) && !vma_is_anonymous(vma);
>   }
>   
>   /*
> - * If wr-protecting the range for file-backed, populate pgtable for the case
> - * when pgtable is empty but page cache exists.  When {pte|pmd|...}_alloc()
> - * failed we treat it the same way as pgtable allocation failures during
> - * page faults by kicking OOM and returning error.
> + * Return true if we want to populate pgtables in change protection
> + * procedure, false otherwise
> + */
> +static inline bool
> +pgtable_populate_needed(struct vm_area_struct *vma, unsigned long cp_flags)
> +{
> +	/* If not within ioctl(UFFDIO_WRITEPROTECT), then don't bother */
> +	if (!(cp_flags & MM_CP_UFFD_WP))
> +		return false;
> +
> +	/* Either if this is file-based, we need it for pte markers */
> +	if (!vma_is_anonymous(vma))
> +		return true;
> +
> +	/*
> +	 * Or anonymous, we only need this if WP_ZEROPAGE enabled (to
> +	 * install zero pages).

s/WP_ZEROPAGE/WP_UNPOPULATED/

> +	 */
> +	return userfaultfd_wp_unpopulated(vma);
> +}
> +



-- 
Thanks,

David / dhildenb

