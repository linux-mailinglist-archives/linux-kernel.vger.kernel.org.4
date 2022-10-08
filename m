Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 966425F8742
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Oct 2022 21:59:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbiJHT7F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Oct 2022 15:59:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbiJHT7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Oct 2022 15:59:01 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 370DC386BA
        for <linux-kernel@vger.kernel.org>; Sat,  8 Oct 2022 12:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665259140; x=1696795140;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=TH3j0ychwAIj9g3vu6BahUMC3QxmsPBdyXjOTzzFp0E=;
  b=aU/FUhTxjCTCgVGgSxS4z1ZZ5XM4vNZh6OcV9u27ysnXFNVYrjLQCAwR
   QNNH+2S1d2r8ycc78eJH/nrGhGLre1H2H8yUFrYC2Bu6e5gdGkvD8Szva
   ds7ERTdng7jHs2A5VgixP6TcXemhXsnvEtw/pSBr2sWPjgWdLfHgSNSuc
   CP5xz6pxj5qU3W3jFaa0oRmcA7Nesbe/n+V4+a++RnERW99OBRNw0hnzg
   tkKduXM8CXOlZcXMWm7v9PUPDNGGjo6vf+ZUxWIKkMIzDJf7SX6yedKGY
   tUex7MuB4ht+aQ40+jpYKpJyqlUIssXENUDMXSML4nb+dwmFk92m5AL/H
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10494"; a="304995071"
X-IronPort-AV: E=Sophos;i="5.95,170,1661842800"; 
   d="scan'208";a="304995071"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2022 12:58:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10494"; a="714650225"
X-IronPort-AV: E=Sophos;i="5.95,170,1661842800"; 
   d="scan'208";a="714650225"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 08 Oct 2022 12:58:58 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id C077ED0; Sat,  8 Oct 2022 22:59:18 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] panic: Use str_enabled_disabled() helper
Date:   Sat,  8 Oct 2022 22:59:14 +0300
Message-Id: <20221008195914.54199-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use str_enabled_disabled() helper instead of open coding the same.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 kernel/panic.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/panic.c b/kernel/panic.c
index da323209f583..75fe389e8814 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -25,6 +25,7 @@
 #include <linux/kexec.h>
 #include <linux/panic_notifier.h>
 #include <linux/sched.h>
+#include <linux/string_helpers.h>
 #include <linux/sysrq.h>
 #include <linux/init.h>
 #include <linux/nmi.h>
@@ -744,8 +745,8 @@ static int __init panic_on_taint_setup(char *s)
 	if (s && !strcmp(s, "nousertaint"))
 		panic_on_taint_nousertaint = true;
 
-	pr_info("panic_on_taint: bitmask=0x%lx nousertaint_mode=%sabled\n",
-		panic_on_taint, panic_on_taint_nousertaint ? "en" : "dis");
+	pr_info("panic_on_taint: bitmask=0x%lx nousertaint_mode=%s\n",
+		panic_on_taint, str_enabled_disabled(panic_on_taint_nousertaint));
 
 	return 0;
 }
-- 
2.35.1

