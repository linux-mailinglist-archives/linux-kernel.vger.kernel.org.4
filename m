Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8516D6E6E7C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 23:45:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232992AbjDRVoo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 17:44:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232946AbjDRVoj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 17:44:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A135849FD;
        Tue, 18 Apr 2023 14:44:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 27BA463972;
        Tue, 18 Apr 2023 21:44:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AD04C4339E;
        Tue, 18 Apr 2023 21:44:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681854275;
        bh=dxHo8fng5fKFUsmtr5U2E97vDNeCPOyudAHUgofO3Ow=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pzQSEkJzeinJqr/xLkeLsbod8v/LF8j9j1o3R4KhOtcMDbcfdi2dPjR0Qfr+FlcBP
         fZ1/hjf+pLrZSqLXhDjPDrCof1m2Ct0b7+2k+nwb5r+4XJj4R4V3za+zUUvJMXNhq3
         7OlFy+sJaXcfLBIvBwDmWPTJNJzQsolMCPf8De9Mlym9S71PJa9xWdKwZbNhud3jS5
         cC3l659+12sptujUJmIjTidlA4J2sH8TQr+F0n1/O3pb+PubueNXSRbjASwj4aj9X9
         j+lrGC0gUD8YhXNcb+fxfZE4vvpMhEct5F9/9bztS6x5AuoL/zLbbYm5oNcrKGLGSU
         I8rtbhExZhwAg==
From:   Miguel Ojeda <ojeda@kernel.org>
To:     Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>
Cc:     Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Josh Stone <jistone@redhat.com>,
        William Brown <william.brown@suse.com>,
        Georgy Yakovlev <gyakovlev@gentoo.org>,
        Jan Alexander Steffens <jan.steffens@gmail.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev
Subject: [PATCH 2/3] rust: arc: fix intra-doc link in `Arc<T>::init`
Date:   Tue, 18 Apr 2023 23:43:46 +0200
Message-Id: <20230418214347.324156-3-ojeda@kernel.org>
In-Reply-To: <20230418214347.324156-1-ojeda@kernel.org>
References: <20230418214347.324156-1-ojeda@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

`Arc<T>::init` refers to `Arc<T>::pin_init` via an intra-doc link
using the text `pin_init`, rather than more explicitly, which makes
`rustdoc` point it to the `pin_init!` macro instead.

This is required for the compiler upgrade since the newer `rustdoc`
would trigger the `broken_intra_doc_links` lint [1], but in this case
the macro was not the intended target to begin with, and so the actual
fix is to make it point to the right place, regardless of the upgrade.

Thus make it more explicit.

Fixes: 92c4a1e7e81c ("rust: init/sync: add `InPlaceInit` trait to pin-initialize smart pointers")
Link: https://github.com/rust-lang/rust/issues/106142 [1]
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 rust/kernel/sync/arc.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
index e6d206242465..1b0734fdf6a7 100644
--- a/rust/kernel/sync/arc.rs
+++ b/rust/kernel/sync/arc.rs
@@ -185,7 +185,7 @@ impl<T> Arc<T> {
 
     /// Use the given initializer to in-place initialize a `T`.
     ///
-    /// This is equivalent to [`pin_init`], since an [`Arc`] is always pinned.
+    /// This is equivalent to [`Arc<T>::pin_init`], since an [`Arc`] is always pinned.
     #[inline]
     pub fn init<E>(init: impl Init<T, E>) -> error::Result<Self>
     where
-- 
2.40.0

