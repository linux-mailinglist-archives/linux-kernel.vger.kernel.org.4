Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C372570D14D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 04:33:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234681AbjEWCd4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 22:33:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232034AbjEWCdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 22:33:55 -0400
Received: from 167-179-156-38.a7b39c.syd.nbn.aussiebb.net (167-179-156-38.a7b39c.syd.nbn.aussiebb.net [167.179.156.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72BFF185;
        Mon, 22 May 2023 19:33:51 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1q1HqE-00C99V-IG; Tue, 23 May 2023 10:33:39 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Tue, 23 May 2023 10:33:38 +0800
Date:   Tue, 23 May 2023 10:33:38 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Conor Dooley <conor.dooley@microchip.com>
Cc:     Linux Crypto List <linux-crypto@vger.kernel.org>,
        Huan Feng <huan.feng@starfivetech.com>,
        Jia Jie Ho <jiajie.ho@starfivetech.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: [PATCH] crypto: starfive - Depend on AMBA_PL08X instead of selecting
 it
Message-ID: <ZGwmAp5RPqAjVMCg@gondor.apana.org.au>
References: <20230522105257.562cb1ec@canb.auug.org.au>
 <ZGr6aB9uJVnyfJQ9@gondor.apana.org.au>
 <20230523103637.20175fbc@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230523103637.20175fbc@canb.auug.org.au>
X-Spam-Status: No, score=2.7 required=5.0 tests=BAYES_00,HELO_DYNAMIC_IPADDR2,
        RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,TVD_RCVD_IP,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 23, 2023 at 10:36:37AM +1000, Stephen Rothwell wrote:
> 
> That did not fix it :-(

OK, this patch should fix it:

---8<---
A platform option like AMBA should never be selected by a driver.
Use a dependency instead.

Also remove the depenency on DMADEVICES because the driver builds
just fine without it.  Instead add a dependency on HAS_DMA for dma
mapping support.

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Reported-by: Conor Dooley <conor.dooley@microchip.com> 
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/drivers/crypto/starfive/Kconfig b/drivers/crypto/starfive/Kconfig
index 908c162ba79a..59002abcc0ad 100644
--- a/drivers/crypto/starfive/Kconfig
+++ b/drivers/crypto/starfive/Kconfig
@@ -4,14 +4,13 @@
 
 config CRYPTO_DEV_JH7110
 	tristate "StarFive JH7110 cryptographic engine driver"
-	depends on (SOC_STARFIVE || COMPILE_TEST) && DMADEVICES
+	depends on SOC_STARFIVE || AMBA_PL08X || COMPILE_TEST
+	depends on HAS_DMA
 	select CRYPTO_ENGINE
 	select CRYPTO_HMAC
 	select CRYPTO_SHA256
 	select CRYPTO_SHA512
 	select CRYPTO_SM3_GENERIC
-	select ARM_AMBA
-	select AMBA_PL08X
 	help
 	  Support for StarFive JH7110 crypto hardware acceleration engine.
 	  This module provides acceleration for public key algo,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
