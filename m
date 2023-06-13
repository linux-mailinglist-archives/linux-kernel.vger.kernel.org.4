Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D411172DF52
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 12:24:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242023AbjFMKXy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 06:23:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241422AbjFMKXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 06:23:06 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 804AF173E;
        Tue, 13 Jun 2023 03:23:04 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-5187aa14e3bso205240a12.3;
        Tue, 13 Jun 2023 03:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686651783; x=1689243783;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dQ2ryCXqr7uPo1ZCZAFxYzmrawKO4U75wlR0TUXTjbE=;
        b=QJYDWIQdS25P7MIbgpsu+uhtKApKjnUGWqGM5KFmdW2GbMKrZa4yVDOfkX9b0YleT2
         CrFdxwq4oYCBsiynQckKX9imxyKtp72RjWVrEAcrVk1CmsF/yzUZuN3hZU50uLqxfmUn
         hUybiOGE6zuyI6ilWj38iES72y4eOwolvgGiWONseyBDTuB+nIy6hgXmNtPu8fwBgbvF
         SHrP810tZmKhrp91tDQEEAhgOds+POnkI86uyd6ZTJWopMX6Qwmc1RuejQ3JyjcWJrn8
         LGXIwuAVqJiMo/o66YYZV8O0rRwtdw+rKj2z7BtwkSndlDbbsbH6364CBkQ9u/P9O1H0
         Z7gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686651783; x=1689243783;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dQ2ryCXqr7uPo1ZCZAFxYzmrawKO4U75wlR0TUXTjbE=;
        b=llFWT3rLIvZDmNUMGwo4goeR6567MfuQHoSvu29WCpZZLLa0YH/YfaFFeQfnCwHtYj
         /7CU9QiSg3Qfg+qYdsZd5KvpXe/LVEOdM9y546ljwoJYrpZrIRyabwD167l4pEppZPWP
         OsCdaP4/j9RxHkM3oEj5ZVkAw8EA3BZn2PDXsEjIRkX/5cBSIMzGVqqzjexuksGAHmbc
         HWe48g/EzHEH/UsLR7C1gtEf5VUxhi6SqVr4/SpAKPRE6oIvAroBhrMc9B66h7hbjeW+
         dbXk3A9OrSIoYpy8E1k3HQ8q8aGfyVucm4FEv9iXOoI7aUiUrkBzBvZGItuD5vACNos6
         U/6Q==
X-Gm-Message-State: AC+VfDzVkOxgkxOz7cvx6C9b7MMMWy8YU6p8+u/1rwLj48LHkjqCXCTg
        U3R+sCPSvcMncm6l+GOhSo0=
X-Google-Smtp-Source: ACHHUZ43D6uMBgf4syyQLG4qXCvftyYITDcqjZ8a7VENhK6Cmu8bC4yqak0cLpD7gqBkxLzTNVhXpw==
X-Received: by 2002:a17:906:9749:b0:977:c406:f8cf with SMTP id o9-20020a170906974900b00977c406f8cfmr13116876ejy.73.1686651782945;
        Tue, 13 Jun 2023 03:23:02 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8109:aa3f:ead8::298a])
        by smtp.gmail.com with ESMTPSA id b7-20020a170906038700b009787b18c253sm6492493eja.181.2023.06.13.03.23.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 03:23:02 -0700 (PDT)
From:   Mehdi Djait <mehdi.djait.k@gmail.com>
To:     jic23@kernel.org, mazziesaccount@gmail.com
Cc:     krzysztof.kozlowski+dt@linaro.org,
        andriy.shevchenko@linux.intel.com, robh+dt@kernel.org,
        lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Mehdi Djait <mehdi.djait.k@gmail.com>
Subject: [PATCH v6 6/7] iio: accel: kionix-kx022a: Add a function to retrieve number of bytes in buffer
Date:   Tue, 13 Jun 2023 12:22:39 +0200
Message-Id: <cce7586c9994688bbb93c4a960b3f825f0116086.1686651032.git.mehdi.djait.k@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1686651032.git.mehdi.djait.k@gmail.com>
References: <cover.1686651032.git.mehdi.djait.k@gmail.com>
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

Since Kionix accelerometers use various numbers of bits to report data, a
device-specific function is required.
Implement the function as a callback in the device-specific chip_info structure

Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>
Signed-off-by: Mehdi Djait <mehdi.djait.k@gmail.com>
---
v6:
- directly return KX022A_FIFO_MAX_BYTES as suggested by Andy

v5:
- no changes

v4:
- removed the comment about "bogus value from i2c"
- removed regmap_get_device(data->regmap); dev is present in the
  driver's private data

v3:
- no changes

v2:
- separated this change from the chip_info introduction and made it a patch in v2 
- changed the function from generic implementation for to device-specific one
- removed blank lines pointed out by checkpatch
- changed the allocation of the "buffer" array in __kx022a_fifo_flush

 drivers/iio/accel/kionix-kx022a.c | 28 ++++++++++++++++++----------
 drivers/iio/accel/kionix-kx022a.h |  4 ++++
 2 files changed, 22 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/accel/kionix-kx022a.c b/drivers/iio/accel/kionix-kx022a.c
index 0bab3f109e4e..0b0f14dca17f 100644
--- a/drivers/iio/accel/kionix-kx022a.c
+++ b/drivers/iio/accel/kionix-kx022a.c
@@ -596,26 +596,33 @@ static int kx022a_drop_fifo_contents(struct kx022a_data *data)
 	return regmap_write(data->regmap, data->chip_info->buf_clear, 0x0);
 }
 
+static int kx022a_get_fifo_bytes(struct kx022a_data *data)
+{
+	int ret, fifo_bytes;
+
+	ret = regmap_read(data->regmap, KX022A_REG_BUF_STATUS_1, &fifo_bytes);
+	if (ret) {
+		dev_err(data->dev, "Error reading buffer status\n");
+		return ret;
+	}
+
+	if (fifo_bytes == KX022A_FIFO_FULL_VALUE)
+		return KX022A_FIFO_MAX_BYTES;
+
+	return fifo_bytes;
+}
+
 static int __kx022a_fifo_flush(struct iio_dev *idev, unsigned int samples,
 			       bool irq)
 {
 	struct kx022a_data *data = iio_priv(idev);
-	struct device *dev = regmap_get_device(data->regmap);
 	uint64_t sample_period;
 	int count, fifo_bytes;
 	bool renable = false;
 	int64_t tstamp;
 	int ret, i;
 
-	ret = regmap_read(data->regmap, KX022A_REG_BUF_STATUS_1, &fifo_bytes);
-	if (ret) {
-		dev_err(dev, "Error reading buffer status\n");
-		return ret;
-	}
-
-	/* Let's not overflow if we for some reason get bogus value from i2c */
-	if (fifo_bytes == KX022A_FIFO_FULL_VALUE)
-		fifo_bytes = KX022A_FIFO_MAX_BYTES;
+	fifo_bytes = data->chip_info->get_fifo_bytes(data);
 
 	if (fifo_bytes % KX022A_FIFO_SAMPLES_SIZE_BYTES)
 		dev_warn(data->dev, "Bad FIFO alignment. Data may be corrupt\n");
@@ -1023,6 +1030,7 @@ const struct kx022a_chip_info kx022a_chip_info = {
 	.inc5		  = KX022A_REG_INC5,
 	.inc6		  = KX022A_REG_INC6,
 	.xout_l		  = KX022A_REG_XOUT_L,
+	.get_fifo_bytes	  = kx022a_get_fifo_bytes,
 };
 EXPORT_SYMBOL_NS_GPL(kx022a_chip_info, IIO_KX022A);
 
diff --git a/drivers/iio/accel/kionix-kx022a.h b/drivers/iio/accel/kionix-kx022a.h
index 0e5026019213..c9f9aee7e597 100644
--- a/drivers/iio/accel/kionix-kx022a.h
+++ b/drivers/iio/accel/kionix-kx022a.h
@@ -76,6 +76,8 @@
 
 struct device;
 
+struct kx022a_data;
+
 /**
  * struct kx022a_chip_info - Kionix accelerometer chip specific information
  *
@@ -99,6 +101,7 @@ struct device;
  * @inc5:		interrupt control register 5
  * @inc6:		interrupt control register 6
  * @xout_l:		x-axis output least significant byte
+ * @get_fifo_bytes:	function pointer to get number of bytes in the FIFO buffer
  */
 struct kx022a_chip_info {
 	const char *name;
@@ -121,6 +124,7 @@ struct kx022a_chip_info {
 	u8 inc5;
 	u8 inc6;
 	u8 xout_l;
+	int (*get_fifo_bytes)(struct kx022a_data *);
 };
 
 int kx022a_probe_internal(struct device *dev, const struct kx022a_chip_info *chip_info);
-- 
2.30.2

