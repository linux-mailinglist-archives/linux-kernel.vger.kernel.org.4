Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAC186965DD
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 15:06:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233175AbjBNOGc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 09:06:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232458AbjBNOGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 09:06:13 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD83126CE4;
        Tue, 14 Feb 2023 06:06:11 -0800 (PST)
Received: from benjamin-XPS-13-9310.. (unknown [IPv6:2a01:e0a:120:3210:37c0:9b2b:ec16:1f37])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 3460D660216E;
        Tue, 14 Feb 2023 14:06:07 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1676383567;
        bh=e7TTDcNv6HNZsFtnX0uLj6NxhVdB/6sO+gP4Rydq98M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hcycjUOmm1kHlf9Eeks85/apHhYWGfsE4zDV0zWFlQv0aPMhoUwzX7fCfqL5Md/TB
         oqPTuQxOUJCM9iO7b2XvkCMArcdSAm2G22pMCXyrc4TcE3NPdw2XCOU/oVF/MsbysR
         FEL4akvdZ0NG8mx5B8a1JR9Lj9UOF58K41mqLHrE/pZZ6/eAjuVmV7SXudzUZqFqg1
         U9GYdQfCSwIIJZ/jFUEP45FTsbwre0Y+X3catQC35SETzSmSUXPEafsBI9OSZHPbh1
         ssRnB8hlagFkAXNSP6Sd+WNIgXnQwmi+Rl6OdyePDgIiVGb8BdvjD7apa8IjWkKsvs
         kpmPhJ4G4SgEg==
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
To:     ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de,
        mchehab@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, heiko@sntech.de,
        hverkuil@xs4all.nl, nicolas.dufresne@collabora.com,
        jernej.skrabec@gmail.com
Cc:     linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>
Subject: [PATCH v4 06/12] media: verisilicon: Check AV1 bitstreams bit depth
Date:   Tue, 14 Feb 2023 15:05:51 +0100
Message-Id: <20230214140557.537984-7-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230214140557.537984-1-benjamin.gaignard@collabora.com>
References: <20230214140557.537984-1-benjamin.gaignard@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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
---
version 4:
- This patch is the result of squashing "Save bit depth for AV1 decoder"
  and "Check AV1 bitstreams bit depth" of version 3 + adapation to 
  "[PATCH v8 0/6] media: verisilicon: HEVC: fix 10bits handling" series.

 .../media/platform/verisilicon/hantro_drv.c   | 36 +++++++++++++++++++
 .../media/platform/verisilicon/hantro_v4l2.c  |  4 +++
 2 files changed, 40 insertions(+)

diff --git a/drivers/media/platform/verisilicon/hantro_drv.c b/drivers/media/platform/verisilicon/hantro_drv.c
index bc1a85456142..666cd46902da 100644
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
 
@@ -348,6 +354,30 @@ static int hantro_hevc_s_ctrl(struct v4l2_ctrl *ctrl)
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
@@ -365,6 +395,11 @@ static const struct v4l2_ctrl_ops hantro_hevc_ctrl_ops = {
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
@@ -542,6 +577,7 @@ static const struct hantro_ctrl controls[] = {
 		.codec = HANTRO_AV1_DECODER,
 		.cfg = {
 			.id = V4L2_CID_STATELESS_AV1_SEQUENCE,
+			.ops = &hantro_av1_ctrl_ops,
 		},
 	}, {
 		.codec = HANTRO_AV1_DECODER,
diff --git a/drivers/media/platform/verisilicon/hantro_v4l2.c b/drivers/media/platform/verisilicon/hantro_v4l2.c
index 992c5baa929f..7e74e47c9a89 100644
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

