Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0F736A25F2
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Feb 2023 01:45:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbjBYApj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 19:45:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjBYAph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 19:45:37 -0500
Received: from GBR01-LO2-obe.outbound.protection.outlook.com (mail-lo2gbr01on2109.outbound.protection.outlook.com [40.107.10.109])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A6411B2FB;
        Fri, 24 Feb 2023 16:45:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gJWCl10rT82yDpXsscbI369N9djuyOpx1NnsHBdBEtzHRZbpRF6PEBRH65yIDpp5jkqg55OKvGD1SKUeKWWXh6Yr473Gi5UmsR+2m3NJYkEv/3X/tt7xvz3kKq78YLFM6wI1inc92AIf1zxnopKwsPAakYLUnGjLg+ySxh1VTjpvAMJyUIY415ysjv1lKUvgwhVg1/n8oFu1VwjHTsza5UoHeIv09XIDJL0R4sUZVi258kRGl8hUZLc2wb3fB5Manqjduc2oBY7g4P3iZ/BgYoLKm2RTB/SLP7+SFsU9IOgJuhiTZkDcy21F1loTgBn5mKkactx1w0aZETnj1Rh4Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LmyYIKhTAXVLLs3EmuraMYrCrqqqRD/5BKRIruExsUs=;
 b=Jndr5y2RefPbSONl29em/WKZuG4te8YfncpbDgBTkjXlBwmcKOJhLqKTf+ekmWpTMEYLO88FafRYu6DtzqSCwSUZEwqjd4UhxwYR6YPuyzTQkBV5xYlfFlO3VIcIS9UFpG9Qkv0u0X6AIVYZQWVSwHlNASOQ9l2CWAf5AOTSWHikgNgNhQHVVunnS15ad8pKmgECvs/x+svOpnBuzdE/zfztx2MSghhq8UbLuabwUTK3rO6SSxs7tao+O942/WiRrBzB6c7/dV0iCertj4N6vWbJ2Hg7f89hMg273IQ/ZRkJ7P89w3lw7FTbw2XX8hK3wyARrbjn2u6uFsYIIgudQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LmyYIKhTAXVLLs3EmuraMYrCrqqqRD/5BKRIruExsUs=;
 b=uCUXKO4sIDrep1J+jZ0h/shMzyY2vgR0IhGNYKXjtlYamK/HiaR/H9ZxLoYBT2ynOg09WY4UYSIA5eg4ePZsqyMqHIZdKYSkamGsL0jWNlLxP3OaQnLWN3KalNJqNieTugeODrsIv743fuJGANwCeBDvNoWfD/g367wlEcJyn9s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LO4P265MB6617.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:2f9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.25; Sat, 25 Feb
 2023 00:45:34 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::2f2a:55d4:ea1d:dece]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::2f2a:55d4:ea1d:dece%4]) with mapi id 15.20.6134.021; Sat, 25 Feb 2023
 00:45:33 +0000
Date:   Sat, 25 Feb 2023 00:45:32 +0000
From:   Gary Guo <gary@garyguo.net>
To:     Asahi Lina <lina@asahilina.net>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        =?UTF-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kbuild@vger.kernel.org, asahi@lists.linux.dev
Subject: Re: [PATCH] rust: Enable the new_uninit feature for kernel and
 driver crates
Message-ID: <20230225004532.5f1bf427.gary@garyguo.net>
In-Reply-To: <20230224-rust-new_uninit-v1-1-c951443d9e26@asahilina.net>
References: <20230224-rust-new_uninit-v1-1-c951443d9e26@asahilina.net>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0603.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:295::19) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LO4P265MB6617:EE_
X-MS-Office365-Filtering-Correlation-Id: ec47c509-0aa4-4a62-d9dd-08db16c99a65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8ow/8K8GNBG6Qb1LEUuHwKaceIDx3kwdz5SUP5Lwofc2P+fMQ3BaFsKv0wm25Zx/F5+jxlO4mvwDMuXMaWIwv7vr8KUp17yBLPyHE5fiJ5wBI6wBzpDY2kFhjX1D1ruLgJ9nnsyoNielPoxZEDBuy7UEcLwZdVY8c9uzT+LD3BuI4sVVlIAIkGbptnQ94P7ObGsutg+92QA87Y5stBlgqgZed8SxqGSUzPOGx4cDyqIT/InyndquGlx/8dGL8uVbPNgzrVTPXHRAHj6NXaMqbttKAc1uYfEktXeHywzCu+Lg7j4G8uNsNjRmMQrv6jyLfdfe1GfRk6JYOrptrto7atHDyW8f+G745/WoP6TSBVicSNnsHiVYKKNXzQD5tTSOeu2wC322PMy8SeyuMWGt1/G+CpLiv3LwzFp68HqJPBWmYoOcANgupnhb1Jm6DbmJpgNlqOax5K/4MQRQG1BxSz7deIdCJOYCK3IOywK2y3ffODX8rAsLWG/GaaDIVH2FXnz+jRiPijiKlVfexq87ScW6hHf/ndipkUdran8nNTfCBDB90xZFbFzmVkMLZ2Bt82dqnT8jcM7+O+3pT4p/T/RjyJJDvRQ4jGmT5gm0DGw4OsmW/pyCAdcfkuLox3y9
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(366004)(39830400003)(376002)(346002)(136003)(396003)(451199018)(26005)(186003)(316002)(41300700001)(66476007)(66556008)(66946007)(8676002)(4326008)(6916009)(54906003)(6486002)(966005)(6512007)(6506007)(1076003)(86362001)(478600001)(2906002)(38100700002)(83380400001)(36756003)(2616005)(8936002)(5660300002)(7416002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OuqUoHe8xD12k08ks7oWhRDJDVOdXp5zz7E7gQgMabA7y4ofY4shC6Gp2uHf?=
 =?us-ascii?Q?Fi/8S6//kM6rgC/Tuw9y89DyIUSGOD/VunhPaeGA/cPqq+0/3K/0Mf6n9VKO?=
 =?us-ascii?Q?U4XmrfmFdmzp8ffTRzo+qip42kSRj1tra1xfpePAA1a2kc4OMhWFeBgfWLbv?=
 =?us-ascii?Q?EXwKUwYxcRP+WM5gpiOT+KKXXomjCyPJcLv4W5y/7lKCfwjHORcL8Ox7Ybwm?=
 =?us-ascii?Q?sZAx94HyCBimGASqVBvKKx6KNikPd7C5eWQAN/CEekSZvKft0IvHsA7OQMXR?=
 =?us-ascii?Q?TjanVfSc+I2IlJzDSfzLVUs6IUbEA2ed4274EKUjSohzCwKqwK/BWNCvPpPj?=
 =?us-ascii?Q?i8g1ED60xntEj4va0kT0+/wYjr6bEK7KhhbkNeOCUI+/BPYoMJP2Xor1Jx3F?=
 =?us-ascii?Q?Aoh5kmIjiUpgJ7fZrDN+drSocsUoKQIMOySUE8O5OjM6GINyV6JsstAZ1BoL?=
 =?us-ascii?Q?xgH5kn+TMXKOYTuN+/EdA2Q+IPMdfkNBKGBZMipV5umuXfdJ2VKIi4ZXxzFB?=
 =?us-ascii?Q?fA27nzkX1s7jKHM5J79JVcGdrhqmrT9D5+0Fuv6mo0fhzKnn2RUcWriky2kk?=
 =?us-ascii?Q?WnpXlmk5Iqh5ZXerWvBI3tcG4aOgFoB2h3qfNcTJaQ2KVjQrOS3cNvtMbEUV?=
 =?us-ascii?Q?GfbUsVzI1kG4zY7XTbIOTLPQe7FnFcpH805rjo3ueNaQKufA92R/DnJ4fwvJ?=
 =?us-ascii?Q?50yo6ql8xJuS8y+/02gxmnz5DtltdgLEDwaMdov5IaA41Dj1rRd89ASKoCk9?=
 =?us-ascii?Q?Bn9J3cfLKqutN2iFlYH+osHNv8d2dBpmJzGQRcQwpozKS9SXKZbLBoCxrl/2?=
 =?us-ascii?Q?1q2kooM5XVXfNAi8TIoiw8x2RD0G5n1DV1kd9pJIZ74zpWUbh8Hqqy2Rvqwb?=
 =?us-ascii?Q?a26WG08lHHakS9CRNyaH5lF8tP4TLtH+O2+jQVU0YJQZ64p105WKwTjT28dC?=
 =?us-ascii?Q?5b7wBNducTe3dt2DbVkZcHf6Ds8nXrXTtUx2DhCoHkne6RyDkGJTu62IH3tF?=
 =?us-ascii?Q?MaDfyCFm8a4fLASjD3VGA0d5faeLehXkDFD+45Voa//mwvI8NiuR6MqB3+Bt?=
 =?us-ascii?Q?wzjnmsA+IDU9lDd4q0fZayW/BF4+6ePuvN0msqP/AHi8tAfRDD904LNa+X3P?=
 =?us-ascii?Q?22Xpm2ZR92STzPbsBgVGlRkyVztWYigZv+Od0olPtdn7DEawzLbGdlGOV51U?=
 =?us-ascii?Q?6/Wq6rbuyn/5bqRQFRtcJ6myeQJv/HbspXLCqjITifa0VqzceJgOpoIqZ7/u?=
 =?us-ascii?Q?pLQaGIcrb1stnq8FFYngz93aZJXsyCJH1g/V+aAbiBNbf1n86ANj372u4/tf?=
 =?us-ascii?Q?h5S6t1+6zImb4yFvQ06DrrxURdqE3wUptzbO4AksQ8Qh8OmNAI79LMHurUkA?=
 =?us-ascii?Q?V1s0i0wNwQTk+UyT82thGlkp6tUs51Ar+Qai5nwmY3it9GfB73HC7h7WlIvp?=
 =?us-ascii?Q?N8zAvhjf/B2Su2DSraZtwvy0T64Ca5KGzX0U51I/GRDfG949PudaMvi7C3oL?=
 =?us-ascii?Q?M/rJ9HCnu82cfwTaXlQjdo641D/isqzK/nUaQcRpl6m6peFKEl5BNaKjqPhB?=
 =?us-ascii?Q?elRPsKbyP7ZYyW9zT0ZfXnw+vCRfeMANP1CMS+qU?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: ec47c509-0aa4-4a62-d9dd-08db16c99a65
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2023 00:45:33.8753
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MVP1vFrVHN8IhiCjDgjjhurUZDtMJD9MKo9utiUZ7MsbW8G5gfyN42L7sGnC902Q66BH+AStP76iu3FvsL8nQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO4P265MB6617
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Feb 2023 17:09:47 +0900
Asahi Lina <lina@asahilina.net> wrote:

> The unstable new_uninit feature enables various library APIs to create
> uninitialized containers, such as `Box::assume_init()`. This is
> necessary to build abstractions that directly initialize memory at the
> target location, instead of doing copies through the stack.
> 
> Will be used by the DRM scheduler abstraction in the kernel crate, and
> by field-wise initialization (e.g. using `place!()` or a future
> replacement macro which may itself live in `kernel`) in driver crates.
> 
> See [1] [2] [3] for background information.
> 
> [1] https://github.com/Rust-for-Linux/linux/issues/879
> [2] https://github.com/Rust-for-Linux/linux/issues/2
> [3] https://github.com/rust-lang/rust/issues/63291
> 
> Signed-off-by: Asahi Lina <lina@asahilina.net>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  rust/kernel/lib.rs     | 1 +
>  scripts/Makefile.build | 2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index 223564f9f0cc..1118cd3e0b5f 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -17,6 +17,7 @@
>  #![feature(core_ffi_c)]
>  #![feature(dispatch_from_dyn)]
>  #![feature(generic_associated_types)]
> +#![feature(new_uninit)]
>  #![feature(receiver_trait)]
>  #![feature(unsize)]
>  
> diff --git a/scripts/Makefile.build b/scripts/Makefile.build
> index a0d5c6cca76d..0f637e1ca8dc 100644
> --- a/scripts/Makefile.build
> +++ b/scripts/Makefile.build
> @@ -277,7 +277,7 @@ $(obj)/%.lst: $(src)/%.c FORCE
>  # Compile Rust sources (.rs)
>  # ---------------------------------------------------------------------------
>  
> -rust_allowed_features := core_ffi_c
> +rust_allowed_features := core_ffi_c,new_uninit
>  
>  rust_common_cmd = \
>  	RUST_MODFILE=$(modfile) $(RUSTC_OR_CLIPPY) $(rust_flags) \
> 
> ---
> base-commit: 83f978b63fa7ad474ca22d7e2772c5988101c9bd
> change-id: 20230224-rust-new_uninit-a575d34987c3
> 
> Thank you,
> ~~ Lina
> 

