Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFE896C8F89
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 17:48:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231392AbjCYQsw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 12:48:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbjCYQsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 12:48:51 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 207CC10411;
        Sat, 25 Mar 2023 09:48:49 -0700 (PDT)
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1679762927;
        bh=Qq2dEAZxs5inqRunjbHlDLyn/FTG4D6cV9cV5iEjKsU=;
        h=From:Date:Subject:To:Cc:From;
        b=VpsCHlYh80S1G0owOzMN3gsXXP/tGSVPzVri9VumyBL56L+CNpyPBPF7K7YLcv9wH
         v8x10nps1SSu5W+E50vj4+myc9DUe3CUSzYg0ffq2QBcDBr+JuEDsJGb+O+fDnsOQI
         rG6bmoqv2HNYasEgriLJaflGmjQzzpeMYT3S7G14=
Date:   Sat, 25 Mar 2023 16:48:43 +0000
Subject: [PATCH RFC] platform/x86: gigabyte-wmi: remove allowlist
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230325-gigabyte-wmi-unrestrict-v1-1-23771309a4d3@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIAOolH2QC/x2NywrCMBAAf6Xs2YU0qUq9Cn6AV/GQxDVdqKlsU
 h+U/ruLxxkYZoFCwlTg0Cwg9OLCU1ZoNw3EwedEyDdlsMY64+wWEycfvpXw/WCcs1CpwrHi3na
 dsya2fb8DrYMvhEF8joP2eR5HlU+hO3/+uwucT0e4rusPYq3Zq4MAAAA=
To:     =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas@weissschuh.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1679762925; l=3196;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=Qq2dEAZxs5inqRunjbHlDLyn/FTG4D6cV9cV5iEjKsU=;
 b=efRnVTEY9ruNvmgje4MxmZDS+bwN8i7sG0H2mI6VCO6N6R50BwnIjbUzd+/YeNqFMW+D5T4kB
 VAVOHecWyiPBKsPXN0gWqYk6vO8B/NJsuT+BpvFXGcweErE35yGD5oh
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Having to maintain a per-system allowlist is burdensome and confusing
for users, drop it.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---

I propose to keep this in -next for two cycles or so to make sure it
does not break anything.
---
 drivers/platform/x86/gigabyte-wmi.c | 40 -------------------------------------
 1 file changed, 40 deletions(-)

diff --git a/drivers/platform/x86/gigabyte-wmi.c b/drivers/platform/x86/gigabyte-wmi.c
index 322cfaeda17b..b0338f043416 100644
--- a/drivers/platform/x86/gigabyte-wmi.c
+++ b/drivers/platform/x86/gigabyte-wmi.c
@@ -13,10 +13,6 @@
 #define GIGABYTE_WMI_GUID	"DEADBEEF-2001-0000-00A0-C90629100000"
 #define NUM_TEMPERATURE_SENSORS	6
 
-static bool force_load;
-module_param(force_load, bool, 0444);
-MODULE_PARM_DESC(force_load, "Force loading on unknown platform");
-
 static u8 usable_sensors_mask;
 
 enum gigabyte_wmi_commandtype {
@@ -133,46 +129,10 @@ static u8 gigabyte_wmi_detect_sensor_usability(struct wmi_device *wdev)
 	return r;
 }
 
-#define DMI_EXACT_MATCH_GIGABYTE_BOARD_NAME(name) \
-	{ .matches = { \
-		DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "Gigabyte Technology Co., Ltd."), \
-		DMI_EXACT_MATCH(DMI_BOARD_NAME, name), \
-	}}
-
-static const struct dmi_system_id gigabyte_wmi_known_working_platforms[] = {
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
-	DMI_EXACT_MATCH_GIGABYTE_BOARD_NAME("B660 GAMING X DDR4"),
-	DMI_EXACT_MATCH_GIGABYTE_BOARD_NAME("B660I AORUS PRO DDR4"),
-	DMI_EXACT_MATCH_GIGABYTE_BOARD_NAME("Z390 I AORUS PRO WIFI-CF"),
-	DMI_EXACT_MATCH_GIGABYTE_BOARD_NAME("Z490 AORUS ELITE AC"),
-	DMI_EXACT_MATCH_GIGABYTE_BOARD_NAME("X570 AORUS ELITE"),
-	DMI_EXACT_MATCH_GIGABYTE_BOARD_NAME("X570 AORUS ELITE WIFI"),
-	DMI_EXACT_MATCH_GIGABYTE_BOARD_NAME("X570 GAMING X"),
-	DMI_EXACT_MATCH_GIGABYTE_BOARD_NAME("X570 I AORUS PRO WIFI"),
-	DMI_EXACT_MATCH_GIGABYTE_BOARD_NAME("X570 UD"),
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
base-commit: 65aca32efdcb0965502d3db2f1fa33838c070952
change-id: 20230325-gigabyte-wmi-unrestrict-7244320c1996

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>

