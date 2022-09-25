Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AA325E95FC
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Sep 2022 22:43:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232185AbiIYUnv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 16:43:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231218AbiIYUnq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 16:43:46 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABF8929809;
        Sun, 25 Sep 2022 13:43:45 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id dv25so10259543ejb.12;
        Sun, 25 Sep 2022 13:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=IRPOpbRztdIWfoMEyOR5FNdNwTAfeqMezmdLBhrI1Y8=;
        b=oTO93ojZumu65icQuERJ+8LSy3jHGye4u5gcIEciPZolS5siDD0rmq7AzSUi5vBR5t
         Gh/wHx/TQIWgkjVSbx4VvrAcwXWALY7CmBoniRuWSwOUfB0PmKg4xLk7jV9pyQ/ZGbOR
         ltwL7OYwhDnu4AKWC9OxvL95A3D6r1TQAZ8AwkqW959qPEyMeHHghB5sVYOFRW9xAT8z
         NwNsO0E4byzpL9gmBTD7LFlIIXul/fxAiAw1kFR7jlnx7PORzPvZWmXBLl+3/LG8vQT8
         fplX8OILLeuwjIKK1pCVmOZFJuqna9MDBce7u2XMBoSqUJM+GlWtcSBv6c5j6WHatZQ6
         /XYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=IRPOpbRztdIWfoMEyOR5FNdNwTAfeqMezmdLBhrI1Y8=;
        b=smG8kn2W7tcrwjQ3Eio1k9igSTYJt/O8PzvxprDM0roiCLa8NoZgnklmlkX4meFi8F
         LbpAa7ghbsXsXOqNUfwyWS2hxcFPANacSXzEepVSNN/kV2P5jjFniRRr5brAikhvUsb7
         /exadXl4Aok/fXhe+RXHQrI3Y5gGI7Wm7Ul1wB1U9kPqc9t0zbH3wOpltefVNhRhmqZP
         NSWJZIoOGr6vI9NoXy5iqS53zbGzhaiLgB8FcziHHpAG4t7HBEkeGj//RZ6dC7AiWNy1
         UrtUzDe9Wcr+9S5xCzAxNaSkMWqsEeWffAVyc5RYO0KpM6RX1FLQ+riwsJ8771JbXPfU
         swhA==
X-Gm-Message-State: ACrzQf2OT9futU76AUFzwvbYNau7h7mm+oNBDncrK81lRC8/phAYjoKF
        8fzdTXdG3iVvvRiCNwGnO94IdRzsbxU=
X-Google-Smtp-Source: AMsMyM53lHwQZ2WDcwegamAsdfP0T88HKZEVMFM0Ib1UMtvh/YWe8fSxw35fIvtEWh31SNW+0TdBRA==
X-Received: by 2002:a17:907:1b0e:b0:72f:9b43:b98c with SMTP id mp14-20020a1709071b0e00b0072f9b43b98cmr15550202ejc.710.1664138624180;
        Sun, 25 Sep 2022 13:43:44 -0700 (PDT)
Received: from spectre.. (host-82-61-191-175.retail.telecomitalia.it. [82.61.191.175])
        by smtp.gmail.com with ESMTPSA id r10-20020a17090609ca00b0073cb0801104sm7283889eje.147.2022.09.25.13.43.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Sep 2022 13:43:43 -0700 (PDT)
From:   Elia Devito <eliadevito@gmail.com>
Cc:     Elia Devito <eliadevito@gmail.com>,
        Philippe Rouquier <bonfire-app@wanadoo.fr>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] platform/x86: hp-wmi: add support for quiet thermal profile
Date:   Sun, 25 Sep 2022 22:42:45 +0200
Message-Id: <20220925204244.53506-1-eliadevito@gmail.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The quiet profile is available only on models without dGPU,
so we enable it when the device has only one GPU onboard.

Signed-off-by: Elia Devito <eliadevito@gmail.com>
Tested-by: Philippe Rouquier <bonfire-app@wanadoo.fr>
---
 drivers/platform/x86/hp-wmi.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/hp-wmi.c b/drivers/platform/x86/hp-wmi.c
index bc7020e9df9e..3e0e67be8001 100644
--- a/drivers/platform/x86/hp-wmi.c
+++ b/drivers/platform/x86/hp-wmi.c
@@ -177,7 +177,8 @@ enum hp_thermal_profile_omen_v1 {
 enum hp_thermal_profile {
 	HP_THERMAL_PROFILE_PERFORMANCE	= 0x00,
 	HP_THERMAL_PROFILE_DEFAULT		= 0x01,
-	HP_THERMAL_PROFILE_COOL			= 0x02
+	HP_THERMAL_PROFILE_COOL			= 0x02,
+	HP_THERMAL_PROFILE_QUIET			= 0x03,
 };
 
 #define IS_HWBLOCKED(x) ((x & HPWMI_POWER_FW_OR_HW) != HPWMI_POWER_FW_OR_HW)
@@ -1194,6 +1195,9 @@ static int hp_wmi_platform_profile_get(struct platform_profile_handler *pprof,
 	case HP_THERMAL_PROFILE_COOL:
 		*profile =  PLATFORM_PROFILE_COOL;
 		break;
+	case HP_THERMAL_PROFILE_QUIET:
+		*profile =  PLATFORM_PROFILE_QUIET;
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -1216,6 +1220,9 @@ static int hp_wmi_platform_profile_set(struct platform_profile_handler *pprof,
 	case PLATFORM_PROFILE_COOL:
 		tp =  HP_THERMAL_PROFILE_COOL;
 		break;
+	case PLATFORM_PROFILE_QUIET:
+		tp =  HP_THERMAL_PROFILE_QUIET;
+		break;
 	default:
 		return -EOPNOTSUPP;
 	}
@@ -1230,6 +1237,8 @@ static int hp_wmi_platform_profile_set(struct platform_profile_handler *pprof,
 static int thermal_profile_setup(void)
 {
 	int err, tp;
+	unsigned int n_gpu = 0;
+	const struct dmi_device *dev = NULL;
 
 	if (is_omen_thermal_profile()) {
 		tp = omen_thermal_profile_get();
@@ -1263,6 +1272,16 @@ static int thermal_profile_setup(void)
 
 		platform_profile_handler.profile_get = hp_wmi_platform_profile_get;
 		platform_profile_handler.profile_set = hp_wmi_platform_profile_set;
+
+		/*
+		 * The quiet profile is available only on models without dGPU,
+		 * so we enable it when the device has only one GPU onboard.
+		 */
+		while ((dev = dmi_find_device(DMI_DEV_TYPE_VIDEO, NULL, dev)))
+			n_gpu++;
+
+		if (n_gpu == 1)
+			set_bit(PLATFORM_PROFILE_QUIET, platform_profile_handler.choices);
 	}
 
 	set_bit(PLATFORM_PROFILE_COOL, platform_profile_handler.choices);
-- 
2.37.2

