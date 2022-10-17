Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9D62601208
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 16:58:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231529AbiJQO6C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 10:58:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231408AbiJQO4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 10:56:34 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A45520F6B;
        Mon, 17 Oct 2022 07:54:37 -0700 (PDT)
Date:   Mon, 17 Oct 2022 14:54:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1666018454;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nNeu+QKNLaUPU8uxG0/jnQgd9Kg0KOJxKi9cyEHjonM=;
        b=fqKNIcwNtmpA+7rfQ028RBIQMQv7rbb+djwoI56LKneV42FLDA6FJpV/QziDqoKcbl4OWT
        UvYK41hKzFWnZosnSad4bZfhI/rsvBGkcuuqL2ZJz2hu/Fq7lK1Q7/psG34QxoOYFhELyt
        zjfP7jfBCCd52RMHucLS2JI3+XEHAWJPKP7z9AxfvHs9JLU2OXVLXHZsR/mRI8u/NpdNbg
        lqTQlbqnu5uzFGS+1iyUawFWAvWSI8BdXIgKl6mwhOUHjRmJgGrWOlLGBTQpzRf3d2j5Jp
        Gzaiv0U7KIEwCcTOWDDFm1iJD2q1CQT2CDip2iipDI7pmse061whCyXL440vSA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1666018454;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nNeu+QKNLaUPU8uxG0/jnQgd9Kg0KOJxKi9cyEHjonM=;
        b=U16KlrsvywFYTOu8IG4cvNL8HbFOFAFh1/s2vJ7AyB6CPfrvN6uZ7RQOlJHXZXgnfQmG5L
        LovXcrwfzQMjpBBg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] crypto: x86/sm[34]: Remove redundant alignments
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220915111144.868540856@infradead.org>
References: <20220915111144.868540856@infradead.org>
MIME-Version: 1.0
Message-ID: <166601845291.401.13406311811025343830.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     2f93238b87ddbbe1b050ec48ab5843fc61346adb
Gitweb:        https://git.kernel.org/tip/2f93238b87ddbbe1b050ec48ab5843fc61346adb
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 15 Sep 2022 13:10:58 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 17 Oct 2022 16:41:02 +02:00

crypto: x86/sm[34]: Remove redundant alignments

SYM_FUNC_START*() and friends already imply alignment, remove custom
alignment hacks to make code consistent. This prepares for future
function call ABI changes.

Also, with having pushed the function alignment to 16 bytes, this
custom alignment is completely superfluous.

( this code couldn't seem to make up it's mind about what alignment it
  actually wanted, randomly mixing 8 and 16 bytes )

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20220915111144.868540856@infradead.org
---
 arch/x86/crypto/sm3-avx-asm_64.S        | 1 -
 arch/x86/crypto/sm4-aesni-avx-asm_64.S  | 7 -------
 arch/x86/crypto/sm4-aesni-avx2-asm_64.S | 6 ------
 3 files changed, 14 deletions(-)

diff --git a/arch/x86/crypto/sm3-avx-asm_64.S b/arch/x86/crypto/sm3-avx-asm_64.S
index b12b9ef..b28d804 100644
--- a/arch/x86/crypto/sm3-avx-asm_64.S
+++ b/arch/x86/crypto/sm3-avx-asm_64.S
@@ -327,7 +327,6 @@
  * void sm3_transform_avx(struct sm3_state *state,
  *                        const u8 *data, int nblocks);
  */
-.align 16
 SYM_FUNC_START(sm3_transform_avx)
 	/* input:
 	 *	%rdi: ctx, CTX
diff --git a/arch/x86/crypto/sm4-aesni-avx-asm_64.S b/arch/x86/crypto/sm4-aesni-avx-asm_64.S
index 4767ab6..e13c853 100644
--- a/arch/x86/crypto/sm4-aesni-avx-asm_64.S
+++ b/arch/x86/crypto/sm4-aesni-avx-asm_64.S
@@ -139,13 +139,11 @@
 
 
 .text
-.align 16
 
 /*
  * void sm4_aesni_avx_crypt4(const u32 *rk, u8 *dst,
  *                           const u8 *src, int nblocks)
  */
-.align 8
 SYM_FUNC_START(sm4_aesni_avx_crypt4)
 	/* input:
 	 *	%rdi: round key array, CTX
@@ -249,7 +247,6 @@ SYM_FUNC_START(sm4_aesni_avx_crypt4)
 	RET;
 SYM_FUNC_END(sm4_aesni_avx_crypt4)
 
-.align 8
 SYM_FUNC_START_LOCAL(__sm4_crypt_blk8)
 	/* input:
 	 *	%rdi: round key array, CTX
@@ -363,7 +360,6 @@ SYM_FUNC_END(__sm4_crypt_blk8)
  * void sm4_aesni_avx_crypt8(const u32 *rk, u8 *dst,
  *                           const u8 *src, int nblocks)
  */
-.align 8
 SYM_FUNC_START(sm4_aesni_avx_crypt8)
 	/* input:
 	 *	%rdi: round key array, CTX
@@ -419,7 +415,6 @@ SYM_FUNC_END(sm4_aesni_avx_crypt8)
  * void sm4_aesni_avx_ctr_enc_blk8(const u32 *rk, u8 *dst,
  *                                 const u8 *src, u8 *iv)
  */
-.align 8
 SYM_FUNC_START(sm4_aesni_avx_ctr_enc_blk8)
 	/* input:
 	 *	%rdi: round key array, CTX
@@ -494,7 +489,6 @@ SYM_FUNC_END(sm4_aesni_avx_ctr_enc_blk8)
  * void sm4_aesni_avx_cbc_dec_blk8(const u32 *rk, u8 *dst,
  *                                 const u8 *src, u8 *iv)
  */
-.align 8
 SYM_FUNC_START(sm4_aesni_avx_cbc_dec_blk8)
 	/* input:
 	 *	%rdi: round key array, CTX
@@ -544,7 +538,6 @@ SYM_FUNC_END(sm4_aesni_avx_cbc_dec_blk8)
  * void sm4_aesni_avx_cfb_dec_blk8(const u32 *rk, u8 *dst,
  *                                 const u8 *src, u8 *iv)
  */
-.align 8
 SYM_FUNC_START(sm4_aesni_avx_cfb_dec_blk8)
 	/* input:
 	 *	%rdi: round key array, CTX
diff --git a/arch/x86/crypto/sm4-aesni-avx2-asm_64.S b/arch/x86/crypto/sm4-aesni-avx2-asm_64.S
index 4732fe8..2212705 100644
--- a/arch/x86/crypto/sm4-aesni-avx2-asm_64.S
+++ b/arch/x86/crypto/sm4-aesni-avx2-asm_64.S
@@ -153,9 +153,6 @@
 	.long 0xdeadbeef, 0xdeadbeef, 0xdeadbeef
 
 .text
-.align 16
-
-.align 8
 SYM_FUNC_START_LOCAL(__sm4_crypt_blk16)
 	/* input:
 	 *	%rdi: round key array, CTX
@@ -281,7 +278,6 @@ SYM_FUNC_END(__sm4_crypt_blk16)
  * void sm4_aesni_avx2_ctr_enc_blk16(const u32 *rk, u8 *dst,
  *                                   const u8 *src, u8 *iv)
  */
-.align 8
 SYM_FUNC_START(sm4_aesni_avx2_ctr_enc_blk16)
 	/* input:
 	 *	%rdi: round key array, CTX
@@ -394,7 +390,6 @@ SYM_FUNC_END(sm4_aesni_avx2_ctr_enc_blk16)
  * void sm4_aesni_avx2_cbc_dec_blk16(const u32 *rk, u8 *dst,
  *                                   const u8 *src, u8 *iv)
  */
-.align 8
 SYM_FUNC_START(sm4_aesni_avx2_cbc_dec_blk16)
 	/* input:
 	 *	%rdi: round key array, CTX
@@ -448,7 +443,6 @@ SYM_FUNC_END(sm4_aesni_avx2_cbc_dec_blk16)
  * void sm4_aesni_avx2_cfb_dec_blk16(const u32 *rk, u8 *dst,
  *                                   const u8 *src, u8 *iv)
  */
-.align 8
 SYM_FUNC_START(sm4_aesni_avx2_cfb_dec_blk16)
 	/* input:
 	 *	%rdi: round key array, CTX
