Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C70D66CFA4B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 06:41:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbjC3ElD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 00:41:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjC3ElB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 00:41:01 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96CA9618F;
        Wed, 29 Mar 2023 21:40:46 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-17ac5ee3f9cso18533073fac.12;
        Wed, 29 Mar 2023 21:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680151246;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rLQtYNZFpddodHi/ahJfQCsqx8fDKLCv/AuGB4H5UvE=;
        b=IyJZWNVjjZ8/W8dHQs79bS3aAa+GUYXGhoabxs417dD1lH3ar/QQ9Pp9/L5d16GPAL
         tTH25vZr0ronU3Je4ybnvYKw7teys1hfsl87OSR4a0Wx5NHoCiyUQCfc+2WLWIm9iRT5
         TDC6lE5mJermYKgsiBPBoV5Ov+1kBaiJDjY90oeIHB/iADj9voJMmcsgqTc9e6odc2oh
         4c+UZMuVtDbekur4g/yLZX5RZ+zp0bjPmiCp0kK0JC2qum+TzDirISqDgMK92qXHUMIM
         P50YC0LPUoKglhRlUyWiNo7I8S4Xo/s55wISc9Bx0w7IMvc5ZTUrtqgWNJfm+tijzaRg
         VWSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680151246;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rLQtYNZFpddodHi/ahJfQCsqx8fDKLCv/AuGB4H5UvE=;
        b=snExaqrpvZxhGi5xwpvhBDzoZRjDqsDsnzWM0kJa7kjvWou87LOPYAmDaUHEhTJRtD
         ACClUkiFCy54VaZaY0xcpJWK/7TViC0uTs5e8TKu728dxQaQDYYtHpU2C3NPFgw5jQyO
         D8xjKXQN5iVX9gMSggYsuT1kqfbMY/MFU2xzbOhvAWHHxXMpAWPcP2g94RMtlJpTwpav
         JgRxMZKMacNEL0hWods6wrXHQYoLYxj3XZrQJ6ekIExoG5c0UunBUMhCDjlyAKgv5ZrB
         KVVqQwV7VZhDPiDNXEAZkgy0sv/erUHEKgXv2OgI09CJHCT2fuqMeekc4tssQgslDEop
         QPmg==
X-Gm-Message-State: AAQBX9d17BhJG1kmuu1AUenNlO2V+IcOzmlUxN5dEbySOmEqwI/D3Iyx
        SjKkbAuBF/IZr5ar7tGion439WFg5en6lg==
X-Google-Smtp-Source: AKy350aucSdFmqa3P1GdTePMyNL8oukRV8V7IQiqGIow/3iPQ944e3TOCe1OQuU3cKKEAKP/Vt56mQ==
X-Received: by 2002:a05:6870:c150:b0:172:289b:93c5 with SMTP id g16-20020a056870c15000b00172289b93c5mr2508515oad.0.1680151245805;
        Wed, 29 Mar 2023 21:40:45 -0700 (PDT)
Received: from wedsonaf-dev.home.lan ([189.124.190.154])
        by smtp.googlemail.com with ESMTPSA id ea43-20020a056870072b00b0017e0c13b29asm7518599oab.36.2023.03.29.21.40.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 21:40:45 -0700 (PDT)
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
Subject: [PATCH 01/13] rust: sync: introduce `LockClassKey`
Date:   Thu, 30 Mar 2023 01:39:42 -0300
Message-Id: <20230330043954.562237-1-wedsonaf@gmail.com>
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
+/// Returns the given string, if one is provided, otherwise generateis one based on the source code
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

