Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D90073AB28
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 23:06:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231592AbjFVVGA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 17:06:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232204AbjFVVFO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 17:05:14 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on20613.outbound.protection.outlook.com [IPv6:2a01:111:f400:7ea9::613])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 932A32682;
        Thu, 22 Jun 2023 14:02:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mLJCnX6j4e7A3WyreAqK/4rNHoLVsYhlgu3VblU2p6jt+lYGhjjyk+aanlOWM49y9IchKhIuPsBNJ7sV3dHkGjgAKmHyqAecVJfjhY2uW8D4u8Wougy+qOuOQsF75+c4c7ekwE1kBgcMYcsW4TpZlYFID/DFHt4bmc8bHsbT2E1mm9C+c22bM0fOuk+OSoBv/3JizRoOgju4v36FefK7+XyQNmX3Z4jFzMBldsm9SeDMEog6dd9maR2NpgAw40sBHW1ReTS4Cl3ceMQ4P90xHKOzUrnxNU5gL+0Aq7qgH+4D59cLJQvatLWu1ChVq2ICngAp4VvB2swjiPuUXS4N0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N2/XgMTWuARAg6h/D9gYdx1ekNbDBST9o6bpKIvL1nc=;
 b=ODblPeTWauMGGvtE9/FrPdOD0d9/0ca1FvCzMLQSRhXR1xhek9BFUrpX6YsbA9mX1QZm/I7y0LAUrnaClSJw48IzU/Du/5VXIaEro0cbzrpgGikMvoyzvE8SsMvZwpwiFQUKZcO78h+qkdugkgrEiyr212MwWqFggGtGbzCwjciPcVECBuK2erZYtkTfZHKyKySmg4GR+4yOlztJESgJPch/tCFm22lCQsgmx5PVq/ZPwL0G52N4WJ0jFfxo3oAorwuDnkrFG8KxpBj17BmevpG18IPtqiiY5vxU3giW830TMMnbLQVEQUu4V21sE6PG7Pa7q2dKBM9iwUN/y2NAKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N2/XgMTWuARAg6h/D9gYdx1ekNbDBST9o6bpKIvL1nc=;
 b=QEqnRaMHYklI6fjGHTzA9oI/NBMiVTHPx6ljb6hjhxysdLJTlFd73dxvUROPMVM9I0hHvPTpdlthFeahzPO1rcDN6d8qOes0/juffl6ZnUOkNChqBQfk2c+x3HGypmQTHhW846uL1+KCsqZ2YZc0foYxWBqvOyUnEzrlqayO/XU=
Received: from CY5PR15CA0159.namprd15.prod.outlook.com (2603:10b6:930:67::27)
 by DS0PR12MB8527.namprd12.prod.outlook.com (2603:10b6:8:161::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Thu, 22 Jun
 2023 20:59:46 +0000
Received: from CY4PEPF0000EE34.namprd05.prod.outlook.com
 (2603:10b6:930:67:cafe::33) by CY5PR15CA0159.outlook.office365.com
 (2603:10b6:930:67::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24 via Frontend
 Transport; Thu, 22 Jun 2023 20:59:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE34.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.17 via Frontend Transport; Thu, 22 Jun 2023 20:59:45 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 22 Jun
 2023 15:59:45 -0500
From:   Terry Bowman <terry.bowman@amd.com>
To:     <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <bwidawsk@kernel.org>,
        <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
        <Jonathan.Cameron@huawei.com>, <linux-cxl@vger.kernel.org>
CC:     <terry.bowman@amd.com>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: [PATCH v7 23/27] cxl/pci: Add RCH downstream port error logging
Date:   Thu, 22 Jun 2023 15:55:19 -0500
Message-ID: <20230622205523.85375-24-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230622205523.85375-1-terry.bowman@amd.com>
References: <20230622205523.85375-1-terry.bowman@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE34:EE_|DS0PR12MB8527:EE_
X-MS-Office365-Filtering-Correlation-Id: 42a22cae-6b67-4229-8734-08db73639c0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bjGYn2itXmQRIXcP7oIF5ri9RAw50BH6gfZUQJ8CrTbvMsT5uJeR2CMllUedVLLk/A3aKEohcmdlbzfwKMk0hHIVBEOgNh8M6OJ4R1vdTZ9+x9LG/Osushw6Dpw9zmsPKxOHEKTCAH7Uc1RQ8mOILDqq+A7jRlXKfgF7Vg4wjDrkrKBf7Rx5A48GjDqDCRlr9W63mLGXeSujaerzHCkHbhwrT5ZfCgU1Kbf0Riaw5hPq9ah1qMPHYFHQVL/B+wEbh2JIFErgrjHaEw7/vknMS+BcaUmeVA5WAsga3g2G4SYdgjm36D4cUhO/9WnfTVXvw4qz/xzXHDT5K8YOYcRHaUMmXtJEzuNn3X9S1sCDDXy0StlKNjj+hMv9kwZ67XXXkwGx0BxSXHneFy4oCdPK6Y+fcjtV6LxXnh/YiYq13urDn8N/iY9HESbJeBip/O6P36e3PiPFRqUNALgecvxNw3QO3haJLJMv8vUiYveuk+7DCfPAAyc//a6Ay9MlReiBVaQlDXL8WFPT7g3AaYonPKBj5WR3cbnaNliqxI+Pefwnk5JGlIso4WCRYrPrypwxitNy4c7bWU5kBxsahYkcB7XT6asUxDSyOIzZ5VnngpnI5SNCkunjewuMeiz9a7x3c8kKoQ4wq6yPngg0saT8PlM9R0/P3L4iJLI8+Boen6oWFDkakbPvzu6aGW2XFIKt1VCfAccop8ttfxftsnpsH+IB+86oU/uoENnwhAmbB9GPbzebahS8cgpmRqJpLSO9uRfydDanWriE7GMjJDdviA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(396003)(376002)(39860400002)(451199021)(46966006)(36840700001)(40470700004)(7696005)(356005)(36756003)(81166007)(82740400003)(86362001)(82310400005)(4326008)(40460700003)(41300700001)(8676002)(40480700001)(44832011)(5660300002)(26005)(8936002)(7416002)(1076003)(478600001)(83380400001)(16526019)(186003)(426003)(2616005)(2906002)(47076005)(70586007)(6666004)(54906003)(70206006)(316002)(110136005)(336012)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 20:59:45.9011
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 42a22cae-6b67-4229-8734-08db73639c0a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE34.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8527
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
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
---
 drivers/cxl/core/pci.c | 101 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 101 insertions(+)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 9cb39835e154..9e0eba5ccfc4 100644
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
@@ -747,10 +748,107 @@ static bool cxl_handle_endpoint_ras(struct cxl_dev_state *cxlds)
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
@@ -763,6 +861,9 @@ pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
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

