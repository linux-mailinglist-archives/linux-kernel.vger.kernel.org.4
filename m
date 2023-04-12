Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24E1A6DF475
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 13:57:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231572AbjDLL5O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 07:57:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231426AbjDLL5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 07:57:07 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 160F5122;
        Wed, 12 Apr 2023 04:57:06 -0700 (PDT)
Received: from benjamin-XPS-13-9310.. (unknown [IPv6:2a01:e0a:120:3210:c2e:89bd:4b8e:9e98])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 84E266603216;
        Wed, 12 Apr 2023 12:57:04 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1681300624;
        bh=7bTQ885Lf7fJe0LhySXOychmfiOBST4o2pY/rZ1W8Qk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Biu6xNX8ak8hTu1MQB+uTsePEPlYxmKvP2f54GSbyMjUgt8zxGNJ1s3sPFe9kqFts
         IZjluMjTWwiCA1+7FUO58gRDVF3ngQG0UKGbEZ+4JElO+RI2X1yuj1zmevBTvuHfxk
         rQrMNqVE1NWnlhb14k7AqXgg4eBsSZO5Fo+tz1PSxIpaUNJmpcvAypkyDn6Xk2zbtQ
         aNK/b0OQk91magqhr5v3sSTb+d0RAhfTOSEJoHsZGX4u/bBhkRBOFtR4KlYjyy28GU
         Od/7jUK5FxyG/fXqw/TceeOHPjBE6ulUzNhwq969/Er2t3S8GNQ6pBl4iKQ28OgqQO
         yiRlB+ROnCqCg==
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
To:     ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de,
        mchehab@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, heiko@sntech.de,
        hverkuil-cisco@xs4all.nl, nicolas.dufresne@collabora.com
Cc:     linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>
Subject: [PATCH v6 02/13] media: AV1: Make sure that bit depth in correctly initialize
Date:   Wed, 12 Apr 2023 13:56:41 +0200
Message-Id: <20230412115652.403949-3-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230412115652.403949-1-benjamin.gaignard@collabora.com>
References: <20230412115652.403949-1-benjamin.gaignard@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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

