Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEE997462C8
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 20:52:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231292AbjGCSwb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 14:52:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230391AbjGCSw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 14:52:28 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65B4EAF;
        Mon,  3 Jul 2023 11:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688410346; x=1719946346;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vglDNwRcSKOGrj0IrUTDI9q4BegirR6oTWfUcwYB95I=;
  b=hvhHGQ6pBcLzrfrojWdTfuTNXb3IE4OaRkARPiR4eTLUftqkbUUqF2ZO
   dNOe1qg4X5L1RXZxIJjIBxX92fp+02hcGJWWhULRyHsNwCwY92oxiVrEx
   ZCLKr24w9MwPUAKyhvm1OrkNZpKUx8vpS5wLDNjMY/ZxOmXD/OkSILUWC
   hSI1QyDGa9znvuS98TkFwt99bwsN72McFNSz2QrKNlnvI+CNwrA6SQyGN
   bjH1B3DcOSAfM5s114qJSX3y7fYK46CpyhjQ057Pk0FRUCUFxIWe37BRS
   3nU56ZGlym+NtnfzMFWrqClm0f7G69RFfku+VkezB93WkflteSFvk7gWc
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10760"; a="362986960"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; 
   d="scan'208";a="362986960"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2023 11:52:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10760"; a="721860811"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; 
   d="scan'208";a="721860811"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 03 Jul 2023 11:52:24 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 4B284178; Mon,  3 Jul 2023 21:52:27 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Andy Shevchenko <andy@kernel.org>
Subject: [PATCH v1 04/12] HID: cp2112: Switch to for_each_set_bit() to simplify the code
Date:   Mon,  3 Jul 2023 21:52:14 +0300
Message-Id: <20230703185222.50554-5-andriy.shevchenko@linux.intel.com>
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

It's cleaner to use for_each_set_bit() than open coding it.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/hid/hid-cp2112.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/hid/hid-cp2112.c b/drivers/hid/hid-cp2112.c
index 51399b231d36..fb4548feb0c8 100644
--- a/drivers/hid/hid-cp2112.c
+++ b/drivers/hid/hid-cp2112.c
@@ -16,6 +16,7 @@
  *   https://www.silabs.com/documents/public/application-notes/an495-cp2112-interface-specification.pdf
  */
 
+#include <linux/bitops.h>
 #include <linux/gpio/consumer.h>
 #include <linux/gpio/machine.h>
 #include <linux/gpio/driver.h>
@@ -1100,7 +1101,6 @@ static void cp2112_gpio_poll_callback(struct work_struct *work)
 						 gpio_poll_worker.work);
 	struct irq_data *d;
 	u8 gpio_mask;
-	u8 virqs = (u8)dev->irq_mask;
 	u32 irq_type;
 	int irq, virq, ret;
 
@@ -1111,11 +1111,7 @@ static void cp2112_gpio_poll_callback(struct work_struct *work)
 		goto exit;
 
 	gpio_mask = ret;
-
-	while (virqs) {
-		virq = ffs(virqs) - 1;
-		virqs &= ~BIT(virq);
-
+	for_each_set_bit(virq, &dev->irq_mask, 8) {
 		if (!dev->gc.to_irq)
 			break;
 
-- 
2.40.0.1.gaa8946217a0b

