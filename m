Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B5D3607E76
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 20:57:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbiJUS5H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 14:57:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbiJUS5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 14:57:00 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2059.outbound.protection.outlook.com [40.107.93.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1715428E048;
        Fri, 21 Oct 2022 11:56:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=azUKMxPAQM9PdPdQ8ni0A72x61EfHzdWFAy5Kucaksi6R3AhVNIBIKEqNBUjRPb2lSTbWrjaF2xRRhZnBwzlu4nSIEAJyyF4uthF/1jXoD2xQ1oiYOUg0YR4Xcs8wBXUS1cV6w9bSnQB75myd2g9lW59mfh0vPwyTQVkm2sIs6uW/JjEWMPyGZ5TqVbrzfCJho2oLO6K6Ohx3ARlZNBO97bOVEDPrzjCUFc7Wkpeida2HUMuue0AHg/rpOZyDPxvURCicHDKzs4d3ytWNpo9PnTRSIgEqhZ1DN6snNaRoEaU2gUFOZF5E9TmKRJFcbqqv2jO3uc6mxghb23vnB5E0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tPLCm3ji3vI5vthM1SDorRmzlUNnDd2UN00R25Iao/k=;
 b=LLTwCKNu/mL9+IgY2dHB8T+hdKkJ9ohL2fWzvhmElnSSgXRwKQU5PBwXhE8PchE/bCI87FiMctyRmDcV3+BjxCjwoKjCkA/xtvc7C3QSgOQRYOMS4A9RhQhLnXsGPJ79o12joiyW/nGX6bMmngTStx4K8y7u1gL32leGutXXDxeoib2Aih/IHbx1CYrIPBpo4x3fuWBOvQ7E3DRTzZLOfc+H5V2eOCB21BIRZS4jFZU8Cuw+FYMBfkifKQU1Na9zQeinHwL0zuCktItPpzueR50VgmhaW2O7Um2+aEwrA7EP1bhU35nH0rSsTOwP9CKqyd/FQxgohywCmHz1pRMtGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tPLCm3ji3vI5vthM1SDorRmzlUNnDd2UN00R25Iao/k=;
 b=2gKVKULONLOlsWCFztcv5Zl2EiCLX72Xy0A9pu/oiEF15dj+HUPAWner9fjvkRma683K3XdIT05wuo/UfStpcDrM8LmSY5paPknX1mewfIPgIAtbAEXQiTeooqEAKfSZLdEe/BOHfB+RH7ioS/Bx1Xy01Flu+O479xHrAAGvoU0=
Received: from BN1PR10CA0026.namprd10.prod.outlook.com (2603:10b6:408:e0::31)
 by SA1PR12MB7197.namprd12.prod.outlook.com (2603:10b6:806:2bd::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26; Fri, 21 Oct
 2022 18:56:55 +0000
Received: from BN8NAM11FT065.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e0:cafe::ba) by BN1PR10CA0026.outlook.office365.com
 (2603:10b6:408:e0::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21 via Frontend
 Transport; Fri, 21 Oct 2022 18:56:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT065.mail.protection.outlook.com (10.13.177.63) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5746.16 via Frontend Transport; Fri, 21 Oct 2022 18:56:54 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 21 Oct
 2022 13:56:53 -0500
From:   Terry Bowman <terry.bowman@amd.com>
To:     <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <dave.jiang@intel.com>, <ira.weiny@intel.com>,
        <bwidawsk@kernel.org>, <dan.j.williams@intel.com>
CC:     <terry.bowman@amd.com>, <linux-cxl@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>,
        <rafael@kernel.org>, <lenb@kernel.org>,
        <Jonathan.Cameron@huawei.com>, <dave@stgolabs.net>,
        <rrichter@amd.com>
Subject: [PATCH 3/5] cxl/pci: Discover and cache pointer to RCD dport's CXL RAS registers
Date:   Fri, 21 Oct 2022 13:56:13 -0500
Message-ID: <20221021185615.605233-4-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221021185615.605233-1-terry.bowman@amd.com>
References: <20221021185615.605233-1-terry.bowman@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT065:EE_|SA1PR12MB7197:EE_
X-MS-Office365-Filtering-Correlation-Id: b3d9c79e-f6db-4098-a0c0-08dab396059c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UdLJBe3pl5wsW75ZgQ8ql0rTfwW/8f+UYH+IzY1qmyfjZ6oaBA3AKtJdlY/hVYORExGRkvGRROhcNUZlscV7g5FLCa2iDtm/0ACAjt59KGrVJUOb5G4c3i6cxOIzVUhg0woCqvA4Nta+7ZPeOav5HVtszu+Fu5W1SQ+Xf1oQPZl9l8Mmw/iscctHMFsbSbFfY9s2SmPIMl/opBEQYIpi2RYCw/jnGm0ZZl25peQuWVwE+CKbQZa8SE1d1On7aOAt7742UzXTtGq4N6z7AD85XjUm72UpGH4Ux4L8FuYjbSiF1QuRxfzHf55X2yzGKpOkpu06FjzS8TtuThsqnJeV9kljb/fFy/uiPdHYL/hf3ZTsCdESgkSh7yXxPvPWeUTtdU0U0U/TmfbWMkKhjLnuL/SloT4eTbidN771GYfSsphp5bPvlvkcTsodgnMfM0p6tJpR7I7KBJP27ISoHZlV6FeupyQDKJIU1gpTwql+rJ+ideqDLRmbbbj2FCdJWZGUYHZkn9LtAzi21cxdTsdyIlulI6h6kRncby33jtJ9ibSjAi2rx/uYQWxkmuiN6SKifL+caWU3xnndHrsbZdmnHC9Jnebr/srM3Ti/OOnaOk5ZEkkru1f+J/EJbgQtS245FB6cpjZuFNp3rLcE4lZ/UFsQqK1VkdyCe6DKxlnLHp9J4Bk4264yFUQeh5U4d8aCPWexrd1tKm9b1a7oZGqZEKRiFt8LyJN7Y0iMCy8DB/DNhZOEj6+LI9LjaSGoWw6zDjXc6ZeYYcmwJ+EcHfVx0XXTO2gU5GDw39Yadvh+ElJAJcUxeQYTjrTEVirdW4KC
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(376002)(39860400002)(136003)(451199015)(40470700004)(46966006)(36840700001)(8936002)(81166007)(110136005)(6666004)(54906003)(41300700001)(8676002)(70586007)(478600001)(36860700001)(4326008)(36756003)(1076003)(7696005)(2616005)(40480700001)(336012)(16526019)(186003)(82740400003)(40460700003)(356005)(86362001)(82310400005)(70206006)(26005)(47076005)(2906002)(316002)(83380400001)(426003)(7416002)(44832011)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2022 18:56:54.6494
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b3d9c79e-f6db-4098-a0c0-08dab396059c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT065.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7197
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CXL RAS information resides in a RAS capability structure located in
CXL.cache and CXL.mem registers.[1] The RAS capability provides CXL
specific error information that can be helpful in debugging. This
information is not currently logged but needs to be logged during PCIe AER
error handling.

Update the CXL driver to find and cache a pointer to the CXL RAS
capability. The RAS registers resides in the downport's component register
block. Note:RAS registers are not in the upport. The component registers
can be found by first using the RCRB to goto the downport. Next, the
downport's 64-bit BAR[0] will point to the component register block.

[1] CXL3.0 Spec, '8.2.5 CXL.cache and CXL.mem Registers'

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
---
 drivers/cxl/cxl.h    |  4 +++
 drivers/cxl/cxlmem.h |  1 +
 drivers/cxl/pci.c    | 72 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 77 insertions(+)

diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 7d507ab80a78..69b50131ad86 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -36,6 +36,10 @@
 #define   CXL_CM_CAP_CAP_ID_HDM 0x5
 #define   CXL_CM_CAP_CAP_HDM_VERSION 1
 
+/* CXL 3.0 8.2.4.2 CXL RAS Capability Header */
+#define CXL_CM_CAP_ID_RAS 0x2
+#define CXL_CM_CAP_SIZE_RAS 0x5C
+
 /* HDM decoders CXL 2.0 8.2.5.12 CXL HDM Decoder Capability Structure */
 #define CXL_HDM_DECODER_CAP_OFFSET 0x0
 #define   CXL_HDM_DECODER_COUNT_MASK GENMASK(3, 0)
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 079db2e15acc..515273e224ea 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -243,6 +243,7 @@ struct cxl_dev_state {
 	u64 next_persistent_bytes;
 
 	struct cxl_register_map aer_map;
+	struct cxl_register_map ras_map;
 
 	resource_size_t component_reg_phys;
 	u64 serial;
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 2287b5225862..7f717fb47a36 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -586,6 +586,78 @@ void cxl_pci_aer_init(struct cxl_memdev *cxlmd)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_pci_aer_init, CXL);
 
+static resource_size_t cxl_get_dport_ras_base(struct cxl_memdev *cxlmd)
+{
+	resource_size_t component_reg_phys, offset = 0;
+	struct cxl_dev_state *cxlds = cxlmd->cxlds;
+	void *cap_hdr_addr, *comp_reg_mapped;
+	u32 cap_hdr, ras_cap_hdr;
+	int cap_ndx;
+
+	comp_reg_mapped = ioremap(cxlds->component_reg_phys +
+				  CXL_CM_OFFSET, CXL_COMPONENT_REG_BLOCK_SIZE);
+	if (!comp_reg_mapped)
+		return 0;
+
+	cap_hdr_addr = comp_reg_mapped;
+	cap_hdr = readl(cap_hdr_addr);
+	for (cap_ndx = 0;
+	     cap_ndx < FIELD_GET(CXL_CM_CAP_HDR_ARRAY_SIZE_MASK, cap_hdr);
+	     cap_ndx++) {
+		ras_cap_hdr = readl(cap_hdr_addr + cap_ndx*sizeof(u32));
+
+		if (FIELD_GET(CXL_CM_CAP_HDR_ID_MASK, ras_cap_hdr) == CXL_CM_CAP_ID_RAS) {
+			pr_debug("RAS cap header = %X @ %pa, cap_ndx = %d\n",
+				 ras_cap_hdr, cap_hdr_addr, cap_ndx);
+			break;
+		}
+	}
+
+	offset = CXL_CM_OFFSET + PCI_EXT_CAP_NEXT(ras_cap_hdr);
+
+	iounmap(comp_reg_mapped);
+
+	if (FIELD_GET(CXL_CM_CAP_HDR_ID_MASK, ras_cap_hdr) != CXL_CM_CAP_ID_RAS)
+		return 0;
+
+	pr_debug("Found RAS capability @ %llX (%X)\n",
+		 component_reg_phys + offset, *((u32 *)(comp_reg_mapped + offset)));
+
+	return component_reg_phys + offset;
+}
+
+static int cxl_setup_dport_ras(struct cxl_memdev *cxlmd, resource_size_t resource)
+{
+	struct cxl_register_map *map = &cxlmd->cxlds->ras_map;
+	struct pci_dev *pdev = to_pci_dev(&cxlmd->dev);
+
+	if (!resource) {
+		pr_err("%s():%d: RAS resource ptr is NULL\n", __func__, __LINE__);
+		return  -EINVAL;
+	}
+
+	map->base = devm_cxl_iomap_block(&pdev->dev, resource, CXL_CM_CAP_SIZE_RAS);
+	if (!map->base)
+		return -ENOMEM;
+
+	return 0;
+}
+
+void cxl_pci_ras_init(struct cxl_memdev *cxlmd)
+{
+	resource_size_t cap;
+
+	/*
+	 * TODO - CXL2.0 will need change to support PCI config space.
+	 */
+	if (!is_rcd(cxlmd))
+		return;
+
+	cap = cxl_get_dport_ras_base(cxlmd);
+	cxl_setup_dport_ras(cxlmd, cap);
+}
+EXPORT_SYMBOL_NS_GPL(cxl_pci_ras_init, CXL);
+
 static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	struct cxl_register_map map;
-- 
2.34.1

