Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF4056CD90C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 14:05:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbjC2MFF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 08:05:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbjC2MEw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 08:04:52 -0400
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5FAF30FF;
        Wed, 29 Mar 2023 05:04:51 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: linasend@asahilina.net)
        by mail.marcansoft.com (Postfix) with ESMTPSA id E0317424A5;
        Wed, 29 Mar 2023 12:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=asahilina.net;
        s=default; t=1680091490;
        bh=yizatryz94HI38ZhrhHNZKorJP2yMGzaneMJyUc/yLs=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc;
        b=PqITEoRLJt6wek92hSnvKc+Y1lmrOZsCLkof9zV7pn1ZNqZZWcdU2I15hFi/0iu5E
         qAl/+y7C+v5f5jtOnENPkB4CvMhF8EgkbglkUtW8YSNF5/1YDH2cZH1qx0FuegkBws
         kl9MQqd6kE/7jb2NLfNZLxQrkEjByz9eOQp/qNQkZO+getG5pn8J369MZyd853W+uc
         bVH7NfhyspZ7pd4ArAzCusASEKVEvo8N2LT5iq36AuF2YTdzQjFXscoHiR60iDTs6A
         LszjKUuvn0pp7JlYzdskZzmV8QbA/TbPaJ4tWxptPoI3qOR3EJoBp4cCZd4P323+ul
         dVl0caXyxuPLw==
From:   Asahi Lina <lina@asahilina.net>
Date:   Wed, 29 Mar 2023 21:04:34 +0900
Subject: [PATCH v2 2/6] rust: error: Add Error::to_ptr()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230224-rust-error-v2-2-3900319812da@asahilina.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1680091478; l=1617;
 i=lina@asahilina.net; s=20230221; h=from:subject:message-id;
 bh=yizatryz94HI38ZhrhHNZKorJP2yMGzaneMJyUc/yLs=;
 b=g3wfjFA5bNlmO1XJYJc+pIss8D54z8fnJrLrR9I1KnVL0/HzvcuTRtMeiraME/fJKA07ACpAh
 Rb62kJ4bwzLDe8glRgolrXsew//PuOyb/iOnkUki7e2ldOY6UP/20pz
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
index 35894fa35efe..e97e652a1aec 100644
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
+        // SAFETY: Valid as long as self.0 is a valid error
+        unsafe { bindings::ERR_PTR(self.0.into()) as *mut _ }
+    }
 }
 
 impl From<AllocError> for Error {

-- 
2.40.0

