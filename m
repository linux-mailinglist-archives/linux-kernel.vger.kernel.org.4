Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01FFB7462D1
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 20:52:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231381AbjGCSwi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 14:52:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231228AbjGCSw3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 14:52:29 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A01BAF;
        Mon,  3 Jul 2023 11:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688410349; x=1719946349;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=afc07R7Fx+NGuUmDJNCCGkFgs3O6oULmTGVDhDPMWbQ=;
  b=bzzqVpwjjiTMD1+uxU2LXoO3DKd/VKT1zqAUTOFvlP2RGYJegndjPZ+0
   8ShCRDnfDFWK63OxPC66DDE0gNP2U9Lh9oSMOosfM/vhSPSooDotmPetn
   t93qMZtSyzj4swrUbxTrcWcuCHLOnRK+n37UhYS4nHgRxqknCe8UPhPcu
   0v2TzWn4utaD7uEteRRDPVnqQPAASeujm9FWEoUGwgKgKBZcvE8MHktJU
   pm0qUMjU2sYgrPAN5tZ+p3GnkVpATrBfwEUAFOTSD1QQztccAF+0G83v9
   oO4XaJBTGpwVYkwEcziM+5yXqqxXAKOMbish9IjR58VOjAtQYc6EE6A+B
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10760"; a="362986966"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; 
   d="scan'208";a="362986966"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2023 11:52:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10760"; a="721860813"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; 
   d="scan'208";a="721860813"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 03 Jul 2023 11:52:26 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 631041D9; Mon,  3 Jul 2023 21:52:27 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Andy Shevchenko <andy@kernel.org>
Subject: [PATCH v1 05/12] HID: cp2112: Don't call ->to_irq() explicitly
Date:   Mon,  3 Jul 2023 21:52:15 +0300
Message-Id: <20230703185222.50554-6-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20230703185222.50554-1-andriy.shevchenko@linux.intel.com>
References: <20230703185222.50554-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GPIO library guarantees that ->to_irq() is always exists.
Moreover, it tending to become a nische thingy and has to
not be used in ordinary drivers. Hence, replace that by
irq_find_mapping().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/hid/hid-cp2112.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/hid/hid-cp2112.c b/drivers/hid/hid-cp2112.c
index fb4548feb0c8..15b626359281 100644
--- a/drivers/hid/hid-cp2112.c
+++ b/drivers/hid/hid-cp2112.c
@@ -1112,10 +1112,9 @@ static void cp2112_gpio_poll_callback(struct work_struct *work)
 
 	gpio_mask = ret;
 	for_each_set_bit(virq, &dev->irq_mask, 8) {
-		if (!dev->gc.to_irq)
-			break;
-
-		irq = dev->gc.to_irq(&dev->gc, virq);
+		irq = irq_find_mapping(dev->gc.irq.domain, virq);
+		if (!irq)
+			continue;
 
 		d = irq_get_irq_data(irq);
 		if (!d)
-- 
2.40.0.1.gaa8946217a0b

