Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FA9A6D4178
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 12:02:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232080AbjDCKCK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 06:02:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232163AbjDCKBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 06:01:51 -0400
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8778524D;
        Mon,  3 Apr 2023 03:01:49 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: linasend@asahilina.net)
        by mail.marcansoft.com (Postfix) with ESMTPSA id D7606423BA;
        Mon,  3 Apr 2023 10:01:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=asahilina.net;
        s=default; t=1680516108;
        bh=+HaSZDGbivQJSY7YEFbLidqycutVbcVcWgZLNHkg3sc=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc;
        b=PEBvY//MxjhXn7GofQK56jt6e0nLl+Cz8rwP5nuTiXfdMcbDcl9MNXNzupCuKIyOS
         EeWYAjJgQRMUkPkzVUbeKo9E+NXlQ8LiPxACOmWFafGWMFfc8xhPlXlL9Tjenfpv75
         W31kEJZh3fji0IuhFrEFOPY+AkbrHjz48RQyWPC32fQJOE8VRmENcvKcxg2B2QhZ9d
         nA9sc+MvZ31pV60s9ZdwnPR7RQ5WBjqadpmcNxYsQbZRFV16grxPLJyeUNT88xaWYc
         CSxtgq8EkkCoYGtpoa/K39A+gnuBigcUCxasY9M1sDflFEnMRO+0on/e9qorkY7Jbc
         GEJgHiUoTEwAg==
From:   Asahi Lina <lina@asahilina.net>
Date:   Mon, 03 Apr 2023 19:01:12 +0900
Subject: [PATCH v2 2/2] rust: sync: arc: Add
 UniqueArc<MaybeUninit<T>::assume_init()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230224-rust-arc-v2-2-5c97a865b276@asahilina.net>
References: <20230224-rust-arc-v2-0-5c97a865b276@asahilina.net>
In-Reply-To: <20230224-rust-arc-v2-0-5c97a865b276@asahilina.net>
To:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>
Cc:     Andreas Hindborg <a.hindborg@samsung.com>,
        Vincenzo Palazzo <vincenzopalazzodev@gmail.com>,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
        Benno Lossin <y86-dev@protonmail.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        asahi@lists.linux.dev, Asahi Lina <lina@asahilina.net>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1680516096; l=1928;
 i=lina@asahilina.net; s=20230221; h=from:subject:message-id;
 bh=+HaSZDGbivQJSY7YEFbLidqycutVbcVcWgZLNHkg3sc=;
 b=D/SmqTHwoV04N4AZ+pjn10VxfxZKRJYh1xmzLnOtmSG/S67qFVwAk3MdCshzPNeavWKr3bfxk
 fxnk5n1jxLuCUZL+ITvXD8CsT/RYmCobT9gRBt8mc0zEpd/tyYjEIkt
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

We can already create `UniqueArc<MaybeUninit<T>>` instances with
`UniqueArc::try_new_uninit()` and write to them with `write()`. Add
the missing unsafe `assume_init()` function to promote it to
`UniqueArc<T>`, so users can do piece-wise initialization of the
contents instead of doing it all at once as long as they keep the
invariants (the same requirements as `MaybeUninit::assume_init()`).

This mirrors the std `Arc::assume_init()` function. In the kernel,
since we have `UniqueArc`, arguably this only belongs there since most
use cases will initialize it immediately after creating it, before
demoting it to `Arc` to share it.

Co-authored-by: Benno Lossin <y86-dev@protonmail.com>
Signed-off-by: Benno Lossin <y86-dev@protonmail.com>
Signed-off-by: Asahi Lina <lina@asahilina.net>
---
 rust/kernel/sync/arc.rs | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
index b904ed898d3a..b664b41e473d 100644
--- a/rust/kernel/sync/arc.rs
+++ b/rust/kernel/sync/arc.rs
@@ -489,6 +489,17 @@ impl<T> UniqueArc<MaybeUninit<T>> {
     /// Converts a `UniqueArc<MaybeUninit<T>>` into a `UniqueArc<T>` by writing a value into it.
     pub fn write(mut self, value: T) -> UniqueArc<T> {
         self.deref_mut().write(value);
+        // SAFETY: We have just written the contents fully.
+        unsafe { self.assume_init() }
+    }
+
+    /// Unsafely assume that `self` is initialized.
+    ///
+    /// # Safety
+    ///
+    /// The caller guarantees that the value behind this pointer has been initialized. It is
+    /// *immediate* UB to call this when the value is not initialized.
+    pub unsafe fn assume_init(self) -> UniqueArc<T> {
         let inner = ManuallyDrop::new(self).inner.ptr;
         UniqueArc {
             // SAFETY: The new `Arc` is taking over `ptr` from `self.inner` (which won't be

-- 
2.40.0

