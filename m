Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36127666E24
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 10:28:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240191AbjALJ2O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 04:28:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234552AbjALJ1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 04:27:09 -0500
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2078.outbound.protection.outlook.com [40.107.8.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37F6A38AC9;
        Thu, 12 Jan 2023 01:18:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gW68pEAfYULpmeF93tafR5k5isRE1Si0ZXKkY2d4b0ipi+1pKDDbYVo9IuqGJXyNy5cOs9lcJGOkgTIZ4ikFZM4KhedSkzrUVxwkSPtJkN9WcxrLvnOWAmQM4VE643Vb/hTMsfXPGTMaobAOlRZ+L80oQRRctopCiVwvMc950tvUHTMzz2LsVwiOVqW0CqWttMAdNMnXdB1VtlhjynyM3CUiCAQrf6QGtVkgCupSXHNUprPJF6PqonkpomOPWLNb3V/g7+coCdMGcqwl8fARlcbQyE5CALK9vqVewnjgsaNP0l2NtdBb5HQ56uxX/HwWV4V5I1lHpqjDqXLmIxHJ/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FWMwaoJmxkEMj9rody86HQ5FduIQQgsWlJU++4kFvF8=;
 b=eKUjxar+gWEIxTtNA9dftq0d3jPQ4Cd3rVPX9lLXJc/8FPztAKqPXYhSHOjqKvZxC5WUCAJVK5WKNv3FfXTSKmOi+SipaYvxwO44VfErwKVTOTPyFP+aApOpeIc1MEWdyjgr801pBFrVY8aUDyw5syqQ752v30/F6doxr2C0YeK8tx6CdQJIkHcAbsAHdTZ0D+Zs+SDOsExmrPv9bn1Ze7zf21YvSOePbNJhq+UjjzhQVn+iyRshVZKqMuMHKm06q+asaeV7ltp7TKqv46sg3f0XzdLPRcpOsdUErY2YWqxpYhezgDdKaCVxoYG81oyMuFVIT0gTy/mDZS1t2yGLhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FWMwaoJmxkEMj9rody86HQ5FduIQQgsWlJU++4kFvF8=;
 b=EDfDMfdHe22p8tAJtZ/RcN0ygeSVR4jJH10iinqBGORYtaseK7VlQYk1gik8lHbt5iDkVeh0D87Ecx+QVWuY6wMoeoanTNf62HVBQB+YHZoyYwQUhLeku4HmGbKq7/uiQWYJ8AY7kBLt5A1RnJZglU6TJkLj6GC2vZ3VZ4t3juM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by AM9PR04MB8923.eurprd04.prod.outlook.com (2603:10a6:20b:40a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.12; Thu, 12 Jan
 2023 09:18:43 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::3a82:42b3:f1ed:5c3d]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::3a82:42b3:f1ed:5c3d%7]) with mapi id 15.20.6002.013; Thu, 12 Jan 2023
 09:18:43 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, robh+dt@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        xiahong.bao@nxp.com, eagle.zhou@nxp.com, tao.jiang_2@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 2/2] media: amphion: support to decode RealVideo video
Date:   Thu, 12 Jan 2023 17:18:18 +0800
Message-Id: <fe18b078b7448b2e3ece100ebe53198fc4e159ab.1673514352.git.ming.qian@nxp.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1673514352.git.ming.qian@nxp.com>
References: <cover.1673514352.git.ming.qian@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0152.apcprd04.prod.outlook.com (2603:1096:4::14)
 To AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB6341:EE_|AM9PR04MB8923:EE_
X-MS-Office365-Filtering-Correlation-Id: 35624886-7428-4614-76a2-08daf47e005a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zu6r7Nszd+2EOCgaDWD9YAuTVzGCObe+kRaVX7r30rAf5cExJ/pY5WKHWjez/rvMd+JrcobeCyKCZkdM0Yc1xSB8QTNaDXaourTe/hxgo+4z+zykDhm+JcRIaSJxAt6y/RlyH0g34PAwClOy8RXN9Iy/xzhi8kv1Brtn2Pi9/LuGGC/I/vvqvDfkhzRqTIIE+PU4MmeEaP29UWP6/9dmPIoaSIhGRgpPHXpmTDCeqIgV+PCxe/56GQ+vMWzCEmvgVwJE+vWtBGb6kFRnCphGKlR8JevLmSP/hHp6mDUkSqGJaCYjV312AcQ5R/CRvId1cVT+cUyUopJ1oc2kiM0DrAtwcL29b8KRY5NIVez0pQX+mc4nH56uOUrqwpEVQTu3b8BQJweqRsvr+YsrYRL1sHvYPQ+JZkJaey0wvz2k0nyMiPg1YQeZj8mtURXWBWzwxk6D88zgFjEZhZZTqt/0Srdv+VKjbDxL2N7RQaI5ThmCw0iuAvMk0c+7YNV17J1amxN2Kjb68rFHaGu31gcP/wL5+rLnV5B/6Hw10+F1Olu4g/jZXk1kiHu0kNwUSi8DRmEFpkqbTunaJdo7dEF7eDqAHaLNvBgXpa9smaiayc4l3wG/lErZAHOisUHsy8Z6ptPlagMdEPaxI0VC2VYp7j+rhbEVQ7XxTXJB7ey9UsR9zG31E1KaCCRKfqFEBkF/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(136003)(346002)(396003)(366004)(451199015)(83380400001)(316002)(2616005)(26005)(41300700001)(5660300002)(8936002)(7416002)(66476007)(66946007)(8676002)(66556008)(4326008)(44832011)(2906002)(52116002)(6512007)(6506007)(86362001)(6666004)(186003)(36756003)(38100700002)(478600001)(38350700002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NYGDgUOv1gZ/JVYCPrzwerPikqtU1cZIE7gqdG8vU/1BvXVEnbCHGi9KQ6DR?=
 =?us-ascii?Q?b00OUzDGyRmE8FFqvUgY7iV6u8B6Og09wEaC748hWlsxniLrpQC1R2c7aSNl?=
 =?us-ascii?Q?pnR+aNt3/RCdF0Xl5K0rH06/CxbuS6gHV7wQeiLVj7MVjyr/yFn78kjcYIbT?=
 =?us-ascii?Q?ZD3XscXDRVCFJv89qMjtwKdcchW/MzriV7chKPJZh8GEXy69he3OAnWnW5P9?=
 =?us-ascii?Q?iqKhznSVJv6qVItLw6mTmR+pyepBxNuQ8CkFqrM+diEdkuk5rI+ASD5N44n3?=
 =?us-ascii?Q?pX5qmK6QwhFKKMcySar07HtX9xbN1qkqhbiw0fFyC4sHilYwzvRQpi2a7WEQ?=
 =?us-ascii?Q?jk8IhsdgdnX0C0dzRfcauQCaSVc+xY0m4gI6gp8qqbkNBYepMuGG6NrB25bz?=
 =?us-ascii?Q?tXy4GQDXjRt2vbN+Fl8OT+4x5Tx7/hQB5RdlADB3NgB6VSn3rqqC88OrFDPv?=
 =?us-ascii?Q?6u+TcZ/6Mu9vKZcV5/A+gIMu/vh5fhNTgx37OHzeBhA3VhxD8fpKe58XXJA4?=
 =?us-ascii?Q?1u1QSMqOfozvDewGX7mpc27LYQ4RFEd0rSUdwz/unKPlQtlcKYqmg/VqWOtv?=
 =?us-ascii?Q?fKa6uWk4LPK3b81klSvqr59wMecNiK8dswT7n0o0iLMV7G2kyzZL8GjtEavg?=
 =?us-ascii?Q?k78z4jlmXUGD4zwPC88YyBa/VNQ6glDe3HtrYJ67M+1vxRNT+ZdRRGJvaiuD?=
 =?us-ascii?Q?4FYXwfrFSdXuop722vXZ1/AgMk3qanB05cigQ/gsHBIPvr6FGZ/5po3SVNdi?=
 =?us-ascii?Q?FHy4S1SMQ5Xb/GCeMMx3XaZgflSfiluPrp0yoXPBXabcwmO7imp22ERlGuIx?=
 =?us-ascii?Q?Flf4zoLPcorOFuCHgF/STebs1cBaWJ6U64PO76E/227gSo0vkhampJSsY/ek?=
 =?us-ascii?Q?spNy4JxeWoGRGuJDf3pUofkrsUwu7S5YdT+lAb4YolpV4wDz2Idj6auGHTzp?=
 =?us-ascii?Q?G1uX+IAmk6V+NaoF1ToFqIHgU3uq0EX8XGOlw9LI7TeBPB5kP5D/U33e4BV0?=
 =?us-ascii?Q?WT6VmXM/FpTSdIyQN7zEVSstP+AmfeHR7iN8sH7rBbIGrLNTv9/mF5vLqiWb?=
 =?us-ascii?Q?s4VPw9Wfu5rXbnv90FyLlmsNHnM795XNPucdAyJmvYQu7ceJu5uTlDNLdHX3?=
 =?us-ascii?Q?W74kbWdLHm2q7mYwhmkm96LVqX5FMxNC3JN5npEApIjrFuWTiNrWj1nJXAGO?=
 =?us-ascii?Q?n3Q6TmfQoX5LT4pIaWjIoONGlPP5nAN4/XcakMNMDM4GOkt4Mpb/Lo4GUv5G?=
 =?us-ascii?Q?Jnj99+vIJCo+KUVkCzetdjm3Vv4eKgOoz9HZVZomCsTviF8ljYGDxaZNQCbe?=
 =?us-ascii?Q?aoo64hsl9yccGLf8GI2m/521sZud07GP5BC2R4WMRAd0fgZejT/O3IyXmOUM?=
 =?us-ascii?Q?iNVcPamKFEQ/Fv+IU7dXwPOHw8LCIWze/R+MXAQajwghhQFPPNzgRWP5CB5F?=
 =?us-ascii?Q?OjvIPhZ06G2tm9QjKtScqFFb9KzSei9MAxfW5aK6/vQPxmA//onsaCpK4Dio?=
 =?us-ascii?Q?LPYtYiiBqcNkpaM1i+Ju723whe0VKz39lo1s1MLy9HSmYc03oI7yGoCNtCqd?=
 =?us-ascii?Q?Ezx9n5M/SIVS6i4gXta4zzJdABY5fsAGG5m4y3JF?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35624886-7428-4614-76a2-08daf47e005a
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2023 09:18:43.7206
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yH0+PhzDjAX3yzhnCSLElzBIZIamjHM2l4dS/KYjo9yx2wEMGPxphPN4q/MTUhm7WEJoXPH1kblAsRKAF0BZ6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8923
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

amphion decoder add support for the RealVideo video.
RV30 and RV40 are support by amphion decoder.

Signed-off-by: Ming Qian <ming.qian@nxp.com>
---
 drivers/media/platform/amphion/vdec.c       |  7 +++++++
 drivers/media/platform/amphion/vpu_malone.c | 19 +++++++++++++++++++
 drivers/media/platform/amphion/vpu_malone.h |  1 +
 3 files changed, 27 insertions(+)

diff --git a/drivers/media/platform/amphion/vdec.c b/drivers/media/platform/amphion/vdec.c
index 09304b96f40d..7e47465ee749 100644
--- a/drivers/media/platform/amphion/vdec.c
+++ b/drivers/media/platform/amphion/vdec.c
@@ -172,6 +172,13 @@ static const struct vpu_format vdec_formats[] = {
 		.type = V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE,
 		.flags = V4L2_FMT_FLAG_DYN_RESOLUTION | V4L2_FMT_FLAG_COMPRESSED
 	},
+	{
+		.pixfmt = V4L2_PIX_FMT_RV,
+		.mem_planes = 1,
+		.comp_planes = 1,
+		.type = V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE,
+		.flags = V4L2_FMT_FLAG_DYN_RESOLUTION | V4L2_FMT_FLAG_COMPRESSED
+	},
 	{0, 0, 0, 0},
 };
 
diff --git a/drivers/media/platform/amphion/vpu_malone.c b/drivers/media/platform/amphion/vpu_malone.c
index 67ba637c4c7f..6e3626b74c7a 100644
--- a/drivers/media/platform/amphion/vpu_malone.c
+++ b/drivers/media/platform/amphion/vpu_malone.c
@@ -68,6 +68,8 @@
 #define STREAM_CONFIG_NUM_DBE_SET(x, y)		CONFIG_SET(x, y, 30, 0x40000000)
 #define STREAM_CONFIG_FS_CTRL_MODE_SET(x, y)	CONFIG_SET(x, y, 31, 0x80000000)
 
+#define MALONE_DEC_FMT_RV_MASK			BIT(21)
+
 enum vpu_malone_stream_input_mode {
 	INVALID_MODE = 0,
 	FRAME_LVL,
@@ -478,6 +480,8 @@ u32 vpu_malone_get_version(struct vpu_shared_addr *shared)
 {
 	struct malone_iface *iface = shared->iface;
 
+	vpu_malone_enable_format(V4L2_PIX_FMT_RV, iface->fw_version & MALONE_DEC_FMT_RV_MASK);
+
 	return iface->fw_version;
 }
 
@@ -563,8 +567,21 @@ static struct malone_fmt_mapping fmt_mappings[] = {
 	{V4L2_PIX_FMT_JPEG,        MALONE_FMT_JPG},
 	{V4L2_PIX_FMT_VP8,         MALONE_FMT_VP8},
 	{V4L2_PIX_FMT_SPK,         MALONE_FMT_SPK},
+	{V4L2_PIX_FMT_RV,          MALONE_FMT_RV},
 };
 
+void vpu_malone_enable_format(u32 pixelformat, int enable)
+{
+	u32 i;
+
+	for (i = 0; i < ARRAY_SIZE(fmt_mappings); i++) {
+		if (pixelformat == fmt_mappings[i].pixelformat) {
+			fmt_mappings[i].is_disabled = enable ? 0 : 1;
+			return;
+		}
+	}
+}
+
 static enum vpu_malone_format vpu_malone_format_remap(u32 pixelformat)
 {
 	u32 i;
@@ -989,6 +1006,7 @@ static const struct malone_padding_scode padding_scodes[] = {
 	{SCODE_PADDING_EOS,      V4L2_PIX_FMT_H263,        {0xb1010000, 0x0}},
 	{SCODE_PADDING_EOS,      V4L2_PIX_FMT_VP8,         {0x34010000, 0x0}},
 	{SCODE_PADDING_EOS,      V4L2_PIX_FMT_SPK,         {0x34010000, 0x0}},
+	{SCODE_PADDING_EOS,      V4L2_PIX_FMT_RV,          {0x34010000, 0x0}},
 	{SCODE_PADDING_EOS,      V4L2_PIX_FMT_JPEG,        {0xefff0000, 0x0}},
 	{SCODE_PADDING_ABORT,    V4L2_PIX_FMT_H264,        {0x0B010000, 0}},
 	{SCODE_PADDING_ABORT,    V4L2_PIX_FMT_H264_MVC,    {0x0B010000, 0}},
@@ -1001,6 +1019,7 @@ static const struct malone_padding_scode padding_scodes[] = {
 	{SCODE_PADDING_ABORT,    V4L2_PIX_FMT_H263,        {0xb1010000, 0x0}},
 	{SCODE_PADDING_ABORT,    V4L2_PIX_FMT_VP8,         {0x34010000, 0x0}},
 	{SCODE_PADDING_ABORT,    V4L2_PIX_FMT_SPK,         {0x34010000, 0x0}},
+	{SCODE_PADDING_ABORT,    V4L2_PIX_FMT_RV,          {0x34010000, 0x0}},
 	{SCODE_PADDING_EOS,      V4L2_PIX_FMT_JPEG,        {0x0, 0x0}},
 	{SCODE_PADDING_BUFFLUSH, V4L2_PIX_FMT_H264,        {0x15010000, 0x0}},
 	{SCODE_PADDING_BUFFLUSH, V4L2_PIX_FMT_H264_MVC,    {0x15010000, 0x0}},
diff --git a/drivers/media/platform/amphion/vpu_malone.h b/drivers/media/platform/amphion/vpu_malone.h
index 02a9d9530970..c95b53629199 100644
--- a/drivers/media/platform/amphion/vpu_malone.h
+++ b/drivers/media/platform/amphion/vpu_malone.h
@@ -41,5 +41,6 @@ int vpu_malone_post_cmd(struct vpu_shared_addr *shared, u32 instance);
 int vpu_malone_init_instance(struct vpu_shared_addr *shared, u32 instance);
 u32 vpu_malone_get_max_instance_count(struct vpu_shared_addr *shared);
 bool vpu_malone_check_fmt(enum vpu_core_type type, u32 pixelfmt);
+void vpu_malone_enable_format(u32 pixelformat, int enable);
 
 #endif
-- 
2.38.1

