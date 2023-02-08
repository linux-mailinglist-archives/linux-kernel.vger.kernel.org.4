Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D7B168F1BE
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 16:15:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231772AbjBHPPG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 10:15:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231232AbjBHPO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 10:14:57 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C38C4CC25;
        Wed,  8 Feb 2023 07:14:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675869296; x=1707405296;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fWjbxcvDw0K6sgQZihGC3L3cc70DGh95bt3Gr9cHcsY=;
  b=X8slqT1lh2PjKjjvVUW4s+SPZ1EB58mCopKbWyInuHLkYlHJIBDe+CiS
   6XhNey+JvfEIatJIxzN5s/vbfoizn1LLe3eS3cKjD0kT0knLPfNY/D3sY
   ocVUHQyP9tYK0fj7EVSMxLBgQ0ZoGCNJHPN2K/Ryz8kxQbCRDN9ul9VMm
   ep8GH64M4JZI0CUHAn7UmPf3oZdV947L5AKzR51TXjupbcLfsHZR/CZv0
   khTb/2lCUhHdxsguuLbM0qINqk6cWmpYZSzLnEMMQ2RXWUQH86/C7JmsP
   3/T6Z70Qv+6MetEviYBd9UVag6iXLqUOXm2Wo2rbOH2zOA3mNgiwbAeeX
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="357218235"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="357218235"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 07:10:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="730898825"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="730898825"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 08 Feb 2023 07:10:54 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 1692C269; Wed,  8 Feb 2023 17:11:31 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mathias Nyman <mathias.nyman@linux.intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 6/7] xhci: mem: Replace explicit castings with appropriate specifiers
Date:   Wed,  8 Feb 2023 17:11:28 +0200
Message-Id: <20230208151129.28987-7-andriy.shevchenko@linux.intel.com>
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

There is no need to have explicit castings when we have specific pointer extensions
Replace the explicit castings with appropriate specifiers.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/usb/host/xhci-mem.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/host/xhci-mem.c b/drivers/usb/host/xhci-mem.c
index b8c1465f8d23..67ac02d177b5 100644
--- a/drivers/usb/host/xhci-mem.c
+++ b/drivers/usb/host/xhci-mem.c
@@ -666,8 +666,7 @@ struct xhci_stream_info *xhci_alloc_stream_info(struct xhci_hcd *xhci,
 			cur_ring->cycle_state;
 		stream_info->stream_ctx_array[cur_stream].stream_ring =
 			cpu_to_le64(addr);
-		xhci_dbg(xhci, "Setting stream %d ring ptr to 0x%08llx\n",
-				cur_stream, (unsigned long long) addr);
+		xhci_dbg(xhci, "Setting stream %d ring ptr to 0x%08llx\n", cur_stream, addr);
 
 		ret = xhci_update_stream_mapping(cur_ring, mem_flags);
 		if (ret) {
@@ -977,16 +976,14 @@ int xhci_alloc_virt_device(struct xhci_hcd *xhci, int slot_id,
 	if (!dev->out_ctx)
 		goto fail;
 
-	xhci_dbg(xhci, "Slot %d output ctx = 0x%llx (dma)\n", slot_id,
-			(unsigned long long)dev->out_ctx->dma);
+	xhci_dbg(xhci, "Slot %d output ctx = 0x%pad (dma)\n", slot_id, &dev->out_ctx->dma);
 
 	/* Allocate the (input) device context for address device command */
 	dev->in_ctx = xhci_alloc_container_ctx(xhci, XHCI_CTX_TYPE_INPUT, flags);
 	if (!dev->in_ctx)
 		goto fail;
 
-	xhci_dbg(xhci, "Slot %d input ctx = 0x%llx (dma)\n", slot_id,
-			(unsigned long long)dev->in_ctx->dma);
+	xhci_dbg(xhci, "Slot %d input ctx = 0x%pad (dma)\n", slot_id, &dev->in_ctx->dma);
 
 	/* Initialize the cancellation and bandwidth list for each ep */
 	for (i = 0; i < 31; i++) {
@@ -2351,8 +2348,8 @@ int xhci_mem_init(struct xhci_hcd *xhci, gfp_t flags)
 		goto fail;
 	xhci->dcbaa->dma = dma;
 	xhci_dbg_trace(xhci, trace_xhci_dbg_init,
-			"// Device context base array address = 0x%llx (DMA), %p (virt)",
-			(unsigned long long)xhci->dcbaa->dma, xhci->dcbaa);
+			"// Device context base array address = 0x%pad (DMA), %p (virt)",
+			&xhci->dcbaa->dma, xhci->dcbaa);
 	xhci_write_64(xhci, dma, &xhci->op_regs->dcbaa_ptr);
 
 	/*
@@ -2393,8 +2390,8 @@ int xhci_mem_init(struct xhci_hcd *xhci, gfp_t flags)
 		goto fail;
 	xhci_dbg_trace(xhci, trace_xhci_dbg_init,
 			"Allocated command ring at %p", xhci->cmd_ring);
-	xhci_dbg_trace(xhci, trace_xhci_dbg_init, "First segment DMA is 0x%llx",
-			(unsigned long long)xhci->cmd_ring->first_seg->dma);
+	xhci_dbg_trace(xhci, trace_xhci_dbg_init, "First segment DMA is 0x%pad",
+			&xhci->cmd_ring->first_seg->dma);
 
 	/* Set the address in the Command Ring Control register */
 	val_64 = xhci_read_64(xhci, &xhci->op_regs->cmd_ring);
-- 
2.39.1

