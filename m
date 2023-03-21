Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A5FE6C3AFA
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 20:50:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229525AbjCUTuK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 15:50:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjCUTuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 15:50:04 -0400
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 976502123;
        Tue, 21 Mar 2023 12:50:00 -0700 (PDT)
Date:   Tue, 21 Mar 2023 19:49:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1679428197; x=1679687397;
        bh=MV+8YcJMMrOoTL5qWURRXCmjD/bQi79XK3AI3Uupjl4=;
        h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
         Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
        b=VJ5yr/jGRAVs2+vNly9VUAHkyV9pLMogTxndHoblk/QLd7NSPUwDIq2COgaS3WOPU
         hSO9bUqCcVwAilR3aiHFUSvAbzXYfFQDPrXb/cTZgsks3Z1f0DeGzAetdPnGr/Nw2K
         ooNHV2EZkniXTb94CIeDFcT+uyFcBTT4QtsGU0YT/rsdYyObt27DI8QDLfwuAxTEbt
         5W78WAtQIoFEnr0C86oT9w/sywUrwIvBONVueHzRgjfsYWPgSAaV/f9PKL2uJyenjT
         GoOYryukcgKuU/Z06vexnGmVmBVljhXFXeWB9IVunez2yONSBTaMYXf2uWj+8E0Skn
         wcCGX8+sWlfDw==
To:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>
From:   Benno Lossin <y86-dev@protonmail.com>
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev
Subject: [PATCH v2 0/5] Rust pin-init API for pinned initialization of structs
Message-ID: <20230321194934.908891-1-y86-dev@protonmail.com>
Feedback-ID: 40624463:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the second version of the pin-init API. See [1] for the cover
letter of v1.

Changelog v1 -> v2:
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

The first patch adds a utility macro `quote!` for proc-macros. This macro
converts the typed characters directly into Rust tokens that are the output
of proc-macros. It is used by the pin-init API.

The second patch adds the `assume_init` function to
`UniqueArc<MaybeUninit<T>>` that unsafely assumes the pointee to be
initialized and returns a `UniqueArc<T>`. This function is used by
`UniqueArc::write` function and by the third patch.

The third patch introduces the pin-init API. The commit message details
the problem it solves and lays out the overall architecture. The
implementation details are fairly complex; however, this is required to
provide a safe API for users -- reducing the amount of `unsafe` code is a
key goal of the Rust support in the kernel. An example of the before/after
difference from the point of view of users is provided in the commit
message. Ultimately, it is a goal is to at some point have this as a
language feature of Rust. A first step in this direction is the Field
Projection RFC [2].

The fourth patch adds the `kernel::init::common` module. It provides
functions for easier initialization of raw `Opaque<T>` objects via
FFI-functions. This is necessary when writing Rust wrappers.

The fifth patch improves the function `UniqueArc::try_new_uninit` by using
the pin-init API. The old version first allocated uninitialized memory on
the stack and then moved it into the location in the heap. The new version
directly allocates this on the heap.

These patches are also a long way coming, since I held a presentation on
safe pinned initialization at Kangrejos [3]. And my discovery of this
problem was almost a year ago [4].

The repository at [5] contains these patches applied. The Rust-doc
documentation of the pin-init API can be found at [6].

Link: https://lore.kernel.org/rust-for-linux/Bk4Yd1TBtgoLg2g_c37V3c_Wt30FMS=
89z7LrjnfadhDquwG_0dUGz1c_9BlMDmymg0tCACBpmCw-wZxlg4Jl4W2gkorh5P78ePgSnJVR5=
cU=3D@protonmail.com/T/#u [1]
Link: https://github.com/rust-lang/rfcs/pull/3318 [2]
Link: https://kangrejos.com [3]
Link: https://github.com/Rust-for-Linux/linux/issues/772 [4]
Link: https://github.com/y86-dev/linux.git patch/pinned-init-v1 [5]
Link: https://rust-for-linux.github.io/docs/pinned-init/kernel/init [6]

Benno Lossin (4):
  rust: sync: add `assume_init` to `UniqueArc`
  rust: add pin-init API
  rust: init: add common init-helper functions for `Opaque`
  rust: sync: reduce stack usage of `UniqueArc::try_new_uninit`

Gary Guo (1):
  rust: macros: add `quote!` macro

 rust/kernel/init.rs        | 1429 ++++++++++++++++++++++++++++++++++++
 rust/kernel/init/common.rs |   42 ++
 rust/kernel/init/macros.rs |  481 ++++++++++++
 rust/kernel/lib.rs         |    6 +
 rust/kernel/prelude.rs     |    6 +-
 rust/kernel/sync/arc.rs    |   48 +-
 rust/kernel/types.rs       |    8 +
 rust/macros/lib.rs         |   80 ++
 rust/macros/pin_data.rs    |   79 ++
 rust/macros/pinned_drop.rs |   49 ++
 rust/macros/quote.rs       |  143 ++++
 scripts/Makefile.build     |    2 +-
 12 files changed, 2369 insertions(+), 4 deletions(-)
 create mode 100644 rust/kernel/init.rs
 create mode 100644 rust/kernel/init/common.rs
 create mode 100644 rust/kernel/init/macros.rs
 create mode 100644 rust/macros/pin_data.rs
 create mode 100644 rust/macros/pinned_drop.rs
 create mode 100644 rust/macros/quote.rs


base-commit: fe15c26ee26efa11741a7b632e9f23b01aca4cc6
--
2.39.2


