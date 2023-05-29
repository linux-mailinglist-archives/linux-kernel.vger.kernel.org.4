Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5F937143C7
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 07:40:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230518AbjE2FkT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 01:40:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbjE2FkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 01:40:17 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2EFEA8;
        Sun, 28 May 2023 22:40:15 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-530638a60e1so2611673a12.2;
        Sun, 28 May 2023 22:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685338815; x=1687930815;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6FOt6/jNDEYnzLxqC7AoJSZCpvzsH4Kc5a9ChdfDk7g=;
        b=PXDX3dHrEyzRONErAjdsyLZDZPMMgh3Np79VPYpJAXqhv9G7BHgydjpSXVZNcFsXo8
         06L7nLjJvNnPsmOfBsuF/4Q2hzkXL6nQh7znIfXYd8MBVX7STkQj/HQR9rJajEMGDdvE
         VNppD2fA06s4o7o0PXKC0pT+Zy8NresWbOhI9sqS66eShcHPRo/BPpBwOZA8swnle56K
         JeCXmg3y9U3w2H/Slb0KUqMphwlwKZ26K286O9rn5NKEvbOEZ6tV+E+EcaFqD3EnGO33
         GvPyO2fUU5N6SCUlAf8rY5Pvgm3NMs5pfq9oHu7BuuW87hf7TBMOSowF2RPPgHKfVmiL
         AJ2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685338815; x=1687930815;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6FOt6/jNDEYnzLxqC7AoJSZCpvzsH4Kc5a9ChdfDk7g=;
        b=GiGAEGI9wvSy9QmuKu0EfvTqPXw0SBTbW0uRbuxJDpnwwJdau6xU0rEKhrQ+LEeTCc
         TuBiXOfq6oRz4CUOt4LBIjUBY1wPgIBxWK0UClNxPu7n66mTstlAVhSe5W6Q6rmkL1zn
         kEwr7KnysPDo7ySYf+PpTVpHfF7CaTNuAmjCJhpeivtl/d+he4YjE2AEVFDGDWEiITMU
         w8Rkiwu7lF0VcJsCwxvJrzlZawTKmFn1T3YAl7DwefJG9a035I9m9uut53GMbULlEV0n
         50xFoM7+PPloYtofWsCNn8dNKuCfWlyALh/yaczapujbvM3kb1DsZ4XJo0Ee7sJv3ZHW
         evuQ==
X-Gm-Message-State: AC+VfDzilM3gen63tSkXCionA5HGYH6+DsFYiH+hKTlECdeMLjVCZOO2
        cX5prPNmUYorm156QmgTCa9pOV55Al8=
X-Google-Smtp-Source: ACHHUZ6Do4fvcFcfxjOHXK8o5whrQlGz/usqWsCFS0LW7jg9gHuY+SoWfFQCtERIozPRmf8/ii4Rqw==
X-Received: by 2002:a17:902:dac9:b0:1b0:3c1a:1238 with SMTP id q9-20020a170902dac900b001b03c1a1238mr3555125plx.59.1685338815240;
        Sun, 28 May 2023 22:40:15 -0700 (PDT)
Received: from localhost.localdomain ([110.46.146.116])
        by smtp.gmail.com with ESMTPSA id p20-20020a170902a41400b001ab39cd885esm7186778plq.212.2023.05.28.22.40.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 May 2023 22:40:14 -0700 (PDT)
From:   SungHwan Jung <onenowy@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>
Cc:     SungHwan Jung <onenowy@gmail.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] platform/x86: hp-wmi: Add thermal profile for Victus 16-d1xxx
Date:   Mon, 29 May 2023 14:39:58 +0900
Message-Id: <20230529053959.4876-1-onenowy@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
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

This patch includes Platform Profile support (performance, balanced, quiet)
for Victus 16-d1xxx (8A25).

Signed-off-by: SungHwan Jung <onenowy@gmail.com>
---
 drivers/platform/x86/hp/hp-wmi.c | 104 +++++++++++++++++++++++++++++--
 1 file changed, 99 insertions(+), 5 deletions(-)

diff --git a/drivers/platform/x86/hp/hp-wmi.c b/drivers/platform/x86/hp/hp-wmi.c
index 6364ae262705..6259b907ce63 100644
--- a/drivers/platform/x86/hp/hp-wmi.c
+++ b/drivers/platform/x86/hp/hp-wmi.c
@@ -66,6 +66,11 @@ static const char *const omen_thermal_profile_force_v0_boards[] = {
 	"8607", "8746", "8747", "8749", "874A", "8748"
 };
 
+/* DMI Board names of Victus laptops */
+static const char * const victus_thermal_profile_boards[] = {
+	"8A25"
+};
+
 enum hp_wmi_radio {
 	HPWMI_WIFI	= 0x0,
 	HPWMI_BLUETOOTH	= 0x1,
@@ -176,6 +181,12 @@ enum hp_thermal_profile_omen_v1 {
 	HP_OMEN_V1_THERMAL_PROFILE_COOL		= 0x50,
 };
 
+enum hp_thermal_profile_victus {
+	HP_VICTUS_THERMAL_PROFILE_DEFAULT		= 0x00,
+	HP_VICTUS_THERMAL_PROFILE_PERFORMANCE	= 0x01,
+	HP_VICTUS_THERMAL_PROFILE_QUIET			= 0x03,
+};
+
 enum hp_thermal_profile {
 	HP_THERMAL_PROFILE_PERFORMANCE	= 0x00,
 	HP_THERMAL_PROFILE_DEFAULT		= 0x01,
@@ -1246,6 +1257,70 @@ static int hp_wmi_platform_profile_set(struct platform_profile_handler *pprof,
 	return 0;
 }
 
+static bool is_victus_thermal_profile(void)
+{
+	const char *board_name = dmi_get_system_info(DMI_BOARD_NAME);
+
+	if (!board_name)
+		return false;
+
+	return match_string(victus_thermal_profile_boards,
+			    ARRAY_SIZE(victus_thermal_profile_boards),
+			    board_name) >= 0;
+}
+
+static int platform_profile_victus_get(struct platform_profile_handler *pprof,
+				     enum platform_profile_option *profile)
+{
+	int tp;
+
+	tp = omen_thermal_profile_get();
+	if (tp < 0)
+		return tp;
+
+	switch (tp) {
+	case HP_VICTUS_THERMAL_PROFILE_PERFORMANCE:
+		*profile =  PLATFORM_PROFILE_PERFORMANCE;
+		break;
+	case HP_VICTUS_THERMAL_PROFILE_DEFAULT:
+		*profile =  PLATFORM_PROFILE_BALANCED;
+		break;
+	case HP_VICTUS_THERMAL_PROFILE_QUIET:
+		*profile =  PLATFORM_PROFILE_QUIET;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int platform_profile_victus_set(struct platform_profile_handler *pprof,
+				     enum platform_profile_option profile)
+{
+	int err, tp;
+
+	switch (profile) {
+	case PLATFORM_PROFILE_PERFORMANCE:
+		tp =  HP_VICTUS_THERMAL_PROFILE_PERFORMANCE;
+		break;
+	case PLATFORM_PROFILE_BALANCED:
+		tp =  HP_VICTUS_THERMAL_PROFILE_DEFAULT;
+		break;
+	case PLATFORM_PROFILE_QUIET:
+		tp =  HP_VICTUS_THERMAL_PROFILE_QUIET;
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	err = omen_thermal_profile_set(tp);
+	if (err < 0)
+		return err;
+
+	return 0;
+}
+
 static int thermal_profile_setup(void)
 {
 	int err, tp;
@@ -1266,6 +1341,25 @@ static int thermal_profile_setup(void)
 
 		platform_profile_handler.profile_get = platform_profile_omen_get;
 		platform_profile_handler.profile_set = platform_profile_omen_set;
+
+		set_bit(PLATFORM_PROFILE_COOL, platform_profile_handler.choices);
+	} else if (is_victus_thermal_profile()) {
+		tp = omen_thermal_profile_get();
+		if (tp < 0)
+			return tp;
+
+		/*
+		 * call thermal profile write command to ensure that the
+		 * firmware correctly sets the OEM variables
+		 */
+		err = omen_thermal_profile_set(tp);
+		if (err < 0)
+			return err;
+
+		platform_profile_handler.profile_get = platform_profile_victus_get;
+		platform_profile_handler.profile_set = platform_profile_victus_set;
+
+		set_bit(PLATFORM_PROFILE_QUIET, platform_profile_handler.choices);
 	} else {
 		tp = thermal_profile_get();
 
@@ -1273,20 +1367,20 @@ static int thermal_profile_setup(void)
 			return tp;
 
 		/*
-		 * call thermal profile write command to ensure that the
-		 * firmware correctly sets the OEM variables for the DPTF
-		 */
+		 * call thermal profile write command to ensure that the
+		 * firmware correctly sets the OEM variables for the DPTF
+		 */
 		err = thermal_profile_set(tp);
 		if (err)
 			return err;
 
 		platform_profile_handler.profile_get = hp_wmi_platform_profile_get;
 		platform_profile_handler.profile_set = hp_wmi_platform_profile_set;
-
+
 		set_bit(PLATFORM_PROFILE_QUIET, platform_profile_handler.choices);
+		set_bit(PLATFORM_PROFILE_COOL, platform_profile_handler.choices);
 	}
 
-	set_bit(PLATFORM_PROFILE_COOL, platform_profile_handler.choices);
 	set_bit(PLATFORM_PROFILE_BALANCED, platform_profile_handler.choices);
 	set_bit(PLATFORM_PROFILE_PERFORMANCE, platform_profile_handler.choices);
 
-- 
2.40.1

