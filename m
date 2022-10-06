Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1C345F5F7E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 05:21:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbiJFDVM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 23:21:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbiJFDUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 23:20:18 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2089.outbound.protection.outlook.com [40.107.243.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9348EFD1B;
        Wed,  5 Oct 2022 20:19:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UJ2bFlS6cMTVKE+RQWzVM0DrRr4pfycGqhj68o4mSNOQLlIczdlj13i3WDIynGuJWx8kl2DQfgSd1XK45+iQalQ4qcgaU20scN25Wa/ljV970bpfjuOBSxhCnc8gbBZwR8y+jCssazZceRiOti5o7UeboJVPdQhEU4R0J0c9UN3nQ5yQh4EePRigp/iSQPOZ0JstEgRPoGc7exHSOBjYuSOHsP4GeC7CqCr+0TkFsSsKloxyk6acYGGqjYXRqjapWP5GUCvXP5Zyqof6CDBotwNKagRIAHt4tfYYoCNu7/6frApA73UqBrfkZq0VCt5uYJwGUQTR97f8nEKA4WGlJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KiLAjJ+YWiKO/cZsJFmLCEH8r2kiulS+akAiHUDdbmA=;
 b=IX+xbbfntfGp6qSLeWi/TiLE6ByMSFVgHyXWTgWKkJRUiwwZ9DihHvsFLOCbXe7osKY4lyVJzEdU89DxrU0QqzZ0NZH1HJZY29RjuAGj0jycykzCId3x7Mxzb9T4wCSrWHM3wV2iAgkTSqVlDWbywVQqyetnsYYn7pkyVQB2FGjp0hHrMZBxRifeUFrdpS4w2ovs9RcRhaqch9u4mpV9stC3uzUb00p/oogM+F3mf1RvR5r9kJR584Q+BjpZbOx/RX1WlTgifhpz/Xr5W1QsbxNvIPrDlKgugkJpZMS0POzL0Ppo4MrxkB1Qm22wazRigu3zPxwys+8vlNjyP2ALPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KiLAjJ+YWiKO/cZsJFmLCEH8r2kiulS+akAiHUDdbmA=;
 b=GPQ4xow/n0jFeWYi3z9AMftw/F08w1TGKqHZHuwtgPhVTwyIrv6PbGMCkEUL/FxMqHn8eq8r4llQxJ4QTnmvygTXBQlEWwzy3A4R5uW+OkmwnlOpUEBTEUMuguaMMqdaQQEmuvUAvC5+wxYG9rufExOXJlWwuKI/rwdvZHqoToGa5fZxWzax/fzTCQAkineT11H82U3r5+W2lw8J3pr1pZEMSL1jaaTtGYUKjKS7d0BuV9R2htYQ6OMuk3OU9Iw9AYZGNH+VlKgg3mggyyieTjWV8EWgiykt1yzeo3y3O3tCDp16IPyrwwP3h3GiZ7j6QUVT4WhjVRUw1bJyD2HJJw==
Received: from DM6PR18CA0029.namprd18.prod.outlook.com (2603:10b6:5:15b::42)
 by CY8PR12MB7313.namprd12.prod.outlook.com (2603:10b6:930:53::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24; Thu, 6 Oct
 2022 03:19:49 +0000
Received: from DM6NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:15b:cafe::61) by DM6PR18CA0029.outlook.office365.com
 (2603:10b6:5:15b::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.31 via Frontend
 Transport; Thu, 6 Oct 2022 03:19:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM6NAM11FT055.mail.protection.outlook.com (10.13.173.103) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5709.10 via Frontend Transport; Thu, 6 Oct 2022 03:19:48 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Wed, 5 Oct 2022
 20:19:37 -0700
Received: from dev.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Wed, 5 Oct 2022
 20:19:37 -0700
From:   Chaitanya Kulkarni <kch@nvidia.com>
To:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <axboe@kernel.dk>, <kch@nvidia.com>,
        <damien.lemoal@opensource.wdc.com>, <johannes.thumshirn@wdc.com>,
        <bvanassche@acm.org>, <ming.lei@redhat.com>,
        <shinichiro.kawasaki@wdc.com>, <vincent.fu@samsung.com>,
        <yukuai3@huawei.com>
Subject: [PATCH V2 5/7] null_blk: remove extra space in switch condition
Date:   Wed, 5 Oct 2022 20:18:27 -0700
Message-ID: <20221006031829.37741-6-kch@nvidia.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20221006031829.37741-1-kch@nvidia.com>
References: <20221006031829.37741-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT055:EE_|CY8PR12MB7313:EE_
X-MS-Office365-Filtering-Correlation-Id: cc393655-875b-4ef7-87c9-08daa749a03f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EJxP0IR9FKm2rj8DPrOhVWrO7JaHBhxnVfPSCTf4ZMaR3n4mbqI+r4nUUSv4LI8KWk8eMT+bxQnld3jW7gJoOxu4WgUNvrSdP8UM96olSqk/YpSlSMwNRDScjxduVx8a5lLjGFbs8og6ksrZJh0d4LuXo8Fxlce8q0BN1v9U0MKa83DRWVM9IAm0cvJZZ/6XA3hlFmX6+nk3Eg6HmdfN7l6tYmSj6Sh7zy58MmLcnxT/F+Yopb+njgj5BSALFotYHKn/uUgRsPIsxr0UnMcFJcrHhci248T2CzSdXv3fzqCaq+uckjbtRwFrSIP00AFpw0kPzUx8hDT3uKKzQbFCQfasAfZABU9psTZ5Hku5zShIGmhmFmUxt6RLcECoxDivS7zzYbI2oBza/J2DX9y41y1m0WD5acbE+TFrXeTsiSImFfdLJlCvS+6s2D/Rx82LVonDAuuE7+H1lkOt3mdTJk2qBahIc78KO/+qOrDKvpi6PmFJh5GLMBplt6G794dD0yiSS+kjRMBZDWRYDJ+VNeEZqvOrcGOi413mzQbvTz9s0k23CyFo7N/C+QRc6lYlWcMIyEbKb1AgR6FauwOoBmXJboanUVfPbTh8OyUtScagzRtfqNf//YfvHs7V65GmJq3MnPAnL1DdEUbXWyeavThJ5MARjhg0Kt3tCoaZdGF4PFZFnx68zuiTn4YnLiBoAS0pxjXQx22odp3M+mM1+agqIEq6IFp8ol5ZfXegITKKCAOFVruPqSshPVa0gGNnAAvc9X0GfrDJtYLL0Rjhvw==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(396003)(39860400002)(136003)(451199015)(40470700004)(36840700001)(46966006)(7636003)(356005)(2906002)(4326008)(54906003)(316002)(70206006)(8676002)(7416002)(110136005)(70586007)(8936002)(4744005)(41300700001)(2616005)(40460700003)(186003)(336012)(16526019)(426003)(47076005)(40480700001)(7696005)(26005)(6666004)(1076003)(36860700001)(478600001)(5660300002)(82740400003)(83380400001)(36756003)(82310400005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2022 03:19:48.7753
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc393655-875b-4ef7-87c9-08daa749a03f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7313
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

