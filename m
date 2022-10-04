Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9534B5F3C09
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 06:13:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbiJDENN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 00:13:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbiJDEMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 00:12:55 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2059.outbound.protection.outlook.com [40.107.243.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3D4A26562;
        Mon,  3 Oct 2022 21:12:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HRcGsbA0t3ByHHoRJdjARETvdtXVqtUCQ0T/3Amj220HwUKQtEisHQV/tKs8XLGKVPj/IX3kS5I7KEjD1pOraP9khvWdYyNxShn+wLEQGaXezshI3qG+g5w8W75TYhwsqKVVx/sd8GqO9/4XNo6e//WonEcaCpOf+2X61wWVm0K/8qoQJOwFSumxiHkqLuD0QJz8mHWz9Tssp2CRadTAvydvICnVZ+zIlMFSTqpV2pZ5H9Se0RU1WbCnl7piLSLNaLw2NAHQumBYWTDksnovmaFIVEcQyBjIN7iU/3FzYMWvT9FkzfB+eEZvLDbjTlUTKcTjNmN4vvYRXEY2dPk1Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K8vNCnYCQ8noFpvUzUi38+/Uk7zudR4MubiMYo1Sfhg=;
 b=g2j1OVEeBY5EuQccTUk0whNAwqSWCND0Dk0iy2S45qOsJgrjt0MZqhhu7FcdztmYvPy3578w6V29mhLLK3n/FAQ4FBhXOLE6LNJyJGW6U/LNAA3KOwTLTHdbEIuaIRkPnWZwncIc6Gbcx4jA0aMNGyjsDAp2H06sTtXMtawYNfMroFmRBTXBAeSzqpqWaf3yZ3llfZAm2oABNUexopqT+Kq2nnITty4NLU3ULanNdRrRWdGQkr/d2rZxvqOrtFGn1Md3a3CDNt6q4sRPmEauflMiDsrLW1rsFc/e1T2zcWKh0dmyQYScs/6+ix/KNIjCotqoAXlsnqhTD8p2io7S3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K8vNCnYCQ8noFpvUzUi38+/Uk7zudR4MubiMYo1Sfhg=;
 b=3zFvG+1tqW6m18lP8pIK+A/Jr/IQoOzs9cj7yMKXadv0GVYH3qA3V2hoEhW6pradnEh03vlMDwurlh/B7DXXrnfw2bYNFcOUG8fLwqlfv5VrEwMM6eiELt1+fGtRvkQUg8ij2w4f510TsXM//6wliVhubnDY60Ad29iEzSYycj0=
Received: from BN9PR03CA0133.namprd03.prod.outlook.com (2603:10b6:408:fe::18)
 by BN9PR12MB5178.namprd12.prod.outlook.com (2603:10b6:408:11b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24; Tue, 4 Oct
 2022 04:12:48 +0000
Received: from BN8NAM11FT080.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fe:cafe::8d) by BN9PR03CA0133.outlook.office365.com
 (2603:10b6:408:fe::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.23 via Frontend
 Transport; Tue, 4 Oct 2022 04:12:48 +0000
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
Subject: [RFC 3/3] xhci-pci: Allow host runtime PM as default for AMD Pink Sardine
Date:   Mon, 3 Oct 2022 23:12:25 -0500
Message-ID: <20221004041225.1462336-4-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT080:EE_|BN9PR12MB5178:EE_
X-MS-Office365-Filtering-Correlation-Id: 38d2a5bc-e56b-405b-ebfc-08daa5beb24d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qlr5U1LRASfKdaxI4yZjLzYQAeYr1C8O2XdmHE8YHgz/AJKNr0nt/gSQ7bt/WTbp4GGzT12FFQ9LCvrQ+yiB1m6kG07ckyn7Xa/xtfikn1aKQiMi56IkVsgyc/B0PEhcZbe9/0AXelsXyW80b936vzanDebTKnF2/FEd3O2q50LT1xuT7CUPrVKrXq4NPbV7UH06992mpZaQx9f71y+AVwxU/r4n4pghiO34BB7SzGcMYwq/8TQTd7CidHFmiBVuuSSPF4AfgQmHhqJQNOQrTHawvcVKXW4dvgWdMEUBnKGLqlwz9KG7+hPdEFVNiKpa2o3JZDeGk66vxBPNTHLr43ejGn306m+6kA8457VYvLW/Ml3zI+fNrjni+foX3m0JmjRPm3GxvYX3CZA6Xh5L+3Ac7LsPgf4F2HUmvDP1f5kL9a2PBIj2vgOdlP5nyWr2OyHKv27p0Kji7wDBanmBpiEk6eDLBNEurg+fqV4a2OHhQA3w7zBAuXmah3FOZ+Bv7nWy9muBgxxm2o7/j6/7lNU+G9M/fr58QaaKap0jr76uCHbPCI0QsFsE+6Dw+zsCETLj3OrjjoRhnKFOKP7RKYgGQAPZFgE9YxZH5jUTfnVkVrV68lxJFoo1p1f/6B0Z6ePpQmkYdS7GnjN8mw02PNIjrv8YdUf8mI1xY7KXELOsrrUy3JrB1lVTKmIpy5SnRYwrqu1wZDU6KOtLS5r2M/ubnDjYM3in6nrryWQUCOhxsyh2FwGrPgaCO6m2SNI5JKTr0SVclI3LwQdLzYS7GqekgafU72u5HfrBbgkuwKj1IQ0cS0OK0ep9dx8u2NYF
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(39860400002)(396003)(376002)(451199015)(46966006)(40470700004)(36840700001)(478600001)(82310400005)(186003)(1076003)(2616005)(8936002)(2906002)(5660300002)(356005)(426003)(47076005)(6666004)(16526019)(70586007)(70206006)(8676002)(4326008)(336012)(26005)(6916009)(54906003)(36756003)(316002)(40480700001)(36860700001)(40460700003)(82740400003)(44832011)(81166007)(86362001)(83380400001)(41300700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2022 04:12:47.9385
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 38d2a5bc-e56b-405b-ebfc-08daa5beb24d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT080.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5178
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The XHCI controllers not connected to the USB4 controller via a device
link can support D3. For optimal runtime power consumption on AMD Pink
Sardine, all XHCI controllers must support runtime suspend.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/usb/host/xhci-pci.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
index 44defa8b796f7..a569b29a46a99 100644
--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -69,6 +69,8 @@
 #define PCI_DEVICE_ID_AMD_YELLOW_CARP_XHCI_4		0x161e
 #define PCI_DEVICE_ID_AMD_YELLOW_CARP_XHCI_5		0x161c
 #define PCI_DEVICE_ID_AMD_YELLOW_CARP_XHCI_6		0x161f
+#define PCI_DEVICE_ID_AMD_PINK_SARDINE_XHCI_1		0x15b9
+#define PCI_DEVICE_ID_AMD_PINK_SARDINE_XHCI_2		0x15ba
 
 #define PCI_DEVICE_ID_ASMEDIA_1042_XHCI			0x1042
 #define PCI_DEVICE_ID_ASMEDIA_1042A_XHCI		0x1142
@@ -328,7 +330,9 @@ static void xhci_pci_quirks(struct device *dev, struct xhci_hcd *xhci)
 	    pdev->device == PCI_DEVICE_ID_AMD_YELLOW_CARP_XHCI_3 ||
 	    pdev->device == PCI_DEVICE_ID_AMD_YELLOW_CARP_XHCI_4 ||
 	    pdev->device == PCI_DEVICE_ID_AMD_YELLOW_CARP_XHCI_5 ||
-	    pdev->device == PCI_DEVICE_ID_AMD_YELLOW_CARP_XHCI_6))
+	    pdev->device == PCI_DEVICE_ID_AMD_YELLOW_CARP_XHCI_6 ||
+	    pdev->device == PCI_DEVICE_ID_AMD_PINK_SARDINE_XHCI_1 ||
+	    pdev->device == PCI_DEVICE_ID_AMD_PINK_SARDINE_XHCI_2))
 		xhci->quirks |= XHCI_DEFAULT_PM_RUNTIME_ALLOW;
 
 	if (xhci->quirks & XHCI_RESET_ON_RESUME)
-- 
2.34.1

