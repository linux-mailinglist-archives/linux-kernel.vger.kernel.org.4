Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F9855B8A20
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 16:15:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbiINOPH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 10:15:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbiINOOq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 10:14:46 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89389C34;
        Wed, 14 Sep 2022 07:14:44 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id j6-20020a17090a694600b00200bba67dadso14570719pjm.5;
        Wed, 14 Sep 2022 07:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=S8jwxWuuGRLyh4Xd6g3SHgR8UXQy3eOYQg/H6/mPhRE=;
        b=nqAeTyoHkatCAh52mME+F88ZxWZhlnQTQ2b1LoHsJHKwa6MmlnUFNHqb9SRbQMInqK
         Hc+FECWSrzHTHQMgjW/nyllwuY/3gaA16HLS1UuWJPWymKo3ibDBLQWaXll0Lj3QaZ2D
         EcBLQNESwjYUH2rOIZ8a2ImimodgoB2I8nR1KfBxXdjOQNamZlz946ijRY16LSYI9qIa
         54x8h6SIDK3BFEUoQJOQH8MxTMsphW0kaeFgyQBrvZqIon2tT0r9ijoSjGe8w/pMxQUr
         Fqv/5Y3lrXlliTwML0oF/FK2JQH7rjhl//FgkOwZUTI93YBlWNJZdkgVhoF/Sg7CKRvH
         2lMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=S8jwxWuuGRLyh4Xd6g3SHgR8UXQy3eOYQg/H6/mPhRE=;
        b=WPTNKdXM8p+bDRiOBBizmlQMkho34qk42yyOCy0HRW1800bEYr4seqDPGkY+djOHR9
         IVPYY1cy+vTgofbeutLM3XDijPQvgpKbeJjt4hKMwdjaXaJ4ac+NeqVxNlxmDKc4dtqp
         R7eq0TmgfqAcQR9+ylvgBBLvGQptBXx26f7RJxbCOLbsBYVqGW+fMkhgOxHG2sNDv+kt
         UHntMyuXFm4qAhBEZ3vR3hGzhBquw3cRiUE8SlG9ZTHeXJ+qhIdJ5SRyCjf/NTZlTQE+
         E6l97HFhyjqZAmeIlCikaXcu+XUsE0pEs+BiA9YNIKX3WUInJT8D/62d1woLEuwQgjiz
         SG4w==
X-Gm-Message-State: ACrzQf3Km6byrVjI4xv561o0sybqXJ6Mk8dO8qTanVmKLESrFzMr/7+8
        +mKpB8GuaCC+01YAM7EEW/k=
X-Google-Smtp-Source: AMsMyM7pS3lqZiSHxY6xz40YjtwbjlokxIseywnf47GpcyjD1h/90m7Qo5gegVn0ObJVSNYks58d8w==
X-Received: by 2002:a17:90a:6a83:b0:200:9da5:d0e7 with SMTP id u3-20020a17090a6a8300b002009da5d0e7mr4988866pjj.187.1663164877051;
        Wed, 14 Sep 2022 07:14:37 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:202:201:2f68:fe7:a2e6:7595])
        by smtp.gmail.com with ESMTPSA id a9-20020a170902ecc900b0017839e5abfasm6480624plh.263.2022.09.14.07.14.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 07:14:36 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] Input: auo-pixcir-ts - switch to using generic device properties
Date:   Wed, 14 Sep 2022 07:14:27 -0700
Message-Id: <20220914141428.2201784-4-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
In-Reply-To: <20220914141428.2201784-1-dmitry.torokhov@gmail.com>
References: <20220914141428.2201784-1-dmitry.torokhov@gmail.com>
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

Let's use generic device properties API instead of OF-specific one.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/touchscreen/auo-pixcir-ts.c | 40 ++++++-----------------
 1 file changed, 10 insertions(+), 30 deletions(-)

diff --git a/drivers/input/touchscreen/auo-pixcir-ts.c b/drivers/input/touchscreen/auo-pixcir-ts.c
index 4960a50f59ea..2deae5a6823a 100644
--- a/drivers/input/touchscreen/auo-pixcir-ts.c
+++ b/drivers/input/touchscreen/auo-pixcir-ts.c
@@ -22,6 +22,7 @@
 #include <linux/delay.h>
 #include <linux/gpio/consumer.h>
 #include <linux/of.h>
+#include <linux/property.h>
 
 /*
  * Coordinate calculation:
@@ -474,33 +475,6 @@ static int __maybe_unused auo_pixcir_resume(struct device *dev)
 static SIMPLE_DEV_PM_OPS(auo_pixcir_pm_ops,
 			 auo_pixcir_suspend, auo_pixcir_resume);
 
-#ifdef CONFIG_OF
-static int auo_pixcir_parse_dt(struct device *dev, struct auo_pixcir_ts *ts)
-{
-	struct device_node *np = dev->of_node;
-
-	if (!np)
-		return -ENOENT;
-
-	if (of_property_read_u32(np, "x-size", &ts->x_max)) {
-		dev_err(dev, "failed to get x-size property\n");
-		return -EINVAL;
-	}
-
-	if (of_property_read_u32(np, "y-size", &ts->y_max)) {
-		dev_err(dev, "failed to get y-size property\n");
-		return -EINVAL;
-	}
-
-	return 0;
-}
-#else
-static int auo_pixcir_parse_dt(struct device *dev, struct auo_pixcir_ts *ts)
-{
-	return -EINVAL;
-}
-#endif
-
 static void auo_pixcir_reset(void *data)
 {
 	struct auo_pixcir_ts *ts = data;
@@ -535,9 +509,15 @@ static int auo_pixcir_probe(struct i2c_client *client,
 	snprintf(ts->phys, sizeof(ts->phys),
 		 "%s/input0", dev_name(&client->dev));
 
-	error = auo_pixcir_parse_dt(&client->dev, ts);
-	if (error)
-		return error;
+	if (device_property_read_u32(&client->dev, "x-size", &ts->x_max)) {
+		dev_err(&client->dev, "failed to get x-size property\n");
+		return -EINVAL;
+	}
+
+	if (device_property_read_u32(&client->dev, "y-size", &ts->y_max)) {
+		dev_err(&client->dev, "failed to get y-size property\n");
+		return -EINVAL;
+	}
 
 	input_dev->name = "AUO-Pixcir touchscreen";
 	input_dev->phys = ts->phys;
-- 
2.37.2.789.g6183377224-goog

