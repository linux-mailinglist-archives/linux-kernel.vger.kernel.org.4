Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEFC9640131
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 08:48:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232461AbiLBHr5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 02:47:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232356AbiLBHrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 02:47:53 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2081.outbound.protection.outlook.com [40.107.21.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 029C3FCD3;
        Thu,  1 Dec 2022 23:47:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AXmhhOk2bdfa8h7gm2MeFLxoCeMBAaAIGHnIgxkpxhG7ijk49jfP/R7+9EcuT4VIhKZJVom2lX2D36W0iPkMvAgzNvIGGOWLLfWfMEdT6lOop1/lSUzsbhkRZ9lItIix344AlxFGCxUUABvFaPAwhGun9gZnxX4niPpHeI1/vJQG6fVEKAOENTHSlG0tgToMyDxcdNQ7vNuhWe1hyo3v5qw18yCyNWXh++zCF0cb+rsbOq8xfdqWtbJ7IlCYaZKM3rreMSA3VKWJ7TyfxUqzE+bUPWmNzLt+u+tWplTzxb56M7P80S4j6cTwzz6RsyWY0wanrGjzm8OpoPS3jBsEAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cu3P7ryNMLoHtw08Bw8zwZYVi+5b7Hwih9KWC1ja8+o=;
 b=HQJuKbZQw8BdQTCN4K282Sh6kRcg7ef0uL6jHRQjm8OJSjvHEjb8Lc1145Wr3dwQNF3pTs+Rmf5Wh52LcLOXoa6q85Se9Sk2Bp7QBlakV+RTUlFSiONxFqNodt94owwiyL1yPL5kNitnx9ncpNdkxu2b+abl6anZ0lhNjR9A23UbZbxJhjT4ta6o1olpwtjtSknE5M4f+tMhlaps4Oa1a7d/dEDfEaQVIAeSGZevv+9xndkqaKWCxFx2ChqQb1CIvWxdktuxRGNPJIbVhP7yqfyjiuj0ks/omsk5htV7qcdPFnh17IhWxRnDa9abiNjaE7m3uQZv9mz6ZTLQmH0yTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cu3P7ryNMLoHtw08Bw8zwZYVi+5b7Hwih9KWC1ja8+o=;
 b=Ur+1ayGQ2r0joy9s3AxdWF+z4lAeYmStbEK0mP01yipMY5KNDBTVVGI7obYKqYgZZV1G7V1RNPKaQ8EWuKCQ9PNvgmFqlgmyMIQGn1bAA2IpVcXuDCZdeobcr7HIhrL2JSRdMQNBzhIahRxiZsnEi6f8HvCbMSsRPUMPT1wWyMM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by AS1PR04MB9384.eurprd04.prod.outlook.com (2603:10a6:20b:4d8::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.8; Fri, 2 Dec
 2022 07:47:49 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::4e64:fadc:30cf:4b86]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::4e64:fadc:30cf:4b86%5]) with mapi id 15.20.5857.023; Fri, 2 Dec 2022
 07:47:49 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, robh+dt@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        xiahong.bao@nxp.com, ming.zhou@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/2] media: add Sorenson Spark video format
Date:   Fri,  2 Dec 2022 15:47:16 +0800
Message-Id: <d4d0f9178e1645917d96033f4a4cb2541dedba7c.1669966698.git.ming.qian@nxp.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1669966698.git.ming.qian@nxp.com>
References: <cover.1669966698.git.ming.qian@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0015.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::18) To AM6PR04MB6341.eurprd04.prod.outlook.com
 (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB6341:EE_|AS1PR04MB9384:EE_
X-MS-Office365-Filtering-Correlation-Id: 10411770-fece-4316-7632-08dad4398279
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m/PyysXWkQbdorpsyULn5k9MUSaWsRQVmt5y0Aa/fBEHgj5ELc3YNHsOtKp3VAWTowzdtdHJRjTAwbpo3GtjILsDEJeTICKSmNzRh7+7uZlldv/NCToh312YothKm4L8N2jnY924WscEo2t5Dhfp163KIAPfjeyQqZ0oB7op1AzaeNCqyVf+tgvuUySRdw+kWNRDFLgh7McLQpq59/ycDCnU7a1v5VfeRpQHdnTdEwFy9oeouY4sC99JFYU5lq1zUZo0C33nxpZ10+IMeNiqHQQPn6i+bva6E7QKrpHhDlHPyjVgsW5FXveTUAsVtT4H4EKODBtmyXdwbnwFd/jisQxMJ9G5ZvNjelK7gsvb5taoYkDVmmluZHNhnV+ZURqYPJE5p2brDw6eBo5h16PVrBXgJ/IC1jPXlPfMGQxwsae/yJD6UQd8l0P7j2WjFDq0rvFEko/NTwJ/1gO/cn6SlVnfaAZMmV5YUE75lHyOyhR+2mfa/TZIyjkXoE+sEkrkq47pk2uOKNIwM+h80L/MrmIJoAo3znT0D7SEuCKrvmH2BvUFKpF/9AFGyJXJisqq1QZ+vYyyN6+xVEUQ1mfb4p1HMc/I3dhsYj4adPbq8BAsSJ+elaJTR79YY4gJWHyZcn2IkGyD3eyOtk8gDJL/xnz5x0OXPEQXGM725hvhkLjn0EeQp/Zizv/RI+l+1Pc6
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(366004)(39860400002)(346002)(396003)(451199015)(36756003)(86362001)(6486002)(316002)(44832011)(5660300002)(8936002)(4326008)(66946007)(8676002)(7416002)(41300700001)(66476007)(478600001)(66556008)(38350700002)(38100700002)(6506007)(6666004)(2906002)(52116002)(26005)(6512007)(186003)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lSWIVt/P8J1IYT+2szbhEQ9Aw0gqkhqIRerm2w2JLeSinSG41WE1CYpfXzvD?=
 =?us-ascii?Q?LaqbQo6uR8bzp4R2ttBbDndpjzHsExGlbTUyRZtUMwEtEXTPv9gqTvf18L6s?=
 =?us-ascii?Q?XHwkE2MBb+FyDGpmGAPyQwL0B3PYCtHPax1tB7cDE/1hggE7iaAkb9gxRJU8?=
 =?us-ascii?Q?vXBTsW7bFxKUdNSzH5PYl45PtKkBiijkMU6tXEj8gC0adwHHzkGZUOcSNnGY?=
 =?us-ascii?Q?yqH5LOcBa2NoG4xMOSGssby1I3tIvN/BBQ+tP1TU2KYVFPcShuhVLTKwRhES?=
 =?us-ascii?Q?NeuTXDRHl5veqoEgmlYvMkeBD/CFq3IV0mywZrvbQRtSWfJ8M+vV56lwO+H8?=
 =?us-ascii?Q?hGlwCu81ZUMlbEGSHwoOgP1UlcQj5GzxbCKomcC49QZOYLr0U55pTD8gTiq4?=
 =?us-ascii?Q?d7CTx/2nMVpqLmj2uil8wA1vgMSoeoTNTOlpfDXF71ntDrWA8vsVM5GmKSZh?=
 =?us-ascii?Q?5VAs9cFXydaY2BW/xgm8QUHEH64WBLO/hwKj77R6u3/jBCgoBy+kBdFlLY1b?=
 =?us-ascii?Q?SMcsUMQRQJIpbXnORVkPWdnXpSj840wPNqHycUNHivGIKHS9FWPdiNnDKiAc?=
 =?us-ascii?Q?dSuP2KxBKFc7Vi/ni0WzQ3vuce2VAtq+M/FhiEfPtSuYRZXc+MMmyMN1XQtF?=
 =?us-ascii?Q?YXIICPePTqvHco3P07Sux0i/4St1M3dMiglYRO0U6tywXvQ0QC91DrKKoPPn?=
 =?us-ascii?Q?YnwIK9w2QjRe6WbLtcsK3TFcq7y68lQkuTMiu/yXti9AvnT+2VKjb9qGoN55?=
 =?us-ascii?Q?aDCx6bymPVXRHelmpfZmj+0VvCzl9Lhcj5u4SarnwhQ1/Mxc3ASZk220ktp3?=
 =?us-ascii?Q?j2oRRF0V1GANuvXUZyDJBIGJgHKQd3PF0irQuz6rG42UJiKUsNs367PHbx5T?=
 =?us-ascii?Q?LiGMMGomYDVPQ9Rwh4JXAYu+YCx6fsOrAQbBgHbUIajeoVKCsJ9m6BCCn/Uz?=
 =?us-ascii?Q?O8zf+eGV5i/1fLqsglTYfnCIEDEQD92a8s6WP8ZnVbSrQYS90/sgbGnx1/c4?=
 =?us-ascii?Q?n5s0Mqp41ZH7AGBBchzjpPfgLAlYJEEf9vnmNu9KVkXon/IxUxTEntEmi2tC?=
 =?us-ascii?Q?AGl/jLZ4AUkGmtmE1fB4xZ+XS9CtqG/wc6kX9vqcXyT9QG2FoYGWihGC7H1l?=
 =?us-ascii?Q?Ap9pPBJgdUD3Za3e+N8eJ+CibnnFqmXsdujt+g4kwI8n4jKCqvHN0y9BDhhy?=
 =?us-ascii?Q?rouV/ZncK9fmzQkWTHOloUJk4DZqyLXAaULkmSpoDUhUuD9Z7cYz5+tqcnoR?=
 =?us-ascii?Q?3O3s/4XfL6kPlUCyj45zFca6iYZUQptxT9qet5payKo2iFmv3BWt7RpFwCOf?=
 =?us-ascii?Q?I5GMjSGMkWl+L0pndHOvtzraokIZKRL7I2xl+I1uyhqRAb4/UwbpYsu/F9GB?=
 =?us-ascii?Q?SZUIUHk3pdnyiZqjE2Y/3jK4rPUeNi1dFn8hLSDtM9yxUz77TWYqIwRyJlvO?=
 =?us-ascii?Q?uc6019RRpEhzyuTrPgdsx/URWQ0rWcyyD79xmayrPMQIm3BWeGtUgpv7WHja?=
 =?us-ascii?Q?4WRUo2XNNn3Me2oyzvIoQxw/iogvJ8Jop9Fgz4MH5lKfoKQ124I2E58MIqZz?=
 =?us-ascii?Q?QSA7+dQgFlTEZyjN0Dzgs5HxUL812fAzd69RxFiX?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10411770-fece-4316-7632-08dad4398279
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2022 07:47:49.4506
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vno4Dmb1Y+A8LwbJW4bUgEmzVuPZmwMR33ZtL3xetYT5GX8XH/J/1LzDWcpyo9XC8srhowjDtSRd/xu/uevI+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9384
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
Sorenson Spark is an incomplete implementation of H.263.
It differs mostly in header structure and ranges of the coefficients.

Signed-off-by: Ming Qian <ming.qian@nxp.com>
---
 Documentation/userspace-api/media/v4l/pixfmt-compressed.rst | 5 +++++
 drivers/media/v4l2-core/v4l2-ioctl.c                        | 1 +
 include/uapi/linux/videodev2.h                              | 1 +
 3 files changed, 7 insertions(+)

diff --git a/Documentation/userspace-api/media/v4l/pixfmt-compressed.rst b/Documentation/userspace-api/media/v4l/pixfmt-compressed.rst
index 506dd3c98884..8794b92fde36 100644
--- a/Documentation/userspace-api/media/v4l/pixfmt-compressed.rst
+++ b/Documentation/userspace-api/media/v4l/pixfmt-compressed.rst
@@ -88,6 +88,11 @@ Compressed Formats
       - ``V4L2_PIX_FMT_H263``
       - 'H263'
       - H263 video elementary stream.
+    * .. _V4L2-PIX-FMT-SPK:
+
+      - ``V4L2_PIX_FMT_SPK``
+      - 'Sorenson Spark'
+      - Sorenson Spark is an implementation of H.263 for use in Flash Video and Adobe Flash files
     * .. _V4L2-PIX-FMT-MPEG1:
 
       - ``V4L2_PIX_FMT_MPEG1``
diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-core/v4l2-ioctl.c
index d5a259db55b0..ee4196b9d71f 100644
--- a/drivers/media/v4l2-core/v4l2-ioctl.c
+++ b/drivers/media/v4l2-core/v4l2-ioctl.c
@@ -1478,6 +1478,7 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtdesc *fmt)
 		case V4L2_PIX_FMT_HEVC_SLICE:	descr = "HEVC Parsed Slice Data"; break;
 		case V4L2_PIX_FMT_FWHT:		descr = "FWHT"; break; /* used in vicodec */
 		case V4L2_PIX_FMT_FWHT_STATELESS:	descr = "FWHT Stateless"; break; /* used in vicodec */
+		case V4L2_PIX_FMT_SPK:		descr = "Sorenson Spark"; break;
 		case V4L2_PIX_FMT_CPIA1:	descr = "GSPCA CPiA YUV"; break;
 		case V4L2_PIX_FMT_WNVA:		descr = "WNVA"; break;
 		case V4L2_PIX_FMT_SN9C10X:	descr = "GSPCA SN9C10X"; break;
diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
index 0e2ccd7dc877..0f905abbd15a 100644
--- a/include/uapi/linux/videodev2.h
+++ b/include/uapi/linux/videodev2.h
@@ -739,6 +739,7 @@ struct v4l2_pix_format {
 #define V4L2_PIX_FMT_FWHT_STATELESS     v4l2_fourcc('S', 'F', 'W', 'H') /* Stateless FWHT (vicodec) */
 #define V4L2_PIX_FMT_H264_SLICE v4l2_fourcc('S', '2', '6', '4') /* H264 parsed slices */
 #define V4L2_PIX_FMT_HEVC_SLICE v4l2_fourcc('S', '2', '6', '5') /* HEVC parsed slices */
+#define V4L2_PIX_FMT_SPK      v4l2_fourcc('S', 'P', 'K', '0') /* Sorenson Spark */
 
 /*  Vendor-specific formats   */
 #define V4L2_PIX_FMT_CPIA1    v4l2_fourcc('C', 'P', 'I', 'A') /* cpia1 YUV */
-- 
2.38.1

