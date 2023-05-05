Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 237E56F8282
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 14:03:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232055AbjEEMDm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 08:03:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232052AbjEEMDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 08:03:40 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37C9A1A606
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 05:03:36 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id DB9941FEC8;
        Fri,  5 May 2023 12:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1683288214; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=EV1vWLr09sbNSmPSMG0i9gGj4MlwFYBMGWKaSEkiid0=;
        b=XusMd8M+t2W/paO3pJK9pScSCGlT8XC5KyAt58tirorIatbsV186Hodg9foq8ePCIaQ5+F
        hewGJ8pMtAEVl1b3+vt60tmT66m7XXSkMeKp+Z+wmicw/HYHqPgdaCFYu36e6HMoDA16si
        LHS+nCgwDsEc+Z+LV1PaMYn9KI9No8I=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8FA5F13513;
        Fri,  5 May 2023 12:03:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id BgqfIJbwVGQpKwAAMHmgww
        (envelope-from <nik.borisov@suse.com>); Fri, 05 May 2023 12:03:34 +0000
From:   Nikolay Borisov <nik.borisov@suse.com>
To:     kirill.shutemov@linux.intel.com
Cc:     dave.hansen@linux.intel.com, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Nikolay Borisov <nik.borisov@suse.com>
Subject: [PATCH] x86/tdx: Wrap r11 argument of decompression hypercall with hcall_func
Date:   Fri,  5 May 2023 15:03:32 +0300
Message-Id: <20230505120332.1429957-1-nik.borisov@suse.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This just unifies the decompression  tdx-related code with the rest
of the code which invokes tdx hypercalls. No functional changes.

Signed-off-by: Nikolay Borisov <nik.borisov@suse.com>
---
 arch/x86/boot/compressed/tdx.c    |  4 ++--
 arch/x86/coco/tdx/tdx.c           | 11 -----------
 arch/x86/include/asm/shared/tdx.h | 11 +++++++++++
 3 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/x86/boot/compressed/tdx.c b/arch/x86/boot/compressed/tdx.c
index 2d81d3cc72a1..8841b945a1e2 100644
--- a/arch/x86/boot/compressed/tdx.c
+++ b/arch/x86/boot/compressed/tdx.c
@@ -20,7 +20,7 @@ static inline unsigned int tdx_io_in(int size, u16 port)
 {
 	struct tdx_hypercall_args args = {
 		.r10 = TDX_HYPERCALL_STANDARD,
-		.r11 = EXIT_REASON_IO_INSTRUCTION,
+		.r11 = hcall_func(EXIT_REASON_IO_INSTRUCTION),
 		.r12 = size,
 		.r13 = 0,
 		.r14 = port,
@@ -36,7 +36,7 @@ static inline void tdx_io_out(int size, u16 port, u32 value)
 {
 	struct tdx_hypercall_args args = {
 		.r10 = TDX_HYPERCALL_STANDARD,
-		.r11 = EXIT_REASON_IO_INSTRUCTION,
+		.r11 = hcall_func(EXIT_REASON_IO_INSTRUCTION),
 		.r12 = size,
 		.r13 = 1,
 		.r14 = port,
diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index e146b599260f..15569bd32ed5 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -76,17 +76,6 @@ noinstr void __tdx_hypercall_failed(void)
 	panic("TDVMCALL failed. TDX module bug?");
 }
 
-/*
- * The TDG.VP.VMCALL-Instruction-execution sub-functions are defined
- * independently from but are currently matched 1:1 with VMX EXIT_REASONs.
- * Reusing the KVM EXIT_REASON macros makes it easier to connect the host and
- * guest sides of these calls.
- */
-static __always_inline u64 hcall_func(u64 exit_reason)
-{
-	return exit_reason;
-}
-
 #ifdef CONFIG_KVM_GUEST
 long tdx_kvm_hypercall(unsigned int nr, unsigned long p1, unsigned long p2,
 		       unsigned long p3, unsigned long p4)
diff --git a/arch/x86/include/asm/shared/tdx.h b/arch/x86/include/asm/shared/tdx.h
index 2631e01f6e0f..b415a24f0d48 100644
--- a/arch/x86/include/asm/shared/tdx.h
+++ b/arch/x86/include/asm/shared/tdx.h
@@ -40,5 +40,16 @@ u64 __tdx_hypercall_ret(struct tdx_hypercall_args *args);
 /* Called from __tdx_hypercall() for unrecoverable failure */
 void __tdx_hypercall_failed(void);
 
+/*
+ * The TDG.VP.VMCALL-Instruction-execution sub-functions are defined
+ * independently from but are currently matched 1:1 with VMX EXIT_REASONs.
+ * Reusing the KVM EXIT_REASON macros makes it easier to connect the host and
+ * guest sides of these calls.
+ */
+static __always_inline u64 hcall_func(u64 exit_reason)
+{
+        return exit_reason;
+}
+
 #endif /* !__ASSEMBLY__ */
 #endif /* _ASM_X86_SHARED_TDX_H */
-- 
2.34.1

