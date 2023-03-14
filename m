Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6E1C6B8F59
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 11:11:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbjCNKKv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 06:10:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbjCNKKh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 06:10:37 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2080.outbound.protection.outlook.com [40.107.21.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52E2D231C2;
        Tue, 14 Mar 2023 03:10:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BfVxGebQQgAY/PYsZmg6bVAw0ZBMGcyQqA0A1vV7JPawgPvILLlQ5NvZC6GEX4Eqln/1FLriHJWNcF0eHnu5UUq4bstxWKdkFbr8GAtZ2E6JcWKLgwX93AOCuPnQD3eCCpIhKjpkwZXCarfnHjABMlufHnASobDrmIfEko0CSuOAud/WRiGRot8nf3KNxxZwZEFMsFuUkY4RrC6wVHBV0GMhM/WNY0NJKD1UQZSpCysFzGO8p6jTyBXLJz9hwXRtHplvW3P85QOrIbtgD3wKe9FHXHV4PekjKve2thjMHkJyhAIKL0dRryOnSoyeBrkRlTYEieRxVwJV+TutPnuU9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/8H4+vWP7BA+UfxXwkEHLwMGKN3NFs+oVfPrEZ+GNJk=;
 b=BBQPhbKttzGCF/zcZqnppZjABb5eGwAZhS3ntRwlTYXY6pPkXgvaMsBU/i+W0+qYjmPHlK4d3zdtUhZyIJ78eCXHodia0E/C9wGxn2cdgDj5wCK9FxN9VN78Pea30nd8DQY16QWf4HHNKyCV1FGKmJ7WD2WNSZpaP+SgymaRH75ivJBxnimZsJyT1i9CpRqIw7zozScslkdUWN0mjHFbvnqMTnvk2yI/cWwPe1WGOGu7luDukPUw5tNYL6XcQFMsoVeUhfxgG3zpRWcyCUIy0Vtnmfa5A+nILOCKA7fweZcdfgUbZv9w6kM1wYzQGJYzTeGMSl0LvBg0+Bo3Qpbf3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/8H4+vWP7BA+UfxXwkEHLwMGKN3NFs+oVfPrEZ+GNJk=;
 b=hwZJtlKmJDqosCwK0qNpvWKVVNHi1c+if9n28MV75Ja3jiyr00IObstTwQ/rwDdkRyrvWv7NVDJIVt3g4M8/yvqpQMRTlzkoOLxN532RsRZrQhGJR3SHlyVDCs8q9Tilda4spOShUTc8ErHxwqUUiRF//Qdsxhp3vHp0shRcMzI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by AM8PR04MB7841.eurprd04.prod.outlook.com (2603:10a6:20b:244::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.26; Tue, 14 Mar
 2023 10:10:22 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::89aa:9204:790d:e46b]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::89aa:9204:790d:e46b%5]) with mapi id 15.20.6178.024; Tue, 14 Mar 2023
 10:10:22 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, mirela.rabulea@oss.nxp.com,
        hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, xiahong.bao@nxp.com, linux-imx@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 06/10] media: Add ABGR64_12 video format
Date:   Tue, 14 Mar 2023 18:08:49 +0800
Message-Id: <381112ea3503ec1a49a5130a0bcee777ce58391a.1678788305.git.ming.qian@nxp.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1678788305.git.ming.qian@nxp.com>
References: <cover.1678788305.git.ming.qian@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0028.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::6) To AM6PR04MB6341.eurprd04.prod.outlook.com
 (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB6341:EE_|AM8PR04MB7841:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e463075-8c31-4f10-f391-08db247452be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wpRLJQSsgub6m8+pw/e4bfj29U3B7pYI0L67/xRRxEXWvyxOXYnasyYM6JypcSOgfQ/VGxyxEU7MkqE2lTrdVBpmpDi54uoFuS2n1JmrC9EyjlfQwOZkKmuj/3c1OIIt6/Oa0IugZfLT51c3YDKGdo0j/5w/nIGBwlU0gRVIFHk6mSmURg5YxWAsJFeqPkUU3qu9GQ3jf9a//uDP4D5aYWb/AvqUhyndOdywPtUcoz7qsMRSfdGJKvmm3pV60a2vB5h5CnfuIrayAdpl1GEq11CQL/C+bQRo4EPO0FMAeUxomHJtVuuZjejH+HVBAbzuLeflI2R7n5AYYgUj/tr2KN1p9brClH3MdwYw+sP9EwKCK/o+g23wLEdDu+vKrSV7R8QpGnY6QR/fJzEfbcmba2WSAJmuDlts6XcZF7YjaLwGYPSEmK51/XvX0qnNYzjM5l2zxkAoQKfjx2JjC0cWMD+WwuCJLuO+WhrWo+9azI7qWpxbtIHfE9/C/StQ3oeH7ck8HQYe5Q8/KGIusDRdaOCGbBrUOWyj+X57gs+LTVVe922OrM+WFbkPfKxxw3QbeuZdGIVzMXPz4tA42Onb6ggkIiDB9B7z+geyMHt7LexUnq4Sv+HhDTKk2f2RUGue0Tks5LfcVUCOoC5kaSHZCbimb63MGFivdGHKTIpSBH3c5eNNs35zbFIFzfUtZqD8Fxf2iy3rjW5RenoGhh0FBw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(346002)(39860400002)(366004)(376002)(136003)(451199018)(7416002)(5660300002)(8936002)(2906002)(44832011)(38350700002)(38100700002)(86362001)(36756003)(41300700001)(478600001)(66946007)(66556008)(66476007)(8676002)(6486002)(6666004)(4326008)(52116002)(83380400001)(316002)(186003)(26005)(6506007)(2616005)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Hv6PztDOXhVPVpozuJ3kv57GO5m9rnIusxkbrpJ4WBKcvkHbtJ3LXCuc+sXA?=
 =?us-ascii?Q?FJ5TWRWcYS6Hbp+gw648tOx2QY/T7/vIX21GNW1lXlByBA+EuhEi3DWAYmmr?=
 =?us-ascii?Q?NyxBSkKlNUEjch6ZO0wfR5l0VkhNGmPDAkJDjtUiB6KAtkQoSj/je+GgXhHs?=
 =?us-ascii?Q?dDjyvD0mBphsMRL3cIwHmrcFrlBfN6hXviXvhwLwg+ZgfTqAgoGijPV3FRAv?=
 =?us-ascii?Q?V6hVU75DDOG7XkohupMuk7X1n7VMCvBelVdOO509C9I2AxT2jWXt2GBjwmHj?=
 =?us-ascii?Q?DLv52XrEdzEs1GUMKgRpqefZ0C2lGcC//YhQ1tRAhXEIiuBHdHBmpGy1YHCj?=
 =?us-ascii?Q?pqSmjLZj4UK6ifc+tbCNt2EE2mlhEx7u+9xG58KAB1LFT90xbwqWvFITXQoy?=
 =?us-ascii?Q?seWNCQE6U1EJBSmv6IyKS0I6jnORBAEF+3sj1q6NTeJxmIzObvDyPTTqhquI?=
 =?us-ascii?Q?PHCYcvkV5ICxGvBA4z3I9NYiIUPMwjG561X/7exUaHVHTqUvPYHG1nnet646?=
 =?us-ascii?Q?rNjfxmOMwfoLIas/nnJmOnYlo8zMS0xNj/J5VWW+ApS50+urTkxllBjlhHmH?=
 =?us-ascii?Q?U42/V4OtgY+6dfSWjKzHVBEDBHvi6ENRJIjpdNnCmhOseFC/sdklCLXHp/Fv?=
 =?us-ascii?Q?IAMJjyjbFU4XvZjNKEj/NJbcuV2VaPiLgCtZ/NkyAWW3uKbWXodfht4YiyL9?=
 =?us-ascii?Q?zBq+Xi8Aj9dp0TxmYL5fKep4K70fbDj5w2PfQK+5jBDgms9ZqW2L7OtwT1R5?=
 =?us-ascii?Q?6nhcvafkaTOhoaNMSaJVQCDO3dk0ezGGQO89lS4H1/WXxuK6SElugCwbMB0U?=
 =?us-ascii?Q?Y3iwPrppQCcPlKVvAIiyxSB7+xdDicK1Q4eKs/YakhHV4MNZzcLVdqyOzO9J?=
 =?us-ascii?Q?B5Vz2WrPp7659JSwCDDlbqllJZq83goYvHgLSK9c/4oTRVT63l3ehgIfv2fv?=
 =?us-ascii?Q?I7K9k/2aIim4822GRqmTEj/NkqCK7onVt0qIc8MRZnF+7IkrNeY+K/1guupx?=
 =?us-ascii?Q?tfPxlk4qInJmk1+RnYtrJyqFml6yxjVAXH3jKR13tjFMYdC3hlDi5bt/f8wx?=
 =?us-ascii?Q?bhfShWqHjJepX3sf8Si09qXG88GeyW7ig2SjH3UYfYpjb10KHISTM3Ct/LDy?=
 =?us-ascii?Q?xNgkCCiA4tLvV+a3fl+/Fyh6PyXiOWRmdn6RBv9qHm+TKvc2FUCYMIUmAyb8?=
 =?us-ascii?Q?JOiPQnf7jdhdZiZGohQvCBITZ9Qu78QKkjxubktnAPef+jK0Kvw4lWxJFeph?=
 =?us-ascii?Q?bb7NVVSLUvl3oxtWDptX+uJYblAi4uAwLL+7Nq3QIL5YJjWZ3Tx2LhBA2F/Y?=
 =?us-ascii?Q?mEi26XbTL7jwDU+EeOyNFdGLh7EQVV9fBCYKljy+TVgY5vs+G3ANnh1YJHiB?=
 =?us-ascii?Q?gxtBA3tnMtMttKlya15MHoVMh1eGY5qmrVZ+clYzn0RmLb9bZ1nb3IdAFx9I?=
 =?us-ascii?Q?q5HqfNBx5S7LD1NpV025HjqPeDCgf3DOj8TYfJUTHq0BTY9ZZTuRt8KdbGgQ?=
 =?us-ascii?Q?A1KDolwlBSFLFrmz/B0mpk/qlJqg3Z60vlJG6oZzugmM8LJjeVJFgIBZEdWL?=
 =?us-ascii?Q?/j4dRtmgVzabQjQ+Wx8/8Uz4jb1Olb+ZV5N//fY/?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e463075-8c31-4f10-f391-08db247452be
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2023 10:10:22.7984
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MWeAcBsIzHcBjQDs2GetMdSCU6AEeS6eQkjpdds2nRgt2bg21SMektF5+JiRXfjv5E4lkiRBrOXtnpi+Prq4NQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7841
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ABGR64_12 is a reversed RGB format with alpha channel last,
12 bits per component like ABGR32,
expanded to 16bits.
Data in the 12 high bits, zeros in the 4 low bits,
arranged in little endian order.

Signed-off-by: Ming Qian <ming.qian@nxp.com>
---
 Documentation/userspace-api/media/v4l/pixfmt-rgb.rst | 9 +++++++++
 drivers/media/v4l2-core/v4l2-common.c                | 1 +
 drivers/media/v4l2-core/v4l2-ioctl.c                 | 1 +
 include/uapi/linux/videodev2.h                       | 1 +
 4 files changed, 12 insertions(+)

diff --git a/Documentation/userspace-api/media/v4l/pixfmt-rgb.rst b/Documentation/userspace-api/media/v4l/pixfmt-rgb.rst
index fc98a10991f1..c97eab59a6dc 100644
--- a/Documentation/userspace-api/media/v4l/pixfmt-rgb.rst
+++ b/Documentation/userspace-api/media/v4l/pixfmt-rgb.rst
@@ -985,6 +985,15 @@ arranged in little endian order.
       - G\ :sub:`15-4`
       - R\ :sub:`15-4`
       -
+    * .. _V4L2-PIX-FMT-ABGR64-12:
+
+      - ``V4L2_PIX_FMT_ABGR64_12``
+      - 'B412'
+
+      - B\ :sub:`15-4`
+      - G\ :sub:`15-4`
+      - R\ :sub:`15-4`
+      - A\ :sub:`15-4`
 
 .. raw:: latex
 
diff --git a/drivers/media/v4l2-core/v4l2-common.c b/drivers/media/v4l2-core/v4l2-common.c
index 16d3c91c7da2..3c5ab5ecd678 100644
--- a/drivers/media/v4l2-core/v4l2-common.c
+++ b/drivers/media/v4l2-core/v4l2-common.c
@@ -253,6 +253,7 @@ const struct v4l2_format_info *v4l2_format_info(u32 format)
 		{ .format = V4L2_PIX_FMT_RGB555,  .pixel_enc = V4L2_PIXEL_ENC_RGB, .mem_planes = 1, .comp_planes = 1, .bpp = { 2, 0, 0, 0 }, .hdiv = 1, .vdiv = 1 },
 		{ .format = V4L2_PIX_FMT_BGR666,  .pixel_enc = V4L2_PIXEL_ENC_RGB, .mem_planes = 1, .comp_planes = 1, .bpp = { 4, 0, 0, 0 }, .hdiv = 1, .vdiv = 1 },
 		{ .format = V4L2_PIX_FMT_BGR48_12, .pixel_enc = V4L2_PIXEL_ENC_RGB, .mem_planes = 1, .comp_planes = 1, .bpp = { 6, 0, 0, 0 }, .hdiv = 1, .vdiv = 1 },
+		{ .format = V4L2_PIX_FMT_ABGR64_12, .pixel_enc = V4L2_PIXEL_ENC_RGB, .mem_planes = 1, .comp_planes = 1, .bpp = { 8, 0, 0, 0 }, .hdiv = 1, .vdiv = 1 },
 
 		/* YUV packed formats */
 		{ .format = V4L2_PIX_FMT_YUYV,    .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 1, .comp_planes = 1, .bpp = { 2, 0, 0, 0 }, .hdiv = 2, .vdiv = 1 },
diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-core/v4l2-ioctl.c
index 6d9599391d7b..768e1bad4eb2 100644
--- a/drivers/media/v4l2-core/v4l2-ioctl.c
+++ b/drivers/media/v4l2-core/v4l2-ioctl.c
@@ -1303,6 +1303,7 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtdesc *fmt)
 	case V4L2_PIX_FMT_RGBA1010102:	descr = "32-bit RGBA 10-10-10-2"; break;
 	case V4L2_PIX_FMT_ARGB2101010:	descr = "32-bit ARGB 2-10-10-10"; break;
 	case V4L2_PIX_FMT_BGR48_12:	descr = "12-bit Depth BGR"; break;
+	case V4L2_PIX_FMT_ABGR64_12:	descr = "12-bit Depth BGRA"; break;
 	case V4L2_PIX_FMT_GREY:		descr = "8-bit Greyscale"; break;
 	case V4L2_PIX_FMT_Y4:		descr = "4-bit Greyscale"; break;
 	case V4L2_PIX_FMT_Y6:		descr = "6-bit Greyscale"; break;
diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
index 3c5acd72606c..a6df69ce5cf7 100644
--- a/include/uapi/linux/videodev2.h
+++ b/include/uapi/linux/videodev2.h
@@ -582,6 +582,7 @@ struct v4l2_pix_format {
 
 /* RGB formats (6 or 8 bytes per pixel) */
 #define V4L2_PIX_FMT_BGR48_12    v4l2_fourcc('B', '3', '1', '2') /* 48  BGR 12-bit per component */
+#define V4L2_PIX_FMT_ABGR64_12   v4l2_fourcc('B', '4', '1', '2') /* 64  BGRA 12-bit per component */
 
 /* Grey formats */
 #define V4L2_PIX_FMT_GREY    v4l2_fourcc('G', 'R', 'E', 'Y') /*  8  Greyscale     */
-- 
2.38.1

