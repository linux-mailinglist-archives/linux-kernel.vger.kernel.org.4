Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F13C770DF98
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 16:45:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236220AbjEWOpx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 10:45:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234406AbjEWOpu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 10:45:50 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CC17132
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 07:45:48 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-babb5e91ab4so6581201276.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 07:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684853147; x=1687445147;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Cirt2ON6amstA/3YNx8Dl/DrSfD+lKUlEarHqMF6nxw=;
        b=DqYCWPhParszen3Hd8C6NALzsNq4RE0GYoUKErPQQT/Rk8O/vXKcFFl4bB4qWAWbtP
         kkux8OKOZOKVkJsvkJ2Ny+BMhW6JZ8Lp8rG5soKSuqkKXV72FR+NUz5qjTBaOP88KeGN
         H0AC4WDcLBg1UrXmePmLeZyRcirBCEwzjJ7wSBiRt+97j9WoXoaqf2oKm7wLH7DlYFfe
         1Pv8kbdl6HkciPp6/Wmquuc5gUJx5SC+dKxW9tuwanpD0iX6llPgQm/VSavm+1y3b3PR
         h/Y217d0niQUL9S2/ueC8YV1UCjcINwLp02CAsb6llA5VM/mPUIIgFMI864kmpC1XiE7
         d/Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684853147; x=1687445147;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Cirt2ON6amstA/3YNx8Dl/DrSfD+lKUlEarHqMF6nxw=;
        b=gT4VRumqx1sE+kOPxtag72k6C0sA7veD5KwigwuUfIqKuk5D67Uu5zLpH+zfKu8Lo2
         2noa3t3koBZXxP7lMmr6095nDBvNLgpUSvB3NzoezcjtMcY0NEiFhukmvNIXRaQm6q+u
         1yxqukaG+vguechAGSSLf9hcjYYIJPvyxwUmfUZx6BuRHG62Qvd2Ww+LMqQ1CqvPICth
         0t/kragJAtGjPyMkPbC5gwLeMEwF4aciDnKjKKkGggW/sTnCdWNiDc3j0fpJugfRv79t
         uc9EbKXViCBrkz/dx+Q7GEDR0P40Y78yGOqbGbv6JD2mm/wM2A4/4ad1vSjRjV0SyWeF
         UuVw==
X-Gm-Message-State: AC+VfDxBcU1+Ufe623f6HxrRss8Ws2w+ECHiZ91VOsRhyViKX4bYNAtx
        P4b9Gp7P5WqIYGThJzuBCovGLAz8bCjeLhE=
X-Google-Smtp-Source: ACHHUZ5HGv5J4DLwutjlh5WRFIrH9ud/Hd5FtZAOkFZuacDfLlkK3smnxJzIXubwF4Z90tgv7QY8eKQgKy5wLVk=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:6c8])
 (user=aliceryhl job=sendgmr) by 2002:a25:949:0:b0:ba8:6422:bbec with SMTP id
 u9-20020a250949000000b00ba86422bbecmr8780701ybm.4.1684853147290; Tue, 23 May
 2023 07:45:47 -0700 (PDT)
Date:   Tue, 23 May 2023 14:44:17 +0000
In-Reply-To: <20230523144418.1250547-1-aliceryhl@google.com>
Mime-Version: 1.0
References: <20230523144418.1250547-1-aliceryhl@google.com>
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
Message-ID: <20230523144418.1250547-4-aliceryhl@google.com>
Subject: [PATCH v2 3/4] rust: specify when `ARef` is thread safe
From:   Alice Ryhl <aliceryhl@google.com>
To:     Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>
Cc:     Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        "=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?=" <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Alice Ryhl <aliceryhl@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Andreas Hindborg <a.hindborg@samsung.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

An `ARef` behaves just like the `Arc` when it comes to thread safety, so
we can reuse the thread safety comments from `Arc` here.

This is necessary because without this change, the Rust compiler will
assume that things are not thread safe even though they are.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Andreas Hindborg <a.hindborg@samsung.com>
Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
---
 rust/kernel/types.rs | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
index 29db59d6119a..1e5380b16ed5 100644
--- a/rust/kernel/types.rs
+++ b/rust/kernel/types.rs
@@ -321,6 +321,19 @@ pub struct ARef<T: AlwaysRefCounted> {
     _p: PhantomData<T>,
 }
 
+// SAFETY: It is safe to send `ARef<T>` to another thread when the underlying `T` is `Sync` because
+// it effectively means sharing `&T` (which is safe because `T` is `Sync`); additionally, it needs
+// `T` to be `Send` because any thread that has an `ARef<T>` may ultimately access `T` using a
+// mutable reference, for example, when the reference count reaches zero and `T` is dropped.
+unsafe impl<T: AlwaysRefCounted + Sync + Send> Send for ARef<T> {}
+
+// SAFETY: It is safe to send `&ARef<T>` to another thread when the underlying `T` is `Sync`
+// because it effectively means sharing `&T` (which is safe because `T` is `Sync`); additionally,
+// it needs `T` to be `Send` because any thread that has a `&ARef<T>` may clone it and get an
+// `ARef<T>` on that thread, so the thread may ultimately access `T` using a mutable reference, for
+// example, when the reference count reaches zero and `T` is dropped.
+unsafe impl<T: AlwaysRefCounted + Sync + Send> Sync for ARef<T> {}
+
 impl<T: AlwaysRefCounted> ARef<T> {
     /// Creates a new instance of [`ARef`].
     ///
-- 
2.40.1.698.g37aff9b760-goog

