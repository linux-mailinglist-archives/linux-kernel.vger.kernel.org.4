Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73435640A79
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 17:19:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234011AbiLBQS4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 11:18:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234070AbiLBQSL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 11:18:11 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEB81DFB59;
        Fri,  2 Dec 2022 08:16:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7B1A362322;
        Fri,  2 Dec 2022 16:16:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6F3EC43470;
        Fri,  2 Dec 2022 16:16:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669997806;
        bh=YyjXthwblgrT88DPLFu+XIPGLqjTiZLg+Xpj0PN4MaE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iUVfcvaGJdF/n2QAZNTbyYm5gbDZ+FvzXb1+V8Q7HwFKlarV3seVo1NnOevDs7f9A
         uxcx1Ce9O/9sI14ZMd98O5sFBiUUgCcucTb4+KI/zXlega/CNBZpzsuRiXAlpPUEux
         oPtm3kxnmuw1fAt/iUFshg9JMuKQZavSA/KJpFUAd8Rl2yUN8Hbu+6kOtRGKw3hyBp
         I3ZSh6nvGSQ6ddBxn2yHDHPvwNJKZDL8JoiLX3U6mkmv8zs1eWyZhXSzHNioAell2D
         8+znw2S00T/44bGNXLEEUmiMlyC/YIDBT6y9MFZowF6EDXr+RVIhfRd0/qFm5ZqEUb
         wCkPYCWBYfpTA==
From:   ojeda@kernel.org
To:     Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev
Subject: [PATCH v2 28/28] rust: types: add `Opaque` type
Date:   Fri,  2 Dec 2022 17:14:59 +0100
Message-Id: <20221202161502.385525-29-ojeda@kernel.org>
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

From: Wedson Almeida Filho <wedsonaf@gmail.com>

Add the `Opaque` type, which is meant to be used with FFI objects
that are never interpreted by Rust code, e.g.:

    struct Waiter {
        completion: Opaque<bindings::completion>,
        next: *mut Waiter,
    }

It has the advantage that the objects don't have to be
zero-initialised before calling their init functions, making
the code performance closer to C.

Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
[Reworded, adapted for upstream and applied latest changes]
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 rust/kernel/types.rs | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
index 3b0c44769708..e84e51ec9716 100644
--- a/rust/kernel/types.rs
+++ b/rust/kernel/types.rs
@@ -2,6 +2,31 @@
 
 //! Kernel types.
 
+use core::{cell::UnsafeCell, mem::MaybeUninit};
+
+/// Stores an opaque value.
+///
+/// This is meant to be used with FFI objects that are never interpreted by Rust code.
+#[repr(transparent)]
+pub struct Opaque<T>(MaybeUninit<UnsafeCell<T>>);
+
+impl<T> Opaque<T> {
+    /// Creates a new opaque value.
+    pub const fn new(value: T) -> Self {
+        Self(MaybeUninit::new(UnsafeCell::new(value)))
+    }
+
+    /// Creates an uninitialised value.
+    pub const fn uninit() -> Self {
+        Self(MaybeUninit::uninit())
+    }
+
+    /// Returns a raw pointer to the opaque data.
+    pub fn get(&self) -> *mut T {
+        UnsafeCell::raw_get(self.0.as_ptr())
+    }
+}
+
 /// A sum type that always holds either a value of type `L` or `R`.
 pub enum Either<L, R> {
     /// Constructs an instance of [`Either`] containing a value of type `L`.
-- 
2.38.1

