Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EF8A5F4E16
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 05:18:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbiJEDSu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 23:18:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbiJEDSb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 23:18:31 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2080.outbound.protection.outlook.com [40.107.220.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5526A72B40;
        Tue,  4 Oct 2022 20:18:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b6myo9NclVCMPblcNsvAZ5EmzzztLkS2ltELZqVPaGdCB6Kji1p1ZAhpOP81d1ftJVTPyd4vNfflKuS+HDODT/wkxuWmNNp+mJuAKLie0URHRTT+mkuPY4aYgHGlBkJwhLrga1isOBgCH85F8YkjWyyNVedtj5tgI7Q5YdD1W/tHn+XXFBv743civyBQfaLn4R0v8lToVWOzh4X5SEeN19nokpWTCkX+6wxUR56HenEhY4Zum/5fxePw5z4oJCxBPP0Mj39PanC0YT9dMuifXTD8gOJX+yaNN8uxWDiD07vVTslTCWw+KkckvkAMlQIKJ5Y5twnnLNJ/VkNiTgNASw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=exeAseTkzWgC8ke2liF309aQJwvXrcgbHoddUpSqxdM=;
 b=YL2gwqXolufCVhbH1/kp5/cW5BFQMjo3/0v/FhjGqMw4TqnmsGZptDMm1vVrSbf3esSdPZGmgsENr/Qt+GOlZPmKBMfylG8HeXSKEZWGQofAOd5tMBU42OfUcqafwHFxLvUQPo0A8JoMTI+wA0Y5HGkT3/kc+K359/V4BFDo8QR85BnLcrpX2enIerKxQfTXq2KDWjg4XDcEAbmfVyxGGBFPTEUa702HDQcTQ44I35kuKIdeJGHGMwKoC5xY8ygeYuOKhulvwCvj00UcHi3JsPAL8aPaP7wEjzZhhxGHUVDm0c/JaJ6w0xh2Uu20fUBd0h1eTwTeL1xU1XH3HWkubg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=exeAseTkzWgC8ke2liF309aQJwvXrcgbHoddUpSqxdM=;
 b=J1E7h+dZyREp1xSKwTcQezAHvtzUdM4NsQxE19GR79E4rD4H85OI7uNkdGqzDE+ZlJDHvuH1TKM3hGiINHfliLUAU79NBeiw0XGZzic5QOJs1/hnYEIj310W0Zeh3D3RWJdwqb+kHiEPK8ES1bt1pOe8SAXMcLjDOzg3i0F7/S5mcWeVvjgog6pSu4nRADwK3uZncFIN/BkIxaGSCN/6goCnRno5vIg9uAnKqIDXToo80ybnXQpCgRnRFvah61Abst/KrcOOtnICUoqlVmD8tC1rfeWTA+C+Wxf9cvIu9hCA9eWD0RDxXKEhQDKzsk9iZZUKTNFdeo2v5Onztf1UEw==
Received: from MW4PR03CA0046.namprd03.prod.outlook.com (2603:10b6:303:8e::21)
 by DM6PR12MB4370.namprd12.prod.outlook.com (2603:10b6:5:2aa::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24; Wed, 5 Oct
 2022 03:18:20 +0000
Received: from CO1NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8e:cafe::bb) by MW4PR03CA0046.outlook.office365.com
 (2603:10b6:303:8e::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24 via Frontend
 Transport; Wed, 5 Oct 2022 03:18:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1NAM11FT010.mail.protection.outlook.com (10.13.175.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5709.10 via Frontend Transport; Wed, 5 Oct 2022 03:18:19 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Tue, 4 Oct 2022
 20:18:06 -0700
Received: from dev.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 4 Oct 2022
 20:18:06 -0700
From:   Chaitanya Kulkarni <kch@nvidia.com>
To:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <axboe@kernel.dk>, <kch@nvidia.com>,
        <damien.lemoal@opensource.wdc.com>, <johannes.thumshirn@wdc.com>,
        <bvanassche@acm.org>, <ming.lei@redhat.com>,
        <shinichiro.kawasaki@wdc.com>, <vincent.fu@samsung.com>,
        <yukuai3@huawei.com>
Subject: [PATCH 5/6] null_blk: don't use magic numbers in the code
Date:   Tue, 4 Oct 2022 20:17:00 -0700
Message-ID: <20221005031701.79077-6-kch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1NAM11FT010:EE_|DM6PR12MB4370:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e5a69a4-9459-40d0-559e-08daa68040d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LjtezFy/xcAqOGL2LDLxZGgkfbaNiTTSrp95bxXv9+n18ooDZh8PPZz36CFyyM8/tfVXqYCb+XYihmFPh3VdvLL/+/ALKLf+uFY1oJ4JcRlnGteaEUY6fnrzDrXdMWfAPw9WSHFF42k3mnHQs7oDinp7wM1l13B9gCz/9j9ms5GrcYCrAgvIn2Y+wqK7ic2B3mER1a5RDyeH/HW7icw60ToYqXFyJVHOumSk1uJZYYqLWf9GwLLQygr+tGny0pARGvGMPVjrBP0UWvgFIp9DkBh/O8KchFWpKbyP14eosQdr5uJSzVCTvsAIxCurMRi7iM0oz61acEQgW9jgzj8lyxLM1b5Tk5pn2rJTCRZ9yCv7HoF/qYhx5gm7Y78lyYZtDeazweS2mGOQn2Cgi/MtcrS2jIHKXn2k0djXI87RtYPBcnMZeCRjWHJSgpu1nR6IA1KOes6Vgn5ZyUhTm7XR7Zk+VDSU6wqwbJwy3iH5D5kVh5gxINnvLZKaYKYcO24caSY39Yv8bf6wFU/X4gUjypUe2OmGglFgunhC3I+bw56BslJWYIOWBm4+6ik3w4Gr/TAPH6WhxBzVgntVzkucA9z5Nu/246dG2Vf9h6M+lxYcA8LmsTjhuPesMRx7X7odITmMLF1PaaFYO2Qs8/3ZgYDofr1B72MW5s54YHPalnWWOsCkH5iwzqI2wnwmDDkvYEUccMqhSpTvxFWJgnLeQHvAYagEqvRIO2c3WwNIdeKQk4cIuA7RbEGRh7Sq732jkyFroP0LExqfwQMX0R+AdA==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(136003)(376002)(346002)(451199015)(46966006)(36840700001)(40470700004)(47076005)(83380400001)(7636003)(40460700003)(110136005)(7416002)(54906003)(478600001)(336012)(2906002)(316002)(40480700001)(82310400005)(5660300002)(356005)(6666004)(7696005)(82740400003)(26005)(41300700001)(186003)(16526019)(426003)(1076003)(70586007)(70206006)(4326008)(2616005)(8676002)(8936002)(36860700001)(36756003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2022 03:18:19.8869
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e5a69a4-9459-40d0-559e-08daa68040d3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4370
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
---
 drivers/block/null_blk/main.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index 765c1ca0edf5..eda5050d6dee 100644
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

