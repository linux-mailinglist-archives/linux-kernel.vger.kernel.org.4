Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EAB164D713
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 08:14:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbiLOHOJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 02:14:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230113AbiLOHNp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 02:13:45 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 088892BE4
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 23:13:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671088385; x=1702624385;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=EWQk0FKhMSiCXvonJAP6/L07NtFYNlyOomIZtp+JTIo=;
  b=iMDXcPCSqA0kX4rYzIni8TCRi5nEcpTO1itojpihsrSizZn7OUI8HZ0w
   +2RIjwzXy/Tm+7sAvVbCVC6sYbmBE+5UK116aLgb2a61Hn/jy1+cLhYgq
   nLXCS4pQbzFhXjsNpzEMTptyB7KRYo7zNF7CBsmR+YotVwj5gszOKxRyn
   +KHmirxPOyhxPMj6NGeOQOUeAzsXQXzlpccMjmg5kgY2ijIZRDR4rBsLF
   3tHM2/Jo6CxUjTutFEU98IqI6RsubeWM89y04LehcPtmhJoTiXRXlWAeZ
   +6/4+wEptNKzf5SMFuwj7VKnYwBx34y3KmluV3ChsrNLiETrDQVYQEAfJ
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10561"; a="302014613"
X-IronPort-AV: E=Sophos;i="5.96,246,1665471600"; 
   d="scan'208";a="302014613"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2022 23:13:04 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10561"; a="680015052"
X-IronPort-AV: E=Sophos;i="5.96,246,1665471600"; 
   d="scan'208";a="680015052"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2022 23:13:02 -0800
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        Pengfei Xu <pengfei.xu@intel.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Miaohe Lin <linmiaohe@huawei.com>
Subject: Re: [PATCH 2/2] mm: Fix a few rare cases of using swapin error pte
 marker
References: <20221214200453.1772655-1-peterx@redhat.com>
        <20221214200453.1772655-3-peterx@redhat.com>
Date:   Thu, 15 Dec 2022 15:12:13 +0800
In-Reply-To: <20221214200453.1772655-3-peterx@redhat.com> (Peter Xu's message
        of "Wed, 14 Dec 2022 15:04:53 -0500")
Message-ID: <87bko5cf8y.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Xu <peterx@redhat.com> writes:

> This patch should harden commit 15520a3f0469 ("mm: use pte markers for swap
> errors") on using pte markers for swapin errors on a few corner cases.
>
> 1. Propagate swapin errors across fork()s: if there're swapin errors in
>    the parent mm, after fork()s the child should sigbus too when an error
>    page is accessed.
>
> 2. Fix a rare condition race in pte_marker_clear() where a uffd-wp pte
>    marker can be quickly switched to a swapin error.
>
> 3. Explicitly ignore swapin error pte markers in change_protection().
>
> I mostly don't worry on (2) or (3) at all, but we should still have them.
> Case (1) is special because it can potentially cause silent data corrupt on
> child when parent has swapin error triggered with swapoff, but since swapin
> error is rare itself already it's probably not easy to trigger either.
>
> Currently there is a priority difference between the uffd-wp bit and the
> swapin error entry, in which the swapin error always has higher
> priority (e.g. we don't need to wr-protect a swapin error pte marker).
>
> If there will be a 3rd bit introduced, we'll probably need to consider a
> more involved approach so we may need to start operate on the bits.  Let's
> leave that for later.
>
> This patch is tested with case (1) explicitly where we'll get corrupted
> data before in the child if there's existing swapin error pte markers, and
> after patch applied the child can be rightfully killed.
>
> We don't need to copy stable for this one since 15520a3f0469 just landed as
> part of v6.2-rc1, only "Fixes" applied.
>
> Fixes: 15520a3f0469 ("mm: use pte markers for swap errors")
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  mm/hugetlb.c  | 3 +++
>  mm/memory.c   | 8 ++++++--
>  mm/mprotect.c | 8 +++++++-
>  3 files changed, 16 insertions(+), 3 deletions(-)
>
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index f5f445c39dbc..1e8e4eb10328 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -4884,6 +4884,9 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
>  				entry = huge_pte_clear_uffd_wp(entry);
>  			set_huge_pte_at(dst, addr, dst_pte, entry);
>  		} else if (unlikely(is_pte_marker(entry))) {
> +			/* No swap on hugetlb */
> +			WARN_ON_ONCE(
> +			    is_swapin_error_entry(pte_to_swp_entry(entry)));
>  			/*
>  			 * We copy the pte marker only if the dst vma has
>  			 * uffd-wp enabled.
> diff --git a/mm/memory.c b/mm/memory.c
> index 032ef700c3e8..3e836fecd035 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -828,7 +828,7 @@ copy_nonpresent_pte(struct mm_struct *dst_mm, struct mm_struct *src_mm,
>  			return -EBUSY;
>  		return -ENOENT;
>  	} else if (is_pte_marker_entry(entry)) {
> -		if (userfaultfd_wp(dst_vma))
> +		if (is_swapin_error_entry(entry) || userfaultfd_wp(dst_vma))

Should we do this in [1/2]?  It appears that we introduce an issue in
[1/2] and fix it in [2/2]?

Best Regards,
Huang, Ying

>  			set_pte_at(dst_mm, addr, dst_pte, pte);
>  		return 0;
>  	}
> @@ -3625,8 +3625,12 @@ static vm_fault_t pte_marker_clear(struct vm_fault *vmf)
>  	/*
>  	 * Be careful so that we will only recover a special uffd-wp pte into a
>  	 * none pte.  Otherwise it means the pte could have changed, so retry.
> +	 *
> +	 * This should also cover the case where e.g. the pte changed
> +	 * quickly from a PTE_MARKER_UFFD_WP into PTE_MARKER_SWAPIN_ERROR.
> +	 * So is_pte_marker() check is not enough to safely drop the pte.
>  	 */
> -	if (is_pte_marker(*vmf->pte))
> +	if (pte_same(vmf->orig_pte, *vmf->pte))
>  		pte_clear(vmf->vma->vm_mm, vmf->address, vmf->pte);
>  	pte_unmap_unlock(vmf->pte, vmf->ptl);
>  	return 0;
> diff --git a/mm/mprotect.c b/mm/mprotect.c
> index 093cb50f2fc4..a6f905211327 100644
> --- a/mm/mprotect.c
> +++ b/mm/mprotect.c
> @@ -245,7 +245,13 @@ static unsigned long change_pte_range(struct mmu_gather *tlb,
>  					newpte = pte_swp_mksoft_dirty(newpte);
>  				if (pte_swp_uffd_wp(oldpte))
>  					newpte = pte_swp_mkuffd_wp(newpte);
> -			} else if (pte_marker_entry_uffd_wp(entry)) {
> +			} else if (is_pte_marker_entry(entry)) {
> +				/*
> +				 * Ignore swapin errors unconditionally,
> +				 * because any access should sigbus anyway.
> +				 */
> +				if (is_swapin_error_entry(entry))
> +					continue;
>  				/*
>  				 * If this is uffd-wp pte marker and we'd like
>  				 * to unprotect it, drop it; the next page
