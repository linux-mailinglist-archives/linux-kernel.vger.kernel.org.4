Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65B4E67FC24
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 02:35:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231680AbjA2Bev (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 20:34:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbjA2Beg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 20:34:36 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 792D41ADFF;
        Sat, 28 Jan 2023 17:34:31 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id fl11-20020a05600c0b8b00b003daf72fc844so7824059wmb.0;
        Sat, 28 Jan 2023 17:34:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=noifTElFu9mmHKT03DqbqnypIlOKd/W5pFkjf4BBLe4=;
        b=jpreqJpDTKuNCmKTUb4yBLFnDrq86M7Wd6Jv10pMve92idxjs7EPSdotVFRmFan85G
         7dfu2qXsi4bWejbcN4P/IpMSM51lCihn1vbsQ0Gbk5PiZoQLUx9li2flS6PCoBLiw+fl
         hsWiDUHOsPlxSdQ86hkVoX+bai5XtaYQS7u+R5GmyXJL8rqv86P3G5Tinompx4qDzKrx
         5Ufh4nT0hVW+DXyaXPYAVK3gd0xzFbOVaZIZ2SzzCARj+ZuCLQpppB/LxtoJOi5o5t+6
         xaySNAJIA8Nd4DGX4QGYGu8RIkf8jlYnsldLUOA1VuDAVQpeoaoVwngnHhjn6UjBbRUj
         /wlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=noifTElFu9mmHKT03DqbqnypIlOKd/W5pFkjf4BBLe4=;
        b=rJ1kivCPGMPmsvpXACJKbUpl/byTMmE3l/m70DDDN1yTtIjm8GfrrEDQeZDjRtXcEB
         uCKhX/x6DmxjYTm7zCSUimb7CLjdKtdbmT2IbFU21DLR9EkqwuDshOGQk6xE45+O+LJ1
         9iA4Kv0TE4ftm89TL+wcpHFubLxMKgzJccZkKVL4cLottPhiZPEC0/u/oL2L4sA/FybA
         H7Gmhcnjhnx9Kfg0zpyVo6v+3upiutnx0TeitXOuS2E4yMwNh7vr+/F8v1JcYQ2K0S8+
         MIQUzA14pFN++R0V7FXQVg5H9fcT1h2qicCHfZvNx7D8ylw34lo5y2kZUklLzD8ShyWH
         EQWQ==
X-Gm-Message-State: AFqh2kpMyn5DHn7Ci7X1iagu9syglg83AEHMbqac0wx8WDQYo4mkUTX4
        jU6/fb50DAT15nR86zAL8LArokm4IcI=
X-Google-Smtp-Source: AMrXdXvVHQP4qiE+A4DKODzzhuFvhtpEf94dndAeTkt5LN7XVdO0gnFYLtsNkLOOxSB2dFnDxKAdUA==
X-Received: by 2002:a05:600c:4f42:b0:3db:2e62:1d69 with SMTP id m2-20020a05600c4f4200b003db2e621d69mr34551985wmq.31.1674956069435;
        Sat, 28 Jan 2023 17:34:29 -0800 (PST)
Received: from localhost.localdomain (143.red-83-35-57.dynamicip.rima-tde.net. [83.35.57.143])
        by smtp.gmail.com with ESMTPSA id r7-20020a05600c434700b003dc3f195abesm5197132wme.39.2023.01.28.17.34.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Jan 2023 17:34:29 -0800 (PST)
From:   Angel Iglesias <ang.iglesiasg@gmail.com>
To:     linux-iio@vger.kernel.org
Cc:     Angel Iglesias <ang.iglesiasg@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andreas Klinger <ak@it-klinger.de>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/7] iio: pressure: bmp280: Add preinit callback
Date:   Sun, 29 Jan 2023 02:33:04 +0100
Message-Id: <f44c0fce3fa620db03ade26c8b131d62d46df1c3.1674954271.git.ang.iglesiasg@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1674954271.git.ang.iglesiasg@gmail.com>
References: <cover.1674954271.git.ang.iglesiasg@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds preinit callback to execute operations on probe before applying
initial configuration.

Signed-off-by: Angel Iglesias <ang.iglesiasg@gmail.com>

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index 2c8773db4b73..6467034b1d3e 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -1076,6 +1076,12 @@ static const int bmp380_odr_table[][2] = {
 	[BMP380_ODR_0_0015HZ]	= {0, 1526},
 };
 
+static int bmp380_preinit(struct bmp280_data *data)
+{
+	/* BMP3xx requires soft-reset as part of initialization */
+	return bmp380_cmd(data, BMP380_CMD_SOFT_RESET);
+}
+
 static int bmp380_chip_config(struct bmp280_data *data)
 {
 	bool change = false, aux;
@@ -1206,6 +1212,7 @@ const struct bmp280_chip_info bmp380_chip_info = {
 	.read_temp = bmp380_read_temp,
 	.read_press = bmp380_read_press,
 	.read_calib = bmp380_read_calib,
+	.preinit = bmp380_preinit,
 };
 EXPORT_SYMBOL_NS(bmp380_chip_info, IIO_BMP280);
 
@@ -1605,11 +1612,11 @@ int bmp280_common_probe(struct device *dev,
 		return -EINVAL;
 	}
 
-	/* BMP3xx requires soft-reset as part of initialization */
-	if (chip_id == BMP380_CHIP_ID) {
-		ret = bmp380_cmd(data, BMP380_CMD_SOFT_RESET);
-		if (ret < 0)
-			return ret;
+	if (data->chip_info->preinit) {
+		ret = data->chip_info->preinit(data);
+		if (ret)
+			return dev_err_probe(data->dev, ret,
+					     "error running preinit tasks\n");
 	}
 
 	ret = data->chip_info->chip_config(data);
diff --git a/drivers/iio/pressure/bmp280.h b/drivers/iio/pressure/bmp280.h
index 387723fd0772..be17104ef0a2 100644
--- a/drivers/iio/pressure/bmp280.h
+++ b/drivers/iio/pressure/bmp280.h
@@ -345,6 +345,7 @@ struct bmp280_chip_info {
 	int (*read_press)(struct bmp280_data *, int *, int *);
 	int (*read_humid)(struct bmp280_data *, int *, int *);
 	int (*read_calib)(struct bmp280_data *);
+	int (*preinit)(struct bmp280_data *);
 };
 
 /* Chip infos for each variant */
-- 
2.39.1

