Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 053FC6F5356
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 10:35:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbjECIfY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 04:35:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbjECIex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 04:34:53 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBB8E4C0E;
        Wed,  3 May 2023 01:34:50 -0700 (PDT)
Received: from benjamin-XPS-13-9310.. (unknown [IPv6:2a01:e0a:120:3210:8234:977e:ebbe:d70b])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 064C066056D6;
        Wed,  3 May 2023 09:34:49 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1683102889;
        bh=S8uSvpRfQyFULmsyzaSvviAfEQ9HpZ+C/7nq1x552mY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Rbe++TfWxWWvubJN2NsZ8ZenW2X8ixPnpYMNGLgSamctsFkthEU2topHo173XrVkD
         0IUR7XawLBSb3W/QOe4hS0PGZ04jqDs1CJqOyfWrk64AOPvVD99/2XW/NiHODaHaTH
         CGn7LmDn4LopwjyVN/7sC0GW0+El+4Iwjn/r/EGHgUk9QrFWPBZTjZb7Jfzun3ayEw
         YLWKd/6uc2p3136HjXFeQWWa0TXd1Ua+XUqeE/bW15FAYh1YYM9hCb7a8pN2Gr9Xq9
         m6tdd/muPBP9dsTfKuuywIeaH1P46f2DHSS/ONNVMMh6KnzzqF197HLKQRMmkzn7k9
         8F+NmC3q50Qhg==
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
To:     ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de,
        mchehab@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, heiko@sntech.de,
        hverkuil-cisco@xs4all.nl, nicolas.dufresne@collabora.com
Cc:     linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>
Subject: [PATCH v7 07/13] media: verisilicon: Check AV1 bitstreams bit depth
Date:   Wed,  3 May 2023 10:34:32 +0200
Message-Id: <20230503083438.85139-8-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230503083438.85139-1-benjamin.gaignard@collabora.com>
References: <20230503083438.85139-1-benjamin.gaignard@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver supports 8 and 10 bits bitstreams, make sure to discard
other cases.
It could happens that userland test if V4L2_CID_STATELESS_AV1_SEQUENCE
exists without setting bit_depth field in this case use
HANTRO_DEFAULT_BIT_DEPTH value.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
---
 .../media/platform/verisilicon/hantro_drv.c   | 36 +++++++++++++++++++
 .../media/platform/verisilicon/hantro_v4l2.c  |  4 +++
 2 files changed, 40 insertions(+)

diff --git a/drivers/media/platform/verisilicon/hantro_drv.c b/drivers/media/platform/verisilicon/hantro_drv.c
index 8f6021e3953c..be1f06c21910 100644
--- a/drivers/media/platform/verisilicon/hantro_drv.c
+++ b/drivers/media/platform/verisilicon/hantro_drv.c
@@ -275,7 +275,13 @@ static int hantro_try_ctrl(struct v4l2_ctrl *ctrl)
 		/* We only support profile 0 */
 		if (dec_params->profile != 0)
 			return -EINVAL;
+	} else if (ctrl->id == V4L2_CID_STATELESS_AV1_SEQUENCE) {
+		const struct v4l2_ctrl_av1_sequence *sequence = ctrl->p_new.p_av1_sequence;
+
+		if (sequence->bit_depth != 8 && sequence->bit_depth != 10)
+			return -EINVAL;
 	}
+
 	return 0;
 }
 
@@ -346,6 +352,30 @@ static int hantro_hevc_s_ctrl(struct v4l2_ctrl *ctrl)
 	return 0;
 }
 
+static int hantro_av1_s_ctrl(struct v4l2_ctrl *ctrl)
+{
+	struct hantro_ctx *ctx;
+
+	ctx = container_of(ctrl->handler,
+			   struct hantro_ctx, ctrl_handler);
+
+	switch (ctrl->id) {
+	case V4L2_CID_STATELESS_AV1_SEQUENCE:
+	{
+		int bit_depth = ctrl->p_new.p_av1_sequence->bit_depth;
+
+		if (ctx->bit_depth == bit_depth)
+			return 0;
+
+		return hantro_reset_raw_fmt(ctx, bit_depth);
+	}
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static const struct v4l2_ctrl_ops hantro_ctrl_ops = {
 	.try_ctrl = hantro_try_ctrl,
 };
@@ -363,6 +393,11 @@ static const struct v4l2_ctrl_ops hantro_hevc_ctrl_ops = {
 	.s_ctrl = hantro_hevc_s_ctrl,
 };
 
+static const struct v4l2_ctrl_ops hantro_av1_ctrl_ops = {
+	.try_ctrl = hantro_try_ctrl,
+	.s_ctrl = hantro_av1_s_ctrl,
+};
+
 #define HANTRO_JPEG_ACTIVE_MARKERS	(V4L2_JPEG_ACTIVE_MARKER_APP0 | \
 					 V4L2_JPEG_ACTIVE_MARKER_COM | \
 					 V4L2_JPEG_ACTIVE_MARKER_DQT | \
@@ -540,6 +575,7 @@ static const struct hantro_ctrl controls[] = {
 		.codec = HANTRO_AV1_DECODER,
 		.cfg = {
 			.id = V4L2_CID_STATELESS_AV1_SEQUENCE,
+			.ops = &hantro_av1_ctrl_ops,
 		},
 	}, {
 		.codec = HANTRO_AV1_DECODER,
diff --git a/drivers/media/platform/verisilicon/hantro_v4l2.c b/drivers/media/platform/verisilicon/hantro_v4l2.c
index d4c5035ab3e3..1ab5f9ce725b 100644
--- a/drivers/media/platform/verisilicon/hantro_v4l2.c
+++ b/drivers/media/platform/verisilicon/hantro_v4l2.c
@@ -86,6 +86,10 @@ hantro_check_depth_match(const struct hantro_fmt *fmt, int bit_depth)
 	if (!fmt->match_depth && !fmt->postprocessed)
 		return true;
 
+	/* 0 means default depth, which is 8 */
+	if (!bit_depth)
+		bit_depth = HANTRO_DEFAULT_BIT_DEPTH;
+
 	fmt_depth = hantro_get_format_depth(fmt->fourcc);
 
 	/*
-- 
2.34.1

