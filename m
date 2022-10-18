Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47FF4603661
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 01:05:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbiJRXFY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 19:05:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbiJRXFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 19:05:00 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43647437E2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 16:04:47 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-355ae0f4d3dso153088787b3.14
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 16:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/k50xcora8SusgWH3PC14s9L2Ta+3apzzJKJhsds4aQ=;
        b=Ex5XMJrkse9STYw9ZDiUFUgkqKcQV7UAnfL8qqxPTT7wSILe1Pd9egosOfYxh0shn8
         sjrmCZqKm4fAk+PZBqqMNvAZ/O8oRDilep2AOwiQPbsfzuG7uAdWOEo99mPbpPfPN5IQ
         hrIypZ+r27+++zVjtnL6v7AAPq4nBJThSYMpsQLhCF5BMWbALoZZnNcBvhbQ338gvima
         GKiMB4usiu6YqkWgHYYV+qcj9+h/XWLWBnO+0XcHw4Tj3outSR86xz93g++zepNrYuoj
         4ZT4ADUS4Md6xJhXE7PbCmpXevqP993WJ/Phmc1ak3nv5GJNH1hAw1YTrkNpNhajP+yE
         f4dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/k50xcora8SusgWH3PC14s9L2Ta+3apzzJKJhsds4aQ=;
        b=J9+eirBeP82ehB9EFOFccWE2/SGWKY9By2r4crXk5JCDjGnrDBno1ZKzFzr7Vgcd1r
         KoJ4fwCo5cwM0cOtuVvJZ0/Wqpgo7DTKRtZCBz2UxdBD4f2xCGSp5EVge84jQMrykxKg
         eduzMbzJTq4ULx9VZJGwXhhMSeIVN4lmhHHhvAYYF+QIaIWUmHSWwG+i/HEk8oJ6Zq2f
         K04ESKarpYGPRjbiS5X+Fv45KDdX4YMLKE2LvXmA2KcYs+O299oPtaZb9R1DDnQNzY3p
         t6mJkOz0QIxvr0YnnJOZtaTpBBHAl2MIZ9E0LIk0DRPSsWi6G031a/XYjnyagv4CvBL0
         G3KA==
X-Gm-Message-State: ACrzQf1pjK9A0f6cOjegVDLrQayKyQNoq1EkOIfBoAhDRxImwkAbzJLA
        riTFHv4quvbQ11uliNAg7X6lppehZA==
X-Google-Smtp-Source: AMsMyM42OmmsI248GW1q6Cx2tnJLcApQITiriyV5uHtjNqgqP/EHV7at+rjrjiCxXNjcNIf8GTBMt3cYUA==
X-Received: from nhuck.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:39cc])
 (user=nhuck job=sendgmr) by 2002:a25:8e0a:0:b0:6be:fb9a:9027 with SMTP id
 p10-20020a258e0a000000b006befb9a9027mr4585013ybl.8.1666134280586; Tue, 18 Oct
 2022 16:04:40 -0700 (PDT)
Date:   Tue, 18 Oct 2022 16:04:12 -0700
In-Reply-To: <Y08rHF09/qxCVK+K@sol.localdomain>
Mime-Version: 1.0
References: <Y08rHF09/qxCVK+K@sol.localdomain>
X-Mailer: git-send-email 2.38.0.413.g74048e4d9e-goog
Message-ID: <20221018230412.886349-1-nhuck@google.com>
Subject: [PATCH v3] crypto: x86/polyval - Fix crashes when keys are not
 16-byte aligned
From:   Nathan Huckleberry <nhuck@google.com>
To:     ebiggers@kernel.org
Cc:     ardb@kernel.org, bgoncalv@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, davem@davemloft.net,
        herbert@gondor.apana.org.au, hpa@zytor.com,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, nhuck@google.com, tglx@linutronix.de,
        x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

crypto_tfm::__crt_ctx is not guaranteed to be 16-byte aligned on x86-64.
This causes crashes due to movaps instructions in clmul_polyval_update.

Add logic to align polyval_tfm_ctx to 16 bytes.

Fixes: 34f7f6c30112 ("crypto: x86/polyval - Add PCLMULQDQ accelerated implementation of POLYVAL")
Reported-by: Bruno Goncalves <bgoncalv@redhat.com>
Signed-off-by: Nathan Huckleberry <nhuck@google.com>
---
 arch/x86/crypto/polyval-clmulni_glue.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/arch/x86/crypto/polyval-clmulni_glue.c b/arch/x86/crypto/polyval-clmulni_glue.c
index b7664d018851..8fa58b0f3cb3 100644
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
@@ -45,6 +49,11 @@ asmlinkage void clmul_polyval_update(const struct polyval_tfm_ctx *keys,
 	const u8 *in, size_t nblocks, u8 *accumulator);
 asmlinkage void clmul_polyval_mul(u8 *op1, const u8 *op2);
 
+static inline struct polyval_tfm_ctx *polyval_tfm_ctx(struct crypto_shash *tfm)
+{
+	return PTR_ALIGN(crypto_shash_ctx(tfm), POLYVAL_ALIGN);
+}
+
 static void internal_polyval_update(const struct polyval_tfm_ctx *keys,
 	const u8 *in, size_t nblocks, u8 *accumulator)
 {
@@ -72,7 +81,7 @@ static void internal_polyval_mul(u8 *op1, const u8 *op2)
 static int polyval_x86_setkey(struct crypto_shash *tfm,
 			const u8 *key, unsigned int keylen)
 {
-	struct polyval_tfm_ctx *tctx = crypto_shash_ctx(tfm);
+	struct polyval_tfm_ctx *tctx = polyval_tfm_ctx(tfm);
 	int i;
 
 	if (keylen != POLYVAL_BLOCK_SIZE)
@@ -102,7 +111,7 @@ static int polyval_x86_update(struct shash_desc *desc,
 			 const u8 *src, unsigned int srclen)
 {
 	struct polyval_desc_ctx *dctx = shash_desc_ctx(desc);
-	const struct polyval_tfm_ctx *tctx = crypto_shash_ctx(desc->tfm);
+	const struct polyval_tfm_ctx *tctx = polyval_tfm_ctx(desc->tfm);
 	u8 *pos;
 	unsigned int nblocks;
 	unsigned int n;
@@ -143,7 +152,7 @@ static int polyval_x86_update(struct shash_desc *desc,
 static int polyval_x86_final(struct shash_desc *desc, u8 *dst)
 {
 	struct polyval_desc_ctx *dctx = shash_desc_ctx(desc);
-	const struct polyval_tfm_ctx *tctx = crypto_shash_ctx(desc->tfm);
+	const struct polyval_tfm_ctx *tctx = polyval_tfm_ctx(desc->tfm);
 
 	if (dctx->bytes) {
 		internal_polyval_mul(dctx->buffer,
@@ -167,7 +176,7 @@ static struct shash_alg polyval_alg = {
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

