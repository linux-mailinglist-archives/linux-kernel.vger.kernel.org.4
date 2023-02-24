Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C043A6A179D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 09:00:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbjBXIAQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 03:00:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbjBXIAI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 03:00:08 -0500
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1E4221950;
        Fri, 24 Feb 2023 00:00:06 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: linasend@asahilina.net)
        by mail.marcansoft.com (Postfix) with ESMTPSA id CB14A425FF;
        Fri, 24 Feb 2023 08:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=asahilina.net;
        s=default; t=1677225605;
        bh=6Wbnei3k6KtVJz9ZI7M1PVB1moPrUHEpETOWDNtBwL8=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc;
        b=HNf14lwW2ZiKP2wSRb6ZYYx6kIurcsxTrTnaYTiE6pGBGgNBb46Ayp/vt5XW7NxNN
         h44pAvXfwVovff8VmmBWdLlUp6gHjUt1LpSQmKUl6P3JRrW7JwLLsbp1bXXBLjQ+Ar
         qSqSZWTSYgMAGbCWtDztaRsnOrDmjGn0LKUjH9+bs9h8EXFJYyJP7Q/D/1R+Bqi8tY
         klxNRUOyZMwJJyqUYsWvDJIMpwmO5sdgqY2RmpMzhO587mAC2a1pCNgk16LPtOO24+
         3XWeauLuT2R37YdJmBrZUSUbZMi8bEt7hhx19NXNbpyNc4h+zy4HeEq4rhFjf4wM8K
         cmoc/rD1KdouA==
From:   Asahi Lina <lina@asahilina.net>
Date:   Fri, 24 Feb 2023 16:59:33 +0900
Subject: [PATCH 1/2] rust: sync: arc: implement Arc<dyn Any + Send +
 Sync>::downcast()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230224-rust-arc-v1-1-568eea613a41@asahilina.net>
References: <20230224-rust-arc-v1-0-568eea613a41@asahilina.net>
In-Reply-To: <20230224-rust-arc-v1-0-568eea613a41@asahilina.net>
To:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        asahi@lists.linux.dev, Asahi Lina <lina@asahilina.net>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1677225599; l=1738;
 i=lina@asahilina.net; s=20230221; h=from:subject:message-id;
 bh=6Wbnei3k6KtVJz9ZI7M1PVB1moPrUHEpETOWDNtBwL8=;
 b=pl+lv4Tc3xCIBS5/RLRLXHflMYEspfZVvyeG9O2EVpNFAe5b/JOSXqDeabDbmi3eE4wYUsw3B
 FzcsitZwuTzClhPwm86Jxdx/DHXFqY5N7mORtzgFbDCpcbFGBp+cqZy
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

This mirrors the standard library's alloc::sync::Arc::downcast().

Based on the Rust standard library implementation, ver 1.62.0,
licensed under "Apache-2.0 OR MIT", from:

    https://github.com/rust-lang/rust/tree/1.62.0/library/alloc/src

For copyright details, please see:

    https://github.com/rust-lang/rust/blob/1.62.0/COPYRIGHT

Signed-off-by: Asahi Lina <lina@asahilina.net>
---
 rust/kernel/sync/arc.rs | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
index a94e303217c6..752bd7c4699e 100644
--- a/rust/kernel/sync/arc.rs
+++ b/rust/kernel/sync/arc.rs
@@ -22,6 +22,7 @@ use crate::{
 };
 use alloc::boxed::Box;
 use core::{
+    any::Any,
     fmt,
     marker::{PhantomData, Unsize},
     mem::{ManuallyDrop, MaybeUninit},
@@ -220,6 +221,27 @@ impl<T: 'static> ForeignOwnable for Arc<T> {
     }
 }
 
+impl Arc<dyn Any + Send + Sync> {
+    /// Attempt to downcast the `Arc<dyn Any + Send + Sync>` to a concrete type.
+    // Based on the Rust standard library implementation, ver 1.62.0, which is
+    // Apache-2.0 OR MIT.
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
+
 impl<T: ?Sized> Deref for Arc<T> {
     type Target = T;
 

-- 
2.35.1

