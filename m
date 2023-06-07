Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A357D72717E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 00:21:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232625AbjFGWVV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 18:21:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233015AbjFGWVF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 18:21:05 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2042.outbound.protection.outlook.com [40.107.220.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD1A72717;
        Wed,  7 Jun 2023 15:20:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n8fc+UAblrSrWvgPtXhzld8OVXYEsSlm08y9y4eqjnyIRcsUhI9d1d9rxBFlvbJ+/ewnZ+8GW90434ET/B5KPEJWfKaRSzgeAB0B1Ka+r5Nn0fkfJDk4d5KtvdnVis4njnNjKKmS9GmYIiIvw8gxo+nxgSUXeEQTb+fg5clhTi6dMpRsGsuzdvVQ7cV287AjF9m7cvuRQfP7jRzzH1LkFg4ZcKfE8Tv4Hvi589mXJ4NWVNUfTf3ive5dPcVqXZptmDM59GtLtK4LTQTdWm/breS1Hz98GSfJT8mzi9lyi5RwAgNBV1ihP3nWnm4/OTLBnbueK0HvZjHB9XoQVq7wUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M3jSizoV4xF32SGkaMOlI96ma4dVjd6XLw4E/qnbEpk=;
 b=a9+WR+fHAFz1uPs4i/KyxsOQsleIrWFLuDqWQk6RfyBQeXDtutM7xB6mwpC8aS349YPO4CvgrExSlw5CgZYYMTBy3lJbjPUAXN/8tThiZn+9Q+AZeq5kMkyHA1PYhbXL9Fsyo5l+zozxJuDuMScLXgFoGjD7YJDjqfpJ1xqSPWvk1Kwdj7EFRlzOxq5c05ZvqxiDc8vgJTzb7P+HhkF0PLrdfJmcSm9fTtk0FXbDRWJJ1Kc6IDdUzaNyd5loL5zkWKMwnzmi85tn1yo5KQFyLxlcQB26nUWf/BdKcnVy3sxr7kuJN28VkCzAsh8X8JrtSwXNOLKuPTMAWMB9OT7BhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M3jSizoV4xF32SGkaMOlI96ma4dVjd6XLw4E/qnbEpk=;
 b=jkOJ+QBf00giBXtS6o+XLbEqk/07Crpm8pWYRYg3C1gqDWZb8rDkgkYSvvX1AUEJE4w8EZNL3ek5pW3dzCvTUBF6oINga++0R/xg/Nq8fC8XhozgLHVdiXJpiIf3cbR32pI86b6JA5lX4M54yi2Vk9rVDHud7wUfIo9n4gsEgt8=
Received: from SN4PR0501CA0054.namprd05.prod.outlook.com
 (2603:10b6:803:41::31) by MW4PR12MB6998.namprd12.prod.outlook.com
 (2603:10b6:303:20a::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Wed, 7 Jun
 2023 22:20:15 +0000
Received: from SA2PEPF0000150B.namprd04.prod.outlook.com
 (2603:10b6:803:41:cafe::dd) by SN4PR0501CA0054.outlook.office365.com
 (2603:10b6:803:41::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.19 via Frontend
 Transport; Wed, 7 Jun 2023 22:20:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF0000150B.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6477.13 via Frontend Transport; Wed, 7 Jun 2023 22:20:14 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 7 Jun
 2023 17:20:12 -0500
From:   Terry Bowman <terry.bowman@amd.com>
To:     <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <bwidawsk@kernel.org>,
        <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
        <Jonathan.Cameron@huawei.com>, <linux-cxl@vger.kernel.org>
CC:     <terry.bowman@amd.com>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: [PATCH v5 17/26] cxl/port: Remove Component Register base address from struct cxl_dport
Date:   Wed, 7 Jun 2023 17:16:42 -0500
Message-ID: <20230607221651.2454764-18-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF0000150B:EE_|MW4PR12MB6998:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ce3ae14-b780-4712-93a2-08db67a55e20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GoOsMhWZtT4wRDBBsCrVSMY29kK84GlxbGmgaC9GuPUA1b5ZjIU+sTnAWkvUWT5k3+9srtCnU/ujMUXrv0TFerkcvDBK0FaJFcj/Dt3lH+fg29gJpp2Mc60h5YBP+YHHUeDdWZ+ZFhPEzbg6zs2zCillTjYCThagM/l4o+ztLDfUnnIX7AvcJHvKXvOy02n8Pnl4RbJ1zUEtRZoxtlXo/M8Q1gM7/jaQm892uLyZsU7E/AGUIRKJ2jLHTgXRQK9sAoAXFTDPKQ5Cn4HfHXhX5zI1MYmrQ7n2NgmWo3R58S1BZtO0EX0GTEzKGgwDBYKBgfyhrY7FXE7SFC8Jcbym2/3yr0hYry0Blg810KUgPScTPHBEFM4m8XfvdMtyWUdRj5ZZOMwVXiYo6U3WgMeQ1qKZq9pGah4iTDsO5HanEbz99akn2s8TvjLWnfbuNXpbWCnrbx+Egq3mf46Mnduz6cY5Boa4xMi5VqAifExnI8/p2UrSPPFWM5Q5YzPXbJZFCh0OBCWMoh76zv5lA3wpCW48DDSXd6BJYNnqCYHGg6uQX37G9XHsiZ7jr/oBPaCyTJxyNaThAJ0zYWN3iFifV+EKjgBMsQx5fqf8VHP7q2XQl8c6zjiUZ1NhYVSitj7r+9KOd1snINyQ7mm29v6L5I01zd4k2cf+J+BuW+hDuHnn0zNvqeAOt0IpUS2oWq/Q+e4iUEMSrT5v4aVeiEJmlw3Y0raTj52tQZ81e4NFirIwTTcQPL1RNYRRoTZo2G0gQHj69NFsQTEknvFfigT28A==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(376002)(346002)(136003)(451199021)(46966006)(36840700001)(40470700004)(83380400001)(40460700003)(336012)(47076005)(426003)(2906002)(2616005)(36756003)(86362001)(82310400005)(356005)(81166007)(82740400003)(36860700001)(40480700001)(41300700001)(316002)(6666004)(5660300002)(8936002)(8676002)(7696005)(110136005)(478600001)(54906003)(70586007)(4326008)(70206006)(26005)(1076003)(16526019)(7416002)(186003)(44832011)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 22:20:14.8890
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ce3ae14-b780-4712-93a2-08db67a55e20
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF0000150B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6998
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

The Component Register base address @component_reg_phys is no longer
used after the rework of the Component Register setup which now uses
struct member @comp_map instead. Remove the base address.

Signed-off-by: Robert Richter <rrichter@amd.com>
Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/cxl/core/port.c | 1 -
 drivers/cxl/cxl.h       | 2 --
 2 files changed, 3 deletions(-)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 554d779af619..3111f754c740 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -994,7 +994,6 @@ __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
 
 	dport->dev = dport_dev;
 	dport->port_id = port_id;
-	dport->component_reg_phys = component_reg_phys;
 	dport->port = port;
 
 	rc = cxl_dport_setup_regs(dport, component_reg_phys);
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 4365d46606df..6134644b51f8 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -601,7 +601,6 @@ struct cxl_rcrb_info {
  * @port: reference to cxl_port that contains this downstream port
  * @comp_map: component register capability mappings
  * @port_id: unique hardware identifier for dport in decoder target list
- * @component_reg_phys: downstream port component registers
  * @rch: Indicate whether this dport was enumerated in RCH or VH mode
  * @rcrb: Data about the Root Complex Register Block layout
  */
@@ -610,7 +609,6 @@ struct cxl_dport {
 	struct cxl_port *port;
 	struct cxl_register_map comp_map;
 	int port_id;
-	resource_size_t component_reg_phys;
 	bool rch;
 	struct cxl_rcrb_info rcrb;
 };
-- 
2.34.1

