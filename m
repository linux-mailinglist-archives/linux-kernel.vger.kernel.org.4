Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68CBA6F9B9B
	for <lists+linux-kernel@lfdr.de>; Sun,  7 May 2023 22:45:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232157AbjEGUpv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 May 2023 16:45:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbjEGUpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 May 2023 16:45:49 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF591120BE;
        Sun,  7 May 2023 13:45:43 -0700 (PDT)
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1683492341;
        bh=patFs8wTXMMBz2l3cb0i9Y4TO2h4Wx7Ot9XUJWY2bvw=;
        h=From:Date:Subject:To:Cc:From;
        b=XOZ0755shgO6yqlNBCggMYAvYfcoi2nxMKLLJiUy/iMXsDWVrW3l0U3y5mlP6c9I5
         fENUHgWSqvcmBBsIZk2bXgKXGkuefABgncrwwd6vIIrwOW9TrsDeDnK9eCBu7ayTQH
         dqAInBqdE9lCgeh9Gzd8m6wzK22BTR6hj1+lG+Kk=
Date:   Sun, 07 May 2023 22:45:36 +0200
Subject: [PATCH v2] platform/x86: gigabyte-wmi: remove allowlist
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230325-gigabyte-wmi-unrestrict-v2-1-0a54bc8e70d2@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIAPANWGQC/4WNSw6CMBQAr0K69pl+UIIr72FYlPKkL8Fi+gpIC
 He3cgGXM8lkNsEYCVncik1EnIlpDBn0qRDO29AjUJdZaKmNNPoCPfW2XRPC8iKYQkROkVyCSpe
 l0dKpur6KXLeWEdpog/O5D9MwZPmO+KTPsXs0mT1xGuN63Gf1s/9HswIF2lSVMrK2ZWfuCxIzO
 z/5c8Akmn3fv0gvFNTYAAAA
To:     =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas@weissschuh.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1683492340; l=3727;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=patFs8wTXMMBz2l3cb0i9Y4TO2h4Wx7Ot9XUJWY2bvw=;
 b=CXp+t+4VN1fA3eQ1gi+iorksxh6UyD2VI3amST6XUvqzYGWLd+LV1LjMlLKYEAr9pSkgoBXNL
 IEfKN9SRXstCvMVKMoPdTi3aozNVleLGBRypUrrTJHiQjilxTOnfAN6
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Having to maintain a per-system allowlist is burdensome and confusing
for users, drop it.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Changes in v2:
- Rebase on 6.4-rc1
- Remove RFC status
- Drop #include <linux/dmi.h>
- Link to v1: https://lore.kernel.org/r/20230325-gigabyte-wmi-unrestrict-v1-1-23771309a4d3@weissschuh.net
---

As discussed in v1 this is based on 6.4-rc1.
---
 drivers/platform/x86/gigabyte-wmi.c | 44 -------------------------------------
 1 file changed, 44 deletions(-)

diff --git a/drivers/platform/x86/gigabyte-wmi.c b/drivers/platform/x86/gigabyte-wmi.c
index 2a426040f749..8aa665e866b8 100644
--- a/drivers/platform/x86/gigabyte-wmi.c
+++ b/drivers/platform/x86/gigabyte-wmi.c
@@ -5,7 +5,6 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <linux/acpi.h>
-#include <linux/dmi.h>
 #include <linux/hwmon.h>
 #include <linux/module.h>
 #include <linux/wmi.h>
@@ -13,10 +12,6 @@
 #define GIGABYTE_WMI_GUID	"DEADBEEF-2001-0000-00A0-C90629100000"
 #define NUM_TEMPERATURE_SENSORS	6
 
-static bool force_load;
-module_param(force_load, bool, 0444);
-MODULE_PARM_DESC(force_load, "Force loading on unknown platform");
-
 static u8 usable_sensors_mask;
 
 enum gigabyte_wmi_commandtype {
@@ -133,49 +128,10 @@ static u8 gigabyte_wmi_detect_sensor_usability(struct wmi_device *wdev)
 	return r;
 }
 
-#define DMI_EXACT_MATCH_GIGABYTE_BOARD_NAME(name) \
-	{ .matches = { \
-		DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "Gigabyte Technology Co., Ltd."), \
-		DMI_EXACT_MATCH(DMI_BOARD_NAME, name), \
-	}}
-
-static const struct dmi_system_id gigabyte_wmi_known_working_platforms[] = {
-	DMI_EXACT_MATCH_GIGABYTE_BOARD_NAME("A320M-S2H V2-CF"),
-	DMI_EXACT_MATCH_GIGABYTE_BOARD_NAME("B450M DS3H-CF"),
-	DMI_EXACT_MATCH_GIGABYTE_BOARD_NAME("B450M DS3H WIFI-CF"),
-	DMI_EXACT_MATCH_GIGABYTE_BOARD_NAME("B450M S2H V2"),
-	DMI_EXACT_MATCH_GIGABYTE_BOARD_NAME("B550 AORUS ELITE AX V2"),
-	DMI_EXACT_MATCH_GIGABYTE_BOARD_NAME("B550 AORUS ELITE"),
-	DMI_EXACT_MATCH_GIGABYTE_BOARD_NAME("B550 AORUS ELITE V2"),
-	DMI_EXACT_MATCH_GIGABYTE_BOARD_NAME("B550 GAMING X V2"),
-	DMI_EXACT_MATCH_GIGABYTE_BOARD_NAME("B550I AORUS PRO AX"),
-	DMI_EXACT_MATCH_GIGABYTE_BOARD_NAME("B550M AORUS PRO-P"),
-	DMI_EXACT_MATCH_GIGABYTE_BOARD_NAME("B550M DS3H"),
-	DMI_EXACT_MATCH_GIGABYTE_BOARD_NAME("B650 AORUS ELITE AX"),
-	DMI_EXACT_MATCH_GIGABYTE_BOARD_NAME("B660 GAMING X DDR4"),
-	DMI_EXACT_MATCH_GIGABYTE_BOARD_NAME("B660I AORUS PRO DDR4"),
-	DMI_EXACT_MATCH_GIGABYTE_BOARD_NAME("Z390 I AORUS PRO WIFI-CF"),
-	DMI_EXACT_MATCH_GIGABYTE_BOARD_NAME("Z490 AORUS ELITE AC"),
-	DMI_EXACT_MATCH_GIGABYTE_BOARD_NAME("X570 AORUS ELITE"),
-	DMI_EXACT_MATCH_GIGABYTE_BOARD_NAME("X570 AORUS ELITE WIFI"),
-	DMI_EXACT_MATCH_GIGABYTE_BOARD_NAME("X570 GAMING X"),
-	DMI_EXACT_MATCH_GIGABYTE_BOARD_NAME("X570 I AORUS PRO WIFI"),
-	DMI_EXACT_MATCH_GIGABYTE_BOARD_NAME("X570 UD"),
-	DMI_EXACT_MATCH_GIGABYTE_BOARD_NAME("X570S AORUS ELITE"),
-	DMI_EXACT_MATCH_GIGABYTE_BOARD_NAME("Z690M AORUS ELITE AX DDR4"),
-	{ }
-};
-
 static int gigabyte_wmi_probe(struct wmi_device *wdev, const void *context)
 {
 	struct device *hwmon_dev;
 
-	if (!dmi_check_system(gigabyte_wmi_known_working_platforms)) {
-		if (!force_load)
-			return -ENODEV;
-		dev_warn(&wdev->dev, "Forcing load on unknown platform");
-	}
-
 	usable_sensors_mask = gigabyte_wmi_detect_sensor_usability(wdev);
 	if (!usable_sensors_mask) {
 		dev_info(&wdev->dev, "No temperature sensors usable");

---
base-commit: ac9a78681b921877518763ba0e89202254349d1b
change-id: 20230325-gigabyte-wmi-unrestrict-7244320c1996

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>

