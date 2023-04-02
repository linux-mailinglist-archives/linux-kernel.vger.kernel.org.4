Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 991BE6D3A37
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Apr 2023 22:10:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230447AbjDBUKo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Apr 2023 16:10:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230300AbjDBUK1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Apr 2023 16:10:27 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC25DCDE2
        for <linux-kernel@vger.kernel.org>; Sun,  2 Apr 2023 13:10:25 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id cn12so109555545edb.4
        for <linux-kernel@vger.kernel.org>; Sun, 02 Apr 2023 13:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1680466225;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YKRIdGHuZOd/fQcotLl6knbHASupHjbM4BeF84H3jy8=;
        b=KemN7IfEaOKpyLMRAKesUNvo24XAovAd4ZbIiIGt+CDFvnp3LWFFq8s9nJ1oPJI1YG
         vkFLJ91RDd4+nFRefEQHRP5s30PMiMsN3BgnytdSGmJjNFJSFwT7zPGEv2fHNFHIMu9q
         FMrNnNJLaqYIU5iQxiU5i/K8Qb3y2qJgco94I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680466225;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YKRIdGHuZOd/fQcotLl6knbHASupHjbM4BeF84H3jy8=;
        b=Ur3hzieMHJYptYs3V+OSLm54r4FErrv1uY7Nfuq/m5n4yzBcZP3kX1D3Vy9PqDF0Hg
         7evjAPzqtapXlh3abmIYkBNW+mLcwyjCpKLW5QLRqCzVKD/KMjNjs/2pNTFLFvLqxpie
         aBiAnaGH8Oy2LCfkiQSMIREXrS+R0zJxLxKQ3ibxOIr2v3e3HofcJQ2sdYSuLd2Ic5jk
         ogbSpU/4AHwFWYIzNXCqXLsncBvZd8Z19SmoKkhgX++iYkK0MYbCWT6IgxqGtxcftTOK
         nK9m1wpEB6+f77428TDPF4VKp3FPk1o9+zK4FErJ+naWqkIju3og8SpwLksHdL5QcDkS
         3bcw==
X-Gm-Message-State: AAQBX9fFvr0DSg/FEI2BAafUD6QIEqwn8rowNLhsJhuGteaPTRfKM3u0
        Lf/oJ0bQLzlO40fIgS58ylZj54FvwJ7OzvHHjeo=
X-Google-Smtp-Source: AKy350bmW8+mqHitZKifCu3kSyviwg6CmmU0N6sR5cecSEU/DKNNAPOiklDjW2pcVfw3y6wb++6PWw==
X-Received: by 2002:a17:906:4796:b0:93f:3084:d6f with SMTP id cw22-20020a170906479600b0093f30840d6fmr34022998ejc.18.1680466224998;
        Sun, 02 Apr 2023 13:10:24 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-95-248-31-153.retail.telecomitalia.it. [95.248.31.153])
        by smtp.gmail.com with ESMTPSA id gl18-20020a170906e0d200b00924d38bbdc0sm3553127ejb.105.2023.04.02.13.10.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Apr 2023 13:10:24 -0700 (PDT)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     michael@amarulasolutions.com, linux-amarula@amarulasolutions.com,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Oliver Graute <oliver.graute@kococonnector.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-input@vger.kernel.org
Subject: [PATCH 9/9] Input: edt-ft5x06: Calculate points data length only once
Date:   Sun,  2 Apr 2023 22:09:51 +0200
Message-Id: <20230402200951.1032513-10-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20230402200951.1032513-1-dario.binacchi@amarulasolutions.com>
References: <20230402200951.1032513-1-dario.binacchi@amarulasolutions.com>
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

It is pointless and expensive to calculate data in the interrupt that
depends on the type of touchscreen, which is detected on the driver
probe and cannot then be changed.
So calculate the size of the data buffer on the driver probe, as well as
the data retrieval command, and then use them in the ISR.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

 drivers/input/touchscreen/edt-ft5x06.c | 56 +++++++++++++-------------
 1 file changed, 28 insertions(+), 28 deletions(-)

diff --git a/drivers/input/touchscreen/edt-ft5x06.c b/drivers/input/touchscreen/edt-ft5x06.c
index fdb32e3591be..24ab9e9f5b21 100644
--- a/drivers/input/touchscreen/edt-ft5x06.c
+++ b/drivers/input/touchscreen/edt-ft5x06.c
@@ -135,6 +135,10 @@ struct edt_ft5x06_ts_data {
 	int offset_y;
 	int report_rate;
 	int max_support_points;
+	int point_len;
+	u8 tdata_cmd;
+	int tdata_len;
+	int tdata_offset;
 
 	char name[EDT_NAME_LEN];
 	char fw_version[EDT_NAME_LEN];
@@ -296,38 +300,13 @@ static irqreturn_t edt_ft5x06_ts_isr(int irq, void *dev_id)
 {
 	struct edt_ft5x06_ts_data *tsdata = dev_id;
 	struct device *dev = &tsdata->client->dev;
-	u8 cmd;
 	u8 rdbuf[63];
 	int i, type, x, y, id;
-	int offset, tplen, datalen, crclen;
 	int error;
 
-	switch (tsdata->version) {
-	case EDT_M06:
-		cmd = 0xf9; /* tell the controller to send touch data */
-		offset = 5; /* where the actual touch data starts */
-		tplen = 4;  /* data comes in so called frames */
-		crclen = 1; /* length of the crc data */
-		break;
-
-	case EDT_M09:
-	case EDT_M12:
-	case EV_FT:
-	case GENERIC_FT:
-		cmd = 0x0;
-		offset = 3;
-		tplen = 6;
-		crclen = 0;
-		break;
-
-	default:
-		goto out;
-	}
-
 	memset(rdbuf, 0, sizeof(rdbuf));
-	datalen = tplen * tsdata->max_support_points + offset + crclen;
-
-	error = regmap_bulk_read(tsdata->regmap, cmd, rdbuf, datalen);
+	error = regmap_bulk_read(tsdata->regmap, tsdata->tdata_cmd, rdbuf,
+				 tsdata->tdata_len);
 	if (error) {
 		dev_err_ratelimited(dev, "Unable to fetch data, error: %d\n",
 				    error);
@@ -335,7 +314,7 @@ static irqreturn_t edt_ft5x06_ts_isr(int irq, void *dev_id)
 	}
 
 	for (i = 0; i < tsdata->max_support_points; i++) {
-		u8 *buf = &rdbuf[i * tplen + offset];
+		u8 *buf = &rdbuf[i * tsdata->point_len + tsdata->tdata_offset];
 
 		type = buf[0] >> 6;
 		/* ignore Reserved events */
@@ -1071,6 +1050,26 @@ static void edt_ft5x06_ts_get_parameters(struct edt_ft5x06_ts_data *tsdata)
 	}
 }
 
+static void edt_ft5x06_ts_set_tdata_parameters(struct edt_ft5x06_ts_data *tsdata)
+{
+	int crclen;
+
+	if (tsdata->version == EDT_M06) {
+		tsdata->tdata_cmd = 0xf9;
+		tsdata->tdata_offset = 5;
+		tsdata->point_len = 4;
+		crclen = 1;
+	} else {
+		tsdata->tdata_cmd = 0x0;
+		tsdata->tdata_offset = 3;
+		tsdata->point_len = 6;
+		crclen = 0;
+	}
+
+	tsdata->tdata_len = tsdata->point_len * tsdata->max_support_points +
+		tsdata->tdata_offset + crclen;
+}
+
 static void edt_ft5x06_ts_set_regs(struct edt_ft5x06_ts_data *tsdata)
 {
 	struct edt_reg_addr *reg_addr = &tsdata->reg_addr;
@@ -1274,6 +1273,7 @@ static int edt_ft5x06_ts_probe(struct i2c_client *client)
 	 */
 	regmap_read(tsdata->regmap, 0x00, &val);
 
+	edt_ft5x06_ts_set_tdata_parameters(tsdata);
 	edt_ft5x06_ts_set_regs(tsdata);
 	edt_ft5x06_ts_get_defaults(&client->dev, tsdata);
 	edt_ft5x06_ts_get_parameters(tsdata);
-- 
2.32.0

