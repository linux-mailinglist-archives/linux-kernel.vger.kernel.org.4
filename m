Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8E4E6EF6B1
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 16:44:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241484AbjDZOow (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 10:44:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241511AbjDZOor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 10:44:47 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5C237695
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 07:44:45 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-63b52ad6311so8505087b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 07:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1682520285; x=1685112285;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=unoMmmw4ERQhjIti7rAorCXdA4tzC1K8iFsMEZhavZ0=;
        b=XaZLVrt1MAcN0Beh1WTI5sVwkDsA+97s0BzKfnIKBZXqCwILv939LL07A9EKds4tZq
         8FCdjSIFw0HB45f41bM8shTO1Ui1nC9PjiOX/W1dXmAkhtzf3ayfCNRpOsPX6bFWLOEK
         A2WO/vb+Yy50KEqx2a6Hj18+F0UfUnYqAMzas=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682520285; x=1685112285;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=unoMmmw4ERQhjIti7rAorCXdA4tzC1K8iFsMEZhavZ0=;
        b=iGs4WdjMnZD9w/eBHFtq8Gz9gP7ADq3ZnGt76hVohjSEWre/rd55ULaAu+aF5JbNqA
         GHXDI7DRyQXAZdqL16YSC3t3xSVpn2Ify9iT0upmqmDu+VwmDb96GoUnmIFB3OawjKuq
         oaoRmDtdDlqCXo6jcJYtY679fL+YWQTxpnkkAzIrJBONaFEf4xBrd5Fjq7RPpsi4aF4a
         ueZxB/ocd7rGYS3ue1g9QLMqyk9IIBLKxKlhrpNLxW20yo7QRkk207yE/C1e/ncKkGak
         uhhyYFNAS/lRTBEC9ZvV3iwkLs3WlI7pSpNeurqFdBi5VzniX6zlNM0u+KR1wVB7M573
         j32A==
X-Gm-Message-State: AAQBX9e64B17R4p6eP/CH9Uyyt47VIkRzL1ryh8vhQT9SJeP6JaisFg5
        e5YYskTSNVopU5dOJ8z2ccVjGw==
X-Google-Smtp-Source: AKy350anOfPnTjWBVxV9V8oS46CcuV5wDlXlWJitrGClrfTDhJe52dFeq38OdC4o4ASuG2TpDuywjQ==
X-Received: by 2002:a05:6a00:1305:b0:63d:a0d:6fa1 with SMTP id j5-20020a056a00130500b0063d0a0d6fa1mr24917705pfu.21.1682520285002;
        Wed, 26 Apr 2023 07:44:45 -0700 (PDT)
Received: from fshao-glinux.tpe.corp.google.com ([2401:fa00:1:10:dcf6:797f:140d:6d])
        by smtp.gmail.com with ESMTPSA id f17-20020a631011000000b00502f20aa4desm8750495pgl.70.2023.04.26.07.44.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Apr 2023 07:44:44 -0700 (PDT)
From:   Fei Shao <fshao@chromium.org>
To:     Jeff LaBundy <jeff@labundy.com>,
        Douglas Anderson <dianders@chromium.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-mediatek <linux-mediatek@lists.infradead.org>,
        Fei Shao <fshao@chromium.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jiri Kosina <jikos@kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Stephen Kitt <steve@sk2.org>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] HID: i2c-hid: goodix: Add support for "goodix,no-reset-during-suspend" property
Date:   Wed, 26 Apr 2023 22:44:22 +0800
Message-ID: <20230426144423.2820826-3-fshao@chromium.org>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
In-Reply-To: <20230426144423.2820826-1-fshao@chromium.org>
References: <20230426144423.2820826-1-fshao@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

To address both cases, this patch adds the support for the new
"goodix,no-reset-during-suspend" property in the driver:
- When set to true, the driver does not assert the reset GPIO during
  power-down.
  Instead, the GPIO will be asserted during power-up to ensure the
  touchscreen always has a clean start and consistent behavior after
  resuming.
  This is for designs with a dedicated always-on regulator.
- When set to false or unset, the driver uses the original control flow
  and asserts GPIO and disables regulators normally.
  This is for the two-regulator and shared-regulator designs.

Signed-off-by: Fei Shao <fshao@chromium.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>

---

Changes in v3:
- In power-down, only skip the GPIO but not the regulator calls if the
  flag is set

Changes in v2:
- Do not change the regulator_enable logic during power-up.

 drivers/hid/i2c-hid/i2c-hid-of-goodix.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/i2c-hid/i2c-hid-of-goodix.c b/drivers/hid/i2c-hid/i2c-hid-of-goodix.c
index 0060e3dcd775..3ed365b50432 100644
--- a/drivers/hid/i2c-hid/i2c-hid-of-goodix.c
+++ b/drivers/hid/i2c-hid/i2c-hid-of-goodix.c
@@ -28,6 +28,7 @@ struct i2c_hid_of_goodix {
 	struct regulator *vdd;
 	struct regulator *vddio;
 	struct gpio_desc *reset_gpio;
+	bool no_reset_during_suspend;
 	const struct goodix_i2c_hid_timing_data *timings;
 };
 
@@ -37,6 +38,14 @@ static int goodix_i2c_hid_power_up(struct i2chid_ops *ops)
 		container_of(ops, struct i2c_hid_of_goodix, ops);
 	int ret;
 
+	if (ihid_goodix->no_reset_during_suspend) {
+		/*
+		 * We assert reset GPIO here (instead of during power-down) to
+		 * ensure the device will have a clean state after powering up,
+		 * just like the normal scenarios will have.
+		 */
+		gpiod_set_value_cansleep(ihid_goodix->reset_gpio, 1);
+	}
 	ret = regulator_enable(ihid_goodix->vdd);
 	if (ret)
 		return ret;
@@ -60,7 +69,9 @@ static void goodix_i2c_hid_power_down(struct i2chid_ops *ops)
 	struct i2c_hid_of_goodix *ihid_goodix =
 		container_of(ops, struct i2c_hid_of_goodix, ops);
 
-	gpiod_set_value_cansleep(ihid_goodix->reset_gpio, 1);
+	if (!ihid_goodix->no_reset_during_suspend)
+		gpiod_set_value_cansleep(ihid_goodix->reset_gpio, 1);
+
 	regulator_disable(ihid_goodix->vddio);
 	regulator_disable(ihid_goodix->vdd);
 }
@@ -91,6 +102,9 @@ static int i2c_hid_of_goodix_probe(struct i2c_client *client)
 	if (IS_ERR(ihid_goodix->vddio))
 		return PTR_ERR(ihid_goodix->vddio);
 
+	ihid_goodix->no_reset_during_suspend =
+		of_property_read_bool(client->dev.of_node, "goodix,no-reset-during-suspend");
+
 	ihid_goodix->timings = device_get_match_data(&client->dev);
 
 	return i2c_hid_core_probe(client, &ihid_goodix->ops, 0x0001, 0);
-- 
2.40.1.495.gc816e09b53d-goog

