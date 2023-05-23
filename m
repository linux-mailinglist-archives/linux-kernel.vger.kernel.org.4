Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C026770D799
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 10:35:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235623AbjEWIfi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 04:35:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236217AbjEWIfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 04:35:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 314FA10EF;
        Tue, 23 May 2023 01:33:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8C2B5601C6;
        Tue, 23 May 2023 08:33:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE65AC4339B;
        Tue, 23 May 2023 08:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684830800;
        bh=MnGHsJX536Td4nzr8n47Z1xXn9aYKRj+yG30BHNM0pE=;
        h=From:To:Cc:Subject:Date:From;
        b=VjlerZ6DwRlft+MW5AKa+6QzLwoGVwrBuYKV+9G06XcHljxy7GOaXAbhHxd9ty586
         UWdkKzXGJtP3kRTiZHA09Hl2Pl0CNxAEpvuTodMwV/nnbjo2sWcEn+ndrB3DH/CISL
         cbVi/qZnNhjVc/KZgj9Azp3zgVlNZ+MUjvA22O5mbEPUi1vVVMnr0hjai3o7mATxzU
         Tzc2RVu1t0N9TguAkJhw9vR6d9p2E+HZjl85aDIVRq6XwxHCF6ramLRYPb64N7GQol
         qj9Ri9a+fbbIWlle9CCv5FzqeUWcqSCPNk7HEyFIdhmKOUcnbA9a7DbJJvvrZYpVHO
         R/I8YD1ENffig==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Boris Brezillon <bbrezillon@kernel.org>,
        Arnaud Ebalard <arno@natisbad.org>,
        Srujana Challa <schalla@marvell.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Arnd Bergmann <arnd@arndb.de>, Kees Cook <keescook@chromium.org>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] crypto: marvell/cesa - Fix type mismatch warning
Date:   Tue, 23 May 2023 10:33:04 +0200
Message-Id: <20230523083313.899332-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Commit df8fc4e934c1 ("kbuild: Enable -fstrict-flex-arrays=3") uncovered
a type mismatch in cesa 3des support that leads to a memcpy beyond the
end of a structure:

In function 'fortify_memcpy_chk',
    inlined from 'mv_cesa_des3_ede_setkey' at drivers/crypto/marvell/cesa/cipher.c:307:2:
include/linux/fortify-string.h:583:25: error: call to '__write_overflow_field' declared with attribute warning: detected write beyond size of field (1st parameter); maybe use struct_group()? [-Werror=attribute-warning]
  583 |                         __write_overflow_field(p_size_field, size);
      |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

This is probably harmless as the actual data that is copied has the correct
type, but clearly worth fixing nonetheless.

Fixes: 4ada48397823 ("crypto: marvell/cesa - add Triple-DES support")
Cc: Kees Cook <keescook@chromium.org>
Cc: Gustavo A. R. Silva" <gustavoars@kernel.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/crypto/marvell/cesa/cipher.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/marvell/cesa/cipher.c b/drivers/crypto/marvell/cesa/cipher.c
index c6f2fa753b7c..0f37dfd42d85 100644
--- a/drivers/crypto/marvell/cesa/cipher.c
+++ b/drivers/crypto/marvell/cesa/cipher.c
@@ -297,7 +297,7 @@ static int mv_cesa_des_setkey(struct crypto_skcipher *cipher, const u8 *key,
 static int mv_cesa_des3_ede_setkey(struct crypto_skcipher *cipher,
 				   const u8 *key, unsigned int len)
 {
-	struct mv_cesa_des_ctx *ctx = crypto_skcipher_ctx(cipher);
+	struct mv_cesa_des3_ctx *ctx = crypto_skcipher_ctx(cipher);
 	int err;
 
 	err = verify_skcipher_des3_key(cipher, key);
-- 
2.39.2

