Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E702565BE88
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 12:00:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237114AbjACLAW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 06:00:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233043AbjACLAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 06:00:20 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C1942DEB;
        Tue,  3 Jan 2023 03:00:18 -0800 (PST)
Date:   Tue, 03 Jan 2023 11:00:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1672743617;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dtjkbuGNEyAtfVHAFWGtHLaL5xcC6aKO5Rvstp0NeRI=;
        b=nJKCbfyR0gW6B7K62witUlOTYvu7wvDGNqAvQxQRkbCv6nnxenBizgE+ZcHNISYobfC8c+
        c+gZsfDSP/vI4xWRG9r5pLDBaRA/u7/RSH2MGpDUCG8Xic06EtD4q765BpI1QOF9v5ZgO5
        ZnK8SkLinmNn5R0mHvGCZxuypuhQV6KTScdHjDWlvBMES0jQTZz2jsgkVjiuTkiannCRaM
        WrlY+wnU96ZI+gFOqOWC0JGBcAc7qtmHFav65bO9olLjsmVGzSlpzNXUdEK3AuYWs+RFH5
        G3JgdI5uZeNkaMcMz4+UkU02De5REIE3Umjf5CBcCJGxRoPvbLyWjy3NdGP2KQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1672743617;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dtjkbuGNEyAtfVHAFWGtHLaL5xcC6aKO5Rvstp0NeRI=;
        b=R3BlekOC4v7KkPycfH/ueK3fz3HwTQISc8rzx+EVMLbyY7w9Amt4+PIL4++tH4Kse7vo8v
        jKQjgLbqU2Ez3wCQ==
From:   "tip-bot2 for Jason A. Donenfeld" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/asm] x86/insn: Avoid namespace clash by separating
 instruction decoder MMIO type from MMIO trace type
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230101162910.710293-2-Jason@zx2c4.com>
References: <20230101162910.710293-2-Jason@zx2c4.com>
MIME-Version: 1.0
Message-ID: <167274361649.4906.7354355894858442435.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/asm branch of tip:

Commit-ID:     a0e3aa8fe6cb1065686d5863bfeb7f5f3b17d030
Gitweb:        https://git.kernel.org/tip/a0e3aa8fe6cb1065686d5863bfeb7f5f3b17d030
Author:        Jason A. Donenfeld <Jason@zx2c4.com>
AuthorDate:    Sun, 01 Jan 2023 17:29:04 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 03 Jan 2023 11:30:28 +01:00

x86/insn: Avoid namespace clash by separating instruction decoder MMIO type from MMIO trace type

Both <linux/mmiotrace.h> and <asm/insn-eval.h> define various MMIO_ enum constants,
whose namespace overlaps.

Rename the <asm/insn-eval.h> ones to have a INSN_ prefix, so that the headers can be
used from the same source file.

Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20230101162910.710293-2-Jason@zx2c4.com
---
 arch/x86/coco/tdx/tdx.c          | 26 +++++++++++++-------------
 arch/x86/include/asm/insn-eval.h | 18 +++++++++---------
 arch/x86/kernel/sev.c            | 18 +++++++++---------
 arch/x86/lib/insn-eval.c         | 20 ++++++++++----------
 4 files changed, 41 insertions(+), 41 deletions(-)

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index cfd4c95..669d9e4 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -386,8 +386,8 @@ static int handle_mmio(struct pt_regs *regs, struct ve_info *ve)
 {
 	unsigned long *reg, val, vaddr;
 	char buffer[MAX_INSN_SIZE];
+	enum insn_mmio_type mmio;
 	struct insn insn = {};
-	enum mmio_type mmio;
 	int size, extend_size;
 	u8 extend_val = 0;
 
@@ -402,10 +402,10 @@ static int handle_mmio(struct pt_regs *regs, struct ve_info *ve)
 		return -EINVAL;
 
 	mmio = insn_decode_mmio(&insn, &size);
-	if (WARN_ON_ONCE(mmio == MMIO_DECODE_FAILED))
+	if (WARN_ON_ONCE(mmio == INSN_MMIO_DECODE_FAILED))
 		return -EINVAL;
 
-	if (mmio != MMIO_WRITE_IMM && mmio != MMIO_MOVS) {
+	if (mmio != INSN_MMIO_WRITE_IMM && mmio != INSN_MMIO_MOVS) {
 		reg = insn_get_modrm_reg_ptr(&insn, regs);
 		if (!reg)
 			return -EINVAL;
@@ -426,23 +426,23 @@ static int handle_mmio(struct pt_regs *regs, struct ve_info *ve)
 
 	/* Handle writes first */
 	switch (mmio) {
-	case MMIO_WRITE:
+	case INSN_MMIO_WRITE:
 		memcpy(&val, reg, size);
 		if (!mmio_write(size, ve->gpa, val))
 			return -EIO;
 		return insn.length;
-	case MMIO_WRITE_IMM:
+	case INSN_MMIO_WRITE_IMM:
 		val = insn.immediate.value;
 		if (!mmio_write(size, ve->gpa, val))
 			return -EIO;
 		return insn.length;
-	case MMIO_READ:
-	case MMIO_READ_ZERO_EXTEND:
-	case MMIO_READ_SIGN_EXTEND:
+	case INSN_MMIO_READ:
+	case INSN_MMIO_READ_ZERO_EXTEND:
+	case INSN_MMIO_READ_SIGN_EXTEND:
 		/* Reads are handled below */
 		break;
-	case MMIO_MOVS:
-	case MMIO_DECODE_FAILED:
+	case INSN_MMIO_MOVS:
+	case INSN_MMIO_DECODE_FAILED:
 		/*
 		 * MMIO was accessed with an instruction that could not be
 		 * decoded or handled properly. It was likely not using io.h
@@ -459,15 +459,15 @@ static int handle_mmio(struct pt_regs *regs, struct ve_info *ve)
 		return -EIO;
 
 	switch (mmio) {
-	case MMIO_READ:
+	case INSN_MMIO_READ:
 		/* Zero-extend for 32-bit operation */
 		extend_size = size == 4 ? sizeof(*reg) : 0;
 		break;
-	case MMIO_READ_ZERO_EXTEND:
+	case INSN_MMIO_READ_ZERO_EXTEND:
 		/* Zero extend based on operand size */
 		extend_size = insn.opnd_bytes;
 		break;
-	case MMIO_READ_SIGN_EXTEND:
+	case INSN_MMIO_READ_SIGN_EXTEND:
 		/* Sign extend based on operand size */
 		extend_size = insn.opnd_bytes;
 		if (size == 1 && val & BIT(7))
diff --git a/arch/x86/include/asm/insn-eval.h b/arch/x86/include/asm/insn-eval.h
index f07faa6..54368a4 100644
--- a/arch/x86/include/asm/insn-eval.h
+++ b/arch/x86/include/asm/insn-eval.h
@@ -32,16 +32,16 @@ int insn_fetch_from_user_inatomic(struct pt_regs *regs,
 bool insn_decode_from_regs(struct insn *insn, struct pt_regs *regs,
 			   unsigned char buf[MAX_INSN_SIZE], int buf_size);
 
-enum mmio_type {
-	MMIO_DECODE_FAILED,
-	MMIO_WRITE,
-	MMIO_WRITE_IMM,
-	MMIO_READ,
-	MMIO_READ_ZERO_EXTEND,
-	MMIO_READ_SIGN_EXTEND,
-	MMIO_MOVS,
+enum insn_mmio_type {
+	INSN_MMIO_DECODE_FAILED,
+	INSN_MMIO_WRITE,
+	INSN_MMIO_WRITE_IMM,
+	INSN_MMIO_READ,
+	INSN_MMIO_READ_ZERO_EXTEND,
+	INSN_MMIO_READ_SIGN_EXTEND,
+	INSN_MMIO_MOVS,
 };
 
-enum mmio_type insn_decode_mmio(struct insn *insn, int *bytes);
+enum insn_mmio_type insn_decode_mmio(struct insn *insn, int *bytes);
 
 #endif /* _ASM_X86_INSN_EVAL_H */
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index a428c62..679026a 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -1536,32 +1536,32 @@ static enum es_result vc_handle_mmio_movs(struct es_em_ctxt *ctxt,
 static enum es_result vc_handle_mmio(struct ghcb *ghcb, struct es_em_ctxt *ctxt)
 {
 	struct insn *insn = &ctxt->insn;
+	enum insn_mmio_type mmio;
 	unsigned int bytes = 0;
-	enum mmio_type mmio;
 	enum es_result ret;
 	u8 sign_byte;
 	long *reg_data;
 
 	mmio = insn_decode_mmio(insn, &bytes);
-	if (mmio == MMIO_DECODE_FAILED)
+	if (mmio == INSN_MMIO_DECODE_FAILED)
 		return ES_DECODE_FAILED;
 
-	if (mmio != MMIO_WRITE_IMM && mmio != MMIO_MOVS) {
+	if (mmio != INSN_MMIO_WRITE_IMM && mmio != INSN_MMIO_MOVS) {
 		reg_data = insn_get_modrm_reg_ptr(insn, ctxt->regs);
 		if (!reg_data)
 			return ES_DECODE_FAILED;
 	}
 
 	switch (mmio) {
-	case MMIO_WRITE:
+	case INSN_MMIO_WRITE:
 		memcpy(ghcb->shared_buffer, reg_data, bytes);
 		ret = vc_do_mmio(ghcb, ctxt, bytes, false);
 		break;
-	case MMIO_WRITE_IMM:
+	case INSN_MMIO_WRITE_IMM:
 		memcpy(ghcb->shared_buffer, insn->immediate1.bytes, bytes);
 		ret = vc_do_mmio(ghcb, ctxt, bytes, false);
 		break;
-	case MMIO_READ:
+	case INSN_MMIO_READ:
 		ret = vc_do_mmio(ghcb, ctxt, bytes, true);
 		if (ret)
 			break;
@@ -1572,7 +1572,7 @@ static enum es_result vc_handle_mmio(struct ghcb *ghcb, struct es_em_ctxt *ctxt)
 
 		memcpy(reg_data, ghcb->shared_buffer, bytes);
 		break;
-	case MMIO_READ_ZERO_EXTEND:
+	case INSN_MMIO_READ_ZERO_EXTEND:
 		ret = vc_do_mmio(ghcb, ctxt, bytes, true);
 		if (ret)
 			break;
@@ -1581,7 +1581,7 @@ static enum es_result vc_handle_mmio(struct ghcb *ghcb, struct es_em_ctxt *ctxt)
 		memset(reg_data, 0, insn->opnd_bytes);
 		memcpy(reg_data, ghcb->shared_buffer, bytes);
 		break;
-	case MMIO_READ_SIGN_EXTEND:
+	case INSN_MMIO_READ_SIGN_EXTEND:
 		ret = vc_do_mmio(ghcb, ctxt, bytes, true);
 		if (ret)
 			break;
@@ -1600,7 +1600,7 @@ static enum es_result vc_handle_mmio(struct ghcb *ghcb, struct es_em_ctxt *ctxt)
 		memset(reg_data, sign_byte, insn->opnd_bytes);
 		memcpy(reg_data, ghcb->shared_buffer, bytes);
 		break;
-	case MMIO_MOVS:
+	case INSN_MMIO_MOVS:
 		ret = vc_handle_mmio_movs(ctxt, bytes);
 		break;
 	default:
diff --git a/arch/x86/lib/insn-eval.c b/arch/x86/lib/insn-eval.c
index 21104c4..558a605 100644
--- a/arch/x86/lib/insn-eval.c
+++ b/arch/x86/lib/insn-eval.c
@@ -1595,16 +1595,16 @@ bool insn_decode_from_regs(struct insn *insn, struct pt_regs *regs,
  * Returns:
  *
  * Type of the instruction. Size of the memory operand is stored in
- * @bytes. If decode failed, MMIO_DECODE_FAILED returned.
+ * @bytes. If decode failed, INSN_MMIO_DECODE_FAILED returned.
  */
-enum mmio_type insn_decode_mmio(struct insn *insn, int *bytes)
+enum insn_mmio_type insn_decode_mmio(struct insn *insn, int *bytes)
 {
-	enum mmio_type type = MMIO_DECODE_FAILED;
+	enum insn_mmio_type type = INSN_MMIO_DECODE_FAILED;
 
 	*bytes = 0;
 
 	if (insn_get_opcode(insn))
-		return MMIO_DECODE_FAILED;
+		return INSN_MMIO_DECODE_FAILED;
 
 	switch (insn->opcode.bytes[0]) {
 	case 0x88: /* MOV m8,r8 */
@@ -1613,7 +1613,7 @@ enum mmio_type insn_decode_mmio(struct insn *insn, int *bytes)
 	case 0x89: /* MOV m16/m32/m64, r16/m32/m64 */
 		if (!*bytes)
 			*bytes = insn->opnd_bytes;
-		type = MMIO_WRITE;
+		type = INSN_MMIO_WRITE;
 		break;
 
 	case 0xc6: /* MOV m8, imm8 */
@@ -1622,7 +1622,7 @@ enum mmio_type insn_decode_mmio(struct insn *insn, int *bytes)
 	case 0xc7: /* MOV m16/m32/m64, imm16/imm32/imm64 */
 		if (!*bytes)
 			*bytes = insn->opnd_bytes;
-		type = MMIO_WRITE_IMM;
+		type = INSN_MMIO_WRITE_IMM;
 		break;
 
 	case 0x8a: /* MOV r8, m8 */
@@ -1631,7 +1631,7 @@ enum mmio_type insn_decode_mmio(struct insn *insn, int *bytes)
 	case 0x8b: /* MOV r16/r32/r64, m16/m32/m64 */
 		if (!*bytes)
 			*bytes = insn->opnd_bytes;
-		type = MMIO_READ;
+		type = INSN_MMIO_READ;
 		break;
 
 	case 0xa4: /* MOVS m8, m8 */
@@ -1640,7 +1640,7 @@ enum mmio_type insn_decode_mmio(struct insn *insn, int *bytes)
 	case 0xa5: /* MOVS m16/m32/m64, m16/m32/m64 */
 		if (!*bytes)
 			*bytes = insn->opnd_bytes;
-		type = MMIO_MOVS;
+		type = INSN_MMIO_MOVS;
 		break;
 
 	case 0x0f: /* Two-byte instruction */
@@ -1651,7 +1651,7 @@ enum mmio_type insn_decode_mmio(struct insn *insn, int *bytes)
 		case 0xb7: /* MOVZX r32/r64, m16 */
 			if (!*bytes)
 				*bytes = 2;
-			type = MMIO_READ_ZERO_EXTEND;
+			type = INSN_MMIO_READ_ZERO_EXTEND;
 			break;
 
 		case 0xbe: /* MOVSX r16/r32/r64, m8 */
@@ -1660,7 +1660,7 @@ enum mmio_type insn_decode_mmio(struct insn *insn, int *bytes)
 		case 0xbf: /* MOVSX r32/r64, m16 */
 			if (!*bytes)
 				*bytes = 2;
-			type = MMIO_READ_SIGN_EXTEND;
+			type = INSN_MMIO_READ_SIGN_EXTEND;
 			break;
 		}
 		break;
