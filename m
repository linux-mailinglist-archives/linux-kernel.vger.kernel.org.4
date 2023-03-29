Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A20646CD89F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 13:40:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbjC2Lkt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 07:40:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbjC2Lkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 07:40:45 -0400
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F1D410F;
        Wed, 29 Mar 2023 04:40:44 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: linasend@asahilina.net)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 44AE54249C;
        Wed, 29 Mar 2023 11:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=asahilina.net;
        s=default; t=1680090042;
        bh=op/MvH8FI1eaZn0mWBwxw30yZPebXAjGRe5pwINXIX8=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc;
        b=laM3guzYqlofOX5ArDj2VyS20jgM0Qpgg/W59vG5AGtywZDLVZjOCijiR2coy9inm
         c14QXgDrgQkrL1BNEeRbNdKAEJHOyawQD4EM+712HlfHYAt2r9JB47S0bI9FQiyuDf
         KGMdf5EFwOLL3lJeZXqyCxxsSMedkIviJSQvObVeSQ7YVIkfxTdpVG4naOv7nSxz/U
         qwS7Oz2/phkSCUNAvZS4Qn5xtIqeLdxehwj/md1KOqmC8JiQEk8p+LfHxYZrJS589U
         7aq/+bq0Gif9tem6BiEnD2OmGuU559GWWEkhvJ0lW3ptGATcpZYCX748wH1tURj1xE
         0cWgbRYWAxGIQ==
From:   Asahi Lina <lina@asahilina.net>
Date:   Wed, 29 Mar 2023 20:40:18 +0900
Subject: [PATCH 1/2] rust: uapi: Add UAPI crate
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230329-rust-uapi-v1-1-ee78f2933726@asahilina.net>
References: <20230329-rust-uapi-v1-0-ee78f2933726@asahilina.net>
In-Reply-To: <20230329-rust-uapi-v1-0-ee78f2933726@asahilina.net>
To:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>
Cc:     linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
        asahi@lists.linux.dev, Asahi Lina <lina@asahilina.net>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1680090036; l=4678;
 i=lina@asahilina.net; s=20230221; h=from:subject:message-id;
 bh=op/MvH8FI1eaZn0mWBwxw30yZPebXAjGRe5pwINXIX8=;
 b=+TFoSsDQaePj1U3bW/UnEdo6ELlQoPqtT4aoKzc4FE4Sn8CAhFJAAs/MrR/8IxUzOVBI0JkmP
 WVdnwWnUzeYCzwUdeiSYgcwi+MkNxI7yyaDHKE9fEAiG1/eZH87fDSy
X-Developer-Key: i=lina@asahilina.net; a=ed25519;
 pk=Qn8jZuOtR1m5GaiDfTrAoQ4NE1XoYVZ/wmt5YtXWFC4=
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This crate mirrors the `bindings` crate, but will contain only UAPI
bindings. Unlike the bindings crate, drivers may directly use this crate
if they have to interface with userspace.

Initially, just bind the generic ioctl stuff.

In the future, we would also like to add additional checks to ensure
that all types exposed by this crate satisfy UAPI-safety guarantees
(that is, they are safely castable to/from a "bag of bits").

Signed-off-by: Asahi Lina <lina@asahilina.net>
---
 rust/.gitignore         |  1 +
 rust/Makefile           | 18 ++++++++++++++++--
 rust/kernel/lib.rs      |  1 +
 rust/uapi/lib.rs        | 27 +++++++++++++++++++++++++++
 rust/uapi/uapi_helper.h |  9 +++++++++
 5 files changed, 54 insertions(+), 2 deletions(-)

diff --git a/rust/.gitignore b/rust/.gitignore
index 168cb26a31b9..21552992b401 100644
--- a/rust/.gitignore
+++ b/rust/.gitignore
@@ -2,6 +2,7 @@
 
 bindings_generated.rs
 bindings_helpers_generated.rs
+uapi_generated.rs
 exports_*_generated.h
 doc/
 test/
diff --git a/rust/Makefile b/rust/Makefile
index f88d108fbef0..59a327f0fa1a 100644
--- a/rust/Makefile
+++ b/rust/Makefile
@@ -16,6 +16,9 @@ obj-$(CONFIG_RUST) += alloc.o bindings.o kernel.o
 always-$(CONFIG_RUST) += exports_alloc_generated.h exports_bindings_generated.h \
     exports_kernel_generated.h
 
+always-$(CONFIG_RUST) += uapi/uapi_generated.rs
+obj-$(CONFIG_RUST) += uapi.o
+
 ifdef CONFIG_RUST_BUILD_ASSERT_ALLOW
 obj-$(CONFIG_RUST) += build_error.o
 else
@@ -288,6 +291,12 @@ $(obj)/bindings/bindings_generated.rs: $(src)/bindings/bindings_helper.h \
     $(src)/bindgen_parameters FORCE
 	$(call if_changed_dep,bindgen)
 
+$(obj)/uapi/uapi_generated.rs: private bindgen_target_flags = \
+    $(shell grep -v '^\#\|^$$' $(srctree)/$(src)/bindgen_parameters)
+$(obj)/uapi/uapi_generated.rs: $(src)/uapi/uapi_helper.h \
+    $(src)/bindgen_parameters FORCE
+	$(call if_changed_dep,bindgen)
+
 # See `CFLAGS_REMOVE_helpers.o` above. In addition, Clang on C does not warn
 # with `-Wmissing-declarations` (unlike GCC), so it is not strictly needed here
 # given it is `libclang`; but for consistency, future Clang changes and/or
@@ -388,10 +397,15 @@ $(obj)/bindings.o: $(src)/bindings/lib.rs \
     $(obj)/bindings/bindings_helpers_generated.rs FORCE
 	$(call if_changed_dep,rustc_library)
 
+$(obj)/uapi.o: $(src)/uapi/lib.rs \
+    $(obj)/compiler_builtins.o \
+    $(obj)/uapi/uapi_generated.rs FORCE
+	$(call if_changed_dep,rustc_library)
+
 $(obj)/kernel.o: private rustc_target_flags = --extern alloc \
-    --extern build_error --extern macros --extern bindings
+    --extern build_error --extern macros --extern bindings --extern uapi
 $(obj)/kernel.o: $(src)/kernel/lib.rs $(obj)/alloc.o $(obj)/build_error.o \
-    $(obj)/libmacros.so $(obj)/bindings.o FORCE
+    $(obj)/libmacros.so $(obj)/bindings.o $(obj)/uapi.o FORCE
 	$(call if_changed_dep,rustc_library)
 
 endif # CONFIG_RUST
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 7610b18ee642..63f796781b7c 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -43,6 +43,7 @@ pub mod types;
 #[doc(hidden)]
 pub use bindings;
 pub use macros;
+pub use uapi;
 
 #[doc(hidden)]
 pub use build_error::build_error;
diff --git a/rust/uapi/lib.rs b/rust/uapi/lib.rs
new file mode 100644
index 000000000000..29f69f3a52de
--- /dev/null
+++ b/rust/uapi/lib.rs
@@ -0,0 +1,27 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! UAPI Bindings.
+//!
+//! Contains the bindings generated by `bindgen` for UAPI interfaces.
+//!
+//! This crate may be used directly by drivers that need to interact with
+//! userspace APIs.
+
+#![no_std]
+#![feature(core_ffi_c)]
+// See <https://github.com/rust-lang/rust-bindgen/issues/1651>.
+#![cfg_attr(test, allow(deref_nullptr))]
+#![cfg_attr(test, allow(unaligned_references))]
+#![cfg_attr(test, allow(unsafe_op_in_unsafe_fn))]
+#![allow(
+    clippy::all,
+    missing_docs,
+    non_camel_case_types,
+    non_upper_case_globals,
+    non_snake_case,
+    improper_ctypes,
+    unreachable_pub,
+    unsafe_op_in_unsafe_fn
+)]
+
+include!(concat!(env!("OBJTREE"), "/rust/uapi/uapi_generated.rs"));
diff --git a/rust/uapi/uapi_helper.h b/rust/uapi/uapi_helper.h
new file mode 100644
index 000000000000..301f5207f023
--- /dev/null
+++ b/rust/uapi/uapi_helper.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Header that contains the headers for which Rust UAPI bindings
+ * will be automatically generated by `bindgen`.
+ *
+ * Sorted alphabetically.
+ */
+
+#include <uapi/asm-generic/ioctl.h>

-- 
2.40.0

