Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96AB070E97B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 01:24:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238727AbjEWXY4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 19:24:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238718AbjEWXYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 19:24:51 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2083.outbound.protection.outlook.com [40.107.244.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF003184;
        Tue, 23 May 2023 16:24:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dVI6L3Q+5VLGi5UdC+q+kmN8BBwCfpSkSTqqdWKILgj3nTTqS581vwxw5ri3mbaItPZYE4e6RU/uQuLhnTss0qEJafAlBSGFVlJUnxmREkZwo0l3ckDYPv4gn8xaBGDiFdqugy/BNg3RJ91AnXN+WQZDLpP75jLJ1nw9v7klN5iAnvDPrj/ZwPVOq0S3FwWm+ZRe82FYxfAsYpjqK/B3oo3wwgYLRShnEA7opaq4J96qDIPLfqRdrzXc66MEc06Yghnr38x9SQxTYznhuj8aLZHJ3GuAK/+j2WUiQ4HoOo8h/AuStp6sp1TIZBJKW6qcaS3o4G+Ai4OQ9ye9mRcUAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g8ZHaV2lEJshBMFNLkBFdton5/MRV4L5HGfPj8fCoPg=;
 b=YtGCauRQEcx0ql7a3LtA0+7K6QFtU8Zbdx/DS3jWOOa2ZUz9D6WCyJR7x+8sPllf7t5ewMMLzB5zrZ3wPni3JOeczrX2S4YDlGtzRs+0MmoOnfU6GQ2VvKLLUCf+B8EIVxh5cQwaNlCygmOba6SmOYYNWOPT2zwXSO9VqLrf8mrkwQlC+MFWVri/OsQSyWi91iJGmfmyQ1i1TeVh3lLsMcZM2BT2NnP0mkN5L/8wI02GTpz6Qdb8Q5h+5k/uAfDqPEUvx/fifIaR+lXlVBVzAjYsXH7vpSv7VIXM/gG3dyn6HBPnWtlhxCZnTpFAGd4sEnDTByQBkBkFoFaXhbcfNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g8ZHaV2lEJshBMFNLkBFdton5/MRV4L5HGfPj8fCoPg=;
 b=byNB6/ITDygwmPO3QR+1Ftf/aJRBc3Lqt7qVgZU1r3yhxFkJ/RqXWvW/qqvTLO4zYU84pkZmionZO3GqvpCnac20gvLfE/Yx8SaIsit2CI12CuoOUV8R6BT+WfLtlORJij/ZbrQWWIeOdRHa2TaVXx+eytq7AiLt29/17x57s7w=
Received: from MW4PR03CA0354.namprd03.prod.outlook.com (2603:10b6:303:dc::29)
 by DS0PR12MB6533.namprd12.prod.outlook.com (2603:10b6:8:c2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Tue, 23 May
 2023 23:24:22 +0000
Received: from CO1NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:dc:cafe::92) by MW4PR03CA0354.outlook.office365.com
 (2603:10b6:303:dc::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.14 via Frontend
 Transport; Tue, 23 May 2023 23:24:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT008.mail.protection.outlook.com (10.13.175.191) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.30 via Frontend Transport; Tue, 23 May 2023 23:24:21 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 23 May
 2023 18:24:17 -0500
From:   Terry Bowman <terry.bowman@amd.com>
To:     <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <bwidawsk@kernel.org>,
        <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
        <Jonathan.Cameron@huawei.com>, <linux-cxl@vger.kernel.org>
CC:     <terry.bowman@amd.com>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: [PATCH v4 07/23] cxl/acpi: Directly bind the CEDT detected CHBCR to the Host Bridge's port
Date:   Tue, 23 May 2023 18:21:58 -0500
Message-ID: <20230523232214.55282-8-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1NAM11FT008:EE_|DS0PR12MB6533:EE_
X-MS-Office365-Filtering-Correlation-Id: 8bc9cda2-10de-4b02-53e0-08db5be4d6ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TbQpJz7KZRBua2m9slYYTazlw0pKvfdyov5tCb9sHj4GCqIjE3feqexdvW1TFOghrtKUFQuTUH8GKd9HLSRyurTFG6rb6va1m+T7uHoY60VqCoRwqia38eRltz5PMSufd0OwaC7a538jUFMnTOjWfjYHbjIjjUWM5eoVTfXjN1jgHu9jPGY4HYb44wotR8WLFZmoJZd5DT6KHBNbVRwwv0tMLnF5SxBj1/krKIPTbDtOX3egY9CgGtcwNz7iqNKJZCquJzgBesUHsTL5eUHp9uxDEpdVnjivlw7em8mi+LSd5h7SxWy9YKs7FxG/928VBR8nUmcxvrPoKkjNWrRA2c6OR5PXlbxzCU66kk5hpqtegUMF3XqE+N6FRKJbiTgFaS/YwEZ4X3j4H0VLtnDLe8TX/YkFDSVrpjHNU5Yselb+kpLQRUFva8BepLSKJnI+MEHkw/awzpmly6A8a8NeGY6YaoYKpIFJxdJ0tkTSlnB3sX0Y1wjGD5rMDrYlSfjyVd1rC+LBS0FxctibD7J8rl2oqtKL9/FXM3drmHTySSiCmI1LsWZQz/FYFTPxn5bDolNXXQpsVyZu5xKRR1zxvieffSb2Z+FNv6Cg4EpZ32W1WKGY9ltg5IX8DYjauhlU9zw5ExoMlAzNNRVeRAkZQkqjQH0vszOcMfb+Z/SrebKUB8VMFhdijrcNCTKqxVApKEwH992ftisFlZUwqMK9zVO6vtdK42xtP3iWuNjmxoBpaFnfAVGN0TSKJttghWN8GZW7yjDda/6+gpvQrSBh8w==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(39860400002)(346002)(396003)(451199021)(40470700004)(36840700001)(46966006)(82310400005)(2906002)(7696005)(6666004)(82740400003)(70586007)(70206006)(110136005)(41300700001)(478600001)(54906003)(426003)(47076005)(2616005)(81166007)(40480700001)(356005)(86362001)(7416002)(8936002)(8676002)(40460700003)(316002)(44832011)(4326008)(36756003)(83380400001)(186003)(26005)(1076003)(336012)(36860700001)(5660300002)(16526019)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2023 23:24:21.4071
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bc9cda2-10de-4b02-53e0-08db5be4d6ae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6533
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

During a Host Bridge's downstream port enumeration the CHBS entries in
the CEDT table are parsed, its Component Register base address
extracted and then stored in struct cxl_dport. The CHBS may contain
either the RCRB (RCH mode) or the Host Bridge's Component Registers
(CHBCR, VH mode). The RCRB further contains the CXL downstream port
register base address, while in VH mode the CXL Downstream Switch
Ports are visible in the PCI hierarchy and the DP's component regs are
disovered using the CXL DVSEC register locator capability. The
Component Registers derived from the CHBS for both modes are different
and thus also must be treated differently. That is, in RCH mode, the
component regs base should be bound to the dport, but in VH mode to
the CXL host bridge's port object.

The current implementation stores the CHBCR in addition in struct
cxl_dport and copies it later from there to struct cxl_port. As a
result, the dport contains the wrong Component Registers base address
and, e.g. the RAS capability of a CXL Root Port cannot be detected.

To fix the CHBCR binding, attach it directly to the Host Bridge's
@cxl_port structure. Do this during port creation of the Host Bridge
in add_host_bridge_uport(). Factor out CHBS parsing code in
add_host_bridge_dport() and use it in both functions.

Signed-off-by: Robert Richter <rrichter@amd.com>
Signed-off-by: Terry Bowman <terry.bowman@amd.com>
---
 drivers/cxl/acpi.c | 65 +++++++++++++++++++++++++++++++++++-----------
 1 file changed, 50 insertions(+), 15 deletions(-)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index 4fd9fe32f830..78a24b2ca923 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -333,8 +333,8 @@ struct cxl_chbs_context {
 	u32 cxl_version;
 };
 
-static int cxl_get_chbs(union acpi_subtable_headers *header, void *arg,
-			 const unsigned long end)
+static int cxl_get_chbs_iter(union acpi_subtable_headers *header, void *arg,
+			     const unsigned long end)
 {
 	struct cxl_chbs_context *ctx = arg;
 	struct acpi_cedt_chbs *chbs;
@@ -362,6 +362,22 @@ static int cxl_get_chbs(union acpi_subtable_headers *header, void *arg,
 	return 0;
 }
 
+static int cxl_get_chbs(struct acpi_device *hb, struct cxl_chbs_context *ctx)
+{
+	unsigned long long uid;
+	int rc;
+
+	rc = acpi_evaluate_integer(hb->handle, METHOD_NAME__UID, NULL, &uid);
+	if (rc != AE_OK)
+		return -ENOENT;
+
+	memset(ctx, 0, sizeof(*ctx));
+	ctx->uid = uid;
+	acpi_table_parse_cedt(ACPI_CEDT_TYPE_CHBS, cxl_get_chbs_iter, ctx);
+
+	return 0;
+}
+
 static int add_host_bridge_dport(struct device *match, void *arg)
 {
 	acpi_status rc;
@@ -377,19 +393,15 @@ static int add_host_bridge_dport(struct device *match, void *arg)
 	if (!hb)
 		return 0;
 
-	rc = acpi_evaluate_integer(hb->handle, METHOD_NAME__UID, NULL, &uid);
-	if (rc != AE_OK) {
+	rc = cxl_get_chbs(hb, &ctx);
+	if (rc == -ENOENT)
 		dev_err(match, "unable to retrieve _UID\n");
-		return -ENODEV;
-	}
+	if (rc)
+		return rc;
 
+	uid = ctx.uid;
 	dev_dbg(match, "UID found: %lld\n", uid);
 
-	ctx = (struct cxl_chbs_context) {
-		.uid = uid,
-	};
-	acpi_table_parse_cedt(ACPI_CEDT_TYPE_CHBS, cxl_get_chbs, &ctx);
-
 	if (!ctx.base) {
 		dev_warn(match, "No CHBS found for Host Bridge (UID %lld)\n",
 			 uid);
@@ -405,12 +417,17 @@ static int add_host_bridge_dport(struct device *match, void *arg)
 	pci_root = acpi_pci_find_root(hb->handle);
 	bridge = pci_root->bus->bridge;
 
+	/*
+	 * In RCH mode, bind the component regs base to the dport. In
+	 * VH mode it will be bound to the CXL host bridge's port
+	 * object later in add_host_bridge_uport().
+	 */
 	if (ctx.cxl_version == ACPI_CEDT_CHBS_VERSION_CXL11) {
 		dev_dbg(match, "RCRB found for UID %lld: %pa\n", uid, &ctx.base);
 		dport = devm_cxl_add_rch_dport(root_port, bridge, uid, ctx.base);
 	} else {
-		dev_dbg(match, "CHBCR found for UID %lld: %pa\n", uid, &ctx.base);
-		dport = devm_cxl_add_dport(root_port, bridge, uid, ctx.base);
+		dport = devm_cxl_add_dport(root_port, bridge, uid,
+					   CXL_RESOURCE_NONE);
 	}
 
 	if (IS_ERR(dport))
@@ -432,6 +449,8 @@ static int add_host_bridge_uport(struct device *match, void *arg)
 	struct cxl_dport *dport;
 	struct cxl_port *port;
 	struct device *bridge;
+	struct cxl_chbs_context ctx;
+	resource_size_t component_reg_phys;
 	int rc;
 
 	if (!hb)
@@ -450,12 +469,28 @@ static int add_host_bridge_uport(struct device *match, void *arg)
 		return 0;
 	}
 
+	rc = cxl_get_chbs(hb, &ctx);
+	if (rc)
+		return rc;
+
+	if (ctx.cxl_version == ACPI_CEDT_CHBS_VERSION_CXL11)
+		/* RCH mode, should never happen */
+		return 0;
+
+	if (ctx.base)
+		component_reg_phys = ctx.base;
+	else
+		component_reg_phys = CXL_RESOURCE_NONE;
+
+	if (component_reg_phys != CXL_RESOURCE_NONE)
+		dev_dbg(match, "CHBCR found for UID %lld: %pa\n",
+			ctx.uid, &component_reg_phys);
+
 	rc = devm_cxl_register_pci_bus(host, bridge, pci_root->bus);
 	if (rc)
 		return rc;
 
-	port = devm_cxl_add_port(host, bridge, dport->component_reg_phys,
-				 dport);
+	port = devm_cxl_add_port(host, bridge, component_reg_phys, dport);
 	if (IS_ERR(port))
 		return PTR_ERR(port);
 
-- 
2.34.1

