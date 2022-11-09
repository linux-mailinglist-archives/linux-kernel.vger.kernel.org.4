Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 140046228BB
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 11:42:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231193AbiKIKmF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 05:42:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231127AbiKIKlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 05:41:46 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2045.outbound.protection.outlook.com [40.107.93.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 588D02655B;
        Wed,  9 Nov 2022 02:41:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YlQ711kwq5wBQwi7ZyQDAjnZC/bZmCFyCpGAPP6VKtdBiGlWOoM7CwUIp1mJ4nJjsMXgEYoptTFJi5jt9MEX6KgXLXdOnSH09SR9YwTcC/+TL1oGynW4USk97XrVvB1pPwLIVaSbhJOaDsbS+8kJUyN/4pI99QCApbZ4mbiL7Yro8Ud9/2MyHzAGrAKDumbcDjpiMNP5upfCU4fymbcuEfX31Zk2wI+V+EieS+ObIVQI2ZCNgnQZbM9OkXqzRmiS0zo/U7djgLn1+LlU4iXdhGWa436DsVniJDeTNOh2VP7GJ8Ka3DmutqVEbRVnF8OVgQqIy8UsxPWUBPHfxuZlQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nS3RJuVhOl31ZYeV432y068pJtOlAuTnnT5e2/RDVFE=;
 b=gMssLs4XiWU0SrJNyWiFVtutHi5c8Lb/uaejiQpQ8fzs4diiOh1WvOoi0CFJlxX9CdfEjZ8XF3lTCXhU1qD/0owhYQyguOwuaRHCsw0XXhy36nChb/VA8p37qRME95a8NIMRJo+hgKNC4mjJfIuubS3IUNsyVOCUyO0pBZm3vUv+LKj0Uy30/aNrVFR6WcLnT/c7hHRy8G+QL29f9PhMYablbOswz1c0y6QtooKbMgrwc6ggM7IqVaObgm014eLiodmv2z6Cgi6SqwgEur7X3UONWMPus5TO7MstBjIx2mjPHDIb/glYbuIz0+9MvmttPxyx3Bp0ncNIEfVBvJSlCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nS3RJuVhOl31ZYeV432y068pJtOlAuTnnT5e2/RDVFE=;
 b=KUpyQ9FuArG6hySGCLlGJnOeM57od8hunbRTaA2ynHtQRkAlFqLzAsaGBbny+AvF+ztUt8bLHW95VVe/kHvriCbtRcBjLja7Bizj0MU8HsUKGldhYOG+zhZ8TspbMFQexpr63VsqQSdUW/LU9TOzB0gNQ9IymrNcYrZFhVtBeIQ=
Received: from BN0PR04CA0062.namprd04.prod.outlook.com (2603:10b6:408:ea::7)
 by MW4PR12MB7239.namprd12.prod.outlook.com (2603:10b6:303:228::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27; Wed, 9 Nov
 2022 10:41:41 +0000
Received: from BN8NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ea:cafe::22) by BN0PR04CA0062.outlook.office365.com
 (2603:10b6:408:ea::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27 via Frontend
 Transport; Wed, 9 Nov 2022 10:41:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT031.mail.protection.outlook.com (10.13.177.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5813.12 via Frontend Transport; Wed, 9 Nov 2022 10:41:41 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 9 Nov
 2022 04:41:32 -0600
From:   Robert Richter <rrichter@amd.com>
To:     Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "Davidlohr Bueso" <dave@stgolabs.net>,
        Dave Jiang <dave.jiang@intel.com>,
        Robert Richter <rrichter@amd.com>
Subject: [PATCH v3 5/9] cxl/pci: Only register RCDs with device 0, function 0 as CXL memory device
Date:   Wed, 9 Nov 2022 11:40:55 +0100
Message-ID: <20221109104059.766720-6-rrichter@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221109104059.766720-1-rrichter@amd.com>
References: <20221109104059.766720-1-rrichter@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT031:EE_|MW4PR12MB7239:EE_
X-MS-Office365-Filtering-Correlation-Id: ddd8ab70-2fa1-40b1-f37c-08dac23efccc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y6/d7+PK4NJVWpH1W0AwtNNJLHO1LEtagbmHg2WGeJsfb0cmXvpPqSDWMUhkKt7yiszXCCNZAoTZrCVbaMR9N5COoMz2MkrkokyyHSEge4Ik0PpdKjDbiniGkrhLoCHAh5aBS4yqndaTRSzKIU8W32pv10mq/b/gvX8wmOv1Am6VpGLPkjtaPzw2OGDLyfeZPRABE2PxspIruvKHFT3O1vCSaMDc08GU0jB8sQfGKqHDd13NLJaWFSBJoAdra83UW6UU9SdUUSCVD3muDAL2bdDlDZ6wQhvlEirt1WhsSpEkZpi/atFyaOY91liHWid158PmC9QaGzsoOma1Z/fYVzltPfNgYsW8vRBPAbwt7aoKAZ5g9uDk4XFDG/Q88yb8MSZgW3T+ZC0/Su9kezd0JoXKKtZhS1o6ZS9MxQDTw0Nw7Lrg8PHxWaoN3GXFfAXEsQiYE1m1Fdy/yQWvHRgWo/jLfaKckt7YwwojVmgLWMdi041I4J/dREQWKsLYOGrgDB2T2nko1CTMFQoP3dWOOR6t2HPx4MqbTv8veepGua0m0FPq40Qpb2q75V8btEOalq8eu1Nv+UnV4uanQyigI8nLyaL3bYjuP7DQmb/9W7WHgXW2nB6lgvZfZPKnalt0uNslvzbTVur3f16MhIEJkuu7wevzumX/HMzLFSBVpo0YmepMcZhS0NUwqOCT32xakXnocvE2QuBdhUZuQyzxdJS5ior21GMd6iajssBb8wNKvCs0qgZa6cGnljkcPpsevTHpjLj7pBFANsT+JD72I3xwnMyVmTH/m/23oTanktUf0sk9fxaVyQjpPrVA0c/+
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(396003)(376002)(136003)(451199015)(40470700004)(46966006)(36840700001)(356005)(81166007)(36756003)(26005)(2616005)(40460700003)(82740400003)(82310400005)(7416002)(8936002)(83380400001)(2906002)(5660300002)(8676002)(70206006)(4326008)(41300700001)(54906003)(70586007)(40480700001)(316002)(186003)(1076003)(478600001)(16526019)(47076005)(426003)(336012)(6666004)(36860700001)(110136005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2022 10:41:41.0928
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ddd8ab70-2fa1-40b1-f37c-08dac23efccc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7239
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Device 0, Function 0 DVSEC controls the CXL functionality of the
entire device. Add a check to prevent registration of any other PCI
device on the bus as a CXL memory device.

Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/cxl/pci.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index faeb5d9d7a7a..cc4f206f24b3 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -428,11 +428,26 @@ static void devm_cxl_pci_create_doe(struct cxl_dev_state *cxlds)
 	}
 }
 
+static int check_restricted_device(struct pci_dev *pdev, u16 pcie_dvsec)
+{
+	if (pci_pcie_type(pdev) != PCI_EXP_TYPE_RC_END)
+		return 0;		/* no RCD */
+
+	if (pdev->devfn == PCI_DEVFN(0, 0) && pcie_dvsec)
+		return 0;		/* ok */
+
+	dev_warn(&pdev->dev, "Skipping RCD: devfn=0x%02x dvsec=%u\n",
+		pdev->devfn, pcie_dvsec);
+
+	return -ENODEV;
+}
+
 static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	struct cxl_register_map map;
 	struct cxl_memdev *cxlmd;
 	struct cxl_dev_state *cxlds;
+	u16 pcie_dvsec;
 	int rc;
 
 	/*
@@ -442,6 +457,13 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	BUILD_BUG_ON(offsetof(struct cxl_regs, memdev) !=
 		     offsetof(struct cxl_regs, device_regs.memdev));
 
+	pcie_dvsec = pci_find_dvsec_capability(
+		pdev, PCI_DVSEC_VENDOR_ID_CXL, CXL_DVSEC_PCIE_DEVICE);
+
+	rc = check_restricted_device(pdev, pcie_dvsec);
+	if (rc)
+		return rc;
+
 	rc = pcim_enable_device(pdev);
 	if (rc)
 		return rc;
@@ -451,8 +473,7 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		return PTR_ERR(cxlds);
 
 	cxlds->serial = pci_get_dsn(pdev);
-	cxlds->cxl_dvsec = pci_find_dvsec_capability(
-		pdev, PCI_DVSEC_VENDOR_ID_CXL, CXL_DVSEC_PCIE_DEVICE);
+	cxlds->cxl_dvsec = pcie_dvsec;
 	if (!cxlds->cxl_dvsec)
 		dev_warn(&pdev->dev,
 			 "Device DVSEC not present, skip CXL.mem init\n");
-- 
2.30.2

