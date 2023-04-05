Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8386E6D879D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 22:00:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234051AbjDEUAS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 16:00:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233050AbjDEUAD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 16:00:03 -0400
Received: from GBR01-CWL-obe.outbound.protection.outlook.com (mail-cwlgbr01on2132.outbound.protection.outlook.com [40.107.11.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12FEE4EDB;
        Wed,  5 Apr 2023 12:59:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eOru2GbfDPo7Rxyn6UnlMjh8BuMAudT81Kje4YKOqzVOnAABsydQQbV2Tth/fl8pnIAr4+9wsHhpJB3omFp8B7NYUcgovNz8pn44LXDPTi8ZA/xXBf8k4cg8WvEWIlp/tnMhKJoRQYKZscTSz4DjtsNfPcnANlfFcOUJMCY5pg7XqOcD8kPpD7NGFDLnFf0U5x45OQca8xg/LYU8OCvEKuZm7QsZG31hiz3Y491YZbfRtDJLKfh5Ue74OVAOcVfEkA67PuIBvtB75ZKMbLSZ8aTjMvC76auMt/+EWQxfOMFUbLvgxcr982/nkE6fRqwqwYZoKA7aTjVF6QfreDgVog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qOyuiYm2CpCJ4VDAounHSJVibbnVCBXMflER2CKDK1U=;
 b=iP+F+5Q0qDg+8zJKUKoQNW7cWxqEZc9NyWPcJ3KtwA0hOvDeB202M2Zkc1XxbQtyniDpALIOLQrT/hr6EH8LWZCrYL5WAseq2nJpnLoocIOZ14zM3NT+j52F5c3WJ2rcaPram+4A5B7ERMv8Kf9xR0nexjNU/AtQD14swF5+BJ/TzrYYeRA+JQ+Nyv2FqFHGA+Ox7V93+JbqpFOerDMAPeZZyCTuLxQLuOMJSYlDZGSaPc4QJz8WiYgc3RJXcPzVva30dSaIWq90Tnjlx/qT1rmriA2upgByuPFg33lofNAGTLMR42itTHyqbypi/kYe4cQ8eHXHdMJu+3oiexscTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qOyuiYm2CpCJ4VDAounHSJVibbnVCBXMflER2CKDK1U=;
 b=Bo9wtrcgRnu+RYRJ3XXpz75Z3bHjoh1JZ9NLGAlmXoxSyte0A2Y6Xz/Fi5iXv0Ubera3nQxd6wSxwCmNjQ9aT6kSNRGnHJj8rwHS2a9pwC6rahxW2O09MUHk52KiT83CPgMth775+2NKe5zeAYQlQX2J8uX99bInfvXDEVqOp8g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LNXP265MB2539.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:126::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Wed, 5 Apr
 2023 19:59:51 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::e1a3:5e38:b483:8161]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::e1a3:5e38:b483:8161%5]) with mapi id 15.20.6254.035; Wed, 5 Apr 2023
 19:59:51 +0000
Date:   Wed, 5 Apr 2023 20:59:49 +0100
From:   Gary Guo <gary@garyguo.net>
To:     Benno Lossin <y86-dev@protonmail.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        =?UTF-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
        Alice Ryhl <alice@ryhl.io>,
        Andreas Hindborg <nmi@metaspace.dk>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Alice Ryhl <aliceryhl@google.com>,
        Andreas Hindborg <a.hindborg@samsung.com>
Subject: Re: [PATCH v6 10/15] rust: init: add `stack_pin_init!` macro
Message-ID: <20230405205949.33d20a4d.gary@garyguo.net>
In-Reply-To: <20230405193445.745024-11-y86-dev@protonmail.com>
References: <20230405193445.745024-1-y86-dev@protonmail.com>
        <20230405193445.745024-11-y86-dev@protonmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0279.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:195::14) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LNXP265MB2539:EE_
X-MS-Office365-Filtering-Correlation-Id: 824de76c-248c-49b3-9fe6-08db3610514c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kr7GgPk4DVw5O+UqlxcOd2sMPcq31RidU4bFapyCh+fD67PNwVVlMx8mQkASY5y711Dmpygneq1JxFvoFwbwDPvmmQrmsq+M4W7KMh9z58fR7eKtkcT4Js4PaPuAOVbjs/hxE9D0c3wWOXS6gkeLNOIMVl+vtMS07FyKuh3BZ5E/JCVvPsvJRgz3FXaF899oSP/Tcp8vGBEoaBUSe2J55vmgpkBh8ITD4TlRB4EP5BM2ZdNRUYegZm1x+hv7xJXuPoPhLDBA5QbFaoqOA3v35h5dPeHUy0MLzjsUQY4bazZi+o74POolKOuyA6/ZGGEZHNZ/fc9Pps+katVQtjBCNluZIMNI10u2ONURnYmtXpjA8X5R2TXhsPQZ1ZpCXJLDSiepN9HszR5UOkU7yaVRdNVB8D1+Nv25bRwC3iWx+2HsW1wl/j9GvAWb5qtnksRinhvY1+LFrLItpkmcVnhhb+JQA8fek1/GAnV3kZd5tWjAEbN9O39UQ3uv682UmrWyYXiyYpiMSShYTafXP+f/JEaYh2RgcKRDI1L6QTO/Zuhpaye9BRO9JYz44RDszvnpxY5RFAsGPY/jNaBBzFDJTXWbh3PN3QxB9CesPXm86ws=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(376002)(346002)(39830400003)(396003)(136003)(366004)(451199021)(478600001)(316002)(7416002)(54906003)(5660300002)(8936002)(36756003)(2906002)(4326008)(6916009)(86362001)(8676002)(38100700002)(66556008)(41300700001)(6512007)(6506007)(83380400001)(1076003)(26005)(66946007)(966005)(6486002)(2616005)(66476007)(186003)(81973001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LlhRswF6xC3A6Oi72+MRnFkVb16ZMb1jV20myhQNrDWIWvJ/R7ES7u6cNcGY?=
 =?us-ascii?Q?2t6W+7Mt0cToP6YTAneFebgSIAim6+Nf3kxWqGg2xs1ZJg5oi46rmuwphcsS?=
 =?us-ascii?Q?JnCHF+fAMROF88VfGC61Q07OdXijXQuSdkHKT5tzr5kNtbXZ0zR1la/S2sVC?=
 =?us-ascii?Q?y2AmWN1cjItD6q0We3bMgWEH5DgoDMlHoXPO5qRhUzM2sAmdAmbjSfX/tXg+?=
 =?us-ascii?Q?2iIk2YcU1ZqMrhL75LhyoQ2Vab53rsCOpKHnrV6ZjEBxtIz5w4X3kBKWCu9u?=
 =?us-ascii?Q?b6Z8S0J74KEzdpQu9i90ptdi1IMsuARLgI7V+iUMIYqbB30ND8LhPNB1QxzD?=
 =?us-ascii?Q?AzXIJqKwc/YY1GYPd8z/DvMQBw3yA8/9Nv5wVjB5Uh5Iq1zgTV6eSU/0LErh?=
 =?us-ascii?Q?ZPcXSGt9QzrNShqWouchF64hO08EMV4l8z5kbQGHPdZVoZERzNHMcCRLdeQL?=
 =?us-ascii?Q?OC80qYYZ9ioNVmaSFAtKlrnEAUmo/WODpJRFYb9Yw/eTpLuk3/S25r3nG7g2?=
 =?us-ascii?Q?KKEuTvMzbLyQbQEuaBtsf5IdUR1BZW6XjmNrRALNCM6OMPrOY4+vGooTnhev?=
 =?us-ascii?Q?8obaLmoVQ04lzt1cNdwxe3l8VSMXM+n8s3G3UWXlH5xHT73lBxe2RQXINehC?=
 =?us-ascii?Q?YFpqwx7u08i7YOX+UYyZU7ecbGwK+B3g4he5pfLsTIyp95K1M/m0SYgWnT0T?=
 =?us-ascii?Q?ICKxhptoGFOMTZ77B1P73W3pJQy3IhKIYXZcNTUZylRdPrbqt2WbFhPnBuhn?=
 =?us-ascii?Q?XKCvj28zI206ifO83aqnJd3DVWoVKCyYni46bHUV707sZCl36Ko/3IdMQfkE?=
 =?us-ascii?Q?k5Rf6NyUFuDFbtlF4dSl27sqiuyYsLgLz45dWGo6E+3xKC2JGh9TeJHehkd9?=
 =?us-ascii?Q?SmLGYrWHsgkO78qCejCvknnvK69Uv17nDS/QHfhB8fIjFtt7XjrfbLKBzh1r?=
 =?us-ascii?Q?yJQx5r0MQId/lU022nwP4HIHC1f4m1vpZYZRYRUFnrE6mEems/XyIKgXGD0k?=
 =?us-ascii?Q?9qRAUk4BaprqBPRozOw4nbj6JtmtCghxhXZ/y4nu43cHQFi4oToZFfi5j5Wq?=
 =?us-ascii?Q?q5+nnci1SPl4Q0dJOx4i/+WLgtBG8u34eAr/y4ZDQkBJYJzhC4dhjCqQpCLG?=
 =?us-ascii?Q?EAeH3VoU0Z8gm7X6PgOaWydm/A11hN21Hvwbp8WeRw0USALcD4zmAD99t2HE?=
 =?us-ascii?Q?qmnkYWiXkPubioZ/LBurnE1SAxCNtj1jBUlae+f5J/qXkobdVhb6EgZ42GNP?=
 =?us-ascii?Q?DnZ6TaKxVshG4aBSbk0sW6Q+nqoDN0yjAx3UUZgjyh4hA1np253cXEsxZe+E?=
 =?us-ascii?Q?qWY5fcwQet5JltUFgxSa54c2n415vyTI22c+Rf3RLgKT9p1yt9cgo06A/dmQ?=
 =?us-ascii?Q?yCklqfYCLkEH8h/kIDv4DkdlRMyog/9oCyG8SQJWpphFEOtnEGSc5liU2CXe?=
 =?us-ascii?Q?famCgvsjeHBQh0v5EwNkCundYZfdoC5sy9AdDUDa00rltAyuIgJQRmRSZrAm?=
 =?us-ascii?Q?QDlxD9Z5OteLPnleBCIgKB791mNEh2PupIzFwHo/53JmeCFMdjwPCqQyDTp1?=
 =?us-ascii?Q?9x0ejkfeDdCpwIt7TObNJcZrbr/XSRMwD/F5G6Og?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 824de76c-248c-49b3-9fe6-08db3610514c
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2023 19:59:51.5858
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WjX5TrVNlls8XuTZS6YgTK2/SqSFzaQ8oWLfsL815rTIC78mLmBR2RVBvfMRdho2GgNkbmSvw62B2W6jKqAjQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LNXP265MB2539
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 05 Apr 2023 19:36:29 +0000
Benno Lossin <y86-dev@protonmail.com> wrote:

> The `stack_pin_init!` macro allows pin-initializing a value on the
> stack. It accepts a `impl PinInit<T, E>` to initialize a `T`. It allows
> propagating any errors via `?` or handling it normally via `match`.
> 
> Signed-off-by: Benno Lossin <y86-dev@protonmail.com>
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Cc: Andreas Hindborg <a.hindborg@samsung.com>
> Cc: Gary Guo <gary@garyguo.net>

Reviewed-by: Gary Guo <gary@garyguo.net>

Code-wise this looks fine, there is a nit about comments below.

> ---
>  rust/kernel/init.rs            | 140 +++++++++++++++++++++++++++++++--
>  rust/kernel/init/__internal.rs |  50 ++++++++++++
>  2 files changed, 184 insertions(+), 6 deletions(-)
> 
> diff --git a/rust/kernel/init.rs b/rust/kernel/init.rs
> index 37e8159df24d..99751375e7c8 100644
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
> @@ -202,6 +204,132 @@ pub mod __internal;
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
> +/// stack_pin_init!(let foo = pin_init!(Foo {
> +///     a <- new_mutex!(42),
> +///     b: Bar {
> +///         x: 64,
> +///     },
> +/// }));
> +/// let foo: Pin<&mut Foo> = foo;
> +/// pr_info!("a: {}", &*foo.a.lock());
> +/// ```
> +///
> +/// # Syntax
> +///
> +/// A normal `let` binding with optional type annotation. The expression is expected to implement
> +/// [`PinInit`]/[`Init`] with the error type [`Infallible`]. If you want to use a different error
> +/// type, then use [`stack_try_pin_init!`].
> +#[macro_export]
> +macro_rules! stack_pin_init {
> +    (let $var:ident $(: $t:ty)? = $val:expr) => {
> +        let val = $val;
> +        let mut $var = ::core::pin::pin!($crate::init::__internal::StackInit$(::<$t>)?::uninit());
> +        let mut $var = match $crate::init::__internal::StackInit::init($var, val) {
> +            Ok(res) => res,
> +            Err(x) => {
> +                let x: ::core::convert::Infallible = x;
> +                match x {}
> +            }
> +        };
> +    };
> +}
> +
> +/// Initialize and pin a type directly on the stack.
> +///
> +/// # Examples
> +///
> +/// ```rust
> +/// # #![allow(clippy::disallowed_names, clippy::new_ret_no_self)]
> +/// # use kernel::{init, pin_init, stack_try_pin_init, init::*, sync::Mutex, new_mutex};
> +/// # use macros::pin_data;
> +/// # use core::{alloc::AllocError, pin::Pin};
> +/// #[pin_data]
> +/// struct Foo {
> +///     #[pin]
> +///     a: Mutex<usize>,
> +///     b: Box<Bar>,
> +/// }
> +///
> +/// struct Bar {
> +///     x: u32,
> +/// }
> +///
> +/// stack_try_pin_init!(let foo: Result<Pin<&mut Foo>, AllocError> = pin_init!(Foo {
> +///     a <- new_mutex!(42),
> +///     b: Box::try_new(Bar {
> +///         x: 64,
> +///     })?,
> +/// }));
> +/// let foo = foo.unwrap();
> +/// pr_info!("a: {}", &*foo.a.lock());
> +/// ```
> +///
> +/// ```rust
> +/// # #![allow(clippy::disallowed_names, clippy::new_ret_no_self)]
> +/// # use kernel::{init, pin_init, stack_try_pin_init, init::*, sync::Mutex, new_mutex};
> +/// # use macros::pin_data;
> +/// # use core::{alloc::AllocError, pin::Pin};
> +/// #[pin_data]
> +/// struct Foo {
> +///     #[pin]
> +///     a: Mutex<usize>,
> +///     b: Box<Bar>,
> +/// }
> +///
> +/// struct Bar {
> +///     x: u32,
> +/// }
> +///
> +/// stack_try_pin_init!(let foo: Pin<&mut Foo> =? pin_init!(Foo {
> +///     a <- new_mutex!(42),
> +///     b: Box::try_new(Bar {
> +///         x: 64,
> +///     })?,
> +/// }));
> +/// pr_info!("a: {}", &*foo.a.lock());
> +/// # Ok::<_, AllocError>(())
> +/// ```
> +///
> +/// # Syntax
> +///
> +/// A normal `let` binding with optional type annotation. The expression is expected to implement
> +/// [`PinInit`]/[`Init`]. This macro assigns a result to the given variable, adding a `?` after the
> +/// `=` will propagate this error.
> +#[macro_export]
> +macro_rules! stack_try_pin_init {
> +    (let $var:ident $(: $t:ty)? = $val:expr) => {
> +        let val = $val;
> +        let mut $var = ::core::pin::pin!($crate::init::__internal::StackInit$(::<$t>)?::uninit());
> +        let mut $var = $crate::init::__internal::StackInit::init($var, val);
> +    };
> +    (let $var:ident $(: $t:ty)? =? $val:expr) => {
> +        let val = $val;
> +        let mut $var = ::core::pin::pin!($crate::init::__internal::StackInit$(::<$t>)?::uninit());
> +        let mut $var = $crate::init::__internal::StackInit::init($var, val)?;
> +    };
> +}
> +
>  /// Construct an in-place, pinned initializer for `struct`s.
>  ///
>  /// This macro defaults the error to [`Infallible`]. If you need [`Error`], then use
> @@ -913,8 +1041,8 @@ macro_rules! try_init {
>  /// A pin-initializer for the type `T`.
>  ///
>  /// To use this initializer, you will need a suitable memory location that can hold a `T`. This can
> -/// be [`Box<T>`], [`Arc<T>`], [`UniqueArc<T>`]. Use the [`InPlaceInit::pin_init`] function of a
> -/// smart pointer like [`Arc<T>`] on this.
> +/// be [`Box<T>`], [`Arc<T>`], [`UniqueArc<T>`] or even the stack (see [`stack_pin_init!`]). Use the
> +/// [`InPlaceInit::pin_init`] function of a smart pointer like [`Arc<T>`] on this.
>  ///
>  /// Also see the [module description](self).
>  ///
> @@ -949,9 +1077,9 @@ pub unsafe trait PinInit<T: ?Sized, E = Infallible>: Sized {
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
> index 69be03e17c1f..600b6442c6e9 100644
> --- a/rust/kernel/init/__internal.rs
> +++ b/rust/kernel/init/__internal.rs
> @@ -112,6 +112,56 @@ unsafe impl<T: ?Sized> HasInitData for T {
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
> +    #[inline]
> +    pub fn init<E>(self: Pin<&mut Self>, init: impl PinInit<T, E>) -> Result<Pin<&mut T>, E> {
> +        // SAFETY: We never move out of `this`.
> +        let this = unsafe { Pin::into_inner_unchecked(self) };
> +        // The value is currently initialized, so it needs to be dropped before we can reuse
> +        // the memory (this is a safety guarantee of `Pin`).
> +        if this.1 {

// INVARIANT: `this.0` is dropped below.

> +            this.1 = false;

// SAFETY: `this.1` was true and therefore `this.0` is initialized.

> +            // SAFETY: `this.1` was true and we set it to false.
> +            unsafe { this.0.assume_init_drop() };
> +        }
> +        // SAFETY: The memory slot is valid and this type ensures that it will stay pinned.
> +        unsafe { init.__pinned_init(this.0.as_mut_ptr())? };

// INVARIANT: `this.0` is initialized above.

> +        this.1 = true;
> +        // SAFETY: The slot is now pinned, since we will never give access to `&mut T`.
> +        Ok(unsafe { Pin::new_unchecked(this.0.assume_init_mut()) })
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

