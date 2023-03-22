Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F062B6C41DC
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 06:13:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbjCVFNy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 01:13:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbjCVFNv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 01:13:51 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2059.outbound.protection.outlook.com [40.107.20.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15B875098D;
        Tue, 21 Mar 2023 22:13:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SsmaRKjxlBTpVGz4btuHUkLZXPDS3Ysb6lK6ivAOrPeF1zl7b0OtK4XGbo6KM/SQGHXC0ZMD8OtjXOSRsE0JmJ6RYyFz6CTCR31DvJOShMUiaAOPI/+8IuHqJAJVf20PTK/KB5YHhqGhpRclLn0XHugW2r2PGn2Cy+hO/bnvvP5ifhwjqHZI9JQZfiKVQbUUSEGQMC4TSC5NxDcfguvbgqA0Z1H7HjoKDSQJZ7EQtTl5LDullDUEyLQXRuFWZcjB0ONiJvrHoDeMyNOWpifwguIF43hae7tXDFunFxRmr9/SLLiaCv3pN9rZSdgbjlIGtJskXO5xXD2dOZ7x6j0Thw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rlj9RD2tTi9bXNFXB378vqR8wVFI1TNqBoqCx6xlqu4=;
 b=T2UAo5EYO7ySJAJl5CLarjoaeYhcRcN75kFR/q1wHBPI8NGJGWmFn3xxG6CLLmdgrvG5LYSEDspP3QGYU3P/hJqbZkFq1g+0vQ397Xi1tAvZAYphjpdUQocDA+DQwBsydWwANgsmfq7iU2dEhkEiQLZLJqnctcRPgaT1pTQNIs2/w/lipgAOyhQANb7vTrL+A0oZeDr26sK1EXwWyPbJj3V51jjbGeWKcDaP5dq+IzrffeSKbrRANJShvHtKmrNU6P1O4oA5LWPVoOmJfANMW021r0z4zgub4jNOHBbZw75hQmTCcqwx3FTHbEHBNNWKXLQOCKO+zXDkf7h6Be2+mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rlj9RD2tTi9bXNFXB378vqR8wVFI1TNqBoqCx6xlqu4=;
 b=ijXrgMDZHyind38sIv3RgVglLvDCxJI3nEhF3IslzZcYEr+bg75RmXdM2c1fcVKarMiDxVYmC6Kzhwe2oe707VyKLnsQZcNUthe1D32Dglrgf9ZrVnzWZ3VAS4pIvXi7l00UKFLuxRhDlK4k0KgwHIcvKC2rjG97myLmtq9nPOE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by AM9PR04MB8100.eurprd04.prod.outlook.com (2603:10a6:20b:3e3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Wed, 22 Mar
 2023 05:13:46 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::89aa:9204:790d:e46b]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::89aa:9204:790d:e46b%5]) with mapi id 15.20.6178.037; Wed, 22 Mar 2023
 05:13:46 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, mirela.rabulea@oss.nxp.com,
        hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, xiahong.bao@nxp.com, linux-imx@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v5 01/10] media: Add P012 and P012M video format
Date:   Wed, 22 Mar 2023 13:13:04 +0800
Message-Id: <475b9d0584bc9360eea277f39c3fee1837ef232b.1679461709.git.ming.qian@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: cbef7621-bd28-4be6-5a6e-08db2a9436c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x4iHTOB0vFv8X7OO1Q4Dlz4nXJ5EAv7pTQVSmjaH2ZVFDX1Sl0ma38vHNgy4cVobUJlVj2WRcYIfb7wPinucKkwVEHxqELVNgwMAevVhqdviHthYnDZiG05i9o5ddFj8RfWbaAA9Zk0cHankTLz6xDFFgwsgitRFOlNnvrwJ7QCfl0As9w9BD4DvgzAfMFnj2jUf7QIYQ6lCITWgvD57aM9l1RTV/ShzVEUGflNY+utluwgujnxv5Vj/ms7HD6AqKMM6XDBfU6ttj1Y3VDPZYdCE3fJ9evfc8NLEBKLcxsIjH4nuDpAc92uCz0FsoRvBNGXiPSetLRAM8o0T2YnQgjnzjzWIVJlBm1JCC6UYbdwYGVrtjEdvcNdcaVjhePJEdIzO62yMe+TJ/V3t7FI/+ZXwPw/q94V4S2hn6QNU890xUYFu+XTw7fdtq+T2SjMeUGX1d5be18DhD/Lj8My87viDXegpsw0IPGVtKUxTh6Smv34vftJAthksrZl2Lh39lIO1ta8BXPt7ZFv0RaVmhEFRkg4aXrg/kMYMTZ64Y9o77CN0vxB/wzqbKW7c97GGVJxOf7AMA2c0q6OHUo3MsZa20SbOu7NlXr7ev7YaVREmY5yXIcdECSl1w9e9SDDg0gcgP2uoDScxUoBOj6Ya9oKziuDjC559RGx/1c+kCHclbWyf5JuxDWT4Y+E4hPis2Ues/kep2LsP8pTewR89PA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(366004)(136003)(39860400002)(376002)(396003)(451199018)(6486002)(66556008)(41300700001)(52116002)(66476007)(7416002)(478600001)(66946007)(5660300002)(8936002)(8676002)(316002)(44832011)(4326008)(36756003)(86362001)(6506007)(6512007)(186003)(26005)(6666004)(2616005)(2906002)(38350700002)(38100700002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3puPMPXUv6/Ez8wNhHSfIsWQ9s/PE7+COw79mXTM1AuMjcNZrVwKD8GoMFAK?=
 =?us-ascii?Q?rTrKVIzExhFGbndO5Xwe39x3Es7/rGq6gVLtXYpVP2M/PVTFk9uGnjJFBsW/?=
 =?us-ascii?Q?QZymH2xcwkBLP0WBaWOpdjpFQlQoOTVvPDqfiJnqsZngXPQKa2UvFxAj86MZ?=
 =?us-ascii?Q?dnBsU8/NVI3ADEIvLo7ZYNChxXCEWfcpAbaLVC0qgr6DHDZqy3R02YD6mTaG?=
 =?us-ascii?Q?prFK8hhuxn70IL5BIbsfTQIYftl/49Ft2pEvHKVU3+6aKBjg8bmg206VdrLY?=
 =?us-ascii?Q?oDsmGiN0ONnecYn/cUqtjBHyEOU2cNbMax6KEfV8JEvprjfjjl8Wz8AYnkwO?=
 =?us-ascii?Q?Ko+I4u638L8Zh8h0aDHJWhCawhiFoxll6FETEwXqQI1kTiDSuhWlAzSFqKZp?=
 =?us-ascii?Q?qF9Sl23Y0FJREbCCDVSx43QNSq8O0b1O4AsywvGrqIXgxhXnjMxxcBmmkSDJ?=
 =?us-ascii?Q?c94L8lpxzKlsf3/YT5ytBAyWcZsUBdgD5xQvWMWkgk+PwyAfNduEjp6JgF+o?=
 =?us-ascii?Q?u29manx508fSCXfsqYCAl2rl3c33oeCHD2nmpmbUWbi0EEkWJGnMZz4CJW20?=
 =?us-ascii?Q?ybdblZng4rGYRZba7F15XBkhnEBP9rPdwJU3voffER+eOtFyD0ATjW7o3F+e?=
 =?us-ascii?Q?R9a9ulQITkpnw/Ysv6UBr4KMvHvz7ZrnNhrNImWr3qMLywxtmaRYOuif3llg?=
 =?us-ascii?Q?j5v3KgyDqz+ub01SBe2BhiwyZ/ocvxN4QgmUBAANu2mqjqs5tBVWgeu7Gk0E?=
 =?us-ascii?Q?mYXBH9NsHESB9TWet8ozwae095J0612TGDEy+i1rc7kIHn5GOto+b1QFuS9L?=
 =?us-ascii?Q?Q5rO+faeQbzM3nFhowuDfnkn7LAZkjvZJ9v7mU5Wq+Nbp78OYjkzDnyJjppN?=
 =?us-ascii?Q?N2B2hpUHe7bOhzLR9IH/dM+pRvmH5EMk9CsQ3a5eKKlsK+rX720y3BraOv6h?=
 =?us-ascii?Q?DcyX643XIDWsTw7K9gbPTD2zSk/JKlyPbGIcMLLJAJ70PuF5yz2CvgZEVEiw?=
 =?us-ascii?Q?uOSsFgj2nOL/GcVNr3FCpOBS65IfJLQ8WlYrSHX6TdvocLRaVRlD8KWD27Td?=
 =?us-ascii?Q?35wyde7C1IXNz95SEzdt5q5JF4Uc7JE0HLcoDDko9hIuxuwjB+sdHM/Wz9vB?=
 =?us-ascii?Q?ljJvvD4hvb5gyBWV+jXBriHa6Jnn62nK3d2EMOHMnekfZXfeZfpkFXZtymvC?=
 =?us-ascii?Q?U/x0kSM/AxJmDxXlSg/iq8dmeLuwPfPn81vEMG8OrdzMNP/tlLLD1IEzBCHw?=
 =?us-ascii?Q?wZQ41bRalBARR1/Y8n4hk5z5Vg0ie3cK1/ZFxmjfUCkFla3/qwgfiypNS34i?=
 =?us-ascii?Q?1HDtdd7KvmuMc5PjrRz6PlJoJ6i6ztip+ITFKAMVGgxCIYNsZsiyIdIRswie?=
 =?us-ascii?Q?fi7aUy1NHq34SsMoF7pO92pndYni7NE6KHBmNJAfuQCO7TIXQG2Hglzxb3L4?=
 =?us-ascii?Q?uvrtSeHSSN+FNfKNCqKvU8GfbxRt/1VExcPa/SMo1pZ17fzIaaph3ZxQZuK5?=
 =?us-ascii?Q?A0pKOj4oSuQ4CZDB/892wOLFNuFwBKuOavRXbuAiFGE7sNKR9e6zpcdWd8Nr?=
 =?us-ascii?Q?aKMNy7bPhgcso18ji/52Aol5b16lpYwo0wgQftvY?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbef7621-bd28-4be6-5a6e-08db2a9436c1
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2023 05:13:46.6943
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sp8/jNe8qYPFR1MT8MMY8YqGY/zYoaamJcq8Fj07D4uDNFWqtizLo3MeLBQ0tmXxzUv5jahN0eYdidcCU6S8+A==
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

P012 is a YUV format with 12-bits per component with interleaved UV,
like NV12, expanded to 16 bits.
Data in the 12 high bits, zeros in the 4 low bits,
arranged in little endian order.
And P012M has two non contiguous planes.

Signed-off-by: Ming Qian <ming.qian@nxp.com>
---
 .../media/v4l/pixfmt-yuv-planar.rst           | 94 +++++++++++++++++++
 drivers/media/v4l2-core/v4l2-common.c         |  2 +
 drivers/media/v4l2-core/v4l2-ioctl.c          |  2 +
 include/uapi/linux/videodev2.h                |  2 +
 4 files changed, 100 insertions(+)

diff --git a/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst b/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst
index f1d5bb7b806d..72324274f20c 100644
--- a/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst
+++ b/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst
@@ -123,6 +123,20 @@ All components are stored with the same number of bits per component.
       - Cb, Cr
       - Yes
       - 4x4 tiles
+    * - V4L2_PIX_FMT_P012
+      - 'P012'
+      - 12
+      - 4:2:0
+      - Cb, Cr
+      - Yes
+      - Linear
+    * - V4L2_PIX_FMT_P012M
+      - 'PM12'
+      - 12
+      - 4:2:0
+      - Cb, Cr
+      - No
+      - Linear
     * - V4L2_PIX_FMT_NV16
       - 'NV16'
       - 8
@@ -586,6 +600,86 @@ Data in the 10 high bits, zeros in the 6 low bits, arranged in little endian ord
       - Cb\ :sub:`11`
       - Cr\ :sub:`11`
 
+.. _V4L2-PIX-FMT-P012:
+.. _V4L2-PIX-FMT-P012M:
+
+P012 and P012M
+--------------
+
+P012 is like NV12 with 12 bits per component, expanded to 16 bits.
+Data in the 12 high bits, zeros in the 4 low bits, arranged in little endian order.
+
+.. flat-table:: Sample 4x4 P012 Image
+    :header-rows:  0
+    :stub-columns: 0
+
+    * - start + 0:
+      - Y'\ :sub:`00`
+      - Y'\ :sub:`01`
+      - Y'\ :sub:`02`
+      - Y'\ :sub:`03`
+    * - start + 8:
+      - Y'\ :sub:`10`
+      - Y'\ :sub:`11`
+      - Y'\ :sub:`12`
+      - Y'\ :sub:`13`
+    * - start + 16:
+      - Y'\ :sub:`20`
+      - Y'\ :sub:`21`
+      - Y'\ :sub:`22`
+      - Y'\ :sub:`23`
+    * - start + 24:
+      - Y'\ :sub:`30`
+      - Y'\ :sub:`31`
+      - Y'\ :sub:`32`
+      - Y'\ :sub:`33`
+    * - start + 32:
+      - Cb\ :sub:`00`
+      - Cr\ :sub:`00`
+      - Cb\ :sub:`01`
+      - Cr\ :sub:`01`
+    * - start + 40:
+      - Cb\ :sub:`10`
+      - Cr\ :sub:`10`
+      - Cb\ :sub:`11`
+      - Cr\ :sub:`11`
+
+.. flat-table:: Sample 4x4 P012M Image
+    :header-rows:  0
+    :stub-columns: 0
+
+    * - start0 + 0:
+      - Y'\ :sub:`00`
+      - Y'\ :sub:`01`
+      - Y'\ :sub:`02`
+      - Y'\ :sub:`03`
+    * - start0 + 8:
+      - Y'\ :sub:`10`
+      - Y'\ :sub:`11`
+      - Y'\ :sub:`12`
+      - Y'\ :sub:`13`
+    * - start0 + 16:
+      - Y'\ :sub:`20`
+      - Y'\ :sub:`21`
+      - Y'\ :sub:`22`
+      - Y'\ :sub:`23`
+    * - start0 + 24:
+      - Y'\ :sub:`30`
+      - Y'\ :sub:`31`
+      - Y'\ :sub:`32`
+      - Y'\ :sub:`33`
+    * -
+    * - start1 + 0:
+      - Cb\ :sub:`00`
+      - Cr\ :sub:`00`
+      - Cb\ :sub:`01`
+      - Cr\ :sub:`01`
+    * - start1 + 8:
+      - Cb\ :sub:`10`
+      - Cr\ :sub:`10`
+      - Cb\ :sub:`11`
+      - Cr\ :sub:`11`
+
 
 Fully Planar YUV Formats
 ========================
diff --git a/drivers/media/v4l2-core/v4l2-common.c b/drivers/media/v4l2-core/v4l2-common.c
index 40f56e044640..a5e8ba370d33 100644
--- a/drivers/media/v4l2-core/v4l2-common.c
+++ b/drivers/media/v4l2-core/v4l2-common.c
@@ -267,6 +267,7 @@ const struct v4l2_format_info *v4l2_format_info(u32 format)
 		{ .format = V4L2_PIX_FMT_NV24,    .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 1, .comp_planes = 2, .bpp = { 1, 2, 0, 0 }, .hdiv = 1, .vdiv = 1 },
 		{ .format = V4L2_PIX_FMT_NV42,    .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 1, .comp_planes = 2, .bpp = { 1, 2, 0, 0 }, .hdiv = 1, .vdiv = 1 },
 		{ .format = V4L2_PIX_FMT_P010,    .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 1, .comp_planes = 2, .bpp = { 2, 2, 0, 0 }, .hdiv = 2, .vdiv = 1 },
+		{ .format = V4L2_PIX_FMT_P012,    .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 1, .comp_planes = 2, .bpp = { 2, 4, 0, 0 }, .hdiv = 2, .vdiv = 2 },
 
 		{ .format = V4L2_PIX_FMT_YUV410,  .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 1, .comp_planes = 3, .bpp = { 1, 1, 1, 0 }, .hdiv = 4, .vdiv = 4 },
 		{ .format = V4L2_PIX_FMT_YVU410,  .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 1, .comp_planes = 3, .bpp = { 1, 1, 1, 0 }, .hdiv = 4, .vdiv = 4 },
@@ -292,6 +293,7 @@ const struct v4l2_format_info *v4l2_format_info(u32 format)
 		{ .format = V4L2_PIX_FMT_NV21M,   .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 2, .comp_planes = 2, .bpp = { 1, 2, 0, 0 }, .hdiv = 2, .vdiv = 2 },
 		{ .format = V4L2_PIX_FMT_NV16M,   .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 2, .comp_planes = 2, .bpp = { 1, 2, 0, 0 }, .hdiv = 2, .vdiv = 1 },
 		{ .format = V4L2_PIX_FMT_NV61M,   .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 2, .comp_planes = 2, .bpp = { 1, 2, 0, 0 }, .hdiv = 2, .vdiv = 1 },
+		{ .format = V4L2_PIX_FMT_P012M,   .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 2, .comp_planes = 2, .bpp = { 2, 4, 0, 0 }, .hdiv = 2, .vdiv = 2 },
 
 		/* Bayer RGB formats */
 		{ .format = V4L2_PIX_FMT_SBGGR8,	.pixel_enc = V4L2_PIXEL_ENC_BAYER, .mem_planes = 1, .comp_planes = 1, .bpp = { 1, 0, 0, 0 }, .hdiv = 1, .vdiv = 1 },
diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-core/v4l2-ioctl.c
index 87f163a89c80..6489b67babfa 100644
--- a/drivers/media/v4l2-core/v4l2-ioctl.c
+++ b/drivers/media/v4l2-core/v4l2-ioctl.c
@@ -1352,6 +1352,7 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtdesc *fmt)
 	case V4L2_PIX_FMT_NV24:		descr = "Y/UV 4:4:4"; break;
 	case V4L2_PIX_FMT_NV42:		descr = "Y/VU 4:4:4"; break;
 	case V4L2_PIX_FMT_P010:		descr = "10-bit Y/UV 4:2:0"; break;
+	case V4L2_PIX_FMT_P012:		descr = "12-bit Y/UV 4:2:0"; break;
 	case V4L2_PIX_FMT_NV12_4L4:	descr = "Y/UV 4:2:0 (4x4 Linear)"; break;
 	case V4L2_PIX_FMT_NV12_16L16:	descr = "Y/UV 4:2:0 (16x16 Linear)"; break;
 	case V4L2_PIX_FMT_NV12_32L32:   descr = "Y/UV 4:2:0 (32x32 Linear)"; break;
@@ -1362,6 +1363,7 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtdesc *fmt)
 	case V4L2_PIX_FMT_NV61M:	descr = "Y/VU 4:2:2 (N-C)"; break;
 	case V4L2_PIX_FMT_NV12MT:	descr = "Y/UV 4:2:0 (64x32 MB, N-C)"; break;
 	case V4L2_PIX_FMT_NV12MT_16X16:	descr = "Y/UV 4:2:0 (16x16 MB, N-C)"; break;
+	case V4L2_PIX_FMT_P012M:	descr = "12-bit Y/UV 4:2:0 (N-C)"; break;
 	case V4L2_PIX_FMT_YUV420M:	descr = "Planar YUV 4:2:0 (N-C)"; break;
 	case V4L2_PIX_FMT_YVU420M:	descr = "Planar YVU 4:2:0 (N-C)"; break;
 	case V4L2_PIX_FMT_YUV422M:	descr = "Planar YUV 4:2:2 (N-C)"; break;
diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
index 17a9b975177a..f83a9d1210fb 100644
--- a/include/uapi/linux/videodev2.h
+++ b/include/uapi/linux/videodev2.h
@@ -637,12 +637,14 @@ struct v4l2_pix_format {
 #define V4L2_PIX_FMT_NV24    v4l2_fourcc('N', 'V', '2', '4') /* 24  Y/CbCr 4:4:4  */
 #define V4L2_PIX_FMT_NV42    v4l2_fourcc('N', 'V', '4', '2') /* 24  Y/CrCb 4:4:4  */
 #define V4L2_PIX_FMT_P010    v4l2_fourcc('P', '0', '1', '0') /* 24  Y/CbCr 4:2:0 10-bit per component */
+#define V4L2_PIX_FMT_P012    v4l2_fourcc('P', '0', '1', '2') /* 24  Y/CbCr 4:2:0 12-bit per component */
 
 /* two non contiguous planes - one Y, one Cr + Cb interleaved  */
 #define V4L2_PIX_FMT_NV12M   v4l2_fourcc('N', 'M', '1', '2') /* 12  Y/CbCr 4:2:0  */
 #define V4L2_PIX_FMT_NV21M   v4l2_fourcc('N', 'M', '2', '1') /* 21  Y/CrCb 4:2:0  */
 #define V4L2_PIX_FMT_NV16M   v4l2_fourcc('N', 'M', '1', '6') /* 16  Y/CbCr 4:2:2  */
 #define V4L2_PIX_FMT_NV61M   v4l2_fourcc('N', 'M', '6', '1') /* 16  Y/CrCb 4:2:2  */
+#define V4L2_PIX_FMT_P012M   v4l2_fourcc('P', 'M', '1', '2') /* 24  Y/CbCr 4:2:0 12-bit per component */
 
 /* three planes - Y Cb, Cr */
 #define V4L2_PIX_FMT_YUV410  v4l2_fourcc('Y', 'U', 'V', '9') /*  9  YUV 4:1:0     */
-- 
2.38.1

