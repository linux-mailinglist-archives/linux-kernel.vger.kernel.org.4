Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71C0A6DBF15
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Apr 2023 09:47:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbjDIHrP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Apr 2023 03:47:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjDIHrN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Apr 2023 03:47:13 -0400
Received: from 167-179-156-38.a7b39c.syd.nbn.aussiebb.net (167-179-156-38.a7b39c.syd.nbn.aussiebb.net [167.179.156.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC84259EB;
        Sun,  9 Apr 2023 00:47:10 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1plPlL-00E301-Cu; Sun, 09 Apr 2023 15:47:00 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sun, 09 Apr 2023 15:46:59 +0800
Date:   Sun, 9 Apr 2023 15:46:59 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Tom Zanussi <tom.zanussi@linux.intel.com>
Cc:     clabbe@baylibre.com, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org
Subject: [PATCH] crypto: ixp4xx - Do not check word size when compile testing
Message-ID: <ZDJtc7C6YBgknbTq@gondor.apana.org.au>
References: <37694343f8b89dc0469d4a1718dad8f5f8c765bd.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <37694343f8b89dc0469d4a1718dad8f5f8c765bd.camel@linux.intel.com>
X-Spam-Status: No, score=4.3 required=5.0 tests=HELO_DYNAMIC_IPADDR2,
        RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,TVD_RCVD_IP autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 07, 2023 at 02:37:44PM -0500, Tom Zanussi wrote:
> COMPILE_TEST was added during the move to drivers/crypto/intel/ but
> shouldn't have been as it triggers a build bug when not compiled by
> the target compiler.  So remove it to match the original.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Link: https://lore.kernel.org/oe-kbuild-all/202304061846.G6cpPXiQ-lkp@intel.com/
> Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
> ---
>  drivers/crypto/intel/ixp4xx/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

We could also fix it by making the BUILD_BUG_ON conditional:

---8<---
The BUILD_BUG_ON preventing compilation on foreign architectures
should be disabled when we're doing compile testing.

Fixes: 1bc7fdbf2677 ("crypto: ixp4xx - Move driver to...")
Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/oe-kbuild-all/202304061846.G6cpPXiQ-lkp@intel.com/
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/drivers/crypto/intel/ixp4xx/ixp4xx_crypto.c b/drivers/crypto/intel/ixp4xx/ixp4xx_crypto.c
index b63e2359a133..5d640f13ad1c 100644
--- a/drivers/crypto/intel/ixp4xx/ixp4xx_crypto.c
+++ b/drivers/crypto/intel/ixp4xx/ixp4xx_crypto.c
@@ -263,7 +263,8 @@ static int setup_crypt_desc(void)
 {
 	struct device *dev = &pdev->dev;
 
-	BUILD_BUG_ON(sizeof(struct crypt_ctl) != 64);
+	BUILD_BUG_ON(!IS_ENABLED(CONFIG_COMPILE_TEST) &&
+		     sizeof(struct crypt_ctl) != 64);
 	crypt_virt = dma_alloc_coherent(dev,
 					NPE_QLEN * sizeof(struct crypt_ctl),
 					&crypt_phys, GFP_ATOMIC);
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
