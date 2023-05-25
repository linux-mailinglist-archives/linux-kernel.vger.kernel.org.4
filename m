Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16D5A7105E1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 09:00:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234549AbjEYHAd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 03:00:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbjEYHAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 03:00:31 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9064DE47
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 00:00:29 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-510d6e1f1abso3969638a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 00:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684998028; x=1687590028;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JadIsMTsJ92GVWq2DDb6+uGxVPHVaTT+yhE6DV4FGg8=;
        b=PcF02pS9UagN9j65JNVgpj49EsPnJJeiRr2XIYIragHySmAWbfFlUTGS+VR0j/BkHS
         QOCjQCwzb8uA1lO2p6wR/DRshUJx4exZdhewT3CIjcajrShYMQQsbmjDNWU+myWVAQM9
         KUJQfWbLojJRLAY+KyM6X+ABIj2ylanVkkwjfVnRVaEYUN4EjKXzFeE2w85kZejVP9/M
         0U9J10gZu0Ex9ABbTEd9kQ8uekpfL6O9RpTtsFQ4+KWcZvxLXk+cHZk+IYfdZkYzDC+v
         6ZPDFHAhyQUWZrr5txxxoxDoarkvRAz9crqqmcseAfJr6qo/yPJaQL/k9n1VMqfHHmNC
         /pVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684998028; x=1687590028;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JadIsMTsJ92GVWq2DDb6+uGxVPHVaTT+yhE6DV4FGg8=;
        b=bP0STCqeVEHB292lSzdAJYwplI55n+p8ATrlW9lf+GrQXfnriGZ7l2UADeYoPs4AVP
         wSixPB2Wl1E3ntQw/Y5QP46J5cJOr8Lk6f5KUQ2cYaL9prg1R300urlPhlrVmzdIb2Pg
         Bu3yiJXAmE04b7E0woU4tbJLySGuwH0i330SR7/GsbOrbYR0zlgKUHF2TLxwW6apMdwz
         lqW7fB4Nu2Ror0tz2NRQDV0TxeMh5Z8W7lD7XowWP5iQ+V6e2cB0m3URGgNnHPU3IfNR
         wBJXWqMhmyOJSpm9vLA7b7YeVIJUfcUOt5ZpCIqb9KcO20sukpzta4WBSlc239D4orMm
         L7Qg==
X-Gm-Message-State: AC+VfDxRsALC+xTMeIzXsNxG8hk4Lu+WFmtbOlLP2tabkc1ONuPK1RGc
        M5Pta5YFDmYaTZrWBY4agkA=
X-Google-Smtp-Source: ACHHUZ6ly4kMiHyfuzLJOGx9PXe0SUufmozsiz+WXgYGfTHm0DcucxcZQEEMkd+IOez3iEE2+mu64A==
X-Received: by 2002:a17:906:9c82:b0:94f:1a23:2f1c with SMTP id fj2-20020a1709069c8200b0094f1a232f1cmr729972ejc.50.1684998027690;
        Thu, 25 May 2023 00:00:27 -0700 (PDT)
Received: from computer001049.comelit.it (net-2-40-105-25.cust.vodafonedsl.it. [2.40.105.25])
        by smtp.gmail.com with ESMTPSA id x15-20020a170906148f00b00969f13d886fsm423452ejc.71.2023.05.25.00.00.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 May 2023 00:00:26 -0700 (PDT)
From:   Milo Spadacini <milo.spadacini@gmail.com>
To:     heiko@sntech.de, lee@kernel.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Milo Spadacini <milo.spadacini@gmail.com>
Subject: [PATCH] driver: mfd: admit rk805 driver registration without interrupt support
Date:   Thu, 25 May 2023 09:00:11 +0200
Message-Id: <20230525070011.23761-1-milo.spadacini@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rk805 use interrupt only for "rk808-rtc" and "rk805-pwrkey" drivers.
On custom board these drivers could be not used and the irq gpio
could be not connected.
Force the usage of a not used gpio, that could be floating, could cause
spurious interrupt.

Signed-off-by: Milo Spadacini <milo.spadacini@gmail.com>
---
 drivers/mfd/rk808.c | 39 +++++++++++++++++++++++++++------------
 1 file changed, 27 insertions(+), 12 deletions(-)

diff --git a/drivers/mfd/rk808.c b/drivers/mfd/rk808.c
index e00da7c7e3b1..ae33be90b312 100644
--- a/drivers/mfd/rk808.c
+++ b/drivers/mfd/rk808.c
@@ -643,6 +643,7 @@ MODULE_DEVICE_TABLE(of, rk808_of_match);
 static int rk808_probe(struct i2c_client *client,
 		       const struct i2c_device_id *id)
 {
+	struct irq_domain * rk808_irq_domain = NULL;
 	struct device_node *np = client->dev.of_node;
 	struct rk808 *rk808;
 	const struct rk808_reg_data *pre_init_reg;
@@ -692,7 +693,11 @@ static int rk808_probe(struct i2c_client *client,
 		pre_init_reg = rk805_pre_init_reg;
 		nr_pre_init_regs = ARRAY_SIZE(rk805_pre_init_reg);
 		cells = rk805s;
-		nr_cells = ARRAY_SIZE(rk805s);
+		if (client->irq)
+			nr_cells = ARRAY_SIZE(rk805s);
+		else
+			nr_cells = ARRAY_SIZE(rk805s) - 2;
+
 		break;
 	case RK808_ID:
 		rk808->regmap_cfg = &rk808_regmap_config;
@@ -734,19 +739,28 @@ static int rk808_probe(struct i2c_client *client,
 		return PTR_ERR(rk808->regmap);
 	}
 
-	if (!client->irq) {
+	if (client->irq) {
+
+		ret = regmap_add_irq_chip(rk808->regmap, client->irq,
+					  IRQF_ONESHOT, -1,
+					  rk808->regmap_irq_chip, &rk808->irq_data);
+		if (ret) {
+			dev_err(&client->dev, "Failed to add irq_chip %d\n", ret);
+			return ret;
+		}
+
+		rk808_irq_domain = regmap_irq_get_domain(rk808->irq_data);
+	}
+	else if (rk808->variant == RK805_ID)
+	{
+		dev_warn(&client->dev, "Skip interrupt support, no core IRQ\n");
+	}
+	else
+	{
 		dev_err(&client->dev, "No interrupt support, no core IRQ\n");
 		return -EINVAL;
 	}
 
-	ret = regmap_add_irq_chip(rk808->regmap, client->irq,
-				  IRQF_ONESHOT, -1,
-				  rk808->regmap_irq_chip, &rk808->irq_data);
-	if (ret) {
-		dev_err(&client->dev, "Failed to add irq_chip %d\n", ret);
-		return ret;
-	}
-
 	for (i = 0; i < nr_pre_init_regs; i++) {
 		ret = regmap_update_bits(rk808->regmap,
 					pre_init_reg[i].addr,
@@ -762,7 +776,7 @@ static int rk808_probe(struct i2c_client *client,
 
 	ret = devm_mfd_add_devices(&client->dev, PLATFORM_DEVID_NONE,
 			      cells, nr_cells, NULL, 0,
-			      regmap_irq_get_domain(rk808->irq_data));
+			      rk808_irq_domain);
 	if (ret) {
 		dev_err(&client->dev, "failed to add MFD devices %d\n", ret);
 		goto err_irq;
@@ -796,7 +810,8 @@ static void rk808_remove(struct i2c_client *client)
 {
 	struct rk808 *rk808 = i2c_get_clientdata(client);
 
-	regmap_del_irq_chip(client->irq, rk808->irq_data);
+	if (client->irq)
+		regmap_del_irq_chip(client->irq, rk808->irq_data);
 
 	/**
 	 * pm_power_off may points to a function from another module.
-- 
2.34.1

