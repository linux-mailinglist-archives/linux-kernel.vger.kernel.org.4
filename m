Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 376A26D07F6
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 16:20:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232396AbjC3OUE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 10:20:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232338AbjC3OT4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 10:19:56 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6C8CC160;
        Thu, 30 Mar 2023 07:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680185977; x=1711721977;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=79LV+OrRl703R6iMPgkR0twJmLykHeDX2mMjxvwYOEg=;
  b=OX9PRYjsnUiuG7c1SaP9xfxZGfbP96zFaeTUay8nMAz77C40tnMnpVlB
   Elew9ZivchFIPDV5RoKBy4L9rco+6IxS6fzyRs2zYd9SWekU0PxS0huA3
   B+uE0r8aiiDLcdYr9ijZk3lmX1SZvLP24/9+7qEUVtz7GjY3NhZzxiL2W
   QNzbFA3L4IvzOooWkttSFdofLTCd7145DtIUUty7R8bx0pBnt6Wcw+nOj
   0VnQCDInIcVt1OovRpDnh+y2ZtGD8yG3R1SWfJ42MbiXNLZ/UmRBvKl04
   MmCfxeKCkk+bLaVxXBEvfqGThl34j5s5sohZDm+kn8L0gPB0E23SxcATE
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10665"; a="339903322"
X-IronPort-AV: E=Sophos;i="5.98,303,1673942400"; 
   d="scan'208";a="339903322"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2023 07:19:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10665"; a="749213928"
X-IronPort-AV: E=Sophos;i="5.98,303,1673942400"; 
   d="scan'208";a="749213928"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 30 Mar 2023 07:19:17 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id CD98814B; Thu, 30 Mar 2023 17:15:40 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Olliver Schinagl <oliver@schinagl.nl>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>
Subject: [PATCH v1 2/2] thunderbolt: Make use of ioread32_poll_timeout()
Date:   Thu, 30 Mar 2023 17:14:13 +0300
Message-Id: <20230330141413.25569-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20230330141413.25569-1-andriy.shevchenko@linux.intel.com>
References: <20230330141413.25569-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of open coding the same routine switch the code to use
ioread32_poll_timeout().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/thunderbolt/nhi.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/drivers/thunderbolt/nhi.c b/drivers/thunderbolt/nhi.c
index d76e923fbc6a..d0bf11b40131 100644
--- a/drivers/thunderbolt/nhi.c
+++ b/drivers/thunderbolt/nhi.c
@@ -16,8 +16,8 @@
 #include <linux/dma-mapping.h>
 #include <linux/interrupt.h>
 #include <linux/iommu.h>
+#include <linux/iopoll.h>
 #include <linux/module.h>
-#include <linux/delay.h>
 #include <linux/property.h>
 #include <linux/string_helpers.h>
 
@@ -40,7 +40,7 @@
 #define MSIX_MIN_VECS		6
 #define MSIX_MAX_VECS		16
 
-#define NHI_MAILBOX_TIMEOUT	500 /* ms */
+#define NHI_MAILBOX_TIMEOUT_US	500000
 
 /* Host interface quirks */
 #define QUIRK_AUTO_CLEAR_INT	BIT(0)
@@ -830,8 +830,8 @@ EXPORT_SYMBOL_GPL(tb_ring_free);
  */
 int nhi_mailbox_cmd(struct tb_nhi *nhi, enum nhi_mailbox_cmd cmd, u32 data)
 {
-	ktime_t timeout;
 	u32 val;
+	int ret;
 
 	iowrite32(data, nhi->iobase + REG_INMAIL_DATA);
 
@@ -840,16 +840,12 @@ int nhi_mailbox_cmd(struct tb_nhi *nhi, enum nhi_mailbox_cmd cmd, u32 data)
 	val |= REG_INMAIL_OP_REQUEST | cmd;
 	iowrite32(val, nhi->iobase + REG_INMAIL_CMD);
 
-	timeout = ktime_add_ms(ktime_get(), NHI_MAILBOX_TIMEOUT);
-	do {
-		val = ioread32(nhi->iobase + REG_INMAIL_CMD);
-		if (!(val & REG_INMAIL_OP_REQUEST))
-			break;
-		usleep_range(10, 20);
-	} while (ktime_before(ktime_get(), timeout));
+	ret = ioread32_poll_timeout(nhi->iobase + REG_INMAIL_CMD,
+				    val, !(val & REG_INMAIL_OP_REQUEST),
+				    40, NHI_MAILBOX_TIMEOUT_US);
+	if (ret)
+		return ret;
 
-	if (val & REG_INMAIL_OP_REQUEST)
-		return -ETIMEDOUT;
 	if (val & REG_INMAIL_ERROR)
 		return -EIO;
 
-- 
2.40.0.1.gaa8946217a0b

