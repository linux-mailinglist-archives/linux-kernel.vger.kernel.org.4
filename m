Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB782624758
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 17:44:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232367AbiKJQon (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 11:44:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232211AbiKJQoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 11:44:11 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEFAF48742;
        Thu, 10 Nov 2022 08:43:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6A92FB8224F;
        Thu, 10 Nov 2022 16:43:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24135C433D6;
        Thu, 10 Nov 2022 16:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668098601;
        bh=VGz/Q7gY5LCscMIH+BUom4dYaRe94hPiAPnwG7cHlrU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HurCQzjaTx4LXSUf0fsQCh5zspRKv/suYkpVIO8l7dXLwUCfRBtmyoxFxLHqBTlEC
         tI3+A1Oh+VcLnNjO9B0fBuY+h4jiHHFXY0g2L4K3v+vsK3nQ3W92AgnWMTdK5I6IUb
         OL3jrf2ccL3+PtY/e/P3Pd1/KhImoVq+8SMLBYRSb1mDSm19ZMORxQihNNSfR/cS/i
         WjKbMwXa91am0kscJ0UQQwrL72rposHYxDuO2ZHtJDqKImrUvO/E9J9KjAOITc47xi
         wL3wJy0UQc9z2Of54UowHj6Hvx1RigamLh/dK5TL4h6bb7oVlsBUhpTsaPvKJ3pT5/
         4oClzLVvBIENw==
From:   Miguel Ojeda <ojeda@kernel.org>
To:     Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev
Subject: [PATCH v1 21/28] rust: str: add `CString` type
Date:   Thu, 10 Nov 2022 17:41:33 +0100
Message-Id: <20221110164152.26136-22-ojeda@kernel.org>
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

From: Wedson Almeida Filho <wedsonaf@gmail.com>

Add the `CString` type, which is an owned string that is guaranteed
to have exactly one `NUL` byte at the end, i.e. the owned equivalent
to `CStr` introduced earlier.

It is used for interoperability with kernel APIs that take C strings.

In order to do so, implement the `RawFormatter::new()` constructor
and the `RawFormatter::bytes_written()` method as well.

Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
[Reworded, adapted for upstream and applied latest changes]
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 rust/kernel/str.rs | 91 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 89 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
index db6473db31c6..877148b77e71 100644
--- a/rust/kernel/str.rs
+++ b/rust/kernel/str.rs
@@ -2,6 +2,7 @@
 
 //! String representations.
 
+use alloc::vec::Vec;
 use core::fmt::{self, Write};
 use core::ops::{self, Deref, Index};
 
@@ -393,13 +394,22 @@ mod tests {
 /// is less than `end`.
 pub(crate) struct RawFormatter {
     // Use `usize` to use `saturating_*` functions.
-    #[allow(dead_code)]
     beg: usize,
     pos: usize,
     end: usize,
 }
 
 impl RawFormatter {
+    /// Creates a new instance of [`RawFormatter`] with an empty buffer.
+    fn new() -> Self {
+        // INVARIANT: The buffer is empty, so the region that needs to be writable is empty.
+        Self {
+            beg: 0,
+            pos: 0,
+            end: 0,
+        }
+    }
+
     /// Creates a new instance of [`RawFormatter`] with the given buffer pointers.
     ///
     /// # Safety
@@ -438,6 +448,11 @@ impl RawFormatter {
     pub(crate) fn pos(&self) -> *mut u8 {
         self.pos as _
     }
+
+    /// Return the number of bytes written to the formatter.
+    pub(crate) fn bytes_written(&self) -> usize {
+        self.pos - self.beg
+    }
 }
 
 impl fmt::Write for RawFormatter {
@@ -478,7 +493,6 @@ impl Formatter {
     ///
     /// The memory region starting at `buf` and extending for `len` bytes must be valid for writes
     /// for the lifetime of the returned [`Formatter`].
-    #[allow(dead_code)]
     pub(crate) unsafe fn from_buffer(buf: *mut u8, len: usize) -> Self {
         // SAFETY: The safety requirements of this function satisfy those of the callee.
         Self(unsafe { RawFormatter::from_buffer(buf, len) })
@@ -505,3 +519,76 @@ impl fmt::Write for Formatter {
         }
     }
 }
+
+/// An owned string that is guaranteed to have exactly one `NUL` byte, which is at the end.
+///
+/// Used for interoperability with kernel APIs that take C strings.
+///
+/// # Invariants
+///
+/// The string is always `NUL`-terminated and contains no other `NUL` bytes.
+///
+/// # Examples
+///
+/// ```
+/// use kernel::str::CString;
+///
+/// let s = CString::try_from_fmt(fmt!("{}{}{}", "abc", 10, 20)).unwrap();
+/// assert_eq!(s.as_bytes_with_nul(), "abc1020\0".as_bytes());
+///
+/// let tmp = "testing";
+/// let s = CString::try_from_fmt(fmt!("{tmp}{}", 123)).unwrap();
+/// assert_eq!(s.as_bytes_with_nul(), "testing123\0".as_bytes());
+///
+/// // This fails because it has an embedded `NUL` byte.
+/// let s = CString::try_from_fmt(fmt!("a\0b{}", 123));
+/// assert_eq!(s.is_ok(), false);
+/// ```
+pub struct CString {
+    buf: Vec<u8>,
+}
+
+impl CString {
+    /// Creates an instance of [`CString`] from the given formatted arguments.
+    pub fn try_from_fmt(args: fmt::Arguments<'_>) -> Result<Self, Error> {
+        // Calculate the size needed (formatted string plus `NUL` terminator).
+        let mut f = RawFormatter::new();
+        f.write_fmt(args)?;
+        f.write_str("\0")?;
+        let size = f.bytes_written();
+
+        // Allocate a vector with the required number of bytes, and write to it.
+        let mut buf = Vec::try_with_capacity(size)?;
+        // SAFETY: The buffer stored in `buf` is at least of size `size` and is valid for writes.
+        let mut f = unsafe { Formatter::from_buffer(buf.as_mut_ptr(), size) };
+        f.write_fmt(args)?;
+        f.write_str("\0")?;
+
+        // SAFETY: The number of bytes that can be written to `f` is bounded by `size`, which is
+        // `buf`'s capacity. The contents of the buffer have been initialised by writes to `f`.
+        unsafe { buf.set_len(f.bytes_written()) };
+
+        // Check that there are no `NUL` bytes before the end.
+        // SAFETY: The buffer is valid for read because `f.bytes_written()` is bounded by `size`
+        // (which the minimum buffer size) and is non-zero (we wrote at least the `NUL` terminator)
+        // so `f.bytes_written() - 1` doesn't underflow.
+        let ptr = unsafe { bindings::memchr(buf.as_ptr().cast(), 0, (f.bytes_written() - 1) as _) };
+        if !ptr.is_null() {
+            return Err(EINVAL);
+        }
+
+        // INVARIANT: We wrote the `NUL` terminator and checked above that no other `NUL` bytes
+        // exist in the buffer.
+        Ok(Self { buf })
+    }
+}
+
+impl Deref for CString {
+    type Target = CStr;
+
+    fn deref(&self) -> &Self::Target {
+        // SAFETY: The type invariants guarantee that the string is `NUL`-terminated and that no
+        // other `NUL` bytes exist.
+        unsafe { CStr::from_bytes_with_nul_unchecked(self.buf.as_slice()) }
+    }
+}
-- 
2.38.1

