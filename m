Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 844CC730786
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 20:43:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233152AbjFNSm6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 14:42:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235103AbjFNSmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 14:42:53 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A357D1BEC;
        Wed, 14 Jun 2023 11:42:51 -0700 (PDT)
Date:   Wed, 14 Jun 2023 18:42:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686768170;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=S12bjusbzZwPYFboksUHkPk1TprVMLPd+OX6SytDRkA=;
        b=2tGI5YkpLcHel75sR9lbWFlr8DCyWREGx8jGZRAxeIbrIjDJDkamqzmRWm61dAgsftlYkF
        KA4batutX12rfWiZUE8H4zOnbKhOA5MMczTEaudFSlHatoW8nlklf4djLMV3N7dfQhHkFP
        Ogel6rOmN42A+/6nxFORM7FgmtGo5WW9IJV6X1JTV5Knen3fxfn25jWXlvYviNmMu2P2n4
        v8mfwYDt0ES8n+9nKesmAApddIIYr9FP60CzrhWJhTVLRENCW5ZyRVZgFMI4kWjBhDHZP7
        qQErYU020Lk7rPJ8AN4fVjopJODNBmbcsUNAwaAzOmcRmsTWAAJiJyt2mkSyVQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686768170;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=S12bjusbzZwPYFboksUHkPk1TprVMLPd+OX6SytDRkA=;
        b=ETrv5BO+CCr0lNxEPwzSSUOG2oKsPp3jFZxtioDSPQS199Xc/Wss3WgsEsgrMoEulVLhx6
        4V37zxeZ2h3Rl6Cw==
From:   "tip-bot2 for Petr Pavlu" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/build] x86/build: Avoid relocation information in final vmlinux
Cc:     Petr Pavlu <petr.pavlu@suse.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        Nick Desaulniers <ndesaulniers@google.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220927084632.14531-1-petr.pavlu@suse.com>
References: <20220927084632.14531-1-petr.pavlu@suse.com>
MIME-Version: 1.0
Message-ID: <168676816939.404.11506682535615735950.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/build branch of tip:

Commit-ID:     9d9173e9ceb63660ccad80f41373fd7eb48ff4ac
Gitweb:        https://git.kernel.org/tip/9d9173e9ceb63660ccad80f41373fd7eb48ff4ac
Author:        Petr Pavlu <petr.pavlu@suse.com>
AuthorDate:    Mon, 27 Mar 2023 11:54:06 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 14 Jun 2023 19:54:40 +02:00

x86/build: Avoid relocation information in final vmlinux

The Linux build process on x86 roughly consists of compiling all input
files, statically linking them into a vmlinux ELF file, and then taking
and turning this file into an actual bzImage bootable file.

vmlinux has in this process two main purposes:
1) It is an intermediate build target on the way to produce the final
   bootable image.
2) It is a file that is expected to be used by debuggers and standard
   ELF tooling to work with the built kernel.

For the second purpose, a vmlinux file is typically collected by various
package build recipes, such as distribution spec files, including the
kernel's own tar-pkg target.

When building a kernel supporting KASLR with CONFIG_X86_NEED_RELOCS,
vmlinux contains also relocation information produced by using the
--emit-relocs linker option. This is utilized by subsequent build steps
to create vmlinux.relocs and produce a relocatable image. However, the
information is not needed by debuggers and other standard ELF tooling.

The issue is then that the collected vmlinux file and hence distribution
packages end up unnecessarily large because of this extra data. The
following is a size comparison of vmlinux v6.0 with and without the
relocation information:

  | Configuration      | With relocs | Stripped relocs |
  | x86_64_defconfig   |       70 MB |           43 MB |
  | +CONFIG_DEBUG_INFO |      818 MB |          367 MB |

Optimize a resulting vmlinux by adding a postlink step that splits the
relocation information into vmlinux.relocs and then strips it from the
vmlinux binary.

Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Tested-by: Nick Desaulniers <ndesaulniers@google.com>
Link: https://lore.kernel.org/r/20220927084632.14531-1-petr.pavlu@suse.com
---
 arch/x86/Makefile.postlink        | 47 ++++++++++++++++++++++++++++++-
 arch/x86/boot/compressed/Makefile |  8 +----
 2 files changed, 50 insertions(+), 5 deletions(-)
 create mode 100644 arch/x86/Makefile.postlink

diff --git a/arch/x86/Makefile.postlink b/arch/x86/Makefile.postlink
new file mode 100644
index 0000000..936093d
--- /dev/null
+++ b/arch/x86/Makefile.postlink
@@ -0,0 +1,47 @@
+# SPDX-License-Identifier: GPL-2.0
+# ===========================================================================
+# Post-link x86 pass
+# ===========================================================================
+#
+# 1. Separate relocations from vmlinux into vmlinux.relocs.
+# 2. Strip relocations from vmlinux.
+
+PHONY := __archpost
+__archpost:
+
+-include include/config/auto.conf
+include $(srctree)/scripts/Kbuild.include
+
+CMD_RELOCS = arch/x86/tools/relocs
+OUT_RELOCS = arch/x86/boot/compressed
+quiet_cmd_relocs = RELOCS  $(OUT_RELOCS)/$@.relocs
+      cmd_relocs = \
+	mkdir -p $(OUT_RELOCS); \
+	$(CMD_RELOCS) $@ > $(OUT_RELOCS)/$@.relocs; \
+	$(CMD_RELOCS) --abs-relocs $@
+
+quiet_cmd_strip_relocs = RSTRIP  $@
+      cmd_strip_relocs = \
+	$(OBJCOPY) --remove-section='.rel.*' --remove-section='.rel__*' \
+		   --remove-section='.rela.*' --remove-section='.rela__*' $@
+
+# `@true` prevents complaint when there is nothing to be done
+
+vmlinux: FORCE
+	@true
+ifeq ($(CONFIG_X86_NEED_RELOCS),y)
+	$(call cmd,relocs)
+	$(call cmd,strip_relocs)
+endif
+
+%.ko: FORCE
+	@true
+
+clean:
+	@rm -f $(OUT_RELOCS)/vmlinux.relocs
+
+PHONY += FORCE clean
+
+FORCE:
+
+.PHONY: $(PHONY)
diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index 6b6cfe6..0f78dbb 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -121,11 +121,9 @@ $(obj)/vmlinux.bin: vmlinux FORCE
 
 targets += $(patsubst $(obj)/%,%,$(vmlinux-objs-y)) vmlinux.bin.all vmlinux.relocs
 
-CMD_RELOCS = arch/x86/tools/relocs
-quiet_cmd_relocs = RELOCS  $@
-      cmd_relocs = $(CMD_RELOCS) $< > $@;$(CMD_RELOCS) --abs-relocs $<
-$(obj)/vmlinux.relocs: vmlinux FORCE
-	$(call if_changed,relocs)
+# vmlinux.relocs is created by the vmlinux postlink step.
+$(obj)/vmlinux.relocs: vmlinux
+	@true
 
 vmlinux.bin.all-y := $(obj)/vmlinux.bin
 vmlinux.bin.all-$(CONFIG_X86_NEED_RELOCS) += $(obj)/vmlinux.relocs
