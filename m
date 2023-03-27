Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 163356CA09D
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 11:56:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232944AbjC0J4s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 05:56:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233104AbjC0Jys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 05:54:48 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40A635586
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 02:54:42 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E33C12206F;
        Mon, 27 Mar 2023 09:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1679910880; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=iiHsEfNhP1qqTbuNrc8gnQGQpdjgtMWj40lVX3bSGoc=;
        b=ZXa9Yvq10wzwOi69DJm8FTGBNME7XyMUXAPd2t0YbkpxVJetft33xidrjPUYLskmXDwD1n
        qbEfQREIca9w5DBoAcsmxWw+gEzEtp0U+UXyK4wpCyaN/UeG0jiyLabjohr6dDSuEzWiED
        R2eg/4ubGMeIw/W5o5jiL8XiyCV1s38=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A085F13482;
        Mon, 27 Mar 2023 09:54:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 71KTJeBnIWQicwAAMHmgww
        (envelope-from <petr.pavlu@suse.com>); Mon, 27 Mar 2023 09:54:40 +0000
From:   Petr Pavlu <petr.pavlu@suse.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com
Cc:     nathan@kernel.org, ndesaulniers@google.com, trix@redhat.com,
        linux-kernel@vger.kernel.org, Petr Pavlu <petr.pavlu@suse.com>
Subject: [PATCH v6] x86: Avoid relocation information in final vmlinux
Date:   Mon, 27 Mar 2023 11:54:06 +0200
Message-Id: <20230327095406.6895-1-petr.pavlu@suse.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
Tested-by: Nick Desaulniers <ndesaulniers@google.com>
---

Changes since v5 [1]:
- Put vmlinux.relocs back into arch/x86/boot/compressed.
- Wrap the long objcopy command line.

Changes since v4 [2]:
- Update the example target which is mentioned in the patch description
  to collect vmlinux from binrpm-pkg to tar-pkg, to reflect fc8c2d8ff206
  ("kbuild: Stop including vmlinux.bz2 in the rpm's").

Changes since v3 [3]:
- Update the Kbuild.include path in arch/x86/Makefile.postlink to work
  after 67d7c3023a67 ("kbuild: remove --include-dir MAKEFLAG from top
  Makefile").

Changes since v2 [4]:
- Ignore only the moved vmlinux.relocs, add it to .gitignore and
  Documentation/dontdiff.
- Clean up the patch description.

Changes since v1 [5]:
- Fix the command to remove relocations to work with llvm-objcopy too.

[1] https://lore.kernel.org/lkml/20230320121006.4863-1-petr.pavlu@suse.com/
[2] https://lore.kernel.org/lkml/20230227131829.26824-1-petr.pavlu@suse.com/
[3] https://lore.kernel.org/lkml/20221211141227.7622-1-petr.pavlu@suse.com/
[4] https://lore.kernel.org/lkml/20220927084632.14531-1-petr.pavlu@suse.com/
[5] https://lore.kernel.org/lkml/20220913132911.6850-1-petr.pavlu@suse.com/

 arch/x86/Makefile.postlink        | 47 +++++++++++++++++++++++++++++++
 arch/x86/boot/compressed/Makefile |  8 ++----
 2 files changed, 50 insertions(+), 5 deletions(-)
 create mode 100644 arch/x86/Makefile.postlink

diff --git a/arch/x86/Makefile.postlink b/arch/x86/Makefile.postlink
new file mode 100644
index 000000000000..936093d29160
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
index 6b6cfe607bdb..0f78dbbbdcdd 100644
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
-- 
2.35.3

