Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0CC5647C89
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 04:16:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbiLIDQg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 22:16:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiLIDQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 22:16:33 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B02278E5B0
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 19:16:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670555792; x=1702091792;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=+qzWuJhdLNj38CLulD3dFODyqhkADDx3rnnROBnGehQ=;
  b=RKAq/mrF1/pXu60LEoGOl2edCKpJHzHXxWIGt/cFzxasio72hpC+ogGL
   3NNRH3sqlCzn+iYLb1BI/YKHjUJuV/uDNrO4JUM74HijM4zC5wJHko4KG
   BCDqkR4KDO0dbl7TPCOZ4lYqrfjz6sW/RjFRWxH+rfPATgDN+oqNO3e7I
   sHbJF84+m3WpuzmTbET7H3d4cVYiL4nYNtuHDwYfftMSLMj0z2L9SA4fI
   3nxCLegW88S22b40C9RE6GcsC8zUfsYRpKDbxpZggtwGEVzk429aSL0Fe
   n8h0CMc+N+Hyo/8G2wPxBi3tRdNWoRNK95QGyrya19vz6JwZLMgKjs/Nq
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10555"; a="315005978"
X-IronPort-AV: E=Sophos;i="5.96,228,1665471600"; 
   d="scan'208";a="315005978"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2022 19:16:32 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10555"; a="649416107"
X-IronPort-AV: E=Sophos;i="5.96,228,1665471600"; 
   d="scan'208";a="649416107"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2022 19:16:30 -0800
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Kairui Song <ryncsn@gmail.com>
Cc:     linux-mm@kvack.org, Kairui Song <kasong@tencent.com>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH 2/5] swap: avoid a redundant pte map if ra window is 1
References: <20221208180209.50845-1-ryncsn@gmail.com>
        <20221208180209.50845-3-ryncsn@gmail.com>
Date:   Fri, 09 Dec 2022 11:15:41 +0800
In-Reply-To: <20221208180209.50845-3-ryncsn@gmail.com> (Kairui Song's message
        of "Fri, 9 Dec 2022 02:02:06 +0800")
Message-ID: <87v8mlqnc2.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kairui Song <ryncsn@gmail.com> writes:

> From: Kairui Song <kasong@tencent.com>
>
> Avoid a redundant pte map/unmap when swap readahead window is 1.
>
> Signed-off-by: Kairui Song <kasong@tencent.com>
> ---
>  mm/swap_state.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)

Good to reduce the line of code.  Thanks!

Reviewed-by: "Huang, Ying" <ying.huang@intel.com>

> diff --git a/mm/swap_state.c b/mm/swap_state.c
> index 438d0676c5be..60136bda78e3 100644
> --- a/mm/swap_state.c
> +++ b/mm/swap_state.c
> @@ -730,8 +730,6 @@ static void swap_ra_info(struct vm_fault *vmf,
>  	}
>  
>  	faddr = vmf->address;
> -	orig_pte = pte = pte_offset_map(vmf->pmd, faddr);
> -
>  	fpfn = PFN_DOWN(faddr);
>  	ra_val = GET_SWAP_RA_VAL(vma);
>  	pfn = PFN_DOWN(SWAP_RA_ADDR(ra_val));
> @@ -742,12 +740,11 @@ static void swap_ra_info(struct vm_fault *vmf,
>  	atomic_long_set(&vma->swap_readahead_info,
>  			SWAP_RA_VAL(faddr, win, 0));
>  
> -	if (win == 1) {
> -		pte_unmap(orig_pte);
> +	if (win == 1)
>  		return;
> -	}
>  
>  	/* Copy the PTEs because the page table may be unmapped */
> +	orig_pte = pte = pte_offset_map(vmf->pmd, faddr);
>  	if (fpfn == pfn + 1)
>  		swap_ra_clamp_pfn(vma, faddr, fpfn, fpfn + win, &start, &end);
>  	else if (pfn == fpfn + 1)
