Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 639596DB961
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 09:54:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbjDHHyB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Apr 2023 03:54:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjDHHx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Apr 2023 03:53:57 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4712B26A4;
        Sat,  8 Apr 2023 00:53:55 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id q27so31655633oiw.0;
        Sat, 08 Apr 2023 00:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680940434;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8DXY5enKnxnJyRV7r86vq2fiEM2iNKd+iCSjske2KHI=;
        b=QpArfm+D2AtseAfEe0p39Qc9A+hlCKSMdgaYUrWWmhe6qILHfP6feTEBkFhEDZKW1j
         ZOwdqgemZ4V/YA6c5VbWjVEzyzVuCyx2P5XKeFe232Y+vRNQADzY7RfNu5WsrOJdFRnQ
         BdyomMOB0g4OaNpeeqPs3Ix4bsVepv+Bi+W3l/PQB5/JhuWrd9CzYK3rq+LJUNFbOVGt
         MHY4TITVWIsPSD+ZC4YC71w3/zDdN92b2PZoVgci40DC8lr6FMP7D5SpaU1/b5EaaKuh
         SIWj4PyM04rL/OWEjl/o0RZ9QP+L64oL84oBqMeEexYYzsFulBXmoPggImafbw9mgGxm
         /GTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680940434;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8DXY5enKnxnJyRV7r86vq2fiEM2iNKd+iCSjske2KHI=;
        b=v9bq2rD27TbhoXbS/rWPs0BwozYDnSOIQ3wjwXK4aQNRmI3e9X2VL05E6+GHp5EQY4
         Asw8yZNlCe6lKqlqo8G4dJ3fAxuh8v2mrfRDKMoJhIH4RC/SFJhgvA8meGE80r+5J+C1
         Zya3gajxbhcqlDQh0KRW0b/qGwbFSrH8kaJk/y48/ucUuK7Ega6Q9jqZYBdyXDv3eqs9
         Jj258YNPQvyh0pQdgCWGosv3e63rqxnoOeWBYt/iUrC05PFfbSwbBMrKzgRQRG9N2x9P
         IBKjLIRZxZmJq/ER7LE8BSMAlj1CEVq0VYZvwO9uieE/Uwf1dyPIRZxKdKuOcfWbjeOW
         oXqg==
X-Gm-Message-State: AAQBX9cPvk/Gya7jTTt4Y3+zdfuh/ZyoEaYorMdkMQmY+jQbOHKTmPDB
        iHYHoWbEnD1AYUblj75aQlJQQV3+yu21OQ==
X-Google-Smtp-Source: AKy350Y2jz8CrbInPZ+jxCq4GrcQcrZGSQ7lFKlHzM9bC8NbL5uwlVDcLdI8Jbq5tCOn5IxBX0BFiA==
X-Received: by 2002:aca:1905:0:b0:389:4a80:336f with SMTP id l5-20020aca1905000000b003894a80336fmr2042313oii.23.1680940434442;
        Sat, 08 Apr 2023 00:53:54 -0700 (PDT)
Received: from wedsonaf-dev.home.lan ([189.124.190.154])
        by smtp.googlemail.com with ESMTPSA id o6-20020a4a9586000000b0051ffe0fe11bsm2435175ooi.6.2023.04.08.00.53.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Apr 2023 00:53:54 -0700 (PDT)
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
Subject: [PATCH v3 01/13] rust: sync: introduce `LockClassKey`
Date:   Sat,  8 Apr 2023 04:53:28 -0300
Message-Id: <20230408075340.25237-1-wedsonaf@gmail.com>
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
v2 -> v3: Replaced `core` with `::core` in macro

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
-- 
2.34.1

