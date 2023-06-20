Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37F7973759F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 22:04:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbjFTUEF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 16:04:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbjFTUDl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 16:03:41 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8F7F10F0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 13:03:39 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-519f6e1a16cso6065336a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 13:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687291418; x=1689883418;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2RVAC+ZaZODWJ+QFQBc3rYxuHiijX92xEaSVhSFgl3o=;
        b=mrVUpP3jn3SF8dK4Gd4pciXBMZDMGoWleyLtt8d4i0veouLd5ObXCGZhqq0qS8tZpS
         LHWE09xVNGj7BeUgVg1UYLBLa4lOjz9ghVQBYCOY7kdssPocZuEhZhSJJqiTutcR+O6Z
         vN9HKSNk4gPyIkyxNnWbq2uJFBmV8gW5gUB1aYN18CiuCVB0t5Wao8I2tIidUiHi8Fni
         4PqNZNU1aiYdWsD2fKEOljz6nx3GITQCBdjjZVoaAn6mDv4DKQ+G2rcTrhOL9pC/jI6T
         4aT0I+e0AFcs8sGGZ293V7yhku4PsJOhO285z/DIhUbUQaWEeSKz000q+SYSJ9Er++bq
         xh6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687291418; x=1689883418;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2RVAC+ZaZODWJ+QFQBc3rYxuHiijX92xEaSVhSFgl3o=;
        b=V5/zO1qUNKCAK5KQxzZauKyd62VUapC23OfqWKofhkbXD5CChnvg3b64c/D0laybJd
         fx/GoykqkMtxVwyU/UZzYY5tx5p0kCc8rAITN/43D/oLWZnJjJj/Jttoix8FeAtIWSZP
         6FZJvntduBuatk6F2iL6sJQj4LTl1neIfbaSJkwfAmQ9eYP6pysvJU3ZYS5Npsmj0HNj
         1CvdEgu52nSGdMoPqKVFQuDC4k779IioTvKqYr6o/w2Y7payqoFH+kA33g8QUNBOaQdI
         IKupNQM7v3URvEoX2cSJ7s9VLBCwWMJRyvIsjKKYGgyR3uCX5ODK/LiMTrgmPNBfi33b
         pSSg==
X-Gm-Message-State: AC+VfDyUm+sxOaEeLBUgrvK0RiMHnfWCGJ4lqxt7/zOhh2qgyuPfcSBm
        FnTJlfSzgG7XMiaEtoJ4zoH0LSfjLZ+jZQ==
X-Google-Smtp-Source: ACHHUZ5bp7x5munn1VtEk7+2qSwrdlsaEXcT/zqtu43LDIo0364bHeI2Z5XRriP+opDt0q/EU4hBqg==
X-Received: by 2002:a17:907:9453:b0:987:47b3:6e34 with SMTP id dl19-20020a170907945300b0098747b36e34mr8704687ejc.67.1687291418327;
        Tue, 20 Jun 2023 13:03:38 -0700 (PDT)
Received: from [127.0.1.1] ([91.230.2.244])
        by smtp.gmail.com with ESMTPSA id u21-20020a17090617d500b00977e0bcff1esm1947064eje.10.2023.06.20.13.03.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 13:03:37 -0700 (PDT)
From:   Benjamin Bara <bbara93@gmail.com>
Date:   Tue, 20 Jun 2023 22:03:00 +0200
Subject: [PATCH RFC v4 07/13] regulator: find active protections during
 initialization
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230419-dynamic-vmon-v4-7-4d3734e62ada@skidata.com>
References: <20230419-dynamic-vmon-v4-0-4d3734e62ada@skidata.com>
In-Reply-To: <20230419-dynamic-vmon-v4-0-4d3734e62ada@skidata.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     support.opensource@diasemi.com,
        DLG-Adam.Ward.opensource@dm.renesas.com,
        Martin Fuzzey <martin.fuzzey@flowbird.group>,
        linux-kernel@vger.kernel.org,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Benjamin Bara <benjamin.bara@skidata.com>
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Benjamin Bara <benjamin.bara@skidata.com>

It can happen that monitors are activated before the kernel is started,
e.g. by bootloader or by OTP. If monitoring workarounds are active on a
regulator, the core shouldn't perform the state changes without applying
the workaround to the regulator. Therefore, warn the user already during
initialization that the device-tree should be adapted.

Warning can be fixed by enabling (or disabling) monitoring in the DT,
e.g.:
regulator-uv-protection-microvolt = <1>;
or
regulator-ov-error-microvolt = <0>;

Constraints regarding the monitoring of a regulator can usually be found
in the docu.

Signed-off-by: Benjamin Bara <benjamin.bara@skidata.com>
---
 drivers/regulator/core.c | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index ca5d6ba889dc..9bddab17450e 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -1564,6 +1564,47 @@ static int set_machine_constraints(struct regulator_dev *rdev)
 		}
 	}
 
+	/*
+	 * When the core is in charge of handling monitoring workarounds,
+	 * it is essential to know if a monitor is already active during
+	 * initialization.
+	 */
+	if (rdev->desc->mon_disable_reg_disabled ||
+	    rdev->desc->mon_disable_reg_set_higher ||
+	    rdev->desc->mon_disable_reg_set_lower ||
+	    rdev->desc->mon_unsupported_reg_modes) {
+		unsigned int monitor_state = REGULATOR_MONITOR_NONE;
+
+		ret = ops->get_active_protections(rdev, &monitor_state);
+		if (ret)
+			return ret;
+
+		if (!rdev->constraints->over_voltage_detection &&
+		    (monitor_state & REGULATOR_MONITOR_OVER_VOLTAGE)) {
+			rdev_err(rdev, "dt unaware of active %s monitor!\n",
+				       "over-voltage");
+			return -EINVAL;
+		}
+		if (!rdev->constraints->under_voltage_detection &&
+		    (monitor_state & REGULATOR_MONITOR_UNDER_VOLTAGE)) {
+			rdev_err(rdev, "dt unaware of active %s monitor!\n",
+				       "under-voltage");
+			return -EINVAL;
+		}
+		if (!rdev->constraints->over_current_detection &&
+		    (monitor_state & REGULATOR_MONITOR_OVER_CURRENT)) {
+			rdev_err(rdev, "dt unaware of active %s monitor!\n",
+				       "over-current");
+			return -EINVAL;
+		}
+		if (!rdev->constraints->over_temp_detection &&
+		    (monitor_state & REGULATOR_MONITOR_OVER_TEMPERATURE)) {
+			rdev_err(rdev, "dt unaware of active %s monitor!\n",
+				       "over-temperature");
+			return -EINVAL;
+		}
+	}
+
 	if (rdev->constraints->over_current_detection)
 		ret = handle_notify_limits(rdev,
 					   ops->set_over_current_protection,

-- 
2.34.1

