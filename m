Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F051C660D2F
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 10:18:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231723AbjAGJSk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 04:18:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230236AbjAGJSe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 04:18:34 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D5CD85CB0;
        Sat,  7 Jan 2023 01:18:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0CF0F606A0;
        Sat,  7 Jan 2023 09:18:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2752C433F0;
        Sat,  7 Jan 2023 09:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673083112;
        bh=0QF2lzNN/SLn4tIfGJY0no6diuyNZkG0xSiunadzdwQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bn/zBTlN/qu9/Q/toTAoVwwdm6H665REKlxjr9NaCH1ds7yhrw8wNfqpK5mi/hmXm
         8V6WJcyVYjKjzfmz98tYnt9GRa9QtdWkn6qWYYTD8Unid/lPiFkq+XYGR/oVY2Vlf+
         Or5h7tt6tjJV0PpKZlrD9lTzQtKRjiZUkHtXc5+nuRnWer9NAs+GCDS8LOOYpd1GM+
         V6CWuvEIeEJeFr6Kv1i9QY/f7R7hviBYNBTOw6fNq3R3mb1y3zB1ng2p/E83deCxl8
         LOG6TXnLlfI75hyHZHBEPfWQFDMsQPK02bJmMf311q2zcMOxy7LZbALbKGzISwZCtr
         n2BZ7OwHKyRyA==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
        rust-for-linux@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Vincenzo Palazzo <vincenzopalazzodev@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>, Tom Rix <trix@redhat.com>,
        llvm@lists.linux.dev
Subject: [PATCH v2 2/7] kbuild: specify output names separately for each emission type from rustc
Date:   Sat,  7 Jan 2023 18:18:15 +0900
Message-Id: <20230107091820.3382134-2-masahiroy@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230107091820.3382134-1-masahiroy@kernel.org>
References: <20230107091820.3382134-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In Kbuild, two different rules must not write to the same file, but
it happens when compiling rust source files.

For example, set CONFIG_SAMPLE_RUST_MINIMAL=m and run the following:

  $ make -j$(nproc) samples/rust/rust_minimal.o samples/rust/rust_minimal.rsi \
                    samples/rust/rust_minimal.s samples/rust/rust_minimal.ll
    [snip]
    RUSTC [M] samples/rust/rust_minimal.o
    RUSTC [M] samples/rust/rust_minimal.rsi
    RUSTC [M] samples/rust/rust_minimal.s
    RUSTC [M] samples/rust/rust_minimal.ll
  mv: cannot stat 'samples/rust/rust_minimal.d': No such file or directory
  make[3]: *** [scripts/Makefile.build:334: samples/rust/rust_minimal.ll] Error 1
  make[3]: *** Waiting for unfinished jobs....
  mv: cannot stat 'samples/rust/rust_minimal.d': No such file or directory
  make[3]: *** [scripts/Makefile.build:309: samples/rust/rust_minimal.o] Error 1
  mv: cannot stat 'samples/rust/rust_minimal.d': No such file or directory
  make[3]: *** [scripts/Makefile.build:326: samples/rust/rust_minimal.s] Error 1
  make[2]: *** [scripts/Makefile.build:504: samples/rust] Error 2
  make[1]: *** [scripts/Makefile.build:504: samples] Error 2
  make: *** [Makefile:2008: .] Error 2

The reason for the error is that 4 threads running in parallel renames
the same file, samples/rust/rust_minimal.d.

This does not happen when compiling C or assembly files because
-Wp,-MMD,$(depfile) explicitly specifies the dependency filepath.
$(depfile) is a unique path for each target.

Currently, rustc is only given --out-dir and --emit=<list-of-types>
So, all the rust build rules output the dep-info into the default
<CRATE_NAME>.d, which causes the path conflict.

Fortunately, the --emit option is able to specify the output path
individually, with the form --emit=<type>=<path>.

Add --emit=dep-info=$(depfile) to the common part. Also, remove the
redundant --out-dir because the output path is specified for each type.

The code gets much cleaner because we do not need to rename *.d files.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Reviewed-by: Miguel Ojeda <ojeda@kernel.org>
Tested-by: Miguel Ojeda <ojeda@kernel.org>
Reviewed-by: Vincenzo Palazzo <vincenzopalazzodev@gmail.com>
---

Changes in v2:
  - Wrap a too long line

 rust/Makefile          | 11 +++++------
 scripts/Makefile.build | 14 +++++++-------
 scripts/Makefile.host  |  6 ++----
 3 files changed, 14 insertions(+), 17 deletions(-)

diff --git a/rust/Makefile b/rust/Makefile
index ff70c4c916f8..865afb87bc9b 100644
--- a/rust/Makefile
+++ b/rust/Makefile
@@ -331,10 +331,9 @@ $(obj)/exports_kernel_generated.h: $(obj)/kernel.o FORCE
 quiet_cmd_rustc_procmacro = $(RUSTC_OR_CLIPPY_QUIET) P $@
       cmd_rustc_procmacro = \
 	$(RUSTC_OR_CLIPPY) $(rust_common_flags) \
-		--emit=dep-info,link --extern proc_macro \
-		--crate-type proc-macro --out-dir $(objtree)/$(obj) \
+		--emit=dep-info=$(depfile) --emit=link=$@ --extern proc_macro \
+		--crate-type proc-macro \
 		--crate-name $(patsubst lib%.so,%,$(notdir $@)) $<; \
-	mv $(objtree)/$(obj)/$(patsubst lib%.so,%,$(notdir $@)).d $(depfile); \
 	sed -i '/^\#/d' $(depfile)
 
 # Procedural macros can only be used with the `rustc` that compiled it.
@@ -348,10 +347,10 @@ quiet_cmd_rustc_library = $(if $(skip_clippy),RUSTC,$(RUSTC_OR_CLIPPY_QUIET)) L
 	OBJTREE=$(abspath $(objtree)) \
 	$(if $(skip_clippy),$(RUSTC),$(RUSTC_OR_CLIPPY)) \
 		$(filter-out $(skip_flags),$(rust_flags) $(rustc_target_flags)) \
-		--emit=dep-info,obj,metadata --crate-type rlib \
-		--out-dir $(objtree)/$(obj) -L$(objtree)/$(obj) \
+		--emit=dep-info=$(depfile) --emit=obj=$@ \
+		--emit=metadata=$(dir $@)$(patsubst %.o,lib%.rmeta,$(notdir $@)) \
+		--crate-type rlib -L$(objtree)/$(obj) \
 		--crate-name $(patsubst %.o,%,$(notdir $@)) $<; \
-	mv $(objtree)/$(obj)/$(patsubst %.o,%,$(notdir $@)).d $(depfile); \
 	sed -i '/^\#/d' $(depfile) \
 	$(if $(rustc_objcopy),;$(OBJCOPY) $(rustc_objcopy) $@)
 
diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index a0d5c6cca76d..40de20246e50 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -285,11 +285,11 @@ rust_common_cmd = \
 	-Zcrate-attr=no_std \
 	-Zcrate-attr='feature($(rust_allowed_features))' \
 	--extern alloc --extern kernel \
-	--crate-type rlib --out-dir $(obj) -L $(objtree)/rust/ \
-	--crate-name $(basename $(notdir $@))
+	--crate-type rlib -L $(objtree)/rust/ \
+	--crate-name $(basename $(notdir $@)) \
+	--emit=dep-info=$(depfile)
 
 rust_handle_depfile = \
-	mv $(obj)/$(basename $(notdir $@)).d $(depfile); \
 	sed -i '/^\#/d' $(depfile)
 
 # `--emit=obj`, `--emit=asm` and `--emit=llvm-ir` imply a single codegen unit
@@ -302,7 +302,7 @@ rust_handle_depfile = \
 
 quiet_cmd_rustc_o_rs = $(RUSTC_OR_CLIPPY_QUIET) $(quiet_modtag) $@
       cmd_rustc_o_rs = \
-	$(rust_common_cmd) --emit=dep-info,obj $<; \
+	$(rust_common_cmd) --emit=obj=$@ $<; \
 	$(rust_handle_depfile)
 
 $(obj)/%.o: $(src)/%.rs FORCE
@@ -310,7 +310,7 @@ $(obj)/%.o: $(src)/%.rs FORCE
 
 quiet_cmd_rustc_rsi_rs = $(RUSTC_OR_CLIPPY_QUIET) $(quiet_modtag) $@
       cmd_rustc_rsi_rs = \
-	$(rust_common_cmd) --emit=dep-info -Zunpretty=expanded $< >$@; \
+	$(rust_common_cmd) -Zunpretty=expanded $< >$@; \
 	command -v $(RUSTFMT) >/dev/null && $(RUSTFMT) $@; \
 	$(rust_handle_depfile)
 
@@ -319,7 +319,7 @@ $(obj)/%.rsi: $(src)/%.rs FORCE
 
 quiet_cmd_rustc_s_rs = $(RUSTC_OR_CLIPPY_QUIET) $(quiet_modtag) $@
       cmd_rustc_s_rs = \
-	$(rust_common_cmd) --emit=dep-info,asm $<; \
+	$(rust_common_cmd) --emit=asm=$@ $<; \
 	$(rust_handle_depfile)
 
 $(obj)/%.s: $(src)/%.rs FORCE
@@ -327,7 +327,7 @@ $(obj)/%.s: $(src)/%.rs FORCE
 
 quiet_cmd_rustc_ll_rs = $(RUSTC_OR_CLIPPY_QUIET) $(quiet_modtag) $@
       cmd_rustc_ll_rs = \
-	$(rust_common_cmd) --emit=dep-info,llvm-ir $<; \
+	$(rust_common_cmd) --emit=llvm-ir=$@ $<; \
 	$(rust_handle_depfile)
 
 $(obj)/%.ll: $(src)/%.rs FORCE
diff --git a/scripts/Makefile.host b/scripts/Makefile.host
index dea494ef55d5..67ef852712d4 100644
--- a/scripts/Makefile.host
+++ b/scripts/Makefile.host
@@ -85,7 +85,7 @@ hostc_flags    = $(KBUILD_HOSTCFLAGS) $(HOST_EXTRACFLAGS) \
 hostcxx_flags  = $(KBUILD_HOSTCXXFLAGS) $(HOST_EXTRACXXFLAGS) \
                   $(HOSTCXXFLAGS_$(target-stem).o) -Wp,-MMD,$(depfile)
 hostrust_flags = $(KBUILD_HOSTRUSTFLAGS) $(HOST_EXTRARUSTFLAGS) \
-                 $(HOSTRUSTFLAGS_$(target-stem))
+                 $(HOSTRUSTFLAGS_$(target-stem)) --emit=dep-info=$(depfile)
 
 # $(objtree)/$(obj) for including generated headers from checkin source files
 ifeq ($(KBUILD_EXTMOD),)
@@ -145,9 +145,7 @@ $(host-cxxobjs): $(obj)/%.o: $(src)/%.cc FORCE
 # host-rust -> Executable
 quiet_cmd_host-rust	= HOSTRUSTC $@
       cmd_host-rust	= \
-	$(HOSTRUSTC) $(hostrust_flags) --emit=dep-info,link \
-		--out-dir=$(obj)/ $<; \
-	mv $(obj)/$(target-stem).d $(depfile); \
+	$(HOSTRUSTC) $(hostrust_flags) --emit=link=$@ $<; \
 	sed -i '/^\#/d' $(depfile)
 $(host-rust): $(obj)/%: $(src)/%.rs FORCE
 	$(call if_changed_dep,host-rust)
-- 
2.34.1

