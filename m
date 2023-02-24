Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53BD46A1846
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 09:51:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbjBXIvZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 03:51:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbjBXIvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 03:51:08 -0500
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D30B63DC2;
        Fri, 24 Feb 2023 00:50:53 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: linasend@asahilina.net)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 9133941A42;
        Fri, 24 Feb 2023 08:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=asahilina.net;
        s=default; t=1677228651;
        bh=xB/uTkNdcRyAJ9MSmz0Zm2ytGsD1PaLAfUTJ4lXE38o=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc;
        b=jluUxTT4MsfWow1fquKnY6BSANJ/SOd4Jesz7Uh8zivRONgIVXOwXArRMjNQS/0D5
         45iD20o5RBLpaAQRA+5duNKq/skh3y8obwKVEE7ktZXZBSn0ZsGY/XJDI9uXMiQGN7
         D3SCiWUJ+1JaXLBWBJDkwb13SIU3jBpAlu20+E2p/fbmdd6B/t7gKj9NYD9sBUa7x5
         uCrakUy9Kj/cdP2CiOm7iTR9MJLGYnyIaX5T87NMrrBiDHUyr6ZL6nXlQpo2YPNnEE
         slCjNYRl9kyhKBiIhqlsNLhkhGpT7ztUT/2gucAYgFJxtJx+whXqpK2BpsKpMKS4tE
         bQpHo8xTgTtXg==
From:   Asahi Lina <lina@asahilina.net>
Date:   Fri, 24 Feb 2023 17:50:23 +0900
Subject: [PATCH 5/5] rust: error: Add from_kernel_result!() macro
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230224-rust-error-v1-5-f8f9a9a87303@asahilina.net>
References: <20230224-rust-error-v1-0-f8f9a9a87303@asahilina.net>
In-Reply-To: <20230224-rust-error-v1-0-f8f9a9a87303@asahilina.net>
To:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Sven Van Asbroeck <thesven73@gmail.com>
Cc:     Fox Chen <foxhlchen@gmail.com>, rust-for-linux@vger.kernel.org,
        linux-kernel@vger.kernel.org, asahi@lists.linux.dev,
        Asahi Lina <lina@asahilina.net>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1677228630; l=2780;
 i=lina@asahilina.net; s=20230221; h=from:subject:message-id;
 bh=vBDhcwnH5ynZ3xRDLShDFkYEv5ArQWgEwhEf43533EA=;
 b=boG/WaS3XMs/3FWEPp+1XQvxkXa8H/c6k5q+2b+v2KaY055zgjtJnRQ53iv5jS+h2FpjzuPR1
 fI81HlcBJISB+Tr+N/6qsC2xNEW3hQyZxQhKw+ky6RopnnFk1ZYcITp
X-Developer-Key: i=lina@asahilina.net; a=ed25519;
 pk=Qn8jZuOtR1m5GaiDfTrAoQ4NE1XoYVZ/wmt5YtXWFC4=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wedson Almeida Filho <wedsonaf@gmail.com>

Add a helper macro to easily return C result codes from a Rust function
that calls functions which return a Result<T>.

Lina: Imported from rust-for-linux/rust, originally developed by Wedson
as part of file_operations.rs. Added the allow() flags since there is no
user in the kernel crate yet and fixed a typo in a comment.

Co-developed-by: Fox Chen <foxhlchen@gmail.com>
Signed-off-by: Fox Chen <foxhlchen@gmail.com>
Co-developed-by: Miguel Ojeda <ojeda@kernel.org>
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
Signed-off-by: Asahi Lina <lina@asahilina.net>
---
 rust/kernel/error.rs | 52 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/rust/kernel/error.rs b/rust/kernel/error.rs
index cf3d089477d2..8a9222595cd1 100644
--- a/rust/kernel/error.rs
+++ b/rust/kernel/error.rs
@@ -226,3 +226,55 @@ pub(crate) fn from_kernel_err_ptr<T>(ptr: *mut T) -> Result<*mut T> {
     }
     Ok(ptr)
 }
+
+// TODO: Remove `dead_code` marker once an in-kernel client is available.
+#[allow(dead_code)]
+pub(crate) fn from_kernel_result_helper<T>(r: Result<T>) -> T
+where
+    T: From<i16>,
+{
+    match r {
+        Ok(v) => v,
+        // NO-OVERFLOW: negative `errno`s are no smaller than `-bindings::MAX_ERRNO`,
+        // `-bindings::MAX_ERRNO` fits in an `i16` as per invariant above,
+        // therefore a negative `errno` always fits in an `i16` and will not overflow.
+        Err(e) => T::from(e.to_kernel_errno() as i16),
+    }
+}
+
+/// Transforms a [`crate::error::Result<T>`] to a kernel C integer result.
+///
+/// This is useful when calling Rust functions that return [`crate::error::Result<T>`]
+/// from inside `extern "C"` functions that need to return an integer
+/// error result.
+///
+/// `T` should be convertible from an `i16` via `From<i16>`.
+///
+/// # Examples
+///
+/// ```ignore
+/// # use kernel::from_kernel_result;
+/// # use kernel::bindings;
+/// unsafe extern "C" fn probe_callback(
+///     pdev: *mut bindings::platform_device,
+/// ) -> core::ffi::c_int {
+///     from_kernel_result! {
+///         let ptr = devm_alloc(pdev)?;
+///         bindings::platform_set_drvdata(pdev, ptr);
+///         Ok(0)
+///     }
+/// }
+/// ```
+// TODO: Remove `unused_macros` marker once an in-kernel client is available.
+#[allow(unused_macros)]
+macro_rules! from_kernel_result {
+    ($($tt:tt)*) => {{
+        $crate::error::from_kernel_result_helper((|| {
+            $($tt)*
+        })())
+    }};
+}
+
+// TODO: Remove `unused_imports` marker once an in-kernel client is available.
+#[allow(unused_imports)]
+pub(crate) use from_kernel_result;

-- 
2.35.1

