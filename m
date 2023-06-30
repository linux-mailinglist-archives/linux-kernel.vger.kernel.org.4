Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22101744520
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jul 2023 01:20:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232656AbjF3XT6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 19:19:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232775AbjF3XTV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 19:19:21 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on20604.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe5a::604])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8963E49D0;
        Fri, 30 Jun 2023 16:18:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T2m5FsyXA2sNbo1G5YsQe5XSAU9hFbmL+LDCkWrKanEesB02T8WSnapK+sNYW+pf+atd6SHa8SJ5efgPMc2IckiORnCzaZ2ygauCtl31x63a7B8/p+kQy+Mg3BzH9sx7koJd/UV3CgRsgXiSh+QsnuCYZ9ko/M4NVsA0WSc4KzcYYd4BvdBvyE6B0UYA6hiu3eJGE80C0wic2JeIo7j6E5hceHsuGkyiFOSR6wpFuiaav/KtP45aQr0EFCK1OH36yb0SnuJIe5Z1jpr1a8mZc0Py8nRBnGNVJqUZjEGVTwlZ2VBQZQe7w3hd8u/MpHygkyKGS8I0AhwQlH64l4HrwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zrropQhLceQl7tGToOfeISiMGtGWPfSCW9YAyl/WFo4=;
 b=McMU3bpUJsi/zYzAXChap0ga0BMzcLeKqtKu87abj13vsAWYjzu3n5hDlkCb+o/UUhNpr/hFd+0BDopzKgLHxkeLkiD4Thjj4VajHY2t6pdSBWRqbw7EuLrKheMneIpHuEZOsTU/T4X9gSg55NKoinj82dOQtC1hSc5p+1zsolsf0zmBXNzG3mi39kR/h7wKhALi1GIIS/Wc4H4PwINRutMnrNrCaSZNqJ9jdMuhWzgK3UruNW4BETw/NT7V9yMUfmz/cQxLpbiulQq8fzlDXBsh4WMFuopOUfb6spq/lhYS1EYIEU60EUwCUZ9thHuH48wP28hy+vBjZHPuXZhUfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zrropQhLceQl7tGToOfeISiMGtGWPfSCW9YAyl/WFo4=;
 b=P8aB+UTNxM1VXgBqj2Nkey02E3jFJHuVmG3JdOvSm9md7lh1zEHSTSTw1Z78KDm4OWF/hsS0RY13Ld9nEnnoaE6oPKgB5cUK41Tn7EjYojL6qnpiLMuxDXSAE44DR9wXDqM9tv0PQPzC9dt95aDPIciwFakGCsn6km4Ksy0w9cU=
Received: from BY5PR04CA0001.namprd04.prod.outlook.com (2603:10b6:a03:1d0::11)
 by MW4PR12MB6874.namprd12.prod.outlook.com (2603:10b6:303:20b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.15; Fri, 30 Jun
 2023 23:18:41 +0000
Received: from DM6NAM11FT071.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:1d0:cafe::b8) by BY5PR04CA0001.outlook.office365.com
 (2603:10b6:a03:1d0::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.22 via Frontend
 Transport; Fri, 30 Jun 2023 23:18:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT071.mail.protection.outlook.com (10.13.173.48) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.43 via Frontend Transport; Fri, 30 Jun 2023 23:18:40 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 30 Jun
 2023 18:18:39 -0500
From:   Terry Bowman <terry.bowman@amd.com>
To:     <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <bwidawsk@kernel.org>,
        <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
        <Jonathan.Cameron@huawei.com>, <linux-cxl@vger.kernel.org>
CC:     <terry.bowman@amd.com>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: [PATCH v8 10/14] cxl/pci: Add RCH downstream port error logging
Date:   Fri, 30 Jun 2023 18:16:31 -0500
Message-ID: <20230630231635.3132638-11-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230630231635.3132638-1-terry.bowman@amd.com>
References: <20230630231635.3132638-1-terry.bowman@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT071:EE_|MW4PR12MB6874:EE_
X-MS-Office365-Filtering-Correlation-Id: fb76e144-cf02-43ec-83ce-08db79c056fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vKvOCwE8GJvUQBcWlnx9yIJg7y2Tyrkvu5wDo9dUHqh/7UhxJiptLHXdFZYZE1kPEJSPi00tC8Bn87ylaDgrLZsR/nJqvZ6VUzLlcKtc/K4kPnhSt7L4RpgFgeHXng6DZIry4pSOAoH4Bp7d0mRFvhG/vNs4qVObPWbmCO7e/LPuyiiuwrb6ZP722SM10mNOST/tAyrCQw0jjUxoits7qEtFJg2b7A1NECM+xH1N+P45UPFYUS2G6/O9zFV51g6TeQvhCXtJEL6BY1MXxkCfOv2POO4gKAPUZxK8cCuJt7xEnH8qXosSSiWKTVJN1BUbPvI60ds4yDhfw2keFElcBRQ2mrcpXJS41CxHhfU46ul6QpPd+oz/nlnrPr8gxlWcSHzu0mGjCEL5QiBGzErHMFWYqy5msQYhSlNSjgaAoFc61WKpaVm/tI/sr2qktLKZlZ5fTqDoYveNSkHSHiDd6Komb/VWNw3MXtx2HcOW5AXR0onmcZOmMVzagGiYHmlryZ2xucAztCn2R3QjP7Z8fATT7jTxfpj5VBAQBq8XY6EylS4PL+ReiSfhhp2APHFroBTycfHltae3lL1UpLMLVeB/KQvI9NehYkfVe5he0KCHdI/cjoIxW+P8JOaDJLI9cTPphx+xLd0k/VCbeIoTu26Itjk63QQXH7DDabHs7mYshk5wPdZCvLO7T8BcH4w8zjsFERh6bTYLMvSQpHlb72VNlBqI7eStt6V9dS4De+kxKZvyx7spDQn8SQpoR2eSYsHZtG4uyGXIiPhH7SsWHg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(396003)(346002)(39860400002)(451199021)(40470700004)(36840700001)(46966006)(40460700003)(36860700001)(5660300002)(336012)(426003)(44832011)(478600001)(2906002)(2616005)(110136005)(16526019)(54906003)(36756003)(7416002)(8676002)(1076003)(8936002)(47076005)(26005)(40480700001)(86362001)(82310400005)(83380400001)(4326008)(82740400003)(7696005)(356005)(81166007)(70586007)(6666004)(316002)(70206006)(41300700001)(186003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2023 23:18:40.2216
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fb76e144-cf02-43ec-83ce-08db79c056fa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT071.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6874
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RCH downstream port error logging is missing in the current CXL driver. The
missing AER and RAS error logging is needed for communicating driver error
details to userspace. Update the driver to include PCIe AER and CXL RAS
error logging.

Add RCH downstream port error handling into the existing RCiEP handler.
The downstream port error handler is added to the RCiEP error handler
because the downstream port is implemented in a RCRB, is not PCI
enumerable, and as a result is not directly accessible to the PCI AER
root port driver. The AER root port driver calls the RCiEP handler for
handling RCD errors and RCH downstream port protocol errors.

Update existing RCiEP correctable and uncorrectable handlers to also call
the RCH handler. The RCH handler will read the RCH AER registers, check for
error severity, and if an error exists will log using an existing kernel
AER trace routine. The RCH handler will also log downstream port RAS errors
if they exist.

Co-developed-by: Robert Richter <rrichter@amd.com>
Signed-off-by: Robert Richter <rrichter@amd.com>
Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/pci.c | 101 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 101 insertions(+)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index edfee8035820..1c40270968b6 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -5,6 +5,7 @@
 #include <linux/delay.h>
 #include <linux/pci.h>
 #include <linux/pci-doe.h>
+#include <linux/aer.h>
 #include <cxlpci.h>
 #include <cxlmem.h>
 #include <cxl.h>
@@ -728,10 +729,107 @@ static bool cxl_handle_endpoint_ras(struct cxl_dev_state *cxlds)
 	return __cxl_handle_ras(cxlds, cxlds->regs.ras);
 }
 
+#ifdef CONFIG_PCIEAER_CXL
+
+static void cxl_handle_rdport_cor_ras(struct cxl_dev_state *cxlds,
+					  struct cxl_dport *dport)
+{
+	return __cxl_handle_cor_ras(cxlds, dport->regs.ras);
+}
+
+static bool cxl_handle_rdport_ras(struct cxl_dev_state *cxlds,
+				       struct cxl_dport *dport)
+{
+	return __cxl_handle_ras(cxlds, dport->regs.ras);
+}
+
+/*
+ * Copy the AER capability registers using 32 bit read accesses.
+ * This is necessary because RCRB AER capability is MMIO mapped. Clear the
+ * status after copying.
+ *
+ * @aer_base: base address of AER capability block in RCRB
+ * @aer_regs: destination for copying AER capability
+ */
+static bool cxl_rch_get_aer_info(void __iomem *aer_base,
+				 struct aer_capability_regs *aer_regs)
+{
+	int read_cnt = sizeof(struct aer_capability_regs) / sizeof(u32);
+	u32 *aer_regs_buf = (u32 *)aer_regs;
+	int n;
+
+	if (!aer_base)
+		return false;
+
+	/* Use readl() to guarantee 32-bit accesses */
+	for (n = 0; n < read_cnt; n++)
+		aer_regs_buf[n] = readl(aer_base + n * sizeof(u32));
+
+	writel(aer_regs->uncor_status, aer_base + PCI_ERR_UNCOR_STATUS);
+	writel(aer_regs->cor_status, aer_base + PCI_ERR_COR_STATUS);
+
+	return true;
+}
+
+/* Get AER severity. Return false if there is no error. */
+static bool cxl_rch_get_aer_severity(struct aer_capability_regs *aer_regs,
+				     int *severity)
+{
+	if (aer_regs->uncor_status & ~aer_regs->uncor_mask) {
+		if (aer_regs->uncor_status & PCI_ERR_ROOT_FATAL_RCV)
+			*severity = AER_FATAL;
+		else
+			*severity = AER_NONFATAL;
+		return true;
+	}
+
+	if (aer_regs->cor_status & ~aer_regs->cor_mask) {
+		*severity = AER_CORRECTABLE;
+		return true;
+	}
+
+	return false;
+}
+
+static void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds)
+{
+	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
+	struct aer_capability_regs aer_regs;
+	struct cxl_dport *dport;
+	struct cxl_port *port;
+	int severity;
+
+	port = cxl_pci_find_port(pdev, &dport);
+	if (!port)
+		return;
+
+	put_device(&port->dev);
+
+	if (!cxl_rch_get_aer_info(dport->regs.dport_aer, &aer_regs))
+		return;
+
+	if (!cxl_rch_get_aer_severity(&aer_regs, &severity))
+		return;
+
+	pci_print_aer(pdev, severity, &aer_regs);
+
+	if (severity == AER_CORRECTABLE)
+		cxl_handle_rdport_cor_ras(cxlds, dport);
+	else
+		cxl_handle_rdport_ras(cxlds, dport);
+}
+
+#else
+static void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds) { }
+#endif
+
 void cxl_cor_error_detected(struct pci_dev *pdev)
 {
 	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
 
+	if (cxlds->rcd)
+		cxl_handle_rdport_errors(cxlds);
+
 	cxl_handle_endpoint_cor_ras(cxlds);
 }
 EXPORT_SYMBOL_NS_GPL(cxl_cor_error_detected, CXL);
@@ -744,6 +842,9 @@ pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
 	struct device *dev = &cxlmd->dev;
 	bool ue;
 
+	if (cxlds->rcd)
+		cxl_handle_rdport_errors(cxlds);
+
 	/*
 	 * A frozen channel indicates an impending reset which is fatal to
 	 * CXL.mem operation, and will likely crash the system. On the off
-- 
2.34.1

