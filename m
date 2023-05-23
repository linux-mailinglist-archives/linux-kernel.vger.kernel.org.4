Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E024D70E1A1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 18:21:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237155AbjEWQQO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 12:16:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236100AbjEWQQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 12:16:11 -0400
Received: from GBR01-CWL-obe.outbound.protection.outlook.com (mail-cwlgbr01on2094.outbound.protection.outlook.com [40.107.11.94])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A329C2;
        Tue, 23 May 2023 09:16:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L571I0l5GZpJpN712fredus6xEcUmN784RunqiAmvFICvwrITu+r8Bwg8S2r/memzP9pShaPd4o/n56ARc43v28Isn/IkVtsl6mdhea4vVWu9sKEj6W9d7emXTfuP29Z+OnuT/+qzqmgXyy9OmHHjRgPoi3l0xBpIZK99GTFrDGY67qsXa2iHWDOldcNqvNlbi7DF8KvaPMBOyuPfcG4nb7Pd1EW9+x2vhyKztwVcdD262jkyMBvgJ8sS6SqQ+qmqM2LgzNmryUGL2ZJE7/hA52hNnVy5UsMbaoBCbH+9kQMzXFEcObgh3pZaPpBeZkt5aY2EYEY3xgFt2+zsik7EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kWNwlRTGVitowBlEGl+F1tjYEryxdl5JKH60q4MeVqE=;
 b=cL+Ekpq9rRRgq/mI22OUL6xrz58PHSdWrgaZAfL9QELKg6jpjJCDsPqstDfuCo/T2F+xd3ue3l409vinUKNy5HO0QYU0YK8T/pdjnv6N1K4B/NxvVE8NPfMkuPFOH5BCIIc2N19t25nZE2hwc1B56jBQwHuaSqnAC4b1tOkI4kn0nQMTe551FJVyAz7lU09ZkZDHUYGHAu5htIi0SR8czU/w0Oihp/UDive54/cxJaid4tAMBIrv/p7xlw8s5ljuOAmFW8sfw3FID1oylvUWhFT8YDnlxESgoOcyUXlBn2v4bktBEV3vihoyBmssVT4jsy+/DdXUbwyOBvwNXUB7Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kWNwlRTGVitowBlEGl+F1tjYEryxdl5JKH60q4MeVqE=;
 b=Z+d0hVIU4veoGF+WNmLwcqi2vo+7MXkR/0oXsof/WgUWG/nJ2TDs/EPSt97u0VmmUeN819WDVkou/1G5hUlKqatQAxC9o5cN0UCXxXjx9IBQMk0nqo57n9iN4/YbIvWbZDRwvFR/Gw8Nl7nTQytdHa+yNA+dRD8SMM7ijuMBEh0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LO6P265MB6256.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:2b6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.14; Tue, 23 May
 2023 16:16:02 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1d51:d482:270c:7daf]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1d51:d482:270c:7daf%4]) with mapi id 15.20.6433.013; Tue, 23 May 2023
 16:16:02 +0000
Date:   Tue, 23 May 2023 17:15:59 +0100
From:   Gary Guo <gary@garyguo.net>
To:     Benno Lossin <benno.lossin@proton.me>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        =?UTF-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev
Subject: Re: [PATCH 4/4] rust: init: update macro expansion example in docs
Message-ID: <20230523171559.7458afc1.gary@garyguo.net>
In-Reply-To: <20230424081112.99890-4-benno.lossin@proton.me>
References: <20230424081112.99890-1-benno.lossin@proton.me>
        <20230424081112.99890-4-benno.lossin@proton.me>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P123CA0032.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600::20)
 To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LO6P265MB6256:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e88e6bc-837f-4f47-eea0-08db5ba900c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ur1i0CTMJpdl25+LEZ0YshnLSn9vsxoR7V54gTFmRADfebQe2byyc+pGbsSjhWRFpfCrpZDRlVHyPEjc37CKyJvTr2a1oZJV1E8+VN8uS3ZdXPCImt3LaK6JlUJNCCFgHid/7/8JYortLisYILFvgkikX5FIbyWmCot+V7gy0KFZAuqbW4oxUQ8AgL8dARw+x4WUEH71S9Nw2/E8FlHizS0gYoda/xjAtiFqEjbH+yWDG7lC8vU5NYIKAUzQ0MOF8/81RAbvZbo4VzemZ+QnEsBCZIy/6DWGbsYZjXhk4WZFXMho3ZG2NdErb3G27yCER/mPw+xY+JD0MrwrtzXeluEaaBWDg2GnMlN6NKjLp2k2OW6FEf5P1EsalDl9d9ENZzN9PPPgn1ZgeD+RFdnfkCC5bUOsoa/Ycq8EWXP34VEig5wpsNfno6Dp5D3DQt1gRlMCcmH0Cf6fHz3cIFC/2htoLT4CEltNxEBYJh1yxAxnPb9Na9UG8soJ6R9qD922iiK/tPcQxxZ8zcI9r/NOZTLvrhIVAH3CuiGafc6P5WfhxPzt3HLTQBxrdJ5IobiT
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(39840400004)(376002)(396003)(366004)(346002)(136003)(451199021)(186003)(6512007)(6506007)(1076003)(26005)(2616005)(83380400001)(36756003)(6666004)(6486002)(2906002)(316002)(54906003)(5660300002)(8676002)(478600001)(4326008)(66946007)(66556008)(66476007)(38100700002)(86362001)(6916009)(8936002)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?m2w8jCVSYwYobuTlb8ExVM+dGxBIRE64trYtKCKiYmqDnx17MrjbvN962Wne?=
 =?us-ascii?Q?LhHulgN/LCN/bsUuxRg92F8H7tMbTheqkAEPlD+Z1vcbQmEmDntkwpzfpS/+?=
 =?us-ascii?Q?L+Mq38tqcu/KpzPbhZrhEKLd8qU4UyL+IRF714rjjDCcjIc09h8zPNmU9qnR?=
 =?us-ascii?Q?ukPAZ31hTckPfxfu6hGHgX1U/i28Wsoh0SEQJSl90uFsoRgdVXCQqoDjGJWe?=
 =?us-ascii?Q?0FT9z0o9yh/tnN+JagqbxFzhRJh9Bs8gwf8OafcC7mBKMikSGdZPdm/8KicI?=
 =?us-ascii?Q?3Q53ynQqOODdPf0udWISkjO6KCvjRPHi9BRYJObujD3isoVM4gfM1XLa0HwT?=
 =?us-ascii?Q?m/zjEEXvLnebxmzpNLHz8fM3NuPpb/MEwQFfkDckkk/7/WKZbeQKVdTvuHH5?=
 =?us-ascii?Q?fE193/3RKxZnLbGGvJ30ylhV9XZfH87bjkJ3lsmd+MqXcrwAaQtj7/PHyj7D?=
 =?us-ascii?Q?b+cxm3OD/d4qzl+DGaBH+Lm8OQDpXQ9SRIykA3L6yzaQEyK4Pf56g/qi59zZ?=
 =?us-ascii?Q?9ZxIC8YX5XPKiOoF7anw0Ot0ijz2i9I7Np4HF4On4Ti0sM7Gh15kkOq7QXqY?=
 =?us-ascii?Q?++PfdMEU/FGo6YsXsO79v5i+R6ZuQdxz7tSoG84HY0N9ZKE35Ps+JNxitJQ6?=
 =?us-ascii?Q?jfCE7Ggni5N/54SpCgv4ShHglqz5zUwr5l3fJdxCyCaaIB8LL4jM5+3z4/HW?=
 =?us-ascii?Q?5K2xHKAjzkfPF/7QOOmXmzw2sPHn6o3kKQx7kHDdzIgeVIyYc5jd6S7DWdRI?=
 =?us-ascii?Q?7y7OM0Ni/g5O+0G2SQAYL/WiL6/nK3Ud/REAHwp07poaytdIzlorCznmnuDu?=
 =?us-ascii?Q?bKazUOmJUW/+6DyAhPXnC3tuBTAOYiTQBdIYHoDkUEgD5V69XsX7xXzrImCF?=
 =?us-ascii?Q?prXLUiOlIxSKK47vEHfGqvoGNZUxkH6ItbV4YFwtBjOYnnqoKcYJFB9R9Rvr?=
 =?us-ascii?Q?Veq6xiohadXXkzXsmp0yPsuZFrxFd7r44foOrjWecTmFKTiP0Wc8v1OgUWPf?=
 =?us-ascii?Q?G3FroZLT/qHu51qBZsccEbE3CfHKQBZK8wr6rT6SVdZV2lvpWWDW/o8cJVYt?=
 =?us-ascii?Q?ds4LonxzM872pFEZQS1KsjOnDYuUBRxz7+Z9U72SNEjJ/jT1czOsnvIG8Jby?=
 =?us-ascii?Q?5slFB1gQuKf9YDOQRpcuaE0MfAwoAQwnFxNWDsPvtMYICyn/afH3klhr+x7J?=
 =?us-ascii?Q?hUDkOgUUaglqE4x9f0FyNJ4Nm9mctuztDd8vSf+Z5o5Fxj1ie/YIlxt1KTYf?=
 =?us-ascii?Q?Ua05OHfWG/cUyEF/ukCq16mMfOyUuX2rxzIHd0tumFrNkPrIM8iDmOVrnLac?=
 =?us-ascii?Q?XRBalaWF3yQauSvJYoDH6tKBs4FMUjVbHsux3d9fHqynV6F38oBlsGVkOtF3?=
 =?us-ascii?Q?pipoIGo9ToFJ4f2Dl00VZl6dAuxsJpOH9Us0QV22FTGa2e2SnxpDFkD1pMfW?=
 =?us-ascii?Q?hnCpVdfato7vh9zmOmbzWQfEfiTQ9aTIW+iPIfByNWOpLZmZ9a/3mZui46cV?=
 =?us-ascii?Q?DofCvT4rs+QbPsgEBwOBcqpVFjqK5rtYUJuviATR3fQUM3lewrZOc5LBMCxK?=
 =?us-ascii?Q?38MMkR0qj4gpTaPQuMcoT1dM1ajUhvj8mTAAjKtf?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e88e6bc-837f-4f47-eea0-08db5ba900c9
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2023 16:16:02.5370
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CYK7LKDkErxTNbOkvtvAUXLfXNIzrxk5AjESi9jZ6OlJlVCmKtePBBNCpN3CqDtZE74BG3eiA/RzdGrUtC0MOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO6P265MB6256
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Apr 2023 08:11:49 +0000
Benno Lossin <benno.lossin@proton.me> wrote:

> Also improve the explaining comments.
> 
> Signed-off-by: Benno Lossin <benno.lossin@proton.me>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  rust/kernel/init/macros.rs | 85 +++++++++++++++++++++-----------------
>  1 file changed, 48 insertions(+), 37 deletions(-)
> 
> diff --git a/rust/kernel/init/macros.rs b/rust/kernel/init/macros.rs
> index 541cfad1d8be..00aa4e956c0a 100644
> --- a/rust/kernel/init/macros.rs
> +++ b/rust/kernel/init/macros.rs
> @@ -16,8 +16,9 @@
>  //!
>  //! We will look at the following example:
>  //!
> -//! ```rust
> +//! ```rust,ignore
>  //! # use kernel::init::*;
> +//! # use core::pin::Pin;
>  //! #[pin_data]
>  //! #[repr(C)]
>  //! struct Bar<T> {
> @@ -71,11 +72,12 @@
>  //!
>  //! Here is the definition of `Bar` from our example:
>  //!
> -//! ```rust
> +//! ```rust,ignore
>  //! # use kernel::init::*;
>  //! #[pin_data]
>  //! #[repr(C)]
>  //! struct Bar<T> {
> +//!     #[pin]
>  //!     t: T,
>  //!     pub x: usize,
>  //! }
> @@ -83,7 +85,7 @@
>  //!
>  //! This expands to the following code:
>  //!
> -//! ```rust
> +//! ```rust,ignore
>  //! // Firstly the normal definition of the struct, attributes are preserved:
>  //! #[repr(C)]
>  //! struct Bar<T> {
> @@ -116,20 +118,22 @@
>  //!         unsafe fn t<E>(
>  //!             self,
>  //!             slot: *mut T,
> -//!             init: impl ::kernel::init::Init<T, E>,
> +//!             // Since `t` is `#[pin]`, this is `PinInit`.
> +//!             init: impl ::kernel::init::PinInit<T, E>,
>  //!         ) -> ::core::result::Result<(), E> {
> -//!             unsafe { ::kernel::init::Init::__init(init, slot) }
> +//!             unsafe { ::kernel::init::PinInit::__pinned_init(init, slot) }
>  //!         }
>  //!         pub unsafe fn x<E>(
>  //!             self,
>  //!             slot: *mut usize,
> +//!             // Since `x` is not `#[pin]`, this is `Init`.
>  //!             init: impl ::kernel::init::Init<usize, E>,
>  //!         ) -> ::core::result::Result<(), E> {
>  //!             unsafe { ::kernel::init::Init::__init(init, slot) }
>  //!         }
>  //!     }
>  //!     // Implement the internal `HasPinData` trait that associates `Bar` with the pin-data struct
> -//!     // that we constructed beforehand.
> +//!     // that we constructed above.
>  //!     unsafe impl<T> ::kernel::init::__internal::HasPinData for Bar<T> {
>  //!         type PinData = __ThePinData<T>;
>  //!         unsafe fn __pin_data() -> Self::PinData {
> @@ -160,6 +164,8 @@
>  //!     struct __Unpin<'__pin, T> {
>  //!         __phantom_pin: ::core::marker::PhantomData<fn(&'__pin ()) -> &'__pin ()>,
>  //!         __phantom: ::core::marker::PhantomData<fn(Bar<T>) -> Bar<T>>,
> +//!         // Our only `#[pin]` field is `t`.
> +//!         t: T,
>  //!     }
>  //!     #[doc(hidden)]
>  //!     impl<'__pin, T>
> @@ -193,7 +199,7 @@
>  //!
>  //! Here is the impl on `Bar` defining the new function:
>  //!
> -//! ```rust
> +//! ```rust,ignore
>  //! impl<T> Bar<T> {
>  //!     fn new(t: T) -> impl PinInit<Self> {
>  //!         pin_init!(Self { t, x: 0 })
> @@ -203,7 +209,7 @@
>  //!
>  //! This expands to the following code:
>  //!
> -//! ```rust
> +//! ```rust,ignore
>  //! impl<T> Bar<T> {
>  //!     fn new(t: T) -> impl PinInit<Self> {
>  //!         {
> @@ -232,25 +238,31 @@
>  //!                     // that will refer to this struct instead of the one defined above.
>  //!                     struct __InitOk;
>  //!                     // This is the expansion of `t,`, which is syntactic sugar for `t: t,`.
> -//!                     unsafe { ::core::ptr::write(&raw mut (*slot).t, t) };
> +//!                     unsafe { ::core::ptr::write(::core::addr_of_mut!((*slot).t), t) };
>  //!                     // Since initialization could fail later (not in this case, since the error
> -//!                     // type is `Infallible`) we will need to drop this field if it fails. This
> -//!                     // `DropGuard` will drop the field when it gets dropped and has not yet
> -//!                     // been forgotten. We make a reference to it, so users cannot `mem::forget`
> -//!                     // it from the initializer, since the name is the same as the field.
> +//!                     // type is `Infallible`) we will need to drop this field if there is an
> +//!                     // error later. This `DropGuard` will drop the field when it gets dropped
> +//!                     // and has not yet been forgotten. We make a reference to it, so users
> +//!                     // cannot `mem::forget` it from the initializer, since the name is the same
> +//!                     // as the field (including hygiene).
>  //!                     let t = &unsafe {
> -//!                         ::kernel::init::__internal::DropGuard::new(&raw mut (*slot).t)
> +//!                         ::kernel::init::__internal::DropGuard::new(
> +//!                             ::core::addr_of_mut!((*slot).t),
> +//!                         )
>  //!                     };
>  //!                     // Expansion of `x: 0,`:
>  //!                     // Since this can be an arbitrary expression we cannot place it inside of
>  //!                     // the `unsafe` block, so we bind it here.
>  //!                     let x = 0;
> -//!                     unsafe { ::core::ptr::write(&raw mut (*slot).x, x) };
> +//!                     unsafe { ::core::ptr::write(::core::addr_of_mut!((*slot).x), x) };
> +//!                     // We again create a `DropGuard`.
>  //!                     let x = &unsafe {
> -//!                         ::kernel::init::__internal::DropGuard::new(&raw mut (*slot).x)
> +//!                         ::kernel::init::__internal::DropGuard::new(
> +//!                             ::core::addr_of_mut!((*slot).x),
> +//!                         )
>  //!                     };
>  //!
> -//!                     // Here we use the type checker to ensuer that every field has been
> +//!                     // Here we use the type checker to ensure that every field has been
>  //!                     // initialized exactly once, since this is `if false` it will never get
>  //!                     // executed, but still type-checked.
>  //!                     // Additionally we abuse `slot` to automatically infer the correct type for
> @@ -272,7 +284,7 @@
>  //!                         };
>  //!                     }
>  //!                     // Since initialization has successfully completed, we can now forget the
> -//!                     // guards.
> +//!                     // guards. This is not `mem::forget`, since we only have `&DropGuard`.
>  //!                     unsafe { ::kernel::init::__internal::DropGuard::forget(t) };
>  //!                     unsafe { ::kernel::init::__internal::DropGuard::forget(x) };
>  //!                 }
> @@ -280,7 +292,7 @@
>  //!                 // `__InitOk` that we need to return.
>  //!                 Ok(__InitOk)
>  //!             });
> -//!             // Change the return type of the closure.
> +//!             // Change the return type from `__InitOk` to `()`.
>  //!             let init = move |slot| -> ::core::result::Result<(), ::core::convert::Infallible> {
>  //!                 init(slot).map(|__InitOk| ())
>  //!             };
> @@ -299,7 +311,7 @@
>  //! Since we already took a look at `#[pin_data]` on `Bar`, this section will only explain the
>  //! differences/new things in the expansion of the `Foo` definition:
>  //!
> -//! ```rust
> +//! ```rust,ignore
>  //! #[pin_data(PinnedDrop)]
>  //! struct Foo {
>  //!     a: usize,
> @@ -310,7 +322,7 @@
>  //!
>  //! This expands to the following code:
>  //!
> -//! ```rust
> +//! ```rust,ignore
>  //! struct Foo {
>  //!     a: usize,
>  //!     b: Bar<u32>,
> @@ -330,8 +342,6 @@
>  //!         unsafe fn b<E>(
>  //!             self,
>  //!             slot: *mut Bar<u32>,
> -//!             // Note that this is `PinInit` instead of `Init`, this is because `b` is
> -//!             // structurally pinned, as marked by the `#[pin]` attribute.
>  //!             init: impl ::kernel::init::PinInit<Bar<u32>, E>,
>  //!         ) -> ::core::result::Result<(), E> {
>  //!             unsafe { ::kernel::init::PinInit::__pinned_init(init, slot) }
> @@ -359,14 +369,13 @@
>  //!     struct __Unpin<'__pin> {
>  //!         __phantom_pin: ::core::marker::PhantomData<fn(&'__pin ()) -> &'__pin ()>,
>  //!         __phantom: ::core::marker::PhantomData<fn(Foo) -> Foo>,
> -//!         // Since this field is `#[pin]`, it is listed here.
>  //!         b: Bar<u32>,
>  //!     }
>  //!     #[doc(hidden)]
>  //!     impl<'__pin> ::core::marker::Unpin for Foo where __Unpin<'__pin>: ::core::marker::Unpin {}
>  //!     // Since we specified `PinnedDrop` as the argument to `#[pin_data]`, we expect `Foo` to
>  //!     // implement `PinnedDrop`. Thus we do not need to prevent `Drop` implementations like
> -//!     // before, instead we implement it here and delegate to `PinnedDrop`.
> +//!     // before, instead we implement `Drop` here and delegate to `PinnedDrop`.
>  //!     impl ::core::ops::Drop for Foo {
>  //!         fn drop(&mut self) {
>  //!             // Since we are getting dropped, no one else has a reference to `self` and thus we
> @@ -388,7 +397,7 @@
>  //!
>  //! Here is the `PinnedDrop` impl for `Foo`:
>  //!
> -//! ```rust
> +//! ```rust,ignore
>  //! #[pinned_drop]
>  //! impl PinnedDrop for Foo {
>  //!     fn drop(self: Pin<&mut Self>) {
> @@ -399,7 +408,7 @@
>  //!
>  //! This expands to the following code:
>  //!
> -//! ```rust
> +//! ```rust,ignore
>  //! // `unsafe`, full path and the token parameter are added, everything else stays the same.
>  //! unsafe impl ::kernel::init::PinnedDrop for Foo {
>  //!     fn drop(self: Pin<&mut Self>, _: ::kernel::init::__internal::OnlyCallFromDrop) {
> @@ -410,10 +419,10 @@
>  //!
>  //! ## `pin_init!` on `Foo`
>  //!
> -//! Since we already took a look at `pin_init!` on `Bar`, this section will only explain the
> -//! differences/new things in the expansion of `pin_init!` on `Foo`:
> +//! Since we already took a look at `pin_init!` on `Bar`, this section will only show the expansion
> +//! of `pin_init!` on `Foo`:
>  //!
> -//! ```rust
> +//! ```rust,ignore
>  //! let a = 42;
>  //! let initializer = pin_init!(Foo {
>  //!     a,
> @@ -423,7 +432,7 @@
>  //!
>  //! This expands to the following code:
>  //!
> -//! ```rust
> +//! ```rust,ignore
>  //! let a = 42;
>  //! let initializer = {
>  //!     struct __InitOk;
> @@ -438,13 +447,15 @@
>  //!     >(data, move |slot| {
>  //!         {
>  //!             struct __InitOk;
> -//!             unsafe { ::core::ptr::write(&raw mut (*slot).a, a) };
> -//!             let a = &unsafe { ::kernel::init::__internal::DropGuard::new(&raw mut (*slot).a) };
> +//!             unsafe { ::core::ptr::write(::core::addr_of_mut!((*slot).a), a) };
> +//!             let a = &unsafe {
> +//!                 ::kernel::init::__internal::DropGuard::new(::core::addr_of_mut!((*slot).a))
> +//!             };
>  //!             let b = Bar::new(36);
> -//!             // Here we use `data` to access the correct field and require that `b` is of type
> -//!             // `PinInit<Bar<u32>, Infallible>`.
> -//!             unsafe { data.b(&raw mut (*slot).b, b)? };
> -//!             let b = &unsafe { ::kernel::init::__internal::DropGuard::new(&raw mut (*slot).b) };
> +//!             unsafe { data.b(::core::addr_of_mut!((*slot).b), b)? };
> +//!             let b = &unsafe {
> +//!                 ::kernel::init::__internal::DropGuard::new(::core::addr_of_mut!((*slot).b))
> +//!             };
>  //!
>  //!             #[allow(unreachable_code, clippy::diverging_sub_expression)]
>  //!             if false {
> --
> 2.40.0
> 
> 

