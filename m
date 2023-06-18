Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FDF97346F1
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jun 2023 18:16:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbjFRQQT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jun 2023 12:16:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjFRQQS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jun 2023 12:16:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4711E1AB;
        Sun, 18 Jun 2023 09:16:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D6E60612A5;
        Sun, 18 Jun 2023 16:16:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD367C433C8;
        Sun, 18 Jun 2023 16:16:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687104972;
        bh=LheThdeDVN84aRUG/RORjdWuXRzKBo9kbyrfOkt+tMk=;
        h=From:To:Cc:Subject:Date:From;
        b=ZX3N1MkkwdJZq8Wm4ycvLs9rPgdBZKHnZDDx2C/TMM2epMMKCZjAz+52Nw3IOvGs1
         pwSEIQJjwTaBy/f7G6QvXzHc1xIBsqPZe04ubxXJOzWbempR0F/0msCiT0XbLRVt0U
         86M7G5i6gHe8CCK+Osug2+I/r5hFeFsJKGoDSFFUYS9iXQrbEzEIwZ6eRhGPttnZ7y
         GTMoTNOvho9+nzMdG9i1lWHQV4xzJGX3AFuNKysy4gECevIuiICA6c0J25OvmqoebE
         pONhzECIprzeTjwVDibfwPAl6xkA+py/fNFEokmNn8mSldyIb192x8tTiavJK/xwf0
         f8Yo+ylcgcpTA==
From:   Miguel Ojeda <ojeda@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Rust for 6.5
Date:   Sun, 18 Jun 2023 18:15:58 +0200
Message-ID: <20230618161558.1051269-1-ojeda@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

This is the next round of the Rust support.

All commits have been in linux-next for more than 2 weeks, except the
last which has been there for 4 days.

No conflicts expected. No changes to the C side.

Please pull for v6.5 -- thanks!

Cheers,
Miguel


The following changes since commit 7877cb91f1081754a1487c144d85dc0d2e2e7fc4:

  Linux 6.4-rc4 (2023-05-28 07:49:00 -0400)

are available in the Git repository at:

  https://github.com/Rust-for-Linux/linux.git tags/rust-6.5

for you to fetch changes up to d2e3115d717197cb2bc020dd1f06b06538474ac3:

  rust: error: `impl Debug` for `Error` with `errname()` integration (2023-06-13 01:24:42 +0200)

----------------------------------------------------------------
Rust changes for v6.5

A fairly small one in terms of feature additions. Most of the changes in
terms of lines come from the upgrade to the new version of the toolchain
(which in turn is big due to the vendored 'alloc' crate).

 - Upgrade to Rust 1.68.2:

   This is the first such upgrade, and we will try to update it often
   from now on, in order to remain close to the latest release, until
   a minimum version (which is "in the future") can be established.

   The upgrade brings the stabilization of 4 features we used (and 2
   more that we used in our old 'rust' branch).

   Commit 3ed03f4da06e ("rust: upgrade to Rust 1.68.2") contains the
   details and rationale.

 - pin-init API:

   Several internal improvements and fixes to the pin-init API, e.g.
   allowing to use 'Self' in a struct definition with '#[pin_data]'.

 - 'error'  module:

   New 'name()' method for the 'Error' type (with 'errname()'
   integration), used to implement the 'Debug' trait for 'Error'.

   Add error codes from 'include/linux/errno.h' to the list of Rust
   'Error' constants.

   Allow specifying error type on the 'Result' type (with the default
   still being our usual 'Error' type).

 - 'str' module:

   'TryFrom' implementation for 'CStr', and new 'to_cstring()' method
   based on it.

 - 'sync' module:

   Implement 'AsRef' trait for 'Arc', allowing to use 'Arc' in code that
   is generic over smart pointer types.

   Add 'ptr_eq' method to 'Arc' for easier, less error prone comparison
   between two 'Arc' pointers.

   Reword the 'Send' safety comment for 'Arc', and avoid referencing it
   from the 'Sync' one.

 - 'task' module:

   Implement 'Send' marker for 'Task'.

 - 'types' module:

   Implement 'Send' and 'Sync' markers for 'ARef<T>' when 'T' is
   'AlwaysRefCounted', 'Send' and 'Sync'.

 - Other changes:

   Documentation improvements and '.gitattributes' change to start
   using the Rust diff driver.

----------------------------------------------------------------
Alice Ryhl (9):
      rust: error: allow specifying error type on `Result`
      rust: str: add conversion from `CStr` to `CString`
      rust: error: add missing error codes
      rust: sync: add `Arc::ptr_eq`
      rust: sync: implement `AsRef<T>` for `Arc<T>`
      rust: sync: reword the `Arc` safety comment for `Send`
      rust: sync: reword the `Arc` safety comment for `Sync`
      rust: specify when `ARef` is thread safe
      rust: task: add `Send` marker to `Task`

Benno Lossin (4):
      rust: macros: fix usage of `#[allow]` in `quote!`
      rust: macros: refactor generics parsing of `#[pin_data]` into its own function
      rust: macros: replace Self with the concrete type in #[pin_data]
      rust: init: update macro expansion example in docs

Gary Guo (1):
      rust: error: `impl Debug` for `Error` with `errname()` integration

Miguel Ojeda (5):
      rust: alloc: clarify what is the upstream version
      rust: arc: fix intra-doc link in `Arc<T>::init`
      rust: upgrade to Rust 1.68.2
      .gitattributes: set diff driver for Rust source code files
      docs: rust: point directly to the standalone installers

 .gitattributes                     |   1 +
 Documentation/process/changes.rst  |   2 +-
 Documentation/rust/quick-start.rst |   4 +-
 rust/alloc/README.md               |   3 +
 rust/alloc/alloc.rs                |  55 +++--
 rust/alloc/boxed.rs                | 446 +++++++++++++++++++++++++++++++++--
 rust/alloc/collections/mod.rs      |   5 +-
 rust/alloc/lib.rs                  |  71 ++++--
 rust/alloc/raw_vec.rs              |  16 +-
 rust/alloc/slice.rs                | 447 +++++------------------------------
 rust/alloc/vec/drain.rs            |  81 ++++++-
 rust/alloc/vec/drain_filter.rs     |  60 ++++-
 rust/alloc/vec/into_iter.rs        | 125 +++++++---
 rust/alloc/vec/is_zero.rs          |  96 +++++++-
 rust/alloc/vec/mod.rs              | 464 ++++++++++++++++++++++++++++---------
 rust/alloc/vec/set_len_on_drop.rs  |   5 +
 rust/alloc/vec/spec_extend.rs      |  63 +----
 rust/bindings/bindings_helper.h    |   1 +
 rust/bindings/lib.rs               |   1 -
 rust/helpers.c                     |   7 +
 rust/kernel/build_assert.rs        |   2 +
 rust/kernel/error.rs               |  61 ++++-
 rust/kernel/init.rs                |   5 +
 rust/kernel/init/macros.rs         |  85 ++++---
 rust/kernel/lib.rs                 |   4 -
 rust/kernel/std_vendor.rs          |   2 +
 rust/kernel/str.rs                 |  22 ++
 rust/kernel/sync/arc.rs            |  25 +-
 rust/kernel/task.rs                |  10 +-
 rust/kernel/types.rs               |  13 ++
 rust/macros/helpers.rs             |  86 ++++++-
 rust/macros/pin_data.rs            | 168 +++++++++-----
 rust/macros/quote.rs               |  14 +-
 rust/uapi/lib.rs                   |   1 -
 scripts/Makefile.build             |   2 +-
 scripts/min-tool-version.sh        |   2 +-
 36 files changed, 1659 insertions(+), 796 deletions(-)
