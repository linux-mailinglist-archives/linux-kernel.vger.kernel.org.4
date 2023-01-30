Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A78676819A2
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 19:49:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237290AbjA3Sto (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 13:49:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230340AbjA3Stm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 13:49:42 -0500
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2137.outbound.protection.outlook.com [40.107.8.137])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C532B8697;
        Mon, 30 Jan 2023 10:49:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BVkRNS9M6EsCtUJevlttwQlO8scwK8hQrEGXrPer+Dx3SvMcjaJ1OjMJzZVnt3O+ssB5rzdo0/3kvZIy9vDpV6YF5RrwxZtxNIf5AsUYoZ1hDdi3GMotBmgiWvHQgbdmee3QLFZ565DnvN1msK70oEmyHlcKOk1qTOFMhfm5+xHTEGk9Wqo3j+jlk3bSuLKS/cj8JV+8bfYJ3i1XxwaOxu/hC7H5RPql1GheNX2k0SkfjhiuYSEXJzv6RJpLZeb8tWOA/M9zSy5pJopxh0aZkhjZ7JPfxS4gwbzzmlyKbaokkuNI5csaD4kPjGJF/A8R17RtA6tNdyui98bDeZDPwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+q7B6+4Cavvq1Dz/KG19sgC6ZRkvRZ0mn+A3cz+lqzs=;
 b=BIUCZs4nf9KDki9AQ/GDzg5O7Fh/9ryJ5r2fumYAPMUCWChxASPMLdTiMKSbQspzNo2ds3qnqLH4I07NyqWsvuQqqpE7VDMKkYcHq3dYhIunkluyP8olL8uiFttirI8sX4BdVGrdg2uIuClz0Qq523mmkOz9Tk74+2tx6Uew35UQ6XMKlk3kzRzFxXMi92ixqqn2ddZjSK7XY/B1yh1J/MYzv1bPTRW9jFkTbOhBinaoDD5E4b1PHus74YoMUejzLkNnoLi+CBm+XGHnjFLGnHvjtFtY7Vggf97RtRJa2cztwlTcVjQbXFU965aAHgpIdDT2W8OYlW/sWHqHvjs3SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+q7B6+4Cavvq1Dz/KG19sgC6ZRkvRZ0mn+A3cz+lqzs=;
 b=NAQpRGg/OW7M/DCLXMuwa/63lQHG58f2LcFUO7sktneWmkVoDDAILTmfiFfDLizs7Wx1r2ls6IpKTmw1N8hc5QDu7iaLniJG5qmeGbik/xE4QA0W/ktcE8FY9ot+Q2PbFw0auzQHIwxUZNAkEh1HhdNmBb/RZWltnF8SUj8/uo0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by CWLP265MB6050.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1d3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36; Mon, 30 Jan
 2023 18:49:38 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::b96e:93ad:4043:6145]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::b96e:93ad:4043:6145%9]) with mapi id 15.20.6043.036; Mon, 30 Jan 2023
 18:49:38 +0000
Date:   Mon, 30 Jan 2023 18:49:37 +0000
From:   Gary Guo <gary@garyguo.net>
To:     Wedson Almeida Filho <wedsonaf@gmail.com>
Cc:     rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        =?UTF-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
        linux-kernel@vger.kernel.org,
        Vincenzo Palazzo <vincenzopalazzodev@gmail.com>,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Subject: Re: [PATCH v2 2/5] rust: types: introduce `ForeignOwnable`
Message-ID: <20230130184937.13dd037e.gary@garyguo.net>
In-Reply-To: <20230130064404.744600-2-wedsonaf@gmail.com>
References: <20230130064404.744600-1-wedsonaf@gmail.com>
        <20230130064404.744600-2-wedsonaf@gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0622.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:294::7) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|CWLP265MB6050:EE_
X-MS-Office365-Filtering-Correlation-Id: f15bdea0-4f29-4560-3547-08db02f2bd59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RusPp9NIxlkePgAtnUqgo1MJZ0fb1B88kOF/f8PhnQyAyOTbialbIn43TvIO2qerwS4DLLxi5gzYjwVYY1RqDgx9votjhiqS5H37FPObIRCFzsE26vRTh07AItNtIkB8ujeMevPf56VaKCFjLnsNi4e9KuH08jhUclZYvgp1RQOHkWfmUZhyFfOUgrbbechIW28cSuDIx9z6TlraMjKwqci9GnwmU0z5jGYjBIFpBZXkz+2cbLpUnYlDvBnvdi6Hb63T4QQY5TPoBo2YogqAhC5oXDGPyT727udg0t67OeMZ7O2I2A3wrakXtI16kMIkkPmItNz3sw8z6UolUdFrAtSKbaUfNJQp/icdm3KDcSe+QQVJx+zOGzWUhrVETf3lPp7C/FmfDA8GzQlgh7Czij1wR2N9j0+VnsXiqhbpzmXnW6GjdxLV1Y/mjjcQrNz1wduvNjlHKswVh1EIiJJU43qOVTP9n2/MdDc5gMRE2hVfbTN9lvChycMJFIL+ytfi3yQRBDp9Y6TSddaE8Fn4fwVa+HcJFxZltqbKtK4MAXRmsGtwNEbnjlEhKhvGCEpXHyMhlKfpV1B2W1yC3cU0lo+i5RMOhsrKVCS5kE4Rkk3yxE8xcWGDdjAuRQePaKcmBAh6z2lMNRN6LZiaXCBOFjiN4HTwydtSPTVTsq0Jxeb3H3Ix9JMbMd6f4l5XJSKnsD2+kfEJNAJ69TFacs3UXoUFU4O0xgLORlZKSCW6zsc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(39830400003)(136003)(376002)(346002)(366004)(396003)(451199018)(36756003)(54906003)(66946007)(66476007)(8676002)(66556008)(4326008)(6916009)(8936002)(316002)(5660300002)(38100700002)(86362001)(26005)(6506007)(186003)(6512007)(1076003)(2906002)(6486002)(478600001)(41300700001)(83380400001)(2616005)(81973001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0KYBIzwqkoC5i8vr12byJ2JQhTU9dQh8cuNmIxCk/LQtGSYdapoO/0EDYrpZ?=
 =?us-ascii?Q?/a8EaPN9MsFsjP8co+WadiNXMw8rbptfZZeZTldUNid+fxdGVliL/NBXhI4Z?=
 =?us-ascii?Q?uNSZ8ia5eWwuAI+Iz2yMfKyXi32HZ0hV9wr2MvUe+iCdQYRqXv/d4gbhczrZ?=
 =?us-ascii?Q?QYDJj9OSkberjkj21QH9/VnGZ+hMG1v2kAr6xlpB//I6F0PJfcbwsai3Bn7L?=
 =?us-ascii?Q?NhIvnWK5/tbn838DUedJ8oNjLO+X+M4d+w9JFydtx/cfN3rjmhJwW0qat8rg?=
 =?us-ascii?Q?LIpPTqyd0FeyumOZY4ArOna7OAHPnQcyKafHAioE0RaKb0N0sX80pbCy8fVf?=
 =?us-ascii?Q?+9JBVSNeBmYGQcmPcvqW0mk1NPmyq/0PSfeymVQmfJrBG+rnJ4PTR4LBTemm?=
 =?us-ascii?Q?xB5GIf0PZ6EsqQKM0dGeYbpfo+ZToRwKtmVwlXQKonEe8JF/FVD7SgHnWTCa?=
 =?us-ascii?Q?xWJlFu+dqBdELekoYSuaEDmimzkqJzjscUIXWcTsk+hhCTf6G64+vE+O53ry?=
 =?us-ascii?Q?JRyXDe4KUit0mb8/PpQlRxxI5sGh15rinHYfM9kmABkt9YVAKAG79e2LkEMq?=
 =?us-ascii?Q?/fPSkke66AEmVw2Ox8qy1EI7fDZPSdGDnCi5K6EOHD5WDs/lGh4WmBzwtqzx?=
 =?us-ascii?Q?V/p93IRhBxNndJlzkfbgBvK8LkzoDaOq4ppoVkvVm8YjuUyDUykyZKuze0eG?=
 =?us-ascii?Q?gY2vn5IDya3c6yEp4OSBST/B4jFq8Oi3rC0da5vVUlOmotvWdQQ+skMXksWj?=
 =?us-ascii?Q?rgEwxzkuyW8FPlxPxFvw/XFTtjc2Ra8jYgy1ibbqH2p46nC7Wif+kK/65TRn?=
 =?us-ascii?Q?vRfkv3G7Nvt3Wue/FhFvRgpXmbiUqrYZ8IDAcrj1eWcs+vc+dpdRwSihV2S+?=
 =?us-ascii?Q?78GQbMYEHTekTmfxXMClss5aE3N4jfKuQ0cPy1oDJZb4shWLLcVCFIeIwMSu?=
 =?us-ascii?Q?Ba5CCfAZCqfDPPLvt8o7zR8Nma9fqHJk9ueK+sdcv6WK+WnHkIem0f4W1w7z?=
 =?us-ascii?Q?XFuErV/z/TpiCNx+CuolPVkmyWVGi0DMCRwww3QgaJTN/C3qQe9DDdNMes5u?=
 =?us-ascii?Q?MgIIYwaf17hpbCcy2m9yP7tyZWGoaJ5OJzgoNS6B8IDIBMzJFKXrRgZFlV3u?=
 =?us-ascii?Q?5WvvAq0oj9BUxP83ToVqd+qMCDX+vItoOPd6F7QEn0/6scw7X6085ELsM8Ts?=
 =?us-ascii?Q?DQ1AhfW/mI4d+3qKzy5xCgHE/h9q0ZMcJdv+78gOcZgWEtTY3SYhS2QVOpMw?=
 =?us-ascii?Q?BgcIZMCFDc/VlgIzGfI82vD91LJgu++5THcDX96rUwx/eY8D79RLmTcK3FgC?=
 =?us-ascii?Q?00aizvc7cINPRGXRKUXBDvkm1enQwBoy4LfC3ylQVrWe50SmXZPaVLMJXku2?=
 =?us-ascii?Q?HfnV9wVZc4hmS2YHIkyZuc8pVzJM4XblEPFfWnMRVdDZec46+pSGaQXgkut3?=
 =?us-ascii?Q?OvXztT9UqjqnLG7zyAVT4vcQ7lBL1wbf0OfxNEGqyFiXpqcn2BcT3z7iw1iQ?=
 =?us-ascii?Q?GPtgYCKKbanR/U0HJkXaCzukFhK5fkDnCr/fKeITcXio0OmerckX8uYFJIUC?=
 =?us-ascii?Q?PJIuuWwiAMUtARPE+TXzH96ff6iY1HY3pYGYMzUd?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: f15bdea0-4f29-4560-3547-08db02f2bd59
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2023 18:49:38.6544
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iTyIRnz9MZr7M2IpixsUBbo/ZTIlLGVg0Jxzdri/0XLGqls5qiuUZhg1XaDphB0kBVaYWk0LI21DQ+mSwQoDMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB6050
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Jan 2023 03:44:01 -0300
Wedson Almeida Filho <wedsonaf@gmail.com> wrote:

> It was originally called `PointerWrapper`. It is used to convert
> a Rust object to a pointer representation (void *) that can be
> stored on the C side, used, and eventually returned to Rust.
> 
> Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> Reviewed-by: Vincenzo Palazzo <vincenzopalazzodev@gmail.com>
> Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
> v1 -> v2: Use `Self` instead of generic type in `borrow_mut`
> 
>  rust/kernel/lib.rs   |  1 +
>  rust/kernel/types.rs | 54 ++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 55 insertions(+)
> 
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index e0b0e953907d..223564f9f0cc 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -16,6 +16,7 @@
>  #![feature(coerce_unsized)]
>  #![feature(core_ffi_c)]
>  #![feature(dispatch_from_dyn)]
> +#![feature(generic_associated_types)]
>  #![feature(receiver_trait)]
>  #![feature(unsize)]
>  
> diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
> index dd834bfcb57b..72710b7442a3 100644
> --- a/rust/kernel/types.rs
> +++ b/rust/kernel/types.rs
> @@ -8,6 +8,60 @@ use core::{
>      ops::{Deref, DerefMut},
>  };
>  
> +/// Used to transfer ownership to and from foreign (non-Rust) languages.
> +///
> +/// Ownership is transferred from Rust to a foreign language by calling [`Self::into_foreign`] and
> +/// later may be transferred back to Rust by calling [`Self::from_foreign`].
> +///
> +/// This trait is meant to be used in cases when Rust objects are stored in C objects and
> +/// eventually "freed" back to Rust.
> +pub trait ForeignOwnable: Sized {
> +    /// Type of values borrowed between calls to [`ForeignOwnable::into_foreign`] and
> +    /// [`ForeignOwnable::from_foreign`].
> +    type Borrowed<'a>;
> +
> +    /// Converts a Rust-owned object to a foreign-owned one.
> +    ///
> +    /// The foreign representation is a pointer to void.
> +    fn into_foreign(self) -> *const core::ffi::c_void;
> +
> +    /// Borrows a foreign-owned object.
> +    ///
> +    /// # Safety
> +    ///
> +    /// `ptr` must have been returned by a previous call to [`ForeignOwnable::into_foreign`] for
> +    /// which a previous matching [`ForeignOwnable::from_foreign`] hasn't been called yet.
> +    /// Additionally, all instances (if any) of values returned by [`ForeignOwnable::borrow_mut`]
> +    /// for this object must have been dropped.
> +    unsafe fn borrow<'a>(ptr: *const core::ffi::c_void) -> Self::Borrowed<'a>;
> +
> +    /// Mutably borrows a foreign-owned object.
> +    ///
> +    /// # Safety
> +    ///
> +    /// `ptr` must have been returned by a previous call to [`ForeignOwnable::into_foreign`] for
> +    /// which a previous matching [`ForeignOwnable::from_foreign`] hasn't been called yet.
> +    /// Additionally, all instances (if any) of values returned by [`ForeignOwnable::borrow`] and
> +    /// [`ForeignOwnable::borrow_mut`] for this object must have been dropped.
> +    unsafe fn borrow_mut(ptr: *const core::ffi::c_void) -> ScopeGuard<Self, fn(Self)> {
> +        // SAFETY: The safety requirements ensure that `ptr` came from a previous call to
> +        // `into_foreign`.
> +        ScopeGuard::new_with_data(unsafe { Self::from_foreign(ptr) }, |d| {
> +            d.into_foreign();
> +        })
> +    }
> +
> +    /// Converts a foreign-owned object back to a Rust-owned one.
> +    ///
> +    /// # Safety
> +    ///
> +    /// `ptr` must have been returned by a previous call to [`ForeignOwnable::into_foreign`] for
> +    /// which a previous matching [`ForeignOwnable::from_foreign`] hasn't been called yet.
> +    /// Additionally, all instances (if any) of values returned by [`ForeignOwnable::borrow`] and
> +    /// [`ForeignOwnable::borrow_mut`] for this object must have been dropped.
> +    unsafe fn from_foreign(ptr: *const core::ffi::c_void) -> Self;
> +}
> +
>  /// Runs a cleanup function/closure when dropped.
>  ///
>  /// The [`ScopeGuard::dismiss`] function prevents the cleanup function from running.

