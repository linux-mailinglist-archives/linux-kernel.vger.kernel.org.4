Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB38761456D
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 09:05:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbiKAIFi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 04:05:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbiKAIFe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 04:05:34 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60048.outbound.protection.outlook.com [40.107.6.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A241814D34;
        Tue,  1 Nov 2022 01:05:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ShZkEqrsUi5MV/6Z2ZiiYvRxqyqlOrYvYeudgmOLc+kO1HEZA4wCM0qmvO+Lgg7ETJgyl1cjk1wf6AHv71rg2/MMkAnhmuNeQfKvBs0O9GDk8yAS9AYiDm9kT/YO16mfeptR5g8Chnsniyo1tu+0IvBcLUgf8TOgTl7QXXtwxkmyLZRIf6D509n4J9zRyPzQ2hQ6eZMIfpGoURkrM6SYC/NX04peu68ScL1qQwPn0bP3zMiLD3eX2OSnKK/QOBfwKiKq5g7fLNszhBuU29c5cwvmgDqyrgjAv+47NGoZ9dU3caGCqLh8x9+mbz0tKfCb6xntd52H7Y6Dp4XFtRMRAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l8gubUrvDhHari4pLqZkJximV2tZ5hvhlIulFa5p52w=;
 b=OMQmvNOXoW0/lRTfXjQ+RIuLwPJ7ju+n55NPKBNNeQYAXc9CDs/45XYAh8Fk1Rg8ss5+Zl6g7qMbOVPuupg6icQm7VkKBmtNQp6jTytmsIy0CFzgKR7eB/ALVt5BHTPsW6oBSP3V08PtzdDkiJ7ZXaX70Vggx38HityUEuDEPn09G9DIcafmyzUA5XB/ItMF08gTmGXmbk6o6jh+QARZotVkzfrm+RDd045eKx+jXLLVq9F6vVS5oi4EwEd61UONybHPeT5Bqg+bjrrly+eHHxTYGq8TIJjcR39TQhoxJfcBwhnuG3llj6j3HoBAMt5XOHQphgI78l0Q+SY4OX3E6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l8gubUrvDhHari4pLqZkJximV2tZ5hvhlIulFa5p52w=;
 b=VfN63OdOej3fo0eZIoTinWfADfIzHGKPJ45IsG0EH6so4mbQ+sMnT+pyhyRq4I0JuNg/6WbP0/8/ivGDGEbqCG/QNrneE3i7Ub+0V06FrHIsvsc7H8POOQy68PQQkl6fPChWr7n7bVAFD/QQUBNO7J788Zb8gD6PLuk6iaLVrK0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by AM9PR04MB8729.eurprd04.prod.outlook.com (2603:10a6:20b:43c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.14; Tue, 1 Nov
 2022 08:05:30 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::976e:7d79:975e:8d23]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::976e:7d79:975e:8d23%3]) with mapi id 15.20.5769.021; Tue, 1 Nov 2022
 08:05:30 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, robh+dt@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        xiahong.bao@nxp.com, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH] media: amphion: apply vb2_queue_error instead of setting manually
Date:   Tue,  1 Nov 2022 16:04:53 +0800
Message-Id: <ca2a5ce24190482f33eb68fe24de5f4b1543992a.1667289245.git.ming.qian@nxp.com>
X-Mailer: git-send-email 2.38.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0176.apcprd04.prod.outlook.com
 (2603:1096:4:14::14) To AM6PR04MB6341.eurprd04.prod.outlook.com
 (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB6341:EE_|AM9PR04MB8729:EE_
X-MS-Office365-Filtering-Correlation-Id: 51542910-7765-4f88-cdeb-08dabbdfd7d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Co58pAqbeaCwZNRo8oTZns1h+3XGCQgmz5jkA2u598bvWWHD8MJZqzc1dhYr1HobCQPS7FErDAbbwZFJ+LZSHMByFQPoWcPPR8MFdDHlj0VQIapDUo7GQYTSqV1coWXkSqHtmNx/UoWYTim/0sPksk1T0nBdhcNYQGRW/m0n31VV0uifbzxBDeu56eCEjD3CVQvx5SqVDBzhYzivVSr78S+wZiw8YlRwNrAqr21rlXC0QlBLIv2eyPlQJKR03VqytyKPg0abJxI5fOH32fQ0BPTZLf3f5Jm84l192x1T9hzmrvO9IzC81NdWpQIBhdbAOnA7C6zduvOY0xba3ZYayxhKvo/CbZDOO6LvnyEwvPz4/v9YksuD6H1hiHBhcZvj5BC7JQbxT1obi1xTKMyFXY+ZxOGQMG8vHVUY++uwz2MUvYeM3sO+izSJnFOupNlRv9HiyFPhhctD7b4Bhwmeh1TZLJqK0a3XJ6+gnMV7nFYmIlpZsHOY1qWJONNDTOjZPY3HEMna3lFr0DZTQMcfd+PjoLDXjgOKjLZJ9bnixGkxD4iPyrqzzKdWCp+GzkTmtm7UGPpUgKAreR1jloBv4Gpo9Hyk8TlwbRHO/SHDZdOlbwvJXd8NmSPxoye5IsbyEK2+zJ30EbtGlDMXp11Dqsw2S652rADVAoBowNdvu+UoGfeoKe/ukYEbxPIOFtQSFkDSd7R0sxNIsqrATo/hX9pOcCZyZfIIyk+HMhPN/68HH0hLWKxXrdh3IMYdG5VRBHH18FJVwmkgMgbNE93aGg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(366004)(346002)(376002)(39860400002)(451199015)(36756003)(86362001)(44832011)(2906002)(83380400001)(6486002)(5660300002)(66476007)(7416002)(41300700001)(66556008)(4326008)(8936002)(8676002)(38350700002)(316002)(2616005)(6666004)(478600001)(6506007)(52116002)(66946007)(38100700002)(26005)(6512007)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pEKyYu1WN+ONWkc5eIX28Vh1hcGBP5vpl9HZvBLObWOVbgkGgTIEiKr6nbeG?=
 =?us-ascii?Q?IWiRL7ah/kqIS7ao5NQTl+geC/m/XmgLeseidobv+936L4EYHbaVLj8JGlD7?=
 =?us-ascii?Q?TKxvpwFkafCTWrhcodMI54uxBJE+csXMy6WSoS/bjeLP4rR5Vbd3q0+WVEuq?=
 =?us-ascii?Q?6NVoJ8Fye07+I8SQMjETniN0pn8lGtZGFe5c7kHmeqFdFvCDmt+jLHhvLz5m?=
 =?us-ascii?Q?sA45zRHndOYMMoH8utRHhcvAwoseV0UIK1Ww7ZZt4fh2v1TDzlTZftt+zcZA?=
 =?us-ascii?Q?D4YzVZ6giHbP8OufH1ryDnnXbfS+KDVujsz2lWt1VocMpoIiSAIJ4YVhxGKv?=
 =?us-ascii?Q?1I2jSciGzlhlyq3im5j5wzzAc3fZ0+WJ8OPJcvaqzFOEq3Cq8TC/q/e++yHL?=
 =?us-ascii?Q?qXxEBpnDRnia+UEmkgoy8KG89HyqglBOyVYEHgG/ZhQwQHRg80TJ88eCIo3+?=
 =?us-ascii?Q?M0GKX50uA3ywUK7TbGc3dhx+tU+o3ievdgFYux8ZP1CLkP2BBnfI91/2gCnr?=
 =?us-ascii?Q?gnYYyd/t5kuOZKDOQ8uRmeTo2F7ZU67epzvs901rp3KhMcXKew7RcnnjMQdp?=
 =?us-ascii?Q?rs5LZhOKqIVjUXTzQo9FmQCLY5oA0hqrgiN1936SPd2o0BcxRu3hbK57IVVP?=
 =?us-ascii?Q?ODUXKasXh4i1qe2TLpMfXP0zGEbwRyhMhIIelpLoCAx2snrns6QQjpAClZlY?=
 =?us-ascii?Q?qSaazAiueMNTc5JwXo/SUhx8dO2Tj1MwTOFTlqSGvejtJfV+QBupI+jKWEp9?=
 =?us-ascii?Q?tKiZYCr0pnWPRWKo4jKsYvPd1Q5pBDSKvwDzyNiBoUXSXsWYyBeruE6rL7Py?=
 =?us-ascii?Q?vVXrvpDwm04bZICA4ydu9LejBYB1+/kk3aVgop1TNVuwPY5hOk3RvnFEAJ30?=
 =?us-ascii?Q?iKYOuYTWAn8iqm+V8BJEryVhuoKqez6msQcMTLVhSBeroe0ks9uXVd1ZFwVE?=
 =?us-ascii?Q?rHCxiT7iVdr9IE6OgTJCzPx93/k9T3Dk90X10jpodedkUciHjQZiqukdCw8b?=
 =?us-ascii?Q?g9+tU7uGv18S1ddfYHaSBfQFFDRrpvYYcJ5599CU2NGXf+oUZfcbPOvy6Pz8?=
 =?us-ascii?Q?PALDwu2HXVXEuNEsNvsU4N/QfeeFs3C/PG8TZ6GIdd2aHhAb0j1/klFSvoa4?=
 =?us-ascii?Q?FLIbVRBNIeFQlu7Ad6DugYXYVzAG+7ilqROSpr5ygliOdel3nwk2QS25aXJ5?=
 =?us-ascii?Q?5UFNndW+mf5fqjoQN9PIFcud7cE9uwI4GyhZLx9/gpb9+OWAq1oyPVEQcbry?=
 =?us-ascii?Q?XgzoxT5Rd15kkrqFSCyNM9MeKBdER3t6NihfnCjUfqt6Fm1fQQJhA/u2Tz6U?=
 =?us-ascii?Q?8RjURLtaz+uLLUVnQ+34a+yfS+LELYR4IFXZiWozkVyFpTdhrGhzYh+Ijx17?=
 =?us-ascii?Q?3QsOaxN4dSXdB8pAd6lYhD18dTV0+BC9y3s/pYQ+g4JkvmSdIQjXXjrlAPZ5?=
 =?us-ascii?Q?Hk5Jcr04RjhdmuYHk6jS+Ho6h9t7qEK9P8qVej+2QP7KwvAoJBjKWz+77nYi?=
 =?us-ascii?Q?ELrUs/Gq6c98O1AZgA9aDZ8hfqYTEJjI/Hj3vXt3g0WSiizaH8vHmSdJG2aY?=
 =?us-ascii?Q?DabEraW9Bkna0YNP4sFHARZMeW0kgwcuKCunU4Hw?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51542910-7765-4f88-cdeb-08dabbdfd7d5
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2022 08:05:30.2529
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WOvT3niFHa4U//mGnxxc63tw1gaa4E5Lo41farAcfGnARmhtaYX8EqCJp4qGWtUDON+V06ADzWW5uM+5tqpzXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8729
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vb2_queue_error is help to set the error of vb2_queue,
don't need to set it manually

Fixes: 3cd084519c6f ("media: amphion: add vpu v4l2 m2m support")
Signed-off-by: Ming Qian <ming.qian@nxp.com>
---
 drivers/media/platform/amphion/vpu_v4l2.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/media/platform/amphion/vpu_v4l2.c b/drivers/media/platform/amphion/vpu_v4l2.c
index 845fc53d8937..76312090fc8e 100644
--- a/drivers/media/platform/amphion/vpu_v4l2.c
+++ b/drivers/media/platform/amphion/vpu_v4l2.c
@@ -65,18 +65,11 @@ unsigned int vpu_get_buffer_state(struct vb2_v4l2_buffer *vbuf)
 
 void vpu_v4l2_set_error(struct vpu_inst *inst)
 {
-	struct vb2_queue *src_q;
-	struct vb2_queue *dst_q;
-
 	vpu_inst_lock(inst);
 	dev_err(inst->dev, "some error occurs in codec\n");
 	if (inst->fh.m2m_ctx) {
-		src_q = v4l2_m2m_get_src_vq(inst->fh.m2m_ctx);
-		dst_q = v4l2_m2m_get_dst_vq(inst->fh.m2m_ctx);
-		src_q->error = 1;
-		dst_q->error = 1;
-		wake_up(&src_q->done_wq);
-		wake_up(&dst_q->done_wq);
+		vb2_queue_error(v4l2_m2m_get_src_vq(inst->fh.m2m_ctx));
+		vb2_queue_error(v4l2_m2m_get_dst_vq(inst->fh.m2m_ctx));
 	}
 	vpu_inst_unlock(inst);
 }
-- 
2.38.1

