Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29C626CC66B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 17:32:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234057AbjC1Pck (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 11:32:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234042AbjC1PcX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 11:32:23 -0400
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3FFD7EF6;
        Tue, 28 Mar 2023 08:32:00 -0700 (PDT)
Received: by mail-ua1-x92e.google.com with SMTP id q8so1458884uas.7;
        Tue, 28 Mar 2023 08:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680017519;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=P0x6xCbQygbPliInrwR1gxPOLOCdBAfNL8QxTNV7eMw=;
        b=MgiMmkHPRroH78cr4TdXWrye5heIP/oIy4WprQVvLx3vWlMsoSHEsaclC5USJnsHwy
         DiN4d861al5DNOao8aa3F7hV0EyKBT0PXzAtleQ4Tynx8Ad9zyq3TSu48/4Dhtv+ubLa
         K86Y7ZTkgBD8XX2QgTHYxTFyog/7/gODAN4bHT9jXfAJ3hlvsat184HcWNJHrZvGwmV4
         kJfYVxGh1jqjevTPq+GXU2ZEF8AmpwdVb3IYpVwOEc+yq22o2o3+bdKBdXYHmFGsdamL
         PmpufY7iVAfFbUoBzPHXBDLG4KQXeWpBvjQSAE7xV9WRMNzymStbnn2pLTt50vir9oas
         1j4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680017519;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P0x6xCbQygbPliInrwR1gxPOLOCdBAfNL8QxTNV7eMw=;
        b=dn4fsfWS610kNjw5bs6Sf/7S7AJbRusHLHnscm4Pa5U7FSrplhCz5vbJbrIC0wMvAg
         QD8XVnad0VI8q6AAGfV/hXfiqyUJjUIViEarj4tuknT64xouTvf13sdUUGBav//GtJu4
         pxOSXO/PYwPe8LZ6jAoQmhNRfdRGif/5fIXP88Xtg95vhBhGw/QIEv7qRXN8ZEQ9tJFn
         eC3YajOOY9vk48eH8/mc2wk+nXQTgQ8XiTJrwDzhNo9zxjmZzNlXRUL+eWJMFCC1d1/v
         xK5mQuitlqjRjsJ0lKO/qDpFqmXBghYKldMIW6KCtxI+8ETS/j3EaI1cVBqdX1pItCdx
         cvbA==
X-Gm-Message-State: AAQBX9fOj3i/lbO4BRKivx9vJP1bZmxan2IOc/QgFjL7PGqS8jYrRFwt
        m35ID7zU3YVMsk4EYWMWB7Ka/2a7HUAgNA==
X-Google-Smtp-Source: AKy350Z2lTaqsVuaBOeMQMJNcTNOXSzZ5D2n+BMpIhHCtDfC1+rbRxuXEeCsPRvzuKgbMzIz/9lGIw==
X-Received: by 2002:a1f:aad0:0:b0:40e:eec8:6d64 with SMTP id t199-20020a1faad0000000b0040eeec86d64mr5933171vke.9.1680017519320;
        Tue, 28 Mar 2023 08:31:59 -0700 (PDT)
Received: from [127.0.1.1] ([91.230.2.244])
        by smtp.gmail.com with ESMTPSA id b2-20020a1fb202000000b00432796a9c36sm4396874vkf.5.2023.03.28.08.31.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 08:31:59 -0700 (PDT)
From:   Benjamin Bara <bbara93@gmail.com>
Date:   Tue, 28 Mar 2023 17:31:49 +0200
Subject: [PATCH v3] Input: tsc2007 - enable GPIO chips that can sleep
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230328-tsc2007-sleep-v3-1-5941e8dc0411@skidata.com>
X-B4-Tracking: v=1; b=H4sIAGQII2QC/zWNQQqDMBBFryJZNxIzxmhXvUfpYhJHDRiViZSCe
 PfGQpePz3v/EIk4UBL34hBM75DCumSAWyH8hMtIMvSZhVYaFOhW7slrpaxMM9Emh8Z0BpBA90p
 kx2Ei6RgXP11WxLQTX8PGNITP7+j5yjzwGuU+MeE/r5WtjLK1gbqEqmoa28pKOoeMHTzGiGEu/
 RrFeX4BlE09F7UAAAA=
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     richard.leitner@linux.dev, christophe.jaillet@wanadoo.fr,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Benjamin Bara <benjamin.bara@skidata.com>,
        Richard Leitner <richard.leitner@linux.dev>
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Benjamin Bara <benjamin.bara@skidata.com>

This enables the usage of "can_sleep" GPIO chips as "pin up" GPIO.
This might be the case if the GPIO chip is an expander behind i2c.

As the pendown value is read during a hard IRQ, the read process is not
allowed to sleep. Therefore, find out if the read process can sleep and
if so, just return true. During the following soft IRQ, the read process
is allowed to sleep and therefore the actual value can be read.

Signed-off-by: Benjamin Bara <benjamin.bara@skidata.com>
Signed-off-by: Richard Leitner <richard.leitner@skidata.com>
---
This is basically a resend of v2 with extended commit message.

v2: https://lore.kernel.org/lkml/20220715074534.3116678-1-bbara93@gmail.com/

----
v3:
- extend commit message

v2:
- fix style mentioned by Christophe
---
 drivers/input/touchscreen/tsc2007.h      |  1 +
 drivers/input/touchscreen/tsc2007_core.c | 34 +++++++++++++++++++++++++++-----
 2 files changed, 30 insertions(+), 5 deletions(-)

diff --git a/drivers/input/touchscreen/tsc2007.h b/drivers/input/touchscreen/tsc2007.h
index 69b08dd6c8df..cdd90d727160 100644
--- a/drivers/input/touchscreen/tsc2007.h
+++ b/drivers/input/touchscreen/tsc2007.h
@@ -78,6 +78,7 @@ struct tsc2007 {
 	bool			stopped;
 
 	int			(*get_pendown_state)(struct device *);
+	int			(*get_pendown_state_cansleep)(struct device *dev);
 	void			(*clear_penirq)(void);
 
 	struct mutex		mlock;
diff --git a/drivers/input/touchscreen/tsc2007_core.c b/drivers/input/touchscreen/tsc2007_core.c
index 3c793fb70a0e..764cec1036e1 100644
--- a/drivers/input/touchscreen/tsc2007_core.c
+++ b/drivers/input/touchscreen/tsc2007_core.c
@@ -20,6 +20,7 @@
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/gpio/consumer.h>
+#include <linux/gpio/driver.h>
 #include <linux/input.h>
 #include <linux/interrupt.h>
 #include <linux/i2c.h>
@@ -108,6 +109,14 @@ bool tsc2007_is_pen_down(struct tsc2007 *ts)
 	return ts->get_pendown_state(&ts->client->dev);
 }
 
+static bool tsc2007_is_pen_down_cansleep(struct tsc2007 *ts)
+{
+	if (!ts->get_pendown_state_cansleep)
+		return true;
+
+	return ts->get_pendown_state_cansleep(&ts->client->dev);
+}
+
 static irqreturn_t tsc2007_soft_irq(int irq, void *handle)
 {
 	struct tsc2007 *ts = handle;
@@ -115,7 +124,7 @@ static irqreturn_t tsc2007_soft_irq(int irq, void *handle)
 	struct ts_event tc;
 	u32 rt;
 
-	while (!ts->stopped && tsc2007_is_pen_down(ts)) {
+	while (!ts->stopped && tsc2007_is_pen_down_cansleep(ts)) {
 
 		/* pen is down, continue with the measurement */
 
@@ -125,7 +134,7 @@ static irqreturn_t tsc2007_soft_irq(int irq, void *handle)
 
 		rt = tsc2007_calculate_resistance(ts, &tc);
 
-		if (!rt && !ts->get_pendown_state) {
+		if (!rt && !ts->get_pendown_state_cansleep) {
 			/*
 			 * If pressure reported is 0 and we don't have
 			 * callback to check pendown state, we have to
@@ -229,6 +238,14 @@ static int tsc2007_get_pendown_state_gpio(struct device *dev)
 	return gpiod_get_value(ts->gpiod);
 }
 
+static int tsc2007_get_pendown_state_gpio_cansleep(struct device *dev)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct tsc2007 *ts = i2c_get_clientdata(client);
+
+	return gpiod_get_value_cansleep(ts->gpiod);
+}
+
 static int tsc2007_probe_properties(struct device *dev, struct tsc2007 *ts)
 {
 	u32 val32;
@@ -264,10 +281,17 @@ static int tsc2007_probe_properties(struct device *dev, struct tsc2007 *ts)
 	if (IS_ERR(ts->gpiod))
 		return PTR_ERR(ts->gpiod);
 
-	if (ts->gpiod)
-		ts->get_pendown_state = tsc2007_get_pendown_state_gpio;
-	else
+	if (ts->gpiod) {
+		ts->get_pendown_state_cansleep = tsc2007_get_pendown_state_gpio_cansleep;
+
+		/* pendown pin is read during hard irq -> gpio chip is not allowed to sleep */
+		if (gpiod_to_chip(ts->gpiod) && !gpiod_to_chip(ts->gpiod)->can_sleep)
+			ts->get_pendown_state = tsc2007_get_pendown_state_gpio;
+		else
+			dev_dbg(dev, "Pen down GPIO chip can sleep\n");
+	} else {
 		dev_warn(dev, "Pen down GPIO is not specified in properties\n");
+	}
 
 	return 0;
 }

---
base-commit: 197b6b60ae7bc51dd0814953c562833143b292aa
change-id: 20230328-tsc2007-sleep-f65953ae32d0

Best regards,
-- 
Benjamin Bara <benjamin.bara@skidata.com>

