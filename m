Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE3005C0353
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 18:02:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231648AbiIUQCn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 12:02:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232629AbiIUQAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 12:00:07 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58A9C175BC
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 08:53:23 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id q83so5381116iod.7
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 08:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=bZ+qtxPfho04MrKrUszJh9/TiBJm28a0YpVnjrNGpL8=;
        b=mCF/QM7OAKcOvv9Q594jwoylSjpaNAuQp69j59Te3aQiMkxEPlUT3Dv1KiWFD5vrfv
         MCjFg9iaUGoW/gzddaj0RyfUeYKk57WpX4j6N+0h+YCJBWaCsErdvmINwQ6DtHKZ9mWR
         nUnR9Z8cdmKszF8iiy6up8A0cFeX85mFuPCdo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=bZ+qtxPfho04MrKrUszJh9/TiBJm28a0YpVnjrNGpL8=;
        b=b6KBcm7xHYKYruh4kzBkS/DhUKghaPQQmGasgP2uRpNGl8M8GrLe9xyW0sQo3XENi4
         80YAYOKdCLPARUmiJ3MGfN7zFWRZt/uaZFEMGOwg5t9Ry3c65TFs7+jh3EU/O67SL2Fb
         MjBSPbz47p0hOoRpYoqKovi9FsfO+GvkUQLqi6MszL4nChr3w+FT2glj4rT3aFRYxwte
         x1peH9MRPx7stVXSGFpdZwStyw+i37QafQ8j6jwVAgmonYlu15PvzN/6vDku7SQT2Nq/
         L9e+JtKOJvCP9+OzHLj9zTp+RqSKU7LH+au2NU6CnGutfFwiErx3WVTJCnLpVDfX9xHD
         7HYw==
X-Gm-Message-State: ACrzQf2CU5iOKKb3VSTPS/LFpoO9P4CIa/uJDxbQQ5O/o4LTbuJq8Hoh
        Pqi1FbhVhuUjrIyT4MV/JxeN7g==
X-Google-Smtp-Source: AMsMyM72fliVsNACh53kZswB/oyGlBYQMe9bQa0Qfw0v0ff/8pEMI0VtdtEy3JWGxSjVxhW3kLi6dw==
X-Received: by 2002:a5e:df43:0:b0:6a1:ffc6:4e30 with SMTP id g3-20020a5edf43000000b006a1ffc64e30mr11835391ioq.192.1663775534113;
        Wed, 21 Sep 2022 08:52:14 -0700 (PDT)
Received: from rrangel920.bld.corp.google.com (h24-56-189-219.arvdco.broadband.dynamic.tds.net. [24.56.189.219])
        by smtp.gmail.com with ESMTPSA id c14-20020a023b0e000000b0035a8d644a31sm1148061jaa.117.2022.09.21.08.52.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 08:52:13 -0700 (PDT)
From:   Raul E Rangel <rrangel@chromium.org>
To:     linux-acpi@vger.kernel.org, linux-input@vger.kernel.org
Cc:     rafael@kernel.org, timvp@google.com,
        mika.westerberg@linux.intel.com, andriy.shevchenko@linux.intel.com,
        dmitry.torokhov@gmail.com, jingle.wu@emc.com.tw,
        hdegoede@redhat.com, mario.limonciello@amd.com,
        linus.walleij@linaro.org, Raul E Rangel <rrangel@chromium.org>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 04/13] Input: raydium_ts_i2c - Use PM subsystem to manage wake irq
Date:   Wed, 21 Sep 2022 09:51:56 -0600
Message-Id: <20220921094736.v5.4.I06b417b274bbecb31775a73993a7a3c1bc80de7b@changeid>
X-Mailer: git-send-email 2.37.3.968.ga6b4b080e4-goog
In-Reply-To: <20220921155205.1332614-1-rrangel@chromium.org>
References: <20220921155205.1332614-1-rrangel@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The raydium I2C touchscreen driver is currently manually managing the
wake IRQ. This change removes the explicit enable_irq_wake /
disable_irq_wake and instead relies on the PM subsystem. This is done by
calling dev_pm_set_wake_irq.

i2c_device_probe already calls dev_pm_set_wake_irq when using device
tree, and i2c_device_remove also already calls dev_pm_clear_wake_irq.
There could be some device tree systems that have incorrectly declared
`wake` capabilities, so this change will set the wake irq if one is
missing. This matches the previous behavior.

Signed-off-by: Raul E Rangel <rrangel@chromium.org>
---

(no changes since v2)

Changes in v2:
- Added raydium_ts_i2c to series

 drivers/input/touchscreen/raydium_i2c_ts.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/input/touchscreen/raydium_i2c_ts.c b/drivers/input/touchscreen/raydium_i2c_ts.c
index 3a4952935366f9..66c5b577b791d4 100644
--- a/drivers/input/touchscreen/raydium_i2c_ts.c
+++ b/drivers/input/touchscreen/raydium_i2c_ts.c
@@ -21,6 +21,7 @@
 #include <linux/interrupt.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/pm_wakeirq.h>
 #include <linux/regulator/consumer.h>
 #include <linux/slab.h>
 #include <asm/unaligned.h>
@@ -134,8 +135,6 @@ struct raydium_data {
 	u8 pkg_size;
 
 	enum raydium_boot_mode boot_mode;
-
-	bool wake_irq_enabled;
 };
 
 /*
@@ -1186,6 +1185,15 @@ static int raydium_i2c_probe(struct i2c_client *client,
 		return error;
 	}
 
+	/*
+	 * The wake IRQ should be declared via device tree instead of assuming
+	 * the IRQ can wake the system. This is here for legacy reasons and
+	 * will be removed once the i2c-core supports querying ACPI for wake
+	 * capabilities.
+	 */
+	if (!client->dev.power.wakeirq)
+		dev_pm_set_wake_irq(&client->dev, client->irq);
+
 	error = devm_device_add_group(&client->dev,
 				   &raydium_i2c_attribute_group);
 	if (error) {
@@ -1222,8 +1230,6 @@ static int __maybe_unused raydium_i2c_suspend(struct device *dev)
 
 	if (device_may_wakeup(dev)) {
 		raydium_enter_sleep(client);
-
-		ts->wake_irq_enabled = (enable_irq_wake(client->irq) == 0);
 	} else {
 		raydium_i2c_power_off(ts);
 	}
@@ -1237,8 +1243,6 @@ static int __maybe_unused raydium_i2c_resume(struct device *dev)
 	struct raydium_data *ts = i2c_get_clientdata(client);
 
 	if (device_may_wakeup(dev)) {
-		if (ts->wake_irq_enabled)
-			disable_irq_wake(client->irq);
 		raydium_i2c_sw_reset(client);
 	} else {
 		raydium_i2c_power_on(ts);
-- 
2.37.3.968.ga6b4b080e4-goog

