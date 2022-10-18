Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1D1E60354E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 23:56:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbiJRV4n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 17:56:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiJRV4l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 17:56:41 -0400
Received: from mail-ua1-x949.google.com (mail-ua1-x949.google.com [IPv6:2607:f8b0:4864:20::949])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BE4C7FE63
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 14:56:40 -0700 (PDT)
Received: by mail-ua1-x949.google.com with SMTP id h11-20020ab0470b000000b003bf1da44886so6337441uac.17
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 14:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=m7J+/b5/L0nQHPU1N8gvtVOb8AwUDuLMMuB/44yFdGw=;
        b=mEO2pPTxKmNgWoZtl0QxarEGwuWxwB5IlUJOcOiG99LrRsWMdv5m6glj1IUBip4WCN
         5suO/47EjfF9pPx4xUfqzVWXv07PSgNVIFbPKvRfR4OjyQM87lxjnbKfwCEvjquoKZJ6
         J0eviU7IkE+awbL7gWM/iQRVo5YQAFNQdCaFXY1nehdOSxffeuH6RBSX2/OlNSTsCiHS
         WnUKkhIoBHSXMv87CJsewUE/kkuIhsYEqZ9j6aSU73ryyMG6Yce0hc1+tSb00Tq2kRuu
         aWALp+a/U1w13NJXPFLRWgaVoe5yMWNMJVb9ioj2LOy1fTTmTRt9A4wKemWOPLDcrzrf
         8GVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m7J+/b5/L0nQHPU1N8gvtVOb8AwUDuLMMuB/44yFdGw=;
        b=EW6oKcoetmOZj2Hq9MIDI2XspiCnZPVK8DzMPtwDUby5ln42EFEFBMIrjl3ghVrqYJ
         GyBEB0oqHSpTAq6GM/aOBleGvi8Vmb4bxEmG4Vmh0w51kR2uGhTQel+GRsHt8QPxRWZ3
         Z+ok9zv5Qt91gCHQy8qtR44ILMckGvBaQDK/yBRXygM0TU8ZL5KD38P4TWJpyocSsjc1
         iDX+ILkCQNtyfJu1m1ENwGhszDmNeQlVvjVRxHqx41qvnJxnGYoI0BIAOGVe69Dnavyg
         6y8+DuU9EYY9ORL9TCW8Zjmenr4Xw2mTdf4BVFCgT9PYjtqb1118T7rvIq2QB/WWSd5l
         iiXA==
X-Gm-Message-State: ACrzQf328lDW/2vp5D6/vobkUtwqe+cEJObMORKdShP9D6wd57vwLMJl
        O/YXnnY34OyxUrPlG4iBlCdWMBSw6A==
X-Google-Smtp-Source: AMsMyM6swT74DF3e/aSs3KGk5NJODczWqA8x54vzE4y3j/+jMsMvWGFakKgx7XSQB8uYv/1BgYP+tWrgCQ==
X-Received: from nhuck.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:39cc])
 (user=nhuck job=sendgmr) by 2002:a05:6122:4f8:b0:3ae:21f7:28da with SMTP id
 s24-20020a05612204f800b003ae21f728damr2502221vkf.33.1666130199389; Tue, 18
 Oct 2022 14:56:39 -0700 (PDT)
Date:   Tue, 18 Oct 2022 14:56:23 -0700
In-Reply-To: <Y04lhwMechdfBkUU@gondor.apana.org.au>
Mime-Version: 1.0
References: <Y04lhwMechdfBkUU@gondor.apana.org.au>
X-Mailer: git-send-email 2.38.0.413.g74048e4d9e-goog
Message-ID: <20221018215623.866014-1-nhuck@google.com>
Subject: [PATCH v2] crypto: x86/polyval - Fix crashes when keys are not
 16-byte aligned
From:   Nathan Huckleberry <nhuck@google.com>
To:     herbert@gondor.apana.org.au
Cc:     ardb@kernel.org, bgoncalv@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, davem@davemloft.net,
        ebiggers@kernel.org, hpa@zytor.com, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, mingo@redhat.com, nhuck@google.com,
        tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

crypto_tfm::__crt_ctx is not guaranteed to be 16-byte aligned on x86-64.
This causes crashes due to movaps instructions in clmul_polyval_update.

Add logic to align polyval_tfm_ctx to 16 bytes if required.

Fixes: 34f7f6c30112 ("crypto: x86/polyval - Add PCLMULQDQ accelerated implementation of POLYVAL")
Reported-by: Bruno Goncalves <bgoncalv@redhat.com>
Signed-off-by: Nathan Huckleberry <nhuck@google.com>
---
 arch/x86/crypto/polyval-clmulni_glue.c | 29 ++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)

diff --git a/arch/x86/crypto/polyval-clmulni_glue.c b/arch/x86/crypto/polyval-clmulni_glue.c
index b7664d018851..79ad497c32b5 100644
--- a/arch/x86/crypto/polyval-clmulni_glue.c
+++ b/arch/x86/crypto/polyval-clmulni_glue.c
@@ -27,13 +27,17 @@
 #include <asm/cpu_device_id.h>
 #include <asm/simd.h>
 
+#define POLYVAL_ALIGN	16
+#define POLYVAL_ALIGN_ATTR __aligned(POLYVAL_ALIGN)
+#define POLYVAL_ALIGN_EXTRA ((POLYVAL_ALIGN - 1) & ~(CRYPTO_MINALIGN - 1))
+#define POLYVAL_CTX_SIZE (sizeof(struct polyval_tfm_ctx) + POLYVAL_ALIGN_EXTRA)
 #define NUM_KEY_POWERS	8
 
 struct polyval_tfm_ctx {
 	/*
 	 * These powers must be in the order h^8, ..., h^1.
 	 */
-	u8 key_powers[NUM_KEY_POWERS][POLYVAL_BLOCK_SIZE];
+	u8 key_powers[NUM_KEY_POWERS][POLYVAL_BLOCK_SIZE] POLYVAL_ALIGN_ATTR;
 };
 
 struct polyval_desc_ctx {
@@ -45,9 +49,20 @@ asmlinkage void clmul_polyval_update(const struct polyval_tfm_ctx *keys,
 	const u8 *in, size_t nblocks, u8 *accumulator);
 asmlinkage void clmul_polyval_mul(u8 *op1, const u8 *op2);
 
-static void internal_polyval_update(const struct polyval_tfm_ctx *keys,
+static inline struct polyval_tfm_ctx *polyval_tfm_ctx(const void *raw_ctx)
+{
+	unsigned long addr = (unsigned long)raw_ctx;
+	unsigned long align = POLYVAL_ALIGN;
+
+	if (align <= crypto_tfm_ctx_alignment())
+		align = 1;
+	return (struct polyval_tfm_ctx *)ALIGN(addr, align);
+}
+
+static void internal_polyval_update(const void *raw_keys,
 	const u8 *in, size_t nblocks, u8 *accumulator)
 {
+	const struct polyval_tfm_ctx *keys = polyval_tfm_ctx(raw_keys);
 	if (likely(crypto_simd_usable())) {
 		kernel_fpu_begin();
 		clmul_polyval_update(keys, in, nblocks, accumulator);
@@ -72,7 +87,7 @@ static void internal_polyval_mul(u8 *op1, const u8 *op2)
 static int polyval_x86_setkey(struct crypto_shash *tfm,
 			const u8 *key, unsigned int keylen)
 {
-	struct polyval_tfm_ctx *tctx = crypto_shash_ctx(tfm);
+	struct polyval_tfm_ctx *tctx = polyval_tfm_ctx(crypto_shash_ctx(tfm));
 	int i;
 
 	if (keylen != POLYVAL_BLOCK_SIZE)
@@ -102,7 +117,8 @@ static int polyval_x86_update(struct shash_desc *desc,
 			 const u8 *src, unsigned int srclen)
 {
 	struct polyval_desc_ctx *dctx = shash_desc_ctx(desc);
-	const struct polyval_tfm_ctx *tctx = crypto_shash_ctx(desc->tfm);
+	const struct polyval_tfm_ctx *tctx =
+	    polyval_tfm_ctx(crypto_shash_ctx(desc->tfm));
 	u8 *pos;
 	unsigned int nblocks;
 	unsigned int n;
@@ -143,7 +159,8 @@ static int polyval_x86_update(struct shash_desc *desc,
 static int polyval_x86_final(struct shash_desc *desc, u8 *dst)
 {
 	struct polyval_desc_ctx *dctx = shash_desc_ctx(desc);
-	const struct polyval_tfm_ctx *tctx = crypto_shash_ctx(desc->tfm);
+	const struct polyval_tfm_ctx *tctx =
+	    polyval_tfm_ctx(crypto_shash_ctx(desc->tfm));
 
 	if (dctx->bytes) {
 		internal_polyval_mul(dctx->buffer,
@@ -167,7 +184,7 @@ static struct shash_alg polyval_alg = {
 		.cra_driver_name	= "polyval-clmulni",
 		.cra_priority		= 200,
 		.cra_blocksize		= POLYVAL_BLOCK_SIZE,
-		.cra_ctxsize		= sizeof(struct polyval_tfm_ctx),
+		.cra_ctxsize		= POLYVAL_CTX_SIZE,
 		.cra_module		= THIS_MODULE,
 	},
 };
-- 
2.38.0.413.g74048e4d9e-goog

