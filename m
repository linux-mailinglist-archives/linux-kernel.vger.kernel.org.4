Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DCD1607E7A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 20:57:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbiJUS5h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 14:57:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230086AbiJUS5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 14:57:33 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2058.outbound.protection.outlook.com [40.107.237.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F77528F26F;
        Fri, 21 Oct 2022 11:57:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gyMpALwWrjRBo6Is60IBR5tQH+m54EfR20B2DbfIff/6gtSSluOkvNjQ32rCl3ql18xsnJkLLSScQzEzFvfqt32Qk5tDdZvozZiQVquHc+x3iP9pxVvkVk3WjIU8GmfBAcstUqhE1vjGxb95ANZke9nddX+JZ1UflTh0iibdO2b7LZdCW7qfKgJtI2uUUb46/gF8Tx68HvmBldztY/AdRMdwFVS7eUrVTr2gkskdDTq8ZZp6oIIgmXr6UxN37hyhNwa37dRvNcGyU9/aYZPeK/A/RZTP56z6hBfF25Vr6kIzzB8raOpZx3Lwa1LzBYFvdmPZuyvfWOziUmZunUZo2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g6Dn92GPbW7gIcGIZtAondhwYlN+GFR0oASVtDZ8Nko=;
 b=PCDQIo/hFo9CjDZ8KOrxUuGkxyBi2eQszPeoOUo27rZgma33zWFRKapJp8bGQfBeNA4DIjRaEUHuxq64fqVplsxB+zyFfPcH04R3ElaknG0kuWVS67eaEk5pKZBYQAzEBUHYe41jTdQfAgdR20r6YbDvAED8kZ8im8zh5DiPSNc5NilEaJZEOYY+56CYMdDjP54WZwNkH54nqGr2WgpSp4GCHeMPbWf79KdRow91096624rg7bebKqDudMQO7QMcgDmOSd0A/Xfk/1+fuLQJafROxnmzdCl0DVfdpOdk/KYUFTjsLvAuVgbO2HgU/M1nKuFaNEJIBdjUOHMIEnVWuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g6Dn92GPbW7gIcGIZtAondhwYlN+GFR0oASVtDZ8Nko=;
 b=u9wh0YDGD+sZNP4MOnniP3cYVxQM/ixG7OjRMWiR4HSUH33wMcP9gehhphts7UgEZmgaRejiMQ+jlOK9dLJbPUZ2bn08tRh9mO7XqmMF0TD8dZbrgRldRX85o+mTTXkxLj1U1ZXBKcmPLWUx2e1oJnjJIOsUn1eCp5dmUCiXq6M=
Received: from BN9PR03CA0287.namprd03.prod.outlook.com (2603:10b6:408:f5::22)
 by BY5PR12MB4855.namprd12.prod.outlook.com (2603:10b6:a03:1dd::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.33; Fri, 21 Oct
 2022 18:57:17 +0000
Received: from BN8NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f5:cafe::60) by BN9PR03CA0287.outlook.office365.com
 (2603:10b6:408:f5::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21 via Frontend
 Transport; Fri, 21 Oct 2022 18:57:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT031.mail.protection.outlook.com (10.13.177.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5746.16 via Frontend Transport; Fri, 21 Oct 2022 18:57:16 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 21 Oct
 2022 13:57:15 -0500
From:   Terry Bowman <terry.bowman@amd.com>
To:     <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <dave.jiang@intel.com>, <ira.weiny@intel.com>,
        <bwidawsk@kernel.org>, <dan.j.williams@intel.com>
CC:     <terry.bowman@amd.com>, <linux-cxl@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>,
        <rafael@kernel.org>, <lenb@kernel.org>,
        <Jonathan.Cameron@huawei.com>, <dave@stgolabs.net>,
        <rrichter@amd.com>
Subject: [PATCH 5/5] cxl/pci: Log CXL device's PCIe AER and CXL RAS error information
Date:   Fri, 21 Oct 2022 13:56:15 -0500
Message-ID: <20221021185615.605233-6-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221021185615.605233-1-terry.bowman@amd.com>
References: <20221021185615.605233-1-terry.bowman@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT031:EE_|BY5PR12MB4855:EE_
X-MS-Office365-Filtering-Correlation-Id: 473852d0-1a92-4430-d190-08dab39612be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d0oEYI4VX2aDCBazeUSDuJlT8ou582+5/qkH7QUGYE6T9sDkKZ2cIgaHVwBFeUCy7f/GwiZcvyelo1kAsj5wb19Xut0yvnfHq7Kup/STz/hHvWUrQH/p1FjuouIDQgzt1geIa/VKcR+HIjmMFZXH+etqLDuO72u3pr6YPIGVBT6Oe+7kKLI74shMCKX+vWrXvJ1VN/8TBqJ+js/PNj8ZOQ5dHEW8GQOOVIbt1CJQPc8TOkmao2Tj7llEbKfAX8yKRDOM63XezDecbZTkDriedZ0iBqtTFKLoefvc13KU226LHAs9aJLazSU1R7AKXtnz2tYKsH0YKAYP0Wav4EOjClfIfc2/cS+KdN3HcNrT1xkByPdP4YksHS8j9pClHMoyL2fQNUnKHml9QIR0ES6yK1nfru4DHYwIcHv4BJA8csfh8C1Ikr7+WtPMr2xvn9sdA4ljEOeuuY124r876duMuBQnxBJnistXrmigC4yv/cKumxe+clm38fxBQnQM6S+8MaCgHMhJZALe1gqnEbyC3bOZzpgIEla5b0DgyCjIiBLjQ2Ut2oVXWgFfW+PI+eISG3bIAZTNltJmHyJx9oD6TgDFTVcepLA48xxLhbnz7bEsh20Go5SUPBqNmhZ3GRbaK/2xOnYg6583NxcV+UiIzw9jzI3L+bpi3a58vn8Tk4pyrueRtyreOJu26nCz2C42TGxgE5K0hcllFlC3q9SK8DenNWkYGRq6/BA6u8Vq7u+QVZ0lZDKtNzSKrc7+2YeDYkGaZuSZ+cbga76N7Jb77cEjF3YCxg6yPZSONPum4LrDvRD25V2wwC1/cokOawo+
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(346002)(376002)(396003)(451199015)(40470700004)(36840700001)(46966006)(2906002)(2616005)(40460700003)(186003)(36860700001)(16526019)(47076005)(7696005)(426003)(44832011)(40480700001)(26005)(5660300002)(1076003)(7416002)(41300700001)(110136005)(8676002)(8936002)(316002)(4326008)(478600001)(82310400005)(54906003)(336012)(70206006)(70586007)(86362001)(36756003)(356005)(81166007)(82740400003)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2022 18:57:16.6839
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 473852d0-1a92-4430-d190-08dab39612be
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4855
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The CXL downport PCIe AER and CXL RAS capability information needs to be
logged during PCIe AER error handling.

The existing PCIe AER error handler logs native AER errors but does not
log upport/downport AER capability residing in the RCRB. The CXL1.1
RCRB does not have a BDF and is not enunmerable. The existing error handler
logic does not display CXL RAS details either.

Add a CXL error handler to the existing PCI error handlers. Add a call
to the CXL error handler within the PCIe AER error handler. Implement the
driver's CXL callback to log downport PCIe AER and CXL RAS capability
information.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
---
 drivers/cxl/pci.c      | 76 ++++++++++++++++++++++++++++++++++++++++++
 drivers/pci/pcie/aer.c | 45 ++++++++++++++++++++++++-
 include/linux/pci.h    |  4 +++
 3 files changed, 124 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 80a01b304efe..dceda9f9fc60 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -7,6 +7,7 @@
 #include <linux/sizes.h>
 #include <linux/mutex.h>
 #include <linux/list.h>
+#include <linux/aer.h>
 #include <linux/pci.h>
 #include <linux/pci-doe.h>
 #include <linux/io.h>
@@ -14,6 +15,9 @@
 #include "cxlpci.h"
 #include "cxl.h"
 
+extern void cxl_print_aer(struct pci_dev *dev, int aer_severity,
+			  struct aer_capability_regs *aer);
+
 /**
  * DOC: cxl pci
  *
@@ -744,9 +748,80 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (resource_size(&cxlds->pmem_res) && IS_ENABLED(CONFIG_CXL_PMEM))
 		rc = devm_cxl_add_nvdimm(&pdev->dev, cxlmd);
 
+	dev_set_drvdata(&pdev->dev, cxlmd);
+
 	return rc;
 }
 
+struct ras_cap {
+	u32 uc_error_status;
+	u32 uc_error_mask;
+	u32 uc_error_severity;
+	u32 c_error_status;
+	u32 c_error_mask;
+	u32 ctrl;
+	u32 log[];
+};
+
+/*
+ * Log the state of the CXL downport AER and RAS status registers.
+ */
+static void cxl_error_report(struct cxl_memdev *cxlmd)
+{
+	struct pci_dev *pdev = to_pci_dev(cxlmd->cxlds->dev);
+	struct aer_capability_regs *aer_cap;
+	struct ras_cap *ras_cap;
+
+	aer_cap = (struct aer_capability_regs *)cxlmd->cxlds->aer_map.base;
+	ras_cap = (struct ras_cap *)cxlmd->cxlds->ras_map.base;
+
+	pci_err(pdev, "CXL Error Report\n");
+	pci_err(pdev, "AER Errors:\n");
+	if (aer_cap) {
+		cxl_print_aer(pdev, AER_CORRECTABLE, aer_cap);
+		cxl_print_aer(pdev, AER_NONFATAL, aer_cap);
+		cxl_print_aer(pdev, AER_FATAL, aer_cap);
+	}
+
+	pci_err(pdev, "RAS Errors:\n");
+	if (ras_cap) {
+		pci_err(pdev, "RAS: uc_error_status = %X\n", readl(&ras_cap->uc_error_status));
+		pci_err(pdev, "RAS: uc_error_mask = %X\n", readl(&ras_cap->uc_error_mask));
+		pci_err(pdev, "RAS: uc_error_severity = %X\n", readl(&ras_cap->uc_error_severity));
+		pci_err(pdev, "RAS: c_error_status = %X\n", readl(&ras_cap->c_error_status));
+		pci_err(pdev, "RAS: c_error_mask = %X\n", readl(&ras_cap->c_error_mask));
+		pci_err(pdev, "RAS: ras_caps->ctrl = %X\n", readl(&ras_cap->ctrl));
+		pci_err(pdev, "RAS: log = %X\n", readl(&ras_cap->log));
+	}
+}
+
+static void cxl_error_detected(struct pci_dev *pdev)
+{
+	struct cxl_memdev *cxlmd;
+
+	if (!is_cxl_memdev(&pdev->dev)) {
+		pci_err(pdev, "CXL memory device is invalid\n");
+		return;
+	}
+
+	cxlmd = dev_get_drvdata(&pdev->dev);
+	if (!cxlmd) {
+		pci_err(pdev, "CXL memory device is NULL\n");
+		return;
+	}
+
+	if (!cxlmd->cxlds) {
+		pci_err(pdev, "CXL device state object is NULL\n");
+		return;
+	}
+
+	cxl_error_report(cxlmd);
+}
+
+static struct pci_error_handlers cxl_error_handlers = {
+	.cxl_error_detected = cxl_error_detected,
+};
+
 static const struct pci_device_id cxl_mem_pci_tbl[] = {
 	/* PCI class code for CXL.mem Type-3 Devices */
 	{ PCI_DEVICE_CLASS((PCI_CLASS_MEMORY_CXL << 8 | CXL_MEMORY_PROGIF), ~0)},
@@ -761,6 +836,7 @@ static struct pci_driver cxl_pci_driver = {
 	.driver	= {
 		.probe_type	= PROBE_PREFER_ASYNCHRONOUS,
 	},
+	.err_handler		= &cxl_error_handlers,
 };
 
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index e2d8a74f83c3..dea04d412406 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -811,6 +811,13 @@ void cper_print_aer(struct pci_dev *dev, int aer_severity,
 }
 #endif
 
+void cxl_print_aer(struct pci_dev *dev, int aer_severity,
+		    struct aer_capability_regs *aer)
+{
+	cper_print_aer(dev, aer_severity, aer);
+}
+EXPORT_SYMBOL_GPL(cxl_print_aer);
+
 /**
  * add_error_device - list device to be handled
  * @e_info: pointer to error info
@@ -1169,6 +1176,40 @@ static void aer_isr_one_error(struct aer_rpc *rpc,
 	}
 }
 
+static int report_cxl_errors_iter(struct pci_dev *pdev, void *data)
+{
+	struct pci_driver *pdrv = pdev->driver;
+
+	if (pdrv &&
+	    pdrv->err_handler &&
+	    pdrv->err_handler->cxl_error_detected)
+		pdrv->err_handler->cxl_error_detected(pdev);
+
+	return 0;
+}
+
+static void report_cxl_errors(struct aer_rpc *rpc,
+			      struct aer_err_source *e_src)
+{
+	struct pci_dev *pdev = rpc->rpd;
+	struct aer_err_info e_info;
+	u32 uncor_status, cor_status;
+
+	pci_read_config_dword(pdev, pdev->aer_cap + PCI_ERR_UNCOR_STATUS, &uncor_status);
+	pci_read_config_dword(pdev, pdev->aer_cap + PCI_ERR_COR_STATUS, &cor_status);
+
+	if (!uncor_status && !cor_status)
+		return;
+
+	if (pci_pcie_type(pdev) == PCI_EXP_TYPE_RC_EC)
+		pcie_walk_rcec(pdev, report_cxl_errors_iter, &e_info);
+	else
+		pci_walk_bus(pdev->subordinate, report_cxl_errors_iter, &e_info);
+
+	pci_write_config_dword(pdev, pdev->aer_cap + PCI_ERR_UNCOR_STATUS, uncor_status);
+	pci_write_config_dword(pdev, pdev->aer_cap + PCI_ERR_COR_STATUS, cor_status);
+}
+
 /**
  * aer_isr - consume errors detected by root port
  * @irq: IRQ assigned to Root Port
@@ -1185,8 +1226,10 @@ static irqreturn_t aer_isr(int irq, void *context)
 	if (kfifo_is_empty(&rpc->aer_fifo))
 		return IRQ_NONE;
 
-	while (kfifo_get(&rpc->aer_fifo, &e_src))
+	while (kfifo_get(&rpc->aer_fifo, &e_src)) {
+		report_cxl_errors(rpc, &e_src);
 		aer_isr_one_error(rpc, &e_src);
+	}
 	return IRQ_HANDLED;
 }
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 2bda4a4e47e8..4f4b3a8f5454 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -827,6 +827,10 @@ enum pci_ers_result {
 
 /* PCI bus error event callbacks */
 struct pci_error_handlers {
+
+	/* CXL error detected on this device */
+	void (*cxl_error_detected)(struct pci_dev *dev);
+
 	/* PCI bus error detected on this device */
 	pci_ers_result_t (*error_detected)(struct pci_dev *dev,
 					   pci_channel_state_t error);
-- 
2.34.1

