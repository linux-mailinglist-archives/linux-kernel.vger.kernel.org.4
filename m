Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D93BB6F43FA
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 14:40:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234150AbjEBMkw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 08:40:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233721AbjEBMku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 08:40:50 -0400
Received: from mail-ed1-x54a.google.com (mail-ed1-x54a.google.com [IPv6:2a00:1450:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 772DD59D0
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 05:40:47 -0700 (PDT)
Received: by mail-ed1-x54a.google.com with SMTP id 4fb4d7f45d1cf-50bcaaeaec0so1780066a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 May 2023 05:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683031246; x=1685623246;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ADtw/qW1A9BDeVMPTl0uodglbiJnCrGJeTfJlSlwBKg=;
        b=lRfYJWOz4yXMl4kx4LfEGKhFornexgFZ/Pzr37hrHOqVYHHpYkdPbpSnnCMSkD7gE9
         tNNzh3nS+kfLmd5nCFeXPqcvbh5ujRqoww7VqTHgr6zPziQA2Lw+YEw5Qb7sdjVurQok
         o5lHwpagAes7lc7Rpz3w1bCyXkg+VC1sj2qLGS6PMJXio9kkOFIqwBlRyy/0EIe0SGZ0
         3UiLeNvXApuYs9vCwKwPyVJkGkI3qfl7yx3aC6ihkrqR7n2eEgqgyXQm5qAvoanfUkvG
         cCNZ4EQpl0aHc6TP7bgtLHeuK02F7M9uZLmnaDPV4GegmHN3m2CGIctOY00bdWgTSRIp
         4/Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683031246; x=1685623246;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ADtw/qW1A9BDeVMPTl0uodglbiJnCrGJeTfJlSlwBKg=;
        b=R5Nlal06kl+8glnNlslbCLc2H1yyONKNrl3QWS2QkshWP2AySB/FQp89ZHoAWm8pg9
         Js0ArDsrr1VoiO8rPprzI5QxUkbuRktXX3229m5XGL3B86yWec6XwqBp36i9JakCzxJc
         ism1ZXMch/Bdgm28rjgQrCE8woVb2mbJpbf8p2+flBXbVcqRiVxB2L0gLHi7saoNFp+/
         8k0Ijz//Obpi+J0i/W5s3SKb4isuDfB4aT+TecHY7Q+gZHIy0ue/x7ty6y0fOBp590CW
         chY9oJSO9WnwzPTrCdtEaHyzB7Qr+9MYFS5lsauw75o/itCQsOoBefRUT6fw+vlnQRU8
         ipjg==
X-Gm-Message-State: AC+VfDwy87xbqnv8/kkT+YPjgGTEDrbBuXXfvX6QlMG/LsRMTgzADYEC
        p5Dda0XNNw9x5yGUdv1iVy+YZwMacesgOAY=
X-Google-Smtp-Source: ACHHUZ4PGt9JNY1496rQhEH+WLmSav3+qf88yqqFPW52fA2YiYcRFGcqDl4OEBgAI76aE3ZWAWeGyNcuQPShBzg=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:6c8])
 (user=aliceryhl job=sendgmr) by 2002:a50:9fe3:0:b0:50b:c83b:22d8 with SMTP id
 c90-20020a509fe3000000b0050bc83b22d8mr2063829edf.3.1683031242984; Tue, 02 May
 2023 05:40:42 -0700 (PDT)
Date:   Tue,  2 May 2023 12:40:15 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Message-ID: <20230502124015.356001-1-aliceryhl@google.com>
Subject: [PATCH] rust: error: allow specifying error type on `Result`
From:   Alice Ryhl <aliceryhl@google.com>
To:     Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>
Cc:     Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        "=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?=" <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Alice Ryhl <aliceryhl@google.com>
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

Currently, if the `kernel::error::Result` type is in scope (which is
often is, since it's in the kernel's prelude), you cannot write
`Result<T, SomeOtherErrorType>` when you want to use a different error
type than `kernel::error::Error`.

To solve this we change the error type from being hard-coded to just
being a default generic parameter. This still lets you write `Result<T>`
when you just want to use the `Error` error type, but also lets you
write `Result<T, SomeOtherErrorType>` when necessary.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/error.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/kernel/error.rs b/rust/kernel/error.rs
index 5f4114b30b94..01dd4d2f63d2 100644
--- a/rust/kernel/error.rs
+++ b/rust/kernel/error.rs
@@ -177,7 +177,7 @@ impl From<core::convert::Infallible> for Error {
 /// Note that even if a function does not return anything when it succeeds,
 /// it should still be modeled as returning a `Result` rather than
 /// just an [`Error`].
-pub type Result<T = ()> = core::result::Result<T, Error>;
+pub type Result<T = (), E = Error> = core::result::Result<T, E>;
 
 /// Converts an integer as returned by a C kernel function to an error if it's negative, and
 /// `Ok(())` otherwise.

base-commit: ea76e08f4d901a450619831a255e9e0a4c0ed162
-- 
2.40.1.495.gc816e09b53d-goog

