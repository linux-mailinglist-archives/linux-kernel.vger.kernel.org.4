Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DA876485F2
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 16:51:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230509AbiLIPv2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 10:51:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230499AbiLIPus (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 10:50:48 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8B461D65D
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 07:50:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670601047; x=1702137047;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=hG4NYNsluE+2FrVCn2dyTAimfT0CMNyI12psTrWqc+8=;
  b=GKPuE1Po53A9nz2JYlMWaMCP+KdYMeFnSPhWmjhandRSc1yltIb8xWBy
   hZObSTDhIPgir0jPY7u0S3j5o6PPzBMHmbsWEvKtKVu1k02NEzpuhN+Tg
   aYeyTimTj0k/ewmi1yyUZABsKCcFCzmvbgMQ3BHXJUSKvcJX/ErYspAI8
   iOF99LaULuD/ULd+v7Nzou007WEtXFfyrvwcdye8jBExbF1am9S9bRSba
   BkMY5moJ+iwUAnl85g5tm0nlE78SzcN6KzVrXgsbPoVhu8Yg7fa9fBKxJ
   vLIxTlEEl+ebbcp/bsDCX2DmoLPIGeTN7hhFfl1NkKUecgiE7D3XoncbG
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10556"; a="315120126"
X-IronPort-AV: E=Sophos;i="5.96,230,1665471600"; 
   d="scan'208";a="315120126"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2022 07:50:47 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10556"; a="647433723"
X-IronPort-AV: E=Sophos;i="5.96,230,1665471600"; 
   d="scan'208";a="647433723"
Received: from rrode-mobl1.amr.corp.intel.com (HELO [10.251.24.37]) ([10.251.24.37])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2022 07:50:47 -0800
Message-ID: <ac8b6afa-813d-56c7-094a-8891ba69deeb@linux.intel.com>
Date:   Fri, 9 Dec 2022 07:50:46 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
Subject: Re: [PATCH 4/4] x86/tdx: Disable NOTIFY_ENABLES
Content-Language: en-US
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Elena Reshetova <elena.reshetova@intel.com>, x86@kernel.org,
        linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20221209132524.20200-1-kirill.shutemov@linux.intel.com>
 <20221209132524.20200-5-kirill.shutemov@linux.intel.com>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20221209132524.20200-5-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/9/22 5:25 AM, Kirill A. Shutemov wrote:
> == Background ==
> 
> There is a class of side-channel attacks against SGX enclaves called
> "SGX Step"[1]. These attacks create lots of exceptions inside of
> enclaves. Basically, run an in-enclave instruction, cause an exception.
> Over and over.
> 
> There is a concern that a VMM could attack a TDX guest in the same way
> by causing lots of #VE's. The TDX architecture includes new
> countermeasures for these attacks. It basically counts the number of
> exceptions and can send another *special* exception once the number of
> VMM-induced #VE's hits a critical threshold[2].
> 
> == Problem ==
> 
> But, these special exceptions are independent of any action that the
> guest takes. They can occur anywhere that the guest executes. This
> includes sensitive areas like the entry code. The (non-paranoid) #VE
> handler is incapable of handling exceptions in these areas.
> 
> == Solution ==
> 
> Fortunately, the special exceptions can be disabled by the guest via
> write to NOTIFY_ENABLES TDCS field. NOTIFY_ENABLES is disabled by
> default, but might be enabled by a bootloader, firmware or an earlier
> kernel before the current kernel runs.
> 
> Disable NOTIFY_ENABLES feature explicitly and unconditionally. Any
> NOTIFY_ENABLES-based #VE's that occur before this point will end up
> in the early #VE exception handler and die due to unexpected exit
> reason.
> 
> [1] https://github.com/jovanbulck/sgx-step
> [2] https://intel.github.io/ccc-linux-guest-hardening-docs/security-spec.html#safety-against-ve-in-kernel-code
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> ---

I don't think you need to explicitly use section names (Background,
problem or solution) in the commit log. But it is up to you.

Rest looks good.


>  arch/x86/coco/tdx/tdx.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
> index 0e47846ff8ff..c93c2fd2e113 100644
> --- a/arch/x86/coco/tdx/tdx.c
> +++ b/arch/x86/coco/tdx/tdx.c
> @@ -19,6 +19,10 @@
>  #define TDX_GET_VEINFO			3
>  #define TDX_GET_REPORT			4
>  #define TDX_ACCEPT_PAGE			6
> +#define TDX_WR				8
> +
> +/* TDCS fields. To be used by TDG.VM.WR and TDG.VM.RD module calls */
> +#define TDCS_NOTIFY_ENABLES		0x9100000000000010
>  
>  /* TDX hypercall Leaf IDs */
>  #define TDVMCALL_MAP_GPA		0x10001
> @@ -858,6 +862,9 @@ void __init tdx_early_init(void)
>  	tdx_parse_tdinfo(&cc_mask);
>  	cc_set_mask(cc_mask);
>  
> +	/* Kernel does not use NOTIFY_ENABLES and does not need random #VEs */
> +	tdx_module_call(TDX_WR, 0, TDCS_NOTIFY_ENABLES, 0, -1ULL, NULL);
> +
>  	/*
>  	 * All bits above GPA width are reserved and kernel treats shared bit
>  	 * as flag, not as part of physical address.

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
