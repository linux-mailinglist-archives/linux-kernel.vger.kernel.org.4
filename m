Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69ED468C2AF
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 17:12:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231743AbjBFQMj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 11:12:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231724AbjBFQMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 11:12:33 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 283CC17CE9;
        Mon,  6 Feb 2023 08:12:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675699924; x=1707235924;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5JACWvw3uGfxpdVuryzlIEd+jJzEoO70sDh6Ir94Mzs=;
  b=M1eNxiNTFebCLlyVmxcG3qD1dTCPlnRTeTxzD+JAnHGYzuzGZsnHzCGA
   u5zjyl7JEEikl7PQnNh/0R8ArebkOrUABSs/nMA6FfR8Uuq2SB3b5cMPc
   c7abhg7nXwtYWz664VOXb9BzdZ/0x8TMvINzRi6FMxBsxYe2CUoD2/gY7
   5EzKRhgGNeVQvoEdYpWaj5coNNqIAeXCkJqug/iZ4xob4E5N1HMFNNuvZ
   Ieyggb/w3iENU5myN6Ftec5AqWSyxq+K/Dfeagi7uO97nJYJwqAw6h2Y3
   D9bFLv/oO5/AMETVSTrS+yiACV3vYXjnCp5OAsYTfuFUA64AGxdLsak5c
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="308887673"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="308887673"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2023 08:10:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="698884073"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="698884073"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 06 Feb 2023 08:10:17 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 77B8A303; Mon,  6 Feb 2023 18:10:52 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mathias Nyman <mathias.nyman@linux.intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 5/7] xhci: mem: Use while (i--) pattern to clean up
Date:   Mon,  6 Feb 2023 18:10:47 +0200
Message-Id: <20230206161049.13972-6-andriy.shevchenko@linux.intel.com>
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

Use more natural while (i--) patter to clean up allocated resources.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/usb/host/xhci-mem.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/usb/host/xhci-mem.c b/drivers/usb/host/xhci-mem.c
index 5c873e62c4d3..a3351b11efa5 100644
--- a/drivers/usb/host/xhci-mem.c
+++ b/drivers/usb/host/xhci-mem.c
@@ -1681,11 +1681,10 @@ static int scratchpad_alloc(struct xhci_hcd *xhci, gfp_t flags)
 	return 0;
 
  fail_sp4:
-	for (i = i - 1; i >= 0; i--) {
+	while (i--)
 		dma_free_coherent(dev, xhci->page_size,
 				    xhci->scratchpad->sp_buffers[i],
 				    xhci->scratchpad->sp_array[i]);
-	}
 
 	kfree(xhci->scratchpad->sp_buffers);
 
-- 
2.39.1

