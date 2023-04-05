Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6667A6D8545
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 19:52:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232978AbjDERwt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 13:52:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232079AbjDERwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 13:52:47 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EE4A729F;
        Wed,  5 Apr 2023 10:52:19 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id y184so27232254oiy.8;
        Wed, 05 Apr 2023 10:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680717138;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yDKrcsZh/wP/lITy5QMY3W9uqlt+ywEoUOGYJrXbNMY=;
        b=B/OTciN28kbRHCwGguPcjRZzHoK8qkWPrMjQOltw7nWygfMtMu8Fq3RBOlurtP5vIo
         cD5ZIDTTmI9fUJGEWt1e/oEQuKOFJEuM0RT9GqGRHPrsJhBnxEMsw0ymiqqAo1WKEmb1
         BtPyexqr5J6zBpeCCmo2XosylDfOCLH1G7aTdxJ9TjdBfRFrZNJkl7I+1n6zFaRJ437Q
         wVgX9fwX0Kg5lgJ6sH24X3XaZ4GNNbGcb3wstSU7fbv6woY5MgnOOmgz3i96fPY3IoCL
         a2TXs3XSh38D3ybYh9rPZi+OX1UG6EjKHfIkdU4vXA9JV4iIurUSS2fDghs/+dNabLmK
         0ePw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680717138;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yDKrcsZh/wP/lITy5QMY3W9uqlt+ywEoUOGYJrXbNMY=;
        b=FamiMgBgYvLQoFWSPtFD1QyjnuY0OYo6I1o1bIykIRN2HGJsXKJ+j7JuYt5dopYHuI
         8KxZhmr/UD7UHgxgDJWGrfpRsnz3D7DuiMkAkO6Q3e4pNy2lJxHZTzusARtjweUzxt5f
         zc+GVa74Ab3l/qi846CJp+26qicD8iyOR+lYMRjFJ1nXJBz3dl/CTsZLTV4UaHWMo7Vx
         eR7D+R5rTxWTmHBn1hFm1/dYR6Ya4JyJfnvBZCw4VbDnzp1rv5CIJhtIh+dZQd4IFQlx
         K8rU7kToYcm4Tj27WzpnlA6EmzZlVoLjm9Mv7mi5TWoYcO7L9qXulCZWMU/emCoxQ9Ec
         721g==
X-Gm-Message-State: AAQBX9camDSVcm1mdbMfZfGXbkUKHtY4KBfUxCEoJX4FZqGjs44wSXeY
        hIAfZrN7DEbl1F+O7Go65jEghX+nFkI=
X-Google-Smtp-Source: AKy350Zqt6Q4jHFed7v6ozdKW+xZlpX/wxm6BlSwVvzipxiDAM6xqQOYzQVhYCWHkSQacwrvXYevew==
X-Received: by 2002:aca:2210:0:b0:386:9873:d377 with SMTP id b16-20020aca2210000000b003869873d377mr2780365oic.56.1680717137736;
        Wed, 05 Apr 2023 10:52:17 -0700 (PDT)
Received: from wedsonaf-dev.home.lan ([189.124.190.154])
        by smtp.googlemail.com with ESMTPSA id w185-20020aca62c2000000b003896e31867esm6604045oib.49.2023.04.05.10.52.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 10:52:17 -0700 (PDT)
From:   Wedson Almeida Filho <wedsonaf@gmail.com>
To:     rust-for-linux@vger.kernel.org
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
        linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <walmeida@microsoft.com>
Subject: [PATCH v2 08/13] rust: introduce `ARef`
Date:   Wed,  5 Apr 2023 14:51:06 -0300
Message-Id: <20230405175111.5974-8-wedsonaf@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230405175111.5974-1-wedsonaf@gmail.com>
References: <20230405175111.5974-1-wedsonaf@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wedson Almeida Filho <walmeida@microsoft.com>

This is an owned reference to an object that is always ref-counted. This
is meant to be used in wrappers for C types that have their own ref
counting functions, for example, tasks, files, inodes, dentries, etc.

Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
---
v1 -> v2: No changes

 rust/kernel/types.rs | 107 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 107 insertions(+)

diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
index dbfae9bb97ce..b071730253c7 100644
--- a/rust/kernel/types.rs
+++ b/rust/kernel/types.rs
@@ -6,8 +6,10 @@ use crate::init::{self, PinInit};
 use alloc::boxed::Box;
 use core::{
     cell::UnsafeCell,
+    marker::PhantomData,
     mem::MaybeUninit,
     ops::{Deref, DerefMut},
+    ptr::NonNull,
 };
 
 /// Used to transfer ownership to and from foreign (non-Rust) languages.
@@ -295,6 +297,111 @@ opaque_init_funcs! {
     "Rust" manual_init4(arg1: A1, arg2: A2, arg3: A3, arg4: A4);
 }
 
+/// Types that are _always_ reference counted.
+///
+/// It allows such types to define their own custom ref increment and decrement functions.
+/// Additionally, it allows users to convert from a shared reference `&T` to an owned reference
+/// [`ARef<T>`].
+///
+/// This is usually implemented by wrappers to existing structures on the C side of the code. For
+/// Rust code, the recommendation is to use [`Arc`](crate::sync::Arc) to create reference-counted
+/// instances of a type.
+///
+/// # Safety
+///
+/// Implementers must ensure that increments to the reference count keep the object alive in memory
+/// at least until matching decrements are performed.
+///
+/// Implementers must also ensure that all instances are reference-counted. (Otherwise they
+/// won't be able to honour the requirement that [`AlwaysRefCounted::inc_ref`] keep the object
+/// alive.)
+pub unsafe trait AlwaysRefCounted {
+    /// Increments the reference count on the object.
+    fn inc_ref(&self);
+
+    /// Decrements the reference count on the object.
+    ///
+    /// Frees the object when the count reaches zero.
+    ///
+    /// # Safety
+    ///
+    /// Callers must ensure that there was a previous matching increment to the reference count,
+    /// and that the object is no longer used after its reference count is decremented (as it may
+    /// result in the object being freed), unless the caller owns another increment on the refcount
+    /// (e.g., it calls [`AlwaysRefCounted::inc_ref`] twice, then calls
+    /// [`AlwaysRefCounted::dec_ref`] once).
+    unsafe fn dec_ref(obj: NonNull<Self>);
+}
+
+/// An owned reference to an always-reference-counted object.
+///
+/// The object's reference count is automatically decremented when an instance of [`ARef`] is
+/// dropped. It is also automatically incremented when a new instance is created via
+/// [`ARef::clone`].
+///
+/// # Invariants
+///
+/// The pointer stored in `ptr` is non-null and valid for the lifetime of the [`ARef`] instance. In
+/// particular, the [`ARef`] instance owns an increment on the underlying object's reference count.
+pub struct ARef<T: AlwaysRefCounted> {
+    ptr: NonNull<T>,
+    _p: PhantomData<T>,
+}
+
+impl<T: AlwaysRefCounted> ARef<T> {
+    /// Creates a new instance of [`ARef`].
+    ///
+    /// It takes over an increment of the reference count on the underlying object.
+    ///
+    /// # Safety
+    ///
+    /// Callers must ensure that the reference count was incremented at least once, and that they
+    /// are properly relinquishing one increment. That is, if there is only one increment, callers
+    /// must not use the underlying object anymore -- it is only safe to do so via the newly
+    /// created [`ARef`].
+    pub unsafe fn from_raw(ptr: NonNull<T>) -> Self {
+        // INVARIANT: The safety requirements guarantee that the new instance now owns the
+        // increment on the refcount.
+        Self {
+            ptr,
+            _p: PhantomData,
+        }
+    }
+}
+
+impl<T: AlwaysRefCounted> Clone for ARef<T> {
+    fn clone(&self) -> Self {
+        self.inc_ref();
+        // SAFETY: We just incremented the refcount above.
+        unsafe { Self::from_raw(self.ptr) }
+    }
+}
+
+impl<T: AlwaysRefCounted> Deref for ARef<T> {
+    type Target = T;
+
+    fn deref(&self) -> &Self::Target {
+        // SAFETY: The type invariants guarantee that the object is valid.
+        unsafe { self.ptr.as_ref() }
+    }
+}
+
+impl<T: AlwaysRefCounted> From<&T> for ARef<T> {
+    fn from(b: &T) -> Self {
+        b.inc_ref();
+        // SAFETY: We just incremented the refcount above.
+        unsafe { Self::from_raw(NonNull::from(b)) }
+    }
+}
+
+impl<T: AlwaysRefCounted> Drop for ARef<T> {
+    fn drop(&mut self) {
+        // SAFETY: The type invariants guarantee that the `ARef` owns the reference we're about to
+        // decrement.
+        unsafe { T::dec_ref(self.ptr) };
+    }
+}
+
 /// A sum type that always holds either a value of type `L` or `R`.
 pub enum Either<L, R> {
     /// Constructs an instance of [`Either`] containing a value of type `L`.
-- 
2.34.1

