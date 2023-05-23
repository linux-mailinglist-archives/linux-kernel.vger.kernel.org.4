Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99A6570E975
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 01:24:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233532AbjEWXX6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 19:23:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233141AbjEWXXz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 19:23:55 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2084.outbound.protection.outlook.com [40.107.223.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05CAB196;
        Tue, 23 May 2023 16:23:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X2osHJ9usoZSz4dVqPGzV64NOfrJ5JTNvioKCCIyed+M2IAuTWCKH9ZsHYHPbFdbxCAY676CAPH20Ih6+wvutT/zEFJT+7W8M7456x9yhusBc7n8SWjnr3snA4eP4YxrIhmZCy7u8MkiQN1/w5QxqxD8lDnnNbntL7qnKSLs8M0YpmIec1xCL+ppYbN7i/Q+SRyX9pqQDn6SZ8yPWAYxUmCHFto/0hbNCSQo749a+fmbGIXNqfwxJSZCasP7rUiIJihow6rTDJK8ssinZ5w2+v19eZwFhuYoHvREf09u6KtqQDnqXX7ERbA/trWvnvpdI/f/4GC2NIFXu1blyGGZ7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cFVlLB0GBlktuCXYWRL/VlNWdh4Luw9BhB+qEW0/XPM=;
 b=T2AuS15QqZFKVTV2Ll+82nJy6y9YyHgesxJ8aYEOWj/rZmH4V84jlbhmcan4yigngguQRDEle6Bhhk8pOv9IBCs2TYRLM8OeCBqOjzBVUifN+sE2SNhSesYpIBsrCj61NxCxfD3sMhmNbIrU3VY9A0H60DA57cNCXXYPak9hlfLos2+FZam/KedGBEzVUHmg7bnaMXFIb6e1hv+8xLXLrZr84iebuvX3zxtQA5ESO2cdIEpYVBN/T9DegUP76OZSJD18mSLkQeMj+z/+PJbVWu/Ws3xG32JCNr5htrPZYRDWmiD7rcqBnx13orJuh3nLJRFL+L52gx56/YJq2WeJ5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cFVlLB0GBlktuCXYWRL/VlNWdh4Luw9BhB+qEW0/XPM=;
 b=MUNW1W7HWThqxYdkjqo9SqlgIjgZCNRlhb+knwQ7KnTGakZs5vRW7Ct1VGqkQkc4d76Yw7YkEWYhNFYv6JnH+8wwu7PcUs9JRCt8pxU/ynNSA0L0CLrBrSTieicA/WXDMQ0WbCIH1tuRTjH2UZ2SHx1ldEJKcU3inaYEd/fTvF8=
Received: from MW4PR03CA0192.namprd03.prod.outlook.com (2603:10b6:303:b8::17)
 by PH0PR12MB8151.namprd12.prod.outlook.com (2603:10b6:510:299::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.19; Tue, 23 May
 2023 23:23:36 +0000
Received: from CO1NAM11FT082.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b8:cafe::ad) by MW4PR03CA0192.outlook.office365.com
 (2603:10b6:303:b8::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.14 via Frontend
 Transport; Tue, 23 May 2023 23:23:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT082.mail.protection.outlook.com (10.13.175.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.29 via Frontend Transport; Tue, 23 May 2023 23:23:35 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 23 May
 2023 18:23:32 -0500
From:   Terry Bowman <terry.bowman@amd.com>
To:     <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <bwidawsk@kernel.org>,
        <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
        <Jonathan.Cameron@huawei.com>, <linux-cxl@vger.kernel.org>
CC:     <terry.bowman@amd.com>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: [PATCH v4 03/23] cxl: Rename member @dport of struct cxl_dport to @dev
Date:   Tue, 23 May 2023 18:21:54 -0500
Message-ID: <20230523232214.55282-4-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1NAM11FT082:EE_|PH0PR12MB8151:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e23b901-285f-4b5f-10e8-08db5be4bb6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KfZ6Tq7h2JelfWPwF7fzgdo/HFzmu617xQhWJAJf9XLWkB77GGfg5p69uGGFD3OcKquLSDXRDttrnKlGvLXhL1a+o8qVUO/ERb84tcT/YQqh9h7Me3zVTaktARuWa967rGG6KJmJjh3xSEoQXhTrKN/uZLc/MJ9csfD+q77Peyh/e5jYQjzKiv8maXPya50zjgK2Hr1P7VtM2d0x0vGu2ZIZ6ti8Guc1/AFZF0nM1mieDWvhGeDsZta2iYqfjBk/ufOoG/qNZNYKdeYqpZUcod+WSwwJgZ1poDfkPbjsXWhULSGxB2dAmO5s7swR27h/0KwcI+G7bQk12aO8VFyKkvESCYDWgn6mTPrlIeLI8y9QXNtw0pZVYTZT3z7UYb0H5LiQpjA10T55xyl+bDvPqd+F9uEgKqPAYc/eGcChUOoibHoqbBTPyTatWxpibRJl5FnVLYVWIbEIualN+NMbzOVaDPQWS1VFXzRS6Uok8hVvjUJbFbavCVkoCKmol30jApSZ3J9TMdhOd3tib0ggWqiggNoVu7TFU/jYsCcnDXRB5BbVQ1X9gPGCj3+p5g8ElxBeqaS7r+3zImL5t4ApJnrfrAcLuXr7ILRbMmco01RxZC6ebuRlRvxeu4sJYyGSGfzwGbpPdiur67QLdjK89k77e03KE6ZnLOzepxJ6G0cpwz9bSzvB6txeVT22VAhkjfCnTosy4Pz/+kjAtkENf8UzHMchLoXL6Zi7ehn9sUN3Ri86Tg7dvGLB5DsJptwJH5acaN+G3GgRqyK4G8UHpQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(396003)(346002)(376002)(451199021)(36840700001)(46966006)(40470700004)(2906002)(54906003)(47076005)(82310400005)(36860700001)(7416002)(5660300002)(8936002)(8676002)(44832011)(336012)(40460700003)(41300700001)(40480700001)(70586007)(110136005)(70206006)(478600001)(316002)(4326008)(7696005)(6666004)(36756003)(26005)(1076003)(81166007)(86362001)(2616005)(83380400001)(186003)(16526019)(426003)(82740400003)(356005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2023 23:23:35.6612
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e23b901-285f-4b5f-10e8-08db5be4bb6a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT082.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8151
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

Reading code like dport->dport does not immediately suggest that this
points to the corresponding device structure of the dport. Rename
struct member @dport to @dev.

While at it, also rename @new argument of add_dport() to @dport. This
better describes the variable as a dport (e.g. new->dport becomes to
dport->dev).

Signed-off-by: Robert Richter <rrichter@amd.com>
Signed-off-by: Terry Bowman <terry.bowman@amd.com>
---
 drivers/cxl/core/port.c   | 20 ++++++++++----------
 drivers/cxl/core/region.c |  4 ++--
 drivers/cxl/cxl.h         |  4 ++--
 3 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 618865ca6a9f..66f567480238 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -605,7 +605,7 @@ static int devm_cxl_link_parent_dport(struct device *host,
 	if (!parent_dport)
 		return 0;
 
-	rc = sysfs_create_link(&port->dev.kobj, &parent_dport->dport->kobj,
+	rc = sysfs_create_link(&port->dev.kobj, &parent_dport->dev->kobj,
 			       "parent_dport");
 	if (rc)
 		return rc;
@@ -658,7 +658,7 @@ static struct cxl_port *cxl_port_alloc(struct device *uport,
 		if (iter->host_bridge)
 			port->host_bridge = iter->host_bridge;
 		else if (parent_dport->rch)
-			port->host_bridge = parent_dport->dport;
+			port->host_bridge = parent_dport->dev;
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
+			dport->port_id, dev_name(dport->dev),
+			dev_name(dup->dev));
 		return -EBUSY;
 	}
 
-	rc = xa_insert(&port->dports, (unsigned long)new->dport, new,
+	rc = xa_insert(&port->dports, (unsigned long)dport->dev, dport,
 		       GFP_KERNEL);
 	if (rc)
 		return rc;
@@ -895,8 +895,8 @@ static void cxl_dport_remove(void *data)
 	struct cxl_dport *dport = data;
 	struct cxl_port *port = dport->port;
 
-	xa_erase(&port->dports, (unsigned long) dport->dport);
-	put_device(dport->dport);
+	xa_erase(&port->dports, (unsigned long) dport->dev);
+	put_device(dport->dev);
 }
 
 static void cxl_dport_unlink(void *data)
@@ -954,7 +954,7 @@ __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
 		dev_dbg(dport_dev, "Component Registers found for dport: %pa\n",
 			&component_reg_phys);
 
-	dport->dport = dport_dev;
+	dport->dev = dport_dev;
 	dport->port_id = port_id;
 	dport->component_reg_phys = component_reg_phys;
 	dport->port = port;
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index f822de44bee0..8886c6201998 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1162,7 +1162,7 @@ static int cxl_port_setup_targets(struct cxl_port *port,
 			dev_dbg(&cxlr->dev, "%s:%s: %s expected %s at %d\n",
 				dev_name(port->uport), dev_name(&port->dev),
 				dev_name(&cxlsd->cxld.dev),
-				dev_name(ep->dport->dport),
+				dev_name(ep->dport->dev),
 				cxl_rr->nr_targets_set);
 			return -ENXIO;
 		}
@@ -1173,7 +1173,7 @@ static int cxl_port_setup_targets(struct cxl_port *port,
 	cxl_rr->nr_targets_set += inc;
 	dev_dbg(&cxlr->dev, "%s:%s target[%d] = %s for %s:%s @ %d\n",
 		dev_name(port->uport), dev_name(&port->dev),
-		cxl_rr->nr_targets_set - 1, dev_name(ep->dport->dport),
+		cxl_rr->nr_targets_set - 1, dev_name(ep->dport->dev),
 		dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev), pos);
 
 	return 0;
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 29e0bd2b8f2a..a8bda2c74a85 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -594,7 +594,7 @@ struct cxl_rcrb_info {
 
 /**
  * struct cxl_dport - CXL downstream port
- * @dport: PCI bridge or firmware device representing the downstream link
+ * @dev: PCI bridge or firmware device representing the downstream link
  * @port: reference to cxl_port that contains this downstream port
  * @port_id: unique hardware identifier for dport in decoder target list
  * @component_reg_phys: downstream port component registers
@@ -602,7 +602,7 @@ struct cxl_rcrb_info {
  * @rcrb: Data about the Root Complex Register Block layout
  */
 struct cxl_dport {
-	struct device *dport;
+	struct device *dev;
 	struct cxl_port *port;
 	int port_id;
 	resource_size_t component_reg_phys;
-- 
2.34.1

