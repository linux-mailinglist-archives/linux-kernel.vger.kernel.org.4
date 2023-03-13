Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58FE16B7CD4
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 16:54:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231150AbjCMPx6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 11:53:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231222AbjCMPxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 11:53:42 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00621206AE;
        Mon, 13 Mar 2023 08:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678722802; x=1710258802;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=44H65SqPEjytPpOdhJ9BoDKKnN4CrCDrzMx5ajkPqYc=;
  b=bV4pNF/EaKH+20m4yGh8uotIq3USur1YMKPeU21xtN5fBR8Rfpw8tGwv
   xCj1L5j5QPjduxdJeddSCfwVLgUeXS15lZbfjK8N6QThszd6BoVuL2l/L
   Ighh1IBeUbawekb/bJRmA+dBYBIZT/hmsIZf/wtWiA2d3tVZAgun0Q2X2
   tnUs+CdXTUKMCAeD0vrK5j65WE1/k6tsRurwQX754IBVKMg3Z3nFxUYWZ
   tI20C4mx8m8QOmDPeht2Cdjyu/wxYg0cLOyePrkrMJ0OYNoN+HoTnwEz4
   uKFjeL6QtvRFE4GtTdQMjaLlinat/y0vVIYYfVIOA1vY+GwYtIwqwNyWA
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="337206324"
X-IronPort-AV: E=Sophos;i="5.98,257,1673942400"; 
   d="scan'208";a="337206324"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2023 08:52:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="747659008"
X-IronPort-AV: E=Sophos;i="5.98,257,1673942400"; 
   d="scan'208";a="747659008"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 13 Mar 2023 08:52:31 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 74026365; Mon, 13 Mar 2023 17:53:15 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Henry Tian <tianxiaofeng@bytedance.com>,
        Joel Stanley <joel@jms.id.au>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Liang He <windhl@126.com>, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Jeffery <andrew@aj.id.au>
Subject: [PATCH v1 1/1] usb: gadget: aspeed: Rectify a bit a random header inclusion
Date:   Mon, 13 Mar 2023 17:53:10 +0200
Message-Id: <20230313155310.80022-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.39.2
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

It looks like the driver copied'n'pasted almost random set of
headers for its code. Rectify it a bit by removing of_gpio.h
that is not only unused, but also will be removed in the future
completely.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/usb/gadget/udc/aspeed-vhub/core.c | 1 -
 drivers/usb/gadget/udc/aspeed-vhub/dev.c  | 1 -
 drivers/usb/gadget/udc/aspeed-vhub/ep0.c  | 1 -
 drivers/usb/gadget/udc/aspeed-vhub/epn.c  | 1 -
 drivers/usb/gadget/udc/aspeed-vhub/hub.c  | 1 -
 5 files changed, 5 deletions(-)

diff --git a/drivers/usb/gadget/udc/aspeed-vhub/core.c b/drivers/usb/gadget/udc/aspeed-vhub/core.c
index ac3ca24f8b04..86398a04a012 100644
--- a/drivers/usb/gadget/udc/aspeed-vhub/core.c
+++ b/drivers/usb/gadget/udc/aspeed-vhub/core.c
@@ -21,7 +21,6 @@
 #include <linux/clk.h>
 #include <linux/usb/gadget.h>
 #include <linux/of.h>
-#include <linux/of_gpio.h>
 #include <linux/regmap.h>
 #include <linux/dma-mapping.h>
 
diff --git a/drivers/usb/gadget/udc/aspeed-vhub/dev.c b/drivers/usb/gadget/udc/aspeed-vhub/dev.c
index 4f3bc27c1c62..573109ca5b79 100644
--- a/drivers/usb/gadget/udc/aspeed-vhub/dev.c
+++ b/drivers/usb/gadget/udc/aspeed-vhub/dev.c
@@ -21,7 +21,6 @@
 #include <linux/clk.h>
 #include <linux/usb/gadget.h>
 #include <linux/of.h>
-#include <linux/of_gpio.h>
 #include <linux/regmap.h>
 #include <linux/dma-mapping.h>
 #include <linux/usb.h>
diff --git a/drivers/usb/gadget/udc/aspeed-vhub/ep0.c b/drivers/usb/gadget/udc/aspeed-vhub/ep0.c
index b4cf46249fea..e9aa74231760 100644
--- a/drivers/usb/gadget/udc/aspeed-vhub/ep0.c
+++ b/drivers/usb/gadget/udc/aspeed-vhub/ep0.c
@@ -21,7 +21,6 @@
 #include <linux/clk.h>
 #include <linux/usb/gadget.h>
 #include <linux/of.h>
-#include <linux/of_gpio.h>
 #include <linux/regmap.h>
 #include <linux/dma-mapping.h>
 
diff --git a/drivers/usb/gadget/udc/aspeed-vhub/epn.c b/drivers/usb/gadget/udc/aspeed-vhub/epn.c
index 56e55472daa1..148d7ec3ebf4 100644
--- a/drivers/usb/gadget/udc/aspeed-vhub/epn.c
+++ b/drivers/usb/gadget/udc/aspeed-vhub/epn.c
@@ -21,7 +21,6 @@
 #include <linux/clk.h>
 #include <linux/usb/gadget.h>
 #include <linux/of.h>
-#include <linux/of_gpio.h>
 #include <linux/regmap.h>
 #include <linux/dma-mapping.h>
 
diff --git a/drivers/usb/gadget/udc/aspeed-vhub/hub.c b/drivers/usb/gadget/udc/aspeed-vhub/hub.c
index e2207d014620..a63e4af60a56 100644
--- a/drivers/usb/gadget/udc/aspeed-vhub/hub.c
+++ b/drivers/usb/gadget/udc/aspeed-vhub/hub.c
@@ -21,7 +21,6 @@
 #include <linux/clk.h>
 #include <linux/usb/gadget.h>
 #include <linux/of.h>
-#include <linux/of_gpio.h>
 #include <linux/regmap.h>
 #include <linux/dma-mapping.h>
 #include <linux/bcd.h>
-- 
2.39.2

