Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6959673D43F
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 22:55:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbjFYUzG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 16:55:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjFYUzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 16:55:03 -0400
Received: from GBR01-LO2-obe.outbound.protection.outlook.com (mail-lo2gbr01on2126.outbound.protection.outlook.com [40.107.10.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C061C126;
        Sun, 25 Jun 2023 13:54:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bqXg+thWdl3mJjNP67VLgS5THbJtz+3HqIu9VG4W8l4gk31WCyftwRKI6ZzyDagYb0kkIt97hxmEgFPEzwK/Nxko9q27h1BglS0janAfZm5isByGFUjig47ypVeU8BAk171lo/trp716dB7Fbj5ju8ZZNWHkZET6+bKD+NmtujszzkqQT9O2NzVY2bVvr8fYNW5RTIbniUu0GvNgKLE9ngUobN29Pay6pF4S7OXLUAxv0cNVKsuP7JoBNOuKdVOCakDqc9uZQ9Nc+mnz1Mb9a/X3PbDJjXdpLkwnQ8hLmy+V+gQD+D6DzoKVcTZ2F8RAx9B0tzOVKLBAAYasgV5Opw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UKuR1sdu0xOg5qCjeeHoPIPbEPaqrAsxu0W8JgXgHHE=;
 b=EE3rtyidltVS+BCWt1Ddsmq2bMVYodAwr0Xo9Z8hIR4KJm5bJYjxVhzIrTVgCBaxr69n0J+iFInYAWYSLV0VJAvOrFFqqNfp4PTKEXXhb9ZNJz2FSnNyukbGZkSoSCQk2fvY+TruthS9MHuhiEOvQITHTutMe13BsEoVKUzrFFERU2Tt40DbLKST4xosD3t/PgZDWlw83Dq2Le/iJhurlrBkd3pbOJvM7Xbhkzt+X/tsnR6dn26XjOs3Luw+2Z7LLD8fZP9NvFZv2SiQ9wF5eFOWz1EHeJSAvdGMgBJWIa2aqKs03N7rMf0zxUoxxKSPjoxX9HNcCvqyhRYBtXa+SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UKuR1sdu0xOg5qCjeeHoPIPbEPaqrAsxu0W8JgXgHHE=;
 b=y8JNaIjT0Ow/Doc9sDAXtiJSH5z4QhBquaw8pO3DnqP1peAMYMkL5A9mkQ5UpXqzGtCY9RmZlq4tgUUNhuUrAqL9dgfCuiczVJq1McFIQH+sY5P5sS/IWXGyyixlJFh9ZATzyLOjujBwPZpd7AlKpxJbLiviv4isPDfbkytDUsU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by CWXP265MB1815.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:30::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Sun, 25 Jun
 2023 20:54:56 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::25e2:a08b:cd9c:c3c9]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::25e2:a08b:cd9c:c3c9%3]) with mapi id 15.20.6521.026; Sun, 25 Jun 2023
 20:54:56 +0000
Date:   Sun, 25 Jun 2023 21:54:53 +0100
From:   Gary Guo <gary@garyguo.net>
To:     Benno Lossin <benno.lossin@proton.me>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        =?UTF-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
        Alice Ryhl <aliceryhl@google.com>,
        Andreas Hindborg <nmi@metaspace.dk>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Asahi Lina <lina@asahilina.net>
Subject: Re: [PATCH 3/7] rust: init: make guards in the init macros hygienic
Message-ID: <20230625215453.25aa38a0.gary@garyguo.net>
In-Reply-To: <20230624092330.157338-3-benno.lossin@proton.me>
References: <20230624092330.157338-1-benno.lossin@proton.me>
        <20230624092330.157338-3-benno.lossin@proton.me>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0305.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a5::29) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|CWXP265MB1815:EE_
X-MS-Office365-Filtering-Correlation-Id: fd581893-e88e-4465-8aee-08db75be6e92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IbiM9Q/qYJP5RaTxpBfJXjnV1/Jm20VaaEA1Ccg6ri56SsG+YRXs4N6/AVtIzACm4sUQ5wbnF0+Ja+w0EhFMH7wj+Dvg1HtXFRCe5kDp8uzYlSgE0SHqLev18V8VbTf2wr9unIvJfyA/bM7eDguSl5BWevQTM+RVjR09Us7BShNPqYqfjA+xho0GBginSVRYWo4G+Te+Sojc48MThTq5F3cn4s72oaRFbcpeHgboUJR2CzJFQlJQ+IRn0kPLZ9ZEP9S5FPpQlgWnH4VfmmyGJiDQSTCzofI/7x88K0ukkg2/VgsyI8J8MUUnha+Sxdw8Jcmhvz4qdjnpbir8XwVcoeTkkbrFFwX80mKo72L8RZdqXl4ThQYzbxDdagOA3JQr3Gpvukq0TJyizog69AEvCr40+nyWVWDWGma9I6f0RB1VNwjh+VwbXWGSSZTA8HkT3QsKm9hLW8eSzVdC2f0TLdXOm+WxPh1ZIaQ41i1PKTwKeTrsUq+dnpf7+8y9PuwcGC188StUjx4BzBtcUCq1LQ5f1dwzAwynYah1BQYHjZU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(366004)(376002)(136003)(346002)(39830400003)(396003)(451199021)(36756003)(5660300002)(7416002)(6916009)(8936002)(8676002)(41300700001)(86362001)(66556008)(66476007)(38100700002)(4326008)(316002)(66946007)(966005)(1076003)(6506007)(26005)(6512007)(2906002)(186003)(2616005)(478600001)(6666004)(83380400001)(54906003)(6486002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2r7SWKsHoxSpzAa+jKUZrVay/ML1QI1WHEQV+boAKOdfxD3L1p21V8xEG1MP?=
 =?us-ascii?Q?iXcS6O5/8X9/jr8WEKfCpL3RK0TBuEGpM8FO9ZMkAFDyO8TlMY0JSOT7sGU6?=
 =?us-ascii?Q?r8r6ZSze3oVcVuxckGdTxdIIdzF5lMFBwVs/P6D/4f4qEQjeavVy26d0BgVz?=
 =?us-ascii?Q?6CdM2XR0QiAX6WylCrCNyPnoD93IWFlg/Rr7MHtUsSpwmDxNk55K95os2gTa?=
 =?us-ascii?Q?Ly2RmivBiVaaQB+VFaacWtvyZp/KcKVslh6jy9iKM+3FA/q6/hUkyLHUlI0p?=
 =?us-ascii?Q?kiuhiiK05mpcVFdXvmjB6Tu1XOOEDrR/VFEkgVbfXn/qUYgnvoo4KvcByhQp?=
 =?us-ascii?Q?nj/KpUuIDd3zVY5fDM2jJvfn0NGv8qDMM4gHBBPmI6+kEUCLS7syRJ2iKn+y?=
 =?us-ascii?Q?BLypzU23b7Q8HiFxZ7BFFBqiiJVTb2yNsY/zDRF1d1OvkCVz6lW+lt1sSPEc?=
 =?us-ascii?Q?x76UegBKn9WL147nfYWBs2MghRL94wJdQG52fN3KLGI+MpPGveIGhydpbHr1?=
 =?us-ascii?Q?ugxqSeb1ncAYBVG60VuwoalOrJ8/HM0pX5Ly9zPm2KanWYB7BWJBFojGfxop?=
 =?us-ascii?Q?9oCUeuspkwgkl+j8hBCGHIfEJxJrZjd2l95TYC1L0GvvIP76jtSNo8UAKV++?=
 =?us-ascii?Q?wxtI4OO7kT7q3hCm3NwoZYST7cLJyWx4mkbXZyK0PgbJoOuo1nnOty/9R2Jo?=
 =?us-ascii?Q?mXtIU2crfZGxksT/DTS/kjhb423GZRxX6msu+kvoPgJEx8aUg90WsG0//gJc?=
 =?us-ascii?Q?k+Ff4rX3GUD1QnAVQKGwvXQ2WAuNmt+tbfxEnzYkyaQMO529D3t3yq3oc1zI?=
 =?us-ascii?Q?i1gzoRNCgHFco35aZyc+6LfGThY5sklYjMAxa0EfTgu1PaJ8cs/JguEJWmJN?=
 =?us-ascii?Q?4i3RWByknklv6Hmn6RdkEKyj4vJaoebyPO/cv27qb1nOVRXoLFh3BY0lgNfj?=
 =?us-ascii?Q?rXjkgTzZR57gZxQe00miWLPT4D9JoogR0Hv74EM5pHbSRABlyZ44EkSwFFSB?=
 =?us-ascii?Q?DyiXeco3YyR4sWbcr3PhVupBfjdjThNEWz2Iik0C/leMdr0V01LA+6xBX7TL?=
 =?us-ascii?Q?EG+TWrmspHOfvdWnSjvKPz+/rsJL6rz/krAbv6ZyHyoRcMeNExdB3XnLFzLv?=
 =?us-ascii?Q?2OAs47Fdey66utvja9HrHQTuT91u5vjnO2yZkm3vZ8gvJlzuQOf42avP5219?=
 =?us-ascii?Q?Qo8PsLgGq2UIeUS2PcTcYT0mkqJVMqGQlBZ5oeHYa1KD8bifYMWRuKU2S0JV?=
 =?us-ascii?Q?/ktMliUmdmydlNPgw8v2jzVse0Ob6LzJ3wVOKGikWxUYLz15O0tec7LHiPnF?=
 =?us-ascii?Q?/9bMCgGiH1Z0qlSuQJUPhKcG7AbJw7OvKl6nj/LnoOBT2WN+TSz/wl8mGb8X?=
 =?us-ascii?Q?hzxPnSHyOENaT+jFkb9pEdiI6uYHrv2ex+Rjak3utZ/ft5vt0zs+ImAcGB1o?=
 =?us-ascii?Q?8DwRdtFypKAL6DdvHgWqletI1nm9qeDOW29GThg937L0h+94uS3fKLbbuPuL?=
 =?us-ascii?Q?u2tA3zhqylKhged6G/LlXKx2PuSg43qLp4GasDQN0al+zlwitMMC9T3yifjN?=
 =?us-ascii?Q?Jnlffgzaiu/CZLefek0WvQBCEM8MtXtWK+/O6IEQ?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: fd581893-e88e-4465-8aee-08db75be6e92
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2023 20:54:56.3702
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xr9IDKuR3K1zVRMbHawizbzAA1lXR1f2YW0i09GEBzmH1THRcRfJggynKF8R65KHDkXwHXA4yMghpgpJBKDusQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP265MB1815
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 24 Jun 2023 09:25:10 +0000
Benno Lossin <benno.lossin@proton.me> wrote:

> Use hygienic identifiers for the guards instead of the field names. This
> makes the init macros feel more like normal struct initializers, since
> assigning identifiers with the name of a field does not create
> conflicts.
> Also change the internals of the guards, no need to make the `forget`
> function `unsafe`, since users cannot access the guards anyways. Now the
> guards are carried directly on the stack and have no extra `Cell<bool>`
> field that marks if they have been forgotten or not, instead they are
> just forgotten via `mem::forget`.

The code LGTM, so:

Reviewed-by: Gary Guo <gary@garyguo.net>

Although this will cause the new expansion we have to be no longer
compatible with a totally-proc-macro impl, if we want to do everything
in proc macro in the future.

If we have the paste macro upstream (
https://github.com/nbdd0121/linux/commit/fff00461b0be7fd3ec218dcc428f25886b5ec04a
) then we can replace the `guard` with `paste!([<$field>])` and keep
the expansion identical.

> 
> Suggested-by: Asahi Lina <lina@asahilina.net>
> Signed-off-by: Benno Lossin <benno.lossin@proton.me>
> ---
>  rust/kernel/init.rs            |  1 -
>  rust/kernel/init/__internal.rs | 25 +++------------
>  rust/kernel/init/macros.rs     | 56 ++++++++++++----------------------
>  3 files changed, 23 insertions(+), 59 deletions(-)
> 
> diff --git a/rust/kernel/init.rs b/rust/kernel/init.rs
> index d9a91950cba2..ecf6a4bd0ce4 100644
> --- a/rust/kernel/init.rs
> +++ b/rust/kernel/init.rs
> @@ -206,7 +206,6 @@
>  use alloc::boxed::Box;
>  use core::{
>      alloc::AllocError,
> -    cell::Cell,
>      convert::Infallible,
>      marker::PhantomData,
>      mem::MaybeUninit,
> diff --git a/rust/kernel/init/__internal.rs b/rust/kernel/init/__internal.rs
> index 44751fb62b51..7abd1fb65e41 100644
> --- a/rust/kernel/init/__internal.rs
> +++ b/rust/kernel/init/__internal.rs
> @@ -174,7 +174,6 @@ pub fn init<E>(self: Pin<&mut Self>, init: impl PinInit<T, E>) -> Result<Pin<&mu
>  /// Can be forgotten to prevent the drop.
>  pub struct DropGuard<T: ?Sized> {
>      ptr: *mut T,
> -    do_drop: Cell<bool>,
>  }
> 
>  impl<T: ?Sized> DropGuard<T> {
> @@ -190,32 +189,16 @@ impl<T: ?Sized> DropGuard<T> {
>      /// - will not be dropped by any other means.
>      #[inline]
>      pub unsafe fn new(ptr: *mut T) -> Self {
> -        Self {
> -            ptr,
> -            do_drop: Cell::new(true),
> -        }
> -    }
> -
> -    /// Prevents this guard from dropping the supplied pointer.
> -    ///
> -    /// # Safety
> -    ///
> -    /// This function is unsafe in order to prevent safe code from forgetting this guard. It should
> -    /// only be called by the macros in this module.
> -    #[inline]
> -    pub unsafe fn forget(&self) {
> -        self.do_drop.set(false);
> +        Self { ptr }
>      }
>  }
> 
>  impl<T: ?Sized> Drop for DropGuard<T> {
>      #[inline]
>      fn drop(&mut self) {
> -        if self.do_drop.get() {
> -            // SAFETY: A `DropGuard` can only be constructed using the unsafe `new` function
> -            // ensuring that this operation is safe.
> -            unsafe { ptr::drop_in_place(self.ptr) }
> -        }
> +        // SAFETY: A `DropGuard` can only be constructed using the unsafe `new` function
> +        // ensuring that this operation is safe.
> +        unsafe { ptr::drop_in_place(self.ptr) }
>      }
>  }
> 
> diff --git a/rust/kernel/init/macros.rs b/rust/kernel/init/macros.rs
> index e8165ff53a94..df4281743175 100644
> --- a/rust/kernel/init/macros.rs
> +++ b/rust/kernel/init/macros.rs
> @@ -992,7 +992,6 @@ impl<$($impl_generics)*> $pin_data<$($ty_generics)*>
>  /// - `init_slot`: recursively creates the code that initializes all fields in `slot`.
>  /// - `make_initializer`: recursively create the struct initializer that guarantees that every
>  ///   field has been initialized exactly once.
> -/// - `forget_guards`: recursively forget the drop guards for every field.
>  #[doc(hidden)]
>  #[macro_export]
>  macro_rules! __init_internal {
> @@ -1032,6 +1031,7 @@ macro_rules! __init_internal {
>                      $crate::__init_internal!(init_slot($($use_data)?):
>                          @data(data),
>                          @slot(slot),
> +                        @guards(),
>                          @munch_fields($($fields)*,),
>                      );
>                      // We use unreachable code to ensure that all fields have been mentioned exactly
> @@ -1046,10 +1046,6 @@ macro_rules! __init_internal {
>                              @acc(),
>                          );
>                      }
> -                    // Forget all guards, since initialization was a success.
> -                    $crate::__init_internal!(forget_guards:
> -                        @munch_fields($($fields)*,),
> -                    );
>                  }
>                  Ok(__InitOk)
>              }
> @@ -1063,13 +1059,17 @@ macro_rules! __init_internal {
>      (init_slot($($use_data:ident)?):
>          @data($data:ident),
>          @slot($slot:ident),
> +        @guards($($guards:ident,)*),
>          @munch_fields($(,)?),
>      ) => {
> -        // Endpoint of munching, no fields are left.
> +        // Endpoint of munching, no fields are left. If execution reaches this point, all fields
> +        // have been initialized. Therefore we can now dismiss the guards by forgetting them.
> +        $(::core::mem::forget($guards);)*
>      };
>      (init_slot($use_data:ident): // use_data is present, so we use the `data` to init fields.
>          @data($data:ident),
>          @slot($slot:ident),
> +        @guards($($guards:ident,)*),
>          // In-place initialization syntax.
>          @munch_fields($field:ident <- $val:expr, $($rest:tt)*),
>      ) => {
> @@ -1080,24 +1080,26 @@ macro_rules! __init_internal {
>          // return when an error/panic occurs.
>          // We also use the `data` to require the correct trait (`Init` or `PinInit`) for `$field`.
>          unsafe { $data.$field(::core::ptr::addr_of_mut!((*$slot).$field), $field)? };
> -        // Create the drop guard.
> +        // Create the drop guard:
>          //
> -        // We only give access to `&DropGuard`, so it cannot be forgotten via safe code.
> +        // We rely on macro hygiene to make it impossible for users to access this local variable.
>          //
>          // SAFETY: We forget the guard later when initialization has succeeded.
> -        let $field = &unsafe {
> +        let guard = unsafe {
>              $crate::init::__internal::DropGuard::new(::core::ptr::addr_of_mut!((*$slot).$field))
>          };
> 
>          $crate::__init_internal!(init_slot($use_data):
>              @data($data),
>              @slot($slot),
> +            @guards(guard, $($guards,)*),
>              @munch_fields($($rest)*),
>          );
>      };
>      (init_slot(): // no use_data, so we use `Init::__init` directly.
>          @data($data:ident),
>          @slot($slot:ident),
> +        @guards($($guards:ident,)*),
>          // In-place initialization syntax.
>          @munch_fields($field:ident <- $val:expr, $($rest:tt)*),
>      ) => {
> @@ -1107,24 +1109,26 @@ macro_rules! __init_internal {
>          // SAFETY: `slot` is valid, because we are inside of an initializer closure, we
>          // return when an error/panic occurs.
>          unsafe { $crate::init::Init::__init($field, ::core::ptr::addr_of_mut!((*$slot).$field))? };
> -        // Create the drop guard.
> +        // Create the drop guard:
>          //
> -        // We only give access to `&DropGuard`, so it cannot be forgotten via safe code.
> +        // We rely on macro hygiene to make it impossible for users to access this local variable.
>          //
>          // SAFETY: We forget the guard later when initialization has succeeded.
> -        let $field = &unsafe {
> +        let guard = unsafe {
>              $crate::init::__internal::DropGuard::new(::core::ptr::addr_of_mut!((*$slot).$field))
>          };
> 
>          $crate::__init_internal!(init_slot():
>              @data($data),
>              @slot($slot),
> +            @guards(guard, $($guards,)*),
>              @munch_fields($($rest)*),
>          );
>      };
>      (init_slot($($use_data:ident)?):
>          @data($data:ident),
>          @slot($slot:ident),
> +        @guards($($guards:ident,)*),
>          // Init by-value.
>          @munch_fields($field:ident $(: $val:expr)?, $($rest:tt)*),
>      ) => {
> @@ -1135,16 +1139,17 @@ macro_rules! __init_internal {
>          unsafe { ::core::ptr::write(::core::ptr::addr_of_mut!((*$slot).$field), $field) };
>          // Create the drop guard:
>          //
> -        // We only give access to `&DropGuard`, so it cannot be accidentally forgotten.
> +        // We rely on macro hygiene to make it impossible for users to access this local variable.
>          //
>          // SAFETY: We forget the guard later when initialization has succeeded.
> -        let $field = &unsafe {
> +        let guard = unsafe {
>              $crate::init::__internal::DropGuard::new(::core::ptr::addr_of_mut!((*$slot).$field))
>          };
> 
>          $crate::__init_internal!(init_slot($($use_data)?):
>              @data($data),
>              @slot($slot),
> +            @guards(guard, $($guards,)*),
>              @munch_fields($($rest)*),
>          );
>      };
> @@ -1189,29 +1194,6 @@ macro_rules! __init_internal {
>              @acc($($acc)* $field: ::core::panic!(),),
>          );
>      };
> -    (forget_guards:
> -        @munch_fields($(,)?),
> -    ) => {
> -        // Munching finished.
> -    };
> -    (forget_guards:
> -        @munch_fields($field:ident <- $val:expr, $($rest:tt)*),
> -    ) => {
> -        unsafe { $crate::init::__internal::DropGuard::forget($field) };
> -
> -        $crate::__init_internal!(forget_guards:
> -            @munch_fields($($rest)*),
> -        );
> -    };
> -    (forget_guards:
> -        @munch_fields($field:ident $(: $val:expr)?, $($rest:tt)*),
> -    ) => {
> -        unsafe { $crate::init::__internal::DropGuard::forget($field) };
> -
> -        $crate::__init_internal!(forget_guards:
> -            @munch_fields($($rest)*),
> -        );
> -    };
>  }
> 
>  #[doc(hidden)]
> --
> 2.41.0
> 
> 

