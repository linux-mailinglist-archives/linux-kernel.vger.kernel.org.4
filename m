Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00C9E68F1CB
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 16:16:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231818AbjBHPQJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 10:16:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231782AbjBHPQD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 10:16:03 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D83740BE5;
        Wed,  8 Feb 2023 07:16:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675869362; x=1707405362;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ohp5bQqnI/OnKaRFcY242R1ns9uUyAH0LpsOgERaknw=;
  b=MxUWae7CJlDE8F3Q5vzjTs9ojCX2kTE2W0tJrxoHSNAj8gt/NdfwRk1Y
   Yb6Hfvro5U6s5Pccx6J0yAunKVQq6n2bVw8MeoLJAz+6gH+Sxrw89tdDs
   8izQgRFj9sqrkHCM5TSt5/kN9Z1fvPjAHp0i7eiSH8PEEg4p7RdFC6+rU
   84zL5+cvXluIkilxoDEKRSgvv6p2aprqnuIEh+whwZ08I1IykASrq8uc7
   fxGdOY5aSBGgUB0SK3ygN/ylw7nPiWUxzoQUe6B/vtWo4ZD45D8eNQ9IF
   HSgH768SUVldABQIV0Tdm+JJq86AJTQNMDoPexBrmpHGCv2Kx06OtVJSs
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="317825125"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="317825125"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 07:10:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="776061115"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="776061115"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 08 Feb 2023 07:10:52 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id F3AF3252; Wed,  8 Feb 2023 17:11:30 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mathias Nyman <mathias.nyman@linux.intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 4/7] xhci: mem: Drop useless return:s
Date:   Wed,  8 Feb 2023 17:11:26 +0200
Message-Id: <20230208151129.28987-5-andriy.shevchenko@linux.intel.com>
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

When function returns void and we have if-else-if chain, there is
no need to explicitly call return. Drop them and indent lines better.

While at it, make if-chain sorted from testing bigger values to smaller.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/usb/host/xhci-mem.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/host/xhci-mem.c b/drivers/usb/host/xhci-mem.c
index 357883256a5a..fa0c4ac2ca7f 100644
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

