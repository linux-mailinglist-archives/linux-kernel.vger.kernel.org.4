Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C5E573291F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 09:45:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245324AbjFPHpe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 03:45:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244284AbjFPHpb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 03:45:31 -0400
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC8212719;
        Fri, 16 Jun 2023 00:45:29 -0700 (PDT)
Date:   Fri, 16 Jun 2023 07:45:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1686901527; x=1687160727;
        bh=hja84EESOQ9EaSxRMOYXkxBe5bRgfXkY/dr6HfkUDdw=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=UnCtG/TNYW/c2hj1iuYW9BVFSfc3MamSO/1GgW7QqhNODpOPMihdMKcBs8DQWb1bU
         WCTXOl33qmyXRQCwlks+omoyqIERsvq8bx0GHcrX2XXRekrygTToo9b7nQOLl93wvi
         s0g1RVSfM0r1etX2g+I2G51pE3aAfp6i57KuU3EYnYoOq6IMG+TGLGteFMmYo8SqQn
         /hAn32YyLE79hytYP7ZMkmizIMDMNuewLYqK8mSu6a93diwnjuNMWwyx7Wnu0NcAVp
         mY9ZKfcaVGUdomoUm1RdipPoBDbfIUp3NVY2K/GfSaXr8LHl7j7jhwvGStJsGvhzYt
         I1En8JyAiEX8A==
To:     Miguel Ojeda <ojeda@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>
From:   Heghedus Razvan <heghedus.razvan@protonmail.com>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Alice Ryhl <aliceryhl@google.com>,
        Andreas Hindborg <nmi@metaspace.dk>,
        linux-kbuild@vger.kernel.org, rust-for-linux@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev
Subject: Re: [PATCH v2 00/11] `scripts/rust_is_available.sh` improvements
Message-ID: <CTDWNRIZBWCN.CJEV9K20D9OI@pc-server>
In-Reply-To: <20230616001631.463536-1-ojeda@kernel.org>
References: <20230616001631.463536-1-ojeda@kernel.org>
Feedback-ID: 1233518:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri Jun 16, 2023 at 3:16 AM EEST, Miguel Ojeda wrote:
> This is the patch series to improve `scripts/rust_is_available.sh`.
>
> The major addition in v2 is the test suite in the last commit. I added
> it because I wanted to have a proper way to test any further changes to
> it (such as the suggested `set --` idea to avoid forking by Masahiro),
> and so that adding new checks was easier to justify too (i.e. vs. the
> added complexity).
>
> In addition, there are also a few new checks in the script, to cover for
> even some more cases, which hopefully make problematic setups easier to
> identify and solve by users building the kernel. For instance, running
> the script externally gives:
>
>     $ scripts/rust_is_available.sh
>     ***
>     *** Environment variable 'RUSTC' is not set.
>     ***
>     *** This script is intended to be called from Kbuild.
>     *** Please use the 'rustavailable' target to call it instead.
>     *** Otherwise, the results may not be meaningful.
>     ***
>     *** Please see Documentation/rust/quick-start.rst for details
>     *** on how to set up the Rust support.
>     ***
>
> I also changed it to avoid setting `-e` as Masahiro suggested.
> Similarly, I now check for `$RUSTC`, `$BINDGEN` and `$CC`, instead of
> `$MAKEFLAGS`, as he also suggested (but I gave it their own error
> message rather than use the `${CC?: is not set}` approach. This goes in
> line with the reasons outlined above, i.e. trying to give users a clear
> error of what step exactly failed).
>
> In the test suite I included previously problematic compiler version
> strings we got reports for. The test suite covers all current branches
> in the script, and we should keep it that way in the future.
>
> The patch series also include Masahiro's patch to remove the `-v`
> option, as well as Russell's patch for supporting multiple arguments
> in `$CC`.
>
> All in all, this should solve all the issues we got so far (unless I
> have missed something) and improve things further with the new checks
> plus the test suite to hopefully have an easier time in the future.
>
> Testers for this one are appreciated, especially if you have uncommon or
> custom setups for building the kernel.

I gave this patch series a spin and is a nice improvement when trying to
use a broken setup.

When previously I had:
./scripts/rust_is_available.sh: line 21: 100000 *  + 100 *  + : syntax erro=
r: operand expected (error token is "+ ")
make: *** [Makefile:1883: rustavailable] Error 1

Now I have:

***
*** Running 'bindgen' to check the libclang version (used by the Rust
*** bindings generator) failed with code 101. This may be caused by
*** a failure to locate libclang. See output and docs below for details:
***
thread 'main' panicked at 'Unable to find libclang: "the `libclang` shared =
library at /opt/sdk/sysroots/x86_64-pokysdk-linux/usr/lib/libclang.so.14.0.=
3 could not be opened: /lib/x86_64-linux-gnu/libc.so.6: version `GLIBC_2.34=
' not found (required by /opt/idc23/sysroots/x86_64-pokysdk-linux/usr/lib/l=
ibclang.so.14.0.3)"', /home/heghedusrazvan/.cargo/registry/src/github.com-1=
ecc6299db9ec823/bindgen-0.56.0/src/lib.rs:1922:31
note: run with `RUST_BACKTRACE=3D1` environment variable to display a backt=
race
***
***
*** Please see Documentation/rust/quick-start.rst for details
*** on how to set up the Rust support.
***
make: *** [Makefile:1883: rustavailable] Error 1

or:

***
*** Rust compiler 'rustc' is too new. This may or may not work.
***   Your version:     1.70.0
***   Expected version: 1.68.2
***
***
*** Running 'bindgen' to check the libclang version (used by the Rust
*** bindings generator) failed with code 101. This may be caused by
*** a failure to locate libclang. See output and docs below for details:
***
thread 'main' panicked at 'Unable to find libclang: "the `libclang` shared =
library at /opt/sdk/sysroots/x86_64-pokysdk-linux/usr/lib/libclang.so.14.0.=
3 could not be opened: libncurses.so.5: cannot open shared object file: No =
such file or directory"', /root/.cargo/registry/src/index.crates.io-6f17d22=
bba15001f/bindgen-0.56.0/src/lib.rs:1922:31
note: run with `RUST_BACKTRACE=3D1` environment variable to display a backt=
race
***
***
*** Please see Documentation/rust/quick-start.rst for details
*** on how to set up the Rust support.
***
make: *** [Makefile:1883: rustavailable] Error 1

-- Razvan
>
> This could go through either the Kbuild or the Rust tree.
>
> Masahiro Yamada (1):
>   kbuild: rust_is_available: remove -v option
>
> Miguel Ojeda (9):
>   docs: rust: add paragraph about finding a suitable `libclang`
>   kbuild: rust_is_available: print docs reference
>   kbuild: rust_is_available: add check for `bindgen` invocation
>   kbuild: rust_is_available: check that environment variables are set
>   kbuild: rust_is_available: fix confusion when a version appears in the
>     path
>   kbuild: rust_is_available: normalize version matching
>   kbuild: rust_is_available: handle failures calling `$RUSTC`/`$BINDGEN`
>   kbuild: rust_is_available: check that output looks as expected
>   kbuild: rust_is_available: add test suite
>
> Russell Currey (1):
>   kbuild: rust_is_available: fix version check when CC has multiple
>     arguments
>
>  Documentation/rust/quick-start.rst |  17 ++
>  Makefile                           |   4 +-
>  scripts/rust_is_available.sh       | 233 +++++++++++++------
>  scripts/rust_is_available_test.py  | 346 +++++++++++++++++++++++++++++
>  4 files changed, 532 insertions(+), 68 deletions(-)
>  create mode 100755 scripts/rust_is_available_test.py
>
>
> base-commit: 858fd168a95c5b9669aac8db6c14a9aeab446375
> --
> 2.41.0


