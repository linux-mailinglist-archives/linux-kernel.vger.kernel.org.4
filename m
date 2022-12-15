Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C74564DF8D
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 18:19:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbiLORTK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 12:19:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbiLORTF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 12:19:05 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3C3C3D90C
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 09:19:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671124743; x=1702660743;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=u1WEeFPOHbu4SVG8amxcRl9L6dw5emIMW0tIYt+I6+M=;
  b=O2qiaYjVEBSH0p6NZAV05fACig/hRPi0CyDeVJTCsjwkFijnlvlM+A73
   QPcg7XMiOU+7qCGoRoit+zI4xfNTpU+BKQ0PmOkNz3abFLD1HLR+xBsrC
   2ACVkoDUgnQ+Oe3Oxq6/5oB8sDsBAOjp5mDmnWvTHzxz5sqcM6zN4CQxy
   2Z//+2J2S77C3BnX3tHqUKHmBNUORaG/7b0/BTFzQ7OMnGRHhufka5jJa
   D0W6jTyBNy4mlLajcfBQYTCqT+LR6kq+3XwhLoCEJ8tOK/4dJF8S+GsPu
   Pv1T5mmnlSfIlCoS8rEuAlAVsARWrXuDjKagPNSNIR8yhn8VnnE3xR+b7
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10562"; a="316383921"
X-IronPort-AV: E=Sophos;i="5.96,248,1665471600"; 
   d="scan'208";a="316383921"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2022 09:13:03 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10562"; a="681962547"
X-IronPort-AV: E=Sophos;i="5.96,248,1665471600"; 
   d="scan'208";a="681962547"
Received: from milawils-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.251.217.73])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2022 09:12:58 -0800
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 45FEC109448; Thu, 15 Dec 2022 20:12:54 +0300 (+03)
Date:   Thu, 15 Dec 2022 20:12:54 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Elena Reshetova <elena.reshetova@intel.com>, x86@kernel.org,
        linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] x86/tdx: Use ReportFatalError to report missing
 SEPT_VE_DISABLE
Message-ID: <20221215171254.3v4maexfhkdnbfk2@box.shutemov.name>
References: <20221209132524.20200-1-kirill.shutemov@linux.intel.com>
 <20221209132524.20200-3-kirill.shutemov@linux.intel.com>
 <3121847d-d334-67fc-43d8-0670c08c64b6@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3121847d-d334-67fc-43d8-0670c08c64b6@intel.com>
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 13, 2022 at 03:06:07PM -0800, Dave Hansen wrote:
> On 12/9/22 05:25, Kirill A. Shutemov wrote:
> > The check for SEPT_VE_DISABLE happens early in the kernel boot where
> > earlyprintk is not yet functional. Kernel successfully detect broken
> > TD configuration and stops the kernel with panic(), but it cannot
> > communicate the reason to the user.
> 
> Linux TDX guests require that the SEPT_VE_DISABLE "attribute" be set.
> If it is not set, the kernel is theoretically required to handle
> exceptions anywhere that kernel memory is accessed, including places
> like NMI handlers and in the syscall entry gap.
> 
> Rather than even try to handle these exceptions, the kernel refuses to
> run if SEPT_VE_DISABLE is unset.
> 
> However, the SEPT_VE_DISABLE detection and refusal code happens very
> early in boot, even before earlyprintk runs.  Calling panic() will
> effectively just hang the system.
> 
> Instead, call a TDX-specific panic() function.  This makes a very simple
> TDVMCALL which gets a short error string out to the hypervisor without
> any console infrastructure.
> 
> --
> 
> Is that better?

Yes, thank you.

> Also, are you sure we want to do this?  Is there any way to do this
> inside of panic() itself to get panic() itself to call tdx_panic() and
> get a short error message out to the hypervisor?
> 
> Getting *all* users of panic this magic ability would be a lot better
> than giving it to one call-site of panic().
> 
> I'm all for making the panic() path as short and simple as possible, but
> it would be nice if this fancy hypercall would get used in more than one
> spot.

Well, I don't see an obvious way to integrate this into panic().

There is panic_notifier_list and it kinda/sorta works, see the patch
below.

But it breaks panic_notifier_list contract: the callback will never return
and no other callback will be able to do their stuff. panic_timeout is
also broken.

So ReportFatalError() is no good for the task. And I don't have anything
else :/

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index 83ca9a7f0b75..81f9a964dc1f 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -7,6 +7,7 @@
 #include <linux/cpufeature.h>
 #include <linux/export.h>
 #include <linux/io.h>
+#include <linux/panic_notifier.h>
 #include <asm/coco.h>
 #include <asm/tdx.h>
 #include <asm/vmx.h>
@@ -146,8 +147,10 @@ int tdx_mcall_get_report0(u8 *reportdata, u8 *tdreport)
 }
 EXPORT_SYMBOL_GPL(tdx_mcall_get_report0);
 
-static void __noreturn tdx_panic(const char *msg)
+static int tdx_panic(struct notifier_block *this,
+				 unsigned long event, void *ptr)
 {
+	const char *msg = ptr;
 	struct tdx_hypercall_args args = {
 		.r10 = TDX_HYPERCALL_STANDARD,
 		.r11 = TDVMCALL_REPORT_FATAL_ERROR,
@@ -219,7 +222,7 @@ static void tdx_parse_tdinfo(u64 *cc_mask)
 		if (td_attr & ATTR_DEBUG)
 			pr_warn("%s\n", msg);
 		else
-			tdx_panic(msg);
+			panic(msg);
 	}
 }
 
@@ -851,6 +854,10 @@ static bool tdx_enc_status_changed(unsigned long vaddr, int numpages, bool enc)
 	return true;
 }
 
+static struct notifier_block panic_block = {
+	.notifier_call = tdx_panic,
+};
+
 void __init tdx_early_init(void)
 {
 	u64 cc_mask;
@@ -863,6 +870,7 @@ void __init tdx_early_init(void)
 
 	setup_force_cpu_cap(X86_FEATURE_TDX_GUEST);
 
+	atomic_notifier_chain_register(&panic_notifier_list, &panic_block);
 	cc_set_vendor(CC_VENDOR_INTEL);
 	tdx_parse_tdinfo(&cc_mask);
 	cc_set_mask(cc_mask);
-- 
  Kiryl Shutsemau / Kirill A. Shutemov
