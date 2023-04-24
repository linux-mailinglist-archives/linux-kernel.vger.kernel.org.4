Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AE7D6ED5B5
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 21:57:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232611AbjDXT5c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 15:57:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231503AbjDXT5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 15:57:22 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2086.outbound.protection.outlook.com [40.107.96.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E77D93FC;
        Mon, 24 Apr 2023 12:56:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oJi+AiCvMFLJHbLcBv3quKLtqfgrWaVvN2AYhl8MRNOMrBrf7T0veI1xYlmB+B8vYYd0t2cK3B2KGmsHn9EGkCuRaVd716EdwA1+g4nfaHtPHcKrOvieUTPXZcDhgMqGThehMkB2nHIKiVswTkm5mEg8EqRoCPMXV/IUalVxnNeE9haGyH0xCfPjdwxvg4iHhhZsAuyG9TIpIlPm3j7xrdWsmcjFpZ0hBnXLEaZCrewEqpyuNXpafzNxsaFiq3g5LTMsNTjfPXJ/zF+DbXBGXspG/zwDQ80BdhYotzdzTF6k99pv1yFVCa0IxP3rBsIGwvtTvnrAcWm7gBOooDWdIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OrEn9jcLoEOY+A/OrTjHhAyoR4kJFpFC+UiWLYgBbKU=;
 b=lqRz+dbX/1EOH/JpJ/Oq+xE7Plvk7nX/HrSFRJtum5cnDHX02dUJUIwgMU8/qFT2dzDclximF1HA63ZyQVjBTpMjRl2KgMaxtSj2Ik6gCgPXPFcwOacxHVkJmByXKnwbs4Lb4xNo2lWNTgwE4yoJw7xz/gBnyO8NzjeWGbmmwYX3FVkb2HTTWsDFiFOXYxeJ6XEvFaEbOCtaD3+ktMr4c1o8rJQsSLbzqPgN4cPHwbpxN8ES93qFIa9fgiAMeEAa/sE1olOHo4fqeIafa+ET1T3bg1JIaigXS1efq9NkeI7S+utdrw8jhzweQIPBTlLunzNflpi/T7KRwNXUZv4FBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OrEn9jcLoEOY+A/OrTjHhAyoR4kJFpFC+UiWLYgBbKU=;
 b=ihKlz6e6q5/m80J71R4fGgxBljJ/WsSnUHMi0OlO9bqM0ZQP2qrgPsTUyzdoinP9J6tFpYaXPoifqYbJC29oVcWDf8BcMUcWV3maRBpZ1ZSvm69Ro1UM4Off4f5LKtOAjF7hVTcvUCY3+nZasv7Q8ZQoZYsyvKnkKmk7eko93dY=
Received: from CY5PR15CA0175.namprd15.prod.outlook.com (2603:10b6:930:81::20)
 by MW4PR12MB7465.namprd12.prod.outlook.com (2603:10b6:303:212::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Mon, 24 Apr
 2023 19:56:18 +0000
Received: from CY4PEPF0000C96C.namprd02.prod.outlook.com
 (2603:10b6:930:81:cafe::1e) by CY5PR15CA0175.outlook.office365.com
 (2603:10b6:930:81::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33 via Frontend
 Transport; Mon, 24 Apr 2023 19:56:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000C96C.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6340.15 via Frontend Transport; Mon, 24 Apr 2023 19:56:17 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 24 Apr
 2023 14:56:16 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>
CC:     S Sanath <Sanath.S@amd.com>, <richard.gong@amd.com>,
        <Sanju.Mehta@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 2/2] thunderbolt: Move Intel quirks into quirks.c
Date:   Mon, 24 Apr 2023 14:55:55 -0500
Message-ID: <20230424195556.2233-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230424195556.2233-1-mario.limonciello@amd.com>
References: <20230424195556.2233-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000C96C:EE_|MW4PR12MB7465:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f9ac921-f49f-49bd-f2e3-08db44fdf7e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7d02/Lz2vVv8mzFBjMxrfCvas2oA7eiGuigvHgO2D0+XP0sWtwJPy42hhEYeeVHaoDZNYAGY3saaNuE2k3SpSHzW8bJk8PUysAHPBGpcIDlCC3jinsSK+G2fownV3NyC4VN2ipsIjSCyqsRK6i0z0+ZR/wHm9J4OXSrxIZpLGR6rXfpcEOWIRRFmdvAnOjzHg+JX+nMujJES2RYn3/5GxnD6gQcZ/m92R8K9syf9m51zd4XWjm+D+SJDkZuAftVRUquEq5lz3+5B2ANq4AtKLzx62wz1FW9FTSFtxJkF49256w3hI+8U52KSoc5CD6Gj2DOyUKGb/dHZ3EBaEw5G4t3UwQnIhe3UvoyqO2T1l/jDQgOfhh9QHF4eV3CqbZEH+12PrMIR8j+LIpACP7WLzzbN9IPvE50QykaxOxkpuLaM9i1zuicsCAUzYZXRaSToVcV2xXcsjmeeWk1UpCiuWW2HCsZeFXskt5QmirSTl8Ce+JVUjKPfN9YLhK+O9JFUI8vUB0rso2dE038ExDp0Izf3GOEA5hq8QLu9H67PHUc8jPEymC3pyenu1GxFusNOScogIFY2egmMsXx0iZFmxzyElowzu76ityq4cEkedof7TYqgZrAV1TlUXm60P28lMgEInP46hJegPZvIAXRSl4e0HFNEw5Q8VoJVaIWbOaItRCGem/6W2AMg02+CDklzivXPTLr6H4St7V4PzQI7b6DFAIMagQVCOfuPNHMILoo=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(39860400002)(376002)(346002)(451199021)(36840700001)(40470700004)(46966006)(26005)(1076003)(40480700001)(336012)(426003)(2616005)(36756003)(83380400001)(36860700001)(47076005)(186003)(16526019)(40460700003)(356005)(82740400003)(81166007)(70206006)(478600001)(86362001)(84970400001)(70586007)(8676002)(8936002)(54906003)(44832011)(110136005)(5660300002)(7696005)(2906002)(41300700001)(82310400005)(4326008)(6666004)(316002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2023 19:56:17.8223
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f9ac921-f49f-49bd-f2e3-08db44fdf7e2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000C96C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7465
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are two Intel specific quirks for auto clear and end to end
that are not specified in the quirks file.  Move them to this location
instead.

This does change it so that they're initialized at a different time,
than quirks currently run but no intended functional impacts.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v1->v2:
 * New patch

I tried to base this off thunderbolt.git/next (tag: thunderbolt-for-v6.4-rc1)
but the following 2 commits are missing from that branch but are in 6.3-rc7:

7af9da8ce8f9 ("thunderbolt: Add quirk to disable CLx")
f0a57dd33b3e ("thunderbolt: Limit USB3 bandwidth of certain Intel USB4 host routers")

I cherry picked them first as this patch builds on them. It's expected that
this patch should apply on top of 6.4-rc1 properly.

I don't have the matching hardware so this patch is only compile tested.
---
 drivers/thunderbolt/nhi.c    | 27 ---------------------------
 drivers/thunderbolt/quirks.c | 27 +++++++++++++++++++++++++++
 drivers/thunderbolt/tb.h     |  4 ++++
 3 files changed, 31 insertions(+), 27 deletions(-)

diff --git a/drivers/thunderbolt/nhi.c b/drivers/thunderbolt/nhi.c
index c0aee5dc5237..1f8545d03030 100644
--- a/drivers/thunderbolt/nhi.c
+++ b/drivers/thunderbolt/nhi.c
@@ -43,8 +43,6 @@
 #define NHI_MAILBOX_TIMEOUT	500 /* ms */
 
 /* Host interface quirks */
-#define QUIRK_AUTO_CLEAR_INT	BIT(0)
-#define QUIRK_E2E		BIT(1)
 
 static int ring_interrupt_index(const struct tb_ring *ring)
 {
@@ -1147,30 +1145,6 @@ static void nhi_shutdown(struct tb_nhi *nhi)
 		nhi->ops->shutdown(nhi);
 }
 
-static void nhi_check_quirks(struct tb_nhi *nhi)
-{
-	if (nhi->pdev->vendor == PCI_VENDOR_ID_INTEL) {
-		/*
-		 * Intel hardware supports auto clear of the interrupt
-		 * status register right after interrupt is being
-		 * issued.
-		 */
-		nhi->quirks |= QUIRK_AUTO_CLEAR_INT;
-
-		switch (nhi->pdev->device) {
-		case PCI_DEVICE_ID_INTEL_FALCON_RIDGE_2C_NHI:
-		case PCI_DEVICE_ID_INTEL_FALCON_RIDGE_4C_NHI:
-			/*
-			 * Falcon Ridge controller needs the end-to-end
-			 * flow control workaround to avoid losing Rx
-			 * packets when RING_FLAG_E2E is set.
-			 */
-			nhi->quirks |= QUIRK_E2E;
-			break;
-		}
-	}
-}
-
 static int nhi_check_iommu_pdev(struct pci_dev *pdev, void *data)
 {
 	if (!pdev->external_facing ||
@@ -1322,7 +1296,6 @@ static int nhi_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (!nhi->tx_rings || !nhi->rx_rings)
 		return -ENOMEM;
 
-	nhi_check_quirks(nhi);
 	nhi_check_iommu(nhi);
 
 	res = nhi_init_msi(nhi);
diff --git a/drivers/thunderbolt/quirks.c b/drivers/thunderbolt/quirks.c
index 1157b8869bcc..da851e0760b7 100644
--- a/drivers/thunderbolt/quirks.c
+++ b/drivers/thunderbolt/quirks.c
@@ -26,6 +26,18 @@ static void quirk_clx_disable(struct tb_switch *sw)
 	tb_sw_dbg(sw, "disabling CL states\n");
 }
 
+static void quirk_auto_clear_interrupts(struct tb_switch *sw)
+{
+	sw->quirks |= QUIRK_AUTO_CLEAR_INT;
+	tb_sw_dbg(sw, "setting auto clear interrupts\n");
+}
+
+static void quirk_e2e(struct tb_switch *sw)
+{
+	sw->quirks |= QUIRK_E2E;
+	tb_sw_dbg(sw, "setting E2E flow control\n");
+}
+
 static void quirk_usb3_maximum_bandwidth(struct tb_switch *sw)
 {
 	struct tb_port *port;
@@ -51,6 +63,21 @@ static const struct tb_quirk tb_quirks[] = {
 	/* Dell WD19TB supports self-authentication on unplug */
 	{ 0x0000, 0x0000, 0x00d4, 0xb070, quirk_force_power_link },
 	{ 0x0000, 0x0000, 0x00d4, 0xb071, quirk_force_power_link },
+	/*
+	 * Intel hardware supports auto clear of the interrupt
+	 * status register right after interrupt is being
+	 * issued.
+	 */
+	{ 0x8087, 0x0000, 0x0000, 0x0000, quirk_auto_clear_interrupts },
+	/*
+	 * Falcon Ridge controller needs the end-to-end
+	 * flow control workaround to avoid losing Rx
+	 * packets when RING_FLAG_E2E is set.
+	 */
+	{ 0x8087, PCI_DEVICE_ID_INTEL_FALCON_RIDGE_2C_NHI, 0x0000, 0x0000,
+		  quirk_e2e },
+	{ 0x8087, PCI_DEVICE_ID_INTEL_FALCON_RIDGE_4C_NHI, 0x0000, 0x0000,
+		  quirk_e2e },
 	/*
 	 * Intel Goshen Ridge NVM 27 and before report wrong number of
 	 * DP buffers.
diff --git a/drivers/thunderbolt/tb.h b/drivers/thunderbolt/tb.h
index ce0a035800ab..07b19b17f6b5 100644
--- a/drivers/thunderbolt/tb.h
+++ b/drivers/thunderbolt/tb.h
@@ -27,6 +27,10 @@
 #define QUIRK_FORCE_POWER_LINK_CONTROLLER		BIT(0)
 /* Disable CLx if not supported */
 #define QUIRK_NO_CLX					BIT(1)
+/* Automatically clears interrupts status register */
+#define QUIRK_AUTO_CLEAR_INT				BIT(2)
+/* Needs end to end flow control */
+#define QUIRK_E2E					BIT(3)
 
 /**
  * struct tb_nvm - Structure holding NVM information
-- 
2.34.1

