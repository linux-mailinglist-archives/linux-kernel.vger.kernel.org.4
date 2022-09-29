Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B9915EFA32
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 18:21:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236232AbiI2QUB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 12:20:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236179AbiI2QT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 12:19:29 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 655B31E1CDA
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 09:19:25 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id n192so1297120iod.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 09:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0RZMraw+MSve3FKroio91yFqDKIRTDkX36AHVGBSH9U=;
        b=SLvL0tRkoTy264/NjkTRX0UVvir6FYfVr0a1FgjGLg/c8SvU6KMs8TjxCjSwvWyu7W
         ZFvGerSFSh1Bu90dgqxLCIysK8kodRgpQ8wuP8D3OVDKW/d8K/8g/PTEhOvDpKhqdH5j
         w7HXUJKVC5tFcBKKRQbxrnCW1GvOtLBICm2ck=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0RZMraw+MSve3FKroio91yFqDKIRTDkX36AHVGBSH9U=;
        b=iWLJr5RQBGkUorpO5euWhb6kjBp/wXT6OXYdb0F4FUbIV8wNVZDUEuwp41Arq55j1C
         y2RpV7vwJTrx56DCljRSXw/r7znJTAU7MBL5EbCpajHm9S5E6coz/IksCZfbc3nLW7Un
         Ei/CzDvvuMoEhrOdkIfLtXIkSgbHs4hkPUtxJPnhl7Xl0nYajL3rx2jyJboCKY3hJu+W
         OBRkFUErD8f6ak7cQW4JtL72iKQ9i2gY5w7bQCXGNLtRMn1PO/EE2p1tCSvp+pNpaQeu
         4bB08iNOforD79L+jEkjxoE+Ih3t+jyd32WvIcX7W218synzjryXtEojZUoAe3ThM9w4
         6X0g==
X-Gm-Message-State: ACrzQf2I9z6UbW3qMCzauJmDkQkKxU0VKXvdxARCcqkT45SOiH9FDa7I
        Ggy9LmcV61sx1AQNBCGdOBFQuA==
X-Google-Smtp-Source: AMsMyM6KOCM6DeWWxSe4E0kgqW4Y8qIhdGyRKDMJBSPUZK2c0/KUll1VopnFHSBLbWOFbgpdvOZViQ==
X-Received: by 2002:a05:6638:240a:b0:35a:4645:b025 with SMTP id z10-20020a056638240a00b0035a4645b025mr2188882jat.50.1664468364759;
        Thu, 29 Sep 2022 09:19:24 -0700 (PDT)
Received: from rrangel920.bld.corp.google.com (h24-56-189-219.arvdco.broadband.dynamic.tds.net. [24.56.189.219])
        by smtp.gmail.com with ESMTPSA id f12-20020a02848c000000b0035aab2f1ab1sm2965451jai.134.2022.09.29.09.19.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 09:19:24 -0700 (PDT)
From:   Raul E Rangel <rrangel@chromium.org>
To:     linux-acpi@vger.kernel.org, linux-input@vger.kernel.org
Cc:     andriy.shevchenko@linux.intel.com, dmitry.torokhov@gmail.com,
        hdegoede@redhat.com, rafael@kernel.org,
        mika.westerberg@linux.intel.com, mario.limonciello@amd.com,
        timvp@google.com, linus.walleij@linaro.org, jingle.wu@emc.com.tw,
        Raul E Rangel <rrangel@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Johnny Chuang <johnny.chuang.emc@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 03/13] Input: elants_i2c - Use PM subsystem to manage wake irq
Date:   Thu, 29 Sep 2022 10:19:07 -0600
Message-Id: <20220929093200.v6.3.I5862429ee3e4de0f9ad5ba01ce07ad99eec10cf0@changeid>
X-Mailer: git-send-email 2.37.3.998.g577e59143f-goog
In-Reply-To: <20220929161917.2348231-1-rrangel@chromium.org>
References: <20220929161917.2348231-1-rrangel@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Elan I2C touchscreen driver is currently manually managing the wake
IRQ. This change removes the explicit enable_irq_wake/disable_irq_wake
and instead relies on the PM subsystem. This is done by calling
dev_pm_set_wake_irq.

i2c_device_probe already calls dev_pm_set_wake_irq when using device
tree, and i2c_device_remove also already calls dev_pm_clear_wake_irq.
There could be some device tree systems that have incorrectly declared
`wake` capabilities, so this change will set the wake irq if one is
missing. This matches the previous behavior.

Signed-off-by: Raul E Rangel <rrangel@chromium.org>
---

(no changes since v2)

Changes in v2:
- Added elants_i2c to series

 drivers/input/touchscreen/elants_i2c.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/input/touchscreen/elants_i2c.c b/drivers/input/touchscreen/elants_i2c.c
index a56f042adf9d829..80e16b533c452a0 100644
--- a/drivers/input/touchscreen/elants_i2c.c
+++ b/drivers/input/touchscreen/elants_i2c.c
@@ -36,6 +36,7 @@
 #include <linux/input/touchscreen.h>
 #include <linux/acpi.h>
 #include <linux/of.h>
+#include <linux/pm_wakeirq.h>
 #include <linux/gpio/consumer.h>
 #include <linux/regulator/consumer.h>
 #include <linux/uuid.h>
@@ -180,7 +181,6 @@ struct elants_data {
 	u8 cmd_resp[HEADER_SIZE];
 	struct completion cmd_done;
 
-	bool wake_irq_enabled;
 	bool keep_power_in_suspend;
 
 	/* Must be last to be used for DMA operations */
@@ -1582,6 +1582,15 @@ static int elants_i2c_probe(struct i2c_client *client)
 	if (!client->dev.of_node)
 		device_init_wakeup(&client->dev, true);
 
+	/*
+	 * The wake IRQ should be declared via device tree instead of assuming
+	 * the IRQ can wake the system. This is here for legacy reasons and
+	 * will be removed once the i2c-core supports querying ACPI for wake
+	 * capabilities.
+	 */
+	if (!client->dev.power.wakeirq)
+		dev_pm_set_wake_irq(&client->dev, client->irq);
+
 	error = devm_device_add_group(&client->dev, &elants_attribute_group);
 	if (error) {
 		dev_err(&client->dev, "failed to create sysfs attributes: %d\n",
@@ -1626,7 +1635,7 @@ static int __maybe_unused elants_i2c_suspend(struct device *dev)
 		 * The device will automatically enter idle mode
 		 * that has reduced power consumption.
 		 */
-		ts->wake_irq_enabled = (enable_irq_wake(client->irq) == 0);
+		return 0;
 	} else if (ts->keep_power_in_suspend) {
 		for (retry_cnt = 0; retry_cnt < MAX_RETRIES; retry_cnt++) {
 			error = elants_i2c_send(client, set_sleep_cmd,
@@ -1655,8 +1664,6 @@ static int __maybe_unused elants_i2c_resume(struct device *dev)
 	int error;
 
 	if (device_may_wakeup(dev)) {
-		if (ts->wake_irq_enabled)
-			disable_irq_wake(client->irq);
 		elants_i2c_sw_reset(client);
 	} else if (ts->keep_power_in_suspend) {
 		for (retry_cnt = 0; retry_cnt < MAX_RETRIES; retry_cnt++) {
-- 
2.37.3.998.g577e59143f-goog

