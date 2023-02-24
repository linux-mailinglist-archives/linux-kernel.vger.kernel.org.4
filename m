Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8EAB6A188A
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 10:12:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbjBXJMO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 04:12:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbjBXJMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 04:12:09 -0500
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E544765CDB;
        Fri, 24 Feb 2023 01:12:07 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: linasend@asahilina.net)
        by mail.marcansoft.com (Postfix) with ESMTPSA id E58264247C;
        Fri, 24 Feb 2023 09:12:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=asahilina.net;
        s=default; t=1677229926;
        bh=aEnf3Yi6W7s32UBEQhPMTbXySskKZPdQMXcNDxihEz0=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc;
        b=aq+DnANaXmRdkfeWfOIHDk/XU/UrjeHhFYVdtIKu5egVbFN12LN9vWxZBvAXAav6k
         sOz0sOzcVA3lM4+8CzVqCT+IyWL8nxsJznfkH5EigOR9HSE9v+SpfRWg2pw2zThu3f
         PGSnyW/YQA/l3oGEEFnunZOtMXdvRiGozGcTk8NcB0hn01RSlz2KbaHkML/FAADRis
         6jgjkJIV4u4kmZTuy2KI5MrtAEA3tBMSxQEMoDSGLU/yl8F2DJ7oifZJauUCnAzcQJ
         5R+bHCtq0eW9Q3CD4HfBIu/geA5VX5BskkTuK+LAIQXYPQkZzqB2t43lfMDoRt/jep
         pAmiXv89FdAvw==
From:   Asahi Lina <lina@asahilina.net>
Date:   Fri, 24 Feb 2023 18:11:48 +0900
Subject: [PATCH 2/4] rust: Import upstream `alloc::vec::spec_extend` module
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230224-rust-vec-v1-2-733b5b5a57c5@asahilina.net>
References: <20230224-rust-vec-v1-0-733b5b5a57c5@asahilina.net>
In-Reply-To: <20230224-rust-vec-v1-0-733b5b5a57c5@asahilina.net>
To:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>
Cc:     linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
        asahi@lists.linux.dev, Asahi Lina <lina@asahilina.net>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1677229917; l=3800;
 i=lina@asahilina.net; s=20230221; h=from:subject:message-id;
 bh=aEnf3Yi6W7s32UBEQhPMTbXySskKZPdQMXcNDxihEz0=;
 b=g5G05vV5FAJKNC2CQVVFo0gberglSfKhbAQEz33O9+FHYNCX8NT77Z0NrrJRm4nipKklHn4o6
 YHpmy1B6hvuCVQnVWkckoagSMkhGg9xHkrDIcEtJt+KIyZ1FYPaTxi+
X-Developer-Key: i=lina@asahilina.net; a=ed25519;
 pk=Qn8jZuOtR1m5GaiDfTrAoQ4NE1XoYVZ/wmt5YtXWFC4=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a subset of the Rust standard library `alloc` crate,
version 1.66.0, licensed under "Apache-2.0 OR MIT", from:

    https://github.com/rust-lang/rust/tree/1.66.0/library/alloc/src

The file is copied as-is, with no modifications whatsoever
(not even adding the SPDX identifiers).

For copyright details, please see:

    https://github.com/rust-lang/rust/blob/1.66.0/COPYRIGHT

Signed-off-by: Asahi Lina <lina@asahilina.net>
---
 rust/alloc/vec/spec_extend.rs | 87 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 87 insertions(+)

diff --git a/rust/alloc/vec/spec_extend.rs b/rust/alloc/vec/spec_extend.rs
new file mode 100644
index 000000000000..1ea9c827afd7
--- /dev/null
+++ b/rust/alloc/vec/spec_extend.rs
@@ -0,0 +1,87 @@
+use crate::alloc::Allocator;
+use core::iter::TrustedLen;
+use core::ptr::{self};
+use core::slice::{self};
+
+use super::{IntoIter, SetLenOnDrop, Vec};
+
+// Specialization trait used for Vec::extend
+pub(super) trait SpecExtend<T, I> {
+    fn spec_extend(&mut self, iter: I);
+}
+
+impl<T, I, A: Allocator> SpecExtend<T, I> for Vec<T, A>
+where
+    I: Iterator<Item = T>,
+{
+    default fn spec_extend(&mut self, iter: I) {
+        self.extend_desugared(iter)
+    }
+}
+
+impl<T, I, A: Allocator> SpecExtend<T, I> for Vec<T, A>
+where
+    I: TrustedLen<Item = T>,
+{
+    default fn spec_extend(&mut self, iterator: I) {
+        // This is the case for a TrustedLen iterator.
+        let (low, high) = iterator.size_hint();
+        if let Some(additional) = high {
+            debug_assert_eq!(
+                low,
+                additional,
+                "TrustedLen iterator's size hint is not exact: {:?}",
+                (low, high)
+            );
+            self.reserve(additional);
+            unsafe {
+                let mut ptr = self.as_mut_ptr().add(self.len());
+                let mut local_len = SetLenOnDrop::new(&mut self.len);
+                iterator.for_each(move |element| {
+                    ptr::write(ptr, element);
+                    ptr = ptr.add(1);
+                    // Since the loop executes user code which can panic we have to bump the pointer
+                    // after each step.
+                    // NB can't overflow since we would have had to alloc the address space
+                    local_len.increment_len(1);
+                });
+            }
+        } else {
+            // Per TrustedLen contract a `None` upper bound means that the iterator length
+            // truly exceeds usize::MAX, which would eventually lead to a capacity overflow anyway.
+            // Since the other branch already panics eagerly (via `reserve()`) we do the same here.
+            // This avoids additional codegen for a fallback code path which would eventually
+            // panic anyway.
+            panic!("capacity overflow");
+        }
+    }
+}
+
+impl<T, A: Allocator> SpecExtend<T, IntoIter<T>> for Vec<T, A> {
+    fn spec_extend(&mut self, mut iterator: IntoIter<T>) {
+        unsafe {
+            self.append_elements(iterator.as_slice() as _);
+        }
+        iterator.forget_remaining_elements();
+    }
+}
+
+impl<'a, T: 'a, I, A: Allocator + 'a> SpecExtend<&'a T, I> for Vec<T, A>
+where
+    I: Iterator<Item = &'a T>,
+    T: Clone,
+{
+    default fn spec_extend(&mut self, iterator: I) {
+        self.spec_extend(iterator.cloned())
+    }
+}
+
+impl<'a, T: 'a, A: Allocator + 'a> SpecExtend<&'a T, slice::Iter<'a, T>> for Vec<T, A>
+where
+    T: Copy,
+{
+    fn spec_extend(&mut self, iterator: slice::Iter<'a, T>) {
+        let slice = iterator.as_slice();
+        unsafe { self.append_elements(slice) };
+    }
+}

-- 
2.35.1

