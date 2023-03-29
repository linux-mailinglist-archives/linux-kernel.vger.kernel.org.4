Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A5946CF666
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 00:33:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbjC2WdH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 18:33:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbjC2WdE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 18:33:04 -0400
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44DB94C09;
        Wed, 29 Mar 2023 15:33:01 -0700 (PDT)
Date:   Wed, 29 Mar 2023 22:32:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1680129178; x=1680388378;
        bh=wUME1cBbBgvvARESXv93SSUi2UbZmqNJXbfHf+FZUn4=;
        h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
         Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
        b=NajYJ6A+8/PgRzeqinlthVpgoTHd96zpYoEr8+lwmEE/kpLZdFVtKhYoXXvaWkQgU
         iH/qpRS9h5dNhQG+6OjAWSkm98uiz1TWI/3V8r/AqgNuSBZahrgr48chKhOZxEW3Uu
         pcO7k0cZZ5YSo+WIhdrIn2xXtGQQ8KshvRP63c1kcqnwmKU+nE8mFjOBtGHyQgBOye
         1ayGskHSB+xf55jaxNOZdufuri23KtslKuUdIzS0Jt/2LU91QBsLBbwRDu7R+jZC2e
         ReEFcKTAwX8sdzLVjVF0KdyafPz8dsnHFMv5V5tb0aBF/Qr51B3YV57EKt2fWE9LCq
         9QYFx1HHWP7CA==
To:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Alice Ryhl <alice@ryhl.io>
From:   y86-dev@protonmail.com
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev
Subject: [PATCH v3 00/13] Rust pin-init API for pinned initialization of structs
Message-ID: <20230329223239.138757-1-y86-dev@protonmail.com>
Feedback-ID: 40624463:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Benno Lossin <y86-dev@protonmail.com>

This is the third version of the pin-init API. See [1] for v2.
This version changes v2 a lot, see the changelog below.

The tree at [2] contains these patches applied on top of 6.3-rc1.
The Rust-doc documentation of the pin-init API can be found at [3].

These patches are a long way coming, since I held a presentation on
safe pinned initialization at Kangrejos [4]. And my discovery of this
problem was almost a year ago [5].

- #1 adds a utility macro `quote!` for proc-macros. This macro converts
  the typed characters directly into Rust tokens that are the output of
  proc-macros. It is used by the pin-init API proc-macros.
- #2 adds the `assume_init` function to `UniqueArc<MaybeUninit<T>>` that
  unsafely assumes the pointee to be initialized and returns a
  `UniqueArc<T>`. `UniqueArc::write` is modified to use this new function.
  Later patches use it as well.
- #3 adds `Opaque::raw_get` to access the value inside of an `Opaque` from
  a raw pointer only.
- #4-9 introduce the pin-init API. The commit message of #4 details the
  problem it solves and lays out the overall architecture. The
  implementation details are fairly complex; however, this is required to
  provide a safe API for users -- reducing the amount of `unsafe` code is a
  key goal of the Rust support in the kernel. An example of the
  before/after difference from the point of view of users is provided in
  the commit message. It is a goal to at some point have pin-init as a
  language feature of Rust. A first step in this direction is the Field
  Projection RFC [6].
- #10 adds important traits and macros from pin-init to the prelude.
- #11 adds functions for easier initialization of `Opaque<T>` via
  FFI and raw pointer initializer functions. This is necessary when writing
  Rust wrappers and will be used by Wedson's `sync` module patches.
- #12 improves the `UniqueArc::try_new_uninit` function by using the
  pin-init API. The old version first allocated uninitialized memory on the
  stack and then moved it into the location in the heap. The new version
  directly allocates this on the heap.
- #13 adds functions for initializing already allocated `UniqueArc`s, this
  will be used by the Android Binder driver.

--

Changelog:

v2 -> v3:
- Split the big original commit into six smaller commits.
- Use `PinnedDrop` in the `RawFoo` code example.
- Move the `init::common::ffi_init` functions to `Opaque::ffi_init`.
- Move all `#[doc(hidden)]`, internal types into the new `__internal`
  module.
- Specify safety guarantees and requirements of the initializer macros.
- Add a detailed example of what the expanded code of the various macros
  looks like.
- Require generics in the initializer macros to use turbofish syntax
  (`::<>`).
- Refactor the internals of the initializer macros, this way they have
  better type inference and generic arguments can be omitted more often.
- Replace `init::from_value` with a blanket impl of the initializer traits
  for ordinary objects.
- Add initializing functions for already allocated `UniqueArc`s.
- Add `Opaque::manual_init` functions akin to `ffi_init`, but they take an
  `extern "Rust" fn` instead.
- Documentation and inline comment improvements.


v1 -> v2:
- split the common module and `UniqueArc::assume_init` into their own
  commits
- change the generics syntax of `pin_init!` to reflect normal struct
  generic syntax
- replace `PinnedDrop::__ensure_no_unsafe_op_in_drop` with an only unsafely
  creatable token
- hide `StackInit<T>` in the docs, because it is internal API
- improve macro internals of `pin_init!` according to Gary's review
- add check for `PhantomPinned` fields without a `#[pin]` attribute in
  `#[pin_data]`, as those fields will not have the intended effect
- add docs to `quote.rs`

[1] https://lore.kernel.org/rust-for-linux/0e9686f2-f30c-89be-0505-fb36f1c0=
a5c5@proton.me/T/#t
[2] https://github.com/y86-dev/linux.git patch/pinned-init-v3
[3] https://rust-for-linux.github.io/docs/pinned-init/kernel/init
[4] https://kangrejos.com
[5] https://github.com/Rust-for-Linux/linux/issues/772
[6] https://github.com/rust-lang/rfcs/pull/3318

Benno Lossin (12):
  rust: sync: add `assume_init` to `UniqueArc`
  rust: types: add `Opaque::raw_get`
  rust: add pin-init API core
  rust: init: add initialization macros
  rust: init/sync: add `InPlaceInit` trait to pin-initialize smart
    pointers
  rust: init: add `PinnedDrop` trait and macros
  rust: init: add `stack_pin_init!` macro
  rust: init: add `Zeroable` trait and `init::zeroed` function
  rust: prelude: add `pin-init` API items to prelude
  rust: types: add common init-helper functions for `Opaque`
  rust: sync: reduce stack usage of `UniqueArc::try_new_uninit`
  rust: sync: add functions for initializing `UniqueArc<MaybeUninit<T>>`

Gary Guo (1):
  rust: macros: add `quote!` macro

 rust/kernel/init.rs            | 1330 ++++++++++++++++++++++++++++++++
 rust/kernel/init/__internal.rs |  195 +++++
 rust/kernel/init/macros.rs     |  970 +++++++++++++++++++++++
 rust/kernel/lib.rs             |    6 +
 rust/kernel/prelude.rs         |    6 +-
 rust/kernel/sync/arc.rs        |   74 +-
 rust/kernel/types.rs           |   55 ++
 rust/macros/lib.rs             |   80 ++
 rust/macros/pin_data.rs        |   79 ++
 rust/macros/pinned_drop.rs     |   49 ++
 rust/macros/quote.rs           |  143 ++++
 scripts/Makefile.build         |    2 +-
 12 files changed, 2984 insertions(+), 5 deletions(-)
 create mode 100644 rust/kernel/init.rs
 create mode 100644 rust/kernel/init/__internal.rs
 create mode 100644 rust/kernel/init/macros.rs
 create mode 100644 rust/macros/pin_data.rs
 create mode 100644 rust/macros/pinned_drop.rs
 create mode 100644 rust/macros/quote.rs


base-commit: fe15c26ee26efa11741a7b632e9f23b01aca4cc6
--
2.39.2


