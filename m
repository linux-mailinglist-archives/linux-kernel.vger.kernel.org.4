Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD99870E9A8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 01:32:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238877AbjEWXcv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 19:32:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234317AbjEWXct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 19:32:49 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2060f.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eaa::60f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89EA1E7E;
        Tue, 23 May 2023 16:32:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N/1zUfzmdIQouD5ivcbTUzF9Vdu0tprIqQac6NAnMtK14BYdfkNkQDOIA6Ic6HArvoiJSGCLr2Bz0a7zuv6+KiNjKlluasFLD9c2x6lw1i5Xk/U/YK3rYC/AG9oai9OipM3hNGhiCmYiPdCSaF/yv9WNJT9fDYLbFP1YUJAFiiGr1xVJ7NJOPE7SFd0QJe1IfPSEdWpZsD3u0JSA7dJA391D5N1zyo+/3JDRJPWmgV67aVEu9drk90mgstsQ8p6WtoO+YYxygAnF1CqRo/0wikY9vpXEDoKBECQOVAZ6BfHAHs3Ouz1udfQiHH5ZiZ/DDnEOLTWnRmFC6YzwBRBbhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Up9PnbYq90TTuHUgklfiOWrK0S2RBA+NFGGLVwspxHQ=;
 b=BsKem7ANFP3pWnSL7RmHgXrvvv/+P5lWjwj34PTyFBx1mhygmU7yZItMkP4L2ABge6p4tI15hE+vQqzSGzXpJEJBa4pn41o4Hqh13K8SnjVgagtEjDeB7lL7QZ5MTf1KaksRJ5NVrSeUguRzgwNQdkFwRjiV8grK1obOGA5sM6enhRiHF7/8PCNpAARgJlvsAZRTPE+focFJH2bDcYlWfl9ooJ4+VuWcW17gS6BcT9e3bhJbmegUFjXpNlQ/4b5OT+b92EVcPeLjqT7oHlFgUsHnOM7fh3Nu5HJJDANWCPD3JJ8egGxdRJpa5YFFBpVcZToKHtsYK+LZ8vVoDoWsHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Up9PnbYq90TTuHUgklfiOWrK0S2RBA+NFGGLVwspxHQ=;
 b=c8IhaXBFBqvrNFRH6557O6ZHSvIXQkU9/XYpVP8zkav1bngKqlEYsgo1GI+QOsDt9iYZK01tLptaRnHLNxpVODuZJ6MI0bAhzn/VqJPaS1Cv0T9nMkXXvCSJJK2J1eZhBikOh+5Okti5K3x4Ao8YEswNxAyrH0qAajEHy4cdjos=
Received: from MW4PR03CA0278.namprd03.prod.outlook.com (2603:10b6:303:b5::13)
 by CH3PR12MB8331.namprd12.prod.outlook.com (2603:10b6:610:12f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Tue, 23 May
 2023 23:26:08 +0000
Received: from CO1NAM11FT070.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b5:cafe::6d) by MW4PR03CA0278.outlook.office365.com
 (2603:10b6:303:b5::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.29 via Frontend
 Transport; Tue, 23 May 2023 23:26:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT070.mail.protection.outlook.com (10.13.175.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.30 via Frontend Transport; Tue, 23 May 2023 23:26:08 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 23 May
 2023 18:26:06 -0500
From:   Terry Bowman <terry.bowman@amd.com>
To:     <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <bwidawsk@kernel.org>,
        <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
        <Jonathan.Cameron@huawei.com>, <linux-cxl@vger.kernel.org>
CC:     <terry.bowman@amd.com>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: [PATCH v4 17/23] cxl/pci: Add RCH downstream port AER register discovery
Date:   Tue, 23 May 2023 18:22:08 -0500
Message-ID: <20230523232214.55282-18-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1NAM11FT070:EE_|CH3PR12MB8331:EE_
X-MS-Office365-Filtering-Correlation-Id: a81dea59-0433-4a28-005d-08db5be51643
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5IuJ9G8p4I2ZHP2zDt1yl7bfmXHjAhrE08P01Rm1AhrkkLIX6BxifyPBLGYiBKywR16Ny37r61yZbLHsFJ3HHpy4ULk5Q2+JQlA4FTQSlf5z3mScwB14cQGOcBAiWgEHD57yt738ikCpxT1CR4kZlC+3eCfhMM3CxezvpmGuG0lHbRocr8ZhTvvfbgt+facJS2kdZreBguuTlUYKbvJ41XnxE/67a+jYBL9OhD4lrOfevj9Y2WbjGQ1SGJr7fR+WBedI2tI1jSaSPOBEmLZrrXxanyhmgy87bG7R0eod5+jezQk20pEHP0HFUv3hBjjKeMTwz5qIJ86Cg2Ns5eVvk1ZvKc70V0Y2u8ldrQtGwS0OEd54HQeUUaD7zRnWI6+CnEE+UqTtNm6C6r371I4Gv8INh0uDiZiMHGZhlUltVw3m8/XDo+w+Hg00UrKPgedGZsXO+qVgb/9I8hdKt3k9CAe0faVwryeiTzpZZCn6Grpaliu41Ab/EoB5LY7VnEbpH3kXJavIV9Qbg5x/udt1Vz9RUeWyCoLph3OdabKrCiaKkAW9khQVQ7FacVGomNlpJc1j6Mp+JOwq1OJmoXqUpW8J+pDfGbLdW+nxEF3UayDqdkGjyes7pe6DPiQV1kKmDz7buEbJm0yWCOxPhzGflnnR9qkBLNB9fvaDwTJgg7Zk6rg6QSCaOqZPtzkx9eJaoE8QEO9kYHx/X8jX0JT6ZvZk3+cWlzkpV/sKP3kcRFPH2GQNJbR53m+xjQTELzpINWlnMAxRfukDdB8Qvu/agQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(39860400002)(346002)(376002)(451199021)(40470700004)(36840700001)(46966006)(110136005)(54906003)(41300700001)(7696005)(82310400005)(316002)(4326008)(70586007)(356005)(81166007)(70206006)(82740400003)(8936002)(8676002)(86362001)(478600001)(5660300002)(44832011)(7416002)(83380400001)(47076005)(1076003)(26005)(2906002)(40460700003)(16526019)(186003)(36860700001)(36756003)(40480700001)(2616005)(336012)(426003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2023 23:26:08.0779
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a81dea59-0433-4a28-005d-08db5be51643
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT070.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8331
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
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
---
 drivers/cxl/core/regs.c | 51 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
index 7e56ddf509c0..045abc11add8 100644
--- a/drivers/cxl/core/regs.c
+++ b/drivers/cxl/core/regs.c
@@ -404,6 +404,54 @@ int cxl_setup_regs(struct cxl_register_map *map)
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
@@ -467,6 +515,9 @@ resource_size_t cxl_probe_rcrb(struct device *dev, resource_size_t rcrb,
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

