Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 971146D0297
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 13:08:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231499AbjC3LIo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 07:08:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230389AbjC3LIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 07:08:43 -0400
Received: from GBR01-LO2-obe.outbound.protection.outlook.com (mail-lo2gbr01on2130.outbound.protection.outlook.com [40.107.10.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 121EE1709;
        Thu, 30 Mar 2023 04:08:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cpUdF4+KdBMdNQwa3igLCWT7z/BECSiwpcDrdm+6P858BVT0DzmEI6ZrUnke+CYvc7oOY+oZ6jZ1/ZpOu9uDYLoc77GmNzw8D3jj/sEyvHram/ifvKjjUn61LCZqeUX1bIkHlxhkeyOwlC5wNJS/ae9MVFOvamv0b8b087IFVjhaQiKn8aBEqFjiWimyLeoRW0QOouBLstlcd6cXMyv+WXcCK0/XzW+X0juo7Vmu4HfRJoKg37J8hCkEHTsad9fSkE7MJDcacWIGSMtNDE9reU5IWxCq5a33XIw/Bdbvk/8saj11sBE0jrHtheHgl3TWKhhRN1IQ8WiIV56rEA4xwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8kF4/UWvFeP3HFrUzZB1dxeFbOjQYcJyQOElMFhPKxw=;
 b=ekyNJXdDK5FxoC30M6vbkOt022b1rS2q7D+YFRRxWbURYuIzS/LlyDIHgyGtl4kQ5W6GQidDRqdM/eqTFeEuidUQe8ZI5YM/nQax5c+ECELLga+GlVpS7KpsxXORJwjP0nOklwVjIEnF+Cp9GFe/kFhqo19BUhMHTnFXox8bikiEkF2h2aVImjL4jbJ3LUmDRWghuIB4lvQUJuCsJTWPyoqdl7djLE4n/1sJsoVrbBd57SJcHeg+YkQyfDBUwMYeb2U3z7PWKLanew+pXQXR7YHeVM8d5N0rvrGsHN7UP9UW5oSNWB+yAw56FPZJ+YyjhWM+retK9g1vsgVDb/bqyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8kF4/UWvFeP3HFrUzZB1dxeFbOjQYcJyQOElMFhPKxw=;
 b=cqxsTTYBvQ5MJmROwQ66qg1P/2d/0nm1Sfj9gt++QkwlIv/ToJyim4utltkP4V5QkGTudixzUwXtq7wYZYTge0gtLQS7isGx9Ql5icGI2D7pIk2Vzhnt4+H6HAQ26d0EDVZtR46BicAsI68Bruwvpt5BeBmoJH6rZFoSUHOiPEw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LO6P265MB6332.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:2db::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.35; Thu, 30 Mar
 2023 11:08:33 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::2f2a:55d4:ea1d:dece]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::2f2a:55d4:ea1d:dece%4]) with mapi id 15.20.6222.035; Thu, 30 Mar 2023
 11:08:33 +0000
Date:   Thu, 30 Mar 2023 12:08:32 +0100
From:   Gary Guo <gary@garyguo.net>
To:     y86-dev@protonmail.com
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        =?UTF-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
        Alice Ryhl <alice@ryhl.io>, rust-for-linux@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev
Subject: Re: [PATCH v3 12/13] rust: sync: reduce stack usage of
 `UniqueArc::try_new_uninit`
Message-ID: <20230330120832.6ced3ecc.gary@garyguo.net>
In-Reply-To: <20230329223239.138757-13-y86-dev@protonmail.com>
References: <20230329223239.138757-13-y86-dev@protonmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0623.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:294::18) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LO6P265MB6332:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e54b1bf-7bce-47b0-336d-08db310f1a24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3xIB+370Kj4SLbwrsxapIypPbtegER3YUr0t1v8BZhT/8ZefYQbIXFlMurMExxe/NVRyhMG9lXx0EVCuvix88sX3G6h6jDyVGuCbE+HFeExvR9YetyBArZOQsbjLl4rkSWO6lNwZgDl82iv/lRlyzDrIjihWDNpObZ3m7SSkpzYB5cbsvC8kmi31vk8Ak2D5Mvb3PKSj8Wg8LQMs911VdKpVrKm4NQpeUwtREUOOyQ22+DEYydIwR5QOMWxTMRPtIuygY+BuCapvkZ+C4JW4vCkaAnf9omnKaGw7WILyRkPe37jUVajj+pjMfH2YlQn/3v2K9A9N+bUeMbmRpgOe1JE3r4AzGUtEOl5xxzz4uel5Zd1LphWRARbG7N75tcMp/mBlXzJ7slufGBdk24Cjr0pIJJYviin5wAS66h4yqLFuHxDI1Kd/ZA9jXiWZAFOHmb400NIXVzPVge9AptNLilye4khYcng2orNcsnNjmJ125mUP0qOqpDRve61+VrD7Hl3MhoHbZN3PBG6Z2SpG99390GBOOfZwHPJm4Kq9crBW7Hvz8OzUMH63TWwmzrVdjDSjnsM/AhGqNs5qM8fCyQJFE95t6geCcDOTHABR0ZY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(346002)(376002)(366004)(396003)(39840400004)(136003)(451199021)(83380400001)(1076003)(26005)(316002)(54906003)(7416002)(36756003)(66556008)(66946007)(66476007)(38100700002)(8676002)(41300700001)(86362001)(6916009)(6512007)(4326008)(478600001)(6506007)(6486002)(2616005)(8936002)(5660300002)(2906002)(186003)(81973001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pRzLZknrD89mEbqLnlLJyAOEyRF7AN+bLyQKPtU4w1Dg2b+/tizEA8GDl6By?=
 =?us-ascii?Q?XwF6/4u4/8hXmdvWvxOdR7dva4IWycwavI31UWgP0AMbcWZ7XsXBEivPejME?=
 =?us-ascii?Q?vJpzm5qzgi3V0/nHlZ1YXvJYUzQywxlpqZ2Kw7LuG8CORAgTBQ6IOgPTp7ev?=
 =?us-ascii?Q?+Sn4ufMPJDukas0aZROon9WkMzfB1/a+gEuF4WXYZ8HSjGXzLEj53fQ9I5rh?=
 =?us-ascii?Q?rxsuaKvKhO0ljw6PSwdR+Phfnt6aypeyR/hm7PcvMUbjZimXLZz8yTcwPQPe?=
 =?us-ascii?Q?X+Auh+gfsbc0uFTF4q8VKnuGpygXuYYBLuqbV1twB0e1ehz1hCJpS15gLuT0?=
 =?us-ascii?Q?XUp+7eW835qrxTNBZG15loPvwfaY9MrFTjpXfTl+7H4QH3dcYyx36dXS2mH0?=
 =?us-ascii?Q?BXlvCM7iTPtfaK/DtItPiCIHte5o1UAX+ddVQvTi75NCBeaz1L/t4Yxp0jJ6?=
 =?us-ascii?Q?CFFpFyV40hhO2uM3FPgTcKbyOuEDt4Gyjr2FeBMR+/582oxZcmyznGJm0//W?=
 =?us-ascii?Q?Y+sfS2sNKlbY3Ouq1rYyHeAA8TadmQYTS+TD8JoiqLtHAZniyXb2nCjx8a1G?=
 =?us-ascii?Q?Y3/Yp0nvAYDoX3b1Pdfys+l1F7Qyt5b7XgpCbj34jpPg0uZe3KcuNpB+b7Mr?=
 =?us-ascii?Q?d2iPiAtoDMCW5Q20Lj0I+su+eMjidAEKM9mo3KYecMNSSRP4Hx1VrpTpHwy+?=
 =?us-ascii?Q?V7WhuXK7/waJoF26ua0ikQaV5IDO5X5Vd7ncovgIcl5ZPhCZfh+ekz0Zd8Mn?=
 =?us-ascii?Q?9jxAvn7awRASSPD5HMwaWWH4L4S22aDka7dNjWczhqQLsq9y16FUhqtO/u0J?=
 =?us-ascii?Q?BLuTWRfaUkIhkwQJ5CseozID639vYlGZFkizi7N6RlPrXn1xwiWwcFHXtqVz?=
 =?us-ascii?Q?QVbsqAGd4iztC4AsK3zflrUorS/k45GC9CRo7zATnyIw4YZC/LyxrZJXD67Q?=
 =?us-ascii?Q?pbf/0ZlkuV0Uylp4/osxXqnPV5e29ceB3SB/0+j3Dua/7bxOFRSLKUnTBNjQ?=
 =?us-ascii?Q?KnJVStXOhsHD693RyzRnhln3dchA6p2IjfNloQCa6IscTqWWxWxuCR8XCQxC?=
 =?us-ascii?Q?tlX11Re9ImcFYE04Wtm1vaPEjNkPYC1K8vLCVoDd9AgRqUkxjEcD56t1wKQD?=
 =?us-ascii?Q?EdDohBRfRlDAla6+881cBQi4WYoF4oFtdAuM05eeFhP5fTBVS2v5V2oNY2jM?=
 =?us-ascii?Q?KbpVSxlu3zEy/hgBPzxAhHUMqIsJUiH0CW1GWu+9iEmSNq49y74uN2KBYZS6?=
 =?us-ascii?Q?v78/iTh/ZuixFx0965cRnBbDA71Kug54pn28k63G6LSsSAp2LgWdg9AP0yvw?=
 =?us-ascii?Q?OIj0jag4g6aK16eEuc7+iNlHIm7Z9/Hw9v8S791zjNIF5o+LpkACOzVyEP/+?=
 =?us-ascii?Q?Jh0OGLygtQEt1RwSS81tP08r1ZD6/aZcudqyifAF9bY8LuXItAhR4fJEEdAn?=
 =?us-ascii?Q?v4p5/yb3cpIVgY/6EW7o6gbyXS0dzPQqoARGes9eK6BPdsiVSl3PznVCFSMw?=
 =?us-ascii?Q?xJuF0kpFVQmAj7iVIlxlYlzYUpOAO6qJ74EU4sOddyUMH3nF2k4VYQzQeY1k?=
 =?us-ascii?Q?BhTNF9GE8m4YewYpbrTZCG5wet+CTZQj7celrihW?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e54b1bf-7bce-47b0-336d-08db310f1a24
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 11:08:33.7101
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5iXiyP9GHbXtdsu6HS+cAkfQhZdKAsASXU1CY5GjBWFtRisA4IZek3c9XbXqjsxuHdNGAbAU6JivBTQKsZ/vjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO6P265MB6332
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Mar 2023 22:33:49 +0000
y86-dev@protonmail.com wrote:

> From: Benno Lossin <y86-dev@protonmail.com>
> 
> `UniqueArc::try_new_uninit` calls `Arc::try_new(MaybeUninit::uninit())`.
> This results in the uninitialized memory being placed on the stack,
> which may be arbitrarily large due to the generic `T` and thus could
> cause a stack overflow for large types.
> 
> Change the implementation to use the pin-init API which enables in-place
> initialization. In particular it avoids having to first construct and
> then move the uninitialized memory from the stack into the final location.
> 
> Signed-off-by: Benno Lossin <y86-dev@protonmail.com>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  rust/kernel/lib.rs      |  1 -
>  rust/kernel/sync/arc.rs | 14 ++++++++++++--
>  2 files changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index 3e2777d26ff5..d9df77132fa2 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -27,7 +27,6 @@
>  #[cfg(not(CONFIG_RUST))]
>  compile_error!("Missing kernel configuration for conditional compilation");
> 
> -#[allow(unused_extern_crates)]
>  // Allow proc-macros to refer to `::kernel` inside the `kernel` crate (this crate).
>  extern crate self as kernel;
> 
> diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
> index 77a3833cc265..4ed6329a5e5f 100644
> --- a/rust/kernel/sync/arc.rs
> +++ b/rust/kernel/sync/arc.rs
> @@ -18,6 +18,7 @@
>  use crate::{
>      bindings,
>      error::{Error, Result},
> +    init,
>      init::{InPlaceInit, Init, PinInit},
>      types::{ForeignOwnable, Opaque},
>  };
> @@ -29,6 +30,7 @@ use core::{
>      pin::Pin,
>      ptr::NonNull,
>  };
> +use macros::pin_data;
> 
>  /// A reference-counted pointer to an instance of `T`.
>  ///
> @@ -121,6 +123,7 @@ pub struct Arc<T: ?Sized> {
>      _p: PhantomData<ArcInner<T>>,
>  }
> 
> +#[pin_data]
>  #[repr(C)]
>  struct ArcInner<T: ?Sized> {
>      refcount: Opaque<bindings::refcount_t>,
> @@ -501,9 +504,16 @@ impl<T> UniqueArc<T> {
> 
>      /// Tries to allocate a new [`UniqueArc`] instance whose contents are not initialised yet.
>      pub fn try_new_uninit() -> Result<UniqueArc<MaybeUninit<T>>> {
> -        Ok(UniqueArc::<MaybeUninit<T>> {
> +        // INVARIANT: The refcount is initialised to a non-zero value.
> +        let inner = Box::init(init!(ArcInner {
> +            // SAFETY: There are no safety requirements for this FFI call.
> +            refcount: Opaque::new(unsafe { bindings::REFCOUNT_INIT(1) }),
> +            data <- init::uninit(),
> +        }))?;
> +        Ok(UniqueArc {
>              // INVARIANT: The newly-created object has a ref-count of 1.
> -            inner: Arc::try_new(MaybeUninit::uninit())?,
> +            // SAFETY: The pointer from the `Box` is valid.
> +            inner: unsafe { Arc::from_inner(Box::leak(inner).into()) },
>          })
>      }
>  }
> --
> 2.39.2
> 
> 

