Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A5B66C1257
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 13:52:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231605AbjCTMwe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 08:52:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231683AbjCTMwP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 08:52:15 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 736BA193DA
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 05:50:44 -0700 (PDT)
Received: from zn.tnic (p5de8e687.dip0.t-ipconnect.de [93.232.230.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C02261EC067D;
        Mon, 20 Mar 2023 13:50:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1679316642;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Y3bgQS2Tn8xizogHkHYu7p9PoAxlYTtZQNfsQpJFTBs=;
        b=PMZ9WwwweHCn4Nx3wAK1OonDbxDUbtCmsPMGctSb2xSh00Vk7JuOZU0YilV8dtEqtlBwd1
        wvUU4U9sO3K0Zu8j0YP1a5PxIzWbhPy2Zbb1fMkmZ0yUUt2ZBcOqq36FxgY0thQBHxyMSo
        /kZOkW6vXzBe6IkoVsayxGILmQQqWBI=
Date:   Mon, 20 Mar 2023 13:50:38 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Juergen Gross <jgross@suse.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v4 02/12] x86/mtrr: optimize mtrr_calc_physbits()
Message-ID: <20230320125038.GEZBhWnkON79eAbS04@fat_crate.local>
References: <20230306163425.8324-1-jgross@suse.com>
 <20230306163425.8324-3-jgross@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230306163425.8324-3-jgross@suse.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 06, 2023 at 05:34:15PM +0100, Juergen Gross wrote:
> Optimize mtrr_calc_physbits() for better readability.
> 
> Drop a stale comment, as reality has made it obsolete.
> 
> Signed-off-by: Juergen Gross <jgross@suse.com>
> ---
> V3:
> - new patch, split off from previous patch (Boris Petkov)
> ---
>  arch/x86/kernel/cpu/mtrr/mtrr.c | 19 +++----------------
>  1 file changed, 3 insertions(+), 16 deletions(-)

Optimize some more:

---
From: Juergen Gross <jgross@suse.com>
Date: Mon, 6 Mar 2023 17:34:15 +0100
Subject: [PATCH] x86/mtrr: Optimize mtrr_calc_physbits()

Optimize mtrr_calc_physbits() for better readability.

Drop a stale comment, as reality has made it obsolete.

  [ bp:
   - s/mtrr/MTRR/
   - s/boot_cpu_has/cpu_feature_enabled/
   - use GENMASK_ULL
   - simplify. ]

Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20230306163425.8324-3-jgross@suse.com
---
 arch/x86/kernel/cpu/mtrr/mtrr.c | 27 +++++++--------------------
 1 file changed, 7 insertions(+), 20 deletions(-)

diff --git a/arch/x86/kernel/cpu/mtrr/mtrr.c b/arch/x86/kernel/cpu/mtrr/mtrr.c
index 8310bdb111d0..deb22e989105 100644
--- a/arch/x86/kernel/cpu/mtrr/mtrr.c
+++ b/arch/x86/kernel/cpu/mtrr/mtrr.c
@@ -619,8 +619,6 @@ static struct syscore_ops mtrr_syscore_ops = {
 
 int __initdata changed_by_mtrr_cleanup;
 
-#define SIZE_OR_MASK_BITS(n)  (~((1ULL << ((n) - PAGE_SHIFT)) - 1))
-
 static unsigned int __init mtrr_calc_physbits(bool generic)
 {
 	unsigned int phys_addr;
@@ -628,15 +626,8 @@ static unsigned int __init mtrr_calc_physbits(bool generic)
 	phys_addr = 32;
 
 	if (generic) {
-		size_or_mask = SIZE_OR_MASK_BITS(36);
-		size_and_mask = 0x00f00000;
 		phys_addr = 36;
 
-		/*
-		 * This is an AMD specific MSR, but we assume(hope?) that
-		 * Intel will implement it too when they extend the address
-		 * bus of the Xeon.
-		 */
 		if (cpuid_eax(0x80000000) >= 0x80000008) {
 			phys_addr = cpuid_eax(0x80000008) & 0xff;
 			/* CPUID workaround for Intel 0F33/0F34 CPU */
@@ -647,41 +638,37 @@ static unsigned int __init mtrr_calc_physbits(bool generic)
 			     boot_cpu_data.x86_stepping == 0x4))
 				phys_addr = 36;
 
-			size_or_mask = SIZE_OR_MASK_BITS(phys_addr);
-			size_and_mask = ~size_or_mask & 0xfffff00000ULL;
 		} else if (boot_cpu_data.x86_vendor == X86_VENDOR_CENTAUR &&
 			   boot_cpu_data.x86 == 6) {
 			/*
 			 * VIA C* family have Intel style MTRRs,
 			 * but don't support PAE
 			 */
-			size_or_mask = SIZE_OR_MASK_BITS(32);
-			size_and_mask = 0;
 			phys_addr = 32;
 		}
-	} else {
-		size_or_mask = SIZE_OR_MASK_BITS(32);
-		size_and_mask = 0;
 	}
 
+	size_or_mask  = ~GENMASK_ULL(phys_addr - PAGE_SHIFT, 0);
+	size_and_mask = ~size_or_mask & GENMASK_ULL(39, 20);
+
 	return phys_addr;
 }
 
 /**
- * mtrr_bp_init - initialize mtrrs on the boot CPU
+ * mtrr_bp_init - initialize MTRRs on the boot CPU
  *
  * This needs to be called early; before any of the other CPUs are
  * initialized (i.e. before smp_init()).
- *
  */
 void __init mtrr_bp_init(void)
 {
+	bool generic_mtrrs = cpu_feature_enabled(X86_FEATURE_MTRR);
 	const char *why = "(not available)";
 	unsigned int phys_addr;
 
-	phys_addr = mtrr_calc_physbits(boot_cpu_has(X86_FEATURE_MTRR));
+	phys_addr = mtrr_calc_physbits(generic_mtrrs);
 
-	if (boot_cpu_has(X86_FEATURE_MTRR)) {
+	if (generic_mtrrs) {
 		mtrr_if = &generic_mtrr_ops;
 	} else {
 		switch (boot_cpu_data.x86_vendor) {
-- 
2.35.1

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
