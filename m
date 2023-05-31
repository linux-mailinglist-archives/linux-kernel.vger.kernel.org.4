Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 572D2718573
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 17:00:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233554AbjEaPAw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 11:00:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233543AbjEaPAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 11:00:47 -0400
Received: from mail-ed1-x54a.google.com (mail-ed1-x54a.google.com [IPv6:2a00:1450:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0441B107
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 08:00:42 -0700 (PDT)
Received: by mail-ed1-x54a.google.com with SMTP id 4fb4d7f45d1cf-514b8d2b21fso893088a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 08:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685545240; x=1688137240;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=v7AwI9/GAng9F6JU881/rPRp6iZXP9LwiNNuLduw3ys=;
        b=OMfl8/Z1UwxPwIyaHYkJ8H7XXz53ExBje25D3fSggmAEgqJKexyNv/r05uILaNVDH3
         T5pW/a/d7fWKUhDGhaJRx9W6nzSAhQEKxq4NCO9CY3nxTH5muUNEJCcdJEwE4FDKS5YE
         mYtD4BXfm5MS0N3+F6W6wTY8BVSX/OtnsTIl/ym9yDrzKwkqbJuxky5teH0ZIc6hZGV+
         4zu2xJq1E0BdirdqaHNQC6za3BZrmsP+frmwlo6ZL3kMQZ+wZwP9hNv7crfRZDRjX8oC
         c0qI0l8MuhuhbctU5kMcULymtY0J4dWQT3OiUwRNBTlaEv30nTmYbag6K13T0WiAy6ga
         xXMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685545240; x=1688137240;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v7AwI9/GAng9F6JU881/rPRp6iZXP9LwiNNuLduw3ys=;
        b=al7UXEMwXm+nJZj+px7Ron3P3P9L3hpYHBGA8oofgTcaHcmhmlVgWOaCxTRgVwBbTo
         lT/f3ZCi2FYoae5DH/KfgsUCEjGkpd7Rue16Zt++B7nKV5gh+YJe4EzkfZXse+8UL3h6
         +IJ9+Wh6rS1WGKVH4cq3Hbwi2l+t6Nvcc1xI9q9dtWDnNjbryIN2s+Bku70hC3hf64S4
         p86aJN3s1nz4SlN1F2/0cFrgiinhxOUqeKnQ9brBs8NmbKl9AANnRoHJ7XaYzjKgPs40
         gDPtfMRRze6lURduZeXi9Eb1yipbe9SnCetau8wh5OYiAdWVmPdTi2YDX2Zb2RjxaDvK
         2+OA==
X-Gm-Message-State: AC+VfDxwIQA1oVnnQHTFdayIZ3ZsYtcCmbnCQ4B5FVPQ5oyJbY1U4P0J
        sIPognhAHI7O1trkCRdYUSP4D1YesnhGR/s=
X-Google-Smtp-Source: ACHHUZ68XPwYHak3RB9bb2krSE7KWIbi6M9HKaemsTXiQeyDGltkWQmmatoHjKKHCoSRCi/az8D3w9Kajgq9dOk=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:6c8])
 (user=aliceryhl job=sendgmr) by 2002:a50:cdc1:0:b0:504:fcf5:63ee with SMTP id
 h1-20020a50cdc1000000b00504fcf563eemr1888238edj.0.1685545240591; Wed, 31 May
 2023 08:00:40 -0700 (PDT)
Date:   Wed, 31 May 2023 14:59:36 +0000
In-Reply-To: <20230531145939.3714886-1-aliceryhl@google.com>
Mime-Version: 1.0
References: <20230531145939.3714886-1-aliceryhl@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Message-ID: <20230531145939.3714886-2-aliceryhl@google.com>
Subject: [PATCH v3 1/4] rust: sync: reword the `Arc` safety comment for `Send`
From:   Alice Ryhl <aliceryhl@google.com>
To:     rust-for-linux@vger.kernel.org
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        "=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?=" <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Alice Ryhl <aliceryhl@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>
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
Reviewed-by: Gary Guo <gary@garyguo.net>
Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Reviewed-by: Benno Lossin <benno.lossin@proton.me>
---
 rust/kernel/sync/arc.rs | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
index e6d206242465..3ad831603cf4 100644
--- a/rust/kernel/sync/arc.rs
+++ b/rust/kernel/sync/arc.rs
@@ -146,8 +146,8 @@ impl<T: ?Sized + Unsize<U>, U: ?Sized> core::ops::DispatchFromDyn<Arc<U>> for Ar
 
 // SAFETY: It is safe to send `Arc<T>` to another thread when the underlying `T` is `Sync` because
 // it effectively means sharing `&T` (which is safe because `T` is `Sync`); additionally, it needs
-// `T` to be `Send` because any thread that has an `Arc<T>` may ultimately access `T` directly, for
-// example, when the reference count reaches zero and `T` is dropped.
+// `T` to be `Send` because any thread that has an `Arc<T>` may ultimately access `T` using a
+// mutable reference when the reference count reaches zero and `T` is dropped.
 unsafe impl<T: ?Sized + Sync + Send> Send for Arc<T> {}
 
 // SAFETY: It is safe to send `&Arc<T>` to another thread when the underlying `T` is `Sync` for the
-- 
2.41.0.rc0.172.g3f132b7071-goog

