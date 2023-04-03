Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4741F6D513A
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 21:20:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231530AbjDCTU5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 15:20:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231627AbjDCTUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 15:20:55 -0400
Received: from GBR01-LO2-obe.outbound.protection.outlook.com (mail-lo2gbr01on2100.outbound.protection.outlook.com [40.107.10.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE0EA40E6;
        Mon,  3 Apr 2023 12:20:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a4+BbNyQGBEFS7PoJUWzTYWuCYwM16Ug1haDXPUdbIc21ZCNBU2J5ZoqKKx34+IuBTV6OW00UDA/c3kvxNYRJJ95naJ8H0A+v3KrULIoPlLftieJzNW1vcDkKiJoF/RHVLpZDkyeYcZheeCFOuTq3q37bIW46Mm03n6RVm80yui/AV2LK+HCMgedBtCrR+rEfkr177MpCUEfM6CxcuD2qFh5+8UjV0ZcDCVxf2mMJBWzwNSC9ndC4WEEqiHvk6jkY9IjwPtpYs+30Pc0oV7YFC8RXT8ADO4gzYb2xhLtav1rqNHnUQVYtJLzjhujuzlndtViZ+lNZ6/zJVH+SosRbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hTzI5nnitNAo/mErvZOoPGcXZaGxKaLfamGb4m7gi3c=;
 b=Xrav/5bAZNz/XDFv5qEA32HQWwXq7eyMeQleUFxijiP00LreL3LTEe3IIlSMShaowDrLrtdOlVvoNx79C9zr2sA23QO8AutU8N8za2GiUqurLqlCrpgg1rlfnPxwkvT2PbolGgueTgDMa/IsRcLmcbwSJNWFbH+IWWtuZz9z/7To5QzkjVrwzdONwN2rk2s/Am/AEYvcOkfbi5fPb6WQhHFZHU+tnYCAuy4lhZfLxFpFyGkoTMzOMI2ckdQlwo0G8Fygz9p2E+WfAQlRY89b5LXn1hgbB0WtBLfrpTtnliVqMEfznmeFmRiDA0Ak12Gk8S1DLZTPiLrBKaaN0KI7mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hTzI5nnitNAo/mErvZOoPGcXZaGxKaLfamGb4m7gi3c=;
 b=g1hPTndcc/FNCkfe3ukk4bLR213zSVUgfNpXDsiw0M8lye6ZwjsaS3qVZ//sNn10rq0c+RgaX1wZ9NMianQNu+IZ94Oeci75bLdyKtEJ134F5S8swBDq4GEb5L/V4Ga0o/pwU13rkdf5zMj407X1q/ZKwZzAsm6bS59hLscNTTc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by CWXP265MB2391.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:7c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Mon, 3 Apr
 2023 19:20:18 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::e1a3:5e38:b483:8161]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::e1a3:5e38:b483:8161%5]) with mapi id 15.20.6254.033; Mon, 3 Apr 2023
 19:20:18 +0000
Date:   Mon, 3 Apr 2023 20:20:15 +0100
From:   Gary Guo <gary@garyguo.net>
To:     Alice Ryhl <alice@ryhl.io>
Cc:     Benno Lossin <y86-dev@protonmail.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Alice Ryhl <aliceryhl@google.com>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        =?UTF-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>
Subject: Re: [PATCH v5 11/15] rust: init: add `Zeroable` trait and
 `init::zeroed` function
Message-ID: <20230403202015.22e351bb.gary@garyguo.net>
In-Reply-To: <dc983245-2de9-2aa4-16c3-ae11a8c20b6f@ryhl.io>
References: <20230403154422.168633-1-y86-dev@protonmail.com>
        <20230403160511.174894-4-y86-dev@protonmail.com>
        <dc983245-2de9-2aa4-16c3-ae11a8c20b6f@ryhl.io>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0698.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:37b::11) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|CWXP265MB2391:EE_
X-MS-Office365-Filtering-Correlation-Id: c2dbe589-1c3b-402d-9a0b-08db347875c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1qoz/ExN43JTf63pCViIPPvoBCazVU+HLXYQrz47C+Zaj3kGhg9XikUnavIh+Sq97GxabVDLJ4u4Tx8Gd59HKUd1GNoRKEq9Ve/zd7F3SmwRgQ3sj7m1TEv/KOapUV0IR+JkhI/l//xxraXk3en/bxOTMZwwRh77G/OFJI/iMoWjONkK5guatVlmUrN4oEzJmrwy2vtua8Sn9RVFdhMk7LnykhsfH4zGPFK5Hs2S6XxoHcpmkaDO5Db9GyT0N+aCpAaDcfLNi8NVqoc1nb007gSv/FVIDaDMqsBqnArzECDkEsC39Vl2rFW12V53f1Abrc/l0+Sj1/mSXDCtcpAPq9N/+4QW8ZhPKokbcXGaLHUn945kCaYV4lUGerb4fqpDarnputTiutbhxV6RSoeAKqMncX91gK2d9Ig+dNpoSExuJ3XpM3jdaJOD6eh1PUVpSsYY1msbUKSVgMigqyAxmVgHbAspW9M/pwSXC+EpMXSUweVcW9oV39nR0XQNrTZZL4lp+OasrQuBtdIgYMcXa2/4RWHTSXSBoJ/tOExTUC1iwWZTMke/ixzwDBirtjiOe5iXLlpH6m1Zex9VkG1sLFX0Z1sbG6QiUBzWQF+GOTM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(39830400003)(396003)(376002)(136003)(451199021)(6916009)(66476007)(4326008)(8676002)(316002)(66556008)(66946007)(478600001)(8936002)(54906003)(41300700001)(5660300002)(7416002)(38100700002)(53546011)(186003)(83380400001)(2616005)(6486002)(6666004)(6506007)(6512007)(26005)(1076003)(86362001)(36756003)(2906002)(81973001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XolaOQC0GDomt5K8a4cxIK3qYQ/j5osgFcFakHV238gRFdZEnj6xwb9vFgsO?=
 =?us-ascii?Q?fHEhNAmYMy5vE4M001Bdu14886FFWpap44v5MInap8yF1JJ6wiTgpxz/6oFn?=
 =?us-ascii?Q?GeqxEOVj0Xc5qrVTP7k3nHGtrBUg6MWRhNsJDT9l4JVIvOwKYtTQvUhNSBoC?=
 =?us-ascii?Q?8DMlU4ubkLHvOU2hcxFRagZbhEjfLU8h8zEDF4n7bt9MjOONEB651m7RKm3M?=
 =?us-ascii?Q?nIk4ZESBmQygAv/6l2iOOvdzYyILUkJ13PvrSvr1ERH/NOBIWgsNtQwLmDE3?=
 =?us-ascii?Q?Vh+pTcl/OMzNUpErdmRU5saHc9FK3SaagOPVFdrCFPKOuoHb1FbStN+jcdKf?=
 =?us-ascii?Q?zkvAOrHEhdGub3HUZohVZbZr/SgHKr+trknaQysUGaouPZpqs7e0msQNjAlm?=
 =?us-ascii?Q?zDnI7/e/HEJdn8wThmw8WvEZTEbNA4vIzhLRen06usayE5SwtV/TigP99CGX?=
 =?us-ascii?Q?qP4yp46yQ5VRq1eJFTvoti4O73uupNjIK2+c9uA3PbTK3C971Hb8iCr3ViM/?=
 =?us-ascii?Q?FETT9eIHLbpFmmLctNoscVBQ4Yk4Q9nXtLyUUUdXO6IvD5ErrLf9+0xOGX2h?=
 =?us-ascii?Q?1wkOCfnNu2uBjC2fXkEXDDHI8yCoewzvxDnxudXiodrcqGDLurIbSxFfr+mQ?=
 =?us-ascii?Q?P93QGKmrFduDOgLczJn/SacsHNqxSPl+TbpBU9MpXQxfa2IlIEZbfqk3032r?=
 =?us-ascii?Q?OzOgfT0xXowBlS4wqlAmjeeJmUEn2CBwg9GgPnMHAnv2XOKoZxXCgHrJ4l5m?=
 =?us-ascii?Q?fM4OwvPqm5YgNqukd2VI9SP+K/eSQnFLCSCRrGqi7qgYObfcl/kBATaaZpaL?=
 =?us-ascii?Q?AAF9uq3nW3Ib3GOIzrx6+y1Yn9pyA9k0kYzQs8PDXITFubT/do9znqd2Aozs?=
 =?us-ascii?Q?0Z7cWb6J068h5VuEQw8/+MApHtEyf2r87lw5sNwVoOeE+FNXFEVeyXvkK6pR?=
 =?us-ascii?Q?BNKj+XZ8Jf5BunnVVZ1UsfNn3kVazUK68hnEPyXdmKrxcoFRlbtwe/mKRbCp?=
 =?us-ascii?Q?ZDVCjIhRIMkegq1r34tBMIHyHxwIX2aWw9qv6/+ducnFIm2IoMX3GumsmlJI?=
 =?us-ascii?Q?JMkqKtaRjFNEd4IKVglXZ+jR2dr0NRduGYkHPAohnZgi+ExbiIcvZqZIwPcH?=
 =?us-ascii?Q?CF3FjgoDwbk0grSXt+sjiP7qzxPHId6l4x9srjxKTamFAC1iliJWiXRXYKNO?=
 =?us-ascii?Q?u+wKv829ZCs0oeIQhxCXaQPm7AjNaDYl60QEvZAhTK2ZXJ0ZR3Ti1wXl2Ru8?=
 =?us-ascii?Q?mcuQto88JsQ598EqS4iLeITHanKF9HYMLe7upnZ2qlycsNOBa//l3jjDdir7?=
 =?us-ascii?Q?keqoNy0sXcfjaRe7adIVjMVJYc8jsRGccquDXnCx89JK3IKB5WZ36KZLkFpB?=
 =?us-ascii?Q?EpPo87guFt4ZniZsfTZIw9bzQi8MF1wKNeqaMUpJLXZAx3qoXyxTKeaVx2QN?=
 =?us-ascii?Q?K2vj7AIHZTws0WuECVh5LxYa8HoB1aDGVXHIhox7kldeDJpsL1Aer5GZhxAk?=
 =?us-ascii?Q?tEVUTVwosR/cmfdTawZN0feHHzoAVQaMJ4hFF8ZkSjFFBBuEUrykZDUdSFqO?=
 =?us-ascii?Q?JlVNTYIMiTzfCAqaLLIqIeRpTWHKsof2SR1qptPV?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: c2dbe589-1c3b-402d-9a0b-08db347875c2
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2023 19:20:18.0990
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oXI3ofRVYMs7h3+xHnh1JdBOKKih+tV8FSL34rOG49Fg4C//yLW79l5Qj5Q/PEqiMZha3706/sldmofbAOkADw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP265MB2391
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Apr 2023 19:56:29 +0200
Alice Ryhl <alice@ryhl.io> wrote:

> On 4/3/23 18:05, Benno Lossin wrote:
> > Add the `Zeroable` trait which marks types that can be initialized by
> > writing `0x00` to every byte of the type. Also add the `init::zeroed`
> > function that creates an initializer for a `Zeroable` type that writes
> > `0x00` to every byte.
> > 
> > Signed-off-by: Benno Lossin <y86-dev@protonmail.com>
> > Cc: Gary Guo <gary@garyguo.net>
> > Cc: Alice Ryhl <aliceryhl@google.com>
> > Cc: Andreas Hindborg <a.hindborg@samsung.com>  
> 
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> 
> I have two minor suggestions - take them or leave them.
> 
> > +pub fn zeroed<T: Zeroable + Unpin>() -> impl Init<T> {
> > +    // SAFETY: Because `T: Zeroable`, all bytes zero is a valid bit pattern for `T`
> > +    // and because we write all zeroes, the memory is initialized.
> > +    unsafe {
> > +        init_from_closure(|slot: *mut T| {
> > +            slot.write_bytes(0, 1);
> > +            Ok(())
> > +        })
> > +    }
> > +}  
> 
> You don't need `T: Unpin` here.
> 
> > +macro_rules! impl_zeroable {
> > +    ($($({$($generics:tt)*})? $t:ty, )*) => {
> > +        $(unsafe impl$($($generics)*)? Zeroable for $t {})*
> > +    };
> > +}
> > +
> > +impl_zeroable! {
> > +    // SAFETY: All primitives that are allowed to be zero.
> > +    bool,
> > +    char,
> > +    u8, u16, u32, u64, u128, usize,
> > +    i8, i16, i32, i64, i128, isize,
> > +    f32, f64,
> > +
> > +    // SAFETY: These are ZSTs, there is nothing to zero.
> > +    {<T: ?Sized>} PhantomData<T>, core::marker::PhantomPinned, Infallible, (),
> > +
> > +    // SAFETY: Type is allowed to take any value, including all zeros.
> > +    {<T>} MaybeUninit<T>,
> > +
> > +    // SAFETY: All zeros is equivalent to `None` (option layout optimization guarantee).
> > +    Option<NonZeroU8>, Option<NonZeroU16>, Option<NonZeroU32>, Option<NonZeroU64>,
> > +    Option<NonZeroU128>, Option<NonZeroUsize>,
> > +    Option<NonZeroI8>, Option<NonZeroI16>, Option<NonZeroI32>, Option<NonZeroI64>,
> > +    Option<NonZeroI128>, Option<NonZeroIsize>,
> > +
> > +    // SAFETY: All zeros is equivalent to `None` (option layout optimization guarantee).
> > +    //
> > +    // In this case we are allowed to use `T: ?Sized`, since all zeros is the `None` variant.
> > +    {<T: ?Sized>} Option<NonNull<T>>,
> > +    {<T: ?Sized>} Option<Box<T>>,
> > +
> > +    // SAFETY: `null` pointer is valid.
> > +    //
> > +    // We cannot use `T: ?Sized`, since the VTABLE pointer part of fat pointers is not allowed to be
> > +    // null.
> > +    {<T>} *mut T, {<T>} *const T,
> > +
> > +    // SAFETY: `null` pointer is valid and the metadata part of these fat pointers is allowed to be
> > +    // zero.
> > +    {<T>} *mut [T], {<T>} *const [T], *mut str, *const str,
> > +
> > +    // SAFETY: `T` is `Zeroable`.
> > +    {<const N: usize, T: Zeroable>} [T; N], {<T: Zeroable>} Wrapping<T>,
> > +}  
> 
> Arguably, it would make sense to just expand this macro. The code 
> doesn't become that much longer, and it removes the need to understand 
> the macro.

I think it makes sense to use macro for non-generic types (primitives
and `NonZero`s. It'll be quite verbose if these are just expanded.

For the generic ones, I have no preference.
