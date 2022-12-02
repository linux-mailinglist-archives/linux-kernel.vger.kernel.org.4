Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 043AA640A5A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 17:15:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233633AbiLBQPg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 11:15:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232678AbiLBQPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 11:15:31 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00FC4AD304;
        Fri,  2 Dec 2022 08:15:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7FE8862322;
        Fri,  2 Dec 2022 16:15:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B85ACC433D6;
        Fri,  2 Dec 2022 16:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669997727;
        bh=Tg9Vetnf1ynCTh+XAWpkiqMszhnKMj/lQo1pCgoc+TI=;
        h=From:To:Cc:Subject:Date:From;
        b=pc5UoQ8h5+GkKU0VnSUhVfrOssinSaJFyeYS/SmvmNT8wVNtJV6XeMXzwBdb1aiF8
         O3JpHSfZ947Rkpm9Mb1XBbGKIzVTawsW54Pa8hb54ialUbxabdOuPhAGjAHpKssHGh
         H3Ipk03gjPm2mbpmCteR57ryni5yjuH+5ClyamOwlR+qA/jPKgWkfa8XRyIpbZD110
         ZLa8Cr+s3w6klh6ojTTt1FP/0kx3y0s7ZAOz+WQNQLK/5SV/KQozFlUOsLjjgM+ku0
         zY/0gPQWnOq03OaDSZce7hLQqKcq4Ojvd2HGnbYkn924ZRfGNEtE8WVjg72sXO946Y
         4Jg3FmueHPrfQ==
From:   ojeda@kernel.org
To:     Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev
Subject: [PATCH v2 00/28] Rust core additions
Date:   Fri,  2 Dec 2022 17:14:31 +0100
Message-Id: <20221202161502.385525-1-ojeda@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Miguel Ojeda <ojeda@kernel.org>

This is v2 of the first batch of changes to upstream the rest of
the Rust support. v1 is at:

    https://lore.kernel.org/rust-for-linux/20221110164152.26136-1-ojeda@kernel.org/

I collected the tags and applied the agreed changes. The full diff
follows (with respect to v1), since they are minor enough.

I will be applying the patches tomorrow, since v1 has had more than
three weeks of review time.

diff --git a/rust/build_error.rs b/rust/build_error.rs
index 0ff6b33059aa..fa24eeef9929 100644
--- a/rust/build_error.rs
+++ b/rust/build_error.rs
@@ -2,19 +2,26 @@
 
 //! Build-time error.
 //!
-//! This crate provides a function `build_error`, which will panic in
-//! compile-time if executed in const context, and will cause a build error
-//! if not executed at compile time and the optimizer does not optimise away the
-//! call.
+//! This crate provides a [const function][const-functions] `build_error`, which will panic in
+//! compile-time if executed in [const context][const-context], and will cause a build error
+//! if not executed at compile time and the optimizer does not optimise away the call.
 //!
 //! It is used by `build_assert!` in the kernel crate, allowing checking of
 //! conditions that could be checked statically, but could not be enforced in
-//! Rust yet (e.g. perform some checks in const functions, but those
+//! Rust yet (e.g. perform some checks in [const functions][const-functions], but those
 //! functions could still be called in the runtime).
+//!
+//! For details on constant evaluation in Rust, please see the [Reference][const-eval].
+//!
+//! [const-eval]: https://doc.rust-lang.org/reference/const_eval.html
+//! [const-functions]: https://doc.rust-lang.org/reference/const_eval.html#const-functions
+//! [const-context]: https://doc.rust-lang.org/reference/const_eval.html#const-context
 
 #![no_std]
 
-/// Panics if executed in const context, or triggers a build error if not.
+/// Panics if executed in [const context][const-context], or triggers a build error if not.
+///
+/// [const-context]: https://doc.rust-lang.org/reference/const_eval.html#const-context
 #[inline(never)]
 #[cold]
 #[export_name = "rust_build_error"]
diff --git a/rust/kernel/std_vendor.rs b/rust/kernel/std_vendor.rs
index da57b4e521f4..b3e68b24a8c6 100644
--- a/rust/kernel/std_vendor.rs
+++ b/rust/kernel/std_vendor.rs
@@ -35,9 +35,12 @@
 /// This is useful when debugging issues that only occur in release
 /// builds or when debugging in release mode is significantly faster.
 ///
-/// Note that the macro is intended as a debugging tool and therefore you
-/// should avoid having uses of it in version control for long periods
-/// (other than in tests and similar).
+/// Note that the macro is intended as a temporary debugging tool to be
+/// used during development. Therefore, avoid committing `dbg!` macro
+/// invocations into the kernel tree.
+///
+/// For debug output that is intended to be kept in the kernel tree,
+/// use [`pr_debug`] and similar facilities instead.
 ///
 /// # Stability
 ///
diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
index ffac633423db..b771310fa4a4 100644
--- a/rust/kernel/str.rs
+++ b/rust/kernel/str.rs
@@ -129,18 +129,6 @@ impl CStr {
         Ok(unsafe { Self::from_bytes_with_nul_unchecked(bytes) })
     }
 
-    /// Creates a [`CStr`] from a `[u8]`, panic if input is not valid.
-    ///
-    /// This function is only meant to be used by `c_str!` macro, so
-    /// crates using `c_str!` macro don't have to enable `const_panic` feature.
-    #[doc(hidden)]
-    pub const fn from_bytes_with_nul_unwrap(bytes: &[u8]) -> &Self {
-        match Self::from_bytes_with_nul(bytes) {
-            Ok(v) => v,
-            Err(_) => panic!("string contains interior NUL"),
-        }
-    }
-
     /// Creates a [`CStr`] from a `[u8]` without performing any additional
     /// checks.
     ///
@@ -349,7 +337,10 @@ where
 macro_rules! c_str {
     ($str:expr) => {{
         const S: &str = concat!($str, "\0");
-        const C: &$crate::str::CStr = $crate::str::CStr::from_bytes_with_nul_unwrap(S.as_bytes());
+        const C: &$crate::str::CStr = match $crate::str::CStr::from_bytes_with_nul(S.as_bytes()) {
+            Ok(v) => v,
+            Err(_) => panic!("string contains interior NUL"),
+        };
         C
     }};
 }
diff --git a/rust/macros/concat_idents.rs b/rust/macros/concat_idents.rs
index 3b5a9dd70e8a..7e4b450f3a50 100644
--- a/rust/macros/concat_idents.rs
+++ b/rust/macros/concat_idents.rs
@@ -18,6 +18,6 @@ pub(crate) fn concat_idents(ts: TokenStream) -> TokenStream {
     assert_eq!(expect_punct(&mut it), ',');
     let b = expect_ident(&mut it);
     assert!(it.next().is_none(), "only two idents can be concatenated");
-    let res = Ident::new(&(a.to_string() + &b.to_string()), b.span());
+    let res = Ident::new(&format!("{a}{b}"), b.span());
     TokenStream::from_iter([TokenTree::Ident(res)])
 }

Björn Roy Baron (1):
  rust: macros: add `concat_idents!` proc macro

Finn Behrens (1):
  rust: error: declare errors using macro

Gary Guo (9):
  rust: macros: add `#[vtable]` proc macro
  rust: macros: take string literals in `module!`
  rust: str: add `BStr` type
  rust: str: add `b_str!` macro
  rust: str: add `CStr` type
  rust: str: implement several traits for `CStr`
  rust: str: add `c_str!` macro
  rust: add `build_error` crate
  rust: build_assert: add `build_{error,assert}!` macros

Miguel Ojeda (7):
  rust: prelude: split re-exports into groups
  rust: print: add more `pr_*!` levels
  rust: print: add `pr_cont!` macro
  rust: samples: add `rust_print` example
  rust: alloc: add `RawVec::try_with_capacity_in()` constructor
  rust: alloc: add `Vec::try_with_capacity{,_in}()` constructors
  rust: static_assert: add `static_assert!` macro

Milan Landaverde (1):
  rust: str: add `CStr` unit tests

Niklas Mohrin (1):
  rust: std_vendor: add `dbg!` macro based on `std`'s one

Viktor Garske (1):
  rust: error: add codes from `errno-base.h`

Wedson Almeida Filho (7):
  rust: error: add `From` implementations for `Error`
  rust: prelude: add `error::code::*` constant items
  rust: str: add `Formatter` type
  rust: str: add `CString` type
  rust: str: add `fmt!` macro
  rust: types: add `Either` type
  rust: types: add `Opaque` type

 lib/Kconfig.debug                 |  16 +
 rust/Makefile                     |  22 +-
 rust/alloc/raw_vec.rs             |  33 +-
 rust/alloc/vec/mod.rs             |  89 +++++
 rust/build_error.rs               |  31 ++
 rust/exports.c                    |   5 +
 rust/kernel/build_assert.rs       |  82 +++++
 rust/kernel/error.rs              |  90 ++++-
 rust/kernel/lib.rs                |   9 +
 rust/kernel/prelude.rs            |  20 +-
 rust/kernel/print.rs              | 214 +++++++++++-
 rust/kernel/static_assert.rs      |  34 ++
 rust/kernel/std_vendor.rs         | 163 ++++++++++
 rust/kernel/str.rs                | 523 +++++++++++++++++++++++++++++-
 rust/kernel/types.rs              |  37 +++
 rust/macros/concat_idents.rs      |  23 ++
 rust/macros/helpers.rs            |  24 +-
 rust/macros/lib.rs                | 108 +++++-
 rust/macros/module.rs             |  10 +-
 rust/macros/vtable.rs             |  95 ++++++
 samples/rust/Kconfig              |  10 +
 samples/rust/Makefile             |   1 +
 samples/rust/rust_minimal.rs      |   8 +-
 samples/rust/rust_print.rs        |  54 +++
 scripts/generate_rust_analyzer.py |   8 +-
 25 files changed, 1667 insertions(+), 42 deletions(-)
 create mode 100644 rust/build_error.rs
 create mode 100644 rust/kernel/build_assert.rs
 create mode 100644 rust/kernel/static_assert.rs
 create mode 100644 rust/kernel/std_vendor.rs
 create mode 100644 rust/kernel/types.rs
 create mode 100644 rust/macros/concat_idents.rs
 create mode 100644 rust/macros/vtable.rs
 create mode 100644 samples/rust/rust_print.rs


base-commit: f0c4d9fc9cc9462659728d168387191387e903cc
-- 
2.38.1

