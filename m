Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADFAB6D4179
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 12:02:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231364AbjDCKCN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 06:02:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232157AbjDCKBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 06:01:51 -0400
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF5CD83F0;
        Mon,  3 Apr 2023 03:01:45 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: linasend@asahilina.net)
        by mail.marcansoft.com (Postfix) with ESMTPSA id D8E5142118;
        Mon,  3 Apr 2023 10:01:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=asahilina.net;
        s=default; t=1680516104;
        bh=mt96Ry31EMWGGv3xrCXuVnmwVeuczytGDrnki4wvMRY=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc;
        b=PqipZl7AWWAdCe5Yzxssc80eVykz40viy3qcLHZ62UHBx/iPgJuhXz2D79idamOaI
         NjMH16vDg2ZOGI62I+F7GkXLjwbkPmSUFgbQ0tlddmi97ND25mlUd9mjqoQZvkVJMW
         5lNKqqbWg6Tew9DZcNqgVPjsnW8yZNbOB/gHGKAMjc3WjD8lPyIwO+791nJ+sw2g4G
         0zFxXfk6ga0yVxkWVRqkGOdZGPxC34X890SYtMogMLy1bT9VEMokw0SLpZB3X8EWCn
         XG4avnkZjk6wl5W3+ReAjnFCMNjIAIDYyb2xHMp2sBE9CQIg6fKpiB4W9rkzkWOaSE
         hrlEZ6LzmpRRg==
From:   Asahi Lina <lina@asahilina.net>
Date:   Mon, 03 Apr 2023 19:01:11 +0900
Subject: [PATCH v2 1/2] rust: sync: arc: Implement Arc<dyn Any + Send +
 Sync>::downcast()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230224-rust-arc-v2-1-5c97a865b276@asahilina.net>
References: <20230224-rust-arc-v2-0-5c97a865b276@asahilina.net>
In-Reply-To: <20230224-rust-arc-v2-0-5c97a865b276@asahilina.net>
To:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>
Cc:     Andreas Hindborg <a.hindborg@samsung.com>,
        Vincenzo Palazzo <vincenzopalazzodev@gmail.com>,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
        Benno Lossin <y86-dev@protonmail.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        asahi@lists.linux.dev, Asahi Lina <lina@asahilina.net>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1680516096; l=2373;
 i=lina@asahilina.net; s=20230221; h=from:subject:message-id;
 bh=mt96Ry31EMWGGv3xrCXuVnmwVeuczytGDrnki4wvMRY=;
 b=CZTlhuH+UKIX+dfSA8mpbpmUrwOHpedGgcAWg9ihdc3Zse8Z/baeEqCP51bezEj85mQaJMvmE
 r9NNAIqSPQZA7JYdmy2VtJ2yQlX+qirhipwZ+r9tGnKWWX4oAUrDI9y
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

This mirrors the standard library's alloc::sync::Arc::downcast().

Based on the Rust standard library implementation, ver 1.62.0,
licensed under "Apache-2.0 OR MIT", from:

    https://github.com/rust-lang/rust/tree/1.62.0/library/alloc/src

For copyright details, please see:

    https://github.com/rust-lang/rust/blob/1.62.0/COPYRIGHT

Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Reviewed-by: Andreas Hindborg <a.hindborg@samsung.com>
Reviewed-by: Vincenzo Palazzo <vincenzopalazzodev@gmail.com>
Reviewed-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Asahi Lina <lina@asahilina.net>
---
 rust/kernel/sync/arc.rs            |  2 ++
 rust/kernel/sync/arc/std_vendor.rs | 28 ++++++++++++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
index f2f1c83d72ba..b904ed898d3a 100644
--- a/rust/kernel/sync/arc.rs
+++ b/rust/kernel/sync/arc.rs
@@ -522,3 +522,5 @@ impl<T: ?Sized> DerefMut for UniqueArc<T> {
         unsafe { &mut self.inner.ptr.as_mut().data }
     }
 }
+
+mod std_vendor;
diff --git a/rust/kernel/sync/arc/std_vendor.rs b/rust/kernel/sync/arc/std_vendor.rs
new file mode 100644
index 000000000000..a66a0c2831b3
--- /dev/null
+++ b/rust/kernel/sync/arc/std_vendor.rs
@@ -0,0 +1,28 @@
+// SPDX-License-Identifier: Apache-2.0 OR MIT
+
+//! The contents of this file come from the Rust standard library, hosted in
+//! the <https://github.com/rust-lang/rust> repository, licensed under
+//! "Apache-2.0 OR MIT" and adapted for kernel use. For copyright details,
+//! see <https://github.com/rust-lang/rust/blob/master/COPYRIGHT>.
+
+use crate::sync::{arc::ArcInner, Arc};
+use core::any::Any;
+
+impl Arc<dyn Any + Send + Sync> {
+    /// Attempt to downcast the `Arc<dyn Any + Send + Sync>` to a concrete type.
+    pub fn downcast<T>(self) -> core::result::Result<Arc<T>, Self>
+    where
+        T: Any + Send + Sync,
+    {
+        if (*self).is::<T>() {
+            // SAFETY: We have just checked that the type is correct, so we can cast the pointer.
+            unsafe {
+                let ptr = self.ptr.cast::<ArcInner<T>>();
+                core::mem::forget(self);
+                Ok(Arc::from_inner(ptr))
+            }
+        } else {
+            Err(self)
+        }
+    }
+}

-- 
2.40.0

