Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF38D62A241
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 20:54:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbiKOTyA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 14:54:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231540AbiKOTxw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 14:53:52 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2062.outbound.protection.outlook.com [40.107.223.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A32C27930;
        Tue, 15 Nov 2022 11:53:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IUyvStYS9PCX7CaHeagTNyvEoOS3jE3w4NBDEtqw9SIeR4DbccnZJTTZDCSmh48v2WsfSiqMeEaR7+3l2i/AQeE6DbFNZEG+f5I9MByXa39lIwPecJgK2wEieFF0USbqZH/LtCGTFU3uX0TGpy36yKBaXW1dJziqMzW6BNBgTOEkXiLa/pZunAojuNc9YUPp7CN6VoRViqmsiM98mpjyW2f+HVUuOHjH1xmDUYorFjriQKEwENUUwabjCuGaywRfZDTuKzEmUrlFJ1siP7NcQZQnjY5c/BMKlXoHq48uLCLYUqeAnsr0GQdKWRV+KELD+CZ44ByiyXTWtTY9f3+GXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PZZJAecIDxYJNi/PEEW6yXAKM5a+NxESkCX2vkJOAAw=;
 b=mmZd34vElReKDyPmuNCocxVvJitSsG66imh1clSRBVvMspekMYpnPZJloSqJ6+WEYhLIIGWirwvP0/DXiS5X1j4cy2yQzQ6ne5JpG/wFbc56nI7IJHSD+rqB1GdOP0lz0XAzXQpIAfdGVBpuiSlIi9fOCSc7ihUaztN6VXF7X71rdq/eLUOIuHtMVo3yJzmb4v9BA3ljkrdT1+uPrJKyxYJzG9fy6d8h2SH/W9AVKuwu6xPAoorzLwPRTIcC2J996Enke2sQStpIDyDH4airbaPev2kJQD70O/YNn6g9QadHtWgnIQOpGK+GM5pI+m+fgQaPzPa56TWbd6MGalfqYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PZZJAecIDxYJNi/PEEW6yXAKM5a+NxESkCX2vkJOAAw=;
 b=X/2dhxtsVnaZV7Vyqf+KVqs2rZuCsQDUnY88cR2l7J/sVSsPimpbWon/noaqiBPcL9IJXOTj9ohK7yg09JL22VQYgPIet3AqARMZeKMitEIrHQhSCFKh9sCHAxGGO4SsE3cgGp8tzfNaUpLX7fsxhv0Gtt3/MWbTjWEZYjCpBJoM5Op0LfrAURNtdYoI9VUdBY1ZKVI6ywDWV9UVinXRxyz8Ye8BK3wOgrxiwMYg2393/XSsLiJ4EOghQOz7akLupboP6MpqNqTcd63eNqxNUrCeFRc5KDZYCnky4UskpW0Ydz+DGWhucrcB5q1XXdcNK0teo//IjgjkWiTNugNCGg==
Received: from DM6PR07CA0054.namprd07.prod.outlook.com (2603:10b6:5:74::31) by
 BL1PR12MB5269.namprd12.prod.outlook.com (2603:10b6:208:30b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Tue, 15 Nov
 2022 19:53:42 +0000
Received: from DM6NAM11FT014.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:74:cafe::df) by DM6PR07CA0054.outlook.office365.com
 (2603:10b6:5:74::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17 via Frontend
 Transport; Tue, 15 Nov 2022 19:53:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM6NAM11FT014.mail.protection.outlook.com (10.13.173.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5834.8 via Frontend Transport; Tue, 15 Nov 2022 19:53:42 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 15 Nov
 2022 11:53:34 -0800
Received: from dev.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 15 Nov
 2022 11:53:34 -0800
From:   Chaitanya Kulkarni <kch@nvidia.com>
To:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <axboe@kernel.dk>, <kch@nvidia.com>,
        <damien.lemoal@opensource.wdc.com>, <johannes.thumshirn@wdc.com>,
        <bvanassche@acm.org>, <ming.lei@redhat.com>,
        <shinichiro.kawasaki@wdc.com>, <vincent.fu@samsung.com>,
        <yukuai3@huawei.com>
Subject: [PATCH V3 3/7] null_blk: initialize cmd->bio in __alloc_cmd()
Date:   Tue, 15 Nov 2022 11:52:49 -0800
Message-ID: <20221115195253.182484-4-kch@nvidia.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20221115195253.182484-1-kch@nvidia.com>
References: <20221115195253.182484-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT014:EE_|BL1PR12MB5269:EE_
X-MS-Office365-Filtering-Correlation-Id: 265b3a67-05df-4f52-5e40-08dac7431929
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nQhnbmOx31aHci/B62eWcr7CIoggotB2ytlAyFslyKaJB0Tkdxtw8ydoA/r0IWGxPMB79uK5Yb+vAA0HRHmuDdAWCxd1h5lIlKTQl1XaLfHiftWgpk/dH+8BdVB1Mx8J4hI6tCxHnhk+N1bmSNoBlk0Etnn1L9vviaGvFkJW6eIohZkVJP4lyF4ghKk9ggrFk/gNKb5nu2pHq7fPdxuD2taj0C8nzazdCgqWDFHyAAUEJsqrh15bbg7lNNCy8WWOvpKX2KPikGBTz6LB8Fm2wBLquATjn3qINCEB0R0C7SThJYe8vRZ5ScS+Uf1/6qtNrdNL+LmKKLx5k8liHuPpzEfkmqRs26l5Mhpkx4MRvTFn/2I9UoLtE4AvXu2Mi8gu6FHEcnPA4hKG4VLCloqR6kS99JjIxy4l89G9Lm0ai+KmFC5d4QFz8XX1/EDkBg3ANySSb/gWfhNkwBoZ2YrAtGMwO/O2fGqSGw14K9pClJrOVbEtNm8dFJ85RMZPgqqKXAkn5nCvrh9BTN6JDvMZ74qxLI0oU8W9rzcOAI/tPej5ay4PuSzfIJu+SO9fuAbmesJ1n8rh8UrEpvwDBISYIh3AmplPicNk/45euMra8ZkCiKhxvaQekH+MaBnqFnl1aAaPb4joCy0h/Q3WA5NhNAgykOjjkTNLPyOv6O47CY7MRcxDHzdpk2+mREesiAlFZtSgQYGEj0pcpwRziEHpESYlvhj2eBS17SnCffarbtQli7BbiNljd1MZCyMb4M4LvBYlDBcWMGhBTIBNM2rNpA==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(346002)(376002)(39860400002)(451199015)(46966006)(36840700001)(40470700004)(7696005)(2906002)(2616005)(4326008)(316002)(54906003)(8676002)(83380400001)(41300700001)(70206006)(40460700003)(36756003)(336012)(5660300002)(70586007)(26005)(7416002)(16526019)(8936002)(186003)(47076005)(426003)(82310400005)(356005)(1076003)(110136005)(82740400003)(478600001)(36860700001)(6666004)(40480700001)(7636003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2022 19:53:42.3661
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 265b3a67-05df-4f52-5e40-08dac7431929
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT014.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5269
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

