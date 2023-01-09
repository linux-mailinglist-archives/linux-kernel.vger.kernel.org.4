Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C005466356C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 00:36:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237883AbjAIXgJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 18:36:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237851AbjAIXgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 18:36:03 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C51F10A9
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 15:36:00 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id h26so9585159qtu.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 15:36:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=criticallink.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Omc6RJb75WehF9fTbabhEnE5DcQvC42CI90e1s9PLrk=;
        b=siN7GujK+FUeCr1O9CoGS68J8NCUuh891jd428rzwVirnNPB7oC2DlSjmTSm8qIabm
         4Kr2rS3D0QyFDcK+DybptVP8qF4AHpoXkE9+xX6TGlOz2M3kfVOJIYjkiWOycG1WhD7d
         3++yAlvgrHbibGcQWIOQex/6Avqplc+Gi3n9Z88jNWozj45nCH9Wk0hIxyknVDmJu8WW
         Qg1oCYk/7P/Z6uo5vbhiiZ0XV0L4pIguflN4qPbqMjo+/kmDFOemsJVQSbnlnXgyk/Rb
         eIY26LrBkunXiEPKVeky1t+vm87yTROF5QClgnYHZOtGnzXkgkxfXblMnAu/7KCEJQWO
         JNNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Omc6RJb75WehF9fTbabhEnE5DcQvC42CI90e1s9PLrk=;
        b=0FvGFJshcv/j0JN7HXCxDm5qLLt6+a0AT05l6OdgiD7S2r7I8S9zWbFItCITBrsbyT
         IU5uqoSf/FWGVCfzcjcoF2CK5GLBzie18LAQGbyNx8cLiObPw5oFgFbiQqWuM7krYouh
         gGBOVisG7pXl4AKqsqtLQGWqUFbe5HMR8uFNJckQiQGe0oK/K0DPiC4aiaLODWS2Uiul
         iXr9c4WbZSzzQQ1L8u4qYIEZljk83GznGRSqaeJVgWhJoKftjZBq+SqHkZ8RqGy1Y4Bm
         M6c92XzhuA59JLM30Z+AUbrTogXoChwW35g/oiz/Xi2Oj4PU76Av25ogCaK56QSwZ0Za
         JeYA==
X-Gm-Message-State: AFqh2kqaE+FMa/6Ki9RaBQ2lsZ7dxmhEjXCXIi0ZUNVlUD/8Gel6Zzii
        d11R7SJPKjo8QtErYQllro+EKQ==
X-Google-Smtp-Source: AMrXdXs7LyHcYWze0fIdxaO9udBB/U/ezdUsN+AtYBx515eKR7aZSpGNVVO2mex3UDJQ/WXNOeiouw==
X-Received: by 2002:ac8:7551:0:b0:3a7:f46b:7a82 with SMTP id b17-20020ac87551000000b003a7f46b7a82mr85112283qtr.21.1673307359514;
        Mon, 09 Jan 2023 15:35:59 -0800 (PST)
Received: from jcormier-MS-7A93.syr.criticallink.com (static-72-90-70-109.syrcny.fios.verizon.net. [72.90.70.109])
        by smtp.gmail.com with ESMTPSA id t5-20020a05620a450500b006fa8299b4d5sm6294846qkp.100.2023.01.09.15.35.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 15:35:59 -0800 (PST)
From:   Jonathan Cormier <jcormier@criticallink.com>
To:     linux-hwmon@vger.kernel.org
Cc:     Jonathan Cormier <jcormier@criticallink.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bob Duke <bduke@criticallink.com>,
        John Pruitt <jpruitt@criticallink.com>
Subject: [PATCH v3 3/5] hwmon: ltc2945: Handle error case in ltc2945_value_store
Date:   Mon,  9 Jan 2023 18:35:32 -0500
Message-Id: <20230109233534.1932370-4-jcormier@criticallink.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230109233534.1932370-1-jcormier@criticallink.com>
References: <20221214220727.1350784-3-jcormier@criticallink.com>
 <20230109233534.1932370-1-jcormier@criticallink.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ltc2945_val_to_reg errors were not being handled
which would have resulted in register being set to
0 (clamped) instead of being left alone.

Change reg_to_val and val_to_reg to return values
via parameters to make it more obvious when an
error case isn't handled. Also to allow
the regval type to be the correct sign in prep for
next commits.

Fixes: 6700ce035f83 ("hwmon: Driver for Linear Technologies LTC2945")

Signed-off-by: Jonathan Cormier <jcormier@criticallink.com>
---
 drivers/hwmon/ltc2945.c | 30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/drivers/hwmon/ltc2945.c b/drivers/hwmon/ltc2945.c
index 9af3e3821152..c66acf8d2124 100644
--- a/drivers/hwmon/ltc2945.c
+++ b/drivers/hwmon/ltc2945.c
@@ -70,12 +70,12 @@ static inline bool is_power_reg(u8 reg)
 }
 
 /* Return the value from the given register in uW, mV, or mA */
-static long long ltc2945_reg_to_val(struct device *dev, u8 reg)
+static int ltc2945_reg_to_val(struct device *dev, u8 reg, u64 *regval)
 {
 	struct regmap *regmap = dev_get_drvdata(dev);
 	unsigned int control;
 	u8 buf[3];
-	long long val;
+	u64 val;
 	int ret;
 
 	ret = regmap_bulk_read(regmap, reg, buf,
@@ -148,11 +148,12 @@ static long long ltc2945_reg_to_val(struct device *dev, u8 reg)
 	default:
 		return -EINVAL;
 	}
-	return val;
+	*regval = val;
+	return 0;
 }
 
 static int ltc2945_val_to_reg(struct device *dev, u8 reg,
-			      unsigned long val)
+			      unsigned long val, unsigned long *regval)
 {
 	struct regmap *regmap = dev_get_drvdata(dev);
 	unsigned int control;
@@ -220,19 +221,21 @@ static int ltc2945_val_to_reg(struct device *dev, u8 reg,
 	default:
 		return -EINVAL;
 	}
-	return val;
+	*regval = val;
+	return 0;
 }
 
 static ssize_t ltc2945_value_show(struct device *dev,
 				  struct device_attribute *da, char *buf)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
-	long long value;
+	int ret;
+	u64 value;
 
-	value = ltc2945_reg_to_val(dev, attr->index);
-	if (value < 0)
-		return value;
-	return sysfs_emit(buf, "%lld\n", value);
+	ret = ltc2945_reg_to_val(dev, attr->index, &value);
+	if (ret < 0)
+		return ret;
+	return sysfs_emit(buf, "%llu\n", value);
 }
 
 static ssize_t ltc2945_value_store(struct device *dev,
@@ -245,7 +248,7 @@ static ssize_t ltc2945_value_store(struct device *dev,
 	unsigned long val;
 	u8 regbuf[3];
 	int num_regs;
-	int regval;
+	unsigned long regval;
 	int ret;
 
 	ret = kstrtoul(buf, 10, &val);
@@ -253,7 +256,10 @@ static ssize_t ltc2945_value_store(struct device *dev,
 		return ret;
 
 	/* convert to register value, then clamp and write result */
-	regval = ltc2945_val_to_reg(dev, reg, val);
+	ret = ltc2945_val_to_reg(dev, reg, val, &regval);
+	if (ret < 0)
+		return ret;
+
 	if (is_power_reg(reg)) {
 		regval = clamp_val(regval, 0, 0xffffff);
 		regbuf[0] = regval >> 16;
-- 
2.25.1

