Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 601A272EBF4
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 21:28:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230223AbjFMT1O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 15:27:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjFMT1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 15:27:11 -0400
Received: from GBR01-CWL-obe.outbound.protection.outlook.com (mail-cwlgbr01on2090.outbound.protection.outlook.com [40.107.11.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E41C6E6F;
        Tue, 13 Jun 2023 12:27:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hn9TQbO57CHmfn04gc5/xWdnS6xQvoX3lKl+kiJ2GnDkpq5HmhWcWRPDWErecsJ6QulvkL5efMXDo5H7eFoGvlBASn+InNjJMtHxNVREQ6r6g5vDkUoQrY94pD8ysmjp5rR2hiFDeWKpSHK95FvDxYePlDiK2zhBScPyMa/3AyZoVHgriPPGBnukPGzJYBoI1MkyPTyVhHDwBKnshuF4xnY5pJyWbQgME4cRdASn8KKupNm8d9kJqB8p6njS3bHMNxKHXeAxbRn5Sj6YEuL9g6b9rlX/sj/T6NA7U2ads5jsAwEHDapZ5GiI2wP3ZdS5oxhkNuvSb/tf+kAjGKjFWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4bQlsf6RL4rbZaE9Sv3N2HdZW759fa9C6QoollQ+xCU=;
 b=BAjn8qq3xyjUOcCU99gmBqXS7qdxjUV/nfCIKRBwttjyoPHbgNGlkznrrHerkZ4EeEUIcrnC9+olnNnNIJ6HE5zKS2FSaNwvxeZvXYxl4j0DQcabdO9DjAQvRPKMtglY5l/d6ztZDkHOgDm8veGaR/mUEljxwsUpDLGpkmKTyzisiPFYPz2QBl7McY6wwAsCe32LNsQ86oQb5BjV+7y38hDykEmb9n+9a0cNbxuf2ChoQU3naOhY+CdYrsVTP9vCrL8cauE1/aokHkGwoDgUYdYFRSF3QJPDnzgNm5Zqy1jiq5LNDnaNj8LSYCwudqGtqyV3IFYVJyjFcvE483c4Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4bQlsf6RL4rbZaE9Sv3N2HdZW759fa9C6QoollQ+xCU=;
 b=Nf/xeMXjpHethGatPjJ7rf2u34s7HALSSrXH41jZgiKYlEGnYgIP83+Q+l1MjHOF25SSCFnNtxcxOAV27IYwuiTfdFBpNW8oW0e8tPru3+q3GMQNp7j6UBtBT+sUTU0tKPjOuvSQu9o+Qh6GzPNit/wb52eWRKmNBydx/O5MFoc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LO4P265MB6700.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:2f2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.21; Tue, 13 Jun
 2023 19:27:04 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f968:901e:1398:7d22]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f968:901e:1398:7d22%4]) with mapi id 15.20.6500.020; Tue, 13 Jun 2023
 19:27:04 +0000
Date:   Tue, 13 Jun 2023 20:27:02 +0100
From:   Gary Guo <gary@garyguo.net>
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        =?UTF-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
        Alice Ryhl <aliceryhl@google.com>,
        Dariusz Sosnowski <dsosnowski@dsosnowski.pl>,
        Geoffrey Thomas <geofft@ldpreload.com>,
        Fox Chen <foxhlchen@gmail.com>,
        John Baublitz <john.m.baublitz@gmail.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Andreas Hindborg <nmi@metaspace.dk>, stable@vger.kernel.org
Subject: Re: [PATCH] rust: allocator: Prevents mis-aligned allocation
Message-ID: <20230613202702.56f321ab.gary@garyguo.net>
In-Reply-To: <20230613164258.3831917-1-boqun.feng@gmail.com>
References: <20230613164258.3831917-1-boqun.feng@gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0215.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a5::22) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LO4P265MB6700:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a9a731f-e5d6-4876-d5b8-08db6c442b2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dye1vyA5h+/lgzrI0ctA+o6wOg0tf8En0yElW68KElDe1/+GfIJGfve9alBsWgDn8R3yVEBms69zaeThtAMz+R/CJvibFMaV/JEtXQrAQt17W0zeLz4Sw6V+pl9Pygb+9zSxfopKUKWgTuTBlTU/9up2yNFfRRq82FqpFqE38uccihTmZf+owXw5VVtZOZZy7rcSr+6ZdfzK1pzqG+uDZaJs06DNZ2buMzVwc5cMc52gtfYVBm4cHDS/VIE5b2Tgm183FTjrrVUdTDnQOHTahLMakCAcnf7TUtCFP78VkRx78itJYKeF2AjVWIhiNKnNmLIJlogeVHcXAQWpaUZkLTJV0K7s1gfA1qxUTGRIShv80MmC3BnFe7uRvP2JQl2M6Mmy+85goFmlzWJn18G6ddA8SVNuO4iB4HJRzQFY0Zi9ZOljIUbiZJtP9uXDr0TOW4j204hg25FLoOIX0hvIJyJr8EwONGRStQwbijzhsFnELpXr36jxqDzCZrr3ukV2Cb0vZvHwz2vf7zTCEwfJu4fbG6K6uRymIrq8Ge86JaA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(376002)(366004)(346002)(39830400003)(451199021)(966005)(6486002)(478600001)(26005)(6512007)(83380400001)(1076003)(6506007)(36756003)(186003)(38100700002)(86362001)(2616005)(4326008)(6916009)(66476007)(66946007)(66556008)(316002)(5660300002)(8936002)(8676002)(7416002)(41300700001)(2906002)(66899021)(54906003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WNgNnF9BLRwkiRtiEd7IlJ7wDPkV7PJcfUxV3Fz66+NPtN/NYHJ+5d04n7kr?=
 =?us-ascii?Q?nxnG0esKRk5YdTk7jqRFtAdjRWC2QW8aKJJT1idAcRftO/bxw3kI7gFtkdfr?=
 =?us-ascii?Q?8L1UI5lDeDlJOj2CLQWDsm1NO+7hUqctWK4xIieFRTTH9Wc0UGptee4HCEL0?=
 =?us-ascii?Q?aVicKIwKngM13QaAvr0SLYGfE8pEy8pGSuGx+t1UUTY592s6iYavQpSPjDxI?=
 =?us-ascii?Q?ZhfNNiQxOFr+LCS2fheC5hbBoldImXkn2gDxLMH2E+ORDmD7W8NAVg4lZ+qA?=
 =?us-ascii?Q?x8FqidPUkVR/SrYvlM9D+264liET5FPaxTAAf5KI+JeOjMbaEWXsziMnkXsn?=
 =?us-ascii?Q?XZW36FkeUS2ZlX1usAk6qWvG4890508bE1HH0ovwhmnojFDsQTaS00SpHfvp?=
 =?us-ascii?Q?/onrVg2ThVelpNZr0pv+m+0u1zg9BhqOr9PuI+Vd/HWTSPcdiWUuszeSPimF?=
 =?us-ascii?Q?Z9+/srCeHRa1khvtFTfGV8FiobtSl4xAA5r04xewk3Kno43Czds1t8EUYwEN?=
 =?us-ascii?Q?f0tw12WB1eId1ixm0PvCH0b1OViFC2YZD+Q4A2A+RLUpFzecUKtOL9U4GNbw?=
 =?us-ascii?Q?Tv4opVRd1gw9fzEyBhZqDtMIdXcti7eb4jb7yIyBC5/Zui1TJBFQne8zN9KN?=
 =?us-ascii?Q?+lMoue4L021Y0xDJ7r4kcz+zCtZP2ng2/NaACaM9bbCwO+WIcnMtW6gHLNHa?=
 =?us-ascii?Q?vdoRgx84ejQl6IuVpLLjcDJkl8gzwLlXj09mTVXzW4VP5ozd1bJF6kzKJ28Q?=
 =?us-ascii?Q?gJroj+y1BkwztRBFbJsw72eU/1bcuQ+PLcaMofTq/QVVBhu2/lMH1ntVgVNV?=
 =?us-ascii?Q?Ttv/hosjFMG3SE3tUrpnkWg503QCBuZ/tbNq7n153Ap/leLUzwyb9UuI+RsU?=
 =?us-ascii?Q?1Py3ywwfI8SFPX+10I5s+yYrc2nToH4TF4c/PRbCSk6MNCm872oJwDhBeamG?=
 =?us-ascii?Q?7LChj1jw5AFMmIxrh4nwRkyWaMfPl8Qe7gd150FBQGYEBCpljBg8UZ8359hX?=
 =?us-ascii?Q?xFRr87Z76Tj8Eg0xhiYewJUGSsVLfPRAGJc+2CFWCRM1lVlhdnbaNVygljPE?=
 =?us-ascii?Q?PoeY2taYENdctzfxyA/O5Fqs9bBOajb3PnRNdSNHhFT8nZ1cnPzQk/PbTZEn?=
 =?us-ascii?Q?eQTmot1qSNWQFWbgccviInpjuB7kw7pOImGgONsaBLnvh4ekeo7ijtnxugoq?=
 =?us-ascii?Q?XR3aTFwM24Ii4n0iVUprju5m/jqN3NGilEJyaHawFmSG45Ys4SbCDdul8X1M?=
 =?us-ascii?Q?WG7h6mzNBoFXfnPeAP+fS4br5fK3WGrHI9gLaS7rwC5rnitvtgkELKCvGQ9H?=
 =?us-ascii?Q?5YZJW9gv87DChn4Jifp6BCSYJz5IcY78HSqXTrl5hHtMGJ8bdqMTOugrZnCh?=
 =?us-ascii?Q?Te3gsd5NMa1T+2C2inSDpfcjSxe0T3j69GcJB+BmI8usmprzU+fybQHigIPf?=
 =?us-ascii?Q?R1icJ9gSz6pLmFkkOkFb2f2Fy+mZ7njZBei/yHRZcZZYm11D6f6VPskZGn8Q?=
 =?us-ascii?Q?ozX4RPvJZYOLYewYHEpWTWvPPocpIOr3FKROyoJNqFCumm94FkL6KE/yxhIz?=
 =?us-ascii?Q?S2B1apjvzlS8p7OT2/GUyNFjQ98Tu8C9WrqhfJA/?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a9a731f-e5d6-4876-d5b8-08db6c442b2f
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 19:27:04.2804
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fKSf5tv6EAIxVu641xAnX9SKgkUqlebXt6Hi+hhvujFCecbAil8XG/QJqevghjnLS3o+Gsfy2KRvxl1/fxf5fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO4P265MB6700
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Jun 2023 09:42:58 -0700
Boqun Feng <boqun.feng@gmail.com> wrote:

> Currently the KernelAllocator simply passes the size of the type Layout
> to krealloc(), and in theory the alignment requirement from the type
> Layout may be larger than the guarantee provided by SLAB, which means
> the allocated object is mis-aligned.
> 
> Fixes this by adjusting the allocation size to the nearest power of two,
> which SLAB always guarantees a size-aligned allocation. And because Rust
> guarantees that original size must be a multiple of alignment and the
> alignment must be a power of two, then the alignment requirement is
> satisfied.
> 
> Suggested-by: Vlastimil Babka <vbabka@suse.cz>
> Co-developed-by: Andreas Hindborg (Samsung) <nmi@metaspace.dk>
> Signed-off-by: Andreas Hindborg (Samsung) <nmi@metaspace.dk>
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> Cc: stable@vger.kernel.org # v6.1+

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
> Some more explanation:
> 
> * Layout is a data structure describing a particular memory layout,
>   conceptionally it has two fields: align and size.
> 
>   * align is guaranteed to be a power of two.
>   * size can be smaller than align (only when the Layout is created via
>     Layout::from_align_size())
>   * After pad_to_align(), the size is guaranteed to be a multiple of
>     align
> 
> For more information, please see: 
> 
> 	https://doc.rust-lang.org/stable/std/alloc/struct.Layout.html
> 
>  rust/bindings/bindings_helper.h |  1 +
>  rust/kernel/allocator.rs        | 17 ++++++++++++++++-
>  2 files changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
> index 3e601ce2548d..6619ce95dd37 100644
> --- a/rust/bindings/bindings_helper.h
> +++ b/rust/bindings/bindings_helper.h
> @@ -15,3 +15,4 @@
>  /* `bindgen` gets confused at certain things. */
>  const gfp_t BINDINGS_GFP_KERNEL = GFP_KERNEL;
>  const gfp_t BINDINGS___GFP_ZERO = __GFP_ZERO;
> +const size_t BINDINGS_ARCH_SLAB_MINALIGN = ARCH_SLAB_MINALIGN;
> diff --git a/rust/kernel/allocator.rs b/rust/kernel/allocator.rs
> index 397a3dd57a9b..66575cf87ce2 100644
> --- a/rust/kernel/allocator.rs
> +++ b/rust/kernel/allocator.rs
> @@ -11,9 +11,24 @@
>  
>  unsafe impl GlobalAlloc for KernelAllocator {
>      unsafe fn alloc(&self, layout: Layout) -> *mut u8 {
> +        // Customized layouts from `Layout::from_size_align()` can have size < align, so pads first.
> +        let layout = layout.pad_to_align();
> +
> +        let mut size = layout.size();
> +
> +        if layout.align() > bindings::BINDINGS_ARCH_SLAB_MINALIGN {
> +            // The alignment requirement exceeds the slab guarantee, then tries to enlarges the size
> +            // to use the "power-of-two" size/alignment guarantee (see comments in kmalloc() for
> +            // more information).
> +            //
> +            // Note that `layout.size()` (after padding) is guaranteed to be muliples of
> +            // `layout.align()`, so `next_power_of_two` gives enough alignment guarantee.
> +            size = size.next_power_of_two();
> +        }
> +
>          // `krealloc()` is used instead of `kmalloc()` because the latter is
>          // an inline function and cannot be bound to as a result.
> -        unsafe { bindings::krealloc(ptr::null(), layout.size(), bindings::GFP_KERNEL) as *mut u8 }
> +        unsafe { bindings::krealloc(ptr::null(), size, bindings::GFP_KERNEL) as *mut u8 }
>      }
>  
>      unsafe fn dealloc(&self, ptr: *mut u8, _layout: Layout) {

