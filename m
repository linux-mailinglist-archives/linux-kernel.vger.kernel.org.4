Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A0936FCF65
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 22:24:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234838AbjEIUYh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 16:24:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbjEIUYg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 16:24:36 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BF0340C2;
        Tue,  9 May 2023 13:24:34 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-3078fa679a7so3134194f8f.3;
        Tue, 09 May 2023 13:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683663873; x=1686255873;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+fA8ozPK1R+gWSVuxj7Oooge25CINHzv42GXaEYpyEU=;
        b=NxSi6yL1CDcUwPBB94+pd5DZhAra6avgmwN+C3k7c+U2jJfUkmL0b7hUufXqCK9Ywi
         0aIqSEC8jKkZb2IHnaPkSrMcWJJ7/jnx+S2M44HNP7FJCj1cRggeLAO6ZMRO2WCX9Vc1
         MmCH7YikUJcY/4gjomhr32NMY7DF3XLLEAFV8tbQjSP7vrnjr+0htuXOXr595E2Mu2RX
         cUaDYaxwrAvVHg7OSjHYpsoTBpFoAhEApUekxSj9L/1y5M1oTOUs6EtlPmXrBKG+JxLb
         CNOJlrnWLYQLR0MB9l1jf3D55mEBHZs3vDjTZovDczSIf5S9eSLb3xjZdesWWNdLDJU9
         JOhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683663873; x=1686255873;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+fA8ozPK1R+gWSVuxj7Oooge25CINHzv42GXaEYpyEU=;
        b=QmQOOLHuyxgMrNtO/zjhGwng0kFi7HwyqbLn2QtvpT+NPe899x/LFhr/D2o9HcspLF
         sdvDWbeu3Pvn+kxeD1GN6+yCBzp3VNqdWqTyof9VYUGlSExdt3lcsKAt9Jpt5xEo1nqw
         69o6tKzmrWNx+hhRfkqcAnGLazpsfPM+RVbWWu36f2+teu5XeYuFZcoobeDMsf1G7pkn
         BWoeQZ9EXqsPQSEaWtUea5Hz/jJUDbak4wxWa2Iz+SFyVqfdguX5EE30nFAMHthdoQiO
         TNAanV+hA3JdcPRPs9vOOKhAnGCcBFKOaL9JSKi2BmHBsT38GIPaML9CnJyP3jrtgZtN
         IR/A==
X-Gm-Message-State: AC+VfDzo2n8Ame8PbJ/udTNBEQh1rJdFp0Tr+j/ycNbTh/e4/o53S1Tp
        76/oNsnQWu/IPOhjpmdA758=
X-Google-Smtp-Source: ACHHUZ7zw4C5PvKOGNFMk0W4TGh29ZhzgbZPSQDFCJmjuhxc6moBgDBqhkC3uyowg0x98zUWB04VrA==
X-Received: by 2002:adf:ef4a:0:b0:306:44a9:76a0 with SMTP id c10-20020adfef4a000000b0030644a976a0mr11768165wrp.9.1683663872870;
        Tue, 09 May 2023 13:24:32 -0700 (PDT)
Received: from localhost.localdomain ([2.222.93.88])
        by smtp.gmail.com with ESMTPSA id d18-20020adfe852000000b002fe13ec49fasm15196126wrn.98.2023.05.09.13.24.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 13:24:32 -0700 (PDT)
From:   Ben Gooding <ben.gooding.dev@gmail.com>
To:     miguel.ojeda.sandonis@gmail.com
Cc:     alex.gaynor@gmail.com, ben.gooding.dev@gmail.com,
        benno.lossin@proton.me, bjorn3_gh@protonmail.com,
        boqun.feng@gmail.com, gary@garyguo.net,
        linux-kernel@vger.kernel.org, ojeda@kernel.org,
        rust-for-linux@vger.kernel.org, wedsonaf@gmail.com,
        yakoyoku@gmail.com
Subject: [PATCH v2] rust: lock: Add intra-doc links to the Backend trait
Date:   Tue,  9 May 2023 21:23:14 +0100
Message-Id: <20230509202314.8248-1-ben.gooding.dev@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CANiq72n-swO1L1zsPNDz=ZMMm=Ox5MOJHzXBbxgX0f_vWFWDmg@mail.gmail.com>
References: <CANiq72n-swO1L1zsPNDz=ZMMm=Ox5MOJHzXBbxgX0f_vWFWDmg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing intra-doc links to the Backend trait to make navigating the
documentation easier.

Suggested-by: Benno Lossin <benno.lossin@proton.me>
Link: https://lore.kernel.org/rust-for-linux/94625fe6-b87a-a8f0-5b2a-a8152d5f7436@proton.me/
Link: https://github.com/Rust-for-Linux/linux/issues/1001
Signed-off-by: Ben Gooding <ben.gooding.dev@gmail.com>
---
 rust/kernel/sync/lock.rs | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/rust/kernel/sync/lock.rs b/rust/kernel/sync/lock.rs
index a2216325632d..05ac8107ff3c 100644
--- a/rust/kernel/sync/lock.rs
+++ b/rust/kernel/sync/lock.rs
@@ -72,8 +72,8 @@ pub unsafe trait Backend {
 
 /// A mutual exclusion primitive.
 ///
-/// Exposes one of the kernel locking primitives. Which one is exposed depends on the lock backend
-/// specified as the generic parameter `B`.
+/// Exposes one of the kernel locking primitives. Which one is exposed depends on the lock
+/// [`Backend`] specified as the generic parameter `B`.
 #[pin_data]
 pub struct Lock<T: ?Sized, B: Backend> {
     /// The kernel lock object.
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

