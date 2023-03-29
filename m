Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE6596CD911
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 14:05:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229461AbjC2MFd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 08:05:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbjC2MFU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 08:05:20 -0400
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5037344A8;
        Wed, 29 Mar 2023 05:05:08 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: linasend@asahilina.net)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 1C55241F46;
        Wed, 29 Mar 2023 12:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=asahilina.net;
        s=default; t=1680091506;
        bh=70azhY624dmqDR1WbAO/UkRG4/uvUwfXnn1O/f8fXaM=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc;
        b=Dcx7JmfYEJOvEoHOUZ0fYa8ZVFzUaYpAK5mmZz51FeSgXeupwRNpt4uhxB3kdh6Kx
         I3WFNita+VmGIE0BV7TYP1oAJ++hgFK3kCyD/ZIiiVYHgm3eJtTnnGOPvdQNtJvqLx
         7jbEz+IqnqU8uwkOYIm/cv0zRKszm60IWa1Moh7TW/BS0WcJZZqmR+/PTx+PVKSyz8
         0EtFdvd7DtDatbAhe+vvqqku9Q3zPI3vUybkdJ19cst5iehOGWYWIvoAoreY2v5n+w
         0nWp4cKK5IAtscHKfWTEJiuxmVJkmnMBcEWQoeb+43MSQm7f0KdChKYYyD5prnOkp/
         K9Zfxsz3jgzfw==
From:   Asahi Lina <lina@asahilina.net>
Date:   Wed, 29 Mar 2023 21:04:38 +0900
Subject: [PATCH v2 6/6] rust: error: Add from_result() helper
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230224-rust-error-v2-6-3900319812da@asahilina.net>
References: <20230224-rust-error-v2-0-3900319812da@asahilina.net>
In-Reply-To: <20230224-rust-error-v2-0-3900319812da@asahilina.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1680091478; l=2445;
 i=lina@asahilina.net; s=20230221; h=from:subject:message-id;
 bh=Ai/iEgQ/fBNHagg7igl9ARuv9+jNWr+C78oJzdHwp1Q=;
 b=FtgUuaSd6mC3+e/DMioQcQS/rPK7XBseDo6+v/MVJi3rTWw7yGSMv3Q7DU/Oyw7ISdeBXG5+d
 BPUZKi78hqqB9vP31WhnZuhDT44q/p8pQiS+4Z+ejaIpN6TNuA0Z4Fz
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

From: Wedson Almeida Filho <wedsonaf@gmail.com>

Add a helper function to easily return C result codes from a Rust function
that calls functions which return a Result<T>.

Lina: Imported from rust-for-linux/rust, originally developed by Wedson
as part of file_operations.rs. Added the allow() flags since there is no
user in the kernel crate yet and fixed a typo in a comment. Replaced the
macro with a function taking a closure, per discussion on the ML.

Co-developed-by: Fox Chen <foxhlchen@gmail.com>
Signed-off-by: Fox Chen <foxhlchen@gmail.com>
Co-developed-by: Miguel Ojeda <ojeda@kernel.org>
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
Signed-off-by: Asahi Lina <lina@asahilina.net>
---
 rust/kernel/error.rs | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/rust/kernel/error.rs b/rust/kernel/error.rs
index 6b10129075a7..4d8b19d5967d 100644
--- a/rust/kernel/error.rs
+++ b/rust/kernel/error.rs
@@ -226,3 +226,42 @@ pub(crate) fn from_err_ptr<T>(ptr: *mut T) -> Result<*mut T> {
     }
     Ok(ptr)
 }
+
+/// Calls a closure returning a [`crate::error::Result<T>`] and converts the result to
+/// a C integer result.
+///
+/// This is useful when calling Rust functions that return [`crate::error::Result<T>`]
+/// from inside `extern "C"` functions that need to return an integer error result.
+///
+/// `T` should be convertible from an `i16` via `From<i16>`.
+///
+/// # Examples
+///
+/// ```ignore
+/// # use kernel::from_result;
+/// # use kernel::bindings;
+/// unsafe extern "C" fn probe_callback(
+///     pdev: *mut bindings::platform_device,
+/// ) -> core::ffi::c_int {
+///     from_result(|| {
+///         let ptr = devm_alloc(pdev)?;
+///         bindings::platform_set_drvdata(pdev, ptr);
+///         Ok(0)
+///     })
+/// }
+/// ```
+// TODO: Remove `dead_code` marker once an in-kernel client is available.
+#[allow(dead_code)]
+pub(crate) fn from_result<T, F>(f: F) -> T
+where
+    T: From<i16>,
+    F: FnOnce() -> Result<T>,
+{
+    match f() {
+        Ok(v) => v,
+        // NO-OVERFLOW: negative `errno`s are no smaller than `-bindings::MAX_ERRNO`,
+        // `-bindings::MAX_ERRNO` fits in an `i16` as per invariant above,
+        // therefore a negative `errno` always fits in an `i16` and will not overflow.
+        Err(e) => T::from(e.to_errno() as i16),
+    }
+}

-- 
2.40.0

