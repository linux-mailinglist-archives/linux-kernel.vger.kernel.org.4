Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B149773079A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 20:49:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234566AbjFNStj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 14:49:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbjFNStg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 14:49:36 -0400
Received: from GBR01-LO2-obe.outbound.protection.outlook.com (mail-lo2gbr01on2105.outbound.protection.outlook.com [40.107.10.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4647ED;
        Wed, 14 Jun 2023 11:49:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PXLAd9CsPMCU4bgebV7MEdSQiySpAnP21wOgBRYaNl6vG6VLzhOFVbjkybUExkn+EVWjMzmNEoF9mlEAooMgW1rtyV95y0f3mupKhOeL8xnvcscSoLnR5oEjSxQdf7X/Lvwap9sZ8qdgA64/H/kX4Xf4WSqoqxFoNa3zocPEqDDgPe3F6I0DaVrn9fZKnY4wPI72OCwB5KPwW6HWBGR0gQ0QM8lD2QTUSb/rNt9Aj9v4TqHHcsNQd5pJhCZY/AtySNkyB1bGI2zvR8GQ5xoUvjoA9rb7rlp+ORIlgOscUbRygfayeZya7g9PFZsWgzMMYTTsF5miMiJ+zM2hWvuRfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+BSxCl+A8R+nPgMWRJJ3v1qwdRWDN4MAdVSFLmReVoQ=;
 b=SQtoQi+ao5vfm9yMIjNw2HWip9b7RKCIbkkffI1l8XR+tgTo/6iOY32e9/zhSQW4p4g1rPsB51/A+3IMNGhlMA5Atc2QVUU8seMvbYeNsJsMvbkbkioFeK3blKkYWzd3TYDNlz/bEyRrpA6BsxOkQwVMokxfJezazgfwGn2cNQQnOx+wx0FVhCY+1MJ8nbGhs0w+C1WF0jyxXH0xIiFbX0ekX6LhoZkgZRzZyJmE+RN67li8obFdm+XnUl/jNHErJJnpCagxvOhvyfzrlRnMB/ieD1jh+/4iczIVJNj3LB6eElXf9HHlm94MzRupEIr6QmOL+189E9iJvUhISU66iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+BSxCl+A8R+nPgMWRJJ3v1qwdRWDN4MAdVSFLmReVoQ=;
 b=kZDIEn/f7q4ntZ7n1/eDipCRziPUXFqHT3tTPyhRNRnPSBeEBjtH5jNSohlEDH2T04rTmWoEpGZoxRakLHoYlERK7nkPFwvrOe0Em/g+/IzM9pal9FYRMinAeYkL9VfAbofsKlHyV1yjCP4nsKryN7s0jhcL83IHozsV2ED/HZw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LO0P265MB6099.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:248::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.25; Wed, 14 Jun
 2023 18:49:32 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f968:901e:1398:7d22]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f968:901e:1398:7d22%4]) with mapi id 15.20.6500.025; Wed, 14 Jun 2023
 18:49:32 +0000
Date:   Wed, 14 Jun 2023 19:49:30 +0100
From:   Gary Guo <gary@garyguo.net>
To:     Aakash Sen Sharma <aakashsensharma@gmail.com>
Cc:     corbet@lwn.net, ojeda@kernel.org, alex.gaynor@gmail.com,
        wedsonaf@gmail.com, boqun.feng@gmail.com, bjorn3_gh@protonmail.com,
        nathan@kernel.org, ndesaulniers@google.com, trix@redhat.com,
        masahiroy@kernel.org, me@kloenk.de, aliceryhl@google.com,
        benno.lossin@proton.me, dev@niklasmohrin.de, lina@asahilina.net,
        hca@linux.ibm.com, rust-for-linux@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH] rust: bindgen: upgrade to 0.65.1
Message-ID: <20230614194930.5da4e418.gary@garyguo.net>
In-Reply-To: <20230612194311.24826-1-aakashsensharma@gmail.com>
References: <20230612194311.24826-1-aakashsensharma@gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P123CA0016.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:a6::28) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LO0P265MB6099:EE_
X-MS-Office365-Filtering-Correlation-Id: 79af2281-f175-4517-2d8c-08db6d08176b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z2nNEL+M8vc8nszbGLdgPmqitB5l5SDE2VO03qX3HqF0bY2NZeQQwXMyJRjgCdb9zcgDcHnaSLXyE3+CuCrkJc+v3xWAinhebZwczkZuY+Tbs02cJ9qGalkdVqY3GaGIVOkCkYvdFYoxpC9/nTk+tvnMETokiCYYM7BS/9F4CCSHL6QogKCBlv2v6k3a/AiYjPpAOew5EMbp5ds0++xiYeiZnk3rFFVaFvKUZpxmRrv3fRphi18CqGmi5nU21plJev9BGSZBD8EcrmBRxGSZM2FyH7qgu9f6zpETK37jvmR6asqBNL9wHwZqq5ApMpZ269IDu8JgrreFQmekc766HdymGxwalRy/dgSl/boN+7nbVxaB+ergMAf/z0Hgxiiy7II84fZmgJ3QYEMgE5m2P1P21snA3vqVZoyTGhYDsEmdMW4x72pmVVW3FFTA8ix42QBO8pkK7Giz9zb3OlDlAqOqgbOBlvFTQNA5GoNouTTSUlGzUKSpr+qPC3DmcmXvLBqVxxmrvQj8Uf4uSoAN5WOfX9g++KxrUDCPKPX1ze0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(366004)(376002)(39830400003)(396003)(451199021)(38100700002)(86362001)(8676002)(5660300002)(7416002)(316002)(8936002)(41300700001)(66556008)(66476007)(66946007)(6916009)(4326008)(83380400001)(2616005)(186003)(478600001)(26005)(1076003)(36756003)(6506007)(6512007)(2906002)(6486002)(966005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aFMmYvG0NIcv7UTNzLNCmdwbK0abf0L47qbeOqAcxLxt2Ej1ZSTUe4RRJfVi?=
 =?us-ascii?Q?BGVNWsyyb4GnmusYLD8HrbRQgmF6NNbi0wBi70Kc5uMY/xv0V6aVw8QV9ANe?=
 =?us-ascii?Q?LDD7Ze33s3IPWVuZM527jhS7y6G/H/lx2rQ1g77pRxEh/p/kg3L1D4OKmqBy?=
 =?us-ascii?Q?BvJJHE0Cvic+t62BkWK1KM0imscA+x+wxJliooRMMdWYTcw5zceSqojM2j1t?=
 =?us-ascii?Q?J8DLgHL08bkBW0LEO6eTYLjmB4oZ/r+9iT9yYqjKR3f9rW80o3df4iaNdFJD?=
 =?us-ascii?Q?Ug4zspdqDd6lYacQ+6lmV6DQjEnD/nYVhbYu9J8XvYVLXl9BIkgvypp2/6nV?=
 =?us-ascii?Q?LP9M5XvPr7mjiVt8hoRPw2/LFZXB+5ICZsqdIaWp09op3vFEbpWgOYklV7u1?=
 =?us-ascii?Q?EN2IO4JWehoLZ9pBHLmQxxjAEtpxjmsm7ViqrO4oA/UbZtVffxsq3raPf01I?=
 =?us-ascii?Q?EkzCGSa4ImOUBhYAje2r0FQQUpDYqyNHjJ2tVg+jiaD+5N0heLMTCX4O/XSN?=
 =?us-ascii?Q?hZDqYGyvVg8SeIR15aTHZ8R8Ih5PH5ncllW9fiuVlLcfedMnLpNtiy79Idb/?=
 =?us-ascii?Q?hKU6GJOb0uMG9fbvuniY86n8kDm/1Zcp7B09BzjSJ5U+AtW8IAecnE7FsWd7?=
 =?us-ascii?Q?r4RzmB0Et/ypc5n5jLppFinO7NIv0LUiGMqdrZWKN8yF0lmgqkj6I3SuuS8/?=
 =?us-ascii?Q?6EDQtZ09FEIJLcLgxN+P7gmD9J1SoQ7np8mhoRHcMBF4bvO14iFlYbEc5nEn?=
 =?us-ascii?Q?+yBMcUljn+8+JIgFTlIpHcIcZ0cd/4YqD9r15LJLfWmKh0Z365AfGxtdDNNG?=
 =?us-ascii?Q?3Lf9s9Iszapw9ZPtYAoa6vwHJBzkeqsZRy64+9SDBIsYGPzdPfeZVbIXPB/1?=
 =?us-ascii?Q?4X2jZpjI9HxBvVwMiRzgaTAit/rzucFjLJmbwi/wCUJUXaRgT1WEoL6Xgt3E?=
 =?us-ascii?Q?rQb3HoAMOTIWY++5mZ60BBxRvvWIMweIVpdxBvevkaebqi3oT8ULCdl2jtAE?=
 =?us-ascii?Q?JejvOqpNdTibDEqe3WBJOegU4rTMZ+Pl2dzhPECrJqlDfT1Iw+iMPRuNET7A?=
 =?us-ascii?Q?68scEt0rln3qUQS1IVlxrZVZ/11Oeomo428FlRMKZLqKhaHYWN9h7ONre1iH?=
 =?us-ascii?Q?cnJDN4bjo1ryuJOZyPI8VkDzZqw/GJMTybma6SFd7onroJwCMuvDcqxoIDiX?=
 =?us-ascii?Q?BHX0ZKt+MsLdA/L1azOzxm22BiAfT7RTvXaVVWXtJnWwmIUQBY8pv2kKFzmW?=
 =?us-ascii?Q?J2o6AbGZ9bTvQAJ39AZbiUAPVjePCOPPIqqptbQUT8lhU74T2s60n3JKUT0U?=
 =?us-ascii?Q?FSvhxgbaaIvW6GveRKy1ZM48+VF5V2fLplBgMwf9KdFUIVzrJNOgjoBb5J3I?=
 =?us-ascii?Q?SU1pIO/PCjgfBh7+iwy3BWLKZrFpKlqntvS4TrGZ/shutnQmf3DG516wSSxl?=
 =?us-ascii?Q?xOlT8bcgitClfZB7h/8QcjcI7AqTbpxfDKv+UThf9TNNhlyjIMFiihDAzNj+?=
 =?us-ascii?Q?hg4tu0jFg/83l3bU+TdHHbxBRVwhbjlN1OV5PzHbfbu+ImhfKpSKOXXmtXTM?=
 =?us-ascii?Q?gYtT0T5GTPjJxF415QO6+UFQ8kaAiNsPhAYya1wL?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 79af2281-f175-4517-2d8c-08db6d08176b
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2023 18:49:32.4577
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ng8HD5y+NUiZzBr0C7tZvehq85bJfHFLyPS97gU6LdShYBeVgztMcqERQWXiSF/JQFiqyopkQB8Ccq76HZBpTQ==
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

On Tue, 13 Jun 2023 01:13:11 +0530
Aakash Sen Sharma <aakashsensharma@gmail.com> wrote:

> * Rationale:
> 
> Upgrades bindgen to code-generation for anonymous unions, structs, and enums [7]
> for LLVM-16 based toolchains.
> 
> The following upgrade also incorporates `noreturn` support from bindgen
> allowing us to remove useless `loop` calls which was placed as a
> workaround.
> 
> * Truncated build logs on using bindgen `v0.56.0` prior to LLVM-16 toolchain:
> 
> ```
> $ make rustdoc LLVM=1 CLIPPY=1 -j$(nproc)
>   RUSTC L rust/core.o
>   BINDGEN rust/bindings/bindings_generated.rs
>   BINDGEN rust/bindings/bindings_helpers_generated.rs
>   BINDGEN rust/uapi/uapi_generated.rs
> thread 'main' panicked at '"ftrace_branch_data_union_(anonymous_at__/_/include/linux/compiler_types_h_146_2)" is not a valid Ident', .../proc-macro2-1.0.24/src/fallback.rs:693:9
> ...
> thread 'main' panicked at '"ftrace_branch_data_union_(anonymous_at__/_/include/linux/compiler_types_h_146_2)" is not a valid Ident', .../proc-macro2-1.0.24/src/fallback.rs:693:9
> ...
> ```
> 
> * LLVM-16 Changes:
> 
> API changes [1] were introduced such that libclang would emit names like
> "(unnamed union at compiler_types.h:146:2)" for unnamed unions, structs, and
> enums whereas it previously returned an empty string.
> 
> * Bindgen Changes:
> 
> Bindgen `v0.56.0` on LLVM-16 based toolchains hence was unable to process the
> anonymous union in `include/linux/compiler_types` `struct ftrace_branch_data`
> and caused subsequent panics as the new `libclang` API emitted name was not
> being handled. The following issue was fixed in Bindgen `v0.62.0` [2].
> 
> Bindgen `v0.58.0` changed the flags `--whitelist-*` and `--blacklist-*`
> to `--allowlist-*` and `--blocklist-*` respectively [3].
> 
> Bindgen `v0.61.0` added support for `_Noreturn`, `[[noreturn]]`, `__attribute__((noreturn))` [4],
> hence the empty `loop`s used to circumvent bindgen returning `!` in place of `()`
> for noreturn attributes have been removed completely.
> 
> Bindgen `v0.61.0` also changed default functionality to bind `size_t` to `usize` [5] and
> added the `--no-size_t-is-usize` [5] flag to not bind `size_t` as `usize`.
> 
> Bindgen `v0.65.0` removed `--size_t-is-usize` flag [6].
> 
> Link: https://github.com/llvm/llvm-project/commit/19e984ef8f49bc3ccced15621989fa9703b2cd5b [1]
> Link: https://github.com/rust-lang/rust-bindgen/pull/2319 [2]
> Link: https://github.com/rust-lang/rust-bindgen/pull/1990 [3]
> Link: https://github.com/rust-lang/rust-bindgen/issues/2094 [4]
> Link: https://github.com/rust-lang/rust-bindgen/commit/cc78b6fdb6e829e5fb8fa1639f2182cb49333569 [5]
> Link: https://github.com/rust-lang/rust-bindgen/pull/2408 [6]
> Closes: https://github.com/Rust-for-Linux/linux/issues/1013 [7]
> Signed-off-by: Aakash Sen Sharma <aakashsensharma@gmail.com>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  Documentation/process/changes.rst |  2 +-
>  rust/Makefile                     |  6 +++---
>  rust/helpers.c                    | 13 ++++++-------
>  rust/kernel/lib.rs                |  3 ---
>  scripts/min-tool-version.sh       |  2 +-
>  5 files changed, 11 insertions(+), 15 deletions(-)
> 
> diff --git a/Documentation/process/changes.rst b/Documentation/process/changes.rst
> index ef540865ad22..5f21c4c6cf5c 100644
> --- a/Documentation/process/changes.rst
> +++ b/Documentation/process/changes.rst
> @@ -32,7 +32,7 @@ you probably needn't concern yourself with pcmciautils.
>  GNU C                  5.1              gcc --version
>  Clang/LLVM (optional)  11.0.0           clang --version
>  Rust (optional)        1.62.0           rustc --version
> -bindgen (optional)     0.56.0           bindgen --version
> +bindgen (optional)     0.65.1           bindgen --version
>  GNU make               3.82             make --version
>  bash                   4.2              bash --version
>  binutils               2.25             ld -v
> diff --git a/rust/Makefile b/rust/Makefile
> index f88d108fbef0..c187c6f3a384 100644
> --- a/rust/Makefile
> +++ b/rust/Makefile
> @@ -279,7 +279,7 @@ quiet_cmd_bindgen = BINDGEN $@
>  	$(BINDGEN) $< $(bindgen_target_flags) \
>  		--use-core --with-derive-default --ctypes-prefix core::ffi --no-layout-tests \
>  		--no-debug '.*' \
> -		--size_t-is-usize -o $@ -- $(bindgen_c_flags_final) -DMODULE \
> +		-o $@ -- $(bindgen_c_flags_final) -DMODULE \
>  		$(bindgen_target_cflags) $(bindgen_target_extra)
> 
>  $(obj)/bindings/bindings_generated.rs: private bindgen_target_flags = \
> @@ -293,8 +293,8 @@ $(obj)/bindings/bindings_generated.rs: $(src)/bindings/bindings_helper.h \
>  # given it is `libclang`; but for consistency, future Clang changes and/or
>  # a potential future GCC backend for `bindgen`, we disable it too.
>  $(obj)/bindings/bindings_helpers_generated.rs: private bindgen_target_flags = \
> -    --blacklist-type '.*' --whitelist-var '' \
> -    --whitelist-function 'rust_helper_.*'
> +    --blocklist-type '.*' --allowlist-var '' \
> +    --allowlist-function 'rust_helper_.*'
>  $(obj)/bindings/bindings_helpers_generated.rs: private bindgen_target_cflags = \
>      -I$(objtree)/$(obj) -Wno-missing-prototypes -Wno-missing-declarations
>  $(obj)/bindings/bindings_helpers_generated.rs: private bindgen_target_extra = ; \
> diff --git a/rust/helpers.c b/rust/helpers.c
> index 121583282976..98d9ef47225b 100644
> --- a/rust/helpers.c
> +++ b/rust/helpers.c
> @@ -122,19 +122,18 @@ void rust_helper_put_task_struct(struct task_struct *t)
>  EXPORT_SYMBOL_GPL(rust_helper_put_task_struct);
> 
>  /*
> - * We use `bindgen`'s `--size_t-is-usize` option to bind the C `size_t` type
> - * as the Rust `usize` type, so we can use it in contexts where Rust
> - * expects a `usize` like slice (array) indices. `usize` is defined to be
> - * the same as C's `uintptr_t` type (can hold any pointer) but not
> - * necessarily the same as `size_t` (can hold the size of any single
> + * `bindgen` binds the C `size_t` type the Rust `usize` type, so we can
> + * use it in contexts where Rust expects a `usize` like slice (array) indices.
> + * `usize` is defined to be the same as C's `uintptr_t` type (can hold any pointer)
> + * but not necessarily the same as `size_t` (can hold the size of any single
>   * object). Most modern platforms use the same concrete integer type for
>   * both of them, but in case we find ourselves on a platform where
>   * that's not true, fail early instead of risking ABI or
>   * integer-overflow issues.
>   *
>   * If your platform fails this assertion, it means that you are in
> - * danger of integer-overflow bugs (even if you attempt to remove
> - * `--size_t-is-usize`). It may be easiest to change the kernel ABI on
> + * danger of integer-overflow bugs (even if you attempt to add
> + * `--no-size_t-is-usize`). It may be easiest to change the kernel ABI on
>   * your platform such that `size_t` matches `uintptr_t` (i.e., to increase
>   * `size_t`, because `uintptr_t` has to be at least as big as `size_t`).
>   */
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index ee27e10da479..1b0dcf03b9c2 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -95,7 +95,4 @@ fn panic(info: &core::panic::PanicInfo<'_>) -> ! {
>      pr_emerg!("{}\n", info);
>      // SAFETY: FFI call.
>      unsafe { bindings::BUG() };
> -    // Bindgen currently does not recognize `__noreturn` so `BUG` returns `()`
> -    // instead of `!`. See <https://github.com/rust-lang/rust-bindgen/issues/2094>.
> -    loop {}
>  }
> diff --git a/scripts/min-tool-version.sh b/scripts/min-tool-version.sh
> index 20d483ec6f5f..5b80c5d3a9f8 100755
> --- a/scripts/min-tool-version.sh
> +++ b/scripts/min-tool-version.sh
> @@ -30,7 +30,7 @@ rustc)
>  	echo 1.62.0
>  	;;
>  bindgen)
> -	echo 0.56.0
> +	echo 0.65.1
>  	;;
>  *)
>  	echo "$1: unknown tool" >&2
> --
> 2.40.1
> 

