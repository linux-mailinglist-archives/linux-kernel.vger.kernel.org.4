Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DD377451A6
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jul 2023 21:56:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbjGBT4a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jul 2023 15:56:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233067AbjGBTzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 15:55:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 794D649D7;
        Sun,  2 Jul 2023 12:53:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 25EC260C8C;
        Sun,  2 Jul 2023 19:51:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43901C433C7;
        Sun,  2 Jul 2023 19:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688327493;
        bh=+D9RzPYp1mHsuhfCM8ltaJ/I0y2yfeu0a+08T3Ww96A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KPklPD73fyo2L4W2bfI+p2Szt9RR4LQce4y4FvL5dPuaeHbnCeFIgjPLcn0jUL289
         GN4g8WXvX9C6X9o0x1Lc2dVDqNIDzW2JXSllu9QHQlUkYECLpa0Wy4+UFQ73W5InWT
         9GwtFoDE/EtRVLzMzksniRB8B0KsmIz7qyf0dhnPcd1G21eCZR3Ky1ZcNjkLVV1AKB
         IJlsDqRV2C0aAHGxQ2ZR4RZ8xXdhtUoF1iJWn36cmh+VXZAJOHf1TnKhuOaucOxICt
         RJfc7xTVnq6Mmc6COEilX330OcgdAMFvANua/02IJRFt+kJtpxPMeSQbAiFcb7gy+T
         6Y2Tj6C1BykxQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Hans de Goede <hdegoede@redhat.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>, rafael@kernel.org,
        mario.limonciello@amd.com, andriy.shevchenko@linux.intel.com,
        mail@mariushoch.de, linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.3 02/11] ACPI: x86: Add skip i2c clients quirk for Nextbook Ares 8A
Date:   Sun,  2 Jul 2023 15:51:18 -0400
Message-Id: <20230702195127.1787911-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230702195127.1787911-1-sashal@kernel.org>
References: <20230702195127.1787911-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.3.11
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit 69d6b37695c1f2320cfa330e1e1636d50dd5040a ]

The Nextbook Ares 8A is a x86 ACPI tablet which ships with Android x86
as factory OS. Its DSDT contains a bunch of I2C devices which are not
actually there (the Android x86 kernel fork ignores I2C devices described
in the DSDT).

On this specific model this just not cause resource conflicts, one of
the probe() calls for the non existing i2c_clients actually ends up
toggling a GPIO or executing a _PS3 after a failed probe which turns
the tablet off.

Add a ACPI_QUIRK_SKIP_I2C_CLIENTS for the Nextbook Ares 8 to the
acpi_quirk_skip_dmi_ids table to avoid the bogus i2c_clients and
to fix the tablet turning off during boot because of this.

Also add the "10EC5651" HID for the RealTek ALC5651 codec used
in this tablet to the list of HIDs for which not to skipi2c_client
instantiation, since the Intel SST sound driver relies on
the codec being instantiated through ACPI.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/x86/utils.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/x86/utils.c b/drivers/acpi/x86/utils.c
index ba420a28a4aad..436dccdce8275 100644
--- a/drivers/acpi/x86/utils.c
+++ b/drivers/acpi/x86/utils.c
@@ -355,7 +355,7 @@ static const struct dmi_system_id acpi_quirk_skip_dmi_ids[] = {
 					ACPI_QUIRK_SKIP_ACPI_AC_AND_BATTERY),
 	},
 	{
-		/* Nextbook Ares 8 */
+		/* Nextbook Ares 8 (BYT version)*/
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "Insyde"),
 			DMI_MATCH(DMI_PRODUCT_NAME, "M890BAP"),
@@ -364,6 +364,16 @@ static const struct dmi_system_id acpi_quirk_skip_dmi_ids[] = {
 					ACPI_QUIRK_SKIP_ACPI_AC_AND_BATTERY |
 					ACPI_QUIRK_SKIP_GPIO_EVENT_HANDLERS),
 	},
+	{
+		/* Nextbook Ares 8A (CHT version)*/
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Insyde"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "CherryTrail"),
+			DMI_MATCH(DMI_BIOS_VERSION, "M882"),
+		},
+		.driver_data = (void *)(ACPI_QUIRK_SKIP_I2C_CLIENTS |
+					ACPI_QUIRK_SKIP_ACPI_AC_AND_BATTERY),
+	},
 	{
 		/* Whitelabel (sold as various brands) TM800A550L */
 		.matches = {
@@ -382,6 +392,7 @@ static const struct dmi_system_id acpi_quirk_skip_dmi_ids[] = {
 #if IS_ENABLED(CONFIG_X86_ANDROID_TABLETS)
 static const struct acpi_device_id i2c_acpi_known_good_ids[] = {
 	{ "10EC5640", 0 }, /* RealTek ALC5640 audio codec */
+	{ "10EC5651", 0 }, /* RealTek ALC5651 audio codec */
 	{ "INT33F4", 0 },  /* X-Powers AXP288 PMIC */
 	{ "INT33FD", 0 },  /* Intel Crystal Cove PMIC */
 	{ "INT34D3", 0 },  /* Intel Whiskey Cove PMIC */
-- 
2.39.2

