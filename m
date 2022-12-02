Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFDE7640A66
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 17:17:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233990AbiLBQQ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 11:16:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233895AbiLBQQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 11:16:28 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2457DF62F;
        Fri,  2 Dec 2022 08:16:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 75525B821EF;
        Fri,  2 Dec 2022 16:15:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 788FAC433D7;
        Fri,  2 Dec 2022 16:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669997758;
        bh=LHdw9TfUAyqQhYug7LeGlRw9Sq8mQsT00lw24iqeNao=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CaLL6Fg6EFH72SLa7DwuDVUZqmHFJMaZ7EzzJVbe4oDzaplP1xRuLk9saKkzY1qT8
         +j/GZdi+3tbWT9/clKmNH8MOXegnJvagR8NW03O92ux16Y/gym2zV54UV9qqmqEcv7
         QSSCN935YzhVvdOlrb8iU48O66LiAmJWY0QEJFR9Ohh/KPfwDQvvs6/zOtxlImXrOL
         kPjTgeOhsGrsnL4FI2dt0SIJSsdQ21YLkFaetBE5KjX/zC4weTPfAAxV+tw23y+Sxe
         r8A24ohFgqTwMJW3qltF4xhWMxAX/3/z3ql4RGBdDXy082LWz8bzLQ9sWf/TiL/MUi
         776M4eiEvRmow==
From:   ojeda@kernel.org
To:     Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Adam Bratschi-Kaye <ark.email@gmail.com>,
        =?UTF-8?q?N=C3=A1ndor=20Istv=C3=A1n=20Kr=C3=A1cser?= 
        <bonifaido@gmail.com>, Finn Behrens <me@kloenk.dev>
Subject: [PATCH v2 10/28] rust: error: add `From` implementations for `Error`
Date:   Fri,  2 Dec 2022 17:14:41 +0100
Message-Id: <20221202161502.385525-11-ojeda@kernel.org>
In-Reply-To: <20221202161502.385525-1-ojeda@kernel.org>
References: <20221202161502.385525-1-ojeda@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wedson Almeida Filho <wedsonaf@gmail.com>

Add a set of `From` implementations for the `Error` kernel type.

These implementations allow to easily convert from standard Rust
error types to the usual kernel errors based on one of the `E*`
integer codes.

On top of that, the question mark Rust operator (`?`) implicitly
performs a conversion on the error value using the `From` trait
when propagating. Thus it is extra convenient to use.

For instance, a kernel function that needs to convert a `i64` into
a `i32` and to bubble up the error as a kernel error may write:

    fn f(x: i64) -> Result<...> {
        ...
        let y = i32::try_from(x)?;
        ...
    }

which will transform the `TryFromIntError` into an `Err(EINVAL)`.

Co-developed-by: Adam Bratschi-Kaye <ark.email@gmail.com>
Signed-off-by: Adam Bratschi-Kaye <ark.email@gmail.com>
Co-developed-by: Nándor István Krácser <bonifaido@gmail.com>
Signed-off-by: Nándor István Krácser <bonifaido@gmail.com>
Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
Reviewed-by: Finn Behrens <me@kloenk.dev>
[Reworded, adapted for upstream and applied latest changes]
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 rust/kernel/error.rs | 45 +++++++++++++++++++++++++++++++++++++++++++-
 rust/kernel/lib.rs   |  1 +
 2 files changed, 45 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/error.rs b/rust/kernel/error.rs
index 861746f2422d..5b9751d7ff1d 100644
--- a/rust/kernel/error.rs
+++ b/rust/kernel/error.rs
@@ -4,7 +4,14 @@
 //!
 //! C header: [`include/uapi/asm-generic/errno-base.h`](../../../include/uapi/asm-generic/errno-base.h)
 
-use alloc::collections::TryReserveError;
+use alloc::{
+    alloc::{AllocError, LayoutError},
+    collections::TryReserveError,
+};
+
+use core::convert::From;
+use core::num::TryFromIntError;
+use core::str::Utf8Error;
 
 /// Contains the C-compatible error codes.
 pub mod code {
@@ -71,12 +78,48 @@ impl Error {
     }
 }
 
+impl From<AllocError> for Error {
+    fn from(_: AllocError) -> Error {
+        code::ENOMEM
+    }
+}
+
+impl From<TryFromIntError> for Error {
+    fn from(_: TryFromIntError) -> Error {
+        code::EINVAL
+    }
+}
+
+impl From<Utf8Error> for Error {
+    fn from(_: Utf8Error) -> Error {
+        code::EINVAL
+    }
+}
+
 impl From<TryReserveError> for Error {
     fn from(_: TryReserveError) -> Error {
         code::ENOMEM
     }
 }
 
+impl From<LayoutError> for Error {
+    fn from(_: LayoutError) -> Error {
+        code::ENOMEM
+    }
+}
+
+impl From<core::fmt::Error> for Error {
+    fn from(_: core::fmt::Error) -> Error {
+        code::EINVAL
+    }
+}
+
+impl From<core::convert::Infallible> for Error {
+    fn from(e: core::convert::Infallible) -> Error {
+        match e {}
+    }
+}
+
 /// A [`Result`] with an [`Error`] error type.
 ///
 /// To be used as the return type for functions that may fail.
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index abd46261d385..ffc6626a6d29 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -12,6 +12,7 @@
 //! do so first instead of bypassing this crate.
 
 #![no_std]
+#![feature(allocator_api)]
 #![feature(core_ffi_c)]
 
 // Ensure conditional compilation based on the kernel configuration works;
-- 
2.38.1

