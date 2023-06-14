Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1970773020D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 16:33:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245639AbjFNOdO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 10:33:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245633AbjFNOdE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 10:33:04 -0400
Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A81492682
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 07:32:49 -0700 (PDT)
Date:   Wed, 14 Jun 2023 14:32:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
        s=protonmail; t=1686753167; x=1687012367;
        bh=Eym4bt3G3yI5tzMrX6NSMGd1+ikTIMtBGpmezvReHMk=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=Xkh/eR8al1uA04ta5Bbi8OPlyK6TSpuMGojkCHFCB046PABXv7MtBc39nJrrqvDTy
         Qepc9vvN4tO/+bij/nZwQLdueaT3SnPLRnP/FLD1I/HmrFALkd8uSB0rsVZrcCaiQw
         1e2kcXYGlxMBuyWM6bgsXqpVMYtwsafhP6BZ2Dzp0LI+sPocaXK5wpFKF/2eLlKdqh
         lhNUHeg2KsmbSZjuOmeFdM5NC2WxV2WomqYHs9RS04xpJQd7/HaIUOlDqUqb8U7FXD
         G3wxciegsorkG8l3wVINiAGVclJnBjNmhz36eF5qwXF/aAEuvSGrDQ2lAsfwtDn4W2
         T9b8t2d5pNruw==
To:     Boqun Feng <boqun.feng@gmail.com>
From:   Benno Lossin <benno.lossin@proton.me>
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
        Alice Ryhl <aliceryhl@google.com>,
        Dariusz Sosnowski <dsosnowski@dsosnowski.pl>,
        Geoffrey Thomas <geofft@ldpreload.com>,
        Fox Chen <foxhlchen@gmail.com>,
        John Baublitz <john.m.baublitz@gmail.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Andreas Hindborg <nmi@metaspace.dk>, stable@vger.kernel.org
Subject: Re: [PATCH] rust: allocator: Prevents mis-aligned allocation
Message-ID: <91XpcluPyeKjsC8_uSh1yvgcz2BoRMeih76O5-wTwQgnNiLFdOCiO3HT9kXByzZIiK-6nForUTTeo-H9cR0CWemr7dJuMgMnC0wzGDIBmlQ=@proton.me>
In-Reply-To: <20230613164258.3831917-1-boqun.feng@gmail.com>
References: <20230613164258.3831917-1-boqun.feng@gmail.com>
Feedback-ID: 71780778:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.06.23 18:42, Boqun Feng wrote:
> Currently the KernelAllocator simply passes the size of the type Layout
> to krealloc(), and in theory the alignment requirement from the type
> Layout may be larger than the guarantee provided by SLAB, which means
> the allocated object is mis-aligned.
>=20
> Fixes this by adjusting the allocation size to the nearest power of two,
> which SLAB always guarantees a size-aligned allocation. And because Rust
> guarantees that original size must be a multiple of alignment and the
> alignment must be a power of two, then the alignment requirement is
> satisfied.
>=20
> Suggested-by: Vlastimil Babka <vbabka@suse.cz>
> Co-developed-by: Andreas Hindborg (Samsung) <nmi@metaspace.dk>
> Signed-off-by: Andreas Hindborg (Samsung) <nmi@metaspace.dk>
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> Cc: stable@vger.kernel.org # v6.1+

Reviewed-by: Benno Lossin <benno.lossin@proton.me>

--=20
Cheers,
Benno

> ---
> Some more explanation:
>=20
> * Layout is a data structure describing a particular memory layout,
>    conceptionally it has two fields: align and size.
>=20
>    * align is guaranteed to be a power of two.
>    * size can be smaller than align (only when the Layout is created via
>      Layout::from_align_size())
>    * After pad_to_align(), the size is guaranteed to be a multiple of
>      align
>=20
> For more information, please see:
>=20
> =09https://doc.rust-lang.org/stable/std/alloc/struct.Layout.html
>=20
>   rust/bindings/bindings_helper.h |  1 +
>   rust/kernel/allocator.rs        | 17 ++++++++++++++++-
>   2 files changed, 17 insertions(+), 1 deletion(-)
>=20
> diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_hel=
per.h
> index 3e601ce2548d..6619ce95dd37 100644
> --- a/rust/bindings/bindings_helper.h
> +++ b/rust/bindings/bindings_helper.h
> @@ -15,3 +15,4 @@
>   /* `bindgen` gets confused at certain things. */
>   const gfp_t BINDINGS_GFP_KERNEL =3D GFP_KERNEL;
>   const gfp_t BINDINGS___GFP_ZERO =3D __GFP_ZERO;
> +const size_t BINDINGS_ARCH_SLAB_MINALIGN =3D ARCH_SLAB_MINALIGN;
> diff --git a/rust/kernel/allocator.rs b/rust/kernel/allocator.rs
> index 397a3dd57a9b..66575cf87ce2 100644
> --- a/rust/kernel/allocator.rs
> +++ b/rust/kernel/allocator.rs
> @@ -11,9 +11,24 @@
>=20
>   unsafe impl GlobalAlloc for KernelAllocator {
>       unsafe fn alloc(&self, layout: Layout) -> *mut u8 {
> +        // Customized layouts from `Layout::from_size_align()` can have =
size < align, so pads first.
> +        let layout =3D layout.pad_to_align();
> +
> +        let mut size =3D layout.size();
> +
> +        if layout.align() > bindings::BINDINGS_ARCH_SLAB_MINALIGN {
> +            // The alignment requirement exceeds the slab guarantee, the=
n tries to enlarges the size
> +            // to use the "power-of-two" size/alignment guarantee (see c=
omments in kmalloc() for
> +            // more information).
> +            //
> +            // Note that `layout.size()` (after padding) is guaranteed t=
o be muliples of
> +            // `layout.align()`, so `next_power_of_two` gives enough ali=
gnment guarantee.
> +            size =3D size.next_power_of_two();
> +        }
> +
>           // `krealloc()` is used instead of `kmalloc()` because the latt=
er is
>           // an inline function and cannot be bound to as a result.
> -        unsafe { bindings::krealloc(ptr::null(), layout.size(), bindings=
::GFP_KERNEL) as *mut u8 }
> +        unsafe { bindings::krealloc(ptr::null(), size, bindings::GFP_KER=
NEL) as *mut u8 }
>       }
>=20
>       unsafe fn dealloc(&self, ptr: *mut u8, _layout: Layout) {
> --
> 2.39.2
> 
