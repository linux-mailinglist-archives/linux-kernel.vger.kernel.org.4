Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 299DD6E756F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 10:38:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232385AbjDSIi3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 04:38:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231308AbjDSIi0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 04:38:26 -0400
Received: from 167-179-156-38.a7b39c.syd.nbn.aussiebb.net (167-179-156-38.a7b39c.syd.nbn.aussiebb.net [167.179.156.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A712D5BA1;
        Wed, 19 Apr 2023 01:38:23 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1pp3KA-00089X-Gl; Wed, 19 Apr 2023 16:38:00 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Wed, 19 Apr 2023 16:37:59 +0800
Date:   Wed, 19 Apr 2023 16:37:59 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     kernel test robot <lkp@intel.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        =?utf-8?Q?=C5=81ukasz?= Stelmach <l.stelmach@samsung.com>,
        linux-samsung-soc@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-amlogic@lists.infradead.org,
        Sean Wang <sean.wang@mediatek.com>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>
Subject: [PATCH] hwrng: Kconfig - Add HAS_IOMEM dependencies for
 exynos/meson/mtk/npcm
Message-ID: <ZD+oZ9DWiTxeo3RY@gondor.apana.org.au>
References: <202304191106.swKbBeDh-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202304191106.swKbBeDh-lkp@intel.com>
X-Spam-Status: No, score=2.7 required=5.0 tests=BAYES_00,HELO_DYNAMIC_IPADDR2,
        RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,TVD_RCVD_IP,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 19, 2023 at 11:43:42AM +0800, kernel test robot wrote:
>
>    s390-linux-ld: drivers/char/hw_random/exynos-trng.o: in function `exynos_trng_probe':
>    exynos-trng.c:(.text+0x39e): undefined reference to `devm_platform_ioremap_resource'
>    s390-linux-ld: drivers/char/hw_random/meson-rng.o: in function `meson_rng_probe':
>    meson-rng.c:(.text+0x10a): undefined reference to `devm_platform_ioremap_resource'
>    s390-linux-ld: drivers/char/hw_random/mtk-rng.o: in function `mtk_rng_probe':
>    mtk-rng.c:(.text+0x40e): undefined reference to `devm_platform_ioremap_resource'
>    s390-linux-ld: drivers/char/hw_random/npcm-rng.o: in function `npcm_rng_probe':
>    npcm-rng.c:(.text+0x2ca): undefined reference to `devm_platform_ioremap_resource'

OK, this patch should fix these ones at least:

---8<---
Add missing dependencies on HAS_IOMEM as otherwise they will trigger
failed builds with COMPILE_TEST enabled.

Also add dependencies on OF where appropriate.

Change the default so that these drivers are not enabled just because
COMPILE_TEST is turned on.

Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/oe-kbuild-all/202304191106.swKbBeDh-lkp@intel.com/
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/drivers/char/hw_random/Kconfig b/drivers/char/hw_random/Kconfig
index ae508e96cfc2..f3146470ce88 100644
--- a/drivers/char/hw_random/Kconfig
+++ b/drivers/char/hw_random/Kconfig
@@ -400,9 +400,9 @@ config HW_RANDOM_POLARFIRE_SOC
 
 config HW_RANDOM_MESON
 	tristate "Amlogic Meson Random Number Generator support"
-	depends on HW_RANDOM
 	depends on ARCH_MESON || COMPILE_TEST
-	default y
+	depends on HAS_IOMEM && OF
+	default HW_RANDOM if ARCH_MESON
 	help
 	  This driver provides kernel-side support for the Random Number
 	  Generator hardware found on Amlogic Meson SoCs.
@@ -427,9 +427,9 @@ config HW_RANDOM_CAVIUM
 
 config HW_RANDOM_MTK
 	tristate "Mediatek Random Number Generator support"
-	depends on HW_RANDOM
 	depends on ARCH_MEDIATEK || COMPILE_TEST
-	default y
+	depends on HAS_IOMEM && OF
+	default HW_RANDOM if ARCH_MEDIATEK
 	help
 	  This driver provides kernel-side support for the Random Number
 	  Generator hardware found on Mediatek SoCs.
@@ -456,7 +456,8 @@ config HW_RANDOM_S390
 config HW_RANDOM_EXYNOS
 	tristate "Samsung Exynos True Random Number Generator support"
 	depends on ARCH_EXYNOS || COMPILE_TEST
-	default HW_RANDOM
+	depends on HAS_IOMEM
+	default HW_RANDOM if ARCH_EXYNOS
 	help
 	  This driver provides support for the True Random Number
 	  Generator available in Exynos SoCs.
@@ -483,7 +484,8 @@ config HW_RANDOM_OPTEE
 config HW_RANDOM_NPCM
 	tristate "NPCM Random Number Generator support"
 	depends on ARCH_NPCM || COMPILE_TEST
-	default HW_RANDOM
+	depends on HAS_IOMEM
+	default HW_RANDOM if ARCH_NPCM
 	help
 	  This driver provides support for the Random Number
 	  Generator hardware available in Nuvoton NPCM SoCs.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
