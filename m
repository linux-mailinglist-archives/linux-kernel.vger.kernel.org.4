Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE237703FEF
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 23:38:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245609AbjEOVih (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 17:38:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245323AbjEOVie (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 17:38:34 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2044.outbound.protection.outlook.com [40.107.94.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE72B106CD;
        Mon, 15 May 2023 14:38:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AzHFmA9r+AhPR6qYcSp9HTa/vN6rNAQbPUmHB+NWdPd9YpRP7IzHSWRSVQ5RHeyKbBd91ndZZNg/xDMfM7g0RsXO7pDWrVToYwyMAIxqUluLJDMHnRaTEwHy6wu55eVWQ5C5xAdrNsoprN3if42KXgfd2ZQj/JBZ+NCKzIXDs4GMZX2w6sESnLPf1n2eowW+Xht/B5bHEmf/zVUTVo6iVEbtte6wRru++E/R4gXWj/rKGnMxaHjpWPkFjXOCyzppRxG+12f1r0BGD+9eDuiw7yI1dX/kZc9pFhciPuZ8LQiMEcrXTIrom/FWw4UYoWUUsikiY7nUgpHmz2gR/pUdAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0aADnmxmEhPtbjYc4uOz1eZbW6ESSJQPiyNcopcba0k=;
 b=Ys5+uvb0PrQwrGVw5Y3DSvoDeFZrCwXSMHogAXqhHCjiCN4U0Zys8U36kKc0ArQid59RJ2JhjPIUDDYoMI9CEirsqTIsX/FfJX/ijqnE2pnUNjUiNk03gMmnMLvUVB7HQG4DZPFLuH5ex8cSDRcFOCzi1d9vcZUczSvWDQHrJwVATDrsHjAjKeqFfVVamrhQC5IB4SWdFAEztPw9ZuOMO4ru+EVFpcNay6uO/2cGz6A9LzKwfGYV8SiQ2NRttNtvjSuh7AeRAAeQQmmmFGoBlnLcai1WCE2eL84XFk22noAwlDNdsyg5HGToMr5bcSSd0uW7UZgBvIsoaGouPuZNiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0aADnmxmEhPtbjYc4uOz1eZbW6ESSJQPiyNcopcba0k=;
 b=mqTRa0NUv1GfTdIGQCW9vbeoQNalmKyk0dSOcUQ/1djFWitwO3JxpiyuJ+rZ5XMxxfXca1BglcM3g2BngioCqU270JmvmIrwVgUr/bfSts48a7H+dW2LQzEcz1nJYj/+VGtMgshXO9+raYrDho7a/XaK+khkhVh74aCeE44r+qg=
Received: from BN0PR02CA0030.namprd02.prod.outlook.com (2603:10b6:408:e4::35)
 by SJ2PR12MB9008.namprd12.prod.outlook.com (2603:10b6:a03:543::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Mon, 15 May
 2023 21:38:29 +0000
Received: from BN8NAM11FT077.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e4:cafe::d9) by BN0PR02CA0030.outlook.office365.com
 (2603:10b6:408:e4::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.31 via Frontend
 Transport; Mon, 15 May 2023 21:38:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT077.mail.protection.outlook.com (10.13.177.232) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.15 via Frontend Transport; Mon, 15 May 2023 21:38:28 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 15 May
 2023 16:38:26 -0500
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
Subject: [PATCH] ACPI: resource: Remove "Zen" specific match and quirks
Date:   Mon, 15 May 2023 16:38:22 -0500
Message-ID: <20230515213822.1277-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT077:EE_|SJ2PR12MB9008:EE_
X-MS-Office365-Filtering-Correlation-Id: d95879fa-f7a2-4729-cedb-08db558cb8dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i6e5jtgWa67245p8BkulsTXjIkWzMb/TH+b3zuvRGMv/7VX9v5WpwKHd0yHGtSgBdnGDwlGmD38CULkHWor2ADn4nRt8uUfiErVx71N02olElQHqSwhh8UGU4dHUYW9VxKg7Efoz+9H1wA4MXhJvurR9kPAkgFvyIMlkRReScKDVq0q5Ozm3p7/dpJlGKDBadWlTXejvVyhNuropA884tNYsI4pkdKkhzi5AA+es5bnd5lWoJpFfbwVw5eRRB85b6Q/DwOINaf+AShz/BmBre0Lwvi/nRc8NtSQ3TWR2QpSI0hLi+0FMNNZIFWGTGcOag5CPLcNH71y2a8apKnh9M7tq5rG/KKs4L03jfkAWz9qygeq1qc0pHS3dWUSxh9VDPJx11esbyBJucETYH1bij8DzNXvlFJR4nRn5lhwd1zjDAXNf6Qc9jszuI2L9/O9o8YukdEXwXnSgdCOY9mw35ljzntygxMndY65+6M2JkeV4ud7xekiAUTUK1GcAwQVIdJwL5IwZTLutE7cGjw0tATD/lvbBDdeGcKjcDVXFCF2EEYgRlG5cVuLrQBDINIqERykU3pd3dLVpBxphIk8trmyKimNrwlOpmz51zYOGVubgUBo7+8HSHUamxoLxsQysGOsmIgcvV8EbOQgI1DhqM0ZzRUThWqFgzW4dgnM29mTVFRPcV5PVqqKCh7nDGsVEpxaJwkTWCZTEC5b3Q4z3etFiYji7w+y4Va8igUl7o1/7QOkfPbpASarQHOgWJQqKBLhe5uBtOcUiy22RVXC1k6JWSzv9j3E3ueDLAN2+Rxo=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(346002)(376002)(396003)(451199021)(40470700004)(46966006)(36840700001)(66899021)(26005)(478600001)(1076003)(40460700003)(966005)(7696005)(40480700001)(6916009)(6666004)(36756003)(82740400003)(4326008)(70206006)(70586007)(41300700001)(356005)(316002)(81166007)(36860700001)(426003)(336012)(86362001)(47076005)(2906002)(83380400001)(82310400005)(44832011)(8676002)(5660300002)(7416002)(8936002)(186003)(16526019)(2616005)(54906003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2023 21:38:28.8071
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d95879fa-f7a2-4729-cedb-08db558cb8dd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT077.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9008
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
Cc: gch981213@gmail.com
Cc: wse@tuxedocomputers.com
Cc: adam.niederer@gmail.com
Cc: adrian@freund.io
Cc: jirislaby@kernel.org
Tested-by: Renjith.Pananchikkal@amd.com
Tested-by: anson.tsao@amd.com
Tested-by: Richard.Gong@amd.com
Reported-by: evilsnoo@proton.me
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217394
Reported-by: ruinairas1992@gmail.com
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217406
Fixes: 9946e39fe8d0 ("ACPI: resource: skip IRQ override on AMD Zen platforms")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/acpi/resource.c | 154 +++++++++++++++++-----------------------
 1 file changed, 65 insertions(+), 89 deletions(-)

diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index e8492b3a393a..828adb4be721 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -470,53 +470,7 @@ static const struct dmi_system_id asus_laptop[] = {
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
-struct irq_override_cmp {
+struct irq_override_dmi_cmp {
 	const struct dmi_system_id *system;
 	unsigned char irq;
 	unsigned char triggering;
@@ -525,49 +479,85 @@ struct irq_override_cmp {
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
@@ -580,26 +570,12 @@ static void acpi_dev_get_irqresource(struct resource *res, u32 gsi,
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
-- 
2.34.1

