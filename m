Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF8A86C2432
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 23:04:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbjCTWEN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 18:04:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbjCTWEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 18:04:06 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30E7C46A1;
        Mon, 20 Mar 2023 15:04:04 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id w11so7404729wmo.2;
        Mon, 20 Mar 2023 15:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679349842;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6B/G/Avv34zlBUdW5xblvGC436YdVz0pbsXhfWqrqU8=;
        b=R7rSSr2FRoVkJHqqUVUC7gqjXpOI3vhWu03zsM8/4mhFwQvJCoTuNzcoqujnqHX1b7
         oYuX3TmfE1ZY/6ZcRGbPa63/jfsgrYs6AJz0fJKy36rY/bbrTxUU8of/ijlfvRrIPsyW
         +AgUZHEXSNpDevHU8tYcYauyPu3r/ef2Bjau/D2BeS3HD9QvHqt90BZxn1kT6tOOH4R1
         GwUTOtg6K6zWyWDiuBZ1qYIl6TILByC/fx/i9+VuJD5IMPCx/hyv5ko7MmGeYWkDI28T
         Zpd/TuGyotf6S65hhBHoHFRAHf4QS7DUaDDqZ8EIoKdfqaIIgF1b8n1rmynHHusNhJGb
         a5UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679349842;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6B/G/Avv34zlBUdW5xblvGC436YdVz0pbsXhfWqrqU8=;
        b=lsGsnYUvRGkJqVtp9xka6CiHdEX2Bk6z6P4SvhjJNbgO/TBuBG8gKCROrs0QDtJZeX
         00V4wB/ZC3RdIazV9gkYlm30DDtcDVL1+X+S7DBNeryax1FojdGAv1NOmHq2yCgwQWO6
         rdUUBJZSKxiX4pkDYk/pSx6cP5Q7PuBfW2gwwMvk4K1kUU72b9T6ctVyb1FG1yP7cOPe
         O3okgzg5rxuy/+YKkS/06oGvBTzJaDdOSTBTBPHE7YRhUvYvkWOqNgK98FZYDDa2lYLZ
         fnXPUKzp7kzgvFwmDSndogm3puQiPjry5fGomqwDl2k6JzOPVe2rAdowQ5zDn1r3l+TS
         CTTA==
X-Gm-Message-State: AO0yUKVFKeflOQUHryz8CBkua3g5/opxsvWaa4510Xltib3dNnvPsQI5
        j9kpKS/4+uGPuubwfBw8OXo=
X-Google-Smtp-Source: AK7set9F28VitLawp5ROjm4DDQ9bWgz5jpu+qXB8gL8+1WwYNxxJPpgQjH6na2EKKQhcywed5Dwnnw==
X-Received: by 2002:a1c:4c1a:0:b0:3ed:95a5:3257 with SMTP id z26-20020a1c4c1a000000b003ed95a53257mr800158wmf.2.1679349842541;
        Mon, 20 Mar 2023 15:04:02 -0700 (PDT)
Received: from PCBABN.skidata.net ([91.230.2.244])
        by smtp.gmail.com with ESMTPSA id bg5-20020a05600c3c8500b003e7f1086660sm17868386wmb.15.2023.03.20.15.04.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 15:04:02 -0700 (PDT)
From:   Benjamin Bara <bbara93@gmail.com>
To:     lee@kernel.org
Cc:     dmitry.osipenko@collabora.com, jonathanh@nvidia.com,
        treding@nvidia.com, richard.leitner@linux.dev,
        benjamin.bara@skidata.com, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] mfd: tps6586x: register restart handler
Date:   Mon, 20 Mar 2023 23:03:45 +0100
Message-Id: <20230320220345.1463687-3-bbara93@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230320220345.1463687-1-bbara93@gmail.com>
References: <20230320220345.1463687-1-bbara93@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Benjamin Bara <benjamin.bara@skidata.com>

The TPS658629-Q1 (unfortunately the only TPS6586x with public data sheet)
provides a SOFT RST bit in the SUPPLYENE reg to request a (cold) reboot.

Use it to implement and register a restart handler.

Tested on a TPS658640.

Signed-off-by: Benjamin Bara <benjamin.bara@skidata.com>
---
 drivers/mfd/tps6586x.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/mfd/tps6586x.c b/drivers/mfd/tps6586x.c
index 4869155437cb..b46917231847 100644
--- a/drivers/mfd/tps6586x.c
+++ b/drivers/mfd/tps6586x.c
@@ -15,6 +15,7 @@
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/irqdomain.h>
+#include <linux/irqflags.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
@@ -30,6 +31,7 @@
 #include <linux/mfd/tps6586x.h>
 
 #define TPS6586X_SUPPLYENE	0x14
+#define SOFT_RST_BIT		BIT(0)
 #define EXITSLREQ_BIT		BIT(1)
 #define SLEEP_MODE_BIT		BIT(3)
 
@@ -470,6 +472,20 @@ static int tps6586x_power_off_handler(struct sys_off_data *data)
 	return tps6586x_set_bits(tps6586x_dev, TPS6586X_SUPPLYENE, SLEEP_MODE_BIT);
 }
 
+static int tps6586x_restart_handler(struct sys_off_data *data)
+{
+	unsigned long flags;
+	struct device *tps6586x_dev = (struct device *)data->cb_data;
+
+	/* bring pmic into HARD REBOOT state, enforce atomic i2c xfer */
+	local_irq_save(flags);
+	tps6586x_set_bits(tps6586x_dev, TPS6586X_SUPPLYENE, SOFT_RST_BIT);
+	local_irq_restore(flags);
+
+	mdelay(500);
+	return 0;
+}
+
 static void tps6586x_print_version(struct i2c_client *client, int version)
 {
 	const char *name;
@@ -570,6 +586,13 @@ static int tps6586x_i2c_probe(struct i2c_client *client)
 			dev_err(&client->dev, "register power off handler failed: %d\n", ret);
 			goto err_add_devs;
 		}
+
+		ret = devm_register_restart_handler(&client->dev, &tps6586x_restart_handler,
+						    &client->dev);
+		if (ret) {
+			dev_err(&client->dev, "register restart handler failed: %d\n", ret);
+			goto err_add_devs;
+		}
 	}
 
 	return 0;
-- 
2.34.1

