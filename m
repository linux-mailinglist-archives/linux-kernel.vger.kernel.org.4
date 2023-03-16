Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A68506BD35F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 16:23:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbjCPPXu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 11:23:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbjCPPXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 11:23:47 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86C63BD4EE;
        Thu, 16 Mar 2023 08:23:22 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id cy23so9020922edb.12;
        Thu, 16 Mar 2023 08:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678980201;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PrzoMD4CuQsD1GnaeduBqm/59VH2CvP6iZ8kpO4L4zo=;
        b=XrCXgJktL34IIt3GcnrDHQHCthbcX8YMQKdGHU2WcL0y+Bu/PhLujdea7yl8QF/lqq
         8POJ8BJNXHxkXbBmynbKTiksORbOSHKL246ItZuT4agOTc6Me2DGhFaX4/gIlJg/LTjf
         uZDsJVRAERjYQUlkf8vv4H8V/eUKlPYl5FLkNYxg9Pe/tE3qOET+4M/BsArcMrOsFsNX
         tOXjTwcEy3ZMFhGg5eW6OyA9RjcvVVpdFXKVcMvngPLg+DuDGK+pOLl+27DuQn/hzfVH
         XpWcNwEfmGAgNHAjuQd/dhtyM8Sdafq421zsktFiHvgiNxgpQs2DJ40lUiC0pUjQunEz
         aRiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678980201;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PrzoMD4CuQsD1GnaeduBqm/59VH2CvP6iZ8kpO4L4zo=;
        b=cj+KtQw6gjS2SghllZKc/mm+zua3+rb1wjrZDj8iQYqQDkxerhnyFuy3M4206ZPCFw
         HlC33POSRIJ0V7ffoiDPPR1yWS576Az65UzsAuy+uEfrcX93GFLh/cA2pZg7KQiCgMPt
         J8ljpIVMjXKHxoCuhRkhx1aSLQdGcES7ssN70n65+2JIYdLHtxFLbSRCHOQkNhzhWv9U
         7r5Wr/WJo/OZzBN23w5zRenlaccQMQwfcWqd2sIr6rlFK3pT1hkgVarzg549fdKQuXYx
         giC4cT9frZ6mCai44pZgZprjky6Pe+9rNssjp45sC+NoE3UFBeDBplKI75CAWF37axZU
         W5Rg==
X-Gm-Message-State: AO0yUKVP+b/iKYqsDWe6zxMjJrThJrOfRUnMQBy+AjxDgYJ4ZzEPC2Kx
        Kpkovtcqy1mtwRFr53XtqLc=
X-Google-Smtp-Source: AK7set8lt7URSpbX+pGpgLmU3TWep7/xdKn7mfbpM5H0xYj/ihzze1dQOcospGw7olsuqcv7qa9ZbQ==
X-Received: by 2002:a17:906:6816:b0:930:1914:88fe with SMTP id k22-20020a170906681600b00930191488femr3553311ejr.68.1678980200899;
        Thu, 16 Mar 2023 08:23:20 -0700 (PDT)
Received: from localhost.localdomain (84-84-8-249.fixed.kpn.net. [84.84.8.249])
        by smtp.gmail.com with ESMTPSA id vg8-20020a170907d30800b008c76facbbf7sm3981006ejc.171.2023.03.16.08.22.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 08:23:00 -0700 (PDT)
From:   Jan Jasper de Kroon <jajadekroon@gmail.com>
To:     jajadekroon@gmail.com
Cc:     dmitry.torokhov@gmail.com, hadess@hadess.net, hdegoede@redhat.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        megi@xff.cz
Subject: [PATCH v4 2/2] input: touchscreen: goodix: Hold controller in reset during suspend
Date:   Thu, 16 Mar 2023 16:22:00 +0100
Message-Id: <20230316152159.66922-1-jajadekroon@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20230310170026.415739-1-jajadekroon@gmail.com>
References: <20230310170026.415739-1-jajadekroon@gmail.com>
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

A separate commit adds a new device tree property "goodix-hold-in-reset"
to control the hold-in-reset behavior of the controller during system sleep.

Signed-off-by: Ondrej Jirman <megi@xff.cz>
Signed-off-by: Jan Jasper de Kroon <jajadekroon@gmail.com>
---
Changes from v3 to v4:
- Renamed the hold-in-reset-in-suspend function to 
  goodix-hold-in-reset to prevent potential naming conflicts with other 
  functions in the codebase. No functional changes were made.

Changes from v2 to v3:
- Some patch style cleaning up, to confirm to submission standard.

Changes from v1 to v2:
- Rewrote the commit message and function name to better reflect it's 
  behavior.
 drivers/input/touchscreen/goodix.c | 23 +++++++++++++++++++++++
 drivers/input/touchscreen/goodix.h |  1 +
 2 files changed, 24 insertions(+)

diff --git a/drivers/input/touchscreen/goodix.c b/drivers/input/touchscreen/goodix.c
index b348172f19c3..9f86bdfbfc73 100644
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
+	ts->goodix_hold_in_reset = of_property_read_bool(np, "goodix-hold-in-reset");
 
 	error = goodix_get_gpio_config(ts);
 	if (error)
@@ -1410,6 +1412,13 @@ static int goodix_suspend(struct device *dev)
 	if (ts->load_cfg_from_disk)
 		wait_for_completion(&ts->firmware_loading_complete);
 
+	if (ts->goodix_hold_in_reset) {
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
 
+	if (ts->goodix_hold_in_reset) {
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
index 87797cc88b32..7be7eb1a8f27 100644
--- a/drivers/input/touchscreen/goodix.h
+++ b/drivers/input/touchscreen/goodix.h
@@ -104,6 +104,7 @@ struct goodix_ts_data {
 	u8 main_clk[GOODIX_MAIN_CLK_LEN];
 	int bak_ref_len;
 	u8 *bak_ref;
+	bool goodix_hold_in_reset;
 };
 
 int goodix_i2c_read(struct i2c_client *client, u16 reg, u8 *buf, int len);
-- 
2.34.3

