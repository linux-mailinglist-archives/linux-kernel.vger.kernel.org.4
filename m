Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B0A56B03E0
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 11:19:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230383AbjCHKTi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 05:19:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230232AbjCHKT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 05:19:29 -0500
Received: from 167-179-156-38.a7b39c.syd.nbn.aussiebb.net (167-179-156-38.a7b39c.syd.nbn.aussiebb.net [167.179.156.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E3DDB56C1;
        Wed,  8 Mar 2023 02:19:26 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1pZqsz-001e47-6J; Wed, 08 Mar 2023 18:19:06 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Wed, 08 Mar 2023 18:19:05 +0800
Date:   Wed, 8 Mar 2023 18:19:05 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Lionel Debieve <lionel.debieve@foss.st.com>,
        Li kunyu <kunyu@nfschina.com>, davem@davemloft.net,
        linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com, mcoquelin.stm32@gmail.com
Subject: Re: [v5 PATCH 7/7] crypto: stm32 - Save and restore between each
 request
Message-ID: <ZAhhGch6TtI8LA6x@gondor.apana.org.au>
References: <ZAVu/XHbL9IR5D3h@gondor.apana.org.au>
 <E1pZ2fs-000e27-4H@formenos.hmeau.com>
 <CACRpkdY8iN_ga0VuQ-z=8KUWaJ6=5rh2vZEwcp+oNgcBuPFk=g@mail.gmail.com>
 <ZAcNhtm/+mik1N2m@gondor.apana.org.au>
 <CACRpkdbcrCa9v82xVWtixWdDPvCu6E6Rkw-3Vg3APisdvYGwqQ@mail.gmail.com>
 <ZAf/rAbc3bMIwBcr@gondor.apana.org.au>
 <ZAgDku9htWcetafb@gondor.apana.org.au>
 <CACRpkdZ-zPZG4jK-AF2YF0wUFb8qrKBeoa4feb1qJ9SPusjv+Q@mail.gmail.com>
 <ZAhfBmlNHUpGEwW3@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZAhfBmlNHUpGEwW3@gondor.apana.org.au>
X-Spam-Status: No, score=2.7 required=5.0 tests=BAYES_00,HELO_DYNAMIC_IPADDR2,
        PDS_RDNS_DYNAMIC_FP,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,TVD_RCVD_IP,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 08, 2023 at 06:10:14PM +0800, Herbert Xu wrote:
>
> If it's just empty messages, which we know are broken with ux500
> to begin with, then we can simply not do the hash at all (doing
> it and then throwing it away seems pointless).

Here is a patch to not process empty messages at all.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
--
diff --git a/drivers/crypto/stm32/stm32-hash.c b/drivers/crypto/stm32/stm32-hash.c
index ff6e4f1e47ed..3f436fa0e5c1 100644
--- a/drivers/crypto/stm32/stm32-hash.c
+++ b/drivers/crypto/stm32/stm32-hash.c
@@ -374,9 +374,15 @@ static int stm32_hash_xmit_cpu(struct stm32_hash_dev *hdev,
 	const u32 *buffer = (const u32 *)buf;
 	u32 reg;
 
-	if (final)
+	if (final) {
 		hdev->flags |= HASH_FLAGS_FINAL;
 
+		/* Do not process empty messages if hw is buggy. */
+		if (!(hdev->flags & HASH_FLAGS_INIT) && !length &&
+		    hdev->pdata->broken_emptymsg)
+			return 0;
+	}
+
 	len32 = DIV_ROUND_UP(length, sizeof(u32));
 
 	dev_dbg(hdev->dev, "%s: length: %zd, final: %x len32 %i\n",
