Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81B6467C35A
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 04:16:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236379AbjAZDQy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 22:16:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236422AbjAZDQl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 22:16:41 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B64E66020;
        Wed, 25 Jan 2023 19:16:01 -0800 (PST)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30Q3Da6b006094;
        Thu, 26 Jan 2023 03:14:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=qBXiNQtwFlkX5W6deQxEhKIHG8aNPycqcvlIiLU6plo=;
 b=Nh9CSZXqcbZC/NvDF6HxcfxTuLrye0ZOkprVKjpeQXBb/8x1V0yrhdPFWjfQRRk/GwU6
 KXkRvmH2LND4TGz6t9azQUMOEg+L9MwZghDJVve7glh3NzrBnIaela7EmAPnAM7BbrJs
 AjATUm1VkkbIid2BBveOp7qw8SdElhhomK+2zBmPXS8yh/WME9iANSgOZbXcbpFrYL+8
 qDhmu7qtslbpHwK9L3piRgpSI3IU6ixgrJMFcHlhHDiHtH9Ylvch/kapwNNdbe79cHom
 hXIMC6P13CZxwtN63ItCTiCFi6rUUgh1q5cZeFV3hQSkGMrtB4BBudHOFyqjFkv9sGUg gQ== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nb0qrsx71-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Jan 2023 03:14:43 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30Q3EgdP016036
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Jan 2023 03:14:42 GMT
Received: from hu-wcheng-lv.qualcomm.com (10.49.16.6) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Wed, 25 Jan 2023 19:14:41 -0800
From:   Wesley Cheng <quic_wcheng@quicinc.com>
To:     <srinivas.kandagatla@linaro.org>, <mathias.nyman@intel.com>,
        <perex@perex.cz>, <lgirdwood@gmail.com>, <andersson@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <gregkh@linuxfoundation.org>,
        <Thinh.Nguyen@synopsys.com>, <broonie@kernel.org>,
        <bgoswami@quicinc.com>, <tiwai@suse.com>, <robh+dt@kernel.org>,
        <agross@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <quic_jackp@quicinc.com>,
        <quic_plai@quicinc.com>, Wesley Cheng <quic_wcheng@quicinc.com>
Subject: [RFC PATCH v2 07/22] ASoC: Add SOC USB APIs for adding an USB backend
Date:   Wed, 25 Jan 2023 19:14:09 -0800
Message-ID: <20230126031424.14582-8-quic_wcheng@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230126031424.14582-1-quic_wcheng@quicinc.com>
References: <20230126031424.14582-1-quic_wcheng@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: a_XQr21frpgJ8epFwFoDPKQB0M26kM23
X-Proofpoint-ORIG-GUID: a_XQr21frpgJ8epFwFoDPKQB0M26kM23
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-25_14,2023-01-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 lowpriorityscore=0 phishscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0
 priorityscore=1501 spamscore=0 suspectscore=0 clxscore=1015 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301260028
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some platforms may want to register its USB port to be handled by the ASoC
framework.  Audio playback/capture support is also handled entirely by the
vendor ASoC drivers.

Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
---
 include/sound/soc-usb.h |  33 +++++++
 sound/soc/Makefile      |   2 +-
 sound/soc/soc-usb.c     | 202 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 236 insertions(+), 1 deletion(-)
 create mode 100644 include/sound/soc-usb.h
 create mode 100644 sound/soc/soc-usb.c

diff --git a/include/sound/soc-usb.h b/include/sound/soc-usb.h
new file mode 100644
index 000000000000..ec422a8a834f
--- /dev/null
+++ b/include/sound/soc-usb.h
@@ -0,0 +1,33 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#ifndef __LINUX_SND_SOC_USB_H
+#define __LINUX_SND_SOC_USB_H
+
+/**
+ * struct snd_soc_usb
+ * @component - Reference to DAPM component
+ * @connection_status_cb - callback to notify connection events
+ * @priv_data - vendor data
+ **/
+struct snd_soc_usb {
+	struct list_head list;
+	struct device *dev;
+	struct snd_soc_component *component;
+	int (*connection_status_cb)(struct snd_soc_usb *usb, int card_idx,
+				int connected);
+	void *priv_data;
+};
+
+int snd_soc_usb_connect(struct device *usbdev, int card_idx);
+int snd_soc_usb_disconnect(struct device *usbdev);
+void snd_soc_usb_set_priv_data(struct device *dev, void *priv);
+void *snd_soc_usb_get_priv_data(struct device *usbdev);
+
+struct snd_soc_usb *snd_soc_usb_add_port(struct device *dev,
+			int (*connection_cb)(struct snd_soc_usb *usb, int card_idx,
+			int connected));
+int snd_soc_usb_remove_port(struct device *dev);
+#endif
diff --git a/sound/soc/Makefile b/sound/soc/Makefile
index 507eaed1d6a1..3305ceb59d84 100644
--- a/sound/soc/Makefile
+++ b/sound/soc/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
-snd-soc-core-objs := soc-core.o soc-dapm.o soc-jack.o soc-utils.o soc-dai.o soc-component.o
+snd-soc-core-objs := soc-core.o soc-dapm.o soc-jack.o soc-usb.o soc-utils.o soc-dai.o soc-component.o
 snd-soc-core-objs += soc-pcm.o soc-devres.o soc-ops.o soc-link.o soc-card.o
 snd-soc-core-$(CONFIG_SND_SOC_COMPRESS) += soc-compress.o
 
diff --git a/sound/soc/soc-usb.c b/sound/soc/soc-usb.c
new file mode 100644
index 000000000000..bfce6c9609e1
--- /dev/null
+++ b/sound/soc/soc-usb.c
@@ -0,0 +1,202 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+#include <linux/of.h>
+#include <linux/usb.h>
+#include <sound/soc.h>
+#include <sound/soc-usb.h>
+#include "../usb/card.h"
+
+static DEFINE_MUTEX(ctx_mutex);
+static LIST_HEAD(usb_ctx_list);
+
+#define for_each_usb_ctx(ctx)			\
+	list_for_each_entry(ctx, &usb_ctx_list, list)
+
+static struct device_node *snd_soc_find_phandle(struct device *dev)
+{
+	struct device_node *node;
+
+	node = of_parse_phandle(dev->of_node, "usb-soc-be", 0);
+	if (!node)
+		return ERR_PTR(-ENODEV);
+
+	return node;
+}
+
+static struct snd_soc_usb *snd_soc_find_usb_ctx(struct device *dev)
+{
+	struct device_node *node;
+	struct snd_soc_usb *ctx = NULL;
+
+	node = snd_soc_find_phandle(dev);
+	if (IS_ERR(node))
+		return NULL;
+
+	mutex_lock(&ctx_mutex);
+	for_each_usb_ctx(ctx) {
+		if (ctx->dev->of_node == node) {
+			of_node_put(node);
+			mutex_unlock(&ctx_mutex);
+			return ctx;
+		}
+	}
+	of_node_put(node);
+	mutex_unlock(&ctx_mutex);
+
+	return NULL;
+}
+
+/**
+ * snd_soc_usb_get_priv_data() - Retrieve private data stored
+ * @usbdev: USB bus sysdev
+ *
+ * Fetch the private data stored in the USB SND SOC structure.  This is
+ * intended to be called by the USB offloading class driver, in order to
+ * attain parameters about the USB backend device.
+ *
+ */
+void *snd_soc_usb_get_priv_data(struct device *usbdev)
+{
+	struct snd_soc_usb *ctx;
+
+	if (!usbdev)
+		return NULL;
+
+	ctx = snd_soc_find_usb_ctx(usbdev);
+
+	return ctx ? ctx->priv_data : NULL;
+}
+EXPORT_SYMBOL_GPL(snd_soc_usb_get_priv_data);
+
+/**
+ * snd_soc_usb_set_priv_data() - Set private data stored
+ * @dev: USB backend device
+ * @priv: private data to store
+ *
+ * Save data describing the USB backend device parameters.  This is intended
+ * to be called by the ASoC USB backend driver.
+ *
+ */
+void snd_soc_usb_set_priv_data(struct device *dev, void *priv)
+{
+	struct snd_soc_usb *ctx;
+
+	mutex_lock(&ctx_mutex);
+	for_each_usb_ctx(ctx) {
+		if (dev->of_node == ctx->dev->of_node) {
+			ctx->priv_data = priv;
+			break;
+		}
+	}
+	mutex_unlock(&ctx_mutex);
+}
+EXPORT_SYMBOL_GPL(snd_soc_usb_set_priv_data);
+
+/**
+ * snd_soc_usb_add_port() - Add a USB backend port
+ * @dev: USB backend device
+ * @connection_cb: connection status callback
+ *
+ * Register a USB backend device to the SND USB SOC framework.  Memory is
+ * allocated as part of the USB backend device.
+ *
+ */
+struct snd_soc_usb *snd_soc_usb_add_port(struct device *dev,
+			int (*connection_cb)(struct snd_soc_usb *usb, int card_idx,
+			int connected))
+{
+	struct snd_soc_usb *usb;
+
+	usb = devm_kzalloc(dev, sizeof(*usb), GFP_KERNEL);
+	if (!usb)
+		return ERR_PTR(-ENOMEM);
+
+	usb->connection_status_cb = connection_cb;
+	usb->dev = dev;
+
+	mutex_lock(&ctx_mutex);
+	list_add_tail(&usb->list, &usb_ctx_list);
+	mutex_unlock(&ctx_mutex);
+
+	return usb;
+}
+EXPORT_SYMBOL_GPL(snd_soc_usb_add_port);
+
+/**
+ * snd_soc_usb_remove_port() - Remove a USB backend port
+ * @dev: USB backend device
+ *
+ * Remove a USB backend device from USB SND SOC.  Memory is freed when USB
+ * backend is removed.
+ *
+ */
+int snd_soc_usb_remove_port(struct device *dev)
+{
+	struct snd_soc_usb *ctx, *tmp;
+
+	mutex_lock(&ctx_mutex);
+	list_for_each_entry_safe(ctx, tmp, &usb_ctx_list, list) {
+		if (ctx->dev == dev) {
+			list_del(&ctx->list);
+			break;
+		}
+	}
+	mutex_unlock(&ctx_mutex);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(snd_soc_usb_remove_port);
+
+/**
+ * snd_soc_usb_connect() - Notification of USB device connection
+ * @usbdev: USB bus device
+ * @card_idx: USB SND card instance
+ *
+ * Notify of a new USB SND device connection.  The card_idx can be used to
+ * handle how the USB backend selects, which device to enable offloading on.
+ *
+ */
+int snd_soc_usb_connect(struct device *usbdev, int card_idx)
+{
+	struct snd_soc_usb *ctx;
+
+	if (!usbdev)
+		return -ENODEV;
+
+	ctx = snd_soc_find_usb_ctx(usbdev);
+	if (!ctx)
+		return -ENODEV;
+
+	if (ctx->connection_status_cb)
+		ctx->connection_status_cb(ctx, card_idx, 1);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(snd_soc_usb_connect);
+
+/**
+ * snd_soc_usb_connect() - Notification of USB device connection
+ * @usbdev: USB bus device
+ *
+ * Notify of a new USB SND device disconnection to the USB backend.
+ *
+ */
+int snd_soc_usb_disconnect(struct device *usbdev)
+{
+	struct snd_soc_usb *ctx;
+
+	if (!usbdev)
+		return -ENODEV;
+
+	ctx = snd_soc_find_usb_ctx(usbdev);
+	if (!ctx)
+		return -ENODEV;
+
+	if (ctx->connection_status_cb)
+		ctx->connection_status_cb(ctx, -1, 0);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(snd_soc_usb_disconnect);
