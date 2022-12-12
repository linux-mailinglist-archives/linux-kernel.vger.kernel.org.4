Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8693164A92E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 22:05:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233375AbiLLVFU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 16:05:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233192AbiLLVEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 16:04:48 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2399218B13
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 13:04:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D242CB80E35
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 21:04:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCA48C433D2;
        Mon, 12 Dec 2022 21:04:04 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="LcWov99g"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1670879043;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=jQi+KqdarD9JZcBJN4YPid9D4ky5u8WlWbv9+TvYdfY=;
        b=LcWov99g6nA2wg+Pb/2C4jNyo1D+G0zFfmc/hgxHYsAhLxFRedanONiWX1if9GtVqc3OeD
        9KCpQ2Jt39yYblveijGa5AzYenmTn70iwRj32tRyNxxRrY/Nt3mFE5kOaJPeEHXTl92jVF
        GGHPu7hwfseWZkS3tzS0frkQVYaNoCg=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 754edfe5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 12 Dec 2022 21:04:03 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH] x86: lib: Separate instruction decoder MMIO type from MMIO trace
Date:   Mon, 12 Dec 2022 14:02:55 -0700
Message-Id: <20221212210254.2559995-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both mmiotrace.h and insn-eval.h define various MMIO_ enum constants.
Rename the insn ones to have a INSN_ prefix, so that the headers can be
used from the same source file.

Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
This doesn't fix any existing compile error that I'm aware of, but if
this makes it into 6.2, it would avoid me having to carry it in a series
I'm working on, where the clash does result in a compile error.

 arch/x86/coco/tdx/tdx.c          | 26 +++++++++++++-------------
 arch/x86/include/asm/insn-eval.h | 18 +++++++++---------
 arch/x86/kernel/sev.c            | 18 +++++++++---------
 arch/x86/lib/insn-eval.c         | 20 ++++++++++----------
 4 files changed, 41 insertions(+), 41 deletions(-)

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index b8998cf0508a..c05428668fbc 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -347,7 +347,7 @@ static int handle_mmio(struct pt_regs *regs, struct ve_info *ve)
 	unsigned long *reg, val, vaddr;
 	char buffer[MAX_INSN_SIZE];
 	struct insn insn = {};
-	enum mmio_type mmio;
+	enum insn_mmio_type mmio;
 	int size, extend_size;
 	u8 extend_val = 0;
 
@@ -362,10 +362,10 @@ static int handle_mmio(struct pt_regs *regs, struct ve_info *ve)
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
@@ -386,23 +386,23 @@ static int handle_mmio(struct pt_regs *regs, struct ve_info *ve)
 
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
@@ -419,15 +419,15 @@ static int handle_mmio(struct pt_regs *regs, struct ve_info *ve)
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
index f07faa61c7f3..54368a43abf6 100644
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
index a428c62330d3..ecd991ec1a98 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -1537,31 +1537,31 @@ static enum es_result vc_handle_mmio(struct ghcb *ghcb, struct es_em_ctxt *ctxt)
 {
 	struct insn *insn = &ctxt->insn;
 	unsigned int bytes = 0;
-	enum mmio_type mmio;
+	enum insn_mmio_type mmio;
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
index 21104c41cba0..558a605929db 100644
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
-- 
2.39.0

