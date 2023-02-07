Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DC8C68E09E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 19:52:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231225AbjBGSwx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 13:52:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232212AbjBGSwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 13:52:51 -0500
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2CF49EF0;
        Tue,  7 Feb 2023 10:52:48 -0800 (PST)
Received: by mail-qv1-xf29.google.com with SMTP id k28so9724401qve.5;
        Tue, 07 Feb 2023 10:52:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wmko9U6xz9AxcE4cRj9bysFLw2CXZVZtRuLkE86PSJA=;
        b=kNZGlZmQpFMwNMGoZy2/mcgEFIa+lvEq0MYcXzAQK3qX+HTN5H4fwMzEe81b5O880H
         D22mUtuh3l92jbls5hULW1+M4F1Rqfulm1du6ml7mgcQClVdolH6xoLgODA2PDm8zHp6
         UtXY/bsl8CSTLthlOmblI3nD8MD4C4aGPo6WfuKJvrKqAAfmYn0D7Ft0jc5GTky+rFWn
         9tczATkj8F7CdwArhAxU3evcSLF1cY2rM0/A9UozcwmQ6T8ceyCmaIDW6lnwQ93xfu+Y
         +sfF/oHkmW8mjjesgwd63pWzyMRlDmoxcAaFG9ZyJReGQGRVkMFVwDel+Q9yvvJtDo1R
         W9ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wmko9U6xz9AxcE4cRj9bysFLw2CXZVZtRuLkE86PSJA=;
        b=SL9Zje1jVu6IIFHJCxb7WDMxB1DrXQWEbZ0bwYwdv3mgvghOnVMwH1yhEXzXCegVGG
         wAJU74WGn+IB02/1Aur76pvDY656wDTntL3BPpW2m29VDShxImrI9KTTHQp0cRkiOWqu
         nHbIprVNQzRC5QsJn1iD8DwO4p9vfNlPwX2J9MtVVstcRxCY2ul+FrADeVFIv2RcPoPz
         dL8wwRIA+gi1JsXn6IxX4Fsv3cKwDQqF1q9xpzcBrvYshRDFAnmTCspRcK7UsLUeYJb8
         M/snQ/g+XxIlB2CJl506Jnm0B8sdvywG4jNv92V5DwOQ6B3AbiDBFP09QlOBcERxYxqQ
         2rdw==
X-Gm-Message-State: AO0yUKXaNWw61PDX9d5A0RgfNlStjbDJh/RbB04MOdou4FlAtal0T6uP
        XgYOzk0a5jHOtgyJud+74xY=
X-Google-Smtp-Source: AK7set/LuYmzN5/m8rFk4BNLQnUmbQnLnDMH0XltaV9w4TM9F1NK6YBQ2/XEccxAX505vc0pgL2VyQ==
X-Received: by 2002:a05:6214:5298:b0:56b:ee96:4d32 with SMTP id kj24-20020a056214529800b0056bee964d32mr6706308qvb.51.1675795967835;
        Tue, 07 Feb 2023 10:52:47 -0800 (PST)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id p13-20020a05620a22ad00b007204305dee4sm9840932qkh.19.2023.02.07.10.52.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 10:52:47 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailauth.nyi.internal (Postfix) with ESMTP id D8DA527C0054;
        Tue,  7 Feb 2023 13:52:46 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 07 Feb 2023 13:52:46 -0500
X-ME-Sender: <xms:_p3iYzK13tGaAxDi2FPtGLX_0Nw8xhnv0gL5eVSj661cW8qnz0P4HQ>
    <xme:_p3iY3IurCDWz4O4zyw1Jy8aXzORwgM5Ke8ES2myh5Abz56lL-nPW1uK97dNMYdp4
    rnOiE9_78JVCn3znw>
X-ME-Received: <xmr:_p3iY7uKgj8NqGHfq9ozPmQ4cmKO6OuCCHHEbgotSt-zMgT62SsOMZPNue8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudegkedgudduhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeeuohhq
    uhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrf
    grthhtvghrnhepheefvddtkeejtdelffekgfdtheeugeefffekgefghfejhfduieekjeeg
    heetvdefnecuffhomhgrihhnpehpthhrrdgrshenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghr
    shhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvg
    hngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:_p3iY8Z_gKYSBiNxZPgCu_hrwX-_mCubt81Xbp-hACqy19KcAOYOzw>
    <xmx:_p3iY6YPThLpMa2ZsFwwf7tJ_SQDDiHpfgxkwbI6fAWaNa-bQTVSyQ>
    <xmx:_p3iYwBqOs89aHusyM2USLgijEXwn11RRckeklcR2MTpfyITq3iVsA>
    <xmx:_p3iYyoLxuaTdXUZoZ27Vbk9DlFn41NvFp8EyQWOkeiJu5y1TSvv8w>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Feb 2023 13:52:45 -0500 (EST)
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
Subject: [PATCH v2 1/2] rust: sync: impl {Debug,Display} for {Unique,}Arc
Date:   Tue,  7 Feb 2023 10:52:15 -0800
Message-Id: <20230207185216.1314638-2-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230207185216.1314638-1-boqun.feng@gmail.com>
References: <20230207185216.1314638-1-boqun.feng@gmail.com>
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
inner data implements `Display` or `Debug`. It's useful for logging and
debugging purpose.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Reviwed-by: Vincenzo Palazzo <vincenzopalazzodev@gmail.com>
---
 rust/kernel/sync/arc.rs | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
index 519a6ec43644..e6176d9b5b29 100644
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
@@ -522,3 +523,27 @@ impl<T: ?Sized> DerefMut for UniqueArc<T> {
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
+
+impl<T: fmt::Debug + ?Sized> fmt::Debug for UniqueArc<T> {
+    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
+        fmt::Debug::fmt(self.deref(), f)
+    }
+}
+
+impl<T: fmt::Debug + ?Sized> fmt::Debug for Arc<T> {
+    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
+        fmt::Debug::fmt(self.deref(), f)
+    }
+}
-- 
2.39.1

