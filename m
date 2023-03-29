Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA8E76CD90D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 14:05:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbjC2MFI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 08:05:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230058AbjC2ME5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 08:04:57 -0400
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E041830ED;
        Wed, 29 Mar 2023 05:04:55 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: linasend@asahilina.net)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 19E7E41F46;
        Wed, 29 Mar 2023 12:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=asahilina.net;
        s=default; t=1680091494;
        bh=i4OiR3LCVFp1o7pcdF1+sBJPH/zxSaRWGdgRE2WJDNU=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc;
        b=LhnYkk72xZfQ9ysMIZ32YxC6aiSSoincImJAGgNxUoaYeiBX78sfY5rq8WLcal/i+
         XZggEobuj3q0kLkwBWwiU1VzJcw7M5MQoytDIm3CSC3xz8lHu3fituOehDia+s9xM9
         b0LG3l0mae6+Ne93MosdY45QU/Z1omitZFuDQi/weoTWOpycW1SyqdKAAZCuaseFOc
         3uiFUPxxlbUY59CE7drn6qZ/fHmvwND3KiLdMKPtvB8Taj8pQ1B78VQlNGSQOzuT4h
         Qndab1aq5ByHy6j6TqikiV8CgHpncvJjdGzpVDkFJqdv+8XxTvj47rjqsxnBd9Wzby
         Hh2eeuGFnGuzQ==
From:   Asahi Lina <lina@asahilina.net>
Date:   Wed, 29 Mar 2023 21:04:35 +0900
Subject: [PATCH v2 3/6] rust: error: Add Error::from_errno()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230224-rust-error-v2-3-3900319812da@asahilina.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1680091478; l=1923;
 i=lina@asahilina.net; s=20230221; h=from:subject:message-id;
 bh=VSgp8GJmq0GyyWZ2FrIFWGZbohpKXUspc+RJ4lAro+A=;
 b=MI7BIrTtZmn6MoA5cs6z3VjONdRNDkoCAfIOu+dk9btyw14filP7UP7mvZNtWRVQSD36I41+j
 sB23CuOjfluCfsXkohXWQdCKwXyqrrETbQlWVggmrqD6pBoRt9D6iIp
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
Signed-off-by: Asahi Lina <lina@asahilina.net>
---
 rust/kernel/error.rs | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/rust/kernel/error.rs b/rust/kernel/error.rs
index e97e652a1aec..659468bd1735 100644
--- a/rust/kernel/error.rs
+++ b/rust/kernel/error.rs
@@ -72,6 +72,25 @@ pub mod code {
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
     /// Returns the kernel error code.
     pub fn to_errno(self) -> core::ffi::c_int {
         self.0

-- 
2.40.0

