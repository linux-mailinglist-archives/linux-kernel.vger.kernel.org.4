Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C856676286
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 01:45:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbjAUApP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 19:45:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjAUApO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 19:45:14 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 126E66C131;
        Fri, 20 Jan 2023 16:45:13 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id z9so5558490qtv.5;
        Fri, 20 Jan 2023 16:45:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=EONii7uRlv+5lE1JkGxwkUV1QX6ggI0MPQy4AWM0VIM=;
        b=lMZhYWrxUJ+LW/2AuGUyLXKMOmthoajG4rUQAwu1qMH66uiggZRN3aqBZaj6C0Ka0q
         hC3NGiKqCNz+M7KeNDnpTzO6qRC8E1pD9N3CWGs0YPW5U2xOC8cMuyr6KLSSkJj+oQYY
         DOrVfCgJR5dFV59wKi0JhCxbuyhFzmDaB92P0GDUrRLYr9cHq6tIQs6SyQGwIxjvvWiQ
         qYZNt4dosWoaukjxJ+nP5spya+wcvp/EfFgUPo2xU4QySpD36NhUZVIR1TzLMJGyJ3SX
         tbuc5Xr16xSBzUrpXBHBHmAadn5eQyo9vHUYsB1K2ob3HkJRPfDquyPFIoQXRMFbty/q
         oJtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EONii7uRlv+5lE1JkGxwkUV1QX6ggI0MPQy4AWM0VIM=;
        b=anO7JWQ5O4WQUy6h8T/FpODRWnGPvroFIgkzqs9Yy9kD3+DzX+iERpFsYiMoW+Lsi9
         HCIjkkKSyP/0I0ciLNxGAQ9fAcD+4O9w0tUcgayXXSgsd+R3z4gJHOAEa+Dlvfdu9n6V
         12U3JEQnboAXHxOuXFmP+M7E1N6O9h635GGi40NMczpZmPssORz4qk9tokYc/no/iyAU
         dOCgZ0PPFAV1I+o4jl6YZjsuG8COWdYQ1ldxOy8DrohIHKIqeRatUODStf9iokrdb1iN
         uS7lSvrpjgHep+QSux5egY5Q0c1G0zo3XS3fHP1F/rSi8ky4R7k+9QIAnAg+7RjbIitm
         XT/A==
X-Gm-Message-State: AFqh2kqUyyxAOGGubTpCb2WlBXMV9SofIGDsegj0w3W+vIktJKAwDLig
        5W4P4d71jrvjrpfLYlTruqU=
X-Google-Smtp-Source: AMrXdXvTE+TWOytPv3Ukg7x0FRsdK/qAIJVCs2wEDEuGaMrTqg3HBUFaZLcyEQ7qQuhVGObacutc3w==
X-Received: by 2002:ac8:5444:0:b0:3ab:af8e:64e6 with SMTP id d4-20020ac85444000000b003abaf8e64e6mr19360961qtq.67.1674261912183;
        Fri, 20 Jan 2023 16:45:12 -0800 (PST)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id b5-20020ac85405000000b003b6894f7002sm4232120qtq.9.2023.01.20.16.45.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 16:45:11 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailauth.nyi.internal (Postfix) with ESMTP id 2EA9C27C0054;
        Fri, 20 Jan 2023 19:45:10 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Fri, 20 Jan 2023 19:45:11 -0500
X-ME-Sender: <xms:ljXLY4MIw4H1kxUM98F-RShHNFhsW_YJppSummrjbgTV8w8esc_wVQ>
    <xme:ljXLY-9tajRc83yMSPi97sPNWHPqnCpeXlDM9YgplRIcNTNC7VoitQ7GyAcY2y7T1
    YXVI38SPwxf0DMeaw>
X-ME-Received: <xmr:ljXLY_TgyYGLoF-DXzxuQp67aGwAl93yts1_0AJ2KrtPwFg8wu-85c9f1mU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedruddufedgvdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttddunecuhfhrohhmpeeuohhq
    uhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrf
    grthhtvghrnhepueegtdefieejveevvdelheefffdtffehveejtddvkefgkefhveekieet
    leffveetnecuffhomhgrihhnpehpthhrrdgrshdpihhnnhgvrhdrrghsnecuvehluhhsth
    gvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhm
    thhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvd
    dqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:ljXLYwts4-Avn8g28tCOa1piyoOV9vqcT2aFUMSWBo7HJPpa0qoXJQ>
    <xmx:ljXLYwenTnQkBWIlvNfcyYxQs3Z7wQOlka1b4dYaaIyyQIB9C3RihA>
    <xmx:ljXLY00E6LyD3fokHgfn_nSoIJYGX3mjdPW8nrL7PpDWIe8alpkaXg>
    <xmx:ljXLY-tRl4ZsefkisuEPQPy9XiQi6vTfKfSn3H1QoNKDjp8G9naO_Q>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Jan 2023 19:45:09 -0500 (EST)
Date:   Fri, 20 Jan 2023 16:44:42 -0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Gary Guo <gary@garyguo.net>
Cc:     Emilio Cobos =?iso-8859-1?Q?=C1lvarez?= <emilio@crisal.io>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/7] rust: sync: introduce `ArcBorrow`
Message-ID: <Y8s1evi1wY1XlVgG@boqun-archlinux>
References: <20221228060346.352362-1-wedsonaf@gmail.com>
 <20221228060346.352362-4-wedsonaf@gmail.com>
 <20221231194352.55cf0a26.gary@garyguo.net>
 <CANeycqrVsbNJ+A+A26LXkBezBNUHvnZU2Q3_whexCwwG5ZcgPQ@mail.gmail.com>
 <df2f6c0b-fb4c-97e5-b607-7df626ea5933@crisal.io>
 <20230116220736.6d5c8ea3.gary@garyguo.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230116220736.6d5c8ea3.gary@garyguo.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Jan 16, 2023 at 10:07:36PM +0000, Gary Guo wrote:
> On Wed, 4 Jan 2023 17:06:50 +0100
> Emilio Cobos Álvarez <emilio@crisal.io> wrote:
> 
> > Sorry for the drive-by comment, but maybe it saves some work.
> > 
> > On 1/4/23 16:29, Wedson Almeida Filho wrote:
> > > On Sat, 31 Dec 2022 at 19:43, Gary Guo <gary@garyguo.net> wrote:  
> > >>
> > >> On Wed, 28 Dec 2022 06:03:43 +0000
> > >> Wedson Almeida Filho <wedsonaf@gmail.com> wrote:
> > >>> +pub struct ArcBorrow<'a, T: ?Sized + 'a> {
> > >>> +    inner: NonNull<ArcInner<T>>,
> > >>> +    _p: PhantomData<&'a ()>,
> > >>> +}
> > >>> +
> > >>> +impl<T: ?Sized> Clone for ArcBorrow<'_, T> {
> > >>> +    fn clone(&self) -> Self {
> > >>> +        *self
> > >>> +    }
> > >>> +}
> > >>> +
> > >>> +impl<T: ?Sized> Copy for ArcBorrow<'_, T> {}  
> > >>
> > >> Couldn't this just be derived `Clone` and `Copy`?  
> > > 
> > > Indeed. I'll send a v2 with this.  
> > 
> > I'm not sure this is true. Deriving will add the T: Copy and T: Clone 
> > bound, which I think is not what you want here.
> > 
> > i.e., I assume you want an ArcBorrow to be Copy even if the underlying T 
> > is not.
> 
> Thanks for pointing out, I neglected that.
> 

Somehow I run into this code again, and after a few thoughts, I'm
wondering: isn't ArcBorrow just &ArcInner<T>?

I've tried the following diff, and it seems working. The better parts
are 1) #[derive(Clone, Copy)] works and 2) I'm able to remove a few code
including one "unsafe" in ArcBorrow::deref().

But sure, more close look is needed. Thoughts?

Regards,
Boqun

> In this case:
> 
> Reviewed-by: Gary Guo <gary@garyguo.net>

--------------------------------->8
diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
index ff73f9240ca1..48f919878f44 100644
--- a/rust/kernel/sync/arc.rs
+++ b/rust/kernel/sync/arc.rs
@@ -185,7 +185,7 @@ impl<T: ?Sized> Arc<T> {
         // SAFETY: The constraint that the lifetime of the shared reference must outlive that of
         // the returned `ArcBorrow` ensures that the object remains alive and that no mutable
         // reference can be created.
-        unsafe { ArcBorrow::new(self.ptr) }
+        ArcBorrow(unsafe { self.ptr.as_ref() })
     }
 }
 
@@ -298,52 +298,25 @@ impl<T: ?Sized> From<Pin<UniqueArc<T>>> for Arc<T> {
 /// let obj = Arc::try_new(Example { a: 10, b: 20 })?;
 /// obj.as_arc_borrow().use_reference();
 /// ```
-pub struct ArcBorrow<'a, T: ?Sized + 'a> {
-    inner: NonNull<ArcInner<T>>,
-    _p: PhantomData<&'a ()>,
-}
+#[derive(Clone, Copy)]
+pub struct ArcBorrow<'a, T: ?Sized>(&'a ArcInner<T>);
 
 // This is to allow [`ArcBorrow`] (and variants) to be used as the type of `self`.
 impl<T: ?Sized> core::ops::Receiver for ArcBorrow<'_, T> {}
 
 // This is to allow `ArcBorrow<U>` to be dispatched on when `ArcBorrow<T>` can be coerced into
 // `ArcBorrow<U>`.
-impl<T: ?Sized + Unsize<U>, U: ?Sized> core::ops::DispatchFromDyn<ArcBorrow<'_, U>>
-    for ArcBorrow<'_, T>
+impl<'a, T: ?Sized + Unsize<U>, U: ?Sized> core::ops::DispatchFromDyn<ArcBorrow<'a, U>>
+    for ArcBorrow<'a, T>
 {
 }
 
-impl<T: ?Sized> Clone for ArcBorrow<'_, T> {
-    fn clone(&self) -> Self {
-        *self
-    }
-}
-
-impl<T: ?Sized> Copy for ArcBorrow<'_, T> {}
-
-impl<T: ?Sized> ArcBorrow<'_, T> {
-    /// Creates a new [`ArcBorrow`] instance.
-    ///
-    /// # Safety
-    ///
-    /// Callers must ensure the following for the lifetime of the returned [`ArcBorrow`] instance:
-    /// 1. That `inner` remains valid;
-    /// 2. That no mutable references to `inner` are created.
-    unsafe fn new(inner: NonNull<ArcInner<T>>) -> Self {
-        // INVARIANT: The safety requirements guarantee the invariants.
-        Self {
-            inner,
-            _p: PhantomData,
-        }
-    }
-}
-
 impl<T: ?Sized> From<ArcBorrow<'_, T>> for Arc<T> {
     fn from(b: ArcBorrow<'_, T>) -> Self {
         // SAFETY: The existence of `b` guarantees that the refcount is non-zero. `ManuallyDrop`
         // guarantees that `drop` isn't called, so it's ok that the temporary `Arc` doesn't own the
         // increment.
-        ManuallyDrop::new(unsafe { Arc::from_inner(b.inner) })
+        ManuallyDrop::new(unsafe { Arc::from_inner(b.0.into()) })
             .deref()
             .clone()
     }
@@ -353,9 +326,7 @@ impl<T: ?Sized> Deref for ArcBorrow<'_, T> {
     type Target = T;
 
     fn deref(&self) -> &Self::Target {
-        // SAFETY: By the type invariant, the underlying object is still alive with no mutable
-        // references to it, so it is safe to create a shared reference.
-        unsafe { &self.inner.as_ref().data }
+        &self.0.data
     }
 }
 
