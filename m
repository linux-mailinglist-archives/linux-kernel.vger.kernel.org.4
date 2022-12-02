Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16244640133
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 08:48:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232292AbiLBHsG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 02:48:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232464AbiLBHr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 02:47:57 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2057.outbound.protection.outlook.com [40.107.22.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8DD5205FA;
        Thu,  1 Dec 2022 23:47:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gfRuyB2NYrc6XganfoFTY94yNuupTwcg3HDyV0n31t3cb+v4yb9YLUymLMTWyopDgF8u+Uco4HoIvYgdMvt76J2IepcbPoaSGj+rjQh+kF2c6dZA744TLVSYNILJRdUqS4by2/gO9ZVNNACFuLZ5ppu81peu4X/es4tNg6QliL5vyyrfTFFrd93VqfVSyj3hRooE93OJIlBIKEasCtLEOANuL2BQvYbeRhU0QtVaKnb8LWlDzTRT/Cennu0eqkJQq329EJIDiN7uLgTZ0gwAC2hD2bVFsRCDXB0Hd6y6IeXfQIKYFJetelTB1/OqROWJT2ZWXyYD3TFbSpd2dJJXgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fmo9r4dCtCA/pxiFPT/rVXfK/Ozo6bHQOtSI5P6fCwA=;
 b=HkhDMjZR+k1dz42cuFt+S3hGlmK70Wdi7C87blOJmx2PWHJhrDasWne2lKKpgujKi0U30ZNn7aZLF0PhbsVeG6QZHJjI0aiQxgsrp/S/CpIjmCAkfNXt6fIZqxxRxxNQ/pc26bTmSufOH0LQSCJiiWT3kW1A/eo+V4BcAle82+Hitk7274U4qXrDZoNfmL0gDtKAojxFGgqtkuah0Z0vQN9qaqBoef3Uq8sXYBzixrgKCtyW4HWxOnoTkEIWLTdrFnvPpV8eFoSYplUV0XwfVkmTDtb97gYsUeLd+2PWMKMa+Pmh5ksUTmbR5yoMvrceH7UbK2nuoWFykjkJv3ZfXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fmo9r4dCtCA/pxiFPT/rVXfK/Ozo6bHQOtSI5P6fCwA=;
 b=obO+xIBT3DqIbYqnnp/5MVsZX62EBkjPRRgsVtVvw3Fb/M402r0lBCIypJKjERKsertI/Mz06AqslgS5fursoCDCj8SYJR+aIglsQ1ozPCTWXvijl/rTCAsBffuZEGqVAZYVyylkcBkgOqoAL5vpj1sJm8lbz71j7fuoS+gMbdk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by AS8PR04MB8232.eurprd04.prod.outlook.com (2603:10a6:20b:3b2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.20; Fri, 2 Dec
 2022 07:47:53 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::4e64:fadc:30cf:4b86]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::4e64:fadc:30cf:4b86%5]) with mapi id 15.20.5857.023; Fri, 2 Dec 2022
 07:47:53 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, robh+dt@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        xiahong.bao@nxp.com, ming.zhou@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/2] media: amphion: support to decode sorenson spark video
Date:   Fri,  2 Dec 2022 15:47:17 +0800
Message-Id: <a4f2e447b9f181b991608b6bab217206a8c5a71d.1669966698.git.ming.qian@nxp.com>
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
X-MS-TrafficTypeDiagnostic: AM6PR04MB6341:EE_|AS8PR04MB8232:EE_
X-MS-Office365-Filtering-Correlation-Id: ed6df154-6fb5-4eb6-b463-08dad43984c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ODT1d5ramsCRZQPlZ17Mq76K2A+2Q+RAp8IwMqcHoaoo5tCaI6hbyUdC3DV4SXIzHqtPfPr4ASXmSURzlmImdqAhOiaKwbHOl2pmzfHJqY+SPJ3se2jj4GjJNeRz8GdQOZSAi/EoJaEuhfwl28eMHc0Tn8MPRAxnHZjA5euQXsKhGbjTuiM95j0D/GnYQPGQCkqkRhLjfdjUkA8LHeS1EE7FWjeaiLcLTcuSO9iX/8ZxdaDFURE0iFB/dt88C09C4CibC9ONRru9nkkUO1lvmAtkfo807oUG+kyvyV38wbmxgyl2gnC17EL4f6eaBQwzljhi5RvF7MkuteuSYmNx/U7w4KB3VK1UcI3YIE18lWKQPuN6zkznlcYndk0mMLf9NpbcoAvqyyORhWKRx7rM7TO6W4uX5j/dsSKufb+MhLcBA3UAQeGrCJpOBe6oXxRLZG5YHHfhC0/UjTO9bdMgpyOMlPfd0BohbnjvXEPrKIrqxglInns3ZylUyj9nZuBB+m92wboRJAKtrztGvB8C19txBwodqaUbjlq5zS1eXXOOIZGDitz3ZlrM29RxlxoKiYpbJQcc66EtmYPRXfUAQnJOkHv21fMYdLKk0E0Fp1f2OHAtTj1nZAb23zAuXIbV8FdeAdIQI6TpeFqJFOeM6cpIz30gKt4c0pcP2Ga2ESwrl38ojOUNqq5NQgQeTT1ljDmCojbixk3y6FCtdcVI6w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(366004)(396003)(346002)(39860400002)(451199015)(41300700001)(4326008)(186003)(86362001)(44832011)(2616005)(8936002)(7416002)(36756003)(5660300002)(478600001)(6486002)(38100700002)(38350700002)(26005)(66476007)(66946007)(8676002)(66556008)(316002)(6506007)(6512007)(6666004)(52116002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+LfIKAr98kG7yUCglB2DODt6dMt1pEScYFn2eJ3FhlZd8uw38cUnjCbu1Hnz?=
 =?us-ascii?Q?8WUBph/t+B5Ro/n8hn0rYcgXDRoLTO0VRFa788hTvrOT+0YZjh8QW2ykJSib?=
 =?us-ascii?Q?dm0UaNeBzQGKap0Mgu5bGfH6b++kLvJck2/erWBDcPylcrox22BM6Heso3rG?=
 =?us-ascii?Q?1FE2sqSA6QzHwZhZsK8qV1RWW2rCbmipPlC1Q3lpRrrulLTIom0GEhVPYdXK?=
 =?us-ascii?Q?MWbhOraRM/5lSr1ZHko/MIm7EBWIy8hAXKVJdytA7MyQU4n+QuOjPGcajlJ4?=
 =?us-ascii?Q?puySPfhziib/+5kQfenst1FkdjzJDafYG1+ROwllqiJxQvn8kPtwdqhZw4y6?=
 =?us-ascii?Q?3+E4TKGECT3kURQBMppFP1bB7iokmdYQISHVphf/MPYG7c+ymF5JmZsF12Ex?=
 =?us-ascii?Q?gRWR0HVutLrlnQDAyIqNge4TbD0PfciMlEKoslOZ3crzsOgwCqX4fivhawFT?=
 =?us-ascii?Q?CsD5g0av5Nx4T7W2RibCuxB6j73RUECm5w8PtDcd0j1QJhfBMKx6NB3/VjFa?=
 =?us-ascii?Q?9YpE41U6SzeGNw1MYQ5RvWxGGyOlrDyFL3h9TwlgaSaFmljgQvez3bc1KR0Q?=
 =?us-ascii?Q?2gINSepJLRk+CLfi5cKG9vnOA5RZRJpuNWL/D2pIzxK55dcqrpzj2ANru1jH?=
 =?us-ascii?Q?+oujBSd9vYB+CTf/vt4xLH6dy+RuumfspY+Qo34jg9vsWAgfTD3iX0OwhF2+?=
 =?us-ascii?Q?DFi9mnTYQ5I9iOUTRqIXwpgU83FHlRiO57Wz/cFmFDtaMLy/AlV3ueH1/F3D?=
 =?us-ascii?Q?yNnaQpH7DCFta5BZeZmpGuHJAXTw+wW4kFod4UYsjaO1R5b75guYVJCes+Km?=
 =?us-ascii?Q?W+sD1F3e9roUVYZFUwt0/LFmA1y+NBOIHZ2HFrJawDINuvmH/b33wu/837DZ?=
 =?us-ascii?Q?9mwC01OpyY+jlV0ro47A+c4BjewvN2UWFhhyzWMJlhimPIkVaSItXZO0BitJ?=
 =?us-ascii?Q?mcaUYpKiwV+uxw98n+DiZXVouZrguIeKtQuMcQFl8e529DaG3sl/+K2TXfSN?=
 =?us-ascii?Q?WdBwgTlsPrz9mQF2WwnxsLoqx/NoWzmDoNLdN83FAIsCgzoEOLaDLU+anRAh?=
 =?us-ascii?Q?/j9nQ80mWJ0657OkjD/qBd2VVc6M7bvClS6nGHpTP23j+63Q7dSmfrdQdRpi?=
 =?us-ascii?Q?K5Jlm2B8heui3sJZz/9j1ooOir5v/sf7TLld9DjXE19Js4RbdtfRNhW+UE25?=
 =?us-ascii?Q?jy7qgrZV2uykLyTE6RO3H0huIkzCPWZ7ICx8kco064LsptdLGsuIUAaKP1/9?=
 =?us-ascii?Q?LuAN5EAG9hKlKOv5yAfOJqqT0pqwwxAdOBd+zHmFd9iUf4aw7zI6DhoS+Iwr?=
 =?us-ascii?Q?ipzgZqXDYe+o6alfnljrohrq/XO6OEbhr9W9YBmXoVIXKlVlHaSJCZczb+5k?=
 =?us-ascii?Q?7phOekwg2zydR1aCMO8K4SNeoKFd+QgqTvCjMAaEQXMy4pdiujmpksWmzDj+?=
 =?us-ascii?Q?QMpK5Ez9tJM59PS/4Lckyrq8EsyK1gP8TxbSU0UnBg9qw2Y6+Dj6nJs2Qdcz?=
 =?us-ascii?Q?cgOSnDKk4Z1bRp1bs/lqTZeZz9zmVIGIHYA37qVPsfBcDWSEYyHyBsywtas6?=
 =?us-ascii?Q?kmRxvNxlD2t2P6OETE94J/hKeFr4BTYQFjfyCtMj?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed6df154-6fb5-4eb6-b463-08dad43984c8
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2022 07:47:53.4035
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nISHXp3osycJ0csxe54b//m9DLkK3KLtdcukTwR0oV7kz7OtSelBwn/ohIPnH6xPU8Y2pb2znd8sljZabJ3UOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8232
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

