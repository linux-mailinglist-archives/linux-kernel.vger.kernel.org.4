Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E160E7087EB
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 20:39:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbjERSj4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 14:39:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbjERSjt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 14:39:49 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFC1C1B6;
        Thu, 18 May 2023 11:39:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n7TurrjNSA3RbuD9d9YI2xV7Vb7ztGHas1Rxz9YW+VPKk8Y5Z4lnfMt31sKto9a2LDnlJsvjpiBlLW9beiW1l3eZS/ACHkpAxqKvbJUCoe5LQ3+IPbJFa7tO3++mRFd+NjNW+NJn7UMf5kTq5o49Mgepb2JDn3PwpVi54c9tJesZeG1gakwp8+5a7wOVK20Su+vMKAZrCFQ5xt4CtrIh7EwPNX937KnbTaDf4K571Wcu8SrTmkE1G1EGUAxtZtwbwqFpvaGoMbnJS01ckTBfwpBtvP7prk2sdSniE59X+dLUwi0nXbUvyUGwEtpes0Ld2s9tMq97iz5Y0u9uwEDi2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MSuv2rDwlynwTowUfPAdZhpzFsUBXRE7e6RWpNUZ5xY=;
 b=ag4mMKENOSJwNt5fLnKOyGTL70rFp5lCd0KCCfVZsUFhGRs7EvUIOjQE7qid6wxNSVkhPUs/4DSa48ShOSzxgaG/+EKxuehsu26ECW+7GSHvP9qnRCPko+r0YeeGZq++SHPSiWrLBWrPPj1F+FchzXIrCqqYceO6XspAFg+zsmlPyTZyrHoEqesoCf+mMfPehPHQccjB6kJHbEu9AOIQoKkMEV4T8e06uj+fAf2ciSnW7xgNj9Ffv3iW2Dan3udXkS0JzdUoGrVTm1QAbGLeQ6wHuXOMr8QtnyEpyYs8ulVpOQJBX6DCnAJogqFfYSV/UJ9HxOJXx8TL1aApLcPNrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MSuv2rDwlynwTowUfPAdZhpzFsUBXRE7e6RWpNUZ5xY=;
 b=dYJq6bur5lhLtDfCKymeKbzwy32KuIU8lktAoxMpxtLsOgxdWb0GcOP/82+EIEt8A1CTdfuH4Rcu8zkY+gxqTHS/l76e92D4BjjM+tmPWcob6XToQbT9OTjdGOWZGLx/TPyPlez0w3NKem/lbgst6kceY43IbA9JPHYPCSCOy3c=
Received: from BN0PR04CA0132.namprd04.prod.outlook.com (2603:10b6:408:ed::17)
 by CH2PR12MB4939.namprd12.prod.outlook.com (2603:10b6:610:61::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Thu, 18 May
 2023 18:39:45 +0000
Received: from BN8NAM11FT099.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ed:cafe::b5) by BN0PR04CA0132.outlook.office365.com
 (2603:10b6:408:ed::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.19 via Frontend
 Transport; Thu, 18 May 2023 18:39:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT099.mail.protection.outlook.com (10.13.177.197) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.19 via Frontend Transport; Thu, 18 May 2023 18:39:45 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 18 May
 2023 13:39:43 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <rafael@kernel.org>
CC:     <gch981213@gmail.com>, <linux-acpi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <regressions@leemhuis.info>,
        "Mario Limonciello" <mario.limonciello@amd.com>,
        <ofenfisch@googlemail.com>, <wse@tuxedocomputers.com>,
        <adam.niederer@gmail.com>, <adrian@freund.io>,
        <jirislaby@kernel.org>, <Renjith.Pananchikkal@amd.com>,
        <anson.tsao@amd.com>, <Richard.Gong@amd.com>, <evilsnoo@proton.me>,
        <ruinairas1992@gmail.com>
Subject: [PATCH v2] ACPI: resource: Remove "Zen" specific match and quirks
Date:   Thu, 18 May 2023 13:39:20 -0500
Message-ID: <20230518183920.93472-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT099:EE_|CH2PR12MB4939:EE_
X-MS-Office365-Filtering-Correlation-Id: 02612bcb-b8e6-456b-12c1-08db57cf4059
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7v39mg61kyCsRLr1l2HFfu9RC7g3U1MYYHnkT6khr477d/NLAQlxMb5ypbX88V6hmIHWp9UBgA/0xPlM/HtyJ0/O5ISGxerbgC08funznnyb3RMtiRUmD0tEen5nsisNlYkkilG6T4xZDRXpgKd7tIW0P4lUml/dKrOwuU+tBAhALeNcddWISOoDXBSSp93TkaJX2IIJAr/FbkQsEK/J4CVbVLY/sAnBBXIO1Y1uLs06NEUmZdtbnHssYA12YodpdT0U0ErjwSqZQMDpTOKf4kv3WAVBAWRmB+RnJ5FQI5afU/jaDG6WTVLy0MUKH6DXgAaGllRIE2mZpPCffWnSv42c7z5vIEvuExgfM/rShnOwjt9wTaGQjZSUr1sbWd/npxivvqlF5y6wL81cj47qQK6tbhELgdLF7HZ+QdoKN3jD/I5hOm+cIaXdi5uS7F6X7OhoCpCWGmlAFfPmWHqgkkMbfWgukLg88Gtm6cy9uznCeDut0zA0vYjXcAp4pIQVv18af4A7hZD/YrPONeDyOtMHPet0+tHfqcxIDJI6zijwkxtIKXFEZSXiyh2qhnxpKK3OX3HlAHIzoE1ROvJRce5llB9fSVFCMcKQ+0v1Cfhb7mXjfQWaCiavGeoOjf7JV0kmGmGJhc6xtJ8ULV+kULd7jH73y8yEFcD29DkX2A8KUWbdjZwm36ZwaMa66lE6YSrxMQFZ4OLcrk7Z/3tjJ5aZhckpKzgk0KUHW6yxYXLv3EuTCYtVHbCxbQ2t228YEAgH/fwLSn2yKgUNqc4wyVQ1QX5IqoQ7Tn7Fkk6tYjQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(136003)(346002)(39860400002)(451199021)(46966006)(40470700004)(36840700001)(36756003)(478600001)(54906003)(316002)(70206006)(70586007)(4326008)(966005)(6916009)(6666004)(40480700001)(82310400005)(7416002)(8936002)(8676002)(5660300002)(7696005)(2906002)(44832011)(86362001)(41300700001)(81166007)(356005)(82740400003)(2616005)(186003)(1076003)(26005)(336012)(16526019)(426003)(36860700001)(83380400001)(47076005)(66899021)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2023 18:39:45.2014
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 02612bcb-b8e6-456b-12c1-08db57cf4059
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT099.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4939
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 9946e39fe8d0 ("ACPI: resource: skip IRQ override on
AMD Zen platforms") attempted to overhaul the override logic so it
didn't apply on X86 AMD Zen systems.  This was intentional so that
systems would prefer DSDT values instead of default MADT value for
IRQ 1 on Ryzen 6000 systems which use ActiveLow for IRQ1.

This turned out to be a bad assumption because several vendors seem
to add Interrupt Source Override but don't fix the DSDT. A pile of
quirks was collecting that proved this wasn't sustaintable.

Adjust the logic so that only IRQ1 is overridden in Ryzen 6000 case.

This effectively reverts the following commits:
commit 17bb7046e7ce ("ACPI: resource: Do IRQ override on all TongFang
GMxRGxx")
commit f3cb9b740869 ("ACPI: resource: do IRQ override on Lenovo 14ALC7")
commit bfcdf58380b1 ("ACPI: resource: do IRQ override on LENOVO IdeaPad")
commit 7592b79ba4a9 ("ACPI: resource: do IRQ override on XMG Core 15")

Cc: ofenfisch@googlemail.com
Cc: wse@tuxedocomputers.com
Cc: adam.niederer@gmail.com
Cc: adrian@freund.io
Cc: jirislaby@kernel.org
Tested-by: Renjith.Pananchikkal@amd.com
Tested-by: anson.tsao@amd.com
Tested-by: Richard.Gong@amd.com
Tested-by: Chuanhong Guo <gch981213@gmail.com>
Reported-by: evilsnoo@proton.me
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217394
Reported-by: ruinairas1992@gmail.com
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217406
Fixes: 9946e39fe8d0 ("ACPI: resource: skip IRQ override on AMD Zen platforms")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v1->v2:
 * Rebase on 71a485624c4c ("ACPI: resource: Add IRQ override quirk for LG UltraPC 17U70P")
 * Pick up tag
---
 drivers/acpi/resource.c | 154 +++++++++++++++++-----------------------
 1 file changed, 65 insertions(+), 89 deletions(-)

diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index 0800a9d77558..c6ac87e01e1c 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -470,52 +470,6 @@ static const struct dmi_system_id asus_laptop[] = {
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
@@ -527,7 +481,7 @@ static const struct dmi_system_id lg_laptop[] = {
 	{ }
 };
 
-struct irq_override_cmp {
+struct irq_override_dmi_cmp {
 	const struct dmi_system_id *system;
 	unsigned char irq;
 	unsigned char triggering;
@@ -536,50 +490,86 @@ struct irq_override_cmp {
 	bool override;
 };
 
-static const struct irq_override_cmp override_table[] = {
+struct irq_override_acpi_cmp {
+	const char *id;
+	unsigned char irq;
+	unsigned char triggering;
+	unsigned char polarity;
+};
+
+static const struct irq_override_dmi_cmp dmi_override_table[] = {
 	{ medion_laptop, 1, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW, 0, false },
 	{ asus_laptop, 1, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW, 0, false },
-	{ lenovo_laptop, 6, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW, 0, true },
-	{ lenovo_laptop, 10, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW, 0, true },
-	{ tongfang_gm_rg, 1, ACPI_EDGE_SENSITIVE, ACPI_ACTIVE_LOW, 1, true },
-	{ maingear_laptop, 1, ACPI_EDGE_SENSITIVE, ACPI_ACTIVE_LOW, 1, true },
 	{ lg_laptop, 1, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW, 0, false },
 };
 
-static bool acpi_dev_irq_override(u32 gsi, u8 triggering, u8 polarity,
-				  u8 shareable)
+/*
+ * Ryzen 6000 requires ActiveLow for keyboard, but a number of machines
+ * seem to get it wrong in DSDT or don't have an Interrupt Source
+ * Override.
+ */
+static const struct irq_override_acpi_cmp acpi_override_table[] = {
+	{ "AMDI0007", 1, ACPI_EDGE_SENSITIVE, ACPI_ACTIVE_LOW },
+};
+
+static void acpi_dev_irq_override(u32 gsi, u8 *triggering, u8 *polarity,
+				  u8 *shareable)
 {
-	int i;
+	int i, p, t;
+	int check_override = true;
 
-	for (i = 0; i < ARRAY_SIZE(override_table); i++) {
-		const struct irq_override_cmp *entry = &override_table[i];
+	for (i = 0; i < ARRAY_SIZE(dmi_override_table); i++) {
+		const struct irq_override_dmi_cmp *entry = &dmi_override_table[i];
 
 		if (dmi_check_system(entry->system) &&
 		    entry->irq == gsi &&
-		    entry->triggering == triggering &&
-		    entry->polarity == polarity &&
-		    entry->shareable == shareable)
-			return entry->override;
+		    entry->triggering == *triggering &&
+		    entry->polarity == *polarity &&
+		    entry->shareable == *shareable)
+			check_override = entry->override;
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
+	if (!check_override)
+		return;
 
-	return true;
+	if (!acpi_get_override_irq(gsi, &t, &p)) {
+		u8 trig = t ? ACPI_LEVEL_SENSITIVE : ACPI_EDGE_SENSITIVE;
+		u8 pol = p ? ACPI_ACTIVE_LOW : ACPI_ACTIVE_HIGH;
+
+		if (*triggering != trig || *polarity != pol) {
+			pr_warn("ACPI: IRQ %d override to %s%s, %s%s\n", gsi,
+				t ? "level" : "edge",
+				trig == *triggering ? "" : "(!)",
+				p ? "low" : "high",
+				pol == *polarity ? "" : "(!)");
+			*triggering = trig;
+			*polarity = pol;
+		}
+	}
+
+	for (i = 0; i < ARRAY_SIZE(acpi_override_table); i++) {
+		const struct irq_override_acpi_cmp *entry = &acpi_override_table[i];
+
+		if (acpi_dev_found(entry->id) && gsi == entry->irq &&
+		   (*polarity != entry->polarity || *triggering != entry->triggering)) {
+			pr_warn("ACPI: IRQ %d override to %s%s, %s%s due to %s\n",
+				gsi,
+				entry->triggering ? "level" : "edge",
+				entry->triggering == *triggering ? "" : "(!)",
+				entry->polarity ? "low" : "high",
+				entry->polarity == *polarity ? "" : "(!)",
+				entry->id);
+			*polarity = entry->polarity;
+			*triggering = entry->triggering;
+		}
+	}
 }
 
 static void acpi_dev_get_irqresource(struct resource *res, u32 gsi,
 				     u8 triggering, u8 polarity, u8 shareable,
 				     u8 wake_capable, bool check_override)
 {
-	int irq, p, t;
+	int irq;
 
 	if (!valid_IRQ(gsi)) {
 		irqresource_disabled(res, gsi);
@@ -592,26 +582,12 @@ static void acpi_dev_get_irqresource(struct resource *res, u32 gsi,
 	 * 2. BIOS uses IO-APIC mode Interrupt Source Override
 	 *
 	 * We do this only if we are dealing with IRQ() or IRQNoFlags()
-	 * resource (the legacy ISA resources). With modern ACPI 5 devices
+	 * resource (the legacy ISA resources). With ACPI devices
 	 * using extended IRQ descriptors we take the IRQ configuration
 	 * from _CRS directly.
 	 */
-	if (check_override &&
-	    acpi_dev_irq_override(gsi, triggering, polarity, shareable) &&
-	    !acpi_get_override_irq(gsi, &t, &p)) {
-		u8 trig = t ? ACPI_LEVEL_SENSITIVE : ACPI_EDGE_SENSITIVE;
-		u8 pol = p ? ACPI_ACTIVE_LOW : ACPI_ACTIVE_HIGH;
-
-		if (triggering != trig || polarity != pol) {
-			pr_warn("ACPI: IRQ %d override to %s%s, %s%s\n", gsi,
-				t ? "level" : "edge",
-				trig == triggering ? "" : "(!)",
-				p ? "low" : "high",
-				pol == polarity ? "" : "(!)");
-			triggering = trig;
-			polarity = pol;
-		}
-	}
+	if (check_override)
+		acpi_dev_irq_override(gsi, &triggering, &polarity, &shareable);
 
 	res->flags = acpi_dev_irq_flags(triggering, polarity, shareable, wake_capable);
 	irq = acpi_register_gsi(NULL, gsi, triggering, polarity);

base-commit: c554eee18c9a440bd2dd5a363b0f79325717f0bf
-- 
2.34.1

