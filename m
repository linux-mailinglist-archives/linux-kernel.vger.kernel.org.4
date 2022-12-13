Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B0FF64C053
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 00:13:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236959AbiLMXNu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 18:13:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236962AbiLMXNq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 18:13:46 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56BCFBF59
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 15:13:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670973225; x=1702509225;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=bhHTeRftPavsWtwdAURnlzeya5sIPgv+TpvVOQO96to=;
  b=GkUye/dkfXy5LnPIuBncK8lD9i/173pR+XFul5kptYRPGiviJgaA93Yk
   eQaXCLGe3GMiHGLUrQM7SLss2AFaMVd002z8BV3qxygzu/qHij50EHdw/
   Fnx9opbhNZw39f52hjwQqTnE7rVH/M8wepcKDY0W7agwkkJC1ZcapOEuc
   wzDgZg/RSACOYBglk6KwxP1cIeV8jgeHfsz+ZQbY77qmCOq6rAsw1c/o3
   8nUUq7mMfFxr6jCc9AAccuF7QP8ulGDzqxEbEgBnT8oXUMpRS+CqTg5xd
   uMve5bjTCSYGNM6M6XxClEcLHoZeEBTUT/aOIkF2pS8L6LFUNXOGDXVvR
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10560"; a="305900709"
X-IronPort-AV: E=Sophos;i="5.96,242,1665471600"; 
   d="scan'208";a="305900709"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2022 15:13:44 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10560"; a="791106051"
X-IronPort-AV: E=Sophos;i="5.96,242,1665471600"; 
   d="scan'208";a="791106051"
Received: from snjones-mobl1.amr.corp.intel.com (HELO [10.212.218.27]) ([10.212.218.27])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2022 15:13:43 -0800
Message-ID: <4e595e75-2c5f-e114-9c2c-37689870639c@intel.com>
Date:   Tue, 13 Dec 2022 15:13:43 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 3/4] x86/tdx: Relax SEPT_VE_DISABLE check for debug TD
Content-Language: en-US
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>
Cc:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Elena Reshetova <elena.reshetova@intel.com>, x86@kernel.org,
        linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20221209132524.20200-1-kirill.shutemov@linux.intel.com>
 <20221209132524.20200-4-kirill.shutemov@linux.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20221209132524.20200-4-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/9/22 05:25, Kirill A. Shutemov wrote:
> SEPT_VE_DISABLE check is required to keep the TD protected from VMM
> attacks, but it makes harder to debug guest kernel bugs. If guest
> touches unaccepted memory the TD will get terminated without any
> traces on what has happened.

This is a bit sparse.

--

A "SEPT #VE" occurs when a TDX guest touches memory that is not properly
mapped into the "secure EPT".  This can be the result of hypervisor
attacks or bugs, *OR* guest bugs.  Most notably, buggy guests might
touch unaccepted memory for lots of different memory safety bugs like
buffer overflows.

TDX guests do not want to continue in the face of hypervisor attacks or
hypervisor bugs.  They want to terminate as fast and safely as possible.
 SEPT_VE_DISABLE ensures that TDX guests *can't* continue in the face of
these kinds of issues.

But, that causes a problem.  TDX guests that can't continue can't spit
out oopses or other debugging info.  In essence SEPT_VE_DISABLE=1 guests
are not debuggable.  That's a problem.

--

Eh?

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

What's the cc_mkdec() doing?

