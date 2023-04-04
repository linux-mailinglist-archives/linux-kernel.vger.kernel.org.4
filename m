Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0F776D6285
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 15:16:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235102AbjDDNQa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 09:16:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235097AbjDDNQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 09:16:26 -0400
Received: from GBR01-LO2-obe.outbound.protection.outlook.com (mail-lo2gbr01on070c.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe15::70c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9EDB30F5;
        Tue,  4 Apr 2023 06:16:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TeIQQiOCVU5bwKOEYdGNmj17ofKvIWSB88CER9EtZbSRNr52rNCCtXGM4JZJcsmIHSdGTo9etCDmU+mF4fIGS3rgBL4hUz+1oAeZZV+rV2bqL2GdGVtSDMxuskBXvKpRGPWpf8r/KIfiahJaaLPSVDiGkQda8e/5axWnFtFrPLB4sRQdVUszFU2ievXHIU8Orr8l9Ic2Pr9S4RVA590emXPqdUtCwetP1crCr56OMS/5QX0xGXcTpoa10013bu2qTej1OZcn8qqC0tsj46FJqqYWh10z7i8HL3oxkSBlQ4Jn+S+WdaSok2395DAFRwJxdVLL1yLetVxFSM7fJLKaxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XHMhtOPBA/eYpcZhMmy+Db7kUrCfb5rfDR3vRAtR+0o=;
 b=OX0ydf5+f9e+0b/me43hLJMD2kSzcArV3Gkuy8IOJlmNdDEqsJTVnxD8Qo+2uVthH2K02qxe8rfZwq0rehMpx7SJjacww6sUEHE7vy5kkLLJeqz/re8ELjR3CrQdJ8Nywit/RK7bBvUTaJvLsF7V8t95+Bn15uHsKlG9gcP9NIfdKEo0qSmwYbY0wUusWsNXZZby/VjRRjW9ekoCWbxETHisJwQ0MfjGO2TYXbAm4rMpUzhqKUoNI2L3ACUOvt8JOABiBI0AnIdG5t1aSW+A0aN2hpzITe3qroLyuMdzjZla06+7gKwVTueSsYL9t4DUnJaofV+zZ2IlilT04pNg5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XHMhtOPBA/eYpcZhMmy+Db7kUrCfb5rfDR3vRAtR+0o=;
 b=yuqgxAYH7WP45QtH8pNNwT99BFaRRah7wd+mDvOmrR15eYednqll5LJ0YLZvOWCEWXfSaQoxurIt6/BA2b815EPxOQfkq3wk+uJvAv37732tcYooCEUF2JjWtefKPoxJp9O3A8a3NTmGleD4ihO8yXoFhZAn+s+vhyqoN2XBjQk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LO2P265MB6309.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:254::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Tue, 4 Apr
 2023 13:15:51 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::e1a3:5e38:b483:8161]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::e1a3:5e38:b483:8161%5]) with mapi id 15.20.6254.035; Tue, 4 Apr 2023
 13:15:51 +0000
Date:   Tue, 4 Apr 2023 14:15:49 +0100
From:   Gary Guo <gary@garyguo.net>
To:     Benno Lossin <y86-dev@protonmail.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        =?UTF-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
        Alice Ryhl <alice@ryhl.io>, rust-for-linux@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Alice Ryhl <aliceryhl@google.com>
Subject: Re: [PATCH v5 08/15] rust: init/sync: add `InPlaceInit` trait to
 pin-initialize smart pointers
Message-ID: <20230404141549.48230994.gary@garyguo.net>
In-Reply-To: <20230403160511.174894-1-y86-dev@protonmail.com>
References: <20230403154422.168633-1-y86-dev@protonmail.com>
        <20230403160511.174894-1-y86-dev@protonmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0305.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:196::22) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LO2P265MB6309:EE_
X-MS-Office365-Filtering-Correlation-Id: 61f50f6a-6e15-4727-7b62-08db350eb6af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yipFxJbAp/yQ/1UvKyGoq+9HOsoLI6IGs4geWEgflnSkgy/ogbm4Ds8yvhOy0tknaTcna/+vcvdTGAOBWdDWW7r0l2h5QHk6RBIt8CKdXV9jr1Ovjjc6DJ2eDk59LUohPbQFjX3Dh48lb4aVDXJvsfd76mR5Ndn666ZSf+QO+CjGTTck38fTFten5/ZP//U96iSpG7sQs8wgHpWWVS7CNhLP5ZjrPe5FyAGI8UpEEf86Y5KQwiTencJHfDrIwEghbQAgPAaCmkLTLBpPFDvGHRpZYw6P8Xo3BklxBhgoUCgUJWESuE+0yohcFfVqyVJwHJnFWmQHCXopnWjiIWVKGiRkKFCMMoF9wOSDurGmf2XyJa4aQftSWKlTKAD/xYdU/RNTRnEG3OMl+tf79OI5GwNtgy7Rshi/0FkRTX//h0RiVAjFqk/WE9ke7iSIuz0zYZOLYvHhatng+TfHWOQq4c0c1G1EuSsmH7ElVDk7gap0+B6sdxurRL//QfwM2FxYQP70pYdgdnulCXsGTCFmrjE5Jm4TcPWMsaTKO/SOqmd+lpovgyj8+lc/M1OKI/LgvewbPPRZr8596LCwpGU3vMam1c8UY1g+IgSilqiyIdU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(6029001)(39830400003)(396003)(366004)(346002)(376002)(136003)(451199021)(86362001)(36756003)(2906002)(66899021)(2616005)(6486002)(186003)(83380400001)(6512007)(26005)(1076003)(6506007)(4326008)(8676002)(66946007)(66476007)(66556008)(478600001)(7416002)(41300700001)(38100700002)(316002)(6916009)(54906003)(5660300002)(8936002)(81973001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Cc4e37kMYo6YMdOKY7iBE+21dQ5G2sFy/27E9xSUEnACQbvYHLHWsdPm/43/?=
 =?us-ascii?Q?NAqMScAIXcfoQt+aplS7mmO68x6cUar0KNhD3p0up9bCH1ym0sQBtNUj+Whp?=
 =?us-ascii?Q?3tJfFo09as6Yp1Jx5mrQVnUycdhxj24ls/8Jhh2sx/vb4m3OjRiTXAXkwcq2?=
 =?us-ascii?Q?GQIRxo7jzPVGgquwTnV0XUCw/9aEpOo2R3N4OjxcTjH1DTE9+NCZwtAWh60u?=
 =?us-ascii?Q?p93JmHAcjkBR5LF1+cU4/ET7FyBD7jx4X0y381j9owXF/ULSvZTvPhRvsOKU?=
 =?us-ascii?Q?o8lNzIx+uHgEGkM60ULiahyDXY6+G4aahq29vovrZX7ui+5q5rdA0Kc5THpd?=
 =?us-ascii?Q?wiZtBnYEc5tOfPciK0EYCab37jBac4Fd+ZUIBwY1Yq2SV5DaEH305WugdRjp?=
 =?us-ascii?Q?kiSwWehflVpdjt9TtPDoXmAHHNmWewSnIuz1S7D/fcD/rX3tTdY4ZP/4W5e+?=
 =?us-ascii?Q?bp8IAAWkY4Tzz3/aDOXwiokbfk6RHkgxhjz7XqMcMgpYb+oInbsEtNIfucZh?=
 =?us-ascii?Q?FTEtR544BhlNJrnQVzMVEkGbib99teI6vZKnLwiu9RO5GrKVSP2SKhWkGo70?=
 =?us-ascii?Q?NxH25wZr5TAMIZmdy0S5DZyxFOVABO7o2oSAleeYQYzgYPtZHUy2NhLqS5oj?=
 =?us-ascii?Q?G3x6Q8Vt/JdhZYKJQLd3Iap+Y9O0Y50PSTSwSo2gL2PTj2ry7oFHUfH1yOC7?=
 =?us-ascii?Q?82Ug0wD5roSbAUCBjTUdQdXmtNb+7zbwv1IBCPWavxhnB8e1rmNgOH4cBDX9?=
 =?us-ascii?Q?A1vYkCVoKmVMuuqBPGJ9rdcaiwk5skLeurgAEgdbe7eYq4i7KOUCX0qXsiV4?=
 =?us-ascii?Q?pSGWK1bCqF5vJ2Z2I6OQG8kpbZpi9mgulSNJfTycTs/lFG3oo4l9lDyFGJut?=
 =?us-ascii?Q?34Qn3W7h+rYW5wWtLtb3wOwSwM6ckCUkuwdtTCioEWAdokDdCSlIMShH80gO?=
 =?us-ascii?Q?w1vMlzLS5Kpyv+ibwoRhTbfaEF9tWOePadpk/0F6XQWeeBx4xR5iy9dcGuil?=
 =?us-ascii?Q?RQDfnesWD+nZDsZ1Z6BSTvXgXpAfmY/uhwT92bE/0ge3SsUgthK3l29Mdx3X?=
 =?us-ascii?Q?UQdp9vAA5HNq8edJZwpk5fRI27hqvTws67bsvQo5UQbwE1CAozuJl9P8wdzx?=
 =?us-ascii?Q?UIoIDzgaWGT0n6o9Rt/kB6DAQ6+ktVLdUyHZMqxN7+MV0M3ZO+wfoMvLF/+C?=
 =?us-ascii?Q?wWVt2jS2cL1EQ9puKhqz28j7O+wBREMEDby1MPqruRZ1+Q5WQSKIP31Mjrqa?=
 =?us-ascii?Q?v9rRySMqeDRs+WKnIYRQl3xwVYeBR2eDrP7FsfY3OiZdQSHIw9Y+5iWVFNok?=
 =?us-ascii?Q?ePBlRaHaUzDfx4YLwSpym9E6KmX+Sk1UBhOATOv8hUDwD+/f4Jvnv2qrpvew?=
 =?us-ascii?Q?Luqnuvj4wFxCTljaTxup5bnRrXe3fFt4jFg6CxevYHFy5Yy76nbZ4Ga5slN5?=
 =?us-ascii?Q?kyo3P+31qMPDaHGqORpAWurojYtQn+9OrG1fVJp856nEL+FmaoYm+ZaI5a79?=
 =?us-ascii?Q?qbCCTPOviiNO1XdF1ZknhTUfwvaaQlrzN8ounNPxHygtZ9cmCgG9kaKJeiB1?=
 =?us-ascii?Q?UJapJaHUwqAco2th9QRi4ejzbv3EWt7AAkOXuEIZ?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 61f50f6a-6e15-4727-7b62-08db350eb6af
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2023 13:15:51.5466
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vOmB6mJuVP+P35mDNv7kNUpWpnB0nfbFZNh0YC+MDwJE3BogyZs5jp+1WKMUSjyHSqZcrh0fRUOCiiTNuxkQzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P265MB6309
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 03 Apr 2023 16:05:22 +0000
Benno Lossin <y86-dev@protonmail.com> wrote:

> The `InPlaceInit` trait that provides two functions, for initializing
> using `PinInit<T, E>` and `Init<T>`. It is implemented by `Arc<T>`,
> `UniqueArc<T>` and `Box<T>`.
> 
> Signed-off-by: Benno Lossin <y86-dev@protonmail.com>
> Cc: Andreas Hindborg <a.hindborg@samsung.com>
> Cc: Alice Ryhl <aliceryhl@google.com>
> Cc: Gary Guo <gary@garyguo.net>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  rust/kernel/init.rs     | 128 ++++++++++++++++++++++++++++++++++++----
>  rust/kernel/sync/arc.rs |  24 ++++++++
>  2 files changed, 139 insertions(+), 13 deletions(-)
> 
> diff --git a/rust/kernel/init.rs b/rust/kernel/init.rs
> index ecef0376d726..6499cf5c9c20 100644
> --- a/rust/kernel/init.rs
> +++ b/rust/kernel/init.rs
> @@ -114,10 +114,16 @@
>  //! [`impl Init<T, E>`]: Init
>  //! [`Opaque`]: kernel::types::Opaque
>  //! [`pin_data`]: ::macros::pin_data
> -//! [`UniqueArc<T>`]: kernel::sync::UniqueArc
> 
> +use crate::{
> +    error::{self, Error},
> +    sync::UniqueArc,
> +};
>  use alloc::boxed::Box;
> -use core::{cell::Cell, convert::Infallible, marker::PhantomData, mem::MaybeUninit, ptr};
> +use core::{
> +    alloc::AllocError, cell::Cell, convert::Infallible, marker::PhantomData, mem::MaybeUninit,
> +    pin::Pin, ptr,
> +};
> 
>  #[doc(hidden)]
>  pub mod __internal;
> @@ -309,7 +315,6 @@ pub mod macros;
>  ///
>  /// [`try_pin_init!`]: kernel::try_pin_init
>  /// [`NonNull<Self>`]: core::ptr::NonNull
> -/// [`Error`]: kernel::error::Error
>  // For a detailed example of how this macro works, see the module documentation of the hidden
>  // module `__internal` inside of `init/__internal.rs`.
>  #[macro_export]
> @@ -363,8 +368,6 @@ macro_rules! pin_init {
>  ///     }
>  /// }
>  /// ```
> -///
> -/// [`Error`]: kernel::error::Error
>  // For a detailed example of how this macro works, see the module documentation of the hidden
>  // module `__internal` inside of `init/__internal.rs`.
>  #[macro_export]
> @@ -586,8 +589,6 @@ macro_rules! try_pin_init {
>  ///
>  /// This initializer is for initializing data in-place that might later be moved. If you want to
>  /// pin-initialize, use [`pin_init!`].
> -///
> -/// [`Error`]: kernel::error::Error
>  // For a detailed example of how this macro works, see the module documentation of the hidden
>  // module `__internal` inside of `init/__internal.rs`.
>  #[macro_export]
> @@ -635,8 +636,6 @@ macro_rules! init {
>  ///     }
>  /// }
>  /// ```
> -///
> -/// [`Error`]: kernel::error::Error
>  // For a detailed example of how this macro works, see the module documentation of the hidden
>  // module `__internal` inside of `init/__internal.rs`.
>  #[macro_export]
> @@ -842,7 +841,8 @@ macro_rules! try_init {
>  /// A pin-initializer for the type `T`.
>  ///
>  /// To use this initializer, you will need a suitable memory location that can hold a `T`. This can
> -/// be [`Box<T>`], [`Arc<T>`], [`UniqueArc<T>`].
> +/// be [`Box<T>`], [`Arc<T>`], [`UniqueArc<T>`]. Use the [`InPlaceInit::pin_init`] function of a
> +/// smart pointer like [`Arc<T>`] on this.
>  ///
>  /// Also see the [module description](self).
>  ///
> @@ -861,7 +861,6 @@ macro_rules! try_init {
>  ///
>  /// [`Arc<T>`]: crate::sync::Arc
>  /// [`Arc::pin_init`]: crate::sync::Arc::pin_init
> -/// [`UniqueArc<T>`]: kernel::sync::UniqueArc
>  #[must_use = "An initializer must be used in order to create its value."]
>  pub unsafe trait PinInit<T: ?Sized, E = Infallible>: Sized {
>      /// Initializes `slot`.
> @@ -878,7 +877,8 @@ pub unsafe trait PinInit<T: ?Sized, E = Infallible>: Sized {
>  /// An initializer for `T`.
>  ///
>  /// To use this initializer, you will need a suitable memory location that can hold a `T`. This can
> -/// be [`Box<T>`], [`Arc<T>`], [`UniqueArc<T>`]. Because [`PinInit<T, E>`] is a super trait, you can
> +/// be [`Box<T>`], [`Arc<T>`], [`UniqueArc<T>`]. Use the [`InPlaceInit::init`] function of a smart
> +/// pointer like [`Arc<T>`] on this. Because [`PinInit<T, E>`] is a super trait, you can
>  /// use every function that takes it as well.
>  ///
>  /// Also see the [module description](self).
> @@ -903,7 +903,6 @@ pub unsafe trait PinInit<T: ?Sized, E = Infallible>: Sized {
>  /// move the pointee after initialization.
>  ///
>  /// [`Arc<T>`]: crate::sync::Arc
> -/// [`UniqueArc<T>`]: kernel::sync::UniqueArc
>  #[must_use = "An initializer must be used in order to create its value."]
>  pub unsafe trait Init<T: ?Sized, E = Infallible>: Sized {
>      /// Initializes `slot`.
> @@ -982,3 +981,106 @@ unsafe impl<T> Init<T> for T {
>          Ok(())
>      }
>  }
> +
> +/// Smart pointer that can initialize memory in-place.
> +pub trait InPlaceInit<T>: Sized {
> +    /// Use the given pin-initializer to pin-initialize a `T` inside of a new smart pointer of this
> +    /// type.
> +    ///
> +    /// If `T: !Unpin` it will not be able to move afterwards.
> +    fn try_pin_init<E>(init: impl PinInit<T, E>) -> Result<Pin<Self>, E>
> +    where
> +        E: From<AllocError>;
> +
> +    /// Use the given pin-initializer to pin-initialize a `T` inside of a new smart pointer of this
> +    /// type.
> +    ///
> +    /// If `T: !Unpin` it will not be able to move afterwards.
> +    fn pin_init<E>(init: impl PinInit<T, E>) -> error::Result<Pin<Self>>
> +    where
> +        Error: From<E>,
> +    {
> +        // SAFETY: We delegate to `init` and only change the error type.
> +        let init = unsafe {
> +            pin_init_from_closure(|slot| init.__pinned_init(slot).map_err(|e| Error::from(e)))
> +        };
> +        Self::try_pin_init(init)
> +    }
> +
> +    /// Use the given initializer to in-place initialize a `T`.
> +    fn try_init<E>(init: impl Init<T, E>) -> Result<Self, E>
> +    where
> +        E: From<AllocError>;
> +
> +    /// Use the given initializer to in-place initialize a `T`.
> +    fn init<E>(init: impl Init<T, E>) -> error::Result<Self>
> +    where
> +        Error: From<E>,
> +    {
> +        // SAFETY: We delegate to `init` and only change the error type.
> +        let init = unsafe {
> +            init_from_closure(|slot| init.__pinned_init(slot).map_err(|e| Error::from(e)))
> +        };
> +        Self::try_init(init)
> +    }
> +}
> +
> +impl<T> InPlaceInit<T> for Box<T> {
> +    #[inline]
> +    fn try_pin_init<E>(init: impl PinInit<T, E>) -> Result<Pin<Self>, E>
> +    where
> +        E: From<AllocError>,
> +    {
> +        let mut this = Box::try_new_uninit()?;
> +        let slot = this.as_mut_ptr();
> +        // SAFETY: When init errors/panics, slot will get deallocated but not dropped,
> +        // slot is valid and will not be moved, because we pin it later.
> +        unsafe { init.__pinned_init(slot)? };
> +        // SAFETY: All fields have been initialized.
> +        Ok(unsafe { this.assume_init() }.into())
> +    }
> +
> +    #[inline]
> +    fn try_init<E>(init: impl Init<T, E>) -> Result<Self, E>
> +    where
> +        E: From<AllocError>,
> +    {
> +        let mut this = Box::try_new_uninit()?;
> +        let slot = this.as_mut_ptr();
> +        // SAFETY: When init errors/panics, slot will get deallocated but not dropped,
> +        // slot is valid.
> +        unsafe { init.__init(slot)? };
> +        // SAFETY: All fields have been initialized.
> +        Ok(unsafe { this.assume_init() })
> +    }
> +}
> +
> +impl<T> InPlaceInit<T> for UniqueArc<T> {
> +    #[inline]
> +    fn try_pin_init<E>(init: impl PinInit<T, E>) -> Result<Pin<Self>, E>
> +    where
> +        E: From<AllocError>,
> +    {
> +        let mut this = UniqueArc::try_new_uninit()?;
> +        let slot = this.as_mut_ptr();
> +        // SAFETY: When init errors/panics, slot will get deallocated but not dropped,
> +        // slot is valid and will not be moved, because we pin it later.
> +        unsafe { init.__pinned_init(slot)? };
> +        // SAFETY: All fields have been initialized.
> +        Ok(unsafe { this.assume_init() }.into())
> +    }
> +
> +    #[inline]
> +    fn try_init<E>(init: impl Init<T, E>) -> Result<Self, E>
> +    where
> +        E: From<AllocError>,
> +    {
> +        let mut this = UniqueArc::try_new_uninit()?;
> +        let slot = this.as_mut_ptr();
> +        // SAFETY: When init errors/panics, slot will get deallocated but not dropped,
> +        // slot is valid.
> +        unsafe { init.__init(slot)? };
> +        // SAFETY: All fields have been initialized.
> +        Ok(unsafe { this.assume_init() })
> +    }
> +}
> diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
> index eee7008e5e3e..43a53fbe175d 100644
> --- a/rust/kernel/sync/arc.rs
> +++ b/rust/kernel/sync/arc.rs
> @@ -17,6 +17,8 @@
> 
>  use crate::{
>      bindings,
> +    error::{self, Error},
> +    init::{InPlaceInit, Init, PinInit},
>      types::{ForeignOwnable, Opaque},
>  };
>  use alloc::boxed::Box;
> @@ -163,6 +165,28 @@ impl<T> Arc<T> {
>          // `Arc` object.
>          Ok(unsafe { Self::from_inner(Box::leak(inner).into()) })
>      }
> +
> +    /// Use the given initializer to in-place initialize a `T`.
> +    ///
> +    /// If `T: !Unpin` it will not be able to move afterwards.
> +    #[inline]
> +    pub fn pin_init<E>(init: impl PinInit<T, E>) -> error::Result<Self>
> +    where
> +        Error: From<E>,
> +    {
> +        UniqueArc::pin_init(init).map(|u| u.into())
> +    }
> +
> +    /// Use the given initializer to in-place initialize a `T`.
> +    ///
> +    /// This is equivalent to [`pin_init`], since an [`Arc`] is always pinned.
> +    #[inline]
> +    pub fn init<E>(init: impl Init<T, E>) -> error::Result<Self>
> +    where
> +        Error: From<E>,
> +    {
> +        UniqueArc::init(init).map(|u| u.into())
> +    }
>  }
> 
>  impl<T: ?Sized> Arc<T> {
> --
> 2.39.2
> 
> 

