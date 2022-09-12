Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 488DD5B635A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 00:14:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbiILWOL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 18:14:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230199AbiILWNx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 18:13:53 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5700A4E610
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 15:13:50 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id k13so3605241ilc.11
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 15:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=NUJ2mFRmNNirGf1kAydkfNUjnODGrxL6a/2ExPoV0ms=;
        b=LNBn05wWgYfFwxGwQwXNH8ynal6Isc9H+msuIscES50SvMjd2kAj5QAR/Atolntl35
         edmZouMdhKrcTh+L74Pevwlc3TZvmi5zTnjiqSO2sD9RcO+9qX5JnMHErPFhOOtW1WM6
         7Dc0r7lgKCA1w7WpNYvlxkzmN/xv6Y/laiHAs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=NUJ2mFRmNNirGf1kAydkfNUjnODGrxL6a/2ExPoV0ms=;
        b=RQ8vfcgawpAKllMlFBod19JCwt+kPOccYm+e7ZQnPH9besIKiYmYZ9pstSzwFKJR9o
         Z/JfAEh62gIFnPTrqw8xdQzeHlxxJ2hVWncnyzBhWnPpxnFwsb2a43YIr1BawhWhYq1d
         d4MsyAYf7HRiusCXzv+pfm+CSa2bvBn+0CG3ladsJMmeRf/4fr6R9lI4RVT2y4fKe9zg
         rqy6NhiHCYHPl/80GkNWyjTIzgWWtlwJTr3g5ExPQFRX5EgCr/2SUhh2LY14HfIghDcF
         uFc5h5vdrNnxWGt8KRcF79VFclpMMJTpfc/inq63JWuTK4nq08OZTsGo0cgvZEFrhf4d
         1gFw==
X-Gm-Message-State: ACgBeo2hUtNoLO+VwgbpfTZnI7D6S+NcMtuv/FepMpL1uOnGjJ0RgjEi
        UEeo5QA12LFlC31LZ41ToGiOLQ==
X-Google-Smtp-Source: AA6agR66XtwxoNStOvOaWE0VbjfN/JAn/jWgrTF7HYmUdQ1Y2IPqOQINV19sYqA0BnuiiexIx21G7Q==
X-Received: by 2002:a05:6e02:1886:b0:2eb:438a:c64c with SMTP id o6-20020a056e02188600b002eb438ac64cmr11251879ilu.282.1663020829532;
        Mon, 12 Sep 2022 15:13:49 -0700 (PDT)
Received: from rrangel920.bld.corp.google.com (h24-56-189-219.arvdco.broadband.dynamic.tds.net. [24.56.189.219])
        by smtp.gmail.com with ESMTPSA id 18-20020a056e020cb200b002f16e7021f6sm4077334ilg.22.2022.09.12.15.13.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Sep 2022 15:13:48 -0700 (PDT)
From:   Raul E Rangel <rrangel@chromium.org>
To:     linux-acpi@vger.kernel.org, linux-input@vger.kernel.org
Cc:     andriy.shevchenko@linux.intel.com, jingle.wu@emc.com.tw,
        mario.limonciello@amd.com, timvp@google.com,
        linus.walleij@linaro.org, hdegoede@redhat.com, rafael@kernel.org,
        Raul E Rangel <rrangel@chromium.org>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Guenter Roeck <groeck@chromium.org>,
        Johnny Chuang <johnny.chuang.emc@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 03/13] Input: elants_i2c - Use PM subsystem to manage wake irq
Date:   Mon, 12 Sep 2022 16:13:07 -0600
Message-Id: <20220912160931.v2.3.I5862429ee3e4de0f9ad5ba01ce07ad99eec10cf0@changeid>
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

Changes in v2:
- Added elants_i2c to series

 drivers/input/touchscreen/elants_i2c.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/input/touchscreen/elants_i2c.c b/drivers/input/touchscreen/elants_i2c.c
index a56f042adf9d82..80e16b533c452a 100644
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
2.37.2.789.g6183377224-goog

