Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 036196D8818
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 22:19:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233317AbjDEUTD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 16:19:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233929AbjDEUS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 16:18:57 -0400
Received: from GBR01-CWL-obe.outbound.protection.outlook.com (mail-cwlgbr01on2105.outbound.protection.outlook.com [40.107.11.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E55055FCF;
        Wed,  5 Apr 2023 13:18:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MAh9NTIHyHbeB1riPVB/1Bmq1USFSGGKj7QPaQT/4PKK8vuBU6qPAVnpi0DOdhHFdH+uCgbqawVA0AVwzx9JvoViACVCbVdRDh01h0xVq2hwFQizYDSC0+mh4uYm7E1o2/ZZkksKWOoCfAe67fBqYo4u5Yzte6CAm5KuyWK6mwncQYYW7/GEPnC2wLG58/9hR+n5INzrb+LqASsOwBqNhXYuQesY2wpuDvN1cb1OTNn0TejuCya2Bk2/XoQsKSBC4ovLYRwkqxrH03THPVA5WMWBeTVOwCSs6Yuepxzw5/lhobj7UdGndB9GtNirVLMe2iBHqwVEDPkEQVlqWjW90w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j99oVgE2/qV+VukceL08W9uxNtWq3eeg4l1LviLdsq4=;
 b=RdrrW2wedmx6/tbhb3rUOGlOfhdb4cPY3kDbASuOsCoO/73EERW3wRoj+bLnBHX5A7FA0LIjx2QGctXinapiwNgeWaeHEYuGw2lYxDanCJNZ6+1WWWUUg0t/1qyUdmhKbMsF0IfSzVkAKBofHaGaKuvHPv/HU3DpJmEzsbNDmlxg2OwcoMIETMV7PQMGWBs+1NQ8rqG9o5xx8P5FnqloEc5OTc+6KwgBmkUkk6pPfBCf11vjk2m8cFtaf465Xkl+WZkoKgXfC9vvldqdq6WI7A2p2aKaroapWwV0Dk6rvExfZrkhbYvUXZ0hYwuJ9/5WrDPUJp5A/bZXJLdL3Ssb6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j99oVgE2/qV+VukceL08W9uxNtWq3eeg4l1LviLdsq4=;
 b=GMhjRA8qZljR1h5BSAl5IURuYgdP9AdkvqC2rTvz/NYI8+i7NKErkJo3KdbEGfXvxxZ2aJO2oOJL/tD26IZYJ5k0t3vcIyHgPEVDR9GyLy0QpgmwXKhNFGxzmB2fJaP7M7mxDWzTz79kkyD8FRWp8PNYezcaZNkRW2yn6EF3nIk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by CWLP265MB6340.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1e4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.29; Wed, 5 Apr
 2023 20:18:44 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::e1a3:5e38:b483:8161]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::e1a3:5e38:b483:8161%5]) with mapi id 15.20.6254.035; Wed, 5 Apr 2023
 20:18:44 +0000
Date:   Wed, 5 Apr 2023 21:18:40 +0100
From:   Gary Guo <gary@garyguo.net>
To:     Benno Lossin <y86-dev@protonmail.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        =?UTF-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
        Alice Ryhl <alice@ryhl.io>,
        Andreas Hindborg <nmi@metaspace.dk>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Alice Ryhl <aliceryhl@google.com>,
        Andreas Hindborg <a.hindborg@samsung.com>
Subject: Re: [PATCH v6 13/15] rust: types: add common init-helper functions
 for `Opaque`
Message-ID: <20230405211840.022ee6e2.gary@garyguo.net>
In-Reply-To: <20230405193445.745024-14-y86-dev@protonmail.com>
References: <20230405193445.745024-1-y86-dev@protonmail.com>
 <20230405193445.745024-14-y86-dev@protonmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0688.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:37b::17) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|CWLP265MB6340:EE_
X-MS-Office365-Filtering-Correlation-Id: 1290258c-d70e-4e9d-71b0-08db3612f4a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D3KydrcMrhtoKc87+39zMylrXbhk5Gz4Mnhd2CslmzosQrXVu2kFgrJcRMqN2LvABk9s7W1iBhApoK6Bvs3h0FyZg7z8bRxUP4QxvXv1ug5oZwOvBM8ivgx8n8WRbtl+ceC0UMqcdXCeZrXm9bZPfMZAJNi8K7fTP7Y5iX8Fsn5AM9DQicMxQFnrcNJFi2Hq6q6ZdCQnDCsbGgswjFPbLtYv4CxWWWqjXCZwfPG4znLuSlcr54+bOaoJFbsSQWJirtku1yJ/QiTsDSHbUgUEt7znGmTWzRbe3rN447H+An16VA+8cdUZFqEHuzDDxT88U7KE+hEPOQQ9bjrguMvjqHUOcHNPb9pHe8EyTrSaHhhAaRWW2MXidC9hBq5cy7OGoAPGbLKU7J8nsZIxvcJ5dsVLbqQLjO62sNeEB4Njb2jg9mer225xeDwCCGlPpG1pATjOBmRnhicFncsqhatCynz40LsnYFqY0jo2KY6p3Ov7ICk3DkSwQK+dHBeZCtWcEdwnifyK33bpNpRFCH+UQ5t6rErqXy/GDfKHjjCtpl8yMTg++Ms7C5YFN7us/o2/p11uMXPSbWxln+pbsO74C459aoH5H4PSjbaDzUqmsD4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(396003)(376002)(39830400003)(136003)(451199021)(6666004)(86362001)(41300700001)(36756003)(186003)(54906003)(6486002)(6916009)(4326008)(966005)(8676002)(478600001)(2906002)(38100700002)(66476007)(66946007)(66556008)(83380400001)(316002)(8936002)(26005)(5660300002)(2616005)(6512007)(6506007)(1076003)(7416002)(81973001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LL4tMCvb06gA3PQuLHEU8GiaC0rHulBottky7apKT3rEnp4UfCBua+csEWOG?=
 =?us-ascii?Q?78t0swLLQNR93VjqKj7F5NXcfMbCNlx7IOV3C/OjpSSKKEUs6MpmFJSnGnN6?=
 =?us-ascii?Q?1iNPHT1Dhl2gXaUTwdEO6g+1L/Xs1hpuG/O0V7QVHntiTcgGosn6pJQpe7wq?=
 =?us-ascii?Q?f3TikpJoy8h1WkM2TtxNIJq4baiPoQJnsj7vk1rtTXHHwEmU5R1euIGmZUcU?=
 =?us-ascii?Q?Ice6KsyogYIISEqtNCQyIenXTCI9MI9Y6vgoDsoe2RWGgehi2PTEzYjpJuVr?=
 =?us-ascii?Q?nm7g0xX1SU3CiG4hY2p4k/ogHWgeNnZ9vvS5OOTwe7bWobuaCcr0xvY8LQfE?=
 =?us-ascii?Q?3J3kNRgX+NQ5CPeH+A8gsIxs2wRJAs14+JKSvRRW4lk949Y+JDc/XLbkud8C?=
 =?us-ascii?Q?ASk//PGwzlWfmHeLGaYdO52tVj1/x8sgs4qoMBCc+rR5xwXKpCQ5VM5nsxBz?=
 =?us-ascii?Q?oY19zIZFXFOzCwJLPxhe/f1DVXyUSDvVde29Mc6zxmyjgbPQvFZaEFpkfd/w?=
 =?us-ascii?Q?2S1G6UIyxlo4oZCRS+C6A7/KUaDSes0tGb86mxUVzB2cFQ3MhLms2uwE45BN?=
 =?us-ascii?Q?aNa9ZvtmrCnABrWcSxllT2DA822Jsjnma484hkObrvGJZXFa+P0cw3SXPkJR?=
 =?us-ascii?Q?7PGS8yLEf1kTFB+GQtTUKRGjLVfsARZM8i2jsIsezIh+ilcymGrI2tdXa+OP?=
 =?us-ascii?Q?g6QE+qJde3tkQOsUrIrplQ11hMnE23Dmq5RrCwoBtZYsgj84Ybw9LynOXK4Z?=
 =?us-ascii?Q?MBCMQMoLjBd/FwUTVdQJSaPABu2WtMT/F815lLKTP3dGwQYl6ElAk/2DUvqW?=
 =?us-ascii?Q?+J4du2yxTS7tsntrN7HGUUix2cztB4WsvejMCrOObTaLeva63RFv45RzusAX?=
 =?us-ascii?Q?6pKkS1a2NH/znqS1u75HmiLNlJ+ybND3iymi4dN0pvg1PR2RIV3Qwe5cvRD8?=
 =?us-ascii?Q?LonML21qlFrxZqLUiSeKdtdrKkpQZcnyq9C0oI30YChHCRxZtyS9fHWILN4D?=
 =?us-ascii?Q?tvPRIN9u60UHr0pDHr/iy3UroSGmDib9SCBzbqZhF8As1hrjyYddEqNDYJCF?=
 =?us-ascii?Q?cc/zoYfDcv5cjxFEip2YThiI8sv1LUJqVFpU7eH5BB/ePpFdOuYLROg84bSe?=
 =?us-ascii?Q?Zvk43wlaQRRPsgdx0E97urpFPc+O3gHJ1Krhj4zvUpxd2IsZmb1ZYek/p9Wc?=
 =?us-ascii?Q?4ZXqcm8M6m+kTEIl8DWoY5FCEuJevv9cfNDxVusUZAey+4pLDqqeLXqZr5V8?=
 =?us-ascii?Q?eDzg3RF4POtTiwi/0KLdpIlQtYLt6ZGgzbBcjK4WvOfrdAj/PDCfWiXVXXkm?=
 =?us-ascii?Q?SPMaGBqsRMx1qzsq7wexwCCVAJtdK30uEic2HKLUICOIM6vO/JkmAA6S3VrO?=
 =?us-ascii?Q?bftLUXPXnuPg63YDvaQZkjq/od2ICi01skb+0IzyT2Bc8Zj35dHC1584tikg?=
 =?us-ascii?Q?ThNh5Yd0i/vJl3eXHpl/DEvqR1cd2AI2aVzHZmUi9USaHs2spk3r6e5HsUNB?=
 =?us-ascii?Q?DJ/OfBDUKNDF8Q6ISWFg5LUef1F9D5FzLStXhlAlUMkg7QVdmx/UIqkhb9p1?=
 =?us-ascii?Q?hN7Cu3ewtrHcdm8vs1O+yOGXhqn/+qhEx7zQdv9/?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 1290258c-d70e-4e9d-71b0-08db3612f4a0
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2023 20:18:44.5868
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RyvJrM/C2MtuqT/jqauZ6lZU+Z+0To3djK8v51eebWpUeyPm4h6XEDcTwtBaXuVx+fCq9m0NRkSZzRtDj6752A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB6340
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 05 Apr 2023 19:36:46 +0000
Benno Lossin <y86-dev@protonmail.com> wrote:

> Add helper functions to more easily initialize `Opaque<T>` via FFI and
> rust raw initializer functions.
> These functions take a function pointer to the FFI/raw initialization
> function and take between 0-4 other arguments. It then returns an
> initializer that uses the FFI/raw initialization function along with the
> given arguments to initialize an `Opaque<T>`.
> 
> Signed-off-by: Benno Lossin <y86-dev@protonmail.com>
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Reviewed-by: Andreas Hindborg <a.hindborg@samsung.com>
> Cc: Gary Guo <gary@garyguo.net>
> ---
>  rust/kernel/init.rs  |  9 +++++++++
>  rust/kernel/types.rs | 47 ++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 56 insertions(+)
> 
> diff --git a/rust/kernel/init.rs b/rust/kernel/init.rs
> index ffd539e2f5ef..a501fb823ae9 100644
> --- a/rust/kernel/init.rs
> +++ b/rust/kernel/init.rs
> @@ -177,6 +177,14 @@
>  //! }
>  //! ```
>  //!
> +//! For the special case where initializing a field is a single FFI-function call that cannot fail,
> +//! there exist helper functions [`Opaque::ffi_init`]. These functions initialize a single
> +//! [`Opaque`] field by just delegating to the FFI-function. You can use these in combination with
> +//! [`pin_init!`].
> +//!
> +//! For more information on how to use [`pin_init_from_closure()`], take a look at the uses inside
> +//! the `kernel` crate. The [`sync`] module is a good starting point.
> +//!
>  //! [`sync`]: kernel::sync
>  //! [pinning]: https://doc.rust-lang.org/std/pin/index.html
>  //! [structurally pinned fields]:
> @@ -187,6 +195,7 @@
>  //! [`impl PinInit<T, E>`]: PinInit
>  //! [`impl Init<T, E>`]: Init
>  //! [`Opaque`]: kernel::types::Opaque
> +//! [`Opaque::ffi_init`]: kernel::types::Opaque::ffi_init
>  //! [`pin_data`]: ::macros::pin_data
> 
>  use crate::{
> diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
> index ff2b2fac951d..dbfae9bb97ce 100644
> --- a/rust/kernel/types.rs
> +++ b/rust/kernel/types.rs
> @@ -2,6 +2,7 @@
> 
>  //! Kernel types.
> 
> +use crate::init::{self, PinInit};
>  use alloc::boxed::Box;
>  use core::{
>      cell::UnsafeCell,
> @@ -248,6 +249,52 @@ impl<T> Opaque<T> {
>      }
>  }
> 
> +macro_rules! opaque_init_funcs {
> +    ($($abi:literal $name:ident($($arg_name:ident: $arg_typ:ident),*);)*) => {
> +        impl<T> Opaque<T> {
> +            $(
> +                /// Create an initializer using the given initializer function.
> +                ///
> +                /// # Safety
> +                ///
> +                /// The given function **must** under all circumstances initialize the memory
> +                /// location to a valid `T`. If it fails to do so it results in UB.
> +                ///
> +                /// If any parameters are given, those need to be valid for the function. Valid
> +                /// means that calling the function with those parameters complies with the above
> +                /// requirement **and** every other requirement on the function itself.
> +                pub unsafe fn $name<$($arg_typ),*>(
> +                    init_func: unsafe extern $abi fn(*mut T $(, $arg_typ)*),
> +                    $($arg_name: $arg_typ,)*
> +                ) -> impl PinInit<Self> {
> +                    // SAFETY: The safety contract of this function ensures that `init_func` fully
> +                    // initializes `slot`.
> +                    unsafe {
> +                        init::pin_init_from_closure(move |slot| {
> +                            init_func(Self::raw_get(slot) $(, $arg_name)*);
> +                            Ok(())
> +                        })
> +                    }
> +                }
> +            )*
> +        }
> +    }
> +}

I personally don't like the fact that this is using function pointers,
as that generally causes a difficulty for static analysis tools.

How useful would this helper be?

unsafe {
    Opaque::ffi_init2(
        bindings::__init_waitqueue_head,
        name.as_char_ptr(),
        key.as_ptr(),
    )
}

doesn't save much from

unsafe {
    init::pin_init_from_closure(move |slot| {
        bindings::__init_waitqueue_head(
            Opaque::raw_get(slot),
            name.as_char_ptr(),
            key.as_ptr(),
       )
    )
}

> +
> +opaque_init_funcs! {
> +    "C" ffi_init();
> +    "C" ffi_init1(arg1: A1);
> +    "C" ffi_init2(arg1: A1, arg2: A2);
> +    "C" ffi_init3(arg1: A1, arg2: A2, arg3: A3);
> +    "C" ffi_init4(arg1: A1, arg2: A2, arg3: A3, arg4: A4);
> +
> +    "Rust" manual_init();
> +    "Rust" manual_init1(arg1: A1);
> +    "Rust" manual_init2(arg1: A1, arg2: A2);
> +    "Rust" manual_init3(arg1: A1, arg2: A2, arg3: A3);
> +    "Rust" manual_init4(arg1: A1, arg2: A2, arg3: A3, arg4: A4);
> +}
> +
>  /// A sum type that always holds either a value of type `L` or `R`.
>  pub enum Either<L, R> {
>      /// Constructs an instance of [`Either`] containing a value of type `L`.
> --
> 2.39.2
> 
> 

