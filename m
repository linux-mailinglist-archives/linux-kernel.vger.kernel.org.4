Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 882D470E993
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 01:28:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238849AbjEWX2k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 19:28:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238846AbjEWX2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 19:28:35 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2089.outbound.protection.outlook.com [40.107.95.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2437BE5F;
        Tue, 23 May 2023 16:28:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DoKsM2X5eqeNKEpyPA76l7Pmvars9LbIBbNmIaLV1vCWAOxMDYs8bYibEO8W+YeJ+x3EqxX5kEoN73uNN2FrJ8HRXYAxNQzFc73V/Evp75hm5YxFcKBT1h3tdNl0oZcYWjTbzgwuhWkrORdMg7U2BRx/kod6ZF8cZaWgXEmJJGHGXiWA6jDLrodCfAdx2g+L2FiD2KjcL8p3lanJN9hQH0FG4Ogi8kj/DVKxx3rGatAPdT41Gq62iXEpI9Aa6wyUCyXR6K5pJCIxRPW+DhSwYJzIeVX78GNlUFggZ+j06E/tX0M3kF355WXhKq+tqjDqcMkqpAkgTNzMl4hsXPnmOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ru4BkiU5cPsAD4arfiZPyON6tBIvUzVPdxT2kisKG/s=;
 b=LJ4uj4WViBibNsBBskKoLC5pg7yIcbI4B3XwQPv1Z8QuJWNolA+VenSKYW/tH+s3I/t/1fQQOiuvNvUi0biRyHTU+zbS6oX/BSBnZlujvf/Wu0kQOS59woa8aWz+z2T1BE5QE8wYskfD5lWHQkVqeDuuyW9Eznmz3pjuYE0QpEY+p2tqre6Z8/UbSqduoP6/RzyXDdQJIxQXO65735qxp3V0YW1oKDNhuk04i4MfQ3mV6qOXDLMEGyuAFZrDY+w83CpJ1XbBVNd5fWFG8Yt/K9aYuf820v48ZERZCrIgsHBEmpGtZXfv1YmRBvgds7PLvUNQYgI3pTFO/k8EJEV6Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com;
 dmarc=temperror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ru4BkiU5cPsAD4arfiZPyON6tBIvUzVPdxT2kisKG/s=;
 b=X7e57O4yvN1ZQPkzJaqtP0dvAwpIbyH0ZZ7sE70R8TyKmALZfN75VRfyJbfYIae4rqIYvlexMW0cKqeyfVk4A9l+r/EW4p7bjTsEwq6yv+FmEjf30471EB5qUKVii/4PWvDTl8ZQcZVWxHUFmkvbfZ6vUHBtM3/9cqwRoynp54Q=
Received: from MW3PR06CA0022.namprd06.prod.outlook.com (2603:10b6:303:2a::27)
 by SA1PR12MB6994.namprd12.prod.outlook.com (2603:10b6:806:24d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.27; Tue, 23 May
 2023 23:26:53 +0000
Received: from CO1NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:2a:cafe::d4) by MW3PR06CA0022.outlook.office365.com
 (2603:10b6:303:2a::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28 via Frontend
 Transport; Tue, 23 May 2023 23:26:53 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=temperror action=none header.from=amd.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of amd.com: DNS Timeout)
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT038.mail.protection.outlook.com (10.13.174.231) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.30 via Frontend Transport; Tue, 23 May 2023 23:26:51 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 23 May
 2023 18:26:50 -0500
From:   Terry Bowman <terry.bowman@amd.com>
To:     <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <bwidawsk@kernel.org>,
        <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
        <Jonathan.Cameron@huawei.com>, <linux-cxl@vger.kernel.org>
CC:     <terry.bowman@amd.com>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: [PATCH v4 21/23] cxl/pci: Add RCH downstream port error logging
Date:   Tue, 23 May 2023 18:22:12 -0500
Message-ID: <20230523232214.55282-22-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230523232214.55282-1-terry.bowman@amd.com>
References: <20230523232214.55282-1-terry.bowman@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT038:EE_|SA1PR12MB6994:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f7d45fb-55e9-452d-6c98-08db5be53052
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bvTSsD+kTxcZGtDMGjHsND7snPqmr6YiAUNttivJVKwsF2woUIm6Vy77N4yY16rsm2Weoe5j+rQCnC3GpZmT5FiHc1I8Rvkl5hWY4qL1gPMvHblM+vJ1Oxtf0xz2hKuWbqAN0zm46+3jOj549rGAVMLrVId48WOmxzCTkGTf69lOTLW4AzOEY0IWzP06ho2TeMbNVc6mQYEyiH28r9ba4I/U7lGkDO5nU3imlxsLyv54dacC7EdVcIIgwPf3PfGiIt3x6EPiREAKMoWxnTgl5nur7yg7InnTlUC+oUgMn5r07edXptfHAaLzWCEIgx3Yk7EMcfEsapxxzN8MjCipF3m77IvI+WMmBYEpUYl6YU3i//wVO8IMu33+A9zVSbnAzHDpogXTPChBoPSq4Rc4pauz8oCT6vpdeAOgHoVNFi4sCRBdMnDNzyhuN8FMsAAp1ZJE4aTbBF+G7GyVuLPViclLHyRhwWqM8MhHzUwkUPHMmI9emkpGioFtFxGt0xlg6VhtQ9e38Irc5a46ZUAqCGWiqPQYtitDdO0SMIGsUodFr+GXjvmGiLt3Ya8L6ixLg5QnpkoJ6y2A104gzDddl/P7CQejGGeoyeuXYzDMLNFKbOXlGk7z1KdrCZPx0abM/mtmdhBkRuY1GGv09/S2lQjx2+QxjNlRiR0z3RRHhJpzvwCWFCFBdvcUfSGbJ25ltzQGjGJ+8XQmM78yBrWZcGO4HwVWjrLyKQ3TZhUfLzejI56bhwYODARyIH2N6r7MMAeviNDc1DetMqxEmnJ5+g==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(136003)(396003)(376002)(451199021)(36840700001)(40470700004)(46966006)(5660300002)(8936002)(8676002)(40460700003)(86362001)(2906002)(1076003)(26005)(426003)(47076005)(36756003)(83380400001)(63350400001)(2616005)(63370400001)(336012)(16526019)(36860700001)(186003)(40480700001)(7416002)(44832011)(4326008)(70586007)(356005)(82740400003)(81166007)(70206006)(316002)(110136005)(54906003)(478600001)(7696005)(41300700001)(6666004)(82310400005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2023 23:26:51.7997
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f7d45fb-55e9-452d-6c98-08db5be53052
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6994
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
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
---
 drivers/cxl/core/pci.c | 98 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 98 insertions(+)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index def6ee5ab4f5..97886aacc64a 100644
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
@@ -747,10 +748,105 @@ static bool cxl_report_and_clear(struct cxl_dev_state *cxlds)
 	return __cxl_report_and_clear(cxlds, cxlds->regs.ras);
 }
 
+#ifdef CONFIG_PCIEAER_CXL
+
+static void cxl_log_correctable_ras_dport(struct cxl_dev_state *cxlds,
+					  struct cxl_dport *dport)
+{
+	return __cxl_log_correctable_ras(cxlds, dport->regs.ras);
+}
+
+static bool cxl_report_and_clear_dport(struct cxl_dev_state *cxlds,
+				       struct cxl_dport *dport)
+{
+	return __cxl_report_and_clear(cxlds, dport->regs.ras);
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
+static void cxl_handle_rch_dport_errors(struct cxl_dev_state *cxlds)
+{
+	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
+	struct aer_capability_regs aer_regs;
+	struct cxl_dport *dport;
+	int severity;
+
+	if (!cxlds->rcd)
+		return;
+
+	if (!cxl_pci_find_port(pdev, &dport) || !dport->rch)
+		return;
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
+		cxl_log_correctable_ras_dport(cxlds, dport);
+	else
+		cxl_report_and_clear_dport(cxlds, dport);
+}
+
+#else
+static void cxl_handle_rch_dport_errors(struct cxl_dev_state *cxlds) { }
+#endif
+
 void cxl_cor_error_detected(struct pci_dev *pdev)
 {
 	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
 
+	cxl_handle_rch_dport_errors(cxlds);
+
 	cxl_log_correctable_ras_endpoint(cxlds);
 }
 EXPORT_SYMBOL_NS_GPL(cxl_cor_error_detected, CXL);
@@ -763,6 +859,8 @@ pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
 	struct device *dev = &cxlmd->dev;
 	bool ue;
 
+	cxl_handle_rch_dport_errors(cxlds);
+
 	/*
 	 * A frozen channel indicates an impending reset which is fatal to
 	 * CXL.mem operation, and will likely crash the system. On the off
-- 
2.34.1

