Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D317864919C
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Dec 2022 02:03:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbiLKA43 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Dec 2022 19:56:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiLKA42 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Dec 2022 19:56:28 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BEFE11A3F;
        Sat, 10 Dec 2022 16:56:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2D903B8094D;
        Sun, 11 Dec 2022 00:56:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7E1CC433EF;
        Sun, 11 Dec 2022 00:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670720182;
        bh=z2Ic5dL5U/Pe4mtp6YXb6Fk2TXczw29Ly0amvAbkuQs=;
        h=From:To:Cc:Subject:Date:From;
        b=tjMqpHoTwROGvGwJxv6x/KPBkw/mlW9XvavSOnbQv5SKBf+eHKroRkWTrqs/NRF4g
         xADO7SGM63zI3I74LPe90Uh0yI2JSbgcIczH1PRjOsYYSMl/zsw294j7GnSGN1tzuz
         vS3T3z5/SdWB9kEkeg48aKj7Qlru+x9Ju9eX/bWh0WILq4a2ytbJoSSqYyciY6TuKy
         9+0d5yuz3zCokiUUV4heW7HrKNHwQx50QX2aq4DezDhy03kPedbY22M22nOtD4fBwj
         6akz67A3X7UiuYHdIKoxQzuuHNzU2BnUgOpWzOdXQ6YXIGsQlbv66WTrEB3I7uL9d6
         MMmAKwR0cQdMQ==
From:   ojeda@kernel.org
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Rust for 6.2
Date:   Sun, 11 Dec 2022 01:56:09 +0100
Message-Id: <20221211005609.270457-1-ojeda@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Miguel Ojeda <ojeda@kernel.org>

Hi Linus,

This is the first Rust PR after the merge.

It contains a set of new functionality to start the upstreaming of
the rest of the pieces we had. There are no changes to the C side.

The commits have been in linux-next for a week, though most of the
code has been there for months. No conflicts expected.

Please pull for v6.2 -- thanks!

Cheers,
Miguel

The following changes since commit f0c4d9fc9cc9462659728d168387191387e903cc:

  Linux 6.1-rc4 (2022-11-06 15:07:11 -0800)

are available in the Git repository at:

  https://github.com/Rust-for-Linux/linux tags/rust-6.2

for you to fetch changes up to b9ecf9b9ac5969d7b7ea786ce5c76e24246df2c5:

  rust: types: add `Opaque` type (2022-12-04 01:59:16 +0100)

----------------------------------------------------------------
Rust changes for v6.2

The first set of changes after the merge, the major ones being:

- String and formatting: new types `CString`, `CStr`, `BStr` and
  `Formatter`; new macros `c_str!`, `b_str!` and `fmt!`.

- Errors: the rest of the error codes from `errno-base.h`, as well as
  some `From` trait implementations for the `Error` type.

- Printing: the rest of the `pr_*!` levels and the continuation one
  `pr_cont!`, as well as a new sample.

- `alloc` crate: new constructors `try_with_capacity()` and
  `try_with_capacity_in()` for `RawVec` and `Vec`.

- Procedural macros: new macros `#[vtable]` and `concat_idents!`, as
  well as better ergonomics for `module!` users.

- Asserting: new macros `static_assert!`, `build_error!` and
  `build_assert!`, as well as a new crate `build_error` to support them.

- Vocabulary types: new types `Opaque` and `Either`.

- Debugging: new macro `dbg!`.

----------------------------------------------------------------
Björn Roy Baron (1):
      rust: macros: add `concat_idents!` proc macro

Finn Behrens (1):
      rust: error: declare errors using macro

Gary Guo (9):
      rust: macros: add `#[vtable]` proc macro
      rust: macros: take string literals in `module!`
      rust: str: add `BStr` type
      rust: str: add `b_str!` macro
      rust: str: add `CStr` type
      rust: str: implement several traits for `CStr`
      rust: str: add `c_str!` macro
      rust: add `build_error` crate
      rust: build_assert: add `build_{error,assert}!` macros

Miguel Ojeda (7):
      rust: prelude: split re-exports into groups
      rust: print: add more `pr_*!` levels
      rust: print: add `pr_cont!` macro
      rust: samples: add `rust_print` example
      rust: alloc: add `RawVec::try_with_capacity_in()` constructor
      rust: alloc: add `Vec::try_with_capacity{,_in}()` constructors
      rust: static_assert: add `static_assert!` macro

Milan Landaverde (1):
      rust: str: add `CStr` unit tests

Niklas Mohrin (1):
      rust: std_vendor: add `dbg!` macro based on `std`'s one

Viktor Garske (1):
      rust: error: add codes from `errno-base.h`

Wedson Almeida Filho (7):
      rust: error: add `From` implementations for `Error`
      rust: prelude: add `error::code::*` constant items
      rust: str: add `Formatter` type
      rust: str: add `CString` type
      rust: str: add `fmt!` macro
      rust: types: add `Either` type
      rust: types: add `Opaque` type

 lib/Kconfig.debug                 |  16 ++
 rust/Makefile                     |  22 +-
 rust/alloc/raw_vec.rs             |  33 ++-
 rust/alloc/vec/mod.rs             |  89 +++++++
 rust/build_error.rs               |  31 +++
 rust/exports.c                    |   5 +
 rust/kernel/build_assert.rs       |  82 ++++++
 rust/kernel/error.rs              |  90 ++++++-
 rust/kernel/lib.rs                |   9 +
 rust/kernel/prelude.rs            |  20 +-
 rust/kernel/print.rs              | 214 +++++++++++++++-
 rust/kernel/static_assert.rs      |  34 +++
 rust/kernel/std_vendor.rs         | 163 ++++++++++++
 rust/kernel/str.rs                | 523 +++++++++++++++++++++++++++++++++++++-
 rust/kernel/types.rs              |  37 +++
 rust/macros/concat_idents.rs      |  23 ++
 rust/macros/helpers.rs            |  24 +-
 rust/macros/lib.rs                | 108 +++++++-
 rust/macros/module.rs             |  10 +-
 rust/macros/vtable.rs             |  95 +++++++
 samples/rust/Kconfig              |  10 +
 samples/rust/Makefile             |   1 +
 samples/rust/rust_minimal.rs      |   8 +-
 samples/rust/rust_print.rs        |  54 ++++
 scripts/generate_rust_analyzer.py |   8 +-
 25 files changed, 1667 insertions(+), 42 deletions(-)
 create mode 100644 rust/build_error.rs
 create mode 100644 rust/kernel/build_assert.rs
 create mode 100644 rust/kernel/static_assert.rs
 create mode 100644 rust/kernel/std_vendor.rs
 create mode 100644 rust/kernel/types.rs
 create mode 100644 rust/macros/concat_idents.rs
 create mode 100644 rust/macros/vtable.rs
 create mode 100644 samples/rust/rust_print.rs
