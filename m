Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D9227064C9
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 11:59:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbjEQJ71 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 05:59:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230184AbjEQJ7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 05:59:21 -0400
Received: from mail-ej1-x649.google.com (mail-ej1-x649.google.com [IPv6:2a00:1450:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 639A95FE2
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 02:59:15 -0700 (PDT)
Received: by mail-ej1-x649.google.com with SMTP id a640c23a62f3a-94a34d3e5ebso61580766b.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 02:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684317554; x=1686909554;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oVJvngviayRWrsi8hPEk5VyWaF+LdxzTgL6t46JKF4M=;
        b=KecI38Q9xTWAE0PprFQml7YSBfXofANn7rQwnOlqGZQhMFXccrFjTplXYrzs4eN+zL
         EOs4w1CsvnWy4Sl7/g2Q04dfjnQcFZ0PU3eNVE3of+GxwjTtqvjXaMMaCLB45mXBvxQ8
         XQyUxZ+6WAI4I+ZwpHt8lMyNKBe30GTIDb3KwJZOIP8cWvdLWbRNUfSab3fBbxm/wQU6
         4GBbokznler4dGVzWDXLxxPibCJKbrZkNleLTOX149a8i79MvxPSG9vVwxARsKwBi6x8
         VL6QSfteq/nEsNQCxnnU6qdc7q9PZquW7l+93/XCP0DeU/rYfLLxKVvpu0Psb7JsdBk5
         NELg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684317554; x=1686909554;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oVJvngviayRWrsi8hPEk5VyWaF+LdxzTgL6t46JKF4M=;
        b=L0qmQS9hUmgfJj5rut/zWavK+t7gaB/4jB0FjQy5miJAQXrwaDRaVsDVbk7FuRgPk4
         os3NYXWESmeX0hYkNt5bJxvWym1jkFK8cZguJyMkKaWx2TBzZalzqAjfBM+Jrpsq4SIv
         It9tj2cXE9HlJikeh9w5BDGdtGIl6Efy4SvnoNF+dSvqt0P4MXxydfVVsU5CaT3GZXMl
         l/N2hcDHvstkEs19UqRKAfNHrzZ3fqB+SCVTKvGgBbDh4ApHFVZoXhbnBNZMeje2Oo0S
         TNjJ6Yjli5pydyg/2vMRoeSazpAd5ogN5zRFnCPB8csOzYBSC+NwlI8SDS/9QvNV43rJ
         5Qng==
X-Gm-Message-State: AC+VfDzQikbXiAeFR4QfO4k/ccYRcn9HljX9XYbV7MicaMKP8fWqAWLa
        kf6ObeDAZlNsXUMQe9rRGjtgQQjjXmQ4pYk=
X-Google-Smtp-Source: ACHHUZ4QmWt9xgKfOeGLFUBiX8JY8AUf7sbDVzygI0+aeWmzcjN2/WavO+1jXqJgJlfTOPfLxp8s7SGhU7+wK5w=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:6c8])
 (user=aliceryhl job=sendgmr) by 2002:a17:906:9bc2:b0:94f:23d8:839 with SMTP
 id de2-20020a1709069bc200b0094f23d80839mr13337271ejc.10.1684317553900; Wed,
 17 May 2023 02:59:13 -0700 (PDT)
Date:   Wed, 17 May 2023 09:59:04 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
Message-ID: <20230517095905.3548100-1-aliceryhl@google.com>
Subject: [PATCH v1 1/2] rust: specify when `ARef` is thread safe
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

An `ARef` behaves just like the `Arc` when it comes to thread safety, so
we can reuse the thread safety comments from `Arc` here.

This is necessary because without this change, the Rust compiler will
assume that things are not thread safe even though they are.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/types.rs | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
index 29db59d6119a..9c8d94c04deb 100644
--- a/rust/kernel/types.rs
+++ b/rust/kernel/types.rs
@@ -321,6 +321,17 @@ pub struct ARef<T: AlwaysRefCounted> {
     _p: PhantomData<T>,
 }
 
+// SAFETY: It is safe to send `ARef<T>` to another thread when the underlying `T` is `Sync` because
+// it effectively means sharing `&T` (which is safe because `T` is `Sync`); additionally, it needs
+// `T` to be `Send` because any thread that has an `ARef<T>` may ultimately access `T` directly, for
+// example, when the reference count reaches zero and `T` is dropped.
+unsafe impl<T: AlwaysRefCounted + Sync + Send> Send for ARef<T> {}
+
+// SAFETY: It is safe to send `&ARef<T>` to another thread when the underlying `T` is `Sync` for the
+// same reason as above. `T` needs to be `Send` as well because a thread can clone an `&ARef<T>`
+// into an `ARef<T>`, which may lead to `T` being accessed by the same reasoning as above.
+unsafe impl<T: AlwaysRefCounted + Sync + Send> Sync for ARef<T> {}
+
 impl<T: AlwaysRefCounted> ARef<T> {
     /// Creates a new instance of [`ARef`].
     ///

base-commit: ac9a78681b921877518763ba0e89202254349d1b
-- 
2.40.1.606.ga4b1b128d6-goog

