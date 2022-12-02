Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14BDC640A6B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 17:17:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233413AbiLBQRO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 11:17:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233904AbiLBQQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 11:16:31 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4A3FD96A5;
        Fri,  2 Dec 2022 08:16:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 717F062321;
        Fri,  2 Dec 2022 16:16:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF922C433D6;
        Fri,  2 Dec 2022 16:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669997768;
        bh=H8GrOu07IRuGrUGFNBmi30U0LGPQsGBzhM2gPsNjUkU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GSXqOdyvoi8n6XgrzYEVF4fhRH5tBbsPS7tPg3IrH4f/YUi3ehHMrKcQl2ulQ/Kop
         XEQoyYJuaPY9MWeMLa5swvgmArnT5mNqjne8069nzMrXH9An5X8Hsv9aa4fgWZruPw
         v5eiihrOunn5lnROLNG7vBCwouR95qcm+C7ctlR14lAs3iewozoi8RA31YmSBBfxzK
         KoOcheBvdRW7gelraQ/dzHya7zURlnBmn9909XlxyvrIg/Wg01jxUpxIOZDgXp8toF
         Q4DmdoaBMRV26zZjzNGTpwLmKwOx7hT1Fm6cKp2FDR/3/ZQAx/yZ6nnOrJ6EyUM/A8
         wc7KBED35y1cw==
From:   ojeda@kernel.org
To:     Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev
Subject: [PATCH v2 14/28] rust: str: add `BStr` type
Date:   Fri,  2 Dec 2022 17:14:45 +0100
Message-Id: <20221202161502.385525-15-ojeda@kernel.org>
In-Reply-To: <20221202161502.385525-1-ojeda@kernel.org>
References: <20221202161502.385525-1-ojeda@kernel.org>
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

From: Gary Guo <gary@garyguo.net>

Add the `BStr` type, which is a byte string without UTF-8
validity guarantee.

It is simply an alias to `[u8]`, but has a more evident
semantical meaning.

Signed-off-by: Gary Guo <gary@garyguo.net>
[Reworded, adapted for upstream and applied latest changes]
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 rust/kernel/str.rs | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
index e45ff220ae50..3aa1a0cb9bf8 100644
--- a/rust/kernel/str.rs
+++ b/rust/kernel/str.rs
@@ -4,6 +4,11 @@
 
 use core::fmt;
 
+/// Byte string without UTF-8 validity guarantee.
+///
+/// `BStr` is simply an alias to `[u8]`, but has a more evident semantical meaning.
+pub type BStr = [u8];
+
 /// Allows formatting of [`fmt::Arguments`] into a raw buffer.
 ///
 /// It does not fail if callers write past the end of the buffer so that they can calculate the
-- 
2.38.1

