Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E46965B6362
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 00:14:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbiILWN5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 18:13:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230173AbiILWNr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 18:13:47 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98B754DF18
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 15:13:46 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id n81so7712125iod.6
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 15:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=mFrbzNQLKG8CXPO79w4AjsVZ8usX9qVrnGw8EpWynk8=;
        b=AOmtMoMUs2aYSo+sMzMa9oWTCCfyDC/ZsgWoMyX+TlQsyBmE02zMN1svsLv36u+Ycb
         KEnHe3z4WozzzUEo4wHPoZPJMn/81Mq6Ho/aRgM/8RK7Muhhhhp8c5OnhGuIkoab/LbZ
         zZaAC0BFDEFGvm1425bppIiy4tnDq8qAOwOxc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=mFrbzNQLKG8CXPO79w4AjsVZ8usX9qVrnGw8EpWynk8=;
        b=E2AtfCTne0YAbkua2PRWAkab53TW6lORfUJe6VjtHyRFh2HOR/nx3+u5IcY8o7i0j7
         OeWh4SdNRWtTddTMQ73jcoEZ8YnmH9aVmEqFS4/JjZrnO9tv0DzQRA3+dk97FCA3WBI1
         vA+u2wM47dKq5lKMGkUDISCNc5/1TMkGErCRoRFeh8MEJ/VNzLZaXCz6wW1wUmZbFHLA
         a/mvTHdfUCW75sqbgtS4R8iVl37FEyu6Ep1KSXm60qauNI2x15eXpSfWqKkrAeU2Df/Q
         tsAgy3ug5S5NKNmUeE65UI24B76VrtoyV4EEfh9JfZlNo3SWjhq4aDREpCs2zEZWWv9O
         N+Zg==
X-Gm-Message-State: ACgBeo3gNsr4RowsRG6N+uiqEI0RAC38BJIjoIaggz9clZrMU7hFGTOh
        09MPO64WXFYA8zmqLwUA3C1jUw==
X-Google-Smtp-Source: AA6agR7+xi+3eILnnUT6w5qcA3dGXcT9+pSxvcvfZhe3NJWIwgstMUo9fQiq4by9kDHLsr8FGAQfAw==
X-Received: by 2002:a05:6638:d48:b0:351:497c:89a9 with SMTP id d8-20020a0566380d4800b00351497c89a9mr15514132jak.278.1663020825828;
        Mon, 12 Sep 2022 15:13:45 -0700 (PDT)
Received: from rrangel920.bld.corp.google.com (h24-56-189-219.arvdco.broadband.dynamic.tds.net. [24.56.189.219])
        by smtp.gmail.com with ESMTPSA id 18-20020a056e020cb200b002f16e7021f6sm4077334ilg.22.2022.09.12.15.13.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Sep 2022 15:13:45 -0700 (PDT)
From:   Raul E Rangel <rrangel@chromium.org>
To:     linux-acpi@vger.kernel.org, linux-input@vger.kernel.org
Cc:     andriy.shevchenko@linux.intel.com, jingle.wu@emc.com.tw,
        mario.limonciello@amd.com, timvp@google.com,
        linus.walleij@linaro.org, hdegoede@redhat.com, rafael@kernel.org,
        Raul E Rangel <rrangel@chromium.org>,
        Alistair Francis <alistair@alistair23.me>,
        Angela Czubak <acz@semihalf.com>,
        Bartosz Szczepanek <bsz@semihalf.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jiri Kosina <jikos@kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 01/13] HID: i2c-hid: Use PM subsystem to manage wake irq
Date:   Mon, 12 Sep 2022 16:13:05 -0600
Message-Id: <20220912160931.v2.1.Id4b4bdfe06e2caf2d5a3c9dd4a9b1080c38b539c@changeid>
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

Changes in v2:
- Set the wake_irq when not configured by the i2c-core. This is
  different than v1, where the wake_irq was only set for non DT systems.

 drivers/hid/i2c-hid/i2c-hid-core.c | 33 +++++++++++-------------------
 1 file changed, 12 insertions(+), 21 deletions(-)

diff --git a/drivers/hid/i2c-hid/i2c-hid-core.c b/drivers/hid/i2c-hid/i2c-hid-core.c
index baa169fadd6632..57214549460043 100644
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
+	if (!dev->power.wakeirq)
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
2.37.2.789.g6183377224-goog

