Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C1F4651969
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 04:13:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbiLTDNm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 22:13:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233126AbiLTDNS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 22:13:18 -0500
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2078.outbound.protection.outlook.com [40.107.15.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B05BE15807;
        Mon, 19 Dec 2022 19:12:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=digdfR0kSEC+yqpZdV3hLaPsfdZ2GK3jZyGWJkbLRUlsz2tgCjL/7pyK0RdJ93Qy8cAE9ZV0X46wt0UsG63MgcXLhn/GrDW7EdYdfg0ehR223/ha2BbIfZOQd0qrfvo1lY6USPeAv1afh4sNYnE0Pk5x8Xw6KM5+YrkPzsoHM87miI5V3l6wSevcEftF60ZPqUJvMvZLE0MgSRcM+eqaqaYx8upg/3bp+n54tp+TcWrkJiesklrjpDjj9Azc2TLkr0x+D3WuXHJ2D7+Qrklm444bR5AG0TjyuJSPeSwWrLfb/kIsHoxZSdzGzjwNEcpjZpPYF64wBYLZIA4wmQnaVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/WnNYiad6tygjPwmw3EFwqU6eGmAf/6+8ZRHrgjUCc0=;
 b=cMTI3VHWwgp06HmRPcn/s8vwAusdgqMTKXfBfb7oDoraTP1qU/UhFcHSpWIhgEEf3aJPheSme1XkP0vlQ9PcMqyZQPIqz8to4OcybGEiCl2E2svrvinzxZtmAozR4lqO7n9J+RoGXbEbywgEKBNmiJJIujbuUSvUHXJb5Ckj6iixInJ8K6a7HLZjZrJ7WY0fqSKC/SaiTkYynAIatfb4YuCmPREdSurzqloZJvYxGY4jWKGQ22OI/lN0HhmYcUDDAIamFOiBWqn2p/7BaPKtuBX2JjBfmRq3O7NyP4CePSbXlDdLUEmbLhrBX/HQSntam2HH5aSmZPo1EZiAQS8j2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/WnNYiad6tygjPwmw3EFwqU6eGmAf/6+8ZRHrgjUCc0=;
 b=WomW4RqXXu8ZWxOIKoSVYRb6QckUzROP1SlJfEbIjdjok56eYHag8ewvY8nGr/vFmIB6RmWS58AkiKqPywpb/sk7GSfayLDHyZkz6ycgt9pRNuzzKqLGw7zUDQY0rgaI3pa07Y3euAMGK+er1T8K5M6WHrmmwi3OyuQMrKABaa4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by AS1PR04MB9405.eurprd04.prod.outlook.com (2603:10a6:20b:4db::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Tue, 20 Dec
 2022 03:12:40 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::3a82:42b3:f1ed:5c3d]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::3a82:42b3:f1ed:5c3d%7]) with mapi id 15.20.5924.016; Tue, 20 Dec 2022
 03:12:40 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, mirela.rabulea@oss.nxp.com,
        hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, xiahong.bao@nxp.com, linux-imx@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 06/10] media: Add B412 video format
Date:   Tue, 20 Dec 2022 11:11:36 +0800
Message-Id: <86983e95cfd05ba9b3b4688e25b58e96ab23d185.1671071730.git.ming.qian@nxp.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1671071730.git.ming.qian@nxp.com>
References: <cover.1671071730.git.ming.qian@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0014.apcprd04.prod.outlook.com
 (2603:1096:4:197::18) To AM6PR04MB6341.eurprd04.prod.outlook.com
 (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB6341:EE_|AS1PR04MB9405:EE_
X-MS-Office365-Filtering-Correlation-Id: 924bbe90-35ef-4fdd-9198-08dae2380d6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ueYEZTp1dnATx+210r+1x5bIA6en9cAELuCrlScDH68PJYxDLvXAZdk4obK7LY757iXCjllJ6a59Ar4ishHRkiwL9QBxYBW1gCxD59IH2Q36safvKDqHFwc027ftiTtyEWlzztQbuc4apvmoLI6eOb4oHGj/e1FhDfcH5UsJjIUrX9Au0u5Mwf+zRjsbxIBL1v8/HWbJRPeV/y71bhC6rWkvaWLcEsPLhksBlUN5yFgUlIFHfcNGvqmRq7nSlGbRyCujTe1DQGeJO/aTlHWggkdOxHEYimutAzKsIjr0XgDi/vbCpy8JXzhHmUWhBB/ndgxnMKPYALZI5walbl8gsOIygPty7qiW+q3uZ/z1gYRWhVt344PkvILsS75lEm/Ew0b6O8weJotrEUSZ5h8KVhKLrWXdL8h//DUXWIeTIGZlJqJCq/GOfNBVM+ayk5J5bClGHD/tzDh75MFyi+juYosdjpwIO63u7441mVvvE4R+3p4Kg18p0wuyRmA6KgNRdervJ8/wKlMdRfX680oRB4agzSgAI+m+7NMVA/82pthgy+1m7TFS/rmnRwQl6B/1pGYgouUcCUsr+g/tfgMIUfeiQ66GwcSwkhK2NxHRxc2j/1MhMSm1hU68NODwSJnp6OpSVruiMgmrqZTk2EBaxPn6XEcZAhJMlz7i6Zk3mQ9TYB0srtHc3RotGpJMQWBRueNXt+1ojjkAqlI3FjL0lg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(396003)(366004)(39860400002)(346002)(451199015)(36756003)(86362001)(478600001)(316002)(6486002)(66476007)(8676002)(52116002)(7416002)(2906002)(6666004)(5660300002)(44832011)(66946007)(41300700001)(8936002)(66556008)(4326008)(6506007)(38100700002)(26005)(38350700002)(6512007)(186003)(83380400001)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Rh49TpMVSxzDvW3KY+wkJoUC4HQgiBVuEXfkn3fW8izzUPxEI3c8q01Z3CAo?=
 =?us-ascii?Q?uavLf714EW943NFOoS36cQVgBSvmHq2BxpExXzG6TnBGultDyxim8MqybfiB?=
 =?us-ascii?Q?Zhri05OM7mhDP9/j9c7G3X17lHPmv22wRF0XF87XWXWIXWoDhft/SNXs/Y7F?=
 =?us-ascii?Q?fVjBaJ9KlhWxA9lL1VSvP5cdbaw1FZNQFs+nlXtnz7ojjndUEw1MU0yhwF2p?=
 =?us-ascii?Q?n+ERJuMV9huTpbIJsPHspAK6epavHG0jv4Z0QfmXe7a/XAtmrhER4eRjoEFA?=
 =?us-ascii?Q?w7wtB6ufC3uiN/U/hC6PHYhpQPHedgcTE8vv/7uwbR5M88+Y5Xi+1fLqzFjF?=
 =?us-ascii?Q?EpFNhS815FS+d0fKSA8r16AIn666R3VwHQ3NipQwZFc0cBIY7/Y7kEFEbyXr?=
 =?us-ascii?Q?LyCXRo/PAqHWJXA/GcYxr9ziJgnN6/je/jHs/Y+6XRZVfuFNWOqu/LCavWGs?=
 =?us-ascii?Q?gB3+znfLHi9nUlISG2VrU88hwMd7ersrB2nSw8+6nE6v9Za+c5eiHavQTFsn?=
 =?us-ascii?Q?ZymPDgU8t2UVh5fy2FQWYdIAy84mbtgsZfbU2U4WX0cqK0T0ISoJrsRMSUB5?=
 =?us-ascii?Q?vzMW/BsfMWtwWEQqaPDY+AQSiqBY3Pmn2bahiyLlpsFqponDhsCDMXp5nAOs?=
 =?us-ascii?Q?DQjgf7VdFqhyqWPPSon1Vakmx8NR6vFRg7WbLYnSlS6EsvkRQYXlip4OAm+t?=
 =?us-ascii?Q?MMztn5vEFw3BeQIGbkoIsfxsXqlRK8N0DyGL0WC4U35XtAJqztTABGYW8Ly8?=
 =?us-ascii?Q?w9eCIOtyt5SybZUpN16R4NAnV8DEGcWdP/aH1uIddI4GEvFyAHZh92EPg++b?=
 =?us-ascii?Q?IgBMGIcK+VxNrWM26urY2O6b3Uc5jpcJckPFkJEugDSKHdp5Z6VcO0wKEyDw?=
 =?us-ascii?Q?Uh0eoiJOdM75PEOp3jVwuGRZlfQZ+rGeuGEHY+Y2a+TUZ4Mx2hvcP0e+8HHS?=
 =?us-ascii?Q?OJdRy92taMSeb3IxBFp6aLHxC3tpLsQTNqMNSqUWu5EzFfgnu2+erE8HIp7L?=
 =?us-ascii?Q?79ghkk3rRRMVl5Wux5BEptxoBzs0hVJPxPf+jVmhVFbFGUnv05qI3RGHGex3?=
 =?us-ascii?Q?lsymzv02inBusXq3uM94POVi+LZkzOFRWoyGAZpa6xd3OvvhnbnhVgvZeIKF?=
 =?us-ascii?Q?4QkB1ysK29WtI2o584Ff0d0zWqR+fNemypMz3CXLeZExNixQ0Ihy/JDqBI6h?=
 =?us-ascii?Q?J94tJTLFI0mtUd9V6iAlOwvgiGX4wxthDWpKfMkNFGD4acNJfWI3TWqX3SML?=
 =?us-ascii?Q?H/ovcAcPxX0T2nQD9IzV6X5fig6v+0o4/F+5g9VmEK1hnAQj122skiqHOS7L?=
 =?us-ascii?Q?KeNO13+K/Ear3I7SzI9aEZHw4TOvknD9wxu8qgLG06o2ucQ1nFBAAbJ+v3xu?=
 =?us-ascii?Q?kSwHE9vX5kAWegl9XbzlGDz1FJhVCFT0o9BLdVAGrbkv8jqlG/kjs0VgvVuv?=
 =?us-ascii?Q?aLUJKIKiYZowogzRNBC+KypKdGzZlSm7wmZVPkAIbl8Sr8I6VzGwN/zOeEEn?=
 =?us-ascii?Q?fpRaOWc88wPHiCuPnApmYu8ZVr7faDOir44EYie2ghiHBtDeofmo4QANMz6m?=
 =?us-ascii?Q?8xLaYdxYbPIuP5bpYF3hAU4ndln2N8H52cjuw7+7?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 924bbe90-35ef-4fdd-9198-08dae2380d6d
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2022 03:12:39.9551
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FgqChrCwb+YUy5kWq4Z5UmFsrOOMj5/AbyQUWqhF7gQooPsgv/GhSXB2C5nztT8yvReun9c5urHEuVv95R/ZNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9405
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

B412 is a reversed RGB format with alpha channel last,
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
index f7785c93292a..b9d1e48c0224 100644
--- a/Documentation/userspace-api/media/v4l/pixfmt-rgb.rst
+++ b/Documentation/userspace-api/media/v4l/pixfmt-rgb.rst
@@ -793,6 +793,15 @@ arranged in little endian order.
       - G\ :sub:`15-4`
       - R\ :sub:`15-4`
       -
+    * .. _V4L2-PIX-FMT-B412:
+
+      - ``V4L2_PIX_FMT_B412``
+      - 'B412'
+
+      - B\ :sub:`15-4`
+      - G\ :sub:`15-4`
+      - R\ :sub:`15-4`
+      - A\ :sub:`15-4`
 
 .. raw:: latex
 
diff --git a/drivers/media/v4l2-core/v4l2-common.c b/drivers/media/v4l2-core/v4l2-common.c
index 0cc58abae562..5384648903a9 100644
--- a/drivers/media/v4l2-core/v4l2-common.c
+++ b/drivers/media/v4l2-core/v4l2-common.c
@@ -253,6 +253,7 @@ const struct v4l2_format_info *v4l2_format_info(u32 format)
 		{ .format = V4L2_PIX_FMT_RGB555,  .pixel_enc = V4L2_PIXEL_ENC_RGB, .mem_planes = 1, .comp_planes = 1, .bpp = { 2, 0, 0, 0 }, .hdiv = 1, .vdiv = 1 },
 		{ .format = V4L2_PIX_FMT_BGR666,  .pixel_enc = V4L2_PIXEL_ENC_RGB, .mem_planes = 1, .comp_planes = 1, .bpp = { 4, 0, 0, 0 }, .hdiv = 1, .vdiv = 1 },
 		{ .format = V4L2_PIX_FMT_B312,    .pixel_enc = V4L2_PIXEL_ENC_RGB, .mem_planes = 1, .comp_planes = 1, .bpp = { 6, 0, 0, 0 }, .hdiv = 1, .vdiv = 1 },
+		{ .format = V4L2_PIX_FMT_B412,    .pixel_enc = V4L2_PIXEL_ENC_RGB, .mem_planes = 1, .comp_planes = 1, .bpp = { 8, 0, 0, 0 }, .hdiv = 1, .vdiv = 1 },
 
 		/* YUV packed formats */
 		{ .format = V4L2_PIX_FMT_YUYV,    .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 1, .comp_planes = 1, .bpp = { 2, 0, 0, 0 }, .hdiv = 2, .vdiv = 1 },
diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-core/v4l2-ioctl.c
index 8c3d40d3acf5..8cb21024bd96 100644
--- a/drivers/media/v4l2-core/v4l2-ioctl.c
+++ b/drivers/media/v4l2-core/v4l2-ioctl.c
@@ -1299,6 +1299,7 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtdesc *fmt)
 	case V4L2_PIX_FMT_RGBA32:	descr = "32-bit RGBA 8-8-8-8"; break;
 	case V4L2_PIX_FMT_RGBX32:	descr = "32-bit RGBX 8-8-8-8"; break;
 	case V4L2_PIX_FMT_B312:		descr = "12-bit Depth BGR"; break;
+	case V4L2_PIX_FMT_B412:		descr = "12-bit Depth BGRA"; break;
 	case V4L2_PIX_FMT_GREY:		descr = "8-bit Greyscale"; break;
 	case V4L2_PIX_FMT_Y4:		descr = "4-bit Greyscale"; break;
 	case V4L2_PIX_FMT_Y6:		descr = "6-bit Greyscale"; break;
diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
index c67f895210de..a26ff16a52c8 100644
--- a/include/uapi/linux/videodev2.h
+++ b/include/uapi/linux/videodev2.h
@@ -579,6 +579,7 @@ struct v4l2_pix_format {
 
 /* RGB formats (6 or 8 bytes per pixel) */
 #define V4L2_PIX_FMT_B312    v4l2_fourcc('B', '3', '1', '2') /* 48  BGR 12-bit per component */
+#define V4L2_PIX_FMT_B412    v4l2_fourcc('B', '4', '1', '2') /* 64  BGRA 12-bit per component */
 
 /* Grey formats */
 #define V4L2_PIX_FMT_GREY    v4l2_fourcc('G', 'R', 'E', 'Y') /*  8  Greyscale     */
-- 
2.38.1

