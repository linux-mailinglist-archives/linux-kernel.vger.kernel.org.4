Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD86A6D023F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 12:58:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231314AbjC3K6R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 06:58:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231225AbjC3K6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 06:58:14 -0400
Received: from GBR01-CWL-obe.outbound.protection.outlook.com (mail-cwlgbr01on2103.outbound.protection.outlook.com [40.107.11.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F08367EC3;
        Thu, 30 Mar 2023 03:58:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e3fQZhs8L4ZlJ8n7sH5YJsVfR36PtHP6z6SGBVBEsX+5Og3TS4+cKYoVdLOapR2tmFUh+v+/fe7KB3X+PBfVURJ3jwXeftP6X3m7gw+ejBQ5TNF/ExLfJf7bkiP0JNhRcQ4faA5vQBg9x1cqN3LbLf41/tXEAkgln3dO9qbEdVT0WHJOcNf4naPFXMb/kt5NyXES+YqQEuPSjkPzBmKNJ1MFBwrqnEkbcyBUw0rI+/rue+wgnCFUX/8YjPTuw8WpO83ZfViQcY6U7j6fcw56AhFvKcoO1Lju7a1x5stP17wIoCM103A0WlB/9MKw2o0N0A5ol/zlldfM/EcemaXLKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7IkwZtjPJ9Wn0ZKe/3NyngbqzUtimVrUVmEDqp5U+TM=;
 b=faBxXU/oriATdDhXbnRUDmkoSkP1w5zyJLMIeRD1w/ql9tDAlitWMqroJl2Ko4bGR/k1CPydwff7Dlf7bSukqb+yo2mdvZQBwQoSOXjqOxX+5lWud3Z6bD2tuk6ujcCK0XOaNZRh8h5WZD+xw8U0PycBMedCWSt0sAic92vwKcIfDrMY1Zb4RJ9LSwd6iJmsHTZKbyUXfj6QQmntswv8zVmyXLsy+42U6gKEBzc36TorXKrnHyBQrVXpdk/ncccun+egyoQCTmaNOazbyOml0srfGVpTKUb2T4MvLQWeTzBL7axBVuaMy9yazTB/nTYmf6NBE5QpfxkJfdtry4QcfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7IkwZtjPJ9Wn0ZKe/3NyngbqzUtimVrUVmEDqp5U+TM=;
 b=k88C7a02WzoVOnhNHwj9gU8hRNkzMFs1m7c2K4BfWhydhQD7qLU8cKeWoG8YzW0GMQ0CmnJTpEq3SRB3WE4Oj7wVvuoPgmBSRQslGC7NjrfaijOTQk8ASzR2aNonwJzjqZ/F96bSr9zKUdtDriRGdDifmC3fhfyakCHJS8EbiNs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LO6P265MB6126.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:2b8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.37; Thu, 30 Mar
 2023 10:58:10 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::2f2a:55d4:ea1d:dece]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::2f2a:55d4:ea1d:dece%4]) with mapi id 15.20.6222.035; Thu, 30 Mar 2023
 10:58:10 +0000
Date:   Thu, 30 Mar 2023 11:58:08 +0100
From:   Gary Guo <gary@garyguo.net>
To:     y86-dev@protonmail.com
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        =?UTF-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
        Alice Ryhl <alice@ryhl.io>, rust-for-linux@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev
Subject: Re: [PATCH v3 06/13] rust: init/sync: add `InPlaceInit` trait to
 pin-initialize smart pointers
Message-ID: <20230330115808.65f8c01d.gary@garyguo.net>
In-Reply-To: <20230329223239.138757-7-y86-dev@protonmail.com>
References: <20230329223239.138757-1-y86-dev@protonmail.com>
        <20230329223239.138757-7-y86-dev@protonmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0208.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:33a::6) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LO6P265MB6126:EE_
X-MS-Office365-Filtering-Correlation-Id: b023ae9c-e4b7-414d-08da-08db310da6c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1T867qwJohZIBKI6MYeRq39w1XLBSXVOPT87T4Iy6O8+5Yg9URNMAG7JoJHZ6PPLpX8vFDtHse9vXMeTS+G42BbdwGiOdv8T1wSylWnQB4BUYaTpddZxbqSy8ZbWsIKbpncc44oSCHLWVSiW5tsGJpSEpMjQcar2AkwHzg0kHsZLNzl1Rwq63D8kiIkN/kHlCSMvruqK1A3CT3zP45iWYnrN41UXPWzXdU0xH6FqcgrS2BxH8S1HqtgkcxT08L4KK1BZwj9SyEMKGE8V6tQm9UHMme2ACAwgXxmuqIjXDnC/pPQC8DObL/tMwP9zAM394Y368hhjOA8IwQvP8Os1dsWVqDCh8kCnGQSyVL2XOSxPJd3ls2kaZSr2Z7kOMzUDdcVVfrSyjt3yPaxE2oJVQ1KJxc0I/9iSa1Em0X7JIWiF1jD7TEslAYJRC82lyMHBtAsMlikq3nb2NhEvxda3f881NvLYIV1UgqXScydY7tun53acHP9emycHuDiyGl0FoJ19NfgX19vwGbeZ8sHCkQu0q6YBpR+b4sdUxGvyKjScCjPuV8yLFamKGDj7tLmZ7pAyEA4ToCCxXUYFKXYJ7Gnt1Kp9WF4bj2wPsf9AxHM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(6029001)(376002)(346002)(136003)(396003)(366004)(39830400003)(451199021)(2616005)(83380400001)(6486002)(478600001)(186003)(316002)(26005)(1076003)(54906003)(6512007)(2906002)(6506007)(5660300002)(7416002)(36756003)(4326008)(8936002)(38100700002)(6916009)(8676002)(66946007)(41300700001)(66476007)(66556008)(86362001)(66899021)(81973001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yYe3IoM8AoVHi3TUYcTnOJ4bSp86amIzw8RE6j3Tq1CmoAd/3jMCJOgBRyTF?=
 =?us-ascii?Q?x9P3USRNrIcnn3bYIae8aBbkmylzoVktbANUdYcuLhiXNMEIoTpGlewKosOA?=
 =?us-ascii?Q?m7nK2pJJaS8VVwZAJ+PKEycDWT8zbd+1Of7qoa76dZQgPOE+qBI45aOc1VTy?=
 =?us-ascii?Q?PopLTfmavCdjpPAQMBx/0sSho14QUZe0hMaXB25DOuxKIVe7kjQZDw+04suc?=
 =?us-ascii?Q?kGZ3bcemgtWu2bxn8ON1Zz65L+qJwyz+njHAFiODYDBDLVJmvKlKsbu53Hp+?=
 =?us-ascii?Q?OCA0QtQvYuYaffy/fydp6AxhNTi02iyJELtKaNlSkWhwbYEQ48AcWHUpAecE?=
 =?us-ascii?Q?veeHSEhoe7PHcK1Eq1S9y+4bMofT8FMbRu+6XTg5L5Q7zgTnXw1Pnybe7fH+?=
 =?us-ascii?Q?43Sz6aR4iYkuzcP/E9qpiStPBHZ8kze1dTIyR8Bo/TI1UzJRbYigFr9JVUnL?=
 =?us-ascii?Q?PbMJS2c7/CdvAxeVU6pZUSgZ2/DgYUeUGhFbDplBTw6pO8Ugx1BVlR8g/mB3?=
 =?us-ascii?Q?KHGQ1FAwwL5ynU67ZY/KHAgd7QOUr4bdWueHbySHlhYkkI8rhh/nr6H8Kzuy?=
 =?us-ascii?Q?AoL5fTmcSmfOXfZSd5rWzqGkKtbSkYKvuGJ3nPLu6okbcrdQPJlTgU44K2hN?=
 =?us-ascii?Q?6pJ0TVnb7RxBY3qPMDTPsKTOX57kEypZ4xNjB+ZsSUVGbL7/hg8VrlVOmh9d?=
 =?us-ascii?Q?+8ku/vKnC3epbrHa8g0OR4/B/J+9m0qDC8hGqazXDA0Rh/N1n2P4Sw8W3VTJ?=
 =?us-ascii?Q?Ps+mgBmnSBxf7+M3M92PlVirFGMtUnxhnI7dU78LsiP1bauWq02vYvMlFDPt?=
 =?us-ascii?Q?dsJ26zNNnuo3EjOBr835reSTIgSK/xHXfKzO+x4SVtUnh7BQMkCPiCytasHa?=
 =?us-ascii?Q?hgh8TplgOEvJJA73i7X3Zj7agZ9/sRWrlkuipMB0rw5pRdwFhW8le0kJk7t/?=
 =?us-ascii?Q?9jni6A1Y6ashpEcKnCZ5MBOgL2HPjmI5ZeAasRrxRY1JUhjP05fKpbY5izkc?=
 =?us-ascii?Q?0Rl9lsnM7qRF4YqHeVf77L6RkaUluFqTfmK4O1gf3i3tF1nlBGByVuN4W4l+?=
 =?us-ascii?Q?/UoCA7QOXpUvk9C45KJdULqcbNIwRveBJgsbySg1t4hSQYQ3GQsYnodB1iJm?=
 =?us-ascii?Q?jG4tUYes5meflVWB01m/XQCmF4xPQ8AG0HroBbhCVpKysHZibmVVOA/YvC5K?=
 =?us-ascii?Q?v9hviBRx3eorGx5qYHqflhpKfumfyxur8ww+9xOoHXBhwDigs+fE2l1Ov9mf?=
 =?us-ascii?Q?52kN7X7r1VqFw4N8HLLNoH44TezPm0e8Gn1stDX9TSyP2Rh+FwTaHC/yH1Eg?=
 =?us-ascii?Q?TW3by1nqZZNFmbuwiHGQX+z0W3NJW4pbInc7uq9yZkEhDDU1AX+YA+wty8Uh?=
 =?us-ascii?Q?WFzRYA6knwnb5RiS71rXMNLlEZPTk+/VW3hllWTXFIZLvnapJsdkcC7i5kIq?=
 =?us-ascii?Q?EgUooMA8o0JOOT1JWR5X6pnSE8k8e8AvNbIEe2v6RLbmduY8+DoU7t1bRPRR?=
 =?us-ascii?Q?Y54T2oXx6WPK3ObUz+RYL6uE3CTLTeQ4/ilsifLxP2aMkOfY6zm4mrNrEiqO?=
 =?us-ascii?Q?WYlFZJf9RMcKMJoQsphQ3NGEfZo/TWMdXn8jTE5u?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: b023ae9c-e4b7-414d-08da-08db310da6c9
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 10:58:10.6382
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J21lU1i1uV/Z0Y90zprzG9gPWC2yndCZPAm9xOY9HWGxz7TqYJHvox6QHMlwlFH8r/32TBmALHCEe/NxThXeeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO6P265MB6126
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Mar 2023 22:33:18 +0000
y86-dev@protonmail.com wrote:

> From: Benno Lossin <y86-dev@protonmail.com>
> 
> The `InPlaceInit` trait that provides two functions, for initializing
> using `PinInit<T, E>` and `Init<T>`. It is implemented by `Arc<T>`,
> `UniqueArc<T>` and `Box<T>`.
> 
> Signed-off-by: Benno Lossin <y86-dev@protonmail.com>
> ---
>  rust/kernel/init.rs     | 97 +++++++++++++++++++++++++++++++++++------
>  rust/kernel/sync/arc.rs | 25 ++++++++++-
>  2 files changed, 108 insertions(+), 14 deletions(-)
> 
> diff --git a/rust/kernel/init.rs b/rust/kernel/init.rs
> index 85e8d5f41b60..3d89c7e3bdb5 100644
> --- a/rust/kernel/init.rs
> +++ b/rust/kernel/init.rs
> @@ -114,10 +114,13 @@
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
> +use core::{cell::Cell, convert::Infallible, marker::PhantomData, mem::MaybeUninit, pin::Pin, ptr};
> 
>  #[doc(hidden)]
>  pub mod __internal;
> @@ -309,7 +312,6 @@ pub mod macros;
>  ///
>  /// [`try_pin_init!`]: kernel::try_pin_init
>  /// [`NonNull<Self>`]: core::ptr::NonNull
> -/// [`Error`]: kernel::error::Error
>  // For a detailed example of how this macro works, see the module documentation of the hidden
>  // module `__internal` inside of `init/__internal.rs`.
>  #[macro_export]
> @@ -366,8 +368,6 @@ macro_rules! pin_init {
>  ///     }
>  /// }
>  /// ```
> -///
> -/// [`Error`]: kernel::error::Error
>  // For a detailed example of how this macro works, see the module documentation of the hidden
>  // module `__internal` inside of `init/__internal.rs`.
>  #[macro_export]
> @@ -589,8 +589,6 @@ macro_rules! try_pin_init {
>  ///
>  /// This initializer is for initializing data in-place that might later be moved. If you want to
>  /// pin-initialize, use [`pin_init!`].
> -///
> -/// [`Error`]: kernel::error::Error
>  // For a detailed example of how this macro works, see the module documentation of the hidden
>  // module `__internal` inside of `init/__internal.rs`.
>  #[macro_export]
> @@ -641,8 +639,6 @@ macro_rules! init {
>  ///     }
>  /// }
>  /// ```
> -///
> -/// [`Error`]: kernel::error::Error
>  // For a detailed example of how this macro works, see the module documentation of the hidden
>  // module `__internal` inside of `init/__internal.rs`.
>  #[macro_export]
> @@ -848,7 +844,8 @@ macro_rules! try_init {
>  /// A pinned initializer for `T`.
>  ///
>  /// To use this initializer, you will need a suitable memory location that can hold a `T`. This can
> -/// be [`Box<T>`], [`Arc<T>`], [`UniqueArc<T>`].
> +/// be [`Box<T>`], [`Arc<T>`], [`UniqueArc<T>`]. Use the [`InPlaceInit::pin_init`] function of a
> +/// smart pointer like [`Arc<T>`] on this.
>  ///
>  /// Also see the [module description](self).
>  ///
> @@ -867,7 +864,6 @@ macro_rules! try_init {
>  ///
>  /// [`Arc<T>`]: crate::sync::Arc
>  /// [`Arc::pin_init`]: crate::sync::Arc::pin_init
> -/// [`UniqueArc<T>`]: kernel::sync::UniqueArc
>  #[must_use = "An initializer must be used in order to create its value."]
>  pub unsafe trait PinInit<T: ?Sized, E = Infallible>: Sized {
>      /// Initializes `slot`.
> @@ -884,7 +880,8 @@ pub unsafe trait PinInit<T: ?Sized, E = Infallible>: Sized {
>  /// An initializer for `T`.
>  ///
>  /// To use this initializer, you will need a suitable memory location that can hold a `T`. This can
> -/// be [`Box<T>`], [`Arc<T>`], [`UniqueArc<T>`]. Because [`PinInit<T, E>`] is a super trait, you can
> +/// be [`Box<T>`], [`Arc<T>`], [`UniqueArc<T>`]. Use the [`InPlaceInit::init`] function of a smart
> +/// pointer like [`Arc<T>`] on this. Because [`PinInit<T, E>`] is a super trait, you can
>  /// use every function that takes it as well.
>  ///
>  /// Also see the [module description](self).
> @@ -909,7 +906,6 @@ pub unsafe trait PinInit<T: ?Sized, E = Infallible>: Sized {
>  /// move the pointee after initialization.
>  ///
>  /// [`Arc<T>`]: crate::sync::Arc
> -/// [`UniqueArc<T>`]: kernel::sync::UniqueArc
>  #[must_use = "An initializer must be used in order to create its value."]
>  pub unsafe trait Init<T: ?Sized, E = Infallible>: PinInit<T, E> {
>      /// Initializes `slot`.
> @@ -1014,3 +1010,78 @@ unsafe impl<T> Init<T> for T {
>          Ok(())
>      }
>  }
> +
> +/// Smart pointer that can initialize memory in-place.
> +pub trait InPlaceInit<T>: Sized {
> +    /// Use the given initializer to in-place initialize a `T`.
> +    ///
> +    /// If `T: !Unpin` it will not be able to move afterwards.
> +    fn pin_init<E>(init: impl PinInit<T, E>) -> error::Result<Pin<Self>>
> +    where
> +        Error: From<E>;
> +
> +    /// Use the given initializer to in-place initialize a `T`.
> +    fn init<E>(init: impl Init<T, E>) -> error::Result<Self>
> +    where
> +        Error: From<E>;
> +}
> +
> +impl<T> InPlaceInit<T> for Box<T> {
> +    #[inline]
> +    fn pin_init<E>(init: impl PinInit<T, E>) -> error::Result<Pin<Self>>
> +    where
> +        Error: From<E>,
> +    {
> +        let mut this = Box::try_new_uninit()?;
> +        let slot = this.as_mut_ptr();
> +        // SAFETY: When init errors/panics, slot will get deallocated but not dropped,
> +        // slot is valid and will not be moved because of the `Pin::new_unchecked`
> +        unsafe { init.__pinned_init(slot)? };
> +        // SAFETY: All fields have been initialized.
> +        Ok(unsafe { Pin::new_unchecked(this.assume_init()) })

This can be either `Box::into_pin` or just `into()`.

> +    }
> +
> +    #[inline]
> +    fn init<E>(init: impl Init<T, E>) -> error::Result<Self>
> +    where
> +        Error: From<E>,
> +    {
> +        let mut this = Box::try_new_uninit()?;
> +        let slot = this.as_mut_ptr();
> +        // SAFETY: When init errors/panics, slot will get deallocated but not dropped,
> +        // slot is valid
> +        unsafe { init.__init(slot)? };
> +        // SAFETY: All fields have been initialized.
> +        Ok(unsafe { this.assume_init() })
> +    }
> +}
