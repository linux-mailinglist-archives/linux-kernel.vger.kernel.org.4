Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A4F35FA183
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 18:00:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbiJJQAl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 12:00:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiJJQAi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 12:00:38 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2044.outbound.protection.outlook.com [40.107.96.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D11006D9EE;
        Mon, 10 Oct 2022 09:00:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T8KgtWk8l0QlMRg8Z6NXfYmBgPNlyornxOlrhSWT/x1v261HBwoAvDKcVMe4xkdTe3W3iIF/xbSDsdKr2uNHVyrLzFpJ0gtmbrb5nFILm/Qr20UgiYjew7miyFpdjR7reS3a47+8vrmbe/GLnPA5lNfyhMzY1FN23DLg8ocojwboJNMWXIu1Gq8c6TEzwR3BPssyrOE4LCliX/+kvgRXQ+Rd+BhZxh1KPJrxUB0oycQjS4jKVTv/0fOFNhN3aUl4Z3alssO0isSueDogHraYhIbmUjhhUQZQtl5+t8Or39TjTk6Uf9X5aE2OHS3dJiHfs13y3bqu+MRJx1vuX059mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SV+wn+X2s5GRpVWUuxyaAkArdgW+3m7DhWGOZactC/k=;
 b=Uyk9lP9ZeN64oZmgDw48znuOtWHOTn7V4lRbbFYe2j9hPIEhrBekgiGjBVjMv4DmEfWbY/c44wLN1nROXA8w49NcvqH1VMRKn4Vfk/M5j1XVEUU8nbgQp8oxNhg7LNEg76csIrXHl+BrwJ3jnE/D149tPCYXWMKVUJRkx4/3S4onVT6VKQoDwy70FMjaXwqFXYkl3u1wOowmtccf7kEmPLgL2gw4XGH8hwuHSIohPphdydTD7a3Hg48z0Q5+1+J6eBR/qkNm08uBlOSEUhfhauA4adyk5iA8Uoq9NBAPkv6THtzMB9GMhGcqyH37pCPqKxkICXMhaG0RcR45Q0PKnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SV+wn+X2s5GRpVWUuxyaAkArdgW+3m7DhWGOZactC/k=;
 b=qsXf5Iy5sbXU98a6smJpTWQ605M1STzDaSh+ZT2yEcHzwQzg2goCSwsvvXFKP1+bR2ISrY2Jh7DB+cL88lbTl8y+M2t2Xh8wjrjhZPzmyl6o4BFFLs4qL1D2/07l0jn/8yhcD+IfK19uMpyCr6X19NKyOOLCxoeK0SX2dykUnuQ=
Received: from MW4PR03CA0203.namprd03.prod.outlook.com (2603:10b6:303:b8::28)
 by CY5PR12MB6623.namprd12.prod.outlook.com (2603:10b6:930:41::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.28; Mon, 10 Oct
 2022 16:00:33 +0000
Received: from CO1NAM11FT109.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b8:cafe::e8) by MW4PR03CA0203.outlook.office365.com
 (2603:10b6:303:b8::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15 via Frontend
 Transport; Mon, 10 Oct 2022 16:00:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT109.mail.protection.outlook.com (10.13.174.176) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5709.10 via Frontend Transport; Mon, 10 Oct 2022 16:00:33 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 10 Oct
 2022 11:00:32 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <mario.limonciello@amd.com>,
        Mathias Nyman <mathias.nyman@intel.com>
CC:     Mehta Sanju <Sanju.Mehta@amd.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3] xhci-pci: Set runtime PM as default policy on all xHC 1.2 or later devices
Date:   Mon, 10 Oct 2022 11:00:21 -0500
Message-ID: <20221010160022.647-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT109:EE_|CY5PR12MB6623:EE_
X-MS-Office365-Filtering-Correlation-Id: 81ae6342-f737-4ec1-81d7-08daaad8901c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AYWyvjCUdG1GWCOTy3ZZPspvCxq5ddcAfl84hXdIUUUpoDGHu3AKbv7CIJVzlQuYSQEwdlQZrO3+aVwhrJqyBzeFU5b99vsTE/rvAbQZ/1OjbaOHHcnyL9ldkYvLGIjy/1VXPT0e9SFholpop03cn1kDDn+taTLsuvtRJ/kgLhx66EcDpdgkR3d88EaIyNLwq5Iup7uqr788Ep5g8SCY2c4Dvs5Sx25TeWChsMi1FLzaewPoG4m6oG6dz1Jjrb5Kdjb6lp4H1uYamTq1UrwPcMZ3s2KtoPEg908XZGi/YcMduwLn0s4kfmfEimInSW8i058EzsHO6Vb94/uI9fWgkAqx6Io2sIE+Seduf2nUkxV1gGvz9rmq2h0IngWSfc+bshcNgdIs9+7YkyLpILf4Ev3BChI3v4GjCgmyAiKZdxMFNcrucqOCb8SmTSicR62bWnZCuEY09H7CwQZqXE4PxnHr0kEq+oQwUFg8AFJn0w6GGsfJn0RZE7DhyQ6wXNdbPeUOnZCH9sgImf3RkAOU1DyzdBWRN1bv+8Sqz9G0JCpyI3PZjJJLjVOZZ3cvLrHQK0WG6U6y0stTXmzvkyEnToY+TZGL9HEVM+V3PwJDA7WnvAC/lj5VhC82jwXU160dBPSvO5CXAvNcHZI0mp/YatjfO908vnI4956r7GFAhWlFvC3zWOnf5JEgfN29HGa/svgXAAi2azGGWaaFWIe/HxFHK+XT43XSoLm6s7sbpwoaZ8cyKv2/Rp5XvQiBiSEL0TDtanLve83+q6aeJ5aL+DppUvjaXTSGVuVaiigunTWPX8HTy2Nvt6+inR37VgsJ93F9jlIe50cDNsGQ+6ABew==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(396003)(136003)(376002)(451199015)(40470700004)(36840700001)(46966006)(316002)(70206006)(4326008)(8676002)(7696005)(2906002)(70586007)(41300700001)(5660300002)(966005)(82310400005)(44832011)(40460700003)(110136005)(8936002)(36756003)(6666004)(86362001)(478600001)(186003)(26005)(54906003)(83380400001)(16526019)(356005)(40480700001)(47076005)(81166007)(82740400003)(336012)(36860700001)(426003)(2616005)(1076003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2022 16:00:33.1604
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 81ae6342-f737-4ec1-81d7-08daaad8901c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT109.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6623
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For optimal power consumption of USB4 routers the XHCI PCIe endpoint
used for tunneling must be in D3.  Historically this is accomplished
by a long list of PCIe IDs that correspond to these endpoints because
the xhci_hcd driver will not default to allowing runtime PM for all
devices.

As both AMD and Intel have released new products with new XHCI controllers
this list continues to grow. In reviewing the XHCI specification v1.2 on
page 607 there is already a requirement that the PCI power management
states D3hot and D3cold must be supported.

In the quirk list, use this to indicate that runtime PM should be allowed
on XHCI controllers. The following controllers are known to be xHC 1.2 and
dropped explicitly:
* AMD Yellow Carp
* Intel Alder Lake
* Intel Meteor Lake
* Intel Raptor Lake

Suggested-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Link: https://www.intel.com/content/dam/www/public/us/en/documents/technical-specifications/extensible-host-controler-interface-usb-xhci.pdf
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v2->v3:
 * Add a comment for future discovery (Mika)
 * Correct version from 0x102 to 0x120 (Mathias)
 * Drop some Intel controllers too (Mathias)
 * Drop second patch (Mathias)
---
 drivers/usb/host/xhci-pci.c | 31 +++----------------------------
 1 file changed, 3 insertions(+), 28 deletions(-)

diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
index dce6c0ec8d340..fd6f2698b3ea4 100644
--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -58,25 +58,12 @@
 #define PCI_DEVICE_ID_INTEL_CML_XHCI			0xa3af
 #define PCI_DEVICE_ID_INTEL_TIGER_LAKE_XHCI		0x9a13
 #define PCI_DEVICE_ID_INTEL_MAPLE_RIDGE_XHCI		0x1138
-#define PCI_DEVICE_ID_INTEL_ALDER_LAKE_XHCI		0x461e
-#define PCI_DEVICE_ID_INTEL_ALDER_LAKE_N_XHCI		0x464e
-#define PCI_DEVICE_ID_INTEL_ALDER_LAKE_PCH_XHCI	0x51ed
-#define PCI_DEVICE_ID_INTEL_RAPTOR_LAKE_XHCI		0xa71e
-#define PCI_DEVICE_ID_INTEL_METEOR_LAKE_XHCI		0x7ec0
 
 #define PCI_DEVICE_ID_AMD_RENOIR_XHCI			0x1639
 #define PCI_DEVICE_ID_AMD_PROMONTORYA_4			0x43b9
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
 
 #define PCI_DEVICE_ID_ASMEDIA_1042_XHCI			0x1042
 #define PCI_DEVICE_ID_ASMEDIA_1042A_XHCI		0x1142
@@ -268,12 +255,7 @@ static void xhci_pci_quirks(struct device *dev, struct xhci_hcd *xhci)
 	     pdev->device == PCI_DEVICE_ID_INTEL_TITAN_RIDGE_DD_XHCI ||
 	     pdev->device == PCI_DEVICE_ID_INTEL_ICE_LAKE_XHCI ||
 	     pdev->device == PCI_DEVICE_ID_INTEL_TIGER_LAKE_XHCI ||
-	     pdev->device == PCI_DEVICE_ID_INTEL_MAPLE_RIDGE_XHCI ||
-	     pdev->device == PCI_DEVICE_ID_INTEL_ALDER_LAKE_XHCI ||
-	     pdev->device == PCI_DEVICE_ID_INTEL_ALDER_LAKE_N_XHCI ||
-	     pdev->device == PCI_DEVICE_ID_INTEL_ALDER_LAKE_PCH_XHCI ||
-	     pdev->device == PCI_DEVICE_ID_INTEL_RAPTOR_LAKE_XHCI ||
-	     pdev->device == PCI_DEVICE_ID_INTEL_METEOR_LAKE_XHCI))
+	     pdev->device == PCI_DEVICE_ID_INTEL_MAPLE_RIDGE_XHCI))
 		xhci->quirks |= XHCI_DEFAULT_PM_RUNTIME_ALLOW;
 
 	if (pdev->vendor == PCI_VENDOR_ID_ETRON &&
@@ -336,15 +318,8 @@ static void xhci_pci_quirks(struct device *dev, struct xhci_hcd *xhci)
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
+	/* xHC spec requires PCI devices to support D3hot and D3cold */
+	if (xhci->hci_version >= 0x120)
 		xhci->quirks |= XHCI_DEFAULT_PM_RUNTIME_ALLOW;
 
 	if (xhci->quirks & XHCI_RESET_ON_RESUME)
-- 
2.34.1

