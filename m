Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A19E9657306
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 07:04:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbiL1GEt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 01:04:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiL1GEj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 01:04:39 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A262BDF5E;
        Tue, 27 Dec 2022 22:04:37 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id n3so13326857wrc.5;
        Tue, 27 Dec 2022 22:04:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=goq/CMrFBd6u+qE+xn52atb3sI7HR978kaW9wQkRdwc=;
        b=QCeu10zRclmKJOgwNkQvDbuxs0Cl1FaNUtIhoFH+m++i0zY2pFvcmyZ/f/5JZxDidH
         Ft52J1m0QnOKBe9gos0xQ9atSJeYrEUe2+qh2Fp08EpdDJnCDERtSlcxk3llQKSXvDVK
         lG+kW5pfP9UYzhX1ahke286G9Q+OwKDasAeZSK0Kv+ZILmLWOeJkABcUnSqLhNL1x7kD
         VSbjOkXS6EbpHpzoen1Fg7w3fEaWmtsrKljPhhg5ZVlxbh83TNaZeNBAxwzn+0swy4DN
         RBWazzkIpzmEqwNK7Eat/8hgHRZwUbmINiXla7hS3ITLAAmfBPf4LVE9ScKqAA8xd0tm
         vD7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=goq/CMrFBd6u+qE+xn52atb3sI7HR978kaW9wQkRdwc=;
        b=PtP1a1512jT2ro3nrw4pYr4LSuyXsx/6XEyx7s7SjTvBhC3MdxhiaKXpjw5nN57Ejn
         XPACBhM79gdGdRg3QxDeZyFjYEfsmprORwbkqOH0Oi+1CpbKUOH89LWYIMkWSJU3oPna
         XiiF1RKR5GcO4aY56PHkT+VDpnNea9Dm0hbG0YA8cGI8ssua95kDRERqGELQnUTToq08
         bU7QgD7OCLQYEDarAHYNu9iXKdEnKAnMgDHHBy2ptK2HZJsCVLcS2fIU3H0PIxiwQJED
         wmAf9DPTzFdkZN4JvVRlcZUdMIvfKbq51tZdBg9XkOOMVpl2p2F4FmfeIc9iHEiJ3zaV
         I6gg==
X-Gm-Message-State: AFqh2kqPt2ul+faPTFCHc40MdwOmKomNJWkRPenHvXkC+J46HNyIf+Wb
        dINkgx9humhBAAReSn+OmUBwfvM/HkbtmA==
X-Google-Smtp-Source: AMrXdXs/K9CWPr0+1C6ehYAefcszcm8XY/rFPYKGkyvgBCwH0gV8wBTpX+8nKUs0kffghkTEl1qEog==
X-Received: by 2002:a5d:430e:0:b0:279:53e1:5178 with SMTP id h14-20020a5d430e000000b0027953e15178mr7260690wrq.45.1672207476141;
        Tue, 27 Dec 2022 22:04:36 -0800 (PST)
Received: from wedsonaf-dev.. ([81.2.152.129])
        by smtp.googlemail.com with ESMTPSA id x16-20020a5d6510000000b002755e301eeasm12128867wru.100.2022.12.27.22.04.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Dec 2022 22:04:35 -0800 (PST)
From:   Wedson Almeida Filho <wedsonaf@gmail.com>
To:     rust-for-linux@vger.kernel.org
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
        linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <wedsonaf@gmail.com>
Subject: [PATCH 2/7] rust: sync: allow type of `self` to be `Arc<T>` or variants
Date:   Wed, 28 Dec 2022 06:03:41 +0000
Message-Id: <20221228060346.352362-2-wedsonaf@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221228060346.352362-1-wedsonaf@gmail.com>
References: <20221228060346.352362-1-wedsonaf@gmail.com>
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

This allows associated functions whose `self` argument has `Arc<T>` or
variants as their type. This, in turn, allows callers to use the dot
syntax to make calls.

Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
---
 rust/kernel/lib.rs      |  1 +
 rust/kernel/sync/arc.rs | 28 ++++++++++++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index ace064a3702a..1a10f7c0ddd9 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -14,6 +14,7 @@
 #![no_std]
 #![feature(allocator_api)]
 #![feature(core_ffi_c)]
+#![feature(receiver_trait)]
 
 // Ensure conditional compilation based on the kernel configuration works;
 // otherwise we may silently break things like initcall handling.
diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
index 22290eb5ab9b..e2eb0e67d483 100644
--- a/rust/kernel/sync/arc.rs
+++ b/rust/kernel/sync/arc.rs
@@ -57,6 +57,31 @@ use core::{marker::PhantomData, ops::Deref, ptr::NonNull};
 ///
 /// // The refcount drops to zero when `cloned` goes out of scope, and the memory is freed.
 /// ```
+///
+/// Using `Arc<T>` as the type of `self`:
+///
+/// ```
+/// use kernel::sync::Arc;
+///
+/// struct Example {
+///     a: u32,
+///     b: u32,
+/// }
+///
+/// impl Example {
+///     fn take_over(self: Arc<Self>) {
+///         // ...
+///     }
+///
+///     fn use_reference(self: &Arc<Self>) {
+///         // ...
+///     }
+/// }
+///
+/// let obj = Arc::try_new(Example { a: 10, b: 20 })?;
+/// obj.use_reference();
+/// obj.take_over();
+/// ```
 pub struct Arc<T: ?Sized> {
     ptr: NonNull<ArcInner<T>>,
     _p: PhantomData<ArcInner<T>>,
@@ -68,6 +93,9 @@ struct ArcInner<T: ?Sized> {
     data: T,
 }
 
+// This is to allow [`Arc`] (and variants) to be used as the type of `self`.
+impl<T: ?Sized> core::ops::Receiver for Arc<T> {}
+
 // SAFETY: It is safe to send `Arc<T>` to another thread when the underlying `T` is `Sync` because
 // it effectively means sharing `&T` (which is safe because `T` is `Sync`); additionally, it needs
 // `T` to be `Send` because any thread that has an `Arc<T>` may ultimately access `T` directly, for
-- 
2.34.1

