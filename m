Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD6F372717A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 00:20:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232568AbjFGWUv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 18:20:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232708AbjFGWUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 18:20:30 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2063.outbound.protection.outlook.com [40.107.220.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C371C2115;
        Wed,  7 Jun 2023 15:20:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U02+ARWVrcWHzENdJX9V5N5NQ7MK2+vYc8XydWfBzW4Oj3exJEfe7aXx9s+h0JVsbT2XB8eRjZTTaokk68tWdy6J9X2NNz+mag1S08lH1qL9KBwetyz37o15+g2sFPITvMTDljGj3kLxmh8GZEBdtOIfq4V6aYT+u4N90i+zkm+cKNlYK4X6jTxiRGaGhEkhN4vlLlT6RnJJIxrwhWyakoUmXYofFoEU6/1NY3rldgO+sPF5XSutOexXKLo+LcUUF9WsdNA76XP4/GLQMe6pmGRXquFR3E1Yw2oCcSUfMp6yaTohGjYzLv9Eq4QUFEkkwtA85D/M4tljZ3OPrsOnSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ObbhvXDTfYfnLzUlovgxR45xBzxwfVjixD1tW5Kji6Y=;
 b=nNjtvcFjezblNuNBEuS3krojfwfz0DEnQl7RJophqHMHsdfwkpPcgqxz0OAzxE23XdoxgLnTDUgrK1rBEeZxNFSB1jnbuNNQ2MR0HOGOadJxDi0l/u91Q6im7uLHvkn+1ClXZ0SSxZdi4o1gCU7J7XlGJWhsHyq8/Sc4T5ijPTbl7HofvtIrrA4PTuyV7xs3f3sd24GjsA3/qLqDPcGW2Eh6uvapqOvJEhiysAHUOesuYbkGR6DpaCXHrIiOM1fvtxRL3ril0w9Bl1sfFuI5lt7Edg48VuRzjBmJATBP8HCpjBARfwCOA0SHZRKAccTF5Rl7cAisTccDatLtWP0TIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ObbhvXDTfYfnLzUlovgxR45xBzxwfVjixD1tW5Kji6Y=;
 b=tJA1Ygg4fI0AWeuVTovCTkPJjOpYVxiUMtCnzj5MXabEZoU6bs0vx2VIHgkZj+Nzh59G9KJzKbGGGFk517C4ZCfwjFhVGty0K5EPrhqhH8NaIJaUqdU7TaK+Ch42ZTADnUZBWvLyuL7L4bqFPsvqkU6mNAkO9CijXDIqn/C/Ybk=
Received: from SN7PR04CA0043.namprd04.prod.outlook.com (2603:10b6:806:120::18)
 by PH7PR12MB8595.namprd12.prod.outlook.com (2603:10b6:510:1b5::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.19; Wed, 7 Jun
 2023 22:19:40 +0000
Received: from SA2PEPF00001507.namprd04.prod.outlook.com
 (2603:10b6:806:120:cafe::a4) by SN7PR04CA0043.outlook.office365.com
 (2603:10b6:806:120::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.19 via Frontend
 Transport; Wed, 7 Jun 2023 22:19:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001507.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6477.13 via Frontend Transport; Wed, 7 Jun 2023 22:19:40 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 7 Jun
 2023 17:19:39 -0500
From:   Terry Bowman <terry.bowman@amd.com>
To:     <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <bwidawsk@kernel.org>,
        <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
        <Jonathan.Cameron@huawei.com>, <linux-cxl@vger.kernel.org>
CC:     <terry.bowman@amd.com>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: [PATCH v5 14/26] cxl/pci: Store the endpoint's Component Register mappings in struct cxl_dev_state
Date:   Wed, 7 Jun 2023 17:16:39 -0500
Message-ID: <20230607221651.2454764-15-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00001507:EE_|PH7PR12MB8595:EE_
X-MS-Office365-Filtering-Correlation-Id: b654c5ae-9dba-4bc2-12ca-08db67a54974
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 85qyv06gffdPPu2QxJxB2kojus5cRmGwLedG+fnNWvg4DKggrHn2ZI3rRjsZHQvsEaMi1fhxaz/0qDrSIqJFqYYGcLAbOF5XT+sMRIoVM7vzfXuukK54khcgvmB8gTSYGPqBYV/nxqV4UQzimsrIYoRrXeSn04YiOwvBhDByWOnAWOeRC6XovBS0KvzE5jXr2MXIFZdu9DKbc71hYRMNQ1wkFvB89kYyjiKwJupeHS4wcgviu25t3nSmXWtE6wgCe+WvKehQ1/0eWUaOPR6WZwch1b9+YY0ynK8AGLrFH0R7M3rBCow0lO5zvosv25Oi7iBVkcORFN1ySVGre43EDRCFrpOS6CLZXq8hpLildNWrpPGyZ4EhWKmYaN4pBSEMtx4VqW8KsGFN+SFl1DwPc4gw4EzTBBEY3SCIlj+YbtkXE7m8ypuCkJNvMmFQcmAXz02jlyiZOhLIkqUKMbvPNK4uIwIIAt1ijtRNSVdmUf6/LtscGTb4cCNvKhRgkJoathDg5Ge+7ZpqgB4uWDMtit3njewZKAjslqf5iGwwPix1y/AqaUrcXXmaSscRD/RGPU2LOtygtSPqre1yg91+VMyWp9acAz7JEfiOOiuaptm/wWhGY9D5Yj/z/D9D6xb+TyXojfwQ7MQxeEFXX7jSD8wJS5Z/yiJtUMM9vR99hAPJhAiY55MYwjahBn7QCrOGtg02fZaV8OIF9pcjh8/gXEr8FQTTdbqyKWdsm5vpZLXW4mXRbLY1/H5i6v7T69M8N5eG7TaYwEyRat04Z5RCKA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(376002)(396003)(39860400002)(451199021)(36840700001)(40470700004)(46966006)(86362001)(40460700003)(7696005)(4326008)(2906002)(54906003)(110136005)(41300700001)(82310400005)(8676002)(5660300002)(82740400003)(356005)(36756003)(316002)(44832011)(81166007)(7416002)(70206006)(70586007)(40480700001)(8936002)(478600001)(36860700001)(16526019)(186003)(83380400001)(47076005)(2616005)(426003)(336012)(26005)(1076003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 22:19:40.2040
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b654c5ae-9dba-4bc2-12ca-08db67a54974
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001507.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8595
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

Same as for ports and dports, also store the endpoint's Component
Register mappings, use struct cxl_dev_state for that.

Signed-off-by: Robert Richter <rrichter@amd.com>
Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/cxl/cxlmem.h | 3 ++-
 drivers/cxl/pci.c    | 9 +++++----
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index a2845a7a69d8..2823c5aaf3db 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -263,6 +263,7 @@ struct cxl_poison_state {
  *
  * @dev: The device associated with this CXL state
  * @cxlmd: The device representing the CXL.mem capabilities of @dev
+ * @comp_map: component register capability mappings
  * @regs: Parsed register blocks
  * @cxl_dvsec: Offset to the PCIe device DVSEC
  * @rcd: operating in RCD mode (CXL 3.0 9.11.8 CXL Devices Attached to an RCH)
@@ -299,7 +300,7 @@ struct cxl_poison_state {
 struct cxl_dev_state {
 	struct device *dev;
 	struct cxl_memdev *cxlmd;
-
+	struct cxl_register_map comp_map;
 	struct cxl_regs regs;
 	int cxl_dvsec;
 
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 2975b232fcd1..816b23a6c4aa 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -662,15 +662,16 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	 * still be useful for management functions so don't return an error.
 	 */
 	cxlds->component_reg_phys = CXL_RESOURCE_NONE;
-	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_COMPONENT, &map);
+	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_COMPONENT,
+				&cxlds->comp_map);
 	if (rc)
 		dev_warn(&pdev->dev, "No component registers (%d)\n", rc);
-	else if (!map.component_map.ras.valid)
+	else if (!cxlds->comp_map.component_map.ras.valid)
 		dev_dbg(&pdev->dev, "RAS registers not found\n");
 
-	cxlds->component_reg_phys = map.resource;
+	cxlds->component_reg_phys = cxlds->comp_map.resource;
 
-	rc = cxl_map_component_regs(&map, &cxlds->regs.component,
+	rc = cxl_map_component_regs(&cxlds->comp_map, &cxlds->regs.component,
 				    BIT(CXL_CM_CAP_CAP_ID_RAS));
 	if (rc)
 		dev_dbg(&pdev->dev, "Failed to map RAS capability.\n");
-- 
2.34.1

