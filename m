Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDFD86F533D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 10:35:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbjECIfC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 04:35:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbjECIeu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 04:34:50 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DC804C1F;
        Wed,  3 May 2023 01:34:48 -0700 (PDT)
Received: from benjamin-XPS-13-9310.. (unknown [IPv6:2a01:e0a:120:3210:8234:977e:ebbe:d70b])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id ABDE066032BE;
        Wed,  3 May 2023 09:34:46 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1683102887;
        bh=7bTQ885Lf7fJe0LhySXOychmfiOBST4o2pY/rZ1W8Qk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A10mlTZSkoBmsfXfHU18G7LtrzrlpOxks689r7i7jeogOC8y+SKYFcIhd7UcYGCm6
         eumixvdasq+TWz7cs9a63TsEiVcbocwOx10cZUQWPN/MQjGTlKln4ZGPSpf/E+Koxe
         cEwMQd7ME/b5fCc5e+/slGvhCoMcF6Q8/7gQqgKPw75mua/dTiV/T8Gc6bGag5r3Do
         yKNOEbAboVWHie2pHoPnGNqW0DtODZc6KulQzqvy5Z20dd/gCpthlAECPCi+8nJIFc
         YLt3iO+jOPUUzUWpjrvzbF+QIovZFz+Lv8DA4Q54oMmyMTRy1BbMPhNYBKb86rgPfd
         NhrkOjV1HsRjg==
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
To:     ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de,
        mchehab@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, heiko@sntech.de,
        hverkuil-cisco@xs4all.nl, nicolas.dufresne@collabora.com
Cc:     linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>
Subject: [PATCH v7 02/13] media: AV1: Make sure that bit depth in correctly initialize
Date:   Wed,  3 May 2023 10:34:27 +0200
Message-Id: <20230503083438.85139-3-benjamin.gaignard@collabora.com>
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

Make sure that bit_depth field of V4L2_CTRL_TYPE_AV1_SEQUENCE
is initialized correctly before using it.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
---
 drivers/media/v4l2-core/v4l2-ctrls-core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/media/v4l2-core/v4l2-ctrls-core.c b/drivers/media/v4l2-core/v4l2-ctrls-core.c
index 9fd37e94db17..a662fb60f73f 100644
--- a/drivers/media/v4l2-core/v4l2-ctrls-core.c
+++ b/drivers/media/v4l2-core/v4l2-ctrls-core.c
@@ -111,6 +111,7 @@ static void std_init_compound(const struct v4l2_ctrl *ctrl, u32 idx,
 	struct v4l2_ctrl_vp9_frame *p_vp9_frame;
 	struct v4l2_ctrl_fwht_params *p_fwht_params;
 	struct v4l2_ctrl_h264_scaling_matrix *p_h264_scaling_matrix;
+	struct v4l2_ctrl_av1_sequence *p_av1_sequence;
 	void *p = ptr.p + idx * ctrl->elem_size;
 
 	if (ctrl->p_def.p_const)
@@ -157,6 +158,10 @@ static void std_init_compound(const struct v4l2_ctrl *ctrl, u32 idx,
 		p_vp9_frame->flags |= V4L2_VP9_FRAME_FLAG_X_SUBSAMPLING |
 			V4L2_VP9_FRAME_FLAG_Y_SUBSAMPLING;
 		break;
+	case V4L2_CTRL_TYPE_AV1_SEQUENCE:
+		p_av1_sequence = p;
+		p_av1_sequence->bit_depth = 8;
+		break;
 	case V4L2_CTRL_TYPE_FWHT_PARAMS:
 		p_fwht_params = p;
 		p_fwht_params->version = V4L2_FWHT_VERSION;
-- 
2.34.1

