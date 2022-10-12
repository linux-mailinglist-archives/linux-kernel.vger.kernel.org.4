Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA6195FC920
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 18:22:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbiJLQWu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 12:22:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbiJLQWb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 12:22:31 -0400
Received: from smtp.cesky-hosting.cz (smtp.cesky-hosting.cz [IPv6:2a00:1ed0:2:0:1:5bef:c8ee:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F49FF41BF;
        Wed, 12 Oct 2022 09:22:20 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at smtp.cesky-hosting.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=elrest.cz;
        s=rampa2-202208; t=1665591117;
        bh=3PJXsVojE1yIhCWBte/WZxkCcLEvTSwXh4kCjVhKYUs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BM9SRrG5yhctNS3csxOccAcSe9vSkB3S2uNE6KRqTiSY34JigW89/x39nfaRLs6Kf
         dLdUsEwN9Dh/DTG0XEyco++ecN6flXxf9+UxHPG2iNlYEEMuZOm8BKEH9+HT7moR5f
         3+SIWdshFStDyvBTir4GfYUmpMZTWXbXsSYZg3C5Pt+qRoA8q3NAYNJIxcCYhxgjKL
         9V+lRum8MNl+/6ZHJdS/qRZvP4g4dQ9nb6ftCi2bTahAJKB1gxCAPjBGtR63Dy6tUq
         NJ5vJI/+JUHuKiaksFyOdvDS7yF5k7chQ2MrGK7vmdhTC0njx+reJ/Q4zjG5omh2VG
         c6hwfMij99J+g==
X-Thin-Conversation: conversation
Received: from localhost.localdomain (unknown [5.181.92.50])
        (Authenticated sender: tomas.marek@elrest.cz)
        by smtp.cesky-hosting.cz (Postfix) with ESMTPSA id 4FB2E1ACF;
        Wed, 12 Oct 2022 18:11:57 +0200 (CEST)
From:   Tomas Marek <tomas.marek@elrest.cz>
To:     mpm@selenic.com, herbert@gondor.apana.org.au
Cc:     mcoquelin.stm32@gmail.com, linux-arm-kernel@lists.infradead.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        alexandre.torgue@foss.st.com, oleg.karfich@wago.com,
        Tomas Marek <tomas.marek@elrest.cz>
Subject: [PATCH 2/2] hwrng: stm32 - fix read of the last word
Date:   Wed, 12 Oct 2022 18:09:24 +0200
Message-Id: <20221012160924.12226-3-tomas.marek@elrest.cz>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221012160924.12226-1-tomas.marek@elrest.cz>
References: <20221012160924.12226-1-tomas.marek@elrest.cz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The stm32_rng_read() function samples TRNG by 4 bytes until at
least 5 bytes are free in the input buffer. The last four bytes
are never read. For example, 60 bytes are returned in case the
input buffer size is 64 bytes.

Read until at least 4 bytes are free in the input buffer. Fill
the buffer entirely in case the buffer size is divisible by 4.

Cc: Oleg Karfich <oleg.karfich@wago.com>
Signed-off-by: Tomas Marek <tomas.marek@elrest.cz>
---
 drivers/char/hw_random/stm32-rng.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/hw_random/stm32-rng.c b/drivers/char/hw_random/stm32-rng.c
index 8eaacefd498b..366edda4848b 100644
--- a/drivers/char/hw_random/stm32-rng.c
+++ b/drivers/char/hw_random/stm32-rng.c
@@ -44,7 +44,7 @@ static int stm32_rng_read(struct hwrng *rng, void *data, size_t max, bool wait)
 
 	pm_runtime_get_sync((struct device *) priv->rng.priv);
 
-	while (max > sizeof(u32)) {
+	while (max >= sizeof(u32)) {
 		sr = readl_relaxed(priv->base + RNG_SR);
 		/* Manage timeout which is based on timer and take */
 		/* care of initial delay time when enabling rng	*/
-- 
2.17.1

