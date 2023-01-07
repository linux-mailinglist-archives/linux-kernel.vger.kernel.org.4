Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DBA5660D37
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 10:19:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231992AbjAGJT2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 04:19:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231905AbjAGJSy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 04:18:54 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D654B87902;
        Sat,  7 Jan 2023 01:18:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 844F2B81F74;
        Sat,  7 Jan 2023 09:18:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9051C433F1;
        Sat,  7 Jan 2023 09:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673083121;
        bh=Gydwsigs3s+UcKgjKjO+8mlNk6k/2GkoKY1BjgMibbo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U/ETtaOtHHRMupIDCoDQClmyyS1Xhi7LQgTA/ixQVGgyw8c7DHOZtx+gNMx3DDmQ9
         xo/N5kdIQXblY+sPnJ5sBRNscHwtKeFIGhMFT4KXlE2Nd9f+nD1erBi9Y36Z6DC8e2
         8RkM7W1ZlyFFyuMFNURCGw7VXAXQ9EZQaJ44EOOyUgZCyJbCzWY64HU2IhqnJzuAGx
         z2uv8RXGSTMB9JNa3J6davMmbPHg+QLczxGW6gIco0M8p/58/y8P1siTuJcj76M3uN
         m0RuNWtzKjQgLWm8vsT67Vc9XhyowUTj9TitP7fWWyMtmfli9Db/on3obOHHp3q0je
         gJtnVpU6JFa4A==
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
Subject: [PATCH v2 4/7] kbuild: remove sed commands after rustc rules
Date:   Sat,  7 Jan 2023 18:18:17 +0900
Message-Id: <20230107091820.3382134-4-masahiroy@kernel.org>
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

rustc may put comments in dep-info, so sed is used to drop them before
passing it to fixdep.

Now that fixdep can remove comments, Makefiles do not need to run sed.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Reviewed-by: Miguel Ojeda <ojeda@kernel.org>
Tested-by: Miguel Ojeda <ojeda@kernel.org>
Reviewed-by: Vincenzo Palazzo <vincenzopalazzodev@gmail.com>
---

(no changes since v1)

 rust/Makefile          |  6 ++----
 scripts/Makefile.build | 18 ++++--------------
 scripts/Makefile.host  |  3 +--
 3 files changed, 7 insertions(+), 20 deletions(-)

diff --git a/rust/Makefile b/rust/Makefile
index 865afb87bc9b..f403b79cae5a 100644
--- a/rust/Makefile
+++ b/rust/Makefile
@@ -333,8 +333,7 @@ quiet_cmd_rustc_procmacro = $(RUSTC_OR_CLIPPY_QUIET) P $@
 	$(RUSTC_OR_CLIPPY) $(rust_common_flags) \
 		--emit=dep-info=$(depfile) --emit=link=$@ --extern proc_macro \
 		--crate-type proc-macro \
-		--crate-name $(patsubst lib%.so,%,$(notdir $@)) $<; \
-	sed -i '/^\#/d' $(depfile)
+		--crate-name $(patsubst lib%.so,%,$(notdir $@)) $<
 
 # Procedural macros can only be used with the `rustc` that compiled it.
 # Therefore, to get `libmacros.so` automatically recompiled when the compiler
@@ -350,8 +349,7 @@ quiet_cmd_rustc_library = $(if $(skip_clippy),RUSTC,$(RUSTC_OR_CLIPPY_QUIET)) L
 		--emit=dep-info=$(depfile) --emit=obj=$@ \
 		--emit=metadata=$(dir $@)$(patsubst %.o,lib%.rmeta,$(notdir $@)) \
 		--crate-type rlib -L$(objtree)/$(obj) \
-		--crate-name $(patsubst %.o,%,$(notdir $@)) $<; \
-	sed -i '/^\#/d' $(depfile) \
+		--crate-name $(patsubst %.o,%,$(notdir $@)) $< \
 	$(if $(rustc_objcopy),;$(OBJCOPY) $(rustc_objcopy) $@)
 
 rust-analyzer:
diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 40de20246e50..76323201232a 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -289,9 +289,6 @@ rust_common_cmd = \
 	--crate-name $(basename $(notdir $@)) \
 	--emit=dep-info=$(depfile)
 
-rust_handle_depfile = \
-	sed -i '/^\#/d' $(depfile)
-
 # `--emit=obj`, `--emit=asm` and `--emit=llvm-ir` imply a single codegen unit
 # will be used. We explicitly request `-Ccodegen-units=1` in any case, and
 # the compiler shows a warning if it is not 1. However, if we ever stop
@@ -301,9 +298,7 @@ rust_handle_depfile = \
 # would not match each other.
 
 quiet_cmd_rustc_o_rs = $(RUSTC_OR_CLIPPY_QUIET) $(quiet_modtag) $@
-      cmd_rustc_o_rs = \
-	$(rust_common_cmd) --emit=obj=$@ $<; \
-	$(rust_handle_depfile)
+      cmd_rustc_o_rs = $(rust_common_cmd) --emit=obj=$@ $<
 
 $(obj)/%.o: $(src)/%.rs FORCE
 	$(call if_changed_dep,rustc_o_rs)
@@ -311,24 +306,19 @@ $(obj)/%.o: $(src)/%.rs FORCE
 quiet_cmd_rustc_rsi_rs = $(RUSTC_OR_CLIPPY_QUIET) $(quiet_modtag) $@
       cmd_rustc_rsi_rs = \
 	$(rust_common_cmd) -Zunpretty=expanded $< >$@; \
-	command -v $(RUSTFMT) >/dev/null && $(RUSTFMT) $@; \
-	$(rust_handle_depfile)
+	command -v $(RUSTFMT) >/dev/null && $(RUSTFMT) $@
 
 $(obj)/%.rsi: $(src)/%.rs FORCE
 	$(call if_changed_dep,rustc_rsi_rs)
 
 quiet_cmd_rustc_s_rs = $(RUSTC_OR_CLIPPY_QUIET) $(quiet_modtag) $@
-      cmd_rustc_s_rs = \
-	$(rust_common_cmd) --emit=asm=$@ $<; \
-	$(rust_handle_depfile)
+      cmd_rustc_s_rs = $(rust_common_cmd) --emit=asm=$@ $<
 
 $(obj)/%.s: $(src)/%.rs FORCE
 	$(call if_changed_dep,rustc_s_rs)
 
 quiet_cmd_rustc_ll_rs = $(RUSTC_OR_CLIPPY_QUIET) $(quiet_modtag) $@
-      cmd_rustc_ll_rs = \
-	$(rust_common_cmd) --emit=llvm-ir=$@ $<; \
-	$(rust_handle_depfile)
+      cmd_rustc_ll_rs = $(rust_common_cmd) --emit=llvm-ir=$@ $<
 
 $(obj)/%.ll: $(src)/%.rs FORCE
 	$(call if_changed_dep,rustc_ll_rs)
diff --git a/scripts/Makefile.host b/scripts/Makefile.host
index 67ef852712d4..a45a97b027d1 100644
--- a/scripts/Makefile.host
+++ b/scripts/Makefile.host
@@ -145,8 +145,7 @@ $(host-cxxobjs): $(obj)/%.o: $(src)/%.cc FORCE
 # host-rust -> Executable
 quiet_cmd_host-rust	= HOSTRUSTC $@
       cmd_host-rust	= \
-	$(HOSTRUSTC) $(hostrust_flags) --emit=link=$@ $<; \
-	sed -i '/^\#/d' $(depfile)
+	$(HOSTRUSTC) $(hostrust_flags) --emit=link=$@ $<
 $(host-rust): $(obj)/%: $(src)/%.rs FORCE
 	$(call if_changed_dep,host-rust)
 
-- 
2.34.1

