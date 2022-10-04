Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 987965F40DF
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 12:33:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbiJDKdw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 06:33:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbiJDKdt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 06:33:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E5E147BAE;
        Tue,  4 Oct 2022 03:33:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C77A8B819A2;
        Tue,  4 Oct 2022 10:33:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33B86C433D6;
        Tue,  4 Oct 2022 10:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664879625;
        bh=XRG5jiEdp+ApFkASJ+vUHOoQYt1GREQ6VBKWpfYxdr0=;
        h=From:To:Cc:Subject:Date:From;
        b=OVwlMLh7arbdUxcDybNlv/kRDl4rFEi9ET/LlYSW255UO6WhRPiqs6R0lFKB5yzWS
         fbK7duAM9pZ0+i9G+jlwXWVHZn96vj6EjgNBAIQmy1Ocq+GGgthx1JbglTwQN5GVvL
         axQLp9tM94Nu3o1QAX1Ih9HfPoDlta+XfiY91uA1XB8k0TsCgNEY+w4yvGEQOJKJy3
         8yeHkC5DhJgEKiD1mjAx/yrw0Q9PvgcyEUHTHwi6cQtJkNrDVD4htkfmx8Yz/WXKkl
         LGB54ln2ojk2TWYprUG3wZpe4fV2jGIIu/3Byfx/roBp9sy9ImicSJxDZvrQ89Ga7D
         j+flN4kFPGl7Q==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     rafael.j.wysocki@intel.com
Cc:     linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        Chuanhong Guo <gch981213@gmail.com>,
        Tighe Donnelly <tighe.donnelly@protonmail.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Fridrich Strba <fstrba@suse.com>
Subject: [PATCH 1/2] ACPI: resource: do IRQ override on LENOVO IdeaPad
Date:   Tue,  4 Oct 2022 12:33:40 +0200
Message-Id: <20221004103341.12646-1-jirislaby@kernel.org>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LENOVO IdeaPad Flex 5 is ryzen-5 based and the commit below removed IRQ
overriding for those. This broke touchscreen and trackpad:
 i2c_designware AMDI0010:00: controller timed out
 i2c_designware AMDI0010:03: controller timed out
 i2c_hid_acpi i2c-MSFT0001:00: failed to reset device: -61
 i2c_designware AMDI0010:03: controller timed out
 ...
 i2c_hid_acpi i2c-MSFT0001:00: can't add hid device: -61
 i2c_hid_acpi: probe of i2c-MSFT0001:00 failed with error -61

White-list this specific model in the override_table.

For this to work, the ZEN test needs to be put below the table walk.

Fixes: 37c81d9f1d1b (ACPI: resource: skip IRQ override on AMD Zen platforms)
Link: https://bugzilla.suse.com/show_bug.cgi?id=1203794
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org
Cc: Chuanhong Guo <gch981213@gmail.com>
Cc: Tighe Donnelly <tighe.donnelly@protonmail.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Fridrich Strba <fstrba@suse.com>
Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/acpi/resource.c | 42 +++++++++++++++++++++++++++--------------
 1 file changed, 28 insertions(+), 14 deletions(-)

diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index 514d89656dde..8d13e94bb921 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -424,17 +424,31 @@ static const struct dmi_system_id asus_laptop[] = {
 	{ }
 };
 
+static const struct dmi_system_id lenovo_82ra[] = {
+	{
+		.ident = "LENOVO IdeaPad Flex 5 16ALC7",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "82RA"),
+		},
+	},
+	{ }
+};
+
 struct irq_override_cmp {
 	const struct dmi_system_id *system;
 	unsigned char irq;
 	unsigned char triggering;
 	unsigned char polarity;
 	unsigned char shareable;
+	bool override;
 };
 
-static const struct irq_override_cmp skip_override_table[] = {
-	{ medion_laptop, 1, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW, 0 },
-	{ asus_laptop, 1, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW, 0 },
+static const struct irq_override_cmp override_table[] = {
+	{ medion_laptop, 1, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW, 0, false },
+	{ asus_laptop, 1, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW, 0, false },
+	{ lenovo_82ra, 6, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW, 0, true },
+	{ lenovo_82ra, 10, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW, 0, true },
 };
 
 static bool acpi_dev_irq_override(u32 gsi, u8 triggering, u8 polarity,
@@ -442,6 +456,17 @@ static bool acpi_dev_irq_override(u32 gsi, u8 triggering, u8 polarity,
 {
 	int i;
 
+	for (i = 0; i < ARRAY_SIZE(override_table); i++) {
+		const struct irq_override_cmp *entry = &override_table[i];
+
+		if (dmi_check_system(entry->system) &&
+		    entry->irq == gsi &&
+		    entry->triggering == triggering &&
+		    entry->polarity == polarity &&
+		    entry->shareable == shareable)
+			return entry->override;
+	}
+
 #ifdef CONFIG_X86
 	/*
 	 * IRQ override isn't needed on modern AMD Zen systems and
@@ -452,17 +477,6 @@ static bool acpi_dev_irq_override(u32 gsi, u8 triggering, u8 polarity,
 		return false;
 #endif
 
-	for (i = 0; i < ARRAY_SIZE(skip_override_table); i++) {
-		const struct irq_override_cmp *entry = &skip_override_table[i];
-
-		if (dmi_check_system(entry->system) &&
-		    entry->irq == gsi &&
-		    entry->triggering == triggering &&
-		    entry->polarity == polarity &&
-		    entry->shareable == shareable)
-			return false;
-	}
-
 	return true;
 }
 
-- 
2.37.3

