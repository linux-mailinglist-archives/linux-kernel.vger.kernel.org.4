Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1519574EAAB
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 11:36:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbjGKJgb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 05:36:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbjGKJg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 05:36:27 -0400
Received: from mail-ej1-x649.google.com (mail-ej1-x649.google.com [IPv6:2a00:1450:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD083100
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 02:36:25 -0700 (PDT)
Received: by mail-ej1-x649.google.com with SMTP id a640c23a62f3a-993d500699fso252842766b.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 02:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689068184; x=1691660184;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tpNSgka6HOUQbghNI4iad00TiEGE4hqZSL3kST/OC3w=;
        b=Ti91ZX6MJ0NfZLQYe73Us+V/cCtLmivVf32T6Xf2KspuQN/HTcSSA9g2lebAH2TQhN
         M917g/IJ0yYA7BsuE+fY6jib84ff2BbHeYYHdD7GCus1Tood8iq9pudMXIAGApmDtGd4
         opZTY0ahW5qJWmjOk9a1uReY5/8HIlRkuYvOrXDOGLvxRlc5ETES8cHD8upbUCEwyrcV
         cmQJcqZwgLshmeP2cWEXLeRyZ6F8E1+DqwshQI+h7PS6PaokWygqwzkipVev6NfY6ooi
         xIzWgbc1lDZuygb5OF4iCT/R0P81bIE5xWiiPhwHzB8T3R1bNjKNR5n/xG+vnkTxNVEt
         5QkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689068184; x=1691660184;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tpNSgka6HOUQbghNI4iad00TiEGE4hqZSL3kST/OC3w=;
        b=AbRQW/+/fYcJSFB8vOSHnKgmPQ0/r1ao7t/bdoM1cVd2ThV87VkCV+W5Tcd+rlA7O6
         Rogb1GLjc7+w0PpFBRZ1VQcRk0xY5QAr24apJakj2f/AxyX2g2A9GPxJzi2108+QEuRo
         YD1XR1/nwoHXcIxJ2+LarcFXr+/ufxh7NhgAwKEZnzDbn7OyIG22EIKcSN73YEK+9RQt
         C53LIoXSGtN748RTlrbtdcjhBkbsp8yO4sMe7YwCVF6FmVKFurtTHnWshZNA94C8W0qf
         O+vKcaIQ8Lsy02dzfj6GSoz8lsjx6fM3LtlAI2p54rC0r80m5bz8YfMTLRqU0KNMECSy
         Ay6w==
X-Gm-Message-State: ABy/qLb4cmHKOLei3HiVtcggYCTjEwAoCLkBhho5om3Yc29BLyCF62sb
        lapHzDSJL7Go4Z8McVt3eTlLQU2C4Hprcm4=
X-Google-Smtp-Source: APBJJlEXPkfvK066yngPvjteqmRRMhHSgThqq79DkRpbbWFOsk+9nVl2pGFxKPX6/WUYw7K3M70B7cmLZ6KJrJk=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:6c8])
 (user=aliceryhl job=sendgmr) by 2002:a17:907:763a:b0:98e:2b63:9f78 with SMTP
 id jy26-20020a170907763a00b0098e2b639f78mr48893ejc.0.1689068183762; Tue, 11
 Jul 2023 02:36:23 -0700 (PDT)
Date:   Tue, 11 Jul 2023 09:32:55 +0000
In-Reply-To: <20230711093303.1433770-1-aliceryhl@google.com>
Mime-Version: 1.0
References: <20230711093303.1433770-1-aliceryhl@google.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230711093303.1433770-2-aliceryhl@google.com>
Subject: [PATCH v3 1/9] rust: add offset_of! macro
From:   Alice Ryhl <aliceryhl@google.com>
To:     rust-for-linux@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>
Cc:     Lai Jiangshan <jiangshanlai@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        "=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?=" <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Alice Ryhl <aliceryhl@google.com>,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        Wedson Almeida Filho <walmeida@microsoft.com>,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wedson Almeida Filho <walmeida@microsoft.com>

This macro is used to compute the offset of a field in a struct.

This commit enables an unstable feature that is necessary for using
the macro in a constant. However, this is not a problem as the macro
will become available from the Rust standard library soon [1]. The
unstable feature can be disabled again once that happens.

The macro in this patch does not support sub-fields. That is, you cannot
write `offset_of!(MyStruct, field.sub_field)` to get the offset of
`sub_field` with `field`'s type being a struct with a field called
`sub_field`. This is because `field` might be a `Box<SubStruct>`, which
means that you would be trying to compute the offset to something in an
entirely different allocation. There's no easy way to fix the current
macro to support subfields, but the version being added to the standard
library should support it, so the limitation is temporary and not a big
deal.

Link: https://github.com/rust-lang/rust/issues/106655 [1]
Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
Co-developed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Reviewed-by: Gary Guo <gary@garyguo.net>
Reviewed-by: Benno Lossin <benno.lossin@proton.me>
---
v2 -> v3:
 * Add comment as suggested in https://lore.kernel.org/rust-for-linux/875y862lr7.fsf@metaspace.dk/
 * Added Reviewed-by from Gary and Benno.

 rust/kernel/lib.rs     | 37 +++++++++++++++++++++++++++++++++++++
 scripts/Makefile.build |  2 +-
 2 files changed, 38 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 85b261209977..788914fd935f 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -14,6 +14,7 @@
 #![no_std]
 #![feature(allocator_api)]
 #![feature(coerce_unsized)]
+#![feature(const_refs_to_cell)]
 #![feature(dispatch_from_dyn)]
 #![feature(new_uninit)]
 #![feature(receiver_trait)]
@@ -97,3 +98,39 @@ fn panic(info: &core::panic::PanicInfo<'_>) -> ! {
     // instead of `!`. See <https://github.com/rust-lang/rust-bindgen/issues/2094>.
     loop {}
 }
+
+/// Calculates the offset of a field from the beginning of the struct it belongs to.
+///
+/// # Examples
+///
+/// ```
+/// #[repr(C)]
+/// struct Test {
+///     a: u64,
+///     b: u32,
+/// }
+///
+/// assert_eq!(kernel::offset_of!(Test, b), 8);
+/// ```
+#[macro_export]
+macro_rules! offset_of {
+    ($type:path, $field:ident) => {{
+        // Statically ensure that the type has a field of the given name. This ensures that no
+        // deref coercion is happening.
+        let $type { $field: _, .. };
+        let tmp = ::core::mem::MaybeUninit::<$type>::uninit();
+        let outer = tmp.as_ptr();
+        // To avoid warnings when nesting `unsafe` blocks.
+        #[allow(unused_unsafe)]
+        // SAFETY: The pointer is valid and aligned, just not initialised; `addr_of` ensures that
+        // we don't actually read from `outer` (which would be UB) nor create an intermediate
+        // reference.
+        let inner = unsafe { ::core::ptr::addr_of!((*outer).$field) } as *const u8;
+        // To avoid warnings when nesting `unsafe` blocks.
+        #[allow(unused_unsafe)]
+        // SAFETY: The two pointers are within the same allocation block.
+        unsafe {
+            inner.offset_from(outer as *const u8) as usize
+        }
+    }};
+}
diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 78175231c969..819510694769 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -277,7 +277,7 @@ $(obj)/%.lst: $(src)/%.c FORCE
 # Compile Rust sources (.rs)
 # ---------------------------------------------------------------------------
 
-rust_allowed_features := new_uninit
+rust_allowed_features := const_refs_to_cell,new_uninit
 
 rust_common_cmd = \
 	RUST_MODFILE=$(modfile) $(RUSTC_OR_CLIPPY) $(rust_flags) \
-- 
2.41.0.255.g8b1d071c50-goog

