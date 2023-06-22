Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9D777395F5
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 05:53:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbjFVDxx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 23:53:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230113AbjFVDxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 23:53:36 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2075.outbound.protection.outlook.com [40.107.94.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD56A1FF2;
        Wed, 21 Jun 2023 20:53:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BpcgpMBY3gLOb5SWkYPzPgxsqIBNUSwtxRo5uUyicoVODMWDBuS+/fNGDPBDm5KqnLMb3kcDFt+PEh02sd0/BGw/IIk44eron3vi6dcULtqfYNCVJ9aVWbelWzqd3uCWAEDAjY4v3DmF3M5KXCJElyHkjEO5gJkQfBiFcw7vfNoZGfh082ZPZnNfheBcejVirheCYad3PYAqD7wRAlCJdq9STEmpGcFyM0yK5mTppxdOl0ke7ubZbcMm52TLYTNKha0AV2NeA2+1yVRe3ttRdiIIz5xeMw8hlUC6++fpzGb/iliXjWp+HnTQF319W700oH8L4mirOCnq0MUnBYu4qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G3XQwXAHJy7GzCPDUQNM1GXGisSr3ZK/tvX5eovg+7Q=;
 b=FVwsRiSiBmV4BcwOZ8agJ7+26uRSWEwyAWixs/UXZWoDkZQukak0bOTfkQY2BeT6WQ5dlNoVyDaOLkNWyE8l88PDYi2zJQexFkXDlHzuc9vZCimKHVRk2LkcteKHBXq+WllDMciJ9AOLmFcvTz80YKf0CFlJOuO8ZHo6QvYMF+YaExCWV/7eMJvPlIiz/RRAVW53JqLOhPvmlj2OGADeTcaGWOWqVYZkgwe8QC+kTE1BD7NtBQpCfWMuJjam1jvo9z089WrAQH+0kRr6CM8OxhXyC3Fy+cIi3awPFILRdYbksUL7p58IPdGFRbEKa7Mc5VtVhYWFNz2fET0ifIyDxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G3XQwXAHJy7GzCPDUQNM1GXGisSr3ZK/tvX5eovg+7Q=;
 b=kNxjrcsp0r7+p3tKDOsUNwz7H75Cg+HC5Wjqkgbzv/eaWU9bypQg14bb2CGLo6rHiZTvCbJLuX8EXh2TeKvv9+YP2KZxN5D3r3uECNRpVxjpC6Jsz/kQIpnrQPSOTmdFGBGE3LOyCht4cxos3yJAQaL9wBQRuW9sE8woYURr46c=
Received: from MW4PR04CA0322.namprd04.prod.outlook.com (2603:10b6:303:82::27)
 by LV8PR12MB9232.namprd12.prod.outlook.com (2603:10b6:408:182::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Thu, 22 Jun
 2023 03:53:16 +0000
Received: from CO1PEPF000042AB.namprd03.prod.outlook.com
 (2603:10b6:303:82:cafe::6e) by MW4PR04CA0322.outlook.office365.com
 (2603:10b6:303:82::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24 via Frontend
 Transport; Thu, 22 Jun 2023 03:53:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AB.mail.protection.outlook.com (10.167.243.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.17 via Frontend Transport; Thu, 22 Jun 2023 03:53:15 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 21 Jun
 2023 22:53:14 -0500
From:   Terry Bowman <terry.bowman@amd.com>
To:     <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <bwidawsk@kernel.org>,
        <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
        <Jonathan.Cameron@huawei.com>, <linux-cxl@vger.kernel.org>
CC:     <terry.bowman@amd.com>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: [PATCH v6 05/27] cxl: Rename member @dport of struct cxl_dport to @dport_dev
Date:   Wed, 21 Jun 2023 22:51:04 -0500
Message-ID: <20230622035126.4130151-6-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AB:EE_|LV8PR12MB9232:EE_
X-MS-Office365-Filtering-Correlation-Id: 7cb0789f-579c-4968-0238-08db72d43593
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1sC/72IVoWGYMdpYAEdQ/CiBpZxh289da8RYfQbtlqY9YaJXit43oX+8l52OZBLe12MhKSOsmXj0HyGJ8QqzttnoTiCjYeMAj7xrAycPDjJfHtif564aunXsN4KWIf9CXW93RLy59w/OirNPJREKIZIpxpN+9dw+Kt/eVwGIOUCYB46UYJjnGXwmhO7xzVAkQZzSIak4y1SKFm6vdazqCNdJXAa8skpznqzmSjT7q99XTEy16IkHpXrJAJwletKjaq3Svx5w/C7CW/JjwjQd9oFCJKiasSVkUEiifoGDcafN/Azf+v1H4URG7TJ4EPBGWTIiuNe0ffLzRPzr8yvG2k/id/jPq7/g5HdPBOurtHlIhBdJ+ZV90yE4TRoE3hj8vcx6+7bKdvxULzEvUSGB4xkAWXn+33kDdfD4PMF9CoiwxHQN5isk0bPkMMInJM0/KjF9IRSFrOwvG0BAArglcSlowZ2Ien/QyfpUksFFtxr/eAvKUOWvm2K4JYMtvSX4ny/AQ9U37zjGDL6l9ERaUJ/fg+6WtNNPrTvjlxJSiXGD/+ky68m21vx9M+mNOTxC31LGU9cgJ1NdfI6PST/JHJiPqhh3CvFZdWTfDmzWPX5L3TuWmx7f1l2WREZwrHRdRthqzItTE++GU8Cd8hx2dbpHfAFrTDTqh8/zHJQlMPYvfv0Hl7IRhdX+dtfBy9lUw0XYjU+Nt+cxIIsthpOuPaOrgISY8iyFTzUnM+cN6oW4E6LJwnGhZ2IC8as3txc/lvHJ794JLCcOLeQ133vizw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(396003)(39860400002)(346002)(451199021)(46966006)(36840700001)(40470700004)(82310400005)(7696005)(4326008)(70586007)(70206006)(478600001)(36756003)(6666004)(316002)(54906003)(40460700003)(110136005)(86362001)(83380400001)(426003)(26005)(1076003)(47076005)(336012)(16526019)(186003)(2616005)(82740400003)(356005)(5660300002)(81166007)(2906002)(41300700001)(8676002)(8936002)(7416002)(36860700001)(44832011)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 03:53:15.8954
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cb0789f-579c-4968-0238-08db72d43593
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9232
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

