Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A61435F6023
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 06:34:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbiJFEeb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 00:34:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbiJFEe2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 00:34:28 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A6808981D
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 21:34:26 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id j7so804196wrr.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Oct 2022 21:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=2+q4B77y4492OMsLSwltTjFCfBaNdGlc5g1vRjEyo3g=;
        b=2wFJjHlwVyr1e0k1AXHQd1abfAAdqyKs3yxiEy2rMVLvl00/Z2ER9PrhBplnR4VAMc
         a0UQPjzaqILUbow5I4EUnT5BPmVCno5ncMVszIlEFCCATeFYaClwMum+A6Ze12PiT4Fj
         5bxRjAbbdMDgUBnzhJyk9b2nSC/ovqtWaJs0C5Qaee5eszNy4VHLlJtkN2L2w83hxxri
         Gz063zBGv2XcPwUlxltNG2JIiIe6J8wyYwTtz2Qe6YzQScaz6uHChNxsJ+Q7QKWNKR8C
         hbKwMGexOIvw918S8S2kvkkmEz0EgXXQ9GHm7UMB64WhYL0GwVlv4AGwXDPg9tZOzOg+
         qqBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=2+q4B77y4492OMsLSwltTjFCfBaNdGlc5g1vRjEyo3g=;
        b=CHXe2Za6bklzzq7ePaPjyYLsOwlRfnob/PHeYtkq2DHsjSGST0w7S6Kr4VThRpxSGf
         iVuKWGe+1c/9Nftqu0yoJ9kr/vA5XhhPV+vXXsqAKsMlvd2jhDjqull26uik6FRS83Bu
         dJM1JAHFdCLLpJxpKT25CuXMrrPngt44r0wtbdQQBXpryu2zETsSAlAfc9Itq0ZubNNl
         u6lR+Ud/LOr9Y1Hm/Uei4Gzyv0e8e5XN8EaSmXBTdZngl1jL+UsLG51IUmrgoduUBbYN
         0MLY31oMe2/iUiGvo1qrcH7NEIlVZ2GSjchplzC3vXrMKp8NsIYoMmoO7G3hjNK80Jar
         AxNg==
X-Gm-Message-State: ACrzQf3OBq8uKtWYaBSrJaOthG0+0GLxSXrU3yF4HJKLLbgHfM8NXp0T
        CscQPWYns6weJiqaaPbrs/1mKA==
X-Google-Smtp-Source: AMsMyM68fvNTKc7Kj9S8HiFOC1YknIuea7TFI8ga2VspcWpmb3pOpp/8tJGMH9bSF5nT9gyfGZ3QEA==
X-Received: by 2002:a5d:4a41:0:b0:228:48c6:7386 with SMTP id v1-20020a5d4a41000000b0022848c67386mr1630387wrs.649.1665030864572;
        Wed, 05 Oct 2022 21:34:24 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id p3-20020a5d4e03000000b002238ea5750csm19627163wrt.72.2022.10.05.21.34.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 21:34:24 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     davem@davemloft.net, eike-kernel@sf-tec.de,
        herbert@gondor.apana.org.au
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Corentin Labbe <clabbe@baylibre.com>, stable@kernel.org
Subject: [PATCH] crypto: n2: add missing hash statesize
Date:   Thu,  6 Oct 2022 04:34:19 +0000
Message-Id: <20221006043419.3892520-1-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing statesize to hash templates.
This is mandatory otherwise no algorithms can be registered as the core
requires statesize to be set.

CC: stable@kernel.org # 4.3+
Reported-by: Rolf Eike Beer <eike-kernel@sf-tec.de>
Tested-by: Rolf Eike Beer <eike-kernel@sf-tec.de>
Fixes: 0a625fd2abaa ("crypto: n2 - Add Niagara2 crypto driver")
Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/crypto/n2_core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/crypto/n2_core.c b/drivers/crypto/n2_core.c
index 31e24df18877..20d0dcd50344 100644
--- a/drivers/crypto/n2_core.c
+++ b/drivers/crypto/n2_core.c
@@ -1229,6 +1229,7 @@ struct n2_hash_tmpl {
 	const u8	*hash_init;
 	u8		hw_op_hashsz;
 	u8		digest_size;
+	u8		statesize;
 	u8		block_size;
 	u8		auth_type;
 	u8		hmac_type;
@@ -1260,6 +1261,7 @@ static const struct n2_hash_tmpl hash_tmpls[] = {
 	  .hmac_type	= AUTH_TYPE_HMAC_MD5,
 	  .hw_op_hashsz	= MD5_DIGEST_SIZE,
 	  .digest_size	= MD5_DIGEST_SIZE,
+	  .statesize	= sizeof(struct md5_state),
 	  .block_size	= MD5_HMAC_BLOCK_SIZE },
 	{ .name		= "sha1",
 	  .hash_zero	= sha1_zero_message_hash,
@@ -1268,6 +1270,7 @@ static const struct n2_hash_tmpl hash_tmpls[] = {
 	  .hmac_type	= AUTH_TYPE_HMAC_SHA1,
 	  .hw_op_hashsz	= SHA1_DIGEST_SIZE,
 	  .digest_size	= SHA1_DIGEST_SIZE,
+	  .statesize	= sizeof(struct sha1_state),
 	  .block_size	= SHA1_BLOCK_SIZE },
 	{ .name		= "sha256",
 	  .hash_zero	= sha256_zero_message_hash,
@@ -1276,6 +1279,7 @@ static const struct n2_hash_tmpl hash_tmpls[] = {
 	  .hmac_type	= AUTH_TYPE_HMAC_SHA256,
 	  .hw_op_hashsz	= SHA256_DIGEST_SIZE,
 	  .digest_size	= SHA256_DIGEST_SIZE,
+	  .statesize	= sizeof(struct sha256_state),
 	  .block_size	= SHA256_BLOCK_SIZE },
 	{ .name		= "sha224",
 	  .hash_zero	= sha224_zero_message_hash,
@@ -1284,6 +1288,7 @@ static const struct n2_hash_tmpl hash_tmpls[] = {
 	  .hmac_type	= AUTH_TYPE_RESERVED,
 	  .hw_op_hashsz	= SHA256_DIGEST_SIZE,
 	  .digest_size	= SHA224_DIGEST_SIZE,
+	  .statesize	= sizeof(struct sha256_state),
 	  .block_size	= SHA224_BLOCK_SIZE },
 };
 #define NUM_HASH_TMPLS ARRAY_SIZE(hash_tmpls)
@@ -1424,6 +1429,7 @@ static int __n2_register_one_ahash(const struct n2_hash_tmpl *tmpl)
 
 	halg = &ahash->halg;
 	halg->digestsize = tmpl->digest_size;
+	halg->statesize = tmpl->statesize;
 
 	base = &halg->base;
 	snprintf(base->cra_name, CRYPTO_MAX_ALG_NAME, "%s", tmpl->name);
-- 
2.35.1

