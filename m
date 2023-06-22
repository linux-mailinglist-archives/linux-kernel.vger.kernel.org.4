Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98C8873AA8F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 23:01:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231466AbjFVVBY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 17:01:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231521AbjFVU7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 16:59:40 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2061d.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e88::61d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A86BC26B8;
        Thu, 22 Jun 2023 13:59:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KcsttozYPyydCdS3XE71D8Cyb6o/g3FsNOvzzCtXyIssG3+H+KjcgP9pEhDL6EmZdgTHcIZfhsE80e+BO7aN+Oj8EtxB0FEJB0cftAI8jqWR1tycGWz5djj8NSsoYZnLS5MMrlHqVGSqNgZNd1Bb5UOUo3zj/gt/NZbnUscjI4COUbHtqkv0rsIl8jgm5WgGaB+igSEJI0zFGLy+RteMo4ZSBeVo08Uq0gI1J5nwYXq0HxOEYSwryTLPlB+LiZ9Vhz7pupvviblHBsTWxhEmrAgUaAbetpE4CXTxYCPeVGdb91kY+WpG1scqGUdPoLW4Joa3/VCnuLAfSgP/1GNNSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vkqEs6ZmbEts9c6Wly0FYTh8FuavnbbvEx04H/s25TM=;
 b=bmfsn+qb557piZWxxyTvKkKzvHju7W32KDmkUapamP0r1pjKVMfJRPp456lCShjTOQeKh4aP8/+e5rvrDILc9Boe9J5KmkWH8DFK0/YaUAGVyP9ImrSPiNCLeDCfeXHoDbOqzfz7u9hVHJWjZ8BxoJZ4/MOgqtdT6H7qDF+36essyK/Q6bf5AW767R6NSsrsF2dkDNYX6iFzv5iwdWz8LEsEiKMccPWo33eExOXJhw1D7Cav8KoRgeLjJ8oxuTKmDAeoyzJbELrId2mTz7U9JtRS1iyFg+Jh+MW9csmm1liYQCIlkzhgiiXFadTREuv/gfLb54DtGcnAj17nNz4rHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vkqEs6ZmbEts9c6Wly0FYTh8FuavnbbvEx04H/s25TM=;
 b=ZvImVFt0kWAyxeSEWme+FxGZWrWWd+nTAlPBg14CYqBerI+BdYPzHfKqM8rTF8hR91I0Jk4kuedmUEwQ8sO6XFJAd4OQ7xAbshl+oPRAcfpvHJDqNOQ3QrfeRbOGl5nkRTNqPEdhvF2SgkFHqgAQc2aax8Qa97i2ojCY6nY2CyI=
Received: from CY5PR14CA0018.namprd14.prod.outlook.com (2603:10b6:930:2::18)
 by BY5PR12MB5015.namprd12.prod.outlook.com (2603:10b6:a03:1db::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Thu, 22 Jun
 2023 20:58:19 +0000
Received: from CY4PEPF0000EE35.namprd05.prod.outlook.com
 (2603:10b6:930:2:cafe::31) by CY5PR14CA0018.outlook.office365.com
 (2603:10b6:930:2::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24 via Frontend
 Transport; Thu, 22 Jun 2023 20:58:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE35.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.17 via Frontend Transport; Thu, 22 Jun 2023 20:58:18 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 22 Jun
 2023 15:58:17 -0500
From:   Terry Bowman <terry.bowman@amd.com>
To:     <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <bwidawsk@kernel.org>,
        <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
        <Jonathan.Cameron@huawei.com>, <linux-cxl@vger.kernel.org>
CC:     <terry.bowman@amd.com>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: [PATCH v7 15/27] cxl/port: Store the downstream port's Component Register mappings in struct cxl_dport
Date:   Thu, 22 Jun 2023 15:55:11 -0500
Message-ID: <20230622205523.85375-16-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE35:EE_|BY5PR12MB5015:EE_
X-MS-Office365-Filtering-Correlation-Id: 1644f5f3-df9f-49d3-9b7d-08db7363682e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 67tFwtdOVJFzw1PuniPb4HsX5RjolQBtiUcx2Um5ALNuu4sBIPYzV67/oR8oF2Z/TmWI/5/UDIVjTpNhL3usmqvzpeCdpbsJMvRk3uUIHEAThwmt5TXiVkmJ0UoPHfTiSRkdP5tkWVKzFQ/hYNc296GgqorqzIRIjuP/KgIeA8nesiSPvhoO1zVBn3VcEW4lkPBh43FRBCKGxrUCsq/MEBzsy4gXZhvBfAbwlI7W1q7VX5/5FxASAo/9fT/KvqhQn65+3BwD+6p3JNHklvMkXBY7TPY7grI7McmkdJvjtg6DnZZvd2uMcFPGnLbE0DPXtmhOcgaNJ2Up1RexCgpi6YGcTTsP7CyA1OJkD7qkB857XaDBTPfAWqtylDc9Sct69cAqhESzNtYP1CYwfo55Sq2Lyvt9V5t7Hm1PQ0BW4TkpzpN5GMIzR5zDLEtFdblKGEKp8rG0D7EyLcCxQerRDmfmNkynZcP2EpFgctvzQimh7eFX/ZC9B9wdPaDyMwK3mNSpVR6HYUlr8th3ZnLf3G5eys/COuYJINQz9V98Byp7jU9juGwr5X3XGkrdrluSt63PcF7oq8Eae6B+OxbG+g0+n5A2gurQ9qg2C5Ztp+1QIstHWw0kWB4XVbRLW9Qta+uuLL3AjV3dtYlRWWRpkywnRK/RwyqL6zZCDjgWN7hcDpFM7lC1BXJiY8vSsZjg7MyRskcfLx2D4GOZeDlBmUummjmr9b4Z/i8mraDeR4pQbd3WyFaAxkQNHxozo3FsGPan2QZ7lp2wh6qUZE7deQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(396003)(39860400002)(376002)(451199021)(36840700001)(46966006)(40470700004)(40460700003)(2906002)(426003)(316002)(16526019)(186003)(83380400001)(336012)(47076005)(36860700001)(6666004)(70586007)(70206006)(4326008)(2616005)(54906003)(110136005)(7416002)(8936002)(1076003)(26005)(478600001)(44832011)(5660300002)(41300700001)(8676002)(40480700001)(81166007)(356005)(36756003)(82740400003)(82310400005)(86362001)(7696005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 20:58:18.8492
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1644f5f3-df9f-49d3-9b7d-08db7363682e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE35.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB5015
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

Same as for ports, also store the downstream port's Component Register
mappings, use struct cxl_dport for that.

Signed-off-by: Robert Richter <rrichter@amd.com>
Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/cxl/core/port.c | 11 +++++++++++
 drivers/cxl/cxl.h       |  2 ++
 2 files changed, 13 insertions(+)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 43ffecebf1d8..cbd3d17f6410 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -711,6 +711,13 @@ static inline int cxl_port_setup_regs(struct cxl_port *port,
 				   component_reg_phys);
 }
 
+static inline int cxl_dport_setup_regs(struct cxl_dport *dport,
+				       resource_size_t component_reg_phys)
+{
+	return cxl_setup_comp_regs(dport->dport_dev, &dport->comp_map,
+				   component_reg_phys);
+}
+
 static struct cxl_port *__devm_cxl_add_port(struct device *host,
 					    struct device *uport_dev,
 					    resource_size_t component_reg_phys,
@@ -989,6 +996,10 @@ __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
 	dport->port_id = port_id;
 	dport->port = port;
 
+	rc = cxl_dport_setup_regs(dport, component_reg_phys);
+	if (rc)
+		return ERR_PTR(rc);
+
 	cond_cxl_root_lock(port);
 	rc = add_dport(port, dport);
 	cond_cxl_root_unlock(port);
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 37fa5b565362..b1adca9b27ba 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -595,6 +595,7 @@ struct cxl_rcrb_info {
 /**
  * struct cxl_dport - CXL downstream port
  * @dport_dev: PCI bridge or firmware device representing the downstream link
+ * @comp_map: component register capability mappings
  * @port_id: unique hardware identifier for dport in decoder target list
  * @rcrb: Data about the Root Complex Register Block layout
  * @rch: Indicate whether this dport was enumerated in RCH or VH mode
@@ -602,6 +603,7 @@ struct cxl_rcrb_info {
  */
 struct cxl_dport {
 	struct device *dport_dev;
+	struct cxl_register_map comp_map;
 	int port_id;
 	struct cxl_rcrb_info rcrb;
 	bool rch;
-- 
2.34.1

