Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBF876D4129
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 11:49:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232395AbjDCJta (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 05:49:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232251AbjDCJs6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 05:48:58 -0400
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CE0B4C31;
        Mon,  3 Apr 2023 02:48:29 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: linasend@asahilina.net)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 365F3423BA;
        Mon,  3 Apr 2023 09:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=asahilina.net;
        s=default; t=1680515307;
        bh=RPuHJ6R232r0hFYOL7uwv1XyiKxx1ILr03e3JPbKDFw=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc;
        b=KQG/jE6FxwK7RjGbmyVlAV5GM0iFmOq0z0+oWzGPINY5h9xVL1AlD3exE8L32Zagv
         fkl60XlcK1WQcWom42C/V/xcjxye5weRSFGDCeA9ewuIVwKTt2w9oIOdSMN2n0Y7SM
         JT8fDP0Jtt3/4a/mKQCz/bdRTVPHEygr8ecDXKJEKC1s+c/ltUrD9vgbDJzBrTZeNr
         aVzTjz0z0sV4PeE2BFCv6XCKioxvQsMqHsxMu2IF5f4o1t3tkEyfyIUkxeCArtRNDw
         kTMohxBuHSJDr6Dr1eaG4U5x0QNXG+YS65LXrTWs5i/k8bk6334hlWTdNUmV6rt5xZ
         mSbSLr3Rz335w==
From:   Asahi Lina <lina@asahilina.net>
Date:   Mon, 03 Apr 2023 18:48:11 +0900
Subject: [PATCH v3 2/6] rust: error: Add Error::to_ptr()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230224-rust-error-v3-2-03779bddc02b@asahilina.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1680515295; l=1683;
 i=lina@asahilina.net; s=20230221; h=from:subject:message-id;
 bh=RPuHJ6R232r0hFYOL7uwv1XyiKxx1ILr03e3JPbKDFw=;
 b=hvY3vvMJfh3KKdhSs9ptvvbGhmtEqmj3Guf8UT/y6cT43cn8ztSn1XJcxaGoNdJpUghwjyGUB
 EKJxa2nN8G3BNausNRjwPXuzOebAa0Gvuqe+0ePdMhXkiN5ZSGOGfrn
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

This is the Rust equivalent to ERR_PTR(), for use in C callbacks.
Marked as #[allow(dead_code)] for now, since it does not have any
consumers yet.

Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Signed-off-by: Asahi Lina <lina@asahilina.net>
---
 rust/helpers.c       | 7 +++++++
 rust/kernel/error.rs | 7 +++++++
 2 files changed, 14 insertions(+)

diff --git a/rust/helpers.c b/rust/helpers.c
index 09a4d93f9d62..89f4cd1e0df3 100644
--- a/rust/helpers.c
+++ b/rust/helpers.c
@@ -20,6 +20,7 @@
 
 #include <linux/bug.h>
 #include <linux/build_bug.h>
+#include <linux/err.h>
 #include <linux/refcount.h>
 
 __noreturn void rust_helper_BUG(void)
@@ -46,6 +47,12 @@ bool rust_helper_refcount_dec_and_test(refcount_t *r)
 }
 EXPORT_SYMBOL_GPL(rust_helper_refcount_dec_and_test);
 
+__force void *rust_helper_ERR_PTR(long err)
+{
+	return ERR_PTR(err);
+}
+EXPORT_SYMBOL_GPL(rust_helper_ERR_PTR);
+
 /*
  * We use `bindgen`'s `--size_t-is-usize` option to bind the C `size_t` type
  * as the Rust `usize` type, so we can use it in contexts where Rust
diff --git a/rust/kernel/error.rs b/rust/kernel/error.rs
index 35894fa35efe..154d0ca6e2dc 100644
--- a/rust/kernel/error.rs
+++ b/rust/kernel/error.rs
@@ -76,6 +76,13 @@ impl Error {
     pub fn to_errno(self) -> core::ffi::c_int {
         self.0
     }
+
+    /// Returns the error encoded as a pointer.
+    #[allow(dead_code)]
+    pub(crate) fn to_ptr<T>(self) -> *mut T {
+        // SAFETY: self.0 is a valid error due to its invariant.
+        unsafe { bindings::ERR_PTR(self.0.into()) as *mut _ }
+    }
 }
 
 impl From<AllocError> for Error {

-- 
2.40.0

