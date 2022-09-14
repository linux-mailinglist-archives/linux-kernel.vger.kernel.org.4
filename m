Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5F945B913F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 01:58:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229480AbiINX6S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 19:58:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbiINX6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 19:58:09 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26FF38980E
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 16:58:08 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id i7so4663812ioa.5
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 16:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=tlb/jBBoBszWVk5wX7JgxKdayuraWLIogIZ7IhePa+U=;
        b=jjEy/jgKElInFwZkF0H4qzh1Q/dsUBj7KWr9+3FYwBTsMsk2yDGnQJjKAg/jULKS0O
         VfP9f78UxOUG1kr5qyCqi/ARy8WNzF1kqECKwodoaEpLJtCQ4txtDDv9a7aT2Zw0E/bJ
         m6xVm3MlXV++OLTNvp0uJ5Vnr6xJ3zZpbvbVg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=tlb/jBBoBszWVk5wX7JgxKdayuraWLIogIZ7IhePa+U=;
        b=wQuvjg1GqHi2PQZd7yXUbV5zLTD8EbWAryf0HXMbxwRMoMEJ8h0WxSp71yu2J6D3YO
         uKrK4SIP6T/+g5VDKikzxF1eYdFVhCm+YISmyFyUxkbrJhIKE3OcGpI/TToxGNiN8gkl
         pukmH1fChVjsqv9vvYuplPxYNKOTwnsMp/9xL3KeB7lL7q++OXphGD+HOK2V4XEFtV7m
         Mw+RhC3AyMeovQGleGxvm7kYiCdll+4KO5rtf/1CZo0vfG0tXut8K08N8rPSfpckjOYN
         GV7DCQY7yckZYMHKkmtV9ZxOFmmU6kp5nU7/qbg/OCd5+xu7DAcb/owMVgy0jHjJUViN
         Rnvw==
X-Gm-Message-State: ACgBeo1jN8L1OPnYv79iz5isspaHpUHnAuod6F5J6/oSYysLn13LPmhc
        hMLojG7ULNWl1PePKBJyoFmvww==
X-Google-Smtp-Source: AA6agR6gY3ZcUPrnEf8WQJxDLCEZo/qOuujp3KFniSoMv0/CGDI3Qj8ODnVpXeVxk4mLouo+iwScRQ==
X-Received: by 2002:a05:6638:22c5:b0:346:dc09:b0f5 with SMTP id j5-20020a05663822c500b00346dc09b0f5mr20279429jat.194.1663199887469;
        Wed, 14 Sep 2022 16:58:07 -0700 (PDT)
Received: from rrangel920.bld.corp.google.com (h24-56-189-219.arvdco.broadband.dynamic.tds.net. [24.56.189.219])
        by smtp.gmail.com with ESMTPSA id a14-20020a027a0e000000b0034c0e8829c0sm353721jac.0.2022.09.14.16.58.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 16:58:06 -0700 (PDT)
From:   Raul E Rangel <rrangel@chromium.org>
To:     linux-acpi@vger.kernel.org, linux-input@vger.kernel.org
Cc:     jingle.wu@emc.com.tw, rafael@kernel.org,
        andriy.shevchenko@linux.intel.com, mario.limonciello@amd.com,
        hdegoede@redhat.com, linus.walleij@linaro.org, timvp@google.com,
        dmitry.torokhov@gmail.com, Raul E Rangel <rrangel@chromium.org>,
        Alistair Francis <alistair@alistair23.me>,
        Angela Czubak <acz@semihalf.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jiri Kosina <jikos@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v3 01/13] HID: i2c-hid: Use PM subsystem to manage wake irq
Date:   Wed, 14 Sep 2022 17:57:49 -0600
Message-Id: <20220914155914.v3.1.Id4b4bdfe06e2caf2d5a3c9dd4a9b1080c38b539c@changeid>
X-Mailer: git-send-email 2.37.3.968.ga6b4b080e4-goog
In-Reply-To: <20220914235801.1731478-1-rrangel@chromium.org>
References: <20220914235801.1731478-1-rrangel@chromium.org>
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

The I2C hid driver is currently manually managing the wake
IRQ. This change removes the explicit enable_irq_wake/disable_irq_wake
and instead relies on the PM subsystem. This is done by calling
dev_pm_set_wake_irq.

i2c_device_probe already calls dev_pm_set_wake_irq when using device
tree, and i2c_device_remove also already calls dev_pm_clear_wake_irq.
There could be some device tree systems that have incorrectly declared
`wake` capabilities, so this change will set the wake irq if one is
missing. This matches the previous behavior.

I tested this on an ACPI system that has a HID touchscreen and verified
the IRQ was armed for wake on suspend.

Signed-off-by: Raul E Rangel <rrangel@chromium.org>
---

Changes in v3:
- Fixed typo in if condition

Changes in v2:
- Set the wake_irq when not configured by the i2c-core. This is
  different than v1, where the wake_irq was only set for non DT systems.

 drivers/hid/i2c-hid/i2c-hid-core.c | 33 +++++++++++-------------------
 1 file changed, 12 insertions(+), 21 deletions(-)

diff --git a/drivers/hid/i2c-hid/i2c-hid-core.c b/drivers/hid/i2c-hid/i2c-hid-core.c
index baa169fadd6632..a2fa40dec04ea5 100644
--- a/drivers/hid/i2c-hid/i2c-hid-core.c
+++ b/drivers/hid/i2c-hid/i2c-hid-core.c
@@ -26,6 +26,7 @@
 #include <linux/delay.h>
 #include <linux/slab.h>
 #include <linux/pm.h>
+#include <linux/pm_wakeirq.h>
 #include <linux/device.h>
 #include <linux/wait.h>
 #include <linux/err.h>
@@ -116,7 +117,6 @@ struct i2c_hid {
 
 	wait_queue_head_t	wait;		/* For waiting the interrupt */
 
-	bool			irq_wake_enabled;
 	struct mutex		reset_lock;
 
 	struct i2chid_ops	*ops;
@@ -1036,6 +1036,15 @@ int i2c_hid_core_probe(struct i2c_client *client, struct i2chid_ops *ops,
 	if (ret < 0)
 		goto err_powered;
 
+	/*
+	 * The wake IRQ should be declared via device tree instead of assuming
+	 * the IRQ can wake the system. This is here for legacy reasons and
+	 * will be removed once the i2c-core supports querying ACPI for wake
+	 * capabilities.
+	 */
+	if (!client->dev.power.wakeirq)
+		dev_pm_set_wake_irq(&client->dev, client->irq);
+
 	hid = hid_allocate_device();
 	if (IS_ERR(hid)) {
 		ret = PTR_ERR(hid);
@@ -1119,7 +1128,6 @@ static int i2c_hid_core_suspend(struct device *dev)
 	struct i2c_hid *ihid = i2c_get_clientdata(client);
 	struct hid_device *hid = ihid->hid;
 	int ret;
-	int wake_status;
 
 	ret = hid_driver_suspend(hid, PMSG_SUSPEND);
 	if (ret < 0)
@@ -1130,16 +1138,8 @@ static int i2c_hid_core_suspend(struct device *dev)
 
 	disable_irq(client->irq);
 
-	if (device_may_wakeup(&client->dev)) {
-		wake_status = enable_irq_wake(client->irq);
-		if (!wake_status)
-			ihid->irq_wake_enabled = true;
-		else
-			hid_warn(hid, "Failed to enable irq wake: %d\n",
-				wake_status);
-	} else {
+	if (!device_may_wakeup(&client->dev))
 		i2c_hid_core_power_down(ihid);
-	}
 
 	return 0;
 }
@@ -1150,18 +1150,9 @@ static int i2c_hid_core_resume(struct device *dev)
 	struct i2c_client *client = to_i2c_client(dev);
 	struct i2c_hid *ihid = i2c_get_clientdata(client);
 	struct hid_device *hid = ihid->hid;
-	int wake_status;
 
-	if (!device_may_wakeup(&client->dev)) {
+	if (!device_may_wakeup(&client->dev))
 		i2c_hid_core_power_up(ihid);
-	} else if (ihid->irq_wake_enabled) {
-		wake_status = disable_irq_wake(client->irq);
-		if (!wake_status)
-			ihid->irq_wake_enabled = false;
-		else
-			hid_warn(hid, "Failed to disable irq wake: %d\n",
-				wake_status);
-	}
 
 	enable_irq(client->irq);
 
-- 
2.37.3.968.ga6b4b080e4-goog

