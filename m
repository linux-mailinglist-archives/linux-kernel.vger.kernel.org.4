Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 853BC651C76
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 09:40:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233192AbiLTIkF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 03:40:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233115AbiLTIj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 03:39:57 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2049.outbound.protection.outlook.com [40.107.21.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1DF816582;
        Tue, 20 Dec 2022 00:39:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W5+Itfd4cc+0Yz4JYt5Wkwz+i3MkP+VuhmTHPxoq79aKZtFcmXB49v8eAJktj2AOG+vaTulNM/hb09QO7G2dDljXxMWnTUQhXho3OsIuZPPlyysOGP8LgPxOcDlZ4t+73WRfqRQYY2JLLzyF9hEkZJCx6PwU6avS694y6ToPE4LZZho52IV6rXpXof7gYkwq36MmKoBG/Tnr/mECzpBhTqt9fH4ylJrS/taggdm9Su3Rr2t89MQmIMh7A2SXIhc7dOLatz4x7R5t/Y7Aufv80w4Zo3NVTEf2wSF2KzEITqQYR6B/j8OBhrAmEfWr5QFMUbAWq1Rp0COAeYs/IkDDRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CgSY55gUz2N+idyDtg+l8a5zVEJNu4gnZ9XzReY297I=;
 b=Z4HMJkTk7gl3gYoHSMGvMss8ss3d2UTldVdEVpuMs9zi6esDHrddzq/BzlE8uoM3GeYdDlcalhtdOgIHYLih1omRBrIq9xImcuQVGh9N4nAJuCxtpRK5qFs3HVdVZWtZOdSynIabuB/Ov16HudsF5ASqjJKwl6tgwN5MNL2t6RW071+eVDXZnNbwUMJFt7dQYTuMgAcf/9gTmNAAOUIDV11iJa47vJDMaEqHwz1U8qS9fGg/2ZSWISBlt58cm+FShd2ZokyfRms95vfy0Kd5kncGJ3w689f8fBi8tDuZjKv8VEL1Ve0jx+rqCznRLGnKmWS1NZTpH6qlMyCZkz/9wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CgSY55gUz2N+idyDtg+l8a5zVEJNu4gnZ9XzReY297I=;
 b=CZSSx1GZ3jENuIj3xGNE9whZMwy2ihXlsPGOV08+tdWS2C3e7WPfMOCRTV5vxDnCAgnTF4vk6qN2eSKZzYGS9Y0AkVgMlG1dKHb5GdPCO9VEfPItemuYruxqoza1pH6IMAYP8H+yb09Db6WHT0k7SGzPcgJcCQc51rqm+a/juM4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by PAXPR04MB9255.eurprd04.prod.outlook.com (2603:10a6:102:2bb::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Tue, 20 Dec
 2022 08:39:53 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::3a82:42b3:f1ed:5c3d]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::3a82:42b3:f1ed:5c3d%7]) with mapi id 15.20.5924.016; Tue, 20 Dec 2022
 08:39:53 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, robh+dt@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        xiahong.bao@nxp.com, ming.zhou@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/2] media: amphion: support to decode RealMedia video
Date:   Tue, 20 Dec 2022 16:39:20 +0800
Message-Id: <90ea729efa90529e47f0bfbcf31f6a0a9b00d796.1671525379.git.ming.qian@nxp.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1671525379.git.ming.qian@nxp.com>
References: <cover.1671525379.git.ming.qian@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0098.apcprd03.prod.outlook.com
 (2603:1096:4:7c::26) To AM6PR04MB6341.eurprd04.prod.outlook.com
 (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB6341:EE_|PAXPR04MB9255:EE_
X-MS-Office365-Filtering-Correlation-Id: 07272d81-b33f-40c4-e5c1-08dae265c3c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FlTU7G09fixI6B2NEHBfu098+RzMgO75U6jIcynJEKkD75eRg1Ji77KMdc2pnpjQBp7AuoNkwkTXARdQPgmVq5Fm6qRPKpdcdgl2dF8Bekawq5Zo6oRmqoMDcayCST7+h1AOJrCZ9d6LWTlSUe1qWZYralntVYLxBEjq8Fgh9J4/p41UTskQc0TYHTZ1WAhxMpyCLlgXTRGh1oAvLdh+gm0Xjwb1yQ1N5z2RF6EA6H2AYfY7lOTbebXSGTkkr5VDyeKxLUxGHWlQlTN4vY9zlmjsoJ3EcLUnru9vdcSX/chp3mn5vHFWOnYbysZloKB/O54lWyursEXmbgypERZ6k2M9CC6rN/pKEBZ6tsRsxHc85PumFQokbKhN7PE2sZEkGXjchkp2czU11Irjjb55+Q32xdKD5EzxrzGyQ83LKGZRm04Gab1ElcGJC7ot8RQy2OR/BF9Mmh5qX7EU1aiV8e28Ev2JFgRtACb1HgbsXYQ6URzkLC+4iVp8dhAfSjNw1ubO7xMwGngnOIeQcrgOSyxhwKZMnMQGTk22i8WVCeL1J99gby8CD0EHHM7rk7jyWEzpVakVWA4t8d+6h+LuQCb5VYqxsm1g45CKWtLDKhB0CTthNrwB7tmkIk98lOBYYsRKV3CkC+EDQJP/L7YbW9fs812en+0Or/t119iwHCAafxTkXZfhBDYrQLUYSbyl
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(366004)(136003)(376002)(396003)(451199015)(5660300002)(7416002)(86362001)(6512007)(52116002)(186003)(26005)(316002)(83380400001)(6486002)(44832011)(36756003)(6506007)(478600001)(66476007)(38100700002)(66946007)(2616005)(38350700002)(66556008)(2906002)(8936002)(4326008)(6666004)(8676002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Nauq1CM3t78JcRq9+wFGoqJ4bBO0PMgxeVEAPjm+rjokJXn/m639+iHbLduN?=
 =?us-ascii?Q?pJ645EW5PFpG4LQAU5+Jm6q2KJtnB5ocatUr8cc5pjokhEQK/1BSFeiHqG+O?=
 =?us-ascii?Q?RZ8+DKyuWW+fEaZaiD2kTX6zaGzkz87X90+mzQvVJI/qnvpitAdMz+ah6GYX?=
 =?us-ascii?Q?LeN5w43IYASs/RHf1oeBMpymNZ7Etaxhh2aPPE07/C8YP8Nj4Q4xirqkI/Z0?=
 =?us-ascii?Q?fHe7onspdyc+xp6kR0e9YyVMhQ8yppOSJI8bi+TcY+UDbXM6vgVH6bGJ7azQ?=
 =?us-ascii?Q?z9nWISc1xatoJwJwLwq+EPOjHzDhpld0nSnEIKCjPiYdBvQBqsviqrIEA9gH?=
 =?us-ascii?Q?KNNHGtpj9gpXhCvIhofvcLGnKgOQFCDcmwdtCTZsMig62CbyNkSsQKzsK+ve?=
 =?us-ascii?Q?bxjdpJ4936GB0Jc0J0fx7YzSV8oYeCKwNYHQuYWaGqGByVfRkSrU+rW7dy8a?=
 =?us-ascii?Q?3xW29BIfFUOdXPenEQo456EN9OY1MPEobG88Mpg72cCo6AYZvEhREa5SUJ43?=
 =?us-ascii?Q?DCYIHdgZG7mzLpPWfXI5WhiR2+3c8NepHgMbqnJdJNN/YGH3Zapblsv6jCkJ?=
 =?us-ascii?Q?2Hl7gQUvy/g07NTd6ONe67VOqUECIUJ8RXna820HIwLQp+WjMdsaAE/Ass2r?=
 =?us-ascii?Q?yfgcNp3xbapXb46lK+/Z7HXAELJFC4DYJTroV0sMJ5NLC35PdHaEk09HPbDj?=
 =?us-ascii?Q?fhHRCUB3txO4M//pJEYTqwscbZjCSJw4tcgBXqcH/bGv6POmtSp30StlfbGR?=
 =?us-ascii?Q?wRnoYpbinhYxD4nT8MJahbweqFr99in7B3u0cNoWbYjGPrDgfAaR9miNQud9?=
 =?us-ascii?Q?azRTinlsMdCxWFjVr010mbEuKClKgv8AsCLZGrR6xUvgU0lljWa+9UNkjJvS?=
 =?us-ascii?Q?8LBWX0/iJaer1lmFhLzWTc+ZtLRdnuRr8cDq+onQ2c8cIMK4s3fLVCxOEvIs?=
 =?us-ascii?Q?mcntBJ40TV2hYYq9i4SIb3LndwQZPd1KEDEeaL2J+EYQ5n2frvTqU5tAzdt7?=
 =?us-ascii?Q?v9ShLe2XW2xTLFB8k3DEKeY8WVDj1diAukUaEUj22QM+k7hek0KWE9ZX1cII?=
 =?us-ascii?Q?dxGycV0PFKVPpgCs3IsnF9wyOegnVhCGMW5RocLF8nX1e+aVOlQpCT8/+9dD?=
 =?us-ascii?Q?wG4i8ezJMOG7tCn2dBPeeeNEDb+d+bGyqB+6M4I+/n1tT6wH7PHmIcUs/BRY?=
 =?us-ascii?Q?MnFeosWeKgoThXqmcQpvWKpA3qDLQV8AKzhRyJQh6Fql4sNbkETI2V5eupzm?=
 =?us-ascii?Q?lE8ZXLWS9CaWsj4RpJ89OA2LSk4+FCgqqNzczOaIra/4UAqdf0PjWhn61pCg?=
 =?us-ascii?Q?MBIPBuByAIIM6vyXPahgd+3UiaonHGcYof5ikmXVJRENoLReCHr1Q6FJbX/G?=
 =?us-ascii?Q?71O0xbx5TbIhELji5xREtlTkbQJy5n3PBgcjPOhY3x/TpxLDo5qUG7RR4gzG?=
 =?us-ascii?Q?0EF6V4E79CLoK3fzSwSUKOopHXsLta08y8GjK/PyNbi/Pyz/3ZosAj/HzhEN?=
 =?us-ascii?Q?/wTpIiTMgzq97iQ9yFXmDMG2hcNwOhUd50iEvzjJsrxGt12CDypu+llUnqD6?=
 =?us-ascii?Q?jiJ9PpNZPHOLyMswwrQkTk7iB3y4QLhcr/xxazwN?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07272d81-b33f-40c4-e5c1-08dae265c3c4
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2022 08:39:53.2100
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tJDKzhudf34hKsqhijY3ugmO36N5YCGHyAK9L8P+YQN5ALhf4CuqYcWkT2jL3w5NJZeJRAGJJmbSlqVDVpJ0bA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9255
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

amphion decoder add support for the RealMedia video

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

