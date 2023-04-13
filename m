Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3F946E0AFC
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 12:02:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbjDMKCb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 06:02:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjDMKC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 06:02:29 -0400
X-Greylist: delayed 3953 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 13 Apr 2023 03:02:24 PDT
Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79F69769F
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 03:02:24 -0700 (PDT)
Date:   Thu, 13 Apr 2023 10:02:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
        s=protonmail; t=1681380142; x=1681639342;
        bh=/LzrCvKWuttehRbr4lZ5bedwD/eeW7ZCBjqk7BUNs+k=;
        h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
         Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
        b=Xn5XEEgYc1xZID1fuj344NeCVTTfaQ56EKzp+TREShH8fUdswG1dNguf1vEBJfjIm
         7SsZADL3IhkWKFRTQ1S92wSHIh6fwxWljZFn9QKmu8Bf30Bi4UbJ3p5rja22y8tgkV
         Q7UKKKX+0S+5v6x9mI92EM4WF7Bsoh8ePyuoRoLyq4OrorvzpocLm9EqLbLKmRqeKy
         fDAiaFXlgnmUljLmLkNRzCvIWbpHEEHgPAXBUKrLbK3vKGQ8+0LGjWKL91rNnJTCm5
         66//yBv3ZMDx4Ct77hsN12n5OxMLlVN2l4jMHX6+eVEf9mQpZX//aPCTb0Q01kv+f9
         i+HBgf55RXPfg==
To:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>
From:   Benno Lossin <benno.lossin@proton.me>
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Benno Lossin <benno.lossin@proton.me>
Subject: [PATCH] rust: init: broaden the blanket impl of `Init`
Message-ID: <20230413100157.740697-1-benno.lossin@proton.me>
Feedback-ID: 71780778:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This makes it possible to use `T` as a `impl Init<T, E>` for every error
type `E` instead of just `Infallible`.

Signed-off-by: Benno Lossin <benno.lossin@proton.me>
---

@Miguel: you can squash this patch into 90e53c5e70a69 or put it on top of
rust-next.

 rust/kernel/init.rs | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/init.rs b/rust/kernel/init.rs
index a1298c8bbda0..4ebfb08dab11 100644
--- a/rust/kernel/init.rs
+++ b/rust/kernel/init.rs
@@ -1190,8 +1190,8 @@ pub fn uninit<T, E>() -> impl Init<MaybeUninit<T>, E>=
 {
 }

 // SAFETY: Every type can be initialized by-value.
-unsafe impl<T> Init<T> for T {
-    unsafe fn __init(self, slot: *mut T) -> Result<(), Infallible> {
+unsafe impl<T, E> Init<T, E> for T {
+    unsafe fn __init(self, slot: *mut T) -> Result<(), E> {
         unsafe { slot.write(self) };
         Ok(())
     }

base-commit: 1944caa8e8dcb2d93d99d8364719ad8d07aa163f
--
2.39.2


