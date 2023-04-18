Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40A396E6FEF
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 01:31:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231265AbjDRXbw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 19:31:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbjDRXbu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 19:31:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EED8776B6;
        Tue, 18 Apr 2023 16:31:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8A58C62F93;
        Tue, 18 Apr 2023 23:31:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1734BC433EF;
        Tue, 18 Apr 2023 23:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681860696;
        bh=dXrs6HEsN21LvkE2B3upLi4G+i29wmCt/lPdjsvXpGI=;
        h=From:To:Cc:Subject:Date:From;
        b=kHUv3WsqPqzTUjKZj5daYdXJVOeGYPfR+HG/1Ev5CEQ8LdaBAskFK4XARG+8WHt/l
         GRshbswOxIG769iM5hqnzpq+Me6XxQeuva7mJ4pTq26GfkqPkePob7eqP4FjCFoGKj
         YVreXt3MhxRSydf5g8/5BTs4qeLw+dStiJ4bxqgBZehB3XlYIduJUmcsj0fLs2YxKs
         8zM7imnjJv5k5PVMlIrKpk2CRnIf3UhYDigJQ1XRnUJXxBvLly+IlibqKRWYDZDLEA
         P4yKAZZu33mYQriE3r4DblTGy29Q6smgowNEh7YCYmBkJBZ91sSGahWyPJPFjW+p2g
         cko7jlNtKcWhg==
From:   Miguel Ojeda <ojeda@kernel.org>
To:     Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>
Cc:     Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Jean Delvare <jdelvare@suse.de>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev
Subject: [PATCH] .gitattributes: set diff driver for Rust source code files
Date:   Wed, 19 Apr 2023 01:30:48 +0200
Message-Id: <20230418233048.335281-1-ojeda@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Git supports a builtin Rust diff driver [1] since v2.23.0 (2019).

It improves the choice of hunk headers in some cases, such as
diffs within methods, since those are indented in Rust within
an `impl` block, and therefore the default diff driver would
pick the outer `impl` block instead (rather than the method
where the changed code is).

For instance, with the default diff driver:

    @@ -455,6 +455,8 @@ impl fmt::Write for RawFormatter {
             // Amount that we can copy. `saturating_sub` ensures we get 0 if `pos` goes past `end`.
             let len_to_copy = core::cmp::min(pos_new, self.end).saturating_sub(self.pos);

    +        test_diff_driver();
    +
             if len_to_copy > 0 {
                 // SAFETY: If `len_to_copy` is non-zero, then we know `pos` has not gone past `end`
                 // yet, so it is valid for write per the type invariants.

With the Rust diff driver:

    @@ -455,6 +455,8 @@ fn write_str(&mut self, s: &str) -> fmt::Result {
             // Amount that we can copy. `saturating_sub` ensures we get 0 if `pos` goes past `end`.
             let len_to_copy = core::cmp::min(pos_new, self.end).saturating_sub(self.pos);

    +        test_diff_driver();
    +
             if len_to_copy > 0 {
                 // SAFETY: If `len_to_copy` is non-zero, then we know `pos` has not gone past `end`
                 // yet, so it is valid for write per the type invariants.

Thus set the `rust` diff driver for `*.rs` source files.

Link: https://git-scm.com/docs/gitattributes#_defining_a_custom_hunk_header [1]
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 .gitattributes | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.gitattributes b/.gitattributes
index c9ba5bfc4036..2325c529e185 100644
--- a/.gitattributes
+++ b/.gitattributes
@@ -2,3 +2,4 @@
 *.[ch] diff=cpp
 *.dts diff=dts
 *.dts[io] diff=dts
+*.rs diff=rust

base-commit: 09a9639e56c01c7a00d6c0ca63f4c7c41abe075d
-- 
2.40.0

