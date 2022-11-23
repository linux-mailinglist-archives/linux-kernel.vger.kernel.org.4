Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3EEA636249
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 15:49:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237333AbiKWOs5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 09:48:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236447AbiKWOsz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 09:48:55 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 146626DCD3;
        Wed, 23 Nov 2022 06:48:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669214934; x=1700750934;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pgt4N39lUyQv8Pv+snAd9Kisc2GhpoYqnvOX9T/Og/g=;
  b=XFhha/N/4Phk105vFiRUe2SNqGNuMxCLetT2tDEKEMTkyE1a7ER5UqDl
   3gmp6E+tmY9yN8SYnXuYVgZZ+GyJgbh2aO4KfJSmiPo2w+xe1FEuaduvQ
   CtNyDaXg4PWIxR882WxOL4tr1Rb+fma6gI0S2t/kFrkAn2sN/VqVBbcLL
   BB5qzvKM0A4GebLSAIZSXsBxWI7WOsiUzkEwYWvd25XMxvg6m8b6fNsle
   aMp1miY13ktIr739llA+Tx+F0l7WWk7obCTM9c2dOad8ng6Gk0yCqQvJp
   gUOxfjdqN7+aRjvLYj7/xP41ztYwPedAZeHlo2P0KW+OkWvu8ANtVMr78
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10540"; a="315231755"
X-IronPort-AV: E=Sophos;i="5.96,187,1665471600"; 
   d="scan'208";a="315231755"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2022 06:48:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10540"; a="970883660"
X-IronPort-AV: E=Sophos;i="5.96,187,1665471600"; 
   d="scan'208";a="970883660"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 23 Nov 2022 06:48:37 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id B03FC24A; Wed, 23 Nov 2022 16:49:03 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jakob Koschel <jakobkoschel@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Kevin Cernekee <cernekee@gmail.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v4 4/4] xhci: Convert to use list_count()
Date:   Wed, 23 Nov 2022 16:49:01 +0200
Message-Id: <20221123144901.40493-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221123144901.40493-1-andriy.shevchenko@linux.intel.com>
References: <20221123144901.40493-1-andriy.shevchenko@linux.intel.com>
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

The list API now provides the list_count() to help with counting
existing nodes in the list. Utilise it.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Mathias Nyman <mathias.nyman@linux.intel.com>
---
v4: added tag (Mathias)
v3: no change
v2: no change
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

