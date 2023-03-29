Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0699E6CD8A0
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 13:40:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbjC2Lkv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 07:40:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbjC2Lks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 07:40:48 -0400
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45F3A449A;
        Wed, 29 Mar 2023 04:40:47 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: linasend@asahilina.net)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 558A7424A5;
        Wed, 29 Mar 2023 11:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=asahilina.net;
        s=default; t=1680090045;
        bh=36jyt17+gpMhtBUVGOnMVEqQehMLVw5t+BF+sC4kAO8=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc;
        b=KPAnbJo8Tq/Bj92pG1Isa8rQKjE9Iqk0vQqsUPpIhachljQJImGeJzRfySV62vase
         0FbEB2LyLTN98m/ukAUNt/bmQecQ7++tp37YQaaQF303uaoBuFpkJRtFcMDQHJiBJi
         n1HGe+HyBRLZcl2sGo/y23Gd1//ncThaGaatsLA9mALLs9y/4NQyEkGM6KWDZ0uOLX
         UTj0Fr1LmeP+2LykGDPYF6RKF7A6LwV0JxJSnD5WZaQ+JKcgwkr+Mno1I5XSk5LMGZ
         EbtfHMdG+vXhu2Le+VmQOoity6dhyDT0bfI3CaU+dBLCoPP0yUN4SOKDVdyyO1GHmv
         Mqj8+KNQnK1ZA==
From:   Asahi Lina <lina@asahilina.net>
Date:   Wed, 29 Mar 2023 20:40:19 +0900
Subject: [PATCH 2/2] rust: ioctl: Move to the uapi crate
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230329-rust-uapi-v1-2-ee78f2933726@asahilina.net>
References: <20230329-rust-uapi-v1-0-ee78f2933726@asahilina.net>
In-Reply-To: <20230329-rust-uapi-v1-0-ee78f2933726@asahilina.net>
To:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>
Cc:     linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
        asahi@lists.linux.dev, Asahi Lina <lina@asahilina.net>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1680090036; l=3405;
 i=lina@asahilina.net; s=20230221; h=from:subject:message-id;
 bh=36jyt17+gpMhtBUVGOnMVEqQehMLVw5t+BF+sC4kAO8=;
 b=nfZZd5UugBCJimQIF7tuA5PmeTswIM2a3l93eYTyrBNnpczR4cUCJ2lZUU/rtF2f2DzVoYUUd
 5PcEeiYQVXfBCBwFrOxAsN2Ylw9JJ8m0Y1YLNgb8qasKBPd5/8YlbmV
X-Developer-Key: i=lina@asahilina.net; a=ed25519;
 pk=Qn8jZuOtR1m5GaiDfTrAoQ4NE1XoYVZ/wmt5YtXWFC4=
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we have the uapi crate, this abstraction can use that instead
of bindings.

Signed-off-by: Asahi Lina <lina@asahilina.net>
---
 rust/kernel/ioctl.rs | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/rust/kernel/ioctl.rs b/rust/kernel/ioctl.rs
index b2076113b6a8..007437959395 100644
--- a/rust/kernel/ioctl.rs
+++ b/rust/kernel/ioctl.rs
@@ -10,40 +10,40 @@ use crate::build_assert;
 /// Build an ioctl number, analogous to the C macro of the same name.
 #[inline(always)]
 const fn _IOC(dir: u32, ty: u32, nr: u32, size: usize) -> u32 {
-    build_assert!(dir <= bindings::_IOC_DIRMASK);
-    build_assert!(ty <= bindings::_IOC_TYPEMASK);
-    build_assert!(nr <= bindings::_IOC_NRMASK);
-    build_assert!(size <= (bindings::_IOC_SIZEMASK as usize));
+    build_assert!(dir <= uapi::_IOC_DIRMASK);
+    build_assert!(ty <= uapi::_IOC_TYPEMASK);
+    build_assert!(nr <= uapi::_IOC_NRMASK);
+    build_assert!(size <= (uapi::_IOC_SIZEMASK as usize));
 
-    (dir << bindings::_IOC_DIRSHIFT)
-        | (ty << bindings::_IOC_TYPESHIFT)
-        | (nr << bindings::_IOC_NRSHIFT)
-        | ((size as u32) << bindings::_IOC_SIZESHIFT)
+    (dir << uapi::_IOC_DIRSHIFT)
+        | (ty << uapi::_IOC_TYPESHIFT)
+        | (nr << uapi::_IOC_NRSHIFT)
+        | ((size as u32) << uapi::_IOC_SIZESHIFT)
 }
 
 /// Build an ioctl number for an argumentless ioctl.
 #[inline(always)]
 pub const fn _IO(ty: u32, nr: u32) -> u32 {
-    _IOC(bindings::_IOC_NONE, ty, nr, 0)
+    _IOC(uapi::_IOC_NONE, ty, nr, 0)
 }
 
 /// Build an ioctl number for an read-only ioctl.
 #[inline(always)]
 pub const fn _IOR<T>(ty: u32, nr: u32) -> u32 {
-    _IOC(bindings::_IOC_READ, ty, nr, core::mem::size_of::<T>())
+    _IOC(uapi::_IOC_READ, ty, nr, core::mem::size_of::<T>())
 }
 
 /// Build an ioctl number for an write-only ioctl.
 #[inline(always)]
 pub const fn _IOW<T>(ty: u32, nr: u32) -> u32 {
-    _IOC(bindings::_IOC_WRITE, ty, nr, core::mem::size_of::<T>())
+    _IOC(uapi::_IOC_WRITE, ty, nr, core::mem::size_of::<T>())
 }
 
 /// Build an ioctl number for a read-write ioctl.
 #[inline(always)]
 pub const fn _IOWR<T>(ty: u32, nr: u32) -> u32 {
     _IOC(
-        bindings::_IOC_READ | bindings::_IOC_WRITE,
+        uapi::_IOC_READ | uapi::_IOC_WRITE,
         ty,
         nr,
         core::mem::size_of::<T>(),
@@ -52,20 +52,20 @@ pub const fn _IOWR<T>(ty: u32, nr: u32) -> u32 {
 
 /// Get the ioctl direction from an ioctl number.
 pub const fn _IOC_DIR(nr: u32) -> u32 {
-    (nr >> bindings::_IOC_DIRSHIFT) & bindings::_IOC_DIRMASK
+    (nr >> uapi::_IOC_DIRSHIFT) & uapi::_IOC_DIRMASK
 }
 
 /// Get the ioctl type from an ioctl number.
 pub const fn _IOC_TYPE(nr: u32) -> u32 {
-    (nr >> bindings::_IOC_TYPESHIFT) & bindings::_IOC_TYPEMASK
+    (nr >> uapi::_IOC_TYPESHIFT) & uapi::_IOC_TYPEMASK
 }
 
 /// Get the ioctl number from an ioctl number.
 pub const fn _IOC_NR(nr: u32) -> u32 {
-    (nr >> bindings::_IOC_NRSHIFT) & bindings::_IOC_NRMASK
+    (nr >> uapi::_IOC_NRSHIFT) & uapi::_IOC_NRMASK
 }
 
 /// Get the ioctl size from an ioctl number.
 pub const fn _IOC_SIZE(nr: u32) -> usize {
-    ((nr >> bindings::_IOC_SIZESHIFT) & bindings::_IOC_SIZEMASK) as usize
+    ((nr >> uapi::_IOC_SIZESHIFT) & uapi::_IOC_SIZEMASK) as usize
 }

-- 
2.40.0

