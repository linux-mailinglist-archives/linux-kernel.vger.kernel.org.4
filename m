Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02E3E62474D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 17:43:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231918AbiKJQnp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 11:43:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232274AbiKJQnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 11:43:11 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E59145ECB;
        Thu, 10 Nov 2022 08:42:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2B36D60E75;
        Thu, 10 Nov 2022 16:42:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 852C1C433C1;
        Thu, 10 Nov 2022 16:42:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668098574;
        bh=oHlabre48JwaQeQ82d/rrnGlLyDZ1CNALanCqEPU3dw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P4Bx/5fMNOjtIMrYghXNmUtzIdPI4JhjRlrRWBRrhfd5cTaivD5K2wGsqAzYlSn0+
         KRyBBHNuGQnBXvI5SV2wbxTs1JHzfzT4LqQUPmwJ1rrvha15ZLz8dREEP4tTirp1bn
         9JDVflUqFXxCop7nlp23gmGF6+hB07TaO3xom+/StRWZErd9wLBg/iKR8fNWcrgKb0
         tpBoobNEDIQ474EIgzE8d5H6Sja0sMf/FQT0dw+aOilom7LYseVVZ1HgqFI1Szc+wN
         bJLKrVa59oW6cGhuPBUzneF3vxk9SVfm3rcgm8KMyR1KciDIJOvDTgWRDNdaureF/w
         mSBDNNB25bnIA==
From:   Miguel Ojeda <ojeda@kernel.org>
To:     Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev
Subject: [PATCH v1 12/28] rust: alloc: add `RawVec::try_with_capacity_in()` constructor
Date:   Thu, 10 Nov 2022 17:41:24 +0100
Message-Id: <20221110164152.26136-13-ojeda@kernel.org>
In-Reply-To: <20221110164152.26136-1-ojeda@kernel.org>
References: <20221110164152.26136-1-ojeda@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the `RawVec::try_with_capacity_in()` constructor as the fallible
version of `RawVec::with_capacity_in()`.

The implementation follows the original.

The infallible constructor is implemented in terms of the private
`RawVec::allocate_in()` constructor, thus also add the private
`RawVec::try_allocate_in()` constructor following the other.

It will be used to implement `Vec::try_with_capacity{,_in}()` in
the next patch.

Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 rust/alloc/raw_vec.rs | 34 +++++++++++++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/rust/alloc/raw_vec.rs b/rust/alloc/raw_vec.rs
index daf5f2da7168..c342f3843972 100644
--- a/rust/alloc/raw_vec.rs
+++ b/rust/alloc/raw_vec.rs
@@ -20,11 +20,11 @@ use crate::collections::TryReserveErrorKind::*;
 #[cfg(test)]
 mod tests;
 
-#[cfg(not(no_global_oom_handling))]
 enum AllocInit {
     /// The contents of the new memory are uninitialized.
     Uninitialized,
     /// The new memory is guaranteed to be zeroed.
+    #[allow(dead_code)]
     Zeroed,
 }
 
@@ -133,6 +133,14 @@ impl<T, A: Allocator> RawVec<T, A> {
         Self::allocate_in(capacity, AllocInit::Uninitialized, alloc)
     }
 
+    /// Like `try_with_capacity`, but parameterized over the choice of
+    /// allocator for the returned `RawVec`.
+    #[allow(dead_code)]
+    #[inline]
+    pub fn try_with_capacity_in(capacity: usize, alloc: A) -> Result<Self, TryReserveError> {
+        Self::try_allocate_in(capacity, AllocInit::Uninitialized, alloc)
+    }
+
     /// Like `with_capacity_zeroed`, but parameterized over the choice
     /// of allocator for the returned `RawVec`.
     #[cfg(not(no_global_oom_handling))]
@@ -203,6 +211,30 @@ impl<T, A: Allocator> RawVec<T, A> {
         }
     }
 
+    fn try_allocate_in(capacity: usize, init: AllocInit, alloc: A) -> Result<Self, TryReserveError> {
+        // Don't allocate here because `Drop` will not deallocate when `capacity` is 0.
+        if mem::size_of::<T>() == 0 || capacity == 0 {
+            return Ok(Self::new_in(alloc));
+        }
+
+        let layout = Layout::array::<T>(capacity).map_err(|_| CapacityOverflow)?;
+        alloc_guard(layout.size())?;
+        let result = match init {
+            AllocInit::Uninitialized => alloc.allocate(layout),
+            AllocInit::Zeroed => alloc.allocate_zeroed(layout),
+        };
+        let ptr = result.map_err(|_| AllocError { layout, non_exhaustive: () })?;
+
+        // Allocators currently return a `NonNull<[u8]>` whose length
+        // matches the size requested. If that ever changes, the capacity
+        // here should change to `ptr.len() / mem::size_of::<T>()`.
+        Ok(Self {
+            ptr: unsafe { Unique::new_unchecked(ptr.cast().as_ptr()) },
+            cap: capacity,
+            alloc,
+        })
+    }
+
     /// Reconstitutes a `RawVec` from a pointer, capacity, and allocator.
     ///
     /// # Safety
-- 
2.38.1

