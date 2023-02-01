Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F39E26871D3
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 00:23:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229473AbjBAXXF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 18:23:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbjBAXXA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 18:23:00 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF2644680;
        Wed,  1 Feb 2023 15:22:57 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id z5so179120qtn.8;
        Wed, 01 Feb 2023 15:22:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aHPo6+AwM9yD1jStn/Ea4v3g6F0MxEwpwB3GOsSYmsQ=;
        b=coBzvkNWO16ubnVJFhsQLkJKuN9MBdDiq1fLJ4nGhdNLQYX4cfG7oGiORemm8jizjt
         y9c5k39cFqghMA3rXgtIEklnCshDDJaUHGbpWe3yjw+RTyLGWEcF3ij5SA6x9lcjniv4
         hDfkWY4nLrSeiFG5heMYed0UPizPfTgOSL3clXMb6TVBokvO0ieKTCaax3+yXVOdwXZv
         GiHvO218gYxLcpqjr0W80Lr6EFJVrY/wJnO/HaUgzX9EWip2nUHdCygRoMdARpAZesfG
         KPPsx1Z/OMIKJnTfVTK0Y3QCnKgu6hRiS55NZSXYe5WKpXiIjNpyLCEgcJBNr07pmFPO
         +nuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aHPo6+AwM9yD1jStn/Ea4v3g6F0MxEwpwB3GOsSYmsQ=;
        b=grsjgInOxnj18VJcmIOHTAJ919hOw8kIz/8848JXoFNIlu61gpjkan4pZGEs4kdeRc
         pOUBAym3r3o19hkQzNHYsbwGWZaE4wdjPYZt3gMVAEsFP+g5v48CUx7icwA5OK08sA+1
         bq//qVXdhPcAf2Q/FJozgk3woxx79AsfUBk96X82hdYJHwK3AIeHQNULY7x+hiDwD78Q
         7eLZiRquc8shE86YWnP5xxnfzBwynsklgPBHEr1ZVPhAMg06YDFEWC1MZaemLtiE+oUy
         sIKD0Q20fkB4Hj5sfzYOEaKbqEqHLr2iZJj5hlPL0wgDyrrHFQuqi9jXw0OLE1ubt+GT
         LS2g==
X-Gm-Message-State: AO0yUKU2IrrT24FfTOC6YtfVTEw70y+s9+y8ccMjQPkGZgu0NchaZZyN
        hlFuXEST/4IIfp87TRVbGYc=
X-Google-Smtp-Source: AK7set8e2QsqCZCuq1Et5y4/QaCWYeoawUWEscDSM7aOiQ8oEljU9DDNG4UnIrlXdysT+8gZHz+qKg==
X-Received: by 2002:ac8:4e54:0:b0:3b9:bd1f:1de6 with SMTP id e20-20020ac84e54000000b003b9bd1f1de6mr4876552qtw.40.1675293777095;
        Wed, 01 Feb 2023 15:22:57 -0800 (PST)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id eq14-20020a05622a5e0e00b003b9b8ae2c8dsm2252376qtb.93.2023.02.01.15.22.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 15:22:56 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailauth.nyi.internal (Postfix) with ESMTP id B047327C005A;
        Wed,  1 Feb 2023 18:22:55 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 01 Feb 2023 18:22:55 -0500
X-ME-Sender: <xms:T_TaYzSc83tDIh_n-yzZDNIMQIXa4airstfQmAioBjQgPdhvw--YNg>
    <xme:T_TaY0xW9gR2njGmlgQDVhKcmw4hDwHJYN_CuUBLIKVvvXXqOqpZ6yK0iNMdOkzcJ
    CwB4MOw7lXmdbSuzg>
X-ME-Received: <xmr:T_TaY41e29uru-Kaw1pWNHp4gvR5x9IwyHKlpcTLZ7nKYSBH3CWH5leZ0Es>
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
X-ME-Proxy: <xmx:T_TaYzBcOWiYhrjrfhU2bG8qZVAlPnAjzXV43KYQXMFNmY2ea3bdEQ>
    <xmx:T_TaY8gkw8Fr5mJqEWtPKY7yZ6LWrVJNeh1fpey-3TQho5Ujf9N3PQ>
    <xmx:T_TaY3r1aKxoTMJHBs8bLTPYDLVQlHKRD43VNsrUlHTM_gOdHhVUhg>
    <xmx:T_TaYxZ53PMw3OJ9hYtSHc8OkCFX6MDa-vVHi6rxQoU3VfQSK9AMFw>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Feb 2023 18:22:55 -0500 (EST)
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
Subject: [RFC 3/5] rust: sync: Arc: Introduces Arc::get_inner() helper
Date:   Wed,  1 Feb 2023 15:22:42 -0800
Message-Id: <20230201232244.212908-4-boqun.feng@gmail.com>
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

Getting a `&ArcInner<T>` should always be safe from a `Arc<T>`,
therefore add this helper function to avoid duplicate unsafe
`ptr.as_ref()`.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 rust/kernel/sync/arc.rs | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
index fbfceaa3096e..4d8de20c996f 100644
--- a/rust/kernel/sync/arc.rs
+++ b/rust/kernel/sync/arc.rs
@@ -201,6 +201,13 @@ impl<T: ?Sized> Arc<T> {
         // reference can be created.
         unsafe { ArcBorrow::new(self.ptr) }
     }
+
+    /// Returns a reference to the internal [`ArcInner`].
+    fn get_inner(&self) -> &ArcInner<T> {
+        // SAFETY: By the type invariant, there is necessarily a reference to the object, so it is
+        // safe to dereference it.
+        unsafe { self.ptr.as_ref() }
+    }
 }
 
 impl<T: 'static> ForeignOwnable for Arc<T> {
@@ -233,9 +240,7 @@ impl<T: ?Sized> Deref for Arc<T> {
     type Target = T;
 
     fn deref(&self) -> &Self::Target {
-        // SAFETY: By the type invariant, there is necessarily a reference to the object, so it is
-        // safe to dereference it.
-        unsafe { &self.ptr.as_ref().data }
+        &self.get_inner().data
     }
 }
 
@@ -244,7 +249,7 @@ impl<T: ?Sized> Clone for Arc<T> {
         // INVARIANT: C `refcount_inc` saturates the refcount, so it cannot overflow to zero.
         // SAFETY: By the type invariant, there is necessarily a reference to the object, so it is
         // safe to increment the refcount.
-        unsafe { bindings::refcount_inc(self.ptr.as_ref().refcount.get()) };
+        unsafe { bindings::refcount_inc(self.get_inner().refcount.get()) };
 
         // SAFETY: We just incremented the refcount. This increment is now owned by the new `Arc`.
         unsafe { Self::from_inner(self.ptr) }
@@ -253,11 +258,7 @@ impl<T: ?Sized> Clone for Arc<T> {
 
 impl<T: ?Sized> Drop for Arc<T> {
     fn drop(&mut self) {
-        // SAFETY: By the type invariant, there is necessarily a reference to the object. We cannot
-        // touch `refcount` after it's decremented to a non-zero value because another thread/CPU
-        // may concurrently decrement it to zero and free it. It is ok to have a raw pointer to
-        // freed/invalid memory as long as it is never dereferenced.
-        let refcount = unsafe { self.ptr.as_ref() }.refcount.get();
+        let refcount = self.get_inner().refcount.get();
 
         // INVARIANT: If the refcount reaches zero, there are no other instances of `Arc`, and
         // this instance is being dropped, so the broken invariant is not observable.
-- 
2.39.1

