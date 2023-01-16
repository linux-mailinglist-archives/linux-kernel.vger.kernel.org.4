Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E50666BA1D
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 10:19:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbjAPJTD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 04:19:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232156AbjAPJRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 04:17:54 -0500
Received: from formenos.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 136DDF76B;
        Mon, 16 Jan 2023 01:17:25 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1pHLcF-000RAu-NC; Mon, 16 Jan 2023 17:17:20 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Mon, 16 Jan 2023 17:17:19 +0800
Date:   Mon, 16 Jan 2023 17:17:19 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Crypto List <linux-crypto@vger.kernel.org>,
        Danny Tsen <dtsen@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: [PATCH] crypto: p10-aes-gcm - Use _GLOBAL instead of .global
Message-ID: <Y8UWHwTkKIkQn1t0@gondor.apana.org.au>
References: <20230116112939.0820ff24@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230116112939.0820ff24@canb.auug.org.au>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 16, 2023 at 11:29:39AM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the crypto tree, today's linux-next build (powerpc
> ppc64_defconfig) failed like this:
> 
> ERROR: modpost: ".aes_p10_gcm_decrypt" [arch/powerpc/crypto/p10-aes-gcm-crypto.ko] undefined!
> ERROR: modpost: ".aes_p10_gcm_encrypt" [arch/powerpc/crypto/p10-aes-gcm-crypto.ko] undefined!
> 
> Caused by commits
> 
>   cc40379b6e19 ("crypto: p10-aes-gcm - Glue code for AES/GCM stitched implementation")
>   ca68a96c37eb ("crypto: p10-aes-gcm - An accelerated AES/GCM stitched implementation")

Does this patch help?

> I have used the crypto tree from next-20230113 for today.
> 
> BTW, that series seems to have been committed in the wrong order -
> there are refrerences to files/functions before they are created.

Sorry, this patch series was submitted in this order and I
didn't pick it up when applying it.

---8<---
_GLOBAL is needed instead of .global on Linux in assembly code.

Fixes: cc40379b6e19 ("crypto: p10-aes-gcm - Glue code for AES/GCM stitched implementation")
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/arch/powerpc/crypto/p10_aes_gcm.S b/arch/powerpc/crypto/p10_aes_gcm.S
index 2306ad7c5e36..c25a1837efca 100644
--- a/arch/powerpc/crypto/p10_aes_gcm.S
+++ b/arch/powerpc/crypto/p10_aes_gcm.S
@@ -38,6 +38,8 @@
  # ===================================================================================
  #
 
+#include <asm/ppc_asm.h>
+
 .machine        "any"
 .abiversion     1
 .text
@@ -569,9 +571,8 @@ ppc_aes_gcm_ghash:
  #    rounds is at offset 240 in rk
  #    Xi is at 0 in gcm_table (Xip).
  #
-.global aes_p10_gcm_encrypt
 .align 5
-aes_p10_gcm_encrypt:
+_GLOBAL(aes_p10_gcm_encrypt)
 
 	SAVE_REGS
 
@@ -1109,9 +1110,8 @@ aes_gcm_out:
  #
  # 8x Decrypt
  #
-.global aes_p10_gcm_decrypt
 .align 5
-aes_p10_gcm_decrypt:
+_GLOBAL(aes_p10_gcm_decrypt)
 
 	SAVE_REGS
 
Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
