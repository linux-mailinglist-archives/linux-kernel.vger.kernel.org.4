Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B54C772717C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 00:21:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232818AbjFGWU7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 18:20:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232729AbjFGWUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 18:20:38 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on20601.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e8a::601])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C8FE26A4;
        Wed,  7 Jun 2023 15:20:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M8akOZJDvnrYZvvBZVvF4UN0iUDUX16mvWY46X9tZnYV41XxiI+J277WzR1J653meKhMwc9rXQjXqiovtMLKyR5FGctnn3Y0gSFjPvhRJrP9zJEyjM2h4Dww+VNyC4pKsgqFZP4iZJ3g2CSttSjs+0UNrN+YQbpZJRYH0vYf6/5e0CXID1/QDwnA7XGnauDgf4MH+6J6Mecqk00zJk+W1h2688Bg3TynV7NN2uvd9WSppzd1krRDuNoZklCqsTU+C0oVsOw5FINGIJXqTvlkY8SDmA+cP4ozkfh5YKNicdtm9N8Dhi8tim+UQtlfNcvI+Cmzf4qI+berN7AD0vAI4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vTWebRW4p3Zzhpr5o1kZ1GNGSrUKYalwAtn9qtuFgoc=;
 b=Bq6MD7Suh1p1H7grnVe9Hp4Jy2zUXh8g7Z+Z4Ppz1ny4QdHnG/haDar3lFsm/26y9EJZNdcCG0BW/ir4Gkl3YraemkikI7hA/W2sQpNA9ZzLgS9XWKuUMR0Fa1XVNu9T9EoGoTXOH2D2BfC8qsO2RyPmIIB6YacSW7rBz/FgfuwCyXaiHye1NJgIRmch2ZPTcoBZ7YZ6TPJOHgHBvBTIPH75H8jaAdG4QTauNPaYr8ZszDKg2drsdOH7f4PyyLgpOhJK44LwdpChxFPRTzyt5VFTy+UDuWVLeSsisP7X2Gyd5V3WuD6VKIJM5FyDQlEeUBmzANaz08pZswM+wzMhKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vTWebRW4p3Zzhpr5o1kZ1GNGSrUKYalwAtn9qtuFgoc=;
 b=dglm1R8l9wuY0lD96/NMNLc9ZBK1chMhK9X76E4Hc3jdUq+5ENJy5CeXa3dHVFFmyncejntAG0S+9sTbWTAPuoGsb4RagthG05cDZJLY32ax9DnVbQ+MiBqCNfNN4/Y99gIEV73KX0s2IFDdokUDiI0oUuO4ajdCnazpgERHfHs=
Received: from SN4PR0501CA0132.namprd05.prod.outlook.com
 (2603:10b6:803:42::49) by DS7PR12MB5765.namprd12.prod.outlook.com
 (2603:10b6:8:74::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Wed, 7 Jun
 2023 22:20:03 +0000
Received: from SA2PEPF00001506.namprd04.prod.outlook.com
 (2603:10b6:803:42:cafe::4) by SN4PR0501CA0132.outlook.office365.com
 (2603:10b6:803:42::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.19 via Frontend
 Transport; Wed, 7 Jun 2023 22:20:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001506.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6477.13 via Frontend Transport; Wed, 7 Jun 2023 22:20:03 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 7 Jun
 2023 17:20:01 -0500
From:   Terry Bowman <terry.bowman@amd.com>
To:     <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <bwidawsk@kernel.org>,
        <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
        <Jonathan.Cameron@huawei.com>, <linux-cxl@vger.kernel.org>
CC:     <terry.bowman@amd.com>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: [PATCH v5 16/26] cxl/port: Remove Component Register base address from struct cxl_port
Date:   Wed, 7 Jun 2023 17:16:41 -0500
Message-ID: <20230607221651.2454764-17-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00001506:EE_|DS7PR12MB5765:EE_
X-MS-Office365-Filtering-Correlation-Id: f8561dfd-9f24-4eac-ebd5-08db67a5570f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a1xwZPsKeFkmEFCUKjdaBkz3U4tR/IDk2lvceQAUvk/DHIH3cjsunOKcGDXnPpKI8ppUg95fvVqMs0gk72roAtvOpnWnQkxRVp6In2zUiHDaFJHOpIHmwkUuLyb5dxV3De3wGhZqCNZ+Gcg59Uhon/tJPUHTU3gUTZePgnxDIb1bbdyzBoJcOyNb/CKQTwCwdSj7WS016yzvZ8HrAm3bEMKoQawmhMUFrvFQuYiQFMzk+bLMZlpTTJp0lxIxLSXmlUKPHmdJVQkeEYo8Laq4wBpKoAs/PeyZYDqeA1A7sqAlxbdMERORqKGwk6DlfpSHtev2o8nOYzLQFIqb7f+m/VyQ0vKF4z8IX8sT6rS2YzZUaOEuND4e//dv+JD07TuMoKR7bJ6TFuojiQyiHMmbAyJJlSUXt4rixVMaYfqm6uFt+y8m7CD5pVoa/qCnwq6x28SUZJCQvEYZcM7JHYTO7oHT+09lpLGO4XFrcIPaJ6vIdCDiVdrwGGj0oww6M9iNHICiBX5PKbctp0pAyy6wQJTQGnvwBxjPR0UUMEwyH9x9ubE0zVUkOwsQI/DQwqjFgd5JY+76s4SV4zOU2nWHSreMd2rD2/ekGokKbHo+ftlNzy6rJEgkXFMMVJrfQKJOdCThVG77rw32wv8yh/y120uuwA2hWZLpaq0Sb2BWGzMSlRVq0kxnEm4WA4GtFDfbPh0Wxjs1cFFh6LfFaFYM3jL0a7q1GDGv3S7KmRX+zD0EowXni7unkCtTv5opVtvKpy6zEGoH9+PMsCooukpuHA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(39860400002)(136003)(346002)(451199021)(36840700001)(40470700004)(46966006)(81166007)(7416002)(70586007)(70206006)(356005)(4326008)(41300700001)(316002)(8676002)(8936002)(40460700003)(5660300002)(86362001)(36756003)(82310400005)(40480700001)(2906002)(44832011)(186003)(16526019)(478600001)(2616005)(6666004)(7696005)(26005)(1076003)(110136005)(54906003)(36860700001)(82740400003)(47076005)(426003)(336012)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 22:20:03.0358
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f8561dfd-9f24-4eac-ebd5-08db67a5570f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001506.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5765
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
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
index a40d8cefb57d..554d779af619 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -615,7 +615,6 @@ static int devm_cxl_link_parent_dport(struct device *host,
 static struct lock_class_key cxl_port_key;
 
 static struct cxl_port *cxl_port_alloc(struct device *uport,
-				       resource_size_t component_reg_phys,
 				       struct cxl_dport *parent_dport)
 {
 	struct cxl_port *port;
@@ -665,7 +664,6 @@ static struct cxl_port *cxl_port_alloc(struct device *uport,
 	} else
 		dev->parent = uport;
 
-	port->component_reg_phys = component_reg_phys;
 	ida_init(&port->decoder_ida);
 	port->hdm_end = -1;
 	port->commit_end = -1;
@@ -724,7 +722,7 @@ static struct cxl_port *__devm_cxl_add_port(struct device *host,
 	struct device *dev;
 	int rc;
 
-	port = cxl_port_alloc(uport, component_reg_phys, parent_dport);
+	port = cxl_port_alloc(uport, parent_dport);
 	if (IS_ERR(port))
 		return port;
 
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index dc83c1d0396e..4365d46606df 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -556,7 +556,6 @@ struct cxl_dax_region {
  * @nr_dports: number of entries in @dports
  * @hdm_end: track last allocated HDM decoder instance for allocation ordering
  * @commit_end: cursor to track highest committed decoder for commit ordering
- * @component_reg_phys: component register capability base address (optional)
  * @dead: last ep has been removed, force port re-creation
  * @depth: How deep this port is relative to the root. depth 0 is the root.
  * @cdat: Cached CDAT data
@@ -576,7 +575,6 @@ struct cxl_port {
 	int nr_dports;
 	int hdm_end;
 	int commit_end;
-	resource_size_t component_reg_phys;
 	bool dead;
 	unsigned int depth;
 	struct cxl_cdat {
-- 
2.34.1

