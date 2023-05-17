Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31707707310
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 22:31:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbjEQUbm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 16:31:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjEQUbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 16:31:32 -0400
Received: from mail-ej1-x64a.google.com (mail-ej1-x64a.google.com [IPv6:2a00:1450:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4203F30DE
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 13:31:30 -0700 (PDT)
Received: by mail-ej1-x64a.google.com with SMTP id a640c23a62f3a-969f24626fbso68332766b.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 13:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684355489; x=1686947489;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1m2NIZThmeCBayz0liS/tGETC/9gj7ELeSxPKaC6Yh8=;
        b=BnGU93/l6zgPX74n1BWhPYto1+DmrAaRJmje1ktjtxvvMVe5/ufxtkwfhHuGWoWdhk
         sTD0ze0cB+pBIMUh0eC20QGkHMtXngl1qheah8sXtY3xJUm4p2C/jy+3agGa/nXWMaBI
         cjXQYFgEMFGWjq0AK5WF2hb3rxsDq2qWXzEhoziYVq2kaalDDx9UX4nj4NQFwlvAumU+
         X8d+B3yeLFzGBO3Z8qQeVsV6ID5+4q96aaX8eg1fnDPAsOkB3kNDdNSo2o+kmZH4J8aw
         91bpLwB4E7EfRot8PStAuoblk4n4X2GSjicq/7i8QVuKgUhHDcQKGNJycsRIbr49laKs
         oJ7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684355489; x=1686947489;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1m2NIZThmeCBayz0liS/tGETC/9gj7ELeSxPKaC6Yh8=;
        b=Zl71juEiWgWapMieElwxyxvVlTgo7rZXGmSnDEl5iVUZUtXdGaJ0J8wium9eKnvjJG
         l8WIx8E+Y3+NYHhEDMO/JVB66nrlztT+q48BR5WxYF/2jh0RQPfYVSZBdZmLSWZEr5Nc
         pww5aVjUiac5OGx9EIs5vG0djJ6WUaIzm95Kku7G5cLi0mZ3Tc7kWQpD3n1G7eoO3RcE
         Yq85DoQVOkz7yNTdIxOtrByHjwC19OxQH3R24ApRTq4wHMfPbSLtNfHBJndSpW9HH1JG
         7JwVs8neLGmiMSNeO38kZX3p/DbCGdZTg5uRF7VmjyIp0WNgg1OCeovMfmWeu6/KArk3
         TYhA==
X-Gm-Message-State: AC+VfDwxCnQWukm2fhCOSsmlU2PCqGADf9kO6U3gMSsIpj9DlMBSx9Pp
        /RyHxkWmBGaeM5NCnG9a8zaXCFsgoOFsjTU=
X-Google-Smtp-Source: ACHHUZ6sg88Il3pJwgEPwAiDSK3Ct7Xt3RuoovGGygDfZP0R/TVVkjhn15R+rZzdr/rlqagjcoaYfOdz6TWU5JQ=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:6c8])
 (user=aliceryhl job=sendgmr) by 2002:a17:907:2bf5:b0:94e:dcd5:2429 with SMTP
 id gv53-20020a1709072bf500b0094edcd52429mr1413196ejc.3.1684355488912; Wed, 17
 May 2023 13:31:28 -0700 (PDT)
Date:   Wed, 17 May 2023 20:31:15 +0000
In-Reply-To: <20230517203119.3160435-1-aliceryhl@google.com>
Mime-Version: 1.0
References: <20230517203119.3160435-1-aliceryhl@google.com>
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
Message-ID: <20230517203119.3160435-4-aliceryhl@google.com>
Subject: [PATCH v1 3/7] rust: sync: add `Arc::{from_raw, into_raw}`
From:   Alice Ryhl <aliceryhl@google.com>
To:     rust-for-linux@vger.kernel.org
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        "=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?=" <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Alice Ryhl <aliceryhl@google.com>,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wedson Almeida Filho <walmeida@microsoft.com>

These methods can be used to turn an `Arc` into a raw pointer and back,
in a way that preserves the metadata for fat pointers.

This is done using the unstable ptr_metadata feature [1]. However, it
could also be done using the unstable pointer_byte_offsets feature [2],
which is likely to have a shorter path to stabilization than
ptr_metadata.

Link: https://github.com/rust-lang/rust/issues/81513 [1]
Link: https://github.com/rust-lang/rust/issues/96283 [2]
Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
Co-developed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/lib.rs      |  1 +
 rust/kernel/sync/arc.rs | 44 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+)

diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index cdf9fe999328..82854c86e65d 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -22,6 +22,7 @@
 #![feature(generic_associated_types)]
 #![feature(new_uninit)]
 #![feature(pin_macro)]
+#![feature(ptr_metadata)]
 #![feature(receiver_trait)]
 #![feature(unsize)]
 
diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
index e6d206242465..7c55a9178dfb 100644
--- a/rust/kernel/sync/arc.rs
+++ b/rust/kernel/sync/arc.rs
@@ -210,6 +210,50 @@ impl<T: ?Sized> Arc<T> {
         }
     }
 
+    /// Convert the [`Arc`] into a raw pointer.
+    ///
+    /// The raw pointer has ownership of the refcount that this Arc object owned.
+    pub fn into_raw(self) -> *const T {
+        let ptr = self.ptr.as_ptr();
+        core::mem::forget(self);
+        // SAFETY: The pointer is valid.
+        unsafe { core::ptr::addr_of!((*ptr).data) }
+    }
+
+    /// Recreates an [`Arc`] instance previously deconstructed via [`Arc::into_raw`].
+    ///
+    /// This code relies on the `repr(C)` layout of structs as described in
+    /// <https://doc.rust-lang.org/reference/type-layout.html#reprc-structs>.
+    ///
+    /// # Safety
+    ///
+    /// `ptr` must have been returned by a previous call to [`Arc::into_raw`]. Additionally, it
+    /// can only be called once for each previous call to [`Arc::into_raw`].
+    pub unsafe fn from_raw(ptr: *const T) -> Self {
+        // SAFETY: The safety requirement ensures that the pointer is valid.
+        let val_align = core::mem::align_of_val(unsafe { &*ptr });
+        let refcount_size = core::mem::size_of::<Opaque<bindings::refcount_t>>();
+
+        // Use the `repr(C)` algorithm to compute the offset of `data` in `ArcInner`.
+        //
+        // Pseudo-code for the `#[repr(C)]` algorithm can be found here:
+        // <https://doc.rust-lang.org/reference/type-layout.html#reprc-structs>
+        let mut val_offset = refcount_size;
+        let val_misalign = val_offset % val_align;
+        if val_misalign > 0 {
+            val_offset += val_align - val_misalign;
+        }
+
+        // This preserves the metadata in the pointer, if any.
+        let metadata = core::ptr::metadata(ptr as *const ArcInner<T>);
+        let ptr = (ptr as *mut u8).wrapping_sub(val_offset) as *mut ();
+        let ptr = core::ptr::from_raw_parts_mut(ptr, metadata);
+
+        // SAFETY: By the safety requirements we know that `ptr` came from `Arc::into_raw`, so the
+        // reference count held then will be owned by the new `Arc` object.
+        unsafe { Self::from_inner(NonNull::new_unchecked(ptr)) }
+    }
+
     /// Returns an [`ArcBorrow`] from the given [`Arc`].
     ///
     /// This is useful when the argument of a function call is an [`ArcBorrow`] (e.g., in a method
-- 
2.40.1.606.ga4b1b128d6-goog

