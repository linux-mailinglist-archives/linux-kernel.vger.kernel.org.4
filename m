Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28984719ED0
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 15:50:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232640AbjFANuC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 09:50:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230222AbjFANt7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 09:49:59 -0400
Received: from mail-ej1-x649.google.com (mail-ej1-x649.google.com [IPv6:2a00:1450:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3012B189
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 06:49:57 -0700 (PDT)
Received: by mail-ej1-x649.google.com with SMTP id a640c23a62f3a-94a34d3e5ebso57052966b.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 06:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685627395; x=1688219395;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=az0YAt2KTk16nw2JnbQbsBwE6ykYTuim3D59K9WH+fw=;
        b=f0NVKnLT6zT+WJcXI/mgsB1RJu7ayQo/PmjvmqEjy4BKO1oF0CUDIGmF1Py4hgizlm
         cC/GDDrvtyAPc0iyKHkXMfEaBm/kRQYss84Gj02VgxmApJh9i1J5Y9EzwpjOI4zcofff
         6KL5DSSGvLYDJ37W3hL8/4o0N/nXPCAlLEHH3RX3gDbz1jqH3ri8sfosyh9YBI/WNvDi
         tGfSmu8Y9tuPYhuhMT853gwRACSeGK3X9kzCyRBKRfHKZGyAortUk8PiebJlG1JXdwMJ
         peRS9BRK08EB08n/nfekR46px7ccFRpU6h8jzGakPHG7M9E2IfPsF20HOA2CpGYdriYS
         ASHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685627395; x=1688219395;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=az0YAt2KTk16nw2JnbQbsBwE6ykYTuim3D59K9WH+fw=;
        b=bw+NnHBWF0tM9pMTejyemfLXS+vRFUMu79qCoVRDJdfiAoJjRX7AiP6cMCyeOXsgjE
         Ji4XpDw0MXGR0huaXP7oKzNIKM7m8OkFvMFqvhoPAGxptDI/yQrHAVkcaJ6mATvc3oi/
         qpnBpfNxTyJkLLOaXmKXi9JDm7ZIxvmpiRrxYAqz339j9kMhG1qW+J6/G5gG+0G+z0BK
         Hkk51nW/QDZAEZSVglkbgT3lDagnF572X0G4WUYsR1rswHIAs2DjJOIsL6HiuY8682ud
         TPWRBLKqT3gBKsAnsElyitzKNcs0TJlPIw4UyrfaKlL+psBsXkzYSpB/2pGjF9RQN5OQ
         damw==
X-Gm-Message-State: AC+VfDxCiZh4RpdknHPEKL1RWeOwZJbNYFZsTXW06+ZDZ8E7pU8/s+GJ
        COHoV/Brjwl/Sh1AvbIyoHNpS6ErypqKLww=
X-Google-Smtp-Source: ACHHUZ6y558j5AwsRrstwPTYGwrzuoI4R2q5Hll3BeCCQsm0d7NK4qsQFtXx0QME/IjY8y5dnLNNjCUJZBL7QmI=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:6c8])
 (user=aliceryhl job=sendgmr) by 2002:a17:907:270c:b0:965:b935:91f6 with SMTP
 id w12-20020a170907270c00b00965b93591f6mr2284491ejk.14.1685627395637; Thu, 01
 Jun 2023 06:49:55 -0700 (PDT)
Date:   Thu,  1 Jun 2023 13:49:38 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Message-ID: <20230601134946.3887870-1-aliceryhl@google.com>
Subject: [PATCH v2 0/8] rust: workqueue: add bindings for the workqueue
From:   Alice Ryhl <aliceryhl@google.com>
To:     rust-for-linux@vger.kernel.org
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        "=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?=" <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Alice Ryhl <aliceryhl@google.com>,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset contains bindings for the kernel workqueue.

One of the primary goals behind the design used in this patch is that we
must support embedding the `work_struct` as a field in user-provided
types, because this allows you to submit things to the workqueue without
having to allocate, making the submission infallible. If we didn't have
to support this, then the patch would be much simpler. One of the main
things that make it complicated is that we must ensure that the function
pointer in the `work_struct` is compatible with the struct it is
contained within.

The original version of the workqueue bindings was written by Wedson,
but I have rewritten much of it so that it uses the pin-init
infrastructure and can be used with containers other than `Arc`.

Changes since v1:

Most of this patchset was rewritten based on Gary's example for how
field projections can be used with the workqueue.

I have also added some examples of how the workqueue bindings will be
used. You can find those in the last patch of this patchset.

v1: https://lore.kernel.org/all/20230517203119.3160435-1-aliceryhl@google.com/

Alice Ryhl (5):
  rust: workqueue: add low-level workqueue bindings
  rust: workqueue: add helper for defining work_struct fields
  rust: workqueue: implement `WorkItemPointer` for pointer types
  rust: workqueue: add `try_spawn` helper method
  rust: workqueue: add examples

Wedson Almeida Filho (3):
  rust: add offset_of! macro
  rust: sync: add `Arc::{from_raw, into_raw}`
  rust: workqueue: define built-in queues

 rust/bindings/bindings_helper.h |   1 +
 rust/helpers.c                  |   8 +
 rust/kernel/lib.rs              |  37 ++
 rust/kernel/sync/arc.rs         |  42 ++-
 rust/kernel/workqueue.rs        | 631 ++++++++++++++++++++++++++++++++
 scripts/Makefile.build          |   2 +-
 6 files changed, 719 insertions(+), 2 deletions(-)
 create mode 100644 rust/kernel/workqueue.rs


base-commit: d09a61024f6b78c6a08892fc916cdafd87b50365
-- 
2.41.0.rc0.172.g3f132b7071-goog

