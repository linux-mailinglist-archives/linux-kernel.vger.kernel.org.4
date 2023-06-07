Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D28A1727181
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 00:22:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232350AbjFGWWR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 18:22:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232291AbjFGWWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 18:22:11 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72C8326A8;
        Wed,  7 Jun 2023 15:21:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QJejOrnA78p1H8wo8MAAKo/thjk4Sc0GDWk6WOY6S3p9pS24yUhEbybarlAhllGtA9ndqlaKBZTk+6VEC9bb0iPPXIT+c0AadbLC8jfo75m+GG43SGq+9ERMLootRFlmmYmdpqOKhnPV5nqoU8es8lVaaui5MMa+yLIzdOf+0nAdn/KEitpVe/MBiNsMoyA7hodjPnKi2chOwfkEsDtyZaYkPP7LDd17PCDXsp4wlRI2hD9YQYu4x1Q0m8TdXUd251PlbbzNl+oMs7LRlpTqUUP1A1que0UenkYspe5hCnYya+J/oLVKy+5b5WTS1ok6124H+G79V92680S0myDSUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mEQCCp+ZOH7IOks8WtJDrDfddMJUmiqg2rQjTofNCEQ=;
 b=Tx9cOih3CA1PJEEGpDVHvMsocAqp4W6a+rO0G0MtU1uy+9qo/sx0UV5jW3MUkUXQk3rjJPUtStSsAXTZDkb107sSPzRzIeK/WSx+7rgIZBYY2TKLu4KTkAcVPLU9tW4fDQkycJuB8OUNIi9sWGPOg59Bm1clXIoo9KG1QrI14EjsCEn/dO1wOzv1qt18yKeB3EF7bKDIntjMnETYbXkxZG05Qr0JFgzjWaNCXZT4Hs7EqjEsGw6dQ4CBZb22LY26P/TJZJLCip8Oaku0zM4ZUYmqqpJWF0xtGT027FYNGqHiwSBCa2Rsyx+t7GIf1q/A/pqNlYHj23YGwRc3RvHl+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mEQCCp+ZOH7IOks8WtJDrDfddMJUmiqg2rQjTofNCEQ=;
 b=ziE9QHlMC/PJLDlA974tlYIlV/uxFcF5qYk8hXdo28VKTFAT3YoPa/TLAW2P9gPTn50F7Dza7xatUMAsj7RQ9Rpp5h1iqQ9LkbIfbRql/n+CyVkMh0e6uV8L/pkTNQkqb/kUkjSbSwu+THzlK4fXlAdn9qsbnsP4czAGYExiflA=
Received: from SN6PR08CA0015.namprd08.prod.outlook.com (2603:10b6:805:66::28)
 by DM6PR12MB4894.namprd12.prod.outlook.com (2603:10b6:5:209::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Wed, 7 Jun
 2023 22:20:24 +0000
Received: from SA2PEPF0000150A.namprd04.prod.outlook.com
 (2603:10b6:805:66:cafe::b6) by SN6PR08CA0015.outlook.office365.com
 (2603:10b6:805:66::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.19 via Frontend
 Transport; Wed, 7 Jun 2023 22:20:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF0000150A.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6477.13 via Frontend Transport; Wed, 7 Jun 2023 22:20:24 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 7 Jun
 2023 17:20:23 -0500
From:   Terry Bowman <terry.bowman@amd.com>
To:     <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <bwidawsk@kernel.org>,
        <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
        <Jonathan.Cameron@huawei.com>, <linux-cxl@vger.kernel.org>
CC:     <terry.bowman@amd.com>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: [PATCH v5 18/26] cxl/pci: Remove Component Register base address from struct cxl_dev_state
Date:   Wed, 7 Jun 2023 17:16:43 -0500
Message-ID: <20230607221651.2454764-19-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF0000150A:EE_|DM6PR12MB4894:EE_
X-MS-Office365-Filtering-Correlation-Id: 9fdedb3b-f8ce-41d4-28a9-08db67a563d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 82xWrBbjMPxmrgpf+snVvJh69K/Fqz+QUNh8qQsRansmCwK3YkAcnaxYOyk15aJC5rz5U9TgCQa7A5CSgaNkZ7UODUP3YrX7yJ7TbYuRfL9ozYN5rnhxfB7xBX2ddNSLBJxjcu6DUmfNLDV9qVBQbiIEcr6MieQjfCZMGE1+Ohi+3RgvtPM7TZd5IZsSWLZt/mxKm2kfyld8TjkaOYW6P2gmHunufvxngZogKt0HB579NRAFwrvr+TSC1OnxMe8JbUtL7GDTeOgNb69Ynnin1ce0wgodc1ypxgmiwkxnuj5dFsqpDt9ypXlf+XHGTjlNjRAjHsZ+KsvzWOp1QegghPNcdZwafk2USO012yGY56i7mObHyAXJap4H0+q9XCtSZEL6rZLqs/MxnZi2C3oJV6bMRVk+FOUhl+LXj/AySBf9b6LYLSbecgWpiKm0H5n4hjuKs0wzk36VzfvQXPdD1xN/kjobesmCQwjhu7dkIqiKqrOJvdxNOWKMaxCA2nLUNzLpxrjepRk9UgtNma3eQ+Ry5zsFiur9mfUabFjdcq9iSTvOl0oPbG+vf5fFVhpq27XzPXFoum7nsT4eK3ytiaIxtFxVzUJ4lG3E1vaEmPQV+Ih22wgibeYRhI9DGaa790h86uxpzRbUe72CSYA2AI0DAOV1S+gvXep4CPHb9OohDGf/BS/q0CBKoJhpLZMAfIKyg+ZRKjktiKJsER/se1qlmzZ1ockt2LeuJKbCy03GkKMbcy3Ajut7YSPYXJe08YIXqee4GpDZiLdDsX86gQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(396003)(376002)(136003)(451199021)(40470700004)(46966006)(36840700001)(7696005)(356005)(81166007)(6666004)(2906002)(82740400003)(70586007)(70206006)(54906003)(110136005)(36756003)(5660300002)(7416002)(8936002)(86362001)(8676002)(44832011)(41300700001)(40480700001)(4326008)(316002)(478600001)(40460700003)(426003)(336012)(2616005)(186003)(26005)(1076003)(16526019)(36860700001)(82310400005)(47076005)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 22:20:24.4479
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fdedb3b-f8ce-41d4-28a9-08db67a563d3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF0000150A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4894
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

The Component Register base address @component_reg_phys is no longer
used after the rework of the Component Register setup which now uses
struct member @comp_map instead. Remove the base address.

Signed-off-by: Robert Richter <rrichter@amd.com>
Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/cxl/cxlmem.h | 2 --
 drivers/cxl/mem.c    | 4 ++--
 drivers/cxl/pci.c    | 3 ---
 3 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 2823c5aaf3db..7b5b2d3187bf 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -287,7 +287,6 @@ struct cxl_poison_state {
  * @active_persistent_bytes: sum of hard + soft persistent
  * @next_volatile_bytes: volatile capacity change pending device reset
  * @next_persistent_bytes: persistent capacity change pending device reset
- * @component_reg_phys: register base of component registers
  * @info: Cached DVSEC information about the device.
  * @serial: PCIe Device Serial Number
  * @event: event log driver state
@@ -326,7 +325,6 @@ struct cxl_dev_state {
 	u64 next_volatile_bytes;
 	u64 next_persistent_bytes;
 
-	resource_size_t component_reg_phys;
 	u64 serial;
 
 	struct cxl_event_state event;
diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index 0643852444f3..618e839919eb 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -49,7 +49,6 @@ static int devm_cxl_add_endpoint(struct device *host, struct cxl_memdev *cxlmd,
 				 struct cxl_dport *parent_dport)
 {
 	struct cxl_port *parent_port = parent_dport->port;
-	struct cxl_dev_state *cxlds = cxlmd->cxlds;
 	struct cxl_port *endpoint, *iter, *down;
 	int rc;
 
@@ -65,8 +64,9 @@ static int devm_cxl_add_endpoint(struct device *host, struct cxl_memdev *cxlmd,
 		ep->next = down;
 	}
 
+	/* The Endpoint's component regs are located in cxlds. */
 	endpoint = devm_cxl_add_port(host, &cxlmd->dev,
-				     cxlds->component_reg_phys,
+				     CXL_RESOURCE_NONE,
 				     parent_dport);
 	if (IS_ERR(endpoint))
 		return PTR_ERR(endpoint);
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 816b23a6c4aa..ce14e8f32ff0 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -661,7 +661,6 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	 * If the component registers can't be found, the cxl_pci driver may
 	 * still be useful for management functions so don't return an error.
 	 */
-	cxlds->component_reg_phys = CXL_RESOURCE_NONE;
 	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_COMPONENT,
 				&cxlds->comp_map);
 	if (rc)
@@ -669,8 +668,6 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	else if (!cxlds->comp_map.component_map.ras.valid)
 		dev_dbg(&pdev->dev, "RAS registers not found\n");
 
-	cxlds->component_reg_phys = cxlds->comp_map.resource;
-
 	rc = cxl_map_component_regs(&cxlds->comp_map, &cxlds->regs.component,
 				    BIT(CXL_CM_CAP_CAP_ID_RAS));
 	if (rc)
-- 
2.34.1

