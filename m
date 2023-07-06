Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4380D74A56B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 23:01:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232509AbjGFVBp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 17:01:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjGFVBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 17:01:44 -0400
Received: from GBR01-LO2-obe.outbound.protection.outlook.com (mail-lo2gbr01on2127.outbound.protection.outlook.com [40.107.10.127])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3798319B7;
        Thu,  6 Jul 2023 14:01:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cOMCbaSryTgKnYlyJflH4DyGPImseS9Lg8LELKYAAlCELyts0+x9+A8JodWc7MC32PLtjIk8gmIS1KpO3w+ZQu0DKSOcT5MxCz1OQ4TKWyq8SStFxpYDDYqM6eqTIftX5Q01ZpKtkz6Wc8nGm7uJgcSPO0EAALzEwcgevaG0ZvcNs+ptT2dPKglzb4fMxRL8xHFllongLLgAi5f587djsPrIDxA3ppHkedkNpF9Rx6Zk4EVXPfDTH5SYo8V+mmgfGa6vSbWg93U60ZlK8YdtEVW0fi8mh3qZI+q9nVjlvCnhCXM+5gl/n/Y39iya2Cn2PA3yyPm5/FFk7skfL6O/kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YWcYkGk0n2MA8J5p9YPZcIwNcCm5lXgNpEKvF0ymqqs=;
 b=Zay5Cu9Fq+Om5bbNaTgYR2/i3m3hOfWxrmrAj+F5eh2Gt+SSiNArZibQAy500fGLwd2mwG/4o0PxK89JbgTMx/ZSdMVrKgiS14ysIfi9HYVXg8lr9MEq+eZ58EKos+yROxEwThCIi29WPOGdH+voWUoH8pPHA7y3Wti/AZhLNYYtKQ0XvpydISwW0dz6rDc+cqSCIiUcmHgvn94slnMOVxR0HnEXoMzEjMeFuuWQIqLTx1RPdMuB4p++fZ9YHSpOnaTVR2MP8RbjWp9oZGDdzUkf+W8aw9LHAm6IfXAxydJOS9BbQFKHHzt/7UIHDcNDXO3tjWdHK59jbh5eZR6oGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YWcYkGk0n2MA8J5p9YPZcIwNcCm5lXgNpEKvF0ymqqs=;
 b=UsBpEJtuYwOB8SuhPIrlPtnZ61KkIipvSc+nibtgPseXNeEu6jSErQ34PbVXUCWTFNvEDdPBzTk5Ttfa13n64FrC5ca62yVdRKWUzSZV61+KKZmy8OS5huJ0z8vL/s/UyV9txEz8pXOKEIoOpo9wyHSfZozsOhB9xoqOZ2bxk1Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LO0P265MB6344.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:2c9::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.25; Thu, 6 Jul
 2023 21:01:40 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::25e2:a08b:cd9c:c3c9]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::25e2:a08b:cd9c:c3c9%3]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 21:01:40 +0000
Date:   Thu, 6 Jul 2023 22:01:31 +0100
From:   Gary Guo <gary@garyguo.net>
To:     Alice Ryhl <aliceryhl@google.com>
Cc:     rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "=?UTF-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev
Subject: Re: [PATCH] rust: delete `ForeignOwnable::borrow_mut`
Message-ID: <20230706220131.428276e4.gary@garyguo.net>
In-Reply-To: <20230706094615.3080784-1-aliceryhl@google.com>
References: <20230706094615.3080784-1-aliceryhl@google.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P302CA0020.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c1::9) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LO0P265MB6344:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a9ea341-e8b7-4fb7-2970-08db7e6431a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0r4fhcfjaXGciP8ksg4oga2sflWgd1P5wdQsd7+zdRJi2SvtB0lERqT3tNoYpW4n4TnwpYLTVLDB25xA6/IKdqosQJsMlP4vkIsLZxmfjuL2tHKwjN8B1kSPFuRHOPh1PUqXy7kRd5AXmIp14V/P9sXRmV6+ikBbHZbN0uEnQQpLBtSb7dVpSRpHBdETj1Y2xPUdHITQCBjjBBXKwZ1uynXSBdCrHrXfhs9MiwYQud6wL1Cmfj5ePv6job/iBhfAqYgSjyVHgXFWc6orKYtWbFZdLLJUA9XTGgbnkyuYj1FACgxr469da0iqQf0u8+I59EOxNEcIirsLim2vqpG07qt8gQtZUssDb0Ae76yqSicAFQ71rm90eXbkJvnoY53Z5QYEL5CB8sX83Dbw793QNJRv3d7TVd27YJprkxCLr8PG41OC/CEHXr+KtXOsSF/u9Vl/CLwOR5hQUSxAL3RqMoKMtWKoSpeGSU5fL1EPmBs7tVbENABcKEAXMkd7iKeqAHqGJu0hZHnOZFDrqgRCjZhQDCikQdxYcz7FnRy76kstoR5x4vFwRW8ktPp/5+j5vVikHX7aOYUhfhzS6AUjfhatt8AO3DxZGd1ssmlXwRI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(376002)(366004)(136003)(39830400003)(451199021)(478600001)(6486002)(6666004)(54906003)(6506007)(1076003)(26005)(6512007)(186003)(2906002)(41300700001)(316002)(6916009)(4326008)(66946007)(66476007)(7416002)(5660300002)(8936002)(8676002)(66556008)(38100700002)(86362001)(36756003)(2616005)(83380400001)(81973001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Hyzl4dVopu8vrfhQlbR0tBGtEIYCAY9FkWAwcly/FU9aM3AxcVDYxaLR7pMF?=
 =?us-ascii?Q?T/GRu65NhiRZklBFlkdWAdyU7UeMgOb8O109yCamJtfx9XvC5CKnXXq5mFMg?=
 =?us-ascii?Q?sQSBfyip3oT37ZNOhWqiFr8kYzFfCvE853kU6hZuoJ4o4DeSDJuN2Wv8uNG0?=
 =?us-ascii?Q?HCbA5Fv8T1mXgmIbU7XOXlpTtiTG7OJcc3KP68qd0JCmb2m63hL3M6LdW+I3?=
 =?us-ascii?Q?NxaRtMR7yDP6o1qK7vpL9UCamaAs56tOYojbj9Q7WgmTN3aV+11fxY1tZfwI?=
 =?us-ascii?Q?M9iBi3qwOHg77Ud2ZPysAj8Mi7j+FYroZPq1CvR+69OZjnO8MzqYzJXTJbvj?=
 =?us-ascii?Q?6HTP5itwwNPpK0TKd6DA55ae8pMZsnynXubOCBKD4l7Hc3ez4dDVLhjafUPw?=
 =?us-ascii?Q?5LoKQfNaY8Jvx0klaRD1ymzjUtRrg/YDQR0vYsYeqn27h2GdwlXAmWBlx87n?=
 =?us-ascii?Q?M60DEBRV2ErYt4Ralmh2N8ZyEdpcIBqlePJzCBva55NcBnAZ7ySfIHVFQUyM?=
 =?us-ascii?Q?F57cGw3t49aNyyxewm714UF/a59OpKxOuH0H8FTLdKEDUoAh93ev1pilD6kL?=
 =?us-ascii?Q?4W2T9Mx4g3YXvkSPVZGbcuKr2HbiL4WPHCMDf5hmPLeWBmuZ5q1SC0nVdeGw?=
 =?us-ascii?Q?zZ7CU02iHxitvaQceaKKa6OcAEg5kLc7ETTU/hVkqwkBSpAbHxNuCvtYmK/g?=
 =?us-ascii?Q?X2lutBYBHyy+Z13oRztCcorvfUicmASeHdj22z5k1sNIYWx7hBj2dn4K37+D?=
 =?us-ascii?Q?j4Y4ZJl2hnwFxGKCW0YoT4Q6EkqPJvS71ZdtYaxzM3Cp5b6r2ntx+JZ64BF5?=
 =?us-ascii?Q?Q0PTaKAVXyMGSg5T7mTZprzNWmqzPwjHtiu8GlNhpN7BMb68LzV4qIlo5b7a?=
 =?us-ascii?Q?X8CBrOLGR9W9I6brrZUH4xuzFNSJWo/uT6n0eOh0t3SJQ7nU4HdJOxycrmEL?=
 =?us-ascii?Q?qdCPaXjsdItu8oKUtxGlMUfgSYZZO9ZC68su0Bhn+/C9K5pCEDAD2GkfXljW?=
 =?us-ascii?Q?G0TEVpvKObd3Uw10gv1VOHBGvfR8d+3WqnLzG7pUQcCC8ew9Ocd+L6S8huWz?=
 =?us-ascii?Q?D4LmFhm+VHEbwQRle5Q6sBerV2QdOl7h9/4hf52i/nLfYDK6dNTI5xMY8jmy?=
 =?us-ascii?Q?R9G1nbXe0aDrUzLOQjRzUXYUF7QuxpXM13FHYXCbpMoCO9JewcaM/IewFdRf?=
 =?us-ascii?Q?WUxxgr/Tr9Uo7hGjuWrfaMUvJU18unJTrFNFjPCVxWm0kacbnblXbQE8stIW?=
 =?us-ascii?Q?syM01I296eXTFYt/eH7gXs8+rhVRims0VTqM6oT3f8oRq1o02TOB1u7o/Po9?=
 =?us-ascii?Q?LyeyA5Nj2kGF/AjdkDia8lTR6arAkJeN6A69W8CUGCERiAYDGM85rpjN0LO6?=
 =?us-ascii?Q?5gfP8w/LymkwElFKGLgBNP+v3CHDImFIVm9jH/3J1WSOFsH2acwgH+K6ls7V?=
 =?us-ascii?Q?G6etOxdR4TOqLGiAq3dHVKAYhLOEUbQPqgD/gKo4/GpIs0NRrsC77doDhH8J?=
 =?us-ascii?Q?ahgQI1mh5NBhwj8dV+3USF9uge/OxheokKoEY4Wai7jTi6/ifWbVSxI10umc?=
 =?us-ascii?Q?Ym42qrRAUOTPxRZl1SsHi68rokekkwYeeY6ASXOu?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a9ea341-e8b7-4fb7-2970-08db7e6431a5
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 21:01:39.9625
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c77BzqXyJtXztJURkX6WE0eOUxtuEC9mlmcF5oXVuSQUPu18QMKlgDUPFRv/VbljyVTsoHkOOfXg2wBlqIcftw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P265MB6344
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  6 Jul 2023 09:46:15 +0000
Alice Ryhl <aliceryhl@google.com> wrote:

> We discovered that the current design of `borrow_mut` is problematic.
> This patch removes it until a better solution can be found.
> 
> Specifically, the current design gives you access to a `&mut T`, which
> lets you change where the `ForeignOwnable` points (e.g., with
> `core::mem::swap`). No upcoming user of this API intended to make that
> possible, making all of them unsound.
> 
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  rust/kernel/sync/arc.rs |  3 +--
>  rust/kernel/types.rs    | 22 ++--------------------
>  2 files changed, 3 insertions(+), 22 deletions(-)
> 
> diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
> index a89843cacaad..172f563976a9 100644
> --- a/rust/kernel/sync/arc.rs
> +++ b/rust/kernel/sync/arc.rs
> @@ -243,8 +243,7 @@ unsafe fn borrow<'a>(ptr: *const core::ffi::c_void) -> ArcBorrow<'a, T> {
>          let inner = NonNull::new(ptr as *mut ArcInner<T>).unwrap();
>  
>          // SAFETY: The safety requirements of `from_foreign` ensure that the object remains alive
> -        // for the lifetime of the returned value. Additionally, the safety requirements of
> -        // `ForeignOwnable::borrow_mut` ensure that no new mutable references are created.
> +        // for the lifetime of the returned value.
>          unsafe { ArcBorrow::new(inner) }
>      }
>  
> diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
> index 1e5380b16ed5..d479f8da8f38 100644
> --- a/rust/kernel/types.rs
> +++ b/rust/kernel/types.rs
> @@ -35,34 +35,16 @@ pub trait ForeignOwnable: Sized {
>      ///
>      /// `ptr` must have been returned by a previous call to [`ForeignOwnable::into_foreign`] for
>      /// which a previous matching [`ForeignOwnable::from_foreign`] hasn't been called yet.
> -    /// Additionally, all instances (if any) of values returned by [`ForeignOwnable::borrow_mut`]
> -    /// for this object must have been dropped.
>      unsafe fn borrow<'a>(ptr: *const core::ffi::c_void) -> Self::Borrowed<'a>;
>  
> -    /// Mutably borrows a foreign-owned object.
> -    ///
> -    /// # Safety
> -    ///
> -    /// `ptr` must have been returned by a previous call to [`ForeignOwnable::into_foreign`] for
> -    /// which a previous matching [`ForeignOwnable::from_foreign`] hasn't been called yet.
> -    /// Additionally, all instances (if any) of values returned by [`ForeignOwnable::borrow`] and
> -    /// [`ForeignOwnable::borrow_mut`] for this object must have been dropped.
> -    unsafe fn borrow_mut(ptr: *const core::ffi::c_void) -> ScopeGuard<Self, fn(Self)> {
> -        // SAFETY: The safety requirements ensure that `ptr` came from a previous call to
> -        // `into_foreign`.
> -        ScopeGuard::new_with_data(unsafe { Self::from_foreign(ptr) }, |d| {
> -            d.into_foreign();
> -        })
> -    }
> -
>      /// Converts a foreign-owned object back to a Rust-owned one.
>      ///
>      /// # Safety
>      ///
>      /// `ptr` must have been returned by a previous call to [`ForeignOwnable::into_foreign`] for
>      /// which a previous matching [`ForeignOwnable::from_foreign`] hasn't been called yet.
> -    /// Additionally, all instances (if any) of values returned by [`ForeignOwnable::borrow`] and
> -    /// [`ForeignOwnable::borrow_mut`] for this object must have been dropped.
> +    /// Additionally, all instances (if any) of values returned by [`ForeignOwnable::borrow`] for
> +    /// this object must have been dropped.
>      unsafe fn from_foreign(ptr: *const core::ffi::c_void) -> Self;
>  }
>  
> 
> base-commit: d2e3115d717197cb2bc020dd1f06b06538474ac3

