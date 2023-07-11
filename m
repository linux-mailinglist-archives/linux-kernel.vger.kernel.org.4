Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C33C74EA9B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 11:34:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbjGKJeB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 05:34:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjGKJd7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 05:33:59 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71D4B100
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 02:33:58 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-c64ef5bde93so6488298276.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 02:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689068037; x=1691660037;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=i+zDEU10wYnr89r/fFOaqQkCw/zLk+nePTObPe5KGak=;
        b=4cOhTU9J7VvWcpswEGbcooTo36VAK9TcuU2c6+Hur/0i1hcy3Tc3+j8tqPjGWJXh0F
         vArzmq0YYav0AhtC0YABYFyw/vGTZZpGTBVKGjSalFfCd7p/Fd+PfJ4rTr5MA+KypJMg
         jZziMqtHCxaXQ016l56d+FP+93N0bs9EwvrcEEZ5+N56TDyB0LHezclxnDyS4HSFuwyw
         V+bLokMXh1FDeCHSlcb1iy8WqLa2VcAQe37sb2wCt3dwSTJ1vDEsbryfbBh7TZ5pRgCe
         7BbsjesnBgGZDUCAVfSLO5jRzgC3EL3PPkd0piev9chZHjo/otF3aQWm/CBDy12n5FyI
         AAYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689068037; x=1691660037;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i+zDEU10wYnr89r/fFOaqQkCw/zLk+nePTObPe5KGak=;
        b=GbDsVlv6UdaU6N03CJV2bXN0Fl0l7UMoqUh3v9mVsHjJSdiMkIU3FHlcsVRmCMbTGi
         3ej1BtI5rKZls4FItBCHmxhsfSr1iYDrnGJ0L/w/YDmb2CqZEbnZi8KX0fLnE5Cu64ka
         AEWn+BTLmrf32RPBCqtTI/kqObO3y34tx1QMg2wsM9bc7imVO39O0F7Ze+gdtBYa7NWp
         8HEuYGCmBEYIvdM6vI0aXne1ShkQ+bXhYji43mNd031LEnNsP8vLIi8xDGNO7TqTEjlt
         orffXkxA+dg2R0GHFXJxehLyIaFAOMBEJvceuqS4HlbYDyJ2MdijJmpCfOQzy4KGBHnD
         Np6Q==
X-Gm-Message-State: ABy/qLbVGUJVP89IeJwjogQAYZvp3poeTs34KGnxex6/edCAJ2rxAel+
        IQQ2xB07fYpVXeoCghmGZ9DlX+uuMTPgzH0=
X-Google-Smtp-Source: APBJJlG7CVg8ZIjiHugsIIAwsKz38An7XLFFQ67zguULn2KMYeTniDrNRdInRiElbolNDz0ZuyBpq8JoTzIBmpc=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:6c8])
 (user=aliceryhl job=sendgmr) by 2002:a25:ad54:0:b0:c1a:dc07:1d74 with SMTP id
 l20-20020a25ad54000000b00c1adc071d74mr135384ybe.0.1689068037722; Tue, 11 Jul
 2023 02:33:57 -0700 (PDT)
Date:   Tue, 11 Jul 2023 09:32:54 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230711093303.1433770-1-aliceryhl@google.com>
Subject: [PATCH v3 0/9] rust: workqueue: add bindings for the workqueue
From:   Alice Ryhl <aliceryhl@google.com>
To:     rust-for-linux@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>
Cc:     Lai Jiangshan <jiangshanlai@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        "=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?=" <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Alice Ryhl <aliceryhl@google.com>,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset contains Rust bindings for the kernel workqueue.

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

Changes v2 -> v3:

 * Moved dependency patches so they are first.
 * Various documentation and comment improvements.
 * Changed implementation of `Arc::from_raw`.
 * Use __INIT_WORK_WITH_KEY instead of __INIT_WORK and use `LockClassKey`
   where appropriate.
 * Removed PhantomPinned from Work. This depends on [1] for correctness.

More detailed changelogs can be found on the individual patches.

v1: https://lore.kernel.org/all/20230517203119.3160435-1-aliceryhl@google.com/
v2: https://lore.kernel.org/all/20230601134946.3887870-1-aliceryhl@google.com/

[1]: https://lore.kernel.org/all/20230630150216.109789-1-benno.lossin@proton.me/

Alice Ryhl (5):
  rust: workqueue: add low-level workqueue bindings
  rust: workqueue: add helper for defining work_struct fields
  rust: workqueue: implement `WorkItemPointer` for pointer types
  rust: workqueue: add `try_spawn` helper method
  rust: workqueue: add examples

Wedson Almeida Filho (4):
  rust: add offset_of! macro
  rust: sync: add `Arc::{from_raw, into_raw}`
  workqueue: introduce `__INIT_WORK_WITH_KEY`
  rust: workqueue: define built-in queues

 include/linux/workqueue.h       |  17 +-
 rust/bindings/bindings_helper.h |   1 +
 rust/helpers.c                  |   8 +
 rust/kernel/lib.rs              |  39 ++
 rust/kernel/sync/arc.rs         |  49 ++-
 rust/kernel/workqueue.rs        | 659 ++++++++++++++++++++++++++++++++
 scripts/Makefile.build          |   2 +-
 7 files changed, 767 insertions(+), 8 deletions(-)
 create mode 100644 rust/kernel/workqueue.rs


base-commit: d2e3115d717197cb2bc020dd1f06b06538474ac3
-- 
2.41.0.255.g8b1d071c50-goog

