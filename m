Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40EEC63CBD6
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 00:29:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbiK2X3a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 18:29:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230024AbiK2X3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 18:29:24 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2078.outbound.protection.outlook.com [40.107.237.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6C686F349;
        Tue, 29 Nov 2022 15:29:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FuiQHGEPxGwhbntb1f8ZGpllQW2iRMry/HF9urhPB0PtKVAnMsgMsemhAVOSjBF1TCPmnCKlG9Mi/xnVnt2CehyHEXVmATTTDP7iKJwDKdRmmoO5IioTWmf4/jaVSzqEJTDu5mzWoI5dFFbc1jlgT7EppEGFs9AxDX11yK2Nc97IgLKVahISieL8Q0HMy21uboD/DZb/Vlekb4ujBhuvGBOJhzbs+wWj/OF376lvaqBa84A7Kznl8PZqiFagSxeuw/ulioieEufUu4lHHIzQMIXQO37+eQRulOt0IUjC4jNa93nwgALKEnc0ixwOzgTAw+nxSYM2O1nJCo//74Yxgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PZZJAecIDxYJNi/PEEW6yXAKM5a+NxESkCX2vkJOAAw=;
 b=mjLyK9xnBp8h266j51b/7u4yaEUzxBhRfK0ifp+4AGRyv6XFrmfInDRhft/T6gdtZAbsc2OEZLPSancewjaQWD7JCXFDzaQcx9+875O4zPZKqCrzlYjrrZSUUzEdvEAJHcWrK7MY5Jr51OHJJp896nU8uYdHmMIcnCl/ylQDNSQ7qFQUaeostqZNPiBF0mLqadD1GTp6sXKfX0THC3cXeMLakZ01Ya6D83imtxoVooJ6vk5amYvKVI1QtjUTAKSRluCpcrQixp/7NGye5ESXp4vb2noSp3+vgu1/Jr9sTBkphhqDUmszr0oNfQ2XqnV9zvV5AO9z3q6a5jhwFV3isQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PZZJAecIDxYJNi/PEEW6yXAKM5a+NxESkCX2vkJOAAw=;
 b=stAldM5I9y5cWbf99HqyrK0vIxsQ3a6qJExSmrreLvmZJJw4aLx2pFs4g30C/XLheIGLfsXj6uBrdwRMtylQTrd25obYxUIMqCrpkNW+A+hDxqciAQfavtjSZ/9bR+hnB5UH6aKBpjceT3qQY2ZFo31NQAtd8qRO/P+h9ghJSaJ2CfTwBvZqiYSpRXA7zlEnTNi3vVUMxuPTigqITMpNSVTKyv6HPd4mddXofpw3f6Jtc5oPrFhzfTF489YEl2qaXg5W0aofSa1AEhBroLq4Cv82yTrsqGyTJRAGLBQDrHa7btQE9AB6KJytVIamOW5iFC/aAop+Y94kZk4gERTrJA==
Received: from DM6PR03CA0094.namprd03.prod.outlook.com (2603:10b6:5:333::27)
 by PH7PR12MB7986.namprd12.prod.outlook.com (2603:10b6:510:27d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.6; Tue, 29 Nov
 2022 23:29:05 +0000
Received: from DM6NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:333:cafe::9d) by DM6PR03CA0094.outlook.office365.com
 (2603:10b6:5:333::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23 via Frontend
 Transport; Tue, 29 Nov 2022 23:29:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT067.mail.protection.outlook.com (10.13.172.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5857.17 via Frontend Transport; Tue, 29 Nov 2022 23:29:04 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 29 Nov
 2022 15:28:56 -0800
Received: from dev.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 29 Nov
 2022 15:28:56 -0800
From:   Chaitanya Kulkarni <kch@nvidia.com>
To:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <axboe@kernel.dk>, <damien.lemoal@opensource.wdc.com>,
        <bvanassche@acm.org>, <shinichiro.kawasaki@wdc.com>,
        <vincent.fu@samsung.com>, Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH V4 3/8] null_blk: initialize cmd->bio in __alloc_cmd()
Date:   Tue, 29 Nov 2022 15:28:08 -0800
Message-ID: <20221129232813.37968-4-kch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DM6NAM11FT067:EE_|PH7PR12MB7986:EE_
X-MS-Office365-Filtering-Correlation-Id: 27c37351-2862-4a15-3d76-08dad2618120
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gOTc4ByalVjYl2zOmmG4CXOnzE4yMOB7poAnYqXBegPD5a7VWR0hC/SJm5dNeVMJB7fc645hML6OV0JZQ7LHm8llC4eGBCtP3dOgaJ79pjYAWyFG9l5RzU4MkT3IXF2mhvB9kV91IMPl5VDfWL6VjgyhjNSStQrg5DdUeemLYqwDmhp8ssvQpGDzSM3sxA6GFP1VbFvl4qOEAk1/hE88wVQuMVtM558yfvAYNPMx9WaE+0b1pAByj5oTrZ6WSxV2+EJBajztr14QPu1OwZfDkyxp7yn1nOI96WSmZPxgQ9cqmL2DT4cKj30eggRamZjgLS7GOP+aT5dfOvHGVYh4oeQCD4MJuOS2O0KfuhdNSuH4wlzDJCrVbibg4vKR9bARbXkbvmWho8xRM8MLPUZzWNarfHv6tXFWc9DXtjIRIX2yySvB40xDnlib6QBDmpx7gsQtI5jeZucc0VjLE5nQJFRDIP6w1w6nI7gTouw+sDNHZxpmDsEAbGFcGgXCEsEM6Ww9gSvyp9rF3re/wX96VYteMtdQmgMWlgyDRREq3/UJRW7yonRMUs49tI2fpMnm4HZ2gBfnByxwz0FTHSyjg1zADVJUvHkOnKd7Be4wg4PH0PJwNCu9FeEqdiWu+Lw4TrJ0CvPpNUVKEvX56fn008cX2vvuDunCDconqjuuIMNXtUYXkm+k2rICVCnxFtfh6ep9EJvhjIZnGv5kwu3FCw==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(136003)(376002)(396003)(451199015)(36840700001)(46966006)(40470700004)(2906002)(41300700001)(4326008)(8676002)(70586007)(70206006)(8936002)(36860700001)(7696005)(107886003)(54906003)(36756003)(2616005)(110136005)(1076003)(186003)(316002)(26005)(478600001)(16526019)(83380400001)(82310400005)(336012)(6666004)(5660300002)(40460700003)(40480700001)(426003)(7636003)(47076005)(82740400003)(356005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2022 23:29:04.4818
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 27c37351-2862-4a15-3d76-08dad2618120
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT067.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7986
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function __alloc_cmd() is responsible to allocate tag and
initialize the different members of the null_cmd structure e.g.
cmd->tag, cmd->error, and cmd->nq, Move only member bio that is initialized
from alloc_cmd() into __alloc_cmd().

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 drivers/block/null_blk/main.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index fa47fab279c3..84f5ca0cc79c 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -743,7 +743,7 @@ static void free_cmd(struct nullb_cmd *cmd)
 
 static enum hrtimer_restart null_cmd_timer_expired(struct hrtimer *timer);
 
-static struct nullb_cmd *__alloc_cmd(struct nullb_queue *nq)
+static struct nullb_cmd *__alloc_cmd(struct nullb_queue *nq, struct bio *bio)
 {
 	struct nullb_cmd *cmd;
 	unsigned int tag;
@@ -754,6 +754,7 @@ static struct nullb_cmd *__alloc_cmd(struct nullb_queue *nq)
 		cmd->tag = tag;
 		cmd->error = BLK_STS_OK;
 		cmd->nq = nq;
+		cmd->bio = bio;
 		if (nq->dev->irqmode == NULL_IRQ_TIMER) {
 			hrtimer_init(&cmd->timer, CLOCK_MONOTONIC,
 				     HRTIMER_MODE_REL);
@@ -775,11 +776,9 @@ static struct nullb_cmd *alloc_cmd(struct nullb_queue *nq, struct bio *bio)
 		 * This avoids multiple return statements, multiple calls to
 		 * __alloc_cmd() and a fast path call to prepare_to_wait().
 		 */
-		cmd = __alloc_cmd(nq);
-		if (cmd) {
-			cmd->bio = bio;
+		cmd = __alloc_cmd(nq, bio);
+		if (cmd)
 			return cmd;
-		}
 		prepare_to_wait(&nq->wait, &wait, TASK_UNINTERRUPTIBLE);
 		io_schedule();
 		finish_wait(&nq->wait, &wait);
-- 
2.29.0

