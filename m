Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A23D624749
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 17:43:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231915AbiKJQnT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 11:43:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232140AbiKJQm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 11:42:58 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5428A45095;
        Thu, 10 Nov 2022 08:42:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 095B2B82252;
        Thu, 10 Nov 2022 16:42:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D6DBC433D6;
        Thu, 10 Nov 2022 16:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668098559;
        bh=sgzLAxpoWYOhhz1qABiMpx4C/FWitRtqVHgbxRNmqTw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HEC7BC06OAR9pVeEukkGaqBFYivIWanC36Ml5l8z2qN9azjXT9hhFIMHhquUvPRSV
         kpSkIwgiFbSCECSgzsmTbREoKNwte4NUsinJSlOItbwU60n36YC1fBy6jdfoQIATCf
         mePvqXfMaUXcE3hlW6P5HqBo8gFP8mESSdBM+UyRbN6LHN37PiFDEax44R/oEoqt0V
         OMLT/JLBBzwlfc4lY4gFqHNCoT6lErjpydHLxOLxtLV2r830Vn7bdIB/B9MOBIAGXf
         CmuhbPf2nHX6WKcqv8kmf7aRGE6TtR5DaXNEvX9OiAzw8m7jWaU7og7EjJMHkl5/iO
         3Qa8pm35Xs05g==
From:   Miguel Ojeda <ojeda@kernel.org>
To:     Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev
Subject: [PATCH v1 07/28] rust: macros: take string literals in `module!`
Date:   Thu, 10 Nov 2022 17:41:19 +0100
Message-Id: <20221110164152.26136-8-ojeda@kernel.org>
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

Instead of taking binary string literals, take string ones instead,
making it easier for users to define a module, i.e. instead of
calling `module!` like:

    module! {
        ...
        name: b"rust_minimal",
        ...
    }

now it is called as:

    module! {
        ...
        name: "rust_minimal",
        ...
    }

Module names, aliases and license strings are restricted to
ASCII only. However, the author and the description allows UTF-8.

For simplicity (avoid parsing), escape sequences and raw string
literals are not yet handled.

Link: https://github.com/Rust-for-Linux/linux/issues/252
Link: https://lore.kernel.org/lkml/YukvvPOOu8uZl7+n@yadro.com/
Signed-off-by: Gary Guo <gary@garyguo.net>
[Reworded, adapted for upstream and applied latest changes]
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 rust/macros/helpers.rs       | 24 ++++++++++++++++++------
 rust/macros/lib.rs           | 12 ++++++------
 rust/macros/module.rs        | 10 +++++-----
 samples/rust/rust_minimal.rs |  8 ++++----
 samples/rust/rust_print.rs   |  8 ++++----
 5 files changed, 37 insertions(+), 25 deletions(-)

diff --git a/rust/macros/helpers.rs b/rust/macros/helpers.rs
index cdc7dc6135d2..cf7ad950dc1e 100644
--- a/rust/macros/helpers.rs
+++ b/rust/macros/helpers.rs
@@ -18,10 +18,16 @@ pub(crate) fn try_literal(it: &mut token_stream::IntoIter) -> Option<String> {
     }
 }
 
-pub(crate) fn try_byte_string(it: &mut token_stream::IntoIter) -> Option<String> {
-    try_literal(it).and_then(|byte_string| {
-        if byte_string.starts_with("b\"") && byte_string.ends_with('\"') {
-            Some(byte_string[2..byte_string.len() - 1].to_string())
+pub(crate) fn try_string(it: &mut token_stream::IntoIter) -> Option<String> {
+    try_literal(it).and_then(|string| {
+        if string.starts_with('\"') && string.ends_with('\"') {
+            let content = &string[1..string.len() - 1];
+            if content.contains('\\') {
+                panic!("Escape sequences in string literals not yet handled");
+            }
+            Some(content.to_string())
+        } else if string.starts_with("r\"") {
+            panic!("Raw string literals are not yet handled");
         } else {
             None
         }
@@ -40,8 +46,14 @@ pub(crate) fn expect_punct(it: &mut token_stream::IntoIter) -> char {
     }
 }
 
-pub(crate) fn expect_byte_string(it: &mut token_stream::IntoIter) -> String {
-    try_byte_string(it).expect("Expected byte string")
+pub(crate) fn expect_string(it: &mut token_stream::IntoIter) -> String {
+    try_string(it).expect("Expected string")
+}
+
+pub(crate) fn expect_string_ascii(it: &mut token_stream::IntoIter) -> String {
+    let string = try_string(it).expect("Expected string");
+    assert!(string.is_ascii(), "Expected ASCII string");
+    string
 }
 
 pub(crate) fn expect_end(it: &mut token_stream::IntoIter) {
diff --git a/rust/macros/lib.rs b/rust/macros/lib.rs
index e40caaf0a656..c1d385e345b9 100644
--- a/rust/macros/lib.rs
+++ b/rust/macros/lib.rs
@@ -25,20 +25,20 @@ use proc_macro::TokenStream;
 ///
 /// module!{
 ///     type: MyModule,
-///     name: b"my_kernel_module",
-///     author: b"Rust for Linux Contributors",
-///     description: b"My very own kernel module!",
-///     license: b"GPL",
+///     name: "my_kernel_module",
+///     author: "Rust for Linux Contributors",
+///     description: "My very own kernel module!",
+///     license: "GPL",
 ///     params: {
 ///        my_i32: i32 {
 ///            default: 42,
 ///            permissions: 0o000,
-///            description: b"Example of i32",
+///            description: "Example of i32",
 ///        },
 ///        writeable_i32: i32 {
 ///            default: 42,
 ///            permissions: 0o644,
-///            description: b"Example of i32",
+///            description: "Example of i32",
 ///        },
 ///    },
 /// }
diff --git a/rust/macros/module.rs b/rust/macros/module.rs
index 186a5b8be23c..a7e363c2b044 100644
--- a/rust/macros/module.rs
+++ b/rust/macros/module.rs
@@ -108,11 +108,11 @@ impl ModuleInfo {
 
             match key.as_str() {
                 "type" => info.type_ = expect_ident(it),
-                "name" => info.name = expect_byte_string(it),
-                "author" => info.author = Some(expect_byte_string(it)),
-                "description" => info.description = Some(expect_byte_string(it)),
-                "license" => info.license = expect_byte_string(it),
-                "alias" => info.alias = Some(expect_byte_string(it)),
+                "name" => info.name = expect_string_ascii(it),
+                "author" => info.author = Some(expect_string(it)),
+                "description" => info.description = Some(expect_string(it)),
+                "license" => info.license = expect_string_ascii(it),
+                "alias" => info.alias = Some(expect_string_ascii(it)),
                 _ => panic!(
                     "Unknown key \"{}\". Valid keys are: {:?}.",
                     key, EXPECTED_KEYS
diff --git a/samples/rust/rust_minimal.rs b/samples/rust/rust_minimal.rs
index 54ad17685742..dc05f4bbe27e 100644
--- a/samples/rust/rust_minimal.rs
+++ b/samples/rust/rust_minimal.rs
@@ -6,10 +6,10 @@ use kernel::prelude::*;
 
 module! {
     type: RustMinimal,
-    name: b"rust_minimal",
-    author: b"Rust for Linux Contributors",
-    description: b"Rust minimal sample",
-    license: b"GPL",
+    name: "rust_minimal",
+    author: "Rust for Linux Contributors",
+    description: "Rust minimal sample",
+    license: "GPL",
 }
 
 struct RustMinimal {
diff --git a/samples/rust/rust_print.rs b/samples/rust/rust_print.rs
index 09f737790f3f..8b39d9cef6d1 100644
--- a/samples/rust/rust_print.rs
+++ b/samples/rust/rust_print.rs
@@ -7,10 +7,10 @@ use kernel::prelude::*;
 
 module! {
     type: RustPrint,
-    name: b"rust_print",
-    author: b"Rust for Linux Contributors",
-    description: b"Rust printing macros sample",
-    license: b"GPL",
+    name: "rust_print",
+    author: "Rust for Linux Contributors",
+    description: "Rust printing macros sample",
+    license: "GPL",
 }
 
 struct RustPrint;
-- 
2.38.1

