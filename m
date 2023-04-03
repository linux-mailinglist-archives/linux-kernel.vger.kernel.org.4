Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAA206D412F
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 11:50:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231860AbjDCJuC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 05:50:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232391AbjDCJta (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 05:49:30 -0400
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A13012BFF;
        Mon,  3 Apr 2023 02:48:44 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: linasend@asahilina.net)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 1D0B941E64;
        Mon,  3 Apr 2023 09:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=asahilina.net;
        s=default; t=1680515319;
        bh=FFczrsn4BHG2jGRMZ9qqibn2umHy3oP8Nzgbsa+sfGQ=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc;
        b=W5xf2sVK+gyRZ9offnkTD/0SpWZxA5EunI4QAXKhn1dXM/Q7aRhUxCFzR2EaJCqxG
         IVGOR7TxkLrmH1QxsVJzZgGlTAdkL3wIaXF6P0eFjkyMMYKcu6NO3EYoBMlqnSBPvF
         23N3SQkWxWLeh9S4DF3jiZmgPToZke2PTd8ImbVisGEYCuVHbkjVRueDW8wwcijZ41
         vrCz3+HLwjyS1TQuu1l87I2y0YBsZeJeH4Dr9EqRyopO5XoBPoDe0HFBgDAOIMazO3
         vh2YfqtyH0+G6hJBDKpxAaLIgFtMNmDmRezcDpOUb47v2XE+RtcE7/BjBa6szHNMQw
         zOWXkcjq/UjIA==
From:   Asahi Lina <lina@asahilina.net>
Date:   Mon, 03 Apr 2023 18:48:14 +0900
Subject: [PATCH v3 5/6] rust: error: Add a helper to convert a C ERR_PTR to
 a `Result`
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230224-rust-error-v3-5-03779bddc02b@asahilina.net>
References: <20230224-rust-error-v3-0-03779bddc02b@asahilina.net>
In-Reply-To: <20230224-rust-error-v3-0-03779bddc02b@asahilina.net>
To:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Sven Van Asbroeck <thesven73@gmail.com>
Cc:     Fox Chen <foxhlchen@gmail.com>,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        asahi@lists.linux.dev, Asahi Lina <lina@asahilina.net>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1680515295; l=4192;
 i=lina@asahilina.net; s=20230221; h=from:subject:message-id;
 bh=ISUvnAT4TyiogMaTmuiS16KnnBXAUwEeRJutcySkWLo=;
 b=IELaoMg8SSQorXRnN2gvxejtyyJxGzy0urJANcFWVMLquvf5coqJVqSHlHd8rPd+7VCCKIaGZ
 K8jx70ApDMRBPAvtOeaih1oh6vfnPfEOrxIIt9D2UQErxcmbWNPEUSu
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

From: Sven Van Asbroeck <thesven73@gmail.com>

Some kernel C API functions return a pointer which embeds an optional
`errno`. Callers are supposed to check the returned pointer with
`IS_ERR()` and if this returns `true`, retrieve the `errno` using
`PTR_ERR()`.

Create a Rust helper function to implement the Rust equivalent:
transform a `*mut T` to `Result<*mut T>`.

Lina: Imported from rust-for-linux/linux, with subsequent refactoring
and contributions squashed in and attributed below. Renamed the function
to from_err_ptr().

Co-developed-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Co-developed-by: Miguel Ojeda <ojeda@kernel.org>
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
Co-developed-by: Fox Chen <foxhlchen@gmail.com>
Signed-off-by: Fox Chen <foxhlchen@gmail.com>
Co-developed-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Sven Van Asbroeck <thesven73@gmail.com>
Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Signed-off-by: Asahi Lina <lina@asahilina.net>
---
 rust/helpers.c       | 12 ++++++++++++
 rust/kernel/error.rs | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 61 insertions(+)

diff --git a/rust/helpers.c b/rust/helpers.c
index 89f4cd1e0df3..04b9be46e887 100644
--- a/rust/helpers.c
+++ b/rust/helpers.c
@@ -53,6 +53,18 @@ __force void *rust_helper_ERR_PTR(long err)
 }
 EXPORT_SYMBOL_GPL(rust_helper_ERR_PTR);
 
+bool rust_helper_IS_ERR(__force const void *ptr)
+{
+	return IS_ERR(ptr);
+}
+EXPORT_SYMBOL_GPL(rust_helper_IS_ERR);
+
+long rust_helper_PTR_ERR(__force const void *ptr)
+{
+	return PTR_ERR(ptr);
+}
+EXPORT_SYMBOL_GPL(rust_helper_PTR_ERR);
+
 /*
  * We use `bindgen`'s `--size_t-is-usize` option to bind the C `size_t` type
  * as the Rust `usize` type, so we can use it in contexts where Rust
diff --git a/rust/kernel/error.rs b/rust/kernel/error.rs
index e8697ad6b62e..67637b874267 100644
--- a/rust/kernel/error.rs
+++ b/rust/kernel/error.rs
@@ -188,3 +188,52 @@ pub fn to_result(err: core::ffi::c_int) -> Result {
         Ok(())
     }
 }
+
+/// Transform a kernel "error pointer" to a normal pointer.
+///
+/// Some kernel C API functions return an "error pointer" which optionally
+/// embeds an `errno`. Callers are supposed to check the returned pointer
+/// for errors. This function performs the check and converts the "error pointer"
+/// to a normal pointer in an idiomatic fashion.
+///
+/// # Examples
+///
+/// ```ignore
+/// # use kernel::from_err_ptr;
+/// # use kernel::bindings;
+/// fn devm_platform_ioremap_resource(
+///     pdev: &mut PlatformDevice,
+///     index: u32,
+/// ) -> Result<*mut core::ffi::c_void> {
+///     // SAFETY: FFI call.
+///     unsafe {
+///         from_err_ptr(bindings::devm_platform_ioremap_resource(
+///             pdev.to_ptr(),
+///             index,
+///         ))
+///     }
+/// }
+/// ```
+// TODO: Remove `dead_code` marker once an in-kernel client is available.
+#[allow(dead_code)]
+pub(crate) fn from_err_ptr<T>(ptr: *mut T) -> Result<*mut T> {
+    // CAST: Casting a pointer to `*const core::ffi::c_void` is always valid.
+    let const_ptr: *const core::ffi::c_void = ptr.cast();
+    // SAFETY: The FFI function does not deref the pointer.
+    if unsafe { bindings::IS_ERR(const_ptr) } {
+        // SAFETY: The FFI function does not deref the pointer.
+        let err = unsafe { bindings::PTR_ERR(const_ptr) };
+        // CAST: If `IS_ERR()` returns `true`,
+        // then `PTR_ERR()` is guaranteed to return a
+        // negative value greater-or-equal to `-bindings::MAX_ERRNO`,
+        // which always fits in an `i16`, as per the invariant above.
+        // And an `i16` always fits in an `i32`. So casting `err` to
+        // an `i32` can never overflow, and is always valid.
+        //
+        // SAFETY: `IS_ERR()` ensures `err` is a
+        // negative value greater-or-equal to `-bindings::MAX_ERRNO`.
+        #[allow(clippy::unnecessary_cast)]
+        return Err(unsafe { Error::from_errno_unchecked(err as core::ffi::c_int) });
+    }
+    Ok(ptr)
+}

-- 
2.40.0

