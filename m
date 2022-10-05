Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 030395F5AEF
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 22:24:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230383AbiJEUYF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 16:24:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbiJEUXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 16:23:48 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB8D552E5D;
        Wed,  5 Oct 2022 13:23:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k+qrTKLKrz2qYsA/hJgY03g0U6FOJCLZgQuQuk9PHaNe9RWeVQc+lkjUmBXY0FDtKhOd9/kQttyQteOJNFt+PL+XohaA93CU1ejRQEKetUPdFrpDtXO0diJnAxA2VtxsvP/f55fkR9GPHOnZ+P53Ru3CQf7swmIOz7511Evld56bkJcn0kmjuAwV8BrfbNTvOVGvCSaJ+eJ514uBd8FniV1fQ+xFRvoNzIPpP6f/zUdX2xN+nHYh0lvnNZ5cmQaCM6GThWIJ8bpR/kUgpGcBdLPfI6P62h1R7g84gTRSD866mLuTaDZEYpr4UbbhtOQkKVesNKTr9P0CgAg35F5IMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aIb/pm+/xArYkw9iZhejHSYZDfF+1lxSmkXgqvDyYlU=;
 b=gp6UahDM7lmTTiNQKG2A4svvsgfDHR9AGILxM5lMYYTFI3wZLlHp5/iLIZHrEGc66vScLSpQBHfNkkJ8XRmUX+2IfC80cSYTPi3PbCQfcdAFcrybceUPjcVUX9yS162174UFlIP7wMLxRI60k0cMMazNexqI0vx2kvlYPWWqBIiUu4Q1occfG8NPtMf7wd108PnRSfbzajCHwDsj/CdtYZrZDkum15EjalVhfTdwVkUyPelqlV5F05oGlOAAH0XNgHrQkXYZkvXqZjo2iaQ1rghTxQR0wgpVbrBcr0GB4C+yHIGg5QRCfwoWnZFpMrKrIIvynpRwo2Si+KgOpLwaIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aIb/pm+/xArYkw9iZhejHSYZDfF+1lxSmkXgqvDyYlU=;
 b=MlqYmbv/op9sJQmqJKQlb38bo/wQPllOxWrBm7qsNGII9JuSDZuMkXsCg5x5pzdBtRU/Patl5NSmrcvjUYgD9lQ4fNw9YHnHKMKOWVllO1mSTCQXYOCQhVj24qd5SLI1Kca4X7dY98d9PAqVkzrhaCNYTBoVVYnLAwxHZ1mfE00=
Received: from DM6PR03CA0063.namprd03.prod.outlook.com (2603:10b6:5:100::40)
 by PH7PR12MB5758.namprd12.prod.outlook.com (2603:10b6:510:1d1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.35; Wed, 5 Oct
 2022 20:23:44 +0000
Received: from DM6NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:100:cafe::d5) by DM6PR03CA0063.outlook.office365.com
 (2603:10b6:5:100::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24 via Frontend
 Transport; Wed, 5 Oct 2022 20:23:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT009.mail.protection.outlook.com (10.13.173.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5709.10 via Frontend Transport; Wed, 5 Oct 2022 20:23:44 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 5 Oct
 2022 15:23:43 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <mathias.nyman@intel.com>, <mika.westerberg@linux.intel.com>
CC:     <Sanju.Mehta@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/4] xhci-pci: Remove a number of controllers from the runtime PM allowlist
Date:   Wed, 5 Oct 2022 15:23:51 -0500
Message-ID: <20221005202353.1269-4-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: DM6NAM11FT009:EE_|PH7PR12MB5758:EE_
X-MS-Office365-Filtering-Correlation-Id: de018c1e-df01-4091-7412-08daa70f806b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 17kctkJFp9xyVbzVvUpyX+PyepSWBsFtHAd8REFbo/V2+fzLu1HObTDsA9MmO2FWK6cIH4GmiZnC4DD3ogRebF/2rDHDRdIgOs/Zl61CRF+3u/S2byBH7Od+Bi5sB5yURC3DL6DT/iuruQM41JarZi0qRbBLwqB7px7Op1GCkXhBeI42mcXwaYzldqX0H37WnlL0iOJj2XPNRLecZgqj0gLEmV6ua9YYV4nn45PWyUpEcgTSlLGtQgxATWMbtUfTgvox7lVp4jPW0jjd570RQPMzmGXSrolfKEJgA+Psiq66lA/KeMpaJ2DHXkPvnGqZSmyo9JRTLecUWANDPsSav1wbOyQWh0ppUZIPc2VgoQxJ3H+1jzv7FSoclibKVQyzLSna9UbThBTvzVlvaGNx5jkkirile5Ecj5TW1tSPfmdReQkGOdLEB0T1f5NN075q2jq4VOMRlZQf35qVpCkkZ083ftTiRUxVHysUgrAIVBsq0lkH/2/ZdZG4U+0Z5P+hsgX4fHtxpBT4bH9rRtkU92MnQ1cpXFmPsD75vEoCqt/z3gj8N3XMlPY3qn2MsEiAT6WjF30l6GdG0GW3Bf5eCF1UXG6O+aclCj9PomXaJMXO9c1d7m2iHvTZgImTc8Zi0VNvtejZvVKu3U3lONDCRPUl/2O10eLzGBnLUyw4sicl00jKf5oHHUbsoX3QB0VKDRVaG/1C3q4xO7TjtQg0Owll6cneTEGrG26Fykp8uZbqIUEX9rMH+Nc6l15kyTdsMkO+m2+BQl8YNpi52xjPU12EaRCaqAUL2IA7wdUARppC3jPIpmboQU6uO10vp3XfjjTP1kTqALStKKuFtALcFg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(376002)(396003)(39860400002)(451199015)(40470700004)(46966006)(36840700001)(36756003)(336012)(86362001)(426003)(36860700001)(44832011)(54906003)(8936002)(82740400003)(47076005)(356005)(110136005)(16526019)(81166007)(2616005)(66574015)(83380400001)(1076003)(7696005)(26005)(4326008)(6666004)(40460700003)(316002)(478600001)(40480700001)(41300700001)(5660300002)(186003)(82310400005)(70586007)(70206006)(8676002)(2906002)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2022 20:23:44.6282
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de018c1e-df01-4091-7412-08daa70f806b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5758
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,UPPERCASE_50_75 autolearn=no
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
* commit f886d4fbb7c97 ("usb: xhci: Extend support for runtime power
management for AMD's Yellow carp.")

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
RFC v1->PATCH v1:
 * Drop ICL and TGL, these need it even for FW CM and don't have
   device links
 * Rebase on top of patch to make a table instead
---
 drivers/usb/host/xhci-pci.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
index 6e5bcec9b2b16..c17f748b05929 100644
--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -58,11 +58,7 @@
 #define PCI_DEVICE_ID_INTEL_CML_XHCI			0xa3af
 #define PCI_DEVICE_ID_INTEL_TIGER_LAKE_XHCI		0x9a13
 #define PCI_DEVICE_ID_INTEL_MAPLE_RIDGE_XHCI		0x1138
-#define PCI_DEVICE_ID_INTEL_ALDER_LAKE_XHCI		0x461e
-#define PCI_DEVICE_ID_INTEL_ALDER_LAKE_N_XHCI		0x464e
 #define PCI_DEVICE_ID_INTEL_ALDER_LAKE_PCH_XHCI	0x51ed
-#define PCI_DEVICE_ID_INTEL_RAPTOR_LAKE_XHCI		0xa71e
-#define PCI_DEVICE_ID_INTEL_METEOR_LAKE_XHCI		0x7ec0
 
 #define PCI_DEVICE_ID_AMD_RENOIR_XHCI			0x1639
 #define PCI_DEVICE_ID_AMD_PROMONTORYA_4			0x43b9
@@ -73,10 +69,8 @@
 #define PCI_DEVICE_ID_AMD_REMBRANDT_XHCI_2		0x161b
 #define PCI_DEVICE_ID_AMD_REMBRANDT_XHCI_3		0x161d
 #define PCI_DEVICE_ID_AMD_REMBRANDT_XHCI_4		0x161e
-#define PCI_DEVICE_ID_AMD_REMBRANDT_XHCI_5		0x15d6
-#define PCI_DEVICE_ID_AMD_REMBRANDT_XHCI_6		0x15d7
-#define PCI_DEVICE_ID_AMD_REMBRANDT_XHCI_7		0x161c
-#define PCI_DEVICE_ID_AMD_REMBRANDT_XHCI_8		0x161f
+#define PCI_DEVICE_ID_AMD_REMBRANDT_XHCI_5		0x161c
+#define PCI_DEVICE_ID_AMD_REMBRANDT_XHCI_6		0x161f
 
 #define PCI_DEVICE_ID_ASMEDIA_1042_XHCI			0x1042
 #define PCI_DEVICE_ID_ASMEDIA_1042A_XHCI		0x1142
@@ -98,11 +92,7 @@ static const struct pci_device_id runtime_allow_pci_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICE_LAKE_XHCI) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_TIGER_LAKE_XHCI) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_MAPLE_RIDGE_XHCI) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ALDER_LAKE_XHCI) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ALDER_LAKE_N_XHCI) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ALDER_LAKE_PCH_XHCI) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_RAPTOR_LAKE_XHCI) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_METEOR_LAKE_XHCI) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_REMBRANDT_XHCI_1) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_REMBRANDT_XHCI_2) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_REMBRANDT_XHCI_3) },
@@ -110,8 +100,6 @@ static const struct pci_device_id runtime_allow_pci_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_REMBRANDT_XHCI_4) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_REMBRANDT_XHCI_5) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_REMBRANDT_XHCI_6) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_REMBRANDT_XHCI_7) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_REMBRANDT_XHCI_8) },
 	{ 0 }
 };
 
-- 
2.34.1

