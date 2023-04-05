Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F1306D853E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 19:51:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230489AbjDERvu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 13:51:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230031AbjDERvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 13:51:49 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43F794ED2;
        Wed,  5 Apr 2023 10:51:48 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id r16so27164948oij.5;
        Wed, 05 Apr 2023 10:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680717107;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gMP0vMNBwrLjFKEPy2CMu1fnlfs0/NqzPWZqghLoLH0=;
        b=FlNG5Mh+LYHiKmpVO5Kkc4ndfZx6rglAL3tzSlmi/R1LjGSO+vBbn6ks5jH5DYpZgt
         FT+BqMYU+CEicm4jafguOkkUALEXGHPS4q1txwi8kO8aH8je0r/wiM+0UiVVrl2BvUrP
         1VniGaZvNHas/TWAvQ5/7l6AvbmGkHLL4JIbGTjspA4xamSeiaJQRAxWfJV80u6FtTHM
         OW4aksSQ5cf9DyJHjnGu9daZqwAiLwpFR74E+UZvj8ApO280bzLe8K8JsYCkkZYsL7xw
         aFEv2G0FgZ+65ZbkB9QDtO66naum9o1X12ufKAhJdQ2ZbMQ2LAXsT9NRMDUv4towzBK6
         gm6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680717107;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gMP0vMNBwrLjFKEPy2CMu1fnlfs0/NqzPWZqghLoLH0=;
        b=SfZPn6gAXjbBPHGulWdhKaQkqlagEQS2yHaIMW5/hT7RlVi0UR5zxwHA4kpfomwtJy
         IXvqpIhzF2VQMY3vkJTBjMiX/g3v1X90UPpjz0u7cjq9iO4Pd0b9uAGl9W4+3bqqoepO
         zO3JVYSpAOxgrXYDSX3rZVcDSt3TwPwkZsQ6v6ZWl6efUT3vXxlLm0RQvN56E5ziWAEn
         KRUcZegsp4hB7uFwBLpHe9IqeORMFnwHTv+MNKTY5ToJzQoiTbNEubtiGAcd6fQ/zyRQ
         LrMIGdI0K5LivBb9NoQKoUdlMUm/Vbq7tYDmfulAJ4hKQMnxMRqT+qwY1lvViQxPgUIx
         cvag==
X-Gm-Message-State: AAQBX9egCtYV3tTiHvam437CAFFKAto6OIiP4cxPHdVb7RVd6FXIfi/p
        52Fyf+HM//UafxGxE7AtJG7vWA++zoSYEw==
X-Google-Smtp-Source: AKy350Ybgro8MIK4AzIvRa3zXk/XENDtnfhCGSoUuq5/14ejQ7qXBL1w6SUNewjY+UAc1V1QqpvdzA==
X-Received: by 2002:a05:6808:6084:b0:386:f58a:2262 with SMTP id de4-20020a056808608400b00386f58a2262mr3259621oib.57.1680717107544;
        Wed, 05 Apr 2023 10:51:47 -0700 (PDT)
Received: from wedsonaf-dev.home.lan ([189.124.190.154])
        by smtp.googlemail.com with ESMTPSA id w185-20020aca62c2000000b003896e31867esm6604045oib.49.2023.04.05.10.51.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 10:51:47 -0700 (PDT)
From:   Wedson Almeida Filho <wedsonaf@gmail.com>
To:     rust-for-linux@vger.kernel.org
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
        linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <walmeida@microsoft.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v2 01/13] rust: sync: introduce `LockClassKey`
Date:   Wed,  5 Apr 2023 14:50:59 -0300
Message-Id: <20230405175111.5974-1-wedsonaf@gmail.com>
X-Mailer: git-send-email 2.34.1
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

It is a wrapper around C's `lock_class_key`, which is used by the
synchronisation primitives that are checked with lockdep. This is in
preparation for introducing Rust abstractions for these primitives.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Will Deacon <will@kernel.org>
Cc: Waiman Long <longman@redhat.com>
Co-developed-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
---
v1 -> v2: Fixed a typo in comment

 rust/kernel/sync.rs | 45 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/rust/kernel/sync.rs b/rust/kernel/sync.rs
index 33da23e3076d..84a4b560828c 100644
--- a/rust/kernel/sync.rs
+++ b/rust/kernel/sync.rs
@@ -5,6 +5,51 @@
 //! This module contains the kernel APIs related to synchronisation that have been ported or
 //! wrapped for usage by Rust code in the kernel.
 
+use crate::types::Opaque;
+
 mod arc;
 
 pub use arc::{Arc, ArcBorrow, UniqueArc};
+
+/// Represents a lockdep class. It's a wrapper around C's `lock_class_key`.
+#[repr(transparent)]
+pub struct LockClassKey(Opaque<bindings::lock_class_key>);
+
+// SAFETY: `bindings::lock_class_key` is designed to be used concurrently from multiple threads and
+// provides its own synchronization.
+unsafe impl Sync for LockClassKey {}
+
+impl LockClassKey {
+    /// Creates a new lock class key.
+    pub const fn new() -> Self {
+        Self(Opaque::uninit())
+    }
+
+    #[allow(dead_code)]
+    pub(crate) fn as_ptr(&self) -> *mut bindings::lock_class_key {
+        self.0.get()
+    }
+}
+
+/// Defines a new static lock class and returns a pointer to it.
+#[doc(hidden)]
+#[macro_export]
+macro_rules! static_lock_class {
+    () => {{
+        static CLASS: $crate::sync::LockClassKey = $crate::sync::LockClassKey::new();
+        &CLASS
+    }};
+}
+
+/// Returns the given string, if one is provided, otherwise generates one based on the source code
+/// location.
+#[doc(hidden)]
+#[macro_export]
+macro_rules! optional_name {
+    () => {
+        $crate::c_str!(core::concat!(core::file!(), ":", core::line!()))
+    };
+    ($name:literal) => {
+        $crate::c_str!($name)
+    };
+}
-- 
2.34.1

