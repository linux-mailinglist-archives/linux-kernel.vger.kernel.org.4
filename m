Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49B9C5EC961
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 18:24:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231636AbiI0QY0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 12:24:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232838AbiI0QYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 12:24:09 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C48F415EF98;
        Tue, 27 Sep 2022 09:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664295848; x=1695831848;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dpNyqYIg37FmXv5O2Z7OWfgIqfp8/Y7GWzFm22mxQjs=;
  b=KTuzX4gaF0PKZMegG+m7e4zaK0eM3if05gPFgVHRycI95BPlpDhIY7Ct
   K2LuUW5rhR+qb2wdo/zAjWcpfMcpPGnRU/3v7iqjl83Kcf2WuGY0ZWznO
   bR5DKMUuttyP6WvkSK3K3Y0dS2+l7Nnmu7qwbeStIUvaVErevZ7vuj11Z
   KYM1aKJE/euckqoFhrJoluy6uRUOfmfhGiyO5hlXQOZ8n7gTmRfO5BdB6
   tdBXVRw5JfgT5+1DnA/7xDO3ZS9+kIysKtDu+7M78lbsE2kynCkiiTrSo
   OuBVW6Q0nhhCAEbky1dV7xbKOg6IpEUDGY1kllNKcMLabJe9mj7+OXgfd
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="327719510"
X-IronPort-AV: E=Sophos;i="5.93,349,1654585200"; 
   d="scan'208";a="327719510"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2022 09:24:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="763935894"
X-IronPort-AV: E=Sophos;i="5.93,349,1654585200"; 
   d="scan'208";a="763935894"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 27 Sep 2022 09:24:05 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 7E124101; Tue, 27 Sep 2022 19:24:23 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Thierry Reding <thierry.reding@gmail.com>
Subject: [PATCH v4 2/7] pwm: lpss: Move exported symbols to PWM_LPSS namespace
Date:   Tue, 27 Sep 2022 19:24:16 +0300
Message-Id: <20220927162421.11052-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220927162421.11052-1-andriy.shevchenko@linux.intel.com>
References: <20220927162421.11052-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoid unnecessary pollution of the global symbol namespace by
moving library functions in to a specific namespace and import
that into the drivers that make use of the functions.

For more info: https://lwn.net/Articles/760045/

Suggested-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-lpss-pci.c      | 1 +
 drivers/pwm/pwm-lpss-platform.c | 1 +
 drivers/pwm/pwm-lpss.c          | 2 ++
 3 files changed, 4 insertions(+)

diff --git a/drivers/pwm/pwm-lpss-pci.c b/drivers/pwm/pwm-lpss-pci.c
index 75b778e839b3..9f2c666b95ec 100644
--- a/drivers/pwm/pwm-lpss-pci.c
+++ b/drivers/pwm/pwm-lpss-pci.c
@@ -92,3 +92,4 @@ module_pci_driver(pwm_lpss_driver_pci);
 
 MODULE_DESCRIPTION("PWM PCI driver for Intel LPSS");
 MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS(PWM_LPSS);
diff --git a/drivers/pwm/pwm-lpss-platform.c b/drivers/pwm/pwm-lpss-platform.c
index 834423c34f48..65154c0abab1 100644
--- a/drivers/pwm/pwm-lpss-platform.c
+++ b/drivers/pwm/pwm-lpss-platform.c
@@ -88,4 +88,5 @@ module_platform_driver(pwm_lpss_driver_platform);
 
 MODULE_DESCRIPTION("PWM platform driver for Intel LPSS");
 MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS(PWM_LPSS);
 MODULE_ALIAS("platform:pwm-lpss");
diff --git a/drivers/pwm/pwm-lpss.c b/drivers/pwm/pwm-lpss.c
index 9537aefd254a..74a296cb1af0 100644
--- a/drivers/pwm/pwm-lpss.c
+++ b/drivers/pwm/pwm-lpss.c
@@ -18,6 +18,8 @@
 #include <linux/pm_runtime.h>
 #include <linux/time.h>
 
+#define DEFAULT_SYMBOL_NAMESPACE PWM_LPSS
+
 #include "pwm-lpss.h"
 
 #define PWM				0x00000000
-- 
2.35.1

