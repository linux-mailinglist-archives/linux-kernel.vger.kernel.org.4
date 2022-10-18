Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3682602CDA
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 15:24:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230429AbiJRNYs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 09:24:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230420AbiJRNYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 09:24:34 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2087.outbound.protection.outlook.com [40.107.237.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF31BBF74;
        Tue, 18 Oct 2022 06:24:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XT/kY6E5q/unoJElgXcUx3CGdZE6vB95W79++5nRCFJeq73HgOa08VySFcYzj5ii2zb/T+/LtqchNQIpNokW4KAkvjzs9OLpKXR7hSeO8MtRhwmVs0cGMkjAdbeVfHvAgizviXk2y7krCUEMbJbMtUnac30rvOcVkEwE7+zSZ9SUvWgTZaeZ0FSbMi2fv0ZAB3VkIAeOPZXLoRbUhP7iBX5NqCIwoQ1X6ZukB78AW9EfoJ41mcfkzhxpfGHbQjqWjKLN01tteeBMVinXW1ltjQHlMxSgURdj32z4wdPRv7tnN1S5qiCYzG3MV1S0I6MphHj69WXNJB/FZkMFMJaEKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WHNFlrO4qrQBm018055H1tLywEzE/PzkskChRQ3S8nk=;
 b=iUKMzpMNjgjj44CX6YRPqoR4AYZ71qrrcxEM88QakZEh/qyVSWof4x1eaPaSDqRasMSex1TJl5Oj5K5Ec2hvT6Q5hDmzwYXF3DGSaKHXlKNpOiERJ/erBVEH9hrAgC2NzYGkgJLOJkpmaTu8F1tWrfJswTl3eLfltsfNC3q3mM6q/O5NPyIiyrZBt9WXoYik8JaCoy9oNZvHiIuNcLEcuOUMH+wPDAF2pYk6QdqCNoiYDQw2z1Ta2SP8ceA8+OV15NQnOMlFVBikq5HhGZ1wk74F533lrE3GPsWQGZFZHgFfiu11bto594saHOO9wAhuLMvEFFGB/Um8Ls4IZAa6pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WHNFlrO4qrQBm018055H1tLywEzE/PzkskChRQ3S8nk=;
 b=sO1XXoavW+7LMQM/p7ksixE9AeKEi8Iz8/FPkL9ENw+vn8TKBkWwlMLT6cidD5Dr1PmUnbq9I3cRjlEiRcp6IetspdjviOL6UblPRMGfGcfJmnmDRzI9X3iA1ZB7PAvVyc/zD1p0K1nGVTPDnVFB1H2F2q9TMraqHcTmZw7zxRE=
Received: from BN7PR02CA0005.namprd02.prod.outlook.com (2603:10b6:408:20::18)
 by LV2PR12MB5896.namprd12.prod.outlook.com (2603:10b6:408:172::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Tue, 18 Oct
 2022 13:24:20 +0000
Received: from BN8NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:20:cafe::95) by BN7PR02CA0005.outlook.office365.com
 (2603:10b6:408:20::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.33 via Frontend
 Transport; Tue, 18 Oct 2022 13:24:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT050.mail.protection.outlook.com (10.13.177.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5723.20 via Frontend Transport; Tue, 18 Oct 2022 13:24:19 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 18 Oct
 2022 08:24:17 -0500
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
        Robert Richter <rrichter@amd.com>
Subject: [PATCH v2 05/12] cxl/acpi: Improve debug messages in cxl_acpi_probe()
Date:   Tue, 18 Oct 2022 15:23:33 +0200
Message-ID: <20221018132341.76259-6-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT050:EE_|LV2PR12MB5896:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e1d0c91-bca4-4b02-4d2c-08dab10c1076
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XhWQCfsP4w/GCtNoFXqXkXguiAV1vVxLeNBh9bALY+XLZa+pg3Udd8m8wWPi+8rg+dqVxHNvLkcx5pCTXHCSKwQOgSJrdJMMyVDMUqN2pFjnud8vdMz/h8zFrpYlO83ZHf8YKOA+dYke6QRf7yCFz6bIkePQjOoBG9HsMgPbszr8RucLD3cbf1aYTPiv0sC9qBKVXTUJam0tGRCEDehIihtNMqnDBA09W8r1Nk2UoAMXzeGlMgtsMTwKk5oXTfco7T8tkIDC18iCQzfLWcYwlFINjlsQBrcGnkcJ8gmAqGz5d12SummXWXYDfyS5GsbwsXDDbguApf6yUlrJ/LeuACNNvGLhmDSMMWKymVUOpkapS99a0CjOrePWbtsvDBsl0VCqyPnw+xnQFLuFQwZKko7zH1NrdlEeQFLNFt4bAf+6hU7QygoNqTguT0bxKx/YnzdImkla2BFnPNhZv5XXimqwNCkYqdSQ71W2tp962RdCQ0w/Mj4caISR995oNISDGIdZb+ssPPL+FWsRWhgxH1PTUhfqCVputOBV7ckkZKSHvv1io8kPpY/r3UNiXARcKk5wuQOiF7+Z7xugbmNw9NTREz7/C/FCXZPeXy6jlac5e/rF7w4brfM8r0oN+S79zC/el4URRPeLfjtYzhCJ4NOhayIS31Ln1X/GUq5pF1FTyXfpuh5PW1TFtY77iTn0xU5AGlYcYgIE507AERkCVwBPXFrM9PgDdCY3m+oD0O63MD1cl/En8Foy9xhCQ08lSyOwXxtcBmu+llRpjS4huMriDEBZcb6qwAGvm/2jbJDtjVUVeTpE3PsdZPIwzN5q
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(376002)(396003)(346002)(451199015)(40470700004)(36840700001)(46966006)(83380400001)(8676002)(36860700001)(316002)(70206006)(6666004)(186003)(16526019)(81166007)(356005)(1076003)(110136005)(54906003)(5660300002)(47076005)(70586007)(426003)(7416002)(40480700001)(8936002)(40460700003)(82740400003)(336012)(36756003)(15650500001)(4326008)(478600001)(2616005)(26005)(82310400005)(41300700001)(2906002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2022 13:24:19.9790
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e1d0c91-bca4-4b02-4d2c-08dab10c1076
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5896
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In cxl_acpi_probe() the iterator bus_for_each_dev() walks through all
CXL hosts. Since all dev_*() debug messages point to the ACPI0017
device which is the CXL root for all hosts, the device information is
pointless as it is always the same device. Change this to use the host
device for this instead.

Also, add additional host specific information such as CXL support,
UID and CHBCR.

This is an example log:

 acpi ACPI0016:00: UID found: 4
 acpi ACPI0016:00: CHBCR found: 0x28090000000
 acpi ACPI0016:00: dport added to root0
 acpi ACPI0016:00: host-bridge: ACPI0016:00
  pci0000:7f: host supports CXL

Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/cxl/acpi.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index 31e104f0210f..fb9f72813067 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -221,6 +221,8 @@ static int add_host_bridge_uport(struct device *match, void *arg)
 	if (IS_ERR(port))
 		return PTR_ERR(port);
 
+	dev_info(pci_root->bus->bridge, "host supports CXL\n");
+
 	return 0;
 }
 
@@ -264,11 +266,12 @@ static int add_host_bridge_dport(struct device *match, void *arg)
 	status = acpi_evaluate_integer(bridge->handle, METHOD_NAME__UID, NULL,
 				       &uid);
 	if (status != AE_OK) {
-		dev_err(host, "unable to retrieve _UID of %s\n",
-			dev_name(match));
+		dev_err(match, "unable to retrieve _UID\n");
 		return -ENODEV;
 	}
 
+	dev_dbg(match, "UID found: %lld\n", uid);
+
 	ctx = (struct cxl_chbs_context) {
 		.dev = host,
 		.uid = uid,
@@ -276,11 +279,12 @@ static int add_host_bridge_dport(struct device *match, void *arg)
 	acpi_table_parse_cedt(ACPI_CEDT_TYPE_CHBS, cxl_get_chbcr, &ctx);
 
 	if (ctx.chbcr == 0) {
-		dev_warn(host, "No CHBS found for Host Bridge: %s\n",
-			 dev_name(match));
+		dev_warn(match, "No CHBS found for Host Bridge (UID %lld)\n", uid);
 		return 0;
 	}
 
+	dev_dbg(match, "CHBCR found: 0x%08llx\n", (u64)ctx.chbcr);
+
 	dport = devm_cxl_add_dport(root_port, match, uid, ctx.chbcr);
 	if (IS_ERR(dport))
 		return PTR_ERR(dport);
-- 
2.30.2

