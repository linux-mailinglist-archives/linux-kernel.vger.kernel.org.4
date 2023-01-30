Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0133680624
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 07:45:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235860AbjA3GpI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 01:45:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235835AbjA3Gop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 01:44:45 -0500
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D737013DF8;
        Sun, 29 Jan 2023 22:44:40 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id dt8so6166611oib.0;
        Sun, 29 Jan 2023 22:44:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1+8DLLeJL2vbcZ/1sx6aN3cI3SB5furv18W3lUJcflM=;
        b=TfF3Ypmncs4V09HuumYfpFm2C0xZDaLKRAETSnCb/bJZmvUNrMXwDR1J/l2c+VxFAJ
         VBfW1vtGgiOBjxi4NWhvcIR2B52khFq6DOz4uCVsmIcUXJ7izYbDofHb5RnENJhF4ogR
         gbq94kf5XPsGkRU5sDtpAyCRrtfy8/YVeNt2nWXhlU4VbBJNiwVTDNYoP/4G+DNpIpVF
         W3MIZA7jAKnuiMoxDcbA7uG/Lm7wFs1nBXQssgXV+OcpwhasNu5LuEhF+GKI9TI4TnaL
         08Uv8P2uQdUAqTDOPv9MFFKhegpm6H0ByTzb0Ng4PySW/1r8wclHhhpNtjd5oMBhxOkU
         qsFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1+8DLLeJL2vbcZ/1sx6aN3cI3SB5furv18W3lUJcflM=;
        b=SGfIV6y+/L8vmFoH2NGTdzpyL0LpeczeUFcTMIX3MJG8HlCgNlaZMzIDYP5kLOowj7
         14G4MpXw5QH9f/PGw2U0fPHlOjPbfMcaeIltCmlqI6Dam+3ystos0DGPWPEudWh3DXoy
         OQFiQ/tZ4f+X5tEKW0hkK3yHUyAFr+kJydGvwL3Cup/76OyGZC1BEPnnbCvFc/QutqK5
         7ZqT5bFLtiPHVjKOzeSUG/aInXnJVaxbHeyQjMsIQ3wcekLepzXyLPPGq190oLyY2G2T
         OhDJOpmVSuFAWxgpB/9sL6wJjHSr/pebeu2XU2tXzimcVTYNZwwehmdPue/hn4azlLbl
         1xzw==
X-Gm-Message-State: AFqh2kqEsZdYSVaorrKPQfYDrJ9Q2kUisZLHrIozZIrEopFUK2alLjGO
        LApA5atJg/0EolMq79nGsAUovrzNc7h0aTuw
X-Google-Smtp-Source: AMrXdXsqXksFeqIf0u+mkDVkznchBvNUchbI0L5flmmSkVkUUKA8R5mXQH/K9Kmlz0NRLOc/l+oObw==
X-Received: by 2002:aca:d80b:0:b0:366:bfc6:4a78 with SMTP id p11-20020acad80b000000b00366bfc64a78mr19838189oig.20.1675061080625;
        Sun, 29 Jan 2023 22:44:40 -0800 (PST)
Received: from wedsonaf-dev.home.lan ([189.124.190.154])
        by smtp.googlemail.com with ESMTPSA id o64-20020aca5a43000000b003670342726fsm4427883oib.12.2023.01.29.22.44.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Jan 2023 22:44:40 -0800 (PST)
From:   Wedson Almeida Filho <wedsonaf@gmail.com>
To:     rust-for-linux@vger.kernel.org
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
        linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Vincenzo Palazzo <vincenzopalazzodev@gmail.com>
Subject: [PATCH v2 4/5] rust: types: implement `ForeignOwnable` for the unit type
Date:   Mon, 30 Jan 2023 03:44:03 -0300
Message-Id: <20230130064404.744600-4-wedsonaf@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230130064404.744600-1-wedsonaf@gmail.com>
References: <20230130064404.744600-1-wedsonaf@gmail.com>
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
Reviewed-by: Vincenzo Palazzo <vincenzopalazzodev@gmail.com>
---
v1 -> v2: use `NonNull::dangling` to generate pointer

 rust/kernel/types.rs | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
index 411655eca3e9..9d0fdbc55843 100644
--- a/rust/kernel/types.rs
+++ b/rust/kernel/types.rs
@@ -85,6 +85,18 @@ impl<T: 'static> ForeignOwnable for Box<T> {
     }
 }
 
+impl ForeignOwnable for () {
+    type Borrowed<'a> = ();
+
+    fn into_foreign(self) -> *const core::ffi::c_void {
+        core::ptr::NonNull::dangling().as_ptr()
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

