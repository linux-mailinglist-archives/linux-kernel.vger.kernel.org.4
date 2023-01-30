Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C83A68061F
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 07:44:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235828AbjA3Gom (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 01:44:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235746AbjA3Goc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 01:44:32 -0500
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54A911423B;
        Sun, 29 Jan 2023 22:44:31 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id dt8so6166399oib.0;
        Sun, 29 Jan 2023 22:44:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lcoHsPxq8wVGl54MVPcRLlL61B4LcEe/VoM4sx/i6CI=;
        b=GdCNzoVy6C9eZXiBn/+g07Yxh+x4Eeck7GAtnKymZzppORxSaPwYrdriEz8uP+7gxD
         3clET0B2eZZaHsyIN+hca4/6PTIzBgIUGnf1RtHoCXODNzq/GQvPKDpkk8mmzTJc4cHc
         SBEm0hFrWt6ObonlYgUYGA9b9uP29FeaFHBfDmlCulH/BMrl+F+UnPJOgETRoCbWQ1p7
         7YrKFdz9V6eCIMEAmnHZx4jRsNQnJjFO3D1ctvHXWACo0h4t27YNcl9Oqk/x9KFJ9YL4
         BvzyNhoQtSNWS9+Q3bi1iwGy4Hq/zEibw3lEzIeETY3ZU5IU8gC/cfUIGhhesZ7A6eU6
         KjkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lcoHsPxq8wVGl54MVPcRLlL61B4LcEe/VoM4sx/i6CI=;
        b=isNs9o4BmYpiPfF696iYyNH5H9AeadEo80egiewMau0Py62eZC343okBHMhwguMkJh
         ywEJnBHed9eyqp6WRvjtVvlmkdM+JRB58oeAexbygXDS+KE+v2cYaWw8QwJ3B+LZjQ8+
         K/Ev9Z7yr4K62pA0Qk3fdo3RrO9+yeaiyBUzYCH9evbmo30YopzjxD1dSsnC3TnH1r2X
         fF6b9iucsoSTbw0UWOvuysUEMzhNiNncfWgnh58OTUFyMDG+IfePU5LR62yOJ6sWeira
         dhtf0jG248p+WYmVJJyS39ECgXilk5volVWAEv+nV1wL7K0Bt/WcEyf/WVGmUCCqD8Eo
         3wnw==
X-Gm-Message-State: AFqh2koI73/p36BiKmKTcoo/a0or8PC3k2ge53x+Lsz20c825qC/8Aft
        MIoI2Toa9yR3d1ZSxEYbFRTlypALyLYCbaCm
X-Google-Smtp-Source: AMrXdXvL7TnAYkwwJSe8XAts7h2YFxWyONTchyS21geU7fUOUKBo7VoNqlQQWT8j4HyBgEsKzk1/Hw==
X-Received: by 2002:a05:6808:3186:b0:36e:bab6:cb71 with SMTP id cd6-20020a056808318600b0036ebab6cb71mr20074711oib.50.1675061070677;
        Sun, 29 Jan 2023 22:44:30 -0800 (PST)
Received: from wedsonaf-dev.home.lan ([189.124.190.154])
        by smtp.googlemail.com with ESMTPSA id o64-20020aca5a43000000b003670342726fsm4427883oib.12.2023.01.29.22.44.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Jan 2023 22:44:30 -0800 (PST)
From:   Wedson Almeida Filho <wedsonaf@gmail.com>
To:     rust-for-linux@vger.kernel.org
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
        linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Vincenzo Palazzo <vincenzopalazzodev@gmail.com>,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Subject: [PATCH v2 2/5] rust: types: introduce `ForeignOwnable`
Date:   Mon, 30 Jan 2023 03:44:01 -0300
Message-Id: <20230130064404.744600-2-wedsonaf@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230130064404.744600-1-wedsonaf@gmail.com>
References: <20230130064404.744600-1-wedsonaf@gmail.com>
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
Reviewed-by: Vincenzo Palazzo <vincenzopalazzodev@gmail.com>
Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
---
v1 -> v2: Use `Self` instead of generic type in `borrow_mut`

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
index dd834bfcb57b..72710b7442a3 100644
--- a/rust/kernel/types.rs
+++ b/rust/kernel/types.rs
@@ -8,6 +8,60 @@ use core::{
     ops::{Deref, DerefMut},
 };
 
+/// Used to transfer ownership to and from foreign (non-Rust) languages.
+///
+/// Ownership is transferred from Rust to a foreign language by calling [`Self::into_foreign`] and
+/// later may be transferred back to Rust by calling [`Self::from_foreign`].
+///
+/// This trait is meant to be used in cases when Rust objects are stored in C objects and
+/// eventually "freed" back to Rust.
+pub trait ForeignOwnable: Sized {
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
+    unsafe fn borrow_mut(ptr: *const core::ffi::c_void) -> ScopeGuard<Self, fn(Self)> {
+        // SAFETY: The safety requirements ensure that `ptr` came from a previous call to
+        // `into_foreign`.
+        ScopeGuard::new_with_data(unsafe { Self::from_foreign(ptr) }, |d| {
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

