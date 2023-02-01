Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D89096871D5
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 00:23:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230515AbjBAXXM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 18:23:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232001AbjBAXXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 18:23:02 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A927A264;
        Wed,  1 Feb 2023 15:23:00 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id m12so201226qth.4;
        Wed, 01 Feb 2023 15:23:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WRf7FsW0svSQ5uvgmd0AHIX9qix6pe5dIuAX0+vgnjk=;
        b=AaGH4xIRJHiGzFMV++RFKatLGmRKIlREolVmZNjG58XdbhhZh+dfTsMyJYEO+70aem
         tBqEufwqM5laAYG07ZQPu8n6RGmg+qrsVt5Zqo6b3ISlGXUwbys8dTWui33h1xrvKKA5
         n1CihKRhSpTe+48nBn480C5vwmB2HicalOCh4HRM7mt6aqy+/iCOMgYHhHUIr5HHjlb+
         RTvpnbVpRzvWisvXms2l3y4e2SiNqRVZuutfDxnXhU20zU+YdCNjwQK+lRq6PAmCYORR
         GUZoSPcR+/cRSEgsWhh9yJQuWrTv2e0f9ucLgKuoOFB0FpBtRudXBfgQgpQfmUXiFefQ
         5bBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WRf7FsW0svSQ5uvgmd0AHIX9qix6pe5dIuAX0+vgnjk=;
        b=U37R2xk4+D4anO1F0nsjAloxJMblkiq7mMafhdrkrMXPRp67OS6Cx4Z8iRn1u3d1v/
         C1JxTnnHxqBHge2pcXJaYUHu73iCYL/LHhaIIXQHR2o2+ZpD4YeepVVRnraG4HO1ZKK8
         y8XTmYiYNl/a5Yssk0rVk7w5Aycf3qPMTb/Gvrot9qY/qn5WpAU9jTqLvR3EQYoUCB8Z
         btVvkCRYCZzUd77VsM3IAxtDUl4VYLOqIzcbBlAADbOqSdu1b76LGa9tY15pFWrZtE7L
         3I3S0ECWgUj3VU3H51S/Xj/fgjOWfN/o9KGH3MG7KkXo40rJhrxCfJlfCwCWCcPtscr6
         Y2WA==
X-Gm-Message-State: AO0yUKXTNLQM17qKt4uRunEa3KHfc/k4efigedRgZTSKtg2lJkHBENFd
        EK2FRHa8Y7uJzoM2jpxu80U=
X-Google-Smtp-Source: AK7set8a4O590xcb1r76E6BdTkcepn8WXa7kzVn5DCamhrt0fB+pXN3hlNimrLvuOLFWYKwV+G0Z+Q==
X-Received: by 2002:ac8:5886:0:b0:3b9:b297:5ec5 with SMTP id t6-20020ac85886000000b003b9b2975ec5mr7535406qta.13.1675293779687;
        Wed, 01 Feb 2023 15:22:59 -0800 (PST)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id s39-20020a05622a1aa700b003a7e38055c9sm12735406qtc.63.2023.02.01.15.22.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 15:22:58 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailauth.nyi.internal (Postfix) with ESMTP id 71F4527C0054;
        Wed,  1 Feb 2023 18:22:58 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Wed, 01 Feb 2023 18:22:58 -0500
X-ME-Sender: <xms:UvTaY-AnHLgtb4I40VMzL9cSsKBUaYVsDrybfHp_MjqEaari3wEgug>
    <xme:UvTaY4hWRvoFfYkqdnThqUilTxrXyJWR4QzO6JE2S0N2YRVEfJCixxv66cpz4hBhQ
    y33a5KjrutI6398NQ>
X-ME-Received: <xmr:UvTaYxlgcW4XaiKaGmAptmrIXpURDTndFNdK1xwNGUuoSIb3mw_nV4Vk_FM>
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
X-ME-Proxy: <xmx:UvTaY8zMi2zYNBIfZSv25qmIz8XfGUIKhg5eqvp5Or43Oq9zAeLuNQ>
    <xmx:UvTaYzQ_2cHwEKVNwA8oxxtDyTuqsFbCu51kTuBO_pvB1BxuBiDpLg>
    <xmx:UvTaY3Y9H5XPJgAYUTXRCLeo7vSIYAmNVZVcXshqNfeOVwDXyf_bSQ>
    <xmx:UvTaY4IGnp6pA3NG7yqSPzTVgAOBFkuyylu8H8s1rNiK2-deCp0Alw>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Feb 2023 18:22:57 -0500 (EST)
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
Subject: [RFC 5/5] sample: rust: print: Add sampe code for Arc printing
Date:   Wed,  1 Feb 2023 15:22:44 -0800
Message-Id: <20230201232244.212908-6-boqun.feng@gmail.com>
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

This both demonstrates the usage of different print format in Rust and
serves as a selftest for the `Display` and `Debug` implementation of
`Arc` and its friends.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 samples/rust/rust_print.rs | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/samples/rust/rust_print.rs b/samples/rust/rust_print.rs
index 8b39d9cef6d1..165a8d7b1c07 100644
--- a/samples/rust/rust_print.rs
+++ b/samples/rust/rust_print.rs
@@ -15,6 +15,30 @@ module! {
 
 struct RustPrint;
 
+fn arc_print() -> Result {
+    use kernel::sync::*;
+
+    let a = Arc::try_new(1)?;
+    let b = UniqueArc::try_new("hello, world")?;
+
+    // Prints the value of data in `a`.
+    pr_info!("{}", a);
+
+    // Uses ":?" to print debug fmt of `b`.
+    pr_info!("{:?}", b);
+
+    let a: Arc<&str> = b.into();
+    let c = a.clone();
+
+    // Uses `dbg` to print, will move `c`.
+    dbg!(c);
+
+    // Prints debug fmt with pretty-print "#" and number-in-hex "x".
+    pr_info!("{:#x?}", a);
+
+    Ok(())
+}
+
 impl kernel::Module for RustPrint {
     fn init(_module: &'static ThisModule) -> Result<Self> {
         pr_info!("Rust printing macros sample (init)\n");
@@ -43,6 +67,8 @@ impl kernel::Module for RustPrint {
         pr_cont!(" is {}", "continued");
         pr_cont!(" with {}\n", "args");
 
+        arc_print()?;
+
         Ok(RustPrint)
     }
 }
-- 
2.39.1

