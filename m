Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 424BE624751
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 17:44:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232473AbiKJQoE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 11:44:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232351AbiKJQn1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 11:43:27 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A58E43AE2;
        Thu, 10 Nov 2022 08:43:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DAF0C61BCB;
        Thu, 10 Nov 2022 16:43:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 678EEC433D7;
        Thu, 10 Nov 2022 16:42:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668098580;
        bh=H8GrOu07IRuGrUGFNBmi30U0LGPQsGBzhM2gPsNjUkU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V1fkxyBuVKLqkXCwarbt2nzk2Gmd07/5IZb172x8K6Iy7ZZK0piYHQxGtjJCvFZ8q
         Egl+ANyi1jtSNOuoAVyMVUn7rSeKu62QUS8uG1yNeqdQ+kDrAWvp82GYOJx0YHKWck
         lr/e+VWXG4RC7ejtRrDSGpYfNpXSBwAGrMQg7Bnb5C0xO19VpGmFTymLBid3wrPtx/
         ZXk7aIs44xhFG4QWSt7kCoxPk9WwPBVZH9uM2K7i/1GcZ2hLuUh1wMR/+dmHhCwbMo
         F+z3N+/Vf2dX4jP31xl7zMAda7Tv7tuUDo4lJ4/4IG64eaxObhRxbFOYk8xUTftZA2
         9AvF7s5SKzNWQ==
From:   Miguel Ojeda <ojeda@kernel.org>
To:     Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev
Subject: [PATCH v1 14/28] rust: str: add `BStr` type
Date:   Thu, 10 Nov 2022 17:41:26 +0100
Message-Id: <20221110164152.26136-15-ojeda@kernel.org>
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

