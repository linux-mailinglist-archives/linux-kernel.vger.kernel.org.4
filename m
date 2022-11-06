Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3A2A61E223
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 13:45:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbiKFMpl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 07:45:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbiKFMpj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 07:45:39 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A436634B;
        Sun,  6 Nov 2022 04:45:38 -0800 (PST)
Received: from zn.tnic (p200300ea9733e7a5329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e7a5:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B70C11EC050B;
        Sun,  6 Nov 2022 13:45:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1667738736;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=O3Plcr3YOvWsF84KnFw9R0UX3XtJkwUwzUnXUCUaHoY=;
        b=lO2T1ERQfqMhcp3K2rEZugUHLYpePRXjgR42fDDzpDUcpsfsQ/PRrawsdC7z7MAE/qjMZ9
        VTaRC8HJt7BFvpMyiz08w851BVWx9bFpFPh2/dFxtOJW1Mb+SYUEiMaNkkEiN1wfnm9RvO
        fii72rKb9IjCWouDXfCI1qqHsvUUPDg=
Date:   Sun, 6 Nov 2022 13:45:16 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Dave Hansen <dave.hansen@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        x86@kernel.org
Subject: Re: [tip: x86/urgent] x86/tdx: Prepare for using "INFO" call for a
 second purpose
Message-ID: <Y2esXPWwulendusf@zn.tnic>
References: <166734513630.7716.12952231613533508782.tip-bot2@tip-bot2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <166734513630.7716.12952231613533508782.tip-bot2@tip-bot2>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 01, 2022 at 11:25:36PM -0000, tip-bot2 for Dave Hansen wrote:
> @@ -121,7 +121,7 @@ static u64 get_cc_mask(void)
>  	 * The highest bit of a guest physical address is the "sharing" bit.
>  	 * Set it for shared pages and clear it for private pages.
>  	 */
> -	return BIT_ULL(gpa_width - 1);
> +	*cc_mask = BIT_ULL(gpa_width - 1);
>  }

I'm looking at the next patch too and I still don't see what the point
is of making it a void?

IOW, what's wrong with doing this?

---
diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index b8998cf0508a..0421cb7f3b86 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -100,11 +100,11 @@ static inline void tdx_module_call(u64 fn, u64 rcx, u64 rdx, u64 r8, u64 r9,
 		panic("TDCALL %lld failed (Buggy TDX module!)\n", fn);
 }
 
-static void tdx_parse_tdinfo(u64 *cc_mask)
+static u64 tdx_parse_tdinfo(void)
 {
 	struct tdx_module_output out;
 	unsigned int gpa_width;
-	u64 td_attr;
+	u64 td_attr, ret;
 
 	/*
 	 * TDINFO TDX module call is used to get the TD execution environment
@@ -123,7 +123,7 @@ static void tdx_parse_tdinfo(u64 *cc_mask)
 	 * can not meaningfully run without it.
 	 */
 	gpa_width = out.rcx & GENMASK(5, 0);
-	*cc_mask = BIT_ULL(gpa_width - 1);
+	ret = BIT_ULL(gpa_width - 1);
 
 	/*
 	 * The kernel can not handle #VE's when accessing normal kernel
@@ -133,6 +133,8 @@ static void tdx_parse_tdinfo(u64 *cc_mask)
 	td_attr = out.rdx;
 	if (!(td_attr & ATTR_SEPT_VE_DISABLE))
 		panic("TD misconfiguration: SEPT_VE_DISABLE attibute must be set.\n");
+
+	return ret;
 }
 
 /*
@@ -769,7 +771,7 @@ void __init tdx_early_init(void)
 	setup_force_cpu_cap(X86_FEATURE_TDX_GUEST);
 
 	cc_set_vendor(CC_VENDOR_INTEL);
-	tdx_parse_tdinfo(&cc_mask);
+	cc_mask = tdx_parse_tdinfo();
 	cc_set_mask(cc_mask);
 
 	/*

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
