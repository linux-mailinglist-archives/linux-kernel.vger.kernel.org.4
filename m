Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C289C73AB18
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 23:03:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231874AbjFVVDa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 17:03:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbjFVVCJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 17:02:09 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2076.outbound.protection.outlook.com [40.107.244.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F17F62D7D;
        Thu, 22 Jun 2023 14:00:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LOMX+cOvomQ2XVjctQMkpu5msBueb1prFS6sg1tF+ymQ6IHuxxP0Mf5Juv5XHdMoYNNVz9OhmYIwJfImJvZGd6MzYY70zxv0Vwcr6T+PbDY6Fgm8OGCyisr/GNkmREuMSsK1bX/dQ9Pet1D60IHHdneAVyHr1LQA4Yb2cvKT/TTfXJZyzWWN316riUFE2shic9qitvr0mC2t3FCbrJvLt+Ex6csFigpnDSphqs4Ugjb4pbp4Zujctkrr21qN5+HgbRPG6P00TBMHt4XJgTDt3jT41OyKe8H3ygdqnV2OlSus/SEjmL2ZnAb04UC9WALscgL07T4FfbnXV8pmwqUUMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KgTpm2nx7+39PjWbSUCJ3aB2hcwzIP0xRgKQ0bSQVX8=;
 b=maQNeNgDRkwBeAU+PXWByM38hVnDIovdlVeER1CxuoKICrVytA7ILYz4nBcv4cLxZE45x5Ie/tp8Fhl3oDyppC940eCu2GVSx/7zIPA9wjUu9+a/V9SWKfju6nmS57qOPp52ADKwVlT/pUkM3A74F4tZ47MDwpGCtEwnzP1ITQAZg8UPtE/34k1K6IOI1DVrIukoooAGP+L02V7dLasqqGcoGvgJkSurNrugwYLcNMgpuDA9SddRxrYvHjjv6IKm0+gezQPzidda+57DSeS5Dya+D6mnHZlsvaDt4N0m1VAqJEV0/RcGJKWpxJp4Hk782qI1U/nEuB4I+NOzLj3c4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KgTpm2nx7+39PjWbSUCJ3aB2hcwzIP0xRgKQ0bSQVX8=;
 b=dghplyb+wMix49uB+j1fUG4nj8PVb18fpGqs9+bDumO+9NLQioMJBsUzCp2txxIrm4Ofe4C1MH0H/Lh6ONMT2ZPfMcPUS9dI8N6kdX5beA4KhRE9iUgkcILqs8Cl3r/oD/hpf1JZjV7zzTaZpyU0zlF71t5sucmQwLvqmVE95Mg=
Received: from CY8PR02CA0001.namprd02.prod.outlook.com (2603:10b6:930:4d::7)
 by DM6PR12MB4252.namprd12.prod.outlook.com (2603:10b6:5:211::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Thu, 22 Jun
 2023 20:58:51 +0000
Received: from CY4PEPF0000EE35.namprd05.prod.outlook.com
 (2603:10b6:930:4d:cafe::6c) by CY8PR02CA0001.outlook.office365.com
 (2603:10b6:930:4d::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26 via Frontend
 Transport; Thu, 22 Jun 2023 20:58:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE35.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.17 via Frontend Transport; Thu, 22 Jun 2023 20:58:51 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 22 Jun
 2023 15:58:50 -0500
From:   Terry Bowman <terry.bowman@amd.com>
To:     <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <bwidawsk@kernel.org>,
        <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
        <Jonathan.Cameron@huawei.com>, <linux-cxl@vger.kernel.org>
CC:     <terry.bowman@amd.com>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: [PATCH v7 18/27] cxl/port: Remove Component Register base address from struct cxl_port
Date:   Thu, 22 Jun 2023 15:55:14 -0500
Message-ID: <20230622205523.85375-19-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE35:EE_|DM6PR12MB4252:EE_
X-MS-Office365-Filtering-Correlation-Id: a9ccf7fa-2deb-4984-42a4-08db73637b59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ETNayYknhU8FGhc0YfCcas5JhwjOte7ZYtDtTZO00cyWlTdIJRT+aPfbKlo/i9SyoiZSju+9n2ouGZSkUoCycdKiidxE1z88EYmgixekg+nSbvVIjYj0Yep2y66x/hfhRgnYk/6gSr0l0Cc6MPFdjGr7kyEby5ku7XSw7N7WSsSRCPiT5zmwsmCM44ZQICwnD8KQ0dw6KAsC+c+f5mleyGvhEelXcJXNqfZPvHFn5fk6dGyu9gi9V1NPtJk+Hjp33CRbU+2RxFj/Jt1swUs76ArolDh8sAyb5nS3SmfuhAlnDF5iUDvfMGv5hujnd3ge7MS1oMFObNMdG6LHUTg3ejsEWqywq9SI3wcmqU04WDCAobOLXEIvh6K7UWG1prVruBmAhBcvoO1NA9ItP72FFFFhxmcVhkyzFUz3qb4AlAbkEUmZW6gsXCxwcPsdA2QzMjmMk9NJYk46bkO/MDnsoKL+/noTDp9VUMJejtOXFiCwSL/XmjkSRQJZ53wkanwvl+FwE+fFbU3X95cZ1EZ3XCG0PWwedVp+89DZ6oY7ZgEH0U+UUHVaAoo38Q4D1dnxoskGZgXOeIgdVUePpwXP36Zwn73GTB6/3316ZzjYjWh5lznXr/1ZgSoqs8yJ71szLJ0T6yESfzNGZsH6sWZpWXWrtkoyQRZqc6DxPzDJmr+Qjk28xYDJnwed9UAtK+7PLxGdxZHQp2NHdpAYyDt0c72Ga9FlKSxpt0bvNWXeGLuU+3Au0/okqcmR2PCwmRR1NkQ3M7AfzgTR73NXYpLQuA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(136003)(346002)(39860400002)(451199021)(40470700004)(36840700001)(46966006)(426003)(26005)(186003)(2616005)(336012)(16526019)(1076003)(86362001)(54906003)(478600001)(6666004)(7696005)(47076005)(110136005)(36756003)(82740400003)(81166007)(356005)(36860700001)(83380400001)(2906002)(40460700003)(8676002)(8936002)(70206006)(316002)(41300700001)(4326008)(40480700001)(70586007)(5660300002)(44832011)(7416002)(82310400005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 20:58:51.0367
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a9ccf7fa-2deb-4984-42a4-08db73637b59
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE35.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4252
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

The Component Register base address @component_reg_phys is no longer
used after the rework of the Component Register setup which now uses
struct member @comp_map instead. Remove the base address.

Signed-off-by: Robert Richter <rrichter@amd.com>
Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/cxl/core/port.c | 4 +---
 drivers/cxl/cxl.h       | 2 --
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index cbd3d17f6410..95d5aae1f97b 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -616,7 +616,6 @@ static int devm_cxl_link_parent_dport(struct device *host,
 static struct lock_class_key cxl_port_key;
 
 static struct cxl_port *cxl_port_alloc(struct device *uport_dev,
-				       resource_size_t component_reg_phys,
 				       struct cxl_dport *parent_dport)
 {
 	struct cxl_port *port;
@@ -667,7 +666,6 @@ static struct cxl_port *cxl_port_alloc(struct device *uport_dev,
 	} else
 		dev->parent = uport_dev;
 
-	port->component_reg_phys = component_reg_phys;
 	ida_init(&port->decoder_ida);
 	port->hdm_end = -1;
 	port->commit_end = -1;
@@ -727,7 +725,7 @@ static struct cxl_port *__devm_cxl_add_port(struct device *host,
 	struct device *dev;
 	int rc;
 
-	port = cxl_port_alloc(uport_dev, component_reg_phys, parent_dport);
+	port = cxl_port_alloc(uport_dev, parent_dport);
 	if (IS_ERR(port))
 		return port;
 
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index b1adca9b27ba..9f46a4e1fbec 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -551,7 +551,6 @@ struct cxl_dax_region {
  * @nr_dports: number of entries in @dports
  * @hdm_end: track last allocated HDM decoder instance for allocation ordering
  * @commit_end: cursor to track highest committed decoder for commit ordering
- * @component_reg_phys: component register capability base address (optional)
  * @dead: last ep has been removed, force port re-creation
  * @depth: How deep this port is relative to the root. depth 0 is the root.
  * @cdat: Cached CDAT data
@@ -571,7 +570,6 @@ struct cxl_port {
 	int nr_dports;
 	int hdm_end;
 	int commit_end;
-	resource_size_t component_reg_phys;
 	bool dead;
 	unsigned int depth;
 	struct cxl_cdat {
-- 
2.34.1

