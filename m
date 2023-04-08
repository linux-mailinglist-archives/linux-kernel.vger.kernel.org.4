Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B3496DB967
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 09:55:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbjDHHy7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Apr 2023 03:54:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230144AbjDHHyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Apr 2023 03:54:35 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7842810271;
        Sat,  8 Apr 2023 00:54:17 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id f14so18831052oiw.10;
        Sat, 08 Apr 2023 00:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680940457;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S9xdueeJy7MgLea0ONmd9MZ1VHllI6hHaQJbmcDSqvw=;
        b=gJPOyjdIa5tq77ALNTMPC2MFBLNhcROzoktPdDzydEf5g6t1f171CYPi/W6bF+1MJA
         a7NXuCM6eOUDRd0+M6o9IbTb5d1+Ssh0ZyPyZOhZTATdSu0gI96WjxXek3wDqz426r0N
         BEVi2tBlRqofAlJGtL2hom7owEyLzCBRWf9nXyjfmnNZggAFYy1B5ON4uCvSkTV4QcnX
         WiweHjRDLZsMoexiXJ0Wu81iJvxLmeSud9t01K9xmEllmRb7Z69Rfl/cDqpmlDM6L+8W
         +nwO42Zzn23IcAXkzJKO87F4ge9Vi62WpmBykdaxoF3gnyFjTQ9aHrxOvPWhls9kQY+7
         q6kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680940457;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S9xdueeJy7MgLea0ONmd9MZ1VHllI6hHaQJbmcDSqvw=;
        b=j/fOvvVHSxF8HFbZ3Rd04MOq3ocrXJceYPLzy+gJ3k3h1MyAfRh5VWKjsY+q7i0AFk
         4xJERmHnZ5Wl02gZBkTyLVq5kuXwyewDYNpQHyr3N9vPjmhkOccs4qaYzs+y+FG+LgG4
         O6siY+XQJZV1YOytY9Pr8raDi5o1S+5w8Dz5oyGuq+B+jh2pB2yY0ViN9a2jmtNUOfDB
         +VRc7B8khbbB3qQnnnWNEUcbWdJuiLPpbVoGkCMufCT8PIT+w1cocvy0H2maj0aCR/Xj
         sytq7pQNJolomk5xwpkrsuz/M1395mVFpOkR2DIPovtD7tSPVcBRePZT6eptXS/f3/0U
         V2SQ==
X-Gm-Message-State: AAQBX9dI68dO8vTUccKuxKKeYpblF/N94Necvm9AD6V1Wn0/Pzb0ePcP
        I5YCFJPCQ3V6VllaiS56xL+a9fJ3l8o=
X-Google-Smtp-Source: AKy350aByny0Ua7+HLInjCklu0BXubtnbbdwM9B/AA9HVLWv2BDeGGNMGXCSAcgEacOQdoUCAP1nZQ==
X-Received: by 2002:a05:6808:16a7:b0:386:9af9:96db with SMTP id bb39-20020a05680816a700b003869af996dbmr2027862oib.38.1680940457034;
        Sat, 08 Apr 2023 00:54:17 -0700 (PDT)
Received: from wedsonaf-dev.home.lan ([189.124.190.154])
        by smtp.googlemail.com with ESMTPSA id o6-20020a4a9586000000b0051ffe0fe11bsm2435175ooi.6.2023.04.08.00.54.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Apr 2023 00:54:16 -0700 (PDT)
From:   Wedson Almeida Filho <wedsonaf@gmail.com>
To:     rust-for-linux@vger.kernel.org
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
        linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <walmeida@microsoft.com>
Subject: [PATCH v3 08/13] rust: introduce `ARef`
Date:   Sat,  8 Apr 2023 04:53:35 -0300
Message-Id: <20230408075340.25237-8-wedsonaf@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230408075340.25237-1-wedsonaf@gmail.com>
References: <20230408075340.25237-1-wedsonaf@gmail.com>
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
v2 -> v3: No changes

 rust/kernel/types.rs | 107 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 107 insertions(+)

diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
index 3a46ec1a00cd..73709ce1f0a1 100644
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
@@ -268,6 +270,111 @@ impl<T> Opaque<T> {
     }
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

