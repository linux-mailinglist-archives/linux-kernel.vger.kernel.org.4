Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58F566A25E4
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Feb 2023 01:43:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbjBYAnr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 19:43:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjBYAnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 19:43:45 -0500
Received: from GBR01-CWL-obe.outbound.protection.outlook.com (mail-cwlgbr01on2116.outbound.protection.outlook.com [40.107.11.116])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9422513D79;
        Fri, 24 Feb 2023 16:43:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vgl2LSybHggyWjBEgjjf2Tf+aC2brv/2sFKNo+dVHVHUz7az82LnlGNUhrtj+QDXLxSyqkv6Co68GEnk3qi/Ojn5uHp3AjiJEsAYj9UlkLcoxGz0WRfAmfWjAuwq7U/SCCUgHITTiC8sJ9V/ixBzLIuZpVEe1DTVEhStu0KYj1jvagF3LCx1cwS4S8PXygb8tVLSVV5ec3K4tOkTjZjNnP//l6U7CpBS3pDWvXmNZHGhJi2R3g2Eq9c8UCphQu/U2ey4mWJRKxwe8bTFwPIzbvW0CY+8JBtAcC8uqTlJoe7LEczOoGFyPxFbhOn700QrEkT9FYSv8fOZ/nOiXUxvuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=blVag8d3Y+Ujl/nLjB/6DMUFfQCCcwID+Sos8aZ01aI=;
 b=dzcpnl8YCLb5SVCJ/sPWdABm/muhETjRLd5N2iC+X2++Vk8Yie0rFVm7sEv/AePedcnpovpWbaOPRhXvzyf4HvBRVI8khPP5JM4TFpnX7p2RBs6Zkb2MpE9OC+tWC8D33gh0eMKDVrwx/DnGLRBeidSoUmKyTjRtitZLA5WWTBfQgIxJkYZLWpIvgJXemzJJ7/VDrP2QLvqiD4Fd0GJxZd+0nLc+boeu+4c4ijEegNwAik37qoh8a82niORyQDrK+9lSqLacpwmvpV9T9XoYSbXfhTJPsEO9wKqKfkTyOYxn0EE8n+wp0EVT5dHqernEsz7DdriymjwS8vPw7GsJJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=blVag8d3Y+Ujl/nLjB/6DMUFfQCCcwID+Sos8aZ01aI=;
 b=fMC43lBRu9G0vu3XyaA3mDrzQS1MTCFvSOPjSQFYojGizi4Nx2+SDeS5zUUSOdlp2AGdLKuoOFCTWtDvAgX7GAQxjVZewwZYoqVeGlp6z/yWkchXEbsib0iD0PXyr6TVQYzEAjBLQ6G5qdfKwook8QU/+kLBsnZSTLhHBlvJeiE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by CWLP265MB5379.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1c7::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.24; Sat, 25 Feb
 2023 00:43:41 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::2f2a:55d4:ea1d:dece]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::2f2a:55d4:ea1d:dece%4]) with mapi id 15.20.6134.021; Sat, 25 Feb 2023
 00:43:41 +0000
Date:   Sat, 25 Feb 2023 00:43:40 +0000
From:   Gary Guo <gary@garyguo.net>
To:     Asahi Lina <lina@asahilina.net>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        =?UTF-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        asahi@lists.linux.dev
Subject: Re: [PATCH 1/2] rust: sync: arc: implement Arc<dyn Any + Send +
 Sync>::downcast()
Message-ID: <20230225004340.3957288e.gary@garyguo.net>
In-Reply-To: <20230224-rust-arc-v1-1-568eea613a41@asahilina.net>
References: <20230224-rust-arc-v1-0-568eea613a41@asahilina.net>
        <20230224-rust-arc-v1-1-568eea613a41@asahilina.net>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO3P265CA0026.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:387::9) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|CWLP265MB5379:EE_
X-MS-Office365-Filtering-Correlation-Id: d141fef4-d5f7-476c-2f8c-08db16c95779
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OJ34fvK2umQWRCMLbVxsB7+s+4I8nEo4q3RTfF+KG8mprjUhsBcdyc09ewoRel+hxD5aqdy6oGI98oj076rAezJi5i3Cy2gEgpdsLZYyvWeRl20d+In9n7C0vyECU2xU3stB1MJTLz4QoNmDWlhbd0lsXQOmcBLrWpJ7IyRo/SX4wn643Y7TGDSED3KlILYbeii/pZZ+JmXQydtKCFr4B6VemVffAWNKxFypSrqdaPB3szBc6MkStGpuihO5jlY5YXtry47YRrUIzIxg4wBn7ZTHlEv7+3w1ymbydqkHYHYrteZuPIZd8nlK+scNvFViw8yYegF+qoQbanO3gHc1d+0UM6CpQ+H+gwEftQ4TW9Q20AwFj0m44Qm8cpoPZ7DsqtJmF1Us7KGvja7EuGWZI5wkAj6wppHi46FGM4RhXAGkj9zBBRBFC8Cu43azx5voYGHugtrkkmFcnrUPu/+jOkW9hhqmtjsPJLvfk22k6cz9KyahvPmm6IasTiVe/tI6rYgsBaVpc4xa0TX4tzNwF92chtiaY7BGwTnAsoWqjj9pVgEY6FpiI/rn0vGCVYyegAeZLq90GWuTLzkRvdv+YwkgiUlfXv/oKIX9J/iIf/QMK2S5hNNgqnEKeu+eWg6i
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(366004)(39830400003)(376002)(136003)(346002)(396003)(451199018)(5660300002)(54906003)(66556008)(66476007)(66946007)(316002)(478600001)(8936002)(6916009)(8676002)(2906002)(41300700001)(4326008)(966005)(6486002)(6512007)(1076003)(6506007)(38100700002)(186003)(26005)(2616005)(36756003)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?E4WoAF+46I/gLZrtEh9vHLEghc526+JfcmwHJFrKdZIqsRgp2XedcTFQeQgB?=
 =?us-ascii?Q?UYbktKh5sO2n5PLGSMvxfwJMWTvEfRuTCYPmdOVWXKQLQ3f0lEwVxMNYAz/f?=
 =?us-ascii?Q?eKtoRlo5YSc3MyU2YX58mmsUeyDJ+AWJ+8mrmeqWqJa7u+HoebuB936ocEKa?=
 =?us-ascii?Q?p793FkARSfIRWyXbru32mnREBRhLIyvghERD+JlskcaYNQ7oqg3ZSvMdiKkA?=
 =?us-ascii?Q?lOf0eTWld00fBgr7Lesiid/mz9FNe4yokxLmDmS5MYVMslJvSXyVqBQhBo3C?=
 =?us-ascii?Q?0CL3naPqpNrE82HSFCQR+u2p0YwWUjl75Y5CASef5jiCLW+RKmss7ByPylOI?=
 =?us-ascii?Q?mxIx4oO+V8kbb5P7wyoRWhxQHp1CEwvtqxhe1Z5Fl8tQq1/94maSm95gBXom?=
 =?us-ascii?Q?ghg1YAi0B2IE3kmPeV2uQQOt3HydbUk6xhKJyliUT2FyRvx79fsZVBjCDuKt?=
 =?us-ascii?Q?XnGTfOnAXWxWbxOcpcNPXaA6Kam1MJ+D3O36yz3eMNZHZ6YsiZCip0G6GyLi?=
 =?us-ascii?Q?LlyssnbZvSvS/k3Q3cGK/HKpXozkESYpyz2azT6QWuSKemJRRd+/gRkPwOVL?=
 =?us-ascii?Q?Kz13q++F2CKjFMi/UvnRAgYE4gCTvjSkxq8ZoK/6HJzmezgW1V9IXiYJPmZ7?=
 =?us-ascii?Q?M+Do8iys+lGc16Xxgap3ZmrZY2a7oq5zC9rnNyRQjkMhSdumxkpewuk5Y6X1?=
 =?us-ascii?Q?xK7VpDb5FfKirX5sj5YVNglJZX4J67F3a3rHjViRl90/N48NhnOdV0U/9f0G?=
 =?us-ascii?Q?I177xzVesfuq1a9gc6F8DtVZMPdS9+EQos2qFFZMsQQ9f2iQdKUBT3GrBRre?=
 =?us-ascii?Q?vn2e1WaMGrZZ2JMx7001OVryN/yfPY8LlZKiiTBa3vywqXw1qsnzU48izCoi?=
 =?us-ascii?Q?xODZ6r7mFBWKIZSFnwamuZB3aIF1BaqQz8ZbfxijLGi8RzbWAgeOaci8O+jI?=
 =?us-ascii?Q?Y43CFRLxdeDYECODQYXDR6B4HpF3i2MsTSi1r4VJgWN8AT3aCwdoyr/kq2yg?=
 =?us-ascii?Q?c1yM+pszGgDB6RhQvVNuxDOxqWX3o6ZHBXsB+wkxaypZ+mml04yOIGLU+XEZ?=
 =?us-ascii?Q?5XD0Auko4weIDs5loAWQp+p6+yxek3GrJv5zMxbH6JL7FSmIr/0kMBQQ4lrw?=
 =?us-ascii?Q?aZiwodpyWQn7M0tVTds5ACRfvv2pSN/p77rxey90//aW5B+wQCHHhQg31i8Z?=
 =?us-ascii?Q?Z8fHAqKmfsE6eYl5/bhWhjaFfiFZ3Nr9F+9Ldm2xsI2NfRZSBpI7rOknYmeH?=
 =?us-ascii?Q?XRW13BX5SLrn4veYDxR6c71A5cl5q0njobj0VZmRol4/ra4B+nf9tuk/DO+l?=
 =?us-ascii?Q?mE/aObv3FJfRpFWxW6NdjmU9X0HQNoJak852WufDi7euk+cSmglgX4a87U5a?=
 =?us-ascii?Q?8t1yo9I7WUE/zEoLtzQ5N9hAjbyStIBINSvAiduScQQbSMOP/cgWbHn3DlV9?=
 =?us-ascii?Q?A6za/lHZ+AtoPtUnP7f4J7xXfDVhu/6oW/T94XpKaXU5fJBnvtyvokqoYtHh?=
 =?us-ascii?Q?nj8faXfUE/PKuPQsEaNflvM81bNDjcxUdOckpTOiAEkFC9Sa0kmguf+3+bCq?=
 =?us-ascii?Q?QpHZ+5qaRirREo+0GY8w+c55u54mUijDBzD/TpM1?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: d141fef4-d5f7-476c-2f8c-08db16c95779
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2023 00:43:41.5912
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pNCg09CaJWSx2b3oKSY2EyGKUdPNWiyJsXVbRtk+BE/PhlWXMv9iV7Xy9BkdsvITNhXH2muTSpdji/R691mPVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB5379
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Feb 2023 16:59:33 +0900
Asahi Lina <lina@asahilina.net> wrote:

> This mirrors the standard library's alloc::sync::Arc::downcast().
> 
> Based on the Rust standard library implementation, ver 1.62.0,
> licensed under "Apache-2.0 OR MIT", from:
> 
>     https://github.com/rust-lang/rust/tree/1.62.0/library/alloc/src
> 
> For copyright details, please see:
> 
>     https://github.com/rust-lang/rust/blob/1.62.0/COPYRIGHT
> 
> Signed-off-by: Asahi Lina <lina@asahilina.net>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  rust/kernel/sync/arc.rs | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
> index a94e303217c6..752bd7c4699e 100644
> --- a/rust/kernel/sync/arc.rs
> +++ b/rust/kernel/sync/arc.rs
> @@ -22,6 +22,7 @@ use crate::{
>  };
>  use alloc::boxed::Box;
>  use core::{
> +    any::Any,
>      fmt,
>      marker::{PhantomData, Unsize},
>      mem::{ManuallyDrop, MaybeUninit},
> @@ -220,6 +221,27 @@ impl<T: 'static> ForeignOwnable for Arc<T> {
>      }
>  }
>  
> +impl Arc<dyn Any + Send + Sync> {
> +    /// Attempt to downcast the `Arc<dyn Any + Send + Sync>` to a concrete type.
> +    // Based on the Rust standard library implementation, ver 1.62.0, which is
> +    // Apache-2.0 OR MIT.
> +    pub fn downcast<T>(self) -> core::result::Result<Arc<T>, Self>
> +    where
> +        T: Any + Send + Sync,
> +    {
> +        if (*self).is::<T>() {
> +            // SAFETY: We have just checked that the type is correct, so we can cast the pointer.
> +            unsafe {
> +                let ptr = self.ptr.cast::<ArcInner<T>>();
> +                core::mem::forget(self);
> +                Ok(Arc::from_inner(ptr))
> +            }
> +        } else {
> +            Err(self)
> +        }
> +    }
> +}
> +
>  impl<T: ?Sized> Deref for Arc<T> {
>      type Target = T;
>  
> 

