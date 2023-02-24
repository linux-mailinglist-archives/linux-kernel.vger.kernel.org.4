Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D20B6A1842
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 09:50:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbjBXIuo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 03:50:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbjBXIuj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 03:50:39 -0500
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE38526AA;
        Fri, 24 Feb 2023 00:50:38 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: linasend@asahilina.net)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 31A103FB17;
        Fri, 24 Feb 2023 08:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=asahilina.net;
        s=default; t=1677228637;
        bh=M10zbadndwKZhD79Kr8HJcwiw4rH1LF/7cTiGWMgTk8=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc;
        b=rxZyMibjaZ6LZEVtlYDJAKnfIA8G8nCJ6WBhvtUFKt+oa44YUYkNytz/nRl7PIjK3
         KsovDYXQ7NxK4j0FoX30fybbD/sTebMJBDIoqR9KSzLGyc8Lp+IO16y+OFsXKltDzy
         BobDpVsTTYVYOONz883rwyRgu1dv5Xlv+EEDpbCbfJtiTGRoTrf4l7KtudA93X4BTk
         Uf6hMIV46bR6OCV8WYI7OtjxwKTdWlAUUdfdYBzvRUfpssj719iFfVcqpQcdCasLRe
         Uq7EB3xIgb9z2DGg/xJgsHcQFIt/bd7Vkm/5htImkA6ybhaCY1hxgEvrC086rTLWo2
         Q6uig72WcEk6g==
From:   Asahi Lina <lina@asahilina.net>
Date:   Fri, 24 Feb 2023 17:50:19 +0900
Subject: [PATCH 1/5] rust: error: Add Error::to_ptr()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230224-rust-error-v1-1-f8f9a9a87303@asahilina.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1677228630; l=1624;
 i=lina@asahilina.net; s=20230221; h=from:subject:message-id;
 bh=M10zbadndwKZhD79Kr8HJcwiw4rH1LF/7cTiGWMgTk8=;
 b=z9aZrN4fCmRuP/ostz6C6/F/Fyl5yn8Ylw5KNL2xDbGwWpW4TGwxSiMXo66tBPTFXeAM/J8XP
 hFMbaVVmizHA2/pLsbqC/BVXiYzZ79/viIlk3yIwIoQl2id9f+fFNdr
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
index 5b9751d7ff1d..8611758e27f4 100644
--- a/rust/kernel/error.rs
+++ b/rust/kernel/error.rs
@@ -76,6 +76,13 @@ impl Error {
     pub fn to_kernel_errno(self) -> core::ffi::c_int {
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
2.35.1

