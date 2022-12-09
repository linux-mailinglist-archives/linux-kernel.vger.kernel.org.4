Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66363647C92
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 04:24:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbiLIDYe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 22:24:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbiLIDYd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 22:24:33 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D35A1C930
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 19:24:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670556272; x=1702092272;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=vp6xMOdRn/5zWi/yiPp1W1YaQj05xOxBN9Fzkz5Mw+I=;
  b=QPlCk6OG9sotxfVN/U1jX+qm5CBDZR7GumKgKJmGvSjUaRQLvHkA8JBW
   IwgXFOQkrNSAILQLdD2BzoeRETY/xqfFweXmG2bbT7qSkZ+68oYzS+DKa
   HNnfYhk2kYdpOHXeMlyaZFUk46mRf75QYrLLbWDT3zowEVxyNLsglNIcu
   a6WWvFU5ykTccuLD9uxPt1I8utbymLpXeB7sH8oAY3xb7nHb3kktP/T2z
   oOr/8SsOTF6ERZNF9CbIQs0biDDb1F8ALnw38qA4diRD0URcgWrBHAwZZ
   taIr5kWOCeDPEHj4PN+AXyGB5fPXNMB6l2DfEjFLj2uYyivAHXG1841SC
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10555"; a="344402948"
X-IronPort-AV: E=Sophos;i="5.96,228,1665471600"; 
   d="scan'208";a="344402948"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2022 19:24:31 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10555"; a="821590312"
X-IronPort-AV: E=Sophos;i="5.96,228,1665471600"; 
   d="scan'208";a="821590312"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2022 19:24:28 -0800
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Kairui Song <ryncsn@gmail.com>
Cc:     linux-mm@kvack.org, Kairui Song <kasong@tencent.com>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH 3/5] swap: fold swap_ra_clamp_pfn into swap_ra_info
References: <20221208180209.50845-1-ryncsn@gmail.com>
        <20221208180209.50845-4-ryncsn@gmail.com>
Date:   Fri, 09 Dec 2022 11:23:39 +0800
In-Reply-To: <20221208180209.50845-4-ryncsn@gmail.com> (Kairui Song's message
        of "Fri, 9 Dec 2022 02:02:07 +0800")
Message-ID: <87r0x9qmys.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kairui Song <ryncsn@gmail.com> writes:

> From: Kairui Song <kasong@tencent.com>
>
> This make the code cleaner. This helper is made of only two line of
> self explanational code and not reused anywhere else.
>
> And this actually make the compiled object smaller by a bit:
>
>           text    data     bss     dec     hex filename
> Before:   9502     976      12   10490    28fa mm/swap_state.o
> After:    9470     976      12   10458    28da mm/swap_state.o
>
> Signed-off-by: Kairui Song <kasong@tencent.com>
> ---
>  mm/swap_state.c | 44 +++++++++++++++++++-------------------------
>  1 file changed, 19 insertions(+), 25 deletions(-)

LGTM, Thanks!

Reviewed-by: "Huang, Ying" <ying.huang@intel.com>

> diff --git a/mm/swap_state.c b/mm/swap_state.c
> index 60136bda78e3..19089417abd1 100644
> --- a/mm/swap_state.c
> +++ b/mm/swap_state.c
> @@ -696,28 +696,15 @@ void exit_swap_address_space(unsigned int type)
>  	swapper_spaces[type] = NULL;
>  }
>  
> -static inline void swap_ra_clamp_pfn(struct vm_area_struct *vma,
> -				     unsigned long faddr,
> -				     unsigned long lpfn,
> -				     unsigned long rpfn,
> -				     unsigned long *start,
> -				     unsigned long *end)
> -{
> -	*start = max3(lpfn, PFN_DOWN(vma->vm_start),
> -		      PFN_DOWN(faddr & PMD_MASK));
> -	*end = min3(rpfn, PFN_DOWN(vma->vm_end),
> -		    PFN_DOWN((faddr & PMD_MASK) + PMD_SIZE));
> -}
> -
>  static void swap_ra_info(struct vm_fault *vmf,
> -			struct vma_swap_readahead *ra_info)
> +			 struct vma_swap_readahead *ra_info)
>  {
>  	struct vm_area_struct *vma = vmf->vma;
>  	unsigned long ra_val;
> -	unsigned long faddr, pfn, fpfn;
> +	unsigned long faddr, pfn, fpfn, lpfn, rpfn;
>  	unsigned long start, end;
>  	pte_t *pte, *orig_pte;
> -	unsigned int max_win, hits, prev_win, win, left;
> +	unsigned int max_win, hits, prev_win, win;
>  #ifndef CONFIG_64BIT
>  	pte_t *tpte;
>  #endif
> @@ -745,16 +732,23 @@ static void swap_ra_info(struct vm_fault *vmf,
>  
>  	/* Copy the PTEs because the page table may be unmapped */
>  	orig_pte = pte = pte_offset_map(vmf->pmd, faddr);
> -	if (fpfn == pfn + 1)
> -		swap_ra_clamp_pfn(vma, faddr, fpfn, fpfn + win, &start, &end);
> -	else if (pfn == fpfn + 1)
> -		swap_ra_clamp_pfn(vma, faddr, fpfn - win + 1, fpfn + 1,
> -				  &start, &end);
> -	else {
> -		left = (win - 1) / 2;
> -		swap_ra_clamp_pfn(vma, faddr, fpfn - left, fpfn + win - left,
> -				  &start, &end);
> +	if (fpfn == pfn + 1) {
> +		lpfn = fpfn;
> +		rpfn = fpfn + win;
> +	} else if (pfn == fpfn + 1) {
> +		lpfn = fpfn - win + 1;
> +		rpfn = fpfn + 1;
> +	} else {
> +		unsigned int left = (win - 1) / 2;
> +
> +		lpfn = fpfn - left;
> +		rpfn = fpfn + win - left;
>  	}
> +	start = max3(lpfn, PFN_DOWN(vma->vm_start),
> +		     PFN_DOWN(faddr & PMD_MASK));
> +	end = min3(rpfn, PFN_DOWN(vma->vm_end),
> +		   PFN_DOWN((faddr & PMD_MASK) + PMD_SIZE));
> +
>  	ra_info->nr_pte = end - start;
>  	ra_info->offset = fpfn - start;
>  	pte -= ra_info->offset;
