Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED8EE657309
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 07:05:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbiL1GE6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 01:04:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbiL1GEk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 01:04:40 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73CBADFAE;
        Tue, 27 Dec 2022 22:04:39 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id n3so13326896wrc.5;
        Tue, 27 Dec 2022 22:04:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NYJ20jftMQ92CUxnJjaaHKdOk3jkOftLaji4+9En0dc=;
        b=igz9ApMN93MMMvir8cEZVLhAlEwrT5qCIUt8GTeIg9hE1k033dQeVJAxv9ZNQC/TH4
         mSJAMfWRk/P9OLtuX+1Xzbu0cA9hRzElS+i3j2cKO6fbY9xrfflj5Rmno/aV/LRQCak5
         QLAw9IWaJ4lRtxWb1kKH/CQ+sJA7yJerLb8ueS3HajQYmSbeHObV9r+oiVt0tflpvPdy
         /A9LXfLy5OqkMF6JzMfRU8uL1yIFStcEziBi6wGqQl3DPpZhOXLVtDCIP8unUXpxCGOq
         uDwEUjf/jV1O4xC5JKbHoPFHjVEz/osPp5nWrWohUBBjLKoZDyDeFALPR/Jsvnby3tTH
         5u9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NYJ20jftMQ92CUxnJjaaHKdOk3jkOftLaji4+9En0dc=;
        b=3M6/tmOQn6FIQOhT5VDXEOw9PeHIMaTIubIKzTD2pKeFK3FVqXJb2fd5rrn+btC4Q1
         T7P/+JNiiofomIx+mNRVyAEvsgyLQzWiE2mIyIS7L4bpjntJq/5Utc5GjhDyo6RVe/bc
         t/desAQSTSqC+Q2QmsTFLii0z8MI1B+23C7PAFVhfrrNLu1gDoUamiWkU01HmA8cIYTF
         rNf/PuMTQ/eH1AFtQxc+sTIL22bnKX1/PFHA0pQbrvhTKP+nEthE55jB3Ez2jvSkKmqf
         T/WIzebdGegwCR8/J9xxuiGDJsYUp9xqfEdIxtTWxYHbFObbHh8CmzuY6Ps2E1vr6rXK
         eUbg==
X-Gm-Message-State: AFqh2kqidosWGstyblvHRkVf20XWJiFrbDWGYIyQyxPoyRa/2ZsWwthU
        oyjgsyJXNcjucLNkFUIPyvQdsMdp6rGlaA==
X-Google-Smtp-Source: AMrXdXuC1gCGLNHaroQyEOUNBKveXyX/5vMGb6LjG5lY2UlYdhVx491Xw/kEAPDDsimJlJraBFKlNw==
X-Received: by 2002:adf:ec4f:0:b0:27b:a73e:33ae with SMTP id w15-20020adfec4f000000b0027ba73e33aemr6257770wrn.8.1672207477843;
        Tue, 27 Dec 2022 22:04:37 -0800 (PST)
Received: from wedsonaf-dev.. ([81.2.152.129])
        by smtp.googlemail.com with ESMTPSA id x16-20020a5d6510000000b002755e301eeasm12128867wru.100.2022.12.27.22.04.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Dec 2022 22:04:37 -0800 (PST)
From:   Wedson Almeida Filho <wedsonaf@gmail.com>
To:     rust-for-linux@vger.kernel.org
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
        linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <wedsonaf@gmail.com>
Subject: [PATCH 4/7] rust: sync: introduce `ArcBorrow`
Date:   Wed, 28 Dec 2022 06:03:43 +0000
Message-Id: <20221228060346.352362-4-wedsonaf@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221228060346.352362-1-wedsonaf@gmail.com>
References: <20221228060346.352362-1-wedsonaf@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows us to create references to a ref-counted allocation without
double-indirection and that still allow us to increment the refcount to
a new `Arc<T>`.

Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
---
 rust/kernel/sync.rs     |  2 +-
 rust/kernel/sync/arc.rs | 97 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 98 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/sync.rs b/rust/kernel/sync.rs
index 39b379dd548f..5de03ea83ea1 100644
--- a/rust/kernel/sync.rs
+++ b/rust/kernel/sync.rs
@@ -7,4 +7,4 @@
 
 mod arc;
 
-pub use arc::Arc;
+pub use arc::{Arc, ArcBorrow};
diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
index dbc7596cc3ce..f68bfc02c81a 100644
--- a/rust/kernel/sync/arc.rs
+++ b/rust/kernel/sync/arc.rs
@@ -19,6 +19,7 @@ use crate::{bindings, error::Result, types::Opaque};
 use alloc::boxed::Box;
 use core::{
     marker::{PhantomData, Unsize},
+    mem::ManuallyDrop,
     ops::Deref,
     ptr::NonNull,
 };
@@ -164,6 +165,18 @@ impl<T: ?Sized> Arc<T> {
             _p: PhantomData,
         }
     }
+
+    /// Returns an [`ArcBorrow`] from the given [`Arc`].
+    ///
+    /// This is useful when the argument of a function call is an [`ArcBorrow`] (e.g., in a method
+    /// receiver), but we have an [`Arc`] instead. Getting an [`ArcBorrow`] is free when optimised.
+    #[inline]
+    pub fn as_arc_borrow(&self) -> ArcBorrow<'_, T> {
+        // SAFETY: The constraint that the lifetime of the shared reference must outlive that of
+        // the returned `ArcBorrow` ensures that the object remains alive and that no mutable
+        // reference can be created.
+        unsafe { ArcBorrow::new(self.ptr) }
+    }
 }
 
 impl<T: ?Sized> Deref for Arc<T> {
@@ -208,3 +221,87 @@ impl<T: ?Sized> Drop for Arc<T> {
         }
     }
 }
+
+/// A borrowed reference to an [`Arc`] instance.
+///
+/// For cases when one doesn't ever need to increment the refcount on the allocation, it is simpler
+/// to use just `&T`, which we can trivially get from an `Arc<T>` instance.
+///
+/// However, when one may need to increment the refcount, it is preferable to use an `ArcBorrow<T>`
+/// over `&Arc<T>` because the latter results in a double-indirection: a pointer (shared reference)
+/// to a pointer (`Arc<T>`) to the object (`T`). An [`ArcBorrow`] eliminates this double
+/// indirection while still allowing one to increment the refcount and getting an `Arc<T>` when/if
+/// needed.
+///
+/// # Invariants
+///
+/// There are no mutable references to the underlying [`Arc`], and it remains valid for the
+/// lifetime of the [`ArcBorrow`] instance.
+///
+/// # Example
+///
+/// ```
+/// use crate::sync::{Arc, ArcBorrow};
+///
+/// struct Example;
+///
+/// fn do_something(e: ArcBorrow<'_, Example>) -> Arc<Example> {
+///     e.into()
+/// }
+///
+/// let obj = Arc::try_new(Example)?;
+/// let cloned = do_something(obj.as_arc_borrow());
+///
+/// // Assert that both `obj` and `cloned` point to the same underlying object.
+/// assert!(core::ptr::eq(&*obj, &*cloned));
+/// ```
+pub struct ArcBorrow<'a, T: ?Sized + 'a> {
+    inner: NonNull<ArcInner<T>>,
+    _p: PhantomData<&'a ()>,
+}
+
+impl<T: ?Sized> Clone for ArcBorrow<'_, T> {
+    fn clone(&self) -> Self {
+        *self
+    }
+}
+
+impl<T: ?Sized> Copy for ArcBorrow<'_, T> {}
+
+impl<T: ?Sized> ArcBorrow<'_, T> {
+    /// Creates a new [`ArcBorrow`] instance.
+    ///
+    /// # Safety
+    ///
+    /// Callers must ensure the following for the lifetime of the returned [`ArcBorrow`] instance:
+    /// 1. That `inner` remains valid;
+    /// 2. That no mutable references to `inner` are created.
+    unsafe fn new(inner: NonNull<ArcInner<T>>) -> Self {
+        // INVARIANT: The safety requirements guarantee the invariants.
+        Self {
+            inner,
+            _p: PhantomData,
+        }
+    }
+}
+
+impl<T: ?Sized> From<ArcBorrow<'_, T>> for Arc<T> {
+    fn from(b: ArcBorrow<'_, T>) -> Self {
+        // SAFETY: The existence of `b` guarantees that the refcount is non-zero. `ManuallyDrop`
+        // guarantees that `drop` isn't called, so it's ok that the temporary `Arc` doesn't own the
+        // increment.
+        ManuallyDrop::new(unsafe { Arc::from_inner(b.inner) })
+            .deref()
+            .clone()
+    }
+}
+
+impl<T: ?Sized> Deref for ArcBorrow<'_, T> {
+    type Target = T;
+
+    fn deref(&self) -> &Self::Target {
+        // SAFETY: By the type invariant, the underlying object is still alive with no mutable
+        // references to it, so it is safe to create a shared reference.
+        unsafe { &self.inner.as_ref().data }
+    }
+}
-- 
2.34.1

