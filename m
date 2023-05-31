Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A208571856C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 17:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233305AbjEaPAO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 11:00:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231501AbjEaPAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 11:00:12 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C463410E
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 08:00:10 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5659c7dad06so121917837b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 08:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685545210; x=1688137210;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kgt3lW2r0aoY0DDLcZTyq/QALzXXToKg0VwThNVsEZs=;
        b=DxCZiH1EJ6GTCeR7M1xZCCD83a49cOiQ9TFOb2cpTE+xJykFniGsMxkSKaNxVhgrie
         1ZUAUK64KCNds1oQP+SCgoYSGdYMWl4o7suvBgY/fiRhtcgkzNsNtzRN+NWwpIus8zx3
         Vae/ZhynetGaQPIjblP8vLMJRXOMjpcH629xoRqz8t5E2fEZrJswrNEjr6nEe/aHzUTs
         RF6bxBNTe+6jyJyimjvXZ6/h8o3aJ6JwIzR0C63FS93ayeG0tDJuGhpRYKeAhQSqums1
         4tURIQ+m9vlVvRiXXfNzi4B2tWPJXtV8fwHUDZ2/v9rrUFsoB2tqZmw9E2ZE5l2J9MU8
         roSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685545210; x=1688137210;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kgt3lW2r0aoY0DDLcZTyq/QALzXXToKg0VwThNVsEZs=;
        b=Jf0t8p0gyW2apWyfZugEzysCpYMR3uKUPBrH3UiV1pP6AKB1M5QN0MDAbduerV6ERk
         49RRyH3rCDqE9L981QAoXMEnSkqhN2Ua5AFzERvXYMAygSzL+8agrsxSpJzt1Zl3d4qG
         77j4NvoeoO8e195dK4G0mGG136yj2BNytxHAzqc9dYNSqOyZM4MgDBJQ/fZSH3aVUelp
         iD2v+7JCpIwyR6y7CF+hJiZxP2/50CLdwyAvu2LIZRke0z8SWgcxWlccB6PUA7GfDnUq
         Dgb1H4vgXisQqK2goKRB9xpqxQPGl9FuN1ZVpdziYMGhp/2R//VNsSByAjQ/iuFHlOn+
         Hqtw==
X-Gm-Message-State: AC+VfDwbHHW+FigKuTSWUjokhLugR/BsLJcC5S+sPkrzE0Lsb6vxZVkd
        tx95mDqEllTq0g1O4+HpdLCEkaUmNoNlLsY=
X-Google-Smtp-Source: ACHHUZ5PGbClUzmUIu5JqGN5ZZy5XtiWsjT/HcmZjSMbK2ZzZTMOkv46r/SbQAgSQWglSlAAgf/x7TZItrF2jmQ=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:6c8])
 (user=aliceryhl job=sendgmr) by 2002:a81:ae05:0:b0:565:9f59:664f with SMTP id
 m5-20020a81ae05000000b005659f59664fmr3434986ywh.6.1685545210063; Wed, 31 May
 2023 08:00:10 -0700 (PDT)
Date:   Wed, 31 May 2023 14:59:35 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Message-ID: <20230531145939.3714886-1-aliceryhl@google.com>
Subject: [PATCH v3 0/4] Update thread safety markers
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
        linux-kernel@vger.kernel.org, patches@lists.linux.dev
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

In Rust, the `Send` and `Sync` traits are used to mark in what ways a
specific type is thread safe. In this patch series, I add some missing
thread safety markers and improve the documentation related to them.
This change will let you compile some code that would currently fail to
compile even though it doesn't actually violate any thread safety rules.

You can find a definition of what these marker traits mean at [1].

Changes since v2:

 * Removed "for example" as suggested in [2].
 * Added Reviewed-by annotations from v2 review.

[1]: https://stackoverflow.com/a/68708557/1704411
[2]: https://lore.kernel.org/all/20230523165027.71600b4b.gary@garyguo.net/

Alice Ryhl (4):
  rust: sync: reword the `Arc` safety comment for `Send`
  rust: sync: reword the `Arc` safety comment for `Sync`
  rust: specify when `ARef` is thread safe
  rust: task: add `Send` marker to `Task`

 rust/kernel/sync/arc.rs | 12 +++++++-----
 rust/kernel/task.rs     | 10 ++++++++--
 rust/kernel/types.rs    | 13 +++++++++++++
 3 files changed, 28 insertions(+), 7 deletions(-)


base-commit: ac9a78681b921877518763ba0e89202254349d1b
-- 
2.41.0.rc0.172.g3f132b7071-goog

