Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE64270DF95
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 16:45:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237082AbjEWOpL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 10:45:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234406AbjEWOpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 10:45:08 -0400
Received: from mail-ej1-x64a.google.com (mail-ej1-x64a.google.com [IPv6:2a00:1450:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9E49C6
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 07:45:06 -0700 (PDT)
Received: by mail-ej1-x64a.google.com with SMTP id a640c23a62f3a-94a356c74e0so745525866b.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 07:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684853105; x=1687445105;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qdVRg6LoNElWahe9YlmLHc0fO9VPVtOwab5a4NPQ+t0=;
        b=L+ydM2ZMhTGwNMwmjmnRmRfMJfy783Y8dALDZDlyzR0avEpxlOnKtSq5GYMkYzb317
         vtIYmC0LT38gm6XodkzGrp11N2LZSJzXE2oX4+W0z/RRuSLisAL86VqLi7RA5QO8f8GZ
         MxaI60HRLpFzgsFuRKnLFYwHloYozwkZC6aKvzAr95gWRC27FvpWdG3aAxjmKIqnSmbw
         p1oYFQpe3C9rz5RILbQYi1dfGzQIBcN6VOtGm7F2Kkm2Uaml0QsfDRilvm4+zqsDKcZW
         G511w179klPw2ryx75gy6gXzIM9R+enCxH/3gS0BhdyC4bXWrH8OjIEVk2y5yvwAQAE+
         6usg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684853105; x=1687445105;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qdVRg6LoNElWahe9YlmLHc0fO9VPVtOwab5a4NPQ+t0=;
        b=dQZ63bLZswOTOoZOYggd1PitKu78pPpWfqj/97g/P8vAt4e5C2t1hwYuySckw35pO+
         8a4FJzsfyh5z7MqozpdJ2LBzMGoi86noA8wlBmHfWQr4DJLo/c2GV2b/z71FxIRucsDj
         H3pohODzU6yS4VWgnRIdNqRwsctUQoCwCSZqp+WYfg6bOmU4JFDh6WiqRLdQnI/VpMrU
         fGEy91G6DxHIYxUb+YADz0CUdcd172a82daqaP9wf0fRdhSJho1pLH4F/ZogfuXcQEyt
         dIzipXO53b/jCY7WxwOt7stxbxrR93jZBWQHtCHL53763Vc1HZZVI+tl2V/VCRZXhVBE
         uOyQ==
X-Gm-Message-State: AC+VfDy5X6mUAL1YnUhM4bmmxiGSjWXHqsW9PFdw7/z+oXLNqdncmNf8
        1oMLxRaPoK4FOphUwBpg0bLTwk588vcFfRs=
X-Google-Smtp-Source: ACHHUZ5EOxmKcPckGGYoWG+E6eScW9ff6mALx3v5X3xhD+aggfd1Uq5KEgyfu4kvGgNrs8PkLoMCyDXlb999Xwc=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:6c8])
 (user=aliceryhl job=sendgmr) by 2002:a17:906:8453:b0:965:ecf8:4af5 with SMTP
 id e19-20020a170906845300b00965ecf84af5mr5174037ejy.12.1684853105342; Tue, 23
 May 2023 07:45:05 -0700 (PDT)
Date:   Tue, 23 May 2023 14:44:15 +0000
In-Reply-To: <20230523144418.1250547-1-aliceryhl@google.com>
Mime-Version: 1.0
References: <20230523144418.1250547-1-aliceryhl@google.com>
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
Message-ID: <20230523144418.1250547-2-aliceryhl@google.com>
Subject: [PATCH v2 1/4] rust: sync: reword the `Arc` safety comment for `Send`
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

The safety comment on `impl Send for Arc` talks about "directly"
accessing the value, when it really means "accessing the value with a
mutable reference". This commit clarifies that.

Suggested-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Andreas Hindborg <a.hindborg@samsung.com>
Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
---
 rust/kernel/sync/arc.rs | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
index e6d206242465..87a4c9ed712b 100644
--- a/rust/kernel/sync/arc.rs
+++ b/rust/kernel/sync/arc.rs
@@ -146,8 +146,8 @@ impl<T: ?Sized + Unsize<U>, U: ?Sized> core::ops::DispatchFromDyn<Arc<U>> for Ar
 
 // SAFETY: It is safe to send `Arc<T>` to another thread when the underlying `T` is `Sync` because
 // it effectively means sharing `&T` (which is safe because `T` is `Sync`); additionally, it needs
-// `T` to be `Send` because any thread that has an `Arc<T>` may ultimately access `T` directly, for
-// example, when the reference count reaches zero and `T` is dropped.
+// `T` to be `Send` because any thread that has an `Arc<T>` may ultimately access `T` using a
+// mutable reference, for example, when the reference count reaches zero and `T` is dropped.
 unsafe impl<T: ?Sized + Sync + Send> Send for Arc<T> {}
 
 // SAFETY: It is safe to send `&Arc<T>` to another thread when the underlying `T` is `Sync` for the
-- 
2.40.1.698.g37aff9b760-goog

