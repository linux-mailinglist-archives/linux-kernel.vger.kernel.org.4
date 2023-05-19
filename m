Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90D5870A228
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 23:55:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231173AbjESVzU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 17:55:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbjESVzS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 17:55:18 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on20600.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eae::600])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB21D110;
        Fri, 19 May 2023 14:55:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=neAZUKDB3pVwCYZFK7UgEYBSspySX5vQyAf3alPdvhnmHtsucx5q+hSCeDc9MW42R0y7mJApZluR5VD5YleZoXiAhuu9q4K9HCUryz05C7iF/Tps/6TOvhxr070BuBlkXfqBlWt90ylaDDRIxyCQND0hRIacG6JQjqdO4Ipo98dNR/UDLAvnng+8UDsix0Q+YqMhQLKHLqKJQ+go0ot2nSQas1gMF6sFFzvSjDEZds2WEYo7OVFUaHjLcpvx7NWLdcoYqQwE3gWZoT76Q+cHX89+9vspUg3+JwCP3ImTdZp75Fk7G0sri8tQx8CLL6mfNw6K/px2fzSFpE/u2fGESg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zMqhDo8OInbCUhb+4XP6xkJhnolqdujSB7JAvEVMnLk=;
 b=KuH2NRYh2itxM25uVsqIoGwWhHHNTDeo5Z+TiE+a9e3Gl1ZU73vjTZput0xWCaz+HC4rhM9wZquH9frCbPFiRCF+Uye6RXM7EgIVrJZKqtuhwkLXCKYTioDpi8Tc9EsNmbXqDey7Z7jn+CinCclH8qprUvo01wQEKiT0MFLwrfVK7ub1BYqmmcNRNkJnx7+g3iQB5XX9dF/9SpBrV2xkmnFN9JX7Kk51U/sdEWrUHHrN0I8xGgzYhKAJ+AST8az4q8j8SZbJwq1pUwmbTHTpDk8XqGSJkh6NvnjlQF5h/bTmJsipLt47qTVsLt+VzKaUpc59tBK3hh6LFIBBEf7VLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zMqhDo8OInbCUhb+4XP6xkJhnolqdujSB7JAvEVMnLk=;
 b=oHLna2UmCdCbg8XgIE8HpYkPKibFxlPopZ3mpg6UrmrQZWNkM9wyKUfKVYvx6NHP+ElAguD0gbbI+7PXhXhoCkCfCF7ATMxSyvBknCJkxRxCjoTmGFMwD7+Sur4Gj4Y1OGk8V2JzKeoqK7FZAxVv6BFx1xoVWW5FRhIKIJBJJgs=
Received: from BN9PR03CA0484.namprd03.prod.outlook.com (2603:10b6:408:130::9)
 by DM6PR12MB4500.namprd12.prod.outlook.com (2603:10b6:5:28f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.21; Fri, 19 May
 2023 21:55:13 +0000
Received: from BN8NAM11FT047.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:130:cafe::7e) by BN9PR03CA0484.outlook.office365.com
 (2603:10b6:408:130::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.21 via Frontend
 Transport; Fri, 19 May 2023 21:55:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT047.mail.protection.outlook.com (10.13.177.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.22 via Frontend Transport; Fri, 19 May 2023 21:55:12 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 19 May
 2023 16:55:10 -0500
From:   Robert Richter <rrichter@amd.com>
To:     Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        "Robert Richter" <rrichter@amd.com>
CC:     <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] cxl/port: Fix NULL pointer access in devm_cxl_add_port()
Date:   Fri, 19 May 2023 23:54:35 +0200
Message-ID: <20230519215436.3394532-1-rrichter@amd.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT047:EE_|DM6PR12MB4500:EE_
X-MS-Office365-Filtering-Correlation-Id: 6520f2a5-b0a8-41ac-060b-08db58b3b8fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Gejmzdxec58Di40tjVhaFWkCYNVvP8R1n4OeS7nP2pOLrMEtV5ZcDfXsxjzi+MfsCqJCKybpHA+4fqGIydlX0DSOsEa/paiMyRmKx9hjRK+yLL36ThQ5HnUqptFeu2iKg/vD4wIrxHloOtENIhjSkSMchenQoZpZ2zt26NVy5pI+Iw/EgcgWYok1LzM5Eu34pE6yPUi7HNIIF1VWrDaC5xfXPljvEX6K587A3rVxvic8EB3mdswJhSO+gCxrHtPIrI3nbFj24QkN0OQYetta7cwSfEuzpvjBqjA38fP5kCga5X35CdD5RDPSsNmrh4BVF/H/n0lgYgfsQzI9DcH0TgbJQIJxIzFAzLPKIUeQqSw6GBuBoq5lqSStZQ7DPih/bxcfiaghZMMsKQ5MJZgd0OQGUZccgt7igD7VZKVRlO77uh1xEPLL2vQnElQE0TM7dJD9SK4peToazIuxXnuYUQe5q0WumqiHlARES3IS988lpspBivMGIcBoJLoIBZ3R9CkvPFzgPFuLr7OyQdzjAFXJgTT9gjUp09p7wYlAhZ8RWTv9iLIx2+00Ag3Xc/2jgAGuyt9cyilWZXNEcLE3c3gSamHykb/SxASxFdTKUWNk0SAoMwZWgPL9mqhMXSWuEbjmRfh++E8g5j3fm+GgJX70olvJxHsmDd5V/HWGuw8yojt+cjHK2GK5KuhTIeAY/pqeFFtKODWvJrQ/+Ul1nrU/zLxJYzhQQMpVlIlKZJ27WzZf8SXS/1ECJXWV/JYKT+qYaZNqiFAl59L1bHLqQg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(396003)(346002)(376002)(451199021)(40470700004)(46966006)(36840700001)(16526019)(70206006)(70586007)(4326008)(82740400003)(110136005)(54906003)(8936002)(8676002)(40480700001)(478600001)(316002)(6666004)(41300700001)(40460700003)(7049001)(2906002)(356005)(81166007)(26005)(1076003)(47076005)(186003)(36756003)(426003)(336012)(82310400005)(36860700001)(2616005)(5660300002)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2023 21:55:12.8503
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6520f2a5-b0a8-41ac-060b-08db58b3b8fc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT047.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4500
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In devm_cxl_add_port() the port creation may fail and its associated
pointer does not contain a valid address. During error message
generation this invalid port address is used. Fix that wrong address
access.

Fixes: f3cd264c4ec1 ("cxl: Unify debug messages when calling devm_cxl_add_port()")
Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/cxl/core/port.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index da2068475fa2..e7c284c890bc 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -750,11 +750,10 @@ struct cxl_port *devm_cxl_add_port(struct device *host, struct device *uport,
 
 	parent_port = parent_dport ? parent_dport->port : NULL;
 	if (IS_ERR(port)) {
-		dev_dbg(uport, "Failed to add %s%s%s%s: %ld\n",
-			dev_name(&port->dev),
-			parent_port ? " to " : "",
+		dev_dbg(uport, "Failed to add%s%s%s: %ld\n",
+			parent_port ? " port to " : "",
 			parent_port ? dev_name(&parent_port->dev) : "",
-			parent_port ? "" : " (root port)",
+			parent_port ? "" : " root port",
 			PTR_ERR(port));
 	} else {
 		dev_dbg(uport, "%s added%s%s%s\n",

base-commit: e764f12208b99ac7892c4e3f6bf88d71ca71036f
-- 
2.30.2

