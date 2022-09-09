Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E60525B3C6F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 17:55:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231669AbiIIPzC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 11:55:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231470AbiIIPy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 11:54:58 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B873357F4;
        Fri,  9 Sep 2022 08:54:56 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id t7so3483667wrm.10;
        Fri, 09 Sep 2022 08:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=CIy/SfUDRIaKPAApTrbsRbtCFddr/ngKopfBIn5YtEk=;
        b=TW/Fet7UtEu99GCRXLJwzZjDYWyZcx8cuW7FvpFA4uv5qC92CEHqFoHjF6VpAG3B5R
         Z3vezosg1qmjwJUNlQT5VxSQ/gUyuQWLP3m8tJKmJ4K64Gu9JhhNgQakcxgfkh4840Ph
         lu6piwiEPKIzNiUfYANRKTH6B3WseO2oSlO1RXWqlQM+OpDyxxVT0bEwWkqBViiUFX7s
         ZLKtc99TSEJaBPZL97MPRjrXlFcYn3+zBLgQDHYU9/XvKi9hRMK0bosV0EsXlmgk80Dq
         6pM5tTUNo4D7gnd/nx9CYUx4ELAGOm0vBk7e4yxnrll99IBNTY2DYq+Vjh8VyFNs/Cz7
         88eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=CIy/SfUDRIaKPAApTrbsRbtCFddr/ngKopfBIn5YtEk=;
        b=6FdJHNIYfIaUP7KUF2y0PqyEf0+9+T+rN2KJtXDaFC+v92A3Za7JYlEDojufDVEwY+
         9zRyoeZ+lzIBMAkiMNu7dphu5CkiOk5Ms0bbxcSvacCYj11dWVL7iO5YT+A7g5zzCfmP
         TRJlByaqafLpf0KErF9yv2SrsgzafHKuP8stvEitnAMGkUI8Ld974Z9Gs0M6Dkcf9GMJ
         HUDwJG0iZz6y41ZrWlaq9+vyTKe2kQoFVj5PSAOFanUWUpeHbmOwJivt1zusRwICx8+D
         PCDAIdzyMpCzjkHgq71zTPbHgHUsiZFWD/Xxs0bJrWnFcs/fjX7X32J2Qv5wsHrSkPY6
         I5mQ==
X-Gm-Message-State: ACgBeo1XbDGBFLbs/7ZC3vrQeFdBogSM4C1ovygDp+XzvfW+Lr2ti1pW
        5oSMmMpIYcK7nWF0jzNFwQo=
X-Google-Smtp-Source: AA6agR5vSNM2zRCQMr/uD4AssYlJ/J7yUXuU6YDip+tmQkXxj9He7E4t8BE+cIxpdPC/CrxpInOgqQ==
X-Received: by 2002:a5d:6a07:0:b0:228:dba4:2138 with SMTP id m7-20020a5d6a07000000b00228dba42138mr8183533wru.346.1662738894951;
        Fri, 09 Sep 2022 08:54:54 -0700 (PDT)
Received: from caracal.museclub.art (p200300cf9f3f2f002177673bc12404e5.dip0.t-ipconnect.de. [2003:cf:9f3f:2f00:2177:673b:c124:4e5])
        by smtp.googlemail.com with ESMTPSA id i13-20020a05600c354d00b003a5c1e916c8sm173652wmq.1.2022.09.09.08.54.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 08:54:54 -0700 (PDT)
From:   Eugene Shalygin <eugene.shalygin@gmail.com>
To:     eugene.shalygin@gmail.com
Cc:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/1] hwmon: (asus-ec-sensors) autoload module via DMI data
Date:   Fri,  9 Sep 2022 17:54:46 +0200
Message-Id: <20220909155446.122937-2-eugene.shalygin@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220909155446.122937-1-eugene.shalygin@gmail.com>
References: <20220909155446.122937-1-eugene.shalygin@gmail.com>
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

Replace autoloading data based on the ACPI EC device with the DMI
records for motherboards models. The ACPI method created a bug that when
this driver returns error from the probe function because of the
unsupported motherboard model, the ACPI subsystem concludes
that the EC device does not work properly.

Fixes: 5cd29012028d
Bug: https://bugzilla.kernel.org/show_bug.cgi?id=216412
Bug: https://bugzilla.redhat.com/show_bug.cgi?id=2121844
Signed-off-by: Eugene Shalygin <eugene.shalygin@gmail.com>
---
 drivers/hwmon/asus-ec-sensors.c | 413 ++++++++++++++++++--------------
 1 file changed, 227 insertions(+), 186 deletions(-)

diff --git a/drivers/hwmon/asus-ec-sensors.c b/drivers/hwmon/asus-ec-sensors.c
index 61a4684fc020..206265ea8122 100644
--- a/drivers/hwmon/asus-ec-sensors.c
+++ b/drivers/hwmon/asus-ec-sensors.c
@@ -266,9 +266,7 @@ static const struct ec_sensor_info sensors_family_intel_600[] = {
 #define SENSOR_SET_WATER_BLOCK                                                 \
 	(SENSOR_TEMP_WATER_BLOCK_IN | SENSOR_TEMP_WATER_BLOCK_OUT)
 
-
 struct ec_board_info {
-	const char *board_names[MAX_IDENTICAL_BOARD_VARIATIONS];
 	unsigned long sensors;
 	/*
 	 * Defines which mutex to use for guarding access to the state and the
@@ -281,152 +279,194 @@ struct ec_board_info {
 	enum board_family family;
 };
 
-static const struct ec_board_info board_info[] = {
-	{
-		.board_names = {"PRIME X470-PRO"},
-		.sensors = SENSOR_SET_TEMP_CHIPSET_CPU_MB |
-			SENSOR_TEMP_T_SENSOR | SENSOR_TEMP_VRM |
-			SENSOR_FAN_CPU_OPT |
-			SENSOR_CURR_CPU | SENSOR_IN_CPU_CORE,
-		.mutex_path = ACPI_GLOBAL_LOCK_PSEUDO_PATH,
-		.family = family_amd_400_series,
-	},
-	{
-		.board_names = {"PRIME X570-PRO"},
-		.sensors = SENSOR_SET_TEMP_CHIPSET_CPU_MB | SENSOR_TEMP_VRM |
-			SENSOR_TEMP_T_SENSOR | SENSOR_FAN_CHIPSET,
-		.mutex_path = ASUS_HW_ACCESS_MUTEX_ASMX,
-		.family = family_amd_500_series,
-	},
-	{
-		.board_names = {"ProArt X570-CREATOR WIFI"},
-		.sensors = SENSOR_SET_TEMP_CHIPSET_CPU_MB | SENSOR_TEMP_VRM |
-			SENSOR_TEMP_T_SENSOR | SENSOR_FAN_CPU_OPT |
-			SENSOR_CURR_CPU | SENSOR_IN_CPU_CORE,
-	},
-	{
-		.board_names = {"Pro WS X570-ACE"},
-		.sensors = SENSOR_SET_TEMP_CHIPSET_CPU_MB | SENSOR_TEMP_VRM |
-			SENSOR_TEMP_T_SENSOR | SENSOR_FAN_CHIPSET |
-			SENSOR_CURR_CPU | SENSOR_IN_CPU_CORE,
-		.mutex_path = ASUS_HW_ACCESS_MUTEX_ASMX,
-		.family = family_amd_500_series,
-	},
-	{
-		.board_names = {"ROG CROSSHAIR VIII DARK HERO"},
-		.sensors = SENSOR_SET_TEMP_CHIPSET_CPU_MB |
-			SENSOR_TEMP_T_SENSOR |
-			SENSOR_TEMP_VRM | SENSOR_SET_TEMP_WATER |
-			SENSOR_FAN_CPU_OPT | SENSOR_FAN_WATER_FLOW |
-			SENSOR_CURR_CPU | SENSOR_IN_CPU_CORE,
-		.mutex_path = ASUS_HW_ACCESS_MUTEX_ASMX,
-		.family = family_amd_500_series,
-	},
-	{
-		.board_names = {
-			"ROG CROSSHAIR VIII FORMULA",
-			"ROG CROSSHAIR VIII HERO",
-			"ROG CROSSHAIR VIII HERO (WI-FI)",
-		},
-		.sensors = SENSOR_SET_TEMP_CHIPSET_CPU_MB |
-			SENSOR_TEMP_T_SENSOR |
-			SENSOR_TEMP_VRM | SENSOR_SET_TEMP_WATER |
-			SENSOR_FAN_CPU_OPT | SENSOR_FAN_CHIPSET |
-			SENSOR_FAN_WATER_FLOW | SENSOR_CURR_CPU |
-			SENSOR_IN_CPU_CORE,
-		.mutex_path = ASUS_HW_ACCESS_MUTEX_ASMX,
-		.family = family_amd_500_series,
-	},
-	{
-		.board_names = {
-			"ROG MAXIMUS XI HERO",
-			"ROG MAXIMUS XI HERO (WI-FI)",
-		},
-		.sensors = SENSOR_SET_TEMP_CHIPSET_CPU_MB |
-			SENSOR_TEMP_T_SENSOR |
-			SENSOR_TEMP_VRM | SENSOR_SET_TEMP_WATER |
-			SENSOR_FAN_CPU_OPT | SENSOR_FAN_WATER_FLOW,
-		.mutex_path = ASUS_HW_ACCESS_MUTEX_ASMX,
-		.family = family_intel_300_series,
-	},
-	{
-		.board_names = {"ROG CROSSHAIR VIII IMPACT"},
-		.sensors = SENSOR_SET_TEMP_CHIPSET_CPU_MB |
-			SENSOR_TEMP_T_SENSOR | SENSOR_TEMP_VRM |
-			SENSOR_FAN_CHIPSET | SENSOR_CURR_CPU |
-			SENSOR_IN_CPU_CORE,
-		.mutex_path = ASUS_HW_ACCESS_MUTEX_ASMX,
-		.family = family_amd_500_series,
-	},
-	{
-		.board_names = {"ROG STRIX B550-E GAMING"},
-		.sensors = SENSOR_SET_TEMP_CHIPSET_CPU_MB |
-			SENSOR_TEMP_T_SENSOR | SENSOR_TEMP_VRM |
-			SENSOR_FAN_CPU_OPT,
-		.mutex_path = ASUS_HW_ACCESS_MUTEX_ASMX,
-		.family = family_amd_500_series,
-	},
-	{
-		.board_names = {"ROG STRIX B550-I GAMING"},
-		.sensors = SENSOR_SET_TEMP_CHIPSET_CPU_MB |
-			SENSOR_TEMP_T_SENSOR | SENSOR_TEMP_VRM |
-			SENSOR_FAN_VRM_HS | SENSOR_CURR_CPU |
-			SENSOR_IN_CPU_CORE,
-		.mutex_path = ASUS_HW_ACCESS_MUTEX_ASMX,
-		.family = family_amd_500_series,
-	},
-	{
-		.board_names = {"ROG STRIX X570-E GAMING"},
-		.sensors = SENSOR_SET_TEMP_CHIPSET_CPU_MB |
-			SENSOR_TEMP_T_SENSOR | SENSOR_TEMP_VRM |
-			SENSOR_FAN_CHIPSET | SENSOR_CURR_CPU |
-			SENSOR_IN_CPU_CORE,
-		.mutex_path = ASUS_HW_ACCESS_MUTEX_ASMX,
-		.family = family_amd_500_series,
-	},
-	{
-		.board_names = {"ROG STRIX X570-E GAMING WIFI II"},
-		.sensors = SENSOR_SET_TEMP_CHIPSET_CPU_MB |
-			SENSOR_TEMP_T_SENSOR | SENSOR_CURR_CPU |
-			SENSOR_IN_CPU_CORE,
-		.mutex_path = ASUS_HW_ACCESS_MUTEX_ASMX,
-		.family = family_amd_500_series,
-	},
-	{
-		.board_names = {"ROG STRIX X570-F GAMING"},
-		.sensors = SENSOR_SET_TEMP_CHIPSET_CPU_MB |
-			SENSOR_TEMP_T_SENSOR | SENSOR_FAN_CHIPSET,
-		.mutex_path = ASUS_HW_ACCESS_MUTEX_ASMX,
-		.family = family_amd_500_series,
-	},
-	{
-		.board_names = {"ROG STRIX X570-I GAMING"},
-		.sensors = SENSOR_TEMP_CHIPSET | SENSOR_TEMP_VRM |
-			SENSOR_TEMP_T_SENSOR |
-			SENSOR_FAN_VRM_HS | SENSOR_FAN_CHIPSET |
-			SENSOR_CURR_CPU | SENSOR_IN_CPU_CORE,
-		.mutex_path = ASUS_HW_ACCESS_MUTEX_ASMX,
-		.family = family_amd_500_series,
-	},
-	{
-		.board_names = {"ROG STRIX Z690-A GAMING WIFI D4"},
-		.sensors = SENSOR_TEMP_T_SENSOR | SENSOR_TEMP_VRM,
-		.mutex_path = ASUS_HW_ACCESS_MUTEX_RMTW_ASMX,
-		.family = family_intel_600_series,
-	},
-	{
-		.board_names = {"ROG ZENITH II EXTREME"},
-		.sensors = SENSOR_SET_TEMP_CHIPSET_CPU_MB | SENSOR_TEMP_T_SENSOR |
-			SENSOR_TEMP_VRM | SENSOR_SET_TEMP_WATER |
-			SENSOR_FAN_CPU_OPT | SENSOR_FAN_CHIPSET | SENSOR_FAN_VRM_HS |
-			SENSOR_FAN_WATER_FLOW | SENSOR_CURR_CPU | SENSOR_IN_CPU_CORE |
-			SENSOR_SET_WATER_BLOCK |
-			SENSOR_TEMP_T_SENSOR_2 | SENSOR_TEMP_SENSOR_EXTRA_1 |
-			SENSOR_TEMP_SENSOR_EXTRA_2 | SENSOR_TEMP_SENSOR_EXTRA_3,
-		.mutex_path = ASUS_HW_ACCESS_MUTEX_SB_PCI0_SBRG_SIO1_MUT0,
-		.family = family_amd_500_series,
-	},
-	{}
+static const struct ec_board_info board_info_prime_x470_pro = {
+	.sensors = SENSOR_SET_TEMP_CHIPSET_CPU_MB |
+		SENSOR_TEMP_T_SENSOR | SENSOR_TEMP_VRM |
+		SENSOR_FAN_CPU_OPT |
+		SENSOR_CURR_CPU | SENSOR_IN_CPU_CORE,
+	.mutex_path = ACPI_GLOBAL_LOCK_PSEUDO_PATH,
+	.family = family_amd_400_series,
+};
+
+static const struct ec_board_info board_info_prime_x570_pro = {
+	.sensors = SENSOR_SET_TEMP_CHIPSET_CPU_MB | SENSOR_TEMP_VRM |
+		SENSOR_TEMP_T_SENSOR | SENSOR_FAN_CHIPSET,
+	.mutex_path = ASUS_HW_ACCESS_MUTEX_ASMX,
+	.family = family_amd_500_series,
+};
+
+static const struct ec_board_info board_info_pro_art_x570_creator_wifi = {
+	.sensors = SENSOR_SET_TEMP_CHIPSET_CPU_MB | SENSOR_TEMP_VRM |
+		SENSOR_TEMP_T_SENSOR | SENSOR_FAN_CPU_OPT |
+		SENSOR_CURR_CPU | SENSOR_IN_CPU_CORE,
+	.family = family_amd_500_series,
+};
+
+static const struct ec_board_info board_info_pro_ws_x570_ace = {
+	.sensors = SENSOR_SET_TEMP_CHIPSET_CPU_MB | SENSOR_TEMP_VRM |
+		SENSOR_TEMP_T_SENSOR | SENSOR_FAN_CHIPSET |
+		SENSOR_CURR_CPU | SENSOR_IN_CPU_CORE,
+	.mutex_path = ASUS_HW_ACCESS_MUTEX_ASMX,
+	.family = family_amd_500_series,
+};
+
+static const struct ec_board_info board_info_crosshair_viii_dark_hero = {
+	.sensors = SENSOR_SET_TEMP_CHIPSET_CPU_MB |
+		SENSOR_TEMP_T_SENSOR |
+		SENSOR_TEMP_VRM | SENSOR_SET_TEMP_WATER |
+		SENSOR_FAN_CPU_OPT | SENSOR_FAN_WATER_FLOW |
+		SENSOR_CURR_CPU | SENSOR_IN_CPU_CORE,
+	.mutex_path = ASUS_HW_ACCESS_MUTEX_ASMX,
+	.family = family_amd_500_series,
+};
+
+static const struct ec_board_info board_info_crosshair_viii_hero = {
+	.sensors = SENSOR_SET_TEMP_CHIPSET_CPU_MB |
+		SENSOR_TEMP_T_SENSOR |
+		SENSOR_TEMP_VRM | SENSOR_SET_TEMP_WATER |
+		SENSOR_FAN_CPU_OPT | SENSOR_FAN_CHIPSET |
+		SENSOR_FAN_WATER_FLOW | SENSOR_CURR_CPU |
+		SENSOR_IN_CPU_CORE,
+	.mutex_path = ASUS_HW_ACCESS_MUTEX_ASMX,
+	.family = family_amd_500_series,
+};
+
+static const struct ec_board_info board_info_maximus_xi_hero = {
+	.sensors = SENSOR_SET_TEMP_CHIPSET_CPU_MB |
+		SENSOR_TEMP_T_SENSOR |
+		SENSOR_TEMP_VRM | SENSOR_SET_TEMP_WATER |
+		SENSOR_FAN_CPU_OPT | SENSOR_FAN_WATER_FLOW,
+	.mutex_path = ASUS_HW_ACCESS_MUTEX_ASMX,
+	.family = family_intel_300_series,
+};
+
+static const struct ec_board_info board_info_crosshair_viii_impact = {
+	.sensors = SENSOR_SET_TEMP_CHIPSET_CPU_MB |
+		SENSOR_TEMP_T_SENSOR | SENSOR_TEMP_VRM |
+		SENSOR_FAN_CHIPSET | SENSOR_CURR_CPU |
+		SENSOR_IN_CPU_CORE,
+	.mutex_path = ASUS_HW_ACCESS_MUTEX_ASMX,
+	.family = family_amd_500_series,
+};
+
+static const struct ec_board_info board_info_strix_b550_e_gaming = {
+	.sensors = SENSOR_SET_TEMP_CHIPSET_CPU_MB |
+		SENSOR_TEMP_T_SENSOR | SENSOR_TEMP_VRM |
+		SENSOR_FAN_CPU_OPT,
+	.mutex_path = ASUS_HW_ACCESS_MUTEX_ASMX,
+	.family = family_amd_500_series,
+};
+
+static const struct ec_board_info board_info_strix_b550_i_gaming = {
+	.sensors = SENSOR_SET_TEMP_CHIPSET_CPU_MB |
+		SENSOR_TEMP_T_SENSOR | SENSOR_TEMP_VRM |
+		SENSOR_FAN_VRM_HS | SENSOR_CURR_CPU |
+		SENSOR_IN_CPU_CORE,
+	.mutex_path = ASUS_HW_ACCESS_MUTEX_ASMX,
+	.family = family_amd_500_series,
+};
+
+static const struct ec_board_info board_info_strix_x570_e_gaming = {
+	.sensors = SENSOR_SET_TEMP_CHIPSET_CPU_MB |
+		SENSOR_TEMP_T_SENSOR | SENSOR_TEMP_VRM |
+		SENSOR_FAN_CHIPSET | SENSOR_CURR_CPU |
+		SENSOR_IN_CPU_CORE,
+	.mutex_path = ASUS_HW_ACCESS_MUTEX_ASMX,
+	.family = family_amd_500_series,
+};
+
+static const struct ec_board_info board_info_strix_x570_e_gaming_wifi_ii = {
+	.sensors = SENSOR_SET_TEMP_CHIPSET_CPU_MB |
+		SENSOR_TEMP_T_SENSOR | SENSOR_CURR_CPU |
+		SENSOR_IN_CPU_CORE,
+	.mutex_path = ASUS_HW_ACCESS_MUTEX_ASMX,
+	.family = family_amd_500_series,
+};
+
+static const struct ec_board_info board_info_strix_x570_f_gaming = {
+	.sensors = SENSOR_SET_TEMP_CHIPSET_CPU_MB |
+		SENSOR_TEMP_T_SENSOR | SENSOR_FAN_CHIPSET,
+	.mutex_path = ASUS_HW_ACCESS_MUTEX_ASMX,
+	.family = family_amd_500_series,
+};
+
+static const struct ec_board_info board_info_strix_x570_i_gaming = {
+	.sensors = SENSOR_TEMP_CHIPSET | SENSOR_TEMP_VRM |
+		SENSOR_TEMP_T_SENSOR |
+		SENSOR_FAN_VRM_HS | SENSOR_FAN_CHIPSET |
+		SENSOR_CURR_CPU | SENSOR_IN_CPU_CORE,
+	.mutex_path = ASUS_HW_ACCESS_MUTEX_ASMX,
+	.family = family_amd_500_series,
+};
+
+static const struct ec_board_info board_info_strix_z690_a_gaming_wifi_d4 = {
+	.sensors = SENSOR_TEMP_T_SENSOR | SENSOR_TEMP_VRM,
+	.mutex_path = ASUS_HW_ACCESS_MUTEX_RMTW_ASMX,
+	.family = family_intel_600_series,
+};
+
+static const struct ec_board_info board_info_zenith_ii_extreme = {
+	.sensors = SENSOR_SET_TEMP_CHIPSET_CPU_MB | SENSOR_TEMP_T_SENSOR |
+		SENSOR_TEMP_VRM | SENSOR_SET_TEMP_WATER |
+		SENSOR_FAN_CPU_OPT | SENSOR_FAN_CHIPSET | SENSOR_FAN_VRM_HS |
+		SENSOR_FAN_WATER_FLOW | SENSOR_CURR_CPU | SENSOR_IN_CPU_CORE |
+		SENSOR_SET_WATER_BLOCK |
+		SENSOR_TEMP_T_SENSOR_2 | SENSOR_TEMP_SENSOR_EXTRA_1 |
+		SENSOR_TEMP_SENSOR_EXTRA_2 | SENSOR_TEMP_SENSOR_EXTRA_3,
+	.mutex_path = ASUS_HW_ACCESS_MUTEX_SB_PCI0_SBRG_SIO1_MUT0,
+	.family = family_amd_500_series,
+};
+
+#define DMI_EXACT_MATCH_ASUS_BOARD_NAME(name, board_info)                      \
+	{                                                                      \
+		.matches = {                                                   \
+			DMI_EXACT_MATCH(DMI_BOARD_VENDOR,                      \
+					"ASUSTeK COMPUTER INC."),              \
+			DMI_EXACT_MATCH(DMI_BOARD_NAME, name),                 \
+		},                                                             \
+		.driver_data = (void *)board_info,                              \
+	}
+
+static const struct dmi_system_id dmi_table[] = {
+	DMI_EXACT_MATCH_ASUS_BOARD_NAME("PRIME X470-PRO",
+					&board_info_prime_x470_pro),
+	DMI_EXACT_MATCH_ASUS_BOARD_NAME("PRIME X570-PRO",
+					&board_info_prime_x570_pro),
+	DMI_EXACT_MATCH_ASUS_BOARD_NAME("ProArt X570-CREATOR WIFI",
+					&board_info_pro_art_x570_creator_wifi),
+	DMI_EXACT_MATCH_ASUS_BOARD_NAME("Pro WS X570-ACE",
+					&board_info_pro_ws_x570_ace),
+	DMI_EXACT_MATCH_ASUS_BOARD_NAME("ROG CROSSHAIR VIII DARK HERO",
+					&board_info_crosshair_viii_dark_hero),
+	DMI_EXACT_MATCH_ASUS_BOARD_NAME("ROG CROSSHAIR VIII FORMULA",
+					&board_info_crosshair_viii_hero),
+	DMI_EXACT_MATCH_ASUS_BOARD_NAME("ROG CROSSHAIR VIII HERO",
+					&board_info_crosshair_viii_hero),
+	DMI_EXACT_MATCH_ASUS_BOARD_NAME("ROG CROSSHAIR VIII HERO (WI-FI)",
+					&board_info_crosshair_viii_hero),
+	DMI_EXACT_MATCH_ASUS_BOARD_NAME("ROG MAXIMUS XI HERO",
+					&board_info_maximus_xi_hero),
+	DMI_EXACT_MATCH_ASUS_BOARD_NAME("ROG MAXIMUS XI HERO (WI-FI)",
+					&board_info_maximus_xi_hero),
+	DMI_EXACT_MATCH_ASUS_BOARD_NAME("ROG CROSSHAIR VIII IMPACT",
+					&board_info_crosshair_viii_impact),
+	DMI_EXACT_MATCH_ASUS_BOARD_NAME("ROG STRIX B550-E GAMING",
+					&board_info_strix_b550_e_gaming),
+	DMI_EXACT_MATCH_ASUS_BOARD_NAME("ROG STRIX B550-I GAMING",
+					&board_info_strix_b550_i_gaming),
+	DMI_EXACT_MATCH_ASUS_BOARD_NAME("ROG STRIX X570-E GAMING",
+					&board_info_strix_x570_e_gaming),
+	DMI_EXACT_MATCH_ASUS_BOARD_NAME("ROG STRIX X570-E GAMING WIFI II",
+					&board_info_strix_x570_e_gaming_wifi_ii),
+	DMI_EXACT_MATCH_ASUS_BOARD_NAME("ROG STRIX X570-F GAMING",
+					&board_info_strix_x570_f_gaming),
+	DMI_EXACT_MATCH_ASUS_BOARD_NAME("ROG STRIX X570-I GAMING",
+					&board_info_strix_x570_i_gaming),
+	DMI_EXACT_MATCH_ASUS_BOARD_NAME("ROG STRIX Z690-A GAMING WIFI D4",
+					&board_info_strix_z690_a_gaming_wifi_d4),
+	DMI_EXACT_MATCH_ASUS_BOARD_NAME("ROG ZENITH II EXTREME",
+					&board_info_zenith_ii_extreme),
+	{},
 };
 
 struct ec_sensor {
@@ -537,12 +577,12 @@ static int find_ec_sensor_index(const struct ec_sensors_data *ec,
 	return -ENOENT;
 }
 
-static int __init bank_compare(const void *a, const void *b)
+static int bank_compare(const void *a, const void *b)
 {
 	return *((const s8 *)a) - *((const s8 *)b);
 }
 
-static void __init setup_sensor_data(struct ec_sensors_data *ec)
+static void setup_sensor_data(struct ec_sensors_data *ec)
 {
 	struct ec_sensor *s = ec->sensors;
 	bool bank_found;
@@ -574,7 +614,7 @@ static void __init setup_sensor_data(struct ec_sensors_data *ec)
 	sort(ec->banks, ec->nr_banks, 1, bank_compare, NULL);
 }
 
-static void __init fill_ec_registers(struct ec_sensors_data *ec)
+static void fill_ec_registers(struct ec_sensors_data *ec)
 {
 	const struct ec_sensor_info *si;
 	unsigned int i, j, register_idx = 0;
@@ -589,7 +629,7 @@ static void __init fill_ec_registers(struct ec_sensors_data *ec)
 	}
 }
 
-static int __init setup_lock_data(struct device *dev)
+static int setup_lock_data(struct device *dev)
 {
 	const char *mutex_path;
 	int status;
@@ -812,7 +852,7 @@ static umode_t asus_ec_hwmon_is_visible(const void *drvdata,
 	return find_ec_sensor_index(state, type, channel) >= 0 ? S_IRUGO : 0;
 }
 
-static int __init
+static int
 asus_ec_hwmon_add_chan_info(struct hwmon_channel_info *asus_ec_hwmon_chan,
 			     struct device *dev, int num,
 			     enum hwmon_sensor_types type, u32 config)
@@ -841,27 +881,15 @@ static struct hwmon_chip_info asus_ec_chip_info = {
 	.ops = &asus_ec_hwmon_ops,
 };
 
-static const struct ec_board_info * __init get_board_info(void)
+static const struct ec_board_info *get_board_info(void)
 {
-	const char *dmi_board_vendor = dmi_get_system_info(DMI_BOARD_VENDOR);
-	const char *dmi_board_name = dmi_get_system_info(DMI_BOARD_NAME);
-	const struct ec_board_info *board;
-
-	if (!dmi_board_vendor || !dmi_board_name ||
-	    strcasecmp(dmi_board_vendor, "ASUSTeK COMPUTER INC."))
-		return NULL;
-
-	for (board = board_info; board->sensors; board++) {
-		if (match_string(board->board_names,
-				 MAX_IDENTICAL_BOARD_VARIATIONS,
-				 dmi_board_name) >= 0)
-			return board;
-	}
+	const struct dmi_system_id *dmi_entry;
 
-	return NULL;
+	dmi_entry = dmi_first_match(dmi_table);
+	return dmi_entry ? dmi_entry->driver_data : NULL;
 }
 
-static int __init asus_ec_probe(struct platform_device *pdev)
+static int asus_ec_probe(struct platform_device *pdev)
 {
 	const struct hwmon_channel_info **ptr_asus_ec_ci;
 	int nr_count[hwmon_max] = { 0 }, nr_types = 0;
@@ -970,29 +998,42 @@ static int __init asus_ec_probe(struct platform_device *pdev)
 	return PTR_ERR_OR_ZERO(hwdev);
 }
 
-
-static const struct acpi_device_id acpi_ec_ids[] = {
-	/* Embedded Controller Device */
-	{ "PNP0C09", 0 },
-	{}
-};
+MODULE_DEVICE_TABLE(dmi, dmi_table);
 
 static struct platform_driver asus_ec_sensors_platform_driver = {
 	.driver = {
 		.name	= "asus-ec-sensors",
-		.acpi_match_table = acpi_ec_ids,
 	},
+	.probe = asus_ec_probe,
 };
 
-MODULE_DEVICE_TABLE(acpi, acpi_ec_ids);
-/*
- * we use module_platform_driver_probe() rather than module_platform_driver()
- * because the probe function (and its dependants) are marked with __init, which
- * means we can't put it into the .probe member of the platform_driver struct
- * above, and we can't mark the asus_ec_sensors_platform_driver object as __init
- * because the object is referenced from the module exit code.
- */
-module_platform_driver_probe(asus_ec_sensors_platform_driver, asus_ec_probe);
+static struct platform_device *asus_ec_sensors_platform_device;
+
+static void cleanup_device(void)
+{
+	platform_device_unregister(asus_ec_sensors_platform_device);
+	platform_driver_unregister(&asus_ec_sensors_platform_driver);
+}
+
+static int __init asus_ec_init(void)
+{
+	asus_ec_sensors_platform_device =
+		platform_create_bundle(&asus_ec_sensors_platform_driver,
+				       asus_ec_probe, NULL, 0, NULL, 0);
+
+	if (IS_ERR(asus_ec_sensors_platform_device))
+		return PTR_ERR(asus_ec_sensors_platform_device);
+
+	return 0;
+}
+
+static void __exit asus_ec_exit(void)
+{
+	cleanup_device();
+}
+
+module_init(asus_ec_init);
+module_exit(asus_ec_exit);
 
 module_param_named(mutex_path, mutex_path_override, charp, 0);
 MODULE_PARM_DESC(mutex_path,
-- 
2.37.3

