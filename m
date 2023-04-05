Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F25A06D8543
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 19:52:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232530AbjDERwU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 13:52:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232079AbjDERwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 13:52:17 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CCD065B2;
        Wed,  5 Apr 2023 10:52:07 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id b19so27233751oib.7;
        Wed, 05 Apr 2023 10:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680717127;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sG++w8NyFtmU3a0MKdVasgEDSXcDlxmofOYd/dEc4Vg=;
        b=MqTYpyAJ0uiRFQpxjXrrJm0DoawAd2L4V+h9dx2IhPXHokDFQ0nQosHQrSNLNNW3Eo
         z6vOY/TRmvjtzI7nD3AwKa5mBy6xN/VvLktI8E9nNvDXCz3+qXze8p7iPC58i+w/b0rW
         9p22SV0DtBbtIIR3fzf+hccTgSsXyL/zSTXAiwTB/IsjVP/B5GXSdIDlA+AmO95Eoj6q
         Sa0vO6fEis4pZtAOdFCznr26WIZKeiuBgO4d0djF6daQDx9iNyhlq3glL+VObxTbTCxo
         RbG3upqiyIosE7AUb3Jj7xmC5ZlygF9XB3nRF2icOXCgN3egsgfWWb2lxxGBzviR+Qbr
         ZylA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680717127;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sG++w8NyFtmU3a0MKdVasgEDSXcDlxmofOYd/dEc4Vg=;
        b=FzQyGyLQsXhFsa9e8lbdlN8dRloXb5BzP7j320LC76xrszOSrxM030Xift10+jKNoc
         QWYlGaaDPt54fH2E9++lA2OjgfxXXp2ZeaKH6lSfX+pGSXlLI3Sqj5PRIDSPT8bImoq8
         7U+kspqGt7qPY8h03ZFq/aMQsi8p2rkwfBguLgoSczZnpWLx+CDJwvlOnHqKzgDFPWkm
         PhC65svNUrrAA0eur0iB5GrXYqVpUIXqZHr1a6HuTQCPAGI+Kiy4Su0C8Ju8qZX5OUN4
         D9gOd9l1SRBuqj20IzVzdaBA/sUx7KgwJ6CkadRf9WfQxAFtFxWWZXz+MzAkRVGW8jJN
         Xjfw==
X-Gm-Message-State: AAQBX9fSLUGjbgdFTTQrVYpHFBYU/wLaNgcGl0eIgARC96h/w+MxHC/h
        a4wI87XRZsa3o4MYih1ipZIiObOpFc8=
X-Google-Smtp-Source: AKy350aLoVyVPn3feTTFZLJ056HP8gggLDXJWePrtJRPJWhL6GCPiTc2OS03gnKMK29D80yhHJAN1g==
X-Received: by 2002:aca:1e0b:0:b0:387:2075:59b with SMTP id m11-20020aca1e0b000000b003872075059bmr2901893oic.24.1680717127067;
        Wed, 05 Apr 2023 10:52:07 -0700 (PDT)
Received: from wedsonaf-dev.home.lan ([189.124.190.154])
        by smtp.googlemail.com with ESMTPSA id w185-20020aca62c2000000b003896e31867esm6604045oib.49.2023.04.05.10.52.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 10:52:06 -0700 (PDT)
From:   Wedson Almeida Filho <wedsonaf@gmail.com>
To:     rust-for-linux@vger.kernel.org
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
        linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <walmeida@microsoft.com>
Subject: [PATCH v2 06/13] rust: lock: add support for `Lock::lock_irqsave`
Date:   Wed,  5 Apr 2023 14:51:04 -0300
Message-Id: <20230405175111.5974-6-wedsonaf@gmail.com>
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

This allows locks like spinlocks and raw spinlocks to expose a
`lock_irqsave` variant in Rust that corresponds to the C version.

Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
---
v1 -> v2: No changes

 rust/kernel/sync/lock.rs | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/rust/kernel/sync/lock.rs b/rust/kernel/sync/lock.rs
index bca9af2a9a5a..491446c3a074 100644
--- a/rust/kernel/sync/lock.rs
+++ b/rust/kernel/sync/lock.rs
@@ -57,6 +57,29 @@ pub unsafe trait Backend {
     unsafe fn unlock(ptr: *mut Self::State, guard_state: &Self::GuardState);
 }
 
+/// The "backend" of a lock that supports the irq-save variant.
+///
+/// # Safety
+///
+/// The same requirements wrt mutual exclusion in [`Backend`] apply for acquiring the lock via
+/// [`IrqSaveBackend::lock_irqsave`].
+///
+/// Additionally, when [`IrqSaveBackend::lock_irqsave`] is used to acquire the lock, implementers
+/// must disable interrupts on lock, and restore interrupt state on unlock. Implementers may use
+/// [`Backend::GuardState`] to store state needed to keep track of the interrupt state.
+pub unsafe trait IrqSaveBackend: Backend {
+    /// Acquires the lock, making the caller its owner.
+    ///
+    /// Before acquiring the lock, it disables interrupts, and returns the previous interrupt state
+    /// as its guard state so that the guard can restore it when it is dropped.
+    ///
+    /// # Safety
+    ///
+    /// Callers must ensure that [`Backend::init`] has been previously called.
+    #[must_use]
+    unsafe fn lock_irqsave(ptr: *mut Self::State) -> Self::GuardState;
+}
+
 /// A mutual exclusion primitive.
 ///
 /// Exposes one of the kernel locking primitives. Which one is exposed depends on the lock banckend
@@ -109,6 +132,21 @@ impl<T: ?Sized, B: Backend> Lock<T, B> {
     }
 }
 
+impl<T: ?Sized, B: IrqSaveBackend> Lock<T, B> {
+    /// Acquires the lock and gives the caller access to the data protected by it.
+    ///
+    /// Before acquiring the lock, it disables interrupts. When the guard is dropped, the interrupt
+    /// state (either enabled or disabled) is restored to its state before
+    /// [`lock_irqsave`](Self::lock_irqsave) was called.
+    pub fn lock_irqsave(&self) -> Guard<'_, T, B> {
+        // SAFETY: The constructor of the type calls `init`, so the existence of the object proves
+        // that `init` was called.
+        let state = unsafe { B::lock_irqsave(self.state.get()) };
+        // SAFETY: The lock was just acquired.
+        unsafe { Guard::new(self, state) }
+    }
+}
+
 /// A lock guard.
 ///
 /// Allows mutual exclusion primitives that implement the `Backend` trait to automatically unlock
-- 
2.34.1

