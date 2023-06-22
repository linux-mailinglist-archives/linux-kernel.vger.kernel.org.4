Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F29673AB22
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 23:04:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231947AbjFVVEd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 17:04:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231889AbjFVVER (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 17:04:17 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2083.outbound.protection.outlook.com [40.107.94.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EA893AAE;
        Thu, 22 Jun 2023 14:01:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A9JkPQ/ggBRxC/IVe0hdMutKo7hywX62rAsDatf1bUW0b8QeTcW+fZbXNCaLx2xjofj9iVI8DYupgY8cy1r7B7wfbzyTMluGqQ5vqt4a3swGr3a0tfhJtUYZr/hrey/oERdIzUB5b8UhtwrxJv2RyR/OknbJvcnLC9mqEbr5RAyOXK1SwA9Nwt1vyDJN1UW5HdqAmlZMabHk9Wh6fF0zu8PR3zHfL1TI6Xht8QUVD6mPMYKgylzm+YKZglz7DkEJwIPb0XIYZ0Oik9dx+2scWi0RTAJpaeQOIPDq3HJfVKYSVksIvisKsbX8H850JriN/T9SkkkhVU7DymyvtCnbOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YEWZoqGQjZGiHM078woqIXSPHIqp1sJsoUluk/TlTf0=;
 b=BEFEhrHr4ypPdrmYdD8de3PmjyEP9qhVwYdMBDkGPwNDcOPNGhC3iBfUnOdGexaTVBM/3YF9/9M/I2AcNkYKPHwpSX2rcERS4HRWjwo+Q0qMA8iPFJ3h/NT/UHpvBXR+ocjU22kxAPaocnqoa4zu1X5lI4Ueuu70teTWUml9pyPLh7/XAT35T3ppQXOHCf/GpcpZxseYRrrbjUHD/xnHvL7xityz9mBke6I2P0LZatvJ3rz5dfhSH3WqbubAtH7yP1KiVlem3JoQgRsePeoomYcgD/ZpXLY/+1S3oKE4MSafELC7/catZA6t5q2y0jug/u6Hnvp/8xfZZKq21YDyKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YEWZoqGQjZGiHM078woqIXSPHIqp1sJsoUluk/TlTf0=;
 b=q3REIfJLjvt9Qg+6EbEo0dS2ZzAlj3YIPREScxxtJkdNNJViMu/NY8WIbZRbMO57HwIEV/tcVMkCO4IYfnnRxDHEYD46Oi8eMUCvJ4fWFuBRD1wnOLGkmp4CjQ5i/XWjuyhUJRDWY7vIbu4HoKBpvfoPTQSzUFl2Pvn2fSiqvZY=
Received: from CY8PR02CA0022.namprd02.prod.outlook.com (2603:10b6:930:4d::26)
 by BY5PR12MB4098.namprd12.prod.outlook.com (2603:10b6:a03:205::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Thu, 22 Jun
 2023 21:00:08 +0000
Received: from CY4PEPF0000EE35.namprd05.prod.outlook.com
 (2603:10b6:930:4d:cafe::a4) by CY8PR02CA0022.outlook.office365.com
 (2603:10b6:930:4d::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24 via Frontend
 Transport; Thu, 22 Jun 2023 21:00:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE35.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.17 via Frontend Transport; Thu, 22 Jun 2023 21:00:07 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 22 Jun
 2023 16:00:07 -0500
From:   Terry Bowman <terry.bowman@amd.com>
To:     <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <bwidawsk@kernel.org>,
        <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
        <Jonathan.Cameron@huawei.com>, <linux-cxl@vger.kernel.org>
CC:     <terry.bowman@amd.com>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: [PATCH v7 25/27] PCI/AER: Forward RCH downstream port-detected errors to the CXL.mem dev handler
Date:   Thu, 22 Jun 2023 15:55:21 -0500
Message-ID: <20230622205523.85375-26-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE35:EE_|BY5PR12MB4098:EE_
X-MS-Office365-Filtering-Correlation-Id: a779ed71-e752-4f83-d534-08db7363a92d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AoDns71SI+pTAXnpXnUvGoQvnP7RHckBRFoYKj3fjmnVi5XHH3rjiMDYBM4JJ10E2FgUky7KfesBglvFQT0JmQWwumWIOZMrMI4obsDIaLhmXBPimABDsSfYmhAoQ20FM2juJVV088ELRUZ3OeqYzgR8jTqbssO++ScLCfEK65obJhfnHZwLv98wHxeWUB0gPLyWugG4dM048hRQh5aYKrIpTs7l4JAAfSF32l8J6AUEgkkDxo6W6VlWpNcf05p4QoqYvldQEry2F/t4yhcspjcttfow071IiiIBIYkOnj4QFgu3Ni6iZndZ3pUForrHGAzPgZFPGz8jGRj9dQYBCSShp/T15tdjb1FmdycgbG7S/E2NzH1qTFdxCtilLQxNyxxIhkEPqpyOEI3YH188RXkDx+ED45c3R/TKKPd57CV94bk1UbNml9uct4/8BlyirQJsRMVPT6AxnGEMu77YADvKC+wvQZ/hOeFNl6Ng3uxGjezwo/fYpURLnB8RkkGRg2PTnh/rg2khzpL6K3zc9ipnrmvTdvH1ivO6RvUAUxdxv+DmiqY0aK4w7qPvTKuzYEzw/yv94o3lvPyN5Oca+uXIFDq+9pJ0ZPtu7eEG7QauQcZ+prN2qkUcx3D/jElX3XsTh1WJVnCNIBglb+YEdFifQLaB+TPP2M8/WeyvK0cEOPiaBHKGWZI6BM2xYl+YHlGjvRFs+HpB0Y5EYnsACeJKZ902Czn8i2dsw8WpPPb5a3387c1vWuTxHYokT5/OpBmtHSBss3ITYuRmxgQj0g==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(376002)(136003)(346002)(451199021)(40470700004)(36840700001)(46966006)(356005)(36860700001)(81166007)(4326008)(6666004)(966005)(82740400003)(26005)(186003)(16526019)(54906003)(110136005)(36756003)(2906002)(40480700001)(40460700003)(86362001)(82310400005)(2616005)(316002)(44832011)(336012)(8936002)(70586007)(70206006)(7696005)(1076003)(5660300002)(47076005)(478600001)(426003)(7416002)(41300700001)(83380400001)(8676002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 21:00:07.9429
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a779ed71-e752-4f83-d534-08db7363a92d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE35.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4098
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
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
Requster ID of the RCEC set in the RCEC's AER Error Source ID
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

