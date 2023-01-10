Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E08116638EF
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 06:57:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231131AbjAJF51 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 00:57:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231639AbjAJF4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 00:56:08 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C41644352
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 21:55:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673330141; x=1704866141;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=1w4ypkqHrSsKN+f9gXoNWqz9PeGgeztfz3He0u8lGw4=;
  b=fPIZO7BNWHOgA1tguA7A3NJkR0gOfsRgsTMXU4T0GIS8ii233anICiTp
   LWl83ZIFOnsswJAfrPSs4K8Qv2Q5K6b7L6LORAbCbGN4bpzTCeWSvgDVx
   fQKBs8AzeKhje8CMQs1uFgvRkCABjElmi7Z8MPEeyhHEtyX0lHCLIGiNq
   1Lo2j+m8idhzoL1EUCsokTdEGWkq8DUhhMgf6IQSMfd3Ur8mKPfEUmRhX
   cURyDAarZpCkjniaB5z5VWX6w+F8XfkYE34SkLqJopftnbqj3MI0QwdCO
   Kc0DqWb5MPjimnFhnudNeLWn4OMHHJdXTCiKWFomlYiegE4jfh6MNClSn
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10585"; a="350289957"
X-IronPort-AV: E=Sophos;i="5.96,314,1665471600"; 
   d="scan'208";a="350289957"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2023 21:55:39 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10585"; a="634483736"
X-IronPort-AV: E=Sophos;i="5.96,314,1665471600"; 
   d="scan'208";a="634483736"
Received: from oux.sc.intel.com ([10.3.52.57])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2023 21:55:39 -0800
From:   Yian Chen <yian.chen@intel.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ravi Shankar <ravi.v.shankar@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        Paul Lai <paul.c.lai@intel.com>,
        Yian Chen <yian.chen@intel.com>
Subject: [PATCH 2/7] x86: Add CONFIG option X86_LASS
Date:   Mon,  9 Jan 2023 21:51:59 -0800
Message-Id: <20230110055204.3227669-3-yian.chen@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230110055204.3227669-1-yian.chen@intel.com>
References: <20230110055204.3227669-1-yian.chen@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LASS is an Intel x86-64 only feature. Add CONFIG
option X86_LASS and flag DISABLE_LASS to choose
opt-in/out the feature from kernel binary.

CONFIG_X86_LASS is enabled by default because it
is a security feature which should have little
to no overhead or side effects. If any issues are
found with specific use cases, the CONFIG option
makes it easy to disable.

Signed-off-by: Yian Chen <yian.chen@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/Kconfig                               | 10 ++++++++++
 arch/x86/include/asm/disabled-features.h       |  8 +++++++-
 tools/arch/x86/include/asm/disabled-features.h |  8 +++++++-
 3 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 3604074a878b..38b1497afd75 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1826,6 +1826,16 @@ config ARCH_USES_PG_UNCACHED
 	def_bool y
 	depends on X86_PAT
 
+config X86_LASS
+	def_bool y
+	prompt "Linear Address Space Separation"
+	depends on X86_64 && CPU_SUP_INTEL
+	help
+	  Linear Address Space Separation (LASS) is a processor
+	  feature that mitigates address space layout probes.
+
+	  if unsure, say Y.
+
 config X86_UMIP
 	def_bool y
 	prompt "User Mode Instruction Prevention" if EXPERT
diff --git a/arch/x86/include/asm/disabled-features.h b/arch/x86/include/asm/disabled-features.h
index c44b56f7ffba..0cad37d59e0f 100644
--- a/arch/x86/include/asm/disabled-features.h
+++ b/arch/x86/include/asm/disabled-features.h
@@ -16,6 +16,12 @@
 # define DISABLE_UMIP	(1<<(X86_FEATURE_UMIP & 31))
 #endif
 
+#ifdef CONFIG_X86_LASS
+# define DISABLE_LASS	0
+#else
+# define DISABLE_LASS	(1<<(X86_FEATURE_LASS & 31))
+#endif
+
 #ifdef CONFIG_X86_64
 # define DISABLE_VME		(1<<(X86_FEATURE_VME & 31))
 # define DISABLE_K6_MTRR	(1<<(X86_FEATURE_K6_MTRR & 31))
@@ -115,7 +121,7 @@
 #define DISABLED_MASK10	0
 #define DISABLED_MASK11	(DISABLE_RETPOLINE|DISABLE_RETHUNK|DISABLE_UNRET| \
 			 DISABLE_CALL_DEPTH_TRACKING)
-#define DISABLED_MASK12	0
+#define DISABLED_MASK12	(DISABLE_LASS)
 #define DISABLED_MASK13	0
 #define DISABLED_MASK14	0
 #define DISABLED_MASK15	0
diff --git a/tools/arch/x86/include/asm/disabled-features.h b/tools/arch/x86/include/asm/disabled-features.h
index c44b56f7ffba..0cad37d59e0f 100644
--- a/tools/arch/x86/include/asm/disabled-features.h
+++ b/tools/arch/x86/include/asm/disabled-features.h
@@ -16,6 +16,12 @@
 # define DISABLE_UMIP	(1<<(X86_FEATURE_UMIP & 31))
 #endif
 
+#ifdef CONFIG_X86_LASS
+# define DISABLE_LASS	0
+#else
+# define DISABLE_LASS	(1<<(X86_FEATURE_LASS & 31))
+#endif
+
 #ifdef CONFIG_X86_64
 # define DISABLE_VME		(1<<(X86_FEATURE_VME & 31))
 # define DISABLE_K6_MTRR	(1<<(X86_FEATURE_K6_MTRR & 31))
@@ -115,7 +121,7 @@
 #define DISABLED_MASK10	0
 #define DISABLED_MASK11	(DISABLE_RETPOLINE|DISABLE_RETHUNK|DISABLE_UNRET| \
 			 DISABLE_CALL_DEPTH_TRACKING)
-#define DISABLED_MASK12	0
+#define DISABLED_MASK12	(DISABLE_LASS)
 #define DISABLED_MASK13	0
 #define DISABLED_MASK14	0
 #define DISABLED_MASK15	0
-- 
2.34.1

