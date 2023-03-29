Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F6396CF48A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 22:29:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229504AbjC2U3u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 16:29:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbjC2U3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 16:29:47 -0400
Received: from GBR01-LO2-obe.outbound.protection.outlook.com (mail-lo2gbr01on2093.outbound.protection.outlook.com [40.107.10.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D56F5BB1;
        Wed, 29 Mar 2023 13:29:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ktfQSMNJJf5s56eo69bR1ZwrvwXF13bceMAyHaQJ8+/rEv8RrEtoIstsd25+eNN0jiN3PXSXHbz6nQbAAnYWg5CU2nqGB2D0nm8G6/wjE6yCl41VHJVRlZcyeapuJFVGfpS9O29uzpbZf+igMyLoy/qwqruHzQU48qyOHtkqcm+ds63nGEmhoPNXJdOoNky9A05Wbo028mJo6XudkXPk//39XWpNvjygMmilWCiBTel6XKcBDQrOR7Zx2pIpwpsfxCQc/7RQOcsXKrkQXppBhzekMYO+R3Jl1YZIJ8wkvsxXcuVzHze/lVga+7kMxvuCj2bD3WUVHhvw8eEdsRionA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zp/x/H1ui9IrDTuFU4fEAmwYeFC4isULdF+ZE2uuDqA=;
 b=i1VbZWI+2sZbA0fGVKv2LU7afyswyreRRhYU3bPA/4ItsQk9i3JQenVPAUwVPSk/f45fSCXl5jz86ZaG6sN7/OXGx8/0MKT0evgBrF77dSxx1jDD4VCJGanhCZ93TzWI4wVeDzExvghWJhPTRa2L+tAF6A+Gike8wRogZrr6Yd/r1QtJOkj52MsucSHqzBb3vCYilNvqDYNmjJIsGyzVllB01yakELh4O2Q5mXau5aB12xOs3pFYvLzYpd66fN5Z4tLcjl9Iv54o3yEBnv0cMkZ+jj5VQFoVGW8Do+2bYlrhjIMcOs6bNWKyHq6GzRxZI2vzQtBC/yBrEimQhsgmdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zp/x/H1ui9IrDTuFU4fEAmwYeFC4isULdF+ZE2uuDqA=;
 b=keogbw0l02Ryqk0SPfz/H2YetoNm7jMnky/IiQTf0wnQclew1CUbTqeiRqfR6xJ6+1QCe6bgfcH4gPS0pIMUa3Bx6kYr2mfnGssjG6RjZJzsDfHotfKY9JXrNWb7sGJH3jMvVkgkGSG6+h1jILNKbdcAobGppvJe4BkfzDSqx/A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LO6P265MB5984.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:2a5::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Wed, 29 Mar
 2023 20:29:43 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::2f2a:55d4:ea1d:dece]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::2f2a:55d4:ea1d:dece%4]) with mapi id 15.20.6222.035; Wed, 29 Mar 2023
 20:29:43 +0000
Date:   Wed, 29 Mar 2023 21:29:41 +0100
From:   Gary Guo <gary@garyguo.net>
To:     Asahi Lina <lina@asahilina.net>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        =?UTF-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
        linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
        asahi@lists.linux.dev
Subject: Re: [PATCH 2/2] rust: ioctl: Move to the uapi crate
Message-ID: <20230329212941.28c749c3.gary@garyguo.net>
In-Reply-To: <20230329-rust-uapi-v1-2-ee78f2933726@asahilina.net>
References: <20230329-rust-uapi-v1-0-ee78f2933726@asahilina.net>
        <20230329-rust-uapi-v1-2-ee78f2933726@asahilina.net>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0347.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18d::10) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LO6P265MB5984:EE_
X-MS-Office365-Filtering-Correlation-Id: 5280657d-157e-4d2a-01fe-08db30945428
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TKftJ7gdvxVWVuQM7DPk9ad8NeVqUg+o0Vi07X1JOzOAYzc0EP8HXHWN4793h/JCTOFQ4xwZDP/XLCFHlZDsRWJVpbWPMrSh0phvFmRwf7LHdy5jXHNkBZyV3cOyce92DL7g8g1bHb3md8+XnGcKYQ0e+rNp8UntHg0j7jTM9Oo85N2FW84RT/bWqygKz1RDUtvR/pMFbcErDmop/9EYNDCotxvZ5ricUoz5nQCAW/3C0LjKuPg6GzSqc0+KpHVviuqurnd6R8P5Wiou3o8BDuTQGm2+JGVPZO7ptmc4IhtyinL4AhE5YlPsw1M6T5Su/sLKNufIrGsAgxNpHhuhT8MLArkNs5bTu10O3q10VgPNJUPoqVc2vHWeyY9/hS561HgKV2qYUCHq8x4W3PpigsIYqoafT9D56y34cAA+gs1r+oXoZwGDm6h8OlCdiPJIzcsOCe3nXn0ls4ZqiOTyXcf3khFjBbkSX9Xi/a+/0U3I2Ovbee4eMXmuXdJU9QE+vj+OAegKRPm35a48vgm4ClNPcDwlUDBLzu6t0hfS6tfHchDQXYOCx163tAmeOv8N
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(366004)(376002)(346002)(136003)(39830400003)(396003)(451199021)(6486002)(478600001)(6506007)(6512007)(54906003)(186003)(83380400001)(4326008)(5660300002)(41300700001)(2616005)(8936002)(2906002)(1076003)(26005)(316002)(38100700002)(66946007)(66556008)(36756003)(8676002)(66476007)(6916009)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WOjPCB1MAQuVZ2lOuO8qptUBXn87WslywZfZAx+wTtVGiyQ9PvP/JwO5wlaj?=
 =?us-ascii?Q?nck52uiBC5Fr90i1PQcmhGWnPlVJwEAiqP46l2kT6AeEr8H5AP9vkXvxsxJQ?=
 =?us-ascii?Q?zn0uUUYI92pzVBapSWRt7ELAuqvhF5URYlS/909vyPJIiD+WvhkQqMCUhJMP?=
 =?us-ascii?Q?zTWABRdfnh2z8vmasrUbXroriyRzi+Hj+Q7a2R6NrHajlz7uWLqicnYAy0GH?=
 =?us-ascii?Q?txLhJdlYVVddEEU3mYvMaOD8yN9wc89VhTBdAaXng0ZsSYpe1G7V0yCh8i96?=
 =?us-ascii?Q?QMbly2g7+bKIRKlS98PZq6HxOHYLB9FXVhAuusC1EckyQ8Uzb1l/y3unYnoS?=
 =?us-ascii?Q?zPw5ExDK2WwFxglCiJcD/7mq6HI/EnW77BrflJgLzsFkB0xTlAcfLd5GbBvG?=
 =?us-ascii?Q?PtcIfn7VYVNj8IatIKv5rv0HV2CYq4vtUSSxpmXwGYB8fqc1XlzC0gwAfG2R?=
 =?us-ascii?Q?AlyNPP56nkno3BJPk6srYU1YDkrtwjS/4MV1iRCD+8aqK5Y4Jn4foBxNl5sL?=
 =?us-ascii?Q?qMzqFpMg07zWIPIkP6ZKRoEt/yRJANy/vvUiGJLoMPRfyjlwKLUDFjZTcEjl?=
 =?us-ascii?Q?YUzE3kUxP9G2y40WMjIDFebcs9PlkqhGP9Tpzik2kbOi17n/cIUncWjjNcKf?=
 =?us-ascii?Q?KpwBauCpAfF7ksJkC9hJZWOT/OK3dYHgVKa0l+UwurhScA4Utf8ax72j69wT?=
 =?us-ascii?Q?ECpjH6FdTGNbFX3g8Z3XPP7LV6V+vmFLCeLXYMof9QhN1hhIpTkFGQWf/DKc?=
 =?us-ascii?Q?tl20tGNUp9wbPwjLoCqJPu8qFmfoN2Ud9DqqeRAmSataJ4QC8DQDyL5kaoLn?=
 =?us-ascii?Q?t3JzwMd0+vPHfN8ftxCrE2p87/AOxhwg7o+4dn/NXcgR7ayV0mpw3eufhEJ9?=
 =?us-ascii?Q?UV9ubtAqQfsMRJjcrBq0m9rsttqR8R561xH51BlufMi6a1+gqIB5PVjGVCeu?=
 =?us-ascii?Q?Vtp6OTwHOT5YG9xG0SOWCJjpNWL4aK6C0BhbWLzu7Lmpm89LdL/BBvYwu1JK?=
 =?us-ascii?Q?7foV7vf/u4JYSwBvNsjD5fh2MLbUNeZVlnnP9VSwrr130zrCK5sVwSXtXVnH?=
 =?us-ascii?Q?462vXk3nW09L4RjO3A9jhfOsiQVv/5tvg5QipQs/ulzqV0kZvYVtu7NjYl0m?=
 =?us-ascii?Q?U37pvRp32pgUrFo3MTfy0RVDalRiJOKteuCcOJJ/tWQoLmPctuGi1BzGYBxz?=
 =?us-ascii?Q?xidQQt0Pq/y4dTrt7XrAMY3ynae2XDVy1ZPJvaxqsdDaDD8kPrk0IFSbfAA0?=
 =?us-ascii?Q?LHkNUCY0RHSH1rbghRV2MXAuA+y0W9jOwZDwveyNBBFz9RaZ9mC9nP3OTPZ5?=
 =?us-ascii?Q?TrqF+9EJQTffqp2g+Sc7BrJWj+n9otVbQOQXk6FYic/y1ZvsUC5POjlNlG0+?=
 =?us-ascii?Q?BEKU3S78eK5hMyuKG6XSwDDucrLeZCAbwoWiJRltuNNbeEFPbKPT6k/MeUaW?=
 =?us-ascii?Q?YK7uUI4VXWqKM2A1f+vYcpMm0RosT66YeODKqcxbbXs5Df2D7pLQkJfNVglf?=
 =?us-ascii?Q?0Mo3kqwx5Km1H8HlCQw6H4xucIlkModj3CLFJ0+yeR6+YlZZm1h4XIKqdgaO?=
 =?us-ascii?Q?FtWxx+jJTpZQnAGC0hVyBwCW4ov9Pjqe17FRMb2x?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 5280657d-157e-4d2a-01fe-08db30945428
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 20:29:42.9892
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OW91EWiKvIcSqZU3nd+O3xgvkCKpbmDHoWcdKW2ORghPi05BwA45MQp/2bu/aDy4Pj7jVbhAcY45B+x+2zC1cA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO6P265MB5984
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Mar 2023 20:40:19 +0900
Asahi Lina <lina@asahilina.net> wrote:

> Now that we have the uapi crate, this abstraction can use that instead
> of bindings.

These functions really just reflect macros in uapi ioctl.h, maybe
these should just be part of the uapi crate?

Best,
Gary

> 
> Signed-off-by: Asahi Lina <lina@asahilina.net>
> ---
>  rust/kernel/ioctl.rs | 32 ++++++++++++++++----------------
>  1 file changed, 16 insertions(+), 16 deletions(-)
> 
> diff --git a/rust/kernel/ioctl.rs b/rust/kernel/ioctl.rs
> index b2076113b6a8..007437959395 100644
> --- a/rust/kernel/ioctl.rs
> +++ b/rust/kernel/ioctl.rs
> @@ -10,40 +10,40 @@ use crate::build_assert;
>  /// Build an ioctl number, analogous to the C macro of the same name.
>  #[inline(always)]
>  const fn _IOC(dir: u32, ty: u32, nr: u32, size: usize) -> u32 {
> -    build_assert!(dir <= bindings::_IOC_DIRMASK);
> -    build_assert!(ty <= bindings::_IOC_TYPEMASK);
> -    build_assert!(nr <= bindings::_IOC_NRMASK);
> -    build_assert!(size <= (bindings::_IOC_SIZEMASK as usize));
> +    build_assert!(dir <= uapi::_IOC_DIRMASK);
> +    build_assert!(ty <= uapi::_IOC_TYPEMASK);
> +    build_assert!(nr <= uapi::_IOC_NRMASK);
> +    build_assert!(size <= (uapi::_IOC_SIZEMASK as usize));
>  
> -    (dir << bindings::_IOC_DIRSHIFT)
> -        | (ty << bindings::_IOC_TYPESHIFT)
> -        | (nr << bindings::_IOC_NRSHIFT)
> -        | ((size as u32) << bindings::_IOC_SIZESHIFT)
> +    (dir << uapi::_IOC_DIRSHIFT)
> +        | (ty << uapi::_IOC_TYPESHIFT)
> +        | (nr << uapi::_IOC_NRSHIFT)
> +        | ((size as u32) << uapi::_IOC_SIZESHIFT)
>  }
>  
>  /// Build an ioctl number for an argumentless ioctl.
>  #[inline(always)]
>  pub const fn _IO(ty: u32, nr: u32) -> u32 {
> -    _IOC(bindings::_IOC_NONE, ty, nr, 0)
> +    _IOC(uapi::_IOC_NONE, ty, nr, 0)
>  }
>  
>  /// Build an ioctl number for an read-only ioctl.
>  #[inline(always)]
>  pub const fn _IOR<T>(ty: u32, nr: u32) -> u32 {
> -    _IOC(bindings::_IOC_READ, ty, nr, core::mem::size_of::<T>())
> +    _IOC(uapi::_IOC_READ, ty, nr, core::mem::size_of::<T>())
>  }
>  
>  /// Build an ioctl number for an write-only ioctl.
>  #[inline(always)]
>  pub const fn _IOW<T>(ty: u32, nr: u32) -> u32 {
> -    _IOC(bindings::_IOC_WRITE, ty, nr, core::mem::size_of::<T>())
> +    _IOC(uapi::_IOC_WRITE, ty, nr, core::mem::size_of::<T>())
>  }
>  
>  /// Build an ioctl number for a read-write ioctl.
>  #[inline(always)]
>  pub const fn _IOWR<T>(ty: u32, nr: u32) -> u32 {
>      _IOC(
> -        bindings::_IOC_READ | bindings::_IOC_WRITE,
> +        uapi::_IOC_READ | uapi::_IOC_WRITE,
>          ty,
>          nr,
>          core::mem::size_of::<T>(),
> @@ -52,20 +52,20 @@ pub const fn _IOWR<T>(ty: u32, nr: u32) -> u32 {
>  
>  /// Get the ioctl direction from an ioctl number.
>  pub const fn _IOC_DIR(nr: u32) -> u32 {
> -    (nr >> bindings::_IOC_DIRSHIFT) & bindings::_IOC_DIRMASK
> +    (nr >> uapi::_IOC_DIRSHIFT) & uapi::_IOC_DIRMASK
>  }
>  
>  /// Get the ioctl type from an ioctl number.
>  pub const fn _IOC_TYPE(nr: u32) -> u32 {
> -    (nr >> bindings::_IOC_TYPESHIFT) & bindings::_IOC_TYPEMASK
> +    (nr >> uapi::_IOC_TYPESHIFT) & uapi::_IOC_TYPEMASK
>  }
>  
>  /// Get the ioctl number from an ioctl number.
>  pub const fn _IOC_NR(nr: u32) -> u32 {
> -    (nr >> bindings::_IOC_NRSHIFT) & bindings::_IOC_NRMASK
> +    (nr >> uapi::_IOC_NRSHIFT) & uapi::_IOC_NRMASK
>  }
>  
>  /// Get the ioctl size from an ioctl number.
>  pub const fn _IOC_SIZE(nr: u32) -> usize {
> -    ((nr >> bindings::_IOC_SIZESHIFT) & bindings::_IOC_SIZEMASK) as usize
> +    ((nr >> uapi::_IOC_SIZESHIFT) & uapi::_IOC_SIZEMASK) as usize
>  }
> 

