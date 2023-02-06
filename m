Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77CF268C294
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 17:10:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230344AbjBFQKb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 11:10:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231613AbjBFQKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 11:10:23 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BB4C6580;
        Mon,  6 Feb 2023 08:10:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675699819; x=1707235819;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IklJ4DtmNmBUFeLIjZ4SvmC24kVHGrfFxz9cUAXCZtQ=;
  b=A7BU4P7fnp/fqaU4I15WFMuWYa6svKkAEAF9wWi/o/tLmyrzgx0Tu8au
   5DxGn89pPYpXHN/12Naqn49jzdSUnyMjmYIqemGmpwcg183Tgr9XzWZ1L
   cXw3AV8ai3YO9FXA/8X3xlwwv0rcVLC4mc2kxZcrtSPuB4XuTceTxDebe
   D+TpNOT4HDXlIG7A2FxW4PNi+qE1rXhpw9GRjMgUn/pUWyh8d8+jc5im4
   rU8OEp5Nanpd67Q5cXLntKr/V5LtJYYZzSMH6h37nLOgbjQZNgeC7sDEE
   6bAFbXHtlj6qM3HcDfVLtKdlaijXbz51/dlN/RhZek7L0ctzGY+rr40f5
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="327877015"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="327877015"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2023 08:10:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="644084672"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="644084672"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 06 Feb 2023 08:10:16 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 87267413; Mon,  6 Feb 2023 18:10:52 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mathias Nyman <mathias.nyman@linux.intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 6/7] xhci: mem: Replace explicit castings with appropriate specifiers
Date:   Mon,  6 Feb 2023 18:10:48 +0200
Message-Id: <20230206161049.13972-7-andriy.shevchenko@linux.intel.com>
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

There is no need to have explicit castings when we have specific pointer extensions
Replace the explicit castings with appropriate specifiers.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/usb/host/xhci-mem.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/host/xhci-mem.c b/drivers/usb/host/xhci-mem.c
index a3351b11efa5..fef74e7c20fc 100644
--- a/drivers/usb/host/xhci-mem.c
+++ b/drivers/usb/host/xhci-mem.c
@@ -668,8 +668,7 @@ struct xhci_stream_info *xhci_alloc_stream_info(struct xhci_hcd *xhci,
 			cur_ring->cycle_state;
 		stream_info->stream_ctx_array[cur_stream].stream_ring =
 			cpu_to_le64(addr);
-		xhci_dbg(xhci, "Setting stream %d ring ptr to 0x%08llx\n",
-				cur_stream, (unsigned long long) addr);
+		xhci_dbg(xhci, "Setting stream %d ring ptr to 0x%08llx\n", cur_stream, addr);
 
 		ret = xhci_update_stream_mapping(cur_ring, mem_flags);
 		if (ret) {
@@ -979,16 +978,14 @@ int xhci_alloc_virt_device(struct xhci_hcd *xhci, int slot_id,
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
@@ -2353,8 +2350,8 @@ int xhci_mem_init(struct xhci_hcd *xhci, gfp_t flags)
 		goto fail;
 	xhci->dcbaa->dma = dma;
 	xhci_dbg_trace(xhci, trace_xhci_dbg_init,
-			"// Device context base array address = 0x%llx (DMA), %p (virt)",
-			(unsigned long long)xhci->dcbaa->dma, xhci->dcbaa);
+			"// Device context base array address = 0x%pad (DMA), %p (virt)",
+			&xhci->dcbaa->dma, xhci->dcbaa);
 	xhci_write_64(xhci, dma, &xhci->op_regs->dcbaa_ptr);
 
 	/*
@@ -2395,8 +2392,8 @@ int xhci_mem_init(struct xhci_hcd *xhci, gfp_t flags)
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

