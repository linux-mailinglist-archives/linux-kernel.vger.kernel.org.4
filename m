Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E02D867E727
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 14:55:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233326AbjA0Nzo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 08:55:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbjA0Nzn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 08:55:43 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2119.outbound.protection.outlook.com [40.107.7.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F576C155;
        Fri, 27 Jan 2023 05:55:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FAL3bGFYAIsCwjFyO6KF8iJ9lch0cVVKavyemVvNE4sZr9TQWSSelwzO8/cbYKC/xV3QGeuABoUh3aH9ZyBCAXmRQF9xwcbUsmDFUFIyIUCLIl74AAHQN1vFGFEHEA/F9pE6PSasqMoTrSL8nDvEVjMsxbWoOpvIeCMWVgpFkya17QXK58Z7TlDEAkAQnuOW/dSqIRtx7zzUGW/s9D93pTTMmc795qDhXvt7j6AQQOgpFgEsthYhkX9uyAvvfQ4crqoTVdo6It+uyDFiKaEQBvkXE7oWZcgy9MF5yP20wsSdV0NulkrmNN7Moyujh0FnnjYTQIZMy7I1ch7O+Djmig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iX0j2/olWgGg7ltIyn2gTlcwW+RhkWXqxRhwzGN8C3U=;
 b=MUe1yu/Pszf4Qm9XlQL81bHFHZ6041fVYiQ9qYLG7otgytgtFfyeW6fS5gDIEfUaRwdlUXSXLsnDpuBi3scoALHnvawIH5SGM8QXHe8mevqq0GiO3+G5e2hGGJN7stiYTmeSObrHJc4xYY4EznSd/9g6mK3ECBjuUgy1lYompDVSfot31R8T70b8QubgLMzAdGg/PAS8DG5KmAU4+unBn0vGQAdApG5s22y+L8UDya1kXQRWoT7Y2sv3VoK/gd6+eKB8XqFny2i60DuX2RiXsQqws4sDTSMPIzW8NVsb23y3Drz3kKMNnhl6P7eKkR8tj8gFTXCKDPPcVXo8EpF80g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iX0j2/olWgGg7ltIyn2gTlcwW+RhkWXqxRhwzGN8C3U=;
 b=rqJBnaAq1pEcE2tJ5x0+8HS0Yp3ZCB4yAN3iaNnzTzeUh/XSwGoz/AzbyoVdmveVo9xsm6nCwwnQnePgYkB+7FqrWEjr0HuzQL73E7Z99BO07u/BuC2qChKlhqF3x7FN4aTOTZa/wkYgXmDd8IsLxbi5iExV7i0P07fTb3D5xSU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by CWLP265MB2340.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:67::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.23; Fri, 27 Jan
 2023 13:55:39 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::b96e:93ad:4043:6145]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::b96e:93ad:4043:6145%9]) with mapi id 15.20.6043.023; Fri, 27 Jan 2023
 13:55:38 +0000
Date:   Fri, 27 Jan 2023 13:55:33 +0000
From:   Gary Guo <gary@garyguo.net>
To:     Wedson Almeida Filho <wedsonaf@gmail.com>
Cc:     rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        =?UTF-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] rust: types: introduce `ForeignOwnable`
Message-ID: <20230127135533.3dfc7440.gary@garyguo.net>
In-Reply-To: <20230119174036.64046-2-wedsonaf@gmail.com>
References: <20230119174036.64046-1-wedsonaf@gmail.com>
        <20230119174036.64046-2-wedsonaf@gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0003.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ad::6) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|CWLP265MB2340:EE_
X-MS-Office365-Filtering-Correlation-Id: b2d32981-d9a1-413b-7155-08db006e2be6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XocB7IMbxQY/xo3G45n8bjjXs752okvUD+RMDfT1UPgVP6EVx0tEohiLcWXKLQh3Mknh6F+KzoLkVOcpsqCyugKxERGIo8w9zOeFWuzVSA0tCztE6fUZyFlVIO8vIjv7Gck9Jf1dyE6ZGPuPSAZuM4de1+MYtZaVZAKnwjfeaohQQXo4ZtoGOct733hDLaHcLkq0WrbXGSbsJuWJuK23aypfrvhsY9tE6//ZtEZNAXmDs0QMHG8OfoOAouz+QQJ52WO4mSGglXdBUhQAdzyl83rtpRbyQC5BoyVX8LpFR21Ghp9WI0XTflacf0KiAe4r2C14ixAQdtGyhZwe5vDzX4f7xuW2lcNNvZomhVG76SWSghEgjcROjkOlU4Hl9TEtbmfYamciagNrfEvecCRmkI5fkqkLXTe+UKqhrycrqV6HiWh1JCzzAqlsgIUzVyqv4r49sn7ArWFtlSSEdil6K1Kl2AHGWxVAfMmAWgE8K3FRoRbhuw7uTGqCQJp5UkFf2GujKAnRGhDqTDLShyDlr9mZ/mc2zkce0/Wcs0i3hGN23VTZyOW2B35xue/qJlE0oVSXVVZb07rGM6RTs86Fma8n641+Cdl82frdMydGNCCeSVMn82bpdRiPOwxE8b7YgxEC6Zr/cH2bbUXpXknIJkkBsgpvK86rF47frAX5mJQ5aijRS7r0AveYvb09dmGI
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(396003)(376002)(136003)(39830400003)(346002)(366004)(451199018)(41300700001)(66476007)(66556008)(83380400001)(86362001)(316002)(38100700002)(2616005)(36756003)(54906003)(8676002)(1076003)(4326008)(66946007)(6506007)(6916009)(6666004)(6512007)(26005)(6486002)(478600001)(186003)(2906002)(8936002)(5660300002)(81973001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cbqTANkTol3U/eW5x2j9GI6I6sVk6E9gmShROTIb94IVhETIon+NnYQ/XeDk?=
 =?us-ascii?Q?zuQ/d6OKLkaZw6Km5C9jPr8ocO9DSwXh81jEtCV+BrJBshZ3/RudYUL5ZRF7?=
 =?us-ascii?Q?luDZBE645ZZCMDn4iXkDxR81pwhfTA+CFNg3l5y0Jc9bc6ox6PsNfl/B6IjM?=
 =?us-ascii?Q?CwXANckAikXJULrsqksjJKQheTHfkdWDMC68YA/g05wsjAVMAecPvI8rIpbl?=
 =?us-ascii?Q?Sr96f9dUOwPvzzxdWvjGKvttgW3Yoin/adQ5XSZcTeacrQxjhYfOU2Da58Em?=
 =?us-ascii?Q?Bc7d+I7IGCUsQ7ZSGH1uh3IkYwAgoi9dbm4MANf1Yw2xlUGBzv0PobDZL2Cf?=
 =?us-ascii?Q?nxgjMWwVoCk2dWlbbVbJG+AkKGbjP9Mfwu+zqn9zuwiqJMv++mOO6LcCStlq?=
 =?us-ascii?Q?HUOMl1Pczp9nseuTDLARFOSXql0GCa1qaViTwLxwn9+xEWxSizE+Pj0Q2eVN?=
 =?us-ascii?Q?cudyDWSx/lXq4ovd/OHByW+PDMPy8AGvhUELBFa9lIxRSrRoql50uadBCjtA?=
 =?us-ascii?Q?nJ2idNr6uAZ06FMJLkuqP7vMozC0WagwbWdTS+ZNQtz7kan/R3+uRMFLF1tU?=
 =?us-ascii?Q?ggfCHnNHDH8D4WI3kqh9nGwrqTxwPbXrfDRtozm6S0qo1X8YQXM2L/4JF202?=
 =?us-ascii?Q?GNMKLoShwlcoKkY6FU7GkZgyfAX9Otu4GTl4mXu8yaZHKHN4GuGTt62NDVFn?=
 =?us-ascii?Q?E4MDuClGjmmwLYG3/TFCzH/75itm9ymo6bJQtvwNQvn1uKqkVFPLuP/olSmz?=
 =?us-ascii?Q?9s8IA3YmSO1q+9tuiUTQePEBL/hHdtnEHuUcmF1X8kXadO/QlfwdcswH+QFG?=
 =?us-ascii?Q?SwGx3Y2Hv2+4LZhRu9K1nsgJtnkd8gHyb1vNglV1zp8ew7RG3hs3gCdndgYy?=
 =?us-ascii?Q?ChmQQdNRMMwX40Uh2yPzEAvjnufQg+jEwXGRHGAi5X8jafNsPEOmeMIV7VjH?=
 =?us-ascii?Q?rUJtaS5XI+rSaIi7K0Qmq9cwURwNBWpxbopIQ+QHqOG5D1IwoFPcA4AFULGs?=
 =?us-ascii?Q?yVwwF0V1AobFC2b4LdA58wc5MtxqR++nc0qcpYbIXWjFhIGaPv0E6bmuCWqR?=
 =?us-ascii?Q?3IDX8l30MSNZj1O+6XYFcAqgp/q2T6dzVRHUX2lMvBY6Dw1ZwlWffmK4ednw?=
 =?us-ascii?Q?iS4M8MLaqjYZ/k1BbHzZf1E8CG7D2TSO5VS+bWAkHuu4jv+Vrk3wHKQqukdy?=
 =?us-ascii?Q?8IqUAsnjTQklJ3vJzuXwcD+7wK/Bj9lSbHVeoM9RqtN+YtysdlUr37q7ZHEI?=
 =?us-ascii?Q?XANYTahjVEAVrdyXf4sTbZZqJMN1HkrGMg/c5b/Ea/+/2YdrfURj1WJP5rPM?=
 =?us-ascii?Q?KMgcvJ9zKtVHvq5vJ2KeUV/5sTSH86G+a5U8TcxJMxE4LT5CREYF01T6Txdy?=
 =?us-ascii?Q?lNoeKOLP3/UMNdiG2F3DSnROW3XkkYykZ5Ux0zh5nYHFsf7A9mb9gJAfETj0?=
 =?us-ascii?Q?1+ffyk5nuOKJSbjq2jzE3v3TmYi47XCu0wNaqixOPrSOdlxuzETT3h9zYLpo?=
 =?us-ascii?Q?yUFGqDfQh2CQ4osRpqxoq6LMXEySzSWJF6o07wTEUjmXOuHhDdYdYS3GCkU9?=
 =?us-ascii?Q?CRFxCsy1C9paB5YD2L9ghbm0fVnoDQ4p7Ue+pvdc?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: b2d32981-d9a1-413b-7155-08db006e2be6
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2023 13:55:38.9419
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LMMgSxMO/zlETaeyogczCa1WW8N70PopyopSROdIKeOar4Ef5dFews9Ca36VPEwhcO65owPfI7AkW9S+3zJKnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB2340
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Jan 2023 14:40:33 -0300
Wedson Almeida Filho <wedsonaf@gmail.com> wrote:

> It was originally called `PointerWrapper`. It is used to convert
> a Rust object to a pointer representation (void *) that can be
> stored on the C side, used, and eventually returned to Rust.
> 
> Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> ---
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
> index f0ad4472292d..5475f6163002 100644
> --- a/rust/kernel/types.rs
> +++ b/rust/kernel/types.rs
> @@ -9,6 +9,60 @@ use core::{
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
> +pub trait ForeignOwnable {
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
> +    unsafe fn borrow_mut<T: ForeignOwnable>(ptr: *const core::ffi::c_void) -> ScopeGuard<T, fn(T)> {

I feel that this should could its own guard (maybe `PointerGuard`?) to
be more semantically meaningful than a `ScopeGuard`.

> +        // SAFETY: The safety requirements ensure that `ptr` came from a previous call to
> +        // `into_foreign`.
> +        ScopeGuard::new_with_data(unsafe { T::from_foreign(ptr) }, |d| {
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

