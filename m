Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 994B96DB966
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 09:54:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbjDHHyk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Apr 2023 03:54:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbjDHHyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Apr 2023 03:54:16 -0400
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com [IPv6:2607:f8b0:4864:20::c31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C981EF91;
        Sat,  8 Apr 2023 00:54:11 -0700 (PDT)
Received: by mail-oo1-xc31.google.com with SMTP id g26-20020a4adc9a000000b0053b9059edd5so101132oou.3;
        Sat, 08 Apr 2023 00:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680940451;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wpOoeU4Qo2xSWrP8Zd47XosmBdNzXp8ItY0SM633XWM=;
        b=XLHoIICN4WFwHuDBqxfKuglpmeOGb0tM/R0Hg70PpgPHdHtnZs4dWSz8OGj0GBvj+w
         RmXHSyGsBLFukKlZM6mC4tGYngB2/VEOVVrfQwQ/PZG0wJHWUIUOnmxLTXJZh4VgfXIo
         Yyvy6fBIYsGXtrdawKmHht6TDayR3g4d4zzYewKAmh3JlCuX3A2vLmD51ZkI7bZ6qBB/
         vuNBDV0eo1AjVf84FlG6LoZ/hpS+cUGCxF3KLH+roU5FIOV9UnHVCVQSulDOMdWwh+9x
         pPzsg9DlH1NeuCgqSLRUwLaRnnUNLKQ/xwJX6SIiuK+2mKPy9A8QSm204DTuI4LaZSMQ
         U0TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680940451;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wpOoeU4Qo2xSWrP8Zd47XosmBdNzXp8ItY0SM633XWM=;
        b=LRsH13/nkR9WTA4H447eUIqurpK49UVf3ww1taBd0YL/hhdAZ0wgEmRsH7f05DNZAC
         Xsw+RGxlRCo26cvpA3+e0Nxt2rl7PBr9reK3tIfeLlDfggYg+l/YSx8SQMGdebGygq+d
         8mD+mj/9N4SvEMOP/dKUeZ86mQa4a48Eaa3JDJS0mUyR9E/butChLlk+p+8u3yXzG+zf
         /6alUKwVOwYYtBeYM+18dRHpPkPuuIqCVtQ4blwDGVS4Iyi6AUlug2hbMEeAZd8zcLHf
         CUweiNlieRAWs9zpGZYpWO7skT0DEAhRF7EthXT5MsA9q36u1+FR672aPTbfeNHq2PO9
         68bw==
X-Gm-Message-State: AAQBX9fvgxtk5ZC1g7UOjA4xWXdZkVMx1XzmmlcJr00ogN8mvYdlELc0
        Lc+YviD4yhYqdA1LcfMNF6L4GKw/BkQ=
X-Google-Smtp-Source: AKy350YrquCOq7bdfdlw3x4MFa6rgRr71bB0aUmra4lMhjkiyi75Bue78/5tsEWXIKUo6utlI4PnZA==
X-Received: by 2002:a4a:58cb:0:b0:517:a7d1:9762 with SMTP id f194-20020a4a58cb000000b00517a7d19762mr2437292oob.7.1680940450726;
        Sat, 08 Apr 2023 00:54:10 -0700 (PDT)
Received: from wedsonaf-dev.home.lan ([189.124.190.154])
        by smtp.googlemail.com with ESMTPSA id o6-20020a4a9586000000b0051ffe0fe11bsm2435175ooi.6.2023.04.08.00.54.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Apr 2023 00:54:10 -0700 (PDT)
From:   Wedson Almeida Filho <wedsonaf@gmail.com>
To:     rust-for-linux@vger.kernel.org
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
        linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <walmeida@microsoft.com>
Subject: [PATCH v3 06/13] rust: lock: add support for `Lock::lock_irqsave`
Date:   Sat,  8 Apr 2023 04:53:33 -0300
Message-Id: <20230408075340.25237-6-wedsonaf@gmail.com>
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

This allows locks like spinlocks and raw spinlocks to expose a
`lock_irqsave` variant in Rust that corresponds to the C version.

Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
---
v1 -> v2: No changes
v2 -> v3: No changes

 rust/kernel/sync/lock.rs | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/rust/kernel/sync/lock.rs b/rust/kernel/sync/lock.rs
index df43dff5af5c..690429561f0e 100644
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

