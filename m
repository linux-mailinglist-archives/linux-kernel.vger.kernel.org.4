Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69ED4694BE7
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 17:00:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231341AbjBMQAD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 11:00:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231377AbjBMP7y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 10:59:54 -0500
Received: from mail.fris.de (mail.fris.de [116.203.77.234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3061B170B
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 07:59:53 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 62C89C02BC;
        Mon, 13 Feb 2023 16:59:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
        t=1676303991; h=from:subject:date:message-id:to:cc:mime-version:
         content-transfer-encoding:in-reply-to:references;
        bh=ewI3/QSFAFiKru2ko/nlJ095/aScxxTskV5+d8BLT6c=;
        b=MkxlcLA52COrYKwd2SoBvgutpxQZJImOoLVAkw9FeZ0nceRbak4lumMdpIsJWoWID4tQRy
        hXWpOQsrdLwCpl6poVxqDhir0lWNz+xjFxc+tiVvZIKLci6ydHnApMYS2+PvXWL076oQoF
        9PXOo4LXv3qKFGSpwp00Up0AGN+l52Gj0j9BeCYNS3261Ixeeh9F5jUZMICnG+6nm8EXrN
        F9HcpKZYsherzW3CZcwXkhAZQGwsEa6F72qeP4N+qIhTQFAK5SUDmjsgoqqQBE3WQdvrWF
        onBq0yzO+ykz3kQC+lggNTL5DTqfHpbx72fqzWH3cLOsXV7ttWhy49Bdv2VTqQ==
From:   Frieder Schrempf <frieder@fris.de>
To:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Cc:     Marek Vasut <marex@denx.de>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Per-Daniel Olsson <perdo@axis.com>,
        Rickard x Andersson <rickaran@axis.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Subject: [PATCH 3/6] Revert "regulator: pca9450: Add SD_VSEL GPIO for LDO5"
Date:   Mon, 13 Feb 2023 16:58:21 +0100
Message-Id: <20230213155833.1644366-4-frieder@fris.de>
In-Reply-To: <20230213155833.1644366-1-frieder@fris.de>
References: <20230213155833.1644366-1-frieder@fris.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frieder Schrempf <frieder.schrempf@kontron.de>

This reverts commit 8c67a11bae889f51fe5054364c3c789dfae3ad73.

It turns out that all boards using the PCA9450 actually have the
SD_VSEL input conencted to the VSELECT signal of the SoCs SD/MMC
interface. Therefore we don't need manual control for this signal
via GPIO and threre aren't any users.

Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 drivers/regulator/pca9450-regulator.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/regulator/pca9450-regulator.c b/drivers/regulator/pca9450-regulator.c
index a815666566b5..804a22c0e376 100644
--- a/drivers/regulator/pca9450-regulator.c
+++ b/drivers/regulator/pca9450-regulator.c
@@ -5,7 +5,6 @@
  */
 
 #include <linux/err.h>
-#include <linux/gpio/consumer.h>
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
@@ -33,7 +32,6 @@ struct pca9450_regulator_desc {
 struct pca9450 {
 	struct device *dev;
 	struct regmap *regmap;
-	struct gpio_desc *sd_vsel_gpio;
 	enum pca9450_chip_type type;
 	unsigned int rcnt;
 	int irq;
@@ -834,18 +832,6 @@ static int pca9450_i2c_probe(struct i2c_client *i2c)
 		}
 	}
 
-	/*
-	 * The driver uses the LDO5CTRL_H register to control the LDO5 regulator.
-	 * This is only valid if the SD_VSEL input of the PMIC is high. Let's
-	 * check if the pin is available as GPIO and set it to high.
-	 */
-	pca9450->sd_vsel_gpio = gpiod_get_optional(pca9450->dev, "sd-vsel", GPIOD_OUT_HIGH);
-
-	if (IS_ERR(pca9450->sd_vsel_gpio)) {
-		dev_err(&i2c->dev, "Failed to get SD_VSEL GPIO\n");
-		return PTR_ERR(pca9450->sd_vsel_gpio);
-	}
-
 	dev_info(&i2c->dev, "%s probed.\n",
 		type == PCA9450_TYPE_PCA9450A ? "pca9450a" : "pca9450bc");
 
-- 
2.39.1

