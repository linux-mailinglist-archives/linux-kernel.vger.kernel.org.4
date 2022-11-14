Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7B116284FA
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 17:22:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236699AbiKNQV7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 11:21:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236716AbiKNQVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 11:21:52 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E16262DE9;
        Mon, 14 Nov 2022 08:21:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668442910; x=1699978910;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=w8JnsSQEeOM8g80fNSiY85GCK9KLByACfZ2G33EPHKE=;
  b=kUWML0nQpU20kQH7V/vUzzcHZViAnDrSrz6bJAFSvBAtfswFPCUryx14
   EO6Z/ZTq+GiRv95SgHKwJZ2GVyyfoYMFe0uv6+Udlc2TBfqHK3bvxVgpq
   dJLKKpZI6wpPsdf7PejlbBnOqRGt2TUysLJQK4Pd8m8tjT7hIFkC+RAaA
   SoJug8hfJANmg9cmHeVFm0av+6sDE1D2MpURMx+7V8zosmTFv58tp7Igq
   wzU8MWWSNn6n/1Wy/bOQU/YWfiaZLV4G9TR39V+/oDd5rAGFpqbTBFrfJ
   jt/YKp1E4KpAyWtI6RLX+Yx6xpMzIYUgT1JA3/p/zO3C6SS/OU49AqtxT
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="398302924"
X-IronPort-AV: E=Sophos;i="5.96,164,1665471600"; 
   d="scan'208";a="398302924"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2022 08:21:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="616372363"
X-IronPort-AV: E=Sophos;i="5.96,164,1665471600"; 
   d="scan'208";a="616372363"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 14 Nov 2022 08:21:46 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id D065D346; Mon, 14 Nov 2022 18:22:10 +0200 (EET)
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
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v2 4/4] xhci: Convert to use list_count()
Date:   Mon, 14 Nov 2022 18:22:07 +0200
Message-Id: <20221114162207.62559-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221114162207.62559-1-andriy.shevchenko@linux.intel.com>
References: <20221114162207.62559-1-andriy.shevchenko@linux.intel.com>
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

