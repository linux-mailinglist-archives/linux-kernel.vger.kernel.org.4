Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D957860C5E1
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 09:53:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232097AbiJYHxq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 03:53:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232023AbiJYHx3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 03:53:29 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F62716727E;
        Tue, 25 Oct 2022 00:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666684408; x=1698220408;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RWPxjqUEW0aVK9VcmeBXN4qxzRy3SWUCRQUYmPXVmfw=;
  b=j/39rM8Lq6palViebwh9hCDzkO47bng4aZFmNqhFJFb0h0jFkFV1JINp
   qqgRBxCrJHycExOf87HDgbJGBQZtLWaahjM4VvNAAOqdhDO1fH8Ljp8YN
   C/JC6Vlkro5OkTjCeKO5rpOrh4uhkayzLNcfsnbEaBZcdo8kL0dudzdvJ
   habO6MuTANx4Kw9znJqCFoRoRZbJ6zRnAhaMHxzhF/TBVQxffS3YU7NtX
   V7/x6s4Lz3h2neS5Y4MNWpqLXWs7535oeuVcPisxIPenUZzDUwP1UyMRR
   HUfgjbZD7EVv+OPArqkicjA6VwYuvYOCsCTdD1wUazKB3E/ow7oXdLeTq
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="290916774"
X-IronPort-AV: E=Sophos;i="5.95,211,1661842800"; 
   d="scan'208";a="290916774"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2022 00:53:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="736725630"
X-IronPort-AV: E=Sophos;i="5.95,211,1661842800"; 
   d="scan'208";a="736725630"
Received: from unknown (HELO fred..) ([172.25.112.68])
  by fmsmga002.fm.intel.com with ESMTP; 25 Oct 2022 00:53:26 -0700
From:   Xin Li <xin3.li@intel.com>
To:     linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        linux-kbuild@vger.kernel.org, x86@kernel.org
Cc:     nathan@kernel.org, keescook@chromium.org,
        andrew.cooper3@citrix.com, hpa@zytor.com, peterz@infradead.org
Subject: [PATCH v2 1/1] kbuild: upgrade the orphan section warning to an error if CONFIG_WERROR is set
Date:   Tue, 25 Oct 2022 00:30:23 -0700
Message-Id: <20221025073023.16137-2-xin3.li@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221025073023.16137-1-xin3.li@intel.com>
References: <20221025073023.16137-1-xin3.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Cooper suggested upgrading the orphan section warning to a hard link
error. However Nathan Chancellor said outright turning the warning into an
error with no escape hatch might be too aggressive, as we have had these
warnings triggered by new compiler generated sections, and suggested turning
orphan sections into an error only if CONFIG_WERROR is set. Kees Cook echoed
and emphasized that the mandate from Linus is that we should avoid breaking
builds. It wrecks bisection, it causes problems across compiler versions, etc.

Thus upgrade the orphan section warning to a hard link error only if
CONFIG_WERROR is set.

Suggested-by: Andrew Cooper <andrew.cooper3@citrix.com>
Suggested-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Xin Li <xin3.li@intel.com>
Reviewed-by: Nathan Chancellor <nathan@kernel.org>
Tested-by: Nathan Chancellor <nathan@kernel.org>
---
Change since v1:
* Introduce a new Kconfig item CONFIG_LD_ORPHAN_WARN_LEVEL to replace
  (if $(CONFIG_WERROR),error,warn) (Nathan Chancellor).
---
 Makefile                          |  2 +-
 arch/arm/boot/compressed/Makefile |  2 +-
 arch/arm64/kernel/vdso/Makefile   |  2 +-
 arch/arm64/kernel/vdso32/Makefile |  2 +-
 arch/x86/boot/compressed/Makefile |  2 +-
 init/Kconfig                      | 15 ++++++++++++---
 6 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/Makefile b/Makefile
index d148a55bfd0f..7c00bb1d562b 100644
--- a/Makefile
+++ b/Makefile
@@ -1118,7 +1118,7 @@ endif
 # We never want expected sections to be placed heuristically by the
 # linker. All sections should be explicitly named in the linker script.
 ifdef CONFIG_LD_ORPHAN_WARN
-LDFLAGS_vmlinux += --orphan-handling=warn
+LDFLAGS_vmlinux += --orphan-handling=$(CONFIG_LD_ORPHAN_WARN_LEVEL)
 endif
 
 # Align the bit size of userspace programs with the kernel
diff --git a/arch/arm/boot/compressed/Makefile b/arch/arm/boot/compressed/Makefile
index 41bcbb460fac..53cadc3aaff1 100644
--- a/arch/arm/boot/compressed/Makefile
+++ b/arch/arm/boot/compressed/Makefile
@@ -123,7 +123,7 @@ LDFLAGS_vmlinux += --no-undefined
 LDFLAGS_vmlinux += -X
 # Report orphan sections
 ifdef CONFIG_LD_ORPHAN_WARN
-LDFLAGS_vmlinux += --orphan-handling=warn
+LDFLAGS_vmlinux += --orphan-handling=$(CONFIG_LD_ORPHAN_WARN_LEVEL)
 endif
 # Next argument is a linker script
 LDFLAGS_vmlinux += -T
diff --git a/arch/arm64/kernel/vdso/Makefile b/arch/arm64/kernel/vdso/Makefile
index 619e2dc7ee14..beaf9586338f 100644
--- a/arch/arm64/kernel/vdso/Makefile
+++ b/arch/arm64/kernel/vdso/Makefile
@@ -27,7 +27,7 @@ ldflags-y := -shared -soname=linux-vdso.so.1 --hash-style=sysv	\
 	     -Bsymbolic --build-id=sha1 -n $(btildflags-y)
 
 ifdef CONFIG_LD_ORPHAN_WARN
-  ldflags-y += --orphan-handling=warn
+  ldflags-y += --orphan-handling=$(CONFIG_LD_ORPHAN_WARN_LEVEL)
 endif
 
 ldflags-y += -T
diff --git a/arch/arm64/kernel/vdso32/Makefile b/arch/arm64/kernel/vdso32/Makefile
index 36c8f66cad25..f59bd1a4ead6 100644
--- a/arch/arm64/kernel/vdso32/Makefile
+++ b/arch/arm64/kernel/vdso32/Makefile
@@ -104,7 +104,7 @@ VDSO_AFLAGS += -D__ASSEMBLY__
 VDSO_LDFLAGS += -Bsymbolic --no-undefined -soname=linux-vdso.so.1
 VDSO_LDFLAGS += -z max-page-size=4096 -z common-page-size=4096
 VDSO_LDFLAGS += -shared --hash-style=sysv --build-id=sha1
-VDSO_LDFLAGS += --orphan-handling=warn
+VDSO_LDFLAGS += --orphan-handling=$(CONFIG_LD_ORPHAN_WARN_LEVEL)
 
 
 # Borrow vdsomunge.c from the arm vDSO
diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index 3a261abb6d15..66b8a8cb5a0f 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -68,7 +68,7 @@ KBUILD_LDFLAGS += $(call ld-option,--no-ld-generated-unwind-info)
 # address by the bootloader.
 LDFLAGS_vmlinux := -pie $(call ld-option, --no-dynamic-linker)
 ifdef CONFIG_LD_ORPHAN_WARN
-LDFLAGS_vmlinux += --orphan-handling=warn
+LDFLAGS_vmlinux += --orphan-handling=$(CONFIG_LD_ORPHAN_WARN_LEVEL)
 endif
 LDFLAGS_vmlinux += -z noexecstack
 ifeq ($(CONFIG_LD_IS_BFD),y)
diff --git a/init/Kconfig b/init/Kconfig
index abf65098f1b6..b416594d5689 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -159,10 +159,12 @@ config WERROR
 	help
 	  A kernel build should not cause any compiler warnings, and this
 	  enables the '-Werror' (for C) and '-Dwarnings' (for Rust) flags
-	  to enforce that rule by default.
+	  to enforce that rule by default. Certain warnings from other tools
+	  such as the linker may be upgraded to errors with this option as
+	  well.
 
-	  However, if you have a new (or very old) compiler with odd and
-	  unusual warnings, or you have some architecture with problems,
+	  However, if you have a new (or very old) compiler or linker with odd
+	  and unusual warnings, or you have some architecture with problems,
 	  you may need to disable this config option in order to
 	  successfully build the kernel.
 
@@ -1454,6 +1456,13 @@ config LD_ORPHAN_WARN
 	def_bool y
 	depends on ARCH_WANT_LD_ORPHAN_WARN
 	depends on $(ld-option,--orphan-handling=warn)
+	depends on $(ld-option,--orphan-handling=error)
+
+config LD_ORPHAN_WARN_LEVEL
+        string
+        depends on LD_ORPHAN_WARN
+        default "error" if WERROR
+        default "warn"
 
 config SYSCTL
 	bool
-- 
2.34.1

