Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E6CD6B6A4F
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 19:42:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbjCLSmU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 14:42:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbjCLSmS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 14:42:18 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C1502D42;
        Sun, 12 Mar 2023 11:41:58 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id x22so1058446wmj.3;
        Sun, 12 Mar 2023 11:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678646513;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sPNMgVqTpUEhuVVUGea+g39Dl62GmKAwnFbl7GgjRp8=;
        b=adcr1AtJaW+BvWT+icAKTc/tHWmWdSkUWw63V9PkZvsp1et8CG2Ih84OYeKyKxz/z1
         vIuBbRhtSx1lrWyDGh8ygeFGzlM+T6L12RAfFVxbeUgEs2JOndLF377Q7/qaSYoxiQiY
         +Ksxd2lX7xzith13WNgPrYOCwZSOES1/h111Vu8KQp7JtlJimxwMf+V3aa9C8eTUC5NV
         GXdb8YAuMVU+e0LByRjYKcEshrcZ07rcblfdNmI/wXVQs42NxUEf31ioNCwST8ILphhP
         PyyOF03M9G7XcRWeqbEkRGu2PCUk7zUIdWrZZ2j7pvE1VHc7fpWgnr1eHvPcKX0FA4zg
         2yGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678646513;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sPNMgVqTpUEhuVVUGea+g39Dl62GmKAwnFbl7GgjRp8=;
        b=BVIl3DTL5u8bmhkigJJb7oxybImDhb4IBZU68t3qtOTSXIAIL764y6yODupIaF0QGe
         Y1iHlQhBvzvLSfWelFYyL+9i5YdInGv/12qItNgWOIT5YR3KHcPMYaGwvxUj0yV9r5JN
         TmscOW/7rNedQzq9ym25ie/tFqsjU08C3jK4IJnz3ZjG19uUJoxS66wBICLNllklVS1W
         Sb08mt3GUD06IfARPU/pIeUweQe8eh4+yWrFNaniWz2hOQDAN7Ar/VaXGtEbPmq7uX8n
         yoPcY810fyKFUAgthCUZVnAxQtI7zlWrF++A+/2C3tEXvHKR01vYY8qUsfu/poEOpOjN
         ujQA==
X-Gm-Message-State: AO0yUKVp/gL7Hf45UGsm9H051+wmzlDUJxncvQxD4q80WWry/rU3encp
        sL9z7GDn7HyJdDpUsaArAOY=
X-Google-Smtp-Source: AK7set9MrjRJ5PVCkbZDgVmZv0n6eXl8lq4OGVulyR4mW/ZU0l9q5lXpc8EF40WADuf5XRSgB/rXjg==
X-Received: by 2002:a7b:c050:0:b0:3e7:6a59:d9d3 with SMTP id u16-20020a7bc050000000b003e76a59d9d3mr8741551wmc.37.1678646513489;
        Sun, 12 Mar 2023 11:41:53 -0700 (PDT)
Received: from localhost.localdomain ([146.70.189.10])
        by smtp.gmail.com with ESMTPSA id w19-20020a05600c475300b003eb2e33f327sm8734443wmo.2.2023.03.12.11.41.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Mar 2023 11:41:52 -0700 (PDT)
From:   Jan Jasper de Kroon <jajadekroon@gmail.com>
To:     jajadekroon@gmail.com
Cc:     linux-input@vger.kernel.org, megi@xff.cz, hadess@hadess.net,
        hdegoede@redhat.com, dmitry.torokhov@gmail.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] input: touchscreen: goodix: Hold controller in reset during suspend
Date:   Sun, 12 Mar 2023 19:40:59 +0100
Message-Id: <20230312184058.552305-1-jajadekroon@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20230311131534.484700-1-jajadekroon@gmail.com>
References: <20230311131534.484700-1-jajadekroon@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Ondřej Jirman <megi@xff.cz>

The Goodix touchscreen controller used in PinePhone is not properly
suspended during system sleep, leading to high power consumption. This
commit modifies the driver to hold the controller in reset during
system sleep, reducing power consumption by around 40mW.

The original patch also disabled the regulators during system sleep, but
this could cause issues with other peripherals attached to the same power
supplies. Hence, this commit only holds the controller in reset during
system sleep and does not attempt to power it off.

Separate commit adds a new device tree property "hold-in-reset-in-suspend"
to control the hold-in-reset behavior of the controller during system
sleep.

Signed-off-by: Ondřej Jirman <megi@xff.cz>
Signed-off-by: Jan Jasper de Kroon <jajadekroon@gmail.com>
---
V1 -> V2: 
- Rewrote the commit message and function name to better reflect it's 
  behavior.
v2 -> V3: Some patch style cleaning up, to confirm to submission standard.

 drivers/input/touchscreen/goodix.c | 23 +++++++++++++++++++++++
 drivers/input/touchscreen/goodix.h |  1 +
 2 files changed, 24 insertions(+)

diff --git a/drivers/input/touchscreen/goodix.c b/drivers/input/touchscreen/goodix.c
index b348172f19c3..a35a203e04bf 100644
--- a/drivers/input/touchscreen/goodix.c
+++ b/drivers/input/touchscreen/goodix.c
@@ -1284,6 +1284,7 @@ static void goodix_disable_regulators(void *arg)
 
 static int goodix_ts_probe(struct i2c_client *client)
 {
+	struct device_node *np = client->dev.of_node;
 	struct goodix_ts_data *ts;
 	const char *cfg_name;
 	int error;
@@ -1303,6 +1304,7 @@ static int goodix_ts_probe(struct i2c_client *client)
 	i2c_set_clientdata(client, ts);
 	init_completion(&ts->firmware_loading_complete);
 	ts->contact_size = GOODIX_CONTACT_SIZE;
+	ts->hold_in_reset_in_suspend = of_property_read_bool(np, "hold-in-reset-in-suspend");
 
 	error = goodix_get_gpio_config(ts);
 	if (error)
@@ -1410,6 +1412,13 @@ static int goodix_suspend(struct device *dev)
 	if (ts->load_cfg_from_disk)
 		wait_for_completion(&ts->firmware_loading_complete);
 
+	if (ts->hold_in_reset_in_suspend) {
+		goodix_free_irq(ts);
+		goodix_irq_direction_output(ts, 0);
+		gpiod_direction_output(ts->gpiod_rst, 0);
+		return 0;
+	}
+
 	/* We need gpio pins to suspend/resume */
 	if (ts->irq_pin_access_method == IRQ_PIN_ACCESS_NONE) {
 		disable_irq(client->irq);
@@ -1455,6 +1464,20 @@ static int goodix_resume(struct device *dev)
 	u8 config_ver;
 	int error;
 
+	if (ts->hold_in_reset_in_suspend) {
+		error = goodix_reset(ts);
+		if (error) {
+			dev_err(dev, "Controller reset failed.\n");
+			return error;
+		}
+
+		error = goodix_request_irq(ts);
+		if (error)
+			return error;
+
+		return 0;
+	}
+
 	if (ts->irq_pin_access_method == IRQ_PIN_ACCESS_NONE) {
 		enable_irq(client->irq);
 		return 0;
diff --git a/drivers/input/touchscreen/goodix.h b/drivers/input/touchscreen/goodix.h
index 87797cc88b32..c515d03b742c 100644
--- a/drivers/input/touchscreen/goodix.h
+++ b/drivers/input/touchscreen/goodix.h
@@ -104,6 +104,7 @@ struct goodix_ts_data {
 	u8 main_clk[GOODIX_MAIN_CLK_LEN];
 	int bak_ref_len;
 	u8 *bak_ref;
+	bool hold_in_reset_in_suspend;
 };
 
 int goodix_i2c_read(struct i2c_client *client, u16 reg, u8 *buf, int len);
-- 
2.34.3

