Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55DF36E5EEB
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 12:35:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231270AbjDRKfH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 06:35:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231187AbjDRKet (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 06:34:49 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C24126A5
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 03:34:44 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id xi5so71870677ejb.13
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 03:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1681814082; x=1684406082;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ml1nedlrXgWfNGvpKNjoDJf5JKupI4N1yItZ011XKWE=;
        b=BON11A64Y1B8bvrfHmnxxqy2xkhp2EHBMOU1eOLDje3/DfAairJHN4KeyE/lqCshf5
         Lm5TxwIaa5TGjpOTm+cWWJAihOI64Fxmgd1xM+GdUbMMU7FiOApVe8Ec++warn3IBr4z
         PE+oU0kQYwgWCgLddUjuVIPKdMP4mC1cTvrjMY0xl/r+eLlBbSYg6hCEXOhW39boQIhU
         19DYMTCe6VtkSGE2jjtOAeFrrLHIrqaBN5mrKyJhRY0KyJVd0QTTxdVxuBBuHzZM5Urr
         Kw6SHZeEgFFjfOoVISZcpyXAy5snPr68fnhxNFbWs2Wy4xZCPBuZzCGve6PJbODCh21Z
         qwtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681814082; x=1684406082;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ml1nedlrXgWfNGvpKNjoDJf5JKupI4N1yItZ011XKWE=;
        b=d7ficGiu3rhZ+tX1K+pXgsd9hdhpFrMSXbOexJsfHM53q51vXP56hjeJ9XqiLrgQtQ
         pvYYFL26YxGhSceGcRAmIoj/lo9HkAn2j6YMIeKPuRbA6Yd28WQgfkcLU7zDVfs2y08+
         XuRTSdYmOZvuREWpqy2IEFU3XMC96D3gsWCL4tFRZPAc8zpKNyk57r6XY0nCsnJutICJ
         r+Ifedw37bkqEWoAs0NJ491/RSP2dNKTnc/o8U1plKpB+hG1bC8dnUzarMZbAutAXsAU
         XeF+hw1dmW6+IQiarMTXLQdeZIG9gqQni9RxGKvT9dPY2qkN79TXVqLEuI75QlFFLhT0
         DRkA==
X-Gm-Message-State: AAQBX9eD9lSSy7MSaDdZphzgM1/LtrJd9DFeP3u+BqmvXkkxutZyl6Ed
        LMPbtUdQxgA92H5kZasmUGen4XDGdRXCZWnSXHw=
X-Google-Smtp-Source: AKy350bPKU4OdS+klRmOWNR8bkLPj+3uDBrJAHLQi3R7lTVgk8ARhBx107G8MSkeiS6LlAbKBIjdoA==
X-Received: by 2002:a17:906:4e0b:b0:8f5:8da0:a482 with SMTP id z11-20020a1709064e0b00b008f58da0a482mr10678683eju.25.1681814082708;
        Tue, 18 Apr 2023 03:34:42 -0700 (PDT)
Received: from fedora.sec.9e.network (ip-095-222-150-251.um34.pools.vodafone-ip.de. [95.222.150.251])
        by smtp.gmail.com with ESMTPSA id a12-20020a170906368c00b0094e8de89111sm7787126ejc.201.2023.04.18.03.34.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 03:34:42 -0700 (PDT)
From:   Patrick Rudolph <patrick.rudolph@9elements.com>
To:     Peter Rosin <peda@axentia.se>
Cc:     Patrick Rudolph <patrick.rudolph@9elements.com>,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v13 4/4] i2c: muxes: pca954x: Add regulator support
Date:   Tue, 18 Apr 2023 12:34:29 +0200
Message-Id: <20230418103430.966278-5-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230418103430.966278-1-patrick.rudolph@9elements.com>
References: <20230418103430.966278-1-patrick.rudolph@9elements.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a vdd regulator and enable it for boards that have the
mux powered off by default.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
---
 drivers/i2c/muxes/i2c-mux-pca954x.c | 28 +++++++++++++++++++++++-----
 1 file changed, 23 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/muxes/i2c-mux-pca954x.c b/drivers/i2c/muxes/i2c-mux-pca954x.c
index a9195d1547f1..ae98e76e0733 100644
--- a/drivers/i2c/muxes/i2c-mux-pca954x.c
+++ b/drivers/i2c/muxes/i2c-mux-pca954x.c
@@ -49,6 +49,7 @@
 #include <linux/module.h>
 #include <linux/pm.h>
 #include <linux/property.h>
+#include <linux/regulator/consumer.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <dt-bindings/mux/mux.h>
@@ -101,6 +102,7 @@ struct pca954x {
 	struct irq_domain *irq;
 	unsigned int irq_mask;
 	raw_spinlock_t lock;
+	struct regulator *supply;
 };
 
 /* Provide specs for the MAX735x, PCA954x and PCA984x types we know about */
@@ -440,6 +442,8 @@ static void pca954x_cleanup(struct i2c_mux_core *muxc)
 	struct pca954x *data = i2c_mux_priv(muxc);
 	int c, irq;
 
+	regulator_disable(data->supply);
+
 	if (data->irq) {
 		for (c = 0; c < data->chip->nchans; c++) {
 			irq = irq_find_mapping(data->irq, c);
@@ -492,10 +496,22 @@ static int pca954x_probe(struct i2c_client *client)
 	i2c_set_clientdata(client, muxc);
 	data->client = client;
 
+	data->supply = devm_regulator_get(dev, "vdd");
+	if (IS_ERR(data->supply))
+		return dev_err_probe(dev, PTR_ERR(data->supply),
+				"Failed to request regulator\n");
+
+	ret = regulator_enable(data->supply);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Failed to enable vdd supply\n");
+
 	/* Reset the mux if a reset GPIO is specified. */
 	gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
-	if (IS_ERR(gpio))
-		return PTR_ERR(gpio);
+	if (IS_ERR(gpio)) {
+		ret = PTR_ERR(gpio);
+		goto fail_cleanup;
+	}
 	if (gpio) {
 		udelay(1);
 		gpiod_set_value_cansleep(gpio, 0);
@@ -512,7 +528,7 @@ static int pca954x_probe(struct i2c_client *client)
 
 		ret = i2c_get_device_id(client, &id);
 		if (ret && ret != -EOPNOTSUPP)
-			return ret;
+			goto fail_cleanup;
 
 		if (!ret &&
 		    (id.manufacturer_id != data->chip->id.manufacturer_id ||
@@ -520,7 +536,8 @@ static int pca954x_probe(struct i2c_client *client)
 			dev_warn(dev, "unexpected device id %03x-%03x-%x\n",
 				 id.manufacturer_id, id.part_id,
 				 id.die_revision);
-			return -ENODEV;
+			ret = -ENODEV;
+			goto fail_cleanup;
 		}
 	}
 
@@ -539,7 +556,8 @@ static int pca954x_probe(struct i2c_client *client)
 	ret = pca954x_init(client, data);
 	if (ret < 0) {
 		dev_warn(dev, "probe failed\n");
-		return -ENODEV;
+		ret = -ENODEV;
+		goto fail_cleanup;
 	}
 
 	ret = pca954x_irq_setup(muxc);
-- 
2.39.2

