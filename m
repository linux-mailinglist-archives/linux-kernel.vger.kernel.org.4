Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0CBB62A243
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 20:54:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231725AbiKOTyT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 14:54:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231605AbiKOTyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 14:54:10 -0500
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2064.outbound.protection.outlook.com [40.107.101.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5443D2CC94;
        Tue, 15 Nov 2022 11:54:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e593txaV9FnGS1/u7+R4yIlkRtMGCsQvef1OkYlv9fsqW+QgvNTfYNHwtCEj+yJmBdK+J8WAONkgyCch7YMQkTz/UzLALfQhWHUBb2VlqXb38n5izIuS0jSheVOjwT7Z18MapbSddZcDE9m7u8v1YLsKU3aT4rMKP+FYpEwg3UeBMViOBGAL0LViGY/kAH/pkkNT73DQAJgRoIxEGLBx04a/iO5vjNxj82ICmxAXTdI4QVtd3zhDPb1meBvYryF+0GERNtj8F6dtCfzbENixIIMS/+wVC2chGV73cyzDHITkOpLLyVRUVZIxhOFeLkkWKXDEXWxG2Z/rQq8sIfsD9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nhqnQ9+IRStfTM1paQcWDVCdN1oRNJogWVL+ureO1/w=;
 b=IbeujpJzDRE62F+WmITaQymnVJXgSWRWdandKWMcHMbBCah1kr6ibAljHhqZcO+68cM3i1asmiAY4rPKnN+UgoXC7zcF1TVW6Q+EhmXQ/gGOALjVAzwt2txfo2v1J/biLqWg7i9nqLjuEjmO/cvMDXr3ZgYw9wkJ9uGTnBlIA8BgwsED9/lchAHjKAJs9q3yhUmOfbXQco3Pe1cXEx7ZDTwbguHnXRUBaSTKmm1Us+PndhUrLAI4GXK+CftRVIChUgZAmgMtvHTI/Uf0XasuUnYgFGIQrmj/viYNZzWp5YubPcim7FesGiHVKdYHrnFVsEuUhLDGmBYkJ9dMKaUJbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nhqnQ9+IRStfTM1paQcWDVCdN1oRNJogWVL+ureO1/w=;
 b=QcZaBxzCrlxwQRocyAtbTyXcp7ABZjxJB5o4lLmW3q3lGDLODMv9qeGoaCg4ujjW/vvVG12oqZ8AKs9o/c4aanIpBnykgtstnBrpbzVbJ9Xmp3Ws47sZ2n6leznsOShzAp6CfgRHv86JsnHO7oU3Yb1Ypw5pVVy1egFyBw1fiDxDGG2Y/o1f1KG9C0IbdwRkLbYSl45uDUvHFUeMiOKrOF8hhL1di5NEDIssxChJgOAcpF076J6zY2dF+LwrsA6cDjNpof2YoVuTo35POqwwifW4kyL6kAQV2X0TmlmbKLdPN/2d9W7C0D9em2YPqWnAQg4gpJF8LUCI7iYf5B4nmg==
Received: from MW4PR03CA0249.namprd03.prod.outlook.com (2603:10b6:303:b4::14)
 by IA1PR12MB6388.namprd12.prod.outlook.com (2603:10b6:208:388::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Tue, 15 Nov
 2022 19:54:01 +0000
Received: from CO1NAM11FT096.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b4:cafe::dc) by MW4PR03CA0249.outlook.office365.com
 (2603:10b6:303:b4::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17 via Frontend
 Transport; Tue, 15 Nov 2022 19:54:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1NAM11FT096.mail.protection.outlook.com (10.13.175.84) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5813.12 via Frontend Transport; Tue, 15 Nov 2022 19:54:00 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 15 Nov
 2022 11:53:47 -0800
Received: from dev.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 15 Nov
 2022 11:53:45 -0800
From:   Chaitanya Kulkarni <kch@nvidia.com>
To:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <axboe@kernel.dk>, <kch@nvidia.com>,
        <damien.lemoal@opensource.wdc.com>, <johannes.thumshirn@wdc.com>,
        <bvanassche@acm.org>, <ming.lei@redhat.com>,
        <shinichiro.kawasaki@wdc.com>, <vincent.fu@samsung.com>,
        <yukuai3@huawei.com>
Subject: [PATCH V3 4/7] null_blk: don't use magic numbers in the code
Date:   Tue, 15 Nov 2022 11:52:50 -0800
Message-ID: <20221115195253.182484-5-kch@nvidia.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20221115195253.182484-1-kch@nvidia.com>
References: <20221115195253.182484-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT096:EE_|IA1PR12MB6388:EE_
X-MS-Office365-Filtering-Correlation-Id: a9e35941-62e0-42ad-e5a3-08dac743242b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RU+0jrKku2OjmOG4jgnfQnEh9m0ZNUNpxWewfQx125JNaBCya8yrBquaFFhqK8JggkY8/aUwKJjHkW8RbmBeU984GNl9yut9lhYyNkLqboS7FY9NVG8oFloysYlYeVv8CWU1tExQr3OC2+IybOZXuw6CVgYDlngdp8AEBYrmp4heuIflAw5/HTh2U+x7h9KfLzyLsBTrGdDpn+DNtImjCUNz7Rx6MZHZmS0zHBWUOHetUBWqhWwkKTPZQRXEFXLMhnxkkIOJQL4JpE32OmScoj5BJbG8KGV7tbCLpjD3/cJpVKxQ9HNPCCE31TLb8M4+bm3FfPj/tnF1yNWGmUFPBsVCTwZEhUkWUCJt7e1LTJ/XDmJiP44WrgQPy7cjeqabUGWtPjbCeXofV/es6svXjcujVwlHTUKaH8xlNqBOjYHAy1Go+vyUYHLo4HuW8a7TXfyfiNdGVScXsTB4ACNOgm7IhffGsL4Jezj4nn3J20ZPr3MIN5ASaI7uyfUZiMVencFHgn5z9CxZnzbh9Q0pPsI3lxi7nsbcj+2mqwoCHFyX8PUPt2UqCDtTJurKsnZUW4HogS8bD9YSJ9yk20O3XEMpBHOEcEgsU45fV1/+fypRu+WZGeJIDZJIEGwSms2OMnUUIWocqFqemvNJ4sieoa52k4/iNWGPFo4LVCyXb3NyETyOqYbqI6E8A7yW3J4iWUortFps8IyAOGZyWcUsaAl4V6pgSZJQZfzwse4dDNJpe9/Eif5EV4doyX8Zh2ojXPu082nUJkS73NzxZesEqg==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(136003)(346002)(396003)(451199015)(46966006)(36840700001)(40470700004)(36756003)(2906002)(478600001)(36860700001)(7416002)(8936002)(356005)(83380400001)(40460700003)(1076003)(47076005)(336012)(2616005)(426003)(16526019)(54906003)(7636003)(316002)(110136005)(186003)(82310400005)(40480700001)(5660300002)(70586007)(82740400003)(4326008)(41300700001)(70206006)(8676002)(6666004)(7696005)(26005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2022 19:54:00.8376
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a9e35941-62e0-42ad-e5a3-08dac743242b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT096.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6388
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of using the hardcoded value use meaningful macro for tag
available value of -1U in get_tag() and __alloc_cmd().

While at it return early on error to get rid of the extra indentation
in __alloc_cmd().

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 drivers/block/null_blk/main.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index 84f5ca0cc79c..db849e6bc475 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -24,6 +24,8 @@
 #define TICKS_PER_SEC		50ULL
 #define TIMER_INTERVAL		(NSEC_PER_SEC / TICKS_PER_SEC)
 
+#define NULL_REQ_TAG_NOT_AVAILABLE (-1U)
+
 #ifdef CONFIG_BLK_DEV_NULL_BLK_FAULT_INJECTION
 static DECLARE_FAULT_ATTR(null_timeout_attr);
 static DECLARE_FAULT_ATTR(null_requeue_attr);
@@ -730,7 +732,7 @@ static unsigned int get_tag(struct nullb_queue *nq)
 	do {
 		tag = find_first_zero_bit(nq->tag_map, nq->queue_depth);
 		if (tag >= nq->queue_depth)
-			return -1U;
+			return NULL_REQ_TAG_NOT_AVAILABLE;
 	} while (test_and_set_bit_lock(tag, nq->tag_map));
 
 	return tag;
@@ -749,21 +751,19 @@ static struct nullb_cmd *__alloc_cmd(struct nullb_queue *nq, struct bio *bio)
 	unsigned int tag;
 
 	tag = get_tag(nq);
-	if (tag != -1U) {
-		cmd = &nq->cmds[tag];
-		cmd->tag = tag;
-		cmd->error = BLK_STS_OK;
-		cmd->nq = nq;
-		cmd->bio = bio;
-		if (nq->dev->irqmode == NULL_IRQ_TIMER) {
-			hrtimer_init(&cmd->timer, CLOCK_MONOTONIC,
-				     HRTIMER_MODE_REL);
-			cmd->timer.function = null_cmd_timer_expired;
-		}
-		return cmd;
+	if (tag == NULL_REQ_TAG_NOT_AVAILABLE)
+		return NULL;
+	cmd = &nq->cmds[tag];
+	cmd->tag = tag;
+	cmd->error = BLK_STS_OK;
+	cmd->nq = nq;
+	cmd->bio = bio;
+	if (nq->dev->irqmode == NULL_IRQ_TIMER) {
+		hrtimer_init(&cmd->timer, CLOCK_MONOTONIC,
+				HRTIMER_MODE_REL);
+		cmd->timer.function = null_cmd_timer_expired;
 	}
-
-	return NULL;
+	return cmd;
 }
 
 static struct nullb_cmd *alloc_cmd(struct nullb_queue *nq, struct bio *bio)
-- 
2.29.0

