Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 298EB634043
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 16:35:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233283AbiKVPfV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 10:35:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232132AbiKVPfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 10:35:15 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC39069DC3;
        Tue, 22 Nov 2022 07:35:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669131314; x=1700667314;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zu4U5AcdMvxjBbkfIRJ4d3Ua9ejTwnth+3FLNezefWw=;
  b=md3N+GrGvwUf6QOWLknExsDuy5ZH8A0ClL+DOWmPyuIORQhgSwNgmrDr
   +7ClffdZ2he0tn/dqWNPpHmtoy/FFMNNzoU2Xc6e8glQkNZfrg/D9/Pv5
   13yCZkIWN2ZgcFxxF6TtDwjBkfEv2vk+hfFFVS6+aDrlQOYupJN8RTDAn
   r6FrM4iDo77PI792VkmP/tHELLe3o/hsh5oZ6COTIZcAUm/azEAXocdz7
   fOKKYhzLQL6hDCyrAOOmUoN3/r+7RWurukdwl6909/nWev+R0adD1OekO
   /KU3kAhQUJJI2f4ZQobJFMWOVcXZDbW+eMSKF5NL0DEEyZwpWUi8X+L+9
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10539"; a="315662394"
X-IronPort-AV: E=Sophos;i="5.96,184,1665471600"; 
   d="scan'208";a="315662394"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2022 07:35:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10539"; a="747395671"
X-IronPort-AV: E=Sophos;i="5.96,184,1665471600"; 
   d="scan'208";a="747395671"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 22 Nov 2022 07:35:00 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 5B37D184; Tue, 22 Nov 2022 17:35:26 +0200 (EET)
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
Subject: [PATCH v3 3/4] usb: gadget: udc: bcm63xx: Convert to use list_count()
Date:   Tue, 22 Nov 2022 17:35:15 +0200
Message-Id: <20221122153516.52577-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221122153516.52577-1-andriy.shevchenko@linux.intel.com>
References: <20221122153516.52577-1-andriy.shevchenko@linux.intel.com>
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
existing nodes in the list. Utilise it.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v3: no change
v2: no change
 drivers/usb/gadget/udc/bcm63xx_udc.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/gadget/udc/bcm63xx_udc.c b/drivers/usb/gadget/udc/bcm63xx_udc.c
index 2cdb07905bde..0762e49e85f8 100644
--- a/drivers/usb/gadget/udc/bcm63xx_udc.c
+++ b/drivers/usb/gadget/udc/bcm63xx_udc.c
@@ -2172,7 +2172,6 @@ static int bcm63xx_iudma_dbg_show(struct seq_file *s, void *p)
 
 	for (ch_idx = 0; ch_idx < BCM63XX_NUM_IUDMA; ch_idx++) {
 		struct iudma_ch *iudma = &udc->iudma[ch_idx];
-		struct list_head *pos;
 
 		seq_printf(s, "IUDMA channel %d -- ", ch_idx);
 		switch (iudma_defaults[ch_idx].ep_type) {
@@ -2205,14 +2204,10 @@ static int bcm63xx_iudma_dbg_show(struct seq_file *s, void *p)
 		seq_printf(s, "  desc: %d/%d used", iudma->n_bds_used,
 			   iudma->n_bds);
 
-		if (iudma->bep) {
-			i = 0;
-			list_for_each(pos, &iudma->bep->queue)
-				i++;
-			seq_printf(s, "; %d queued\n", i);
-		} else {
+		if (iudma->bep)
+			seq_printf(s, "; %zu queued\n", list_count(&iudma->bep->queue));
+		else
 			seq_printf(s, "\n");
-		}
 
 		for (i = 0; i < iudma->n_bds; i++) {
 			struct bcm_enet_desc *d = &iudma->bd_ring[i];
-- 
2.35.1

