Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3E676209AB
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 07:43:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233484AbiKHGnK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 01:43:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233499AbiKHGnF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 01:43:05 -0500
Received: from smtp.cesky-hosting.cz (smtp.cesky-hosting.cz [IPv6:2a00:1ed0:2:0:1:5bef:c8ee:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25C3A27CED;
        Mon,  7 Nov 2022 22:42:56 -0800 (PST)
X-Virus-Scanned: Debian amavisd-new at smtp.cesky-hosting.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=elrest.cz;
        s=rampa2-202208; t=1667889774;
        bh=V9/jJPJ9a+5GSM47PiAdHLQKBlIKHvofJMorNo6oRy0=;
        h=From:To:Cc:Subject:Date:From;
        b=vqNnAkr6B/J3zlhwmAFZMQz1PCVkrCGqIn/7icCoiGTrjKwWpJ1Sna3UGkFrRJdFQ
         Eg42cjIgpqbnRiYebkdn9z/ADFOa1RNXWIusvZRo0Rg1yAIfPrgrmhztrL/kOj1nmn
         6e+i17SjVA7tGeNSu3vpqz7CS5ldXeoqo2aNWez4qfCi5Rq9TO/a1YHMsvs7nP9R5z
         5hzD0WRJIj7+gVBUG2tAwx555r/JXWuf88bff9QV8hZqem0Jfe/BOz6APXHQkEkt6l
         hFbcF7MGlfKXHfPKLDEms75Kg9T0kH8PhGprNaoM5oOhKoJxi7onw2T28ObzbkxxO2
         wASwghYQgo5qA==
Received: from localhost.localdomain (unknown [5.181.92.50])
        (Authenticated sender: tomas.marek@elrest.cz)
        by smtp.cesky-hosting.cz (Postfix) with ESMTPSA id 2882078B;
        Tue,  8 Nov 2022 07:42:50 +0100 (CET)
From:   Tomas Marek <tomas.marek@elrest.cz>
To:     mpm@selenic.com, herbert@gondor.apana.org.au
Cc:     mcoquelin.stm32@gmail.com, linux-arm-kernel@lists.infradead.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        alexandre.torgue@foss.st.com
Subject: [PATCH] hwrng: stm32 - rename readl return value
Date:   Tue,  8 Nov 2022 07:42:40 +0100
Message-Id: <20221108064240.30878-1-tomas.marek@elrest.cz>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use a more meaningful name for the readl return value variable.

Link: https://lore.kernel.org/all/Y1J3QwynPFIlfrIv@loth.rohan.me.apana.org.au/

Signed-off-by: Tomas Marek <tomas.marek@elrest.cz>
---
 drivers/char/hw_random/stm32-rng.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/char/hw_random/stm32-rng.c b/drivers/char/hw_random/stm32-rng.c
index 366edda4848b..a6731cf0627a 100644
--- a/drivers/char/hw_random/stm32-rng.c
+++ b/drivers/char/hw_random/stm32-rng.c
@@ -49,13 +49,13 @@ static int stm32_rng_read(struct hwrng *rng, void *data, size_t max, bool wait)
 		/* Manage timeout which is based on timer and take */
 		/* care of initial delay time when enabling rng	*/
 		if (!sr && wait) {
-			int ret;
+			int err;
 
-			ret = readl_relaxed_poll_timeout_atomic(priv->base
+			err = readl_relaxed_poll_timeout_atomic(priv->base
 								   + RNG_SR,
 								   sr, sr,
 								   10, 50000);
-			if (ret)
+			if (err)
 				dev_err((struct device *)priv->rng.priv,
 					"%s: timeout %x!\n", __func__, sr);
 		}
-- 
2.25.1

