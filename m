Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40F5C63CBD8
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 00:29:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbiK2X3j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 18:29:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbiK2X3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 18:29:31 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2063.outbound.protection.outlook.com [40.107.243.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 214466F35C;
        Tue, 29 Nov 2022 15:29:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QFu8Fc7pVCCbIAuyo4yUGRfcFG4JdM0rdmiEpJGOqqICIyBMmXHFHxKH8Nh+NpWae8cjwiqC/5C2emNvI3B8roVlpeJ6V/oOC3G9g8w5LBTowyARk81IcQvEAu707Th1OPQSnz2JBAi/sUrNKybCIyalP45ObjezRvveCC5cNkUnBUvy4XS+KlKOBA1igpeC4dWw3aA4E8A36CApZW0g6Zpz//oit4S7sWFecfaMtXaA/tGq/tFotEUBx1dTYPoIOMH3Csk8dEuuzFSLRVYVDtKW609CvB7crjR5vLLNBkTES8WhW53lz37oNCXVCq+68KRwmgcFRT4du74pfJcuVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nhqnQ9+IRStfTM1paQcWDVCdN1oRNJogWVL+ureO1/w=;
 b=gM8NqtBYHRp3gQP/atRhJsI/+5F/7zPLJYiOi8lCDOgAS8mIs/sI+p7SpP7GDidbZKDAUDAnoRIu3ATivQW7DSPedxQszwkAe012MVD9ymkf8zjhR3filiTKnGLcE1HU47j20DuVw/fsz1KmO6S4btczNindOXYzqMu53+w7byIPzX0LmC51y6qr8ZFkWxx/VsNW4j9RTqe/BJx4YOiQt1Z0aH38JztFsEPK5GWPI03mWBKqgWIP7+tlH0nXJprtJfpg9u3brAaHgd/IYDEeAbO9f2qGAze1z4hG+9npliTTRII6NoCGEtmfLSVExYzUtcbrwWJMVBND8Kna99OoTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nhqnQ9+IRStfTM1paQcWDVCdN1oRNJogWVL+ureO1/w=;
 b=euvtf9Q53YkvEPGbOKE8riWKhoiG0JDyVVcDWMDdV0l+3LIKXNAKKohQd9MoKDnZJlD780Z20c5EyleT3/r+ImIPWF4J1T1Tam0UR2KD5zZQuePTEZQo9zuua+qmPZf7rby+7TQjL7TrwmbcDueaRBvIKOciMhz8ZxRyKKHLdO8H6TcsEdFVoMWUXoB52RRaKefb+AMyFZSiG7YgP/9vSJ7KQ8J7Z5opxYKQPqxlUhukujW2DuEWpJ/D/OWpQ4FmWCZOFIZ/PBXgW8jozb9xW662KOZtxTi4g0+bJWKszIQ41U4ToeXD1plikfdn34mOfk6NdBGXYFGoFJlXk9NL9g==
Received: from DM6PR03CA0069.namprd03.prod.outlook.com (2603:10b6:5:100::46)
 by DS7PR12MB6008.namprd12.prod.outlook.com (2603:10b6:8:7f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Tue, 29 Nov
 2022 23:29:16 +0000
Received: from DM6NAM11FT114.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:100:cafe::c1) by DM6PR03CA0069.outlook.office365.com
 (2603:10b6:5:100::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23 via Frontend
 Transport; Tue, 29 Nov 2022 23:29:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT114.mail.protection.outlook.com (10.13.172.206) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5857.23 via Frontend Transport; Tue, 29 Nov 2022 23:29:16 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 29 Nov
 2022 15:29:08 -0800
Received: from dev.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 29 Nov
 2022 15:29:07 -0800
From:   Chaitanya Kulkarni <kch@nvidia.com>
To:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <axboe@kernel.dk>, <damien.lemoal@opensource.wdc.com>,
        <bvanassche@acm.org>, <shinichiro.kawasaki@wdc.com>,
        <vincent.fu@samsung.com>, Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH V4 4/8] null_blk: don't use magic numbers in the code
Date:   Tue, 29 Nov 2022 15:28:09 -0800
Message-ID: <20221129232813.37968-5-kch@nvidia.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20221129232813.37968-1-kch@nvidia.com>
References: <20221129232813.37968-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT114:EE_|DS7PR12MB6008:EE_
X-MS-Office365-Filtering-Correlation-Id: 0087c2c2-909a-4b42-83f8-08dad2618875
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Fno9e0uUwovtI6vG3qknSsN1RN3GrhyVizEdNy9jDWfsRXl2x1Er4wA0exv2Zvml1sN9G6Lp4hYIjqxQcXGaiPABBsWx2ZfWwigDPa3ekZJ2IfjCfYGEAWuHAesCpwN3Xss5BOgecHvTYxnvY2+ejumwlH+RYFc+wML5gX7RvdPfMGcXEz0Dn0EBPmilascWa+LKYRlxxx4Nki4TOAqkwCFgCygCDXeMTSpIGwL2GQk7jYEs9FhS8W/3Y9tp2yQKDoZMOIqV3SCjwzJ3dqWZMOb+gvwcl/44uwIDqhIq+zJQYUMG0Q/1nnAbuyelxzGr76apVotHoePGKBgyLndDBWsBXBQGFwMMjz+SgM0X+6M7Wow18JpOqvGAXuy6Imc1R8Hrdy0KtK7lo1n17G7FIDap1rR87MHH3W4vb5+KgwwRpdvzriHA5UN5VX9BhR2A4wmy7MI+WdeQEo9JDcuh+W5MWJfoZ5bikrXFCmF55H++zKr/LAJjbZ7N8P6HgBWv8Wj3+KehlCIW3tFEthCU25tAx7/80bYnZcZKGOjXUl62ECPaMEAHIQb/J2H4ayB5MymxCcBcwgeF7TqdYp3E3Oi5UzzId01MuoVx85lpW8DdhAU8nSmWyowqF9E4x9GuW8TvGOSTGRd2QZ1w3J1rLx0a/CUggeibuQorYE1kAB/AOX0VJyt4KLHPZCPbPpmMX8HCREQDHalSJ30uqWTXWg==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(39860400002)(136003)(346002)(451199015)(46966006)(40470700004)(36840700001)(2906002)(8936002)(41300700001)(82310400005)(107886003)(36860700001)(70206006)(70586007)(36756003)(5660300002)(40460700003)(40480700001)(7636003)(316002)(82740400003)(356005)(4326008)(8676002)(478600001)(26005)(7696005)(16526019)(186003)(110136005)(426003)(54906003)(336012)(47076005)(1076003)(83380400001)(2616005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2022 23:29:16.7847
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0087c2c2-909a-4b42-83f8-08dad2618875
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT114.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6008
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

