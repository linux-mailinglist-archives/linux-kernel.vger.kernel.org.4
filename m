Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA2AD727183
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 00:22:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232623AbjFGWWb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 18:22:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbjFGWW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 18:22:27 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA2FD2D4C;
        Wed,  7 Jun 2023 15:21:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=myQBDLXBtt77ucibmUf6WXnsuSYvR9TLgv/k6bJA9tZMwMJ75+UZzjCFW9kN+sPrhbpSk+oYgKYzj5AQc0yGLlRYxDvpPfun7IEMtsA4HTy0HW3MqXRHx7ienNxTSAO8sVemsLMO3ghs6nZGQw8aRTtdw0MCM+3hvh4WNS+ZtnXR3OrwxFrdCyaQ4+V1HvdcwS8vjjyPDdEPB0HjTm6o4C96MuBbvq2F1YVBa2k8uy87rduUQAhesN++dAxZ3aBRXTbcpTF07/9ZiG7sa+9uW/HTOl9ka7xDHaAIP/xn+l2gBEe8D8GyH9mMcD+ZJYoxBheABoJi4GiYs4m4kcYfFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y8AlHeFrPOvL/UwI1n2VCKJXZ/4CsGpymZqt2Tc6rjM=;
 b=PryWpfaMj8xDytUZBdi6QHomKP8Dg2zuPU6ReobtoeT4RUwqUP6/zSXW56OxLYCKe2VoAEC/2W7NPns3WOp4Xa4WoyMm4xv9WIJhsqHVAoWGTnrPJEfQtkLYFpmL074aNOxKbtAYSNFopvUu43FnGgRaWZI34Vhje/CkYuyRhmxTk0oA7gmrJDQTdrUYhtw2uzaTDxbsksuA929PuYj/zcZwmER9oYxFIuY6JsPeFd8cp2dZ/koQcso0Uc/t4RN8EMGcNzBN0ngEAAD++l/p6TrSlzv0Q+HDcWEmj/HKCz7p4r10pyQGuL9VTI9ArGqK7ZKDAcMIZ5uOrqVEIBOnCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y8AlHeFrPOvL/UwI1n2VCKJXZ/4CsGpymZqt2Tc6rjM=;
 b=J6mMj0ukIUnvLxCX3npxO8ZggGcNGgfM3kMtERmX4oo7gEO4vATSbuHlg73OLUjIyGFznFsjTQtYEIeC6se2POjpYitEI3Ny3Qgenec6DjXClFf+C91+Z1WpQijo2w0khMQEAT/ItKoA1c1eBPGCad0u5k1Tzvfrd6tqAy+jPHU=
Received: from SN7PR18CA0005.namprd18.prod.outlook.com (2603:10b6:806:f3::24)
 by SA3PR12MB8438.namprd12.prod.outlook.com (2603:10b6:806:2f6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Wed, 7 Jun
 2023 22:20:35 +0000
Received: from SA2PEPF00001504.namprd04.prod.outlook.com
 (2603:10b6:806:f3:cafe::c5) by SN7PR18CA0005.outlook.office365.com
 (2603:10b6:806:f3::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.19 via Frontend
 Transport; Wed, 7 Jun 2023 22:20:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001504.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6477.13 via Frontend Transport; Wed, 7 Jun 2023 22:20:35 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 7 Jun
 2023 17:20:34 -0500
From:   Terry Bowman <terry.bowman@amd.com>
To:     <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <bwidawsk@kernel.org>,
        <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
        <Jonathan.Cameron@huawei.com>, <linux-cxl@vger.kernel.org>
CC:     <terry.bowman@amd.com>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: [PATCH v5 19/26] cxl/pci: Add RCH downstream port AER register discovery
Date:   Wed, 7 Jun 2023 17:16:44 -0500
Message-ID: <20230607221651.2454764-20-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00001504:EE_|SA3PR12MB8438:EE_
X-MS-Office365-Filtering-Correlation-Id: d586b7a5-bcc8-47b8-4efa-08db67a56a22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9RBhsOKLew8czXDmNcFAzPFYlhRhGtLzRtzwfzOJzbqtAxzr24U05apGLg2qWcm1Nti9ntQMDJ3toN3PLXxFLdFcZqA0Ea9dd3ajxXJutMSxsqHobDoVHpZBUrPibkTAEEXoGh6mZSwRI9e8vX9q+SRojA7Eu/JqlDZtvNKDWri0Is9/wYkzLBs5ZKh0hGr6tX+c0brdInyjJDicFATinLQroQfw5ZpzKDUdkPE5EndYqLfDo+66abNQHJ3xSRSZBALR/Ae9ipca1uvxvrFkeRIP4478JA5iZkZ2bVAkL1ZEG5C8hjCus6zPsdUOdF3lqj76qywt+tOwt2Snr3Pb/GHLxdvhAe8ZFzLYxU26HUxGcleUtGd/WRgAdeffqwXo21H1oaFhrmlA31nR3jpdT4Cuq1EENstG20q6DG1oYd8S24uMVSC6BqtWW3R/gzJScXf00wJ4bpge2VZf7NxiMbOyoWDnHUWeJ5WkE4HuKc2l073vKnEKHgkzHdT/awZwnnw1Hx69BrHOjNFey5WdQgA1n37SguEWUfcmAf8ZYnwmlw/lb+G5Gz51vmKDizYEKqGMzZodSLmfVvAqMrKqwsAnMSgllwARUQT7moAIIPrPgLY8xpHWu2D623bJbKgyG0x1+FZw/AkKhgFyZEzK18ntrPz6wIM5tkKvOHzObWPpSIkYZYSM5VMW1+82s4e4U8Q1I4KNYSOFUKpuBqM0njoH5kUhw8UJnNLEdWzNRkr+kJ304h/iOAHsjLIMuX5myYFrrlqrrFJaF9u6FWy6Gw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(376002)(136003)(396003)(451199021)(40470700004)(46966006)(36840700001)(40480700001)(7696005)(70586007)(82740400003)(110136005)(54906003)(81166007)(316002)(356005)(478600001)(8936002)(47076005)(8676002)(41300700001)(4326008)(70206006)(2616005)(186003)(336012)(16526019)(426003)(36860700001)(6666004)(40460700003)(83380400001)(1076003)(26005)(86362001)(44832011)(7416002)(2906002)(82310400005)(36756003)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 22:20:35.0330
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d586b7a5-bcc8-47b8-4efa-08db67a56a22
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001504.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8438
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
 drivers/cxl/core/regs.c | 51 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
index ba2b1763042c..dd6c3c898cff 100644
--- a/drivers/cxl/core/regs.c
+++ b/drivers/cxl/core/regs.c
@@ -408,6 +408,54 @@ int cxl_setup_regs(struct cxl_register_map *map)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_setup_regs, CXL);
 
+static void __iomem *cxl_map_reg(struct device *dev, resource_size_t addr,
+				resource_size_t length)
+{
+	struct resource *res;
+
+	if (WARN_ON_ONCE(addr == CXL_RESOURCE_NONE))
+		return NULL;
+
+	res = request_mem_region(addr, length, dev_name(dev));
+	if (!res)
+		return NULL;
+
+	return ioremap(addr, length);
+}
+
+static void cxl_unmap_reg(void __iomem *base, resource_size_t addr,
+			 resource_size_t length)
+{
+	iounmap(base);
+	release_mem_region(addr, length);
+}
+
+static u16 cxl_rcrb_to_aer(struct device *dev, resource_size_t rcrb)
+{
+	void __iomem *addr;
+	u16 offset = 0;
+	u32 cap_hdr;
+
+	addr = cxl_map_reg(dev, rcrb, SZ_4K);
+	if (!addr)
+		return 0;
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
+	cxl_unmap_reg(addr, rcrb, SZ_4K);
+
+	return offset;
+}
+
 resource_size_t cxl_probe_rcrb(struct device *dev, resource_size_t rcrb,
 			       struct cxl_rcrb_info *ri, enum cxl_rcrb which)
 {
@@ -471,6 +519,9 @@ resource_size_t cxl_probe_rcrb(struct device *dev, resource_size_t rcrb,
 	if (!IS_ALIGNED(component_reg_phys, CXL_COMPONENT_REG_BLOCK_SIZE))
 		return CXL_RESOURCE_NONE;
 
+	if (ri)
+		ri->aer_cap = cxl_rcrb_to_aer(dev, ri->base);
+
 	return component_reg_phys;
 }
 EXPORT_SYMBOL_NS_GPL(cxl_probe_rcrb, CXL);
-- 
2.34.1

