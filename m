Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7635460AEED
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 17:22:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231732AbiJXPWO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 11:22:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231522AbiJXPVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 11:21:33 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1062DC06A6
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 07:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666620322; x=1698156322;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ILbdB+RzuchUOaY6BHrudvHVo6rj5y46FZuOl8iY9NA=;
  b=jZRJCgO2/AvAX49jgMEPCwtTPw3oSPO76bm84xi6V+feh3z6nSAfJgOY
   JflJvA1hJxEiSQPjM5HfA7u4iYLgyUc9yEuae5fuNT1dzUyy9SclMxSX9
   sUlyDjn9U7z/BcvehQJnTtWYzFMVNJRXZndj9dJtbloPS185c9k+VFcEq
   LmAZQd63u6x/f8KOYHz035bkqG3d/bpVVn04zplpZ80bYv9br8wITzOEr
   X8GyP/dX4Emx2Xo88FM124+vO4B6YMcmmu54fQ1HSN+sJRmbuXxjWoT++
   nq61RnUs14F21yLTxoaJvm80wiefVMz0+HckKJbD0K1UzpVAV3hS7xKiZ
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="309101790"
X-IronPort-AV: E=Sophos;i="5.95,209,1661842800"; 
   d="scan'208";a="309101790"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2022 06:24:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="806302275"
X-IronPort-AV: E=Sophos;i="5.95,209,1661842800"; 
   d="scan'208";a="806302275"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 24 Oct 2022 06:24:17 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 5139E6DA; Mon, 24 Oct 2022 16:24:39 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>
Subject: [rft, PATCH v1 4/4] kernel.h: Split out ARRAY_SZIE()
Date:   Mon, 24 Oct 2022 16:24:34 +0300
Message-Id: <20221024132434.47057-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221024132434.47057-1-andriy.shevchenko@linux.intel.com>
References: <20221024132434.47057-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kernel.h is being used as a dump for all kinds of stuff for a long time.
ARRAY_SIZE() is used in many drivers without need of the full kernel.h
dependency train with it.

Here is the attempt on cleaning it up by splitting out ARRAY_SIZE().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/array_size.h | 13 +++++++++++++
 include/linux/kernel.h     |  8 +-------
 2 files changed, 14 insertions(+), 7 deletions(-)
 create mode 100644 include/linux/array_size.h

diff --git a/include/linux/array_size.h b/include/linux/array_size.h
new file mode 100644
index 000000000000..c9cdba26555f
--- /dev/null
+++ b/include/linux/array_size.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_ARRAY_SIZE_H
+#define _LINUX_ARRAY_SIZE_H
+
+#include <linux/compiler.h>
+
+/**
+ * ARRAY_SIZE - get the number of elements in array @arr
+ * @arr: array to be sized
+ */
+#define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
+
+#endif	/* _LINUX_ARRAY_SIZE_H */
diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 7e9612de01b8..011eab2b0e93 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -17,7 +17,7 @@
 #include <linux/linkage.h>
 #include <linux/stddef.h>
 #include <linux/types.h>
-#include <linux/compiler.h>
+#include <linux/array_size.h>
 #include <linux/container_of.h>
 #include <linux/bitops.h>
 #include <linux/hex.h>
@@ -46,12 +46,6 @@
  */
 #define REPEAT_BYTE(x)	((~0ul / 0xff) * (x))
 
-/**
- * ARRAY_SIZE - get the number of elements in array @arr
- * @arr: array to be sized
- */
-#define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
-
 #define PTR_IF(cond, ptr)	((cond) ? (ptr) : NULL)
 
 #define u64_to_user_ptr(x) (		\
-- 
2.35.1

