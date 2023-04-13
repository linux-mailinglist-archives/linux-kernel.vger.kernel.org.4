Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 104336E0888
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 10:02:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbjDMIC4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 04:02:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjDMICy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 04:02:54 -0400
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63E171996;
        Thu, 13 Apr 2023 01:02:52 -0700 (PDT)
Date:   Thu, 13 Apr 2023 08:02:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
        s=defwzdmaenehngew2pjqi5ow4e.protonmail; t=1681372970; x=1681632170;
        bh=tgvPbiKBjIQ3zUaZAx9h4mi+To8BUxn+30NwtaLSZ0Y=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=jeRXmJfamXCYFqKHvosjUlzyG/O4SoY5AxOqyWMtfMhkhTaBolyFq/sQmZQQfDX1m
         k5kdbd4IusypgHeIWNu6zSqz3IWqRHizQJ0U+gFb7f+MzaO6BftJiOsOGTtjQoZ/mX
         S3e480l3tOfsLlboWvWHJus+JLIpzeYKrIhdCuEViAW3JPsmzGI+LeNieYorxCl0+P
         NEdcdgLFFg1p3yw2sQBmn2IBOvkggq+U+g7bOC8oQaukDg0hxJCeZ5mOgnG8+Lsmds
         iyXrxmemA9hisU/YYQ4BZAlMAfKv05/Hx746rPuR0ArtaewHJmwg0fOZWcS9Qn1C3C
         kLhhSGQx6fx8Q==
To:     Wedson Almeida Filho <wedsonaf@gmail.com>,
        rust-for-linux@vger.kernel.org
From:   Benno Lossin <benno.lossin@proton.me>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <walmeida@microsoft.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Subject: Re: [PATCH v4 01/13] rust: sync: introduce `LockClassKey`
Message-ID: <a9428aa7-efc0-f6e8-6bc3-5a3173a09e7e@proton.me>
In-Reply-To: <20230411054543.21278-1-wedsonaf@gmail.com>
References: <20230411054543.21278-1-wedsonaf@gmail.com>
Feedback-ID: 71780778:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.04.23 07:45, Wedson Almeida Filho wrote:
> From: Wedson Almeida Filho <walmeida@microsoft.com>
>
> It is a wrapper around C's `lock_class_key`, which is used by the
> synchronisation primitives that are checked with lockdep. This is in
> preparation for introducing Rust abstractions for these primitives.
>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Waiman Long <longman@redhat.com>
> Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
> Co-developed-by: Boqun Feng <boqun.feng@gmail.com>
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>

Reviewed-by: Benno Lossin <benno.lossin@proton.me>

> ---
> v1 -> v2: Fixed a typo in comment
> v2 -> v3: Replaced `core` with `::core` in macro
> v3 -> v4:
> - Rebased on top of rust-next now that all dependencies are applied
>
>   rust/kernel/sync.rs | 45 +++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 45 insertions(+)
>
> diff --git a/rust/kernel/sync.rs b/rust/kernel/sync.rs
> index 33da23e3076d..541d235ffbeb 100644
> --- a/rust/kernel/sync.rs
> +++ b/rust/kernel/sync.rs
> @@ -5,6 +5,51 @@
>   //! This module contains the kernel APIs related to synchronisation tha=
t have been ported or
>   //! wrapped for usage by Rust code in the kernel.
>
> +use crate::types::Opaque;
> +
>   mod arc;
>
>   pub use arc::{Arc, ArcBorrow, UniqueArc};
> +
> +/// Represents a lockdep class. It's a wrapper around C's `lock_class_ke=
y`.
> +#[repr(transparent)]
> +pub struct LockClassKey(Opaque<bindings::lock_class_key>);
> +
> +// SAFETY: `bindings::lock_class_key` is designed to be used concurrentl=
y from multiple threads and
> +// provides its own synchronization.
> +unsafe impl Sync for LockClassKey {}
> +
> +impl LockClassKey {
> +    /// Creates a new lock class key.
> +    pub const fn new() -> Self {
> +        Self(Opaque::uninit())
> +    }
> +
> +    #[allow(dead_code)]
> +    pub(crate) fn as_ptr(&self) -> *mut bindings::lock_class_key {
> +        self.0.get()
> +    }
> +}
> +
> +/// Defines a new static lock class and returns a pointer to it.
> +#[doc(hidden)]
> +#[macro_export]
> +macro_rules! static_lock_class {
> +    () =3D> {{
> +        static CLASS: $crate::sync::LockClassKey =3D $crate::sync::LockC=
lassKey::new();
> +        &CLASS
> +    }};
> +}
> +
> +/// Returns the given string, if one is provided, otherwise generates on=
e based on the source code
> +/// location.
> +#[doc(hidden)]
> +#[macro_export]
> +macro_rules! optional_name {
> +    () =3D> {
> +        $crate::c_str!(::core::concat!(::core::file!(), ":", ::core::lin=
e!()))
> +    };
> +    ($name:literal) =3D> {
> +        $crate::c_str!($name)
> +    };
> +}
>
> base-commit: 2d0dec625d872a41632a68fce2e69453ed87df91
> --
> 2.34.1
>

