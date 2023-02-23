Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3E2B6A04E2
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 10:33:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233975AbjBWJdF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 04:33:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233982AbjBWJc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 04:32:58 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 477D41BC0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 01:32:53 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 80A3A2092A;
        Thu, 23 Feb 2023 09:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1677144772; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wdZqXElp1B5EQPu6xSmwn38A5NK5TNGdQEx7TILYZLE=;
        b=i8/NqxQ5yCEFskkrBBCpH1p4ynIukWGL10RQLP/QPzpaVhlTsy+Djzn5BgDurkceiTgsbm
        CuG82f2b/rIoG7eQfFSqcJUM1s7desrO84grwQPuDTrMxMe0obqsaDdPpOLt8fgHu0hgLj
        7NeiQc5cmZzKHEiEcUO+upMMN3nzSjM=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4945213928;
        Thu, 23 Feb 2023 09:32:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 63WwEMQy92NqbAAAMHmgww
        (envelope-from <jgross@suse.com>); Thu, 23 Feb 2023 09:32:52 +0000
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v3 01/12] x86/mtrr: split off physical address size calculation
Date:   Thu, 23 Feb 2023 10:32:32 +0100
Message-Id: <20230223093243.1180-2-jgross@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230223093243.1180-1-jgross@suse.com>
References: <20230223093243.1180-1-jgross@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the calculation of the physical address size in mtrr_bp_init()
into a helper function. This will be needed later.

Do only the pure code movement without optimizing it.

Signed-off-by: Juergen Gross <jgross@suse.com>
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

