Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 026FF71857C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 17:02:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233769AbjEaPCo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 11:02:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233677AbjEaPCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 11:02:42 -0400
Received: from mail-ej1-x649.google.com (mail-ej1-x649.google.com [IPv6:2a00:1450:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24CAF123
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 08:02:31 -0700 (PDT)
Received: by mail-ej1-x649.google.com with SMTP id a640c23a62f3a-96fd3757c1dso580154266b.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 08:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685545349; x=1688137349;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VjkkPXwWP2UuAC8i0OxxIXvE50xM+SJ4TuQh4LuQSuA=;
        b=b9HP3fVC1WMLEISsNDvrmAx+7T6OCx606wh51FEYzDPSVAbudgUPILu4wPuhUmSsAj
         88aIsX+eUupN+Ztym2x/N0KNysr0nbAL9lK3BHICx7QsVQ/6Br2OqpqKa0O6/zXQteCG
         aJxkky9PCqkB6uHmZyY29AMStNAa62L34JltEfi5kSJHu7rGR3Gl5nV+Dr0RMmgPSEqV
         aR6fyBkkqAbBaWy1RiADSlAfOw7OPBdc5KiFCtrObXZcSTIfDsDM99ito93Tm+3YP0IJ
         En6qoIFZfB2w5hXi7viGmOgheLKG4sXaeBxtF9ByBdMfaAjej+owSATDIm16m5j03RfP
         6zIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685545349; x=1688137349;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VjkkPXwWP2UuAC8i0OxxIXvE50xM+SJ4TuQh4LuQSuA=;
        b=E3MCESR7Ij0CuOuOyonSUjo4miBi5K21Ig5+hVmIaRO6dbxNXsrol4S3vOkkEN7H+3
         3aiQxlfkjgOeB3NFz3T0dlSxpl3dMrAyvHaaZSSb930f8htxsznZhxvsrid6HSAXqZMb
         7ST2pjvi6bGgJ4+hEfcCymbe/8mNE6lDmUudVyLIRX8Un1kJTMmBpHLmQzx6MElwmCCk
         y865GZYyKWjTT140e0BS4k+C3sDlWTvHG4Mx8959qir/01GDGz3sxE+J9Ikm1a2kXUMb
         Lx8NCVqFLnjF5RFiWvaXMyHi1mTgMSssUgcK0E4OT9NNOmNSZr4TmHlYha71QU3nZnS+
         heMw==
X-Gm-Message-State: AC+VfDyKpZbr77VbjuosSJxM6Lk7y1wmDD9lnk+yYLPsCwkV6dCx9d0j
        bufPLqbyrqs36lHjGs/Jqg+quKBlEqKmffw=
X-Google-Smtp-Source: ACHHUZ42wsfRNkL/N1arfet+5Di2c/mNhloIBbuHgEuBaMc9ULTRP8O/zj0KwniRad+/E3n6OiJn4Zqy+whHr2U=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:6c8])
 (user=aliceryhl job=sendgmr) by 2002:a17:906:8a7b:b0:962:334b:ee1a with SMTP
 id hy27-20020a1709068a7b00b00962334bee1amr1499837ejc.1.1685545349753; Wed, 31
 May 2023 08:02:29 -0700 (PDT)
Date:   Wed, 31 May 2023 14:59:38 +0000
In-Reply-To: <20230531145939.3714886-1-aliceryhl@google.com>
Mime-Version: 1.0
References: <20230531145939.3714886-1-aliceryhl@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Message-ID: <20230531145939.3714886-4-aliceryhl@google.com>
Subject: [PATCH v3 3/4] rust: specify when `ARef` is thread safe
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

An `ARef` behaves just like the `Arc` when it comes to thread safety, so
we can reuse the thread safety comments from `Arc` here.

This is necessary because without this change, the Rust compiler will
assume that things are not thread safe even though they are.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Andreas Hindborg <a.hindborg@samsung.com>
Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Reviewed-by: Benno Lossin <benno.lossin@proton.me>
---
 rust/kernel/types.rs | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
index 29db59d6119a..1e5380b16ed5 100644
--- a/rust/kernel/types.rs
+++ b/rust/kernel/types.rs
@@ -321,6 +321,19 @@ pub struct ARef<T: AlwaysRefCounted> {
     _p: PhantomData<T>,
 }
 
+// SAFETY: It is safe to send `ARef<T>` to another thread when the underlying `T` is `Sync` because
+// it effectively means sharing `&T` (which is safe because `T` is `Sync`); additionally, it needs
+// `T` to be `Send` because any thread that has an `ARef<T>` may ultimately access `T` using a
+// mutable reference, for example, when the reference count reaches zero and `T` is dropped.
+unsafe impl<T: AlwaysRefCounted + Sync + Send> Send for ARef<T> {}
+
+// SAFETY: It is safe to send `&ARef<T>` to another thread when the underlying `T` is `Sync`
+// because it effectively means sharing `&T` (which is safe because `T` is `Sync`); additionally,
+// it needs `T` to be `Send` because any thread that has a `&ARef<T>` may clone it and get an
+// `ARef<T>` on that thread, so the thread may ultimately access `T` using a mutable reference, for
+// example, when the reference count reaches zero and `T` is dropped.
+unsafe impl<T: AlwaysRefCounted + Sync + Send> Sync for ARef<T> {}
+
 impl<T: AlwaysRefCounted> ARef<T> {
     /// Creates a new instance of [`ARef`].
     ///
-- 
2.41.0.rc0.172.g3f132b7071-goog

