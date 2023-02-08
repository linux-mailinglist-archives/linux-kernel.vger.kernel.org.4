Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D5C068F1C9
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 16:16:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231807AbjBHPQH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 10:16:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231744AbjBHPQC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 10:16:02 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 304A73A599;
        Wed,  8 Feb 2023 07:16:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675869362; x=1707405362;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7Sgb1zaNMokHswRtSrmPc/gbS71Ao7WxNEkQZZyyfeI=;
  b=Sw+FwS4qZKtzSQGXhg1LP56n8Zwpug/UUZsZxXZy6oztrT6cqo9/nFdZ
   t3GNfut5LczrCJBpi6kN/qR6epmN619WEraQ4gwEt6/1NytvXut050jfq
   BFON5yFEwkW83idtXPEJSS8SF7UmcV67WA/BKlmI8kBen0Ls/El1Vbfpc
   EpLJemM3Z9h/1r2o8uKOoZfeGzOUTMKbRsGvUw23v0mMAXs1D1HLxGf1P
   H2RSpQCAPjB3wESMxNRnhU3w9th6vKMEwAAYXSe6y6/uHD/lCcqp+//Sr
   7D5JaUKMhYFdqV57SvngDXzpqtUTfOBGDlr9TrhOPDxVtFRFIjtTYG2m2
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="317825120"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="317825120"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 07:10:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="776061112"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="776061112"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 08 Feb 2023 07:10:52 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id EA1C9210; Wed,  8 Feb 2023 17:11:30 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mathias Nyman <mathias.nyman@linux.intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 3/7] xhci: mem: Get rid of redundant 'else'
Date:   Wed,  8 Feb 2023 17:11:25 +0200
Message-Id: <20230208151129.28987-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230208151129.28987-1-andriy.shevchenko@linux.intel.com>
References: <20230208151129.28987-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the snippets like the following

	if (...)
		return / goto / break / continue ...;
	else
		...

the 'else' is redundant. Get rid of it.

While at it, make if-chain sorted from testing bigger values to smaller.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/usb/host/xhci-mem.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/host/xhci-mem.c b/drivers/usb/host/xhci-mem.c
index 4ffa6495878d..357883256a5a 100644
--- a/drivers/usb/host/xhci-mem.c
+++ b/drivers/usb/host/xhci-mem.c
@@ -572,14 +572,11 @@ static struct xhci_stream_ctx *xhci_alloc_stream_ctx(struct xhci_hcd *xhci,
 	size_t size = size_mul(sizeof(struct xhci_stream_ctx), num_stream_ctxs);
 
 	if (size > MEDIUM_STREAM_ARRAY_SIZE)
-		return dma_alloc_coherent(dev, size,
-				dma, mem_flags);
-	else if (size <= SMALL_STREAM_ARRAY_SIZE)
-		return dma_pool_zalloc(xhci->small_streams_pool,
-				mem_flags, dma);
+		return dma_alloc_coherent(dev, size, dma, mem_flags);
+	if (size > SMALL_STREAM_ARRAY_SIZE)
+		return dma_pool_zalloc(xhci->medium_streams_pool, mem_flags, dma);
 	else
-		return dma_pool_zalloc(xhci->medium_streams_pool,
-				mem_flags, dma);
+		return dma_pool_zalloc(xhci->small_streams_pool, mem_flags, dma);
 }
 
 struct xhci_ring *xhci_dma_to_transfer_ring(
@@ -1399,8 +1396,9 @@ static u32 xhci_get_max_esit_payload(struct usb_device *udev,
 	if ((udev->speed >= USB_SPEED_SUPER_PLUS) &&
 	    USB_SS_SSP_ISOC_COMP(ep->ss_ep_comp.bmAttributes))
 		return le32_to_cpu(ep->ssp_isoc_ep_comp.dwBytesPerInterval);
+
 	/* SuperSpeed or SuperSpeedPlus Isoc ep with less than 48k per esit */
-	else if (udev->speed >= USB_SPEED_SUPER)
+	if (udev->speed >= USB_SPEED_SUPER)
 		return le16_to_cpu(ep->ss_ep_comp.wBytesPerInterval);
 
 	max_packet = usb_endpoint_maxp(&ep->desc);
-- 
2.39.1

