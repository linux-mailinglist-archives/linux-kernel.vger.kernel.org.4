Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0A2F744516
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jul 2023 01:18:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232152AbjF3XS0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 19:18:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231899AbjF3XSJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 19:18:09 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2082.outbound.protection.outlook.com [40.107.223.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 551CC4487;
        Fri, 30 Jun 2023 16:17:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UwPA2fcXmI5+rpvslerfOafpB70NO09kpsHyKgWBpYBuanU5yGxvWhhvwlkA+NaMaUApCDA1IbADwy6a9WCylgV61VkapdL9XG8WyaitfEeK5+NKY1FfYpMTE5tMX1vHBaIUCESSeWS8pVWYsWyeNDUcja8YRR2vh7ThipPNL2U8QCssVOnWnNumkkED2Mrdrhjcq7ibuQz3HeyksNhIDNXDkBZJInkgAad3bek9P1OgQDpDJ8mLvXM1w6DO9SDj41KQNKhxcvK8Tx4sawSsHzIC8D0Kf4ge4jJEKb8Qosy+YwPG1b+A24f61CrIn36ySbqta5HiXzUan04mE6wESg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o7serfzQiQHg0grqhTFUnVLW3YoTmgvkFzw/kStPs08=;
 b=nNKa3btjeU1Q0nDPif6HWVcQD6eFgzonUUm0qQIemqQD8KllFh2ImAQs7h4m07kAtTsZleFms28WUCSHjoQEqHLw7Ei9SHCu9ptDeb+NkBy5mdOeG9aHYeXx/u3V307MqpIQ7baieNpM0/jEVA1yRqJMbIpDkB8G95uQCmveU8oIBlPUqRnjOtFsqn5jefQnsOwQnDQNHDV5bKijjfy5Crc0pMAKant8kFFi4I1tFqQdGeKde+0hWhNwNwW6+xMTZUXONYl2XTkYea/+jeR2C04NQgijRzO5B+2Uv3XPyU2TcCeL7EL/QVmObK8BUZKJvDv4yA95z9WBZx55xX4D8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o7serfzQiQHg0grqhTFUnVLW3YoTmgvkFzw/kStPs08=;
 b=N6Sfl6U2NNllBK7SrvD3omHtrNCBDlKQ2yccA0USySLBn7n5Eamjn/LlFPldXhBgyDIb1460fFcnTf4Gg4PWa0XeaFz1qAaQM7M3kn/CgJOegyr2RQEYV1hK/JZ04YEzheB4A59daympTM/Lm2M/116myCiyZ7WX7l0QlD4xgvI=
Received: from DM6PR11CA0025.namprd11.prod.outlook.com (2603:10b6:5:190::38)
 by IA1PR12MB8262.namprd12.prod.outlook.com (2603:10b6:208:3f6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Fri, 30 Jun
 2023 23:17:45 +0000
Received: from DM6NAM11FT035.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:190:cafe::ca) by DM6PR11CA0025.outlook.office365.com
 (2603:10b6:5:190::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.22 via Frontend
 Transport; Fri, 30 Jun 2023 23:17:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT035.mail.protection.outlook.com (10.13.172.100) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.49 via Frontend Transport; Fri, 30 Jun 2023 23:17:45 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 30 Jun
 2023 18:17:44 -0500
From:   Terry Bowman <terry.bowman@amd.com>
To:     <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <bwidawsk@kernel.org>,
        <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
        <Jonathan.Cameron@huawei.com>, <linux-cxl@vger.kernel.org>
CC:     <terry.bowman@amd.com>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: [PATCH v8 05/14] cxl/port: Remove Component Register base address from struct cxl_port
Date:   Fri, 30 Jun 2023 18:16:26 -0500
Message-ID: <20230630231635.3132638-6-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: DM6NAM11FT035:EE_|IA1PR12MB8262:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e9f177b-c857-4821-6537-08db79c03646
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eMY8nyuxDad1DMvUipKsuHt/WlFyBTBuZ8ATryzPlCay/kauW6e4KDK8jXDWiJp08u08tJBUzRW+Qujpa2/XxmhH9+eXlzri1EekKR8TDxCZIppDbwaURbcpg2RG7rtJJjpBiR/1eZRMlmvSvMEAw2HDinRmXlXTOtvxzYTp2iQmMe72gYvBXtV4ms8hjvRmeFbu/Q5RuYQ0o+im1V6PJMImtGGVkjy4izhPzgcAHINy2u8yzPG7NgfnpV1MZN3sWO4v7XZi9Q7/dtCJnwlyfMAlEe2R/ctn+7EXX2XOUVNum2GYij/7++aPupHNQqn0pph2JOsL3QlUyWvWNtwn9BIG3mFKZaGmCHeF7xFEfDCwBiuuc3WOu+pqupI0gHzKOrbzJhl3YDy/GK8Z1iHgARNCRKhDND+bonSZXGcRz5c5Y5NHEWGF0nvXSgB3lQsSIaaGQhlA4Sf+dUW776nfiO3GC1tHcv1cItqy98xLzsDJsuE4fj6Ayb+3k0N8811Gpry0OaNJtJkIUO/RhvFC69OagrefPtRykTQZ6/8GAIMAACipQszjO+5vn3++0cS01pwUysSwmr2OxoCRofn4gesQ3FTUA783ERzB0t1lWDtd/ax9gM2IjkCduln1Xn0WYvd4kKyMJ0iLZycAOqbKjFkI5qkja8+6XUsZL5xe/iCHR/rnNiiRHubluXwBrPEUkcnP6FdEmdX09MEZK8OwbPyyMAZcwM8hvAGiwtWYl/qV8KVkNIQmdcMQhjdUyYZT5aDBeDE88MV+QBc6uQ5zVQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(39860400002)(396003)(376002)(451199021)(36840700001)(46966006)(40470700004)(26005)(2906002)(86362001)(356005)(6666004)(82310400005)(7696005)(186003)(82740400003)(83380400001)(2616005)(81166007)(336012)(426003)(16526019)(47076005)(40460700003)(54906003)(110136005)(41300700001)(36860700001)(40480700001)(4326008)(478600001)(36756003)(70586007)(316002)(70206006)(1076003)(5660300002)(44832011)(8936002)(8676002)(7416002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2023 23:17:45.3384
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e9f177b-c857-4821-6537-08db79c03646
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT035.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8262
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
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/port.c | 4 +---
 drivers/cxl/cxl.h       | 2 --
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 2d22e7a5629b..99cf5cfbbcb2 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -618,7 +618,6 @@ static int devm_cxl_link_parent_dport(struct device *host,
 static struct lock_class_key cxl_port_key;
 
 static struct cxl_port *cxl_port_alloc(struct device *uport_dev,
-				       resource_size_t component_reg_phys,
 				       struct cxl_dport *parent_dport)
 {
 	struct cxl_port *port;
@@ -669,7 +668,6 @@ static struct cxl_port *cxl_port_alloc(struct device *uport_dev,
 	} else
 		dev->parent = uport_dev;
 
-	port->component_reg_phys = component_reg_phys;
 	ida_init(&port->decoder_ida);
 	port->hdm_end = -1;
 	port->commit_end = -1;
@@ -730,7 +728,7 @@ static struct cxl_port *__devm_cxl_add_port(struct device *host,
 	struct device *dev;
 	int rc;
 
-	port = cxl_port_alloc(uport_dev, component_reg_phys, parent_dport);
+	port = cxl_port_alloc(uport_dev, parent_dport);
 	if (IS_ERR(port))
 		return port;
 
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 76d92561af29..6c045a13ecf3 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -576,7 +576,6 @@ struct cxl_dax_region {
  * @nr_dports: number of entries in @dports
  * @hdm_end: track last allocated HDM decoder instance for allocation ordering
  * @commit_end: cursor to track highest committed decoder for commit ordering
- * @component_reg_phys: component register capability base address (optional)
  * @dead: last ep has been removed, force port re-creation
  * @depth: How deep this port is relative to the root. depth 0 is the root.
  * @cdat: Cached CDAT data
@@ -596,7 +595,6 @@ struct cxl_port {
 	int nr_dports;
 	int hdm_end;
 	int commit_end;
-	resource_size_t component_reg_phys;
 	bool dead;
 	unsigned int depth;
 	struct cxl_cdat {
-- 
2.34.1

