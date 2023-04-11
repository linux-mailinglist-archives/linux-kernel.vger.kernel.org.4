Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39DF66DD201
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 07:46:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbjDKFqt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 01:46:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbjDKFqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 01:46:31 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 445C92D61;
        Mon, 10 Apr 2023 22:46:16 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id j12so4798517oij.3;
        Mon, 10 Apr 2023 22:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681191975;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AAreLXMWIgov70baVUCg3TcwQ+G9hKF5u+kmMd3Sihc=;
        b=gEQkaR3P8AqjvIR7pewuoP8UX0zC/dEcw/ATVeKUBdbqqUMbiK10WEP9Lv7vq+ceZB
         7OUZ3akb7OSG5f0u+tX+1G86wTj7wQQ18JogW/oBZjXH49H7q7eh1vLm5U8j4BIcAYgO
         zzLyS6/qUE64VVytwvFWIuslAPetr2ap0wM2gccbN2siOgNmOh4x4BS8o2x9loj+ZMuz
         qj3zD+Qe0egpXy6uoyUGTyWcUnVRJa5uu4leEZBwp6rZpejmBV261dTMth0p+FKCuoYv
         iBgV7Jlsa/uQ3k0ch3NagUI4JW/ufVWkqOMWDUCbePTFoo2trF1gIJ3y8HwZE6SNxARa
         eJJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681191975;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AAreLXMWIgov70baVUCg3TcwQ+G9hKF5u+kmMd3Sihc=;
        b=3get5erOBSn1Msy6iaqhQ23OMtxAuZF3r9fNAkD0XWxWnEzlMGvp/dmu1SeUtGLyeG
         j0Rv7D+27yI9CtRB/awxhIypNnN50oi2oZUc3u/pwwiTAb7uAMdz6XMDtLQ1mtaNcmUG
         0bL35AXUxfwu62Jkcxe/Vcu7WFp8Fa8HIUyaScEe6AYnQzsXoYkzljg+UNBefJuFU0bi
         9Grd46vBZX51GwF0Tfdb+pYWCvY857Z+HsW+Y3pyonfNKvWRdDngRrlnp20th44u9V5K
         HpworlEpJl/Er5JHN5Yg81WN0rETV0zIhkFflIz+5f2sxKrkGtTocyN1s5L+ft+JHW3n
         gKxQ==
X-Gm-Message-State: AAQBX9csbwn25UwTH6LotG3C37lRfpI5Dzq9c2KXtB1e3YjcHljagZ7h
        8tpG8m9qPK01IjDiojQMIsjhtBhNZj4=
X-Google-Smtp-Source: AKy350ZUzus3yyJNoO9ARjsMH8M94s7R+dU/Ia2iYiejXSuEdtMFndZw3qCoWxG7e1dL1BpLyQ8Pxw==
X-Received: by 2002:a54:4716:0:b0:387:3694:d5d6 with SMTP id k22-20020a544716000000b003873694d5d6mr4071074oik.25.1681191975404;
        Mon, 10 Apr 2023 22:46:15 -0700 (PDT)
Received: from wedsonaf-dev.home.lan ([189.124.190.154])
        by smtp.googlemail.com with ESMTPSA id z186-20020a4a49c3000000b005252d376caesm5440706ooa.22.2023.04.10.22.46.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Apr 2023 22:46:15 -0700 (PDT)
From:   Wedson Almeida Filho <wedsonaf@gmail.com>
To:     rust-for-linux@vger.kernel.org
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
        linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <walmeida@microsoft.com>,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Subject: [PATCH v4 06/13] rust: lock: add support for `Lock::lock_irqsave`
Date:   Tue, 11 Apr 2023 02:45:36 -0300
Message-Id: <20230411054543.21278-6-wedsonaf@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230411054543.21278-1-wedsonaf@gmail.com>
References: <20230411054543.21278-1-wedsonaf@gmail.com>
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

Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
---
v1 -> v2: No changes
v2 -> v3: No changes
v3 -> v4: No changes

 rust/kernel/sync/lock.rs | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/rust/kernel/sync/lock.rs b/rust/kernel/sync/lock.rs
index 08adc3747033..819b8ea5ba2b 100644
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
@@ -111,6 +134,21 @@ impl<T: ?Sized, B: Backend> Lock<T, B> {
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

