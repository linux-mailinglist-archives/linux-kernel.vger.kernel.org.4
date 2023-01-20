Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5561E6758F2
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 16:44:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230409AbjATPoN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 10:44:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbjATPoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 10:44:09 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0AAA6A30D;
        Fri, 20 Jan 2023 07:44:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674229447; x=1705765447;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Zvmz1e8tNVkf9F2k6v9cQ9mCVyAkLICIV32C307I3+A=;
  b=BbOlueFg5urU2fIRZkhnbjmOgZ8lI8vskiRtkaGnfGQWVfjdDzrG4qXw
   xgbtZAmLM/hVmnBu/1QZXPRDJ9zh3z0a7H+BvDCWlw2DdbT6l1YUe1u3x
   dv9uml+lx0dPdQWS9X2p9YF7rsZk4T17Eh6nYyG9SUtt6ZzP0ovK90GON
   35HutaZ9blgcLU+9v3IMRomfagNFM5G0S4LGugNPbVgFI4SiiI4MgWCo7
   s8OfDAWsFEbYALoJ3vHA/83CbcgubdmG2QtMr9D+wwg9BwBUxPIOIeXHb
   tveEtqmgXFfIfOubGZEjrRqFuXQ2t2nmelrOz7/06wbkbdjqrubTyTrbB
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10596"; a="309179502"
X-IronPort-AV: E=Sophos;i="5.97,232,1669104000"; 
   d="scan'208";a="309179502"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2023 07:44:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10596"; a="610512127"
X-IronPort-AV: E=Sophos;i="5.97,232,1669104000"; 
   d="scan'208";a="610512127"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 20 Jan 2023 07:44:05 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 048EA36D; Fri, 20 Jan 2023 17:44:40 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 3/5] usb: fotg210-udc: remove redundant error logging
Date:   Fri, 20 Jan 2023 17:44:35 +0200
Message-Id: <20230120154437.22025-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230120154437.22025-1-andriy.shevchenko@linux.intel.com>
References: <20230120154437.22025-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A call to platform_get_irq() already prints an error on failure within
its own implementation. So printing another error based on its return
value in the caller is redundant and should be removed. The clean up
also makes if condition block braces unnecessary. Remove that as well.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/usb/fotg210/fotg210-udc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/fotg210/fotg210-udc.c b/drivers/usb/fotg210/fotg210-udc.c
index 4334504fccc8..18d254125186 100644
--- a/drivers/usb/fotg210/fotg210-udc.c
+++ b/drivers/usb/fotg210/fotg210-udc.c
@@ -1169,10 +1169,8 @@ int fotg210_udc_probe(struct platform_device *pdev, struct fotg210 *fotg)
 	int i;
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		pr_err("could not get irq\n");
-		return -ENODEV;
-	}
+	if (irq < 0)
+		return irq;
 
 	/* initialize udc */
 	fotg210 = kzalloc(sizeof(struct fotg210_udc), GFP_KERNEL);
-- 
2.39.0

