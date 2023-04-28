Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B4006F14E9
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 12:02:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345857AbjD1KCh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 06:02:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346049AbjD1KCP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 06:02:15 -0400
Received: from out0-212.mail.aliyun.com (out0-212.mail.aliyun.com [140.205.0.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60E9B5FEA
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 03:02:04 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R981e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047213;MF=houwenlong.hwl@antgroup.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---.STCEPrW_1682675622;
Received: from localhost(mailfrom:houwenlong.hwl@antgroup.com fp:SMTPD_---.STCEPrW_1682675622)
          by smtp.aliyun-inc.com;
          Fri, 28 Apr 2023 17:53:43 +0800
From:   "Hou Wenlong" <houwenlong.hwl@antgroup.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Thomas Garnier" <thgarnie@chromium.org>,
        "Lai Jiangshan" <jiangshan.ljs@antgroup.com>,
        "Kees Cook" <keescook@chromium.org>,
        "Hou Wenlong" <houwenlong.hwl@antgroup.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        "Dave Hansen" <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH RFC 35/43] x86/pie: Build the kernel as PIE
Date:   Fri, 28 Apr 2023 17:51:15 +0800
Message-Id: <bb082963f83e7b273d2e2044deffd76f38a1d92e.1682673543.git.houwenlong.hwl@antgroup.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1682673542.git.houwenlong.hwl@antgroup.com>
References: <cover.1682673542.git.houwenlong.hwl@antgroup.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel is currently build with mcmode=kernel option which forces it
to stay on the top 2G of the virtual address space. For PIE, use -fPIE
option to build the kernel as a Position Independent Executable (PIE),
which uses RIP-relative addressing and could be able to move below the
top 2G.

The --emit-relocs linker option was kept instead of using -pie to limit
the impact on mapped sections. Any incompatible relocation will be catch
by the objtool at compile time.

Suggested-by: Lai Jiangshan <jiangshan.ljs@antgroup.com>
Signed-off-by: Hou Wenlong <houwenlong.hwl@antgroup.com>
Cc: Thomas Garnier <thgarnie@chromium.org>
Cc: Kees Cook <keescook@chromium.org>
---
 arch/x86/Kconfig  | 8 ++++++--
 arch/x86/Makefile | 9 +++++++--
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 5ac5f335855e..9f8020991184 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2222,10 +2222,14 @@ config RELOCATABLE
 	  (CONFIG_PHYSICAL_START) is used as the minimum location.
 
 config X86_PIE
-	def_bool n
-	depends on X86_64
+	bool "Build a PIE kernel"
+	default n
+	depends on X86_64 && !XEN
 	select OBJTOOL if HAVE_OBJTOOL
 	select DYNAMIC_FTRACE if FUNCTION_TRACER && RETPOLINE
+	help
+	  This builds a PIE kernel image that could be put at any
+	  virtual address.
 
 config RANDOMIZE_BASE
 	bool "Randomize the address of the kernel image (KASLR)"
diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 81500011396d..6631974e2003 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -160,10 +160,15 @@ else
         KBUILD_CFLAGS += -mno-red-zone
 
 ifdef CONFIG_X86_PIE
-        PIE_CFLAGS := -include $(srctree)/include/linux/hidden.h
+        PIE_CFLAGS := -fPIE -include $(srctree)/include/linux/hidden.h
         KBUILD_CFLAGS += $(PIE_CFLAGS)
-endif
+        # Relax relocation in both CFLAGS and LDFLAGS to support older compilers
+        KBUILD_CFLAGS += $(call cc-option,-Wa$(comma)-mrelax-relocations=no)
+        LDFLAGS_vmlinux += $(call ld-option,--no-relax)
+        KBUILD_LDFLAGS_MODULE += $(call ld-option,--no-relax)
+else
         KBUILD_CFLAGS += -mcmodel=kernel
+endif
         KBUILD_RUSTFLAGS += -Cno-redzone=y
         KBUILD_RUSTFLAGS += -Ccode-model=kernel
 
-- 
2.31.1

