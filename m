Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35D665F5AEC
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 22:24:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbiJEUYB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 16:24:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbiJEUXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 16:23:46 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2083.outbound.protection.outlook.com [40.107.93.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 997636D56F;
        Wed,  5 Oct 2022 13:23:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PHKd8yu3NX2dytOklX62NuhZ4WhXTTx1wwsABvvKcVda5MqqrnzLbGAnALtOVPnLsYKVU0FuiLChUyoprhMg98S0fDg1SpFeZ/vFh7HANjCjCUCR0ABhADxPpadphISoNdnrk1bVUngR8b2E+h0C/E+3OCKj6IETKbKZEmqE5LbutG9EpxahzDtI+CvFKIecDdV7zdeBkgWNlrr2JqIjTJDT/9VHF9UJv3B71lIEAtIC25ysvMX/dEGlr/vJELpMO76MEC6FEivbtChtoc2DvXHDSfx+2mVD4XNZ7qJhz8wzooNBtqZT27fK7z8r/Z0SeFjrVBj4DRbVg4uH/qsCmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uCALTAQQVZcBwtKhpI+tt3MRR/jVv+tSWPzP5/hza5M=;
 b=KaLjbz41dwv468gnI1E0wZFYE+UG+Tr6HVzxzw6xAW7DE/D+KSH0kMGfglVL/zu7mEI1mLSiRcnv6dvzSBkUrm1y/4YdHvA/RPnl6E4VbZ6+u6DPQiSVWjHXR59zxWyrBiUwMW315ahiPtNteVMfQkLUXXQlOGpkL4hkcIixHDR7HDJgyZhdMClQknwNHqkv1VGrTed7qwSNs4qmxqBTUj3tJW6PimMmv9K4nU4jjgHQGHYk7LliEpZszkxyJ0SDP4pCMAJuj3261aT0bhPzA/VdIfiDk0aAcDY9arld3z2SXGueWSVorxJzUq+elVG1k2M7lrDjAZdlmwKKwiJlKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uCALTAQQVZcBwtKhpI+tt3MRR/jVv+tSWPzP5/hza5M=;
 b=X839/0l+xMkYu+AuHywp/UxrdmJyvgQocTHLOTWloDcBRfoTCjlc9ijoAqyVTjcUJ0CxQKomitl0befsGlfPGwBiw02j3vWIDmpOfnKi93X0gbwJFJjuvFW9IFpPBCJ/7k9JntPDFItE/3lvH+L3vflrpjO7NpLUXUU3EzhEvDg=
Received: from DM6PR14CA0066.namprd14.prod.outlook.com (2603:10b6:5:18f::43)
 by SN7PR12MB7321.namprd12.prod.outlook.com (2603:10b6:806:298::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.20; Wed, 5 Oct
 2022 20:23:43 +0000
Received: from DM6NAM11FT085.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:18f:cafe::70) by DM6PR14CA0066.outlook.office365.com
 (2603:10b6:5:18f::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.29 via Frontend
 Transport; Wed, 5 Oct 2022 20:23:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT085.mail.protection.outlook.com (10.13.172.236) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5709.10 via Frontend Transport; Wed, 5 Oct 2022 20:23:43 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 5 Oct
 2022 15:23:41 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <mathias.nyman@intel.com>, <mika.westerberg@linux.intel.com>
CC:     <Sanju.Mehta@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/4] xhci-pci: Move PCI IDs for runtime allow into a table
Date:   Wed, 5 Oct 2022 15:23:50 -0500
Message-ID: <20221005202353.1269-3-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221005202353.1269-1-mario.limonciello@amd.com>
References: <20221005202353.1269-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT085:EE_|SN7PR12MB7321:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d6ed391-f631-48d9-8c80-08daa70f7fa1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9lBt8Ifn4kRxBp0ZeKqdqu7XLraDoLJbT5rSYyruhibwH+NLbfMtdGqj+R9OvLG7jPF3KAo+1HpLau/+bfcewUwqObMbV1HriPbii0jdmKyrHL03jHgg5P66JzbxY5o851Ny2RS9WKzf0387vK3DaSn21VYy1vSYCggTKW/boGw+y1QWtbYEOSEpviiLD5QwshQbyKZwc/t0AWoFmXk3WSFQe0LfMueht+gCuNCf6dHxL3S73hr2oijt1n6JQVREvbI3qdeRUAj/MlGPUIXPmdj+ntRQ7VL8d3I6y9SDWS5m4KwIqhmKGJ3jDal9HE9oaNGvvp0Zmm1c8f48ouyxXBhAqhH2CoCDjuwbK3GbVFT1vtD6yL2hqcoNOQ9VPUtajTxkuxYQHmyQKYD+JD2+nN2QLwHrNYlGaJH8o6nRaBnE2SCMUrCJ3/88leaxpsJ4HO+SvKLqDMe2pk0JvkVAIP15wlnBvii084BDhTl1NCfU9tyjrJvBmYKI8OxiZaBM6eE3F5Eav2XKTzd6st03IZcVEPbKPWSKsXAGoM/4sZcwp5iA5tIxOk3i0rmeXgumzq/GQ6MGwtsCFQ0BucNu7bL35EHG45wlNC7Y7cRJhwaymufdg9BoXjaB2wi4wJKGOOVZfUdQH7KF1FU5mMEdnwEZtOf9qN016anFIb/YrVkLm5HR0tXZNa/Wy7cPAOShn1A+BkI45GUC9DTEIZDTXTLGltwj9HqpuwzLf6vtnecJDjzztxlwzFpfp0378YAgzKopr5kxWYNOgBTXzLZu3bckjN2A6MS6QjjmdqPEFxZY1phVPss2ktUdI6qm+z5s
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(346002)(376002)(396003)(451199015)(40470700004)(36840700001)(46966006)(82310400005)(36756003)(86362001)(40480700001)(110136005)(54906003)(8936002)(316002)(8676002)(70586007)(81166007)(82740400003)(2906002)(4326008)(356005)(36860700001)(41300700001)(478600001)(186003)(83380400001)(70206006)(40460700003)(2616005)(1076003)(47076005)(16526019)(26005)(426003)(336012)(44832011)(7696005)(6666004)(5660300002)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2022 20:23:43.2894
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d6ed391-f631-48d9-8c80-08daa70f7fa1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT085.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7321
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,UPPERCASE_50_75 autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Every time an new ID is added to this file, it ends up in a list that
will require changing the last parenthesis or a curly brace or both.

To make for cleaner patches in the future, match devices against a table.
While moving IDs over, rename the Yellow Carp ones to Rembrandt as it
has launched.  No functional changes intended by this change.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
RFC v1->PATCH v1
 * New patch
---
 drivers/usb/host/xhci-pci.c | 74 +++++++++++++++++++------------------
 1 file changed, 38 insertions(+), 36 deletions(-)

diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
index dce6c0ec8d340..6e5bcec9b2b16 100644
--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -69,14 +69,14 @@
 #define PCI_DEVICE_ID_AMD_PROMONTORYA_3			0x43ba
 #define PCI_DEVICE_ID_AMD_PROMONTORYA_2			0x43bb
 #define PCI_DEVICE_ID_AMD_PROMONTORYA_1			0x43bc
-#define PCI_DEVICE_ID_AMD_YELLOW_CARP_XHCI_1		0x161a
-#define PCI_DEVICE_ID_AMD_YELLOW_CARP_XHCI_2		0x161b
-#define PCI_DEVICE_ID_AMD_YELLOW_CARP_XHCI_3		0x161d
-#define PCI_DEVICE_ID_AMD_YELLOW_CARP_XHCI_4		0x161e
-#define PCI_DEVICE_ID_AMD_YELLOW_CARP_XHCI_5		0x15d6
-#define PCI_DEVICE_ID_AMD_YELLOW_CARP_XHCI_6		0x15d7
-#define PCI_DEVICE_ID_AMD_YELLOW_CARP_XHCI_7		0x161c
-#define PCI_DEVICE_ID_AMD_YELLOW_CARP_XHCI_8		0x161f
+#define PCI_DEVICE_ID_AMD_REMBRANDT_XHCI_1		0x161a
+#define PCI_DEVICE_ID_AMD_REMBRANDT_XHCI_2		0x161b
+#define PCI_DEVICE_ID_AMD_REMBRANDT_XHCI_3		0x161d
+#define PCI_DEVICE_ID_AMD_REMBRANDT_XHCI_4		0x161e
+#define PCI_DEVICE_ID_AMD_REMBRANDT_XHCI_5		0x15d6
+#define PCI_DEVICE_ID_AMD_REMBRANDT_XHCI_6		0x15d7
+#define PCI_DEVICE_ID_AMD_REMBRANDT_XHCI_7		0x161c
+#define PCI_DEVICE_ID_AMD_REMBRANDT_XHCI_8		0x161f
 
 #define PCI_DEVICE_ID_ASMEDIA_1042_XHCI			0x1042
 #define PCI_DEVICE_ID_ASMEDIA_1042A_XHCI		0x1142
@@ -86,6 +86,35 @@
 
 static const char hcd_name[] = "xhci_hcd";
 
+static const struct pci_device_id runtime_allow_pci_ids[] = {
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ALPINE_RIDGE_2C_XHCI) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ALPINE_RIDGE_4C_XHCI) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ALPINE_RIDGE_LP_XHCI) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ALPINE_RIDGE_C_2C_XHCI) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ALPINE_RIDGE_C_4C_XHCI) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_TITAN_RIDGE_2C_XHCI) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_TITAN_RIDGE_4C_XHCI) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_TITAN_RIDGE_DD_XHCI) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICE_LAKE_XHCI) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_TIGER_LAKE_XHCI) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_MAPLE_RIDGE_XHCI) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ALDER_LAKE_XHCI) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ALDER_LAKE_N_XHCI) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ALDER_LAKE_PCH_XHCI) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_RAPTOR_LAKE_XHCI) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_METEOR_LAKE_XHCI) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_REMBRANDT_XHCI_1) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_REMBRANDT_XHCI_2) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_REMBRANDT_XHCI_3) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_REMBRANDT_XHCI_4) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_REMBRANDT_XHCI_4) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_REMBRANDT_XHCI_5) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_REMBRANDT_XHCI_6) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_REMBRANDT_XHCI_7) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_REMBRANDT_XHCI_8) },
+	{ 0 }
+};
+
 static struct hc_driver __read_mostly xhci_pci_hc_driver;
 
 static int xhci_pci_setup(struct usb_hcd *hcd);
@@ -257,25 +286,6 @@ static void xhci_pci_quirks(struct device *dev, struct xhci_hcd *xhci)
 	     pdev->device == PCI_DEVICE_ID_INTEL_DNV_XHCI))
 		xhci->quirks |= XHCI_MISSING_CAS;
 
-	if (pdev->vendor == PCI_VENDOR_ID_INTEL &&
-	    (pdev->device == PCI_DEVICE_ID_INTEL_ALPINE_RIDGE_2C_XHCI ||
-	     pdev->device == PCI_DEVICE_ID_INTEL_ALPINE_RIDGE_4C_XHCI ||
-	     pdev->device == PCI_DEVICE_ID_INTEL_ALPINE_RIDGE_LP_XHCI ||
-	     pdev->device == PCI_DEVICE_ID_INTEL_ALPINE_RIDGE_C_2C_XHCI ||
-	     pdev->device == PCI_DEVICE_ID_INTEL_ALPINE_RIDGE_C_4C_XHCI ||
-	     pdev->device == PCI_DEVICE_ID_INTEL_TITAN_RIDGE_2C_XHCI ||
-	     pdev->device == PCI_DEVICE_ID_INTEL_TITAN_RIDGE_4C_XHCI ||
-	     pdev->device == PCI_DEVICE_ID_INTEL_TITAN_RIDGE_DD_XHCI ||
-	     pdev->device == PCI_DEVICE_ID_INTEL_ICE_LAKE_XHCI ||
-	     pdev->device == PCI_DEVICE_ID_INTEL_TIGER_LAKE_XHCI ||
-	     pdev->device == PCI_DEVICE_ID_INTEL_MAPLE_RIDGE_XHCI ||
-	     pdev->device == PCI_DEVICE_ID_INTEL_ALDER_LAKE_XHCI ||
-	     pdev->device == PCI_DEVICE_ID_INTEL_ALDER_LAKE_N_XHCI ||
-	     pdev->device == PCI_DEVICE_ID_INTEL_ALDER_LAKE_PCH_XHCI ||
-	     pdev->device == PCI_DEVICE_ID_INTEL_RAPTOR_LAKE_XHCI ||
-	     pdev->device == PCI_DEVICE_ID_INTEL_METEOR_LAKE_XHCI))
-		xhci->quirks |= XHCI_DEFAULT_PM_RUNTIME_ALLOW;
-
 	if (pdev->vendor == PCI_VENDOR_ID_ETRON &&
 			pdev->device == PCI_DEVICE_ID_EJ168) {
 		xhci->quirks |= XHCI_RESET_ON_RESUME;
@@ -336,15 +346,7 @@ static void xhci_pci_quirks(struct device *dev, struct xhci_hcd *xhci)
 	     pdev->device == PCI_DEVICE_ID_AMD_PROMONTORYA_4))
 		xhci->quirks |= XHCI_NO_SOFT_RETRY;
 
-	if (pdev->vendor == PCI_VENDOR_ID_AMD &&
-	    (pdev->device == PCI_DEVICE_ID_AMD_YELLOW_CARP_XHCI_1 ||
-	    pdev->device == PCI_DEVICE_ID_AMD_YELLOW_CARP_XHCI_2 ||
-	    pdev->device == PCI_DEVICE_ID_AMD_YELLOW_CARP_XHCI_3 ||
-	    pdev->device == PCI_DEVICE_ID_AMD_YELLOW_CARP_XHCI_4 ||
-	    pdev->device == PCI_DEVICE_ID_AMD_YELLOW_CARP_XHCI_5 ||
-	    pdev->device == PCI_DEVICE_ID_AMD_YELLOW_CARP_XHCI_6 ||
-	    pdev->device == PCI_DEVICE_ID_AMD_YELLOW_CARP_XHCI_7 ||
-	    pdev->device == PCI_DEVICE_ID_AMD_YELLOW_CARP_XHCI_8))
+	if (pci_match_id(runtime_allow_pci_ids, pdev))
 		xhci->quirks |= XHCI_DEFAULT_PM_RUNTIME_ALLOW;
 
 	if (xhci->quirks & XHCI_RESET_ON_RESUME)
-- 
2.34.1

