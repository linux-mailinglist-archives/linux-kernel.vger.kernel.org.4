Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04F9D728EC0
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 06:01:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238313AbjFIEBX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 00:01:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjFIEBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 00:01:16 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F079430E1;
        Thu,  8 Jun 2023 21:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686283272; x=1717819272;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=2EcSjpulKjk5XFbCfBa9nzXMzA3JLe/W3YU4+K6Ux5o=;
  b=XKsh24D5v8v2GduTx/USiYMRPOgeQvy5ErDQqUZKOIISM7KII+n26c9u
   mAy9MQilQY4wW3Y3PBzvUzUl+m1SCAUaOTb5UrGWBeWV/x2sfH67TYsp2
   tNgc3gNcm5K/zO92x+nwg9rzj32Eba1tsizTQK9YyNhbWjUQ1smZxgMyv
   m28LtgyAcf1TP0fIP+RXzsbk0Xl92FZPAEokRNVB08CkiWUC9XXIzMDwq
   /YbrWT9u/cJURS8XRyG56zYtFizfyaZmtp9RWv6g8MSkuyn9m2mY4z0Nm
   cBz3rnQOoKtUbd5YngauNbTU6m5XRnFxmLLkSbhzO7R0L71k8rqxh1DZy
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="337863856"
X-IronPort-AV: E=Sophos;i="6.00,228,1681196400"; 
   d="scan'208";a="337863856"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2023 21:01:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="687606956"
X-IronPort-AV: E=Sophos;i="6.00,228,1681196400"; 
   d="scan'208";a="687606956"
Received: from rahmanma-mobl1.amr.corp.intel.com (HELO [10.251.4.72]) ([10.251.4.72])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2023 21:01:11 -0700
Message-ID: <77187035-52c0-77b4-7c9e-d09ece77e0ce@linux.intel.com>
Date:   Thu, 8 Jun 2023 21:01:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.0
Subject: Re: [PATCH v11 11/20] x86/virt/tdx: Fill out TDMRs to cover all TDX
 memory regions
Content-Language: en-US
To:     Kai Huang <kai.huang@intel.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     linux-mm@kvack.org, dave.hansen@intel.com,
        kirill.shutemov@linux.intel.com, tony.luck@intel.com,
        peterz@infradead.org, tglx@linutronix.de, seanjc@google.com,
        pbonzini@redhat.com, david@redhat.com, dan.j.williams@intel.com,
        rafael.j.wysocki@intel.com, ying.huang@intel.com,
        reinette.chatre@intel.com, len.brown@intel.com, ak@linux.intel.com,
        isaku.yamahata@intel.com, chao.gao@intel.com, bagasdotme@gmail.com,
        sagis@google.com, imammedo@redhat.com
References: <cover.1685887183.git.kai.huang@intel.com>
 <927ec9871721d2a50f1aba7d1cf7c3be50e4f49b.1685887183.git.kai.huang@intel.com>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <927ec9871721d2a50f1aba7d1cf7c3be50e4f49b.1685887183.git.kai.huang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/4/23 7:27 AM, Kai Huang wrote:
> Start to transit out the "multi-steps" to construct a list of "TD Memory
> Regions" (TDMRs) to cover all TDX-usable memory regions.
> 
> The kernel configures TDX-usable memory regions by passing a list of
> TDMRs "TD Memory Regions" (TDMRs) to the TDX module.  Each TDMR contains
> the information of the base/size of a memory region, the base/size of the
> associated Physical Address Metadata Table (PAMT) and a list of reserved
> areas in the region.
> 
> Do the first step to fill out a number of TDMRs to cover all TDX memory
> regions.  To keep it simple, always try to use one TDMR for each memory
> region.  As the first step only set up the base/size for each TDMR.

As a first step?

> 
> Each TDMR must be 1G aligned and the size must be in 1G granularity.
> This implies that one TDMR could cover multiple memory regions.  If a
> memory region spans the 1GB boundary and the former part is already
> covered by the previous TDMR, just use a new TDMR for the remaining
> part.
> 
> TDX only supports a limited number of TDMRs.  Disable TDX if all TDMRs
> are consumed but there is more memory region to cover.
> 
> There are fancier things that could be done like trying to merge
> adjacent TDMRs.  This would allow more pathological memory layouts to be
> supported.  But, current systems are not even close to exhausting the
> existing TDMR resources in practice.  For now, keep it simple.
> 
> Signed-off-by: Kai Huang <kai.huang@intel.com>
> ---
> 
> v10 -> v11:
>  - No update
> 
> v9 -> v10:
>  - No change.
> 
> v8 -> v9:
> 
>  - Added the last paragraph in the changelog (Dave).
>  - Removed unnecessary type cast in tdmr_entry() (Dave).
> 
> 
> ---
>  arch/x86/virt/vmx/tdx/tdx.c | 94 ++++++++++++++++++++++++++++++++++++-
>  1 file changed, 93 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
> index 7a20c72361e7..fa9fa8bc581a 100644
> --- a/arch/x86/virt/vmx/tdx/tdx.c
> +++ b/arch/x86/virt/vmx/tdx/tdx.c
> @@ -385,6 +385,93 @@ static void free_tdmr_list(struct tdmr_info_list *tdmr_list)
>  			tdmr_list->max_tdmrs * tdmr_list->tdmr_sz);
>  }
>  
> +/* Get the TDMR from the list at the given index. */
> +static struct tdmr_info *tdmr_entry(struct tdmr_info_list *tdmr_list,
> +				    int idx)
> +{
> +	int tdmr_info_offset = tdmr_list->tdmr_sz * idx;
> +
> +	return (void *)tdmr_list->tdmrs + tdmr_info_offset;
> +}
> +
> +#define TDMR_ALIGNMENT		BIT_ULL(30)
> +#define TDMR_PFN_ALIGNMENT	(TDMR_ALIGNMENT >> PAGE_SHIFT)

This macro is never used. Maybe you can drop it from this patch.

> +#define TDMR_ALIGN_DOWN(_addr)	ALIGN_DOWN((_addr), TDMR_ALIGNMENT)
> +#define TDMR_ALIGN_UP(_addr)	ALIGN((_addr), TDMR_ALIGNMENT)
> +
> +static inline u64 tdmr_end(struct tdmr_info *tdmr)
> +{
> +	return tdmr->base + tdmr->size;
> +}
> +
> +/*
> + * Take the memory referenced in @tmb_list and populate the
> + * preallocated @tdmr_list, following all the special alignment
> + * and size rules for TDMR.
> + */
> +static int fill_out_tdmrs(struct list_head *tmb_list,
> +			  struct tdmr_info_list *tdmr_list)
> +{
> +	struct tdx_memblock *tmb;
> +	int tdmr_idx = 0;
> +
> +	/*
> +	 * Loop over TDX memory regions and fill out TDMRs to cover them.
> +	 * To keep it simple, always try to use one TDMR to cover one
> +	 * memory region.
> +	 *
> +	 * In practice TDX1.0 supports 64 TDMRs, which is big enough to
> +	 * cover all memory regions in reality if the admin doesn't use
> +	 * 'memmap' to create a bunch of discrete memory regions.  When
> +	 * there's a real problem, enhancement can be done to merge TDMRs
> +	 * to reduce the final number of TDMRs.
> +	 */
> +	list_for_each_entry(tmb, tmb_list, list) {
> +		struct tdmr_info *tdmr = tdmr_entry(tdmr_list, tdmr_idx);
> +		u64 start, end;
> +
> +		start = TDMR_ALIGN_DOWN(PFN_PHYS(tmb->start_pfn));
> +		end   = TDMR_ALIGN_UP(PFN_PHYS(tmb->end_pfn));
> +
> +		/*
> +		 * A valid size indicates the current TDMR has already
> +		 * been filled out to cover the previous memory region(s).
> +		 */
> +		if (tdmr->size) {
> +			/*
> +			 * Loop to the next if the current memory region
> +			 * has already been fully covered.
> +			 */
> +			if (end <= tdmr_end(tdmr))
> +				continue;
> +
> +			/* Otherwise, skip the already covered part. */
> +			if (start < tdmr_end(tdmr))
> +				start = tdmr_end(tdmr);
> +
> +			/*
> +			 * Create a new TDMR to cover the current memory
> +			 * region, or the remaining part of it.
> +			 */
> +			tdmr_idx++;
> +			if (tdmr_idx >= tdmr_list->max_tdmrs) {
> +				pr_warn("initialization failed: TDMRs exhausted.\n");
> +				return -ENOSPC;
> +			}
> +
> +			tdmr = tdmr_entry(tdmr_list, tdmr_idx);
> +		}
> +
> +		tdmr->base = start;
> +		tdmr->size = end - start;
> +	}
> +
> +	/* @tdmr_idx is always the index of last valid TDMR. */
> +	tdmr_list->nr_consumed_tdmrs = tdmr_idx + 1;
> +
> +	return 0;
> +}
> +
>  /*
>   * Construct a list of TDMRs on the preallocated space in @tdmr_list
>   * to cover all TDX memory regions in @tmb_list based on the TDX module
> @@ -394,10 +481,15 @@ static int construct_tdmrs(struct list_head *tmb_list,
>  			   struct tdmr_info_list *tdmr_list,
>  			   struct tdsysinfo_struct *sysinfo)
>  {
> +	int ret;
> +
> +	ret = fill_out_tdmrs(tmb_list, tdmr_list);
> +	if (ret)
> +		return ret;
> +
>  	/*
>  	 * TODO:
>  	 *
> -	 *  - Fill out TDMRs to cover all TDX memory regions.
>  	 *  - Allocate and set up PAMTs for each TDMR.
>  	 *  - Designate reserved areas for each TDMR.
>  	 *

Rest looks good to me.

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
