Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93849623D02
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 09:01:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232835AbiKJIBC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 03:01:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232766AbiKJIA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 03:00:56 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5BF51CB01
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 00:00:54 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-368994f4bc0so9771617b3.14
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 00:00:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4Mlhvy7LVfX8RsDMkCEDUilCHxpF1dj6dt7DixRlTa4=;
        b=jPPXDBURrtwvQYF7HqZe1kuBWz2SIPYRRDSQtlyqhuoTABxMiNSDGB8emDo6vChHDR
         iu1TzAaWrfurbfhGuDFJxE2Mt4v5pI/awSB5deSi4zuv0iuxy4CLnCy3y+LVJP3n6BcC
         SeHjDNU3f7s70gvNz0+FKq63K5z5meTnMe/hpWOBcZuktLxsAcSbrf1+zqBZ7B08rO+z
         2DUjXshNnjwqv4uYI0ZtrBHa24nZugnB/LIT4EaxY7a/DYzXDrQU6rlXj9zWD/FTJS6x
         U0qqEmuuHHz7Mwrs7e3UtbjhDI0fGqAx4efkz9Gd2kzNSRLMqIH2tCU1b8XqgSyoWWzT
         Z/0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4Mlhvy7LVfX8RsDMkCEDUilCHxpF1dj6dt7DixRlTa4=;
        b=A6QEBxZxuDPNGjGGIHOCQlGnRSFV2g+Rz2TzkmVXeLMDR9lJrWRXkYLOdZX8KryQ+a
         jG0VQLu9XXQZm3YvPG6Ug7dJWIYBe0QeLgNrO5T0Pkuh11wKyoHZizz3wY8mASO1lgN5
         VdYi3zAjJ5LAIBQA2luJ6lQRBz13cd6cteCXWuc/NhCgpGq1e+m3oOPMBkRMdztIzr5x
         0Xwfka4GqbM84lX47NeHExJwYwKRJ9cKIXkLLGKVHi6su8kKLb6UZXzySVAMP+7qOf94
         7CwtVZgldWJmCt8w4ALrx+n21m8vZScyvOkVcNtdtQGAYpBGi5oHjuA/kAgFdQZ1XtiB
         olSA==
X-Gm-Message-State: ACrzQf0S/7bXRcYwuUAuybeHeJkacNXTsQnq8UmKTndNdcPwKw0X3McG
        DyMSK+a/ZKqtuW0j6i9k+kMrQZ7qMspt5ffLODg=
X-Google-Smtp-Source: AMsMyM4pgZz7Aqn+mMO1hKSHYVMHBBEwBe8XCMCPsSgLaapP8GBJk4j9P9eexF1isicAugfgbzq7Sb/ABU5svWsuIqU=
X-Received: from albertccwang.ntc.corp.google.com ([2401:fa00:fc:202:2c6f:5c28:5579:9e27])
 (user=albertccwang job=sendgmr) by 2002:a0d:f985:0:b0:370:72ad:bc17 with SMTP
 id j127-20020a0df985000000b0037072adbc17mr48281356ywf.233.1668067253938; Thu,
 10 Nov 2022 00:00:53 -0800 (PST)
Date:   Thu, 10 Nov 2022 16:00:04 +0800
In-Reply-To: <20221110080006.3563429-1-albertccwang@google.com>
Message-Id: <20221110080006.3563429-2-albertccwang@google.com>
Mime-Version: 1.0
References: <20221110080006.3563429-1-albertccwang@google.com>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Subject: [PATCH v2 1/3] usb: host: add xhci hooks for USB offload
From:   Albert Wang <albertccwang@google.com>
To:     mathias.nyman@intel.com, gregkh@linuxfoundation.org
Cc:     badhri@google.com, howardyen@google.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
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

From: Howard Yen <howardyen@google.com>

This change is to provide USB offload function which allows to offload some
xHCI operations on co-processor. This is especially designed for USB audio
usecase. The co-processor is able to manipulate some USB structures in his
own memory, like SRAM.

There are several offload_ops introduced by this patch:

struct xhci_offload_ops - function callbacks for offlad specific operations
{
	@offload_init:
		- called for vendor init process during xhci-plat-hcd
		  probe.
	@offload_cleanup:
		- called for vendor cleanup process during xhci-plat-hcd
		  remove.
	@is_usb_offload_enabled:
		- called to check if usb offload enabled.
	@alloc_dcbaa:
		- called when allocating vendor specific dcbaa during
		  memory initializtion.
	@free_dcbaa:
		- called to free vendor specific dcbaa when cleanup the
		  memory.
	@alloc_transfer_ring:
		- called when vendor specific transfer ring allocation is required
	@free_transfer_ring:
		- called to free vendor specific transfer ring
	@usb_offload_skip_urb:
		- called to check if need to skip urb enqueue
}

The xhci hooks with prefix "xhci_vendor_" on the ops in xhci_offload_ops.
For example, offload_init ops will be invoked by xhci_vendor_offload_init()
hook,is_usb_offload_enabled ops will be invoked by
xhci_vendor_is_usb_offload_enabled(), and so on.

Signed-off-by: Howard Yen <howardyen@google.com>
---
Changes in v2:
- Remove irq work, device context synchronization
- Remove export symbols
- Use 'offload_ops' instead of 'vendor_ops'

 drivers/usb/host/xhci-mem.c  | 97 +++++++++++++++++++++++++++++++-----
 drivers/usb/host/xhci-plat.c | 23 +++++++++
 drivers/usb/host/xhci-plat.h |  1 +
 drivers/usb/host/xhci.c      | 21 ++++++++
 drivers/usb/host/xhci.h      | 31 ++++++++++++
 5 files changed, 160 insertions(+), 13 deletions(-)

diff --git a/drivers/usb/host/xhci-mem.c b/drivers/usb/host/xhci-mem.c
index 81ca2bc1f0be..ab0ef19d4fa3 100644
--- a/drivers/usb/host/xhci-mem.c
+++ b/drivers/usb/host/xhci-mem.c
@@ -361,6 +361,38 @@ static int xhci_alloc_segments_for_ring(struct xhci_hcd *xhci,
 	return 0;
 }
 
+static struct xhci_ring *xhci_vendor_alloc_transfer_ring(struct xhci_hcd *xhci,
+		u32 endpoint_type, enum xhci_ring_type ring_type,
+		unsigned int max_packet, gfp_t mem_flags)
+{
+	struct xhci_offload_ops *ops = xhci_offload_get_ops(xhci);
+
+	if (ops && ops->alloc_transfer_ring)
+		return ops->alloc_transfer_ring(xhci, endpoint_type, ring_type,
+						max_packet, mem_flags);
+	return 0;
+}
+
+static void xhci_vendor_free_transfer_ring(struct xhci_hcd *xhci,
+		struct xhci_virt_device *virt_dev, unsigned int ep_index)
+{
+	struct xhci_offload_ops *ops = xhci_offload_get_ops(xhci);
+
+	if (ops && ops->free_transfer_ring)
+		ops->free_transfer_ring(xhci, virt_dev, ep_index);
+}
+
+static bool xhci_vendor_is_offload_enabled(struct xhci_hcd *xhci,
+		struct xhci_virt_device *virt_dev, unsigned int ep_index)
+{
+	struct xhci_offload_ops *ops = xhci_offload_get_ops(xhci);
+
+	if (ops && ops->is_offload_enabled)
+		return ops->is_offload_enabled(xhci, virt_dev, ep_index);
+
+	return false;
+}
+
 /*
  * Create a new ring with zero or more segments.
  *
@@ -412,7 +444,11 @@ void xhci_free_endpoint_ring(struct xhci_hcd *xhci,
 		struct xhci_virt_device *virt_dev,
 		unsigned int ep_index)
 {
-	xhci_ring_free(xhci, virt_dev->eps[ep_index].ring);
+	if (xhci_vendor_is_offload_enabled(xhci, virt_dev, ep_index))
+		xhci_vendor_free_transfer_ring(xhci, virt_dev, ep_index);
+	else
+		xhci_ring_free(xhci, virt_dev->eps[ep_index].ring);
+
 	virt_dev->eps[ep_index].ring = NULL;
 }
 
@@ -885,7 +921,7 @@ void xhci_free_virt_device(struct xhci_hcd *xhci, int slot_id)
 
 	for (i = 0; i < 31; i++) {
 		if (dev->eps[i].ring)
-			xhci_ring_free(xhci, dev->eps[i].ring);
+			xhci_free_endpoint_ring(xhci, dev, i);
 		if (dev->eps[i].stream_info)
 			xhci_free_stream_info(xhci,
 					dev->eps[i].stream_info);
@@ -1487,8 +1523,16 @@ int xhci_endpoint_init(struct xhci_hcd *xhci,
 		mult = 0;
 
 	/* Set up the endpoint ring */
-	virt_dev->eps[ep_index].new_ring =
-		xhci_ring_alloc(xhci, 2, 1, ring_type, max_packet, mem_flags);
+	if (xhci_vendor_is_offload_enabled(xhci, virt_dev, ep_index) &&
+	    usb_endpoint_xfer_isoc(&ep->desc)) {
+		virt_dev->eps[ep_index].new_ring =
+			xhci_vendor_alloc_transfer_ring(xhci, endpoint_type, ring_type,
+							max_packet, mem_flags);
+	} else {
+		virt_dev->eps[ep_index].new_ring =
+			xhci_ring_alloc(xhci, 2, 1, ring_type, max_packet, mem_flags);
+	}
+
 	if (!virt_dev->eps[ep_index].new_ring)
 		return -ENOMEM;
 
@@ -1832,6 +1876,23 @@ void xhci_free_erst(struct xhci_hcd *xhci, struct xhci_erst *erst)
 	erst->entries = NULL;
 }
 
+static void xhci_vendor_alloc_dcbaa(
+		struct xhci_hcd *xhci, gfp_t flags)
+{
+	struct xhci_offload_ops *ops = xhci_offload_get_ops(xhci);
+
+	if (ops && ops->alloc_dcbaa)
+		return ops->alloc_dcbaa(xhci, flags);
+}
+
+static void xhci_vendor_free_dcbaa(struct xhci_hcd *xhci)
+{
+	struct xhci_offload_ops *ops = xhci_offload_get_ops(xhci);
+
+	if (ops && ops->free_dcbaa)
+		ops->free_dcbaa(xhci);
+}
+
 void xhci_mem_cleanup(struct xhci_hcd *xhci)
 {
 	struct device	*dev = xhci_to_hcd(xhci)->self.sysdev;
@@ -1883,9 +1944,13 @@ void xhci_mem_cleanup(struct xhci_hcd *xhci)
 	xhci_dbg_trace(xhci, trace_xhci_dbg_init,
 			"Freed medium stream array pool");
 
-	if (xhci->dcbaa)
-		dma_free_coherent(dev, sizeof(*xhci->dcbaa),
-				xhci->dcbaa, xhci->dcbaa->dma);
+	if (xhci_vendor_is_offload_enabled(xhci, NULL, 0)) {
+		xhci_vendor_free_dcbaa(xhci);
+	} else {
+		if (xhci->dcbaa)
+			dma_free_coherent(dev, sizeof(*xhci->dcbaa),
+					xhci->dcbaa, xhci->dcbaa->dma);
+	}
 	xhci->dcbaa = NULL;
 
 	scratchpad_free(xhci);
@@ -2422,15 +2487,21 @@ int xhci_mem_init(struct xhci_hcd *xhci, gfp_t flags)
 	 * xHCI section 5.4.6 - Device Context array must be
 	 * "physically contiguous and 64-byte (cache line) aligned".
 	 */
-	xhci->dcbaa = dma_alloc_coherent(dev, sizeof(*xhci->dcbaa), &dma,
-			flags);
-	if (!xhci->dcbaa)
-		goto fail;
-	xhci->dcbaa->dma = dma;
+	if (xhci_vendor_is_offload_enabled(xhci, NULL, 0)) {
+		xhci_vendor_alloc_dcbaa(xhci, flags);
+		if (!xhci->dcbaa)
+			goto fail;
+	} else {
+		xhci->dcbaa = dma_alloc_coherent(dev, sizeof(*xhci->dcbaa), &dma,
+				flags);
+		if (!xhci->dcbaa)
+			goto fail;
+		xhci->dcbaa->dma = dma;
+	}
 	xhci_dbg_trace(xhci, trace_xhci_dbg_init,
 			"// Device context base array address = 0x%llx (DMA), %p (virt)",
 			(unsigned long long)xhci->dcbaa->dma, xhci->dcbaa);
-	xhci_write_64(xhci, dma, &xhci->op_regs->dcbaa_ptr);
+	xhci_write_64(xhci, xhci->dcbaa->dma, &xhci->op_regs->dcbaa_ptr);
 
 	/*
 	 * Initialize the ring segment pool.  The ring must be a contiguous
diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
index 5fb55bf19493..2f04acb42fa6 100644
--- a/drivers/usb/host/xhci-plat.c
+++ b/drivers/usb/host/xhci-plat.c
@@ -173,6 +173,23 @@ static const struct of_device_id usb_xhci_of_match[] = {
 MODULE_DEVICE_TABLE(of, usb_xhci_of_match);
 #endif
 
+static int xhci_vendor_init(struct xhci_hcd *xhci)
+{
+	struct xhci_offload_ops *ops = xhci_offload_get_ops(xhci);
+
+	if (ops && ops->offload_init)
+		return ops->offload_init(xhci);
+	return 0;
+}
+
+static void xhci_vendor_cleanup(struct xhci_hcd *xhci)
+{
+	struct xhci_offload_ops *ops = xhci_offload_get_ops(xhci);
+
+	if (ops && ops->offload_cleanup)
+		ops->offload_cleanup(xhci);
+}
+
 static int xhci_plat_probe(struct platform_device *pdev)
 {
 	const struct xhci_plat_priv *priv_match;
@@ -317,6 +334,10 @@ static int xhci_plat_probe(struct platform_device *pdev)
 			goto disable_clk;
 	}
 
+	ret = xhci_vendor_init(xhci);
+	if (ret)
+		goto disable_usb_phy;
+
 	hcd->tpl_support = of_usb_host_tpl_support(sysdev->of_node);
 
 	if (priv && (priv->quirks & XHCI_SKIP_PHY_INIT))
@@ -410,6 +431,8 @@ static int xhci_plat_remove(struct platform_device *dev)
 	if (shared_hcd)
 		usb_put_hcd(shared_hcd);
 
+	xhci_vendor_cleanup(xhci);
+
 	clk_disable_unprepare(clk);
 	clk_disable_unprepare(reg_clk);
 	usb_put_hcd(hcd);
diff --git a/drivers/usb/host/xhci-plat.h b/drivers/usb/host/xhci-plat.h
index 1fb149d1fbce..5aa0d38fa01a 100644
--- a/drivers/usb/host/xhci-plat.h
+++ b/drivers/usb/host/xhci-plat.h
@@ -13,6 +13,7 @@
 struct xhci_plat_priv {
 	const char *firmware_name;
 	unsigned long long quirks;
+	struct xhci_offload_ops *offload_ops;
 	void (*plat_start)(struct usb_hcd *);
 	int (*init_quirk)(struct usb_hcd *);
 	int (*suspend_quirk)(struct usb_hcd *);
diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index 79d7931c048a..75d39fe0d44d 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -22,6 +22,7 @@
 #include "xhci-trace.h"
 #include "xhci-debugfs.h"
 #include "xhci-dbgcap.h"
+#include "xhci-plat.h"
 
 #define DRIVER_AUTHOR "Sarah Sharp"
 #define DRIVER_DESC "'eXtensible' Host Controller (xHC) Driver"
@@ -1669,6 +1670,11 @@ static int xhci_urb_enqueue(struct usb_hcd *hcd, struct urb *urb, gfp_t mem_flag
 		return -ENODEV;
 	}
 
+	if (xhci_vendor_usb_offload_skip_urb(xhci, urb)) {
+		xhci_dbg(xhci, "skip urb for usb offload\n");
+		return -EOPNOTSUPP;
+	}
+
 	if (usb_endpoint_xfer_isoc(&urb->ep->desc))
 		num_tds = urb->number_of_packets;
 	else if (usb_endpoint_is_bulk_out(&urb->ep->desc) &&
@@ -4441,6 +4447,21 @@ static int __maybe_unused xhci_change_max_exit_latency(struct xhci_hcd *xhci,
 	return ret;
 }
 
+struct xhci_offload_ops *xhci_offload_get_ops(struct xhci_hcd *xhci)
+{
+	return xhci_to_priv(xhci)->offload_ops;
+}
+EXPORT_SYMBOL_GPL(xhci_offload_get_ops);
+
+bool xhci_vendor_usb_offload_skip_urb(struct xhci_hcd *xhci, struct urb *urb)
+{
+	struct xhci_offload_ops *ops = xhci_offload_get_ops(xhci);
+
+	if (ops && ops->usb_offload_skip_urb)
+		return ops->usb_offload_skip_urb(xhci, urb);
+	return false;
+}
+
 #ifdef CONFIG_PM
 
 /* BESL to HIRD Encoding array for USB2 LPM */
diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
index cc084d9505cd..d67bea2c180d 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -2229,6 +2229,37 @@ static inline struct xhci_ring *xhci_urb_to_transfer_ring(struct xhci_hcd *xhci,
 					urb->stream_id);
 }
 
+/**
+ * struct xhci_offload_ops - function callbacks for offload specific operations
+ * @offload_init: called for offload init process
+ * @offload_cleanup: called for offload cleanup process
+ * @is_usb_offload_enabled: called to check if xhci offload enabled
+ * @alloc_dcbaa: called when allocating specific dcbaa for offload
+ * @free_dcbaa: called to free specific dcbaa for offload
+ * @alloc_transfer_ring: called when remote transfer ring allocation is required
+ * @free_transfer_ring: called to free specific transfer ring for offload
+ * @usb_offload_skip_urb: called to check if need to skip urb
+ */
+struct xhci_offload_ops {
+	int (*offload_init)(struct xhci_hcd *xhci);
+	void (*offload_cleanup)(struct xhci_hcd *xhci);
+	bool (*is_offload_enabled)(struct xhci_hcd *xhci,
+				       struct xhci_virt_device *vdev,
+				       unsigned int ep_index);
+	void (*alloc_dcbaa)(struct xhci_hcd *xhci, gfp_t flags);
+	void (*free_dcbaa)(struct xhci_hcd *xhci);
+
+	struct xhci_ring *(*alloc_transfer_ring)(struct xhci_hcd *xhci,
+			u32 endpoint_type, enum xhci_ring_type ring_type,
+			unsigned int max_packet, gfp_t mem_flags);
+	void (*free_transfer_ring)(struct xhci_hcd *xhci,
+			struct xhci_virt_device *virt_dev, unsigned int ep_index);
+	bool (*usb_offload_skip_urb)(struct xhci_hcd *xhci, struct urb *urb);
+};
+
+struct xhci_offload_ops *xhci_offload_get_ops(struct xhci_hcd *xhci);
+bool xhci_vendor_usb_offload_skip_urb(struct xhci_hcd *xhci, struct urb *urb);
+
 /*
  * TODO: As per spec Isochronous IDT transmissions are supported. We bypass
  * them anyways as we where unable to find a device that matches the
-- 
2.38.1.431.g37b22c650d-goog

