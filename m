Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2056B6F953C
	for <lists+linux-kernel@lfdr.de>; Sun,  7 May 2023 02:31:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230421AbjEGAbG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 20:31:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230383AbjEGAa4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 20:30:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E29C81A105;
        Sat,  6 May 2023 17:30:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 426EE61450;
        Sun,  7 May 2023 00:30:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE376C433A0;
        Sun,  7 May 2023 00:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683419447;
        bh=FVIp0F2gnFLeA4VU9rwR397kVxDgw3cesSKY8g34k2w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OBmf5pal/PZaA3IW/6kWE47UISaezF9T7AJwmINJ4gy6NCrGsagiYrnlAO9+M+OB6
         1Y5Uj1RKLXH4TUOZwKxlCDvwZNRbQnj67OcWenQ8ujXwt05juGQ3sevOvkGjnJ89iA
         5/6NXT41CH0eSchLuj7R+IFpmiVmup+VjKkOkd3HiebObySglCdCdtaLF8UUyNwu2b
         T4hcbQzEd0aetXAS8iaR3tnPohSjVBiNePOQQ/iA9HEnVfzVqxy9aIAFe4a5+xMeKh
         KUqun95/c2j2VdeGx1z/wCj7cLsZa5au5mfpoYAJ2sO8V4uqWIa0gmwxTXQdMyJUou
         4ruVWpsQ5DVDA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, mathias.nyman@intel.com,
        linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 6.3 07/24] xhci: mem: Carefully calculate size for memory allocations
Date:   Sat,  6 May 2023 20:30:03 -0400
Message-Id: <20230507003022.4070535-7-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230507003022.4070535-1-sashal@kernel.org>
References: <20230507003022.4070535-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

[ Upstream commit 347284984f415e52590373253c6943bbdc806ebf ]

Carefully calculate size for memory allocations, i.e. with help
of size_mul() macro from overflow.h.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Link: https://lore.kernel.org/r/20230317154715.535523-2-mathias.nyman@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/host/xhci-mem.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/host/xhci-mem.c b/drivers/usb/host/xhci-mem.c
index d0a9467aa5fc4..c385513ad00b6 100644
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
2.39.2

