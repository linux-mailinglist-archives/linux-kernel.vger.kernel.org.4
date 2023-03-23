Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 019F46C726A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 22:39:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231614AbjCWVjX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 17:39:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231152AbjCWVjK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 17:39:10 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2081.outbound.protection.outlook.com [40.107.243.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE5B02385D;
        Thu, 23 Mar 2023 14:39:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k9HjKdZeq7yMM3dWK7yia/4QkRrwHGEMlx1mBG7gerriFEZ82IP7qM0raJi/2ylxlMurvWhL9QMrSLvqAZ2ujWET7nMX2xfiAE9ZEpk39qR/azjVRWg7Rx2QMQwAocSYpoZpZR4BzK3i28mF4K9szWxI/aO08LM/qpgmrt7S8VelQ1Kug8+eCjKVdtiLHReUL+jaXLDoKNM6WsPmLSz6ywLJEi4DNh3cDwmq3aE2c8nqc6eKBskTfXxurphHMgWPGzVeDgs0DquLm0IDw+58+Lvs/Qbmx4JSbZ9xn09wpQ19VW6h858ZBaMntQUgdaI4mJ6YebCmOCVgZYkbPOxvuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YoohbZ8vAjQdX46lwNBehPetu5rK3ytlD1ilL/UZOqI=;
 b=RazDf8yMxRpd48uN9Cn5ILaBfs+W4IePeySNKBzWoYpqXDQE+LzZTbfrZwxkpBxePoJYWmtM9GQRj8qefLmKlIXtl26k4GdfpGXQ26ax2o9L4zbk6U9LZkjRaunk0NLbcxBQCKn24/+jI1xoum7jUoMTnBUHvW6PGutC17PxVWWEHOXKiEvUXloELTvo+aRfakgAtdWQ3hvMGHM2vzsKCRm/vLsk85X1dw0uaUiQjrg+OkQWnyy56HZxX5uHWCdMDtkJPi6+IN/yEIC2CrInQivlUU0a2lTt32KyCTi/DSnEcGqYbPavkN0CctyCXzEgw+2oRewSFs+UjukOZBxzsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YoohbZ8vAjQdX46lwNBehPetu5rK3ytlD1ilL/UZOqI=;
 b=gayaJvHsY72yNhMIM53EjZBcqXmCXODG+/03QYftWjhbDv2NTAJSunzLXcWDZJd8/JNoJXtfiU2KWluqp++8T4GBmjpC5KAYOA3tunk6xTTisSeTrWiRPwa3WW/Tmek5QRvZ+6MBcF6yelF22j39GfkOoqn2BqBZa8W5VABsqeU=
Received: from DM6PR13CA0041.namprd13.prod.outlook.com (2603:10b6:5:134::18)
 by DM4PR12MB5086.namprd12.prod.outlook.com (2603:10b6:5:389::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Thu, 23 Mar
 2023 21:38:59 +0000
Received: from DM6NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:134:cafe::4f) by DM6PR13CA0041.outlook.office365.com
 (2603:10b6:5:134::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.6 via Frontend
 Transport; Thu, 23 Mar 2023 21:38:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT011.mail.protection.outlook.com (10.13.172.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6222.21 via Frontend Transport; Thu, 23 Mar 2023 21:38:59 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 23 Mar
 2023 16:38:58 -0500
From:   Terry Bowman <terry.bowman@amd.com>
To:     <terry.bowman@amd.com>, <alison.schofield@intel.com>,
        <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
        <bwidawsk@kernel.org>, <dan.j.williams@intel.com>,
        <dave.jiang@intel.com>, <Jonathan.Cameron@huawei.com>,
        <linux-cxl@vger.kernel.org>, <rrichter@amd.com>
CC:     <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: [PATCH v2 4/5] cxl/pci: Forward RCH downstream port-detected errors to the CXL.mem dev handler
Date:   Thu, 23 Mar 2023 16:38:07 -0500
Message-ID: <20230323213808.398039-5-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230323213808.398039-1-terry.bowman@amd.com>
References: <20230323213808.398039-1-terry.bowman@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT011:EE_|DM4PR12MB5086:EE_
X-MS-Office365-Filtering-Correlation-Id: 94d182c9-945a-4824-3e61-08db2be70319
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BokTngVCPnTiegjy2zobO1id1psicB9t0W6WN+nAjAIHKaQwE7V4Hh/I96vBEO/mv+3rDF8glUwe2HQ7C4znDkZFPDX/lf49YAuU5FIqb0TWY8aZkZ1OSCtFpJ+91W1gc65gvjRGupgPQu93njAPFNMPqQlOqtpUEJ2o3LfuoUpYEoGD4z0baIO55IqAMEkHnqzS6BG1wFc690Z+DPulKPE6GFj2iS6HFgB8BsM4+//4B/GNei2heaAiDAynPOJdClCkS+PPrDJA/vkA13WIry9jrUZHzAIaQFvb6T4xr4BhXLJJ8Yir3JWeEBs528d+spjN6HcVRRkkFBDXJgUew9NmvEP2LDEeGCONertS3276eRVF11poXRUrJaX9y54JyG+dfR7+YBbG4adV1ue3t1scKIPzz9Mf7CkXZpfPOCdF6zWkmDQps1KBrDOn4pVai0GyoWd+NPVJCQ924+6xLfNhii8Ym68HbKGfGCbNfCbdC+qS3vgmMqQ3FQXiJ6ufHaoRgnQb0niHkWEnfLm2jTA7E+p8C8FcC86fwO8a8YQyTty+93ROBqeqpvcMfhsY8hfoA5vMxR8XUI9o/CisvGVHmabNP5BmW+Cjou+naJxX485Hvu8gm2EqS7BLZALWS3OBlnbqYXbWu0WAwgOE76cTH48lQYDK/kwcuHiWiHEwJcOA1r27+ZrgjZH4fwJHXkT4EO7ukuwJavimmgPJeuH/Fmq+hWExyY2xswHzI9GycxJHpSOab6fY2r5EkRLR
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(396003)(136003)(346002)(39860400002)(376002)(451199018)(40470700004)(36840700001)(46966006)(40460700003)(36860700001)(8676002)(4326008)(70586007)(70206006)(54906003)(6636002)(41300700001)(5660300002)(7416002)(44832011)(82740400003)(26005)(47076005)(426003)(81166007)(1076003)(8936002)(6666004)(16526019)(316002)(186003)(478600001)(83380400001)(2616005)(336012)(7696005)(110136005)(36756003)(82310400005)(86362001)(40480700001)(2906002)(921005)(356005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2023 21:38:59.1701
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 94d182c9-945a-4824-3e61-08db2be70319
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5086
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Robert Richter <rrichter@amd.com>

In RCD mode a CXL device (RCD) is exposed as an RCiEP, but CXL
downstream and upstream ports are not enumerated and not visible in
the PCIe hierarchy. Protocol and link errors are sent to an RCEC.

Now, RCH downstream port-detected errors are signaled as internal AER
errors (UIE/CIE) with the RCEC's source ID. A CXL handler must then
inspect the error status in various CXL registers residing in the
dport's component register space (CXL RAS cap) or the dport's RCRB
(AER ext cap). [1]

This patch connects errors showing up in the RCEC's error handler with
the CXL subsystem. Implement this by forwarding the error to all CXL
devices below the RCEC. Since the entire CXL device is controlled only
using PCIe Configuration Space of device 0, Function 0, only pass it
there [2]. These devices have the Memory Device class code set
(PCI_CLASS_MEMORY_CXL, 502h) and the existing cxl_pci driver can
implement the handler. The CXL device driver is then responsible to
enable error reporting in the RCEC's AER cap (esp. CIE and UIE) and to
inspect the dport's CXL registers in addition (CXL RAS cap and AER ext
cap).

The reason for choosing this implementation is that a CXL RCEC device
is bound to the AER port driver, but the driver does not allow it to
register a custom specific handler to support CXL. Connecting the RCEC
hard-wired with a CXL handler does not work, as the CXL subsystem
might not be present all the time. The alternative to add an
implementation to the portdrv to allow the registration of a custom
RCEC error handler isn't worth doing it as CXL would be its only user.
Instead, just check for an CXL RCEC and pass it down to the connected
CXL device's error handler.

[1] CXL 3.0 spec, 12.2.1.1 RCH Downstream Port-detected Errors
[2] CXL 3.0 spec, 8.1.3 PCIe DVSEC for CXL Devices

Co-developed-by: Terry Bowman <terry.bowman@amd.com>
Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Signed-off-by: Robert Richter <rrichter@amd.com>
Cc: "Oliver O'Halloran" <oohall@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-pci@vger.kernel.org
---
 drivers/pci/pcie/aer.c | 45 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 7f0f52d094a4..d250a4caa85a 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -943,6 +943,49 @@ static bool find_source_device(struct pci_dev *parent,
 	return true;
 }
 
+#if IS_ENABLED(CONFIG_CXL_PCI)
+
+static void handle_error_source(struct pci_dev *dev, struct aer_err_info *info);
+
+static int handle_cxl_error_iter(struct pci_dev *dev, void *data)
+{
+	struct aer_err_info *e_info = (struct aer_err_info *)data;
+
+	if (dev->devfn != PCI_DEVFN(0, 0))
+		return 0;
+
+	/* Right now there is only a CXL.mem driver */
+	if ((dev->class >> 8) != PCI_CLASS_MEMORY_CXL)
+		return 0;
+
+	/* pci_dev_put() in handle_error_source() */
+	dev = pci_dev_get(dev);
+	if (dev)
+		handle_error_source(dev, e_info);
+
+	return 0;
+}
+
+static bool is_internal_error(struct aer_err_info *info)
+{
+	if (info->severity == AER_CORRECTABLE)
+		return info->status & PCI_ERR_COR_INTERNAL;
+
+	return info->status & PCI_ERR_UNC_INTN;
+}
+
+static void handle_cxl_error(struct pci_dev *dev, struct aer_err_info *info)
+{
+	if (pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC &&
+	    is_internal_error(info))
+		pcie_walk_rcec(dev, handle_cxl_error_iter, info);
+}
+
+#else
+static inline void handle_cxl_error(struct pci_dev *dev,
+				    struct aer_err_info *info) { }
+#endif
+
 /**
  * handle_error_source - handle logging error into an event log
  * @dev: pointer to pci_dev data structure of error source device
@@ -954,6 +997,8 @@ static void handle_error_source(struct pci_dev *dev, struct aer_err_info *info)
 {
 	int aer = dev->aer_cap;
 
+	handle_cxl_error(dev, info);
+
 	if (info->severity == AER_CORRECTABLE) {
 		/*
 		 * Correctable error does not need software intervention.
-- 
2.34.1

