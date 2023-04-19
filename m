Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81CF06E7638
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 11:28:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232723AbjDSJ2F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 05:28:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231714AbjDSJ2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 05:28:03 -0400
Received: from 167-179-156-38.a7b39c.syd.nbn.aussiebb.net (167-179-156-38.a7b39c.syd.nbn.aussiebb.net [167.179.156.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E02757AB9;
        Wed, 19 Apr 2023 02:28:00 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1pp46F-00091g-Ap; Wed, 19 Apr 2023 17:27:41 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Wed, 19 Apr 2023 17:27:40 +0800
Date:   Wed, 19 Apr 2023 17:27:40 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     kernel test robot <lkp@intel.com>
Cc:     Robert Elliott <elliott@hpe.com>, llvm@lists.linux.dev,
        oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Subject: [PATCH] crypto: arm/sha1-neon - Fix clang function cast warnings
Message-ID: <ZD+0DJq1NHmMSSja@gondor.apana.org.au>
References: <202304081828.zjGcFUyE-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202304081828.zjGcFUyE-lkp@intel.com>
X-Spam-Status: No, score=2.7 required=5.0 tests=BAYES_00,HELO_DYNAMIC_IPADDR2,
        RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,TVD_RCVD_IP,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of casting the function which upsets clang for some reason,
change the assembly function siganture instead.

Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/oe-kbuild-all/202304081828.zjGcFUyE-lkp@intel.com/
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/arch/arm/crypto/sha1_neon_glue.c b/arch/arm/crypto/sha1_neon_glue.c
index cfe36ae0f3f5..9c70b87e69f7 100644
--- a/arch/arm/crypto/sha1_neon_glue.c
+++ b/arch/arm/crypto/sha1_neon_glue.c
@@ -26,8 +26,8 @@
 
 #include "sha1.h"
 
-asmlinkage void sha1_transform_neon(void *state_h, const char *data,
-				    unsigned int rounds);
+asmlinkage void sha1_transform_neon(struct sha1_state *state_h,
+				    const u8 *data, int rounds);
 
 static int sha1_neon_update(struct shash_desc *desc, const u8 *data,
 			  unsigned int len)
@@ -39,8 +39,7 @@ static int sha1_neon_update(struct shash_desc *desc, const u8 *data,
 		return sha1_update_arm(desc, data, len);
 
 	kernel_neon_begin();
-	sha1_base_do_update(desc, data, len,
-			    (sha1_block_fn *)sha1_transform_neon);
+	sha1_base_do_update(desc, data, len, sha1_transform_neon);
 	kernel_neon_end();
 
 	return 0;
@@ -54,9 +53,8 @@ static int sha1_neon_finup(struct shash_desc *desc, const u8 *data,
 
 	kernel_neon_begin();
 	if (len)
-		sha1_base_do_update(desc, data, len,
-				    (sha1_block_fn *)sha1_transform_neon);
-	sha1_base_do_finalize(desc, (sha1_block_fn *)sha1_transform_neon);
+		sha1_base_do_update(desc, data, len, sha1_transform_neon);
+	sha1_base_do_finalize(desc, sha1_transform_neon);
 	kernel_neon_end();
 
 	return sha1_base_finish(desc, out);
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
