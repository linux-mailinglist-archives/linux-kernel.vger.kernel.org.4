Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93D5173813E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 13:11:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbjFUJc7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 05:32:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231366AbjFUJbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 05:31:32 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 477DC19B6
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 02:31:17 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3f9c2913133so2871495e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 02:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1687339876; x=1689931876;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iCNYj/86/5sdpI0dqVl7psoKKhFSLSkxZDdeHiB+vfs=;
        b=zKBvUDeuh/AFGKGg1KW0cPS/Z+YJwgyTetO5WMcCNXlsdpA6DjdA+JCVw45yfuzOQ7
         +ggePlPV3BBZnFVirubbyFlazU9n8ZAQj0zkNJ/DD+8+2atf/UTfto6Um/z+4M4Zq6B9
         EjBubPtKj/umzTqO5cGA7NrHohxZE4BCTl1MBpXkc8BnPRZwr9YUtV/s4CYuyxjCbokc
         P5vyN9h0L5kRalzYsd99rB177VmsDdNE8fI4EFcRb8+b6tJOlJ8DZiTvy3pnH0pRaWcZ
         tHRdrkMTSwHYtYfyih96fQ+/L8iuf0mZH0mZ5GaI7ysumftvk8TaZMPd5kO9ke+Ysz0U
         X8aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687339876; x=1689931876;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iCNYj/86/5sdpI0dqVl7psoKKhFSLSkxZDdeHiB+vfs=;
        b=GRQp2yFpvayDgr+E+/BaD0Pkt3fujgBD17VMDX9PKA6jGHRtXQyzn0bRvf2+4W0vyM
         3XZQJ5SouyRj0YZ4M0NeHomNBbqdhbI1eUn1W8KSXc1BZdXgeUhMumnAWFnQ29NSQYiZ
         OgeW6jrzNrrlSY+9ZygVz9zpXB2Thl3xC2sgoel5LMnIaoMXluHn3y4iofAIqjWSkBWq
         Nd35ORuOipKhDwmCLrXd7oNLnpRIwpCqNchPYr8C2hYW1tFaeT6R/cxuBCL1Yf5nPRMR
         9RRBY0iOUgIlgcZ0WEXbjd6hPVrhVEW+3JrdIvPRuRU3gG8m2nGshOVxFzvgqWTZwrBW
         VJuA==
X-Gm-Message-State: AC+VfDz9JIPh1C+OkERCfl5d//mul6FOqHwa4Szz1mqskVNAU5deBHav
        zsQEyTdwpO/0TX7wOQtucUgBMA==
X-Google-Smtp-Source: ACHHUZ7UtUgNUTqAfGOg4L/0CMP4+0xc+qarTvVyytZqEa5kddJf6P2sJTX0FK96SnjlHw6+Bk3Cpg==
X-Received: by 2002:a05:600c:248:b0:3f9:b3b4:4367 with SMTP id 8-20020a05600c024800b003f9b3b44367mr5036089wmj.15.1687339875812;
        Wed, 21 Jun 2023 02:31:15 -0700 (PDT)
Received: from blmsp.fritz.box ([2001:4091:a247:82fa:b762:4f68:e1ed:5041])
        by smtp.gmail.com with ESMTPSA id t10-20020a5d49ca000000b002fe96f0b3acsm3977344wrs.63.2023.06.21.02.31.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 02:31:15 -0700 (PDT)
From:   Markus Schneider-Pargmann <msp@baylibre.com>
To:     Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
        Michal Kubiak <michal.kubiak@intel.com>,
        Vivek Yadav <vivek.2311@samsung.com>,
        linux-can@vger.kernel.org, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Simon Horman <simon.horman@corigine.com>,
        Markus Schneider-Pargmann <msp@baylibre.com>
Subject: [PATCH v2 6/6] can: tcan4x5x: Add error messages in probe
Date:   Wed, 21 Jun 2023 11:31:03 +0200
Message-Id: <20230621093103.3134655-7-msp@baylibre.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230621093103.3134655-1-msp@baylibre.com>
References: <20230621093103.3134655-1-msp@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To be able to understand issues during probe easier, add error messages
if something fails.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 drivers/net/can/m_can/tcan4x5x-core.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/drivers/net/can/m_can/tcan4x5x-core.c b/drivers/net/can/m_can/tcan4x5x-core.c
index 756acd122075..e30faa1cf893 100644
--- a/drivers/net/can/m_can/tcan4x5x-core.c
+++ b/drivers/net/can/m_can/tcan4x5x-core.c
@@ -397,6 +397,8 @@ static int tcan4x5x_can_probe(struct spi_device *spi)
 
 	/* Sanity check */
 	if (freq < 20000000 || freq > TCAN4X5X_EXT_CLK_DEF) {
+		dev_err(&spi->dev, "Clock frequency is out of supported range %d\n",
+			freq);
 		ret = -ERANGE;
 		goto out_m_can_class_free_dev;
 	}
@@ -415,32 +417,44 @@ static int tcan4x5x_can_probe(struct spi_device *spi)
 	/* Configure the SPI bus */
 	spi->bits_per_word = 8;
 	ret = spi_setup(spi);
-	if (ret)
+	if (ret) {
+		dev_err(&spi->dev, "SPI setup failed %d\n", ret);
 		goto out_m_can_class_free_dev;
+	}
 
 	ret = tcan4x5x_regmap_init(priv);
-	if (ret)
+	if (ret) {
+		dev_err(&spi->dev, "regmap init failed %d\n", ret);
 		goto out_m_can_class_free_dev;
+	}
 
 	ret = tcan4x5x_power_enable(priv->power, 1);
-	if (ret)
+	if (ret) {
+		dev_err(&spi->dev, "Enabling regulator failed %d\n", ret);
 		goto out_m_can_class_free_dev;
+	}
 
 	ret = tcan4x5x_verify_version(priv, &version_info);
 	if (ret)
 		goto out_power;
 
 	ret = tcan4x5x_get_gpios(mcan_class, version_info);
-	if (ret)
+	if (ret) {
+		dev_err(&spi->dev, "Getting gpios failed %d\n", ret);
 		goto out_power;
+	}
 
 	ret = tcan4x5x_init(mcan_class);
-	if (ret)
+	if (ret) {
+		dev_err(&spi->dev, "tcan initialization failed %d\n", ret);
 		goto out_power;
+	}
 
 	ret = m_can_class_register(mcan_class);
-	if (ret)
+	if (ret) {
+		dev_err(&spi->dev, "Failed registering m_can device %d\n", ret);
 		goto out_power;
+	}
 
 	netdev_info(mcan_class->net, "TCAN4X5X successfully initialized.\n");
 	return 0;
-- 
2.40.1

