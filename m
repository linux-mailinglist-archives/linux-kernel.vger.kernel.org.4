Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6339069603E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 11:06:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232006AbjBNKGA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 05:06:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231561AbjBNKFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 05:05:55 -0500
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2041.outbound.protection.outlook.com [40.107.14.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 108AF1420E;
        Tue, 14 Feb 2023 02:05:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gBE8fQP5orMjgGNsI+bEdY6SaYeVxBurafhEwPdFQgk1D6VLCGyltQ046i17pLMr0TAF0g2sa1XJiaC62VXDlZXItQcODPz1TMRXLkJmUy2J5UwB3ReMFa/CWfhQKpIgECTiyZK82eyOTueF0dFDlVxs+SyjHlnyAFz+D2OBP9AZ8XXMQEcRy4YrnLizK0S3J4JRkjOE5YcPpWMFRTUrRQMB8ZQ6LHKxG8EN8aSZ/ELis221wp9LIFelA9GcErJvetDe6LTp/UhSQ+JBhmYldVKwoNMUrcT0FAyNSZXD3IaxB6CRmVsvS5/zr9ic/qSdKvLmL5rrnaSwPDZkzPkb9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ix9v61PoUsYvkmqee5FtlDggASkuV8T2VAn8f1BTS0c=;
 b=WB5Jr1N2U6PeVYcP6wQgdxt/9yIdZ8yYtqe3Db8uOpgUz3UE2aMd2FjaDUQQ32Xj0GNv1QGS9EssXlElWxVAvNCKaKCUHVZ8khlN9X14zKINhR8S4wmiRKYgRq6TUQIX1FfGD/UCv6+IKc7pDlsr2avlB94brmvhryj4cVYYMhMqq+tS4O4n3uqp5Gp1yEIApEbe7Hm9lMlkdXTays0oBCE43/yrFLGkrZYTwLIZ9m6jVrphK1dHiicAUUdAymuI4x8rXMooDm84KtbPcpjasNTCexvcUqhxJISLnUL/P/HMvU2Ubvn73tKfgTqkJlRAWWPGcfR6RFvpa8YR4UrDJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ix9v61PoUsYvkmqee5FtlDggASkuV8T2VAn8f1BTS0c=;
 b=BVFyMBiN3PYeZLoLvDjsEx3E/dM8QrkX9n53+fhgQIr5WLZvCILj5M9TOc4iGzuz/ytiYibFwmmkPq6YM7t/Mrma70tOiHav9HQUGf1E2Y5eIOwaILjbVcpLg+7fIrH3HTh2WTQcmBVw+xoYBYr3JySDl4J3jRv0JGNJvDFTrlk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by PAXPR04MB9204.eurprd04.prod.outlook.com (2603:10a6:102:227::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24; Tue, 14 Feb
 2023 10:05:51 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::3a82:42b3:f1ed:5c3d]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::3a82:42b3:f1ed:5c3d%7]) with mapi id 15.20.6086.023; Tue, 14 Feb 2023
 10:05:51 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, mirela.rabulea@oss.nxp.com,
        hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, xiahong.bao@nxp.com, linux-imx@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 02/10] media: Add Y012 video format
Date:   Tue, 14 Feb 2023 18:04:44 +0800
Message-Id: <d26f60f6f0a5e9cc90cc1abf8ef62735685f6c6a.1676368610.git.ming.qian@nxp.com>
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
X-MS-TrafficTypeDiagnostic: AM6PR04MB6341:EE_|PAXPR04MB9204:EE_
X-MS-Office365-Filtering-Correlation-Id: aa20e51e-4bb1-4700-9ffd-08db0e730d52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0HhJOLneZYoij2RU/PizS1O5KTsr83V+nUXYCrXqGcg/XzfeSm+OFHLtIGMe5NsbaWf3FQAGtA7A9liNJFd0i3n8hGHcj+Jddf2q00GMECFKz6HNeQLuXo4L99z3AKKx1VsX9s8XiSfNIrpY/DamrXNUwcBTnjPw2Z+u8jlrKflmRA++2VhD5MY65xfE0zp729Fpv2/OALt0gb+nOoOmYq9EA/A8DOJfKIYwLFHD0bzTnMIp8DQc0BjHTyo6BOmNZAhtVLUC4uzc7lrPaaLlXE9SwugS9FR94M5BFNblKsGgQm8Tfnc1WXU7PJegepK1gJi5DJWiQUIak6OQ5SMfra5o7udofBukrqNfKLeY3p73GGB17RHoDNw62CJLC5uyRhz97u23jMaSlg4FGx0+XKhE7eY2MVf0VeR9330RNRMd6E+hru2qQBzHw21uDS8H+cqvFtpyFfQ1TaWbxqCyDKdZTotwRsWCa7dXWd8RFWxwhHhpKFK+Bv/svPwTCVVjTRlTyZZiov52ZT1CA7eKF3nSrHmgdNkX9aPszP2EDHUm5yhbhNLErnPl16ivPJacWxyfHTD5Z7x6daZF2JVW03LFmAENo7FNA8SAT4oBzPaB1mMufXBxcmbgsbgIvKKCDL1twyvlr0YxejaJQzTtL4Zv8VcLYQMUt1WfWja6boD4EsuZzux79ZHlBGBrAR/BuH4n+UVbG1F5qbQ5sl+ndA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(396003)(366004)(39860400002)(346002)(376002)(451199018)(6666004)(2616005)(41300700001)(8676002)(66476007)(66556008)(66946007)(2906002)(38350700002)(478600001)(8936002)(38100700002)(7416002)(4326008)(44832011)(5660300002)(316002)(52116002)(83380400001)(86362001)(6486002)(36756003)(26005)(6512007)(186003)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sTq82RkKIRyB3b3NqKJguMzwmPL0felz7xi19VHF/1ukCsYb/AtOFiWlzwgd?=
 =?us-ascii?Q?wB/PT4kauzgNMOLohiurMWImCm7rtPLT6kbszeZCiTMcCCBA8XH4pjzI5J7U?=
 =?us-ascii?Q?b7pgFrCVkREWp7zHWM1pn/R+ktdgJSWFCFegMQnYzhy2Go4bnmd4zbH00+Fk?=
 =?us-ascii?Q?917xSbGA67SlZ/z4flexMEmfVYVboRGhcvvrdOd9KnlJywJ6hQdzZtr7AYFc?=
 =?us-ascii?Q?+/6BTKzavFAERFcDOMJhBgixNT8RawKovp5Yn4emP7wtV65RmXzMK485QbEf?=
 =?us-ascii?Q?h6ftwdgKvtac7GokuIM/PnjkX1d6XIO7icUVM+kzxXIxqWjSRLaqkcTxnE7k?=
 =?us-ascii?Q?I4x0yIDMHijUbzg3jff7XUDdXB/r1bW3Wugjq1Hvof8TibLVBT6HqvAJYd54?=
 =?us-ascii?Q?jnEVzwHXDKTNFamWxTloXjXx6kUvnOud3V968ViCYgv+fqXh90GefSSrIKbJ?=
 =?us-ascii?Q?rsQUh3eA9LjODt6FASUVSx7rgG22YkgTkuPI79U0AhCVdqvvshGSIrwzQmsM?=
 =?us-ascii?Q?R6VJbIW2scuxOUFX3GbU0dMWisXKZKz+t8Lqa/4CQborY7nI9uY7R/Fz0BGT?=
 =?us-ascii?Q?IVLXUZwCaAeoHs2+1y0fTcYC1ZJa1sX3RR5GRvc3uYl7wcszgdMOqUf/5Jij?=
 =?us-ascii?Q?KOI3JtIN1SukKNXrmuIcoF7ZBtsCbjzlYwUs/wEKfXFPgbca2uxibJuwqYGB?=
 =?us-ascii?Q?2N3eWrB7k6co073+em2j/15bTvywfYjEPAhM1fJTzX+EI6/m1v0RppiFXwLl?=
 =?us-ascii?Q?0GBpOM+egIQVuyO6be9pYVZYApsclEQOeUtCsPJdoG1tNdFeQUKidOYZa3Xl?=
 =?us-ascii?Q?PUH2CcoChGSkEwag2RleMEeFTb+bXhx7EfAeuFdtK7DsSoappmVTXH/y7rOy?=
 =?us-ascii?Q?CnwMsRY/EJP1QOmKimk0UJ0lIu5p/BAjl5dTkyb98n/KUmtmeW6i4x00O23F?=
 =?us-ascii?Q?vKNOABwVJ1HjAkWLIlpzSI8mzleY2BvhV81w+EEHFYh/q4dcGCenA8tznaB0?=
 =?us-ascii?Q?dYqDt7VZemNIIMFm4x9TCbJ41eAaBHVbr6vKIRuRa8WrBHWUfZKUHhSbxAF/?=
 =?us-ascii?Q?qfP54gbBRJkzStWt1IrjP3Z+ovf8d4fEHfOmBrDnUtp2mWSwh5t8AWWBPVFw?=
 =?us-ascii?Q?vk9rCxjrGkXYhPonegq7TlxoRyMZxPH0WOZhBaQluf24XWBDCgwzU8SKEW3T?=
 =?us-ascii?Q?uoh+JyRixvOF1dywK9eL1a/0QGdVrq/DBccieE/W59aUvYmadPL3Y5/O39OO?=
 =?us-ascii?Q?ZX4CaYTCP2mfWq60gdBsV5TrOfAw3SnfwjEXLlniLMC6EUN+FayMOT0Xrukb?=
 =?us-ascii?Q?AzB4eeBZU8BdSzxfnnp8IWsMxHliIdjkUgqwy7uT20rkYU9v7bMSdUGu6/wK?=
 =?us-ascii?Q?/SGDVYwjKZ6K5Jx6eFwPgbyf+FbisCaq0sujVmq+3khfGYM/XCapwtPTjm/j?=
 =?us-ascii?Q?cmIQCDuqjFR4aKR2KUEA8YVnY5lsla3NcR/sk4eM0Tao7pik//WykUO56bWa?=
 =?us-ascii?Q?WhIQW79meXshzRtAbOIOB2nnU2IsbF6YsiZMi1fBQ9kYx7xaLE2wvu9JUClc?=
 =?us-ascii?Q?i0Jyx4xqvaM7eSQ+pGR2NlzJnrxu32NHoiS23f33?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa20e51e-4bb1-4700-9ffd-08db0e730d52
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2023 10:05:51.2791
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xoVukyZ7+wZh8vS4K6An1hvwEfRw66cTutDobBWOndvTqE+bRteQWyVpGMbkrh29WdFrC3agF0SlmhjaUzGOhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9204
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
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
index 6a387f9df3ba..a114ab76b298 100644
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
index a166436be83f..ec1c9ef27e88 100644
--- a/drivers/media/v4l2-core/v4l2-ioctl.c
+++ b/drivers/media/v4l2-core/v4l2-ioctl.c
@@ -1304,6 +1304,7 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtdesc *fmt)
 	case V4L2_PIX_FMT_Y6:		descr = "6-bit Greyscale"; break;
 	case V4L2_PIX_FMT_Y10:		descr = "10-bit Greyscale"; break;
 	case V4L2_PIX_FMT_Y12:		descr = "12-bit Greyscale"; break;
+	case V4L2_PIX_FMT_Y012:		descr = "12-bit Greyscale"; break;
 	case V4L2_PIX_FMT_Y14:		descr = "14-bit Greyscale"; break;
 	case V4L2_PIX_FMT_Y16:		descr = "16-bit Greyscale"; break;
 	case V4L2_PIX_FMT_Y16_BE:	descr = "16-bit Greyscale BE"; break;
diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
index 5448aa3b7858..3d8f89bff33c 100644
--- a/include/uapi/linux/videodev2.h
+++ b/include/uapi/linux/videodev2.h
@@ -583,6 +583,7 @@ struct v4l2_pix_format {
 #define V4L2_PIX_FMT_Y6      v4l2_fourcc('Y', '0', '6', ' ') /*  6  Greyscale     */
 #define V4L2_PIX_FMT_Y10     v4l2_fourcc('Y', '1', '0', ' ') /* 10  Greyscale     */
 #define V4L2_PIX_FMT_Y12     v4l2_fourcc('Y', '1', '2', ' ') /* 12  Greyscale     */
+#define V4L2_PIX_FMT_Y012    v4l2_fourcc('Y', '0', '1', '2') /* 12  Greyscale     */
 #define V4L2_PIX_FMT_Y14     v4l2_fourcc('Y', '1', '4', ' ') /* 14  Greyscale     */
 #define V4L2_PIX_FMT_Y16     v4l2_fourcc('Y', '1', '6', ' ') /* 16  Greyscale     */
 #define V4L2_PIX_FMT_Y16_BE  v4l2_fourcc_be('Y', '1', '6', ' ') /* 16  Greyscale BE  */
-- 
2.38.1

