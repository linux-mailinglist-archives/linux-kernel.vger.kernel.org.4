Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EDBE70DF99
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 16:46:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237366AbjEWOqG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 10:46:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232856AbjEWOqE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 10:46:04 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF659119
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 07:46:02 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-ba8bab3b392so9966548276.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 07:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684853162; x=1687445162;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=r16leosVab/uLX7D74lYCjCyQd2teI7cw9N2TnAgQsA=;
        b=Hd/uUrDISL30aYgFZm7tT9bNmVfu5Hj5bE8z8pqztEcp7fh7IokeZvyVl4+oOgQpv2
         1msJ8stWSASsldMCECBLTZSZbmB67D/T7j1oTM2DeUMplouDBShHymsHyviGEf60tBiM
         d5vZPUEHKU0E12wSNBYOP4P1NYGjDUM5j4FC2jB/qherVgJcq2o2o9Lx9KuA3cUjjFbh
         fGZSVMVBEzRtgYXzq81Yb06w9UEFGdV9cfI9x14itoTZcmT+hYvViRiWZtK/VEhv4HGE
         vpDT/Rx7Cux0WO7uyvBET3G0qLUukSAXX6k4OFRmxbn4iL0lJKuXNJeqS7trW8tXqQhC
         akzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684853162; x=1687445162;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r16leosVab/uLX7D74lYCjCyQd2teI7cw9N2TnAgQsA=;
        b=VnRpNx//PCRUC6kaSXEDNJ8FdJ4eH801yTEA5aq0Ko3Ebl714GMxqyxLaWj7U4PtFp
         VGqMt9n5Hu9M+vzrVUGlRdoIvfZ7cfM6RnGol8p8fBc5d507Dj9N0sCpVYfM4qNXipA6
         SqEIR5TIpCLR8979SWUaeKtG2iyOLzWmgWIItX9xnitrvWCB55qdqN1Utumom4yqQsxR
         XynjuwjhlDuUZRSpSGGVZ9clB9O2TtMqx+aOd71901m9XIpbG/twLTS5ReYTDQdb4Rth
         ZbUnBHoJmTin2AXPcdI+zjsTGffcHJhjOlJSTIvlhlMVq4XKHoH0FQQeG7eTGnb2qYOU
         k7XA==
X-Gm-Message-State: AC+VfDz50AZaG3GN0VbaW9/M6hqDrCeOOxrbC9havZwxldmQ0oyUp+oA
        ml+IyI1WuPUCq/uTq2SvMgVDZZCPaIqRbj4=
X-Google-Smtp-Source: ACHHUZ5GGO9M9zi95iQU/We2rgCa/AZ2NpDuHENeetlWQiYs4A5/3srhvSG4IjsY4UStilvM/k6fLMYqCtGwmFY=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:6c8])
 (user=aliceryhl job=sendgmr) by 2002:a25:9989:0:b0:ba2:2d0e:a752 with SMTP id
 p9-20020a259989000000b00ba22d0ea752mr8278874ybo.6.1684853162123; Tue, 23 May
 2023 07:46:02 -0700 (PDT)
Date:   Tue, 23 May 2023 14:44:18 +0000
In-Reply-To: <20230523144418.1250547-1-aliceryhl@google.com>
Mime-Version: 1.0
References: <20230523144418.1250547-1-aliceryhl@google.com>
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
Message-ID: <20230523144418.1250547-5-aliceryhl@google.com>
Subject: [PATCH v2 4/4] rust: task: add `Send` marker to `Task`
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

When a type also implements `Sync`, the meaning of `Send` is just "this
type may be accessed mutably from threads other than the one it is
created on". That's ok for this type.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Andreas Hindborg <a.hindborg@samsung.com>
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
2.40.1.698.g37aff9b760-goog

