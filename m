Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D450066370B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 03:02:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbjAJCCH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 21:02:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjAJCBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 21:01:51 -0500
Received: from mo-csw-fb.securemx.jp (mo-csw-fb1516.securemx.jp [210.130.202.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07DBE19C3E;
        Mon,  9 Jan 2023 18:01:46 -0800 (PST)
Received: by mo-csw-fb.securemx.jp (mx-mo-csw-fb1516) id 30A1lheX021040; Tue, 10 Jan 2023 10:47:43 +0900
Received: by mo-csw.securemx.jp (mx-mo-csw1516) id 30A1l7DG021078; Tue, 10 Jan 2023 10:47:08 +0900
X-Iguazu-Qid: 34tMdphy6SDIybhVP2
X-Iguazu-QSIG: v=2; s=0; t=1673315227; q=34tMdphy6SDIybhVP2; m=uoChtJBKH0YNt/9y+T1kXl/ZdACBjHA85vd9PVDR4RY=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
        by relay.securemx.jp (mx-mr1510) id 30A1l67R001959
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 10 Jan 2023 10:47:06 +0900
X-SA-MID: 52735595
From:   Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>
To:     Hans Verkuil <hverkuil@xs4all.nl>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Cc:     linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        yuji2.ishikawa@toshiba.co.jp
Subject: [PATCH v4 3/6] media: platform: visconti: Add Toshiba Visconti Video Input Interface driver user interace
Date:   Tue, 10 Jan 2023 10:41:40 +0900
X-TSB-HOP2: ON
Message-Id: <20230110014143.18684-4-yuji2.ishikawa@toshiba.co.jp>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230110014143.18684-1-yuji2.ishikawa@toshiba.co.jp>
References: <20230110014143.18684-1-yuji2.ishikawa@toshiba.co.jp>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support to Video Input Interface on Toshiba Visconti ARM SoCs.
The interface device includes CSI2 Receiver,
frame grabber, video DMAC and image signal processor.
This patch provides the user interface layer.

A driver instance provides three /dev/videoX device files;
one for RGB image capture, another one for optional RGB capture
with different parameters and the last one for RAW capture.

Through the device files, the driver provides streaming (DMA-BUF) interface.
A userland application should feed DMA-BUF instances for capture buffers.

The driver is based on media controller framework.
Its operations are roughly mapped to two subdrivers;
one for ISP and CSI2 receiver (yields 1 instance),
the other for capture (yields 3 instances for each capture mode).

Signed-off-by: Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>
---
Changelog v2:
- Resend v1 because a patch exceeds size limit.

Changelog v3:
- Adapted to media control framework
- Introduced ISP subdevice, capture device
- Remove private IOCTLs and add vendor specific V4L2 controls
- Change function name avoiding camelcase and uppercase letters

Changelog v4:
- Split patches because the v3 patch exceeds size limit 
- Stop using ID number to identify driver instance:
  - Use dynamically allocated structure to hold HW specific context,
    instead of static one.
  - Call HW layer functions with the context structure instead of ID number
- Use pm_runtime to trigger initialization of HW
  along with open/close of device files.
---
 drivers/media/platform/visconti/Makefile      |    1 +
 drivers/media/platform/visconti/viif.c        |  544 ++++++++
 drivers/media/platform/visconti/viif.h        |  203 +++
 .../media/platform/visconti/viif_capture.c    | 1201 +++++++++++++++++
 drivers/media/platform/visconti/viif_isp.c    |  846 ++++++++++++
 5 files changed, 2795 insertions(+)
 create mode 100644 drivers/media/platform/visconti/viif.c
 create mode 100644 drivers/media/platform/visconti/viif.h
 create mode 100644 drivers/media/platform/visconti/viif_capture.c
 create mode 100644 drivers/media/platform/visconti/viif_isp.c

diff --git a/drivers/media/platform/visconti/Makefile b/drivers/media/platform/visconti/Makefile
index e14b904df75..d7a23c1f4e8 100644
--- a/drivers/media/platform/visconti/Makefile
+++ b/drivers/media/platform/visconti/Makefile
@@ -3,6 +3,7 @@
 # Makefile for the Visconti video input device driver
 #
 
+visconti-viif-objs = viif.o viif_capture.o viif_isp.o
 visconti-viif-objs += hwd_viif_csi2rx.o hwd_viif.o
 
 obj-$(CONFIG_VIDEO_VISCONTI_VIIF) += visconti-viif.o
diff --git a/drivers/media/platform/visconti/viif.c b/drivers/media/platform/visconti/viif.c
new file mode 100644
index 00000000000..6bf83ae7114
--- /dev/null
+++ b/drivers/media/platform/visconti/viif.c
@@ -0,0 +1,544 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+/* Toshiba Visconti Video Capture Support
+ *
+ * (C) Copyright 2022 TOSHIBA CORPORATION
+ * (C) Copyright 2022 Toshiba Electronic Devices & Storage Corporation
+ */
+
+#include <linux/delay.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/of_graph.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <media/v4l2-fwnode.h>
+
+#include "viif.h"
+
+static inline struct viif_device *v4l2_to_viif(struct v4l2_device *v4l2_dev)
+{
+	return container_of(v4l2_dev, struct viif_device, v4l2_dev);
+}
+
+static struct viif_subdev *to_viif_subdev(struct v4l2_async_subdev *asd)
+{
+	return container_of(asd, struct viif_subdev, asd);
+}
+
+/* VSYNC mask setting of MAIN unit */
+#define INT_M_SYNC_MASK_VSYNC_INT	 BIT(0)
+#define INT_M_SYNC_MASK_LINES_DELAY_INT1 BIT(1)
+#define INT_M_SYNC_MASK_LINES_DELAY_INT2 BIT(2)
+#define INT_M_SYNC_MASK_SW_DELAY_INT0	 BIT(16)
+#define INT_M_SYNC_MASK_SW_DELAY_INT1	 BIT(17)
+#define INT_M_SYNC_MASK_SW_DELAY_INT2	 BIT(18)
+
+/* STATUS error mask setting of MAIN unit */
+#define INT_M_MASK_L2ISP_SIZE_ERROR	     BIT(0)
+#define INT_M_MASK_CRGBF_INTCRGERR_WRSTART   BIT(1)
+#define INT_M_MASK_CRGBF_INTCRGERR_RDSTART   BIT(2)
+#define INT_M_MASK_EMBED_ERROR		     BIT(3)
+#define INT_M_MASK_USERDATA_ERROR	     BIT(4)
+#define INT_M_MASK_L2ISP_POST0_TABLE_TIMEOUT BIT(8)
+#define INT_M_MASK_L2ISP_POST1_TABLE_TIMEOUT BIT(9)
+#define INT_M_MASK_L2ISP_GRID_TABLE_TIMEOUT  BIT(11)
+#define INT_M_MASK_L1ISP_SIZE_ERROR0	     BIT(16)
+#define INT_M_MASK_L1ISP_SIZE_ERROR1	     BIT(17)
+#define INT_M_MASK_L1ISP_SIZE_ERROR2	     BIT(18)
+#define INT_M_MASK_L1ISP_SIZE_ERROR3	     BIT(19)
+#define INT_M_MASK_L1ISP_SIZE_ERROR4	     BIT(20)
+#define INT_M_MASK_L1ISP_INT_ERR_CRGWRSTART  BIT(21)
+#define INT_M_MASK_L1ISP_INT_ERR_CRGRDSTART  BIT(22)
+#define INT_M_MASK_DELAY_INT_ERROR	     BIT(24)
+
+/* VSYNC mask settings of SUB unit */
+#define INT_S_SYNC_MASK_VSYNC_INT	 BIT(0)
+#define INT_S_SYNC_MASK_LINES_DELAY_INT1 BIT(1)
+#define INT_S_SYNC_MASK_SW_DELAY_INT0	 BIT(16)
+#define INT_S_SYNC_MASK_SW_DELAY_INT1	 BIT(17)
+
+/* STATUS error mask setting of SUB unit */
+#define INT_S_MASK_SIZE_ERROR	   BIT(0)
+#define INT_S_MASK_EMBED_ERROR	   BIT(1)
+#define INT_S_MASK_USERDATA_ERROR  BIT(2)
+#define INT_S_MASK_DELAY_INT_ERROR BIT(24)
+#define INT_S_MASK_RESERVED_SET	   BIT(16) | BIT(28)
+
+static void viif_vsync_irq_handler_w_isp(struct viif_device *viif_dev)
+{
+	u32 event_main, event_sub, status_err, l2_transfer_status;
+	u64 ts;
+
+	ts = ktime_get_ns();
+	hwd_viif_vsync_irq_handler(viif_dev->hwd_res, &event_main, &event_sub);
+
+	/* Delayed Vsync of MAIN unit */
+	if (event_main & INT_M_SYNC_MASK_LINES_DELAY_INT2) {
+		/* unmask timeout error of gamma table */
+		hwd_viif_main_status_err_set_irq_mask(viif_dev->hwd_res, INT_M_MASK_DELAY_INT_ERROR);
+		viif_dev->masked_gamma_path = 0;
+
+		/* Get abort status of L2ISP */
+		hwd_viif_isp_guard_start(viif_dev->hwd_res);
+		hwd_viif_isp_get_info(viif_dev->hwd_res, NULL, &l2_transfer_status);
+		hwd_viif_isp_guard_end(viif_dev->hwd_res);
+
+		status_err = viif_dev->status_err;
+		viif_dev->status_err = 0;
+
+		visconti_viif_capture_switch_buffer(&viif_dev->cap_dev0, status_err,
+						    l2_transfer_status, ts);
+		visconti_viif_capture_switch_buffer(&viif_dev->cap_dev1, status_err,
+						    l2_transfer_status, ts);
+	}
+
+	/* Delayed Vsync of SUB unit */
+	if (event_sub & INT_S_SYNC_MASK_LINES_DELAY_INT1)
+		visconti_viif_capture_switch_buffer(&viif_dev->cap_dev2, 0, 0, ts);
+}
+
+#define MASK_M_GAMMATBL_TIMEOUT 0x0700U
+
+static void viif_status_err_irq_handler(struct viif_device *viif_dev)
+{
+	u32 event_main, event_sub, val, mask;
+
+	hwd_viif_status_err_irq_handler(viif_dev->hwd_res, &event_main, &event_sub);
+
+	if (event_main) {
+		/* mask for gamma table time out error which will be unmasked in the next Vsync */
+		val = FIELD_GET(MASK_M_GAMMATBL_TIMEOUT, event_main);
+		if (val) {
+			viif_dev->masked_gamma_path |= val;
+			mask = INT_M_MASK_DELAY_INT_ERROR |
+			       FIELD_PREP(MASK_M_GAMMATBL_TIMEOUT, viif_dev->masked_gamma_path);
+			hwd_viif_main_status_err_set_irq_mask(viif_dev->hwd_res, mask);
+		}
+
+		viif_dev->status_err = event_main;
+	}
+	viif_dev->reported_err_main |= event_main;
+	viif_dev->reported_err_sub |= event_sub;
+	dev_err(viif_dev->dev, "MAIN/SUB error 0x%x 0x%x.\n", event_main, event_sub);
+}
+
+static void viif_csi2rx_err_irq_handler(struct viif_device *viif_dev)
+{
+	u32 event;
+
+	event = hwd_viif_csi2rx_err_irq_handler(viif_dev->hwd_res);
+	viif_dev->reported_err_csi2rx |= event;
+	dev_err(viif_dev->dev, "CSI2RX error 0x%x.\n", event);
+}
+
+static irqreturn_t visconti_viif_irq(int irq, void *dev_id)
+{
+	struct viif_device *viif_dev = dev_id;
+	int irq_type = irq - viif_dev->irq[0];
+
+	spin_lock(&viif_dev->lock);
+
+	switch (irq_type) {
+	case 0:
+		viif_vsync_irq_handler_w_isp(viif_dev);
+		break;
+	case 1:
+		viif_status_err_irq_handler(viif_dev);
+		break;
+	case 2:
+		viif_csi2rx_err_irq_handler(viif_dev);
+		break;
+	}
+
+	spin_unlock(&viif_dev->lock);
+
+	return IRQ_HANDLED;
+}
+
+/* ----- Async Notifier Operations----- */
+static int visconti_viif_notify_bound(struct v4l2_async_notifier *notifier,
+				      struct v4l2_subdev *v4l2_sd, struct v4l2_async_subdev *asd)
+{
+	struct v4l2_device *v4l2_dev = notifier->v4l2_dev;
+	struct viif_device *viif_dev = v4l2_to_viif(v4l2_dev);
+	struct viif_subdev *viif_sd = to_viif_subdev(asd);
+
+	viif_sd->v4l2_sd = v4l2_sd;
+	viif_dev->num_sd++;
+
+	return 0;
+}
+
+static void visconti_viif_create_links(struct viif_device *viif_dev)
+{
+	unsigned int source_pad;
+	int ret;
+
+	/* camera subdev pad0 -> isp suddev pad0 */
+	ret = media_entity_get_fwnode_pad(&viif_dev->sd->v4l2_sd->entity,
+					  viif_dev->sd->v4l2_sd->fwnode, MEDIA_PAD_FL_SOURCE);
+	if (ret < 0) {
+		dev_err(viif_dev->dev, "failed to find source pad\n");
+		return;
+	}
+	source_pad = ret;
+
+	ret = media_create_pad_link(&viif_dev->sd->v4l2_sd->entity, source_pad,
+				    &viif_dev->isp_subdev.sd.entity, VIIF_ISP_PAD_SINK,
+				    MEDIA_LNK_FL_ENABLED);
+	if (ret)
+		dev_err(viif_dev->dev, "failed create_pad_link (camera:src -> isp:sink)\n");
+
+	ret = media_create_pad_link(&viif_dev->isp_subdev.sd.entity, VIIF_ISP_PAD_SRC_PATH0,
+				    &viif_dev->cap_dev0.vdev.entity, VIIF_CAPTURE_PAD_SINK,
+				    MEDIA_LNK_FL_ENABLED);
+	if (ret)
+		dev_err(viif_dev->dev, "failed create_pad_link (isp:src -> capture0:sink)\n");
+
+	ret = media_create_pad_link(&viif_dev->isp_subdev.sd.entity, VIIF_ISP_PAD_SRC_PATH1,
+				    &viif_dev->cap_dev1.vdev.entity, VIIF_CAPTURE_PAD_SINK,
+				    MEDIA_LNK_FL_ENABLED);
+	if (ret)
+		dev_err(viif_dev->dev, "failed create_pad_link (isp:src -> capture1:sink)\n");
+
+	ret = media_create_pad_link(&viif_dev->isp_subdev.sd.entity, VIIF_ISP_PAD_SRC_PATH2,
+				    &viif_dev->cap_dev2.vdev.entity, VIIF_CAPTURE_PAD_SINK,
+				    MEDIA_LNK_FL_ENABLED);
+	if (ret)
+		dev_err(viif_dev->dev, "failed create_pad_link (isp:src -> capture2:sink)\n");
+}
+
+static void visconti_viif_notify_unbind(struct v4l2_async_notifier *notifier,
+					struct v4l2_subdev *subdev, struct v4l2_async_subdev *asd)
+{
+	struct v4l2_device *v4l2_dev = notifier->v4l2_dev;
+	struct viif_subdev *viif_sd = to_viif_subdev(asd);
+
+	v4l2_dev->ctrl_handler = NULL;
+	viif_sd->v4l2_sd = NULL;
+}
+
+static int visconti_viif_notify_complete(struct v4l2_async_notifier *notifier)
+{
+	struct v4l2_device *v4l2_dev = notifier->v4l2_dev;
+	struct viif_device *viif_dev = v4l2_to_viif(v4l2_dev);
+	int ret;
+
+	ret = v4l2_device_register_subdev_nodes(v4l2_dev);
+	if (ret < 0) {
+		dev_err(v4l2_dev->dev, "Failed to register subdev nodes\n");
+		return ret;
+	}
+
+	/* Make sure at least one sensor is primary and use it to initialize */
+	if (!viif_dev->sd) {
+		viif_dev->sd = &viif_dev->subdevs[0];
+		viif_dev->sd_index = 0;
+	}
+
+	ret = visconti_viif_capture_register_ctrl_handlers(viif_dev);
+	if (ret)
+		return ret;
+
+	visconti_viif_create_links(viif_dev);
+
+	return 0;
+}
+
+static const struct v4l2_async_notifier_operations viif_notify_ops = {
+	.bound = visconti_viif_notify_bound,
+	.unbind = visconti_viif_notify_unbind,
+	.complete = visconti_viif_notify_complete,
+};
+
+/* ----- Probe and Remove ----- */
+static int visconti_viif_init_async_subdevs(struct viif_device *viif_dev, unsigned int n_sd)
+{
+	/* Reserve memory for 'n_sd' viif_subdev descriptors. */
+	viif_dev->subdevs =
+		devm_kcalloc(viif_dev->dev, n_sd, sizeof(*viif_dev->subdevs), GFP_KERNEL);
+	if (!viif_dev->subdevs)
+		return -ENOMEM;
+
+	/* Reserve memory for 'n_sd' pointers to async_subdevices.
+	 * viif_dev->asds members will point to &viif_dev.asd
+	 */
+	viif_dev->asds = devm_kcalloc(viif_dev->dev, n_sd, sizeof(*viif_dev->asds), GFP_KERNEL);
+	if (!viif_dev->asds)
+		return -ENOMEM;
+
+	viif_dev->sd = NULL;
+	viif_dev->sd_index = 0;
+	viif_dev->num_sd = 0;
+
+	return 0;
+}
+
+static int visconti_viif_parse_dt(struct viif_device *viif_dev)
+{
+	struct device_node *of = viif_dev->dev->of_node;
+	struct v4l2_fwnode_endpoint fw_ep;
+	struct viif_subdev *viif_sd;
+	struct device_node *ep;
+	unsigned int i;
+	int num_ep;
+	int ret;
+
+	memset(&fw_ep, 0, sizeof(struct v4l2_fwnode_endpoint));
+
+	num_ep = of_graph_get_endpoint_count(of);
+	if (!num_ep)
+		return -ENODEV;
+
+	ret = visconti_viif_init_async_subdevs(viif_dev, num_ep);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < num_ep; i++) {
+		ep = of_graph_get_endpoint_by_regs(of, 0, i);
+		if (!ep) {
+			dev_err(viif_dev->dev, "No subdevice connected on endpoint %u.\n", i);
+			ret = -ENODEV;
+			goto error_put_node;
+		}
+
+		ret = v4l2_fwnode_endpoint_parse(of_fwnode_handle(ep), &fw_ep);
+		if (ret) {
+			dev_err(viif_dev->dev, "Unable to parse endpoint #%u.\n", i);
+			goto error_put_node;
+		}
+
+		if (fw_ep.bus_type != V4L2_MBUS_CSI2_DPHY ||
+		    fw_ep.bus.mipi_csi2.num_data_lanes == 0) {
+			dev_err(viif_dev->dev, "missing CSI-2 properties in endpoint\n");
+			ret = -EINVAL;
+			goto error_put_node;
+		}
+
+		/* Setup the ceu subdevice and the async subdevice. */
+		viif_sd = &viif_dev->subdevs[i];
+		INIT_LIST_HEAD(&viif_sd->asd.list);
+
+		viif_sd->mbus_flags = fw_ep.bus.mipi_csi2.flags;
+		viif_sd->num_lane = fw_ep.bus.mipi_csi2.num_data_lanes;
+		viif_sd->asd.match_type = V4L2_ASYNC_MATCH_FWNODE;
+		viif_sd->asd.match.fwnode =
+			fwnode_graph_get_remote_port_parent(of_fwnode_handle(ep));
+
+		viif_dev->asds[i] = &viif_sd->asd;
+		of_node_put(ep);
+	}
+
+	return num_ep;
+
+error_put_node:
+	of_node_put(ep);
+	return ret;
+}
+
+static const struct of_device_id visconti_viif_of_table[] = {
+	{
+		.compatible = "toshiba,visconti-viif",
+	},
+	{},
+};
+MODULE_DEVICE_TABLE(of, visconti_viif_of_table);
+
+#define NUM_IRQS       3
+#define IRQ_ID_STR     "viif"
+#define MEDIA_MODEL    "visconti_viif"
+#define MEDIA_BUS_INFO "platform:visconti_viif"
+
+static int visconti_viif_probe(struct platform_device *pdev)
+{
+	const struct of_device_id *of_id;
+	struct device *dev = &pdev->dev;
+	struct viif_device *viif_dev;
+	dma_addr_t table_paddr;
+	int ret, i, num_sd;
+
+	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(36));
+	if (ret)
+		return ret;
+
+	viif_dev = devm_kzalloc(dev, sizeof(*viif_dev), GFP_KERNEL);
+	if (!viif_dev)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, viif_dev);
+	viif_dev->dev = dev;
+
+	spin_lock_init(&viif_dev->lock);
+	mutex_init(&viif_dev->pow_lock);
+
+	viif_dev->capture_reg = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(viif_dev->capture_reg))
+		return PTR_ERR(viif_dev->capture_reg);
+
+	viif_dev->csi2host_reg = devm_platform_ioremap_resource(pdev, 1);
+	if (IS_ERR(viif_dev->csi2host_reg))
+		return PTR_ERR(viif_dev->csi2host_reg);
+
+	viif_dev->hwd_res = allocate_viif_res(dev, viif_dev->csi2host_reg, viif_dev->capture_reg);
+
+	for (i = 0; i < NUM_IRQS; i++) {
+		ret = platform_get_irq(pdev, i);
+		if (ret < 0) {
+			dev_err(dev, "failed to acquire irq resource\n");
+			return ret;
+		}
+		viif_dev->irq[i] = ret;
+		ret = devm_request_irq(dev, viif_dev->irq[i], visconti_viif_irq, 0, IRQ_ID_STR,
+				       viif_dev);
+		if (ret) {
+			dev_err(dev, "irq request failed\n");
+			return ret;
+		}
+	}
+
+	viif_dev->table_vaddr =
+		dma_alloc_wc(dev, sizeof(struct viif_table_area), &table_paddr, GFP_KERNEL);
+	if (!viif_dev->table_vaddr) {
+		dev_err(dev, "dma_alloc_wc failed\n");
+		return -ENOMEM;
+	}
+	viif_dev->table_paddr = (struct viif_table_area *)table_paddr;
+
+	/* power control */
+	pm_runtime_enable(dev);
+
+	/* build media_dev */
+	viif_dev->media_dev.hw_revision = 0;
+	strscpy(viif_dev->media_dev.model, MEDIA_MODEL, sizeof(viif_dev->media_dev.model));
+	viif_dev->media_dev.dev = dev;
+	strscpy(viif_dev->media_dev.bus_info, MEDIA_BUS_INFO, sizeof(viif_dev->media_dev.bus_info));
+	media_device_init(&viif_dev->media_dev);
+
+	/* build v4l2_dev */
+	viif_dev->v4l2_dev.mdev = &viif_dev->media_dev;
+	ret = v4l2_device_register(dev, &viif_dev->v4l2_dev);
+	if (ret)
+		goto error_dma_free;
+
+	ret = media_device_register(&viif_dev->media_dev);
+	if (ret) {
+		dev_err(dev, "Failed to register media device: %d\n", ret);
+		goto error_v4l2_unregister;
+	}
+
+	ret = visconti_viif_isp_register(viif_dev);
+	if (ret) {
+		dev_err(dev, "failed to register isp sub node: %d\n", ret);
+		goto error_media_unregister;
+	}
+	ret = visconti_viif_capture_register(viif_dev);
+	if (ret) {
+		dev_err(dev, "failed to register capture node: %d\n", ret);
+		goto error_media_unregister;
+	}
+
+	/* check device type */
+	of_id = of_match_device(visconti_viif_of_table, dev);
+
+	num_sd = visconti_viif_parse_dt(viif_dev);
+	if (ret < 0) {
+		ret = num_sd;
+		goto error_media_unregister;
+	}
+
+	viif_dev->notifier.v4l2_dev = &viif_dev->v4l2_dev;
+	v4l2_async_nf_init(&viif_dev->notifier);
+	for (i = 0; i < num_sd; i++)
+		__v4l2_async_nf_add_subdev(&viif_dev->notifier, viif_dev->asds[i]);
+	viif_dev->notifier.ops = &viif_notify_ops;
+	ret = v4l2_async_nf_register(&viif_dev->v4l2_dev, &viif_dev->notifier);
+	if (ret)
+		goto error_media_unregister;
+
+	return 0;
+
+error_media_unregister:
+	media_device_unregister(&viif_dev->media_dev);
+error_v4l2_unregister:
+	v4l2_device_unregister(&viif_dev->v4l2_dev);
+error_dma_free:
+	pm_runtime_disable(dev);
+	dma_free_wc(&pdev->dev, sizeof(struct viif_table_area), viif_dev->table_vaddr,
+		    (dma_addr_t)viif_dev->table_paddr);
+	return ret;
+}
+
+static int visconti_viif_remove(struct platform_device *pdev)
+{
+	struct viif_device *viif_dev = platform_get_drvdata(pdev);
+
+	visconti_viif_isp_unregister(viif_dev);
+	visconti_viif_capture_unregister(viif_dev);
+	v4l2_async_nf_unregister(&viif_dev->notifier);
+	media_device_unregister(&viif_dev->media_dev);
+	v4l2_device_unregister(&viif_dev->v4l2_dev);
+	pm_runtime_disable(&pdev->dev);
+	dma_free_wc(&pdev->dev, sizeof(struct viif_table_area), viif_dev->table_vaddr,
+		    (dma_addr_t)viif_dev->table_paddr);
+
+	return 0;
+}
+
+static int visconti_viif_runtime_suspend(struct device *dev)
+{
+	/* This callback is kicked when the last device-file is closed */
+	return 0;
+}
+
+static int visconti_viif_runtime_resume(struct device *dev)
+{
+	/* This callback is kicked when the first device-file is opened */
+	struct viif_device *viif_dev = dev_get_drvdata(dev);
+
+	viif_dev->rawpack_mode = HWD_VIIF_RAWPACK_DISABLE;
+
+	mutex_lock(&viif_dev->pow_lock);
+
+	/* VSYNC mask setting of MAIN unit */
+	hwd_viif_main_vsync_set_irq_mask(
+		viif_dev->hwd_res, INT_M_SYNC_MASK_VSYNC_INT | INT_M_SYNC_MASK_LINES_DELAY_INT1 |
+					   INT_M_SYNC_MASK_SW_DELAY_INT0 |
+					   INT_M_SYNC_MASK_SW_DELAY_INT2);
+
+	/* STATUS error mask setting of MAIN unit */
+	hwd_viif_main_status_err_set_irq_mask(viif_dev->hwd_res, INT_M_MASK_DELAY_INT_ERROR);
+
+	/* VSYNC mask settings of SUB unit */
+	hwd_viif_sub_vsync_set_irq_mask(viif_dev->hwd_res, INT_S_SYNC_MASK_VSYNC_INT |
+								   INT_S_SYNC_MASK_SW_DELAY_INT0 |
+								   INT_S_SYNC_MASK_SW_DELAY_INT1);
+
+	/* STATUS error mask setting(unmask) of SUB unit */
+	hwd_viif_sub_status_err_set_irq_mask(viif_dev->hwd_res,
+					     INT_S_MASK_RESERVED_SET | INT_S_MASK_DELAY_INT_ERROR);
+
+	mutex_unlock(&viif_dev->pow_lock);
+
+	return 0;
+}
+
+static const struct dev_pm_ops visconti_viif_pm_ops = { SET_RUNTIME_PM_OPS(
+	visconti_viif_runtime_suspend, visconti_viif_runtime_resume, NULL) };
+
+static struct platform_driver visconti_viif_driver = {
+	.probe = visconti_viif_probe,
+	.remove = visconti_viif_remove,
+	.driver = {
+			.name = "visconti_viif",
+			.of_match_table = visconti_viif_of_table,
+			.pm = &visconti_viif_pm_ops,
+		},
+};
+
+module_platform_driver(visconti_viif_driver);
+
+MODULE_AUTHOR("Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>");
+MODULE_DESCRIPTION("Toshiba Visconti Video Input driver");
+MODULE_LICENSE("Dual BSD/GPL");
diff --git a/drivers/media/platform/visconti/viif.h b/drivers/media/platform/visconti/viif.h
new file mode 100644
index 00000000000..cd121ae3200
--- /dev/null
+++ b/drivers/media/platform/visconti/viif.h
@@ -0,0 +1,203 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
+/* Toshiba Visconti Video Capture Support
+ *
+ * (C) Copyright 2022 TOSHIBA CORPORATION
+ * (C) Copyright 2022 Toshiba Electronic Devices & Storage Corporation
+ */
+
+#ifndef VIIF_H
+#define VIIF_H
+
+#include <linux/visconti_viif.h>
+#include <media/v4l2-async.h>
+#include <media/v4l2-common.h>
+#include <media/v4l2-ctrls.h>
+#include <media/v4l2-dev.h>
+#include <media/v4l2-device.h>
+#include <media/v4l2-event.h>
+#include <media/v4l2-ioctl.h>
+#include <media/v4l2-mediabus.h>
+#include <media/v4l2-mem2mem.h>
+#include <media/videobuf2-dma-contig.h>
+
+#include "hwd_viif.h"
+
+#define VIIF_ISP_REGBUF_0 0
+#define VIIF_L2ISP_POST_0 0
+#define VIIF_L2ISP_POST_1 1
+
+#define VIIF_CAPTURE_PAD_SINK  0
+#define VIIF_ISP_PAD_SINK      0
+#define VIIF_ISP_PAD_SRC_PATH0 1
+#define VIIF_ISP_PAD_SRC_PATH1 2
+#define VIIF_ISP_PAD_SRC_PATH2 3
+#define VIIF_ISP_PAD_NUM       4
+
+#define CAPTURE_PATH_MAIN_POST0 0
+#define CAPTURE_PATH_MAIN_POST1 1
+#define CAPTURE_PATH_SUB	2
+
+#define VIIF_DPC_TABLE_BYTES	  8192
+#define VIIF_LSC_TABLE_BYTES	  1536
+#define VIIF_UNDIST_TABLE_BYTES	  8192
+#define VIIF_L2_GAMMA_TABLE_BYTES 512
+
+#define VIIF_HW_AVAILABLE_IRQS 4
+
+struct viif_fmt {
+	u32 fourcc;
+	u8 bpp[3];
+	u8 num_planes;
+	u32 colorspace;
+	u32 pitch_align;
+};
+
+struct viif_subdev {
+	struct v4l2_subdev *v4l2_sd;
+	struct v4l2_async_subdev asd;
+
+	/* per-subdevice mbus configuration options */
+	unsigned int mbus_flags;
+	unsigned int mbus_code;
+	unsigned int num_lane;
+};
+
+struct viif_table_area {
+	/* viif_l1_dpc_config */
+	u32 dpc_table_h[VIIF_DPC_TABLE_BYTES / sizeof(u32)];
+	u32 dpc_table_m[VIIF_DPC_TABLE_BYTES / sizeof(u32)];
+	u32 dpc_table_l[VIIF_DPC_TABLE_BYTES / sizeof(u32)];
+	/* viif_l1_lsc_config */
+	u16 lsc_table_gr[VIIF_LSC_TABLE_BYTES / sizeof(u16)];
+	u16 lsc_table_r[VIIF_LSC_TABLE_BYTES / sizeof(u16)];
+	u16 lsc_table_b[VIIF_LSC_TABLE_BYTES / sizeof(u16)];
+	u16 lsc_table_gb[VIIF_LSC_TABLE_BYTES / sizeof(u16)];
+	/* viif_l2_undist_config */
+	u32 undist_write_g[VIIF_UNDIST_TABLE_BYTES / sizeof(u32)];
+	u32 undist_read_b[VIIF_UNDIST_TABLE_BYTES / sizeof(u32)];
+	u32 undist_read_g[VIIF_UNDIST_TABLE_BYTES / sizeof(u32)];
+	u32 undist_read_r[VIIF_UNDIST_TABLE_BYTES / sizeof(u32)];
+	/* viif_l2_gamma_config */
+	u16 l2_gamma_table[2][6][VIIF_L2_GAMMA_TABLE_BYTES / sizeof(u16)];
+};
+
+/* capture device node information */
+struct cap_dev {
+	u32 pathid; /* 0 ... MAIN POST0, 1 ... MAIN POST1, 2 ... SUB */
+	struct video_device vdev;
+	struct media_pad capture_pad;
+	struct v4l2_ctrl_handler ctrl_handler;
+	struct mutex vlock; /* serialize ioctl to vb2_queue and video_device */
+
+	/* vb2 queue, capture buffer list and active buffer pointer */
+	struct vb2_queue vb2_vq;
+	struct list_head buf_queue;
+	struct vb2_v4l2_buffer *active;
+	struct vb2_v4l2_buffer *dma_active;
+	int buf_cnt;
+	unsigned int sequence;
+
+	/* currently configured field and pixel format */
+	enum v4l2_field field;
+	struct v4l2_pix_format_mplane v4l2_pix;
+	unsigned int out_format;
+	struct hwd_viif_img_area img_area;
+	struct hwd_viif_out_process out_process;
+
+	struct viif_device *viif_dev;
+};
+
+struct isp_subdev {
+	struct v4l2_subdev sd;
+	struct media_pad pads[VIIF_ISP_PAD_NUM];
+	struct v4l2_subdev_pad_config pad_cfg[VIIF_ISP_PAD_NUM];
+	struct mutex ops_lock; /* serialize V4L2 query */
+	struct viif_device *viif_dev;
+	struct v4l2_ctrl_handler ctrl_handler;
+};
+
+struct hwd_viif_res;
+
+struct viif_device {
+	struct device *dev;
+	struct v4l2_device v4l2_dev;
+	struct media_device media_dev;
+	struct media_pipeline pipe;
+	u32 masked_gamma_path;
+	struct hwd_viif_func *func;
+
+	struct viif_subdev *subdevs;
+	struct v4l2_async_subdev **asds;
+	/* async subdev notification helpers */
+	struct v4l2_async_notifier notifier;
+
+	/* the subdevice currently in use */
+	struct viif_subdev *sd;
+	unsigned int sd_index;
+	unsigned int num_sd;
+
+	/* sub device node information */
+	struct cap_dev cap_dev0;
+	struct cap_dev cap_dev1;
+	struct cap_dev cap_dev2;
+	struct isp_subdev isp_subdev;
+
+	/* lock - serialize calls to low-level operations (hwd_xxxx) */
+	/* also, this serialize access to capture buffer queue and active buffer */
+	spinlock_t lock;
+
+	/* pow_lock - serialize power control*/
+	struct mutex pow_lock;
+
+	struct {
+		u32 clock_id;
+		u32 csi2_clock_id;
+		u32 csi2_reset_id;
+	} clk_compat;
+
+	/* hwd_res - context of low level implementation */
+	struct hwd_viif_res *hwd_res;
+
+	void __iomem *capture_reg;
+	void __iomem *csi2host_reg;
+	unsigned int irq[VIIF_HW_AVAILABLE_IRQS];
+
+	/* Un-cache table area */
+	struct viif_table_area *table_vaddr;
+	struct viif_table_area *table_paddr;
+
+	/* Rawpack mode */
+	u32 rawpack_mode;
+
+	/* Error flag checked at delayed vsync handler  */
+	u32 status_err;
+
+	/* Error flag checked at compound control GET_REPORTED_ERRORS  */
+	u32 reported_err_main;
+	u32 reported_err_sub;
+	u32 reported_err_csi2rx;
+};
+
+/* viif.c */
+void visconti_viif_hw_on(struct viif_device *viif_dev);
+void visconti_viif_hw_off(struct viif_device *viif_dev);
+
+/* viif_capture.c */
+int visconti_viif_capture_register(struct viif_device *viif_dev);
+void visconti_viif_capture_unregister(struct viif_device *viif_dev);
+int visconti_viif_capture_register_ctrl_handlers(struct viif_device *viif_dev);
+void visconti_viif_capture_switch_buffer(struct cap_dev *cap_dev, u32 status_err,
+					 u32 l2_transfer_status, u64 timestamp);
+
+/* viif_isp.c */
+int visconti_viif_isp_register(struct viif_device *viif_dev);
+void visconti_viif_isp_unregister(struct viif_device *viif_dev);
+int visconti_viif_isp_main_set_unit(struct viif_device *viif_dev);
+int visconti_viif_isp_sub_set_unit(struct viif_device *viif_dev);
+void visconti_viif_isp_set_compose_rect(struct viif_device *viif_dev,
+					struct viif_l2_roi_config *roi);
+
+/* viif_controls.c */
+int visconti_viif_isp_init_controls(struct viif_device *viif_dev);
+
+#endif /* VIIF_H */
diff --git a/drivers/media/platform/visconti/viif_capture.c b/drivers/media/platform/visconti/viif_capture.c
new file mode 100644
index 00000000000..fa18aec4470
--- /dev/null
+++ b/drivers/media/platform/visconti/viif_capture.c
@@ -0,0 +1,1201 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+/* Toshiba Visconti Video Capture Support
+ *
+ * (C) Copyright 2022 TOSHIBA CORPORATION
+ * (C) Copyright 2022 Toshiba Electronic Devices & Storage Corporation
+ */
+
+#include <linux/delay.h>
+#include <linux/pm_runtime.h>
+#include <media/v4l2-common.h>
+#include <media/v4l2-subdev.h>
+
+#include "viif.h"
+
+#define VIIF_CROP_MAX_X_ISP (8062U)
+#define VIIF_CROP_MAX_Y_ISP (3966U)
+#define VIIF_CROP_MIN_W	    (128U)
+#define VIIF_CROP_MAX_W_ISP (8190U)
+#define VIIF_CROP_MIN_H	    (128U)
+#define VIIF_CROP_MAX_H_ISP (4094U)
+
+struct viif_buffer {
+	struct vb2_v4l2_buffer vb;
+	struct list_head queue;
+};
+
+static inline struct viif_buffer *vb2_to_viif(struct vb2_v4l2_buffer *vbuf)
+{
+	return container_of(vbuf, struct viif_buffer, vb);
+}
+
+static inline struct cap_dev *video_drvdata_to_capdev(struct file *file)
+{
+	return (struct cap_dev *)video_drvdata(file);
+}
+
+static inline struct cap_dev *vb2queue_to_capdev(struct vb2_queue *vq)
+{
+	return (struct cap_dev *)vb2_get_drv_priv(vq);
+}
+
+/* ----- ISRs and VB2 Operations ----- */
+static int viif_set_img(struct cap_dev *cap_dev, struct vb2_buffer *vb)
+{
+	struct v4l2_pix_format_mplane *pix = &cap_dev->v4l2_pix;
+	struct viif_device *viif_dev = cap_dev->viif_dev;
+	struct hwd_viif_img next_out_img;
+	dma_addr_t phys_addr;
+	int i, ret = 0;
+
+	next_out_img.width = pix->width;
+	next_out_img.height = pix->height;
+	next_out_img.format = cap_dev->out_format;
+
+	for (i = 0; i < pix->num_planes; i++) {
+		next_out_img.pixelmap[i].pitch = pix->plane_fmt[i].bytesperline;
+		phys_addr = vb2_dma_contig_plane_dma_addr(vb, i);
+		next_out_img.pixelmap[i].pmap_paddr = phys_addr;
+	}
+
+	if (cap_dev->pathid == CAPTURE_PATH_MAIN_POST0) {
+		hwd_viif_isp_guard_start(viif_dev->hwd_res);
+		ret = hwd_viif_l2_set_img_transmission(viif_dev->hwd_res, VIIF_L2ISP_POST_0,
+						       HWD_VIIF_ENABLE, &cap_dev->img_area,
+						       &cap_dev->out_process, &next_out_img);
+		hwd_viif_isp_guard_end(viif_dev->hwd_res);
+		if (ret)
+			dev_err(viif_dev->dev, "set img error. %d\n", ret);
+	} else if (cap_dev->pathid == CAPTURE_PATH_MAIN_POST1) {
+		hwd_viif_isp_guard_start(viif_dev->hwd_res);
+		ret = hwd_viif_l2_set_img_transmission(viif_dev->hwd_res, VIIF_L2ISP_POST_1,
+						       HWD_VIIF_ENABLE, &cap_dev->img_area,
+						       &cap_dev->out_process, &next_out_img);
+		hwd_viif_isp_guard_end(viif_dev->hwd_res);
+		if (ret)
+			dev_err(viif_dev->dev, "set img error. %d\n", ret);
+	} else if (cap_dev->pathid == CAPTURE_PATH_SUB) {
+		hwd_viif_isp_guard_start(viif_dev->hwd_res);
+		ret = hwd_viif_sub_set_img_transmission(viif_dev->hwd_res, &next_out_img);
+		hwd_viif_isp_guard_end(viif_dev->hwd_res);
+		if (ret)
+			dev_err(viif_dev->dev, "set img error. %d\n", ret);
+	}
+
+	return ret;
+}
+
+/*
+ * viif_capture_switch_buffer() is called from interrupt service routine
+ * triggered by VSync with some fixed delay.
+ * The function may switch DMA target buffer by calling viif_set_img().
+ * The VIIF DMA HW captures the destination address at next VSync
+ * and completes transfer at one more after.
+ * Therefore, filled buffer is available at the one after next ISR.
+ *
+ * To avoid DMA HW getting stucked, we always need to set valid destination address.
+ * If a prepared buffer is not available, we reuse the buffer currently being transferred to.
+ *
+ * The cap_dev structure has two pointers and a queue to handle video buffers;
+ + Description of each item at the entry of this function:
+ * * buf_queue:  holds prepared buffers, set by vb2_queue()
+ * * active:     pointing at address captured (and to be filled) by DMA HW
+ * * dma_active: pointing at buffer filled by DMA HW
+ *
+ * Rules to update items:
+ * * when buf_queue is not empty, "active" buffer goes "dma_active"
+ * * when buf_queue is empty:
+ *   * "active" buffer stays the same (DMA HW fills the same buffer for coming two frames)
+ *   * "dma_active" gets NULL (filled buffer will be reused; should not go "DONE" at next ISR)
+ *
+ * Simulation:
+ * | buf_queue   | active  | dma_active | note |
+ * | X           | NULL    | NULL       |      |
+ * <QBUF BUF0>
+ * | X           | BUF0    | NULL       | BUF0 stays |
+ * | X           | BUF0    | NULL       | BUF0 stays |
+ * <QBUF BUF1>
+ * <QBUF BUF2>
+ * | BUF2 BUF1   | BUF0    | NULL       |      |
+ * | BUF2        | BUF1    | BUF0       | BUF0 goes DONE |
+ * | X           | BUF2    | BUF1       | BUF1 goes DONE, BUF2 stays |
+ * | X           | BUF2    | NULL       | BUF2 stays |
+ */
+void visconti_viif_capture_switch_buffer(struct cap_dev *cap_dev, u32 status_err,
+					 u32 l2_transfer_status, u64 timestamp)
+{
+	if (cap_dev->dma_active) {
+		/* DMA has completed and another framebuffer instance is set */
+		struct vb2_v4l2_buffer *vbuf = cap_dev->dma_active;
+		enum vb2_buffer_state state;
+
+		cap_dev->buf_cnt--;
+		vbuf->vb2_buf.timestamp = timestamp;
+		vbuf->sequence = cap_dev->sequence++;
+		vbuf->field = cap_dev->field;
+		if (status_err || l2_transfer_status)
+			state = VB2_BUF_STATE_ERROR;
+		else
+			state = VB2_BUF_STATE_DONE;
+
+		vb2_buffer_done(&vbuf->vb2_buf, state);
+	}
+
+	/* QUEUE pop to register an instance as next DMA target; if empty, reuse current instance */
+	if (!list_empty(&cap_dev->buf_queue)) {
+		struct viif_buffer *buf =
+			list_entry(cap_dev->buf_queue.next, struct viif_buffer, queue);
+		list_del_init(&buf->queue);
+		viif_set_img(cap_dev, &buf->vb.vb2_buf);
+		cap_dev->active = &buf->vb;
+		cap_dev->dma_active = cap_dev->active;
+	} else {
+		cap_dev->dma_active = NULL;
+	}
+}
+
+/* --- Capture buffer control --- */
+static int viif_vb2_setup(struct vb2_queue *vq, unsigned int *count, unsigned int *num_planes,
+			  unsigned int sizes[], struct device *alloc_devs[])
+{
+	struct cap_dev *cap_dev = vb2queue_to_capdev(vq);
+	struct v4l2_pix_format_mplane *pix = &cap_dev->v4l2_pix;
+	unsigned int i;
+
+	/* num_planes is set: just check plane sizes. */
+	if (*num_planes) {
+		for (i = 0; i < pix->num_planes; i++)
+			if (sizes[i] < pix->plane_fmt[i].sizeimage)
+				return -EINVAL;
+
+		return 0;
+	}
+
+	/* num_planes not set: called from REQBUFS, just set plane sizes. */
+	*num_planes = pix->num_planes;
+	for (i = 0; i < pix->num_planes; i++)
+		sizes[i] = pix->plane_fmt[i].sizeimage;
+
+	cap_dev->buf_cnt = 0;
+
+	return 0;
+}
+
+static void viif_vb2_queue(struct vb2_buffer *vb)
+{
+	struct cap_dev *cap_dev = vb2queue_to_capdev(vb->vb2_queue);
+	struct vb2_v4l2_buffer *vbuf = to_vb2_v4l2_buffer(vb);
+	struct viif_device *viif_dev = cap_dev->viif_dev;
+	struct viif_buffer *buf = vb2_to_viif(vbuf);
+	unsigned long irqflags;
+
+	spin_lock_irqsave(&viif_dev->lock, irqflags);
+
+	if (!cap_dev->active) {
+		cap_dev->active = vbuf;
+		viif_set_img(cap_dev, vb);
+	} else {
+		list_add_tail(&buf->queue, &cap_dev->buf_queue);
+	}
+	cap_dev->buf_cnt++;
+
+	spin_unlock_irqrestore(&viif_dev->lock, irqflags);
+}
+
+static int viif_vb2_prepare(struct vb2_buffer *vb)
+{
+	struct cap_dev *cap_dev = vb2queue_to_capdev(vb->vb2_queue);
+	struct v4l2_pix_format_mplane *pix = &cap_dev->v4l2_pix;
+	struct viif_device *viif_dev = cap_dev->viif_dev;
+	unsigned int i;
+
+	for (i = 0; i < pix->num_planes; i++) {
+		if (vb2_plane_size(vb, i) < pix->plane_fmt[i].sizeimage) {
+			dev_err(viif_dev->dev, "Plane size too small (%lu < %u)\n",
+				vb2_plane_size(vb, i), pix->plane_fmt[i].sizeimage);
+			return -EINVAL;
+		}
+
+		vb2_set_plane_payload(vb, i, pix->plane_fmt[i].sizeimage);
+	}
+	return 0;
+}
+
+static int viif_start_streaming(struct vb2_queue *vq, unsigned int count)
+{
+	struct cap_dev *cap_dev = vb2queue_to_capdev(vq);
+	struct viif_device *viif_dev = cap_dev->viif_dev;
+	struct viif_subdev *viif_sd = viif_dev->sd;
+	unsigned long irqflags;
+	int ret;
+
+	spin_lock_irqsave(&viif_dev->lock, irqflags);
+
+	/* note that pipe is shared among paths; see pipe.streaming_count member variable */
+	ret = video_device_pipeline_start(&cap_dev->vdev, &viif_dev->pipe);
+	if (ret)
+		dev_err(viif_dev->dev, "start pipeline failed %d\n", ret);
+
+	/* Currently, only path0 (MAIN POST0) initializes ISP and Camera */
+	/* Possibly, initialization can be done when pipe.streaming_count==0 */
+	if (cap_dev->pathid == CAPTURE_PATH_MAIN_POST0) {
+		/* CSI2RX start */
+		ret = v4l2_subdev_call(&viif_dev->isp_subdev.sd, video, s_stream, true);
+		if (ret) {
+			dev_err(viif_dev->dev, "Start isp subdevice stream failed. %d\n", ret);
+			spin_unlock_irqrestore(&viif_dev->lock, irqflags);
+			return ret;
+		}
+	}
+
+	/* buffer control */
+	cap_dev->sequence = 0;
+
+	/* finish critical section: some sensor driver (including imx219) calls schedule() */
+	spin_unlock_irqrestore(&viif_dev->lock, irqflags);
+
+	/* Camera (CSI2 source) start streaming */
+	/* Currently, only path0 (MAIN POST0) initializes ISP and Camera */
+	/* Possibly, initialization can be done when pipe.streaming_count==0 */
+	if (cap_dev->pathid == CAPTURE_PATH_MAIN_POST0) {
+		ret = v4l2_subdev_call(viif_sd->v4l2_sd, video, s_stream, true);
+		if (ret) {
+			dev_err(viif_dev->dev, "Start subdev stream failed. %d\n", ret);
+			(void)v4l2_subdev_call(&viif_dev->isp_subdev.sd, video, s_stream, false);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+static void viif_stop_streaming(struct vb2_queue *vq)
+{
+	struct cap_dev *cap_dev = vb2queue_to_capdev(vq);
+	struct viif_device *viif_dev = cap_dev->viif_dev;
+	struct viif_subdev *viif_sd = viif_dev->sd;
+	struct viif_buffer *buf;
+	unsigned long irqflags;
+	int ret;
+
+	/* Currently, only path0 (MAIN POST0) stops ISP and Camera */
+	/* Possibly, teardown can be done when pipe.streaming_count==0 */
+	if (cap_dev->pathid == CAPTURE_PATH_MAIN_POST0) {
+		ret = v4l2_subdev_call(viif_sd->v4l2_sd, video, s_stream, false);
+		if (ret)
+			dev_err(viif_dev->dev, "Stop subdev stream failed. %d\n", ret);
+	}
+
+	spin_lock_irqsave(&viif_dev->lock, irqflags);
+
+	/* Currently, only path0 (MAIN POST0) stops ISP and Camera */
+	/* Possibly, teardown can be done when pipe.streaming_count==0 */
+	if (cap_dev->pathid == CAPTURE_PATH_MAIN_POST0) {
+		ret = v4l2_subdev_call(&viif_dev->isp_subdev.sd, video, s_stream, false);
+		if (ret)
+			dev_err(viif_dev->dev, "Stop isp subdevice stream failed %d\n", ret);
+	}
+
+	/* buffer control */
+	if (cap_dev->active) {
+		vb2_buffer_done(&cap_dev->active->vb2_buf, VB2_BUF_STATE_ERROR);
+		cap_dev->buf_cnt--;
+		cap_dev->active = NULL;
+	}
+	if (cap_dev->dma_active) {
+		vb2_buffer_done(&cap_dev->dma_active->vb2_buf, VB2_BUF_STATE_ERROR);
+		cap_dev->buf_cnt--;
+		cap_dev->dma_active = NULL;
+	}
+
+	/* Release all queued buffers. */
+	list_for_each_entry(buf, &cap_dev->buf_queue, queue) {
+		vb2_buffer_done(&buf->vb.vb2_buf, VB2_BUF_STATE_ERROR);
+		cap_dev->buf_cnt--;
+	}
+	INIT_LIST_HEAD(&cap_dev->buf_queue);
+	if (cap_dev->buf_cnt)
+		dev_err(viif_dev->dev, "Buffer count error %d\n", cap_dev->buf_cnt);
+
+	video_device_pipeline_stop(&cap_dev->vdev);
+
+	spin_unlock_irqrestore(&viif_dev->lock, irqflags);
+}
+
+static const struct vb2_ops viif_vb2_ops = {
+	.queue_setup = viif_vb2_setup,
+	.buf_queue = viif_vb2_queue,
+	.buf_prepare = viif_vb2_prepare,
+	.wait_prepare = vb2_ops_wait_prepare,
+	.wait_finish = vb2_ops_wait_finish,
+	.start_streaming = viif_start_streaming,
+	.stop_streaming = viif_stop_streaming,
+};
+
+/* --- VIIF hardware settings --- */
+/* L2ISP output csc setting for YUV to RGB(ITU-R BT.709) */
+static const struct hwd_viif_csc_param viif_csc_yuv2rgb = {
+	.r_cr_in_offset = 0x18000,
+	.g_y_in_offset = 0x1f000,
+	.b_cb_in_offset = 0x18000,
+	.coef = {
+			[0] = 0x1000,
+			[1] = 0xfd12,
+			[2] = 0xf8ad,
+			[3] = 0x1000,
+			[4] = 0x1d07,
+			[5] = 0x0000,
+			[6] = 0x1000,
+			[7] = 0x0000,
+			[8] = 0x18a2,
+		},
+	.r_cr_out_offset = 0x1000,
+	.g_y_out_offset = 0x1000,
+	.b_cb_out_offset = 0x1000,
+};
+
+/* L2ISP output csc setting for RGB to YUV(ITU-R BT.709) */
+static const struct hwd_viif_csc_param viif_csc_rgb2yuv = {
+	.r_cr_in_offset = 0x1f000,
+	.g_y_in_offset = 0x1f000,
+	.b_cb_in_offset = 0x1f000,
+	.coef = {
+			[0] = 0x0b71,
+			[1] = 0x0128,
+			[2] = 0x0367,
+			[3] = 0xf9b1,
+			[4] = 0x082f,
+			[5] = 0xfe20,
+			[6] = 0xf891,
+			[7] = 0xff40,
+			[8] = 0x082f,
+		},
+	.r_cr_out_offset = 0x8000,
+	.g_y_out_offset = 0x1000,
+	.b_cb_out_offset = 0x8000,
+};
+
+static int viif_l2_set_format(struct cap_dev *cap_dev)
+{
+	struct v4l2_pix_format_mplane *pix = &cap_dev->v4l2_pix;
+	struct viif_device *viif_dev = cap_dev->viif_dev;
+	const struct hwd_viif_csc_param *csc_param = NULL;
+	struct v4l2_subdev_selection sel = {
+		.target = V4L2_SEL_TGT_CROP,
+		.which = V4L2_SUBDEV_FORMAT_ACTIVE,
+	};
+	struct v4l2_subdev_format fmt = {
+		.which = V4L2_SUBDEV_FORMAT_ACTIVE,
+	};
+	bool inp_is_rgb = false;
+	bool out_is_rgb = false;
+	u32 postid;
+	int ret;
+
+	/* check path id */
+	if (cap_dev->pathid == CAPTURE_PATH_MAIN_POST0) {
+		sel.pad = VIIF_ISP_PAD_SRC_PATH0;
+		fmt.pad = VIIF_ISP_PAD_SRC_PATH0;
+		postid = VIIF_L2ISP_POST_0;
+	} else if (cap_dev->pathid == CAPTURE_PATH_MAIN_POST1) {
+		sel.pad = VIIF_ISP_PAD_SRC_PATH1;
+		fmt.pad = VIIF_ISP_PAD_SRC_PATH1;
+		postid = VIIF_L2ISP_POST_1;
+	} else {
+		return -EINVAL;
+	}
+
+	cap_dev->out_process.half_scale = HWD_VIIF_DISABLE;
+	cap_dev->out_process.select_color = HWD_VIIF_COLOR_YUV_RGB;
+	cap_dev->out_process.alpha = 0;
+
+	ret = v4l2_subdev_call(&viif_dev->isp_subdev.sd, pad, get_selection, NULL, &sel);
+	if (ret) {
+		cap_dev->img_area.x = 0;
+		cap_dev->img_area.y = 0;
+		cap_dev->img_area.w = pix->width;
+		cap_dev->img_area.h = pix->height;
+	} else {
+		cap_dev->img_area.x = sel.r.left;
+		cap_dev->img_area.y = sel.r.top;
+		cap_dev->img_area.w = sel.r.width;
+		cap_dev->img_area.h = sel.r.height;
+	}
+
+	ret = v4l2_subdev_call(&viif_dev->isp_subdev.sd, pad, get_fmt, NULL, &fmt);
+	if (!ret)
+		inp_is_rgb = (fmt.format.code == MEDIA_BUS_FMT_RGB888_1X24);
+
+	switch (pix->pixelformat) {
+	case V4L2_PIX_FMT_RGB24:
+		cap_dev->out_format = HWD_VIIF_RGB888_PACKED;
+		out_is_rgb = true;
+		break;
+	case V4L2_PIX_FMT_ABGR32:
+		cap_dev->out_format = HWD_VIIF_ARGB8888_PACKED;
+		cap_dev->out_process.alpha = 0xff;
+		out_is_rgb = true;
+		break;
+	case V4L2_PIX_FMT_YUV422M:
+		cap_dev->out_format = HWD_VIIF_YCBCR422_8_PLANAR;
+		break;
+	case V4L2_PIX_FMT_YUV444M:
+		cap_dev->out_format = HWD_VIIF_RGB888_YCBCR444_8_PLANAR;
+		break;
+	case V4L2_PIX_FMT_Y16:
+		cap_dev->out_format = HWD_VIIF_ONE_COLOR_16;
+		cap_dev->out_process.select_color = HWD_VIIF_COLOR_Y_G;
+		break;
+	}
+
+	if (!inp_is_rgb && out_is_rgb)
+		csc_param = &viif_csc_yuv2rgb; /* YUV -> RGB */
+	else if (inp_is_rgb && !out_is_rgb)
+		csc_param = &viif_csc_rgb2yuv; /* RGB -> YUV */
+
+	return hwd_viif_l2_set_output_csc(viif_dev->hwd_res, postid, csc_param);
+}
+
+/* --- IOCTL Operations --- */
+static const struct viif_fmt viif_fmt_list[] = {
+	{
+		.fourcc = V4L2_PIX_FMT_RGB24,
+		.bpp = { 24, 0, 0 },
+		.num_planes = 1,
+		.colorspace = V4L2_COLORSPACE_SRGB,
+		.pitch_align = 384,
+	},
+	{
+		.fourcc = V4L2_PIX_FMT_ABGR32,
+		.bpp = { 32, 0, 0 },
+		.num_planes = 1,
+		.colorspace = V4L2_COLORSPACE_SRGB,
+		.pitch_align = 512,
+	},
+	{
+		.fourcc = V4L2_PIX_FMT_YUV422M,
+		.bpp = { 8, 4, 4 },
+		.num_planes = 3,
+		.colorspace = V4L2_COLORSPACE_REC709,
+		.pitch_align = 128,
+	},
+	{
+		.fourcc = V4L2_PIX_FMT_YUV444M,
+		.bpp = { 8, 8, 8 },
+		.num_planes = 3,
+		.colorspace = V4L2_COLORSPACE_REC709,
+		.pitch_align = 128,
+	},
+	{
+		.fourcc = V4L2_PIX_FMT_Y16,
+		.bpp = { 16, 0, 0 },
+		.num_planes = 1,
+		.colorspace = V4L2_COLORSPACE_REC709,
+		.pitch_align = 128,
+	},
+};
+
+static const struct viif_fmt viif_rawfmt_list[] = {
+	{
+		.fourcc = V4L2_PIX_FMT_SRGGB10,
+		.bpp = { 16, 0, 0 },
+		.num_planes = 1,
+		.colorspace = V4L2_COLORSPACE_SRGB,
+		.pitch_align = 256,
+	},
+	{
+		.fourcc = V4L2_PIX_FMT_SRGGB12,
+		.bpp = { 16, 0, 0 },
+		.num_planes = 1,
+		.colorspace = V4L2_COLORSPACE_SRGB,
+		.pitch_align = 256,
+	},
+	{
+		.fourcc = V4L2_PIX_FMT_SRGGB14,
+		.bpp = { 16, 0, 0 },
+		.num_planes = 1,
+		.colorspace = V4L2_COLORSPACE_SRGB,
+		.pitch_align = 256,
+	},
+};
+
+static const struct viif_fmt *get_viif_fmt_from_fourcc(unsigned int fourcc)
+{
+	const struct viif_fmt *fmt = &viif_fmt_list[0];
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(viif_fmt_list); i++, fmt++)
+		if (fmt->fourcc == fourcc)
+			return fmt;
+
+	return NULL;
+}
+
+static void viif_update_plane_sizes(struct v4l2_plane_pix_format *plane, unsigned int bpl,
+				    unsigned int szimage)
+{
+	memset(plane, 0, sizeof(*plane));
+
+	plane->sizeimage = szimage;
+	plane->bytesperline = bpl;
+}
+
+static void viif_calc_plane_sizes(const struct viif_fmt *viif_fmt,
+				  struct v4l2_pix_format_mplane *pix)
+{
+	unsigned int i, bpl, szimage;
+
+	for (i = 0; i < viif_fmt->num_planes; i++) {
+		bpl = pix->width * viif_fmt->bpp[i] / 8;
+		/* round up ptch */
+		bpl = (bpl + (viif_fmt->pitch_align - 1)) / viif_fmt->pitch_align;
+		bpl *= viif_fmt->pitch_align;
+		szimage = pix->height * bpl;
+		viif_update_plane_sizes(&pix->plane_fmt[i], bpl, szimage);
+	}
+	pix->num_planes = viif_fmt->num_planes;
+}
+
+static int viif_querycap(struct file *file, void *priv, struct v4l2_capability *cap)
+{
+	struct viif_device *viif_dev = video_drvdata_to_capdev(file)->viif_dev;
+
+	strscpy(cap->card, "Toshiba VIIF", sizeof(cap->card));
+	strscpy(cap->driver, "viif", sizeof(cap->driver));
+	snprintf(cap->bus_info, sizeof(cap->bus_info), "platform:toshiba-viif-%s",
+		 dev_name(viif_dev->dev));
+	return 0;
+}
+
+static int viif_enum_rawfmt(struct cap_dev *cap_dev, struct v4l2_fmtdesc *f)
+{
+	if (f->index >= ARRAY_SIZE(viif_rawfmt_list))
+		return -EINVAL;
+
+	f->pixelformat = viif_rawfmt_list[f->index].fourcc;
+
+	return 0;
+}
+
+static int viif_enum_fmt_vid_cap(struct file *file, void *priv, struct v4l2_fmtdesc *f)
+{
+	struct cap_dev *cap_dev = video_drvdata_to_capdev(file);
+	const struct viif_fmt *fmt;
+
+	if (cap_dev->pathid == CAPTURE_PATH_SUB)
+		return viif_enum_rawfmt(cap_dev, f);
+
+	if (f->index >= ARRAY_SIZE(viif_fmt_list))
+		return -EINVAL;
+
+	fmt = &viif_fmt_list[f->index];
+	f->pixelformat = fmt->fourcc;
+
+	return 0;
+}
+
+/* size of minimum/maximum output image */
+#define VIIF_MIN_OUTPUT_IMG_WIDTH     (128U)
+#define VIIF_MAX_OUTPUT_IMG_WIDTH_ISP (5760U)
+#define VIIF_MAX_OUTPUT_IMG_WIDTH_SUB (4096U)
+
+#define VIIF_MIN_OUTPUT_IMG_HEIGHT     (128U)
+#define VIIF_MAX_OUTPUT_IMG_HEIGHT_ISP (3240U)
+#define VIIF_MAX_OUTPUT_IMG_HEIGHT_SUB (2160U)
+
+static int viif_try_fmt(struct cap_dev *cap_dev, struct v4l2_format *v4l2_fmt)
+{
+	struct v4l2_pix_format_mplane *pix = &v4l2_fmt->fmt.pix_mp;
+	struct viif_device *viif_dev = cap_dev->viif_dev;
+	struct v4l2_subdev_format format = {
+		.which = V4L2_SUBDEV_FORMAT_ACTIVE,
+	};
+	const struct viif_fmt *viif_fmt;
+	int ret;
+
+	/* check path id */
+	if (cap_dev->pathid == CAPTURE_PATH_MAIN_POST0)
+		format.pad = VIIF_ISP_PAD_SRC_PATH0;
+	else if (cap_dev->pathid == CAPTURE_PATH_MAIN_POST1)
+		format.pad = VIIF_ISP_PAD_SRC_PATH1;
+	else
+		format.pad = VIIF_ISP_PAD_SRC_PATH2;
+
+	ret = v4l2_subdev_call(&viif_dev->isp_subdev.sd, pad, get_fmt, NULL, &format);
+	if (ret)
+		return -EINVAL;
+
+	/* fourcc check */
+	if (cap_dev->pathid == CAPTURE_PATH_SUB) {
+		switch (format.format.code) {
+		case MEDIA_BUS_FMT_SRGGB10_1X10:
+		case MEDIA_BUS_FMT_SGRBG10_1X10:
+		case MEDIA_BUS_FMT_SGBRG10_1X10:
+		case MEDIA_BUS_FMT_SBGGR10_1X10:
+			viif_fmt = &viif_rawfmt_list[0]; /*V4L2_PIX_FMT_SRGGB10*/
+			pix->pixelformat = viif_fmt->fourcc;
+			break;
+		case MEDIA_BUS_FMT_SRGGB12_1X12:
+		case MEDIA_BUS_FMT_SGRBG12_1X12:
+		case MEDIA_BUS_FMT_SGBRG12_1X12:
+		case MEDIA_BUS_FMT_SBGGR12_1X12:
+			viif_fmt = &viif_rawfmt_list[1]; /*V4L2_PIX_FMT_SRGGB12*/
+			pix->pixelformat = viif_fmt->fourcc;
+			break;
+		case MEDIA_BUS_FMT_SRGGB14_1X14:
+		case MEDIA_BUS_FMT_SGRBG14_1X14:
+		case MEDIA_BUS_FMT_SGBRG14_1X14:
+		case MEDIA_BUS_FMT_SBGGR14_1X14:
+			viif_fmt = &viif_rawfmt_list[2]; /*V4L2_PIX_FMT_SRGGB14*/
+			pix->pixelformat = viif_fmt->fourcc;
+			break;
+		default:
+			return -EINVAL;
+		}
+	} else {
+		viif_fmt = get_viif_fmt_from_fourcc(pix->pixelformat);
+		if (!viif_fmt)
+			return -EINVAL;
+	}
+
+	/* min/max width, height check */
+	if (pix->width < VIIF_MIN_OUTPUT_IMG_WIDTH)
+		pix->width = VIIF_MIN_OUTPUT_IMG_WIDTH;
+
+	if (pix->width > VIIF_MAX_OUTPUT_IMG_WIDTH_ISP)
+		pix->width = VIIF_MAX_OUTPUT_IMG_WIDTH_ISP;
+
+	if (pix->height < VIIF_MIN_OUTPUT_IMG_HEIGHT)
+		pix->height = VIIF_MIN_OUTPUT_IMG_HEIGHT;
+
+	if (pix->height > VIIF_MAX_OUTPUT_IMG_HEIGHT_ISP)
+		pix->height = VIIF_MAX_OUTPUT_IMG_HEIGHT_ISP;
+
+	/* consistency with isp::pad::src::fmt */
+	if (pix->width != format.format.width)
+		return -EINVAL;
+	if (pix->height != format.format.height)
+		return -EINVAL;
+
+	/* update derived parameters, such as bpp */
+	viif_calc_plane_sizes(viif_fmt, pix);
+
+	return 0;
+}
+
+static int viif_try_fmt_vid_cap(struct file *file, void *priv, struct v4l2_format *f)
+{
+	struct cap_dev *cap_dev = video_drvdata_to_capdev(file);
+
+	return viif_try_fmt(cap_dev, f);
+}
+
+static int viif_s_fmt_vid_cap(struct file *file, void *priv, struct v4l2_format *f)
+{
+	struct cap_dev *cap_dev = video_drvdata_to_capdev(file);
+	struct viif_device *viif_dev = cap_dev->viif_dev;
+	int ret = 0;
+
+	if (vb2_is_streaming(&cap_dev->vb2_vq))
+		return -EBUSY;
+
+	if (f->type != cap_dev->vb2_vq.type)
+		return -EINVAL;
+
+	ret = viif_try_fmt(cap_dev, f);
+	if (ret)
+		return ret;
+
+	if (cap_dev->pathid == CAPTURE_PATH_MAIN_POST0) {
+		/*
+		 * A call to main_set_unit() is currently at ioctl(VIDIOC_S_FMT) context.
+		 * This call can be moved to viif_isp_s_stream(),
+		 * if you don't want to check the given format is compatible to HW.
+		 */
+		ret = visconti_viif_isp_main_set_unit(viif_dev);
+		if (ret)
+			return ret;
+	}
+
+	cap_dev->v4l2_pix = f->fmt.pix_mp;
+	cap_dev->field = V4L2_FIELD_NONE;
+
+	if (cap_dev->pathid == CAPTURE_PATH_SUB) {
+		cap_dev->out_format = HWD_VIIF_ONE_COLOR_16;
+		ret = visconti_viif_isp_sub_set_unit(viif_dev);
+	} else {
+		ret = viif_l2_set_format(cap_dev);
+	}
+
+	return ret;
+}
+
+static int viif_g_fmt_vid_cap(struct file *file, void *priv, struct v4l2_format *f)
+{
+	struct cap_dev *cap_dev = video_drvdata_to_capdev(file);
+
+	f->fmt.pix_mp = cap_dev->v4l2_pix;
+
+	return 0;
+}
+
+static int viif_enum_input(struct file *file, void *priv, struct v4l2_input *inp)
+{
+	struct viif_device *viif_dev = video_drvdata_to_capdev(file)->viif_dev;
+	struct viif_subdev *viif_sd;
+	struct v4l2_subdev *v4l2_sd;
+	int ret;
+
+	if (inp->index >= viif_dev->num_sd)
+		return -EINVAL;
+
+	viif_sd = &viif_dev->subdevs[inp->index];
+	v4l2_sd = viif_sd->v4l2_sd;
+
+	ret = v4l2_subdev_call(v4l2_sd, video, g_input_status, &inp->status);
+	if (ret < 0 && ret != -ENOIOCTLCMD && ret != -ENODEV)
+		return ret;
+	inp->type = V4L2_INPUT_TYPE_CAMERA;
+	inp->std = 0;
+	if (v4l2_subdev_has_op(v4l2_sd, pad, dv_timings_cap))
+		inp->capabilities = V4L2_IN_CAP_DV_TIMINGS;
+	else
+		inp->capabilities = V4L2_IN_CAP_STD;
+	snprintf(inp->name, sizeof(inp->name), "Camera%u: %s", inp->index, viif_sd->v4l2_sd->name);
+
+	return 0;
+}
+
+static int viif_g_input(struct file *file, void *priv, unsigned int *i)
+{
+	struct viif_device *viif_dev = video_drvdata_to_capdev(file)->viif_dev;
+
+	*i = viif_dev->sd_index;
+
+	return 0;
+}
+
+static int viif_s_input(struct file *file, void *priv, unsigned int i)
+{
+	struct viif_device *viif_dev = video_drvdata_to_capdev(file)->viif_dev;
+
+	if (i >= viif_dev->num_sd)
+		return -EINVAL;
+
+	return 0;
+}
+
+static int viif_g_selection(struct file *file, void *priv, struct v4l2_selection *s)
+{
+	struct cap_dev *cap_dev = video_drvdata_to_capdev(file);
+	struct viif_device *viif_dev = cap_dev->viif_dev;
+	struct v4l2_subdev_selection sel = {
+		.target = V4L2_SEL_TGT_CROP,
+		.which = V4L2_SUBDEV_FORMAT_ACTIVE,
+	};
+	int ret;
+
+	/* check path id */
+	if (cap_dev->pathid == CAPTURE_PATH_MAIN_POST0)
+		sel.pad = VIIF_ISP_PAD_SRC_PATH0;
+	else if (cap_dev->pathid == CAPTURE_PATH_MAIN_POST1)
+		sel.pad = VIIF_ISP_PAD_SRC_PATH1;
+	else
+		return -EINVAL;
+
+	ret = v4l2_subdev_call(&viif_dev->isp_subdev.sd, pad, get_selection, NULL, &sel);
+	s->r = sel.r;
+
+	return ret;
+}
+
+static int viif_s_selection(struct file *file, void *priv, struct v4l2_selection *s)
+{
+	struct cap_dev *cap_dev = video_drvdata_to_capdev(file);
+	struct viif_device *viif_dev = cap_dev->viif_dev;
+	struct v4l2_subdev_selection sel = {
+		.target = V4L2_SEL_TGT_CROP,
+		.which = V4L2_SUBDEV_FORMAT_ACTIVE,
+		.r = s->r,
+	};
+	int ret;
+
+	/* check path id */
+	if (cap_dev->pathid == CAPTURE_PATH_MAIN_POST0)
+		sel.pad = VIIF_ISP_PAD_SRC_PATH0;
+	else if (cap_dev->pathid == CAPTURE_PATH_MAIN_POST1)
+		sel.pad = VIIF_ISP_PAD_SRC_PATH1;
+	else
+		return -EINVAL;
+
+	if (s->r.left > VIIF_CROP_MAX_X_ISP || s->r.top > VIIF_CROP_MAX_Y_ISP ||
+	    s->r.width < VIIF_CROP_MIN_W || s->r.width > VIIF_CROP_MAX_W_ISP ||
+	    s->r.height < VIIF_CROP_MIN_H || s->r.height > VIIF_CROP_MAX_H_ISP) {
+		return -EINVAL;
+	}
+
+	ret = v4l2_subdev_call(&viif_dev->isp_subdev.sd, pad, set_selection, NULL, &sel);
+	s->r = sel.r;
+
+	return ret;
+}
+
+static int viif_dv_timings_cap(struct file *file, void *priv_fh, struct v4l2_dv_timings_cap *cap)
+{
+	struct viif_device *viif_dev = video_drvdata_to_capdev(file)->viif_dev;
+	struct viif_subdev *viif_sd = viif_dev->sd;
+
+	return v4l2_subdev_call(viif_sd->v4l2_sd, pad, dv_timings_cap, cap);
+}
+
+static int viif_enum_dv_timings(struct file *file, void *priv_fh,
+				struct v4l2_enum_dv_timings *timings)
+{
+	struct viif_device *viif_dev = video_drvdata_to_capdev(file)->viif_dev;
+	struct viif_subdev *viif_sd = viif_dev->sd;
+
+	return v4l2_subdev_call(viif_sd->v4l2_sd, pad, enum_dv_timings, timings);
+}
+
+static int viif_g_dv_timings(struct file *file, void *priv_fh, struct v4l2_dv_timings *timings)
+{
+	struct viif_device *viif_dev = video_drvdata_to_capdev(file)->viif_dev;
+	struct viif_subdev *viif_sd = viif_dev->sd;
+
+	return v4l2_subdev_call(viif_sd->v4l2_sd, video, g_dv_timings, timings);
+}
+
+static int viif_s_dv_timings(struct file *file, void *priv_fh, struct v4l2_dv_timings *timings)
+{
+	struct viif_device *viif_dev = video_drvdata_to_capdev(file)->viif_dev;
+	struct viif_subdev *viif_sd = viif_dev->sd;
+
+	return v4l2_subdev_call(viif_sd->v4l2_sd, video, s_dv_timings, timings);
+}
+
+static int viif_query_dv_timings(struct file *file, void *priv_fh, struct v4l2_dv_timings *timings)
+{
+	struct viif_device *viif_dev = video_drvdata_to_capdev(file)->viif_dev;
+	struct viif_subdev *viif_sd = viif_dev->sd;
+
+	return v4l2_subdev_call(viif_sd->v4l2_sd, video, query_dv_timings, timings);
+}
+
+static int viif_g_edid(struct file *file, void *fh, struct v4l2_edid *edid)
+{
+	struct viif_device *viif_dev = video_drvdata_to_capdev(file)->viif_dev;
+	struct viif_subdev *viif_sd = viif_dev->sd;
+
+	return v4l2_subdev_call(viif_sd->v4l2_sd, pad, get_edid, edid);
+}
+
+static int viif_s_edid(struct file *file, void *fh, struct v4l2_edid *edid)
+{
+	struct viif_device *viif_dev = video_drvdata_to_capdev(file)->viif_dev;
+	struct viif_subdev *viif_sd = viif_dev->sd;
+
+	return v4l2_subdev_call(viif_sd->v4l2_sd, pad, set_edid, edid);
+}
+
+static int viif_g_parm(struct file *file, void *fh, struct v4l2_streamparm *a)
+{
+	struct viif_device *viif_dev = video_drvdata_to_capdev(file)->viif_dev;
+
+	return v4l2_g_parm_cap(video_devdata(file), viif_dev->sd->v4l2_sd, a);
+}
+
+static int viif_s_parm(struct file *file, void *fh, struct v4l2_streamparm *a)
+{
+	struct viif_device *viif_dev = video_drvdata_to_capdev(file)->viif_dev;
+
+	return v4l2_s_parm_cap(video_devdata(file), viif_dev->sd->v4l2_sd, a);
+}
+
+static int viif_enum_framesizes(struct file *file, void *fh, struct v4l2_frmsizeenum *fsize)
+{
+	struct viif_device *viif_dev = video_drvdata_to_capdev(file)->viif_dev;
+	struct viif_subdev *viif_sd = viif_dev->sd;
+	struct v4l2_subdev *v4l2_sd = viif_sd->v4l2_sd;
+	struct v4l2_subdev_frame_size_enum fse = {
+		.code = viif_sd->mbus_code,
+		.index = fsize->index,
+		.which = V4L2_SUBDEV_FORMAT_ACTIVE,
+	};
+	int ret;
+
+	ret = v4l2_subdev_call(v4l2_sd, pad, enum_frame_size, NULL, &fse);
+	if (ret)
+		return ret;
+
+	fsize->type = V4L2_FRMSIZE_TYPE_DISCRETE;
+	fsize->discrete.width = fse.max_width;
+	fsize->discrete.height = fse.max_height;
+
+	return 0;
+}
+
+static int viif_enum_frameintervals(struct file *file, void *fh, struct v4l2_frmivalenum *fival)
+{
+	struct viif_device *viif_dev = video_drvdata_to_capdev(file)->viif_dev;
+	struct viif_subdev *viif_sd = viif_dev->sd;
+	struct v4l2_subdev *v4l2_sd = viif_sd->v4l2_sd;
+	struct v4l2_subdev_frame_interval_enum fie = {
+		.code = viif_sd->mbus_code,
+		.index = fival->index,
+		.width = fival->width,
+		.height = fival->height,
+		.which = V4L2_SUBDEV_FORMAT_ACTIVE,
+	};
+	int ret;
+
+	ret = v4l2_subdev_call(v4l2_sd, pad, enum_frame_interval, NULL, &fie);
+	if (ret)
+		return ret;
+
+	fival->type = V4L2_FRMIVAL_TYPE_DISCRETE;
+	fival->discrete = fie.interval;
+
+	return 0;
+}
+
+static const struct v4l2_ioctl_ops viif_ioctl_ops = {
+	.vidioc_querycap = viif_querycap,
+
+	.vidioc_enum_fmt_vid_cap = viif_enum_fmt_vid_cap,
+	.vidioc_try_fmt_vid_cap_mplane = viif_try_fmt_vid_cap,
+	.vidioc_s_fmt_vid_cap_mplane = viif_s_fmt_vid_cap,
+	.vidioc_g_fmt_vid_cap_mplane = viif_g_fmt_vid_cap,
+
+	.vidioc_enum_input = viif_enum_input,
+	.vidioc_g_input = viif_g_input,
+	.vidioc_s_input = viif_s_input,
+
+	.vidioc_g_selection = viif_g_selection,
+	.vidioc_s_selection = viif_s_selection,
+
+	.vidioc_dv_timings_cap = viif_dv_timings_cap,
+	.vidioc_enum_dv_timings = viif_enum_dv_timings,
+	.vidioc_g_dv_timings = viif_g_dv_timings,
+	.vidioc_s_dv_timings = viif_s_dv_timings,
+	.vidioc_query_dv_timings = viif_query_dv_timings,
+
+	.vidioc_g_edid = viif_g_edid,
+	.vidioc_s_edid = viif_s_edid,
+
+	.vidioc_g_parm = viif_g_parm,
+	.vidioc_s_parm = viif_s_parm,
+
+	.vidioc_enum_framesizes = viif_enum_framesizes,
+	.vidioc_enum_frameintervals = viif_enum_frameintervals,
+
+	.vidioc_reqbufs = vb2_ioctl_reqbufs,
+	.vidioc_querybuf = vb2_ioctl_querybuf,
+	.vidioc_qbuf = vb2_ioctl_qbuf,
+	.vidioc_expbuf = vb2_ioctl_expbuf,
+	.vidioc_dqbuf = vb2_ioctl_dqbuf,
+	.vidioc_create_bufs = vb2_ioctl_create_bufs,
+	.vidioc_prepare_buf = vb2_ioctl_prepare_buf,
+	.vidioc_streamon = vb2_ioctl_streamon,
+	.vidioc_streamoff = vb2_ioctl_streamoff,
+
+	.vidioc_log_status = v4l2_ctrl_log_status,
+	.vidioc_subscribe_event = v4l2_ctrl_subscribe_event,
+	.vidioc_unsubscribe_event = v4l2_event_unsubscribe,
+};
+
+/* --- File Operations --- */
+static int viif_capture_open(struct file *file)
+{
+	struct cap_dev *cap_dev = video_drvdata_to_capdev(file);
+	struct viif_device *viif_dev = cap_dev->viif_dev;
+	int ret;
+
+	ret = v4l2_fh_open(file);
+	if (ret)
+		return ret;
+
+	return pm_runtime_resume_and_get(viif_dev->dev);
+}
+
+static int viif_capture_release(struct file *file)
+{
+	struct cap_dev *cap_dev = video_drvdata_to_capdev(file);
+	struct viif_device *viif_dev = cap_dev->viif_dev;
+
+	vb2_fop_release(file);
+	pm_runtime_put(viif_dev->dev);
+
+	return 0;
+}
+
+static const struct v4l2_file_operations viif_fops = {
+	.owner = THIS_MODULE,
+	.open = viif_capture_open,
+	.release = viif_capture_release,
+	.unlocked_ioctl = video_ioctl2,
+	.mmap = vb2_fop_mmap,
+	.poll = vb2_fop_poll,
+};
+
+/* ----- media control callbacks ----- */
+static int viif_capture_link_validate(struct media_link *link)
+{
+	/* link validation at start-stream */
+	return 0;
+}
+
+static const struct media_entity_operations viif_media_ops = {
+	.link_validate = viif_capture_link_validate,
+};
+
+/* ----- attach ctrl callbacck handler ----- */
+int visconti_viif_capture_register_ctrl_handlers(struct viif_device *viif_dev)
+{
+	int ret;
+
+	/* MAIN POST0: merge controls of ISP and CAPTURE0 */
+	ret = v4l2_ctrl_add_handler(&viif_dev->cap_dev0.ctrl_handler,
+				    viif_dev->sd->v4l2_sd->ctrl_handler, NULL, true);
+	if (ret) {
+		dev_err(viif_dev->dev, "Failed to add sensor ctrl_handler");
+		return ret;
+	}
+	ret = v4l2_ctrl_add_handler(&viif_dev->cap_dev0.ctrl_handler,
+				    &viif_dev->isp_subdev.ctrl_handler, NULL, true);
+	if (ret) {
+		dev_err(viif_dev->dev, "Failed to add isp subdev ctrl_handler");
+		return ret;
+	}
+
+	/* MAIN POST1: merge controls of ISP and CAPTURE0 */
+	ret = v4l2_ctrl_add_handler(&viif_dev->cap_dev1.ctrl_handler,
+				    viif_dev->sd->v4l2_sd->ctrl_handler, NULL, true);
+	if (ret) {
+		dev_err(viif_dev->dev, "Failed to add sensor ctrl_handler");
+		return ret;
+	}
+	ret = v4l2_ctrl_add_handler(&viif_dev->cap_dev1.ctrl_handler,
+				    &viif_dev->isp_subdev.ctrl_handler, NULL, true);
+	if (ret) {
+		dev_err(viif_dev->dev, "Failed to add isp subdev ctrl_handler");
+		return ret;
+	}
+
+	/* SUB: no control is exported */
+
+	return 0;
+}
+
+/* ----- register/remove capture device node ----- */
+static int visconti_viif_capture_register_node(struct cap_dev *cap_dev)
+{
+	struct viif_device *viif_dev = cap_dev->viif_dev;
+	struct v4l2_device *v4l2_dev = &viif_dev->v4l2_dev;
+	struct video_device *vdev = &cap_dev->vdev;
+	struct vb2_queue *q = &cap_dev->vb2_vq;
+	static const char *const node_name[] = {
+		"viif_capture_post0",
+		"viif_capture_post1",
+		"viif_capture_sub",
+	};
+	int ret;
+
+	INIT_LIST_HEAD(&cap_dev->buf_queue);
+
+	mutex_init(&cap_dev->vlock);
+
+	/* Initialize vb2 queue. */
+	q->type = V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE;
+	q->io_modes = VB2_DMABUF;
+	q->timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_MONOTONIC;
+	q->ops = &viif_vb2_ops;
+	q->mem_ops = &vb2_dma_contig_memops;
+	q->drv_priv = cap_dev;
+	q->buf_struct_size = sizeof(struct viif_buffer);
+	q->min_buffers_needed = 2;
+	q->lock = &cap_dev->vlock;
+	q->dev = viif_dev->v4l2_dev.dev;
+
+	ret = vb2_queue_init(q);
+	if (ret)
+		return ret;
+
+	/* Register the video device. */
+	strscpy(vdev->name, node_name[cap_dev->pathid], sizeof(vdev->name));
+	vdev->v4l2_dev = v4l2_dev;
+	vdev->lock = &cap_dev->vlock;
+	vdev->queue = &cap_dev->vb2_vq;
+	vdev->ctrl_handler = NULL;
+	vdev->fops = &viif_fops;
+	vdev->ioctl_ops = &viif_ioctl_ops;
+	vdev->device_caps = V4L2_CAP_VIDEO_CAPTURE_MPLANE | V4L2_CAP_STREAMING;
+	vdev->device_caps |= V4L2_CAP_IO_MC;
+	vdev->entity.ops = &viif_media_ops;
+	vdev->release = video_device_release_empty;
+	video_set_drvdata(vdev, cap_dev);
+	vdev->vfl_dir = VFL_DIR_RX;
+	cap_dev->capture_pad.flags = MEDIA_PAD_FL_SINK;
+
+	ret = video_register_device(vdev, VFL_TYPE_VIDEO, -1);
+	if (ret < 0) {
+		dev_err(v4l2_dev->dev, "video_register_device failed: %d\n", ret);
+		return ret;
+	}
+
+	ret = media_entity_pads_init(&vdev->entity, 1, &cap_dev->capture_pad);
+	if (ret) {
+		video_unregister_device(vdev);
+		return ret;
+	}
+
+	ret = v4l2_ctrl_handler_init(&cap_dev->ctrl_handler, 30);
+	if (ret)
+		return -ENOMEM;
+
+	cap_dev->vdev.ctrl_handler = &cap_dev->ctrl_handler;
+
+	return 0;
+}
+
+int visconti_viif_capture_register(struct viif_device *viif_dev)
+{
+	int ret;
+
+	/* register MAIN POST0 (primary RGB output)*/
+	viif_dev->cap_dev0.pathid = CAPTURE_PATH_MAIN_POST0;
+	viif_dev->cap_dev0.viif_dev = viif_dev;
+	ret = visconti_viif_capture_register_node(&viif_dev->cap_dev0);
+	if (ret)
+		return ret;
+
+	/* register MAIN POST1 (additional RGB output)*/
+	viif_dev->cap_dev1.pathid = CAPTURE_PATH_MAIN_POST1;
+	viif_dev->cap_dev1.viif_dev = viif_dev;
+	ret = visconti_viif_capture_register_node(&viif_dev->cap_dev1);
+	if (ret)
+		return ret;
+
+	/* register SUB (RAW output) */
+	viif_dev->cap_dev2.pathid = CAPTURE_PATH_SUB;
+	viif_dev->cap_dev2.viif_dev = viif_dev;
+	ret = visconti_viif_capture_register_node(&viif_dev->cap_dev2);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static void visconti_viif_capture_unregister_node(struct cap_dev *cap_dev)
+{
+	media_entity_cleanup(&cap_dev->vdev.entity);
+	v4l2_ctrl_handler_free(&cap_dev->ctrl_handler);
+	vb2_video_unregister_device(&cap_dev->vdev);
+	mutex_destroy(&cap_dev->vlock);
+}
+
+void visconti_viif_capture_unregister(struct viif_device *viif_dev)
+{
+	visconti_viif_capture_unregister_node(&viif_dev->cap_dev0);
+	visconti_viif_capture_unregister_node(&viif_dev->cap_dev1);
+	visconti_viif_capture_unregister_node(&viif_dev->cap_dev2);
+}
diff --git a/drivers/media/platform/visconti/viif_isp.c b/drivers/media/platform/visconti/viif_isp.c
new file mode 100644
index 00000000000..9314e6e8661
--- /dev/null
+++ b/drivers/media/platform/visconti/viif_isp.c
@@ -0,0 +1,846 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+/* Toshiba Visconti Video Capture Support
+ *
+ * (C) Copyright 2022 TOSHIBA CORPORATION
+ * (C) Copyright 2022 Toshiba Electronic Devices & Storage Corporation
+ */
+
+#include <linux/delay.h>
+#include <media/v4l2-common.h>
+#include <media/v4l2-subdev.h>
+
+#include "viif.h"
+
+/* ----- supported MBUS formats ----- */
+struct visconti_mbus_format {
+	unsigned int code;
+	unsigned int bpp;
+	int rgb_out;
+} static visconti_mbus_formats[] = {
+	{ .code = MEDIA_BUS_FMT_RGB888_1X24, .bpp = 24, .rgb_out = 1 },
+	{ .code = MEDIA_BUS_FMT_UYVY8_1X16, .bpp = 16, .rgb_out = 0 },
+	{ .code = MEDIA_BUS_FMT_UYVY10_1X20, .bpp = 20, .rgb_out = 0 },
+	{ .code = MEDIA_BUS_FMT_RGB565_1X16, .bpp = 16, .rgb_out = 1 },
+	{ .code = MEDIA_BUS_FMT_SBGGR8_1X8, .bpp = 8, .rgb_out = 0 },
+	{ .code = MEDIA_BUS_FMT_SGBRG8_1X8, .bpp = 8, .rgb_out = 0 },
+	{ .code = MEDIA_BUS_FMT_SGRBG8_1X8, .bpp = 8, .rgb_out = 0 },
+	{ .code = MEDIA_BUS_FMT_SRGGB8_1X8, .bpp = 8, .rgb_out = 0 },
+	{ .code = MEDIA_BUS_FMT_SRGGB10_1X10, .bpp = 10, .rgb_out = 0 },
+	{ .code = MEDIA_BUS_FMT_SGRBG10_1X10, .bpp = 10, .rgb_out = 0 },
+	{ .code = MEDIA_BUS_FMT_SGBRG10_1X10, .bpp = 10, .rgb_out = 0 },
+	{ .code = MEDIA_BUS_FMT_SBGGR10_1X10, .bpp = 10, .rgb_out = 0 },
+	{ .code = MEDIA_BUS_FMT_SRGGB12_1X12, .bpp = 12, .rgb_out = 0 },
+	{ .code = MEDIA_BUS_FMT_SGRBG12_1X12, .bpp = 12, .rgb_out = 0 },
+	{ .code = MEDIA_BUS_FMT_SGBRG12_1X12, .bpp = 12, .rgb_out = 0 },
+	{ .code = MEDIA_BUS_FMT_SBGGR12_1X12, .bpp = 12, .rgb_out = 0 },
+	{ .code = MEDIA_BUS_FMT_SRGGB14_1X14, .bpp = 14, .rgb_out = 0 },
+	{ .code = MEDIA_BUS_FMT_SGRBG14_1X14, .bpp = 14, .rgb_out = 0 },
+	{ .code = MEDIA_BUS_FMT_SGBRG14_1X14, .bpp = 14, .rgb_out = 0 },
+	{ .code = MEDIA_BUS_FMT_SBGGR14_1X14, .bpp = 14, .rgb_out = 0 },
+};
+
+static int viif_get_mbus_rgb_out(unsigned int mbus_code)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(visconti_mbus_formats); i++)
+		if (visconti_mbus_formats[i].code == mbus_code)
+			return visconti_mbus_formats[i].rgb_out;
+
+	/* YUV intermediate code by default */
+	return 0;
+}
+
+static unsigned int viif_get_mbus_bpp(unsigned int mbus_code)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(visconti_mbus_formats); i++)
+		if (visconti_mbus_formats[i].code == mbus_code)
+			return visconti_mbus_formats[i].bpp;
+
+	/* default bpp value */
+	return 24;
+}
+
+static bool viif_is_valid_mbus_code(unsigned int mbus_code)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(visconti_mbus_formats); i++)
+		if (visconti_mbus_formats[i].code == mbus_code)
+			return true;
+	return false;
+}
+
+/* ----- handling main processing path ----- */
+static int viif_get_dv_timings(struct viif_device *viif_dev, struct v4l2_dv_timings *timings)
+{
+	struct viif_subdev *viif_sd = viif_dev->sd;
+	struct v4l2_subdev_pad_config pad_cfg;
+	struct v4l2_subdev_state pad_state = {
+		.pads = &pad_cfg,
+	};
+	struct v4l2_subdev_format format = {
+		.which = V4L2_SUBDEV_FORMAT_ACTIVE,
+		.pad = 0,
+	};
+	struct v4l2_ctrl *ctrl;
+	int ret;
+
+	/* some video I/F support dv_timings query */
+	ret = v4l2_subdev_call(viif_sd->v4l2_sd, video, g_dv_timings, timings);
+	if (ret == 0)
+		return 0;
+
+	/* others: call some discrete APIs */
+	ret = v4l2_subdev_call(viif_sd->v4l2_sd, pad, get_fmt, &pad_state, &format);
+	if (ret != 0)
+		return ret;
+
+	timings->bt.width = format.format.width;
+	timings->bt.height = format.format.height;
+
+	ctrl = v4l2_ctrl_find(viif_sd->v4l2_sd->ctrl_handler, V4L2_CID_HBLANK);
+	if (!ctrl) {
+		dev_err(viif_dev->dev, "subdev: V4L2_CID_VBLANK error.\n");
+		return -EINVAL;
+	}
+	timings->bt.hsync = v4l2_ctrl_g_ctrl(ctrl);
+
+	ctrl = v4l2_ctrl_find(viif_sd->v4l2_sd->ctrl_handler, V4L2_CID_VBLANK);
+	if (!ctrl) {
+		dev_err(viif_dev->dev, "subdev: V4L2_CID_VBLANK error.\n");
+		return -EINVAL;
+	}
+	timings->bt.vsync = v4l2_ctrl_g_ctrl(ctrl);
+
+	ctrl = v4l2_ctrl_find(viif_sd->v4l2_sd->ctrl_handler, V4L2_CID_PIXEL_RATE);
+	if (!ctrl) {
+		dev_err(viif_dev->dev, "subdev: V4L2_CID_PIXEL_RATE error.\n");
+		return -EINVAL;
+	}
+	timings->bt.pixelclock = v4l2_ctrl_g_ctrl_int64(ctrl);
+
+	return 0;
+}
+
+int visconti_viif_isp_main_set_unit(struct viif_device *viif_dev)
+{
+	unsigned int dt_image, color_type, rawpack, yuv_conv;
+	struct viif_subdev *viif_sd = viif_dev->sd;
+	struct hwd_viif_input_img in_img_main;
+	struct viif_l2_undist undist = { 0 };
+	struct v4l2_dv_timings timings;
+	struct v4l2_subdev_format fmt = {
+		.pad = 0,
+		.which = V4L2_SUBDEV_FORMAT_ACTIVE,
+	};
+	int mag_hactive = 1;
+	int ret = 0;
+
+	ret = viif_get_dv_timings(viif_dev, &timings);
+	if (ret) {
+		dev_err(viif_dev->dev, "could not get timing information of subdev");
+		return -EINVAL;
+	}
+
+	ret = v4l2_subdev_call(viif_sd->v4l2_sd, pad, get_fmt, NULL, &fmt);
+	if (ret) {
+		dev_err(viif_dev->dev, "could not get pad information of subdev");
+		return -EINVAL;
+	}
+
+	switch (fmt.format.code) {
+	case MEDIA_BUS_FMT_RGB888_1X24:
+		dt_image = VISCONTI_CSI2_DT_RGB888;
+		break;
+	case MEDIA_BUS_FMT_UYVY8_1X16:
+		dt_image = VISCONTI_CSI2_DT_YUV4228B;
+		break;
+	case MEDIA_BUS_FMT_UYVY10_1X20:
+		dt_image = VISCONTI_CSI2_DT_YUV42210B;
+		break;
+	case MEDIA_BUS_FMT_RGB565_1X16:
+		dt_image = VISCONTI_CSI2_DT_RGB565;
+		break;
+	case MEDIA_BUS_FMT_SBGGR8_1X8:
+	case MEDIA_BUS_FMT_SGBRG8_1X8:
+	case MEDIA_BUS_FMT_SGRBG8_1X8:
+	case MEDIA_BUS_FMT_SRGGB8_1X8:
+		dt_image = VISCONTI_CSI2_DT_RAW8;
+		break;
+	case MEDIA_BUS_FMT_SRGGB10_1X10:
+	case MEDIA_BUS_FMT_SGRBG10_1X10:
+	case MEDIA_BUS_FMT_SGBRG10_1X10:
+	case MEDIA_BUS_FMT_SBGGR10_1X10:
+		dt_image = VISCONTI_CSI2_DT_RAW10;
+		break;
+	case MEDIA_BUS_FMT_SRGGB12_1X12:
+	case MEDIA_BUS_FMT_SGRBG12_1X12:
+	case MEDIA_BUS_FMT_SGBRG12_1X12:
+	case MEDIA_BUS_FMT_SBGGR12_1X12:
+		dt_image = VISCONTI_CSI2_DT_RAW12;
+		break;
+	case MEDIA_BUS_FMT_SRGGB14_1X14:
+	case MEDIA_BUS_FMT_SGRBG14_1X14:
+	case MEDIA_BUS_FMT_SGBRG14_1X14:
+	case MEDIA_BUS_FMT_SBGGR14_1X14:
+		dt_image = VISCONTI_CSI2_DT_RAW14;
+		break;
+	default:
+		dt_image = VISCONTI_CSI2_DT_RGB888;
+		break;
+	}
+
+	color_type = dt_image;
+
+	if (color_type == VISCONTI_CSI2_DT_RAW8 || color_type == VISCONTI_CSI2_DT_RAW10 ||
+	    color_type == VISCONTI_CSI2_DT_RAW12) {
+		rawpack = viif_dev->rawpack_mode;
+		if (rawpack != HWD_VIIF_RAWPACK_DISABLE)
+			mag_hactive = 2;
+	} else {
+		rawpack = HWD_VIIF_RAWPACK_DISABLE;
+	}
+
+	if (color_type == VISCONTI_CSI2_DT_YUV4228B || color_type == VISCONTI_CSI2_DT_YUV42210B)
+		yuv_conv = HWD_VIIF_YUV_CONV_INTERPOLATION;
+	else
+		yuv_conv = HWD_VIIF_YUV_CONV_REPEAT;
+
+	in_img_main.hactive_size = timings.bt.width;
+	in_img_main.vactive_size = timings.bt.height;
+	in_img_main.htotal_size = timings.bt.width * mag_hactive + timings.bt.hsync;
+	in_img_main.vtotal_size = timings.bt.height + timings.bt.vsync;
+	in_img_main.pixel_clock = timings.bt.pixelclock / 1000;
+	in_img_main.vbp_size = timings.bt.vsync - 5;
+
+	in_img_main.interpolation_mode = HWD_VIIF_L1_INPUT_INTERPOLATION_LINE;
+	in_img_main.input_num = 1;
+	in_img_main.hobc_width = 0;
+	in_img_main.hobc_margin = 0;
+
+	/* configuration of MAIN unit */
+	ret = hwd_viif_main_set_unit(viif_dev->hwd_res, dt_image, &in_img_main, color_type, rawpack,
+				     yuv_conv);
+	if (ret) {
+		dev_err(viif_dev->dev, "main_set_unit error. %d\n", ret);
+		return ret;
+	}
+
+	/* Enable regbuf */
+	hwd_viif_isp_set_regbuf_auto_transmission(viif_dev->hwd_res);
+
+	/* L2 UNDIST Enable through mode as default  */
+	undist.through_mode = HWD_VIIF_ENABLE;
+	undist.sensor_crop_ofs_h = 1 - in_img_main.hactive_size;
+	undist.sensor_crop_ofs_v = 1 - in_img_main.vactive_size;
+	undist.grid_node_num_h = 16;
+	undist.grid_node_num_v = 16;
+	ret = hwd_viif_l2_set_undist(viif_dev->hwd_res, &undist);
+	if (ret)
+		dev_err(viif_dev->dev, "l2_set_undist error. %d\n", ret);
+	return ret;
+}
+
+static unsigned int dt_image_from_mbus_code(unsigned int mbus_code)
+{
+	switch (mbus_code) {
+	case MEDIA_BUS_FMT_RGB888_1X24:
+		return VISCONTI_CSI2_DT_RGB888;
+	case MEDIA_BUS_FMT_UYVY8_1X16:
+		return VISCONTI_CSI2_DT_YUV4228B;
+	case MEDIA_BUS_FMT_UYVY10_1X20:
+		return VISCONTI_CSI2_DT_YUV42210B;
+	case MEDIA_BUS_FMT_RGB565_1X16:
+		return VISCONTI_CSI2_DT_RGB565;
+	case MEDIA_BUS_FMT_SBGGR8_1X8:
+	case MEDIA_BUS_FMT_SGBRG8_1X8:
+	case MEDIA_BUS_FMT_SGRBG8_1X8:
+	case MEDIA_BUS_FMT_SRGGB8_1X8:
+		return VISCONTI_CSI2_DT_RAW8;
+	case MEDIA_BUS_FMT_SRGGB10_1X10:
+	case MEDIA_BUS_FMT_SGRBG10_1X10:
+	case MEDIA_BUS_FMT_SGBRG10_1X10:
+	case MEDIA_BUS_FMT_SBGGR10_1X10:
+		return VISCONTI_CSI2_DT_RAW10;
+	case MEDIA_BUS_FMT_SRGGB12_1X12:
+	case MEDIA_BUS_FMT_SGRBG12_1X12:
+	case MEDIA_BUS_FMT_SGBRG12_1X12:
+	case MEDIA_BUS_FMT_SBGGR12_1X12:
+		return VISCONTI_CSI2_DT_RAW12;
+	case MEDIA_BUS_FMT_SRGGB14_1X14:
+	case MEDIA_BUS_FMT_SGRBG14_1X14:
+	case MEDIA_BUS_FMT_SGBRG14_1X14:
+	case MEDIA_BUS_FMT_SBGGR14_1X14:
+		return VISCONTI_CSI2_DT_RAW14;
+	default:
+		return VISCONTI_CSI2_DT_RGB888;
+	}
+}
+
+int visconti_viif_isp_sub_set_unit(struct viif_device *viif_dev)
+{
+	struct hwd_viif_input_img in_img_sub;
+	struct v4l2_dv_timings timings;
+	struct v4l2_subdev_format fmt = {
+		.pad = 0,
+		.which = V4L2_SUBDEV_FORMAT_ACTIVE,
+	};
+	unsigned int dt_image;
+	int ret;
+
+	ret = viif_get_dv_timings(viif_dev, &timings);
+	if (ret)
+		return -EINVAL;
+
+	ret = v4l2_subdev_call(viif_dev->sd->v4l2_sd, pad, get_fmt, NULL, &fmt);
+	if (ret) {
+		dev_err(viif_dev->dev, "could not get pad information of subdev");
+		return -EINVAL;
+	}
+
+	dt_image = dt_image_from_mbus_code(fmt.format.code);
+
+	in_img_sub.hactive_size = 0;
+	in_img_sub.vactive_size = timings.bt.height;
+	in_img_sub.htotal_size = timings.bt.width + timings.bt.hsync;
+	in_img_sub.vtotal_size = timings.bt.height + timings.bt.vsync;
+	in_img_sub.pixel_clock = timings.bt.pixelclock / 1000;
+	in_img_sub.vbp_size = timings.bt.vsync - 5;
+	in_img_sub.interpolation_mode = HWD_VIIF_L1_INPUT_INTERPOLATION_LINE;
+	in_img_sub.input_num = 1;
+	in_img_sub.hobc_width = 0;
+	in_img_sub.hobc_margin = 0;
+
+	ret = hwd_viif_sub_set_unit(viif_dev->hwd_res, dt_image, &in_img_sub);
+	if (ret)
+		dev_err(viif_dev->dev, "sub_set_unit error. %d\n", ret);
+
+	return ret;
+};
+
+/* ----- handling CSI2RX hardware ----- */
+static int viif_csi2rx_initialize(struct viif_device *viif_dev)
+{
+	struct hwd_viif_csi2rx_line_err_target err_target = { 0 };
+	struct hwd_viif_csi2rx_irq_mask csi2rx_mask;
+	struct viif_subdev *viif_sd = viif_dev->sd;
+	struct v4l2_mbus_config cfg = { 0 };
+	struct v4l2_subdev_format fmt = {
+		.pad = 0,
+		.which = V4L2_SUBDEV_FORMAT_ACTIVE,
+	};
+	struct v4l2_dv_timings timings;
+	int num_lane, dphy_rate;
+	int ret;
+
+	ret = v4l2_subdev_call(viif_sd->v4l2_sd, pad, get_mbus_config, 0, &cfg);
+	if (ret) {
+		dev_dbg(viif_dev->dev, "subdev: g_mbus_config error. %d\n", ret);
+		num_lane = viif_sd->num_lane;
+	} else {
+		if (cfg.type != V4L2_MBUS_CSI2_DPHY)
+			return -EINVAL;
+		num_lane = cfg.bus.mipi_csi2.num_data_lanes;
+	}
+
+	ret = v4l2_subdev_call(viif_sd->v4l2_sd, pad, get_fmt, 0, &fmt);
+	if (ret)
+		return -EINVAL;
+
+	ret = viif_get_dv_timings(viif_dev, &timings);
+	if (ret)
+		return -EINVAL;
+
+	dphy_rate = (timings.bt.pixelclock / 1000) * viif_get_mbus_bpp(fmt.format.code) / num_lane;
+	dphy_rate = dphy_rate / 1000;
+
+	/* check error for CH0: all supported DTs */
+	err_target.dt[0] = VISCONTI_CSI2_DT_RGB565;
+	err_target.dt[1] = VISCONTI_CSI2_DT_YUV4228B;
+	err_target.dt[2] = VISCONTI_CSI2_DT_YUV42210B;
+	err_target.dt[3] = VISCONTI_CSI2_DT_RGB888;
+	err_target.dt[4] = VISCONTI_CSI2_DT_RAW8;
+	err_target.dt[5] = VISCONTI_CSI2_DT_RAW10;
+	err_target.dt[6] = VISCONTI_CSI2_DT_RAW12;
+	err_target.dt[7] = VISCONTI_CSI2_DT_RAW14;
+
+	/* Define errors to be masked */
+	csi2rx_mask.mask[0] = 0x0000000F; /*check all for PHY_FATAL*/
+	csi2rx_mask.mask[1] = 0x0001000F; /*check all for PKT_FATAL*/
+	csi2rx_mask.mask[2] = 0x000F0F0F; /*check all for FRAME_FATAL*/
+	csi2rx_mask.mask[3] = 0x000F000F; /*check all for PHY*/
+	csi2rx_mask.mask[4] = 0x000F000F; /*check all for PKT*/
+	csi2rx_mask.mask[5] = 0x00FF00FF; /*check all for LINE*/
+
+	return hwd_viif_csi2rx_initialize(viif_dev->hwd_res, num_lane, HWD_VIIF_CSI2_DPHY_L0L1L2L3,
+					 dphy_rate, HWD_VIIF_ENABLE, &err_target, &csi2rx_mask);
+}
+
+static int viif_csi2rx_start(struct viif_device *viif_dev)
+{
+	struct hwd_viif_csi2rx_packet packet = { 0 };
+	u32 vc_main = 0;
+	u32 vc_sub = 0;
+
+	viif_dev->masked_gamma_path = 0U;
+
+	return hwd_viif_csi2rx_start(viif_dev->hwd_res, vc_main, vc_sub, &packet);
+}
+
+static int viif_csi2rx_stop(struct viif_device *viif_dev)
+{
+	s32 ret;
+
+	ret = hwd_viif_csi2rx_stop(viif_dev->hwd_res);
+	if (ret)
+		dev_err(viif_dev->dev, "csi2rx_stop error. %d\n", ret);
+
+	hwd_viif_csi2rx_uninitialize(viif_dev->hwd_res);
+
+	return ret;
+}
+
+/* ----- subdevice video operations ----- */
+static int visconti_viif_isp_s_stream(struct v4l2_subdev *sd, int enable)
+{
+	struct viif_device *viif_dev = ((struct isp_subdev *)sd)->viif_dev;
+	int ret;
+
+	if (enable) {
+		ret = viif_csi2rx_initialize(viif_dev);
+		if (ret)
+			return ret;
+		return viif_csi2rx_start(viif_dev);
+	} else {
+		return viif_csi2rx_stop(viif_dev);
+	}
+}
+
+/* ----- subdevice pad operations ----- */
+static int visconti_viif_isp_enum_mbus_code(struct v4l2_subdev *sd,
+					    struct v4l2_subdev_state *sd_state,
+					    struct v4l2_subdev_mbus_code_enum *code)
+{
+	if (code->pad == 0) {
+		/* sink */
+		if (code->index > ARRAY_SIZE(visconti_mbus_formats) - 1)
+			return -EINVAL;
+		code->code = visconti_mbus_formats[code->index].code;
+		return 0;
+	}
+
+	/* source */
+	if (code->index > 0)
+		return -EINVAL;
+	code->code = MEDIA_BUS_FMT_YUV8_1X24;
+	return 0;
+}
+
+static struct v4l2_mbus_framefmt *visconti_viif_isp_get_pad_fmt(struct v4l2_subdev *sd,
+								struct v4l2_subdev_state *sd_state,
+								unsigned int pad, u32 which)
+{
+	struct viif_device *viif_dev = ((struct isp_subdev *)sd)->viif_dev;
+	struct v4l2_subdev_state state = {
+		.pads = viif_dev->isp_subdev.pad_cfg,
+	};
+
+	if (which == V4L2_SUBDEV_FORMAT_TRY)
+		return v4l2_subdev_get_try_format(&viif_dev->isp_subdev.sd, sd_state, pad);
+	else
+		return v4l2_subdev_get_try_format(&viif_dev->isp_subdev.sd, &state, pad);
+}
+
+static struct v4l2_rect *visconti_viif_isp_get_pad_crop(struct v4l2_subdev *sd,
+							struct v4l2_subdev_state *sd_state,
+							unsigned int pad, u32 which)
+{
+	struct viif_device *viif_dev = ((struct isp_subdev *)sd)->viif_dev;
+	struct v4l2_subdev_state state = {
+		.pads = viif_dev->isp_subdev.pad_cfg,
+	};
+
+	if (which == V4L2_SUBDEV_FORMAT_TRY)
+		return v4l2_subdev_get_try_crop(&viif_dev->isp_subdev.sd, sd_state, pad);
+	else
+		return v4l2_subdev_get_try_crop(&viif_dev->isp_subdev.sd, &state, pad);
+}
+
+static struct v4l2_rect *visconti_viif_isp_get_pad_compose(struct v4l2_subdev *sd,
+							   struct v4l2_subdev_state *sd_state,
+							   unsigned int pad, u32 which)
+{
+	struct viif_device *viif_dev = ((struct isp_subdev *)sd)->viif_dev;
+	struct v4l2_subdev_state state = {
+		.pads = viif_dev->isp_subdev.pad_cfg,
+	};
+
+	if (which == V4L2_SUBDEV_FORMAT_TRY)
+		return v4l2_subdev_get_try_compose(&viif_dev->isp_subdev.sd, sd_state, pad);
+	else
+		return v4l2_subdev_get_try_compose(&viif_dev->isp_subdev.sd, &state, pad);
+}
+
+static int visconti_viif_isp_get_fmt(struct v4l2_subdev *sd, struct v4l2_subdev_state *sd_state,
+				     struct v4l2_subdev_format *fmt)
+{
+	struct viif_device *viif_dev = ((struct isp_subdev *)sd)->viif_dev;
+
+	mutex_lock(&viif_dev->isp_subdev.ops_lock);
+	fmt->format = *visconti_viif_isp_get_pad_fmt(sd, sd_state, fmt->pad, fmt->which);
+	mutex_unlock(&viif_dev->isp_subdev.ops_lock);
+
+	return 0;
+}
+
+static void visconti_viif_isp_set_sink_fmt(struct v4l2_subdev *sd,
+					   struct v4l2_subdev_state *sd_state,
+					   struct v4l2_mbus_framefmt *format, u32 which)
+{
+	struct v4l2_mbus_framefmt *sink_fmt, *src0_fmt, *src1_fmt, *src2_fmt;
+
+	sink_fmt = visconti_viif_isp_get_pad_fmt(sd, sd_state, VIIF_ISP_PAD_SINK, which);
+	src0_fmt = visconti_viif_isp_get_pad_fmt(sd, sd_state, VIIF_ISP_PAD_SRC_PATH0, which);
+	src1_fmt = visconti_viif_isp_get_pad_fmt(sd, sd_state, VIIF_ISP_PAD_SRC_PATH1, which);
+	src2_fmt = visconti_viif_isp_get_pad_fmt(sd, sd_state, VIIF_ISP_PAD_SRC_PATH2, which);
+
+	/* update mbus code only if it's available */
+	if (viif_is_valid_mbus_code(format->code))
+		sink_fmt->code = format->code;
+
+	/* sink::mbus_code is derived from src::mbus_code */
+	if (viif_get_mbus_rgb_out(sink_fmt->code)) {
+		src0_fmt->code = MEDIA_BUS_FMT_RGB888_1X24;
+		src1_fmt->code = MEDIA_BUS_FMT_RGB888_1X24;
+	} else {
+		src0_fmt->code = MEDIA_BUS_FMT_YUV8_1X24;
+		src1_fmt->code = MEDIA_BUS_FMT_YUV8_1X24;
+	}
+
+	/* SRC2 (RAW output) follows SINK format */
+	src2_fmt->code = format->code;
+	src2_fmt->width = format->width;
+	src2_fmt->height = format->height;
+
+	/* size check */
+	sink_fmt->width = format->width;
+	sink_fmt->height = format->height;
+
+	*format = *sink_fmt;
+}
+
+static void visconti_viif_isp_set_src_fmt(struct v4l2_subdev *sd,
+					  struct v4l2_subdev_state *sd_state,
+					  struct v4l2_mbus_framefmt *format, unsigned int pad,
+					  u32 which)
+{
+	struct v4l2_mbus_framefmt *sink_fmt, *src_fmt;
+	struct v4l2_rect *src_crop;
+
+	sink_fmt = visconti_viif_isp_get_pad_fmt(sd, sd_state, VIIF_ISP_PAD_SINK,
+						 V4L2_SUBDEV_FORMAT_ACTIVE);
+	src_fmt = visconti_viif_isp_get_pad_fmt(sd, sd_state, pad, which);
+	src_crop = visconti_viif_isp_get_pad_crop(sd, sd_state, pad, which);
+
+	/* sink::mbus_code is derived from src::mbus_code */
+	if (viif_get_mbus_rgb_out(sink_fmt->code))
+		src_fmt->code = MEDIA_BUS_FMT_RGB888_1X24;
+	else
+		src_fmt->code = MEDIA_BUS_FMT_YUV8_1X24;
+
+	/*size check*/
+	src_fmt->width = format->width;
+	src_fmt->height = format->height;
+
+	/*update crop*/
+	src_crop->width = format->width;
+	src_crop->height = format->height;
+
+	*format = *src_fmt;
+}
+
+static void visconti_viif_isp_set_src_fmt_rawpath(struct v4l2_subdev *sd,
+						  struct v4l2_subdev_state *sd_state,
+						  struct v4l2_mbus_framefmt *format,
+						  unsigned int pad, u32 which)
+{
+	struct v4l2_mbus_framefmt *sink_fmt, *src_fmt;
+
+	sink_fmt = visconti_viif_isp_get_pad_fmt(sd, sd_state, VIIF_ISP_PAD_SINK,
+						 V4L2_SUBDEV_FORMAT_ACTIVE);
+	src_fmt = visconti_viif_isp_get_pad_fmt(sd, sd_state, pad, which);
+
+	/* RAWPATH SRC pad has just the same configuration as SINK pad */
+	src_fmt->code = sink_fmt->code;
+	src_fmt->width = sink_fmt->width;
+	src_fmt->height = sink_fmt->height;
+
+	*format = *src_fmt;
+}
+
+static int visconti_viif_isp_set_fmt(struct v4l2_subdev *sd, struct v4l2_subdev_state *sd_state,
+				     struct v4l2_subdev_format *fmt)
+{
+	struct viif_device *viif_dev = ((struct isp_subdev *)sd)->viif_dev;
+
+	mutex_lock(&viif_dev->isp_subdev.ops_lock);
+
+	if (fmt->pad == VIIF_ISP_PAD_SINK)
+		visconti_viif_isp_set_sink_fmt(sd, sd_state, &fmt->format, fmt->which);
+	else if (fmt->pad == VIIF_ISP_PAD_SRC_PATH2)
+		visconti_viif_isp_set_src_fmt_rawpath(sd, sd_state, &fmt->format, fmt->pad,
+						      fmt->which);
+	else
+		visconti_viif_isp_set_src_fmt(sd, sd_state, &fmt->format, fmt->pad, fmt->which);
+
+	mutex_unlock(&viif_dev->isp_subdev.ops_lock);
+
+	return 0;
+}
+
+#define VISCONTI_VIIF_ISP_DEFAULT_WIDTH	  1920
+#define VISCONTI_VIIF_ISP_DEFAULT_HEIGHT  1080
+#define VISCONTI_VIIF_MAX_COMPOSED_WIDTH  8190
+#define VISCONTI_VIIF_MAX_COMPOSED_HEIGHT 4094
+
+static int visconti_viif_isp_init_config(struct v4l2_subdev *sd, struct v4l2_subdev_state *sd_state)
+{
+	struct viif_device *viif_dev = ((struct isp_subdev *)sd)->viif_dev;
+	struct v4l2_mbus_framefmt *sink_fmt, *src_fmt;
+	struct v4l2_rect *src_crop, *sink_compose;
+
+	sink_fmt =
+		v4l2_subdev_get_try_format(&viif_dev->isp_subdev.sd, sd_state, VIIF_ISP_PAD_SINK);
+	sink_fmt->width = VISCONTI_VIIF_ISP_DEFAULT_WIDTH;
+	sink_fmt->height = VISCONTI_VIIF_ISP_DEFAULT_HEIGHT;
+	sink_fmt->field = V4L2_FIELD_NONE;
+	sink_fmt->code = MEDIA_BUS_FMT_SRGGB10_1X10;
+
+	sink_compose =
+		v4l2_subdev_get_try_compose(&viif_dev->isp_subdev.sd, sd_state, VIIF_ISP_PAD_SINK);
+	sink_compose->top = 0;
+	sink_compose->left = 0;
+	sink_compose->width = VISCONTI_VIIF_ISP_DEFAULT_WIDTH;
+	sink_compose->height = VISCONTI_VIIF_ISP_DEFAULT_HEIGHT;
+
+	src_fmt = v4l2_subdev_get_try_format(&viif_dev->isp_subdev.sd, sd_state,
+					     VIIF_ISP_PAD_SRC_PATH0);
+	src_fmt->width = VISCONTI_VIIF_ISP_DEFAULT_WIDTH;
+	src_fmt->height = VISCONTI_VIIF_ISP_DEFAULT_HEIGHT;
+	src_fmt->field = V4L2_FIELD_NONE;
+	src_fmt->code = MEDIA_BUS_FMT_YUV8_1X24;
+
+	src_crop = v4l2_subdev_get_try_crop(&viif_dev->isp_subdev.sd, sd_state,
+					    VIIF_ISP_PAD_SRC_PATH0);
+	src_crop->top = 0;
+	src_crop->left = 0;
+	src_crop->width = VISCONTI_VIIF_ISP_DEFAULT_WIDTH;
+	src_crop->height = VISCONTI_VIIF_ISP_DEFAULT_HEIGHT;
+
+	src_fmt = v4l2_subdev_get_try_format(&viif_dev->isp_subdev.sd, sd_state,
+					     VIIF_ISP_PAD_SRC_PATH1);
+	src_fmt->width = VISCONTI_VIIF_ISP_DEFAULT_WIDTH;
+	src_fmt->height = VISCONTI_VIIF_ISP_DEFAULT_HEIGHT;
+	src_fmt->field = V4L2_FIELD_NONE;
+	src_fmt->code = MEDIA_BUS_FMT_YUV8_1X24;
+
+	src_crop = v4l2_subdev_get_try_crop(&viif_dev->isp_subdev.sd, sd_state,
+					    VIIF_ISP_PAD_SRC_PATH1);
+	src_crop->top = 0;
+	src_crop->left = 0;
+	src_crop->width = VISCONTI_VIIF_ISP_DEFAULT_WIDTH;
+	src_crop->height = VISCONTI_VIIF_ISP_DEFAULT_HEIGHT;
+
+	src_fmt = v4l2_subdev_get_try_format(&viif_dev->isp_subdev.sd, sd_state,
+					     VIIF_ISP_PAD_SRC_PATH2);
+	src_fmt->width = VISCONTI_VIIF_ISP_DEFAULT_WIDTH;
+	src_fmt->height = VISCONTI_VIIF_ISP_DEFAULT_HEIGHT;
+	src_fmt->field = V4L2_FIELD_NONE;
+	src_fmt->code = MEDIA_BUS_FMT_SRGGB10_1X10;
+
+	return 0;
+}
+
+static int visconti_viif_isp_get_selection(struct v4l2_subdev *sd,
+					   struct v4l2_subdev_state *sd_state,
+					   struct v4l2_subdev_selection *sel)
+{
+	struct viif_device *viif_dev = ((struct isp_subdev *)sd)->viif_dev;
+	struct v4l2_mbus_framefmt *sink_fmt;
+	int ret = -EINVAL;
+
+	mutex_lock(&viif_dev->isp_subdev.ops_lock);
+	if (sel->pad == VIIF_ISP_PAD_SINK) {
+		/* SINK PAD */
+		switch (sel->target) {
+		case V4L2_SEL_TGT_CROP:
+			sink_fmt = visconti_viif_isp_get_pad_fmt(sd, sd_state, VIIF_ISP_PAD_SINK,
+								 sel->which);
+			sel->r.top = 0;
+			sel->r.left = 0;
+			sel->r.width = sink_fmt->width;
+			sel->r.height = sink_fmt->height;
+			ret = 0;
+			break;
+		case V4L2_SEL_TGT_COMPOSE:
+			sel->r = *visconti_viif_isp_get_pad_compose(sd, sd_state, VIIF_ISP_PAD_SINK,
+								    sel->which);
+			ret = 0;
+			break;
+		case V4L2_SEL_TGT_COMPOSE_BOUNDS:
+			/* fixed value */
+			sel->r.top = 0;
+			sel->r.left = 0;
+			sel->r.width = VISCONTI_VIIF_MAX_COMPOSED_WIDTH;
+			sel->r.height = VISCONTI_VIIF_MAX_COMPOSED_HEIGHT;
+			ret = 0;
+			break;
+		}
+	} else if ((sel->pad == VIIF_ISP_PAD_SRC_PATH0) || (sel->pad == VIIF_ISP_PAD_SRC_PATH1)) {
+		/* SRC PAD */
+		switch (sel->target) {
+		case V4L2_SEL_TGT_CROP:
+			sel->r =
+				*visconti_viif_isp_get_pad_crop(sd, sd_state, sel->pad, sel->which);
+			ret = 0;
+			break;
+		}
+	}
+	mutex_unlock(&viif_dev->isp_subdev.ops_lock);
+
+	return ret;
+}
+
+static int visconti_viif_isp_set_selection(struct v4l2_subdev *sd,
+					   struct v4l2_subdev_state *sd_state,
+					   struct v4l2_subdev_selection *sel)
+{
+	struct viif_device *viif_dev = ((struct isp_subdev *)sd)->viif_dev;
+	struct v4l2_mbus_framefmt *src_fmt;
+	struct v4l2_rect *rect, *rect_compose;
+	int ret = -EINVAL;
+
+	mutex_lock(&viif_dev->isp_subdev.ops_lock);
+	/* only source::selection::crop is writable */
+	if (sel->pad == VIIF_ISP_PAD_SRC_PATH0 || sel->pad == VIIF_ISP_PAD_SRC_PATH1) {
+		switch (sel->target) {
+		case V4L2_SEL_TGT_CROP: {
+			/* check if new SRC::CROP is inside SINK::COMPOSE */
+			rect_compose = visconti_viif_isp_get_pad_compose(
+				sd, sd_state, VIIF_ISP_PAD_SINK, sel->which);
+			if (sel->r.top < rect_compose->top || sel->r.left < rect_compose->left ||
+			    (sel->r.top + sel->r.height) >
+				    (rect_compose->top + rect_compose->height) ||
+			    (sel->r.left + sel->r.width) >
+				    (rect_compose->left + rect_compose->width)) {
+				break;
+			}
+
+			rect = visconti_viif_isp_get_pad_crop(sd, sd_state, sel->pad, sel->which);
+			*rect = sel->r;
+
+			/* update SRC::FMT along with SRC::CROP */
+			src_fmt = visconti_viif_isp_get_pad_fmt(sd, sd_state, sel->pad, sel->which);
+			src_fmt->width = sel->r.width;
+			src_fmt->height = sel->r.height;
+			ret = 0;
+			break;
+		}
+		}
+	}
+	mutex_unlock(&viif_dev->isp_subdev.ops_lock);
+
+	return ret;
+}
+
+void visconti_viif_isp_set_compose_rect(struct viif_device *viif_dev,
+					struct viif_l2_roi_config *roi)
+{
+	struct v4l2_rect *rect;
+
+	rect = visconti_viif_isp_get_pad_compose(&viif_dev->isp_subdev.sd, NULL, VIIF_ISP_PAD_SINK,
+						 V4L2_SUBDEV_FORMAT_ACTIVE);
+	rect->top = 0;
+	rect->left = 0;
+	rect->width = roi->corrected_hsize[0];
+	rect->height = roi->corrected_vsize[0];
+}
+
+static const struct media_entity_operations visconti_viif_isp_media_ops = {
+	.link_validate = v4l2_subdev_link_validate,
+};
+
+static const struct v4l2_subdev_pad_ops visconti_viif_isp_pad_ops = {
+	.enum_mbus_code = visconti_viif_isp_enum_mbus_code,
+	.get_selection = visconti_viif_isp_get_selection,
+	.set_selection = visconti_viif_isp_set_selection,
+	.init_cfg = visconti_viif_isp_init_config,
+	.get_fmt = visconti_viif_isp_get_fmt,
+	.set_fmt = visconti_viif_isp_set_fmt,
+	.link_validate = v4l2_subdev_link_validate_default,
+};
+
+static const struct v4l2_subdev_video_ops visconti_viif_isp_video_ops = {
+	.s_stream = visconti_viif_isp_s_stream,
+};
+
+static const struct v4l2_subdev_ops visconti_viif_isp_ops = {
+	.video = &visconti_viif_isp_video_ops,
+	.pad = &visconti_viif_isp_pad_ops,
+};
+
+/* ----- register/remove isp subdevice node ----- */
+int visconti_viif_isp_register(struct viif_device *viif_dev)
+{
+	struct v4l2_subdev_state state = {
+		.pads = viif_dev->isp_subdev.pad_cfg,
+	};
+	struct media_pad *pads = viif_dev->isp_subdev.pads;
+	struct v4l2_subdev *sd = &viif_dev->isp_subdev.sd;
+	int ret;
+
+	viif_dev->isp_subdev.viif_dev = viif_dev;
+
+	v4l2_subdev_init(sd, &visconti_viif_isp_ops);
+	sd->flags |= V4L2_SUBDEV_FL_HAS_DEVNODE;
+	sd->entity.ops = &visconti_viif_isp_media_ops;
+	sd->entity.function = MEDIA_ENT_F_PROC_VIDEO_SCALER;
+	sd->owner = THIS_MODULE;
+	strscpy(sd->name, "visconti-viif:isp", sizeof(sd->name));
+
+	pads[0].flags = MEDIA_PAD_FL_SINK | MEDIA_PAD_FL_MUST_CONNECT;
+	pads[1].flags = MEDIA_PAD_FL_SOURCE | MEDIA_PAD_FL_MUST_CONNECT;
+	pads[2].flags = MEDIA_PAD_FL_SOURCE | MEDIA_PAD_FL_MUST_CONNECT;
+	pads[3].flags = MEDIA_PAD_FL_SOURCE | MEDIA_PAD_FL_MUST_CONNECT;
+
+	mutex_init(&viif_dev->isp_subdev.ops_lock);
+
+	ret = media_entity_pads_init(&sd->entity, 4, pads);
+	if (ret) {
+		dev_err(viif_dev->dev, "Failed on media_entity_pads_init\n");
+		return ret;
+	}
+
+	ret = v4l2_device_register_subdev(&viif_dev->v4l2_dev, sd);
+	if (ret) {
+		dev_err(viif_dev->dev, "Failed to resize ISP subdev\n");
+		goto err_cleanup_media_entity;
+	}
+
+	visconti_viif_isp_init_config(sd, &state);
+
+	return 0;
+
+err_cleanup_media_entity:
+	media_entity_cleanup(&sd->entity);
+	return ret;
+}
+
+void visconti_viif_isp_unregister(struct viif_device *viif_dev)
+{
+	v4l2_device_unregister_subdev(&viif_dev->isp_subdev.sd);
+	media_entity_cleanup(&viif_dev->isp_subdev.sd.entity);
+}
-- 
2.25.1


