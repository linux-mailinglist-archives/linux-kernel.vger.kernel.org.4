Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A98856D62BE
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 15:25:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234908AbjDDNZn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 09:25:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234198AbjDDNZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 09:25:41 -0400
Received: from GBR01-CWL-obe.outbound.protection.outlook.com (mail-cwlgbr01on2121.outbound.protection.outlook.com [40.107.11.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B209F19A6;
        Tue,  4 Apr 2023 06:25:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SYnyW6I5k37mOeypVNpSN2qLqwytDVOwiu4PEEZewuWu4SSyW2PJXXhtFWVDcyl+pFzku5QRO4RGtMz7fSyZtGp2XExz1HW74vfEXc4uTcZ1IYOCQP1tKdeqRyrq3ruVTqEuudjZ1Zxq3/vkHz6eDQhwupH34eqJySXNjAaDeqAM0Ax05zN7uCdCBZV9wTFuhm+tm6pq7CR2R3WYcbkbNI7azQSohdkY/EimlZ6JjV8vGM8zjpgRhY7SjCvukY33YUkCS619cEx6aSr7UIgD7s4spHqgzDmfrxdVRWBFx7Wj1FdMdyfvc8ByDwMyHM6TzpE//IVhzeaJJ1fXfcUCpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UHXzunnPTuoYOyVuL3YIOCvzwY8XXrIHLDWiVYBqcY4=;
 b=a9MHSLnHzSxFYLA9ASJ0EdbJDs1Jd/jsaglICzpUaiZK3kaJs8zBqsYHQPyrqcsZugtN4INiOeNGwRaJqy0UuD5ATuNIwPRUg8pz2ub1ogQc0BT61CnjlqB9KUJ2s1PKDIDkwcsxEN0UkBY2niqUhzVC8sZ0vNUsXsVvMDils5vVgoRCDjiCOuMln9jgBuzX1DrWnz37KCtpWyPdIu2jqYVb2gFBr6XhZe1AH3XnFyNE+E4rVK2SyV8WBGf6nuMiUbxAcCWMEhD5cSjG+7KZv59a2+SQfIfoXW7BSFVoXT8VnkeMyYwwb+hXbZcyEzmi+3A2coZGx6Et9037RIBdtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UHXzunnPTuoYOyVuL3YIOCvzwY8XXrIHLDWiVYBqcY4=;
 b=qmPCb+9QjhtJq0UCkPDy2zMc0Qnqc3usA4jDXkufwHItbbi5M5ndP/uiaGwQmc6V6D2J39R0MGiPiTh5tTvoA+nM3vP3SpDNcm0mTsbMydZNPDlw8sAzKIt7JN41tOLcF5Uv7UkKleGdM6Kp+9mVKo/TYPrpE2hVBed7qosIHGI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LO4P265MB6263.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:279::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Tue, 4 Apr
 2023 13:25:37 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::e1a3:5e38:b483:8161]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::e1a3:5e38:b483:8161%5]) with mapi id 15.20.6254.035; Tue, 4 Apr 2023
 13:25:37 +0000
Date:   Tue, 4 Apr 2023 14:25:35 +0100
From:   Gary Guo <gary@garyguo.net>
To:     Benno Lossin <y86-dev@protonmail.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        =?UTF-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
        Alice Ryhl <alice@ryhl.io>, rust-for-linux@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        Alice Ryhl <aliceryhl@google.com>,
        Andreas Hindborg <a.hindborg@samsung.com>
Subject: Re: [PATCH v5 14/15] rust: sync: reduce stack usage of
 `UniqueArc::try_new_uninit`
Message-ID: <20230404142535.63d75904.gary@garyguo.net>
In-Reply-To: <20230403160511.174894-7-y86-dev@protonmail.com>
References: <20230403154422.168633-1-y86-dev@protonmail.com>
        <20230403160511.174894-7-y86-dev@protonmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0305.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:196::22) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LO4P265MB6263:EE_
X-MS-Office365-Filtering-Correlation-Id: fc3eb80d-919c-4a13-53fc-08db351013cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S1oUGXDO5WuLPU8k9d1ViLu90WcV3UuCi6MagZ3Upwn7dUj2PO0jkUwtBneLJ8TFqONz9lRXK0hTHWbpf9s9X5/CiFFUojcmuWdAxOSGy8avNX4kwQt24tSBf1fvc1pXqcZTXMNWA4rdX2G1lEq+inBCbNFAtEIEVJRsLlwHIBVxv7H3fTW3ltTSxNfsugOGLLWZo6GMcnTGJQXQvFr3vOeeDBXF/WTrzGJwG+kTj1nsrLr/MRzd2y/GkADMoTQfcRfG5FWsn4RVydUljQrLGTFLDCrGUIHwOuwRt3q9hpBP7mvIU2sHGLv90AqLJQBeV+7qSjONRnmOo7eWVej22vU4vnGIuKrXTrSu0FdscxF+Mlhgkug91ZdFLLpUb9zBjJz/mlgeSYo66zn3BiyRFdncJ1ImvboJQGCmvcBhn2iHKn8c5rLy5nboaa51vfIZGiquc7NHcFDpamJYe9j/NP77o8MATU2UpRHhKmXZSEizXjD3WK7LgL9iuRIWf7W2d8c/J/BkUEeUzBuFh7BR5K8X59HrLuADNPI1gjbrodhsn2tEvlr9rNrbb3NydXMKWp/B+nzBcaxx2ZW4iAZQ+/Axz8l9/KkzEkxwxBGzDW8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(39830400003)(396003)(366004)(346002)(376002)(136003)(451199021)(86362001)(36756003)(2906002)(2616005)(6486002)(186003)(83380400001)(6512007)(26005)(1076003)(6506007)(4326008)(8676002)(66946007)(66476007)(66556008)(478600001)(7416002)(41300700001)(38100700002)(316002)(6916009)(54906003)(5660300002)(8936002)(81973001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CZRe/T8bxIWEzAt47pdTeqmpAeeQPpF4v+S1HLkMP4uodoCll/SJRxBD5N4j?=
 =?us-ascii?Q?0vfIe4mO8A2iUAKbM9RQApyif9kmgwwMp+nIuWm9FWy2WoxdPfXgwv0rjiLI?=
 =?us-ascii?Q?rwaxX5F0AyhRZjAYsPztfryVR+OkHmP9uhLzSjAt5+kY+/gqA6Z7SaoH+naK?=
 =?us-ascii?Q?gA17V/vaTb6n/ShuEsfjufkiLJPmV6OccqU0smXy9evFvXTVkEb5Cfu9Y7ti?=
 =?us-ascii?Q?lPFIr0xxwMMetniWF4/nztCPNA7bmc6kTAZ0RLLBzqB5yem4ihIInel7fDyu?=
 =?us-ascii?Q?gCpWjRXQCTG2DIQPbcaTuRqCDS6H0vsgzaEv0iF9kjGqRgzmvzgoEmr2Mqpu?=
 =?us-ascii?Q?f24zQIGlDQGMekhDpnrsMJ+b267wYmRtaKEaaiEEitR592sBDMpR6Q81abxZ?=
 =?us-ascii?Q?g9vb8Q8/Y0WqQFnFvbBrGdJfwD8eWMSrbC5+sS/vHxjN1wMps1M/VHpzlJmW?=
 =?us-ascii?Q?iQOFEDUADJMwsXxbrtwGi7q9H3g70w6XkIHnnBq7OsLX9YeuXKwsmfiJhW6V?=
 =?us-ascii?Q?wSjQ5R3MAGh2oXENOcZd8bHa+YUBLzVKq3m0t0evNoqM69bnX7Wpmai6CbLx?=
 =?us-ascii?Q?YheUO3oP5RWBWAcA8ZP3igGuJEP1Gz+533aek/ToetdKka2JwSy3WborBwbe?=
 =?us-ascii?Q?ZAgcgCNf7mrRpZ6ke6vL9EqPbUYcvECKcw8aFsGpGcVR8cKmCliFIXzHEbbH?=
 =?us-ascii?Q?qWnNOD78ag3wtDU0E1MLMzc8unTd2XmfTeTeVIPI4JJ/1GSWqRkC8xv2HwzD?=
 =?us-ascii?Q?bH7UuOf3O6FvgdnqfvbjNavmi2j+r70rCG0zYWOa45z/scA715bnSX7fjxGj?=
 =?us-ascii?Q?QDuuJgra013JWGZKejsza6yUyOyLMtSkxNg8OxAUF4lrzPI4ovyAer+/X46M?=
 =?us-ascii?Q?luNru6w5vn0wMZ9awwfIYdGUAFuxO8XgRa9vpX9hOE4qGdMakxHoJHAsOYUB?=
 =?us-ascii?Q?0yAXZIZNmIsztlkcETXWt77UWk2YLmq4AeOOclQE5LhaW9lZ/5dGoV+SspO1?=
 =?us-ascii?Q?MUUL7Tpo1fJ4+xBFmSpxNKU7pVWQ3xUIEUsxFH74JB/1L1p+QBPjPSei8VEN?=
 =?us-ascii?Q?ns0WpviZ/0IxJLr6m0CqtGDWaPF4lj4RrEazJ6hP+5THxTsu+sKy4ueNAluC?=
 =?us-ascii?Q?9KosYs6JT9pWaBy8wGQtZ7Y+VooQS7KWEi76e/HoUMPkpFiyJksmK2oVx01r?=
 =?us-ascii?Q?IwHYQMB1WnABQqgC5cobZrnsCCVvg9d3KRgIPxoTHNjHprvZUeNMfDBzDlmu?=
 =?us-ascii?Q?dP0dQQRapnlSGRxttjpy/re4XONodAmzNCvPlYND0HJ2lWq3qAKha2nLQY7o?=
 =?us-ascii?Q?pVDsiMVX5+MPafcSp6lhDrQf3wIyZ8+MCgBlbguQc2l15TiqFcjN+gZ1c5SN?=
 =?us-ascii?Q?t2L3caaZ3VIqVqtecQJD2O533Sfi3iIqzhFp08ANO1TzDDqeg7RioyZRbL2j?=
 =?us-ascii?Q?wYIF8RZGrPhqdeBiNFCrTALCevW0CWfdR56BmoD8Ee8ZHfZfCZkhT5AzieTv?=
 =?us-ascii?Q?nZtz+S0PLGcTfQMfi3phrgQnS7t065Fr+RcDaF1XyrinKHHidcdfI5hcCFls?=
 =?us-ascii?Q?YlN75K8LcPNMEhXCBM3ShO3qn7N0fljyuMvVccoR?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: fc3eb80d-919c-4a13-53fc-08db351013cb
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2023 13:25:37.2244
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6Yx/D5lurw8Wsdeq+P/kWddCky4jbVLa4j7nVoZzfJ292Vnqw4GtgVmXTS1KtL5bYdyr8KLlZs1oaxHwtYLjXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO4P265MB6263
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 03 Apr 2023 16:05:56 +0000
Benno Lossin <y86-dev@protonmail.com> wrote:

> `UniqueArc::try_new_uninit` calls `Arc::try_new(MaybeUninit::uninit())`.
> This results in the uninitialized memory being placed on the stack,
> which may be arbitrarily large due to the generic `T` and thus could
> cause a stack overflow for large types.
> 
> Change the implementation to use the pin-init API which enables in-place
> initialization. In particular it avoids having to first construct and
> then move the uninitialized memory from the stack into the final location.
> 
> Signed-off-by: Benno Lossin <y86-dev@protonmail.com>
> Cc: Gary Guo <gary@garyguo.net>
> Cc: Alice Ryhl <aliceryhl@google.com>
> Cc: Andreas Hindborg <a.hindborg@samsung.com>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  rust/kernel/lib.rs      |  1 -
>  rust/kernel/sync/arc.rs | 16 +++++++++++++---
>  2 files changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index 821bd067151c..2d7606135ef6 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -28,7 +28,6 @@
>  #[cfg(not(CONFIG_RUST))]
>  compile_error!("Missing kernel configuration for conditional compilation");
> 
> -#[allow(unused_extern_crates)]
>  // Allow proc-macros to refer to `::kernel` inside the `kernel` crate (this crate).
>  extern crate self as kernel;
> 
> diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
> index 43a53fbe175d..d05caa723718 100644
> --- a/rust/kernel/sync/arc.rs
> +++ b/rust/kernel/sync/arc.rs
> @@ -18,7 +18,8 @@
>  use crate::{
>      bindings,
>      error::{self, Error},
> -    init::{InPlaceInit, Init, PinInit},
> +    init::{self, InPlaceInit, Init, PinInit},
> +    try_init,
>      types::{ForeignOwnable, Opaque},
>  };
>  use alloc::boxed::Box;
> @@ -30,6 +31,7 @@ use core::{
>      pin::Pin,
>      ptr::NonNull,
>  };
> +use macros::pin_data;
> 
>  /// A reference-counted pointer to an instance of `T`.
>  ///
> @@ -122,6 +124,7 @@ pub struct Arc<T: ?Sized> {
>      _p: PhantomData<ArcInner<T>>,
>  }
> 
> +#[pin_data]
>  #[repr(C)]
>  struct ArcInner<T: ?Sized> {
>      refcount: Opaque<bindings::refcount_t>,
> @@ -502,9 +505,16 @@ impl<T> UniqueArc<T> {
> 
>      /// Tries to allocate a new [`UniqueArc`] instance whose contents are not initialised yet.
>      pub fn try_new_uninit() -> Result<UniqueArc<MaybeUninit<T>>, AllocError> {
> -        Ok(UniqueArc::<MaybeUninit<T>> {
> +        // INVARIANT: The refcount is initialised to a non-zero value.
> +        let inner = Box::try_init::<AllocError>(try_init!(ArcInner {
> +            // SAFETY: There are no safety requirements for this FFI call.
> +            refcount: Opaque::new(unsafe { bindings::REFCOUNT_INIT(1) }),
> +            data <- init::uninit::<T, AllocError>(),
> +        }? AllocError))?;
> +        Ok(UniqueArc {
>              // INVARIANT: The newly-created object has a ref-count of 1.
> -            inner: Arc::try_new(MaybeUninit::uninit())?,
> +            // SAFETY: The pointer from the `Box` is valid.
> +            inner: unsafe { Arc::from_inner(Box::leak(inner).into()) },
>          })
>      }
>  }
> --
> 2.39.2
> 
> 

