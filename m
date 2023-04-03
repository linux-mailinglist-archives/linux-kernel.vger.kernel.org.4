Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B5A16D40C0
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 11:35:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232158AbjDCJfn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 05:35:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231267AbjDCJfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 05:35:13 -0400
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40A581025C;
        Mon,  3 Apr 2023 02:34:33 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: linasend@asahilina.net)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 4CFCB423BA;
        Mon,  3 Apr 2023 09:34:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=asahilina.net;
        s=default; t=1680514445;
        bh=SDM5ek/CE6FiKqreYBHfMz3sZGIrU/VxZUpt63EoDg4=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc;
        b=LmOYmscjE3LwgLD9P9o4Ci8hz4+jSYPZvRUlSSUpCYBmsCQCqPNounJCXWtPyd3Dc
         XoW9EgpI5XYSLM8a5gJlnfmYOGj2DYah5413Ob113FUniByPvTfA3GacsYCOnGqmV2
         E+byz0Y0cL6xq6/M7DHJ5exwj5NmWv1gRXTL4J8x6nnOIQdH9QUJgthWPZ6hNgPjxu
         w+Q+uSfS12tTSgMTjtHkZkc3xvSFycNcC+lb+WoIO16mnQKr2rcWf8t5nIf3WhDTgA
         zmUwWUoX7ahUQp/sIvR8q3pkFv7G0JAi97dUc0s4Dx9Gh6eB2OMyb8W7VT9A6377OP
         WK9v6fwhcVoHg==
From:   Asahi Lina <lina@asahilina.net>
Date:   Mon, 03 Apr 2023 18:33:53 +0900
Subject: [PATCH v2 2/2] rust: ioctl: Add ioctl number manipulation
 functions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230329-rust-uapi-v2-2-bca5fb4d4a12@asahilina.net>
References: <20230329-rust-uapi-v2-0-bca5fb4d4a12@asahilina.net>
In-Reply-To: <20230329-rust-uapi-v2-0-bca5fb4d4a12@asahilina.net>
To:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
        linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
        asahi@lists.linux.dev, Asahi Lina <lina@asahilina.net>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1680514434; l=3343;
 i=lina@asahilina.net; s=20230221; h=from:subject:message-id;
 bh=SDM5ek/CE6FiKqreYBHfMz3sZGIrU/VxZUpt63EoDg4=;
 b=LHDkVMUjIhnbPwKIIJMWnc8W7YRkmeOb6N304PCQzDppQzdlX/TcgenWDUJDtfPsp/sGbVj48
 cpNbG13R5njA1zH3eTmFV8FL4Uv0D/p2BKjs2k2w2uQJ+7d9J4S8GOm
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

Add simple 1:1 wrappers of the C ioctl number manipulation functions.
Since these are macros we cannot bindgen them directly, and since they
should be usable in const context we cannot use helper wrappers, so
we'll have to reimplement them in Rust. Thankfully, the C headers do
declare defines for the relevant bitfield positions, so we don't need
to duplicate that.

Signed-off-by: Asahi Lina <lina@asahilina.net>
---
 rust/kernel/ioctl.rs | 71 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 rust/kernel/lib.rs   |  1 +
 2 files changed, 72 insertions(+)

diff --git a/rust/kernel/ioctl.rs b/rust/kernel/ioctl.rs
new file mode 100644
index 000000000000..007437959395
--- /dev/null
+++ b/rust/kernel/ioctl.rs
@@ -0,0 +1,71 @@
+// SPDX-License-Identifier: GPL-2.0
+#![allow(non_snake_case)]
+
+//! ioctl() number definitions
+//!
+//! C header: [`include/asm-generic/ioctl.h`](../../../../include/asm-generic/ioctl.h)
+
+use crate::build_assert;
+
+/// Build an ioctl number, analogous to the C macro of the same name.
+#[inline(always)]
+const fn _IOC(dir: u32, ty: u32, nr: u32, size: usize) -> u32 {
+    build_assert!(dir <= uapi::_IOC_DIRMASK);
+    build_assert!(ty <= uapi::_IOC_TYPEMASK);
+    build_assert!(nr <= uapi::_IOC_NRMASK);
+    build_assert!(size <= (uapi::_IOC_SIZEMASK as usize));
+
+    (dir << uapi::_IOC_DIRSHIFT)
+        | (ty << uapi::_IOC_TYPESHIFT)
+        | (nr << uapi::_IOC_NRSHIFT)
+        | ((size as u32) << uapi::_IOC_SIZESHIFT)
+}
+
+/// Build an ioctl number for an argumentless ioctl.
+#[inline(always)]
+pub const fn _IO(ty: u32, nr: u32) -> u32 {
+    _IOC(uapi::_IOC_NONE, ty, nr, 0)
+}
+
+/// Build an ioctl number for an read-only ioctl.
+#[inline(always)]
+pub const fn _IOR<T>(ty: u32, nr: u32) -> u32 {
+    _IOC(uapi::_IOC_READ, ty, nr, core::mem::size_of::<T>())
+}
+
+/// Build an ioctl number for an write-only ioctl.
+#[inline(always)]
+pub const fn _IOW<T>(ty: u32, nr: u32) -> u32 {
+    _IOC(uapi::_IOC_WRITE, ty, nr, core::mem::size_of::<T>())
+}
+
+/// Build an ioctl number for a read-write ioctl.
+#[inline(always)]
+pub const fn _IOWR<T>(ty: u32, nr: u32) -> u32 {
+    _IOC(
+        uapi::_IOC_READ | uapi::_IOC_WRITE,
+        ty,
+        nr,
+        core::mem::size_of::<T>(),
+    )
+}
+
+/// Get the ioctl direction from an ioctl number.
+pub const fn _IOC_DIR(nr: u32) -> u32 {
+    (nr >> uapi::_IOC_DIRSHIFT) & uapi::_IOC_DIRMASK
+}
+
+/// Get the ioctl type from an ioctl number.
+pub const fn _IOC_TYPE(nr: u32) -> u32 {
+    (nr >> uapi::_IOC_TYPESHIFT) & uapi::_IOC_TYPEMASK
+}
+
+/// Get the ioctl number from an ioctl number.
+pub const fn _IOC_NR(nr: u32) -> u32 {
+    (nr >> uapi::_IOC_NRSHIFT) & uapi::_IOC_NRMASK
+}
+
+/// Get the ioctl size from an ioctl number.
+pub const fn _IOC_SIZE(nr: u32) -> usize {
+    ((nr >> uapi::_IOC_SIZESHIFT) & uapi::_IOC_SIZEMASK) as usize
+}
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index afec0792d982..63f796781b7c 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -30,6 +30,7 @@ compile_error!("Missing kernel configuration for conditional compilation");
 mod allocator;
 mod build_assert;
 pub mod error;
+pub mod ioctl;
 pub mod prelude;
 pub mod print;
 mod static_assert;

-- 
2.40.0

