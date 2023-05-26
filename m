Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E269712848
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 16:31:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243895AbjEZObU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 10:31:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243878AbjEZObO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 10:31:14 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 742AF19A;
        Fri, 26 May 2023 07:31:11 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-514859f3ffbso59606a12.1;
        Fri, 26 May 2023 07:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685111470; x=1687703470;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QoqhjUFkGgsChUUR4qfnQGTApxV2QixLW8z4bQQp3E0=;
        b=ixPnPwkAxNpY8S5hjRG5ZShjKsvrFZ7mPVHL0NBAYCXpHRnctUNNpyeHwSEmJtHycN
         ZDuQ8c9bB5ytuNe191BaNF8XGag8gOv70M0PIwpqb/75P3of4TuXupbAHpFNOM+svIGQ
         njOwdT9dHjZdKr0gU1lRK+YXxaoBIoHbiFd8X7x5oRrki6UIibUf75UuO7MnYsEtFVlc
         wsSMOCZjqmG5NS7j7pwe474dePYn9Q59+Tx7BH05EcQ0Px/Sfh6x+kM4AFVUiC0r6208
         ckqWXv+d6h5kcwCoXsean7u+x8RmLWjwT772Wec8ok5kVY7on13YcILdg9khL7KC9dP0
         Lstw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685111470; x=1687703470;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QoqhjUFkGgsChUUR4qfnQGTApxV2QixLW8z4bQQp3E0=;
        b=lwixFvALVBIMxARAEAd7z9XoZ+Cvc8XnGdBLiKZzoSKrcVzf4MAF53H70uQ1nZB2Jc
         hapB/n7vMzRBvt6BnIgeNdLZiuzHRuleaaLux3r/mBURcxpAUTpWV7Dx7RwZDzNp9pNC
         v8KB0JZ++OwZHWsyFzMNYOfH/2iHKhsrT7524F4aQXGr9J4aW6QH4VCe3ovpf2BYdn5h
         eC5bYugs5I36VURTkzxxf1AkcoIdhckzcxl+tmF8mUc2ICellKFx4I6GJB6W6RcmtaZJ
         o3pCSBw2cssFH5hN/1fBQzHiTr52IhtHMoF9tvPv/OaEWAf2NFF5Ye/45amN2yPIQ4LB
         tojA==
X-Gm-Message-State: AC+VfDzJmPLZldNBf2Ay2IWqHLjxnVccdp3+rgDDseic+JKwtYm4jj/K
        5ccZkk0Zy3488kBzANInkAs=
X-Google-Smtp-Source: ACHHUZ5yD458x1BWqxS9YKct5dYsBGJIcLc5zzPl+jkekvvOknXHGfE51eMDXfxy50MUI5UZopwCyA==
X-Received: by 2002:a17:906:eec5:b0:958:4c75:705e with SMTP id wu5-20020a170906eec500b009584c75705emr2314665ejb.17.1685111469649;
        Fri, 26 May 2023 07:31:09 -0700 (PDT)
Received: from carbian.corp.quobyte.com ([2a02:8109:aa3f:ead8::d8a0])
        by smtp.gmail.com with ESMTPSA id r20-20020a170906365400b0094e7d196aa4sm2157023ejb.160.2023.05.26.07.31.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 May 2023 07:31:09 -0700 (PDT)
From:   Mehdi Djait <mehdi.djait.k@gmail.com>
To:     jic23@kernel.org, mazziesaccount@gmail.com
Cc:     krzysztof.kozlowski+dt@linaro.org,
        andriy.shevchenko@linux.intel.com, robh+dt@kernel.org,
        lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Mehdi Djait <mehdi.djait.k@gmail.com>
Subject: [PATCH v4 6/7] iio: accel: kionix-kx022a: Add a function to retrieve number of bytes in buffer
Date:   Fri, 26 May 2023 16:30:47 +0200
Message-Id: <564e55936a0abe7c07a7fe51605e298a5264e56f.1685109507.git.mehdi.djait.k@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1685109507.git.mehdi.djait.k@gmail.com>
References: <cover.1685109507.git.mehdi.djait.k@gmail.com>
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
index 69c22071c731..20f5965e878c 100644
--- a/drivers/iio/accel/kionix-kx022a.c
+++ b/drivers/iio/accel/kionix-kx022a.c
@@ -597,26 +597,33 @@ static int kx022a_drop_fifo_contents(struct kx022a_data *data)
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
+		fifo_bytes = KX022A_FIFO_MAX_BYTES;
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
@@ -1025,6 +1032,7 @@ const struct kx022a_chip_info kx022a_chip_info = {
 	.inc5		  = KX022A_REG_INC5,
 	.inc6		  = KX022A_REG_INC6,
 	.xout_l		  = KX022A_REG_XOUT_L,
+	.get_fifo_bytes	  = kx022a_get_fifo_bytes,
 };
 EXPORT_SYMBOL_NS_GPL(kx022a_chip_info, IIO_KX022A);
 
diff --git a/drivers/iio/accel/kionix-kx022a.h b/drivers/iio/accel/kionix-kx022a.h
index c23b6f03409e..7792907534b5 100644
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
@@ -122,6 +125,7 @@ struct kx022a_chip_info {
 	u8 inc5;
 	u8 inc6;
 	u8 xout_l;
+	int (*get_fifo_bytes)(struct kx022a_data *);
 };
 
 int kx022a_probe_internal(struct device *dev, const struct kx022a_chip_info *chip_info);
-- 
2.30.2

