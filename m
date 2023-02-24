Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9DF76A179E
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 09:00:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbjBXIAT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 03:00:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbjBXIAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 03:00:11 -0500
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E993122DEF;
        Fri, 24 Feb 2023 00:00:09 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: linasend@asahilina.net)
        by mail.marcansoft.com (Postfix) with ESMTPSA id E970C42627;
        Fri, 24 Feb 2023 08:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=asahilina.net;
        s=default; t=1677225608;
        bh=0Up47y7KEYhekwntYgr5syUpa6Dxb/pGbZHOT4tPwJM=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc;
        b=tER4tx7J4m3yFPMir0rEV1nhCYmxofpML4pw1lwQYZhVt3OM2iNb41mFu4itCF3Q4
         Vk+V16EjWGKqAGT1XCMFkiH1f4BwehRYbZWCZ7/E+dhMp4hDAxaBZ+xO80N7NSFeoO
         1P59zVIfTE+Epbm2JUshFd51dHWmY2yBBz+uWOU9NAGCVFEWN7KWe73/lcClmsWnFs
         wrEVjuinO7AJ+Hw2ompz99OxVd54JjTtD9FXuNUOYnuDXRLCF/XH1nErXRz3CsuJZ+
         XyDsZjJrbLXKC814dS1xE5WE3jNkKEulgILcNARN6Ow7Nyjdc3TnkU7W2dr4FnN50K
         sQDP3r5UapMaA==
From:   Asahi Lina <lina@asahilina.net>
Date:   Fri, 24 Feb 2023 16:59:34 +0900
Subject: [PATCH 2/2] rust: sync: arc: Add
 UniqueArc<MaybeUninit<T>::assume_init()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230224-rust-arc-v1-2-568eea613a41@asahilina.net>
References: <20230224-rust-arc-v1-0-568eea613a41@asahilina.net>
In-Reply-To: <20230224-rust-arc-v1-0-568eea613a41@asahilina.net>
To:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        asahi@lists.linux.dev, Asahi Lina <lina@asahilina.net>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1677225599; l=1757;
 i=lina@asahilina.net; s=20230221; h=from:subject:message-id;
 bh=0Up47y7KEYhekwntYgr5syUpa6Dxb/pGbZHOT4tPwJM=;
 b=uJ1yTsqKiJ60A7a9DGhqliBpLPZdFYZvgKBN4QFlYL8xz5Fq/DvvPu1HeHmu9Ru9FqBj2uX1Z
 Y9EbTDTSc0QC01RK+qseEH2NcYWjE1RCHtAH9DyQH9p4mLLqKfKcyLh
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

Signed-off-by: Asahi Lina <lina@asahilina.net>
---
 rust/kernel/sync/arc.rs | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
index 752bd7c4699e..b8e9477fe865 100644
--- a/rust/kernel/sync/arc.rs
+++ b/rust/kernel/sync/arc.rs
@@ -512,6 +512,15 @@ impl<T> UniqueArc<MaybeUninit<T>> {
     /// Converts a `UniqueArc<MaybeUninit<T>>` into a `UniqueArc<T>` by writing a value into it.
     pub fn write(mut self, value: T) -> UniqueArc<T> {
         self.deref_mut().write(value);
+        // SAFETY: We have just written the contents fully.
+        unsafe { self.assume_init() }
+    }
+
+    /// Returns a UniqueArc<T>, assuming the MaybeUninit<T> has already been initialized.
+    ///
+    /// # Safety
+    /// The contents of the UniqueArc must have already been fully initialized.
+    pub unsafe fn assume_init(self) -> UniqueArc<T> {
         let inner = ManuallyDrop::new(self).inner.ptr;
         UniqueArc {
             // SAFETY: The new `Arc` is taking over `ptr` from `self.inner` (which won't be

-- 
2.35.1

