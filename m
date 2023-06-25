Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B10473D42B
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 22:39:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbjFYUjh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 16:39:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbjFYUjg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 16:39:36 -0400
Received: from GBR01-CWL-obe.outbound.protection.outlook.com (mail-cwlgbr01on2108.outbound.protection.outlook.com [40.107.11.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE6FF9B;
        Sun, 25 Jun 2023 13:39:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lH7zI0JRNXPJTnKWdVtlRmMeW1Tc33aUQz6xiBM05NmACsUmSCl6AXO/3tf3820qhn2gulnsCzwDNSj2vEHVaEfo7vCsVFzL0VV1QHFB9H9hAT5EauAkQMKlf0+wu1UzO1QcSS3tMen1tQrT5b4LXG7hgCeCvRvf8BoWQ1s7NiGXuEmUv1Xac5iJtgG2Te6Qq5XA1uiJ2/zeAj2cU/fQ6sibzxmOil8MaXDiXQaCzafezun/wPy/3VID40oEdOlXNbNtE+zowboMNp3fIvG5IJK+LZ6LZWCPh9OrtcwKbHjk2zPQN+toxjkZUUSaLOMtwj5f/5QDujNxWOhNn6ya1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uPrnreqVJ5+8iDTPXkeMsK0qhACFvbnRxA5lMz4/QM4=;
 b=Iv4yo5401xaW7VfTiP8awvwQPHb4pRgypdW+j0g16vsyIR6zt4qBRW/LoGkPtmGNPYEOTjni5MdIhrDTolTCouFDoULNahA5rnZGf2oOMTo033eet6BJbmd2uLpd/WS/Wgpp38riL1tbyvi3et8hTKJmiHGddnWLr7divH1ezwQT1ab/lMxJrlb6OTewDEGeUu6cNfitCpp/qHXz/KrSMkfHPy+y0NUn6B8lDw2iJG6pDXYxY7C3JMI22+UYwyIkHOUSg1Hsv1ACQikImMo2h+Wv0i66NkdqdDmq2ItM77l5vq/Li7texvzNYSHTVNO9CjxOXOv5tTSJgwaGoqDVuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uPrnreqVJ5+8iDTPXkeMsK0qhACFvbnRxA5lMz4/QM4=;
 b=P51KrsdOlB4JdNGdSM2kmC1DxmClx9xB3utr9jG8Xl0n7iT7hcbn63+hcjoB9l3Geo+4Kr1Cl77jzOE5Lbe7boz96C7+fzQmkzJwG4fuQTw8en9Cpw4F2wfqcv2O1wijiuLXZv8QtUWL/HP+61/i6L152d4IWVvelEj6nnDFrr8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by CWLP265MB5498.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1ba::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Sun, 25 Jun
 2023 20:39:32 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::25e2:a08b:cd9c:c3c9]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::25e2:a08b:cd9c:c3c9%3]) with mapi id 15.20.6521.026; Sun, 25 Jun 2023
 20:39:32 +0000
Date:   Sun, 25 Jun 2023 21:39:27 +0100
From:   Gary Guo <gary@garyguo.net>
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     bjorn3_gh@protonmail.com, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rust: alloc: Add realloc and alloc_zeroed to the
 GlobalAlloc impl
Message-ID: <20230625213927.2e656905.gary@garyguo.net>
In-Reply-To: <ZJXXxEfzVza5Jzxj@boqun-archlinux>
References: <20230622-global_alloc_methods-v1-1-3d3561593e23@protonmail.com>
        <ZJXXxEfzVza5Jzxj@boqun-archlinux>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: LO4P265CA0145.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c4::7) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|CWLP265MB5498:EE_
X-MS-Office365-Filtering-Correlation-Id: fbabf298-78da-46ff-32c2-08db75bc47d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nBQytzPKz/+rdubERAUge1a8NvjiIlRIGBG/EmRExg7PN0QxZy3oxD9FOhaw9d2kAWXcuRjVNxbWHZmdtymBXpyVBGE6Gx0nVbG2XBUJLAFdqCXgQnU91i5taetlBXABxAof1IkxdojvXQA6D2XVlPuolBOPN3jj2gyVuB+5juJU3xsBD7gDfXKSw58dYeWsQa2JBDgXdH7FyLMbPq+4F8G1No/NEVVHpOe+LVYiCPHtrQF8YrOCzFwjrstK6ofhO+gf8Sie3JkXNYs/3NwsbskljmCfw/2ONsv1ael33v6z8Owsx2l1sN+hcHgWmSjd13yAPHd1bpQREb/iflFYIV+/CnCN7My4HLkj+1Jq88tDBnXzft+VyKVC3z+r0Vg6Z4HzgtMUxqR3818UgNs0Z4CApQhGhlA7KX6eBZkxL1kBtkXyqho24qdd6XZ3p3nZkHPz8CwKoso0dviblHqNo5avdL6a4xtWY3vMsUOsspoYkj6xXRzfgRSYR8SoMFFcfniiiBliui+vYruLAA4pYUhNtpMqjQnOVs9dUvtaP/U=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(39830400003)(376002)(366004)(346002)(451199021)(36756003)(316002)(66946007)(66556008)(66476007)(6916009)(4326008)(478600001)(5660300002)(8936002)(8676002)(66899021)(966005)(86362001)(54906003)(41300700001)(6486002)(2906002)(26005)(186003)(6512007)(6506007)(1076003)(38100700002)(6666004)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aW9Pdldtak5QVU5uZHdHTmQyNE9mTVV1SWkrdTJmbVZ2ZmdoRzg5T1R2SnZL?=
 =?utf-8?B?eDRiZ2g4L0NOb3VKeWJBelBFMjNOdEQyK09ERjhaSHhGNlorMy8xaFdKbjl6?=
 =?utf-8?B?ckJHcldsbTNaMFJoei8xZE1RbEZ1Y1JnL0ZjUVQ1bUN5OTQ5NTBJWEkzbExJ?=
 =?utf-8?B?TjBNbkJab1EyNDRiQ3Nad3g3c2YwUXZzY2QxVWtOTDc3T2hEeWhXVkwrcWJl?=
 =?utf-8?B?bGtkL0VEVjR2VjFLNG01SjRFMUpBbDhOM1BQa1QzS3ljcjF0OUVEazR1ZzQr?=
 =?utf-8?B?QnZ0MEszM1dSNzZteWZWNEg2SlBBdFFSYTByeWVLWjM2bjhnM3lwVmE4NGJo?=
 =?utf-8?B?eFBvc0ZJOTBYL1NkWU5yb3c2dk1STVpMc2pGclZpb2xZSktINFlNd3h6UGJS?=
 =?utf-8?B?Q1JteGtWaW5PaFdBS3hIOG9CUFhnYUp2WlJrNndrOUc3MXdqK25rSysxMFUz?=
 =?utf-8?B?TCtMbWJJcFl5bk9hN0NuQklHMTBWcHpDZjBhL3VMdS9INUxqdFpmNlhrS2dR?=
 =?utf-8?B?Z2EvbmIvR09vblU1UDZheEVjdy92Q3VqbkowK0g3cFlBSGVNcVFTcHJvQTg3?=
 =?utf-8?B?aUNqRkhjTkJyRnFwcXpPR3R6NS9MTHE1WmVoNVh3TWxYcDJTVm1PdWRZVzFY?=
 =?utf-8?B?eXd5VEVSZllKcU1HcGdSRjE1MTY5ZTExRzBjVHNtZkFYNGJENUJyS3p4dU1k?=
 =?utf-8?B?Y2g5cVNNSkIxTmpQSHl5d3BWUnZ2dXE3SG1hWTQwclpoNlNRZU9ydUV1R1VR?=
 =?utf-8?B?aC9sOTBuL2RHaUt3MDdmdVBaRDBkeUZYZU9NczB2T2luSjFPYlZlUjVSYzN1?=
 =?utf-8?B?WjNMRjBLdkRwV3RPdjlUYTNJdk5id21QUDlKRTAranpvb1NuREtJSFltMnk1?=
 =?utf-8?B?MlBJT1ZpeWlQWnRSaHVBWWVhTmlJMjhDVmZPb3k4SlJIMkhraDl6NWRHRjNw?=
 =?utf-8?B?V0hlTWxmSUFKL1BuVVgrOFg1dDdSMGdzdUlUUk9TR2pEK3gxRFZzWWJnVGgy?=
 =?utf-8?B?Yis0R0JVSE9pZEdmR0FvSVRWSG1rZHYwSEZjR0kvTEkzcUhNbm9tK0JYMllX?=
 =?utf-8?B?QmV4VDVZQlB4YlpPaWtGWFRsVHFmajlDZFQzQWdGUjNTOVFRQmRCMDBlT1Jr?=
 =?utf-8?B?dEsybkQ2enVoY1FBdm9OQndicXpaRHprV2VMRzRtVHA1YnNPdU5vODYvcGxV?=
 =?utf-8?B?WnVNZjJ4K0gwYUdyMnREdCs0SmpEN3JrWG5GUEtjQ3h5K3hSczczbWJjbFEz?=
 =?utf-8?B?NUQzVjRxZGNtdThZK1FFQVFCVTdnZkhUNkdzNkkrekpIUURkYUZldG1vWmFC?=
 =?utf-8?B?Rm9yQVlDUCt5cUtmNUwrNGdBenV1VFQ3cHJob2duYlZtVHdkK0pWSG1Xdnh4?=
 =?utf-8?B?ZHFJaUFYT1Z0UEFnM050QTRPMkFOU2UvRCtQcjFBVVRSMUhMelExNzlyWnl4?=
 =?utf-8?B?WnJtUEwrbVBpOGJjbjU2WTB2OEZwZE9mSlFTTi9Nd3NXN0xOR2hJMVViRjE0?=
 =?utf-8?B?eGFwMWVNVlUxUDFubjRDM3dJNlZwajUwR0VlclNmWmhjaGFSZDRyZEhWTVpI?=
 =?utf-8?B?eVp2eUdOREVSTDg4KzNQNzJoWk9wcC9uU3EyeDRtcFJ3Uk9JNHVhL2VkY1Q1?=
 =?utf-8?B?VThsaEYzTkxLQnEzcHpiTC9hMjFmNXliYmcyeTk5WC9sdEtZRFF3WTdwSEhl?=
 =?utf-8?B?UVlCR2Q5enVLajU0RzJuL21Ydk13WG4walVxSnp2d0docnFiRUVhUU1iejRT?=
 =?utf-8?B?SFA3TkY2Z2hhUDQ2ZkFNS2ZKaEYyWE9OWURlbkFaaEQwZkFPNXZKdmMzTThT?=
 =?utf-8?B?bG5wK05aL3QrbFlRN1dnUnJkem92bmJuN3hNTmUyQ0NmU1FBLzlzZ2cwZUov?=
 =?utf-8?B?VFFpaE92NlB3bVNEVnExS2xVNmR6NEJFY1NqWi81Q2pzQ1U2aTRtZ3phRWgv?=
 =?utf-8?B?czVSK3Q0UC9kdTdnaXI3aDQ3dlRPTEJJbmc4aFV3OFJ0T0YxNExxUHQxa1Uz?=
 =?utf-8?B?NjJTNnNNTklMaTBqQk92WFNmM1NGK2hnd0JnNFJaOENlM3NXYVpObXg1Nk5Y?=
 =?utf-8?B?bTZCVDgxRzljN3kxTUtyb2ZMeUlNT3R4TUJhSFZkNjV6eGZ6WU0yM3hwSUhm?=
 =?utf-8?Q?k3nDp3imaZXxnIR9/N7q997lz?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: fbabf298-78da-46ff-32c2-08db75bc47d3
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2023 20:39:32.4116
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PECENeP3MY0O4ZyauKZ00ONFh2IuuqVr7NFYZmsbSTR59iHfOkwThjBxTTj6eqSaAQI2F+v2BQNXgsPGIftVuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB5498
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Jun 2023 10:35:00 -0700
Boqun Feng <boqun.feng@gmail.com> wrote:

> On Thu, Jun 22, 2023 at 09:24:40PM +0200, Bj=C3=B6rn Roy Baron via B4 Rel=
ay wrote:
> > From: Bj=C3=B6rn Roy Baron <bjorn3_gh@protonmail.com>
> >=20
> > While there are default impls for these methods, using the respective C
> > api's is faster. Currently neither the existing nor these new
> > GlobalAlloc method implementations are actually called. Instead the
> > __rust_* function defined below the GlobalAlloc impl are used. With
> > rustc 1.71 these functions will be gone and all allocation calls will g=
o
> > through the GlobalAlloc implementation.
> >=20
> > Link: https://github.com/Rust-for-Linux/linux/issues/68 =20
>=20
> Nice! Although I think we need to do the simialr size adjustment as:
>=20
> 	https://lore.kernel.org/rust-for-linux/20230613164258.3831917-1-boqun.fe=
ng@gmail.com/
>=20
> so I applied your patch onto my patch and came up with the following:

The diff LGTM.

>=20
> --------------------------------->8 =20
> diff --git a/rust/kernel/allocator.rs b/rust/kernel/allocator.rs
> index ce7a06bf7589..af723c2924dc 100644
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
> @@ -37,23 +59,30 @@ unsafe fn dealloc(&self, ptr: *mut u8, _layout: Layou=
t) {
>          }
>      }
> =20
> -    unsafe fn realloc(&self, ptr: *mut u8, _layout: Layout, new_size: us=
ize) -> *mut u8 {
> -        unsafe {
> -            bindings::krealloc(
> -                ptr as *const core::ffi::c_void,
> -                new_size,
> -                bindings::GFP_KERNEL,
> -            ) as *mut u8
> -        }
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
>      }
> =20
>      unsafe fn alloc_zeroed(&self, layout: Layout) -> *mut u8 {
> +        // SAFETY: `ptr::null_mut()` is null and `layout` has a non-zero=
 size by the function safety
> +        // requirement.
>          unsafe {
> -            bindings::krealloc(
> -                core::ptr::null(),
> -                layout.size(),
> +            self.krealloc_with_flags(
> +                ptr::null_mut(),
> +                layout,
>                  bindings::GFP_KERNEL | bindings::__GFP_ZERO,
> -            ) as *mut u8
> +            )
>          }
>      }
>  }
>=20
>=20
> Regards,
> Boqun
>=20
> > Signed-off-by: Bj=C3=B6rn Roy Baron <bjorn3_gh@protonmail.com>
> > ---
> >  rust/kernel/allocator.rs | 20 ++++++++++++++++++++
> >  1 file changed, 20 insertions(+)
> >=20
> > diff --git a/rust/kernel/allocator.rs b/rust/kernel/allocator.rs
> > index 397a3dd57a9b..e0a27b1326b5 100644
> > --- a/rust/kernel/allocator.rs
> > +++ b/rust/kernel/allocator.rs
> > @@ -21,6 +21,26 @@ unsafe fn dealloc(&self, ptr: *mut u8, _layout: Layo=
ut) {
> >              bindings::kfree(ptr as *const core::ffi::c_void);
> >          }
> >      }
> > +
> > +    unsafe fn realloc(&self, ptr: *mut u8, _layout: Layout, new_size: =
usize) -> *mut u8 {
> > +        unsafe {
> > +            bindings::krealloc(
> > +                ptr as *const core::ffi::c_void,
> > +                new_size,
> > +                bindings::GFP_KERNEL,
> > +            ) as *mut u8
> > +        }
> > +    }
> > +
> > +    unsafe fn alloc_zeroed(&self, layout: Layout) -> *mut u8 {
> > +        unsafe {
> > +            bindings::krealloc(
> > +                core::ptr::null(),
> > +                layout.size(),
> > +                bindings::GFP_KERNEL | bindings::__GFP_ZERO,
> > +            ) as *mut u8
> > +        }
> > +    }
> >  }
> > =20
> >  #[global_allocator]
> >=20
> > ---
> > base-commit: d2e3115d717197cb2bc020dd1f06b06538474ac3
> > change-id: 20230622-global_alloc_methods-abf5b5e38dba
> >=20
> > Best regards,
> > --=20
> > Bj=C3=B6rn Roy Baron <bjorn3_gh@protonmail.com>
> >  =20

