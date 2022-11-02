Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29241615F5D
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 10:15:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231356AbiKBJPx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 05:15:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231392AbiKBJO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 05:14:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A6A727FF4;
        Wed,  2 Nov 2022 02:13:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AB4C76183D;
        Wed,  2 Nov 2022 09:13:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A270C433D6;
        Wed,  2 Nov 2022 09:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667380407;
        bh=qV1mccLmHgXBC52kRBp51ztt9XoIScITKFyDIhvm/Os=;
        h=From:To:Cc:Subject:Date:From;
        b=BVuG3LRWJs1C3JH+D3DIoLR+Nu4qJ9wCRw/d7sfS2eKW0i6y8OQviKP0/WLDHnBe0
         FySfxEmY0lPKpY9RVF+f2HQqYTrEQbxG53PwBlUglHsjuGMF0MpJGlvapCKboXESaW
         9QNV8ug6LBUfczX3Aa1fVYX+NgSvDhfYVTFEpuSdEkHxOg+PxrETaDoKwggyPCp90x
         WWPwYsHS3CqMXK/aC2t6kq2cQxUfxybJHh4SbxOx/5hYnOGDPGWSClSQfWLMXJB88O
         knDrGT5ix96ki/BQnw7Nd7dg7PpwZn/OQmYD1Jj17HkUhiZW71/3bTdVjwVi6S4tZh
         hXIlUhFanYq+w==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>,
        Michael Matz <matz@suse.de>
Cc:     Kees Cook <keescook@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Fangrui Song <maskray@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: [RFC PATCH] kbuild: pass objects instead of archives to linker
Date:   Wed,  2 Nov 2022 18:13:08 +0900
Message-Id: <20221102091308.11568-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an experimental patch, driven by the feedback from Jiri Slaby
and Michael Matz. [1]

Michael Matz says:
 "I know of no linker (outside LTO-like modes) that processes
  archives in a different order than first-to-last-member (under
  whole-archive), but that's not guaranteed anywhere. So relying on
  member-order within archives is always brittle."

It is pretty easy to pass the list of objects instead of a thin archive
because the linker supports the '@file' syntax, where command line
arguments are read from 'file'.

Without this patch, the linker receives

  --whole-archive vmlinux.a --no-whole-archive

With this patch, the linker will receive

  @vmlinux.order

Here, vmlinux.order is a text file that lists built-in objects in the
correct link order.

I am not a toolchain expert. I just want to know if this makes any
difference from the linker perspective and from (non-upstreamed) GCC-LTO
perspective.

(I know this patch does not work for Clang LTO because I did not touch
scripts/generate_initcall_order.pl)

This patch may be unneeded because more correct patches were submitted [2]
but I am still curious about "thin archive vs direct object list".

[1]: https://lore.kernel.org/linux-kbuild/alpine.LSU.2.20.2210251210140.29399@wotan.suse.de/
[2]: https://lore.kernel.org/all/20221101161529.1634188-1-alexandr.lobakin@intel.com/

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 Makefile                                    | 21 ++++++++++-----------
 scripts/Makefile.modpost                    |  5 +++--
 scripts/Makefile.vmlinux_o                  |  6 +++---
 scripts/clang-tools/gen_compile_commands.py | 21 ++++++++++++++++++++-
 scripts/link-vmlinux.sh                     |  8 ++++----
 5 files changed, 40 insertions(+), 21 deletions(-)

diff --git a/Makefile b/Makefile
index e9e7eff906a5..511484a3dacb 100644
--- a/Makefile
+++ b/Makefile
@@ -1213,19 +1213,18 @@ quiet_cmd_autoksyms_h = GEN     $@
 $(autoksyms_h):
 	$(call cmd,autoksyms_h)
 
-# '$(AR) mPi' needs 'T' to workaround the bug of llvm-ar <= 14
-quiet_cmd_ar_vmlinux.a = AR      $@
-      cmd_ar_vmlinux.a = \
-	rm -f $@; \
-	$(AR) cDPrST $@ $(KBUILD_VMLINUX_OBJS); \
-	$(AR) mPiT $$($(AR) t $@ | sed -n 1p) $@ $$($(AR) t $@ | grep -F -f $(srctree)/scripts/head-object-list.txt)
+quiet_cmd_vmlinux_order = GEN     $@
+      cmd_vmlinux_order = \
+	{ $(foreach m, $(KBUILD_VMLINUX_OBJS), $(AR) t $m;) :; } > $(tmp-target) ; \
+	grep -F -f $(srctree)/scripts/head-object-list.txt $(tmp-target) > $@; \
+	grep -F -f $(srctree)/scripts/head-object-list.txt $(tmp-target) -v >> $@
 
-targets += vmlinux.a
-vmlinux.a: $(KBUILD_VMLINUX_OBJS) scripts/head-object-list.txt autoksyms_recursive FORCE
-	$(call if_changed,ar_vmlinux.a)
+targets += vmlinux.order
+vmlinux.order: $(KBUILD_VMLINUX_OBJS) scripts/head-object-list.txt autoksyms_recursive FORCE
+	$(call if_changed,vmlinux_order)
 
 PHONY += vmlinux_o
-vmlinux_o: vmlinux.a $(KBUILD_VMLINUX_LIBS)
+vmlinux_o: vmlinux.order $(KBUILD_VMLINUX_LIBS)
 	$(Q)$(MAKE) -f $(srctree)/scripts/Makefile.vmlinux_o
 
 vmlinux.o modules.builtin.modinfo modules.builtin: vmlinux_o
@@ -2037,7 +2036,7 @@ quiet_cmd_gen_compile_commands = GEN     $@
       cmd_gen_compile_commands = $(PYTHON3) $< -a $(AR) -o $@ $(filter-out $<, $(real-prereqs))
 
 $(extmod_prefix)compile_commands.json: scripts/clang-tools/gen_compile_commands.py \
-	$(if $(KBUILD_EXTMOD),, vmlinux.a $(KBUILD_VMLINUX_LIBS)) \
+	$(if $(KBUILD_EXTMOD),, vmlinux.order $(KBUILD_VMLINUX_LIBS)) \
 	$(if $(CONFIG_MODULES), $(MODORDER)) FORCE
 	$(call if_changed,gen_compile_commands)
 
diff --git a/scripts/Makefile.modpost b/scripts/Makefile.modpost
index e41dee64d429..1d6847da39bd 100644
--- a/scripts/Makefile.modpost
+++ b/scripts/Makefile.modpost
@@ -70,12 +70,13 @@ quiet_cmd_vmlinux_objs = GEN     $@
 	for f in $(real-prereqs); do	\
 		case $${f} in		\
 		*libgcc.a) ;;		\
-		*) $(AR) t $${f} ;;	\
+		*.a) $(AR) t $${f} ;;	\
+		*) cat $${f} ;;		\
 		esac			\
 	done > $@
 
 targets += .vmlinux.objs
-.vmlinux.objs: vmlinux.a $(KBUILD_VMLINUX_LIBS) FORCE
+.vmlinux.objs: vmlinux.order $(KBUILD_VMLINUX_LIBS) FORCE
 	$(call if_changed,vmlinux_objs)
 
 vmlinux.o-if-present := $(wildcard vmlinux.o)
diff --git a/scripts/Makefile.vmlinux_o b/scripts/Makefile.vmlinux_o
index 0edfdb40364b..6eb07f2bb39f 100644
--- a/scripts/Makefile.vmlinux_o
+++ b/scripts/Makefile.vmlinux_o
@@ -18,7 +18,7 @@ quiet_cmd_gen_initcalls_lds = GEN     $@
 	$(PERL) $(real-prereqs) > $@
 
 .tmp_initcalls.lds: $(srctree)/scripts/generate_initcall_order.pl \
-		vmlinux.a $(KBUILD_VMLINUX_LIBS) FORCE
+		vmlinux.order $(KBUILD_VMLINUX_LIBS) FORCE
 	$(call if_changed,gen_initcalls_lds)
 
 targets := .tmp_initcalls.lds
@@ -48,7 +48,7 @@ quiet_cmd_ld_vmlinux.o = LD      $@
       cmd_ld_vmlinux.o = \
 	$(LD) ${KBUILD_LDFLAGS} -r -o $@ \
 	$(addprefix -T , $(initcalls-lds)) \
-	--whole-archive vmlinux.a --no-whole-archive \
+	@vmlinux.order \
 	--start-group $(KBUILD_VMLINUX_LIBS) --end-group \
 	$(cmd_objtool)
 
@@ -57,7 +57,7 @@ define rule_ld_vmlinux.o
 	$(call cmd,gen_objtooldep)
 endef
 
-vmlinux.o: $(initcalls-lds) vmlinux.a $(KBUILD_VMLINUX_LIBS) FORCE
+vmlinux.o: $(initcalls-lds) vmlinux.order $(KBUILD_VMLINUX_LIBS) FORCE
 	$(call if_changed_rule,ld_vmlinux.o)
 
 targets += vmlinux.o
diff --git a/scripts/clang-tools/gen_compile_commands.py b/scripts/clang-tools/gen_compile_commands.py
index d800b2c0af97..c8ba9f084bd0 100755
--- a/scripts/clang-tools/gen_compile_commands.py
+++ b/scripts/clang-tools/gen_compile_commands.py
@@ -57,7 +57,7 @@ def parse_arguments():
     parser.add_argument('-a', '--ar', type=str, default='llvm-ar', help=ar_help)
 
     paths_help = ('directories to search or files to parse '
-                  '(files should be *.o, *.a, or modules.order). '
+                  '(files should be *.o, *.a, or *.order). '
                   'If nothing is specified, the current directory is searched')
     parser.add_argument('paths', type=str, nargs='*', help=paths_help)
 
@@ -124,6 +124,23 @@ def cmdfiles_for_a(archive, ar):
         yield to_cmdfile(obj)
 
 
+def cmdfiles_for_vmlinux_order(vmlinux_order):
+    """Generate the iterator of .cmd files associated with the vmlinux.order.
+
+    Parse the given vmlinux.order, and yield every .cmd file used to build the
+    contained modules.
+
+    Args:
+        vmlinux_order: The vmlinux.order file to parse
+
+    Yields:
+        The path to every .cmd file found
+    """
+    with open(vmlinux_order) as f:
+        for line in f:
+            yield to_cmdfile(line.rstrip())
+
+
 def cmdfiles_for_modorder(modorder):
     """Generate the iterator of .cmd files associated with the modules.order.
 
@@ -203,6 +220,8 @@ def main():
             cmdfiles = cmdfiles_in_dir(path)
         elif path.endswith('.a'):
             cmdfiles = cmdfiles_for_a(path, ar)
+        elif path.endswith('vmlinux.order'):
+            cmdfiles = cmdfiles_for_vmlinux_order(path)
         elif path.endswith('modules.order'):
             cmdfiles = cmdfiles_for_modorder(path)
         else:
diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index 918470d768e9..617ed443e377 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -3,15 +3,15 @@
 #
 # link vmlinux
 #
-# vmlinux is linked from the objects in vmlinux.a and $(KBUILD_VMLINUX_LIBS).
-# vmlinux.a contains objects that are linked unconditionally.
+# vmlinux is linked from the objects in vmlinux.order and $(KBUILD_VMLINUX_LIBS).
+# vmlinux.order is a text file that contains objects that are linked unconditionally.
 # $(KBUILD_VMLINUX_LIBS) are archives which are linked conditionally
 # (not within --whole-archive), and do not require symbol indexes added.
 #
 # vmlinux
 #   ^
 #   |
-#   +--< vmlinux.a
+#   +--< vmlinux.order
 #   |
 #   +--< $(KBUILD_VMLINUX_LIBS)
 #   |    +--< lib/lib.a + more
@@ -65,7 +65,7 @@ vmlinux_link()
 		objs=vmlinux.o
 		libs=
 	else
-		objs=vmlinux.a
+		objs=@vmlinux.order
 		libs="${KBUILD_VMLINUX_LIBS}"
 	fi
 
-- 
2.34.1

