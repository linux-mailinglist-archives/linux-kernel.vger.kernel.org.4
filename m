Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07C365F4E14
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 05:18:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbiJEDSV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 23:18:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbiJEDSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 23:18:02 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2052.outbound.protection.outlook.com [40.107.220.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DF3A71BC2;
        Tue,  4 Oct 2022 20:17:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TSG/5f7LDiieX8S5xkT/+Cid/H8enLL99upAYwMOzhzTQNVKZjkPo8SC8TmpF/EgJnSzMpiMj1U8wk59L7DPSAlOUHPIiEG/ebvErVHFXfiD9HY7PDctRz8zP5sIIhb5ww8zt5rYgYTuz2GKajohTOogWrBXoJADCPrQe2nscyVwZUG92MNlKilcvhy1zev7vTpMemKncsxjbmszvUQFGJHnZPMp7tkHUQxjQ0L8qNOfVKOuOM7yYFzvUjx77ek2Q4gSY1hc/U9PSsTuSkwVi3t3d+nNEBArdegmcRyDfnnPn9JeShhBvm9uhb2ioVGU72FsqPf0r7T1AKIdX9qvGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qu7w/oEg6+DPDhMB1iJ3xtdU1PsDIweTh1KJ3p1wXBI=;
 b=b4gAT4tnjKRq50KJ69kfuCFtNNzzi3LUwAw/XHbzaQxFHTuaoD5BURWqGk26YTR5gjal2Q8tnE5yGHhWs0t/wx1OR0BCkGKSkjgBP1lpbGkLzO2rsADuRTloz/1HJdUTvDJWMtgp8ECoZhWhqTL53KCee2zw8nfDey93jkiA6VcTsDobKslFGAuaMjHYaW2cBvEKnTM4rPEHoSYcmUlJQxLW/aZoUKEG3l1Eeaa31J0PxRby2O/RRn0r1vuEQHuOTc2sBeTbHcyi3DEPQHCs2m9qhxn8x6zYOTNGGtC0uOYBPv+iXLW5wlxcvGlvl8NgF4ur/3FgiLrg6LipGYFHjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qu7w/oEg6+DPDhMB1iJ3xtdU1PsDIweTh1KJ3p1wXBI=;
 b=rDenH2DvI5ctR/FGm71Oyj8QRoMbnC7FFkwHiIMm/X/owoARSUXZkVIKuqK6AL1gSHK0eNkNyGvZu15cMsBzO8bzbzz9uUKM7vacW4eOFsTGyiOwhLd1f9PypWAWefoZKPJm5bSr71EdXj5KTpFxbcRlh+p91eMQWRPQqk2CgrZRKtzmbqLJ19H2MewlesBcco3f8CWIg+lneET+Ejg+0wgjT/hhIf2+gjWSHZbA0i4Eiz8X5AevQBNZSpi1mgNgaYwzsVKRNTakDz95B4Meb+wvbnI1dU3mIhLKuOIwqs3s1I4s9hDP3hFnbgj74R5w9/NpSuWelSNppo1aAWJvqA==
Received: from MW4PR04CA0141.namprd04.prod.outlook.com (2603:10b6:303:84::26)
 by DM6PR12MB4926.namprd12.prod.outlook.com (2603:10b6:5:1bb::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.28; Wed, 5 Oct
 2022 03:17:56 +0000
Received: from CO1NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:84:cafe::50) by MW4PR04CA0141.outlook.office365.com
 (2603:10b6:303:84::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.26 via Frontend
 Transport; Wed, 5 Oct 2022 03:17:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1NAM11FT038.mail.protection.outlook.com (10.13.174.231) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5709.10 via Frontend Transport; Wed, 5 Oct 2022 03:17:55 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Tue, 4 Oct 2022
 20:17:55 -0700
Received: from dev.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 4 Oct 2022
 20:17:54 -0700
From:   Chaitanya Kulkarni <kch@nvidia.com>
To:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <axboe@kernel.dk>, <kch@nvidia.com>,
        <damien.lemoal@opensource.wdc.com>, <johannes.thumshirn@wdc.com>,
        <bvanassche@acm.org>, <ming.lei@redhat.com>,
        <shinichiro.kawasaki@wdc.com>, <vincent.fu@samsung.com>,
        <yukuai3@huawei.com>
Subject: [PATCH 4/6] null_blk: initialize cmd->bio in __alloc_cmd()
Date:   Tue, 4 Oct 2022 20:16:59 -0700
Message-ID: <20221005031701.79077-5-kch@nvidia.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20221005031701.79077-1-kch@nvidia.com>
References: <20221005031701.79077-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT038:EE_|DM6PR12MB4926:EE_
X-MS-Office365-Filtering-Correlation-Id: c3c13d38-8adb-483e-16e4-08daa6803294
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LVA8b/PrOpT/t8zKdTQkUwy5tLqTb8sOKiN+s6cBQspAxMWtSGpIQIivSBSzk2q8S5HimCgs34ksOrsZ7zavH3q2Cde+vwj2MI1xEbnfQL1gVq50mW4zzPWoU+OsfVhfwQVG9QV1rYjM09F43Plh9+i6IFuw61ag4zYD47MlKbgMl2q0blsMaMf5mfz42vqXLR1klSx9Lw/wurR1FNBMaio8R9PUW9UJGv0XSL3zLI5TVfmWOCT5vQNeCYGvWqBpfv4qPx5J81H3QhJDkAfsGbRjMnUACaEtUREZpLgr9GprrYx/26BlnA0ee+ub/dk/vXDvJT9n9TMPwLQtHEPPwNaE4mA1xAAwnmYbcsMOj3OG1/BUuUGEW8vlV/63tSoFLfUkZjvaXl5udRTqUJ6akNwoSksz0Ko5rYdSf2FgwrawMX+f9tLOvy3JkSYaK7lZSka7hf/omUYfUQsyRGZ4yGuEaJnFfb5+Q5l/cR08kTXgm12kiwZmpo0jXSqQ9VJKbCKlytkugCVEM32dpoTNz4t+RQeNgI74XWYbI5aLnYSArwno9Xi5iv0nG8Ry8xU6aAnKlSig5fDl92nibJ9IiCMkHlXrwkTk6Hbwq6Du+OGsCBh43VUHORQRkrvydFiUnoR7BVga55GsFSfn66RZWQSn89D+Pgm84VoJ8WIDzXHfwdb1SitPKfQvLtAHSpyPbm9FQhqq/QVay6MVdUNWPn1Ik/NgNSjz8eAW1dE4FtXpqfYzIH0tFMHIGUQh3Ed4p9vgmC0pEKnvV9hQHmMtKA==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(396003)(376002)(346002)(451199015)(46966006)(40470700004)(36840700001)(186003)(16526019)(83380400001)(336012)(82310400005)(426003)(47076005)(82740400003)(356005)(7636003)(36860700001)(41300700001)(8936002)(5660300002)(7416002)(316002)(110136005)(40480700001)(8676002)(70586007)(70206006)(4326008)(54906003)(26005)(7696005)(40460700003)(1076003)(2616005)(2906002)(478600001)(36756003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2022 03:17:55.9843
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c3c13d38-8adb-483e-16e4-08daa6803294
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4926
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
initializae the different members of the null_cmd structure e.g.
cmd->tag, cmd->error, and cmd->nq, Move only member bio that is initialized
from alloc_cmd() into __alloc_cmd().

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/block/null_blk/main.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index b82c2ffeb086..765c1ca0edf5 100644
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

