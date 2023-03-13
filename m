Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A32B86B6D0C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 02:23:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbjCMBXC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 21:23:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbjCMBW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 21:22:59 -0400
Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F48012E
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 18:22:55 -0700 (PDT)
Date:   Mon, 13 Mar 2023 01:22:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1678670567; x=1678929767;
        bh=8JDf4Eklx3nC7W1bhw1n1uLJ99rwzcE6YOLk5j3je2E=;
        h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
         Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
        b=Dn0A4kYODpwMSO1GM/pni6FLrtz15KvEgoxkR3Z84SjclMB8wYhHJlAFwLrF4q6jd
         rVrab21R05z5qN4EJsbbxg2wAebxfGfCDvHL9RNPWPDMhzEpzeJ2xeYFQ7S2mV6rx8
         CP3qnUzMbCoTQl+MiEch7LiCDjKLDxBvULERZsa7HFcSsgu6YCbfoT7AQA12LciSNO
         d5iAne3Wf+lRt+/GLv6iBEFtuGJuH8OO/KCVOkEND2KIHG2wDFZLoYnu0FghNZ/BNz
         oPKg9Al4dA3j1NITMoHZMzv5viJD5kVz4DrirL6o+u4GFuhETh0TapO4OT8RNgz0Lc
         vnfNAQ32WBOWw==
To:     "ojeda@kernel.org" <ojeda@kernel.org>,
        "alex.gaynor@gmail.com" <alex.gaynor@gmail.com>,
        "wedsonaf@gmail.com" <wedsonaf@gmail.com>,
        "boqun.feng@gmail.com" <boqun.feng@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        "bjorn3_gh@protonmail.com" <bjorn3_gh@protonmail.com>
From:   y86-dev <y86-dev@protonmail.com>
Cc:     "rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: [PATCH v1 0/3] Rust pin-init API for pinned initialization of structs
Message-ID: <Bk4Yd1TBtgoLg2g_c37V3c_Wt30FMS89z7LrjnfadhDquwG_0dUGz1c_9BlMDmymg0tCACBpmCw-wZxlg4Jl4W2gkorh5P78ePgSnJVR5cU=@protonmail.com>
Feedback-ID: 40624463:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds the pin-init API for initializing pinned structs in-place.
It reduces the need for `unsafe` and streamlines initialization of structs.

The first patch adds a utility macro `quote!` for proc-macros. This macro
converts the typed characters directly into Rust tokens that are the output
of proc-macros. It is used by the pin-init API.

The second patch introduces the pin-init API. The commit message details
the problem it solves and lays out the overall architecture. The
implementation details are fairly complex; however, this is required to
provide a safe API for users -- reducing the amount of `unsafe` code is a
key goal of the Rust support in the kernel. An example of the before/after
difference from the point of view of users is provided in the commit
message. Ultimately, it is a goal is to at some point have this as a
language feature of Rust. A first step in this direction is the Field
Projection RFC [1].

The third patch improves the function `UniqueArc::try_new_uninit` by using
the pin-init API. The old version first allocated uninitialized memory on
the stack and then moved it into the location in the heap. The new version
directly allocates this on the heap.

These patches provide an important foundation for ergonomic and safe
synchronization primitives and their users. It also enables in-place
initialization of structs, so structs with a bigger size than the stack
size can be created.

These patches are also a long way coming, since I held a presentation on
safe pinned initialization at Kangrejos [2]. And my discovery of this
problem was almost a year ago [3].

The repository at [4] contains these patches applied. The Rust-doc
documentation of the pin-init API can be found at [5].

Link: https://github.com/rust-lang/rfcs/pull/3318 [1]
Link: https://kangrejos.com [2]
Link: https://github.com/Rust-for-Linux/linux/issues/772 [3]
Link: https://github.com/y86-dev/linux.git patch/pinned-init-v1 [4]
Link: https://rust-for-linux.github.io/docs/pinned-init/kernel/init [5]

Benno Lossin (2):
  rust: add pin-init API
  rust: sync: reduce stack usage of `UniqueArc::try_new_uninit`

Gary Guo (1):
  rust: macros: add `quote!` macro

 rust/kernel/init.rs        | 1396 ++++++++++++++++++++++++++++++++++++
 rust/kernel/init/common.rs |   42 ++
 rust/kernel/init/macros.rs |  449 ++++++++++++
 rust/kernel/lib.rs         |    6 +
 rust/kernel/prelude.rs     |    6 +-
 rust/kernel/sync/arc.rs    |   48 +-
 rust/kernel/types.rs       |    8 +
 rust/macros/lib.rs         |   80 +++
 rust/macros/pin_data.rs    |   79 ++
 rust/macros/pinned_drop.rs |   49 ++
 rust/macros/quote.rs       |  125 ++++
 scripts/Makefile.build     |    2 +-
 12 files changed, 2286 insertions(+), 4 deletions(-)
 create mode 100644 rust/kernel/init.rs
 create mode 100644 rust/kernel/init/common.rs
 create mode 100644 rust/kernel/init/macros.rs
 create mode 100644 rust/macros/pin_data.rs
 create mode 100644 rust/macros/pinned_drop.rs
 create mode 100644 rust/macros/quote.rs


base-commit: fe15c26ee26efa11741a7b632e9f23b01aca4cc6
--=20
2.39.2

