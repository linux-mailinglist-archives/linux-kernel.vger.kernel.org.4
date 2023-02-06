Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8975F68C2A5
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 17:12:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231707AbjBFQMF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 11:12:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231508AbjBFQMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 11:12:03 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53E442ED49;
        Mon,  6 Feb 2023 08:11:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675699903; x=1707235903;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6q1oqYzgNWSfxZgRT2J9mn+oyf7jlZ2Pq+SmMt+Wz70=;
  b=LvHTGWOT+4lYvlS+qtojUqASyyoz5+tUmpXI6j9xKqHTIERzYK9ueRCE
   Es+uN44OYiYLCV5FrINQjhqGYKZ0Z9+Ywr7jz9ZEUZX9RfSCYQXTWy24L
   R+o2qtfQRb1fDZ5DpF5m86DYya9NduQQXF5G4FZnixHfNzLMAxknfcPs1
   8jRGS0flZ8ijFk0MtP5xQXPBxRFQSaLSZU1RT6zx+B8PtODcGOhZfAKWE
   ClDKcnQ5fKLgcpUBiUjpRR5a0YN6OugHIsT27fJ6tlmOCrQguhdhEuTRq
   JwCbox1aQwKBftOt/7hDGvaBrgBNWYvCvocZHdWpQI8UiogcseUiyKuOt
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="308887658"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="308887658"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2023 08:10:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="616485720"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="616485720"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 06 Feb 2023 08:10:14 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 71DD934D; Mon,  6 Feb 2023 18:10:52 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mathias Nyman <mathias.nyman@linux.intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 4/7] xhci: mem: Drop useless return:s
Date:   Mon,  6 Feb 2023 18:10:46 +0200
Message-Id: <20230206161049.13972-5-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230206161049.13972-1-andriy.shevchenko@linux.intel.com>
References: <20230206161049.13972-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When function returns void and we have if-else-if chain, there is
no need to explicitly call return. Drop them and indent lines better.

While at it, make if chain sorted from testing bigger values to smaller.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/usb/host/xhci-mem.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/host/xhci-mem.c b/drivers/usb/host/xhci-mem.c
index 34f5ba19471e..5c873e62c4d3 100644
--- a/drivers/usb/host/xhci-mem.c
+++ b/drivers/usb/host/xhci-mem.c
@@ -544,14 +544,11 @@ static void xhci_free_stream_ctx(struct xhci_hcd *xhci,
 	size_t size = sizeof(struct xhci_stream_ctx) * num_stream_ctxs;
 
 	if (size > MEDIUM_STREAM_ARRAY_SIZE)
-		dma_free_coherent(dev, size,
-				stream_ctx, dma);
-	else if (size <= SMALL_STREAM_ARRAY_SIZE)
-		return dma_pool_free(xhci->small_streams_pool,
-				stream_ctx, dma);
+		dma_free_coherent(dev, size, stream_ctx, dma);
+	else if (size > SMALL_STREAM_ARRAY_SIZE)
+		dma_pool_free(xhci->medium_streams_pool, stream_ctx, dma);
 	else
-		return dma_pool_free(xhci->medium_streams_pool,
-				stream_ctx, dma);
+		dma_pool_free(xhci->small_streams_pool, stream_ctx, dma);
 }
 
 /*
-- 
2.39.1

