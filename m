Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4854F64B366
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 11:43:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234949AbiLMKny (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 05:43:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234909AbiLMKnr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 05:43:47 -0500
Received: from formenos.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB3F8644C;
        Tue, 13 Dec 2022 02:43:45 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1p52l0-006n59-GP; Tue, 13 Dec 2022 18:43:31 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Tue, 13 Dec 2022 18:43:30 +0800
Date:   Tue, 13 Dec 2022 18:43:30 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     kernel test robot <lkp@intel.com>,
        Robert Elliott <elliott@hpe.com>, llvm@lists.linux.dev,
        oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Subject: [PATCH] crypto: arm/sha1 - Fix clang function cast warnings
Message-ID: <Y5hXUlvSmHrP8PTN@gondor.apana.org.au>
References: <202211041904.f9S5gAGL-lkp@intel.com>
 <Y5FvChDBD/+uaFy8@gondor.apana.org.au>
 <CAMj1kXGkdp_cwOWeX_49Y5xTCH8Y7X-LnM8pJufCH3yw7anBWQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXGkdp_cwOWeX_49Y5xTCH8Y7X-LnM8pJufCH3yw7anBWQ@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 08, 2022 at 07:05:45PM +0100, Ard Biesheuvel wrote:
>
> We can, as the BUILD_BUG() will catch it if struct sha1_state gets
> modified in an incompatible way.

Thanks for confirming!

---8<---
Instead of casting the function which upsets clang for some reason,
change the assembly function siganture instead.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/arch/arm/crypto/sha1_glue.c b/arch/arm/crypto/sha1_glue.c
index 6c2b849e459d..95a727bcd664 100644
--- a/arch/arm/crypto/sha1_glue.c
+++ b/arch/arm/crypto/sha1_glue.c
@@ -21,31 +21,29 @@
 
 #include "sha1.h"
 
-asmlinkage void sha1_block_data_order(u32 *digest,
-		const unsigned char *data, unsigned int rounds);
+asmlinkage void sha1_block_data_order(struct sha1_state *digest,
+		const u8 *data, int rounds);
 
 int sha1_update_arm(struct shash_desc *desc, const u8 *data,
 		    unsigned int len)
 {
-	/* make sure casting to sha1_block_fn() is safe */
+	/* make sure signature matches sha1_block_fn() */
 	BUILD_BUG_ON(offsetof(struct sha1_state, state) != 0);
 
-	return sha1_base_do_update(desc, data, len,
-				   (sha1_block_fn *)sha1_block_data_order);
+	return sha1_base_do_update(desc, data, len, sha1_block_data_order);
 }
 EXPORT_SYMBOL_GPL(sha1_update_arm);
 
 static int sha1_final(struct shash_desc *desc, u8 *out)
 {
-	sha1_base_do_finalize(desc, (sha1_block_fn *)sha1_block_data_order);
+	sha1_base_do_finalize(desc, sha1_block_data_order);
 	return sha1_base_finish(desc, out);
 }
 
 int sha1_finup_arm(struct shash_desc *desc, const u8 *data,
 		   unsigned int len, u8 *out)
 {
-	sha1_base_do_update(desc, data, len,
-			    (sha1_block_fn *)sha1_block_data_order);
+	sha1_base_do_update(desc, data, len, sha1_block_data_order);
 	return sha1_final(desc, out);
 }
 EXPORT_SYMBOL_GPL(sha1_finup_arm);
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
