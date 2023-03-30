Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4292D6D081D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 16:23:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232388AbjC3OXs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 10:23:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232396AbjC3OXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 10:23:46 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA23AC15E;
        Thu, 30 Mar 2023 07:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680186204; x=1711722204;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=FY8IX9SAO9iBATQiPxyU6DgWIpMVyTKKJh0RUHkpsWM=;
  b=WhgQCXRYLbTUJZDSqUg9snjCL6hHVMUVy2hk0Tj6nZrjWYCAbAwBlNjq
   2qEVJpuRmRbHe2qoRrALgm78RNQNtFq5EjjBuNyBz3kublCsfAsOOyW1t
   KXRq2c5UvPIl8jgQ2AM/3oER3n6iZQdqIWrrPNzAUhZ4XzRMTx/ddZ+X5
   NgHusZS4qlE2fVXEBrpReApcebwc/6ScIYK3Vr+9n2JjvPhkH3ppU2fc3
   W6Jmjq5qTwRR/kBN/Tqgi+SJtEvlHy+plO3Pc1Qw5zkPx5r1V8f4f9LrD
   9WTiHVLD2khO4SXUEVFZoHGgaONXrwWO38Q3PYSjk70wzxAnL8HJvJZiL
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10665"; a="406169619"
X-IronPort-AV: E=Sophos;i="5.98,303,1673942400"; 
   d="scan'208";a="406169619"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2023 07:19:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10665"; a="634927548"
X-IronPort-AV: E=Sophos;i="5.98,303,1673942400"; 
   d="scan'208";a="634927548"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 30 Mar 2023 07:19:13 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 8C97213A; Thu, 30 Mar 2023 17:15:37 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Olliver Schinagl <oliver@schinagl.nl>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>
Subject: [PATCH v1 1/2] iopoll: Introduce ioreadXX_poll_timeout() macros
Date:   Thu, 30 Mar 2023 17:14:12 +0300
Message-Id: <20230330141413.25569-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Olliver Schinagl <oliver@schinagl.nl>

There are users in the Linux kernel that would benefit from using
ioreadXX_poll_timeout() macros, such as ioread32_poll_timeout().
Introduce those macros.

Signed-off-by: Olliver Schinagl <oliver@schinagl.nl>
Co-developed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/iopoll.h | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/include/linux/iopoll.h b/include/linux/iopoll.h
index 2c8860e406bd..30ba609175a7 100644
--- a/include/linux/iopoll.h
+++ b/include/linux/iopoll.h
@@ -140,6 +140,7 @@
 #define readx_poll_timeout_atomic(op, addr, val, cond, delay_us, timeout_us) \
 	read_poll_timeout_atomic(op, val, cond, delay_us, timeout_us, false, addr)
 
+/* readX() */
 #define readb_poll_timeout(addr, val, cond, delay_us, timeout_us) \
 	readx_poll_timeout(readb, addr, val, cond, delay_us, timeout_us)
 
@@ -164,6 +165,7 @@
 #define readq_poll_timeout_atomic(addr, val, cond, delay_us, timeout_us) \
 	readx_poll_timeout_atomic(readq, addr, val, cond, delay_us, timeout_us)
 
+/* readX_relaxed() */
 #define readb_relaxed_poll_timeout(addr, val, cond, delay_us, timeout_us) \
 	readx_poll_timeout(readb_relaxed, addr, val, cond, delay_us, timeout_us)
 
@@ -188,4 +190,29 @@
 #define readq_relaxed_poll_timeout_atomic(addr, val, cond, delay_us, timeout_us) \
 	readx_poll_timeout_atomic(readq_relaxed, addr, val, cond, delay_us, timeout_us)
 
+/* ioreadXX() */
+#define ioread8_poll_timeout(addr, val, cond, delay_us, timeout_us) \
+	readx_poll_timeout(ioread8, addr, val, cond, delay_us, timeout_us)
+
+#define ioread8_poll_timeout_atomic(addr, val, cond, delay_us, timeout_us) \
+	readx_poll_timeout_atomic(ioread8, addr, val, cond, delay_us, timeout_us)
+
+#define ioread16_poll_timeout(addr, val, cond, delay_us, timeout_us) \
+	readx_poll_timeout(ioread16, addr, val, cond, delay_us, timeout_us)
+
+#define ioread16_poll_timeout_atomic(addr, val, cond, delay_us, timeout_us) \
+	readx_poll_timeout_atomic(ioread16, addr, val, cond, delay_us, timeout_us)
+
+#define ioread32_poll_timeout(addr, val, cond, delay_us, timeout_us) \
+	readx_poll_timeout(ioread32, addr, val, cond, delay_us, timeout_us)
+
+#define ioread32_poll_timeout_atomic(addr, val, cond, delay_us, timeout_us) \
+	readx_poll_timeout_atomic(ioread32, addr, val, cond, delay_us, timeout_us)
+
+#define ioread64_poll_timeout(addr, val, cond, delay_us, timeout_us) \
+	readx_poll_timeout(ioread64, addr, val, cond, delay_us, timeout_us)
+
+#define ioread64_poll_timeout_atomic(addr, val, cond, delay_us, timeout_us) \
+	readx_poll_timeout_atomic(ioread64, addr, val, cond, delay_us, timeout_us)
+
 #endif /* _LINUX_IOPOLL_H */
-- 
2.40.0.1.gaa8946217a0b

