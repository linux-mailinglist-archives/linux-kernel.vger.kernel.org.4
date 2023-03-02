Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC95E6A7AD4
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 06:34:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbjCBFeh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 00:34:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjCBFef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 00:34:35 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2048.outbound.protection.outlook.com [40.107.22.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82C5812074;
        Wed,  1 Mar 2023 21:34:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bqqVj6NA7H7HfvzZc8ocv6aImyQ99FED7GilOlITEN/RbOiLGywIILpCdYJtWmGdT1ZC78mfIFaZvyMLSyXrU3VUUG8wm97b6Viyok6Ks4hAhHx2PsGhXB4K0WB3qdcari1D/f774mtTsg2jmLoxpn7fH5S/4cvNF4oLbKDYnijTOVny2kaKA5ESF/QFSL+EJtTTI/U0CHJk6/5XQdmqqmZqtY7RsSQ0njXlAoiVchWWah63Dc/zbglYuB4T+C8z+KWHp+/nHlk+G7SYOOocW5CUKQv7WEdH9JkJBS+WfoV9sva1JhbX8oksnD2NToJ2p97HyTZK0BVDmyJqqE93ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+3sugRDKoR4VOYpKFOjSfzM+A1fwWF+70xwmen1oatU=;
 b=d2ONZQK8TQBG9nBCa6E+hZSoM0x3WyKPv753CrVp+SrlI8AG0kpm8N+M03976G2jpBpyzmvbwGNdgLR2xznjIJO9b6lDHC6K5liWMzRu5it1kRNUd4CdpXQ13PSQ+vzy/26OyCNVN3oUUZLjWT+t6na+tXOeM50KkMhe7ELE2bvJXaR3IGinxcvsr9fRFee+R97c/WnAQJPWDpnRnX/DLIe44QvqnyOHAU+zqe1qT0idDpIx2WdaSkyfwVK/YdBXgg5MEWPXWSKVVo/MaSe1synN1+X6cjRccJg/vDG8JEulXo6RX0OXyUdPP9lpavOgzdcVy11zq0KHcPdKgAYuDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+3sugRDKoR4VOYpKFOjSfzM+A1fwWF+70xwmen1oatU=;
 b=sTxw8Kz1R8ae7X0Lzs25/jMPV/6iiqWCZ6HoQHwv8k/QNWOWxL+oP2QHdrp2GxNmnbfej37O9gy1VB2Ct3mglCvVxpcpcP2/p3O19RDCx2RBFg62truEWoT5ZyZO5OJT/gnO/uPOYWwh8f0PDZXTJqzKGGobb6chOPxxgIopIk8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by DB9PR04MB9647.eurprd04.prod.outlook.com (2603:10a6:10:30b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.30; Thu, 2 Mar
 2023 05:34:30 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::89aa:9204:790d:e46b]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::89aa:9204:790d:e46b%5]) with mapi id 15.20.6156.019; Thu, 2 Mar 2023
 05:34:30 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, robh+dt@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        xiahong.bao@nxp.com, eagle.zhou@nxp.com, tao.jiang_2@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] media: amphion: decoder implement display delay enable
Date:   Thu,  2 Mar 2023 13:34:10 +0800
Message-Id: <20230302053410.30513-1-ming.qian@nxp.com>
X-Mailer: git-send-email 2.38.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0013.apcprd02.prod.outlook.com
 (2603:1096:4:194::21) To AM6PR04MB6341.eurprd04.prod.outlook.com
 (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB6341:EE_|DB9PR04MB9647:EE_
X-MS-Office365-Filtering-Correlation-Id: a1d3cd10-7c59-4c74-5d03-08db1adfcc0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pbr6q/maERuJpFLO/wo25RkVlBEGd1Fppy2KsdPNzsGCpT+odu59bAA//rafOVH/8Vq7MCa5NRKXkDr5oYujtfCq02Sgg7zdZi9rFsXV8LOOwRDSzKA2Q+ToCwJ8VSd7IxjGzAKnXhtMfJvvGsZNIuCxeRRNpauYvclUy2A9Ckxq/jtKBM3vp7F5QFGdWTsMpIzoxkRtS7nfbIpnnMFno8/UEHHceKhHeP1aQNVfZc9mWesCjdyh1QcEUDYJkacbQ3ZbtwOfqQdtXrKMCC+w3qx7cU4/WyGPBqEMW94VoGZrP23uwS1UQgRYc1upGkafbn1FRkLuBkEmieUhsfKmb7VytpC/qlVOHPAigrI+nOYPX5LYdFEJtGIKq7SHPt/f3x2sCO23L+OCMSYtib2PABdzCgwiGInrYosCHZoiqVRFSMRPlIVrMW2CsO2mRAe9U487AX34bkiqBbpcD+Vmw8I8Q/GzvSNY3ZXDgo9D+I6GRDiaTENSTef4lXhNo17kCrmj7QZNbvHBBsV2QEq60h9lIlszq907Pv7OxYGIBxAVN/83LhdxaP1rZhFk+7duLpJwOu8uxbnWrxrDeE6O3MUugFlWmpM8ISMip2UNlokBuOII4zhXNgNn/vmab7C68UdUT7Q57XFbiMEJsola521oBQ11HmbThpbSUURlXpx1ppGaH9ci6dLxuo5M3nlefJHW3Edf1vZ51y8i/N/b+w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(376002)(39860400002)(366004)(136003)(396003)(451199018)(86362001)(5660300002)(66556008)(41300700001)(7416002)(8936002)(8676002)(66946007)(66476007)(44832011)(2906002)(4326008)(36756003)(38350700002)(38100700002)(52116002)(6666004)(6486002)(478600001)(316002)(26005)(83380400001)(186003)(1076003)(6506007)(6512007)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7UAOt3q7oYBcMNvwzLqNA1G8iJvW+3eJgEdXr5hvl8AnEhoihla/a49barkk?=
 =?us-ascii?Q?JYiRs5gTCOBrcvKy9YRaj6jhVK2eC7dehSDgmpcEHvfSMIwEnFjhYTVh6U3O?=
 =?us-ascii?Q?0tdWS+Ctm5E0M/LREL8KKlHZvV8efF4NUXrkGcEkXr6VlF4OpWmHHy6heYTa?=
 =?us-ascii?Q?js3zpsKE4E1hQhD8z9RBQfh2pQ1XLLfE2TzTC+8eikKQI3EAN67w7oEspu6r?=
 =?us-ascii?Q?TqZZcWW1VoS4ggkuGxApZVVWfQoRdxlB+/3x1jukVAsNDuvGroJn6sMZxA/L?=
 =?us-ascii?Q?7ZTQwvglwnbTwDO+OVfTVYPm3CeGp6gphwZ1TLm+lT22v2eEv3XIZYWVgIUu?=
 =?us-ascii?Q?oRziwtibDDQ0gyHZC2iKD4aOK0hgGfool54oJKfw9KVitpjj6MoRzhwbNR5H?=
 =?us-ascii?Q?EzvMTpvTd8F4FQKxD/FDmQFXekc8GjBCtOkHxzX8cbx1aWIATZUNgfPUD5C8?=
 =?us-ascii?Q?vUqEp98fNREhHIme1L9mv43mP6wJ+F0mZ6JP9KsZYCHRVs6vUhslhsIdkkEo?=
 =?us-ascii?Q?k3QEONZIlG0IkNGDKWhMVXqPU42DPz0AMRXFWwkv20i4nd8PrevhYgXSsO6W?=
 =?us-ascii?Q?JGSPkglNpQ8/05qf84YUJJ5FwEwz9T2RXuyZftlx7ur7JuJvWeVgcxkATwC4?=
 =?us-ascii?Q?nRYJW/zbisJh6/Ok7kRD49SLnTjWi9Ly88nKEfFFHi3IAteauv6QB7Lu8Ypj?=
 =?us-ascii?Q?YG2mXOufUWyc/X4mQmgnHWOxIiFv17V6KwY5M+whrEJn9FrbFv6LYfuT8BJa?=
 =?us-ascii?Q?irbJRNOjmyl4blUu8lSt+3WCKieyPOYBvxEFAMnVkKyvfZslWG82HE6XROeo?=
 =?us-ascii?Q?/ZRo77vuJiyHaSKOQxUuPmQYMxRVsaL8a1kJaZcQb+RVM0oN5xV5m9B2d4ib?=
 =?us-ascii?Q?kUcc8DkWgNNiDJFhiIC13lFp5DxeQpou1+J8Xkr0T7Mj0q1GqKp2fK/cjekx?=
 =?us-ascii?Q?cLjM1shz8Zn9A7nG9kVCkFH8jt3S4QBUlCfqxIni01Dfz2Wae9xvmep2cW3I?=
 =?us-ascii?Q?cWxPxDI72l7l1m7lkF7Y5zzoBSH2CGoVHv9NvZaagtUK0n+hSt4WmxrHDCXF?=
 =?us-ascii?Q?ZdA7nzXrGcBXFfnVu1phP0D9lStAx7f9ywgrCdi61bVCMMelj5LSz8/cKU0B?=
 =?us-ascii?Q?zaZnctWCGk0e8KjtVCw0k5icWNEGYBMwkeVuZj6aZyexJ9ygobHyjkLlRceq?=
 =?us-ascii?Q?O2XSFziD+g02nH2fqJVuT4pQZJRshR8ftEIXyw72HdIL9rKHNoKDFDFg5k7s?=
 =?us-ascii?Q?gB8gUMJQQgzKK2qGutdznwda/TLuLg9pg7cHyCBw6YtwO7+XSiEFALXUQksr?=
 =?us-ascii?Q?IMsevDNBnKpCxVeGxZHczWIqbRW+R8SAe+dEh/YI3eWnWx4l5WY86dq/wpRn?=
 =?us-ascii?Q?GT7/nvbbxtyqnPxjG68yO4G0gI3KK/jdhuwgHnByOETok6qtk/OegEosybbr?=
 =?us-ascii?Q?u51C0QIofUlsUAV/8qZU9XWxTGVeBHCEnr5P6rbFWfkucqOhL2VXVBzutt0u?=
 =?us-ascii?Q?cFwJLfsjD/m8C/McFJZvTteOg45pU/mWPscA+7p3SXHYxQ3Y8CEHhX8X1z/I?=
 =?us-ascii?Q?H2Ua+LRtrCLe/7YBu+6BxloEgfOqMG9CVxOYKdtk?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1d3cd10-7c59-4c74-5d03-08db1adfcc0e
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2023 05:34:30.8142
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eRcZxIammDekI71j2FVu6lfQny0ahFmJrJhqJk9QQN6QoJxmjz5oa2UKmX9zLqg6LbRofUO0x9Twy2UzuanZFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9647
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

amphion vpu support a low latency mode,
when V4L2_CID_MPEG_VIDEO_DEC_DISPLAY_DELAY_ENABLE is enabled,
decoder can display frame immediately after it's decoded.
Only h264 is support yet.

Fixes: 6de8d628df6e ("media: amphion: add v4l2 m2m vpu decoder stateful driver")
Signed-off-by: Ming Qian <ming.qian@nxp.com>
---
 drivers/media/platform/amphion/vdec.c       | 32 +++++++++++++++++++++
 drivers/media/platform/amphion/vpu_codec.h  |  3 +-
 drivers/media/platform/amphion/vpu_malone.c |  4 ++-
 3 files changed, 37 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/amphion/vdec.c b/drivers/media/platform/amphion/vdec.c
index 03477998b9eb..3fa1a74a2e20 100644
--- a/drivers/media/platform/amphion/vdec.c
+++ b/drivers/media/platform/amphion/vdec.c
@@ -189,7 +189,31 @@ static const struct vpu_format vdec_formats[] = {
 	{0, 0, 0, 0},
 };
 
+static int vdec_op_s_ctrl(struct v4l2_ctrl *ctrl)
+{
+	struct vpu_inst *inst = ctrl_to_inst(ctrl);
+	struct vdec_t *vdec = inst->priv;
+	int ret = 0;
+
+	vpu_inst_lock(inst);
+	switch (ctrl->id) {
+	case V4L2_CID_MPEG_VIDEO_DEC_DISPLAY_DELAY_ENABLE:
+		vdec->params.display_delay_enable = ctrl->val;
+		break;
+	case V4L2_CID_MPEG_VIDEO_DEC_DISPLAY_DELAY:
+		vdec->params.display_delay = ctrl->val;
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+	vpu_inst_unlock(inst);
+
+	return ret;
+}
+
 static const struct v4l2_ctrl_ops vdec_ctrl_ops = {
+	.s_ctrl = vdec_op_s_ctrl,
 	.g_volatile_ctrl = vpu_helper_g_volatile_ctrl,
 };
 
@@ -202,6 +226,14 @@ static int vdec_ctrl_init(struct vpu_inst *inst)
 	if (ret)
 		return ret;
 
+	v4l2_ctrl_new_std(&inst->ctrl_handler, &vdec_ctrl_ops,
+			  V4L2_CID_MPEG_VIDEO_DEC_DISPLAY_DELAY,
+			  0, 0, 1, 0);
+
+	v4l2_ctrl_new_std(&inst->ctrl_handler, &vdec_ctrl_ops,
+			  V4L2_CID_MPEG_VIDEO_DEC_DISPLAY_DELAY_ENABLE,
+			  0, 1, 1, 0);
+
 	ctrl = v4l2_ctrl_new_std(&inst->ctrl_handler, &vdec_ctrl_ops,
 				 V4L2_CID_MIN_BUFFERS_FOR_CAPTURE, 1, 32, 1, 2);
 	if (ctrl)
diff --git a/drivers/media/platform/amphion/vpu_codec.h b/drivers/media/platform/amphion/vpu_codec.h
index 528a93f08ecd..bac6d0d94f8a 100644
--- a/drivers/media/platform/amphion/vpu_codec.h
+++ b/drivers/media/platform/amphion/vpu_codec.h
@@ -55,7 +55,8 @@ struct vpu_encode_params {
 struct vpu_decode_params {
 	u32 codec_format;
 	u32 output_format;
-	u32 b_dis_reorder;
+	u32 display_delay_enable;
+	u32 display_delay;
 	u32 b_non_frame;
 	u32 frame_count;
 	u32 end_flag;
diff --git a/drivers/media/platform/amphion/vpu_malone.c b/drivers/media/platform/amphion/vpu_malone.c
index 26039741166a..ef44bff9fbaf 100644
--- a/drivers/media/platform/amphion/vpu_malone.c
+++ b/drivers/media/platform/amphion/vpu_malone.c
@@ -661,7 +661,9 @@ static int vpu_malone_set_params(struct vpu_shared_addr *shared,
 		hc->jpg[instance].jpg_mjpeg_interlaced = 0;
 	}
 
-	hc->codec_param[instance].disp_imm = params->b_dis_reorder ? 1 : 0;
+	hc->codec_param[instance].disp_imm = params->display_delay_enable ? 1 : 0;
+	if (malone_format != MALONE_FMT_AVC)
+		hc->codec_param[instance].disp_imm = 0;
 	hc->codec_param[instance].dbglog_enable = 0;
 	iface->dbglog_desc.level = 0;
 
-- 
2.38.1

