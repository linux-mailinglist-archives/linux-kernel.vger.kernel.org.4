Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D25FE7416A4
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 18:43:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230262AbjF1Qnn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 12:43:43 -0400
Received: from mail-lo2gbr01on2095.outbound.protection.outlook.com ([40.107.10.95]:19168
        "EHLO GBR01-LO2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231499AbjF1Qnh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 12:43:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U4nNKLkrV1HzHSLlQU2ZOlM4sqvdf3AA5acAiluiYqhzjY5vPb1NJMq1qisizJz77DZgY28rHx+JjcKO52pohBsjWhEh50iKt2kC9pyXR4CCC9WwE1nVv9HhSHVcB6hnXhk3tl8KeVKSbmweUWa5eIIrY7cYD3aZy6ncf7UUvMuYdh1CUtNi1Wv+sZqYPkwBfQTUycXWKdboCpv13FDZgvxoYtzj5xCKAkuG1qg/fb6C9WGP//2FXdJesSArvykjPwTGQWpZ0a2lPr+3ZDOb2sbvgClTucnsVwJ0/pJXzL0Y+cyM/zUKv3Y3tU+FUpCwnFNGAywrlaOQlbPUoKR7WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5SfdNDVOAv/wegHEkRfTMjKXsGPp9lBdUOishV0cPDo=;
 b=DwsvIu/ctX73XOfiea42GwSaTbdlI9k/bRMiQM5BKkISxGhpiZ2LP3/NrKWkQnJR1ZfApwsIkJSFqu58Vh8U4A1pbLuqpv/ESTCn8vKAu4yrn5ItPoLEhbHPDiTNUCoDryjpOELB2/qNz8F3ENvprXe+8Chy8IHJuR5TxiPx9p5ukiGs1ZTm5cg/A1YFgCv8YXjNrxJAW0NiIxzrRB7c45eMXlbPdOZ+pFCabAPeGE0YRYHYDlpyqWXslKIl7/T7oSuPGyruqOUp9j9dOu0+HAOWZNOut2goVAcZzRd/gwb8gDkLwecH4hxTca1cxdf0Eqivd+OLOf+rxBF/9EPpTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5SfdNDVOAv/wegHEkRfTMjKXsGPp9lBdUOishV0cPDo=;
 b=pnQQzsKY6dq6A8e+RWfUi59IXAC0/P6lC39VLfat2LIMQUTJheRGsr3J0ZHoOcsb6A9drpLmgmEFVa3tUfdb8J1sMJvpiMbnrZvk4WAvb/63QvVjl/K3qYdSmA7LQQlXHAY3iwmVIJL+b3p4slVuh2QdkdrRx8+NUrXY5SZmc+w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LO0P265MB7238.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:335::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Wed, 28 Jun
 2023 16:43:34 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::25e2:a08b:cd9c:c3c9]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::25e2:a08b:cd9c:c3c9%3]) with mapi id 15.20.6521.026; Wed, 28 Jun 2023
 16:43:34 +0000
Date:   Wed, 28 Jun 2023 17:43:33 +0100
From:   Gary Guo <gary@garyguo.net>
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        =?UTF-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Subject: Re: [PATCH v2] rust: alloc: Add realloc and alloc_zeroed to the
 GlobalAlloc impl
Message-ID: <20230628174333.6eb827ae.gary@garyguo.net>
In-Reply-To: <20230625232528.89306-1-boqun.feng@gmail.com>
References: <20230625232528.89306-1-boqun.feng@gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: LO4P265CA0236.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:315::15) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LO0P265MB7238:EE_
X-MS-Office365-Filtering-Correlation-Id: e245c422-f42f-4c02-e160-08db77f6d08b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ho9++VitKFYAtTlGh1NJoHhVfrP+07l9G87syFcLHHq2lRj+4hPc5Y13/+OPAFzGgXVxq8qQcl8DE+BdqlJHl+dNRS5cN0CaxNDymDkRvEUE/lEnQioyBXh49wDuWwgs21ghKplrde9M+NzdYxtuY3LOQ/kUv4FHgmLpp/S9HoaRLp2R1e5rVzQpY1nhyzFDUxNxx/GlZqWqP1ue66+OUkEgHV2wBK4cUPunY8YB9iYuyAnaRFezMB4O5/iOKMLRyXDhOePhDQb+NVItZCJATjc0A75afhBOj0H9is7SAGSZKCea1HUu9RZXFfVFfQ2D9un+BgzAxTqMx8dVfjoati/QmomJeFJ0VKrPpMBVcr9rkfHHq2ue9NkakBLfAmz2L+mp+nhOu3+k5goHXy6S+xkMeOyxyRcRvhGQ9hPAN6PiWmKtojkO2jf12Q7lNK3n3PHKHwNKBNs2He4JH+/cx39fIfOFBDuphDth5rhYPnASPEkO3kyy3SRIuTp96iwNh72xhbvxuho/Bm720FXeSK+LCU0MYwHiAwQtlm0zu00=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(366004)(376002)(39830400003)(396003)(346002)(136003)(451199021)(6506007)(26005)(2906002)(6486002)(1076003)(2616005)(38100700002)(83380400001)(186003)(6512007)(966005)(41300700001)(86362001)(54906003)(4326008)(316002)(66476007)(66946007)(6916009)(66556008)(8936002)(36756003)(5660300002)(8676002)(478600001)(66899021);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z2J0Tm1xUmRJYmRiNW1HRHgvditlcUVBQmw0WjNaWDMveEJXVGF4d0U4a1BP?=
 =?utf-8?B?NGFIRHE5QUdjVXJGa0htL3laUzNzeVlwUFlGWitRekl5NHlucVpXZzM1WHk0?=
 =?utf-8?B?cVhqdnBtZ2tFU1JITW1SWnA0L3ZuTFd6MWtmSmRIVlc2QnhERHBLZW1Fbkkw?=
 =?utf-8?B?ZW1oM1JCS2pWSUpFWDRZOGgwVmJDdTBXSWIyZDVudVlvS1MrUkNuclZucDZ0?=
 =?utf-8?B?UC9ldVZ0M2JoeFZDL3NrcUs5ckdKSmR3Wm02RWhaWlgzcUdaYkNYMUZOb3Vx?=
 =?utf-8?B?VHQ3WUtWL3JiYzNlWkkxYWwxcTlXdXQxcHVZSXBMVE83OUROOWsrU3l1SFNR?=
 =?utf-8?B?SVNWUVFUY29vcnJLZlpYWHdjR2JXMjd5LzdBTURiTmNTZmxtOE9wOGMvd3Ay?=
 =?utf-8?B?Q3lycmwydGluSVhhWEZXcVl3UUVhOVBZNUtDN1BVUHRGcUZRa1U2TEU4UUJo?=
 =?utf-8?B?M3dqSFZHQXhMbVdoelcyR1ZoRlJuZHE2SnJSL2llajNyVVFGVHhsbi9jVGdE?=
 =?utf-8?B?M3M0ZXFmZVlyYVgzYlFCKzFYZXlGRDJFNEtlZEE4VFY5YnlFcldoT3dkMnh4?=
 =?utf-8?B?MEc4RHdSQXhGblVXMU5qMFZkYnJpOVpZY2ZRdlFEWm1sNllWWHZ3L2lyRzNE?=
 =?utf-8?B?dmUva1dvOU1KSzZvdENTWGVDa0pkYmVraHBJMWpxVTNjMkRBVStmdU5CUmNv?=
 =?utf-8?B?OHh2LzZtWEh0QmdzdTBCdkhicFgwbnJVZ3RyMnZyVFRTaWsweE15QkJnOUl0?=
 =?utf-8?B?SUtmaDdidnNnZDRpN3VCc3BFQ2phWEZieEdHcm1USGFzMHRsdFAvOER6WEs5?=
 =?utf-8?B?bko5dTdkaXUyMktlcWp6M1NBalE1d3FPUEk0bDM3RGFncWROcTJiaDFxTnBX?=
 =?utf-8?B?UTVrUXpCSTc5RE45NUxZTWRuWWcwb0FaYUlONjVzS0ZOMGpySllvTSt1b0JW?=
 =?utf-8?B?dFNaR0xDQnR6MHVKYzQ2R0Y1NmE0b2VjYVJMVmxLZ0xtSU1FRFB2eUE1MzU2?=
 =?utf-8?B?MzQvemk4SmMwaG5ya3YxK1FWTkxQYmVOWEhJbVcrY0RhWXY4YUZ6VjZiNVlV?=
 =?utf-8?B?VzZpdnV1aDJHK3FVQ1NOQUNZWURNV01yOGhuTGdrNUJqeHo0eTN6ajJPeFhD?=
 =?utf-8?B?NG00dXh1RFlwNElSMjA2c1E1V3RXc0N4OWlHa2xId2UrckI4NFNJckF5LzZz?=
 =?utf-8?B?bWRpRDdqTWp0aUdERVZzWDk3Q0c3SWZDd3dTeW9MbnF5TTk3VWRhaVI1Y1Z5?=
 =?utf-8?B?TzZVdTdZTS9kQ1JJZXpuVTA5T3BPcVRGeWhWUmFHd0wwM25GbXRvdlZjOVA3?=
 =?utf-8?B?dklFMUNSODZYRTFrUVR5aFdLM1lya1dLUVBneGlpZjR0a3N6aTJ2TFBsRWdk?=
 =?utf-8?B?dURnVlpmQzZscjN4UXArTWpwWVlRRTNQRWZ4bnh2U24vSXViek9nbVhLOFdJ?=
 =?utf-8?B?S1U0RGZIMS85elI0elhiQUV2cE1GQzNRc3U2S1J2UGdBWUduZjZxbXczdFBo?=
 =?utf-8?B?QmkzeWpOdzNxb212aXU5MExhSHJnQ1BWbXRqOXFPY0NIeFVoQnR1RG1BWU14?=
 =?utf-8?B?clUwM3h1V2RKenpBeGpNZjdSMGxCb0Y4NmJGdGdyRHQwclhyOUsxNm00RTln?=
 =?utf-8?B?TTZGSEJvR05IQ1phcWhBcFhreVM4c09lSjNsZlJRRHh4SjZJU1VtUXhKamFU?=
 =?utf-8?B?Q05QL2xJaTVRZnd6bTF3TDBteTM2Vmk2eExDU0loQldESlMxVCtYSUpDcVl2?=
 =?utf-8?B?WGNCOGc0Y3JWdXV2Z24yaWIvVkc4NnlPNnBCY1hRMnR3cmxHdU0rL3krV3JF?=
 =?utf-8?B?RnBUK3I1dHRUM0FDL2JmWFNYNC9KMTkvOHhPK1I0a1dZeGFyTW9uLzhrWFM1?=
 =?utf-8?B?L21iaEJHd25PYURSNmxFWW5JalZHQmpWRitOVVRXR3FwcXhvNlRNRWREaVRo?=
 =?utf-8?B?M2NyLzhxc2lEVTlLdDhWaXN4THV5d1dLUzNMNCtXVkE2V0xRRFVvRXcxb2h0?=
 =?utf-8?B?ZnhxanppRTRaclBCa2lBL0RFS0Zsc21CYldhNHAwZ3ZsTzZzRTNVMjFTUWJN?=
 =?utf-8?B?ci9TWDIyVFd2UWV2RVhRbjFUSU8rNFJ2SW9Xbk9SOENZMjRrSWRsRk8rVFdi?=
 =?utf-8?Q?R+P8Yd0mWNQT6CCOJHSvIOu4b?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: e245c422-f42f-4c02-e160-08db77f6d08b
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2023 16:43:34.8853
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: akBCrIvPeCx/Y2rTzCDUGIRonZ6KT96tL0dMt+NlstPIFZGmnRc2bEjIfAjhk9hdl9RPof+yNhbPm9Be3yQ5Uw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P265MB7238
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 25 Jun 2023 16:25:28 -0700
Boqun Feng <boqun.feng@gmail.com> wrote:

> While there are default impls for these methods, using the respective C
> api's is faster. Currently neither the existing nor these new
> GlobalAlloc method implementations are actually called. Instead the
> __rust_* function defined below the GlobalAlloc impl are used. With
> rustc 1.71 these functions will be gone and all allocation calls will go
> through the GlobalAlloc implementation.
>=20
> Link: https://github.com/Rust-for-Linux/linux/issues/68
> Signed-off-by: Bj=C3=B6rn Roy Baron <bjorn3_gh@protonmail.com>
> [boqun: add size adjustment for alignment requirement]
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
> Miguel, I fold my diff into Bj=C3=B6rn's original patch and make a v2, it
> relies on the other patch:
>=20
> 	https://lore.kernel.org/rust-for-linux/6e61f06f-2411-0bcb-926b-0a6927096=
f20@gmail.com/
>=20
> So this v2 (if all goes well) is targeted for v6.6, JFYI.
>=20
> v1 -> v2:
>=20
> *	Add size adjustment for align requirement.
>=20
>  rust/kernel/allocator.rs | 59 ++++++++++++++++++++++++++++++++++++----
>  1 file changed, 54 insertions(+), 5 deletions(-)
>=20
> diff --git a/rust/kernel/allocator.rs b/rust/kernel/allocator.rs
> index 66575cf87ce2..af723c2924dc 100644
> --- a/rust/kernel/allocator.rs
> +++ b/rust/kernel/allocator.rs
> @@ -9,8 +9,17 @@
> =20
>  struct KernelAllocator;
> =20
> -unsafe impl GlobalAlloc for KernelAllocator {
> -    unsafe fn alloc(&self, layout: Layout) -> *mut u8 {
> +impl KernelAllocator {
> +    /// # Safety
> +    ///
> +    /// * `ptr` can be either null or a pointer which has been allocated=
 by this allocator.
> +    /// * `layout` must have a non-zero size.
> +    unsafe fn krealloc_with_flags(
> +        &self,
> +        ptr: *mut u8,
> +        layout: Layout,
> +        flags: bindings::gfp_t,
> +    ) -> *mut u8 {
>          // Customized layouts from `Layout::from_size_align()` can have =
size < align, so pads first.
>          let layout =3D layout.pad_to_align();
> =20
> @@ -26,9 +35,22 @@ unsafe fn alloc(&self, layout: Layout) -> *mut u8 {
>              size =3D size.next_power_of_two();
>          }
> =20
> -        // `krealloc()` is used instead of `kmalloc()` because the latte=
r is
> -        // an inline function and cannot be bound to as a result.
> -        unsafe { bindings::krealloc(ptr::null(), size, bindings::GFP_KER=
NEL) as *mut u8 }
> +        // SAFETY:
> +        //
> +        // * `ptr` is either null or a pointer returned from a previous =
k{re}alloc() by the function
> +        //   safety requirement.
> +        //
> +        // * `size` is greater than 0 since it's either a `layout.size()=
` (which cannot be zero
> +        //    according to the function safety requirement) or a result =
from `next_power_of_two()`.
> +        unsafe { bindings::krealloc(ptr as *const core::ffi::c_void, siz=
e, flags) as *mut u8 }
> +    }
> +}
> +
> +unsafe impl GlobalAlloc for KernelAllocator {
> +    unsafe fn alloc(&self, layout: Layout) -> *mut u8 {
> +        // SAFETY: `ptr::null_mut()` is null and `layout` has a non-zero=
 size by the function safety
> +        // requirement.
> +        unsafe { self.krealloc_with_flags(ptr::null_mut(), layout, bindi=
ngs::GFP_KERNEL) }
>      }
> =20
>      unsafe fn dealloc(&self, ptr: *mut u8, _layout: Layout) {
> @@ -36,6 +58,33 @@ unsafe fn dealloc(&self, ptr: *mut u8, _layout: Layout=
) {
>              bindings::kfree(ptr as *const core::ffi::c_void);
>          }
>      }
> +
> +    unsafe fn realloc(&self, ptr: *mut u8, layout: Layout, new_size: usi=
ze) -> *mut u8 {
> +        // SAFETY:
> +        // * `new_size` when rounded up to the nearest multiple of `layo=
ut.align()`, will not
> +        //   overflow `isize` by the function safety requirement.
> +        // * `layout.align()` is a proper alignment (i.e. not zero and m=
ust be a power of two).
> +        let layout =3D unsafe { Layout::from_size_align_unchecked(new_si=
ze, layout.align()) };
> +
> +        // SAFETY:
> +        // * `ptr` is either null or a pointer allocated by this allocat=
or by function safety
> +        //   requirement.
> +        // * the size of `layout` is not zero because `new_size` is not =
zero by function safety
> +        //   requirement.
> +        unsafe { self.krealloc_with_flags(ptr, layout, bindings::GFP_KER=
NEL) }
> +    }
> +
> +    unsafe fn alloc_zeroed(&self, layout: Layout) -> *mut u8 {
> +        // SAFETY: `ptr::null_mut()` is null and `layout` has a non-zero=
 size by the function safety
> +        // requirement.
> +        unsafe {
> +            self.krealloc_with_flags(
> +                ptr::null_mut(),
> +                layout,
> +                bindings::GFP_KERNEL | bindings::__GFP_ZERO,
> +            )
> +        }
> +    }
>  }
> =20
>  #[global_allocator]

