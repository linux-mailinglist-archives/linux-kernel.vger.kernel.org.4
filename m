Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34D2C62475C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 17:45:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232383AbiKJQpU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 11:45:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232209AbiKJQom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 11:44:42 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E29A0BDC;
        Thu, 10 Nov 2022 08:43:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 728D861BCD;
        Thu, 10 Nov 2022 16:43:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF050C433D6;
        Thu, 10 Nov 2022 16:43:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668098613;
        bh=q1b+8RZULo3LQ8zfqDuXjlyaAk2LL+pi89RJyIKKyOM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KcZWT59DhU6X0r5e+tq/lKETZqJggaXdtsuQ9zutkzK2+7s+T5StUs+YzFvBnACGg
         ogTAKl6xIMpebuPXuCitVtNnY8VpWQxom9BtobATzy//M5CJ7ErFztIwV4oGqMPgqh
         heo2ndpyQmPtJSLGr9aZAT38CVilEe5JPglAcFaL4wZ6Ca6eR8znyC158lz98eDUxk
         6qlX1EMZ2qUdsieAYqPfgQk7lsiX0a3OdvRgwjWDh8Yg9J5NaJncHEchEV1+biGbKu
         4dTuoyolV77dcXBFGKkXoARnoq3JYG/tvK2O7qhiP0iAtZghZ8UUPsBOrEindsgtIf
         S7EeVmWJ2t9jg==
From:   Miguel Ojeda <ojeda@kernel.org>
To:     Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev
Subject: [PATCH v1 25/28] rust: add `build_error` crate
Date:   Thu, 10 Nov 2022 17:41:37 +0100
Message-Id: <20221110164152.26136-26-ojeda@kernel.org>
In-Reply-To: <20221110164152.26136-1-ojeda@kernel.org>
References: <20221110164152.26136-1-ojeda@kernel.org>
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

From: Gary Guo <gary@garyguo.net>

The `build_error` crate provides a function `build_error` which
will panic at compile-time if executed in const context and,
by default, will cause a build error if not executed at compile
time and the optimizer does not optimise away the call.

The `CONFIG_RUST_BUILD_ASSERT_ALLOW` kernel option allows to
relax the default build failure and convert it to a runtime
check. If the runtime check fails, `panic!` will be called.

Its functionality will be exposed to users as a couple macros in
the `kernel` crate in the following patch, thus some documentation
here refers to them for simplicity.

Signed-off-by: Gary Guo <gary@garyguo.net>
[Reworded, adapted for upstream and applied latest changes]
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 lib/Kconfig.debug                 | 16 ++++++++++++++++
 rust/Makefile                     | 22 +++++++++++++++++-----
 rust/build_error.rs               | 24 ++++++++++++++++++++++++
 rust/exports.c                    |  5 +++++
 scripts/generate_rust_analyzer.py |  8 +++++++-
 5 files changed, 69 insertions(+), 6 deletions(-)
 create mode 100644 rust/build_error.rs

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 29280072dc0e..452c9f06c2bc 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2801,6 +2801,22 @@ config RUST_OVERFLOW_CHECKS
 
 	  If unsure, say Y.
 
+config RUST_BUILD_ASSERT_ALLOW
+	bool "Allow unoptimized build-time assertions"
+	depends on RUST
+	help
+	  Controls how are `build_error!` and `build_assert!` handled during build.
+
+	  If calls to them exist in the binary, it may indicate a violated invariant
+	  or that the optimizer failed to verify the invariant during compilation.
+
+	  This should not happen, thus by default the build is aborted. However,
+	  as an escape hatch, you can choose Y here to ignore them during build
+	  and let the check be carried at runtime (with `panic!` being called if
+	  the check fails).
+
+	  If unsure, say N.
+
 endmenu # "Rust"
 
 source "Documentation/Kconfig"
diff --git a/rust/Makefile b/rust/Makefile
index 7700d3853404..ff70c4c916f8 100644
--- a/rust/Makefile
+++ b/rust/Makefile
@@ -19,6 +19,12 @@ obj-$(CONFIG_RUST) += alloc.o bindings.o kernel.o
 always-$(CONFIG_RUST) += exports_alloc_generated.h exports_bindings_generated.h \
     exports_kernel_generated.h
 
+ifdef CONFIG_RUST_BUILD_ASSERT_ALLOW
+obj-$(CONFIG_RUST) += build_error.o
+else
+always-$(CONFIG_RUST) += build_error.o
+endif
+
 obj-$(CONFIG_RUST) += exports.o
 
 # Avoids running `$(RUSTC)` for the sysroot when it may not be available.
@@ -108,7 +114,7 @@ rustdoc-alloc: $(src)/alloc/lib.rs rustdoc-core rustdoc-compiler_builtins FORCE
 	$(call if_changed,rustdoc)
 
 rustdoc-kernel: private rustc_target_flags = --extern alloc \
-    --extern macros=$(objtree)/$(obj)/libmacros.so \
+    --extern build_error --extern macros=$(objtree)/$(obj)/libmacros.so \
     --extern bindings
 rustdoc-kernel: $(src)/kernel/lib.rs rustdoc-core rustdoc-macros \
     rustdoc-compiler_builtins rustdoc-alloc $(obj)/libmacros.so \
@@ -126,6 +132,9 @@ quiet_cmd_rustc_test_library = RUSTC TL $<
 		-L$(objtree)/$(obj)/test \
 		--crate-name $(subst rusttest-,,$(subst rusttestlib-,,$@)) $<
 
+rusttestlib-build_error: $(src)/build_error.rs rusttest-prepare FORCE
+	$(call if_changed,rustc_test_library)
+
 rusttestlib-macros: private rustc_target_flags = --extern proc_macro
 rusttestlib-macros: private rustc_test_library_proc = yes
 rusttestlib-macros: $(src)/macros/lib.rs rusttest-prepare FORCE
@@ -216,9 +225,9 @@ rusttest-macros: $(src)/macros/lib.rs rusttest-prepare FORCE
 	$(call if_changed,rustdoc_test)
 
 rusttest-kernel: private rustc_target_flags = --extern alloc \
-    --extern macros --extern bindings
+    --extern build_error --extern macros --extern bindings
 rusttest-kernel: $(src)/kernel/lib.rs rusttest-prepare \
-    rusttestlib-macros rusttestlib-bindings FORCE
+    rusttestlib-build_error rusttestlib-macros rusttestlib-bindings FORCE
 	$(call if_changed,rustc_test)
 	$(call if_changed,rustc_test_library)
 
@@ -366,6 +375,9 @@ $(obj)/alloc.o: private rustc_target_flags = $(alloc-cfgs)
 $(obj)/alloc.o: $(src)/alloc/lib.rs $(obj)/compiler_builtins.o FORCE
 	$(call if_changed_dep,rustc_library)
 
+$(obj)/build_error.o: $(src)/build_error.rs $(obj)/compiler_builtins.o FORCE
+	$(call if_changed_dep,rustc_library)
+
 $(obj)/bindings.o: $(src)/bindings/lib.rs \
     $(obj)/compiler_builtins.o \
     $(obj)/bindings/bindings_generated.rs \
@@ -373,8 +385,8 @@ $(obj)/bindings.o: $(src)/bindings/lib.rs \
 	$(call if_changed_dep,rustc_library)
 
 $(obj)/kernel.o: private rustc_target_flags = --extern alloc \
-    --extern macros --extern bindings
-$(obj)/kernel.o: $(src)/kernel/lib.rs $(obj)/alloc.o \
+    --extern build_error --extern macros --extern bindings
+$(obj)/kernel.o: $(src)/kernel/lib.rs $(obj)/alloc.o $(obj)/build_error.o \
     $(obj)/libmacros.so $(obj)/bindings.o FORCE
 	$(call if_changed_dep,rustc_library)
 
diff --git a/rust/build_error.rs b/rust/build_error.rs
new file mode 100644
index 000000000000..0ff6b33059aa
--- /dev/null
+++ b/rust/build_error.rs
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Build-time error.
+//!
+//! This crate provides a function `build_error`, which will panic in
+//! compile-time if executed in const context, and will cause a build error
+//! if not executed at compile time and the optimizer does not optimise away the
+//! call.
+//!
+//! It is used by `build_assert!` in the kernel crate, allowing checking of
+//! conditions that could be checked statically, but could not be enforced in
+//! Rust yet (e.g. perform some checks in const functions, but those
+//! functions could still be called in the runtime).
+
+#![no_std]
+
+/// Panics if executed in const context, or triggers a build error if not.
+#[inline(never)]
+#[cold]
+#[export_name = "rust_build_error"]
+#[track_caller]
+pub const fn build_error(msg: &'static str) -> ! {
+    panic!("{}", msg);
+}
diff --git a/rust/exports.c b/rust/exports.c
index bb7cc64cecd0..83e2a7070cae 100644
--- a/rust/exports.c
+++ b/rust/exports.c
@@ -19,3 +19,8 @@
 #include "exports_alloc_generated.h"
 #include "exports_bindings_generated.h"
 #include "exports_kernel_generated.h"
+
+// For modules using `rust/build_error.rs`.
+#ifdef CONFIG_RUST_BUILD_ASSERT_ALLOW
+EXPORT_SYMBOL_RUST_GPL(rust_build_error);
+#endif
diff --git a/scripts/generate_rust_analyzer.py b/scripts/generate_rust_analyzer.py
index 75bb611bd751..ecc7ea9a4dcf 100755
--- a/scripts/generate_rust_analyzer.py
+++ b/scripts/generate_rust_analyzer.py
@@ -67,6 +67,12 @@ def generate_crates(srctree, objtree, sysroot_src):
     )
     crates[-1]["proc_macro_dylib_path"] = "rust/libmacros.so"
 
+    append_crate(
+        "build_error",
+        srctree / "rust" / "build_error.rs",
+        ["core", "compiler_builtins"],
+    )
+
     append_crate(
         "bindings",
         srctree / "rust"/ "bindings" / "lib.rs",
@@ -78,7 +84,7 @@ def generate_crates(srctree, objtree, sysroot_src):
     append_crate(
         "kernel",
         srctree / "rust" / "kernel" / "lib.rs",
-        ["core", "alloc", "macros", "bindings"],
+        ["core", "alloc", "macros", "build_error", "bindings"],
         cfg=cfg,
     )
     crates[-1]["source"] = {
-- 
2.38.1

