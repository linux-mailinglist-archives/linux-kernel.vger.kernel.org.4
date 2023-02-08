Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6628B68F1CC
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 16:16:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231823AbjBHPQM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 10:16:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231781AbjBHPQD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 10:16:03 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFA684A1FF;
        Wed,  8 Feb 2023 07:16:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675869363; x=1707405363;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jA6wyyXWmWqm2vrlys0nGdu2icWTLAxdk73M1mDbu9c=;
  b=fZ+KnDw50oWLGcYc+HQObfZCmD4I4TxVsRAvppxqT5qLW59vrY9568gq
   ZumB6aXKxwS10791E+plxxWQRsekJjl4x7xvrC4RbeIQoYDMUHk7ISMa5
   Z6BqxYSNwJWz9GfMnZJQRLiF+YeO3Xy5Q0Kkj0o3+suHV59XhUP2Mas5f
   A3gODxatcjFNtoQVjy43AAVYkF7YAUFc6uupfOlwEelnxnFoUurel7tvB
   SCVb470uN7t5poRgUo1vE1Pl/SBBE6TPAxSztzrQFCf41RUSL0qAS3Vu6
   ykUS+AAoAXTzqAy5H9DANZJzOWEfm2Ssdt6WJJcq2Nx2wNxjG+B5NyOSy
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="317825143"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="317825143"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 07:10:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="776061140"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="776061140"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 08 Feb 2023 07:10:54 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 11904299; Wed,  8 Feb 2023 17:11:31 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mathias Nyman <mathias.nyman@linux.intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 5/7] xhci: mem: Use while (i--) pattern to clean up
Date:   Wed,  8 Feb 2023 17:11:27 +0200
Message-Id: <20230208151129.28987-6-andriy.shevchenko@linux.intel.com>
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

Use more natural while (i--) patter to clean up allocated resources.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/usb/host/xhci-mem.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/usb/host/xhci-mem.c b/drivers/usb/host/xhci-mem.c
index fa0c4ac2ca7f..b8c1465f8d23 100644
--- a/drivers/usb/host/xhci-mem.c
+++ b/drivers/usb/host/xhci-mem.c
@@ -1679,11 +1679,10 @@ static int scratchpad_alloc(struct xhci_hcd *xhci, gfp_t flags)
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

