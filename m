Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC19E5EE958
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 00:24:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbiI1WYy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 18:24:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234078AbiI1WYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 18:24:49 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13C692018B;
        Wed, 28 Sep 2022 15:24:46 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id cc5so21857765wrb.6;
        Wed, 28 Sep 2022 15:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=tOCqao0F0QwSSCGrvEuCDfM8iTqn8ZX98V4N0X8hr3Y=;
        b=XScKVakNg/IrTdv6P6I92z+G9E2jmAA/hory7em/M8GNMUaNnGu22NDfC3NM21+dSo
         EdpCCD5iO0ddI6UiA2j9EtpLRkPYu53XYy/VaLyi9uefs/XXLc9u6wDNLWwDwH1xfCEW
         JbhX97lZ1ssGGLQD735t6HtopU35eXou3UoCFHsP49WjyMOVtIUkq5w7+ig369HovQpa
         azVWKjXdDnyimh3jZvy0HrX8rZ1sBYqceAK82tY64CzOurwCMNy7v+4UKACfCihuARdz
         9YMt5WlB20cixH1o6i4vi1eYhqfm5ySzUC6GxnXPSwjcKKaLVMzOnbDPNX5cKVaKbDrH
         fRDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=tOCqao0F0QwSSCGrvEuCDfM8iTqn8ZX98V4N0X8hr3Y=;
        b=gYKDIYqhy7VugM/rV4bIXosWwxwBR0qfazvJF+2gN+b7uQt7tp1lFpEmpMsnCmEucw
         OOZt3kTK1SurgJcc78ZRw+OqMnxSr2uCgmL+PK8NyGQVLFN+Ic7X7El5f8cduldAGyVD
         1jOH6tZYCBmlN+x5V+mQt1p8dStAxbG+Ncjdo957IKF3Y+snfSiUosvkWNPyPxc8F0YY
         3N5IeHWKwPYmP6zXE9X5J8VcRxzBqCy7To41HHXdByGrE7bR5w6DtLlQS8tTbt3iYcDQ
         TgtqitcQsWH5qQy9vaNroQ94xuBVpAX2yK3cCV3x0BTiVB9e7XocztEcmJB45mhYHLxV
         15vQ==
X-Gm-Message-State: ACrzQf05akSmVNmxsK8sXigDyC6ySsXMPbi+kHAtr61JMyD1xEHlv36n
        cnzBmcyvroVfVyKSYv+40h9EnoLZsA3wGg==
X-Google-Smtp-Source: AMsMyM6Dx3qK/uOKDRkcxuP3IeSlkDVMCFpOi2jj5uBMViSsDQ+R61gatBIT/3Zw/8lMBGlFnvacSQ==
X-Received: by 2002:a05:6000:10d2:b0:228:d60b:6d5a with SMTP id b18-20020a05600010d200b00228d60b6d5amr41346wrx.146.1664403885112;
        Wed, 28 Sep 2022 15:24:45 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id k1-20020a056000004100b00228dbf15072sm585114wrx.62.2022.09.28.15.24.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 15:24:44 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Nicolas Toromanoff <nicolas.toromanoff@foss.st.com>,
        linux-crypto@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] crypto: stm32 - Fix spelling mistake "wite" -> "write"
Date:   Wed, 28 Sep 2022 23:24:43 +0100
Message-Id: <20220928222443.68705-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are a couple of spelling mistakes in dev_err messages. Fix them.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/crypto/stm32/stm32-cryp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/stm32/stm32-cryp.c b/drivers/crypto/stm32/stm32-cryp.c
index 59ef541123ae..59638dfce573 100644
--- a/drivers/crypto/stm32/stm32-cryp.c
+++ b/drivers/crypto/stm32/stm32-cryp.c
@@ -1400,7 +1400,7 @@ static void stm32_cryp_irq_write_ccm_padded_data(struct stm32_cryp *cryp)
 	/* wait end of process */
 	err = stm32_cryp_wait_output(cryp);
 	if (err) {
-		dev_err(cryp->dev, "Timeout (wite ccm padded data)\n");
+		dev_err(cryp->dev, "Timeout (write ccm padded data)\n");
 		return stm32_cryp_finish_req(cryp, err);
 	}
 
@@ -1440,7 +1440,7 @@ static void stm32_cryp_irq_write_ccm_padded_data(struct stm32_cryp *cryp)
 	/* h) wait for completion */
 	err = stm32_cryp_wait_busy(cryp);
 	if (err)
-		dev_err(cryp->dev, "Timeout (wite ccm padded data)\n");
+		dev_err(cryp->dev, "Timeout (write ccm padded data)\n");
 
 	/* i) run the he normal Final phase */
 	stm32_cryp_finish_req(cryp, err);
-- 
2.37.1

