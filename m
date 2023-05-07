Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFCCA6F99FB
	for <lists+linux-kernel@lfdr.de>; Sun,  7 May 2023 18:28:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231480AbjEGQ2B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 May 2023 12:28:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231245AbjEGQ16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 May 2023 12:27:58 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2F07A5FC;
        Sun,  7 May 2023 09:27:52 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id ffacd0b85a97d-3063208beedso3497951f8f.1;
        Sun, 07 May 2023 09:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683476871; x=1686068871;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LH7Gskf0JBlpJmh8+F9VpZ1h6y3N33yjdkZhVHwbcas=;
        b=n0WcNb6RrINFMqnVPb2zmYiu7XPmXKRLRfUTweUgs2tCCPq3TgZHo3HwjXzpEWgKH1
         MgtyN2XbKe890EIZJ9mDQ/k5im1rxH2X2PskXRJfIFA+iDo4/aBqRNEq8XeSa6V/Tzpk
         GgVFUmyx08KggByVpAA3ptvQ7s7c4+8DdKpheochEtKTyIFtOKwHWTFBNsJgTPVjR/8z
         ADWiimnekR4pQk30WlGy6rRQ3F++7IrtecmYp2ebw29IMt5f9n1TIZkz3AKfNFgJUWOs
         3tQ1YkURRn7QfUWyZIa2LaRGh+AgfwT3MPH8Aod2K+ygXrr06D15O/16s1aKdLwN0I3W
         Vtfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683476871; x=1686068871;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LH7Gskf0JBlpJmh8+F9VpZ1h6y3N33yjdkZhVHwbcas=;
        b=kiuBv0IqTph3LWBfDBUJu1w0vD68HLNEMEGBHSZQlbSS3y6VThkuUHz5en65s+KLHz
         xUn3XCfWSG8lVyos/xBnBbLLIIFxJkfmWt88J57JL/63K7yrJveLgo2+j2ZnXeRwtaM6
         q40I2uqqEiOPBmJkAhXpAdeCtB3Vl41X7X4waLEnJmFumSD5/nmlLrupV0EE5zPQ31it
         L6T57jLG26rtd8k+xR3CVnb/gYmap54R69cpNe0Xyu66VGY76uEbX+gdqCezYDYepQ1Y
         SN4LNkxjVyNm1kfOKmsxD7Ve87HhwDVguo5HRO3qYjF1FNjeSTjZJxpDga1bpyHg42xh
         wZZw==
X-Gm-Message-State: AC+VfDzXsEPuH13fwPIJeOP0m0OYU9YDL9BXa0B9Rlrjf+RG0SKPrKOP
        YJF17OgEt/Pk8vrOHh4MXQY=
X-Google-Smtp-Source: ACHHUZ5AY4yMv7lBXwF2AMsU1MfeUUj8HA/N9Y8FIQJdVsb6ddEsilpecArcuHegkFLe4ZTEWVS2Mw==
X-Received: by 2002:a5d:40c3:0:b0:306:2b2b:8c56 with SMTP id b3-20020a5d40c3000000b003062b2b8c56mr5306981wrq.37.1683476871003;
        Sun, 07 May 2023 09:27:51 -0700 (PDT)
Received: from localhost.localdomain ([2.222.93.88])
        by smtp.gmail.com with ESMTPSA id n3-20020a5d4843000000b003047d5b8817sm8695318wrs.80.2023.05.07.09.27.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 May 2023 09:27:50 -0700 (PDT)
From:   Ben Gooding <ben.gooding.dev@gmail.com>
To:     alice@ryhl.io
Cc:     alex.gaynor@gmail.com, ben.gooding.dev@gmail.com,
        benno.lossin@proton.me, bjorn3_gh@protonmail.com,
        boqun.feng@gmail.com, gary@garyguo.net,
        linux-kernel@vger.kernel.org, ojeda@kernel.org,
        rust-for-linux@vger.kernel.org, wedsonaf@gmail.com,
        yakoyoku@gmail.com
Subject: [PATCH] rust: lock: Reflow long documentation line
Date:   Sun,  7 May 2023 17:27:39 +0100
Message-Id: <20230507162739.17392-1-ben.gooding.dev@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <7f464c01-d4ec-d632-fa40-0c3f18c2ffca@ryhl.io>
References: <7f464c01-d4ec-d632-fa40-0c3f18c2ffca@ryhl.io>
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

Suggested-by: Alice Ryhl <alice@ryhl.io>
Signed-off-by: Ben Gooding <ben.gooding.dev@gmail.com>
---
 rust/kernel/sync/lock.rs | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/sync/lock.rs b/rust/kernel/sync/lock.rs
index 95466201dab7..04413f6f145a 100644
--- a/rust/kernel/sync/lock.rs
+++ b/rust/kernel/sync/lock.rs
@@ -72,8 +72,10 @@ pub unsafe trait Backend {
 
 /// A mutual exclusion primitive.
 ///
-/// Exposes one of the kernel locking primitives. Which one is exposed depends on the lock [backend](Backend)
-/// specified as the generic parameter `B`.
+/// Exposes one of the kernel locking primitives. Which one is exposed depends on the lock
+/// [backend] specified as the generic parameter `B`.
+/// 
+/// [backend]: Backend
 #[pin_data]
 pub struct Lock<T: ?Sized, B: Backend> {
     /// The kernel lock object.
-- 
2.34.1

