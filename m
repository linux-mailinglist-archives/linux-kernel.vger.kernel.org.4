Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BECA263CBDA
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 00:29:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbiK2X3x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 18:29:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbiK2X3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 18:29:40 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2067.outbound.protection.outlook.com [40.107.94.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B3AD6F0E9;
        Tue, 29 Nov 2022 15:29:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OSzzlrN2blHqxTzwku1OtO3ykocWNsIUByEJ/yUDgUyQcXUVqLcCACAeeGhmN7mVdSF+vkXd+E11ivuTNmVqlk/PHgjpDwbCqjYbfBjLFKEMZVIaXP+WwUlytFcJGcCG/PdIYAVLMVd67s7BiBt4L7lKIh8TYFOhKuYd5cVBqbN6N0zp/ZVEvvfc3j0cPLAMybyUMO3Pj0Tjss8+k8eoKtYDESyW/PoQ9Q1LsfUh4ieRm87HHNpcbfu85ThuqrLrJWSqNPl+OJTb9NVAHPrHU+aMv8D8ETp9w8ZYaYfS3cRMZUq1Brp20fB7/y44LU1sPhepqGA+P0QM6ZVccFiD4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KiLAjJ+YWiKO/cZsJFmLCEH8r2kiulS+akAiHUDdbmA=;
 b=fCcBFEg/kp4G6iJEk9lY7xy+LRpy+iZ0PaY2bEcpVJANt2pr20shFb5QkMmx3axpiMb62rCDpINvaZTCdBCi6h5rupSHgYS4vaidc8l787t+xUxHQ/aZAgTu7Bjk5jKB5QqXXYQrf+iezPE3VMtSLwDZrVyrLWIUv8cJUMKQM5P/zYKngBxh4LF3KJUVjH5KYoRCoM6K6rlUhzTfbcSzwBCJ8yyLMv7Ca8OSOWrBTyOB5vlfUUQp5vYS/HMDxGJwHiaKALfqAnKkYtXiZakTrfwypvKCtNgjtJAN8uWKwEREWvMPXKbE6wzMLhb0yiswqbuxIDY4X2TGYJ4cwLGqMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KiLAjJ+YWiKO/cZsJFmLCEH8r2kiulS+akAiHUDdbmA=;
 b=YBvIj7YOnYvQnR8p6+XcDwIRSIiskI0NhPWYVaVluKEVqXtO263MxNYwK2SGAD2mUFysPGDC6aSSs0VUtz5Q5HpnzIHNtJAHp1KDLUPISuLZuBHNUMcWPTDdFD9MvJDjSz08tjvxEh+IvNCVIxmnKWAAAoxVW14eC2gkOItjl1VPKOxgICrUvzKr5hxLE9KfFnxK9M9EnK45bjCc/g44Bu1QjywclJt6Vfdbc8ZzV9QS/wgBFVnju1hsi8DI+GH09ErOrhj0289mpT5K3XE6v31BWnXITxkaXYJuPtG6diwDsTtLelIWXNHQHWZiaqpE8RgfU+O2etLkiQSS22H4mg==
Received: from BN9PR03CA0172.namprd03.prod.outlook.com (2603:10b6:408:f4::27)
 by DM4PR12MB7501.namprd12.prod.outlook.com (2603:10b6:8:113::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Tue, 29 Nov
 2022 23:29:27 +0000
Received: from BL02EPF0000EE3E.namprd05.prod.outlook.com
 (2603:10b6:408:f4:cafe::10) by BN9PR03CA0172.outlook.office365.com
 (2603:10b6:408:f4::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23 via Frontend
 Transport; Tue, 29 Nov 2022 23:29:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF0000EE3E.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5857.17 via Frontend Transport; Tue, 29 Nov 2022 23:29:27 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 29 Nov
 2022 15:29:19 -0800
Received: from dev.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 29 Nov
 2022 15:29:18 -0800
From:   Chaitanya Kulkarni <kch@nvidia.com>
To:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <axboe@kernel.dk>, <damien.lemoal@opensource.wdc.com>,
        <bvanassche@acm.org>, <shinichiro.kawasaki@wdc.com>,
        <vincent.fu@samsung.com>, Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH V4 5/8] null_blk: remove extra space in switch condition
Date:   Tue, 29 Nov 2022 15:28:10 -0800
Message-ID: <20221129232813.37968-6-kch@nvidia.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20221129232813.37968-1-kch@nvidia.com>
References: <20221129232813.37968-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0000EE3E:EE_|DM4PR12MB7501:EE_
X-MS-Office365-Filtering-Correlation-Id: a347a6e7-91d9-4e43-e06e-08dad2618eee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gPpF+uSj6OCRV6CHpJt136tRVc2M1MrzQH67cfWXaBlusKiAw0jqU98JUugZ9IXxRX+t+tX/ISoPazKP0uYpq40KnXYrSfPY0FILoX/0mFoJESyyx11zdOCqmq1b4+DYfGiA22uP9Q66rkVZHaHHp92vwO+JwRi228YA5dAJFfUKbOw6aAilMHUG4CuoJQffzkjmAEaQ36XVb62QKgNp+KdjPQJrKSTUX1AfDBvP/4E90aFUo/WEELOQA9uhSu0snDH4/WItCxY0jO7Zsmv8mbnr/wDflLbcaxkrkWTSeziLlWO0AdODpKu4yRFml775ls5ZHZyc6b/nThTrT373NZKRP6CiDx//y3jtnHoGm60F+/9iiedh/23RdT8wjh9N9k+XZDH28N4dwu6BifQlRCGM/EFOhx4ox6LuF0FkKX06tqwQ3F3EIidDJFXldxrqEmE/pq1kd8PTGqmJBOKVSjgpaw9JPOP81NziOuhDQweZ2m88cHwsbwhqa6t6gArfUXk9V1wV8oZVry3b473dOWXpGFkzTwMHq1oGCTctq5EMWX5ndnvzk+lSUu7/SZl0bhTNtsbX1k8EVG7kqzaZARzUMKEt9iwGlOFSnEGE2Xnj1Rs3N3kDrgA0pJYfYDZmStxtR8DcY0lkoqrXcyjEQ7FTRyyd94X7n239QjshiFzGFgaOQtZJ9K11G9oOOTnwp4i++03i2X8MKj3Oh2M6cQ==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(346002)(396003)(39860400002)(451199015)(40470700004)(36840700001)(46966006)(40460700003)(8676002)(2906002)(36756003)(7696005)(36860700001)(4744005)(5660300002)(41300700001)(8936002)(4326008)(6666004)(47076005)(107886003)(83380400001)(16526019)(26005)(1076003)(186003)(336012)(2616005)(426003)(54906003)(356005)(110136005)(7636003)(316002)(70206006)(70586007)(82310400005)(82740400003)(40480700001)(478600001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2022 23:29:27.5214
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a347a6e7-91d9-4e43-e06e-08dad2618eee
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0000EE3E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7501
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The extra space in after switch condition does not follow kernel coding
standards, remove extra space in switch condition end_cmd().

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 drivers/block/null_blk/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index db849e6bc475..96b8aca5abda 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -789,7 +789,7 @@ static void end_cmd(struct nullb_cmd *cmd)
 {
 	int queue_mode = cmd->nq->dev->queue_mode;
 
-	switch (queue_mode)  {
+	switch (queue_mode) {
 	case NULL_Q_MQ:
 		blk_mq_end_request(cmd->rq, cmd->error);
 		return;
-- 
2.29.0

