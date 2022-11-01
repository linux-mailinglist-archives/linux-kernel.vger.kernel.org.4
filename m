Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ACA5614ABF
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 13:32:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbiKAMcg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 08:32:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbiKAMc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 08:32:26 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17ADC17E10;
        Tue,  1 Nov 2022 05:32:23 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id y16so19869493wrt.12;
        Tue, 01 Nov 2022 05:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=anWv+GoTCGvGN50JHpqsa/f4lMH+MNgyO2CdcIXyP1E=;
        b=S/JbnaiBzdNgYGoOK4H5OwOodUcZE4srII5e1SedrMX3mEdBRT4J0l0U0fybar9/R1
         q1LWwP7wQRWlq9Dp8iirLqBwhZ0IYU6j/qwtTeIIYv2Yb18v4de7y8TkOrRnFn59RV1Z
         xc/DKr7Q3Sbxew5pAIeLmpkepXc/fX9B+AgLuXkLSaTxLC3bGr1GceRZEuW1p9j2mSaO
         mwfMWcCwlAn9nSRqDwTpvOacAthKb4dWb4nEf7VZBllVbhlLzWfu7Spa72QRlxaODyP7
         C3CPudM24dVJKs/pTV/Ije6C4rKLArFe4mwDw7YZMtjgUbOc3GvtO5jcsQZDuh5s5Sp9
         vnUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=anWv+GoTCGvGN50JHpqsa/f4lMH+MNgyO2CdcIXyP1E=;
        b=CCL2XS1K2KsKkZLVltpR3XYLtyBjzmAjAXadfK6n9ud3sU7/HFefcTExy/y/gsBUT9
         8tW1gVDfK+AqOJ1rchyXctS/az4jYeR0YJDHwOiBhHBiOb4c7bobA6IjdRhieUlFWdTN
         NlpnpWkBFd1e/Bak+2kbisddBkoznIa9ggF7eSLaOYzXPKXs5P+h8LJxPbgpLDdKuGai
         7wSz3pwrFHKT7Bi51VaQdiIZMdtZ2sIfY4XNTIxh2YXvy5aUaqBCGQVD+J6wE9PCb+AI
         HiqHIEofBofXT9PgT/bYjYeWOPNNJmTARKkWh5O55ASB0YbF+EyzuN0w++zV9dW1glfo
         ktjQ==
X-Gm-Message-State: ACrzQf0jbOMp4AhcKtdTsAeiWiM+DjqpFvYTUJqBSOv36eJsAIRqBc9V
        XAy4gJJOvEROpNSxnwcUYOY=
X-Google-Smtp-Source: AMsMyM4CL8OilBjLm2l1WpIwdxb6LV40yrM/I6/4t769iQ8MhcAc4xG8aZfM9ctptnUNTl6mtSvGAw==
X-Received: by 2002:a5d:61c9:0:b0:236:781a:8d7e with SMTP id q9-20020a5d61c9000000b00236781a8d7emr11537372wrv.576.1667305941434;
        Tue, 01 Nov 2022 05:32:21 -0700 (PDT)
Received: from kista.localdomain (82-149-19-102.dynamic.telemach.net. [82.149.19.102])
        by smtp.gmail.com with ESMTPSA id f18-20020a1cc912000000b003cf5ec79bf9sm10404176wmb.40.2022.11.01.05.32.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 05:32:21 -0700 (PDT)
From:   Jernej Skrabec <jernej.skrabec@gmail.com>
To:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        wens@csie.org, samuel@sholland.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH 2/3] media: sunxi: Add H6 deinterlace driver
Date:   Tue,  1 Nov 2022 13:32:00 +0100
Message-Id: <20221101123201.3021129-3-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221101123201.3021129-1-jernej.skrabec@gmail.com>
References: <20221101123201.3021129-1-jernej.skrabec@gmail.com>
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

This driver covers H6 deinterlace core, which is marked in vendor driver
as v2.3. Contrary to older cores, covered by sun8i-di, it doesn't
support scaling, but it supports iommu and has additional motion
compensated deinterlacing algorithm.

Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 MAINTAINERS                                   |    4 +-
 drivers/media/platform/sunxi/Kconfig          |    1 +
 drivers/media/platform/sunxi/Makefile         |    1 +
 .../media/platform/sunxi/sun50i-di/Kconfig    |   15 +
 .../media/platform/sunxi/sun50i-di/Makefile   |    2 +
 .../platform/sunxi/sun50i-di/sun50i-di.c      | 1142 +++++++++++++++++
 .../platform/sunxi/sun50i-di/sun50i-di.h      |  175 +++
 7 files changed, 1339 insertions(+), 1 deletion(-)
 create mode 100644 drivers/media/platform/sunxi/sun50i-di/Kconfig
 create mode 100644 drivers/media/platform/sunxi/sun50i-di/Makefile
 create mode 100644 drivers/media/platform/sunxi/sun50i-di/sun50i-di.c
 create mode 100644 drivers/media/platform/sunxi/sun50i-di/sun50i-di.h

diff --git a/MAINTAINERS b/MAINTAINERS
index cf0f18502372..df35acab10fc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5781,12 +5781,14 @@ M:	"Maciej W. Rozycki" <macro@orcam.me.uk>
 S:	Maintained
 F:	drivers/net/fddi/defza.*
 
-DEINTERLACE DRIVERS FOR ALLWINNER H3
+DEINTERLACE DRIVERS FOR ALLWINNER SOCS
 M:	Jernej Skrabec <jernej.skrabec@gmail.com>
 L:	linux-media@vger.kernel.org
 S:	Maintained
 T:	git git://linuxtv.org/media_tree.git
+F:	Documentation/devicetree/bindings/media/allwinner,sun50i-h6-deinterlace.yaml
 F:	Documentation/devicetree/bindings/media/allwinner,sun8i-h3-deinterlace.yaml
+F:	drivers/media/platform/sunxi/sun50i-di/
 F:	drivers/media/platform/sunxi/sun8i-di/
 
 DELL LAPTOP DRIVER
diff --git a/drivers/media/platform/sunxi/Kconfig b/drivers/media/platform/sunxi/Kconfig
index 2dd15083a1d9..413a79d23625 100644
--- a/drivers/media/platform/sunxi/Kconfig
+++ b/drivers/media/platform/sunxi/Kconfig
@@ -7,4 +7,5 @@ source "drivers/media/platform/sunxi/sun6i-csi/Kconfig"
 source "drivers/media/platform/sunxi/sun6i-mipi-csi2/Kconfig"
 source "drivers/media/platform/sunxi/sun8i-a83t-mipi-csi2/Kconfig"
 source "drivers/media/platform/sunxi/sun8i-di/Kconfig"
+source "drivers/media/platform/sunxi/sun50i-di/Kconfig"
 source "drivers/media/platform/sunxi/sun8i-rotate/Kconfig"
diff --git a/drivers/media/platform/sunxi/Makefile b/drivers/media/platform/sunxi/Makefile
index 9aa01cb01883..f92927f49f93 100644
--- a/drivers/media/platform/sunxi/Makefile
+++ b/drivers/media/platform/sunxi/Makefile
@@ -5,4 +5,5 @@ obj-y		+= sun6i-csi/
 obj-y		+= sun6i-mipi-csi2/
 obj-y		+= sun8i-a83t-mipi-csi2/
 obj-y		+= sun8i-di/
+obj-y		+= sun50i-di/
 obj-y		+= sun8i-rotate/
diff --git a/drivers/media/platform/sunxi/sun50i-di/Kconfig b/drivers/media/platform/sunxi/sun50i-di/Kconfig
new file mode 100644
index 000000000000..cc92f5086862
--- /dev/null
+++ b/drivers/media/platform/sunxi/sun50i-di/Kconfig
@@ -0,0 +1,15 @@
+# SPDX-License-Identifier: GPL-2.0-only
+config VIDEO_SUN50I_DEINTERLACE
+	tristate "Allwinner Deinterlace v2 driver"
+	depends on V4L_MEM2MEM_DRIVERS
+	depends on VIDEO_DEV
+	depends on ARCH_SUNXI || COMPILE_TEST
+	depends on COMMON_CLK && OF
+	depends on PM
+	select VIDEOBUF2_DMA_CONTIG
+	select V4L2_MEM2MEM_DEV
+	help
+	  Support for the Allwinner deinterlace v2 unit found on
+	  some SoCs, like H6.
+	  To compile this driver as a module choose m here. The
+	  module will be called sun50i-di.
diff --git a/drivers/media/platform/sunxi/sun50i-di/Makefile b/drivers/media/platform/sunxi/sun50i-di/Makefile
new file mode 100644
index 000000000000..225b3b808069
--- /dev/null
+++ b/drivers/media/platform/sunxi/sun50i-di/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_VIDEO_SUN50I_DEINTERLACE) += sun50i-di.o
diff --git a/drivers/media/platform/sunxi/sun50i-di/sun50i-di.c b/drivers/media/platform/sunxi/sun50i-di/sun50i-di.c
new file mode 100644
index 000000000000..3ee8786cecc0
--- /dev/null
+++ b/drivers/media/platform/sunxi/sun50i-di/sun50i-di.c
@@ -0,0 +1,1142 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Allwinner sun50i deinterlacer driver
+ *
+ * Copyright (C) 2022 Jernej Skrabec <jernej.skrabec@gmail.com>
+ */
+
+#include <linux/delay.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/pm_runtime.h>
+
+#include <media/v4l2-ioctl.h>
+#include <media/videobuf2-dma-contig.h>
+
+#include "sun50i-di.h"
+
+#define FLAG_PITCH (DEINTERLACE_MAX_WIDTH / 4)
+#define FLAG_SIZE (FLAG_PITCH * DEINTERLACE_MAX_HEIGHT)
+
+static const u32 deinterlace_formats[] = {
+	V4L2_PIX_FMT_NV12,
+	V4L2_PIX_FMT_NV21,
+	V4L2_PIX_FMT_YUV420,
+	V4L2_PIX_FMT_NV16,
+	V4L2_PIX_FMT_NV61,
+	V4L2_PIX_FMT_YUV422P
+};
+
+static u32 deinterlace_read(struct deinterlace_dev *dev, u32 reg)
+{
+	return readl(dev->base + reg);
+}
+
+static void deinterlace_write(struct deinterlace_dev *dev,
+			      u32 reg, u32 value)
+{
+	writel(value, dev->base + reg);
+}
+
+static void deinterlace_device_run(void *priv)
+{
+	dma_addr_t buf, prev, curr, next, addr[4][3];
+	struct deinterlace_ctx *ctx = priv;
+	struct deinterlace_dev *dev = ctx->dev;
+	struct vb2_v4l2_buffer *src, *dst;
+	u32 reg, pitch[3], offset[2];
+	unsigned int val;
+	bool motion;
+
+	src = v4l2_m2m_next_src_buf(ctx->fh.m2m_ctx);
+	dst = v4l2_m2m_next_dst_buf(ctx->fh.m2m_ctx);
+
+	v4l2_m2m_buf_copy_metadata(src, dst, true);
+
+	reg = DEINTERLACE_SIZE_WIDTH(ctx->src_fmt.width);
+	reg |= DEINTERLACE_SIZE_HEIGHT(ctx->src_fmt.height);
+	deinterlace_write(dev, DEINTERLACE_SIZE, reg);
+
+	switch (ctx->src_fmt.pixelformat) {
+	case V4L2_PIX_FMT_NV12:
+	case V4L2_PIX_FMT_NV21:
+		reg = DEINTERLACE_FORMAT_YUV420SP;
+		break;
+	case V4L2_PIX_FMT_YUV420:
+		reg = DEINTERLACE_FORMAT_YUV420P;
+		break;
+	case V4L2_PIX_FMT_NV16:
+	case V4L2_PIX_FMT_NV61:
+		reg = DEINTERLACE_FORMAT_YUV422SP;
+		break;
+	case V4L2_PIX_FMT_YUV422P:
+		reg = DEINTERLACE_FORMAT_YUV422P;
+		break;
+	}
+	deinterlace_write(dev, DEINTERLACE_FORMAT, reg);
+
+	pitch[0] = ctx->src_fmt.bytesperline;
+	switch (ctx->src_fmt.pixelformat) {
+	case V4L2_PIX_FMT_YUV420:
+	case V4L2_PIX_FMT_YUV422P:
+		pitch[1] = pitch[0] / 2;
+		pitch[2] = pitch[1];
+		break;
+	case V4L2_PIX_FMT_NV12:
+	case V4L2_PIX_FMT_NV21:
+	case V4L2_PIX_FMT_NV16:
+	case V4L2_PIX_FMT_NV61:
+		pitch[1] = pitch[0];
+		pitch[2] = 0;
+		break;
+	}
+
+	/*
+	 * Deinterlacer assumes that each input has a single field. In
+	 * reality, each input has two interlaced fields. By doubling
+	 * pitches we satisfy deinterlacer's assumption. That way
+	 * every second line will be skipped and it will appear to
+	 * the deinterlacer as a single field.
+	 */
+	deinterlace_write(dev, DEINTERLACE_IN_PITCH0, pitch[0] * 2);
+	deinterlace_write(dev, DEINTERLACE_IN_PITCH1, pitch[1] * 2);
+	deinterlace_write(dev, DEINTERLACE_IN_PITCH2, pitch[2] * 2);
+
+	deinterlace_write(dev, DEINTERLACE_OUT_PITCH0, pitch[0]);
+	deinterlace_write(dev, DEINTERLACE_OUT_PITCH1, pitch[1]);
+	deinterlace_write(dev, DEINTERLACE_OUT_PITCH2, pitch[2]);
+
+	deinterlace_write(dev, DEINTERLACE_FLAG_PITCH, FLAG_PITCH);
+
+	offset[0] = pitch[0] * ctx->src_fmt.height;
+	switch (ctx->src_fmt.pixelformat) {
+	case V4L2_PIX_FMT_YUV420:
+		offset[1] = offset[0] + offset[0] / 4;
+		break;
+	case V4L2_PIX_FMT_YUV422P:
+		offset[1] = offset[0] + offset[0] / 2;
+		break;
+	default:
+		offset[1] = 0;
+		break;
+	}
+
+	/*
+	 * Make sure that all inputs are valid. If history is not
+	 * long enough, reuse last buffer as many times as needed.
+	 */
+	buf = vb2_dma_contig_plane_dma_addr(&src->vb2_buf, 0);
+	next = buf;
+	if (ctx->prev[0])
+		buf = vb2_dma_contig_plane_dma_addr(&ctx->prev[0]->vb2_buf, 0);
+	curr = buf;
+	if (ctx->prev[1])
+		buf = vb2_dma_contig_plane_dma_addr(&ctx->prev[1]->vb2_buf, 0);
+	prev = buf;
+
+	if (ctx->first_field == 0) {
+		if (ctx->field == 0) {
+			addr[0][0] = prev;
+			addr[0][1] = prev;
+			addr[0][2] = prev;
+			addr[1][0] = prev + pitch[0];
+			addr[1][1] = prev + pitch[1];
+			addr[1][2] = prev + pitch[2];
+			addr[2][0] = curr;
+			addr[2][1] = curr;
+			addr[2][2] = curr;
+			addr[3][0] = curr + pitch[0];
+			addr[3][1] = curr + pitch[1];
+			addr[3][2] = curr + pitch[2];
+		} else {
+			addr[0][0] = prev + pitch[0];
+			addr[0][1] = prev + pitch[1];
+			addr[0][2] = prev + pitch[2];
+			addr[1][0] = curr;
+			addr[1][1] = curr;
+			addr[1][2] = curr;
+			addr[2][0] = curr + pitch[0];
+			addr[2][1] = curr + pitch[1];
+			addr[2][2] = curr + pitch[2];
+			addr[3][0] = next;
+			addr[3][1] = next;
+			addr[3][2] = next;
+		}
+	} else {
+		if (ctx->field == 0) {
+			addr[0][0] = prev;
+			addr[0][1] = prev;
+			addr[0][2] = prev;
+			addr[1][0] = curr + pitch[0];
+			addr[1][1] = curr + pitch[1];
+			addr[1][2] = curr + pitch[2];
+			addr[2][0] = curr;
+			addr[2][1] = curr;
+			addr[2][2] = curr;
+			addr[3][0] = next + pitch[0];
+			addr[3][1] = next + pitch[1];
+			addr[3][2] = next + pitch[2];
+		} else {
+			addr[0][0] = prev + pitch[0];
+			addr[0][1] = prev + pitch[1];
+			addr[0][2] = prev + pitch[2];
+			addr[1][0] = prev;
+			addr[1][1] = prev;
+			addr[1][2] = prev;
+			addr[2][0] = curr + pitch[0];
+			addr[2][1] = curr + pitch[1];
+			addr[2][2] = curr + pitch[2];
+			addr[3][0] = curr;
+			addr[3][1] = curr;
+			addr[3][2] = curr;
+		}
+	}
+
+	deinterlace_write(dev, DEINTERLACE_IN0_ADDR0, addr[0][0]);
+	deinterlace_write(dev, DEINTERLACE_IN0_ADDR1, addr[0][1] + offset[0]);
+	deinterlace_write(dev, DEINTERLACE_IN0_ADDR2, addr[0][2] + offset[1]);
+
+	deinterlace_write(dev, DEINTERLACE_IN1_ADDR0, addr[1][0]);
+	deinterlace_write(dev, DEINTERLACE_IN1_ADDR1, addr[1][1] + offset[0]);
+	deinterlace_write(dev, DEINTERLACE_IN1_ADDR2, addr[1][2] + offset[1]);
+
+	deinterlace_write(dev, DEINTERLACE_IN2_ADDR0, addr[2][0]);
+	deinterlace_write(dev, DEINTERLACE_IN2_ADDR1, addr[2][1] + offset[0]);
+	deinterlace_write(dev, DEINTERLACE_IN2_ADDR2, addr[2][2] + offset[1]);
+
+	deinterlace_write(dev, DEINTERLACE_IN3_ADDR0, addr[3][0]);
+	deinterlace_write(dev, DEINTERLACE_IN3_ADDR1, addr[3][1] + offset[0]);
+	deinterlace_write(dev, DEINTERLACE_IN3_ADDR2, addr[3][2] + offset[1]);
+
+	buf = vb2_dma_contig_plane_dma_addr(&dst->vb2_buf, 0);
+	deinterlace_write(dev, DEINTERLACE_OUT_ADDR0, buf);
+	deinterlace_write(dev, DEINTERLACE_OUT_ADDR1, buf + offset[0]);
+	deinterlace_write(dev, DEINTERLACE_OUT_ADDR2, buf + offset[1]);
+
+	if (ctx->field) {
+		deinterlace_write(dev, DEINTERLACE_IN_FLAG_ADDR,
+				  ctx->flag1_buf_dma);
+		deinterlace_write(dev, DEINTERLACE_OUT_FLAG_ADDR,
+				  ctx->flag2_buf_dma);
+	} else {
+		deinterlace_write(dev, DEINTERLACE_IN_FLAG_ADDR,
+				  ctx->flag2_buf_dma);
+		deinterlace_write(dev, DEINTERLACE_OUT_FLAG_ADDR,
+				  ctx->flag1_buf_dma);
+	}
+
+	if (ctx->first_field == 0)
+		val = 4;
+	else
+		val = 5;
+
+	reg = DEINTERLACE_INTP_PARAM0_ANGLE_LIMIT(20);
+	reg |= DEINTERLACE_INTP_PARAM0_ANGLE_CONST_TH(5);
+	reg |= DEINTERLACE_INTP_PARAM0_LUMA_CUR_FAC_MODE(val);
+	reg |= DEINTERLACE_INTP_PARAM0_CHROMA_CUR_FAC_MODE(val);
+	deinterlace_write(dev, DEINTERLACE_INTP_PARAM0, reg);
+
+	reg = DEINTERLACE_POLAR_FIELD(ctx->field);
+	deinterlace_write(dev, DEINTERLACE_POLAR, reg);
+
+	motion = ctx->prev[0] && ctx->prev[1];
+	reg = DEINTERLACE_MODE_DEINT_LUMA;
+	reg |= DEINTERLACE_MODE_DEINT_CHROMA;
+	reg |= DEINTERLACE_MODE_INTP_EN;
+	reg |= DEINTERLACE_MODE_AUTO_UPD_MODE(ctx->first_field);
+	if (motion)
+		reg |= DEINTERLACE_MODE_MOTION_EN;
+	else
+		reg |= DEINTERLACE_MODE_FIELD_MODE;
+	deinterlace_write(dev, DEINTERLACE_MODE, reg);
+
+	/* Start the watchdog timer. */
+	schedule_delayed_work(&dev->watchdog_work, msecs_to_jiffies(1000));
+
+	deinterlace_write(dev, DEINTERLACE_INT_CTRL, DEINTERLACE_INT_EN);
+
+	reg = DEINTERLACE_CTRL_START;
+	if (device_iommu_mapped(dev->dev))
+		reg |= DEINTERLACE_CTRL_IOMMU_EN;
+	deinterlace_write(dev, DEINTERLACE_CTRL, reg);
+}
+
+static void deinterlace_end_job(struct deinterlace_dev *dev,
+				enum vb2_buffer_state state)
+{
+	struct deinterlace_ctx *ctx;
+	struct vb2_v4l2_buffer *dst;
+
+	deinterlace_write(dev, DEINTERLACE_INT_CTRL, 0);
+	deinterlace_write(dev, DEINTERLACE_STATUS, DEINTERLACE_STATUS_FINISHED);
+
+	/* vendor driver always resets the core, so do that here too */
+	deinterlace_write(dev, DEINTERLACE_CTRL, DEINTERLACE_CTRL_RESET);
+	udelay(1);
+	deinterlace_write(dev, DEINTERLACE_CTRL, 0);
+
+	ctx = v4l2_m2m_get_curr_priv(dev->m2m_dev);
+	if (!ctx) {
+		v4l2_err(&dev->v4l2_dev,
+			 "Instance released before the end of transaction\n");
+		return;
+	}
+
+	if (state == VB2_BUF_STATE_ERROR) {
+		memset(ctx->flag1_buf, 0, FLAG_SIZE);
+		memset(ctx->flag2_buf, 0, FLAG_SIZE);
+	}
+
+	dst = v4l2_m2m_dst_buf_remove(ctx->fh.m2m_ctx);
+	v4l2_m2m_buf_done(dst, state);
+
+	if (ctx->field != ctx->first_field || ctx->aborting) {
+		ctx->field = ctx->first_field;
+
+		if (ctx->prev[1])
+			v4l2_m2m_buf_done(ctx->prev[1], VB2_BUF_STATE_DONE);
+		ctx->prev[1] = ctx->prev[0];
+		ctx->prev[0] = v4l2_m2m_src_buf_remove(ctx->fh.m2m_ctx);
+
+		v4l2_m2m_job_finish(dev->m2m_dev, ctx->fh.m2m_ctx);
+	} else {
+		ctx->field = !ctx->first_field;
+		deinterlace_device_run(ctx);
+	}
+}
+
+static irqreturn_t deinterlace_irq(int irq, void *data)
+{
+	struct deinterlace_dev *dev = data;
+	unsigned int status;
+
+	status = deinterlace_read(dev, DEINTERLACE_STATUS);
+	if (!(status & DEINTERLACE_STATUS_FINISHED))
+		return IRQ_NONE;
+
+	/*
+	 * If cancel_delayed_work returns false it means watchdog already
+	 * executed and finished the job.
+	 */
+	if (!cancel_delayed_work(&dev->watchdog_work))
+		return IRQ_HANDLED;
+
+	deinterlace_end_job(dev, VB2_BUF_STATE_DONE);
+
+	return IRQ_HANDLED;
+}
+
+static void deinterlace_watchdog(struct work_struct *work)
+{
+	struct deinterlace_dev *dev;
+
+	dev = container_of(to_delayed_work(work),
+			   struct deinterlace_dev, watchdog_work);
+
+	deinterlace_end_job(dev, VB2_BUF_STATE_ERROR);
+}
+
+static void deinterlace_init(struct deinterlace_dev *dev)
+{
+	u32 reg;
+
+	deinterlace_write(dev, DEINTERLACE_OUT_PATH, 0);
+
+	reg = DEINTERLACE_MD_PARAM0_MIN_LUMA_TH(4);
+	reg |= DEINTERLACE_MD_PARAM0_MAX_LUMA_TH(12);
+	reg |= DEINTERLACE_MD_PARAM0_AVG_LUMA_SHIFT(6);
+	reg |= DEINTERLACE_MD_PARAM0_TH_SHIFT(1);
+	deinterlace_write(dev, DEINTERLACE_MD_PARAM0, reg);
+
+	reg = DEINTERLACE_MD_PARAM1_MOV_FAC_NONEDGE(2);
+	deinterlace_write(dev, DEINTERLACE_MD_PARAM1, reg);
+
+	reg = DEINTERLACE_MD_PARAM2_CHROMA_SPATIAL_TH(128);
+	reg |= DEINTERLACE_MD_PARAM2_CHROMA_DIFF_TH(5);
+	reg |= DEINTERLACE_MD_PARAM2_PIX_STATIC_TH(3);
+	deinterlace_write(dev, DEINTERLACE_MD_PARAM2, reg);
+
+	reg = DEINTERLACE_MD_CH_PARAM_BLEND_MODE(1);
+	reg |= DEINTERLACE_MD_CH_PARAM_FONT_PRO_EN;
+	reg |= DEINTERLACE_MD_CH_PARAM_FONT_PRO_TH(48);
+	reg |= DEINTERLACE_MD_CH_PARAM_FONT_PRO_FAC(4);
+	deinterlace_write(dev, DEINTERLACE_MD_CH_PARAM, reg);
+
+	reg = DEINTERLACE_INTP_PARAM1_A(4);
+	reg |= DEINTERLACE_INTP_PARAM1_EN;
+	reg |= DEINTERLACE_INTP_PARAM1_C(10);
+	reg |= DEINTERLACE_INTP_PARAM1_CMAX(64);
+	reg |= DEINTERLACE_INTP_PARAM1_MAXRAT(2);
+	deinterlace_write(dev, DEINTERLACE_INTP_PARAM1, reg);
+
+	/* only 32-bit addresses are supported, so high bits are always 0 */
+	deinterlace_write(dev, DEINTERLACE_IN0_ADDRH, 0);
+	deinterlace_write(dev, DEINTERLACE_IN1_ADDRH, 0);
+	deinterlace_write(dev, DEINTERLACE_IN2_ADDRH, 0);
+	deinterlace_write(dev, DEINTERLACE_IN3_ADDRH, 0);
+	deinterlace_write(dev, DEINTERLACE_OUT_ADDRH, 0);
+	deinterlace_write(dev, DEINTERLACE_FLAG_ADDRH, 0);
+}
+
+static int deinterlace_job_ready(void *priv)
+{
+	struct deinterlace_ctx *ctx = priv;
+
+	return v4l2_m2m_num_src_bufs_ready(ctx->fh.m2m_ctx) >= 1 &&
+	       v4l2_m2m_num_dst_bufs_ready(ctx->fh.m2m_ctx) >= 2;
+}
+
+static void deinterlace_job_abort(void *priv)
+{
+	struct deinterlace_ctx *ctx = priv;
+
+	/* Will cancel the transaction in the next interrupt handler */
+	ctx->aborting = 1;
+}
+
+static inline struct deinterlace_ctx *deinterlace_file2ctx(struct file *file)
+{
+	return container_of(file->private_data, struct deinterlace_ctx, fh);
+}
+
+static bool deinterlace_check_format(u32 pixelformat)
+{
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(deinterlace_formats); i++)
+		if (deinterlace_formats[i] == pixelformat)
+			return true;
+
+	return false;
+}
+
+static void deinterlace_prepare_format(struct v4l2_pix_format *pix_fmt)
+{
+	unsigned int bytesperline = pix_fmt->bytesperline;
+	unsigned int height = pix_fmt->height;
+	unsigned int width = pix_fmt->width;
+	unsigned int sizeimage;
+
+	width = clamp(width, DEINTERLACE_MIN_WIDTH,
+		      DEINTERLACE_MAX_WIDTH);
+	height = clamp(height, DEINTERLACE_MIN_HEIGHT,
+		       DEINTERLACE_MAX_HEIGHT);
+
+	/* try to respect userspace wishes about pitch */
+	bytesperline = ALIGN(bytesperline, 2);
+	if (bytesperline < ALIGN(width, 2))
+		bytesperline = ALIGN(width, 2);
+
+	/* luma */
+	sizeimage = bytesperline * height;
+
+	/* chroma */
+	switch (pix_fmt->pixelformat) {
+	case V4L2_PIX_FMT_NV12:
+	case V4L2_PIX_FMT_NV21:
+	case V4L2_PIX_FMT_YUV420:
+		sizeimage += bytesperline * height / 2;
+		break;
+	case V4L2_PIX_FMT_NV16:
+	case V4L2_PIX_FMT_NV61:
+	case V4L2_PIX_FMT_YUV422P:
+		sizeimage += bytesperline * height;
+		break;
+	}
+
+	if (pix_fmt->sizeimage < sizeimage)
+		pix_fmt->sizeimage = sizeimage;
+
+	pix_fmt->width = width;
+	pix_fmt->height = height;
+	pix_fmt->bytesperline = bytesperline;
+}
+
+static int deinterlace_querycap(struct file *file, void *priv,
+				struct v4l2_capability *cap)
+{
+	strscpy(cap->driver, DEINTERLACE_NAME, sizeof(cap->driver));
+	strscpy(cap->card, DEINTERLACE_NAME, sizeof(cap->card));
+	snprintf(cap->bus_info, sizeof(cap->bus_info),
+		 "platform:%s", DEINTERLACE_NAME);
+
+	return 0;
+}
+
+static int deinterlace_enum_fmt(struct file *file, void *priv,
+				struct v4l2_fmtdesc *f)
+{
+	if (f->index < ARRAY_SIZE(deinterlace_formats)) {
+		f->pixelformat = deinterlace_formats[f->index];
+
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
+static int deinterlace_enum_framesizes(struct file *file, void *priv,
+				       struct v4l2_frmsizeenum *fsize)
+{
+	if (fsize->index != 0)
+		return -EINVAL;
+
+	if (!deinterlace_check_format(fsize->pixel_format))
+		return -EINVAL;
+
+	fsize->type = V4L2_FRMSIZE_TYPE_STEPWISE;
+	fsize->stepwise.min_width = DEINTERLACE_MIN_WIDTH;
+	fsize->stepwise.min_height = DEINTERLACE_MIN_HEIGHT;
+	fsize->stepwise.max_width = DEINTERLACE_MAX_WIDTH;
+	fsize->stepwise.max_height = DEINTERLACE_MAX_HEIGHT;
+	fsize->stepwise.step_width = 2;
+
+	switch (fsize->pixel_format) {
+	case V4L2_PIX_FMT_NV12:
+	case V4L2_PIX_FMT_NV21:
+	case V4L2_PIX_FMT_YUV420:
+		fsize->stepwise.step_height = 2;
+		break;
+	case V4L2_PIX_FMT_NV16:
+	case V4L2_PIX_FMT_NV61:
+	case V4L2_PIX_FMT_YUV422P:
+		fsize->stepwise.step_height = 1;
+		break;
+	}
+
+	return 0;
+}
+
+static int deinterlace_g_fmt_vid_cap(struct file *file, void *priv,
+				     struct v4l2_format *f)
+{
+	struct deinterlace_ctx *ctx = deinterlace_file2ctx(file);
+
+	f->fmt.pix = ctx->dst_fmt;
+
+	return 0;
+}
+
+static int deinterlace_g_fmt_vid_out(struct file *file, void *priv,
+				     struct v4l2_format *f)
+{
+	struct deinterlace_ctx *ctx = deinterlace_file2ctx(file);
+
+	f->fmt.pix = ctx->src_fmt;
+
+	return 0;
+}
+
+static void deinterlace_try_cap_format(struct deinterlace_ctx *ctx,
+				       struct v4l2_pix_format *fmt)
+{
+	fmt->pixelformat = ctx->src_fmt.pixelformat;
+	fmt->field = V4L2_FIELD_NONE;
+	fmt->width = ctx->src_fmt.width;
+	fmt->height = ctx->src_fmt.height;
+
+	deinterlace_prepare_format(fmt);
+}
+
+static void deinterlace_try_out_format(struct v4l2_pix_format *fmt)
+{
+	if (!deinterlace_check_format(fmt->pixelformat))
+		fmt->pixelformat = deinterlace_formats[0];
+
+	if (fmt->field != V4L2_FIELD_INTERLACED_TB &&
+	    fmt->field != V4L2_FIELD_INTERLACED_BT &&
+	    fmt->field != V4L2_FIELD_INTERLACED)
+		fmt->field = V4L2_FIELD_INTERLACED;
+
+	deinterlace_prepare_format(fmt);
+}
+
+static int deinterlace_try_fmt_vid_cap(struct file *file, void *priv,
+				       struct v4l2_format *f)
+{
+	deinterlace_try_cap_format(deinterlace_file2ctx(file), &f->fmt.pix);
+
+	return 0;
+}
+
+static int deinterlace_try_fmt_vid_out(struct file *file, void *priv,
+				       struct v4l2_format *f)
+{
+	deinterlace_try_out_format(&f->fmt.pix);
+
+	return 0;
+}
+
+static void deinterlace_set_cap_format(struct deinterlace_ctx *ctx,
+				       struct v4l2_pix_format *fmt)
+{
+	deinterlace_try_cap_format(ctx, fmt);
+
+	ctx->dst_fmt = *fmt;
+}
+
+static void deinterlace_set_out_format(struct deinterlace_ctx *ctx,
+				       struct v4l2_pix_format *fmt)
+{
+	deinterlace_try_out_format(fmt);
+
+	ctx->src_fmt = *fmt;
+
+	/* Propagate colorspace information to capture. */
+	ctx->dst_fmt.colorspace = fmt->colorspace;
+	ctx->dst_fmt.xfer_func = fmt->xfer_func;
+	ctx->dst_fmt.ycbcr_enc = fmt->ycbcr_enc;
+	ctx->dst_fmt.quantization = fmt->quantization;
+
+	deinterlace_set_cap_format(ctx, &ctx->dst_fmt);
+}
+
+static int deinterlace_s_fmt_vid_cap(struct file *file, void *priv,
+				     struct v4l2_format *f)
+{
+	struct deinterlace_ctx *ctx = deinterlace_file2ctx(file);
+	struct vb2_queue *vq;
+
+	vq = v4l2_m2m_get_vq(ctx->fh.m2m_ctx, f->type);
+	if (vb2_is_busy(vq))
+		return -EBUSY;
+
+	deinterlace_set_cap_format(ctx, &f->fmt.pix);
+
+	return 0;
+}
+
+static int deinterlace_s_fmt_vid_out(struct file *file, void *priv,
+				     struct v4l2_format *f)
+{
+	struct deinterlace_ctx *ctx = deinterlace_file2ctx(file);
+	struct vb2_queue *vq;
+
+	vq = v4l2_m2m_get_vq(ctx->fh.m2m_ctx, f->type);
+	if (vb2_is_busy(vq))
+		return -EBUSY;
+
+	/*
+	 * Pixel format and size must be propagated to capture format too,
+	 * so capture queue must not be busy.
+	 */
+	vq = v4l2_m2m_get_vq(ctx->fh.m2m_ctx, V4L2_BUF_TYPE_VIDEO_CAPTURE);
+	if (vb2_is_busy(vq))
+		return -EBUSY;
+
+	deinterlace_set_out_format(ctx, &f->fmt.pix);
+
+	return 0;
+}
+
+static const struct v4l2_ioctl_ops deinterlace_ioctl_ops = {
+	.vidioc_querycap		= deinterlace_querycap,
+
+	.vidioc_enum_framesizes		= deinterlace_enum_framesizes,
+
+	.vidioc_enum_fmt_vid_cap	= deinterlace_enum_fmt,
+	.vidioc_g_fmt_vid_cap		= deinterlace_g_fmt_vid_cap,
+	.vidioc_try_fmt_vid_cap		= deinterlace_try_fmt_vid_cap,
+	.vidioc_s_fmt_vid_cap		= deinterlace_s_fmt_vid_cap,
+
+	.vidioc_enum_fmt_vid_out	= deinterlace_enum_fmt,
+	.vidioc_g_fmt_vid_out		= deinterlace_g_fmt_vid_out,
+	.vidioc_try_fmt_vid_out		= deinterlace_try_fmt_vid_out,
+	.vidioc_s_fmt_vid_out		= deinterlace_s_fmt_vid_out,
+
+	.vidioc_reqbufs			= v4l2_m2m_ioctl_reqbufs,
+	.vidioc_querybuf		= v4l2_m2m_ioctl_querybuf,
+	.vidioc_qbuf			= v4l2_m2m_ioctl_qbuf,
+	.vidioc_dqbuf			= v4l2_m2m_ioctl_dqbuf,
+	.vidioc_prepare_buf		= v4l2_m2m_ioctl_prepare_buf,
+	.vidioc_create_bufs		= v4l2_m2m_ioctl_create_bufs,
+	.vidioc_expbuf			= v4l2_m2m_ioctl_expbuf,
+
+	.vidioc_streamon		= v4l2_m2m_ioctl_streamon,
+	.vidioc_streamoff		= v4l2_m2m_ioctl_streamoff,
+};
+
+static int deinterlace_queue_setup(struct vb2_queue *vq, unsigned int *nbuffers,
+				   unsigned int *nplanes, unsigned int sizes[],
+				   struct device *alloc_devs[])
+{
+	struct deinterlace_ctx *ctx = vb2_get_drv_priv(vq);
+	struct v4l2_pix_format *pix_fmt;
+
+	if (V4L2_TYPE_IS_OUTPUT(vq->type))
+		pix_fmt = &ctx->src_fmt;
+	else
+		pix_fmt = &ctx->dst_fmt;
+
+	if (*nplanes) {
+		if (sizes[0] < pix_fmt->sizeimage)
+			return -EINVAL;
+	} else {
+		sizes[0] = pix_fmt->sizeimage;
+		*nplanes = 1;
+	}
+
+	return 0;
+}
+
+static int deinterlace_buf_prepare(struct vb2_buffer *vb)
+{
+	struct vb2_queue *vq = vb->vb2_queue;
+	struct deinterlace_ctx *ctx = vb2_get_drv_priv(vq);
+	struct v4l2_pix_format *pix_fmt;
+
+	if (V4L2_TYPE_IS_OUTPUT(vq->type))
+		pix_fmt = &ctx->src_fmt;
+	else
+		pix_fmt = &ctx->dst_fmt;
+
+	if (vb2_plane_size(vb, 0) < pix_fmt->sizeimage)
+		return -EINVAL;
+
+	vb2_set_plane_payload(vb, 0, pix_fmt->sizeimage);
+
+	return 0;
+}
+
+static void deinterlace_buf_queue(struct vb2_buffer *vb)
+{
+	struct vb2_v4l2_buffer *vbuf = to_vb2_v4l2_buffer(vb);
+	struct deinterlace_ctx *ctx = vb2_get_drv_priv(vb->vb2_queue);
+
+	v4l2_m2m_buf_queue(ctx->fh.m2m_ctx, vbuf);
+}
+
+static void deinterlace_queue_cleanup(struct vb2_queue *vq, u32 state)
+{
+	struct deinterlace_ctx *ctx = vb2_get_drv_priv(vq);
+	struct vb2_v4l2_buffer *vbuf;
+
+	do {
+		if (V4L2_TYPE_IS_OUTPUT(vq->type))
+			vbuf = v4l2_m2m_src_buf_remove(ctx->fh.m2m_ctx);
+		else
+			vbuf = v4l2_m2m_dst_buf_remove(ctx->fh.m2m_ctx);
+
+		if (vbuf)
+			v4l2_m2m_buf_done(vbuf, state);
+	} while (vbuf);
+
+	if (V4L2_TYPE_IS_OUTPUT(vq->type)) {
+		if (ctx->prev[0])
+			v4l2_m2m_buf_done(ctx->prev[0], state);
+		if (ctx->prev[1])
+			v4l2_m2m_buf_done(ctx->prev[1], state);
+	}
+}
+
+static int deinterlace_start_streaming(struct vb2_queue *vq, unsigned int count)
+{
+	struct deinterlace_ctx *ctx = vb2_get_drv_priv(vq);
+	struct device *dev = ctx->dev->dev;
+	int ret;
+
+	if (V4L2_TYPE_IS_OUTPUT(vq->type)) {
+		ret = pm_runtime_get_sync(dev);
+		if (ret < 0) {
+			dev_err(dev, "Failed to enable module\n");
+
+			goto err_runtime_get;
+		}
+
+		ctx->first_field =
+			ctx->src_fmt.field == V4L2_FIELD_INTERLACED_BT;
+		ctx->field = ctx->first_field;
+
+		ctx->prev[0] = NULL;
+		ctx->prev[1] = NULL;
+		ctx->aborting = 0;
+
+		ctx->flag1_buf = dma_alloc_coherent(dev, FLAG_SIZE,
+						    &ctx->flag1_buf_dma,
+						    GFP_KERNEL);
+		if (!ctx->flag1_buf) {
+			ret = -ENOMEM;
+
+			goto err_no_mem1;
+		}
+
+		ctx->flag2_buf = dma_alloc_coherent(dev, FLAG_SIZE,
+						    &ctx->flag2_buf_dma,
+						    GFP_KERNEL);
+		if (!ctx->flag2_buf) {
+			ret = -ENOMEM;
+
+			goto err_no_mem2;
+		}
+	}
+
+	return 0;
+
+err_no_mem2:
+	dma_free_coherent(dev, FLAG_SIZE, ctx->flag1_buf,
+			  ctx->flag1_buf_dma);
+err_no_mem1:
+	pm_runtime_put(dev);
+err_runtime_get:
+	deinterlace_queue_cleanup(vq, VB2_BUF_STATE_QUEUED);
+
+	return ret;
+}
+
+static void deinterlace_stop_streaming(struct vb2_queue *vq)
+{
+	struct deinterlace_ctx *ctx = vb2_get_drv_priv(vq);
+
+	if (V4L2_TYPE_IS_OUTPUT(vq->type)) {
+		struct device *dev = ctx->dev->dev;
+
+		dma_free_coherent(dev, FLAG_SIZE, ctx->flag1_buf,
+				  ctx->flag1_buf_dma);
+		dma_free_coherent(dev, FLAG_SIZE, ctx->flag2_buf,
+				  ctx->flag2_buf_dma);
+
+		pm_runtime_put(dev);
+	}
+
+	deinterlace_queue_cleanup(vq, VB2_BUF_STATE_ERROR);
+}
+
+static const struct vb2_ops deinterlace_qops = {
+	.queue_setup		= deinterlace_queue_setup,
+	.buf_prepare		= deinterlace_buf_prepare,
+	.buf_queue		= deinterlace_buf_queue,
+	.start_streaming	= deinterlace_start_streaming,
+	.stop_streaming		= deinterlace_stop_streaming,
+	.wait_prepare		= vb2_ops_wait_prepare,
+	.wait_finish		= vb2_ops_wait_finish,
+};
+
+static int deinterlace_queue_init(void *priv, struct vb2_queue *src_vq,
+				  struct vb2_queue *dst_vq)
+{
+	struct deinterlace_ctx *ctx = priv;
+	int ret;
+
+	src_vq->type = V4L2_BUF_TYPE_VIDEO_OUTPUT;
+	src_vq->io_modes = VB2_MMAP | VB2_DMABUF;
+	src_vq->drv_priv = ctx;
+	src_vq->buf_struct_size = sizeof(struct v4l2_m2m_buffer);
+	src_vq->min_buffers_needed = 1;
+	src_vq->ops = &deinterlace_qops;
+	src_vq->mem_ops = &vb2_dma_contig_memops;
+	src_vq->timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_COPY;
+	src_vq->lock = &ctx->dev->dev_mutex;
+	src_vq->dev = ctx->dev->dev;
+
+	ret = vb2_queue_init(src_vq);
+	if (ret)
+		return ret;
+
+	dst_vq->type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
+	dst_vq->io_modes = VB2_MMAP | VB2_DMABUF;
+	dst_vq->drv_priv = ctx;
+	dst_vq->buf_struct_size = sizeof(struct v4l2_m2m_buffer);
+	dst_vq->min_buffers_needed = 2;
+	dst_vq->ops = &deinterlace_qops;
+	dst_vq->mem_ops = &vb2_dma_contig_memops;
+	dst_vq->timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_COPY;
+	dst_vq->lock = &ctx->dev->dev_mutex;
+	dst_vq->dev = ctx->dev->dev;
+
+	ret = vb2_queue_init(dst_vq);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int deinterlace_open(struct file *file)
+{
+	struct deinterlace_dev *dev = video_drvdata(file);
+	struct deinterlace_ctx *ctx = NULL;
+	int ret;
+
+	if (mutex_lock_interruptible(&dev->dev_mutex))
+		return -ERESTARTSYS;
+
+	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
+	if (!ctx) {
+		mutex_unlock(&dev->dev_mutex);
+		return -ENOMEM;
+	}
+
+	/* set default output and capture format */
+	deinterlace_set_out_format(ctx, &ctx->src_fmt);
+
+	v4l2_fh_init(&ctx->fh, video_devdata(file));
+	file->private_data = &ctx->fh;
+	ctx->dev = dev;
+
+	ctx->fh.m2m_ctx = v4l2_m2m_ctx_init(dev->m2m_dev, ctx,
+					    &deinterlace_queue_init);
+	if (IS_ERR(ctx->fh.m2m_ctx)) {
+		ret = PTR_ERR(ctx->fh.m2m_ctx);
+		goto err_free;
+	}
+
+	v4l2_fh_add(&ctx->fh);
+
+	mutex_unlock(&dev->dev_mutex);
+
+	return 0;
+
+err_free:
+	kfree(ctx);
+	mutex_unlock(&dev->dev_mutex);
+
+	return ret;
+}
+
+static int deinterlace_release(struct file *file)
+{
+	struct deinterlace_dev *dev = video_drvdata(file);
+	struct deinterlace_ctx *ctx = container_of(file->private_data,
+						   struct deinterlace_ctx, fh);
+
+	mutex_lock(&dev->dev_mutex);
+
+	v4l2_fh_del(&ctx->fh);
+	v4l2_fh_exit(&ctx->fh);
+	v4l2_m2m_ctx_release(ctx->fh.m2m_ctx);
+
+	kfree(ctx);
+
+	mutex_unlock(&dev->dev_mutex);
+
+	return 0;
+}
+
+static const struct v4l2_file_operations deinterlace_fops = {
+	.owner		= THIS_MODULE,
+	.open		= deinterlace_open,
+	.release	= deinterlace_release,
+	.poll		= v4l2_m2m_fop_poll,
+	.unlocked_ioctl	= video_ioctl2,
+	.mmap		= v4l2_m2m_fop_mmap,
+};
+
+static const struct video_device deinterlace_video_device = {
+	.name		= DEINTERLACE_NAME,
+	.vfl_dir	= VFL_DIR_M2M,
+	.fops		= &deinterlace_fops,
+	.ioctl_ops	= &deinterlace_ioctl_ops,
+	.minor		= -1,
+	.release	= video_device_release_empty,
+	.device_caps	= V4L2_CAP_VIDEO_M2M | V4L2_CAP_STREAMING,
+};
+
+static const struct v4l2_m2m_ops deinterlace_m2m_ops = {
+	.device_run	= deinterlace_device_run,
+	.job_ready	= deinterlace_job_ready,
+	.job_abort	= deinterlace_job_abort,
+};
+
+static int deinterlace_probe(struct platform_device *pdev)
+{
+	struct deinterlace_dev *dev;
+	struct video_device *vfd;
+	int irq, ret;
+
+	dev = devm_kzalloc(&pdev->dev, sizeof(*dev), GFP_KERNEL);
+	if (!dev)
+		return -ENOMEM;
+
+	dev->vfd = deinterlace_video_device;
+	dev->dev = &pdev->dev;
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq <= 0)
+		return irq;
+
+	ret = devm_request_irq(dev->dev, irq, deinterlace_irq,
+			       0, dev_name(dev->dev), dev);
+	if (ret) {
+		dev_err(dev->dev, "Failed to request IRQ\n");
+
+		return ret;
+	}
+
+	dev->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(dev->base))
+		return PTR_ERR(dev->base);
+
+	dev->bus_clk = devm_clk_get(dev->dev, "bus");
+	if (IS_ERR(dev->bus_clk))
+		return dev_err_probe(dev->dev, PTR_ERR(dev->bus_clk),
+				     "Failed to get bus clock\n");
+
+	dev->mod_clk = devm_clk_get(dev->dev, "mod");
+	if (IS_ERR(dev->mod_clk))
+		return dev_err_probe(dev->dev, PTR_ERR(dev->mod_clk),
+				     "Failed to get mod clock\n");
+
+	dev->ram_clk = devm_clk_get(dev->dev, "ram");
+	if (IS_ERR(dev->ram_clk))
+		return dev_err_probe(dev->dev, PTR_ERR(dev->ram_clk),
+				     "Failed to get ram clock\n");
+
+	dev->rstc = devm_reset_control_get(dev->dev, NULL);
+	if (IS_ERR(dev->rstc))
+		return dev_err_probe(dev->dev, PTR_ERR(dev->rstc),
+				     "Failed to get reset control\n");
+
+	dma_set_mask_and_coherent(dev->dev, DMA_BIT_MASK(32));
+	dma_set_max_seg_size(dev->dev, UINT_MAX);
+
+	mutex_init(&dev->dev_mutex);
+
+	INIT_DELAYED_WORK(&dev->watchdog_work, deinterlace_watchdog);
+
+	ret = v4l2_device_register(&pdev->dev, &dev->v4l2_dev);
+	if (ret) {
+		dev_err(dev->dev, "Failed to register V4L2 device\n");
+
+		return ret;
+	}
+
+	vfd = &dev->vfd;
+	vfd->lock = &dev->dev_mutex;
+	vfd->v4l2_dev = &dev->v4l2_dev;
+
+	snprintf(vfd->name, sizeof(vfd->name), "%s",
+		 deinterlace_video_device.name);
+	video_set_drvdata(vfd, dev);
+
+	ret = video_register_device(vfd, VFL_TYPE_VIDEO, 0);
+	if (ret) {
+		v4l2_err(&dev->v4l2_dev, "Failed to register video device\n");
+
+		goto err_v4l2;
+	}
+
+	v4l2_info(&dev->v4l2_dev,
+		  "Device registered as /dev/video%d\n", vfd->num);
+
+	dev->m2m_dev = v4l2_m2m_init(&deinterlace_m2m_ops);
+	if (IS_ERR(dev->m2m_dev)) {
+		v4l2_err(&dev->v4l2_dev,
+			 "Failed to initialize V4L2 M2M device\n");
+		ret = PTR_ERR(dev->m2m_dev);
+
+		goto err_video;
+	}
+
+	platform_set_drvdata(pdev, dev);
+
+	pm_runtime_enable(dev->dev);
+
+	return 0;
+
+err_video:
+	video_unregister_device(&dev->vfd);
+err_v4l2:
+	v4l2_device_unregister(&dev->v4l2_dev);
+
+	return ret;
+}
+
+static int deinterlace_remove(struct platform_device *pdev)
+{
+	struct deinterlace_dev *dev = platform_get_drvdata(pdev);
+
+	v4l2_m2m_release(dev->m2m_dev);
+	video_unregister_device(&dev->vfd);
+	v4l2_device_unregister(&dev->v4l2_dev);
+
+	pm_runtime_force_suspend(&pdev->dev);
+
+	return 0;
+}
+
+static int deinterlace_runtime_resume(struct device *device)
+{
+	struct deinterlace_dev *dev = dev_get_drvdata(device);
+	int ret;
+
+	ret = clk_prepare_enable(dev->bus_clk);
+	if (ret) {
+		dev_err(dev->dev, "Failed to enable bus clock\n");
+
+		return ret;
+	}
+
+	ret = clk_prepare_enable(dev->mod_clk);
+	if (ret) {
+		dev_err(dev->dev, "Failed to enable mod clock\n");
+
+		goto err_bus_clk;
+	}
+
+	ret = clk_prepare_enable(dev->ram_clk);
+	if (ret) {
+		dev_err(dev->dev, "Failed to enable ram clock\n");
+
+		goto err_mod_clk;
+	}
+
+	ret = reset_control_deassert(dev->rstc);
+	if (ret) {
+		dev_err(dev->dev, "Failed to apply reset\n");
+
+		goto err_ram_clk;
+	}
+
+	deinterlace_init(dev);
+
+	return 0;
+
+err_ram_clk:
+	clk_disable_unprepare(dev->ram_clk);
+err_mod_clk:
+	clk_disable_unprepare(dev->mod_clk);
+err_bus_clk:
+	clk_disable_unprepare(dev->bus_clk);
+
+	return ret;
+}
+
+static int deinterlace_runtime_suspend(struct device *device)
+{
+	struct deinterlace_dev *dev = dev_get_drvdata(device);
+
+	reset_control_assert(dev->rstc);
+
+	clk_disable_unprepare(dev->ram_clk);
+	clk_disable_unprepare(dev->mod_clk);
+	clk_disable_unprepare(dev->bus_clk);
+
+	return 0;
+}
+
+static const struct of_device_id deinterlace_dt_match[] = {
+	{ .compatible = "allwinner,sun50i-h6-deinterlace" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, deinterlace_dt_match);
+
+static const struct dev_pm_ops deinterlace_pm_ops = {
+	.runtime_resume		= deinterlace_runtime_resume,
+	.runtime_suspend	= deinterlace_runtime_suspend,
+};
+
+static struct platform_driver deinterlace_driver = {
+	.probe		= deinterlace_probe,
+	.remove		= deinterlace_remove,
+	.driver		= {
+		.name		= DEINTERLACE_NAME,
+		.of_match_table	= deinterlace_dt_match,
+		.pm		= &deinterlace_pm_ops,
+	},
+};
+module_platform_driver(deinterlace_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Jernej Skrabec <jernej.skrabec@gmail.com>");
+MODULE_DESCRIPTION("Allwinner sun50i deinterlace driver");
diff --git a/drivers/media/platform/sunxi/sun50i-di/sun50i-di.h b/drivers/media/platform/sunxi/sun50i-di/sun50i-di.h
new file mode 100644
index 000000000000..c6eae30040e9
--- /dev/null
+++ b/drivers/media/platform/sunxi/sun50i-di/sun50i-di.h
@@ -0,0 +1,175 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Allwinner Deinterlace driver
+ *
+ * Copyright (C) 2020 Jernej Skrabec <jernej.skrabec@gmail.com>
+ */
+
+#ifndef _SUN8I_DEINTERLACE_H_
+#define _SUN8I_DEINTERLACE_H_
+
+#include <linux/clk.h>
+#include <linux/platform_device.h>
+#include <linux/reset.h>
+#include <linux/workqueue.h>
+
+#include <media/v4l2-device.h>
+#include <media/v4l2-mem2mem.h>
+#include <media/videobuf2-v4l2.h>
+
+#define DEINTERLACE_NAME		"sun50i-di"
+
+#define DEINTERLACE_CTRL			0x00
+#define DEINTERLACE_CTRL_START				BIT(0)
+#define DEINTERLACE_CTRL_IOMMU_EN			BIT(16)
+#define DEINTERLACE_CTRL_RESET				BIT(31)
+
+#define DEINTERLACE_INT_CTRL			0x04
+#define DEINTERLACE_INT_EN				BIT(0)
+
+#define DEINTERLACE_STATUS			0x08
+#define DEINTERLACE_STATUS_FINISHED			BIT(0)
+#define DEINTERLACE_STATUS_BUSY				BIT(8)
+
+#define DEINTERLACE_SIZE			0x10
+#define DEINTERLACE_SIZE_WIDTH(w) \
+	(((w) - 1) & 0x7ff)
+#define DEINTERLACE_SIZE_HEIGHT(h) \
+	((((h) - 1) & 0x7ff) << 16)
+
+#define DEINTERLACE_FORMAT			0x14
+#define DEINTERLACE_FORMAT_YUV420P			0
+#define DEINTERLACE_FORMAT_YUV420SP			1
+#define DEINTERLACE_FORMAT_YUV422P			2
+#define DEINTERLACE_FORMAT_YUV422SP			3
+
+#define DEINTERLACE_POLAR			0x18
+#define DEINTERLACE_POLAR_FIELD(x)			((x) & 1)
+
+/* all pitch registers accept 16-bit values */
+#define DEINTERLACE_IN_PITCH0			0x20
+#define DEINTERLACE_IN_PITCH1			0x24
+#define DEINTERLACE_IN_PITCH2			0x28
+#define DEINTERLACE_OUT_PITCH0			0x30
+#define DEINTERLACE_OUT_PITCH1			0x34
+#define DEINTERLACE_OUT_PITCH2			0x38
+#define DEINTERLACE_FLAG_PITCH			0x40
+#define DEINTERLACE_IN0_ADDR0			0x50
+#define DEINTERLACE_IN0_ADDR1			0x54
+#define DEINTERLACE_IN0_ADDR2			0x58
+#define DEINTERLACE_IN0_ADDRH			0x5c
+#define DEINTERLACE_IN1_ADDR0			0x60
+#define DEINTERLACE_IN1_ADDR1			0x64
+#define DEINTERLACE_IN1_ADDR2			0x68
+#define DEINTERLACE_IN1_ADDRH			0x6c
+#define DEINTERLACE_IN2_ADDR0			0x70
+#define DEINTERLACE_IN2_ADDR1			0x74
+#define DEINTERLACE_IN2_ADDR2			0x78
+#define DEINTERLACE_IN2_ADDRH			0x7c
+#define DEINTERLACE_IN3_ADDR0			0x80
+#define DEINTERLACE_IN3_ADDR1			0x84
+#define DEINTERLACE_IN3_ADDR2			0x88
+#define DEINTERLACE_IN3_ADDRH			0x8c
+#define DEINTERLACE_OUT_ADDR0			0x90
+#define DEINTERLACE_OUT_ADDR1			0x94
+#define DEINTERLACE_OUT_ADDR2			0x98
+#define DEINTERLACE_OUT_ADDRH			0x9c
+#define DEINTERLACE_IN_FLAG_ADDR		0xa0
+#define DEINTERLACE_OUT_FLAG_ADDR		0xa4
+#define DEINTERLACE_FLAG_ADDRH			0xa8
+
+#define DEINTERLACE_ADDRH0(x)				((x) & 0xff)
+#define DEINTERLACE_ADDRH1(x)				(((x) & 0xff) << 8)
+#define DEINTERLACE_ADDRH2(x)				(((x) & 0xff) << 16)
+
+#define DEINTERLACE_MODE			0xb0
+#define DEINTERLACE_MODE_DEINT_LUMA			BIT(0)
+#define DEINTERLACE_MODE_MOTION_EN			BIT(4)
+#define DEINTERLACE_MODE_INTP_EN			BIT(5)
+#define DEINTERLACE_MODE_AUTO_UPD_MODE(x)		(((x) & 3) << 12)
+#define DEINTERLACE_MODE_DEINT_CHROMA			BIT(16)
+#define DEINTERLACE_MODE_FIELD_MODE			BIT(31)
+
+#define DEINTERLACE_MD_PARAM0			0xb4
+#define DEINTERLACE_MD_PARAM0_MIN_LUMA_TH(x)		((x) & 0xff)
+#define DEINTERLACE_MD_PARAM0_MAX_LUMA_TH(x)		(((x) & 0xff) << 8)
+#define DEINTERLACE_MD_PARAM0_AVG_LUMA_SHIFT(x)		(((x) & 0xf) << 16)
+#define DEINTERLACE_MD_PARAM0_TH_SHIFT(x)		(((x) & 0xf) << 24)
+
+#define DEINTERLACE_MD_PARAM1			0xb8
+#define DEINTERLACE_MD_PARAM1_MOV_FAC_NONEDGE(x)	(((x) & 0x3) << 28)
+
+#define DEINTERLACE_MD_PARAM2			0xbc
+#define DEINTERLACE_MD_PARAM2_CHROMA_SPATIAL_TH(x)	(((x) & 0xff) << 8)
+#define DEINTERLACE_MD_PARAM2_CHROMA_DIFF_TH(x)		(((x) & 0xff) << 16)
+#define DEINTERLACE_MD_PARAM2_PIX_STATIC_TH(x)		(((x) & 0x3) << 28)
+
+#define DEINTERLACE_INTP_PARAM0			0xc0
+#define DEINTERLACE_INTP_PARAM0_ANGLE_LIMIT(x)		((x) & 0x1f)
+#define DEINTERLACE_INTP_PARAM0_ANGLE_CONST_TH(x)	(((x) & 7) << 8)
+#define DEINTERLACE_INTP_PARAM0_LUMA_CUR_FAC_MODE(x)	(((x) & 7) << 16)
+#define DEINTERLACE_INTP_PARAM0_CHROMA_CUR_FAC_MODE(x)	(((x) & 7) << 20)
+
+#define DEINTERLACE_MD_CH_PARAM			0xc4
+#define DEINTERLACE_MD_CH_PARAM_BLEND_MODE(x)		((x) & 0xf)
+#define DEINTERLACE_MD_CH_PARAM_FONT_PRO_EN		BIT(8)
+#define DEINTERLACE_MD_CH_PARAM_FONT_PRO_TH(x)		(((x) & 0xff) << 16)
+#define DEINTERLACE_MD_CH_PARAM_FONT_PRO_FAC(x)		(((x) & 0x1f) << 24)
+
+#define DEINTERLACE_INTP_PARAM1			0xc8
+#define DEINTERLACE_INTP_PARAM1_A(x)			((x) & 7)
+#define DEINTERLACE_INTP_PARAM1_EN			BIT(3)
+#define DEINTERLACE_INTP_PARAM1_C(x)			(((x) & 0xf) << 4)
+#define DEINTERLACE_INTP_PARAM1_CMAX(x)			(((x) & 0xff) << 8)
+#define DEINTERLACE_INTP_PARAM1_MAXRAT(x)		(((x) & 3) << 16)
+
+/* there is no explanation what this register does */
+#define DEINTERLACE_OUT_PATH			0x200
+
+#define DEINTERLACE_MIN_WIDTH	2U
+#define DEINTERLACE_MIN_HEIGHT	2U
+#define DEINTERLACE_MAX_WIDTH	2048U
+#define DEINTERLACE_MAX_HEIGHT	1100U
+
+struct deinterlace_dev {
+	struct v4l2_device	v4l2_dev;
+	struct video_device	vfd;
+	struct device		*dev;
+	struct v4l2_m2m_dev	*m2m_dev;
+
+	/* Device file mutex */
+	struct mutex		dev_mutex;
+
+	void __iomem		*base;
+
+	struct clk		*bus_clk;
+	struct clk		*mod_clk;
+	struct clk		*ram_clk;
+
+	struct reset_control	*rstc;
+
+	struct delayed_work	watchdog_work;
+};
+
+struct deinterlace_ctx {
+	struct v4l2_fh		fh;
+	struct deinterlace_dev	*dev;
+
+	struct v4l2_pix_format	src_fmt;
+	struct v4l2_pix_format	dst_fmt;
+
+	void			*flag1_buf;
+	dma_addr_t		flag1_buf_dma;
+
+	void			*flag2_buf;
+	dma_addr_t		flag2_buf_dma;
+
+	struct vb2_v4l2_buffer	*prev[2];
+
+	unsigned int		first_field;
+	unsigned int		field;
+
+	int			aborting;
+};
+
+#endif
-- 
2.38.1

