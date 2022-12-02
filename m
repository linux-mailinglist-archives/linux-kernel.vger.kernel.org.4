Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B32E9640A6A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 17:17:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233858AbiLBQRU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 11:17:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233883AbiLBQQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 11:16:46 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2655BAD9AC;
        Fri,  2 Dec 2022 08:16:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AA01862321;
        Fri,  2 Dec 2022 16:16:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D479AC4314F;
        Fri,  2 Dec 2022 16:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669997777;
        bh=lSrHt+F2Ze+/0shcXyGqT2iYHkhHUzJS18BpgwZFKfQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gFYHA5/tQJfrLY2tIEHdQ9SHhxkxhRakBLeDbRT0zxpv7dx9kQLQtuJazH6m6aVXf
         gnKkepKJPuKvfcuB+2X2jvp5nyDj+F6CRXRHzsc9xxdl5fD+uqVQACAuL+HBDYLfhA
         cZws+wpA/mtCbx2+K8HrvbpURAtnDTV7VEDKZmDKZ+GlnUV1NunRfGyBdTCeVwecce
         8S5JEe5HR6yPWnaeesWeC+sKAqzLPdF6sjP5TIWLeSBKu/ynoy1Pzr3fN4gkdD3U9B
         c8n9On8iuaxdeTN4ShAFSbhU3ezYZ6NvicvI+dCMmS9AWRHvnTW38tF1CZJ1SOoHLZ
         /KyNk796JJ6PQ==
From:   ojeda@kernel.org
To:     Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Morgan Bartlett <mjmouse9999@gmail.com>
Subject: [PATCH v2 17/28] rust: str: implement several traits for `CStr`
Date:   Fri,  2 Dec 2022 17:14:48 +0100
Message-Id: <20221202161502.385525-18-ojeda@kernel.org>
In-Reply-To: <20221202161502.385525-1-ojeda@kernel.org>
References: <20221202161502.385525-1-ojeda@kernel.org>
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

Implement `Debug`, `Display`, `Deref` (into `BStr`), `AsRef<BStr>`
and a set of `Index<...>` traits.

This makes it `CStr` more convenient to use (and closer to `str`).

Co-developed-by: Alex Gaynor <alex.gaynor@gmail.com>
Signed-off-by: Alex Gaynor <alex.gaynor@gmail.com>
Co-developed-by: Morgan Bartlett <mjmouse9999@gmail.com>
Signed-off-by: Morgan Bartlett <mjmouse9999@gmail.com>
Signed-off-by: Gary Guo <gary@garyguo.net>
[Reworded, adapted for upstream and applied latest changes]
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 rust/kernel/str.rs | 124 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 123 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
index d66565f92f71..11d297c1a61c 100644
--- a/rust/kernel/str.rs
+++ b/rust/kernel/str.rs
@@ -2,7 +2,8 @@
 
 //! String representations.
 
-use core::fmt;
+use core::fmt::{self, Write};
+use core::ops::{self, Deref, Index};
 
 use crate::{
     bindings,
@@ -199,6 +200,127 @@ impl CStr {
     }
 }
 
+impl fmt::Display for CStr {
+    /// Formats printable ASCII characters, escaping the rest.
+    ///
+    /// ```
+    /// # use kernel::c_str;
+    /// # use kernel::str::CStr;
+    /// # use kernel::str::CString;
+    /// let penguin = c_str!("🐧");
+    /// let s = CString::try_from_fmt(fmt!("{}", penguin)).unwrap();
+    /// assert_eq!(s.as_bytes_with_nul(), "\\xf0\\x9f\\x90\\xa7\0".as_bytes());
+    ///
+    /// let ascii = c_str!("so \"cool\"");
+    /// let s = CString::try_from_fmt(fmt!("{}", ascii)).unwrap();
+    /// assert_eq!(s.as_bytes_with_nul(), "so \"cool\"\0".as_bytes());
+    /// ```
+    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
+        for &c in self.as_bytes() {
+            if (0x20..0x7f).contains(&c) {
+                // Printable character.
+                f.write_char(c as char)?;
+            } else {
+                write!(f, "\\x{:02x}", c)?;
+            }
+        }
+        Ok(())
+    }
+}
+
+impl fmt::Debug for CStr {
+    /// Formats printable ASCII characters with a double quote on either end, escaping the rest.
+    ///
+    /// ```
+    /// # use kernel::c_str;
+    /// # use kernel::str::CStr;
+    /// # use kernel::str::CString;
+    /// let penguin = c_str!("🐧");
+    /// let s = CString::try_from_fmt(fmt!("{:?}", penguin)).unwrap();
+    /// assert_eq!(s.as_bytes_with_nul(), "\"\\xf0\\x9f\\x90\\xa7\"\0".as_bytes());
+    ///
+    /// // Embedded double quotes are escaped.
+    /// let ascii = c_str!("so \"cool\"");
+    /// let s = CString::try_from_fmt(fmt!("{:?}", ascii)).unwrap();
+    /// assert_eq!(s.as_bytes_with_nul(), "\"so \\\"cool\\\"\"\0".as_bytes());
+    /// ```
+    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
+        f.write_str("\"")?;
+        for &c in self.as_bytes() {
+            match c {
+                // Printable characters.
+                b'\"' => f.write_str("\\\"")?,
+                0x20..=0x7e => f.write_char(c as char)?,
+                _ => write!(f, "\\x{:02x}", c)?,
+            }
+        }
+        f.write_str("\"")
+    }
+}
+
+impl AsRef<BStr> for CStr {
+    #[inline]
+    fn as_ref(&self) -> &BStr {
+        self.as_bytes()
+    }
+}
+
+impl Deref for CStr {
+    type Target = BStr;
+
+    #[inline]
+    fn deref(&self) -> &Self::Target {
+        self.as_bytes()
+    }
+}
+
+impl Index<ops::RangeFrom<usize>> for CStr {
+    type Output = CStr;
+
+    #[inline]
+    fn index(&self, index: ops::RangeFrom<usize>) -> &Self::Output {
+        // Delegate bounds checking to slice.
+        // Assign to _ to mute clippy's unnecessary operation warning.
+        let _ = &self.as_bytes()[index.start..];
+        // SAFETY: We just checked the bounds.
+        unsafe { Self::from_bytes_with_nul_unchecked(&self.0[index.start..]) }
+    }
+}
+
+impl Index<ops::RangeFull> for CStr {
+    type Output = CStr;
+
+    #[inline]
+    fn index(&self, _index: ops::RangeFull) -> &Self::Output {
+        self
+    }
+}
+
+mod private {
+    use core::ops;
+
+    // Marker trait for index types that can be forward to `BStr`.
+    pub trait CStrIndex {}
+
+    impl CStrIndex for usize {}
+    impl CStrIndex for ops::Range<usize> {}
+    impl CStrIndex for ops::RangeInclusive<usize> {}
+    impl CStrIndex for ops::RangeToInclusive<usize> {}
+}
+
+impl<Idx> Index<Idx> for CStr
+where
+    Idx: private::CStrIndex,
+    BStr: Index<Idx>,
+{
+    type Output = <BStr as Index<Idx>>::Output;
+
+    #[inline]
+    fn index(&self, index: Idx) -> &Self::Output {
+        &self.as_bytes()[index]
+    }
+}
+
 /// Allows formatting of [`fmt::Arguments`] into a raw buffer.
 ///
 /// It does not fail if callers write past the end of the buffer so that they can calculate the
-- 
2.38.1

