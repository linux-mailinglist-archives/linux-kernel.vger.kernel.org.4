Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45AF96BBDC2
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 21:07:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232313AbjCOUHg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 16:07:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbjCOUHe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 16:07:34 -0400
Received: from GBR01-LO2-obe.outbound.protection.outlook.com (mail-lo2gbr01on2136.outbound.protection.outlook.com [40.107.10.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE8501CF40;
        Wed, 15 Mar 2023 13:07:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TonU8jp/vYmReqB+iY6xDq6QGlUT4+yOxGHkCwTEPmsHsHiOKmn1yPAwhPrM7L+CaHSR+26J47E00dmnwfQysW/X1em/2RFEZUitPc9YZwtR4Mkh7kP5eKUC1JgvSLq4h+6ltJYnZnJaZfy8PCx480LVPZbHuIHvgroCfXBCStn4VC2Tqgu4ovHN2V8z9yv0gx1gV71NDXi7QcFPZODqAAL/PGW08/xVbqNQoXHIzNoTKuJ10uo2LJE0ubBGPVL6ev4x94vPzn5+I3Rdi/VVuVDFBLk3AW/cyNWYZR/oc9FVKUaabbNFmKh4IEWxLgFseakqe4I1jcQLQKXWvDBxTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EhvVHLuIrNQQQ0pG1uU5Sn0Xgt7f0C/cjzSabKrTeR8=;
 b=LgTTd94p6KUDB/DgpkkB6hf4pBisTewnktEoUf/xLXCjBfX+1wfcXxcRTW+gkmJoM2oD1nnQO3vMSxV3N91T+Cxc6BF20tQMMTvwkxJ+QBmUm6YilaVQty9gjbmzokQ5+DweJ/K4xXFyXe7AGSH/oVYErc3EWhTS4R+ivJ+SWbtNOkn6RcQTaicMNhLmR7qCd8FbjbZwTfmolcbAJU1hoYCKTWMBbzSTnnFR6ZsOkj+y/d0sCTxafpAt4Dc7SZlVEAqAzqZQntj64weMs+INJ2USOiQnYmDHFRrXbbepo3Dw2+rw85kUfBHsAcTn8/SoIc/Y1sA0UavmxDlRRb73UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EhvVHLuIrNQQQ0pG1uU5Sn0Xgt7f0C/cjzSabKrTeR8=;
 b=rvW7d+jfV3WAx70SUswqcpXT/cJYe+FlsMP7EWvJPRE6oudxvKlDrX8tpo5DNG8Vp5p0TphHz2JoigasWFh51Hcj6VtUvTFEFuHLq+LTm1cPqZj8ZBMfTvK96pHSAcDMJS3k4Si7B0aTlzHveZfLyV0FTuBqXwb+cB19ydhyXPE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LOYP265MB1839.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:e5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.30; Wed, 15 Mar
 2023 20:07:26 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::2f2a:55d4:ea1d:dece]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::2f2a:55d4:ea1d:dece%3]) with mapi id 15.20.6178.029; Wed, 15 Mar 2023
 20:07:26 +0000
Date:   Wed, 15 Mar 2023 20:07:22 +0000
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
Message-ID: <20230315200722.57487341.gary@garyguo.net>
In-Reply-To: <D0mWM1KEcWLeFa7IIqPygHlXRTD6gRFHvJKaegYzQXo9zTx7YbSpVLeYLFfq53s2S30Wx7v0khkPMOy6Ng5HiNZ5x7TXtOyLB58vUHtq6ro=@protonmail.com>
References: <D0mWM1KEcWLeFa7IIqPygHlXRTD6gRFHvJKaegYzQXo9zTx7YbSpVLeYLFfq53s2S30Wx7v0khkPMOy6Ng5HiNZ5x7TXtOyLB58vUHtq6ro=@protonmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LNXP265CA0065.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5d::29) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LOYP265MB1839:EE_
X-MS-Office365-Filtering-Correlation-Id: a0cfc757-ab8b-48af-0a46-08db2590e5f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LK6YT55HQ9stanbgYjMWFIUpAGl31CmV6bpEGCoQ0230Ea0DJQPD+H+1YPywXBj6ITWe60nD9qDHpQ1rgGvC5KGHpbMH4LG04mAiS3s2xKCaO0iun5RxPTmylDui1Vr0CvoukoiJ0U8P/JmojN+GUvFeDtDvTmhsVAFh219+iIlITKIdP/NQEnyvVmjTnvjdDJxnG3agzLmwLe3YKSfNSgp7gEmc5XYe1BLc97275drIOoWWvPAXzcrIcngW0jCIc2LzMSP2RK8YOWN/3/74FFZDe+sqQ+SLBK0bnJvOifqeoR7pTw1p1MYROYTlNCavZVA+XKvh+K0q3ZZc0E0DODC8mCyPe/6KrMbKrXCTNkrlSKQFzRU6JomLq1CsRtoJdZbYdbS0juO1ArETW2GJPAAzHc1JnbuLc3OJK0c1gRw/OeA7yYKx8jTMKbtBN/kfmq60xtiKFjB9CmWgwFnvKxuFiHfxNSSC5LtJJAovWUZYiiXFoiJrSou2/zBvOrwcAyoNqSS9B0/Gxhj1VMNUp+72GQgxEadFoK0yISa//6Lp0VZBSgU8BWv9Sr4I5+SAIfgrZGJ10ul0fnbXKZHWR7PdHXEwSMu10FNsRuMLNEi7wo2UEXFNHn6MQIeiDVBTeg3rGcPw16B4yn2uOXmrqA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(39830400003)(366004)(136003)(396003)(376002)(346002)(451199018)(2616005)(6666004)(2906002)(6486002)(1076003)(478600001)(83380400001)(316002)(6512007)(6506007)(66899018)(54906003)(186003)(26005)(8676002)(6916009)(4326008)(41300700001)(8936002)(66556008)(66476007)(66946007)(5660300002)(30864003)(38100700002)(86362001)(36756003)(579004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6/HOuomKA0jfkF6iT7YoVcfww1tVq+pebRHyHH8Yrp4NO85sc6Ou/1ZWPIav?=
 =?us-ascii?Q?qvwjkTHTTAtnAFk9uQPzdYrRYNxoiMu/TyzYYrhn8Qw9ePPOGShpjiUSfdc2?=
 =?us-ascii?Q?sF3JlVm2iDfIRpdhV759QjbwcLdi1QkoPgwzytPeADePBr1ExzmeLjKW0W39?=
 =?us-ascii?Q?P5dNY5VNJMV+jdQJyF8LFjaAn8KWX6RZX27Z/afEp/YvAE6KCjNZah2xCOIy?=
 =?us-ascii?Q?aJ+gmoYJ98znKVNnFSqeFBchI+QYp4jh7qJibbyXrIuSi7I+ypkPtVynfWhI?=
 =?us-ascii?Q?SqD9p/6Ui/VToBpI0+2hMvyoJ9sH7QU13BPqFhNEAn9EOeoymkW2feUgcd3P?=
 =?us-ascii?Q?h4scizPFtTKVklpHcyzYsKFU2kNSMNie/Cmr9MW5R5Cc6n2sbD8sp+zsBx3Y?=
 =?us-ascii?Q?uriWCXcvwEsJwWcgK7FLZXuILlkNYPJM/o/CiP6Ryq9MoO/JjO9b736JG8gW?=
 =?us-ascii?Q?WXdH1IOsPV1B0/ziyOj2CznYUCN+krBLKp12V3OWqtXd+yTtf5+RwaqTMDYT?=
 =?us-ascii?Q?3QaxU9uFPahF8KBjYCGrkUAi6tOiSsFXUzr7SkVvqMHT9XpQN143QiLHQnxG?=
 =?us-ascii?Q?jk3p8if6PNToRBgbaZn4L3i9DB2Xag0k4GHXGRyikLZZuwXYXTcWeUFKYzBE?=
 =?us-ascii?Q?3+V7aKLl8ZrFeajZJkmmfEdb5fRocso1+i3ymSJ6IQPBV0sXj5aGXsgJtnQp?=
 =?us-ascii?Q?unzcFANw5d1y3SQk3xr81oyNtB7Jv+cm5TbuyXGqkQW1mEXB8qSqLC7jkazB?=
 =?us-ascii?Q?mjU1glwwrgTdMV9ADQaXoEGYXJOhpTim8cqYCs9+dOOTfYeN9zUO1SSePVmL?=
 =?us-ascii?Q?/7S9cprssh8STga6Z40KsXMwom8PBdlOG0eNsxSB23tHDercNXR6ktHfixes?=
 =?us-ascii?Q?aY9/W09KcVr/kVBuutlrYfdsSCLrO8HlL67hipJ3jmFfXiXwGP60y1pQThrJ?=
 =?us-ascii?Q?H103ir9oUwI2c44NltFs/WpJFXw3f8rAEvA+kMrjRxSoPeRrKD+bm15YhgaV?=
 =?us-ascii?Q?nTtGsSLczSY+WwjWuB+EmJjbhVk92yHbGLWY1xmxNgdUrIbg8wnFHjpJRuSJ?=
 =?us-ascii?Q?Kv7QLshhM7mi2VuKHgdbvMXDTb5QF8/aUZMrnGyjUo6zwX5Lz7k5+jMBFY75?=
 =?us-ascii?Q?ep8KRpMQrOPeogHEv30cXPKQH5MXp0SnUBBIIbqTw86sXzM90XIfzAlQqZ5L?=
 =?us-ascii?Q?EGzfRNyCICmh6qlWMOShKvFajfY7b3w3OxVmH+jN3mISwYGfeonDWjBfgt1F?=
 =?us-ascii?Q?WfjGGzJMNn4eOxSEKoNUuPawB5h98FUlIgOToyN8dMj87F3k4mUPnu8tJDB4?=
 =?us-ascii?Q?5nMszHq96NomFVQv6kzERkULUX4UJd5T6SIglRvvbU4qylDIplzVJ4TPm1Wu?=
 =?us-ascii?Q?WjIFeq4KxHpJhwnQNwMrAn3H7M/eDuWjwRJyjloOOHnirUHV1dW1zUYbp+AE?=
 =?us-ascii?Q?4X7hNs4yo2lA8+ucbMM1eBbDtgIZmjZts9lf+Up/p5qZfCIrPYKZVwdUwXfm?=
 =?us-ascii?Q?5laWx3llrJk5Dh67X1lmDPdCxH1f/1snDAZAv93gilg4GK537/Sge9esuR8/?=
 =?us-ascii?Q?aUtdgOEQG3RuKPe3S2nuVpq3JYnp2zdSxqCOb8Nz?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: a0cfc757-ab8b-48af-0a46-08db2590e5f2
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2023 20:07:26.7981
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tAM/k4alw95EHHWjzAMMBrjAuG3pekQtddXjlypmd3qQNiv5RVpmWPiiKWvd7KUNe8rp7vdwbVjhOnweFz4mAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOYP265MB1839
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Mar 2023 01:23:52 +0000
y86-dev <y86-dev@protonmail.com> wrote:

> +
> +#[macro_export]
> +macro_rules! pin_init {
> +    ($(&$this:ident in)? $t:ident $(<$($generics:ty),* $(,)?>)? {

For this part here, I would suggest the syntax to be

$t:ident $(:: <$($generics:ty),* $(,)?>)

so that it's compatible with struct expression syntax.

> +        $($fields:tt)*
> +    }) => {
> +        $crate::try_pin_init!(
> +            @this($($this)?),
> +            @type_name($t),
> +            @typ($t $(<$($generics),*>)?),
> +            @fields($($fields)*),
> +            @error(::core::convert::Infallible),
> +        )
> +    };
> +}
> +
> +#[macro_export]
> +macro_rules! try_pin_init {
> +    ($(&$this:ident in)? $t:ident $(<$($generics:ty),* $(,)?>)? {
> +        $($fields:tt)*
> +    }) => {
> +        $crate::try_pin_init!(
> +            @this($($this)?),
> +            @type_name($t),
> +            @typ($t $(<$($generics),*>)?),
> +            @fields($($fields)*),
> +            @error($crate::error::Error),
> +        )
> +    };
> +    ($(&$this:ident in)? $t:ident $(<$($generics:ty),* $(,)?>)? {
> +        $($fields:tt)*
> +    }? $err:ty) => {
> +        $crate::try_pin_init!(
> +            @this($($this)?),
> +            @type_name($t),
> +            @typ($t $(<$($generics),*>)?),
> +            @fields($($fields)*),
> +            @error($err),
> +        )
> +    };
> +    (
> +        @this($($this:ident)?),
> +        @type_name($t:ident),
> +        @typ($ty:ty),
> +        @fields($($fields:tt)*),
> +        @error($err:ty),
> +    ) => {{
> +        // We do not want to allow arbitrary returns, so we declare this type as the `Ok` return
> +        // type and shadow it later when we insert the arbitrary user code. That way there will be
> +        // no possibility of returning without `unsafe`.
> +        struct __InitOk;
> +        let init = move |slot: *mut $ty| -> ::core::result::Result<__InitOk, $err> {
> +            {
> +                // Shadow the structure so it cannot be used to return early.
> +                struct __InitOk;
> +                // Create the `this` so it can be referenced by the user inside of the expressions
> +                // creating the individual fields.
> +                $(let $this = unsafe { ::core::ptr::NonNull::new_unchecked(slot) };)?
> +                // Initialize every field.
> +                $crate::try_pin_init!(init_slot:
> +                    @typ($ty),
> +                    @slot(slot),
> +                    @munch_fields($($fields)*,),
> +                );
> +                // We use unreachable code to ensure that all fields have been mentioned exactly
> +                // once, this struct initializer will still be type-checked and complain with a
> +                // very natural error message if a field is forgotten/mentioned more than once.
> +                #[allow(unreachable_code, clippy::diverging_sub_expression)]
> +                if false {
> +                    $crate::try_pin_init!(make_initializer:
> +                        @typ($ty),
> +                        @type_name($t),
> +                        @munch_fields($($fields)*,),
> +                        @acc(),
> +                    );
> +                }
> +                // Forget all guards, since initialization was a success.
> +                $crate::try_pin_init!(forget_guards:
> +                    @munch_fields($($fields)*,),
> +                );
> +            }
> +            Ok(__InitOk)
> +        };
> +        let init = move |slot: *mut $ty| -> ::core::result::Result<(), $err> {
> +            init(slot).map(|__InitOk| ())
> +        };
> +        let init = unsafe { $crate::init::pin_init_from_closure::<$ty, $err>(init) };
> +        init
> +    }};
> +    (init_slot:
> +        @typ($ty:ty),
> +        @slot($slot:ident),
> +        @munch_fields($(,)?),
> +    ) => {
> +        // Endpoint of munching, no fields are left.
> +    };
> +    (init_slot:
> +        @typ($ty:ty),
> +        @slot($slot:ident),
> +        // In-place initialization syntax.
> +        @munch_fields($field:ident <- $val:expr, $($rest:tt)*),
> +    ) => {
> +        let $field = $val;
> +        // Call the initializer.
> +        //
> +        // SAFETY: `slot` is valid, because we are inside of an initializer closure, we
> +        // return when an error/panic occurs.
> +        // We also use the `__PinData` to request the correct trait (`Init` or `PinInit`).
> +        unsafe {
> +            <$ty as $crate::init::__PinData>::__PinData::$field(
> +                ::core::ptr::addr_of_mut!((*$slot).$field),
> +                $field,
> +            )?;
> +        }
> +        // Create the drop guard.
> +        //
> +        // SAFETY: We forget the guard later when initialization has succeeded.
> +        let $field = unsafe {
> +            $crate::init::DropGuard::new(::core::ptr::addr_of_mut!((*$slot).$field))
> +        };
> +        // Only give access to `&DropGuard`, so it cannot be forgotten via safe code.
> +        let $field = &$field;

Instead of shadowing, you can use lifetime extension of `let x = &v` pattern directly:

let $field = &unsafe {
    $crate::init::DropGuard::new(::core::ptr::addr_of_mut!((*$slot).$field))
};

(same for the value init case and the `init!` macro)

> +
> +        $crate::try_pin_init!(init_slot:
> +            @typ($ty),
> +            @slot($slot),
> +            @munch_fields($($rest)*),
> +        );
> +    };
> +    (init_slot:
> +        @typ($ty:ty),
> +        @slot($slot:ident),
> +        // Direct value init, this is safe for every field.
> +        @munch_fields($field:ident $(: $val:expr)?, $($rest:tt)*),
> +    ) => {
> +        $(let $field = $val;)?
> +        // Call the initializer.
> +        //
> +        // SAFETY: The memory at `slot` is uninitialized.
> +        unsafe { ::core::ptr::write(::core::ptr::addr_of_mut!((*$slot).$field), $field) };

Could this be

unsafe { ::core::ptr::addr_of_mut!((*$slot).$field).write($field) };

? Not sure if this has any implication on type inference though.

> +        // Create the drop guard:
> +        //
> +        // SAFETY: We forget the guard later when initialization has succeeded.
> +        let $field = unsafe {
> +            $crate::init::DropGuard::new(::core::ptr::addr_of_mut!((*$slot).$field))
> +        };
> +        // Only give access to `&DropGuard`, so it cannot be accidentally forgotten.
> +        let $field = &$field;
> +
> +        $crate::try_pin_init!(init_slot:
> +            @typ($ty),
> +            @slot($slot),
> +            @munch_fields($($rest)*),
> +        );
> +    };
> +    (make_initializer:
> +        @typ($ty:ty),
> +        @type_name($t:ident),
> +        @munch_fields($(,)?),
> +        @acc($($acc:tt)*),
> +    ) => {
> +        // Endpoint, nothing more to munch.
> +        let _: $ty = $t {
> +            $($acc)*
> +        };
> +    };
> +    (make_initializer:
> +        @typ($ty:ty),
> +        @type_name($t:ident),
> +        @munch_fields($field:ident <- $val:expr, $($rest:tt)*),
> +        @acc($($acc:tt)*),
> +    ) => {
> +        $crate::try_pin_init!(make_initializer:
> +            @typ($ty),
> +            @type_name($t),
> +            @munch_fields($($rest)*),
> +            @acc($($acc)* $field: ::core::panic!(),),
> +        );
> +    };
> +    (make_initializer:
> +        @typ($ty:ty),
> +        @type_name($t:ident),
> +        @munch_fields($field:ident $(: $val:expr)?, $($rest:tt)*),
> +        @acc($($acc:tt)*),
> +    ) => {
> +        $crate::try_pin_init!(make_initializer:
> +            @typ($ty),
> +            @type_name($t),
> +            @munch_fields($($rest)*),
> +            @acc($($acc)* $field: ::core::panic!(),),
> +        );
> +    };
> +    (forget_guards:
> +        @munch_fields($(,)?),
> +    ) => {
> +        // Munching finished.
> +    };
> +    (forget_guards:
> +        @munch_fields($field:ident <- $val:expr, $($rest:tt)*),
> +    ) => {
> +        unsafe { $crate::init::DropGuard::forget($field) };
> +
> +        $crate::try_pin_init!(forget_guards:
> +            @munch_fields($($rest)*),
> +        );
> +    };
> +    (forget_guards:
> +        @munch_fields($field:ident $(: $val:expr)?, $($rest:tt)*),
> +    ) => {
> +        unsafe { $crate::init::DropGuard::forget($field) };
> +
> +        $crate::try_pin_init!(forget_guards:
> +            @munch_fields($($rest)*),
> +        );
> +    };
> +}
> +
> +/// Construct an in-place initializer for `struct`s.
> +///
> +/// This macro defaults the error to [`Infallible`]. If you need [`Error`], then use
> +/// [`try_init!`].
> +///
> +/// The syntax is identical to [`pin_init!`].
> +///
> +/// This initializer is for initializing data in-place that might later be moved. If you want to
> +/// pin-initialize, use [`pin_init!`].
> +#[macro_export]
> +macro_rules! init {
> +    ($(&$this:ident in)? $t:ident $(<$($generics:ty),* $(,)?>)? {
> +        $($fields:tt)*
> +    }) => {
> +        $crate::try_init!(
> +            @this($($this)?),
> +            @type_name($t),
> +            @typ($t $(<$($generics),*>)?),
> +            @fields($($fields)*),
> +            @error(::core::convert::Infallible),
> +        )
> +    }
> +}
> +
> +/// Construct an in-place fallible initializer for `struct`s.
> +///
> +/// This macro defaults the error to [`Error`]. If you need [`Infallible`], then use
> +/// [`init!`].
> +///
> +/// The syntax is identical to [`try_pin_init!`]. If you want to specify a custom error,
> +/// append `? $type` after the `struct` initializer.
> +///
> +/// # Examples
> +///
> +/// ```rust
> +/// use kernel::{init::PinInit, error::Error};
> +/// struct BigBuf {
> +///     big: Box<[u8; 1024 * 1024 * 1024]>,
> +///     small: [u8; 1024 * 1024],
> +/// }
> +///
> +/// impl BigBuf {
> +///     fn new() -> impl Init<Self, Error> {
> +///         try_init!(Self {
> +///             big: {
> +///                 let zero = Box::try_new_zeroed()?;
> +///                 unsafe { zero.assume_init() }
> +///             },
> +///             small: [0; 1024 * 1024],
> +///         }? Error)
> +///     }
> +/// }
> +/// ```
> +#[macro_export]
> +macro_rules! try_init {
> +    ($(&$this:ident in)? $t:ident $(<$($generics:ty),* $(,)?>)? {
> +        $($fields:tt)*
> +    }) => {
> +        $crate::try_init!(
> +            @this($($this)?),
> +            @type_name($t),
> +            @typ($t $(<$($generics),*>)?),
> +            @fields($($fields)*),
> +            @error($crate::error::Error),
> +        )
> +    };
> +    ($(&$this:ident in)? $t:ident $(<$($generics:ty),* $(,)?>)? {
> +        $($fields:tt)*
> +    }? $err:ty) => {
> +        $crate::try_init!(
> +            @this($($this)?),
> +            @type_name($t),
> +            @typ($t $(<$($generics),*>)?),
> +            @fields($($fields)*),
> +            @error($err),
> +        )
> +    };
> +    (
> +        @this($($this:ident)?),
> +        @type_name($t:ident),
> +        @typ($ty:ty),
> +        @fields($($fields:tt)*),
> +        @error($err:ty),
> +    ) => {{
> +        // We do not want to allow arbitrary returns, so we declare this type as the `Ok` return
> +        // type and shadow it later when we insert the arbitrary user code. That way there will be
> +        // no possibility of returning without `unsafe`.
> +        struct __InitOk;
> +        let init = move |slot: *mut $ty| -> ::core::result::Result<__InitOk, $err> {
> +            {
> +                // Shadow the structure so it cannot be used to return early.
> +                struct __InitOk;
> +                // Create the `this` so it can be referenced by the user inside of the expressions
> +                // creating the individual fields.
> +                $(let $this = unsafe { ::core::ptr::NonNull::new_unchecked(slot) };)?
> +                // Initialize every field.
> +                $crate::try_init!(init_slot:
> +                    @typ($ty),
> +                    @slot(slot),
> +                    @munch_fields($($fields)*,),
> +                );
> +                // We use unreachable code to ensure that all fields have been mentioned exactly
> +                // once, this struct initializer will still be type-checked and complain with a
> +                // very natural error message if a field is forgotten/mentioned more than once.
> +                #[allow(unreachable_code, clippy::diverging_sub_expression)]
> +                if false {
> +                    $crate::try_init!(make_initializer:
> +                        @typ($ty),
> +                        @type_name($t),
> +                        @munch_fields($($fields)*,),
> +                        @acc(),
> +                    );
> +                }
> +                // Forget all guards, since initialization was a success.
> +                $crate::try_init!(forget_guards:
> +                    @munch_fields($($fields)*,),
> +                );
> +            }
> +            Ok(__InitOk)
> +        };
> +        let init = move |slot: *mut $ty| -> ::core::result::Result<(), $err> {
> +            init(slot).map(|__InitOk| ())
> +        };
> +        let init = unsafe { $crate::init::init_from_closure::<$ty, $err>(init) };
> +        init
> +    }};
> +    (init_slot:
> +        @typ($ty:ty),
> +        @slot($slot:ident),
> +        @munch_fields( $(,)?),
> +    ) => {
> +        // Endpoint of munching, no fields are left.
> +    };
> +    (init_slot:
> +        @typ($ty:ty),
> +        @slot($slot:ident),
> +        @munch_fields($field:ident <- $val:expr, $($rest:tt)*),
> +    ) => {
> +        let $field = $val;
> +        // Call the initializer.
> +        //
> +        // SAFETY: `slot` is valid, because we are inside of an initializer closure, we
> +        // return when an error/panic occurs.
> +        unsafe {
> +            $crate::init::Init::__init($field, ::core::ptr::addr_of_mut!((*$slot).$field))?;
> +        }
> +        // Create the drop guard.
> +        //
> +        // SAFETY: We forget the guard later when initialization has succeeded.
> +        let $field = unsafe {
> +            $crate::init::DropGuard::new(::core::ptr::addr_of_mut!((*$slot).$field))
> +        };
> +        // Only give access to `&DropGuard`, so it cannot be accidentally forgotten.
> +        let $field = &$field;
> +
> +        $crate::try_init!(init_slot:
> +            @typ($ty),
> +            @slot($slot),
> +            @munch_fields($($rest)*),
> +        );
> +    };
> +    (init_slot:
> +        @typ($ty:ty),
> +        @slot($slot:ident),
> +        // Direct value init.
> +        @munch_fields($field:ident $(: $val:expr)?, $($rest:tt)*),
> +    ) => {
> +        $(let $field = $val;)?
> +        // Call the initializer.
> +        //
> +        // SAFETY: The memory at `slot` is uninitialized.
> +        unsafe { ::core::ptr::write(::core::ptr::addr_of_mut!((*$slot).$field), $field) };
> +        // Create the drop guard.
> +        //
> +        // SAFETY: We forget the guard later when initialization has succeeded.
> +        let $field = unsafe {
> +            $crate::init::DropGuard::new(::core::ptr::addr_of_mut!((*$slot).$field))
> +        };
> +        // Only give access to `&DropGuard`, so it cannot be accidentally forgotten.
> +        let $field = &$field;
> +
> +        $crate::try_init!(init_slot:
> +            @typ($ty),
> +            @slot($slot),
> +            @munch_fields($($rest)*),
> +        );
> +    };
> +    (make_initializer:
> +        @typ($ty:ty),
> +        @type_name($t:ident),
> +        @munch_fields( $(,)?),
> +        @acc($($acc:tt)*),
> +    ) => {
> +        // Endpoint, nothing more to munch.
> +        let _: $ty = $t {
> +            $($acc)*
> +        };
> +    };
> +    (make_initializer:
> +        @typ($ty:ty),
> +        @type_name($t:ident),
> +        @munch_fields($field:ident <- $val:expr, $($rest:tt)*),
> +        @acc($($acc:tt)*),
> +    ) => {
> +        $crate::try_init!(make_initializer:
> +            @typ($ty),
> +            @type_name($t),
> +            @munch_fields($($rest)*),
> +            @acc($($acc)*$field: ::core::panic!(),),
> +        );
> +    };
> +    (make_initializer:
> +        @typ($ty:ty),
> +        @type_name($t:ident),
> +        @munch_fields($field:ident $(: $val:expr)?, $($rest:tt)*),
> +        @acc($($acc:tt)*),
> +    ) => {
> +        $crate::try_init!(make_initializer:
> +            @typ($ty),
> +            @type_name($t),
> +            @munch_fields($($rest)*),
> +            @acc($($acc)*$field: ::core::panic!(),),
> +        );
> +    };
> +    (forget_guards:
> +        @munch_fields($(,)?),
> +    ) => {
> +        // Munching finished.
> +    };
> +    (forget_guards:
> +        @munch_fields($field:ident <- $val:expr, $($rest:tt)*),
> +    ) => {
> +        unsafe { $crate::init::DropGuard::forget($field) };
> +
> +        $crate::try_init!(forget_guards:
> +            @munch_fields($($rest)*),
> +        );
> +    };
> +    (forget_guards:
> +        @munch_fields($field:ident $(: $val:expr)?, $($rest:tt)*),
> +    ) => {
> +        unsafe { $crate::init::DropGuard::forget($field) };
> +
> +        $crate::try_init!(forget_guards:
> +            @munch_fields($($rest)*),
> +        );
> +    };
> +}
> +
> +/// A pinned initializer for `T`.
> +///
> +/// To use this initializer, you will need a suitable memory location that can hold a `T`. This can
> +/// be [`Box<T>`], [`Arc<T>`], [`UniqueArc<T>`] or even the stack (see [`stack_pin_init!`]). Use the
> +/// [`InPlaceInit::pin_init`] function of a smart pointer like [`Arc::pin_init`] on this.
> +///
> +/// Also see the [module description](self).
> +///
> +/// # Safety
> +///
> +/// When implementing this type you will need to take great care. Also there are probably very few
> +/// cases where a manual implementation is necessary. Use [`from_value`] and
> +/// [`pin_init_from_closure`] where possible.
> +///
> +/// The [`PinInit::__pinned_init`] function
> +/// - returns `Ok(())` if it initialized every field of `slot`,
> +/// - returns `Err(err)` if it encountered an error and then cleaned `slot`, this means:
> +///     - `slot` can be deallocated without UB occurring,
> +///     - `slot` does not need to be dropped,
> +///     - `slot` is not partially initialized.
> +/// - while constructing the `T` at `slot` it upholds the pinning invariants of `T`.
> +///
> +/// [`Arc<T>`]: crate::sync::Arc
> +/// [`Arc::pin_init`]: crate::sync::Arc::pin_init
> +#[must_use = "An initializer must be used in order to create its value."]
> +pub unsafe trait PinInit<T: ?Sized, E = Infallible>: Sized {
> +    /// Initializes `slot`.
> +    ///
> +    /// # Safety
> +    ///
> +    /// - `slot` is a valid pointer to uninitialized memory.
> +    /// - the caller does not touch `slot` when `Err` is returned, they are only permitted to
> +    ///   deallocate.
> +    /// - `slot` will not move until it is dropped, i.e. it will be pinned.
> +    unsafe fn __pinned_init(self, slot: *mut T) -> Result<(), E>;
> +}
> +
> +/// An initializer for `T`.
> +///
> +/// To use this initializer, you will need a suitable memory location that can hold a `T`. This can
> +/// be [`Box<T>`], [`Arc<T>`], [`UniqueArc<T>`] or even the stack (see [`stack_pin_init!`]). Use the
> +/// `init` function of a smart pointer like [`Box::init`] on this. Because [`PinInit<T, E>`] is a
> +/// super trait, you can use every function that takes it as well.
> +///
> +/// Also see the [module description](self).
> +///
> +/// # Safety
> +///
> +/// When implementing this type you will need to take great care. Also there are probably very few
> +/// cases where a manual implementation is necessary. Use [`from_value`] and
> +/// [`init_from_closure`] where possible.
> +///
> +/// The [`Init::__init`] function
> +/// - returns `Ok(())` if it initialized every field of `slot`,
> +/// - returns `Err(err)` if it encountered an error and then cleaned `slot`, this means:
> +///     - `slot` can be deallocated without UB occurring,
> +///     - `slot` does not need to be dropped,
> +///     - `slot` is not partially initialized.
> +/// - while constructing the `T` at `slot` it upholds the pinning invariants of `T`.
> +///
> +/// The `__pinned_init` function from the supertrait [`PinInit`] needs to execute the exact same
> +/// code as `__init`.
> +///
> +/// Contrary to its supertype [`PinInit<T, E>`] the caller is allowed to
> +/// move the pointee after initialization.
> +///
> +/// [`Arc<T>`]: crate::sync::Arc
> +#[must_use = "An initializer must be used in order to create its value."]
> +pub unsafe trait Init<T: ?Sized, E = Infallible>: PinInit<T, E> {
> +    /// Initializes `slot`.
> +    ///
> +    /// # Safety
> +    ///
> +    /// - `slot` is a valid pointer to uninitialized memory.
> +    /// - the caller does not touch `slot` when `Err` is returned, they are only permitted to
> +    ///   deallocate.
> +    unsafe fn __init(self, slot: *mut T) -> Result<(), E>;
> +}
> +
> +type Invariant<T> = PhantomData<fn(*mut T) -> *mut T>;
> +// This is the module-internal type implementing `PinInit` and `Init`. It is unsafe to create this
> +// type, since the closure needs to fulfill the same safety requirement as the
> +// `__pinned_init`/`__init` functions.
> +struct InitClosure<F, T: ?Sized, E>(F, Invariant<(E, T)>);
> +
> +// SAFETY: While constructing the `InitClosure`, the user promised that it upholds the
> +// `__pinned_init` invariants.
> +unsafe impl<T: ?Sized, F, E> PinInit<T, E> for InitClosure<F, T, E>
> +where
> +    F: FnOnce(*mut T) -> Result<(), E>,
> +{
> +    #[inline]
> +    unsafe fn __pinned_init(self, slot: *mut T) -> Result<(), E> {
> +        (self.0)(slot)
> +    }
> +}
> +
> +// SAFETY: While constructing the `InitClosure`, the user promised that it upholds the
> +// `__init` invariants.
> +unsafe impl<T: ?Sized, F, E> Init<T, E> for InitClosure<F, T, E>
> +where
> +    F: FnOnce(*mut T) -> Result<(), E>,
> +{
> +    #[inline]
> +    unsafe fn __init(self, slot: *mut T) -> Result<(), E> {
> +        (self.0)(slot)
> +    }
> +}
> +
> +/// Creates a new [`PinInit<T, E>`] from the given closure.
> +///
> +/// # Safety
> +///
> +/// The closure:
> +/// - returns `Ok(())` if it initialized every field of `slot`,
> +/// - returns `Err(err)` if it encountered an error and then cleaned `slot`, this means:
> +///     - `slot` can be deallocated without UB occurring,
> +///     - `slot` does not need to be dropped,
> +///     - `slot` is not partially initialized.
> +/// - may assume that the `slot` does not move if `T: !Unpin`,
> +/// - while constructing the `T` at `slot` it upholds the pinning invariants of `T`.
> +#[inline]
> +pub const unsafe fn pin_init_from_closure<T: ?Sized, E>(
> +    f: impl FnOnce(*mut T) -> Result<(), E>,
> +) -> impl PinInit<T, E> {
> +    InitClosure(f, PhantomData)
> +}
> +
> +/// Creates a new [`Init<T, E>`] from the given closure.
> +///
> +/// # Safety
> +///
> +/// The closure:
> +/// - returns `Ok(())` if it initialized every field of `slot`,
> +/// - returns `Err(err)` if it encountered an error and then cleaned `slot`, this means:
> +///     - `slot` can be deallocated without UB occurring,
> +///     - `slot` does not need to be dropped,
> +///     - `slot` is not partially initialized.
> +/// - the `slot` may move after initialization.
> +/// - while constructing the `T` at `slot` it upholds the pinning invariants of `T`.
> +#[inline]
> +pub const unsafe fn init_from_closure<T: ?Sized, E>(
> +    f: impl FnOnce(*mut T) -> Result<(), E>,
> +) -> impl Init<T, E> {
> +    InitClosure(f, PhantomData)
> +}
> +
> +/// Trait facilitating pinned destruction.
> +///
> +/// Use [`pinned_drop`] to implement this trait safely:
> +///
> +/// ```rust
> +/// # use kernel::sync::Mutex;
> +/// use kernel::macros::pinned_drop;
> +/// use core::pin::Pin;
> +/// #[pin_data(PinnedDrop)]
> +/// struct Foo {
> +///     #[pin]
> +///     mtx: Mutex<usize>,
> +/// }
> +///
> +/// #[pinned_drop]
> +/// impl PinnedDrop for Foo {
> +///     fn drop(self: Pin<&mut Self>) {
> +///         pr_info!("Foo is being dropped!");
> +///     }
> +/// }
> +/// ```
> +///
> +/// # Safety
> +///
> +/// This trait must be implemented with [`pinned_drop`].
> +///
> +/// [`pinned_drop`]: kernel::macros::pinned_drop
> +pub unsafe trait PinnedDrop: __PinData {
> +    /// Executes the pinned destructor of this type.
> +    ///
> +    /// # Safety
> +    ///
> +    /// Only call this from `<Self as Drop>::drop`.
> +    unsafe fn drop(self: Pin<&mut Self>);
> +
> +    // Used by the `pinned_drop` proc-macro to ensure that only safe operations are used in `drop`.
> +    // the function should not be called.
> +    #[doc(hidden)]
> +    fn __ensure_no_unsafe_op_in_drop(self: Pin<&mut Self>);

One idea to avoid this extra function is to have an unsafe token to the
drop function.

fn drop(self: Pin<&mut Self>, token: TokenThatCanOnlyBeCreatedUnsafely);

> +}
> +
> +/// Smart pointer that can initialize memory in-place.
> +pub trait InPlaceInit<T>: Sized {
> +    /// Use the given initializer to in-place initialize a `T`.
> +    ///
> +    /// If `T: !Unpin` it will not be able to move afterwards.
> +    fn pin_init<E>(init: impl PinInit<T, E>) -> error::Result<Pin<Self>>
> +    where
> +        Error: From<E>;
> +
> +    /// Use the given initializer to in-place initialize a `T`.
> +    fn init<E>(init: impl Init<T, E>) -> error::Result<Self>
> +    where
> +        Error: From<E>;
> +}

Is this trait used? Or the methods could be inherent methods?

> +
> +impl<T> InPlaceInit<T> for Box<T> {
> +    #[inline]
> +    fn pin_init<E>(init: impl PinInit<T, E>) -> error::Result<Pin<Self>>
> +    where
> +        Error: From<E>,
> +    {
> +        let mut this = Box::try_new_uninit()?;
> +        let slot = this.as_mut_ptr();
> +        // SAFETY: When init errors/panics, slot will get deallocated but not dropped,
> +        // slot is valid and will not be moved because of the `Pin::new_unchecked`
> +        unsafe { init.__pinned_init(slot)? };
> +        // SAFETY: All fields have been initialized.
> +        Ok(unsafe { Pin::new_unchecked(this.assume_init()) })
> +    }
> +
> +    #[inline]
> +    fn init<E>(init: impl Init<T, E>) -> error::Result<Self>
> +    where
> +        Error: From<E>,
> +    {
> +        let mut this = Box::try_new_uninit()?;
> +        let slot = this.as_mut_ptr();
> +        // SAFETY: When init errors/panics, slot will get deallocated but not dropped,
> +        // slot is valid
> +        unsafe { init.__init(slot)? };
> +        // SAFETY: All fields have been initialized.
> +        Ok(unsafe { this.assume_init() })
> +    }
> +}
> +
> +impl<T> InPlaceInit<T> for UniqueArc<T> {
> +    #[inline]
> +    fn pin_init<E>(init: impl PinInit<T, E>) -> error::Result<Pin<Self>>
> +    where
> +        Error: From<E>,
> +    {
> +        let mut this = UniqueArc::try_new_uninit()?;
> +        let slot = this.as_mut_ptr();
> +        // SAFETY: When init errors/panics, slot will get deallocated but not dropped,
> +        // slot is valid and will not be moved because of the `Pin::new_unchecked`.
> +        unsafe { init.__pinned_init(slot)? };
> +        // SAFETY: All fields have been initialized.
> +        Ok(unsafe { Pin::new_unchecked(this.assume_init()) })
> +    }
> +
> +    #[inline]
> +    fn init<E>(init: impl Init<T, E>) -> error::Result<Self>
> +    where
> +        Error: From<E>,
> +    {
> +        let mut this = UniqueArc::try_new_uninit()?;
> +        let slot = this.as_mut_ptr();
> +        // SAFETY: When init errors/panics, slot will get deallocated but not dropped,
> +        // slot is valid.
> +        unsafe { init.__init(slot)? };
> +        // SAFETY: All fields have been initialized.
> +        Ok(unsafe { this.assume_init() })
> +    }
> +}
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
> +/// An initializer that leaves the memory uninitialized.
> +///
> +/// The initializer is a no-op. The `slot` memory is not changed.
> +#[inline]
> +pub fn uninit<T>() -> impl Init<MaybeUninit<T>> {
> +    // SAFETY: The memory is allowed to be uninitialized.
> +    unsafe { init_from_closure(|_| Ok(())) }
> +}

Do you think there's a value to have a `Uninitable` which is
implemented for both `MaybeUninit` and `Opaque`?

> +
> +/// Convert a value into an initializer.
> +///
> +/// Directly moves the value into the given `slot`.
> +///
> +/// Note that you can just write `field: value,` in all initializer macros. This function's purpose
> +/// is to provide compatibility with APIs that only have `PinInit`/`Init` as parameters.
> +#[inline]
> +pub fn from_value<T>(value: T) -> impl Init<T> {

How about `unsafe impl<T> Init<T> for T`?

> +    // SAFETY: We use the value to initialize the slot.
> +    unsafe {
> +        init_from_closure(move |slot: *mut T| {
> +            slot.write(value);
> +            Ok(())
> +        })
> +    }
> +}
> +
> +macro_rules! impl_zeroable {
> +    ($($t:ty),*) => {
> +        $(unsafe impl Zeroable for $t {})*
> +    };
> +}

I personally would do ($($t:ty,)*) and then we can have

impl_zeroable!(
    // SAFETY: All primitives that are allowed to be zero.
    bool,
    char,
    u8, u16, u32, u64, u128, usize,
    i8, i16, i32, i64, i128, isize,
    f32, f64,
    // SAFETY: There is nothing to zero.
    core::marker::PhantomPinned, Infallible, (),
    ......
);

> +// SAFETY: All primitives that are allowed to be zero.
> +impl_zeroable!(
> +    bool, char, u8, u16, u32, u64, u128, usize, i8, i16, i32, i64, i128, isize, f32, f64
> +);
> +// SAFETY: There is nothing to zero.
> +impl_zeroable!(core::marker::PhantomPinned, Infallible, ());
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
> +
> +// This trait is only implemented via the `#[pin_data]` proc-macro. It is used to facilitate
> +// the pin projections within the initializers.
> +#[doc(hidden)]
> +pub unsafe trait __PinData {
> +    type __PinData;
> +}
> +
> +/// Stack initializer helper type. Use [`stack_pin_init`] instead of this primitive.

`#[doc(hidden)]`?

> +///
> +/// # Invariants
> +///
> +/// If `self.1` is true, then `self.0` is initialized.
> +///
> +/// [`stack_pin_init`]: kernel::stack_pin_init
> +pub struct StackInit<T>(MaybeUninit<T>, bool);
> +
> +impl<T> Drop for StackInit<T> {
> +    #[inline]
> +    fn drop(&mut self) {
> +        if self.1 {
> +            // SAFETY: As we are being dropped, we only call this once. And since `self.1 == true`,
> +            // `self.0` has to be initialized.
> +            unsafe { self.0.assume_init_drop() };
> +        }
> +    }
> +}
> +impl<T> StackInit<T> {
> +    /// Creates a new [`StackInit<T>`] that is uninitialized. Use [`stack_pin_init`] instead of this
> +    /// primitive.
> +    ///
> +    /// [`stack_pin_init`]: kernel::stack_pin_init
> +    #[inline]
> +    pub fn uninit() -> Self {
> +        Self(MaybeUninit::uninit(), false)
> +    }
> +
> +    /// Initializes the contents and returns the result.
> +    ///
> +    /// # Safety
> +    ///
> +    /// The caller ensures that `self` is on the stack and not accessible in any other way, if this
> +    /// function returns `Ok`.
> +    #[inline]
> +    pub unsafe fn init<E>(&mut self, init: impl PinInit<T, E>) -> Result<Pin<&mut T>, E> {
> +        // SAFETY: The memory slot is valid and this type ensures that it will stay pinned.
> +        unsafe { init.__pinned_init(self.0.as_mut_ptr())? };
> +        self.1 = true;
> +        // SAFETY: The slot is now pinned, since we will never give access to `&mut T`.
> +        Ok(unsafe { Pin::new_unchecked(self.0.assume_init_mut()) })
> +    }
> +}
> +
> +/// When a value of this type is dropped, it drops a `T`.
> +///
> +/// Public, but hidden type, since it should only be used by the macros of this module.
> +#[doc(hidden)]
> +pub struct DropGuard<T: ?Sized>(*mut T, Cell<bool>);
> +
> +impl<T: ?Sized> DropGuard<T> {
> +    /// Creates a new [`DropGuard<T>`]. It will [`ptr::drop_in_place`] `ptr` when it gets dropped.
> +    ///
> +    /// # Safety
> +    ///
> +    /// `ptr` must be a valid pointer.
> +    ///
> +    /// It is the callers responsibility that `self` will only get dropped if the pointee of `ptr`:
> +    /// - has not been dropped,
> +    /// - is not accessible by any other means,
> +    /// - will not be dropped by any other means.
> +    #[inline]
> +    pub unsafe fn new(ptr: *mut T) -> Self {
> +        Self(ptr, Cell::new(true))
> +    }
> +
> +    /// Prevents this guard from dropping the supplied pointer.
> +    ///
> +    /// # Safety
> +    ///
> +    /// This function is unsafe in order to prevent safe code from forgetting this guard. It should
> +    /// only be called by the macros in this module.
> +    #[inline]
> +    pub unsafe fn forget(&self) {
> +        self.1.set(false);
> +    }
> +}
> +
> +impl<T: ?Sized> Drop for DropGuard<T> {
> +    #[inline]
> +    fn drop(&mut self) {
> +        if self.1.get() {
> +            // SAFETY: A `DropGuard` can only be constructed using the unsafe `new` function
> +            // ensuring that this operation is safe.
> +            unsafe { ptr::drop_in_place(self.0) }
> +        }
> +    }
> +}
> diff --git a/rust/kernel/init/common.rs b/rust/kernel/init/common.rs
> new file mode 100644
> index 000000000000..f8c6e9dff786
> --- /dev/null
> +++ b/rust/kernel/init/common.rs
> @@ -0,0 +1,42 @@
> +// SPDX-License-Identifier: Apache-2.0 OR MIT
> +
> +//! Module containing common kernel initializer functions.
> +
> +use crate::{
> +    init::{self, PinInit},
> +    types::Opaque,
> +};
> +
> +macro_rules! create_func {
> +    ($name:ident $(, $arg_name:ident: $arg_typ:ident)*) => {
> +        /// Create an initializer using the given initializer function from C.
> +        ///
> +        /// # Safety
> +        ///
> +        /// The given function **must** under all circumstances initialize the memory location to a
> +        /// valid `T`. If it fails to do so it results in UB.
> +        ///
> +        /// If any parameters are given, those need to be valid for the function. Valid means that
> +        /// calling the function with those parameters complies with the above requirement **and**
> +        /// every other requirement on the function itself.
> +        pub unsafe fn $name<T $(, $arg_typ)*>(
> +            init_func: unsafe extern "C" fn(*mut T $(, $arg_name: $arg_typ)*),
> +            $($arg_name: $arg_typ,)*
> +        ) -> impl PinInit<Opaque<T>> {
> +            // SAFETY: The safety contract of this function ensures that `init_func` fully
> +            // initializes `slot`.
> +            unsafe {
> +                init::pin_init_from_closure(move |slot| {
> +                    init_func(Opaque::raw_get(slot) $(, $arg_name)*);
> +                    Ok(())
> +                })
> +            }
> +        }
> +    }
> +}
> +
> +create_func!(ffi_init);
> +create_func!(ffi_init1, arg1: A1);
> +create_func!(ffi_init2, arg1: A1, arg2: A2);
> +create_func!(ffi_init3, arg1: A1, arg2: A2, arg3: A3);
> +create_func!(ffi_init4, arg1: A1, arg2: A2, arg3: A3, arg4: A4);

This part can be a separate commit (or perhaps in a separate patch
series when it's being used).

> diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
> index f2f1c83d72ba..5b4f64dd3ac8 100644
> --- a/rust/kernel/sync/arc.rs
> +++ b/rust/kernel/sync/arc.rs
> @@ -17,7 +17,8 @@
>  
>  use crate::{
>      bindings,
> -    error::Result,
> +    error::{Error, Result},
> +    init::{InPlaceInit, Init, PinInit},
>      types::{ForeignOwnable, Opaque},
>  };
>  use alloc::boxed::Box;
> @@ -163,6 +164,28 @@ impl<T> Arc<T> {
>          // `Arc` object.
>          Ok(unsafe { Self::from_inner(Box::leak(inner).into()) })
>      }
> +
> +    /// Use the given initializer to in-place initialize a `T`.
> +    ///
> +    /// If `T: !Unpin` it will not be able to move afterwards.
> +    #[inline]
> +    pub fn pin_init<E>(init: impl PinInit<T, E>) -> Result<Self>
> +    where
> +        Error: From<E>,
> +    {
> +        UniqueArc::pin_init(init).map(|u| u.into())
> +    }
> +
> +    /// Use the given initializer to in-place initialize a `T`.
> +    ///
> +    /// This is equivalent to [`pin_init`], since an `Arc` is always pinned.
> +    #[inline]
> +    pub fn init<E>(init: impl Init<T, E>) -> Result<Self>
> +    where
> +        Error: From<E>,
> +    {
> +        UniqueArc::init(init).map(|u| u.into())
> +    }
>  }
>  
>  impl<T: ?Sized> Arc<T> {
> @@ -489,6 +512,17 @@ impl<T> UniqueArc<MaybeUninit<T>> {
>      /// Converts a `UniqueArc<MaybeUninit<T>>` into a `UniqueArc<T>` by writing a value into it.
>      pub fn write(mut self, value: T) -> UniqueArc<T> {
>          self.deref_mut().write(value);
> +        // SAFETY: We just wrote the value to be initialized.
> +        unsafe { self.assume_init() }
> +    }
> +
> +    /// Unsafely assume that `self` is initialized.
> +    ///
> +    /// # Safety
> +    ///
> +    /// The caller guarantees that the value behind this pointer has been initialized. It is
> +    /// *immediate* UB to call this when the value is not initialized.
> +    pub unsafe fn assume_init(self) -> UniqueArc<T> {

This part should be a separate commit.

>          let inner = ManuallyDrop::new(self).inner.ptr;
>          UniqueArc {
>              // SAFETY: The new `Arc` is taking over `ptr` from `self.inner` (which won't be

Best,
Gary
