Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFC856DD1F6
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 07:46:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbjDKFqB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 01:46:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbjDKFqA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 01:46:00 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83186C1;
        Mon, 10 Apr 2023 22:45:58 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id bh10so4800966oib.1;
        Mon, 10 Apr 2023 22:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681191957;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1ypxcwM7jmy4EIpQHDDPh+AsNB2yPLBLHEq+9dLke6s=;
        b=bf0q5pptumpcxLxrOW546KbU4uBFR3fSYOT3zZ+OPRaAKucJvPTTIiDnQ2On/1P2b5
         q/l1Sz0fmZj75+UjF+oyuYKRCzcCbTYUIqAsxydmXZgsYVR1wdcVVtZGxbO2DEgmOFcL
         OI/bM55VumEXQw8P96QEGUQeZ1Q+Y5zNefGZL1vYUXKcVF6gdra3/kKDUbmsgJ/m0+ha
         pN+Q46fMjMhm5qgZ5JsPWvfFdAdZZ1V4zJ+14NchpzKkKsJsrLHy7VvfPf3aFqafJ75o
         fgSJ+vrjGwnrOdKTI91sA+CAHVaxQrv11XbwEkJQZqGF9H8YPgUl0r5tt8TeBF/4OUip
         ScvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681191957;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1ypxcwM7jmy4EIpQHDDPh+AsNB2yPLBLHEq+9dLke6s=;
        b=FmRRQ+RPWqj8IVUjKvVxBv1eaHdPZZw1fU/7ZALeeAK/UrlzYpI1FTVkspDXCrwRWh
         BNk2V7u5nQTgIAzV1a49kUxj6TGvG9SwYpXZ4FNj6vGaIgYDuEH+hONxF507M6UZ5ZU7
         ri9XA/O/zrs/TiFxTNu6YzysukhfWtzcG55KWb7UUsM0KR+TkylQ0PnMyzgXH9aOCleB
         aZB68lubn9SAfRPouAjqARJJl9S9xd8p/e3fDbcmp0d6EUf0/AId1E2yoNAOY0FPuG9F
         ZDovPj0JpXwRePEOit4Zx7CJJd/ep0nnL3YkqyK8tr8LSjTixLazfcIZ0BZRN9nnDHnZ
         8BjA==
X-Gm-Message-State: AAQBX9eidutPy+UeEHo7f9D40rI7NfmovRQLTKUVVAKGzU7Of7jCL4HW
        hRc1kP8nxhg7sPh7oJP8E1/xdGOBSLHNDQ==
X-Google-Smtp-Source: AKy350Y+3+CJqjQWYuvLgLxxo/VmXsxo1nkAQ/5N5ccKf34lbL4QxuCndVGvGCA2AdV7X9xHxqKKOQ==
X-Received: by 2002:a05:6808:2904:b0:38b:bceb:4047 with SMTP id ev4-20020a056808290400b0038bbceb4047mr2652094oib.45.1681191957535;
        Mon, 10 Apr 2023 22:45:57 -0700 (PDT)
Received: from wedsonaf-dev.home.lan ([189.124.190.154])
        by smtp.googlemail.com with ESMTPSA id z186-20020a4a49c3000000b005252d376caesm5440706ooa.22.2023.04.10.22.45.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Apr 2023 22:45:57 -0700 (PDT)
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
        Waiman Long <longman@redhat.com>,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Subject: [PATCH v4 01/13] rust: sync: introduce `LockClassKey`
Date:   Tue, 11 Apr 2023 02:45:31 -0300
Message-Id: <20230411054543.21278-1-wedsonaf@gmail.com>
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
Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Co-developed-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
---
v1 -> v2: Fixed a typo in comment
v2 -> v3: Replaced `core` with `::core` in macro
v3 -> v4:
- Rebased on top of rust-next now that all dependencies are applied

 rust/kernel/sync.rs | 45 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/rust/kernel/sync.rs b/rust/kernel/sync.rs
index 33da23e3076d..541d235ffbeb 100644
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
+        $crate::c_str!(::core::concat!(::core::file!(), ":", ::core::line!()))
+    };
+    ($name:literal) => {
+        $crate::c_str!($name)
+    };
+}

base-commit: 2d0dec625d872a41632a68fce2e69453ed87df91
-- 
2.34.1

