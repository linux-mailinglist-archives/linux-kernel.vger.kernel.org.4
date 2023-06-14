Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C598A73078A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 20:43:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233267AbjFNSnN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 14:43:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233913AbjFNSnD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 14:43:03 -0400
Received: from GBR01-LO2-obe.outbound.protection.outlook.com (mail-lo2gbr01on2107.outbound.protection.outlook.com [40.107.10.107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEDD52135;
        Wed, 14 Jun 2023 11:42:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jiO1+pd+ATE5TJe850d6b8C5DQjXc8qLbd4YDJoEozFc74IUKtxvHWf5oQ0x4x1Sbb3M7sDiGV564wxJkoJusaD7w+DRXIzDx5K/UkrWw66VvfBjOlb+yQ+uEolq6PAUoRn1CRqZkG2hSMqjrHBi6AXB4jf3eNOaDR6BVAD6sECWaV+yTJ5JaWneX6+Et2YLrtcPEsJpytWhLHlYqMPeP2yJUP100twUznJx/Vo8YWAo24ltn0gvqHm8PFdoLqjNFDgl2VOQgar551UjMfrWwg/83dSSNkownyXbKzP/tw/+MutnN3ZkZAnRXqOvfv3fF6X2P8EcZI9DMFIdq303SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=094GVrETUzYXINOgug0EiX2YiVI4/pbM04N6L0U2zcg=;
 b=mpBcP2qW+GIqDW3vUUKtWj5qwI7yXRlbKdMZkZ7gJFedrC/U/z+W1/0Tq8gyTvM0TDg2cDJET+xMZCQSOV54nJwyHvI9IZ4e6F01GsYQ0iB3VssywsMaI38q4HLVJN+3IqGqM8YPg/I4IOufm4k51biKQWyQLFK15oznWAicz7Ig/2VlfGhysfrKLviLIaqyL007lCkTHJA7OUnD/OGb/oAUECSmEK69rvtAt+Fxp5cea8uM/EVyydMg4PGXxKkI5MU89wR7RNjuIq6H9f7FEokQxtKz+7Va4OMtaVqSXI71lmB4av7MrQ+ZvalcTvWhg75Ag97Q8eiYwXRKjRh12A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=094GVrETUzYXINOgug0EiX2YiVI4/pbM04N6L0U2zcg=;
 b=q3b1hgzJ2ItZgkyzHn6IBHfc88n+OXeucuBs5t9OEGLwfn5fHzktenNA92is0N7WUV7k0ZIOfUG1I3vXIp86DGR9RNFHbLEcT6wSrnVpz6DQ3Jzh9g0F9axFx0joCy7W+NJ0Wx+hUnqotV95NmM8pKiV+ghgoF6lBFDU5eMReSM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LO0P265MB6099.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:248::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.25; Wed, 14 Jun
 2023 18:42:57 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f968:901e:1398:7d22]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f968:901e:1398:7d22%4]) with mapi id 15.20.6500.025; Wed, 14 Jun 2023
 18:42:57 +0000
Date:   Wed, 14 Jun 2023 19:42:55 +0100
From:   Gary Guo <gary@garyguo.net>
To:     Alice Ryhl <aliceryhl@google.com>
Cc:     rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "=?UTF-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev
Subject: Re: [PATCH] rust: make `UnsafeCell` the outer type in `Opaque`
Message-ID: <20230614194255.1fb8f6c0.gary@garyguo.net>
In-Reply-To: <20230614115328.2825961-1-aliceryhl@google.com>
References: <20230614115328.2825961-1-aliceryhl@google.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO3P265CA0024.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:387::19) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LO0P265MB6099:EE_
X-MS-Office365-Filtering-Correlation-Id: e3922a72-8e88-4e9f-e4f1-08db6d072bf2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ED/mRKQNidC8AOFOqmGOOg9I8688SABtkND0XLOjdd1mgVGG7PZBahdPY55fTzvd8fs0B6wltm/xv0nKgXor6rEPCKczteMtjHSTzutMqfG80iaRfk3HFlkjXzLDN98czF1rgLBn1vtvMQ2exFDPLr/eaCz2lYD6EWy7xXClzqVvIoS2deE2KbJvY73PnrgRrOimdlbBHzzEBpUzlcRg1Ud9DVdDGj+Z3vjII8yDwZNQiSNL3ZW5DB2WtN9dbwDWyTUao80iH+J0YG/OdYd/RJN3gwmVUbDrUCaql+j7TqoStg0bIDXvEpmmmeywlkrpSrgV2GHt8/Xa4IQbjMq2CBZpZbxU8vY8ZmFvh5mNCknJeT4WBpWddFc0pvWANGxeP/SyXTlbAZKyFruCP0YykDp9CzhV7ZzrKnxh5Tnw3oglSB7+9nMHd9vw593pqVdQbuKiZiFmKtx+GmD6R8TKtt80mT72ZsieZQobbY5eBJGe59R2uYl/TLkjKNJgdBMx11NWesTSFGxLZ3v8r3ZYnQiZqzcnO2obwc+KdjtcPwRFfboQJg+YQprDmvjtMG74wiPo7VfRgy7H/UpBW38+Insbrt9FqbMA12XS2NX06Cg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(366004)(376002)(39830400003)(396003)(451199021)(38100700002)(86362001)(8676002)(5660300002)(7416002)(316002)(8936002)(41300700001)(66556008)(66476007)(66946007)(6916009)(4326008)(83380400001)(54906003)(2616005)(186003)(478600001)(26005)(1076003)(36756003)(6506007)(6512007)(2906002)(6486002)(81973001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AgecQe1zM+u7ZxVZCDiR0sRnju6y4uF9UOKrEhKIzh8Wt5NbPdAolvpF4+Wc?=
 =?us-ascii?Q?124b9NpZm1WZZL/Ry/ZXHDHNR0IMs4R1e1AV+sXmucQBbEd/vvdQv3CgRTfx?=
 =?us-ascii?Q?J31xF35Gn7No+s3CAgc0djW+V6V2UnzswTymC/NrEP5VjzP3eWoEylcGZtfV?=
 =?us-ascii?Q?o3EVI2db6xD+fj0reX543GEdacs7Qw4I7cKBixfiZvsXH/2cRCMpOcWAKyxk?=
 =?us-ascii?Q?JOBtzAaAKwbUZnn1mkMG1JNTR8zaanEbtXQ2YG8CSi5jR+yzzPBvDcshayUU?=
 =?us-ascii?Q?DMTYdLhWCMs0Orzj5CwuPixYHl9v528+gBZGuzAqmozqLYthkL/z2BDCGoqn?=
 =?us-ascii?Q?51KFEnp30YWskKMyNTR4BkiE68snRwVH1z8g61HD+FJVcKMt+DVsQhudLl2c?=
 =?us-ascii?Q?nPZgipbB9hrQBr5+OrulXl5ifDg6SNz2wEHo0VFs7Hyf5hVM2FKlqzgs29Fd?=
 =?us-ascii?Q?onA8hv2hb5XoAgePAvpMOIK7wyrf4Mrc5G/1ekf4ej5FoXHEEfDHQEgQP6WU?=
 =?us-ascii?Q?xen5/iMpqb632CxQ0mkT4Sg/bEV2YMFONNe1VvtIrEcMlwIUDs2fxSpfchZw?=
 =?us-ascii?Q?taYqQXemmc+CN8uW6fUTd9O0kv5W1/qJRkDF/MO1yglkxhG4mJWCJ8tUOYyO?=
 =?us-ascii?Q?Po+ZSJm0xUNZeKaZyITMYumb8xy6yat+e69m/VhDFmPg8at5DIYzGY2tLKlI?=
 =?us-ascii?Q?gk65NcfU3zq4+U992PzlZCPWgZwQ5JYbG+B2qdXQ9WFGCANeui0ivy9Bv0cc?=
 =?us-ascii?Q?0UMemPLkKBbeXubr8OIbWhQw1JUqFMPyXDqWLqaEoSC+/UZe+3QSQ0tcD/vA?=
 =?us-ascii?Q?CtfQfTH/y18SRq4oexJ7kaXKtQT6ZjPWCAhkMuemRclqBx0uldCmDKuUOvuy?=
 =?us-ascii?Q?S+V2z3g86j662qYYp+OBBiWDqxczGyhNEOnY6UjIdWWLy4GTHDNJ0vXxWooR?=
 =?us-ascii?Q?gl1/rf+17MN/s6TBWjgO/3eXLeJ/2raflal07Dr/GsRX3X2sg4YwvR5uDepr?=
 =?us-ascii?Q?L4gSDgW8Gtgn7tKOTjCd0Hna7Mr2Vs2ynJe0+gLK1Y04gBYAuHUkbgQhBTjY?=
 =?us-ascii?Q?Hgj58z5ay1Q/QCmQq41XYaPftAyomiSAR2lU5Z1AjpcKkzmYFibQcEKW55Ic?=
 =?us-ascii?Q?Us01jdeCkVOWissd6eO3ut/POIud01U3Y5GWdIubxKIGFfd6MPMIfGoZwklJ?=
 =?us-ascii?Q?LrSXB5tFx9mMSrqg+MNOSJMhNFZm14U+UYkwP5BcTEQKUK0TV1R6SD+4f03u?=
 =?us-ascii?Q?QRKRKQqNv48YiP9OqJT7Idsf0WoCMcoJhQ7NfpugHGxYCXluJF0TcT+IVnY7?=
 =?us-ascii?Q?EE1yGEwBim7pnr1e9z8SkrZAAKvEWWkFd0aEyblniLO+E9ERYp5kfkAi3eNN?=
 =?us-ascii?Q?/HFMRrtOdYiEXqaYssbkTe0hLGCUPj4q127VdO6/1zRJzAMF0pbbfowVZdrF?=
 =?us-ascii?Q?b7axmVqy8zwO/a0/j0bNos45dw/U2EnxNM/HYK2Sz6tqATd+VRDXP1E0q0eE?=
 =?us-ascii?Q?TWIgzDbDvbGhade9ePT4Iy7kJjDAuiEh0NVeEHlyJA6kBtoMU7xE9J8XxlCo?=
 =?us-ascii?Q?mk0qQEuCfcrC48UYHSzX2t7fQfHZ56E8jRLkNR4f?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: e3922a72-8e88-4e9f-e4f1-08db6d072bf2
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2023 18:42:57.4488
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m8c6D183NQB/YpJR8r5ZUPksZP8HA6CxnaAD0TEm8Npb8FvJ5G84EYAorRcZhPsh1VnMtpqJiXUWJk6lGikR2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P265MB6099
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Jun 2023 11:53:28 +0000
Alice Ryhl <aliceryhl@google.com> wrote:

> When combining `UnsafeCell` with `MaybeUninit`, it is idiomatic to use
> `UnsafeCell` as the outer type. Intuitively, this is because a
> `MaybeUninit<T>` might not contain a `T`, but we always want the effect
> of the `UnsafeCell`, even if the inner value is uninitialized.
> 
> Now, strictly speaking, this doesn't really make a difference. The
> compiler will always apply the `UnsafeCell` effect even if the inner
> value is uninitialized. But I think we should follow the convention
> here.
> 
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  rust/kernel/types.rs | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
> index 1e5380b16ed5..fb41635f1e1f 100644
> --- a/rust/kernel/types.rs
> +++ b/rust/kernel/types.rs
> @@ -224,17 +224,17 @@ fn drop(&mut self) {
>  ///
>  /// This is meant to be used with FFI objects that are never interpreted by Rust code.
>  #[repr(transparent)]
> -pub struct Opaque<T>(MaybeUninit<UnsafeCell<T>>);
> +pub struct Opaque<T>(UnsafeCell<MaybeUninit<T>>);
>  
>  impl<T> Opaque<T> {
>      /// Creates a new opaque value.
>      pub const fn new(value: T) -> Self {
> -        Self(MaybeUninit::new(UnsafeCell::new(value)))
> +        Self(UnsafeCell::new(MaybeUninit::new(value)))
>      }
>  
>      /// Creates an uninitialised value.
>      pub const fn uninit() -> Self {
> -        Self(MaybeUninit::uninit())
> +        Self(UnsafeCell::new(MaybeUninit::uninit()))
>      }
>  
>      /// Creates a pin-initializer from the given initializer closure.
> @@ -258,7 +258,7 @@ pub fn ffi_init(init_func: impl FnOnce(*mut T)) -> impl PinInit<Self> {
>  
>      /// Returns a raw pointer to the opaque data.
>      pub fn get(&self) -> *mut T {
> -        UnsafeCell::raw_get(self.0.as_ptr())
> +        UnsafeCell::get(&self.0).cast::<T>()
>      }
>  
>      /// Gets the value behind `this`.
> @@ -266,7 +266,7 @@ pub fn get(&self) -> *mut T {
>      /// This function is useful to get access to the value without creating intermediate
>      /// references.
>      pub const fn raw_get(this: *const Self) -> *mut T {
> -        UnsafeCell::raw_get(this.cast::<UnsafeCell<T>>())
> +        UnsafeCell::raw_get(this.cast::<UnsafeCell<MaybeUninit<T>>>()).cast::<T>()

This can just be `this.cast_mut().cast()` since all types involved are
transparent.

>      }
>  }
>  
> 
> base-commit: d2e3115d717197cb2bc020dd1f06b06538474ac3

