Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 988E770E997
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 01:28:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235614AbjEWX2z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 19:28:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238868AbjEWX2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 19:28:50 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2087.outbound.protection.outlook.com [40.107.92.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3878F10CE;
        Tue, 23 May 2023 16:28:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gunv5cjmhuGr6U/iUnAzsQBfkPJ78XMFI+UgGT0V/WALLDtKhOzjXA0nR5JzHs2QhsLsJs0sY7BYz5ULoaTlUsc1MDQkqvQ4Bs45bKpGjcMORYNbkUKpSn8q4fm/n3kW6JuoNursLU8eAkX+/pNAG2Gin6H4UxyssMv2QlAoqshFlniqnIswiP1TKBhgOsfKDBw6d4xFKOKAfHFb6dgigHoyUVuzIoOosq5l4ejYjsjWRKgC2qnYXUlWybotHZg8hYbrKBjkd62U88SXh7CLxow69GTPqtmyuAmN0Fo2+/PvMXOr9R152mfEGh79w4rzZVo9hmp1pzMoVzuWM8NBJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aJQwyTThQNqOz8HKMjNSNM8Yqza7Cao2DLD2ujZhYDU=;
 b=hEY4J8ShxI3kOXZtKYMB/8WQJYENJG6vd/uzWYbyUENwCSMIOZ4xAwHGooHHOkHLMdtaW9J83KE10suK4VdgWb2jnm4I+DnuIGaqKB+HNfok1Ms/8VNnVHRRd//yPHL1gv1PYwRk4DVYB7tvC08meES2McU3mK1AXJs8It//EUHJYJkU4SVK3x0juwBGJwbp6M6tlQbxnkrRZkt8uaosdjNJeCG6aRaB+tuNG8f+nqJOhMhct4hMjqmix+6FvaPdi4INea3tx+L78Nn/boJQO5Rd5fblbOFOPdl0HAwFOwIOSxid3akuB8/Qn4xqqEZWp9rr9ZdJZjm3wLsfaZAm3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aJQwyTThQNqOz8HKMjNSNM8Yqza7Cao2DLD2ujZhYDU=;
 b=uDEoiuDP+gC+7YBbd8fV+crWrRGgEqCqy2tPGePH12WuiJaApTwJUvJqhdMHNEsaQryy7mqwdyc8nI9bNDArRYL579VpwSNF47p8SXZRci90VnpIO16LKutZUxUGvzSP1OdSSJwkW49NsvB+ZoICIKIJaw0BlHfgO2Okg0u21yM=
Received: from MW4PR03CA0148.namprd03.prod.outlook.com (2603:10b6:303:8c::33)
 by MW6PR12MB8705.namprd12.prod.outlook.com (2603:10b6:303:24c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.29; Tue, 23 May
 2023 23:27:14 +0000
Received: from CO1NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8c:cafe::da) by MW4PR03CA0148.outlook.office365.com
 (2603:10b6:303:8c::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.14 via Frontend
 Transport; Tue, 23 May 2023 23:27:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT008.mail.protection.outlook.com (10.13.175.191) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.30 via Frontend Transport; Tue, 23 May 2023 23:27:13 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 23 May
 2023 18:27:12 -0500
From:   Terry Bowman <terry.bowman@amd.com>
To:     <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <bwidawsk@kernel.org>,
        <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
        <Jonathan.Cameron@huawei.com>, <linux-cxl@vger.kernel.org>
CC:     <terry.bowman@amd.com>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: [PATCH v4 23/23] PCI/AER: Unmask RCEC internal errors to enable RCH downstream port error handling
Date:   Tue, 23 May 2023 18:22:14 -0500
Message-ID: <20230523232214.55282-24-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1NAM11FT008:EE_|MW6PR12MB8705:EE_
X-MS-Office365-Filtering-Correlation-Id: 10981dd8-2125-48a5-b1c3-08db5be53d7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l4CVby1S23vrC99wPUGp0we0MyBJ6APzSXK5A6+gMzNZMgmJg71UWDnOGQihoWjkyDMsedEC0cNzsNErxUHgbQJ545V/KWtWATX+0gbQmvlhgtXrMbSe2kmLaCokOd9G3ezcspBm882/FdH+fCWDYxGGfqma7dAxzZsScPZSHYFs+9fZFbwHWvEtIxq+EYvv+UIthimJWt+flKAhNXhkUiWr0gCN+1+DBo6+xkDIQIHyy5XBTa74pAKKuKFaaH+ROGKdjRxylBIYQzNMjYAJFLwcDl2KAEdzGXMMz4s7xJqm584pcYhj2gZxxB7MWtqX9pnLkpsG2Fco3UcCMfpHM79463gs0O2WpVRE+B+pRea6ZV1C87tC6mZFJdMNli8h3yq0l6cjNrBT2TVQhj/6qNs5Y5AK01u6+r8Az6pw7hcyVHbxaRbYKKpUAYE7OD6DXmyxGZGcdymWF1jXH+D6x5axHYcYyGJBP3KMBoZpD/lY4QizQEVDpuU4zlb2VYHxwjUwTvakzlfr2xgF1bsdHVRLfYZAATkGRP9loy9E9MPyuvaxiiQ70qlcKInPn85C79B44huERy9CsJK8XmwytX5U8HmqOwG/xtPnb0F9xgQA9GSNPcfwfdlsX0lD2UUOcOWMvue5snq4+13/aGIddvLTm6XShG5PH7sJ5q0RiQYfuck9KfoL1CoCNxZZz2oxjp6ZmU3a6qQMo9rsg0noNLA4/jrKFIefKahL8tFC3ZSOR/GaMYx60S2hZkMxYDRtclIdR9NtWKZfp8hU96m93RTGtDhGikB8BTgFinS1Q48=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(39860400002)(346002)(136003)(451199021)(46966006)(40470700004)(36840700001)(82310400005)(478600001)(70206006)(70586007)(4326008)(7696005)(41300700001)(110136005)(316002)(54906003)(5660300002)(8936002)(8676002)(86362001)(44832011)(81166007)(26005)(356005)(82740400003)(1076003)(7416002)(40460700003)(16526019)(186003)(426003)(336012)(83380400001)(40480700001)(2906002)(2616005)(36756003)(36860700001)(47076005)(36900700001)(309714004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2023 23:27:13.8806
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 10981dd8-2125-48a5-b1c3-08db5be53d7b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8705
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

From: Robert Richter <rrichter@amd.com>

AER corrected and uncorrectable internal errors (CIE/UIE) are masked
in their corresponding mask registers per default once in power-up
state. [1][2] Enable internal errors for RCECs to receive CXL
downstream port errors of Restricted CXL Hosts (RCHs).

[1] CXL 3.0 Spec, 12.2.1.1 - RCH Downstream Port Detected Errors
[2] PCIe Base Spec 6.0, 7.8.4.3 Uncorrectable Error Mask Register,
    7.8.4.6 Correctable Error Mask Register

Co-developed-by: Terry Bowman <terry.bowman@amd.com>
Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/pci/pcie/aer.c | 64 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 2e3f00b6a5bd..c5076ae4eb58 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -948,6 +948,32 @@ static bool find_source_device(struct pci_dev *parent,
 
 #ifdef CONFIG_PCIEAER_CXL
 
+static int pci_aer_unmask_internal_errors(struct pci_dev *dev)
+{
+	int aer, rc;
+	u32 mask;
+
+	if (!pcie_aer_is_native(dev))
+		return -EIO;
+
+	aer = dev->aer_cap;
+	rc = pci_read_config_dword(dev, aer + PCI_ERR_UNCOR_MASK, &mask);
+	if (rc)
+		return rc;
+	mask &= ~PCI_ERR_UNC_INTN;
+	rc = pci_write_config_dword(dev, aer + PCI_ERR_UNCOR_MASK, mask);
+	if (rc)
+		return rc;
+
+	rc = pci_read_config_dword(dev, aer + PCI_ERR_COR_MASK, &mask);
+	if (rc)
+		return rc;
+	mask &= ~PCI_ERR_COR_INTERNAL;
+	rc = pci_write_config_dword(dev, aer + PCI_ERR_COR_MASK, mask);
+
+	return rc;
+}
+
 static bool is_cxl_mem_dev(struct pci_dev *dev)
 {
 	/*
@@ -1031,7 +1057,44 @@ static void cxl_rch_handle_error(struct pci_dev *dev, struct aer_err_info *info)
 		pcie_walk_rcec(dev, cxl_rch_handle_error_iter, info);
 }
 
+static int handles_cxl_error_iter(struct pci_dev *dev, void *data)
+{
+	int *handles_cxl = data;
+
+	*handles_cxl = is_cxl_mem_dev(dev) && cxl_error_is_native(dev);
+
+	return *handles_cxl;
+}
+
+static bool handles_cxl_errors(struct pci_dev *rcec)
+{
+	int handles_cxl = 0;
+
+	if (pci_pcie_type(rcec) == PCI_EXP_TYPE_RC_EC &&
+	    pcie_aer_is_native(rcec))
+		pcie_walk_rcec(rcec, handles_cxl_error_iter, &handles_cxl);
+
+	return !!handles_cxl;
+}
+
+static void cxl_rch_enable_rcec(struct pci_dev *rcec)
+{
+	if (!handles_cxl_errors(rcec))
+		return;
+
+	/*
+	 * Internal errors are masked by default, unmask RCEC's here
+	 * PCI6.0 7.8.4.3 Uncorrectable Error Mask Register (Offset 08h)
+	 * PCI6.0 7.8.4.6 Correctable Error Mask Register (Offset 14h)
+	 */
+	if (pci_aer_unmask_internal_errors(rcec))
+		pci_err(rcec, "CXL: Failed to unmask internal errors");
+	else
+		pci_info(rcec, "CXL: Internal errors unmasked");
+}
+
 #else
+static inline void cxl_rch_enable_rcec(struct pci_dev *dev) { }
 static inline void cxl_rch_handle_error(struct pci_dev *dev,
 					struct aer_err_info *info) { }
 #endif
@@ -1432,6 +1495,7 @@ static int aer_probe(struct pcie_device *dev)
 		return status;
 	}
 
+	cxl_rch_enable_rcec(port);
 	aer_enable_rootport(rpc);
 	pci_info(port, "enabled with IRQ %d\n", dev->irq);
 	return 0;
-- 
2.34.1

