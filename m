Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F6B670DEEF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 16:15:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236815AbjEWOPN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 10:15:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237328AbjEWOPF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 10:15:05 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F26BCA;
        Tue, 23 May 2023 07:15:03 -0700 (PDT)
Date:   Tue, 23 May 2023 14:14:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1684851300;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=Nk3X6BKw3HRCtmi2q1JAJeoY4KAETf3DsT8Z6wEf8Rw=;
        b=3y0glTUIVtWGDeDInhXGc3UU65t7OkopbpSkRJ8/FRQW03eYuSjt4dcwoizogeDXbIeXd9
        QADforY/YbWKQG3WU8Lfzyc1fvzcicvQTVlpE/kHSEm4Lb8P652poduyJxXjLmZb2r1pwR
        yv/PGoqLZKsgxr71Ww4qAUt8WErsQD9Jfc1hyqOwfz/lz2UgCdVb/aiVATDaqinPe4Cyvt
        ag7ZxktXSoc9Al+D4YmSkR4ntoXP/e9O1s5z0HShoPgMsEXdHClkj7b/L5Qv2LgXywrJDe
        NHi/NgbtzgX2X5WEeK1afdTSNCFO1gmi5EIqizpb2rpV7G0rTvDfI3xdoTY9fw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1684851300;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=Nk3X6BKw3HRCtmi2q1JAJeoY4KAETf3DsT8Z6wEf8Rw=;
        b=YXFyZN1kcjYigNPEGD02bFcoQMRP4pcg0/+BenAybTqpk+SSmf31/FmDDpusSfU5JeRosA
        B89XGOU2DrAqSMDA==
From:   "tip-bot2 for Nikolay Borisov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/tdx] x86/tdx: Wrap exit reason with hcall_func()
Cc:     Nikolay Borisov <nik.borisov@suse.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <168485129927.404.7998546441150815663.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/tdx branch of tip:

Commit-ID:     122333d6bd229af279cdb35d1b874b71b3b9ccfb
Gitweb:        https://git.kernel.org/tip/122333d6bd229af279cdb35d1b874b71b3b9ccfb
Author:        Nikolay Borisov <nik.borisov@suse.com>
AuthorDate:    Fri, 05 May 2023 15:03:32 +03:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Tue, 23 May 2023 07:01:45 -07:00

x86/tdx: Wrap exit reason with hcall_func()

TDX reuses VMEXIT "reasons" in its guest->host hypercall ABI.  This is
confusing because there might not be a VMEXIT involved at *all*.
These instances are supposed to document situation and reduce confusion
by wrapping VMEXIT reasons with hcall_func().

The decompression code does not follow this convention.

Unify the TDX decompression code with the other TDX use of VMEXIT reasons.
No functional changes.

Signed-off-by: Nikolay Borisov <nik.borisov@suse.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Link: https://lore.kernel.org/all/20230505120332.1429957-1-nik.borisov%40suse.com
---
 arch/x86/boot/compressed/tdx.c    |  4 ++--
 arch/x86/coco/tdx/tdx.c           | 11 -----------
 arch/x86/include/asm/shared/tdx.h | 11 +++++++++++
 3 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/x86/boot/compressed/tdx.c b/arch/x86/boot/compressed/tdx.c
index 2d81d3c..8841b94 100644
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
index e146b59..15569bd 100644
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
index 2631e01..b415a24 100644
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
