Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E57663D4F5
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 12:50:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234088AbiK3LuS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 06:50:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233443AbiK3LuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 06:50:05 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40C3E3E0B9;
        Wed, 30 Nov 2022 03:50:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669809005; x=1701345005;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SU/NorHp8bte8kSzQBB60nH7d9fJQrjLciVnA/+O99s=;
  b=YcIG8rzeP0u04+Z/4OPAQP5wzeLtomFlYIJZ3NQ6sgdZ955/4seyi2Ij
   Ndt/BjFM9TofIve4d9Eqj4xT/+xEDbZjFsR5eUhtiaRDXOmH0cTZ+Fr4P
   pk0PiT0j0EyTAu3zwEnZ9VsApE/SKmT2bKlyRBg+VVncEVnTJ3AmCNNHR
   P8vNkFD8pBwplmdT7PEpgoHxCnfM7edw4ISonIQ4g/ArUn94sgyJ0l98k
   xZf3o73r4TXOosdNn10i9DmwSeLd2vuSLY80ER35EAes6atxqwujhAHrK
   houqioOTL7vb7tBNiM+mohqMPRIr1c5iriVIGDTsAFUtoFsugiz2PGFCn
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10546"; a="298748038"
X-IronPort-AV: E=Sophos;i="5.96,206,1665471600"; 
   d="scan'208";a="298748038"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2022 03:50:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10546"; a="732959311"
X-IronPort-AV: E=Sophos;i="5.96,206,1665471600"; 
   d="scan'208";a="732959311"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 30 Nov 2022 03:50:02 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id DF038184; Wed, 30 Nov 2022 13:50:29 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andy@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH v1 3/3] lib/string_helpers: Split out string_choices.h
Date:   Wed, 30 Nov 2022 13:50:22 +0200
Message-Id: <20221130115022.68956-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221130115022.68956-1-andriy.shevchenko@linux.intel.com>
References: <20221130115022.68956-1-andriy.shevchenko@linux.intel.com>
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

Some users may only need the string choice APIs. Split
the respective header, i.e. string_choices.h. Include
it in the string_helpers.h.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 MAINTAINERS                    |  1 +
 include/linux/string_choices.h | 37 ++++++++++++++++++++++++++++++++++
 include/linux/string_helpers.h | 31 +---------------------------
 3 files changed, 39 insertions(+), 30 deletions(-)
 create mode 100644 include/linux/string_choices.h

diff --git a/MAINTAINERS b/MAINTAINERS
index c1f0310dae18..b16c2488f05a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8722,6 +8722,7 @@ GENERIC STRING LIBRARY
 R:	Andy Shevchenko <andy@kernel.org>
 S:	Maintained
 F:	include/linux/string.h
+F:	include/linux/string_choices.h
 F:	include/linux/string_helpers.h
 F:	lib/string.c
 F:	lib/string_helpers.c
diff --git a/include/linux/string_choices.h b/include/linux/string_choices.h
new file mode 100644
index 000000000000..ff7e202808a9
--- /dev/null
+++ b/include/linux/string_choices.h
@@ -0,0 +1,37 @@
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
+static inline const char *str_high_low(bool v)
+{
+	return v ? "high" : "low";
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
index fd72393e7975..88fb8e1d0421 100644
--- a/include/linux/string_helpers.h
+++ b/include/linux/string_helpers.h
@@ -5,6 +5,7 @@
 #include <linux/bits.h>
 #include <linux/ctype.h>
 #include <linux/string.h>
+#include <linux/string_choices.h>
 #include <linux/types.h>
 
 struct device;
@@ -108,34 +109,4 @@ void kfree_strarray(char **array, size_t n);
 
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
-static inline const char *str_high_low(bool v)
-{
-	return v ? "high" : "low";
-}
-
-static inline const char *str_read_write(bool v)
-{
-	return v ? "read" : "write";
-}
-
 #endif
-- 
2.35.1

