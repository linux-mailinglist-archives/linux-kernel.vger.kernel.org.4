Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83F156E64AC
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 14:51:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232177AbjDRMv1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 08:51:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232179AbjDRMvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 08:51:19 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8393F16B30
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 05:50:55 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-63b4bf2d74aso1729221b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 05:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1681822255; x=1684414255;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Papc1sXd+qDh/1CZbyPf6tKXYxl99aL3JhfvjUH30aw=;
        b=W02vLdWJ3jV+eysJyBXOZkWpyU4OWVzVbN+pnYkJKHPtCh7O/8OzBlIMsLxX7PW6nI
         KCygHot6i9LcL4jrs0P04ul3KuPW4e9NzqPVzfenoRhX1c7dk2vGAvizQThTCS+fw7iT
         D9ZueUY62fFwpHtiVBQDwWXcMGdo7jK3LrapI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681822255; x=1684414255;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Papc1sXd+qDh/1CZbyPf6tKXYxl99aL3JhfvjUH30aw=;
        b=ik3j1C9qd38juQx8gBLMhqkqqWvI2xRy3WUYgkuMLcUEj3x6IdBJYyNf4ap/n/4EeC
         szTKIavTu/DAwk5Wy9vYq4S9VxUfpsmJooSrfk8vmFGbtQSmxG5dWVB4xzmdSWqqMXJx
         di6QtAzc1aFSEPwpc20pLdoRKWlA09jsHRjMU2/oxutdZg9j07QrdWIivj4pDSdYEVgB
         JTEG49vzQY1SvhAXgA7Ok01aadV4fcNTKs9wX5UBsyGx/uNv09SW0wOiGMXoyQVPdODV
         Ss+1rbkx62diS5x1PGc8D8Uusl5ufO+lOID4dUwwz28lQkQNRB0GaC6GrrBzljCdd8nP
         YGUA==
X-Gm-Message-State: AAQBX9cFZmgVR/xwKH8BP+Nv1PLL0fDnfGRstMCLU+svpAEb5oXvZDNX
        E2urqVDkulT9t5cOxIfoxTBJWg==
X-Google-Smtp-Source: AKy350YSKwMcKwM7NQ08Mn+FjbYkwflE/RoqWCwGyKQZXouI16JZM1yOzG8VWacpqa+y30fpbCbEWg==
X-Received: by 2002:a05:6a00:99e:b0:63b:3e:cbee with SMTP id u30-20020a056a00099e00b0063b003ecbeemr27392282pfg.32.1681822254999;
        Tue, 18 Apr 2023 05:50:54 -0700 (PDT)
Received: from fshao-glinux.tpe.corp.google.com ([2401:fa00:1:10:2fb7:301d:6083:752b])
        by smtp.gmail.com with ESMTPSA id v11-20020a62a50b000000b0063afb08afeesm9323733pfm.67.2023.04.18.05.50.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 05:50:54 -0700 (PDT)
From:   Fei Shao <fshao@chromium.org>
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Douglas Anderson <dianders@chromium.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-mediatek <linux-mediatek@lists.infradead.org>,
        Fei Shao <fshao@chromium.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jiri Kosina <jikos@kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Stephen Kitt <steve@sk2.org>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] HID: i2c-hid: goodix: Add support for powered-in-suspend property
Date:   Tue, 18 Apr 2023 20:49:52 +0800
Message-ID: <20230418124953.3170028-3-fshao@chromium.org>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
In-Reply-To: <20230418124953.3170028-1-fshao@chromium.org>
References: <20230418124953.3170028-1-fshao@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the beginning, commit 18eeef46d359 ("HID: i2c-hid: goodix: Tie the
reset line to true state of the regulator") introduced a change to tie
the reset line of the Goodix touchscreen to the state of the regulator
to fix a power leakage issue in suspend.

After some time, the change was deemed unnecessary and was reverted in
commit 557e05fa9fdd ("HID: i2c-hid: goodix: Stop tying the reset line to
the regulator") due to difficulties in managing regulator notifiers for
designs like Evoker, which provides a second power rail to touchscreen.

However, the revert caused a power regression on another Chromebook
device Steelix in the field, which has a dedicated always-on regulator
for touchscreen and was covered by the workaround in the first commit.

To address both cases, this patch adds the support for the
`powered-in-suspend` property in the driver that allows the driver to
determine whether the touchscreen is still powered in suspend, and
handle the reset GPIO accordingly as below:
- When set to true, the driver does not assert the reset GPIO in power
  down. To ensure a clean start and the consistent behavior, it does the
  assertion in power up instead.
  This is for designs with a dedicated always-on regulator.
- When set to false, the driver uses the original control flow and
  asserts GPIO and disable regulators normally.
  This is for the two-regulator and shared-regulator designs.

Signed-off-by: Fei Shao <fshao@chromium.org>

---

 drivers/hid/i2c-hid/i2c-hid-of-goodix.c | 46 +++++++++++++++++++++----
 1 file changed, 39 insertions(+), 7 deletions(-)

diff --git a/drivers/hid/i2c-hid/i2c-hid-of-goodix.c b/drivers/hid/i2c-hid/i2c-hid-of-goodix.c
index 0060e3dcd775..b438db8ca6f4 100644
--- a/drivers/hid/i2c-hid/i2c-hid-of-goodix.c
+++ b/drivers/hid/i2c-hid/i2c-hid-of-goodix.c
@@ -28,6 +28,7 @@ struct i2c_hid_of_goodix {
 	struct regulator *vdd;
 	struct regulator *vddio;
 	struct gpio_desc *reset_gpio;
+	bool powered_in_suspend;
 	const struct goodix_i2c_hid_timing_data *timings;
 };
 
@@ -37,13 +38,34 @@ static int goodix_i2c_hid_power_up(struct i2chid_ops *ops)
 		container_of(ops, struct i2c_hid_of_goodix, ops);
 	int ret;
 
-	ret = regulator_enable(ihid_goodix->vdd);
-	if (ret)
-		return ret;
-
-	ret = regulator_enable(ihid_goodix->vddio);
-	if (ret)
-		return ret;
+	/*
+	 * This is to ensure that the reset GPIO will be asserted and the
+	 * regulators will be enabled for all cases.
+	 */
+	if (ihid_goodix->powered_in_suspend) {
+		/*
+		 * This is not mandatory, but we assert reset here (instead of
+		 * in power-down) to ensure that the device will have a clean
+		 * state later on just like the normal scenarios would have.
+		 *
+		 * Also, since the regulators were not disabled in power-down,
+		 * we don't need to enable them here.
+		 */
+		gpiod_set_value_cansleep(ihid_goodix->reset_gpio, 1);
+	} else {
+		/*
+		 * In this case, the reset is already asserted (either in
+		 * probe or power-down).
+		 * All we need is to enable the regulators.
+		 */
+		ret = regulator_enable(ihid_goodix->vdd);
+		if (ret)
+			return ret;
+
+		ret = regulator_enable(ihid_goodix->vddio);
+		if (ret)
+			return ret;
+	}
 
 	if (ihid_goodix->timings->post_power_delay_ms)
 		msleep(ihid_goodix->timings->post_power_delay_ms);
@@ -60,6 +82,13 @@ static void goodix_i2c_hid_power_down(struct i2chid_ops *ops)
 	struct i2c_hid_of_goodix *ihid_goodix =
 		container_of(ops, struct i2c_hid_of_goodix, ops);
 
+	/*
+	 * Don't assert reset GPIO or disable regulators if we're keeping the
+	 * device powered in suspend.
+	 */
+	if (ihid_goodix->powered_in_suspend)
+		return;
+
 	gpiod_set_value_cansleep(ihid_goodix->reset_gpio, 1);
 	regulator_disable(ihid_goodix->vddio);
 	regulator_disable(ihid_goodix->vdd);
@@ -91,6 +120,9 @@ static int i2c_hid_of_goodix_probe(struct i2c_client *client)
 	if (IS_ERR(ihid_goodix->vddio))
 		return PTR_ERR(ihid_goodix->vddio);
 
+	ihid_goodix->powered_in_suspend =
+		of_property_read_bool(client->dev.of_node, "powered-in-suspend");
+
 	ihid_goodix->timings = device_get_match_data(&client->dev);
 
 	return i2c_hid_core_probe(client, &ihid_goodix->ops, 0x0001, 0);
-- 
2.40.0.634.g4ca3ef3211-goog

