Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22FFB5EBDD9
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 10:56:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbiI0I4M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 04:56:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231181AbiI0I4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 04:56:07 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9B3367CAB
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 01:56:05 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id l8so6082482wmi.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 01:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=bEQ+cO4PtSvPHzqNY25Rk57cl8sc42zs+u1n/Vf8KZg=;
        b=XOIvxDxpY8g1tcDM9f3ZfJNAfiXKalsyBRMkO6YU1eeQ2kIfWL9DQ/j4zmvwazNZXd
         UNhVd6jnOgv6MD0rqH548Mf7l5ZwaPA+gZcqeoo11t+0ZSW48HUgNQCUqLYNXP4D3ApU
         rK5ZKovFnxJcUiwkzVx5J3oyBaGbsA/tY8pIDSvvHhtye8mlL0iQCBEocGUALy5WNhLF
         81ZbVXHb6EHFRL6r56Xw204S7+CQghY04kYmyHf4Xku82mUumsYbb/Vgq75I3NSA7/D+
         FFGBUbdvbGmUgZPuvD2FNKg2Z2sXHjsrYEmgiudPo0+Vp/mQU8D/Xs57iktslVuXYj/n
         AmvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=bEQ+cO4PtSvPHzqNY25Rk57cl8sc42zs+u1n/Vf8KZg=;
        b=kRD75eLTjKiD3AqLZoEfKS8IZi4oHO5hB1/5FdJ8xEx9aPMUJQ+sgcd/ny26stbEFy
         kzE8SSjBT5KqQ+HrWfcv2n74S0WoXDVmjuDhZIXrxuAVzsz4clvHKqiOBVfHDbpLP0tD
         IDYhE5L5mRs5VnrAqoUUo+46o9ti32WgjPueeSJFv4lRq/GA9NEdbSLnp07QX6N7+jq9
         axApjvJnSYzCDTzwZX01pLWCKeLvota5s9HsN+CfxEhJQ7fXrg/P2SQmFcQ7H5YBDbaM
         QnydjHX4iRlk0pn4H3TxNtVavFzRnwooou6aVg87SErtSLnGGntUS3RsNlgh9z0e5SQ3
         Cygw==
X-Gm-Message-State: ACrzQf2nQH8RnX/rwOs2OAONxGqTm59UNn4HK1BUdjx0B7jzi8ZCOmiv
        u7xB5HK05UdrgIOybOLjF4fNRw==
X-Google-Smtp-Source: AMsMyM6dnWsD/C8sFek13thSn84HTvLHGHHhfLDclUX5OEqJ+U7Jyg5vYkgBcr7E1Hl6m25sd9Tbcw==
X-Received: by 2002:a05:600c:310b:b0:3b4:c618:180d with SMTP id g11-20020a05600c310b00b003b4c618180dmr1773755wmo.25.1664268964293;
        Tue, 27 Sep 2022 01:56:04 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id t126-20020a1c4684000000b003b505d26776sm13183734wma.5.2022.09.27.01.56.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 01:56:03 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     dan.carpenter@oracle.com, davem@davemloft.net,
        herbert@gondor.apana.org.au, jernej.skrabec@gmail.com,
        samuel@sholland.org, wens@csie.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev,
        linux-sunxi@googlegroups.com, Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH] crypto: allwinner: sun8i-ss: use dma_addr instead u32
Date:   Tue, 27 Sep 2022 08:55:55 +0000
Message-Id: <20220927085555.3196257-1-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DMA address need to be stored in a dma_addr_t

Fixes: 359e893e8af4 ("crypto: sun8i-ss - rework handling of IV")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/crypto/allwinner/sun8i-ss/sun8i-ss-cipher.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-cipher.c b/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-cipher.c
index 910d6751644c..902f6be057ec 100644
--- a/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-cipher.c
+++ b/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-cipher.c
@@ -124,7 +124,7 @@ static int sun8i_ss_setup_ivs(struct skcipher_request *areq)
 	unsigned int ivsize = crypto_skcipher_ivsize(tfm);
 	struct sun8i_ss_flow *sf = &ss->flows[rctx->flow];
 	int i = 0;
-	u32 a;
+	dma_addr_t a;
 	int err;
 
 	rctx->ivlen = ivsize;
-- 
2.35.1

