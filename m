Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3153F65C4B6
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 18:07:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238483AbjACRFL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 12:05:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238386AbjACRE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 12:04:28 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A2C313F33;
        Tue,  3 Jan 2023 09:01:26 -0800 (PST)
Received: from benjamin-XPS-13-9310.. (unknown [IPv6:2a01:e0a:120:3210:abfa:cf23:1e4e:2b14])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 421B06602D07;
        Tue,  3 Jan 2023 17:01:12 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1672765272;
        bh=WKnUc4065UFAP8ex+HL2CHU0GCNHlvHhtIo5+EmiUnM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XQynU8CKI/f8LxERxqK0rO0iL1nVwQW0BxRlOc1leeWG0ZN+VXHOdPTAJ4cGrwgDQ
         Ihqf0JDVEzjik5JUmlMPHDLPJO4QE/lpEBPb/v/ekc34KwdrdVuLix7VB/jXgeQce4
         ZUhrVlYVKnn0YOf9FQQ07DDoW4aOjchgbXmA84i/yfOhNhEUJ7E3EBS7CdL5dPbf8l
         BE7X8A0q5ZmAhRqMEw48jaM0AOHXOU3MxU7yr8O8dT9vECSrzPVsRTnW+VvJ0IePau
         2iVqz6AprG4mjqzEI42IbqMj0gUusjedTdllycA2y+1Nuf17N2LBhwAxyy6pbFjjtf
         jMHIfiam1z1JA==
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
To:     ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de,
        mchehab@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, heiko@sntech.de,
        daniel.almeida@collabora.com, nicolas.dufresne@collabora.co.uk
Cc:     linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>
Subject: [PATCH v2 06/13] media: verisilicon: Save bit depth for AV1 decoder
Date:   Tue,  3 Jan 2023 18:00:51 +0100
Message-Id: <20230103170058.810597-7-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230103170058.810597-1-benjamin.gaignard@collabora.com>
References: <20230103170058.810597-1-benjamin.gaignard@collabora.com>
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

Store bit depth information from AV1 sequence control.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
---
 .../media/platform/verisilicon/hantro_drv.c   | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/media/platform/verisilicon/hantro_drv.c b/drivers/media/platform/verisilicon/hantro_drv.c
index 4500e1fc0f2c..8e93710dcfed 100644
--- a/drivers/media/platform/verisilicon/hantro_drv.c
+++ b/drivers/media/platform/verisilicon/hantro_drv.c
@@ -324,6 +324,25 @@ static int hantro_vp9_s_ctrl(struct v4l2_ctrl *ctrl)
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
+		ctx->bit_depth = ctrl->p_new.p_av1_sequence->bit_depth;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+
 static const struct v4l2_ctrl_ops hantro_ctrl_ops = {
 	.try_ctrl = hantro_try_ctrl,
 };
@@ -336,6 +355,12 @@ static const struct v4l2_ctrl_ops hantro_vp9_ctrl_ops = {
 	.s_ctrl = hantro_vp9_s_ctrl,
 };
 
+static const struct v4l2_ctrl_ops hantro_av1_ctrl_ops = {
+	.try_ctrl = hantro_try_ctrl,
+	.s_ctrl = hantro_av1_s_ctrl,
+};
+
+
 #define HANTRO_JPEG_ACTIVE_MARKERS	(V4L2_JPEG_ACTIVE_MARKER_APP0 | \
 					 V4L2_JPEG_ACTIVE_MARKER_COM | \
 					 V4L2_JPEG_ACTIVE_MARKER_DQT | \
@@ -513,6 +538,7 @@ static const struct hantro_ctrl controls[] = {
 		.codec = HANTRO_AV1_DECODER,
 		.cfg = {
 			.id = V4L2_CID_STATELESS_AV1_SEQUENCE,
+			.ops = &hantro_av1_ctrl_ops,
 		},
 	}, {
 		.codec = HANTRO_AV1_DECODER,
-- 
2.34.1

