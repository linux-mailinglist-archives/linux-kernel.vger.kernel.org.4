Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A9E369C179
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Feb 2023 18:00:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230427AbjBSRAk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Feb 2023 12:00:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230428AbjBSRAi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Feb 2023 12:00:38 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B41012F08;
        Sun, 19 Feb 2023 09:00:31 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id b11so1375780wrw.5;
        Sun, 19 Feb 2023 09:00:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=buT6rsBtaYRd0fPtLJUZZnU5bTcOJFhmzI00E1ESfOk=;
        b=aX1BbmSr4CL+QDJtbPZYHtRVVi9O/Nr6KsUozF4oVUfrJH+jBvoG3vVoxzQfFrYOP9
         F6q57/bveQLsbLXzo9KVGUy1g32jt1rdB6aNaCnv0adWc4to78gNt/8yVlI6WcUYHYC3
         +EkeIz+0MgOHuyEshq/9/CLIQG7zcsxsfhM/2VEw1zLFu2g06vfbt4zvSezxKGKtygnW
         OV8fzMqUYsHwyrW++97QGp9uBVI2p+A91fxfqiK8Z0z/lJs7i4SPrUoAYkxm7Xhn6TBY
         qafPZo9/1HLN8RqMDFQ+ZtFQW3Y3yMXvtGHut5KlSz8I0p9fvOuvDi7TyMilwh52Nmko
         DWQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=buT6rsBtaYRd0fPtLJUZZnU5bTcOJFhmzI00E1ESfOk=;
        b=uGsdgU1XggKCDyRTw15qhF2Mer/eEkPYz82BPRF366TKOAHzB7BKxwtfHmEXk7QaOz
         vstFdl/ul3n8BpqcEgVGHOBd4PhF1kfO0soYV9UvBeBBZihhGagUlWX2nl6u6l/tSq7h
         fPK/nhXPvsALgmuC0YWH5XhEzhakAiEJ2zoiujsGuY+EDikZByMPgHZNRAqm+ml+nt+9
         M41vZa06pYL7B0cqhoeyWLlsCJUMXGelqpeWqvMLeOHrCN8bdFiobIIiVSZAuxjnrkZL
         P2k8D7zQG1c36wiDbamX8S1KnNIbQHG1bXzQV1UR65mSvKOl2kY/97HOWg70x/pgC/qm
         u01g==
X-Gm-Message-State: AO0yUKVZJnq3xS69iu2q9pyE411GRTGQz53OVYVTQEJqKMhHZIbf8KiR
        ezifqhJqtyNqS/5UfVzD3gqt2N8YgJQ=
X-Google-Smtp-Source: AK7set/QVSxiDFK0BfUKKrK1JJvyvog7hMrwIRCycYPaYbeA6VQQHiafDg75P3crFKZAAdNQ7rTYBA==
X-Received: by 2002:adf:e609:0:b0:2bf:ee65:b0b0 with SMTP id p9-20020adfe609000000b002bfee65b0b0mr2343979wrm.41.1676826029780;
        Sun, 19 Feb 2023 09:00:29 -0800 (PST)
Received: from localhost.localdomain (6.red-83-37-22.dynamicip.rima-tde.net. [83.37.22.6])
        by smtp.gmail.com with ESMTPSA id v20-20020a5d5914000000b002c552c6c8c2sm366427wrd.87.2023.02.19.09.00.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Feb 2023 09:00:29 -0800 (PST)
From:   Angel Iglesias <ang.iglesiasg@gmail.com>
To:     linux-iio@vger.kernel.org
Cc:     Angel Iglesias <ang.iglesiasg@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alexandru Lazar <alazar@startmail.com>,
        Andreas Klinger <ak@it-klinger.de>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/7] iio: pressure: bmp280: Add preinit callback
Date:   Sun, 19 Feb 2023 17:58:00 +0100
Message-Id: <fa9513ffad37a6a43b6d46df9d8319ccab6f5870.1676823250.git.ang.iglesiasg@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1676823250.git.ang.iglesiasg@gmail.com>
References: <cover.1676823250.git.ang.iglesiasg@gmail.com>
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
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

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
2.39.2

