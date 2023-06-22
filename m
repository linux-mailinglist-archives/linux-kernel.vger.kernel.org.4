Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B565739605
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 05:58:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbjFVD63 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 23:58:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230191AbjFVD5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 23:57:43 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2058.outbound.protection.outlook.com [40.107.93.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9FA61FFD;
        Wed, 21 Jun 2023 20:56:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UM3ItGDMgAxQtZ6pAyE75ILgn8QXbk2QaZyB0lVkpg3huk3QZn8SExs840XgDrTvigmSwl2QDNeLLNunb82pxdqmFxAY6AG7RYU6R9zsqZsejgQBk8QZDYSSacFsRFIEbEZDKdUYRCakbxve7u4WbDgDkewkPmY4Ewvzn4wc0KeHlNqSSa8VWFvBWRShvzaeTX8NfSnq+jkd0pdvOfNvCMc/5WwPv1n/hI9AJc4E8WUL2n79q73X6E+BE70NfzUgiS5/0k8RwQhpVnaF/BZuNdfx68WTfug7FI8n48doqYBuFLPWukE5pwG6lZe7fEL3A+H65N4GMqdIOFQBWY/grw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=elGP9FkYghUy70/jcm7qSXPKwzKRFZeI2IrOiqqgJDE=;
 b=YtmB5TkJSF9Mrfu394QnNcuB+152b2VMRzyTSFXnZD7bA+tj7e+c5Ldsy1GRgi5gnHcURXEVMOfTlofp0m7TIzxSf7Iv0NCgc3qn5YTMSxB+nHredOC7W7P9GZcxOFLkrWKjHFd5ddo+V1YkI9xvCQFrazVoF/TIw0rhmZ4PIcz1zXsHuH1BusvZrqArcn4TYDEfQXtnwAR63SKEpsRzsiXlbBaa2cxk88X9Bb/AH1gicKYvYgpvQDNuFgtZkfmGAlA2vX/e2e2sackn1RptERjvBq5SJY2ZjmjxJoRpRmH3W/vH2ug7wYJJMboMuoFOhI1gaKoV/IMml6Ri6xWSGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com;
 dmarc=temperror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=elGP9FkYghUy70/jcm7qSXPKwzKRFZeI2IrOiqqgJDE=;
 b=sQ4325YV2JjknKbSh9TW3Wiebj1XXvqLP8XfdX1Vi98xwZnDcqkLEC9IHz7mPjqAtdPNhryDCiG7uS4QUsGbumNHY7HQhmypUmJZHzOc0o/Vusy9norW1zB7WUaZ3Phx8Zqy8PHovsQkQYk75EPgxcu6hjDNBrNzaGF9vYgWpNM=
Received: from BN7PR06CA0057.namprd06.prod.outlook.com (2603:10b6:408:34::34)
 by SJ0PR12MB5456.namprd12.prod.outlook.com (2603:10b6:a03:3ae::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Thu, 22 Jun
 2023 03:56:25 +0000
Received: from BN8NAM11FT105.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:34:cafe::69) by BN7PR06CA0057.outlook.office365.com
 (2603:10b6:408:34::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24 via Frontend
 Transport; Thu, 22 Jun 2023 03:56:24 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=temperror action=none header.from=amd.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of amd.com: DNS Timeout)
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT105.mail.protection.outlook.com (10.13.176.183) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.41 via Frontend Transport; Thu, 22 Jun 2023 03:56:23 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 21 Jun
 2023 22:56:21 -0500
From:   Terry Bowman <terry.bowman@amd.com>
To:     <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <bwidawsk@kernel.org>,
        <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
        <Jonathan.Cameron@huawei.com>, <linux-cxl@vger.kernel.org>
CC:     <terry.bowman@amd.com>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: [PATCH v6 20/27] cxl/pci: Add RCH downstream port AER register discovery
Date:   Wed, 21 Jun 2023 22:51:19 -0500
Message-ID: <20230622035126.4130151-21-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230622035126.4130151-1-terry.bowman@amd.com>
References: <20230622035126.4130151-1-terry.bowman@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT105:EE_|SJ0PR12MB5456:EE_
X-MS-Office365-Filtering-Correlation-Id: c8bf6726-8a8d-4b0d-de93-08db72d4a50d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sEj5OcJKczv8jzw3Q+3/Rx4I891bvJY7smm34/cQgYP+6hElKKeOVHZXdNwctX5Hctzv8adnAMABuWcNly1vrRi9YalLK4yqcHFChpw36PsjqOmpFkr1qmnr5Vm4Rt5mFjDytLfBrclDHCYIIqfO0YsEdeN+6MBgJg4IsRvORVKr7t7HcK/1R3v6ETzC9/iHokO81Y8PskTovagl4xzsUOxirc6ukQ8hYA2J+8l/UWaWCxdINTM+ysLp7brVlGOWxufv43lHhLT+5ngPRzcEjsYkFUBkj4Ny9pDxy2yO9uyYIsywqqIsKSZgPjwBjvabBP1rCsuwoIXaAIkNwRAl0fcXzbeGk2p6h7SSqcSBfwE7sO5bMn4VpZ0fPp0jrNSiwA1RbjP/OtlxSSZRvnQeB9v0oYmZlQ2oIXEsSu32bqaomnml3uvp1jxD8wHUCGjnS5Ii93lJHQKY6CA3Q0nqlmTtzS8mkvAkAohCbbISZ9uFWA5ELUoDhWsMCICELOc5kzdPnt/GDBZwrL/KAzqOOFlp5PTpSQVcXI0Uib1autMhEoO7mVpPnNw+tnL01nMBmvhn7OfPW/LzxCLcm9Q5W2BzozILpI9ingR1i4iMjndJkuvb+AQH4609/JmOSSSw3iUNwfKhqqoKpWZZJCHTGj0NDxdWkMxsr6Q9ZSCdb/6Pv1td0HvAXXsDWa8DqV91LT3SXTDa8G3dqYl65PvEtHOGnEA/Ddagp/EBki8Cy7ZTTseKr2/MCJA71UnnmqWFrsBxCm06qC1Ft0Ijt+ugbw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(376002)(396003)(136003)(451199021)(40470700004)(36840700001)(46966006)(7416002)(8936002)(8676002)(86362001)(44832011)(70586007)(316002)(70206006)(4326008)(2906002)(478600001)(110136005)(41300700001)(54906003)(5660300002)(82740400003)(1076003)(82310400005)(83380400001)(63370400001)(63350400001)(7696005)(36860700001)(2616005)(47076005)(336012)(426003)(40460700003)(81166007)(356005)(16526019)(186003)(26005)(36756003)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 03:56:23.0371
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c8bf6726-8a8d-4b0d-de93-08db72d4a50d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT105.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5456
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
 drivers/cxl/core/port.c |  7 ++++++-
 drivers/cxl/core/regs.c | 35 +++++++++++++++++++++++++++++++++++
 3 files changed, 42 insertions(+), 1 deletion(-)

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
index cfae8307de90..37ecd756b224 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -678,7 +678,6 @@ static struct cxl_port *cxl_port_alloc(struct device *uport_dev,
 	device_set_pm_not_required(dev);
 	dev->bus = &cxl_bus_type;
 	dev->type = &cxl_port_type;
-
 	return port;
 
 err:
@@ -974,6 +973,8 @@ __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
 		return ERR_PTR(-ENOMEM);
 
 	if (rcrb != CXL_RESOURCE_NONE) {
+		struct pci_host_bridge *host_bridge;
+
 		dport->rcrb.base = rcrb;
 		component_reg_phys = __rcrb_to_component(dport_dev, &dport->rcrb,
 							 CXL_RCRB_DOWNSTREAM);
@@ -982,6 +983,10 @@ __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
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

