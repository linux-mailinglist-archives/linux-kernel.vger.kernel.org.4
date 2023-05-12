Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F67370058E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 12:32:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240606AbjELKby convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 12 May 2023 06:31:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231660AbjELKbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 06:31:34 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 205BB83DC;
        Fri, 12 May 2023 03:31:24 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 0065424E34B;
        Fri, 12 May 2023 18:28:49 +0800 (CST)
Received: from EXMBX073.cuchost.com (172.16.6.83) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 12 May
 2023 18:28:48 +0800
Received: from xiaofei.localdomain (180.164.60.184) by EXMBX073.cuchost.com
 (172.16.6.83) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 12 May
 2023 18:28:47 +0800
From:   Jack Zhu <jack.zhu@starfivetech.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Foss <rfoss@kernel.org>,
        Todor Tomov <todor.too@gmail.com>,
        <bryan.odonoghue@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Laurent Pinchart" <laurent.pinchart@ideasonboard.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Eugen Hristev <eugen.hristev@collabora.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
CC:     <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <jack.zhu@starfivetech.com>,
        <changhuang.liang@starfivetech.com>
Subject: [PATCH v5 6/6] media: starfive: Add VIN driver
Date:   Fri, 12 May 2023 18:28:44 +0800
Message-ID: <20230512102844.51084-7-jack.zhu@starfivetech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230512102844.51084-1-jack.zhu@starfivetech.com>
References: <20230512102844.51084-1-jack.zhu@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [180.164.60.184]
X-ClientProxiedBy: EXCAS062.cuchost.com (172.16.6.22) To EXMBX073.cuchost.com
 (172.16.6.83)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Video In Controller driver for StarFive Camera Subsystem.

Signed-off-by: Jack Zhu <jack.zhu@starfivetech.com>
---
 drivers/media/platform/starfive/Makefile      |    4 +-
 drivers/media/platform/starfive/stf_camss.c   |   39 +-
 drivers/media/platform/starfive/stf_camss.h   |    2 +
 drivers/media/platform/starfive/stf_vin.c     | 1134 +++++++++++++++++
 drivers/media/platform/starfive/stf_vin.h     |  180 +++
 .../media/platform/starfive/stf_vin_hw_ops.c  |  241 ++++
 6 files changed, 1598 insertions(+), 2 deletions(-)
 create mode 100644 drivers/media/platform/starfive/stf_vin.c
 create mode 100644 drivers/media/platform/starfive/stf_vin.h
 create mode 100644 drivers/media/platform/starfive/stf_vin_hw_ops.c

diff --git a/drivers/media/platform/starfive/Makefile b/drivers/media/platform/starfive/Makefile
index 60a3018f4994..bf497dd24bbb 100644
--- a/drivers/media/platform/starfive/Makefile
+++ b/drivers/media/platform/starfive/Makefile
@@ -7,6 +7,8 @@ starfive-camss-objs += \
 		stf_camss.o \
 		stf_isp.o \
 		stf_isp_hw_ops.o \
-		stf_video.o
+		stf_video.o \
+		stf_vin.o \
+		stf_vin_hw_ops.o
 
 obj-$(CONFIG_VIDEO_STARFIVE_CAMSS) += starfive-camss.o \
diff --git a/drivers/media/platform/starfive/stf_camss.c b/drivers/media/platform/starfive/stf_camss.c
index 7ae9a827daa1..926315fce7fe 100644
--- a/drivers/media/platform/starfive/stf_camss.c
+++ b/drivers/media/platform/starfive/stf_camss.c
@@ -142,27 +142,61 @@ static int stfcamss_init_subdevices(struct stfcamss *stfcamss)
 		return ret;
 	}
 
+	ret = stf_vin_subdev_init(stfcamss);
+	if (ret < 0) {
+		dev_err(stfcamss->dev, "Failed to init vin subdev: %d\n", ret);
+		return ret;
+	}
 	return ret;
 }
 
 static int stfcamss_register_subdevices(struct stfcamss *stfcamss)
 {
 	int ret;
+	struct stf_vin_dev *vin_dev = &stfcamss->vin_dev;
 	struct stf_isp_dev *isp_dev = &stfcamss->isp_dev;
 
 	ret = stf_isp_register(isp_dev, &stfcamss->v4l2_dev);
 	if (ret < 0) {
 		dev_err(stfcamss->dev,
 			"Failed to register stf isp%d entity: %d\n", 0, ret);
-		return ret;
+		goto err_reg_isp;
+	}
+
+	ret = stf_vin_register(vin_dev, &stfcamss->v4l2_dev);
+	if (ret < 0) {
+		dev_err(stfcamss->dev,
+			"Failed to register vin entity: %d\n", ret);
+		goto err_reg_vin;
 	}
 
+	ret = media_create_pad_link(&isp_dev->subdev.entity,
+				    STF_ISP_PAD_SRC,
+				    &vin_dev->line[VIN_LINE_ISP].subdev.entity,
+				    STF_VIN_PAD_SINK,
+				    0);
+	if (ret < 0) {
+		dev_err(stfcamss->dev,
+			"Failed to link %s->%s entities: %d\n",
+			isp_dev->subdev.entity.name,
+			vin_dev->line[VIN_LINE_ISP].subdev.entity.name, ret);
+		goto err_link;
+	}
+
+	return ret;
+
+err_link:
+	stf_vin_unregister(&stfcamss->vin_dev);
+err_reg_vin:
+	stf_isp_unregister(&stfcamss->isp_dev);
+err_reg_isp:
 	return ret;
 }
 
 static void stfcamss_unregister_subdevices(struct stfcamss *stfcamss)
 {
 	stf_isp_unregister(&stfcamss->isp_dev);
+	stf_vin_unregister(&stfcamss->vin_dev);
 }
 
 static int stfcamss_subdev_notifier_bound(struct v4l2_async_notifier *async,
@@ -175,11 +209,14 @@ static int stfcamss_subdev_notifier_bound(struct v4l2_async_notifier *async,
 		container_of(asd, struct stfcamss_async_subdev, asd);
 	enum port_num port = csd->port;
 	struct stf_isp_dev *isp_dev = &stfcamss->isp_dev;
+	struct stf_vin_dev *vin_dev = &stfcamss->vin_dev;
 	struct host_data *host_data = &stfcamss->host_data;
 	struct media_entity *source;
 	int i, j;
 
 	if (port == PORT_NUMBER_CSI2RX) {
+		host_data->host_entity[0] =
+			&vin_dev->line[VIN_LINE_WR].subdev.entity;
 		host_data->host_entity[1] = &isp_dev->subdev.entity;
 	} else if (port == PORT_NUMBER_DVP_SENSOR) {
 		dev_err(stfcamss->dev, "Not support DVP sensor\n");
diff --git a/drivers/media/platform/starfive/stf_camss.h b/drivers/media/platform/starfive/stf_camss.h
index c9d94be92ea8..688bb3b7b6d0 100644
--- a/drivers/media/platform/starfive/stf_camss.h
+++ b/drivers/media/platform/starfive/stf_camss.h
@@ -17,6 +17,7 @@
 
 #include "stf_common.h"
 #include "stf_isp.h"
+#include "stf_vin.h"
 
 #define DRV_NAME     "starfive-camss"
 #define STF_DVP_NAME "stf_dvp"
@@ -72,6 +73,7 @@ struct stfcamss {
 	struct media_device media_dev;
 	struct media_pipeline pipe;
 	struct device *dev;
+	struct stf_vin_dev vin_dev;
 	struct stf_isp_dev isp_dev;
 	struct v4l2_async_notifier notifier;
 	struct host_data host_data;
diff --git a/drivers/media/platform/starfive/stf_vin.c b/drivers/media/platform/starfive/stf_vin.c
new file mode 100644
index 000000000000..21b0afa4ca3a
--- /dev/null
+++ b/drivers/media/platform/starfive/stf_vin.c
@@ -0,0 +1,1134 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * stf_vin.c
+ *
+ * StarFive Camera Subsystem - VIN Module
+ *
+ * Copyright (C) 2021-2023 StarFive Technology Co., Ltd.
+ */
+#include <linux/pm_runtime.h>
+
+#include "stf_camss.h"
+
+#define vin_line_array(ptr_line) \
+	((const struct vin_line (*)[]) &(ptr_line)[-((ptr_line)->id)])
+
+#define line_to_vin_dev(ptr_line) \
+	container_of(vin_line_array(ptr_line), struct stf_vin_dev, line)
+
+#define VIN_FRAME_DROP_MAX_VAL 90
+#define VIN_FRAME_DROP_MIN_VAL 4
+#define VIN_FRAME_PER_SEC_MAX_VAL 90
+
+/* ISP ctrl need 1 sec to let frames become stable. */
+#define VIN_FRAME_DROP_SEC_FOR_ISP_CTRL 1
+
+static const struct vin_format vin_formats_wr[] = {
+	{ MEDIA_BUS_FMT_SRGGB10_1X10, 10},
+	{ MEDIA_BUS_FMT_SGRBG10_1X10, 10},
+	{ MEDIA_BUS_FMT_SGBRG10_1X10, 10},
+	{ MEDIA_BUS_FMT_SBGGR10_1X10, 10},
+};
+
+static const struct vin_format vin_formats_uo[] = {
+	{ MEDIA_BUS_FMT_Y12_1X12, 8},
+};
+
+static const struct vin_format_table vin_formats_table[] = {
+	/* VIN_LINE_WR */
+	{ vin_formats_wr, ARRAY_SIZE(vin_formats_wr) },
+	/* VIN_LINE_ISP */
+	{ vin_formats_uo, ARRAY_SIZE(vin_formats_uo) },
+};
+
+static void vin_buffer_done(struct vin_line *line);
+static void vin_change_buffer(struct vin_line *line);
+static struct stfcamss_buffer *vin_buf_get_pending(struct vin_output *output);
+static void vin_output_init_addrs(struct vin_line *line);
+static void vin_init_outputs(struct vin_line *line);
+static struct v4l2_mbus_framefmt *
+__vin_get_format(struct vin_line *line,
+		 struct v4l2_subdev_state *state,
+		 unsigned int pad,
+		 enum v4l2_subdev_format_whence which);
+
+static char *vin_get_line_subdevname(int line_id)
+{
+	char *name = NULL;
+
+	switch (line_id) {
+	case VIN_LINE_WR:
+		name = "wr";
+		break;
+	case VIN_LINE_ISP:
+		name = "isp0";
+		break;
+	default:
+		name = "unknown";
+		break;
+	}
+	return name;
+}
+
+static enum isp_line_id vin_map_isp_line(enum vin_line_id line)
+{
+	enum isp_line_id line_id;
+
+	if (line > VIN_LINE_WR && line < VIN_LINE_MAX)
+		line_id = STF_ISP_LINE_SRC;
+	else
+		line_id = STF_ISP_LINE_INVALID;
+
+	return line_id;
+}
+
+enum isp_pad_id stf_vin_map_isp_pad(enum vin_line_id line, enum isp_pad_id def)
+{
+	enum isp_pad_id pad_id;
+
+	if (line == VIN_LINE_WR)
+		pad_id = STF_ISP_PAD_SINK;
+	else if ((line > VIN_LINE_WR) && (line < VIN_LINE_MAX))
+		pad_id = (enum isp_pad_id)vin_map_isp_line(line);
+	else
+		pad_id = def;
+
+	return pad_id;
+}
+
+int stf_vin_subdev_init(struct stfcamss *stfcamss)
+{
+	struct device *dev = stfcamss->dev;
+	struct stf_vin_dev *vin_dev = &stfcamss->vin_dev;
+	int i, ret = 0;
+
+	vin_dev->stfcamss = stfcamss;
+
+	vin_dev->isr_ops = devm_kzalloc(dev, sizeof(*vin_dev->isr_ops),
+					GFP_KERNEL);
+	if (!vin_dev->isr_ops)
+		return -ENOMEM;
+	vin_dev->isr_ops->isr_buffer_done = vin_buffer_done;
+	vin_dev->isr_ops->isr_change_buffer = vin_change_buffer;
+
+	atomic_set(&vin_dev->ref_count, 0);
+
+	ret = devm_request_irq(dev,
+			       stfcamss->irq[STF_IRQ_VINWR],
+			       stf_vin_wr_irq_handler,
+			       0, "vin_axiwr_irq", vin_dev);
+	if (ret) {
+		dev_err(dev, "Failed to request irq\n");
+		goto out;
+	}
+
+	ret = devm_request_irq(dev,
+			       stfcamss->irq[STF_IRQ_ISP],
+			       stf_vin_isp_irq_handler,
+			       0, "vin_isp_irq", vin_dev);
+	if (ret) {
+		dev_err(dev, "Failed to request isp irq\n");
+		goto out;
+	}
+
+	ret = devm_request_irq(dev,
+			       stfcamss->irq[STF_IRQ_ISPCSIL],
+			       stf_vin_isp_irq_csiline_handler,
+			       0, "vin_isp_irq_csiline", vin_dev);
+	if (ret) {
+		dev_err(dev, "failed to request isp irq csiline\n");
+		goto out;
+	}
+
+	mutex_init(&vin_dev->power_lock);
+	vin_dev->power_count = 0;
+
+	for (i = 0; i < STF_DUMMY_MODULE_NUMS; i++) {
+		struct dummy_buffer *dummy_buffer = &vin_dev->dummy_buffer[i];
+
+		mutex_init(&dummy_buffer->stream_lock);
+		dummy_buffer->nums =
+			i == 0 ? VIN_DUMMY_BUFFER_NUMS : ISP_DUMMY_BUFFER_NUMS;
+		dummy_buffer->stream_count = 0;
+		dummy_buffer->buffer =
+			devm_kzalloc(dev,
+				     dummy_buffer->nums * sizeof(struct vin_dummy_buffer),
+				     GFP_KERNEL);
+		atomic_set(&dummy_buffer->frame_skip, 0);
+	}
+
+	for (i = VIN_LINE_WR; i < STF_ISP_LINE_MAX + 1; i++) {
+		struct vin_line *l = &vin_dev->line[i];
+
+		l->video_out.type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
+		l->video_out.stfcamss = stfcamss;
+		l->id = i;
+		l->sdev_type = STF_SUBDEV_TYPE_VIN;
+		l->formats = vin_formats_table[i].fmts;
+		l->nformats = vin_formats_table[i].nfmts;
+		spin_lock_init(&l->output_lock);
+
+		mutex_init(&l->stream_lock);
+		l->stream_count = 0;
+		mutex_init(&l->power_lock);
+		l->power_count = 0;
+	}
+
+	return 0;
+out:
+	return ret;
+}
+
+static enum link vin_get_link(struct media_entity *entity)
+{
+	struct v4l2_subdev *subdev;
+	struct media_pad *pad;
+	bool isp = false;
+
+	while (1) {
+		pad = &entity->pads[0];
+		if (!(pad->flags & MEDIA_PAD_FL_SINK))
+			return LINK_ERROR;
+
+		pad = media_pad_remote_pad_first(pad);
+		if (!pad || !is_media_entity_v4l2_subdev(pad->entity))
+			return LINK_ERROR;
+
+		entity = pad->entity;
+		subdev = media_entity_to_v4l2_subdev(entity);
+
+		if (!strncmp(subdev->name, STF_CSI_NAME,
+			     strlen(STF_CSI_NAME))) {
+			if (isp)
+				return LINK_CSI_TO_ISP;
+			else
+				return LINK_CSI_TO_WR;
+		} else if (!strncmp(subdev->name, STF_DVP_NAME,
+				    strlen(STF_DVP_NAME))) {
+			if (isp)
+				return LINK_DVP_TO_ISP;
+			else
+				return LINK_DVP_TO_WR;
+		} else if (!strncmp(subdev->name, STF_ISP_NAME,
+				    strlen(STF_ISP_NAME))) {
+			isp = true;
+		} else {
+			return LINK_ERROR;
+		}
+	}
+}
+
+static int vin_set_power(struct v4l2_subdev *sd, int on)
+{
+	struct vin_line *line = v4l2_get_subdevdata(sd);
+	struct stf_vin_dev *vin_dev = line_to_vin_dev(line);
+	struct stfcamss *stfcamss = vin_dev->stfcamss;
+	enum link link;
+
+	mutex_lock(&line->power_lock);
+	if (on) {
+		if (line->power_count == 0)
+			vin_init_outputs(line);
+		line->power_count++;
+	} else {
+		if (line->power_count == 0) {
+			dev_err(stfcamss->dev,
+				"line power off on power_count = 0\n");
+			goto exit_line;
+		}
+		line->power_count--;
+	}
+exit_line:
+	mutex_unlock(&line->power_lock);
+
+	mutex_lock(&vin_dev->power_lock);
+	link = vin_get_link(&sd->entity);
+	if (link == LINK_ERROR)
+		goto exit;
+
+	if (on) {
+		if (vin_dev->power_count == 0) {
+			pm_runtime_get_sync(stfcamss->dev);
+			stf_vin_clk_enable(vin_dev, link);
+		}
+		vin_dev->power_count++;
+	} else {
+		if (vin_dev->power_count == 0) {
+			dev_err(stfcamss->dev,
+				"vin_dev power off on power_count=0\n");
+			goto exit;
+		}
+		if (vin_dev->power_count == 1) {
+			stf_vin_clk_disable(vin_dev, link);
+			pm_runtime_put_sync(stfcamss->dev);
+		}
+		vin_dev->power_count--;
+	}
+exit:
+
+	mutex_unlock(&vin_dev->power_lock);
+
+	return 0;
+}
+
+static int vin_enable_output(struct vin_line *line)
+{
+	struct vin_output *output = &line->output;
+	unsigned long flags;
+
+	spin_lock_irqsave(&line->output_lock, flags);
+
+	output->state = VIN_OUTPUT_IDLE;
+
+	output->buf[0] = vin_buf_get_pending(output);
+
+	if (!output->buf[0] && output->buf[1]) {
+		output->buf[0] = output->buf[1];
+		output->buf[1] = NULL;
+	}
+
+	if (output->buf[0])
+		output->state = VIN_OUTPUT_SINGLE;
+
+	output->sequence = 0;
+
+	vin_output_init_addrs(line);
+	spin_unlock_irqrestore(&line->output_lock, flags);
+	return 0;
+}
+
+static int vin_disable_output(struct vin_line *line)
+{
+	struct vin_output *output = &line->output;
+	unsigned long flags;
+
+	spin_lock_irqsave(&line->output_lock, flags);
+
+	output->state = VIN_OUTPUT_OFF;
+
+	spin_unlock_irqrestore(&line->output_lock, flags);
+	return 0;
+}
+
+static u32 vin_line_to_dummy_module(struct vin_line *line)
+{
+	u32 dummy_module = 0;
+
+	switch (line->id) {
+	case VIN_LINE_WR:
+		dummy_module = STF_DUMMY_VIN;
+		break;
+	case VIN_LINE_ISP:
+		dummy_module = STF_DUMMY_ISP;
+		break;
+	default:
+		dummy_module = STF_DUMMY_VIN;
+		break;
+	}
+
+	return dummy_module;
+}
+
+static int vin_alloc_dummy_buffer(struct stf_vin_dev *vin_dev,
+				  struct v4l2_mbus_framefmt *fmt,
+				  int dummy_module)
+{
+	struct device *dev = vin_dev->stfcamss->dev;
+	struct dummy_buffer *dummy_buffer =
+				&vin_dev->dummy_buffer[dummy_module];
+	struct vin_dummy_buffer *buffer = NULL;
+	int ret = 0, i;
+	u32 aligns;
+
+	for (i = 0; i < dummy_buffer->nums; i++) {
+		buffer = &vin_dev->dummy_buffer[dummy_module].buffer[i];
+		buffer->width = fmt->width;
+		buffer->height = fmt->height;
+		buffer->mcode = fmt->code;
+		if (i == STF_VIN_PAD_SINK) {
+			aligns = ALIGN(fmt->width * 4,
+				       STFCAMSS_FRAME_WIDTH_ALIGN_8);
+			buffer->buffer_size = PAGE_ALIGN(aligns * fmt->height);
+		} else if (i == STF_ISP_PAD_SRC) {
+			aligns = ALIGN(fmt->width,
+				       STFCAMSS_FRAME_WIDTH_ALIGN_8);
+			buffer->buffer_size =
+				PAGE_ALIGN(aligns * fmt->height * 3 / 2);
+		} else {
+			continue;
+		}
+
+		buffer->vaddr = dma_alloc_coherent(dev,
+						   buffer->buffer_size,
+						   &buffer->paddr[0],
+						   GFP_DMA | GFP_KERNEL);
+
+		if (buffer->vaddr) {
+			if (i == STF_ISP_PAD_SRC)
+				buffer->paddr[1] =
+					(dma_addr_t)(buffer->paddr[0] + aligns * fmt->height);
+			else
+				dev_dbg(dev, "signal plane\n");
+		}
+	}
+
+	return ret;
+}
+
+static void vin_free_dummy_buffer(struct stf_vin_dev *vin_dev, int dummy_module)
+{
+	struct device *dev = vin_dev->stfcamss->dev;
+	struct dummy_buffer *dummy_buffer =
+		&vin_dev->dummy_buffer[dummy_module];
+	struct vin_dummy_buffer *buffer = NULL;
+	int i;
+
+	for (i = 0; i < dummy_buffer->nums; i++) {
+		buffer = &dummy_buffer->buffer[i];
+		if (buffer->vaddr)
+			dma_free_coherent(dev, buffer->buffer_size,
+					  buffer->vaddr, buffer->paddr[0]);
+		memset(buffer, 0, sizeof(struct vin_dummy_buffer));
+	}
+}
+
+static void vin_set_dummy_buffer(struct vin_line *line, u32 pad)
+{
+	struct stf_vin_dev *vin_dev = line_to_vin_dev(line);
+	int dummy_module = vin_line_to_dummy_module(line);
+	struct dummy_buffer *dummy_buffer =
+		&vin_dev->dummy_buffer[dummy_module];
+	struct vin_dummy_buffer *buffer = NULL;
+
+	switch (pad) {
+	case STF_VIN_PAD_SINK:
+		if (line->id == VIN_LINE_WR) {
+			buffer = &dummy_buffer->buffer[STF_VIN_PAD_SINK];
+			stf_vin_wr_set_ping_addr(vin_dev, buffer->paddr[0]);
+			stf_vin_wr_set_pong_addr(vin_dev, buffer->paddr[0]);
+		} else {
+			buffer = &dummy_buffer->buffer[STF_ISP_PAD_SRC];
+			stf_vin_isp_set_yuv_addr(vin_dev,
+						 buffer->paddr[0],
+						 buffer->paddr[1]);
+		}
+		break;
+	case STF_ISP_PAD_SRC:
+		buffer = &dummy_buffer->buffer[STF_ISP_PAD_SRC];
+		stf_vin_isp_set_yuv_addr(vin_dev,
+					 buffer->paddr[0],
+					 buffer->paddr[1]);
+		break;
+	default:
+		break;
+	}
+}
+
+static int vin_set_stream(struct v4l2_subdev *sd, int enable)
+{
+	struct vin_line *line = v4l2_get_subdevdata(sd);
+	struct stf_vin_dev *vin_dev = line_to_vin_dev(line);
+	int dummy_module = vin_line_to_dummy_module(line);
+	struct dummy_buffer *dummy_buffer =
+		&vin_dev->dummy_buffer[dummy_module];
+	struct v4l2_mbus_framefmt *fmt;
+	enum link link;
+
+	fmt = __vin_get_format(line, NULL,
+			       STF_VIN_PAD_SINK, V4L2_SUBDEV_FORMAT_ACTIVE);
+	mutex_lock(&dummy_buffer->stream_lock);
+	if (enable) {
+		if (dummy_buffer->stream_count == 0) {
+			vin_alloc_dummy_buffer(vin_dev, fmt, dummy_module);
+			vin_set_dummy_buffer(line, STF_VIN_PAD_SINK);
+			atomic_set(&dummy_buffer->frame_skip,
+				   VIN_FRAME_DROP_MIN_VAL + 30);
+		}
+		dummy_buffer->stream_count++;
+	} else {
+		if (dummy_buffer->stream_count == 1) {
+			vin_free_dummy_buffer(vin_dev, dummy_module);
+			/* set buffer addr to zero */
+			vin_set_dummy_buffer(line, STF_VIN_PAD_SINK);
+		} else {
+			vin_set_dummy_buffer(line,
+				stf_vin_map_isp_pad(line->id, STF_ISP_PAD_SINK));
+		}
+
+		dummy_buffer->stream_count--;
+	}
+	mutex_unlock(&dummy_buffer->stream_lock);
+
+	mutex_lock(&line->stream_lock);
+	link = vin_get_link(&sd->entity);
+	if (link == LINK_ERROR)
+		goto exit;
+
+	if (enable) {
+		if (line->stream_count == 0) {
+			stf_vin_stream_set(vin_dev, link);
+			if (line->id == VIN_LINE_WR) {
+				stf_vin_wr_irq_enable(vin_dev, 1);
+				stf_vin_wr_stream_set(vin_dev);
+			}
+		}
+		line->stream_count++;
+	} else {
+		if (line->stream_count == 1 && line->id == VIN_LINE_WR)
+			stf_vin_wr_irq_enable(vin_dev, 0);
+		line->stream_count--;
+	}
+exit:
+	mutex_unlock(&line->stream_lock);
+
+	if (enable)
+		vin_enable_output(line);
+	else
+		vin_disable_output(line);
+
+	return 0;
+}
+
+static struct v4l2_mbus_framefmt *
+__vin_get_format(struct vin_line *line,
+		 struct v4l2_subdev_state *state,
+		 unsigned int pad,
+		 enum v4l2_subdev_format_whence which)
+{
+	if (which == V4L2_SUBDEV_FORMAT_TRY)
+		return v4l2_subdev_get_try_format(&line->subdev, state, pad);
+	return &line->fmt[pad];
+}
+
+static void vin_try_format(struct vin_line *line,
+			   struct v4l2_subdev_state *state,
+			   unsigned int pad,
+			   struct v4l2_mbus_framefmt *fmt,
+			   enum v4l2_subdev_format_whence which)
+{
+	unsigned int i;
+
+	switch (pad) {
+	case STF_VIN_PAD_SINK:
+		/* Set format on sink pad */
+		for (i = 0; i < line->nformats; i++)
+			if (fmt->code == line->formats[i].code)
+				break;
+
+		/* If not found, use UYVY as default */
+		if (i >= line->nformats)
+			fmt->code = line->formats[0].code;
+
+		fmt->width = clamp_t(u32, fmt->width,
+				     STFCAMSS_FRAME_MIN_WIDTH,
+				     STFCAMSS_FRAME_MAX_WIDTH);
+		fmt->height = clamp_t(u32, fmt->height,
+				      STFCAMSS_FRAME_MIN_HEIGHT,
+				      STFCAMSS_FRAME_MAX_HEIGHT);
+
+		fmt->field = V4L2_FIELD_NONE;
+		fmt->colorspace = V4L2_COLORSPACE_SRGB;
+		fmt->flags = 0;
+		break;
+
+	case STF_VIN_PAD_SRC:
+		/* Set and return a format same as sink pad */
+		*fmt = *__vin_get_format(line, state, STF_VIN_PAD_SINK, which);
+		break;
+	}
+
+	fmt->colorspace = V4L2_COLORSPACE_SRGB;
+}
+
+static int vin_enum_mbus_code(struct v4l2_subdev *sd,
+			      struct v4l2_subdev_state *state,
+			      struct v4l2_subdev_mbus_code_enum *code)
+{
+	struct vin_line *line = v4l2_get_subdevdata(sd);
+
+	if (code->index >= line->nformats)
+		return -EINVAL;
+	if (code->pad == STF_VIN_PAD_SINK) {
+		code->code = line->formats[code->index].code;
+	} else {
+		struct v4l2_mbus_framefmt *sink_fmt;
+
+		sink_fmt = __vin_get_format(line, state, STF_VIN_PAD_SINK,
+					    code->which);
+
+		code->code = sink_fmt->code;
+		if (!code->code)
+			return -EINVAL;
+	}
+	code->flags = 0;
+
+	return 0;
+}
+
+static int vin_enum_frame_size(struct v4l2_subdev *sd,
+			       struct v4l2_subdev_state *state,
+			       struct v4l2_subdev_frame_size_enum *fse)
+{
+	struct vin_line *line = v4l2_get_subdevdata(sd);
+	struct v4l2_mbus_framefmt format;
+
+	if (fse->index != 0)
+		return -EINVAL;
+
+	format.code = fse->code;
+	format.width = 1;
+	format.height = 1;
+	vin_try_format(line, state, fse->pad, &format, fse->which);
+	fse->min_width = format.width;
+	fse->min_height = format.height;
+
+	if (format.code != fse->code)
+		return -EINVAL;
+
+	format.code = fse->code;
+	format.width = -1;
+	format.height = -1;
+	vin_try_format(line, state, fse->pad, &format, fse->which);
+	fse->max_width = format.width;
+	fse->max_height = format.height;
+
+	return 0;
+}
+
+static int vin_get_format(struct v4l2_subdev *sd,
+			  struct v4l2_subdev_state *state,
+			  struct v4l2_subdev_format *fmt)
+{
+	struct vin_line *line = v4l2_get_subdevdata(sd);
+	struct v4l2_mbus_framefmt *format;
+
+	format = __vin_get_format(line, state, fmt->pad, fmt->which);
+	if (!format)
+		return -EINVAL;
+
+	fmt->format = *format;
+
+	return 0;
+}
+
+static int vin_set_format(struct v4l2_subdev *sd,
+			  struct v4l2_subdev_state *state,
+			  struct v4l2_subdev_format *fmt)
+{
+	struct vin_line *line = v4l2_get_subdevdata(sd);
+	struct v4l2_mbus_framefmt *format;
+
+	format = __vin_get_format(line, state, fmt->pad, fmt->which);
+	if (!format)
+		return -EINVAL;
+
+	mutex_lock(&line->stream_lock);
+	if (line->stream_count) {
+		fmt->format = *format;
+		mutex_unlock(&line->stream_lock);
+		goto out;
+	} else {
+		vin_try_format(line, state, fmt->pad, &fmt->format, fmt->which);
+		*format = fmt->format;
+	}
+	mutex_unlock(&line->stream_lock);
+
+	if (fmt->pad == STF_VIN_PAD_SINK) {
+		/* Propagate the format from sink to source */
+		format = __vin_get_format(line, state, STF_VIN_PAD_SRC,
+					  fmt->which);
+
+		*format = fmt->format;
+		vin_try_format(line, state, STF_VIN_PAD_SRC, format,
+			       fmt->which);
+	}
+
+out:
+	return 0;
+}
+
+static int vin_init_formats(struct v4l2_subdev *sd,
+			    struct v4l2_subdev_fh *fh)
+{
+	struct v4l2_subdev_format format = {
+		.pad = STF_VIN_PAD_SINK,
+		.which = fh ?
+			 V4L2_SUBDEV_FORMAT_TRY : V4L2_SUBDEV_FORMAT_ACTIVE,
+		.format = {
+			.code = MEDIA_BUS_FMT_RGB565_2X8_LE,
+			.width = 1920,
+			.height = 1080
+		}
+	};
+
+	return vin_set_format(sd, fh ? fh->state : NULL, &format);
+}
+
+static void vin_output_init_addrs(struct vin_line *line)
+{
+	struct vin_output *output = &line->output;
+	struct stf_vin_dev *vin_dev = line_to_vin_dev(line);
+	dma_addr_t ping_addr;
+	dma_addr_t y_addr, uv_addr;
+
+	output->active_buf = 0;
+
+	if (output->buf[0]) {
+		ping_addr = output->buf[0]->addr[0];
+		y_addr = output->buf[0]->addr[0];
+		uv_addr = output->buf[0]->addr[1];
+	} else {
+		return;
+	}
+
+	switch (vin_map_isp_line(line->id)) {
+	case STF_ISP_LINE_SRC:
+		stf_vin_isp_set_yuv_addr(vin_dev, y_addr, uv_addr);
+		break;
+	default:
+		if (line->id == VIN_LINE_WR) {
+			stf_vin_wr_set_ping_addr(vin_dev, ping_addr);
+			stf_vin_wr_set_pong_addr(vin_dev, ping_addr);
+		}
+		break;
+	}
+}
+
+static void vin_init_outputs(struct vin_line *line)
+{
+	struct vin_output *output = &line->output;
+
+	output->state = VIN_OUTPUT_OFF;
+	output->buf[0] = NULL;
+	output->buf[1] = NULL;
+	output->active_buf = 0;
+	INIT_LIST_HEAD(&output->pending_bufs);
+	INIT_LIST_HEAD(&output->ready_bufs);
+}
+
+static void vin_buf_add_ready(struct vin_output *output,
+			      struct stfcamss_buffer *buffer)
+{
+	INIT_LIST_HEAD(&buffer->queue);
+	list_add_tail(&buffer->queue, &output->ready_bufs);
+}
+
+static struct stfcamss_buffer *vin_buf_get_ready(struct vin_output *output)
+{
+	struct stfcamss_buffer *buffer = NULL;
+
+	if (!list_empty(&output->ready_bufs)) {
+		buffer = list_first_entry(&output->ready_bufs,
+					  struct stfcamss_buffer,
+					  queue);
+		list_del(&buffer->queue);
+	}
+
+	return buffer;
+}
+
+static void vin_buf_add_pending(struct vin_output *output,
+				struct stfcamss_buffer *buffer)
+{
+	INIT_LIST_HEAD(&buffer->queue);
+	list_add_tail(&buffer->queue, &output->pending_bufs);
+}
+
+static struct stfcamss_buffer *vin_buf_get_pending(struct vin_output *output)
+{
+	struct stfcamss_buffer *buffer = NULL;
+
+	if (!list_empty(&output->pending_bufs)) {
+		buffer = list_first_entry(&output->pending_bufs,
+					  struct stfcamss_buffer,
+					  queue);
+		list_del(&buffer->queue);
+	}
+
+	return buffer;
+}
+
+static void vin_buf_update_on_last(struct vin_line *line)
+{
+	struct vin_output *output = &line->output;
+
+	switch (output->state) {
+	case VIN_OUTPUT_CONTINUOUS:
+		output->state = VIN_OUTPUT_SINGLE;
+		output->active_buf = !output->active_buf;
+		break;
+	case VIN_OUTPUT_SINGLE:
+		output->state = VIN_OUTPUT_STOPPING;
+		break;
+	default:
+		break;
+	}
+}
+
+static void vin_buf_update_on_next(struct vin_line *line)
+{
+	struct vin_output *output = &line->output;
+
+	switch (output->state) {
+	case VIN_OUTPUT_CONTINUOUS:
+		output->active_buf = !output->active_buf;
+		break;
+	case VIN_OUTPUT_SINGLE:
+	default:
+		break;
+	}
+}
+
+static void vin_buf_update_on_new(struct vin_line *line,
+				  struct vin_output *output,
+				  struct stfcamss_buffer *new_buf)
+{
+	switch (output->state) {
+	case VIN_OUTPUT_SINGLE:
+		vin_buf_add_pending(output, new_buf);
+		break;
+	case VIN_OUTPUT_IDLE:
+		if (!output->buf[0]) {
+			output->buf[0] = new_buf;
+			vin_output_init_addrs(line);
+			output->state = VIN_OUTPUT_SINGLE;
+		} else {
+			vin_buf_add_pending(output, new_buf);
+		}
+		break;
+	case VIN_OUTPUT_STOPPING:
+		if (output->last_buffer) {
+			output->buf[output->active_buf] = output->last_buffer;
+			output->last_buffer = NULL;
+		}
+
+		output->state = VIN_OUTPUT_SINGLE;
+		vin_buf_add_pending(output, new_buf);
+		break;
+	case VIN_OUTPUT_CONTINUOUS:
+	default:
+		vin_buf_add_pending(output, new_buf);
+		break;
+	}
+}
+
+static void vin_buf_flush(struct vin_output *output,
+			  enum vb2_buffer_state state)
+{
+	struct stfcamss_buffer *buf;
+	struct stfcamss_buffer *t;
+
+	list_for_each_entry_safe(buf, t, &output->pending_bufs, queue) {
+		vb2_buffer_done(&buf->vb.vb2_buf, state);
+		list_del(&buf->queue);
+	}
+	list_for_each_entry_safe(buf, t, &output->ready_bufs, queue) {
+		vb2_buffer_done(&buf->vb.vb2_buf, state);
+		list_del(&buf->queue);
+	}
+}
+
+static void vin_buffer_done(struct vin_line *line)
+{
+	struct stfcamss_buffer *ready_buf;
+	struct vin_output *output = &line->output;
+	unsigned long flags;
+	u64 ts = ktime_get_ns();
+
+	if (output->state == VIN_OUTPUT_OFF ||
+	    output->state == VIN_OUTPUT_RESERVED)
+		return;
+
+	spin_lock_irqsave(&line->output_lock, flags);
+
+	while ((ready_buf = vin_buf_get_ready(output))) {
+		ready_buf->vb.vb2_buf.timestamp = ts;
+		ready_buf->vb.sequence = output->sequence++;
+
+		vb2_buffer_done(&ready_buf->vb.vb2_buf, VB2_BUF_STATE_DONE);
+	}
+
+	spin_unlock_irqrestore(&line->output_lock, flags);
+}
+
+static void vin_change_buffer(struct vin_line *line)
+{
+	struct stfcamss_buffer *ready_buf;
+	struct vin_output *output = &line->output;
+	struct stf_vin_dev *vin_dev = line_to_vin_dev(line);
+	dma_addr_t *new_addr;
+	unsigned long flags;
+	u32 active_index;
+
+	if (output->state == VIN_OUTPUT_OFF ||
+	    output->state == VIN_OUTPUT_STOPPING ||
+	    output->state == VIN_OUTPUT_RESERVED ||
+	    output->state == VIN_OUTPUT_IDLE)
+		return;
+
+	spin_lock_irqsave(&line->output_lock, flags);
+
+	active_index = output->active_buf;
+
+	ready_buf = output->buf[active_index];
+	if (!ready_buf) {
+		dev_warn(vin_dev->stfcamss->dev, "Missing ready buf %d %d!\n",
+			 active_index, output->state);
+		active_index = !active_index;
+		ready_buf = output->buf[active_index];
+		if (!ready_buf) {
+			dev_err(vin_dev->stfcamss->dev,
+				"Missing ready buf2 %d %d!\n",
+				active_index, output->state);
+			goto out_unlock;
+		}
+	}
+
+	/* Get next buffer */
+	output->buf[active_index] = vin_buf_get_pending(output);
+	if (!output->buf[active_index]) {
+		/* No next buffer - set same address */
+		new_addr = ready_buf->addr;
+		vin_buf_update_on_last(line);
+	} else {
+		new_addr = output->buf[active_index]->addr;
+		vin_buf_update_on_next(line);
+	}
+
+	if (output->state == VIN_OUTPUT_STOPPING) {
+		output->last_buffer = ready_buf;
+	} else {
+		switch (vin_map_isp_line(line->id)) {
+		case STF_ISP_LINE_SRC:
+			stf_vin_isp_set_yuv_addr(vin_dev,
+						 new_addr[0],
+						 new_addr[1]);
+			break;
+		default:
+			if (line->id == VIN_LINE_WR) {
+				stf_vin_wr_set_ping_addr(vin_dev, new_addr[0]);
+				stf_vin_wr_set_pong_addr(vin_dev, new_addr[0]);
+			}
+			break;
+		}
+
+		vin_buf_add_ready(output, ready_buf);
+	}
+
+	spin_unlock_irqrestore(&line->output_lock, flags);
+	return;
+
+out_unlock:
+	spin_unlock_irqrestore(&line->output_lock, flags);
+}
+
+static int vin_queue_buffer(struct stfcamss_video *vid,
+			    struct stfcamss_buffer *buf)
+{
+	struct vin_line *line = container_of(vid, struct vin_line, video_out);
+	struct vin_output *output;
+	unsigned long flags;
+
+	output = &line->output;
+
+	spin_lock_irqsave(&line->output_lock, flags);
+
+	vin_buf_update_on_new(line, output, buf);
+
+	spin_unlock_irqrestore(&line->output_lock, flags);
+
+	return 0;
+}
+
+static int vin_flush_buffers(struct stfcamss_video *vid,
+			     enum vb2_buffer_state state)
+{
+	struct vin_line *line = container_of(vid, struct vin_line, video_out);
+	struct vin_output *output = &line->output;
+	unsigned long flags;
+
+	spin_lock_irqsave(&line->output_lock, flags);
+
+	vin_buf_flush(output, state);
+	if (output->buf[0])
+		vb2_buffer_done(&output->buf[0]->vb.vb2_buf, state);
+
+	if (output->buf[1])
+		vb2_buffer_done(&output->buf[1]->vb.vb2_buf, state);
+
+	if (output->last_buffer) {
+		vb2_buffer_done(&output->last_buffer->vb.vb2_buf, state);
+		output->last_buffer = NULL;
+	}
+	output->buf[0] = NULL;
+	output->buf[1] = NULL;
+
+	spin_unlock_irqrestore(&line->output_lock, flags);
+	return 0;
+}
+
+static int vin_link_setup(struct media_entity *entity,
+			  const struct media_pad *local,
+			  const struct media_pad *remote, u32 flags)
+{
+	if (flags & MEDIA_LNK_FL_ENABLED)
+		if (media_pad_remote_pad_first(local))
+			return -EBUSY;
+	return 0;
+}
+
+static const struct v4l2_subdev_core_ops vin_core_ops = {
+	.s_power = vin_set_power,
+};
+
+static const struct v4l2_subdev_video_ops vin_video_ops = {
+	.s_stream = vin_set_stream,
+};
+
+static const struct v4l2_subdev_pad_ops vin_pad_ops = {
+	.enum_mbus_code   = vin_enum_mbus_code,
+	.enum_frame_size  = vin_enum_frame_size,
+	.get_fmt          = vin_get_format,
+	.set_fmt          = vin_set_format,
+};
+
+static const struct v4l2_subdev_ops vin_v4l2_ops = {
+	.core = &vin_core_ops,
+	.video = &vin_video_ops,
+	.pad = &vin_pad_ops,
+};
+
+static const struct v4l2_subdev_internal_ops vin_v4l2_internal_ops = {
+	.open = vin_init_formats,
+};
+
+static const struct stfcamss_video_ops stfcamss_vin_video_ops = {
+	.queue_buffer = vin_queue_buffer,
+	.flush_buffers = vin_flush_buffers,
+};
+
+static const struct media_entity_operations vin_media_ops = {
+	.link_setup = vin_link_setup,
+	.link_validate = v4l2_subdev_link_validate,
+};
+
+int stf_vin_register(struct stf_vin_dev *vin_dev, struct v4l2_device *v4l2_dev)
+{
+	struct v4l2_subdev *sd;
+	struct stfcamss_video *video_out;
+	struct media_pad *pads;
+	int ret;
+	int i;
+
+	for (i = 0; i < STF_ISP_LINE_MAX + 1; i++) {
+		char name[32];
+		char *sub_name = vin_get_line_subdevname(i);
+
+		sd = &vin_dev->line[i].subdev;
+		pads = vin_dev->line[i].pads;
+		video_out = &vin_dev->line[i].video_out;
+		video_out->id = i;
+
+		v4l2_subdev_init(sd, &vin_v4l2_ops);
+		sd->internal_ops = &vin_v4l2_internal_ops;
+		sd->flags |= V4L2_SUBDEV_FL_HAS_DEVNODE;
+		snprintf(sd->name, ARRAY_SIZE(sd->name), "%s%d_%s",
+			 STF_VIN_NAME, 0, sub_name);
+		v4l2_set_subdevdata(sd, &vin_dev->line[i]);
+
+		ret = vin_init_formats(sd, NULL);
+		if (ret < 0) {
+			dev_err(vin_dev->stfcamss->dev,
+				"Failed to init format: %d\n", ret);
+			goto err_init;
+		}
+
+		pads[STF_VIN_PAD_SINK].flags = MEDIA_PAD_FL_SINK;
+		pads[STF_VIN_PAD_SRC].flags = MEDIA_PAD_FL_SOURCE;
+
+		sd->entity.function =
+			MEDIA_ENT_F_PROC_VIDEO_PIXEL_FORMATTER;
+		sd->entity.ops = &vin_media_ops;
+		ret = media_entity_pads_init(&sd->entity,
+					     STF_VIN_PADS_NUM, pads);
+		if (ret < 0) {
+			dev_err(vin_dev->stfcamss->dev,
+				"Failed to init media entity: %d\n",
+				ret);
+			goto err_init;
+		}
+
+		ret = v4l2_device_register_subdev(v4l2_dev, sd);
+		if (ret < 0) {
+			dev_err(vin_dev->stfcamss->dev,
+				"Failed to register subdev: %d\n", ret);
+			goto err_reg_subdev;
+		}
+
+		video_out->ops = &stfcamss_vin_video_ops;
+		video_out->bpl_alignment = 16 * 8;
+
+		snprintf(name, ARRAY_SIZE(name), "%s_%s%d",
+			 sd->name, "video", i);
+		ret = stf_video_register(video_out, v4l2_dev, name);
+		if (ret < 0) {
+			dev_err(vin_dev->stfcamss->dev,
+				"Failed to register video node: %d\n", ret);
+			goto err_vid_reg;
+		}
+
+		ret = media_create_pad_link(
+			&sd->entity, STF_VIN_PAD_SRC,
+			&video_out->vdev.entity, 0,
+			MEDIA_LNK_FL_IMMUTABLE | MEDIA_LNK_FL_ENABLED);
+		if (ret < 0) {
+			dev_err(vin_dev->stfcamss->dev,
+				"Failed to link %s->%s entities: %d\n",
+				sd->entity.name, video_out->vdev.entity.name,
+				ret);
+			goto err_create_link;
+		}
+	}
+
+	return 0;
+
+err_create_link:
+	stf_video_unregister(video_out);
+err_vid_reg:
+	v4l2_device_unregister_subdev(sd);
+err_reg_subdev:
+	media_entity_cleanup(&sd->entity);
+err_init:
+	for (i--; i >= 0; i--) {
+		sd = &vin_dev->line[i].subdev;
+		video_out = &vin_dev->line[i].video_out;
+
+		stf_video_unregister(video_out);
+		v4l2_device_unregister_subdev(sd);
+		media_entity_cleanup(&sd->entity);
+	}
+	return ret;
+}
+
+int stf_vin_unregister(struct stf_vin_dev *vin_dev)
+{
+	struct v4l2_subdev *sd;
+	struct stfcamss_video *video_out;
+	int i;
+
+	mutex_destroy(&vin_dev->power_lock);
+	for (i = 0; i < STF_DUMMY_MODULE_NUMS; i++)
+		mutex_destroy(&vin_dev->dummy_buffer[i].stream_lock);
+
+	for (i = 0; i < STF_ISP_LINE_MAX + 1; i++) {
+		sd = &vin_dev->line[i].subdev;
+		video_out = &vin_dev->line[i].video_out;
+
+		stf_video_unregister(video_out);
+		v4l2_device_unregister_subdev(sd);
+		media_entity_cleanup(&sd->entity);
+		mutex_destroy(&vin_dev->line[i].stream_lock);
+		mutex_destroy(&vin_dev->line[i].power_lock);
+	}
+	return 0;
+}
diff --git a/drivers/media/platform/starfive/stf_vin.h b/drivers/media/platform/starfive/stf_vin.h
new file mode 100644
index 000000000000..9db71d09e044
--- /dev/null
+++ b/drivers/media/platform/starfive/stf_vin.h
@@ -0,0 +1,180 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * stf_vin.h
+ *
+ * StarFive Camera Subsystem - VIN Module
+ *
+ * Copyright (C) 2021-2023 StarFive Technology Co., Ltd.
+ */
+
+#ifndef STF_VIN_H
+#define STF_VIN_H
+
+#include <linux/interrupt.h>
+#include <linux/spinlock_types.h>
+#include <media/v4l2-subdev.h>
+
+#include "stf_video.h"
+
+#define SYSCONSAIF_SYSCFG(x)	(x)
+
+/* syscon offset 0 */
+#define U0_VIN_CNFG_AXI_DVP_EN	BIT(2)
+
+/* syscon offset 20 */
+#define U0_VIN_CHANNEL_SEL_MASK	GENMASK(3, 0)
+#define U0_VIN_AXIWR0_EN	BIT(4)
+#define CHANNEL(x)	((x) << 0)
+
+/* syscon offset 32 */
+#define U0_VIN_INTR_CLEAN	BIT(0)
+#define U0_VIN_INTR_M	BIT(1)
+#define U0_VIN_PIX_CNT_END_MASK	GENMASK(12, 2)
+#define U0_VIN_PIX_CT_MASK	GENMASK(14, 13)
+#define U0_VIN_PIXEL_HEIGH_BIT_SEL_MAKS	GENMASK(16, 15)
+
+#define PIX_CNT_END(x)	((x) << 2)
+#define PIX_CT(x)	((x) << 13)
+#define PIXEL_HEIGH_BIT_SEL(x)	((x) << 15)
+
+/* syscon offset 36 */
+#define U0_VIN_CNFG_DVP_HS_POS	BIT(1)
+#define U0_VIN_CNFG_DVP_SWAP_EN	BIT(2)
+#define U0_VIN_CNFG_DVP_VS_POS	BIT(3)
+#define U0_VIN_CNFG_GEN_EN_AXIRD	BIT(4)
+#define U0_VIN_CNFG_ISP_DVP_EN0		BIT(5)
+#define U0_VIN_MIPI_BYTE_EN_ISP0(n)	((n) << 6)
+#define U0_VIN_MIPI_CHANNEL_SEL0(n)	((n) << 8)
+#define U0_VIN_P_I_MIPI_HAEDER_EN0(n)	((n) << 12)
+#define U0_VIN_PIX_NUM(n)	((n) << 13)
+#define U0_VIN_MIPI_BYTE_EN_ISP0_MASK	GENMASK(7, 6)
+#define U0_VIN_MIPI_CHANNEL_SEL0_MASK	GENMASK(11, 8)
+#define U0_VIN_P_I_MIPI_HAEDER_EN0_MASK	BIT(12)
+#define U0_VIN_PIX_NUM_MASK	GENMASK(16, 13)
+
+#define STF_VIN_PAD_SINK   0
+#define STF_VIN_PAD_SRC    1
+#define STF_VIN_PADS_NUM   2
+
+#define ISP_DUMMY_BUFFER_NUMS  STF_ISP_PAD_MAX
+#define VIN_DUMMY_BUFFER_NUMS  1
+
+enum {
+	STF_DUMMY_VIN,
+	STF_DUMMY_ISP,
+	STF_DUMMY_MODULE_NUMS,
+};
+
+enum link {
+	LINK_ERROR = -1,
+	LINK_DVP_TO_WR,
+	LINK_DVP_TO_ISP,
+	LINK_CSI_TO_WR,
+	LINK_CSI_TO_ISP,
+};
+
+struct vin_format {
+	u32 code;
+	u8 bpp;
+};
+
+struct vin_format_table {
+	const struct vin_format *fmts;
+	int nfmts;
+};
+
+enum vin_output_state {
+	VIN_OUTPUT_OFF,
+	VIN_OUTPUT_RESERVED,
+	VIN_OUTPUT_SINGLE,
+	VIN_OUTPUT_CONTINUOUS,
+	VIN_OUTPUT_IDLE,
+	VIN_OUTPUT_STOPPING
+};
+
+struct vin_output {
+	int active_buf;
+	struct stfcamss_buffer *buf[2];
+	struct stfcamss_buffer *last_buffer;
+	struct list_head pending_bufs;
+	struct list_head ready_bufs;
+	enum vin_output_state state;
+	unsigned int sequence;
+	unsigned int frame_skip;
+};
+
+/* The vin output lines */
+enum vin_line_id {
+	VIN_LINE_NONE = -1,
+	VIN_LINE_WR = 0,
+	VIN_LINE_ISP,
+	VIN_LINE_MAX,
+};
+
+struct vin_line {
+	enum stf_subdev_type sdev_type;  /* must be frist */
+	enum vin_line_id id;
+	struct v4l2_subdev subdev;
+	struct media_pad pads[STF_VIN_PADS_NUM];
+	struct v4l2_mbus_framefmt fmt[STF_VIN_PADS_NUM];
+	struct stfcamss_video video_out;
+	struct mutex stream_lock;	/* serialize stream control */
+	int stream_count;
+	struct mutex power_lock; /* serialize pipeline control in power process*/
+	int power_count;
+	struct vin_output output;	/* pipeline and stream states */
+	spinlock_t output_lock;
+	const struct vin_format *formats;
+	unsigned int nformats;
+};
+
+struct vin_dummy_buffer {
+	dma_addr_t paddr[3];
+	void *vaddr;
+	u32 buffer_size;
+	u32 width;
+	u32 height;
+	u32 mcode;
+};
+
+struct dummy_buffer {
+	struct vin_dummy_buffer *buffer;
+	u32 nums;
+	struct mutex stream_lock;	/* protects buffer data */
+	int stream_count;
+	atomic_t frame_skip;
+};
+
+struct vin_isr_ops {
+	void (*isr_buffer_done)(struct vin_line *line);
+	void (*isr_change_buffer)(struct vin_line *line);
+};
+
+struct stf_vin_dev {
+	struct stfcamss *stfcamss;
+	struct vin_line line[VIN_LINE_MAX];
+	struct dummy_buffer dummy_buffer[STF_DUMMY_MODULE_NUMS];
+	struct vin_isr_ops *isr_ops;
+	atomic_t ref_count;
+	struct mutex power_lock;	/* serialize power control*/
+	int power_count;
+};
+
+int stf_vin_clk_enable(struct stf_vin_dev *vin_dev, enum link link);
+int stf_vin_clk_disable(struct stf_vin_dev *vin_dev, enum link link);
+int stf_vin_wr_stream_set(struct stf_vin_dev *vin_dev);
+int stf_vin_stream_set(struct stf_vin_dev *vin_dev, enum link link);
+void stf_vin_wr_irq_enable(struct stf_vin_dev *vin_dev, int enable);
+void stf_vin_wr_set_ping_addr(struct stf_vin_dev *vin_dev, dma_addr_t addr);
+void stf_vin_wr_set_pong_addr(struct stf_vin_dev *vin_dev, dma_addr_t addr);
+void stf_vin_isp_set_yuv_addr(struct stf_vin_dev *vin_dev,
+			      dma_addr_t y_addr, dma_addr_t uv_addr);
+irqreturn_t stf_vin_wr_irq_handler(int irq, void *priv);
+irqreturn_t stf_vin_isp_irq_handler(int irq, void *priv);
+irqreturn_t stf_vin_isp_irq_csiline_handler(int irq, void *priv);
+int stf_vin_subdev_init(struct stfcamss *stfcamss);
+int stf_vin_register(struct stf_vin_dev *vin_dev, struct v4l2_device *v4l2_dev);
+int stf_vin_unregister(struct stf_vin_dev *vin_dev);
+enum isp_pad_id stf_vin_map_isp_pad(enum vin_line_id line, enum isp_pad_id def);
+
+#endif /* STF_VIN_H */
diff --git a/drivers/media/platform/starfive/stf_vin_hw_ops.c b/drivers/media/platform/starfive/stf_vin_hw_ops.c
new file mode 100644
index 000000000000..a4adb5e4ea60
--- /dev/null
+++ b/drivers/media/platform/starfive/stf_vin_hw_ops.c
@@ -0,0 +1,241 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * stf_vin_hw_ops.c
+ *
+ * Register interface file for StarFive VIN module driver
+ *
+ * Copyright (C) 2021-2023 StarFive Technology Co., Ltd.
+ */
+#include "stf_camss.h"
+
+static void vin_intr_clear(struct stfcamss *stfcamss)
+{
+	stf_syscon_reg_set_bit(stfcamss, SYSCONSAIF_SYSCFG(28),
+			       U0_VIN_INTR_CLEAN);
+	stf_syscon_reg_clear_bit(stfcamss, SYSCONSAIF_SYSCFG(28),
+				 U0_VIN_INTR_CLEAN);
+}
+
+irqreturn_t stf_vin_wr_irq_handler(int irq, void *priv)
+{
+	struct stf_vin_dev *vin_dev = priv;
+	struct stfcamss *stfcamss = vin_dev->stfcamss;
+	struct dummy_buffer *dummy_buffer =
+			&vin_dev->dummy_buffer[STF_DUMMY_VIN];
+
+	if (atomic_dec_if_positive(&dummy_buffer->frame_skip) < 0) {
+		vin_dev->isr_ops->isr_change_buffer(&vin_dev->line[VIN_LINE_WR]);
+		vin_dev->isr_ops->isr_buffer_done(&vin_dev->line[VIN_LINE_WR]);
+	}
+
+	vin_intr_clear(stfcamss);
+
+	return IRQ_HANDLED;
+}
+
+irqreturn_t stf_vin_isp_irq_handler(int irq, void *priv)
+{
+	struct stf_vin_dev *vin_dev = priv;
+	u32 int_status;
+
+	int_status = stf_isp_reg_read(vin_dev->stfcamss, ISP_REG_ISP_CTRL_0);
+
+	if (int_status & ISPC_INTS) {
+		if ((int_status & ISPC_ENUO))
+			vin_dev->isr_ops->isr_buffer_done(
+				&vin_dev->line[VIN_LINE_ISP]);
+
+		/* clear interrupt */
+		stf_isp_reg_write(vin_dev->stfcamss,
+				  ISP_REG_ISP_CTRL_0,
+				  (int_status & ~EN_INT_ALL) |
+				  EN_INT_ISP_DONE |
+				  EN_INT_CSI_DONE |
+				  EN_INT_SC_DONE);
+	}
+
+	return IRQ_HANDLED;
+}
+
+irqreturn_t stf_vin_isp_irq_csiline_handler(int irq, void *priv)
+{
+	struct stf_vin_dev *vin_dev = priv;
+	struct stf_isp_dev *isp_dev;
+	u32 int_status;
+
+	isp_dev = &vin_dev->stfcamss->isp_dev;
+
+	int_status = stf_isp_reg_read(vin_dev->stfcamss, ISP_REG_ISP_CTRL_0);
+	if (int_status & ISPC_SCFEINT) {
+		struct dummy_buffer *dummy_buffer =
+			&vin_dev->dummy_buffer[STF_DUMMY_ISP];
+
+		if (atomic_dec_if_positive(&dummy_buffer->frame_skip) < 0) {
+			if ((int_status & ISPC_ENUO))
+				vin_dev->isr_ops->isr_change_buffer(
+					&vin_dev->line[VIN_LINE_ISP]);
+		}
+
+		stf_isp_reg_set_bit(isp_dev->stfcamss, ISP_REG_CSIINTS,
+				    CSI_INTS_MASK, CSI_INTS(0x3));
+		stf_isp_reg_set_bit(isp_dev->stfcamss, ISP_REG_IESHD,
+				    SHAD_UP_M | SHAD_UP_EN, 0x3);
+
+		/* clear interrupt */
+		stf_isp_reg_write(vin_dev->stfcamss, ISP_REG_ISP_CTRL_0,
+				  (int_status & ~EN_INT_ALL) | EN_INT_LINE_INT);
+	}
+
+	return IRQ_HANDLED;
+}
+
+int stf_vin_clk_enable(struct stf_vin_dev *vin_dev, enum link link)
+{
+	struct stfcamss *stfcamss = vin_dev->stfcamss;
+
+	clk_set_rate(stfcamss->sys_clk[STF_CLK_APB_FUNC].clk, 49500000);
+
+	switch (link) {
+	case LINK_CSI_TO_WR:
+		clk_set_rate(stfcamss->sys_clk[STF_CLK_MIPI_RX0_PXL].clk,
+			     198000000);
+		reset_control_deassert(stfcamss->sys_rst[STF_RST_AXIWR].rstc);
+		clk_set_parent(stfcamss->sys_clk[STF_CLK_AXIWR].clk,
+			       stfcamss->sys_clk[STF_CLK_MIPI_RX0_PXL].clk);
+		break;
+	case LINK_CSI_TO_ISP:
+		clk_set_rate(stfcamss->sys_clk[STF_CLK_MIPI_RX0_PXL].clk,
+			     198000000);
+		clk_set_parent(stfcamss->sys_clk[STF_CLK_WRAPPER_CLK_C].clk,
+			       stfcamss->sys_clk[STF_CLK_MIPI_RX0_PXL].clk);
+		break;
+	case LINK_DVP_TO_WR:
+	case LINK_DVP_TO_ISP:
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+int stf_vin_clk_disable(struct stf_vin_dev *vin_dev, enum link link)
+{
+	struct stfcamss *stfcamss = vin_dev->stfcamss;
+
+	switch (link) {
+	case LINK_CSI_TO_WR:
+		reset_control_assert(stfcamss->sys_rst[STF_RST_AXIWR].rstc);
+		break;
+	case LINK_CSI_TO_ISP:
+		break;
+	case LINK_DVP_TO_WR:
+	case LINK_DVP_TO_ISP:
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+int stf_vin_wr_stream_set(struct stf_vin_dev *vin_dev)
+{
+	struct stfcamss *stfcamss = vin_dev->stfcamss;
+
+	/* make the axiwr alway on */
+	stf_syscon_reg_set_bit(stfcamss, SYSCONSAIF_SYSCFG(20),
+			       U0_VIN_AXIWR0_EN);
+
+	return 0;
+}
+
+int stf_vin_stream_set(struct stf_vin_dev *vin_dev, enum link link)
+{
+	struct stfcamss *stfcamss = vin_dev->stfcamss;
+	u32 val;
+
+	switch (link) {
+	case LINK_CSI_TO_WR:
+		val = stf_syscon_reg_read(stfcamss, SYSCONSAIF_SYSCFG(20));
+		val &= ~U0_VIN_CHANNEL_SEL_MASK;
+		val |= CHANNEL(0);
+		stf_syscon_reg_write(stfcamss, SYSCONSAIF_SYSCFG(20), val);
+
+		val = stf_syscon_reg_read(stfcamss, SYSCONSAIF_SYSCFG(28));
+		val &= ~U0_VIN_PIX_CT_MASK;
+		val |= PIX_CT(1);
+
+		val &= ~U0_VIN_PIXEL_HEIGH_BIT_SEL_MAKS;
+		val |= PIXEL_HEIGH_BIT_SEL(0);
+
+		val &= ~U0_VIN_PIX_CNT_END_MASK;
+		val |= PIX_CNT_END(IMAGE_MAX_WIDTH / 4 - 1);
+
+		stf_syscon_reg_write(stfcamss, SYSCONSAIF_SYSCFG(28), val);
+		break;
+	case LINK_CSI_TO_ISP:
+		val = stf_syscon_reg_read(stfcamss, SYSCONSAIF_SYSCFG(36));
+		val &= ~U0_VIN_MIPI_BYTE_EN_ISP0_MASK;
+		val |= U0_VIN_MIPI_BYTE_EN_ISP0(0);
+
+		val &= ~U0_VIN_MIPI_CHANNEL_SEL0_MASK;
+		val |= U0_VIN_MIPI_CHANNEL_SEL0(0);
+
+		val &= ~U0_VIN_PIX_NUM_MASK;
+		val |= U0_VIN_PIX_NUM(0);
+
+		val &= ~U0_VIN_P_I_MIPI_HAEDER_EN0_MASK;
+		val |= U0_VIN_P_I_MIPI_HAEDER_EN0(1);
+
+		stf_syscon_reg_write(stfcamss, SYSCONSAIF_SYSCFG(36), val);
+		break;
+	case LINK_DVP_TO_WR:
+	case LINK_DVP_TO_ISP:
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+void stf_vin_wr_irq_enable(struct stf_vin_dev *vin_dev, int enable)
+{
+	struct stfcamss *stfcamss = vin_dev->stfcamss;
+
+	if (enable) {
+		stf_syscon_reg_clear_bit(stfcamss, SYSCONSAIF_SYSCFG(28),
+					 U0_VIN_INTR_M);
+	} else {
+		/* clear vin interrupt */
+		stf_syscon_reg_set_bit(stfcamss, SYSCONSAIF_SYSCFG(28),
+				       U0_VIN_INTR_CLEAN);
+		stf_syscon_reg_clear_bit(stfcamss, SYSCONSAIF_SYSCFG(28),
+					 U0_VIN_INTR_CLEAN);
+		stf_syscon_reg_set_bit(stfcamss, SYSCONSAIF_SYSCFG(28),
+				       U0_VIN_INTR_M);
+	}
+}
+
+void stf_vin_wr_set_ping_addr(struct stf_vin_dev *vin_dev, dma_addr_t addr)
+{
+	struct stfcamss *stfcamss = vin_dev->stfcamss;
+
+	/* set the start address */
+	stf_syscon_reg_write(stfcamss, SYSCONSAIF_SYSCFG(32), (long)addr);
+}
+
+void stf_vin_wr_set_pong_addr(struct stf_vin_dev *vin_dev, dma_addr_t addr)
+{
+	struct stfcamss *stfcamss = vin_dev->stfcamss;
+
+	/* set the start address */
+	stf_syscon_reg_write(stfcamss, SYSCONSAIF_SYSCFG(24), (long)addr);
+}
+
+void stf_vin_isp_set_yuv_addr(struct stf_vin_dev *vin_dev,
+			      dma_addr_t y_addr, dma_addr_t uv_addr)
+{
+	stf_isp_reg_write(vin_dev->stfcamss,
+			  ISP_REG_Y_PLANE_START_ADDR, y_addr);
+	stf_isp_reg_write(vin_dev->stfcamss,
+			  ISP_REG_UV_PLANE_START_ADDR, uv_addr);
+}
-- 
2.34.1

