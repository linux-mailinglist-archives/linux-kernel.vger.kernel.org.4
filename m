Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94594710E50
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 16:27:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241498AbjEYO1P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 10:27:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241631AbjEYO1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 10:27:09 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B17F1B4;
        Thu, 25 May 2023 07:27:08 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id 5614622812f47-39831cb47c6so592989b6e.2;
        Thu, 25 May 2023 07:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685024827; x=1687616827;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=C3UAQNcfvYSrO7NwjcGLPnwIV6p+B20zb2tpMvZ8UCQ=;
        b=nrdDvpuBR5mNmD/4QPb46UJPDw5hb53K3iun1XuSKuf5aD19dd5AzaG/hzWOkp4Mcu
         T1+tjfw9RCcmJre/EMltvE8uosN6c1cRn5THCfyIXQzgW5YdPml6WU1E4/NZbzYhf/0W
         et4ML8D3N2IJEKb26jt8HpdqkRdZKSwKuMHxsXzk7qrIR9ci6XZdWX1WnhAFoXmfzOyE
         6rDqrYpO3Kvj7/RlTKDnLskO2U5uTkcyLlOZhdv34Xux9a9Y+EIb4/fbTidwOfDqGKTl
         mcsd2WYiQDYoZ9HoEWQLmGik2d2BB0ubiipKzg4tYBKUbEBqfkK+HS/yRtyHjejc3x9b
         /e3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685024827; x=1687616827;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C3UAQNcfvYSrO7NwjcGLPnwIV6p+B20zb2tpMvZ8UCQ=;
        b=XKKsGgBo5IpDRy9VG1QvFAtDra1/j+IDD7OlEPRQvuka+x4v8myGJUiGPrxIKiyYgN
         z6WploY37TSsIommrT1Gnlyq/CNHC5b8/UAaHnE3f2YbMk1p3JhHVtEELPBkx+urNyB+
         g+BPnGGwbDn5grOazQpZQ5FuTLr3G3V+unVT5OwTaWC4UoxNOGE8oU00HRD1t8QiVj9e
         ozNwBvoafXBY4muHD98QR6oitpnS7u+keWPP3Ek9sT4mz9Hz4bepgxoofHDi7yTSmk0R
         JWkJtuHgaeSNAB2b+UVVKOfjzzrNOepYMG8/21y2SIKb24pBLCG24jqQfzVoFtI4X6fE
         y37w==
X-Gm-Message-State: AC+VfDxKRDXQLX8IO8y2CxRHKuViSqYWljesEnR8XEV5TaSUdNA3ttfV
        ynlGW4p/D8ap/6meF+scSGUPthHdSFU=
X-Google-Smtp-Source: ACHHUZ4/epwYClLdnQuvLAY/sefgIgLya2KfguUdlbhb+alHSNc8E8ImhqL7Ey/jOI2qFkuBqWSDLw==
X-Received: by 2002:aca:2b07:0:b0:38b:efe8:dfa8 with SMTP id i7-20020aca2b07000000b0038befe8dfa8mr10211291oik.51.1685024827557;
        Thu, 25 May 2023 07:27:07 -0700 (PDT)
Received: from smeagol.fibertel.com.ar ([201.235.4.68])
        by smtp.gmail.com with ESMTPSA id g10-20020a9d620a000000b006a5e0165d3esm680859otj.19.2023.05.25.07.27.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 May 2023 07:27:06 -0700 (PDT)
From:   =?UTF-8?q?Joaqu=C3=ADn=20Ignacio=20Aramend=C3=ADa?= 
        <samsagax@gmail.com>
To:     linux@roeck-us.net
Cc:     =?UTF-8?q?Joaqu=C3=ADn=20Ignacio=20Aramend=C3=ADa?= 
        <samsagax@gmail.com>, derekjohn.clark@gmail.com, jdelvare@suse.com,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] hwmon: (oxp-sensors) Stop passing device structure
Date:   Thu, 25 May 2023 11:26:52 -0300
Message-Id: <20230525142652.41981-1-samsagax@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We don't need to pass device structure to write_to_ec() so we remove
that from the function declaration.
The same is valid for pwm_enable() and pwm_disable() as we were passing
the pointer to hand it off to write_to_ec().

Signed-off-by: Joaquín Ignacio Aramendía <samsagax@gmail.com>
---
 drivers/hwmon/oxp-sensors.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/hwmon/oxp-sensors.c b/drivers/hwmon/oxp-sensors.c
index a4ee757f879f..0ec7588610ad 100644
--- a/drivers/hwmon/oxp-sensors.c
+++ b/drivers/hwmon/oxp-sensors.c
@@ -141,7 +141,7 @@ static int read_from_ec(u8 reg, int size, long *val)
 	return 0;
 }
 
-static int write_to_ec(const struct device *dev, u8 reg, u8 value)
+static int write_to_ec(u8 reg, u8 value)
 {
 	int ret;
 
@@ -156,14 +156,14 @@ static int write_to_ec(const struct device *dev, u8 reg, u8 value)
 	return ret;
 }
 
-static int oxp_pwm_enable(const struct device *dev)
+static int oxp_pwm_enable(void)
 {
-	return write_to_ec(dev, OXP_SENSOR_PWM_ENABLE_REG, 0x01);
+	return write_to_ec(OXP_SENSOR_PWM_ENABLE_REG, 0x01);
 }
 
-static int oxp_pwm_disable(const struct device *dev)
+static int oxp_pwm_disable(void)
 {
-	return write_to_ec(dev, OXP_SENSOR_PWM_ENABLE_REG, 0x00);
+	return write_to_ec(OXP_SENSOR_PWM_ENABLE_REG, 0x00);
 }
 
 /* Callbacks for hwmon interface */
@@ -234,9 +234,9 @@ static int oxp_platform_write(struct device *dev, enum hwmon_sensor_types type,
 		switch (attr) {
 		case hwmon_pwm_enable:
 			if (val == 1)
-				return oxp_pwm_enable(dev);
+				return oxp_pwm_enable();
 			else if (val == 0)
-				return oxp_pwm_disable(dev);
+				return oxp_pwm_disable();
 			return -EINVAL;
 		case hwmon_pwm_input:
 			if (val < 0 || val > 255)
@@ -254,7 +254,7 @@ static int oxp_platform_write(struct device *dev, enum hwmon_sensor_types type,
 			default:
 				break;
 			}
-			return write_to_ec(dev, OXP_SENSOR_PWM_REG, val);
+			return write_to_ec(OXP_SENSOR_PWM_REG, val);
 		default:
 			break;
 		}
-- 
2.40.1

