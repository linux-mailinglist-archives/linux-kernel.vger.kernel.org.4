Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 861556ACE8A
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 20:55:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbjCFTzm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 14:55:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230158AbjCFTzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 14:55:37 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCD4A6A047;
        Mon,  6 Mar 2023 11:55:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678132534; x=1709668534;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oNHVpcFZrYbfI1Ngidi0XIrUh6MQDoXmEl3L94PnfHU=;
  b=XfhWqvcyPsRKzmhAdVrKDvjnA2LlpiSOVcEuIaWKqEo1O8yQhG7giLOT
   IQ3W8lvAmA9eC3DJaOOP20WK5SS1Yzh0Pu7+x3vSmG1AdJDcV+nXJ4x38
   l5HZrIIIDxVLKbhCZdRBAmJWRY6rLKRjqYbwVO6RmFxiDwA/llLZCzbkq
   OQ1GDi0c0yL6vxEa4syE5myMRP6ydF5WRtxkVuFuzGtOzH8va3wZITDC+
   dgp+xyYqRY+LY3wsqkmRrdQlQ+2Tt0dW2h0qV8Jn6VfOrN2UycCeJjfcH
   D/VBSxWTjXneCmPsvyd8RluMTkSpmaOIFYQ/iR0tKE7zEVa4g58/u/eOD
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="400483882"
X-IronPort-AV: E=Sophos;i="5.98,238,1673942400"; 
   d="scan'208";a="400483882"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2023 11:55:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="1005549561"
X-IronPort-AV: E=Sophos;i="5.98,238,1673942400"; 
   d="scan'208";a="1005549561"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 06 Mar 2023 11:55:28 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 57F61354; Mon,  6 Mar 2023 21:56:12 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Schspa Shi <schspa@gmail.com>, Marc Zyngier <maz@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        patches@opensource.cirrus.com
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Doug Berger <opendmb@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Andy Shevchenko <andy@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Nandor Han <nandor.han@ge.com>,
        Semi Malinen <semi.malinen@ge.com>
Subject: [PATCH v1 02/16] lib/string_helpers: Split out string_choices.h
Date:   Mon,  6 Mar 2023 21:55:42 +0200
Message-Id: <20230306195556.55475-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230306195556.55475-1-andriy.shevchenko@linux.intel.com>
References: <20230306195556.55475-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some users may only need the string choice APIs. Split
the respective header, i.e. string_choices.h. Include
it in the string_helpers.h for backward compatibility.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 MAINTAINERS                    |  1 +
 include/linux/string_choices.h | 32 ++++++++++++++++++++++++++++++++
 include/linux/string_helpers.h | 26 +-------------------------
 3 files changed, 34 insertions(+), 25 deletions(-)
 create mode 100644 include/linux/string_choices.h

diff --git a/MAINTAINERS b/MAINTAINERS
index ee157981c4cf..64f19e200191 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8616,6 +8616,7 @@ GENERIC STRING LIBRARY
 R:	Andy Shevchenko <andy@kernel.org>
 S:	Maintained
 F:	include/linux/string.h
+F:	include/linux/string_choices.h
 F:	include/linux/string_helpers.h
 F:	lib/string.c
 F:	lib/string_helpers.c
diff --git a/include/linux/string_choices.h b/include/linux/string_choices.h
new file mode 100644
index 000000000000..b7e7b9fd098c
--- /dev/null
+++ b/include/linux/string_choices.h
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_STRING_CHOICES_H_
+#define _LINUX_STRING_CHOICES_H_
+
+#include <linux/types.h>
+
+static inline const char *str_enable_disable(bool v)
+{
+	return v ? "enable" : "disable";
+}
+
+static inline const char *str_enabled_disabled(bool v)
+{
+	return v ? "enabled" : "disabled";
+}
+
+static inline const char *str_read_write(bool v)
+{
+	return v ? "read" : "write";
+}
+
+static inline const char *str_on_off(bool v)
+{
+	return v ? "on" : "off";
+}
+
+static inline const char *str_yes_no(bool v)
+{
+	return v ? "yes" : "no";
+}
+
+#endif
diff --git a/include/linux/string_helpers.h b/include/linux/string_helpers.h
index fae6beaaa217..0f2255738940 100644
--- a/include/linux/string_helpers.h
+++ b/include/linux/string_helpers.h
@@ -5,6 +5,7 @@
 #include <linux/bits.h>
 #include <linux/ctype.h>
 #include <linux/string.h>
+#include <linux/string_choices.h>
 #include <linux/types.h>
 
 struct device;
@@ -113,29 +114,4 @@ void kfree_strarray(char **array, size_t n);
 
 char **devm_kasprintf_strarray(struct device *dev, const char *prefix, size_t n);
 
-static inline const char *str_yes_no(bool v)
-{
-	return v ? "yes" : "no";
-}
-
-static inline const char *str_on_off(bool v)
-{
-	return v ? "on" : "off";
-}
-
-static inline const char *str_enable_disable(bool v)
-{
-	return v ? "enable" : "disable";
-}
-
-static inline const char *str_enabled_disabled(bool v)
-{
-	return v ? "enabled" : "disabled";
-}
-
-static inline const char *str_read_write(bool v)
-{
-	return v ? "read" : "write";
-}
-
 #endif
-- 
2.39.1

