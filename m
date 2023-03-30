Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 916E86D028C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 13:07:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231338AbjC3LH2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 07:07:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbjC3LHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 07:07:25 -0400
Received: from GBR01-CWL-obe.outbound.protection.outlook.com (mail-cwlgbr01on2115.outbound.protection.outlook.com [40.107.11.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 473A19ED6;
        Thu, 30 Mar 2023 04:07:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d4ipyu24IddGbUA1ciVjZLrs20h0T+FTFxMHwjobbQbT401uEKtbqGjAkz2AIeyljsQID2S2TZMhURUOnPVD/aTgKkMarvQz/kZQFVB4YLwrZEq+iiWvto4PNNzcb0EAU75fpMFu5LmL1fPN27dIToR4cOxS03jixE9+eFg0ysqcNXtKVffN8IIEj/KNZmAxsW8maMNhNF11cFS0L4AZZ34NLBPzjp2F3haK79z/kd9U5WIcFd9N7j9Qrgqg5gaHZSYls0QBoHRjhRnMw05n0OZ8ycT5pKHWz5tGaqeFBZvZlracBtGyYJesx9xA3J+FI/YqrCUXtTyJt6LSJkNxZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TY1gpTEAdn1puIybMfWTMkDK6PVPe6och5DB9uPX3W8=;
 b=ENvpN7KDka5yzZMVpxBCpW8IYmZKlnbA8+qaMfVVgDpqM+xqkiGV6hM1yC5M5/tbplubXO+eSbXOCrSoPKlpq/HbMAkAip1OLfsHgtJpkyHEUeAsixVYNwuAHHUBtLEe3utLomNpp4yOyKvFN7CQ2W8V7bKdAIClle18e4R4JzXQikWSIhZExbqLnCcS8gqAMyXLCvW6DuJqsb2UIhAQ6NXMou/6KzqqSoVIS4dIAxjnaWJIAFAmvwvjL6z6F2zAuRqRWhMi7UlUf0kV8PPtfISht9dO1ZjL0afAmc4lEjDHT0EQwBbPey6VWNzO48PRdu8VZWDdmYdt1ar3Sw6ceQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TY1gpTEAdn1puIybMfWTMkDK6PVPe6och5DB9uPX3W8=;
 b=zICc89YGd6LHMgELv1mZPoYje6dSnZGSNaMlJ/+LzTMwptkJ5QbigUFWSVXh/eCKt8Wmdtt+IQ4NyVBL7JSHI4UGXjTDFNSzexd7FATp/yvF0fYHh7vGWYZlfMrhLCobKA0lttHDcU+zkgU2ONb6F5qsvzZy8IQ9f5d3B1l17rY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LO4P265MB6823.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:349::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.35; Thu, 30 Mar
 2023 11:06:46 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::2f2a:55d4:ea1d:dece]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::2f2a:55d4:ea1d:dece%4]) with mapi id 15.20.6222.035; Thu, 30 Mar 2023
 11:06:45 +0000
Date:   Thu, 30 Mar 2023 12:06:43 +0100
From:   Gary Guo <gary@garyguo.net>
To:     y86-dev@protonmail.com
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        =?UTF-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
        Alice Ryhl <alice@ryhl.io>, rust-for-linux@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev
Subject: Re: [PATCH v3 09/13] rust: init: add `Zeroable` trait and
 `init::zeroed` function
Message-ID: <20230330120643.11f92c38.gary@garyguo.net>
In-Reply-To: <20230329223239.138757-10-y86-dev@protonmail.com>
References: <20230329223239.138757-10-y86-dev@protonmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0258.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:194::11) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LO4P265MB6823:EE_
X-MS-Office365-Filtering-Correlation-Id: 34c1f314-2ae1-4f06-0302-08db310ed95e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nYq6eMAqnc1qLsO62C8eT19cMJDHZwdemHv/nomAygkPARB5QLG/X3hr7Y71C6bdEt9asxcmPcCy6he1d9z0lwWtKX8E9YG6Ovq7M++0fLknCHOJXx6ylSgc9p0eWL22ySvbFGzWFoky67aqNx2LTLjhI0+ObB3y1xSHsvTre+FHiHYy+2Sg0KGA9THVAWJyj3gEBqP9nl9T9cmPMciQ39dd4V3Y+jDWB0nssdu8yrnGx0Xvm0zcKsLCGPn9Wo1CelcKRc7iVBbyKFJxasaRrtueCpGmzf0Ctnva4KtrWSaIDbPNjWHlWXZwI3yHb3fbjJkLJeF4d5A2YjZwti3Pm6mn6hI4hVe6kQ4ajO3DxlV0RSuht/Nd9OVV4oXbYPsAAYCWkrGVqOEmJLKoFlxpOMWoRYfg026XgDBc2eH6pam6hbXlPQ12nPHWpdOwLry2Jmkd7v/T+ad4uvO3N8Yp7a7oyyyHQ1j+MpsqAa+KPH/KLqoRIw/mVW1q2ol/bldAMcQeozNFGKMgulFcZ7LUxos9CdkX5G7ulCzsb4nbdDNvqyHINWhCYRR9HxtEVHmq3plR+cPR+Ijv3+zH27nmV0s3u2PL8b288sPp3Xuij+I=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(396003)(366004)(39840400004)(376002)(451199021)(41300700001)(8936002)(83380400001)(7416002)(5660300002)(2616005)(8676002)(66476007)(4326008)(66556008)(66946007)(6916009)(6512007)(1076003)(86362001)(26005)(316002)(6506007)(2906002)(36756003)(478600001)(186003)(6486002)(54906003)(38100700002)(81973001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0JQ6I4slB19ggEHIY+q0EtZTW5gRX696t3QW3UJbqsV6D0ETT43cHoZVHeo3?=
 =?us-ascii?Q?mRS2Eyf5RnRDia51bRFE3ckgg31kq15WTKSsXMiiajv6vXaR5VLUQff5yjaw?=
 =?us-ascii?Q?UY1r0J+ms3dNkw/GI7jEcQSsGt4g4wrPa1UiCP7aDbLFSzUDDUt2wrPEOiEK?=
 =?us-ascii?Q?Cx1LWkcdOjgzmjG0lkqax1Xo/2MzQiciyCQ2VO77fYcgC3kILehjHGLmKMfh?=
 =?us-ascii?Q?6CoXFn1D3FSo0gMRBm5yHoOR1DZAp094CcSZe5jG/ivjG4TQHH9kQBJhyQ9D?=
 =?us-ascii?Q?xO//TG46jsGD2hDW2yMvO31GTRsFDYHbRQ+RiPVq8ZA5ca8qp2pJfHfFpx5Y?=
 =?us-ascii?Q?Tztnpd8I60YsuzAKorrpy031PvkCfe2X2REwnH/n1DkkSNWgrY0qniLwLCL+?=
 =?us-ascii?Q?7nKuQPPAvvclL47m/n+Jmw/AhnK6xkvQNPCqcNYIXglGdxtQDlLplpMjnWE0?=
 =?us-ascii?Q?Az/OwZ0kfrRwOXF9IVOTij7DhZPGBrTcNATRj8t3ziCM2AOzEycMFcU4Uf6+?=
 =?us-ascii?Q?mHXsEqP8euHSZUGhDkbaNkaxljXyE8lsyRCz8ndnnqME2BIV7KQ6x+EcmtqI?=
 =?us-ascii?Q?KP+p1UNg8bERfgxDV3p/j1lcfgKFYtbsiZRMRdbxiPG2Ffvn19Q8v2z6YjWK?=
 =?us-ascii?Q?+7DIrYk2rYub+gprLRa/VAe72cM5vr+Xy/R+5t4o39qk6nXhkHm0q5lpVx/b?=
 =?us-ascii?Q?HamcLAx/MLPBtDL3UzSKiikaNtOPBxZnNSNghWQGHE206iV9or8dmUK/gkjz?=
 =?us-ascii?Q?CJ/J2jJji/f1NbBJ3AZdY/jrRg3WKBVtBSfi/VXAtGP8zD332R9yoh1YDAx0?=
 =?us-ascii?Q?cD+GcBsHi+sQvFCOuwAovnUj62zgzZDyMkCmUGqJXROVz9QOePKPmiee5Pg+?=
 =?us-ascii?Q?6yk9bj+/QLiPzlE7lhyzTH+C/2DRJtYVUVn/vJ6RJWBUCI+J8ovIb7mAJt92?=
 =?us-ascii?Q?oA4rOOsOKKscIWx+5gBEZDXajGEP6j8wr2pmfpYinKdpeqPyu8ypZT3WeteW?=
 =?us-ascii?Q?mqxH2V7uURN6ctP9veZd6I1Q6YnrQrmDP+P+czGcxQ3Hr1B0jh9YZO229DG3?=
 =?us-ascii?Q?Xgx2VUvqaFSfxJU033R8uXVLz32Es9KfvCiULjDwnmyvOs9dnUwLkdtDwvmj?=
 =?us-ascii?Q?JupslFyJ3jY2ATo3Y9WekCtvINUeZ5r+B3GyykUwbluYpOyG1HneeKI1mOWg?=
 =?us-ascii?Q?2mZQKmE960cv1i/WeMByZwoHdVsylolckis1cEGuY1nzvXmZTokrkJ4L7D7N?=
 =?us-ascii?Q?M34zFkPGxcX1KInIsomjwcJU2+nf5VHtb9xyjDX8Aq9EAUENvPt3zTuc+D4G?=
 =?us-ascii?Q?KrNFLoQlxvpimOMBwQfojdQu1EDAH8QOhJrzMXRKtPg15VVZQYBlLsJbdPyb?=
 =?us-ascii?Q?n5cYgNH6+WVMacMkq1WGy7yp3QXdjcWRQG2U5/4RLLYtqwru/dQOsuPeNTlW?=
 =?us-ascii?Q?lfl4plGC03103kpD4+eviOI4Zi9xpWx3goxgpwXhbWfnff07Z5jdtnYX25QZ?=
 =?us-ascii?Q?pA4Bjh3ocBk1R5EH1mm4x+V/b2STRHpt5s8kvwIH+852nQcZNpCrOcfSuLli?=
 =?us-ascii?Q?z6Z8MsD5ArlfdrEmyHSK2cumse+tdHG3yP7qHnzB?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 34c1f314-2ae1-4f06-0302-08db310ed95e
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 11:06:45.0638
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3J2PXmnSPzVcCvwsgytTBLM0PhIUnmxPQqFCx8OG06OtFGmI9G3oZvkYnEPSn7jpsMqyl0jDBJODHff2lmJRPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO4P265MB6823
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Mar 2023 22:33:35 +0000
y86-dev@protonmail.com wrote:

> From: Benno Lossin <y86-dev@protonmail.com>
> 
> Add the `Zeroable` trait which marks types that can be initialized by
> writing `0x00` to every byte of the type. Also add the `init::zeroed`
> function that creates an initializer for a `Zeroable` type that writes
> `0x00` to every byte.
> 
> Signed-off-by: Benno Lossin <y86-dev@protonmail.com>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  rust/kernel/init.rs | 65 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 65 insertions(+)
> 
> diff --git a/rust/kernel/init.rs b/rust/kernel/init.rs
> index 3358f14beffb..a923546696ce 100644
> --- a/rust/kernel/init.rs
> +++ b/rust/kernel/init.rs
> @@ -1254,3 +1254,68 @@ pub unsafe trait PinnedDrop: __internal::HasPinData {
>      /// automatically.
>      fn drop(self: Pin<&mut Self>, only_call_from_drop: __internal::OnlyCallFromDrop);
>  }
> +
> +/// Marker trait for types that can be initialized by writing just zeroes.
> +///
> +/// # Safety
> +///
> +/// The bit pattern consisting of only zeroes is a valid bit pattern for this type. In other words,
> +/// this is not UB:
> +///
> +/// ```rust,ignore
> +/// let val: Self = unsafe { core::mem::zeroed() };
> +/// ```
> +pub unsafe trait Zeroable {}
> +
> +/// Create a new zeroed T.
> +///
> +/// The returned initializer will write `0x00` to every byte of the given `slot`.
> +#[inline]
> +pub fn zeroed<T: Zeroable + Unpin>() -> impl Init<T> {
> +    // SAFETY: Because `T: Zeroable`, all bytes zero is a valid bit pattern for `T`
> +    // and because we write all zeroes, the memory is initialized.
> +    unsafe {
> +        init_from_closure(|slot: *mut T| {
> +            slot.write_bytes(0, 1);
> +            Ok(())
> +        })
> +    }
> +}
> +
> +macro_rules! impl_zeroable {
> +    ($($t:ty, )*) => {
> +        $(unsafe impl Zeroable for $t {})*
> +    };
> +}
> +
> +impl_zeroable! {
> +    // SAFETY: All primitives that are allowed to be zero.
> +    bool,
> +    char,
> +    u8, u16, u32, u64, u128, usize,
> +    i8, i16, i32, i64, i128, isize,
> +    f32, f64,
> +    // SAFETY: There is nothing to zero.
> +    core::marker::PhantomPinned, Infallible, (),
> +}
> +
> +// SAFETY: We are allowed to zero padding bytes.
> +unsafe impl<const N: usize, T: Zeroable> Zeroable for [T; N] {}
> +
> +// SAFETY: There is nothing to zero.
> +unsafe impl<T: ?Sized> Zeroable for PhantomData<T> {}
> +
> +// SAFETY: `null` pointer is valid.
> +unsafe impl<T: ?Sized> Zeroable for *mut T {}
> +unsafe impl<T: ?Sized> Zeroable for *const T {}
> +
> +macro_rules! impl_tuple_zeroable {
> +    ($(,)?) => {};
> +    ($first:ident, $($t:ident),* $(,)?) => {
> +        // SAFETY: All elements are zeroable and padding can be zero.
> +        unsafe impl<$first: Zeroable, $($t: Zeroable),*> Zeroable for ($first, $($t),*) {}
> +        impl_tuple_zeroable!($($t),* ,);
> +    }
> +}
> +
> +impl_tuple_zeroable!(A, B, C, D, E, F, G, H, I, J);
> --
> 2.39.2
> 
> 

