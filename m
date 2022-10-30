Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6474D612BA6
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 17:39:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbiJ3QjZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 12:39:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiJ3QjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 12:39:22 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F113BF1A
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 09:39:20 -0700 (PDT)
Received: from zn.tnic (p200300ea9733e745329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e745:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4603A1EC054E;
        Sun, 30 Oct 2022 17:39:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1667147959;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=BB1ePUNM1BbC8WRzI6/WKi8TDgsMIa4rj1HirQWEQTY=;
        b=Ew756vwmyB1MD/KsS+mMBW0bBwaqmgNVsa6rgfkOwxWKtbmqQonScJVZcwXO48L9czGySu
        mlhYKFLNkEhQeKmHLU3HJ6iElzkev9I2lImcrnKjBCO+sCkzUFoa51k4s7YmWSNSBlX7B1
        uSRjQiV0PcJtz1rA4CBbgwZLtXkAbiA=
Date:   Sun, 30 Oct 2022 17:39:14 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Juergen Gross <jgross@suse.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v4 16/16] x86/mtrr: simplify mtrr_ops initialization
Message-ID: <Y16osqK3kbCz8Sf3@zn.tnic>
References: <20221004081023.32402-1-jgross@suse.com>
 <20221004081023.32402-17-jgross@suse.com>
 <Y15o4o8j6zbQuaQJ@zn.tnic>
 <dbd5861a-aa12-ea4f-c076-974613fba51c@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <dbd5861a-aa12-ea4f-c076-974613fba51c@suse.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 30, 2022 at 04:05:29PM +0100, Juergen Gross wrote:
> As the specific ops variables are available for X86_32 only, this
> would require to add an "#ifdef CONFIG_X86_32" around the code block
> doing the assignments. Otherwise the build would fail.

Well, it looks like my compiler is smart enough and eliminates all that
dead code, see diff below.

I've added the asm markers "#begin" and "#end" and the resulting asm
looks like this:

# arch/x86/kernel/cpu/mtrr/mtrr.c:666:          asm volatile("#begin");
        call    __sanitizer_cov_trace_pc        #
#APP
# 666 "arch/x86/kernel/cpu/mtrr/mtrr.c" 1
        #begin
# 0 "" 2
# arch/x86/kernel/cpu/mtrr/mtrr.c:693:          asm volatile("#end");
# 693 "arch/x86/kernel/cpu/mtrr/mtrr.c" 1
        #end
# 0 "" 2
# arch/x86/kernel/cpu/mtrr/mtrr.c:630:  phys_addr = 32;
#NO_APP

which basically says that all between line 666 and 693 has been
eliminated.

I have the suspicion, though, that clang might not be that smart.

Lemme test it a bit.

---

diff --git a/arch/x86/kernel/cpu/mtrr/mtrr.c b/arch/x86/kernel/cpu/mtrr/mtrr.c
index 7ba68356c0ff..d499c83b2ad7 100644
--- a/arch/x86/kernel/cpu/mtrr/mtrr.c
+++ b/arch/x86/kernel/cpu/mtrr/mtrr.c
@@ -663,25 +663,26 @@ void __init mtrr_bp_init(void)
 			phys_addr = 32;
 		}
 	} else {
+		asm volatile("#begin");
 		switch (boot_cpu_data.x86_vendor) {
 		case X86_VENDOR_AMD:
 			if (cpu_feature_enabled(X86_FEATURE_K6_MTRR)) {
 				/* Pre-Athlon (K6) AMD CPU MTRRs */
-				mtrr_if = vendor_mtrr_ops(amd_mtrr_ops);
+				mtrr_if = &amd_mtrr_ops;
 				size_or_mask = SIZE_OR_MASK_BITS(32);
 				size_and_mask = 0;
 			}
 			break;
 		case X86_VENDOR_CENTAUR:
 			if (cpu_feature_enabled(X86_FEATURE_CENTAUR_MCR)) {
-				mtrr_if = vendor_mtrr_ops(centaur_mtrr_ops);
+				mtrr_if = &centaur_mtrr_ops;
 				size_or_mask = SIZE_OR_MASK_BITS(32);
 				size_and_mask = 0;
 			}
 			break;
 		case X86_VENDOR_CYRIX:
 			if (cpu_feature_enabled(X86_FEATURE_CYRIX_ARR)) {
-				mtrr_if = vendor_mtrr_ops(cyrix_mtrr_ops);
+				mtrr_if = &cyrix_mtrr_ops;
 				size_or_mask = SIZE_OR_MASK_BITS(32);
 				size_and_mask = 0;
 			}
@@ -689,6 +690,7 @@ void __init mtrr_bp_init(void)
 		default:
 			break;
 		}
+		asm volatile("#end");
 	}
 
 	if (mtrr_if) {
diff --git a/arch/x86/kernel/cpu/mtrr/mtrr.h b/arch/x86/kernel/cpu/mtrr/mtrr.h
index 7a7387356192..02eb5871492d 100644
--- a/arch/x86/kernel/cpu/mtrr/mtrr.h
+++ b/arch/x86/kernel/cpu/mtrr/mtrr.h
@@ -68,11 +68,6 @@ void mtrr_wrmsr(unsigned, unsigned, unsigned);
 extern const struct mtrr_ops amd_mtrr_ops;
 extern const struct mtrr_ops cyrix_mtrr_ops;
 extern const struct mtrr_ops centaur_mtrr_ops;
-#ifdef CONFIG_X86_64
-#define vendor_mtrr_ops(x) NULL
-#else
-#define vendor_mtrr_ops(x) &(x)
-#endif
 
 extern int changed_by_mtrr_cleanup;
 extern int mtrr_cleanup(unsigned address_bits);


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
