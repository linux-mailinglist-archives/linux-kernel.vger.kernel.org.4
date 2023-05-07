Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A3476F994A
	for <lists+linux-kernel@lfdr.de>; Sun,  7 May 2023 17:23:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231691AbjEGPXZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 May 2023 11:23:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231653AbjEGPXY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 May 2023 11:23:24 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A65C17FCD;
        Sun,  7 May 2023 08:23:16 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3f19afc4f60so23341445e9.1;
        Sun, 07 May 2023 08:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683472994; x=1686064994;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cXfYAxy/0WQK3eurmoC5L3aB81s98dVICzFWcsOt+GA=;
        b=opwmOyCf3zacpjaTp05ZgrNC6QDcPbiGf7IX0xqQX9eOnaeApS9sKjzDIuQBbTE6h6
         YupY3Mu69A/dY4z0ts4OSW2sCPKzM4w9fkS1NdIYmrYlVfq8wNzuHFWB9E37m1UzwB3+
         tvsv8do87qGhJNcKk2ii71nCmU+jFXcIP9TvyUxX+go03o4W0XG1jqQsNOK4BUfBy87v
         2FdEsnAyM7XcF49BJsiNVOp20RBLIXAy7CErnypx/LExlyZ8ebn+pQLhXDQGMORzToW2
         KmgS+m/KyaNMEOFsQIifgIdD7+X+bU+0d2ut4sq5RSV8lRQuqHZZjVg9Y2D55PnIt0W+
         tT8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683472994; x=1686064994;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cXfYAxy/0WQK3eurmoC5L3aB81s98dVICzFWcsOt+GA=;
        b=MiJxYKVYC9C9EBjMFNIWRmQ0rJUaxbYn4juDANk1yVxLWcsSJ5/3zAyWfdNeqaX3q7
         UNiAGiqQ/MV8wmjSGEGNqWIQK+gzG+Ovrp02VjAmHI6lW5+7DsT+AQCpg7eqsM5QjcOc
         80bA+/Ps9ZTKqwrChVVEfkfd3E9wl5+fX2ACfJB8iyIr0FF4oTJCOe66NNoG0wnBRQ8m
         cpb+GaB7T+oPF/y61fsB82qbGAl/pSCAswiHBCTYoFxfrbGG3IL0+9DPKH5m6syNzDcY
         HGArSYOCkcZjs87qRm2S4B5643xOhyUz9CPQnot7/N+N2es7Xs+qLFe5hr7MnwJqU6bv
         TKPw==
X-Gm-Message-State: AC+VfDyGp5s8rqBAhxCErsMknkxjt9HJEc+me+lHPaiQ83sAk9/M3fK5
        a89CZfo5H0WUSIuVEduJANA=
X-Google-Smtp-Source: ACHHUZ7z1wk89lMWxDlAcZxxE0xL7fz35swhns0FZt859CE35le8Qm8pASHhZskAqXlS0KR4Ew/cXg==
X-Received: by 2002:a1c:720f:0:b0:3f4:16bc:bd1c with SMTP id n15-20020a1c720f000000b003f416bcbd1cmr3169835wmc.3.1683472994534;
        Sun, 07 May 2023 08:23:14 -0700 (PDT)
Received: from localhost.localdomain ([2.222.93.88])
        by smtp.gmail.com with ESMTPSA id c17-20020adffb11000000b003075428aad5sm8231630wrr.29.2023.05.07.08.23.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 May 2023 08:23:14 -0700 (PDT)
From:   Ben Gooding <ben.gooding.dev@gmail.com>
Cc:     ben.gooding.dev@gmail.com, Benno Lossin <benno.lossin@proton.me>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] rust: lock: Add intra-doc links to the Backend trait
Date:   Sun,  7 May 2023 16:22:29 +0100
Message-Id: <20230507152232.803-1-ben.gooding.dev@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Also fix a minor typo in one of the comments

Suggested-by: Benno Lossin <benno.lossin@proton.me>
Link: https://lore.kernel.org/rust-for-linux/94625fe6-b87a-a8f0-5b2a-a8152d5f7436@proton.me/
Link: https://github.com/Rust-for-Linux/linux/issues/1001
Signed-off-by: Ben Gooding <ben.gooding.dev@gmail.com>
---
 rust/kernel/sync/lock.rs | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/rust/kernel/sync/lock.rs b/rust/kernel/sync/lock.rs
index a2216325632d..95466201dab7 100644
--- a/rust/kernel/sync/lock.rs
+++ b/rust/kernel/sync/lock.rs
@@ -72,7 +72,7 @@ pub unsafe trait Backend {
 
 /// A mutual exclusion primitive.
 ///
-/// Exposes one of the kernel locking primitives. Which one is exposed depends on the lock backend
+/// Exposes one of the kernel locking primitives. Which one is exposed depends on the lock [backend](Backend)
 /// specified as the generic parameter `B`.
 #[pin_data]
 pub struct Lock<T: ?Sized, B: Backend> {
@@ -90,7 +90,7 @@ pub struct Lock<T: ?Sized, B: Backend> {
     pub(crate) data: UnsafeCell<T>,
 }
 
-// SAFETY: `Lock` can be transferred across thread boundaries iff the data it protects can.
+// SAFETY: `Lock` can be transferred across thread boundaries if the data it protects can.
 unsafe impl<T: ?Sized + Send, B: Backend> Send for Lock<T, B> {}
 
 // SAFETY: `Lock` serialises the interior mutability it provides, so it is `Sync` as long as the
@@ -126,7 +126,7 @@ impl<T: ?Sized, B: Backend> Lock<T, B> {
 
 /// A lock guard.
 ///
-/// Allows mutual exclusion primitives that implement the `Backend` trait to automatically unlock
+/// Allows mutual exclusion primitives that implement the [`Backend`] trait to automatically unlock
 /// when a guard goes out of scope. It also provides a safe and convenient way to access the data
 /// protected by the lock.
 #[must_use = "the lock unlocks immediately when the guard is unused"]
-- 
2.34.1

