Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D48070DF97
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 16:45:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237355AbjEWOpf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 10:45:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234406AbjEWOpc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 10:45:32 -0400
Received: from mail-ej1-x64a.google.com (mail-ej1-x64a.google.com [IPv6:2a00:1450:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB405121
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 07:45:25 -0700 (PDT)
Received: by mail-ej1-x64a.google.com with SMTP id a640c23a62f3a-96fffd1ba46so215044266b.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 07:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684853124; x=1687445124;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lZ4w9FZLzrevw3euUgZ/CnJwq2fkRa+GrhkB6vuUVZU=;
        b=DM09wBFceGQyjzVeQn88f9gT37GoP8CdPRKIqccyn5klXMCzMXmxgXiA33U1xBdApV
         phKL7Y6oJqHMuNyPNkbrA8fkuJoSJtclCT6DlV4sbNFhEYoRh71OR3w1YoSmECRVdrmX
         bJ+EqUNSt4SfVYAfMThw8o4+OOuqNeNXdCilulQS1pEFabKB0fed/m9nsAE3FHgf28Tt
         5s9oD0Ammk7IScrdsNQ9otYN9ftb17Wl/mIR2fwtLw0Ei+SJ5U4VKFjJriNnbE5Ef95u
         se6yubaEdwOhFET+po90z+DhM/u2x4CqHeuJOKgTgzofYW75jZE4kv8+8G3kvzEMoYIB
         CFhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684853124; x=1687445124;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lZ4w9FZLzrevw3euUgZ/CnJwq2fkRa+GrhkB6vuUVZU=;
        b=JLFP4QVUQvBhK69+RWeQ0It59AGAl12vZzz6+rdGXY1c0n27G0PbO8uSDX1lPfYPlf
         CqxxZiwP2YtXvJfK4nHB6i0by5EcxuH1vq+DvJpjwCgZ6KQ69yRarX7bDMYV7LUhaeVr
         ZOg5nDPP38N4xZydtTf2kvMENfn0Jd0RT09kgk1uAmbrM8ves4XwAd/qDMkVQRfqRj95
         9/q6NDBHt/gVSg2WH8BglwODSw0ipkmz0r4gO2QEd70vcBpg4yvyxADAzmu7WoOCiw20
         +H/sEKtve65a9kARm4JsRF+NNBfHnTNCKamI+OzwmIyJq39csP0WP2b4MglZyrI5JfgH
         LzIQ==
X-Gm-Message-State: AC+VfDzVOjAxAKRsWhqH5v323Au2ozr1LPjHObLQFLVl7bzdN0EoOigZ
        GKSqPwX1qtXJ3IWbkYOKAZevlPsq0Pzati0=
X-Google-Smtp-Source: ACHHUZ5Uknm/33fO8x2pU4Gkt1Qyr7oafKZ5WmNy1nlRwLRdCV5Y5wya147tNmIt/yqie5nQUQ62+Nxb6oSmcW0=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:6c8])
 (user=aliceryhl job=sendgmr) by 2002:a17:906:ad82:b0:96f:5864:eb73 with SMTP
 id la2-20020a170906ad8200b0096f5864eb73mr4342619ejb.9.1684853124405; Tue, 23
 May 2023 07:45:24 -0700 (PDT)
Date:   Tue, 23 May 2023 14:44:16 +0000
In-Reply-To: <20230523144418.1250547-1-aliceryhl@google.com>
Mime-Version: 1.0
References: <20230523144418.1250547-1-aliceryhl@google.com>
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
Message-ID: <20230523144418.1250547-3-aliceryhl@google.com>
Subject: [PATCH v2 2/4] rust: sync: reword the `Arc` safety comment for `Sync`
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

The safety comment on `impl Sync for Arc` references the Send safety
comment. This commit avoids that in case the two comments drift apart in
the future.

Suggested-by: Andreas Hindborg <a.hindborg@samsung.com>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Andreas Hindborg <a.hindborg@samsung.com>
Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
---
 rust/kernel/sync/arc.rs | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
index 87a4c9ed712b..4d10f9868d9e 100644
--- a/rust/kernel/sync/arc.rs
+++ b/rust/kernel/sync/arc.rs
@@ -150,9 +150,11 @@ impl<T: ?Sized + Unsize<U>, U: ?Sized> core::ops::DispatchFromDyn<Arc<U>> for Ar
 // mutable reference, for example, when the reference count reaches zero and `T` is dropped.
 unsafe impl<T: ?Sized + Sync + Send> Send for Arc<T> {}
 
-// SAFETY: It is safe to send `&Arc<T>` to another thread when the underlying `T` is `Sync` for the
-// same reason as above. `T` needs to be `Send` as well because a thread can clone an `&Arc<T>`
-// into an `Arc<T>`, which may lead to `T` being accessed by the same reasoning as above.
+// SAFETY: It is safe to send `&Arc<T>` to another thread when the underlying `T` is `Sync`
+// because it effectively means sharing `&T` (which is safe because `T` is `Sync`); additionally,
+// it needs `T` to be `Send` because any thread that has a `&Arc<T>` may clone it and get an
+// `Arc<T>` on that thread, so the thread may ultimately access `T` using a mutable reference, for
+// example, when the reference count reaches zero and `T` is dropped.
 unsafe impl<T: ?Sized + Sync + Send> Sync for Arc<T> {}
 
 impl<T> Arc<T> {
-- 
2.40.1.698.g37aff9b760-goog

