Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 055F3638242
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 03:08:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbiKYCIO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 21:08:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiKYCIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 21:08:05 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2048.outbound.protection.outlook.com [40.107.22.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2093D18385;
        Thu, 24 Nov 2022 18:08:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F8Kxizu1k0DZwH4gGpR66P1xKJlfbOgn9nFk/UdfCJYFTQsnn4vRvNAl41GyxaoS4H6QXxK1h5rtSjlHA0A0ZW+yE9RNH01GZnc0adaVG7t0UjuUmVjXDjqN2inCPZ0J5bl7/ezTwV3un34eCWYM8HySw7BaaY6z5j69G+x/poo8glG4AwS/mgpQho6g+c8kxzpw/SGC8nliySa5PyfjGJ6TEa/nNXThKwyYLnyhrZpKVSNbOmzpxDIEb1xWzjiLZjylXYwieoi58bEauQAHh3785mqarQMMixUlXRkac+UHIN0uSRjgMCE0rlOLAs2jWCZbgTSr8rfV5XjdfyqGGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6wmrhD9YBh+fO75kjzItDt3H75Zx55nQKxB2WsnNPl0=;
 b=X/8Noz/zrLbTsPIdM4pR1ojdthFrlW9ZRtx9BQLaWoyxrcogsEWFBLExUYgRhvkraHNN3Cum0k945LCiIJ/UrzuWhIInIKcBVYBs2sG7/Nkj2tt8CUN153uE6BXQQwMNgEXG42hkHtNswZW0Bj3eYZdJ9HVbJ4e6h1VEWHlKb36D8bsKmdQjIPYemnokWuA3DIvvgEQbJCedELCImvXSLFRl1DEPFg6JoZi1RrNJoa8bfcpU8W2mdt5R1W+7A+KgVbL+dHAuGnByqgI2ivrr98jVA29j5AneXu0uwO4+kmooTt1yjUMHjH/IL7uYA9S1QJl3v8908dG+/T5/9nv6oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6wmrhD9YBh+fO75kjzItDt3H75Zx55nQKxB2WsnNPl0=;
 b=DgRIODMcmEos7vDtUmairAz+Ha9o3Fxj4hcSCIf9fQFfKaljyqJZRv2xHn4GmXKzyMIEtCtbNr9G2+7Kr7LFz34+hYo8k/Tp+7jH4+uCvbo0uunDD6OjCQjjqFYkw85jVszSHd9L9bSPedEB9JtEHFx1xZsD9EOhf8nTaJ2DY0M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by DU2PR04MB8933.eurprd04.prod.outlook.com (2603:10a6:10:2e0::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.19; Fri, 25 Nov
 2022 02:08:01 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::5c78:27ea:319f:d11]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::5c78:27ea:319f:d11%3]) with mapi id 15.20.5834.015; Fri, 25 Nov 2022
 02:08:01 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl
Cc:     nicolas@ndufresne.ca, tfiga@chromium.org, shawnguo@kernel.org,
        robh+dt@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, xiahong.bao@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2] media: videobuf2: add V4L2_BUF_FLAG_HEADERS_ONLY flag
Date:   Fri, 25 Nov 2022 10:07:41 +0800
Message-Id: <20221125020741.28239-1-ming.qian@nxp.com>
X-Mailer: git-send-email 2.38.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0019.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::15) To AM6PR04MB6341.eurprd04.prod.outlook.com
 (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB6341:EE_|DU2PR04MB8933:EE_
X-MS-Office365-Filtering-Correlation-Id: f16305f4-b7ba-49ba-3318-08dace89e127
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A2vTYmuxYaRNqPH+4u/R8WZaD7CCbkYOp9yuyUWtt0fO4/JNQmx/tjpRWWWWpf8LnVtMpoht/D5Tv2w2OaVeoBCA+gFZHt2UK+c5Eee4QjQ9vUGZZfa5Kc5Eaj55p8CqajOwSs8nX+hS3usk6zPf3TIZajKJ9qeDc98BoViVhB8STs+TbpdPvp4oamt7IvpgVp/UnRcdKIR0zMRn+GU1s9cUA+wZ2a+ZKFrffyS0bstwkhCC59kSafy2h25c9C8g7GjaVk2oSoTdJgsL79oNVqWcfYLKczJW2cfgbCZqm8fujacjGiTBdJ1tDbvlAB1tlf1Q7MwjXkiMuP6crOD3n+o1c+eb7XvlwJ46oZSQS/Yh7KZtXbgYtwyUNoOhfU5LOAoZwjtAFc5ytQG8MzJ/d4vmqzOStYLfRuBbLT5rcxPqr769rQKjMWQ4df8SZ70sCAQieiC00ggUZtgFOMtlsoSULjqAu/vH9Yauw6UM0BMVMPudMjP+oy+UX3buyWWuEhUMhYzi+/sb1yUatOHq9uMdU9zs3+64EQcVe07HfaiabIMJ3+yqngt4hEW7lbRO9dO3pXQdAgXXjCj5OO/wKn5azb7+cD2MaSfAQOC7d1kyE82uCqoo7D4OSqzSV7LXGT+f+muLPavCN+CFyUpjgu8lNxpnCjv9Xy0w8bZZ7MSW8FsUs0mhV+jxS3lGFe6I6AkYarv0HkTdA6r/J8GRFw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(136003)(376002)(366004)(346002)(451199015)(44832011)(5660300002)(7416002)(2906002)(66946007)(83380400001)(66556008)(36756003)(8676002)(4326008)(66476007)(86362001)(316002)(8936002)(41300700001)(6486002)(478600001)(52116002)(6506007)(26005)(6512007)(6666004)(2616005)(1076003)(186003)(38100700002)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PsrahRL30a/fqsCoHLodFlQo2J8vWvU0O5cyDZ/kCzTRB+cCmO/JLtoiL/1I?=
 =?us-ascii?Q?J+FEISxtfWw3A67YBlvtfPTocDfem3XqcnoTTdxQHXoRT52lpEV3A1W/L+6o?=
 =?us-ascii?Q?kXbEZUuuGYBk1xcBdW0XxSWqOKfro2XpjBzKRjl8VJqZ7/ucuN6hCc5ZY36f?=
 =?us-ascii?Q?6879mb1SZ4lpZNnh7sVuWCr58TABjFXdUEVkjXFCkeF/X3BpOBaodTXv0pSp?=
 =?us-ascii?Q?EnrGjb4+7zFWgyp9iYdiXW0Mm/pd1CzmsPAqI7C67Xu6a8c3D0fTl+Wukk/F?=
 =?us-ascii?Q?ORkfbyMTxkEZuJyQEtBZH2JuFk8nRzMrReS7as0xIa1rwu+T4aB1M5yrQUF8?=
 =?us-ascii?Q?p55VzR9Y8f0S+RdshdV9BNbK/VSE4Ekh/xvDAuh6y8FVNW7kvVXSDrPLluV+?=
 =?us-ascii?Q?EE1JaYXCc5PDO11+1/OLB1JFAUyuTgO1CbAL1OXf6GGw5SJcnvyS1FVrUvad?=
 =?us-ascii?Q?0Mf7CebYwYfyMCo2FXV7sQrXdTlrmOnuG94KlZVzYAIHUkKx/XVCXlE/N0uO?=
 =?us-ascii?Q?fcautw9ckewYm35X7mCTOuY/tBnsa9kU3U7CWS8cBUPJhs6SgjxSrd+VzacO?=
 =?us-ascii?Q?RD29gwfqKPA5SBB3N6RlaEBlW4PqrqNr64ABLy8vkGqAJDg1jdkr9tIfSqh5?=
 =?us-ascii?Q?RegzgpKhdgcWwoSv6OiwW4C2dEgfPOwdcjrlWaXtzCaIaSB8CWmyZlCWE7wZ?=
 =?us-ascii?Q?v0BS3o/uv/gSPWXuAKKkMWIJrGU5niO9gztPofLBye+sYjoV0q1ENDhRYmhR?=
 =?us-ascii?Q?10ikJ/z1yvSRhOBNwgA5XD7oB8AeGJWgiQZcCWQKHyVDWgEYP3yE42hAM4JF?=
 =?us-ascii?Q?3TUOPHkEBm4v8WreCDfkXZROzY1skfM7nBmCEoafwH2oAAea/rA2l3OlziXj?=
 =?us-ascii?Q?4LQr1AKkHz7TJ6sntBEBs1DxauVQAj02QDRAPqLovseciq3Pd0au/ZQ/cHr1?=
 =?us-ascii?Q?703i5IOmrmFPIsMhBLOAM+7xN9kopw3Ud39ytOfn883K1fUXp4fJ4BomlsAe?=
 =?us-ascii?Q?WZToEkGNr6O9XI3+OkJknloGl4+4skR1er2Yofop8+kCENeJpYCseWwAtxO8?=
 =?us-ascii?Q?w3C99jpeZHGS4UoyBd0TfgQL2k+qCYDoYBA6mtQgW+i76Q2Uwr/kwpKmD5Wj?=
 =?us-ascii?Q?uK3aEevcRLmjUH8rYROV3ZsZ6Fc6uAClYRbzkWOLSP/k3VUGX6q0SubgKHZQ?=
 =?us-ascii?Q?N706S6fhjrmhI32biMNkg/adRt4bqU9Pi8x9BFyjvvG4kDoJDwdOCulPscX+?=
 =?us-ascii?Q?Oa+5Of7f3OXorooGRuyqVsQjdu5uKO0wp0wtZij2Ho/ttueQaRv7V2jNB/q7?=
 =?us-ascii?Q?lCxYHJbO01UfRKWPiPLeB/XmYVpvrjJmDm19GjyGmFdusrdIBvMlVuJXQ8vM?=
 =?us-ascii?Q?M3H/+N0UJF/Tu57mgNpaQW1AQoyQGeAsUvfC8rky56masQQAxVCD/Rv+8f4o?=
 =?us-ascii?Q?pngaL9IRE/Ro/Oam34u53dI4XKHf6Q22VdLPfQNlnOyQaD/zvipS5mYtuZj/?=
 =?us-ascii?Q?VrDdN5eI0VLEOG/SOm0PYoNWiwyty4WGzbQvCp96HSXAMGQVLb1bQiHzvwPq?=
 =?us-ascii?Q?irHgYD7cZkJSwycr3L2uqRZk8D3w62S6mnrEuYoA?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f16305f4-b7ba-49ba-3318-08dace89e127
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2022 02:08:01.1974
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1GttCE9k3tZvfi+v/Ose0bnrVYeaG8Dk6G13VXvdk865357y61GltMU5ixdkEhz0GvkmqSTcwBOeIM0KcACRYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8933
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By setting the V4L2_BUF_FLAG_HEADERS_ONLY flag,
hint the vb2 only contains stream header,
but does not contain any frame data.

This flag needs to be used when header mode is set to
V4L2_MPEG_VIDEO_HEADER_MODE_SEPARATE.

For decoder, there are some scenarios user only
queue the header in a separate buffer,
especially in android case,
but some vpu requires one buffer contains one frame,
for example, the amphion vpu, if the buffer only contains header,
the driver will merge the header to the next IDR frame.
So driver need this flag to tell this case.

For encoder, it's an enhancement.
when V4L2_MPEG_VIDEO_HEADER_MODE_SEPARATE is set,
encoder can return vps, sps, pps separately.

Signed-off-by: Ming Qian <ming.qian@nxp.com>
---
 Documentation/userspace-api/media/v4l/buffer.rst     | 12 ++++++++++++
 .../userspace-api/media/v4l/ext-ctrls-codec.rst      | 10 +++++++---
 include/uapi/linux/videodev2.h                       |  2 ++
 3 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/Documentation/userspace-api/media/v4l/buffer.rst b/Documentation/userspace-api/media/v4l/buffer.rst
index 4638ec64db00..f00521c7ec48 100644
--- a/Documentation/userspace-api/media/v4l/buffer.rst
+++ b/Documentation/userspace-api/media/v4l/buffer.rst
@@ -607,6 +607,18 @@ Buffer Flags
 	the format. Any subsequent call to the
 	:ref:`VIDIOC_DQBUF <VIDIOC_QBUF>` ioctl will not block anymore,
 	but return an ``EPIPE`` error code.
+    * .. _`V4L2-BUF-FLAG-HEADERS-ONLY`:
+
+      - ``V4L2_BUF_FLAG_HEADERS_ONLY``
+      - 0x00200000
+      - This flag may be set by user for decoder and by driver for encoder
+	when the buffer only contains the codec header,
+	but does not contain any frame data. Usually the codec
+	header is merged with the next IDR frame, with the flag
+	``V4L2_BUF_FLAG_KEYFRAME``, but there are still some scenarios that will
+	queue the header in a separate buffer. This flag can be set only when
+	the codec supports V4L2_MPEG_VIDEO_HEADER_MODE_SEPARATE,
+	and the header mode is set to V4L2_MPEG_VIDEO_HEADER_MODE_SEPARATE
     * .. _`V4L2-BUF-FLAG-REQUEST-FD`:
 
       - ``V4L2_BUF_FLAG_REQUEST_FD``
diff --git a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
index 2a165ae063fb..e42d6b4b15f5 100644
--- a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
+++ b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
@@ -1386,8 +1386,12 @@ enum v4l2_mpeg_video_intra_refresh_period_type -
     (enum)
 
 enum v4l2_mpeg_video_header_mode -
-    Determines whether the header is returned as the first buffer or is
-    it returned together with the first frame. Applicable to encoders.
+    Determines whether the header is returned as the first buffer
+    with flag V4L2_BUF_FLAG_HEADERS_ONLY or if
+    it is returned together with the first frame.
+    Applicable to encoders and decoders.
+    If it's not implemented in a driver,
+    V4L2_MPEG_VIDEO_HEADER_MODE_JOINED_WITH_1ST_FRAME is to be assumed,
     Possible values are:
 
 .. raw:: latex
@@ -1401,7 +1405,7 @@ enum v4l2_mpeg_video_header_mode -
     :stub-columns: 0
 
     * - ``V4L2_MPEG_VIDEO_HEADER_MODE_SEPARATE``
-      - The stream header is returned separately in the first buffer.
+      - The stream header is returned separately in the first buffer with the flag V4L2_BUF_FLAG_HEADERS_ONLY.
     * - ``V4L2_MPEG_VIDEO_HEADER_MODE_JOINED_WITH_1ST_FRAME``
       - The stream header is returned together with the first encoded
 	frame.
diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
index 29da1f4b4578..8eba081a6674 100644
--- a/include/uapi/linux/videodev2.h
+++ b/include/uapi/linux/videodev2.h
@@ -1156,6 +1156,8 @@ static inline __u64 v4l2_timeval_to_ns(const struct timeval *tv)
 #define V4L2_BUF_FLAG_TSTAMP_SRC_SOE		0x00010000
 /* mem2mem encoder/decoder */
 #define V4L2_BUF_FLAG_LAST			0x00100000
+/* Buffer only contains the codec header */
+#define V4L2_BUF_FLAG_HEADERS_ONLY		0x00200000
 /* request_fd is valid */
 #define V4L2_BUF_FLAG_REQUEST_FD		0x00800000
 
-- 
2.38.1

