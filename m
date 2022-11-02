Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5D46616BBF
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 19:09:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231493AbiKBSJH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 14:09:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231288AbiKBSI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 14:08:28 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B853B4B2;
        Wed,  2 Nov 2022 11:08:27 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id d26so47412675eje.10;
        Wed, 02 Nov 2022 11:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LZXn/eratvKwy31qlLD6eywRNyLVLrqRQvFS+fmobPY=;
        b=jgFGwGoBaVDoPDl4dOt823hkJpZ+xNsjJdU8XvAt1wACNy+6p3tKUOE1KlUnR+MfZW
         nrjhY/6aCmhJc41DMTR0/sUHzzl38/EGZujd2tuQMS207TDxWNhQs376LGAKx1j/vazs
         uJHkcq5cAgdLPOqTJOsS4eBi04ORyG3iGXwb3wFiV/mmt2tvE5KmnOOu/lz+yPGcYHIg
         WHlMZsFMuX4AzD7Ao4W+8IA99AryXGit/o+FNeqRaf8IL2VYMqkszLup24KRJkxJTxcI
         swH91okm30O/ycayJm0ONBL38bBuFBfIEHoEwNzZU0obaQh/rnjOP6VLAlHl+q4w0SLp
         HJtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LZXn/eratvKwy31qlLD6eywRNyLVLrqRQvFS+fmobPY=;
        b=QoHDAFwheKV4Vf/0/t23yqA8meXzXRgQqUVK6uNlTfPIIaUmocUsi+k1eAOKVGRP7J
         ofaSJlFsYXbgyOl6vC1hAXd7C74+MBZb82KULjnrwOvTZ6Wga3cseycFXYXUXicX4CMc
         QCPnZxtgUHxIlTSNlYzfBlGEkRwo/weBL1iFawqcYeNb7XtqNmARAfmxqpIZ5h6D1vJp
         X+bpqcwfYMoTo3Ax6WN21nilPH+xT0vVfKmuMWNWVdpLTi3Z93mtdb6pKzGL7+5EZREl
         FWl0YNFpZddTAslSspwAdJI4tJYUerTCfrGbAclsxRY7yIbCZCPdAQIKFwEBdXz+jvcY
         f1tA==
X-Gm-Message-State: ACrzQf10RsDAsfwaS1ER77RHnHrGkxay4QR864/YMBPCDFxYekRJvZlg
        ODLUhStWsq/fSZV6dz5Og1I=
X-Google-Smtp-Source: AMsMyM4mp/994s29Y9cbpgyVTuqHdNKAhOfhMBHOTnNDO4ll8TKOevkgBXSAnW0Ez1XNG6S8i+3j5A==
X-Received: by 2002:a17:906:195b:b0:7ae:108:9729 with SMTP id b27-20020a170906195b00b007ae01089729mr4720802eje.604.1667412505457;
        Wed, 02 Nov 2022 11:08:25 -0700 (PDT)
Received: from kista.localdomain (82-149-19-102.dynamic.telemach.net. [82.149.19.102])
        by smtp.gmail.com with ESMTPSA id gy8-20020a170906f24800b007317f017e64sm5677460ejb.134.2022.11.02.11.08.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 11:08:25 -0700 (PDT)
From:   Jernej Skrabec <jernej.skrabec@gmail.com>
To:     mripard@kernel.org, paul.kocialkowski@bootlin.com
Cc:     mchehab@kernel.org, gregkh@linuxfoundation.org, wens@csie.org,
        samuel@sholland.org, hverkuil-cisco@xs4all.nl,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH v2 07/11] media: cedrus: Remove cedrus_codec enum
Date:   Wed,  2 Nov 2022 19:08:06 +0100
Message-Id: <20221102180810.267252-8-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221102180810.267252-1-jernej.skrabec@gmail.com>
References: <20221102180810.267252-1-jernej.skrabec@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Last user of cedrus_codec enum is cedrus_engine_enable() but this
argument is completely redundant. Same information can be obtained via
source pixel format. Let's remove this argument and enum.

No functional changes intended.

Acked-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 drivers/staging/media/sunxi/cedrus/cedrus.h       |  8 --------
 drivers/staging/media/sunxi/cedrus/cedrus_h264.c  |  2 +-
 drivers/staging/media/sunxi/cedrus/cedrus_h265.c  |  2 +-
 drivers/staging/media/sunxi/cedrus/cedrus_hw.c    | 12 ++++++------
 drivers/staging/media/sunxi/cedrus/cedrus_hw.h    |  2 +-
 drivers/staging/media/sunxi/cedrus/cedrus_mpeg2.c |  2 +-
 drivers/staging/media/sunxi/cedrus/cedrus_vp8.c   |  2 +-
 7 files changed, 11 insertions(+), 19 deletions(-)

diff --git a/drivers/staging/media/sunxi/cedrus/cedrus.h b/drivers/staging/media/sunxi/cedrus/cedrus.h
index 0b082b1fae22..5904294f3108 100644
--- a/drivers/staging/media/sunxi/cedrus/cedrus.h
+++ b/drivers/staging/media/sunxi/cedrus/cedrus.h
@@ -35,14 +35,6 @@
 #define CEDRUS_CAPABILITY_VP8_DEC	BIT(4)
 #define CEDRUS_CAPABILITY_H265_10_DEC	BIT(5)
 
-enum cedrus_codec {
-	CEDRUS_CODEC_MPEG2,
-	CEDRUS_CODEC_H264,
-	CEDRUS_CODEC_H265,
-	CEDRUS_CODEC_VP8,
-	CEDRUS_CODEC_LAST,
-};
-
 enum cedrus_irq_status {
 	CEDRUS_IRQ_NONE,
 	CEDRUS_IRQ_ERROR,
diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_h264.c b/drivers/staging/media/sunxi/cedrus/cedrus_h264.c
index c92dec21c1ac..dfb401df138a 100644
--- a/drivers/staging/media/sunxi/cedrus/cedrus_h264.c
+++ b/drivers/staging/media/sunxi/cedrus/cedrus_h264.c
@@ -518,7 +518,7 @@ static int cedrus_h264_setup(struct cedrus_ctx *ctx, struct cedrus_run *run)
 	struct cedrus_dev *dev = ctx->dev;
 	int ret;
 
-	cedrus_engine_enable(ctx, CEDRUS_CODEC_H264);
+	cedrus_engine_enable(ctx);
 
 	cedrus_write(dev, VE_H264_SDROT_CTRL, 0);
 	cedrus_write(dev, VE_H264_EXTRA_BUFFER1,
diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_h265.c b/drivers/staging/media/sunxi/cedrus/cedrus_h265.c
index 7a438cd22c34..5d3da50ce46a 100644
--- a/drivers/staging/media/sunxi/cedrus/cedrus_h265.c
+++ b/drivers/staging/media/sunxi/cedrus/cedrus_h265.c
@@ -471,7 +471,7 @@ static int cedrus_h265_setup(struct cedrus_ctx *ctx, struct cedrus_run *run)
 	}
 
 	/* Activate H265 engine. */
-	cedrus_engine_enable(ctx, CEDRUS_CODEC_H265);
+	cedrus_engine_enable(ctx);
 
 	/* Source offset and length in bits. */
 
diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_hw.c b/drivers/staging/media/sunxi/cedrus/cedrus_hw.c
index c3387cd1e80f..fa86a658fdc6 100644
--- a/drivers/staging/media/sunxi/cedrus/cedrus_hw.c
+++ b/drivers/staging/media/sunxi/cedrus/cedrus_hw.c
@@ -31,7 +31,7 @@
 #include "cedrus_hw.h"
 #include "cedrus_regs.h"
 
-int cedrus_engine_enable(struct cedrus_ctx *ctx, enum cedrus_codec codec)
+int cedrus_engine_enable(struct cedrus_ctx *ctx)
 {
 	u32 reg = 0;
 
@@ -42,18 +42,18 @@ int cedrus_engine_enable(struct cedrus_ctx *ctx, enum cedrus_codec codec)
 	reg |= VE_MODE_REC_WR_MODE_2MB;
 	reg |= VE_MODE_DDR_MODE_BW_128;
 
-	switch (codec) {
-	case CEDRUS_CODEC_MPEG2:
+	switch (ctx->src_fmt.pixelformat) {
+	case V4L2_PIX_FMT_MPEG2_SLICE:
 		reg |= VE_MODE_DEC_MPEG;
 		break;
 
 	/* H.264 and VP8 both use the same decoding mode bit. */
-	case CEDRUS_CODEC_H264:
-	case CEDRUS_CODEC_VP8:
+	case V4L2_PIX_FMT_H264_SLICE:
+	case V4L2_PIX_FMT_VP8_FRAME:
 		reg |= VE_MODE_DEC_H264;
 		break;
 
-	case CEDRUS_CODEC_H265:
+	case V4L2_PIX_FMT_HEVC_SLICE:
 		reg |= VE_MODE_DEC_H265;
 		break;
 
diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_hw.h b/drivers/staging/media/sunxi/cedrus/cedrus_hw.h
index 7c92f00e36da..6f1e701b1ea8 100644
--- a/drivers/staging/media/sunxi/cedrus/cedrus_hw.h
+++ b/drivers/staging/media/sunxi/cedrus/cedrus_hw.h
@@ -16,7 +16,7 @@
 #ifndef _CEDRUS_HW_H_
 #define _CEDRUS_HW_H_
 
-int cedrus_engine_enable(struct cedrus_ctx *ctx, enum cedrus_codec codec);
+int cedrus_engine_enable(struct cedrus_ctx *ctx);
 void cedrus_engine_disable(struct cedrus_dev *dev);
 
 void cedrus_dst_format_set(struct cedrus_dev *dev,
diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_mpeg2.c b/drivers/staging/media/sunxi/cedrus/cedrus_mpeg2.c
index c1128d2cd555..10e98f08aafc 100644
--- a/drivers/staging/media/sunxi/cedrus/cedrus_mpeg2.c
+++ b/drivers/staging/media/sunxi/cedrus/cedrus_mpeg2.c
@@ -66,7 +66,7 @@ static int cedrus_mpeg2_setup(struct cedrus_ctx *ctx, struct cedrus_run *run)
 	quantisation = run->mpeg2.quantisation;
 
 	/* Activate MPEG engine. */
-	cedrus_engine_enable(ctx, CEDRUS_CODEC_MPEG2);
+	cedrus_engine_enable(ctx);
 
 	/* Set intra quantisation matrix. */
 	matrix = quantisation->intra_quantiser_matrix;
diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_vp8.c b/drivers/staging/media/sunxi/cedrus/cedrus_vp8.c
index f7714baae37d..969677a3bbf9 100644
--- a/drivers/staging/media/sunxi/cedrus/cedrus_vp8.c
+++ b/drivers/staging/media/sunxi/cedrus/cedrus_vp8.c
@@ -662,7 +662,7 @@ static int cedrus_vp8_setup(struct cedrus_ctx *ctx, struct cedrus_run *run)
 	int header_size;
 	u32 reg;
 
-	cedrus_engine_enable(ctx, CEDRUS_CODEC_VP8);
+	cedrus_engine_enable(ctx);
 
 	cedrus_write(dev, VE_H264_CTRL, VE_H264_CTRL_VP8);
 
-- 
2.38.1

