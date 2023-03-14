Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 826CE6B90B4
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 11:54:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230135AbjCNKyI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 06:54:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjCNKyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 06:54:02 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA082AD20;
        Tue, 14 Mar 2023 03:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1678791191;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jxfNorIALSXTIcdSKIDH829B6vo4dZmRww3AUKQcurM=;
        b=rRy0moM6paKV750d9wksROPVqQ6QxR5dF4aK91ULps8ORGUFeqgX5gQdu3rfSh7dDyjoKJ
        gGuVnq8VNh7gGSfMuq4KL3GJxGOMIZctpxei1I9Rof06p0zWtG+6Y4/WsOE81PcjV9Z9rS
        HMVEegH1qXn5y3b8AIfeOJ4eD/A3gow=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     michael.hennerich@analog.com, nuno.sa@analog.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 1/2] usb: gadget: Support already-mapped DMA SGs
Date:   Tue, 14 Mar 2023 11:52:56 +0100
Message-Id: <20230314105257.17345-2-paul@crapouillou.net>
In-Reply-To: <20230314105257.17345-1-paul@crapouillou.net>
References: <20230314105257.17345-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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

