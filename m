Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E60D1624750
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 17:44:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232207AbiKJQoB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 11:44:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232099AbiKJQn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 11:43:26 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A4294385A;
        Thu, 10 Nov 2022 08:43:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DA077B82251;
        Thu, 10 Nov 2022 16:42:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88272C433B5;
        Thu, 10 Nov 2022 16:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668098577;
        bh=BvwkwmrbZC14+/ZpCX1HQjoc2T2Qpowc2X8TOjeQukE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=s791YN2UzC8dhtmjVNGRnI0TlhTl/C5cNWs9GU+8N/CMDuw3sUQPrw+9/ee8KnDtq
         mMSuLzJmPNMiWBRTYbSSUnXLCQtLRoUuEzrO37LiXy6Z+M49S03NLaWfgpqAJ7dGgh
         dz2Acl6UXWkPAqNeWejXTcFL7NAtRPti3g/PN416jMnL3g1Rn9bUr1iNCNtNk75HvL
         US1JOiBnvbEJyP/Vb3XpgeL+fhv1QMd+DnvrRhSZK2lAZ9k5r+TB8pxuyMoaHQ2Woe
         Sm2g/YYENLlz4ojLxVqaov38JdbUKh3LWPonkNSR3EhKCJynHtCFy/KZXLarJN7zvE
         UL4DCRGqp3CFw==
From:   Miguel Ojeda <ojeda@kernel.org>
To:     Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev
Subject: [PATCH v1 13/28] rust: alloc: add `Vec::try_with_capacity{,_in}()` constructors
Date:   Thu, 10 Nov 2022 17:41:25 +0100
Message-Id: <20221110164152.26136-14-ojeda@kernel.org>
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

Add `Vec::try_with_capacity()` and `Vec::try_with_capacity_in()` as
the fallible versions of `Vec::with_capacity()` and
`Vec::with_capacity_in()`, respectively.

The implementations follow the originals and use the previously
added `RawVec::try_with_capacity_in()`.

In turn, `Vec::try_with_capacity()` will be used to implement
the `CString` type (which wraps a `Vec<u8>`) in a later patch.

Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 rust/alloc/raw_vec.rs |  1 -
 rust/alloc/vec/mod.rs | 89 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 89 insertions(+), 1 deletion(-)

diff --git a/rust/alloc/raw_vec.rs b/rust/alloc/raw_vec.rs
index c342f3843972..eb77db5def55 100644
--- a/rust/alloc/raw_vec.rs
+++ b/rust/alloc/raw_vec.rs
@@ -135,7 +135,6 @@ impl<T, A: Allocator> RawVec<T, A> {
 
     /// Like `try_with_capacity`, but parameterized over the choice of
     /// allocator for the returned `RawVec`.
-    #[allow(dead_code)]
     #[inline]
     pub fn try_with_capacity_in(capacity: usize, alloc: A) -> Result<Self, TryReserveError> {
         Self::try_allocate_in(capacity, AllocInit::Uninitialized, alloc)
diff --git a/rust/alloc/vec/mod.rs b/rust/alloc/vec/mod.rs
index 540787804cc2..8ac6c1e3b2a8 100644
--- a/rust/alloc/vec/mod.rs
+++ b/rust/alloc/vec/mod.rs
@@ -472,6 +472,48 @@ impl<T> Vec<T> {
         Self::with_capacity_in(capacity, Global)
     }
 
+    /// Tries to construct a new, empty `Vec<T>` with the specified capacity.
+    ///
+    /// The vector will be able to hold exactly `capacity` elements without
+    /// reallocating. If `capacity` is 0, the vector will not allocate.
+    ///
+    /// It is important to note that although the returned vector has the
+    /// *capacity* specified, the vector will have a zero *length*. For an
+    /// explanation of the difference between length and capacity, see
+    /// *[Capacity and reallocation]*.
+    ///
+    /// [Capacity and reallocation]: #capacity-and-reallocation
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// let mut vec = Vec::try_with_capacity(10).unwrap();
+    ///
+    /// // The vector contains no items, even though it has capacity for more
+    /// assert_eq!(vec.len(), 0);
+    /// assert_eq!(vec.capacity(), 10);
+    ///
+    /// // These are all done without reallocating...
+    /// for i in 0..10 {
+    ///     vec.push(i);
+    /// }
+    /// assert_eq!(vec.len(), 10);
+    /// assert_eq!(vec.capacity(), 10);
+    ///
+    /// // ...but this may make the vector reallocate
+    /// vec.push(11);
+    /// assert_eq!(vec.len(), 11);
+    /// assert!(vec.capacity() >= 11);
+    ///
+    /// let mut result = Vec::try_with_capacity(usize::MAX);
+    /// assert!(result.is_err());
+    /// ```
+    #[inline]
+    #[stable(feature = "kernel", since = "1.0.0")]
+    pub fn try_with_capacity(capacity: usize) -> Result<Self, TryReserveError> {
+        Self::try_with_capacity_in(capacity, Global)
+    }
+
     /// Creates a `Vec<T>` directly from the raw components of another vector.
     ///
     /// # Safety
@@ -617,6 +659,53 @@ impl<T, A: Allocator> Vec<T, A> {
         Vec { buf: RawVec::with_capacity_in(capacity, alloc), len: 0 }
     }
 
+    /// Tries to construct a new, empty `Vec<T, A>` with the specified capacity
+    /// with the provided allocator.
+    ///
+    /// The vector will be able to hold exactly `capacity` elements without
+    /// reallocating. If `capacity` is 0, the vector will not allocate.
+    ///
+    /// It is important to note that although the returned vector has the
+    /// *capacity* specified, the vector will have a zero *length*. For an
+    /// explanation of the difference between length and capacity, see
+    /// *[Capacity and reallocation]*.
+    ///
+    /// [Capacity and reallocation]: #capacity-and-reallocation
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// #![feature(allocator_api)]
+    ///
+    /// use std::alloc::System;
+    ///
+    /// let mut vec = Vec::try_with_capacity_in(10, System).unwrap();
+    ///
+    /// // The vector contains no items, even though it has capacity for more
+    /// assert_eq!(vec.len(), 0);
+    /// assert_eq!(vec.capacity(), 10);
+    ///
+    /// // These are all done without reallocating...
+    /// for i in 0..10 {
+    ///     vec.push(i);
+    /// }
+    /// assert_eq!(vec.len(), 10);
+    /// assert_eq!(vec.capacity(), 10);
+    ///
+    /// // ...but this may make the vector reallocate
+    /// vec.push(11);
+    /// assert_eq!(vec.len(), 11);
+    /// assert!(vec.capacity() >= 11);
+    ///
+    /// let mut result = Vec::try_with_capacity_in(usize::MAX, System);
+    /// assert!(result.is_err());
+    /// ```
+    #[inline]
+    #[stable(feature = "kernel", since = "1.0.0")]
+    pub fn try_with_capacity_in(capacity: usize, alloc: A) -> Result<Self, TryReserveError> {
+        Ok(Vec { buf: RawVec::try_with_capacity_in(capacity, alloc)?, len: 0 })
+    }
+
     /// Creates a `Vec<T, A>` directly from the raw components of another vector.
     ///
     /// # Safety
-- 
2.38.1

