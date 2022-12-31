Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D5E665A658
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Dec 2022 20:44:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231700AbiLaTn7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 14:43:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbiLaTn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 14:43:57 -0500
Received: from GBR01-CWL-obe.outbound.protection.outlook.com (mail-cwlgbr01on2122.outbound.protection.outlook.com [40.107.11.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C42283892;
        Sat, 31 Dec 2022 11:43:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F2W/pm3jKoehYHhPMu6wRrkk4f8v8+fJ5egZzZIzkyA3yAqG1EtQHfK/EAQo5yQIXE3X15E2rVWWTx9OnwlzErtq7pcFiF3PU7AZLk6lagOn2b62xTBsVkJtiTYBiwqvoeJAdvVGJvHP+HWT98nklLsT/sngSwYmo61aPRL5gfhWb3SK4YiVxwstezvPoTUgcUC6pSDlczNTv2VlUXRoDwIfHZDyrtjgZF2eM/3vzDwxKvoQoECqbttL6PMsaGqfEPXi8UUky+BBczgspS2G/Fr9KoCdGx3Qp9yI3qPWCDBRtAcnGGEQhXbydgIR1/b6r8/sfwMzUc3Ic9qKCdd5ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SPTUG3bd3H9TxEaw9kqwQrG9CjHWqV/yDCcquQRWfkw=;
 b=eFlk7OtuYaa2fE1m5JoAg7fGikRKgpcd4I8TNoO3IheaA7YqRlQti1az/01gbp6gmuxw+z4hPfMxIrMq+6O/SSGAqpTKOYMU/N+xwuqhMxGsSYKJ3h9idWSHY+hZmby5mgwhng+7rf8Bu9ImVHnYrsprkmZBD++z48fA/RY0Vb2fsA1ZTh3vpUtJc0x0SdbHp4T/r+Z4VzSS7RfdlsPSHwAgvfm0i1pOaLd+vWWYPf8BaiatbYkLivophezZKZqB4qSnhUnmqeXVB9P5w8WzCtlAZFUdJZJmGeugyczRBRZYhgkVzWp/W7jN6LhAO7UQ7XableAm5f9lijlej6CJWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SPTUG3bd3H9TxEaw9kqwQrG9CjHWqV/yDCcquQRWfkw=;
 b=lKrf83Y2kuDU7veGln0PRzYAvsM+JfncVZiiI+GyI5OMFXpyncBnWW0Iu/eyKaTxOAS0RB2Fa4hySqfAVi+Ex2zvtO7D5JRRzYrQ8VkNV93EPbI77AlE0ccfKIRf1vEILIPsQwqMBDIkGDNhPqGFr8prhc/2NV38fr2NW9ruUo0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LO6P265MB6473.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:2dd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.18; Sat, 31 Dec
 2022 19:43:53 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::2f24:8099:5588:8ba8]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::2f24:8099:5588:8ba8%8]) with mapi id 15.20.5944.018; Sat, 31 Dec 2022
 19:43:53 +0000
Date:   Sat, 31 Dec 2022 19:43:52 +0000
From:   Gary Guo <gary@garyguo.net>
To:     Wedson Almeida Filho <wedsonaf@gmail.com>
Cc:     rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        =?UTF-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/7] rust: sync: introduce `ArcBorrow`
Message-ID: <20221231194352.55cf0a26.gary@garyguo.net>
In-Reply-To: <20221228060346.352362-4-wedsonaf@gmail.com>
References: <20221228060346.352362-1-wedsonaf@gmail.com>
        <20221228060346.352362-4-wedsonaf@gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0593.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:295::8) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LO6P265MB6473:EE_
X-MS-Office365-Filtering-Correlation-Id: dcdaabfa-6cba-4b88-29e9-08daeb67590a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aU/wlqbM6DGqiNO5dfVSnGzwwRwUPnFEdMWooA+mXzCRoUWfOoIgGa1umtXPsoi5U+aUlOlyy2hpYi2z3eQZUoH7xVaus6CQZz5hnMOJcEg0ltiTCAjVqMebtY+byM9koaOaKIbW8nkTTkkXETSa5ecf8jedLqF9XQuPatWEkzCVHhRDYE45ZIpxEYFpbJksD2BQ6efrDctvjjpagCI2Ktu5AWjGpqbc2GMUEb07bciVcFHh+bpu945u6qQo33Itk1DvDRBSF1BIncLMOd0/DK++hC+4oWMv6HmP7ObRcsINepcY5rx4lUJSY8BDqksDjUFZ6YObaq6QbPHYQAjhBa18o2XOxZ4iTKz9xgZR+prK5/1N9v+r7/R8yzMAIUolfIcOLTWe2K3idBM47iDqwkLdvjzALkjtTmuWHotr4jA3v16gE1Rql5Wq5582UeqWOq3MVuotLClvdiEAvTcPk2wu+Wt55ESeMSfTydYOuxI+VyK7bDKQO5KmlfchT4mjs6qJSoO4Fq2OmnlQyPD2x2o0vdE0mVETui2Em2Woo8wZcrpcQX93p7GBwfbZQ/eiM6nlMpSjpFmKrZd3oadnal3vNiZNlsEClD6QQb2Z12vu9ZB1zroi5nwSI40fLroIOD6jesXd8HkSH4/4qppR86/co9f8ff8VNRZPwS2AZiMt4P74X8LTOdzDZkrEn+dJ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(366004)(346002)(396003)(376002)(136003)(39830400003)(451199015)(83380400001)(26005)(186003)(6512007)(2616005)(1076003)(55236004)(6506007)(86362001)(36756003)(38100700002)(8936002)(4326008)(8676002)(41300700001)(2906002)(5660300002)(6486002)(478600001)(66946007)(316002)(66476007)(66556008)(54906003)(6916009)(81973001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TbMf7+2Y6fmAnnCQPqR+NUq0JUeOpIe4BW6aoQErubG8jVgyn9X+0RzkqyXx?=
 =?us-ascii?Q?5oXsKp2/2934p3s1WGFShleBhae7iOtWwVGUK08mOptakuMWM2zYtAUf/Ue7?=
 =?us-ascii?Q?yf7MUHmabIvp5FZ1cn4B6DNkx0yr8MxNnvTGYsni8ocpp5u8nqJ5tm4XuA3U?=
 =?us-ascii?Q?2tIU7XS/HfBVsxBPflRs4++zRthoVYAVw3AHR8Ja4vq/NF3/iYalAjU5iCbT?=
 =?us-ascii?Q?a0182RcK93sQZVuyW+rn2ypiPvYcNaDwb1U3kAGcBV5KnBUhzb7MBeOsD/Mx?=
 =?us-ascii?Q?M8sgUzUrXX/Pocj7YaqbS21o1bLLYxQyvFWNoka7mt82NZ7eiDuf5l1XkfxO?=
 =?us-ascii?Q?DPA7ukPuWqhzsTj2zVmEGw238/oG9TJRmG+srEfUoRHRnQx/MXkf8YspCpam?=
 =?us-ascii?Q?+Je4V88A6CsDeytPXDBvaeJs9KmiQvTDGItTzd4kHAIzUUhzwsF0FBUlReB+?=
 =?us-ascii?Q?m25OIY73u17JM2ruDrZYhH/DhasEC0H/itSZJVvUAd+quBUqTL6zlj+Q/Vsb?=
 =?us-ascii?Q?mxfAvhFWv6jn77DGwSTKyohDdFbr2eplNPbf3lyZzFOihy84L3o2nYjKP873?=
 =?us-ascii?Q?HUAYK1lywdQWvkGTmzCWk4VEhq7HRQ84I54+mrb5skrUJVGPFvLUL3LWl+hR?=
 =?us-ascii?Q?DZP5EcYrhc0FbpervUCuuNFwnO9yzha4/hbthuhnAdcZ1ytiYIy5tUW/rUmL?=
 =?us-ascii?Q?rhx9pN4tdj1mx7W3WZv8N2Zn1Sq83sJzZGaGJGYXnHKgvyFphGGhZI5nkJWS?=
 =?us-ascii?Q?K1D6zMVG7TbkgaZnJ9fjJsmoAdwWHUd1ElnvHyBHTTQK8RAvkjRh0rE33ggZ?=
 =?us-ascii?Q?P9PRyAWa+Hgw2ryPMrOov2ddUvE2bWE9PfQzKvA+J6q3xfZk8C0mJfc/nohK?=
 =?us-ascii?Q?P/OcI2iNdfwKxawGG7QmEKZ1MfAsD0PCaVtGSkeKIoVqVecQBJ6RcAsePdqM?=
 =?us-ascii?Q?W0GMbkw/MlnRrLJPlzVLHbL64qa/g5YAd6lodKwJMZLablr0TPflDkIgiHJy?=
 =?us-ascii?Q?i52dCEx9Yjjo07zw11ZxMP2YfcCgMhz2NRqSlyNbW6HEMJdV2I080p/YDVne?=
 =?us-ascii?Q?4Ft9USv7iPGRKtxtfbcRYf/Xtpq1U2j92KeHoqk5eaahzK9FDrabS175ZA0L?=
 =?us-ascii?Q?N7KVi/gYmVC8mN2A7T6HfQJz+vo44T7LwMmLhpS8i1t1zHoaicvY8oSsETIH?=
 =?us-ascii?Q?M9n+IjmorcJfA1/njDLzMfWSvzyk2rGEkofYFgSW0rW+EW35HxpxRrZVBfp2?=
 =?us-ascii?Q?1M1JJRCNJ6e7mjC2c0/QiKyq/HcEaGGe1SBL22UVgtoNNKqaBSY31v+kKKWn?=
 =?us-ascii?Q?bxDo/dlMa1EZXHAVwknekd1eY1BLnaN7vHMgv6QfrFXcq5OVHiwzvBUqqbKK?=
 =?us-ascii?Q?wpiLOW3BXzgs+ivXJahaBfCvXQTix3fTBPXnLk1WL+MkPCElpoujE+qc15y8?=
 =?us-ascii?Q?qFhQGNFzfdO5dZKUDIrgCrbGciVlkG71CnP9KScYpL55mgJg4HdqpokUme3/?=
 =?us-ascii?Q?0J8bL70Sz8+GSzY+ztpXQwjmOJXXDNXjuO/I91jiJ0AelmPemBeGKhjZNbzi?=
 =?us-ascii?Q?RUZcDqOUdPDjSwQVmOY=3D?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: dcdaabfa-6cba-4b88-29e9-08daeb67590a
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Dec 2022 19:43:53.5594
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: majo5l7LRsL5oQIcEhI3euYY5FPUSeN+Cf2SJgGTasrHyx07cGxeRMDp81PIU0+5+q+3heT/r89PJi333E6ZjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO6P265MB6473
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,SPF_HELO_PASS,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Dec 2022 06:03:43 +0000
Wedson Almeida Filho <wedsonaf@gmail.com> wrote:

> This allows us to create references to a ref-counted allocation without
> double-indirection and that still allow us to increment the refcount to
> a new `Arc<T>`.
> 
> Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> ---
>  rust/kernel/sync.rs     |  2 +-
>  rust/kernel/sync/arc.rs | 97 +++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 98 insertions(+), 1 deletion(-)
> 
> diff --git a/rust/kernel/sync.rs b/rust/kernel/sync.rs
> index 39b379dd548f..5de03ea83ea1 100644
> --- a/rust/kernel/sync.rs
> +++ b/rust/kernel/sync.rs
> @@ -7,4 +7,4 @@
>  
>  mod arc;
>  
> -pub use arc::Arc;
> +pub use arc::{Arc, ArcBorrow};
> diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
> index dbc7596cc3ce..f68bfc02c81a 100644
> --- a/rust/kernel/sync/arc.rs
> +++ b/rust/kernel/sync/arc.rs
> @@ -19,6 +19,7 @@ use crate::{bindings, error::Result, types::Opaque};
>  use alloc::boxed::Box;
>  use core::{
>      marker::{PhantomData, Unsize},
> +    mem::ManuallyDrop,
>      ops::Deref,
>      ptr::NonNull,
>  };
> @@ -164,6 +165,18 @@ impl<T: ?Sized> Arc<T> {
>              _p: PhantomData,
>          }
>      }
> +
> +    /// Returns an [`ArcBorrow`] from the given [`Arc`].
> +    ///
> +    /// This is useful when the argument of a function call is an [`ArcBorrow`] (e.g., in a method
> +    /// receiver), but we have an [`Arc`] instead. Getting an [`ArcBorrow`] is free when optimised.
> +    #[inline]
> +    pub fn as_arc_borrow(&self) -> ArcBorrow<'_, T> {
> +        // SAFETY: The constraint that the lifetime of the shared reference must outlive that of
> +        // the returned `ArcBorrow` ensures that the object remains alive and that no mutable
> +        // reference can be created.
> +        unsafe { ArcBorrow::new(self.ptr) }
> +    }
>  }
>  
>  impl<T: ?Sized> Deref for Arc<T> {
> @@ -208,3 +221,87 @@ impl<T: ?Sized> Drop for Arc<T> {
>          }
>      }
>  }
> +
> +/// A borrowed reference to an [`Arc`] instance.
> +///
> +/// For cases when one doesn't ever need to increment the refcount on the allocation, it is simpler
> +/// to use just `&T`, which we can trivially get from an `Arc<T>` instance.
> +///
> +/// However, when one may need to increment the refcount, it is preferable to use an `ArcBorrow<T>`
> +/// over `&Arc<T>` because the latter results in a double-indirection: a pointer (shared reference)
> +/// to a pointer (`Arc<T>`) to the object (`T`). An [`ArcBorrow`] eliminates this double
> +/// indirection while still allowing one to increment the refcount and getting an `Arc<T>` when/if
> +/// needed.
> +///
> +/// # Invariants
> +///
> +/// There are no mutable references to the underlying [`Arc`], and it remains valid for the
> +/// lifetime of the [`ArcBorrow`] instance.
> +///
> +/// # Example
> +///
> +/// ```
> +/// use crate::sync::{Arc, ArcBorrow};
> +///
> +/// struct Example;
> +///
> +/// fn do_something(e: ArcBorrow<'_, Example>) -> Arc<Example> {
> +///     e.into()
> +/// }
> +///
> +/// let obj = Arc::try_new(Example)?;
> +/// let cloned = do_something(obj.as_arc_borrow());
> +///
> +/// // Assert that both `obj` and `cloned` point to the same underlying object.
> +/// assert!(core::ptr::eq(&*obj, &*cloned));
> +/// ```
> +pub struct ArcBorrow<'a, T: ?Sized + 'a> {
> +    inner: NonNull<ArcInner<T>>,
> +    _p: PhantomData<&'a ()>,
> +}
> +
> +impl<T: ?Sized> Clone for ArcBorrow<'_, T> {
> +    fn clone(&self) -> Self {
> +        *self
> +    }
> +}
> +
> +impl<T: ?Sized> Copy for ArcBorrow<'_, T> {}

Couldn't this just be derived `Clone` and `Copy`?

> +
> +impl<T: ?Sized> ArcBorrow<'_, T> {
> +    /// Creates a new [`ArcBorrow`] instance.
> +    ///
> +    /// # Safety
> +    ///
> +    /// Callers must ensure the following for the lifetime of the returned [`ArcBorrow`] instance:
> +    /// 1. That `inner` remains valid;
> +    /// 2. That no mutable references to `inner` are created.
> +    unsafe fn new(inner: NonNull<ArcInner<T>>) -> Self {
> +        // INVARIANT: The safety requirements guarantee the invariants.
> +        Self {
> +            inner,
> +            _p: PhantomData,
> +        }
> +    }
> +}
> +
> +impl<T: ?Sized> From<ArcBorrow<'_, T>> for Arc<T> {
> +    fn from(b: ArcBorrow<'_, T>) -> Self {
> +        // SAFETY: The existence of `b` guarantees that the refcount is non-zero. `ManuallyDrop`
> +        // guarantees that `drop` isn't called, so it's ok that the temporary `Arc` doesn't own the
> +        // increment.
> +        ManuallyDrop::new(unsafe { Arc::from_inner(b.inner) })
> +            .deref()
> +            .clone()
> +    }
> +}

It might be easier to follow if this is jsut `bindings::refcount_inc`
followed by `Arc::from_inner`?

> +
> +impl<T: ?Sized> Deref for ArcBorrow<'_, T> {
> +    type Target = T;
> +
> +    fn deref(&self) -> &Self::Target {
> +        // SAFETY: By the type invariant, the underlying object is still alive with no mutable
> +        // references to it, so it is safe to create a shared reference.
> +        unsafe { &self.inner.as_ref().data }
> +    }
> +}
