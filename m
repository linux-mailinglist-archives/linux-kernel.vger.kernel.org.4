Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7951164DDF4
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 16:41:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbiLOPlY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 10:41:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbiLOPlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 10:41:20 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01EF4EBD
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 07:41:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671118880; x=1702654880;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2spTJNDqOA3JU359JYb+gDTvNuuQDCTXFiO+1qLec6I=;
  b=cG/dSPSsYpxfchlazAV25jSZggydNWxLUAdFd53q7TSy1n71PImSseCD
   PIyvwMT5v2H9nRlPKqsXOXwiFqf8ylB40Nua2Einzbk4+rRxjZ5PiCZDI
   PRT7uuaVdSj4p2G1qKHDAkMvUHvwE1cprBz/aiLDKivUDV4CNzVeL/xpg
   qFJODWtlEVIeGjnqzFeUxlwQFO4+726UsDWPfoEQKdZ1Ja1Io5o9d83es
   NQ5aA1rYUGoDb2MkWoT+817/eimdxVkYZSC/c0XdBOvIzx02eJN4h7UKw
   yRFj/9NAqhDsjFuFiPBjtbNwf36G6i2ZFWJSNcZMOSn8ZM2GsXTbXiyvS
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10562"; a="319872883"
X-IronPort-AV: E=Sophos;i="5.96,247,1665471600"; 
   d="scan'208";a="319872883"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2022 07:40:23 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10562"; a="642962422"
X-IronPort-AV: E=Sophos;i="5.96,247,1665471600"; 
   d="scan'208";a="642962422"
Received: from milawils-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.251.217.73])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2022 07:40:21 -0800
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 48A1E109448; Thu, 15 Dec 2022 18:40:18 +0300 (+03)
Date:   Thu, 15 Dec 2022 18:40:18 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Elena Reshetova <elena.reshetova@intel.com>, x86@kernel.org,
        linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] x86/tdx: Relax SEPT_VE_DISABLE check for debug TD
Message-ID: <20221215154018.dyoce56wfpvlihxt@box.shutemov.name>
References: <20221209132524.20200-1-kirill.shutemov@linux.intel.com>
 <20221209132524.20200-4-kirill.shutemov@linux.intel.com>
 <4e595e75-2c5f-e114-9c2c-37689870639c@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4e595e75-2c5f-e114-9c2c-37689870639c@intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 13, 2022 at 03:13:43PM -0800, Dave Hansen wrote:
> On 12/9/22 05:25, Kirill A. Shutemov wrote:
> > SEPT_VE_DISABLE check is required to keep the TD protected from VMM
> > attacks, but it makes harder to debug guest kernel bugs. If guest
> > touches unaccepted memory the TD will get terminated without any
> > traces on what has happened.
> 
> This is a bit sparse.
> 
> --
> 
> A "SEPT #VE" occurs when a TDX guest touches memory that is not properly
> mapped into the "secure EPT".  This can be the result of hypervisor
> attacks or bugs, *OR* guest bugs.  Most notably, buggy guests might
> touch unaccepted memory for lots of different memory safety bugs like
> buffer overflows.
> 
> TDX guests do not want to continue in the face of hypervisor attacks or
> hypervisor bugs.  They want to terminate as fast and safely as possible.
>  SEPT_VE_DISABLE ensures that TDX guests *can't* continue in the face of
> these kinds of issues.
> 
> But, that causes a problem.  TDX guests that can't continue can't spit
> out oopses or other debugging info.  In essence SEPT_VE_DISABLE=1 guests
> are not debuggable.  That's a problem.
> 
> --
> 
> Eh?

Thanks!

> > Relax the SEPT_VE_DISABLE check to warning on debug TD and panic() in
> > the #VE handler on EPT-violation on private memory. It will produce
> > useful backtrace.
> > 
> > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > ---
> >  arch/x86/coco/tdx/tdx.c | 14 ++++++++++++--
> >  1 file changed, 12 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
> > index 8ad04d101270..0e47846ff8ff 100644
> > --- a/arch/x86/coco/tdx/tdx.c
> > +++ b/arch/x86/coco/tdx/tdx.c
> > @@ -38,6 +38,7 @@
> >  #define VE_GET_PORT_NUM(e)	((e) >> 16)
> >  #define VE_IS_IO_STRING(e)	((e) & BIT(4))
> >  
> > +#define ATTR_DEBUG		BIT(0)
> >  #define ATTR_SEPT_VE_DISABLE	BIT(28)
> >  
> >  /* TDX Module call error codes */
> > @@ -207,8 +208,15 @@ static void tdx_parse_tdinfo(u64 *cc_mask)
> >  	 * TD-private memory.  Only VMM-shared memory (MMIO) will #VE.
> >  	 */
> >  	td_attr = out.rdx;
> > -	if (!(td_attr & ATTR_SEPT_VE_DISABLE))
> > -		tdx_panic("TD misconfiguration: SEPT_VE_DISABLE attribute must be set.");
> > +	if (!(td_attr & ATTR_SEPT_VE_DISABLE)) {
> > +		const char *msg = "TD misconfiguration: SEPT_VE_DISABLE attribute must be set.";
> > +
> > +		/* Relax SEPT_VE_DISABLE check for debug TD. */
> > +		if (td_attr & ATTR_DEBUG)
> > +			pr_warn("%s\n", msg);
> > +		else
> > +			tdx_panic(msg);
> > +	}
> >  }
> >  
> >  /*
> > @@ -682,6 +690,8 @@ static int virt_exception_kernel(struct pt_regs *regs, struct ve_info *ve)
> >  	case EXIT_REASON_CPUID:
> >  		return handle_cpuid(regs, ve);
> >  	case EXIT_REASON_EPT_VIOLATION:
> > +		if (ve->gpa != cc_mkdec(ve->gpa))
> > +			panic("Unexpected EPT-violation on private memory.");
> 
> What's the cc_mkdec() doing?

Checks if the GPA is private. I will move it to helper. Like this:

static inline bool is_private_gpa(u64 gpa)
{
	return gpa == cc_mkenc(gpa);
}

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
