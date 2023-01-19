Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA25667402E
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 18:41:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbjASRld (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 12:41:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbjASRlW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 12:41:22 -0500
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0AE2798F9;
        Thu, 19 Jan 2023 09:41:08 -0800 (PST)
Received: by mail-oi1-x22c.google.com with SMTP id v17so2297841oie.5;
        Thu, 19 Jan 2023 09:41:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NO/tLxVBmWB1dJAexFMTC87LMSP1V8gc/xUgEhy6fvI=;
        b=YBF/bv8HlX6jUtB0z4bb1xtYgg4EdDkd80BPaxQb8LIoAa6fmzgul3M6qSS5yRI8Cy
         fGIybIuQB5cT1uuCDHK3kr9/mIHcetjAftYjO88JzxaBX8e5VWpkkxPeu/gwtlmfwySs
         VUy4NLBcyyxcgsWBDrf78+meibyXGyuM4zzRsXhSpU5LrIWbeXMSjwbopFHonDvUeJag
         pYYIYKAD2jAqT2JzLQLfu5E1Iqk6teivVTyqrFiOhABiX1/yEc8lpFrYnFfj3TUGHiVK
         m88jKaFFsb/qKwQ0K9mlhfcJlgzHvGqzU1zR+vl0tVUIbsbu5f7FqlHMeSgZQqyTghny
         OCJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NO/tLxVBmWB1dJAexFMTC87LMSP1V8gc/xUgEhy6fvI=;
        b=ZZ0MyAIDcewrtMHq9udoGHkTzPVtU9QbsqSRRaKXKC+ExaalGiOo6EH1H1CFcowBcz
         0x0kf/268TS7b+w/DY6P3Q+7so51m4lH4FdbYlPOLAd88ZNMtZdxKvAlPm+YMJE/hnT+
         F4XSFWJPskaLw7tqCPvvP+TZ9OdMVW2B92BQwIz+YBYfDlTdTIp7EmSRWEAzz2Dc4ncO
         tFfh4/CgrRWWUBYHjAxXwt+vR8WKnURE5cZ/ElAXwPGXX/Md9hIyhngeJ2tW6NgE9g3x
         ose5x9e000yQ2e9G8iMqTcM504nkGEYEsbsfy1BoGJlnGyjmSAtgpAUsTEf4xnR+s3qx
         Cgzg==
X-Gm-Message-State: AFqh2kq0s8BI8EsZ/DrzAH/0hC2vM+uQUUs1jKmEsYArmjiaxGx9rts5
        FmBLlbdoPeOEyZyyAvtTlyVCXar7Lh729VYj
X-Google-Smtp-Source: AMrXdXskw501h0ljeQ3C8gqSyvaricDgJIhUCASkVXIEtghgC/7d5sbGv2Ohb6k11uwc37KXy/RjWw==
X-Received: by 2002:aca:1710:0:b0:36e:b552:1ec3 with SMTP id j16-20020aca1710000000b0036eb5521ec3mr576626oii.38.1674150068191;
        Thu, 19 Jan 2023 09:41:08 -0800 (PST)
Received: from wedsonaf-dev.home.lan ([189.124.190.154])
        by smtp.googlemail.com with ESMTPSA id i7-20020a056808054700b003631fe1810dsm10226906oig.47.2023.01.19.09.41.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 09:41:08 -0800 (PST)
From:   Wedson Almeida Filho <wedsonaf@gmail.com>
To:     rust-for-linux@vger.kernel.org
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
        linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <wedsonaf@gmail.com>
Subject: [PATCH 4/5] rust: types: implement `ForeignOwnable` for the unit type
Date:   Thu, 19 Jan 2023 14:40:35 -0300
Message-Id: <20230119174036.64046-4-wedsonaf@gmail.com>
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

This allows us to use the unit type `()` when we have no object whose
ownership must be managed but one implementing the `ForeignOwnable`
trait is needed.

Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
---
 rust/kernel/types.rs | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
index e037c262f23e..8f80cffbff59 100644
--- a/rust/kernel/types.rs
+++ b/rust/kernel/types.rs
@@ -85,6 +85,19 @@ impl<T: 'static> ForeignOwnable for Box<T> {
     }
 }
 
+impl ForeignOwnable for () {
+    type Borrowed<'a> = ();
+
+    fn into_foreign(self) -> *const core::ffi::c_void {
+        // We use 1 to be different from a null pointer.
+        1usize as _
+    }
+
+    unsafe fn borrow<'a>(_: *const core::ffi::c_void) -> Self::Borrowed<'a> {}
+
+    unsafe fn from_foreign(_: *const core::ffi::c_void) -> Self {}
+}
+
 /// Runs a cleanup function/closure when dropped.
 ///
 /// The [`ScopeGuard::dismiss`] function prevents the cleanup function from running.
-- 
2.34.1

