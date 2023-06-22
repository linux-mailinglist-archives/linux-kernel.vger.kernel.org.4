Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A036373AB1F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 23:04:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231675AbjFVVEG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 17:04:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231681AbjFVVDr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 17:03:47 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on20624.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eab::624])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0DD4269A;
        Thu, 22 Jun 2023 14:00:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O3p/dERb0VzblOM2hZmVpm0mTIx36RVgIROTtnYTp0vCGkpsvPKLzAwhkPYKtKCRbUt4P7/NvYZ9aoO4/Hb3zFNMv2j0yowFsGN4FmokJfkg/osKUHalArnwtdPgVDPB7Nqk9tOSuQLJz6P+mqI+MaJYBNuN3HTTze7xqyjjCO+kcX+ne3i6Ako/3FsalptdHtfng5Hj1XoA8uLmP+G9DbzRz6k09gE7yDe6xeHOql9i7eXbGEVOPLxE/FuQTravNviyytkKtk3fejGnlk9T5Nz4pYZyCrdIimoWazm4Rhx6pXvUgXG1hhHtAGLrq+FMh90HevGjN7qPQ+ZMojW+1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=agqMnK0ovyPKAoEg1ZjFNGP350xlTZeSY4xZcQHj4o4=;
 b=nZuM2WKSz0ZMjJYMkV3GpTrjZOG3ITvlDv7StsobogEAvx21O69W1ndjovN0JHrdwyWuoLBpknfkaMXJzWnqCaseXk9IQ95XsigWXtByFeHqwOwwi4R6KkSLSpddrfxBE0JH6Tpc46ZCaZqDTT4ZcicvxmOV7whJSu4EENMNL+5XT/cjKKTQJMP5LU/FI895umXmyNPNNl6EORdsJ6rH/3Nqukpun7HqjC2Ga67vFabfme0UTa5SH9ouZoMOp4u7qDMtN8pkKtThRl1OG7mLthS3BamKV8U7/lqJgc5HWU+7S16yLGwiXRWxOJJlP/rJKyQH7UEHirHkw8LPaMxutA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=agqMnK0ovyPKAoEg1ZjFNGP350xlTZeSY4xZcQHj4o4=;
 b=F10/0kVcbhwSjqjAyMNDfoULowJQj9fTMZCf5h1VvZpl0ksZi6vRZYzO15+MJjr+6Pqe4P3F9tpgck6fKNB7GQupCvX7wNThtindOpivr7Pk9Sfa09eje1AfZXrEnoTe8QQq8ukP7dKo0ct6BL4wMnXAKJoRXTZTO414WYAIZRA=
Received: from DM6PR13CA0024.namprd13.prod.outlook.com (2603:10b6:5:bc::37) by
 CH2PR12MB4939.namprd12.prod.outlook.com (2603:10b6:610:61::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6521.23; Thu, 22 Jun 2023 20:59:13 +0000
Received: from CY4PEPF0000EE37.namprd05.prod.outlook.com
 (2603:10b6:5:bc:cafe::e3) by DM6PR13CA0024.outlook.office365.com
 (2603:10b6:5:bc::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.9 via Frontend
 Transport; Thu, 22 Jun 2023 20:59:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE37.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.17 via Frontend Transport; Thu, 22 Jun 2023 20:59:12 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 22 Jun
 2023 15:59:12 -0500
From:   Terry Bowman <terry.bowman@amd.com>
To:     <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <bwidawsk@kernel.org>,
        <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
        <Jonathan.Cameron@huawei.com>, <linux-cxl@vger.kernel.org>
CC:     <terry.bowman@amd.com>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: [PATCH v7 20/27] PCI/AER: Refactor cper_print_aer() for use by CXL driver module
Date:   Thu, 22 Jun 2023 15:55:16 -0500
Message-ID: <20230622205523.85375-21-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE37:EE_|CH2PR12MB4939:EE_
X-MS-Office365-Filtering-Correlation-Id: 5453ffa9-f927-4e16-872d-08db73638842
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vlBJHlJC/O7o/k9hAExaxVsz9D0Yk5rFG55z9H1t/1NUUN/jy+9J0dT0o3jHJ/xcFH5g+4Zq+f8ypUtdZNE9n9wO8PPIMbmfBUOXIX8wPEUy/uUmzT8U2lBmiKiUIrPrAH5KnuiuTxPgRqVUUL5CTvIKaDpmaYoEXrtqLqJ03COQUJZtKYRxSuq1SoFT8A1c3HyCeCWun/vMdcuE1dpwy9USNd/n92KHnAkwFloFW5gGtLx8OYrpKGrk1rDJeGklVZ2UB8n3XA0jJ7OR7M+RQK68Plvs2STcSv+SgI/wDBcb9uoj7hshwXdc9ieBKuor3RWRS4j69xXJTf7dWmU9mty+m6qQri+DkgQo7+kl5f0bfG7T7L+KyxlF318KKozz13CwclOnAruTa66pR1tEGs4jwLk+p7Uu0yL8Lbtq3VSJqDLUwb6feagEUxgAoFHzq/GUZc/G95fjRIYsTH4zkWuIX3RoKswWaMQXNNMlFTXMXYFTEepaNnL3r/uH7PLmYm9ndHC7u3pMrsOSWJ/r+U/6z6iBOPqKVj1oRr2T/cjS5cFZo00hLPl2E6ptxxzrastfwePmMCfQx/6YetvC2d8mXuccJZu9Hi2XgUP2w67TnZKlC9QQHqT/93OKLp1A2dHfIoPQnJiIgwn0tDPtgZxZR7F6kXuwM6YDVjzr5QBA4XqnZZejl6b1xfKtsm2a2Ps8MrlXBbCm6U7TM+LKVT6l2ClnOcNNrpcIpZUA/RnPXNoAKXwTsSKaLZH+kRwbcqDMq38zEfCJQz+yn1si8g==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(136003)(39860400002)(346002)(451199021)(36840700001)(40470700004)(46966006)(110136005)(54906003)(70586007)(70206006)(478600001)(2616005)(26005)(186003)(16526019)(1076003)(336012)(82310400005)(7696005)(40460700003)(4326008)(8936002)(41300700001)(8676002)(316002)(5660300002)(44832011)(40480700001)(2906002)(7416002)(81166007)(356005)(82740400003)(36756003)(86362001)(426003)(36860700001)(47076005)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 20:59:12.7137
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5453ffa9-f927-4e16-872d-08db73638842
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE37.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4939
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The CXL driver plans to use cper_print_aer() for logging restricted CXL
host (RCH) AER errors. cper_print_aer() is not currently exported and
therefore not usable by the CXL drivers built as loadable modules. Export
the cper_print_aer() function. Use the EXPORT_SYMBOL_NS_GPL() variant
to restrict the export to CXL drivers.

The CONFIG_ACPI_APEI_PCIEAER kernel config is currently used to enable
cper_print_aer(). cper_print_aer() logs the AER registers and is
useful in PCIE AER logging outside of APEI. Remove the
CONFIG_ACPI_APEI_PCIEAER dependency to enable cper_print_aer().

The cper_print_aer() function name implies CPER specific use but is useful
in non-CPER cases as well. Rename cper_print_aer() to pci_print_aer().

Also, update cxl_core to import CXL namespace imports.

Co-developed-by: Robert Richter <rrichter@amd.com>
Signed-off-by: Robert Richter <rrichter@amd.com>
Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>
Cc: "Oliver O'Halloran" <oohall@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/cxl/core/port.c | 1 +
 drivers/pci/pcie/aer.c  | 9 +++++----
 include/linux/aer.h     | 2 +-
 3 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 449472fb26a8..683f40e98119 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -2058,3 +2058,4 @@ static void cxl_core_exit(void)
 subsys_initcall(cxl_core_init);
 module_exit(cxl_core_exit);
 MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS(CXL);
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index f6c24ded134c..d3344fcf1f79 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -771,9 +771,10 @@ int cper_severity_to_aer(int cper_severity)
 	}
 }
 EXPORT_SYMBOL_GPL(cper_severity_to_aer);
+#endif
 
-void cper_print_aer(struct pci_dev *dev, int aer_severity,
-		    struct aer_capability_regs *aer)
+void pci_print_aer(struct pci_dev *dev, int aer_severity,
+		   struct aer_capability_regs *aer)
 {
 	int layer, agent, tlp_header_valid = 0;
 	u32 status, mask;
@@ -812,7 +813,7 @@ void cper_print_aer(struct pci_dev *dev, int aer_severity,
 	trace_aer_event(dev_name(&dev->dev), (status & ~mask),
 			aer_severity, tlp_header_valid, &aer->header_log);
 }
-#endif
+EXPORT_SYMBOL_NS_GPL(pci_print_aer, CXL);
 
 /**
  * add_error_device - list device to be handled
@@ -1009,7 +1010,7 @@ static void aer_recover_work_func(struct work_struct *work)
 			       PCI_SLOT(entry.devfn), PCI_FUNC(entry.devfn));
 			continue;
 		}
-		cper_print_aer(pdev, entry.severity, entry.regs);
+		pci_print_aer(pdev, entry.severity, entry.regs);
 		if (entry.severity == AER_NONFATAL)
 			pcie_do_recovery(pdev, pci_channel_io_normal,
 					 aer_root_reset);
diff --git a/include/linux/aer.h b/include/linux/aer.h
index 97f64ba1b34a..8f124b904314 100644
--- a/include/linux/aer.h
+++ b/include/linux/aer.h
@@ -64,7 +64,7 @@ static inline void pci_save_aer_state(struct pci_dev *dev) {}
 static inline void pci_restore_aer_state(struct pci_dev *dev) {}
 #endif
 
-void cper_print_aer(struct pci_dev *dev, int aer_severity,
+void pci_print_aer(struct pci_dev *dev, int aer_severity,
 		    struct aer_capability_regs *aer);
 int cper_severity_to_aer(int cper_severity);
 void aer_recover_queue(int domain, unsigned int bus, unsigned int devfn,
-- 
2.34.1

