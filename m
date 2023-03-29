Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21D1E6CF47B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 22:26:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbjC2U0R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 16:26:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjC2U0P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 16:26:15 -0400
Received: from GBR01-CWL-obe.outbound.protection.outlook.com (mail-cwlgbr01on2126.outbound.protection.outlook.com [40.107.11.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3B7E40FE;
        Wed, 29 Mar 2023 13:26:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EBdaWzP4qaO0L/ILRIzJHAedz5qCZ7CE45M5RZU6sLhl/Da1qqtqNbKXG7kdyRoo/WiswKUywzv2F4MH3NWm0191QpTGtnqycO0jEBYoNhhtfZ75xEF/2qxPkQ7rPUV1YEVvLwNzuyNRqDFI8TcoP29/uvA5YyMLnTpPEpFBMtX7s5Pyn89+1B9BwWVSa01QgfjuYuKUU/zq8bfILIAl+pNDtWjkvcyYrwAdYJP2ioDoR2bXaV7xOFz95sCDISJZx1z43hdHTbzbF1yUJQdqysP1wr2NvIANcztivVVg7S/W2l144cjuxvM1ZhmPrlPopy5PvzI4IQYI9DX1xxDjSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=upv/EPPiaai8qvJulpQ20Vst+wc+tdDVZ5igegWZTfY=;
 b=COBBqb4V1xkbjnGbf82ppC6kGGiLOOFL3khzU6wJf92sfuCUnLP4ws8FazmntivJZD5aMTQqFiD21dwayd1ojQEkmVoT/I8N9BF+8DzH+UW8wZ1LVYnu0QSHsDJPZlXux4KETfM8VtR4QO+VPJBSj1s1UfO7BQUoJNYA14B5U7nHpt+xb3Loy5lh6i7j0kkXL3O/EHqwKSMejZQJh7YBCRoNksG+AC8co70jdaeONW1c2zQ3R5AhJhy/Yc3y19ILShqIi8/5zByFThxbhqemDbtlyD4Jl6j2yStjfC8jQl4aIzGDrrgd5hZKUgJsk59mIRnpbc74qmxCZO8wEC2hVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=upv/EPPiaai8qvJulpQ20Vst+wc+tdDVZ5igegWZTfY=;
 b=KwEaNK1mCRKOz1kcpsopJf4KTx07bPSFsqC1+XPxBnh4p4PajmVaCYImUzV8e/9BZI59trFGMTTFEr65sP8JQJJNwMtJdKnJ5Y6kRZEWXonSxEbRqSpT0If8/msQiua9szgYXwKoEzfBcZj1tfrPOAxZ6bCxTMFXYsjgg5YzkoA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LOYP265MB1806.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:eb::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.35; Wed, 29 Mar
 2023 20:26:11 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::2f2a:55d4:ea1d:dece]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::2f2a:55d4:ea1d:dece%4]) with mapi id 15.20.6222.035; Wed, 29 Mar 2023
 20:26:11 +0000
Date:   Wed, 29 Mar 2023 21:25:52 +0100
From:   Gary Guo <gary@garyguo.net>
To:     Asahi Lina <lina@asahilina.net>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        =?UTF-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
        linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
        asahi@lists.linux.dev
Subject: Re: [PATCH 1/2] rust: uapi: Add UAPI crate
Message-ID: <20230329212552.0d7b575a.gary@garyguo.net>
In-Reply-To: <20230329-rust-uapi-v1-1-ee78f2933726@asahilina.net>
References: <20230329-rust-uapi-v1-0-ee78f2933726@asahilina.net>
        <20230329-rust-uapi-v1-1-ee78f2933726@asahilina.net>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0071.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:153::22) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LOYP265MB1806:EE_
X-MS-Office365-Filtering-Correlation-Id: d1d86d76-4aef-4599-60d4-08db3093d5e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eLzV8M//FDY9B0MX3O84pq2/Byv/0rZq/yF96gFblvnUNCdCfOVSyeCWh7XJRd5nbJ2SVL1aX92w9eodCatd9lX4MQkVW/WeXP+ckctx9+d9O+cv4w3u3I7hzO0J/pIUeLI17ruk9eFnbjF+QsPxd38+VhMwnDWp091YkXlIovrxK0gp3z9MDfyIb2qg8EAqXOp3sU83hJd4jv93mrFiEu69dEfn5k5OsLr4jQir62oxryn/jZQ0WJ2ImUIH5tCjXMw/uPHyNaqybPf6ifWcvtDTL/MYr0wGdjjL5Q21ghhrOwu1v34oTn/avXp53nZGZ2xDomP8Qli2JejSX33e8lFgKqr1VuiGyjrBu79vn69zwG/YD8rvG1Ks0kjdWAw8sPviB4GTpO61X63s/f/w9dOYAG+uBLtgOc2bSDxEUy+U9rICSibT+ld86Y6k+nEnGDwph84cOLu13jWZXryGEdIBZv7vofsmK+Zm1gXxqrzx55w1wRfc4KwOknbdCDMuLJbpecKAIIhcE/upB+IY0FPvyzcQcfAx8yi2vmb+jaI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(39830400003)(376002)(366004)(136003)(346002)(396003)(451199021)(8676002)(26005)(6666004)(38100700002)(6486002)(6512007)(2616005)(186003)(8936002)(2906002)(5660300002)(6506007)(36756003)(478600001)(54906003)(316002)(86362001)(41300700001)(4326008)(6916009)(66946007)(66476007)(66556008)(1076003)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LHRdAbC/2SNSMNSaKvkqOSEhXLSHfvBoUuoNpfIN4DUVfXDg13NdauXu059L?=
 =?us-ascii?Q?bgVY/JnK+Iw5mD7SRWfGb47jtuZ904K/CM22CX6ELtCspmZu/fS6YRe+ieX8?=
 =?us-ascii?Q?OG7MdhCLQMsd/rY/m60HP+48ZUrRz01WtnaoRahVDRKLIRowM1lcGR+IhMvo?=
 =?us-ascii?Q?OxHPoWph6Qq6EwaVGjurU6XkwGlxTa362U7UmGNGppCtK9IJL1qGjYI3i3qy?=
 =?us-ascii?Q?56dDd3AvpB/OP0Y3iy7mQbuPwUzDjIgSJQXTAD4+dV7QZBiTC3omoEt2aXFG?=
 =?us-ascii?Q?fqaE70fj2Sc6mZNHytO2IfWdajVa8DtCZEmvD6myO0ZcwRQmHdV1XyLoUMEs?=
 =?us-ascii?Q?Ul2PLeyaEKZs/mkGNgtBTl5/xm21t6WHZCKvDxebxXBr7kBRWHZE2QRN7X5K?=
 =?us-ascii?Q?QQOU/QGLBDpCMWYyTT+sjqQvcPgFICM0UStoJXc1U+0OutB6oCj7g6pLjzLr?=
 =?us-ascii?Q?yUgUlDS2FDLbRHfYEVwgIy2X9fAqQoSnMuNbCZ50Wzb208wvBiAegDBsrrRY?=
 =?us-ascii?Q?ewFRAWbnUyfLeYhkOKHXC7JuHqJGjlrjPrkMsUhWw1gKZeGi9AfhLXcYWfis?=
 =?us-ascii?Q?SY2nV5R2erCGwKWgMHAvMMacC8kGklmn+1VyYqO0QxAxIV0N7MwAC+P10qIE?=
 =?us-ascii?Q?uow8qkPOE4vSJmrproDutGnapLuutDOQKMgDolJBrj2MdOTrThThegWozRHp?=
 =?us-ascii?Q?xz1TR/KN3R7XHjHol/XhxoRIQT4bUxqUfBhNqaQ8V2crNWxAw3/6T9uqft+A?=
 =?us-ascii?Q?Dup28LeW7Hf7ww7t6aaLuxKcM7uY8Rhqk/zCJybvcWdqeeI3e0Yw3neix4dg?=
 =?us-ascii?Q?XMgUdU0gbkIdUpZa0QAp5Mw6eNstW/X2e2sqy3vz0V5rJdbGO9OcNh/vVWKn?=
 =?us-ascii?Q?YGlzK4b2RHSlvtUddc5tGh/B/F2dQ9rGsRg3A3JRZkaz78yXIa4IfJUiGJr9?=
 =?us-ascii?Q?y/WWlYjmLdNPzJXjcuWi5OamCvIXNHroAXU9bDsprgFvDFpU+GIy1jDU+SEL?=
 =?us-ascii?Q?WjpcmpKjk8KzYzLBDh1c7x0NCBXj/skPy5hqfieKQ+ypQx/YYfEZvAMoQYC6?=
 =?us-ascii?Q?skFd3DUai+L/NTcEjmt+xUqBvZ9/2eBwg0q8q+H85Zag+nRO/p/8EclU9027?=
 =?us-ascii?Q?/GhHFiyK5FBkrWTOUxxSDQIGbeXtSIRD97C9HYu6JLGAeTWOQpLfUy/GwTU6?=
 =?us-ascii?Q?S8mcQAo5XumipYiB2Po4UHPA8nX4WdLGPfHYGPrw7mR13tDWtlll8g70edvn?=
 =?us-ascii?Q?6vFjpRtvYEPgjCibdX6Hyn/4wX5miTy+FuyBWmt61Egjyy3ath0sG6aHpHwY?=
 =?us-ascii?Q?DVIOF7QAaMXKBih5+axzXYKGwrWPrqVsi0PEeQOafF+UL6gQT8NYN0lvXWWl?=
 =?us-ascii?Q?vg3cVzUv3idnDfdfQOHY900p5bZm8fGLFIj7f5YAtCAOdbMyo/hwtGbJCmKA?=
 =?us-ascii?Q?iqvNUwqb7gftGJobJCUGi6bc85IzQDTJwQw5b9RmyKTRG0N+mjQK1zi892zU?=
 =?us-ascii?Q?GQCGVm8Tydmew4qN9doZLMyo8y3gbz0n9gn3tVUFuubpc/TILpmxsePZP+xZ?=
 =?us-ascii?Q?RhcHr+4qIjCb45aGlHwAgbu+pKMpvRPDPMcEHKTU?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: d1d86d76-4aef-4599-60d4-08db3093d5e6
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 20:26:11.1620
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oeVx1kaB1cNFrlIRXROWdrT8I1qK4HKv3QMLrK8fMVLD1Mqj9y41WqBze4GbcvuU1eIes8DGhLoFvZKuMykRvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOYP265MB1806
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Mar 2023 20:40:18 +0900
Asahi Lina <lina@asahilina.net> wrote:

> This crate mirrors the `bindings` crate, but will contain only UAPI
> bindings. Unlike the bindings crate, drivers may directly use this crate
> if they have to interface with userspace.
> 
> Initially, just bind the generic ioctl stuff.
> 
> In the future, we would also like to add additional checks to ensure
> that all types exposed by this crate satisfy UAPI-safety guarantees
> (that is, they are safely castable to/from a "bag of bits").
> 
> Signed-off-by: Asahi Lina <lina@asahilina.net>
> ---
>  rust/.gitignore         |  1 +
>  rust/Makefile           | 18 ++++++++++++++++--
>  rust/kernel/lib.rs      |  1 +
>  rust/uapi/lib.rs        | 27 +++++++++++++++++++++++++++
>  rust/uapi/uapi_helper.h |  9 +++++++++
>  5 files changed, 54 insertions(+), 2 deletions(-)
> 
> diff --git a/rust/.gitignore b/rust/.gitignore
> index 168cb26a31b9..21552992b401 100644
> --- a/rust/.gitignore
> +++ b/rust/.gitignore
> @@ -2,6 +2,7 @@
>  
>  bindings_generated.rs
>  bindings_helpers_generated.rs
> +uapi_generated.rs
>  exports_*_generated.h
>  doc/
>  test/
> diff --git a/rust/Makefile b/rust/Makefile
> index f88d108fbef0..59a327f0fa1a 100644
> --- a/rust/Makefile
> +++ b/rust/Makefile
> @@ -16,6 +16,9 @@ obj-$(CONFIG_RUST) += alloc.o bindings.o kernel.o
>  always-$(CONFIG_RUST) += exports_alloc_generated.h exports_bindings_generated.h \
>      exports_kernel_generated.h
>  
> +always-$(CONFIG_RUST) += uapi/uapi_generated.rs
> +obj-$(CONFIG_RUST) += uapi.o
> +
>  ifdef CONFIG_RUST_BUILD_ASSERT_ALLOW
>  obj-$(CONFIG_RUST) += build_error.o
>  else
> @@ -288,6 +291,12 @@ $(obj)/bindings/bindings_generated.rs: $(src)/bindings/bindings_helper.h \
>      $(src)/bindgen_parameters FORCE
>  	$(call if_changed_dep,bindgen)
>  
> +$(obj)/uapi/uapi_generated.rs: private bindgen_target_flags = \
> +    $(shell grep -v '^\#\|^$$' $(srctree)/$(src)/bindgen_parameters)
> +$(obj)/uapi/uapi_generated.rs: $(src)/uapi/uapi_helper.h \
> +    $(src)/bindgen_parameters FORCE
> +	$(call if_changed_dep,bindgen)
> +
>  # See `CFLAGS_REMOVE_helpers.o` above. In addition, Clang on C does not warn
>  # with `-Wmissing-declarations` (unlike GCC), so it is not strictly needed here
>  # given it is `libclang`; but for consistency, future Clang changes and/or
> @@ -388,10 +397,15 @@ $(obj)/bindings.o: $(src)/bindings/lib.rs \
>      $(obj)/bindings/bindings_helpers_generated.rs FORCE
>  	$(call if_changed_dep,rustc_library)
>  
> +$(obj)/uapi.o: $(src)/uapi/lib.rs \
> +    $(obj)/compiler_builtins.o \
> +    $(obj)/uapi/uapi_generated.rs FORCE
> +	$(call if_changed_dep,rustc_library)
> +
>  $(obj)/kernel.o: private rustc_target_flags = --extern alloc \
> -    --extern build_error --extern macros --extern bindings
> +    --extern build_error --extern macros --extern bindings --extern uapi
>  $(obj)/kernel.o: $(src)/kernel/lib.rs $(obj)/alloc.o $(obj)/build_error.o \
> -    $(obj)/libmacros.so $(obj)/bindings.o FORCE
> +    $(obj)/libmacros.so $(obj)/bindings.o $(obj)/uapi.o FORCE
>  	$(call if_changed_dep,rustc_library)
>  
>  endif # CONFIG_RUST
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index 7610b18ee642..63f796781b7c 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -43,6 +43,7 @@ pub mod types;
>  #[doc(hidden)]
>  pub use bindings;
>  pub use macros;
> +pub use uapi;
>  
>  #[doc(hidden)]
>  pub use build_error::build_error;
> diff --git a/rust/uapi/lib.rs b/rust/uapi/lib.rs
> new file mode 100644
> index 000000000000..29f69f3a52de
> --- /dev/null
> +++ b/rust/uapi/lib.rs
> @@ -0,0 +1,27 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! UAPI Bindings.
> +//!
> +//! Contains the bindings generated by `bindgen` for UAPI interfaces.
> +//!
> +//! This crate may be used directly by drivers that need to interact with
> +//! userspace APIs.
> +
> +#![no_std]
> +#![feature(core_ffi_c)]
> +// See <https://github.com/rust-lang/rust-bindgen/issues/1651>.
> +#![cfg_attr(test, allow(deref_nullptr))]
> +#![cfg_attr(test, allow(unaligned_references))]
> +#![cfg_attr(test, allow(unsafe_op_in_unsafe_fn))]

Looks like that we should bump our bindgen version.

> +#![allow(
> +    clippy::all,
> +    missing_docs,
> +    non_camel_case_types,
> +    non_upper_case_globals,
> +    non_snake_case,
> +    improper_ctypes,
> +    unreachable_pub,
> +    unsafe_op_in_unsafe_fn
> +)]
> +
> +include!(concat!(env!("OBJTREE"), "/rust/uapi/uapi_generated.rs"));
> diff --git a/rust/uapi/uapi_helper.h b/rust/uapi/uapi_helper.h
> new file mode 100644
> index 000000000000..301f5207f023
> --- /dev/null
> +++ b/rust/uapi/uapi_helper.h
> @@ -0,0 +1,9 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Header that contains the headers for which Rust UAPI bindings
> + * will be automatically generated by `bindgen`.
> + *
> + * Sorted alphabetically.
> + */
> +
> +#include <uapi/asm-generic/ioctl.h>
> 

Best,
Gary
