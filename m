Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF60C64949E
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Dec 2022 15:13:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbiLKONR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Dec 2022 09:13:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiLKONP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Dec 2022 09:13:15 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92106B4AA
        for <linux-kernel@vger.kernel.org>; Sun, 11 Dec 2022 06:13:12 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B14931F381;
        Sun, 11 Dec 2022 14:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1670767990; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=sMsSMIXIBrOiC15T53uI5MCD1g0UEocKDW+9a+KXbzM=;
        b=tc0ePlnolVYxZkh9bMJ2MWYgB9ROBRWVj0gBfKkNAte7yZfBUAIjM7GvdW15vHJskvEAyw
        MFoD1p1k1+/VQUSOcxmdbFNhrj7X/dePB5OkVhuafbyvKEy89hbvpXsr+Kr0x2/qyfsvmD
        PNTnDtS/AIu1ZdgQhZIUWbkThugS/H4=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 743BF1376E;
        Sun, 11 Dec 2022 14:13:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 8Rp2G3bllWOdNAAAMHmgww
        (envelope-from <petr.pavlu@suse.com>); Sun, 11 Dec 2022 14:13:10 +0000
From:   Petr Pavlu <petr.pavlu@suse.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com
Cc:     nathan@kernel.org, ndesaulniers@google.com, trix@redhat.com,
        corbet@lwn.net, linux-kernel@vger.kernel.org,
        Petr Pavlu <petr.pavlu@suse.com>
Subject: [PATCH v3] x86: Avoid relocation information in final vmlinux
Date:   Sun, 11 Dec 2022 15:12:27 +0100
Message-Id: <20221211141227.7622-1-petr.pavlu@suse.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
kernel's own binrpm-pkg target.

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
---

Changes since v2 [1]:
- Ignore only the moved vmlinux.relocs, add it to .gitignore and
  Documentation/dontdiff.
- Clean up the patch description.

Changes since v1 [2]:
- Fix the command to remove relocations to work with llvm-objcopy too.

[1] https://lore.kernel.org/lkml/20220927084632.14531-1-petr.pavlu@suse.com/
[2] https://lore.kernel.org/lkml/20220913132911.6850-1-petr.pavlu@suse.com/

 .gitignore                          |  1 +
 Documentation/dontdiff              |  1 +
 arch/x86/Makefile.postlink          | 41 +++++++++++++++++++++++++++++
 arch/x86/boot/compressed/.gitignore |  1 -
 arch/x86/boot/compressed/Makefile   | 10 +++----
 5 files changed, 47 insertions(+), 7 deletions(-)
 create mode 100644 arch/x86/Makefile.postlink

diff --git a/.gitignore b/.gitignore
index 5da004814678..cb59d89372c0 100644
--- a/.gitignore
+++ b/.gitignore
@@ -61,6 +61,7 @@ modules.order
 /vmlinux
 /vmlinux.32
 /vmlinux.map
+/vmlinux.relocs
 /vmlinux.symvers
 /vmlinux-gdb.py
 /vmlinuz
diff --git a/Documentation/dontdiff b/Documentation/dontdiff
index 352ff53a2306..7c210744d84c 100644
--- a/Documentation/dontdiff
+++ b/Documentation/dontdiff
@@ -255,6 +255,7 @@ vmlinux.aout
 vmlinux.bin.all
 vmlinux.lds
 vmlinux.map
+vmlinux.relocs
 vmlinux.symvers
 vmlinuz
 voffset.h
diff --git a/arch/x86/Makefile.postlink b/arch/x86/Makefile.postlink
new file mode 100644
index 000000000000..b38ffa4defb3
--- /dev/null
+++ b/arch/x86/Makefile.postlink
@@ -0,0 +1,41 @@
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
+include scripts/Kbuild.include
+
+CMD_RELOCS = arch/x86/tools/relocs
+quiet_cmd_relocs = RELOCS  $@.relocs
+      cmd_relocs = $(CMD_RELOCS) $@ > $@.relocs;$(CMD_RELOCS) --abs-relocs $@
+
+quiet_cmd_strip_relocs = RSTRIP  $@
+      cmd_strip_relocs = $(OBJCOPY) --remove-section='.rel.*' --remove-section='.rel__*' --remove-section='.rela.*' --remove-section='.rela__*' $@
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
+	@rm -f vmlinux.relocs
+
+PHONY += FORCE clean
+
+FORCE:
+
+.PHONY: $(PHONY)
diff --git a/arch/x86/boot/compressed/.gitignore b/arch/x86/boot/compressed/.gitignore
index 25805199a506..b2968175fc27 100644
--- a/arch/x86/boot/compressed/.gitignore
+++ b/arch/x86/boot/compressed/.gitignore
@@ -1,7 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
 relocs
 vmlinux.bin.all
-vmlinux.relocs
 vmlinux.lds
 mkpiggy
 piggy.S
diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index 3a261abb6d15..75a467a408d2 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -121,14 +121,12 @@ $(obj)/vmlinux.bin: vmlinux FORCE
 
 targets += $(patsubst $(obj)/%,%,$(vmlinux-objs-y)) vmlinux.bin.all vmlinux.relocs
 
-CMD_RELOCS = arch/x86/tools/relocs
-quiet_cmd_relocs = RELOCS  $@
-      cmd_relocs = $(CMD_RELOCS) $< > $@;$(CMD_RELOCS) --abs-relocs $<
-$(obj)/vmlinux.relocs: vmlinux FORCE
-	$(call if_changed,relocs)
+# vmlinux.relocs is created by the vmlinux postlink step.
+vmlinux.relocs: vmlinux
+	@true
 
 vmlinux.bin.all-y := $(obj)/vmlinux.bin
-vmlinux.bin.all-$(CONFIG_X86_NEED_RELOCS) += $(obj)/vmlinux.relocs
+vmlinux.bin.all-$(CONFIG_X86_NEED_RELOCS) += vmlinux.relocs
 
 $(obj)/vmlinux.bin.gz: $(vmlinux.bin.all-y) FORCE
 	$(call if_changed,gzip)
-- 
2.35.3

