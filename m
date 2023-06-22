Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDE3C73A9AB
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 22:56:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231215AbjFVU4k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 16:56:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231287AbjFVU4h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 16:56:37 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2061.outbound.protection.outlook.com [40.107.237.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F23212134;
        Thu, 22 Jun 2023 13:56:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U53KXgq++gbBFrea70JNJfiG4cyg5MO73Ax93mPBc4105rGCZeY5Q8U9g4tHy5nPvc2iu0SkvaMcL3oeS5ysLRgTMK/y1m71/9VbLZCRKRZOm7z5rMdIFL1lxsqskgbWjmemFx86U8MSJstqqDbPdF3crKAwkq34vU4gNA1OwJb3aEgFkIa6CUwvP5BHsqXqYDBtzU/FJ9Px/VM/FHGaxKbr3X+OSKWkDEpuYU73dfKoD6kiK2JZPmoeaWQJI5r3x5X6h71Dj0QrP2hkq5GBkZkSX1SI5bUXsPqYqe9MtBXGThbM92myxwQ0fr3WKSsAPMkqnoqkSthwQAlSD/WVdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F3S8vj1xA/ndAIz269AobwF3vhvAecegLBJ/xKqZdRU=;
 b=TKnFgaawunoqdyRfyP289qpOf2JgCnVO4f+dvSvEcsjRcnwUlG4mqVHGc67ugD22Zz74fsogtHGBKK85job5JwhkeSlzTRKmbYRzC0Ej3Wz2V4FeE9aIryyQdM2ECUmT32IdgMhdmrYBD/1OxqKVDYKOE9GA+rTF0xuc03oaEUaE/9vtbEOgB0QMr8KRLEToCC6XqzIaQjU6atxrgPZx09wjxFypsNvcNuq6GVxp/velw/gPaABJTTufadE0KPDUslGg/zo/lTRwOBYdyZQN6c6o7aVYd6xLBE1sv+9UbI8dXAT3rr66jG21rIsVA51zoGPabDFa3pgWINd0x02lnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F3S8vj1xA/ndAIz269AobwF3vhvAecegLBJ/xKqZdRU=;
 b=UH5jAGmhkNEfwHPkhDW/56DjOV0z2FH4dMaorpHerGeUFFP01BlUEVusBNua+SP0CdZgs1ag1+sADg5CQSL1/HUTa4cUyhykfJ6xLeTsQ13SJMoEeLXMvl1lPYChQ3KJM4hpPhZALT8ZwwEsjaQtCNCEcNA9eX9oNkv/2kLHnJA=
Received: from MW4PR03CA0232.namprd03.prod.outlook.com (2603:10b6:303:b9::27)
 by IA0PR12MB7773.namprd12.prod.outlook.com (2603:10b6:208:431::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Thu, 22 Jun
 2023 20:56:14 +0000
Received: from MWH0EPF000989E5.namprd02.prod.outlook.com
 (2603:10b6:303:b9:cafe::65) by MW4PR03CA0232.outlook.office365.com
 (2603:10b6:303:b9::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24 via Frontend
 Transport; Thu, 22 Jun 2023 20:56:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E5.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.17 via Frontend Transport; Thu, 22 Jun 2023 20:56:14 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 22 Jun
 2023 15:56:13 -0500
From:   Terry Bowman <terry.bowman@amd.com>
To:     <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <bwidawsk@kernel.org>,
        <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
        <Jonathan.Cameron@huawei.com>, <linux-cxl@vger.kernel.org>
CC:     <terry.bowman@amd.com>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: [PATCH v7 04/27] cxl: Rename member @dport of struct cxl_dport to @dport_dev
Date:   Thu, 22 Jun 2023 15:55:00 -0500
Message-ID: <20230622205523.85375-5-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230622205523.85375-1-terry.bowman@amd.com>
References: <20230622205523.85375-1-terry.bowman@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E5:EE_|IA0PR12MB7773:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ddddaa4-6c3b-4c8b-0d9d-08db73631df4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jE4RIEPiJKlXp8pYQ+jPg2CDBGN4wn7Xf8CGPbsxBZ3j/eCm9tVgbfhimyoRvqssVm+xf81a6xb7LUbcT5YT4ADHbNEOcsvB/2lKwHhgFdwUiHpAJ3tUZMlLa7mGZUH7ZGH+CUKcnBoTiBth6Au/RvusRUtO6fVCkxNPtsmU4ChfAb0dOB94wB0SbuJicvUsxOnkNY7a+UylGnWANz6VC+Bl6X6kmjWFRxPx8AD3IWcRnFWxDNPVtzEWr77mQDOEj/WTe3p7ZomsjHZ+Ln4RMpptMHzjiCAVwsdk2p2SJlBohXbiO21ZhqFCwktoi5QWSs+hzq5K71OyYsfMvYNyT3tZ5dC7UQtmESN9QdUNYFZEiThqCVnI6SbcKF7SKX15EJjiVHoqUQ29y56uaUQR9eW9cmy9IZdzfBzP87kEpDk09C/TL0L/pGNQwDCRamT73JIo8+KCmjTj5hinx9/ApxEt77f+WFLpNVsjv3GSvhVbDd9m6vnjVD3hgTBUoDfNIeJEm82uaKjKQ+mRq4Ft2/POMg+kOCxsbur02k0Cfv9rUhseCW/RRoIA4jvGIfaBNvC2GdWhnDiySF8UotjkfQQHPKR3Aykmpt7pMQnMG9hLyQcRq7rE0gixMRAlKc88LihlHTr5AoxyMw2wdQoqFn/EsstL/j6hUqgkSMgERXmf/l5dTIolkJqsCACPCebNQ6M2VRYz8+k9aOo+pRPhCebkkk0+e3Zw+U8odwADCYISKV/YFFMO5b74BmBuuK0KX5Oe5Ileju+6JRX0DAQs8w==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(396003)(39860400002)(136003)(451199021)(36840700001)(46966006)(40470700004)(2906002)(7416002)(44832011)(5660300002)(40480700001)(82310400005)(356005)(81166007)(82740400003)(86362001)(36756003)(6666004)(478600001)(54906003)(110136005)(7696005)(41300700001)(316002)(8676002)(8936002)(70586007)(4326008)(70206006)(47076005)(36860700001)(186003)(16526019)(26005)(1076003)(426003)(83380400001)(336012)(2616005)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 20:56:14.3140
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ddddaa4-6c3b-4c8b-0d9d-08db73631df4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7773
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Robert Richter <rrichter@amd.com>

Reading code like dport->dport does not immediately suggest that this
points to the corresponding device structure of the dport. Rename
struct member @dport to @dport_dev.

While at it, also rename @new argument of add_dport() to @dport. This
better describes the variable as a dport (e.g. new->dport becomes to
dport->dport_dev).

Co-developed-by: Terry Bowman <terry.bowman@amd.com>
Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Signed-off-by: Robert Richter <rrichter@amd.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/cxl/core/port.c   | 20 ++++++++++----------
 drivers/cxl/core/region.c |  4 ++--
 drivers/cxl/cxl.h         |  4 ++--
 3 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 76888c75dae4..7d3079f5b7b5 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -605,7 +605,7 @@ static int devm_cxl_link_parent_dport(struct device *host,
 	if (!parent_dport)
 		return 0;
 
-	rc = sysfs_create_link(&port->dev.kobj, &parent_dport->dport->kobj,
+	rc = sysfs_create_link(&port->dev.kobj, &parent_dport->dport_dev->kobj,
 			       "parent_dport");
 	if (rc)
 		return rc;
@@ -658,7 +658,7 @@ static struct cxl_port *cxl_port_alloc(struct device *uport,
 		if (iter->host_bridge)
 			port->host_bridge = iter->host_bridge;
 		else if (parent_dport->rch)
-			port->host_bridge = parent_dport->dport;
+			port->host_bridge = parent_dport->dport_dev;
 		else
 			port->host_bridge = iter->uport;
 		dev_dbg(uport, "host-bridge: %s\n", dev_name(port->host_bridge));
@@ -847,22 +847,22 @@ static struct cxl_dport *find_dport(struct cxl_port *port, int id)
 	return NULL;
 }
 
-static int add_dport(struct cxl_port *port, struct cxl_dport *new)
+static int add_dport(struct cxl_port *port, struct cxl_dport *dport)
 {
 	struct cxl_dport *dup;
 	int rc;
 
 	device_lock_assert(&port->dev);
-	dup = find_dport(port, new->port_id);
+	dup = find_dport(port, dport->port_id);
 	if (dup) {
 		dev_err(&port->dev,
 			"unable to add dport%d-%s non-unique port id (%s)\n",
-			new->port_id, dev_name(new->dport),
-			dev_name(dup->dport));
+			dport->port_id, dev_name(dport->dport_dev),
+			dev_name(dup->dport_dev));
 		return -EBUSY;
 	}
 
-	rc = xa_insert(&port->dports, (unsigned long)new->dport, new,
+	rc = xa_insert(&port->dports, (unsigned long)dport->dport_dev, dport,
 		       GFP_KERNEL);
 	if (rc)
 		return rc;
@@ -895,8 +895,8 @@ static void cxl_dport_remove(void *data)
 	struct cxl_dport *dport = data;
 	struct cxl_port *port = dport->port;
 
-	xa_erase(&port->dports, (unsigned long) dport->dport);
-	put_device(dport->dport);
+	xa_erase(&port->dports, (unsigned long) dport->dport_dev);
+	put_device(dport->dport_dev);
 }
 
 static void cxl_dport_unlink(void *data)
@@ -954,7 +954,7 @@ __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
 		dev_dbg(dport_dev, "Component Registers found for dport: %pa\n",
 			&component_reg_phys);
 
-	dport->dport = dport_dev;
+	dport->dport_dev = dport_dev;
 	dport->port_id = port_id;
 	dport->component_reg_phys = component_reg_phys;
 	dport->port = port;
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index f822de44bee0..13cda989d944 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1162,7 +1162,7 @@ static int cxl_port_setup_targets(struct cxl_port *port,
 			dev_dbg(&cxlr->dev, "%s:%s: %s expected %s at %d\n",
 				dev_name(port->uport), dev_name(&port->dev),
 				dev_name(&cxlsd->cxld.dev),
-				dev_name(ep->dport->dport),
+				dev_name(ep->dport->dport_dev),
 				cxl_rr->nr_targets_set);
 			return -ENXIO;
 		}
@@ -1173,7 +1173,7 @@ static int cxl_port_setup_targets(struct cxl_port *port,
 	cxl_rr->nr_targets_set += inc;
 	dev_dbg(&cxlr->dev, "%s:%s target[%d] = %s for %s:%s @ %d\n",
 		dev_name(port->uport), dev_name(&port->dev),
-		cxl_rr->nr_targets_set - 1, dev_name(ep->dport->dport),
+		cxl_rr->nr_targets_set - 1, dev_name(ep->dport->dport_dev),
 		dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev), pos);
 
 	return 0;
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 7c8674079f1a..7232c2a0e27c 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -589,7 +589,7 @@ struct cxl_rcrb_info {
 
 /**
  * struct cxl_dport - CXL downstream port
- * @dport: PCI bridge or firmware device representing the downstream link
+ * @dport_dev: PCI bridge or firmware device representing the downstream link
  * @port_id: unique hardware identifier for dport in decoder target list
  * @component_reg_phys: downstream port component registers
  * @rcrb: Data about the Root Complex Register Block layout
@@ -597,7 +597,7 @@ struct cxl_rcrb_info {
  * @port: reference to cxl_port that contains this downstream port
  */
 struct cxl_dport {
-	struct device *dport;
+	struct device *dport_dev;
 	int port_id;
 	resource_size_t component_reg_phys;
 	struct cxl_rcrb_info rcrb;
-- 
2.34.1

