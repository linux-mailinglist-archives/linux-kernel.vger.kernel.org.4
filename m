Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF8AA65A657
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Dec 2022 20:40:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232181AbiLaTh1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 14:37:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbiLaThY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 14:37:24 -0500
Received: from GBR01-LO2-obe.outbound.protection.outlook.com (mail-lo2gbr01on2098.outbound.protection.outlook.com [40.107.10.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D63222608;
        Sat, 31 Dec 2022 11:37:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hL+1HXkoxZK8ofMDm3posNHDYUCVTMm5+3xa78YgvcW9W9JBMEm67OYH6cQ8iLxvfVizyvcq5YHUnc7oA9ivObqvyhzLAvfEKf83z1fUR0TKPKm6IWyNWt7u0bSQKdfcSX4P6JoURSqfZMvfx8q5Eoox3rOKR/poExb/AocLs+nT7sFe8oMj8I8I4n47q694Xy2vxglD+e9kqVC+ffbHhVlYJRBCb0enPVvYcBjDYac2QZW6uxuHuF7R68bGcD3+jdwAruei2JFRjlmFCy/ZdKdIWHuxspvfDl41d0d2F9XmUnDagwcuhq9A7RsUE/mlbq8ZZEJfrbksMp7da0TEow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Et+XbxyMKkXet50wZmTX/8bAsCW709jUusOXp9eyv1w=;
 b=flnvX8vWq8vzLTI5D0bVilQkj46g1b4tNDpRwIgejkf57FIrlf94PIdP+Pti+7EpKcPGIlqVbhbVpW6lIS9phBHwpuKG0A48W0DIsoEaLKEiya8TxmpLrHqlEPy1HFwBOaUNA1Pdm7zF0ATDLs1ILKVkIA4puG1qRrZzcEFHMw8adgkNbueaWQc+KFdqVTV8ptKFroSGb5aMYGOgOiU5bkw4JuXGs6xekfiOPTnYWAtUzgw0gIo7paHEIczeZXSkC0x3sZ0yQrG1YpfHvvm/YpzLQge0fHKiN+b63DsvY32ewTpBZFsFB0gZ1Zv62PvTj09Wy1Y1meZnkR2unlgWgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Et+XbxyMKkXet50wZmTX/8bAsCW709jUusOXp9eyv1w=;
 b=dbQEwt27JSRjyvpOWwjllTLng69up5oxVOfWiD25sNq4CUtt9YihV0YPHi3xPFKAuWMprszve2wHFAUOCAjYs0m/USj2g3pDmOu9y8EX8N9bBPifPvhbX/cfDR0ocbtAw1ayQ7UfE3TjS84PXX6IHEUVmI0V+k4NvHyAkv5CY2A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by CWLP265MB2580.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:a7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.18; Sat, 31 Dec
 2022 19:37:21 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::2f24:8099:5588:8ba8]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::2f24:8099:5588:8ba8%8]) with mapi id 15.20.5944.018; Sat, 31 Dec 2022
 19:37:21 +0000
Date:   Sat, 31 Dec 2022 19:37:20 +0000
From:   Gary Guo <gary@garyguo.net>
To:     Wedson Almeida Filho <wedsonaf@gmail.com>
Cc:     rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        =?UTF-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/7] rust: sync: allow type of `self` to be `Arc<T>` or
 variants
Message-ID: <20221231193720.4428eb7d.gary@garyguo.net>
In-Reply-To: <20221228060346.352362-2-wedsonaf@gmail.com>
References: <20221228060346.352362-1-wedsonaf@gmail.com>
        <20221228060346.352362-2-wedsonaf@gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO0P123CA0010.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:354::19) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|CWLP265MB2580:EE_
X-MS-Office365-Filtering-Correlation-Id: 7dc85e46-9391-4fed-131a-08daeb666f2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6Ni+74BhGapxGhq8Ij8Ojl8c2Dh4FWstHt0wy6W2b3D66Dm7phK6D/Iai93oyrUJmYxcvx2NFtA+NPKvl8B4nGC2qbBFFzCbkxOj3Rx1H7Mqud0i9a/Oj0Dr9in1X4O7qjxqcjnPHcG3sbf8LIhqi15iZGgWyPGdktkBfDNsHo5fH32wfEfAN6Y2oQ0936dJTniCIdbnn1YyBUoKmPvBn36LtluKHnTwjv5aKXOFxtWUiHkT9cMIgk42/29tHPHLBf6emnHZlRFeO3Pdg43BVcId9W0gU0xciMmAhpVdCxHz+yodzP3pMvtjtW4aBR3QFe60PPkbf1NhUW07IlPg2dBpKmJOfEFjv98PtvuKRZzeMa3jebOY0Jij6hHkHcmEFLQESXvw+1S+O/bB6TQgfACi6cgNwotbJB8co7GMUEZJ4Ut4eUolosFM/ov68CgvXrP5A9CqZf+ILnQvWQmvOMYZ7M4OcLX++28a2BABsF3OqJUCZ8TrxYCUAj7vuj8FV50b9YkJ44JLNrh0mIa1vn3hSdEXYi97FZQN9HP1nMryqqC95kgqk+1SDSPHcKQj2sA4m9PEhR5MLzVjaDDdkQbK7ajysjukEkFc9mxAyaYz3jjxUpKdYA0EzlD9goK7jECNylT1FSwiexInPs1c8CPWRaKVXU7KNdviorhvKYZ2N1503TfwH2SMz2V9Kzui
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(136003)(366004)(376002)(39830400003)(346002)(396003)(451199015)(316002)(26005)(55236004)(5660300002)(6916009)(66556008)(8936002)(54906003)(2906002)(6486002)(478600001)(6506007)(66476007)(6512007)(8676002)(186003)(41300700001)(1076003)(83380400001)(86362001)(2616005)(38100700002)(36756003)(66946007)(4326008)(81973001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MBhNIc8zqisxQCCHOHN6SbHWHG9eL2mIv3sEx+QKSvixQTAbkabQIgNLFmXw?=
 =?us-ascii?Q?M8opMG5ojnL/wRKJaurjlhHRr70NToECXVYX+fZrVvWFXYoRFwIhlN8xXbXK?=
 =?us-ascii?Q?Hz8g3/5jQCqJsDriITpeJncp6Mr5wFqua5qPtY7Kp6PzLs04wxdn/qZT8tVs?=
 =?us-ascii?Q?d46iYCggS6GeBs3HJ7qtUQEiBEqa6+4VlwmLQuaLi/6i/P1QfWACKGCMT2bL?=
 =?us-ascii?Q?Coh2i/MTw6+XegFLL0Yffpyi/BScY8TLj5vRyMqFyornCVF9L6elc0Ec1Bq5?=
 =?us-ascii?Q?sgC7D4jBOJBmDsjTnPDb4m1IzxCIhD8b+rE9S+aRd2G13ybAap8qQ63la3BE?=
 =?us-ascii?Q?HgxCWL/FGwI7u0U/hJdi12K12RznXlsnwrVdwruPuWuYkSwmf7hm4z92sGkN?=
 =?us-ascii?Q?wrA29a8eWLmZjQpTxQfBdYIskxPdDMzsrL5MguXDEDNgUkRdg4xz3w/zjl5A?=
 =?us-ascii?Q?VunuBIG7PX5XRGIxLrZnpDSpMUUniynb5x9ybKSAkKoHvvYIcBUC91X1poSz?=
 =?us-ascii?Q?NLhUMbN5zGsrGrdib1OmEk1G68jUTgZXuYspW+YGcdK2ER37VeZY4K/itJwx?=
 =?us-ascii?Q?MLb2FcyXH4XqyCUpNTCv9Av3CAu67VM8vPe6A1U/EhXHT2onjT2ACYA20FGW?=
 =?us-ascii?Q?BOsp3bag035qbYHRcj0dPG5DN4eCbpn2TeBNhnSeqZBOPHUlLQrKloMuRSJS?=
 =?us-ascii?Q?/NnkztnZ8E7sXlLkiMm7Ny9iSAb34grK2qn7ZfbuIJ/ur381O9VpL3sATkmx?=
 =?us-ascii?Q?azMe3wBGLkjlhGaYqGBDOBRr+Ju98m3/pcFa2qR8fVow/OvNu2uEiP0caoBK?=
 =?us-ascii?Q?/N/Ah0wV155u7i2KTiTj/OZuMneFCFN07fsHfjhGGa7vklPTMsX+Ou7mkkVw?=
 =?us-ascii?Q?7IKUbIa5zo6SqTlX5GGMTz6oKx5ki9qlx3bPNeMTMn3VLc1D8vm+rJNy9r1v?=
 =?us-ascii?Q?4COCDysRSyzAsCQGV+/6Lit5t9xm6mdAawUDuk5iY9S4oF++Y23ScZel64ZT?=
 =?us-ascii?Q?WiOVNMoZwWLtkgN55y/yMmlU+A7pEeknpm69ZSsWcqppDTfRbsYZ+sityxIK?=
 =?us-ascii?Q?WTbSaRUKIu/r6ZcgD3sxU8Mdv4GfcZBqIJ6oDYUBNt+KfDTjjcClrBTDTlia?=
 =?us-ascii?Q?DbQllZzPxUCi9Njzte0r2NXwSXx9AZWtYcz6ejOhxy7a9vO7KHGKFDtjOsXN?=
 =?us-ascii?Q?JmENjAFndiOJGPpKLqigVcaHRhHZBDduIDe7pnNGjh9KmJwN1aMqyF7Qw4o2?=
 =?us-ascii?Q?pQ7KWAh1+ilemfL9wgZQFtWaIhkdgQ2wIDqIWai759zCkrUNYRYsGVZCuAOZ?=
 =?us-ascii?Q?rrbdYjMVt7H5cV2XZnDMCisLoOkR0BqBfxnP4KoY8wrrNdZpnRbz334+sSTj?=
 =?us-ascii?Q?o67kFDjFFWrwqrmfJVHQR9NWnG0h48nGyboTJnU+6mOk5IY3j0Sd63KGxCPP?=
 =?us-ascii?Q?PlO/dSHHs/4604Up9J3O5QwSWEpzhZa9fU74Cm8o+wqOCk+eCVla1w++zHQ+?=
 =?us-ascii?Q?+msMpibOTEtg4N7oDiLjdeNjg/gL87xw9Um8Qv1Q1AhOqkimPMo0BRHjGRLv?=
 =?us-ascii?Q?Talj8PBe7ZihhH1mYj4=3D?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dc85e46-9391-4fed-131a-08daeb666f2f
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Dec 2022 19:37:21.2155
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MuNhN803hS9lV4nEeg0Mtt1MkRFHk8nnrYHVms7GkAA6SoMJSBXAqYh1QoiMz595AEEl4feJg/8AhjFYH40YFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB2580
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Dec 2022 06:03:41 +0000
Wedson Almeida Filho <wedsonaf@gmail.com> wrote:

> This allows associated functions whose `self` argument has `Arc<T>` or
> variants as their type. This, in turn, allows callers to use the dot
> syntax to make calls.
> 
> Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  rust/kernel/lib.rs      |  1 +
>  rust/kernel/sync/arc.rs | 28 ++++++++++++++++++++++++++++
>  2 files changed, 29 insertions(+)
> 
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index ace064a3702a..1a10f7c0ddd9 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -14,6 +14,7 @@
>  #![no_std]
>  #![feature(allocator_api)]
>  #![feature(core_ffi_c)]
> +#![feature(receiver_trait)]
>  
>  // Ensure conditional compilation based on the kernel configuration works;
>  // otherwise we may silently break things like initcall handling.
> diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
> index 22290eb5ab9b..e2eb0e67d483 100644
> --- a/rust/kernel/sync/arc.rs
> +++ b/rust/kernel/sync/arc.rs
> @@ -57,6 +57,31 @@ use core::{marker::PhantomData, ops::Deref, ptr::NonNull};
>  ///
>  /// // The refcount drops to zero when `cloned` goes out of scope, and the memory is freed.
>  /// ```
> +///
> +/// Using `Arc<T>` as the type of `self`:
> +///
> +/// ```
> +/// use kernel::sync::Arc;
> +///
> +/// struct Example {
> +///     a: u32,
> +///     b: u32,
> +/// }
> +///
> +/// impl Example {
> +///     fn take_over(self: Arc<Self>) {
> +///         // ...
> +///     }
> +///
> +///     fn use_reference(self: &Arc<Self>) {
> +///         // ...
> +///     }
> +/// }
> +///
> +/// let obj = Arc::try_new(Example { a: 10, b: 20 })?;
> +/// obj.use_reference();
> +/// obj.take_over();
> +/// ```
>  pub struct Arc<T: ?Sized> {
>      ptr: NonNull<ArcInner<T>>,
>      _p: PhantomData<ArcInner<T>>,
> @@ -68,6 +93,9 @@ struct ArcInner<T: ?Sized> {
>      data: T,
>  }
>  
> +// This is to allow [`Arc`] (and variants) to be used as the type of `self`.
> +impl<T: ?Sized> core::ops::Receiver for Arc<T> {}
> +
>  // SAFETY: It is safe to send `Arc<T>` to another thread when the underlying `T` is `Sync` because
>  // it effectively means sharing `&T` (which is safe because `T` is `Sync`); additionally, it needs
>  // `T` to be `Send` because any thread that has an `Arc<T>` may ultimately access `T` directly, for

