Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DEA3744513
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jul 2023 01:17:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231912AbjF3XRa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 19:17:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232281AbjF3XRX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 19:17:23 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77ED5449B;
        Fri, 30 Jun 2023 16:17:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jA2xO/1VvQLM1aoMI0ytOfSQB04aQOjcz1cEWnFexC+j03dnCVolkFIhnFqeuubAavjM/zCP1XwEtL+TXKRwjaJji1cTPDEM8HsiqjZ29hdeXe2/bHsTxUi39aWt+sfatPBw4kIh+ouu7E092JNpzmYlkAhF4AuF99EylfBli+D+RQEN0AZWuWcRI/bHVQp5FWPTJy0HttcGwlHKDreUEti65Hh285K0r6aQfT5CvT4J92hsEeOVrbiZWFpncc/F3t80MfzQ5QMG2nSNZ0WhjYQWf2udjfwBcB8Del3kXQP/PK7RzK5wQnvHYggR/N92zuT612IumTnpCmuGOhvsfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sxhtXHrW9Xt2hF+8oum5oO76GsMV8YN8p84NXdCb7zg=;
 b=lvMy66T4rC9ZK2P6U6e4hekML3UlgU4cpAxNG/AHM6hV9qHfwBJAIP2hBqVzLmejKEXkghKbIAA0e+wCSbxK+08ksPgMcqrGG/FzbGbju1Xs7TxHbVHAyACo9yoZF+uN35o0vbkKUd1iHeOfsL2n5CwDLj4jiitK6gGaeZfsmxQj9ekbQV/dpukdBhVqseDnbOskIeQrENc/njgyPp9UqnqykpYzxBbt+8ftD0RAwses2hYs5cV6ik2gBYN1z/Bw/rmH3GMi6Wow0Q1xvg3IzvJGOrH0iIyQRVgMPihmEqmwvdfmdCjvgcAYX21EV1JvZFQo0OVIf8n9jb4L3wrnaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sxhtXHrW9Xt2hF+8oum5oO76GsMV8YN8p84NXdCb7zg=;
 b=YKbnDwjjjC+ofD5HmHfvBXn5bTEp1nxcXT2HJHxUUEKwiWaSi34FdHuR5gNuTF5vqiWchGZ9pYcG9/7wiimW7kJqBcHDjZIcLf1r0+9HOKmiasuHDKNVx90oURo+OlgLwOVVWnpk3q6wFyOsn/vTT9DcnCyRwfytHZ6BFTKBcDE=
Received: from DM6PR02CA0143.namprd02.prod.outlook.com (2603:10b6:5:332::10)
 by MW4PR12MB7013.namprd12.prod.outlook.com (2603:10b6:303:218::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.19; Fri, 30 Jun
 2023 23:17:12 +0000
Received: from DM6NAM11FT042.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:332:cafe::98) by DM6PR02CA0143.outlook.office365.com
 (2603:10b6:5:332::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.22 via Frontend
 Transport; Fri, 30 Jun 2023 23:17:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT042.mail.protection.outlook.com (10.13.173.165) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.49 via Frontend Transport; Fri, 30 Jun 2023 23:17:12 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 30 Jun
 2023 18:17:11 -0500
From:   Terry Bowman <terry.bowman@amd.com>
To:     <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <bwidawsk@kernel.org>,
        <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
        <Jonathan.Cameron@huawei.com>, <linux-cxl@vger.kernel.org>
CC:     <terry.bowman@amd.com>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: [PATCH v8 02/14] cxl/pci: Store the endpoint's Component Register mappings in struct cxl_dev_state
Date:   Fri, 30 Jun 2023 18:16:23 -0500
Message-ID: <20230630231635.3132638-3-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230630231635.3132638-1-terry.bowman@amd.com>
References: <20230630231635.3132638-1-terry.bowman@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT042:EE_|MW4PR12MB7013:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c367885-104f-4aec-91a8-08db79c02292
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7nX8cx3gV/4N6Bqtf+VMe2Xg26jTDgfHv4tm8D+5rxvCwkBXidiwbP5QA7UnU13Xt1cx/Rg7mA70qDZQfJaNDO7mSjp0TWIm/SYXv2jVAsQVh7PUjhTHJmVsbeE8S9mhnCS2oNoqwheGzXcafbbDCVh/fMjjoDdYZX0zBJBUGK0Bne1sN/cWpu+UJiWAIGGKsGkcuSGAxtVj5IecX7yM0gclDepsnj+2A3vvcXgA4ItURQJE3eOGW9Vvlfe741ue6/qtNOJpC3divzG0Iyq8p4HkLnGay9YHGn4s59gu3wIMMrXNOeNP6KUC+LXzYICuXXMxH/cgrYQmtvylHDDTZP81Qut1bvi8kA/YZyPMk2Xa1+j9ICoMtifisSvmVFJkklRjaauS45h6o3JUWaQcrnZnL3osu6sZT6cxVyJvC3R5qZeFK7IZyYxymN0XtCjwPI6jmRUWEuLwTzTx9jrSV0oaJtE+6aOzEGw84h4ZWLb/OTxAMnIYdi6jh8qJU2npZmH2pZ3hXblSJQnIdDPH3gQk2OKDHk/EiNEiqDQeLNVUc3zLtjHDot6hJVUJ2mdosbgobegK54gutBi6yTESel53HdZlAIT6QGWMJrp7ugqP5nNbgNdA5XJhhVrwyyaX2LgwMoVegw3/l/lmpSu+wOAweDDi6cmLZWu23lQIiP0kIv1QiU5AgsidQBVflcor/lkXM2HXQuDiJNyNZWTV26ZVUTnlB78ak6kYGxYq4AaY2X0dCAfPr+u55GBm+2YO84T11DyTtcqpcagOWQ8NWA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(136003)(39860400002)(376002)(451199021)(36840700001)(46966006)(40470700004)(7696005)(478600001)(40460700003)(6666004)(47076005)(36860700001)(26005)(16526019)(186003)(40480700001)(1076003)(336012)(426003)(83380400001)(36756003)(2616005)(82740400003)(82310400005)(86362001)(81166007)(356005)(4326008)(70586007)(70206006)(2906002)(316002)(7416002)(5660300002)(44832011)(8936002)(8676002)(41300700001)(54906003)(110136005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2023 23:17:12.2988
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c367885-104f-4aec-91a8-08db79c02292
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT042.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7013
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

Keep the Component Register base address @component_reg_phys a bit to
not break functionality. It will be removed after the transition in a
later patch.

Signed-off-by: Robert Richter <rrichter@amd.com>
Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/cxlmem.h | 2 ++
 drivers/cxl/pci.c    | 9 +++++----
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 79e99c873ca2..607ee34b0ce7 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -382,6 +382,7 @@ enum cxl_devtype {
  *
  * @dev: The device associated with this CXL state
  * @cxlmd: The device representing the CXL.mem capabilities of @dev
+ * @comp_map: component register capability mappings
  * @regs: Parsed register blocks
  * @cxl_dvsec: Offset to the PCIe device DVSEC
  * @rcd: operating in RCD mode (CXL 3.0 9.11.8 CXL Devices Attached to an RCH)
@@ -396,6 +397,7 @@ enum cxl_devtype {
 struct cxl_dev_state {
 	struct device *dev;
 	struct cxl_memdev *cxlmd;
+	struct cxl_register_map comp_map;
 	struct cxl_regs regs;
 	int cxl_dvsec;
 	bool rcd;
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 48f88d96029d..054cfa2f6a2d 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -836,15 +836,16 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
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

