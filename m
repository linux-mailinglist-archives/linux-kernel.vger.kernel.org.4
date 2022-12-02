Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6751F640A69
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 17:17:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233712AbiLBQRJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 11:17:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233975AbiLBQQa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 11:16:30 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 075DAD208B;
        Fri,  2 Dec 2022 08:16:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D90E562331;
        Fri,  2 Dec 2022 16:16:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23525C43470;
        Fri,  2 Dec 2022 16:16:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669997766;
        bh=2kl4siMs2CiGNBXEZpLt5Bkk+dmVvKDxrC3ndkxJ8nE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eZzKRlTsLe+l4byy89diKfAYGW9gr1GxcrGfLMdowMTdFbapJswUpLyrVVyMFWbo8
         nhk0YPlJgcqDriXywi2C7Zw8JuJ0jh9n7KlBk6lAjjY9uWjuYyugHjwLAYWpfCIy2p
         tb8LNf6EKbYFWQ4GBZheYuFM8j945A3k55dDEBHfKG2vylvqpfjaMlfnaUxPIHLiI/
         r8xdzY2y2mmB0jH2VK+lP7AaSoB3Emt3gw5hdKF0ljfbx1QY+S7hYHofcUgW20htQo
         Dkx3NcXamstan9FGeYI+3ZA1htUUU0U3DA9f54Bgu+5XX29VRgOHHQBkbLctLQGDJC
         ugz2s0P5LHqXg==
From:   ojeda@kernel.org
To:     Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev
Subject: [PATCH v2 13/28] rust: alloc: add `Vec::try_with_capacity{,_in}()` constructors
Date:   Fri,  2 Dec 2022 17:14:44 +0100
Message-Id: <20221202161502.385525-14-ojeda@kernel.org>
In-Reply-To: <20221202161502.385525-1-ojeda@kernel.org>
References: <20221202161502.385525-1-ojeda@kernel.org>
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

From: Miguel Ojeda <ojeda@kernel.org>

Add `Vec::try_with_capacity()` and `Vec::try_with_capacity_in()` as
the fallible versions of `Vec::with_capacity()` and
`Vec::with_capacity_in()`, respectively.

The implementations follow the originals and use the previously
added `RawVec::try_with_capacity_in()`.

In turn, `Vec::try_with_capacity()` will be used to implement
the `CString` type (which wraps a `Vec<u8>`) in a later patch.

Reviewed-by: Gary Guo <gary@garyguo.net>
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

