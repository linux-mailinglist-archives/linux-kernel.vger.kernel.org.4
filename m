Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4053C68E09F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 19:53:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232583AbjBGSw6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 13:52:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232361AbjBGSwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 13:52:51 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B251103;
        Tue,  7 Feb 2023 10:52:50 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id c2so17892199qtw.5;
        Tue, 07 Feb 2023 10:52:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pw0ByORIxbzjhrXTdLg80T0eGpn6Y+jK2lz5pJ++YH8=;
        b=ZncQL7xoNfDQKYP2yNCeYPlLtuGapA/miBtdGv+YudqBd6A4483uU9LQ9tZ7Z6MALU
         WdMoI7xGiho0iARaGqGVxHmQIcesZ59Y2/6KR572sn1DMC0CfV2MqOx5rN1c5zBCtyJ1
         dt3tEWWt5tht3s9NrenVZa/Y4XcPWOWTZKtSsfLVlzVzPyjD2OxC+TEzgqLgVqS2ZO7K
         nV27ZVwikFgP1d6l67GLr/UKOM/cU93+dU7luJ1MGhMvX01hv/BWabyWiTS4waYuThA+
         GzZxf2XjNpnO8ORApL/h1OsjWrTfp9ol35xjPhuIxTCJobkyNyTHzmsUugyROy4HsyIj
         qLWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pw0ByORIxbzjhrXTdLg80T0eGpn6Y+jK2lz5pJ++YH8=;
        b=3fQdLBFziCr6fxyviDPq7KLC/c0fhmLLhRvTz/6ujEzshmqatLKKavVWpafsOvg2IG
         B9+cTftS2iYcG4+HtP+4eRcJo8chEXjk1xtfctVAPznRXitTtKbw5ruz6MgsPMZ27uRk
         1YY0XApK+bys4BIsQfdlF7zLb7ef9Yjy5lJ1jovf+Zc+WYYYCFsI+9R11wYduqfEfUNp
         hiKuQMNWzBFUf+gcK1hWZaK+2ACKvNAUd7zmL2VIekpyNQBWFe3uiuL6hdu0IIhIzj7h
         VwDfceJg6Iu/5dMK0qJjp+RY6MhB+832/j6RMPtei6de0ktEZqObXtkP5PUyNhJR+h1x
         cpTw==
X-Gm-Message-State: AO0yUKUs8rXtY9agCrZEObIhfkTbeznsAoodHIZFvw6DvoKDaBkrNGWk
        1Us496UvPpoOAeh3N3I+EpcxgTrJQP4=
X-Google-Smtp-Source: AK7set+CfALORVXU2P4BIeSCVej6n+PHzACGFPleZxICuoyIdhEftiR2lBEGapJleGAMbQIgzOgrsw==
X-Received: by 2002:ac8:7fc2:0:b0:3ba:1360:ec0a with SMTP id b2-20020ac87fc2000000b003ba1360ec0amr7070190qtk.41.1675795969132;
        Tue, 07 Feb 2023 10:52:49 -0800 (PST)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id f9-20020ac84989000000b003b869f71eedsm9729924qtq.66.2023.02.07.10.52.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 10:52:48 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailauth.nyi.internal (Postfix) with ESMTP id 4022D27C0054;
        Tue,  7 Feb 2023 13:52:48 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Tue, 07 Feb 2023 13:52:48 -0500
X-ME-Sender: <xms:AJ7iY_nk_S9FixChLO9NteFEiAzPJamGcJBtrv8Y-VEgdbaWLSRp1w>
    <xme:AJ7iYy1QVNaEGvRFoIw6wnp12HAyQIN4curYxuMpL9abpTnz7_z-NPAqo1Bxzkhca
    On0N6oiTch68nceww>
X-ME-Received: <xmr:AJ7iY1rpyugx41U-I-Hkf0wK-WI46O27d11p8NJne-1gMes4F7q6Kz5Nf2w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudegkedgudduhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvfevufffkffojghfgggtgfesthekredtredtjeenucfhrhhomhepueho
    qhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtf
    frrghtthgvrhhnpeehffeiheehhfevhefhleefjedtiedtjefhveekfeejiedugeekkeeu
    uefhieevkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeeh
    tdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmse
    hfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:AJ7iY3mj59usEzwkmLbKf07rlDL_PPDKoNO-v7WoTt7HhnyMpvd3lw>
    <xmx:AJ7iY90UT5xG8OJURtcUYUZ5lFpsQuLBWcWmPv08aUO6FQ8icEnp-w>
    <xmx:AJ7iY2sMDf3K82L7K3wsPtRgvcNC4i983cORJZsPsvdB6jcAfwGUjg>
    <xmx:AJ7iY82VScQmvIeqPIRbqRFGuoa2E7VYBkK8QaalyJ3d8xhSkJrIIg>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Feb 2023 13:52:47 -0500 (EST)
From:   Boqun Feng <boqun.feng@gmail.com>
To:     linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
        Vincenzo Palazzo <vincenzopalazzodev@gmail.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?q?Sergio=20Gonz=C3=A1lez=20Collado?= 
        <sergio.collado@gmail.com>, Finn Behrens <fin@nyantec.com>
Subject: [PATCH v2 2/2] sample: rust: print: Add sampe code for Arc printing
Date:   Tue,  7 Feb 2023 10:52:16 -0800
Message-Id: <20230207185216.1314638-3-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230207185216.1314638-1-boqun.feng@gmail.com>
References: <20230207185216.1314638-1-boqun.feng@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Reviewed-by: Björn Roy Baron <bjorn3_gh@protonmail.com>
Reviewed-by: Finn Behrens <fin@nyantec.com>
Reviewed-by: Vincenzo Palazzo <vincenzopalazzodev@gmail.com>
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

