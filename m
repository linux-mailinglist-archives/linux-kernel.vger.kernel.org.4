Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69BE262473E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 17:42:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232029AbiKJQma (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 11:42:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231955AbiKJQm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 11:42:26 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DF6C13DDD;
        Thu, 10 Nov 2022 08:42:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1F1D4B82248;
        Thu, 10 Nov 2022 16:42:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8F75C433C1;
        Thu, 10 Nov 2022 16:42:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668098537;
        bh=e4hlEGbMvLPpDidaYvlKiHNZ2EtLaQnPxMUUsMUj+Lk=;
        h=From:To:Cc:Subject:Date:From;
        b=dK1EerY5otwPdRKe3gqKcZ432vrddg9S2SvsfGtDdMwfYA1rAyayYxRVO4Z3xHzK2
         ctj1nX/Ilr2RQSgs/cP8cIFiFpDbYqKcHcDGx0mEZ6S9Q90Z2+xpH/77vWFkMxB2cM
         2g/z6K7J3wYBW5jDNLdocut9Hf/AJ6DTA93yh4jxr0sPYr/W2cDGnw6XoGZzKi5PaV
         0wqaxOVX9+jbIW4w/cocJejzSEnT+R0aAtyapmbU7pw/w3keg0UjRICG7bQBEfcmqV
         r41xz3W6ubVz049VW8rXQxqK0mKsKbiKppFnwL7K0bfTxeWmTo6hn5c0jDFSRhj6ic
         Tu5M/GeEgxbpA==
From:   Miguel Ojeda <ojeda@kernel.org>
To:     Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev
Subject: [PATCH v1 00/28] Rust core additions
Date:   Thu, 10 Nov 2022 17:41:12 +0100
Message-Id: <20221110164152.26136-1-ojeda@kernel.org>
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

This patch series is the first batch of changes to upstream the rest
of the Rust support.

In this instance, all the facilities introduced are part of the "Rust
core". They do not interact with the C side in new major ways (no new
C types used; only `strlen`, `memchr`, additional error codes and some
more `printk` format strings).

After this series, `str.rs` and `print.rs` are in sync with downstream
and all remaining proc macros have been added. `error.rs` is fairly
complete too, though a few more `pub(crate)` features will come later
(to avoid leaving dead code in-between series).

Note that a few temporary `#[allow(dead_code)]` attributes are used in
order to have a bit more freedom organizing the patches while keeping
all of them buildable without warnings/errors, but at the end of the
series there is none remaining (of the temporary ones).

Virtually all the code has been in linux-next for months and was part
of the Rust patch series before the trimming down (i.e. up to v8).

Each patch has been built-tested on a Rust-enabled `defconfig` with
`CLIPPY=1` on the `all`, `rustfmtcheck`, `rustdoc` and `rusttest`
targets.

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

 lib/Kconfig.debug                 |  16 +
 rust/Makefile                     |  22 +-
 rust/alloc/raw_vec.rs             |  33 +-
 rust/alloc/vec/mod.rs             |  89 +++++
 rust/build_error.rs               |  24 ++
 rust/exports.c                    |   5 +
 rust/kernel/build_assert.rs       |  82 +++++
 rust/kernel/error.rs              |  90 ++++-
 rust/kernel/lib.rs                |   9 +
 rust/kernel/prelude.rs            |  20 +-
 rust/kernel/print.rs              | 214 +++++++++++-
 rust/kernel/static_assert.rs      |  34 ++
 rust/kernel/std_vendor.rs         | 160 +++++++++
 rust/kernel/str.rs                | 532 +++++++++++++++++++++++++++++-
 rust/kernel/types.rs              |  37 +++
 rust/macros/concat_idents.rs      |  23 ++
 rust/macros/helpers.rs            |  24 +-
 rust/macros/lib.rs                | 108 +++++-
 rust/macros/module.rs             |  10 +-
 rust/macros/vtable.rs             |  95 ++++++
 samples/rust/Kconfig              |  10 +
 samples/rust/Makefile             |   1 +
 samples/rust/rust_minimal.rs      |   8 +-
 samples/rust/rust_print.rs        |  54 +++
 scripts/generate_rust_analyzer.py |   8 +-
 25 files changed, 1666 insertions(+), 42 deletions(-)
 create mode 100644 rust/build_error.rs
 create mode 100644 rust/kernel/build_assert.rs
 create mode 100644 rust/kernel/static_assert.rs
 create mode 100644 rust/kernel/std_vendor.rs
 create mode 100644 rust/kernel/types.rs
 create mode 100644 rust/macros/concat_idents.rs
 create mode 100644 rust/macros/vtable.rs
 create mode 100644 samples/rust/rust_print.rs


base-commit: f0c4d9fc9cc9462659728d168387191387e903cc
-- 
2.38.1

