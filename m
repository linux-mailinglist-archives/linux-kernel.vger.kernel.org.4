Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 219656C2431
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 23:04:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbjCTWEK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 18:04:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbjCTWEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 18:04:05 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 316A25276;
        Mon, 20 Mar 2023 15:04:03 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id az3-20020a05600c600300b003ed2920d585so10043370wmb.2;
        Mon, 20 Mar 2023 15:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679349841;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pf7IiAq5B93+IZXJrCRi5ZHOvjRYrvKXAvC8Q2l3O+Q=;
        b=eZOR8PEkOxbdISlN58EMj53p+mkHBxV1yDfN5Bs67CR8S7vqUsc3GDm05qDYYyToi5
         8F2q4owvBmLnOXF0fovCiMoo9oVxQJJEVNDsLEWhaIdV3SZp0AX9hXJLDbE6MAaNfdRY
         W7rjqOEN8afZhrUB67RJt+RwXJHbj7TIC6uhElhhzW9VXb+uC8QWm+dcuA9/bnaSIyyI
         adQMRk/ckNExM9IqnemlHywxx/7JEygT+KqLIwAj+OWWmVTAqbc7stSRbIJKJEl7UxCm
         eGsQACH+5X2T3QaG/HdjoI0xnEGLj5RXcboPa2DlGvzzyo5DI4YFYwU6fA+kAPTqwbVV
         dHuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679349841;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pf7IiAq5B93+IZXJrCRi5ZHOvjRYrvKXAvC8Q2l3O+Q=;
        b=kSVDwpGv5bHFd3hmPsUSM39p6xzpvxcvWBUmCNgMVGPR5RSpSH7sARsuI/lmYVgldi
         ZVXQPegLt/YKoM0C+38A/w52mihvjDPllvqemhvEgvvoDQyQbN6l/p8nYzagOJul6+/I
         yMFpmp3B1zaJW89GmCS30TepXxsWam+3pWrIT9vPS7I4+0cSl3B254CB10Uqcf4EHEBa
         O8Sc89nZL23xz85v/qk0VIO5o7ZT0DlSSSjgkX6JOzznB5/fzvkWqfiC5JNvSBKpmKx9
         O8/T5xEoKCRbzhxsX++SB15uZf/Wmvc0G/0X8hxtR/XCRtlXCYRYhG6aFLjQ99j/dl93
         yNvg==
X-Gm-Message-State: AO0yUKU+x47emm4hc3qiW374ltUVVHv77OhvnHA7nvjbI6iJHw95FdH3
        rcDrKyKLItqDyHvKg2pmFEU=
X-Google-Smtp-Source: AK7set9J2XchxKyRyonScEppnAa5Yu5CsMcqT90vvVAKDz7nGJ75n7/PsO38ChV1dtcxK7k73SmFBw==
X-Received: by 2002:a1c:f714:0:b0:3e5:4fb9:ea60 with SMTP id v20-20020a1cf714000000b003e54fb9ea60mr826934wmh.9.1679349841684;
        Mon, 20 Mar 2023 15:04:01 -0700 (PDT)
Received: from PCBABN.skidata.net ([91.230.2.244])
        by smtp.gmail.com with ESMTPSA id bg5-20020a05600c3c8500b003e7f1086660sm17868386wmb.15.2023.03.20.15.04.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 15:04:01 -0700 (PDT)
From:   Benjamin Bara <bbara93@gmail.com>
To:     lee@kernel.org
Cc:     dmitry.osipenko@collabora.com, jonathanh@nvidia.com,
        treding@nvidia.com, richard.leitner@linux.dev,
        benjamin.bara@skidata.com, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] mfd: tps6586x: use devm-based power off handler
Date:   Mon, 20 Mar 2023 23:03:44 +0100
Message-Id: <20230320220345.1463687-2-bbara93@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230320220345.1463687-1-bbara93@gmail.com>
References: <20230320220345.1463687-1-bbara93@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Benjamin Bara <benjamin.bara@skidata.com>

Convert the power off handler to a devm-based power off handler.

Signed-off-by: Benjamin Bara <benjamin.bara@skidata.com>
---
 drivers/mfd/tps6586x.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/mfd/tps6586x.c b/drivers/mfd/tps6586x.c
index 2d947f3f606a..4869155437cb 100644
--- a/drivers/mfd/tps6586x.c
+++ b/drivers/mfd/tps6586x.c
@@ -22,6 +22,7 @@
 #include <linux/err.h>
 #include <linux/i2c.h>
 #include <linux/platform_device.h>
+#include <linux/reboot.h>
 #include <linux/regmap.h>
 #include <linux/of.h>
 
@@ -457,13 +458,16 @@ static const struct regmap_config tps6586x_regmap_config = {
 	.cache_type = REGCACHE_RBTREE,
 };
 
-static struct device *tps6586x_dev;
-static void tps6586x_power_off(void)
+static int tps6586x_power_off_handler(struct sys_off_data *data)
 {
-	if (tps6586x_clr_bits(tps6586x_dev, TPS6586X_SUPPLYENE, EXITSLREQ_BIT))
-		return;
+	int ret;
+	struct device *tps6586x_dev = (struct device *)data->cb_data;
+
+	ret = tps6586x_clr_bits(tps6586x_dev, TPS6586X_SUPPLYENE, EXITSLREQ_BIT);
+	if (ret)
+		return ret;
 
-	tps6586x_set_bits(tps6586x_dev, TPS6586X_SUPPLYENE, SLEEP_MODE_BIT);
+	return tps6586x_set_bits(tps6586x_dev, TPS6586X_SUPPLYENE, SLEEP_MODE_BIT);
 }
 
 static void tps6586x_print_version(struct i2c_client *client, int version)
@@ -559,9 +563,13 @@ static int tps6586x_i2c_probe(struct i2c_client *client)
 		goto err_add_devs;
 	}
 
-	if (pdata->pm_off && !pm_power_off) {
-		tps6586x_dev = &client->dev;
-		pm_power_off = tps6586x_power_off;
+	if (pdata->pm_off) {
+		ret = devm_register_power_off_handler(&client->dev, &tps6586x_power_off_handler,
+						      &client->dev);
+		if (ret) {
+			dev_err(&client->dev, "register power off handler failed: %d\n", ret);
+			goto err_add_devs;
+		}
 	}
 
 	return 0;
-- 
2.34.1

