Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BC0E658CF7
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 13:59:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233364AbiL2M7j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 07:59:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233355AbiL2M7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 07:59:34 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1008513DE9;
        Thu, 29 Dec 2022 04:59:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672318774; x=1703854774;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=34P7+7ieU5tbrjpB2CMgoEmWUxpnYkYbmhyOoY0g5QI=;
  b=Cu4eGI03S8f2zxWZle3muOnBDAQ4QlcQ24u51MyUvNY8yXoiu3jdK3nG
   9DWsmUM/dfHSmPysFa2I8EpJWDd4LJF4SkKVfkiDUfu2E4IjVClO0Cr8x
   A7MER7j5tklenQybwvNBQisHw/sAweCmuWhVlR0I9HQNIJfcJDPpI7VbO
   Y8bsJpNBazmWhDEEGig+TGqh95hBJUFdvmHmuJOruFvg9YPPxQJPFmejA
   pXzdqZd+Qwveaj9d8M8V+klLiF2cuIg8kmccgCv5O0KEo2mTLFV4NEpYf
   GCwIHqGa7USVl2486BAo2YAwjk5vOQKGocYHKDRMCOZtCXBwcanzLeLEf
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10574"; a="348247462"
X-IronPort-AV: E=Sophos;i="5.96,284,1665471600"; 
   d="scan'208";a="348247462"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2022 04:59:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10574"; a="777691260"
X-IronPort-AV: E=Sophos;i="5.96,284,1665471600"; 
   d="scan'208";a="777691260"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 29 Dec 2022 04:59:30 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 52DE0F8; Thu, 29 Dec 2022 15:00:01 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Paul Cercueil <paul@crapouillou.net>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Cc:     Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>
Subject: [PATCH v1 1/3] pm: Introduce DEFINE_NOIRQ_DEV_PM_OPS() helper
Date:   Thu, 29 Dec 2022 14:59:55 +0200
Message-Id: <20221229125957.45923-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221229125957.45923-1-andriy.shevchenko@linux.intel.com>
References: <20221229125957.45923-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are a few drivers and might be more in the future that
open code the functionality of proposed DEFINE_NOIRQ_DEV_PM_OPS()
helper. From now on they may switch to the new helper and save
a few lines of code.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/pm.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/pm.h b/include/linux/pm.h
index 93cd34f00822..eba96822b1d9 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -444,6 +444,11 @@ const struct dev_pm_ops __maybe_unused name = { \
 	SET_RUNTIME_PM_OPS(suspend_fn, resume_fn, idle_fn) \
 }
 
+#define DEFINE_NOIRQ_DEV_PM_OPS(name, suspend_fn, resume_fn) \
+const struct dev_pm_ops name = { \
+	NOIRQ_SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn) \
+}
+
 #define pm_ptr(_ptr) PTR_IF(IS_ENABLED(CONFIG_PM), (_ptr))
 #define pm_sleep_ptr(_ptr) PTR_IF(IS_ENABLED(CONFIG_PM_SLEEP), (_ptr))
 
-- 
2.35.1

