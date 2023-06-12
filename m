Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FC6072C891
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 16:30:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236090AbjFLOas (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 10:30:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237471AbjFLOYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 10:24:24 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B90D1732;
        Mon, 12 Jun 2023 07:22:42 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-977c89c47bdso806581366b.2;
        Mon, 12 Jun 2023 07:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686579758; x=1689171758;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/+Ghp8WMod9KmBp0Ag2UtethCdWRlkhLW4wWpba/VrQ=;
        b=pFKnX9Refkqf3XFKjY0johL+sKdq+r9ih9Og93B55nbXhJEHG2vem4KZ75vve3RKvy
         32HA3wkrgUvXEoII1v2usyVZlLpT/ZLJRVXznSPT0jj/CglPEC722P9XWxN0LZUOUgwI
         RaxIvv+Ivf/qPWbF09JLMcueQhNLMuGQbJAhWew2KlOQm8B2xyU8szKyDwGueYyuCQeO
         q+gGDbLdokb8uZQeUKHqBXnfDWUmkFtxu/z7/fdsJ0mCK8XKve5+d07JSIQ8PPZuSdgT
         XL6HtlP/RN+k+BOMSjeZVsREmtyOxilwO/FAUOxA3pCsxQpOKOQ5GDtQiJIwlNRjhz+U
         Bi6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686579758; x=1689171758;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/+Ghp8WMod9KmBp0Ag2UtethCdWRlkhLW4wWpba/VrQ=;
        b=HeDzRjueLZOBUOsPGjTNx0QU8fAPJ/0p1npF5WUY4reLevb3rnNGH7IYmt6JJl/yZp
         skdATZD9EvqODsNJ8OEK/BC4Wer2ukVQouSElMSBMTG2gCrUkOd0HlMwOzyQ4Lw7DluH
         drWCS9+Zo7CAciXGyVKUpFaT3x91mPOPigrX5jS82xUFiDl9UQvWb0105B+CouGx55IY
         ImN0588eyEHU4Nxhq3q/wFJNff4M3IvSMAyAXIxIamcXrF1Qd10e39mtP57CuYiSYYWr
         70uXLc8abGnMKtPhUVD25QcdTDCEXzvz66RRn8zXbFkVR8LG4XNR+KJfQqJcthDR6oxr
         +HXQ==
X-Gm-Message-State: AC+VfDx/+5/ysrwerQBRAsIf2dTcjU/AImzavaSynPew8LcFk3Jc1YjY
        BafdS2okAnYBVLkO0bZCaEc=
X-Google-Smtp-Source: ACHHUZ6hlxBzD31yxGQXXIpcQCEXVRzojZ/Q3C+CWNOPCNuJE12vdlYGYU70fgIvJNoik832krUT+A==
X-Received: by 2002:a17:907:31ce:b0:978:992e:efcf with SMTP id xf14-20020a17090731ce00b00978992eefcfmr10459927ejb.57.1686579758476;
        Mon, 12 Jun 2023 07:22:38 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8109:aa3f:ead8::d8a0])
        by smtp.gmail.com with ESMTPSA id i8-20020a17090671c800b009659fa6eeddsm5262528ejk.196.2023.06.12.07.22.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 07:22:38 -0700 (PDT)
From:   Mehdi Djait <mehdi.djait.k@gmail.com>
To:     jic23@kernel.org, mazziesaccount@gmail.com
Cc:     krzysztof.kozlowski+dt@linaro.org,
        andriy.shevchenko@linux.intel.com, robh+dt@kernel.org,
        lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Mehdi Djait <mehdi.djait.k@gmail.com>
Subject: [PATCH v5 6/7] iio: accel: kionix-kx022a: Add a function to retrieve number of bytes in buffer
Date:   Mon, 12 Jun 2023 16:22:09 +0200
Message-Id: <d09d2c60053158cc85147641eaf7bdce38ede66d.1686578554.git.mehdi.djait.k@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1686578553.git.mehdi.djait.k@gmail.com>
References: <cover.1686578553.git.mehdi.djait.k@gmail.com>
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
index 92cc42b2aaaa..4eed16cd3200 100644
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

