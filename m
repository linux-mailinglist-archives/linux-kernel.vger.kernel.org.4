Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 122E86D0285
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 13:06:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230181AbjC3LGh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 07:06:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231376AbjC3LGa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 07:06:30 -0400
Received: from GBR01-LO2-obe.outbound.protection.outlook.com (mail-lo2gbr01on2092.outbound.protection.outlook.com [40.107.10.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77DB99763;
        Thu, 30 Mar 2023 04:06:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=egmXp4Y9xQzeZRhp0i3i38fxHaBz8Q2xQm8INFIKdsrhpI5KcuwSSk0XR2UjvQZG29+Ntsw/Npo19p3JvB1RUXevujZUSBmcgZDxDSCaJAKyr2uc5FCP2Z4cma6Gw66114I7n5dux/TlsIMZCfgRuK8vh2MzDLLl2mVIhcr///JZp8qDa63Lu5I0ilhdivhsrnqz+tJ++M3nKEewBP2E84g4TUp17Fv4Z0lH2yN0phHCTRCmSWq7OZJ+iU8/PoDn4a09cwo7kbEnkzpvGtvTSiF4Jr+UHQ8fHI9pDHnBYmOeX00ylgbu0psXs28nGmp3lvynlGucYAFChH8feVCo0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lKscbxjFK/Np2j3JcZ+Pcve1uDYVs3nXY+8UWj+MKNw=;
 b=c9oDws4c6RcoMfnB1nwHwe6b91Tgi5n6vdmp6IlJ5f3a3UcxjmMnU/88pZq/U5PMkm5L5Va+ecopNApjANql2HUpLywFsSVCkkQ/EMl59pi+XJEQ41W+oHFDg1hj0ajt2ngDCFZC6rNWoFE1u6ewXoYljUQ6Fgf+L3M0bgvuS8dvq2CNI2jWJ7sC8cDKueRoKixGlbHozbkOeAXPFIY4aJDIbzV+GKgYxnwGQrPh3P1+NijrjKZ6/B//o3+Lw27ep+/xF4dL1q+y6giH9QuidPmCo6gazqTSU+U1p9VMk35nG5/SG/jDehsCb97ms6TD/7OqgyHhRNRbRa4njc3GwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lKscbxjFK/Np2j3JcZ+Pcve1uDYVs3nXY+8UWj+MKNw=;
 b=NckzXnt0diym4KrD/CYLAf+l1LPCyS5PvvSuaAfguEGZNtMbfDTdM1QeVmRuB5nGuSODdxZRtTf0cr6q+N4qehkGJ3Zso8BwRr2EdhzwHONQ66YE//aSOo2J5Vb64C5CF391mc7vTqAqflB4F0BELai/SgenHFKGeS4Li9Onbns=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LO6P265MB6144.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:2b0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22; Thu, 30 Mar
 2023 11:06:03 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::2f2a:55d4:ea1d:dece]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::2f2a:55d4:ea1d:dece%4]) with mapi id 15.20.6222.035; Thu, 30 Mar 2023
 11:06:03 +0000
Date:   Thu, 30 Mar 2023 12:06:00 +0100
From:   Gary Guo <gary@garyguo.net>
To:     y86-dev@protonmail.com
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        =?UTF-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
        Alice Ryhl <alice@ryhl.io>, rust-for-linux@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev
Subject: Re: [PATCH v3 08/13] rust: init: add `stack_pin_init!` macro
Message-ID: <20230330120600.45418253.gary@garyguo.net>
In-Reply-To: <20230329223239.138757-9-y86-dev@protonmail.com>
References: <20230329223239.138757-1-y86-dev@protonmail.com>
        <20230329223239.138757-9-y86-dev@protonmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0479.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a8::16) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LO6P265MB6144:EE_
X-MS-Office365-Filtering-Correlation-Id: 6db502b1-aebb-4142-c525-08db310ec095
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bamZGVmS7Zjii2wIr8fuCMOsxbRGc/PEkGaDRYxyZG3MxAoMVpgwGPH6XDzP2McB8PjYTyQdNV8a9AlykNLqWPIfgAGzU/AikZ//tDphTjtRR5WYzZgbOK+cIp81CCKVns+j1s7cWxzaQk4Znmnv8U+s7QimXTLSnBOcY60cf5rfhnv8aWfkyAKomLjUIoe4cw0bVAahlUfiJC4jEqB2O1yyoGi8WBblVayUvvEvQFsrUwFgejb5NYzxanAGqgvFpa/uRvUAf+P5dE40I8CmkDTQ2KuBr2Xwz5Gd/y8Ky8h/X41NBjareu8+uyz1700OkkkQXY/kY5bUdmql9GsmXQvKVyqnh5dWQynEZDNAqjj7lSlLzktK3/NICx7u6Ta0hM2g0wn3FNqwWDqsqSeaxDkq7ykTYMl5hrnHbZVzGNyDHj0OWTtlVPJCRL4O6NZTNuPcq+mcTXopikrdkU4XCZewMKov3jBhzNChi4zqziPrKepVey8PEdjajI0nJrMPo34QH3uGOvMPB/o7Xi35kopny6b+98IiqWe3Vbu1x4fbH7m1VEcD00NlG9jCBAS9i7UXInieF4LkNCZL9JVZSpicUyW0QVKlgE7bRGRPTQU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(39840400004)(376002)(136003)(396003)(366004)(346002)(451199021)(36756003)(6916009)(38100700002)(4326008)(5660300002)(8936002)(7416002)(86362001)(8676002)(66946007)(66556008)(41300700001)(66476007)(966005)(6486002)(83380400001)(2616005)(26005)(54906003)(1076003)(6506007)(2906002)(6512007)(478600001)(316002)(186003)(81973001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nKa1nT4jeqSlvn/8Ut1om0wlYh0T32Do4Sxwl3pmxqTCd2462cc0YtBwMzEl?=
 =?us-ascii?Q?MWks8LUadkmynlRkzXT2q+BQcK9LSU9CQp2Ib69Zx46uSB6wP8l758XJLiJh?=
 =?us-ascii?Q?AoVOUkjv2Naa634ipyKGzhze52O+iVeA30Ugrg6izMyPITJOL/oIdF6Tve/e?=
 =?us-ascii?Q?QShpJi1unvhW/a2BMyc29tpCs5g+C5PH9AWnbDGKT0sqNX5MSt6m7TWPK1sK?=
 =?us-ascii?Q?pTOgQkl9PuXr6E+ON5gsoK/rr5UkkfRdKRQrDXFXl6jisQ/ZVMjWVtIkV9VO?=
 =?us-ascii?Q?qQ9h4ich34DMbDRci4EUwwMg6FdFObXvLgxsbMzS+p7uvG0KazeefbucgJbt?=
 =?us-ascii?Q?fja1F8+lEzJFy9TzzJEhNmMMpTB7rS0/+eqxwIi0ngfbyuM5H+boIFSZknAy?=
 =?us-ascii?Q?pt31trDCXbmE3MUUzK10cfB4SxfWammo6bItFjIyjC3ruWT/kFaALn1VXlTN?=
 =?us-ascii?Q?ketUVkZ5DqImTgCbUsFbWk7i6V/8nW4B6PCqMWEjwE5jClatYtNfuAtawG5l?=
 =?us-ascii?Q?u/df7lVRHjRD2zMmJ0Qb7aBmwlICF6r7EaHNOwrmzyds9ocsgB8NLdr/n4Dw?=
 =?us-ascii?Q?7/6umT2KYQbcKE1xlZ8TneRRgEzPjpB5+p3dArxE1XOOEmAj/W3QNAAKK61I?=
 =?us-ascii?Q?xYHrsne01l9Z2ECBBGa1Mxw5Yhi82h6Vn5kS35JawW9AU5H/+Ev8TJoz2Xkz?=
 =?us-ascii?Q?S/A4I8A3mhdawxoVA0GO+tFnWVzWDdgTkoPRqgC79LOTP2hIa6IcSo6Ki6IR?=
 =?us-ascii?Q?lMeQo66G9Jmsek63Km58PArbEMiLrZaGZxEipSqP96xOhSzdrf2n7bnHYCNj?=
 =?us-ascii?Q?yRCIq4kAW5hig6x6Ou6tEepSMEC48KsgCWN7mKsbYAgOVazhvLfmpQnRfP5c?=
 =?us-ascii?Q?/pDLuXEwThD5H1XyWqhdW2+nDcC3/vil4B4FCIwRK1LyQX0UusSCWXcdgUrZ?=
 =?us-ascii?Q?KuLVRH14g0mlSqakp98BepIqnfhIG88t/1zinMqKBYY5u/Bo4rLSjE+7aLAc?=
 =?us-ascii?Q?dCuVHNf+SX7GmOk7AOZzG+wyMVCRCslzjiSEftKDJ7D8iwP8aPxMFjZr4k3N?=
 =?us-ascii?Q?dhexYKja06jBEJCOgXVSbW1M3Pa5TI+A5ljpNaLzKqIg4jGBg/l+2Vfd2Md4?=
 =?us-ascii?Q?8Yo8x1g8NPvC+dE+/Pv2Gq3iJgbVIWGX+zMhZJM1/SdylzuIBtMVQeQfSdRH?=
 =?us-ascii?Q?6N92BcSQ/SkhSxiOwUDMDLDnFMne1XF/FJm7/c5NP7Zc8ghivIMcO/Q5nsQy?=
 =?us-ascii?Q?+5xxH0waaqbz2tUrgYQfgli7RK1ejJpSYJ3niLoooh5D679MfolVWPjzkore?=
 =?us-ascii?Q?GL2+HiZdbXE8jiTknIaM0tD4CLdiCnStwvldB28IZFlvBrue6e3Sv1C3SjYi?=
 =?us-ascii?Q?ZaXE/v5x2UT4NT4zPGTd7bTmstLDZXIRln7U1NjYvDmHAxLfJoBAPOkobKZA?=
 =?us-ascii?Q?OkVlXgGyarQUhM0f7UpDC/BSBj3vy8wQfz9V2cOJv6bjP71+7i28qt+SwTol?=
 =?us-ascii?Q?iWpJcXWdzCa14WqLT3NhfdHzsdhPS4Ow4kRVcTRcUEeM7NVlwxTyllkeiHZM?=
 =?us-ascii?Q?7EwV7wdrcDH9mtb3MciyKZjZYmmXSZIYgoHU5wXt?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 6db502b1-aebb-4142-c525-08db310ec095
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 11:06:03.4763
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mBZ5OHDGW8givoVtNr4LspRGh3wVs/SjPPdoQ35wBeHZ+vzfoP2CS6hajmO9U2ExpoM65iZkV4GOG9EXwvO+ug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO6P265MB6144
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Mar 2023 22:33:29 +0000
y86-dev@protonmail.com wrote:

> From: Benno Lossin <y86-dev@protonmail.com>
> 
> The `stack_pin_init!` macro allows pin-initializing a value on the
> stack. It accepts a `impl PinInit<T, E>` to initialize a `T`. It allows
> propagating any errors via `?` or handling it normally via `match`.
> 
> Signed-off-by: Benno Lossin <y86-dev@protonmail.com>
> ---
>  rust/kernel/init.rs            | 70 +++++++++++++++++++++++++++++++---
>  rust/kernel/init/__internal.rs | 46 ++++++++++++++++++++++
>  2 files changed, 110 insertions(+), 6 deletions(-)
> 
> diff --git a/rust/kernel/init.rs b/rust/kernel/init.rs
> index 428b5c2ac516..3358f14beffb 100644
> --- a/rust/kernel/init.rs
> +++ b/rust/kernel/init.rs
> @@ -12,7 +12,8 @@
>  //!
>  //! To initialize a `struct` with an in-place constructor you will need two things:
>  //! - an in-place constructor,
> -//! - a memory location that can hold your `struct`.
> +//! - a memory location that can hold your `struct` (this can be the [stack], an [`Arc<T>`],
> +//!   [`UniqueArc<T>`], [`Box<T>`] or any other smart pointer that implements [`InPlaceInit`]).
>  //!
>  //! To get an in-place constructor there are generally three options:
>  //! - directly creating an in-place constructor using the [`pin_init!`] macro,
> @@ -180,6 +181,7 @@
>  //! [pinning]: https://doc.rust-lang.org/std/pin/index.html
>  //! [structurally pinned fields]:
>  //!     https://doc.rust-lang.org/std/pin/index.html#pinning-is-structural-for-field
> +//! [stack]: crate::stack_pin_init
>  //! [`Arc<T>`]: crate::sync::Arc
>  //! [`impl PinInit<Foo>`]: PinInit
>  //! [`impl PinInit<T, E>`]: PinInit
> @@ -199,6 +201,62 @@ pub mod __internal;
>  #[doc(hidden)]
>  pub mod macros;
> 
> +/// Initialize and pin a type directly on the stack.
> +///
> +/// # Examples
> +///
> +/// ```rust
> +/// # #![allow(clippy::disallowed_names, clippy::new_ret_no_self)]
> +/// # use kernel::{init, pin_init, stack_pin_init, init::*, sync::Mutex, new_mutex};
> +/// # use macros::pin_data;
> +/// # use core::pin::Pin;
> +/// #[pin_data]
> +/// struct Foo {
> +///     #[pin]
> +///     a: Mutex<usize>,
> +///     b: Bar,
> +/// }
> +///
> +/// #[pin_data]
> +/// struct Bar {
> +///     x: u32,
> +/// }
> +///
> +/// let a = new_mutex!(42, "Foo::a");
> +///
> +/// stack_pin_init!(let foo =? pin_init!(Foo {
> +///     a,
> +///     b: Bar {
> +///         x: 64,
> +///     },
> +/// }));
> +/// let foo: Pin<&mut Foo> = foo;
> +/// # Ok::<(), core::convert::Infallible>(())
> +/// ```
> +///
> +/// # Syntax
> +///
> +/// A normal `let` binding with optional type annotation. The expression is expected to implement
> +/// [`PinInit`]. Additionally a `?` can be put after the `=`, this will assign `Pin<&mut T>` to the
> +/// variable instead of `Result<Pin<&mut T>, E>`.
> +#[macro_export]
> +macro_rules! stack_pin_init {
> +    (let $var:ident $(: $t:ty)? = $val:expr) => {
> +        let mut $var = $crate::init::__internal::StackInit$(::<$t>)?::uninit();
> +        let mut $var = {
> +            let val = $val;
> +            unsafe { $crate::init::__internal::StackInit::init(&mut $var, val) }
> +        };
> +    };
> +    (let $var:ident $(: $t:ty)? =? $val:expr) => {
> +        let mut $var = $crate::init::__internal::StackInit$(::<$t>)?::uninit();
> +        let mut $var = {
> +            let val = $val;
> +            unsafe { $crate::init::__internal::StackInit::init(&mut $var, val)? }
> +        };
> +    };
> +}
> +
>  /// Construct an in-place, pinned initializer for `struct`s.
>  ///
>  /// This macro defaults the error to [`Infallible`]. If you need [`Error`], then use
> @@ -916,8 +974,8 @@ macro_rules! try_init {
>  /// A pinned initializer for `T`.
>  ///
>  /// To use this initializer, you will need a suitable memory location that can hold a `T`. This can
> -/// be [`Box<T>`], [`Arc<T>`], [`UniqueArc<T>`]. Use the [`InPlaceInit::pin_init`] function of a
> -/// smart pointer like [`Arc<T>`] on this.
> +/// be [`Box<T>`], [`Arc<T>`], [`UniqueArc<T>`] or even the stack (see [`stack_pin_init!`]). Use the
> +/// [`InPlaceInit::pin_init`] function of a smart pointer like [`Arc<T>`] on this.
>  ///
>  /// Also see the [module description](self).
>  ///
> @@ -952,9 +1010,9 @@ pub unsafe trait PinInit<T: ?Sized, E = Infallible>: Sized {
>  /// An initializer for `T`.
>  ///
>  /// To use this initializer, you will need a suitable memory location that can hold a `T`. This can
> -/// be [`Box<T>`], [`Arc<T>`], [`UniqueArc<T>`]. Use the [`InPlaceInit::init`] function of a smart
> -/// pointer like [`Arc<T>`] on this. Because [`PinInit<T, E>`] is a super trait, you can
> -/// use every function that takes it as well.
> +/// be [`Box<T>`], [`Arc<T>`], [`UniqueArc<T>`] or even the stack (see [`stack_pin_init!`]). Use the
> +/// [`InPlaceInit::init`] function of a smart pointer like [`Arc<T>`] on this. Because
> +/// [`PinInit<T, E>`] is a super trait, you can use every function that takes it as well.
>  ///
>  /// Also see the [module description](self).
>  ///
> diff --git a/rust/kernel/init/__internal.rs b/rust/kernel/init/__internal.rs
> index 4a3c7bf27a06..bf33c8e96e6d 100644
> --- a/rust/kernel/init/__internal.rs
> +++ b/rust/kernel/init/__internal.rs
> @@ -89,6 +89,52 @@ unsafe impl<T: ?Sized> HasInitData for T {
>      }
>  }
> 
> +/// Stack initializer helper type. Use [`stack_pin_init`] instead of this primitive.
> +///
> +/// # Invariants
> +///
> +/// If `self.1` is true, then `self.0` is initialized.
> +///
> +/// [`stack_pin_init`]: kernel::stack_pin_init
> +pub struct StackInit<T>(MaybeUninit<T>, bool);
> +
> +impl<T> Drop for StackInit<T> {
> +    #[inline]
> +    fn drop(&mut self) {
> +        if self.1 {
> +            // SAFETY: As we are being dropped, we only call this once. And since `self.1 == true`,
> +            // `self.0` has to be initialized.
> +            unsafe { self.0.assume_init_drop() };
> +        }
> +    }
> +}
> +
> +impl<T> StackInit<T> {
> +    /// Creates a new [`StackInit<T>`] that is uninitialized. Use [`stack_pin_init`] instead of this
> +    /// primitive.
> +    ///
> +    /// [`stack_pin_init`]: kernel::stack_pin_init
> +    #[inline]
> +    pub fn uninit() -> Self {
> +        Self(MaybeUninit::uninit(), false)
> +    }
> +
> +    /// Initializes the contents and returns the result.
> +    ///
> +    /// # Safety
> +    ///
> +    /// The caller ensures that `self` is on the stack and not accessible in any other way, if this
> +    /// function returns `Ok`.
> +    #[inline]
> +    pub unsafe fn init<E>(&mut self, init: impl PinInit<T, E>) -> Result<Pin<&mut T>, E> {

Could this be made safe if the signature takes `self: Pin<&mut Self>`
instead?

The std `pin!` macro is stable in
1.68 so we can just `core::pin::pin!(StackInit::uninit())` and then
call `init` on it.

Best,
Gary

> +        // SAFETY: The memory slot is valid and this type ensures that it will stay pinned.
> +        unsafe { init.__pinned_init(self.0.as_mut_ptr())? };
> +        self.1 = true;
> +        // SAFETY: The slot is now pinned, since we will never give access to `&mut T`.
> +        Ok(unsafe { Pin::new_unchecked(self.0.assume_init_mut()) })
> +    }
> +}
> +
>  /// When a value of this type is dropped, it drops a `T`.
>  ///
>  /// Can be forgotton to prevent the drop.
> --
> 2.39.2
> 
> 

