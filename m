Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47B827395FF
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 05:57:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbjFVD5o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 23:57:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230306AbjFVD44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 23:56:56 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2061f.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe5a::61f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F18E26AE;
        Wed, 21 Jun 2023 20:56:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lXVnwR70G0IGyVSoaKkX0Kxp/LEFB5aWY78ME01n9OxBNMX1B7VOXJTXiLylT/QpPeHcV9fduYnE0p8qxdjm0CEhQEB7BTexhZiQDK/NjGtKi7QPTMkMJ72APZbBtVtmHhtUPe131ibOwjfPy7pELyvcHxZXGV4cm28HqITHWdnkQH+VuDz5uab/dEvofC+9aLaAN3X+2zgLtv06R8yYM3pP5snLrDZPQ5oOSig6bI94lFLVfO0cVq9C55GpuPCwRwQ0q0qf/7B1MB8iIjBfNlzDVbiVafdaVXAYKYzatbSgxoPiJnwOsuwW1RDMrRktf7n9ff8QvviDbzzDda6Xbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RwLtl14xwOqBYvA14zKZwMZRXZc8ID2gmY3rWTKg6NI=;
 b=H5Md3mfXpDl8uaVp8fBwJ63TTZRmCILh0Zu7a+/H/7X7BqPLNAkyvn2/aJZaWuSJ6ZOA5XnaEzZlFjkZfog6Ff/lJZX6pFI03HtIzuM3BPqrXNGu+IV+KXueGIciDq1ysc3Szj2BMKKWjaImmy9ZY65crhygLaQWyOoi0qxVzrfMp3KyIlQnmlOddAf1fdQhiBVj8Jl5mO0Ldh4H9/UtTnHDq60n8NQPpRsXDMO9vzokW7b/uUO5w++JAug68xOM7yIXIPiNXvJYNL5DNiMmPVvxJ0RMrZ3o8qoBc8nBENxYy2WGejRp1coFtMwrRm9EtumQl89ogOG6v+pqmqVAig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RwLtl14xwOqBYvA14zKZwMZRXZc8ID2gmY3rWTKg6NI=;
 b=wqMm0LFSDln8EdCs04TntOdKNc2+YSHfkD5kQ3oo3PFHzi04L+RF2BkjO3eVlNM2e2QpJX9sxezzj0PWVGaU7f7WxLEb6n0ovkB1YywZRTGxgstijDP+Lf9T60G7PQeJmdXMo4uz5cCVCbh+U0oO9YOlBO/5eWEP0gemZPS4k7c=
Received: from BN8PR12CA0016.namprd12.prod.outlook.com (2603:10b6:408:60::29)
 by IA1PR12MB6458.namprd12.prod.outlook.com (2603:10b6:208:3aa::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.39; Thu, 22 Jun
 2023 03:55:28 +0000
Received: from BN8NAM11FT070.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:60:cafe::e5) by BN8PR12CA0016.outlook.office365.com
 (2603:10b6:408:60::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24 via Frontend
 Transport; Thu, 22 Jun 2023 03:55:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT070.mail.protection.outlook.com (10.13.177.50) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.41 via Frontend Transport; Thu, 22 Jun 2023 03:55:27 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 21 Jun
 2023 22:55:26 -0500
From:   Terry Bowman <terry.bowman@amd.com>
To:     <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <bwidawsk@kernel.org>,
        <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
        <Jonathan.Cameron@huawei.com>, <linux-cxl@vger.kernel.org>
CC:     <terry.bowman@amd.com>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: [PATCH v6 15/27] cxl/port: Store the port's Component Register mappings in struct cxl_port
Date:   Wed, 21 Jun 2023 22:51:14 -0500
Message-ID: <20230622035126.4130151-16-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT070:EE_|IA1PR12MB6458:EE_
X-MS-Office365-Filtering-Correlation-Id: 8307142f-4d44-41c7-d7ed-08db72d48411
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k9w+GRd3NRp/vaeVErRJJZCnH/ByBjYyjG4qpG+iOzje1qCec1EjPoy27wEKDa8wIUrfPS5GFgFSiwfDluZLbvIPvlbfFjmnUeIylKFLCfIgONTv7WA1zjYPqKhbxVTl426rHIwJZXtGyREXmeSAz6UeZcShUmDwYsXt6zBToo4ZUngjHiLci7/LjIUnKiNXIHE+lgHqbTWmz5zjHeMBdZIY9TFXKSpS5AOeJL59l3oDqQrFQZe5Oi+51sxstX+ydQC1n7jwHIo/klvBD9xYme2Dh23rmZefMmNhPa+7W/h3AG6kHcnpvTacOJdi4tCAlxreYKfErCmc1B6YRCXsNno32lrK8ti4usTRXDvc6gyRm3OhRPr19hLJSJS3vK7aFVZ/S5ArCcohe8sKqKgQcWmmnPbbWtoVC7hMNAqXzU+2s90blxe+hcgvD3AKo6rqX9scF+cmbnM58TdjSqkQz4M2Tlkk2plOvTfBlARY5yLYUnnPrrkWlLJnb2rcMo3MIs7VlvIor4tRTZ436V6dffsbkLyjM0utIVSMnjAzAOwgZgTTQiNzm9JPMWpRsmm1cwtvbv+W+SQDsTldG9VFXa7W+4ISKvYGNuzU0INdqPQtuBfJh3B+UgW4bCH2LfkeKICaIatqndvKc2H/yDElZYTMOEvLHA3VdG/TKSptxjbDyJB06wC++l2sN0mEg/8eNKNdMTWQ16yYtmDIps3dgwssaQwhhDiLy85+vCx5f9ILgDFZ/jiqMmr5bs8O4C4AYM6Gbe+Wmw7U+4kdlTxUJQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(346002)(136003)(396003)(451199021)(46966006)(36840700001)(40470700004)(82310400005)(7696005)(8936002)(8676002)(41300700001)(316002)(356005)(70206006)(44832011)(36756003)(7416002)(2906002)(81166007)(82740400003)(83380400001)(26005)(336012)(6666004)(110136005)(54906003)(478600001)(4326008)(426003)(40460700003)(86362001)(5660300002)(40480700001)(47076005)(70586007)(16526019)(36860700001)(2616005)(186003)(1076003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 03:55:27.6827
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8307142f-4d44-41c7-d7ed-08db72d48411
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT070.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6458
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Robert Richter <rrichter@amd.com>

CXL capabilities are stored in the Component Registers. To use them,
the specific I/O ranges of the capabilities must be determined by
probing the registers. For this, the whole Component Register range
needs to be mapped temporarily to detect the offset and length of a
capability range.

In order to use more than one capability of a component (e.g. RAS and
HDM) the Component Register are probed and its mappings created
multiple times. This also causes overlapping I/O ranges as the whole
Component Register range must be mapped again while a capability's I/O
range is already mapped.

Different capabilities cannot be setup at the same time. E.g. the RAS
capability must be made available as soon as the PCI driver is bound,
the HDM decoder is setup later during port enumeration. Moreover,
during early setup it is still unknown if a certain capability is
needed. A central capability setup is therefore not possible,
capabilities must be individually enabled once needed during
initialization.

To avoid a duplicate register probe and overlapping I/O mappings, only
probe the Component Registers one time and store the Component
Register mapping in struct port. The stored mappings can be used later
to iomap the capability register range when enabling the capability,
which will be implemented in a follow-on patch.

Signed-off-by: Robert Richter <rrichter@amd.com>
Signed-off-by: Terry Bowman <terry.bowman@amd.com>
---
 drivers/cxl/core/port.c | 26 ++++++++++++++++++++++++++
 drivers/cxl/cxl.h       |  2 ++
 2 files changed, 28 insertions(+)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 679226023f0c..2e239fd33df9 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -688,6 +688,28 @@ static struct cxl_port *cxl_port_alloc(struct device *uport_dev,
 	return ERR_PTR(rc);
 }
 
+static int cxl_setup_comp_regs(struct device *dev, struct cxl_register_map *map,
+			       resource_size_t component_reg_phys)
+{
+	if (component_reg_phys == CXL_RESOURCE_NONE)
+		return 0;
+
+	memset(map, 0, sizeof(*map));
+	map->dev = dev;
+	map->reg_type = CXL_REGLOC_RBI_COMPONENT;
+	map->resource = component_reg_phys;
+	map->max_size = CXL_COMPONENT_REG_BLOCK_SIZE;
+
+	return cxl_setup_regs(map);
+}
+
+static inline int cxl_port_setup_regs(struct cxl_port *port,
+				      resource_size_t component_reg_phys)
+{
+	return cxl_setup_comp_regs(&port->dev, &port->comp_map,
+				   component_reg_phys);
+}
+
 static struct cxl_port *__devm_cxl_add_port(struct device *host,
 					    struct device *uport_dev,
 					    resource_size_t component_reg_phys,
@@ -711,6 +733,10 @@ static struct cxl_port *__devm_cxl_add_port(struct device *host,
 	if (rc)
 		goto err;
 
+	rc = cxl_port_setup_regs(port, component_reg_phys);
+	if (rc)
+		goto err;
+
 	rc = device_add(dev);
 	if (rc)
 		goto err;
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index fe95f08acb69..37fa5b565362 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -547,6 +547,7 @@ struct cxl_dax_region {
  * @regions: cxl_region_ref instances, regions mapped by this port
  * @parent_dport: dport that points to this port in the parent
  * @decoder_ida: allocator for decoder ids
+ * @comp_map: component register capability mappings
  * @nr_dports: number of entries in @dports
  * @hdm_end: track last allocated HDM decoder instance for allocation ordering
  * @commit_end: cursor to track highest committed decoder for commit ordering
@@ -566,6 +567,7 @@ struct cxl_port {
 	struct xarray regions;
 	struct cxl_dport *parent_dport;
 	struct ida decoder_ida;
+	struct cxl_register_map comp_map;
 	int nr_dports;
 	int hdm_end;
 	int commit_end;
-- 
2.34.1

