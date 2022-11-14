Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59D41627C50
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 12:29:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236007AbiKNL3a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 06:29:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236479AbiKNL2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 06:28:48 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA43DB20;
        Mon, 14 Nov 2022 03:28:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668425305; x=1699961305;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CqSmXEq7rTgzGo2eyXNCXdiASe9v+/RyQA11rBsovD0=;
  b=CdI13GfWjfQQufzb6yMfsxLpUUzBGJfQ/jo5r4Dfy1lBBXAWRezYMoXv
   bNC4dFZBUPmxU/TVz1WrAizZYa8rwHO4iB69CJO4fTZZYV5gz5GNvK7FC
   zkbdkDDSappICXhsJ1ojWUeAYz7sniRhTBA3DGaVyA1X8Tja+phml7sGa
   YYAtb9zVremT12VR1T0RinxZbLcSRrXZmIu29P/f3N8udoJjkqW0SNCnD
   5C7aJVafaLUoANmQkEC7ofF3rBDzUFDgrf9JCG3g8nyM2JwL6UXvpJbct
   fbOUtUOTdgPnWptKuQJ/L+iYWTS/WUl/aHHF4/NwTozoggZ2PSrOaj5SL
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10530"; a="374074729"
X-IronPort-AV: E=Sophos;i="5.96,161,1665471600"; 
   d="scan'208";a="374074729"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2022 03:28:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10530"; a="616278552"
X-IronPort-AV: E=Sophos;i="5.96,161,1665471600"; 
   d="scan'208";a="616278552"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 14 Nov 2022 03:28:19 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 48FA6339; Mon, 14 Nov 2022 13:28:44 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jakob Koschel <jakobkoschel@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Kevin Cernekee <cernekee@gmail.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v1 4/4] xhci: Convert to use list_count()
Date:   Mon, 14 Nov 2022 13:28:42 +0200
Message-Id: <20221114112842.38565-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221114112842.38565-1-andriy.shevchenko@linux.intel.com>
References: <20221114112842.38565-1-andriy.shevchenko@linux.intel.com>
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

The list API now provides the list_count() to help with counting
existing nodes in the list. Uilise it.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/usb/host/xhci-ring.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index ad81e9a508b1..817c31e3b0c8 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -2532,7 +2532,6 @@ static int handle_tx_event(struct xhci_hcd *xhci,
 	union xhci_trb *ep_trb;
 	int status = -EINPROGRESS;
 	struct xhci_ep_ctx *ep_ctx;
-	struct list_head *tmp;
 	u32 trb_comp_code;
 	int td_num = 0;
 	bool handling_skipped_tds = false;
@@ -2580,10 +2579,8 @@ static int handle_tx_event(struct xhci_hcd *xhci,
 	}
 
 	/* Count current td numbers if ep->skip is set */
-	if (ep->skip) {
-		list_for_each(tmp, &ep_ring->td_list)
-			td_num++;
-	}
+	if (ep->skip)
+		td_num += list_count(&ep_ring->td_list);
 
 	/* Look for common error cases */
 	switch (trb_comp_code) {
-- 
2.35.1

