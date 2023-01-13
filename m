Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98398668B4B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 06:27:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234697AbjAMF1Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 00:27:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234573AbjAMF02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 00:26:28 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2051.outbound.protection.outlook.com [40.107.7.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E79961319;
        Thu, 12 Jan 2023 21:26:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nDvomM20gxJUBjdlU4Lqx82zw+jZmCG/2RjcUE9QPjtrTKlmgmY/JKbFtoXU37ahreXztNPexS2vnD1sv3c6WfxdrDZgNd8g+uFNQzj904Dvt80LKtWm7jCMjDErEK2IY0/L7qlJAlvrc5snRuUWIRjR0C2n6EU72+6986Wg2Fe4VGWe+VdmJ6hVrERAWyUbcbn4/QNu4KvO34f58kW5jQqc11pxrQCA6siu2aHYVrAHz2pfDNicvAcgnxQGRt302dia8YLp4rkKchDHYL19Zusi7gyiGuyrlKSG4+rVSbUx9qsmZ7mE+d3yt0YpGahIfeOFSXv8ep3dHeH9NQaAGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bZFW5qfP/3fmDN96yw4B3bYfhN3k1vpunXPTAW6utwM=;
 b=Fp5ExSPLVG83cbmY9ud4as8EOBkWzPv8qTWM9k80xYbxYWXwDPJdr55JCMXcezbpOOvTTW9ZKzimhf4kwZBzWGA7XyFlznSsY2OlCb5qLZMh/JNQMjLgWOlztROtAfp90xthOsQQSgKsAg0El8x/82z9jFUUtbzEH5EMWJTb56QGBeKBa63WdHiGHKB/vftXa7NEcTEx3MYIR0cGordAWhvE5WzXJ+VqvbOOpLviSMFdb6SFn8hMDgOpc06cpJNAmiz6siBKJ5RiBmQa1CSha2zreCx3kg2xoFyWlLiFsAcUanVqVwYrXG0NII6SOkLOq/6IqWpxjAfG0CcDg3c7bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bZFW5qfP/3fmDN96yw4B3bYfhN3k1vpunXPTAW6utwM=;
 b=fNPKe2gMoj+mWJkmUBML1W3m9PNA/yyYhyhuA4/H/0z7HgWiJuBEh/F6eEHKNEnY34Aj+wJ3xKesIVW4yudOAt9tuMFEvLPSCmMbdLtl0xMtDr2aMVR0owlxnwex18poC7WE7MDl+5Y2YPR6TDkLfXAguBmVkoJgrzzEiJpmWig=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by DBBPR04MB8043.eurprd04.prod.outlook.com (2603:10a6:10:1e7::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.12; Fri, 13 Jan
 2023 05:26:07 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::3a82:42b3:f1ed:5c3d]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::3a82:42b3:f1ed:5c3d%7]) with mapi id 15.20.6002.013; Fri, 13 Jan 2023
 05:26:07 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, robh+dt@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        xiahong.bao@nxp.com, eagle.zhou@nxp.com, tao.jiang_2@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] media: amphion: correct the unspecified color space
Date:   Fri, 13 Jan 2023 13:25:51 +0800
Message-Id: <20230113052551.23708-1-ming.qian@nxp.com>
X-Mailer: git-send-email 2.38.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0112.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::16) To AM6PR04MB6341.eurprd04.prod.outlook.com
 (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB6341:EE_|DBBPR04MB8043:EE_
X-MS-Office365-Filtering-Correlation-Id: a205ce03-d1ba-4d93-36f1-08daf526abf2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TBePorAdx8K+WP1fgZXKrKJ1CLK8QTBGWFZrHPks8uzf5AeDsUsxPpgIdI+YnUm2XIjmfIj+7FTeWxmP1YGYkPSGwTKyBLEftzKo29X1nFF/WVsHo3KcaB/xCSsSE6FxKrERiJhiwRc/RuThMlOcstWoseswQSwooeu0X0cmlM5TwyCkJ0++93CXuA+20RJg9T7s+QeDbAtUqqWYUy//W25euvR3OSeQpECkk5aWKZrzVGqerc7jA/g+SFmIik3B3JVk+i+BrctgKZXoiHzoKkYMS/G2ddt/YHsGRfUV4ayUX31/oE6ybZEurLNDYvvwK+CUfqw+h0VgSCTcYlpZ3xD7ZcsS5UF3ZUHVjgLTNHutChCXNq1Esoj3AL58TUkLlaVbmOqCwWZBOjbqj1ebtKdvaV86dgo8x1O7nKfQJ0oAgSEzU3FfnQ7KWnd40ylkp36C2UTIED0YHttNoICOR9V26tOUHs1LcQfoKxe6dUOWxEhf/oGPsZxLCLOzYab9xgsFPZSwmOZiJ4Irl1DHtjDMH4R9e4cNnEcsKxZiyHHtBc5Qu2s2Ln/dC2O99GxmKcAVPN6qVg7zGQ+rqsXEt08bh9rT6ookY6AT75JGTk3JsAAY/wcJiUlmnvBqfIw9dbswyIbKgb9t+0BDUJBbeuhVre2XAo8+20wrFA/2lWBqolvHN4ilgpHbi5lQTkVq700JWMGCp/xRbYpyIT78xw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(396003)(136003)(39860400002)(366004)(451199015)(8936002)(66946007)(66556008)(7416002)(4326008)(26005)(86362001)(66476007)(41300700001)(8676002)(5660300002)(186003)(478600001)(36756003)(2906002)(6486002)(52116002)(44832011)(316002)(6666004)(1076003)(6512007)(6506007)(2616005)(38100700002)(38350700002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2JIID5zU7MuSMOStY8+81b0hRmULjlBV+MDk7kyaEv2A3hOlRuQKMzs/9nsX?=
 =?us-ascii?Q?V9Uj3pSiH4cMXqTFbz2VYOj8lle9CdmoUdmE+x7D9xY+5XP9w6HWyIyWK0ay?=
 =?us-ascii?Q?6ufnLoV8eqld5fN8SWAvGREyYUW7fXzvU6GVcE/xEezdSjWBkRk2T/7GZfYD?=
 =?us-ascii?Q?npqQnfJyjqOK0lm10TkWK2osYilTQscfeIIQ0K3C4OeHFQgHLb0/Y7atu8u5?=
 =?us-ascii?Q?y+o6ZQCQjUlA0Y5/TBnnmyRl2NyjM8w0VuoCX1teRGzhjTVCgF2lRCQy0sfq?=
 =?us-ascii?Q?d8VPmrTiSU/C8+g/z5VWRS6qqYKg8iK7jI957EN0CrTdpl14TW0IgPjgCHYc?=
 =?us-ascii?Q?b+HT0XkvBgR0Rex1HsXoqsTLdRx1adb29LFJv8vMGvobq6r5Jgqnr370Q/9C?=
 =?us-ascii?Q?aSSshPSeFlo47CiTxvaTeq4Dhlzy2K5ED65+p1ToLMDS2/T39mEGGhyVWknB?=
 =?us-ascii?Q?k2QJOvdVcBdkiDlZaLuBUamYcfJ6ywGXPRC81jspu3pOyLdSXVT+Zo42YQ2O?=
 =?us-ascii?Q?1wlJZ9yC2CRYq5SsnzoJhb5vZjwC3w8ztqPgGdBD8XFHuk8zTTVovjywFmM4?=
 =?us-ascii?Q?6GTYGr8HMgWVSY2o9mH4Aa5rddYhXI11R/co5cQG0BG7r3XiQbUeIqt1yCgk?=
 =?us-ascii?Q?+FCnk9nEoIgOjhtUl4AcR0OiOcdp2MlykJyocq+L2dZPa6bnUqKAuCA7TsQ8?=
 =?us-ascii?Q?I49fAtv3kAwUgY2o51VsuAe2XQAYC/lHncbPvfuSK70O1/QeakFVZaMfI+pV?=
 =?us-ascii?Q?Q91ez88NReit9ldeE5RFbAy9AqSN7Tos4DqDKaCziJdAYf50FcHWkHJli7u1?=
 =?us-ascii?Q?DPtKyxQPyOqWLD2qIwpEgBdsV/E5HbOt2dnf9M7SbVaiuw7fBr3Q/RKwgBuF?=
 =?us-ascii?Q?7tiu++Cx7KND7a5c07zAi0AnGwH4TfD5hCoBM1+VWuEPeC/KEJzTh8cYt3Ry?=
 =?us-ascii?Q?IqTvHjYK8ApEzNkr5HZRMx8xPWZm68/Q1V2q/dXhxCYaSOLHENrX+iJy8OLJ?=
 =?us-ascii?Q?+51AziakYJUTnZ+HfrbECwwda8Cc4ZaDMVpk95zZJ7Nn0LAWDLmr7hgcBRqr?=
 =?us-ascii?Q?jDblsG/T4jNnFtlZP8+3I+PcnQbrFgzJrsM88pKdLM/k43pbQXEJq7HLULc/?=
 =?us-ascii?Q?FxnzJNpca6zzlSxoVriCqHjDyMm3ZaqBNiucy87avjElecu/KwMScO4PdMQK?=
 =?us-ascii?Q?VAW3osgcsHZEs3xsJHN+gQ+Tf5UWQFWY3ogI4V3oJ2nWCXzgPtrZucROfDjH?=
 =?us-ascii?Q?djSTKqb7aAQF42bVoOxA1vlJIHE5GazuEwMb88t3hdqf5T2o2YIhObc4GJrK?=
 =?us-ascii?Q?TtyQWTVh4PV8uegLcJcF4+yW9V9HOjamLWtRwVQqs+59Dd9uSAfYguvelcyw?=
 =?us-ascii?Q?UMoTApZ4ubmNR+97KDPqMf2p0Mktgt0NGEmWE+NwSx5hU9p24MT/jHLfeaMi?=
 =?us-ascii?Q?GPsS6sgdBgi1puNHnkmjbaM2jbtEFcrA7zG+NjBba8eSjpZWkXkJkzQ9uSnt?=
 =?us-ascii?Q?q6WnrkU9AtQkc1DSRCvBiF/zqzwnAWW0h4vngIq1f5jAHwIlXkHhTgU3s3aT?=
 =?us-ascii?Q?mxZfvu63/fGRZQAYbyVKnXCCZqSLOsmSjZwej/NE?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a205ce03-d1ba-4d93-36f1-08daf526abf2
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2023 05:26:07.1967
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ImFOAavRVQL/AoC4VrZ1V5avyPnidEXdhr6CWi83HEwVLKMTDllzU08I6As8JBOjkjBdBzUgMeKz7QrDdRLhyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB8043
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

in the E.2.1 of Rec. ITU-T H.264 (06/2019),
0 of cloour primaries is reserved, and 2 is unspecified.
driver can map V4L2_COLORSPACE_LAST to 0,
and map V4L2_COLORSPACE_DEFAULT to 2.

v4l2_xfer_func and v4l2_ycbcr_encoding are similar case.

Fixes: 3cd084519c6f ("media: amphion: add vpu v4l2 m2m support")
Signed-off-by: Ming Qian <ming.qian@nxp.com>
---
 drivers/media/platform/amphion/vpu_color.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/media/platform/amphion/vpu_color.c b/drivers/media/platform/amphion/vpu_color.c
index 80b9a53fd1c1..4ae435cbc5cd 100644
--- a/drivers/media/platform/amphion/vpu_color.c
+++ b/drivers/media/platform/amphion/vpu_color.c
@@ -17,7 +17,7 @@
 #include "vpu_helpers.h"
 
 static const u8 colorprimaries[] = {
-	0,
+	V4L2_COLORSPACE_LAST,
 	V4L2_COLORSPACE_REC709,         /*Rec. ITU-R BT.709-6*/
 	0,
 	0,
@@ -31,7 +31,7 @@ static const u8 colorprimaries[] = {
 };
 
 static const u8 colortransfers[] = {
-	0,
+	V4L2_XFER_FUNC_LAST,
 	V4L2_XFER_FUNC_709,             /*Rec. ITU-R BT.709-6*/
 	0,
 	0,
@@ -53,7 +53,7 @@ static const u8 colortransfers[] = {
 };
 
 static const u8 colormatrixcoefs[] = {
-	0,
+	V4L2_YCBCR_ENC_LAST,
 	V4L2_YCBCR_ENC_709,              /*Rec. ITU-R BT.709-6*/
 	0,
 	0,
-- 
2.38.1

