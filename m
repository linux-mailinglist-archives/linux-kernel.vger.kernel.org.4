Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4055C6D3A38
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Apr 2023 22:10:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231187AbjDBUKs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Apr 2023 16:10:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230331AbjDBUK1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Apr 2023 16:10:27 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BC69CC05
        for <linux-kernel@vger.kernel.org>; Sun,  2 Apr 2023 13:10:24 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id eg48so109411485edb.13
        for <linux-kernel@vger.kernel.org>; Sun, 02 Apr 2023 13:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1680466222;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JemIGhtdjG/TbtBcp8w+D7hK3pU2u0hM7wK5kdSBVec=;
        b=g9Tvx9lk/kHdQLQp48PShBumMe3X49wtUtPqxvPzc7nR+W4VM4FWh2CQSmNU4uuTH+
         lKJoyCf9HKJHTs56uWU6Svf3cMFt4oieNoXsEW4o/NOK9rPLtJNw5OHDu9N4bb0Syw/3
         L/J0LajmMQUGAQ7ZD14NR4xh8y6o1jJU0qikE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680466222;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JemIGhtdjG/TbtBcp8w+D7hK3pU2u0hM7wK5kdSBVec=;
        b=sQ3mSFfzJoydZKbXzylEidj5VjPHtyNaC9sr4jblbWKFAKYNar75ciUtOWzSAPkRUd
         Z+ep7Tz/neJQOQQy/Nj2yQnCQSu2kAkyiRVD4m6gH9ueeRsbJUMt2s/m+Y5tsuva7ipF
         1f0W0uM6uydSeVcBfl7VR8dq3owv1mUV75QBuPj0gNkkCmuYfaRa+z0T7vLjHqA7utfN
         nwsNuhopmUti3kuBizrZzlyZHQ26viPbk1HTtLgzmgqbfLAN+/uEfEDB/ug2Ag9WHiS2
         PBGoPQQI/xc9T4DAdXwkT69EJkmjOyq0URzMzWU7wUPxhZT23HLXBeNRzxH2lkipXbju
         PJIA==
X-Gm-Message-State: AAQBX9fG9cPq3Th5rr9mNFjoKYFEhRKcAiohbvSA913Nrc0YgRkbeOlv
        P9bhiM+a3pQPRIZ6x2p9etoKZEipRbxDW4rRuJw=
X-Google-Smtp-Source: AKy350YtG/43aQpznLS/lp3ljrl1GhQjLftorm/6C/YcYs2+SdFGqTFD6TqO50Jj7ygDmq+R0u0qug==
X-Received: by 2002:a05:6402:450:b0:4fa:e8f3:9685 with SMTP id p16-20020a056402045000b004fae8f39685mr31991889edw.28.1680466222111;
        Sun, 02 Apr 2023 13:10:22 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-95-248-31-153.retail.telecomitalia.it. [95.248.31.153])
        by smtp.gmail.com with ESMTPSA id gl18-20020a170906e0d200b00924d38bbdc0sm3553127ejb.105.2023.04.02.13.10.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Apr 2023 13:10:21 -0700 (PDT)
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
Subject: [PATCH 7/9] Input: edt-ft5x06 - convert to use regmap API
Date:   Sun,  2 Apr 2023 22:09:49 +0200
Message-Id: <20230402200951.1032513-8-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20230402200951.1032513-1-dario.binacchi@amarulasolutions.com>
References: <20230402200951.1032513-1-dario.binacchi@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It replaces custom read/write functions with regmap API, making the
driver code more generic.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

 drivers/input/touchscreen/edt-ft5x06.c | 424 +++++++++++++------------
 1 file changed, 214 insertions(+), 210 deletions(-)

diff --git a/drivers/input/touchscreen/edt-ft5x06.c b/drivers/input/touchscreen/edt-ft5x06.c
index 89958881fca1..8aae4c1e6b73 100644
--- a/drivers/input/touchscreen/edt-ft5x06.c
+++ b/drivers/input/touchscreen/edt-ft5x06.c
@@ -3,6 +3,7 @@
  * Copyright (C) 2012 Simon Budig, <simon.budig@kernelconcepts.de>
  * Daniel Wagener <daniel.wagener@kernelconcepts.de> (M09 firmware support)
  * Lothar Waßmann <LW@KARO-electronics.de> (DT support)
+ * Dario Binacchi <dario.binacchi@amarulasolutions.com> (regmap support)
  */
 
 /*
@@ -26,6 +27,7 @@
 #include <linux/module.h>
 #include <linux/property.h>
 #include <linux/ratelimit.h>
+#include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 #include <linux/slab.h>
 #include <linux/uaccess.h>
@@ -115,6 +117,8 @@ struct edt_ft5x06_ts_data {
 	struct gpio_desc *reset_gpio;
 	struct gpio_desc *wake_gpio;
 
+	struct regmap *regmap;
+
 #if defined(CONFIG_DEBUG_FS)
 	struct dentry *debug_dir;
 	u8 *raw_buffer;
@@ -145,37 +149,10 @@ struct edt_i2c_chip_data {
 	int  max_support_points;
 };
 
-static int edt_ft5x06_ts_readwrite(struct i2c_client *client,
-				   u16 wr_len, u8 *wr_buf,
-				   u16 rd_len, u8 *rd_buf)
-{
-	struct i2c_msg wrmsg[2];
-	int i = 0;
-	int ret;
-
-	if (wr_len) {
-		wrmsg[i].addr  = client->addr;
-		wrmsg[i].flags = 0;
-		wrmsg[i].len = wr_len;
-		wrmsg[i].buf = wr_buf;
-		i++;
-	}
-	if (rd_len) {
-		wrmsg[i].addr  = client->addr;
-		wrmsg[i].flags = I2C_M_RD;
-		wrmsg[i].len = rd_len;
-		wrmsg[i].buf = rd_buf;
-		i++;
-	}
-
-	ret = i2c_transfer(client->adapter, wrmsg, i);
-	if (ret < 0)
-		return ret;
-	if (ret != i)
-		return -EIO;
-
-	return 0;
-}
+static const struct regmap_config edt_ft5x06_i2c_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+};
 
 static bool edt_ft5x06_ts_check_crc(struct edt_ft5x06_ts_data *tsdata,
 				    u8 *buf, int buflen)
@@ -197,6 +174,127 @@ static bool edt_ft5x06_ts_check_crc(struct edt_ft5x06_ts_data *tsdata,
 	return true;
 }
 
+static int edt_M06_i2c_read(void *context, const void *reg_buf, size_t reg_size,
+			    void *val_buf, size_t val_size)
+{
+	struct device *dev = context;
+	struct i2c_client *i2c = to_i2c_client(dev);
+	struct edt_ft5x06_ts_data *tsdata = i2c_get_clientdata(i2c);
+	struct i2c_msg xfer[2];
+	bool reg_read = false;
+	u8 addr;
+	u8 wlen;
+	u8 wbuf[4], rbuf[3];
+	int ret;
+
+	addr = *((u8 *)reg_buf);
+	wbuf[0] = addr;
+	switch (addr) {
+	case 0xf5:
+		wlen = 3;
+		wbuf[0] = 0xf5;
+		wbuf[1] = 0xe;
+		wbuf[2] = *((u8 *)val_buf);
+		break;
+	case 0xf9:
+		wlen = 1;
+		break;
+	default:
+		wlen = 2;
+		reg_read = true;
+		wbuf[0] = M06_REG_CMD(tsdata->factory_mode);
+		wbuf[1] = M06_REG_ADDR(tsdata->factory_mode, addr);
+		wbuf[1] |= tsdata->factory_mode ? 0x80 : 0x40;
+	}
+
+	xfer[0].addr  = i2c->addr;
+	xfer[0].flags = 0;
+	xfer[0].len = wlen;
+	xfer[0].buf = wbuf;
+
+	xfer[1].addr = i2c->addr;
+	xfer[1].flags = I2C_M_RD;
+	xfer[1].len = reg_read ? 2 : val_size;
+	xfer[1].buf = reg_read ? rbuf : val_buf;
+
+	ret = i2c_transfer(i2c->adapter, xfer, 2);
+	if (ret != 2) {
+		if (ret < 0)
+			return ret;
+
+		return -EIO;
+	}
+
+	if (addr == 0xf9) {
+		u8 *buf = (u8 *)val_buf;
+
+		if (buf[0] != 0xaa || buf[1] != 0xaa ||
+		    buf[2] != val_size) {
+			tsdata->header_errors++;
+			dev_err_ratelimited(dev,
+					    "Unexpected header: %02x%02x%02x\n",
+					    buf[0], buf[1], buf[2]);
+			return -EIO;
+		}
+
+		if (!edt_ft5x06_ts_check_crc(tsdata, val_buf, val_size))
+			return -EIO;
+	} else if (reg_read) {
+		u8 crc = wbuf[0] ^ wbuf[1] ^ rbuf[0];
+
+		if (crc != rbuf[1]) {
+			dev_err(dev, "crc error: 0x%02x expected, got 0x%02x\n",
+				crc, rbuf[1]);
+			return -EIO;
+		}
+
+		*((u8 *)val_buf) = rbuf[0];
+	}
+
+	return 0;
+}
+
+static int edt_M06_i2c_write(void *context, const void *data, size_t count)
+{
+	struct device *dev = context;
+	struct i2c_client *i2c = to_i2c_client(dev);
+	struct edt_ft5x06_ts_data *tsdata = i2c_get_clientdata(i2c);
+	u8 addr, val;
+	u8 wbuf[4];
+	struct i2c_msg xfer;
+	int ret;
+
+	addr = *((u8 *)data);
+	val = *((u8 *)data + 1);
+
+	wbuf[0] = M06_REG_CMD(tsdata->factory_mode);
+	wbuf[1] = M06_REG_ADDR(tsdata->factory_mode, addr);
+	wbuf[2] = val;
+	wbuf[3] = wbuf[0] ^ wbuf[1] ^ wbuf[2];
+
+	xfer.addr  = i2c->addr;
+	xfer.flags = 0;
+	xfer.len = 4;
+	xfer.buf = wbuf;
+
+	ret = i2c_transfer(i2c->adapter, &xfer, 1);
+	if (ret != 1) {
+		if (ret < 0)
+			return ret;
+
+		return -EIO;
+	}
+
+	return 0;
+}
+
+static const struct regmap_config edt_M06_i2c_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.read = edt_M06_i2c_read,
+	.write = edt_M06_i2c_write,
+};
+
 static irqreturn_t edt_ft5x06_ts_isr(int irq, void *dev_id)
 {
 	struct edt_ft5x06_ts_data *tsdata = dev_id;
@@ -232,30 +330,13 @@ static irqreturn_t edt_ft5x06_ts_isr(int irq, void *dev_id)
 	memset(rdbuf, 0, sizeof(rdbuf));
 	datalen = tplen * tsdata->max_support_points + offset + crclen;
 
-	error = edt_ft5x06_ts_readwrite(tsdata->client,
-					sizeof(cmd), &cmd,
-					datalen, rdbuf);
+	error = regmap_bulk_read(tsdata->regmap, cmd, rdbuf, datalen);
 	if (error) {
 		dev_err_ratelimited(dev, "Unable to fetch data, error: %d\n",
 				    error);
 		goto out;
 	}
 
-	/* M09/M12 does not send header or CRC */
-	if (tsdata->version == EDT_M06) {
-		if (rdbuf[0] != 0xaa || rdbuf[1] != 0xaa ||
-		    rdbuf[2] != datalen) {
-			tsdata->header_errors++;
-			dev_err_ratelimited(dev,
-					    "Unexpected header: %02x%02x%02x!\n",
-					    rdbuf[0], rdbuf[1], rdbuf[2]);
-			goto out;
-		}
-
-		if (!edt_ft5x06_ts_check_crc(tsdata, rdbuf, datalen))
-			goto out;
-	}
-
 	for (i = 0; i < tsdata->max_support_points; i++) {
 		u8 *buf = &rdbuf[i * tplen + offset];
 
@@ -290,79 +371,6 @@ static irqreturn_t edt_ft5x06_ts_isr(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static int edt_ft5x06_register_write(struct edt_ft5x06_ts_data *tsdata,
-				     u8 addr, u8 value)
-{
-	u8 wrbuf[4];
-
-	switch (tsdata->version) {
-	case EDT_M06:
-		wrbuf[0] = M06_REG_CMD(tsdata->factory_mode);
-		wrbuf[1] = M06_REG_ADDR(tsdata->factory_mode, addr);
-		wrbuf[2] = value;
-		wrbuf[3] = wrbuf[0] ^ wrbuf[1] ^ wrbuf[2];
-		return edt_ft5x06_ts_readwrite(tsdata->client, 4,
-					wrbuf, 0, NULL);
-
-	case EDT_M09:
-	case EDT_M12:
-	case EV_FT:
-	case GENERIC_FT:
-		wrbuf[0] = addr;
-		wrbuf[1] = value;
-
-		return edt_ft5x06_ts_readwrite(tsdata->client, 2,
-					wrbuf, 0, NULL);
-
-	default:
-		return -EINVAL;
-	}
-}
-
-static int edt_ft5x06_register_read(struct edt_ft5x06_ts_data *tsdata,
-				    u8 addr)
-{
-	u8 wrbuf[2], rdbuf[2], crc;
-	int error;
-
-	switch (tsdata->version) {
-	case EDT_M06:
-		wrbuf[0] = M06_REG_CMD(tsdata->factory_mode);
-		wrbuf[1] = M06_REG_ADDR(tsdata->factory_mode, addr);
-		wrbuf[1] |= tsdata->factory_mode ? 0x80 : 0x40;
-
-		error = edt_ft5x06_ts_readwrite(tsdata->client, 2, wrbuf, 2,
-						rdbuf);
-		if (error)
-			return error;
-
-		crc = wrbuf[0] ^ wrbuf[1] ^ rdbuf[0];
-		if (crc != rdbuf[1]) {
-			dev_err(&tsdata->client->dev,
-				"crc error: 0x%02x expected, got 0x%02x\n",
-				crc, rdbuf[1]);
-			return -EIO;
-		}
-		break;
-
-	case EDT_M09:
-	case EDT_M12:
-	case EV_FT:
-	case GENERIC_FT:
-		wrbuf[0] = addr;
-		error = edt_ft5x06_ts_readwrite(tsdata->client, 1,
-						wrbuf, 1, rdbuf);
-		if (error)
-			return error;
-		break;
-
-	default:
-		return -EINVAL;
-	}
-
-	return rdbuf[0];
-}
-
 struct edt_ft5x06_attribute {
 	struct device_attribute dattr;
 	size_t field_offset;
@@ -396,7 +404,7 @@ static ssize_t edt_ft5x06_setting_show(struct device *dev,
 	struct edt_ft5x06_attribute *attr =
 			container_of(dattr, struct edt_ft5x06_attribute, dattr);
 	u8 *field = (u8 *)tsdata + attr->field_offset;
-	int val;
+	unsigned int val;
 	size_t count = 0;
 	int error = 0;
 	u8 addr;
@@ -429,9 +437,8 @@ static ssize_t edt_ft5x06_setting_show(struct device *dev,
 	}
 
 	if (addr != NO_REGISTER) {
-		val = edt_ft5x06_register_read(tsdata, addr);
-		if (val < 0) {
-			error = val;
+		error = regmap_read(tsdata->regmap, addr, &val);
+		if (error) {
 			dev_err(&tsdata->client->dev,
 				"Failed to fetch attribute %s, error %d\n",
 				dattr->attr.name, error);
@@ -504,7 +511,7 @@ static ssize_t edt_ft5x06_setting_store(struct device *dev,
 	}
 
 	if (addr != NO_REGISTER) {
-		error = edt_ft5x06_register_write(tsdata, addr, val);
+		error = regmap_write(tsdata->regmap, addr, val);
 		if (error) {
 			dev_err(&tsdata->client->dev,
 				"Failed to update attribute %s, error: %d\n",
@@ -605,23 +612,19 @@ static const struct attribute_group edt_ft5x06_attr_group = {
 static void edt_ft5x06_restore_reg_parameters(struct edt_ft5x06_ts_data *tsdata)
 {
 	struct edt_reg_addr *reg_addr = &tsdata->reg_addr;
+	struct regmap *regmap = tsdata->regmap;
 
-	edt_ft5x06_register_write(tsdata, reg_addr->reg_threshold,
-				  tsdata->threshold);
-	edt_ft5x06_register_write(tsdata, reg_addr->reg_gain,
-				  tsdata->gain);
+	regmap_write(regmap, reg_addr->reg_threshold, tsdata->threshold);
+	regmap_write(regmap, reg_addr->reg_gain, tsdata->gain);
 	if (reg_addr->reg_offset != NO_REGISTER)
-		edt_ft5x06_register_write(tsdata, reg_addr->reg_offset,
-					  tsdata->offset);
+		regmap_write(regmap, reg_addr->reg_offset, tsdata->offset);
 	if (reg_addr->reg_offset_x != NO_REGISTER)
-		edt_ft5x06_register_write(tsdata, reg_addr->reg_offset_x,
-					  tsdata->offset_x);
+		regmap_write(regmap, reg_addr->reg_offset_x, tsdata->offset_x);
 	if (reg_addr->reg_offset_y != NO_REGISTER)
-		edt_ft5x06_register_write(tsdata, reg_addr->reg_offset_y,
-					  tsdata->offset_y);
+		regmap_write(regmap, reg_addr->reg_offset_y, tsdata->offset_y);
 	if (reg_addr->reg_report_rate != NO_REGISTER)
-		edt_ft5x06_register_write(tsdata, reg_addr->reg_report_rate,
-					  tsdata->report_rate);
+		regmap_write(regmap, reg_addr->reg_report_rate,
+			     tsdata->report_rate);
 }
 
 #ifdef CONFIG_DEBUG_FS
@@ -629,7 +632,7 @@ static int edt_ft5x06_factory_mode(struct edt_ft5x06_ts_data *tsdata)
 {
 	struct i2c_client *client = tsdata->client;
 	int retries = EDT_SWITCH_MODE_RETRIES;
-	int ret;
+	unsigned int val;
 	int error;
 
 	if (tsdata->version != EDT_M06) {
@@ -651,7 +654,7 @@ static int edt_ft5x06_factory_mode(struct edt_ft5x06_ts_data *tsdata)
 	}
 
 	/* mode register is 0x3c when in the work mode */
-	error = edt_ft5x06_register_write(tsdata, WORK_REGISTER_OPMODE, 0x03);
+	error = regmap_write(tsdata->regmap, WORK_REGISTER_OPMODE, 0x03);
 	if (error) {
 		dev_err(&client->dev,
 			"failed to switch to factory mode, error %d\n", error);
@@ -662,8 +665,9 @@ static int edt_ft5x06_factory_mode(struct edt_ft5x06_ts_data *tsdata)
 	do {
 		mdelay(EDT_SWITCH_MODE_DELAY);
 		/* mode register is 0x01 when in factory mode */
-		ret = edt_ft5x06_register_read(tsdata, FACTORY_REGISTER_OPMODE);
-		if (ret == 0x03)
+		error = regmap_read(tsdata->regmap, FACTORY_REGISTER_OPMODE,
+				    &val);
+		if (!error && val == 0x03)
 			break;
 	} while (--retries > 0);
 
@@ -689,11 +693,11 @@ static int edt_ft5x06_work_mode(struct edt_ft5x06_ts_data *tsdata)
 {
 	struct i2c_client *client = tsdata->client;
 	int retries = EDT_SWITCH_MODE_RETRIES;
-	int ret;
+	unsigned int val;
 	int error;
 
 	/* mode register is 0x01 when in the factory mode */
-	error = edt_ft5x06_register_write(tsdata, FACTORY_REGISTER_OPMODE, 0x1);
+	error = regmap_write(tsdata->regmap, FACTORY_REGISTER_OPMODE, 0x1);
 	if (error) {
 		dev_err(&client->dev,
 			"failed to switch to work mode, error: %d\n", error);
@@ -705,8 +709,8 @@ static int edt_ft5x06_work_mode(struct edt_ft5x06_ts_data *tsdata)
 	do {
 		mdelay(EDT_SWITCH_MODE_DELAY);
 		/* mode register is 0x01 when in factory mode */
-		ret = edt_ft5x06_register_read(tsdata, WORK_REGISTER_OPMODE);
-		if (ret == 0x01)
+		error = regmap_read(tsdata->regmap, WORK_REGISTER_OPMODE, &val);
+		if (!error && val == 0x01)
 			break;
 	} while (--retries > 0);
 
@@ -765,10 +769,10 @@ static ssize_t edt_ft5x06_debugfs_raw_data_read(struct file *file,
 	struct edt_ft5x06_ts_data *tsdata = file->private_data;
 	struct i2c_client *client = tsdata->client;
 	int retries  = EDT_RAW_DATA_RETRIES;
-	int val, i, error;
+	unsigned int val;
+	int i, error;
 	size_t read = 0;
 	int colbytes;
-	char wrbuf[3];
 	u8 *rdbuf;
 
 	if (*off < 0 || *off >= tsdata->raw_bufsize)
@@ -781,7 +785,7 @@ static ssize_t edt_ft5x06_debugfs_raw_data_read(struct file *file,
 		goto out;
 	}
 
-	error = edt_ft5x06_register_write(tsdata, 0x08, 0x01);
+	error = regmap_write(tsdata->regmap, 0x08, 0x01);
 	if (error) {
 		dev_err(&client->dev,
 			"failed to write 0x08 register, error %d\n", error);
@@ -790,18 +794,18 @@ static ssize_t edt_ft5x06_debugfs_raw_data_read(struct file *file,
 
 	do {
 		usleep_range(EDT_RAW_DATA_DELAY, EDT_RAW_DATA_DELAY + 100);
-		val = edt_ft5x06_register_read(tsdata, 0x08);
-		if (val < 1)
+		error = regmap_read(tsdata->regmap, 0x08, &val);
+		if (error) {
+			dev_err(&client->dev,
+				"failed to read 0x08 register, error %d\n",
+				error);
+			goto out;
+		}
+
+		if (val == 1)
 			break;
 	} while (--retries > 0);
 
-	if (val < 0) {
-		error = val;
-		dev_err(&client->dev,
-			"failed to read 0x08 register, error %d\n", error);
-		goto out;
-	}
-
 	if (retries == 0) {
 		dev_err(&client->dev,
 			"timed out waiting for register to settle\n");
@@ -812,13 +816,9 @@ static ssize_t edt_ft5x06_debugfs_raw_data_read(struct file *file,
 	rdbuf = tsdata->raw_buffer;
 	colbytes = tsdata->num_y * sizeof(u16);
 
-	wrbuf[0] = 0xf5;
-	wrbuf[1] = 0x0e;
 	for (i = 0; i < tsdata->num_x; i++) {
-		wrbuf[2] = i;  /* column index */
-		error = edt_ft5x06_ts_readwrite(tsdata->client,
-						sizeof(wrbuf), wrbuf,
-						colbytes, rdbuf);
+		rdbuf[0] = i;  /* column index */
+		error = regmap_bulk_read(tsdata->regmap, 0xf5, rdbuf, colbytes);
 		if (error)
 			goto out;
 
@@ -894,8 +894,7 @@ static int edt_ft5x06_ts_identify(struct i2c_client *client,
 	 * to have garbage in there
 	 */
 	memset(rdbuf, 0, sizeof(rdbuf));
-	error = edt_ft5x06_ts_readwrite(client, 1, "\xBB",
-					EDT_NAME_LEN - 1, rdbuf);
+	error = regmap_bulk_read(tsdata->regmap, 0xBB, rdbuf, EDT_NAME_LEN - 1);
 	if (error)
 		return error;
 
@@ -917,6 +916,14 @@ static int edt_ft5x06_ts_identify(struct i2c_client *client,
 			*p++ = '\0';
 		strscpy(model_name, rdbuf + 1, EDT_NAME_LEN);
 		strscpy(fw_version, p ? p : "", EDT_NAME_LEN);
+
+		regmap_exit(tsdata->regmap);
+		tsdata->regmap = regmap_init_i2c(client,
+						 &edt_M06_i2c_regmap_config);
+		if (IS_ERR(tsdata->regmap)) {
+			dev_err(&client->dev, "regmap allocation failed\n");
+			return PTR_ERR(tsdata->regmap);
+		}
 	} else if (!strncasecmp(rdbuf, "EP0", 3)) {
 		tsdata->version = EDT_M12;
 
@@ -943,15 +950,13 @@ static int edt_ft5x06_ts_identify(struct i2c_client *client,
 		 */
 		tsdata->version = GENERIC_FT;
 
-		error = edt_ft5x06_ts_readwrite(client, 1, "\xA6",
-						2, rdbuf);
+		error = regmap_bulk_read(tsdata->regmap, 0xA6, rdbuf, 2);
 		if (error)
 			return error;
 
 		strscpy(fw_version, rdbuf, 2);
 
-		error = edt_ft5x06_ts_readwrite(client, 1, "\xA8",
-						1, rdbuf);
+		error = regmap_bulk_read(tsdata->regmap, 0xA8, rdbuf, 1);
 		if (error)
 			return error;
 
@@ -980,8 +985,7 @@ static int edt_ft5x06_ts_identify(struct i2c_client *client,
 			break;
 		case 0x59:  /* Evervision Display with FT5xx6 TS */
 			tsdata->version = EV_FT;
-			error = edt_ft5x06_ts_readwrite(client, 1, "\x53",
-							1, rdbuf);
+			error = regmap_bulk_read(tsdata->regmap, 0x53, rdbuf, 1);
 			if (error)
 				return error;
 			strscpy(fw_version, rdbuf, 1);
@@ -1003,42 +1007,40 @@ static void edt_ft5x06_ts_get_defaults(struct device *dev,
 				       struct edt_ft5x06_ts_data *tsdata)
 {
 	struct edt_reg_addr *reg_addr = &tsdata->reg_addr;
+	struct regmap *regmap = tsdata->regmap;
 	u32 val;
 	int error;
 
 	error = device_property_read_u32(dev, "threshold", &val);
 	if (!error) {
-		edt_ft5x06_register_write(tsdata, reg_addr->reg_threshold, val);
+		regmap_write(regmap, reg_addr->reg_threshold, val);
 		tsdata->threshold = val;
 	}
 
 	error = device_property_read_u32(dev, "gain", &val);
 	if (!error) {
-		edt_ft5x06_register_write(tsdata, reg_addr->reg_gain, val);
+		regmap_write(regmap, reg_addr->reg_gain, val);
 		tsdata->gain = val;
 	}
 
 	error = device_property_read_u32(dev, "offset", &val);
 	if (!error) {
 		if (reg_addr->reg_offset != NO_REGISTER)
-			edt_ft5x06_register_write(tsdata,
-						  reg_addr->reg_offset, val);
+			regmap_write(regmap, reg_addr->reg_offset, val);
 		tsdata->offset = val;
 	}
 
 	error = device_property_read_u32(dev, "offset-x", &val);
 	if (!error) {
 		if (reg_addr->reg_offset_x != NO_REGISTER)
-			edt_ft5x06_register_write(tsdata,
-						  reg_addr->reg_offset_x, val);
+			regmap_write(regmap, reg_addr->reg_offset_x, val);
 		tsdata->offset_x = val;
 	}
 
 	error = device_property_read_u32(dev, "offset-y", &val);
 	if (!error) {
 		if (reg_addr->reg_offset_y != NO_REGISTER)
-			edt_ft5x06_register_write(tsdata,
-						  reg_addr->reg_offset_y, val);
+			regmap_write(regmap, reg_addr->reg_offset_y, val);
 		tsdata->offset_y = val;
 	}
 }
@@ -1046,33 +1048,30 @@ static void edt_ft5x06_ts_get_defaults(struct device *dev,
 static void edt_ft5x06_ts_get_parameters(struct edt_ft5x06_ts_data *tsdata)
 {
 	struct edt_reg_addr *reg_addr = &tsdata->reg_addr;
+	struct regmap *regmap = tsdata->regmap;
+	unsigned int val;
 
-	tsdata->threshold = edt_ft5x06_register_read(tsdata,
-						     reg_addr->reg_threshold);
-	tsdata->gain = edt_ft5x06_register_read(tsdata, reg_addr->reg_gain);
+	regmap_read(regmap, reg_addr->reg_threshold, &tsdata->threshold);
+	regmap_read(regmap, reg_addr->reg_gain, &tsdata->gain);
 	if (reg_addr->reg_offset != NO_REGISTER)
-		tsdata->offset =
-			edt_ft5x06_register_read(tsdata, reg_addr->reg_offset);
+		regmap_read(regmap, reg_addr->reg_offset, &tsdata->offset);
 	if (reg_addr->reg_offset_x != NO_REGISTER)
-		tsdata->offset_x =
-			edt_ft5x06_register_read(tsdata,
-						 reg_addr->reg_offset_x);
+		regmap_read(regmap, reg_addr->reg_offset_x, &tsdata->offset_x);
 	if (reg_addr->reg_offset_y != NO_REGISTER)
-		tsdata->offset_y =
-			edt_ft5x06_register_read(tsdata,
-						 reg_addr->reg_offset_y);
+		regmap_read(regmap, reg_addr->reg_offset_y, &tsdata->offset_y);
 	if (reg_addr->reg_report_rate != NO_REGISTER)
-		tsdata->report_rate =
-			edt_ft5x06_register_read(tsdata,
-						 reg_addr->reg_report_rate);
+		regmap_read(regmap, reg_addr->reg_report_rate,
+			    &tsdata->report_rate);
 	tsdata->num_x = EDT_DEFAULT_NUM_X;
-	if (reg_addr->reg_num_x != NO_REGISTER)
-		tsdata->num_x = edt_ft5x06_register_read(tsdata,
-							 reg_addr->reg_num_x);
+	if (reg_addr->reg_num_x != NO_REGISTER) {
+		if (!regmap_read(regmap, reg_addr->reg_num_x, &val))
+			tsdata->num_x = val;
+	}
 	tsdata->num_y = EDT_DEFAULT_NUM_Y;
-	if (reg_addr->reg_num_y != NO_REGISTER)
-		tsdata->num_y = edt_ft5x06_register_read(tsdata,
-							 reg_addr->reg_num_y);
+	if (reg_addr->reg_num_y != NO_REGISTER) {
+		if (!regmap_read(regmap, reg_addr->reg_num_y, &val))
+			tsdata->num_y = val;
+	}
 }
 
 static void edt_ft5x06_ts_set_regs(struct edt_ft5x06_ts_data *tsdata)
@@ -1142,7 +1141,7 @@ static int edt_ft5x06_ts_probe(struct i2c_client *client)
 	const struct i2c_device_id *id = i2c_client_get_device_id(client);
 	const struct edt_i2c_chip_data *chip_data;
 	struct edt_ft5x06_ts_data *tsdata;
-	u8 buf[2] = { 0xfc, 0x00 };
+	unsigned int val;
 	struct input_dev *input;
 	unsigned long irq_flags;
 	int error;
@@ -1156,6 +1155,12 @@ static int edt_ft5x06_ts_probe(struct i2c_client *client)
 		return -ENOMEM;
 	}
 
+	tsdata->regmap = regmap_init_i2c(client, &edt_ft5x06_i2c_regmap_config);
+	if (IS_ERR(tsdata->regmap)) {
+		dev_err(&client->dev, "regmap allocation failed\n");
+		return PTR_ERR(tsdata->regmap);
+	}
+
 	chip_data = device_get_match_data(&client->dev);
 	if (!chip_data)
 		chip_data = (const struct edt_i2c_chip_data *)id->driver_data;
@@ -1258,6 +1263,7 @@ static int edt_ft5x06_ts_probe(struct i2c_client *client)
 	tsdata->client = client;
 	tsdata->input = input;
 	tsdata->factory_mode = false;
+	i2c_set_clientdata(client, tsdata);
 
 	error = edt_ft5x06_ts_identify(client, tsdata);
 	if (error) {
@@ -1269,7 +1275,7 @@ static int edt_ft5x06_ts_probe(struct i2c_client *client)
 	 * Dummy read access. EP0700MLP1 returns bogus data on the first
 	 * register read access and ignores writes.
 	 */
-	edt_ft5x06_ts_readwrite(tsdata->client, 2, buf, 2, buf);
+	regmap_read(tsdata->regmap, 0x00, &val);
 
 	edt_ft5x06_ts_set_regs(tsdata);
 	edt_ft5x06_ts_get_defaults(&client->dev, tsdata);
@@ -1291,9 +1297,8 @@ static int edt_ft5x06_ts_probe(struct i2c_client *client)
 		if (tsdata->version == EDT_M06)
 			tsdata->report_rate /= 10;
 
-		edt_ft5x06_register_write(tsdata,
-					  tsdata->reg_addr.reg_report_rate,
-					  tsdata->report_rate);
+		regmap_write(tsdata->regmap, tsdata->reg_addr.reg_report_rate,
+			     tsdata->report_rate);
 	}
 
 	dev_dbg(&client->dev,
@@ -1318,8 +1323,6 @@ static int edt_ft5x06_ts_probe(struct i2c_client *client)
 		return error;
 	}
 
-	i2c_set_clientdata(client, tsdata);
-
 	irq_flags = irq_get_trigger_type(client->irq);
 	if (irq_flags == IRQF_TRIGGER_NONE)
 		irq_flags = IRQF_TRIGGER_FALLING;
@@ -1357,6 +1360,7 @@ static void edt_ft5x06_ts_remove(struct i2c_client *client)
 	struct edt_ft5x06_ts_data *tsdata = i2c_get_clientdata(client);
 
 	edt_ft5x06_ts_teardown_debugfs(tsdata);
+	regmap_exit(tsdata->regmap);
 }
 
 static int edt_ft5x06_ts_suspend(struct device *dev)
@@ -1373,8 +1377,8 @@ static int edt_ft5x06_ts_suspend(struct device *dev)
 		return 0;
 
 	/* Enter hibernate mode. */
-	ret = edt_ft5x06_register_write(tsdata, PMOD_REGISTER_OPMODE,
-					PMOD_REGISTER_HIBERNATE);
+	ret = regmap_write(tsdata->regmap, PMOD_REGISTER_OPMODE,
+			   PMOD_REGISTER_HIBERNATE);
 	if (ret)
 		dev_warn(dev, "Failed to set hibernate mode\n");
 
-- 
2.32.0

