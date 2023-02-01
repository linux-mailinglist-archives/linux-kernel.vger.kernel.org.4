Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D5526871D4
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 00:23:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231509AbjBAXXJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 18:23:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231970AbjBAXXA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 18:23:00 -0500
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AA9510E8;
        Wed,  1 Feb 2023 15:22:59 -0800 (PST)
Received: by mail-qt1-x82d.google.com with SMTP id bb40so210851qtb.2;
        Wed, 01 Feb 2023 15:22:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RJ2eqJLEVXk0Nl1is9sUWLnCG7hj77zSsF65ucYjqnM=;
        b=i4yh+W+BrM8RY8XP1P/LnT/bYfNWNsm8jzEkujYQ5E28NinCeb/zJ33eelJMgMCCja
         zoXTfnMmpxYc2/lU8Iv2RVB1Xc3XegWyc+QtaOaVyKNbLwPkWKiO3ga41LQbfKh/zhy5
         cYLSKjDhX1fgFTcGU5RSnCvlDfPgd/UO+P8KW0Z/S4lnnGXLmDV7EeckFig4+SWyBbwa
         pMRa7j3i1/fwL0wRwbdyA7DzNp6KVGoGoALEgLhEtuj1Iu1C8tSWTmhGyVO9/SW387w6
         EEI/dvZnSsmgJZZJBK6wsx0A5p8lpEdGjT7OpwVMtElTIkQuwH6cXAU7YCe/ERlXv6WQ
         rO3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RJ2eqJLEVXk0Nl1is9sUWLnCG7hj77zSsF65ucYjqnM=;
        b=xe5kuZKzcWYBGhDr4gjDJcdMUBnA2nl0RmcF4AvKnKcW3sBSaG30Bc3cHSoa0Wu1j1
         tcbnvmly6Q1qOvV9UxXgyzqXrXuG/G10uG8xzo2q7n5m3BNL/5Rakq3t5nfVRN6if5dQ
         +28qR5w4abUdy4vqIRVLWhlmoSiyariZyz61SgidaUqFHJ7BBbJ6U130ngC2CigTyXzC
         du2PGTSRQH4keJRjR2TOE79b0GP9AbUVP6usjeDqNM0pEyDeX+eWrejgOoohOw50oh4e
         tTflRqAWjsmVSroVhyipzwCjkak/iNP90A4BPn4HNHBPrUOO6Dad7RXWhbwWKp/LcGuL
         iC1A==
X-Gm-Message-State: AO0yUKVhglYOGHIZPXPrjdVMXGUOaM41jVIDtL5+a3Al9tREKPb7HM+y
        0F2SFVqrEET5Ue6DnNrBLn21rXW2vCk=
X-Google-Smtp-Source: AK7set8MH15M8ebrTvc95LvO8zsJP+EmB0ENiE3zoR7Td84Jayz3huuk8xDs0cpChxcOfs/NubPEsQ==
X-Received: by 2002:a05:622a:152:b0:3b8:6bc1:155b with SMTP id v18-20020a05622a015200b003b86bc1155bmr8312505qtw.45.1675293778224;
        Wed, 01 Feb 2023 15:22:58 -0800 (PST)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id o2-20020a375a02000000b007055dce4cecsm13076809qkb.97.2023.02.01.15.22.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 15:22:57 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id 1383A27C0054;
        Wed,  1 Feb 2023 18:22:57 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Wed, 01 Feb 2023 18:22:57 -0500
X-ME-Sender: <xms:UPTaY6yb3NAL2cABcgH4xxLlBuLBXXeVFMtldJ4Okf6ygAHEo7Lt4Q>
    <xme:UPTaY2TsUBTbKRcoHI3PuqcC0FUVxA7EoVTp8zoKpyeh8DmslxnK73smMOJgUHvSM
    SKyBwIQ5r6sfwEUiQ>
X-ME-Received: <xmr:UPTaY8XWZvYex_tdzx6r7jSE4XAvyskHaENRbUjXT2evHr-mTFo1Kd0h4Ms>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudefjedgudduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeegleejiedthedvheeggfejveefjeejkefgveffieeujefhueeigfegueeh
    geeggfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvg
X-ME-Proxy: <xmx:UPTaYwjcPWfbvGfylH7BxbidBfZp1s28ICA2jDaofs_BLy3neqz4VQ>
    <xmx:UPTaY8CjqYyc29DSpMWDjPNKh_0jAbe9niTEiYBCmpeMh23nrZSIDw>
    <xmx:UPTaYxLVP0PJYCUKE_p86YaJroTPdornsJYf6Ymp79MMRzEUyTMebQ>
    <xmx:UfTaYw6mwM2mOOqcg48B9kU92gZNb_UuAnOlNA7iDo9B-1srjfE6Lg>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Feb 2023 18:22:56 -0500 (EST)
From:   Boqun Feng <boqun.feng@gmail.com>
To:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
        Vincenzo Palazzo <vincenzopalazzodev@gmail.com>
Subject: [RFC 4/5] rust: sync: impl Debug for {Unique,}Arc
Date:   Wed,  1 Feb 2023 15:22:43 -0800
Message-Id: <20230201232244.212908-5-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230201232244.212908-1-boqun.feng@gmail.com>
References: <20230201232244.212908-1-boqun.feng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows printing macros to print the data and the refcount nubmer
of these struct for debugging purposes.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 rust/kernel/sync/arc.rs | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
index 4d8de20c996f..f143d8305c36 100644
--- a/rust/kernel/sync/arc.rs
+++ b/rust/kernel/sync/arc.rs
@@ -474,6 +474,7 @@ impl<T: ?Sized> Deref for ArcBorrow<'_, T> {
 ///
 /// # test().unwrap();
 /// ```
+#[derive(Debug)]
 pub struct UniqueArc<T: ?Sized> {
     inner: Arc<T>,
 }
@@ -545,3 +546,15 @@ impl<T: fmt::Display + ?Sized> fmt::Display for Arc<T> {
         fmt::Display::fmt(self.deref(), f)
     }
 }
+
+impl<T: fmt::Debug + ?Sized> fmt::Debug for Arc<T> {
+    /// Formats debug output for [`Arc`].
+    ///
+    /// Refcount is also printed for debugging purpose.
+    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
+        f.debug_struct("Arc")
+            .field("refcount", &self.get_inner().count())
+            .field("data", &self.deref())
+            .finish()
+    }
+}
-- 
2.39.1

