Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60C7F6CFA50
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 06:41:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbjC3Elh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 00:41:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbjC3ElW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 00:41:22 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AD2255B5;
        Wed, 29 Mar 2023 21:41:08 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id d22-20020a9d5e16000000b0069b5252ced7so9390956oti.13;
        Wed, 29 Mar 2023 21:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680151268;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u/B9dFAeaUqrqqXcKIk+Y/eQ9yVG9iQNTR7il5e9jLs=;
        b=FBldUjeWmTnMcGDYtqPGJOtkr5qqAbx5XiPvKUIklDArae9Xj9CeCHqo5AgHV6DmJ8
         7VYNkFwXjHt4PiCnF+qGoy4piOQ79h/06J07fzF9g5FmSl5EQ8XijZ7ko5HcBgGDj9VN
         /4QFZCOftuHqdU3uFgL27j225r4bIsAFt1dSBzTyi08LjsDzas/byE1wbN1j+qk/reYm
         notFF2U2pairKLHR4xcS/GOOvf5ZRL5zq8oTEYoeXLobavX7T7GvXuk79j2KjtecFyVK
         OhnnTSq5hYySGzqeWDgy78MFf4lbW63A37vRGZWAKb+MzYToslbH527fdxj4M/YLnlNI
         QUJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680151268;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u/B9dFAeaUqrqqXcKIk+Y/eQ9yVG9iQNTR7il5e9jLs=;
        b=ITvSaEUzvQD8Kt+lA8J1CruVuHlwy3d8+9NLWQGviMt91kGCYuyJJZuDiYaq8jqc8O
         lEaGEKKv8T6aMXqmOg1AyOEWp5VYYfyuotEyJrGdnAwFs6vLWgXWxcc1aogEZP0iR/j6
         SKE8oiR8PbXMqBa/2RF5CnMI6jpvHXxEQi2VR9Ado/Gtj+C6y4yFtOMirOaclD6d5sSZ
         dNC0LyW7pIRzWVWQWXA9Bo/eLE/icN2oqbJRWSXwM6V4ni7lH0HluNfnrx5vC5tOIuh/
         dB45BDyXDoCahXFKwYvHryZf8fqkoDrxHRew0dt7Dg0dZHZpGSKFjr8a7E6D8696wgk5
         Br9Q==
X-Gm-Message-State: AO0yUKWxTYVW7LUCqfo8xKwas6Q0qu2UM+i0vP4gRkfMZkOSC3vZxpG+
        IPiu6KB675tq7iP8dPymiYTWEd44G+NswA==
X-Google-Smtp-Source: AK7set99jG8l4uyr3wxeKERjnAXMdcfXxE87b+Wva1bGOUnjb4oAkZzPLPlnQdrwX8lnBEcIj6h4Fw==
X-Received: by 2002:a9d:6854:0:b0:693:d998:f50c with SMTP id c20-20020a9d6854000000b00693d998f50cmr10533454oto.5.1680151267883;
        Wed, 29 Mar 2023 21:41:07 -0700 (PDT)
Received: from wedsonaf-dev.home.lan ([189.124.190.154])
        by smtp.googlemail.com with ESMTPSA id ea43-20020a056870072b00b0017e0c13b29asm7518599oab.36.2023.03.29.21.41.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 21:41:07 -0700 (PDT)
From:   Wedson Almeida Filho <wedsonaf@gmail.com>
To:     rust-for-linux@vger.kernel.org
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
        linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <walmeida@microsoft.com>
Subject: [PATCH 06/13] rust: lock: add support for `Lock::lock_irqsave`
Date:   Thu, 30 Mar 2023 01:39:47 -0300
Message-Id: <20230330043954.562237-6-wedsonaf@gmail.com>
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

This allows locks like spinlocks and raw spinlocks to expose a
`lock_irqsave` variant in Rust that corresponds to the C version.

Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
---
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

