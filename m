Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 072997064CA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 11:59:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbjEQJ7b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 05:59:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230240AbjEQJ7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 05:59:25 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D40E5BAA
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 02:59:18 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-560ee0df572so7567627b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 02:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684317557; x=1686909557;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=J+riL/nvu1twHwHqCACNcwNJex8EunROGCv0pZTyq3c=;
        b=3SFYtDlzFGF0m5RFD90h5jV9WZN4ZQwsCYqL/L/KzsZpuhNTLNtc4NH8KkUmRUjhHw
         yU+/GY4lHVLt8d1eTEBvKc6iGCGTvz6I045YZE8Ng2XHGgSWo+1d0F2TwuhQuaeomJDH
         i/6cV5XiGTYvBIxkfd7/+PUO2skxtNeaGRppfUZYo2OsYGRYf/AbtvCjVoszYi4K7rMv
         NyCLauJl4qVfLHNz0jiJglxu5L01hZP5yijMYDdXMXBUcLgeVuKltS5XBDCm6fa/qfAn
         Dbzm2INF6PUBvWIX8Q1PMEbamATl0vdm0foAco2RbUnHFx4WCbE6oar+BGe9b+EwsDiJ
         KJ+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684317557; x=1686909557;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J+riL/nvu1twHwHqCACNcwNJex8EunROGCv0pZTyq3c=;
        b=mB9MkQ+G7YUmsF3/VIkxnKkhs7LcvS5gNeeRJYMD/mm4mPvqwINgn5OEXPAYCoGjoz
         Obbzfid4jphTGABKEZ2rJs62TUkrWGf/Ud3beM+bGulivkYvwRr+fwQq4udC/muh8rdI
         afEYnV8XvfSW4Wb1+HxYCoCD5WjJZ6vxQYJSDl09KI3go99wrWMiyTCSDBs2TwiCmBHH
         k5AxbPmlszEPdCwLVupLfkvtIpFgFhctCaSmHRuOGipwb5tzO4tbOPME2sOZuK/ctIgJ
         8ujZH4wpw0mzmAQoFvSf4/LmfpzZ0Vuo6pRL/E4Lm7FOBD0gfKXbUcgDIIG07EnFWwTB
         xT5Q==
X-Gm-Message-State: AC+VfDwAFgVcKYI/GzgvFcepTYpgcVRQWZQzLhoeH3klOUvqIs58lUp1
        EcFp0SqGXgWh1CbpOuUU/CEp2ILowvoWZ5k=
X-Google-Smtp-Source: ACHHUZ60EDILvcrgq8I5bNFxfKYG43DpQ8rRj9CmpjDxgovsZUytRTZqwAp2m8+fTB4YrFpINFTOmK2/L+22Ghk=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:6c8])
 (user=aliceryhl job=sendgmr) by 2002:a81:400c:0:b0:560:c30c:75f7 with SMTP id
 l12-20020a81400c000000b00560c30c75f7mr15720009ywn.2.1684317557527; Wed, 17
 May 2023 02:59:17 -0700 (PDT)
Date:   Wed, 17 May 2023 09:59:05 +0000
In-Reply-To: <20230517095905.3548100-1-aliceryhl@google.com>
Mime-Version: 1.0
References: <20230517095905.3548100-1-aliceryhl@google.com>
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
Message-ID: <20230517095905.3548100-2-aliceryhl@google.com>
Subject: [PATCH v1 2/2] rust: task: add `Send` marker to `Task`
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
        patches@lists.linux.dev
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
---
 rust/kernel/task.rs | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/rust/kernel/task.rs b/rust/kernel/task.rs
index 526d29a0ae27..4f1fe9aa9f6e 100644
--- a/rust/kernel/task.rs
+++ b/rust/kernel/task.rs
@@ -64,6 +64,11 @@ macro_rules! current {
 #[repr(transparent)]
 pub struct Task(pub(crate) Opaque<bindings::task_struct>);
 
+// SAFETY: The only situation in which this can be accessed mutably is when the refcount drops to
+// zero and the destructor runs. It is safe for that to happen on any thread, so it is ok for this
+// type to be `Send`.
+unsafe impl Send for Task {}
+
 // SAFETY: It's OK to access `Task` through references from other threads because we're either
 // accessing properties that don't change (e.g., `pid`, `group_leader`) or that are properly
 // synchronised by C code (e.g., `signal_pending`).
-- 
2.40.1.606.ga4b1b128d6-goog

