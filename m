Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D9916FE002
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 16:23:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237436AbjEJOXc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 10:23:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237410AbjEJOXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 10:23:20 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2044.outbound.protection.outlook.com [40.107.220.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E91940CA;
        Wed, 10 May 2023 07:23:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GEfZlGhggPwh0vzWZgW6fKkuwwI6+nzUjuktwb4/Y46+nQtq2L1G3mUhOXX91ZAP9tlPIfAAX/ORhu3A/r9QVvL7OHllkwVA94SEGS8pIksrW2J5VRExUIzE7BjjeVplf3Ho0935jtaY97zQuespVnuibLx1r7Kg0QqrCFNaPHhX9T9zZPcz66odIFETaYz5ZyDtlHLKnva2j/btTbZemnGVfpy9Ffdy4uKFfH3KdFJ4iATTxqE5ao7ysRONAcTtPWkSQSVet0GJ9gQa7Wz6IjkBNfTJu0bLsbvkBvRtUe7PAe0010PoeXvKtxDwBmiY37MCrfirS0b7k5SOr+zY4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lc0dEJvQmuLzNvtqruBunVEc97MoE/kAnqMNyRaALhs=;
 b=YeOxcusmPFoGCz7iYw4iGWlQWKnaMcGYh/HNz+0icgZ5bJ8HxMykEe4QDTOmR0XCJHifV6DOyaPLsIuqsyKj9/TVi3DpoEf6ZCuuXEpR99H0LWddPYuSn7PpfaPGstq1k8r1E/db6Si+e1zd9C+msXhhFJZTvY9yM5QLdyWD4g/blp84bVWZ7MrNB2/oI4sVWfNGNI6v5cCuHqlbojOrBNkVqi2fDW2gdAuX1Gr6RuLo+Pts0dlHTJn7K3YWaBxkeDoHE6bf8ohKZ35ETnUqh6WYB5XNIIdKOpTvcnpRGyUN4VxaztkMliigNu5IyHtPM9VFMgLRl0HNu0/jwBzk/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lc0dEJvQmuLzNvtqruBunVEc97MoE/kAnqMNyRaALhs=;
 b=WuRyrf7dxKYm294tmgmGo3hnB9cwEXP1M/4IRuzxLXFzXpFfLxvH6A6cwjK9peUPHiF1FVPKD0CLMG37G5kXC6PsjTmQAnqzkJxfFN17kOV4Ybqfyj4wrANrMQG2DrY4Ur4B31P5dOE2zaGuR0jGdBV5EgltMZg3fBtH6Gcg3GpmUuIq1E0bi8zUKxBgLU2N/4Ih6REkLCJAvKuu3LCj0hsKhqdBlAemmblwoZMZgk7g1ZWNl0DGTy3W3930EcDJvrdPWdat9ZYgTG5QmgIQ/xaUMRbF5aa4eZAXEJQ8d41DG22cEmfwJA+ZKpUpXTwqYQpSq2UemSeOimqoaNXbuw==
Received: from MW4PR04CA0044.namprd04.prod.outlook.com (2603:10b6:303:6a::19)
 by SN7PR12MB6839.namprd12.prod.outlook.com (2603:10b6:806:265::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Wed, 10 May
 2023 14:23:17 +0000
Received: from CO1NAM11FT069.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6a:cafe::3a) by MW4PR04CA0044.outlook.office365.com
 (2603:10b6:303:6a::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.20 via Frontend
 Transport; Wed, 10 May 2023 14:23:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1NAM11FT069.mail.protection.outlook.com (10.13.174.129) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6387.18 via Frontend Transport; Wed, 10 May 2023 14:23:17 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 10 May 2023
 07:23:08 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 10 May
 2023 07:23:08 -0700
Received: from 44189d9-lcedt.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Wed, 10 May 2023 07:23:06 -0700
From:   Peter De Schrijver <pdeschrijver@nvidia.com>
To:     Peter De Schrijver <pdeschrijver@nvidia.com>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>
CC:     Stefan Kristiansson <stefank@nvidia.com>,
        <jassisinghbrar@gmail.com>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>
Subject: [PATCH v3 2/6] mailbox: tegra: add support for Tegra264
Date:   Wed, 10 May 2023 17:22:44 +0300
Message-ID: <20230510142248.183629-3-pdeschrijver@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230510142248.183629-1-pdeschrijver@nvidia.com>
References: <20230510142248.183629-1-pdeschrijver@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT069:EE_|SN7PR12MB6839:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e6f2bfe-025d-410b-c92d-08db51621922
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WVDj7l6608uGyMMOjNtd0lj56sFRBlvg6gAl/7htqWT6vVCEWN8DPQGHa0bgkd7LwtGGpf8OEJjWzX4dIMBMS6IRLfoIBIP/Ed8511i83/Wrd4HpGknnALaAqAfLl+qlgfUHMGp/CdZaAD1WJJVswvR/O3d82NvlzJm7nfq/oQPSH0dSrFs07glUdM01PsoPRev/ePReGSrMD/SccMZoh4ZiTtlZmPKjuopCv5Md+5vgYx0HuRpdPrkoLIF7E/T4O0MrL2d/20fovjM24FUuq/FHwqiZ7lA4AZHtxLY9flSk+YpakkeRn+B/oQXcvuQ2NnMeW2lXD4nhKJKtKeCJOKE+dR8uXleBobf0LxAf/MLkKGJJZWDj9g5JKNDwIVD0iMt/x5T5mFgE5xTl7RugxehaylTPGc0tXH+dxFAXsHgdhP8MN5p0P1lPKIjhFjqP/tgZQkW76ZyslFpoUCUsGBbD+g3sKTDiRXtIu8hk7RunqVZjrUl4hOTPYjxxb6m0+KF5d7kaDhu2RFkkPAajzjIZ+LwtBflart+sQh3TXQYzcYNJa+j5lTYPlfz5LXJvKUJ5HBG5upvhwqxGyNpPt4D/qVqeDYU5Ct50omwTf2KIUS1VNXwg6SBPor2WjanPbtHFW3karPZLq8HtPg2NxAgaY9+RSt5T/rVUmDTQ3vzeq7h4DJ3iXqylanzfs965lNr9W5hCiHGeJxWa7Ndvyw==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(396003)(136003)(346002)(451199021)(46966006)(36840700001)(40470700004)(8936002)(40480700001)(336012)(1076003)(2616005)(26005)(426003)(8676002)(186003)(6636002)(110136005)(54906003)(7636003)(7696005)(41300700001)(356005)(70586007)(478600001)(6666004)(70206006)(316002)(4326008)(86362001)(82740400003)(36860700001)(36756003)(15650500001)(83380400001)(47076005)(2906002)(82310400005)(5660300002)(40460700003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2023 14:23:17.2162
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e6f2bfe-025d-410b-c92d-08db51621922
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT069.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6839
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Kristiansson <stefank@nvidia.com>

Tegra264 has a slightly different doorbell register layout than
previous chips.

Signed-off-by: Stefan Kristiansson <stefank@nvidia.com>
Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>
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
2.34.1

