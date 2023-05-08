Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8AEF6FAFE0
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 14:24:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233692AbjEHMYa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 08:24:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233361AbjEHMY2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 08:24:28 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2086.outbound.protection.outlook.com [40.107.220.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C8F236100;
        Mon,  8 May 2023 05:24:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n6dXdPwchkDbgl0o27rec9UAR6QFxg86B4gFNA/oBVTjQfRnsTwrP1HrN2uej17J0HD49+BfT9UvJKQ5jIkieeQ7SPdy+G52fb+odm3J5avPh+AJehqd2Q/gFqecoQm6MbcZLkFlCPfHYap+K1EAme4lKzwPvtG7pMuNFGgc/9MNX9lijhIS7k/XpiA7Bqm5lha+2q/KyYDmcO5niBimSxr1iIcj595BsMYLbWQOmrl8AiPHn4UpZUI0G+Y0qgzIsWsaORo15aRp48M9zuSWdmweoP2uKQPXKf0svL0dLmc5xLPWJ46ndDRPSfnjTSLit8XO6DDpNtiN3HwcQjuy5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cw0qNqpL5YDmCM36wfZt5lvBpeGChb/+25X2k3ZC5As=;
 b=NjtvthoLLGqvafJNOoGUQ2VyddXJNTySYGfKhIXK1Ep1xZBrn+uYB2RJQteh/9QMNHyltMCmeVMXNIhhTpjDNPLuQO/uqgGn4VTLICCWKRTjR68XLRkRqtUCRWVM7IuGwXGL51+Ylix57cjvKVaNgUCY9RBZTA/Q84PRhLNwucJja0hQa97+6xL1D0YIhl+Z+CcsJNY8Ovulp+8FARrmUs7FZ+6eIOhkP65D2lWGvf5N1+BhhKGp8wm0oQvTGlVlzEmDOdUsC00kVHLqDz7lE6YYlE4P0RxahEpqKKdpEjAOl+rx0Aj8Fme6WkmD8pFdihKLUxvun34qnmu8jAX8dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cw0qNqpL5YDmCM36wfZt5lvBpeGChb/+25X2k3ZC5As=;
 b=PHsFJusSOb7+lCERuxylpxOfwvKjQqIxgHgJnvLy9LXwDEVEFAka70eJ+AevCc8SXYXcNOhqq3k8Z/tt+oTpEnW/xEzjb9Tij03JEhxLcc715XCIO4Vx1ifE3biOrR/WBQGmJ3kNmhAyhimz8Lm6Nqdao2kSwTGb1oEZAgl5eF4iEqT4B/ZVT71FXOdED/LOX22NJ9p7eillZ72T0nboXHJEV/rOzinN2vCIjWlKZDev94BNz12taBCy3NS8JqFGODEegvM0uNNqI4qlt9GJVOdq2jLHgjZoA4D317MyG9kN4Uyjfmq62wgxvIwQfZOIhxH7LL/VJ6JAjlUXGooBcA==
Received: from MW4PR03CA0160.namprd03.prod.outlook.com (2603:10b6:303:8d::15)
 by CY8PR12MB8193.namprd12.prod.outlook.com (2603:10b6:930:71::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Mon, 8 May
 2023 12:24:24 +0000
Received: from CO1NAM11FT093.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8d:cafe::d2) by MW4PR03CA0160.outlook.office365.com
 (2603:10b6:303:8d::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32 via Frontend
 Transport; Mon, 8 May 2023 12:24:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1NAM11FT093.mail.protection.outlook.com (10.13.175.59) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6363.32 via Frontend Transport; Mon, 8 May 2023 12:24:24 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 8 May 2023
 05:24:12 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Mon, 8 May 2023
 05:24:12 -0700
Received: from mallet.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Mon, 8 May 2023 05:24:10 -0700
From:   Peter De Schrijver <pdeschrijver@nvidia.com>
To:     Peter De Schrijver <pdeschrijver@nvidia.com>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>
CC:     Stefan Kristiansson <stefank@nvidia.com>,
        <jassisinghbrar@gmail.com>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>
Subject: [PATCH 2/5] mailbox: tegra: add support for Tegra264
Date:   Mon, 8 May 2023 15:20:48 +0300
Message-ID: <20230508122048.99953-3-pdeschrijver@nvidia.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230508122048.99953-1-pdeschrijver@nvidia.com>
References: <20230508122048.99953-1-pdeschrijver@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT093:EE_|CY8PR12MB8193:EE_
X-MS-Office365-Filtering-Correlation-Id: ed144f73-8b1e-4fda-0fa5-08db4fbf28db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RW3alzH34qVQwByG5Kii4wxqR/ZnkbokNkW918g0Db0cqW7lVIlQtTSivLeQj6BbFKNrMJCWh8/9j1jGv/YsQ09FUpNIJrjs17BFYtkNXYhMuccCUeRrbrzORZuJ+tcgp7ABtar63OENyhfMidAYpZbOr+AoDZ96o6GCHwX1RqoRs+S9Q9+VNL2ACPGT1M8gSapiabRVk01h8HQmb0IpH75YtBCzlr48hEW73TkRQoJPwoKbs8fGQJWALgG8ak7xHS53/BeUl8y5MoTVSw9lj9lgJaKGY4ohetszH9rjEs0HCk/Ku3GCupoZMh7tJZvSiNHZ/NfXZBQ3JhY6SY35ehe0XKrHqxABSIT47xBzhQB7dwD9gLbKR9zgvc1XLOlot1bZfXwGlCqwGtniNoB8KPKRjdt/GZGtuLkd/XemTsCqHJObd6YoUYDIsp8GFekWqmOr7hJbDNRgpEJRonHml8OhWLzeRdSs5/bWQ7boMhcattpLX9frhrbPtro54PMBOVyzHCfgKLKUilpF465/VIqLRmLdZMuedmpI/Ig5L3pZO23+aSJqMDjQAHMHLSQ77aJt+mWB+L201sXGQHgAgo6EMwDTzWORZc/qBOCJi1D4U1MFl9cILVePKAHOEixdhGbI1fZhM3jhaqGejxZqiGsONV5njmJ+Vk+4LpHoPHu3RDuIBE6blv/4psoSY9lyACOrd/7Nhairb0JIftuI2w==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(39860400002)(346002)(136003)(451199021)(36840700001)(46966006)(40470700004)(26005)(1076003)(83380400001)(336012)(40480700001)(426003)(36860700001)(36756003)(2616005)(7636003)(86362001)(82310400005)(82740400003)(356005)(186003)(40460700003)(7696005)(47076005)(110136005)(15650500001)(54906003)(2906002)(8936002)(8676002)(316002)(41300700001)(478600001)(70586007)(6636002)(4326008)(70206006)(5660300002)(6666004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2023 12:24:24.4287
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed144f73-8b1e-4fda-0fa5-08db4fbf28db
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT093.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8193
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Kristiansson <stefank@nvidia.com>

Tegra264 has a slightly different doorbell register layout than
previous chips.

Signed-off-by: Stefan Kristiansson <stefank@nvidia.com>
---
 drivers/mailbox/tegra-hsp.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/mailbox/tegra-hsp.c b/drivers/mailbox/tegra-hsp.c
index 573481e436f5..7f98e7436d94 100644
--- a/drivers/mailbox/tegra-hsp.c
+++ b/drivers/mailbox/tegra-hsp.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Copyright (c) 2016-2018, NVIDIA CORPORATION.  All rights reserved.
+ * Copyright (c) 2016-2023, NVIDIA CORPORATION.  All rights reserved.
  */
 
 #include <linux/delay.h>
@@ -97,6 +97,7 @@ struct tegra_hsp_soc {
 	const struct tegra_hsp_db_map *map;
 	bool has_per_mb_ie;
 	bool has_128_bit_mb;
+	unsigned int reg_stride;
 };
 
 struct tegra_hsp {
@@ -279,7 +280,7 @@ tegra_hsp_doorbell_create(struct tegra_hsp *hsp, const char *name,
 		return ERR_PTR(-ENOMEM);
 
 	offset = (1 + (hsp->num_sm / 2) + hsp->num_ss + hsp->num_as) * SZ_64K;
-	offset += index * 0x100;
+	offset += index * hsp->soc->reg_stride;
 
 	db->channel.regs = hsp->regs + offset;
 	db->channel.hsp = hsp;
@@ -916,24 +917,35 @@ static const struct tegra_hsp_soc tegra186_hsp_soc = {
 	.map = tegra186_hsp_db_map,
 	.has_per_mb_ie = false,
 	.has_128_bit_mb = false,
+	.reg_stride = 0x100,
 };
 
 static const struct tegra_hsp_soc tegra194_hsp_soc = {
 	.map = tegra186_hsp_db_map,
 	.has_per_mb_ie = true,
 	.has_128_bit_mb = false,
+	.reg_stride = 0x100,
 };
 
 static const struct tegra_hsp_soc tegra234_hsp_soc = {
 	.map = tegra186_hsp_db_map,
 	.has_per_mb_ie = false,
 	.has_128_bit_mb = true,
+	.reg_stride = 0x100,
+};
+
+static const struct tegra_hsp_soc tegra264_hsp_soc = {
+	.map = tegra186_hsp_db_map,
+	.has_per_mb_ie = false,
+	.has_128_bit_mb = true,
+	.reg_stride = 0x1000,
 };
 
 static const struct of_device_id tegra_hsp_match[] = {
 	{ .compatible = "nvidia,tegra186-hsp", .data = &tegra186_hsp_soc },
 	{ .compatible = "nvidia,tegra194-hsp", .data = &tegra194_hsp_soc },
 	{ .compatible = "nvidia,tegra234-hsp", .data = &tegra234_hsp_soc },
+	{ .compatible = "nvidia,tegra264-hsp", .data = &tegra264_hsp_soc },
 	{ }
 };
 
-- 
2.40.0

