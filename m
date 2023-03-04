Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8329F6AA7FB
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Mar 2023 05:20:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbjCDEUB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 23:20:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbjCDETu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 23:19:50 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9341A19F35
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 20:19:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677903589; x=1709439589;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pd8dhXsOYVnMcYaWLAlR4eqh0jn5NMv7qu4K0qUhvcU=;
  b=aOf30N78IrFHtDyfM5pc47f/xxt/8k5+pMAkRzRNTZqPGcIT2VDEAWCM
   Uapts8h2Y56sxaisn81A383aPNfKLGMSfNnKW/R31iVaE08J9nDPBJVWY
   3m5TjOsL83ixUEZEF1zkxR+i0XKanVeNvgTYRdfD3vlT78SNEDfgqPxyF
   FN+JG1WuFAK7GA7nUDHXzg1Jc2aS+hDOdBrWvW4O+FvUgu/fw7o4PftsN
   K43r0oAHLD6fsQ3Z0hbFnVRSVFSBHGUOMwUct3EK06SkPY0DR4K6AkBGx
   k7Mz+L3KTys6BrumqNTKMOaHdT7YJC1tpjxvTwcZmTm1WYBlGufbeToxq
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10638"; a="315618117"
X-IronPort-AV: E=Sophos;i="5.98,232,1673942400"; 
   d="scan'208";a="315618117"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2023 20:19:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10638"; a="708062015"
X-IronPort-AV: E=Sophos;i="5.98,232,1673942400"; 
   d="scan'208";a="708062015"
Received: from tdx-lm.sh.intel.com ([10.239.53.27])
  by orsmga001.jf.intel.com with ESMTP; 03 Mar 2023 20:19:45 -0800
From:   Wei Wang <wei.w.wang@intel.com>
To:     arnd@arndb.de, akpm@linux-foundation.org, keescook@chromium.org,
        herbert@gondor.apana.org.au, josh@joshtriplett.org,
        jani.nikula@intel.com, corbet@lwn.net, jgg@mellanox.com,
        dmatlack@google.com, mizhang@google.com, pbonzini@redhat.com,
        seanjc@google.com
Cc:     linux-kernel@vger.kernel.org, Wei Wang <wei.w.wang@intel.com>
Subject: [PATCH v1 3/3] bug: use bool for __ret_warn_on in WARN/WARN_ON
Date:   Sat,  4 Mar 2023 12:19:32 +0800
Message-Id: <20230304041932.847133-4-wei.w.wang@intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20230304041932.847133-1-wei.w.wang@intel.com>
References: <20230304041932.847133-1-wei.w.wang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

coding-style.rst documents below:
bool function return types and stack variables are always fine to use
whenever appropriate. Use of bool is encouraged to improve readability
and is often a better option than 'int' for storing boolean values.

__ret_warn_on is essentially used as boolean in WARN/WARN_ON, so change
its definition from 'int' to 'bool'.

Signed-off-by: Wei Wang <wei.w.wang@intel.com>
---
 include/asm-generic/bug.h | 12 ++++++------
 tools/include/asm/bug.h   | 10 +++++-----
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/include/asm-generic/bug.h b/include/asm-generic/bug.h
index 4050b191e1a9..3a316be73f0e 100644
--- a/include/asm-generic/bug.h
+++ b/include/asm-generic/bug.h
@@ -107,7 +107,7 @@ extern __printf(1, 2) void __warn_printk(const char *fmt, ...);
 		instrumentation_end();					\
 	} while (0)
 #define WARN_ON_ONCE(condition) ({				\
-	int __ret_warn_on = !!(condition);			\
+	bool __ret_warn_on = !!(condition);			\
 	if (unlikely(__ret_warn_on))				\
 		__WARN_FLAGS(BUGFLAG_ONCE |			\
 			     BUGFLAG_TAINT(TAINT_WARN));	\
@@ -119,7 +119,7 @@ extern __printf(1, 2) void __warn_printk(const char *fmt, ...);
 
 #ifndef WARN_ON
 #define WARN_ON(condition) ({						\
-	int __ret_warn_on = !!(condition);				\
+	bool __ret_warn_on = !!(condition);				\
 	if (unlikely(__ret_warn_on))					\
 		__WARN();						\
 	unlikely(__ret_warn_on);					\
@@ -128,7 +128,7 @@ extern __printf(1, 2) void __warn_printk(const char *fmt, ...);
 
 #ifndef WARN
 #define WARN(condition, format...) ({					\
-	int __ret_warn_on = !!(condition);				\
+	bool __ret_warn_on = !!(condition);				\
 	if (unlikely(__ret_warn_on))					\
 		__WARN_printf(TAINT_WARN, format);			\
 	unlikely(__ret_warn_on);					\
@@ -136,7 +136,7 @@ extern __printf(1, 2) void __warn_printk(const char *fmt, ...);
 #endif
 
 #define WARN_TAINT(condition, taint, format...) ({			\
-	int __ret_warn_on = !!(condition);				\
+	bool __ret_warn_on = !!(condition);				\
 	if (unlikely(__ret_warn_on))					\
 		__WARN_printf(taint, format);				\
 	unlikely(__ret_warn_on);					\
@@ -164,14 +164,14 @@ extern __printf(1, 2) void __warn_printk(const char *fmt, ...);
 
 #ifndef HAVE_ARCH_WARN_ON
 #define WARN_ON(condition) ({						\
-	int __ret_warn_on = !!(condition);				\
+	bool __ret_warn_on = !!(condition);				\
 	unlikely(__ret_warn_on);					\
 })
 #endif
 
 #ifndef WARN
 #define WARN(condition, format...) ({					\
-	int __ret_warn_on = !!(condition);				\
+	bool __ret_warn_on = !!(condition);				\
 	no_printk(format);						\
 	unlikely(__ret_warn_on);					\
 })
diff --git a/tools/include/asm/bug.h b/tools/include/asm/bug.h
index 550223f0a6e6..c1f72071303b 100644
--- a/tools/include/asm/bug.h
+++ b/tools/include/asm/bug.h
@@ -8,14 +8,14 @@
 #define __WARN_printf(arg...)	do { fprintf(stderr, arg); } while (0)
 
 #define WARN(condition, format...) ({		\
-	int __ret_warn_on = !!(condition);	\
+	bool __ret_warn_on = !!(condition);	\
 	if (unlikely(__ret_warn_on))		\
 		__WARN_printf(format);		\
 	unlikely(__ret_warn_on);		\
 })
 
 #define WARN_ON(condition) ({					\
-	int __ret_warn_on = !!(condition);			\
+	bool __ret_warn_on = !!(condition);			\
 	if (unlikely(__ret_warn_on))				\
 		__WARN_printf("assertion failed at %s:%d\n",	\
 				__FILE__, __LINE__);		\
@@ -23,8 +23,8 @@
 })
 
 #define WARN_ON_ONCE(condition) ({			\
-	static int __warned;				\
-	int __ret_warn_once = !!(condition);		\
+	static bool __warned;				\
+	bool __ret_warn_once = !!(condition);		\
 							\
 	if (unlikely(__ret_warn_once && !__warned)) {	\
 		__warned = true;			\
@@ -35,7 +35,7 @@
 
 #define WARN_ONCE(condition, format...)	({	\
 	static int __warned;			\
-	int __ret_warn_once = !!(condition);	\
+	bool __ret_warn_once = !!(condition);	\
 						\
 	if (unlikely(__ret_warn_once))		\
 		if (WARN(!__warned, format)) 	\
-- 
2.27.0

