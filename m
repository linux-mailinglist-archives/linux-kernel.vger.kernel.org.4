Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD8E96D62BC
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 15:24:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234723AbjDDNYY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 09:24:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234248AbjDDNYV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 09:24:21 -0400
Received: from GBR01-CWL-obe.outbound.protection.outlook.com (mail-cwlgbr01on2093.outbound.protection.outlook.com [40.107.11.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3F242683;
        Tue,  4 Apr 2023 06:24:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PjzhwNjoBe8Wekgoog86V5tfYoo7tuy8IhXI/9m1O8w6IELiZCsPaKVEmPMAZMDFsfOAfIYB8rIgoGml6I5RpPjHcXIwqd9VCjv8JOrGkFr6jGtPnJqCM0X0/hrweyJMN9m4RqmkLMWzrwLD556Jp7Kbgk6Akk1wPGAeYnaIBsxR0zcMm7USmFR8bpMwm1xsAIyrEc1MDg5Z6B78stKuKP8jdqD8fiPwPhO6nPVDghwv+eNjsXVVruB6W9oLyBgY1pKZIqP2wuyj9AFfMqJ+yNR7GoLajXIE6C4d9PiXGgJIzee/cdZDJI06hSgny0Y9BfOklHkyVfxt9JfsyFxZ+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zvy+c5bkdoERtIy0xSy1eKOHIIio+A7fkjBfsd6b+TE=;
 b=hW9X1vZVLB269qdJW77+7kWXNr1wo5zhPwGss1qs26TqE1Q5Jx+b5vND/k/N7R2nwKP2a3VDKTDw+kqHMQOka2nJK6VFi0EiWtfzhCNrvyW9hmxVpoqwbDUDsQl7dhtIlxR/g9kp35jq2MMi4TBeeSo+TGKzZ1LEeDE4UzH7x8LVbj6CGz762oplsPeFXrDH77BCJ37gKOA+I8wQ+KDmHIyS/CD27BULGCjBfXOtxt9FEE3mOcolVn0epavcHWenaUkKjTk09oBgaQMzR29x2rygxMLOYf3CTqeiCDfb6famIAugG2K9RGtUs1ypo3sKty4JKgwfgT6xIdEixWPIYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zvy+c5bkdoERtIy0xSy1eKOHIIio+A7fkjBfsd6b+TE=;
 b=zjEYIZIGk+Rhl76VAz/SiDzfz2i/z2fF4RznytqCTZcrYTtaD54IupuTcZlPF0XWFuVLSPI9QzIA9uNRNxcHpJjtzwnORO9ZcSd6ZYeXCMn8X4ZpX6WxhyXfbL+8mCEWGAsu9ldUOTrA0iDXT8lE8klrn2gLhWBmSmPZcjiCmFU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LO6P265MB6378.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:2da::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Tue, 4 Apr
 2023 13:24:17 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::e1a3:5e38:b483:8161]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::e1a3:5e38:b483:8161%5]) with mapi id 15.20.6254.035; Tue, 4 Apr 2023
 13:24:17 +0000
Date:   Tue, 4 Apr 2023 14:24:15 +0100
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
Subject: Re: [PATCH v5 11/15] rust: init: add `Zeroable` trait and
 `init::zeroed` function
Message-ID: <20230404142415.00ccaa22.gary@garyguo.net>
In-Reply-To: <20230403160511.174894-4-y86-dev@protonmail.com>
References: <20230403154422.168633-1-y86-dev@protonmail.com>
        <20230403160511.174894-4-y86-dev@protonmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO0P265CA0004.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:355::14) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LO6P265MB6378:EE_
X-MS-Office365-Filtering-Correlation-Id: c1684a6d-ade3-46c4-55e3-08db350fe41a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Qmc+P3zCZir7Utcy4rft8ptH4J1RTKE79CWtAoJZ8UCTKZ5DlzomUrcDzM1jyQeAJJ/vRxIHg2AU4/jkhIBkGHlRnCxY+bxGwiXphpJOYO6x7FcBGKp1zODaVGcatRlGNJYNCYtqYy/z38/yymZoxA9sSZQ9skN9s76nuIrpBB1rWNUKtzCoY+OoNks95eJHa1lde7M+dTLR8gz7cYBmCiXrMVFvMA/KHMHq4U09G07JKQ4deNrIapz1w81q/bo4d7FGkuoT5i9MwwzNf7arcek6IfUzw2E6NdgwWwxGp0iqcMxJv9Bsv/00VCS27euJA5784e88z4BZjJjMgG4tLBrzt1cNlwywcBAtgoZvmR4yBL4AF4lyFicRMzaS7O2SyUgG7Uu8O7JVSN+69sR4nM7wlVUsxO1QI7TSm8GbIFEq2FCbw5Qnm/lj1TiIOw3/NuW0yWhAKZkcSeWR4BVYdiVmMoqG73+ILLW0xyw/D0Hf7WTCbzITKCPjxIzg56LDYAyuRtdWI4N1YoQ88EJyCYBZEcuDrkrOWOiDcXsf1p6caN3ot5dp+KwB0e5/N4YAn54ovoCEpXg7awjttxjTOQYbMyx93rhp8Q/RAqTv3X0Q34O89PacerYE79aIyLN6Ft/Q5HEeQ7wR/JOT3PgZtw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(39830400003)(136003)(376002)(346002)(396003)(366004)(451199021)(186003)(26005)(6506007)(41300700001)(4326008)(2616005)(1076003)(6916009)(316002)(6512007)(66476007)(66946007)(54906003)(478600001)(38100700002)(8676002)(6486002)(66556008)(36756003)(86362001)(7416002)(2906002)(83380400001)(8936002)(5660300002)(81973001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mRjp2ychZphZNt1a6+q/4AybbPusS1BM7wN0q85WLFVsAbKNO5wiuSmRDYZN?=
 =?us-ascii?Q?7opqHq+gOdrGZHn92s2U5v25tNR0wDlcc8XGC2/Fujlv39yfjInqu+QDGsCw?=
 =?us-ascii?Q?mQneInfbFptLcieynpNkq6y4Tv78SrGVbuFc63e6pDTLpFx+zjc2NvTznC+h?=
 =?us-ascii?Q?uNb8kzJSdUy8maTCpvhfLxDYoloZwDcUN0vXOVHUsB6xrIqVSmKuIn/arsxS?=
 =?us-ascii?Q?AD7sxffziQlBQBXjFOBqJzIHBvYl9jt/nz/S2TomSAd9mc1geSTRaGeeashp?=
 =?us-ascii?Q?cXuIPhOgn2LHu4z6FkJLUzqnrM+UZ/Rp7WP8tgXC6/tCoFarO1fq7/iO0Qd8?=
 =?us-ascii?Q?QhGk/1p/RbJ73n7prW/SmIDKsuM0oBraqWScMlUBxfY8xGiJnFfnjGei2hCp?=
 =?us-ascii?Q?4uWTD6rgN5/zsIRPbXuvctfkXzwy73W2uI+s53yJG7PDKwCnD5pql6bW81hn?=
 =?us-ascii?Q?erqknjCf/5cg8wcKSDHcdDQ06rvpSDShCNfXVqd0tVRkBus6wUFzplf4R1Sr?=
 =?us-ascii?Q?xY/Zr4P4tskTsI9pFCxLaLVuy62lSPsJIy9ZVk2xIAmmPSvgVX70iSkU5Ypc?=
 =?us-ascii?Q?tDy18rOMhVGRfjKn50lcAQh9IpZUTw9E16yH8Qog/JRWtvBbjbMjlEbH19QS?=
 =?us-ascii?Q?X8lzMqCKPHwd56IGRVIx/jyz+ToijcV6PNyPhpnf3/r7Ohults3BTIsf4obS?=
 =?us-ascii?Q?WgmN9Qncp+CM67vx/uLgvMC+jiZpUye1J55L/zoDN6V7AcPUfBeTt47TuCpg?=
 =?us-ascii?Q?Poxw6YhBciNT9syeyQPBuQnz7Vb9G4u4ydtTnKL1dYYrt5RsCbDtvSZdd+Xy?=
 =?us-ascii?Q?Da9MPsRRH1rx/Tq/vf3VSMCd/+A9+KxXBbuxBuu+8G3/y649+A7udKDxibUz?=
 =?us-ascii?Q?dlSt/Wxg7RXMPzQNDE5kmqfALcZOfEuIfw1F/XbbAa2iTk/S8Hym5NT2vonk?=
 =?us-ascii?Q?kIPZNP947TainJziFWDrcdH5bYvXOEuvlIDEuJns6MzsNMLshrBXqi7GBna8?=
 =?us-ascii?Q?Icg2cl44sxZM74scpBrYEfutvURm1OcEotOx1poqenEX1QuUtadbfI4dLCLS?=
 =?us-ascii?Q?wlg3GR70pgPV6b9rt27xj1uRWN3GAMAAqPALBEnU+qzsNA+EkHUUmGfiZo22?=
 =?us-ascii?Q?9bStnEvUrg1BxLlAXzLwG0sOXDieM9/7cDw1n3DJpXqF+vMm/CgbnUE9MxB/?=
 =?us-ascii?Q?wz/wSdB1UEHsMpUx3O+WiXRvClvG029PEwEbqKLRbbfJPsT6PR+hhPq/GR5F?=
 =?us-ascii?Q?nUrmvpy3qmBumMbe0Y7x6rDrmxKVbvulsM7N9n4j4Ws2v9+t/Cb6Gpbd0VFx?=
 =?us-ascii?Q?2SWczqYA4W50mZjEg8w7WG4HpaKwCVIQu9kScw+hKlTewM8cMj4EvhDJEuXG?=
 =?us-ascii?Q?bVQE9zWV5wkgRU2YIbF0KZrn15bDslIycshtiEkQiVrU6PLx3wQ9YG/o4BRD?=
 =?us-ascii?Q?1/edRvvjEVdd8DbfXjyn7tNq6uZ80XNE4m5ezmneJh1B5jBzCZCpWUnqZU6f?=
 =?us-ascii?Q?EVv0wsOga+B4GkoGxg55UA3fuQ7jhyEcaGB167GZrlaglATpdsbfocIDKX9x?=
 =?us-ascii?Q?jczw6SufMmz2J1hUEsQrlr8A66WyUqj8PVTcGPwE?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: c1684a6d-ade3-46c4-55e3-08db350fe41a
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2023 13:24:17.2545
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RQjNITBbXOWn73IJlVhalSwlx7YcZx68t+7ZHEOOydgc6TwHP8M5Jk6mwJjYo5wLawQ7R14WEg/oY5YN8gW8FQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO6P265MB6378
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 03 Apr 2023 16:05:40 +0000
Benno Lossin <y86-dev@protonmail.com> wrote:

> Add the `Zeroable` trait which marks types that can be initialized by
> writing `0x00` to every byte of the type. Also add the `init::zeroed`
> function that creates an initializer for a `Zeroable` type that writes
> `0x00` to every byte.
> 
> Signed-off-by: Benno Lossin <y86-dev@protonmail.com>
> Cc: Gary Guo <gary@garyguo.net>
> Cc: Alice Ryhl <aliceryhl@google.com>
> Cc: Andreas Hindborg <a.hindborg@samsung.com>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  rust/kernel/init.rs | 94 ++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 92 insertions(+), 2 deletions(-)
> 
> diff --git a/rust/kernel/init.rs b/rust/kernel/init.rs
> index 1343cafdd760..09bba4e86ace 100644
> --- a/rust/kernel/init.rs
> +++ b/rust/kernel/init.rs
> @@ -195,8 +195,14 @@ use crate::{
>  };
>  use alloc::boxed::Box;
>  use core::{
> -    alloc::AllocError, cell::Cell, convert::Infallible, marker::PhantomData, mem::MaybeUninit,
> -    pin::Pin, ptr,
> +    alloc::AllocError,
> +    cell::Cell,
> +    convert::Infallible,
> +    marker::PhantomData,
> +    mem::MaybeUninit,
> +    num::*,
> +    pin::Pin,
> +    ptr::{self, NonNull},
>  };
> 
>  #[doc(hidden)]
> @@ -1329,3 +1335,87 @@ pub unsafe trait PinnedDrop: __internal::HasPinData {
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
> +    ($($({$($generics:tt)*})? $t:ty, )*) => {
> +        $(unsafe impl$($($generics)*)? Zeroable for $t {})*
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
> +
> +    // SAFETY: These are ZSTs, there is nothing to zero.
> +    {<T: ?Sized>} PhantomData<T>, core::marker::PhantomPinned, Infallible, (),
> +
> +    // SAFETY: Type is allowed to take any value, including all zeros.
> +    {<T>} MaybeUninit<T>,
> +
> +    // SAFETY: All zeros is equivalent to `None` (option layout optimization guarantee).
> +    Option<NonZeroU8>, Option<NonZeroU16>, Option<NonZeroU32>, Option<NonZeroU64>,
> +    Option<NonZeroU128>, Option<NonZeroUsize>,
> +    Option<NonZeroI8>, Option<NonZeroI16>, Option<NonZeroI32>, Option<NonZeroI64>,
> +    Option<NonZeroI128>, Option<NonZeroIsize>,
> +
> +    // SAFETY: All zeros is equivalent to `None` (option layout optimization guarantee).
> +    //
> +    // In this case we are allowed to use `T: ?Sized`, since all zeros is the `None` variant.
> +    {<T: ?Sized>} Option<NonNull<T>>,
> +    {<T: ?Sized>} Option<Box<T>>,
> +
> +    // SAFETY: `null` pointer is valid.
> +    //
> +    // We cannot use `T: ?Sized`, since the VTABLE pointer part of fat pointers is not allowed to be
> +    // null.
> +    {<T>} *mut T, {<T>} *const T,
> +
> +    // SAFETY: `null` pointer is valid and the metadata part of these fat pointers is allowed to be
> +    // zero.
> +    {<T>} *mut [T], {<T>} *const [T], *mut str, *const str,

Just a note: if `Pointee` trait is stabilised, this could be changed to

impl<T: ?Sized> Zeroable for *const T where <T as Pointee>::Metadata: Zeroable {}

> +
> +    // SAFETY: `T` is `Zeroable`.
> +    {<const N: usize, T: Zeroable>} [T; N], {<T: Zeroable>} Wrapping<T>,
> +}
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

