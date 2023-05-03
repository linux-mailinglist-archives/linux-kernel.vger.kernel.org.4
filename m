Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC2946F5400
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 11:08:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbjECJIB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 05:08:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbjECJHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 05:07:39 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 129D44EDE
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 02:07:26 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3f178da21afso32606765e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 May 2023 02:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20221208.gappssmtp.com; s=20221208; t=1683104845; x=1685696845;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n2aCenBwPL0i3vTawCb2L8YinJvZAslW/YJEjXhFLa8=;
        b=AkqTOFPVsQoS7ielM6GeSVWnFtz9yMESQff8kVfpSdZiy3bdaaWLpuG1t40bS0s7on
         TDgZIlo0iiLY/gG5xlQwmXkLkeWaeeMQho78fmcfwXr9vbm6f7BCJ5iI1WrR7q3Hq/B8
         eriq0v/fAaOJFcSS6bHc2AuiUNCaQsbgtGUGWsqZWxzyvj4YwzKANe2QUZrEgauRlAi0
         NXz0GQAAphVn7VtICawZK7usZ2YbQdSVM0vxmLmJsR+gx1YoAZPAl1wyrseet8M/HpaE
         0YWtzJTugKmoNajsIAjcEDi5kVkiG0HUiPkLga9N2S03hYveh/RedYTApIvgbetEAu5S
         8+zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683104845; x=1685696845;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n2aCenBwPL0i3vTawCb2L8YinJvZAslW/YJEjXhFLa8=;
        b=kfBZDrWq7HlkliKvl2FDXG3wUxJYacyF4LOG4bjyExpABgEUOzgjAIuVTvpO32xNIm
         3sZUcrRH5fDoPJYQ8K0Q2KUgN1VkJpLb/9ZqFFuqMXpiLvI3EoXiP1twQdHLALpnmFdx
         fCCPVGGGid8dTECwRM0Az5C0GNAq27CY/wzUS8dshI6rFqacKBX7A/lG7J+B/n7JqtsY
         lJa/XUuQg1zjrXvle17CIsrLltSDFePz+hOj0iGRsabT6EMa/5Ecckh18h6yl8OgyuGJ
         C9EucUXwNSj+tIvaSRjhfOHwJgcGWDTAeOQg6/dLY6Rcw6oUyR0aDkRotzV0h600nEZ0
         AOgw==
X-Gm-Message-State: AC+VfDz5p7xqiqAVBvRf3cqp1JuM7TTRgb7nRX93BVfCBBg7ohDStEvO
        TEeFhVA+C35R+fM+xnKjzzWeww==
X-Google-Smtp-Source: ACHHUZ6TOXRdg3DPcncxdnXc/lCXM7ZZOYLzK+Nmqw1ltFhclc2DCjmvwo383Z/Dy4ERb34WRGJ4yg==
X-Received: by 2002:a1c:7916:0:b0:3f1:952c:3c70 with SMTP id l22-20020a1c7916000000b003f1952c3c70mr13719294wme.40.1683104845321;
        Wed, 03 May 2023 02:07:25 -0700 (PDT)
Received: from localhost ([147.161.155.99])
        by smtp.gmail.com with ESMTPSA id g10-20020a7bc4ca000000b003f046ad52efsm1235624wmk.31.2023.05.03.02.07.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 02:07:25 -0700 (PDT)
From:   Andreas Hindborg <nmi@metaspace.dk>
To:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Hannes Reinecke <hare@suse.de>,
        lsf-pc@lists.linux-foundation.org, rust-for-linux@vger.kernel.org,
        linux-block@vger.kernel.org
Cc:     Andreas Hindborg <a.hindborg@samsung.com>,
        Matthew Wilcox <willy@infradead.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Andreas Hindborg <nmi@metaspace.dk>,
        linux-kernel@vger.kernel.org (open list), gost.dev@samsung.com
Subject: [RFC PATCH 09/11] RUST: implement `ForeignOwnable` for `Pin`
Date:   Wed,  3 May 2023 11:07:06 +0200
Message-Id: <20230503090708.2524310-10-nmi@metaspace.dk>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230503090708.2524310-1-nmi@metaspace.dk>
References: <20230503090708.2524310-1-nmi@metaspace.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andreas Hindborg <a.hindborg@samsung.com>

Implement `ForeignOwnable for Pin<T> where T: ForeignOwnable + Deref`.

Imported from rust tree [1]

[1] https://github.com/Rust-for-Linux/linux/tree/bc22545f38d74473cfef3e9fd65432733435b79f

Cc: Wedson Almeida Filho <wedsonaf@gmail.com>
---
 rust/kernel/types.rs | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
index 29db59d6119a..98e71e96a7fc 100644
--- a/rust/kernel/types.rs
+++ b/rust/kernel/types.rs
@@ -9,6 +9,7 @@ use core::{
     marker::PhantomData,
     mem::MaybeUninit,
     ops::{Deref, DerefMut},
+    pin::Pin,
     ptr::NonNull,
 };
 
@@ -100,6 +101,29 @@ impl ForeignOwnable for () {
     unsafe fn from_foreign(_: *const core::ffi::c_void) -> Self {}
 }
 
+impl<T: ForeignOwnable + Deref> ForeignOwnable for Pin<T> {
+    type Borrowed<'a> = T::Borrowed<'a>;
+
+    fn into_foreign(self) -> *const core::ffi::c_void {
+        // SAFETY: We continue to treat the pointer as pinned by returning just a pointer to it to
+        // the caller.
+        let inner = unsafe { Pin::into_inner_unchecked(self) };
+        inner.into_foreign()
+    }
+
+    unsafe fn borrow<'a>(ptr: *const core::ffi::c_void) -> Self::Borrowed<'a> {
+        // SAFETY: The safety requirements for this function are the same as the ones for
+        // `T::borrow`.
+        unsafe { T::borrow(ptr) }
+    }
+
+    unsafe fn from_foreign(p: *const core::ffi::c_void) -> Self {
+        // SAFETY: The object was originally pinned.
+        // The passed pointer comes from a previous call to `T::into_foreign`.
+        unsafe { Pin::new_unchecked(T::from_foreign(p)) }
+    }
+}
+
 /// Runs a cleanup function/closure when dropped.
 ///
 /// The [`ScopeGuard::dismiss`] function prevents the cleanup function from running.
-- 
2.40.0

