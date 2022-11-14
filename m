Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34993627C51
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 12:29:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236401AbiKNL3d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 06:29:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236119AbiKNL2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 06:28:51 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA49EB40;
        Mon, 14 Nov 2022 03:28:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668425305; x=1699961305;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cbHRKiBhBcfb/glMiq5EVCvPmL/FExuknALj1+3+vrE=;
  b=cYOZiq3GNj6IK/9GV/Slolw47SRvKzDvdwsN2J91Lw7WaIt30QhNgKqT
   1u7UslYArshZRUr4dHR1rX2AWNEK2nMC9lq4bqObq7ZSdJtY7UsREkbDB
   7hC7+Bi3ftM2a1ftHQj2H+Ag3nQSLwgvwcZHbyWz/9lr/jZLuBm3NXQTC
   WnY0qcBAKdoZ4SJgoHe7ZCPurbkoOc7QmxbxqaPtD3CQ3WEg/7prEwnyi
   KYaOz9CHypDSQmeGQ31iYqAu3FM7h98MsGl7VMBcS5PNlCmN69ApZZ4z8
   EcRlCvRBUgdZyzkDp98JDrN2657M4/yNRWbwdVK1TsWlrmkawejie2b+O
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10530"; a="374074730"
X-IronPort-AV: E=Sophos;i="5.96,161,1665471600"; 
   d="scan'208";a="374074730"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2022 03:28:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10530"; a="616278554"
X-IronPort-AV: E=Sophos;i="5.96,161,1665471600"; 
   d="scan'208";a="616278554"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 14 Nov 2022 03:28:19 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 35D382F3; Mon, 14 Nov 2022 13:28:44 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jakob Koschel <jakobkoschel@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Kevin Cernekee <cernekee@gmail.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v1 3/4] usb: gadget: udc: bcm63xx: Convert to use list_count()
Date:   Mon, 14 Nov 2022 13:28:41 +0200
Message-Id: <20221114112842.38565-3-andriy.shevchenko@linux.intel.com>
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

