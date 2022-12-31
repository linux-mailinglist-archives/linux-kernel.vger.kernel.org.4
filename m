Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84E8165A656
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Dec 2022 20:40:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235650AbiLaThz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 14:37:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231481AbiLaThw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 14:37:52 -0500
Received: from GBR01-LO2-obe.outbound.protection.outlook.com (mail-lo2gbr01on2119.outbound.protection.outlook.com [40.107.10.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8C342BDF;
        Sat, 31 Dec 2022 11:37:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hXDOG20K6WaUBb3M3rov/rpo/pgsNCGYrQq7orxf1RJWh2wjAghCjb09mMsbNZrNdsYi5xh91MPSlHrhW/zMXeIJWUbMbCcVLR71RofNrmpcARdTsLdjyEnq+MEnI1bhJ7W1Xjjn/hyt3skSoX5pkFDSnMFKVhqsruEYw1fE3BY9EOp4t5wBXkY+od/HfzZL7oEslC1OSGvxgGa3Juy/fsZBE2sp0iiuQfnmlz8nr9fMtg3ni//aPpi1bVXNg1R2iuxKo4v9OhoGXyWkug2GL9iIbv2ECEkP+OtN5tK+K375slm4zRxoAMfLw14thB7ThZLCJDzZCcd2YRMQzFwrUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V4IcAPA6cCR7CCkKYO5fak9SVZ70q30I84sFbuF1NFY=;
 b=BTvz+qG5oaw7S20ZymdOf/0vDjOMaweWA83PPqIclMIHSNLyNl//F96a+Nn9gpfQlS7jiYSL826h4+0a3XEuxLSNbOcQ8B1MCHvkQofz0gc1G78H5qi+sTNfIEep5sT8HCytEjCYKgYYQZfRg2PKCQHv7dhilARhVn3QS2x0YZXMrCiBB0VZFPDsYZIzzdxOrB4tBZ0eQ5JGiK2CeIXSvgWp0kfYd6iXBifV8GMBNx2swoUiSTaCyTaeSwlzazsBHDt3UHbGLEtYQEH82RCCp3oq9cSUGGDlHroiJeGrdzopiNX1GhvWyzEFPgmqq7BCmRojemmj3VKcSFdyf9OLFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V4IcAPA6cCR7CCkKYO5fak9SVZ70q30I84sFbuF1NFY=;
 b=j+/r+vdJbt0x3V0txvwC/cOLQ9yG+XW0zKaJaUYqGAfNX4sGAO5dAOfoOlpTlXHMZ1mEUfJAoYnpyxsfme1/z03WZb9XNbc8dy8xiA6qC3Wi1JOBIJLSmKCbBpIkwUxNwuKodKITylTfjmkoKqgwxDBrEkOc87+/Stbo3Gc5068=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by CWXP265MB1912.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:42::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.18; Sat, 31 Dec
 2022 19:37:49 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::2f24:8099:5588:8ba8]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::2f24:8099:5588:8ba8%8]) with mapi id 15.20.5944.018; Sat, 31 Dec 2022
 19:37:49 +0000
Date:   Sat, 31 Dec 2022 19:37:48 +0000
From:   Gary Guo <gary@garyguo.net>
To:     Wedson Almeida Filho <wedsonaf@gmail.com>
Cc:     rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        =?UTF-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/7] rust: sync: allow coercion from `Arc<T>` to
 `Arc<U>`
Message-ID: <20221231193748.103a99ed.gary@garyguo.net>
In-Reply-To: <20221228060346.352362-3-wedsonaf@gmail.com>
References: <20221228060346.352362-1-wedsonaf@gmail.com>
        <20221228060346.352362-3-wedsonaf@gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO0P123CA0006.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:354::8) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|CWXP265MB1912:EE_
X-MS-Office365-Filtering-Correlation-Id: efc298e7-2de1-404d-2f15-08daeb668034
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5or4+GG373JGSY6gr0mj7kzCIr5fTCJbCeOslc+M2cnSIvb+otwlnoAz5gBrPfjUMe7J2MoGNTqA5gpnPSOEyMwadOhJIOAMCvMWXfVExdyzlX5Fyc85xPw+73O7RRweLTpVnQ+kHyyNvpsm1YkryMzUvrHDGLP92WFdL+XVofy+jd4mBbmVzPhaPIkevSQfRHHMJ7p21A+uNTPgwg5waQUE8u0Vc5/Vp5m+28kSZMjPA+dpmxEamHjW5dcuCVrp5riYSuU1C8UTj1nOsoL+oZgBJU3c5IBNJgxXsHoe829txzynxAKg9qE2AHNw0qMLqrybWG0Z5vZYv6UCMZp34/tBo2eNxj9N3ggInRcSj4DM2VizpuLv4HiXHDhBE7LEqcLiTUIvMyPofWDp9CZwUt4GnUZnDCvPTpZkSC++QJBEL+e8oFuZkZw6ejwgb3RBQNZy50GIFhCs17P45eOcyRIaUVwGPmmK3OwLkEbSzTo5vIxHqKclLMoFzxjjIYdUWEtK+RrME6piwvS24kEM7kV41bH748U+ovQFZMOcv6ViWGJcX0fNv4ibsrh6772Rcb8urQ4sgPg2XPABx+Hw9kr9phMBsUDi6hJw7YjAuRgAIStsxTHk+ZLZNp/mKg41AeafVkmx7aQMswbQ4MHUdd2jEL1dE1K9VDhDgfawXSOx6FWp+kZENHqtY72m0VIH
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(136003)(366004)(39830400003)(346002)(396003)(376002)(451199015)(36756003)(86362001)(54906003)(6916009)(316002)(2906002)(38100700002)(55236004)(186003)(26005)(2616005)(83380400001)(6506007)(6512007)(66556008)(66476007)(1076003)(66946007)(5660300002)(6486002)(478600001)(8936002)(41300700001)(4326008)(8676002)(81973001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?09rJ3Er+Vf3rn56Cs82ZL/n6FvfydikAbEEMyPCV7XrTbSskZMSSKcD23klo?=
 =?us-ascii?Q?FSp1HxRMNSpbSGx73gst8Tp+AJaHGUUNhLQf13T2r8Y+U/upTYRUHHDDUE4G?=
 =?us-ascii?Q?3+g+N57j3TnsQTsAC7GdT+ZzNeBQdfzfJecm+FXfuGOf9Pq3EwIURQynQ1FT?=
 =?us-ascii?Q?CqtLWQjfrvEG7omhR4ILEEHiQtKZjcTvQDC/2X0tYPI23L53LB4TzcnaTEzc?=
 =?us-ascii?Q?p/WUTxyE9z8HqNFmQI1qowKqy/anilPN3+zxiWIKNhcXpfSS1MckqGk4zMTM?=
 =?us-ascii?Q?TxPpNkfb0VNZ/E0Vy1vjnKaLAvyyva9rAtCSyBYQPWXWgZQIcu/xdahhpfh4?=
 =?us-ascii?Q?/b1QxRWTq9Hgb95KVYjwqX1A/0bw5PTN3EWbZ5kImHQa6I1Mt1GBnCP5mIOM?=
 =?us-ascii?Q?gsi5AEs+vYyX2q2RBM8I+NXg+AAifNVT/FqZE233DVsBthYpUVxYexpclWcC?=
 =?us-ascii?Q?XSuWC/y0Vc/pf5j2vfkeWO+0nZ7uDWHKLYTa2ah7HvR7fCezEeDFuYa9vs37?=
 =?us-ascii?Q?ajqJ59qIlL782sdX5B/3lwj0AkUXJAhl822riVIKqeuF5XNaMxPCN7tsuj2r?=
 =?us-ascii?Q?1DxixY060Q2SNHPhUCBSWQw7ZKQkLeonpBQ1EpEwOJNT+Qu2wo5W21DUWWMZ?=
 =?us-ascii?Q?TkfBl2wXCFp0TGHLgGbGkfkRAHRB9GP+tBtFNyzM+zvjpfBVJ25ir4/kwcld?=
 =?us-ascii?Q?cetvzb3s+FLp4P0xGKmJsgOpsaI/WdfkMagq6jvwGbjgT8tADDmZzhl2b4Ol?=
 =?us-ascii?Q?BNr3UREKbucsb4N3o7QcF4qoIlnWsMTKkdm7mpPgjxgviSZeH9rp/WlBbF1F?=
 =?us-ascii?Q?9tkMQwYdc/4SLWAkiu7dPNuYlumN0fpn89Ztk0LQ4fwDcl4i6I+E8cnPO73A?=
 =?us-ascii?Q?bvjpOZqCc6pCW2HML1hRKLBcOUNlZMcPG73+WLNqaYdWVMbaHTrWbIw11J4K?=
 =?us-ascii?Q?NUAePbN33iv7DaEDzjGN4cGnFS9XOPJdcdnm9oa+Z7VcXdV2lNSZDYTEJACM?=
 =?us-ascii?Q?yRzSRWU30Hxfus1sPv3+pIEdRkA9zBsJvdYY9ESJZ5iUFXzPPMoNXvxJKa2I?=
 =?us-ascii?Q?JQFLLM1uiz3mqykZ9GXU+62QD95eMXBtutbGxEVACsmNr3C9syLn0YxeVfEV?=
 =?us-ascii?Q?m/EvQQC92/IjxiA6/zJclre2if5Cc4DfmgPl41o0da4mAR0MBLsRDTfoSWXp?=
 =?us-ascii?Q?+ohEj1bCkOyOYAhqvq/7VFo862sTyipo+aSN9xM8PWRZ7yMBDlRYyUDmUJ+F?=
 =?us-ascii?Q?FWWD7rLq9dirY3pFTbpgWh8n+ZDYUWuOoUFSE++4WEeMm8vPmW+Kx0FgfzD9?=
 =?us-ascii?Q?476OQHWHygp1exHFOTBo+2FcYq6m3h0nkoaqvoJyBW8MMdHBlO+zq6KBOsAy?=
 =?us-ascii?Q?pDr0vukGZ3VNmRiQdsAnG7i56JcZJBb0KZK6EGqVsp4V66KUb7GDm11n7f2W?=
 =?us-ascii?Q?A1Wh6oiCp/d9wFJaMHBKsaCgsOV/Mwl8Lz2bt6W7N9/Eq+aK9+kqTLgAPoz2?=
 =?us-ascii?Q?VZlInbfcG5RHzOJHtSYrHDdt4peTFUAFBd5dhnjpMJDdtAjZV9b+dnjfELKq?=
 =?us-ascii?Q?Xfsgtn4kGsa2nW736aM=3D?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: efc298e7-2de1-404d-2f15-08daeb668034
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Dec 2022 19:37:49.7848
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /AMPSwWJE0NSPnkZLCfim4r7unAff86//BKQ8llWR+iVfq7Bz2nnclT/wn4amM+3rma9hQOxTUxBzgVGt97CMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP265MB1912
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Dec 2022 06:03:42 +0000
Wedson Almeida Filho <wedsonaf@gmail.com> wrote:

> The coercion is only allowed if `U` is a compatible dynamically-sized
> type (DST). For example, if we have some type `X` that implements trait
> `Y`, then this allows `Arc<X>` to be coerced into `Arc<dyn Y>`.
> 
> Suggested-by: Gary Guo <gary@garyguo.net>
> Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  rust/kernel/lib.rs      |  2 ++
>  rust/kernel/sync/arc.rs | 27 ++++++++++++++++++++++++++-
>  2 files changed, 28 insertions(+), 1 deletion(-)
> 
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index 1a10f7c0ddd9..4bde65e7b06b 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -13,8 +13,10 @@
>  
>  #![no_std]
>  #![feature(allocator_api)]
> +#![feature(coerce_unsized)]
>  #![feature(core_ffi_c)]
>  #![feature(receiver_trait)]
> +#![feature(unsize)]
>  
>  // Ensure conditional compilation based on the kernel configuration works;
>  // otherwise we may silently break things like initcall handling.
> diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
> index e2eb0e67d483..dbc7596cc3ce 100644
> --- a/rust/kernel/sync/arc.rs
> +++ b/rust/kernel/sync/arc.rs
> @@ -17,7 +17,11 @@
>  
>  use crate::{bindings, error::Result, types::Opaque};
>  use alloc::boxed::Box;
> -use core::{marker::PhantomData, ops::Deref, ptr::NonNull};
> +use core::{
> +    marker::{PhantomData, Unsize},
> +    ops::Deref,
> +    ptr::NonNull,
> +};
>  
>  /// A reference-counted pointer to an instance of `T`.
>  ///
> @@ -82,6 +86,23 @@ use core::{marker::PhantomData, ops::Deref, ptr::NonNull};
>  /// obj.use_reference();
>  /// obj.take_over();
>  /// ```
> +///
> +/// Coercion from `Arc<Example>` to `Arc<dyn MyTrait>`:
> +///
> +/// ```
> +/// use kernel::sync::Arc;
> +///
> +/// trait MyTrait {}
> +///
> +/// struct Example;
> +/// impl MyTrait for Example {}
> +///
> +/// // `obj` has type `Arc<Example>`.
> +/// let obj: Arc<Example> = Arc::try_new(Example)?;
> +///
> +/// // `coerced` has type `Arc<dyn MyTrait>`.
> +/// let coerced: Arc<dyn MyTrait> = obj;
> +/// ```
>  pub struct Arc<T: ?Sized> {
>      ptr: NonNull<ArcInner<T>>,
>      _p: PhantomData<ArcInner<T>>,
> @@ -96,6 +117,10 @@ struct ArcInner<T: ?Sized> {
>  // This is to allow [`Arc`] (and variants) to be used as the type of `self`.
>  impl<T: ?Sized> core::ops::Receiver for Arc<T> {}
>  
> +// This is to allow coercion from `Arc<T>` to `Arc<U>` if `T` can be converted to the
> +// dynamically-sized type (DST) `U`.
> +impl<T: ?Sized + Unsize<U>, U: ?Sized> core::ops::CoerceUnsized<Arc<U>> for Arc<T> {}
> +
>  // SAFETY: It is safe to send `Arc<T>` to another thread when the underlying `T` is `Sync` because
>  // it effectively means sharing `&T` (which is safe because `T` is `Sync`); additionally, it needs
>  // `T` to be `Send` because any thread that has an `Arc<T>` may ultimately access `T` directly, for

