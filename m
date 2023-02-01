Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 417256871D2
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 00:23:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231939AbjBAXW6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 18:22:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231897AbjBAXW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 18:22:56 -0500
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 482971BDC;
        Wed,  1 Feb 2023 15:22:55 -0800 (PST)
Received: by mail-qv1-xf34.google.com with SMTP id k18so27141qvm.7;
        Wed, 01 Feb 2023 15:22:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xDOpfFKpqkig/ifJO3DdK44tzsI39GfXAo3DZPsupvI=;
        b=SWIFInt+tnHdNOuNDsy1BmdUYNLVTjdcAJto1P0JfMykBg4bI8D7W4yZy00i0n3QXa
         JBfOskH/f31gPO6cNFvcqf+tBkaFPJYVi7wfEU3pbtdziSU++uBtuBWE92S3riwEDAd1
         VpOMQq21Z5UeO5g2jynQuBhCZNhOXBnvzYQroZtJBI8bfKy3Akv4JtqdUCO7i3zkdkAM
         JcviuUA6fPEYBJBkhnRpIHPfg3cwXqpQoJwIiiDibalvZWsQKHGVp7lrLKnBBrnhYT8Z
         EE67zWuUSL79pSt5lmytovjpoJFJXh/HU3aQ2fhHqFfq/Qg0y13TOAaiEDq3FB4Rf8et
         H+QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xDOpfFKpqkig/ifJO3DdK44tzsI39GfXAo3DZPsupvI=;
        b=fqpFzhAxybaN09pbv0syxdkp9OPhd6ofEOPri84W6ucaDfHum8497Kicakh0lINqUR
         5yL7VPrneDAcwc+PBs7aU7wO+j8/anFoFL3l566QBYnH1Z8JTDQvC5nTXxFaB8deUGUR
         UCIIpnfVnoTwJ+A4tyRw8hdmr5UsEmr/x0aC31ZtsEJtfiVmWniDCNnwkXs2jUehJRb8
         NkildCetlQKOBmGjyL0CzpO1Bv++7PT8G6rZ62HdQaqGiedQCPSgdiVJv5UtKh3Tm0VF
         HAsAiD/JGvYq6BoOC6OwfP55fsQQMuqKnO3+Qb1IrSCUuI3fVejRuNAZ4ys76EA4SiOV
         saoA==
X-Gm-Message-State: AO0yUKX/brJf1O2j5X86/1U+Gzx9CTCGYBXzTBkeNxOAyyqNtgSEqSq3
        XNMcjRKxwi2XqENUWY2HNdvX4PFHG6A=
X-Google-Smtp-Source: AK7set9a6IxO3IXNd54tsP2BmFYctJnxgkrmxnm4fG+vw1gzaPtFWoaaQhoRP8o0OPSgdQJfcqPFVg==
X-Received: by 2002:ad4:5009:0:b0:534:7371:ab01 with SMTP id s9-20020ad45009000000b005347371ab01mr6384503qvo.7.1675293774237;
        Wed, 01 Feb 2023 15:22:54 -0800 (PST)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id pi48-20020a05620a37b000b006e16dcf99c8sm13181950qkn.71.2023.02.01.15.22.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 15:22:53 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailauth.nyi.internal (Postfix) with ESMTP id D1FCB27C005A;
        Wed,  1 Feb 2023 18:22:52 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 01 Feb 2023 18:22:52 -0500
X-ME-Sender: <xms:TPTaY3xXB-HxQSgUahUQcOSAyJ3bUcC02MU5trXHF45yL41SJofAww>
    <xme:TPTaY_TD_95-vje3fqUoJRhEqq6RUbnRR-AD55MbIamGaCRtC_Ng_t9J_p0t2N8dp
    vfg9Kns41efeW_exw>
X-ME-Received: <xmr:TPTaYxX_Q_E2Q_nW9moXdnTRoDe1g7Riw9iumoT1_mg5GisV3Cm427Ha7fQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudefjedgudduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeehfedvtdekjedtleffkefgtdehueegfeffkeeggffhjefhudeikeejgeeh
    tedvfeenucffohhmrghinhepphhtrhdrrghsnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhs
    ohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnh
    hgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:TPTaYxjmX3MOrdV8ot4lWsBhS9Zpx95Xt9rnZQMEv1jeZ3SCzcYyMA>
    <xmx:TPTaY5BM8nLcU6fE6_aL2pk8CtORJSMquh7wcCD13RoKhPsy2PjLkg>
    <xmx:TPTaY6KVmpeQCYuTLFTfB-iS70QIG6pIen9K4o4bagXcvo54GuK0zA>
    <xmx:TPTaY94ixVV-p54I2waD4b-Biq6YjHov9CWNSwOwjxTt6tkDxFRPdQ>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Feb 2023 18:22:52 -0500 (EST)
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
Subject: [RFC 1/5] rust: sync: impl Display for {Unique,}Arc
Date:   Wed,  1 Feb 2023 15:22:40 -0800
Message-Id: <20230201232244.212908-2-boqun.feng@gmail.com>
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

This allows printing the inner data of `Arc` and its friends if the
inner data implements `Display`. It's useful for logging and debugging
purpose.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 rust/kernel/sync/arc.rs | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
index 519a6ec43644..fc680a4a795c 100644
--- a/rust/kernel/sync/arc.rs
+++ b/rust/kernel/sync/arc.rs
@@ -22,6 +22,7 @@ use crate::{
 };
 use alloc::boxed::Box;
 use core::{
+    fmt,
     marker::{PhantomData, Unsize},
     mem::{ManuallyDrop, MaybeUninit},
     ops::{Deref, DerefMut},
@@ -522,3 +523,15 @@ impl<T: ?Sized> DerefMut for UniqueArc<T> {
         unsafe { &mut self.inner.ptr.as_mut().data }
     }
 }
+
+impl<T: fmt::Display + ?Sized> fmt::Display for UniqueArc<T> {
+    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
+        fmt::Display::fmt(self.deref(), f)
+    }
+}
+
+impl<T: fmt::Display + ?Sized> fmt::Display for Arc<T> {
+    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
+        fmt::Display::fmt(self.deref(), f)
+    }
+}
-- 
2.39.1

