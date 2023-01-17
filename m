Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A39A66D448
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 03:32:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235384AbjAQCci (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 21:32:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235336AbjAQCcZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 21:32:25 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2057.outbound.protection.outlook.com [40.107.7.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CC53252A2;
        Mon, 16 Jan 2023 18:32:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ASv03ot3JFHPromTMc2iS63ZWUrDYCklfiLbYnfpODHaEFZfL/Y/hPUdtszCJ61aDV+uhxa19FH9KsDAkz+Zr2KdGtEulYtDrMrKVIKGIkj+oEZIDMwSZ/W2GkMyKUffmjfFdB3dafX55dPrY1tdW9gwqOEXq74vv9Fkmrs6UxnjWNmhzGigVfi7dNFBACDn97MBdRUX0dQ4H3mLc/bJcdqQxobR7zyb9qrShxT05TKaBjT1ilURE6aYl3dC6eD5UwbJDVQRbh+Ms2+EOCcTheH7jHzBOPtGVVyXEPN02qFPP816Letbw9BHfPLZ25eW1DmmYGLpT3JCul0m+2NW2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OZd/pf9Nctz2lcb09rfma/BLcXqoUAi2b/OPSEzICU8=;
 b=AAF+fh76kQF3KVYF9lRju2vlUzfL5SYYYBzFRYZVBagM35vO9RjzEpUZygzJmaPT0RscJ5CZUuv/yt0cV0iS3crzdy7TIh32az4Imli4xjZGCz9fPEcXI9m6A55PdAOXqYhwCLj3PSchzWRsuaThxGZCXXfIyoOhUYXqrLXx7gq17KwH3wLyeOLS4H5ymlX93o4TyHb3YF3eLV6q6jDUVDifPuuk1MxU8onkztzph6ghJFZFYEXQKjZVVn+xJenATFXtkSfvu8IVsmT7Bn2scax3KfcHxUMOLGjPqWkWLRyCJsjk7qnc5httdV9/N9P6jBbDS/FhYQw3+9oDbzGeXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OZd/pf9Nctz2lcb09rfma/BLcXqoUAi2b/OPSEzICU8=;
 b=QR1yLyjyDUve6CWf9OvsqmZeJE7YM1qUPlW/S3TsfXLEncJRwd/a9RXolP/yk/3c/Ymfoqgj5HNspIpBk7AsQWihaDqE0ew3YbqPOXf5s5zgeuqBgk6q5UvwyMQNqGDiOWpjF5w1Au2M2oyGrSuEHfiXjtqyRMLJ9L7feIbWe0I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by DBBPR04MB7786.eurprd04.prod.outlook.com (2603:10a6:10:1e8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Tue, 17 Jan
 2023 02:32:21 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::3a82:42b3:f1ed:5c3d]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::3a82:42b3:f1ed:5c3d%7]) with mapi id 15.20.6002.013; Tue, 17 Jan 2023
 02:32:21 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, robh+dt@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        xiahong.bao@nxp.com, eagle.zhou@nxp.com, tao.jiang_2@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 2/2] media: amphion: support to decode RealVideo video
Date:   Tue, 17 Jan 2023 10:31:55 +0800
Message-Id: <9b8c369d9f303c500a1ac20ae2e8d56b99b127da.1673922423.git.ming.qian@nxp.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1673922423.git.ming.qian@nxp.com>
References: <cover.1673922423.git.ming.qian@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0028.APCP153.PROD.OUTLOOK.COM (2603:1096:4:190::9)
 To AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB6341:EE_|DBBPR04MB7786:EE_
X-MS-Office365-Filtering-Correlation-Id: 974cca19-2a64-416e-9212-08daf8330f74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hzDxtiQ7BuuyPj7HVMZAR3WDJbNRYJEysB5pfMgp9vNHoWIviAJD9brG6g0DMJRDOa72678XwUYsBw6JJ0D9pvAfWjiZui5qCCSfganUwxA+uCAk1MsHgOr1+K2LMDocuVMU/F3zOxricXXPn5lGvkTuOPWzCQ/urSVlpVp684A3K8Thkj+AaXV5FqLahIx0cSKaQ0yxM0p2zGWXeuo+hLJjyFJ6KY/z80BqHF855tm6GowCm4kslwVmC21DX/mLaIJNIOA3EEEzQwUbk/xirAyWXVeEyC1vh7mYCtCzIijrxzA8dVYbmmgqE+b8wQ2A9ezawalmSejuGrIhAjng8VBAYHNw73eLRbQ6GPXO5oOMEUbeGehLDA8YTwVaFdXUkNaGxUoR8Fw12/VIhvhBxH1lWn/D+GNglQtOyYwnSiU5u6JDwYHNonhZoJK1CLNINp0QWf9XpiVdzNHtUKe0AFs3fCS141zDc3x3Qhpy+6ZbH7tgWvGRqGyw4pS6cqxb0fGWDMnxi1Xqh1N7+LWdIDfZAnXBf1x6HQ2cNPA+ruA7PqpRQV6jQEdq3nU9X1Ilnq/9z9KHBMQoRs60fXsVrWGaDIxfpkZBp4p7QzjcJDPWbONx+rOmSvsvEvyoea/CB6/CVkaMgsiEPkNS+l4uAzSIWGkqn660OlaJ6Dy+e6WTlN3iKShhGcOHmwMew7sN
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(136003)(396003)(346002)(366004)(451199015)(86362001)(66556008)(41300700001)(2616005)(66476007)(66946007)(6512007)(186003)(26005)(8676002)(4326008)(36756003)(5660300002)(83380400001)(38350700002)(8936002)(6666004)(478600001)(52116002)(6506007)(316002)(7416002)(2906002)(38100700002)(6486002)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1R9RGvp2JuqfbM6wkqwxWIhgRUs/YPVh4DMvX4mYOUArfL1JDUHNkrfyTJJ8?=
 =?us-ascii?Q?TgAfmzTYAMYFYvie29b3nzARVcKBNDnWHCf7NkCZrbqGgTOLQm5UB1tSSw/h?=
 =?us-ascii?Q?45d1NrpsMIW+xr97spDIB6PlowS1JyFA7YGhcdSr2XM++uxJGnGDWfpxSouS?=
 =?us-ascii?Q?4bMPL1rLc9hykynIhyFmVgZeSyNF9E7dJObQmrg7uE14F3y3lq/k2aGnApFt?=
 =?us-ascii?Q?xRdwvkYRkukY4WIBetNO88caM2Loy7vonK6RRrIJmF5ff+XJm0/53Q2snaTh?=
 =?us-ascii?Q?cSA2t9LKkzGSjUAGRO9hi4e8F71rsT/9wdaZSoPBxG/paTpiH27C9IHNXj8t?=
 =?us-ascii?Q?0hCES92OthwNX4obAtji9USj/DtLknGEuTbgQODS4mgIHRjyOVZ8/BM79d0d?=
 =?us-ascii?Q?VWegdVE4kZJ5N2EfB5X6PIIGU/Bwy2yJE15yOTyT7Ny5PO8kPKr2jQ7hHqCT?=
 =?us-ascii?Q?4jYdq5g0Z5zcf29zKQ2fsN/g4RQOsvSgIMDfVAUPukNOGAhnBuK5O9dUYXhO?=
 =?us-ascii?Q?8hLF+MzHRDNeS+onQsRy/hYHIcUH+4aGZ4qlr+2gD1hi4ehjoYkRPuf3WAjS?=
 =?us-ascii?Q?yzwNfOtbCqfXpWln+QUnPYCz2+cN4ScQj1Z223WwGnvqC04gDlsZZpmoLoBJ?=
 =?us-ascii?Q?a42K7NOg2v1K9nApN+IvnKJrZhYkZ8DoMczzsLmIl3Tjy1NS0IYdlMpcZ5uo?=
 =?us-ascii?Q?KfG5Nr6JnlfpuntkmO7ZrAZLQa++DghaxiZmTWCJ67IhbsOIPsm6QtNBWvfy?=
 =?us-ascii?Q?oOvLRheCaxu/zZjS8WuA4iMmhek62QUuXBAxYeF6oygSPvag6+pmSRZsi7lF?=
 =?us-ascii?Q?MnvKjOnkxWccIa2OERbXF4a33Sjkr8nEXI1/jUi5K8atV3dDz0hgLT4P9TtB?=
 =?us-ascii?Q?/qDPr6Jgv7liH0oxolQdW2Q0yFGup3UiDLpuUGjVrUMxecr4bUkkHI38CilV?=
 =?us-ascii?Q?G8VKL6zAtJGCXPJN63xza8/BBVvPuNEQBjcfKrCua7vHNVTG58DYvJHiRkwQ?=
 =?us-ascii?Q?1UOUCd1ETBbk9PfLbwoquWYQX36qRvpf5RCIlR9LyvjdO3u/oQ95nHVEExYw?=
 =?us-ascii?Q?8HUAeqAEtag0eb+Gg3plgSkBk5E5QAwo7ryttw0PbtI91ZyU19tZ3PwqfFhD?=
 =?us-ascii?Q?dYTgdyHUrLzXX8ttLfM97Mmv0yp3PF0WXVGZdb1k447AdnCOx8d+JekdWFnA?=
 =?us-ascii?Q?xhEWxMWvF32ZSifkc3PvCT83PcPidSprwmYropLf98E6oNjhXXFfnnWJ7sQ3?=
 =?us-ascii?Q?qYK8aKXzlzBEV6fKK0wuAeB60rXuFqliJBey7bhlhmuFpJ4Eq8d1jbN1CNMz?=
 =?us-ascii?Q?I9d93C/zhZ5jKnzyeqP6MKYfNKxmB8j2UUMu8MNRO2V3xZBspjvDXf6yu4PY?=
 =?us-ascii?Q?eBIYcwLMBelolp0+Wn8bXpqhyjJT/oWbqS3sa6nYxShTxCH1d1dQy749l7qd?=
 =?us-ascii?Q?FYhyTw4PzEHnb5aksP/f2HbeRdsoCntCW4CZOH8HDHQatsYHuKNZhhF2Okku?=
 =?us-ascii?Q?BepuWuTXyd6dljVSgc5FV+GCyOCZdKaAktmZlGqPFEAgPdpC9QdfIBCBqA2O?=
 =?us-ascii?Q?g9gm+Z6ZKptGzgWxKnWz0MtyF0yKm6M+LqcTYpQg?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 974cca19-2a64-416e-9212-08daf8330f74
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2023 02:32:21.6102
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0eaDY7EBjJV6aRfkJjfvezpsQZP6GI4RXPCLh6BGktRoKFKopq0yFyu04Tvm9y/Ous9HTiVrlo1GwvCEAHDO3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7786
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

