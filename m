Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 726C9666128
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 18:00:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234415AbjAKRAQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 12:00:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238088AbjAKQ7p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 11:59:45 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BA66164AC;
        Wed, 11 Jan 2023 08:59:44 -0800 (PST)
Received: from benjamin-XPS-13-9310.. (unknown [IPv6:2a01:e0a:120:3210:1ee3:efce:e4f6:17a3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id C1CE26602DB0;
        Wed, 11 Jan 2023 16:59:42 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1673456383;
        bh=hK5ho7sqz6YdWfEyVAdpQFOjW5xXjqXVPgQmWV4hD5E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WUupMmD0USWPH8l4dwOOX27F/rCX3XPLArZxjvDlfPRP1OI7ybEfsoYIG3C7EVHPY
         DT/K2DMFq7X7rTaBGtXWSK8iuYNliiIlHpFYJAEaulYUvbvMtV1a7m0FvXHkv0BSBr
         zDXyCz15qYIKx7Jj9tBb/+wihcn2JPCDiFK9pmVJfuwB2X7fkrn8BP5QdiM/xi0vbj
         tKbu3LJU12GMxjBD1UfbQ4ivmfjP6meb1wX6citVIKeTY5CE5fQSUnLFv/aq2V6mHv
         mJxBb9/9ItympTVX0Ir8BnIzwiPo70liB61ZWyeUkyBQ7mhzpXzRoEsC18NXJsVazV
         wIbGnUXwNEtBQ==
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
To:     ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de,
        mchehab@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, heiko@sntech.de,
        daniel.almeida@collabora.com, nicolas.dufresne@collabora.co.uk
Cc:     linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>
Subject: [PATCH v3 07/13] media: verisilicon: Check AV1 bitstreams bit depth
Date:   Wed, 11 Jan 2023 17:59:25 +0100
Message-Id: <20230111165931.753763-8-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230111165931.753763-1-benjamin.gaignard@collabora.com>
References: <20230111165931.753763-1-benjamin.gaignard@collabora.com>
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

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
---
 drivers/media/platform/verisilicon/hantro_drv.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/verisilicon/hantro_drv.c b/drivers/media/platform/verisilicon/hantro_drv.c
index 8e93710dcfed..16539e89935c 100644
--- a/drivers/media/platform/verisilicon/hantro_drv.c
+++ b/drivers/media/platform/verisilicon/hantro_drv.c
@@ -282,7 +282,13 @@ static int hantro_try_ctrl(struct v4l2_ctrl *ctrl)
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
 
@@ -333,7 +339,13 @@ static int hantro_av1_s_ctrl(struct v4l2_ctrl *ctrl)
 
 	switch (ctrl->id) {
 	case V4L2_CID_STATELESS_AV1_SEQUENCE:
-		ctx->bit_depth = ctrl->p_new.p_av1_sequence->bit_depth;
+		int bit_depth = ctrl->p_new.p_av1_sequence->bit_depth;
+
+		if (vb2_is_streaming(v4l2_m2m_get_src_vq(ctx->fh.m2m_ctx)))
+			if (ctx->bit_depth != bit_depth)
+				return -EINVAL;
+
+		ctx->bit_depth = bit_depth;
 		break;
 	default:
 		return -EINVAL;
-- 
2.34.1

