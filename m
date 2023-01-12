Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF90A666D8C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 10:10:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238488AbjALJKt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 04:10:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236069AbjALJJw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 04:09:52 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2040.outbound.protection.outlook.com [40.107.20.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29CDB517D2;
        Thu, 12 Jan 2023 01:05:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c2BHJKBEiQuLwlb2aZm2Z0qiS3AAp13szarBIwtQ2EHrOAlSUPkbej13w1aKkYVWmWVhA2xF92W7lciPQ/uTPznNgpDlhfmrgKJ8LmZ2YMukdZXGjBu6LiJZiwvy2QSoCRHJ6DOHDSSpDpVtDMZn9skpl3RZBaobtiwMs4RtrGT3wmwyS1G/Z2GMDQib8aDthHCaskrMaeYs/Wlq7CbMGDbcbSjivJKrMNDQzOno23dClqxFgNoC5BigkfmBX7D6kQFu6blnnyyYeOQUCQaE+k72jx5CRDUKtTmpeX4yNBSGUgFiixvr4DSpJqp95WxVGbUP0AzSkPobNeK17afFng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fmo9r4dCtCA/pxiFPT/rVXfK/Ozo6bHQOtSI5P6fCwA=;
 b=EtGkFCBRA3YG5FDHsZcVM1NHGB6BJv1zMliQsgZ4W7yR2A9/bOEzL0J/s8oc2woABl5VhQlFRiTQPdHKmAFVG8z/3uDCBKwIl+jjYBJOh9GlElJQiZKuFif2H2UdBJY4qm4iFNiwoHhLNmHu2sfBVy+DItK32FlCqfeeuBdys5fSFahdN1WRol32V9EW3MnMbfUbDdzCJvwuGBoZJrBrydAbcKCqw+fHaJF1fEOXsMv9U4bbedAC1cyKiEKh4zDGPrNXcXD4pyfFbmx2ZtZnHaIW7LfqR4B7QpoNAz2UHbrw0F+QbNurt7U2/q7JtGtFCxcPB0JEISrGBAZ7hPvYMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fmo9r4dCtCA/pxiFPT/rVXfK/Ozo6bHQOtSI5P6fCwA=;
 b=AzfyT4SmOWvHif3VUY2cBmgQ6YKE+gn8k1adgcjIl7Db1yupYAtgk9zqhdoOUxUtpcsmOCNgoFi6Gzdm0AgpRni5FkbxuBp99ukHFN+o8rKcp5ZLe3ttWu8Xe5Nv9zQ2n904bWUmgbbSSBd+W20rgvGNgBp2B+ktl9XtIx2M4vk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by AM9PR04MB8875.eurprd04.prod.outlook.com (2603:10a6:20b:40a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Thu, 12 Jan
 2023 09:05:15 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::3a82:42b3:f1ed:5c3d]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::3a82:42b3:f1ed:5c3d%7]) with mapi id 15.20.6002.013; Thu, 12 Jan 2023
 09:05:15 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, robh+dt@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        xiahong.bao@nxp.com, eagle.zhou@nxp.com, tao.jiang_2@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 2/2] media: amphion: support to decode sorenson spark video
Date:   Thu, 12 Jan 2023 17:04:48 +0800
Message-Id: <ab85e597c37aad849480bfe912d5e06aebc51726.1673513975.git.ming.qian@nxp.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1673513975.git.ming.qian@nxp.com>
References: <cover.1673513975.git.ming.qian@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0200.apcprd04.prod.outlook.com
 (2603:1096:4:187::15) To AM6PR04MB6341.eurprd04.prod.outlook.com
 (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB6341:EE_|AM9PR04MB8875:EE_
X-MS-Office365-Filtering-Correlation-Id: 45814b56-dd3f-49fd-bb8d-08daf47c1ecf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xjBDMsPhl1OVeStKllHLvsMobhcLVc3yBymeQMwE6Hp8AfJ7UKQpqLcHARR1oW5dyVMraPMTwKjN64TFew//EycGClAV6pXVoP1HI/CutwKQboUgnpxBOt/cZ4EoRw7+UNUQ8CrSoChB8hs6l2HmSNgAlEcSws2fR8emhX4j5WnAG/cr/Et3U545PFnqHJZa4IJy4S0gRbD4hSnFS+XgLTIxbKB27yDxVDd5KykkZtZDNF/PqMQaWRweej40bLeMPWFVQnWIJTPX6myt2xdRWzb1GRmR/5Aa2ioWCj1KOsrXrVKJKKBSt3l4FAkmZRpjZqFUmdJDDABfAIfK8BmqigXO24dxjJbCIaPtZxn1GREmzgHbtE3/6CdNz1STdNA5XjgQsGX3EGu9SmEMy3a8DtCuaHWBTY1fmVtrbkTtdvOmKqOksu1fRY4uzVRSX4h13HhyadR2cxodCfYMemHMhe5Sn+bf//0Z449eK6cEq+Z7heJARYKUzd4mTQ6LygIQSCSbo3EAgs6olkisIQv+bcTvvekLB34QG5FbRcYlY5MN6RC+N59LWoqHUPGlpSgwKW1jsSQGGsBn/Yekj9mCzxPG867Lh7a3jrUbrKs5pQBt1cmBLxIXEI9a1IvTcytO8qZmfa1iiD2avVsKyqQ6Dd3cOEskjMSD4QiY9TPuFLD4xqnDd5MuohH142PRkZ9TBHIT32v4xbQAUhR0XT0ptw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(136003)(396003)(366004)(346002)(451199015)(38100700002)(2906002)(6506007)(5660300002)(8936002)(6512007)(186003)(44832011)(7416002)(41300700001)(36756003)(26005)(6666004)(86362001)(52116002)(66476007)(8676002)(4326008)(66946007)(66556008)(38350700002)(2616005)(478600001)(316002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3XPXqEKFJnO8vq2Gx+UbEa9A8Gag7qnBPzvbjqfWluw9rSA8xy61+96EP6fv?=
 =?us-ascii?Q?Xqp3CiOYBF834lBNDvv8dhTdMGDkdIFqot1MxYM1ZqBoShG5y51PqSfTmUW5?=
 =?us-ascii?Q?T/qpYgut9LHfrFYME0aBs9V7avFZLX8iEhrSTVXiu6NpAkENDYpXZiU0bGwr?=
 =?us-ascii?Q?N7UbLYApbHFjHqZDJ3DaH3pxu8/fF59cliISg7fVqhh5MXB8Ezx0CXTyZUyv?=
 =?us-ascii?Q?yLxiyicMkCSq+bGNcbIjICsBHN+bZ2z5Ap9yJqgIK4gTMLHKqnx3jl2dgY6h?=
 =?us-ascii?Q?S6Mph4d7gKtIFrbFocRK7LymsgsxnjytbyE1tnTnxRTpRVQPJWiEIA8F91Fm?=
 =?us-ascii?Q?4AK8h7s+OGJfHVs8wD7G9EophEAFDVRqZhdHVFdffp9n6JE/UxTkdWSKYjCG?=
 =?us-ascii?Q?pKM6PcYDMqI3axXX3RltfikfXF+U6v0S5OmwHwCdYvh7oUlklJYped7r1zRL?=
 =?us-ascii?Q?G4wuxJTzkXn8zcUt0fy2X/ZexzLxuq4lzqNEx7jAtyP4H4tWb/zQCJkq/tRI?=
 =?us-ascii?Q?WUAMCbQWvGtvWGpzdcnHnKfZfo1L54oMe8vdCb6scHMcuNSwx9t+qL+m3AZJ?=
 =?us-ascii?Q?1hG67a+9HdyBYvl/TUdoP3pAVW0l2ArTKRXgfLYl5yTqF3pKo32PObSTxgOh?=
 =?us-ascii?Q?abi2Vy8TfVm5MJ1Gxniv+qQGvn8fDKIDkLg8EySWYJQGoVUWbKAfQXMYfCe0?=
 =?us-ascii?Q?358d1wazIT10L5EpLV0/96kelGBEcwaSk0ubwK6QxBkhIoPi86aTcbz/5uIF?=
 =?us-ascii?Q?qMhTvyw+Z0SBqOYCJ7ugnqapY89AI+Azl1AnCe/1Wo7/+UKXAGTy5+qiCb1a?=
 =?us-ascii?Q?Rpsv5qTyIBKqqp3tH/yuOdI2/wxPw0QjA4YFXC+2mJv5rLCQUPaerlUqMB3b?=
 =?us-ascii?Q?1XE+ICJygTQMIgbNTpDY9gtNqo0Xej7yjnzaGezt6bFRB7Ok9peXvcMTngbj?=
 =?us-ascii?Q?zQnAxxLI/2vPwW7VcWJ+JCL6+eEBGUUv/H8b04IhQIPjaiM05nfDHuuY7Rug?=
 =?us-ascii?Q?7NuT9IPID2I3P0W9zwHss8kLGzKXO0ktUFjsz/moRjXP6izb2NnoWKze4ddN?=
 =?us-ascii?Q?AoDmiQQ01dyRCghHudpp7GKVzr1XTyAXMaBW4q1OzFmoM/zouAmfBoj7PzO7?=
 =?us-ascii?Q?YfvZZK+xEUb3YsVg69ZNNAIldAX6AW+nVZuGwyF18hi/MJwjrir5GJXJVgiu?=
 =?us-ascii?Q?JKS2IrUGkd+xUS/oWRAI1SGW9Rn0psnuKRdLJeHZ9LvuMyioisGGN8EwSm4J?=
 =?us-ascii?Q?h3+OLWUh2NFZ+oV1wsyFVzENuh6rfRtrxGLZulXB1sUEkFyr3IYj59ttaxuH?=
 =?us-ascii?Q?ck0Kke9AGkZ/xI5/8dAhWN07UK8nl1I3jR9MrvfirH2SwY3/0nckH0f8dMBM?=
 =?us-ascii?Q?dJOOsjzXD1EBCVVx6V0iSRMmvWj8NFzgxveumDd17ue0y5NN/xjLdqIDSLSZ?=
 =?us-ascii?Q?S6/OcabWYDJqYpT7mqcITUtPw436nvubpPh85gLprqH+/2+bGcLczoV+4tTD?=
 =?us-ascii?Q?UWoFh8dlTc0ncim/mYuRtFtNxyW8ZPvsQXVWE4evIgm3gN9+LTwdyIsdV2oH?=
 =?us-ascii?Q?2qSBdN+BPJxdWiIXUo36F8aWTDOLzXe77smW+HPu?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45814b56-dd3f-49fd-bb8d-08daf47c1ecf
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2023 09:05:15.8117
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aLeZP/TyVfl04OXdPz5lyIAib6Z2LgoFwsD+BpfjJAtfoZYyQQzbyAA/4kHmJFqxseW7+QohtUs7S0VuLH7qkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8875
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorenson Spark is an implementation of H.263 for use
in Flash Video and Adobe Flash files.
amphion decoder can support it by insert some startcode
before sequence and picture.

Signed-off-by: Ming Qian <ming.qian@nxp.com>
---
 drivers/media/platform/amphion/vdec.c       |  7 +++++++
 drivers/media/platform/amphion/vpu_malone.c | 18 ++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/drivers/media/platform/amphion/vdec.c b/drivers/media/platform/amphion/vdec.c
index 87f9f8e90ab1..09304b96f40d 100644
--- a/drivers/media/platform/amphion/vdec.c
+++ b/drivers/media/platform/amphion/vdec.c
@@ -165,6 +165,13 @@ static const struct vpu_format vdec_formats[] = {
 		.type = V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE,
 		.flags = V4L2_FMT_FLAG_DYN_RESOLUTION | V4L2_FMT_FLAG_COMPRESSED
 	},
+	{
+		.pixfmt = V4L2_PIX_FMT_SPK,
+		.mem_planes = 1,
+		.comp_planes = 1,
+		.type = V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE,
+		.flags = V4L2_FMT_FLAG_DYN_RESOLUTION | V4L2_FMT_FLAG_COMPRESSED
+	},
 	{0, 0, 0, 0},
 };
 
diff --git a/drivers/media/platform/amphion/vpu_malone.c b/drivers/media/platform/amphion/vpu_malone.c
index 2c9bfc6a5a72..67ba637c4c7f 100644
--- a/drivers/media/platform/amphion/vpu_malone.c
+++ b/drivers/media/platform/amphion/vpu_malone.c
@@ -562,6 +562,7 @@ static struct malone_fmt_mapping fmt_mappings[] = {
 	{V4L2_PIX_FMT_H263,        MALONE_FMT_ASP},
 	{V4L2_PIX_FMT_JPEG,        MALONE_FMT_JPG},
 	{V4L2_PIX_FMT_VP8,         MALONE_FMT_VP8},
+	{V4L2_PIX_FMT_SPK,         MALONE_FMT_SPK},
 };
 
 static enum vpu_malone_format vpu_malone_format_remap(u32 pixelformat)
@@ -987,6 +988,7 @@ static const struct malone_padding_scode padding_scodes[] = {
 	{SCODE_PADDING_EOS,      V4L2_PIX_FMT_XVID,        {0xb1010000, 0x0}},
 	{SCODE_PADDING_EOS,      V4L2_PIX_FMT_H263,        {0xb1010000, 0x0}},
 	{SCODE_PADDING_EOS,      V4L2_PIX_FMT_VP8,         {0x34010000, 0x0}},
+	{SCODE_PADDING_EOS,      V4L2_PIX_FMT_SPK,         {0x34010000, 0x0}},
 	{SCODE_PADDING_EOS,      V4L2_PIX_FMT_JPEG,        {0xefff0000, 0x0}},
 	{SCODE_PADDING_ABORT,    V4L2_PIX_FMT_H264,        {0x0B010000, 0}},
 	{SCODE_PADDING_ABORT,    V4L2_PIX_FMT_H264_MVC,    {0x0B010000, 0}},
@@ -998,6 +1000,7 @@ static const struct malone_padding_scode padding_scodes[] = {
 	{SCODE_PADDING_ABORT,    V4L2_PIX_FMT_XVID,        {0xb1010000, 0x0}},
 	{SCODE_PADDING_ABORT,    V4L2_PIX_FMT_H263,        {0xb1010000, 0x0}},
 	{SCODE_PADDING_ABORT,    V4L2_PIX_FMT_VP8,         {0x34010000, 0x0}},
+	{SCODE_PADDING_ABORT,    V4L2_PIX_FMT_SPK,         {0x34010000, 0x0}},
 	{SCODE_PADDING_EOS,      V4L2_PIX_FMT_JPEG,        {0x0, 0x0}},
 	{SCODE_PADDING_BUFFLUSH, V4L2_PIX_FMT_H264,        {0x15010000, 0x0}},
 	{SCODE_PADDING_BUFFLUSH, V4L2_PIX_FMT_H264_MVC,    {0x15010000, 0x0}},
@@ -1411,6 +1414,16 @@ static int vpu_malone_insert_scode_vp8_pic(struct malone_scode_t *scode)
 	return size;
 }
 
+static int vpu_malone_insert_scode_spk_seq(struct malone_scode_t *scode)
+{
+	return vpu_malone_insert_scode_seq(scode, MALONE_CODEC_ID_SPK, 0);
+}
+
+static int vpu_malone_insert_scode_spk_pic(struct malone_scode_t *scode)
+{
+	return vpu_malone_insert_scode_pic(scode, MALONE_CODEC_ID_SPK, 0);
+}
+
 static const struct malone_scode_handler scode_handlers[] = {
 	{
 		/* fix me, need to swap return operation after gstreamer swap */
@@ -1427,6 +1440,11 @@ static const struct malone_scode_handler scode_handlers[] = {
 		.insert_scode_seq = vpu_malone_insert_scode_vp8_seq,
 		.insert_scode_pic = vpu_malone_insert_scode_vp8_pic,
 	},
+	{
+		.pixelformat = V4L2_PIX_FMT_SPK,
+		.insert_scode_seq = vpu_malone_insert_scode_spk_seq,
+		.insert_scode_pic = vpu_malone_insert_scode_spk_pic,
+	},
 };
 
 static const struct malone_scode_handler *get_scode_handler(u32 pixelformat)
-- 
2.38.1

