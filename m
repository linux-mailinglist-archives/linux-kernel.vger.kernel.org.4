Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAC725F5F73
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 05:20:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbiJFDU2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 23:20:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230100AbiJFDTs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 23:19:48 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2062.outbound.protection.outlook.com [40.107.92.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CBFE8995E;
        Wed,  5 Oct 2022 20:19:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dMVs2c/zZmOvwMwgwhXOsCepVwrfAnDtVxMdFfu3xdZRVDZMxr4OBCSbp0Qy8c/t5iEvokrl7YKhWVXEJUjRs8PZtrxJaZ7GtCL67hwx/+7+xqsxPs9gOE4EaWCGApJgQjIovidWq3+fSQ9IOxCLf33ZDM0fy5xt1iIaYAnCpMubk58rsr+1RQnTV+0RWqtVS2bi83zA5oCTBUEg7i2vqzEziMAqRhIHnT7M2DK5Onv8FhR/JQVRemOuWZELZc+R7pjSANGipkmUg7wNbOotswZWKWRWV+8dCjkz3dlM9LB3VGfyrTw5WWqy+Dd781sAAxMGqe5uSJDFVile8u60pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SLKSZcYWePeC5l62ZFoA00vICU10ByB9PN30SLGHvvs=;
 b=lVSj/niy/oARg6gzXZChUmFZFExn+oVF8d0nAVUep2BVNpi8X4MS0fWKdp69qqz4uL05CEn+pBjKK6uJ4gDpYpGf5ZHoZTIKB+GhgKWuYZ2ptka4yAsWgNbGfspg1Uky0gznA5G8JpsXorbbxriLs5jOQb2jlnNdnZx4aoYufRhaW458rEGJudOwnjx6tLGAmKsNOhms/hsyp5PtMro2wHEzG8WqBtqtWoXfX3Ntxee8q3JoUlqngoVfECehE2xjRR+Ka5EgrR/RlZBCjF5QWOjXqnMgLpFoesUnFxq4Lsxs329XrkIGMxFcL7lRWuBYncLMV2bqdd2mz2yaPwiWMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SLKSZcYWePeC5l62ZFoA00vICU10ByB9PN30SLGHvvs=;
 b=bvlNyNuXsIoJXQy+lxQ/A9lXnIEjePce69eoktovNBhJrDgP4aN1Hm4Qp5XmpAde7QfjG5SC31fSVRiaPfErQH8+ALSZXQftl/VEDxNg29VRbRyRY0irwqP+lmpj7mqqKVQUxywlAUy25sJueKy2O/dRdCndm6GQ2NPVhno49GhddGEYI5Dyq1ZqMzlgCQs7h2QTDXZjKxm0GHXC4f94KhwOVS0bguLsgkVYHUNOsLJ5GniO3keY+FkvaQWYzBWeTq0qjeVYnKiGASnl5xaOxdzjJ9/54ckjiCAmUSg9Nbilp8h/j3+t0HTlQdxXsbOzmhEyQ+xi83pZk9m+/63FKg==
Received: from DS7PR05CA0040.namprd05.prod.outlook.com (2603:10b6:8:2f::33) by
 CY5PR12MB6131.namprd12.prod.outlook.com (2603:10b6:930:25::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5676.28; Thu, 6 Oct 2022 03:19:26 +0000
Received: from DM6NAM11FT012.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2f:cafe::d2) by DS7PR05CA0040.outlook.office365.com
 (2603:10b6:8:2f::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.9 via Frontend
 Transport; Thu, 6 Oct 2022 03:19:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM6NAM11FT012.mail.protection.outlook.com (10.13.173.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5709.10 via Frontend Transport; Thu, 6 Oct 2022 03:19:26 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Wed, 5 Oct 2022
 20:19:15 -0700
Received: from dev.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Wed, 5 Oct 2022
 20:19:14 -0700
From:   Chaitanya Kulkarni <kch@nvidia.com>
To:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <axboe@kernel.dk>, <kch@nvidia.com>,
        <damien.lemoal@opensource.wdc.com>, <johannes.thumshirn@wdc.com>,
        <bvanassche@acm.org>, <ming.lei@redhat.com>,
        <shinichiro.kawasaki@wdc.com>, <vincent.fu@samsung.com>,
        <yukuai3@huawei.com>
Subject: [PATCH V2 3/7] null_blk: initialize cmd->bio in __alloc_cmd()
Date:   Wed, 5 Oct 2022 20:18:25 -0700
Message-ID: <20221006031829.37741-4-kch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DM6NAM11FT012:EE_|CY5PR12MB6131:EE_
X-MS-Office365-Filtering-Correlation-Id: 01d23d48-7123-4885-8104-08daa74992e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JIg3U34fujrnq0IM13T0OM4ulOV9ODNmqQXzIJfjWmuXpVZl1th9mhfxfhEDech0tLccnpGvCade+jSKPMxRu7oDruCw4a6U86TrXl09Q2RZS4F3V9PrLhcwe98vaXu67IqkeGn15cxlQK1883DN02+dYbe7lbEUWj3X5PlhGz6ZlUrCpTEH+HLLqWrXzj6TosvOsKdnGhsoCD2h9/MFBM94eLx+eoenAYacmBwzuVF0OcshLTKPAR6QvXqmgnPPmxPNuR4ccblAP7SjPyxIgRfZGAtZbMlBTynLXvmq+ZO9+60j3ZqanWaiNlmrDskk2rt/IS0tkFCuWcLzz5/7LgJgaNDa3Px8zQv+p8uEZ+dqQ3FWeGNXCPZsJQ44Xi4fRkeMdkHTTomw10+Q2Ka7OYcrmQqGBCrW31d1p2hye4wXWlGwGt0eLmyXnzUgjS/3PNfLJmdKiTwOaNyDEX7bB6Jzs+cZP+FCguAqwPdw/Dne3xQxs1nrieKGrF204hd0T3eRSzwqeGXnyHontn0T3LD/BVjBrmi+TEeMOH09PZVyRsiR7jZAD6uxrxNb3MGM5MbECy4EvJ58ZaNGFOj+x7wJv0CTpTe8A0935Z4kMR9ngXVrLirB7w09bk1W2lccAsWdG07q2hVQMjSP/sCwDC+JqkkdmqMlqhId2lmeK+DKAJniOPnocDv0AGuuY9P+/vuBn2TFoChqDBqQ3g+6UrXZyGtsy0onrSa2CisgTumOx5H2UeYrTLoRPC0bBHrki2uZ2kQ8G98hI7Rq2uljFQ==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(346002)(396003)(376002)(451199015)(46966006)(40470700004)(36840700001)(41300700001)(70206006)(1076003)(6666004)(8676002)(186003)(4326008)(2616005)(336012)(2906002)(7416002)(426003)(83380400001)(47076005)(36860700001)(16526019)(7696005)(40480700001)(5660300002)(8936002)(40460700003)(36756003)(26005)(70586007)(316002)(82740400003)(82310400005)(110136005)(7636003)(54906003)(356005)(478600001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2022 03:19:26.3578
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01d23d48-7123-4885-8104-08daa74992e0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT012.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6131
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

