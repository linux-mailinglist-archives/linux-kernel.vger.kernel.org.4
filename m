Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 467556485C8
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 16:46:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbiLIPqo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 10:46:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbiLIPqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 10:46:42 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92ADB27938
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 07:46:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670600801; x=1702136801;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=q8N2XjMXM6I+jsDrrd5PF9tR+Xb8pSXqIisIGUSW73s=;
  b=lNf/ygmdkYRa02btfXeWOsYE/e8p64B+ZbspxaD3rRJRwQOqrEyMwHST
   6s9+NSG4+38VLxniYBX/eX25f5gKiDrNo5jOlINH1Si0nfrhyLuDgBzca
   6QgxYB1UyvPOQNCz9TQMMdb8n44NeAr5p2ILSC1FrSFh+sIHx4VoYdYva
   TzLs/F+NBDsPjlx1QdXZnwvdX7xJIu0Wv95mmD4k99fHyeIGyWswhQBX6
   7RIp78A0rHjZfopb5Bs90billVMlptS092fDAdQTULnY2pFVe/V4Likzz
   X6M9ZSbkClCHEJ77H/c00WsNaMJv8iDpaVbGNNRME/MjMJYtL5DJyPaV3
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10556"; a="297163540"
X-IronPort-AV: E=Sophos;i="5.96,230,1665471600"; 
   d="scan'208";a="297163540"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2022 07:45:36 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10556"; a="679964637"
X-IronPort-AV: E=Sophos;i="5.96,230,1665471600"; 
   d="scan'208";a="679964637"
Received: from rrode-mobl1.amr.corp.intel.com (HELO [10.251.24.37]) ([10.251.24.37])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2022 07:45:35 -0800
Message-ID: <acef3c81-635e-6753-577e-3905117823b9@linux.intel.com>
Date:   Fri, 9 Dec 2022 07:45:34 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
Subject: Re: [PATCH 3/4] x86/tdx: Relax SEPT_VE_DISABLE check for debug TD
Content-Language: en-US
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Elena Reshetova <elena.reshetova@intel.com>, x86@kernel.org,
        linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20221209132524.20200-1-kirill.shutemov@linux.intel.com>
 <20221209132524.20200-4-kirill.shutemov@linux.intel.com>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20221209132524.20200-4-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/9/22 5:25 AM, Kirill A. Shutemov wrote:
> SEPT_VE_DISABLE check is required to keep the TD protected from VMM
> attacks, but it makes harder to debug guest kernel bugs. If guest
> touches unaccepted memory the TD will get terminated without any
> traces on what has happened.
> 
> Relax the SEPT_VE_DISABLE check to warning on debug TD and panic() in
> the #VE handler on EPT-violation on private memory. It will produce
> useful backtrace.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> ---
>  arch/x86/coco/tdx/tdx.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
> index 8ad04d101270..0e47846ff8ff 100644
> --- a/arch/x86/coco/tdx/tdx.c
> +++ b/arch/x86/coco/tdx/tdx.c
> @@ -38,6 +38,7 @@
>  #define VE_GET_PORT_NUM(e)	((e) >> 16)
>  #define VE_IS_IO_STRING(e)	((e) & BIT(4))
>  
> +#define ATTR_DEBUG		BIT(0)
>  #define ATTR_SEPT_VE_DISABLE	BIT(28)
>  
>  /* TDX Module call error codes */
> @@ -207,8 +208,15 @@ static void tdx_parse_tdinfo(u64 *cc_mask)
>  	 * TD-private memory.  Only VMM-shared memory (MMIO) will #VE.
>  	 */
>  	td_attr = out.rdx;
> -	if (!(td_attr & ATTR_SEPT_VE_DISABLE))
> -		tdx_panic("TD misconfiguration: SEPT_VE_DISABLE attribute must be set.");
> +	if (!(td_attr & ATTR_SEPT_VE_DISABLE)) {
> +		const char *msg = "TD misconfiguration: SEPT_VE_DISABLE attribute must be set.";
> +
> +		/* Relax SEPT_VE_DISABLE check for debug TD. */
> +		if (td_attr & ATTR_DEBUG)
> +			pr_warn("%s\n", msg);
> +		else
> +			tdx_panic(msg);
> +	}
>  }
>  
>  /*
> @@ -682,6 +690,8 @@ static int virt_exception_kernel(struct pt_regs *regs, struct ve_info *ve)
>  	case EXIT_REASON_CPUID:
>  		return handle_cpuid(regs, ve);
>  	case EXIT_REASON_EPT_VIOLATION:
> +		if (ve->gpa != cc_mkdec(ve->gpa))
> +			panic("Unexpected EPT-violation on private memory.");

Why add this change part of TD debug check? Should this be a separate patch?

>  		return handle_mmio(regs, ve);
>  	case EXIT_REASON_IO_INSTRUCTION:
>  		return handle_io(regs, ve);

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
