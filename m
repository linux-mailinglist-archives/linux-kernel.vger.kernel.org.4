Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE09A69E88E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 20:50:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbjBUTuI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 14:50:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjBUTuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 14:50:06 -0500
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9004828866;
        Tue, 21 Feb 2023 11:50:05 -0800 (PST)
Received: by mail-qv1-xf33.google.com with SMTP id ks17so6069648qvb.6;
        Tue, 21 Feb 2023 11:50:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EePYiMegOTciLAZsPnWcxPxhjZ6l+MFlb+BerAyQPY8=;
        b=kFp77tZGRapMD/xntIodwnN0agkk46bzra9O2hXBMMrCYeKHh2cRc2dTdnWGIGw1Yx
         vNF1cbac8R2OumH0fYsvcLY9xTmoNqAdZlmzedoKjxXUj+M42WQfnFbH6ZC4Dl3Xvszw
         FR8aUfTEZMQWhG4JPs/JGGUUcCU0pqQUFK7IxeUH2B1YA7HBkpwHsqdrkl4lAe666khi
         ecYr9fghfUS+HTxbbO3V6C/FK/gcPj5wNFkWzU9hOvsG8TwbiQUUXJO/73G0hGc6VWEp
         NlcBTDtp+1H+l5MNtwrXEwCfW2XNdITk188yJVV7CDcAk608F7se2NWabQo+C/+4wnOn
         z1QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EePYiMegOTciLAZsPnWcxPxhjZ6l+MFlb+BerAyQPY8=;
        b=c/C7As/ZdE/GlW2ZIS7oryNWh+wLtJ50HND4TlQnaLwZpeliyydQRFH1qdYIJoJHhh
         dWSaiI2xFs3GRzEG0S6KFUyD4xgzRG4gjvzDR3Vzcph3WJbtMBdnVAEVB+3FHU/ocIQ6
         3qdrkODlx5kgC4kWsiIOV7ENqsm4LiGTeyfZH9P5Bj858bWjZBaNHyvm8srbKmueJ1Qe
         Fs2QKmddOmXdssT1b1RopxLBuYhwh33JTQUTKNDr/X4b7YytFk7GVRzHAqEMBl08j2yd
         NOPgC94aw/f3UeCyXODuJSWpruar5e8Q5tlCS3CqiBpZGIwIr2mUeyw/d8ePNLbcjZdL
         YwzQ==
X-Gm-Message-State: AO0yUKVui/W503QCc7C57Moy8vBI/46K8MWcE5MrKb54/Fr+cLsBP7OX
        J26cQIT8Gn2Tr4qCHF/6tUU=
X-Google-Smtp-Source: AK7set8esdN/bnRslH1891GxUxa8gviTZZGZhxV0W0+1ckhCH9sYqIOsZewRRN/M3UiQ1rqYsDqnUA==
X-Received: by 2002:ad4:5946:0:b0:56c:37d:51e with SMTP id eo6-20020ad45946000000b0056c037d051emr6687421qvb.22.1677009004676;
        Tue, 21 Feb 2023 11:50:04 -0800 (PST)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id d123-20020a37b481000000b0071f0d0aaef7sm11459343qkf.80.2023.02.21.11.50.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 11:50:03 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailauth.nyi.internal (Postfix) with ESMTP id 8C0DD27C0054;
        Tue, 21 Feb 2023 14:50:03 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 21 Feb 2023 14:50:03 -0500
X-ME-Sender: <xms:aiD1Y9gEFM7el3iJ9B9u1EzTFpWZ9Qw0WCZaW205Zbqqa4Wc3qcygA>
    <xme:aiD1YyA89slgzPereN_JmbS0K6LM2SAEAmjIUHx14gXXw7OF1cc7LrSX1aWnTq9ze
    w52ZlAgA_ZY5TP_uw>
X-ME-Received: <xmr:aiD1Y9GxvFy0QSiZ9n8-mw4xZJKm7Bjb38JqleA5twS-gx04eSEOPTwadGM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudejjedguddvjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhq
    uhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrf
    grthhtvghrnhephedugfduffffteeutddvheeuveelvdfhleelieevtdeguefhgeeuveei
    udffiedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedt
    ieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfh
    higihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:aiD1YyToqHNBnJHE9PT4ZjinnWR3Hs7t-qpcQ_L7DyfOONVW9-iBHw>
    <xmx:aiD1Y6zz7nSTRr34or559lYqOFthl45--qqwHsuvo62O1oh4Q_h_kg>
    <xmx:aiD1Y47kIMRE-isf2Wl7b7elVCBAaDIld6lJVIQoRI-8VaqKKT-g8g>
    <xmx:ayD1Y842ER2ErNK2ZbIHCPbyMOIfsMc_doaTAstyH1bJGRXDFD5xrA>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Feb 2023 14:50:02 -0500 (EST)
Date:   Tue, 21 Feb 2023 11:49:46 -0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Asahi Lina <lina@asahilina.net>, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        John Stultz <jstultz@google.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        rust-for-linux@vger.kernel.org, asahi@lists.linux.dev
Subject: Re: [PATCH] rust: time: New module for timekeeping functions
Message-ID: <Y/UgWqgRz2QxUT+t@boqun-archlinux>
References: <20230221-gpu-up-time-v1-1-bf8fe74b7f55@asahilina.net>
 <87v8jvnqq4.ffs@tglx>
 <Y/TP6as7qqwfcI42@boqun-archlinux>
 <6aa15295-219b-225c-607d-e87e3d51d048@asahilina.net>
 <87bklmonbv.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87bklmonbv.ffs@tglx>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 21, 2023 at 08:00:52PM +0100, Thomas Gleixner wrote:
[...]
> > I figured we might get a better idea for what to do once a
> > second user comes along. For example, do we want straight methods like
> > that or std::ops trait impls? And do we make everything fallible or
> > panic on overflow or just wrap?
> >
> > It also means we basically have to reimplement all of
> > core::time::Duration if we want to offer an equally ergonomic API with a
> > 64-bit type (for reference, Duration is a struct with u64 secs and u32
> > nanoseconds).
> 
> As you said yourself: The kernel can't use Rust std lib. So you better
> implement sensible interfaces which are straight forward and simple to
> use in the context you are aiming for.
> 

Agreed!

Lina, my suggestion is just to go ahead and add the minimal timestamp
abstraction, surely you may make some bad decisions about APIs (e.g.
panic vs returning a Result), but kernel doesn't have a stable internal
API, so we can always fix things later.

Myself actually do something like below based on your patch, because
nothing like `now()` ;-)

I'm sure you can do better because as you said, you're the first user
;-)

Regards,
Boqun

---------->8
diff --git a/rust/kernel/time.rs b/rust/kernel/time.rs
index 02844db47d34..3398388de0e1 100644
--- a/rust/kernel/time.rs
+++ b/rust/kernel/time.rs
@@ -6,16 +6,61 @@
 //! C header: [`include/linux/timekeeping.h`](../../../../include/linux/timekeeping.h)
 
 use crate::bindings;
-use core::time::Duration;
+// Re-exports [`Duration`], so that it's easy to provide kernel's own implemention in the future.
+pub use core::time::Duration;
+
+/// A timestamp
+pub trait TimeStamp: Copy {
+    /// Gets the current stamp.
+    fn now() -> Self;
+
+    /// Calculates the passed duration since `another`.
+    fn duration_since(&self, another: Self) -> Duration;
+
+
+    /// Return the duration passed since this stamp was created.
+    fn elapsed(&self) -> Duration {
+        let created = self.clone();
+        self.duration_since(created)
+    }
+}
+
+/// CLOCK_MONOTONIC timestamps.
+#[derive(Clone, Copy)]
+pub struct MonoTime(Duration);
+
+impl TimeStamp for MonoTime {
+    fn now() -> Self {
+        Self(ktime_get())
+    }
+
+    fn duration_since(&self, another: Self) -> Duration {
+        ktime_get() - another.0
+    }
+}
+
+/// CLOCK_BOOTTIME timestamps.
+#[derive(Clone, Copy)]
+pub struct BootTime(Duration);
+
+impl TimeStamp for BootTime {
+    fn now() -> Self {
+        Self(ktime_get_boottime())
+    }
+
+    fn duration_since(&self, another: Self) -> Duration {
+        ktime_get_boottime() - another.0
+    }
+}
 
 /// Returns the kernel time elapsed since boot, excluding time spent sleeping, as a [`Duration`].
-pub fn ktime_get() -> Duration {
+fn ktime_get() -> Duration {
     // SAFETY: Function has no side effects and no inputs.
     Duration::from_nanos(unsafe { bindings::ktime_get() }.try_into().unwrap())
 }
 
 /// Returns the kernel time elapsed since boot, including time spent sleeping, as a [`Duration`].
-pub fn ktime_get_boottime() -> Duration {
+fn ktime_get_boottime() -> Duration {
     Duration::from_nanos(
         // SAFETY: Function has no side effects and no variable inputs.
         unsafe { bindings::ktime_get_with_offset(bindings::tk_offsets_TK_OFFS_BOOT) }
