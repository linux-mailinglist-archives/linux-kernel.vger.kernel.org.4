Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E55D6946FB
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 14:27:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbjBMN1j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 08:27:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjBMN1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 08:27:38 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D49D1A4B8;
        Mon, 13 Feb 2023 05:27:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676294857; x=1707830857;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=jPQ6x6Tbwh+UqIy3KRlKxbErjK9ePbHRcwUVfTAEYgk=;
  b=ch3xKtV0RBv57IMykv9Ar+GEnRIqAxgMzfioNHsZR5B8gPQoLaMRElIX
   dVkKOeGxxFjb6GDU+v7A5lkMxa6QyJYwdZKMhW0WcwklPjDqu4Zrz6shY
   yeh75nLzAnxAUo9MfV0KSNCFCQy3dcp/3KBbMEEEiHD+xtjH9waukxkeT
   9Z74jMzs6ptDjQwP7AWhJ/fr4cQDl0Fz4MHjaIJWFwEuLh3mgtofkd6cI
   x+tK6s+Hy2Jyd1j6srv8PlQPeSYWy60EGm/BNzmKu0w67aOdnnGxpUuif
   soYrEM6BLkBKzbmwnCR9eYGLqhhRPUeH8U7U5uCgWI+ES6Uz2jL+37b2J
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10620"; a="393286330"
X-IronPort-AV: E=Sophos;i="5.97,294,1669104000"; 
   d="scan'208";a="393286330"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2023 05:27:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10620"; a="777842510"
X-IronPort-AV: E=Sophos;i="5.97,294,1669104000"; 
   d="scan'208";a="777842510"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 13 Feb 2023 05:27:34 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id B31781F8; Mon, 13 Feb 2023 15:28:13 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v1 1/1] Documentation: firmware-guide: gpio-properties: Clarify Explicit and Implicit
Date:   Mon, 13 Feb 2023 15:28:12 +0200
Message-Id: <20230213132812.38646-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.39.1
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

Clarify the Explicit and Implicit meanings in the table of Pull Bias.

While at it, distinguish pull bias keywords used in ACPI by using bold
font in the table of the respective terms.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 .../firmware-guide/acpi/gpio-properties.rst   | 25 +++++++++++--------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/Documentation/firmware-guide/acpi/gpio-properties.rst b/Documentation/firmware-guide/acpi/gpio-properties.rst
index eaec732cc77c..ae87aa64cb7b 100644
--- a/Documentation/firmware-guide/acpi/gpio-properties.rst
+++ b/Documentation/firmware-guide/acpi/gpio-properties.rst
@@ -67,17 +67,20 @@ state of the output pin which driver should use during its initialization.
 Linux tries to use common sense here and derives the state from the bias
 and polarity settings. The table below shows the expectations:
 
-=========  =============  ==============
-Pull Bias     Polarity     Requested...
-=========  =============  ==============
-Implicit     x            AS IS (assumed firmware configured for us)
-Explicit     x (no _DSD)  as Pull Bias (Up == High, Down == Low),
-                          assuming non-active (Polarity = !Pull Bias)
-Down         Low          as low, assuming active
-Down         High         as low, assuming non-active
-Up           Low          as high, assuming non-active
-Up           High         as high, assuming active
-=========  =============  ==============
+=========          =============  ==============
+Pull Bias             Polarity     Requested...
+=========          =============  ==============
+Implicit             x            AS IS (assumed firmware configured it for us)
+(**Default**)
+Explicit             x (no _DSD)  as Pull Bias (**Up** == high, **Down** == low),
+(**Up**, **Down**,                assuming non-active (Polarity = !Pull Bias);
+ **None**)                        or AS IS (assumed firmware configured it for us)
+                                  with no Pull Bias
+**Down**             Low          as low, assuming active
+**Down**             High         as low, assuming non-active
+**Up**               Low          as high, assuming non-active
+**Up**               High         as high, assuming active
+=========          =============  ==============
 
 That said, for our above example the both GPIOs, since the bias setting
 is explicit and _DSD is present, will be treated as active with a high
-- 
2.39.1

