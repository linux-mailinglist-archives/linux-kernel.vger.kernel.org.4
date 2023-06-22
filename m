Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26BB973AB1D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 23:03:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231689AbjFVVDu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 17:03:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231590AbjFVVCv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 17:02:51 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2056.outbound.protection.outlook.com [40.107.243.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70C6E30DD;
        Thu, 22 Jun 2023 14:00:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=drpdQ2IYhy38TMC+P8OFch6Ccrj4axN3r0P+GF5hgFDmkTSi6F45ezbmDNiWSOx20JnHrsrNxfEcwOQh2xJytCBbhR+/XMhT09NuOVUoFOX0bLnchiM9BDDJbG88eolp/oF93+M5fqKyUFrzwDoq0XJvYJ548tBv3ROK4c9f8DamDq+GvwnN4GJmSEQQnBFHMaMeEcKpnVf11Zi8yl6I+3dQ3+kc5At159A0yceEhcXrRNJPMFij3RiybeBVOEz2wv9oRvJXLbpEEhCFT0BwJhGPDpK9SjY5TCIkRic5LhHMrVqyjSbuY4gOWzlb4lez2sPcGr+YKjtM9spDcnN4gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aGZHL0FNyVRnfyqMoVkUetaLQ+MaFCXWCgXRu2cIQnk=;
 b=TfQFjR/eVDvE0oVRQOoWxrMa2n2kEBiWq1IwUIJxHqP99NVVuMNziSTsNieBJHs3hOrhVkFGZ0eR1yrtRb2kocp8/7KEYPjf6RU5X35VOIqB+CLFaFnHJT/gUvoEYB58rXNgvB4DaThw8MopMM6NLDEYTbURGob4DGQatM81Aw3Ld0RRpu61Bf3A0t/AVQup0sQvuqJYzeKnGYtys2F/LI1n1GP2Po6m6ah0YP2FUB7Js7fME04Ieg7jt1tTzcP42qXKJWBIWXbnhGP1GhW2p6KfdJoIN4Io7qxPproCuADtWo86nbg8D/LfhlIt+apuqM5d1DLOA/C2Gp62uwGV6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aGZHL0FNyVRnfyqMoVkUetaLQ+MaFCXWCgXRu2cIQnk=;
 b=y0gzh+YeQ6V80PepvGzALp5c0QdM/026HQZf6WDt3b5dzviAW5JB5gKNqmLF5Izl5RzWdTJQlJKTBGkxifA0raUj1Coesym0bR0OcWE5bhR2N+5ngyr/5BcMGsMkka/9VpvpMvpRzJ2DDujUx4tTCsRdF++WG7U7biPPf6GjN0U=
Received: from CY5PR15CA0155.namprd15.prod.outlook.com (2603:10b6:930:67::14)
 by CH3PR12MB8970.namprd12.prod.outlook.com (2603:10b6:610:176::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Thu, 22 Jun
 2023 20:59:02 +0000
Received: from CY4PEPF0000EE34.namprd05.prod.outlook.com
 (2603:10b6:930:67:cafe::b4) by CY5PR15CA0155.outlook.office365.com
 (2603:10b6:930:67::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24 via Frontend
 Transport; Thu, 22 Jun 2023 20:59:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE34.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.17 via Frontend Transport; Thu, 22 Jun 2023 20:59:02 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 22 Jun
 2023 15:59:01 -0500
From:   Terry Bowman <terry.bowman@amd.com>
To:     <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <bwidawsk@kernel.org>,
        <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
        <Jonathan.Cameron@huawei.com>, <linux-cxl@vger.kernel.org>
CC:     <terry.bowman@amd.com>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: [PATCH v7 19/27] cxl/pci: Add RCH downstream port AER register discovery
Date:   Thu, 22 Jun 2023 15:55:15 -0500
Message-ID: <20230622205523.85375-20-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE34:EE_|CH3PR12MB8970:EE_
X-MS-Office365-Filtering-Correlation-Id: 745369da-bed8-4840-4f22-08db7363823e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NcH9DRFecuXR0IuDKEmp+QpWbxagHPS9prdjXAD9WaxBtmPPti3byjDI97vmXk+ChRmNDfl58qJjkvZBaU/zBu/gMerzTvUafg60OqWiK6muUY+nVk0hZ7UAMr2togezESJofTByg+FRt6JzwVze3fryzoRKdrRyHqfLnJ1tPJixuPkpC8sGepNeFI6faAoo4SgaJJXnGXorDkG024lJEnqa1JpYbFglTpXjWXlPNGYoxjhfO3MVJy8MAcvHwcq3Zi2i3KXTv/oW0gfSPD1a/hsgwvaqlzo/yfsGn0q1IAxmxhUjz6Gboc+TQ09lDWOErySTSSYahoPiZriBkc2zWnNiBq2YKf35hUacGJwJc7zwGazrSwJU7XFriy5DlsaeMFy5dGGV65RzeRAqto+9M//Th172Tov7BT/JjDI3zJ5VkQmFVQc0KFRTrcRGbwO0omvnsvMCRxxH0KYkH+E94o0nYkgYEjVLeLBFxqqNoPJGp+6K3GoOnOV4lOXjZnATH73+wIJEM9pXisC5G+Mrkcs/h+qis3Ym0wfRgrmFyPN9xCtfUu/taNebMsj6WiRg6QxLg6AOKzwgnDXJcYaTP0EJocFobmUTZKUrwkyzNfy5OtljU3hjCotJgp/dzAoMoq60YXMV/KxISSN67DV9fj/YccP4oi6PkI82fbEvOdcAj49Be3KXTL8EyUQdVbCtYRDnzoEgXPHq9eFdyWj0F4e6eEUJ36kPoki/HJyy9MP+cp9AqBAq0nw3+/VMBdpSo9OjE9ulchqg3bHHkkL74Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(346002)(136003)(376002)(451199021)(36840700001)(46966006)(40470700004)(2906002)(82310400005)(7696005)(478600001)(4326008)(70586007)(70206006)(36756003)(6666004)(54906003)(86362001)(40460700003)(316002)(110136005)(1076003)(47076005)(26005)(186003)(426003)(2616005)(336012)(356005)(82740400003)(16526019)(83380400001)(81166007)(5660300002)(41300700001)(8936002)(8676002)(44832011)(36860700001)(7416002)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 20:59:02.6041
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 745369da-bed8-4840-4f22-08db7363823e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE34.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8970
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Restricted CXL host (RCH) downstream port AER information is not currently
logged while in the error state. One problem preventing the error logging
is the AER and RAS registers are not accessible. The CXL driver requires
changes to find RCH downstream port AER and RAS registers for purpose of
error logging.

RCH downstream ports are not enumerated during a PCI bus scan and are
instead discovered using system firmware, ACPI in this case.[1] The
downstream port is implemented as a Root Complex Register Block (RCRB).
The RCRB is a 4k memory block containing PCIe registers based on the PCIe
root port.[2] The RCRB includes AER extended capability registers used for
reporting errors. Note, the RCH's AER Capability is located in the RCRB
memory space instead of PCI configuration space, thus its register access
is different. Existing kernel PCIe AER functions can not be used to manage
the downstream port AER capabilities and RAS registers because the port was
not enumerated during PCI scan and the registers are not PCI config
accessible.

Discover RCH downstream port AER extended capability registers. Use MMIO
accesses to search for extended AER capability in RCRB register space.

[1] CXL 3.0 Spec, 9.11.2 - System Firmware View of CXL 1.1 Hierarchy
[2] CXL 3.0 Spec, 8.2.1.1 - RCH Downstream Port RCRB

Co-developed-by: Robert Richter <rrichter@amd.com>
Signed-off-by: Robert Richter <rrichter@amd.com>
Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/cxl/core/core.h |  1 +
 drivers/cxl/core/port.c |  6 ++++++
 drivers/cxl/core/regs.c | 35 +++++++++++++++++++++++++++++++++++
 3 files changed, 42 insertions(+)

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index b001669a5133..87467c633123 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -72,6 +72,7 @@ struct cxl_rcrb_info;
 resource_size_t __rcrb_to_component(struct device *dev,
 				    struct cxl_rcrb_info *ri,
 				    enum cxl_rcrb which);
+u16 cxl_rcrb_to_aer(struct device *dev, resource_size_t rcrb);
 
 extern struct rw_semaphore cxl_dpa_rwsem;
 
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 95d5aae1f97b..449472fb26a8 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -975,6 +975,8 @@ __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
 		return ERR_PTR(-ENOMEM);
 
 	if (rcrb != CXL_RESOURCE_NONE) {
+		struct pci_host_bridge *host_bridge;
+
 		dport->rcrb.base = rcrb;
 		component_reg_phys = __rcrb_to_component(dport_dev, &dport->rcrb,
 							 CXL_RCRB_DOWNSTREAM);
@@ -983,6 +985,10 @@ __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
 			return ERR_PTR(-ENXIO);
 		}
 
+		host_bridge = to_pci_host_bridge(dport_dev);
+		if (host_bridge->native_cxl_error)
+			dport->rcrb.aer_cap = cxl_rcrb_to_aer(dport_dev, dport->rcrb.base);
+
 		dport->rch = true;
 	}
 
diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
index e68848075bb6..60b7ba7f4030 100644
--- a/drivers/cxl/core/regs.c
+++ b/drivers/cxl/core/regs.c
@@ -407,6 +407,41 @@ int cxl_setup_regs(struct cxl_register_map *map)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_setup_regs, CXL);
 
+u16 cxl_rcrb_to_aer(struct device *dev, resource_size_t rcrb)
+{
+	void __iomem *addr;
+	u16 offset = 0;
+	u32 cap_hdr;
+
+	if (WARN_ON_ONCE(rcrb == CXL_RESOURCE_NONE))
+		return 0;
+
+	if (!request_mem_region(rcrb, SZ_4K, dev_name(dev)))
+		return 0;
+
+	addr = ioremap(rcrb, SZ_4K);
+	if (!addr) {
+		release_mem_region(rcrb, SZ_4K);
+		return 0;
+	}
+
+	cap_hdr = readl(addr + offset);
+	while (PCI_EXT_CAP_ID(cap_hdr) != PCI_EXT_CAP_ID_ERR) {
+		offset = PCI_EXT_CAP_NEXT(cap_hdr);
+		if (!offset)
+			break;
+		cap_hdr = readl(addr + offset);
+	}
+
+	if (offset)
+		dev_dbg(dev, "found AER extended capability (0x%x)\n", offset);
+
+	iounmap(addr);
+	release_mem_region(rcrb, SZ_4K);
+
+	return offset;
+}
+
 resource_size_t __rcrb_to_component(struct device *dev, struct cxl_rcrb_info *ri,
 				    enum cxl_rcrb which)
 {
-- 
2.34.1

