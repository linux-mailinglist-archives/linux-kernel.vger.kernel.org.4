Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E02D6F598F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 16:11:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbjECOK7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 10:10:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbjECOK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 10:10:56 -0400
Received: from mail-ed1-x54a.google.com (mail-ed1-x54a.google.com [IPv6:2a00:1450:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D77359F7
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 07:10:54 -0700 (PDT)
Received: by mail-ed1-x54a.google.com with SMTP id 4fb4d7f45d1cf-50bcbb5724aso2831634a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 May 2023 07:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683123053; x=1685715053;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PscYnQxei+RrA3NkIhxRI+jonTcqCawkESGLIumeLz8=;
        b=i6wbV3qzZv6N/1ImH/nzBnfPh7xlGmGxBUX8RJPeTpz3tkVH4mRLomkibMuRQlKsUu
         Mqee2m33k6mtzRHeQ2Vuw4bVPr03n/SZALHA+gNsfJNF+zqbWVnKSFnV0QNCBXO/WyRj
         71xunrtFeEha39pnex5dhZSGZySmNlv4pz/07QSarAu+3Sa/HY+MzLbu/QtHAsBziPJI
         bd+P3Lh8NFBr/9hxE+DXRJt0Uc528bq198eDXLISEIAdqdgIhH6TCEqOM2TPfXsWh3nH
         REsCRFj2VCIum6c5B2luTkXrsQ40hKLLav9bfRMsgA1At64d1Fd+9EbzeLqpoiz7FPm2
         igwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683123053; x=1685715053;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PscYnQxei+RrA3NkIhxRI+jonTcqCawkESGLIumeLz8=;
        b=gxlDydSjhD0AkMtAlCMDmrfv6QwG1EQLT1mVyIbJiRkMaJbe9CSKfIHkG4jNIbgtt1
         QAl3XRvFKnPWV/WccrYPwfAelnJkTlSyerLYlSEFSbe0O8JZJ0z/n8HdkpDKvgJ3fME9
         K35yz1ON8Gcz2CUvoksU+WUpByGrTpKAg7VrvkfQc1+lKWxE2uz0DCOOxByT1NTf0CUk
         RY8ymtVRKZVTM8Nml3jGUvNzcyjy35o90PjF0PBee4MQhk0X4BIGtz7txVbGaRzjRHyx
         8BuSHZrlR1ZKdLuJ34BZW3/ydNllWJGhXTQGPD1TwpOz4Zd/MjNwNwCLUYc+x+tRdhmu
         Z9Dg==
X-Gm-Message-State: AC+VfDynBE817ikHKKpjIlgciLMbOls/TNU1NtZdXcaZ94ib48SAq2u/
        Wg8gAVg/set8eg5NJkrX97uKcxGXIce4n2M=
X-Google-Smtp-Source: ACHHUZ5Hcg3R5FNZVjC+7aM4byx27feeE4qcNWau4AL9D22yakKsHM7tbn/7f1WVJnfTEROqkMSdky1OhrWE7ws=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:6c8])
 (user=aliceryhl job=sendgmr) by 2002:a50:d482:0:b0:50b:d28d:a95c with SMTP id
 s2-20020a50d482000000b0050bd28da95cmr2144272edi.4.1683123052719; Wed, 03 May
 2023 07:10:52 -0700 (PDT)
Date:   Wed,  3 May 2023 14:10:16 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Message-ID: <20230503141016.683634-1-aliceryhl@google.com>
Subject: [PATCH v2] rust: str: add conversion from `CStr` to `CString`
From:   Alice Ryhl <aliceryhl@google.com>
To:     Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>
Cc:     Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        "=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?=" <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
        Alice Ryhl <aliceryhl@google.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,
        USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These methods can be used to copy the data in a temporary c string into
a separate allocation, so that it can be accessed later even if the
original is deallocated.

The API in this change mirrors the standard library API for the `&str`
and `String` types. The `ToOwned` trait is not implemented because it
assumes that allocations are infallible.

Reviewed-by: Benno Lossin <benno.lossin@proton.me>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/str.rs | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
index b771310fa4a4..f3dc5b24ea55 100644
--- a/rust/kernel/str.rs
+++ b/rust/kernel/str.rs
@@ -2,6 +2,7 @@
 
 //! String representations.
 
+use alloc::alloc::AllocError;
 use alloc::vec::Vec;
 use core::fmt::{self, Write};
 use core::ops::{self, Deref, Index};
@@ -199,6 +200,12 @@ impl CStr {
     pub unsafe fn as_str_unchecked(&self) -> &str {
         unsafe { core::str::from_utf8_unchecked(self.as_bytes()) }
     }
+
+    /// Convert this [`CStr`] into a [`CString`] by allocating memory and
+    /// copying over the string data.
+    pub fn to_cstring(&self) -> Result<CString, AllocError> {
+        CString::try_from(self)
+    }
 }
 
 impl fmt::Display for CStr {
@@ -584,6 +591,21 @@ impl Deref for CString {
     }
 }
 
+impl<'a> TryFrom<&'a CStr> for CString {
+    type Error = AllocError;
+
+    fn try_from(cstr: &'a CStr) -> Result<CString, AllocError> {
+        let mut buf = Vec::new();
+
+        buf.try_extend_from_slice(cstr.as_bytes_with_nul())
+            .map_err(|_| AllocError)?;
+
+        // INVARIANT: The `CStr` and `CString` types have the same invariants for
+        // the string data, and we copied it over without changes.
+        Ok(CString { buf })
+    }
+}
+
 /// A convenience alias for [`core::format_args`].
 #[macro_export]
 macro_rules! fmt {

base-commit: ea76e08f4d901a450619831a255e9e0a4c0ed162
-- 
2.40.1.521.gf1e218fcd8-goog

