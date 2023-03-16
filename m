Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4FC46BD744
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 18:39:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbjCPRj2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 13:39:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230123AbjCPRjO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 13:39:14 -0400
Received: from GBR01-CWL-obe.outbound.protection.outlook.com (mail-cwlgbr01on2136.outbound.protection.outlook.com [40.107.11.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A293E2536;
        Thu, 16 Mar 2023 10:38:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IE/IOYVC6S8ME266H7hYzi6F/2r7KpJz5yvyiADR8fYb+cusUvMPiLPHzgEi0RuMMGrEmP2n6aWv4hZ8fT8aUN44GtqmLtGzaX+KlglOa5IWZFxg8Jt/wzOQvs56g6sDh+nD+X1u8uEWM7fx1AJzCfpybUtkD+uJXR6qQDoW2VweKDSFGUSx+81LhPT0QOswjO4HVOJdFkcOCm1Pev6l3CTODQOrcNcrdZ/ponWTbr2y4p+5CGamPvlCIdEqpSvmwTdyQCkYMVdiGQ5UmpP0BHHMMPE9SFWMq6y7BJBeCBaZypIoiZdeVyKpgIkCUd/ENSU1lzxyOlmHWCgdwHIt6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IS97sT05ZBg2aMy8byrSb6hopK9iFccuHMFDBlgJBi8=;
 b=LD4/HlWFFMndbR62ZIW5Ks09vluv7jU7ON+Tu/XQm5+MEQu6tZxT2A/Y8Msbejm4qYRVotFIHvg+Kb8uloaQyThLUbHFWTD1fuWd4fzbYMC3Z9deJWDMeLVu+UAXCs3VnPRBXSmc+MRU4kkd+IAkCc/Yf1yMWpEtXTW+sL8+5hzvtFbkKxG+oOhCZYayZ3ZQDN9QCjMgBZrXcQJmJhJ4V1z5qHI95kHBVOYb9msR/BjxDEXgmG8NMuLwogIl0jzeq21LpKmXL5F28SWzbUUXxf0dx6ZI1+dzcsZ58W2fxnreaHj79ry+c45qSUdvsz4LRdpcvebKf5vYcR7/jbuW1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IS97sT05ZBg2aMy8byrSb6hopK9iFccuHMFDBlgJBi8=;
 b=emPhyQx79BLJ066bWEGShxzExUOH/ETZ50AwJXNV+Aoy26qa2qOaokTL4sZH1z/AuE6BCmZH8nH3N5SqoYi2zoCp17BFkW02HpJuTNtIONTyUXht4iERYFlEY+ryd7b9J/UXa4AnunULwjZ986cFPsGy+/pb2UeW6py5Z4k5HCs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LO0P265MB5731.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:264::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.31; Thu, 16 Mar
 2023 17:38:50 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::2f2a:55d4:ea1d:dece]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::2f2a:55d4:ea1d:dece%3]) with mapi id 15.20.6178.031; Thu, 16 Mar 2023
 17:38:49 +0000
Date:   Thu, 16 Mar 2023 17:38:48 +0000
From:   Gary Guo <gary@garyguo.net>
To:     y86-dev <y86-dev@protonmail.com>
Cc:     "ojeda@kernel.org" <ojeda@kernel.org>,
        "alex.gaynor@gmail.com" <alex.gaynor@gmail.com>,
        "wedsonaf@gmail.com" <wedsonaf@gmail.com>,
        "boqun.feng@gmail.com" <boqun.feng@gmail.com>,
        "bjorn3_gh@protonmail.com" <bjorn3_gh@protonmail.com>,
        "rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: Re: [PATCH v1 2/3] rust: add pin-init API
Message-ID: <20230316173848.18b45232.gary@garyguo.net>
In-Reply-To: <ct76zcR4JhAXHG90VDfewAmzPJmEHhMvvOf-MejsM_uZsdcsBs9qVLJNYvNvTHOBLlOedgQ4Dm16M2DSDRBIF-olZfq2zp4XboRsCxsm3CA=@protonmail.com>
References: <D0mWM1KEcWLeFa7IIqPygHlXRTD6gRFHvJKaegYzQXo9zTx7YbSpVLeYLFfq53s2S30Wx7v0khkPMOy6Ng5HiNZ5x7TXtOyLB58vUHtq6ro=@protonmail.com>
        <20230315200722.57487341.gary@garyguo.net>
        <ct76zcR4JhAXHG90VDfewAmzPJmEHhMvvOf-MejsM_uZsdcsBs9qVLJNYvNvTHOBLlOedgQ4Dm16M2DSDRBIF-olZfq2zp4XboRsCxsm3CA=@protonmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0024.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ae::19) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LO0P265MB5731:EE_
X-MS-Office365-Filtering-Correlation-Id: d1c1d3fc-b35d-4e4b-fb35-08db26454d82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t+1svFOJJ1g/89z32YHUxd+GAePSNpXr+kPQgvCzvs404vwdsSgh1a+DVhy3E2R/8Fu4AKLPSmgae9785RUUklm8DqT25DJ7DTYibw9NLFBKXVodciv/O0PsQ2VcT0d9FrA4G53nMcX5vjKDkBfpj1H6EeQeuemtIbQrnERbL935iEsM6sNZaJ2bvl9JJepbpfg6HfHHloJQleXxDAM80B+bncYrxjcnIukGfocSeER/KqZKMZ/8mJCXra76NK9jZdszwkMnVPZQKybWDWyTm7EgtmaTXlbRmKBqiZkBo5GugGw96WMIMyFPhtNWztfv/t3ikWGhymtFqB9nKDMqVZHZPqVYDXK5zvQIs8mPCXp0EPLiXPyUfnzM2LkY3+prQZyf2Xqprb4a1ZPSrHoDSrz9pGUbQD+mqvGDVtwdRsjdLajUObjDpldAsXwKZKYD8TsdqXl9X0Pcdeuqaq80PBWmBwhUdBkpiw+IV2jwZzHXIQEpgNhAe/29dR0anyJfB1a4vWt2Jg7JBc7P5jse8smeenkiAu1rpCr+x7IXVL2VzpBCG29CYJ/wP1prOCq/KquVtjQsYvJ1aZn6vr7cir12KsMOwl3GffwIPsrE+Qimto2JfFOxPa+FelSUA1mUxL0uUKyDITNpHY6Vcb/Iag==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(39830400003)(136003)(376002)(396003)(366004)(346002)(451199018)(36756003)(86362001)(2906002)(38100700002)(5660300002)(41300700001)(8936002)(26005)(1076003)(2616005)(6512007)(186003)(6506007)(4326008)(316002)(54906003)(83380400001)(66476007)(6486002)(6916009)(66556008)(66946007)(8676002)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6jyGMqTTZ9+XPMkaIrRO6Bf+24fr7IjeE5lvxjqhhNmn9ujxzVuvgmvxOF86?=
 =?us-ascii?Q?JL+VoQkivhZ4COW2p7AOAtOZVZQx/UoMZJiR1sWENF4YZjNq4Ram625CDnEW?=
 =?us-ascii?Q?P2sdIDtiFh19gGIzyvUAdESfWZKx8D7a/zbpQYLPXqSr1ZIlcF9CswNkypLx?=
 =?us-ascii?Q?ZfNmb5Dg/dKIvFLnPkxmyhNiActxgwTDXhvNTcZsg8em+O1pUKOz1CQt1Gqi?=
 =?us-ascii?Q?TnUPdEbrkP16llSz1iSaV71x5rBDOfEc+a8261+SLjrjzPFgLBQ7euucIA8e?=
 =?us-ascii?Q?Wx0R+Yp2+V00i1Cq65soaYnSxn1QoFP3yDg+fJfyfqKdMAuzDnDH71P/ebs1?=
 =?us-ascii?Q?ABtXiBHBGvMJmtd3CKkAUPfPsFJeo1rMCibR1CASXS87snQ7RY7zb18H+Tbk?=
 =?us-ascii?Q?x83Wtxy9ov172yeW6vVVlxEYoshQPDzXzT3dwXP7qnyhd8RNCBoF2gBYgIlQ?=
 =?us-ascii?Q?y3st0HE4HcBBdIIDLHGJv4sseG7L06MDP6o5eKYvJwvLeIHuYRT/CUrFicK7?=
 =?us-ascii?Q?AhklNBNnVStOH0Br3YDMeNrGPySFbmbor2cWut6PI2Z3+lrmpY00yq/2OXSO?=
 =?us-ascii?Q?wU4yj85Wn32SDRzuF+jgHBWXTa2ksYDCe/jKL0rfeyA9lBofbaUZvvnJ0hEv?=
 =?us-ascii?Q?jBqjpmIb7DaPSGeb/Mu7dD3NqTZJIOzyKILN5RLSDn4mZu5RJlDypnuQlYTs?=
 =?us-ascii?Q?ZnnyEmWlCDEk4HJoM8e4o+u/4XikiV5WhO5E+EEL4q8wq8OKlwICbF5vfE4a?=
 =?us-ascii?Q?6DJPD8Z7SbPgv85vftNyz/VPANzQKS14TBQ/DcvjrsD5fqwzuFkFwq36PSgX?=
 =?us-ascii?Q?CRJ9Y1jmmjhkzGfn/oCd4GsetcR1hlPsRMJpgIigyEUrE0/cBKEraJCiVrnA?=
 =?us-ascii?Q?55HEoQJGEaSoNvrF9JRKYBK8ZxMC2hFDRqP9rDDLVP9IfE1VrEF3zlseGrE+?=
 =?us-ascii?Q?Nh1r2GF9GIxEMda/g534lyplMIpgdOmzc6KOWKhGfgSGcjDb4O6OYrm3tSKW?=
 =?us-ascii?Q?2KNlt2DR/JgUNTrhRFTpTjzjc2AaJetTrx0URS2xrW4wJyPoLE+ZhOHS/leG?=
 =?us-ascii?Q?Pac8ITO0XFd1c+MfM7mVoCOpKA6l3NwCyQwpZ6Z/J48BkxUT5m4GJK3Kptyx?=
 =?us-ascii?Q?07jOM1jw+CtaTxQi8DUmVmtIQRGZ4igcHzdYC6AhKij+67uN2DqR5xZITSHe?=
 =?us-ascii?Q?jt50EVcauLZNfhzTNhOD4kjyUeA5r6UDp2PkaOFD7NvDUxYkljDs30jea2em?=
 =?us-ascii?Q?gDVP/vM3J1qsrwqoBi9xkn0GSvE7iwDm6SHcg2h74r7FEQPgkJlq+3jQqcWC?=
 =?us-ascii?Q?NZkzPWLfn9KY1Sbw2rqRDa+CU3WBEkL/4dIBcAQD/LcCsKhlJun3N3nrb+xb?=
 =?us-ascii?Q?Yym72n0aVMpCIcptOLehUJmPt2PLZet8slRisAWh18fbK1hT2HqbueF6lbhP?=
 =?us-ascii?Q?d/+uCly4G1rUkydStOD2C5OnSmG0l7J4tj5cw57Y3uu9kICZDwHV/hVzDgX6?=
 =?us-ascii?Q?opqePcaIBqdgP51xRJkDXyMTWV/bXkIWgNam+qUAohU5tS/IKyACdubjvc6H?=
 =?us-ascii?Q?Xy5/2GC7eQb/FZRa7JF87pRP5CysSu+i1tcDIssz?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: d1c1d3fc-b35d-4e4b-fb35-08db26454d82
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2023 17:38:49.9491
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2FCanFeJW39p95H0vEsceP/R5/PEFuzM9o3kUZB/I0v0YfPrIwI6HfAe3zXmZKrVWhGJiMmKl3B8Uf26gShYcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P265MB5731
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Mar 2023 09:38:16 +0000
y86-dev <y86-dev@protonmail.com> wrote:

> > > +
> > > +/// Trait facilitating pinned destruction.
> > > +///
> > > +/// Use [`pinned_drop`] to implement this trait safely:
> > > +///
> > > +/// ```rust
> > > +/// # use kernel::sync::Mutex;
> > > +/// use kernel::macros::pinned_drop;
> > > +/// use core::pin::Pin;
> > > +/// #[pin_data(PinnedDrop)]
> > > +/// struct Foo {
> > > +///     #[pin]
> > > +///     mtx: Mutex<usize>,
> > > +/// }
> > > +///
> > > +/// #[pinned_drop]
> > > +/// impl PinnedDrop for Foo {
> > > +///     fn drop(self: Pin<&mut Self>) {
> > > +///         pr_info!("Foo is being dropped!");
> > > +///     }
> > > +/// }
> > > +/// ```
> > > +///
> > > +/// # Safety
> > > +///
> > > +/// This trait must be implemented with [`pinned_drop`].
> > > +///
> > > +/// [`pinned_drop`]: kernel::macros::pinned_drop
> > > +pub unsafe trait PinnedDrop: __PinData {
> > > +    /// Executes the pinned destructor of this type.
> > > +    ///
> > > +    /// # Safety
> > > +    ///
> > > +    /// Only call this from `<Self as Drop>::drop`.
> > > +    unsafe fn drop(self: Pin<&mut Self>);
> > > +
> > > +    // Used by the `pinned_drop` proc-macro to ensure that only safe operations are used in `drop`.
> > > +    // the function should not be called.
> > > +    #[doc(hidden)]
> > > +    fn __ensure_no_unsafe_op_in_drop(self: Pin<&mut Self>);  
> >
> > One idea to avoid this extra function is to have an unsafe token to the
> > drop function.
> >
> > fn drop(self: Pin<&mut Self>, token: TokenThatCanOnlyBeCreatedUnsafely);  
> 
> What is wrong with having this extra function? If the problem is that this
> function might be called, then we could add a parameter with an
> unconstructable type.
> 
> I think that `drop` should be `unsafe`, since it really does have
> the requirement of only being called in the normal drop impl.

The point to avoid having two functions with the same body. This would
require double the amount of checks needed by the compiler (and make
error message worth if anything's wrong in the body of `drop`).

This current approach is really just a hack to avoid code from doing
unsafe stuff without using `unsafe` block -- and the best solution is
just to avoid make `drop` function unsafe. However we don't want drop
function to be actually called from safe code, and that's the point of
a token that can only be created unsafely is force `drop` to *not* be
called by safe code. The token is a proof that `unsafe` is being used.

This way the `__ensure_no_unsafe_op_in_drop` function would not be
needed.

> 
> > > +}
> > > +
> > > +/// Smart pointer that can initialize memory in-place.
> > > +pub trait InPlaceInit<T>: Sized {
> > > +    /// Use the given initializer to in-place initialize a `T`.
> > > +    ///
> > > +    /// If `T: !Unpin` it will not be able to move afterwards.
> > > +    fn pin_init<E>(init: impl PinInit<T, E>) -> error::Result<Pin<Self>>
> > > +    where
> > > +        Error: From<E>;
> > > +
> > > +    /// Use the given initializer to in-place initialize a `T`.
> > > +    fn init<E>(init: impl Init<T, E>) -> error::Result<Self>
> > > +    where
> > > +        Error: From<E>;
> > > +}  
> >
> > Is this trait used? Or the methods could be inherent methods?  
> 
> I need an extension trait for `Box`, since it is inside of the `alloc`
> crate and so I figured that I might as well use it for other types. I do
> not think we can avoid the extension trait for `Box`, but I could make the
> functions for `UniqueArc` inherent. What do you think?

Good point, I forget about `Box`.

> 
> > > +/// An initializer that leaves the memory uninitialized.
> > > +///
> > > +/// The initializer is a no-op. The `slot` memory is not changed.
> > > +#[inline]
> > > +pub fn uninit<T>() -> impl Init<MaybeUninit<T>> {
> > > +    // SAFETY: The memory is allowed to be uninitialized.
> > > +    unsafe { init_from_closure(|_| Ok(())) }
> > > +}  
> >
> > Do you think there's a value to have a `Uninitable` which is
> > implemented for both `MaybeUninit` and `Opaque`?  
> 
> If we really need it for `Opaque`, then it probably should be an inherent
> function. I do not really see additional use for an `Uninitable` trait.

Fair.

> > > +// This trait is only implemented via the `#[pin_data]` proc-macro. It is used to facilitate
> > > +// the pin projections within the initializers.
> > > +#[doc(hidden)]
> > > +pub unsafe trait __PinData {
> > > +    type __PinData;
> > > +}
> > > +
> > > +/// Stack initializer helper type. Use [`stack_pin_init`] instead of this primitive.  
> >
> > `#[doc(hidden)]`?  
> 
> This trait is implementation detail of the `#[pin_data]` macro. Why should
> it be visible in the rust-docs?

I am commenting about `stack_pin_init` (note the doc comment above my
comment). `StackInit` is an implementation detail of `stack_pin_init`
and shouldn't be exposed, IMO. Or do you think manual use of
`StackInit` is needed?

Best,
Gary
