Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DD247451A8
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jul 2023 21:56:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233111AbjGBT4c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jul 2023 15:56:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233023AbjGBT4D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 15:56:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 014C949E3;
        Sun,  2 Jul 2023 12:54:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AA66F60C91;
        Sun,  2 Jul 2023 19:51:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E2DFC433C8;
        Sun,  2 Jul 2023 19:51:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688327499;
        bh=QktcEbjthSyeHBixXvZ1A8DxQ25bY9Ps1mYspSU5ETA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Wy/S+wRFAwHSvCGuI4bsYbw2C8bStXKSymlp0Vm9fOQ9tosHDTgF6N4npqiX9I0Jy
         a2/SE/ZkUvMPQn2GQ1xnvYzOi4IVfeYgD+U961GyNmOwCSA0TnODrFnW4I5LfHtp1S
         0Gc3aQeAiVfh14JaUYbwkFGNlsaTYMmvs2C9tYXseHij15aXj7iQ7NHkkvbbiz3Dw4
         Pz6mkXOn6+pwtHbFh9atVDxdmStH3KsFR2ljm4HwSXv5OWmdIGgB3JvB6Pmrh7+RyY
         le03WbFX9+jDEKb7BA3VNFrBzERDgRqlICElndz/9LPjnQ8O7o0jHJsBMiTYJE3L8k
         IihKX5Lj81/Cw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Hans de Goede <hdegoede@redhat.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>, rafael@kernel.org,
        mario.limonciello@amd.com, andriy.shevchenko@linux.intel.com,
        mail@mariushoch.de, linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.3 04/11] ACPI: x86: Add ACPI_QUIRK_UART1_SKIP for Lenovo Yoga Book yb1-x90f/l
Date:   Sun,  2 Jul 2023 15:51:20 -0400
Message-Id: <20230702195127.1787911-4-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230702195127.1787911-1-sashal@kernel.org>
References: <20230702195127.1787911-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.3.11
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit f91280f35895d6dcb53f504968fafd1da0b00397 ]

The Lenovo Yoga Book yb1-x90f/l 2-in-1 which ships with Android as
Factory OS has (another) bug in its DSDT where the UART resource for
the BTH0 ACPI device contains "\\_SB.PCIO.URT1" as path to the UART.

Note that is with a letter 'O' instead of the number '0' which is wrong.

This causes Linux to instantiate a standard /dev/ttyS? device for
the UART instead of a /sys/bus/serial device, which in turn causes
bluetooth to not work.

Similar DSDT bugs have been encountered before and to work around those
the acpi_quirk_skip_serdev_enumeration() helper exists.

Previous devices had the broken resource pointing to the first UART, while
the BT HCI was on the second UART, which ACPI_QUIRK_UART1_TTY_UART2_SKIP
deals with. Add a new ACPI_QUIRK_UART1_SKIP quirk for skipping enumeration
of UART1 instead for the Yoga Book case and add this quirk to the
existing DMI quirk table entry for the yb1-x90f/l .

This leaves the UART1 controller unbound allowing the x86-android-tablets
module to manually instantiate a serdev for it fixing bluetooth.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/x86/utils.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/x86/utils.c b/drivers/acpi/x86/utils.c
index 436dccdce8275..2b3e32764a758 100644
--- a/drivers/acpi/x86/utils.c
+++ b/drivers/acpi/x86/utils.c
@@ -249,10 +249,11 @@ bool force_storage_d3(void)
  * drivers/platform/x86/x86-android-tablets.c kernel module.
  */
 #define ACPI_QUIRK_SKIP_I2C_CLIENTS				BIT(0)
-#define ACPI_QUIRK_UART1_TTY_UART2_SKIP				BIT(1)
-#define ACPI_QUIRK_SKIP_ACPI_AC_AND_BATTERY			BIT(2)
-#define ACPI_QUIRK_USE_ACPI_AC_AND_BATTERY			BIT(3)
-#define ACPI_QUIRK_SKIP_GPIO_EVENT_HANDLERS			BIT(4)
+#define ACPI_QUIRK_UART1_SKIP					BIT(1)
+#define ACPI_QUIRK_UART1_TTY_UART2_SKIP				BIT(2)
+#define ACPI_QUIRK_SKIP_ACPI_AC_AND_BATTERY			BIT(3)
+#define ACPI_QUIRK_USE_ACPI_AC_AND_BATTERY			BIT(4)
+#define ACPI_QUIRK_SKIP_GPIO_EVENT_HANDLERS			BIT(5)
 
 static const struct dmi_system_id acpi_quirk_skip_dmi_ids[] = {
 	/*
@@ -309,6 +310,7 @@ static const struct dmi_system_id acpi_quirk_skip_dmi_ids[] = {
 			DMI_EXACT_MATCH(DMI_PRODUCT_VERSION, "YETI-11"),
 		},
 		.driver_data = (void *)(ACPI_QUIRK_SKIP_I2C_CLIENTS |
+					ACPI_QUIRK_UART1_SKIP |
 					ACPI_QUIRK_SKIP_ACPI_AC_AND_BATTERY |
 					ACPI_QUIRK_SKIP_GPIO_EVENT_HANDLERS),
 	},
@@ -439,6 +441,9 @@ int acpi_quirk_skip_serdev_enumeration(struct device *controller_parent, bool *s
 	if (dmi_id)
 		quirks = (unsigned long)dmi_id->driver_data;
 
+	if ((quirks & ACPI_QUIRK_UART1_SKIP) && uid == 1)
+		*skip = true;
+
 	if (quirks & ACPI_QUIRK_UART1_TTY_UART2_SKIP) {
 		if (uid == 1)
 			return -ENODEV; /* Create tty cdev instead of serdev */
-- 
2.39.2

