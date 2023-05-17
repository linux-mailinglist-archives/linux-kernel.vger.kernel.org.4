Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D8967072BA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 22:08:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbjEQUIo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 16:08:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjEQUIi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 16:08:38 -0400
Received: from mail-ej1-x649.google.com (mail-ej1-x649.google.com [IPv6:2a00:1450:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9B0C7D89
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 13:08:37 -0700 (PDT)
Received: by mail-ej1-x649.google.com with SMTP id a640c23a62f3a-94a34d3e5ebso131457666b.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 13:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684354116; x=1686946116;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8iJR0huTfHVTodkNfO2dbFSpbRb6U9pb/v/u0biFupw=;
        b=bWzM94fINtOQiMgIeij8r/YgZ5x9bR/Dr9fiTQjsYbOEc/EG/KK3e24KYDbSbKNXFq
         q0JETAcKy8aAdEveycELSQP0Ii/yRJnHVk4NKArscNFWSTQkCbq1VcORowwK/6Ou8Yb8
         0s6z4qC2HG4wsDP+zgctkD2KNiocsj8sZviKvuD+KSI518NxZvqsWzw8HUxm1BcPU4eJ
         S3tGklnk97V3591mhv9OhfHFl38eoUwDL0WA8VbW30AEVdqh1K736UaBB1EKE5aaAvRJ
         RpxcN2gss1FGPI7JNDtmlPhXfX8KVUsqBfnaRMg0dauYa+JFHyIAHP4RRisrg0k+L8XF
         1ugw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684354116; x=1686946116;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8iJR0huTfHVTodkNfO2dbFSpbRb6U9pb/v/u0biFupw=;
        b=WxVxN0at63RzQ/HqIhGi56zYvMhCPes60qqd7RA4kuYETeFy6FtZn1xw5C4d/Me4eG
         +1+iy2ljz0BQ15EcQjwB3Pf1fCwfF8KgbTdrlqsGBUfPAyyk+Jbw14WECwasj2E1dQhh
         mDB/mXLrfnD7iduIeGyRmg2kK6XvKN05dKvWAYB8tuJFOe5Xc79YkK64vLUAm2689Ow9
         kuV7RfWbzeDHqUXhrCxMfraLJz+lkOH3r6rsYu6oC5r9mxIf1YhWjEyDsN0GWAXrtiPA
         ueN0pNIZNz+vUH4wrmrHdKpt9SpsR8hLyIpHTpR4IvxZkmfYNNykv7BiHSPj6CsJEcbi
         KQ0Q==
X-Gm-Message-State: AC+VfDx2d4p20LMlPKLtk5sQV1vW1zsesQKH5r/E/r/T0fNXlTdlFErH
        iTI1adKT0E2S58uwGr5zBHXgpq8iTm9qgsY=
X-Google-Smtp-Source: ACHHUZ4YGLtjd/kuG8qRx/nnMKQbJbKmU6GNX6G9qK33HW2/6o/Jr8uWhpPLl4A/zXlgMGnERgXqzW6IE9wZdio=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:6c8])
 (user=aliceryhl job=sendgmr) by 2002:a17:906:847a:b0:969:fc90:bf94 with SMTP
 id hx26-20020a170906847a00b00969fc90bf94mr9978929ejc.8.1684354116437; Wed, 17
 May 2023 13:08:36 -0700 (PDT)
Date:   Wed, 17 May 2023 20:08:14 +0000
In-Reply-To: <20230517200814.3157916-1-aliceryhl@google.com>
Mime-Version: 1.0
References: <20230517200814.3157916-1-aliceryhl@google.com>
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
Message-ID: <20230517200814.3157916-2-aliceryhl@google.com>
Subject: [PATCH v1 2/2] rust: sync: implement `AsRef<T>` for `Arc<T>`
From:   Alice Ryhl <aliceryhl@google.com>
To:     Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>
Cc:     Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        "=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?=" <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alice Ryhl <aliceryhl@google.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev,
        Wedson Almeida Filho <walmeida@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This trait lets you use `Arc<T>` in code that is generic over smart
pointer types.

The `AsRef` trait should be implemented on all smart pointers. The
standard library also implements it on the ordinary `Arc`.

Co-developed-by: Wedson Almeida Filho <walmeida@microsoft.com>
Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/sync/arc.rs | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
index 274febe3bb06..9ec911e4a0c7 100644
--- a/rust/kernel/sync/arc.rs
+++ b/rust/kernel/sync/arc.rs
@@ -264,6 +264,12 @@ impl<T: ?Sized> Deref for Arc<T> {
     }
 }
 
+impl<T: ?Sized> AsRef<T> for Arc<T> {
+    fn as_ref(&self) -> &T {
+        self.deref()
+    }
+}
+
 impl<T: ?Sized> Clone for Arc<T> {
     fn clone(&self) -> Self {
         // INVARIANT: C `refcount_inc` saturates the refcount, so it cannot overflow to zero.
-- 
2.40.1.606.ga4b1b128d6-goog

