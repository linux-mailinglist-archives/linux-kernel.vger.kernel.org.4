Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7E9A70EC06
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 05:45:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239364AbjEXDp1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 23:45:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239328AbjEXDpT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 23:45:19 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CEFEE8
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 20:45:18 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-64d18d772bdso382814b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 20:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684899918; x=1687491918;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mNAx86DC0MbJEeALPDvpUMasnonSntghXNH2OAhpxaM=;
        b=RtKZkyqNLvMx8iPH0pj6iwQFHl015JFQI3TE7qXpfm0+J4nWvloy56LofH+EoS3TP2
         fuYdgY9vVgXAPiA8ntzrE1ufVBOG0ah5OwOtuOCqhH0AtxXf3w5Yz392c0cbAW36prlX
         WbrIOn4nLiGngXLu6jH8FLXbTnqeNNfKojIBI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684899918; x=1687491918;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mNAx86DC0MbJEeALPDvpUMasnonSntghXNH2OAhpxaM=;
        b=ZGndFXA4avd5AuEvtN8uFj7DjnYGWjDQxe8DPOjlezPzi912uygOFcG00u52O7m7c9
         hgBViip7mSigiiQfoNp+T0inN9hSQex/Gb0/pNod81dmypYw6Xmht3wr0T99m4iaeFg9
         lrl5bADct1GAyF9RJIraAB4h6Cj/1+0LMPFhVuLzp2dq4qSQUy0b6owfYDa0wpTPlW5C
         VLQj3xXbgI2xD+/ufmKQErqNJeP8NzGSLY7dGWNG9+h86zVG1FJHHdFL2IKagUDdEqrx
         +FPwubKxVHU6UVT122IThmQHUdtgmwqTdtRR2l8mgOd9TDqNUmfVGvHyGybKhG14J11v
         vQhA==
X-Gm-Message-State: AC+VfDxzyw4VU+JN0Cg3TckhYe7xylGwIyemV/FtLzz6q+70j95YmwEK
        ctSbsgsRHAFl3imyvYJLRx3DBg==
X-Google-Smtp-Source: ACHHUZ7lrSSe5gvwtJikgn0Nq+usQfhiJN+qC1SEtW5cx202V0e0ayVFLx1Fi16bLXeQ8mZlyAGxhQ==
X-Received: by 2002:a05:6a00:2488:b0:643:980:65b with SMTP id c8-20020a056a00248800b006430980065bmr1773437pfv.2.1684899918278;
        Tue, 23 May 2023 20:45:18 -0700 (PDT)
Received: from fshao-p620.tpe.corp.google.com ([2401:fa00:1:10:3b18:4c0c:a178:5536])
        by smtp.gmail.com with ESMTPSA id d3-20020aa78683000000b0064cb1fe7e44sm6357616pfo.219.2023.05.23.20.45.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 20:45:17 -0700 (PDT)
From:   Fei Shao <fshao@chromium.org>
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Jeff LaBundy <jeff@labundy.com>,
        Douglas Anderson <dianders@chromium.org>,
        Fei Shao <fshao@chromium.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Stephen Kitt <steve@sk2.org>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH RESEND v4 2/2] HID: i2c-hid: goodix: Add support for "goodix,no-reset-during-suspend" property
Date:   Wed, 24 May 2023 11:42:37 +0800
Message-ID: <20230524114233.RESEND.v4.2.I424e840ae6de3cdbd67394cf4efd24534f6434ba@changeid>
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
In-Reply-To: <20230524114233.RESEND.v4.2.I424e840ae6de3cdbd67394cf4efd24534f6434ba@changeid>
References: <20230524114233.RESEND.v4.2.I424e840ae6de3cdbd67394cf4efd24534f6434ba@changeid>
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
Suggested-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Jeff LaBundy <jeff@labundy.com>

---

Changes in v4:
- Minor coding style improvement

Changes in v3:
- In power-down, only skip the GPIO but not the regulator calls if the
  flag is set

Changes in v2:
- Drop the change to regulator_enable logic during power-up

 drivers/hid/i2c-hid/i2c-hid-of-goodix.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/i2c-hid/i2c-hid-of-goodix.c b/drivers/hid/i2c-hid/i2c-hid-of-goodix.c
index 0060e3dcd775..db4639db9840 100644
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
 
+	/*
+	 * We assert reset GPIO here (instead of during power-down) to ensure
+	 * the device will have a clean state after powering up, just like the
+	 * normal scenarios will have.
+	 */
+	if (ihid_goodix->no_reset_during_suspend)
+		gpiod_set_value_cansleep(ihid_goodix->reset_gpio, 1);
+
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
2.40.1.698.g37aff9b760-goog

