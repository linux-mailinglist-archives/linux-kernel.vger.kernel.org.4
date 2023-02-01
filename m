Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8DFC6871D1
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 00:23:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231979AbjBAXXB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 18:23:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231921AbjBAXW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 18:22:57 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 000FC5BAF;
        Wed,  1 Feb 2023 15:22:55 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id f10so219456qtv.1;
        Wed, 01 Feb 2023 15:22:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kSFjnS2TzF6MjNVz0CrkTRdBZTFROoWEM1aHOLGjobA=;
        b=SwqscVMHJz5NcEj21qpRyEo1QIbrC+LPEotlDBBxSqoKopoc8AzZXPFRFhZe5U8iqj
         wCL4hHbdf45/O4cXuJ+klxnSwp/LLlLtY5IqX2JNhqLnJkBnr5BBIGWXUonK+kBiL/JT
         Ur0cJS5JPDr+rVZ6ZqmXJhcua1Ts57CPpyJYqYflbyOpqPU61IEl2ubn3zmy471D5iiu
         p+/LsRcdE9tKEFkD4VUZ5LW4tlM8QM7WFON4lJJFL84x56tQJ+rQnSbmBFeyo7vhhN/P
         aE4ipQyBqkY51MfK6KdoxWkkyfCNjcMn284BYBGk5bxC3ZCN7ULsIMV5NzJWUWa66Njh
         IpFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kSFjnS2TzF6MjNVz0CrkTRdBZTFROoWEM1aHOLGjobA=;
        b=tT4kk90pOfGQdxftNyUV7wyZZLiLaeBOXpuq97F9AYNSe0o32SG7UDA9jp0WrHVcQa
         FJPHvxZYFT1+sehcvz3nYf/rU3+wewqcH35Zl/jdOtqU/BP6Y/894lqyQt39LGqqYA+F
         0QwQtARwMxnVY9B6BA7kwW+WuZa0k4KqsfbsqQL6l5Kju65FYGf0nvmvjkHIPubb8Nde
         sqL6yyCGuMuDCfthPk3JL5ovSj98P/MD+OACJQ9SOp83IoVbTlORzNOBmY9lP1IWcFCb
         y5kSOLizUE6SXoXOqcmwOhHvSWZf5CWcwDd5uEUpPPobc8B6BIFeAxzVp6FfqPK5nOOu
         QSvQ==
X-Gm-Message-State: AO0yUKV4ese1lD+1WrY12y3DLLRQuPMhVl+RA62bj0mWeDYeyzKrt1zu
        1BMTahtqfuL7J6q9Q7+5hzM=
X-Google-Smtp-Source: AK7set/4+AitiQHzdVQUCv4bLv3awO1NHV/wYA7hZ4FtS4ATErjNK3bqBiPZH68Xu5XpClclB1byig==
X-Received: by 2002:ac8:5e4f:0:b0:3b9:b761:b0a0 with SMTP id i15-20020ac85e4f000000b003b9b761b0a0mr8546936qtx.12.1675293775646;
        Wed, 01 Feb 2023 15:22:55 -0800 (PST)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id v3-20020ac87283000000b003b62e9c82ebsm12661001qto.48.2023.02.01.15.22.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 15:22:54 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailauth.nyi.internal (Postfix) with ESMTP id 4043827C0054;
        Wed,  1 Feb 2023 18:22:54 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Wed, 01 Feb 2023 18:22:54 -0500
X-ME-Sender: <xms:TvTaYx6wCHDq0FGIoF_nYHDz1wTtYqmWC3JnbOtjjatweFEwmtqVgQ>
    <xme:TvTaY-4MjCkxNWtfCZql1VCYPATIlRJO-K_xzQkJbIyhkRMmqsnogMJ63bRLmR-TK
    BBKVks7LqXDjgE4-Q>
X-ME-Received: <xmr:TvTaY4etB8uxyzTXxv2HGhEzlvtvk0g54SX0XwTLTa5QTM4rk1MXHE73lUs>
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
X-ME-Proxy: <xmx:TvTaY6KYg6eeNw9LIU5F9j9J72upzHtREq3pBkDrC38nPPZbjw_IHA>
    <xmx:TvTaY1JNxfu9n01pACEn16KMJarNgH333GqjmH7NK9LWrG9VvxdcpQ>
    <xmx:TvTaYzw0-FoMReYZPmPA0_k940Y_iN40TBblsgNbW6ds5kzIEP_CjA>
    <xmx:TvTaYyDYQdGMgEDr7MpZENE8GQraYN40xVSVlpwf6bJww5hPBUGcfg>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Feb 2023 18:22:53 -0500 (EST)
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
Subject: [RFC 2/5] rust: sync: Arc: Introduces ArcInner::count()
Date:   Wed,  1 Feb 2023 15:22:41 -0800
Message-Id: <20230201232244.212908-3-boqun.feng@gmail.com>
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

This allows reading the current count of a refcount in an `ArcInner`.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 rust/helpers.c          | 6 ++++++
 rust/kernel/sync/arc.rs | 9 +++++++++
 2 files changed, 15 insertions(+)

diff --git a/rust/helpers.c b/rust/helpers.c
index 09a4d93f9d62..afc5f1a39fef 100644
--- a/rust/helpers.c
+++ b/rust/helpers.c
@@ -46,6 +46,12 @@ bool rust_helper_refcount_dec_and_test(refcount_t *r)
 }
 EXPORT_SYMBOL_GPL(rust_helper_refcount_dec_and_test);
 
+unsigned int rust_helper_refcount_read(refcount_t *r)
+{
+	return refcount_read(r);
+}
+EXPORT_SYMBOL_GPL(rust_helper_refcount_read);
+
 /*
  * We use `bindgen`'s `--size_t-is-usize` option to bind the C `size_t` type
  * as the Rust `usize` type, so we can use it in contexts where Rust
diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
index fc680a4a795c..fbfceaa3096e 100644
--- a/rust/kernel/sync/arc.rs
+++ b/rust/kernel/sync/arc.rs
@@ -127,6 +127,15 @@ struct ArcInner<T: ?Sized> {
     data: T,
 }
 
+impl<T: ?Sized> ArcInner<T> {
+    /// Returns the current reference count of [`ArcInner`].
+    fn count(&self) -> u32 {
+        // SAFETY: `self.refcount.get()` is always a valid pointer, and `refcount_read()` is a
+        // normal atomic read (i.e. no data race) only requiring on the address is valid.
+        unsafe { bindings::refcount_read(self.refcount.get()) }
+    }
+}
+
 // This is to allow [`Arc`] (and variants) to be used as the type of `self`.
 impl<T: ?Sized> core::ops::Receiver for Arc<T> {}
 
-- 
2.39.1

