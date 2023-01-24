Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C84167A332
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 20:36:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234962AbjAXTgr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 14:36:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234845AbjAXTgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 14:36:03 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 354D74DBDC;
        Tue, 24 Jan 2023 11:35:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9839F61341;
        Tue, 24 Jan 2023 19:35:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF14CC433D2;
        Tue, 24 Jan 2023 19:35:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674588932;
        bh=FI8sdn87DZyWe6V23ObZn8cI1npB0wR7omjIIDwMD38=;
        h=From:To:Cc:Subject:Date:From;
        b=Z2vqfhD3xRM1+DCVoa4RlqijS7h9YJzh7ZNUWR2nlUYqi3++CmPx05TYxykSB972q
         THBRk7Wz99xQQ0QX2lTG2BCvAzu703o9PeLBQpWpB2S+MOdKyRU2nvXVg0E5P8oqmL
         nVRKOsv6I2qKpGQvI9VhmqODN10rT367jpFgHScJOoT7JAgzoBdBABiFRp0K4bUHfG
         HyVT9unXunApEwJKn64Ve69jzhDLLCS8Q4VZPMMfonL7D5PsyFvnalcXSAPzlHfKBv
         18UX8yiVVGXRDxLwGTtiSdWosEeBvSW7+vqvDMkYKxLorvJ8vDB8oq/RznjQ6+pn9O
         J72nwl7xAYB3Q==
From:   Miguel Ojeda <ojeda@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Rust fixes for 6.2
Date:   Tue, 24 Jan 2023 20:33:34 +0100
Message-Id: <20230124193334.161057-1-ojeda@kernel.org>
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

Hi Linus,

This is the first "fixes" PR for Rust.

While it may be a bit early to have a "fixes" branch, I guessed it
would not hurt to start practicing how to do things for the future when
we may get actual users. And since the opportunity presented itself,
I wanted to also use this PR to bring up a "policy" topic and ideally
get kernel maintainers to think about it.

The PR contains a fix for a soundness issue, i.e. it closes a hole that
would allow somebody to write safe Rust code that is able to trigger
undefined behavior.

There are no actual cases of callers triggering this, so it is possible
to argue this is not a fix, which is fair. In other words, virtually
all C code suffers from these soundness holes, but obviously they are
not considered bugs. It is precisely this extra "layer" of protection
that Rust gives to source code that we think is valuable to the kernel.

On the other hand, others may argue they want soundness fixes to land,
and possibly even backported to stable, because they may run patched
kernels, out-of-tree modules, etc. and they may want to know if they
have a problem, even if that breaks their build.

Personally, for what is worth, I would support treating them as fixes.
But I do not want to create extra work for others until we have at
least some real users. So perhaps it should not go to stable?

The commit has been in linux-next for a week in a new branch called
rust-fixes. No conflicts expected. No changes to the C side.

Please pull -- thanks!

Cheers,
Miguel

The following changes since commit 5dc4c995db9eb45f6373a956eb1f69460e69e6d4:

  Linux 6.2-rc4 (2023-01-15 09:22:43 -0600)

are available in the Git repository at:

  https://github.com/Rust-for-Linux/linux tags/rust-fixes-6.2

for you to fetch changes up to 6618d69aa129a8fc613e64775d5019524c6f231b:

  rust: print: avoid evaluating arguments in `pr_*` macros in `unsafe` blocks (2023-01-16 00:54:35 +0100)

----------------------------------------------------------------
Rust fixes for v6.2

A soundness fix:

 - Avoid evaluating arguments in 'pr_*' macros in 'unsafe' blocks.

----------------------------------------------------------------
Miguel Ojeda (1):
      rust: print: avoid evaluating arguments in `pr_*` macros in `unsafe` blocks

 rust/kernel/print.rs | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)
