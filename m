Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84A4F74CED7
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 09:47:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231307AbjGJHrC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 03:47:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbjGJHrA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 03:47:00 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A168CEB
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 00:46:58 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-57704af0e64so50420167b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 00:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688975218; x=1691567218;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MGNzMe146hTD4+JHH/sdI+of9UzEENP5Y2MiBmMPDb4=;
        b=bC7wieI319tmSd4G8BgSE3FSS50HOJXoG9P+64syprXEvvCuFBMMwcDaXRKqb3tjY4
         +ufFZszVznq5CFOB5jtVgZffOY2SZqCCVBBObhkPKMxLQqyyV1t72r8l1thi+vQBqb0O
         C8i+ikj2SZePquFyR7kKjOYUwYt088rZFHFuCfNFKPEd6BWN8oiO71nDXjU5PdfNnnTX
         AtWhPmxJZaMfPEUjFsuDTLmwEntyIFb0YleTEQ95S29PGloe9EQm0E7IG8dwXOTLksLO
         CiHXCDWpcjpQAY671FEamkA0uKrS1taZVdxowY+BZun7C/Elx7Kb4rTWxBqlYpL58hEw
         HZaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688975218; x=1691567218;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MGNzMe146hTD4+JHH/sdI+of9UzEENP5Y2MiBmMPDb4=;
        b=lyQbH/WgSjTS/AaIVGIR+mt2pfLCFaPoOQ7yzrg9Y3Hlvh33+VqqFUFAB4iAzTFmo4
         mXgKcHkB1ON6PeOmaqwTPV7KM/dKCXP3RbFDgm/UAroaj84rDRrnF9xr28OKze21X9jX
         0qKYNPwOLagYQ3a2vexOLTrfm38jw6iZEoHGU+ogdJNBhE3b1TFpcX5VTVJ1vWUbaHs3
         StlMl1ddHZMiXDJxU4VY9NCvtMLBMdpttzN1LysW1TD+GI5d7fgmTw9NlHJn316XSl1e
         Pj8/UZHd1Irz+vGwxNIz47QOoKGeHJrRBuRp58bWZQVHsFwDIYSqyCNbwm4qSELrevN+
         kMAA==
X-Gm-Message-State: ABy/qLaOC64J7pPefPO5TVjkRLPDIXekosKnC4LUOcdADDRpthEIarE8
        X1yGj9qxmHRkY0Zz/esy6vRLg3VQoibN9Uo=
X-Google-Smtp-Source: APBJJlEbtHxEEU6s7tJDycOmd0CAGmWN21unIj9h1OG72i3+IVpWIAesZj9DiScL47LBuE8ZU/NXTpSAZ9S+Trw=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:6c8])
 (user=aliceryhl job=sendgmr) by 2002:a81:b54f:0:b0:56d:502:9eb0 with SMTP id
 c15-20020a81b54f000000b0056d05029eb0mr82086ywk.6.1688975217853; Mon, 10 Jul
 2023 00:46:57 -0700 (PDT)
Date:   Mon, 10 Jul 2023 07:46:42 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230710074642.683831-1-aliceryhl@google.com>
Subject: [PATCH v1] rust: add improved version of `ForeignOwnable::borrow_mut`
From:   Alice Ryhl <aliceryhl@google.com>
To:     rust-for-linux@vger.kernel.org
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        "=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?=" <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Alice Ryhl <aliceryhl@google.com>,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previously, the `ForeignOwnable` trait had a method called `borrow_mut`
that was intended to provide mutable access to the inner value. However,
the method accidentally made it possible to change the address of the
object being modified, which usually isn't what we want. (And when we
want that, it can be done by calling `from_foreign` and `into_foreign`,
like how the old `borrow_mut` was implemented.)

In this patch, we introduce an alternate definition of `borrow_mut` that
solves the previous problem. Conceptually, given a pointer type `P` that
implements `ForeignOwnable`, the `borrow_mut` method gives you the same
kind of access as an `&mut P` would, except that it does not let you
change the pointer `P` itself.

This is analogous to how the existing `borrow` method provides the same
kind of access to the inner value as an `&P`.

Note that for types like `Arc`, having an `&mut Arc<T>` only gives you
immutable access to the inner `T`. This is because mutable references
assume exclusive access, but there might be other handles to the same
reference counted value, so the access isn't exclusive. The `Arc` type
implements this by making `borrow_mut` return the same type as `borrow`.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---

This patch depends on https://lore.kernel.org/all/20230706094615.3080784-1-aliceryhl@google.com/

 rust/kernel/sync/arc.rs | 31 +++++++++-----
 rust/kernel/types.rs    | 93 ++++++++++++++++++++++++++++++-----------
 2 files changed, 89 insertions(+), 35 deletions(-)
 
diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
index d479f8da8f38..1c2fb36906b6 100644
--- a/rust/kernel/types.rs
+++ b/rust/kernel/types.rs
@@ -20,66 +20,111 @@
 /// This trait is meant to be used in cases when Rust objects are stored in C objects and
 /// eventually "freed" back to Rust.
 pub trait ForeignOwnable: Sized {
-    /// Type of values borrowed between calls to [`ForeignOwnable::into_foreign`] and
-    /// [`ForeignOwnable::from_foreign`].
+    /// Type used to immutably borrow a value that is currently foreign-owned.
     type Borrowed<'a>;
 
+    /// Type used to mutably borrow a value that is currently foreign-owned.
+    type BorrowedMut<'a>;
+
     /// Converts a Rust-owned object to a foreign-owned one.
     ///
     /// The foreign representation is a pointer to void.
     fn into_foreign(self) -> *const core::ffi::c_void;
 
-    /// Borrows a foreign-owned object.
-    ///
-    /// # Safety
-    ///
-    /// `ptr` must have been returned by a previous call to [`ForeignOwnable::into_foreign`] for
-    /// which a previous matching [`ForeignOwnable::from_foreign`] hasn't been called yet.
-    unsafe fn borrow<'a>(ptr: *const core::ffi::c_void) -> Self::Borrowed<'a>;
-
     /// Converts a foreign-owned object back to a Rust-owned one.
     ///
     /// # Safety
     ///
-    /// `ptr` must have been returned by a previous call to [`ForeignOwnable::into_foreign`] for
-    /// which a previous matching [`ForeignOwnable::from_foreign`] hasn't been called yet.
-    /// Additionally, all instances (if any) of values returned by [`ForeignOwnable::borrow`] for
-    /// this object must have been dropped.
+    /// The provided pointer must have been returned by a previous call to [`into_foreign`], and it
+    /// must not be passed to `from_foreign` more than once.
+    ///
+    /// [`into_foreign`]: Self::into_foreign
     unsafe fn from_foreign(ptr: *const core::ffi::c_void) -> Self;
+
+    /// Borrows a foreign-owned object immutably.
+    ///
+    /// This method provides a way to access a foreign-owned value from Rust immutably. It provides
+    /// you with exactly the same abilities as an `&Self` when the value is Rust-owned.
+    ///
+    /// # Safety
+    ///
+    /// The provided pointer must have been returned by a previous call to [`into_foreign`], and if
+    /// the pointer is ever passed to [`from_foreign`], then that call must happen after the end of
+    /// the lifetime 'a.
+    ///
+    /// [`into_foreign`]: Self::into_foreign
+    /// [`from_foreign`]: Self::from_foreign
+    unsafe fn borrow<'a>(ptr: *const core::ffi::c_void) -> Self::Borrowed<'a>;
+
+    /// Borrows a foreign-owned object mutably.
+    ///
+    /// This method provides a way to access a foreign-owned value from Rust mutably. It provides
+    /// you with exactly the same abilities as an `&mut Self` when the value is Rust-owned, except
+    /// that this method does not let you swap the foreign-owned object for another. (That is, it
+    /// does not let you change the address of the void pointer that the foreign code is storing.)
+    ///
+    /// Note that for types like [`Arc`], an `&mut Arc<T>` only gives you immutable access to the
+    /// inner value, so this method also only provides immutable access in that case.
+    ///
+    /// In the case of `Box<T>`, this method gives you the ability to modify the inner `T`, but it
+    /// does not let you change the box itself. That is, you cannot change which allocation the box
+    /// points at.
+    ///
+    /// # Safety
+    ///
+    /// The provided pointer must have been returned by a previous call to [`into_foreign`], and if
+    /// the pointer is ever passed to [`from_foreign`], then that call must happen after the end of
+    /// the lifetime 'a.
+    ///
+    /// The lifetime 'a must not overlap with the lifetime of any other call to [`borrow`] or
+    /// `borrow_mut` on the same object.
+    ///
+    /// [`into_foreign`]: Self::into_foreign
+    /// [`from_foreign`]: Self::from_foreign
+    /// [`borrow`]: Self::borrow
+    /// [`Arc`]: crate::sync::Arc
+    unsafe fn borrow_mut<'a>(ptr: *const core::ffi::c_void) -> Self::BorrowedMut<'a>;
 }
 
 impl<T: 'static> ForeignOwnable for Box<T> {
     type Borrowed<'a> = &'a T;
+    type BorrowedMut<'a> = &'a mut T;
 
     fn into_foreign(self) -> *const core::ffi::c_void {
         Box::into_raw(self) as _
     }
 
-    unsafe fn borrow<'a>(ptr: *const core::ffi::c_void) -> &'a T {
-        // SAFETY: The safety requirements for this function ensure that the object is still alive,
-        // so it is safe to dereference the raw pointer.
-        // The safety requirements of `from_foreign` also ensure that the object remains alive for
-        // the lifetime of the returned value.
-        unsafe { &*ptr.cast() }
-    }
-
     unsafe fn from_foreign(ptr: *const core::ffi::c_void) -> Self {
         // SAFETY: The safety requirements of this function ensure that `ptr` comes from a previous
         // call to `Self::into_foreign`.
         unsafe { Box::from_raw(ptr as _) }
     }
+
+    unsafe fn borrow<'a>(ptr: *const core::ffi::c_void) -> &'a T {
+        // SAFETY: The safety requirements of this method ensure that the object remains alive and
+        // immutable for the duration of 'a.
+        unsafe { &*ptr.cast() }
+    }
+
+    unsafe fn borrow_mut<'a>(ptr: *const core::ffi::c_void) -> &'a mut T {
+        // SAFETY: The safety requirements of this method ensure that the pointer is valid and that
+        // nothing else will access the value for the duration of 'a.
+        unsafe { &mut *ptr.cast_mut().cast() }
+    }
 }
 
 impl ForeignOwnable for () {
     type Borrowed<'a> = ();
+    type BorrowedMut<'a> = ();
 
     fn into_foreign(self) -> *const core::ffi::c_void {
         core::ptr::NonNull::dangling().as_ptr()
     }
 
-    unsafe fn borrow<'a>(_: *const core::ffi::c_void) -> Self::Borrowed<'a> {}
-
     unsafe fn from_foreign(_: *const core::ffi::c_void) -> Self {}
+
+    unsafe fn borrow<'a>(_: *const core::ffi::c_void) -> Self::Borrowed<'a> {}
+    unsafe fn borrow_mut<'a>(_: *const core::ffi::c_void) -> Self::BorrowedMut<'a> {}
 }
 
 /// Runs a cleanup function/closure when dropped.

diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
index 172f563976a9..f152a562c9c3 100644
--- a/rust/kernel/sync/arc.rs
+++ b/rust/kernel/sync/arc.rs
@@ -232,26 +232,35 @@ pub fn ptr_eq(this: &Self, other: &Self) -> bool {
 
 impl<T: 'static> ForeignOwnable for Arc<T> {
     type Borrowed<'a> = ArcBorrow<'a, T>;
+    // Mutable access to the `Arc` does not give any extra abilities over
+    // immutable access.
+    type BorrowedMut<'a> = ArcBorrow<'a, T>;
 
     fn into_foreign(self) -> *const core::ffi::c_void {
         ManuallyDrop::new(self).ptr.as_ptr() as _
     }
 
-    unsafe fn borrow<'a>(ptr: *const core::ffi::c_void) -> ArcBorrow<'a, T> {
-        // SAFETY: By the safety requirement of this function, we know that `ptr` came from
-        // a previous call to `Arc::into_foreign`.
-        let inner = NonNull::new(ptr as *mut ArcInner<T>).unwrap();
-
-        // SAFETY: The safety requirements of `from_foreign` ensure that the object remains alive
-        // for the lifetime of the returned value.
-        unsafe { ArcBorrow::new(inner) }
-    }
-
     unsafe fn from_foreign(ptr: *const core::ffi::c_void) -> Self {
         // SAFETY: By the safety requirement of this function, we know that `ptr` came from
         // a previous call to `Arc::into_foreign`, which guarantees that `ptr` is valid and
         // holds a reference count increment that is transferrable to us.
-        unsafe { Self::from_inner(NonNull::new(ptr as _).unwrap()) }
+        unsafe { Self::from_inner(NonNull::new_unchecked(ptr as _)) }
     }
+
+    unsafe fn borrow<'a>(ptr: *const core::ffi::c_void) -> ArcBorrow<'a, T> {
+        // SAFETY: By the safety requirement of this function, we know that `ptr` came from
+        // a previous call to `Arc::into_foreign`.
+        let inner = unsafe { NonNull::new_unchecked(ptr as *mut ArcInner<T>) };
+
+        // SAFETY: The safety requirements ensure that we will not give up our
+        // foreign-owned refcount while the `ArcBorrow` is still live.
+        unsafe { ArcBorrow::new(inner) }
+    }
+
+    unsafe fn borrow_mut<'a>(ptr: *const core::ffi::c_void) -> ArcBorrow<'a, T> {
+        // SAFETY: The safety requirements for `borrow_mut` are a superset of the safety
+        // requirements for `borrow`.
+        unsafe { Self::borrow(ptr) }
+    }
 }

base-commit: d2e3115d717197cb2bc020dd1f06b06538474ac3
prerequisite-patch-id: b493b9015cb19f599c4bc03127733193b11ca822
-- 
2.41.0.255.g8b1d071c50-goog

