Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BCCB6D2EA1
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Apr 2023 08:37:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233327AbjDAGhP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Apr 2023 02:37:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233283AbjDAGhK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Apr 2023 02:37:10 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DBA11D86D
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 23:37:08 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D459421A1E;
        Sat,  1 Apr 2023 06:37:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1680331026; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7+r4owlpRl68SnHTZez3F/1Q0HJdHfyMYOiLaES+G08=;
        b=IeBqVbmIMhtC5DMJs1CgV3RogvScaXZSq6C0oCoJUDt5DzNA78qzAcxx+++u6Jic+OWjMf
        ccxznvwrrJc41E+ot9pBd551crYP+rPHKnjKc6DoRVG55r8D7+H7NEFWXB+AY571usGbuN
        tnGZH9Qvi4hzt1Y0V63R1R+2jZinsto=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 92D9B134FB;
        Sat,  1 Apr 2023 06:37:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id KxKEIhLRJ2QcdwAAMHmgww
        (envelope-from <jgross@suse.com>); Sat, 01 Apr 2023 06:37:06 +0000
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Michael Kelley <mikelley@microsoft.com>
Subject: [PATCH v5 02/15] x86/mtrr: optimize mtrr_calc_physbits()
Date:   Sat,  1 Apr 2023 08:36:39 +0200
Message-Id: <20230401063652.23522-3-jgross@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230401063652.23522-1-jgross@suse.com>
References: <20230401063652.23522-1-jgross@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Optimize mtrr_calc_physbits() for better readability.

Drop a stale comment, as reality has made it obsolete.

  [ bp:
   - s/mtrr/MTRR/
   - s/boot_cpu_has/cpu_feature_enabled/
   - use GENMASK_ULL
   - simplify. ]

Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Tested-by: Michael Kelley <mikelley@microsoft.com>
---
V3:
- new patch, split off from previous patch (Boris Petkov)
V5:
- add some modifications by Boris Petkov
---
 arch/x86/kernel/cpu/mtrr/mtrr.c | 27 +++++++--------------------
 1 file changed, 7 insertions(+), 20 deletions(-)

diff --git a/arch/x86/kernel/cpu/mtrr/mtrr.c b/arch/x86/kernel/cpu/mtrr/mtrr.c
index 8310bdb111d0..ce0b82209ad3 100644
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
 
+	size_or_mask = ~GENMASK_ULL(phys_addr - PAGE_SHIFT - 1, 0);
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
2.35.3

