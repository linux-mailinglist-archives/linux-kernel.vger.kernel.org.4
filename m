Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E25C76B8F60
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 11:11:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230310AbjCNKLM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 06:11:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230141AbjCNKKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 06:10:48 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2058.outbound.protection.outlook.com [40.107.8.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 664609926C;
        Tue, 14 Mar 2023 03:10:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dQrNKCvX0PERvx5SjbgZr0vDAx98UXLUtAwUVgAhyUEGtDQE/WOsHSerC1LIHYPDDqQ9HZpDMwjKnrkuf/vmOG1NeLZzhvcACN9tZbgCYSF7zVo7/Rt6vVLq1G41N8lNbxmkj+j6kpiS+Y08mAdh247HhsPC1Bb/VfvO0tJ5J3j9Ph/BSVtjYvnJmQE14NihpfOSAspKtZqWpYNvQ5gbgO30bY3ahb7KbB0b7zc/Apuh/b29b4JC0RIZ96NjVEz0vSuIibuQVWceWS2swyvMurmqPKFL+ezbOullKyLxbNlDN7RLIuLx1C5oMQV41mJFxpJ4FmmFrBy1y/pzJGvEUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HrCBHE/Vo1gQsJNT1K4+pi9GaKVG9/ECTcSLZP8Gt2E=;
 b=eNf/BqNAB7j4qysTaTzLFJuf/Uz7aoQFsa/z/qmUqgwVvrYYAN72/VS13RJlIpbV5M+ZslbnhFC1Q0PsQZqWm7Lyw2Dsa8tsROCVamFni8hnM0Usf79Z9h7+x9P+b7dJd8pW4cfnx1rVZGQykToHW9JrUdypGPh5MWNRw3vmpy9QkCNRRCBbofcrcUcGS7/sxUX/Wy9Ur9OOj3DvvXcIN/QxPCMgvPny+SeJkSfkzbjm0qDV+hfYFY5Pzt7f+f39xUkn5BKVdACTGPWWTmx819ISOuDhREXhSXxEquX6zqm+ly5J4wqZn34XC/RcHsoPcF6LpjG7iDcV843k6mDbJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HrCBHE/Vo1gQsJNT1K4+pi9GaKVG9/ECTcSLZP8Gt2E=;
 b=Fy4qs7NNEJt2KCVUBnIPxhhYrL+KOsz6UuKzuJTHuXcSbSlWuz55mUPfRF9Wxg7/BeNfIgQOInUYwgUMY66BnsAQoKWWiBgePbRUW/wScUXI04stD39tkyieefQ70gKpPpIBuPSxF2WyJ+tOKkzRSHAs3no9xmMuTaTSbZ53zyM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by DU0PR04MB9346.eurprd04.prod.outlook.com (2603:10a6:10:356::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Tue, 14 Mar
 2023 10:10:06 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::89aa:9204:790d:e46b]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::89aa:9204:790d:e46b%5]) with mapi id 15.20.6178.024; Tue, 14 Mar 2023
 10:10:06 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, mirela.rabulea@oss.nxp.com,
        hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, xiahong.bao@nxp.com, linux-imx@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 02/10] media: Add Y012 video format
Date:   Tue, 14 Mar 2023 18:08:45 +0800
Message-Id: <e5fefc67731c492570bf468572c5894fdcefbb28.1678788305.git.ming.qian@nxp.com>
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
X-MS-TrafficTypeDiagnostic: AM6PR04MB6341:EE_|DU0PR04MB9346:EE_
X-MS-Office365-Filtering-Correlation-Id: 04f4570e-a256-4939-4d72-08db24744914
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4hwiunJkfAxhTDyn/j41yHNwMeX1Vo33h9MZll+jXQL3gCEcHukBRHXzypknwhO83TwPNdAnu+YYTcKvD4cNnAMfZajA2OXtCUyK8PFQCN9nWSHNs4lKqvJwUBNllaNAeHcEiyNwqYhy9nUsP2PFW5tBMvyd9cCMZ00hHxmDgPdl/mq+R5EKKN0KL7b6uvm7yFzfd9TGLtkJCakM4D8G1gu06BJ03NmzvJf1U1eKfnRVdw19Qh0IGPpLf7kdA8D4oCzbJKABq3gMLizaKwJBUSx+8rohvPnMD7BNRSyyp11xSuAZ/BJjOSG7aI0DEB6rd/NdDP/ExvSrzGo9N3Qon+J3XDjknXMdkJgly6CAqxKj0Okj8HRzdhn5TmhMeZ56Z1ojzj5rvGyxzT7bvloc0RtCNbZjgkvZ1Vbq1yqZ5Qo+AXjmIKXPptJPA3Bg4kLR3DJ20V1dsS7X7329oi2Jqi4QBrwi0k3uCT2Th0eW1ps/dZL8CAvZ6P0Zkw9Ii4kVmke4bi9Wx80AvvMF9jjhHfHEAugk3TZLwv4FIL86Om8PxORYn8donAsftkfjxZPnDZ3yNnLsjCGwHzNKP+PmAnPMqZ7V3mIGEYj2YzmEawjZEoiivEFCqu2mI6vmIykkttaHGzynxe5uB46bgqBV292ClPYzmNbcXF/ECjw4IkaSUDRm6pPefyY1hWY67oejnpISjF826lxQaqRzbs2/OQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(396003)(376002)(39860400002)(366004)(346002)(451199018)(2906002)(41300700001)(83380400001)(36756003)(5660300002)(7416002)(44832011)(66946007)(8676002)(66556008)(38350700002)(4326008)(66476007)(86362001)(38100700002)(316002)(8936002)(186003)(2616005)(26005)(6512007)(52116002)(478600001)(6506007)(6486002)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MqzedhYl1R/QqMwT0hMWuhoimEUu4d4eZD84towf0FJcBa1W4nv86ipxRZ5l?=
 =?us-ascii?Q?w7TYsizZ5/f4piYIi4VrXfXlQ8ixtIi/NiNhjukQ/JgsoqMFHw8YcjsGCGiL?=
 =?us-ascii?Q?6ufFpTrYjzaZMtqB0ozBP/pdARQrrR2ATXkov++wOTUQANJz9YsD4c6RT+6N?=
 =?us-ascii?Q?xMYdBFixC15HGnfnY2juljfgeIWbYswfJ0yUc5FMREB2i0MhHf3FWx0LzLRB?=
 =?us-ascii?Q?lpeIi7oI42YLUHSDoUeuey2LhAWdT4XTvwKtBiiPhPj+InNluWdWDJzEG2iY?=
 =?us-ascii?Q?Qsx4zQ0O0ge29XrJclDkOH9AZUtD5p3+A9nG+/fArQTEJT7W7kPFbTArrdAa?=
 =?us-ascii?Q?Ea0sfJUM/XE8Z2t5ZYgB1+up8+Hw9s8D6wfmhQLsnVFTrDz1bNryz//SIySx?=
 =?us-ascii?Q?Wbu0rwzlr5qtsjt56W2tUD0We2tw7zlZnVzNCeujqnh6BdDlA7sPZnhbitv9?=
 =?us-ascii?Q?PjcqWePgOUqkXmMEYhzql1OeWa5AZdd6d9gU0JaLQSdPBTA/2ndX7CrdrI0k?=
 =?us-ascii?Q?JIP1bgnY1C8kCp3nGDzbAG+7/vsCY4MXObcPC1ldJIGTONT7KJBMkjHjP5EH?=
 =?us-ascii?Q?RnhbXHnEu6ys4KZCkNUe6a5GEteN9uhZ5ZMCw55/X6mKEBr6a0pfsrOZ9DfO?=
 =?us-ascii?Q?aGlgnkxqLQI0Mg2Uh+RqWaTs7FaLDccMjglYy3Gm55APz/x4ZCE9zHEZppvE?=
 =?us-ascii?Q?sh+gt6Kstk0V9LSzLi3YeGAoNsEiC7Jj3dBDFYHWldKyr+ZEkTbhvT1SkotG?=
 =?us-ascii?Q?QmA8uJJUfzJmn/x45+XmzmHkpuZSaz0Y/4+aprIx0lwTceMD+snvZvb/nhqA?=
 =?us-ascii?Q?rnpVSK+vIUPD7EJe911o23lThaOCIEmskBfXkOdwVHantj2AkQQt1vH12UKs?=
 =?us-ascii?Q?hw2En62OqUN/1ai6Wry6FgTtWyqBtWN+QSBGsskANBGkC2ZaWfXsAtKi7r03?=
 =?us-ascii?Q?bTTMZlUAkgx57B4XhM7y4Cdtjd/KALJ075BywhssxyWMNcjeAF9VkJDhOQU0?=
 =?us-ascii?Q?bWsnNG95maYCDDmisIUlaGtV56rDR/yYmQ+LEFuLMM8IaIydVth5dPTUupA0?=
 =?us-ascii?Q?PXUUk4aC5RxeKpJFVL15BkkwBXNFnElFNuRw4VgC94Kgz1HLmDBb8mTHX7M8?=
 =?us-ascii?Q?hywM86MpynVFuDXl7sXLC/iPa+WLu6ziqkiA2kUgf1Jm7cSXDO+ctZAkzk3l?=
 =?us-ascii?Q?pDpYxpqDfllx55D1GoM8T/blcApNKXEpa6OQjKHi/O9IQLocw8AovpvLzNmi?=
 =?us-ascii?Q?O4VfqF9S9eAZyyHuJjqlbSqIPeu14THGSDZBA6U4am1/Q6o3SwK/pg0alKBN?=
 =?us-ascii?Q?+ykxVvIEvz7hCOW04ZTPbxIbaey2wZB0o73DZk3LKH4JZ7Rd8B0D9jciEuTo?=
 =?us-ascii?Q?0QqOpQgyl/IDrgNE5BOQhtYNcHyIroGL8cvAcU1tllGMDuIXmoT67MXdcaX1?=
 =?us-ascii?Q?xPfGEHjCYdYx22m8YY8vwgL+S2jBiXYTy4yY6vUZZMTXpSjNFPqopVHH+exJ?=
 =?us-ascii?Q?FhjB0kCDmcv0/Gba0Vyk7a2OTSv84sswSm/SHSurMNgCFhO7ri/DcUUwmqtY?=
 =?us-ascii?Q?bDoDEmfRZv03yP54jwyxY+lCIRNuGiH3ruTAX2mB?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04f4570e-a256-4939-4d72-08db24744914
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2023 10:10:06.6586
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4auQeJcWiEzdHoQa5UFbRJZ0nv+AoE6w6oVB8kTkmZWxmkLm4fGO+wQS5xB7zC22Ftqmz9eeCgEZyfx/wHT2IA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9346
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Y012 is a luma-only formats with 12-bits per pixel,
expanded to 16bits.
Data in the 12 high bits, zeros in the 4 low bits,
arranged in little endian order.

Signed-off-by: Ming Qian <ming.qian@nxp.com>
---
 .../userspace-api/media/v4l/pixfmt-yuv-luma.rst   | 15 +++++++++++++++
 drivers/media/v4l2-core/v4l2-ioctl.c              |  1 +
 include/uapi/linux/videodev2.h                    |  1 +
 3 files changed, 17 insertions(+)

diff --git a/Documentation/userspace-api/media/v4l/pixfmt-yuv-luma.rst b/Documentation/userspace-api/media/v4l/pixfmt-yuv-luma.rst
index 62078a01de76..7888151f2cd4 100644
--- a/Documentation/userspace-api/media/v4l/pixfmt-yuv-luma.rst
+++ b/Documentation/userspace-api/media/v4l/pixfmt-yuv-luma.rst
@@ -103,6 +103,17 @@ are often referred to as greyscale formats.
       - ...
       - ...
 
+    * .. _V4L2-PIX-FMT-Y012:
+
+      - ``V4L2_PIX_FMT_Y012``
+      - 'Y012'
+
+      - Y'\ :sub:`0`\ [3:0] `0000`
+      - Y'\ :sub:`0`\ [11:4]
+      - ...
+      - ...
+      - ...
+
     * .. _V4L2-PIX-FMT-Y14:
 
       - ``V4L2_PIX_FMT_Y14``
@@ -146,3 +157,7 @@ are often referred to as greyscale formats.
     than 16 bits. For example, 10 bits per pixel uses values in the range 0 to
     1023. For the IPU3_Y10 format 25 pixels are packed into 32 bytes, which
     leaves the 6 most significant bits of the last byte padded with 0.
+
+    For Y012 and Y12 formats, Y012 place its data in the 12 high bits, with
+    padding zeros in the 4 low bits, in contrast to Y12 format, which have
+    its padding located in the most significant bits of the 16 bit word.
diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-core/v4l2-ioctl.c
index 6489b67babfa..2cb485643562 100644
--- a/drivers/media/v4l2-core/v4l2-ioctl.c
+++ b/drivers/media/v4l2-core/v4l2-ioctl.c
@@ -1307,6 +1307,7 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtdesc *fmt)
 	case V4L2_PIX_FMT_Y6:		descr = "6-bit Greyscale"; break;
 	case V4L2_PIX_FMT_Y10:		descr = "10-bit Greyscale"; break;
 	case V4L2_PIX_FMT_Y12:		descr = "12-bit Greyscale"; break;
+	case V4L2_PIX_FMT_Y012:		descr = "12-bit Greyscale"; break;
 	case V4L2_PIX_FMT_Y14:		descr = "14-bit Greyscale"; break;
 	case V4L2_PIX_FMT_Y16:		descr = "16-bit Greyscale"; break;
 	case V4L2_PIX_FMT_Y16_BE:	descr = "16-bit Greyscale BE"; break;
diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
index f83a9d1210fb..db06d4c4f008 100644
--- a/include/uapi/linux/videodev2.h
+++ b/include/uapi/linux/videodev2.h
@@ -586,6 +586,7 @@ struct v4l2_pix_format {
 #define V4L2_PIX_FMT_Y6      v4l2_fourcc('Y', '0', '6', ' ') /*  6  Greyscale     */
 #define V4L2_PIX_FMT_Y10     v4l2_fourcc('Y', '1', '0', ' ') /* 10  Greyscale     */
 #define V4L2_PIX_FMT_Y12     v4l2_fourcc('Y', '1', '2', ' ') /* 12  Greyscale     */
+#define V4L2_PIX_FMT_Y012    v4l2_fourcc('Y', '0', '1', '2') /* 12  Greyscale     */
 #define V4L2_PIX_FMT_Y14     v4l2_fourcc('Y', '1', '4', ' ') /* 14  Greyscale     */
 #define V4L2_PIX_FMT_Y16     v4l2_fourcc('Y', '1', '6', ' ') /* 16  Greyscale     */
 #define V4L2_PIX_FMT_Y16_BE  v4l2_fourcc_be('Y', '1', '6', ' ') /* 16  Greyscale BE  */
-- 
2.38.1

