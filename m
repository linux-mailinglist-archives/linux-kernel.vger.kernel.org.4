Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C5286F0001
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 05:57:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242915AbjD0D5e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 23:57:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236396AbjD0D52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 23:57:28 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BB792723
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 20:57:25 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-2496863c2c7so6688746a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 20:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1682567845; x=1685159845;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2lcib0V3+/ELO569Iy00GQ8fHxNyEHZ4Blfo69bvdqM=;
        b=g9HKfptZk20Ox+mkmRYcscaSTzFpFspwaR35VpaZ4cOjbiahSU4aCyso5kM0SyPoYf
         VzH873PNU/UK3fVyVxOM3/dTsSb6FlwtpkW8xWnCiE0w6zzSO4aeGwdbqMcNtMvcBQkH
         hgjQabfDwFB8yagiqZMvfZQRehUsU23zNDQlE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682567845; x=1685159845;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2lcib0V3+/ELO569Iy00GQ8fHxNyEHZ4Blfo69bvdqM=;
        b=XJgd7gR3GisXert2aJ2JffqKIvm7sZuKT+04Upp268l0MioolMKR4USOOAo1XW3JOg
         7R1gZE80O2qUpOrSCApf2n/94z0IT1D+upcl2XdItd+5XCIQ2zo9k4+Zm+k9UjccJnTd
         /Y133A0suyUFFGIj1bi8tiaJOHqT/kKgFjWzqHHRpP2CBkUx974uvnALQnBz19xL5jkH
         DWRWrxWtbpNz67iqEiUrtUjpNg912mOi0Eq3TUMamfNkG/VIFpNJWc8DUnpZH6UrvDK4
         +muFF1o9pkPrXrsDwDYMNBnUolKTKLQXvLLtoUUocVSv3CXwqkvD9BhVhMYRO04o9Kc9
         78pw==
X-Gm-Message-State: AC+VfDwA+MTa3oZvZcalTcGmQcVzsEmkxFCMux378TkG2wxIeY5phejy
        MxIRh2+9uf9SDX82qXBhe7ZjZw==
X-Google-Smtp-Source: ACHHUZ7BZJGgxXIMRw2e+qA72i2MWL4JOJIFF97S0AujZ/KH7taebd8zyS3xLyIei7CZAbhQN6l7Iw==
X-Received: by 2002:a17:90a:ce8a:b0:24b:fd98:f760 with SMTP id g10-20020a17090ace8a00b0024bfd98f760mr647297pju.0.1682567844860;
        Wed, 26 Apr 2023 20:57:24 -0700 (PDT)
Received: from fshao-glinux.tpe.corp.google.com ([2401:fa00:1:10:dcf6:797f:140d:6d])
        by smtp.gmail.com with ESMTPSA id u1-20020a17090ae00100b002471f9a010dsm12214092pjy.21.2023.04.26.20.57.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Apr 2023 20:57:24 -0700 (PDT)
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
Subject: [PATCH v4 2/2] HID: i2c-hid: goodix: Add support for "goodix,no-reset-during-suspend" property
Date:   Thu, 27 Apr 2023 11:56:56 +0800
Message-ID: <20230427035656.1962698-3-fshao@chromium.org>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
In-Reply-To: <20230427035656.1962698-1-fshao@chromium.org>
References: <20230427035656.1962698-1-fshao@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
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
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Jeff LaBundy <jeff@labundy.com>

---

Changes in v4:
- Minor coding style improvement

Changes in v3:
- In power-down, only skip the GPIO but not the regulator calls if the
  flag is set

Changes in v2:
- Do not change the regulator_enable logic during power-up.

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
2.40.1.495.gc816e09b53d-goog

