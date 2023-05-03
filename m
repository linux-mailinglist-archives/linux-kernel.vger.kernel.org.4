Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 221526F5351
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 10:35:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbjECIfS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 04:35:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbjECIev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 04:34:51 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 723C74C1F;
        Wed,  3 May 2023 01:34:50 -0700 (PDT)
Received: from benjamin-XPS-13-9310.. (unknown [IPv6:2a01:e0a:120:3210:8234:977e:ebbe:d70b])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 8C11366056CE;
        Wed,  3 May 2023 09:34:48 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1683102888;
        bh=ncuqSM6O6qhIHvgsB71afvMuTjYUGa/008nA7UDQKR4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ItXXzXM9h6E+32sPgWfcMbotC5XCT1XWhhwW4BiBbGmWCxK9GoRGAQiZZpw5ojax5
         TGvnfiedfPizsv/noXaFX4uGzGIR49SRZY14FvJHCq8WiYqIb+xd5W93g/M6UpETi8
         5ZFTTgPuQx4nyoPvJuhbUHBQHwFwatJqN1074n09f8K4bGde1NPxMWxX2CkRY3sDz+
         DMGkBCqlgOARbfjIs3Cq16Umc0PrcnlK78Ru6jImfLSI5RuDQ9Uyfpmu0pQHTeWoyJ
         vv7Jt0ttC0EAFU/2xXn/j+03HYkNCUO+vAi5/mQPXt86cMI3gf59Y8l7XjDEGVe/QI
         +AgOb4h+niNww==
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
To:     ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de,
        mchehab@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, heiko@sntech.de,
        hverkuil-cisco@xs4all.nl, nicolas.dufresne@collabora.com
Cc:     linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>
Subject: [PATCH v7 06/13] media: verisilicon: Add AV1 decoder mode and controls
Date:   Wed,  3 May 2023 10:34:31 +0200
Message-Id: <20230503083438.85139-7-benjamin.gaignard@collabora.com>
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

Add AV1 decoder as new decoder mode to Hantro driver.
Register needed AV1 controls for the decoder.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
---
 drivers/media/platform/verisilicon/hantro.h   |  3 +++
 .../media/platform/verisilicon/hantro_drv.c   | 21 +++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/drivers/media/platform/verisilicon/hantro.h b/drivers/media/platform/verisilicon/hantro.h
index 2989ebc631cc..61480825b856 100644
--- a/drivers/media/platform/verisilicon/hantro.h
+++ b/drivers/media/platform/verisilicon/hantro.h
@@ -38,6 +38,7 @@ struct hantro_postproc_ops;
 #define HANTRO_H264_DECODER	BIT(18)
 #define HANTRO_HEVC_DECODER	BIT(19)
 #define HANTRO_VP9_DECODER	BIT(20)
+#define HANTRO_AV1_DECODER	BIT(21)
 #define HANTRO_DECODERS		0xffff0000
 
 /**
@@ -111,6 +112,7 @@ struct hantro_variant {
  * @HANTRO_MODE_VP8_DEC: VP8 decoder.
  * @HANTRO_MODE_HEVC_DEC: HEVC decoder.
  * @HANTRO_MODE_VP9_DEC: VP9 decoder.
+ * @HANTRO_MODE_AV1_DEC: AV1 decoder
  */
 enum hantro_codec_mode {
 	HANTRO_MODE_NONE = -1,
@@ -120,6 +122,7 @@ enum hantro_codec_mode {
 	HANTRO_MODE_VP8_DEC,
 	HANTRO_MODE_HEVC_DEC,
 	HANTRO_MODE_VP9_DEC,
+	HANTRO_MODE_AV1_DEC,
 };
 
 /*
diff --git a/drivers/media/platform/verisilicon/hantro_drv.c b/drivers/media/platform/verisilicon/hantro_drv.c
index 09c74a573ddb..8f6021e3953c 100644
--- a/drivers/media/platform/verisilicon/hantro_drv.c
+++ b/drivers/media/platform/verisilicon/hantro_drv.c
@@ -525,6 +525,27 @@ static const struct hantro_ctrl controls[] = {
 		.cfg = {
 			.id = V4L2_CID_STATELESS_VP9_COMPRESSED_HDR,
 		},
+	}, {
+		.codec = HANTRO_AV1_DECODER,
+		.cfg = {
+			.id = V4L2_CID_STATELESS_AV1_FRAME,
+		},
+	}, {
+		.codec = HANTRO_AV1_DECODER,
+		.cfg = {
+			.id = V4L2_CID_STATELESS_AV1_TILE_GROUP_ENTRY,
+			.dims = { V4L2_AV1_MAX_TILE_COUNT },
+		},
+	}, {
+		.codec = HANTRO_AV1_DECODER,
+		.cfg = {
+			.id = V4L2_CID_STATELESS_AV1_SEQUENCE,
+		},
+	}, {
+		.codec = HANTRO_AV1_DECODER,
+		.cfg = {
+			.id = V4L2_CID_STATELESS_AV1_FILM_GRAIN,
+		},
 	},
 };
 
-- 
2.34.1

