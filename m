Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 531EA68F1C7
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 16:16:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231789AbjBHPQE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 10:16:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230445AbjBHPQC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 10:16:02 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BF921B562;
        Wed,  8 Feb 2023 07:16:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675869361; x=1707405361;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ucD+M51+UJA6YNazEMYHsIe2cYjXbeVwqV2yq8GaAVs=;
  b=atHSKFm0NqPxuvz4hJ9VcM7c+9r6R2BZqt64XnpW+NE6yS+kb5FY3fAI
   hSpodM8jP0SxZddTa/ekjuxmvXlTpKUFcvyfvS6ROTpZiiVqvIhL3oM4p
   M6W7JbYMTqwRekYpgnXCHBDxDHYensyMmJ5xKaRJ5sCp7MkO12tqslJAK
   NnRynUvSvf7rutmVMuOZIzFEGG+ARV1ajZXAw0T8G0fpS1gJqwHutwEPW
   PCBVXpKX3xOIg1lf0KRBR/vJ9GUYKugAhdk65429/AftDxxMeTAPtepMr
   oJcc1YVpXnYqoRS6U6flTZF7LQnkvUuwE0k4/F7+eDqM3EjFC2wKOQcpS
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="317825130"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="317825130"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 07:10:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="776061118"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="776061118"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 08 Feb 2023 07:10:52 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id D6BC11A6; Wed,  8 Feb 2023 17:11:30 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mathias Nyman <mathias.nyman@linux.intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 1/7] xhci: mem: Carefully calculate size for memory allocations
Date:   Wed,  8 Feb 2023 17:11:23 +0200
Message-Id: <20230208151129.28987-2-andriy.shevchenko@linux.intel.com>
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

Carefully calculate size for memory allocations, i.e. with help
of size_mul() macro from overflow.h.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/usb/host/xhci-mem.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/host/xhci-mem.c b/drivers/usb/host/xhci-mem.c
index d0a9467aa5fc..c385513ad00b 100644
--- a/drivers/usb/host/xhci-mem.c
+++ b/drivers/usb/host/xhci-mem.c
@@ -9,6 +9,7 @@
  */
 
 #include <linux/usb.h>
+#include <linux/overflow.h>
 #include <linux/pci.h>
 #include <linux/slab.h>
 #include <linux/dmapool.h>
@@ -568,7 +569,7 @@ static struct xhci_stream_ctx *xhci_alloc_stream_ctx(struct xhci_hcd *xhci,
 		gfp_t mem_flags)
 {
 	struct device *dev = xhci_to_hcd(xhci)->self.sysdev;
-	size_t size = sizeof(struct xhci_stream_ctx) * num_stream_ctxs;
+	size_t size = size_mul(sizeof(struct xhci_stream_ctx), num_stream_ctxs);
 
 	if (size > MEDIUM_STREAM_ARRAY_SIZE)
 		return dma_alloc_coherent(dev, size,
@@ -1660,7 +1661,7 @@ static int scratchpad_alloc(struct xhci_hcd *xhci, gfp_t flags)
 		goto fail_sp;
 
 	xhci->scratchpad->sp_array = dma_alloc_coherent(dev,
-				     num_sp * sizeof(u64),
+				     size_mul(sizeof(u64), num_sp),
 				     &xhci->scratchpad->sp_dma, flags);
 	if (!xhci->scratchpad->sp_array)
 		goto fail_sp2;
@@ -1799,7 +1800,7 @@ int xhci_alloc_erst(struct xhci_hcd *xhci,
 	struct xhci_segment *seg;
 	struct xhci_erst_entry *entry;
 
-	size = sizeof(struct xhci_erst_entry) * evt_ring->num_segs;
+	size = size_mul(sizeof(struct xhci_erst_entry), evt_ring->num_segs);
 	erst->entries = dma_alloc_coherent(xhci_to_hcd(xhci)->self.sysdev,
 					   size, &erst->erst_dma_addr, flags);
 	if (!erst->entries)
@@ -1830,7 +1831,7 @@ xhci_free_interrupter(struct xhci_hcd *xhci, struct xhci_interrupter *ir)
 	if (!ir)
 		return;
 
-	erst_size = sizeof(struct xhci_erst_entry) * (ir->erst.num_entries);
+	erst_size = sizeof(struct xhci_erst_entry) * ir->erst.num_entries;
 	if (ir->erst.entries)
 		dma_free_coherent(dev, erst_size,
 				  ir->erst.entries,
-- 
2.39.1

