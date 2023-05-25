Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AA36711AC1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 01:40:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241134AbjEYXkH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 19:40:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241274AbjEYXkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 19:40:05 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A23C19C;
        Thu, 25 May 2023 16:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685058002; x=1716594002;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=n8tS25fObeTtNS/qQCrIYQeRMkQmVgP3uApvxw4lLGM=;
  b=czL9250SQkolpr8ZG+H0Cb/Dl34ikfPnky5g4PxpKzaUA3AGdSZLA1FZ
   bXWMWSXRxCJDaoSjI6v+UjbFuxqdY4uizQiPWK5vE9tok0nvJpHN8m2eg
   1LkrVAueHXa7AdDHA7Vh0HtjmUalo5FSRSM0w+c5WAapu6veHv6FbGSdC
   voiZW/xnp0DxsxCJP8xr09CF2wotTuuUwLj8kj8ISVQRaw0UVfrwQLNzq
   r9mKH5llxtPNmN87X3MvX8zYlBsNz1BTXOk1wTUV/CfmbZw9TDDjknQ/A
   ZgLu9qfuijfTJuNRutl++melP6SjGfaehOH8qot3ewAC6P7ct5OOHmSl0
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10721"; a="352899731"
X-IronPort-AV: E=Sophos;i="6.00,192,1681196400"; 
   d="scan'208";a="352899731"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2023 16:40:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10721"; a="708189446"
X-IronPort-AV: E=Sophos;i="6.00,192,1681196400"; 
   d="scan'208";a="708189446"
Received: from mseamste-mobl1.amr.corp.intel.com (HELO [10.209.120.148]) ([10.209.120.148])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2023 16:40:00 -0700
Message-ID: <ec1553a9-4412-b624-4f10-93ef332f12d9@linux.intel.com>
Date:   Thu, 25 May 2023 16:40:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.0
Subject: Re: [PATCH 2/2] x86/tdx: Fix race between set_memory_encrypted() and
 load_unaligned_zeropad()
Content-Language: en-US
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        dave.hansen@intel.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de
Cc:     decui@microsoft.com, rick.p.edgecombe@intel.com, seanjc@google.com,
        thomas.lendacky@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20230525225847.28592-1-kirill.shutemov@linux.intel.com>
 <20230525225847.28592-3-kirill.shutemov@linux.intel.com>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20230525225847.28592-3-kirill.shutemov@linux.intel.com>
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

Hi, 

On 5/25/23 3:58 PM, Kirill A. Shutemov wrote:
> Touching privately mapped GPA that is not properly converted to private
> with MapGPA and accepted leads to unrecoverable exit to VMM.
> 
> load_unaligned_zeropad() can touch memory that is not owned by the
> caller, but just happened to next after the owned memory.
> This load_unaligned_zeropad() behaviour makes it important when kernel
> asks VMM to convert a GPA from shared to private or back. Kernel must
> never have a page mapped into direct mapping (and aliases) as private
> when the GPA is already converted to shared or when GPA is not yet
> converted to private.
> 
> guest.enc_status_change_prepare() called before adjusting direct mapping
> and therefore it is responsible for converting the memory to private.
> 
> guest.enc_tlb_flush_required() called after adjusting direct mapping and
> it converts the memory to shared.

Do you mean .enc_status_change_finish() here? Isn't enc_tlb_flush_required()
called before adjusting the mapping?

> 
> It is okay to have a shared mapping of memory that is not converted
> properly. handle_mmio() knows how to deal with load_unaligned_zeropad()
> stepping on it.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Fixes: 7dbde7631629 ("x86/mm/cpa: Add support for TDX shared memory")
> Cc: stable@vger.kernel.org
> ---
>  arch/x86/coco/tdx/tdx.c | 56 ++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 53 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
> index e146b599260f..84525df750d4 100644
> --- a/arch/x86/coco/tdx/tdx.c
> +++ b/arch/x86/coco/tdx/tdx.c
> @@ -840,6 +840,30 @@ static bool tdx_enc_status_changed(unsigned long vaddr, int numpages, bool enc)
>  	return true;
>  }
>  
> +static bool tdx_enc_status_change_prepare(unsigned long vaddr, int numpages,
> +					  bool enc)
> +{
> +	/*
> +	 * Only handle shared->private conversion here.
> +	 * See the comment in tdx_early_init().
> +	 */
> +	if (enc)
> +		return tdx_enc_status_changed(vaddr, numpages, enc);
> +	return true;
> +}
> +
> +static bool tdx_enc_status_change_finish(unsigned long vaddr, int numpages,
> +					 bool enc)
> +{
> +	/*
> +	 * Only handle private->shared conversion here.
> +	 * See the comment in tdx_early_init().
> +	 */
> +	if (!enc)
> +		return tdx_enc_status_changed(vaddr, numpages, enc);
> +	return true;
> +}
> +
>  void __init tdx_early_init(void)
>  {
>  	u64 cc_mask;
> @@ -867,9 +891,35 @@ void __init tdx_early_init(void)
>  	 */
>  	physical_mask &= cc_mask - 1;
>  
> -	x86_platform.guest.enc_cache_flush_required = tdx_cache_flush_required;
> -	x86_platform.guest.enc_tlb_flush_required   = tdx_tlb_flush_required;
> -	x86_platform.guest.enc_status_change_finish = tdx_enc_status_changed;
> +	/*
> +	 * Touching privately mapped GPA that is not properly converted to
> +	 * private with MapGPA and accepted leads to unrecoverable exit
> +	 * to VMM.
> +	 *
> +	 * load_unaligned_zeropad() can touch memory that is not owned by
> +	 * the caller, but just happened to next after the owned memory.
> +	 * This load_unaligned_zeropad() behaviour makes it important when
> +	 * kernel asks VMM to convert a GPA from shared to private or back.
> +	 * Kernel must never have a page mapped into direct mapping (and
> +	 * aliases) as private when the GPA is already converted to shared or
> +	 * when GPA is not yet converted to private.
> +	 *
> +	 * guest.enc_status_change_prepare() called before adjusting direct
> +	 * mapping and therefore it is responsible for converting the memory
> +	 * to private.
> +	 *
> +	 * guest.enc_tlb_flush_required() called after adjusting direct mapping
> +	 * and it converts the memory to shared.

Same as above. Is it .enc_status_change_finish() here?

> +	 *
> +	 * It is okay to have a shared mapping of memory that is not converted
> +	 * properly. handle_mmio() knows how to deal with load_unaligned_zeropad()
> +	 * stepping on it.
> +	 */
> +	x86_platform.guest.enc_status_change_prepare = tdx_enc_status_change_prepare;
> +	x86_platform.guest.enc_status_change_finish  = tdx_enc_status_change_finish;
> +
> +	x86_platform.guest.enc_cache_flush_required  = tdx_cache_flush_required;
> +	x86_platform.guest.enc_tlb_flush_required    = tdx_tlb_flush_required;
>  
>  	pr_info("Guest detected\n");
>  }

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
