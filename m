Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 185EC744524
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jul 2023 01:20:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232449AbjF3XUd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 19:20:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230455AbjF3XT0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 19:19:26 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 330DB49E6;
        Fri, 30 Jun 2023 16:19:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jVHY/arxIlSAoWjqa/UPzt6e0SZHhy3WiT+LeYDdygzU8nrnyuFEwpfj58piJLGKepkqQ4XqdpfvSZ+1sHX6kLNTvkZyrhNh6QNshbhxRf4ur6rZr0XZ1eDdCF1f+lTtrttx91xsabRxuoOiBHyePi2yarj6orxnoZcXRNX1ScspaeKtgNo291aoSR54eB1ZF/24NFHUEGVGgl/KUsamhES/7Fyrq7Y+lq/5vr9MrGh2st4a+nR1DulwqOK5yeVvORk+B4To7DVa5kgXyhOoAWkEuZnkykd2Px7O3RGi3Xbp0WRfII8vY2OXY05bEcDcC9q1mW3kpHFVDTLlyCLgjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IYstJQr+GL/LJYik1NBn6/QzGLgvbSnp0Bwgf2p2jSI=;
 b=KERvKFdriKTbIB4HT2zbJokhAubSxNVD2YI5FR088LcGeMh6NFhsOhp50xUC/6bZZctQldv1TDYetDCKis2rDsirxvCHCEwpkKIbbNBLiXxPN6RgmYqgpO8tZ0F4kKKq2TkQkUUUn0uQfFpY64z9BHcaqQR8cU99XQIGTCD+6PU+v5ZZ22EfSRReuXM2HqLa7XRD1dA1MniKnwUNEsNKqw6bfnjJHJ3u+xg2s0b16SviDwiSnPbztBimYrb79rwe8eVjB++rhrMq1cKtcpvNWzCSmCiq9BMtCBN4BZV34Mz0sHhg7N0jdEjOxKnyQoJfYaaGhYq3DGLIl1ys/4Jx+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IYstJQr+GL/LJYik1NBn6/QzGLgvbSnp0Bwgf2p2jSI=;
 b=VofZV1hd6jq0kBEBwD88Wixh3DVF8iXqAkiVPHmGbbZ07Uu5MPNdHqDtPMiAtzx2BF0VBxd3EQbEMHRmOLpwCtpLIhf4V7pWeiRn3UFfzVDJhtOK45Ttj3ScL3i8Zx8/JC3JG10JuvDI4mOPH4q3P5fac9Vq9Qha5bp1uvuL7ZY=
Received: from DS7PR03CA0301.namprd03.prod.outlook.com (2603:10b6:8:2b::8) by
 PH7PR12MB5951.namprd12.prod.outlook.com (2603:10b6:510:1da::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Fri, 30 Jun
 2023 23:19:02 +0000
Received: from DM6NAM11FT099.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2b:cafe::6) by DS7PR03CA0301.outlook.office365.com
 (2603:10b6:8:2b::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.22 via Frontend
 Transport; Fri, 30 Jun 2023 23:19:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT099.mail.protection.outlook.com (10.13.172.241) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.49 via Frontend Transport; Fri, 30 Jun 2023 23:19:02 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 30 Jun
 2023 18:19:01 -0500
From:   Terry Bowman <terry.bowman@amd.com>
To:     <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <bwidawsk@kernel.org>,
        <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
        <Jonathan.Cameron@huawei.com>, <linux-cxl@vger.kernel.org>
CC:     <terry.bowman@amd.com>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>,
        Oliver O'Halloran <oohall@gmail.com>,
        <linuxppc-dev@lists.ozlabs.org>, <linux-pci@vger.kernel.org>
Subject: [PATCH v8 12/14] PCI/AER: Forward RCH downstream port-detected errors to the CXL.mem dev handler
Date:   Fri, 30 Jun 2023 18:16:33 -0500
Message-ID: <20230630231635.3132638-13-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: DM6NAM11FT099:EE_|PH7PR12MB5951:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f8ccb66-66bb-440c-8c73-08db79c0640e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZDcGfx8A0AN8smxovNhOLb6NGNIx4EqjEJqTdjAcN1lYmvDNQrb81MU0u69v5TLR2BkL9BPTML3fFw57biNJYfVf3UBeko+BMMhxQxaVhT4O+1dncqmUwqJm2WVauJ4qqaLQtZWJ3nNh50W3M++qb8EFQaYzQZAdZobvI0gUchxevDdFtbsZC9vQ3qP0gflDa3sdbrtCHv438KDADOUi6ZpgOrGfOA9AtT/1jDMpwLyDcnSXDn3iTM2XnkM0YHZzs4p0MdlMLhQKOy7k4aLUVBVDZh5cRQqC8887YbsLanGeeKmH6MgWpjZmCyi/5Wk1ViiKnaUG9OEB25ALM22dXkvuQAri0NburMdo+QwdKzaRFhdM4Oqn/UQrK6i+GLE7MMOf0B8aoH7+c9WdnGho7iYln/nwsCfG6br5IFXs2s0k71M4FXgxFmdpyWiYkyQM44K9ZCzbLwDUnJL//UXjt+hWusAgrWBnIpWi+TY/qokZW8rQzdv+/wkJvFHP7czQ4WMXEFXcbmJQjj5gOEa1+VpXEBqTes1LwwN3N/CvoAPN149Y6I/DlhUjKp2Ca0HT3bb5IJ0awZd+3sBHIaacRDghoaDMfqM3luDGj0S0GlfDpSS9PK1ylf07CPWK2LBSJT8kkcWWh7h/ZSELbJ6k+31J6jAmJF9oXDXgoeUOM7dCvmMWZ8HMA62XDm3I/UHzlUHp9x2cQzuD9nrgnQ1JKMox7SKONQ15g/8eimnJIv8Yj9PD7W0DyB1NE1iJq8VsSYJaKjSMbDN+YfaOQus8Sg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(39860400002)(396003)(346002)(451199021)(36840700001)(40470700004)(46966006)(8676002)(41300700001)(8936002)(70206006)(316002)(16526019)(186003)(26005)(1076003)(426003)(336012)(966005)(54906003)(478600001)(110136005)(6666004)(4326008)(2616005)(7696005)(70586007)(40460700003)(44832011)(82310400005)(2906002)(5660300002)(40480700001)(7416002)(81166007)(356005)(82740400003)(36756003)(36860700001)(86362001)(47076005)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2023 23:19:02.1632
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f8ccb66-66bb-440c-8c73-08db79c0640e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT099.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5951
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

In Restricted CXL Device (RCD) mode a CXL device is exposed as an
RCiEP, but CXL downstream and upstream ports are not enumerated and
not visible in the PCIe hierarchy. [1] Protocol and link errors from
these non-enumerated ports are signaled as internal AER errors, either
Uncorrectable Internal Error (UIE) or Corrected Internal Errors (CIE)
via an RCEC.

Restricted CXL host (RCH) downstream port-detected errors have the
Requester ID of the RCEC set in the RCEC's AER Error Source ID
register. A CXL handler must then inspect the error status in various
CXL registers residing in the dport's component register space (CXL
RAS capability) or the dport's RCRB (PCIe AER extended
capability). [2]

Errors showing up in the RCEC's error handler must be handled and
connected to the CXL subsystem. Implement this by forwarding the error
to all CXL devices below the RCEC. Since the entire CXL device is
controlled only using PCIe Configuration Space of device 0, function
0, only pass it there [3]. The error handling is limited to currently
supported devices with the Memory Device class code set (CXL Type 3
Device, PCI_CLASS_MEMORY_CXL, 502h), handle downstream port errors in
the device's cxl_pci driver. Support for other CXL Device Types
(e.g. a CXL.cache Device) can be added later.

To handle downstream port errors in addition to errors directed to the
CXL endpoint device, a handler must also inspect the CXL RAS and PCIe
AER capabilities of the CXL downstream port the device is connected
to.

Since CXL downstream port errors are signaled using internal errors,
the handler requires those errors to be unmasked. This is subject of a
follow-on patch.

The reason for choosing this implementation is that the AER service
driver claims the RCEC device, but does not allow it to register a
custom specific handler to support CXL. Connecting the RCEC hard-wired
with a CXL handler does not work, as the CXL subsystem might not be
present all the time. The alternative to add an implementation to the
portdrv to allow the registration of a custom RCEC error handler isn't
worth doing it as CXL would be its only user. Instead, just check for
an CXL RCEC and pass it down to the connected CXL device's error
handler. With this approach the code can entirely be implemented in
the PCIe AER driver and is independent of the CXL subsystem. The CXL
driver only provides the handler.

[1] CXL 3.0 spec: 9.11.8 CXL Devices Attached to an RCH
[2] CXL 3.0 spec, 12.2.1.1 RCH Downstream Port-detected Errors
[3] CXL 3.0 spec, 8.1.3 PCIe DVSEC for CXL Devices

Co-developed-by: Terry Bowman <terry.bowman@amd.com>
Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Signed-off-by: Robert Richter <rrichter@amd.com>
Cc: "Oliver O'Halloran" <oohall@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-pci@vger.kernel.org
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/pci/pcie/Kconfig | 12 +++++
 drivers/pci/pcie/aer.c   | 96 +++++++++++++++++++++++++++++++++++++++-
 2 files changed, 106 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pcie/Kconfig b/drivers/pci/pcie/Kconfig
index 228652a59f27..4f0e70fafe2d 100644
--- a/drivers/pci/pcie/Kconfig
+++ b/drivers/pci/pcie/Kconfig
@@ -49,6 +49,18 @@ config PCIEAER_INJECT
 	  gotten from:
 	     https://git.kernel.org/cgit/linux/kernel/git/gong.chen/aer-inject.git/
 
+config PCIEAER_CXL
+	bool "PCI Express CXL RAS support for Restricted Hosts (RCH)"
+	default y
+	depends on PCIEAER && CXL_PCI
+	help
+	  Enables error handling of downstream ports of a CXL host
+	  that is operating in RCD mode (Restricted CXL Host, RCH).
+	  The downstream port reports AER errors to a given RCEC.
+	  Errors are handled by the CXL memory device driver.
+
+	  If unsure, say Y.
+
 #
 # PCI Express ECRC
 #
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index d3344fcf1f79..c354ca5e8f2b 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -946,14 +946,100 @@ static bool find_source_device(struct pci_dev *parent,
 	return true;
 }
 
+#ifdef CONFIG_PCIEAER_CXL
+
+static bool is_cxl_mem_dev(struct pci_dev *dev)
+{
+	/*
+	 * The capability, status, and control fields in Device 0,
+	 * Function 0 DVSEC control the CXL functionality of the
+	 * entire device (CXL 3.0, 8.1.3).
+	 */
+	if (dev->devfn != PCI_DEVFN(0, 0))
+		return false;
+
+	/*
+	 * CXL Memory Devices must have the 502h class code set (CXL
+	 * 3.0, 8.1.12.1).
+	 */
+	if ((dev->class >> 8) != PCI_CLASS_MEMORY_CXL)
+		return false;
+
+	return true;
+}
+
+static bool cxl_error_is_native(struct pci_dev *dev)
+{
+	struct pci_host_bridge *host = pci_find_host_bridge(dev->bus);
+
+	if (pcie_ports_native)
+		return true;
+
+	return host->native_aer && host->native_cxl_error;
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
+static int cxl_rch_handle_error_iter(struct pci_dev *dev, void *data)
+{
+	struct aer_err_info *info = (struct aer_err_info *)data;
+	const struct pci_error_handlers *err_handler;
+
+	if (!is_cxl_mem_dev(dev) || !cxl_error_is_native(dev))
+		return 0;
+
+	/* protect dev->driver */
+	device_lock(&dev->dev);
+
+	err_handler = dev->driver ? dev->driver->err_handler : NULL;
+	if (!err_handler)
+		goto out;
+
+	if (info->severity == AER_CORRECTABLE) {
+		if (err_handler->cor_error_detected)
+			err_handler->cor_error_detected(dev);
+	} else if (err_handler->error_detected) {
+		if (info->severity == AER_NONFATAL)
+			err_handler->error_detected(dev, pci_channel_io_normal);
+		else if (info->severity == AER_FATAL)
+			err_handler->error_detected(dev, pci_channel_io_frozen);
+	}
+out:
+	device_unlock(&dev->dev);
+	return 0;
+}
+
+static void cxl_rch_handle_error(struct pci_dev *dev, struct aer_err_info *info)
+{
+	/*
+	 * Internal errors of an RCEC indicate an AER error in an
+	 * RCH's downstream port. Check and handle them in the CXL.mem
+	 * device driver.
+	 */
+	if (pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC &&
+	    is_internal_error(info))
+		pcie_walk_rcec(dev, cxl_rch_handle_error_iter, info);
+}
+
+#else
+static inline void cxl_rch_handle_error(struct pci_dev *dev,
+					struct aer_err_info *info) { }
+#endif
+
 /**
- * handle_error_source - handle logging error into an event log
+ * pci_aer_handle_error - handle logging error into an event log
  * @dev: pointer to pci_dev data structure of error source device
  * @info: comprehensive error information
  *
  * Invoked when an error being detected by Root Port.
  */
-static void handle_error_source(struct pci_dev *dev, struct aer_err_info *info)
+static void pci_aer_handle_error(struct pci_dev *dev, struct aer_err_info *info)
 {
 	int aer = dev->aer_cap;
 
@@ -977,6 +1063,12 @@ static void handle_error_source(struct pci_dev *dev, struct aer_err_info *info)
 		pcie_do_recovery(dev, pci_channel_io_normal, aer_root_reset);
 	else if (info->severity == AER_FATAL)
 		pcie_do_recovery(dev, pci_channel_io_frozen, aer_root_reset);
+}
+
+static void handle_error_source(struct pci_dev *dev, struct aer_err_info *info)
+{
+	cxl_rch_handle_error(dev, info);
+	pci_aer_handle_error(dev, info);
 	pci_dev_put(dev);
 }
 
-- 
2.34.1

