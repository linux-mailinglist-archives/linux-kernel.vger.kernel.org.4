Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3D3E6ED7CB
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 00:23:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233311AbjDXWXa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 18:23:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233331AbjDXWXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 18:23:19 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AA5A9763;
        Mon, 24 Apr 2023 15:22:55 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-94f6c285d92so925536766b.3;
        Mon, 24 Apr 2023 15:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682374973; x=1684966973;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FoF1baVk2RoBBy3cWgZg6CaYQE0V6qisn+a/Dv8tzas=;
        b=WB8DHPU7jeKrT1Zd0WXa7fJcpSUmOswPYDjaD0Ooju2so3LKXUc/PhR2TFwXzYwNry
         Xl4dwnGEXbLhqBO42Xivirb2dVo/mNusm4hK+zW7TKyCeiFQjldlXF0jf7lL+QJ7H7vU
         1bJc9zmJI2aEfnrf7NMZTdKwnbOeu+UXgrTg/gR0H5b07VTija0EloK17TFmURGyReln
         Ej59yr7dfA2haXeA6zkY1J1aIP92m69w0Zt8v7DSn0IbO4UJdE+kYCw41vm7BzjBJyZ4
         VOsQCzLJT+UlyhWir0k1asZ4mqcNUy8pYLGlB6kkan0AgSu06qL+9PdPn8+spyCdlkrZ
         INyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682374973; x=1684966973;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FoF1baVk2RoBBy3cWgZg6CaYQE0V6qisn+a/Dv8tzas=;
        b=U9XePn1KyJp08cgSBpW4nNcyveAARH0x+OEr/6wmFQm2rESgpEU7GKH7EFbQMUUvNC
         Hl0G6ks+2UTZQFY/BmafePw9VA9oImYIvwkSvqwaiPxpYrqdjeAfMoyaaTgMf80kGFFL
         q2Lh7OV9AsSL3hiENMznjlBN4cOu806Jd81BUTWyNi6yBbOi+FQtoagTTdbmDiZCRNKe
         Dxo8EMQkoLyDKfxO6booVmZOyssJ77Xy4V2Wxa10/Bkbt9hfO8SmOl3fcvP31hm9zmEa
         Rj2kfTOP4dNNEdCIFdeR8yRpV7cUxQvtXBbioxfIGa/YYphMplArjuCieNQAosoD943k
         1jzg==
X-Gm-Message-State: AAQBX9ciAhI4VIDqIZwf3qECfxb2Bv3ikcUdOIKps4h/Yhl23i2bfVIH
        fVvuez3BNCW8cPFMEKuMRow8U7TMubI=
X-Google-Smtp-Source: AKy350Z2PYm7Jds71RBDUt4XFycY0IgNW/a55c9vpGP2driF1JEsi2b2+r8zwyp2ZwH+Q45/cNS2fQ==
X-Received: by 2002:a17:906:2855:b0:94e:f9b:66e7 with SMTP id s21-20020a170906285500b0094e0f9b66e7mr11205745ejc.13.1682374973291;
        Mon, 24 Apr 2023 15:22:53 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8109:aa3f:ead8::2fd0])
        by smtp.gmail.com with ESMTPSA id g21-20020a170906539500b0094efdfe60dcsm5870886ejo.206.2023.04.24.15.22.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Apr 2023 15:22:52 -0700 (PDT)
From:   Mehdi Djait <mehdi.djait.k@gmail.com>
To:     jic23@kernel.org, mazziesaccount@gmail.com
Cc:     krzysztof.kozlowski+dt@linaro.org,
        andriy.shevchenko@linux.intel.com, robh+dt@kernel.org,
        lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Mehdi Djait <mehdi.djait.k@gmail.com>
Subject: [PATCH v3 6/7] iio: accel: kionix-kx022a: Add a function to retrieve number of bytes in buffer
Date:   Tue, 25 Apr 2023 00:22:26 +0200
Message-Id: <fc12d40f7c2132c1a9a1b5f83b79231dc8ce539f.1682373451.git.mehdi.djait.k@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1682373451.git.mehdi.djait.k@gmail.com>
References: <cover.1682373451.git.mehdi.djait.k@gmail.com>
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

Signed-off-by: Mehdi Djait <mehdi.djait.k@gmail.com>
---
v3:
- fixed the warning of the kernel test robot in kx132_get_fifo_bytes
	(invalid assignment: &=, left side has type restricted __le16
	right side has type unsigned short)

v2:
- mentioned the kx132-1211 in the Kconfig
- added a kx132-specific get_fifo_bytes function
- changed the device name from "kx132" to "kx132-1211

 drivers/iio/accel/kionix-kx022a.c | 30 ++++++++++++++++++++----------
 drivers/iio/accel/kionix-kx022a.h |  4 ++++
 2 files changed, 24 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/accel/kionix-kx022a.c b/drivers/iio/accel/kionix-kx022a.c
index 66da3c8c3fd0..4a31d17c1f22 100644
--- a/drivers/iio/accel/kionix-kx022a.c
+++ b/drivers/iio/accel/kionix-kx022a.c
@@ -595,11 +595,28 @@ static int kx022a_drop_fifo_contents(struct kx022a_data *data)
 	return regmap_write(data->regmap, data->chip_info->buf_clear, 0x0);
 }
 
+static int kx022a_get_fifo_bytes(struct kx022a_data *data)
+{
+	struct device *dev = regmap_get_device(data->regmap);
+	int ret, fifo_bytes;
+
+	ret = regmap_read(data->regmap, KX022A_REG_BUF_STATUS_1, &fifo_bytes);
+	if (ret) {
+		dev_err(dev, "Error reading buffer status\n");
+		return ret;
+	}
+
+	/* Let's not overflow if we for some reason get bogus value from i2c */
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
 	__le16 *buffer;
 	uint64_t sample_period;
 	int count, fifo_bytes;
@@ -611,15 +628,7 @@ static int __kx022a_fifo_flush(struct iio_dev *idev, unsigned int samples,
 	if (!buffer)
 		return -ENOMEM;
 
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
@@ -1023,6 +1032,7 @@ const struct kx022a_chip_info kx022a_chip_info = {
 	.inc5		  = KX022A_REG_INC5,
 	.inc6		  = KX022A_REG_INC6,
 	.xout_l		  = KX022A_REG_XOUT_L,
+	.get_fifo_bytes	  = kx022a_get_fifo_bytes,
 };
 EXPORT_SYMBOL_NS_GPL(kx022a_chip_info, IIO_KX022A);
 
diff --git a/drivers/iio/accel/kionix-kx022a.h b/drivers/iio/accel/kionix-kx022a.h
index 3c31e7d88f78..f043767067b7 100644
--- a/drivers/iio/accel/kionix-kx022a.h
+++ b/drivers/iio/accel/kionix-kx022a.h
@@ -76,6 +76,8 @@
 
 struct device;
 
+struct kx022a_data;
+
 /**
  * struct kx022a_chip_info - Kionix accelerometer chip specific information
  *
@@ -100,6 +102,7 @@ struct device;
  * @inc5:		interrupt control register 5
  * @inc6:		interrupt control register 6
  * @xout_l:		x-axis output least significant byte
+ * @get_fifo_bytes:	function pointer to get number of bytes in the FIFO buffer
  */
 struct kx022a_chip_info {
 	const char *name;
@@ -123,6 +126,7 @@ struct kx022a_chip_info {
 	u8 inc5;
 	u8 inc6;
 	u8 xout_l;
+	int (*get_fifo_bytes)(struct kx022a_data *);
 };
 
 int kx022a_probe_internal(struct device *dev, const struct kx022a_chip_info *chip_info);
-- 
2.30.2

