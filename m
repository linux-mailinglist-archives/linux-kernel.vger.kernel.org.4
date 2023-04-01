Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8E056D2E9C
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Apr 2023 08:37:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233257AbjDAGhI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Apr 2023 02:37:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233230AbjDAGhG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Apr 2023 02:37:06 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90EC51E73B
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 23:37:02 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 324471FD78;
        Sat,  1 Apr 2023 06:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1680331021; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gsM8JG+0YjKpprMSP0WcpLzh0EmtHSX+OEFp6YWu4DY=;
        b=g8DLE9Ug7PYEkqHVYmdV+X8Cg3YN7OhOO2THjBCiMltqzaduccgavEz5vuQLMoxChKwp7O
        qiXUoviI00yYbavx/BgEsUy+5Y3Kx9swildIQ6yxKHyyaa7PyZiTk9m953mG3IWXpviIqP
        GMlpfHJbaMPFJgIH7WxAVxFFzSG57rc=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E29F9134FB;
        Sat,  1 Apr 2023 06:37:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 0IT8NQzRJ2QSdwAAMHmgww
        (envelope-from <jgross@suse.com>); Sat, 01 Apr 2023 06:37:00 +0000
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Michael Kelley <mikelley@microsoft.com>
Subject: [PATCH v5 01/15] x86/mtrr: split off physical address size calculation
Date:   Sat,  1 Apr 2023 08:36:38 +0200
Message-Id: <20230401063652.23522-2-jgross@suse.com>
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

Move the calculation of the physical address size in mtrr_bp_init()
into a helper function. This will be needed later.

Do only the pure code movement without optimizing it.

Signed-off-by: Juergen Gross <jgross@suse.com>
Tested-by: Michael Kelley <mikelley@microsoft.com>
---
V2:
- new patch
V3:
- only move code, split off optimizations (Boris Petkov)
---
 arch/x86/kernel/cpu/mtrr/mtrr.c | 57 ++++++++++++++++++---------------
 1 file changed, 32 insertions(+), 25 deletions(-)

diff --git a/arch/x86/kernel/cpu/mtrr/mtrr.c b/arch/x86/kernel/cpu/mtrr/mtrr.c
index 783f3210d582..8310bdb111d0 100644
--- a/arch/x86/kernel/cpu/mtrr/mtrr.c
+++ b/arch/x86/kernel/cpu/mtrr/mtrr.c
@@ -620,22 +620,14 @@ static struct syscore_ops mtrr_syscore_ops = {
 int __initdata changed_by_mtrr_cleanup;
 
 #define SIZE_OR_MASK_BITS(n)  (~((1ULL << ((n) - PAGE_SHIFT)) - 1))
-/**
- * mtrr_bp_init - initialize mtrrs on the boot CPU
- *
- * This needs to be called early; before any of the other CPUs are
- * initialized (i.e. before smp_init()).
- *
- */
-void __init mtrr_bp_init(void)
+
+static unsigned int __init mtrr_calc_physbits(bool generic)
 {
-	const char *why = "(not available)";
-	u32 phys_addr;
+	unsigned int phys_addr;
 
 	phys_addr = 32;
 
-	if (boot_cpu_has(X86_FEATURE_MTRR)) {
-		mtrr_if = &generic_mtrr_ops;
+	if (generic) {
 		size_or_mask = SIZE_OR_MASK_BITS(36);
 		size_and_mask = 0x00f00000;
 		phys_addr = 36;
@@ -667,29 +659,44 @@ void __init mtrr_bp_init(void)
 			size_and_mask = 0;
 			phys_addr = 32;
 		}
+	} else {
+		size_or_mask = SIZE_OR_MASK_BITS(32);
+		size_and_mask = 0;
+	}
+
+	return phys_addr;
+}
+
+/**
+ * mtrr_bp_init - initialize mtrrs on the boot CPU
+ *
+ * This needs to be called early; before any of the other CPUs are
+ * initialized (i.e. before smp_init()).
+ *
+ */
+void __init mtrr_bp_init(void)
+{
+	const char *why = "(not available)";
+	unsigned int phys_addr;
+
+	phys_addr = mtrr_calc_physbits(boot_cpu_has(X86_FEATURE_MTRR));
+
+	if (boot_cpu_has(X86_FEATURE_MTRR)) {
+		mtrr_if = &generic_mtrr_ops;
 	} else {
 		switch (boot_cpu_data.x86_vendor) {
 		case X86_VENDOR_AMD:
-			if (cpu_feature_enabled(X86_FEATURE_K6_MTRR)) {
-				/* Pre-Athlon (K6) AMD CPU MTRRs */
+			/* Pre-Athlon (K6) AMD CPU MTRRs */
+			if (cpu_feature_enabled(X86_FEATURE_K6_MTRR))
 				mtrr_if = &amd_mtrr_ops;
-				size_or_mask = SIZE_OR_MASK_BITS(32);
-				size_and_mask = 0;
-			}
 			break;
 		case X86_VENDOR_CENTAUR:
-			if (cpu_feature_enabled(X86_FEATURE_CENTAUR_MCR)) {
+			if (cpu_feature_enabled(X86_FEATURE_CENTAUR_MCR))
 				mtrr_if = &centaur_mtrr_ops;
-				size_or_mask = SIZE_OR_MASK_BITS(32);
-				size_and_mask = 0;
-			}
 			break;
 		case X86_VENDOR_CYRIX:
-			if (cpu_feature_enabled(X86_FEATURE_CYRIX_ARR)) {
+			if (cpu_feature_enabled(X86_FEATURE_CYRIX_ARR))
 				mtrr_if = &cyrix_mtrr_ops;
-				size_or_mask = SIZE_OR_MASK_BITS(32);
-				size_and_mask = 0;
-			}
 			break;
 		default:
 			break;
-- 
2.35.3

