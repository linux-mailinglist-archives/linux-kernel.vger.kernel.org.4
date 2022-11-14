Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFF3D6282A7
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 15:35:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236858AbiKNOfK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 09:35:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236101AbiKNOfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 09:35:07 -0500
Received: from GBR01-CWL-obe.outbound.protection.outlook.com (mail-cwlgbr01on2119.outbound.protection.outlook.com [40.107.11.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82AE3E40;
        Mon, 14 Nov 2022 06:35:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MU6Zuozty0TbfIN1/odsClQu42LCztjIpsw8l13qhcrLHGyKg5oL2xrWfkA8qrM2mc+Tq0HwpQt6uloNPHvX0PmilUI1Qjt47/1xNduSVwIsqEl7gH6+t9Pni0ejBMWXfWuWS979JXDMcNKYOsi+2sFXTQXguo6+uqZhhG2CPRkNJF+287nm9xGdlgxqdojFq7n9Sl/DLDOwtw+cHGwkNZ45IaUQYXvK8fh2psN1wAiNPGDda4V6I6BxJ5kYQMuY7QLb7mlhtmi9uVDjs6orKFEjKpWiW8M0JqcDI7LfQqH2h6IsIyR1kdTChegjDLeCNW6IpC26B7+uni1e109iQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6+APXQzV/xjzW2sfhkB502lgZia/M4MpCN+f/xmVZIk=;
 b=AHrq5ZRDmHuSl2I1KT3QM1794wEmVhAyhgWFYKnPqf5T3WT2+UQGFHaCYk+5icvDkKxuHgs1X5EyEn4PgrexRLrUOpsQs1QTRp5jxr7Z7N5fal08XZ+eu3u7+3Gs8JEHDU7madUChsRAjtQ2pmNdHIWo4GLwPfVb9WmC89++r8+7cDxO6pqYEvK9wJ8FlZOsuhToCX8NOxA5zrotImihSN6Q38/VxVEOmpJc3hcx1ZOZrPe1d89fezrQE5VxvUj7aToGTczJhIXUruzbCV8F0onLyjoF09twwVtLLIgdNteIkb8n3ct4pMtJHUv4LesZ2LPTw07+9IHyamkX9YGrLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6+APXQzV/xjzW2sfhkB502lgZia/M4MpCN+f/xmVZIk=;
 b=KTpJbffy5iPZZ/en1NiWmIZpfCbHuphmwxZ+R+DckLjxV8/1//eqF7Qy3skRvdqtiuuugIt2Ho85Xhbk39m5sj1DElRBPcOOm318V7E23Fm6cmheUxiDPi8wc4C+PrmAjUjtk3qyGPcJtF6r5EG+gI4A0bH6XRnb9yz3qZpBPHI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LO0P265MB5572.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:274::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Mon, 14 Nov
 2022 14:35:04 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6c07:e2da:3210:3fd7]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6c07:e2da:3210:3fd7%6]) with mapi id 15.20.5813.017; Mon, 14 Nov 2022
 14:35:02 +0000
Date:   Mon, 14 Nov 2022 14:35:01 +0000
From:   Gary Guo <gary@garyguo.net>
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        =?UTF-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev
Subject: Re: [PATCH v1 13/28] rust: alloc: add
 `Vec::try_with_capacity{,_in}()` constructors
Message-ID: <20221114143501.7c1a6d2a@GaryWorkstation>
In-Reply-To: <20221110164152.26136-14-ojeda@kernel.org>
References: <20221110164152.26136-1-ojeda@kernel.org>
        <20221110164152.26136-14-ojeda@kernel.org>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0548.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:319::11) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LO0P265MB5572:EE_
X-MS-Office365-Filtering-Correlation-Id: 58ab8abc-cc4f-4c8a-87dc-08dac64d6a61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wEa465LdoRl9FQg2wE4rmQKZlczxpAdl2QPQPTL/n7Ve5IVvmorz/vFqOtrKzmpUI+Mgwjcu+N09jkhRndKHJM3lU3Olec8K3tFSEjgG0PsLx8RS1RJ2WteQSxrkUQIoTYojvyF+7GMGvWQU4BpAeQ4gb4R8YFKC07oxE8I0WEjPs9Rii+apuf8GCrx7GInEZJFRJ8Geds8bfWEbVyc1AieGqi76J+J/4fVF3AUnqHx4Eki5GzGfpmmO9WTNo11FL6wKsiQHspZMCs68drPWoY56z7scLqllQ9X9ruMy22aMysbvzaYHWFb6q8uSzHLVvHqtEpYcdqT2Q+ywVMKnk01soyEIWG5unnsoKlahtWr0z+K3ZSQeiv6dcLEiVIqLQLjtNMUmKfpWgNGCCnkmh7Op8YTcDkulIQEGYrbKolUmTaFOrpjFn7wZdJ/a1/DENsk6jsxRlKtmudNoBoK/hJhz10ft7JgUnSus3bM1wa9E939tJvXFw/iGfTZgKmDJ8hNDISiVNJC4xTA6CG0nSRfZIxwj7DRN6s11RcfUxQViVhXUAjWi8oMUv5PIpU9V4Il56yPVgNEj9xp/8GdhYMBtPo02l0Ioot8QYIOFRoHm315BD0k624VVu9zxdqDjLzNrsOktGLZAxWNnLJWpTE/iSl0OphLCj3Q1WW58BETEVhS4Muoy/MZNi5Ppjsw7dAdMzpdP0peecKuseZLNJKziNNH5NYWZrd889b/iyLBjHxNIsc6GKDi+DafQV0Qo
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(7916004)(376002)(346002)(136003)(396003)(39830400003)(366004)(451199015)(66476007)(66556008)(66946007)(4326008)(9686003)(6512007)(5660300002)(186003)(1076003)(41300700001)(8936002)(316002)(8676002)(38100700002)(86362001)(83380400001)(2906002)(33716001)(478600001)(6486002)(54906003)(6506007)(6916009)(81973001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DN1fuhe7pVTpnNMCBWGYc25n5wu0ruY+f7ArLMq3uHvF0mfd5GwVhWsrpyOE?=
 =?us-ascii?Q?fWJs+bwq5Mvyxfo0p08e9LwYuSrwjbTM2p8F5hSwZFENPlDR04W0LbycpnrJ?=
 =?us-ascii?Q?U2m5uXYtu22s929JMkk588wiOjieW2Mp7+veyF7ZZ6ezl+PdhxVZC9v2NaoG?=
 =?us-ascii?Q?m5GzhCYkRqFBxjOdffIoU9d3VMjFfjyATPuryTt/M1pnBGaN1E2hqLtwC8lf?=
 =?us-ascii?Q?5ceaWf4bmPFkNUcFhrXPEjC/9my4LkAlxL3CqdxkLn8x1zocg0vyhbkGuL/n?=
 =?us-ascii?Q?AHeg0hXQnYtQkA4fYFMso3/fHZ/D65+mV04SM5M9bbok3vCcXWiBlt0Rq2Qz?=
 =?us-ascii?Q?P/HnrmiXAh1zFgm1aF8O49GHbY2SiS+PFGTglYUFUNz+kN424dsa1Ldj/8+d?=
 =?us-ascii?Q?oBuxvkJwgDM2SF/X9pLo3Y8g1Qab2SUVpxvFJLnHGMU4a9m0Zxm/fpMf8/V5?=
 =?us-ascii?Q?YlYHWnT3jijRpcdg4UcC8hFzuhmNRxGXQfn2EDREK/JXLD02aSC2AIjquHvI?=
 =?us-ascii?Q?ShrPlI+g3GsW3SJuxMk/t4T55d9m+5rojZGHCZ9erzh+J7Vw4ena+r6zqlN+?=
 =?us-ascii?Q?5U2B1+hOQ4W/axigG8wrgOfa60RuRUOjZ/Hs/73nYlH3dKZVFbKtvCqLiioX?=
 =?us-ascii?Q?KTqjy5N1SUgTmMdf+FcfzKEkIWplAiOVdeX0T2DE8L44BNbFXQMc0GD99Uey?=
 =?us-ascii?Q?XYQdCzV89kGGv1NmtIGfNisPgLvEUfFdMDthDy1yIVgjefwwPAoIV4HLnP4s?=
 =?us-ascii?Q?Lt6rRZh+YtkTHBUYV1lvIe/Z8IakG00URFeiFPX6iOdfVKzWUz+rQgzhkHXe?=
 =?us-ascii?Q?JPjAd92z/0pU0/YJUruy685TfgePqSqcH+Xt4NsbRBEgBXTD//6/kHTvHYOw?=
 =?us-ascii?Q?XIBZcQDHWtm1EZBY7B0C0plS+ddMbGDvzbsrU9Tc3iSle89p6FIjLDWmYXQP?=
 =?us-ascii?Q?LBrXY51XN71T+dm54A/8EJ3bl658UTObvFf3NyA4fY5MLqKLCNhPWAnFVfd3?=
 =?us-ascii?Q?izyF+QLpXDmCvZJubJ3jro6nByxtYzYG130fJ18pGkrZbBsu/sNuYdDhEC5g?=
 =?us-ascii?Q?gX9sjYUda2R/dDfKXqSWp+7mPrK1Zhd3NCg+f1tLMiVpaOl244w8e+zx3XTy?=
 =?us-ascii?Q?b5YoBsqi/MUmNjhyNjuxGeBQ59N+0go6XRhhAywWRdUcObASkbfNKwFQgHi8?=
 =?us-ascii?Q?jqySVBeU1BUPlh7Su4QYp9ZRJh2LB7Npmoozzi4+Mtltjpk9bnNq+0JHnGow?=
 =?us-ascii?Q?r0PLs0YywF2kRuQisAIm0Vf9LI84dHz7cN5u8dB3/yEgVfMFa/Z5lCau9wYQ?=
 =?us-ascii?Q?T/94A1e1HYvryFGTlj3cJU0MsApqcfZ3ZktYAdHztqXd6MJ2bPKLjaPvHAow?=
 =?us-ascii?Q?auwB0gPPySi/V5Mb+VVnOvOoPmyddHP4GK2V4fuyhFyYjnDgLmRfzHlM105Z?=
 =?us-ascii?Q?WV/acDn2IxpxZe1zeou1UH4xHYnIgeQAa4ZhM64Xs9TcEH0fj+oq+V1jne2Z?=
 =?us-ascii?Q?r6JYlJfx1vNMjvubNTq0FIpH/mVquV0RwprNO174LdKfZMENid/N+Hi8FLXi?=
 =?us-ascii?Q?XZJmQlzlXVb/IQxbPzKUbQqGaI70DfLcoOj4/FXdzJq9C4KQK29hBiLOnUPr?=
 =?us-ascii?Q?vlle9mebWQ1P7CpeyEdxjpt8CNuu7pZ9FGloUbyCVdF/?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 58ab8abc-cc4f-4c8a-87dc-08dac64d6a61
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2022 14:35:02.6841
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G0p0xK2c5CDczMMTLw8ABdBJxHQOdUMzrBJu2T0vsbLT3IiVvka7pK5qFWEsWIhAC4C11JLY+RU5M4GEPVundg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P265MB5572
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Nov 2022 17:41:25 +0100
Miguel Ojeda <ojeda@kernel.org> wrote:

> Add `Vec::try_with_capacity()` and `Vec::try_with_capacity_in()` as
> the fallible versions of `Vec::with_capacity()` and
> `Vec::with_capacity_in()`, respectively.
> 
> The implementations follow the originals and use the previously
> added `RawVec::try_with_capacity_in()`.
> 
> In turn, `Vec::try_with_capacity()` will be used to implement
> the `CString` type (which wraps a `Vec<u8>`) in a later patch.
> 
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  rust/alloc/raw_vec.rs |  1 -
>  rust/alloc/vec/mod.rs | 89 +++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 89 insertions(+), 1 deletion(-)
> 
> diff --git a/rust/alloc/raw_vec.rs b/rust/alloc/raw_vec.rs
> index c342f3843972..eb77db5def55 100644
> --- a/rust/alloc/raw_vec.rs
> +++ b/rust/alloc/raw_vec.rs
> @@ -135,7 +135,6 @@ impl<T, A: Allocator> RawVec<T, A> {
>  
>      /// Like `try_with_capacity`, but parameterized over the choice of
>      /// allocator for the returned `RawVec`.
> -    #[allow(dead_code)]
>      #[inline]
>      pub fn try_with_capacity_in(capacity: usize, alloc: A) -> Result<Self, TryReserveError> {
>          Self::try_allocate_in(capacity, AllocInit::Uninitialized, alloc)
> diff --git a/rust/alloc/vec/mod.rs b/rust/alloc/vec/mod.rs
> index 540787804cc2..8ac6c1e3b2a8 100644
> --- a/rust/alloc/vec/mod.rs
> +++ b/rust/alloc/vec/mod.rs
> @@ -472,6 +472,48 @@ impl<T> Vec<T> {
>          Self::with_capacity_in(capacity, Global)
>      }
>  
> +    /// Tries to construct a new, empty `Vec<T>` with the specified capacity.
> +    ///
> +    /// The vector will be able to hold exactly `capacity` elements without
> +    /// reallocating. If `capacity` is 0, the vector will not allocate.
> +    ///
> +    /// It is important to note that although the returned vector has the
> +    /// *capacity* specified, the vector will have a zero *length*. For an
> +    /// explanation of the difference between length and capacity, see
> +    /// *[Capacity and reallocation]*.
> +    ///
> +    /// [Capacity and reallocation]: #capacity-and-reallocation
> +    ///
> +    /// # Examples
> +    ///
> +    /// ```
> +    /// let mut vec = Vec::try_with_capacity(10).unwrap();
> +    ///
> +    /// // The vector contains no items, even though it has capacity for more
> +    /// assert_eq!(vec.len(), 0);
> +    /// assert_eq!(vec.capacity(), 10);
> +    ///
> +    /// // These are all done without reallocating...
> +    /// for i in 0..10 {
> +    ///     vec.push(i);
> +    /// }
> +    /// assert_eq!(vec.len(), 10);
> +    /// assert_eq!(vec.capacity(), 10);
> +    ///
> +    /// // ...but this may make the vector reallocate
> +    /// vec.push(11);
> +    /// assert_eq!(vec.len(), 11);
> +    /// assert!(vec.capacity() >= 11);
> +    ///
> +    /// let mut result = Vec::try_with_capacity(usize::MAX);
> +    /// assert!(result.is_err());
> +    /// ```
> +    #[inline]
> +    #[stable(feature = "kernel", since = "1.0.0")]
> +    pub fn try_with_capacity(capacity: usize) -> Result<Self, TryReserveError> {
> +        Self::try_with_capacity_in(capacity, Global)
> +    }
> +
>      /// Creates a `Vec<T>` directly from the raw components of another vector.
>      ///
>      /// # Safety
> @@ -617,6 +659,53 @@ impl<T, A: Allocator> Vec<T, A> {
>          Vec { buf: RawVec::with_capacity_in(capacity, alloc), len: 0 }
>      }
>  
> +    /// Tries to construct a new, empty `Vec<T, A>` with the specified capacity
> +    /// with the provided allocator.
> +    ///
> +    /// The vector will be able to hold exactly `capacity` elements without
> +    /// reallocating. If `capacity` is 0, the vector will not allocate.
> +    ///
> +    /// It is important to note that although the returned vector has the
> +    /// *capacity* specified, the vector will have a zero *length*. For an
> +    /// explanation of the difference between length and capacity, see
> +    /// *[Capacity and reallocation]*.
> +    ///
> +    /// [Capacity and reallocation]: #capacity-and-reallocation
> +    ///
> +    /// # Examples
> +    ///
> +    /// ```
> +    /// #![feature(allocator_api)]
> +    ///
> +    /// use std::alloc::System;
> +    ///
> +    /// let mut vec = Vec::try_with_capacity_in(10, System).unwrap();
> +    ///
> +    /// // The vector contains no items, even though it has capacity for more
> +    /// assert_eq!(vec.len(), 0);
> +    /// assert_eq!(vec.capacity(), 10);
> +    ///
> +    /// // These are all done without reallocating...
> +    /// for i in 0..10 {
> +    ///     vec.push(i);
> +    /// }
> +    /// assert_eq!(vec.len(), 10);
> +    /// assert_eq!(vec.capacity(), 10);
> +    ///
> +    /// // ...but this may make the vector reallocate
> +    /// vec.push(11);
> +    /// assert_eq!(vec.len(), 11);
> +    /// assert!(vec.capacity() >= 11);
> +    ///
> +    /// let mut result = Vec::try_with_capacity_in(usize::MAX, System);
> +    /// assert!(result.is_err());
> +    /// ```
> +    #[inline]
> +    #[stable(feature = "kernel", since = "1.0.0")]
> +    pub fn try_with_capacity_in(capacity: usize, alloc: A) -> Result<Self, TryReserveError> {
> +        Ok(Vec { buf: RawVec::try_with_capacity_in(capacity, alloc)?, len: 0 })
> +    }
> +
>      /// Creates a `Vec<T, A>` directly from the raw components of another vector.
>      ///
>      /// # Safety

