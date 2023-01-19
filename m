Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFEB467402D
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 18:41:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230295AbjASRla (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 12:41:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbjASRlV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 12:41:21 -0500
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DACEC8BABC;
        Thu, 19 Jan 2023 09:41:05 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id i5so2273429oih.11;
        Thu, 19 Jan 2023 09:41:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wGMIqOBRVBwOZ5uyAthUJactG+QhEC2sAl1iIa6Sq0Y=;
        b=Ri4BGOfnQOaAKbc9bsyJzNBXcozXCwdE3vwshewu1Uw/45388Y1AnLUr0W6yjWzeQy
         r8Ja2PwxVoRtn3538cqmTsUfue1Q3PLgQbIQe1z9tNRbdie48JAf5V5rbeqUhk405IRz
         K00/7flOo9EVO9c1Q38l+6BWXt1klpjeFTyBZqHVifxYHG4mpBa0Xipy41z++9UnGY7f
         5JZ5gcVizyM5QJgeobaZpxlODIpA09ohumDP0eihN1QChtKrieux5kwhx3RSBRfrFxJh
         iA/0Goj5GdtyhqBi+ctA03dkPXFvMDUsWbkn2rfV78L6QJQK6PAhoxp7SA9YvpSLkgrQ
         dVDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wGMIqOBRVBwOZ5uyAthUJactG+QhEC2sAl1iIa6Sq0Y=;
        b=DkSVoaOaD/n2pM0dOirrQ/io8BT/peCjUioR9fq58pAcW/K+aMrmRFjnJbVkdKUjU0
         gUclPGd19ZU08Jn8baH0ghN0caAWQkv+1yf36jwnwu8PK78en4/V/BimywRYiRj2i2ON
         aanuLxC3Jv8aJe8IxJuZCAtTqHflroDm84NgZWyTDuIS2CPqjd29Y2i9UCzEjqdnaf5O
         SyFnr2qOy4TKwMs8TxRkImRtg6sJsgxXSTljpBOeljkAlVUzXo+1XRsna84UfxaywfXv
         PJOyDkhHmgJ8rcY0w/fsawPEtVtQSWA5o2GrmBZIi6TaEZscEEV9Ct3XM5mvkJga/7bR
         mnsQ==
X-Gm-Message-State: AFqh2kqK0lTY/NfmMXPO2AJFXyLc5YmNufkcWCsz7X1zIFYk5/QBmcyt
        nSFXfa9tG2KCoU4q1ZoxFE4obdheNiaPVwfQ
X-Google-Smtp-Source: AMrXdXtBy7x19i00rqANu3EnwrPCvgO2sfa1l0lEkr/eN55j/MkW7CxJ2Nw5/0uFJoeG8Jc/cFhq/g==
X-Received: by 2002:aca:1c09:0:b0:367:18f4:dbef with SMTP id c9-20020aca1c09000000b0036718f4dbefmr5472968oic.0.1674150065168;
        Thu, 19 Jan 2023 09:41:05 -0800 (PST)
Received: from wedsonaf-dev.home.lan ([189.124.190.154])
        by smtp.googlemail.com with ESMTPSA id i7-20020a056808054700b003631fe1810dsm10226906oig.47.2023.01.19.09.41.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 09:41:04 -0800 (PST)
From:   Wedson Almeida Filho <wedsonaf@gmail.com>
To:     rust-for-linux@vger.kernel.org
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
        linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <wedsonaf@gmail.com>
Subject: [PATCH 3/5] rust: types: implement `ForeignOwnable` for `Box<T>`
Date:   Thu, 19 Jan 2023 14:40:34 -0300
Message-Id: <20230119174036.64046-3-wedsonaf@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230119174036.64046-1-wedsonaf@gmail.com>
References: <20230119174036.64046-1-wedsonaf@gmail.com>
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

This allows us to hand ownership of Rust dynamically allocated
objects to the C side of the kernel.

Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
---
 rust/kernel/types.rs | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
index 5475f6163002..e037c262f23e 100644
--- a/rust/kernel/types.rs
+++ b/rust/kernel/types.rs
@@ -63,6 +63,28 @@ pub trait ForeignOwnable {
     unsafe fn from_foreign(ptr: *const core::ffi::c_void) -> Self;
 }
 
+impl<T: 'static> ForeignOwnable for Box<T> {
+    type Borrowed<'a> = &'a T;
+
+    fn into_foreign(self) -> *const core::ffi::c_void {
+        Box::into_raw(self) as _
+    }
+
+    unsafe fn borrow<'a>(ptr: *const core::ffi::c_void) -> &'a T {
+        // SAFETY: The safety requirements for this function ensure that the object is still alive,
+        // so it is safe to dereference the raw pointer.
+        // The safety requirements of `from_foreign` also ensure that the object remains alive for
+        // the lifetime of the returned value.
+        unsafe { &*ptr.cast() }
+    }
+
+    unsafe fn from_foreign(ptr: *const core::ffi::c_void) -> Self {
+        // SAFETY: The safety requirements of this function ensure that `ptr` comes from a previous
+        // call to `Self::into_foreign`.
+        unsafe { Box::from_raw(ptr as _) }
+    }
+}
+
 /// Runs a cleanup function/closure when dropped.
 ///
 /// The [`ScopeGuard::dismiss`] function prevents the cleanup function from running.
-- 
2.34.1

