Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B164467E7B3
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 15:05:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234083AbjA0OFf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 09:05:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235137AbjA0OFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 09:05:19 -0500
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2092.outbound.protection.outlook.com [40.107.8.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6491140ED;
        Fri, 27 Jan 2023 06:04:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ed1sW2pA+FdujaC13dng+/aGvDEe47PtQ2lEdOHraqd4Aqq7htOLZ8v77CmQy5CTrXZLRsg+SMnJ/kf4hmz02S1grB98bksTcJuS/2oy+n56WNHIyxqgQI49OsxqCS/N2a1wEPXL8J2szJXpL+4rVPhUR7Jae3m+n56kzxm1qKUnPwHLnknHAqgFrkvb4Xqhpd8WVcvJrKmsyz0b5aVKe2dtSPrEwL6tT3iCUAalpBYvWAhYKm91zR2boTqMcLXWpO6c7uUgflmfntXjGdgwCrlcukrpnRE1Gw85HRVpAc9RPKL0ElKMTQgGvji+BHAlrowXTh03j1DaWCSUDU+12A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7MTGvKyNY5dt6bK2QjGiEIzO5SFNzH8deTCu7XeE8Ek=;
 b=eiSBCr48/TElRfKuFerF8+9Ig5iMWovJGv78w4/p6UzD5ZqbYiYcgapNSy5pjVqTKhgMtyoQSnvnw+eNil7ekeGIlUgu1YMVGd5DVh++DN/gOeuQGWdwyFk3yWoHEBfqaV2mzUa+5MIpZBWXe+PuR9VBsJ4V501cRFIdbOp96dtXkTGwL5mK3N0B3KuDDVr+gAgsATTo+/vFmPHACEZqXipI3s65GAqY0vbf2AnuTcFemWLQZR/dEYeGMBGM+2Y8eYaF7LLRPi/Ptp4+imsOKzthUF/0lzzLT+LoYc5IHQvkIIriWLuQnESgyym6p00CF3YkP5HXdM4WnSBtdPjW6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7MTGvKyNY5dt6bK2QjGiEIzO5SFNzH8deTCu7XeE8Ek=;
 b=DHIbvoTYUmeqJKk5QDiiw4T96xI5ABAWELc+7wgGjivqKxh3//WB3AwjUnxF87pTF9tVObYNVCxUdPjc47PbocZDvHt+vzwhJLhnYlQoinJIHCjmpfuchCi3Hzn9NCADlQABN2u/hqLD8X85UjdATWCvdCIr7EPPc7jgZoTVVfg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by CWLP265MB6754.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1e8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.22; Fri, 27 Jan
 2023 14:04:18 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::b96e:93ad:4043:6145]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::b96e:93ad:4043:6145%9]) with mapi id 15.20.6043.023; Fri, 27 Jan 2023
 14:04:18 +0000
Date:   Fri, 27 Jan 2023 14:04:16 +0000
From:   Gary Guo <gary@garyguo.net>
To:     Wedson Almeida Filho <wedsonaf@gmail.com>
Cc:     rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        =?UTF-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] rust: types: implement `ForeignOwnable` for
 `Arc<T>`
Message-ID: <20230127140416.2542ce0a.gary@garyguo.net>
In-Reply-To: <20230119174036.64046-5-wedsonaf@gmail.com>
References: <20230119174036.64046-1-wedsonaf@gmail.com>
        <20230119174036.64046-5-wedsonaf@gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0395.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18f::22) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|CWLP265MB6754:EE_
X-MS-Office365-Filtering-Correlation-Id: e363702d-f751-42a7-d59b-08db006f6188
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ygZ31K1U0nLjIBJz9pC1vo9SAHznduoMzC4ikUokwO83C9Od2ABeUIyrcIaFaMOFvwuQ6d9jtEZM0HcmORn5dQa8p7oHlBX4eCw9MbcgRLViIIFz0JehKFJ/skEjT5I+Cl7W7F6shJbAz1mnrDNr9CRM8Ex3uu+KUzUwp4racYQgqKq6CyGy/26MSJeCj2WjomzkRUJNPLMmpTxdRumydm4Gg/ucSYGhEvdjbHVNuBVc+3klJWY+alJN32v/KRwEq5XVl/sHO9rJRX8EPwL8hdZQXIBhIL/p0+EGGBIA+hU7f6FRPS6R/oDO/VEdzNUtDzx2n+frBA7xEp8KtB+p53ta5GP/gpFGPxWeGL3uwtg8+jxDbTI3DYkiGwZBcv87/+mtNaepo93gq3Et6hcMTkY5QmWhrnMibkxRyu5qIZvm28Ah9/8VXLQ8DTXEud85dzjpXXZUszdAfTcC2OoYNAEdA14HgO50pDYLS4kEMWK5NftrsIW1LYoLzP8xgB6TTlWx+WiBVcfWcxq+ShrCSBx98AqbucJYISiVeLJBfxwOfYcWTfCwQHo8pb1pJGLsd4VNy685Rng7Agb42QJxRCiUiabyXFV5Ldb8UQr+j2leN2H8Yqcmj3d2/2WSK+umHfMnhgw5aO+MAfsTfduUO2w9muMJyq1OHCJQzYswvoRUxVN0e9EDlwkb7aueyVAiEH1VVBtHtPRQ55a+8Jv8rWg705lr4z5EGNk38/0Vm6U=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(39830400003)(376002)(346002)(396003)(136003)(366004)(451199018)(1076003)(316002)(54906003)(38100700002)(41300700001)(8676002)(66476007)(36756003)(6916009)(8936002)(5660300002)(66946007)(66556008)(86362001)(4326008)(2906002)(6506007)(26005)(478600001)(6512007)(186003)(966005)(6486002)(83380400001)(2616005)(81973001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1S2aujHL6KjOq2ZWV91RuHg42TIlnElnhvzLAMf3xu0Q6fCJf5UgTff5DtQn?=
 =?us-ascii?Q?z5DvZDp73O6ayMZ2GrJv1XyVYhqnq1cKUMk/CwYtZM2s43j8OIUoz4Gy6YXQ?=
 =?us-ascii?Q?fwEIGEknYTPnBw9g7r/rTLko8o+3/iHWsTpAHM2h8m1vaUqx5+m83CKZJAzU?=
 =?us-ascii?Q?PwIQ/SnvZd0anyvg7U2DV4NB9t2ukuLd+S9/owF4S5eQ/2uAVqDDI6eySYTM?=
 =?us-ascii?Q?dNxC1Bafely6CG3nxDHlHWhfgUuukmtTR/SCcc6QcE0bXljuSXRxR1FakDDk?=
 =?us-ascii?Q?hH2brCCgC1Ht7Xg0jkee8XVywKlgmpz/sbHeaKFliRcglcUgu2s3JT5C+ILU?=
 =?us-ascii?Q?MfUXGIaQlk53/EJa3jjZLGLwKl63COSDsRT+GKm6YHBw6zz9vW9xpD6GSYBk?=
 =?us-ascii?Q?8wAyEunnD30HUozOqb99YnB7z8xCDTzkjW+yOin2gwn6e0JJXwX232VpLRpz?=
 =?us-ascii?Q?1bdsc6W6ZUPZiXIpGFsSX7QP7tCXfgbyKGNDNeqYAhHyiq/q3Ojito8bbT7t?=
 =?us-ascii?Q?6++hBuAMjKSE2AxboqLPUKnGX01zkb8+lXs/EGYFwirAGMj6vcKJN6u9a8gs?=
 =?us-ascii?Q?GOQVfR0Oouv3MLV/9WT3d5vOkKm27/YLreeU/kcg6kp2/5cwlHBmxJSM072P?=
 =?us-ascii?Q?OvRpLpwDLNTrLZ+g4/k4KKIUk0iyc7R9FD8jL0JJiQe9N4D5JCSl4bScFosy?=
 =?us-ascii?Q?YUkpfmVqHQ2C4ZjEeu3Veglefb8a2cwqiAMJNNtHn4ZEcj0fzRWHz/1fm9DD?=
 =?us-ascii?Q?W++nYQ5cD7FwQB3mKkGXjzvY44PkIUZ8I7AdyfYkf/LvsAoxZ2j3fINuhnhv?=
 =?us-ascii?Q?QYdO2taFo02hckLZkIzqvPuWiZG4WBWj4FFwK5h2kIy02YPcMT7mZ0a8/Gaj?=
 =?us-ascii?Q?ztheT3W0lLdF9czFFD2Rzi6thC/AFO8n8CrxGWkYSvJWh3Qe5iPAcA0ZwuxF?=
 =?us-ascii?Q?yITCYTd0TuBzOtgWnyWSV8N5q3E4G1V//yTPFGhrMGFOM5IzyBWfmIaEqV/o?=
 =?us-ascii?Q?IFZl59t4wcXGtUXHTZSuvbK+x6eIawwYYXKc7pcoYmK7PKEhPZh6JNAP0ZTU?=
 =?us-ascii?Q?FPwx9EITeqJ9xP/IAoW198eTXxiWHunMzst2iYX9CBoXfxGyvDi8rcGukMKv?=
 =?us-ascii?Q?T4UTGvdqR3PbSU2u/AYaQVCP1I2n6eL67eHoXiWRb7q6dNw/5Q8FP4sgcxNx?=
 =?us-ascii?Q?7yfppckEnLK6I4N+JeWe5274nnRapsulG4iWY9Er5jfRDOORBPvzwwryTkzS?=
 =?us-ascii?Q?uQVw856Njn9HbtUA10xY+knaOk4lGakp8CR+I5AzSoN8O4d90RRKaozVAEZ+?=
 =?us-ascii?Q?R4YkaGJlJzA/HeyQk6rr2Uw3TjNbOBRC/Wg3erGJkCThrz4MV16I2Ji3vBE7?=
 =?us-ascii?Q?Ape4anrcuojNypBjKNzRXUIn5mFUVtROt0kP7zg3HAG4dLCX+8DWIrwl32GS?=
 =?us-ascii?Q?xza1oNLMMedqq9lfS+fxKv+h+jGd22ePXmscZBtG7NqKx/nwxzIwkX5KXcsx?=
 =?us-ascii?Q?7gBHBW8BaEebX9NCf95pwSJ+bMzQJF74jN/BscpfeD4tGoi+ztbAv13GXD6q?=
 =?us-ascii?Q?n9SyL9fIt+wo05bKuInwZfZ8HG3HaDpZzFQQG45S?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: e363702d-f751-42a7-d59b-08db006f6188
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2023 14:04:18.1890
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KpDrssPu0AjcTuvPWGvRwpGWYhEbq69nli6FnjlX6MG2bk/BbJMaBdecDrgkgHhIw/ardg3Gw1VUwLP3MZhH1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB6754
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Jan 2023 14:40:36 -0300
Wedson Almeida Filho <wedsonaf@gmail.com> wrote:

> This allows us to hand ownership of Rust ref-counted objects to
> the C side of the kernel.
> 
> Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  rust/kernel/sync/arc.rs | 32 +++++++++++++++++++++++++++++++-
>  1 file changed, 31 insertions(+), 1 deletion(-)
> 
> diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
> index ff73f9240ca1..519a6ec43644 100644
> --- a/rust/kernel/sync/arc.rs
> +++ b/rust/kernel/sync/arc.rs
> @@ -15,7 +15,11 @@
>  //!
>  //! [`Arc`]: https://doc.rust-lang.org/std/sync/struct.Arc.html
>  
> -use crate::{bindings, error::Result, types::Opaque};
> +use crate::{
> +    bindings,
> +    error::Result,
> +    types::{ForeignOwnable, Opaque},
> +};
>  use alloc::boxed::Box;
>  use core::{
>      marker::{PhantomData, Unsize},
> @@ -189,6 +193,32 @@ impl<T: ?Sized> Arc<T> {
>      }
>  }
>  
> +impl<T: 'static> ForeignOwnable for Arc<T> {
> +    type Borrowed<'a> = ArcBorrow<'a, T>;
> +
> +    fn into_foreign(self) -> *const core::ffi::c_void {
> +        ManuallyDrop::new(self).ptr.as_ptr() as _
> +    }
> +
> +    unsafe fn borrow<'a>(ptr: *const core::ffi::c_void) -> ArcBorrow<'a, T> {
> +        // SAFETY: By the safety requirement of this function, we know that `ptr` came from
> +        // a previous call to `Arc::into_foreign`.
> +        let inner = NonNull::new(ptr as *mut ArcInner<T>).unwrap();
> +
> +        // SAFETY: The safety requirements of `from_foreign` ensure that the object remains alive
> +        // for the lifetime of the returned value. Additionally, the safety requirements of
> +        // `ForeignOwnable::borrow_mut` ensure that no new mutable references are created.
> +        unsafe { ArcBorrow::new(inner) }
> +    }
> +
> +    unsafe fn from_foreign(ptr: *const core::ffi::c_void) -> Self {
> +        // SAFETY: By the safety requirement of this function, we know that `ptr` came from
> +        // a previous call to `Arc::into_foreign`, which owned guarantees that `ptr` is valid and
> +        // owns a reference.
> +        unsafe { Self::from_inner(NonNull::new(ptr as _).unwrap()) }
> +    }
> +}
> +
>  impl<T: ?Sized> Deref for Arc<T> {
>      type Target = T;
>  

