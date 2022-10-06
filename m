Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D611C5F700C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 23:16:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232399AbiJFVQA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 17:16:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230323AbiJFVPo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 17:15:44 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2078.outbound.protection.outlook.com [40.107.244.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F025B2DAF;
        Thu,  6 Oct 2022 14:15:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G7hWCIdya0l9m517DJKP+Ge+JLwYdxSmOLeB1tluFCBf7ElXSS9ELjgi7bChF6F7zzAxI7Szm8Pmlo0c9/XnvzB+Y52WPVFvit6vLtBfIkg+YEaM+dqBcbE5x9hVs1tNt8jI3pOr2BWbIMVLoeVDgNctUKrz0ov8oCEFA0FtXE+ffWRCvdQ3QQV1fTMlrtReEoVOAXboPLmEx1mO7fxR5HwJQMk0FLQLeHHNW1gqocWDpNwelwj/2DusB5hqu5EqdPveNEiTwKsuhKT7eKpASF7S9/Z4t1Pf1E3bO5vgw6dSnX6O/OxI1ENgJuz3vLz1d648zmgtIbxIvPS5d+KOOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I1SQMaJo15Mmae9PaT/TfBSg6M09T1dGkXxdilFxvCQ=;
 b=PyCZA6b/3/rOeOnpjq1CrbIre4Jf4va6tgv2yP010D1VbwaRumGSS1mVPmcKYs+CTt7HKElsc4XPabxC+nTR1U3ASCgjSil8gMO5lLoiiASRzb/Gu2b15zgexZ77qN+7BTfaTl3SilNwX86TsuGI0i/+GoHPD7EJMzt81T0m2C8VHxXux9i8kyD5BZleh6PpmseqKbnr20BO5CCJ/I/HO5io9cNIONerf3KYZGx4GVfJBiURdZ1BxVY9kjIJt7XZqXgQ7qt9v/aB5Tmnzh+7eVw7EtXmw94Sp1YzDPB6WEBxLfTwq2iSxmwJ6/uNoFbHfhZutKx5YO3nz4918wvGIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I1SQMaJo15Mmae9PaT/TfBSg6M09T1dGkXxdilFxvCQ=;
 b=UeUOWm2l8GPrLEtNFJZqqhbNjAWSv9GhV80kgFC5/C/eAinClB5CxEs2zkkLrCO4sgTZYD7BL6ksu4SixGCuuWMQr5oQxL/gTpWUOAvdcTubDqpbL01q6Oaqm3EnFXagXu8KBduOkibxVCTN73oLUgCDGy/I/hr8Ijo64u0iNXc=
Received: from DS7PR03CA0167.namprd03.prod.outlook.com (2603:10b6:5:3b2::22)
 by SA0PR12MB4558.namprd12.prod.outlook.com (2603:10b6:806:72::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24; Thu, 6 Oct
 2022 21:15:41 +0000
Received: from DM6NAM11FT104.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b2:cafe::31) by DS7PR03CA0167.outlook.office365.com
 (2603:10b6:5:3b2::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.28 via Frontend
 Transport; Thu, 6 Oct 2022 21:15:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT104.mail.protection.outlook.com (10.13.173.232) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5709.10 via Frontend Transport; Thu, 6 Oct 2022 21:15:41 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 6 Oct
 2022 16:15:40 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Mathias Nyman <mathias.nyman@intel.com>,
        <mika.westerberg@linux.intel.com>
CC:     Mehta Sanju <Sanju.Mehta@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 2/2] xhci-pci: Lower the requirement for runtime PM version to 1.0
Date:   Thu, 6 Oct 2022 16:15:29 -0500
Message-ID: <20221006211529.1858-3-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221006211529.1858-1-mario.limonciello@amd.com>
References: <20221006211529.1858-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT104:EE_|SA0PR12MB4558:EE_
X-MS-Office365-Filtering-Correlation-Id: 7336612a-582c-4687-8c4c-08daa7dfec80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FNmcNOzE6FOrN6TsGqIcnaIYViyJ0pO47ZvZTMT41RPBHQAWR5VLY5QcZrs90HFmGl0ZhKLP7DvWg72aoSnSCVa2zjtjsVA/07RO7VGwOqseYqeUnEk8qMYUWpoHjCZRtqILztDyAHOAFBlF3IwOBfO/avpVQAfMy7TYqkwPdVSALmyrdcnHKXVCBWAFoIX+A/g1isQRIOgPwgcJI0nAQvrfEjSp0UZlMEesqSl9bcRCFSjSaNN8pcGFGOfvds/pz5fu13QSHSYwxNiolAETUusmCvM3LJpHCeeK/Ii9mzdatA8v4zKj0GN7xglZjnG6ZGUjFMI/YB/iys+/xp5O3txvRIfta8ssidI8+bl2UUCenLzvj/xv9AekA29nGoB5vhjHDCKIJtDxMxIBEeK0GzcvB39IgX4Gw/m4ItdnR989YZUAgeCKxX+vopaEE2Yjzx7v6bFs+4ZV6YER38nU1+5Temt9XtUokxcu4MGR+ivDicyjI+znkvea5kamlmE1jija+TUeVSMvDF80yNfcs5y07idRDppCOi0f93F6o5dpFa+YWUUEna9Ei8Uib79Pu4OGCjBa0QfwVadsQsrMIvy8UFwEqHtowfupu1jxMDkIaf9JgTgs2cKcMJ7W0OOCrXQsdEtdNEeufvpD7/uNWdgU+8KLfC1UdpmBR/aq6+UyN3oxqIUIfAQNHQLcVSKM+SGUWG8RbdWQSbqS0xcqPoQQsvbo37gBCE4Adc3D/SaoYX9eZhTId8thtJ/EW2T2EM6dzAh4L2yabU/6jK4lJXHf8ylaFQmg+qSmAem7ruGHICLW1G8J2naUdgnd9M+E7sMiIvx0xszDEf7yLj5+ojN5vUaNbYjsgh6gSHiiKsw=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(396003)(39860400002)(136003)(451199015)(46966006)(40470700004)(36840700001)(44832011)(5660300002)(2906002)(4326008)(86362001)(70206006)(8676002)(41300700001)(8936002)(316002)(40480700001)(82310400005)(81166007)(40460700003)(356005)(36756003)(70586007)(47076005)(82740400003)(83380400001)(186003)(426003)(336012)(1076003)(16526019)(36860700001)(26005)(110136005)(478600001)(966005)(6666004)(7696005)(2616005)(54906003)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2022 21:15:41.2645
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7336612a-582c-4687-8c4c-08daa7dfec80
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT104.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4558
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The XHCI specification has a changelog of new mandatory requirements
in the appendix.  Between versions 1.0 and 1.2 the D3 support was
not made a new mandatory requirement.  As such, all 1.0 controllers
should be safe to allow runtime PM.

This should allow dropping the entire list of controllers from the
driver.

Link: https://www.intel.com/content/dam/www/public/us/en/documents/technical-specifications/extensible-host-controler-interface-usb-xhci.pdf p639+
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
This patch is intentionally split from the first, as I would like Intel
to confirm that all these devices really meet 1.0 or newer xHC version
to avoid causing a potential regression if one was pre-1.0.

 drivers/usb/host/xhci-pci.c | 37 +------------------------------------
 1 file changed, 1 insertion(+), 36 deletions(-)

diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
index 0d2d1cea94a4f..ceb14b3648ed7 100644
--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -46,23 +46,7 @@
 #define PCI_DEVICE_ID_INTEL_BROXTON_B_XHCI		0x1aa8
 #define PCI_DEVICE_ID_INTEL_APL_XHCI			0x5aa8
 #define PCI_DEVICE_ID_INTEL_DNV_XHCI			0x19d0
-#define PCI_DEVICE_ID_INTEL_ALPINE_RIDGE_2C_XHCI	0x15b5
-#define PCI_DEVICE_ID_INTEL_ALPINE_RIDGE_4C_XHCI	0x15b6
-#define PCI_DEVICE_ID_INTEL_ALPINE_RIDGE_LP_XHCI	0x15c1
-#define PCI_DEVICE_ID_INTEL_ALPINE_RIDGE_C_2C_XHCI	0x15db
-#define PCI_DEVICE_ID_INTEL_ALPINE_RIDGE_C_4C_XHCI	0x15d4
-#define PCI_DEVICE_ID_INTEL_TITAN_RIDGE_2C_XHCI		0x15e9
-#define PCI_DEVICE_ID_INTEL_TITAN_RIDGE_4C_XHCI		0x15ec
-#define PCI_DEVICE_ID_INTEL_TITAN_RIDGE_DD_XHCI		0x15f0
-#define PCI_DEVICE_ID_INTEL_ICE_LAKE_XHCI		0x8a13
 #define PCI_DEVICE_ID_INTEL_CML_XHCI			0xa3af
-#define PCI_DEVICE_ID_INTEL_TIGER_LAKE_XHCI		0x9a13
-#define PCI_DEVICE_ID_INTEL_MAPLE_RIDGE_XHCI		0x1138
-#define PCI_DEVICE_ID_INTEL_ALDER_LAKE_XHCI		0x461e
-#define PCI_DEVICE_ID_INTEL_ALDER_LAKE_N_XHCI		0x464e
-#define PCI_DEVICE_ID_INTEL_ALDER_LAKE_PCH_XHCI	0x51ed
-#define PCI_DEVICE_ID_INTEL_RAPTOR_LAKE_XHCI		0xa71e
-#define PCI_DEVICE_ID_INTEL_METEOR_LAKE_XHCI		0x7ec0
 
 #define PCI_DEVICE_ID_AMD_RENOIR_XHCI			0x1639
 #define PCI_DEVICE_ID_AMD_PROMONTORYA_4			0x43b9
@@ -249,25 +233,6 @@ static void xhci_pci_quirks(struct device *dev, struct xhci_hcd *xhci)
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
@@ -328,7 +293,7 @@ static void xhci_pci_quirks(struct device *dev, struct xhci_hcd *xhci)
 	     pdev->device == PCI_DEVICE_ID_AMD_PROMONTORYA_4))
 		xhci->quirks |= XHCI_NO_SOFT_RETRY;
 
-	if (xhci->hci_version >= 0x102)
+	if (xhci->hci_version >= 0x100)
 		xhci->quirks |= XHCI_DEFAULT_PM_RUNTIME_ALLOW;
 
 	if (xhci->quirks & XHCI_RESET_ON_RESUME)
-- 
2.34.1

