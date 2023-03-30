Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CD366CFA53
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 06:42:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbjC3EmC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 00:42:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbjC3Ele (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 00:41:34 -0400
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFE8A6A58;
        Wed, 29 Mar 2023 21:41:16 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-17aeb49429eso18554849fac.6;
        Wed, 29 Mar 2023 21:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680151276;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZIKW7/0TFQl6GljEgB3wW2iOFuiG0GQhzQq6GUBT1ww=;
        b=b9kU6CT36DIeFiFv2cLFVYwALpVHAH/iM/S1SgYTEqa+2W1Bii+11r9TC0fQ7CJgS9
         u9VrmW/kP9KJ589PWODX8gDnc6xNODs8+pBNrwRwR3eTjeSxA+eJTcTI4nHV7ItQuQ6s
         ofIMO8Nv9EB79Q2CEm3Ie5y2UK48BIXn93J+sipvKOQA3eDNTqKwOGotAVeggVLpgIA9
         5ByiXTB17NqhXHWkIOXmsNR+2dqopd+1+jJqjYeNCmQBqs/wamOZ2zwcbJ1zou+iRtcy
         mn7z2SCQMmAH8anq6fp4mp0/8aI/R21LeM/RQWYw3itaPYgIunK5RQ4b+5Bxmv186TXR
         Oalw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680151276;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZIKW7/0TFQl6GljEgB3wW2iOFuiG0GQhzQq6GUBT1ww=;
        b=4/T0jIpILRVAcucezL4ibUZ2seRVVSBtjW4acVIMVRyEkz3Mn8QKWweN2tkVCook3H
         m8RDgHHz2nid1yAWpbNgBgZ3tZ7ICbjkr37HLacqdxD6gWypqoKedDyB4ED+b5e7q5FQ
         rmU7Pmh0dZBoZsaOYlbeZxDbNhY8hvVhFX4SpvQaMRXZYBfvCaH76oqO4sqATFJvYG8P
         py+Dy2rsWjHZqJxxWddgY6goRgLeLbR2RfPh0xKnACOIj2jCTD/Vj3pVbqfCVdmQYvKX
         NKnuSCsnPmhMzq5YPwFe9kJ75GY4IFS5K6aRQ8Gvo9exHzeuW+W3rqCEaEYDVtU7o/VL
         sRZA==
X-Gm-Message-State: AO0yUKWEzD8fFOaTKS79xplKJDfwUlyoTtr8oM3SOaOkOoyKdaTxaSyo
        Dpsc3tBTK/4Z4XJfWJGqTmZzfBdg8nKzug==
X-Google-Smtp-Source: AKy350Zc5O+pOuJJyzR9+UAJkNqcodh9wCyaDzbsQDszQGeW3EYCpe2w/NEJx2awjeMqfV6ySHtfzw==
X-Received: by 2002:a05:6870:4581:b0:17e:a4d6:5e0c with SMTP id y1-20020a056870458100b0017ea4d65e0cmr14683787oao.23.1680151275756;
        Wed, 29 Mar 2023 21:41:15 -0700 (PDT)
Received: from wedsonaf-dev.home.lan ([189.124.190.154])
        by smtp.googlemail.com with ESMTPSA id ea43-20020a056870072b00b0017e0c13b29asm7518599oab.36.2023.03.29.21.41.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 21:41:15 -0700 (PDT)
From:   Wedson Almeida Filho <wedsonaf@gmail.com>
To:     rust-for-linux@vger.kernel.org
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
        linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <walmeida@microsoft.com>
Subject: [PATCH 08/13] rust: introduce `ARef`
Date:   Thu, 30 Mar 2023 01:39:49 -0300
Message-Id: <20230330043954.562237-8-wedsonaf@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230330043954.562237-1-wedsonaf@gmail.com>
References: <20230330043954.562237-1-wedsonaf@gmail.com>
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

