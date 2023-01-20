Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF0186758F5
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 16:44:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbjATPoW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 10:44:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230061AbjATPoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 10:44:10 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F635518EC;
        Fri, 20 Jan 2023 07:44:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674229449; x=1705765449;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KclXtp6RTwwDl0Jov5zoQLZjJ3zoGzOqCU2QiwmBSBo=;
  b=V5wPBcTaXOVkMHAiT9VCLqhFphYl+k6j7OClKUOxDSl2g3oFw8YnGZqt
   fMrCxbg+e6YehfejNkyeqdvsI1qrugARDYKh0Jw4kN187uzT7SdFAE8M8
   ok8ZesY/jDg+/cKwB48jkQVqkzPEbqQwymnS6mlxgfTagZTzJs3Iv7p+0
   +sBxuS830oyDiFQs7hdIEIs7QWOC/OiY6d4qM8+XusxTBYk4Lo2XWOO/E
   cj8tbkWswb5wPEI/GDpWr76IEXm7J6WuBdRw/5XtqT7XS5sfU8uRiyTMT
   tZtg1Q6T9TFUKTtPx4bP9Ndf1J/sL6T42yseF8M+m7QbVXVGEEZO42Dqn
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10596"; a="309179498"
X-IronPort-AV: E=Sophos;i="5.97,232,1669104000"; 
   d="scan'208";a="309179498"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2023 07:44:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10596"; a="610512126"
X-IronPort-AV: E=Sophos;i="5.97,232,1669104000"; 
   d="scan'208";a="610512126"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 20 Jan 2023 07:44:05 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id F301F14A; Fri, 20 Jan 2023 17:44:39 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 2/5] usb: fotg210-hcd: Don't shadow error codes in store()
Date:   Fri, 20 Jan 2023 17:44:34 +0200
Message-Id: <20230120154437.22025-2-andriy.shevchenko@linux.intel.com>
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

kstrtox() along with regmap API can return different error codes based on
circumstances.

Don't shadow them when returning to the caller.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/usb/fotg210/fotg210-hcd.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/fotg210/fotg210-hcd.c b/drivers/usb/fotg210/fotg210-hcd.c
index 46752a75c428..5a934f5343a7 100644
--- a/drivers/usb/fotg210/fotg210-hcd.c
+++ b/drivers/usb/fotg210/fotg210-hcd.c
@@ -4702,8 +4702,10 @@ static ssize_t uframe_periodic_max_store(struct device *dev,
 	ssize_t ret;
 
 	fotg210 = hcd_to_fotg210(bus_to_hcd(dev_get_drvdata(dev)));
-	if (kstrtouint(buf, 0, &uframe_periodic_max) < 0)
-		return -EINVAL;
+
+	ret = kstrtouint(buf, 0, &uframe_periodic_max);
+	if (ret)
+		return ret;
 
 	if (uframe_periodic_max < 100 || uframe_periodic_max >= 125) {
 		fotg210_info(fotg210, "rejecting invalid request for uframe_periodic_max=%u\n",
-- 
2.39.0

