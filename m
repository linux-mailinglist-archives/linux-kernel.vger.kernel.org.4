Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 637A66F711B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 19:36:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbjEDRgo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 13:36:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbjEDRg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 13:36:29 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64F084ECF;
        Thu,  4 May 2023 10:36:28 -0700 (PDT)
Received: from jupiter.universe (dyndsl-091-248-211-176.ewe-ip-backbone.de [91.248.211.176])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 39637660570B;
        Thu,  4 May 2023 18:36:25 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1683221785;
        bh=BwNYqItpwXGrfyTuzvFjLuZMAbcaEb65/BiVmtlvYi4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aTsA8AK3eGEWfqeH18T6FZiZiHOL0medzyJP/Tv4bkOh/AVPJ0U0GI/aZz7cN47Le
         W7tCVUa2Xae67KCPdkOqybNQlu0aykfhOr9fCOCvuG+GZISLNRmnWQJiHuqfRHhMhu
         QdZthpiOW8/sb9c3RhKnp98mMtWAPjYAWIIec0E8f6KwpiX7POVD+6V6/npmZXuuj7
         cBRaPq5xebLqB4cUUC2R99YLsk/tPk/VXrCof7DmgZVSKLnETLWDIr+7fKbMkRirMF
         LugpdT+C4sJi28x56xuX8sUEES74FqKEMdlZzfvWKtqLP9g/U5tlnMiaNOAnWh1Hnz
         oqkNKbo3aUG9A==
Received: by jupiter.universe (Postfix, from userid 1000)
        id E5FD04807F6; Thu,  4 May 2023 19:36:20 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lee Jones <lee@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        kernel@collabora.com
Subject: [PATCH v8 11/14] regulator: rk808: fix asynchronous probing
Date:   Thu,  4 May 2023 19:36:15 +0200
Message-Id: <20230504173618.142075-12-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230504173618.142075-1-sebastian.reichel@collabora.com>
References: <20230504173618.142075-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the probe routine fails with -EPROBE_DEFER after taking over the
OF node from its parent driver, reprobing triggers pinctrl_bind_pins()
and that will fail. Fix this by setting of_node_reused, so that the
device does not try to setup pin muxing.

For me this always happens once the driver is marked to prefer async
probing and never happens without that flag.

Fixes: 259b93b21a9f ("regulator: Set PROBE_PREFER_ASYNCHRONOUS for drivers that existed in 4.14")
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/regulator/rk808-regulator.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/regulator/rk808-regulator.c b/drivers/regulator/rk808-regulator.c
index 3637e81654a8..80ba782d8923 100644
--- a/drivers/regulator/rk808-regulator.c
+++ b/drivers/regulator/rk808-regulator.c
@@ -1336,6 +1336,7 @@ static int rk808_regulator_probe(struct platform_device *pdev)
 
 	config.dev = &pdev->dev;
 	config.dev->of_node = pdev->dev.parent->of_node;
+	config.dev->of_node_reused = true;
 	config.driver_data = pdata;
 	config.regmap = regmap;
 
-- 
2.39.2

