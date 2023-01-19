Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99614674030
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 18:41:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbjASRlh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 12:41:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230095AbjASRlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 12:41:23 -0500
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3692D8BAA9;
        Thu, 19 Jan 2023 09:41:12 -0800 (PST)
Received: by mail-oi1-x22f.google.com with SMTP id p185so2313484oif.2;
        Thu, 19 Jan 2023 09:41:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ewZt9xECZEPZ1KuMvtcM156VR5vfWcAYIR5vc+17fj0=;
        b=ec4/wN56BlwB+jpQj7V9tlgsO2eAholWn2jaBPb+Aq4vRxqrhQ/euBYEL0rsNd8ILt
         CpnFtaM95PSAXdbDqW0OS1S/TlE4cXSsgKc/sb1H0j96NkENDO6Vy5EY5BytRdybIIFn
         HLMyXsWSfQjwBH8IyFtDKe2CrX2a44HSKJprlQsyyq+yDwEDiu9LuCE4sOeJz7c0UUg8
         P+krDC8NSc5kGvXQoJlKWSYQG19xUhffer3/ZiK5FhOZ7VHTVzBJ9r1PXW2eVO7UEMhS
         AewRsNU7+sf7azdBkf7RKBIglXHBB7GeKrjJ5Fvy8u4WLV4hzintzuY/N6EqKHcTxIk5
         beXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ewZt9xECZEPZ1KuMvtcM156VR5vfWcAYIR5vc+17fj0=;
        b=vv3qNBywbHidakBeumB1yvk+9/oALAdHKDZivKlprn7viyWrDyhjmyv56gOD1XP13X
         2XYrDUlhdpBG/ewet88fXu8Ld6AhnhkcsHogIigj93Gt6qqN5oQa4Le57kYk8yJBTTmH
         IZ7jb6pibHF0iFWnKtJ6p3QTwlu2SuB3ZnH8NSs+knnxhgCm1LcEYlESVEhz22R4JcBp
         ZhE7JZztbKeu0B0wiZFrX/N4yc4FY45MCGx4KlUVOufo/eVaxf7pyECD7ss59mXINpLM
         YvyVX3whrMJLKM20ZAluUcmeE7nXC2cTeJ0o5cOEDc1yVdjdh+4Kj6RHNWlgnLFEGce2
         HQpA==
X-Gm-Message-State: AFqh2kog79lYjL96/5Ofrb2n8sd7ivHM1BF55vaudFov4dH9kSBZotse
        A4T1A5XbnVJpQEyYiBeAbuUkCcRGA9d5CLqU
X-Google-Smtp-Source: AMrXdXv/XVCbHYqclqzvqc2uYWnFk0rx7JeIcGkBLlqnkLymNUvP4x5GdrFjNHjjsvdAFG79QqVRpw==
X-Received: by 2002:aca:230f:0:b0:364:d7f0:3847 with SMTP id e15-20020aca230f000000b00364d7f03847mr4873263oie.38.1674150071475;
        Thu, 19 Jan 2023 09:41:11 -0800 (PST)
Received: from wedsonaf-dev.home.lan ([189.124.190.154])
        by smtp.googlemail.com with ESMTPSA id i7-20020a056808054700b003631fe1810dsm10226906oig.47.2023.01.19.09.41.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 09:41:11 -0800 (PST)
From:   Wedson Almeida Filho <wedsonaf@gmail.com>
To:     rust-for-linux@vger.kernel.org
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
        linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <wedsonaf@gmail.com>
Subject: [PATCH 5/5] rust: types: implement `ForeignOwnable` for `Arc<T>`
Date:   Thu, 19 Jan 2023 14:40:36 -0300
Message-Id: <20230119174036.64046-5-wedsonaf@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230119174036.64046-1-wedsonaf@gmail.com>
References: <20230119174036.64046-1-wedsonaf@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows us to hand ownership of Rust ref-counted objects to
the C side of the kernel.

Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
---
 rust/kernel/sync/arc.rs | 32 +++++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
index ff73f9240ca1..519a6ec43644 100644
--- a/rust/kernel/sync/arc.rs
+++ b/rust/kernel/sync/arc.rs
@@ -15,7 +15,11 @@
 //!
 //! [`Arc`]: https://doc.rust-lang.org/std/sync/struct.Arc.html
 
-use crate::{bindings, error::Result, types::Opaque};
+use crate::{
+    bindings,
+    error::Result,
+    types::{ForeignOwnable, Opaque},
+};
 use alloc::boxed::Box;
 use core::{
     marker::{PhantomData, Unsize},
@@ -189,6 +193,32 @@ impl<T: ?Sized> Arc<T> {
     }
 }
 
+impl<T: 'static> ForeignOwnable for Arc<T> {
+    type Borrowed<'a> = ArcBorrow<'a, T>;
+
+    fn into_foreign(self) -> *const core::ffi::c_void {
+        ManuallyDrop::new(self).ptr.as_ptr() as _
+    }
+
+    unsafe fn borrow<'a>(ptr: *const core::ffi::c_void) -> ArcBorrow<'a, T> {
+        // SAFETY: By the safety requirement of this function, we know that `ptr` came from
+        // a previous call to `Arc::into_foreign`.
+        let inner = NonNull::new(ptr as *mut ArcInner<T>).unwrap();
+
+        // SAFETY: The safety requirements of `from_foreign` ensure that the object remains alive
+        // for the lifetime of the returned value. Additionally, the safety requirements of
+        // `ForeignOwnable::borrow_mut` ensure that no new mutable references are created.
+        unsafe { ArcBorrow::new(inner) }
+    }
+
+    unsafe fn from_foreign(ptr: *const core::ffi::c_void) -> Self {
+        // SAFETY: By the safety requirement of this function, we know that `ptr` came from
+        // a previous call to `Arc::into_foreign`, which owned guarantees that `ptr` is valid and
+        // owns a reference.
+        unsafe { Self::from_inner(NonNull::new(ptr as _).unwrap()) }
+    }
+}
+
 impl<T: ?Sized> Deref for Arc<T> {
     type Target = T;
 
-- 
2.34.1

