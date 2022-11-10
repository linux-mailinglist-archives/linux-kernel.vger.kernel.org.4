Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF8D0624759
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 17:44:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232513AbiKJQo4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 11:44:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232516AbiKJQoR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 11:44:17 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7295C450B4;
        Thu, 10 Nov 2022 08:43:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 11C77B82251;
        Thu, 10 Nov 2022 16:43:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA8D4C433B5;
        Thu, 10 Nov 2022 16:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668098603;
        bh=I3b0Z7RHs3m0QbSSsLLKwiQESMTWz+K564vWJV2JsjA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Yp/6XFlz+k04kCIlhS2B7ArlTF8uHXzFiMTnjRyUTjiwb4202IV8ifYnWqDb0mU+G
         yfICCMeY46vT+WeRhUyJuToCRSCPgt8qdqSJuizlKRzNeflPzGSyO/ZCEuIfhErpGM
         0COeovEJQIyeGhyYcArZACHaQFby9VJdFW80t+7Lcmzb/3G0P4ocVCPY+V3gZ0u6y2
         YorzeDzm32SzM8hpLKcB59M8689V8Pmgh2d7CpI6V67oa3UqYcuCAJXiY5/RQU7KM2
         Vix8vowoVr8xSF7f1Ui7Ed8/AV7G7x/zteQ5HQSxeAqg5bTmc7Md0hsusR7qwG2E+1
         FUW9QoBga1rQw==
From:   Miguel Ojeda <ojeda@kernel.org>
To:     Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev
Subject: [PATCH v1 22/28] rust: str: add `fmt!` macro
Date:   Thu, 10 Nov 2022 17:41:34 +0100
Message-Id: <20221110164152.26136-23-ojeda@kernel.org>
In-Reply-To: <20221110164152.26136-1-ojeda@kernel.org>
References: <20221110164152.26136-1-ojeda@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wedson Almeida Filho <wedsonaf@gmail.com>

Add the `fmt!` macro, which is a convenience alias for the Rust
`core::format_args!` macro.

For instance, it may be used to create a `CString`:

    CString::try_from_fmt(fmt!("{}{}", "abc", 42))?

Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
[Reworded, adapted for upstream and applied latest changes]
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 rust/kernel/str.rs | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
index 877148b77e71..ffac633423db 100644
--- a/rust/kernel/str.rs
+++ b/rust/kernel/str.rs
@@ -592,3 +592,9 @@ impl Deref for CString {
         unsafe { CStr::from_bytes_with_nul_unchecked(self.buf.as_slice()) }
     }
 }
+
+/// A convenience alias for [`core::format_args`].
+#[macro_export]
+macro_rules! fmt {
+    ($($f:tt)*) => ( core::format_args!($($f)*) )
+}
-- 
2.38.1

