Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A48BA70E0E3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 17:48:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237638AbjEWPsg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 11:48:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237163AbjEWPsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 11:48:25 -0400
Received: from GBR01-LO2-obe.outbound.protection.outlook.com (mail-lo2gbr01on2103.outbound.protection.outlook.com [40.107.10.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 284A8DD;
        Tue, 23 May 2023 08:48:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lNcy1guVh9Z+aKkPNDBVN9aGBdhueklNpibYB0T0pIuYGTTR+xot/M73HpTShXFLH1ogCA0uPLisGi39Z9L2PWtZy9kIYopR89Kjl6N/WAwPL5/jP4Py1NYGuaXzfCES91+KQAlH66z2KVSdl1hBajM4yHq6dHIg2DXTou2Nqqs5hPpJF6emBu8lEtknxP91C9Ba357XYyOojKoUJgmch7KN5W8A0l6OEoWf0uiGPBnkDbVmMuAVserfAn9D/y8EtSOcS0CqZdWqRpjSlBZesc/vWzS0KyyE3vhmb3WwsAGucrqBZW+4KsGuixhKOrA/czl98kepf7oOsOA/OisJbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ie7sFZlKhgyzmA710x9BpnmSpgAnr/EMW+S5Ucqg+Ww=;
 b=IqdQdBuoyS6KJqajy6uGToKck9jUoTB5dMA6M+wf82I0kEgokJtsaVgaC6d6PJqgXSlKVFKdmRpwfg7v2zQEjzgf4WuxfqzpJBEQQkoOjMREOIBmndvVcTFxjejxSPQV3qEHVeQ4444M7nH6cnVhRl7+3ICgO5+wtZskRqlbzfLnG0Pn6BGPFB1Sz96dXRTwZ3FWB5OUuAwDIldEOkCtnR2Z2c1bd/sanOGqJkzxfqjiNMskFtDBQYfaa3tDQBrVrmj+kb2XXv/9aJcgt/z6jNz84uZa7D6KfhxlqREGWGbEP+1KRn7v6ucfYe/gSB/xprn8e8fZjg6so29v+i4TDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ie7sFZlKhgyzmA710x9BpnmSpgAnr/EMW+S5Ucqg+Ww=;
 b=i9LJSRk3tF1UFSEBNErbBJnwqQ/4SMl9R+60fR0MCOE7iR1iY5fitxjXy/G8j0hB6ivKvHJQHJPvXVRyUgpilsPXBybmArWJBRDetgWaw8ZPZJhEWBFPfZoB8Pkqt7t0Jr+5noL4N4/X64rqn+gIeCW3g0uftTEhbN5Fjb0qZHc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LO2P265MB5133.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:250::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.14; Tue, 23 May
 2023 15:48:20 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1d51:d482:270c:7daf]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1d51:d482:270c:7daf%4]) with mapi id 15.20.6433.013; Tue, 23 May 2023
 15:48:20 +0000
Date:   Tue, 23 May 2023 16:48:18 +0100
From:   Gary Guo <gary@garyguo.net>
To:     Alice Ryhl <aliceryhl@google.com>
Cc:     rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "=?UTF-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev
Subject: Re: [PATCH v1 2/7] rust: add offset_of! macro
Message-ID: <20230523164818.0a44fec8.gary@garyguo.net>
In-Reply-To: <20230517203119.3160435-3-aliceryhl@google.com>
References: <20230517203119.3160435-1-aliceryhl@google.com>
        <20230517203119.3160435-3-aliceryhl@google.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO6P123CA0039.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:2fe::19) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LO2P265MB5133:EE_
X-MS-Office365-Filtering-Correlation-Id: 40adfa6b-6476-43a5-67a8-08db5ba521fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +dloc5TNVYASUvavkatYbIWR15IwqcES/xL489/pL9QNSwuJwuT9HmPVy81rZRGGhVLs4h+IMJIpdb8OVQb+EyfUBsSuX7sYuNSKvNWbPPO5Od2TDCivLmUHMXqE8Nz/C8yDgUGlZkjFI0ldWw6YfUBVYKzjOYMzLN+nx2Drs1V1rFsYNFgnkcMGqdOE8pkfuBw+H1fYYRepKpMxJcL/0CkG+aWKQHlC5OxrjqpwV/Qx0Eyw4hqs3SRELDRbcNepy7zpyENWM9R7Z3vZhbZennHmpLsBm/dlz3vKmdasyXK04dgb+nt4y4WY9yhqtgdQ+auFVUvDd64pry9TjRoat/2zZmxFq/FeTldxSyn0a37WB7DRYInTzo1nlbp/dJ7wYvhOFDBJnkt6rvUfAFIUauD1SoBNvV+kyNhvARCaWGXbLQviJ6naujzocJOJpDHOAlj6MFoIWOpaaF/eZiQLiq8tZrHV2n/L7JobDOBkP51XCZTCLtZ1MRFhI4WpJSLpQz+hGUrP5arp0Yxepv6dCqT4PBIo+Snd/JbPOUWwfKo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(346002)(366004)(376002)(39830400003)(451199021)(8676002)(8936002)(86362001)(966005)(5660300002)(2906002)(6506007)(1076003)(26005)(6512007)(36756003)(83380400001)(2616005)(186003)(7416002)(38100700002)(66556008)(66946007)(66476007)(6916009)(4326008)(54906003)(316002)(478600001)(45080400002)(6486002)(66899021)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8UGtcrEk6lBuTWk/EkVGbjYEXcjwswvUkMXgLSdyp1HMISB6g81hsV0Kx3y8?=
 =?us-ascii?Q?jlbKX5yMJPd51X/T2IeVfJ4EH5BU75Ix62QKgTC+JdZCDSQqQ61OwJZMZyKf?=
 =?us-ascii?Q?rcZz4QYUyOW+g3sdpXWDOjcs8sJXwNFaWLhiyHNxX0LTcIPmm0Ezy9Um3yNN?=
 =?us-ascii?Q?RuQ8Elr2BQR3FgGBoVFyBvfup2RzTR1F96wxh1WF2N2BBp4SGT+bAeXxw+oI?=
 =?us-ascii?Q?zGR4TF2ZSpeJNHGihwL0MSfmqglfWO59l/Y4LWFdsGapYJrBVYHOtTshJyla?=
 =?us-ascii?Q?leIA9gfuHTs6y2ACvL/Y9vV50MiCwsjvqBSVtoHSorKuBqEFJf+IjGk1xdk3?=
 =?us-ascii?Q?Cl8er+SyFD7RfINNausVfzzjaVflPBiu0Sa/NeMnYQJZmmUdG+L5+kdACoPB?=
 =?us-ascii?Q?8DGmHLNqbA/CKDO79hbbLwRo7rWqIlj4CtqqebeAEDOlsQoLZoT4zWGXjqJY?=
 =?us-ascii?Q?nKjODP3boA+XKs07sXGm5zALh2VJOOt7BWv54XgC8RgF6xYvBxOC5dp9WlMz?=
 =?us-ascii?Q?2lqbOqAdyt4bGlHoMID05SjSxS3L4da4VlDsF677h2YH7fcJq8kekZOZNRSu?=
 =?us-ascii?Q?EvlSnc7SvpWc1iKEVTDwqbe5OqF8Y5k4LqJ9jGpQPWleaO0xV8uESMw0nnuc?=
 =?us-ascii?Q?WKK07WmOXoewYeueOidbB+2xAwgUaSy9qfoQQk4oEQ/AR7ihrcr6pwDJ2oE9?=
 =?us-ascii?Q?joRA10nIlftMliUszDVMO11WPnEEVH3RD2sg1AaL03h+jOP/kDygbAao2B5C?=
 =?us-ascii?Q?CT11C+YTeFvgMe3SD1EuPNzHdgv/teQoQapx52NMaPxZNJug8rsRECPKrLl1?=
 =?us-ascii?Q?kenu13fypAd/txpweL9QEEO6QQjR3GJw+hTh8TRAp8FLjRqJd+m9p2o5q6iS?=
 =?us-ascii?Q?zWYyn3hiefLKJlAT5E1Ch/QIBTudYe3+4m5x0dKEQ7p6fkzEYHDJQfE67e+7?=
 =?us-ascii?Q?s2acRyV2V7siQEVwPn8ot0dGtYFAoMIM9HhVZj9YQBF1EzkXjjuKt/fEVC1u?=
 =?us-ascii?Q?XVi7qmGrxFENpfZJxVpJfOzEvvjuw+Suxs9TCStber4+eXGgZ49+2k0bH/5G?=
 =?us-ascii?Q?RB24koCwTfe9PXpecJcnuOBLLtQNuZA41eNM+gFLG3iED4xu+e8uqFBMb498?=
 =?us-ascii?Q?iq+3t2sAJs0mAPBr7deNJBmhFHBgq+2q0YtPBAOVt4vxnFls0wfHtqSo+4sf?=
 =?us-ascii?Q?wQ4YYKchX+7Xtg9PEozGlP5cAzk58WfsIPPEU8x+BXlk+S3XOrqG4mFWK4PC?=
 =?us-ascii?Q?i9pDGHaNW1j3abwGe9OFlpnd5VCrj5Fyx2OC6qz3GH5VgkLkAfhjbyXmuSwz?=
 =?us-ascii?Q?eDZZ6fUtovFRsd2wbSlW9zUt1vuZUzyUUqkoeX1nBY5J0IuX25ogBzEl+KHc?=
 =?us-ascii?Q?tFRkK7jdSyurcgAdFZLZh0pslO/1KXgAoI3/JAjHtejOvzItJ8k7i6wnDpOD?=
 =?us-ascii?Q?e9y34DatzNWVYz9Prq1TsNVXd2nj1KfejGkXLgWRJ2EyVWV/S4AWtTmc+Rd+?=
 =?us-ascii?Q?PZ48ygLfCgYsFuX5vGKDkn/NIBDZM/Vrt0Vy9f0Hi99iW6IYOM2y/7hZ9YgH?=
 =?us-ascii?Q?rMv5EIiyt6n58QpzPwEu5Q3vB+FYbAJ2UnJhoBUn?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 40adfa6b-6476-43a5-67a8-08db5ba521fb
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2023 15:48:20.2245
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LPBHbeOn4XxCkn+34+Z7/imTRm85ZAszOEBxEHa92R9RPb+OImQ6aQo/qtxHssasECc78h8aa1IXR/AXElPH4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P265MB5133
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 May 2023 20:31:14 +0000
Alice Ryhl <aliceryhl@google.com> wrote:

> From: Wedson Almeida Filho <walmeida@microsoft.com>
> 
> This macro is used to compute the offset of a field in a struct.
> 
> This commit enables two unstable features that are necessary for using
> the macro in a constant. However, this is not a problem as the macro
> will become available from the Rust standard library soon [1]. The
> unstable features can be disabled again once that happens.
> 
> The macro in this patch does not support sub-fields. That is, you cannot
> write `offset_of!(MyStruct, field.sub_field)` to get the offset of
> `sub_field` with `field`'s type being a struct with a field called
> `sub_field`. This is because `field` might be a `Box<SubStruct>`, which
> means that you would be trying to compute the offset to something in an
> entirely different allocation. There's no easy way to fix the current
> macro to support subfields, but the version being added to the standard
> library should support it, so the limitation is temporary and not a big
> deal.
> 
> Link: https://github.com/rust-lang/rust/issues/106655 [1]
> Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
> Co-developed-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
>  rust/kernel/lib.rs     | 35 +++++++++++++++++++++++++++++++++++
>  scripts/Makefile.build |  2 +-
>  2 files changed, 36 insertions(+), 1 deletion(-)
> 
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index c718524056a6..cdf9fe999328 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -14,6 +14,8 @@
>  #![no_std]
>  #![feature(allocator_api)]
>  #![feature(coerce_unsized)]
> +#![feature(const_ptr_offset_from)]
> +#![feature(const_refs_to_cell)]
>  #![feature(core_ffi_c)]
>  #![feature(dispatch_from_dyn)]
>  #![feature(explicit_generic_args_with_impl_trait)]
> @@ -102,3 +104,36 @@ fn panic(info: &core::panic::PanicInfo<'_>) -> ! {
>      // instead of `!`. See <https://github.com/rust-lang/rust-bindgen/issues/2094>.
>      loop {}
>  }
> +
> +/// Calculates the offset of a field from the beginning of the struct it belongs to.
> +///
> +/// # Examples
> +///
> +/// ```
> +/// #[repr(C)]
> +/// struct Test {
> +///     a: u64,
> +///     b: u32,
> +/// }
> +///
> +/// assert_eq!(kernel::offset_of!(Test, b), 8);
> +/// ```
> +#[macro_export]
> +macro_rules! offset_of {
> +    ($type:ty, $field:ident) => {{
> +        let tmp = ::core::mem::MaybeUninit::<$type>::uninit();
> +        let outer = tmp.as_ptr();
> +        // To avoid warnings when nesting `unsafe` blocks.
> +        #[allow(unused_unsafe)]
> +        // SAFETY: The pointer is valid and aligned, just not initialised; `addr_of` ensures that
> +        // we don't actually read from `outer` (which would be UB) nor create an intermediate
> +        // reference.
> +        let inner = unsafe { ::core::ptr::addr_of!((*outer).$field) } as *const u8;
> +        // To avoid warnings when nesting `unsafe` blocks.
> +        #[allow(unused_unsafe)]
> +        // SAFETY: The two pointers are within the same allocation block.
> +        unsafe {
> +            inner.offset_from(outer as *const u8) as usize
> +        }

This has no protection against using `Deref`. The memoffset crate has a 

let $type { $field: _, .. };

line to ensure that the field is a direct member of type and deref is
not happening.

> +    }};
> +}
> diff --git a/scripts/Makefile.build b/scripts/Makefile.build
> index 9f94fc83f086..ec583d13dde2 100644
> --- a/scripts/Makefile.build
> +++ b/scripts/Makefile.build
> @@ -277,7 +277,7 @@ $(obj)/%.lst: $(src)/%.c FORCE
>  # Compile Rust sources (.rs)
>  # ---------------------------------------------------------------------------
>  
> -rust_allowed_features := core_ffi_c,explicit_generic_args_with_impl_trait,new_uninit,pin_macro
> +rust_allowed_features := const_ptr_offset_from,const_refs_to_cell,core_ffi_c,explicit_generic_args_with_impl_trait,new_uninit,pin_macro

Side note: once we bump our compiler to 1.71, we should switch to the
built-in `offset_of!` macro and get rid of these unstable features.

Best,
Gary
