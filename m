Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F13AA68F1BC
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 16:15:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231748AbjBHPPA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 10:15:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230307AbjBHPOz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 10:14:55 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F03216ADD;
        Wed,  8 Feb 2023 07:14:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675869294; x=1707405294;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UjZVRXxeXd4sLLmalYuODNehwuO5vR6yLHXOY2Y49oY=;
  b=dk2ciUhx1Od7pXgyCXDpYcl4UygdsDYRJV1KdhslybYKtt/R8+brwkNo
   GzKkCN/49VvKiLmtR8LEYXHmmIO7Nl8t0QF3qnaAdyZTSS49DJ8e/7ZRt
   coaTRDoz5oG9AIugcuuq7reJ7lKvzdGvuNrWQMirhdfMIM3nNCS30p1u5
   k85oca9GHHDbOGbGjpprDb17UmCqLSuaupS4aou4KMrt9C3EjFScxXb5K
   zjNCFMpstPQDsJ346jPHDL87o65d2M3da5kUUDm/tFnrcEiaB89ayE+Tb
   7x6YKwJvdV9PuZkffSZ20CN7Cd55Vd7O94CDIaZ78JCgP23zCfOjst9cb
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="357218206"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="357218206"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 07:10:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="730898815"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="730898815"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 08 Feb 2023 07:10:52 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id E0B931F8; Wed,  8 Feb 2023 17:11:30 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mathias Nyman <mathias.nyman@linux.intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 2/7] xhci: mem: Use dma_poll_zalloc() instead of explicit memset()
Date:   Wed,  8 Feb 2023 17:11:24 +0200
Message-Id: <20230208151129.28987-3-andriy.shevchenko@linux.intel.com>
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

Use dma_poll_zalloc() instead of explicit memset() call in
xhci_alloc_stream_ctx(). Note, that dma_alloc_coherent() is
always issues zeroed memory chunk.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/usb/host/xhci-mem.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/host/xhci-mem.c b/drivers/usb/host/xhci-mem.c
index c385513ad00b..4ffa6495878d 100644
--- a/drivers/usb/host/xhci-mem.c
+++ b/drivers/usb/host/xhci-mem.c
@@ -575,10 +575,10 @@ static struct xhci_stream_ctx *xhci_alloc_stream_ctx(struct xhci_hcd *xhci,
 		return dma_alloc_coherent(dev, size,
 				dma, mem_flags);
 	else if (size <= SMALL_STREAM_ARRAY_SIZE)
-		return dma_pool_alloc(xhci->small_streams_pool,
+		return dma_pool_zalloc(xhci->small_streams_pool,
 				mem_flags, dma);
 	else
-		return dma_pool_alloc(xhci->medium_streams_pool,
+		return dma_pool_zalloc(xhci->medium_streams_pool,
 				mem_flags, dma);
 }
 
@@ -643,8 +643,6 @@ struct xhci_stream_info *xhci_alloc_stream_info(struct xhci_hcd *xhci,
 			mem_flags);
 	if (!stream_info->stream_ctx_array)
 		goto cleanup_ring_array;
-	memset(stream_info->stream_ctx_array, 0,
-			sizeof(struct xhci_stream_ctx)*num_stream_ctxs);
 
 	/* Allocate everything needed to free the stream rings later */
 	stream_info->free_streams_command =
-- 
2.39.1

