Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B68695F4E18
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 05:19:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbiJEDTB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 23:19:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbiJEDSg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 23:18:36 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2071.outbound.protection.outlook.com [40.107.223.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F84E71717;
        Tue,  4 Oct 2022 20:18:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gvVpw8Ci137NTEKNeyB1jTiu8qmAwGwo5z65V8/Us/IWhbK2m/9qK8x8KtHsEdThKfNcVOFgVWu0wi7P+umEME9JnfFFBZbH+FAO8X61NbZmejSuPuCqQUuOdAq60JPduviZZhVAerSLNpJykyWJC34SAEZERntdCcPuRWTwGAFbrDRQRLVhkphZQF37EajbY/UhQn2L2zvSdLbv27k9DA+MF22ShEdUBxcY8+NqCJSY0b/SdZJUdnzrH46DaOtUrHMjLOgMGxOf6T5/Dh8E5/K4ILId+/ZFjnDHP+YdGoZpoL0cSLCgnxbyW5K4li1T4mBhvQLaJpCfvt2h/UNEFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NbCWYKu7V8cahOE1sEcOZv9ewpr5xEMqkRh/j7pg9zo=;
 b=XtO38w3rnoDRLxWsaWREq5nh5odb48qBktNYRkT6J+XnI7G1kNgeBbaBY/twkbINvP4dDBci9nJkrET/9CKAMcCew8/j3uTN0KQ0MukiCVbY58gVGzHZ3sLiAP9CCtdBJv4V/KpoMmHfbXg3jM0t9CTjUYz5UU1VHFnPcHRZ3xZzerjkU6KXrWLkwq12kSMtJngys2sRRg1GpyEhbDsZghDQLGXyoZLiOSERAXBwMAO7k8gYMpspUCPFidKz7PW162Q2V58YkcWs4PIbF7sXE1DBALT7PaUvAym+8B5y6r5DZ8A9AQGu1jsnaFLDIOuMze0dV7WaPrUwpvoLtxeYOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NbCWYKu7V8cahOE1sEcOZv9ewpr5xEMqkRh/j7pg9zo=;
 b=IJ/nMNdJqFmWarKNrek4ggN3AqLMV6+qsiPWIZWu99h7I1No1RvLPzBbM40PHimK/yOCs/RHMOBkloJ5jQCjSzrKmlAG97Hei8PLb/uxpJgjGLcYRKc3A8ItOpFaOnTgTErROFJK2r7Pbxrz56i9Eg3Ol0XhqYF5ks1wfYzXn4bxjzXYFfHrUCLe3cRbZavdEwQqag5If887ukhLYF2JpnXWHiTIHPITbgA/K/KahxFY/hUyPzHJvZLzo55RR5BjYSrag/w70tCK201gbl6zs79LA6iYpTrXYbc8P3qTP5m5p/LVJyFZPFMSftdN+jGoSxQNDVEdH06Y85xJgZuL9w==
Received: from DM5PR07CA0055.namprd07.prod.outlook.com (2603:10b6:4:ad::20) by
 DM4PR12MB5357.namprd12.prod.outlook.com (2603:10b6:5:39b::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5676.28; Wed, 5 Oct 2022 03:18:28 +0000
Received: from DM6NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:ad:cafe::90) by DM5PR07CA0055.outlook.office365.com
 (2603:10b6:4:ad::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25 via Frontend
 Transport; Wed, 5 Oct 2022 03:18:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT056.mail.protection.outlook.com (10.13.173.99) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5709.10 via Frontend Transport; Wed, 5 Oct 2022 03:18:28 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Tue, 4 Oct 2022
 20:18:20 -0700
Received: from dev.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 4 Oct 2022
 20:18:17 -0700
From:   Chaitanya Kulkarni <kch@nvidia.com>
To:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <axboe@kernel.dk>, <kch@nvidia.com>,
        <damien.lemoal@opensource.wdc.com>, <johannes.thumshirn@wdc.com>,
        <bvanassche@acm.org>, <ming.lei@redhat.com>,
        <shinichiro.kawasaki@wdc.com>, <vincent.fu@samsung.com>,
        <yukuai3@huawei.com>
Subject: [PATCH 6/6] null_blk: remove extra space in switch condition
Date:   Tue, 4 Oct 2022 20:17:01 -0700
Message-ID: <20221005031701.79077-7-kch@nvidia.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20221005031701.79077-1-kch@nvidia.com>
References: <20221005031701.79077-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT056:EE_|DM4PR12MB5357:EE_
X-MS-Office365-Filtering-Correlation-Id: a20426f6-dd3b-4fc7-9ff1-08daa680460b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B5S69MvaJDCgoZexVJFi82GvtbBVE3cNzuZ1gwOVtrNF7K0FjngWHbelLs3X+0GjNrvYZ/PdJcubvHajLh0VO7KSHTwm5K/YVQEpxUvZBWLIBMOrwc26F37Js4gnXPSyM/bEo8EQsC+ea2YPIe+JpagzVElIjNCuabjRt8HVWmgesfSwFgTTWer0YEA1PBBuSYXGaOqdQXXW6zXzw7lvzkhjVz0mjvZUEqnba+SpnjjCvbVPNbF8ciCX15PrF3mBi9PciUKvBiRNWiWWotDlmzDc5FBb0sslgiI3M2XYPeoNQ28jHFc9HCvSdX+kKV3hc25wGHNqDONaNz9IkgNhF0ozR6GfIf8o+W31UzuprYu+RVQT8sQFj2nWD7l1LloolQYcVneL67gtz92z6VAQCM3oYphvUAJQuWMcTunafSWYIxdmXEj/24AmFH2w5g1IQHWf/l21A8VjTRIn1NPLHxWDQcrxs+v0m8F7b+3F8juELL6gybti3C73b1La1UhkX9Ozv3IX3R2SP6dKUB5/UExJYUCYJPPPcnHaen5XxAheRRiPKzw2PF/TI+Vj8m0Yd35qjkHgN8r4j4g4wpwTP2BZIp1+V0CcA4sbNKjCHag4Io/u8NLgt7hjM8FIpo6YAvfF3UZ775NwBnrq7Wf+Mt/AJURM6JfsiCaWzfKO1OVPzMYky+xYH5oPUFkh9RfLmpLpVe/78/Qvx4TN+zWWHjDz6MHl2h0eu4MJ7AFdDda7MNUdoazNgubavDrtuXYmUuUpCH4OeU0BMajP1l7LDg==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(39860400002)(136003)(376002)(451199015)(46966006)(40470700004)(36840700001)(41300700001)(478600001)(54906003)(40460700003)(8676002)(4326008)(70206006)(6666004)(316002)(36756003)(110136005)(7416002)(70586007)(426003)(82740400003)(47076005)(4744005)(83380400001)(36860700001)(40480700001)(5660300002)(26005)(8936002)(336012)(7636003)(82310400005)(2906002)(1076003)(16526019)(2616005)(186003)(7696005)(356005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2022 03:18:28.5819
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a20426f6-dd3b-4fc7-9ff1-08daa680460b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5357
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
---
 drivers/block/null_blk/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index eda5050d6dee..e030f87d0208 100644
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

