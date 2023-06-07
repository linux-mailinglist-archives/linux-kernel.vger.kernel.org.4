Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60DE1727167
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 00:18:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231500AbjFGWSI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 18:18:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231420AbjFGWSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 18:18:04 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2076.outbound.protection.outlook.com [40.107.223.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E963926BD;
        Wed,  7 Jun 2023 15:17:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A8YaCZ5d9F3+gF6cLKydA1iYfAURiZtNjWivXcyCLZIOqekNVvJmnEDJX/Snlpmf316vlxm3ZwawEiTHm+WFEYAtDObZBCKpxgReEGB5C40w/DhNCslGad5dQdLEsfIsVhsk1GBicY9MIWXUSDV/a2xW1P54/nVsYbGdgu9OOaY07Xyny3uITjPv1JwDviIqinqbYa9kryAwZgC60QjTs/BugDCsNu2I+jx/bIK5iMnbohLWcLx8HjpH2ODFxDk3e76aTsuv6Najmc+mfV9cgHnpzfSlUHslrdOxpuwhPnuZy58xw7buwFqXdk8/jwBqlET/2cXro3UAwJJWitaPCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EI4mt7LRGBaEf9teLCN+AEvRx9//IJ/yF4HuqjKZ4lI=;
 b=FFs3G2TXqlQxxC/cW6d63CGteGvUleKTWmtDmElWUCoiqJq3606K/hP0EwBL+LsfpuEJxbW2ONW0xICoQDBofHnZ7zTsIePj1Ys0TOR4yYFEVfmRE0iCmACwd+x7EzQQySvJIwL81eVEvySFwiUtHYhQev20ucN3+//sXEJXj2eyW5tPMgexBNulSG0LuhGolUTwsPwylUnRF1FHmrhDz0bpJOkj5wDcuj5Judgj+8ca/mT4Sl2C/FCog/N6e8XbIBd4m2R3FZ+/uB6NBSg2ptzlsaO6ZkSR4uESbJPwNwtfE/byBahzshSsR32yGSOhgc2izYkX3KdXRijOCdAUTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EI4mt7LRGBaEf9teLCN+AEvRx9//IJ/yF4HuqjKZ4lI=;
 b=e4VtcDarggGh7cwHXL17ICAMm54D+nZfK7nE+v0H1KkI4PElYmAiEwAnGPv3a5eBfSpdyGD1YPtjh6U9prFV1ysAY6P3xL5BKRbWENEa3aUhdJQfuQ6Ti/FSiFwNm5pGwzQbVKRs2zToDH5VqikYj0jHH5O6zHc19Obc0wCoLi0=
Received: from SN7PR18CA0018.namprd18.prod.outlook.com (2603:10b6:806:f3::10)
 by PH8PR12MB6867.namprd12.prod.outlook.com (2603:10b6:510:1ca::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.28; Wed, 7 Jun
 2023 22:17:39 +0000
Received: from SA2PEPF00001504.namprd04.prod.outlook.com
 (2603:10b6:806:f3:cafe::7b) by SN7PR18CA0018.outlook.office365.com
 (2603:10b6:806:f3::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.36 via Frontend
 Transport; Wed, 7 Jun 2023 22:17:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001504.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6477.13 via Frontend Transport; Wed, 7 Jun 2023 22:17:39 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 7 Jun
 2023 17:17:38 -0500
From:   Terry Bowman <terry.bowman@amd.com>
To:     <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <bwidawsk@kernel.org>,
        <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
        <Jonathan.Cameron@huawei.com>, <linux-cxl@vger.kernel.org>
CC:     <terry.bowman@amd.com>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: [PATCH v5 03/26] cxl: Rename member @dport of struct cxl_dport to @dev
Date:   Wed, 7 Jun 2023 17:16:28 -0500
Message-ID: <20230607221651.2454764-4-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00001504:EE_|PH8PR12MB6867:EE_
X-MS-Office365-Filtering-Correlation-Id: 31aa3e8f-b5c8-486c-debb-08db67a5018b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 247lNQVx5TIHq925vRncje8NwTBXcxh92V12FTA1CFN957oqI2TlmUdid9x0PES+lAdLoPkQJGXSVmUfzaFR3mYhXpeGp0ah8hGP08D+yZm9/g/hqzLoprx3qXOnWaNX9TgTxiP9n9ycnQwHo6ugbQALMviVNh+yR8/km5kHhNnP4hM5rt826COWapGd9A/Jr6xjBwzWPUk6NvoxNoejKmpU4qhztLsPCetAVUAQECOgU7SbRLK2lj5o7VF0oOb0ArXuufmMMIweum5F0fLEV5krCPM19OZfmqOwoOunPRxraKX+MeyusdwEL0HWiws9kY8x59qKpMrPLjRpaE7FzjTJ2Lc+lRpYqs8P2wgTTBrXpyLpmb5UUgSNEJNP8cfqNuuHCDFx0F/mVpLBGE0QKbfsDUAk8cSZE8Mwh1DBvQB/mWSvFQyAEVnzABKGDxU+O4oh7bipani+2OQ8j/4R6yxCkMc+oAJkZvx2GkywXMgKyOR4S2LVCpri4uXd0LxDibxF4Sxk0EJiIYDO5Jodu4QtbumRLBqvA0OPaFo2AQKUH0Pf93XN5K8SYVhylkM/3g2mQYdsRAT1x3ay8gUidamLPYo7rqMJoDQILROKlbvsZLjMfgDqoRxdgVTXYWFnZNR22TgpYux4xzqTbdm6A4KASWlc4C1I3U3wMds/ozE4Wwlbk+r4+XMFNa2nHcXbUGaiX8sYYI9c65TCABqM7P98Y/ZqUkuLCowo8/+D6yrOfOta+fohS9WnQ/qCUAMcIEkSAhh4LWM72h9BbNuyMA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(376002)(39860400002)(346002)(451199021)(46966006)(36840700001)(40470700004)(36756003)(82310400005)(2906002)(7416002)(86362001)(44832011)(5660300002)(40480700001)(83380400001)(47076005)(6666004)(7696005)(186003)(16526019)(36860700001)(336012)(426003)(26005)(1076003)(356005)(82740400003)(478600001)(40460700003)(81166007)(54906003)(110136005)(70206006)(70586007)(4326008)(316002)(2616005)(8936002)(41300700001)(8676002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 22:17:39.5640
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 31aa3e8f-b5c8-486c-debb-08db67a5018b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001504.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6867
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
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/cxl/core/port.c   | 20 ++++++++++----------
 drivers/cxl/core/region.c |  4 ++--
 drivers/cxl/cxl.h         |  4 ++--
 3 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 7c75e8832afb..82de858506c7 100644
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

