Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 380DF602CDB
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 15:24:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230470AbiJRNYx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 09:24:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbiJRNYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 09:24:35 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2051.outbound.protection.outlook.com [40.107.101.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A314140B3;
        Tue, 18 Oct 2022 06:24:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ISpqoUL9RAMcB78m33fW1psXBDsSg7BxtH3ISb21lOgp2tARMrDKbSmZUXXJs4QuKrhlzbpTFTA51yg6JQlMHMbemtQK+X0lBmEKTmiQA52DW5DtmCoRl+qUDRkKnbyIOdWg5v488AQrNQ+jDvw4JIitt0NxCYCrsWkgVHPoOMZVLedICC367oFw31nf4YfsolRkUyKKdUyRG9ALgSBWZ2QqXRb8evw9TH7JiLAWWwVQ2wNZJ0O9cyyNaJ+nYxhZfzLLPmVkEdsFjXrUuygdXXrundJuj9Dg9++iwMs+hesuPj/sVQBZtVvvporj6Hj9OCBvd6gRnezzngTgotm9Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wVjwz2jaYW2t613ACvCnJfgCx2sRIEoo1AFxWYaapRo=;
 b=FczGjqyc8WRRqjz6zrHWa8Por1tRmd9KodVVAW6YaqExYVJVGJbAsVcIVLqhBgCru0GPQ7R4ezOVJ4nv9IjePRQeAFn61u6JeNHjZQqhWaBe+ycMZcvm/+t1Xk964p2NbdhdBtx/W4Zwp8GWCYoltcT+2UO7a2zgAtcikojfolFsKJ1szwDKV76zYYyL5E6OXvt7g9p1c9bE+XWHgaGk8SRWUhoy261vGjsZShGFRFd8gmIE2ENYxU8N1wyegSuJIcYLe7iWHsrwKSn02zvAKRm+as7TMTFJu+wQbRzmnFQm19P/CgAxXWObLuGV4m0jmafkPDB/3325yRjoLWLWUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wVjwz2jaYW2t613ACvCnJfgCx2sRIEoo1AFxWYaapRo=;
 b=zsqzRNZAt3duRSCvCuKuvw83ArjU/ZEJmW3GBaspzx8AUfq8HJjlFzWbEi9PAv6UGBxhn8WOrzLhknA6SIHsc5NMkRz44F9Pap/le4vh5cpddYv8Gr0VN5JueKhjiXnUQsDUsUZ94ZXf8KmJ7gZmVHHpIu3plFgH57EY02nkIT0=
Received: from BN9P220CA0017.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:13e::22)
 by BN9PR12MB5305.namprd12.prod.outlook.com (2603:10b6:408:102::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.30; Tue, 18 Oct
 2022 13:24:23 +0000
Received: from BN8NAM11FT107.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13e:cafe::66) by BN9P220CA0017.outlook.office365.com
 (2603:10b6:408:13e::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.31 via Frontend
 Transport; Tue, 18 Oct 2022 13:24:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT107.mail.protection.outlook.com (10.13.176.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5723.20 via Frontend Transport; Tue, 18 Oct 2022 13:24:23 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 18 Oct
 2022 08:24:20 -0500
From:   Robert Richter <rrichter@amd.com>
To:     Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "Davidlohr Bueso" <dave@stgolabs.net>,
        Robert Richter <rrichter@amd.com>,
        Terry Bowman <terry.bowman@amd.com>
Subject: [PATCH v2 06/12] cxl/acpi: Extract component registers of restricted hosts from RCRB
Date:   Tue, 18 Oct 2022 15:23:34 +0200
Message-ID: <20221018132341.76259-7-rrichter@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221018132341.76259-1-rrichter@amd.com>
References: <20221018132341.76259-1-rrichter@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT107:EE_|BN9PR12MB5305:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d1d5869-1341-4b32-89a5-08dab10c1244
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TLrg3RxoS8c3Iw4iQmKYS7I9jn2YaPpamA1jgugsSVVINx+iyfYheycQKluMYBHkdIr4NuO/jnegWyi8ogbhMlm3MW8ZYbXSXYHtHaO25hM/MwsKCsafbtWamL2Z3Im3hP1Jl3tkIlcXq+wBKfUxwnhaUmKL/YXFTNIg3lbunMCnEsa+0MA+cCVdnmGunjazNJdAY0jOlt5l7GsJXnlRBODsn98LPNlVHCQDIYCImUbbBEzbcpedFMGTKooGEc9nRDBxjoLoJDDJaCAd4sqqRuKBPKDwrsUmMHio9SYdzM3m/Xdtu1+9F8qyg01rZAPM3eqGO2YeLMNUWIKRpMyhyEk6eFKkUnpjRE20iljHIszRVAM/jrGceNveFd4K4Oo5v2CP6d/KMreBYoFiw2MhOmDZRYUzjMMHipy5eSahdswmgofbv7XawWTcksGulSKbtBsCsI0uwb2VXZn762knaIAYWDKn+wCulEec3+2sNW8doojZwgq2hWO9HKP+C3tAPvHt/W1os9ntRYIk23J7z6WIEemtAeVWX/qHkoa+gPn4/WZWZfWNcPBmthMadKC77Kwc9QSogpYVQEJ0kNcSXOhJy+msqoxkc30sUz8ojRAL0RaLn303j0mS8PABd53CkfmY/Onj9QKGH15+3yUf8gEywgqW/JZ/ODGmNpQ8HGb8lIr/xmcOZne0TS1F0t8W/zIoe3BG4GYfSiQSwo2up8ZBOZsM+hQ81h4Nb5GTpfLcYgeG9yQ+7o6WX/NAdxCDDRfzw9RIrcNrMB5512IqC7DYRRXPwfu+F5RxA9tiiEY=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(396003)(39860400002)(346002)(451199015)(36840700001)(46966006)(40470700004)(26005)(41300700001)(40460700003)(186003)(6666004)(1076003)(16526019)(336012)(478600001)(2616005)(82310400005)(36756003)(2906002)(7416002)(5660300002)(4326008)(8936002)(36860700001)(110136005)(54906003)(82740400003)(40480700001)(316002)(426003)(47076005)(8676002)(70586007)(83380400001)(356005)(81166007)(70206006)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2022 13:24:23.0083
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d1d5869-1341-4b32-89a5-08dab10c1244
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT107.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5305
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A downstream port must be connected to a component register block.
For restricted hosts the base address is determined from the RCRB. The
RCRB is provided by the host's CEDT CHBS entry. Rework CEDT parser to
get the RCRB and add code to extract the component register block from
it.

RCRB's BAR[0..1] point to the component block containing CXL subsystem
component registers. MEMBAR extraction follows the PCI base spec here,
esp. 64 bit extraction and memory range alignment (6.0, 7.5.1.2.1).

Note: Right now the component register block is used for HDM decoder
capability only which is optional for RCDs. If unsupported by the RCD,
the HDM init will fail. It is future work to bypass it in this case.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/cxl/acpi.c | 79 ++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 69 insertions(+), 10 deletions(-)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index fb9f72813067..a92d5d7b7a92 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -9,6 +9,8 @@
 #include "cxlpci.h"
 #include "cxl.h"
 
+#define CXL_RCRB_SIZE	SZ_8K
+
 static unsigned long cfmws_to_decoder_flags(int restrictions)
 {
 	unsigned long flags = CXL_DECODER_F_ENABLE;
@@ -229,27 +231,82 @@ static int add_host_bridge_uport(struct device *match, void *arg)
 struct cxl_chbs_context {
 	struct device *dev;
 	unsigned long long uid;
-	resource_size_t chbcr;
+	struct acpi_cedt_chbs chbs;
 };
 
-static int cxl_get_chbcr(union acpi_subtable_headers *header, void *arg,
-			 const unsigned long end)
+static int cxl_get_chbs(union acpi_subtable_headers *header, void *arg,
+			const unsigned long end)
 {
 	struct cxl_chbs_context *ctx = arg;
 	struct acpi_cedt_chbs *chbs;
 
-	if (ctx->chbcr)
+	if (ctx->chbs.base)
 		return 0;
 
 	chbs = (struct acpi_cedt_chbs *) header;
 
 	if (ctx->uid != chbs->uid)
 		return 0;
-	ctx->chbcr = chbs->base;
+	ctx->chbs = *chbs;
 
 	return 0;
 }
 
+static resource_size_t cxl_get_chbcr(struct cxl_chbs_context *ctx)
+{
+	struct acpi_cedt_chbs *chbs = &ctx->chbs;
+	resource_size_t component_reg_phys, rcrb;
+	u32 bar0, bar1;
+	void *addr;
+
+	if (!chbs->base)
+		return CXL_RESOURCE_NONE;
+
+	if (chbs->cxl_version != ACPI_CEDT_CHBS_VERSION_CXL11)
+		return chbs->base;
+
+	/* Extract RCRB */
+
+	if (chbs->length != CXL_RCRB_SIZE)
+		return CXL_RESOURCE_NONE;
+
+	rcrb = chbs->base;
+
+	dev_dbg(ctx->dev, "RCRB found for UID %lld: 0x%08llx\n",
+		ctx->uid, (u64)rcrb);
+
+	/*
+	 * RCRB's BAR[0..1] point to component block containing CXL
+	 * subsystem component registers. MEMBAR extraction follows
+	 * the PCI Base spec here, esp. 64 bit extraction and memory
+	 * ranges alignment (6.0, 7.5.1.2.1).
+	 */
+	addr = ioremap(rcrb, PCI_BASE_ADDRESS_0 + SZ_8);
+	bar0 = readl(addr + PCI_BASE_ADDRESS_0);
+	bar1 = readl(addr + PCI_BASE_ADDRESS_1);
+	iounmap(addr);
+
+	/* sanity check */
+	if (bar0 & (PCI_BASE_ADDRESS_MEM_TYPE_1M | PCI_BASE_ADDRESS_SPACE_IO))
+		return CXL_RESOURCE_NONE;
+
+	component_reg_phys = bar0 & PCI_BASE_ADDRESS_MEM_MASK;
+	if (bar0 & PCI_BASE_ADDRESS_MEM_TYPE_64)
+		component_reg_phys |= ((u64)bar1) << 32;
+
+	if (!component_reg_phys)
+		return CXL_RESOURCE_NONE;
+
+	/*
+	 * Must be 8k aligned (size of combined CXL 1.1 Downstream and
+	 * Upstream Port RCRBs).
+	 */
+	if (component_reg_phys & (CXL_RCRB_SIZE - 1))
+		return CXL_RESOURCE_NONE;
+
+	return component_reg_phys;
+}
+
 static int add_host_bridge_dport(struct device *match, void *arg)
 {
 	acpi_status status;
@@ -259,6 +316,7 @@ static int add_host_bridge_dport(struct device *match, void *arg)
 	struct cxl_port *root_port = arg;
 	struct device *host = root_port->dev.parent;
 	struct acpi_device *bridge = to_cxl_host_bridge(host, match);
+	resource_size_t component_reg_phys;
 
 	if (!bridge)
 		return 0;
@@ -273,19 +331,20 @@ static int add_host_bridge_dport(struct device *match, void *arg)
 	dev_dbg(match, "UID found: %lld\n", uid);
 
 	ctx = (struct cxl_chbs_context) {
-		.dev = host,
+		.dev = match,
 		.uid = uid,
 	};
-	acpi_table_parse_cedt(ACPI_CEDT_TYPE_CHBS, cxl_get_chbcr, &ctx);
+	acpi_table_parse_cedt(ACPI_CEDT_TYPE_CHBS, cxl_get_chbs, &ctx);
 
-	if (ctx.chbcr == 0) {
+	component_reg_phys = cxl_get_chbcr(&ctx);
+	if (component_reg_phys == CXL_RESOURCE_NONE) {
 		dev_warn(match, "No CHBS found for Host Bridge (UID %lld)\n", uid);
 		return 0;
 	}
 
-	dev_dbg(match, "CHBCR found: 0x%08llx\n", (u64)ctx.chbcr);
+	dev_dbg(match, "CHBCR found: 0x%08llx\n", (u64)component_reg_phys);
 
-	dport = devm_cxl_add_dport(root_port, match, uid, ctx.chbcr);
+	dport = devm_cxl_add_dport(root_port, match, uid, component_reg_phys);
 	if (IS_ERR(dport))
 		return PTR_ERR(dport);
 
-- 
2.30.2

