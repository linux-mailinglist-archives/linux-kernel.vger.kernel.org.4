Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C89E5EFA28
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 18:21:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236223AbiI2QT5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 12:19:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236180AbiI2QTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 12:19:30 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 024BB1E2766
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 09:19:26 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id q11so425332ilj.10
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 09:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lfop3KAMxguQzK3OXs1UqUTIfKzgEPmF0uqm465dBZs=;
        b=WG42TYB/+VFKje/aLR/xoYmg40TPUhb4j3NTgVLpf+cu8Y8/MUtTTeGEi3fIrK/73v
         tm9mbH+hw8aBU5uDlWyh3kFA+fJ0yA5544AfL8iAz+trXO0/pss/x+Kzmdgrzq8iUxyb
         Ft+Hi1oOzLxmv748U4+JgUIn4Svq8E3Aaq8Fg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lfop3KAMxguQzK3OXs1UqUTIfKzgEPmF0uqm465dBZs=;
        b=qFmObpKCfl5SDI0LlzeLS+XLUBD2fgrYjL3ImL2T89JoXzV3nbQCQjTGhffGhGgzOw
         VT8eN89zkTMevYlgwT4JN3gd3it8VP5Ywtz84GhHUglo0AVhQ+kgxu4ThZlyopEeMnQq
         tV97WKB7HUhCTL1aH4eq2I27Mjj47JfuyrmaAvaR+w6YHPUAcnHbbX6L7fx9Mm4ALt0C
         WIUzjpb7G+wc8oIiMTgPFtbjAzVKdLj2qJR5GeROSHbrGJ12t04Li0vNHX6SnXknkwJe
         XQEi1D+PO1m9bPcRxAmX0bxdAI2lScIfSIe9Q/S372VKPBDGzpi3wYSue2WHKV04jT8p
         lPEQ==
X-Gm-Message-State: ACrzQf1uPcAVx/ZNuF+JYnA1awxw+oP7MF2rtlaYllLpNApl3Pcx1V2s
        lchRbFnS2d3pgFaE5SdMYcDh8A==
X-Google-Smtp-Source: AMsMyM6e7vNLxwyelTGYTIIk3LcsSPQYhZtTTP3GlGOItga3IrvZ2Ln3bI/3WZOrki4bXacJsHJESA==
X-Received: by 2002:a05:6e02:164d:b0:2f9:46bb:6ffb with SMTP id v13-20020a056e02164d00b002f946bb6ffbmr496112ilu.320.1664468365762;
        Thu, 29 Sep 2022 09:19:25 -0700 (PDT)
Received: from rrangel920.bld.corp.google.com (h24-56-189-219.arvdco.broadband.dynamic.tds.net. [24.56.189.219])
        by smtp.gmail.com with ESMTPSA id f12-20020a02848c000000b0035aab2f1ab1sm2965451jai.134.2022.09.29.09.19.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 09:19:25 -0700 (PDT)
From:   Raul E Rangel <rrangel@chromium.org>
To:     linux-acpi@vger.kernel.org, linux-input@vger.kernel.org
Cc:     andriy.shevchenko@linux.intel.com, dmitry.torokhov@gmail.com,
        hdegoede@redhat.com, rafael@kernel.org,
        mika.westerberg@linux.intel.com, mario.limonciello@amd.com,
        timvp@google.com, linus.walleij@linaro.org, jingle.wu@emc.com.tw,
        Raul E Rangel <rrangel@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 04/13] Input: raydium_ts_i2c - Use PM subsystem to manage wake irq
Date:   Thu, 29 Sep 2022 10:19:08 -0600
Message-Id: <20220929093200.v6.4.I06b417b274bbecb31775a73993a7a3c1bc80de7b@changeid>
X-Mailer: git-send-email 2.37.3.998.g577e59143f-goog
In-Reply-To: <20220929161917.2348231-1-rrangel@chromium.org>
References: <20220929161917.2348231-1-rrangel@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
index 3a4952935366f91..66c5b577b791d4f 100644
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
2.37.3.998.g577e59143f-goog

