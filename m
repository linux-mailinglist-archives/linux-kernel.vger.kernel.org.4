Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E274E61402A
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 22:52:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbiJaVwH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 17:52:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiJaVwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 17:52:03 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C00E610FD3;
        Mon, 31 Oct 2022 14:52:00 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id z97so19329372ede.8;
        Mon, 31 Oct 2022 14:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=O48Ew7BaLfF+WgWmT/5uYlPPqlp4zJtDnYb8TpZxlNg=;
        b=hGHa5RgCm/RKDRyPvTBLwGjyJgvD1tkiYqBTZF/IrITjqFaZU56/dESVP89TV6rwt0
         yIsjdujiVcrr72S0gSBkqwUDEYF7YK636Gv1ioAjwGDa7lh2GkOZybUQaqWBPb33X1vu
         wZcjWFwFtRF0YIPw8kRPUuNcW55QUgWJ5sSZmLh9RC8a0REVWGHAUOUW9T6t9EPZ5I+j
         LYi6UsAK/J4iDzLVzY2ZXYy8tyOFHu4p98FmZgnoroT6IlWm2rZU/c9c1BNiHL4IIWW4
         yeu+f7Wz13OX60waDVZHbp9qSHEt3zJPkM3X4Xgxr8cSrXRLvC/Ur6GschF5UnVqytiu
         xazQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O48Ew7BaLfF+WgWmT/5uYlPPqlp4zJtDnYb8TpZxlNg=;
        b=faqvyCmS6msLNiXz29/KAqha3PKk6sZNQPf8o34ViWl5tPiZfH2yF5ly11z8/0BAHa
         pT05zFVVuMf5pgmxUbQ/vt//axY50wg99KfFfjHN1ynR6NHhC9dHCdZzF76hiIhQMWIf
         mhoMF+cwhpGTxIB39f6GpIqnSHKMLuuPh9pyVhHzbODIY7Zkv/2P8Nfi7OgvfMGvhrHE
         EMHJVVAsAc9Ux5VbSLZhwrYLFpXmSkVg28Umi2oN2rN7LZ9oT5eMDtC0yiWYI1J8FmYq
         B2YyCJ9IPgl1SYubz6qJb8zDi96SHHyz+bpQq6x4H097Q9fwPoQLedUby27ZqYslaWjB
         ERYw==
X-Gm-Message-State: ACrzQf0/+TZFmegHfoWsQsFB59ca4Bty4dWoceqhGQyqq6rcSpwGB87n
        yQSBAx0pweJAzirYor0QIOg=
X-Google-Smtp-Source: AMsMyM6NRcvYH018TMVocFfmYmwGSnrlPXqiN9C56IiOOW3ee0Sle1ptinLhkt5gxK/2huoDGZvryA==
X-Received: by 2002:a50:c302:0:b0:463:26d6:25fb with SMTP id a2-20020a50c302000000b0046326d625fbmr11094892edb.204.1667253119213;
        Mon, 31 Oct 2022 14:51:59 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a01-0c22-763f-bd00-f22f-74ff-fe21-0725.c22.pool.telefonica.de. [2a01:c22:763f:bd00:f22f:74ff:fe21:725])
        by smtp.googlemail.com with ESMTPSA id lh8-20020a170906f8c800b007708130c287sm3391931ejb.40.2022.10.31.14.51.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 14:51:58 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux@roeck-us.net, linux-hwmon@vger.kernel.org
Cc:     jdelvare@suse.com, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH] hwmon: (jc42) Consistently use bit and bitfield macros in the driver
Date:   Mon, 31 Oct 2022 22:51:40 +0100
Message-Id: <20221031215140.482457-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.38.1
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

Use BIT() and GENMASK() macros for defining the bitfields inside the
registers. Also use FIELD_GET() and FIELD_PREP() where appropriate. This
makes the coding style within the driver consistent. No functional
changes intended.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
This is a small patch with what I consider non-functional improvements.
It makes the driver code consistent with what I am familiar with from
other drivers (not limited to hwmon).
So I'm curious if others also feel that this is an improvement.


 drivers/hwmon/jc42.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/hwmon/jc42.c b/drivers/hwmon/jc42.c
index 6593d81cb901..8523bf974310 100644
--- a/drivers/hwmon/jc42.c
+++ b/drivers/hwmon/jc42.c
@@ -10,6 +10,7 @@
  */
 
 #include <linux/bitops.h>
+#include <linux/bitfield.h>
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/slab.h>
@@ -37,20 +38,19 @@ static const unsigned short normal_i2c[] = {
 #define JC42_REG_SMBUS		0x22 /* NXP and Atmel, possibly others? */
 
 /* Status bits in temperature register */
-#define JC42_ALARM_CRIT_BIT	15
-#define JC42_ALARM_MAX_BIT	14
-#define JC42_ALARM_MIN_BIT	13
+#define JC42_ALARM_CRIT		BIT(15)
+#define JC42_ALARM_MAX		BIT(14)
+#define JC42_ALARM_MIN		BIT(13)
 
 /* Configuration register defines */
-#define JC42_CFG_CRIT_ONLY	(1 << 2)
-#define JC42_CFG_TCRIT_LOCK	(1 << 6)
-#define JC42_CFG_EVENT_LOCK	(1 << 7)
-#define JC42_CFG_SHUTDOWN	(1 << 8)
-#define JC42_CFG_HYST_SHIFT	9
-#define JC42_CFG_HYST_MASK	(0x03 << 9)
+#define JC42_CFG_CRIT_ONLY	BIT(2)
+#define JC42_CFG_TCRIT_LOCK	BIT(6)
+#define JC42_CFG_EVENT_LOCK	BIT(7)
+#define JC42_CFG_SHUTDOWN	BIT(8)
+#define JC42_CFG_HYST_MASK	GENMASK(10, 9)
 
 /* Capabilities */
-#define JC42_CAP_RANGE		(1 << 2)
+#define JC42_CAP_RANGE		BIT(2)
 
 /* Manufacturer IDs */
 #define ADT_MANID		0x11d4  /* Analog Devices */
@@ -277,8 +277,8 @@ static int jc42_read(struct device *dev, enum hwmon_sensor_types type,
 			break;
 
 		temp = jc42_temp_from_reg(regval);
-		hyst = jc42_hysteresis[(data->config & JC42_CFG_HYST_MASK)
-						>> JC42_CFG_HYST_SHIFT];
+		hyst = jc42_hysteresis[FIELD_GET(JC42_CFG_HYST_MASK,
+						 data->config)];
 		*val = temp - hyst;
 		break;
 	case hwmon_temp_crit_hyst:
@@ -288,8 +288,8 @@ static int jc42_read(struct device *dev, enum hwmon_sensor_types type,
 			break;
 
 		temp = jc42_temp_from_reg(regval);
-		hyst = jc42_hysteresis[(data->config & JC42_CFG_HYST_MASK)
-						>> JC42_CFG_HYST_SHIFT];
+		hyst = jc42_hysteresis[FIELD_GET(JC42_CFG_HYST_MASK,
+						 data->config)];
 		*val = temp - hyst;
 		break;
 	case hwmon_temp_min_alarm:
@@ -297,21 +297,21 @@ static int jc42_read(struct device *dev, enum hwmon_sensor_types type,
 		if (ret)
 			break;
 
-		*val = (regval >> JC42_ALARM_MIN_BIT) & 1;
+		*val = FIELD_GET(JC42_ALARM_MIN, regval);
 		break;
 	case hwmon_temp_max_alarm:
 		ret = regmap_read(data->regmap, JC42_REG_TEMP, &regval);
 		if (ret)
 			break;
 
-		*val = (regval >> JC42_ALARM_MAX_BIT) & 1;
+		*val = FIELD_GET(JC42_ALARM_MAX, regval);
 		break;
 	case hwmon_temp_crit_alarm:
 		ret = regmap_read(data->regmap, JC42_REG_TEMP, &regval);
 		if (ret)
 			break;
 
-		*val = (regval >> JC42_ALARM_CRIT_BIT) & 1;
+		*val = FIELD_GET(JC42_ALARM_CRIT, regval);
 		break;
 	default:
 		ret = -EOPNOTSUPP;
@@ -370,7 +370,7 @@ static int jc42_write(struct device *dev, enum hwmon_sensor_types type,
 				hyst = 3;	/* 6.0 degrees C */
 		}
 		data->config = (data->config & ~JC42_CFG_HYST_MASK) |
-				(hyst << JC42_CFG_HYST_SHIFT);
+				FIELD_PREP(JC42_CFG_HYST_MASK, hyst);
 		ret = regmap_write(data->regmap, JC42_REG_CONFIG,
 				   data->config);
 		break;
-- 
2.38.1

