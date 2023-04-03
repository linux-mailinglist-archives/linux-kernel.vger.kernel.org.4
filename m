Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3733F6D412A
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 11:49:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231611AbjDCJtj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 05:49:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232369AbjDCJtD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 05:49:03 -0400
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6280DF76E;
        Mon,  3 Apr 2023 02:48:33 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: linasend@asahilina.net)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 2D02C42450;
        Mon,  3 Apr 2023 09:48:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=asahilina.net;
        s=default; t=1680515311;
        bh=pvm7WbUlb+NyTlE+c65R2hxzbHfwH1tHLDpoJLpargk=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc;
        b=G9veylE4GPhDrjRmkuHDPCfGZcFuNYsx42GtF8DDtfOK/LyjsgcnhvpZVbh9acbMa
         2Xo4eOT7s+Vs0vBogkN00D+2lSNjEMFF1anQoXlOvvoyR5zIH5EYWxA+Rp4qngZXpX
         x4jJ9G20IJJnvcAgP/TxVcRCvdetDBiOZf/9UP/RX/yC2fvASojGGc+FjTTghvEFH0
         Pu0BcoP+53hBF8jdroViphZdnvpTsS1VVilT3WwzBLiYL21V7VOmPi1Tf9ta4MaeNz
         Xz2jbunqBGPsZJmFJNV5SoDRPFz0GkVNRs9U4/oFyAdi09kf1nh5YNLd3hPfYCzucK
         EqiA5p8JkYNCg==
From:   Asahi Lina <lina@asahilina.net>
Date:   Mon, 03 Apr 2023 18:48:12 +0900
Subject: [PATCH v3 3/6] rust: error: Add Error::from_errno{_unchecked}()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230224-rust-error-v3-3-03779bddc02b@asahilina.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1680515295; l=2409;
 i=lina@asahilina.net; s=20230221; h=from:subject:message-id;
 bh=NIH7G76x2xHvQYd680nRP0CtYqhzkgYdRdFs2Fnvuo0=;
 b=UZdEnqHEaSx8QsOcokSBiiKDI0ySOxyOpVj6+4YBFVzVl99Ef+T6kFqCtm2jWoeF8bCtxAHsh
 tu0CFblE0yQBEt0Y7SD/XJvsEMiPPAGm1dQIfH+Osbo6M9LeKZ1CeCU
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

From: Miguel Ojeda <ojeda@kernel.org>

Add a function to create `Error` values out of a kernel error return,
which safely upholds the invariant that the error code is well-formed
(negative and greater than -MAX_ERRNO). If a malformed code is passed
in, it will be converted to EINVAL.

Lina: Imported from rust-for-linux/rust as authored by Miguel and Fox
with refactoring from Wedson, renamed from_kernel_errno() to
from_errno().

Co-developed-by: Fox Chen <foxhlchen@gmail.com>
Signed-off-by: Fox Chen <foxhlchen@gmail.com>
Co-developed-by: Wedson Almeida Filho <wedsonaf@gmail.com>
Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
Reviewed-by: Andreas Hindborg <a.hindborg@samsung.com>
Reviewed-by: Gary Guo <gary@garyguo.net>
Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Signed-off-by: Asahi Lina <lina@asahilina.net>
---
 rust/kernel/error.rs | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/rust/kernel/error.rs b/rust/kernel/error.rs
index 154d0ca6e2dc..1af0d75d3a73 100644
--- a/rust/kernel/error.rs
+++ b/rust/kernel/error.rs
@@ -72,6 +72,36 @@ pub mod code {
 pub struct Error(core::ffi::c_int);
 
 impl Error {
+    /// Creates an [`Error`] from a kernel error code.
+    ///
+    /// It is a bug to pass an out-of-range `errno`. `EINVAL` would
+    /// be returned in such a case.
+    pub(crate) fn from_errno(errno: core::ffi::c_int) -> Error {
+        if errno < -(bindings::MAX_ERRNO as i32) || errno >= 0 {
+            // TODO: Make it a `WARN_ONCE` once available.
+            crate::pr_warn!(
+                "attempted to create `Error` with out of range `errno`: {}",
+                errno
+            );
+            return code::EINVAL;
+        }
+
+        // INVARIANT: The check above ensures the type invariant
+        // will hold.
+        Error(errno)
+    }
+
+    /// Creates an [`Error`] from a kernel error code.
+    ///
+    /// # Safety
+    ///
+    /// `errno` must be within error code range (i.e. `>= -MAX_ERRNO && < 0`).
+    unsafe fn from_errno_unchecked(errno: core::ffi::c_int) -> Error {
+        // INVARIANT: The contract ensures the type invariant
+        // will hold.
+        Error(errno)
+    }
+
     /// Returns the kernel error code.
     pub fn to_errno(self) -> core::ffi::c_int {
         self.0

-- 
2.40.0

