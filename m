Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A0705F3C02
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 06:13:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbiJDEM4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 00:12:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiJDEMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 00:12:52 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2086.outbound.protection.outlook.com [40.107.220.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42C302654A;
        Mon,  3 Oct 2022 21:12:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aeAtLMmL3119DZkRe0sE3ioCBrPjynoucjigbDrO8qAcwqmQ1f5LEsOCP8zq0T4trj5T2YoaBQ6NWqz3DrjLCTZjHHo3agNhq/dedGO2986ZcMSLxAvxqrZsP6IYwg3UuwyfvgxWT+NhVCQsYqvAN8Ayet2C2wdBbPrBYKAo+p+S1BVeMa1AAG8L897SBPKSNnmUG76p+WtbUxiiktJE7BNBfDGBRq7DMhFX4i7U/aab1kzCh88menXaQJfmfOe+fEa+hMhGg45OTZY0cwORIwv5wJnKoHY8fch5axHaHtc0QNWBuFdNDCkJqjWVv95w3XBW4O/2xV91xJmcjvHj/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1lqcgjhFpooZvepJY9X/OtZ5qWYJZdS5uWepWaHfHHE=;
 b=munKbcICqORNFHlz43MtdpEWXFN8qIYVVHKSIDjuIZLXxlggUXYlzew8DS3EowjonN5S2drhorbGHE0jl3C0aV86joo1oSinZxsJXui8ZsV497hGrul/TXf6fFw1eQQ9XZuqXlI2pLZE3JET4Jd1b7U6jeZ1KufU7qCfV9aFH0OPZ/eNEBc7y+dQ5XzSNVdTIgU8R3a/UjGteq2PnRrLMtuhnbapwcAfBAWK5+MDCHw1N+R05qRWyBnxXQejmaa20EIqhJ82YVAxUk79tWKQBjWkzR7S3fFuGxgILHVLWgN5S3izJXQ4aJmwp8LKhs1A1e/DN4Y8GGSN/Sf2t3dhAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1lqcgjhFpooZvepJY9X/OtZ5qWYJZdS5uWepWaHfHHE=;
 b=yjQnW+tc5/TdKVnvH464vZX6P7LE/dlyv87WmttCBjLaAToVRtHliXSsDzoPVSpd8R3aPzOh/97FFk72jlus/Cq73fMCfmW8Rjdh6ZKpZqs3vk6NLv9+r7ynJsj66M8dOOIqXwWCJy+f7HXJUPiDCjB5k965GHmkZVPL9GV2HK8=
Received: from BN9PR03CA0139.namprd03.prod.outlook.com (2603:10b6:408:fe::24)
 by PH8PR12MB7028.namprd12.prod.outlook.com (2603:10b6:510:1bf::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.23; Tue, 4 Oct
 2022 04:12:47 +0000
Received: from BN8NAM11FT080.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fe:cafe::dc) by BN9PR03CA0139.outlook.office365.com
 (2603:10b6:408:fe::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.26 via Frontend
 Transport; Tue, 4 Oct 2022 04:12:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT080.mail.protection.outlook.com (10.13.176.82) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5676.17 via Frontend Transport; Tue, 4 Oct 2022 04:12:47 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 3 Oct
 2022 23:12:45 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
CC:     "open list:THUNDERBOLT DRIVER" <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <Sanju.Mehta@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [RFC 2/3] xhci-pci: Remove a number of controllers from the runtime PM allowlist
Date:   Mon, 3 Oct 2022 23:12:24 -0500
Message-ID: <20221004041225.1462336-3-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221004041225.1462336-1-mario.limonciello@amd.com>
References: <20221004041225.1462336-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT080:EE_|PH8PR12MB7028:EE_
X-MS-Office365-Filtering-Correlation-Id: 931fa7a0-cb1a-47a5-5591-08daa5beb1d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ATzTEh9ZJi77RTCj2YUvANNCxaFmxRFqC/IElgeYB7YA40UcVvwM3fWnj60NvNuLLUaMYcSNeBeQ3AWdDv6GWXPrYDgqBXd07dPwmBofhG4RFarpjnNOEoZufglwJ9BlsLesF8YRBd2D4pxwFkHca7E9whckAFE5dzTe+1m2ihyO1IAL5mCEL/uMy2smrQ0p6p9K+Y2whxKBKoVsl0RXg+pXxUXbCZ/skLRHnil41VzrDt3cVAz7ZqqpiK0wfLpNraUXm3Xv5tT48M68V6Nd0XVN7JyOIdQDC9SvtQm3dxoUeCM5/CBDRsVeheYVL3it2YRo9EZJD+H2cg1OEPc879V5kAJMw0Sb8Jn6EhPOG7VZrgflGNYwpRl5wWE/bLJsBmTjIpCjWrBCnqOPdTP3k/3IaF+vYnj+U5b/izeJ0kDw7IvmOBQyJVmOpqo0uC9hwbrzZWqA3hfEsw9Z1z84e9lyLIPT5GfDk0auY9OYvz23T/wE92nU4Eck/HDe9TkgWEdCizULy4FZnQ/tYfneJ2LCvU4xox1x4isla6RB9GYtvZmiYHpPJJKMxyBJMdJfLtyijVQP1Y2WdHYEEuF4FXMrq1XE/mxmeeta1vDlmbic4FQJjAQF9xNdLt7U5vrt21gkIqWb+e377y5TL8krf6tMth81iptab9sJbNx8lteQ+tmoVtiDtcQG7/trhi4qu5DJnHjKd7GKXMRrhT9cg7YWH1NKs5+Lb8hYDnKHesX4xKgmwGvgPD3HjkyWjU2Ub09f7htTByr0b4UNt99MGl4YzAtDDY+pj484XgcGtU2vNmjlV2Z9i1ZX0kbzsCDl
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(39860400002)(376002)(396003)(451199015)(36840700001)(40470700004)(46966006)(1076003)(47076005)(2616005)(16526019)(426003)(336012)(186003)(66574015)(41300700001)(81166007)(40480700001)(86362001)(6666004)(8676002)(5660300002)(26005)(4326008)(82740400003)(82310400005)(40460700003)(36756003)(356005)(83380400001)(36860700001)(2906002)(54906003)(6916009)(44832011)(316002)(8936002)(478600001)(70586007)(70206006)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2022 04:12:47.1417
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 931fa7a0-cb1a-47a5-5591-08daa5beb1d4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT080.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7028
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When creating a device link from the XHCI PCI device to the USB4 router
the thunderbolt driver will opt the XHCI PCI device into runtime PM.

As such it's not necessary to include a hardcoded list of these XHCI
controllers.  This is effectively a full or partial revert of the following
commits:

* commit 8ffdc53a60049 ("xhci-pci: Allow host runtime PM as default for
Intel Meteor Lake xHCI")
* commit 7516da47a349e ("xhci-pci: Allow host runtime PM as default for
Intel Raptor Lake xHCI")
* commit 74f55a62c4c35 ("xhci: Allow host runtime PM as default for
Intel Alder Lake N xHCI")
* commit b813511135e8b ("xhci-pci: Allow host runtime PM as default for
Intel Alder Lake xHCI")
* commit 6a7c533d4a185 ("xhci-pci: Allow host runtime PM as default for
Intel Tiger Lake xHCI")
* commit 07a594f353655 ("xhci-pci: Allow host runtime PM as default also
for Intel Ice Lake xHCI")
* commit f886d4fbb7c97 ("usb: xhci: Extend support for runtime power
management for AMD's Yellow carp.")

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/usb/host/xhci-pci.c | 24 ++++--------------------
 1 file changed, 4 insertions(+), 20 deletions(-)

diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
index dce6c0ec8d340..44defa8b796f7 100644
--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -54,15 +54,9 @@
 #define PCI_DEVICE_ID_INTEL_TITAN_RIDGE_2C_XHCI		0x15e9
 #define PCI_DEVICE_ID_INTEL_TITAN_RIDGE_4C_XHCI		0x15ec
 #define PCI_DEVICE_ID_INTEL_TITAN_RIDGE_DD_XHCI		0x15f0
-#define PCI_DEVICE_ID_INTEL_ICE_LAKE_XHCI		0x8a13
 #define PCI_DEVICE_ID_INTEL_CML_XHCI			0xa3af
-#define PCI_DEVICE_ID_INTEL_TIGER_LAKE_XHCI		0x9a13
 #define PCI_DEVICE_ID_INTEL_MAPLE_RIDGE_XHCI		0x1138
-#define PCI_DEVICE_ID_INTEL_ALDER_LAKE_XHCI		0x461e
-#define PCI_DEVICE_ID_INTEL_ALDER_LAKE_N_XHCI		0x464e
 #define PCI_DEVICE_ID_INTEL_ALDER_LAKE_PCH_XHCI	0x51ed
-#define PCI_DEVICE_ID_INTEL_RAPTOR_LAKE_XHCI		0xa71e
-#define PCI_DEVICE_ID_INTEL_METEOR_LAKE_XHCI		0x7ec0
 
 #define PCI_DEVICE_ID_AMD_RENOIR_XHCI			0x1639
 #define PCI_DEVICE_ID_AMD_PROMONTORYA_4			0x43b9
@@ -73,10 +67,8 @@
 #define PCI_DEVICE_ID_AMD_YELLOW_CARP_XHCI_2		0x161b
 #define PCI_DEVICE_ID_AMD_YELLOW_CARP_XHCI_3		0x161d
 #define PCI_DEVICE_ID_AMD_YELLOW_CARP_XHCI_4		0x161e
-#define PCI_DEVICE_ID_AMD_YELLOW_CARP_XHCI_5		0x15d6
-#define PCI_DEVICE_ID_AMD_YELLOW_CARP_XHCI_6		0x15d7
-#define PCI_DEVICE_ID_AMD_YELLOW_CARP_XHCI_7		0x161c
-#define PCI_DEVICE_ID_AMD_YELLOW_CARP_XHCI_8		0x161f
+#define PCI_DEVICE_ID_AMD_YELLOW_CARP_XHCI_5		0x161c
+#define PCI_DEVICE_ID_AMD_YELLOW_CARP_XHCI_6		0x161f
 
 #define PCI_DEVICE_ID_ASMEDIA_1042_XHCI			0x1042
 #define PCI_DEVICE_ID_ASMEDIA_1042A_XHCI		0x1142
@@ -266,14 +258,8 @@ static void xhci_pci_quirks(struct device *dev, struct xhci_hcd *xhci)
 	     pdev->device == PCI_DEVICE_ID_INTEL_TITAN_RIDGE_2C_XHCI ||
 	     pdev->device == PCI_DEVICE_ID_INTEL_TITAN_RIDGE_4C_XHCI ||
 	     pdev->device == PCI_DEVICE_ID_INTEL_TITAN_RIDGE_DD_XHCI ||
-	     pdev->device == PCI_DEVICE_ID_INTEL_ICE_LAKE_XHCI ||
-	     pdev->device == PCI_DEVICE_ID_INTEL_TIGER_LAKE_XHCI ||
 	     pdev->device == PCI_DEVICE_ID_INTEL_MAPLE_RIDGE_XHCI ||
-	     pdev->device == PCI_DEVICE_ID_INTEL_ALDER_LAKE_XHCI ||
-	     pdev->device == PCI_DEVICE_ID_INTEL_ALDER_LAKE_N_XHCI ||
-	     pdev->device == PCI_DEVICE_ID_INTEL_ALDER_LAKE_PCH_XHCI ||
-	     pdev->device == PCI_DEVICE_ID_INTEL_RAPTOR_LAKE_XHCI ||
-	     pdev->device == PCI_DEVICE_ID_INTEL_METEOR_LAKE_XHCI))
+	     pdev->device == PCI_DEVICE_ID_INTEL_ALDER_LAKE_PCH_XHCI))
 		xhci->quirks |= XHCI_DEFAULT_PM_RUNTIME_ALLOW;
 
 	if (pdev->vendor == PCI_VENDOR_ID_ETRON &&
@@ -342,9 +328,7 @@ static void xhci_pci_quirks(struct device *dev, struct xhci_hcd *xhci)
 	    pdev->device == PCI_DEVICE_ID_AMD_YELLOW_CARP_XHCI_3 ||
 	    pdev->device == PCI_DEVICE_ID_AMD_YELLOW_CARP_XHCI_4 ||
 	    pdev->device == PCI_DEVICE_ID_AMD_YELLOW_CARP_XHCI_5 ||
-	    pdev->device == PCI_DEVICE_ID_AMD_YELLOW_CARP_XHCI_6 ||
-	    pdev->device == PCI_DEVICE_ID_AMD_YELLOW_CARP_XHCI_7 ||
-	    pdev->device == PCI_DEVICE_ID_AMD_YELLOW_CARP_XHCI_8))
+	    pdev->device == PCI_DEVICE_ID_AMD_YELLOW_CARP_XHCI_6))
 		xhci->quirks |= XHCI_DEFAULT_PM_RUNTIME_ALLOW;
 
 	if (xhci->quirks & XHCI_RESET_ON_RESUME)
-- 
2.34.1

