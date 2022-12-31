Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 303A065A684
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Dec 2022 20:52:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235798AbiLaTw1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 14:52:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbiLaTwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 14:52:24 -0500
Received: from GBR01-LO2-obe.outbound.protection.outlook.com (mail-lo2gbr01on2134.outbound.protection.outlook.com [40.107.10.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 097726243;
        Sat, 31 Dec 2022 11:52:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fWQkBgw8YR85bJKWhdBc5aYzQ9sVXhaq0cJC9AJa+tcvrUzzgJhIgKG9G4/kdlgli7cQdRrgRHGnk78kzlWxFyj+HHYO8g3bKtYW9WenjYyAfPrlnmhH2A6nPFp8Pq2vN2KlK/Bl3u5b3wilUBCx+WSxtGZe8xvTbk6P36iJiVzLljYLvcY3hmKxjQ6xjlq91tDAEig8hwqAYu98DE7C7qxI57PzZnMUSA9CD9JuBe7br1YAMoeJ+cfnOEZem1CNEFoQodP1mG4+Bpxfk3I5ovt7/fettDgTAtLK2+RmeXU62SUq+db7PN3O0ndH/Sas0vwWUJCwDUU3dnK5/IkTyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JExMLOBN/jhFiWvi8h4YJPfejO0l0aDNrIYf8AH2nQs=;
 b=kXcB5mBfkcJ8DAmG9WBVXlswu0jnuXhKuOFh5vQObb2/q1mSh1UG7Nx0aDSnZt4WNe2+Y88XyU2TIsjOniZ3tzVWbs2IMMz+j5Jj1jI1chRQoIbDzTV0RyACUuGpHHVUPXM16Xplz+r7C8a3bYPCBgZ7bo3eCoith9IuLZT3qi5HaITbOKYfJLU1UDFQ7Qb6QkQbM41HdbOv7B3wD6d9ARRDj/Vqo4sw1awmTjjwYk+BBy78iI+MVtUJEU3OYabz4xHblD8kGf/HhoFNQpzGBqRJZFqJJNnnl0+eqf6MVntu4mF9BVX6Kcci9ZN1IXtUVOQU/4lqctMNC0ucBhcFvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JExMLOBN/jhFiWvi8h4YJPfejO0l0aDNrIYf8AH2nQs=;
 b=uAKvXuL6aGk7a6qt+SCgJShLkCJgSN9cxA2X/k3ggKaBwxCk/OhaXTs90BmWG5lSbevcAFIA/N1YWIZ8KhIFNTpWHQEMo4VgpOn7+xwSEiXfnKu3hhr0qz4+jRC9Ij8X/p2nrCo13fsB/+WqGaATFOvODpmOjbmzxF60NidyOC0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by CWLP265MB5497.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:15c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.18; Sat, 31 Dec
 2022 19:52:22 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::2f24:8099:5588:8ba8]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::2f24:8099:5588:8ba8%8]) with mapi id 15.20.5944.018; Sat, 31 Dec 2022
 19:52:22 +0000
Date:   Sat, 31 Dec 2022 19:52:20 +0000
From:   Gary Guo <gary@garyguo.net>
To:     Wedson Almeida Filho <wedsonaf@gmail.com>
Cc:     rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        =?UTF-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/7] rust: sync: add support for dispatching on Arc and
 ArcBorrow.
Message-ID: <20221231195220.42e0893d.gary@garyguo.net>
In-Reply-To: <20221228060346.352362-7-wedsonaf@gmail.com>
References: <20221228060346.352362-1-wedsonaf@gmail.com>
        <20221228060346.352362-7-wedsonaf@gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0071.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2af::13) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|CWLP265MB5497:EE_
X-MS-Office365-Filtering-Correlation-Id: 48eb0ea6-b9ae-4334-abbf-08daeb688827
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0abpd1OJZCc5dHuYqp77Qb1u9U0ZPDomwbuwuIY6nrN3LEoMEGHJqPDnJCXgDUTlhNL9k2hPjhEq6aMHxcpYs3+ggXxwF0QYSIzTUNE8rKh7Yxy5wSaIQTkWsBkOCXk2Eg+UcLkT2+0uwCZmpBTW/pLzX24CsCT8OTM2DESEmJ5+uEY1mTQYLJxj5zfKRHJuIXCNoLAYe6QjaVsuXPDZLoXMBOdYxgWHjYaANZDuHk7SuarL70eNFcGsH8uYTzC4nhLJ3orFIUeKKP2oNxRh95prNZmPzzRcJ8rLGhc05PKdr1gcI5+XPNhWze07FwvhMM2U8xcihdQ4LWKeB0ynNHgGL/VIUWOjm2mdc4VgYDJurwKHZODqjFm5jaQ3aU6qaMmNNbd0v0vKKSZuoPK4jZ9/42MTScL1DyRkCUPVBRduyMEZnqfNEOmChZA4sYZ6mMM5sg+PCa/68Ka/gGzaWLae2Wpltylz/8/msLEycQxs0LEDEkrEeJPUfmWeOBfwrehkUcdvcOswm+QxVPa4Bkl3F9sk4s8MHrlYqI5dAgFu1y23kakItUZpqavQPcfPpq+MsDlPEnWdsAD0xXHktzhlYTyLKg+jdyca3UstR3Gdobf/N0PoParAhuSKQWgWN40dhUaSZpucUVuNibvl5g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(366004)(39830400003)(346002)(376002)(396003)(136003)(451199015)(6486002)(55236004)(478600001)(6506007)(2616005)(8936002)(186003)(6512007)(26005)(5660300002)(83380400001)(36756003)(38100700002)(86362001)(316002)(6916009)(54906003)(2906002)(41300700001)(1076003)(8676002)(66476007)(4326008)(66946007)(66556008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?k+85HwF3eM1bpzLPzabTgeuQAuXNWVU8pC13UTQeFbP0NUOHYhyeaVXwdqx7?=
 =?us-ascii?Q?lMFTDTzxZK1S2gmFXlV9bNsKedMK0nLEoHilLUb7/YsB/KBIk9Dgx5/I8Qdo?=
 =?us-ascii?Q?ckPC128NVt5ervga3IMRBPkuuoyFivIUwAOGy6jUEwdMAlLDWpvMfK9Sb3Go?=
 =?us-ascii?Q?Xj6EoBrksc3G9RW3+iYSFdwPmKH/x/X+jqgm4J3cQCqv0zNqFKkVT3FqEcMX?=
 =?us-ascii?Q?5y7WVX42zgKSnDQPCsis5dYIhuQ3LlE0Kx840AZhtxqzAm3ochpa60uukQYr?=
 =?us-ascii?Q?P5rXdi6eQs1N4Z+YvApPHTpjSEdjsh7cGvpqKvtC2UH/ii7fPmoTmI0UNg+q?=
 =?us-ascii?Q?dmGNJPJlmcKcnErvwkw0ml2Kl+0fyOB+Jj7wJNzkxLDoFP0YpMWyIWFktCSx?=
 =?us-ascii?Q?bBGrKPwjfeJVXkoi406KuHmHSw46QmM5XQ8hTERBtmyiPMa5IQC1t9iyjwGV?=
 =?us-ascii?Q?hXXH15lB0AfzCIJf3kyX8jhXf0r6f5DiLZQgS6jsAqmQ3ZKpvykMO1L7ZmS+?=
 =?us-ascii?Q?EMij3gRrCl0R5NBRL5nKBDyGyHJSIDyyfQUl9Jq76wm2KdswxEVQSSVmAZL7?=
 =?us-ascii?Q?ZCBxmRIiK1VKWKuM+IREaiRRWgMiETFZkUI+bfSMONgN+IrUqP2MUPp0v6/i?=
 =?us-ascii?Q?x7hQ4Zn6fZCm5O1RnX9SfUSBKA2ij6bVCAFpx01XialhsH1yefHYx/xxttqX?=
 =?us-ascii?Q?ngPPq0iJeNROE5eTideqOxizZZ4w8nIVqQElZytSLj7a84a23WQL8w1YsvRi?=
 =?us-ascii?Q?al76e3zCA58Pd8s5HYpcsTjzVnog8M2jVjW7pjYXPkGVRnzqon20Tcp9MtGB?=
 =?us-ascii?Q?lIFClT3qGlJuh9er4zpMTyGhoFJBO/Zn2FlgZMP6FAOBsFwO1bL63I5JoO+0?=
 =?us-ascii?Q?jLz2pyxxCbYi2gDOWGJalvKWsQISPF8M7zoAFij8j3FpGd3FecANWX0hloUp?=
 =?us-ascii?Q?LBSLblDjpdgrk98uS+K3EbbdRVcW0nCcdRnXrOSeEctAHYzfdqasB9UUhFPx?=
 =?us-ascii?Q?Z4GOIxZe9txof9F2VF14KrR00TBNlMmh9Fz74Jfi2MBDO5QPi0LhCkRdPnD0?=
 =?us-ascii?Q?3UArkbsS2Q5UZeCZu8DE6IEqHW2y0kB+QWYiKTJpr1TlQUXDQMlemo1exBZU?=
 =?us-ascii?Q?Qj3RI4T01zUm+hoAO+S3wVf0mCTVSk+r4Rt2nzB06f3z7Iu6NqF+FsPc7wJR?=
 =?us-ascii?Q?a/9GPbh03xd7/BOqeGBfDq4IXPmOHqKJEk6aMi0BUiXIy/slQlHRZsnJ0Qac?=
 =?us-ascii?Q?yiBllrGuo9/KfmFrKbeWAYaj7y3jqTxrWGxVe4QHDTCbsmlxFcpiCIl8jR2K?=
 =?us-ascii?Q?aFWBedxqkIDdYQEmkyttE5ZzL1BJFNlIxzrLUws0Iok4uKxieBDUEyRXN1y8?=
 =?us-ascii?Q?3BAeM5PjqwkgPwmnOD80YmoZ+kV2b0qBUCM1tyb+ht3myTVvF22S6U1q9kn/?=
 =?us-ascii?Q?VJwEQnUPjCX6mB7/7Q9yXvlgNR3pd+y8aBnzPlFvWcspg6Pxhdrf+nK3GpKB?=
 =?us-ascii?Q?K42WlJSuFWGfMvud8UVBBamSiZFKni91fA8VGQTXVNx1FK4tJRoP3gf40oo7?=
 =?us-ascii?Q?/Cp57n39ojzgeAiTGGs=3D?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 48eb0ea6-b9ae-4334-abbf-08daeb688827
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Dec 2022 19:52:22.1023
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g4P/xp+JRCzxfdcaZizbqqghEraOgLwsgflUEtvzlUxszVi6QTXyC3JE5DrSklHc6mo5ZMdjiUzZvNe93HJ84w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB5497
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Dec 2022 06:03:46 +0000
Wedson Almeida Filho <wedsonaf@gmail.com> wrote:

> Trait objects (`dyn T`) require trait `T` to be "object safe". One of
> the requirements for "object safety" is that the receiver have one of
> the allowed types. This commit adds `Arc<T>` and `ArcBorrow<'_, T>` to
> the list of allowed types.
> 
> Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  rust/kernel/lib.rs      |  1 +
>  rust/kernel/sync/arc.rs | 20 ++++++++++++++++++--
>  2 files changed, 19 insertions(+), 2 deletions(-)
> 
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index 4bde65e7b06b..e0b0e953907d 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -15,6 +15,7 @@
>  #![feature(allocator_api)]
>  #![feature(coerce_unsized)]
>  #![feature(core_ffi_c)]
> +#![feature(dispatch_from_dyn)]
>  #![feature(receiver_trait)]
>  #![feature(unsize)]
>  
> diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
> index 832bafc74a90..ff73f9240ca1 100644
> --- a/rust/kernel/sync/arc.rs
> +++ b/rust/kernel/sync/arc.rs
> @@ -92,9 +92,15 @@ use core::{
>  /// Coercion from `Arc<Example>` to `Arc<dyn MyTrait>`:
>  ///
>  /// ```
> -/// use kernel::sync::Arc;
> +/// use kernel::sync::{Arc, ArcBorrow};
> +///
> +/// trait MyTrait {
> +///     // Trait has a function whose `self` type is `Arc<Self>`.
> +///     fn example1(self: Arc<Self>) {}
>  ///
> -/// trait MyTrait {}
> +///     // Trait has a function whose `self` type is `ArcBorrow<'_, Self>`.
> +///     fn example2(self: ArcBorrow<'_, Self>) {}
> +/// }
>  ///
>  /// struct Example;
>  /// impl MyTrait for Example {}
> @@ -123,6 +129,9 @@ impl<T: ?Sized> core::ops::Receiver for Arc<T> {}
>  // dynamically-sized type (DST) `U`.
>  impl<T: ?Sized + Unsize<U>, U: ?Sized> core::ops::CoerceUnsized<Arc<U>> for Arc<T> {}
>  
> +// This is to allow `Arc<U>` to be dispatched on when `Arc<T>` can be coerced into `Arc<U>`.
> +impl<T: ?Sized + Unsize<U>, U: ?Sized> core::ops::DispatchFromDyn<Arc<U>> for Arc<T> {}
> +
>  // SAFETY: It is safe to send `Arc<T>` to another thread when the underlying `T` is `Sync` because
>  // it effectively means sharing `&T` (which is safe because `T` is `Sync`); additionally, it needs
>  // `T` to be `Send` because any thread that has an `Arc<T>` may ultimately access `T` directly, for
> @@ -297,6 +306,13 @@ pub struct ArcBorrow<'a, T: ?Sized + 'a> {
>  // This is to allow [`ArcBorrow`] (and variants) to be used as the type of `self`.
>  impl<T: ?Sized> core::ops::Receiver for ArcBorrow<'_, T> {}
>  
> +// This is to allow `ArcBorrow<U>` to be dispatched on when `ArcBorrow<T>` can be coerced into
> +// `ArcBorrow<U>`.
> +impl<T: ?Sized + Unsize<U>, U: ?Sized> core::ops::DispatchFromDyn<ArcBorrow<'_, U>>
> +    for ArcBorrow<'_, T>
> +{
> +}
> +
>  impl<T: ?Sized> Clone for ArcBorrow<'_, T> {
>      fn clone(&self) -> Self {
>          *self

