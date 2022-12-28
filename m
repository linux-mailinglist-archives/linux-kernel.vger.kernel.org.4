Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 984E165730B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 07:05:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231716AbiL1GFF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 01:05:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiL1GEm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 01:04:42 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 185FEDF1B;
        Tue, 27 Dec 2022 22:04:41 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id bx10so14105631wrb.0;
        Tue, 27 Dec 2022 22:04:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s76JV/Exvx+RM2maTBqxn8/tfygp8gqzjmIPH1TmhL4=;
        b=ZRxl3nUZob8rBBEhsqXnWL0rXlFlstDxouDNrtu7aJYWnNEUFtG6Azp9erA4Y4alPC
         XSu+SYDAGGkDQ49yjn+eFmOiN1oadkbrhc86SbsqxCMwrlG6Uv+D1ti2w3qeqDUM74kn
         OFoTBsiuX9oAqA1QqdMrRAleoiGb6Nso0ar+AoyNXlPCt9QC9mbo3bTHYuEBRo7okWpX
         KSCZIDSs29WNd8wLBwOB11u9kNlqqnL06hoY6PGhbmJA8Kc8ovJRDKgkfM/wwC14jgTM
         ZYvaPuz5aOX0jNhXjqsex1rQlS+RH2841sAislzO3z4nQoQ/Xh8uvQa5z7PV1sW/5mbk
         NC1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s76JV/Exvx+RM2maTBqxn8/tfygp8gqzjmIPH1TmhL4=;
        b=wMArZmZ7fkFGnRod/2+dOjg9ujfsaf/87APvYN3XDQL0Nu065u9Y0bLW77JV05jGOn
         J5dRN9Rcp6IIaoKR0S0H5c36IGJx70yD5DguGq2Q0cUuzsI+18X2WcrR47PTG0JLSz2K
         QIPDMOFq6ABpsh2ooCDf4yigACbjyFZqvSg+0USQ0rABanjQKdiHvl4pdwlX6oIwt4wC
         PFRhokhwjjuKQCl/koS2puscvzEuFxXAGFA7b68CxWcoAQGrKOjvvmtv4ny97RQKXlsR
         bOQE8LECaqDTu+fcz49hW0Dw1VVoRnKIPx6MpZFsZIpFb2yMdDow3qO7X3sGOs/JX+7g
         7fAg==
X-Gm-Message-State: AFqh2ko+2EOd7BPNZ2nOzaSSYb7zB5kZG6vHk1Ehb2gQm463r21fv+Aa
        hw8cKyJ+h8M1jUV0eiUXbMFZon3HY0WeCA==
X-Google-Smtp-Source: AMrXdXsWAt3CyQfXngmugw4A5cKyTwfG0X/Ytwx+IflytwO1EC3h5AvdXEJFWQl/2nkjObKvH/Okhg==
X-Received: by 2002:a05:6000:1801:b0:242:1f22:df11 with SMTP id m1-20020a056000180100b002421f22df11mr15566170wrh.4.1672207479545;
        Tue, 27 Dec 2022 22:04:39 -0800 (PST)
Received: from wedsonaf-dev.. ([81.2.152.129])
        by smtp.googlemail.com with ESMTPSA id x16-20020a5d6510000000b002755e301eeasm12128867wru.100.2022.12.27.22.04.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Dec 2022 22:04:39 -0800 (PST)
From:   Wedson Almeida Filho <wedsonaf@gmail.com>
To:     rust-for-linux@vger.kernel.org
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
        linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <wedsonaf@gmail.com>
Subject: [PATCH 6/7] rust: sync: introduce `UniqueArc`
Date:   Wed, 28 Dec 2022 06:03:45 +0000
Message-Id: <20221228060346.352362-6-wedsonaf@gmail.com>
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

Since `Arc<T>` does not allow mutating `T` directly (i.e., without inner
mutability), it is currently not possible to do some initialisation of
`T` post construction but before being shared.

`UniqueArc<T>` addresses this problem essentially being an `Arc<T>` that
has a refcount of 1 and is therefore writable. Once initialisation is
completed, it can be transitioned (without failure paths) into an
`Arc<T>`.

Suggested-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
---
 rust/kernel/sync.rs     |   2 +-
 rust/kernel/sync/arc.rs | 152 +++++++++++++++++++++++++++++++++++++++-
 2 files changed, 151 insertions(+), 3 deletions(-)

diff --git a/rust/kernel/sync.rs b/rust/kernel/sync.rs
index 5de03ea83ea1..33da23e3076d 100644
--- a/rust/kernel/sync.rs
+++ b/rust/kernel/sync.rs
@@ -7,4 +7,4 @@
 
 mod arc;
 
-pub use arc::{Arc, ArcBorrow};
+pub use arc::{Arc, ArcBorrow, UniqueArc};
diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
index 84f31c85a513..832bafc74a90 100644
--- a/rust/kernel/sync/arc.rs
+++ b/rust/kernel/sync/arc.rs
@@ -19,8 +19,9 @@ use crate::{bindings, error::Result, types::Opaque};
 use alloc::boxed::Box;
 use core::{
     marker::{PhantomData, Unsize},
-    mem::ManuallyDrop,
-    ops::Deref,
+    mem::{ManuallyDrop, MaybeUninit},
+    ops::{Deref, DerefMut},
+    pin::Pin,
     ptr::NonNull,
 };
 
@@ -222,6 +223,19 @@ impl<T: ?Sized> Drop for Arc<T> {
     }
 }
 
+impl<T: ?Sized> From<UniqueArc<T>> for Arc<T> {
+    fn from(item: UniqueArc<T>) -> Self {
+        item.inner
+    }
+}
+
+impl<T: ?Sized> From<Pin<UniqueArc<T>>> for Arc<T> {
+    fn from(item: Pin<UniqueArc<T>>) -> Self {
+        // SAFETY: The type invariants of `Arc` guarantee that the data is pinned.
+        unsafe { Pin::into_inner_unchecked(item).inner }
+    }
+}
+
 /// A borrowed reference to an [`Arc`] instance.
 ///
 /// For cases when one doesn't ever need to increment the refcount on the allocation, it is simpler
@@ -328,3 +342,137 @@ impl<T: ?Sized> Deref for ArcBorrow<'_, T> {
         unsafe { &self.inner.as_ref().data }
     }
 }
+
+/// A refcounted object that is known to have a refcount of 1.
+///
+/// It is mutable and can be converted to an [`Arc`] so that it can be shared.
+///
+/// # Invariants
+///
+/// `inner` always has a reference count of 1.
+///
+/// # Examples
+///
+/// In the following example, we make changes to the inner object before turning it into an
+/// `Arc<Test>` object (after which point, it cannot be mutated directly). Note that `x.into()`
+/// cannot fail.
+///
+/// ```
+/// use kernel::sync::{Arc, UniqueArc};
+///
+/// struct Example {
+///     a: u32,
+///     b: u32,
+/// }
+///
+/// fn test() -> Result<Arc<Example>> {
+///     let mut x = UniqueArc::try_new(Example { a: 10, b: 20 })?;
+///     x.a += 1;
+///     x.b += 1;
+///     Ok(x.into())
+/// }
+///
+/// # test().unwrap();
+/// ```
+///
+/// In the following example we first allocate memory for a ref-counted `Example` but we don't
+/// initialise it on allocation. We do initialise it later with a call to [`UniqueArc::write`],
+/// followed by a conversion to `Arc<Example>`. This is particularly useful when allocation happens
+/// in one context (e.g., sleepable) and initialisation in another (e.g., atomic):
+///
+/// ```
+/// use kernel::sync::{Arc, UniqueArc};
+///
+/// struct Example {
+///     a: u32,
+///     b: u32,
+/// }
+///
+/// fn test() -> Result<Arc<Example>> {
+///     let x = UniqueArc::try_new_uninit()?;
+///     Ok(x.write(Example { a: 10, b: 20 }).into())
+/// }
+///
+/// # test().unwrap();
+/// ```
+///
+/// In the last example below, the caller gets a pinned instance of `Example` while converting to
+/// `Arc<Example>`; this is useful in scenarios where one needs a pinned reference during
+/// initialisation, for example, when initialising fields that are wrapped in locks.
+///
+/// ```
+/// use kernel::sync::{Arc, UniqueArc};
+///
+/// struct Example {
+///     a: u32,
+///     b: u32,
+/// }
+///
+/// fn test() -> Result<Arc<Example>> {
+///     let mut pinned = Pin::from(UniqueArc::try_new(Example { a: 10, b: 20 })?);
+///     // We can modify `pinned` because it is `Unpin`.
+///     pinned.as_mut().a += 1;
+///     Ok(pinned.into())
+/// }
+///
+/// # test().unwrap();
+/// ```
+pub struct UniqueArc<T: ?Sized> {
+    inner: Arc<T>,
+}
+
+impl<T> UniqueArc<T> {
+    /// Tries to allocate a new [`UniqueArc`] instance.
+    pub fn try_new(value: T) -> Result<Self> {
+        Ok(Self {
+            // INVARIANT: The newly-created object has a ref-count of 1.
+            inner: Arc::try_new(value)?,
+        })
+    }
+
+    /// Tries to allocate a new [`UniqueArc`] instance whose contents are not initialised yet.
+    pub fn try_new_uninit() -> Result<UniqueArc<MaybeUninit<T>>> {
+        Ok(UniqueArc::<MaybeUninit<T>> {
+            // INVARIANT: The newly-created object has a ref-count of 1.
+            inner: Arc::try_new(MaybeUninit::uninit())?,
+        })
+    }
+}
+
+impl<T> UniqueArc<MaybeUninit<T>> {
+    /// Converts a `UniqueArc<MaybeUninit<T>>` into a `UniqueArc<T>` by writing a value into it.
+    pub fn write(mut self, value: T) -> UniqueArc<T> {
+        self.deref_mut().write(value);
+        let inner = ManuallyDrop::new(self).inner.ptr;
+        UniqueArc {
+            // SAFETY: The new `Arc` is taking over `ptr` from `self.inner` (which won't be
+            // dropped). The types are compatible because `MaybeUninit<T>` is compatible with `T`.
+            inner: unsafe { Arc::from_inner(inner.cast()) },
+        }
+    }
+}
+
+impl<T: ?Sized> From<UniqueArc<T>> for Pin<UniqueArc<T>> {
+    fn from(obj: UniqueArc<T>) -> Self {
+        // SAFETY: It is not possible to move/replace `T` inside a `Pin<UniqueArc<T>>` (unless `T`
+        // is `Unpin`), so it is ok to convert it to `Pin<UniqueArc<T>>`.
+        unsafe { Pin::new_unchecked(obj) }
+    }
+}
+
+impl<T: ?Sized> Deref for UniqueArc<T> {
+    type Target = T;
+
+    fn deref(&self) -> &Self::Target {
+        self.inner.deref()
+    }
+}
+
+impl<T: ?Sized> DerefMut for UniqueArc<T> {
+    fn deref_mut(&mut self) -> &mut Self::Target {
+        // SAFETY: By the `Arc` type invariant, there is necessarily a reference to the object, so
+        // it is safe to dereference it. Additionally, we know there is only one reference when
+        // it's inside a `UniqueArc`, so it is safe to get a mutable reference.
+        unsafe { &mut self.inner.ptr.as_mut().data }
+    }
+}
-- 
2.34.1

