Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E7555F5F76
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 05:20:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230112AbiJFDUf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 23:20:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230113AbiJFDTt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 23:19:49 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2057.outbound.protection.outlook.com [40.107.102.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 505F0D96;
        Wed,  5 Oct 2022 20:19:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i9xZc56r1VdSAuALoy0FDHoboQriszuVrK2rXe0fHCyGViLOXw53/E2ntWhlEcwPk6+CX98AMpL9qMpzB3UUymz3W+wKqA7oFygKXAXXw8igUcrGaU5/Hb+PESHH2VjHh4YgHuCDHSFbFopIezBWTBFjOSnMBskkb7gwXOVDrRLgqeCRZ0JQEPTjyl1v4cfXAVPO9FeZoNo8IisKrk1hHiwnR4VdK/NVxW+I66ObTyWQ70RpMIQfs6XjwIUszj8R1xgtS15ZwxAxYtASHFIO9oSxdlH90VFnH5vA8n3g9KklZ2BTYqHKGm7A8DA5tMpl/hCO6Fj4FpUjSvWGTYGo+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q8yRQ0Dvn2WSh+NQSHOCa6FnoS/37bVJD2T3lt91ap8=;
 b=kaeY0ToL+su5aYp2EdCwVCzVXW581dEpsF0L3FRrxT7v9O3w2JPdNhRIdaAu5jyS+o1SmWNFRtUY/VZcuQi9yTbcrcDpmoowpY7fVahBGeNhjWvpwTrYqOkQ4DRn2tkNsLveB0iwf1UJlv4M3i3K+2AUdzspmwSzI+PAT3UKMZzcUwBPEouvR2Nd3Dd+svd73uS4sWbdj/v5dMras3LsiOPSjRz+Yk8oZ46ZQ9wdZ/SD4oTNdRzclvIWNA0lzYBi5dq68U5IWS2elTqwxDL6QrDfrDfDzcmdxjsOb9ZjeBxiDQGx2fhstgliwRr7ogbAVq3DcKR3NEQIzkXKusnUuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q8yRQ0Dvn2WSh+NQSHOCa6FnoS/37bVJD2T3lt91ap8=;
 b=bOvBLvcND2ZOSIw+wlqTGQgGq5GgbhGR8Wc+XtgrjdZ4+CU4HZlWuvY3TD3ssl3DT24gsdDqLUVR6hXVTQyVP6hntE/0Sm+c6cPp+PFIbZ6UCpes1RNGMilNDJ68IPWL7mDrLF+ciPvzC65taY8bXYtq52V9gB233IxNMHfMerIAFhfCjcNo+0F3mLgxF7uXeW2ne1cpJ5a45E7g2sDxQRjRCs0RzTJBPGSnQY8/MNJEXU6wnJ4HIiQrHkwWAuDiYAsK2NGdxROEgdpOCyW8Ce27/LfXKRSTUuGCsY2baJirRHfno0S+kxG/8+nFmsMAeTDJbr0TgF66LsIkeRh2qg==
Received: from DS7PR03CA0208.namprd03.prod.outlook.com (2603:10b6:5:3b6::33)
 by SA1PR12MB7270.namprd12.prod.outlook.com (2603:10b6:806:2b9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.28; Thu, 6 Oct
 2022 03:19:33 +0000
Received: from DM6NAM11FT059.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b6:cafe::2b) by DS7PR03CA0208.outlook.office365.com
 (2603:10b6:5:3b6::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24 via Frontend
 Transport; Thu, 6 Oct 2022 03:19:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM6NAM11FT059.mail.protection.outlook.com (10.13.172.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5709.10 via Frontend Transport; Thu, 6 Oct 2022 03:19:33 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Wed, 5 Oct 2022
 20:19:26 -0700
Received: from dev.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Wed, 5 Oct 2022
 20:19:25 -0700
From:   Chaitanya Kulkarni <kch@nvidia.com>
To:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <axboe@kernel.dk>, <kch@nvidia.com>,
        <damien.lemoal@opensource.wdc.com>, <johannes.thumshirn@wdc.com>,
        <bvanassche@acm.org>, <ming.lei@redhat.com>,
        <shinichiro.kawasaki@wdc.com>, <vincent.fu@samsung.com>,
        <yukuai3@huawei.com>
Subject: [PATCH V2 4/7] null_blk: don't use magic numbers in the code
Date:   Wed, 5 Oct 2022 20:18:26 -0700
Message-ID: <20221006031829.37741-5-kch@nvidia.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20221006031829.37741-1-kch@nvidia.com>
References: <20221006031829.37741-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT059:EE_|SA1PR12MB7270:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ae254e0-0ad4-4c15-3390-08daa7499724
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3Pp/R7p7z1hiT4NHWtK1vB/knaoHRl9MZyC01XQcsLccdw77TT66BzsCuZflYtsZytT6idUBwdAJz1nJT7y3InABcySm5KKanMsgBHL1CVzy1hf5nCueUEQRsMmV34jwNsYlwQQ6hq9X1+ajqyajBP2iA2n748lyPLSCTC8GDjeyZUf1PgEfrSK+mz5ZWX2I8E7/+BfdvgyDM2eREJW3bwkmM4BSFDLOHl7KYgZ68FNskDxrgWEkN5B3IC/qCI4wSskfYrs2h1drWqge29AefflOpZJp0ZAo1SHDx1vfqeN+3I1YWidXa2pIt4ooEB+/VxsjXCnIfHztUx13fJo0Re43kNx+oiSFKlUwS1Ac/Ig48B5gDgIA51PCD7oSpoGIMGiJ1wbJ0mkHV3UnoaJD2ZfPPJ1doa/NxUIGSZecf+HOdr0wpEdZSmwBK1tSsbCg+lG2AhynoZVGmmFPjEuFQv7WefYoPvH/om9DG2vM+YQ3PZlrmJevE9ZLQFHpHLrt4s+JOYNKz1Jxs17oeHEu3HkGv4df90xxS6lI1y0NN4mxL+T8g4m0JfP8+w6lcotnOEgdHhrld+bK2X2mRNQNGfFz4bI7IQAihr7HRjWT1R1ehyuSVT2yp3Bc0O5AWQZWwrdXHHZm0bQMvOX03oNoBXsG46sY+gZ9ZzvALJFSYe5EHCdvOtX7D3jI1CAlC7i4DI69GNCP9rqf2hiDjxAldzAbYj6AO/nqeU8MDlOit5w/fJR3MA/JX1t6AgpTLLHo4VpJe7vBWmnEWu5NPhZIuA==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(39860400002)(396003)(376002)(451199015)(40470700004)(36840700001)(46966006)(82310400005)(478600001)(26005)(7696005)(82740400003)(7636003)(356005)(36756003)(83380400001)(1076003)(36860700001)(2616005)(426003)(186003)(47076005)(336012)(16526019)(41300700001)(8676002)(7416002)(8936002)(2906002)(4326008)(70206006)(40480700001)(40460700003)(110136005)(70586007)(54906003)(316002)(5660300002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2022 03:19:33.4967
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ae254e0-0ad4-4c15-3390-08daa7499724
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT059.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7270
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Insteasd of using the hardcoded value use meaningful macro for tag
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

