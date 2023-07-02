Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BF5F7451EA
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jul 2023 21:59:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbjGBT7O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jul 2023 15:59:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233295AbjGBT6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 15:58:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7350E72;
        Sun,  2 Jul 2023 12:55:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BE0AF60D33;
        Sun,  2 Jul 2023 19:52:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6086C433CB;
        Sun,  2 Jul 2023 19:52:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688327551;
        bh=3oBo9b4OOMDk8OZgtBNz38WSFFZGUZPGHvKC7GUR0+I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kYs5lENvrkIufYtxuJbQg4EQLmyF5TIAmarKlNxjf8LpbGJpRqCzlnvECXmP6i+XH
         nYKEq7nCxqMOud3biD1FOBUsSqfZ9CgD8nVo2v/DC5upXJpgBC4O4798AjUKW5hGi/
         x6OWFhYJCHmOg0khH9LhcrAOQ8qFGIjjGqY5yW4HwTSwhtwi/aMmywFaS84rZykkJG
         rXdipoC1esuq9jVWlkBnzI5J9tbojGNoGuimPlNQUvj2uEJq5IQOypA66Gr3Bj1brI
         T1GawYhVla5Jd+FLRM69ZxZc9+Kp+IqVsnH5W/bAe5aQBM+Vf99wSsDlkKcZkqlHN4
         moVNf4Ftp26EA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Mario Limonciello <mario.limonciello@amd.com>, evilsnoo@proton.me,
        ruinairas1992@gmail.com, nmschulte@gmail.com,
        Werner Sembach <wse@tuxedocomputers.com>,
        Chuanhong Guo <gch981213@gmail.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>, rafael@kernel.org,
        linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 4/6] ACPI: resource: Remove "Zen" specific match and quirks
Date:   Sun,  2 Jul 2023 15:52:21 -0400
Message-Id: <20230702195223.1788563-4-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230702195223.1788563-1-sashal@kernel.org>
References: <20230702195223.1788563-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.119
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

From: Mario Limonciello <mario.limonciello@amd.com>

[ Upstream commit a9c4a912b7dc7ff922d4b9261160c001558f9755 ]

commit 9946e39fe8d0 ("ACPI: resource: skip IRQ override on
AMD Zen platforms") attempted to overhaul the override logic so it
didn't apply on X86 AMD Zen systems.  This was intentional so that
systems would prefer DSDT values instead of default MADT value for
IRQ 1 on Ryzen 6000 systems which typically uses ActiveLow for IRQ1.

This turned out to be a bad assumption because several vendors
add Interrupt Source Override but don't fix the DSDT. A pile of
quirks was collecting that proved this wasn't sustaintable.

Furthermore some vendors have used ActiveHigh for IRQ1.
To solve this problem revert the following commits:
* commit 17bb7046e7ce ("ACPI: resource: Do IRQ override on all TongFang
GMxRGxx")
* commit f3cb9b740869 ("ACPI: resource: do IRQ override on Lenovo 14ALC7")
* commit bfcdf58380b1 ("ACPI: resource: do IRQ override on LENOVO IdeaPad")
* commit 7592b79ba4a9 ("ACPI: resource: do IRQ override on XMG Core 15")
* commit 9946e39fe8d0 ("ACPI: resource: skip IRQ override on AMD Zen
platforms")

Reported-by: evilsnoo@proton.me
Link: https://bugzilla.kernel.org/show_bug.cgi?id=217394
Reported-by: ruinairas1992@gmail.com
Link: https://bugzilla.kernel.org/show_bug.cgi?id=217406
Reported-by: nmschulte@gmail.com
Link: https://bugzilla.kernel.org/show_bug.cgi?id=217336
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Tested-by: Werner Sembach <wse@tuxedocomputers.com>
Tested-by: Chuanhong Guo <gch981213@gmail.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/resource.c | 60 -----------------------------------------
 1 file changed, 60 deletions(-)

diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index b0c7ae50a8d79..1ea1c419d3316 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -424,52 +424,6 @@ static const struct dmi_system_id asus_laptop[] = {
 	{ }
 };
 
-static const struct dmi_system_id lenovo_laptop[] = {
-	{
-		.ident = "LENOVO IdeaPad Flex 5 14ALC7",
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "82R9"),
-		},
-	},
-	{
-		.ident = "LENOVO IdeaPad Flex 5 16ALC7",
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "82RA"),
-		},
-	},
-	{ }
-};
-
-static const struct dmi_system_id tongfang_gm_rg[] = {
-	{
-		.ident = "TongFang GMxRGxx/XMG CORE 15 (M22)/TUXEDO Stellaris 15 Gen4 AMD",
-		.matches = {
-			DMI_MATCH(DMI_BOARD_NAME, "GMxRGxx"),
-		},
-	},
-	{ }
-};
-
-static const struct dmi_system_id maingear_laptop[] = {
-	{
-		.ident = "MAINGEAR Vector Pro 2 15",
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Micro Electronics Inc"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "MG-VCP2-15A3070T"),
-		}
-	},
-	{
-		.ident = "MAINGEAR Vector Pro 2 17",
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Micro Electronics Inc"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "MG-VCP2-17A3070T"),
-		},
-	},
-	{ }
-};
-
 static const struct dmi_system_id lg_laptop[] = {
 	{
 		.ident = "LG Electronics 17U70P",
@@ -493,10 +447,6 @@ struct irq_override_cmp {
 static const struct irq_override_cmp override_table[] = {
 	{ medion_laptop, 1, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW, 0, false },
 	{ asus_laptop, 1, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW, 0, false },
-	{ lenovo_laptop, 6, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW, 0, true },
-	{ lenovo_laptop, 10, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW, 0, true },
-	{ tongfang_gm_rg, 1, ACPI_EDGE_SENSITIVE, ACPI_ACTIVE_LOW, 1, true },
-	{ maingear_laptop, 1, ACPI_EDGE_SENSITIVE, ACPI_ACTIVE_LOW, 1, true },
 	{ lg_laptop, 1, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW, 0, false },
 };
 
@@ -516,16 +466,6 @@ static bool acpi_dev_irq_override(u32 gsi, u8 triggering, u8 polarity,
 			return entry->override;
 	}
 
-#ifdef CONFIG_X86
-	/*
-	 * IRQ override isn't needed on modern AMD Zen systems and
-	 * this override breaks active low IRQs on AMD Ryzen 6000 and
-	 * newer systems. Skip it.
-	 */
-	if (boot_cpu_has(X86_FEATURE_ZEN))
-		return false;
-#endif
-
 	return true;
 }
 
-- 
2.39.2

