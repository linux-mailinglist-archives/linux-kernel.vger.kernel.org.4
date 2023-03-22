Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA8F96C41E9
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 06:14:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbjCVFO3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 01:14:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjCVFOP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 01:14:15 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2070.outbound.protection.outlook.com [40.107.20.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC11053735;
        Tue, 21 Mar 2023 22:14:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eI2bKZBcmP4N0SCrAq7RBKOZ3kHkodOEBZFCQrgLLTLQrZM7jysGGwdOlukl1xE4dvzUGaLFozD5HBx4xx2fdIgliPJpI1ROzWpkiQpfEZCHWHuviqyIY2fPlokfPh9TxYzedOhrbkgffZy2H9RWDDeZbcEnJJW8gUEw0Olp4oqTQCiW/K7+mF0vi2BGORvh0KwEwMOlfQoGU1shtRDNeDiV63Z4bsi2FHtXYkqw6X8UJtKNh6LHD7T924sRHv+FtEKDpvbgD/LRcq04RyTWYlaHBUTO+z6iut5YeWnWaE29SZprmRWQANXBQsZ2NyK1Ng02XgYRVBqiLzoCYCQ5Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RNYYeP2WoEtfwMINmCboSPMspPL38A42Pfs0MlV+L5M=;
 b=Omz8/IfKa+14A+jhFxf5FVBPz5G08ufYx3t7aGmhr6fvtDSUX1ATgwABYR7R8QKs2Ur4AelhX3AZwuCBp63mOzXbyiNVWRy3Hy0GeMXEQGe0XvPtJEZp6+HT5wRfqOUJ3A26VZPAEvG/9skGj9LN6lhFcaJUrJjZeao15U576TGvWUmciC1YhuoZ/1FC4XqnWR7QgYaOSYXGajYunfhmEk2jpZ4L17RgiYtWQPDlY1HiRe/G+4G6b1RCJE/HRvvEy7/eKp3PFGgWi9v0b+nqzH1DA5C2GrRJJfD1qGHVz3lPCEwq3i7AMMZxCX5q2MeC3o0Ysefsp8oxHuVtHcVKTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RNYYeP2WoEtfwMINmCboSPMspPL38A42Pfs0MlV+L5M=;
 b=JnRqowug3LOMK5EQCc3Kh/641QaVshxyBMgQmC/TepCoavbsT/Tpvi6ne9d4/MWw0tOkuefsSFqVbIG9x5tsrSXOwGe913qQVRlnMco+9mXeEJCJA1dxPh3uiN0WcOP1WkJKw/5gxTTZyPDvS8D2imViEMY2AFAKWvhm24Rv0hQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by AM9PR04MB8100.eurprd04.prod.outlook.com (2603:10a6:20b:3e3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Wed, 22 Mar
 2023 05:14:02 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::89aa:9204:790d:e46b]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::89aa:9204:790d:e46b%5]) with mapi id 15.20.6178.037; Wed, 22 Mar 2023
 05:14:01 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, mirela.rabulea@oss.nxp.com,
        hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, xiahong.bao@nxp.com, linux-imx@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v5 05/10] media: Add BGR48_12 video format
Date:   Wed, 22 Mar 2023 13:13:08 +0800
Message-Id: <c89dd098c08ac7371c64ce951665296b6c8dc3ed.1679461710.git.ming.qian@nxp.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1679461709.git.ming.qian@nxp.com>
References: <cover.1679461709.git.ming.qian@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0021.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::14) To AM6PR04MB6341.eurprd04.prod.outlook.com
 (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB6341:EE_|AM9PR04MB8100:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fde2a09-7f84-40fd-30dc-08db2a943fd8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yQm9o3+8+AoD4PRp32FgCk48sTIDykk3lc9xpU/pM1Zyhk3H5gbOiR6ogffGqrp+7n5I1dmpWFMpdOGOWqLNX6aymuiNcjXKSkP0ofexWIgunLAtYljLtNfQDgr91FMYDJFxZfd6NUNBQtbGvo4i9fZLcxD1UB/SdNC+KXXNYnsmz5TKjhN7mxMtJ0EZECjrYkZB7NyfoWsHvLXyj9nvCmvbn0eM/4IzqW3YchY3XoJTj35GZR7jrYIOYZQ7FLs6Lbls7esX1fbsmYy7gK2e8r4vr4qiQaFW8LdvgosadMbfXKPtSscxYqDMPy8M8J5wXUlwnhrSsWvEQl1K9yK1gXqUSUOY6h/GunFs00ApP5amUxomKph8uP+A/k8o3L7lBq7y/LeA4TTJWjkka74gDF9u8C+bevQClWQggKXU6iiaOqkKZ4tz+ftGsR4dNaI7JLKaWpVfXkeLe3QEHICPnoz4QI5r2juJyt+vQ1rfQukHlICjuPLa9HWzPoT83l/+oSWC2UBWB7eTUcKUbdZ+pGpoPFGUSQCm9JI+NUiRJUKZk/kiQJRxEcYk91iTeWyHqryg/jNf8eGNN2QHIYQj5pBwpL0sylxEEWxkqbJeO0waZKQbrRJd4p3BrvQV/3USmPwB/JUJoBMyR8vqrEpQWFU45vdoNaBqKrlI6mkwTpPA9dkVjM9H6G0fTEIWXvL/X8pxWX6TF6ZRm+HWQSaA4A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(366004)(136003)(39860400002)(376002)(396003)(451199018)(6486002)(66556008)(41300700001)(52116002)(66476007)(7416002)(478600001)(66946007)(5660300002)(8936002)(8676002)(316002)(44832011)(4326008)(36756003)(86362001)(6506007)(6512007)(186003)(26005)(2616005)(2906002)(38350700002)(38100700002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KX/9aMnRt+YUwMwwg/9QuNpt98tK/1kz18Eeb/ZgRQ5/Tdg42uufzRU4cooH?=
 =?us-ascii?Q?iuwDOA9eK8TDAKLNJoUZns08EAvR0jhSfds6H8voYA/MmhFANoHKPI3WMWSo?=
 =?us-ascii?Q?dhfC7H2zRkaN+xS1F+U6cnQW0SWLeOJaCF4rPxLP6HXHUPa/5Or1C5AH8Mv3?=
 =?us-ascii?Q?kJaCnsIGrrxBozgG2lVttNyb4VE5IBGIbiz5uYOrlrYr43bDiU6w6T43cfqi?=
 =?us-ascii?Q?oNG+OfZW0s1HaqiuJMHshEAgZrMEfm+GZkdioDtfeClAFSwsObZoaypH8zq1?=
 =?us-ascii?Q?iT5chrUY+lTzAUpCu17wfg8ahY2zKkdeHes2cg21/Q8GaDuyPK7mgMxTpTY5?=
 =?us-ascii?Q?aWcEvmHRspaCBgavA3tjl4xSO/bhwDmJER8mku3NVDyR16+zS8SiYp/3oek3?=
 =?us-ascii?Q?NS1FNphk5Z5qavkNL61OsUA3R1AwFEYbQwaat9VSzkuK6VCfL4FSrwpl1PPa?=
 =?us-ascii?Q?bFYn1dfQ01/oAiRF1yLNzjunumEAgSISD+6RCrKaU3U1i4asSXwGGA+KxMse?=
 =?us-ascii?Q?W+IDoJMUZWgV1+qylM/LcUsfSooat0QSjRNKy290bZAcoiPE0o1Aj3JqBeRU?=
 =?us-ascii?Q?uvMDWo9bS3cgT7H4OT9IONVCXKFYFXh9TPPwVnRDDkMre1jMZoqEGuU0xSbZ?=
 =?us-ascii?Q?2xi7jlhm0HN5UftumjpVxL4OUCLzX7WfQvbSPdeZ/CBfvtcjaiRyLujuSdKe?=
 =?us-ascii?Q?QQAyaDFEiZ2ghmChMamTJ7f1EPwXhcQhF3/gDIjVhWUY6hpuvv1w2ZxzdKRT?=
 =?us-ascii?Q?4dBGll1fBp6+8sZ2fqw9k+yoGMriddj/2cUYUiwTUN84x28x966/D4jr/13Q?=
 =?us-ascii?Q?6qT+ywnyQ9Flise4f9xfxzn9xuR8fLr0xj9LHhTRMMh3NYzsYrcIjOrK5AMh?=
 =?us-ascii?Q?O6FDbbMhgrlqzjOLIj0FLjIkWMjzUJCI7aKOFFnw97nNtxmDr/rbjgGChLu8?=
 =?us-ascii?Q?AhtMtYy6PEuGxalzuYREXoqBpAHkPHZJaodG7JiZES7BZ/n3bsf3h0GTkAZP?=
 =?us-ascii?Q?QnHWv2+KkThCxPO9qzbkTAB3CqjVE8ikth/sKwKP4+KQwo7PZkcTlQrPj5Ha?=
 =?us-ascii?Q?pX6MVw2ih9lw/9TSCDdLFABNEieNRNoKvSgTgtENTJVyNRvjpT6xgRZAuty4?=
 =?us-ascii?Q?6aaudm7y+GcWQ52IdYxbR21ayAFLmt03Q3RaG/e3o6XKLntEfGSrysoE7mXI?=
 =?us-ascii?Q?n/zdRRQqgKyGjqxLCdPY224oVm6EVeB0utX2frlTDdZqmxgx4FBxcEPFuoLr?=
 =?us-ascii?Q?fcXrPfma6orkYItqlwb8GO+Gz/n7CXyWDachyyFFHYiqrRAWoQGlrTcL4WR0?=
 =?us-ascii?Q?iAhZSP689USPhijfdPq0Yh5TsCh1q7nENTNsy7I0JpbQX1jqDNR8+ONomCxC?=
 =?us-ascii?Q?cmOSjCafYDGnW93CjSCJnZHZSa+06u+jS+rLKum6ruy52lPVmdHX6Mtihrgc?=
 =?us-ascii?Q?PasNoCO2g8PohdaCqKtJAaD0L93MNpVikI95+4vMOOwu/o4MadL7ZTijCsGN?=
 =?us-ascii?Q?Yu3P3PIW5cicHhQ+QTs7Gvut3wKU4gisi2BldCCILBopyGcJmtXrr7IAnncB?=
 =?us-ascii?Q?4ucbi6d+YcCLDZyhvd5D18lhMbL2PBeU+56KTxe2?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fde2a09-7f84-40fd-30dc-08db2a943fd8
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2023 05:14:01.9435
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pKd1Ms+EjE1CdRKJm1wpEPH7e2+9fVgtRK8454//7EGAM4r5lM2d6GVcuu8O6hGnFpmnP1qBtKzDHPMetCaRKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8100
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

BGR48_12 is a reversed RGB format with 12 bits per component like BGR24,
expanded to 16bits.
Data in the 12 high bits, zeros in the 4 low bits,
arranged in little endian order.

Signed-off-by: Ming Qian <ming.qian@nxp.com>
---
 .../userspace-api/media/v4l/pixfmt-rgb.rst    | 33 +++++++++++++++++++
 drivers/media/v4l2-core/v4l2-common.c         |  1 +
 drivers/media/v4l2-core/v4l2-ioctl.c          |  1 +
 include/uapi/linux/videodev2.h                |  3 ++
 4 files changed, 38 insertions(+)

diff --git a/Documentation/userspace-api/media/v4l/pixfmt-rgb.rst b/Documentation/userspace-api/media/v4l/pixfmt-rgb.rst
index d330aeb4d3eb..779f0bdda642 100644
--- a/Documentation/userspace-api/media/v4l/pixfmt-rgb.rst
+++ b/Documentation/userspace-api/media/v4l/pixfmt-rgb.rst
@@ -956,6 +956,39 @@ number of bits for each component.
 
     \endgroup
 
+12 Bits Per Component
+==============================
+
+These formats store an RGB triplet in six or eight bytes, with 12 bits per component.
+Expand the bits per component to 16 bits, data in the high bits, zeros in the low bits,
+arranged in little endian order.
+
+.. raw:: latex
+
+    \small
+
+.. flat-table:: RGB Formats With 12 Bits Per Component
+    :header-rows:  1
+
+    * - Identifier
+      - Code
+      - Byte 1-0
+      - Byte 3-2
+      - Byte 5-4
+      - Byte 7-6
+    * .. _V4L2-PIX-FMT-BGR48-12:
+
+      - ``V4L2_PIX_FMT_BGR48_12``
+      - 'B312'
+
+      - B\ :sub:`15-4`
+      - G\ :sub:`15-4`
+      - R\ :sub:`15-4`
+      -
+
+.. raw:: latex
+
+    \normalsize
 
 Deprecated RGB Formats
 ======================
diff --git a/drivers/media/v4l2-core/v4l2-common.c b/drivers/media/v4l2-core/v4l2-common.c
index da313a0637de..16d3c91c7da2 100644
--- a/drivers/media/v4l2-core/v4l2-common.c
+++ b/drivers/media/v4l2-core/v4l2-common.c
@@ -252,6 +252,7 @@ const struct v4l2_format_info *v4l2_format_info(u32 format)
 		{ .format = V4L2_PIX_FMT_RGB565,  .pixel_enc = V4L2_PIXEL_ENC_RGB, .mem_planes = 1, .comp_planes = 1, .bpp = { 2, 0, 0, 0 }, .hdiv = 1, .vdiv = 1 },
 		{ .format = V4L2_PIX_FMT_RGB555,  .pixel_enc = V4L2_PIXEL_ENC_RGB, .mem_planes = 1, .comp_planes = 1, .bpp = { 2, 0, 0, 0 }, .hdiv = 1, .vdiv = 1 },
 		{ .format = V4L2_PIX_FMT_BGR666,  .pixel_enc = V4L2_PIXEL_ENC_RGB, .mem_planes = 1, .comp_planes = 1, .bpp = { 4, 0, 0, 0 }, .hdiv = 1, .vdiv = 1 },
+		{ .format = V4L2_PIX_FMT_BGR48_12, .pixel_enc = V4L2_PIXEL_ENC_RGB, .mem_planes = 1, .comp_planes = 1, .bpp = { 6, 0, 0, 0 }, .hdiv = 1, .vdiv = 1 },
 
 		/* YUV packed formats */
 		{ .format = V4L2_PIX_FMT_YUYV,    .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 1, .comp_planes = 1, .bpp = { 2, 0, 0, 0 }, .hdiv = 2, .vdiv = 1 },
diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-core/v4l2-ioctl.c
index 7225e566c528..3490eb3f42e4 100644
--- a/drivers/media/v4l2-core/v4l2-ioctl.c
+++ b/drivers/media/v4l2-core/v4l2-ioctl.c
@@ -1302,6 +1302,7 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtdesc *fmt)
 	case V4L2_PIX_FMT_RGBX1010102:	descr = "32-bit RGBX 10-10-10-2"; break;
 	case V4L2_PIX_FMT_RGBA1010102:	descr = "32-bit RGBA 10-10-10-2"; break;
 	case V4L2_PIX_FMT_ARGB2101010:	descr = "32-bit ARGB 2-10-10-10"; break;
+	case V4L2_PIX_FMT_BGR48_12:	descr = "12-bit Depth BGR"; break;
 	case V4L2_PIX_FMT_GREY:		descr = "8-bit Greyscale"; break;
 	case V4L2_PIX_FMT_Y4:		descr = "4-bit Greyscale"; break;
 	case V4L2_PIX_FMT_Y6:		descr = "6-bit Greyscale"; break;
diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
index 8a6430bc4a00..3c5acd72606c 100644
--- a/include/uapi/linux/videodev2.h
+++ b/include/uapi/linux/videodev2.h
@@ -580,6 +580,9 @@ struct v4l2_pix_format {
 #define V4L2_PIX_FMT_RGBA1010102 v4l2_fourcc('R', 'A', '3', '0') /* 32  RGBA-10-10-10-2 */
 #define V4L2_PIX_FMT_ARGB2101010 v4l2_fourcc('A', 'R', '3', '0') /* 32  ARGB-2-10-10-10 */
 
+/* RGB formats (6 or 8 bytes per pixel) */
+#define V4L2_PIX_FMT_BGR48_12    v4l2_fourcc('B', '3', '1', '2') /* 48  BGR 12-bit per component */
+
 /* Grey formats */
 #define V4L2_PIX_FMT_GREY    v4l2_fourcc('G', 'R', 'E', 'Y') /*  8  Greyscale     */
 #define V4L2_PIX_FMT_Y4      v4l2_fourcc('Y', '0', '4', ' ') /*  4  Greyscale     */
-- 
2.38.1

