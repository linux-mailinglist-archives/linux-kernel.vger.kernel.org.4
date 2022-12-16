Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2655664F0A4
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 18:49:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231598AbiLPRtw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 12:49:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231655AbiLPRtl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 12:49:41 -0500
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7E2370B9D;
        Fri, 16 Dec 2022 09:49:40 -0800 (PST)
Received: by mail-wr1-f44.google.com with SMTP id i7so3240206wrv.8;
        Fri, 16 Dec 2022 09:49:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7yIyfrfOdv5xmkNvR1/BpAbRSIDwZLQJEypBYov0ihk=;
        b=mmC6HbKQ6BYA6GmOpVI3q/ntPkn73T7A4CpKCKOkKCi42iXNHGzwTu/gPNALyFXJ6R
         6rekyI0X2eoRPIKC9o0uU2VN4IaIxZ/71O05rLbbAcAI0/IVSdaDOT6ND3nSCLy5cHxz
         AQAZqNAX16woTG4Ppb8vYlTRPIlh8x/io3JVvA0au3EP6iLxjB0lajktJ+yU1xyopWA3
         io0Vyh6Of7vhLO+1xycqmF/WpTtN0FZO7psbuRbtRWmtCyTg5mPsPZRPfIKhMMcAM5ay
         AR+EPGc1v6SfdbvFNoZ28aIvKnH5D2SccjUb24pthYm/9pDmVIMfhmH1Q6KGGZmLDTR/
         XPAw==
X-Gm-Message-State: ANoB5pk1mkjhUfVmfuy1PTXSM8Ybgz7LNii0Lpv8RGTbLpND9MTeYWlS
        akxGKaOyDD0ZRd3H0cVzCZuBlWyfRqg=
X-Google-Smtp-Source: AA0mqf5cH/FN4aDPJsYWBBDQyEca7uIiApJIE5g7qvsecnaR7LSuohXr8cvjjPr1+O2u7i0/jkTYJQ==
X-Received: by 2002:a5d:6741:0:b0:242:567e:25a7 with SMTP id l1-20020a5d6741000000b00242567e25a7mr22013961wrw.42.1671212978691;
        Fri, 16 Dec 2022 09:49:38 -0800 (PST)
Received: from liuwe-devbox-debian-v2.j3c5onc20sse1dnehy4noqpfcg.zx.internal.cloudapp.net ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id w1-20020adfec41000000b002422b462975sm2809384wrn.34.2022.12.16.09.49.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Dec 2022 09:49:38 -0800 (PST)
From:   Wei Liu <wei.liu@kernel.org>
To:     rust-for-linux@vger.kernel.org,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Cc:     Wei Liu <wei.liu@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>
Subject: [PATCH] rust: kernel: drop repetition in offset_of macro
Date:   Fri, 16 Dec 2022 17:49:27 +0000
Message-Id: <20221216174927.1008629-1-wei.liu@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It doesn't make sense to allow multiple fields to be specified in
offset_of.

No functional change.

Signed-off-by: Wei Liu <wei.liu@kernel.org>
---
Cc: Miguel Ojeda <ojeda@kernel.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>
Cc: Wedson Almeida Filho <wedsonaf@gmail.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Gary Guo <gary@garyguo.net>
Cc: Björn Roy Baron <bjorn3_gh@protonmail.com>
---
 rust/kernel/lib.rs | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 6a322effa60c..2f3601e4e27e 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -208,7 +208,7 @@ impl<'a> Drop for KParamGuard<'a> {
 /// ```
 #[macro_export]
 macro_rules! offset_of {
-    ($type:ty, $($f:tt)*) => {{
+    ($type:ty, $f:tt) => {{
         let tmp = core::mem::MaybeUninit::<$type>::uninit();
         let outer = tmp.as_ptr();
         // To avoid warnings when nesting `unsafe` blocks.
@@ -216,12 +216,14 @@ macro_rules! offset_of {
         // SAFETY: The pointer is valid and aligned, just not initialised; `addr_of` ensures that
         // we don't actually read from `outer` (which would be UB) nor create an intermediate
         // reference.
-        let inner = unsafe { core::ptr::addr_of!((*outer).$($f)*) } as *const u8;
+        let inner = unsafe { core::ptr::addr_of!((*outer).$f) } as *const u8;
         // To avoid warnings when nesting `unsafe` blocks.
         #[allow(unused_unsafe)]
         // SAFETY: The two pointers are within the same allocation block.
-        unsafe { inner.offset_from(outer as *const u8) }
-    }}
+        unsafe {
+            inner.offset_from(outer as *const u8)
+        }
+    }};
 }
 
 /// Produces a pointer to an object from a pointer to one of its fields.
-- 
2.35.1

