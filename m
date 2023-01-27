Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CFF667ED22
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 19:13:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235059AbjA0SNu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 13:13:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234569AbjA0SNj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 13:13:39 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 431838015A;
        Fri, 27 Jan 2023 10:13:22 -0800 (PST)
Received: from jupiter.universe (dyndsl-095-033-159-051.ewe-ip-backbone.de [95.33.159.51])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 62F2F6602E9E;
        Fri, 27 Jan 2023 18:13:20 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1674843200;
        bh=JW5wBxdojw4K7oF/wR5FR58bBfyVL9FjXxsrFAVyCDc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LiWYgR3rPDBegJgLjGad1jVFJY2nvkR6OYFMv/i1EHpfrvTfroONHgfZfNbw2PUeT
         CPyPAhfWewwyt7iaSK6vvTZUwuPQ0rDSnWVn4Mt7kR5IhSTxAlUKsN3PolD9Bo6eJ6
         ioS2frcLnpUWIfcsxbIMwvbepIIjIgAlxPZrc3j5dyzZNh03n0yFEBHuY3ze6mj7Ac
         k5eHcHgsJvAQ/lWOMCyEkQ92ZcNnWuGB8Ei2J7juwHe6P9uAZlZWNPTrWe4K5iIgkP
         obeTwGISr3KKAByNJME+1Nqmwbc4224pHSIJl+qCdOuvSD2voTevfGdG7oY0TjWntG
         hlNaa5AEPWX5g==
Received: by jupiter.universe (Postfix, from userid 1000)
        id 312AE480117; Fri, 27 Jan 2023 19:13:17 +0100 (CET)
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
Subject: [PATCHv6 02/11] mfd: rk808: convert to device managed resources
Date:   Fri, 27 Jan 2023 19:12:35 +0100
Message-Id: <20230127181244.160887-3-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230127181244.160887-1-sebastian.reichel@collabora.com>
References: <20230127181244.160887-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fully convert the driver to device managed resources.

Acked-for-MFD-by: Lee Jones <lee@kernel.org>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/mfd/rk808.c | 64 ++++++++++++++++-----------------------------
 1 file changed, 22 insertions(+), 42 deletions(-)

diff --git a/drivers/mfd/rk808.c b/drivers/mfd/rk808.c
index f44fc3f080a8..4f5dca76bb54 100644
--- a/drivers/mfd/rk808.c
+++ b/drivers/mfd/rk808.c
@@ -547,13 +547,11 @@ static const struct regmap_irq_chip rk818_irq_chip = {
 	.init_ack_masked = true,
 };
 
-static struct i2c_client *rk808_i2c_client;
-
-static void rk808_pm_power_off(void)
+static int rk808_power_off(struct sys_off_data *data)
 {
+	struct rk808 *rk808 = data->cb_data;
 	int ret;
 	unsigned int reg, bit;
-	struct rk808 *rk808 = i2c_get_clientdata(rk808_i2c_client);
 
 	switch (rk808->variant) {
 	case RK805_ID:
@@ -574,16 +572,18 @@ static void rk808_pm_power_off(void)
 		bit = DEV_OFF;
 		break;
 	default:
-		return;
+		return NOTIFY_DONE;
 	}
 	ret = regmap_update_bits(rk808->regmap, reg, bit, bit);
 	if (ret)
-		dev_err(&rk808_i2c_client->dev, "Failed to shutdown device!\n");
+		dev_err(&rk808->i2c->dev, "Failed to shutdown device!\n");
+
+	return NOTIFY_DONE;
 }
 
-static int rk808_restart_notify(struct notifier_block *this, unsigned long mode, void *cmd)
+static int rk808_restart(struct sys_off_data *data)
 {
-	struct rk808 *rk808 = i2c_get_clientdata(rk808_i2c_client);
+	struct rk808 *rk808 = data->cb_data;
 	unsigned int reg, bit;
 	int ret;
 
@@ -599,16 +599,11 @@ static int rk808_restart_notify(struct notifier_block *this, unsigned long mode,
 	}
 	ret = regmap_update_bits(rk808->regmap, reg, bit, bit);
 	if (ret)
-		dev_err(&rk808_i2c_client->dev, "Failed to restart device!\n");
+		dev_err(&rk808->i2c->dev, "Failed to restart device!\n");
 
 	return NOTIFY_DONE;
 }
 
-static struct notifier_block rk808_restart_handler = {
-	.notifier_call = rk808_restart_notify,
-	.priority = 192,
-};
-
 static void rk8xx_shutdown(struct i2c_client *client)
 {
 	struct rk808 *rk808 = i2c_get_clientdata(client);
@@ -744,9 +739,9 @@ static int rk808_probe(struct i2c_client *client)
 		return -EINVAL;
 	}
 
-	ret = regmap_add_irq_chip(rk808->regmap, client->irq,
-				  IRQF_ONESHOT, -1,
-				  rk808->regmap_irq_chip, &rk808->irq_data);
+	ret = devm_regmap_add_irq_chip(&client->dev, rk808->regmap, client->irq,
+				       IRQF_ONESHOT, -1,
+				       rk808->regmap_irq_chip, &rk808->irq_data);
 	if (ret) {
 		dev_err(&client->dev, "Failed to add irq_chip %d\n", ret);
 		return ret;
@@ -770,17 +765,23 @@ static int rk808_probe(struct i2c_client *client)
 			      regmap_irq_get_domain(rk808->irq_data));
 	if (ret) {
 		dev_err(&client->dev, "failed to add MFD devices %d\n", ret);
-		goto err_irq;
+		return ret;
 	}
 
 	if (of_property_read_bool(np, "rockchip,system-power-controller")) {
-		rk808_i2c_client = client;
-		pm_power_off = rk808_pm_power_off;
+		ret = devm_register_sys_off_handler(&client->dev,
+				    SYS_OFF_MODE_POWER_OFF_PREPARE, SYS_OFF_PRIO_HIGH,
+				    &rk808_power_off, rk808);
+		if (ret)
+			return dev_err_probe(&client->dev, ret,
+					     "failed to register poweroff handler\n");
 
 		switch (rk808->variant) {
 		case RK809_ID:
 		case RK817_ID:
-			ret = register_restart_handler(&rk808_restart_handler);
+			ret = devm_register_sys_off_handler(&client->dev,
+							    SYS_OFF_MODE_RESTART, SYS_OFF_PRIO_HIGH,
+							    &rk808_restart, rk808);
 			if (ret)
 				dev_warn(&client->dev, "failed to register rst handler, %d\n", ret);
 			break;
@@ -791,26 +792,6 @@ static int rk808_probe(struct i2c_client *client)
 	}
 
 	return 0;
-
-err_irq:
-	regmap_del_irq_chip(client->irq, rk808->irq_data);
-	return ret;
-}
-
-static void rk808_remove(struct i2c_client *client)
-{
-	struct rk808 *rk808 = i2c_get_clientdata(client);
-
-	regmap_del_irq_chip(client->irq, rk808->irq_data);
-
-	/**
-	 * pm_power_off may points to a function from another module.
-	 * Check if the pointer is set by us and only then overwrite it.
-	 */
-	if (pm_power_off == rk808_pm_power_off)
-		pm_power_off = NULL;
-
-	unregister_restart_handler(&rk808_restart_handler);
 }
 
 static int __maybe_unused rk8xx_suspend(struct device *dev)
@@ -867,7 +848,6 @@ static struct i2c_driver rk808_i2c_driver = {
 		.pm = &rk8xx_pm_ops,
 	},
 	.probe_new = rk808_probe,
-	.remove   = rk808_remove,
 	.shutdown = rk8xx_shutdown,
 };
 
-- 
2.39.0

