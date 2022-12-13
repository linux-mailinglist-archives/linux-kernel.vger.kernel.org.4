Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C622A64C03B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 00:06:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236902AbiLMXG2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 18:06:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236928AbiLMXGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 18:06:23 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0163B1A3B3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 15:06:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670972782; x=1702508782;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=CCUnzEyGEKLvz2QKxpZRU55Orhdnz4fyaad5thE9it0=;
  b=jY1seP8XoK0hFfcgn2oF132Cu1pn/JxRLvgQTltR5WPTI6zg/i5GsZKB
   Mjy8eTw8taXvg9b3zDuIRx4q9iOG9adA/6UoGTcB/0dcvELGoFGYYsZgO
   XkJpb/U2sitVsr34nS9LslHgPdi2UYn4UNb7KPuF+Bm7b8bqCmvzeS47K
   MLROzDh2NpKrzfcC5VKCXG93jVC6unUuAVEW9W9On03+nlqGyPcRl7uMc
   1UD3xS8gyo+jbDJ8sweOTJBYHt1QeYfGjIwKBH0EGMXtJvfWzdoKBwNVQ
   vqhkMPG34NKPUFlTH/M1PJsyEA+Mt4LDjwadlNytXjONyLrOhxSGw3p9d
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10560"; a="305898784"
X-IronPort-AV: E=Sophos;i="5.96,242,1665471600"; 
   d="scan'208";a="305898784"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2022 15:06:22 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10560"; a="648731771"
X-IronPort-AV: E=Sophos;i="5.96,242,1665471600"; 
   d="scan'208";a="648731771"
Received: from snjones-mobl1.amr.corp.intel.com (HELO [10.212.218.27]) ([10.212.218.27])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2022 15:06:07 -0800
Message-ID: <3121847d-d334-67fc-43d8-0670c08c64b6@intel.com>
Date:   Tue, 13 Dec 2022 15:06:07 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 2/4] x86/tdx: Use ReportFatalError to report missing
 SEPT_VE_DISABLE
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
 <20221209132524.20200-3-kirill.shutemov@linux.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20221209132524.20200-3-kirill.shutemov@linux.intel.com>
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
> The check for SEPT_VE_DISABLE happens early in the kernel boot where
> earlyprintk is not yet functional. Kernel successfully detect broken
> TD configuration and stops the kernel with panic(), but it cannot
> communicate the reason to the user.

Linux TDX guests require that the SEPT_VE_DISABLE "attribute" be set.
If it is not set, the kernel is theoretically required to handle
exceptions anywhere that kernel memory is accessed, including places
like NMI handlers and in the syscall entry gap.

Rather than even try to handle these exceptions, the kernel refuses to
run if SEPT_VE_DISABLE is unset.

However, the SEPT_VE_DISABLE detection and refusal code happens very
early in boot, even before earlyprintk runs.  Calling panic() will
effectively just hang the system.

Instead, call a TDX-specific panic() function.  This makes a very simple
TDVMCALL which gets a short error string out to the hypervisor without
any console infrastructure.

--

Is that better?

Also, are you sure we want to do this?  Is there any way to do this
inside of panic() itself to get panic() itself to call tdx_panic() and
get a short error message out to the hypervisor?

Getting *all* users of panic this magic ability would be a lot better
than giving it to one call-site of panic().

I'm all for making the panic() path as short and simple as possible, but
it would be nice if this fancy hypercall would get used in more than one
spot.

> Use TDG.VP.VMCALL<ReportFatalError> to report the error. The hypercall
> can encode message up to 64 bytes in eight registers.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> ---
>  arch/x86/coco/tdx/tdx.c | 38 +++++++++++++++++++++++++++++++++++++-
>  1 file changed, 37 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
> index cfd4c95b9f04..8ad04d101270 100644
> --- a/arch/x86/coco/tdx/tdx.c
> +++ b/arch/x86/coco/tdx/tdx.c
> @@ -22,6 +22,7 @@
>  
>  /* TDX hypercall Leaf IDs */
>  #define TDVMCALL_MAP_GPA		0x10001
> +#define TDVMCALL_REPORT_FATAL_ERROR	0x10003
>  
>  /* MMIO direction */
>  #define EPT_READ	0
> @@ -140,6 +141,41 @@ int tdx_mcall_get_report0(u8 *reportdata, u8 *tdreport)
>  }
>  EXPORT_SYMBOL_GPL(tdx_mcall_get_report0);
>  
> +static void __noreturn tdx_panic(const char *msg)
> +{
> +	struct tdx_hypercall_args args = {
> +		.r10 = TDX_HYPERCALL_STANDARD,
> +		.r11 = TDVMCALL_REPORT_FATAL_ERROR,
> +		.r12 = 0, /* Error code: 0 is Panic */
> +	};
> +	union {
> +		/* Define register order according to the GHCI */
> +		struct { u64 r14, r15, rbx, rdi, rsi, r8, r9, rdx; };
> +
> +		char str[64];
> +	} message;
> +
> +	/* VMM assumes '\0' in byte 65, if the message took all 64 bytes */
> +	strncpy(message.str, msg, 64);
> +
> +	args.r8  = message.r8;
> +	args.r9  = message.r9;
> +	args.r14 = message.r14;
> +	args.r15 = message.r15;
> +	args.rdi = message.rdi;
> +	args.rsi = message.rsi;
> +	args.rbx = message.rbx;
> +	args.rdx = message.rdx;

I dunno.  Is that struct/union better, or would something like this be
more readable:

	args.r8  = *(u64 *)&message[48];
	args.r9  = *(u64 *)&message[56];

and just hard-code the offsets.

> +	/*
> +	 * Keep calling the hypercall in case VMM did not terminated

							terminate^

> +	 * the TD as it must.
> +	 */
> +	while (1) {
> +		__tdx_hypercall(&args, 0);
> +	}
> +}
> +
>  static void tdx_parse_tdinfo(u64 *cc_mask)
>  {
>  	struct tdx_module_output out;
> @@ -172,7 +208,7 @@ static void tdx_parse_tdinfo(u64 *cc_mask)
>  	 */
>  	td_attr = out.rdx;
>  	if (!(td_attr & ATTR_SEPT_VE_DISABLE))
> -		panic("TD misconfiguration: SEPT_VE_DISABLE attibute must be set.\n");
> +		tdx_panic("TD misconfiguration: SEPT_VE_DISABLE attribute must be set.");
>  }

Would it be worth making it more clear when the message is truncated?
Maybe something like:

	if (strlen(msg) > 64) {
		len = 64
		strncpy(&msg[61], "...", 3);
	}

I'm sure I have five off-by-one bugs in there, but you get the idea.
Can we stick a "..." at the end of things that get truncated?
