Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C84F6C469F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 10:37:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231176AbjCVJhR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 05:37:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231137AbjCVJhM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 05:37:12 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E65625F202;
        Wed, 22 Mar 2023 02:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1679476887;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jxfNorIALSXTIcdSKIDH829B6vo4dZmRww3AUKQcurM=;
        b=nY11iy8fR6a2aO+VbjSDeYST0gxDZ1H3hICGOlxr1xoSatxZjWgjvB/vOm6EOOTffEXXW6
        1HJCf1NwDmxoUNOG207QaX8dJ1ezKV+dUj+GpVSIt6RdmulX3Xauvj2ny0Bs4YqNt5iGil
        Jx0mM2Oaw+GfvIAXkLkO0opvKA+tTiY=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     michael.hennerich@analog.com, nuno.sa@analog.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v2 1/3] usb: gadget: Support already-mapped DMA SGs
Date:   Wed, 22 Mar 2023 10:21:16 +0100
Message-Id: <20230322092118.9213-2-paul@crapouillou.net>
In-Reply-To: <20230322092118.9213-1-paul@crapouillou.net>
References: <20230322092118.9213-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new 'sg_was_mapped' field to the struct usb_request. This field
can be used to indicate that the scatterlist associated to the USB
transfer has already been mapped into the DMA space, and it does not
have to be done internally.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/usb/gadget/udc/core.c | 7 ++++++-
 include/linux/usb/gadget.h    | 2 ++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/udc/core.c b/drivers/usb/gadget/udc/core.c
index 23b0629a8774..5f2c4933769d 100644
--- a/drivers/usb/gadget/udc/core.c
+++ b/drivers/usb/gadget/udc/core.c
@@ -829,6 +829,11 @@ int usb_gadget_map_request_by_dev(struct device *dev,
 	if (req->length == 0)
 		return 0;
 
+	if (req->sg_was_mapped) {
+		req->num_mapped_sgs = req->num_sgs;
+		return 0;
+	}
+
 	if (req->num_sgs) {
 		int     mapped;
 
@@ -874,7 +879,7 @@ EXPORT_SYMBOL_GPL(usb_gadget_map_request);
 void usb_gadget_unmap_request_by_dev(struct device *dev,
 		struct usb_request *req, int is_in)
 {
-	if (req->length == 0)
+	if (req->length == 0 || req->sg_was_mapped)
 		return;
 
 	if (req->num_mapped_sgs) {
diff --git a/include/linux/usb/gadget.h b/include/linux/usb/gadget.h
index 00750f7020f3..9dd829b8974a 100644
--- a/include/linux/usb/gadget.h
+++ b/include/linux/usb/gadget.h
@@ -52,6 +52,7 @@ struct usb_ep;
  * @short_not_ok: When reading data, makes short packets be
  *     treated as errors (queue stops advancing till cleanup).
  * @dma_mapped: Indicates if request has been mapped to DMA (internal)
+ * @sg_was_mapped: Set if the scatterlist has been mapped before the request
  * @complete: Function called when request completes, so this request and
  *	its buffer may be re-used.  The function will always be called with
  *	interrupts disabled, and it must not sleep.
@@ -111,6 +112,7 @@ struct usb_request {
 	unsigned		zero:1;
 	unsigned		short_not_ok:1;
 	unsigned		dma_mapped:1;
+	unsigned		sg_was_mapped:1;
 
 	void			(*complete)(struct usb_ep *ep,
 					struct usb_request *req);
-- 
2.39.2

