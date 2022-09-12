Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 272165B636C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 00:16:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbiILWOp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 18:14:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbiILWOC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 18:14:02 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91DB74E615
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 15:13:51 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id e205so4114079iof.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 15:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=vXHIrIo50L1riD03yC2Su3ni64w2wlYKDy3npYanFkI=;
        b=hJd2TgNXN+rJHGuDsMGKINB1TiYRI8Zd7zX78W54wrVkKc5GvO2vvyeM5vV8xshTLd
         VoO1IqzyPM82+99hDRQ4qo+xpv9txNbJuTK2smi71VhvCF16pN2x5odE80pSKsNv7Pl8
         X7lTpwHh4tFXvB1f9CB+v76IR4/3Q4IYFTSE0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=vXHIrIo50L1riD03yC2Su3ni64w2wlYKDy3npYanFkI=;
        b=g9mqxf53zYGDAsyLYBaDxxFvRPYPQ/1+IDSEe8cryL5V2V2v07Ay2qNUsAUgaOQIey
         aHsjTBM+JlsBfJfiE2d9C0kEjgcTLFpDSIkpw6Fp/b6uEEX33YmC+pp3SkSVEGJkT3xF
         RGYOoV+4ELe7YbRksWaRI1makiiXT927oQXeLCPJN4a5xpRrKbDJatJTVzhxg7PUYP1n
         II6/lwuIb0Mak4JivI2tGVXZ5BBdfxPAQsSOoRQOVgTldhjabkvWRw/c+vRrI+jYFePf
         zGdpOU6VT7V9cuZR79g1+k0KTDi48j19fWvMtpBIfe2nucspNVjM9z2Nwd4sbdmgS+zd
         Joyg==
X-Gm-Message-State: ACgBeo1GH8sqFKOq4Udwu/RTZzepBOPK/BgxiTeF5JA2WqpCzvHsFUu8
        YEY/98ID/XP1x4EOCPR3608xwA==
X-Google-Smtp-Source: AA6agR7cqi2okQAOz6bEwKNZTImmFicdp9oezk42RjQYf0T7Ys5LL2qgwdbh/ra8UGMg9JqDx8mg7A==
X-Received: by 2002:a05:6638:1921:b0:350:ed6f:dc89 with SMTP id p33-20020a056638192100b00350ed6fdc89mr14743248jal.154.1663020830921;
        Mon, 12 Sep 2022 15:13:50 -0700 (PDT)
Received: from rrangel920.bld.corp.google.com (h24-56-189-219.arvdco.broadband.dynamic.tds.net. [24.56.189.219])
        by smtp.gmail.com with ESMTPSA id 18-20020a056e020cb200b002f16e7021f6sm4077334ilg.22.2022.09.12.15.13.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Sep 2022 15:13:50 -0700 (PDT)
From:   Raul E Rangel <rrangel@chromium.org>
To:     linux-acpi@vger.kernel.org, linux-input@vger.kernel.org
Cc:     andriy.shevchenko@linux.intel.com, jingle.wu@emc.com.tw,
        mario.limonciello@amd.com, timvp@google.com,
        linus.walleij@linaro.org, hdegoede@redhat.com, rafael@kernel.org,
        Raul E Rangel <rrangel@chromium.org>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 04/13] Input: raydium_ts_i2c - Use PM subsystem to manage wake irq
Date:   Mon, 12 Sep 2022 16:13:08 -0600
Message-Id: <20220912160931.v2.4.I06b417b274bbecb31775a73993a7a3c1bc80de7b@changeid>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
In-Reply-To: <20220912221317.2775651-1-rrangel@chromium.org>
References: <20220912221317.2775651-1-rrangel@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
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
2.37.2.789.g6183377224-goog

