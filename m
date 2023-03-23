Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4F016C6109
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 08:45:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231161AbjCWHpN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 03:45:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230525AbjCWHpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 03:45:01 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACEE51B2C3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 00:44:59 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id x3so82674962edb.10
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 00:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1679557498;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xwXKfhhEqm0u3hOwcWnbc9eMv2uIS61iRmPoBGhEqx8=;
        b=anSz9RHrI2tqTMIGf27gXTNUzoK+4jSQhNQel8DSLnabwyoNefZgfGB1HedSIyMvYv
         rdHEH+aUZVjqmZbCehZ0AAnLycFv4+QbDeMhN9ks9CPd+ZLjYCYNFD9sExvisnDWGhD4
         UzU7PFlsotfjVgIw8LRl0BvqzbC+FWN3aw08Wsa8DfhLcQ9aUnGc91LFf3V3V5WG+66w
         CzgvCdlEygLaLWYoh6eL3x5wUTb2yz6GupS+CORumlmrkY1q9BTpRJwtSTOdgV3AQqoa
         y1Yo3fgZaPB3RREJFh974ZNexpWOCxWcaLKcrW5v4xeTLQSWW3X3t9xGhoVBOKAH6FBs
         GHUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679557498;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xwXKfhhEqm0u3hOwcWnbc9eMv2uIS61iRmPoBGhEqx8=;
        b=vWX07UCcoKY6bylyMqqioMQ/SNuHxZeqFdWCsR2/01j7F/uovRhlS0pUd9SpNoiGqL
         XqDtP4uuJI/kMcOQRbDsCyWV3WS9OCSOKO1fbePTIBcviJHWzGO6r4PKNIQMzKd4MA0H
         Y4y1xVr47JBgVqyZ2/Ga4JNf97kWQUXXc9J9GBHVLLNSHtNVdcfOfY246vyAZ+nZ2VO8
         /JUdIwsF8rDUjkPIMFTMCsFlQtYJQC0wAGNmX4d5Psu4A/PzFvEeR0mb2JTzQ8WAoqVi
         yaEAvftL552itfmGsyBPHuUmZZmweGzpRFp+reIM8vCpb6UqhezVJ+NW9sncGJKXhWDe
         SDxw==
X-Gm-Message-State: AO0yUKVUf6kvc8rMnKicLkvGRPOaMkodB73lJi+1EYfNwW2mgkuAaltz
        M8XMMQHZCcWXXtobQjoMxvov+A==
X-Google-Smtp-Source: AK7set+sMmm5cKa9NtTk7jmCHEXW/jrkiKduVUFeB31k36As8w1fcZDuG+nZ1YoHvZMOUsswSBbZ6w==
X-Received: by 2002:a17:907:7ea5:b0:93c:8403:3516 with SMTP id qb37-20020a1709077ea500b0093c84033516mr2248118ejc.0.1679557498224;
        Thu, 23 Mar 2023 00:44:58 -0700 (PDT)
Received: from fedora.. (ip-095-222-150-251.um34.pools.vodafone-ip.de. [95.222.150.251])
        by smtp.gmail.com with ESMTPSA id g1-20020a1709061c8100b0092669fb4ba1sm8255405ejh.130.2023.03.23.00.44.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 00:44:57 -0700 (PDT)
From:   Patrick Rudolph <patrick.rudolph@9elements.com>
To:     Peter Rosin <peda@axentia.se>, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Patrick Rudolph <patrick.rudolph@9elements.com>,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v10 3/4] i2c: muxes: pca954x: Add regulator support
Date:   Thu, 23 Mar 2023 08:44:18 +0100
Message-Id: <20230323074419.2494609-4-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230323074419.2494609-1-patrick.rudolph@9elements.com>
References: <20230323074419.2494609-1-patrick.rudolph@9elements.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
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
 drivers/i2c/muxes/i2c-mux-pca954x.c | 35 ++++++++++++++++++++++++-----
 1 file changed, 30 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/muxes/i2c-mux-pca954x.c b/drivers/i2c/muxes/i2c-mux-pca954x.c
index 39f313658b18..0d966a55b727 100644
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
@@ -440,6 +442,9 @@ static void pca954x_cleanup(struct i2c_mux_core *muxc)
 	struct pca954x *data = i2c_mux_priv(muxc);
 	int c, irq;
 
+	if (data->supply)
+		regulator_disable(data->supply);
+
 	if (data->irq) {
 		for (c = 0; c < data->chip->nchans; c++) {
 			irq = irq_find_mapping(data->irq, c);
@@ -492,10 +497,28 @@ static int pca954x_probe(struct i2c_client *client)
 	i2c_set_clientdata(client, muxc);
 	data->client = client;
 
+	data->supply = devm_regulator_get_optional(dev, "vdd");
+	if (IS_ERR(data->supply)) {
+		ret = PTR_ERR(data->supply);
+		if (ret != -ENODEV)
+			return dev_err_probe(dev, ret,
+				"Failed to request regulator\n");
+		else
+			data->supply = NULL;
+	} else {
+		ret = regulator_enable(data->supply);
+		if (ret) {
+			dev_err(dev, "Failed to enable regulator: %d\n", ret);
+			return ret;
+		}
+	}
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
@@ -512,7 +535,7 @@ static int pca954x_probe(struct i2c_client *client)
 
 		ret = i2c_get_device_id(client, &id);
 		if (ret && ret != -EOPNOTSUPP)
-			return ret;
+			goto fail_cleanup;
 
 		if (!ret &&
 		    (id.manufacturer_id != data->chip->id.manufacturer_id ||
@@ -520,7 +543,8 @@ static int pca954x_probe(struct i2c_client *client)
 			dev_warn(dev, "unexpected device id %03x-%03x-%x\n",
 				 id.manufacturer_id, id.part_id,
 				 id.die_revision);
-			return -ENODEV;
+			ret = -ENODEV;
+			goto fail_cleanup;
 		}
 	}
 
@@ -539,7 +563,8 @@ static int pca954x_probe(struct i2c_client *client)
 	ret = pca954x_init(client, data);
 	if (ret < 0) {
 		dev_warn(dev, "probe failed\n");
-		return -ENODEV;
+		ret = -ENODEV;
+		goto fail_cleanup;
 	}
 
 	ret = pca954x_irq_setup(muxc);
-- 
2.39.1

