Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 973E069604C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 11:06:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231878AbjBNKGy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 05:06:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231398AbjBNKGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 05:06:47 -0500
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2045.outbound.protection.outlook.com [40.107.105.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59B2F23DAA;
        Tue, 14 Feb 2023 02:06:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NjF1UglkDWBGe5Ga2L166fV4VvAQwZUumXDtmz9MqGyGuflqg0Astu4Voal2ZrS0o+5gi189YY679PVvri0Y0InhUASaXuKJzcgjx5N5viyPOZBRngpKEsBa6/uCllISEtSKijBDK0Qe+UfuW9lvgQE9Has/8HCw2XYF4D31CWZOiQ4FbOS/RYl9RmwdAlSVgm4OhIBMyL/VIw6ZmvLahca8rGnO+h7bpupFXm6uBSpWXo4TlChArFO2Kus0/PCXe4mCU00jOk+KyJXWSmKyl7Uvcru3SgvuXi9fvWOftEpf7gEUbT3kV3e2JJpF6s0z+5FjMat9kOryHuZVpewPKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YbyBPRtBvhf5ILwYjc6qTJcGWFkiWrhaf6Mx1Yxebss=;
 b=UZ3S2mWGA5KNhnT7eBQmrrqXF9Hs/gmqQDMnB7L4gaWmZBXmhVnQZphmRo5WCvtBvKdJ+tU3Cir6mS1E4Ul705vpkwV7JpfV2pouuhxISKbx6RhQvMF6ayE5hxFZPl3DYWPKnTRYBkSKKt3VUvz2idEZk5onCbUYlVPOTECTn2jEFXfX8NnCgek46ZIZDMF01lJK0shDAWAWFTQElJlTWstZw06K47eHnVJyQX0eV0zIO+d3YKGXT0US7fWa9FVUSOMfrCQRn35Zx5iVPAuR5W02oZcmpRvWseVxwr6HnkdUpylhJhGNf95BnWsmg5UcPWu5EIBgWbPNNWIMw4oojA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YbyBPRtBvhf5ILwYjc6qTJcGWFkiWrhaf6Mx1Yxebss=;
 b=M8xXs3WChkrXF98Flt2yPvdL2rcllFORQhPoofUKNuORURYuHjGPmCYcDebTte1BUunJPqd7h6kTd19zrcPk9ZToTcgXSpGJMnxxjT/q8wH/2OBPzih4d/+BJdSp+srWgL96pfTnViNc9P56XG5G5xYHRt4H/fco2S2XBMEkq4Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by VI1PR04MB6800.eurprd04.prod.outlook.com (2603:10a6:803:133::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.23; Tue, 14 Feb
 2023 10:06:07 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::3a82:42b3:f1ed:5c3d]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::3a82:42b3:f1ed:5c3d%7]) with mapi id 15.20.6086.023; Tue, 14 Feb 2023
 10:06:07 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, mirela.rabulea@oss.nxp.com,
        hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, xiahong.bao@nxp.com, linux-imx@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 06/10] media: Add ABGR64_12 video format
Date:   Tue, 14 Feb 2023 18:04:48 +0800
Message-Id: <001d80111433446a324fc907bd6b4b71c4b263ff.1676368610.git.ming.qian@nxp.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1676368610.git.ming.qian@nxp.com>
References: <cover.1676368610.git.ming.qian@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0035.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::13) To AM6PR04MB6341.eurprd04.prod.outlook.com
 (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB6341:EE_|VI1PR04MB6800:EE_
X-MS-Office365-Filtering-Correlation-Id: cf075cd9-49bb-4e0a-cf0e-08db0e731706
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W+BDx/MAkb9VeOsD/WiRzaccev8f/xxTMfVND7LtjGsurC5QsiuqyO6fL2aSEajgiVfj4Xl5z+8JIKFUjuNbRC4wHhbbiQJNbi0Ph13v78v+nslZBPIGu0tA3WoFmNBZDrbyUO7os1HU3j/lcIisEvyvC6Pe0S/tUApvm7mNb0DthAkP1vwYsmsG+XsZYae7WbxbgG70ud8hp2L4Xt3XOzFEXTwcjhGZDRTHqh/cwLgNOk2eHY1WBe6bUuMgLKnHy/Gc4oAmP+tYSJeEAYHvH9x9xX46rq9iNa6ZUhfmjtetBTTteDQUeITLqFInjFCjQP9m6xO1f4txl3FHCwf3gc+8gxykHyrBnIy4wiSRVw+vTZOX/Q2sXCwZwZWmcHjzz96Gol0I2GtKrd7c8CTEsN7EKCYgcDyibM4M1ojl3XGQNWY4sjzFs8Dvx0eacacWb8nv5rtmA3LaYjLXzhoRVAZ5axPS39E2vSfNTb60W1SVJ7KfqKf/NQMrjlwvRyU+XZKDu4ebbRrdOxEPkcrrP9finaTAud+X4UmJnBu7IDf2rMkxvPitGe2h1rw35FJRWdcksmu5R3myOZsxPOtbF+hgyt7JEkjYbQLvzKRxeuk+8QKkn+CKUa5UYyar4mxTF5Z+kcXvas7QowjDn+povNVxwN4o93kpDCOEe/6z5jHlulEgS2d3kti2XDnXlBsJXb3s6LXhd+huQInJyMz1wQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(136003)(366004)(39860400002)(396003)(346002)(451199018)(6506007)(52116002)(83380400001)(6486002)(2906002)(36756003)(26005)(186003)(38100700002)(66556008)(8676002)(66476007)(66946007)(8936002)(6666004)(6512007)(38350700002)(2616005)(4326008)(44832011)(478600001)(316002)(86362001)(5660300002)(7416002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pqNoHb1Vy6tZpDsv67Vz/plpaKtNeRNbbt+1jqrU4WbWjF3Ny77J3e1Mtoad?=
 =?us-ascii?Q?v06hdjahL4tKY8O1NvulS9Z/WPfgrJmseMaHL49+QgOm/wdMM8pkH3mIghK7?=
 =?us-ascii?Q?jOCnbt0+Or//1igBUgOTfAbFAQnVDVOtcS1WlFzdGhD0ySUwXxaDGD7Rotrs?=
 =?us-ascii?Q?Fvlv7BeedVpNs3aKM3zE/n5Mkuf56o/iNurfRRBEwzjkPspFoYwfLvXdAih6?=
 =?us-ascii?Q?lDKCGv6BpJdG1+0LWhvCge53eh5I7knpsDntGfWNF7eVo8sBZ0BpGyMtHEOI?=
 =?us-ascii?Q?fSGz05tCsrRWCKPbYTy2D0P2D1C1WlxVaVKB4BAQBs6pIDroGZZ6C8T5mLqe?=
 =?us-ascii?Q?WKQW9JqgHgpQhXzvPBatK/7//9Wez85KFfpt9NhePDIVXYM3PyOr4Df0gjfv?=
 =?us-ascii?Q?M0OTs3nG00/68n4WLR4Wj3EAkrYgQa3J2WVRO6jSp9Avdnll9iwgf6Z70aMm?=
 =?us-ascii?Q?RY6IeTPiBlPjNemdrdERtlEhqa8J/IIqE9Qu6RYVlt5W4j+gAuA7G8FoVKGq?=
 =?us-ascii?Q?R8LFkDjdmn3wgX/2pAUlLcLXI+9yy8/Tbe1Gt0NE+FKu8VdaQPFPDXqzUALP?=
 =?us-ascii?Q?7g3Wmf1GcLJBFv+Q1p5tDrXtTFfYR6F0zrYdX+qvq6HFaL9Uw2WJ3HUnEx4W?=
 =?us-ascii?Q?n4NnMuytBO7WSX3UdiEdAk5eSOSiajVwvdak4UcpPNSMS40rXwzvDHt1Xl7n?=
 =?us-ascii?Q?tYRdQWeY8Lhozj7F92smZLUwzERttBCBPamoJBhS8eMiwUZ4fQA/tsnYf/2i?=
 =?us-ascii?Q?5DqlVJIdsf/SY8wM+gIkKbKnWn6rOuvNz071cLX3rSi7+FlFVi4WQ0HQouek?=
 =?us-ascii?Q?CVOqvKj6ohc1v4nQpUT3m8wFTMSgegDv7yTotzHel99fgt2/2jSRHmavbqpI?=
 =?us-ascii?Q?ELwWCkwd0g5TF8iOC/PPMoJIvtRj/lT61/ipHMjebs2amYEr/qWRus5n+ex/?=
 =?us-ascii?Q?W+fxUCWX4Go0BkSOAl+hOEKfSZSmw2PcidzIxsZd8lMVRYrqvxXMhMmEImaB?=
 =?us-ascii?Q?2uGo0iIevgzVN8PgWuDDKod2HbOlSpf7bxKFoyoKPsJTSyzdFkbF5lAY/S8r?=
 =?us-ascii?Q?2qRcaWAh1TlrYeDtkRJOdybaa19HFbZbMS6mMf9kgwllMnA6rfa7b4Kn2mjz?=
 =?us-ascii?Q?PrmoLQFoYV2aiwOT4UozXKyKVjEQrg/dUUVJXIWwltT23XEGuX93qcUwlZi9?=
 =?us-ascii?Q?Go0wkTzTAuLj9XdNvIai6LV3xDEaRfFAFTTmfl5WDh2uzmrXhqZWOZG8m7PS?=
 =?us-ascii?Q?yq4o3ZhOH0xOxxNM3TcwKkz/a9h6uXnyCNUzCO+1iwsNsP1FwNv9bylw0pt+?=
 =?us-ascii?Q?f7sge1O7QJKWNT0XzLkrGYk5jGAahBU4DhbMkNQBlCztmgbHBo6bKX+igLf6?=
 =?us-ascii?Q?ZpKAguSin3J/E8jwbq1BYl0bnt0s2+NBEHBGvwvozaTdv3y0zu/foESI2ClR?=
 =?us-ascii?Q?oTC9/gEq/qLGOdX8Ti1MqKX6/RI2BLp94IB6hh4UB7zFom3RZ7+4ZGK1vSZl?=
 =?us-ascii?Q?uyM6zlTvyCLKDP1Fkk+5bOY7aMLNEjOrHt2jmLDRFDxKj+s5v5xSfSOxa2K6?=
 =?us-ascii?Q?V4ucpC3Jq7rY0JTwiWkTctNK7MHyOBtjLyyHrjsh?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf075cd9-49bb-4e0a-cf0e-08db0e731706
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2023 10:06:07.5282
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cPy/MIC2WDKftmaZMlbiNMFNB9hI0u5r1i0t6u5pKK/rId8UwDa6Wd+FiweeO/ALi/lQZwncUtTse9PcC06cHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6800
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
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
index 70568f7ae130..28bcc5391f27 100644
--- a/Documentation/userspace-api/media/v4l/pixfmt-rgb.rst
+++ b/Documentation/userspace-api/media/v4l/pixfmt-rgb.rst
@@ -793,6 +793,15 @@ arranged in little endian order.
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
index e73103fa65ab..a6aec35bfb54 100644
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
index e63580a3d712..e5813ba3e3be 100644
--- a/drivers/media/v4l2-core/v4l2-ioctl.c
+++ b/drivers/media/v4l2-core/v4l2-ioctl.c
@@ -1300,6 +1300,7 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtdesc *fmt)
 	case V4L2_PIX_FMT_RGBA32:	descr = "32-bit RGBA 8-8-8-8"; break;
 	case V4L2_PIX_FMT_RGBX32:	descr = "32-bit RGBX 8-8-8-8"; break;
 	case V4L2_PIX_FMT_BGR48_12:	descr = "12-bit Depth BGR"; break;
+	case V4L2_PIX_FMT_ABGR64_12:	descr = "12-bit Depth BGRA"; break;
 	case V4L2_PIX_FMT_GREY:		descr = "8-bit Greyscale"; break;
 	case V4L2_PIX_FMT_Y4:		descr = "4-bit Greyscale"; break;
 	case V4L2_PIX_FMT_Y6:		descr = "6-bit Greyscale"; break;
diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
index 7aafeccd8f02..3b611d7f2ee7 100644
--- a/include/uapi/linux/videodev2.h
+++ b/include/uapi/linux/videodev2.h
@@ -579,6 +579,7 @@ struct v4l2_pix_format {
 
 /* RGB formats (6 or 8 bytes per pixel) */
 #define V4L2_PIX_FMT_BGR48_12    v4l2_fourcc('B', '3', '1', '2') /* 48  BGR 12-bit per component */
+#define V4L2_PIX_FMT_ABGR64_12   v4l2_fourcc('B', '4', '1', '2') /* 64  BGRA 12-bit per component */
 
 /* Grey formats */
 #define V4L2_PIX_FMT_GREY    v4l2_fourcc('G', 'R', 'E', 'Y') /*  8  Greyscale     */
-- 
2.38.1

