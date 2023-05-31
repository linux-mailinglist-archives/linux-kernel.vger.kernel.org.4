Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEB8F718582
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 17:03:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbjEaPDO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 11:03:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233817AbjEaPDM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 11:03:12 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F06E18F
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 08:03:00 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-bacfa4eefcbso2289453276.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 08:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685545380; x=1688137380;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1lJ5Uf+EcwGNh0b/3i4Z2YdTIWfA6+IGf6dwAn0jzq8=;
        b=5OgM51JSEe6PSOdk5CNCvcME9wVy09vhid7JxBNb7qJiDjF7E4J7ZYoqTcZXK7G/4Q
         fBVGQRIPzqWJ4sY8Qc07prjIwDuUtokHF0Ed2I4HNciIkLqmXpEkND10y5X5aZpnha+V
         JLsxaK5gm0+gDI/poxo2GLrXFxNVTsbSH75EjWelp+iT0fqpaAFlShM/OEEAy9Q/Z1oH
         U4OocqQZEmuNGhc3RV03kZUW3fYLSdLdiSfHU6Vi4FDgN/sFLOHJKfa+8/E/hJkpUra5
         Sjmd9/kBBv4MLQcWszMrplLIURaRI+p5FKBw8o4fAZ4CJcaOMFqdKw5U+Lr+aVFM4OvC
         h9Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685545380; x=1688137380;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1lJ5Uf+EcwGNh0b/3i4Z2YdTIWfA6+IGf6dwAn0jzq8=;
        b=TXQ5zhCBLl8D16BUdJpJ98fSGVeWI+efEzG9yZrNo6XDfCRw8aWDxkH1RgH7ghWVxD
         hmewCQTYiWKil3oXoaCkIbR5LbwrGXQNeURVHR9Dtqu9MW6SvBzheO5p4HZyL0lZUlIV
         Z1wwuIe4q6Zp9j+M2kKHDlRlHGPLELvzn24bTZ31MhKh9EpFGSvbOwPdsGWMN2amTK/q
         t2HsxfqnAdYf0w1rfD7//4afzO7pGqfO2XhAOaFtSK+mPJNGeUMewb+dKGBKmfE+QZGR
         zE7dwcOcaS2ZUTBdXAQyb6c2hqtnbyjS5hJ/qwxf0bti5eb51Tlpj/BgR1xZQuO4emfA
         Q2VA==
X-Gm-Message-State: AC+VfDyLrOdsIXDgbsXwiO3IYjfEa7tS9KWqGvFOF7cynFmm4pIBlKyb
        OMR0Woo4TfcQrtf+DS1JoR++yM6iSNh2hsY=
X-Google-Smtp-Source: ACHHUZ7jvbBEzbGMgkGfuh3So2mtf2RBfJvxuGuJkkzHzas325wMoQJCyO0TQgPDMkaiP/e7MDeDFu9c3SC1WFw=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:6c8])
 (user=aliceryhl job=sendgmr) by 2002:a05:6902:100e:b0:bb1:569c:f381 with SMTP
 id w14-20020a056902100e00b00bb1569cf381mr1335253ybt.1.1685545379836; Wed, 31
 May 2023 08:02:59 -0700 (PDT)
Date:   Wed, 31 May 2023 14:59:39 +0000
In-Reply-To: <20230531145939.3714886-1-aliceryhl@google.com>
Mime-Version: 1.0
References: <20230531145939.3714886-1-aliceryhl@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Message-ID: <20230531145939.3714886-5-aliceryhl@google.com>
Subject: [PATCH v3 4/4] rust: task: add `Send` marker to `Task`
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

When a type also implements `Sync`, the meaning of `Send` is just "this
type may be accessed mutably from threads other than the one it is
created on". That's ok for this type.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Andreas Hindborg <a.hindborg@samsung.com>
Reviewed-by: Gary Guo <gary@garyguo.net>
Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Reviewed-by: Benno Lossin <benno.lossin@proton.me>
---
 rust/kernel/task.rs | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/task.rs b/rust/kernel/task.rs
index 526d29a0ae27..7eda15e5f1b3 100644
--- a/rust/kernel/task.rs
+++ b/rust/kernel/task.rs
@@ -64,8 +64,14 @@ macro_rules! current {
 #[repr(transparent)]
 pub struct Task(pub(crate) Opaque<bindings::task_struct>);
 
-// SAFETY: It's OK to access `Task` through references from other threads because we're either
-// accessing properties that don't change (e.g., `pid`, `group_leader`) or that are properly
+// SAFETY: By design, the only way to access a `Task` is via the `current` function or via an
+// `ARef<Task>` obtained through the `AlwaysRefCounted` impl. This means that the only situation in
+// which a `Task` can be accessed mutably is when the refcount drops to zero and the destructor
+// runs. It is safe for that to happen on any thread, so it is ok for this type to be `Send`.
+unsafe impl Send for Task {}
+
+// SAFETY: It's OK to access `Task` through shared references from other threads because we're
+// either accessing properties that don't change (e.g., `pid`, `group_leader`) or that are properly
 // synchronised by C code (e.g., `signal_pending`).
 unsafe impl Sync for Task {}
 
-- 
2.41.0.rc0.172.g3f132b7071-goog

