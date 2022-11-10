Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75865624754
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 17:44:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232096AbiKJQoT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 11:44:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232373AbiKJQnb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 11:43:31 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BEF045EFF;
        Thu, 10 Nov 2022 08:43:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D91E760E75;
        Thu, 10 Nov 2022 16:43:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14143C433D7;
        Thu, 10 Nov 2022 16:43:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668098586;
        bh=JUlBWWC3mMeuYO9e7TQWTKj0jrpvH43QY5gJsfCQcio=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l91c9VzvwUfPRWQ/5oYRmYOEZYEGPOs+6lKTCG0JBFfHlrVMwP0BBia1scemi5Iqf
         59GVrJAxhXxeAojfncKkdLn4vHxghsRx5CgqR8mqxfy9a6nC5++CSruYW6j8oWvDAF
         Xa6glWaXbztW7ONXVZHICeMKiIBIDU5+OyoRXK8enihvl094nEDy0NHP82Uo/DbmL+
         CR/9KrhMbUVcIBqjYgSv6KxOHifWOHiCsacri6hj2XsyqDKMVXgqGsEZ/hcRd42eO7
         HRBsA1dmO3VX1cmKR45XLa8YMNr6b4SqxF85Uxl933gcBnoqnSUAWvqnbgYCyXAm8h
         5L99GCO8s7QfQ==
From:   Miguel Ojeda <ojeda@kernel.org>
To:     Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Milan Landaverde <milan@mdaverde.com>
Subject: [PATCH v1 16/28] rust: str: add `CStr` type
Date:   Thu, 10 Nov 2022 17:41:28 +0100
Message-Id: <20221110164152.26136-17-ojeda@kernel.org>
In-Reply-To: <20221110164152.26136-1-ojeda@kernel.org>
References: <20221110164152.26136-1-ojeda@kernel.org>
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

From: Gary Guo <gary@garyguo.net>

Add the `CStr` type, which is a borrowed string that is guaranteed
to have exactly one `NUL` byte, which is at the end.

It is used for interoperability with kernel APIs that take C strings.

Add it to the prelude too.

Co-developed-by: Alex Gaynor <alex.gaynor@gmail.com>
Signed-off-by: Alex Gaynor <alex.gaynor@gmail.com>
Co-developed-by: Milan Landaverde <milan@mdaverde.com>
Signed-off-by: Milan Landaverde <milan@mdaverde.com>
Signed-off-by: Gary Guo <gary@garyguo.net>
[Reworded, adapted for upstream and applied latest changes]
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 rust/kernel/prelude.rs |   2 +-
 rust/kernel/str.rs     | 169 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 170 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/prelude.rs b/rust/kernel/prelude.rs
index 1e08b08e9420..89c2c9f4e7a7 100644
--- a/rust/kernel/prelude.rs
+++ b/rust/kernel/prelude.rs
@@ -21,4 +21,4 @@ pub use super::{pr_alert, pr_crit, pr_debug, pr_emerg, pr_err, pr_info, pr_notic
 
 pub use super::error::{code::*, Error, Result};
 
-pub use super::ThisModule;
+pub use super::{str::CStr, ThisModule};
diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
index 95eb757c619d..d66565f92f71 100644
--- a/rust/kernel/str.rs
+++ b/rust/kernel/str.rs
@@ -4,6 +4,11 @@
 
 use core::fmt;
 
+use crate::{
+    bindings,
+    error::{code::*, Error},
+};
+
 /// Byte string without UTF-8 validity guarantee.
 ///
 /// `BStr` is simply an alias to `[u8]`, but has a more evident semantical meaning.
@@ -30,6 +35,170 @@ macro_rules! b_str {
     }};
 }
 
+/// Possible errors when using conversion functions in [`CStr`].
+#[derive(Debug, Clone, Copy)]
+pub enum CStrConvertError {
+    /// Supplied bytes contain an interior `NUL`.
+    InteriorNul,
+
+    /// Supplied bytes are not terminated by `NUL`.
+    NotNulTerminated,
+}
+
+impl From<CStrConvertError> for Error {
+    #[inline]
+    fn from(_: CStrConvertError) -> Error {
+        EINVAL
+    }
+}
+
+/// A string that is guaranteed to have exactly one `NUL` byte, which is at the
+/// end.
+///
+/// Used for interoperability with kernel APIs that take C strings.
+#[repr(transparent)]
+pub struct CStr([u8]);
+
+impl CStr {
+    /// Returns the length of this string excluding `NUL`.
+    #[inline]
+    pub const fn len(&self) -> usize {
+        self.len_with_nul() - 1
+    }
+
+    /// Returns the length of this string with `NUL`.
+    #[inline]
+    pub const fn len_with_nul(&self) -> usize {
+        // SAFETY: This is one of the invariant of `CStr`.
+        // We add a `unreachable_unchecked` here to hint the optimizer that
+        // the value returned from this function is non-zero.
+        if self.0.is_empty() {
+            unsafe { core::hint::unreachable_unchecked() };
+        }
+        self.0.len()
+    }
+
+    /// Returns `true` if the string only includes `NUL`.
+    #[inline]
+    pub const fn is_empty(&self) -> bool {
+        self.len() == 0
+    }
+
+    /// Wraps a raw C string pointer.
+    ///
+    /// # Safety
+    ///
+    /// `ptr` must be a valid pointer to a `NUL`-terminated C string, and it must
+    /// last at least `'a`. When `CStr` is alive, the memory pointed by `ptr`
+    /// must not be mutated.
+    #[inline]
+    pub unsafe fn from_char_ptr<'a>(ptr: *const core::ffi::c_char) -> &'a Self {
+        // SAFETY: The safety precondition guarantees `ptr` is a valid pointer
+        // to a `NUL`-terminated C string.
+        let len = unsafe { bindings::strlen(ptr) } + 1;
+        // SAFETY: Lifetime guaranteed by the safety precondition.
+        let bytes = unsafe { core::slice::from_raw_parts(ptr as _, len as _) };
+        // SAFETY: As `len` is returned by `strlen`, `bytes` does not contain interior `NUL`.
+        // As we have added 1 to `len`, the last byte is known to be `NUL`.
+        unsafe { Self::from_bytes_with_nul_unchecked(bytes) }
+    }
+
+    /// Creates a [`CStr`] from a `[u8]`.
+    ///
+    /// The provided slice must be `NUL`-terminated, does not contain any
+    /// interior `NUL` bytes.
+    pub const fn from_bytes_with_nul(bytes: &[u8]) -> Result<&Self, CStrConvertError> {
+        if bytes.is_empty() {
+            return Err(CStrConvertError::NotNulTerminated);
+        }
+        if bytes[bytes.len() - 1] != 0 {
+            return Err(CStrConvertError::NotNulTerminated);
+        }
+        let mut i = 0;
+        // `i + 1 < bytes.len()` allows LLVM to optimize away bounds checking,
+        // while it couldn't optimize away bounds checks for `i < bytes.len() - 1`.
+        while i + 1 < bytes.len() {
+            if bytes[i] == 0 {
+                return Err(CStrConvertError::InteriorNul);
+            }
+            i += 1;
+        }
+        // SAFETY: We just checked that all properties hold.
+        Ok(unsafe { Self::from_bytes_with_nul_unchecked(bytes) })
+    }
+
+    /// Creates a [`CStr`] from a `[u8]` without performing any additional
+    /// checks.
+    ///
+    /// # Safety
+    ///
+    /// `bytes` *must* end with a `NUL` byte, and should only have a single
+    /// `NUL` byte (or the string will be truncated).
+    #[inline]
+    pub const unsafe fn from_bytes_with_nul_unchecked(bytes: &[u8]) -> &CStr {
+        // SAFETY: Properties of `bytes` guaranteed by the safety precondition.
+        unsafe { core::mem::transmute(bytes) }
+    }
+
+    /// Returns a C pointer to the string.
+    #[inline]
+    pub const fn as_char_ptr(&self) -> *const core::ffi::c_char {
+        self.0.as_ptr() as _
+    }
+
+    /// Convert the string to a byte slice without the trailing 0 byte.
+    #[inline]
+    pub fn as_bytes(&self) -> &[u8] {
+        &self.0[..self.len()]
+    }
+
+    /// Convert the string to a byte slice containing the trailing 0 byte.
+    #[inline]
+    pub const fn as_bytes_with_nul(&self) -> &[u8] {
+        &self.0
+    }
+
+    /// Yields a [`&str`] slice if the [`CStr`] contains valid UTF-8.
+    ///
+    /// If the contents of the [`CStr`] are valid UTF-8 data, this
+    /// function will return the corresponding [`&str`] slice. Otherwise,
+    /// it will return an error with details of where UTF-8 validation failed.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// # use kernel::str::CStr;
+    /// let cstr = CStr::from_bytes_with_nul(b"foo\0").unwrap();
+    /// assert_eq!(cstr.to_str(), Ok("foo"));
+    /// ```
+    #[inline]
+    pub fn to_str(&self) -> Result<&str, core::str::Utf8Error> {
+        core::str::from_utf8(self.as_bytes())
+    }
+
+    /// Unsafely convert this [`CStr`] into a [`&str`], without checking for
+    /// valid UTF-8.
+    ///
+    /// # Safety
+    ///
+    /// The contents must be valid UTF-8.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// # use kernel::c_str;
+    /// # use kernel::str::CStr;
+    /// // SAFETY: String literals are guaranteed to be valid UTF-8
+    /// // by the Rust compiler.
+    /// let bar = c_str!("ツ");
+    /// assert_eq!(unsafe { bar.as_str_unchecked() }, "ツ");
+    /// ```
+    #[inline]
+    pub unsafe fn as_str_unchecked(&self) -> &str {
+        unsafe { core::str::from_utf8_unchecked(self.as_bytes()) }
+    }
+}
+
 /// Allows formatting of [`fmt::Arguments`] into a raw buffer.
 ///
 /// It does not fail if callers write past the end of the buffer so that they can calculate the
-- 
2.38.1

