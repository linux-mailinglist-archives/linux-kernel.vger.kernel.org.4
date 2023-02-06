Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D4F868C291
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 17:10:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231617AbjBFQKX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 11:10:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230344AbjBFQKS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 11:10:18 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75D2D6599;
        Mon,  6 Feb 2023 08:10:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675699817; x=1707235817;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KNO3nmWlf3AsLk6AzRjxlRpI2rddvoMug2nqLE6A5y4=;
  b=FQm9KNb/jQ8LMIYXHzqSPllrsJ+3/8Mkt4wYHI7XaplAvLPXzuRVypfE
   LK0iMqWdvqCRCrh3BE88W26STM1M/b50WSDdbTAE1gMGk/QhzYe8qlaGw
   6ZOcJh4xLYOXWS6Rz9eUFw+Hk6uJ+xWclm5kuNkpoGx6rhFRKf9kQpCHp
   l/IF0656htQCMBXuJOe9uwPUN+DuAV+LHMj/o55fUjuSES+CQZbiGURy/
   BK93VAYO5O4g7XIlEjglB/Hb+0UFvVTwZ+/F2VWL7zvDrD+897eHHUDe5
   iO3d5ekmx1jzDKou2T43Z2twR7XUJaXbuxF2EtxXtveG88bC9JwWpFuLV
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="327876999"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="327876999"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2023 08:10:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="644084658"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="644084658"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 06 Feb 2023 08:10:14 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 5EE47241; Mon,  6 Feb 2023 18:10:52 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mathias Nyman <mathias.nyman@linux.intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 3/7] xhci: mem: Get rid of redundant 'else'
Date:   Mon,  6 Feb 2023 18:10:45 +0200
Message-Id: <20230206161049.13972-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230206161049.13972-1-andriy.shevchenko@linux.intel.com>
References: <20230206161049.13972-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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

While at it, make if chain sorted from testing bigger values to smaller.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/usb/host/xhci-mem.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/host/xhci-mem.c b/drivers/usb/host/xhci-mem.c
index 768adcb544a7..34f5ba19471e 100644
--- a/drivers/usb/host/xhci-mem.c
+++ b/drivers/usb/host/xhci-mem.c
@@ -574,14 +574,11 @@ static struct xhci_stream_ctx *xhci_alloc_stream_ctx(struct xhci_hcd *xhci,
 	mem_flags |= __GFP_ZERO;
 
 	if (size > MEDIUM_STREAM_ARRAY_SIZE)
-		return dma_alloc_coherent(dev, size,
-				dma, mem_flags);
-	else if (size <= SMALL_STREAM_ARRAY_SIZE)
-		return dma_pool_alloc(xhci->small_streams_pool,
-				mem_flags, dma);
+		return dma_alloc_coherent(dev, size, dma, mem_flags);
+	if (size > SMALL_STREAM_ARRAY_SIZE)
+		return dma_pool_alloc(xhci->medium_streams_pool, mem_flags, dma);
 	else
-		return dma_pool_alloc(xhci->medium_streams_pool,
-				mem_flags, dma);
+		return dma_pool_alloc(xhci->small_streams_pool, mem_flags, dma);
 }
 
 struct xhci_ring *xhci_dma_to_transfer_ring(
@@ -1401,8 +1398,9 @@ static u32 xhci_get_max_esit_payload(struct usb_device *udev,
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

