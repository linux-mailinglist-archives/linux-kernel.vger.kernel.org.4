Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8670C6E9457
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 14:31:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231972AbjDTMbm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 08:31:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233953AbjDTMbh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 08:31:37 -0400
Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF6395FD5
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 05:31:24 -0700 (PDT)
Date:   Thu, 20 Apr 2023 12:31:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1681993880; x=1682253080;
        bh=FCkFAbulFGI3Yeay24LtaHM+84J2hy00PW8s2beY1+4=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=MjgeugQg+13JYK+iNQZj/VWwPd5j7KpF0adnh5wyJgfHZbx763uLQ8Y0OcjsWu6ea
         MwhOjm1u2w6xucVMB8Scyb7PHC5RP7iHZAb8XtoyIQsNXJdvCvmNAik+R6fqO+8eSA
         +WtjhuXC44ko8llcV2PounBroYAQrETWNSq0uMW1bO3wN6GaEjGq7yURZyAkGXdicx
         kp+d8nBDr9WvlAEB5ddyUXPpuYJG+4TFONgGe2oFF6cFqfoYpB+zrF9tijehxXn4Xw
         dpx6D6O2ob7X3F+5fei7Rq1Ro/vwj5X/WZS/fcr5O3ZYCpY/UcMjbv52tq4MNRfHro
         S4I+l5Hyf2SsA==
To:     Miguel Ojeda <ojeda@kernel.org>
From:   =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>
Cc:     Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        Benno Lossin <benno.lossin@proton.me>,
        Josh Stone <jistone@redhat.com>,
        William Brown <william.brown@suse.com>,
        Georgy Yakovlev <gyakovlev@gentoo.org>,
        Jan Alexander Steffens <jan.steffens@gmail.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev
Subject: Re: [PATCH 3/3] rust: upgrade to Rust 1.68.2
Message-ID: <0B5taLitZ7KSXZe80LMMwnD0i2dJBwv9KRbM4uwj-DscFSwNEpb3Z1Q-ojqizlBcK_m2carSDL9uPrrJdDkn_BAG04UUl8uM_SpGy_wPnw4=@protonmail.com>
In-Reply-To: <20230418214347.324156-4-ojeda@kernel.org>
References: <20230418214347.324156-1-ojeda@kernel.org> <20230418214347.324156-4-ojeda@kernel.org>
Feedback-ID: 27884398:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, April 18th, 2023 at 23:43, Miguel Ojeda <ojeda@kernel.org> wrot=
e:

> This is the first upgrade to the Rust toolchain since the initial Rust
> merge, from 1.62.0 to 1.68.2 (i.e. the latest).
>=20
> # Context
>=20
> The kernel currently supports only a single Rust version [1] (rather
> than a minimum) given our usage of some "unstable" Rust features [2]
> which do not promise backwards compatibility.
>=20
> The goal is to reach a point where we can declare a minimum version for
> the toolchain. For instance, by waiting for some of the features to be
> stabilized. Therefore, the first minimum Rust version that the kernel
> will support is "in the future".
>=20
> # Upgrade policy
>=20
> Given we will eventually need to reach that minimum version, it would be
> ideal to upgrade the compiler from time to time to be as close as
> possible to that goal and find any issues sooner. In the extreme, we
> could upgrade as soon as a new Rust release is out. Of course, upgrading
> so often is in stark contrast to what one normally would need for GCC
> and LLVM, especially given the release schedule: 6 weeks for Rust vs.
> half a year for LLVM and a year for GCC.
>=20
> Having said that, there is no particular advantage to updating slowly
> either: kernel developers in "stable" distributions are unlikely to be
> able to use their distribution-provided Rust toolchain for the kernel
> anyway [3]. Instead, by routinely upgrading to the latest instead,
> kernel developers using Linux distributions that track the latest Rust
> release may be able to use those rather than Rust-provided ones,
> especially if their package manager allows to pin / hold back /
> downgrade the version for some days during windows where the version may
> not match. For instance, Arch, Fedora, Gentoo and openSUSE all provide
> and track the latest version of Rust as they get released every 6 weeks.
>=20
> Then, when the minimum version is reached, we will stop upgrading and
> decide how wide the window of support will be. For instance, a year of
> Rust versions. We will probably want to start small, and then widen it
> over time, just like the kernel did originally for LLVM, see commit
> 3519c4d6e08e ("Documentation: add minimum clang/llvm version").
>=20
> # Unstable features stabilized
>=20
> This upgrade allows us to remove the following unstable features since
> they were stabilized:
>=20
>   - `feature(explicit_generic_args_with_impl_trait)` (1.63).
>   - `feature(core_ffi_c)` (1.64).
>   - `feature(generic_associated_types)` (1.65).
>   - `feature(const_ptr_offset_from)` (1.65, *).
>   - `feature(bench_black_box)` (1.66, *).
>   - `feature(pin_macro)` (1.68).
>=20
> The ones marked with `*` apply only to our old `rust` branch, not
> mainline yet, i.e. only for code that we may potentially upstream.
>=20
> With this patch applied, the only unstable feature allowed to be used
> outside the `kernel` crate is `new_uninit`, though other code to be
> upstreamed may increase the list.
>=20
> Please see [2] for details.
>=20
> # Other required changes
>=20
> Since 1.63, `rustdoc` triggers the `broken_intra_doc_links` lint for
> links pointing to exported (`#[macro_export]`) `macro_rules`. An issue
> was opened upstream [4], but it turns out it is intended behavior. For
> the moment, just add an explicit reference for each link. Later we can
> revisit this if `rustdoc` removes the compatibility measure.
>=20
> Nevertheless, this was helpful to discover a link that was pointing to
> the wrong place unintentionally. Since that one was actually wrong, it
> is fixed in a previous commit independently.
>=20
> Another change was the addition of `cfg(no_rc)` and `cfg(no_sync)` in
> upstream [5], thus remove our original changes for that.
>=20
> Similarly, upstream now tests that it compiles successfully with
> `#[cfg(not(no_global_oom_handling))]` [6], which allow us to get rid
> of some changes, such as an `#[allow(dead_code)]`.
>=20
> In addition, remove another `#[allow(dead_code)]` due to new uses
> within the standard library.
>=20
> Finally, add `try_extend_trusted` and move the code in `spec_extend.rs`
> since upstream moved it for the infallible version.
>=20
> # `alloc` upgrade and reviewing
>=20
> There are a large amount of changes, but the vast majority of them are
> due to our `alloc` fork being upgraded at once.
>=20
> There are two kinds of changes to be aware of: the ones coming from
> upstream, which we should follow as closely as possible, and the updates
> needed in our added fallible APIs to keep them matching the newer
> infallible APIs coming from upstream.
>=20
> Instead of taking a look at the diff of this patch, an alternative
> approach is reviewing a diff of the changes between upstream `alloc` and
> the kernel's. This allows to easily inspect the kernel additions only,
> especially to check if the fallible methods we already have still match
> the infallible ones in the new version coming from upstream.
>=20
> Another approach is reviewing the changes introduced in the additions in
> the kernel fork between the two versions. This is useful to spot
> potentially unintended changes to our additions.
>=20
> To apply these approaches, one may follow steps similar to the following
> to generate a pair of patches that show the differences between upstream
> Rust and the kernel (for the subset of `alloc` we use) before and after
> applying this patch:
>=20
>     # Get the difference with respect to the old version.
>     git -C rust checkout $(linux/scripts/min-tool-version.sh rustc)
>     git -C linux ls-tree -r --name-only HEAD -- rust/alloc |
>         cut -d/ -f3- |
>         grep -Fv README.md |
>         xargs -IPATH cp rust/library/alloc/src/PATH linux/rust/alloc/PATH
>     git -C linux diff --patch-with-stat --summary -R > old.patch
>     git -C linux restore rust/alloc
>=20
>     # Apply this patch.
>     git -C linux am rust-upgrade.patch
>=20
>     # Get the difference with respect to the new version.
>     git -C rust checkout $(linux/scripts/min-tool-version.sh rustc)
>     git -C linux ls-tree -r --name-only HEAD -- rust/alloc |
>         cut -d/ -f3- |
>         grep -Fv README.md |
>         xargs -IPATH cp rust/library/alloc/src/PATH linux/rust/alloc/PATH
>     git -C linux diff --patch-with-stat --summary -R > new.patch
>     git -C linux restore rust/alloc
>=20
> Now one may check the `new.patch` to take a look at the additions (first
> approach) or at the difference between those two patches (second
> approach). For the latter, a side-by-side tool is recommended.
>=20
> Link: https://rust-for-linux.com/rust-version-policy [1]
> Link: https://github.com/Rust-for-Linux/linux/issues/2 [2]
> Link: https://lore.kernel.org/rust-for-linux/CANiq72mT3bVDKdHgaea-6WiZazd=
8Mvurqmqegbe5JZxVyLR8Yg@mail.gmail.com/ [3]
> Link: https://github.com/rust-lang/rust/issues/106142 [4]
> Link: https://github.com/rust-lang/rust/pull/89891 [5]
> Link: https://github.com/rust-lang/rust/pull/98652 [6]
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Reviewed-by: Bj=C3=B6rn Roy Baron <bjorn3_gh@protonmail.com>

> ---
>  Documentation/process/changes.rst |   2 +-
>  rust/alloc/alloc.rs               |  55 ++--
>  rust/alloc/boxed.rs               | 446 ++++++++++++++++++++++++++--
>  rust/alloc/collections/mod.rs     |   5 +-
>  rust/alloc/lib.rs                 |  71 +++--
>  rust/alloc/raw_vec.rs             |  16 +-
>  rust/alloc/slice.rs               | 447 ++++------------------------
>  rust/alloc/vec/drain.rs           |  81 +++++-
>  rust/alloc/vec/drain_filter.rs    |  60 +++-
>  rust/alloc/vec/into_iter.rs       | 125 ++++++--
>  rust/alloc/vec/is_zero.rs         |  96 ++++++-
>  rust/alloc/vec/mod.rs             | 464 +++++++++++++++++++++++-------
>  rust/alloc/vec/set_len_on_drop.rs |   5 +
>  rust/alloc/vec/spec_extend.rs     |  63 +---
>  rust/bindings/lib.rs              |   1 -
>  rust/kernel/build_assert.rs       |   2 +
>  rust/kernel/init.rs               |   5 +
>  rust/kernel/lib.rs                |   4 -
>  rust/kernel/std_vendor.rs         |   2 +
>  scripts/Makefile.build            |   2 +-
>  scripts/min-tool-version.sh       |   2 +-
>  21 files changed, 1274 insertions(+), 680 deletions(-)
