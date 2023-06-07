Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD271727172
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 00:20:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231997AbjFGWUF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 18:20:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232172AbjFGWTy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 18:19:54 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on20600.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eaa::600])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 175AB212B;
        Wed,  7 Jun 2023 15:19:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mp11AfBjPa5Q6ubAVXcOw3tcGNck9ErJPyxlPB59WRDNKEGhxkRjYEcNU2IQ1/BsYfn8PWOM1IDBfl7Uxzhzzzkr5NsLSgD/MrbTTFmjkct/VpbLwlB/ZTpbBpBl3b11we62nyd6CTRBDkDg6U4Y7KVfWqBT/Ox00jCQJReCI9ZLrPBtoW1x2mG5N9OrP9di/bBICMn35S3eKfzTjL95mSD6r9iTs1xAdi7CBN8XQP1momVu8wV6PeAuvfmM4ZaHHEc5ofC3R06fz44tKiDmZ+z1I+8AVoRZnY6AUnclyphhdoWY+0MimZyvd8eg9+c8kCuyUcH82neewZyErj1ZCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b+Hogx4zOzPpRxUCFcd8fF7YKjNs82+smnuWZ7cgd3k=;
 b=GqTkqifTie4feAAIT8/cg2lTAEPNF/ua7HvUhhXCwhyYgWCejwgDvVQmwDEnjyjkupyf+/Bzo4GuAWuIe6wvX4jxBQ1tMYYl6Q/LeqDr13mYj4192WaOdlrAyYPJ1CB2HBxDARgL+hF4kSCulHRECcIOLb34hgOPTsg5NilQSY8B7G3SPTHnxZMx/wvOJrslBuICNBuNOgQKkHxqYlW4pfkkNgxZVCsFRtiSwDIdipJFZM1LWllUUaHwGbDPKaARWH8//NIeV1Uz2qVxMFJzHfoJK2oh0ZHQrJYbUZXo5uJuKar6jVDVS966xaNjvDBPF4eK2YjCR0bYmSXp4aflBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b+Hogx4zOzPpRxUCFcd8fF7YKjNs82+smnuWZ7cgd3k=;
 b=vhceSB/1fY791PgOtIXO/7TiTaKGW+F6o0IVOkW8YgSVi90fV+CPG/xBX6br8mKwgrfkM6Y4c4oblETYXSzxfcdnueR6q4/L6XBjiOKKFdb/YxYz44NECt196QUIy7mcN4STzD20VF5LoLPv0qm0tIqYh+qGZG5xID7TV/wKyOM=
Received: from SN6PR08CA0010.namprd08.prod.outlook.com (2603:10b6:805:66::23)
 by PH7PR12MB5951.namprd12.prod.outlook.com (2603:10b6:510:1da::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.36; Wed, 7 Jun
 2023 22:18:34 +0000
Received: from SA2PEPF0000150A.namprd04.prod.outlook.com
 (2603:10b6:805:66:cafe::34) by SN6PR08CA0010.outlook.office365.com
 (2603:10b6:805:66::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33 via Frontend
 Transport; Wed, 7 Jun 2023 22:18:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF0000150A.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6477.13 via Frontend Transport; Wed, 7 Jun 2023 22:18:34 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 7 Jun
 2023 17:18:33 -0500
From:   Terry Bowman <terry.bowman@amd.com>
To:     <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <bwidawsk@kernel.org>,
        <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
        <Jonathan.Cameron@huawei.com>, <linux-cxl@vger.kernel.org>
CC:     <terry.bowman@amd.com>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: [PATCH v5 08/26] cxl/acpi: Directly bind the CEDT detected CHBCR to the Host Bridge's port
Date:   Wed, 7 Jun 2023 17:16:33 -0500
Message-ID: <20230607221651.2454764-9-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF0000150A:EE_|PH7PR12MB5951:EE_
X-MS-Office365-Filtering-Correlation-Id: 2205a8b3-b4aa-4ab3-3fd6-08db67a52247
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 80C5wcrOQSJ6dEsj0Aow80eAJoa+wj8k6BQ9b0aqrtVLsgrXWA01EIRZcNRErjJBMcXvPUV5gB6iLp3HbIDb9HmDBsP0h0y4b6FyKn6x8pIIjJL0Btw3zpXo/tQYzMTXpeT+efU6O8tEYGIA4cczcqqJsFfNYWwaRd2Fm23/SR7A60UH4ZEECtiM1qAg+QQxog49/5u1FNVVQ4o9FsxQ5nJu0WJBbzlgO2pBa7lkATsXnYV8H9N59cY1KrDdKuqjP4QjeHBgMP0cDwbUnmGzE3vwHVqAcE6lA9wrd0o7kqwt3hRI2nmTVJ3LpGbkEF1TgbQfIc1sSn0V4wfPnTcBU2P9WjPJNkkK+tqS8On0ghFlg6Zt4KPU0DsIflt4a4voSJMRBGVCCC88wNs5lG4PYOtfLXYHR4pnzMTiqgyPjgET0OvkkwmqoDLFsPTr+nrAey16hjve1QfaCp26Fy0cLx1lsVotdz0rnuffP9U/QnoMg0dCEGfuv8mBJQPKhlXv/1FeGE5f7rAwZhJn/fdM6T6AziHl1ohPENsIXSkkRm+YOgqHtOsZoK7HsHe9fxDy/EJwiYoZtTWXL/2nP1W6EF5IapK18ZAflyGzA6vF5JIC6NbyDSaFRB1/Pqu+h2EuIcfPBZUE17vbel0G91ezMwWIqKG2p9LGMB0jgn2j5DC/tG9HhUe3Aiaz6+liIWUH+c8yLj41eMxKVOqcO3rNxJkiXyzNxJZwxzzUSfn2TJEzMpI9VUI2qdR8IDh8wtzqeElQRa2NOWTQcfFJQy1z8A==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(376002)(39860400002)(136003)(451199021)(40470700004)(46966006)(36840700001)(47076005)(83380400001)(7416002)(82740400003)(336012)(426003)(110136005)(54906003)(40480700001)(44832011)(478600001)(8936002)(8676002)(70586007)(70206006)(316002)(356005)(81166007)(86362001)(40460700003)(5660300002)(4326008)(41300700001)(7696005)(36756003)(2906002)(36860700001)(82310400005)(16526019)(186003)(1076003)(26005)(2616005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 22:18:34.4791
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2205a8b3-b4aa-4ab3-3fd6-08db67a52247
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF0000150A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5951
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
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
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

