Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0BA660ED19
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 02:41:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233993AbiJ0AlR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 20:41:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbiJ0AlN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 20:41:13 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98FC06A52E
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 17:41:12 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id oo18-20020a17090b1c9200b0020bdba475afso2517386pjb.4
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 17:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xF/nz0PjSe1bRrievHFP0p30tg5DgJ194I3faa5Li1Y=;
        b=XnKtBFDC5bQ0hteNM/KIxDI0pzi0X+3/rF8+qWQLjfln+1CyyXczR46PKPSt81Ja3w
         Wb/avi3PMF75+Fx20mC6EAj1J18Uw4GXyWunzbWO+7Mmhfdkseo8J6PBGVOlxTRubhXJ
         /Ms6gjAa6E/9BFs5XAoTUf4G8mfmjOMoMdK9kSV6pYpYB8GXo2Vj3AlpDzifBylPluUn
         kWuRiESkA6EYZQSyqXcM7OPJEOTnQ8H0AHf7NkGk68isfCB4GrXlGrUYVe1cPyQJdnFs
         XYv+rtXzHF6uKieNO2jS3Ah9qTJJUHFsY0q+sQMg5dAbTl4v7oyxAEVy+Ew3fYlSYxRW
         ADfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xF/nz0PjSe1bRrievHFP0p30tg5DgJ194I3faa5Li1Y=;
        b=RWtKpm+WRckH5W0KmFj9+24kK7Nmg+Gq0416TYBXX9hefMY31tsdxbpy5i5HQOcuXk
         KjZLj6NwAafO0L/8yUUBExK1juAyAQVEF82HpL1BvCl8Fpf862ashbUn4PjbTRrmtJ7a
         fcJGyr05htr6OQyUOmCg4TvMfmOLfrYwY30t0F2BQaaXG7c4yrIpNxfbfQM/VRoAvpvp
         9O5nkbvod8Aq/4XdJs8HUq4P9JisifSfWlTGaH9sMVqdocJqMh/U0bZjhJEi49GFCON3
         3N15u4XVhhUdqPjoG+/3DeUW7/4Z8IHbffsT2cv9xJwxJgSZyps57s8Prgco2MwUNZZf
         w6sw==
X-Gm-Message-State: ACrzQf1ebBlq0CCpGgj+c3UuQhveIZct1v/GU3jxOo7mgFnn+6vpyZA1
        a5uivkaqDFqq4PWq1GGKoNGioIeJC4xAfEIvN20=
X-Google-Smtp-Source: AMsMyM7rKzhTIXzbbQfSapbyv+Sfh8wPy1v9p2+5y89yV92IXYIIc43k6O/HVbu9vc4Y+P8riqzSp5YjDeLLtEKQH+0=
X-Received: from albertccwang.ntc.corp.google.com ([2401:fa00:fc:202:57bd:c29a:f9b1:f09c])
 (user=albertccwang job=sendgmr) by 2002:a17:90b:4c07:b0:213:44f5:6073 with
 SMTP id na7-20020a17090b4c0700b0021344f56073mr7086526pjb.184.1666831272214;
 Wed, 26 Oct 2022 17:41:12 -0700 (PDT)
Date:   Thu, 27 Oct 2022 08:40:48 +0800
In-Reply-To: <20221027004050.4192111-1-albertccwang@google.com>
Message-Id: <20221027004050.4192111-2-albertccwang@google.com>
Mime-Version: 1.0
References: <20221027004050.4192111-1-albertccwang@google.com>
X-Mailer: git-send-email 2.38.0.135.g90850a2211-goog
Subject: [PATCH 1/3] usb: host: add xhci hooks for USB offload
From:   Albert Wang <albertccwang@google.com>
To:     mathias.nyman@intel.com, gregkh@linuxfoundation.org
Cc:     badhri@google.com, howardyen@google.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Greg Kroah-Harktman <gregkh@google.com>
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
Link: https://lore.kernel.org/r/20210119101044.1637023-1-howardyen@google.com
Signed-off-by: Greg Kroah-Harktman <gregkh@google.com>
---
 drivers/usb/host/xhci-mem.c  | 97 +++++++++++++++++++++++++++++++-----
 drivers/usb/host/xhci-plat.c | 23 +++++++++
 drivers/usb/host/xhci-plat.h |  1 +
 drivers/usb/host/xhci.c      | 21 ++++++++
 drivers/usb/host/xhci.h      | 31 ++++++++++++
 5 files changed, 160 insertions(+), 13 deletions(-)

diff --git a/drivers/usb/host/xhci-mem.c b/drivers/usb/host/xhci-mem.c
index 9e56aa28efcd..0449109a973d 100644
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
@@ -1483,8 +1519,16 @@ int xhci_endpoint_init(struct xhci_hcd *xhci,
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
 
@@ -1828,6 +1872,23 @@ void xhci_free_erst(struct xhci_hcd *xhci, struct xhci_erst *erst)
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
@@ -1879,9 +1940,13 @@ void xhci_mem_cleanup(struct xhci_hcd *xhci)
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
@@ -2418,15 +2483,21 @@ int xhci_mem_init(struct xhci_hcd *xhci, gfp_t flags)
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
index 5176765c4013..aa3a44733bbe 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -22,6 +22,7 @@
 #include "xhci-trace.h"
 #include "xhci-debugfs.h"
 #include "xhci-dbgcap.h"
+#include "xhci-plat.h"
 
 #define DRIVER_AUTHOR "Sarah Sharp"
 #define DRIVER_DESC "'eXtensible' Host Controller (xHC) Driver"
@@ -1663,6 +1664,11 @@ static int xhci_urb_enqueue(struct usb_hcd *hcd, struct urb *urb, gfp_t mem_flag
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
@@ -4435,6 +4441,21 @@ static int __maybe_unused xhci_change_max_exit_latency(struct xhci_hcd *xhci,
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
index c0964fe8ac12..5368c66f5cec 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -2228,6 +2228,37 @@ static inline struct xhci_ring *xhci_urb_to_transfer_ring(struct xhci_hcd *xhci,
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
2.38.0.135.g90850a2211-goog

