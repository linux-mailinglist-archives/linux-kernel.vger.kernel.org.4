Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5AA76F220B
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 03:24:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347249AbjD2BXx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 21:23:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347161AbjD2BXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 21:23:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97B713A88;
        Fri, 28 Apr 2023 18:23:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0983E61592;
        Sat, 29 Apr 2023 01:23:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C72C7C433EF;
        Sat, 29 Apr 2023 01:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682731425;
        bh=UkoXdKdFd/wlaiuPk7tQXjSFiZN7ZyKUJf4buQLp0Ig=;
        h=From:To:Cc:Subject:Date:From;
        b=lHx9647Z86b86A7PDIUR6+jsVDOVII83Z1iXURVP3RJdUsnNTYPh8L57Bils74sgV
         owBTu087H61BxEv9YRQE4wKtbwriIXkDTb68fstfnZ+udytgyTQcPGMLTha5dDrBHt
         ixQe4q3WfDbNTO34dO4uM2Ml0x1orblwYwp53zLDvwgZZq4rywsmZqWgzNHq8egPrm
         bF5fN91tFm7AyqjLt6e7VAyJF81k8GZ+A37mWLyr/xeNdHDfQy4UUzjyltgu+fWIfU
         t6DOSIlUc9MqZK6E+51KHZwJ63KcQ0o0iFo3J5424GcDw83sr/llv0BVROlwZfJdH6
         bkB+RBurSvr7g==
From:   Miguel Ojeda <ojeda@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Rust for 6.4
Date:   Sat, 29 Apr 2023 03:21:19 +0200
Message-Id: <20230429012119.421536-1-ojeda@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

One more set of core features for the Rust support.

The youngest commits have been in linux-next for 5 rounds; the older
half for 2 weeks.

No conflicts expected. No changes to the C side.

Please pull for v6.4 -- thanks!

Cheers,
Miguel

The following changes since commit 09a9639e56c01c7a00d6c0ca63f4c7c41abe075d:

  Linux 6.3-rc6 (2023-04-09 11:15:57 -0700)

are available in the Git repository at:

  https://github.com/Rust-for-Linux/linux tags/rust-6.4

for you to fetch changes up to ea76e08f4d901a450619831a255e9e0a4c0ed162:

  rust: ioctl: Add ioctl number manipulation functions (2023-04-22 01:46:45 +0200)

----------------------------------------------------------------
Rust changes for v6.4

More additions to the Rust core. Importantly, this adds the pin-init
API, which will be used by other abstractions, such as the
synchronization ones added here too:

  - pin-init API: a solution for the safe pinned initialization problem.
    This allows to reduce the need for 'unsafe' code in the kernel when
    dealing with data structures that require a stable address. Commit
    90e53c5e70a6 ("rust: add pin-init API core") contains a nice
    introduction -- here is an example of how it looks like:

        #[pin_data]
        struct Example {
            #[pin]
            value: Mutex<u32>,

            #[pin]
            value_changed: CondVar,
        }

        impl Example {
            fn new() -> impl PinInit<Self> {
                pin_init!(Self {
                    value <- new_mutex!(0),
                    value_changed <- new_condvar!(),
                })
            }
        }

        // In a `Box`.
        let b = Box::pin_init(Example::new())?;

        // In the stack.
        stack_pin_init!(let s = Example::new());

  - 'sync' module: new types 'LockClassKey' ('struct lock_class_key'),
    'Lock', 'Guard', 'Mutex' ('struct mutex'), 'SpinLock'
    ('spinlock_t'), 'LockedBy' and 'CondVar' (uses 'wait_queue_head_t'),
    plus macros such as 'static_lock_class!' and 'new_spinlock!'.

    In particular, 'Lock' and 'Guard' are generic implementations that
    contain code that is common to all locks. Then, different backends
    (the new 'Backend' trait) are implemented and used to define types
    like 'Mutex':

        type Mutex<T> = Lock<T, MutexBackend>;

    In addition, new methods 'assume_init()', 'init_with()' and
    'pin_init_with()' for 'UniqueArc<MaybeUninit<T>>' and 'downcast()'
    for 'Arc<dyn Any + Send + Sync>'; as well as 'Debug' and 'Display'
    implementations for 'Arc' and 'UniqueArc'. Reduced stack usage of
    'UniqueArc::try_new_uninit()', too.

  - 'types' module: new trait 'AlwaysRefCounted' and new type 'ARef'
    (an owned reference to an always-reference-counted object, meant to
    be used in wrappers for C types that have their own ref counting
    functions).

    Moreover, new associated functions 'raw_get()' and 'ffi_init()'
    for 'Opaque'.

  - New 'task' module with a new type 'Task' ('struct task_struct'), and
    a new macro 'current!' to safely get a reference to the current one.

  - New 'ioctl' module with new '_IOC*' const functions (equivalent to
    the C macros).

  - New 'uapi' crate, intended to be accessible by drivers directly.

  - 'macros' crate: new 'quote!' macro (similar to the one provided in
    userspace by the 'quote' crate); and the 'module!' macro now allows
    specifying multiple module aliases.

  - 'error' module: new associated functions for the 'Error' type,
    such as 'from_errno()' and new functions such as 'to_result()'.

  - 'alloc' crate: more fallible 'Vec' methods: 'try_resize` and
    'try_extend_from_slice' and the infrastructure (imported from
    the Rust standard library) they need.

----------------------------------------------------------------
Asahi Lina (11):
      rust: Enable the new_uninit feature for kernel and driver crates
      rust: Import upstream `alloc::vec::set_len_on_drop` module
      rust: Import upstream `alloc::vec::spec_extend` module
      rust: Add SPDX headers to alloc::vec::{spec_extend, set_len_on_drop}
      rust: macros: Allow specifying multiple module aliases
      rust: sync: arc: Implement Arc<dyn Any + Send + Sync>::downcast()
      rust: sync: arc: Add UniqueArc<MaybeUninit<T>::assume_init()
      rust: error: Rename to_kernel_errno() -> to_errno()
      rust: error: Add Error::to_ptr()
      rust: uapi: Add UAPI crate
      rust: ioctl: Add ioctl number manipulation functions

Benno Lossin (14):
      rust: enable the `pin_macro` feature
      rust: sync: change error type of constructor functions
      rust: types: add `Opaque::raw_get`
      rust: add pin-init API core
      rust: init: add initialization macros
      rust: init/sync: add `InPlaceInit` trait to pin-initialize smart pointers
      rust: init: add `PinnedDrop` trait and macros
      rust: init: add `stack_pin_init!` macro
      rust: init: add `Zeroable` trait and `init::zeroed` function
      rust: prelude: add `pin-init` API items to prelude
      rust: types: add `Opaque::ffi_init`
      rust: sync: reduce stack usage of `UniqueArc::try_new_uninit`
      rust: sync: add functions for initializing `UniqueArc<MaybeUninit<T>>`
      rust: init: broaden the blanket impl of `Init`

Boqun Feng (2):
      rust: sync: impl {Debug,Display} for {Unique,}Arc
      samples: rust: print: Add sample code for Arc printing

Gary Guo (1):
      rust: macros: add `quote!` macro

Miguel Ojeda (3):
      rust: alloc: vec: Add some try_* methods we need
      rust: error: Add Error::from_errno{_unchecked}()
      MAINTAINERS: add Benno Lossin as Rust reviewer

Sven Van Asbroeck (1):
      rust: error: Add a helper to convert a C ERR_PTR to a `Result`

Wedson Almeida Filho (12):
      rust: error: Add to_result() helper
      rust: error: Add from_result() helper
      rust: sync: introduce `LockClassKey`
      rust: sync: introduce `Lock` and `Guard`
      rust: lock: introduce `Mutex`
      rust: lock: introduce `SpinLock`
      rust: introduce `ARef`
      rust: add basic `Task`
      rust: introduce `current`
      rust: sync: introduce `LockedBy`
      rust: lock: add `Guard::do_unlocked`
      rust: sync: introduce `CondVar`

 MAINTAINERS                        |    1 +
 rust/.gitignore                    |    1 +
 rust/Makefile                      |   28 +-
 rust/alloc/vec/mod.rs              |  137 +++-
 rust/alloc/vec/set_len_on_drop.rs  |   30 +
 rust/alloc/vec/spec_extend.rs      |  174 +++++
 rust/bindings/bindings_helper.h    |    2 +
 rust/helpers.c                     |   82 +++
 rust/kernel/error.rs               |  137 +++-
 rust/kernel/init.rs                | 1427 ++++++++++++++++++++++++++++++++++++
 rust/kernel/init/__internal.rs     |  235 ++++++
 rust/kernel/init/macros.rs         |  971 ++++++++++++++++++++++++
 rust/kernel/ioctl.rs               |   72 ++
 rust/kernel/lib.rs                 |   10 +
 rust/kernel/prelude.rs             |    8 +-
 rust/kernel/sync.rs                |   50 ++
 rust/kernel/sync/arc.rs            |  108 ++-
 rust/kernel/sync/arc/std_vendor.rs |   28 +
 rust/kernel/sync/condvar.rs        |  174 +++++
 rust/kernel/sync/lock.rs           |  191 +++++
 rust/kernel/sync/lock/mutex.rs     |  118 +++
 rust/kernel/sync/lock/spinlock.rs  |  117 +++
 rust/kernel/sync/locked_by.rs      |  156 ++++
 rust/kernel/task.rs                |  155 ++++
 rust/kernel/types.rs               |  135 ++++
 rust/macros/helpers.rs             |   10 +-
 rust/macros/lib.rs                 |   80 ++
 rust/macros/module.rs              |   32 +-
 rust/macros/pin_data.rs            |   79 ++
 rust/macros/pinned_drop.rs         |   49 ++
 rust/macros/quote.rs               |  143 ++++
 rust/uapi/lib.rs                   |   27 +
 rust/uapi/uapi_helper.h            |    9 +
 samples/rust/rust_print.rs         |   26 +
 scripts/Makefile.build             |    2 +-
 35 files changed, 4980 insertions(+), 24 deletions(-)
 create mode 100644 rust/alloc/vec/set_len_on_drop.rs
 create mode 100644 rust/alloc/vec/spec_extend.rs
 create mode 100644 rust/kernel/init.rs
 create mode 100644 rust/kernel/init/__internal.rs
 create mode 100644 rust/kernel/init/macros.rs
 create mode 100644 rust/kernel/ioctl.rs
 create mode 100644 rust/kernel/sync/arc/std_vendor.rs
 create mode 100644 rust/kernel/sync/condvar.rs
 create mode 100644 rust/kernel/sync/lock.rs
 create mode 100644 rust/kernel/sync/lock/mutex.rs
 create mode 100644 rust/kernel/sync/lock/spinlock.rs
 create mode 100644 rust/kernel/sync/locked_by.rs
 create mode 100644 rust/kernel/task.rs
 create mode 100644 rust/macros/pin_data.rs
 create mode 100644 rust/macros/pinned_drop.rs
 create mode 100644 rust/macros/quote.rs
 create mode 100644 rust/uapi/lib.rs
 create mode 100644 rust/uapi/uapi_helper.h
