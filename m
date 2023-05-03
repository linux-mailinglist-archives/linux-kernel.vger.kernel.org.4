Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 232E06F53FE
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 11:08:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229569AbjECJH5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 05:07:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbjECJHi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 05:07:38 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B1CA4EC5
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 02:07:24 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-3062678861fso2733867f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 May 2023 02:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20221208.gappssmtp.com; s=20221208; t=1683104843; x=1685696843;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BtKpWEX99/tXFIUB1b2EGEDNutHLi8kX/M6s4oIe5M4=;
        b=CxSTo+18rMVa2ypTkZTy0wLUDTZw1QYq8jpoxdVhk/p84nZH5UHbiZq1swvBWxc3Xl
         r2kO5WRrEPvmzDQeUiP6rVG+UuPHdE+apzClMIY04+UBt5rRJASMvfHzn8yHzRZItfCa
         eICcSstADFeX/SdIHIB5B8+VFI4XL8BgekNIxDTO4LdHoRLMZqNr73unzM6ADYmaIyeq
         tJ6dsNUjxn+lkY8wiCDlibjPjlC8Y01rsjloOfV2tBlRm8G3dYPzQyejyyH9hyMJxKY2
         Ga0zGhnlQF0t9qD5/DaEQMXU1PD13S+IC5523kVFJfpei0LQl8U9b9kNdjDOMCoLgVnw
         vA1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683104843; x=1685696843;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BtKpWEX99/tXFIUB1b2EGEDNutHLi8kX/M6s4oIe5M4=;
        b=HgxF/rR/rSlO4oFvIvCF4Gd6Q1zH9LhkTcsZBNR02i/tG6Kd/Vb0V14iwHSK1ZGXRg
         5SFE0N6vLXz3Zti83Z1JEqixweBITWfcG9vmNDmaNAFWeFaDGgUpF2J4Bd4ZEWjwt45v
         8TOpiYzEns7b/NrkRwtMObKKg4EejfJNwKoy5x89AxTD5mv4qRmi1PZQU0ujr0Ds/VGE
         PxgJgnMC3Ktr8Ns2s4TwNIRLlMEz9Rco6FHb9iYyrU/gMYAgrMbTMk/GO8c5lPCavaOc
         sMrYqXKLMMcKXy2lFcxOXIHyDdzVS0Gd/fV957GhattQhoTzs8cFDbzj8s4Kfb+F25eQ
         9zqg==
X-Gm-Message-State: AC+VfDzGYsXv8AApPFulAkRgkHSEtReysUOJwIeNatWS9iPI8TSz0RSQ
        EgLgD8SwJbvzhR510LmdV2pxKg==
X-Google-Smtp-Source: ACHHUZ7KbXS+IwQVsR80XNjrwtE1ZUCnYctnByWWLdgm7ZrK387pgkawXMC7JKEwhn48tufrkT8hcQ==
X-Received: by 2002:a5d:4577:0:b0:306:2b5a:d8db with SMTP id a23-20020a5d4577000000b003062b5ad8dbmr6680255wrc.23.1683104843273;
        Wed, 03 May 2023 02:07:23 -0700 (PDT)
Received: from localhost ([147.161.155.99])
        by smtp.gmail.com with ESMTPSA id x9-20020a5d60c9000000b002fbdb797483sm32900298wrt.49.2023.05.03.02.07.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 02:07:23 -0700 (PDT)
From:   Andreas Hindborg <nmi@metaspace.dk>
To:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Hannes Reinecke <hare@suse.de>,
        lsf-pc@lists.linux-foundation.org, rust-for-linux@vger.kernel.org,
        linux-block@vger.kernel.org
Cc:     Wedson Almeida Filho <walmeida@microsoft.com>,
        Matthew Wilcox <willy@infradead.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Andreas Hindborg <nmi@metaspace.dk>,
        linux-kernel@vger.kernel.org (open list), gost.dev@samsung.com
Subject: [RFC PATCH 07/11] rust: lock: add support for `Lock::lock_irqsave`
Date:   Wed,  3 May 2023 11:07:04 +0200
Message-Id: <20230503090708.2524310-8-nmi@metaspace.dk>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230503090708.2524310-1-nmi@metaspace.dk>
References: <20230503090708.2524310-1-nmi@metaspace.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wedson Almeida Filho <walmeida@microsoft.com>

This allows locks like spinlocks and raw spinlocks to expose a
`lock_irqsave` variant in Rust that corresponds to the C version.

Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
---
 rust/kernel/sync/lock.rs | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/rust/kernel/sync/lock.rs b/rust/kernel/sync/lock.rs
index 1c584b1df30d..bb21af8a8377 100644
--- a/rust/kernel/sync/lock.rs
+++ b/rust/kernel/sync/lock.rs
@@ -72,6 +72,44 @@ pub unsafe trait Backend {
     }
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
 /// A mutual exclusion primitive.
 ///
 /// Exposes one of the kernel locking primitives. Which one is exposed depends on the lock backend
-- 
2.40.0

