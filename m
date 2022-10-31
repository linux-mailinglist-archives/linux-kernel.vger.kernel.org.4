Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77874613DFE
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 20:02:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbiJaTCm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 15:02:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbiJaTCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 15:02:37 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5E8C6464;
        Mon, 31 Oct 2022 12:02:36 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id l14so17317508wrw.2;
        Mon, 31 Oct 2022 12:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zavMHsSj3e/dCc/hkXC9bPGYtn7phryrRvHhVepuECA=;
        b=Go1kXz3Z1LNi9yomLF4YaQQGN0y/OKFhYwPQ5+Ef51gvcICz6enDy8oxYVs62pbLyx
         JLM6xCl3L4NsPrAEdJV9kjYPb/t9fZjlhhhXEVwK0OLkk7ovn7HJlgCjVvIU6IJAryKW
         EW3cvwQSjDVH6UcPVMkR+3So1Oef22dQW8OgXN/yqG12LiA6wVQELqB5/ff6sFuVlSu3
         7UOrVeghwVnR+5KztQxsg4uyVavjCdtv0EeXZ/tT7sKySiIqQ3Lga8Z6B4UgN4RlTocL
         q5Ti0NxnQYPDb7qjgRnZxZ6DFK1Yh94EB1Rst2nEc+kvBxhn+xU+wLVMRfw69TWxcfSu
         tZ6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zavMHsSj3e/dCc/hkXC9bPGYtn7phryrRvHhVepuECA=;
        b=z6FEWoy28C8kwjzq5EIhWb4RLVR9qxQOBQQSwoEfQsIoCRYboJpJtchlClhxiV4KEo
         Pwzv8n9vpgzwVMKwJfZuzpxQgJrkFeedaAd6cx6O5WGVzzqHJBzN7QvmLlbcpZgePVPn
         Fufqgq4fJ6Q87x9rPSd2UEVHwzIIAIccyiIneszLXUO+dusIIrrwP5vS2cIYxVAcJenG
         UWVCB11izz9dYLV8zQoIFYsI0w4IFts7Ql5V8Ud5Y3iX4VuZZ75rnxa2wqMBeNSaPc66
         8Bz/Um33oAVEcj+p2cPwRcs3MZDMz6Y/w4vDy5XsL/P/+Jc2IGpon2DsHPWxJaO8/jXQ
         9tvw==
X-Gm-Message-State: ACrzQf1kaRUW6bzmk+7MDz9Rj9+93FiftKPYlhVVnHT3wGDoEPK+o0vm
        ina4t6heNTHwVgd1qBXx75d5sRzQ2IyL/vTu
X-Google-Smtp-Source: AMsMyM5lhnhuAEt9zL5fyRMdKem53TI6oRNzm9wxiTea3f3t0q+GWz/2qQf+R9GdX1tyWluwRcA36w==
X-Received: by 2002:adf:a4cc:0:b0:235:f41c:aa1e with SMTP id h12-20020adfa4cc000000b00235f41caa1emr9271250wrb.515.1667242955237;
        Mon, 31 Oct 2022 12:02:35 -0700 (PDT)
Received: from hp-power-15.localdomain (mm-167-8-212-37.vitebsk.dynamic.pppoe.byfly.by. [37.212.8.167])
        by smtp.gmail.com with ESMTPSA id l13-20020a05600c2ccd00b003a2f2bb72d5sm9141750wmc.45.2022.10.31.12.02.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 12:02:34 -0700 (PDT)
From:   Siarhei Volkau <lis8215@gmail.com>
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Siarhei Volkau <lis8215@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Artur Rojek <contact@artur-rojek.eu>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 2/2] Input: adc-joystick - add detachable devices support
Date:   Mon, 31 Oct 2022 22:01:59 +0300
Message-Id: <20221031190159.1341027-3-lis8215@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20221031190159.1341027-1-lis8215@gmail.com>
References: <20221031190159.1341027-1-lis8215@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For detachable or lock-able joysticks the ADC lanes might
be biased to GND or AVDD when the joystick is detached/locked.

One such kind of joystick is found in the Ritmix RZX-50 device.
The joystick is non-detachable, although ADC lane biased to power
supply when the "Hold" switch is activated.

To avoid reporting old/broken measurements valid-range is used.
When measured value is outside valid-range the driver reports
safe center position for corresponding axis.

Signed-off-by: Siarhei Volkau <lis8215@gmail.com>
---
 drivers/input/joystick/adc-joystick.c | 58 ++++++++++++++++++++++++++-
 1 file changed, 57 insertions(+), 1 deletion(-)

diff --git a/drivers/input/joystick/adc-joystick.c b/drivers/input/joystick/adc-joystick.c
index c0deff5d4..6a143dc38 100644
--- a/drivers/input/joystick/adc-joystick.c
+++ b/drivers/input/joystick/adc-joystick.c
@@ -18,6 +18,8 @@ struct adc_joystick_axis {
 	s32 range[2];
 	s32 fuzz;
 	s32 flat;
+	s32 valid[2];
+	s32 center;
 };
 
 struct adc_joystick {
@@ -29,6 +31,14 @@ struct adc_joystick {
 	bool polled;
 };
 
+static inline bool is_in_range(const s32 *range, int val)
+{
+	s32 min = range[0];
+	s32 max = range[1];
+
+	return (min == 0 && max == 0) || (val >= min && val <= max);
+}
+
 static void adc_joystick_poll(struct input_dev *input)
 {
 	struct adc_joystick *joy = input_get_drvdata(input);
@@ -38,6 +48,10 @@ static void adc_joystick_poll(struct input_dev *input)
 		ret = iio_read_channel_raw(&joy->chans[i], &val);
 		if (ret < 0)
 			return;
+
+		if (!is_in_range(joy->axes[i].valid, val))
+			val = joy->axes[i].center;
+
 		input_report_abs(input, joy->axes[i].code, val);
 	}
 	input_sync(input);
@@ -86,6 +100,10 @@ static int adc_joystick_handle(const void *data, void *private)
 			val = sign_extend32(val, msb);
 		else
 			val &= GENMASK(msb, 0);
+
+		if (!is_in_range(joy->axes[i].valid, val))
+			val = joy->axes[i].center;
+
 		input_report_abs(joy->input, joy->axes[i].code, val);
 	}
 
@@ -119,6 +137,21 @@ static void adc_joystick_cleanup(void *data)
 	iio_channel_release_all_cb(data);
 }
 
+static bool valid_range_covers_abs_range(struct adc_joystick_axis *axis)
+{
+	s32 abs_min, abs_max;
+
+	if (axis->range[0] > axis->range[1]) {
+		abs_min = axis->range[1];
+		abs_max = axis->range[0];
+	} else {
+		abs_min = axis->range[0];
+		abs_max = axis->range[1];
+	}
+
+	return axis->valid[0] <= abs_min && axis->valid[1] >= abs_max;
+}
+
 static int adc_joystick_set_axes(struct device *dev, struct adc_joystick *joy)
 {
 	struct adc_joystick_axis *axes;
@@ -137,7 +170,7 @@ static int adc_joystick_set_axes(struct device *dev, struct adc_joystick *joy)
 		return -EINVAL;
 	}
 
-	axes = devm_kmalloc_array(dev, num_axes, sizeof(*axes), GFP_KERNEL);
+	axes = devm_kcalloc(dev, num_axes, sizeof(*axes), GFP_KERNEL);
 	if (!axes)
 		return -ENOMEM;
 
@@ -167,10 +200,33 @@ static int adc_joystick_set_axes(struct device *dev, struct adc_joystick *joy)
 			dev_err(dev, "abs-range invalid or missing\n");
 			goto err_fwnode_put;
 		}
+		axes[i].center = (axes[i].range[0] + axes[i].range[1]) / 2;
 
 		fwnode_property_read_u32(child, "abs-fuzz", &axes[i].fuzz);
 		fwnode_property_read_u32(child, "abs-flat", &axes[i].flat);
 
+		if (fwnode_property_present(child, "valid-range")) {
+			error = fwnode_property_read_u32_array(child,
+						       "valid-range",
+						       axes[i].valid, 2);
+			if (error) {
+				dev_err(dev, "valid-range invalid\n");
+				goto err_fwnode_put;
+			}
+
+			if (axes[i].valid[0] > axes[i].valid[1]) {
+				dev_err(dev,
+					"valid-range invalid (min > max)\n");
+				goto err_fwnode_put;
+			}
+
+			if (!valid_range_covers_abs_range(&axes[i])) {
+				dev_err(dev,
+					"valid-range must cover abs-range\n");
+				goto err_fwnode_put;
+			}
+		}
+
 		input_set_abs_params(joy->input, axes[i].code,
 				     axes[i].range[0], axes[i].range[1],
 				     axes[i].fuzz, axes[i].flat);
-- 
2.36.1

