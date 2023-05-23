Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6EA270DF93
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 16:44:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237195AbjEWOo3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 10:44:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231848AbjEWOo1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 10:44:27 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8189BC6
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 07:44:26 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-ba8c9e9e164so9564900276.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 07:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684853065; x=1687445065;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yPN2BpzOKR7Rs0wxh0Zdg1UkwhhxDvNrZrq1CaLSSZQ=;
        b=B7M4fxocDWncwNJOfecUOc8pS/sCVvN9OXU6KGy4jrD0ZzyajwUU2BDl1AikpLbEIh
         KSyWuw2wF3Cp5ZRDPAOaiNnn80ftEkOCAg6a8n6b/cDc1+ruQaE7BFWieqx7Nfaxbl0P
         rrLSe/jYHNRr2mRLZym1dcwVfPvD2kjh8n6g6t0mXyWe/MTU+l6gMqEr7LaZ0wzSSgAj
         B+OSQ+yfQ3ugA56jl33nP5KbTNVE9BYVwjP3ma/9YBy3U9UnKSnGtW6OFJ7o3R5PZQVa
         pCZJoHuoOremB/BNh1N8aKjD3J+eUzUl3Ki58VQbA2V7tURIp2lwdAWPe7HUBMUp1RI7
         hJQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684853065; x=1687445065;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yPN2BpzOKR7Rs0wxh0Zdg1UkwhhxDvNrZrq1CaLSSZQ=;
        b=Ke1QFFcSQBq7GbSlyd4KXtHF+wEkmpjimV0T+lGxo2jXluny8UWwr4cPOycQQfVpZp
         hYFhehwJoyoYda+8qCe7X9+yu7JHBw9BPmKJhVZ1MVfbPdm1vPOg4rb4LRBqk0w7dm1F
         MlyN4vEOJ72QFIaWvKQPoL0PET9Dlk+i4TFg0QxGVgJ1swghOV9c4PUrXZxLKhHWK1p4
         QyFerL3q42si2srQ0ynSI6zkZVEUc8UXYuqVIxWZQgG64FqebhQWt7zyV747jNSNZH0/
         WfynkL/UhTmbTYQDXeBCVTmh1g6gSyjmV9a9z1NpzXJeboxTiOp6RedPLRfSY1dv1AFI
         ac7A==
X-Gm-Message-State: AC+VfDw+QFVBHpcmrzpOAfkGxm9PbNPMiT1NcUopgSwc2qj6izuHlQpY
        UfvhkYKhUdEsg1nNUb1w9giBjliNjdCyEGI=
X-Google-Smtp-Source: ACHHUZ656OnC2srdDMtzUpWdENlFVaUBI5YJEFeGiZxbSyebkOl0dnFJTs2fWDoVRQLUxZB9CaeyTKcu1gllt+0=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:6c8])
 (user=aliceryhl job=sendgmr) by 2002:a05:6902:1895:b0:ba8:4ba3:5b54 with SMTP
 id cj21-20020a056902189500b00ba84ba35b54mr6433268ybb.11.1684853065789; Tue,
 23 May 2023 07:44:25 -0700 (PDT)
Date:   Tue, 23 May 2023 14:44:14 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
Message-ID: <20230523144418.1250547-1-aliceryhl@google.com>
Subject: [PATCH v2 0/4] Update thread safety markers
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

In Rust, the `Send` and `Sync` traits are used to mark in what ways a
specific type is thread safe. In this patch series, I add some missing
thread safety markers and improve the documentation related to them.
This change will let you compile some code that would currently fail to
compile even though it doesn't actually violate any thread safety rules.

You can find a definition of what these marker traits mean at [1].

[1]: https://stackoverflow.com/a/68708557/1704411

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
2.40.1.698.g37aff9b760-goog

