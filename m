Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03AE67271AD
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 00:29:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232860AbjFGW3Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 18:29:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbjFGW3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 18:29:14 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on20613.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e89::613])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 078B626AB;
        Wed,  7 Jun 2023 15:28:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FDZt6Ew0ZJLGJis+G+3W6zI8gw5DNWC+rVdJXla3nWRoS/Fi26/tcotFGMlk5xry0Vpv0h21XS6OKHhr1W7LW6EiCaGvjAN2TRfTbZtRFW/h+4EsHb+HgXvduyrNGhVdT37RbS1l9YxO9gZpIQ8h7wRWF2jcbm4SOCLf4p/eMAjRsGNkSAoyIpRFIJXMf2qY2ZHxvOXvhlOjCc7DfhwAUcmRva9vh51Sa7K6YoLyCCaxi/1vJHMaUewCmY82JQTdgAr6lBTyoUPSehi5l0hE0tuEbhnyUNriHQL8UImfO3GfjNegvEAPCibzhq7kD64CJyd9PA7cIE+lvwbX76nlig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YEWZoqGQjZGiHM078woqIXSPHIqp1sJsoUluk/TlTf0=;
 b=S4P7bXXnuX0mTLMlOPQgWLcK/wXTx9JFzrcWyqeEEwX4+ur/8Fk54WcgoYQy0g3MhuOvo1uJ6yUooP06p8nhcS2/woPAVDuguzJ877foYxsanMuU6A/K2EAKnYKLMpb3yEsp38w98uHAhVXt+Df8ZK26/76IyYGsy7TvJmOqGHXGme81fb9Lf4GQ8hhKIfb+eUr3c1nqEdLv/U3Awgn5kL8GinZCCUPMAXV/DRYO5/cMUTJrkh1yfwpVeAlHTRBkz3u7djMLcAYtuIDkriJARB54cFuPA8Zm2jZL6pQRakVDp0ZC9uBE7YP1+riJFoco0VQCeVoX4cB4/Q7kxW5tlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YEWZoqGQjZGiHM078woqIXSPHIqp1sJsoUluk/TlTf0=;
 b=qEsWqwj9HkVSi/lA9JX7XmzeKJ7/BIdU7FyF9OOiZrHhWZv98zY8dOwF/gIdnXCDRZwFt2ZG8BmyCTr2oCas9F9DCWJ79uj5Vrj6Ay5eiNRW14jpCX1p/bk5avDiMPWSPe6rOSUVVqCUUc4AY3v450o6HbxmlaII51FmO8WUcXs=
Received: from CY5PR04CA0009.namprd04.prod.outlook.com (2603:10b6:930:1e::35)
 by SJ0PR12MB6733.namprd12.prod.outlook.com (2603:10b6:a03:477::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Wed, 7 Jun
 2023 22:21:41 +0000
Received: from CY4PEPF0000EE33.namprd05.prod.outlook.com
 (2603:10b6:930:1e:cafe::51) by CY5PR04CA0009.outlook.office365.com
 (2603:10b6:930:1e::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33 via Frontend
 Transport; Wed, 7 Jun 2023 22:21:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE33.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6477.13 via Frontend Transport; Wed, 7 Jun 2023 22:21:41 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 7 Jun
 2023 17:21:40 -0500
From:   Terry Bowman <terry.bowman@amd.com>
To:     <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <bwidawsk@kernel.org>,
        <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
        <Jonathan.Cameron@huawei.com>, <linux-cxl@vger.kernel.org>
CC:     <terry.bowman@amd.com>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>,
        Oliver O'Halloran <oohall@gmail.com>,
        <linuxppc-dev@lists.ozlabs.org>, <linux-pci@vger.kernel.org>
Subject: [PATCH v5 25/26] PCI/AER: Forward RCH downstream port-detected errors to the CXL.mem dev handler
Date:   Wed, 7 Jun 2023 17:16:50 -0500
Message-ID: <20230607221651.2454764-26-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230607221651.2454764-1-terry.bowman@amd.com>
References: <20230607221651.2454764-1-terry.bowman@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE33:EE_|SJ0PR12MB6733:EE_
X-MS-Office365-Filtering-Correlation-Id: e35fd94b-ebb0-4a6f-0944-08db67a59196
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SzKZBTIWGW2Hg4ttAoLKqZnxQpSBpnG7w89oP6+/Rnv6+xprRsaZkkfYq1VKxV+Gj1F6oXsI45dPVejLczJ8n/xKYNso4M8AP/oz9EpWs1pKPsq+UKOa0HHrom8Xro1LZhDP1Sbe90hyIKsK6d12ihUOJ5cxpfaW6KWSFjoIn1zeqFK8ZzWjzGPbcTfw3P4ZmDSXuWPnwG2Tmc2P1tODFrNNWtOi+1pzI0lJHDmiD3z2bfILembKGTNK0BvHRNLVB7NPFCKIPpG63Pmr2ExExqusqEk1iL1wbHS0vj2FQ2FfLpBGAd8d87aOi8Y81qYEJKRqyANKcHzvGBZVdeYMQAjDcKf68G5qClCskv4uYX4qamntbRdhyUda9imgZq9DNvOXM3egMoGybJsQE9XpFIHcZr0VcBp9HmqeW8p77YwW+nRyRJNEV5jXHyQMgZ4mdmfvX7dqf8Ns+pmKEsTFwNz+87RuRt1ro0E0B1qB00iv3nyr5M3xK7qq2QaR56zNtML7eDJaKDuSFw6el7uKs5Xfuxb5gKNOUEtg9ZqVvvdTA1Dr1GxILPWYF9whQIewZeiiBIKEghTITLVzg2OyuyawbS2tXUIEQO+py8BoThV//+kgaqzmIdF38oCSx3Ly2o/OGdZejCdVLTRq/0/cagwob0oDPNDZ6VndnWaClg3758ZKWz5uCci0Czi2M0zLNtOgds9rOd+GKoswWlGAs+ciY77JJaqs5DXXR0KQjbeDeGJvboRMuNSoWgC2u3oBZ2ZDFbWDPfTIYYCKhvO0yQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(136003)(376002)(346002)(451199021)(36840700001)(46966006)(40470700004)(426003)(478600001)(2906002)(40460700003)(82740400003)(36756003)(966005)(7696005)(6666004)(36860700001)(336012)(83380400001)(2616005)(47076005)(82310400005)(16526019)(86362001)(356005)(81166007)(186003)(26005)(1076003)(40480700001)(5660300002)(8676002)(8936002)(41300700001)(316002)(70206006)(4326008)(70586007)(54906003)(110136005)(44832011)(7416002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 22:21:41.1913
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e35fd94b-ebb0-4a6f-0944-08db67a59196
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE33.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6733
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
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

