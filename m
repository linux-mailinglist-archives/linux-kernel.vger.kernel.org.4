Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 233ED668AC5
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 05:18:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbjAMERv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 23:17:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235614AbjAMEQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 23:16:46 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2044.outbound.protection.outlook.com [40.107.21.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2F5869535;
        Thu, 12 Jan 2023 20:13:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V5wH9eVWQZhE0iDWqL/OhWG0TiyGjsku5zpRcSJmO/kju1wVDBxygATxZGkmQ3xziHF8AuQ8oxV48iegXn19AmVIYwijxYuuGNQ86VJzz91YnjknGcESItWY6jj62BmyeDWCWqcLENzYU5tvHcosIwA9YorFM5UqsFfV34OhH7n4N9GVvNDLn61LWGLqhGX1WpOep80gk4mwTjfpisdEXm2XB5lCZTB7/eWHSrDiz/MriSDEq9UbrVm9jMzZCEDKfou2l4A6pnLYPzET//wGpt/AhNbi9AwdXqpOU8AHnCcQOHzfFHHce4MFmDRqzRMGPTNsHIi5ymAwX0yr7z6F8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OZd/pf9Nctz2lcb09rfma/BLcXqoUAi2b/OPSEzICU8=;
 b=da8tYMMaOr8z6tQ4XyjmY230YcHqhxjdiTjBo0/gtMQpfVhwyToL2YnK9SEuMBJnWF2z9AcEebZ4KtmanNkLCgBv9PdUeLcitNNKR5fc5jZlu++8WoMn61pdPqA9SaVYObRDr4rihZX6GqmZnPohvYPo9p+f5Zt1SeQ5oI2dmF4ufAYIZ5vlRN1L1HsHcPUUuyFu6q3XzDBBOpu6vHCfHSh8Wadep6vrIGjFVuXjvk233zzuqZnYRdX+LsBnr8s6UZQX8OWEE0RJxqA9Av90Qvg/nq6IZoPYuLz5N5e6TJYNrz+AEkbBnOehgKtMl1a+gfVM5Iyk/h9ZmOA1JZlMUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OZd/pf9Nctz2lcb09rfma/BLcXqoUAi2b/OPSEzICU8=;
 b=hjYIqeJYhS+vKWZrATua80RlQZ87Jd1akujQWYoQMF11d2iUKjL4jCPdLMnvLE2Togm9IuoECIOcQ/tHFtoP9ePeWLW7U6jGTyshcLu98ZhplYbx7yvhFiY2iFzGVbarJEPKvL57JWlchflQy0Yc57ZOQf5ujL1OfIWm11f7Qa8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by AM8PR04MB7441.eurprd04.prod.outlook.com (2603:10a6:20b:1c4::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.12; Fri, 13 Jan
 2023 04:13:31 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::3a82:42b3:f1ed:5c3d]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::3a82:42b3:f1ed:5c3d%7]) with mapi id 15.20.6002.013; Fri, 13 Jan 2023
 04:13:31 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, robh+dt@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        xiahong.bao@nxp.com, eagle.zhou@nxp.com, tao.jiang_2@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 2/2] media: amphion: support to decode RealVideo video
Date:   Fri, 13 Jan 2023 12:13:07 +0800
Message-Id: <7e51bb1653eac32bcedffdff740fd0ebe8a96720.1673582851.git.ming.qian@nxp.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1673582851.git.ming.qian@nxp.com>
References: <cover.1673582851.git.ming.qian@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0230.apcprd06.prod.outlook.com
 (2603:1096:4:ac::14) To AM6PR04MB6341.eurprd04.prod.outlook.com
 (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB6341:EE_|AM8PR04MB7441:EE_
X-MS-Office365-Filtering-Correlation-Id: 695219ae-962b-457f-d4fd-08daf51c87e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A51+iQJMksG+//w3YRBh1ZpMYc4lrghknUCkMh7+xXxnQ5FwenvKUG4R5vuTYAMQnZprnqS1AFCY9loPDmzbI3DxDfwxjD4Nil/IG+tdF/58qxetP/5VKcBBKNrnrHakWOeYCNtvlR3Ri0Uo+fixrTzJht7WV7HftsqcVig65NLtFMewkvHVegcRW2n3ZBDqXaPi6nCvN8jjhYwxWZ6YbX80zIzX2zstae+DUl+/M8Yc+ljFZAxuaF7V2CHZ0a4E09WRjjgVG2QKwh1CLjNInAad62avfSp/ZlRZAnyYQ/C176cltUiZCVXuz/9kpkCMZJi6MGEmKpjN+tc9ORmRs/3/KuXkHulFHur6HzNuRc2HTjafI9es+66AXVT59dYlWVoTqS68kUy97yQqx23SzcFLGwDEb3nmKpg8C4k8iOT0lXkGBJ9CFL+5WULGw5/16gwwW+z/zAk8TZfao0chPRPYwmoRW2cr36ANML9Z5F7yfqa9bHcjkwb+nhMPaDbv1JUb22fQLlQ+Cey6dYhTZIHVhjNalEpbmOL/D3XU6I2dJyCgqaLbyxQgXss1WBz1OmTZGrDPxFH37UXxYIa4PMJtKWH16SbSkcV2Q9nInAntpVGfidKfZkZ2//WIwoN3QZNR/H9dcXEt/okXOLs8W61yX2E2uUZcbK3lXLSyoUxXL95vlpPfxB38IL0AMVqW
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(366004)(136003)(396003)(39860400002)(346002)(451199015)(26005)(6486002)(478600001)(52116002)(6512007)(186003)(316002)(2616005)(8676002)(66556008)(66946007)(66476007)(6506007)(4326008)(6666004)(41300700001)(2906002)(83380400001)(44832011)(8936002)(5660300002)(7416002)(38350700002)(38100700002)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EGomi/16/cBeDU6uQ5tZP9nAPezBTbIkcIgmB3Xil5VlYd3qMXup9V2Quxx3?=
 =?us-ascii?Q?sjPywXaBobzk4PdL3Ezyk1ynBbxaZBfJAgzhGxqVHM83zoEk7uYQdeiBbv3U?=
 =?us-ascii?Q?06Qrs/RdqxtafZL3vBeeHbf6E0ei0SdU+yY9+b7Ub0302PWWdQ5cjovtq2uF?=
 =?us-ascii?Q?r0Cf/YjFZF6zwtBVl0bMCjJtYc9vxrh01cNqs9lkIxVTT+d2/34ook+M6wcj?=
 =?us-ascii?Q?sUx8JvkTDhLfN5Q6VMngS7ZzxxDa0L/ayZ7as+uSXzwHB5+6/FQEIpcf/Tv4?=
 =?us-ascii?Q?RUi6FPZJY/v1/KxdJZkPClfQlvVzIi23PwlMT+FkDAWr/Vgqbl7/nzYrQn0j?=
 =?us-ascii?Q?xkHMzjkeIcfF70gfPijPS3B4jNtE1XpWxjeHHMbyKKyMpK66ovWruFtyJfUJ?=
 =?us-ascii?Q?jd73a3dD93O1sGkeXN3gP5wkzeJp0v7GvXzM1L52EnFsy2Bdru77AIuVHfCo?=
 =?us-ascii?Q?LvTzbYpbXltifMOXsbSPMxG5tbfr0S+kD3Hwwjig+pTaBWZ7cCRZeoAG2Ef9?=
 =?us-ascii?Q?+Aq3CyAxrrhlmLDknk7WVkhyDTlKPbMXBEVA3H87eOwseKoHnZyJUMG+w+K+?=
 =?us-ascii?Q?WTyxjOoWE+CB5WqYJf1ZOXPt0ohnjWUT/gsvO35Ka55PDDGxz8UW8MDsTtkp?=
 =?us-ascii?Q?WYny9Fi9cjg7c9rv9tNEhcYC/xGxN1q82G89CC0htjM1VmC9EFDJUbviqr2/?=
 =?us-ascii?Q?ixq7/HmjVrcnSpaXDNwC7J/6Mhrzq+jnGk6VBhlZwaYHvhwwvb1vNjyVUPK7?=
 =?us-ascii?Q?PLB0mVFEgkHGnQ6CuK8b8tP7vCO+9ft2rtUcpFcYnyEPD2iJ3DLiBC+1QpTz?=
 =?us-ascii?Q?pj7QoD7mMk+4C+VWSNtgiPlpW3ca6EZUPN4k8ucXezOfNVoN4ycXyvuBMSnA?=
 =?us-ascii?Q?My9ji8eYQIq2zsrRnV5M02SrEUYPqkJ4VRXJKB/PLD3i8qohX6pr89RmYify?=
 =?us-ascii?Q?0ZLDjSxOGB7HdBpPIu1n9ujXsWw1cApbHSz4X9Fl8bKS6Gg8eXdRKYMDqZXT?=
 =?us-ascii?Q?fR4YOmX8Ec7oj65MiR59gQZGns/boymChM/fMWa9xxZDWebSNRpMYmiPM4aM?=
 =?us-ascii?Q?cu13DUgxdkY/IGJN5Hrn/wthZb3bJJuH7FlH7EE/+FSv2/UMboXgnfJx+7Si?=
 =?us-ascii?Q?y27oaZeQWeiBRfzHx4+gPBfP3BeqlABBcLkdIJQ10haROg/RZKZPlcaOXWHL?=
 =?us-ascii?Q?JtZtO7V3fjGudk2thEabFfVfCkSOuceQreztOwwRwNHL9y4z99jt5s586DBF?=
 =?us-ascii?Q?u8hFViCqbjJksEG9pgmbgkoJfwh/vlcdvcoiuS+1/QQUTSbg2J5lYUBPW3II?=
 =?us-ascii?Q?ZOeiM0l/inBzY7NM5RhSxYjHnr5Rh6KiXNlHZeL7FFMIUGJAMcLRcVyFPAWJ?=
 =?us-ascii?Q?y5hIfjcJhpEgpiMaPqPTmRkWxXajCQQYSXFQ57oCQjiInW5Aea1eTIG5NDDW?=
 =?us-ascii?Q?R0GS4XdZMNLwRXbH+xbFfRN3KgUTdb2spfzKx9ob6i7hqTZgg9+eQ43/M7u3?=
 =?us-ascii?Q?IvFWwIWd4WQwj21EvC5zrm3xLKe9lR4GKgN7xaUWq/Znzpn53ba2gyCOeutx?=
 =?us-ascii?Q?dDvZnZvf/FdKFPk0bFEuGYdCNX5v2CZUIYlIzHVv?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 695219ae-962b-457f-d4fd-08daf51c87e0
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2023 04:13:31.6238
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lqyz6Kcx9Jj1uYFSuHHQJPADK2X+3tZs6TI83ChcPDw+C3QSoYphawoIRpG+UeSXpcmh7juqPFy7mCclov0glw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7441
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
 drivers/media/platform/amphion/vdec.c       | 14 +++++++++++++
 drivers/media/platform/amphion/vpu_malone.c | 23 +++++++++++++++++++++
 drivers/media/platform/amphion/vpu_malone.h |  1 +
 3 files changed, 38 insertions(+)

diff --git a/drivers/media/platform/amphion/vdec.c b/drivers/media/platform/amphion/vdec.c
index 09304b96f40d..03477998b9eb 100644
--- a/drivers/media/platform/amphion/vdec.c
+++ b/drivers/media/platform/amphion/vdec.c
@@ -172,6 +172,20 @@ static const struct vpu_format vdec_formats[] = {
 		.type = V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE,
 		.flags = V4L2_FMT_FLAG_DYN_RESOLUTION | V4L2_FMT_FLAG_COMPRESSED
 	},
+	{
+		.pixfmt = V4L2_PIX_FMT_RV30,
+		.mem_planes = 1,
+		.comp_planes = 1,
+		.type = V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE,
+		.flags = V4L2_FMT_FLAG_DYN_RESOLUTION | V4L2_FMT_FLAG_COMPRESSED
+	},
+	{
+		.pixfmt = V4L2_PIX_FMT_RV40,
+		.mem_planes = 1,
+		.comp_planes = 1,
+		.type = V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE,
+		.flags = V4L2_FMT_FLAG_DYN_RESOLUTION | V4L2_FMT_FLAG_COMPRESSED
+	},
 	{0, 0, 0, 0},
 };
 
diff --git a/drivers/media/platform/amphion/vpu_malone.c b/drivers/media/platform/amphion/vpu_malone.c
index 67ba637c4c7f..26039741166a 100644
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
@@ -478,6 +480,9 @@ u32 vpu_malone_get_version(struct vpu_shared_addr *shared)
 {
 	struct malone_iface *iface = shared->iface;
 
+	vpu_malone_enable_format(V4L2_PIX_FMT_RV30, iface->fw_version & MALONE_DEC_FMT_RV_MASK);
+	vpu_malone_enable_format(V4L2_PIX_FMT_RV40, iface->fw_version & MALONE_DEC_FMT_RV_MASK);
+
 	return iface->fw_version;
 }
 
@@ -563,8 +568,22 @@ static struct malone_fmt_mapping fmt_mappings[] = {
 	{V4L2_PIX_FMT_JPEG,        MALONE_FMT_JPG},
 	{V4L2_PIX_FMT_VP8,         MALONE_FMT_VP8},
 	{V4L2_PIX_FMT_SPK,         MALONE_FMT_SPK},
+	{V4L2_PIX_FMT_RV30,        MALONE_FMT_RV},
+	{V4L2_PIX_FMT_RV40,        MALONE_FMT_RV},
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
@@ -989,6 +1008,8 @@ static const struct malone_padding_scode padding_scodes[] = {
 	{SCODE_PADDING_EOS,      V4L2_PIX_FMT_H263,        {0xb1010000, 0x0}},
 	{SCODE_PADDING_EOS,      V4L2_PIX_FMT_VP8,         {0x34010000, 0x0}},
 	{SCODE_PADDING_EOS,      V4L2_PIX_FMT_SPK,         {0x34010000, 0x0}},
+	{SCODE_PADDING_EOS,      V4L2_PIX_FMT_RV30,        {0x34010000, 0x0}},
+	{SCODE_PADDING_EOS,      V4L2_PIX_FMT_RV40,        {0x34010000, 0x0}},
 	{SCODE_PADDING_EOS,      V4L2_PIX_FMT_JPEG,        {0xefff0000, 0x0}},
 	{SCODE_PADDING_ABORT,    V4L2_PIX_FMT_H264,        {0x0B010000, 0}},
 	{SCODE_PADDING_ABORT,    V4L2_PIX_FMT_H264_MVC,    {0x0B010000, 0}},
@@ -1001,6 +1022,8 @@ static const struct malone_padding_scode padding_scodes[] = {
 	{SCODE_PADDING_ABORT,    V4L2_PIX_FMT_H263,        {0xb1010000, 0x0}},
 	{SCODE_PADDING_ABORT,    V4L2_PIX_FMT_VP8,         {0x34010000, 0x0}},
 	{SCODE_PADDING_ABORT,    V4L2_PIX_FMT_SPK,         {0x34010000, 0x0}},
+	{SCODE_PADDING_ABORT,    V4L2_PIX_FMT_RV30,        {0x34010000, 0x0}},
+	{SCODE_PADDING_ABORT,    V4L2_PIX_FMT_RV40,        {0x34010000, 0x0}},
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

