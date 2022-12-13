Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE68164B704
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 15:12:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235856AbiLMOMQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 09:12:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235864AbiLMOLr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 09:11:47 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E88442188C
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 06:10:43 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id t9-20020a5b03c9000000b006cff5077dc9so16705630ybp.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 06:10:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=IazsSpG7fcgPawhilo+Akx8DgvbU0pRdUVn94g1nQSg=;
        b=ZFDLWcExas1fbQAmMKyGhT3OkbQxOQaEdfriBTS6JdZQI00n/GQbuN66Lco5XImtjT
         kZIESnkH67i2T9PFNraNCKHUpMCXy8YU8SM3W2w44yU1e74PD6FMPXW4Datn8jzdqZh6
         qc5wAFe6Od8GC7LU52GGwuQJpQpjACC8RKyeacKMWHSWg2cHJ9PG7o5TPpx5Csee1j+e
         LFHjIEfQXKc4iy7RRb8uvGdFFlNWyfnb+nMkD+/Gji6Czb34n7DpG2iSdCmXBLjVoYdR
         chlU38qpEI2YaSfu5jMANepvAtfASD3QZy+zDCQCCdN73mSHs5VwgFP36rY9ixjoC4iA
         XpCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IazsSpG7fcgPawhilo+Akx8DgvbU0pRdUVn94g1nQSg=;
        b=yAGUJQ6yqrDe9apQ2gWBNP8q+aCTj/Q+L0hoZ2M6/RAEGAYkxZgADDhc4pWQ9NQFuD
         Ti6tAakNei4c4e6bXb8INmxmtKKS3vX53Kqx7vsM2wXMzCFH3An6zpyJJlB2YqDpZC4b
         FEHJwFw22la32YSWrPHS95+BA1C2F7iCvPZ8Inxlj+KUCMQv/nhqdR6XqkQ8w9kNyC5Y
         LObySJyCTXf4fHHAMZj4dL7PzIvRooDM31ZQ/0uDw+KR6GoveRV+rZAzFTKaxeq1aSpU
         9Ays8o4PelwD7iLQX3TE2dU5OQg99HUtrPLmCLy/Ud7hCSYn2RVlRL9mRhyJJPrIc0eS
         ke6w==
X-Gm-Message-State: ANoB5pkYVDJOsYFiaynkZkgM37y8uPBP0vI7vc366CEiSR8nAVWxSs9J
        W3xjpHfp9K+QetPUJBiT3Wj65x1ZjtcKR5z2M+I=
X-Google-Smtp-Source: AA0mqf6bZq5lk2o5ROtjASap72pHyN/9rHcvIX+dtcfadEo7eZVnw77Tk3X65zw7lM6/NbOHmEqZUmyw/5I8+TA28cQ=
X-Received: from albertccwang.c.googlers.com ([fda3:e722:ac3:cc00:3:22c1:c0a8:83d])
 (user=albertccwang job=sendgmr) by 2002:a25:2d44:0:b0:6f0:6dfa:c762 with SMTP
 id s4-20020a252d44000000b006f06dfac762mr64433088ybe.109.1670940643201; Tue,
 13 Dec 2022 06:10:43 -0800 (PST)
Date:   Tue, 13 Dec 2022 14:10:05 +0000
In-Reply-To: <20221213141005.3068792-1-albertccwang@google.com>
Mime-Version: 1.0
References: <20221213141005.3068792-1-albertccwang@google.com>
X-Mailer: git-send-email 2.39.0.rc1.256.g54fd8350bd-goog
Message-ID: <20221213141005.3068792-4-albertccwang@google.com>
Subject: [PATCH v3 3/3] usb: host: add the xhci offload hooks implementations
From:   Albert Wang <albertccwang@google.com>
To:     mathias.nyman@intel.com, gregkh@linuxfoundation.org
Cc:     badhri@google.com, howardyen@google.com, pumahsu@google.com,
        raychi@google.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, Albert Wang <albertccwang@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HK_RANDOM_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the offload hooks implementations which are used in the xHCI driver
for vendor offload function, and some functions will call to
co-processor driver for further offload operations.

Signed-off-by: Albert Wang <albertccwang@google.com>
Signed-off-by: Howard Yen <howardyen@google.com>
---
Changes in v3:
- Add new implementation driver file in v3

---
 drivers/usb/host/aoc-usb.c           | 198 ++++++++++++++
 drivers/usb/host/aoc-usb.h           | 108 ++++++++
 drivers/usb/host/xhci-offload-impl.c | 396 +++++++++++++++++++++++++++
 3 files changed, 702 insertions(+)
 create mode 100644 drivers/usb/host/aoc-usb.c
 create mode 100644 drivers/usb/host/aoc-usb.h
 create mode 100644 drivers/usb/host/xhci-offload-impl.c

diff --git a/drivers/usb/host/aoc-usb.c b/drivers/usb/host/aoc-usb.c
new file mode 100644
index 000000000000..b51f26755a63
--- /dev/null
+++ b/drivers/usb/host/aoc-usb.c
@@ -0,0 +1,198 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright 2022 Google LLC. All Rights Reserved.
+ *
+ * Interface to the AoC USB control service
+ */
+
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/of_platform.h>
+#include <linux/notifier.h>
+#include <linux/platform_device.h>
+
+#include "aoc-usb.h"
+
+#define AOC_USB_NAME "aoc_usb"
+
+extern struct blocking_notifier_head aoc_usb_notifier_list;
+
+int xhci_set_offload_state(bool enabled)
+{
+	return blocking_notifier_call_chain(&aoc_usb_notifier_list, SET_OFFLOAD_STATE, &enabled);
+}
+
+int xhci_set_dcbaa_ptr(u64 aoc_dcbaa_ptr)
+{
+	return blocking_notifier_call_chain(&aoc_usb_notifier_list, SET_DCBAA_PTR, &aoc_dcbaa_ptr);
+}
+
+int xhci_setup_done(void)
+{
+	return blocking_notifier_call_chain(&aoc_usb_notifier_list, SETUP_DONE, NULL);
+}
+
+int xhci_sync_conn_stat(unsigned int bus_id, unsigned int dev_num, unsigned int slot_id,
+			       unsigned int conn_stat)
+{
+	struct conn_stat_args args;
+
+	args.bus_id = bus_id;
+	args.dev_num = dev_num;
+	args.slot_id = slot_id;
+	args.conn_stat = conn_stat;
+
+	return blocking_notifier_call_chain(&aoc_usb_notifier_list, SYNC_CONN_STAT, &args);
+}
+
+int usb_host_mode_state_notify(enum usb_conn_state usb_state)
+{
+	return xhci_sync_conn_stat(0, 0, 0, usb_state);
+}
+
+int xhci_set_isoc_tr_info(u16 ep_id, u16 dir, struct xhci_ring *ep_ring)
+{
+	struct get_isoc_tr_info_args tr_info;
+
+	tr_info.ep_id = ep_id;
+	tr_info.dir = dir;
+	tr_info.num_segs = ep_ring->num_segs;
+	tr_info.max_packet = ep_ring->bounce_buf_len;
+	tr_info.type = ep_ring->type;
+	tr_info.seg_ptr = ep_ring->first_seg->dma;
+	tr_info.cycle_state = ep_ring->cycle_state;
+	tr_info.num_trbs_free = ep_ring->num_trbs_free;
+
+	return blocking_notifier_call_chain(&aoc_usb_notifier_list, SET_ISOC_TR_INFO, &tr_info);
+}
+
+static int aoc_usb_match(struct device *dev, void *data)
+{
+	if (sysfs_streq(dev_driver_string(dev), "xhci-hcd-exynos"))
+		return 1;
+
+	return 0;
+}
+
+static bool aoc_usb_is_hcd_working(void)
+{
+	struct device_node *np;
+	struct platform_device *pdev;
+	struct device *udev;
+	int ret;
+
+	np = of_find_node_by_name(NULL, "dwc3");
+	if (!np || !of_device_is_available(np)) {
+		pr_err("Cannot find dwc3 device node\n");
+		return false;
+	}
+
+	pdev = of_find_device_by_node(np);
+	if (!pdev)
+		return false;
+
+	udev = device_find_child(&pdev->dev, NULL, aoc_usb_match);
+	if (!udev)
+		return false;
+
+	ret = usb_host_mode_state_notify(USB_CONNECTED);
+	if (ret)
+		dev_err(udev, "Notifying AoC for xhci driver status is failed.\n");
+
+	return true;
+}
+
+static struct work_struct usb_host_mode_checking_ws;
+static void usb_host_mode_checking_work(struct work_struct *ws)
+{
+	if (aoc_usb_is_hcd_working())
+		pr_info("USB HCD is working, send notification to AoC\n");
+}
+
+/*
+ * This variable used to present if aoc_usb module was probed done. If offload
+ * is enabled, the controller needs to wait for the aoc_usb probe done and then
+ * continue the controller's probe.
+ */
+static bool aoc_usb_probe_done;
+static int aoc_usb_probe(struct aoc_service_dev *adev)
+{
+	struct device *dev = &adev->dev;
+	struct aoc_usb_drvdata *drvdata;
+
+	drvdata = kzalloc(sizeof(*drvdata), GFP_KERNEL);
+	if (!drvdata)
+		return -ENOMEM;
+
+	drvdata->adev = adev;
+
+	mutex_init(&drvdata->lock);
+
+	drvdata->ws = wakeup_source_register(dev, dev_name(dev));
+	if (!drvdata->ws) {
+		dev_err(&drvdata->adev->dev, "wakeup_source_register failed!\n");
+		return -ENOMEM;
+	}
+
+	drvdata->usb_conn_state = 0;
+	dev_set_drvdata(dev, drvdata);
+
+	aoc_usb_probe_done = true;
+
+	schedule_work(&usb_host_mode_checking_ws);
+
+	return 0;
+}
+
+static int aoc_usb_remove(struct aoc_service_dev *adev)
+{
+	struct aoc_usb_drvdata *drvdata = dev_get_drvdata(&adev->dev);
+
+	wakeup_source_unregister(drvdata->ws);
+	mutex_destroy(&drvdata->lock);
+
+	kfree(drvdata);
+
+	aoc_usb_probe_done = false;
+
+	return 0;
+}
+
+bool is_aoc_usb_probe_done(void)
+{
+	return aoc_usb_probe_done;
+}
+
+static const char *const aoc_usb_service_names[] = {
+	"usb_control",
+	NULL,
+};
+
+static struct aoc_driver aoc_usb_driver = {
+	.drv = {
+		.name = AOC_USB_NAME,
+	},
+	.service_names = aoc_usb_service_names,
+	.probe = aoc_usb_probe,
+	.remove = aoc_usb_remove,
+};
+
+static int __init aoc_usb_init(void)
+{
+	xhci_offload_helper_init();
+
+	INIT_WORK(&usb_host_mode_checking_ws, usb_host_mode_checking_work);
+
+	return driver_register(&aoc_usb_driver.drv);
+}
+
+static void __exit aoc_usb_exit(void)
+{
+	driver_unregister(&aoc_usb_driver.drv);
+}
+
+module_init(aoc_usb_init);
+module_exit(aoc_usb_exit);
+
+MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR("Howard Yen (Google)");
+MODULE_DESCRIPTION("USB driver for AoC");
diff --git a/drivers/usb/host/aoc-usb.h b/drivers/usb/host/aoc-usb.h
new file mode 100644
index 000000000000..a756abd00d01
--- /dev/null
+++ b/drivers/usb/host/aoc-usb.h
@@ -0,0 +1,108 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2022 Google Corp.
+ *
+ * Author:
+ *  Howard.Yen <howardyen@google.com>
+ */
+
+#ifndef __LINUX_AOC_USB_H
+#define __LINUX_AOC_USB_H
+
+#include "xhci.h"
+
+struct aoc_service_dev {
+	struct device dev;
+	wait_queue_head_t read_queue;
+	wait_queue_head_t write_queue;
+
+	void *ipc_base;
+	void *prvdata;
+	uint64_t suspend_rx_count;
+
+	uint8_t mbox_index;
+	uint8_t service_index;
+
+	bool dead;
+	bool wake_capable;
+};
+
+struct aoc_driver {
+	struct device_driver drv;
+
+	/* Array of service names to match against.  Last entry must be NULL */
+	const char * const *service_names;
+	int (*probe)(struct aoc_service_dev *dev);
+	int (*remove)(struct aoc_service_dev *dev);
+};
+
+enum usb_offload_msg {
+	SET_DCBAA_PTR,
+	GET_TR_DEQUEUE_PTR,
+	SETUP_DONE,
+	SET_ISOC_TR_INFO,
+	SYNC_CONN_STAT,
+	SET_OFFLOAD_STATE
+};
+
+enum usb_offload_op_mode {
+	USB_OFFLOAD_STOP,
+	USB_OFFLOAD_DRAM
+};
+
+enum usb_conn_state {
+	USB_DISCONNECTED,
+	USB_CONNECTED
+};
+
+enum usb_recover_state {
+	NONE,
+	RECOVER_HOST_OFF,
+	RECOVER_HOST_ON,
+	RECOVERED
+};
+
+struct aoc_usb_drvdata {
+	struct aoc_service_dev *adev;
+
+	struct mutex lock;
+	struct wakeup_source *ws;
+
+	struct notifier_block nb;
+
+	unsigned int usb_conn_state;
+};
+
+struct conn_stat_args {
+	u16 bus_id;
+	u16 dev_num;
+	u16 slot_id;
+	u32 conn_stat;
+};
+
+struct get_isoc_tr_info_args {
+	u16 ep_id;
+	u16 dir;
+	u32 type;
+	u32 num_segs;
+	u32 seg_ptr;
+	u32 max_packet;
+	u32 deq_ptr;
+	u32 enq_ptr;
+	u32 cycle_state;
+	u32 num_trbs_free;
+};
+
+int xhci_set_offload_state(bool enabled);
+int xhci_set_dcbaa_ptr(u64 aoc_dcbaa_ptr);
+int xhci_setup_done(void);
+int xhci_sync_conn_stat(unsigned int bus_id, unsigned int dev_num, unsigned int slot_id,
+			       unsigned int conn_stat);
+int usb_host_mode_state_notify(enum usb_conn_state usb_state);
+int xhci_set_isoc_tr_info(u16 ep_id, u16 dir, struct xhci_ring *ep_ring);
+
+bool is_aoc_usb_probe_done(void);
+
+int xhci_offload_helper_init(void);
+
+#endif /* __LINUX_AOC_USB_H */
diff --git a/drivers/usb/host/xhci-offload-impl.c b/drivers/usb/host/xhci-offload-impl.c
new file mode 100644
index 000000000000..738595382f7e
--- /dev/null
+++ b/drivers/usb/host/xhci-offload-impl.c
@@ -0,0 +1,396 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2022 Google Corp.
+ *
+ * Author:
+ *  Howard.Yen <howardyen@google.com>
+ */
+
+#include <linux/dma-mapping.h>
+#include <linux/of_reserved_mem.h>
+#include <linux/usb.h>
+#include <linux/workqueue.h>
+#include <linux/usb/hcd.h>
+
+#include "aoc-usb.h"
+#include "xhci-plat.h"
+
+struct xhci_offload_data {
+	struct xhci_hcd *xhci;
+
+	bool usb_accessory_enabled;
+	bool usb_audio_offload;
+	bool dt_direct_usb_access;
+	bool offload_state;
+
+	enum usb_offload_op_mode op_mode;
+};
+
+static struct xhci_offload_data *offload_data;
+struct xhci_offload_data *xhci_get_offload_data(void)
+{
+	return offload_data;
+}
+
+/*
+ * Determine if an USB device is a compatible devices:
+ *     True: Devices are audio class and they contain ISOC endpoint
+ *    False: Devices are not audio class or they're audio class but no ISOC endpoint or
+ *           they have at least one interface is video class
+ */
+static bool is_compatible_with_usb_audio_offload(struct usb_device *udev)
+{
+	struct usb_endpoint_descriptor *epd;
+	struct usb_host_config *config;
+	struct usb_host_interface *alt;
+	struct usb_interface_cache *intfc;
+	int i, j, k;
+	bool is_audio = false;
+
+	config = udev->config;
+	for (i = 0; i < config->desc.bNumInterfaces; i++) {
+		intfc = config->intf_cache[i];
+		for (j = 0; j < intfc->num_altsetting; j++) {
+			alt = &intfc->altsetting[j];
+
+			if (alt->desc.bInterfaceClass == USB_CLASS_VIDEO) {
+				is_audio = false;
+				goto out;
+			}
+
+			if (alt->desc.bInterfaceClass == USB_CLASS_AUDIO) {
+				for (k = 0; k < alt->desc.bNumEndpoints; k++) {
+					epd = &alt->endpoint[k].desc;
+					if (usb_endpoint_xfer_isoc(epd)) {
+						is_audio = true;
+						break;
+					}
+				}
+			}
+		}
+	}
+
+out:
+	return is_audio;
+}
+
+/*
+ * check the usb device including the video class:
+ *     True: Devices contain video class
+ *    False: Device doesn't contain video class
+ */
+static bool is_usb_video_device(struct usb_device *udev)
+{
+	struct usb_host_config *config;
+	struct usb_host_interface *alt;
+	struct usb_interface_cache *intfc;
+	int i, j;
+	bool is_video = false;
+
+	if (!udev || !udev->config)
+		return is_video;
+
+	config = udev->config;
+
+	for (i = 0; i < config->desc.bNumInterfaces; i++) {
+		intfc = config->intf_cache[i];
+		for (j = 0; j < intfc->num_altsetting; j++) {
+			alt = &intfc->altsetting[j];
+
+			if (alt->desc.bInterfaceClass == USB_CLASS_VIDEO) {
+				is_video = true;
+				goto out;
+			}
+		}
+	}
+
+out:
+	return is_video;
+}
+
+static int xhci_udev_notify(struct notifier_block *self, unsigned long action,
+				void *dev)
+{
+	struct usb_device *udev = dev;
+	struct xhci_offload_data *offload_data = xhci_get_offload_data();
+
+	switch (action) {
+	case USB_DEVICE_ADD:
+		if (is_compatible_with_usb_audio_offload(udev)) {
+			dev_dbg(&udev->dev, "Compatible with usb audio offload\n");
+			if (offload_data->op_mode == USB_OFFLOAD_DRAM) {
+				xhci_sync_conn_stat(udev->bus->busnum, udev->devnum, udev->slot_id,
+						    USB_CONNECTED);
+			}
+		}
+		offload_data->usb_accessory_enabled = false;
+		break;
+	case USB_DEVICE_REMOVE:
+		if (is_compatible_with_usb_audio_offload(udev) &&
+		    (offload_data->op_mode == USB_OFFLOAD_DRAM)) {
+			xhci_sync_conn_stat(udev->bus->busnum, udev->devnum, udev->slot_id,
+					    USB_DISCONNECTED);
+		}
+		offload_data->usb_accessory_enabled = false;
+		break;
+	}
+
+	return NOTIFY_OK;
+}
+
+static struct notifier_block xhci_udev_nb = {
+	.notifier_call = xhci_udev_notify,
+};
+
+static int usb_audio_offload_init(struct xhci_hcd *xhci)
+{
+	struct device *dev = xhci_to_hcd(xhci)->self.sysdev;
+	struct xhci_offload_data *offload_data = xhci_get_offload_data();
+	int ret;
+	u32 out_val;
+
+	if (!is_aoc_usb_probe_done()) {
+		dev_info(dev, "%s: deferring the probe\n", __func__);
+		return -EPROBE_DEFER;
+	}
+
+	offload_data = kzalloc(sizeof(struct xhci_offload_data), GFP_KERNEL);
+	if (!offload_data)
+		return -ENOMEM;
+
+	if (!of_property_read_u32(dev->of_node, "offload", &out_val))
+		offload_data->usb_audio_offload = (out_val == 1) ? true : false;
+
+	ret = of_reserved_mem_device_init(dev);
+	if (ret) {
+		dev_err(dev, "Could not get reserved memory\n");
+		kfree(offload_data);
+		return ret;
+	}
+
+	offload_data->dt_direct_usb_access =
+		of_property_read_bool(dev->of_node, "direct-usb-access") ? true : false;
+	if (!offload_data->dt_direct_usb_access)
+		dev_warn(dev, "Direct USB access is not supported\n");
+
+	offload_data->offload_state = true;
+
+	usb_register_notify(&xhci_udev_nb);
+	offload_data->op_mode = USB_OFFLOAD_DRAM;
+	offload_data->xhci = xhci;
+
+	return 0;
+}
+
+static void usb_audio_offload_cleanup(struct xhci_hcd *xhci)
+{
+	struct xhci_offload_data *offload_data = xhci_get_offload_data();
+
+	offload_data->usb_audio_offload = false;
+	offload_data->op_mode = USB_OFFLOAD_STOP;
+	offload_data->xhci = NULL;
+
+	usb_unregister_notify(&xhci_udev_nb);
+
+	/* Notification for xhci driver removing */
+	usb_host_mode_state_notify(USB_DISCONNECTED);
+
+	kfree(offload_data);
+}
+
+static bool is_offload_enabled(struct xhci_hcd *xhci,
+		struct xhci_virt_device *vdev, unsigned int ep_index)
+{
+	struct usb_device *udev;
+	struct xhci_offload_data *offload_data = xhci_get_offload_data();
+	bool global_enabled = offload_data->op_mode != USB_OFFLOAD_STOP;
+	struct xhci_ring *ep_ring;
+
+	if (vdev == NULL || vdev->eps[ep_index].ring == NULL)
+		return global_enabled;
+
+	udev = vdev->udev;
+
+	if (global_enabled) {
+		ep_ring = vdev->eps[ep_index].ring;
+		if (offload_data->op_mode == USB_OFFLOAD_DRAM) {
+			if (is_usb_video_device(udev))
+				return false;
+			else if (ep_ring->type == TYPE_ISOC)
+				return offload_data->offload_state;
+		}
+	}
+
+	return false;
+}
+
+static bool is_usb_bulk_transfer_enabled(struct xhci_hcd *xhci, struct urb *urb)
+{
+	struct xhci_offload_data *offload_data = xhci_get_offload_data();
+	struct usb_endpoint_descriptor *desc = &urb->ep->desc;
+	int ep_type = usb_endpoint_type(desc);
+	struct usb_ctrlrequest *cmd;
+	bool skip_bulk = false;
+
+	cmd = (struct usb_ctrlrequest *) urb->setup_packet;
+
+	if (ep_type == USB_ENDPOINT_XFER_CONTROL) {
+		if (!usb_endpoint_dir_in(desc) && cmd->bRequest == 0x35)
+			offload_data->usb_accessory_enabled = true;
+		else
+			offload_data->usb_accessory_enabled = false;
+	}
+
+	if (ep_type == USB_ENDPOINT_XFER_BULK && !usb_endpoint_dir_in(desc))
+		skip_bulk = offload_data->usb_accessory_enabled;
+
+	return skip_bulk;
+}
+
+static void alloc_dcbaa(struct xhci_hcd *xhci, gfp_t flags)
+{
+	dma_addr_t dma;
+	struct device *dev = xhci_to_hcd(xhci)->self.sysdev;
+	struct xhci_offload_data *offload_data = xhci_get_offload_data();
+
+	if (offload_data->op_mode == USB_OFFLOAD_DRAM) {
+		xhci->dcbaa = dma_alloc_coherent(dev, sizeof(*xhci->dcbaa),
+						 &dma, flags);
+		if (!xhci->dcbaa)
+			return;
+
+		xhci->dcbaa->dma = dma;
+		if (xhci_set_dcbaa_ptr(xhci->dcbaa->dma) != 0) {
+			xhci_err(xhci, "Set DCBAA pointer failed\n");
+			xhci->dcbaa = NULL;
+			return;
+		}
+		xhci_setup_done();
+
+		xhci_dbg(xhci, "Set dcbaa_ptr=%llx to AoC\n", xhci->dcbaa->dma);
+	} else {
+		xhci->dcbaa = dma_alloc_coherent(dev, sizeof(*xhci->dcbaa),
+						 &dma, flags);
+		if (!xhci->dcbaa)
+			return;
+
+		xhci->dcbaa->dma = dma;
+	}
+}
+
+static void free_dcbaa(struct xhci_hcd *xhci)
+{
+	struct device *dev = xhci_to_hcd(xhci)->self.sysdev;
+
+	if (!xhci->dcbaa)
+		return;
+
+	dma_free_coherent(dev, sizeof(*xhci->dcbaa),
+			  xhci->dcbaa, xhci->dcbaa->dma);
+
+	xhci->dcbaa = NULL;
+}
+
+static struct xhci_ring *alloc_transfer_ring(struct xhci_hcd *xhci,
+		u32 endpoint_type, enum xhci_ring_type ring_type,
+		unsigned int max_packet, gfp_t mem_flags)
+{
+	struct xhci_ring *ep_ring;
+	u16 dir;
+
+	ep_ring = xhci_ring_alloc(xhci, 1, 1, ring_type, max_packet, mem_flags);
+	dir = endpoint_type == ISOC_IN_EP ? 0 : 1;
+
+	xhci_set_isoc_tr_info(0, dir, ep_ring);
+
+	return ep_ring;
+}
+
+static void free_transfer_ring(struct xhci_hcd *xhci, struct xhci_virt_device *virt_dev,
+				unsigned int ep_index)
+{
+	struct xhci_ring *ring, *new_ring;
+	struct xhci_ep_ctx *ep_ctx;
+	struct xhci_input_control_ctx *ctrl_ctx;
+	u32 ep_type;
+	u32 ep_is_added, ep_is_dropped;
+
+	ring = virt_dev->eps[ep_index].ring;
+	new_ring = virt_dev->eps[ep_index].new_ring;
+	ep_ctx = xhci_get_ep_ctx(xhci, virt_dev->out_ctx, ep_index);
+	ep_type = CTX_TO_EP_TYPE(le32_to_cpu(ep_ctx->ep_info2));
+
+	ctrl_ctx = xhci_get_input_control_ctx(virt_dev->in_ctx);
+	if (!ctrl_ctx) {
+		xhci_warn(xhci, "%s: Could not get input context, bad type.\n", __func__);
+		return;
+	}
+	ep_is_added = EP_IS_ADDED(ctrl_ctx, ep_index);
+	ep_is_dropped = EP_IS_DROPPED(ctrl_ctx, ep_index);
+
+	xhci_dbg(xhci, "%s: ep %u is added(0x%x), is dropped(0x%x)\n", __func__, ep_index,
+		 ep_is_added, ep_is_dropped);
+
+	if (ring) {
+		xhci_dbg(xhci, "%s: ep_index=%u, ep_type=%u, ring type=%u, new_ring=%pK\n",
+			 __func__, ep_index, ep_type, ring->type, new_ring);
+
+		xhci_ring_free(xhci, virt_dev->eps[ep_index].ring);
+
+		virt_dev->eps[ep_index].ring = NULL;
+
+		if (ep_is_added == 0 && ep_is_dropped == 0)
+			return;
+	}
+
+	if (new_ring) {
+		xhci_dbg(xhci, "%s: ep_index=%u, ep_type=%u, new_ring type=%u\n", __func__,
+			ep_index, ep_type, new_ring->type);
+
+		xhci_ring_free(xhci, virt_dev->eps[ep_index].new_ring);
+
+		virt_dev->eps[ep_index].new_ring = NULL;
+
+		return;
+	}
+}
+
+static bool offload_skip_urb(struct xhci_hcd *xhci, struct urb *urb)
+{
+	struct xhci_virt_device *vdev = xhci->devs[urb->dev->slot_id];
+	struct usb_endpoint_descriptor *desc = &urb->ep->desc;
+	int ep_type = usb_endpoint_type(desc);
+	unsigned int ep_index;
+
+	if (ep_type == USB_ENDPOINT_XFER_CONTROL)
+		ep_index = (unsigned int)(usb_endpoint_num(desc)*2);
+	else
+		ep_index = (unsigned int)(usb_endpoint_num(desc)*2) +
+			   (usb_endpoint_dir_in(desc) ? 1 : 0) - 1;
+
+	xhci_dbg(xhci, "%s: ep_index=%u, ep_type=%d\n", __func__, ep_index, ep_type);
+
+	if (is_offload_enabled(xhci, vdev, ep_index))
+		return true;
+
+	if (is_usb_bulk_transfer_enabled(xhci, urb))
+		return true;
+
+	return false;
+}
+
+static struct xhci_offload_ops offload_ops = {
+	.offload_init = usb_audio_offload_init,
+	.offload_cleanup = usb_audio_offload_cleanup,
+	.is_offload_enabled = is_offload_enabled,
+	.alloc_dcbaa = alloc_dcbaa,
+	.free_dcbaa = free_dcbaa,
+	.alloc_transfer_ring = alloc_transfer_ring,
+	.free_transfer_ring = free_transfer_ring,
+	.usb_offload_skip_urb = offload_skip_urb,
+};
+
+int xhci_offload_helper_init(void)
+{
+	return xhci_plat_register_offload_ops(&offload_ops);
+}
-- 
2.39.0.rc1.256.g54fd8350bd-goog

