Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60485644392
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 13:56:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234648AbiLFM4c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 07:56:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234763AbiLFM4P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 07:56:15 -0500
X-Greylist: delayed 228 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 06 Dec 2022 04:56:11 PST
Received: from mout-b-203.mailbox.org (mout-b-203.mailbox.org [IPv6:2001:67c:2050:102:465::203])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCEBD2BF5;
        Tue,  6 Dec 2022 04:56:10 -0800 (PST)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-b-203.mailbox.org (Postfix) with ESMTPS id 4NRL4y2jrpz9tK5;
        Tue,  6 Dec 2022 13:56:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nyantec.com; s=default;
        t=1670331362;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B36lQzGmc6BirP+Aeg4Xr0DaY4W4N99CzPG3/BD5qhQ=;
        b=J1qhPzQIXfZuykmFyrDwkLOaP/fmRoxe6VH2lc7U1Xp00zV4CgZ1Oz1Eovof+apvXVR5+/
        /4G31hK5ivNOG6P5fO3P2cNXB2glL6rgcrd+y3GIbqKtT7iVrOak9XebSdXylkR/pGIWPq
        PPuPEq0OtSUZO1VLZ3Y1YzkMDGEg2kgbs2tM1AnK/CjAAd1mY+HyCVTDoYUrm12b16g7Lr
        b7hKYhpBtN3/qjmmDg6w05xOHCAfQ+M+LU9kqP1f5il51eUqgLNHKDwfxUZe8YOiIMYu70
        CqGtfR7lxElyNdV3FD0jZcNwyjA06b0dIXJjwbNeoqNv9Qz3YQN0HXDz3G9O+A==
From:   Finn Behrens <fin@nyantec.com>
To:     ojeda@kernel.org
Cc:     Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev
Subject: Re: [PATCH v2 13/28] rust: alloc: add
 `Vec::try_with_capacity{,_in}()` constructors
Date:   Tue, 06 Dec 2022 13:55:56 +0100
Message-ID: <F461629C-97D4-4A49-885E-BEE4AEB5C4FB@nyantec.com>
In-Reply-To: <20221202161502.385525-14-ojeda@kernel.org>
References: <20221202161502.385525-1-ojeda@kernel.org>
 <20221202161502.385525-14-ojeda@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2 Dec 2022, at 17:14, ojeda@kernel.org wrote:

> From: Miguel Ojeda <ojeda@kernel.org>
>
> Add `Vec::try_with_capacity()` and `Vec::try_with_capacity_in()` as
> the fallible versions of `Vec::with_capacity()` and
> `Vec::with_capacity_in()`, respectively.
>
> The implementations follow the originals and use the previously
> added `RawVec::try_with_capacity_in()`.
>
> In turn, `Vec::try_with_capacity()` will be used to implement
> the `CString` type (which wraps a `Vec<u8>`) in a later patch.
>
> Reviewed-by: Gary Guo <gary@garyguo.net>
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
Reviewed-by: Finn Behrens <fin@nyantec.com>

Regards,
Finn

> ---
>  rust/alloc/raw_vec.rs |  1 -
>  rust/alloc/vec/mod.rs | 89 +++++++++++++++++++++++++++++++++++++++++++=

>  2 files changed, 89 insertions(+), 1 deletion(-)
>
> diff --git a/rust/alloc/raw_vec.rs b/rust/alloc/raw_vec.rs
> index c342f3843972..eb77db5def55 100644
> --- a/rust/alloc/raw_vec.rs
> +++ b/rust/alloc/raw_vec.rs
> @@ -135,7 +135,6 @@ impl<T, A: Allocator> RawVec<T, A> {
>
>      /// Like `try_with_capacity`, but parameterized over the choice of=

>      /// allocator for the returned `RawVec`.
> -    #[allow(dead_code)]
>      #[inline]
>      pub fn try_with_capacity_in(capacity: usize, alloc: A) -> Result<S=
elf, TryReserveError> {
>          Self::try_allocate_in(capacity, AllocInit::Uninitialized, allo=
c)
> diff --git a/rust/alloc/vec/mod.rs b/rust/alloc/vec/mod.rs
> index 540787804cc2..8ac6c1e3b2a8 100644
> --- a/rust/alloc/vec/mod.rs
> +++ b/rust/alloc/vec/mod.rs
> @@ -472,6 +472,48 @@ impl<T> Vec<T> {
>          Self::with_capacity_in(capacity, Global)
>      }
>
> +    /// Tries to construct a new, empty `Vec<T>` with the specified ca=
pacity.
> +    ///
> +    /// The vector will be able to hold exactly `capacity` elements wi=
thout
> +    /// reallocating. If `capacity` is 0, the vector will not allocate=
=2E
> +    ///
> +    /// It is important to note that although the returned vector has =
the
> +    /// *capacity* specified, the vector will have a zero *length*. Fo=
r an
> +    /// explanation of the difference between length and capacity, see=

> +    /// *[Capacity and reallocation]*.
> +    ///
> +    /// [Capacity and reallocation]: #capacity-and-reallocation
> +    ///
> +    /// # Examples
> +    ///
> +    /// ```
> +    /// let mut vec =3D Vec::try_with_capacity(10).unwrap();
> +    ///
> +    /// // The vector contains no items, even though it has capacity f=
or more
> +    /// assert_eq!(vec.len(), 0);
> +    /// assert_eq!(vec.capacity(), 10);
> +    ///
> +    /// // These are all done without reallocating...
> +    /// for i in 0..10 {
> +    ///     vec.push(i);
> +    /// }
> +    /// assert_eq!(vec.len(), 10);
> +    /// assert_eq!(vec.capacity(), 10);
> +    ///
> +    /// // ...but this may make the vector reallocate
> +    /// vec.push(11);
> +    /// assert_eq!(vec.len(), 11);
> +    /// assert!(vec.capacity() >=3D 11);
> +    ///
> +    /// let mut result =3D Vec::try_with_capacity(usize::MAX);
> +    /// assert!(result.is_err());
> +    /// ```
> +    #[inline]
> +    #[stable(feature =3D "kernel", since =3D "1.0.0")]
> +    pub fn try_with_capacity(capacity: usize) -> Result<Self, TryReser=
veError> {
> +        Self::try_with_capacity_in(capacity, Global)
> +    }
> +
>      /// Creates a `Vec<T>` directly from the raw components of another=
 vector.
>      ///
>      /// # Safety
> @@ -617,6 +659,53 @@ impl<T, A: Allocator> Vec<T, A> {
>          Vec { buf: RawVec::with_capacity_in(capacity, alloc), len: 0 }=

>      }
>
> +    /// Tries to construct a new, empty `Vec<T, A>` with the specified=
 capacity
> +    /// with the provided allocator.
> +    ///
> +    /// The vector will be able to hold exactly `capacity` elements wi=
thout
> +    /// reallocating. If `capacity` is 0, the vector will not allocate=
=2E
> +    ///
> +    /// It is important to note that although the returned vector has =
the
> +    /// *capacity* specified, the vector will have a zero *length*. Fo=
r an
> +    /// explanation of the difference between length and capacity, see=

> +    /// *[Capacity and reallocation]*.
> +    ///
> +    /// [Capacity and reallocation]: #capacity-and-reallocation
> +    ///
> +    /// # Examples
> +    ///
> +    /// ```
> +    /// #![feature(allocator_api)]
> +    ///
> +    /// use std::alloc::System;
> +    ///
> +    /// let mut vec =3D Vec::try_with_capacity_in(10, System).unwrap()=
;
> +    ///
> +    /// // The vector contains no items, even though it has capacity f=
or more
> +    /// assert_eq!(vec.len(), 0);
> +    /// assert_eq!(vec.capacity(), 10);
> +    ///
> +    /// // These are all done without reallocating...
> +    /// for i in 0..10 {
> +    ///     vec.push(i);
> +    /// }
> +    /// assert_eq!(vec.len(), 10);
> +    /// assert_eq!(vec.capacity(), 10);
> +    ///
> +    /// // ...but this may make the vector reallocate
> +    /// vec.push(11);
> +    /// assert_eq!(vec.len(), 11);
> +    /// assert!(vec.capacity() >=3D 11);
> +    ///
> +    /// let mut result =3D Vec::try_with_capacity_in(usize::MAX, Syste=
m);
> +    /// assert!(result.is_err());
> +    /// ```
> +    #[inline]
> +    #[stable(feature =3D "kernel", since =3D "1.0.0")]
> +    pub fn try_with_capacity_in(capacity: usize, alloc: A) -> Result<S=
elf, TryReserveError> {
> +        Ok(Vec { buf: RawVec::try_with_capacity_in(capacity, alloc)?, =
len: 0 })
> +    }
> +
>      /// Creates a `Vec<T, A>` directly from the raw components of anot=
her vector.
>      ///
>      /// # Safety
> -- =

> 2.38.1
