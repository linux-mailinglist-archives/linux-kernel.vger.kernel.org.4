Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2A7768C298
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 17:10:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231590AbjBFQKV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 11:10:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbjBFQKR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 11:10:17 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E706C6580;
        Mon,  6 Feb 2023 08:10:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675699816; x=1707235816;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xh+eFvZUt3OEbPV7o5Euz7hBLKZySMxgRjkO8wgC73k=;
  b=ZFoqVZMYBk3WY82EG6QSZgV6GNjtGNlO2Tn2A7ARrnQfGvLe5/6pXivq
   9WAq/RrrUMP3lDn7oZCaqyDlzAkqXgFJuH2UGt6rRLrouE+ci0yxTjv2G
   L+0hSF+bh/28MgnL9QpL+xGrJ3XeO4erDHMPAY2Nkddqaye7SkSUcjqqe
   vJVsz3xEI/LPcZL2uxmez1QdSd8X3xrLdTdI6Xo0o4NXyyRLOZfdZbheW
   0yniA1FNA8g4SZGDPFhK1Ud6ZRlg17pijgjGgT4GKFvSLfeH2G5kcQYwa
   kKqTX4/FxwgoOAF/9x5g8mGRum5tYWTFnofwhQaiug3vZ/0ER0B9jc0OH
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="327876997"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="327876997"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2023 08:10:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="644084656"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="644084656"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 06 Feb 2023 08:10:14 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 59BA927B; Mon,  6 Feb 2023 18:10:52 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mathias Nyman <mathias.nyman@linux.intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 2/7] xhci: mem: Use __GFP_ZERO instead of explicit memset() call
Date:   Mon,  6 Feb 2023 18:10:44 +0200
Message-Id: <20230206161049.13972-3-andriy.shevchenko@linux.intel.com>
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

Use __GFP_ZERO instead of explicit memset() call in
xhci_alloc_stream_ctx().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/usb/host/xhci-mem.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/host/xhci-mem.c b/drivers/usb/host/xhci-mem.c
index c385513ad00b..768adcb544a7 100644
--- a/drivers/usb/host/xhci-mem.c
+++ b/drivers/usb/host/xhci-mem.c
@@ -571,6 +571,8 @@ static struct xhci_stream_ctx *xhci_alloc_stream_ctx(struct xhci_hcd *xhci,
 	struct device *dev = xhci_to_hcd(xhci)->self.sysdev;
 	size_t size = size_mul(sizeof(struct xhci_stream_ctx), num_stream_ctxs);
 
+	mem_flags |= __GFP_ZERO;
+
 	if (size > MEDIUM_STREAM_ARRAY_SIZE)
 		return dma_alloc_coherent(dev, size,
 				dma, mem_flags);
@@ -643,8 +645,6 @@ struct xhci_stream_info *xhci_alloc_stream_info(struct xhci_hcd *xhci,
 			mem_flags);
 	if (!stream_info->stream_ctx_array)
 		goto cleanup_ring_array;
-	memset(stream_info->stream_ctx_array, 0,
-			sizeof(struct xhci_stream_ctx)*num_stream_ctxs);
 
 	/* Allocate everything needed to free the stream rings later */
 	stream_info->free_streams_command =
-- 
2.39.1

