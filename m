Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAB3960ED1E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 02:41:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234214AbiJ0Alg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 20:41:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234071AbiJ0Ala (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 20:41:30 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0EEE7FE6C
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 17:41:28 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id t6-20020a25b706000000b006b38040b6f7so16242459ybj.6
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 17:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kyyM0qteYt+Lf7RLYSvZS5KQjtZIwVjRvQ4LhjUtVoc=;
        b=HC8wBeC2AYBwwdXqL5VqkplN9DO6Xs+YkaC3n+d3233pHZfY0HTclXPiQ1Qx9/m/SV
         9khL60AxGyfnQ24Qy62EpRraGQdG2GNP8qM5vFhcBkpgtlc9q0o05TYvGrWvqEiXXsc1
         XBs0Ha0aVaNsn1IO4zYk3NUEuU1vEaxafVP0GYPw2rg7zG+uZXPxY2VZZiWlP7Z1+y2y
         +3m2gRSVP+0TktWeKCuf9DLv1ntDlK8gmWeB5AKaIDPlAZ4DVCpjvGfY9x6W7CWXlBtb
         LbNMf4kAu3FH99kqH+fNbrsQp4O6j+94Bcgs+LKvtskodKPxmO0mOZLuYRTzAwhwhq2K
         GQNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kyyM0qteYt+Lf7RLYSvZS5KQjtZIwVjRvQ4LhjUtVoc=;
        b=Yrg6ercm5mjJ/Ql9ieR9wYXI+C7sIe6AiLMOB6Fa8dEq+Z+nRJBcPPzXkmSIKoGAWa
         XIHTKIjANf+5F8gGhjvsYWvRukS7pK4Lld9W832eRh0nz61kEF4h5HeZcPGiChPjT+Sc
         Idx+ow/CqSPAHyVBfSaSq8K4sve30AOp4wKLhL2DA3iljiMHXfiozsT/WxI4Qbw5ro2s
         DQ0Fc7poondw5nNgfEZKDLLdy1adYLfS9Sb1hTQ8V1vth93C7GeSWPoap9oqD2rH+VjO
         unm1mPC7o5lNVaBPoi6cDtWDNttJrWzGFcDpEdQwDX4f+BQ1SR1sx5LDK5KYdXHz01CT
         BgsQ==
X-Gm-Message-State: ACrzQf23kye1rfy5nWRCxjS9Ik/0ZSRaxkFTz/cl8BAisEKdTACwyfm8
        X/L2CZDu1528Qj8su3ogljCiU6AauKLXJb1M37w=
X-Google-Smtp-Source: AMsMyM6o8+Z48I8+oGx0AVplBlyRXdYY/I6eTmM1cAo5yAWSn8/uhIvan0Z2pnEIiiJt9Qe8mX56T67APx6DzXOrdSI=
X-Received: from albertccwang.ntc.corp.google.com ([2401:fa00:fc:202:57bd:c29a:f9b1:f09c])
 (user=albertccwang job=sendgmr) by 2002:a25:d0d1:0:b0:6cb:3ae4:7de2 with SMTP
 id h200-20020a25d0d1000000b006cb3ae47de2mr14726395ybg.505.1666831288153; Wed,
 26 Oct 2022 17:41:28 -0700 (PDT)
Date:   Thu, 27 Oct 2022 08:40:50 +0800
In-Reply-To: <20221027004050.4192111-1-albertccwang@google.com>
Message-Id: <20221027004050.4192111-4-albertccwang@google.com>
Mime-Version: 1.0
References: <20221027004050.4192111-1-albertccwang@google.com>
X-Mailer: git-send-email 2.38.0.135.g90850a2211-goog
Subject: [PATCH 3/3] usb: host: add the xhci offload hooks implementations
From:   Albert Wang <albertccwang@google.com>
To:     mathias.nyman@intel.com, gregkh@linuxfoundation.org
Cc:     badhri@google.com, howardyen@google.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Albert Wang <albertccwang@google.com>
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

Add the offload hooks implementations and call to co-processor for
offload operations.

Signed-off-by: Albert Wang <albertccwang@google.com>
---
 drivers/usb/host/xhci-offload-impl.c | 492 +++++++++++++++++++++++++++
 1 file changed, 492 insertions(+)
 create mode 100644 drivers/usb/host/xhci-offload-impl.c

diff --git a/drivers/usb/host/xhci-offload-impl.c b/drivers/usb/host/xhci-offload-impl.c
new file mode 100644
index 000000000000..90e546d63fbe
--- /dev/null
+++ b/drivers/usb/host/xhci-offload-impl.c
@@ -0,0 +1,492 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2020 Google Corp.
+ *
+ * Author:
+ *  Howard.Yen <howardyen@google.com>
+ */
+
+#include <linux/dmapool.h>
+#include <linux/dma-mapping.h>
+#include <linux/of.h>
+#include <linux/of_reserved_mem.h>
+#include <linux/pm_wakeup.h>
+#include <linux/slab.h>
+#include <linux/usb.h>
+#include <linux/workqueue.h>
+#include <linux/usb/hcd.h>
+
+#include "xhci.h"
+#include "xhci-plat.h"
+
+enum usb_offload_op_mode {
+	USB_OFFLOAD_STOP,
+	USB_OFFLOAD_DRAM
+};
+
+enum usb_state {
+	USB_DISCONNECTED,
+	USB_CONNECTED
+};
+
+enum usb_offload_msg {
+	SET_DCBAA_PTR,
+	SETUP_DONE,
+	SET_ISOC_TR_INFO,
+	SYNC_CONN_STAT,
+	SET_OFFLOAD_STATE
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
+/*
+ * This is the driver call to co-processor for offload operations.
+ */
+int offload_driver_call(enum usb_offload_msg msg, void *ptr)
+{
+	enum usb_offload_msg offload_msg;
+	void *argptr;
+
+	offload_msg = msg;
+	argptr = ptr;
+
+	return 0;
+}
+
+static int xhci_sync_conn_stat(unsigned int bus_id, unsigned int dev_num, unsigned int slot_id,
+				unsigned int conn_stat)
+{
+	struct conn_stat_args conn_args;
+
+	conn_args.bus_id = bus_id;
+	conn_args.dev_num = dev_num;
+	conn_args.slot_id = slot_id;
+	conn_args.conn_stat = conn_stat;
+
+	return offload_driver_call(SYNC_CONN_STAT, &conn_args);
+}
+
+static int usb_host_mode_state_notify(enum usb_state usb_state)
+{
+	return xhci_sync_conn_stat(0, 0, 0, usb_state);
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
+	offload_data = NULL;
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
+static int xhci_set_dcbaa_ptr(u64 dcbaa_ptr)
+{
+	return offload_driver_call(SET_DCBAA_PTR, &dcbaa_ptr);
+}
+
+static int xhci_setup_done(void)
+{
+	return offload_driver_call(SETUP_DONE, NULL);
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
+static int xhci_set_isoc_tr_info(u16 ep_id, u16 dir, struct xhci_ring *ep_ring)
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
+	return offload_driver_call(SET_ISOC_TR_INFO, &tr_info);
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
2.38.0.135.g90850a2211-goog

