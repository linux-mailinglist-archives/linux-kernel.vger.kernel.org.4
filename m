Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 487AC7441A1
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 19:52:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232844AbjF3Rwd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 13:52:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232747AbjF3Rw3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 13:52:29 -0400
Received: from GBR01-LO2-obe.outbound.protection.outlook.com (mail-lo2gbr01on2121.outbound.protection.outlook.com [40.107.10.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B735835AA;
        Fri, 30 Jun 2023 10:52:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cjkteE+NdaVK+Dm6OtNfa7xCW1exLEFd1eXyGRu9t/STegx6C4rlcPCjJlJO0jiUcfaGuI1Thqq6EgmvlpnDhmUlw/PH/vColCSBtSu6w9WV1MbAMKI9DQmanCwUZW1yBg+uetAeSQEhHY9jwfoEnE/tF+QZVlMsWCnNtwonXAe7PF5yp7v6ngQS3utFtx+LBzmNgKSENbH/oMmJEvcqtqUXy4Ir5tAm6COdXuC+QB4LCF3UNX7BP7mxyJoX8Per5t0EJt4n2aw8OFjkZDqr4YWk89gxpEeuxSmnwCvB/4VrSrojpBEGlI0wjWjHdfWG7BPH33DNJLOBr6BYBI2ydQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WAwcewDmQe3kmW1H2lgNB77rVwgFV/3gpvKDHy98hqs=;
 b=JsgZxzoz7iqWm2bL7e/OUAjaReW9kANw4k56QYdbaS1eSqx4pKkX9gLnC6JEm3Zal72EvnpHztEbeCab9LNfOy+1FJubpwOFUY9nSsk7IQG///CZ/SKDJpgAsiR4R6OU9PorALnofF3UI+kRCQ1bCEC4G77qgyOPsMx8DA+Dum0NaLJldaUNTJcXvTwriDu4DS0XVi/UVSwdcpgTD+Jl3nNcbRGi/tBgkmSJefqvsxd/M9Lo4mx8vxxsTZyoPUxAPXkUhSpm2huaRP+x9ZzPaovjO/T63YsFluqQRkdhKG7JPtEagI2C3PgmqmPX3w6rHP8XFZx7GldmD3q4od+02w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WAwcewDmQe3kmW1H2lgNB77rVwgFV/3gpvKDHy98hqs=;
 b=NLQ4RUenS/KtfCXhG2SJmn1p/ETHvMx/WcrtWYGmP4g1GEp1WRuQXYBBgvsYpvTiJoCz4KuIrGqIkaXDb8677KPTFr59aKFtz1lIFyvbeRpxcPkLZ6iIDN6QoNMVFMYYQ//w4bfQwC/1m78P2d/vekE1QITlz2QKdD8wxhUO+sg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by CWLP265MB2035.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:67::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.19; Fri, 30 Jun
 2023 17:52:25 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::25e2:a08b:cd9c:c3c9]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::25e2:a08b:cd9c:c3c9%3]) with mapi id 15.20.6544.019; Fri, 30 Jun 2023
 17:52:25 +0000
Date:   Fri, 30 Jun 2023 18:52:22 +0100
From:   Gary Guo <gary@garyguo.net>
To:     Benno Lossin <benno.lossin@proton.me>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        =?UTF-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
        Alice Ryhl <aliceryhl@google.com>,
        Andreas Hindborg <nmi@metaspace.dk>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev
Subject: Re: [PATCH] rust: types: make `Opaque` be `!Unpin`
Message-ID: <20230630185222.6ee044bd.gary@garyguo.net>
In-Reply-To: <20230630150216.109789-1-benno.lossin@proton.me>
References: <20230630150216.109789-1-benno.lossin@proton.me>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0448.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:e::28) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|CWLP265MB2035:EE_
X-MS-Office365-Filtering-Correlation-Id: d3c12987-6ceb-4afc-07d7-08db7992c347
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V/ZWY0iIwdfoYczNE4Rm1P01H6E4bHb//e/wHBCwi1h/Yp4yeFD6FCeup9wvfo66zzHvRKWyPzr6xagtZMi0GakzbUKWXhbsYZ3aqmJMqWP1aa+9ZDKJnCBSVC/NvGbcYhQKlf56erSqy2E6soMLU2F5uUvyH9BtnXfWZQpZPsQQcThID6CnJe6mJuhbFc6i1LJwzKEgsbrRKHKl9RCaWOeZgiAPLFQyTdNIeoa343EfvVKXsw6MSXKbeh6SGB+mIcnCVnUmIIDhCAvsT3IVsO93QX2L/bpg1IOkuZNtr0H2oIlzKey2qwN5g4FtHXRNR7m7r6wKNELk7envab1kdvhAxXbEKKbN/G2CFGOM/2CE9cSFMuKonTp+h5TQXkiVZLBrDU+l5h6Zmj5Ls+wc9YRi5Pjm0osGKvhGwfQ0QPIeijGtaJSO84irJPPcuC4AavRHnS8eNQpT/khwbuJB2ohjIKNxy19o2Ui9iFmUXK1yqPlGzn3PStPsZ4alMxJa/Nv/GTAsf6WiPntU47kRi3Bg37Hf3+Ew5XbmxWcMV+QIKAvhOlCwabtlyda9oRHU9ea8L+V8XumGcKj4J23et806rSdwh7bWdq0DSJX3jbE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(39830400003)(376002)(346002)(366004)(396003)(136003)(451199021)(2616005)(38100700002)(6666004)(86362001)(966005)(6512007)(2906002)(316002)(6486002)(36756003)(66556008)(66476007)(66946007)(4326008)(6916009)(478600001)(54906003)(1076003)(186003)(6506007)(83380400001)(41300700001)(5660300002)(8936002)(8676002)(26005)(7416002)(81973001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?l5OlcKW+4WK55Az4AuY1/C1pRhjfMBgdi+QZQA2HB+35JnKFwzRthZHgk46k?=
 =?us-ascii?Q?Rbe3svILhBxd4PcNc3shwIJfRXC4+k1hxxnngV6jA3OSOLaTnOEm/2iNiJ4a?=
 =?us-ascii?Q?A9qZfICvwCiC/Q8lmFPyukCyggpKw3tzV938A/4Jbb7ZAKXbiFszTo1jJ9+E?=
 =?us-ascii?Q?w4PYva66l7Rlai7MwNNEzTRVMrMyjdiH5fr2YmE+yjVvo5Z/WRaUjAAiYpeW?=
 =?us-ascii?Q?1FhYIEoiihI4NUVmml3TJtp4SOHBw9uTE44xmZ7ZMhrYvrR+gZSmgjO2ll52?=
 =?us-ascii?Q?A/iAzF7HfUOAVAM4R8e2l9H9x6mkIim8OAiMqrmrUmrsQhnjLMotmIOdaBBt?=
 =?us-ascii?Q?LwJGooxotKVJffVik3v9QPwsDlPBagBlGl3PzcLWDw0Bicme244sibBt98G1?=
 =?us-ascii?Q?1aeMe3pN+8X2FGYFPBb34F/F2Bwcre3vayCc0Ikr/mPbgaIkKFgsupzAA5gM?=
 =?us-ascii?Q?y1BoN7SQ2HiqFY3QcRP0Gdys3QjORpuMYWsspsdBLzMm/pVFGT2FR6XEypO3?=
 =?us-ascii?Q?k3IRZUkBlL1URygO8kaRWROIEN8HHkGEoRp0p32zZ8VDM92lXIgS+Qo7U9+O?=
 =?us-ascii?Q?L5jul4vWT1mKRAfM3MxLkay0t5+TA+dmqscWxBFMVWT6QPaJht/fTyxhbdCp?=
 =?us-ascii?Q?p8+p77bFDgvWxqZXKQL+/wZlKcUEa0Xdffg0wrbthdzQ/mQsKQebGjvBIkZE?=
 =?us-ascii?Q?qDX+E59AxqnRnaTnfJZtjoyPTkDfUwfvcedBOzerZMjb73XrymbxYAnyqmhK?=
 =?us-ascii?Q?K590ihyoJjZSwDSEJhNAvtGxmvhomw7jM4xtzyrQ9sZxOfvT3kLhYPje5bwg?=
 =?us-ascii?Q?7Ow4NqSpWjwsTgCDkqbtzeUBcUqoe96lpWbQozeYsA481BkU/NXCyGtyrp6n?=
 =?us-ascii?Q?WSUBRxYlKgl6LrLTRNJBJIWrkhdkeMQoynyreC1Rn0J7LeYtxsHtGjWr/KdN?=
 =?us-ascii?Q?M951VBnpZsN9WJjdOFRCHyQU4OKmxo4lIfFnbLK8pVLsaxKxKrnH0V1nyqTx?=
 =?us-ascii?Q?LmorVYilFr1IEJX6O8RDNngIadwUDGzNz6yqHS8tva04Uy9RXxmDyI8U6UYZ?=
 =?us-ascii?Q?vwe5qt4IxDKpicZbNHGlWg1c9UZwoheUmmGlTckTT5vkTJDsmppKZb0Iw17h?=
 =?us-ascii?Q?MDJ7hZCWBNPt6WGol/bare66U9VwuSy3mtF6BA/erfgSq6IDX/zRd2I3hCGO?=
 =?us-ascii?Q?liicHAtrIYBKCg/vhNxIHmVVsk/zRkFWcJ1KikDyCrmeKLL+kN21x+BqnRZ6?=
 =?us-ascii?Q?MSpU8q2xJPOoF9PSDiQnHXpu9o09WliXiPc/hxE3PopDUOtgmVdVEAGieG4m?=
 =?us-ascii?Q?XGqCFhV5PcsZqvIaA8OYAFpxLTv6sSetX6oz2ffn2WyLT+LRJWLhqHtcUuvU?=
 =?us-ascii?Q?Os8uhHkALnVV/YMjy/tlbqyqS9x976LreWghYiLVEmIm22bf1U3GI780zda0?=
 =?us-ascii?Q?E4Z8sPDbHU+JD/IK0dHB48eJNyb404xhMZRSI+UDpKYPR8EFkRbRiirWGbZY?=
 =?us-ascii?Q?cL+ar+srKfKVsNJflqCB5H7x8A2FFg82NZHuH0kw/j9wy7A3gu3UKB5omFpb?=
 =?us-ascii?Q?V+NYdY/6TC88+GK1DS4zZK8VlslSVpmv1sNbnnTj?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: d3c12987-6ceb-4afc-07d7-08db7992c347
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2023 17:52:25.3245
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u55V6k9QwXyI7tSDFtlg/W+BbKIPkh75RDylglJFQervECpb+Bx47agsWZz5NRelIvD+BDG5Ac6Mum0g4/DQTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB2035
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Jun 2023 15:03:23 +0000
Benno Lossin <benno.lossin@proton.me> wrote:

> Adds a `PhantomPinned` field to `Opaque<T>`. This removes the last Rust
> guarantee: the assumption that the type `T` can be freely moved. This is
> not the case for many types from the C side (e.g. if they contain a
> `struct list_head`). This change removes the need to add a
> `PhantomPinned` field manually to Rust structs that contain C structs
> which must not be moved.
> 
> Signed-off-by: Benno Lossin <benno.lossin@proton.me>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
> This patch depends on the patch that swaps `UnsafeCell` with
> `MaybeUninit` inside `Opaque` [1].
> 
> [1]: https://lore.kernel.org/rust-for-linux/20230614115328.2825961-1-aliceryhl@google.com/
> ---
>  rust/kernel/types.rs | 19 ++++++++++++++-----
>  1 file changed, 14 insertions(+), 5 deletions(-)
> 
> diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
> index fb41635f1e1f..e664a2beef30 100644
> --- a/rust/kernel/types.rs
> +++ b/rust/kernel/types.rs
> @@ -6,7 +6,7 @@
>  use alloc::boxed::Box;
>  use core::{
>      cell::UnsafeCell,
> -    marker::PhantomData,
> +    marker::{PhantomData, PhantomPinned},
>      mem::MaybeUninit,
>      ops::{Deref, DerefMut},
>      ptr::NonNull,
> @@ -224,17 +224,26 @@ fn drop(&mut self) {
>  ///
>  /// This is meant to be used with FFI objects that are never interpreted by Rust code.
>  #[repr(transparent)]
> -pub struct Opaque<T>(UnsafeCell<MaybeUninit<T>>);
> +pub struct Opaque<T> {
> +    value: UnsafeCell<MaybeUninit<T>>,
> +    _pin: PhantomPinned,
> +}
>  
>  impl<T> Opaque<T> {
>      /// Creates a new opaque value.
>      pub const fn new(value: T) -> Self {
> -        Self(UnsafeCell::new(MaybeUninit::new(value)))
> +        Self {
> +            value: UnsafeCell::new(MaybeUninit::new(value)),
> +            _pin: PhantomPinned,
> +        }
>      }
>  
>      /// Creates an uninitialised value.
>      pub const fn uninit() -> Self {
> -        Self(UnsafeCell::new(MaybeUninit::uninit()))
> +        Self {
> +            value: UnsafeCell::new(MaybeUninit::uninit()),
> +            _pin: PhantomPinned,
> +        }
>      }
>  
>      /// Creates a pin-initializer from the given initializer closure.
> @@ -258,7 +267,7 @@ pub fn ffi_init(init_func: impl FnOnce(*mut T)) -> impl PinInit<Self> {
>  
>      /// Returns a raw pointer to the opaque data.
>      pub fn get(&self) -> *mut T {
> -        UnsafeCell::get(&self.0).cast::<T>()
> +        UnsafeCell::get(&self.value).cast::<T>()
>      }
>  
>      /// Gets the value behind `this`.

