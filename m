Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C64A267402B
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 18:41:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbjASRl2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 12:41:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbjASRlV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 12:41:21 -0500
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A676490857;
        Thu, 19 Jan 2023 09:41:02 -0800 (PST)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-12c8312131fso3396868fac.4;
        Thu, 19 Jan 2023 09:41:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZwxU4+6BfOCgB1/4NzWZU6FV5+g31u+lXUwKNUQPWUE=;
        b=c+dYUuSKYuS+4cZUhnvuhXuGCB2QiKzx0DR+8tgWN3eHX5UzXiXHfHfTwj2WoMmzYH
         ba5Qtrz3izgo0A2Q13X3Vu3pZ/YhqWE+kCyY53E+Lq/wAGaPoaZRyGMJ04He/K+7g9yK
         eahq4wyCfE0+HlAZJG1aRwK/g+M2QdGhKcPC5lj94CdgILTaStho2MHfxhq9hj67R2Fb
         9FV3sJD1kmT/JnOpLuNmUR3Qd3d363foX4A7w9mJTBBLraIxdMFjuYYpuSoiM9R/eixg
         f19OufXWkBCWzaxc1RLq6HoiJug6w44q3buT5J689WzbLCe4PGRN8gBHKSkxvMbZFqc3
         vxpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZwxU4+6BfOCgB1/4NzWZU6FV5+g31u+lXUwKNUQPWUE=;
        b=q09sSd150cPkyqeKc1L1rJ0reo4T5F0T9xPk2PiOWgpBHVH8kloLLVHTMsOarfhw8v
         QcT9g5gn7wz0JlmvClvMEiu8kkXSMrdixvV2fkledHvzEutPKiNENAyE6qXtIHkDV6e0
         KzcWEhctkaeXavsAboKIjE4QeOxxu2mn/4BCn0rLmn0w62NXZOq3e8Sh1K3Ht3YVNt4w
         L9YqFp955l5rEuJfdae2M52RcEOOihqh0QSeqP9o5rWwnmmESMn5P0GArvZ58dj6oz2C
         OIP97D3koj8TW2oFMiI2V15oC3c7HVD/4KqNld5UO8uq/N1z+fg1A+qT/gtWlZ9EPRAW
         hnIw==
X-Gm-Message-State: AFqh2kqs8qJ74GJTL5xXkSGi9dPzQmizFchgORWPzqDrg618P0Z5LcIQ
        rTZeWOgv+9Xplk/ZOk355qRfPwZVlq9JGpbe
X-Google-Smtp-Source: AMrXdXsFXrFGnZjvHru/SJVQMGciWdnxTDPiMjw3umI7T0KHD+fS4XfJkdaZdi9433DIHx2AHuBXpQ==
X-Received: by 2002:a05:6870:659e:b0:15e:d586:6d46 with SMTP id fp30-20020a056870659e00b0015ed5866d46mr15435524oab.34.1674150061906;
        Thu, 19 Jan 2023 09:41:01 -0800 (PST)
Received: from wedsonaf-dev.home.lan ([189.124.190.154])
        by smtp.googlemail.com with ESMTPSA id i7-20020a056808054700b003631fe1810dsm10226906oig.47.2023.01.19.09.40.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 09:41:01 -0800 (PST)
From:   Wedson Almeida Filho <wedsonaf@gmail.com>
To:     rust-for-linux@vger.kernel.org
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
        linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <wedsonaf@gmail.com>
Subject: [PATCH 2/5] rust: types: introduce `ForeignOwnable`
Date:   Thu, 19 Jan 2023 14:40:33 -0300
Message-Id: <20230119174036.64046-2-wedsonaf@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230119174036.64046-1-wedsonaf@gmail.com>
References: <20230119174036.64046-1-wedsonaf@gmail.com>
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

It was originally called `PointerWrapper`. It is used to convert
a Rust object to a pointer representation (void *) that can be
stored on the C side, used, and eventually returned to Rust.

Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
---
 rust/kernel/lib.rs   |  1 +
 rust/kernel/types.rs | 54 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 55 insertions(+)

diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index e0b0e953907d..223564f9f0cc 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -16,6 +16,7 @@
 #![feature(coerce_unsized)]
 #![feature(core_ffi_c)]
 #![feature(dispatch_from_dyn)]
+#![feature(generic_associated_types)]
 #![feature(receiver_trait)]
 #![feature(unsize)]
 
diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
index f0ad4472292d..5475f6163002 100644
--- a/rust/kernel/types.rs
+++ b/rust/kernel/types.rs
@@ -9,6 +9,60 @@ use core::{
     ops::{Deref, DerefMut},
 };
 
+/// Used to transfer ownership to and from foreign (non-Rust) languages.
+///
+/// Ownership is transferred from Rust to a foreign language by calling [`Self::into_foreign`] and
+/// later may be transferred back to Rust by calling [`Self::from_foreign`].
+///
+/// This trait is meant to be used in cases when Rust objects are stored in C objects and
+/// eventually "freed" back to Rust.
+pub trait ForeignOwnable {
+    /// Type of values borrowed between calls to [`ForeignOwnable::into_foreign`] and
+    /// [`ForeignOwnable::from_foreign`].
+    type Borrowed<'a>;
+
+    /// Converts a Rust-owned object to a foreign-owned one.
+    ///
+    /// The foreign representation is a pointer to void.
+    fn into_foreign(self) -> *const core::ffi::c_void;
+
+    /// Borrows a foreign-owned object.
+    ///
+    /// # Safety
+    ///
+    /// `ptr` must have been returned by a previous call to [`ForeignOwnable::into_foreign`] for
+    /// which a previous matching [`ForeignOwnable::from_foreign`] hasn't been called yet.
+    /// Additionally, all instances (if any) of values returned by [`ForeignOwnable::borrow_mut`]
+    /// for this object must have been dropped.
+    unsafe fn borrow<'a>(ptr: *const core::ffi::c_void) -> Self::Borrowed<'a>;
+
+    /// Mutably borrows a foreign-owned object.
+    ///
+    /// # Safety
+    ///
+    /// `ptr` must have been returned by a previous call to [`ForeignOwnable::into_foreign`] for
+    /// which a previous matching [`ForeignOwnable::from_foreign`] hasn't been called yet.
+    /// Additionally, all instances (if any) of values returned by [`ForeignOwnable::borrow`] and
+    /// [`ForeignOwnable::borrow_mut`] for this object must have been dropped.
+    unsafe fn borrow_mut<T: ForeignOwnable>(ptr: *const core::ffi::c_void) -> ScopeGuard<T, fn(T)> {
+        // SAFETY: The safety requirements ensure that `ptr` came from a previous call to
+        // `into_foreign`.
+        ScopeGuard::new_with_data(unsafe { T::from_foreign(ptr) }, |d| {
+            d.into_foreign();
+        })
+    }
+
+    /// Converts a foreign-owned object back to a Rust-owned one.
+    ///
+    /// # Safety
+    ///
+    /// `ptr` must have been returned by a previous call to [`ForeignOwnable::into_foreign`] for
+    /// which a previous matching [`ForeignOwnable::from_foreign`] hasn't been called yet.
+    /// Additionally, all instances (if any) of values returned by [`ForeignOwnable::borrow`] and
+    /// [`ForeignOwnable::borrow_mut`] for this object must have been dropped.
+    unsafe fn from_foreign(ptr: *const core::ffi::c_void) -> Self;
+}
+
 /// Runs a cleanup function/closure when dropped.
 ///
 /// The [`ScopeGuard::dismiss`] function prevents the cleanup function from running.
-- 
2.34.1

