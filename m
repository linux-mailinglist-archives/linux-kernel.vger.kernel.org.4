Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0C386FDCD1
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 13:36:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236926AbjEJLf7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 07:35:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236932AbjEJLfv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 07:35:51 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on20605.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e88::605])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11987269A;
        Wed, 10 May 2023 04:35:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jPrl42kBUGyY4qg/WFiuDtKq1/tRxfcAK//0Y2mr8ikoGc1u7Ea5k/mMj3TKtPlwBx+FRKbqYp2qhrkfHBfyHPf/bZPNVAn3m5l5O6lO5zz9VFGBf39KVp1QiKu1XXaeP5nkaejr56b1IOD4S4iFSqLcjfx/1d+El+7jtl7CMxFVogjLmaRoh28oIfOBhjSFj1PD9ohgBfaFY6/ehbHYLiuwShzzZGEdFaqO69QkvarqieyDbtxswI0TVM+eGRiVOR6JNMXwjCn+IySulVb8//q+8gSRYGfIqieojILgNO0KvCB9uTtZoqlq99pIv2gRUdRzu473dc7VEIwtjsQ2Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lc0dEJvQmuLzNvtqruBunVEc97MoE/kAnqMNyRaALhs=;
 b=eG2HeURG+aG/apsOCaxx1W3kSV1Jl+qnY9OUzR865fQaXbD337PmunQ2G0bXgy7xr6/Iu2lpaFupZbXgWRszEpQUNlQKO9EvZbUTm8tbcsATFUFYiM/bRtc4bAUAHo2FGejzfdNsqseILNkY62q6UmR3aTgqQsj6uFjKZnz9i+qvbwmyXqwVedn+jnPlZhWFFwIyt06EuoU2f0x7U7VsK1/GgTaR3vZO5UpwCfrQU88XM9g7r3b2e14WKbUbnIjpQhIHl2NpU2AlVz2htNiPeE1r2n9RHAqtUTZFcxivcQVMbU6PsBWaKV8tc36ulh7OrFqlWd99iagYX9NNMoQM0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lc0dEJvQmuLzNvtqruBunVEc97MoE/kAnqMNyRaALhs=;
 b=rug1a++qYoUbhkYfRDkZMVIYRigb/wMLERiF39YvMLSVPGW6UZ+lWRzQYxzjTNiPMH1LZ77v5IE4rlORPq6BwdOQTEWkB799ft9KqB/AZX6NIM+lFj7nFEaqOr9YyDLxqM+TUPdTn3zo23ILKLV+vszLXpKPqMzyqyjsQs14FDkirf48Dm/jNXm0yiI2I7n7SSzFgV40LEYr87TiSqL+gI9s/vBBPLG+sVB2gZs3yjce2gDvT1dqh8HTImiqR0iLosz6cXR6zBVwuPnFL/ZJmyBLSVERt/aFwjxFJOAqC2yIf2TUbs6UtFvzRoFQR2PMpNYK/iAVAyVA8cWsInXRMw==
Received: from MW4PR04CA0139.namprd04.prod.outlook.com (2603:10b6:303:84::24)
 by SJ0PR12MB6805.namprd12.prod.outlook.com (2603:10b6:a03:44f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Wed, 10 May
 2023 11:35:45 +0000
Received: from CO1NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:84:cafe::81) by MW4PR04CA0139.outlook.office365.com
 (2603:10b6:303:84::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.20 via Frontend
 Transport; Wed, 10 May 2023 11:35:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CO1NAM11FT054.mail.protection.outlook.com (10.13.174.70) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6387.20 via Frontend Transport; Wed, 10 May 2023 11:35:45 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 10 May 2023
 04:35:39 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Wed, 10 May 2023 04:35:39 -0700
Received: from 44189d9-lcedt.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Wed, 10 May 2023 04:35:37 -0700
From:   Peter De Schrijver <pdeschrijver@nvidia.com>
To:     Peter De Schrijver <pdeschrijver@nvidia.com>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>
CC:     Stefan Kristiansson <stefank@nvidia.com>,
        <jassisinghbrar@gmail.com>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>
Subject: [PATCH v2 2/6] mailbox: tegra: add support for Tegra264
Date:   Wed, 10 May 2023 14:31:28 +0300
Message-ID: <20230510113129.4167493-3-pdeschrijver@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230510113129.4167493-1-pdeschrijver@nvidia.com>
References: <20230510113129.4167493-1-pdeschrijver@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT054:EE_|SJ0PR12MB6805:EE_
X-MS-Office365-Filtering-Correlation-Id: 22222af1-1f8f-475c-e684-08db514ab1f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Rty/PBdhmrX1Xkg8J8pub7xScmdA86xNbwsjGl1mFMIEGIRU+qfF8fJxIKGUZmiqRJFC/7qDKnp2SFNcXKLkQ8HGjr7hcxyo91YkwqGL60OZroncLdZmaXtOvS12abo/2/DRSzHChHQk7bN0t88CpxPuSVqi+9ykxbIKpdNbI6keHy0sdgxRHeyjvZhzS7BtWx57aJEZ8PN8AnWQXSVuMiVDhPLca+z0ZaweXBpDlG3BI9g+f85hS1AZ3xk6K61oVBxW4ucADhMH0J+5GbBWhFekw6FFsU1Kb0XRAKRZdJU7OZpArSIyVc64EKQRiYhORZI2ZqollK+N8HkXpxwK1jXvaqjP18RQPOzAb9BbGu05c7/Bx0NxQkQ95Kxi+pnq5/Qg4yGa2EU2T3+2RyxwxX1Rvri/b5G8iHB69h5FDzz16bU6TOG0SBbhqWnp2lVAhds6f6g9U2thoCXrhriMGfnRz8KTJaYickahkoXHvXsSmkbOahQ03d1q/fOHMrhhx/GDRB5iT8Z1mQK8zTec2Qq7yxMlNrGkNBAnSyXdpPlkOYmknqasUKvHV0St2C7tFnraeceolFHS2KgPFcZcNMIntYs9RPT46ZMm82RyRnkACJHcwDWhepVrEhTKs/LTPUfn0nbXOC5vgMMIl8b72agpHDWeLynGvVNltCP5lCVddjCnGo5z3w1TvBIxJmiPG+dOvVzv1SR8QHE9R1xEGw==
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(396003)(136003)(346002)(451199021)(40470700004)(36840700001)(46966006)(26005)(1076003)(6636002)(4326008)(70586007)(70206006)(40460700003)(36860700001)(186003)(47076005)(83380400001)(86362001)(82740400003)(356005)(2616005)(40480700001)(426003)(7636003)(336012)(110136005)(54906003)(7696005)(36756003)(6666004)(478600001)(5660300002)(82310400005)(2906002)(41300700001)(15650500001)(316002)(8676002)(8936002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2023 11:35:45.6969
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 22222af1-1f8f-475c-e684-08db514ab1f1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6805
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
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

